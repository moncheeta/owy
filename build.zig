const std = @import("std");

pub fn build(builder: *std.build.Builder) void {
    const mode = builder.standardReleaseOptions();
    const target = std.zig.CrossTarget{ .cpu_arch = std.Target.Cpu.Arch.i386, .os_tag = std.Target.Os.Tag.freestanding, .abi = std.Target.Abi.none };

    // build
    const kernel = builder.addExecutable("burrow", "src/main.zig");
    kernel.setBuildMode(mode);
    kernel.setTarget(target);
    kernel.setLinkerScriptPath(.{ .path = "src/linker.ld" });
    kernel.addAssemblyFile("./src/arch/x86/boot.S");
    kernel.code_model = .kernel;
    kernel.install();
    const kernel_step = builder.step("kernel", "Build the kernel");
    kernel_step.dependOn(&kernel.install_step.?.step);

    // run
    const kernel_path = builder.getInstallPath(kernel.install_step.?.dest_dir, kernel.out_filename);
    const run_cmd_str = &[_][]const u8{ "./qemu.sh", kernel_path };
    const run_cmd = builder.addSystemCommand(run_cmd_str);
    run_cmd.step.dependOn(builder.getInstallStep());
    const run_step = builder.step("run", "Run the kernel");
    run_step.dependOn(&run_cmd.step);
}
