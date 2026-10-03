Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F0F3E4C66;
	Sat,  3 Oct 2026 10:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024584; cv=none; b=al5pHYfauJb9KIfMDvJCfOGxg9tWdT9/e0PmFw3nQ5IqHfOp+jg7/yeaAcviYXks7+xeOmrxF6vlMNbGhwdNkIzfNyWK3wEhuSEQ2BxliD9IGWSVd7CCvwPFDyc+Y1uu3Tj5C1fm2WchH/pYOF4490hqXgegZEGdt/3LMS+/5fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024584; c=relaxed/simple;
	bh=Qw3720iIaOsWhoyJoD9+QGXzKcpVjn/OcnuLgDtz0R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RT2aolNPy6cthegpyLk4hA+gqi25qhCktrFj4eNgu6SnmPEXqB7caOVr8EcLlQI5JsnGqjWINO5QK4jsqQ97xBlowFXl235BWPApzDQOMW2K2wtSmapwdWUemzmWTpQZkp9I22Je3AT2rbv4L5C8gzHIkxgBTplv+HK95QXNjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c22p2Vz5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c22p2Vz5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 409FA1F0089B;
	Sat,  3 Oct 2026 10:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791024551;
	bh=FFB9ZIWHLlhSB1rTgFdmSFsmC/ZYjEl2MtCf9ZTVIg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c22p2Vz55RByEa/waZC4h5yXt7slXI/xoa42La/h4apx2fHeFYS2SFD8uSSMLT2Oa
	 IE4kAMeXwhnTO8KOX3rViM6Y7eqiZlDXpDzXLxDZBMfXrTUBk6L1EOX+DYOyWIY89b
	 FDgvkuHhWQnX2cGyKPSK4aqehGWnYLlms7JcHIFs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.271
Date: Sat,  3 Oct 2026 12:49:01 +0200
Message-ID: <2026100301-evolve-outsmart-5858@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026100301-daybed-eldercare-3d6d@gregkh>
References: <2026100301-daybed-eldercare-3d6d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
index df11901a6b3d..7954434b0434 100644
--- a/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
+++ b/Documentation/ABI/testing/sysfs-devices-platform-trackpoint
@@ -5,7 +5,7 @@ Contact:	linux-input@vger.kernel.org
 Description:
 		(RW) Trackpoint sensitivity.
 
-What:		/sys/devices/platform/i8042/.../intertia
+What:		/sys/devices/platform/i8042/.../inertia
 Date:		Aug, 2005
 KernelVersion:	2.6.14
 Contact:	linux-input@vger.kernel.org
diff --git a/Documentation/driver-api/serial/tty.rst b/Documentation/driver-api/serial/tty.rst
index dd972caacf3e..4b709f392713 100644
--- a/Documentation/driver-api/serial/tty.rst
+++ b/Documentation/driver-api/serial/tty.rst
@@ -58,7 +58,7 @@ close()			This is called on a terminal when the line
 hangup()		Called when the tty line is hung up.
 			The line discipline should cease I/O to the tty.
 			No further calls into the ldisc code will occur.
-			The return value is ignored. Can sleep.
+			Can sleep.
 
 read()			(optional) A process requests reading data from
 			the line. Multiple read calls may occur in parallel
diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index e912a47765f3..fbe902b72fb9 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -642,6 +642,8 @@ tcp_rmem - vector of 3 INTEGERs: min, default, max
 	case this value is ignored.
 	Default: between 131072 and 6MB, depending on RAM size.
 
+	Each of the three values cannot be set below 4096.
+
 tcp_sack - BOOLEAN
 	Enable select acknowledgments (SACKS).
 
diff --git a/Documentation/s390/pci.rst b/Documentation/s390/pci.rst
index 492850bff316..c487e41d6ba2 100644
--- a/Documentation/s390/pci.rst
+++ b/Documentation/s390/pci.rst
@@ -6,6 +6,7 @@ S/390 PCI
 
 Authors:
         - Pierre Morel
+        - Niklas Schnelle
 
 Copyright, IBM Corp. 2020
 
@@ -27,14 +28,16 @@ Command line parameters
 debugfs entries
 ---------------
 
-The S/390 debug feature (s390dbf) generates views to hold various debug results in sysfs directories of the form:
+The S/390 debug feature (s390dbf) generates views to hold various debug results
+in sysfs directories of the form:
 
  * /sys/kernel/debug/s390dbf/pci_*/
 
 For example:
 
   - /sys/kernel/debug/s390dbf/pci_msg/sprintf
-    Holds messages from the processing of PCI events, like machine check handling
+
+    holds messages from the processing of PCI events, like machine check handling
     and setting of global functionality, like UID checking.
 
   Change the level of logging to be more or less verbose by piping
@@ -47,79 +50,134 @@ Sysfs entries
 
 Entries specific to zPCI functions and entries that hold zPCI information.
 
-* /sys/bus/pci/slots/XXXXXXXX
+* /sys/bus/pci/slots/XXXXXXXX:
 
-  The slot entries are set up using the function identifier (FID) of the
-  PCI function.
+  The slot entries are set up using the function identifier (FID) of the PCI
+  function as slot name. The format depicted as XXXXXXXX above is 8 hexadecimal
+  digits with 0 padding and lower case hexadecimal digits.
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
-  echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf
+  echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvfs
 
-* /sys/bus/pci/devices/XXXX:XX:XX.X/
+* /sys/bus/pci/devices/DDDD:BB:dd.f/:
 
-  - function_id
-    A zPCI function identifier that uniquely identifies the function in the Z server.
+  - function_id:
+    The zPCI function identifier (FID) is a 32-bit hexadecimal value that
+    uniquely identifies the PCI function. Unless the hypervisor provides
+    a virtual FID e.g. on KVM this identifier is unique across the machine even
+    between different partitions.
 
-  - function_handle
-    Low-level identifier used for a configured PCI function.
-    It might be useful for debuging.
+  - function_handle:
+    This 32-bit hexadecimal value is a low-level identifier used for a PCI
+    function. Note that the function handle may be changed and become invalid
+    on PCI events and when enabling/disabling the PCI function.
 
-  - pchid
-    Model-dependent location of the I/O adapter.
+  - pchid:
+    This 16-bit hexadecimal value encodes a model-dependent location for
+    the PCI function.
 
-  - pfgid
-    PCI function group ID, functions that share identical functionality
+  - pfgid:
+    PCI function group ID; functions that share identical functionality
     use a common identifier.
     A PCI group defines interrupts, IOMMU, IOTLB, and DMA specifics.
 
-  - vfn
+  - vfn:
     The virtual function number, from 1 to N for virtual functions,
     0 for physical functions.
 
-  - pft
-    The PCI function type
-
-  - port
-    The port corresponds to the physical port the function is attached to.
-    It also gives an indication of the physical function a virtual function
-    is attached to.
-
-  - uid
-    The unique identifier (UID) is defined when configuring an LPAR and is
-    unique in the LPAR.
-
-  - pfip/segmentX
+  - pft:
+    The PCI function type is an s390-specific type attribute. It indicates
+    a more general, usage oriented, type than PCI Specification
+    class/vendor/device identifiers. That is PCI functions with the same pft
+    value may be backed by different hardware implementations. At the same time
+    apart from unclassified functions (pft is 0x00) the same pft value
+    generally implies a similar usage model. At the same time the same
+    PCI hardware device may appear with different pft values when in a
+    different usage model. For example NETD and NETH VFs may be implemented
+    by the same PCI hardware device but in NETD the parent Physical Function
+    is user managed while with NETH it is platform managed.
+
+    Currently the following PFT values are defined:
+
+    - 0x00 (UNC): Unclassified
+    - 0x02 (ROCE): RoCE Express
+    - 0x05 (ISM): Internal Shared Memory
+    - 0x0a (ROC2): RoCE Express 2
+    - 0x0b (NVMe): NVMe
+    - 0x0c (NETH): Network Express hybrid
+    - 0x0d (CNW): Cloud Network Adapter
+    - 0x0f (NETD): Network Express direct
+
+  - port:
+    The port is a decimal value corresponding to the physical port the function
+    is attached to. Virtual Functions (VFs) share the port with their parent
+    Physical Function (PF). A value of 0 indicates that the port attribute is
+    not applicable for that PCI function type.
+
+  - uid:
+    The user-defined identifier (UID) for a PCI function is a 32-bit
+    hexadecimal value. It is defined on a per instance basis as part of the
+    partition, KVM guest, or z/VM guest configuration. If UID Checking is
+    enabled the platform ensures that the UID is unique within that instance
+    and no two PCI functions with the same UID will be visible to the instance.
+
+    Independent of this guarantee and unlike the function ID (FID) the UID may
+    be the same in different partitions within the same machine. This allows to
+    create PCI configurations in multiple partitions to be identical in the
+    UID-namespace.
+
+  - uid_is_unique:
+    A 0 or 1 flag indicating whether the user-defined identifier (UID) is
+    guaranteed to be and remain unique within this Linux instance. This
+    platform feature is called UID Checking.
+
+  - pfip/segmentX:
     The segments determine the isolation of a function.
     They correspond to the physical path to the function.
     The more the segments are different, the more the functions are isolated.
 
+  - fidparm:
+    Contains an 8-bit-per-PCI function parameter field in hexadecimal provided
+    by the platform. The meaning of this field is PCI function type specific.
+    For NETH VFs a value of 0x01 indicates that the function supports
+    promiscuous mode.
+
+* /sys/firmware/clp/uid_checking:
+
+  In addition to the per-device uid_is_unique attribute this presents a
+  global indication of whether UID Checking is enabled. This allows users
+  to check for UID Checking even when no PCI functions are configured.
+
 Enumeration and hotplug
 =======================
 
 The PCI address consists of four parts: domain, bus, device and function,
-and is of this form: DDDD:BB:dd.f
+and is of this form: DDDD:BB:dd.f.
 
-* When not using multi-functions (norid is set, or the firmware does not
-  support multi-functions):
+* For a PCI function for which the platform does not expose the RID, the
+  pci=norid kernel parameter is used, or a so-called isolated Virtual Function
+  which does have RID information but is used without its parent Physical
+  Function being part of the same PCI configuration:
 
   - There is only one function per domain.
 
-  - The domain is set from the zPCI function's UID as defined during the
-    LPAR creation.
+  - The domain is set from the zPCI function's UID if UID Checking is on;
+    otherwise the domain ID is generated dynamically and is not stable
+    across reboots or hot plug.
 
-* When using multi-functions (norid parameter is not set),
-  zPCI functions are addressed differently:
+* For a PCI function for which the platform exposes the RID and which
+  is not an Isolated Virtual Function:
 
   - There is still only one bus per domain.
 
-  - There can be up to 256 functions per bus.
+  - There can be up to 256 PCI functions per bus.
 
-  - The domain part of the address of all functions for
-    a multi-Function device is set from the zPCI function's UID as defined
-    in the LPAR creation for the function zero.
+  - The domain part of the address of all functions within the same topology is
+    that of the configured PCI function with the lowest devfn within that
+    topology.
 
-  - New functions will only be ready for use after the function zero
-    (the function with devfn 0) has been enumerated.
+  - Virtual Functions generated by an SR-IOV capable Physical Function only
+    become visible once SR-IOV is enabled.
diff --git a/Documentation/s390/vfio-ccw.rst b/Documentation/s390/vfio-ccw.rst
index 8aad08a8b8a5..9bcd597e3de6 100644
--- a/Documentation/s390/vfio-ccw.rst
+++ b/Documentation/s390/vfio-ccw.rst
@@ -176,7 +176,7 @@ The process of how these work together.
    Use the 'mdev_create' sysfs file, we need to manually create one (and
    only one for our case) mediated device.
 3. vfio_mdev.ko drives the mediated ccw device.
-   vfio_mdev is also the vfio device drvier. It will probe the mdev and
+   vfio_mdev is also the vfio device driver. It will probe the mdev and
    add it to an iommu_group and a vfio_group. Then we could pass through
    the mdev to a guest.
 
diff --git a/Makefile b/Makefile
index ec9b4e32fdb9..be27886239d5 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 270
+SUBLEVEL = 271
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index b62ae4dafa2e..02e4b27992c4 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -17,7 +17,7 @@ menuconfig ARCH_SOCFPGA
 	select ARM_ERRATA_775420
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
-	select PL310_ERRATA_753970 if PL310
+	select PL310_ERRATA_753970
 	select PL310_ERRATA_769419
 	select RESET_CONTROLLER
 
diff --git a/arch/arm/mm/alignment.c b/arch/arm/mm/alignment.c
index bcefe3f51744..758504a28c13 100644
--- a/arch/arm/mm/alignment.c
+++ b/arch/arm/mm/alignment.c
@@ -23,6 +23,7 @@
 #include <asm/cp15.h>
 #include <asm/system_info.h>
 #include <asm/unaligned.h>
+#include <asm/system_misc.h>
 #include <asm/opcodes.h>
 
 #include "fault.h"
@@ -809,6 +810,9 @@ do_alignment(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	int thumb2_32b = 0;
 	int fault;
 
+	if (addr >= TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	if (interrupts_enabled(regs))
 		local_irq_enable();
 
diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index c16d6a293b97..7ac46e1b85a6 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -137,7 +137,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 
 /*
  * Something tried to access memory that isn't in our memory map..
- * User mode accesses just cause a SIGSEGV
+ * User mode accesses just cause a SIGSEGV. Ensure interrupts are enabled
+ * for preempt RT.
  */
 static void
 __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
@@ -145,8 +146,7 @@ __do_user_fault(unsigned long addr, unsigned int fsr, unsigned int sig,
 {
 	struct task_struct *tsk = current;
 
-	if (addr > TASK_SIZE)
-		harden_branch_predictor();
+	local_irq_enable();
 
 #ifdef CONFIG_DEBUG_USER
 	if (((user_debug & UDBG_SEGV) && (sig == SIGSEGV)) ||
@@ -247,6 +247,38 @@ __do_page_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	return fault;
 }
 
+static int __kprobes
+do_kernel_address_page_fault(struct mm_struct *mm, unsigned long addr,
+			     unsigned int fsr, struct pt_regs *regs)
+{
+	if (user_mode(regs)) {
+		/*
+		 * Fault from user mode for a kernel space address. User mode
+		 * should not be faulting in kernel space, which includes the
+		 * vector/khelper page. Handle the branch predictor hardening
+		 * while interrupts are still disabled, then send a SIGSEGV.
+		 * Note that __do_user_fault() will enable interrupts.
+		 */
+		harden_branch_predictor();
+		__do_user_fault(addr, fsr, SIGSEGV, SEGV_MAPERR, regs);
+	} else {
+		/*
+		 * Fault from kernel mode. Enable interrupts if they were
+		 * enabled in the parent context. Section (upper page table)
+		 * translation faults are handled via do_translation_fault(),
+		 * so we will only get here for a non-present kernel space
+		 * PTE or PTE permission fault. This may happen in exceptional
+		 * circumstances and need the fixup tables to be walked.
+		 */
+		if (interrupts_enabled(regs))
+			local_irq_enable();
+
+		__do_kernel_fault(mm, addr, fsr, regs);
+	}
+
+	return 0;
+}
+
 static int __kprobes
 do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
@@ -261,6 +293,12 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 
 	tsk = current;
 	mm  = tsk->mm;
+	/*
+	 * Handle kernel addresses faults separately, which avoids touching
+	 * the mmap lock from contexts that are not able to sleep.
+	 */
+	if (addr >= TASK_SIZE)
+		return do_kernel_address_page_fault(mm, addr, fsr, regs);
 
 	/* Enable interrupts if they were enabled in the parent context. */
 	if (interrupts_enabled(regs))
@@ -386,16 +424,20 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
  * We enter here because the first level page table doesn't contain
  * a valid entry for the address.
  *
- * If the address is in kernel space (>= TASK_SIZE), then we are
- * probably faulting in the vmalloc() area.
+ * If this is a user address (addr < TASK_SIZE), we handle this as a
+ * normal page fault. This leaves the remainder of the function to handle
+ * kernel address translation faults.
+ *
+ * Since user mode is not permitted to access kernel addresses, pass these
+ * directly to do_kernel_address_page_fault() to handle.
  *
- * If the init_task's first level page tables contains the relevant
- * entry, we copy the it to this task.  If not, we send the process
- * a signal, fixup the exception, or oops the kernel.
+ * Otherwise, we're probably faulting in the vmalloc() area, so try to fix
+ * that up. Note that we must not take any locks or enable interrupts in
+ * this case.
  *
- * NOTE! We MUST NOT take any locks for this case. We may be in an
- * interrupt or a critical region, and should only copy the information
- * from the master page table, nothing more.
+ * If vmalloc() fixup fails, that means the non-leaf page tables did not
+ * contain an entry for this address, so handle this via
+ * do_kernel_address_page_fault().
  */
 #ifdef CONFIG_MMU
 static int __kprobes
@@ -461,7 +503,8 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 	return 0;
 
 bad_area:
-	do_bad_area(addr, fsr, regs);
+	do_kernel_address_page_fault(current->mm, addr, fsr, regs);
+
 	return 0;
 }
 #else					/* CONFIG_MMU */
@@ -481,7 +524,16 @@ do_translation_fault(unsigned long addr, unsigned int fsr,
 static int
 do_sect_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 {
+	/*
+	 * If this is a kernel address, but from user mode, then userspace
+	 * is trying bad stuff. Invoke the branch predictor handling.
+	 * Interrupts are disabled here.
+	 */
+	if (addr >= TASK_SIZE && user_mode(regs))
+		harden_branch_predictor();
+
 	do_bad_area(addr, fsr, regs);
+
 	return 0;
 }
 #endif /* CONFIG_ARM_LPAE */
@@ -533,6 +585,9 @@ do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	if (!inf->fn(addr, fsr & ~FSR_LNX_PF, regs))
 		return;
 
+	if (likely(user_mode(regs)))
+		local_irq_enable();
+
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled fault: %s (0x%03x) at 0x%08lx\n",
 		inf->name, fsr, addr);
@@ -571,6 +626,9 @@ do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
 	if (!inf->fn(addr, ifsr | FSR_LNX_PF, regs))
 		return;
 
+	if (likely(user_mode(regs)))
+		local_irq_enable();
+
 	pr_alert("8<--- cut here ---\n");
 	pr_alert("Unhandled prefetch abort: %s (0x%03x) at 0x%08lx\n",
 		inf->name, ifsr, addr);
diff --git a/arch/arm64/include/asm/daifflags.h b/arch/arm64/include/asm/daifflags.h
index cfdde3a56805..fc74d5c7275b 100644
--- a/arch/arm64/include/asm/daifflags.h
+++ b/arch/arm64/include/asm/daifflags.h
@@ -19,7 +19,7 @@
 
 
 /* mask/save/unmask/restore all exceptions, including interrupts. */
-static inline void local_daif_mask(void)
+static __always_inline void local_daif_mask(void)
 {
 	WARN_ON(system_has_prio_mask_debugging() &&
 		(read_sysreg_s(SYS_ICC_PMR_EL1) == (GIC_PRIO_IRQOFF |
@@ -38,7 +38,7 @@ static inline void local_daif_mask(void)
 	trace_hardirqs_off();
 }
 
-static inline unsigned long local_daif_save_flags(void)
+static __always_inline unsigned long local_daif_save_flags(void)
 {
 	unsigned long flags;
 
@@ -53,7 +53,7 @@ static inline unsigned long local_daif_save_flags(void)
 	return flags;
 }
 
-static inline unsigned long local_daif_save(void)
+static __always_inline unsigned long local_daif_save(void)
 {
 	unsigned long flags;
 
@@ -64,7 +64,7 @@ static inline unsigned long local_daif_save(void)
 	return flags;
 }
 
-static inline void local_daif_restore(unsigned long flags)
+static __always_inline void local_daif_restore(unsigned long flags)
 {
 	bool irq_disabled = flags & PSR_I_BIT;
 
@@ -124,7 +124,7 @@ static inline void local_daif_restore(unsigned long flags)
  * Called by synchronous exception handlers to restore the DAIF bits that were
  * modified by taking an exception.
  */
-static inline void local_daif_inherit(struct pt_regs *regs)
+static __always_inline void local_daif_inherit(struct pt_regs *regs)
 {
 	unsigned long flags = regs->pstate & DAIF_MASK;
 
diff --git a/arch/arm64/include/asm/fixmap.h b/arch/arm64/include/asm/fixmap.h
index daff882883f9..9dcf004a4166 100644
--- a/arch/arm64/include/asm/fixmap.h
+++ b/arch/arm64/include/asm/fixmap.h
@@ -73,8 +73,12 @@ enum fixed_addresses {
 	/*
 	 * Temporary boot-time mappings, used by early_ioremap(),
 	 * before ioremap() is functional.
+	 *
+	 * Reserve one extra page so a 256K mapping may start at any
+	 * offset within a page. early_ioremap() maps the page-aligned
+	 * physical range, so the initial offset can consume an extra page.
 	 */
-#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
+#define NR_FIX_BTMAPS		((SZ_256K / PAGE_SIZE) + 1)
 #define FIX_BTMAPS_SLOTS	7
 #define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
 
diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
index 8699ce30f587..0a15d2329627 100644
--- a/arch/arm64/include/asm/kprobes.h
+++ b/arch/arm64/include/asm/kprobes.h
@@ -26,6 +26,12 @@
 struct prev_kprobe {
 	struct kprobe *kp;
 	unsigned int status;
+
+	/*
+	 * The original DAIF state of the outer kprobe, saved here before
+	 * a nested kprobe overwrites kcb->saved_irqflag during reentry.
+	 */
+	unsigned long saved_irqflag;
 };
 
 /* Single step context for kprobe */
diff --git a/arch/arm64/include/asm/percpu.h b/arch/arm64/include/asm/percpu.h
index 1599e17379d8..350680bf8e56 100644
--- a/arch/arm64/include/asm/percpu.h
+++ b/arch/arm64/include/asm/percpu.h
@@ -177,13 +177,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_protect_return(__percpu_read_64, pcp)
 
 #define this_cpu_write_1(pcp, val)	\
-	_pcp_protect(__percpu_write_8, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_8, pcp, (unsigned long)(val))
 #define this_cpu_write_2(pcp, val)	\
-	_pcp_protect(__percpu_write_16, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_16, pcp, (unsigned long)(val))
 #define this_cpu_write_4(pcp, val)	\
-	_pcp_protect(__percpu_write_32, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_32, pcp, (unsigned long)(val))
 #define this_cpu_write_8(pcp, val)	\
-	_pcp_protect(__percpu_write_64, pcp, (unsigned long)val)
+	_pcp_protect(__percpu_write_64, pcp, (unsigned long)(val))
 
 #define this_cpu_add_1(pcp, val)	\
 	_pcp_protect(__percpu_add_case_8, pcp, val)
@@ -204,13 +204,13 @@ PERCPU_RET_OP(add, add, ldadd)
 	_pcp_protect_return(__percpu_add_return_case_64, pcp, val)
 
 #define this_cpu_and_1(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_8, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_8, pcp, ~(u8)(val))
 #define this_cpu_and_2(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_16, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_16, pcp, ~(u16)(val))
 #define this_cpu_and_4(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_32, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_32, pcp, ~(u32)(val))
 #define this_cpu_and_8(pcp, val)	\
-	_pcp_protect(__percpu_andnot_case_64, pcp, ~val)
+	_pcp_protect(__percpu_andnot_case_64, pcp, ~(u64)(val))
 
 #define this_cpu_or_1(pcp, val)		\
 	_pcp_protect(__percpu_or_case_8, pcp, val)
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index 798c3e78b84b..412afe22257d 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -145,12 +145,27 @@ static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	kcb->prev_kprobe.kp = kprobe_running();
 	kcb->prev_kprobe.status = kcb->kprobe_status;
+
+	/*
+	 * Save the outer kprobe's original DAIF flags before the nested
+	 * kprobe calls kprobes_save_local_irqflag() and overwrites
+	 * kcb->saved_irqflag. Without this, the outer kprobe will restore
+	 * the wrong DAIF state and leave interrupts permanently masked.
+	 */
+	kcb->prev_kprobe.saved_irqflag = kcb->saved_irqflag;
 }
 
 static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *kcb)
 {
 	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
 	kcb->kprobe_status = kcb->prev_kprobe.status;
+
+	/*
+	 * Restore the outer kprobe's saved_irqflag so that when its
+	 * single-step completes, kprobes_restore_local_irqflag() uses
+	 * the correct original DAIF value.
+	 */
+	kcb->saved_irqflag = kcb->prev_kprobe.saved_irqflag;
 }
 
 static void __kprobes set_current_kprobe(struct kprobe *p)
@@ -225,10 +240,16 @@ static int __kprobes reenter_kprobe(struct kprobe *p,
 	switch (kcb->kprobe_status) {
 	case KPROBE_HIT_SSDONE:
 	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SS:
+		/*
+		 * A probe can be hit while another kprobe is preparing or
+		 * executing its XOL single-step instruction. This is still a
+		 * recoverable one-level reentry, so handle it in the same way as
+		 * reentry from KPROBE_HIT_ACTIVE or KPROBE_HIT_SSDONE.
+		 */
 		kprobes_inc_nmissed_count(p);
 		setup_singlestep(p, regs, kcb, 1);
 		break;
-	case KPROBE_HIT_SS:
 	case KPROBE_REENTER:
 		pr_warn("Unrecoverable kprobe detected.\n");
 		dump_kprobe(p);
diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
index ce05c0dd3acd..5faea0673714 100644
--- a/arch/mips/cavium-octeon/octeon-platform.c
+++ b/arch/mips/cavium-octeon/octeon-platform.c
@@ -15,7 +15,7 @@
 #include <asm/octeon/octeon.h>
 #include <asm/octeon/cvmx-helper-board.h>
 
-#ifdef CONFIG_USB
+#if IS_ENABLED(CONFIG_USB)
 #include <linux/usb/ehci_def.h>
 #include <linux/usb/ehci_pdriver.h>
 #include <linux/usb/ohci_pdriver.h>
@@ -1079,7 +1079,7 @@ int __init octeon_prune_device_tree(void)
 		;
 	}
 
-#ifdef CONFIG_USB
+#if IS_ENABLED(CONFIG_USB)
 	/* OHCI/UHCI USB */
 	alias_prop = fdt_getprop(initial_boot_params, aliases,
 				 "uctl", NULL);
diff --git a/arch/mips/kernel/cps-vec.S b/arch/mips/kernel/cps-vec.S
index 4db7ff055c9f..1673c66e50c2 100644
--- a/arch/mips/kernel/cps-vec.S
+++ b/arch/mips/kernel/cps-vec.S
@@ -395,8 +395,11 @@ LEAF(mips_cps_boot_vpes)
 	.set	pop
 
 	PTR_LA	t1, 1f
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 	jr.hb	t1
 	 nop
+	.set	pop
 1:	mfc0	t1, CP0_MVPCONTROL
 	ori	t1, t1, MVPCONTROL_VPC
 	mtc0	t1, CP0_MVPCONTROL
@@ -509,8 +512,11 @@ LEAF(mips_cps_boot_vpes)
 	li	t0, TCHALT_H
 	mtc0	t0, CP0_TCHALT
 	PTR_LA	t0, 1f
+	.set	push
+	.set	MIPS_ISA_LEVEL_RAW
 1:	jr.hb	t0
 	 nop
+	.set	pop
 
 2:
 
diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_driver.c
index 20106e490b9c..d556227f2090 100644
--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -534,9 +534,7 @@ static void eeh_rmv_device(struct eeh_dev *edev, void *userdata)
 		if (rmv_data)
 			list_add(&edev->rmv_entry, &rmv_data->removed_vf_list);
 	} else {
-		pci_lock_rescan_remove();
 		pci_stop_and_remove_bus_device(dev);
-		pci_unlock_rescan_remove();
 	}
 }
 
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 370635107f1c..e2b46dea8d90 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -999,7 +999,7 @@ int iommu_tce_check_ioba(unsigned long page_shift,
 	if (ioba < offset)
 		return -EINVAL;
 
-	if ((ioba + 1) > (offset + size))
+	if ((ioba + npages < ioba) || (ioba - offset + npages > size))
 		return -EINVAL;
 
 	return 0;
diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index 9b4fdb47b9ba..61d8d143331d 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -478,7 +478,7 @@ static int add_usable_mem(struct umem_info *um_info, u64 base, u64 end)
 		loc_end = um_info->ranges[i].end;
 		if (loc_base >= base && loc_end <= end)
 			add = true;
-		else if (base < loc_end && end > loc_base) {
+		else if (base <= loc_end && end >= loc_base) {
 			if (loc_base < base)
 				loc_base = base;
 			if (loc_end > end)
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 1d2593238995..1e6c33eb9c7a 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -5286,12 +5286,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
 	struct kvm_kernel_irqfd *irqfd =
 		container_of(cons, struct kvm_kernel_irqfd, consumer);
 
-	irqfd->producer = prod;
-
 	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
 	if (ret)
 		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
 			prod->irq, irqfd->gsi, ret);
+	else
+		irqfd->producer = prod;
 
 	return ret;
 }
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 5f6b3f80023d..296d910a7075 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -770,8 +770,11 @@ static int kvmppc_svm_page_in(struct vm_area_struct *vma,
 		if (spage) {
 			ret = uv_page_in(kvm->arch.lpid, pfn << page_shift,
 					gpa, 0, page_shift);
-			if (ret)
+			if (ret) {
+				unlock_page(dpage);
+				put_page(dpage);
 				goto out_finalize;
+			}
 		}
 	}
 
diff --git a/arch/powerpc/platforms/pseries/kexec.c b/arch/powerpc/platforms/pseries/kexec.c
index 145fcfbc017f..d8bded55e9e5 100644
--- a/arch/powerpc/platforms/pseries/kexec.c
+++ b/arch/powerpc/platforms/pseries/kexec.c
@@ -20,12 +20,15 @@
 void pseries_kexec_cpu_down(int crash_shutdown, int secondary)
 {
 	/*
-	 * Don't risk a hypervisor call if we're crashing
-	 * XXX: Why? The hypervisor is not crashing. It might be better
-	 * to at least attempt unregister to avoid the hypervisor stepping
-	 * on our memory.
+	 * Ensure vpa/slb_shadow/dtl cleanup even while we are crashing.
+	 * Why? The hypervisor is not crashing so at least attempt unregister to
+	 * avoid the hypervisor stepping on our memory. If hypervisor or kexec
+	 * kernel steps on the old memory allocated to these areas before the
+	 * new kexec-kernel happens to allocate and register new areas,
+	 * the hypervisor will see invalid content which may cause
+	 * unexpected behavior.
 	 */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR) && !crash_shutdown) {
+	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		int ret;
 		int cpu = smp_processor_id();
 		int hwcpu = hard_smp_processor_id();
diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 8ef4e5034765..dd9d4917b568 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -607,6 +607,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 		memcpy(walk.dst.virt.addr, buf, nbytes);
 		crypto_inc(walk.iv, AES_BLOCK_SIZE);
 		ret = skcipher_walk_done(&walk, 0);
+		memzero_explicit(buf, sizeof(buf));
 	}
 
 	return ret;
@@ -908,10 +909,14 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 			  gw_in.ptr, aad_bytes);
 
 		n = aad_bytes + pc_bytes;
-		if (gcm_in_walk_done(&gw_in, n) != n)
-			return -ENOMEM;
-		if (gcm_out_walk_done(&gw_out, n) != n)
-			return -ENOMEM;
+		if (gcm_in_walk_done(&gw_in, n) != n) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		if (gcm_out_walk_done(&gw_out, n) != n) {
+			ret = -ENOMEM;
+			goto out;
+		}
 		aadlen -= aad_bytes;
 		pclen -= pc_bytes;
 	} while (aadlen + pclen > 0);
@@ -923,7 +928,10 @@ static int gcm_aes_crypt(struct aead_request *req, unsigned int flags)
 	} else
 		scatterwalk_map_and_copy(param.t, req->dst, len, taglen, 1);
 
+out:
 	memzero_explicit(&param, sizeof(param));
+	memzero_explicit(gw_in.buf, sizeof(gw_in.buf));
+	memzero_explicit(gw_out.buf, sizeof(gw_out.buf));
 	return ret;
 }
 
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 5c028bee91b9..e14d346dafd6 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -131,6 +131,13 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 }
 static BIN_ATTR(report_error, S_IWUSR, NULL, report_error_write, PAGE_SIZE);
 
+static ssize_t uid_is_unique_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", zpci_unique_uid ? 1 : 0);
+}
+static DEVICE_ATTR_RO(uid_is_unique);
+
 static struct bin_attribute *zpci_bin_attrs[] = {
 	&bin_attr_util_string,
 	&bin_attr_report_error,
@@ -148,8 +155,10 @@ static struct attribute *zpci_dev_attrs[] = {
 	&dev_attr_uid.attr,
 	&dev_attr_recover.attr,
 	&dev_attr_mio_enabled.attr,
+	&dev_attr_uid_is_unique.attr,
 	NULL,
 };
+
 static struct attribute_group zpci_attr_group = {
 	.attrs = zpci_dev_attrs,
 	.bin_attrs = zpci_bin_attrs,
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7e2ce4c8d657..7d0d1726a089 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -496,6 +496,7 @@ endmenu
 config COMPAT
 	bool
 	depends on SPARC64
+	depends on !LD_IS_LLD
 	default y
 	select COMPAT_BINFMT_ELF if BINFMT_ELF
 	select HAVE_UID16
diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index 1a0600206bf5..dbc51dc2bb4f 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -278,6 +278,7 @@ int arch_uprobe_exception_notify(struct notifier_block *self,
 	case DIE_SSTEP:
 		if (uprobe_post_sstep_notifier(args->regs))
 			ret = NOTIFY_STOP;
+		break;
 
 	default:
 		break;
diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 3f3411b882f5..6deb0469f866 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -844,4 +844,103 @@ static void quirk_clear_strap_no_soft_reset_dev2_f0(struct pci_dev *dev)
 	}
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x15b8, quirk_clear_strap_no_soft_reset_dev2_f0);
+
+/*
+ * Enhanced atomic operations can cause corruption with 64-bit DMA
+ * on these devices.
+ */
+#define RX_ENH_ATOMIC_EN		BIT(8)
+
+static const u32 nbio_7_7_pcie_smn_addrs[] = {
+	0x111401d0,
+	0x111411d0,
+	0x111421d0,
+	0x111431d0,
+	0x111441d0,
+	0x112401d0,
+	0x112411d0,
+	0x112421d0,
+	0x112431d0,
+	0x112441d0,
+	0x112451d0,
+	0x113401d0,
+	0x114401d0,
+};
+
+static const u32 nbio_7_11_pcie_smn_addrs[] = {
+	0x112401d0,
+	0x112411d0,
+	0x112421d0,
+	0x112431d0,
+	0x112441d0,
+	0x112451d0,
+	0x113401d0,
+	0x113411d0,
+	0x113421d0,
+	0x113431d0,
+	0x113441d0,
+	0x113451d0,
+};
+
+static void quirk_amd_nbio_enhanced_atomic(struct pci_dev *host_bridge,
+					   const u32 *smn_addrs,
+					   size_t nr_smn_addrs)
+{
+	bool changed = false;
+	size_t i;
+	u32 data;
+	int ret;
+
+	for (i = 0; i < nr_smn_addrs; i++) {
+		ret = amd_smn_read(0, smn_addrs[i], &data);
+		if (ret)
+			continue;
+		if (!(data & RX_ENH_ATOMIC_EN))
+			continue;
+		data = data & ~RX_ENH_ATOMIC_EN;
+		ret = amd_smn_write(0, smn_addrs[i], data);
+		if (ret)
+			continue;
+		if (changed)
+			continue;
+		ret = amd_smn_read(0, smn_addrs[i], &data);
+		if (ret)
+			continue;
+		if (data & RX_ENH_ATOMIC_EN)
+			continue;
+		changed = true;
+	}
+
+	if (changed)
+		pci_info(host_bridge, "enhanced atomics disabled\n");
+}
+
+static void quirk_amd_nbio_7_7_disable_enhanced_atomic(struct pci_dev *dev)
+{
+	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_7_pcie_smn_addrs,
+				       ARRAY_SIZE(nbio_7_7_pcie_smn_addrs));
+}
+
+static void quirk_amd_nbio_7_11_disable_enhanced_atomic(struct pci_dev *dev)
+{
+	quirk_amd_nbio_enhanced_atomic(dev, nbio_7_11_pcie_smn_addrs,
+				       ARRAY_SIZE(nbio_7_11_pcie_smn_addrs));
+}
+
+/* Phoenix, Hawk Point (NBIO 7.7) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x14E8,
+			quirk_amd_nbio_7_7_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x14E8,
+			quirk_amd_nbio_7_7_disable_enhanced_atomic);
+
+/* Strix, Krackan, Strix Halo (NBIO 7.11) */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1507,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1507,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x1122,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1122,
+			quirk_amd_nbio_7_11_disable_enhanced_atomic);
+
 #endif
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 7ffdc3360a6c..8f6f11ba8ef5 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -295,15 +295,15 @@ static struct blkcg_gq *blkg_create(struct blkcg *blkcg,
 				blkg->pd[i]->online = true;
 			}
 		}
+		blkg->online = true;
 	}
-	blkg->online = true;
 	spin_unlock(&blkcg->lock);
 
 	if (!ret)
 		return blkg;
 
 	/* @blkg failed fully initialized, use the usual release path */
-	blkg_put(blkg);
+	percpu_ref_kill(&blkg->refcnt);
 	return ERR_PTR(ret);
 
 err_put_css:
diff --git a/crypto/Makefile b/crypto/Makefile
index 3d53cc1d8a86..413d333fceb9 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -176,6 +176,11 @@ obj-$(CONFIG_CRYPTO_ECC) += ecc.o
 obj-$(CONFIG_CRYPTO_ESSIV) += essiv.o
 obj-$(CONFIG_CRYPTO_CURVE25519) += curve25519-generic.o
 
+# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=124949
+ifeq ($(CONFIG_ARM)$(CONFIG_KASAN_STACK)$(CONFIG_CC_IS_GCC),yyy)
+CFLAGS_ecc.o += $(call cc-option,-Wframe-larger-than=1536)
+endif
+
 ecdh_generic-y += ecdh.o
 ecdh_generic-y += ecdh_helper.o
 obj-$(CONFIG_CRYPTO_ECDH) += ecdh_generic.o
diff --git a/drivers/acpi/acpica/dsmethod.c b/drivers/acpi/acpica/dsmethod.c
index 0f4770a48912..f77c7f5ab770 100644
--- a/drivers/acpi/acpica/dsmethod.c
+++ b/drivers/acpi/acpica/dsmethod.c
@@ -698,6 +698,8 @@ void
 acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 				 struct acpi_walk_state *walk_state)
 {
+	u32 i;
+	struct acpi_namespace_node *ref_node;
 
 	ACPI_FUNCTION_TRACE_PTR(ds_terminate_control_method, walk_state);
 
@@ -708,6 +710,47 @@ acpi_ds_terminate_control_method(union acpi_operand_object *method_desc,
 	}
 
 	if (walk_state) {
+		/*
+		 * Check if the return value is a ref_of reference to a method local
+		 * or argument. If so, clear the reference to avoid use-after-free
+		 * when the walk state is deleted.
+		 */
+		if (walk_state->return_desc &&
+		    (walk_state->return_desc->common.type ==
+		     ACPI_TYPE_LOCAL_REFERENCE)
+		    && (walk_state->return_desc->reference.class ==
+			ACPI_REFCLASS_REFOF)) {
+			ref_node = walk_state->return_desc->reference.object;
+			if (ref_node) {
+
+				/* Check against method locals */
+				for (i = 0; i < ACPI_METHOD_NUM_LOCALS; i++) {
+					if (ref_node ==
+					    &walk_state->local_variables[i]) {
+						acpi_ut_remove_reference
+						    (walk_state->return_desc);
+						walk_state->return_desc = NULL;
+						break;
+					}
+				}
+
+				/* Check against method arguments if not already cleared */
+				if (walk_state->return_desc) {
+					for (i = 0; i < ACPI_METHOD_NUM_ARGS;
+					     i++) {
+						if (ref_node ==
+						    &walk_state->arguments[i]) {
+							acpi_ut_remove_reference
+							    (walk_state->
+							     return_desc);
+							walk_state->
+							    return_desc = NULL;
+							break;
+						}
+					}
+				}
+			}
+		}
 
 		/* Delete all arguments and locals */
 
diff --git a/drivers/acpi/acpica/evhandler.c b/drivers/acpi/acpica/evhandler.c
index 3438dc187efb..74e1d2b54017 100644
--- a/drivers/acpi/acpica/evhandler.c
+++ b/drivers/acpi/acpica/evhandler.c
@@ -130,6 +130,14 @@ acpi_ev_has_default_handler(struct acpi_namespace_node *node,
 		/* Walk the linked list of handlers for this object */
 
 		while (handler_obj) {
+
+			/* Validate handler object type before accessing fields */
+
+			if (handler_obj->common.type !=
+			    ACPI_TYPE_LOCAL_ADDRESS_HANDLER) {
+				break;
+			}
+
 			if (handler_obj->address_space.space_id == space_id) {
 				if (handler_obj->address_space.handler_flags &
 				    ACPI_ADDR_HANDLER_DEFAULT_INSTALLED) {
@@ -292,6 +300,9 @@ union acpi_operand_object *acpi_ev_find_region_handler(acpi_adr_space_type
 	/* Walk the handler list for this device */
 
 	while (handler_obj) {
+		if (handler_obj->common.type != ACPI_TYPE_LOCAL_ADDRESS_HANDLER) {
+			break;
+		}
 
 		/* Same space_id indicates a handler is installed */
 
diff --git a/drivers/acpi/acpica/exoparg3.c b/drivers/acpi/acpica/exoparg3.c
index 962929d4abbf..8c4741440567 100644
--- a/drivers/acpi/acpica/exoparg3.c
+++ b/drivers/acpi/acpica/exoparg3.c
@@ -152,7 +152,7 @@ acpi_status acpi_ex_opcode_3A_1T_1R(struct acpi_walk_state *walk_state)
 
 		/* Truncate request if larger than the actual String/Buffer */
 
-		else if ((index + length) > operand[0]->string.length) {
+		else if ((index + length) > operand[0]->string.length || (index + length) < index) {	/* Check for overflow */
 			length =
 			    (acpi_size)operand[0]->string.length -
 			    (acpi_size)index;
diff --git a/drivers/acpi/acpica/nsnames.c b/drivers/acpi/acpica/nsnames.c
index d91153f65700..ab6d217d31db 100644
--- a/drivers/acpi/acpica/nsnames.c
+++ b/drivers/acpi/acpica/nsnames.c
@@ -222,6 +222,12 @@ acpi_ns_build_normalized_path(struct acpi_namespace_node *node,
 		goto build_trailing_null;
 	}
 
+	/* Validate the Node to avoid use-after-free vulnerabilities */
+
+	if (ACPI_GET_DESCRIPTOR_TYPE(node) != ACPI_DESC_TYPE_NAMED) {
+		goto build_trailing_null;
+	}
+
 	next_node = node;
 	while (next_node && next_node != acpi_gbl_root_node) {
 		if (next_node != node) {
diff --git a/drivers/acpi/acpica/nsprepkg.c b/drivers/acpi/acpica/nsprepkg.c
index 237b3ddeb075..d5cc0381e67f 100644
--- a/drivers/acpi/acpica/nsprepkg.c
+++ b/drivers/acpi/acpica/nsprepkg.c
@@ -631,6 +631,13 @@ acpi_ns_custom_package(struct acpi_evaluate_info *info,
 
 	/* Get version number, must be Integer */
 
+	if (!(*elements)) {
+		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
+				      info->node_flags,
+				      "Return Package has a NULL version element"));
+		return_ACPI_STATUS(AE_AML_OPERAND_TYPE);
+	}
+
 	if ((*elements)->common.type != ACPI_TYPE_INTEGER) {
 		ACPI_WARN_PREDEFINED((AE_INFO, info->full_pathname,
 				      info->node_flags,
diff --git a/drivers/acpi/acpica/nsxfname.c b/drivers/acpi/acpica/nsxfname.c
index 0e6aba81605b..5c846978c38a 100644
--- a/drivers/acpi/acpica/nsxfname.c
+++ b/drivers/acpi/acpica/nsxfname.c
@@ -512,6 +512,10 @@ acpi_status acpi_install_method(u8 *buffer)
 
 	parser_state.aml += acpi_ps_get_opcode_size(opcode);
 	parser_state.pkg_end = acpi_ps_get_next_package_end(&parser_state);
+	if ((parser_state.pkg_end > parser_state.aml_end) ||
+	    (parser_state.pkg_end < parser_state.aml)) {
+		return (AE_AML_PACKAGE_LIMIT);
+	}
 	path = acpi_ps_get_next_namestring(&parser_state);
 
 	method_flags = *parser_state.aml++;
diff --git a/drivers/acpi/acpica/psargs.c b/drivers/acpi/acpica/psargs.c
index 7a1120262a14..543890365094 100644
--- a/drivers/acpi/acpica/psargs.c
+++ b/drivers/acpi/acpica/psargs.c
@@ -48,6 +48,7 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	u32 package_length = 0;
 	u32 byte_count;
 	u8 byte_zero_mask = 0x3F;	/* Default [0:5] */
+	u32 remaining;
 
 	ACPI_FUNCTION_TRACE(ps_get_next_package_length);
 
@@ -55,7 +56,23 @@ acpi_ps_get_next_package_length(struct acpi_parse_state *parser_state)
 	 * Byte 0 bits [6:7] contain the number of additional bytes
 	 * used to encode the package length, either 0,1,2, or 3
 	 */
+
+	/* Check if we have at least one byte to read */
+	remaining = (u32)ACPI_PTR_DIFF(parser_state->aml_end, aml);
+	if (remaining == 0) {
+		return_UINT32(0);
+	}
+
 	byte_count = (aml[0] >> 6);
+
+	/* Validate byte_count and ensure we have enough bytes to read */
+	if (byte_count >= remaining) {
+
+		/* Clamp to available bytes and advance to end */
+		parser_state->aml = parser_state->aml_end;
+		return_UINT32(0);
+	}
+
 	parser_state->aml += ((acpi_size)byte_count + 1);
 
 	/* Get bytes 3, 2, 1 as needed */
@@ -131,10 +148,16 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 	/* Point past any namestring prefix characters (backslash or carat) */
 
-	while (ACPI_IS_ROOT_PREFIX(*end) || ACPI_IS_PARENT_PREFIX(*end)) {
+	while (end < parser_state->aml_end &&
+	       (ACPI_IS_ROOT_PREFIX(*end) || ACPI_IS_PARENT_PREFIX(*end))) {
 		end++;
 	}
 
+	if (end >= parser_state->aml_end) {
+		parser_state->aml = parser_state->aml_end;
+		return_PTR(NULL);
+	}
+
 	/* Decode the path prefix character */
 
 	switch (*end) {
@@ -159,6 +182,11 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 
 		/* Multiple name segments, 4 chars each, count in next byte */
 
+		if ((end + 1) >= parser_state->aml_end) {
+			parser_state->aml = parser_state->aml_end;
+			return_PTR(NULL);
+		}
+
 		end += 2 + (*(end + 1) * ACPI_NAMESEG_SIZE);
 		break;
 
@@ -170,6 +198,11 @@ char *acpi_ps_get_next_namestring(struct acpi_parse_state *parser_state)
 		break;
 	}
 
+	if (end > parser_state->aml_end) {
+		parser_state->aml = parser_state->aml_end;
+		return_PTR(NULL);
+	}
+
 	parser_state->aml = end;
 	return_PTR((char *)start);
 }
@@ -367,6 +400,8 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 	u32 length;
 	u16 opcode;
 	u8 *aml = parser_state->aml;
+	u32 remaining = (u32)ACPI_PTR_DIFF(parser_state->aml_end, aml);
+	u64 partial_value;
 
 	ACPI_FUNCTION_TRACE_U32(ps_get_next_simple_arg, arg_type);
 
@@ -376,8 +411,13 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 1 byte from the AML stream */
 
 		opcode = AML_BYTE_OP;
-		arg->common.value.integer = (u64) *aml;
-		length = 1;
+		if (remaining >= 1) {
+			arg->common.value.integer = (u64)*aml;
+			length = 1;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+		}
 		break;
 
 	case ARGP_WORDDATA:
@@ -385,8 +425,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 2 bytes from the AML stream */
 
 		opcode = AML_WORD_OP;
-		ACPI_MOVE_16_TO_64(&arg->common.value.integer, aml);
-		length = 2;
+		if (remaining >= 2) {
+			ACPI_MOVE_16_TO_64(&arg->common.value.integer, aml);
+			length = 2;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_DWORDDATA:
@@ -394,8 +445,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 4 bytes from the AML stream */
 
 		opcode = AML_DWORD_OP;
-		ACPI_MOVE_32_TO_64(&arg->common.value.integer, aml);
-		length = 4;
+		if (remaining >= 4) {
+			ACPI_MOVE_32_TO_64(&arg->common.value.integer, aml);
+			length = 4;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_QWORDDATA:
@@ -403,8 +465,19 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Get 8 bytes from the AML stream */
 
 		opcode = AML_QWORD_OP;
-		ACPI_MOVE_64_TO_64(&arg->common.value.integer, aml);
-		length = 8;
+		if (remaining >= 8) {
+			ACPI_MOVE_64_TO_64(&arg->common.value.integer, aml);
+			length = 8;
+		} else {
+			arg->common.value.integer = 0;
+			length = 0;
+			if (remaining > 0) {
+				partial_value = 0;
+				memcpy(&partial_value, aml, remaining);
+				arg->common.value.integer = partial_value;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_CHARLIST:
@@ -417,10 +490,28 @@ acpi_ps_get_next_simple_arg(struct acpi_parse_state *parser_state,
 		/* Find the null terminator */
 
 		length = 0;
-		while (aml[length]) {
+		while ((length < remaining) && aml[length]) {
 			length++;
 		}
-		length++;
+		if (length < remaining) {
+
+			/* Account for the terminating null */
+			length++;
+		} else {
+			/*
+			 * No terminator found - add null at buffer boundary
+			 * and report a warning
+			 */
+			ACPI_WARNING((AE_INFO,
+				      "Invalid AML string: no null terminator, truncating at offset %u",
+				      (u32)(aml - parser_state->aml)));
+
+			/* Add null terminator at the boundary */
+			if (remaining > 0) {
+				aml[remaining - 1] = 0;
+				length = remaining;
+			}
+		}
 		break;
 
 	case ARGP_NAME:
@@ -474,6 +565,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 	ASL_CV_CAPTURE_COMMENTS_ONLY(parser_state);
 	aml = parser_state->aml;
 
+	if (aml >= parser_state->aml_end) {
+		return_PTR(NULL);
+	}
+
 	/* Determine field type */
 
 	switch (ACPI_GET8(parser_state->aml)) {
@@ -522,6 +617,11 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 		/* Get the 4-character name */
 
+		if ((parser_state->aml + ACPI_NAMESEG_SIZE) >
+		    parser_state->aml_end) {
+			acpi_ps_free_op(field);
+			return_PTR(NULL);
+		}
 		ACPI_MOVE_32_TO_32(&name, parser_state->aml);
 		acpi_ps_set_name(field, name);
 		parser_state->aml += ACPI_NAMESEG_SIZE;
@@ -567,6 +667,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 
 		/* Get the two bytes (Type/Attribute) */
 
+		if ((parser_state->aml + 2) > parser_state->aml_end) {
+			acpi_ps_free_op(field);
+			return_PTR(NULL);
+		}
 		access_type = ACPI_GET8(parser_state->aml);
 		parser_state->aml++;
 		access_attribute = ACPI_GET8(parser_state->aml);
@@ -578,6 +682,10 @@ static union acpi_parse_object *acpi_ps_get_next_field(struct acpi_parse_state
 		/* This opcode has a third byte, access_length */
 
 		if (opcode == AML_INT_EXTACCESSFIELD_OP) {
+			if (parser_state->aml >= parser_state->aml_end) {
+				acpi_ps_free_op(field);
+				return_PTR(NULL);
+			}
 			access_length = ACPI_GET8(parser_state->aml);
 			parser_state->aml++;
 
@@ -775,6 +883,10 @@ acpi_ps_get_next_arg(struct acpi_walk_state *walk_state,
 
 		parser_state->pkg_end =
 		    acpi_ps_get_next_package_end(parser_state);
+		if ((parser_state->pkg_end > parser_state->aml_end)
+		    || (parser_state->pkg_end < parser_state->aml)) {
+			return_ACPI_STATUS(AE_AML_PACKAGE_LIMIT);
+		}
 		break;
 
 	case ARGP_FIELDLIST:
diff --git a/drivers/acpi/acpica/psloop.c b/drivers/acpi/acpica/psloop.c
index 3cf0687b9915..9e21d96faa8e 100644
--- a/drivers/acpi/acpica/psloop.c
+++ b/drivers/acpi/acpica/psloop.c
@@ -362,6 +362,13 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					walk_state->parser_state.aml =
 					    acpi_ps_get_next_package_end
 					    (&walk_state->parser_state);
+					if ((walk_state->parser_state.aml >
+					     walk_state->parser_state.aml_end)
+					    || (walk_state->parser_state.aml <
+						walk_state->aml)) {
+						return_ACPI_STATUS
+						    (AE_AML_PACKAGE_LIMIT);
+					}
 					walk_state->aml =
 					    walk_state->parser_state.aml;
 				}
@@ -422,11 +429,22 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 					parser_state->aml =
 					    acpi_ps_get_next_package_end
 					    (parser_state);
+					if ((parser_state->aml >
+					     parser_state->aml_end)
+					    || (parser_state->aml <
+						walk_state->control_state->
+						control.aml_predicate_start)) {
+						return_ACPI_STATUS
+						    (AE_AML_PACKAGE_LIMIT);
+					}
 					walk_state->aml = parser_state->aml;
 
 					ACPI_ERROR((AE_INFO,
 						    "Skipping While/If block"));
-					if (*walk_state->aml == AML_ELSE_OP) {
+					if ((walk_state->aml <
+					     parser_state->aml_end)
+					    && (*walk_state->aml ==
+						AML_ELSE_OP)) {
 						ACPI_ERROR((AE_INFO,
 							    "Skipping Else block"));
 						walk_state->parser_state.aml =
@@ -434,6 +452,16 @@ acpi_status acpi_ps_parse_loop(struct acpi_walk_state *walk_state)
 						walk_state->parser_state.aml =
 						    acpi_ps_get_next_package_end
 						    (parser_state);
+						if ((walk_state->parser_state.
+						     aml >
+						     walk_state->parser_state.
+						     aml_end)
+						    || (walk_state->
+							parser_state.aml <
+							walk_state->aml)) {
+							return_ACPI_STATUS
+							    (AE_AML_PACKAGE_LIMIT);
+						}
 						walk_state->aml =
 						    parser_state->aml;
 					}
diff --git a/drivers/acpi/acpica/psparse.c b/drivers/acpi/acpica/psparse.c
index bd3caf735be3..700a621abd9b 100644
--- a/drivers/acpi/acpica/psparse.c
+++ b/drivers/acpi/acpica/psparse.c
@@ -70,6 +70,9 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
 	u16 opcode;
 
 	aml = parser_state->aml;
+	if (aml >= parser_state->aml_end) {
+		return (0xFFFF);
+	}
 	opcode = (u16) ACPI_GET8(aml);
 
 	if (opcode == AML_EXTENDED_PREFIX) {
@@ -77,6 +80,9 @@ u16 acpi_ps_peek_opcode(struct acpi_parse_state * parser_state)
 		/* Extended opcode, get the second opcode byte */
 
 		aml++;
+		if (aml >= parser_state->aml_end) {
+			return (0xFFFF);
+		}
 		opcode = (u16) ((opcode << 8) | ACPI_GET8(aml));
 	}
 
@@ -300,6 +306,7 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 {
 	struct acpi_parse_state *parser_state = &walk_state->parser_state;
 	acpi_status status = AE_CTRL_PENDING;
+	u8 *aml;
 
 	ACPI_FUNCTION_TRACE_PTR(ps_next_parse_state, op);
 
@@ -344,7 +351,14 @@ acpi_ps_next_parse_state(struct acpi_walk_state *walk_state,
 		 * Predicate of an IF was true, and we are at the matching ELSE.
 		 * Just close out this package
 		 */
+		aml = parser_state->aml;
+
 		parser_state->aml = acpi_ps_get_next_package_end(parser_state);
+		if ((parser_state->aml > parser_state->aml_end) ||
+		    (parser_state->aml < aml)) {
+			status = AE_AML_PACKAGE_LIMIT;
+			break;
+		}
 		status = AE_CTRL_PENDING;
 		break;
 
diff --git a/drivers/acpi/acpica/utcopy.c b/drivers/acpi/acpica/utcopy.c
index 9a7cc679e544..e4b62202fd30 100644
--- a/drivers/acpi/acpica/utcopy.c
+++ b/drivers/acpi/acpica/utcopy.c
@@ -731,7 +731,15 @@ acpi_ut_copy_simple_object(union acpi_operand_object *source_desc,
 			break;
 		}
 
-		acpi_ut_add_reference(source_desc->reference.object);
+		/*
+		 * Local/Arg/Debug references do not have a valid Object pointer
+		 * that can be referenced
+		 */
+		if ((source_desc->reference.class != ACPI_REFCLASS_LOCAL) &&
+		    (source_desc->reference.class != ACPI_REFCLASS_ARG) &&
+		    (source_desc->reference.class != ACPI_REFCLASS_DEBUG)) {
+			acpi_ut_add_reference(source_desc->reference.object);
+		}
 		break;
 
 	case ACPI_TYPE_REGION:
diff --git a/drivers/acpi/acpica/utresrc.c b/drivers/acpi/acpica/utresrc.c
index cba5505171da..d98f1d1c9eaa 100644
--- a/drivers/acpi/acpica/utresrc.c
+++ b/drivers/acpi/acpica/utresrc.c
@@ -161,6 +161,28 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 	/* Walk the byte list, abort on any invalid descriptor type or length */
 
 	while (aml < end_aml) {
+		/*
+		 * Validate that the remaining buffer space can hold enough
+		 * bytes to safely access fields during validation.
+		 * For large resource descriptors (bit 7 set), we need enough
+		 * bytes to access the Type field in serial_bus resources.
+		 * Small resource descriptors only need sizeof(struct aml_resource_end_tag).
+		 */
+		if ((acpi_size)(end_aml - aml) <
+		    sizeof(struct aml_resource_end_tag)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
+
+		/*
+		 * For large resource descriptors, ensure enough space for
+		 * the header plus serial_bus Type field access.
+		 */
+		if ((ACPI_GET8(aml) & ACPI_RESOURCE_NAME_LARGE) &&
+		    ((acpi_size)(end_aml - aml) <
+		     ACPI_OFFSET(struct aml_resource_common_serialbus,
+				 type) + 1)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
 
 		/* Validate the Resource Type and Resource Length */
 
@@ -178,6 +200,14 @@ acpi_ut_walk_aml_resources(struct acpi_walk_state *walk_state,
 
 		length = acpi_ut_get_descriptor_length(aml);
 
+		/*
+		 * Validate that the descriptor length doesn't exceed the
+		 * remaining buffer size to prevent reading beyond the end.
+		 */
+		if (length > (acpi_size)(end_aml - aml)) {
+			return_ACPI_STATUS(AE_AML_BUFFER_LENGTH);
+		}
+
 		/* Invoke the user function */
 
 		if (user_function) {
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 48d22150528b..77c2b8b997cd 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1768,6 +1768,24 @@ static ssize_t remapped_nvme_show(struct device *dev,
 
 static DEVICE_ATTR_RO(remapped_nvme);
 
+static int ahci_validate_bar_size(struct pci_dev *pdev, int bar,
+				  struct ahci_host_priv *hpriv)
+{
+	u32 cap = readl(hpriv->mmio + HOST_CAP);
+	unsigned int max_ports = ahci_nr_ports(cap);
+	u32 last_port_end = 0x100 + (max_ports * 0x80);
+	resource_size_t bar_size = pci_resource_len(pdev, bar);
+
+	if (last_port_end > bar_size) {
+		dev_warn(&pdev->dev,
+			 "BAR%d too small for %u ports (last port ends at %#x, BAR %pa)\n",
+			 bar, max_ports, last_port_end, &bar_size);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
 	unsigned int board_id = ent->driver_data;
@@ -1872,6 +1890,10 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
 
+	rc = ahci_validate_bar_size(pdev, ahci_pci_bar, hpriv);
+	if (rc)
+		return rc;
+
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
 
diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index e188850f65ff..75ccd7872b7e 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -688,15 +688,28 @@ void ahci_start_fis_rx(struct ata_port *ap)
 	struct ahci_port_priv *pp = ap->private_data;
 	u32 tmp;
 
-	/* set FIS registers */
+	/*
+	 * On HBAs that only support 32-bit addressing PxCLBU is read only '0'.
+	 * When applying the AHCI_HFLAG_32BIT_ONLY quirk, PxCLBU is RW, and the
+	 * reset value is Implementation Specific, so we need to clear it to 0.
+	 */
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->cmd_slot_dma >> 16) >> 16,
 		       port_mmio + PORT_LST_ADDR_HI);
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_LST_ADDR_HI);
 	writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
 
+	/*
+	 * On HBAs that only support 32-bit addressing PxFBU is read only '0'.
+	 * When applying the AHCI_HFLAG_32BIT_ONLY quirk, PxFBU is RW, and the
+	 * reset value is Implementation Specific, so we need to clear it to 0.
+	 */
 	if (hpriv->cap & HOST_CAP_64)
 		writel((pp->rx_fis_dma >> 16) >> 16,
 		       port_mmio + PORT_FIS_ADDR_HI);
+	else if (hpriv->flags & AHCI_HFLAG_32BIT_ONLY)
+		writel(0, port_mmio + PORT_FIS_ADDR_HI);
 	writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
 
 	/* enable FIS reception */
diff --git a/drivers/ata/libata-pmp.c b/drivers/ata/libata-pmp.c
index 79f2aeeb482a..452baa43d77e 100644
--- a/drivers/ata/libata-pmp.c
+++ b/drivers/ata/libata-pmp.c
@@ -446,8 +446,13 @@ static void sata_pmp_quirks(struct ata_port *ap)
 		 * otherwise.  Don't try hard to recover it.
 		 */
 		ap->pmp_link[ap->nr_pmp_links - 1].flags |= ATA_LFLAG_NO_RETRY;
-	} else if (vendor == 0x197b && (devid == 0x2352 || devid == 0x0325)) {
+	} else if (vendor == 0x197b &&
+		   (devid == 0x0562 || devid == 0x2352 || devid == 0x0325)) {
 		/*
+		 * 0x0562: JMicron JMS562, as used in QNAP QDA-A2AR RAID1
+		 *         adapters.  The exported device may stay not ready
+		 *         while the array is rebuilding, and SRST/classify can
+		 *         time out before the RAID volume is exported.
 		 * 0x2352: found in Thermaltake BlackX Duet, jmicron JMB350?
 		 * 0x0325: jmicron JMB394.
 		 */
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 9cf0b858f7b8..9f81ceee649c 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -524,6 +524,23 @@ static int __send_request(struct request *req)
 	err = __vdc_tx_trigger(port);
 	if (err < 0) {
 		printk(KERN_ERR PFX "vdc_tx_trigger() failure, err=%d\n", err);
+		/*
+		 * If the port was reset (-ENOTCONN), the dring and the
+		 * LDC channel including all of its mappings are already
+		 * torn down and reallocated - there is nothing to undo
+		 * and @desc must not be touched.
+		 *
+		 * For any other failure the descriptor was never handed
+		 * to the peer: unmap the cookies and free the descriptor
+		 * again, so that a later retry of the request does not
+		 * leak LDC map table entries.
+		 */
+		if (err != -ENOTCONN) {
+			ldc_unmap(port->vio.lp, desc->cookies,
+				  desc->ncookies);
+			desc->hdr.state = VIO_DESC_FREE;
+			rqe->req = NULL;
+		}
 	} else {
 		port->req_id++;
 		dr->prod = vio_dring_next(dr, dr->prod);
@@ -538,6 +555,7 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct vdc_port *port = hctx->queue->queuedata;
 	struct vio_dring_state *dr;
 	unsigned long flags;
+	int ret;
 
 	dr = &port->vio.drings[VIO_DRIVER_TX_RING];
 
@@ -559,7 +577,13 @@ static blk_status_t vdc_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return BLK_STS_DEV_RESOURCE;
 	}
 
-	if (__send_request(bd->rq) < 0) {
+	ret = __send_request(bd->rq);
+	if (ret == -EAGAIN) {
+		spin_unlock_irqrestore(&port->vio.lock, flags);
+		/* already spun for 10msec, defer 10msec and retry */
+		blk_mq_delay_kick_requeue_list(hctx->queue, 10);
+		return BLK_STS_DEV_RESOURCE;
+	} else if (ret < 0) {
 		spin_unlock_irqrestore(&port->vio.lock, flags);
 		return BLK_STS_IOERR;
 	}
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 971e9f6c36bb..ba6e492821dc 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -897,10 +897,8 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 	wmt_params.status = NULL;
 
 	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
+	if (err < 0)
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
-		return err;
-	}
 
 	pm_runtime_put_noidle(bdev->dev);
 	pm_runtime_disable(bdev->dev);
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index bdde7757ffb3..6dfae5590198 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -62,6 +62,15 @@ static struct usb_driver btusb_driver;
 #define BTUSB_QCA_WCN6855	0x1000000
 
 static const struct usb_device_id btusb_table[] = {
+	/*
+	 * NXP IW610 (0471:0215): the composite device reports Bluetooth
+	 * class at the whole-device level, so the generic entry below
+	 * would also match this WiFi vendor interface. Ignore it here
+	 * first so mwifiex-nxp can bind it instead.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xff, 0xff, 0xff),
+	  .driver_info = BTUSB_IGNORE },
+
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
@@ -359,6 +368,14 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x1286, 0x2046), .driver_info = BTUSB_MARVELL },
 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
 
+	/*
+	 * NXP IW610 BT interfaces (Marvell-lineage silicon, same quirk as
+	 * the 0x1286 entries above). Scoped to the BT interface class,
+	 * not just VID/PID -- see the btusb_table entry above.
+	 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0471, 0x0215, 0xe0, 0x01, 0x01),
+	  .driver_info = BTUSB_MARVELL },
+
 	/* Intel Bluetooth devices */
 	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
 						     BTUSB_WIDEBAND_SPEECH |
@@ -481,12 +498,6 @@ static const struct usb_device_id blacklist_table[] = {
 	{ USB_DEVICE(0x0bda, 0xb009), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x2ff8, 0xb011), .driver_info = BTUSB_REALTEK },
 
-	/* Additional Realtek 8761CU Bluetooth devices */
-	{ USB_DEVICE(0x0b05, 0x1bef), .driver_info = BTUSB_REALTEK |
-						     BTUSB_WIDEBAND_SPEECH },
-	{ USB_DEVICE(0x0b05, 0x1d70), .driver_info = BTUSB_REALTEK |
-						     BTUSB_WIDEBAND_SPEECH },
-
 	/* Additional Realtek 8821AE Bluetooth devices */
 	{ USB_DEVICE(0x0b05, 0x17dc), .driver_info = BTUSB_REALTEK },
 	{ USB_DEVICE(0x13d3, 0x3414), .driver_info = BTUSB_REALTEK },
diff --git a/drivers/bluetooth/hci_mrvl.c b/drivers/bluetooth/hci_mrvl.c
index fbc3f7c3a5c7..b986bdbe09b5 100644
--- a/drivers/bluetooth/hci_mrvl.c
+++ b/drivers/bluetooth/hci_mrvl.c
@@ -297,9 +297,8 @@ static int mrvl_load_firmware(struct hci_dev *hdev, const char *name)
 		err = wait_on_bit_timeout(&mrvl->flags, STATE_FW_REQ_PENDING,
 					  TASK_INTERRUPTIBLE,
 					  msecs_to_jiffies(2000));
-		if (err == 1) {
+		if (err == -EINTR) {
 			bt_dev_err(hdev, "Firmware load interrupted");
-			err = -EINTR;
 			break;
 		} else if (err) {
 			bt_dev_err(hdev, "Firmware request timeout");
diff --git a/drivers/char/ipmi/ipmi_si_platform.c b/drivers/char/ipmi/ipmi_si_platform.c
index 129b5713f187..1cc4841eeba8 100644
--- a/drivers/char/ipmi/ipmi_si_platform.c
+++ b/drivers/char/ipmi/ipmi_si_platform.c
@@ -286,7 +286,10 @@ static int of_ipmi_probe(struct platform_device *pdev)
 	io.regspacing	= regspacing ? be32_to_cpup(regspacing) : DEFAULT_REGSPACING;
 	io.regshift	= regshift ? be32_to_cpup(regshift) : 0;
 
-	io.irq		= irq_of_parse_and_map(pdev->dev.of_node, 0);
+	io.irq = platform_get_irq_optional(pdev, 0);
+	if (io.irq < 0)
+		io.irq = 0;
+
 	io.dev		= &pdev->dev;
 
 	dev_dbg(&pdev->dev, "addr 0x%lx regsize %d spacing %d irq %d\n",
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index e9f694b36871..bd7510abdc07 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -53,7 +53,6 @@
 #include <asm/nvram.h>
 #endif
 
-static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
@@ -310,11 +309,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		break;
 #ifdef CONFIG_PPC32
 	case IOC_NVRAM_SYNC:
-		if (ppc_md.nvram_sync != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (ppc_md.nvram_sync)
 			ppc_md.nvram_sync();
-			mutex_unlock(&nvram_mutex);
-		}
 		ret = 0;
 		break;
 #endif
@@ -324,11 +320,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (arch_nvram_ops.initialize != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (arch_nvram_ops.initialize)
 			ret = arch_nvram_ops.initialize();
-			mutex_unlock(&nvram_mutex);
-		}
 		break;
 	case NVRAM_SETCKS:
 		/* just set checksum, contents unchanged (maybe useful after
@@ -336,11 +329,8 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		if (arch_nvram_ops.set_checksum != NULL) {
-			mutex_lock(&nvram_mutex);
+		if (arch_nvram_ops.set_checksum)
 			ret = arch_nvram_ops.set_checksum();
-			mutex_unlock(&nvram_mutex);
-		}
 		break;
 #endif /* CONFIG_X86 || CONFIG_M68K */
 	}
diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 712db89020f3..5131bc5e3675 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1936,13 +1936,29 @@ static const struct file_operations portdev_fops = {
 static void remove_vqs(struct ports_device *portdev)
 {
 	struct virtqueue *vq;
+	bool multiport = use_multiport(portdev);
 
 	virtio_device_for_each_vq(portdev->vdev, vq) {
 		struct port_buffer *buf;
+		unsigned int len;
 
-		flush_bufs(vq, true);
-		while ((buf = virtqueue_detach_unused_buf(vq)))
-			free_buf(buf, true);
+		/*
+		 * c_ovq cookies are &portdev->cpkt, not port_buffer.
+		 * Detach them but do not free_buf().
+		 */
+		if (multiport && vq == portdev->c_ovq) {
+			spin_lock(&portdev->c_ovq_lock);
+			while (virtqueue_get_buf(vq, &len))
+				;
+			while (virtqueue_detach_unused_buf(vq))
+				;
+			spin_unlock(&portdev->c_ovq_lock);
+		} else {
+			flush_bufs(vq, true);
+			while ((buf = virtqueue_detach_unused_buf(vq)))
+				free_buf(buf, true);
+		}
+		cond_resched();
 	}
 	portdev->vdev->config->del_vqs(portdev->vdev);
 	kfree(portdev->in_vqs);
diff --git a/drivers/clk/at91/pmc.h b/drivers/clk/at91/pmc.h
index 7b86affc6d7c..94f6a3fcb505 100644
--- a/drivers/clk/at91/pmc.h
+++ b/drivers/clk/at91/pmc.h
@@ -98,7 +98,9 @@ struct clk_pcr_layout {
 	u32 pid_mask;
 };
 
+#undef field_get
 #define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+#undef field_prep
 #define field_prep(_mask, _val) (((_val) << (ffs(_mask) - 1)) & (_mask))
 
 #define ndck(a, s) (a[s - 1].id + 1)
diff --git a/drivers/clk/clk-scpi.c b/drivers/clk/clk-scpi.c
index 5a9b140dd8c8..41feac548b6c 100644
--- a/drivers/clk/clk-scpi.c
+++ b/drivers/clk/clk-scpi.c
@@ -86,7 +86,7 @@ static unsigned long scpi_dvfs_recalc_rate(struct clk_hw *hw,
 	int idx = clk->scpi_ops->dvfs_get_idx(clk->id);
 	const struct scpi_opp *opp;
 
-	if (idx < 0)
+	if (idx < 0 || idx >= clk->info->count)
 		return 0;
 
 	opp = clk->info->opps + idx;
diff --git a/drivers/clk/keystone/sci-clk.c b/drivers/clk/keystone/sci-clk.c
index 8af2a9faa805..422482f60bbb 100644
--- a/drivers/clk/keystone/sci-clk.c
+++ b/drivers/clk/keystone/sci-clk.c
@@ -342,6 +342,14 @@ static int _sci_clk_build(struct sci_clk_provider *provider,
 
 	init.ops = &sci_clk_ops;
 	init.num_parents = sci_clk->num_parents;
+
+	/*
+	 * A clock rate query to the SCI firmware will return 0 if either the
+	 * clock itself is disabled or the attached device/consumer is disabled.
+	 * This makes it inherently unsuitable for the caching of the clk
+	 * framework.
+	 */
+	init.flags = CLK_GET_RATE_NOCACHE;
 	sci_clk->hw.init = &init;
 
 	ret = devm_clk_hw_register(provider->dev, &sci_clk->hw);
diff --git a/drivers/clk/renesas/renesas-cpg-mssr.c b/drivers/clk/renesas/renesas-cpg-mssr.c
index a5a68e1e7549..5be04e80c01a 100644
--- a/drivers/clk/renesas/renesas-cpg-mssr.c
+++ b/drivers/clk/renesas/renesas-cpg-mssr.c
@@ -280,6 +280,9 @@ struct clk *cpg_mssr_clk_src_twocell_get(struct of_phandle_args *clkspec,
 	struct clk *clk;
 	int range_check;
 
+	if (clkspec->args_count != 2)
+		return ERR_PTR(-EINVAL);
+
 	switch (clkspec->args[0]) {
 	case CPG_CORE:
 		type = "core";
diff --git a/drivers/clk/socfpga/clk-agilex.c b/drivers/clk/socfpga/clk-agilex.c
index 225636c2b569..2ac87dcee45e 100644
--- a/drivers/clk/socfpga/clk-agilex.c
+++ b/drivers/clk/socfpga/clk-agilex.c
@@ -247,6 +247,8 @@ static const struct stratix10_perip_cnt_clock agilex_main_perip_cnt_clks[] = {
 	   0, 0x3C, 0, 0, 0},
 	{ AGILEX_NOC_FREE_CLK, "noc_free_clk", NULL, noc_free_mux, ARRAY_SIZE(noc_free_mux),
 	  0, 0x40, 0, 0, 0},
+	{ AGILEX_L3_MAIN_FREE_CLK, "l3_main_free_clk", "noc_free_clk", NULL,
+	  1, 0, 0, 1, 0, 0},
 	{ AGILEX_L4_SYS_FREE_CLK, "l4_sys_free_clk", NULL, noc_mux, ARRAY_SIZE(noc_mux), 0,
 	  0, 4, 0x30, 1},
 	{ AGILEX_EMAC_A_FREE_CLK, "emaca_free_clk", NULL, emaca_free_mux, ARRAY_SIZE(emaca_free_mux),
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index f24da4f151f3..47ba1e73e77c 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1204,7 +1204,7 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!policy)
 		return NULL;
 
-	if (!alloc_cpumask_var(&policy->cpus, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&policy->cpus, GFP_KERNEL))
 		goto err_free_policy;
 
 	if (!zalloc_cpumask_var(&policy->related_cpus, GFP_KERNEL))
@@ -1213,6 +1213,8 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 	if (!zalloc_cpumask_var(&policy->real_cpus, GFP_KERNEL))
 		goto err_free_rcpumask;
 
+	init_rwsem(&policy->rwsem);
+
 	init_completion(&policy->kobj_unregister);
 	ret = kobject_init_and_add(&policy->kobj, &ktype_cpufreq,
 				   cpufreq_global_kobject, "policy%u", cpu);
@@ -1227,8 +1229,6 @@ static struct cpufreq_policy *cpufreq_policy_alloc(unsigned int cpu)
 		goto err_free_real_cpus;
 	}
 
-	init_rwsem(&policy->rwsem);
-
 	freq_constraints_init(&policy->constraints);
 
 	policy->nb_min.notifier_call = cpufreq_notifier_min;
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index ce34048d0d68..f77d2c8e71e5 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -69,14 +69,6 @@ config CRYPTO_DEV_SUN8I_CE_HASH
 	help
 	  Say y to enable support for hash algorithms.
 
-config CRYPTO_DEV_SUN8I_CE_PRNG
-	bool "Support for Allwinner Crypto Engine PRNG"
-	depends on CRYPTO_DEV_SUN8I_CE
-	select CRYPTO_RNG
-	help
-	  Select this option if you want to provide kernel-side support for
-	  the Pseudo-Random Number Generator found in the Crypto Engine.
-
 config CRYPTO_DEV_SUN8I_CE_TRNG
 	bool "Support for Allwinner Crypto Engine TRNG"
 	depends on CRYPTO_DEV_SUN8I_CE
@@ -112,14 +104,6 @@ config CRYPTO_DEV_SUN8I_SS_DEBUG
 	  This will create /sys/kernel/debug/sun8i-ss/stats for displaying
 	  the number of requests per flow and per algorithm.
 
-config CRYPTO_DEV_SUN8I_SS_PRNG
-	bool "Support for Allwinner Security System PRNG"
-	depends on CRYPTO_DEV_SUN8I_SS
-	select CRYPTO_RNG
-	help
-	  Select this option if you want to provide kernel-side support for
-	  the Pseudo-Random Number Generator found in the Security System.
-
 config CRYPTO_DEV_SUN8I_SS_HASH
 	bool "Enable support for hash on sun8i-ss"
 	depends on CRYPTO_DEV_SUN8I_SS
diff --git a/drivers/crypto/allwinner/sun8i-ce/Makefile b/drivers/crypto/allwinner/sun8i-ce/Makefile
index 0842eb2d9408..ea708b427e2e 100644
--- a/drivers/crypto/allwinner/sun8i-ce/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ce/Makefile
@@ -1,5 +1,4 @@
 obj-$(CONFIG_CRYPTO_DEV_SUN8I_CE) += sun8i-ce.o
 sun8i-ce-y += sun8i-ce-core.o sun8i-ce-cipher.o
 sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_HASH) += sun8i-ce-hash.o
-sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG) += sun8i-ce-prng.o
 sun8i-ce-$(CONFIG_CRYPTO_DEV_SUN8I_CE_TRNG) += sun8i-ce-trng.o
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 00194d1d9ae6..d88543a923cc 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 
 #include "sun8i-ce.h"
@@ -46,7 +45,6 @@ static const struct ce_variant ce_h3_variant = {
 		{ "mod", 50000000, 0 },
 		},
 	.esr = ESR_H3,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -63,7 +61,6 @@ static const struct ce_variant ce_h5_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_H5,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -77,7 +74,6 @@ static const struct ce_variant ce_h6_variant = {
 	},
 	.cipher_t_dlen_in_bytes = true,
 	.hash_t_dlen_in_bits = true,
-	.prng_t_dlen_in_bytes = true,
 	.trng_t_dlen_in_bytes = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
@@ -85,7 +81,6 @@ static const struct ce_variant ce_h6_variant = {
 		{ "ram", 0, 400000000 },
 		},
 	.esr = ESR_H6,
-	.prng = CE_ALG_PRNG_V2,
 	.trng = CE_ALG_TRNG_V2,
 };
 
@@ -102,7 +97,6 @@ static const struct ce_variant ce_a64_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_A64,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -119,7 +113,6 @@ static const struct ce_variant ce_r40_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_R40,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -541,25 +534,6 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 	}
 },
 #endif
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG
-{
-	.type = CRYPTO_ALG_TYPE_RNG,
-	.alg.rng = {
-		.base = {
-			.cra_name		= "stdrng",
-			.cra_driver_name	= "sun8i-ce-prng",
-			.cra_priority		= 300,
-			.cra_ctxsize		= sizeof(struct sun8i_ce_rng_tfm_ctx),
-			.cra_module		= THIS_MODULE,
-			.cra_init		= sun8i_ce_prng_init,
-			.cra_exit		= sun8i_ce_prng_exit,
-		},
-		.generate               = sun8i_ce_prng_generate,
-		.seed                   = sun8i_ce_prng_seed,
-		.seedsize               = PRNG_SEED_SIZE,
-	}
-},
-#endif
 };
 
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
@@ -587,12 +561,6 @@ static int sun8i_ce_debugfs_show(struct seq_file *seq, void *v)
 				   ce_algs[i].alg.hash.halg.base.cra_name,
 				   ce_algs[i].stat_req, ce_algs[i].stat_fb);
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s %lu %lu\n",
-				   ce_algs[i].alg.rng.base.cra_driver_name,
-				   ce_algs[i].alg.rng.base.cra_name,
-				   ce_algs[i].stat_req, ce_algs[i].stat_bytes);
-			break;
 		}
 	}
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_TRNG
@@ -821,23 +789,6 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 				return err;
 			}
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			if (ce->variant->prng == CE_ID_NOTSUPP) {
-				dev_info(ce->dev,
-					 "DEBUG: Algo of %s not supported\n",
-					 ce_algs[i].alg.rng.base.cra_name);
-				ce_algs[i].ce = NULL;
-				break;
-			}
-			dev_info(ce->dev, "Register %s\n",
-				 ce_algs[i].alg.rng.base.cra_name);
-			err = crypto_register_rng(&ce_algs[i].alg.rng);
-			if (err) {
-				dev_err(ce->dev, "Fail to register %s\n",
-					ce_algs[i].alg.rng.base.cra_name);
-				ce_algs[i].ce = NULL;
-			}
-			break;
 		default:
 			ce_algs[i].ce = NULL;
 			dev_err(ce->dev, "ERROR: tried to register an unknown algo\n");
@@ -864,11 +815,6 @@ static void sun8i_ce_unregister_algs(struct sun8i_ce_dev *ce)
 				 ce_algs[i].alg.hash.halg.base.cra_name);
 			crypto_unregister_ahash(&ce_algs[i].alg.hash);
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			dev_info(ce->dev, "Unregister %d %s\n", i,
-				 ce_algs[i].alg.rng.base.cra_name);
-			crypto_unregister_rng(&ce_algs[i].alg.rng);
-			break;
 		}
 	}
 }
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
deleted file mode 100644
index cfde9ee4356b..000000000000
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ /dev/null
@@ -1,164 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sun8i-ce-prng.c - hardware cryptographic offloader for
- * Allwinner H3/A64/H5/H2+/H6/R40 SoC
- *
- * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
- *
- * This file handle the PRNG
- *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
- */
-#include "sun8i-ce.h"
-#include <linux/dma-mapping.h>
-#include <linux/pm_runtime.h>
-#include <crypto/internal/rng.h>
-
-int sun8i_ce_prng_init(struct crypto_tfm *tfm)
-{
-	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	memset(ctx, 0, sizeof(struct sun8i_ce_rng_tfm_ctx));
-	return 0;
-}
-
-void sun8i_ce_prng_exit(struct crypto_tfm *tfm)
-{
-	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	memzero_explicit(ctx->seed, ctx->slen);
-	kfree(ctx->seed);
-	ctx->seed = NULL;
-	ctx->slen = 0;
-}
-
-int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-		       unsigned int slen)
-{
-	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
-
-	if (ctx->seed && ctx->slen != slen) {
-		memzero_explicit(ctx->seed, ctx->slen);
-		kfree(ctx->seed);
-		ctx->slen = 0;
-		ctx->seed = NULL;
-	}
-	if (!ctx->seed)
-		ctx->seed = kmalloc(slen, GFP_KERNEL | GFP_DMA);
-	if (!ctx->seed)
-		return -ENOMEM;
-
-	memcpy(ctx->seed, seed, slen);
-	ctx->slen = slen;
-
-	return 0;
-}
-
-int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen)
-{
-	struct sun8i_ce_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-	struct sun8i_ce_alg_template *algt;
-	struct sun8i_ce_dev *ce;
-	dma_addr_t dma_iv, dma_dst;
-	int err = 0;
-	int flow = 3;
-	unsigned int todo;
-	struct sun8i_ce_flow *chan;
-	struct ce_task *cet;
-	u32 common, sym;
-	void *d;
-
-	algt = container_of(alg, struct sun8i_ce_alg_template, alg.rng);
-	ce = algt->ce;
-
-	if (ctx->slen == 0) {
-		dev_err(ce->dev, "not seeded\n");
-		return -EINVAL;
-	}
-
-	/* we want dlen + seedsize rounded up to a multiple of PRNG_DATA_SIZE */
-	todo = dlen + ctx->slen + PRNG_DATA_SIZE * 2;
-	todo -= todo % PRNG_DATA_SIZE;
-
-	d = kzalloc(todo, GFP_KERNEL | GFP_DMA);
-	if (!d) {
-		err = -ENOMEM;
-		goto err_mem;
-	}
-
-	dev_dbg(ce->dev, "%s PRNG slen=%u dlen=%u todo=%u multi=%u\n", __func__,
-		slen, dlen, todo, todo / PRNG_DATA_SIZE);
-
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
-	algt->stat_req++;
-	algt->stat_bytes += todo;
-#endif
-
-	dma_iv = dma_map_single(ce->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
-	if (dma_mapping_error(ce->dev, dma_iv)) {
-		dev_err(ce->dev, "Cannot DMA MAP IV\n");
-		goto err_iv;
-	}
-
-	dma_dst = dma_map_single(ce->dev, d, todo, DMA_FROM_DEVICE);
-	if (dma_mapping_error(ce->dev, dma_dst)) {
-		dev_err(ce->dev, "Cannot DMA MAP DST\n");
-		err = -EFAULT;
-		goto err_dst;
-	}
-
-	err = pm_runtime_get_sync(ce->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(ce->dev);
-		goto err_pm;
-	}
-
-	mutex_lock(&ce->rnglock);
-	chan = &ce->chanlist[flow];
-
-	cet = &chan->tl[0];
-	memset(cet, 0, sizeof(struct ce_task));
-
-	cet->t_id = cpu_to_le32(flow);
-	common = ce->variant->prng | CE_COMM_INT;
-	cet->t_common_ctl = cpu_to_le32(common);
-
-	/* recent CE (H6) need length in bytes, in word otherwise */
-	if (ce->variant->prng_t_dlen_in_bytes)
-		cet->t_dlen = cpu_to_le32(todo);
-	else
-		cet->t_dlen = cpu_to_le32(todo / 4);
-
-	sym = PRNG_LD;
-	cet->t_sym_ctl = cpu_to_le32(sym);
-	cet->t_asym_ctl = 0;
-
-	cet->t_key = cpu_to_le32(dma_iv);
-	cet->t_iv = cpu_to_le32(dma_iv);
-
-	cet->t_dst[0].addr = cpu_to_le32(dma_dst);
-	cet->t_dst[0].len = cpu_to_le32(todo / 4);
-	ce->chanlist[flow].timeout = 2000;
-
-	err = sun8i_ce_run_task(ce, 3, "PRNG");
-	mutex_unlock(&ce->rnglock);
-
-	pm_runtime_put(ce->dev);
-
-err_pm:
-	dma_unmap_single(ce->dev, dma_dst, todo, DMA_FROM_DEVICE);
-err_dst:
-	dma_unmap_single(ce->dev, dma_iv, ctx->slen, DMA_TO_DEVICE);
-
-	if (!err) {
-		memcpy(dst, d, dlen);
-		memcpy(ctx->seed, d + dlen, ctx->slen);
-	}
-	memzero_explicit(d, todo);
-err_iv:
-	kfree(d);
-err_mem:
-	return err;
-}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 0cacbd51b480..6f055067f67b 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -15,7 +15,6 @@
 #include <linux/hw_random.h>
 #include <crypto/internal/hash.h>
 #include <crypto/md5.h>
-#include <crypto/rng.h>
 #include <crypto/sha.h>
 
 /* CE Registers */
@@ -57,9 +56,7 @@
 #define CE_ALG_SHA384           20
 #define CE_ALG_SHA512           21
 #define CE_ALG_TRNG		48
-#define CE_ALG_PRNG		49
 #define CE_ALG_TRNG_V2		0x1c
-#define CE_ALG_PRNG_V2		0x1d
 
 /* Used in ce_variant */
 #define CE_ID_NOTSUPP		0xFF
@@ -94,10 +91,6 @@
 #define ESR_H5	3
 #define ESR_H6	4
 
-#define PRNG_DATA_SIZE (160 / 8)
-#define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
-#define PRNG_LD BIT(17)
-
 #define CE_DIE_ID_SHIFT	16
 #define CE_DIE_ID_MASK	0x07
 
@@ -130,13 +123,10 @@ struct ce_clock {
  *				bytes or words
  * @hash_t_dlen_in_bytes:	Does the request size for hash is in
  *				bits or words
- * @prng_t_dlen_in_bytes:	Does the request size for PRNG is in
- *				bytes or words
  * @trng_t_dlen_in_bytes:	Does the request size for TRNG is in
  *				bytes or words
  * @ce_clks:	list of clocks needed by this variant
  * @esr:	The type of error register
- * @prng:	The CE_ALG_XXX value for the PRNG
  * @trng:	The CE_ALG_XXX value for the TRNG
  */
 struct ce_variant {
@@ -145,11 +135,9 @@ struct ce_variant {
 	u32 op_mode[CE_ID_OP_MAX];
 	bool cipher_t_dlen_in_bytes;
 	bool hash_t_dlen_in_bits;
-	bool prng_t_dlen_in_bytes;
 	bool trng_t_dlen_in_bytes;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
-	unsigned char prng;
 	unsigned char trng;
 };
 
@@ -299,16 +287,6 @@ struct sun8i_ce_hash_reqctx {
 	struct ahash_request fallback_req; // keep at the end
 };
 
-/*
- * struct sun8i_ce_prng_ctx - context for PRNG TFM
- * @seed:	The seed to use
- * @slen:	The size of the seed
- */
-struct sun8i_ce_rng_tfm_ctx {
-	void *seed;
-	unsigned int slen;
-};
-
 /*
  * struct sun8i_ce_alg_template - crypto_alg template
  * @type:		the CRYPTO_ALG_TYPE for this template
@@ -329,7 +307,6 @@ struct sun8i_ce_alg_template {
 	union {
 		struct skcipher_alg skcipher;
 		struct ahash_alg hash;
-		struct rng_alg rng;
 	} alg;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_DEBUG
 	unsigned long stat_req;
@@ -365,11 +342,5 @@ int sun8i_ce_hash_finup(struct ahash_request *areq);
 int sun8i_ce_hash_digest(struct ahash_request *areq);
 int sun8i_ce_hash_run(struct crypto_engine *engine, void *breq);
 
-int sun8i_ce_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen);
-int sun8i_ce_prng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen);
-void sun8i_ce_prng_exit(struct crypto_tfm *tfm);
-int sun8i_ce_prng_init(struct crypto_tfm *tfm);
-
 int sun8i_ce_hwrng_register(struct sun8i_ce_dev *ce);
 void sun8i_ce_hwrng_unregister(struct sun8i_ce_dev *ce);
diff --git a/drivers/crypto/allwinner/sun8i-ss/Makefile b/drivers/crypto/allwinner/sun8i-ss/Makefile
index aabfd893c817..2d6458a42e58 100644
--- a/drivers/crypto/allwinner/sun8i-ss/Makefile
+++ b/drivers/crypto/allwinner/sun8i-ss/Makefile
@@ -1,4 +1,3 @@
 obj-$(CONFIG_CRYPTO_DEV_SUN8I_SS) += sun8i-ss.o
 sun8i-ss-y += sun8i-ss-core.o sun8i-ss-cipher.o
-sun8i-ss-$(CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG) += sun8i-ss-prng.o
 sun8i-ss-$(CONFIG_CRYPTO_DEV_SUN8I_SS_HASH) += sun8i-ss-hash.o
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
index 47b5828e35c3..904cbaceee1b 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -22,7 +22,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 
 #include "sun8i-ss.h"
@@ -269,25 +268,6 @@ static struct sun8i_ss_alg_template ss_algs[] = {
 		.decrypt	= sun8i_ss_skdecrypt,
 	}
 },
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG
-{
-	.type = CRYPTO_ALG_TYPE_RNG,
-	.alg.rng = {
-		.base = {
-			.cra_name		= "stdrng",
-			.cra_driver_name	= "sun8i-ss-prng",
-			.cra_priority		= 300,
-			.cra_ctxsize = sizeof(struct sun8i_ss_rng_tfm_ctx),
-			.cra_module		= THIS_MODULE,
-			.cra_init		= sun8i_ss_prng_init,
-			.cra_exit		= sun8i_ss_prng_exit,
-		},
-		.generate               = sun8i_ss_prng_generate,
-		.seed                   = sun8i_ss_prng_seed,
-		.seedsize               = PRNG_SEED_SIZE,
-	}
-},
-#endif
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_HASH
 {	.type = CRYPTO_ALG_TYPE_AHASH,
 	.ss_algo_id = SS_ID_HASH_MD5,
@@ -431,12 +411,6 @@ static int sun8i_ss_debugfs_show(struct seq_file *seq, void *v)
 				   ss_algs[i].alg.skcipher.base.cra_name,
 				   ss_algs[i].stat_req, ss_algs[i].stat_fb);
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
-				   ss_algs[i].alg.rng.base.cra_driver_name,
-				   ss_algs[i].alg.rng.base.cra_name,
-				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
-			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
 				   ss_algs[i].alg.hash.halg.base.cra_driver_name,
@@ -626,14 +600,6 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 				return err;
 			}
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			err = crypto_register_rng(&ss_algs[i].alg.rng);
-			if (err) {
-				dev_err(ss->dev, "Fail to register %s\n",
-					ss_algs[i].alg.rng.base.cra_name);
-				ss_algs[i].ss = NULL;
-			}
-			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			id = ss_algs[i].ss_algo_id;
 			ss_method = ss->variant->alg_hash[id];
@@ -675,11 +641,6 @@ static void sun8i_ss_unregister_algs(struct sun8i_ss_dev *ss)
 				 ss_algs[i].alg.skcipher.base.cra_name);
 			crypto_unregister_skcipher(&ss_algs[i].alg.skcipher);
 			break;
-		case CRYPTO_ALG_TYPE_RNG:
-			dev_info(ss->dev, "Unregister %d %s\n", i,
-				 ss_algs[i].alg.rng.base.cra_name);
-			crypto_unregister_rng(&ss_algs[i].alg.rng);
-			break;
 		case CRYPTO_ALG_TYPE_AHASH:
 			dev_info(ss->dev, "Unregister %d %s\n", i,
 				 ss_algs[i].alg.hash.halg.base.cra_name);
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
deleted file mode 100644
index 3191527928e4..000000000000
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ /dev/null
@@ -1,175 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sun8i-ss-prng.c - hardware cryptographic offloader for
- * Allwinner A80/A83T SoC
- *
- * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
- *
- * This file handle the PRNG found in the SS
- *
- * You could find a link for the datasheet in Documentation/arm/sunxi.rst
- */
-#include "sun8i-ss.h"
-#include <linux/dma-mapping.h>
-#include <linux/pm_runtime.h>
-#include <crypto/internal/rng.h>
-
-int sun8i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-		       unsigned int slen)
-{
-	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
-
-	if (ctx->seed && ctx->slen != slen) {
-		memzero_explicit(ctx->seed, ctx->slen);
-		kfree(ctx->seed);
-		ctx->slen = 0;
-		ctx->seed = NULL;
-	}
-	if (!ctx->seed)
-		ctx->seed = kmalloc(slen, GFP_KERNEL | GFP_DMA);
-	if (!ctx->seed)
-		return -ENOMEM;
-
-	memcpy(ctx->seed, seed, slen);
-	ctx->slen = slen;
-
-	return 0;
-}
-
-int sun8i_ss_prng_init(struct crypto_tfm *tfm)
-{
-	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	memset(ctx, 0, sizeof(struct sun8i_ss_rng_tfm_ctx));
-	return 0;
-}
-
-void sun8i_ss_prng_exit(struct crypto_tfm *tfm)
-{
-	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	memzero_explicit(ctx->seed, ctx->slen);
-	kfree(ctx->seed);
-	ctx->seed = NULL;
-	ctx->slen = 0;
-}
-
-int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen)
-{
-	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
-	struct rng_alg *alg = crypto_rng_alg(tfm);
-	struct sun8i_ss_alg_template *algt;
-	struct sun8i_ss_dev *ss;
-	dma_addr_t dma_iv, dma_dst;
-	unsigned int todo;
-	int err = 0;
-	int flow;
-	void *d;
-	u32 v;
-
-	algt = container_of(alg, struct sun8i_ss_alg_template, alg.rng);
-	ss = algt->ss;
-
-	if (ctx->slen == 0) {
-		dev_err(ss->dev, "The PRNG is not seeded\n");
-		return -EINVAL;
-	}
-
-	/* The SS does not give an updated seed, so we need to get a new one.
-	 * So we will ask for an extra PRNG_SEED_SIZE data.
-	 * We want dlen + seedsize rounded up to a multiple of PRNG_DATA_SIZE
-	 */
-	todo = dlen + PRNG_SEED_SIZE + PRNG_DATA_SIZE;
-	todo -= todo % PRNG_DATA_SIZE;
-
-	d = kzalloc(todo, GFP_KERNEL | GFP_DMA);
-	if (!d)
-		return -ENOMEM;
-
-	flow = sun8i_ss_get_engine_number(ss);
-
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
-	algt->stat_req++;
-	algt->stat_bytes += todo;
-#endif
-
-	v = SS_ALG_PRNG | SS_PRNG_CONTINUE | SS_START;
-	if (flow)
-		v |= SS_FLOW1;
-	else
-		v |= SS_FLOW0;
-
-	dma_iv = dma_map_single(ss->dev, ctx->seed, ctx->slen, DMA_TO_DEVICE);
-	if (dma_mapping_error(ss->dev, dma_iv)) {
-		dev_err(ss->dev, "Cannot DMA MAP IV\n");
-		err = -EFAULT;
-		goto err_free;
-	}
-
-	dma_dst = dma_map_single(ss->dev, d, todo, DMA_FROM_DEVICE);
-	if (dma_mapping_error(ss->dev, dma_dst)) {
-		dev_err(ss->dev, "Cannot DMA MAP DST\n");
-		err = -EFAULT;
-		goto err_iv;
-	}
-
-	err = pm_runtime_get_sync(ss->dev);
-	if (err < 0) {
-		pm_runtime_put_noidle(ss->dev);
-		goto err_pm;
-	}
-	err = 0;
-
-	mutex_lock(&ss->mlock);
-	writel(dma_iv, ss->base + SS_IV_ADR_REG);
-	/* the PRNG act badly (failing rngtest) without SS_KEY_ADR_REG set */
-	writel(dma_iv, ss->base + SS_KEY_ADR_REG);
-	writel(dma_dst, ss->base + SS_DST_ADR_REG);
-	writel(todo / 4, ss->base + SS_LEN_ADR_REG);
-
-	reinit_completion(&ss->flows[flow].complete);
-	ss->flows[flow].status = 0;
-	/* Be sure all data is written before enabling the task */
-	wmb();
-
-	writel(v, ss->base + SS_CTL_REG);
-
-	wait_for_completion_interruptible_timeout(&ss->flows[flow].complete,
-						  msecs_to_jiffies(todo));
-	if (ss->flows[flow].status == 0) {
-		dev_err(ss->dev, "DMA timeout for PRNG (size=%u)\n", todo);
-		err = -EFAULT;
-	}
-	/* Since cipher and hash use the linux/cryptoengine and that we have
-	 * a cryptoengine per flow, we are sure that they will issue only one
-	 * request per flow.
-	 * Since the cryptoengine wait for completion before submitting a new
-	 * one, the mlock could be left just after the final writel.
-	 * But cryptoengine cannot handle crypto_rng, so we need to be sure
-	 * nothing will use our flow.
-	 * The easiest way is to grab mlock until the hardware end our requests.
-	 * We could have used a per flow lock, but this would increase
-	 * complexity.
-	 * The drawback is that no request could be handled for the other flow.
-	 */
-	mutex_unlock(&ss->mlock);
-
-	pm_runtime_put(ss->dev);
-
-err_pm:
-	dma_unmap_single(ss->dev, dma_dst, todo, DMA_FROM_DEVICE);
-err_iv:
-	dma_unmap_single(ss->dev, dma_iv, ctx->slen, DMA_TO_DEVICE);
-
-	if (!err) {
-		memcpy(dst, d, dlen);
-		/* Update seed */
-		memcpy(ctx->seed, d + dlen, ctx->slen);
-	}
-	memzero_explicit(d, todo);
-err_free:
-	kfree(d);
-
-	return err;
-}
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index a97a790ae451..3ff0243301fb 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -8,7 +8,6 @@
 #include <crypto/aes.h>
 #include <crypto/des.h>
 #include <crypto/engine.h>
-#include <crypto/rng.h>
 #include <crypto/skcipher.h>
 #include <linux/atomic.h>
 #include <linux/debugfs.h>
@@ -26,7 +25,6 @@
 #define SS_ALG_DES		(1 << 2)
 #define SS_ALG_3DES		(2 << 2)
 #define SS_ALG_MD5		(3 << 2)
-#define SS_ALG_PRNG		(4 << 2)
 #define SS_ALG_SHA1		(6 << 2)
 #define SS_ALG_SHA224		(7 << 2)
 #define SS_ALG_SHA256		(8 << 2)
@@ -67,8 +65,6 @@
 #define SS_FLOW0	BIT(30)
 #define SS_FLOW1	BIT(31)
 
-#define SS_PRNG_CONTINUE	BIT(18)
-
 #define MAX_SG 8
 
 #define MAXFLOW 2
@@ -78,9 +74,6 @@
 #define SS_DIE_ID_SHIFT	20
 #define SS_DIE_ID_MASK	0x07
 
-#define PRNG_DATA_SIZE (160 / 8)
-#define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
-
 /*
  * struct ss_clock - Describe clocks used by sun8i-ss
  * @name:       Name of clock needed by this variant
@@ -214,16 +207,6 @@ struct sun8i_cipher_tfm_ctx {
 	struct crypto_skcipher *fallback_tfm;
 };
 
-/*
- * struct sun8i_ss_prng_ctx - context for PRNG TFM
- * @seed:	The seed to use
- * @slen:	The size of the seed
- */
-struct sun8i_ss_rng_tfm_ctx {
-	void *seed;
-	unsigned int slen;
-};
-
 /*
  * struct sun8i_ss_hash_tfm_ctx - context for an ahash TFM
  * @enginectx:		crypto_engine used by this TFM
@@ -273,7 +256,6 @@ struct sun8i_ss_alg_template {
 	struct sun8i_ss_dev *ss;
 	union {
 		struct skcipher_alg skcipher;
-		struct rng_alg rng;
 		struct ahash_alg hash;
 	} alg;
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_DEBUG
@@ -297,11 +279,6 @@ int sun8i_ss_skencrypt(struct skcipher_request *areq);
 int sun8i_ss_get_engine_number(struct sun8i_ss_dev *ss);
 
 int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx, const char *name);
-int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen);
-int sun8i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen);
-int sun8i_ss_prng_init(struct crypto_tfm *tfm);
-void sun8i_ss_prng_exit(struct crypto_tfm *tfm);
 
 int sun8i_ss_hash_crainit(struct crypto_tfm *tfm);
 void sun8i_ss_hash_craexit(struct crypto_tfm *tfm);
diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
index 6fb1d02c2c30..b7fa3ea7a3be 100644
--- a/drivers/crypto/atmel-ecc.c
+++ b/drivers/crypto/atmel-ecc.c
@@ -360,6 +360,8 @@ static int atmel_ecc_remove(struct i2c_client *client)
 static const struct of_device_id atmel_ecc_dt_ids[] = {
 	{
 		.compatible = "atmel,atecc508a",
+	}, {
+		.compatible = "atmel,atecc608b",
 	}, {
 		/* sentinel */
 	}
@@ -369,6 +371,7 @@ MODULE_DEVICE_TABLE(of, atmel_ecc_dt_ids);
 
 static const struct i2c_device_id atmel_ecc_id[] = {
 	{ "atecc508a" },
+	{ "atecc608b" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, atmel_ecc_id);
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 68078e83d575..41a677a82ed4 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -426,6 +426,7 @@ static void dma_device_release(struct kref *ref)
 
 	list_del_rcu(&device->global_node);
 	dma_channel_rebalance();
+	synchronize_rcu();
 
 	if (device->device_release)
 		device->device_release(device);
@@ -493,10 +494,13 @@ static int dma_chan_get(struct dma_chan *chan)
  */
 static void dma_chan_put(struct dma_chan *chan)
 {
+	struct module *owner;
+
 	/* This channel is not in use, bail out */
 	if (!chan->client_count)
 		return;
 
+	owner = dma_chan_to_owner(chan);
 	chan->client_count--;
 
 	/* This channel is not in use anymore, free it */
@@ -513,8 +517,10 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->route_data = NULL;
 	}
 
-	dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
+	/* This channel is not in use anymore, drop the device ref */
+	if (!chan->client_count)
+		dma_device_put(chan->device);
+	module_put(owner);
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 4eb63f1ad224..8f1eebf608b2 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -543,7 +543,7 @@ mmp_pdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 	for_each_sg(sgl, sg, sg_len, i) {
 		addr = sg_dma_address(sg);
-		avail = sg_dma_len(sgl);
+		avail = sg_dma_len(sg);
 
 		do {
 			len = min_t(size_t, avail, PDMA_MAX_DESC_BYTES);
diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 60115d8d4083..e6ba7f7df863 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -1205,7 +1205,7 @@ static int sprd_dma_probe(struct platform_device *pdev)
 
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0)
-		goto err_rpm;
+		goto err_register;
 
 	ret = dma_async_device_register(&sdev->dma_dev);
 	if (ret < 0) {
@@ -1227,7 +1227,6 @@ static int sprd_dma_probe(struct platform_device *pdev)
 err_register:
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-err_rpm:
 	sprd_dma_disable(sdev);
 	return ret;
 }
diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
index d846309921a7..5652c8ba1b94 100644
--- a/drivers/dma/sun6i-dma.c
+++ b/drivers/dma/sun6i-dma.c
@@ -345,8 +345,10 @@ static size_t sun6i_get_chan_size(struct sun6i_pchan *pchan)
 	size_t bytes;
 	dma_addr_t pos;
 
-	pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
-	bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+	do {
+		pos = readl(pchan->base + DMA_CHAN_LLI_ADDR);
+		bytes = readl(pchan->base + DMA_CHAN_CUR_CNT);
+	} while (pos != readl(pchan->base + DMA_CHAN_LLI_ADDR));
 
 	if (pos == LLI_LAST_ITEM)
 		return bytes;
@@ -929,7 +931,6 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	struct sun6i_pchan *pchan = vchan->phy;
 	struct sun6i_dma_lli *lli;
 	struct virt_dma_desc *vd;
-	struct sun6i_desc *txd;
 	enum dma_status ret;
 	unsigned long flags;
 	size_t bytes = 0;
@@ -941,9 +942,9 @@ static enum dma_status sun6i_dma_tx_status(struct dma_chan *chan,
 	spin_lock_irqsave(&vchan->vc.lock, flags);
 
 	vd = vchan_find_desc(&vchan->vc, cookie);
-	txd = to_sun6i_desc(&vd->tx);
 
 	if (vd) {
+		struct sun6i_desc *txd = to_sun6i_desc(&vd->tx);
 		for (lli = txd->v_lli; lli != NULL; lli = lli->v_lli_next)
 			bytes += lli->len;
 	} else if (!pchan || !pchan->desc) {
diff --git a/drivers/dma/ti/k3-udma-glue.c b/drivers/dma/ti/k3-udma-glue.c
index a367584f0d7b..6c4c25064b5a 100644
--- a/drivers/dma/ti/k3-udma-glue.c
+++ b/drivers/dma/ti/k3-udma-glue.c
@@ -925,8 +925,9 @@ void k3_udma_glue_release_rx_chn(struct k3_udma_glue_rx_channel *rx_chn)
 		rx_chn->psil_paired = false;
 	}
 
-	for (i = 0; i < rx_chn->flow_num; i++)
-		k3_udma_glue_release_rx_flow(rx_chn, i);
+	if (rx_chn->flows)
+		for (i = 0; i < rx_chn->flow_num; i++)
+			k3_udma_glue_release_rx_flow(rx_chn, i);
 
 	if (xudma_rflow_is_gp(rx_chn->common.udmax, rx_chn->flow_id_base))
 		xudma_free_gp_rflow_range(rx_chn->common.udmax,
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 44d897f2b0f0..b5b0a73e8002 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -725,15 +725,25 @@ xilinx_aximcdma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	return segment;
 }
 
-static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
+static void xilinx_dma_clean_hw_desc(struct xilinx_dma_chan *chan,
+				     struct xilinx_axidma_tx_segment *segment)
 {
-	u32 next_desc = hw->next_desc;
-	u32 next_desc_msb = hw->next_desc_msb;
+	dma_addr_t next;
+	u32 i;
 
-	memset(hw, 0, sizeof(struct xilinx_axidma_desc_hw));
+	/*
+	 * Restore the buffer descriptor's next descriptor pointer to the value
+	 * set up in xilinx_dma_alloc_chan_resources(). Otherwise using the DMA
+	 * in cyclic mode leaves the next descriptor pointer altered and
+	 * prevents subsequent non-cyclic transfers.
+	 */
+	i = segment - chan->seg_v;
+	next = chan->seg_p +
+	       sizeof(*chan->seg_v) * ((i + 1) % XILINX_DMA_NUM_DESCS);
 
-	hw->next_desc = next_desc;
-	hw->next_desc_msb = next_desc_msb;
+	memset(&segment->hw, 0, sizeof(segment->hw));
+	segment->hw.next_desc = lower_32_bits(next);
+	segment->hw.next_desc_msb = upper_32_bits(next);
 }
 
 static void xilinx_mcdma_clean_hw_desc(struct xilinx_aximcdma_desc_hw *hw)
@@ -755,7 +765,7 @@ static void xilinx_mcdma_clean_hw_desc(struct xilinx_aximcdma_desc_hw *hw)
 static void xilinx_dma_free_tx_segment(struct xilinx_dma_chan *chan,
 				struct xilinx_axidma_tx_segment *segment)
 {
-	xilinx_dma_clean_hw_desc(&segment->hw);
+	xilinx_dma_clean_hw_desc(chan, segment);
 
 	list_add_tail(&segment->node, &chan->free_seg_list);
 }
@@ -889,9 +899,9 @@ static void xilinx_dma_free_descriptors(struct xilinx_dma_chan *chan)
 
 	spin_lock_irqsave(&chan->lock, flags);
 
-	xilinx_dma_free_desc_list(chan, &chan->pending_list);
 	xilinx_dma_free_desc_list(chan, &chan->done_list);
 	xilinx_dma_free_desc_list(chan, &chan->active_list);
+	xilinx_dma_free_desc_list(chan, &chan->pending_list);
 
 	spin_unlock_irqrestore(&chan->lock, flags);
 }
diff --git a/drivers/edac/edac_device_sysfs.c b/drivers/edac/edac_device_sysfs.c
index 5e7593753799..b94322369116 100644
--- a/drivers/edac/edac_device_sysfs.c
+++ b/drivers/edac/edac_device_sysfs.c
@@ -90,14 +90,21 @@ static ssize_t edac_device_ctl_poll_msec_store(struct edac_device_ctl_info
 					*ctl_info, const char *data,
 					size_t count)
 {
-	unsigned long value;
+	unsigned int value;
+	int ret;
 
 	/* get the value and enforce that it is non-zero, must be at least
 	 * one millisecond for the delay period, between scans
 	 * Then cancel last outstanding delay for the work request
 	 * and set a new one.
 	 */
-	value = simple_strtoul(data, NULL, 0);
+	ret = kstrtouint(data, 0, &value);
+	if (ret < 0)
+		return ret;
+
+	if (value < 1)
+		return -EINVAL;
+
 	edac_device_reset_delay_period(ctl_info, value);
 
 	return count;
diff --git a/drivers/firmware/arm_scmi/base.c b/drivers/firmware/arm_scmi/base.c
index e51d28ba2833..9cb95ebda50e 100644
--- a/drivers/firmware/arm_scmi/base.c
+++ b/drivers/firmware/arm_scmi/base.c
@@ -280,6 +280,8 @@ static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
 					  void *report, u32 *src_id)
 {
 	int i;
+	u32 error_status;
+	size_t expected_sz;
 	const struct scmi_base_error_notify_payld *p = payld;
 	struct scmi_base_error_report *r = report;
 
@@ -293,10 +295,19 @@ static void *scmi_base_fill_custom_report(const struct scmi_handle *handle,
 	if (evt_id != SCMI_EVENT_BASE_ERROR_EVENT || sizeof(*p) < payld_sz)
 		return NULL;
 
+	expected_sz = offsetof(typeof(*p), msg_reports);
+	if (payld_sz < expected_sz)
+		return NULL;
+
 	r->timestamp = timestamp;
 	r->agent_id = le32_to_cpu(p->agent_id);
-	r->fatal = IS_FATAL_ERROR(le32_to_cpu(p->error_status));
-	r->cmd_count = ERROR_CMD_COUNT(le32_to_cpu(p->error_status));
+	error_status = le32_to_cpu(p->error_status);
+	r->fatal = IS_FATAL_ERROR(error_status);
+	r->cmd_count = ERROR_CMD_COUNT(error_status);
+	expected_sz += r->cmd_count * sizeof(p->msg_reports[0]);
+	if (payld_sz < expected_sz)
+		return NULL;
+
 	for (i = 0; i < r->cmd_count; i++)
 		r->reports[i] = le64_to_cpu(p->msg_reports[i]);
 	*src_id = 0;
diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index 3a1d77b882f7..1ff0e759c6be 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -627,8 +627,8 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	if (ret)
 		return ERR_PTR(ret);
 
-	if (!buf.opp_count)
-		return ERR_PTR(-ENOENT);
+	if (!buf.opp_count || buf.opp_count > MAX_DVFS_OPPS)
+		return ERR_PTR(-EINVAL);
 
 	info = kmalloc(sizeof(*info), GFP_KERNEL);
 	if (!info)
diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index 2bc173c352ce..64bda1add9c1 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -118,8 +118,12 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
 	if (value)
 		value = ARIZONA_GPN_LVL;
 
-	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
-				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
+	ret = regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
+				 ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
+	if (ret < 0 && (val & ARIZONA_GPN_DIR) && persistent)
+		pm_runtime_put_autosuspend(chip->parent);
+
+	return ret;
 }
 
 static void arizona_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
index ea2e2618b794..d6240ae0f87c 100644
--- a/drivers/gpio/gpio-dwapb.c
+++ b/drivers/gpio/gpio-dwapb.c
@@ -189,6 +189,22 @@ static void dwapb_toggle_trigger(struct dwapb_gpio *gpio, unsigned int offs)
 	dwapb_write(gpio, GPIO_INT_POLARITY, pol);
 }
 
+static int dwapb_irq_init_hw(struct gpio_chip *gc)
+{
+	struct dwapb_gpio *gpio = to_dwapb_gpio(gc);
+
+	/*
+	 * GPIO interrupts may retain stale state across warm reboots when
+	 * peripherals stay powered. Force a known-safe state before the GPIO
+	 * irqchip and irq domain are set up.
+	 */
+	dwapb_write(gpio, GPIO_INTEN, 0);
+	dwapb_write(gpio, GPIO_INTMASK, 0xffffffff);
+	dwapb_write(gpio, GPIO_PORTA_EOI, 0xffffffff);
+
+	return 0;
+}
+
 static u32 dwapb_do_irq(struct dwapb_gpio *gpio)
 {
 	struct gpio_chip *gc = &gpio->ports[0].gc;
@@ -428,6 +444,7 @@ static void dwapb_configure_irqs(struct dwapb_gpio *gpio,
 	girq = &gc->irq;
 	girq->handler = handle_bad_irq;
 	girq->default_type = IRQ_TYPE_NONE;
+	girq->init_hw = dwapb_irq_init_hw;
 
 	port->pirq = pirq;
 	pirq->irqchip.name = DWAPB_DRIVER_NAME;
diff --git a/drivers/gpio/gpio-pisosr.c b/drivers/gpio/gpio-pisosr.c
index 8e04054cf07e..9d0dfc8b985f 100644
--- a/drivers/gpio/gpio-pisosr.c
+++ b/drivers/gpio/gpio-pisosr.c
@@ -128,6 +128,7 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
 	struct pisosr_gpio *gpio;
+	u32 ngpios;
 	int ret;
 
 	gpio = devm_kzalloc(dev, sizeof(*gpio), GFP_KERNEL);
@@ -138,7 +139,8 @@ static int pisosr_gpio_probe(struct spi_device *spi)
 
 	gpio->chip = template_chip;
 	gpio->chip.parent = dev;
-	of_property_read_u16(dev->of_node, "ngpios", &gpio->chip.ngpio);
+	if (!of_property_read_u32(dev->of_node, "ngpios", &ngpios))
+		gpio->chip.ngpio = ngpios;
 
 	gpio->spi = spi;
 
diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
index 7f73f775d6ba..67cbca8dc17d 100644
--- a/drivers/gpio/gpio-zynq.c
+++ b/drivers/gpio/gpio-zynq.c
@@ -793,15 +793,7 @@ static int __maybe_unused zynq_gpio_runtime_resume(struct device *dev)
 
 static int zynq_gpio_request(struct gpio_chip *chip, unsigned int offset)
 {
-	int ret;
-
-	ret = pm_runtime_get_sync(chip->parent);
-
-	/*
-	 * If the device is already active pm_runtime_get() will return 1 on
-	 * success, but gpio_request still needs to return 0.
-	 */
-	return ret < 0 ? ret : 0;
+	return pm_runtime_resume_and_get(chip->parent);
 }
 
 static void zynq_gpio_free(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index addeda42339f..536935fbeb67 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -100,7 +100,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	struct amdgpu_vm *vm = &fpriv->vm;
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
-	unsigned size, num_ibs = 0;
+	size_t size;
+	unsigned int num_ibs = 0;
 	uint32_t uf_offset = 0;
 	int i;
 	int ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/atom.c b/drivers/gpu/drm/amd/amdgpu/atom.c
index c1841fa873f5..97d5ec258033 100644
--- a/drivers/gpu/drm/amd/amdgpu/atom.c
+++ b/drivers/gpu/drm/amd/amdgpu/atom.c
@@ -1225,10 +1225,15 @@ static int amdgpu_atom_execute_table_locked(struct atom_context *ctx, int index,
 	ectx.ps = params;
 	ectx.abort = false;
 	ectx.last_jump = 0;
-	if (ws)
+	if (ws) {
 		ectx.ws = kcalloc(4, ws, GFP_KERNEL);
-	else
+		if (!ectx.ws) {
+			ret = -ENOMEM;
+			goto free;
+		}
+	} else {
 		ectx.ws = NULL;
+	}
 
 	debug_depth++;
 	while (1) {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bd15de4dee75..b8dc14ea4203 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8448,6 +8448,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 	/* Release extra reference */
 	if (new_stream)
 		 dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 04c20ce6e94d..2658339ad8cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -176,8 +176,13 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		 */
 		ret = wait_for_completion_interruptible_timeout(
 			&commit->hw_done, 10 * HZ);
-		if (ret)
+		if (ret < 0)
+			goto cleanup;
+
+		if (ret == 0) {
+			ret = -ETIMEDOUT;
 			goto cleanup;
+		}
 	}
 
 	enable = amdgpu_dm_is_valid_crc_source(source);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 8b27ccae62b3..042167b10e07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -185,7 +185,6 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 	char *rd_buf_ptr = NULL;
 	const uint32_t rd_buf_size = 100;
 	uint32_t result = 0;
-	uint8_t str_len = 0;
 	int r;
 
 	if (*pos & 3 || size & 3)
@@ -197,29 +196,26 @@ static ssize_t dp_link_settings_read(struct file *f, char __user *buf,
 
 	rd_buf_ptr = rd_buf;
 
-	str_len = strlen("Current:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Current:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Current:  %d  0x%x  %d  ",
 			link->cur_link_settings.lane_count,
 			link->cur_link_settings.link_rate,
 			link->cur_link_settings.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Verified:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Verified:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Verified:  %d  0x%x  %d  ",
 			link->verified_link_cap.lane_count,
 			link->verified_link_cap.link_rate,
 			link->verified_link_cap.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Reported:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Reported:  %d  0x%x  %d  ",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Reported:  %d  0x%x  %d  ",
 			link->reported_link_cap.lane_count,
 			link->reported_link_cap.link_rate,
 			link->reported_link_cap.link_spread);
-	rd_buf_ptr += str_len;
 
-	str_len = strlen("Preferred:  %d  0x%x  %d  ");
-	snprintf(rd_buf_ptr, str_len, "Preferred:  %d  0x%x  %d\n",
+	rd_buf_ptr += scnprintf(rd_buf_ptr, rd_buf_size - (rd_buf_ptr - rd_buf),
+			"Preferred:  %d  0x%x  %d\n",
 			link->preferred_link_setting.lane_count,
 			link->preferred_link_setting.link_rate,
 			link->preferred_link_setting.link_spread);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index 47d18f129cac..f4bb4d2c3f77 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -7143,6 +7143,7 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 	struct evergreen_power_info *eg_pi = evergreen_get_pi(adev);
 	struct si_power_info *si_pi = si_get_pi(adev);
 	struct  si_ps *ps = si_get_ps(rps);
+	struct amdgpu_clock_and_voltage_limits *limits;
 	u16 leakage_voltage;
 	struct rv7xx_pl *pl = &ps->performance_levels[index];
 	int ret;
@@ -7202,12 +7203,30 @@ static void si_parse_pplib_clock_info(struct amdgpu_device *adev,
 		si_pi->mvdd_bootup_value = mvdd;
 	}
 
+	/*
+	 * Update maximum allowed clock limits.
+	 * VBIOS can contain conflicting values between:
+	 * - the maximum allowed clocks and voltages on AC or DC
+	 * - the clocks and voltages in power states on AC or DC
+	 */
 	if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
-	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE) {
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.sclk = pl->sclk;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.mclk = pl->mclk;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddc = pl->vddc;
-		adev->pm.dpm.dyn_state.max_clock_voltage_on_ac.vddci = pl->vddci;
+	    ATOM_PPLIB_CLASSIFICATION_UI_PERFORMANCE)
+		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_ac;
+	else if ((rps->class & ATOM_PPLIB_CLASSIFICATION_UI_MASK) ==
+		 ATOM_PPLIB_CLASSIFICATION_UI_BATTERY)
+		limits = &adev->pm.dpm.dyn_state.max_clock_voltage_on_dc;
+	else
+		limits = NULL;
+
+	if (limits) {
+		if (pl->sclk > limits->sclk)
+			limits->sclk = pl->sclk;
+		if (pl->mclk > limits->mclk)
+			limits->mclk = pl->mclk;
+		if (pl->vddc > limits->vddc)
+			limits->vddc = pl->vddc;
+		if (pl->vddci > limits->vddci)
+			limits->vddci = pl->vddci;
 	}
 }
 
@@ -7576,7 +7595,7 @@ static int si_dpm_process_interrupt(struct amdgpu_device *adev,
 		break;
 	}
 
-	if (queue_thermal)
+	if (queue_thermal && amdgpu_dpm)
 		schedule_work(&adev->pm.dpm.thermal.work);
 
 	return 0;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
index 1d767473ba8a..e5eead150538 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
@@ -334,7 +334,11 @@ void komeda_dev_destroy(struct komeda_dev *mdev)
 
 int komeda_dev_resume(struct komeda_dev *mdev)
 {
-	clk_prepare_enable(mdev->aclk);
+	int err;
+
+	err = clk_prepare_enable(mdev->aclk);
+	if (err)
+		return err;
 
 	mdev->funcs->enable_irq(mdev);
 
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
index e7933930a657..b7848e4f03fa 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
@@ -61,8 +61,11 @@ static int komeda_bind(struct device *dev)
 	}
 
 	pm_runtime_enable(dev);
-	if (!pm_runtime_enabled(dev))
-		komeda_dev_resume(mdrv->mdev);
+	if (!pm_runtime_enabled(dev)) {
+		err = komeda_dev_resume(mdrv->mdev);
+		if (err)
+			goto err_destroy_mdev;
+	}
 
 	mdrv->kms = komeda_kms_attach(mdrv->mdev);
 	if (IS_ERR(mdrv->kms)) {
@@ -79,7 +82,7 @@ static int komeda_bind(struct device *dev)
 		pm_runtime_disable(dev);
 	else
 		komeda_dev_suspend(mdrv->mdev);
-
+err_destroy_mdev:
 	komeda_dev_destroy(mdrv->mdev);
 
 free_mdrv:
@@ -176,11 +179,12 @@ static int __maybe_unused komeda_pm_suspend(struct device *dev)
 static int __maybe_unused komeda_pm_resume(struct device *dev)
 {
 	struct komeda_drv *mdrv = dev_get_drvdata(dev);
+	int err = 0;
 
 	if (!pm_runtime_status_suspended(dev))
-		komeda_dev_resume(mdrv->mdev);
+		err = komeda_dev_resume(mdrv->mdev);
 
-	return drm_mode_config_helper_resume(&mdrv->kms->base);
+	return err ? err : drm_mode_config_helper_resume(&mdrv->kms->base);
 }
 
 static const struct dev_pm_ops komeda_pm_ops = {
diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
index 69fee05c256c..c547d1300208 100644
--- a/drivers/gpu/drm/arm/malidp_drv.c
+++ b/drivers/gpu/drm/arm/malidp_drv.c
@@ -670,6 +670,11 @@ static int malidp_runtime_pm_suspend(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 	struct malidp_hw_device *hwdev = malidp->dev;
+	struct clk_bulk_data clks[] = {
+		{ .clk = hwdev->pclk },
+		{ .clk = hwdev->aclk },
+		{ .clk = hwdev->mclk },
+	};
 
 	/* we can only suspend if the hardware is in config mode */
 	WARN_ON(!hwdev->hw->in_config_mode(hwdev));
@@ -677,9 +682,7 @@ static int malidp_runtime_pm_suspend(struct device *dev)
 	malidp_se_irq_fini(hwdev);
 	malidp_de_irq_fini(hwdev);
 	hwdev->pm_suspended = true;
-	clk_disable_unprepare(hwdev->mclk);
-	clk_disable_unprepare(hwdev->aclk);
-	clk_disable_unprepare(hwdev->pclk);
+	clk_bulk_disable_unprepare(ARRAY_SIZE(clks), clks);
 
 	return 0;
 }
@@ -689,10 +692,17 @@ static int malidp_runtime_pm_resume(struct device *dev)
 	struct drm_device *drm = dev_get_drvdata(dev);
 	struct malidp_drm *malidp = drm->dev_private;
 	struct malidp_hw_device *hwdev = malidp->dev;
+	struct clk_bulk_data clks[] = {
+		{ .clk = hwdev->pclk },
+		{ .clk = hwdev->aclk },
+		{ .clk = hwdev->mclk },
+	};
+	int err;
+
+	err = clk_bulk_prepare_enable(ARRAY_SIZE(clks), clks);
+	if (err)
+		return err;
 
-	clk_prepare_enable(hwdev->pclk);
-	clk_prepare_enable(hwdev->aclk);
-	clk_prepare_enable(hwdev->mclk);
 	hwdev->pm_suspended = false;
 	malidp_de_irq_hw_init(hwdev);
 	malidp_se_irq_hw_init(hwdev);
diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
index 5873b37f0d26..f6e3ba409121 100644
--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -1163,10 +1163,12 @@ static int prepare_signaling(struct drm_device *dev,
 			struct dma_fence *fence;
 			struct drm_out_fence_state *f;
 
+			ret = -ENOMEM;
+
 			f = krealloc(*fence_state, sizeof(**fence_state) *
 				     (*num_fences + 1), GFP_KERNEL);
 			if (!f)
-				return -ENOMEM;
+				goto err_free_event;
 
 			memset(&f[*num_fences], 0, sizeof(*f));
 
@@ -1175,12 +1177,12 @@ static int prepare_signaling(struct drm_device *dev,
 
 			fence = drm_crtc_create_fence(crtc);
 			if (!fence)
-				return -ENOMEM;
+				goto err_free_event;
 
 			ret = setup_out_fence(&f[(*num_fences)++], fence);
 			if (ret) {
 				dma_fence_put(fence);
-				return ret;
+				goto err_free_event;
 			}
 
 			crtc_state->event->base.fence = fence;
@@ -1234,6 +1236,11 @@ static int prepare_signaling(struct drm_device *dev,
 		return -EINVAL;
 
 	return 0;
+
+err_free_event:
+	drm_event_cancel_free(dev, &crtc_state->event->base);
+	crtc_state->event = NULL;
+	return ret;
 }
 
 static void complete_signaling(struct drm_device *dev,
diff --git a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
index fc9a34ed58bd..48a2adba9487 100644
--- a/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_hdmi_i2c.c
@@ -95,6 +95,7 @@ static int xfer_read(struct i2c_adapter *adap, struct i2c_msg *pmsg)
 	struct oaktrail_hdmi_dev *hdmi_dev = i2c_get_adapdata(adap);
 	struct hdmi_i2c_dev *i2c_dev = hdmi_dev->i2c_dev;
 	u32 temp;
+	int ret;
 
 	i2c_dev->status = I2C_STAT_INIT;
 	i2c_dev->msg = pmsg;
@@ -106,9 +107,14 @@ static int xfer_read(struct i2c_adapter *adap, struct i2c_msg *pmsg)
 	HDMI_WRITE(HDMI_HI2CHCR, temp);
 	HDMI_READ(HDMI_HI2CHCR);
 
-	while (i2c_dev->status != I2C_TRANSACTION_DONE)
-		wait_for_completion_interruptible_timeout(&i2c_dev->complete,
+	while (i2c_dev->status != I2C_TRANSACTION_DONE) {
+		ret = wait_for_completion_interruptible_timeout(&i2c_dev->complete,
 								10 * HZ);
+		if (ret < 0)
+			return ret;
+		if (!ret)
+			return -ETIMEDOUT;
+	}
 
 	return 0;
 }
@@ -127,7 +133,7 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapter *adap,
 {
 	struct oaktrail_hdmi_dev *hdmi_dev = i2c_get_adapdata(adap);
 	struct hdmi_i2c_dev *i2c_dev = hdmi_dev->i2c_dev;
-	int i;
+	int i, ret = 0;
 
 	mutex_lock(&i2c_dev->i2c_lock);
 
@@ -139,9 +145,11 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapter *adap,
 	for (i = 0; i < num; i++) {
 		if (pmsg->len && pmsg->buf) {
 			if (pmsg->flags & I2C_M_RD)
-				xfer_read(adap, pmsg);
+				ret = xfer_read(adap, pmsg);
 			else
-				xfer_write(adap, pmsg);
+				ret = xfer_write(adap, pmsg);
+			if (ret)
+				break;
 		}
 		pmsg++;         /* next message */
 	}
@@ -151,6 +159,9 @@ static int oaktrail_hdmi_i2c_access(struct i2c_adapter *adap,
 
 	mutex_unlock(&i2c_dev->i2c_lock);
 
+	if (ret)
+		return ret;
+
 	return i;
 }
 
diff --git a/drivers/gpu/drm/i915/i915_query.c b/drivers/gpu/drm/i915/i915_query.c
index fed337ad7b68..d5a7b38157e0 100644
--- a/drivers/gpu/drm/i915/i915_query.c
+++ b/drivers/gpu/drm/i915/i915_query.c
@@ -364,8 +364,10 @@ static int query_perf_config_list(struct drm_i915_private *i915,
 		ids = krealloc(oa_config_ids,
 			       n_configs * sizeof(*oa_config_ids),
 			       GFP_KERNEL);
-		if (!ids)
+		if (!ids) {
+			kfree(oa_config_ids);
 			return -ENOMEM;
+		}
 
 		alloc = fetch_and_zero(&n_configs);
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 773bd463ad47..83d5917180e1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -959,6 +959,8 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 	for (i = 0; i < ARRAY_SIZE(adreno_gpu->info->fw); i++)
 		release_firmware(adreno_gpu->fw[i]);
 
+	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
+
 	if (priv && pm_runtime_enabled(&priv->gpu_pdev->dev))
 		pm_runtime_disable(&priv->gpu_pdev->dev);
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index 8a38d4b95102..cfaf9c26a905 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -169,13 +169,13 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 
 	ret = msm_hdmi_phy_resource_enable(phy);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	ret = msm_hdmi_phy_pll_init(pdev, phy->cfg->type);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "couldn't init PLL\n");
 		msm_hdmi_phy_resource_disable(phy);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	msm_hdmi_phy_resource_disable(phy);
@@ -183,6 +183,10 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static int msm_hdmi_phy_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/nouveau/nouveau_drm.c b/drivers/gpu/drm/nouveau/nouveau_drm.c
index 8e15ff95b809..7c61e8caab2f 100644
--- a/drivers/gpu/drm/nouveau/nouveau_drm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
@@ -640,6 +640,7 @@ nouveau_drm_device_fini(struct drm_device *dev)
 	if (nouveau_pmops_runtime()) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	nouveau_led_fini(dev);
@@ -1118,10 +1119,8 @@ nouveau_drm_open(struct drm_device *dev, struct drm_file *fpriv)
 	mutex_unlock(&drm->clients_lock);
 
 done:
-	if (ret && cli) {
-		nouveau_cli_fini(cli);
+	if (ret && cli)
 		kfree(cli);
-	}
 
 	pm_runtime_mark_last_busy(dev->dev);
 	pm_runtime_put_autosuspend(dev->dev);
diff --git a/drivers/gpu/drm/nouveau/nouveau_gem.c b/drivers/gpu/drm/nouveau/nouveau_gem.c
index 93c1afff5e90..6e8461631136 100644
--- a/drivers/gpu/drm/nouveau/nouveau_gem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_gem.c
@@ -421,6 +421,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			if (unlikely(ret)) {
 				if (ret != -ERESTARTSYS)
 					NV_PRINTK(err, cli, "fail reserve\n");
+				drm_gem_object_put(gem);
 				break;
 			}
 		}
@@ -430,6 +431,7 @@ validate_init(struct nouveau_channel *chan, struct drm_file *file_priv,
 			struct nouveau_vma *vma = nouveau_vma_find(nvbo, vmm);
 			if (!vma) {
 				NV_PRINTK(err, cli, "vma not found!\n");
+				drm_gem_object_put(gem);
 				ret = -EINVAL;
 				break;
 			}
diff --git a/drivers/gpu/drm/nouveau/nvif/vmm.c b/drivers/gpu/drm/nouveau/nvif/vmm.c
index 6053d6dc2184..108f229087e6 100644
--- a/drivers/gpu/drm/nouveau/nvif/vmm.c
+++ b/drivers/gpu/drm/nouveau/nvif/vmm.c
@@ -108,6 +108,7 @@ void
 nvif_vmm_dtor(struct nvif_vmm *vmm)
 {
 	kfree(vmm->page);
+	vmm->page = NULL;
 	nvif_object_dtor(&vmm->object);
 }
 
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
index 5214fd0658b8..0927f4b25d67 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/clk/base.c
@@ -199,16 +199,18 @@ nvkm_cstate_prog(struct nvkm_clk *clk, struct nvkm_pstate *pstate, int cstatei)
 	}
 
 	if (volt) {
-		ret = nvkm_volt_set_id(volt, cstate->voltage,
-				       pstate->base.voltage, clk->temp, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower voltage: %d\n", ret);
+		int err = nvkm_volt_set_id(volt, cstate->voltage,
+					   pstate->base.voltage, clk->temp, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower voltage: %d\n", err);
 	}
 
 	if (therm) {
-		ret = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
-		if (ret && ret != -ENODEV)
-			nvkm_error(subdev, "failed to lower fan speed: %d\n", ret);
+		int err = nvkm_therm_cstate(therm, pstate->fanspeed, -1);
+
+		if (err && err != -ENODEV)
+			nvkm_error(subdev, "failed to lower fan speed: %d\n", err);
 	}
 
 	return ret;
@@ -474,6 +476,7 @@ static int
 nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 {
 	struct nvkm_pstate *pstate;
+	bool found = false;
 	int i = 0;
 
 	if (!clk->allow_reclock)
@@ -481,12 +484,14 @@ nvkm_clk_ustate_update(struct nvkm_clk *clk, int req)
 
 	if (req != -1 && req != -2) {
 		list_for_each_entry(pstate, &clk->states, head) {
-			if (pstate->pstate == req)
+			if (pstate->pstate == req) {
+				found = true;
 				break;
+			}
 			i++;
 		}
 
-		if (pstate->pstate != req)
+		if (!found)
 			return -EINVAL;
 		req = i;
 	}
diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
index 18241c6ba5fa..4d52a158f320 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/fb/ramnv1a.c
@@ -51,6 +51,8 @@ nv1a_ram_new(struct nvkm_fb *fb, struct nvkm_ram **pram)
 		mib = ((mem >> 4) & 127) + 1;
 	}
 
+	pci_dev_put(bridge);
+
 	return nvkm_ram_new_(&nv04_ram_func, fb, NVKM_RAM_TYPE_STOLEN,
 			     mib * 1024 * 1024, pram);
 }
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a59adc08267f..0c18c0cc701c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -686,6 +686,31 @@ static const struct panel_desc ampire_am_1280800n3tzqw_t00h = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode ampire_am_1280800w8tzqw_t00h_mode = {
+	.clock = 72400,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 40,
+	.hsync_end = 1280 + 40 + 80,
+	.htotal = 1280 + 40 + 80 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 10,
+	.vsync_end = 800 + 10 + 18,
+	.vtotal = 800 + 10 + 18 + 10,
+};
+
+static const struct panel_desc ampire_am_1280800w8tzqw_t00h = {
+	.modes = &ampire_am_1280800w8tzqw_t00h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode ampire_am_480272h3tmqw_t01h_mode = {
 	.clock = 9000,
 	.hdisplay = 480,
@@ -3921,6 +3946,9 @@ static const struct of_device_id platform_of_match[] = {
 	{
 		.compatible = "ampire,am-1280800n3tzqw-t00h",
 		.data = &ampire_am_1280800n3tzqw_t00h,
+	}, {
+		.compatible = "ampire,am-1280800w8tzqw-t00h",
+		.data = &ampire_am_1280800w8tzqw_t00h,
 	}, {
 		.compatible = "ampire,am-480272h3tmqw-t01h",
 		.data = &ampire_am_480272h3tmqw_t01h,
diff --git a/drivers/gpu/drm/virtio/virtgpu_display.c b/drivers/gpu/drm/virtio/virtgpu_display.c
index 9b2b99e85342..64025fd694dd 100644
--- a/drivers/gpu/drm/virtio/virtgpu_display.c
+++ b/drivers/gpu/drm/virtio/virtgpu_display.c
@@ -315,7 +315,7 @@ virtio_gpu_user_framebuffer_create(struct drm_device *dev,
 	if (ret) {
 		kfree(virtio_gpu_fb);
 		drm_gem_object_put(obj);
-		return NULL;
+		return ERR_PTR(ret);
 	}
 
 	return &virtio_gpu_fb->base;
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 2fb41be0f3c9..d462ebc5103d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -45,7 +45,7 @@ static int virtio_gpu_gem_create(struct drm_file *file,
 
 	ret = drm_gem_handle_create(file, &obj->base.base, &handle);
 	if (ret) {
-		drm_gem_object_release(&obj->base.base);
+		drm_gem_object_put(&obj->base.base);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index 36efa273155d..8a445c851960 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -276,7 +276,7 @@ static int virtio_gpu_resource_create_ioctl(struct drm_device *dev, void *data,
 
 	ret = drm_gem_handle_create(file, obj, &handle);
 	if (ret) {
-		drm_gem_object_release(obj);
+		drm_gem_object_put(obj);
 		return ret;
 	}
 
diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index 8302078fe5fa..69b9559894f1 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -407,6 +407,8 @@ static int u1_raw_event(struct alps_dev *hdata, u8 *data, int size)
 		return 1;
 
 	case U1_SP_ABSOLUTE_REPORT_ID:
+		if (!hdata->input2)
+			return 0;
 		sp_x = get_unaligned_le16(data+2);
 		sp_y = get_unaligned_le16(data+4);
 
@@ -738,7 +740,6 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 			goto exit;
 		}
 
-		data->input2 = input2;
 		input2->phys = input->phys;
 		input2->name = "DualPoint Stick";
 		input2->id.bustype = BUS_I2C;
@@ -762,11 +763,12 @@ static int alps_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		__set_bit(INPUT_PROP_POINTER, input2->propbit);
 		__set_bit(INPUT_PROP_POINTING_STICK, input2->propbit);
 
-		if (input_register_device(data->input2)) {
+		if (input_register_device(input2)) {
 			input_free_device(input2);
 			ret = -ENOENT;
 			goto exit;
 		}
+		data->input2 = input2;
 	}
 
 exit:
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index b9f64e374488..3fdea2a59ce2 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -456,6 +456,25 @@ static int mousevsc_hid_raw_request(struct hid_device *hid,
 	return 0;
 }
 
+static int mousevsc_hid_probe(struct hid_device *hid_dev, const struct hid_device_id *id)
+{
+	int ret;
+
+	ret = hid_parse(hid_dev);
+	if (ret) {
+		hid_err(hid_dev, "parse failed\n");
+		return ret;
+	}
+
+	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
+	if (ret) {
+		hid_err(hid_dev, "hw start failed\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static struct hid_ll_driver mousevsc_ll_driver = {
 	.parse = mousevsc_hid_parse,
 	.open = mousevsc_hid_open,
@@ -465,7 +484,16 @@ static struct hid_ll_driver mousevsc_ll_driver = {
 	.raw_request = mousevsc_hid_raw_request,
 };
 
-static struct hid_driver mousevsc_hid_driver;
+static const struct hid_device_id mousevsc_devices[] = {
+	{ HID_DEVICE(BUS_VIRTUAL, HID_GROUP_ANY, 0x045E, 0x0621) },
+	{ }
+};
+
+static struct hid_driver mousevsc_hid_driver = {
+	.name = "hid-hyperv",
+	.id_table = mousevsc_devices,
+	.probe = mousevsc_hid_probe,
+};
 
 static int mousevsc_probe(struct hv_device *device,
 			const struct hv_vmbus_device_id *dev_id)
@@ -507,7 +535,6 @@ static int mousevsc_probe(struct hv_device *device,
 	}
 
 	hid_dev->ll_driver = &mousevsc_ll_driver;
-	hid_dev->driver = &mousevsc_hid_driver;
 	hid_dev->bus = BUS_VIRTUAL;
 	hid_dev->vendor = input_dev->hid_dev_info.vendor;
 	hid_dev->product = input_dev->hid_dev_info.product;
@@ -522,20 +549,6 @@ static int mousevsc_probe(struct hv_device *device,
 	if (ret)
 		goto probe_err2;
 
-
-	ret = hid_parse(hid_dev);
-	if (ret) {
-		hid_err(hid_dev, "parse failed\n");
-		goto probe_err2;
-	}
-
-	ret = hid_hw_start(hid_dev, HID_CONNECT_HIDINPUT | HID_CONNECT_HIDDEV);
-
-	if (ret) {
-		hid_err(hid_dev, "hw start failed\n");
-		goto probe_err2;
-	}
-
 	device_init_wakeup(&device->device, true);
 
 	input_dev->connected = true;
@@ -615,12 +628,23 @@ static struct  hv_driver mousevsc_drv = {
 
 static int __init mousevsc_init(void)
 {
-	return vmbus_driver_register(&mousevsc_drv);
+	int ret;
+
+	ret = hid_register_driver(&mousevsc_hid_driver);
+	if (ret)
+		return ret;
+
+	ret = vmbus_driver_register(&mousevsc_drv);
+	if (ret)
+		hid_unregister_driver(&mousevsc_hid_driver);
+
+	return ret;
 }
 
 static void __exit mousevsc_exit(void)
 {
 	vmbus_driver_unregister(&mousevsc_drv);
+	hid_unregister_driver(&mousevsc_hid_driver);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 549675b200b9..553b7d84e5a2 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1084,6 +1084,9 @@
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
 #define USB_DEVICE_ID_SAMSUNG_WIRELESS_KBD_MOUSE	0x0600
 
+#define USB_VENDOR_ID_SDINNOVATION		0x36ae
+#define USB_DEVICE_ID_SDINNOVATION_GAMING_KBD	0xfeab
+
 #define USB_VENDOR_ID_SEMICO			0x1a2c
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD	0x0023
 #define USB_DEVICE_ID_SEMICO_USB_KEYKOARD2	0x0027
diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 8b05aad21970..2333a24c9df1 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -306,6 +306,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
 	}
 
 exit:
+	hidpp->send_receive_buf = NULL;
 	mutex_unlock(&hidpp->send_mutex);
 	return ret;
 
@@ -3308,8 +3309,7 @@ static int hidpp_input_configured(struct hid_device *hdev,
 static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 		int size)
 {
-	struct hidpp_report *question = hidpp->send_receive_buf;
-	struct hidpp_report *answer = hidpp->send_receive_buf;
+	struct hidpp_report *question, *answer;
 	struct hidpp_report *report = (struct hidpp_report *)data;
 	int ret;
 
@@ -3318,6 +3318,12 @@ static int hidpp_raw_hidpp_event(struct hidpp_device *hidpp, u8 *data,
 	 * previously sent command.
 	 */
 	if (unlikely(mutex_is_locked(&hidpp->send_mutex))) {
+		question = hidpp->send_receive_buf;
+		answer = hidpp->send_receive_buf;
+
+		if (!question)
+			return 0;
+
 		/*
 		 * Check for a correct hidpp20 answer or the corresponding
 		 * error
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 3a7b23175909..cb3fbbc35ce4 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -171,6 +171,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X52_PRO), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SAITEK, USB_DEVICE_ID_SAITEK_X65), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SDINNOVATION, USB_DEVICE_ID_SDINNOVATION_GAMING_KBD), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD2), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 2af820c31ec8..374719d28f9e 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -102,8 +102,9 @@ static int wacom_wac_pen_serial_enforce(struct hid_device *hdev,
 
 	/* Queue events which have invalid tool type or serial number */
 	for (i = 0; i < report->maxfield; i++) {
-		for (j = 0; j < report->field[i]->maxusage; j++) {
-			struct hid_field *field = report->field[i];
+		struct hid_field *field = report->field[i];
+
+		for (j = 0; j < field->report_count; j++) {
 			struct hid_usage *usage = &field->usage[j];
 			unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 			unsigned int offset;
diff --git a/drivers/hwmon/adt7462.c b/drivers/hwmon/adt7462.c
index e75bbd87ad09..5436c73e8d53 100644
--- a/drivers/hwmon/adt7462.c
+++ b/drivers/hwmon/adt7462.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
+#include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
 #include <linux/log2.h>
 #include <linux/slab.h>
@@ -1814,10 +1815,17 @@ static const struct i2c_device_id adt7462_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, adt7462_id);
 
+static const struct of_device_id adt7462_of_match[] = {
+	{ .compatible = "onnn,adt7462" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, adt7462_of_match);
+
 static struct i2c_driver adt7462_driver = {
 	.class		= I2C_CLASS_HWMON,
 	.driver = {
 		.name	= "adt7462",
+		.of_match_table = adt7462_of_match,
 	},
 	.probe_new	= adt7462_probe,
 	.id_table	= adt7462_id,
diff --git a/drivers/hwmon/applesmc.c b/drivers/hwmon/applesmc.c
index ceeb3f891608..d75658d4bf0d 100644
--- a/drivers/hwmon/applesmc.c
+++ b/drivers/hwmon/applesmc.c
@@ -1249,12 +1249,17 @@ static void applesmc_release_light_sensor(void)
 
 static int applesmc_create_key_backlight(void)
 {
+	int ret;
+
 	if (!smcreg.has_key_backlight)
 		return 0;
 	applesmc_led_wq = create_singlethread_workqueue("applesmc-led");
 	if (!applesmc_led_wq)
 		return -ENOMEM;
-	return led_classdev_register(&pdev->dev, &applesmc_backlight);
+	ret = led_classdev_register(&pdev->dev, &applesmc_backlight);
+	if (ret)
+		destroy_workqueue(applesmc_led_wq);
+	return ret;
 }
 
 static void applesmc_release_key_backlight(void)
diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 3dc97041a704..ed100c042837 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -922,7 +922,9 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 			"missing or invalid reset controller device tree entry");
 		return PTR_ERR(priv->rst);
 	}
-	reset_control_deassert(priv->rst);
+	ret = reset_control_deassert(priv->rst);
+	if (ret)
+		return ret;
 
 	ret = devm_add_action_or_reset(dev, aspeed_pwm_tacho_remove, priv);
 	if (ret)
diff --git a/drivers/hwmon/gpio-fan.c b/drivers/hwmon/gpio-fan.c
index e0b3917dfe6f..cfcd254a5ed1 100644
--- a/drivers/hwmon/gpio-fan.c
+++ b/drivers/hwmon/gpio-fan.c
@@ -562,8 +562,11 @@ static void gpio_fan_shutdown(struct platform_device *pdev)
 {
 	struct gpio_fan_data *fan_data = platform_get_drvdata(pdev);
 
-	if (fan_data->gpios)
+	if (fan_data->gpios) {
+		mutex_lock(&fan_data->lock);
 		set_fan_speed(fan_data, 0);
+		mutex_unlock(&fan_data->lock);
+	}
 }
 
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/hwmon/pmbus/lm25066.c b/drivers/hwmon/pmbus/lm25066.c
index 17199a1104c7..8775f10f6a58 100644
--- a/drivers/hwmon/pmbus/lm25066.c
+++ b/drivers/hwmon/pmbus/lm25066.c
@@ -131,23 +131,23 @@ static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
-			.m = 10742,
-			.b = 1552,
+			.m = 5456,
+			.b = 2118,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
-			.m = 5456,
-			.b = 2118,
+			.m = 10742,
+			.b = 1552,
 			.R = -2,
 		},
 		[PSC_POWER] = {
-			.m = 1204,
-			.b = 8524,
+			.m = 612,
+			.b = 11202,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
-			.m = 612,
-			.b = 11202,
+			.m = 1204,
+			.b = 8524,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
@@ -166,23 +166,23 @@ static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
-			.m = 10753,
-			.b = -1200,
+			.m = 5405,
+			.b = -600,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
-			.m = 5405,
-			.b = -600,
+			.m = 10753,
+			.b = -1200,
 			.R = -2,
 		},
 		[PSC_POWER] = {
-			.m = 1204,
-			.b = -6000,
+			.m = 605,
+			.b = -8000,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
-			.m = 605,
-			.b = -8000,
+			.m = 1204,
+			.b = -6000,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
@@ -201,23 +201,23 @@ static struct __coeff lm25066_coeff[][PSC_NUM_CLASSES + 2] = {
 			.R = -2,
 		},
 		[PSC_CURRENT_IN] = {
-			.m = 15076,
-			.b = -504,
+			.m = 7645,
+			.b = 100,
 			.R = -2,
 		},
 		[PSC_CURRENT_IN_L] = {
-			.m = 7645,
-			.b = 100,
+			.m = 15076,
+			.b = -504,
 			.R = -2,
 		},
 		[PSC_POWER] = {
-			.m = 1701,
-			.b = -4000,
+			.m = 861,
+			.b = -965,
 			.R = -3,
 		},
 		[PSC_POWER_L] = {
-			.m = 861,
-			.b = -965,
+			.m = 1701,
+			.b = -4000,
 			.R = -3,
 		},
 		[PSC_TEMPERATURE] = {
@@ -497,18 +497,20 @@ static int lm25066_probe(struct i2c_client *client)
 	info->m[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].m;
 	info->b[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].b;
 	info->R[PSC_VOLTAGE_OUT] = coeff[PSC_VOLTAGE_OUT].R;
-	info->R[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].R;
-	info->R[PSC_POWER] = coeff[PSC_POWER].R;
 	if (config & LM25066_DEV_SETUP_CL) {
 		info->m[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN_L].m;
 		info->b[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN_L].b;
+		info->R[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN_L].R;
 		info->m[PSC_POWER] = coeff[PSC_POWER_L].m;
 		info->b[PSC_POWER] = coeff[PSC_POWER_L].b;
+		info->R[PSC_POWER] = coeff[PSC_POWER_L].R;
 	} else {
 		info->m[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].m;
 		info->b[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].b;
+		info->R[PSC_CURRENT_IN] = coeff[PSC_CURRENT_IN].R;
 		info->m[PSC_POWER] = coeff[PSC_POWER].m;
 		info->b[PSC_POWER] = coeff[PSC_POWER].b;
+		info->R[PSC_POWER] = coeff[PSC_POWER].R;
 	}
 
 	return pmbus_do_probe(client, info);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index ddd8399a7fee..4ec17b66acf5 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -919,7 +919,9 @@ static int pmbus_get_boolean(struct i2c_client *client, struct pmbus_boolean *b,
 
 	regval = status & mask;
 	if (regval) {
-		if (data->revision >= PMBUS_REV_12) {
+		/* Generic STATUS_WORD alarms are not individually clearable. */
+		if (data->revision >= PMBUS_REV_12 &&
+		    reg != PMBUS_STATUS_WORD) {
 			ret = _pmbus_write_byte_data(client, page, reg, regval);
 			if (ret)
 				goto unlock;
diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index e51635590498..2c390b40cb4a 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1415,6 +1415,7 @@ static int w83791d_remove(struct i2c_client *client)
 	struct w83791d_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &w83791d_group_fanpwm45);
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 
 	return 0;
diff --git a/drivers/hwmon/w83793.c b/drivers/hwmon/w83793.c
index 6342cabfcb1d..fe6a8f0c8cd7 100644
--- a/drivers/hwmon/w83793.c
+++ b/drivers/hwmon/w83793.c
@@ -1931,7 +1931,9 @@ static int w83793_probe(struct i2c_client *client)
 	for (i = 0; i < ARRAY_SIZE(w83793_temp); i++)
 		device_remove_file(dev, &w83793_temp[i].dev_attr);
 free_mem:
-	kfree(data);
+	mutex_lock(&watchdog_data_mutex);
+	kref_put(&data->kref, w83793_release_resources);
+	mutex_unlock(&watchdog_data_mutex);
 exit:
 	return err;
 }
diff --git a/drivers/i2c/busses/i2c-at91-core.c b/drivers/i2c/busses/i2c-at91-core.c
index e14edd236108..0cdffec28217 100644
--- a/drivers/i2c/busses/i2c-at91-core.c
+++ b/drivers/i2c/busses/i2c-at91-core.c
@@ -264,6 +264,7 @@ static int at91_twi_probe(struct platform_device *pdev)
 
 		pm_runtime_disable(dev->dev);
 		pm_runtime_set_suspended(dev->dev);
+		at91_twi_dma_release(dev);
 
 		return rc;
 	}
@@ -280,6 +281,8 @@ static int at91_twi_remove(struct platform_device *pdev)
 	i2c_del_adapter(&dev->adapter);
 	clk_disable_unprepare(dev->clk);
 
+	at91_twi_dma_release(dev);
+
 	pm_runtime_disable(dev->dev);
 	pm_runtime_set_suspended(dev->dev);
 
diff --git a/drivers/i2c/busses/i2c-at91-master.c b/drivers/i2c/busses/i2c-at91-master.c
index 7960fa4b8c5b..b7787033b9e6 100644
--- a/drivers/i2c/busses/i2c-at91-master.c
+++ b/drivers/i2c/busses/i2c-at91-master.c
@@ -820,11 +820,21 @@ static int at91_twi_configure_dma(struct at91_twi_dev *dev, u32 phy_addr)
 error:
 	if (ret != -EPROBE_DEFER)
 		dev_info(dev->dev, "can't get DMA channel, continue without DMA support\n");
+	at91_twi_dma_release(dev);
+	return ret;
+}
+
+void at91_twi_dma_release(struct at91_twi_dev *dev)
+{
+	struct at91_twi_dma *dma = &dev->dma;
+
 	if (dma->chan_rx)
 		dma_release_channel(dma->chan_rx);
 	if (dma->chan_tx)
 		dma_release_channel(dma->chan_tx);
-	return ret;
+	dma->chan_rx = NULL;
+	dma->chan_tx = NULL;
+	dev->use_dma = false;
 }
 
 static int at91_init_twi_recovery_gpio(struct platform_device *pdev,
diff --git a/drivers/i2c/busses/i2c-at91.h b/drivers/i2c/busses/i2c-at91.h
index eae673ae786c..396a1fb34fc9 100644
--- a/drivers/i2c/busses/i2c-at91.h
+++ b/drivers/i2c/busses/i2c-at91.h
@@ -174,6 +174,7 @@ void at91_twi_irq_restore(struct at91_twi_dev *dev);
 void at91_init_twi_bus(struct at91_twi_dev *dev);
 
 void at91_init_twi_bus_master(struct at91_twi_dev *dev);
+void at91_twi_dma_release(struct at91_twi_dev *dev);
 int at91_twi_probe_master(struct platform_device *pdev, u32 phy_addr,
 			  struct at91_twi_dev *dev);
 
diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index b9d26a2c9dd9..b58f4de35eec 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1313,6 +1313,8 @@ static int i2c_imx_probe(struct platform_device *pdev)
 
 clk_notifier_unregister:
 	clk_notifier_unregister(i2c_imx->clk, &i2c_imx->clk_change_nb);
+	if (i2c_imx->dma)
+		i2c_imx_dma_free(i2c_imx);
 	free_irq(irq, i2c_imx);
 rpm_disable:
 	pm_runtime_put_noidle(&pdev->dev);
diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
index 14a21359f116..420caaf79116 100644
--- a/drivers/i2c/i2c-core-smbus.c
+++ b/drivers/i2c/i2c-core-smbus.c
@@ -563,6 +563,18 @@ s32 __i2c_smbus_xfer(struct i2c_adapter *adapter, u16 addr,
 	if (res)
 		return res;
 
+	/* Reject invalid caller-supplied block lengths before any
+	 * tracepoint or native smbus_xfer callback runs.
+	 */
+	if (data &&
+	    (protocol == I2C_SMBUS_I2C_BLOCK_DATA ||
+	     protocol == I2C_SMBUS_BLOCK_PROC_CALL ||
+	     (protocol == I2C_SMBUS_BLOCK_DATA &&
+	      read_write == I2C_SMBUS_WRITE)) &&
+	    (data->block[0] == 0 ||
+	     data->block[0] > I2C_SMBUS_BLOCK_MAX))
+		return -EINVAL;
+
 	/* If enabled, the following two tracepoints are conditional on
 	 * read_write and protocol.
 	 */
diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index b8ab2b0627a3..a8a145f818d8 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -1676,18 +1676,16 @@ static int mma8452_probe(struct i2c_client *client,
 		goto trigger_cleanup;
 
 	if (client->irq) {
-		ret = devm_request_threaded_irq(&client->dev,
-						client->irq,
-						NULL, mma8452_interrupt,
-						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
-						client->name, indio_dev);
+		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
+					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
+					   client->name, indio_dev);
 		if (ret)
 			goto buffer_cleanup;
 	}
 
 	ret = pm_runtime_set_active(&client->dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto free_irq;
 
 	pm_runtime_enable(&client->dev);
 	pm_runtime_set_autosuspend_delay(&client->dev,
@@ -1696,7 +1694,7 @@ static int mma8452_probe(struct i2c_client *client,
 
 	ret = iio_device_register(indio_dev);
 	if (ret < 0)
-		goto buffer_cleanup;
+		goto free_irq;
 
 	ret = mma8452_set_freefall_mode(data, false);
 	if (ret < 0)
@@ -1707,6 +1705,10 @@ static int mma8452_probe(struct i2c_client *client,
 unregister_device:
 	iio_device_unregister(indio_dev);
 
+free_irq:
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+
 buffer_cleanup:
 	iio_triggered_buffer_cleanup(indio_dev);
 
@@ -1733,6 +1735,9 @@ static int mma8452_remove(struct i2c_client *client)
 	pm_runtime_set_suspended(&client->dev);
 	pm_runtime_put_noidle(&client->dev);
 
+	if (client->irq)
+		free_irq(client->irq, indio_dev);
+
 	iio_triggered_buffer_cleanup(indio_dev);
 	mma8452_trigger_cleanup(indio_dev);
 	mma8452_standby(iio_priv(indio_dev));
diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
index acbda6636dc5..c57c50aeeffd 100644
--- a/drivers/iio/adc/qcom-spmi-iadc.c
+++ b/drivers/iio/adc/qcom-spmi-iadc.c
@@ -482,6 +482,11 @@ static const struct iio_chan_spec iadc_channels[] = {
 	},
 };
 
+static void iadc_disable_irq_wake(void *data)
+{
+	disable_irq_wake((unsigned long)data);
+}
+
 static int iadc_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
@@ -539,9 +544,16 @@ static int iadc_probe(struct platform_device *pdev)
 	if (!iadc->poll_eoc) {
 		ret = devm_request_irq(dev, irq_eoc, iadc_isr, 0,
 					"spmi-iadc", iadc);
-		if (!ret)
-			enable_irq_wake(irq_eoc);
-		else
+		if (ret)
+			return ret;
+
+		ret = enable_irq_wake(irq_eoc);
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, iadc_disable_irq_wake,
+					       (void *)(unsigned long)irq_eoc);
+		if (ret)
 			return ret;
 	} else {
 		device_init_wakeup(iadc->dev, 1);
diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 13495b43dbc1..0157c4cf1ea5 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -348,10 +348,6 @@ struct iwpm_nlmsg_request *iwpm_get_nlmsg_request(__u32 nlmsg_seq,
 	if (!nlmsg_request)
 		return NULL;
 
-	spin_lock_irqsave(&iwpm_nlmsg_req_lock, flags);
-	list_add_tail(&nlmsg_request->inprocess_list, &iwpm_nlmsg_req_list);
-	spin_unlock_irqrestore(&iwpm_nlmsg_req_lock, flags);
-
 	kref_init(&nlmsg_request->kref);
 	kref_get(&nlmsg_request->kref);
 	nlmsg_request->nlmsg_seq = nlmsg_seq;
@@ -360,6 +356,11 @@ struct iwpm_nlmsg_request *iwpm_get_nlmsg_request(__u32 nlmsg_seq,
 	nlmsg_request->err_code = 0;
 	sema_init(&nlmsg_request->sem, 1);
 	down(&nlmsg_request->sem);
+
+	spin_lock_irqsave(&iwpm_nlmsg_req_lock, flags);
+	list_add_tail(&nlmsg_request->inprocess_list, &iwpm_nlmsg_req_list);
+	spin_unlock_irqrestore(&iwpm_nlmsg_req_lock, flags);
+
 	return nlmsg_request;
 }
 
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 10d29167b585..1be9513b8966 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -1810,6 +1810,8 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 	int ret;
 
 	INIT_LIST_HEAD(&mad_recv_wc->rmpp_list);
+	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
+
 	ret = ib_mad_enforce_security(mad_agent_priv,
 				      mad_recv_wc->wc->pkey_index);
 	if (ret) {
@@ -1818,7 +1820,6 @@ static void ib_mad_complete_recv(struct ib_mad_agent_private *mad_agent_priv,
 		return;
 	}
 
-	list_add(&mad_recv_wc->recv_buf.list, &mad_recv_wc->rmpp_list);
 	if (is_kernel_rmpp_data_response(mad_agent_priv, mad_recv_wc)) {
 		spin_lock_irqsave(&mad_agent_priv->lock, flags);
 		mad_send_wr = ib_find_send_mad(mad_agent_priv, mad_recv_wc);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index bd3a05a9674d..7efdfcf6bb29 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1488,9 +1488,10 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	mutex_lock(&ctx->mutex);
 	ret = rdma_join_multicast(ctx->cm_id, (struct sockaddr *)&mc->addr,
 				  join_state, mc);
-	mutex_unlock(&ctx->mutex);
-	if (ret)
+	if (ret) {
+		mutex_unlock(&ctx->mutex);
 		goto err_xa_erase;
+	}
 
 	resp.id = mc->id;
 	if (copy_to_user(u64_to_user_ptr(cmd->response),
@@ -1498,6 +1499,7 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 		ret = -EFAULT;
 		goto err_leave_multicast;
 	}
+	mutex_unlock(&ctx->mutex);
 
 	xa_store(&multicast_table, mc->id, mc, 0);
 
@@ -1505,7 +1507,6 @@ static ssize_t ucma_process_join(struct ucma_file *file,
 	return 0;
 
 err_leave_multicast:
-	mutex_lock(&ctx->mutex);
 	rdma_leave_multicast(ctx->cm_id, (struct sockaddr *) &mc->addr);
 	mutex_unlock(&ctx->mutex);
 	ucma_cleanup_mc_events(mc);
diff --git a/drivers/infiniband/hw/mlx4/sysfs.c b/drivers/infiniband/hw/mlx4/sysfs.c
index f75bb58197dd..438ef20c092e 100644
--- a/drivers/infiniband/hw/mlx4/sysfs.c
+++ b/drivers/infiniband/hw/mlx4/sysfs.c
@@ -763,11 +763,13 @@ static int register_one_pkey_tree(struct mlx4_ib_dev *dev, int slave)
 		kobject_put(p);
 	}
 	kobject_put(dev->dev_ports_parent[slave]);
+	dev->dev_ports_parent[slave] = NULL;
 
 err_ports:
 	kobject_put(dev->pkeys.device_parent[slave]);
 	/* extra put for the device_parent create_and_add */
 	kobject_put(dev->pkeys.device_parent[slave]);
+	dev->pkeys.device_parent[slave] = NULL;
 
 fail_dev:
 	kobject_put(dev->iov_parent);
@@ -797,6 +799,8 @@ static void unregister_pkey_tree(struct mlx4_ib_dev *device)
 		return;
 
 	for (slave = device->dev->persist->num_vfs; slave >= 0; --slave) {
+		if (!device->pkeys.device_parent[slave])
+			continue;
 		list_for_each_entry_safe(p, t,
 					 &device->pkeys.pkey_port_list[slave],
 					 entry) {
diff --git a/drivers/infiniband/hw/mlx5/cq.c b/drivers/infiniband/hw/mlx5/cq.c
index e6d3ac4e10dc..c505017a289b 100644
--- a/drivers/infiniband/hw/mlx5/cq.c
+++ b/drivers/infiniband/hw/mlx5/cq.c
@@ -166,7 +166,8 @@ enum {
 static void handle_responder(struct ib_wc *wc, struct mlx5_cqe64 *cqe,
 			     struct mlx5_ib_qp *qp)
 {
-	enum rdma_link_layer ll = rdma_port_get_link_layer(qp->ibqp.device, 1);
+	enum rdma_link_layer ll =
+		rdma_port_get_link_layer(qp->ibqp.device, qp->port);
 	struct mlx5_ib_dev *dev = to_mdev(qp->ibqp.device);
 	struct mlx5_ib_srq *srq = NULL;
 	struct mlx5_ib_wq *wq;
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 0e20b99cae8b..56151a616b07 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1708,6 +1708,9 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	    dev->lb.qps == 1) {
 		if (!dev->lb.enabled) {
 			err = mlx5_nic_vport_update_local_lb(dev->mdev, true);
+			if (err)
+				goto err_rollback;
+
 			dev->lb.enabled = true;
 		}
 	}
@@ -1715,6 +1718,14 @@ int mlx5_ib_enable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
 	mutex_unlock(&dev->lb.mutex);
 
 	return err;
+
+err_rollback:
+	if (td)
+		dev->lb.user_td--;
+	if (qp)
+		dev->lb.qps--;
+	mutex_unlock(&dev->lb.mutex);
+	return err;
 }
 
 void mlx5_ib_disable_lb(struct mlx5_ib_dev *dev, bool td, bool qp)
diff --git a/drivers/infiniband/sw/siw/siw_cm.c b/drivers/infiniband/sw/siw/siw_cm.c
index dfe9077ee168..5e1b577d1c92 100644
--- a/drivers/infiniband/sw/siw/siw_cm.c
+++ b/drivers/infiniband/sw/siw/siw_cm.c
@@ -450,6 +450,12 @@ void siw_cep_put(struct siw_cep *cep)
 	kref_put(&cep->ref, __siw_cep_dealloc);
 }
 
+static void siw_cep_set_free_and_put(struct siw_cep *cep)
+{
+	siw_cep_set_free(cep);
+	siw_cep_put(cep);
+}
+
 void siw_cep_get(struct siw_cep *cep)
 {
 	kref_get(&cep->ref);
@@ -1511,9 +1517,7 @@ int siw_connect(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 		cep->state = SIW_EPSTATE_CLOSED;
 
-		siw_cep_set_free(cep);
-
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 
 	} else if (s) {
 		sock_release(s);
@@ -1544,7 +1548,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	struct siw_cep *cep = (struct siw_cep *)id->provider_data;
 	struct siw_qp *qp;
 	struct siw_qp_attrs qp_attrs;
-	int rv, max_priv_data = MPA_MAX_PRIVDATA;
+	int rv = -EINVAL, max_priv_data = MPA_MAX_PRIVDATA;
 	bool wait_for_peer_rts = false;
 
 	siw_cep_set_inuse(cep);
@@ -1560,26 +1564,17 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
 		siw_dbg_cep(cep, "out of state\n");
-
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
-
-		return -ECONNRESET;
+		rv = -ECONNRESET;
+		goto free_cep;
 	}
 	qp = siw_qp_id2obj(sdev, params->qpn);
 	if (!qp) {
 		WARN(1, "[QP %d] does not exist\n", params->qpn);
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
-
-		return -EINVAL;
+		goto free_cep;
 	}
 	down_write(&qp->state_lock);
-	if (qp->attrs.state > SIW_QP_STATE_RTR) {
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
-	}
+	if (qp->attrs.state > SIW_QP_STATE_RTR)
+		goto error_unlock;
 	siw_dbg_cep(cep, "[QP %d]\n", params->qpn);
 
 	if (try_gso && cep->mpa.hdr.params.bits & MPA_RR_FLAG_GSO_EXP) {
@@ -1593,9 +1588,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			"[QP %u]: ord %d (max %d), ird %d (max %d)\n",
 			qp_id(qp), params->ord, sdev->attrs.max_ord,
 			params->ird, sdev->attrs.max_ird);
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
+		goto error_unlock;
 	}
 	if (cep->enhanced_rdma_conn_est)
 		max_priv_data -= sizeof(struct mpa_v2_data);
@@ -1605,9 +1598,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			cep,
 			"[QP %u]: private data length: %d (max %d)\n",
 			qp_id(qp), params->private_data_len, max_priv_data);
-		rv = -EINVAL;
-		up_write(&qp->state_lock);
-		goto error;
+		goto error_unlock;
 	}
 	if (cep->enhanced_rdma_conn_est) {
 		if (params->ord > cep->ord) {
@@ -1616,9 +1607,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			} else {
 				cep->ird = params->ird;
 				cep->ord = params->ord;
-				rv = -EINVAL;
-				up_write(&qp->state_lock);
-				goto error;
+				goto error_unlock;
 			}
 		}
 		if (params->ird < cep->ird) {
@@ -1627,8 +1616,7 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 				params->ird = cep->ird;
 			else {
 				rv = -ENOMEM;
-				up_write(&qp->state_lock);
-				goto error;
+				goto error_unlock;
 			}
 		}
 		if (cep->mpa.v2_ctrl.ord &
@@ -1674,11 +1662,13 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 			   SIW_QP_ATTR_STATE | SIW_QP_ATTR_LLP_HANDLE |
 				   SIW_QP_ATTR_ORD | SIW_QP_ATTR_IRD |
 				   SIW_QP_ATTR_MPA);
+	if (rv) {
+		qp->cep = NULL;
+		siw_cep_put(cep);
+		goto error_unlock;
+	}
 	up_write(&qp->state_lock);
 
-	if (rv)
-		goto error;
-
 	siw_dbg_cep(cep, "[QP %u]: send mpa reply, %d byte pdata\n",
 		    qp_id(qp), params->private_data_len);
 
@@ -1698,6 +1688,9 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	siw_cep_set_free(cep);
 
 	return 0;
+
+error_unlock:
+	up_write(&qp->state_lock);
 error:
 	siw_socket_disassoc(cep->sock);
 	sock_release(cep->sock);
@@ -1712,10 +1705,8 @@ int siw_accept(struct iw_cm_id *id, struct iw_cm_conn_param *params)
 	}
 	cep->qp = NULL;
 	siw_qp_put(qp);
-
-	siw_cep_set_free(cep);
-	siw_cep_put(cep);
-
+free_cep:
+	siw_cep_set_free_and_put(cep);
 	return rv;
 }
 
@@ -1737,8 +1728,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 	if (cep->state != SIW_EPSTATE_RECVD_MPAREQ) {
 		siw_dbg_cep(cep, "out of state\n");
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep); /* put last reference */
+		siw_cep_set_free_and_put(cep); /* put last reference */
 
 		return -ECONNRESET;
 	}
@@ -1755,8 +1745,7 @@ int siw_reject(struct iw_cm_id *id, const void *pdata, u8 pd_len)
 
 	cep->state = SIW_EPSTATE_CLOSED;
 
-	siw_cep_set_free(cep);
-	siw_cep_put(cep);
+	siw_cep_set_free_and_put(cep);
 
 	return 0;
 }
@@ -1879,8 +1868,7 @@ int siw_create_listen(struct iw_cm_id *id, int backlog)
 		siw_socket_disassoc(s);
 		cep->state = SIW_EPSTATE_CLOSED;
 
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 	}
 	sock_release(s);
 
@@ -1911,8 +1899,7 @@ static void siw_drop_listeners(struct iw_cm_id *id)
 			cep->sock = NULL;
 		}
 		cep->state = SIW_EPSTATE_CLOSED;
-		siw_cep_set_free(cep);
-		siw_cep_put(cep);
+		siw_cep_set_free_and_put(cep);
 	}
 }
 
diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index 743ffb3754e8..d608ecc67dd9 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1095,7 +1095,7 @@ static int siw_get_hdr(struct siw_rx_stream *srx)
 	if (iwarp_pktinfo[opcode].hdr_len > sizeof(struct iwarp_ctrl_tagged)) {
 		int hdrlen = iwarp_pktinfo[opcode].hdr_len;
 
-		bytes = min_t(int, hdrlen - MIN_DDP_HDR, srx->skb_new);
+		bytes = min_t(int, hdrlen - srx->fpdu_part_rcvd, srx->skb_new);
 
 		skb_copy_bits(skb, srx->skb_offset,
 			      (char *)c_hdr + srx->fpdu_part_rcvd, bytes);
diff --git a/drivers/infiniband/ulp/ipoib/ipoib.h b/drivers/infiniband/ulp/ipoib/ipoib.h
index 3440dc48d02c..1c3a8fd520b5 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib.h
+++ b/drivers/infiniband/ulp/ipoib/ipoib.h
@@ -87,6 +87,7 @@ enum {
 	IPOIB_FLAG_INITIALIZED	  = 1,
 	IPOIB_FLAG_ADMIN_UP	  = 2,
 	IPOIB_PKEY_ASSIGNED	  = 3,
+	IPOIB_FLAG_MCAST_FLUSH	  = 4,
 	IPOIB_FLAG_SUBINTERFACE	  = 5,
 	IPOIB_STOP_REAPER	  = 7,
 	IPOIB_FLAG_ADMIN_CM	  = 9,
@@ -417,6 +418,12 @@ struct ipoib_dev_priv {
 	const struct net_device_ops	*rn_ops;
 };
 
+static inline bool ipoib_mcast_allowed(struct ipoib_dev_priv *priv)
+{
+	return test_bit(IPOIB_FLAG_OPER_UP, &priv->flags) &&
+	       !test_bit(IPOIB_FLAG_MCAST_FLUSH, &priv->flags);
+}
+
 struct ipoib_ah {
 	struct net_device *dev;
 	struct ib_ah	  *ah;
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 494f413dc3c6..69bc5c2ff3eb 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -1212,17 +1212,19 @@ static void __ipoib_ib_dev_flush(struct ipoib_dev_priv *priv,
 	}
 
 	if (level == IPOIB_FLUSH_LIGHT) {
-		int oper_up;
 		ipoib_mark_paths_invalid(dev);
-		/* Set IPoIB operation as down to prevent races between:
+		/* Set MCAST_FLUSH to prevent races between:
 		 * the flush flow which leaves MCG and on the fly joins
 		 * which can happen during that time. mcast restart task
 		 * should deal with join requests we missed.
+		 *
+		 * Do not clear OPER_UP for this; restoring it races with
+		 * ipoib_ib_dev_down() and can leave OPER_UP set after the
+		 * device is down.
 		 */
-		oper_up = test_and_clear_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
+		set_bit(IPOIB_FLAG_MCAST_FLUSH, &priv->flags);
 		ipoib_mcast_dev_flush(dev);
-		if (oper_up)
-			set_bit(IPOIB_FLAG_OPER_UP, &priv->flags);
+		clear_bit(IPOIB_FLAG_MCAST_FLUSH, &priv->flags);
 		ipoib_reap_dead_ahs(priv);
 	}
 
diff --git a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
index e009123c703b..32c4e23556b8 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_multicast.c
@@ -74,7 +74,7 @@ static void __ipoib_mcast_schedule_join_thread(struct ipoib_dev_priv *priv,
 					       struct ipoib_mcast *mcast,
 					       bool delay)
 {
-	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
+	if (!ipoib_mcast_allowed(priv))
 		return;
 
 	/*
@@ -479,7 +479,7 @@ static int ipoib_mcast_join(struct net_device *dev, struct ipoib_mcast *mcast)
 	int ret = 0;
 
 	if (!priv->broadcast ||
-	    !test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
+	    !ipoib_mcast_allowed(priv))
 		return -EINVAL;
 
 	init_completion(&mcast->done);
@@ -567,7 +567,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 	unsigned long delay_until = 0;
 	struct ipoib_mcast *mcast = NULL;
 
-	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
+	if (!ipoib_mcast_allowed(priv))
 		return;
 
 	if (ib_query_port(priv->ca, priv->port, &port_attr)) {
@@ -589,7 +589,7 @@ void ipoib_mcast_join_task(struct work_struct *work)
 	netif_addr_unlock_bh(dev);
 
 	spin_lock_irq(&priv->lock);
-	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
+	if (!ipoib_mcast_allowed(priv))
 		goto out;
 
 	if (!priv->broadcast) {
@@ -761,7 +761,7 @@ void ipoib_mcast_send(struct net_device *dev, u8 *daddr, struct sk_buff *skb)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
-	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags)		||
+	if (!ipoib_mcast_allowed(priv)				||
 	    !priv->broadcast					||
 	    !test_bit(IPOIB_MCAST_FLAG_ATTACHED, &priv->broadcast->flags)) {
 		++dev->stats.tx_dropped;
@@ -883,7 +883,7 @@ void ipoib_mcast_restart_task(struct work_struct *work)
 	LIST_HEAD(remove_list);
 	struct ib_sa_mcmember_rec rec;
 
-	if (!test_bit(IPOIB_FLAG_OPER_UP, &priv->flags))
+	if (!ipoib_mcast_allowed(priv))
 		/*
 		 * shortcut...on shutdown flush is called next, just
 		 * let it do all the work
@@ -977,9 +977,9 @@ void ipoib_mcast_restart_task(struct work_struct *work)
 	ipoib_mcast_remove_list(&remove_list);
 
 	/*
-	 * Double check that we are still up
+	 * Double check that we are still up and not flushing
 	 */
-	if (test_bit(IPOIB_FLAG_OPER_UP, &priv->flags)) {
+	if (ipoib_mcast_allowed(priv)) {
 		spin_lock_irq(&priv->lock);
 		__ipoib_mcast_schedule_join_thread(priv, NULL, 0);
 		spin_unlock_irq(&priv->lock);
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
index a16e066989fa..0dac099e3087 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.c
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
@@ -120,9 +120,8 @@ MODULE_PARM_DESC(pi_guard, "T10-PI guard_type [deprecated]");
  * Notes: In case of data length errors or iscsi PDU completion failures
  *        this routine will signal iscsi layer of connection failure.
  */
-void
-iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
-		char *rx_data, int rx_data_len)
+void iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
+		     char *rx_data, int rx_data_len)
 {
 	int rc = 0;
 	int datalen;
@@ -157,8 +156,7 @@ iscsi_iser_recv(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
  * Netes: This routine can't fail, just assign iscsi task
  *        hdr and max hdr size.
  */
-static int
-iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
+static int iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 
@@ -179,9 +177,8 @@ iscsi_iser_pdu_alloc(struct iscsi_task *task, uint8_t opcode)
  * state mutex to avoid dereferencing the IB device which
  * may have already been terminated.
  */
-int
-iser_initialize_task_headers(struct iscsi_task *task,
-			     struct iser_tx_desc *tx_desc)
+int iser_initialize_task_headers(struct iscsi_task *task,
+				 struct iser_tx_desc *tx_desc)
 {
 	struct iser_conn *iser_conn = task->conn->dd_data;
 	struct iser_device *device = iser_conn->ib_conn.device;
@@ -230,8 +227,7 @@ iser_initialize_task_headers(struct iscsi_task *task,
  * Return: Returns zero on success or -ENOMEM when failing
  *         to init task headers (dma mapping error).
  */
-static int
-iscsi_iser_task_init(struct iscsi_task *task)
+static int iscsi_iser_task_init(struct iscsi_task *task)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	int ret;
@@ -265,8 +261,8 @@ iscsi_iser_task_init(struct iscsi_task *task)
  *	xmit.
  *
  **/
-static int
-iscsi_iser_mtask_xmit(struct iscsi_conn *conn, struct iscsi_task *task)
+static int iscsi_iser_mtask_xmit(struct iscsi_conn *conn,
+				 struct iscsi_task *task)
 {
 	int error = 0;
 
@@ -283,9 +279,8 @@ iscsi_iser_mtask_xmit(struct iscsi_conn *conn, struct iscsi_task *task)
 	return error;
 }
 
-static int
-iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
-				 struct iscsi_task *task)
+static int iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
+					   struct iscsi_task *task)
 {
 	struct iscsi_r2t_info *r2t = &task->unsol_r2t;
 	struct iscsi_data hdr;
@@ -319,8 +314,7 @@ iscsi_iser_task_xmit_unsol_data(struct iscsi_conn *conn,
  *
  * Return: zero on success or escalates $error on failure.
  */
-static int
-iscsi_iser_task_xmit(struct iscsi_task *task)
+static int iscsi_iser_task_xmit(struct iscsi_task *task)
 {
 	struct iscsi_conn *conn = task->conn;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -403,8 +397,7 @@ static void iscsi_iser_cleanup_task(struct iscsi_task *task)
  *
  *         In addition the error sector is marked.
  */
-static u8
-iscsi_iser_check_protection(struct iscsi_task *task, sector_t *sector)
+static u8 iscsi_iser_check_protection(struct iscsi_task *task, sector_t *sector)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	enum iser_data_dir dir = iser_task->dir[ISER_DIR_IN] ?
@@ -453,11 +446,9 @@ iscsi_iser_conn_create(struct iscsi_cls_session *cls_session,
  *         -EINVAL in case end-point doesn't exsits anymore or iser connection
  *         state is not UP (teardown already started).
  */
-static int
-iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
-		     struct iscsi_cls_conn *cls_conn,
-		     uint64_t transport_eph,
-		     int is_leading)
+static int iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
+				struct iscsi_cls_conn *cls_conn,
+				uint64_t transport_eph, int is_leading)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iser_conn *iser_conn;
@@ -512,8 +503,7 @@ iscsi_iser_conn_bind(struct iscsi_cls_session *cls_session,
  *        from this point iscsi must call conn_stop in session/connection
  *        teardown so iser transport must wait for it.
  */
-static int
-iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
+static int iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
 {
 	struct iscsi_conn *iscsi_conn;
 	struct iser_conn *iser_conn;
@@ -535,8 +525,7 @@ iscsi_iser_conn_start(struct iscsi_cls_conn *cls_conn)
  *        handle, so we call it under iser the state lock to protect against
  *        this kind of race.
  */
-static void
-iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
+static void iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iser_conn *iser_conn = conn->dd_data;
@@ -571,8 +560,7 @@ iscsi_iser_conn_stop(struct iscsi_cls_conn *cls_conn, int flag)
  *
  * Removes and free iscsi host.
  */
-static void
-iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
+static void iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
 {
 	struct Scsi_Host *shost = iscsi_session_to_shost(cls_session);
 
@@ -581,8 +569,7 @@ iscsi_iser_session_destroy(struct iscsi_cls_session *cls_session)
 	iscsi_host_free(shost);
 }
 
-static inline unsigned int
-iser_dif_prot_caps(int prot_caps)
+static inline unsigned int iser_dif_prot_caps(int prot_caps)
 {
 	return ((prot_caps & IB_PROT_T10DIF_TYPE_1) ?
 		SHOST_DIF_TYPE1_PROTECTION | SHOST_DIX_TYPE0_PROTECTION |
@@ -694,9 +681,8 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
 	return NULL;
 }
 
-static int
-iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
-		     enum iscsi_param param, char *buf, int buflen)
+static int iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
+				enum iscsi_param param, char *buf, int buflen)
 {
 	int value;
 
@@ -746,8 +732,8 @@ iscsi_iser_set_param(struct iscsi_cls_conn *cls_conn,
  *
  * Output connection statistics.
  */
-static void
-iscsi_iser_conn_get_stats(struct iscsi_cls_conn *cls_conn, struct iscsi_stats *stats)
+static void iscsi_iser_conn_get_stats(struct iscsi_cls_conn *cls_conn,
+				      struct iscsi_stats *stats)
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 
@@ -798,9 +784,9 @@ static int iscsi_iser_get_ep_param(struct iscsi_endpoint *ep,
  * Return: iscsi_endpoint created by iscsi layer or ERR_PTR(error)
  *         if fails.
  */
-static struct iscsi_endpoint *
-iscsi_iser_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
-		      int non_blocking)
+static struct iscsi_endpoint *iscsi_iser_ep_connect(struct Scsi_Host *shost,
+						    struct sockaddr *dst_addr,
+						    int non_blocking)
 {
 	int err;
 	struct iser_conn *iser_conn;
@@ -843,8 +829,7 @@ iscsi_iser_ep_connect(struct Scsi_Host *shost, struct sockaddr *dst_addr,
  *         or more likely iser connection state transitioned to TEMINATING or
  *         DOWN during the wait period.
  */
-static int
-iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
+static int iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
 	int rc;
@@ -879,8 +864,7 @@ iscsi_iser_ep_poll(struct iscsi_endpoint *ep, int timeout_ms)
  * and cleanup or actually call it immediately in case we didn't pass
  * iscsi conn bind/start stage, thus it is safe.
  */
-static void
-iscsi_iser_ep_disconnect(struct iscsi_endpoint *ep)
+static void iscsi_iser_ep_disconnect(struct iscsi_endpoint *ep)
 {
 	struct iser_conn *iser_conn = ep->dd_data;
 
diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.h b/drivers/infiniband/ulp/iser/iscsi_iser.h
index 45a2d2b82b09..b4e7172523cf 100644
--- a/drivers/infiniband/ulp/iser/iscsi_iser.h
+++ b/drivers/infiniband/ulp/iser/iscsi_iser.h
@@ -207,12 +207,12 @@ struct iser_reg_resources;
  *
  * @sge:          memory region sg element
  * @rkey:         memory region remote key
- * @mem_h:        pointer to registration context (FMR/Fastreg)
+ * @desc:         pointer to fast registration context
  */
 struct iser_mem_reg {
-	struct ib_sge	 sge;
-	u32		 rkey;
-	void		*mem_h;
+	struct ib_sge sge;
+	u32 rkey;
+	struct iser_fr_desc *desc;
 };
 
 enum iser_desc_type {
diff --git a/drivers/infiniband/ulp/iser/iser_initiator.c b/drivers/infiniband/ulp/iser/iser_initiator.c
index 9ea88dd6a414..2b720b00a4cf 100644
--- a/drivers/infiniband/ulp/iser/iser_initiator.c
+++ b/drivers/infiniband/ulp/iser/iser_initiator.c
@@ -95,11 +95,8 @@ static int iser_prepare_read_cmd(struct iscsi_task *task)
  *  task->data[ISER_DIR_OUT].data_len, Protection size
  *  is stored at task->prot[ISER_DIR_OUT].data_len
  */
-static int
-iser_prepare_write_cmd(struct iscsi_task *task,
-		       unsigned int imm_sz,
-		       unsigned int unsol_sz,
-		       unsigned int edtl)
+static int iser_prepare_write_cmd(struct iscsi_task *task, unsigned int imm_sz,
+				  unsigned int unsol_sz, unsigned int edtl)
 {
 	struct iscsi_iser_task *iser_task = task->dd_data;
 	struct iser_mem_reg *mem_reg;
@@ -160,8 +157,8 @@ iser_prepare_write_cmd(struct iscsi_task *task,
 }
 
 /* creates a new tx descriptor and adds header regd buffer */
-static void iser_create_send_desc(struct iser_conn	*iser_conn,
-				  struct iser_tx_desc	*tx_desc)
+static void iser_create_send_desc(struct iser_conn *iser_conn,
+				  struct iser_tx_desc *tx_desc)
 {
 	struct iser_device *device = iser_conn->ib_conn.device;
 
@@ -360,8 +357,7 @@ static inline bool iser_signal_comp(u8 sig_count)
  * @conn: link to matching iscsi connection
  * @task: SCSI command task
  */
-int iser_send_command(struct iscsi_conn *conn,
-		      struct iscsi_task *task)
+int iser_send_command(struct iscsi_conn *conn, struct iscsi_task *task)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -434,8 +430,7 @@ int iser_send_command(struct iscsi_conn *conn,
  * @task: SCSI command task
  * @hdr: pointer to the LLD's iSCSI message header
  */
-int iser_send_data_out(struct iscsi_conn *conn,
-		       struct iscsi_task *task,
+int iser_send_data_out(struct iscsi_conn *conn, struct iscsi_task *task,
 		       struct iscsi_data *hdr)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
@@ -497,8 +492,7 @@ int iser_send_data_out(struct iscsi_conn *conn,
 	return err;
 }
 
-int iser_send_control(struct iscsi_conn *conn,
-		      struct iscsi_task *task)
+int iser_send_control(struct iscsi_conn *conn, struct iscsi_task *task)
 {
 	struct iser_conn *iser_conn = conn->dd_data;
 	struct iscsi_iser_task *iser_task = task->dd_data;
@@ -593,8 +587,7 @@ void iser_login_rsp(struct ib_cq *cq, struct ib_wc *wc)
 	ib_conn->post_recv_buf_count--;
 }
 
-static inline int
-iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
+static inline int iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 {
 	if (unlikely((!desc->sig_protected && rkey != desc->rsc.mr->rkey) ||
 		     (desc->sig_protected && rkey != desc->rsc.sig_mr->rkey))) {
@@ -610,10 +603,8 @@ iser_inv_desc(struct iser_fr_desc *desc, u32 rkey)
 	return 0;
 }
 
-static int
-iser_check_remote_inv(struct iser_conn *iser_conn,
-		      struct ib_wc *wc,
-		      struct iscsi_hdr *hdr)
+static int iser_check_remote_inv(struct iser_conn *iser_conn, struct ib_wc *wc,
+				 struct iscsi_hdr *hdr)
 {
 	if (wc->wc_flags & IB_WC_WITH_INVALIDATE) {
 		struct iscsi_task *task;
@@ -622,11 +613,8 @@ iser_check_remote_inv(struct iser_conn *iser_conn,
 		iser_dbg("conn %p: remote invalidation for rkey %#x\n",
 			 iser_conn, rkey);
 
-		if (unlikely(!iser_conn->snd_w_inv)) {
-			iser_err("conn %p: unexpected remote invalidation, terminating connection\n",
-				 iser_conn);
-			return -EPROTO;
-		}
+		if (unlikely(!iser_conn->snd_w_inv))
+			goto bad_inv;
 
 		task = iscsi_itt_to_ctask(iser_conn->iscsi_conn, hdr->itt);
 		if (likely(task)) {
@@ -634,13 +622,17 @@ iser_check_remote_inv(struct iser_conn *iser_conn,
 			struct iser_fr_desc *desc;
 
 			if (iser_task->dir[ISER_DIR_IN]) {
-				desc = iser_task->rdma_reg[ISER_DIR_IN].mem_h;
+				desc = iser_task->rdma_reg[ISER_DIR_IN].desc;
+				if (unlikely(!desc))
+					goto bad_inv;
 				if (unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
 
 			if (iser_task->dir[ISER_DIR_OUT]) {
-				desc = iser_task->rdma_reg[ISER_DIR_OUT].mem_h;
+				desc = iser_task->rdma_reg[ISER_DIR_OUT].desc;
+				if (unlikely(!desc))
+					goto bad_inv;
 				if (unlikely(iser_inv_desc(desc, rkey)))
 					return -EINVAL;
 			}
@@ -651,6 +643,11 @@ iser_check_remote_inv(struct iser_conn *iser_conn,
 	}
 
 	return 0;
+
+bad_inv:
+	iser_err("conn %p: unexpected remote invalidation, terminating connection\n",
+		 iser_conn);
+	return -EPROTO;
 }
 
 
diff --git a/drivers/infiniband/ulp/iser/iser_memory.c b/drivers/infiniband/ulp/iser/iser_memory.c
index 519fea5ec3a1..d2e38c5b6bb9 100644
--- a/drivers/infiniband/ulp/iser/iser_memory.c
+++ b/drivers/infiniband/ulp/iser/iser_memory.c
@@ -44,8 +44,7 @@ void iser_reg_comp(struct ib_cq *cq, struct ib_wc *wc)
 	iser_err_comp(wc, "memreg");
 }
 
-static struct iser_fr_desc *
-iser_reg_desc_get_fr(struct ib_conn *ib_conn)
+static struct iser_fr_desc *iser_reg_desc_get_fr(struct ib_conn *ib_conn)
 {
 	struct iser_fr_pool *fr_pool = &ib_conn->fr_pool;
 	struct iser_fr_desc *desc;
@@ -60,9 +59,8 @@ iser_reg_desc_get_fr(struct ib_conn *ib_conn)
 	return desc;
 }
 
-static void
-iser_reg_desc_put_fr(struct ib_conn *ib_conn,
-		     struct iser_fr_desc *desc)
+static void iser_reg_desc_put_fr(struct ib_conn *ib_conn,
+				 struct iser_fr_desc *desc)
 {
 	struct iser_fr_pool *fr_pool = &ib_conn->fr_pool;
 	unsigned long flags;
@@ -73,9 +71,9 @@ iser_reg_desc_put_fr(struct ib_conn *ib_conn,
 }
 
 int iser_dma_map_task_data(struct iscsi_iser_task *iser_task,
-			    struct iser_data_buf *data,
-			    enum iser_data_dir iser_dir,
-			    enum dma_data_direction dma_dir)
+			   struct iser_data_buf *data,
+			   enum iser_data_dir iser_dir,
+			   enum dma_data_direction dma_dir)
 {
 	struct ib_device *dev;
 
@@ -100,9 +98,8 @@ void iser_dma_unmap_task_data(struct iscsi_iser_task *iser_task,
 	ib_dma_unmap_sg(dev, data->sg, data->size, dir);
 }
 
-static int
-iser_reg_dma(struct iser_device *device, struct iser_data_buf *mem,
-	     struct iser_mem_reg *reg)
+static int iser_reg_dma(struct iser_device *device, struct iser_data_buf *mem,
+			struct iser_mem_reg *reg)
 {
 	struct scatterlist *sg = mem->sg;
 
@@ -133,7 +130,7 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 	struct iser_fr_desc *desc;
 	struct ib_mr_status mr_status;
 
-	desc = reg->mem_h;
+	desc = reg->desc;
 	if (!desc)
 		return;
 
@@ -150,12 +147,12 @@ void iser_unreg_mem_fastreg(struct iscsi_iser_task *iser_task,
 		ib_check_mr_status(desc->rsc.sig_mr, IB_MR_CHECK_SIG_STATUS,
 				   &mr_status);
 	}
-	iser_reg_desc_put_fr(&iser_task->iser_conn->ib_conn, reg->mem_h);
-	reg->mem_h = NULL;
+	iser_reg_desc_put_fr(&iser_task->iser_conn->ib_conn, reg->desc);
+	reg->desc = NULL;
 }
 
-static void
-iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
+static void iser_set_dif_domain(struct scsi_cmnd *sc,
+				struct ib_sig_domain *domain)
 {
 	domain->sig_type = IB_SIG_TYPE_T10_DIF;
 	domain->sig.dif.pi_interval = scsi_prot_interval(sc);
@@ -171,8 +168,8 @@ iser_set_dif_domain(struct scsi_cmnd *sc, struct ib_sig_domain *domain)
 		domain->sig.dif.ref_remap = true;
 };
 
-static int
-iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
+static int iser_set_sig_attrs(struct scsi_cmnd *sc,
+			      struct ib_sig_attrs *sig_attrs)
 {
 	switch (scsi_get_prot_op(sc)) {
 	case SCSI_PROT_WRITE_INSERT:
@@ -205,8 +202,7 @@ iser_set_sig_attrs(struct scsi_cmnd *sc, struct ib_sig_attrs *sig_attrs)
 	return 0;
 }
 
-static inline void
-iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
+static inline void iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
 {
 	*mask = 0;
 	if (sc->prot_flags & SCSI_PROT_REF_CHECK)
@@ -215,11 +211,8 @@ iser_set_prot_checks(struct scsi_cmnd *sc, u8 *mask)
 		*mask |= IB_SIG_CHECK_GUARD;
 }
 
-static inline void
-iser_inv_rkey(struct ib_send_wr *inv_wr,
-	      struct ib_mr *mr,
-	      struct ib_cqe *cqe,
-	      struct ib_send_wr *next_wr)
+static inline void iser_inv_rkey(struct ib_send_wr *inv_wr, struct ib_mr *mr,
+				 struct ib_cqe *cqe, struct ib_send_wr *next_wr)
 {
 	inv_wr->opcode = IB_WR_LOCAL_INV;
 	inv_wr->wr_cqe = cqe;
@@ -229,12 +222,11 @@ iser_inv_rkey(struct ib_send_wr *inv_wr,
 	inv_wr->next = next_wr;
 }
 
-static int
-iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
-		struct iser_data_buf *mem,
-		struct iser_data_buf *sig_mem,
-		struct iser_reg_resources *rsc,
-		struct iser_mem_reg *sig_reg)
+static int iser_reg_sig_mr(struct iscsi_iser_task *iser_task,
+			   struct iser_data_buf *mem,
+			   struct iser_data_buf *sig_mem,
+			   struct iser_reg_resources *rsc,
+			   struct iser_mem_reg *sig_reg)
 {
 	struct iser_tx_desc *tx_desc = &iser_task->desc;
 	struct ib_cqe *cqe = &iser_task->iser_conn->ib_conn.reg_cqe;
@@ -335,42 +327,26 @@ static int iser_fast_reg_mr(struct iscsi_iser_task *iser_task,
 	return 0;
 }
 
-static int
-iser_reg_data_sg(struct iscsi_iser_task *task,
-		 struct iser_data_buf *mem,
-		 struct iser_fr_desc *desc,
-		 bool use_dma_key,
-		 struct iser_mem_reg *reg)
-{
-	struct iser_device *device = task->iser_conn->ib_conn.device;
-
-	if (use_dma_key)
-		return iser_reg_dma(device, mem, reg);
-
-	return iser_fast_reg_mr(task, mem, &desc->rsc, reg);
-}
-
 int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 			 enum iser_data_dir dir,
 			 bool all_imm)
 {
 	struct ib_conn *ib_conn = &task->iser_conn->ib_conn;
+	struct iser_device *device = ib_conn->device;
 	struct iser_data_buf *mem = &task->data[dir];
 	struct iser_mem_reg *reg = &task->rdma_reg[dir];
-	struct iser_fr_desc *desc = NULL;
+	struct iser_fr_desc *desc;
 	bool use_dma_key;
 	int err;
 
 	use_dma_key = mem->dma_nents == 1 && (all_imm || !iser_always_reg) &&
 		      scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL;
+	if (use_dma_key)
+		return iser_reg_dma(device, mem, reg);
 
-	if (!use_dma_key) {
-		desc = iser_reg_desc_get_fr(ib_conn);
-		reg->mem_h = desc;
-	}
-
+	desc = iser_reg_desc_get_fr(ib_conn);
 	if (scsi_get_prot_op(task->sc) == SCSI_PROT_NORMAL) {
-		err = iser_reg_data_sg(task, mem, desc, use_dma_key, reg);
+		err = iser_fast_reg_mr(task, mem, &desc->rsc, reg);
 		if (unlikely(err))
 			goto err_reg;
 	} else {
@@ -382,11 +358,12 @@ int iser_reg_mem_fastreg(struct iscsi_iser_task *task,
 		desc->sig_protected = true;
 	}
 
+	reg->desc = desc;
+
 	return 0;
 
 err_reg:
-	if (desc)
-		iser_reg_desc_put_fr(ib_conn, desc);
+	iser_reg_desc_put_fr(ib_conn, desc);
 
 	return err;
 }
diff --git a/drivers/infiniband/ulp/iser/iser_verbs.c b/drivers/infiniband/ulp/iser/iser_verbs.c
index b5127479860d..725d8a5d2fe9 100644
--- a/drivers/infiniband/ulp/iser/iser_verbs.c
+++ b/drivers/infiniband/ulp/iser/iser_verbs.c
@@ -264,14 +264,14 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 	memset(&init_attr, 0, sizeof(init_attr));
 
 	init_attr.event_handler = iser_qp_event_callback;
-	init_attr.qp_context	= (void *)ib_conn;
-	init_attr.send_cq	= ib_conn->cq;
-	init_attr.recv_cq	= ib_conn->cq;
-	init_attr.cap.max_recv_wr  = ISER_QP_MAX_RECV_DTOS;
+	init_attr.qp_context = (void *)ib_conn;
+	init_attr.send_cq = ib_conn->cq;
+	init_attr.recv_cq = ib_conn->cq;
+	init_attr.cap.max_recv_wr = ISER_QP_MAX_RECV_DTOS;
 	init_attr.cap.max_send_sge = 2;
 	init_attr.cap.max_recv_sge = 1;
-	init_attr.sq_sig_type	= IB_SIGNAL_REQ_WR;
-	init_attr.qp_type	= IB_QPT_RC;
+	init_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
+	init_attr.qp_type = IB_QPT_RC;
 	init_attr.cap.max_send_wr = max_send_wr;
 	if (ib_conn->pi_support)
 		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
@@ -282,9 +282,8 @@ static int iser_create_ib_conn_res(struct ib_conn *ib_conn)
 		goto out_err;
 
 	ib_conn->qp = ib_conn->cma_id->qp;
-	iser_info("setting conn %p cma_id %p qp %p max_send_wr %d\n",
-		  ib_conn, ib_conn->cma_id,
-		  ib_conn->cma_id->qp, max_send_wr);
+	iser_info("setting conn %p cma_id %p qp %p max_send_wr %d\n", ib_conn,
+		  ib_conn->cma_id, ib_conn->cma_id->qp, max_send_wr);
 	return ret;
 
 out_err:
@@ -312,7 +311,7 @@ struct iser_device *iser_device_find_by_ib_device(struct rdma_cm_id *cma_id)
 			goto inc_refcnt;
 
 	device = kzalloc(sizeof *device, GFP_KERNEL);
-	if (device == NULL)
+	if (!device)
 		goto out;
 
 	/* assign this device to the device */
@@ -391,8 +390,7 @@ void iser_release_work(struct work_struct *work)
  * so the cm_id removal is out of here. It is Safe to
  * be invoked multiple times.
  */
-static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
-				  bool destroy)
+static void iser_free_ib_conn_res(struct iser_conn *iser_conn, bool destroy)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	struct iser_device *device = ib_conn->device;
@@ -400,7 +398,7 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
 	iser_info("freeing conn %p cma_id %p qp %p\n",
 		  iser_conn, ib_conn->cma_id, ib_conn->qp);
 
-	if (ib_conn->qp != NULL) {
+	if (ib_conn->qp) {
 		rdma_destroy_qp(ib_conn->cma_id);
 		ib_cq_pool_put(ib_conn->cq, ib_conn->cq_size);
 		ib_conn->qp = NULL;
@@ -410,7 +408,7 @@ static void iser_free_ib_conn_res(struct iser_conn *iser_conn,
 		if (iser_conn->rx_descs)
 			iser_free_rx_descriptors(iser_conn);
 
-		if (device != NULL) {
+		if (device) {
 			iser_device_try_release(device);
 			ib_conn->device = NULL;
 		}
@@ -444,7 +442,7 @@ void iser_conn_release(struct iser_conn *iser_conn)
 	iser_free_ib_conn_res(iser_conn, true);
 	mutex_unlock(&iser_conn->state_mutex);
 
-	if (ib_conn->cma_id != NULL) {
+	if (ib_conn->cma_id) {
 		rdma_destroy_id(ib_conn->cma_id);
 		ib_conn->cma_id = NULL;
 	}
@@ -504,9 +502,8 @@ static void iser_connect_error(struct rdma_cm_id *cma_id)
 	iser_conn->state = ISER_CONN_TERMINATING;
 }
 
-static void
-iser_calc_scsi_params(struct iser_conn *iser_conn,
-		      unsigned int max_sectors)
+static void iser_calc_scsi_params(struct iser_conn *iser_conn,
+				  unsigned int max_sectors)
 {
 	struct iser_device *device = iser_conn->ib_conn.device;
 	struct ib_device_attr *attr = &device->ib_device->attrs;
@@ -544,8 +541,8 @@ iser_calc_scsi_params(struct iser_conn *iser_conn,
 static void iser_addr_handler(struct rdma_cm_id *cma_id)
 {
 	struct iser_device *device;
-	struct iser_conn   *iser_conn;
-	struct ib_conn   *ib_conn;
+	struct iser_conn *iser_conn;
+	struct ib_conn *ib_conn;
 	int    ret;
 
 	iser_conn = (struct iser_conn *)cma_id->context;
@@ -592,7 +589,7 @@ static void iser_addr_handler(struct rdma_cm_id *cma_id)
 static void iser_route_handler(struct rdma_cm_id *cma_id)
 {
 	struct rdma_conn_param conn_param;
-	int    ret;
+	int ret;
 	struct iser_cm_hdr req_hdr;
 	struct iser_conn *iser_conn = (struct iser_conn *)cma_id->context;
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
@@ -608,9 +605,9 @@ static void iser_route_handler(struct rdma_cm_id *cma_id)
 
 	memset(&conn_param, 0, sizeof conn_param);
 	conn_param.responder_resources = ib_dev->attrs.max_qp_rd_atom;
-	conn_param.initiator_depth     = 1;
-	conn_param.retry_count	       = 7;
-	conn_param.rnr_retry_count     = 6;
+	conn_param.initiator_depth = 1;
+	conn_param.retry_count = 7;
+	conn_param.rnr_retry_count = 6;
 
 	memset(&req_hdr, 0, sizeof(req_hdr));
 	req_hdr.flags = ISER_ZBVA_NOT_SUP;
@@ -686,7 +683,8 @@ static void iser_cleanup_handler(struct rdma_cm_id *cma_id,
 	complete(&iser_conn->ib_completion);
 };
 
-static int iser_cma_handler(struct rdma_cm_id *cma_id, struct rdma_cm_event *event)
+static int iser_cma_handler(struct rdma_cm_id *cma_id,
+			    struct rdma_cm_event *event)
 {
 	struct iser_conn *iser_conn;
 	int ret = 0;
@@ -764,10 +762,8 @@ void iser_conn_init(struct iser_conn *iser_conn)
  * starts the process of connecting to the target
  * sleeps until the connection is established or rejected
  */
-int iser_connect(struct iser_conn   *iser_conn,
-		 struct sockaddr    *src_addr,
-		 struct sockaddr    *dst_addr,
-		 int                 non_blocking)
+int iser_connect(struct iser_conn *iser_conn, struct sockaddr *src_addr,
+		 struct sockaddr *dst_addr, int non_blocking)
 {
 	struct ib_conn *ib_conn = &iser_conn->ib_conn;
 	int err = 0;
@@ -928,7 +924,7 @@ u8 iser_check_task_pi_status(struct iscsi_iser_task *iser_task,
 			     enum iser_data_dir cmd_dir, sector_t *sector)
 {
 	struct iser_mem_reg *reg = &iser_task->rdma_reg[cmd_dir];
-	struct iser_fr_desc *desc = reg->mem_h;
+	struct iser_fr_desc *desc = reg->desc;
 	unsigned long sector_size = iser_task->sc->device->sector_size;
 	struct ib_mr_status mr_status;
 	int ret;
diff --git a/drivers/infiniband/ulp/isert/ib_isert.c b/drivers/infiniband/ulp/isert/ib_isert.c
index 2ffcf2bb1c59..b7efdc63f4a7 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.c
+++ b/drivers/infiniband/ulp/isert/ib_isert.c
@@ -21,6 +21,7 @@
 #include <target/target_core_fabric.h>
 #include <target/iscsi/iscsi_transport.h>
 #include <linux/semaphore.h>
+#include <linux/wait_bit.h>
 
 #include "ib_isert.h"
 
@@ -46,7 +47,7 @@ static struct workqueue_struct *isert_comp_wq;
 static struct workqueue_struct *isert_release_wq;
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd);
+isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd);
 static int
 isert_login_post_recv(struct isert_conn *isert_conn);
 static int
@@ -313,6 +314,7 @@ isert_init_conn(struct isert_conn *isert_conn)
 	init_completion(&isert_conn->login_req_comp);
 	init_waitqueue_head(&isert_conn->rem_wait);
 	kref_init(&isert_conn->kref);
+	atomic_set(&isert_conn->ctrl_comp_cnt, 0);
 	mutex_init(&isert_conn->mutex);
 	INIT_WORK(&isert_conn->release_work, isert_release_work);
 }
@@ -1032,21 +1034,21 @@ isert_rx_login_req(struct isert_conn *isert_conn)
 	schedule_delayed_work(&conn->login_work, 0);
 }
 
-static struct iscsi_cmd
+static struct iscsit_cmd
 *isert_allocate_cmd(struct iscsi_conn *conn, struct iser_rx_desc *rx_desc)
 {
 	struct isert_conn *isert_conn = conn->context;
 	struct isert_cmd *isert_cmd;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd) {
-		isert_err("Unable to allocate iscsi_cmd + isert_cmd\n");
+		isert_err("Unable to allocate iscsit_cmd + isert_cmd\n");
 		return NULL;
 	}
 	isert_cmd = iscsit_priv_cmd(cmd);
 	isert_cmd->conn = isert_conn;
-	isert_cmd->iscsi_cmd = cmd;
+	isert_cmd->iscsit_cmd = cmd;
 	isert_cmd->rx_desc = rx_desc;
 
 	return cmd;
@@ -1054,7 +1056,7 @@ static struct iscsi_cmd
 
 static int
 isert_handle_scsi_cmd(struct isert_conn *isert_conn,
-		      struct isert_cmd *isert_cmd, struct iscsi_cmd *cmd,
+		      struct isert_cmd *isert_cmd, struct iscsit_cmd *cmd,
 		      struct iser_rx_desc *rx_desc, unsigned char *buf)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1127,7 +1129,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 {
 	struct scatterlist *sg_start;
 	struct iscsi_conn *conn = isert_conn->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
 	u32 unsol_data_len = ntoh24(hdr->dlength);
 	int rc, sg_nents, sg_off, page_off;
@@ -1183,7 +1185,7 @@ isert_handle_iscsi_dataout(struct isert_conn *isert_conn,
 
 static int
 isert_handle_nop_out(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
-		     struct iscsi_cmd *cmd, struct iser_rx_desc *rx_desc,
+		     struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		     unsigned char *buf)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1202,7 +1204,7 @@ isert_handle_nop_out(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
 
 static int
 isert_handle_text_cmd(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd,
-		      struct iscsi_cmd *cmd, struct iser_rx_desc *rx_desc,
+		      struct iscsit_cmd *cmd, struct iser_rx_desc *rx_desc,
 		      struct iscsi_text *hdr)
 {
 	struct iscsi_conn *conn = isert_conn->conn;
@@ -1233,7 +1235,7 @@ isert_rx_opcode(struct isert_conn *isert_conn, struct iser_rx_desc *rx_desc,
 {
 	struct iscsi_hdr *hdr = isert_get_iscsi_hdr(rx_desc);
 	struct iscsi_conn *conn = isert_conn->conn;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct isert_cmd *isert_cmd;
 	int ret = -EINVAL;
 	u8 opcode = (hdr->opcode & ISCSI_OPCODE_MASK);
@@ -1441,7 +1443,7 @@ isert_login_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 static void
 isert_rdma_rw_ctx_destroy(struct isert_cmd *cmd, struct isert_conn *conn)
 {
-	struct se_cmd *se_cmd = &cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *se_cmd = &cmd->iscsit_cmd->se_cmd;
 	enum dma_data_direction dir = target_reverse_dma_direction(se_cmd);
 
 	if (!cmd->rw.nr_ops)
@@ -1463,7 +1465,7 @@ isert_rdma_rw_ctx_destroy(struct isert_cmd *cmd, struct isert_conn *conn)
 static void
 isert_put_cmd(struct isert_cmd *isert_cmd, bool comp_err)
 {
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 	struct isert_conn *isert_conn = isert_cmd->conn;
 	struct iscsi_conn *conn = isert_conn->conn;
 	struct iscsi_text_rsp *hdr;
@@ -1612,7 +1614,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_device *device = isert_conn->device;
 	struct iser_tx_desc *desc = cqe_to_tx_desc(wc->wr_cqe);
 	struct isert_cmd *isert_cmd = tx_desc_to_cmd(desc);
-	struct se_cmd *cmd = &isert_cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *cmd = &isert_cmd->iscsit_cmd->se_cmd;
 	int ret = 0;
 
 	if (unlikely(wc->status != IB_WC_SUCCESS)) {
@@ -1641,7 +1643,7 @@ isert_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		/*
 		 * XXX: isert_put_response() failure is not retried.
 		 */
-		ret = isert_put_response(isert_conn->conn, isert_cmd->iscsi_cmd);
+		ret = isert_put_response(isert_conn->conn, isert_cmd->iscsit_cmd);
 		if (ret)
 			pr_warn_ratelimited("isert_put_response() ret: %d\n", ret);
 	}
@@ -1654,7 +1656,7 @@ isert_rdma_read_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct isert_device *device = isert_conn->device;
 	struct iser_tx_desc *desc = cqe_to_tx_desc(wc->wr_cqe);
 	struct isert_cmd *isert_cmd = tx_desc_to_cmd(desc);
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	int ret = 0;
 
@@ -1699,7 +1701,9 @@ isert_do_control_comp(struct work_struct *work)
 			struct isert_cmd, comp_work);
 	struct isert_conn *isert_conn = isert_cmd->conn;
 	struct ib_device *ib_dev = isert_conn->cm_id->device;
-	struct iscsi_cmd *cmd = isert_cmd->iscsi_cmd;
+	struct iscsit_cmd *cmd = isert_cmd->iscsit_cmd;
+	/* The switch below may free isert_cmd. */
+	bool counted = isert_cmd->ctrl_counted;
 
 	isert_dbg("Cmd %p i_state %d\n", isert_cmd, cmd->i_state);
 
@@ -1721,6 +1725,14 @@ isert_do_control_comp(struct work_struct *work)
 		dump_stack();
 		break;
 	}
+
+	/*
+	 * The count is what keeps isert_conn alive, so drop it last.  The wait
+	 * queue lives in the global hash table, not in isert_conn, so this is
+	 * safe even if the waiter has already freed the connection.
+	 */
+	if (counted && atomic_dec_and_test(&isert_conn->ctrl_comp_cnt))
+		wake_up_var(&isert_conn->ctrl_comp_cnt);
 }
 
 static void
@@ -1757,18 +1769,24 @@ isert_send_done(struct ib_cq *cq, struct ib_wc *wc)
 
 	isert_dbg("Cmd %p\n", isert_cmd);
 
-	switch (isert_cmd->iscsi_cmd->i_state) {
+	switch (isert_cmd->iscsit_cmd->i_state) {
 	case ISTATE_SEND_TASKMGTRSP:
 	case ISTATE_SEND_LOGOUTRSP:
 	case ISTATE_SEND_REJECT:
 	case ISTATE_SEND_TEXTRSP:
 		isert_unmap_tx_desc(tx_desc, ib_dev);
 
+		/* Paired with the wait in isert_wait_conn(). */
+		isert_cmd->ctrl_counted =
+			isert_cmd->iscsit_cmd->i_state != ISTATE_SEND_LOGOUTRSP;
+		if (isert_cmd->ctrl_counted)
+			atomic_inc(&isert_conn->ctrl_comp_cnt);
+
 		INIT_WORK(&isert_cmd->comp_work, isert_do_control_comp);
 		queue_work(isert_comp_wq, &isert_cmd->comp_work);
 		return;
 	default:
-		isert_cmd->iscsi_cmd->i_state = ISTATE_SENT_STATUS;
+		isert_cmd->iscsit_cmd->i_state = ISTATE_SENT_STATUS;
 		isert_completion_put(tx_desc, isert_cmd, ib_dev, false);
 		break;
 	}
@@ -1792,7 +1810,7 @@ isert_post_response(struct isert_conn *isert_conn, struct isert_cmd *isert_cmd)
 }
 
 static int
-isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_put_response(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1843,7 +1861,7 @@ isert_put_response(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 }
 
 static void
-isert_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1879,7 +1897,7 @@ isert_get_sup_prot_ops(struct iscsi_conn *conn)
 }
 
 static int
-isert_put_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+isert_put_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		bool nopout_response)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -1899,7 +1917,7 @@ isert_put_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 
 static int
-isert_put_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1917,7 +1935,7 @@ isert_put_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_tm_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_tm_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1935,7 +1953,7 @@ isert_put_tm_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -1970,7 +1988,7 @@ isert_put_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int
-isert_put_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+isert_put_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	struct isert_conn *isert_conn = conn->context;
@@ -2072,7 +2090,7 @@ static int
 isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 		struct ib_cqe *cqe, struct ib_send_wr *chain_wr)
 {
-	struct se_cmd *se_cmd = &cmd->iscsi_cmd->se_cmd;
+	struct se_cmd *se_cmd = &cmd->iscsit_cmd->se_cmd;
 	enum dma_data_direction dir = target_reverse_dma_direction(se_cmd);
 	u8 port_num = conn->cm_id->port_num;
 	u64 addr;
@@ -2085,7 +2103,7 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 	if (dir == DMA_FROM_DEVICE) {
 		addr = cmd->write_va;
 		rkey = cmd->write_stag;
-		offset = cmd->iscsi_cmd->write_data_done;
+		offset = cmd->iscsit_cmd->write_data_done;
 	} else {
 		addr = cmd->read_va;
 		rkey = cmd->read_stag;
@@ -2125,7 +2143,7 @@ isert_rdma_rw_ctx_post(struct isert_cmd *cmd, struct isert_conn *conn,
 }
 
 static int
-isert_put_datain(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+isert_put_datain(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
@@ -2166,7 +2184,7 @@ isert_put_datain(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
 }
 
 static int
-isert_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd, bool recovery)
+isert_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd, bool recovery)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret;
@@ -2184,7 +2202,7 @@ isert_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd, bool recovery)
 }
 
 static int
-isert_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+isert_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_cmd *isert_cmd = iscsit_priv_cmd(cmd);
 	int ret = 0;
@@ -2209,7 +2227,7 @@ isert_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
 }
 
 static int
-isert_response_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+isert_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	struct isert_conn *isert_conn = conn->context;
 	int ret;
@@ -2560,7 +2578,7 @@ isert_wait4cmds(struct iscsi_conn *conn)
 static void
 isert_put_unsol_pending_cmds(struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd, *tmp;
+	struct iscsit_cmd *cmd, *tmp;
 	static LIST_HEAD(drop_cmd_list);
 
 	spin_lock_bh(&conn->cmd_lock);
@@ -2598,6 +2616,10 @@ static void isert_wait_conn(struct iscsi_conn *conn)
 	isert_wait4cmds(conn);
 	isert_wait4logout(isert_conn);
 
+	/* Paired with the count taken in isert_send_done(). */
+	wait_var_event(&isert_conn->ctrl_comp_cnt,
+		       !atomic_read(&isert_conn->ctrl_comp_cnt));
+
 	queue_work(isert_release_wq, &isert_conn->release_work);
 }
 
diff --git a/drivers/infiniband/ulp/isert/ib_isert.h b/drivers/infiniband/ulp/isert/ib_isert.h
index 4c2f7d78008f..83fbfb8dbf32 100644
--- a/drivers/infiniband/ulp/isert/ib_isert.h
+++ b/drivers/infiniband/ulp/isert/ib_isert.h
@@ -146,13 +146,14 @@ struct isert_cmd {
 	u64			pdu_buf_dma;
 	u32			pdu_buf_len;
 	struct isert_conn	*conn;
-	struct iscsi_cmd	*iscsi_cmd;
+	struct iscsit_cmd	*iscsit_cmd;
 	struct iser_tx_desc	tx_desc;
 	struct iser_rx_desc	*rx_desc;
 	struct rdma_rw_ctx	rw;
 	struct work_struct	comp_work;
 	struct scatterlist	sg;
 	bool			ctx_init_done;
+	bool			ctrl_counted;
 };
 
 static inline struct isert_cmd *tx_desc_to_cmd(struct iser_tx_desc *desc)
@@ -187,6 +188,7 @@ struct isert_conn {
 	struct mutex		mutex;
 	struct kref		kref;
 	struct work_struct	release_work;
+	atomic_t		ctrl_comp_cnt;
 	bool                    logout_posted;
 	bool                    snd_w_inv;
 	wait_queue_head_t	rem_wait;
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
index db014dae9500..fa49cd71b5d6 100644
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -1231,6 +1231,8 @@ static long evdev_do_ioctl(struct file *file, unsigned int cmd,
 
 			t = _IOC_NR(cmd) & ABS_MAX;
 
+			memset(&abs, 0, sizeof(abs));
+
 			if (copy_from_user(&abs, p, min_t(size_t,
 					size, sizeof(struct input_absinfo))))
 				return -EFAULT;
diff --git a/drivers/input/input-compat.c b/drivers/input/input-compat.c
index 2ccd3eedbd67..2deeb9babc21 100644
--- a/drivers/input/input-compat.c
+++ b/drivers/input/input-compat.c
@@ -75,6 +75,8 @@ int input_ff_effect_from_user(const char __user *buffer, size_t size,
 		 */
 		compat_effect = (struct ff_effect_compat *)effect;
 
+		memset(effect, 0, sizeof(*effect));
+
 		if (copy_from_user(compat_effect, buffer,
 				   sizeof(struct ff_effect_compat)))
 			return -EFAULT;
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 7fdc8e988b6d..b5c3b8f73011 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -209,7 +209,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0139, "Afterglow Prismatic Wired Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x013a, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0146, "Rock Candy Wired Controller for Xbox One", 0, XTYPE_XBOXONE },
-	{ 0x0e6f, 0x0147, "PDP Marvel Xbox One Controller", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x0147, "PDP Marvel Xbox 360 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x015c, "PDP Xbox One Arcade Stick", MAP_TRIGGERS_TO_BUTTONS, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0161, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0162, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
@@ -220,6 +220,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0213, "Afterglow Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x021f, "Rock Candy Gamepad for Xbox 360", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x024c, "PDP Victrix Pro BFG Wired Controller for Xbox", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a0, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a1, "PDP Xbox One Controller", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a2, "PDP Wired Controller for Xbox One - Crimson Red", 0, XTYPE_XBOXONE },
diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index baaa40f1efb0..25dc8a904cae 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1962,6 +1962,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* Xiaomi Redmi Book Pro 16 2026 (TM2425) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "XIAOMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "REDMI Book Pro 16 2026"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{ }
 };
 
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index b9ef03af5263..9ae7b5eefd92 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -16,6 +16,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/gpio_keys.h>
 #include <linux/gpio.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/platform_device.h>
 
 static bool use_low_level_irq;
@@ -160,7 +161,7 @@ soc_button_device_create(struct platform_device *pdev,
 	struct gpio_keys_platform_data *gpio_keys_pdata;
 	const struct dmi_system_id *dmi_id;
 	int invalid_acpi_index = -1;
-	int error, gpio, irq;
+	int error, gpio, irq = 0;
 	int n_buttons = 0;
 
 	for (info = button_info; info->name; info++)
@@ -191,8 +192,9 @@ soc_button_device_create(struct platform_device *pdev,
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
-			 * Skip GPIO if not present. Note we deliberately
-			 * ignore -EPROBE_DEFER errors here. On some devices
+			 * Propagate -EPROBE_DEFER, skip button on other errors.
+			 *
+			 * -EPROBE_DEFER is ignored on Bay & Cherry Trail. Here
 			 * Intel is using so called virtual GPIOs which are not
 			 * GPIOs at all but some way for AML code to check some
 			 * random status bits without need a custom opregion.
@@ -201,6 +203,12 @@ soc_button_device_create(struct platform_device *pdev,
 			 * we do not have a driver for these so they will never
 			 * show up, therefore we ignore -EPROBE_DEFER.
 			 */
+			if ((error == -EPROBE_DEFER || irq == -EPROBE_DEFER) &&
+			    !(soc_intel_is_byt() || soc_intel_is_cht())) {
+				error = -EPROBE_DEFER;
+				goto err_free_mem;
+			}
+
 			continue;
 		}
 
@@ -369,7 +377,7 @@ static struct soc_button_info *soc_button_get_button_info(struct device *dev)
 		}
 	}
 
-	if (!btns_desc) {
+	if (!btns_desc || !btns_desc->package.count) {
 		dev_err(dev, "ACPI Button Descriptors not found\n");
 		button_info = ERR_PTR(-ENODEV);
 		goto out;
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 044b59a6ad56..d57cad88147c 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -1804,6 +1804,14 @@ static int synaptics_setup_intertouch(struct psmouse *psmouse,
 
 			return -ENXIO;
 		}
+
+		/* Disable intertouch on known-broken board revisions */
+		if (info->board_id == 2722) {
+			psmouse_info(psmouse,
+				     "Disabling intertouch for board id %u\n",
+				     info->board_id);
+			return -ENXIO;
+		}
 	}
 
 	psmouse_info(psmouse, "Trying to set up SMBus access\n");
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index ef9ea295f9e0..9a094053c9ce 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -946,6 +946,15 @@ int rmi_driver_suspend(struct rmi_device *rmi_dev, bool enable_wake)
 {
 	int retval;
 
+	/*
+	 * Transport driver will try to suspend RMI device even if physical
+	 * driver did not bind to the RMI device, because transport device
+	 * (I2C, SPI) is fully registered and operational. Exit early if
+	 * there is no driver data attached to the RMI device.
+	 */
+	if (!dev_get_drvdata(&rmi_dev->dev))
+		return 0;
+
 	retval = rmi_suspend_functions(rmi_dev);
 	if (retval)
 		dev_warn(&rmi_dev->dev, "Failed to suspend functions: %d\n",
@@ -960,6 +969,10 @@ int rmi_driver_resume(struct rmi_device *rmi_dev, bool clear_wake)
 {
 	int retval;
 
+	/* Skip if not fully bound to RMI driver */
+	if (!dev_get_drvdata(&rmi_dev->dev))
+		return 0;
+
 	rmi_enable_irq(rmi_dev, clear_wake);
 
 	retval = rmi_resume_functions(rmi_dev);
diff --git a/drivers/input/rmi4/rmi_smbus.c b/drivers/input/rmi4/rmi_smbus.c
index f38bf9a5f599..2a2dda110fce 100644
--- a/drivers/input/rmi4/rmi_smbus.c
+++ b/drivers/input/rmi4/rmi_smbus.c
@@ -140,7 +140,7 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 	u8 commandcode;
 	struct rmi_smb_xport *rmi_smb =
 		container_of(xport, struct rmi_smb_xport, xport);
-	int cur_len = (int)len;
+	size_t cur_len = len;
 
 	mutex_lock(&rmi_smb->page_mutex);
 
@@ -148,7 +148,7 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 		/*
 		 * break into 32 bytes chunks to write get command code
 		 */
-		int block_len = min_t(int, len, SMB_MAX_COUNT);
+		int block_len = min_t(size_t, cur_len, SMB_MAX_COUNT);
 
 		retval = rmi_smb_get_command_code(xport, rmiaddr, block_len,
 						  false, &commandcode);
@@ -161,9 +161,9 @@ static int rmi_smb_write_block(struct rmi_transport_dev *xport, u16 rmiaddr,
 			goto exit;
 
 		/* prepare to write next block of bytes */
-		cur_len -= SMB_MAX_COUNT;
-		databuff += SMB_MAX_COUNT;
-		rmiaddr += SMB_MAX_COUNT;
+		cur_len -= block_len;
+		databuff += block_len;
+		rmiaddr += block_len;
 	}
 exit:
 	mutex_unlock(&rmi_smb->page_mutex);
diff --git a/drivers/input/serio/i8042-acpipnpio.h b/drivers/input/serio/i8042-acpipnpio.h
index 329e9b0fe954..a81ff690e4d2 100644
--- a/drivers/input/serio/i8042-acpipnpio.h
+++ b/drivers/input/serio/i8042-acpipnpio.h
@@ -262,6 +262,13 @@ static const struct dmi_system_id i8042_dmi_quirk_table[] __initconst = {
 		},
 		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Aspire AG15-42P"),
+		},
+		.driver_data = (void *)(SERIO_QUIRK_RESET_ALWAYS)
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
index 33e9d9bfd036..1016cc95fffd 100644
--- a/drivers/input/serio/serport.c
+++ b/drivers/input/serio/serport.c
@@ -243,7 +243,7 @@ static int serport_ldisc_compat_ioctl(struct tty_struct *tty,
 }
 #endif
 
-static int serport_ldisc_hangup(struct tty_struct *tty)
+static void serport_ldisc_hangup(struct tty_struct *tty)
 {
 	struct serport *serport = (struct serport *) tty->disc_data;
 	unsigned long flags;
@@ -253,7 +253,6 @@ static int serport_ldisc_hangup(struct tty_struct *tty)
 	spin_unlock_irqrestore(&serport->lock, flags);
 
 	wake_up_interruptible(&serport->wait);
-	return 0;
 }
 
 static void serport_ldisc_write_wakeup(struct tty_struct * tty)
diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
index 2e1404cd09ec..e12601bb5280 100644
--- a/drivers/input/touchscreen/eeti_ts.c
+++ b/drivers/input/touchscreen/eeti_ts.c
@@ -284,6 +284,7 @@ static const struct of_device_id of_eeti_ts_match[] = {
 	{ .compatible = "eeti,exc3000-i2c", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, of_eeti_ts_match);
 #endif
 
 static struct i2c_driver eeti_ts_driver = {
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 12551dc11714..b6a656260dea 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -75,6 +75,8 @@
 #define SPAGE_ORDER 12
 #define SPAGE_SIZE (1 << SPAGE_ORDER)
 
+#define DISABLE_FETCH_DTE_TIME_LIMIT BIT(31)
+
  /*
   * Support mapping any size that fits in one page table:
   *   4 KiB to 4 MiB
@@ -864,6 +866,7 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 	struct iommu_domain *domain = iommu->domain;
 	struct rk_iommu_domain *rk_domain = to_rk_domain(domain);
 	int ret, i;
+	u32 auto_gate;
 
 	ret = clk_bulk_enable(iommu->num_clocks, iommu->clocks);
 	if (ret)
@@ -882,6 +885,11 @@ static int rk_iommu_enable(struct rk_iommu *iommu)
 			       rk_domain->dt_dma);
 		rk_iommu_base_command(iommu->bases[i], RK_MMU_CMD_ZAP_CACHE);
 		rk_iommu_write(iommu->bases[i], RK_MMU_INT_MASK, RK_MMU_IRQ_MASK);
+
+		/* Workaround for iommu blocked, BIT(31) default to 1 */
+		auto_gate = rk_iommu_read(iommu->bases[i], RK_MMU_AUTO_GATING);
+		auto_gate |= DISABLE_FETCH_DTE_TIME_LIMIT;
+		rk_iommu_write(iommu->bases[i], RK_MMU_AUTO_GATING, auto_gate);
 	}
 
 	ret = rk_iommu_enable_paging(iommu);
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b828737487bf..2fd553bfa8f8 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5426,6 +5426,7 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
 		its_acpi_probe();
 
 	if (list_empty(&its_nodes)) {
+		rdists->has_vlpis = false;
 		pr_warn("ITS: No ITS available, not enabling LPIs\n");
 		return -ENXIO;
 	}
diff --git a/drivers/leds/leds-pca9532.c b/drivers/leds/leds-pca9532.c
index e350d5a588d6..1cf39aecaf08 100644
--- a/drivers/leds/leds-pca9532.c
+++ b/drivers/leds/leds-pca9532.c
@@ -177,11 +177,13 @@ static int pca9532_set_brightness(struct led_classdev *led_cdev,
 	int err = 0;
 	struct pca9532_led *led = ldev_to_led(led_cdev);
 
-	if (value == LED_OFF)
+	if (value == LED_OFF) {
 		led->state = PCA9532_OFF;
-	else if (value == LED_FULL)
+	} else if (led->state == PCA9532_PWM1) {
+		return 0; /* Non-zero brightness shall not stop HW blinking */
+	} else if (value == LED_FULL) {
 		led->state = PCA9532_ON;
-	else {
+	} else {
 		led->state = PCA9532_PWM0; /* Thecus: hardcode one pwm */
 		err = pca9532_calcpwm(led->client, 0, 0, value);
 		if (err)
diff --git a/drivers/leds/uleds.c b/drivers/leds/uleds.c
index 90e54370fe7e..3e47cb74f49a 100644
--- a/drivers/leds/uleds.c
+++ b/drivers/leds/uleds.c
@@ -148,10 +148,13 @@ static ssize_t uleds_read(struct file *file, char __user *buffer, size_t count,
 		} else if (!udev->new_data && (file->f_flags & O_NONBLOCK)) {
 			retval = -EAGAIN;
 		} else if (udev->new_data) {
-			retval = copy_to_user(buffer, &udev->brightness,
-					      sizeof(udev->brightness));
-			udev->new_data = false;
-			retval = sizeof(udev->brightness);
+			if (copy_to_user(buffer, &udev->brightness,
+					 sizeof(udev->brightness))) {
+				retval = -EFAULT;
+			} else {
+				udev->new_data = false;
+				retval = sizeof(udev->brightness);
+			}
 		}
 
 		mutex_unlock(&udev->mutex);
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 363eaf3c962e..1dda26c98d75 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -110,8 +110,10 @@ static void tx_tick(struct mbox_chan *chan, int r)
 	if (chan->cl->tx_done)
 		chan->cl->tx_done(chan->cl, mssg, r);
 
-	if (r != -ETIME && chan->cl->tx_block)
+	if (r != -ETIME && chan->cl->tx_block) {
+		chan->tx_status = r;
 		complete(&chan->tx_complete);
+	}
 }
 
 static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
@@ -281,6 +283,8 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 		if (ret == 0) {
 			t = -ETIME;
 			tx_tick(chan, t);
+		} else if (chan->tx_status < 0) {
+			t = chan->tx_status;
 		}
 	}
 
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 637acb8ef60d..5e929ceb4580 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -911,7 +911,7 @@ static void stripe_add_to_batch_list(struct r5conf *conf, struct stripe_head *sh
 	if (test_and_clear_bit(STRIPE_BIT_DELAY, &sh->state)) {
 		int seq = sh->bm_seq;
 		if (test_bit(STRIPE_BIT_DELAY, &sh->batch_head->state) &&
-		    sh->batch_head->bm_seq > seq)
+		    sh->batch_head->bm_seq - seq > 0)
 			seq = sh->batch_head->bm_seq;
 		set_bit(STRIPE_BIT_DELAY, &sh->batch_head->state);
 		sh->batch_head->bm_seq = seq;
diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 4ccd66cba2ca..1de7e47d0ae7 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -458,8 +458,9 @@ static int video_i2c_thread_vid_cap(void *priv)
 		spin_lock(&data->slock);
 
 		if (!list_empty(&data->vid_cap_active)) {
-			vid_cap_buf = list_last_entry(&data->vid_cap_active,
-						 struct video_i2c_buffer, list);
+			vid_cap_buf = list_first_entry(&data->vid_cap_active,
+						       struct video_i2c_buffer,
+						       list);
 			list_del(&vid_cap_buf->list);
 		}
 
diff --git a/drivers/media/pci/dm1105/dm1105.c b/drivers/media/pci/dm1105/dm1105.c
index f00ae8d3b5e3..db08652782ec 100644
--- a/drivers/media/pci/dm1105/dm1105.c
+++ b/drivers/media/pci/dm1105/dm1105.c
@@ -769,6 +769,8 @@ static void dm1105_ir_exit(struct dm1105_dev *dm1105)
 
 static int dm1105_hw_init(struct dm1105_dev *dev)
 {
+	int ret;
+
 	dm1105_disable_irqs(dev);
 
 	dm_writeb(DM1105_HOST_CTR, 0);
@@ -779,7 +781,10 @@ static int dm1105_hw_init(struct dm1105_dev *dev)
 	dm_writew(DM1105_TSCTR, 0xc10a);
 
 	/* map DMA and set address */
-	dm1105_dma_map(dev);
+	ret = dm1105_dma_map(dev);
+	if (ret)
+		return -ENOMEM;
+
 	dm1105_set_dma_addr(dev);
 	/* big buffer */
 	dm_writel(DM1105_RLEN, 5 * DM1105_DMA_BYTES);
diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 565826cff0db..dcdccfe5a731 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -295,6 +295,10 @@ static const struct imon_usb_dev_descr imon_OEM_VFD = {
 		{ 0x000100000000ffeell, KEY_VOLUMEUP },
 		{ 0x010000000000ffeell, KEY_VOLUMEDOWN },
 		{ 0x000000000100ffeell, KEY_MUTE },
+		/* iMON VFD HID OEM v1.2 */
+		{ 0x000000000a00ffeell, KEY_VOLUMEUP },
+		{ 0x000000000b00ffeell, KEY_VOLUMEDOWN },
+		{ 0x000000000c00ffeell, KEY_MUTE },
 		/* 0xffdc iMON MCE VFD */
 		{ 0x00010000ffffffeell, KEY_VOLUMEUP },
 		{ 0x01000000ffffffeell, KEY_VOLUMEDOWN },
diff --git a/drivers/media/rc/mceusb.c b/drivers/media/rc/mceusb.c
index 142319c48405..ec7794b4f551 100644
--- a/drivers/media/rc/mceusb.c
+++ b/drivers/media/rc/mceusb.c
@@ -398,6 +398,8 @@ static const struct usb_device_id mceusb_dev_table[] = {
 	{ USB_DEVICE(VENDOR_COMPRO, 0x3082) },
 	/* Northstar Systems, Inc. eHome Infrared Transceiver */
 	{ USB_DEVICE(VENDOR_NORTHSTAR, 0xe004) },
+	/* Northstar Systems, Inc. eHome Infrared Transceiver - variant */
+	{ USB_DEVICE(VENDOR_NORTHSTAR, 0xe033) },
 	/* TiVo PC IR Receiver */
 	{ USB_DEVICE(VENDOR_TIVO, 0x2000),
 	  .driver_info = TIVO_KIT },
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index b086b2abf082..ffc7ae1ee3a9 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -1115,8 +1115,10 @@ int em28xx_start_analog_streaming(struct vb2_queue *vq, unsigned int count)
 					  dev->max_pkt_size,
 					  dev->packet_multiplier,
 					  em28xx_urb_data_copy);
-		if (rc < 0)
+		if (rc < 0) {
+			res_free(dev, vq->type);
 			return rc;
+		}
 
 		/*
 		 * djh: it's not clear whether this code is still needed.  I'm
diff --git a/drivers/media/v4l2-core/v4l2-h264.c b/drivers/media/v4l2-core/v4l2-h264.c
index 5633a242520a..49b5ce5c99d3 100644
--- a/drivers/media/v4l2-core/v4l2-h264.c
+++ b/drivers/media/v4l2-core/v4l2-h264.c
@@ -258,7 +258,8 @@ v4l2_h264_build_b_ref_lists(const struct v4l2_h264_reflist_builder *builder,
 	       v4l2_h264_b1_ref_list_cmp, NULL, builder);
 
 	if (builder->num_valid > 1 &&
-	    !memcmp(b1_reflist, b0_reflist, builder->num_valid))
+	    !memcmp(b1_reflist, b0_reflist,
+			sizeof(b1_reflist[0]) * builder->num_valid))
 		swap(b1_reflist[0], b1_reflist[1]);
 }
 EXPORT_SYMBOL_GPL(v4l2_h264_build_b_ref_lists);
diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 6676f8883c9c..cfd9b04e27f6 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -410,8 +410,8 @@ void mmc_remove_card(struct mmc_card *card)
 				mmc_hostname(card->host), card->rca);
 		}
 		device_del(&card->dev);
-		of_node_put(card->dev.of_node);
 	}
+	of_node_put(card->dev.of_node);
 
 	if (host->cqe_enabled) {
 		host->cqe_ops->cqe_disable(host);
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index be4067281caa..c2356e8230df 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -103,6 +103,9 @@ static int sdio_uart_add_port(struct sdio_uart_port *port)
 	}
 	spin_unlock(&sdio_uart_table_lock);
 
+	if (ret)
+		kfifo_free(&port->xmit_fifo);
+
 	return ret;
 }
 
diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index 77258948440f..887acabf96fb 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -934,7 +934,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 		}
 	}
 
-	if (qstatus & MMCST0_TOUTRD) {
+	if (data && (qstatus & MMCST0_TOUTRD)) {
 		/* Read data timeout */
 		data->error = -ETIMEDOUT;
 		end_transfer = 1;
@@ -946,7 +946,7 @@ static irqreturn_t mmc_davinci_irq(int irq, void *dev_id)
 		davinci_abort_data(host, data);
 	}
 
-	if (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD)) {
+	if (data && (qstatus & (MMCST0_CRCWR | MMCST0_CRCRD))) {
 		/* Data CRC error */
 		data->error = -EILSEQ;
 		end_transfer = 1;
@@ -1305,14 +1305,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 		goto cpu_freq_fail;
 	}
 
-	ret = mmc_add_host(mmc);
-	if (ret < 0)
-		goto mmc_add_host_fail;
-
 	ret = devm_request_irq(&pdev->dev, irq, mmc_davinci_irq, 0,
 			       mmc_hostname(mmc), host);
 	if (ret)
-		goto request_irq_fail;
+		goto mmc_add_host_fail;
 
 	if (host->sdio_irq >= 0) {
 		ret = devm_request_irq(&pdev->dev, host->sdio_irq,
@@ -1322,6 +1318,10 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 			mmc->caps |= MMC_CAP_SDIO_IRQ;
 	}
 
+	ret = mmc_add_host(mmc);
+	if (ret < 0)
+		goto mmc_add_host_fail;
+
 	rename_region(mem, mmc_hostname(mmc));
 
 	dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
@@ -1330,8 +1330,6 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	return 0;
 
-request_irq_fail:
-	mmc_remove_host(mmc);
 mmc_add_host_fail:
 	mmc_davinci_cpufreq_deregister(host);
 cpu_freq_fail:
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index d85e5f7f5011..bc4e21dc1f98 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -966,6 +966,7 @@ static void mmc_spi_request(struct mmc_host *mmc, struct mmc_request *mrq)
 			status = mmc_spi_command_send(host, mrq, &stop, 0);
 			crc_retry--;
 			mrq->data->error = 0;
+			mrq->data->bytes_xfered = 0;
 			goto crc_recover;
 		}
 
diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 93a105b07564..8806ef98f80e 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1195,6 +1195,10 @@ static int mxcmci_remove(struct platform_device *pdev)
 
 	mmc_remove_host(mmc);
 
+	devm_free_irq(&pdev->dev, platform_get_irq(pdev, 0), host);
+	cancel_work_sync(&host->datawork);
+	timer_delete_sync(&host->watchdog);
+
 	if (host->pdata && host->pdata->exit)
 		host->pdata->exit(&pdev->dev, mmc);
 
diff --git a/drivers/mmc/host/sdhci-of-aspeed.c b/drivers/mmc/host/sdhci-of-aspeed.c
index 60810de52d4d..079f4c5ab4b0 100644
--- a/drivers/mmc/host/sdhci-of-aspeed.c
+++ b/drivers/mmc/host/sdhci-of-aspeed.c
@@ -288,12 +288,14 @@ static int aspeed_sdc_probe(struct platform_device *pdev)
 		if (!cpdev) {
 			of_node_put(child);
 			ret = -ENODEV;
-			goto err_clk;
+			goto err_children;
 		}
 	}
 
 	return 0;
 
+err_children:
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 err_clk:
 	clk_disable_unprepare(sdc->clk);
 	return ret;
@@ -303,6 +305,7 @@ static int aspeed_sdc_remove(struct platform_device *pdev)
 {
 	struct aspeed_sdc *sdc = dev_get_drvdata(&pdev->dev);
 
+	device_for_each_child_reverse(&pdev->dev, NULL, of_platform_device_destroy);
 	clk_disable_unprepare(sdc->clk);
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 6ed4ed6071e4..fdcbd6d6ebd0 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -415,15 +415,13 @@ static int sdhci_am654_execute_tuning(struct mmc_host *mmc, u32 opcode)
 	struct sdhci_host *host = mmc_priv(mmc);
 	int err = sdhci_execute_tuning(mmc, opcode);
 
-	if (err)
-		return err;
 	/*
 	 * Tuning data remains in the buffer after tuning.
 	 * Do a command and data reset to get rid of it
 	 */
 	sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
 
-	return 0;
+	return err;
 }
 
 static u32 sdhci_am654_cqhci_irq(struct sdhci_host *host, u32 intmask)
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 5dec9e239c9b..a3d40f9bac68 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1422,6 +1422,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	host->pd = pdev;
 
 	spin_lock_init(&host->lock);
+	mutex_init(&host->thread_lock);
 
 	mmc->ops = &sh_mmcif_ops;
 	sh_mmcif_init_ocr(host);
@@ -1482,8 +1483,6 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 		}
 	}
 
-	mutex_init(&host->thread_lock);
-
 	ret = mmc_add_host(mmc);
 	if (ret < 0)
 		goto err_clk;
diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
index dff22eddc885..b6bf69a6f2ee 100644
--- a/drivers/net/bonding/bond_alb.c
+++ b/drivers/net/bonding/bond_alb.c
@@ -665,9 +665,15 @@ static struct slave *rlb_arp_xmit(struct sk_buff *skb, struct bonding *bond)
 	if (arp->op_code == htons(ARPOP_REPLY)) {
 		/* the arp must be sent on the selected rx channel */
 		tx_slave = rlb_choose_channel(skb, bond, arp);
-		if (tx_slave)
+		if (tx_slave &&
+		    !ether_addr_equal_64bits(arp->mac_src,
+					     tx_slave->dev->dev_addr)) {
+			if (unlikely(skb_cow_head(skb, 0)))
+				return NULL;
+			arp = (struct arp_pkt *)skb_network_header(skb);
 			bond_hw_addr_copy(arp->mac_src, tx_slave->dev->dev_addr,
 					  tx_slave->dev->addr_len);
+		}
 		netdev_dbg(bond->dev, "(slave %s): Server sent ARP Reply packet\n",
 			   tx_slave ? tx_slave->dev->name : "NULL");
 	} else if (arp->op_code == htons(ARPOP_REQUEST)) {
@@ -1307,7 +1313,6 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 				    struct slave *tx_slave)
 {
 	struct alb_bond_info *bond_info = &(BOND_ALB_INFO(bond));
-	struct ethhdr *eth_data = eth_hdr(skb);
 
 	if (!tx_slave) {
 		/* unbalanced or unassigned, send through primary */
@@ -1318,7 +1323,9 @@ static netdev_tx_t bond_do_alb_xmit(struct sk_buff *skb, struct bonding *bond,
 
 	if (tx_slave && bond_slave_can_tx(tx_slave)) {
 		if (tx_slave != rcu_access_pointer(bond->curr_active_slave)) {
-			ether_addr_copy(eth_data->h_source,
+			if (unlikely(skb_cow_head(skb, 0)))
+				return bond_tx_drop(bond->dev, skb);
+			ether_addr_copy(skb_eth_hdr(skb)->h_source,
 					tx_slave->dev->dev_addr);
 		}
 
@@ -1342,8 +1349,7 @@ struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,
 	struct ethhdr *eth_data;
 	u32 hash_index;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	/* Do not TX balance any multicast or broadcast */
 	if (!is_multicast_ether_addr(eth_data->h_dest)) {
@@ -1394,8 +1400,7 @@ struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 	u32 hash_index = 0;
 	int hash_size = 0;
 
-	skb_reset_mac_header(skb);
-	eth_data = eth_hdr(skb);
+	eth_data = skb_eth_hdr(skb);
 
 	switch (ntohs(skb->protocol)) {
 	case ETH_P_IP: {
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 1c90724603d6..e977fd528d75 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2272,9 +2272,7 @@ static int __bond_release_one(struct net_device *bond_dev,
 		bond_alb_deinit_slave(bond, slave);
 	}
 
-	if (all) {
-		RCU_INIT_POINTER(bond->curr_active_slave, NULL);
-	} else if (oldcurrent == slave) {
+	if (!all && oldcurrent == slave) {
 		/* Note that we hold RTNL over this sequence, so there
 		 * is no concern that another slave add/remove event
 		 * will interfere.
diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 972827db819a..d1833aafc40c 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -662,10 +662,9 @@ static void slcan_close(struct tty_struct *tty)
 	/* This will complete via sl_free_netdev */
 }
 
-static int slcan_hangup(struct tty_struct *tty)
+static void slcan_hangup(struct tty_struct *tty)
 {
 	slcan_close(tty);
-	return 0;
 }
 
 /* Perform I/O control on an active SLCAN channel. */
diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 65aa1100e894..a645962da37a 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -402,6 +402,40 @@ static void ems_usb_rx_err(struct ems_usb *dev, struct ems_cpc_msg *msg)
 	netif_rx(skb);
 }
 
+static bool ems_usb_rx_msg_len_valid(struct ems_cpc_msg *msg)
+{
+	size_t len = msg->length;
+	size_t can_len;
+
+	switch (msg->type) {
+	case CPC_MSG_TYPE_CAN_STATE:
+		return len >= sizeof(msg->msg.can_state);
+
+	case CPC_MSG_TYPE_CAN_FRAME:
+	case CPC_MSG_TYPE_EXT_CAN_FRAME:
+	case CPC_MSG_TYPE_RTR_FRAME:
+	case CPC_MSG_TYPE_EXT_RTR_FRAME:
+		if (len < CPC_CAN_MSG_MIN_SIZE)
+			return false;
+
+		if (msg->type == CPC_MSG_TYPE_RTR_FRAME ||
+		    msg->type == CPC_MSG_TYPE_EXT_RTR_FRAME)
+			return true;
+
+		can_len = get_can_dlc(msg->msg.can_msg.length & 0xf);
+		return len >= CPC_CAN_MSG_MIN_SIZE + can_len;
+
+	case CPC_MSG_TYPE_CAN_FRAME_ERROR:
+		return len >= sizeof(msg->msg.error);
+
+	case CPC_MSG_TYPE_OVERRUN:
+		return len >= sizeof(msg->msg.overrun);
+
+	default:
+		return true;
+	}
+}
+
 /*
  * callback for bulk IN urb
  */
@@ -444,6 +478,15 @@ static void ems_usb_read_bulk_callback(struct urb *urb)
 			}
 
 			msg = (struct ems_cpc_msg *)&ibuf[start];
+			if (msg->length >
+			    urb->actual_length - start - CPC_MSG_HEADER_LEN) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
+			if (!ems_usb_rx_msg_len_valid(msg)) {
+				netdev_err(netdev, "format error\n");
+				break;
+			}
 
 			switch (msg->type) {
 			case CPC_MSG_TYPE_CAN_STATE:
diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.c
index cbf44fc7d03a..5c24a8ce2941 100644
--- a/drivers/net/dsa/bcm_sf2_cfp.c
+++ b/drivers/net/dsa/bcm_sf2_cfp.c
@@ -1092,6 +1092,8 @@ static int bcm_sf2_cfp_rule_get_all(struct bcm_sf2_priv *priv,
 	unsigned int index = 1, rules_cnt = 0;
 
 	for_each_set_bit_from(index, priv->cfp.unique, priv->num_cfp_rules) {
+		if (rules_cnt == nfc->rule_cnt)
+			return -EMSGSIZE;
 		rule_locs[rules_cnt] = index;
 		rules_cnt++;
 	}
diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ebc858087394..1822c8e137c5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1829,6 +1829,7 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
 	struct ethtool_rx_flow_spec *fs = &rxnfc->fs;
 	struct mv88e6xxx_chip *chip = ds->priv;
 	struct mv88e6xxx_policy *policy;
+	u32 cnt = 0;
 	int err;
 	int id;
 
@@ -1854,11 +1855,18 @@ static int mv88e6xxx_get_rxnfc(struct dsa_switch *ds, int port,
 		break;
 	case ETHTOOL_GRXCLSRLALL:
 		rxnfc->data = 0;
-		rxnfc->rule_cnt = 0;
-		idr_for_each_entry(&chip->policies, policy, id)
-			if (policy->port == port)
-				rule_locs[rxnfc->rule_cnt++] = id;
 		err = 0;
+		idr_for_each_entry(&chip->policies, policy, id) {
+			if (policy->port != port)
+				continue;
+			if (cnt == rxnfc->rule_cnt) {
+				err = -EMSGSIZE;
+				break;
+			}
+			rule_locs[cnt++] = id;
+		}
+		if (!err)
+			rxnfc->rule_cnt = cnt;
 		break;
 	default:
 		err = -EOPNOTSUPP;
@@ -4170,6 +4178,7 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.pot_clear = mv88e6xxx_g2_pot_clear,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4212,6 +4221,7 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.watchdog_ops = &mv88e6390_watchdog_ops,
 	.mgmt_rsvd2cpu = mv88e6352_g2_mgmt_rsvd2cpu,
 	.reset = mv88e6352_g1_reset,
+	.rmu_disable = mv88e6352_g1_rmu_disable,
 	.vtu_getnext = mv88e6352_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6352_g1_vtu_loadpurge,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -5036,7 +5046,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
 		.pvt = true,
@@ -5061,7 +5071,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 15000,
-		.g1_irqs = 8,
+		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.atu_move_port_mask = 0xf,
 		.multi_chip = true,
diff --git a/drivers/net/dsa/sja1105/sja1105_flower.c b/drivers/net/dsa/sja1105/sja1105_flower.c
index 12e76020bea3..6cbe4ee310ea 100644
--- a/drivers/net/dsa/sja1105/sja1105_flower.c
+++ b/drivers/net/dsa/sja1105/sja1105_flower.c
@@ -345,9 +345,9 @@ int sja1105_cls_flower_add(struct dsa_switch *ds, int port,
 			struct dsa_port *to_dp;
 
 			to_dp = dsa_port_from_netdev(act->dev);
-			if (IS_ERR(to_dp)) {
+			if (IS_ERR(to_dp) || to_dp->ds != ds) {
 				NL_SET_ERR_MSG_MOD(extack,
-						   "Destination not a switch port");
+						   "Destination not a local switch port");
 				return -EOPNOTSUPP;
 			}
 
diff --git a/drivers/net/ethernet/allwinner/sun4i-emac.c b/drivers/net/ethernet/allwinner/sun4i-emac.c
index 8ce1fb0a8d55..f52ea6f7b65d 100644
--- a/drivers/net/ethernet/allwinner/sun4i-emac.c
+++ b/drivers/net/ethernet/allwinner/sun4i-emac.c
@@ -890,6 +890,7 @@ static int emac_probe(struct platform_device *pdev)
 	return 0;
 
 out_release_sram:
+	of_node_put(db->phy_node);
 	sunxi_sram_release(&pdev->dev);
 out_clk_disable_unprepare:
 	clk_disable_unprepare(db->clk);
@@ -911,6 +912,7 @@ static int emac_remove(struct platform_device *pdev)
 	struct emac_board_info *db = netdev_priv(ndev);
 
 	unregister_netdev(ndev);
+	of_node_put(db->phy_node);
 	sunxi_sram_release(&pdev->dev);
 	clk_disable_unprepare(db->clk);
 	irq_dispose_mapping(ndev->irq);
diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 19e195420e24..d3ad4716d72a 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -943,9 +943,10 @@ static int au1000_close(struct net_device *dev)
 	/* stop the device */
 	netif_stop_queue(dev);
 
+	spin_unlock_irqrestore(&aup->lock, flags);
+
 	/* disable the interrupt */
 	free_irq(dev->irq, dev);
-	spin_unlock_irqrestore(&aup->lock, flags);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 0f7d33632853..8f9561ec83a1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3388,7 +3388,7 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
 
 	/* Enable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
@@ -3399,7 +3399,6 @@ static void xgbe_disable_rx(struct xgbe_prv_data *pdata)
 	unsigned int i;
 
 	/* Disable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 0);
diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 2c5af0d7666a..46a293b8a21c 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1545,6 +1545,9 @@ static bool atl1c_clean_tx_irq(struct atl1c_adapter *adapter,
 
 	AT_READ_REGW(&adapter->hw, reg, &hw_next_to_clean);
 
+	if (unlikely(hw_next_to_clean >= tpd_ring->count))
+		hw_next_to_clean = next_to_clean;
+
 	while (next_to_clean != hw_next_to_clean) {
 		buffer_info = &tpd_ring->buffer_info[next_to_clean];
 		if (buffer_info->skb) {
diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
index e8772972bc2f..ea835f1ca959 100644
--- a/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
+++ b/drivers/net/ethernet/atheros/atl1e/atl1e_main.c
@@ -1234,6 +1234,9 @@ static bool atl1e_clean_tx_irq(struct atl1e_adapter *adapter)
 	u16 hw_next_to_clean = AT_READ_REGW(&adapter->hw, REG_TPD_CONS_IDX);
 	u16 next_to_clean = atomic_read(&tx_ring->next_to_clean);
 
+	if (unlikely(hw_next_to_clean >= tx_ring->count))
+		hw_next_to_clean = next_to_clean;
+
 	while (next_to_clean != hw_next_to_clean) {
 		tx_buffer = &tx_ring->tx_buffer[next_to_clean];
 		if (tx_buffer->dma) {
diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index 2e950313f427..dc822e8c4070 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -2066,6 +2066,9 @@ static int atl1_intr_tx(struct atl1_adapter *adapter)
 	sw_tpd_next_to_clean = atomic_read(&tpd_ring->next_to_clean);
 	cmb_tpd_next_to_clean = le16_to_cpu(adapter->cmb.cmb->tpd_cons_idx);
 
+	if (unlikely(cmb_tpd_next_to_clean >= tpd_ring->count))
+		cmb_tpd_next_to_clean = sw_tpd_next_to_clean;
+
 	while (cmb_tpd_next_to_clean != sw_tpd_next_to_clean) {
 		buffer_info = &tpd_ring->buffer_info[sw_tpd_next_to_clean];
 		if (buffer_info->dma) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f36b2bae3799..ee849e49f373 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8448,8 +8448,13 @@ static int bnxt_shutdown_nic(struct bnxt *bp, bool irq_re_init)
 
 static int bnxt_init_nic(struct bnxt *bp, bool irq_re_init)
 {
+	int rc;
+
 	bnxt_init_cp_rings(bp);
-	bnxt_init_rx_rings(bp);
+	rc = bnxt_init_rx_rings(bp);
+	if (rc)
+		return rc;
+
 	bnxt_init_tx_rings(bp);
 	bnxt_init_ring_grps(bp, irq_re_init);
 	bnxt_init_vnics(bp);
@@ -10923,7 +10928,14 @@ static void bnxt_rx_ring_reset(struct bnxt *bp)
 		rxr->rx_sw_agg_prod = 0;
 		rxr->rx_next_cons = 0;
 		rxr->bnapi->in_reset = false;
-		bnxt_alloc_one_rx_ring(bp, i);
+		rc = bnxt_alloc_one_rx_ring(bp, i);
+		if (rc) {
+			netdev_warn(bp->dev, "RX ring reset failed to allocate buffers, rc = %d, falling back to global reset\n",
+				    rc);
+			bnxt_reset_task(bp, true);
+			bnxt_rtnl_unlock_sp(bp);
+			return;
+		}
 		cpr = &rxr->bnapi->cp_ring;
 		cpr->sw_stats.rx.rx_resets++;
 		if (bp->flags & BNXT_FLAG_AGG_RINGS)
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 954a51fe0cd7..92425b387b54 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18028,6 +18028,10 @@ static int tg3_init_one(struct pci_dev *pdev,
 	return 0;
 
 err_out_apeunmap:
+	if (tg3_flag(tp, USE_PHYLIB))
+		tg3_phy_fini(tp);
+	tg3_mdio_fini(tp);
+
 	if (tp->aperegs) {
 		iounmap(tp->aperegs);
 		tp->aperegs = NULL;
diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 3e93d1115f1a..c66d2ea4e541 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -123,6 +123,7 @@ struct gemini_ethernet_port {
 	unsigned int		rx_coalesce_nsecs;
 	struct sk_buff		*rx_skb;
 	unsigned int		rx_frag_nr;
+	bool			rx_dropping;
 
 	unsigned int		freeq_refill;
 	struct gmac_txq		txq[TX_QUEUE_NUM];
@@ -1409,7 +1410,8 @@ static struct sk_buff *gmac_skb_if_good_frame(struct gemini_ethernet_port *port,
 	return skb;
 }
 
-static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
+static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
+			    unsigned int *freeq_consumed)
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	unsigned short m = (1 << port->rxq_order) - 1;
@@ -1417,9 +1419,12 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	void __iomem *ptr_reg = port->rxq_rwptr;
 	unsigned int frag_nr = port->rx_frag_nr;
 	struct sk_buff *skb = port->rx_skb;
+	unsigned int consumed = 0;
 	unsigned int frame_len, frag_len;
 	struct gmac_rxdesc *rx = NULL;
 	struct gmac_queue_page *gpage;
+	unsigned int received = 0;
+	bool dropping = port->rx_dropping;
 	union gmac_rxdesc_0 word0;
 	union gmac_rxdesc_1 word1;
 	union gmac_rxdesc_3 word3;
@@ -1441,6 +1446,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	w = rw.bits.wptr;
 
 	while (budget && w != r) {
+		page = NULL;
 		rx = port->rxq_ring + r;
 		word0 = rx->word0;
 		word1 = rx->word1;
@@ -1449,11 +1455,22 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 
 		r++;
 		r &= m;
+		consumed++;
 
 		frag_len = word0.bits.buffer_size;
 		frame_len = word1.bits.byte_count;
 		page_offs = mapping & ~PAGE_MASK;
 
+		if (word3.bits32 & SOF_BIT) {
+			if (skb) {
+				napi_free_frags(&port->napi);
+				port->stats.rx_dropped++;
+				skb = NULL;
+				frag_nr = 0;
+			}
+			dropping = false;
+		}
+
 		if (!mapping) {
 			netdev_err(netdev,
 				   "rxq[%u]: HW BUG: zero DMA desc\n", r);
@@ -1464,24 +1481,11 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 		gpage = gmac_get_queue_page(geth, port, mapping + PAGE_SIZE);
 		if (!gpage) {
 			dev_err(geth->dev, "could not find mapping\n");
-			if (skb) {
-				napi_free_frags(&port->napi);
-				port->stats.rx_dropped++;
-				skb = NULL;
-				frag_nr = 0;
-			}
-			continue;
+			goto err_drop;
 		}
 		page = gpage->page;
 
 		if (word3.bits32 & SOF_BIT) {
-			if (skb) {
-				napi_free_frags(&port->napi);
-				port->stats.rx_dropped++;
-				skb = NULL;
-				frag_nr = 0;
-			}
-
 			skb = gmac_skb_if_good_frame(port, word0, frame_len);
 			if (!skb)
 				goto err_drop;
@@ -1491,8 +1495,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			frag_nr = 0;
 
 		} else if (!skb) {
-			put_page(page);
-			continue;
+			goto err_drop;
 		}
 
 		if (word3.bits32 & EOF_BIT)
@@ -1515,9 +1518,8 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			napi_gro_frags(&port->napi);
 			skb = NULL;
 			frag_nr = 0;
-			--budget;
 		}
-		continue;
+		goto next_desc;
 
 err_drop:
 		if (skb) {
@@ -1526,16 +1528,29 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 			frag_nr = 0;
 		}
 
-		if (mapping)
+		if (page)
 			put_page(page);
 
-		port->stats.rx_dropped++;
+		if (!dropping) {
+			port->stats.rx_dropped++;
+			dropping = true;
+		}
+
+next_desc:
+		/* Final or single-descriptor fragment, advance things */
+		if (word3.bits32 & EOF_BIT) {
+			budget--;
+			received++;
+			dropping = false;
+		}
 	}
 
 	port->rx_skb = skb;
 	port->rx_frag_nr = frag_nr;
+	port->rx_dropping = dropping;
+	*freeq_consumed = consumed;
 	writew(r, ptr_reg);
-	return budget;
+	return received;
 }
 
 static int gmac_napi_poll(struct napi_struct *napi, int budget)
@@ -1543,26 +1558,27 @@ static int gmac_napi_poll(struct napi_struct *napi, int budget)
 	struct gemini_ethernet_port *port = netdev_priv(napi->dev);
 	struct gemini_ethernet *geth = port->geth;
 	unsigned int freeq_threshold;
+	unsigned int freeq_consumed;
 	unsigned int received;
 
 	freeq_threshold = 1 << (geth->freeq_order - 1);
 	u64_stats_update_begin(&port->rx_stats_syncp);
 
-	received = gmac_rx(napi->dev, budget);
-	if (received < budget) {
-		napi_gro_flush(napi, false);
-		napi_complete_done(napi, received);
-		gmac_enable_rx_irq(napi->dev, 1);
+	received = gmac_rx(napi->dev, budget, &freeq_consumed);
+	if (received < budget)
 		++port->rx_napi_exits;
-	}
 
-	port->freeq_refill += (budget - received);
+	u64_stats_update_end(&port->rx_stats_syncp);
+
+	port->freeq_refill += freeq_consumed;
 	if (port->freeq_refill > freeq_threshold) {
 		port->freeq_refill -= freeq_threshold;
 		geth_fill_freeq(geth, true);
 	}
 
-	u64_stats_update_end(&port->rx_stats_syncp);
+	if (received < budget && napi_complete_done(napi, received))
+		gmac_enable_rx_irq(napi->dev, 1);
+
 	return received;
 }
 
@@ -1752,7 +1768,7 @@ static irqreturn_t gmac_irq(int irq, void *data)
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
 		spin_lock(&geth->irq_lock);
-		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
+		writel(GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;
@@ -1864,6 +1880,7 @@ static int gmac_stop(struct net_device *netdev)
 	napi_disable(&port->napi);
 	port->rx_skb = NULL;
 	port->rx_frag_nr = 0;
+	port->rx_dropping = false;
 
 	gmac_enable_irq(netdev, 0);
 	gmac_cleanup_rxq(netdev);
diff --git a/drivers/net/ethernet/freescale/fman/fman.c b/drivers/net/ethernet/freescale/fman/fman.c
index 1748161fbbb8..823ab453a21c 100644
--- a/drivers/net/ethernet/freescale/fman/fman.c
+++ b/drivers/net/ethernet/freescale/fman/fman.c
@@ -2778,6 +2778,7 @@ static struct fman *read_dts_node(struct platform_device *of_dev)
 	}
 
 	clk_rate = clk_get_rate(clk);
+	clk_put(clk);
 	if (!clk_rate) {
 		dev_err(&of_dev->dev, "%s: Failed to determine FM%d clock rate\n",
 			__func__, fman->dts_params.id);
diff --git a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
index 5929ac50e351..7d2aa06c750e 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c
@@ -793,6 +793,7 @@ static int hns_mac_register_phy(struct hns_mac_cb *mac_cb)
 		dev_err(mac_cb->dev,
 			"mac%d mdio is NULL, dsaf will probe again later\n",
 			mac_cb->mac_id);
+		put_device(&pdev->dev);
 		return -EPROBE_DEFER;
 	}
 
@@ -801,6 +802,8 @@ static int hns_mac_register_phy(struct hns_mac_cb *mac_cb)
 		dev_dbg(mac_cb->dev, "mac%d register phy addr:%d\n",
 			mac_cb->mac_id, addr);
 
+	put_device(&pdev->dev);
+
 	return rc;
 }
 
diff --git a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
index 5078c0c73863..f5781eaea796 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_hw_mbox.c
@@ -129,6 +129,7 @@ enum hinic_mbox_tx_status {
 
 #define SEQ_ID_START_VAL			0
 #define SEQ_ID_MAX_VAL				42
+#define MBOX_LAST_SEG_MAX_LEN			(MBOX_MAX_BUF_SZ - SEQ_ID_MAX_VAL * MBOX_SEG_LEN)
 
 #define DST_AEQ_IDX_DEFAULT_VAL			0
 #define SRC_AEQ_IDX_DEFAULT_VAL			0
@@ -377,7 +378,8 @@ recv_pf_from_vf_mbox_handler(struct hinic_mbox_func_to_func *func_to_func,
 static bool check_mbox_seq_id_and_seg_len(struct hinic_recv_mbox *recv_mbox,
 					  u8 seq_id, u8 seg_len)
 {
-	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN)
+	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN ||
+	    (seq_id == SEQ_ID_MAX_VAL && seg_len > MBOX_LAST_SEG_MAX_LEN))
 		return false;
 
 	if (seq_id == 0) {
diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index c00b9097eeea..61cc137c54f8 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -30,6 +30,7 @@
 #include <linux/skbuff.h>
 #include <linux/crc32.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/mii.h>
 #include <linux/bitops.h>
 #include <linux/workqueue.h>
@@ -464,7 +465,7 @@ static inline u32 emac_iff2rmr(struct net_device *ndev)
 
 	if (emac_has_feature(dev, EMAC_APM821XX_REQ_JUMBO_FRAME_SIZE)) {
 		r &= ~EMAC4_RMR_MJS_MASK;
-		r |= EMAC4_RMR_MJS(ndev->mtu);
+		r |= EMAC4_RMR_MJS(ndev->mtu + VLAN_HLEN);
 	}
 
 	return r;
diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index b095d5057b5e..34d9e03f631c 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -716,13 +716,13 @@ static int mal_remove(struct platform_device *ofdev)
 	MAL_DBG(mal, "remove" NL);
 
 	/* Synchronize with scheduled polling */
-	napi_disable(&mal->napi);
-
-	if (!list_empty(&mal->list))
+	if (!list_empty(&mal->list)) {
+		napi_disable(&mal->napi);
 		/* This is *very* bad */
 		WARN(1, KERN_EMERG
 		       "mal%d: commac list is not empty on remove!\n",
 		       mal->index);
+	}
 
 	free_irq(mal->serr_irq, mal);
 	free_irq(mal->txde_irq, mal);
diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c b/drivers/net/ethernet/intel/e1000e/ethtool.c
index 4aca854783e2..fe2e0ba7d434 100644
--- a/drivers/net/ethernet/intel/e1000e/ethtool.c
+++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
@@ -597,20 +597,25 @@ static int e1000_set_eeprom(struct net_device *netdev,
 		/* need read/modify/write of first changed EEPROM word */
 		/* only the second byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, first_word, 1, &eeprom_buff[0]);
+		if (ret_val)
+			goto out;
+
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[0]);
+
 		ptr++;
 	}
-	if (((eeprom->offset + eeprom->len) & 1) && (!ret_val))
+	if ((eeprom->offset + eeprom->len) & 1) {
 		/* need read/modify/write of last changed EEPROM word */
 		/* only the first byte of the word is being modified */
 		ret_val = e1000_read_nvm(hw, last_word, 1,
 					 &eeprom_buff[last_word - first_word]);
+		if (ret_val)
+			goto out;
 
-	if (ret_val)
-		goto out;
-
-	/* Device's eeprom is always little-endian, word addressable */
-	for (i = 0; i < last_word - first_word + 1; i++)
-		le16_to_cpus(&eeprom_buff[i]);
+		/* Device's eeprom is always little-endian, word addressable */
+		le16_to_cpus(&eeprom_buff[last_word - first_word]);
+	}
 
 	memcpy(ptr, bytes, eeprom->len);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 7734264d570d..0d5568a36cdd 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -1932,7 +1932,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			ret = ipv6_skip_exthdr(skb, exthdr - skb->data,
 					       &l4_proto, &frag_off);
 			if (ret < 0)
-				return -1;
+				goto checksum_sw_fb;
 		}
 
 		/* define outer transport */
@@ -1951,11 +1951,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			l4.hdr = skb_inner_network_header(skb);
 			break;
 		default:
-			if (first->tx_flags & ICE_TX_FLAGS_TSO)
-				return -1;
-
-			skb_checksum_help(skb);
-			return 0;
+			goto checksum_sw_fb;
 		}
 
 		/* compute outer L3 header size */
@@ -2014,7 +2010,7 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 			ipv6_skip_exthdr(skb, exthdr - skb->data, &l4_proto,
 					 &frag_off);
 	} else {
-		return -1;
+		goto checksum_sw_fb;
 	}
 
 	/* compute inner L3 header size */
@@ -2043,15 +2039,17 @@ int ice_tx_csum(struct ice_tx_buf *first, struct ice_tx_offload_params *off)
 		break;
 
 	default:
-		if (first->tx_flags & ICE_TX_FLAGS_TSO)
-			return -1;
-		skb_checksum_help(skb);
-		return 0;
+		goto checksum_sw_fb;
 	}
 
 	off->td_cmd |= cmd;
 	off->td_offset |= offset;
 	return 1;
+
+checksum_sw_fb:
+	if (first->tx_flags & ICE_TX_FLAGS_TSO)
+		return -1;
+	return skb_checksum_help(skb);
 }
 
 /**
diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 6d672afc73d5..cb0e319bc2f1 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -4689,7 +4689,8 @@ static int mvpp2_change_mtu(struct net_device *dev, int mtu)
 			netdev_warn(dev, "mtu %d too high, switching to shared buffers", mtu);
 			mvpp2_bm_switch_buffers(priv, false);
 		}
-	} else {
+	} else if (priv->hw_version >= MVPP22 &&
+		   mvpp2_get_nrxqs(priv) * 2 <= MVPP2_BM_MAX_POOLS) {
 		bool jumbo = false;
 		int i;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index 89510cac46c2..0ac51c6d1900 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -542,6 +542,7 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 	u32 in[MLX5_ST_SZ_DW(pplm_reg)] = {};
 	int sz = MLX5_ST_SZ_BYTES(pplm_reg);
 	u16 fec_policy_auto = 0;
+	bool fec_set = false;
 	int err;
 	int i;
 
@@ -554,9 +555,6 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 	if (fec_policy >= (1 << MLX5E_FEC_LLRS_272_257_1) && !fec_50g_per_lane)
 		return -EOPNOTSUPP;
 
-	if (fec_policy && !mlx5e_fec_in_caps(dev, fec_policy))
-		return -EOPNOTSUPP;
-
 	MLX5_SET(pplm_reg, in, local_port, 1);
 	err = mlx5_core_access_reg(dev, in, sz, out, sz, MLX5_REG_PPLM, 0, 0);
 	if (err)
@@ -583,12 +581,17 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 		mlx5e_get_fec_cap_field(out, &fec_caps, i);
 
 		/* policy supported for link speed */
-		if (fec_caps & conf_fec)
+		if (fec_caps & conf_fec) {
 			mlx5e_fec_admin_field(out, &conf_fec, 1, i);
-		else
-			/* set FEC to auto*/
+			fec_set = true;
+		} else {
+			/* set FEC to auto */
 			mlx5e_fec_admin_field(out, &fec_policy_auto, 1, i);
+		}
 	}
 
+	if (fec_policy && !fec_set)
+		return -EOPNOTSUPP;
+
 	return mlx5_core_access_reg(dev, out, sz, out, sz, MLX5_REG_PPLM, 0, 1);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index 511c43146562..12c76627aceb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -925,6 +925,9 @@ mlx5_tc_ct_shared_counter_get(struct mlx5_tc_ct_priv *ct_priv,
 
 	spin_unlock_bh(&ct_priv->ht_lock);
 
+	if (rev_entry)
+		mlx5_tc_ct_entry_put(rev_entry);
+
 create_counter:
 
 	shared_counter = mlx5_tc_ct_counter_create(ct_priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 6ea50a9ef1be..09bae012d770 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -133,7 +133,7 @@ static int mlx5e_dcbnl_ieee_getets(struct net_device *netdev,
 		if (err)
 			return err;
 
-		if (ets->tc_tx_bw[i] < MLX5E_MAX_BW_ALLOC &&
+		if (priv->dcbx.tc_tsa[i] == IEEE_8021QAZ_TSA_ETS &&
 		    tc_group[i] == (MLX5E_LOWEST_PRIO_GROUP + 1))
 			is_zero_bw_ets_tc = true;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
index 132ea9997676..345585529a30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads_termtbl.c
@@ -162,12 +162,15 @@ void
 mlx5_eswitch_termtbl_put(struct mlx5_eswitch *esw,
 			 struct mlx5_termtbl_handle *tt)
 {
+	bool last;
+
 	mutex_lock(&esw->offloads.termtbl_mutex);
-	if (--tt->ref_count == 0)
+	last = (--tt->ref_count == 0);
+	if (last)
 		hash_del(&tt->termtbl_hlist);
 	mutex_unlock(&esw->offloads.termtbl_mutex);
 
-	if (!tt->ref_count) {
+	if (last) {
 		mlx5_del_flow_rules(tt->rule);
 		mlx5_destroy_flow_table(tt->termtbl);
 		kfree(tt);
diff --git a/drivers/net/ethernet/socionext/netsec.c b/drivers/net/ethernet/socionext/netsec.c
index bb8631558181..c3bd0370cdfc 100644
--- a/drivers/net/ethernet/socionext/netsec.c
+++ b/drivers/net/ethernet/socionext/netsec.c
@@ -2142,6 +2142,7 @@ static int netsec_probe(struct platform_device *pdev)
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 free_ndev:
+	of_node_put(priv->phy_np);
 	free_netdev(ndev);
 	dev_err(&pdev->dev, "init failed\n");
 
@@ -2159,6 +2160,7 @@ static int netsec_remove(struct platform_device *pdev)
 	netif_napi_del(&priv->napi);
 
 	pm_runtime_disable(&pdev->dev);
+	of_node_put(priv->phy_np);
 	free_netdev(priv->ndev);
 
 	return 0;
diff --git a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
index f2e5c4021a67..ba24be6e863e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/chain_mode.c
@@ -14,9 +14,9 @@
 
 #include "stmmac.h"
 
-static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
+static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
+		     int csum)
 {
-	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)p;
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
@@ -126,9 +126,8 @@ static void init_dma_chain(void *des, dma_addr_t phy_addr,
 	}
 }
 
-static void refill_desc3(void *priv_ptr, struct dma_desc *p)
+static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 {
-	struct stmmac_rx_queue *rx_q = (struct stmmac_rx_queue *)priv_ptr;
 	struct stmmac_priv *priv = rx_q->priv_data;
 
 	if (priv->hwts_rx_en && !priv->extend_desc)
@@ -142,9 +141,8 @@ static void refill_desc3(void *priv_ptr, struct dma_desc *p)
 				      sizeof(struct dma_desc)));
 }
 
-static void clean_desc3(void *priv_ptr, struct dma_desc *p)
+static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 {
-	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)priv_ptr;
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->dirty_tx;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
index 8f0d9bc7cab5..f6abc7bfd29d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac100_dma.c
@@ -80,10 +80,10 @@ static void dwmac100_dump_dma_regs(void __iomem *ioaddr, u32 *reg_space)
 }
 
 /* DMA controller has two counters to track the number of the missed frames. */
-static void dwmac100_dma_diagnostic_fr(void *data, struct stmmac_extra_stats *x,
+static void dwmac100_dma_diagnostic_fr(struct net_device_stats *stats,
+				       struct stmmac_extra_stats *x,
 				       void __iomem *ioaddr)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	u32 csr8 = readl(ioaddr + DMA_MISSED_FRAME_CTR);
 
 	if (unlikely(csr8)) {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index cbf4429fb1d2..3e57061d3a88 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -13,11 +13,11 @@
 #include "dwmac4.h"
 #include "dwmac4_descs.h"
 
-static int dwmac4_wrback_get_tx_status(void *data, struct stmmac_extra_stats *x,
+static int dwmac4_wrback_get_tx_status(struct net_device_stats *stats,
+				       struct stmmac_extra_stats *x,
 				       struct dma_desc *p,
 				       void __iomem *ioaddr)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	unsigned int tdes3;
 	int ret = tx_done;
 
@@ -71,10 +71,10 @@ static int dwmac4_wrback_get_tx_status(void *data, struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static int dwmac4_wrback_get_rx_status(void *data, struct stmmac_extra_stats *x,
+static int dwmac4_wrback_get_rx_status(struct net_device_stats *stats,
+				       struct stmmac_extra_stats *x,
 				       struct dma_desc *p)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	unsigned int rdes1 = le32_to_cpu(p->des1);
 	unsigned int rdes2 = le32_to_cpu(p->des2);
 	unsigned int rdes3 = le32_to_cpu(p->des3);
@@ -486,11 +486,11 @@ static void dwmac4_set_sarc(struct dma_desc *p, u32 sarc_type)
 	p->des3 |= cpu_to_le32(sarc_type & TDES3_SA_INSERT_CTRL_MASK);
 }
 
-static int set_16kib_bfsize(int mtu)
+static int set_16kib_bfsize(int len)
 {
 	int ret = 0;
 
-	if (unlikely(mtu >= BUF_SIZE_8KiB))
+	if (unlikely(len > BUF_SIZE_8KiB))
 		ret = BUF_SIZE_16KiB;
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 4426cb923ac8..98474a1207bd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -398,9 +398,9 @@
 #define XGMAC_RIE			BIT(6)
 #define XGMAC_TBUE			BIT(2)
 #define XGMAC_TIE			BIT(0)
-#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | XGMAC_RBUE | \
+#define XGMAC_DMA_INT_DEFAULT_EN	(XGMAC_NIE | XGMAC_AIE | \
 					XGMAC_RIE | XGMAC_TIE)
-#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RBUE | XGMAC_RIE)
+#define XGMAC_DMA_INT_DEFAULT_RX	(XGMAC_RIE)
 #define XGMAC_DMA_INT_DEFAULT_TX	(XGMAC_TIE)
 #define XGMAC_DMA_CH_Rx_WATCHDOG(x)	(0x0000313c + (0x80 * (x)))
 #define XGMAC_RWT			GENMASK(7, 0)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index ccfb0102dde4..4dbb06acb298 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -8,7 +8,8 @@
 #include "common.h"
 #include "dwxgmac2.h"
 
-static int dwxgmac2_get_tx_status(void *data, struct stmmac_extra_stats *x,
+static int dwxgmac2_get_tx_status(struct net_device_stats *stats,
+				  struct stmmac_extra_stats *x,
 				  struct dma_desc *p, void __iomem *ioaddr)
 {
 	unsigned int tdes3 = le32_to_cpu(p->des3);
@@ -22,7 +23,8 @@ static int dwxgmac2_get_tx_status(void *data, struct stmmac_extra_stats *x,
 	return ret;
 }
 
-static int dwxgmac2_get_rx_status(void *data, struct stmmac_extra_stats *x,
+static int dwxgmac2_get_rx_status(struct net_device_stats *stats,
+				  struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
 	unsigned int rdes3 = le32_to_cpu(p->des3);
diff --git a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
index 6650edfab5bc..f46fe7c392e6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/enh_desc.c
@@ -12,10 +12,10 @@
 #include "common.h"
 #include "descs_com.h"
 
-static int enh_desc_get_tx_status(void *data, struct stmmac_extra_stats *x,
+static int enh_desc_get_tx_status(struct net_device_stats *stats,
+				  struct stmmac_extra_stats *x,
 				  struct dma_desc *p, void __iomem *ioaddr)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	unsigned int tdes0 = le32_to_cpu(p->des0);
 	int ret = tx_done;
 
@@ -117,7 +117,8 @@ static int enh_desc_coe_rdes0(int ipc_err, int type, int payload_err)
 	return ret;
 }
 
-static void enh_desc_get_ext_status(void *data, struct stmmac_extra_stats *x,
+static void enh_desc_get_ext_status(struct net_device_stats *stats,
+				    struct stmmac_extra_stats *x,
 				    struct dma_extended_desc *p)
 {
 	unsigned int rdes0 = le32_to_cpu(p->basic.des0);
@@ -181,10 +182,10 @@ static void enh_desc_get_ext_status(void *data, struct stmmac_extra_stats *x,
 	}
 }
 
-static int enh_desc_get_rx_status(void *data, struct stmmac_extra_stats *x,
+static int enh_desc_get_rx_status(struct net_device_stats *stats,
+				  struct stmmac_extra_stats *x,
 				  struct dma_desc *p)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	unsigned int rdes0 = le32_to_cpu(p->des0);
 	int ret = good_frame;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index d7ea2fd944ee..192f228cfe0e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -56,8 +56,9 @@ struct stmmac_desc_ops {
 	/* Last tx segment reports the transmit status */
 	int (*get_tx_ls)(struct dma_desc *p);
 	/* Return the transmit status looking at the TDES1 */
-	int (*tx_status)(void *data, struct stmmac_extra_stats *x,
-			struct dma_desc *p, void __iomem *ioaddr);
+	int (*tx_status)(struct net_device_stats *stats,
+			 struct stmmac_extra_stats *x,
+			 struct dma_desc *p, void __iomem *ioaddr);
 	/* Get the buffer size from the descriptor */
 	int (*get_tx_len)(struct dma_desc *p);
 	/* Handle extra events on specific interrupts hw dependent */
@@ -65,10 +66,12 @@ struct stmmac_desc_ops {
 	/* Get the receive frame size */
 	int (*get_rx_frame_len)(struct dma_desc *p, int rx_coe_type);
 	/* Return the reception status looking at the RDES1 */
-	int (*rx_status)(void *data, struct stmmac_extra_stats *x,
-			struct dma_desc *p);
-	void (*rx_extended_status)(void *data, struct stmmac_extra_stats *x,
-			struct dma_extended_desc *p);
+	int (*rx_status)(struct net_device_stats *stats,
+			 struct stmmac_extra_stats *x,
+			 struct dma_desc *p);
+	void (*rx_extended_status)(struct net_device_stats *stats,
+				   struct stmmac_extra_stats *x,
+				   struct dma_extended_desc *p);
 	/* Set tx timestamp enable bit */
 	void (*enable_tx_timestamp) (struct dma_desc *p);
 	/* get tx timestamp status */
@@ -189,8 +192,9 @@ struct stmmac_dma_ops {
 	void (*dma_tx_mode)(void __iomem *ioaddr, int mode, u32 channel,
 			    int fifosz, u8 qmode);
 	/* To track extra statistic (if supported) */
-	void (*dma_diagnostic_fr) (void *data, struct stmmac_extra_stats *x,
-				   void __iomem *ioaddr);
+	void (*dma_diagnostic_fr)(struct net_device_stats *stats,
+				  struct stmmac_extra_stats *x,
+				  void __iomem *ioaddr);
 	void (*enable_dma_transmission) (void __iomem *ioaddr);
 	void (*enable_dma_irq)(void __iomem *ioaddr, u32 chan,
 			       bool rx, bool tx);
@@ -516,16 +520,20 @@ struct stmmac_hwtimestamp {
 #define stmmac_get_systime(__priv, __args...) \
 	stmmac_do_void_callback(__priv, ptp, get_systime, __args)
 
+struct stmmac_tx_queue;
+struct stmmac_rx_queue;
+
 /* Helpers to manage the descriptors for chain and ring modes */
 struct stmmac_mode_ops {
 	void (*init) (void *des, dma_addr_t phy_addr, unsigned int size,
 		      unsigned int extend_desc);
 	unsigned int (*is_jumbo_frm) (int len, int ehn_desc);
-	int (*jumbo_frm)(void *priv, struct sk_buff *skb, int csum);
-	int (*set_16kib_bfsize)(int mtu);
+	int (*jumbo_frm)(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
+			 int csum);
+	int (*set_16kib_bfsize)(int len);
 	void (*init_desc3)(struct dma_desc *p);
-	void (*refill_desc3) (void *priv, struct dma_desc *p);
-	void (*clean_desc3) (void *priv, struct dma_desc *p);
+	void (*refill_desc3)(struct stmmac_rx_queue *rx_q, struct dma_desc *p);
+	void (*clean_desc3)(struct stmmac_tx_queue *tx_q, struct dma_desc *p);
 };
 
 #define stmmac_mode_init(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
index 98ef43f35802..a42a62224086 100644
--- a/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/norm_desc.c
@@ -12,10 +12,10 @@
 #include "common.h"
 #include "descs_com.h"
 
-static int ndesc_get_tx_status(void *data, struct stmmac_extra_stats *x,
+static int ndesc_get_tx_status(struct net_device_stats *stats,
+			       struct stmmac_extra_stats *x,
 			       struct dma_desc *p, void __iomem *ioaddr)
 {
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 	unsigned int tdes0 = le32_to_cpu(p->des0);
 	unsigned int tdes1 = le32_to_cpu(p->des1);
 	int ret = tx_done;
@@ -70,12 +70,12 @@ static int ndesc_get_tx_len(struct dma_desc *p)
  * and, if required, updates the multicast statistics.
  * In case of success, it returns good_frame because the GMAC device
  * is supposed to be able to compute the csum in HW. */
-static int ndesc_get_rx_status(void *data, struct stmmac_extra_stats *x,
+static int ndesc_get_rx_status(struct net_device_stats *stats,
+			       struct stmmac_extra_stats *x,
 			       struct dma_desc *p)
 {
 	int ret = good_frame;
 	unsigned int rdes0 = le32_to_cpu(p->des0);
-	struct net_device_stats *stats = (struct net_device_stats *)data;
 
 	if (unlikely(rdes0 & RDES0_OWN))
 		return dma_own;
diff --git a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
index 8ad900949dc8..275b638bbc0f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
+++ b/drivers/net/ethernet/stmicro/stmmac/ring_mode.c
@@ -14,9 +14,9 @@
 
 #include "stmmac.h"
 
-static int jumbo_frm(void *p, struct sk_buff *skb, int csum)
+static int jumbo_frm(struct stmmac_tx_queue *tx_q, struct sk_buff *skb,
+		     int csum)
 {
-	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)p;
 	unsigned int nopaged_len = skb_headlen(skb);
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->cur_tx;
@@ -101,9 +101,8 @@ static unsigned int is_jumbo_frm(int len, int enh_desc)
 	return ret;
 }
 
-static void refill_desc3(void *priv_ptr, struct dma_desc *p)
+static void refill_desc3(struct stmmac_rx_queue *rx_q, struct dma_desc *p)
 {
-	struct stmmac_rx_queue *rx_q = priv_ptr;
 	struct stmmac_priv *priv = rx_q->priv_data;
 
 	/* Fill DES3 in case of RING mode */
@@ -117,9 +116,8 @@ static void init_desc3(struct dma_desc *p)
 	p->des3 = cpu_to_le32(le32_to_cpu(p->des2) + BUF_SIZE_8KiB);
 }
 
-static void clean_desc3(void *priv_ptr, struct dma_desc *p)
+static void clean_desc3(struct stmmac_tx_queue *tx_q, struct dma_desc *p)
 {
-	struct stmmac_tx_queue *tx_q = (struct stmmac_tx_queue *)priv_ptr;
 	struct stmmac_priv *priv = tx_q->priv_data;
 	unsigned int entry = tx_q->dirty_tx;
 
@@ -130,10 +128,10 @@ static void clean_desc3(void *priv_ptr, struct dma_desc *p)
 		p->des3 = 0;
 }
 
-static int set_16kib_bfsize(int mtu)
+static int set_16kib_bfsize(int len)
 {
 	int ret = 0;
-	if (unlikely(mtu > BUF_SIZE_8KiB))
+	if (unlikely(len > BUF_SIZE_8KiB))
 		ret = BUF_SIZE_16KiB;
 	return ret;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ac278d81f161..75d7096ab20b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2743,6 +2743,14 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	/* Initialize MTL*/
 	stmmac_mtl_configuration(priv);
 
+	/* Apply the RX packet parser table */
+	if (priv->tc_entries) {
+		ret = stmmac_rxp_config(priv, priv->hw->pcsr, priv->tc_entries,
+					priv->tc_entries_max);
+		if (ret)
+			return ret;
+	}
+
 	/* Initialize Safety Features */
 	stmmac_safety_feat_configuration(priv);
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
index 5a5002fdbc64..d1315125b331 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_selftests.c
@@ -13,6 +13,7 @@
 #include <linux/ip.h>
 #include <linux/phy.h>
 #include <linux/udp.h>
+#include <net/dsa.h>
 #include <net/pkt_cls.h>
 #include <net/pkt_sched.h>
 #include <net/tcp.h>
@@ -238,6 +239,10 @@ struct stmmac_test_priv {
 	struct stmmac_packet_attrs *packet;
 	struct packet_type pt;
 	struct completion comp;
+	__be16 packet_type;
+	int (*func)(struct sk_buff *skb, struct net_device *ndev,
+		    struct packet_type *pt, struct net_device *orig_ndev);
+	bool capture_all;
 	int double_vlan;
 	int vlan_id;
 	int ok;
@@ -317,6 +322,52 @@ static int stmmac_test_loopback_validate(struct sk_buff *skb,
 	return 0;
 }
 
+static int stmmac_sft_filter(struct sk_buff *skb, struct net_device *ndev,
+			     struct packet_type *pt,
+			     struct net_device *orig_ndev)
+{
+	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+	struct ethhdr *hdr = eth_hdr(skb);
+	int ret = 0;
+
+	if (hdr->h_proto == tpriv->packet_type) {
+		struct sk_buff *nskb = skb_clone(skb, GFP_ATOMIC);
+
+		if (nskb)
+			ret = tpriv->func(nskb, ndev, pt, orig_ndev);
+	}
+
+	kfree_skb(skb);
+	return ret;
+}
+
+static void stmmac_sft_add_pack(struct packet_type *pt)
+{
+	struct stmmac_test_priv *tpriv = pt->af_packet_priv;
+
+	if (netdev_uses_dsa(tpriv->pt.dev) || tpriv->capture_all) {
+		tpriv->packet_type = tpriv->pt.type;
+		tpriv->func = tpriv->pt.func;
+
+		/* DSA conduit will report ETH_P_XDSA, so our packet handler
+		 * won't match. Let's register a ETH_P_ALL match and filter
+		 * manually in stmmac_sft_filter. This is also useful for
+		 * VLAN tests, to capture packets otherwise marked as
+		 * OTHERHOST.
+		 */
+		tpriv->pt.type = htons(ETH_P_ALL);
+		tpriv->pt.func = stmmac_sft_filter;
+		tpriv->pt.ignore_outgoing = true;
+	}
+
+	dev_add_pack(pt);
+}
+
+static void stmmac_sft_remove_pack(struct packet_type *pt)
+{
+	dev_remove_pack(pt);
+}
+
 static int __stmmac_test_loopback(struct stmmac_priv *priv,
 				  struct stmmac_packet_attrs *attr)
 {
@@ -338,7 +389,7 @@ static int __stmmac_test_loopback(struct stmmac_priv *priv,
 	tpriv->packet = attr;
 
 	if (!attr->dont_wait)
-		dev_add_pack(&tpriv->pt);
+		stmmac_sft_add_pack(&tpriv->pt);
 
 	skb = stmmac_test_get_udp_skb(priv, attr);
 	if (!skb) {
@@ -361,7 +412,7 @@ static int __stmmac_test_loopback(struct stmmac_priv *priv,
 
 cleanup:
 	if (!attr->dont_wait)
-		dev_remove_pack(&tpriv->pt);
+		stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -775,7 +826,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 	tpriv->pt.func = stmmac_test_flowctrl_validate;
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
-	dev_add_pack(&tpriv->pt);
+	stmmac_sft_add_pack(&tpriv->pt);
 
 	/* Compute minimum number of packets to make FIFO full */
 	pkt_count = priv->plat->rx_fifo_size;
@@ -833,7 +884,7 @@ static int stmmac_test_flowctrl(struct stmmac_priv *priv)
 cleanup:
 	dev_mc_del(priv->dev, paddr);
 	dev_set_promiscuity(priv->dev, -1);
-	dev_remove_pack(&tpriv->pt);
+	stmmac_sft_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -875,6 +926,11 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 		goto out;
 	if (skb_headlen(skb) < (STMMAC_TEST_PKT_SIZE - ETH_HLEN))
 		goto out;
+
+	ehdr = (struct ethhdr *)skb_mac_header(skb);
+	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
+		goto out;
+
 	if (tpriv->vlan_id) {
 		if (skb->vlan_proto != htons(proto))
 			goto out;
@@ -886,10 +942,6 @@ static int stmmac_test_vlan_validate(struct sk_buff *skb,
 		}
 	}
 
-	ehdr = (struct ethhdr *)skb_mac_header(skb);
-	if (!ether_addr_equal_unaligned(ehdr->h_dest, tpriv->packet->dst))
-		goto out;
-
 	ihdr = ip_hdr(skb);
 	if (tpriv->double_vlan)
 		ihdr = (struct iphdr *)(skb_network_header(skb) + 4);
@@ -931,6 +983,7 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -938,18 +991,20 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 	if (ret)
 		goto cleanup;
 
+	attr.vlan = 1;
+	attr.dst = priv->dev->dev_addr;
+	attr.sport = 9;
+	attr.dport = 9;
+
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	for (i = 0; i < 4; i++) {
-		attr.vlan = 1;
 		attr.vlan_id_out = tpriv->vlan_id + i;
-		attr.dst = priv->dev->dev_addr;
-		attr.sport = 9;
-		attr.dport = 9;
 
 		skb = stmmac_test_get_udp_skb(priv, &attr);
 		if (!skb) {
@@ -976,9 +1031,9 @@ static int __stmmac_test_vlanfilt(struct stmmac_priv *priv)
 	}
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(ETH_P_8021Q), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1025,6 +1080,7 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	tpriv->pt.dev = priv->dev;
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
+	tpriv->capture_all = true;
 
 	/*
 	 * As we use HASH filtering, false positives may appear. This is a
@@ -1032,18 +1088,20 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	 * HASH values.
 	 */
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
 
 	ret = vlan_vid_add(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 	if (ret)
 		goto cleanup;
 
+	attr.vlan = 2;
+	attr.dst = priv->dev->dev_addr;
+	attr.sport = 9;
+	attr.dport = 9;
+
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	for (i = 0; i < 4; i++) {
-		attr.vlan = 2;
 		attr.vlan_id_out = tpriv->vlan_id + i;
-		attr.dst = priv->dev->dev_addr;
-		attr.sport = 9;
-		attr.dport = 9;
 
 		skb = stmmac_test_get_udp_skb(priv, &attr);
 		if (!skb) {
@@ -1070,9 +1128,9 @@ static int __stmmac_test_dvlanfilt(struct stmmac_priv *priv)
 	}
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1303,7 +1361,7 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	tpriv->pt.af_packet_priv = tpriv;
 	tpriv->packet = &attr;
 	tpriv->vlan_id = 0x123;
-	dev_add_pack(&tpriv->pt);
+	tpriv->capture_all = true;
 
 	ret = vlan_vid_add(priv->dev, htons(proto), tpriv->vlan_id);
 	if (ret)
@@ -1311,6 +1369,8 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 
 	attr.dst = priv->dev->dev_addr;
 
+	stmmac_sft_add_pack(&tpriv->pt);
+
 	skb = stmmac_test_get_udp_skb(priv, &attr);
 	if (!skb) {
 		ret = -ENOMEM;
@@ -1328,9 +1388,9 @@ static int stmmac_test_vlanoff_common(struct stmmac_priv *priv, bool svlan)
 	ret = tpriv->ok ? 0 : -ETIMEDOUT;
 
 vlan_del:
+	stmmac_sft_remove_pack(&tpriv->pt);
 	vlan_vid_del(priv->dev, htons(proto), tpriv->vlan_id);
 cleanup:
-	dev_remove_pack(&tpriv->pt);
 	kfree(tpriv);
 	return ret;
 }
@@ -1342,7 +1402,7 @@ static int stmmac_test_vlanoff(struct stmmac_priv *priv)
 
 static int stmmac_test_svlanoff(struct stmmac_priv *priv)
 {
-	if (!priv->dma_cap.dvlan)
+	if (!(priv->dev->features & NETIF_F_HW_VLAN_STAG_TX))
 		return -EOPNOTSUPP;
 	return stmmac_test_vlanoff_common(priv, true);
 }
diff --git a/drivers/net/ethernet/ti/cpsw_new.c b/drivers/net/ethernet/ti/cpsw_new.c
index cc276241f391..83de759bfb90 100644
--- a/drivers/net/ethernet/ti/cpsw_new.c
+++ b/drivers/net/ethernet/ti/cpsw_new.c
@@ -2029,7 +2029,7 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	ret = cpsw_register_ports(cpsw);
 	if (ret)
-		goto clean_unregister_notifiers;
+		goto clean_unregister_devlink;
 
 	dev_notice(dev, "initialized (regs %pa, pool size %d) hw_ver:%08X %d.%d (%d)\n",
 		   &ss_res->start, descs_pool_size,
@@ -2041,6 +2041,8 @@ static int cpsw_probe(struct platform_device *pdev)
 
 	return 0;
 
+clean_unregister_devlink:
+	cpsw_unregister_devlink(cpsw);
 clean_unregister_notifiers:
 	cpsw_unregister_notifiers(cpsw);
 clean_cpts:
diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 77dd20431c44..7c209a749c1e 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2171,7 +2171,7 @@ static int netcp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_get_sync(&pdev->dev);
+	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(dev, "Failed to enable NETCP power-domain\n");
 		pm_runtime_disable(&pdev->dev);
diff --git a/drivers/net/fddi/skfp/skfddi.c b/drivers/net/fddi/skfp/skfddi.c
index 69c29a2ef95d..ab03cdb536eb 100644
--- a/drivers/net/fddi/skfp/skfddi.c
+++ b/drivers/net/fddi/skfp/skfddi.c
@@ -924,7 +924,8 @@ static int skfp_ctl_set_mac_address(struct net_device *dev, void *addr)
 
 	memcpy(dev->dev_addr, p_sockaddr->sa_data, FDDI_K_ALEN);
 	spin_lock_irqsave(&bp->DriverLock, Flags);
-	ResetAdapter(smc);
+	if (netif_running(dev))
+		ResetAdapter(smc);
 	spin_unlock_irqrestore(&bp->DriverLock, Flags);
 
 	return 0;		/* always return zero */
diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
index 95ae47a7a69d..f6ad599252d3 100644
--- a/drivers/net/macvlan.c
+++ b/drivers/net/macvlan.c
@@ -910,6 +910,8 @@ static int macvlan_init(struct net_device *dev)
 	dev->gso_max_size	= lowerdev->gso_max_size;
 	dev->gso_max_segs	= lowerdev->gso_max_segs;
 	dev->hard_header_len	= lowerdev->hard_header_len;
+	dev->needed_headroom	= lowerdev->needed_headroom;
+	dev->needed_tailroom	= lowerdev->needed_tailroom;
 	macvlan_set_lockdep_class(dev);
 
 	vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
@@ -1731,6 +1733,8 @@ static int macvlan_device_event(struct notifier_block *unused,
 		list_for_each_entry(vlan, &port->vlans, list) {
 			vlan->dev->gso_max_size = dev->gso_max_size;
 			vlan->dev->gso_max_segs = dev->gso_max_segs;
+			vlan->dev->needed_headroom = dev->needed_headroom;
+			vlan->dev->needed_tailroom = dev->needed_tailroom;
 			netdev_update_features(vlan->dev);
 		}
 		break;
diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index 164c11df8192..ceb4cdbb0aef 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -65,8 +65,6 @@ struct asyncppp {
 
 	struct tasklet_struct tsk;
 
-	refcount_t	refcnt;
-	struct completion dead;
 	struct ppp_channel chan;	/* interface to generic ppp layer */
 	unsigned char	obuf[OBUFSIZE];
 };
@@ -115,38 +113,6 @@ static const struct ppp_channel_ops async_ops = {
  * Routines implementing the PPP line discipline.
  */
 
-/*
- * We have a potential race on dereferencing tty->disc_data,
- * because the tty layer provides no locking at all - thus one
- * cpu could be running ppp_asynctty_receive while another
- * calls ppp_asynctty_close, which zeroes tty->disc_data and
- * frees the memory that ppp_asynctty_receive is using.  The best
- * way to fix this is to use a rwlock in the tty struct, but for now
- * we use a single global rwlock for all ttys in ppp line discipline.
- *
- * FIXME: this is no longer true. The _close path for the ldisc is
- * now guaranteed to be sane.
- */
-static DEFINE_RWLOCK(disc_data_lock);
-
-static struct asyncppp *ap_get(struct tty_struct *tty)
-{
-	struct asyncppp *ap;
-
-	read_lock(&disc_data_lock);
-	ap = tty->disc_data;
-	if (ap != NULL)
-		refcount_inc(&ap->refcnt);
-	read_unlock(&disc_data_lock);
-	return ap;
-}
-
-static void ap_put(struct asyncppp *ap)
-{
-	if (refcount_dec_and_test(&ap->refcnt))
-		complete(&ap->dead);
-}
-
 /*
  * Called when a tty is put into PPP line discipline. Called in process
  * context.
@@ -181,9 +147,6 @@ ppp_asynctty_open(struct tty_struct *tty)
 	skb_queue_head_init(&ap->rqueue);
 	tasklet_init(&ap->tsk, ppp_async_process, (unsigned long) ap);
 
-	refcount_set(&ap->refcnt, 1);
-	init_completion(&ap->dead);
-
 	ap->chan.private = ap;
 	ap->chan.ops = &async_ops;
 	ap->chan.mtu = PPP_MRU;
@@ -204,34 +167,18 @@ ppp_asynctty_open(struct tty_struct *tty)
 }
 
 /*
- * Called when the tty is put into another line discipline
- * or it hangs up.  We have to wait for any cpu currently
- * executing in any of the other ppp_asynctty_* routines to
- * finish before we can call ppp_unregister_channel and free
- * the asyncppp struct.  This routine must be called from
- * process context, not interrupt or softirq context.
+ * Called when the tty is put into another line discipline or it hangs up.
+ * This call is serialized against other ldisc functions.
  */
 static void
 ppp_asynctty_close(struct tty_struct *tty)
 {
-	struct asyncppp *ap;
+	struct asyncppp *ap = tty->disc_data;
 
-	write_lock_irq(&disc_data_lock);
-	ap = tty->disc_data;
-	tty->disc_data = NULL;
-	write_unlock_irq(&disc_data_lock);
 	if (!ap)
 		return;
 
-	/*
-	 * We have now ensured that nobody can start using ap from now
-	 * on, but we have to wait for all existing users to finish.
-	 * Note that ppp_unregister_channel ensures that no calls to
-	 * our channel ops (i.e. ppp_async_send/ioctl) are in progress
-	 * by the time it returns.
-	 */
-	if (!refcount_dec_and_test(&ap->refcnt))
-		wait_for_completion(&ap->dead);
+	tty->disc_data = NULL;
 	tasklet_kill(&ap->tsk);
 
 	ppp_unregister_channel(&ap->chan);
@@ -241,18 +188,6 @@ ppp_asynctty_close(struct tty_struct *tty)
 	kfree(ap);
 }
 
-/*
- * Called on tty hangup in process context.
- *
- * Wait for I/O to driver to complete and unregister PPP channel.
- * This is already done by the close routine, so just call that.
- */
-static int ppp_asynctty_hangup(struct tty_struct *tty)
-{
-	ppp_asynctty_close(tty);
-	return 0;
-}
-
 /*
  * Read does nothing - no data is ever available this way.
  * Pppd reads and writes packets via /dev/ppp instead.
@@ -285,7 +220,7 @@ static int
 ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
 		   unsigned int cmd, unsigned long arg)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 	int err, val;
 	int __user *p = (int __user *)arg;
 
@@ -326,7 +261,6 @@ ppp_asynctty_ioctl(struct tty_struct *tty, struct file *file,
 		err = tty_mode_ioctl(tty, file, cmd, arg);
 	}
 
-	ap_put(ap);
 	return err;
 }
 
@@ -342,7 +276,7 @@ static void
 ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 		  char *cflags, int count)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 	unsigned long flags;
 
 	if (!ap)
@@ -352,21 +286,19 @@ ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
 	spin_unlock_irqrestore(&ap->recv_lock, flags);
 	if (!skb_queue_empty(&ap->rqueue))
 		tasklet_schedule(&ap->tsk);
-	ap_put(ap);
 	tty_unthrottle(tty);
 }
 
 static void
 ppp_asynctty_wakeup(struct tty_struct *tty)
 {
-	struct asyncppp *ap = ap_get(tty);
+	struct asyncppp *ap = tty->disc_data;
 
 	clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);
 	if (!ap)
 		return;
 	set_bit(XMIT_WAKEUP, &ap->xmit_flags);
 	tasklet_schedule(&ap->tsk);
-	ap_put(ap);
 }
 
 
@@ -376,7 +308,6 @@ static struct tty_ldisc_ops ppp_ldisc = {
 	.name	= "ppp",
 	.open	= ppp_asynctty_open,
 	.close	= ppp_asynctty_close,
-	.hangup	= ppp_asynctty_hangup,
 	.read	= ppp_asynctty_read,
 	.write	= ppp_asynctty_write,
 	.ioctl	= ppp_asynctty_ioctl,
@@ -822,11 +753,8 @@ process_input_packet(struct asyncppp *ap)
  err:
 	/* frame had an error, remember that, reset SC_TOSS & SC_ESCAPE */
 	ap->state = SC_PREV_ERROR;
-	if (skb) {
-		/* make skb appear as freshly allocated */
-		skb_trim(skb, 0);
-		skb_reserve(skb, - skb_headroom(skb));
-	}
+	kfree_skb(skb);
+	ap->rpkt = NULL;
 }
 
 /* Called when the tty driver has data for us. Runs parallel with the
diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
index 11725cab4912..85b0ac03a1c3 100644
--- a/drivers/net/ppp/ppp_synctty.c
+++ b/drivers/net/ppp/ppp_synctty.c
@@ -245,10 +245,9 @@ ppp_sync_close(struct tty_struct *tty)
  * Wait for I/O to driver to complete and unregister PPP channel.
  * This is already done by the close routine, so just call that.
  */
-static int ppp_sync_hangup(struct tty_struct *tty)
+static void ppp_sync_hangup(struct tty_struct *tty)
 {
 	ppp_sync_close(tty);
-	return 0;
 }
 
 /*
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index 0373e3253e58..9c04e327c26a 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -915,10 +915,9 @@ static void slip_close(struct tty_struct *tty)
 	/* sl_uninit() has dropped the slip_devs[] entry by now */
 }
 
-static int slip_hangup(struct tty_struct *tty)
+static void slip_hangup(struct tty_struct *tty)
 {
 	slip_close(tty);
-	return 0;
 }
  /************************************************************************
   *			STANDARD SLIP ENCAPSULATION		  	 *
diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
index 38951608dc57..2983ea88a761 100644
--- a/drivers/net/usb/catc.c
+++ b/drivers/net/usb/catc.c
@@ -239,17 +239,26 @@ static void catc_rx_done(struct urb *urb)
 	}
 
 	do {
-		if(!catc->is_f5u011) {
-			pkt_len = le16_to_cpup((__le16*)pkt_start);
-			if (pkt_len > urb->actual_length) {
+		int remaining = urb->actual_length -
+				(pkt_start - (u8 *)urb->transfer_buffer);
+
+		if (!catc->is_f5u011) {
+			if (remaining < pkt_offset) {
 				catc->netdev->stats.rx_length_errors++;
 				catc->netdev->stats.rx_errors++;
 				break;
 			}
+			pkt_len = le16_to_cpup((__le16 *)pkt_start);
 		} else {
 			pkt_len = urb->actual_length;
 		}
 
+		if (pkt_len < ETH_HLEN || pkt_len + pkt_offset > remaining) {
+			catc->netdev->stats.rx_length_errors++;
+			catc->netdev->stats.rx_errors++;
+			break;
+		}
+
 		if (!(skb = dev_alloc_skb(pkt_len)))
 			return;
 
diff --git a/drivers/net/usb/cdc_mbim.c b/drivers/net/usb/cdc_mbim.c
index 6ad1fb00a35c..e4f17974644f 100644
--- a/drivers/net/usb/cdc_mbim.c
+++ b/drivers/net/usb/cdc_mbim.c
@@ -632,6 +632,11 @@ static const struct usb_device_id mbim_devs[] = {
 	  .driver_info = (unsigned long)&cdc_mbim_info,
 	},
 
+	/* MeiG Smart SRM821 ZLP conformance */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d53, USB_CLASS_COMM, USB_CDC_SUBCLASS_MBIM, USB_CDC_PROTO_NONE),
+	  .driver_info = (unsigned long)&cdc_mbim_info,
+	},
+
 	/* Some Huawei devices, ME906s-158 (12d1:15c1) and E3372
 	 * (12d1:157d), are known to fail unless the NDP is placed
 	 * after the IP packets.  Applying the quirk to all Huawei
diff --git a/drivers/net/usb/cx82310_eth.c b/drivers/net/usb/cx82310_eth.c
index 79a47e2fd437..840d014ac1aa 100644
--- a/drivers/net/usb/cx82310_eth.c
+++ b/drivers/net/usb/cx82310_eth.c
@@ -282,6 +282,7 @@ static int cx82310_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		if (len == 0xffff) {
 			netdev_info(dev->net, "router was rebooted, re-enabling ethernet mode");
 			schedule_work(&priv->reenable_work);
+			return 0;
 		} else if (len > CX82310_MTU) {
 			netdev_err(dev->net, "RX packet too long: %d B\n", len);
 			return 0;
diff --git a/drivers/net/usb/hso.c b/drivers/net/usb/hso.c
index db484215a78c..7ed1b8d7d471 100644
--- a/drivers/net/usb/hso.c
+++ b/drivers/net/usb/hso.c
@@ -1557,10 +1557,10 @@ hso_wait_modem_status(struct hso_serial *serial, unsigned long arg)
 	spin_unlock_irq(&serial->serial_lock);
 	add_wait_queue(&tiocmget->waitq, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
 		spin_lock_irq(&serial->serial_lock);
 		memcpy(&cnow, &tiocmget->icount, sizeof(struct uart_icount));
 		spin_unlock_irq(&serial->serial_lock);
-		set_current_state(TASK_INTERRUPTIBLE);
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd))) {
diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 1a76fccee9a8..7306a5c79180 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -2749,6 +2749,8 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	buf |= HW_CFG_MEF_;
+	buf |= HW_CFG_CLK125_EN_;
+	buf |= HW_CFG_REFCLK25_EN_;
 
 	ret = lan78xx_write_reg(dev, HW_CFG, buf);
 	if (ret < 0)
@@ -2837,8 +2839,11 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 		return ret;
 
 	/* LAN7801 only has RGMII mode */
-	if (dev->chipid == ID_REV_CHIP_ID_7801_)
+	if (dev->chipid == ID_REV_CHIP_ID_7801_) {
 		buf &= ~MAC_CR_GMII_EN_;
+		/* Enable Auto Duplex and Auto speed */
+		buf |= MAC_CR_AUTO_DUPLEX_ | MAC_CR_AUTO_SPEED_;
+	}
 
 	if (dev->chipid == ID_REV_CHIP_ID_7800_ ||
 	    dev->chipid == ID_REV_CHIP_ID_7850_) {
diff --git a/drivers/net/usb/qmi_wwan.c b/drivers/net/usb/qmi_wwan.c
index 0805452b7a5d..ecba25ff2347 100644
--- a/drivers/net/usb/qmi_wwan.c
+++ b/drivers/net/usb/qmi_wwan.c
@@ -1384,6 +1384,8 @@ static const struct usb_device_id products[] = {
 	{QMI_QUIRK_SET_DTR(0x1546, 0x1342, 4)},	/* u-blox LARA-L6 */
 	{QMI_QUIRK_SET_DTR(0x33f8, 0x0104, 4)}, /* Rolling RW101 RMNET */
 	{QMI_FIXED_INTF(0x2dee, 0x4d22, 5)},    /* MeiG Smart SRM825L */
+	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d63, 0)}, /* MeiG SRM813Q w/ Modem(PPP) */
+	{QMI_QUIRK_SET_DTR(0x2dee, 0x4d64, 0)}, /* MeiG SRM813Q w/ NMEA */
 
 	/* 4. Gobi 1000 devices */
 	{QMI_GOBI1K_DEVICE(0x05c6, 0x9212)},	/* Acer Gobi Modem Device */
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 9dbce3232d7c..abfc7fdbe71d 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -402,7 +402,8 @@ static int sr9700_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		/* ignore the CRC length */
 		len = (skb->data[1] | (skb->data[2] << 8)) - 4;
 
-		if (len > ETH_FRAME_LEN || len > skb->len || len < 0)
+		if (len > ETH_FRAME_LEN || len < 0 ||
+		    len > skb->len - SR_RX_OVERHEAD)
 			return 0;
 
 		/* the last packet of current skb */
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 8dad17023e36..a2955729998c 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1065,6 +1065,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1317,6 +1323,11 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
+		return -EINVAL;
+	}
+
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
index e33f9edceb5f..b763495317f6 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/core.c
@@ -555,6 +555,8 @@ void brcmf_txfinalize(struct brcmf_if *ifp, struct sk_buff *txp, bool success)
 
 	if (type == ETH_P_PAE) {
 		atomic_dec(&ifp->pend_8021x_cnt);
+		/* Order the decrement before waitqueue_active() */
+		smp_mb__after_atomic();
 		if (waitqueue_active(&ifp->pend_8021x_wait))
 			wake_up(&ifp->pend_8021x_wait);
 	}
diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
index ad3893d45058..58abd03c406f 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
@@ -1568,6 +1568,10 @@ void brcms_free_timer(struct brcms_timer *t)
 
 	/* delete the timer in case it is active */
 	brcms_del_timer(t);
+	/* Ensure the callback has finished before freeing the timer
+	 * structure, since brcms_del_timer() uses non-synchronous cancel.
+	 */
+	cancel_delayed_work_sync(&t->dly_wrk);
 
 	if (wl->timers == t) {
 		wl->timers = wl->timers->next;
diff --git a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
index 4c6e742c5695..307a1f06f9fe 100644
--- a/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
+++ b/drivers/net/wireless/intel/ipw2x00/libipw_rx.c
@@ -417,7 +417,7 @@ int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 	    ieee->host_mc_decrypt : ieee->host_decrypt;
 
 	if (can_be_decrypted) {
-		if (skb->len >= hdrlen + 3) {
+		if (skb->len >= hdrlen + 4) {
 			/* Top two-bits of byte 3 are the key index */
 			keyidx = skb->data[hdrlen + 3] >> 6;
 		}
@@ -663,7 +663,7 @@ int libipw_rx(struct libipw_device *ieee, struct sk_buff *skb,
 		int trimlen = 0;
 
 		/* Top two-bits of byte 3 are the key index */
-		if (skb->len >= hdrlen + 3)
+		if (skb->len >= hdrlen + 4)
 			keyidx = skb->data[hdrlen + 3] >> 6;
 
 		/* To strip off any security data which appears before the
@@ -1324,6 +1324,9 @@ static int libipw_handle_assoc_resp(struct libipw_device *ieee, struct libipw_as
 	struct libipw_network *network = &network_resp;
 	struct net_device *dev = ieee->dev;
 
+	if (stats->len < sizeof(*frame))
+		return 1;
+
 	network->flags = 0;
 	network->qos_data.active = 0;
 	network->qos_data.supported = 0;
@@ -1536,6 +1539,9 @@ static void libipw_process_probe_response(struct libipw_device
 #endif
 	unsigned long flags;
 
+	if (stats->len < sizeof(*beacon))
+		return;
+
 	LIBIPW_DEBUG_SCAN("'%*pE' (%pM): %c%c%c%c %c%c%c%c-%c%c%c%c %c%c%c%c\n",
 		     info_element->len, info_element->data,
 		     beacon->header.addr3,
diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index 3bcb85fcbe19..4de97500c29a 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -2326,7 +2326,7 @@ il_dealloc_bcast_stations(struct il_priv *il)
 		if (!(il->stations[i].used & IL_STA_BCAST))
 			continue;
 
-		il->stations[i].used &= ~IL_STA_UCODE_ACTIVE;
+		il->stations[i].used = 0;
 		il->num_stations--;
 		BUG_ON(il->num_stations < 0);
 		kfree(il->stations[i].lq);
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
index 47eea2c2a739..4334ac2f9762 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-drv.c
@@ -627,6 +627,7 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 	u32 build, paging_mem_size;
 	int num_of_cpus;
 	bool usniffer_req = false;
+	size_t aligned_tlv_len;
 
 	if (len < sizeof(*ucode)) {
 		IWL_ERR(drv, "uCode has invalid length: %zd\n", len);
@@ -675,8 +676,16 @@ static int iwl_parse_tlv_firmware(struct iwl_drv *drv,
 				len, tlv_len);
 			return -EINVAL;
 		}
-		len -= ALIGN(tlv_len, 4);
-		data += sizeof(*tlv) + ALIGN(tlv_len, 4);
+
+		aligned_tlv_len = ALIGN(tlv_len, 4);
+		if (len < aligned_tlv_len) {
+			IWL_ERR(drv, "invalid aligned TLV len: %zd/%zu\n",
+				len, aligned_tlv_len);
+			return -EINVAL;
+		}
+
+		len -= aligned_tlv_len;
+		data += sizeof(*tlv) + aligned_tlv_len;
 
 		switch (tlv_type) {
 		case IWL_UCODE_TLV_INST:
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index fa784d835290..56a174b2eb76 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3075,7 +3075,7 @@ static void iwl_mvm_check_he_obss_narrow_bw_ru_iter(struct wiphy *wiphy,
 	elem = cfg80211_find_elem(WLAN_EID_EXT_CAPABILITY, ies->data,
 				  ies->len);
 
-	if (!elem || elem->datalen < 10 ||
+	if (!elem || elem->datalen < 11 ||
 	    !(elem->data[10] &
 	      WLAN_EXT_CAPA10_OBSS_NARROW_BW_RU_TOLERANCE_SUPPORT)) {
 		data->tolerated = false;
diff --git a/drivers/net/wireless/intersil/p54/eeprom.c b/drivers/net/wireless/intersil/p54/eeprom.c
index 5bd35c147e19..14646c878322 100644
--- a/drivers/net/wireless/intersil/p54/eeprom.c
+++ b/drivers/net/wireless/intersil/p54/eeprom.c
@@ -418,17 +418,22 @@ static int p54_generate_channel_lists(struct ieee80211_hw *dev)
 }
 
 static int p54_convert_rev0(struct ieee80211_hw *dev,
-			    struct pda_pa_curve_data *curve_data)
+			    struct pda_pa_curve_data *curve_data, size_t len)
 {
 	struct p54_common *priv = dev->priv;
 	struct p54_pa_curve_data_sample *dst;
 	struct pda_pa_curve_data_sample_rev0 *src;
+	size_t needed = curve_data->channels *
+		(sizeof(*src) * curve_data->points_per_channel + 2);
 	size_t cd_len = sizeof(*curve_data) +
 		(curve_data->points_per_channel*sizeof(*dst) + 2) *
 		 curve_data->channels;
 	unsigned int i, j;
 	void *source, *target;
 
+	if (len < sizeof(*curve_data) + needed)
+		return -EINVAL;
+
 	priv->curve_data = kmalloc(sizeof(*priv->curve_data) + cd_len,
 				   GFP_KERNEL);
 	if (!priv->curve_data)
@@ -470,17 +475,22 @@ static int p54_convert_rev0(struct ieee80211_hw *dev,
 }
 
 static int p54_convert_rev1(struct ieee80211_hw *dev,
-			    struct pda_pa_curve_data *curve_data)
+			    struct pda_pa_curve_data *curve_data, size_t len)
 {
 	struct p54_common *priv = dev->priv;
 	struct p54_pa_curve_data_sample *dst;
 	struct pda_pa_curve_data_sample_rev1 *src;
+	size_t needed = curve_data->channels *
+		(sizeof(*src) * curve_data->points_per_channel + 3);
 	size_t cd_len = sizeof(*curve_data) +
 		(curve_data->points_per_channel*sizeof(*dst) + 2) *
 		 curve_data->channels;
 	unsigned int i, j;
 	void *source, *target;
 
+	if (len < sizeof(*curve_data) + needed)
+		return -EINVAL;
+
 	priv->curve_data = kzalloc(cd_len + sizeof(*priv->curve_data),
 				   GFP_KERNEL);
 	if (!priv->curve_data)
@@ -767,6 +777,7 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 		case PDR_PRISM_PA_CAL_CURVE_DATA: {
 			struct pda_pa_curve_data *curve_data =
 				(struct pda_pa_curve_data *)entry->data;
+
 			if (data_len < sizeof(*curve_data)) {
 				err = -EINVAL;
 				goto err;
@@ -774,10 +785,10 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 
 			switch (curve_data->cal_method_rev) {
 			case 0:
-				err = p54_convert_rev0(dev, curve_data);
+				err = p54_convert_rev0(dev, curve_data, data_len);
 				break;
 			case 1:
-				err = p54_convert_rev1(dev, curve_data);
+				err = p54_convert_rev1(dev, curve_data, data_len);
 				break;
 			default:
 				wiphy_err(dev->wiphy,
@@ -805,7 +816,8 @@ int p54_parse_eeprom(struct ieee80211_hw *dev, void *eeprom, int len)
 			break;
 		case PDR_INTERFACE_LIST:
 			tmp = entry->data;
-			while ((u8 *)tmp < entry->data + data_len) {
+			while ((u8 *)tmp + sizeof(struct exp_if) <=
+			       entry->data + data_len) {
 				struct exp_if *exp_if = tmp;
 				if (exp_if->if_id == cpu_to_le16(IF_ID_ISL39000))
 					synth = le16_to_cpu(exp_if->variant);
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 02c31f7fcfd1..20d9f0c6142c 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -738,9 +738,9 @@ static const struct nla_policy hwsim_genl_policy[HWSIM_ATTR_MAX + 1] = {
 	[HWSIM_ATTR_FLAGS] = { .type = NLA_U32 },
 	[HWSIM_ATTR_RX_RATE] = { .type = NLA_U32 },
 	[HWSIM_ATTR_SIGNAL] = { .type = NLA_U32 },
-	[HWSIM_ATTR_TX_INFO] = { .type = NLA_BINARY,
-				 .len = IEEE80211_TX_MAX_RATES *
-					sizeof(struct hwsim_tx_rate)},
+	[HWSIM_ATTR_TX_INFO] =
+		NLA_POLICY_EXACT_LEN(IEEE80211_TX_MAX_RATES *
+				     sizeof(struct hwsim_tx_rate)),
 	[HWSIM_ATTR_COOKIE] = { .type = NLA_U64 },
 	[HWSIM_ATTR_CHANNELS] = { .type = NLA_U32 },
 	[HWSIM_ATTR_RADIO_ID] = { .type = NLA_U32 },
diff --git a/drivers/net/wireless/marvell/libertas/tx.c b/drivers/net/wireless/marvell/libertas/tx.c
index aeb481740df6..d56969920506 100644
--- a/drivers/net/wireless/marvell/libertas/tx.c
+++ b/drivers/net/wireless/marvell/libertas/tx.c
@@ -116,6 +116,13 @@ netdev_tx_t lbs_hard_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (priv->wdev->iftype == NL80211_IFTYPE_MONITOR) {
 		struct tx_radiotap_hdr *rtap_hdr = (void *)skb->data;
 
+		if (skb->len < sizeof(*rtap_hdr) + 4 + ETH_ALEN) {
+			lbs_deb_tx("tx err: short monitor frame %u\n", skb->len);
+			dev->stats.tx_dropped++;
+			dev->stats.tx_errors++;
+			goto free;
+		}
+
 		/* set txpd fields from the radiotap header */
 		txpd->tx_control = cpu_to_le32(convert_radiotap_rate_to_mv(rtap_hdr->rate));
 
diff --git a/drivers/net/wireless/marvell/libertas_tf/main.c b/drivers/net/wireless/marvell/libertas_tf/main.c
index b726e7e0b260..fe95cfb774cf 100644
--- a/drivers/net/wireless/marvell/libertas_tf/main.c
+++ b/drivers/net/wireless/marvell/libertas_tf/main.c
@@ -173,8 +173,8 @@ static int lbtf_init_adapter(struct lbtf_private *priv)
 static void lbtf_free_adapter(struct lbtf_private *priv)
 {
 	lbtf_deb_enter(LBTF_DEB_MAIN);
-	lbtf_free_cmd_buffer(priv);
 	timer_delete_sync(&priv->command_timer);
+	lbtf_free_cmd_buffer(priv);
 	lbtf_deb_leave(LBTF_DEB_MAIN);
 }
 
diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index 50205b6ae4ca..67f9679da062 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -802,7 +802,7 @@ struct chan_band_param_set {
 
 struct mwifiex_ie_types_chan_band_list_param_set {
 	struct mwifiex_ie_types_header header;
-	struct chan_band_param_set chan_band_param[1];
+	struct chan_band_param_set chan_band_param[];
 } __packed;
 
 struct mwifiex_ie_types_rates_param_set {
@@ -860,7 +860,7 @@ struct mwifiex_ie_types_wildcard_ssid_params {
 #define TSF_DATA_SIZE            8
 struct mwifiex_ie_types_tsf_timestamp {
 	struct mwifiex_ie_types_header header;
-	u8 tsf_data[1];
+	u8 tsf_data[];
 } __packed;
 
 struct mwifiex_cf_param_set {
@@ -877,8 +877,8 @@ struct mwifiex_ibss_param_set {
 struct mwifiex_ie_types_ss_param_set {
 	struct mwifiex_ie_types_header header;
 	union {
-		struct mwifiex_cf_param_set cf_param_set[1];
-		struct mwifiex_ibss_param_set ibss_param_set[1];
+		DECLARE_FLEX_ARRAY(struct mwifiex_cf_param_set, cf_param_set);
+		DECLARE_FLEX_ARRAY(struct mwifiex_ibss_param_set, ibss_param_set);
 	} cf_ibss;
 } __packed;
 
@@ -896,8 +896,8 @@ struct mwifiex_ds_param_set {
 struct mwifiex_ie_types_phy_param_set {
 	struct mwifiex_ie_types_header header;
 	union {
-		struct mwifiex_fh_param_set fh_param_set[1];
-		struct mwifiex_ds_param_set ds_param_set[1];
+		DECLARE_FLEX_ARRAY(struct mwifiex_fh_param_set, fh_param_set);
+		DECLARE_FLEX_ARRAY(struct mwifiex_ds_param_set, ds_param_set);
 	} fh_ds;
 } __packed;
 
@@ -1344,7 +1344,7 @@ struct host_cmd_ds_802_11_snmp_mib {
 	__le16 query_type;
 	__le16 oid;
 	__le16 buf_size;
-	u8 value[1];
+	u8 value[];
 } __packed;
 
 struct mwifiex_rate_scope {
@@ -1512,7 +1512,7 @@ struct mwifiex_scan_cmd_config {
 	 *  TLV_TYPE_CHANLIST, mwifiex_ie_types_chan_list_param_set
 	 *  WLAN_EID_SSID, mwifiex_ie_types_ssid_param_set
 	 */
-	u8 tlv_buf[1];	/* SSID TLV(s) and ChanList TLVs are stored
+	u8 tlv_buf[];	/* SSID TLV(s) and ChanList TLVs are stored
 				   here */
 } __packed;
 
@@ -1644,7 +1644,7 @@ struct host_cmd_ds_802_11_bg_scan_query_rsp {
 struct mwifiex_ietypes_domain_param_set {
 	struct mwifiex_ie_types_header header;
 	u8 country_code[IEEE80211_COUNTRY_STRING_LEN];
-	struct ieee80211_country_ie_triplet triplet[1];
+	struct ieee80211_country_ie_triplet triplet[];
 } __packed;
 
 struct host_cmd_ds_802_11d_domain_info {
diff --git a/drivers/net/wireless/marvell/mwifiex/join.c b/drivers/net/wireless/marvell/mwifiex/join.c
index 80e187391b25..760e26eb0d5f 100644
--- a/drivers/net/wireless/marvell/mwifiex/join.c
+++ b/drivers/net/wireless/marvell/mwifiex/join.c
@@ -431,15 +431,15 @@ int mwifiex_cmd_802_11_associate(struct mwifiex_private *priv,
 
 	phy_tlv = (struct mwifiex_ie_types_phy_param_set *) pos;
 	phy_tlv->header.type = cpu_to_le16(WLAN_EID_DS_PARAMS);
-	phy_tlv->header.len = cpu_to_le16(sizeof(phy_tlv->fh_ds.ds_param_set));
-	memcpy(&phy_tlv->fh_ds.ds_param_set,
+	phy_tlv->header.len = cpu_to_le16(sizeof(*phy_tlv->fh_ds.ds_param_set));
+	memcpy(phy_tlv->fh_ds.ds_param_set,
 	       &bss_desc->phy_param_set.ds_param_set.current_chan,
-	       sizeof(phy_tlv->fh_ds.ds_param_set));
+	       sizeof(*phy_tlv->fh_ds.ds_param_set));
 	pos += sizeof(phy_tlv->header) + le16_to_cpu(phy_tlv->header.len);
 
 	ss_tlv = (struct mwifiex_ie_types_ss_param_set *) pos;
 	ss_tlv->header.type = cpu_to_le16(WLAN_EID_CF_PARAMS);
-	ss_tlv->header.len = cpu_to_le16(sizeof(ss_tlv->cf_ibss.cf_param_set));
+	ss_tlv->header.len = cpu_to_le16(sizeof(*ss_tlv->cf_ibss.cf_param_set));
 	pos += sizeof(ss_tlv->header) + le16_to_cpu(ss_tlv->header.len);
 
 	/* Get the common rates supported between the driver and the BSS Desc */
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index 7cec6398da71..9ee932e66a25 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -3244,7 +3244,7 @@ static int mwifiex_pcie_request_irq(struct mwifiex_adapter *adapter)
 					    ret);
 				for (j = 0; j < i; j++)
 					free_irq(card->msix_entries[j].vector,
-						 &card->msix_ctx[i]);
+						 &card->msix_ctx[j]);
 				pci_disable_msix(pdev);
 			} else {
 				mwifiex_dbg(adapter, MSG, "MSIx enabled!");
diff --git a/drivers/net/wireless/marvell/mwifiex/scan.c b/drivers/net/wireless/marvell/mwifiex/scan.c
index 7f949aa77268..b6bff7c45184 100644
--- a/drivers/net/wireless/marvell/mwifiex/scan.c
+++ b/drivers/net/wireless/marvell/mwifiex/scan.c
@@ -116,12 +116,24 @@ has_vendor_hdr(struct ieee_types_vendor_specific *ie, u8 key)
  * a given oui in PTK.
  */
 static u8
-mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui)
+mwifiex_search_oui_in_ie(struct ie_body *iebody, u8 *oui, int ie_len)
 {
+	const size_t ptk_body_offset = offsetof(struct ie_body, ptk_body);
 	u8 count;
 
+	/* ie_len is the number of bytes available at iebody. Keep it signed
+	 * and reject a negative (underflowed) length before the unsigned
+	 * comparisons below, so a small or zero IE length cannot wrap.
+	 */
+	if (ie_len < 0 || (size_t)ie_len < ptk_body_offset)
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	count = iebody->ptk_cnt[0];
 
+	/* Reject an OUI count whose list would run past the element. */
+	if (ptk_body_offset + count * sizeof(iebody->ptk_body) > (size_t)ie_len)
+		return MWIFIEX_OUI_NOT_PRESENT;
+
 	/* There could be multiple OUIs for PTK hence
 	   1) Take the length.
 	   2) Check all the OUIs for AES.
@@ -155,11 +167,14 @@ mwifiex_is_rsn_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_ieee_hdr(bss_desc->bcn_rsn_ie, WLAN_EID_RSN)) {
+		int ie_len = (int)bss_desc->bcn_rsn_ie->ieee_hdr.len -
+			RSN_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)
 			 (((u8 *) bss_desc->bcn_rsn_ie->data) +
 			  RSN_GTK_OUI_OFFSET);
 		oui = &mwifiex_rsn_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
@@ -181,10 +196,14 @@ mwifiex_is_wpa_oui_present(struct mwifiex_bssdescriptor *bss_desc, u32 cipher)
 	u8 ret = MWIFIEX_OUI_NOT_PRESENT;
 
 	if (has_vendor_hdr(bss_desc->bcn_wpa_ie, WLAN_EID_VENDOR_SPECIFIC)) {
+		int ie_len = (int)bss_desc->bcn_wpa_ie->vend_hdr.len -
+			(int)sizeof(bss_desc->bcn_wpa_ie->vend_hdr.oui) -
+			WPA_GTK_OUI_OFFSET;
+
 		iebody = (struct ie_body *)((u8 *)bss_desc->bcn_wpa_ie->data +
 					    WPA_GTK_OUI_OFFSET);
 		oui = &mwifiex_wpa_oui[cipher][0];
-		ret = mwifiex_search_oui_in_ie(iebody, oui);
+		ret = mwifiex_search_oui_in_ie(iebody, oui, ie_len);
 		if (ret)
 			return ret;
 	}
@@ -2124,6 +2143,7 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	u32 bytes_left;
 	u32 idx;
 	u32 tlv_buf_size;
+	size_t fixed_size;
 	struct mwifiex_ie_types_chan_band_list_param_set *chan_band_tlv;
 	struct chan_band_param_set *chan_band;
 	u8 is_bgscan_resp;
@@ -2139,6 +2159,14 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	else
 		scan_rsp = &resp->params.scan_resp;
 
+	scan_resp_size = le16_to_cpu(resp->size);
+	fixed_size = scan_rsp->bss_desc_and_tlv_buffer - (u8 *)resp;
+	if (scan_resp_size < fixed_size) {
+		mwifiex_dbg(adapter, ERROR,
+			    "SCAN_RESP: response is too short\n");
+		ret = -1;
+		goto check_next_scan;
+	}
 
 	if (scan_rsp->number_of_sets > MWIFIEX_MAX_AP) {
 		mwifiex_dbg(adapter, ERROR,
@@ -2156,8 +2184,6 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 		    "info: SCAN_RESP: bss_descript_size %d\n",
 		    bytes_left);
 
-	scan_resp_size = le16_to_cpu(resp->size);
-
 	mwifiex_dbg(adapter, INFO,
 		    "info: SCAN_RESP: returned %d APs before parsing\n",
 		    scan_rsp->number_of_sets);
@@ -2165,15 +2191,17 @@ int mwifiex_ret_802_11_scan(struct mwifiex_private *priv,
 	bss_info = scan_rsp->bss_desc_and_tlv_buffer;
 
 	/*
-	 * The size of the TLV buffer is equal to the entire command response
-	 *   size (scan_resp_size) minus the fixed fields (sizeof()'s), the
-	 *   BSS Descriptions (bss_descript_size as bytesLef) and the command
-	 *   response header (S_DS_GEN)
+	 * The TLV buffer follows the command-specific fixed fields and the BSS
+	 * descriptions. Background-scan responses have an additional fixed
+	 * field before scan_rsp, which is included in fixed_size.
 	 */
-	tlv_buf_size = scan_resp_size - (bytes_left
-					 + sizeof(scan_rsp->bss_descript_size)
-					 + sizeof(scan_rsp->number_of_sets)
-					 + S_DS_GEN);
+	if (bytes_left > scan_resp_size - fixed_size) {
+		mwifiex_dbg(adapter, ERROR,
+			    "SCAN_RESP: BSS data exceeds response\n");
+		ret = -1;
+		goto check_next_scan;
+	}
+	tlv_buf_size = scan_resp_size - fixed_size - bytes_left;
 
 	tlv_data = (struct mwifiex_ie_types_data *) (scan_rsp->
 						 bss_desc_and_tlv_buffer +
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
index d3a968ef21ef..5bfb8d6372a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_cmd.c
@@ -120,7 +120,7 @@ static int mwifiex_cmd_802_11_snmp_mib(struct mwifiex_private *priv,
 		    "cmd: SNMP_CMD: cmd_oid = 0x%x\n", cmd_oid);
 	cmd->command = cpu_to_le16(HostCmd_CMD_802_11_SNMP_MIB);
 	cmd->size = cpu_to_le16(sizeof(struct host_cmd_ds_802_11_snmp_mib)
-				- 1 + S_DS_GEN);
+				+ S_DS_GEN);
 
 	snmp_mib->oid = cpu_to_le16((u16)cmd_oid);
 	if (cmd_action == HostCmd_ACT_GEN_GET) {
diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
index 1f5a6dab9ce5..6cdb0a03cdc7 100644
--- a/drivers/net/wireless/marvell/mwifiex/util.c
+++ b/drivers/net/wireless/marvell/mwifiex/util.c
@@ -347,10 +347,16 @@ mwifiex_parse_mgmt_packet(struct mwifiex_private *priv, u8 *payload, u16 len,
 
 	switch (stype) {
 	case IEEE80211_STYPE_ACTION:
-		category = *(payload + sizeof(struct ieee80211_hdr));
+		if (len < sizeof(*ieee_hdr) + 1)
+			return -1;
+
+		category = *(payload + sizeof(*ieee_hdr));
 		switch (category) {
 		case WLAN_CATEGORY_PUBLIC:
-			action_code = *(payload + sizeof(struct ieee80211_hdr)
+			if (len < sizeof(*ieee_hdr) + 2)
+				return -1;
+
+			action_code = *(payload + sizeof(*ieee_hdr)
 					+ 1);
 			if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
 				addr2 = ieee_hdr->addr2;
diff --git a/drivers/net/wireless/mediatek/mt76/pci.c b/drivers/net/wireless/mediatek/mt76/pci.c
index 4c1c159fbb62..36dba6e03e8b 100644
--- a/drivers/net/wireless/mediatek/mt76/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/pci.c
@@ -30,8 +30,14 @@ void mt76_pci_disable_aspm(struct pci_dev *pdev)
 
 	if (IS_ENABLED(CONFIG_PCIEASPM)) {
 		int err;
+		int state = 0;
 
-		err = pci_disable_link_state(pdev, aspm_conf);
+		if (aspm_conf & PCI_EXP_LNKCTL_ASPM_L0S)
+			state |= PCIE_LINK_STATE_L0S;
+		if (aspm_conf & PCI_EXP_LNKCTL_ASPM_L1)
+			state |= PCIE_LINK_STATE_L1;
+
+		err = pci_disable_link_state(pdev, state);
 		if (!err)
 			return;
 	}
diff --git a/drivers/net/wireless/microchip/wilc1000/cfg80211.c b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
index 5d4f9e9a81e0..43849072cbdf 100644
--- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
+++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
@@ -1039,6 +1039,13 @@ void wilc_wfi_p2p_rx(struct wilc_vif *vif, u8 *buff, u32 size)
 	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buff, size))
 		goto out_rx_mgmt;
 
+	/* ieee80211_is_public_action() only validates up to the category
+	 * byte, so reject frames too short for the P2P public action header
+	 * before dereferencing it or computing size - ie_offset.
+	 */
+	if (size < ie_offset)
+		goto out_rx_mgmt;
+
 	d = (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
 	if (d->oui_subtype != GO_NEG_REQ && d->oui_subtype != GO_NEG_RSP &&
 	    d->oui_subtype != P2P_INV_REQ && d->oui_subtype != P2P_INV_RSP)
@@ -1183,6 +1190,13 @@ static int mgmt_tx(struct wiphy *wiphy,
 	if (!ieee80211_is_public_action((struct ieee80211_hdr *)buf, len))
 		goto out_set_timeout;
 
+	/* ieee80211_is_public_action() only validates up to the category
+	 * byte, so reject frames too short for the P2P public action header
+	 * before dereferencing it or computing len - ie_offset.
+	 */
+	if (len < ie_offset)
+		goto out_set_timeout;
+
 	d = (struct wilc_p2p_pub_act_frame *)(&mgmt->u.action);
 	if (d->oui_type != WLAN_OUI_TYPE_WFA_P2P ||
 	    d->oui_subtype != GO_NEG_CONF) {
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/wireless/microchip/wilc1000/wlan.c
index 6a82fb2f283e..aa3810a791e5 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -771,6 +771,15 @@ static void wilc_wlan_handle_isr_ext(struct wilc *wilc, u32 int_status)
 	if (size <= 0)
 		return;
 
+	/* A size exceeding the RX buffer is bogus; drop the transfer
+	 * instead of overflowing the buffer.
+	 */
+	if (size > WILC_RX_BUFF_SIZE) {
+		wilc->hif_func->hif_clear_int_ext(wilc,
+						  DATA_INT_CLR | ENABLE_RX_VMM);
+		return;
+	}
+
 	if (WILC_RX_BUFF_SIZE - offset < size)
 		offset = 0;
 
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
index 1520785c3ddb..b3e3eac9dd26 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2400pci.c
@@ -1429,7 +1429,7 @@ static irqreturn_t rt2400pci_interrupt(int irq, void *dev_instance)
  */
 static int rt2400pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
index 1be535c74917..758be3c1a259 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2500pci.c
@@ -1555,7 +1555,7 @@ static irqreturn_t rt2500pci_interrupt(int irq, void *dev_instance)
  */
 static int rt2500pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
diff --git a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
index 9a33baaa6184..d5c930c1d62e 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt2800pci.c
@@ -108,7 +108,7 @@ static void rt2800pci_eepromregister_write(struct eeprom_93cx6 *eeprom)
 
 static int rt2800pci_read_eeprom_pci(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 
 	reg = rt2x00mmio_register_read(rt2x00dev, E2PROM_CSR);
diff --git a/drivers/net/wireless/ralink/rt2x00/rt61pci.c b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
index d04761c32a5d..102cee7cc869 100644
--- a/drivers/net/wireless/ralink/rt2x00/rt61pci.c
+++ b/drivers/net/wireless/ralink/rt2x00/rt61pci.c
@@ -2298,7 +2298,7 @@ static irqreturn_t rt61pci_interrupt(int irq, void *dev_instance)
  */
 static int rt61pci_validate_eeprom(struct rt2x00_dev *rt2x00dev)
 {
-	struct eeprom_93cx6 eeprom;
+	struct eeprom_93cx6 eeprom = {};
 	u32 reg;
 	u16 word;
 	u8 *mac;
diff --git a/drivers/net/wireless/rsi/rsi_91x_hal.c b/drivers/net/wireless/rsi/rsi_91x_hal.c
index 30d2eccbcadd..62e36bbfecc4 100644
--- a/drivers/net/wireless/rsi/rsi_91x_hal.c
+++ b/drivers/net/wireless/rsi/rsi_91x_hal.c
@@ -434,6 +434,7 @@ int rsi_prepare_beacon(struct rsi_common *common, struct sk_buff *skb)
 	struct ieee80211_vif *vif;
 	struct sk_buff *mac_bcn;
 	u8 vap_id = 0, i;
+	unsigned int tailroom;
 	u16 tim_offset = 0;
 
 	for (i = 0; i < RSI_MAX_VIFS; i++) {
@@ -483,6 +484,13 @@ int rsi_prepare_beacon(struct rsi_common *common, struct sk_buff *skb)
 	if (mac_bcn->data[tim_offset + 2] == 0)
 		bcn_frm->frame_info |= cpu_to_le16(RSI_DATA_DESC_DTIM_BEACON);
 
+	tailroom = skb_tailroom(skb);
+	if (tailroom < FRAME_DESC_SZ ||
+	    mac_bcn->len > tailroom - FRAME_DESC_SZ) {
+		dev_kfree_skb(mac_bcn);
+		return -EMSGSIZE;
+	}
+
 	memcpy(&skb->data[FRAME_DESC_SZ], mac_bcn->data, mac_bcn->len);
 	skb_put(skb, mac_bcn->len + FRAME_DESC_SZ);
 
diff --git a/drivers/net/wireless/rsi/rsi_91x_mgmt.c b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
index 9000a5d51003..d576d288110a 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mgmt.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mgmt.c
@@ -848,10 +848,10 @@ int rsi_hal_load_key(struct rsi_common *common,
 		} else {
 			memcpy(&set_key->key[0][0], data, key_len);
 		}
-		memcpy(set_key->tx_mic_key, &data[16], 8);
-		memcpy(set_key->rx_mic_key, &data[24], 8);
-	} else {
-		memset(&set_key[FRAME_DESC_SZ], 0, frame_len - FRAME_DESC_SZ);
+		if (cipher == WLAN_CIPHER_SUITE_TKIP) {
+			memcpy(set_key->tx_mic_key, &data[16], 8);
+			memcpy(set_key->rx_mic_key, &data[24], 8);
+		}
 	}
 
 	skb_put(skb, frame_len);
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index 30430b4a4188..bace9e06602d 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -3666,10 +3666,8 @@ void wlcore_regdomain_config(struct wl1271 *wl)
 	}
 
 	ret = wlcore_cmd_regdomain_config_locked(wl);
-	if (ret < 0) {
+	if (ret < 0)
 		wl12xx_queue_recovery_work(wl);
-		goto out;
-	}
 
 	pm_runtime_mark_last_busy(wl->dev);
 	pm_runtime_put_autosuspend(wl->dev);
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index dd6675436bda..a2bb8542c6f9 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -430,6 +430,7 @@ static netdev_tx_t virt_wifi_start_xmit(struct sk_buff *skb,
 	priv->tx_packets++;
 	if (!priv->is_connected) {
 		priv->tx_failed++;
+		dev_kfree_skb_any(skb);
 		return NET_XMIT_DROP;
 	}
 
@@ -551,7 +552,6 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	eth_hw_addr_inherit(dev, priv->lowerdev);
-	netif_stacked_transfer_operstate(priv->lowerdev, dev);
 
 	SET_NETDEV_DEV(dev, &priv->lowerdev->dev);
 	dev->ieee80211_ptr = kzalloc(sizeof(*dev->ieee80211_ptr), GFP_KERNEL);
@@ -578,6 +578,8 @@ static int virt_wifi_newlink(struct net *src_net, struct net_device *dev,
 		goto unregister_netdev;
 	}
 
+	netif_stacked_transfer_operstate(priv->lowerdev, dev);
+
 	dev->priv_destructor = virt_wifi_net_device_destructor;
 	priv->being_deleted = false;
 	priv->is_connected = false;
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 6de0f26c5fc5..2121d2043607 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -252,9 +252,9 @@ static int microread_start_poll(struct nfc_hci_dev *hdev,
 		param[1] |= (1 << 1);
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-						       &hdev->gb_len);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+					    sizeof(hdev->gb), &hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/nfcmrvl/fw_dnld.c b/drivers/nfc/nfcmrvl/fw_dnld.c
index 52c8ae504e32..1bc8c15cba13 100644
--- a/drivers/nfc/nfcmrvl/fw_dnld.c
+++ b/drivers/nfc/nfcmrvl/fw_dnld.c
@@ -274,9 +274,14 @@ static int process_state_fw_dnld(struct nfcmrvl_private *priv,
 		 * B8..N: payload
 		 */
 
-		/* Remove NCI HDR */
-		skb_pull(skb, 3);
-		if (skb->data[0] != HELPER_CMD_PACKET_FORMAT || skb->len != 5) {
+		if (skb->len != NCI_DATA_HDR_SIZE + 5) {
+			nfc_err(priv->dev, "bad command");
+			return -EINVAL;
+		}
+
+		/* Remove NCI header */
+		skb_pull(skb, NCI_DATA_HDR_SIZE);
+		if (skb->data[0] != HELPER_CMD_PACKET_FORMAT) {
 			nfc_err(priv->dev, "bad command");
 			return -EINVAL;
 		}
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d0d69af8925c..67999d6f76c9 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -1381,10 +1381,11 @@ static int pn533_poll_dep(struct nfc_dev *nfc_dev)
 
 	dev_dbg(dev->dev, "%s", __func__);
 
-	if (!dev->gb) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
-
-		if (!dev->gb || !dev->gb_len) {
+	if (!dev->gb_len) {
+		nfc_get_local_general_bytes(nfc_dev, dev->gb,
+					    sizeof(dev->gb),
+					    &dev->gb_len);
+		if (!dev->gb_len) {
 			dev->poll_dep = 0;
 			queue_work(dev->wq, &dev->rf_work);
 		}
@@ -1688,8 +1689,9 @@ static int pn533_start_poll(struct nfc_dev *nfc_dev,
 	}
 
 	if (tm_protocols) {
-		dev->gb = nfc_get_local_general_bytes(nfc_dev, &dev->gb_len);
-		if (dev->gb == NULL)
+		nfc_get_local_general_bytes(nfc_dev, dev->gb,
+					    sizeof(dev->gb), &dev->gb_len);
+		if (dev->gb_len == 0)
 			tm_protocols = 0;
 	}
 
diff --git a/drivers/nfc/pn533/pn533.h b/drivers/nfc/pn533/pn533.h
index 5f94f38a2a08..efb4e97338b9 100644
--- a/drivers/nfc/pn533/pn533.h
+++ b/drivers/nfc/pn533/pn533.h
@@ -6,6 +6,8 @@
  * Copyright (C) 2012-2013 Tieto Poland
  */
 
+#include <net/nfc/nfc.h>
+
 #define PN533_DEVICE_STD		0x1
 #define PN533_DEVICE_PASORI		0x2
 #define PN533_DEVICE_ACR122U		0x3
@@ -166,7 +168,7 @@ struct pn533 {
 	struct timer_list listen_timer;
 	int cancel_listen;
 
-	u8 *gb;
+	u8 gb[NFC_MAX_GT_LEN];
 	size_t gb_len;
 
 	u8 tgt_available_prots;
diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 3ba6b387406c..7fffd2c95864 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -320,7 +320,9 @@ static bool pn533_acr122_is_rx_frame_valid(void *_frame, struct pn533 *dev)
 	if (frame->ccid.type != 0x83)
 		return false;
 
-	if (!frame->ccid.datalen)
+	if (frame->ccid.datalen < 2 ||
+	    frame->ccid.datalen > PN533_ACR122_FRAME_MAX_PAYLOAD_LEN +
+	    PN533_ACR122_RX_FRAME_TAIL_LEN)
 		return false;
 
 	if (frame->data[frame->ccid.datalen - 2] == 0x63)
diff --git a/drivers/nfc/pn544/pn544.c b/drivers/nfc/pn544/pn544.c
index b788870473e8..a5fb5f4673d0 100644
--- a/drivers/nfc/pn544/pn544.c
+++ b/drivers/nfc/pn544/pn544.c
@@ -378,10 +378,9 @@ static int pn544_hci_start_poll(struct nfc_hci_dev *hdev,
 		return r;
 
 	if ((im_protocols | tm_protocols) & NFC_PROTO_NFC_DEP_MASK) {
-		hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							&hdev->gb_len);
-		pr_debug("generate local bytes %p\n", hdev->gb);
-		if (hdev->gb == NULL || hdev->gb_len == 0) {
+		nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+					    sizeof(hdev->gb), &hdev->gb_len);
+		if (hdev->gb_len == 0) {
 			im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 		}
diff --git a/drivers/nfc/port100.c b/drivers/nfc/port100.c
index 2ae1474faede..2145653cfb31 100644
--- a/drivers/nfc/port100.c
+++ b/drivers/nfc/port100.c
@@ -635,6 +635,13 @@ static void port100_recv_response(struct urb *urb)
 
 	in_frame = dev->in_urb->transfer_buffer;
 
+	if (urb->actual_length < PORT100_FRAME_HEADER_LEN ||
+	    urb->actual_length < port100_rx_frame_size(in_frame)) {
+		nfc_err(&dev->interface->dev, "Received a truncated frame\n");
+		cmd->status = -EIO;
+		goto sched_wq;
+	}
+
 	if (!port100_rx_frame_is_valid(in_frame)) {
 		nfc_err(&dev->interface->dev, "Received an invalid frame\n");
 		cmd->status = -EIO;
diff --git a/drivers/nfc/st21nfca/core.c b/drivers/nfc/st21nfca/core.c
index 6ca0d2f56b18..68cbdfc67e77 100644
--- a/drivers/nfc/st21nfca/core.c
+++ b/drivers/nfc/st21nfca/core.c
@@ -352,10 +352,10 @@ static int st21nfca_hci_start_poll(struct nfc_hci_dev *hdev,
 			if (r < 0)
 				return r;
 		} else {
-			hdev->gb = nfc_get_local_general_bytes(hdev->ndev,
-							       &hdev->gb_len);
-
-			if (hdev->gb == NULL || hdev->gb_len == 0) {
+			nfc_get_local_general_bytes(hdev->ndev, hdev->gb,
+						    sizeof(hdev->gb),
+						    &hdev->gb_len);
+			if (hdev->gb_len == 0) {
 				im_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 				tm_protocols &= ~NFC_PROTO_NFC_DEP_MASK;
 			}
@@ -578,9 +578,7 @@ static int st21nfca_get_iso15693_inventory(struct nfc_hci_dev *hdev,
 	if (r < 0)
 		goto exit;
 
-	skb_pull(inventory_skb, 2);
-
-	if (inventory_skb->len == 0 ||
+	if (!skb_pull(inventory_skb, 2) || inventory_skb->len < 2 ||
 	    inventory_skb->len > NFC_ISO15693_UID_MAXSIZE) {
 		r = -EPROTO;
 		goto exit;
diff --git a/drivers/nfc/st21nfca/i2c.c b/drivers/nfc/st21nfca/i2c.c
index 6ea59426ab0b..70b0c58c4a8c 100644
--- a/drivers/nfc/st21nfca/i2c.c
+++ b/drivers/nfc/st21nfca/i2c.c
@@ -292,35 +292,42 @@ static int check_crc(u8 *buf, int buflen)
  */
 static int st21nfca_hci_i2c_repack(struct sk_buff *skb)
 {
-	int i, j, r, size;
+	int read, write, r, size;
 
-	if (skb->len < 1 || (skb->len > 1 && skb->data[1] != 0))
+	if (skb->len < ST21NFCA_FRAME_HEADROOM ||
+	    !IS_START_OF_FRAME(skb->data))
 		return -EBADMSG;
 
 	size = get_frame_size(skb->data, skb->len);
 	if (size > 0) {
+		if (size < ST21NFCA_FRAME_HEADROOM + 2)
+			return -EBADMSG;
+
 		skb_trim(skb, size);
 		/* remove ST21NFCA byte stuffing for upper layer */
-		for (i = 1, j = 0; i < skb->len; i++) {
-			if (skb->data[i + j] ==
+		for (read = 1, write = 1; read < skb->len;) {
+			if (skb->data[read] ==
 					(u8) ST21NFCA_ESCAPE_BYTE_STUFFING) {
-				skb->data[i] = skb->data[i + j + 1]
-						| ST21NFCA_BYTE_STUFFING_MASK;
-				i++;
-				j++;
+				if (read + 1 == skb->len)
+					return -EBADMSG;
+
+				skb->data[write++] = skb->data[read + 1]
+						     | ST21NFCA_BYTE_STUFFING_MASK;
+				read += 2;
+			} else {
+				skb->data[write++] = skb->data[read++];
 			}
-			skb->data[i] = skb->data[i + j];
 		}
 		/* remove byte stuffing useless byte */
-		skb_trim(skb, i - j);
+		skb_trim(skb, write);
+		if (skb->len < ST21NFCA_FRAME_HEADROOM + 2)
+			return -EBADMSG;
 		/* remove ST21NFCA_SOF_EOF from head */
 		skb_pull(skb, 1);
 
 		r = check_crc(skb->data, skb->len);
-		if (r != 0) {
-			i = 0;
+		if (r != 0)
 			return -EBADMSG;
-		}
 
 		/* remove headbyte */
 		skb_pull(skb, 1);
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index 3d7adc0de128..f7df2299a57a 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -925,7 +925,7 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 	val = prop->value;
 	while (nr) {
-		unsigned long freq = be32_to_cpup(val++) * 1000;
+		unsigned long freq = (unsigned long)be32_to_cpup(val++) * 1000;
 		unsigned long volt = be32_to_cpup(val++);
 
 		ret = _opp_add_v1(opp_table, dev, freq, volt, false);
diff --git a/drivers/pci/controller/pcie-altera.c b/drivers/pci/controller/pcie-altera.c
index 68a1bdcf02f8..d7089000521c 100644
--- a/drivers/pci/controller/pcie-altera.c
+++ b/drivers/pci/controller/pcie-altera.c
@@ -837,8 +837,10 @@ static int altera_pcie_remove(struct platform_device *pdev)
 	struct altera_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 	altera_pcie_irq_teardown(pcie);
 
 	return 0;
diff --git a/drivers/pci/controller/pcie-iproc.c b/drivers/pci/controller/pcie-iproc.c
index cc5b7823edeb..fcde897557bb 100644
--- a/drivers/pci/controller/pcie-iproc.c
+++ b/drivers/pci/controller/pcie-iproc.c
@@ -1556,8 +1556,10 @@ int iproc_pcie_remove(struct iproc_pcie *pcie)
 {
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
+	pci_unlock_rescan_remove();
 
 	iproc_pcie_msi_disable(pcie);
 
diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index d2aa0a681967..b7e6ee250e1a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -1155,8 +1155,10 @@ static int mtk_pcie_remove(struct platform_device *pdev)
 	struct mtk_pcie *pcie = platform_get_drvdata(pdev);
 	struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(host->bus);
 	pci_remove_root_bus(host->bus);
+	pci_unlock_rescan_remove();
 	mtk_pcie_free_resources(pcie);
 
 	mtk_pcie_irq_teardown(pcie);
diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index 86bb4f82048a..90f3e69b5d94 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -1021,8 +1021,10 @@ static int rockchip_pcie_remove(struct platform_device *pdev)
 	struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
 	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(rockchip);
 
+	pci_lock_rescan_remove();
 	pci_stop_root_bus(bridge->bus);
 	pci_remove_root_bus(bridge->bus);
+	pci_unlock_rescan_remove();
 	irq_domain_remove(rockchip->irq_domain);
 
 	rockchip_pcie_deinit_phys(rockchip);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index fe15e59e7c56..c831988a3030 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -463,13 +463,6 @@ static int pci_device_remove(struct device *dev)
 	/* Undo the runtime PM settings in local_pci_probe() */
 	pm_runtime_put_sync(dev);
 
-	/*
-	 * If the device is still on, set the power state as "unknown",
-	 * since it might change by the next time we load the driver.
-	 */
-	if (pci_dev->current_state == PCI_D0)
-		pci_dev->current_state = PCI_UNKNOWN;
-
 	/*
 	 * We would love to complain here if pci_dev->is_enabled is set, that
 	 * the driver should have called pci_disable_device(), but the
@@ -808,7 +801,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 
 	if (!pm) {
 		pci_save_state(pci_dev);
-		goto Fixup;
+		goto set_unknown;
 	}
 
 	if (pm->suspend_noirq) {
@@ -865,6 +858,7 @@ static int pci_pm_suspend_noirq(struct device *dev)
 		goto Fixup;
 	}
 
+set_unknown:
 	pci_pm_set_unknown_state(pci_dev);
 
 	/*
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ae0129b6ba10..67f5f84441d9 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1308,18 +1308,19 @@ void __weak pci_remove_resource_files(struct pci_dev *dev) { return; }
  * @off: file offset
  * @count: number of byte in input
  *
- * writing anything except 0 enables it
+ * Writing a boolean value enables or disables the ROM display.
  */
 static ssize_t pci_write_rom(struct file *filp, struct kobject *kobj,
 			     struct bin_attribute *bin_attr, char *buf,
 			     loff_t off, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
+	bool enable;
 
-	if ((off ==  0) && (*buf == '0') && (count == 2))
-		pdev->rom_attr_enabled = 0;
-	else
-		pdev->rom_attr_enabled = 1;
+	if (kstrtobool(buf, &enable))
+		return -EINVAL;
+
+	pdev->rom_attr_enabled = enable;
 
 	return count;
 }
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index e95439af31c8..b3ea52038aec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3614,6 +3614,9 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003c, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0033, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x0034, quirk_no_bus_reset);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ATHEROS, 0x003e, quirk_no_bus_reset);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1103, quirk_no_bus_reset); /* WCN6855 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x1107, quirk_no_bus_reset); /* WCN7850 */
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_QCOM, 0x0308, quirk_no_bus_reset); /* SDX62/SDX65 */
 
 /*
  * Root port on some Cavium CN8xxx chips do not successfully complete a bus
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 491a46e330b3..5f3f7711329a 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1635,7 +1635,8 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 					    &pcs_irqdomain_ops,
 					    pcs_soc);
 	if (!pcs->domain) {
-		irq_set_chained_handler(pcs_soc->irq, NULL);
+		pcs_irq_free(pcs);
+		pcs_soc->irq = -1;
 		return -EINVAL;
 	}
 
diff --git a/drivers/platform/x86/dell-laptop.c b/drivers/platform/x86/dell-laptop.c
index 70edc5bb3a14..af5001ecf77f 100644
--- a/drivers/platform/x86/dell-laptop.c
+++ b/drivers/platform/x86/dell-laptop.c
@@ -198,6 +198,15 @@ static const struct dmi_system_id dell_quirks[] __initconst = {
 		},
 		.driver_data = &quirk_dell_vostro_v130,
 	},
+	{
+		.callback = dmi_matched,
+		.ident = "Dell Inspiron N5110",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Inspiron N5110"),
+		},
+		.driver_data = &quirk_dell_vostro_v130,
+	},
 	{
 		.callback = dmi_matched,
 		.ident = "Dell Vostro 3360",
diff --git a/drivers/platform/x86/intel-hid.c b/drivers/platform/x86/intel-hid.c
index f52367363d53..ccb4b7233e79 100644
--- a/drivers/platform/x86/intel-hid.c
+++ b/drivers/platform/x86/intel-hid.c
@@ -114,6 +114,13 @@ static const struct dmi_system_id button_array_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Surface Go 4"),
 		},
 	},
+	{
+		.ident = "HP ProBook x360 440 G1",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "HP ProBook x360 440 G1"),
+		},
+	},
 	{ }
 };
 
diff --git a/drivers/rtc/rtc-aspeed.c b/drivers/rtc/rtc-aspeed.c
index eacdd0637cce..ffa6f964b891 100644
--- a/drivers/rtc/rtc-aspeed.c
+++ b/drivers/rtc/rtc-aspeed.c
@@ -111,6 +111,7 @@ static const struct of_device_id aspeed_rtc_match[] = {
 	{ .compatible = "aspeed,ast2400-rtc", },
 	{ .compatible = "aspeed,ast2500-rtc", },
 	{ .compatible = "aspeed,ast2600-rtc", },
+	{ .compatible = "aspeed,ast2700-rtc", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, aspeed_rtc_match);
diff --git a/drivers/rtc/rtc-bq32k.c b/drivers/rtc/rtc-bq32k.c
index 933e4237237d..70907aa1fea6 100644
--- a/drivers/rtc/rtc-bq32k.c
+++ b/drivers/rtc/rtc-bq32k.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/bcd.h>
+#include <linux/delay.h>
 
 #define BQ32K_SECONDS		0x00	/* Seconds register address */
 #define BQ32K_SECONDS_MASK	0x7F	/* Mask over seconds value */
@@ -88,9 +89,17 @@ static int bq32k_write(struct device *dev, void *data, uint8_t off, uint8_t len)
 
 static int bq32k_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
+	struct i2c_client *client = to_i2c_client(dev);
 	struct bq32k_regs regs;
 	int error;
 
+	/*
+	 * When the device doesn't have the interrupt connected, prevent
+	 * userpace from polling the RTC registers too frequently.
+	 */
+	if (client->irq <= 0)
+		usleep_range(2000, 2500);
+
 	error = bq32k_read(dev, &regs, 0, sizeof(regs));
 	if (error)
 		return error;
diff --git a/drivers/s390/char/zcore.c b/drivers/s390/char/zcore.c
index 1aee6b2ae66f..baea531c990f 100644
--- a/drivers/s390/char/zcore.c
+++ b/drivers/s390/char/zcore.c
@@ -45,8 +45,6 @@ struct ipib_info {
 static struct debug_info *zcore_dbf;
 static int hsa_available;
 static struct dentry *zcore_dir;
-static struct dentry *zcore_reipl_file;
-static struct dentry *zcore_hsa_file;
 static struct ipl_parameter_block *zcore_ipl_block;
 
 static DEFINE_MUTEX(hsa_buf_mutex);
@@ -325,10 +323,8 @@ static int __init zcore_init(void)
 		goto fail;
 
 	zcore_dir = debugfs_create_dir("zcore" , NULL);
-	zcore_reipl_file = debugfs_create_file("reipl", S_IRUSR, zcore_dir,
-						NULL, &zcore_reipl_fops);
-	zcore_hsa_file = debugfs_create_file("hsa", S_IRUSR|S_IWUSR, zcore_dir,
-					     NULL, &zcore_hsa_fops);
+	debugfs_create_file("reipl", S_IRUSR, zcore_dir, NULL, &zcore_reipl_fops);
+	debugfs_create_file("hsa", S_IRUSR|S_IWUSR, zcore_dir, NULL, &zcore_hsa_fops);
 
 	register_reboot_notifier(&zcore_reboot_notifier);
 	atomic_notifier_chain_register(&panic_notifier_list, &zcore_on_panic_notifier);
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index a5dba3829769..8510921dbb00 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -501,6 +501,8 @@ u8 *ccw_device_get_util_str(struct ccw_device *cdev, int chp_idx)
 	chp_id_init(&chpid);
 	chpid.id = sch->schib.pmcw.chpid[chp_idx];
 	chp = chpid_to_chp(chpid);
+	if (!chp)
+		return NULL;
 
 	util_str = kmalloc(sizeof(chp->desc_fmt3.util_str), GFP_KERNEL);
 	if (!util_str)
diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index 296d73d84326..95ce02ec1a1a 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -15,7 +15,8 @@ int qeth_l2_create_device_attributes(struct device *);
 void qeth_l2_remove_device_attributes(struct device *);
 int qeth_bridgeport_query_ports(struct qeth_card *card,
 				enum qeth_sbp_roles *role,
-				enum qeth_sbp_states *state);
+				enum qeth_sbp_states *state,
+				bool *os_mismatch);
 int qeth_bridgeport_setrole(struct qeth_card *card, enum qeth_sbp_roles role);
 int qeth_bridgeport_an_set(struct qeth_card *card, int enable);
 
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 1797addf69b6..49740de35a89 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -971,7 +971,7 @@ static void qeth_l2_setup_bridgeport_attrs(struct qeth_card *card)
 		qeth_bridgeport_setrole(card, card->options.sbp.role);
 		/* Let the callback function refresh the stored role value. */
 		qeth_bridgeport_query_ports(card, &card->options.sbp.role,
-					    NULL);
+					    NULL, NULL);
 	}
 	if (card->options.sbp.hostnotification) {
 		if (qeth_bridgeport_an_set(card, 1))
@@ -1433,6 +1433,7 @@ struct _qeth_sbp_cbctl {
 		struct {
 			enum qeth_sbp_roles *role;
 			enum qeth_sbp_states *state;
+			bool *os_mismatch;
 		} qports;
 	} data;
 };
@@ -1609,10 +1610,19 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 	struct qeth_ipa_cmd *cmd = (struct qeth_ipa_cmd *) data;
 	struct _qeth_sbp_cbctl *cbctl = (struct _qeth_sbp_cbctl *)reply->param;
 	struct qeth_sbp_port_data *qports;
+	u16 sbp_rc;
 	int rc;
 
 	QETH_CARD_TEXT(card, 2, "brqprtcb");
-	rc = qeth_bridgeport_makerc(card, cmd);
+	sbp_rc = cmd->data.sbp.hdr.return_code;
+
+	/* on OS family mismatch, query still returns valid port data;
+	 * treat as success
+	 */
+	if (sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH && !cmd->hdr.return_code)
+		rc = 0;
+	else
+		rc = qeth_bridgeport_makerc(card, cmd);
 	if (rc)
 		return rc;
 
@@ -1628,6 +1638,9 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
 		if (cbctl->data.qports.state)
 			*cbctl->data.qports.state = qports->entry[0].state;
 	}
+	if (cbctl->data.qports.os_mismatch)
+		*cbctl->data.qports.os_mismatch =
+			(sbp_rc == IPA_RC_SBP_IQD_OS_MISMATCH);
 	return 0;
 }
 
@@ -1636,13 +1649,17 @@ static int qeth_bridgeport_query_ports_cb(struct qeth_card *card,
  * @card:			   qeth_card structure pointer.
  * @role:   Role of the port: 0-none, 1-primary, 2-secondary.
  * @state:  State of the port: 0-inactive, 1-standby, 2-active.
+ * @os_mismatch: if non-NULL, set to true when firmware reports
+ *		 OS family mismatch.
  *
  * Returns negative errno-compatible error indication or 0 on success.
  *
- * 'role' and 'state' are not updated in case of hardware operation failure.
+ * 'role', 'state' and 'os_mismatch' are not updated in case of
+ * hardware operation failure.
  */
 int qeth_bridgeport_query_ports(struct qeth_card *card,
-	enum qeth_sbp_roles *role, enum qeth_sbp_states *state)
+	enum qeth_sbp_roles *role, enum qeth_sbp_states *state,
+	bool *os_mismatch)
 {
 	struct qeth_cmd_buffer *iob;
 	struct _qeth_sbp_cbctl cbctl = {
@@ -1650,6 +1667,7 @@ int qeth_bridgeport_query_ports(struct qeth_card *card,
 			.qports = {
 				.role = role,
 				.state = state,
+				.os_mismatch = os_mismatch,
 			},
 		},
 	};
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 4ba3bc57263f..e46e2a095463 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -15,6 +15,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
 	enum qeth_sbp_states state = QETH_SBP_STATE_INACTIVE;
+	bool os_mismatch = false;
 	int rc = 0;
 	char *word;
 
@@ -25,7 +26,7 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 	if (qeth_card_hw_is_reachable(card) &&
 					card->options.sbp.supported_funcs)
 		rc = qeth_bridgeport_query_ports(card,
-			&card->options.sbp.role, &state);
+			&card->options.sbp.role, &state, &os_mismatch);
 	if (!rc) {
 		if (show_state)
 			switch (state) {
@@ -52,6 +53,10 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 		if (rc)
 			QETH_CARD_TEXT_(card, 2, "SBP%02x:%02x",
 				card->options.sbp.role, state);
+		else if (!show_state &&
+			 card->options.sbp.role == QETH_SBP_ROLE_NONE &&
+			 os_mismatch)
+			rc = sysfs_emit(buf, "%s (OS family mismatch)\n", word);
 		else
 			rc = sprintf(buf, "%s\n", word);
 	}
diff --git a/drivers/scsi/bfa/bfa_fcs_lport.c b/drivers/scsi/bfa/bfa_fcs_lport.c
index 3486e402bfc1..c61008224745 100644
--- a/drivers/scsi/bfa/bfa_fcs_lport.c
+++ b/drivers/scsi/bfa/bfa_fcs_lport.c
@@ -2665,7 +2665,7 @@ bfa_fcs_fdmi_get_hbaattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 
 }
 
-static void
+static noinline_for_stack void
 bfa_fcs_fdmi_get_portattr(struct bfa_fcs_lport_fdmi_s *fdmi,
 			  struct bfa_fcs_fdmi_port_attr_s *port_attr)
 {
diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index 0aa883ab6ff0..3592973407c0 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -491,6 +491,9 @@ static int iscsi_tcp_data_in(struct iscsi_conn *conn, struct iscsi_task *task)
 	int datasn = be32_to_cpu(rhdr->datasn);
 	unsigned total_in_length = task->sc->sdb.length;
 
+	if (task->sc->sc_data_direction != DMA_FROM_DEVICE)
+		return ISCSI_ERR_PROTO;
+
 	/*
 	 * lib iscsi will update this in the completion handling if there
 	 * is status.
diff --git a/drivers/scsi/pm8001/pm8001_ctl.c b/drivers/scsi/pm8001/pm8001_ctl.c
index 467f77664efb..8101d9463ca5 100644
--- a/drivers/scsi/pm8001/pm8001_ctl.c
+++ b/drivers/scsi/pm8001/pm8001_ctl.c
@@ -822,6 +822,14 @@ static ssize_t pm8001_store_update_fw(struct device *cdev,
 		goto out;
 	}
 
+	if (pm8001_ha->controller_fatal_error) {
+		pm8001_dbg(pm8001_ha, FAIL,
+			   "controller in fatal error state, firmware update rejected\n");
+		pm8001_ha->fw_status = FAIL_PARAMETERS;
+		ret = -EINVAL;
+		goto out;
+	}
+
 	for (i = 0; flash_command_table[i].code != FLASH_CMD_NONE; i++) {
 		if (!memcmp(flash_command_table[i].command,
 				 cmd_ptr, strlen(cmd_ptr))) {
diff --git a/drivers/scsi/pm8001/pm80xx_hwi.c b/drivers/scsi/pm8001/pm80xx_hwi.c
index 89051722e04d..64db45d24d80 100644
--- a/drivers/scsi/pm8001/pm80xx_hwi.c
+++ b/drivers/scsi/pm8001/pm80xx_hwi.c
@@ -400,6 +400,13 @@ ssize_t pm80xx_get_non_fatal_dump(struct device *cdev,
 	char *buf_copy = buf;
 
 	temp = (u32 *)pm8001_ha->memoryMap.region[FORENSIC_MEM].virt_ptr;
+
+	if (pm8001_ha->controller_fatal_error) {
+		pm8001_dbg(pm8001_ha, FAIL,
+			   "non-fatal dump not available in fatal error state\n");
+		return -EINVAL;
+	}
+
 	if (++pm8001_ha->non_fatal_count == 1) {
 		if (pm8001_ha->chip_id == chip_8001) {
 			snprintf(pm8001_ha->forensic_info.data_buf.direct_data,
diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 0e0a19030c35..bd770e49f314 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -1697,6 +1697,10 @@ int sdw_handle_slave_status(struct sdw_bus *bus,
 			break;
 
 		case SDW_SLAVE_ALERT:
+			if (slave->status != SDW_SLAVE_ATTACHED &&
+			    slave->status != SDW_SLAVE_ALERT)
+				continue;
+
 			ret = sdw_handle_slave_alerts(slave);
 			if (ret)
 				dev_err(bus->dev,
diff --git a/drivers/soundwire/cadence_master.c b/drivers/soundwire/cadence_master.c
index d3e9cd3faadf..034589453597 100644
--- a/drivers/soundwire/cadence_master.c
+++ b/drivers/soundwire/cadence_master.c
@@ -1416,6 +1416,13 @@ int sdw_cdns_clock_stop(struct sdw_cdns *cdns, bool block_wake)
 		return 0;
 	}
 
+	/*
+	 * wait for any in-flight peripheral event handling to complete before stopping the clock.
+	 * No need to disable peripheral interrupts before canceling the work, as the peripheral
+	 * interrupts are already masked before the work is scheduled.
+	 */
+	cancel_work_sync(&cdns->work);
+
 	/*
 	 * Before entering clock stop we mask the Slave
 	 * interrupts. This helps avoid having to deal with e.g. a
diff --git a/drivers/soundwire/slave.c b/drivers/soundwire/slave.c
index a08f4081c1c4..30cca4730fc2 100644
--- a/drivers/soundwire/slave.c
+++ b/drivers/soundwire/slave.c
@@ -209,8 +209,8 @@ int sdw_of_find_slaves(struct sdw_bus *bus)
 		struct sdw_slave_id id;
 		const __be32 *addr;
 
-		compat = of_get_property(node, "compatible", NULL);
-		if (!compat)
+		ret = of_property_read_string(node, "compatible", &compat);
+		if (ret)
 			continue;
 
 		ret = sscanf(compat, "sdw%01x%04hx%04hx%02hhx", &sdw_version,
diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
index bbc918815634..5c470daf9367 100644
--- a/drivers/spi/spi-zynqmp-gqspi.c
+++ b/drivers/spi/spi-zynqmp-gqspi.c
@@ -1094,7 +1094,7 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 
-	ctlr = spi_alloc_master(&pdev->dev, sizeof(*xqspi));
+	ctlr = devm_spi_alloc_master(&pdev->dev, sizeof(*xqspi));
 	if (!ctlr)
 		return -ENOMEM;
 
@@ -1104,29 +1104,25 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, xqspi);
 
 	xqspi->regs = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(xqspi->regs)) {
-		ret = PTR_ERR(xqspi->regs);
-		goto remove_master;
-	}
+	if (IS_ERR(xqspi->regs))
+		return PTR_ERR(xqspi->regs);
 
 	xqspi->pclk = devm_clk_get(&pdev->dev, "pclk");
 	if (IS_ERR(xqspi->pclk)) {
 		dev_err(dev, "pclk clock not found.\n");
-		ret = PTR_ERR(xqspi->pclk);
-		goto remove_master;
+		return PTR_ERR(xqspi->pclk);
 	}
 
 	xqspi->refclk = devm_clk_get(&pdev->dev, "ref_clk");
 	if (IS_ERR(xqspi->refclk)) {
 		dev_err(dev, "ref_clk clock not found.\n");
-		ret = PTR_ERR(xqspi->refclk);
-		goto remove_master;
+		return PTR_ERR(xqspi->refclk);
 	}
 
 	ret = clk_prepare_enable(xqspi->pclk);
 	if (ret) {
 		dev_err(dev, "Unable to enable APB clock.\n");
-		goto remove_master;
+		return ret;
 	}
 
 	ret = clk_prepare_enable(xqspi->refclk);
@@ -1189,8 +1185,6 @@ static int zynqmp_qspi_probe(struct platform_device *pdev)
 	clk_disable_unprepare(xqspi->refclk);
 clk_dis_pclk:
 	clk_disable_unprepare(xqspi->pclk);
-remove_master:
-	spi_controller_put(ctlr);
 
 	return ret;
 }
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index 723ca72d1bd3..1bfad2a6852e 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -303,6 +303,7 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 {
 	struct fbtft_par *par = info->par;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	unsigned long flags;
 
 	/* special case, needed ? */
 	if (y == -1) {
@@ -311,12 +312,12 @@ static void fbtft_mkdirty(struct fb_info *info, int y, int height)
 	}
 
 	/* Mark display lines/area as dirty */
-	spin_lock(&par->dirty_lock);
+	spin_lock_irqsave(&par->dirty_lock, flags);
 	if (y < par->dirty_lines_start)
 		par->dirty_lines_start = y;
 	if (y + height - 1 > par->dirty_lines_end)
 		par->dirty_lines_end = y + height - 1;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irqrestore(&par->dirty_lock, flags);
 
 	/* Schedule deferred_io to update display (no-op if already on queue)*/
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
@@ -331,13 +332,13 @@ static void fbtft_deferred_io(struct fb_info *info, struct list_head *pagelist)
 	unsigned int y_low = 0, y_high = 0;
 	int count = 0;
 
-	spin_lock(&par->dirty_lock);
+	spin_lock_irq(&par->dirty_lock);
 	dirty_lines_start = par->dirty_lines_start;
 	dirty_lines_end = par->dirty_lines_end;
 	/* set display line markers as clean */
 	par->dirty_lines_start = par->info->var.yres - 1;
 	par->dirty_lines_end = 0;
-	spin_unlock(&par->dirty_lock);
+	spin_unlock_irq(&par->dirty_lock);
 
 	/* Mark display lines as dirty */
 	list_for_each_entry(page, pagelist, lru) {
diff --git a/drivers/target/iscsi/cxgbit/cxgbit.h b/drivers/target/iscsi/cxgbit/cxgbit.h
index 406903398dfd..b23edcb41489 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit.h
+++ b/drivers/target/iscsi/cxgbit/cxgbit.h
@@ -327,9 +327,9 @@ int cxgbit_l2t_send(struct cxgbit_device *, struct sk_buff *,
 		    struct l2t_entry *);
 void cxgbit_push_tx_frames(struct cxgbit_sock *);
 int cxgbit_put_login_tx(struct iscsi_conn *, struct iscsi_login *, u32);
-int cxgbit_xmit_pdu(struct iscsi_conn *, struct iscsi_cmd *,
+int cxgbit_xmit_pdu(struct iscsi_conn *, struct iscsit_cmd *,
 		    struct iscsi_datain_req *, const void *, u32);
-void cxgbit_get_r2t_ttt(struct iscsi_conn *, struct iscsi_cmd *,
+void cxgbit_get_r2t_ttt(struct iscsi_conn *, struct iscsit_cmd *,
 			struct iscsi_r2t *);
 u32 cxgbit_send_tx_flowc_wr(struct cxgbit_sock *);
 int cxgbit_ofld_send(struct cxgbit_device *, struct sk_buff *);
@@ -340,8 +340,8 @@ struct cxgbit_device *cxgbit_find_device(struct net_device *, u8 *);
 /* DDP */
 int cxgbit_ddp_init(struct cxgbit_device *);
 int cxgbit_setup_conn_pgidx(struct cxgbit_sock *, u32);
-int cxgbit_reserve_ttt(struct cxgbit_sock *, struct iscsi_cmd *);
-void cxgbit_unmap_cmd(struct iscsi_conn *, struct iscsi_cmd *);
+int cxgbit_reserve_ttt(struct cxgbit_sock *, struct iscsit_cmd *);
+void cxgbit_unmap_cmd(struct iscsi_conn *, struct iscsit_cmd *);
 
 static inline
 struct cxgbi_ppm *cdev2ppm(struct cxgbit_device *cdev)
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
index b044999ad002..99fe09f5af04 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_ddp.c
@@ -227,7 +227,7 @@ cxgbit_ddp_reserve(struct cxgbit_sock *csk, struct cxgbi_task_tag_info *ttinfo,
 }
 
 void
-cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_r2t *r2t)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -260,7 +260,7 @@ cxgbit_get_r2t_ttt(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	r2t->targ_xfer_tag = ttinfo->tag;
 }
 
-void cxgbit_unmap_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+void cxgbit_unmap_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	struct cxgbit_cmd *ccmd = iscsit_priv_cmd(cmd);
 
diff --git a/drivers/target/iscsi/cxgbit/cxgbit_target.c b/drivers/target/iscsi/cxgbit/cxgbit_target.c
index 282297ffc404..2b6973fefe41 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_target.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_target.c
@@ -337,7 +337,7 @@ static int cxgbit_queue_skb(struct cxgbit_sock *csk, struct sk_buff *skb)
 }
 
 static int
-cxgbit_map_skb(struct iscsi_cmd *cmd, struct sk_buff *skb, u32 data_offset,
+cxgbit_map_skb(struct iscsit_cmd *cmd, struct sk_buff *skb, u32 data_offset,
 	       u32 data_length)
 {
 	u32 i = 0, nr_frags = MAX_SKB_FRAGS;
@@ -390,7 +390,7 @@ cxgbit_map_skb(struct iscsi_cmd *cmd, struct sk_buff *skb, u32 data_offset,
 }
 
 static int
-cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
+cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 		     struct iscsi_datain_req *dr)
 {
 	struct iscsi_conn *conn = csk->conn;
@@ -481,7 +481,7 @@ cxgbit_tx_datain_iso(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
+cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsit_cmd *cmd,
 		 const struct iscsi_datain *datain)
 {
 	struct sk_buff *skb;
@@ -510,7 +510,7 @@ cxgbit_tx_datain(struct cxgbit_sock *csk, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       struct iscsi_datain_req *dr,
 		       const struct iscsi_datain *datain)
 {
@@ -530,7 +530,7 @@ cxgbit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 static int
-cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct cxgbit_sock *csk = conn->context;
@@ -560,7 +560,7 @@ cxgbit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 int
-cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+cxgbit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		struct iscsi_datain_req *dr, const void *buf, u32 buf_len)
 {
 	if (dr)
@@ -832,16 +832,16 @@ cxgbit_skb_copy_to_sg(struct sk_buff *skb, struct scatterlist *sg,
 	}
 }
 
-static struct iscsi_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
+static struct iscsit_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbi_ppm *ppm = cdev2ppm(csk->com.cdev);
 	struct cxgbit_cmd *ccmd;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd) {
-		pr_err("Unable to allocate iscsi_cmd + cxgbit_cmd\n");
+		pr_err("Unable to allocate iscsit_cmd + cxgbit_cmd\n");
 		return NULL;
 	}
 
@@ -853,7 +853,7 @@ static struct iscsi_cmd *cxgbit_allocate_cmd(struct cxgbit_sock *csk)
 }
 
 static int
-cxgbit_handle_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+cxgbit_handle_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			     u32 length)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -910,7 +910,7 @@ cxgbit_handle_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-cxgbit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+cxgbit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			  bool dump_payload)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -964,7 +964,7 @@ cxgbit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+cxgbit_handle_scsi_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -996,7 +996,7 @@ static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 {
 	struct scatterlist *sg_start;
 	struct iscsi_conn *conn = csk->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct cxgbit_cmd *ccmd;
 	struct cxgbi_task_tag_info *ttinfo;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1084,7 +1084,7 @@ static int cxgbit_handle_iscsi_dataout(struct cxgbit_sock *csk)
 	return 0;
 }
 
-static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1134,7 +1134,7 @@ static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
 
 		ping_data[payload_length] = '\0';
 		/*
-		 * Attach ping data to struct iscsi_cmd->buf_ptr.
+		 * Attach ping data to struct iscsit_cmd->buf_ptr.
 		 */
 		cmd->buf_ptr = ping_data;
 		cmd->buf_ptr_size = payload_length;
@@ -1152,7 +1152,7 @@ static int cxgbit_handle_nop_out(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
 }
 
 static int
-cxgbit_handle_text_cmd(struct cxgbit_sock *csk, struct iscsi_cmd *cmd)
+cxgbit_handle_text_cmd(struct cxgbit_sock *csk, struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = csk->conn;
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
@@ -1210,7 +1210,7 @@ static int cxgbit_target_rx_opcode(struct cxgbit_sock *csk)
 	struct cxgbit_lro_pdu_cb *pdu_cb = cxgbit_rx_pdu_cb(csk->skb);
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)pdu_cb->hdr;
 	struct iscsi_conn *conn = csk->conn;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	u8 opcode = (hdr->opcode & ISCSI_OPCODE_MASK);
 	int ret = -EINVAL;
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 17835c878cae..69aacabff38a 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -26,6 +26,7 @@
 #include <target/target_core_base.h>
 #include <target/target_core_fabric.h>
 
+#include <target/target_core_backend.h>
 #include <target/iscsi/iscsi_target_core.h>
 #include "iscsi_target_parameters.h"
 #include "iscsi_target_seq_pdu_list.h"
@@ -59,7 +60,7 @@ struct kmem_cache *lio_dr_cache;
 struct kmem_cache *lio_ooo_cache;
 struct kmem_cache *lio_r2t_cache;
 
-static int iscsit_handle_immediate_data(struct iscsi_cmd *,
+static int iscsit_handle_immediate_data(struct iscsit_cmd *,
 			struct iscsi_scsi_req *, u32);
 
 struct iscsi_tiqn *iscsit_get_tiqn_for_login(unsigned char *buf)
@@ -474,13 +475,13 @@ int iscsit_del_np(struct iscsi_np *np)
 
 static void iscsit_get_rx_pdu(struct iscsi_conn *);
 
-int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+int iscsit_queue_rsp(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	return iscsit_add_cmd_to_response_queue(cmd, cmd->conn, cmd->i_state);
 }
 EXPORT_SYMBOL(iscsit_queue_rsp);
 
-void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsi_cmd *cmd)
+void iscsit_aborted_task(struct iscsi_conn *conn, struct iscsit_cmd *cmd)
 {
 	spin_lock_bh(&conn->cmd_lock);
 	if (!list_empty(&cmd->i_conn_node))
@@ -496,7 +497,7 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *, const void *,
 static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *);
 
 static int
-iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  const void *data_buf, u32 data_buf_len)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)cmd->pdu;
@@ -564,13 +565,13 @@ iscsit_xmit_nondatain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return 0;
 }
 
-static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
+static int iscsit_map_iovec(struct iscsit_cmd *cmd, struct kvec *iov, int nvec,
 			    u32 data_offset, u32 data_length);
-static void iscsit_unmap_iovec(struct iscsi_cmd *);
-static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsi_cmd *,
+static void iscsit_unmap_iovec(struct iscsit_cmd *);
+static u32 iscsit_do_crypto_hash_sg(struct ahash_request *, struct iscsit_cmd *,
 				    u32, u32, u32, u8 *);
 static int
-iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       const struct iscsi_datain *datain)
 {
 	struct kvec *iov;
@@ -644,7 +645,7 @@ iscsit_xmit_datain_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return 0;
 }
 
-static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+static int iscsit_xmit_pdu(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_datain_req *dr, const void *buf,
 			   u32 buf_len)
 {
@@ -791,7 +792,7 @@ int iscsit_add_reject(
 	u8 reason,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_INTERRUPTIBLE);
 	if (!cmd)
@@ -819,7 +820,7 @@ int iscsit_add_reject(
 EXPORT_SYMBOL(iscsit_add_reject);
 
 static int iscsit_add_reject_from_cmd(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 reason,
 	bool add_to_conn,
 	unsigned char *buf)
@@ -863,13 +864,13 @@ static int iscsit_add_reject_from_cmd(
 	return -1;
 }
 
-static int iscsit_add_reject_cmd(struct iscsi_cmd *cmd, u8 reason,
+static int iscsit_add_reject_cmd(struct iscsit_cmd *cmd, u8 reason,
 				 unsigned char *buf)
 {
 	return iscsit_add_reject_from_cmd(cmd, reason, true, buf);
 }
 
-int iscsit_reject_cmd(struct iscsi_cmd *cmd, u8 reason, unsigned char *buf)
+int iscsit_reject_cmd(struct iscsit_cmd *cmd, u8 reason, unsigned char *buf)
 {
 	return iscsit_add_reject_from_cmd(cmd, reason, false, buf);
 }
@@ -879,7 +880,7 @@ EXPORT_SYMBOL(iscsit_reject_cmd);
  * Map some portion of the allocated scatterlist to an iovec, suitable for
  * kernel sockets to copy data in/out.
  */
-static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
+static int iscsit_map_iovec(struct iscsit_cmd *cmd, struct kvec *iov, int nvec,
 			    u32 data_offset, u32 data_length)
 {
 	u32 i = 0, orig_data_length = data_length;
@@ -937,7 +938,7 @@ static int iscsit_map_iovec(struct iscsi_cmd *cmd, struct kvec *iov, int nvec,
 	return -1;
 }
 
-static void iscsit_unmap_iovec(struct iscsi_cmd *cmd)
+static void iscsit_unmap_iovec(struct iscsit_cmd *cmd)
 {
 	u32 i;
 	struct scatterlist *sg;
@@ -951,7 +952,7 @@ static void iscsit_unmap_iovec(struct iscsi_cmd *cmd)
 static void iscsit_ack_from_expstatsn(struct iscsi_conn *conn, u32 exp_statsn)
 {
 	LIST_HEAD(ack_list);
-	struct iscsi_cmd *cmd, *cmd_p;
+	struct iscsit_cmd *cmd, *cmd_p;
 
 	conn->exp_statsn = exp_statsn;
 
@@ -978,7 +979,7 @@ static void iscsit_ack_from_expstatsn(struct iscsi_conn *conn, u32 exp_statsn)
 	}
 }
 
-static int iscsit_allocate_iovecs(struct iscsi_cmd *cmd)
+static int iscsit_allocate_iovecs(struct iscsit_cmd *cmd)
 {
 	u32 iov_count = max(1UL, DIV_ROUND_UP(cmd->se_cmd.data_length, PAGE_SIZE));
 
@@ -991,7 +992,7 @@ static int iscsit_allocate_iovecs(struct iscsi_cmd *cmd)
 	return 0;
 }
 
-int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			  unsigned char *buf)
 {
 	int data_direction, payload_length;
@@ -1204,7 +1205,7 @@ int iscsit_setup_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_setup_scsi_cmd);
 
-void iscsit_set_unsolicited_dataout(struct iscsi_cmd *cmd)
+void iscsit_set_unsolicited_dataout(struct iscsit_cmd *cmd)
 {
 	iscsit_set_dataout_sequence_values(cmd);
 
@@ -1214,7 +1215,7 @@ void iscsit_set_unsolicited_dataout(struct iscsi_cmd *cmd)
 }
 EXPORT_SYMBOL(iscsit_set_unsolicited_dataout);
 
-int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			    struct iscsi_scsi_req *hdr)
 {
 	int cmdsn_ret = 0;
@@ -1274,7 +1275,7 @@ int iscsit_process_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_process_scsi_cmd);
 
 static int
-iscsit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
+iscsit_get_immediate_data(struct iscsit_cmd *cmd, struct iscsi_scsi_req *hdr,
 			  bool dump_payload)
 {
 	int cmdsn_ret = 0, immed_ret = IMMEDIATE_DATA_NORMAL_OPERATION;
@@ -1338,7 +1339,7 @@ iscsit_get_immediate_data(struct iscsi_cmd *cmd, struct iscsi_scsi_req *hdr,
 }
 
 static int
-iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct iscsi_scsi_req *hdr = (struct iscsi_scsi_req *)buf;
@@ -1372,7 +1373,7 @@ iscsit_handle_scsi_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 static u32 iscsit_do_crypto_hash_sg(
 	struct ahash_request *hash,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 data_offset,
 	u32 data_length,
 	u32 padding,
@@ -1445,7 +1446,7 @@ static void iscsit_do_crypto_hash_buf(struct ahash_request *hash,
 
 int
 __iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			   struct iscsi_cmd *cmd, u32 payload_length,
+			   struct iscsit_cmd *cmd, u32 payload_length,
 			   bool *success)
 {
 	struct iscsi_data *hdr = buf;
@@ -1527,8 +1528,10 @@ __iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
 		 */
 		if (se_cmd->transport_state & CMD_T_ABORTED) {
 			if (hdr->flags & ISCSI_FLAG_CMD_FINAL &&
-			    --cmd->outstanding_r2ts < 1)
+			    --cmd->outstanding_r2ts < 1) {
 				iscsit_stop_dataout_timer(cmd);
+				target_complete_cmd(se_cmd, SAM_STAT_TASK_ABORTED);
+			}
 
 			return iscsit_dump_data_payload(conn, payload_length, 1);
 		}
@@ -1549,10 +1552,10 @@ EXPORT_SYMBOL(__iscsit_check_dataout_hdr);
 
 int
 iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			 struct iscsi_cmd **out_cmd)
+			 struct iscsit_cmd **out_cmd)
 {
 	struct iscsi_data *hdr = buf;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u32 payload_length = ntoh24(hdr->dlength);
 	int rc;
 	bool success = false;
@@ -1583,7 +1586,7 @@ iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
 EXPORT_SYMBOL(iscsit_check_dataout_hdr);
 
 static int
-iscsit_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_get_dataout(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		   struct iscsi_data *hdr)
 {
 	struct kvec *iov;
@@ -1651,7 +1654,7 @@ iscsit_get_dataout(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 
 int
-iscsit_check_dataout_payload(struct iscsi_cmd *cmd, struct iscsi_data *hdr,
+iscsit_check_dataout_payload(struct iscsit_cmd *cmd, struct iscsi_data *hdr,
 			     bool data_crc_failed)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -1691,7 +1694,7 @@ EXPORT_SYMBOL(iscsit_check_dataout_payload);
 
 static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_data *hdr = (struct iscsi_data *)buf;
 	int rc;
 	bool data_crc_failed = false;
@@ -1711,7 +1714,7 @@ static int iscsit_handle_data_out(struct iscsi_conn *conn, unsigned char *buf)
 	return iscsit_check_dataout_payload(cmd, hdr, data_crc_failed);
 }
 
-int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			 struct iscsi_nopout *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -1759,7 +1762,7 @@ int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	 * This is not a response to a Unsolicited NopIN, which means
 	 * it can either be a NOPOUT ping request (with a valid ITT),
 	 * or a NOPOUT not requesting a NOPIN (with a reserved ITT).
-	 * Either way, make sure we allocate an struct iscsi_cmd, as both
+	 * Either way, make sure we allocate an struct iscsit_cmd, as both
 	 * can contain ping data.
 	 */
 	if (hdr->ttt == cpu_to_be32(0xFFFFFFFF)) {
@@ -1778,10 +1781,10 @@ int iscsit_setup_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_setup_nop_out);
 
-int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   struct iscsi_nopout *hdr)
 {
-	struct iscsi_cmd *cmd_p = NULL;
+	struct iscsit_cmd *cmd_p = NULL;
 	int cmdsn_ret = 0;
 	/*
 	 * Initiator is expecting a NopIN ping reply..
@@ -1840,7 +1843,7 @@ int iscsit_process_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_process_nop_out);
 
-static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 				 unsigned char *buf)
 {
 	unsigned char *ping_data = NULL;
@@ -1925,7 +1928,7 @@ static int iscsit_handle_nop_out(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 
 		ping_data[payload_length] = '\0';
 		/*
-		 * Attach ping data to struct iscsi_cmd->buf_ptr.
+		 * Attach ping data to struct iscsit_cmd->buf_ptr.
 		 */
 		cmd->buf_ptr = ping_data;
 		cmd->buf_ptr_size = payload_length;
@@ -1967,7 +1970,7 @@ static enum tcm_tmreq_table iscsit_convert_tmf(u8 iscsi_tmf)
 }
 
 int
-iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_task_mgt_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			   unsigned char *buf)
 {
 	struct se_tmr_req *se_tmr;
@@ -2148,7 +2151,7 @@ EXPORT_SYMBOL(iscsit_handle_task_mgt_cmd);
 
 /* #warning FIXME: Support Text Command parameters besides SendTargets */
 int
-iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		      struct iscsi_text *hdr)
 {
 	u32 payload_length = ntoh24(hdr->dlength);
@@ -2188,7 +2191,7 @@ iscsit_setup_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_setup_text_cmd);
 
 int
-iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			struct iscsi_text *hdr)
 {
 	unsigned char *text_in = cmd->text_in_ptr, *text_ptr;
@@ -2247,7 +2250,7 @@ iscsit_process_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 EXPORT_SYMBOL(iscsit_process_text_cmd);
 
 static int
-iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 		       unsigned char *buf)
 {
 	struct iscsi_text *hdr = (struct iscsi_text *)buf;
@@ -2338,7 +2341,7 @@ iscsit_handle_text_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 	return iscsit_reject_cmd(cmd, ISCSI_REASON_PROTOCOL_ERROR, buf);
 }
 
-int iscsit_logout_closesession(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closesession(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_conn *conn_p;
 	struct iscsi_session *sess = conn->sess;
@@ -2368,7 +2371,7 @@ int iscsit_logout_closesession(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 	return 0;
 }
 
-int iscsit_logout_closeconnection(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_closeconnection(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_conn *l_conn;
 	struct iscsi_session *sess = conn->sess;
@@ -2416,7 +2419,7 @@ int iscsit_logout_closeconnection(struct iscsi_cmd *cmd, struct iscsi_conn *conn
 	return 0;
 }
 
-int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
 
@@ -2446,7 +2449,7 @@ int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *cmd, struct iscsi_conn
 }
 
 int
-iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+iscsit_handle_logout_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf)
 {
 	int cmdsn_ret, logout_remove = 0;
@@ -2592,7 +2595,7 @@ static void iscsit_rx_thread_wait_for_tcp(struct iscsi_conn *conn)
 }
 
 static int iscsit_handle_immediate_data(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_scsi_req *hdr,
 	u32 length)
 {
@@ -2701,7 +2704,7 @@ static int iscsit_handle_immediate_data(
 	with active network interface */
 static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct iscsi_conn *conn_p;
 	bool found = false;
 
@@ -2741,7 +2744,7 @@ static void iscsit_build_conn_drop_async_message(struct iscsi_conn *conn)
 }
 
 static int iscsit_send_conn_drop_async_message(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_async *hdr;
@@ -2781,7 +2784,7 @@ static void iscsit_tx_thread_wait_for_tcp(struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_datain_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_datain_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			struct iscsi_datain *datain, struct iscsi_data_rsp *hdr,
 			bool set_statsn)
 {
@@ -2826,7 +2829,7 @@ iscsit_build_datain_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_datain_pdu);
 
-static int iscsit_send_datain(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_datain(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_data_rsp *hdr = (struct iscsi_data_rsp *)&cmd->pdu[0];
 	struct iscsi_datain datain;
@@ -2887,7 +2890,7 @@ static int iscsit_send_datain(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 int
-iscsit_build_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_logout_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			struct iscsi_logout_rsp *hdr)
 {
 	struct iscsi_conn *logout_conn = NULL;
@@ -2982,7 +2985,7 @@ iscsit_build_logout_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_logout_rsp);
 
 static int
-iscsit_send_logout(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_logout(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	int rc;
 
@@ -2995,7 +2998,7 @@ iscsit_send_logout(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 void
-iscsit_build_nopin_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_nopin_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		       struct iscsi_nopin *hdr, bool nopout_response)
 {
 	hdr->opcode		= ISCSI_OP_NOOP_IN;
@@ -3026,7 +3029,7 @@ EXPORT_SYMBOL(iscsit_build_nopin_rsp);
  *	Unsolicited NOPIN, either requesting a response or not.
  */
 static int iscsit_send_unsolicited_nopin(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	int want_response)
 {
@@ -3051,15 +3054,15 @@ static int iscsit_send_unsolicited_nopin(
 }
 
 static int
-iscsit_send_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_nopin(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_nopin *hdr = (struct iscsi_nopin *)&cmd->pdu[0];
 
 	iscsit_build_nopin_rsp(cmd, conn, hdr, true);
 
 	/*
-	 * NOPOUT Ping Data is attached to struct iscsi_cmd->buf_ptr.
-	 * NOPOUT DataSegmentLength is at struct iscsi_cmd->buf_ptr_size.
+	 * NOPOUT Ping Data is attached to struct iscsit_cmd->buf_ptr.
+	 * NOPOUT DataSegmentLength is at struct iscsit_cmd->buf_ptr_size.
 	 */
 	pr_debug("Echoing back %u bytes of ping data.\n", cmd->buf_ptr_size);
 
@@ -3069,7 +3072,7 @@ iscsit_send_nopin(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 }
 
 static int iscsit_send_r2t(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_r2t *r2t;
@@ -3127,7 +3130,7 @@ static int iscsit_send_r2t(
  */
 int iscsit_build_r2ts_for_cmd(
 	struct iscsi_conn *conn,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	bool recovery)
 {
 	int first_r2t = 1;
@@ -3209,7 +3212,7 @@ int iscsit_build_r2ts_for_cmd(
 }
 EXPORT_SYMBOL(iscsit_build_r2ts_for_cmd);
 
-void iscsit_build_rsp_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+void iscsit_build_rsp_pdu(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			bool inc_stat_sn, struct iscsi_scsi_rsp *hdr)
 {
 	if (inc_stat_sn)
@@ -3243,7 +3246,7 @@ void iscsit_build_rsp_pdu(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 }
 EXPORT_SYMBOL(iscsit_build_rsp_pdu);
 
-static int iscsit_send_response(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+static int iscsit_send_response(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_scsi_rsp *hdr = (struct iscsi_scsi_rsp *)&cmd->pdu[0];
 	bool inc_stat_sn = (cmd->i_state == ISTATE_SEND_STATUS);
@@ -3300,7 +3303,7 @@ static u8 iscsit_convert_tcm_tmr_rsp(struct se_tmr_req *se_tmr)
 }
 
 void
-iscsit_build_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 			  struct iscsi_tm_rsp *hdr)
 {
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -3323,7 +3326,7 @@ iscsit_build_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_task_mgt_rsp);
 
 static int
-iscsit_send_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+iscsit_send_task_mgt_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_tm_rsp *hdr = (struct iscsi_tm_rsp *)&cmd->pdu[0];
 
@@ -3335,7 +3338,7 @@ iscsit_send_task_mgt_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
 #define SENDTARGETS_BUF_LIMIT 32768U
 
 static int
-iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
+iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 				  enum iscsit_transport_type network_transport,
 				  int skip_bytes, bool *completed)
 {
@@ -3485,7 +3488,7 @@ iscsit_build_sendtargets_response(struct iscsi_cmd *cmd,
 }
 
 int
-iscsit_build_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_text_rsp(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		      struct iscsi_text_rsp *hdr,
 		      enum iscsit_transport_type network_transport)
 {
@@ -3535,7 +3538,7 @@ iscsit_build_text_rsp(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_text_rsp);
 
 static int iscsit_send_text_rsp(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_text_rsp *hdr = (struct iscsi_text_rsp *)cmd->pdu;
@@ -3552,7 +3555,7 @@ static int iscsit_send_text_rsp(
 }
 
 void
-iscsit_build_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
+iscsit_build_reject(struct iscsit_cmd *cmd, struct iscsi_conn *conn,
 		    struct iscsi_reject *hdr)
 {
 	hdr->opcode		= ISCSI_OP_REJECT;
@@ -3569,7 +3572,7 @@ iscsit_build_reject(struct iscsi_cmd *cmd, struct iscsi_conn *conn,
 EXPORT_SYMBOL(iscsit_build_reject);
 
 static int iscsit_send_reject(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_reject *hdr = (struct iscsi_reject *)&cmd->pdu[0];
@@ -3610,7 +3613,7 @@ void iscsit_thread_get_cpumask(struct iscsi_conn *conn)
 }
 
 int
-iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+iscsit_immediate_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3658,7 +3661,7 @@ iscsit_handle_immediate_queue(struct iscsi_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u8 state;
 	int ret;
 
@@ -3677,7 +3680,7 @@ iscsit_handle_immediate_queue(struct iscsi_conn *conn)
 }
 
 int
-iscsit_response_queue(struct iscsi_conn *conn, struct iscsi_cmd *cmd, int state)
+iscsit_response_queue(struct iscsi_conn *conn, struct iscsit_cmd *cmd, int state)
 {
 	int ret;
 
@@ -3787,7 +3790,7 @@ static int iscsit_handle_response_queue(struct iscsi_conn *conn)
 {
 	struct iscsit_transport *t = conn->conn_transport;
 	struct iscsi_queue_req *qr;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	u8 state;
 	int ret;
 
@@ -3865,7 +3868,7 @@ int iscsi_target_tx_thread(void *arg)
 static int iscsi_target_rx_opcode(struct iscsi_conn *conn, unsigned char *buf)
 {
 	struct iscsi_hdr *hdr = (struct iscsi_hdr *)buf;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	int ret = 0;
 
 	switch (hdr->opcode & ISCSI_OPCODE_MASK) {
@@ -4073,7 +4076,7 @@ int iscsi_target_rx_thread(void *arg)
 static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 {
 	LIST_HEAD(tmp_list);
-	struct iscsi_cmd *cmd = NULL, *cmd_tmp = NULL;
+	struct iscsit_cmd *cmd = NULL, *cmd_tmp = NULL;
 	struct iscsi_session *sess = conn->sess;
 	/*
 	 * We expect this function to only ever be called from either RX or TX
@@ -4102,6 +4105,16 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 		} else {
 			se_cmd->transport_state |= CMD_T_FABRIC_STOP;
 		}
+
+		if (cmd->se_cmd.t_state == TRANSPORT_WRITE_PENDING) {
+			/*
+			 * We never submitted the cmd to LIO core, so we have
+			 * to tell LIO to perform the completion process.
+			 */
+			spin_unlock_irq(&se_cmd->t_state_lock);
+			target_complete_cmd(&cmd->se_cmd, SAM_STAT_TASK_ABORTED);
+			continue;
+		}
 		spin_unlock_irq(&se_cmd->t_state_lock);
 	}
 	spin_unlock_bh(&conn->cmd_lock);
@@ -4118,7 +4131,7 @@ static void iscsit_release_commands_from_conn(struct iscsi_conn *conn)
 static void iscsit_stop_timers_for_cmds(
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -4183,7 +4196,7 @@ int iscsit_close_connection(
 	 *
 	 * During normal operation clear the out of order commands (but
 	 * do not free the struct iscsi_ooo_cmdsn's) and release all
-	 * struct iscsi_cmds.
+	 * struct iscsit_cmds.
 	 */
 	if (atomic_read(&conn->connection_recovery)) {
 		iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(conn);
@@ -4330,7 +4343,7 @@ int iscsit_close_connection(
 	     atomic_read(&sess->session_fall_back_to_erl0)) {
 		spin_unlock_bh(&sess->conn_lock);
 		complete_all(&sess->session_wait_comp);
-		iscsit_close_session(sess);
+		iscsit_close_session(sess, true);
 
 		return 0;
 	} else if (atomic_read(&sess->session_logout)) {
@@ -4340,7 +4353,7 @@ int iscsit_close_connection(
 		if (atomic_read(&sess->session_close)) {
 			spin_unlock_bh(&sess->conn_lock);
 			complete_all(&sess->session_wait_comp);
-			iscsit_close_session(sess);
+			iscsit_close_session(sess, true);
 		} else {
 			spin_unlock_bh(&sess->conn_lock);
 		}
@@ -4356,7 +4369,7 @@ int iscsit_close_connection(
 		if (atomic_read(&sess->session_close)) {
 			spin_unlock_bh(&sess->conn_lock);
 			complete_all(&sess->session_wait_comp);
-			iscsit_close_session(sess);
+			iscsit_close_session(sess, true);
 		} else {
 			spin_unlock_bh(&sess->conn_lock);
 		}
@@ -4369,7 +4382,7 @@ int iscsit_close_connection(
  * If the iSCSI Session for the iSCSI Initiator Node exists,
  * forcefully shutdown the iSCSI NEXUS.
  */
-int iscsit_close_session(struct iscsi_session *sess)
+int iscsit_close_session(struct iscsi_session *sess, bool can_sleep)
 {
 	struct iscsi_portal_group *tpg = sess->tpg;
 	struct se_portal_group *se_tpg = &tpg->tpg_se_tpg;
@@ -4405,14 +4418,10 @@ int iscsit_close_session(struct iscsi_session *sess)
 	 * time2retain handler) and contain and active session usage count we
 	 * restart the timer and exit.
 	 */
-	if (!in_interrupt()) {
-		iscsit_check_session_usage_count(sess);
-	} else {
-		if (iscsit_check_session_usage_count(sess) == 2) {
-			atomic_set(&sess->session_logout, 0);
-			iscsit_start_time2retain_handler(sess);
-			return 0;
-		}
+	if (iscsit_check_session_usage_count(sess, can_sleep)) {
+		atomic_set(&sess->session_logout, 0);
+		iscsit_start_time2retain_handler(sess);
+		return 0;
 	}
 
 	transport_deregister_session(sess->se_sess);
@@ -4527,7 +4536,7 @@ static void iscsit_logout_post_handler_diffcid(
  *	Return of 0 causes the TX thread to restart.
  */
 int iscsit_logout_post_handler(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	int ret = 0;
diff --git a/drivers/target/iscsi/iscsi_target.h b/drivers/target/iscsi/iscsi_target.h
index 7409ce2a6607..bfa3559cf823 100644
--- a/drivers/target/iscsi/iscsi_target.h
+++ b/drivers/target/iscsi/iscsi_target.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <linux/spinlock.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_np;
 struct iscsi_portal_group;
@@ -30,18 +30,18 @@ extern struct iscsi_np *iscsit_add_np(struct sockaddr_storage *,
 extern int iscsit_reset_np_thread(struct iscsi_np *, struct iscsi_tpg_np *,
 				struct iscsi_portal_group *, bool);
 extern int iscsit_del_np(struct iscsi_np *);
-extern int iscsit_reject_cmd(struct iscsi_cmd *cmd, u8, unsigned char *);
-extern void iscsit_set_unsolicited_dataout(struct iscsi_cmd *);
-extern int iscsit_logout_closesession(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_closeconnection(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_logout_removeconnforrecovery(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_reject_cmd(struct iscsit_cmd *cmd, u8, unsigned char *);
+extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
+extern int iscsit_logout_closesession(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_logout_closeconnection(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_logout_removeconnforrecovery(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_send_async_msg(struct iscsi_conn *, u16, u8, u8);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsi_cmd *, bool recovery);
+extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *, bool recovery);
 extern void iscsit_thread_get_cpumask(struct iscsi_conn *);
 extern int iscsi_target_tx_thread(void *);
 extern int iscsi_target_rx_thread(void *);
 extern int iscsit_close_connection(struct iscsi_conn *);
-extern int iscsit_close_session(struct iscsi_session *);
+extern int iscsit_close_session(struct iscsi_session *, bool can_sleep);
 extern void iscsit_fail_session(struct iscsi_session *);
 extern void iscsit_stop_session(struct iscsi_session *, int, int);
 extern int iscsit_release_sessions_for_tpg(struct iscsi_portal_group *, int);
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index 3cd671bbb9a4..755e980071b2 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1337,7 +1337,7 @@ static struct configfs_attribute *lio_target_discovery_auth_attrs[] = {
 
 static int iscsi_get_cmd_state(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	return cmd->i_state;
 }
@@ -1363,7 +1363,7 @@ static u32 lio_sess_get_initiator_sid(
 
 static int lio_queue_data_in(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_DATAIN;
@@ -1372,7 +1372,7 @@ static int lio_queue_data_in(struct se_cmd *se_cmd)
 
 static int lio_write_pending(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	if (!cmd->immediate_data && !cmd->unsolicited_data)
@@ -1383,7 +1383,7 @@ static int lio_write_pending(struct se_cmd *se_cmd)
 
 static int lio_queue_status(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 	struct iscsi_conn *conn = cmd->conn;
 
 	cmd->i_state = ISTATE_SEND_STATUS;
@@ -1396,7 +1396,7 @@ static int lio_queue_status(struct se_cmd *se_cmd)
 
 static void lio_queue_tm_rsp(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	cmd->i_state = ISTATE_SEND_TASKMGTRSP;
 	iscsit_add_cmd_to_response_queue(cmd, cmd->conn, cmd->i_state);
@@ -1404,7 +1404,7 @@ static void lio_queue_tm_rsp(struct se_cmd *se_cmd)
 
 static void lio_aborted_task(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	cmd->conn->conn_transport->iscsit_aborted_task(cmd->conn, cmd);
 }
@@ -1519,7 +1519,7 @@ static int lio_check_stop_free(struct se_cmd *se_cmd)
 
 static void lio_release_cmd(struct se_cmd *se_cmd)
 {
-	struct iscsi_cmd *cmd = container_of(se_cmd, struct iscsi_cmd, se_cmd);
+	struct iscsit_cmd *cmd = container_of(se_cmd, struct iscsit_cmd, se_cmd);
 
 	pr_debug("Entering lio_release_cmd for se_cmd: %p\n", se_cmd);
 	iscsit_release_cmd(cmd);
diff --git a/drivers/target/iscsi/iscsi_target_datain_values.c b/drivers/target/iscsi/iscsi_target_datain_values.c
index 07a22cd36a4e..091a710eadb0 100644
--- a/drivers/target/iscsi/iscsi_target_datain_values.c
+++ b/drivers/target/iscsi/iscsi_target_datain_values.c
@@ -32,14 +32,14 @@ struct iscsi_datain_req *iscsit_allocate_datain_req(void)
 	return dr;
 }
 
-void iscsit_attach_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
+void iscsit_attach_datain_req(struct iscsit_cmd *cmd, struct iscsi_datain_req *dr)
 {
 	spin_lock(&cmd->datain_lock);
 	list_add_tail(&dr->cmd_datain_node, &cmd->datain_list);
 	spin_unlock(&cmd->datain_lock);
 }
 
-void iscsit_free_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
+void iscsit_free_datain_req(struct iscsit_cmd *cmd, struct iscsi_datain_req *dr)
 {
 	spin_lock(&cmd->datain_lock);
 	list_del(&dr->cmd_datain_node);
@@ -48,7 +48,7 @@ void iscsit_free_datain_req(struct iscsi_cmd *cmd, struct iscsi_datain_req *dr)
 	kmem_cache_free(lio_dr_cache, dr);
 }
 
-void iscsit_free_all_datain_reqs(struct iscsi_cmd *cmd)
+void iscsit_free_all_datain_reqs(struct iscsit_cmd *cmd)
 {
 	struct iscsi_datain_req *dr, *dr_tmp;
 
@@ -60,7 +60,7 @@ void iscsit_free_all_datain_reqs(struct iscsi_cmd *cmd)
 	spin_unlock(&cmd->datain_lock);
 }
 
-struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *cmd)
+struct iscsi_datain_req *iscsit_get_datain_req(struct iscsit_cmd *cmd)
 {
 	if (list_empty(&cmd->datain_list)) {
 		pr_err("cmd->datain_list is empty for ITT:"
@@ -76,7 +76,7 @@ struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *cmd)
  *	For Normal and Recovery DataSequenceInOrder=Yes and DataPDUInOrder=Yes.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
@@ -174,7 +174,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_yes(
  *	For Normal and Recovery DataSequenceInOrder=No and DataPDUInOrder=Yes.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_no_and_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 offset, read_data_done, read_data_left, seq_send_order;
@@ -295,7 +295,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_yes(
  *	For Normal and Recovery DataSequenceInOrder=Yes and DataPDUInOrder=No.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 next_burst_len, read_data_done, read_data_left;
@@ -394,7 +394,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_yes_and_no(
  *	For Normal and Recovery DataSequenceInOrder=No and DataPDUInOrder=No.
  */
 static struct iscsi_datain_req *iscsit_set_datain_values_no_and_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	u32 read_data_done, read_data_left, seq_send_order;
@@ -496,7 +496,7 @@ static struct iscsi_datain_req *iscsit_set_datain_values_no_and_no(
 }
 
 struct iscsi_datain_req *iscsit_get_datain_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain *datain)
 {
 	struct iscsi_conn *conn = cmd->conn;
diff --git a/drivers/target/iscsi/iscsi_target_datain_values.h b/drivers/target/iscsi/iscsi_target_datain_values.h
index a420fbd37969..b28df886d828 100644
--- a/drivers/target/iscsi/iscsi_target_datain_values.h
+++ b/drivers/target/iscsi/iscsi_target_datain_values.h
@@ -2,15 +2,15 @@
 #ifndef ISCSI_TARGET_DATAIN_VALUES_H
 #define ISCSI_TARGET_DATAIN_VALUES_H
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_datain;
 
 extern struct iscsi_datain_req *iscsit_allocate_datain_req(void);
-extern void iscsit_attach_datain_req(struct iscsi_cmd *, struct iscsi_datain_req *);
-extern void iscsit_free_datain_req(struct iscsi_cmd *, struct iscsi_datain_req *);
-extern void iscsit_free_all_datain_reqs(struct iscsi_cmd *);
-extern struct iscsi_datain_req *iscsit_get_datain_req(struct iscsi_cmd *);
-extern struct iscsi_datain_req *iscsit_get_datain_values(struct iscsi_cmd *,
+extern void iscsit_attach_datain_req(struct iscsit_cmd *, struct iscsi_datain_req *);
+extern void iscsit_free_datain_req(struct iscsit_cmd *, struct iscsi_datain_req *);
+extern void iscsit_free_all_datain_reqs(struct iscsit_cmd *);
+extern struct iscsi_datain_req *iscsit_get_datain_req(struct iscsit_cmd *);
+extern struct iscsi_datain_req *iscsit_get_datain_values(struct iscsit_cmd *,
 			struct iscsi_datain *);
 
 #endif   /*** ISCSI_TARGET_DATAIN_VALUES_H ***/
diff --git a/drivers/target/iscsi/iscsi_target_device.c b/drivers/target/iscsi/iscsi_target_device.c
index 8bf36ec86e3f..d57041b860bd 100644
--- a/drivers/target/iscsi/iscsi_target_device.c
+++ b/drivers/target/iscsi/iscsi_target_device.c
@@ -42,7 +42,7 @@ void iscsit_determine_maxcmdsn(struct iscsi_session *sess)
 	atomic_add(se_nacl->queue_depth - 1, &sess->max_cmd_sn);
 }
 
-void iscsit_increment_maxcmdsn(struct iscsi_cmd *cmd, struct iscsi_session *sess)
+void iscsit_increment_maxcmdsn(struct iscsit_cmd *cmd, struct iscsi_session *sess)
 {
 	u32 max_cmd_sn;
 
diff --git a/drivers/target/iscsi/iscsi_target_device.h b/drivers/target/iscsi/iscsi_target_device.h
index ab2166f17785..b6a463847720 100644
--- a/drivers/target/iscsi/iscsi_target_device.h
+++ b/drivers/target/iscsi/iscsi_target_device.h
@@ -2,10 +2,10 @@
 #ifndef ISCSI_TARGET_DEVICE_H
 #define ISCSI_TARGET_DEVICE_H
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_session;
 
 extern void iscsit_determine_maxcmdsn(struct iscsi_session *);
-extern void iscsit_increment_maxcmdsn(struct iscsi_cmd *, struct iscsi_session *);
+extern void iscsit_increment_maxcmdsn(struct iscsit_cmd *, struct iscsi_session *);
 
 #endif /* ISCSI_TARGET_DEVICE_H */
diff --git a/drivers/target/iscsi/iscsi_target_erl0.c b/drivers/target/iscsi/iscsi_target_erl0.c
index b4abd7b68e6d..8ca910571ed3 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.c
+++ b/drivers/target/iscsi/iscsi_target_erl0.c
@@ -24,12 +24,12 @@
 #include "iscsi_target.h"
 
 /*
- *	Used to set values in struct iscsi_cmd that iscsit_dataout_check_sequence()
+ *	Used to set values in struct iscsit_cmd that iscsit_dataout_check_sequence()
  *	checks against to determine a PDU's Offset+Length is within the current
  *	DataOUT Sequence.  Used for DataSequenceInOrder=Yes only.
  */
 void iscsit_set_dataout_sequence_values(
-	struct iscsi_cmd *cmd)
+	struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	/*
@@ -63,7 +63,7 @@ void iscsit_set_dataout_sequence_values(
 }
 
 static int iscsit_dataout_within_command_recovery_check(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -129,7 +129,7 @@ static int iscsit_dataout_within_command_recovery_check(
 }
 
 static int iscsit_dataout_check_unsolicited_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 first_burst_len;
@@ -204,7 +204,7 @@ static int iscsit_dataout_check_unsolicited_sequence(
 }
 
 static int iscsit_dataout_check_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 next_burst_len;
@@ -333,7 +333,7 @@ static int iscsit_dataout_check_sequence(
 }
 
 static int iscsit_dataout_check_datasn(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	u32 data_sn = 0;
@@ -384,7 +384,7 @@ static int iscsit_dataout_check_datasn(
 }
 
 static int iscsit_dataout_pre_datapduinorder_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int dump = 0, recovery = 0;
@@ -394,7 +394,7 @@ static int iscsit_dataout_pre_datapduinorder_yes(
 
 	/*
 	 * For DataSequenceInOrder=Yes: If the offset is greater than the global
-	 * DataPDUInOrder=Yes offset counter in struct iscsi_cmd a protcol error has
+	 * DataPDUInOrder=Yes offset counter in struct iscsit_cmd a protcol error has
 	 * occurred and fail the connection.
 	 *
 	 * For DataSequenceInOrder=No: If the offset is greater than the per
@@ -446,7 +446,7 @@ static int iscsit_dataout_pre_datapduinorder_yes(
 }
 
 static int iscsit_dataout_pre_datapduinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_pdu *pdu;
@@ -477,7 +477,7 @@ static int iscsit_dataout_pre_datapduinorder_no(
 	return DATAOUT_NORMAL;
 }
 
-static int iscsit_dataout_update_r2t(struct iscsi_cmd *cmd, u32 offset, u32 length)
+static int iscsit_dataout_update_r2t(struct iscsit_cmd *cmd, u32 offset, u32 length)
 {
 	struct iscsi_r2t *r2t;
 
@@ -497,7 +497,7 @@ static int iscsit_dataout_update_r2t(struct iscsi_cmd *cmd, u32 offset, u32 leng
 }
 
 static int iscsit_dataout_update_datapduinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 data_sn,
 	int f_bit)
 {
@@ -530,7 +530,7 @@ static int iscsit_dataout_update_datapduinorder_no(
 }
 
 static int iscsit_dataout_post_crc_passed(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int ret, send_r2t = 0;
@@ -641,7 +641,7 @@ static int iscsit_dataout_post_crc_passed(
 }
 
 static int iscsit_dataout_post_crc_failed(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -679,7 +679,7 @@ static int iscsit_dataout_post_crc_failed(
  *	and CRC computed.
  */
 int iscsit_check_pre_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
 	int ret;
@@ -717,7 +717,7 @@ int iscsit_check_pre_dataout(
  *	and CRC computed.
  */
 int iscsit_check_post_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u8 data_crc_failed)
 {
@@ -765,7 +765,7 @@ void iscsit_handle_time2retain_timeout(struct timer_list *t)
 
 	iscsit_fill_cxn_timeout_err_stats(sess);
 	spin_unlock_bh(&se_tpg->session_lock);
-	iscsit_close_session(sess);
+	iscsit_close_session(sess, false);
 }
 
 void iscsit_start_time2retain_handler(struct iscsi_session *sess)
diff --git a/drivers/target/iscsi/iscsi_target_erl0.h b/drivers/target/iscsi/iscsi_target_erl0.h
index 883ebf6d36cf..d23a3041c325 100644
--- a/drivers/target/iscsi/iscsi_target_erl0.h
+++ b/drivers/target/iscsi/iscsi_target_erl0.h
@@ -4,13 +4,13 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_session;
 
-extern void iscsit_set_dataout_sequence_values(struct iscsi_cmd *);
-extern int iscsit_check_pre_dataout(struct iscsi_cmd *, unsigned char *);
-extern int iscsit_check_post_dataout(struct iscsi_cmd *, unsigned char *, u8);
+extern void iscsit_set_dataout_sequence_values(struct iscsit_cmd *);
+extern int iscsit_check_pre_dataout(struct iscsit_cmd *, unsigned char *);
+extern int iscsit_check_post_dataout(struct iscsit_cmd *, unsigned char *, u8);
 extern void iscsit_start_time2retain_handler(struct iscsi_session *);
 extern void iscsit_handle_time2retain_timeout(struct timer_list *t);
 extern int iscsit_stop_time2retain_timer(struct iscsi_session *);
diff --git a/drivers/target/iscsi/iscsi_target_erl1.c b/drivers/target/iscsi/iscsi_target_erl1.c
index cd670cb9b8fb..c6f907f24870 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.c
+++ b/drivers/target/iscsi/iscsi_target_erl1.c
@@ -87,7 +87,7 @@ int iscsit_dump_data_payload(
  *	Used for retransmitting R2Ts from a R2T SNACK request.
  */
 static int iscsit_send_recovery_r2t_for_snack(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_r2t *r2t)
 {
 	/*
@@ -109,7 +109,7 @@ static int iscsit_send_recovery_r2t_for_snack(
 }
 
 static int iscsit_handle_r2t_snack(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u32 begrun,
 	u32 runlength)
@@ -167,7 +167,7 @@ static int iscsit_handle_r2t_snack(
  *	FIXME: How is this handled for a RData SNACK?
  */
 int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain_req *dr)
 {
 	u32 data_sn = 0, data_sn_count = 0;
@@ -213,7 +213,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
  *	FIXME: How is this handled for a RData SNACK?
  */
 int iscsit_create_recovery_datain_values_datasequenceinorder_no(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_datain_req *dr)
 {
 	int found_seq = 0, i;
@@ -224,7 +224,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 	struct iscsi_seq *first_seq = NULL, *seq = NULL;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return -1;
 	}
 
@@ -371,7 +371,7 @@ int iscsit_create_recovery_datain_values_datasequenceinorder_no(
 }
 
 static int iscsit_handle_recovery_datain(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf,
 	u32 begrun,
 	u32 runlength)
@@ -439,7 +439,7 @@ int iscsit_handle_recovery_datain_or_r2t(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_find_cmd_from_itt(conn, init_task_tag);
 	if (!cmd)
@@ -471,7 +471,7 @@ int iscsit_handle_status_snack(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	u32 last_statsn;
 	int found_cmd;
 
@@ -534,7 +534,7 @@ int iscsit_handle_data_ack(
 	u32 begrun,
 	u32 runlength)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 
 	cmd = iscsit_find_cmd_from_ttt(conn, targ_xfer_tag);
 	if (!cmd) {
@@ -565,7 +565,7 @@ int iscsit_handle_data_ack(
 }
 
 static int iscsit_send_recovery_r2t(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 xfer_len)
 {
@@ -579,7 +579,7 @@ static int iscsit_send_recovery_r2t(
 }
 
 int iscsit_dataout_datapduinorder_no_fbit(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_pdu *pdu)
 {
 	int i, send_recovery_r2t = 0, recovery = 0;
@@ -655,7 +655,7 @@ int iscsit_dataout_datapduinorder_no_fbit(
 }
 
 static int iscsit_recalculate_dataout_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 pdu_offset,
 	u32 pdu_length,
 	u32 *r2t_offset,
@@ -732,7 +732,7 @@ static int iscsit_recalculate_dataout_values(
 }
 
 int iscsit_recover_dataout_sequence(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 pdu_offset,
 	u32 pdu_length)
 {
@@ -843,7 +843,7 @@ void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 int iscsit_execute_ooo_cmdsns(struct iscsi_session *sess)
 {
 	int ooo_count = 0;
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_ooo_cmdsn *ooo_cmdsn, *ooo_cmdsn_tmp;
 
 	lockdep_assert_held(&sess->cmdsn_mutex);
@@ -886,7 +886,7 @@ int iscsit_execute_ooo_cmdsns(struct iscsi_session *sess)
  *	2. With no locks held directly from iscsi_handle_XXX_pdu() functions
  *	for immediate commands.
  */
-int iscsit_execute_cmd(struct iscsi_cmd *cmd, int ooo)
+int iscsit_execute_cmd(struct iscsit_cmd *cmd, int ooo)
 {
 	struct se_cmd *se_cmd = &cmd->se_cmd;
 	struct iscsi_conn *conn = cmd->conn;
@@ -1012,7 +1012,7 @@ void iscsit_free_all_ooo_cmdsns(struct iscsi_session *sess)
 
 int iscsit_handle_ooo_cmdsn(
 	struct iscsi_session *sess,
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 cmdsn)
 {
 	int batch = 0;
@@ -1051,7 +1051,7 @@ int iscsit_handle_ooo_cmdsn(
 }
 
 static int iscsit_set_dataout_timeout_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 *offset,
 	u32 *length)
 {
@@ -1097,7 +1097,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 {
 	u32 pdu_length = 0, pdu_offset = 0;
 	u32 r2t_length = 0, r2t_offset = 0;
-	struct iscsi_cmd *cmd = from_timer(cmd, t, dataout_timer);
+	struct iscsit_cmd *cmd = from_timer(cmd, t, dataout_timer);
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_session *sess = NULL;
 	struct iscsi_node_attrib *na;
@@ -1181,7 +1181,7 @@ void iscsit_handle_dataout_timeout(struct timer_list *t)
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void iscsit_mod_dataout_timer(struct iscsi_cmd *cmd)
+void iscsit_mod_dataout_timer(struct iscsit_cmd *cmd)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_session *sess = conn->sess;
@@ -1201,7 +1201,7 @@ void iscsit_mod_dataout_timer(struct iscsi_cmd *cmd)
 }
 
 void iscsit_start_dataout_timer(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_session *sess = conn->sess;
@@ -1220,7 +1220,7 @@ void iscsit_start_dataout_timer(
 	mod_timer(&cmd->dataout_timer, jiffies + na->dataout_timeout * HZ);
 }
 
-void iscsit_stop_dataout_timer(struct iscsi_cmd *cmd)
+void iscsit_stop_dataout_timer(struct iscsit_cmd *cmd)
 {
 	spin_lock_bh(&cmd->dataout_timeout_lock);
 	if (!(cmd->dataout_timer_flags & ISCSI_TF_RUNNING)) {
diff --git a/drivers/target/iscsi/iscsi_target_erl1.h b/drivers/target/iscsi/iscsi_target_erl1.h
index 1f6973f87fea..48a13fc32e93 100644
--- a/drivers/target/iscsi/iscsi_target_erl1.h
+++ b/drivers/target/iscsi/iscsi_target_erl1.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <scsi/iscsi_proto.h> /* itt_t */
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_datain_req;
 struct iscsi_ooo_cmdsn;
@@ -14,25 +14,25 @@ struct iscsi_session;
 
 extern int iscsit_dump_data_payload(struct iscsi_conn *, u32, int);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_yes(
-			struct iscsi_cmd *, struct iscsi_datain_req *);
+			struct iscsit_cmd *, struct iscsi_datain_req *);
 extern int iscsit_create_recovery_datain_values_datasequenceinorder_no(
-			struct iscsi_cmd *, struct iscsi_datain_req *);
+			struct iscsit_cmd *, struct iscsi_datain_req *);
 extern int iscsit_handle_recovery_datain_or_r2t(struct iscsi_conn *, unsigned char *,
 			itt_t, u32, u32, u32);
 extern int iscsit_handle_status_snack(struct iscsi_conn *, itt_t, u32,
 			u32, u32);
 extern int iscsit_handle_data_ack(struct iscsi_conn *, u32, u32, u32);
-extern int iscsit_dataout_datapduinorder_no_fbit(struct iscsi_cmd *, struct iscsi_pdu *);
-extern int iscsit_recover_dataout_sequence(struct iscsi_cmd *, u32, u32);
+extern int iscsit_dataout_datapduinorder_no_fbit(struct iscsit_cmd *, struct iscsi_pdu *);
+extern int iscsit_recover_dataout_sequence(struct iscsit_cmd *, u32, u32);
 extern void iscsit_clear_ooo_cmdsns_for_conn(struct iscsi_conn *);
 extern void iscsit_free_all_ooo_cmdsns(struct iscsi_session *);
 extern int iscsit_execute_ooo_cmdsns(struct iscsi_session *);
-extern int iscsit_execute_cmd(struct iscsi_cmd *, int);
-extern int iscsit_handle_ooo_cmdsn(struct iscsi_session *, struct iscsi_cmd *, u32);
+extern int iscsit_execute_cmd(struct iscsit_cmd *, int);
+extern int iscsit_handle_ooo_cmdsn(struct iscsi_session *, struct iscsit_cmd *, u32);
 extern void iscsit_remove_ooo_cmdsn(struct iscsi_session *, struct iscsi_ooo_cmdsn *);
 extern void iscsit_handle_dataout_timeout(struct timer_list *t);
-extern void iscsit_mod_dataout_timer(struct iscsi_cmd *);
-extern void iscsit_start_dataout_timer(struct iscsi_cmd *, struct iscsi_conn *);
-extern void iscsit_stop_dataout_timer(struct iscsi_cmd *);
+extern void iscsit_mod_dataout_timer(struct iscsit_cmd *);
+extern void iscsit_start_dataout_timer(struct iscsit_cmd *, struct iscsi_conn *);
+extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 
 #endif /* ISCSI_TARGET_ERL1_H */
diff --git a/drivers/target/iscsi/iscsi_target_erl2.c b/drivers/target/iscsi/iscsi_target_erl2.c
index b1b7db9d1eda..f19ac2dbc062 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.c
+++ b/drivers/target/iscsi/iscsi_target_erl2.c
@@ -26,7 +26,7 @@
  *	FIXME: Does RData SNACK apply here as well?
  */
 void iscsit_create_conn_recovery_datain_values(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	__be32 exp_data_sn)
 {
 	u32 data_sn = 0;
@@ -54,7 +54,7 @@ void iscsit_create_conn_recovery_datain_values(
 }
 
 void iscsit_create_conn_recovery_dataout_values(
-	struct iscsi_cmd *cmd)
+	struct iscsit_cmd *cmd)
 {
 	u32 write_data_done = 0;
 	struct iscsi_conn *conn = cmd->conn;
@@ -119,7 +119,7 @@ struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 
 void iscsit_free_connection_recovery_entries(struct iscsi_session *sess)
 {
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_conn_recovery *cr, *cr_tmp;
 
 	spin_lock(&sess->cr_a_lock);
@@ -197,7 +197,7 @@ static void iscsit_remove_inactive_connection_recovery_entry(
  *	Called with cr->conn_recovery_cmd_lock help.
  */
 int iscsit_remove_cmd_from_connection_recovery(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_session *sess)
 {
 	struct iscsi_conn_recovery *cr;
@@ -218,7 +218,7 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 	u32 exp_statsn)
 {
 	u32 dropped_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_session *sess = cr->sess;
 
 	spin_lock(&cr->conn_recovery_cmd_lock);
@@ -266,7 +266,7 @@ void iscsit_discard_cr_cmds_by_expstatsn(
 int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 {
 	u32 dropped_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_ooo_cmdsn *ooo_cmdsn, *ooo_cmdsn_tmp;
 	struct iscsi_session *sess = conn->sess;
 
@@ -307,13 +307,13 @@ int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *conn)
 int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
 {
 	u32 cmd_count = 0;
-	struct iscsi_cmd *cmd, *cmd_tmp;
+	struct iscsit_cmd *cmd, *cmd_tmp;
 	struct iscsi_conn_recovery *cr;
 
 	/*
 	 * Allocate an struct iscsi_conn_recovery for this connection.
-	 * Each struct iscsi_cmd contains an struct iscsi_conn_recovery pointer
-	 * (struct iscsi_cmd->cr) so we need to allocate this before preparing the
+	 * Each struct iscsit_cmd contains an struct iscsi_conn_recovery pointer
+	 * (struct iscsit_cmd->cr) so we need to allocate this before preparing the
 	 * connection's command list for connection recovery.
 	 */
 	cr = kzalloc(sizeof(struct iscsi_conn_recovery), GFP_KERNEL);
@@ -393,7 +393,7 @@ int iscsit_prepare_cmds_for_reallegiance(struct iscsi_conn *conn)
 
 		transport_wait_for_tasks(&cmd->se_cmd);
 		/*
-		 * Add the struct iscsi_cmd to the connection recovery cmd list
+		 * Add the struct iscsit_cmd to the connection recovery cmd list
 		 */
 		spin_lock(&cr->conn_recovery_cmd_lock);
 		list_add_tail(&cmd->i_conn_node, &cr->conn_recovery_cmd_list);
diff --git a/drivers/target/iscsi/iscsi_target_erl2.h b/drivers/target/iscsi/iscsi_target_erl2.h
index a39b0caf2337..cf411375ad4c 100644
--- a/drivers/target/iscsi/iscsi_target_erl2.h
+++ b/drivers/target/iscsi/iscsi_target_erl2.h
@@ -4,19 +4,19 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
-extern void iscsit_create_conn_recovery_datain_values(struct iscsi_cmd *, __be32);
-extern void iscsit_create_conn_recovery_dataout_values(struct iscsi_cmd *);
+extern void iscsit_create_conn_recovery_datain_values(struct iscsit_cmd *, __be32);
+extern void iscsit_create_conn_recovery_dataout_values(struct iscsit_cmd *);
 extern struct iscsi_conn_recovery *iscsit_get_inactive_connection_recovery_entry(
 			struct iscsi_session *, u16);
 extern void iscsit_free_connection_recovery_entries(struct iscsi_session *);
 extern int iscsit_remove_active_connection_recovery_entry(
 			struct iscsi_conn_recovery *, struct iscsi_session *);
-extern int iscsit_remove_cmd_from_connection_recovery(struct iscsi_cmd *,
+extern int iscsit_remove_cmd_from_connection_recovery(struct iscsit_cmd *,
 			struct iscsi_session *);
 extern void iscsit_discard_cr_cmds_by_expstatsn(struct iscsi_conn_recovery *, u32);
 extern int iscsit_discard_unacknowledged_ooo_cmdsns_for_conn(struct iscsi_conn *);
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index ad60d28d7034..49ff2eafba49 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -1289,7 +1289,7 @@ int iscsi_target_locate_portal(
 alloc_tags:
 	tag_num = max_t(u32, ISCSIT_MIN_TAGS, queue_depth);
 	tag_num = (tag_num * 2) + ISCSIT_EXTRA_TAGS;
-	tag_size = sizeof(struct iscsi_cmd) + conn->conn_transport->priv_size;
+	tag_size = sizeof(struct iscsit_cmd) + conn->conn_transport->priv_size;
 
 	ret = transport_alloc_session_tags(sess->se_sess, tag_num, tag_size);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
index ea2b02a93e45..98aee976d79c 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.c
@@ -18,7 +18,7 @@
 #include "iscsi_target_seq_pdu_list.h"
 
 #ifdef DEBUG
-static void iscsit_dump_seq_list(struct iscsi_cmd *cmd)
+static void iscsit_dump_seq_list(struct iscsit_cmd *cmd)
 {
 	int i;
 	struct iscsi_seq *seq;
@@ -36,7 +36,7 @@ static void iscsit_dump_seq_list(struct iscsi_cmd *cmd)
 	}
 }
 
-static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd)
+static void iscsit_dump_pdu_list(struct iscsit_cmd *cmd)
 {
 	int i;
 	struct iscsi_pdu *pdu;
@@ -52,12 +52,12 @@ static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd)
 	}
 }
 #else
-static void iscsit_dump_seq_list(struct iscsi_cmd *cmd) {}
-static void iscsit_dump_pdu_list(struct iscsi_cmd *cmd) {}
+static void iscsit_dump_seq_list(struct iscsit_cmd *cmd) {}
+static void iscsit_dump_pdu_list(struct iscsit_cmd *cmd) {}
 #endif
 
 static void iscsit_ordered_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	u32 i, seq_count = 0;
@@ -70,7 +70,7 @@ static void iscsit_ordered_seq_lists(
 }
 
 static void iscsit_ordered_pdu_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	u32 i, pdu_send_order = 0, seq_no = 0;
@@ -117,7 +117,7 @@ static void iscsit_create_random_array(u32 *array, u32 count)
 }
 
 static int iscsit_randomize_pdu_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	int i = 0;
@@ -167,7 +167,7 @@ static int iscsit_randomize_pdu_lists(
 }
 
 static int iscsit_randomize_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u8 type)
 {
 	int i, j = 0;
@@ -199,7 +199,7 @@ static int iscsit_randomize_seq_lists(
 }
 
 static void iscsit_determine_counts_for_list(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_build_list *bl,
 	u32 *seq_count,
 	u32 *pdu_count)
@@ -283,7 +283,7 @@ static void iscsit_determine_counts_for_list(
  *	or DataPDUInOrder=No.
  */
 static int iscsit_do_build_pdu_and_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_build_list *bl)
 {
 	int check_immediate = 0, datapduinorder, datasequenceinorder;
@@ -484,7 +484,7 @@ static int iscsit_do_build_pdu_and_seq_lists(
 }
 
 int iscsit_build_pdu_and_seq_lists(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 immediate_data_length)
 {
 	struct iscsi_build_list bl;
@@ -559,7 +559,7 @@ int iscsit_build_pdu_and_seq_lists(
 }
 
 struct iscsi_pdu *iscsit_get_pdu_holder(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
@@ -567,7 +567,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder(
 	struct iscsi_pdu *pdu = NULL;
 
 	if (!cmd->pdu_list) {
-		pr_err("struct iscsi_cmd->pdu_list is NULL!\n");
+		pr_err("struct iscsit_cmd->pdu_list is NULL!\n");
 		return NULL;
 	}
 
@@ -583,7 +583,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder(
 }
 
 struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_seq *seq)
 {
 	u32 i;
@@ -591,7 +591,7 @@ struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
 	struct iscsi_pdu *pdu = NULL;
 
 	if (!cmd->pdu_list) {
-		pr_err("struct iscsi_cmd->pdu_list is NULL!\n");
+		pr_err("struct iscsit_cmd->pdu_list is NULL!\n");
 		return NULL;
 	}
 
@@ -660,14 +660,14 @@ struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(
 }
 
 struct iscsi_seq *iscsit_get_seq_holder(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
 	u32 i;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return NULL;
 	}
 
diff --git a/drivers/target/iscsi/iscsi_target_seq_pdu_list.h b/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
index 5a0907027973..288298f9f1b4 100644
--- a/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
+++ b/drivers/target/iscsi/iscsi_target_seq_pdu_list.h
@@ -82,11 +82,11 @@ struct iscsi_seq {
 	u32		xfer_len;
 } ____cacheline_aligned;
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 
-extern int iscsit_build_pdu_and_seq_lists(struct iscsi_cmd *, u32);
-extern struct iscsi_pdu *iscsit_get_pdu_holder(struct iscsi_cmd *, u32, u32);
-extern struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(struct iscsi_cmd *, struct iscsi_seq *);
-extern struct iscsi_seq *iscsit_get_seq_holder(struct iscsi_cmd *, u32, u32);
+extern int iscsit_build_pdu_and_seq_lists(struct iscsit_cmd *, u32);
+extern struct iscsi_pdu *iscsit_get_pdu_holder(struct iscsit_cmd *, u32, u32);
+extern struct iscsi_pdu *iscsit_get_pdu_holder_for_seq(struct iscsit_cmd *, struct iscsi_seq *);
+extern struct iscsi_seq *iscsit_get_seq_holder(struct iscsit_cmd *, u32, u32);
 
 #endif /* ISCSI_SEQ_AND_PDU_LIST_H */
diff --git a/drivers/target/iscsi/iscsi_target_tmr.c b/drivers/target/iscsi/iscsi_target_tmr.c
index 7d618db80c51..aa062c3166c2 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.c
+++ b/drivers/target/iscsi/iscsi_target_tmr.c
@@ -28,10 +28,10 @@
 #include "iscsi_target.h"
 
 u8 iscsit_tmr_abort_task(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *ref_cmd;
+	struct iscsit_cmd *ref_cmd;
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -103,10 +103,10 @@ int iscsit_tmr_task_cold_reset(
 }
 
 u8 iscsit_tmr_task_reassign(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	unsigned char *buf)
 {
-	struct iscsi_cmd *ref_cmd = NULL;
+	struct iscsit_cmd *ref_cmd = NULL;
 	struct iscsi_conn *conn = cmd->conn;
 	struct iscsi_conn_recovery *cr = NULL;
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
@@ -175,7 +175,7 @@ u8 iscsit_tmr_task_reassign(
 }
 
 static void iscsit_task_reassign_remove_cmd(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn_recovery *cr,
 	struct iscsi_session *sess)
 {
@@ -195,7 +195,7 @@ static int iscsit_task_reassign_complete_nop_out(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
 
 	if (!cmd->cr) {
@@ -224,7 +224,7 @@ static int iscsit_task_reassign_complete_nop_out(
 }
 
 static int iscsit_task_reassign_complete_write(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	int no_build_r2ts = 0;
@@ -296,7 +296,7 @@ static int iscsit_task_reassign_complete_write(
 }
 
 static int iscsit_task_reassign_complete_read(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -349,7 +349,7 @@ static int iscsit_task_reassign_complete_read(
 }
 
 static int iscsit_task_reassign_complete_none(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_tmr_req *tmr_req)
 {
 	struct iscsi_conn *conn = cmd->conn;
@@ -363,7 +363,7 @@ static int iscsit_task_reassign_complete_scsi_cmnd(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_conn_recovery *cr;
 
 	if (!cmd->cr) {
@@ -412,11 +412,11 @@ static int iscsit_task_reassign_complete(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	int ret = 0;
 
 	if (!tmr_req->ref_cmd) {
-		pr_err("TMR Request is missing a RefCmd struct iscsi_cmd.\n");
+		pr_err("TMR Request is missing a RefCmd struct iscsit_cmd.\n");
 		return -1;
 	}
 	cmd = tmr_req->ref_cmd;
@@ -451,7 +451,7 @@ static int iscsit_task_reassign_complete(
  *	Right now the only one that its really needed for is
  *	connection recovery releated TASK_REASSIGN.
  */
-int iscsit_tmr_post_handler(struct iscsi_cmd *cmd, struct iscsi_conn *conn)
+int iscsit_tmr_post_handler(struct iscsit_cmd *cmd, struct iscsi_conn *conn)
 {
 	struct iscsi_tmr_req *tmr_req = cmd->tmr_req;
 	struct se_tmr_req *se_tmr = cmd->se_cmd.se_tmr_req;
@@ -475,7 +475,7 @@ static int iscsit_task_reassign_prepare_read(
 }
 
 static void iscsit_task_reassign_prepare_unsolicited_dataout(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	int i, j;
@@ -546,7 +546,7 @@ static int iscsit_task_reassign_prepare_write(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *cmd = tmr_req->ref_cmd;
 	struct iscsi_pdu *pdu = NULL;
 	struct iscsi_r2t *r2t = NULL, *r2t_tmp;
 	int first_incomplete_r2t = 1, i = 0;
@@ -575,7 +575,7 @@ static int iscsit_task_reassign_prepare_write(
 	 *
 	 * If we have not received all DataOUT in question,  we must
 	 * make sure to make the appropriate changes to values in
-	 * struct iscsi_cmd (and elsewhere depending on session parameters)
+	 * struct iscsit_cmd (and elsewhere depending on session parameters)
 	 * so iscsit_build_r2ts_for_cmd() in iscsit_task_reassign_complete_write()
 	 * will resend a new R2T for the DataOUT sequences in question.
 	 */
@@ -708,7 +708,7 @@ static int iscsit_task_reassign_prepare_write(
 	 * to check that the Initiator is not requesting R2Ts for DataOUT
 	 * sequences it has already completed.
 	 *
-	 * Free each R2T in question and adjust values in struct iscsi_cmd
+	 * Free each R2T in question and adjust values in struct iscsit_cmd
 	 * accordingly so iscsit_build_r2ts_for_cmd() do the rest of
 	 * the work after the TMR TASK_REASSIGN Response is sent.
 	 */
@@ -773,13 +773,13 @@ static int iscsit_task_reassign_prepare_write(
 
 /*
  *	Performs sanity checks TMR TASK_REASSIGN's ExpDataSN for
- *	a given struct iscsi_cmd.
+ *	a given struct iscsit_cmd.
  */
 int iscsit_check_task_reassign_expdatasn(
 	struct iscsi_tmr_req *tmr_req,
 	struct iscsi_conn *conn)
 {
-	struct iscsi_cmd *ref_cmd = tmr_req->ref_cmd;
+	struct iscsit_cmd *ref_cmd = tmr_req->ref_cmd;
 
 	if (ref_cmd->iscsi_opcode != ISCSI_OP_SCSI_CMD)
 		return 0;
diff --git a/drivers/target/iscsi/iscsi_target_tmr.h b/drivers/target/iscsi/iscsi_target_tmr.h
index 301f0936bd8e..60aac3a8f3c0 100644
--- a/drivers/target/iscsi/iscsi_target_tmr.h
+++ b/drivers/target/iscsi/iscsi_target_tmr.h
@@ -4,17 +4,17 @@
 
 #include <linux/types.h>
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_tmr_req;
 
-extern u8 iscsit_tmr_abort_task(struct iscsi_cmd *, unsigned char *);
+extern u8 iscsit_tmr_abort_task(struct iscsit_cmd *, unsigned char *);
 extern int iscsit_tmr_task_warm_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
 extern int iscsit_tmr_task_cold_reset(struct iscsi_conn *, struct iscsi_tmr_req *,
 			unsigned char *);
-extern u8 iscsit_tmr_task_reassign(struct iscsi_cmd *, unsigned char *);
-extern int iscsit_tmr_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
+extern u8 iscsit_tmr_task_reassign(struct iscsit_cmd *, unsigned char *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_check_task_reassign_expdatasn(struct iscsi_tmr_req *,
 			struct iscsi_conn *);
 
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index f81cbfe760fa..129762ab64a2 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -49,7 +49,7 @@ extern struct list_head g_tiqn_list;
 extern spinlock_t tiqn_lock;
 
 int iscsit_add_r2t_to_list(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 xfer_len,
 	int recovery,
@@ -82,7 +82,7 @@ int iscsit_add_r2t_to_list(
 }
 
 struct iscsi_r2t *iscsit_get_r2t_for_eos(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 offset,
 	u32 length)
 {
@@ -103,7 +103,7 @@ struct iscsi_r2t *iscsit_get_r2t_for_eos(
 	return NULL;
 }
 
-struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *cmd)
+struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsit_cmd *cmd)
 {
 	struct iscsi_r2t *r2t;
 
@@ -121,7 +121,7 @@ struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *cmd)
 	return NULL;
 }
 
-void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsi_cmd *cmd)
+void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsit_cmd *cmd)
 {
 	lockdep_assert_held(&cmd->r2t_lock);
 
@@ -129,7 +129,7 @@ void iscsit_free_r2t(struct iscsi_r2t *r2t, struct iscsi_cmd *cmd)
 	kmem_cache_free(lio_r2t_cache, r2t);
 }
 
-void iscsit_free_r2ts_from_list(struct iscsi_cmd *cmd)
+void iscsit_free_r2ts_from_list(struct iscsit_cmd *cmd)
 {
 	struct iscsi_r2t *r2t, *r2t_tmp;
 
@@ -169,9 +169,9 @@ static int iscsit_wait_for_tag(struct se_session *se_sess, int state, int *cpup)
  * May be called from software interrupt (timer) context for allocating
  * iSCSI NopINs.
  */
-struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
+struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 	struct se_session *se_sess = conn->sess->se_sess;
 	int size, tag, cpu;
 
@@ -181,8 +181,8 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 	if (tag < 0)
 		return NULL;
 
-	size = sizeof(struct iscsi_cmd) + conn->conn_transport->priv_size;
-	cmd = (struct iscsi_cmd *)(se_sess->sess_cmd_map + (tag * size));
+	size = sizeof(struct iscsit_cmd) + conn->conn_transport->priv_size;
+	cmd = (struct iscsit_cmd *)(se_sess->sess_cmd_map + (tag * size));
 	memset(cmd, 0, size);
 
 	cmd->se_cmd.map_tag = tag;
@@ -204,7 +204,7 @@ struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *conn, int state)
 EXPORT_SYMBOL(iscsit_allocate_cmd);
 
 struct iscsi_seq *iscsit_get_seq_holder_for_datain(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 seq_send_order)
 {
 	u32 i;
@@ -216,12 +216,12 @@ struct iscsi_seq *iscsit_get_seq_holder_for_datain(
 	return NULL;
 }
 
-struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *cmd)
+struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsit_cmd *cmd)
 {
 	u32 i;
 
 	if (!cmd->seq_list) {
-		pr_err("struct iscsi_cmd->seq_list is NULL!\n");
+		pr_err("struct iscsit_cmd->seq_list is NULL!\n");
 		return NULL;
 	}
 
@@ -238,7 +238,7 @@ struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *cmd)
 }
 
 struct iscsi_r2t *iscsit_get_holder_for_r2tsn(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	u32 r2t_sn)
 {
 	struct iscsi_r2t *r2t;
@@ -299,7 +299,7 @@ static inline int iscsit_check_received_cmdsn(struct iscsi_session *sess, u32 cm
  * Commands may be received out of order if MC/S is in use.
  * Ensure they are executed in CmdSN order.
  */
-int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			unsigned char *buf, __be32 cmdsn)
 {
 	int ret, cmdsn_ret;
@@ -350,7 +350,7 @@ int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
 }
 EXPORT_SYMBOL(iscsit_sequence_cmd);
 
-int iscsit_check_unsolicited_dataout(struct iscsi_cmd *cmd, unsigned char *buf)
+int iscsit_check_unsolicited_dataout(struct iscsit_cmd *cmd, unsigned char *buf)
 {
 	struct iscsi_conn *conn = cmd->conn;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
@@ -394,11 +394,11 @@ int iscsit_check_unsolicited_dataout(struct iscsi_cmd *cmd, unsigned char *buf)
 	return 0;
 }
 
-struct iscsi_cmd *iscsit_find_cmd_from_itt(
+struct iscsit_cmd *iscsit_find_cmd_from_itt(
 	struct iscsi_conn *conn,
 	itt_t init_task_tag)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -415,12 +415,12 @@ struct iscsi_cmd *iscsit_find_cmd_from_itt(
 }
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt);
 
-struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(
+struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(
 	struct iscsi_conn *conn,
 	itt_t init_task_tag,
 	u32 length)
 {
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -442,11 +442,11 @@ struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(
 }
 EXPORT_SYMBOL(iscsit_find_cmd_from_itt_or_dump);
 
-struct iscsi_cmd *iscsit_find_cmd_from_ttt(
+struct iscsit_cmd *iscsit_find_cmd_from_ttt(
 	struct iscsi_conn *conn,
 	u32 targ_xfer_tag)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 
 	spin_lock_bh(&conn->cmd_lock);
 	list_for_each_entry(cmd, &conn->conn_cmd_list, i_conn_node) {
@@ -464,11 +464,11 @@ struct iscsi_cmd *iscsit_find_cmd_from_ttt(
 
 int iscsit_find_cmd_for_recovery(
 	struct iscsi_session *sess,
-	struct iscsi_cmd **cmd_ptr,
+	struct iscsit_cmd **cmd_ptr,
 	struct iscsi_conn_recovery **cr_ptr,
 	itt_t init_task_tag)
 {
-	struct iscsi_cmd *cmd = NULL;
+	struct iscsit_cmd *cmd = NULL;
 	struct iscsi_conn_recovery *cr;
 	/*
 	 * Scan through the inactive connection recovery list's command list.
@@ -515,7 +515,7 @@ int iscsit_find_cmd_for_recovery(
 }
 
 void iscsit_add_cmd_to_immediate_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	u8 state)
 {
@@ -562,7 +562,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *c
 }
 
 static void iscsit_remove_cmd_from_immediate_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
@@ -591,7 +591,7 @@ static void iscsit_remove_cmd_from_immediate_queue(
 }
 
 int iscsit_add_cmd_to_response_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	u8 state)
 {
@@ -638,7 +638,7 @@ struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *co
 }
 
 static void iscsit_remove_cmd_from_response_queue(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct iscsi_queue_req *qr, *qr_tmp;
@@ -711,7 +711,7 @@ void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *conn)
 	spin_unlock_bh(&conn->response_queue_lock);
 }
 
-void iscsit_release_cmd(struct iscsi_cmd *cmd)
+void iscsit_release_cmd(struct iscsit_cmd *cmd)
 {
 	struct iscsi_session *sess;
 	struct se_cmd *se_cmd = &cmd->se_cmd;
@@ -737,7 +737,7 @@ void iscsit_release_cmd(struct iscsi_cmd *cmd)
 }
 EXPORT_SYMBOL(iscsit_release_cmd);
 
-void __iscsit_free_cmd(struct iscsi_cmd *cmd, bool check_queues)
+void __iscsit_free_cmd(struct iscsit_cmd *cmd, bool check_queues)
 {
 	struct iscsi_conn *conn = cmd->conn;
 
@@ -759,7 +759,7 @@ void __iscsit_free_cmd(struct iscsi_cmd *cmd, bool check_queues)
 		conn->conn_transport->iscsit_unmap_cmd(conn, cmd);
 }
 
-void iscsit_free_cmd(struct iscsi_cmd *cmd, bool shutdown)
+void iscsit_free_cmd(struct iscsit_cmd *cmd, bool shutdown)
 {
 	struct se_cmd *se_cmd = cmd->se_cmd.se_tfo ? &cmd->se_cmd : NULL;
 	int rc;
@@ -779,21 +779,22 @@ void iscsit_free_cmd(struct iscsi_cmd *cmd, bool shutdown)
 }
 EXPORT_SYMBOL(iscsit_free_cmd);
 
-int iscsit_check_session_usage_count(struct iscsi_session *sess)
+bool iscsit_check_session_usage_count(struct iscsi_session *sess,
+				      bool can_sleep)
 {
 	spin_lock_bh(&sess->session_usage_lock);
 	if (sess->session_usage_count != 0) {
 		sess->session_waiting_on_uc = 1;
 		spin_unlock_bh(&sess->session_usage_lock);
-		if (in_interrupt())
-			return 2;
+		if (!can_sleep)
+			return true;
 
 		wait_for_completion(&sess->session_waiting_on_uc_comp);
-		return 1;
+		return false;
 	}
 	spin_unlock_bh(&sess->session_usage_lock);
 
-	return 0;
+	return false;
 }
 
 void iscsit_dec_session_usage_count(struct iscsi_session *sess)
@@ -892,7 +893,7 @@ void iscsit_inc_conn_usage_count(struct iscsi_conn *conn)
 static int iscsit_add_nopin(struct iscsi_conn *conn, int want_response)
 {
 	u8 state;
-	struct iscsi_cmd *cmd;
+	struct iscsit_cmd *cmd;
 
 	cmd = iscsit_allocate_cmd(conn, TASK_RUNNING);
 	if (!cmd)
@@ -1063,7 +1064,7 @@ void iscsit_stop_nopin_timer(struct iscsi_conn *conn)
 }
 
 int iscsit_send_tx_data(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn,
 	int use_misc)
 {
@@ -1096,7 +1097,7 @@ int iscsit_send_tx_data(
 }
 
 int iscsit_fe_sendpage_sg(
-	struct iscsi_cmd *cmd,
+	struct iscsit_cmd *cmd,
 	struct iscsi_conn *conn)
 {
 	struct scatterlist *sg = cmd->first_data_sg;
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index 68e84803b0a1..dec142ed4704 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -7,40 +7,40 @@
 
 #define MARKER_SIZE	8
 
-struct iscsi_cmd;
+struct iscsit_cmd;
 struct iscsi_conn;
 struct iscsi_conn_recovery;
 struct iscsi_session;
 
-extern int iscsit_add_r2t_to_list(struct iscsi_cmd *, u32, u32, int, u32);
-extern struct iscsi_r2t *iscsit_get_r2t_for_eos(struct iscsi_cmd *, u32, u32);
-extern struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsi_cmd *);
-extern void iscsit_free_r2t(struct iscsi_r2t *, struct iscsi_cmd *);
-extern void iscsit_free_r2ts_from_list(struct iscsi_cmd *);
-extern struct iscsi_cmd *iscsit_alloc_cmd(struct iscsi_conn *, gfp_t);
-extern struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
-extern struct iscsi_seq *iscsit_get_seq_holder_for_datain(struct iscsi_cmd *, u32);
-extern struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsi_cmd *);
-extern struct iscsi_r2t *iscsit_get_holder_for_r2tsn(struct iscsi_cmd *, u32);
-extern int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsi_cmd *cmd,
+extern int iscsit_add_r2t_to_list(struct iscsit_cmd *, u32, u32, int, u32);
+extern struct iscsi_r2t *iscsit_get_r2t_for_eos(struct iscsit_cmd *, u32, u32);
+extern struct iscsi_r2t *iscsit_get_r2t_from_list(struct iscsit_cmd *);
+extern void iscsit_free_r2t(struct iscsi_r2t *, struct iscsit_cmd *);
+extern void iscsit_free_r2ts_from_list(struct iscsit_cmd *);
+extern struct iscsit_cmd *iscsit_alloc_cmd(struct iscsi_conn *, gfp_t);
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
+extern struct iscsi_seq *iscsit_get_seq_holder_for_datain(struct iscsit_cmd *, u32);
+extern struct iscsi_seq *iscsit_get_seq_holder_for_r2t(struct iscsit_cmd *);
+extern struct iscsi_r2t *iscsit_get_holder_for_r2tsn(struct iscsit_cmd *, u32);
+extern int iscsit_sequence_cmd(struct iscsi_conn *conn, struct iscsit_cmd *cmd,
 			       unsigned char * ,__be32 cmdsn);
-extern int iscsit_check_unsolicited_dataout(struct iscsi_cmd *, unsigned char *);
-extern struct iscsi_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *,
+extern int iscsit_check_unsolicited_dataout(struct iscsit_cmd *, unsigned char *);
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *,
 			itt_t, u32);
-extern struct iscsi_cmd *iscsit_find_cmd_from_ttt(struct iscsi_conn *, u32);
-extern int iscsit_find_cmd_for_recovery(struct iscsi_session *, struct iscsi_cmd **,
+extern struct iscsit_cmd *iscsit_find_cmd_from_ttt(struct iscsi_conn *, u32);
+extern int iscsit_find_cmd_for_recovery(struct iscsi_session *, struct iscsit_cmd **,
 			struct iscsi_conn_recovery **, itt_t);
-extern void iscsit_add_cmd_to_immediate_queue(struct iscsi_cmd *, struct iscsi_conn *, u8);
+extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
 extern struct iscsi_queue_req *iscsit_get_cmd_from_immediate_queue(struct iscsi_conn *);
-extern int iscsit_add_cmd_to_response_queue(struct iscsi_cmd *, struct iscsi_conn *, u8);
+extern int iscsit_add_cmd_to_response_queue(struct iscsit_cmd *, struct iscsi_conn *, u8);
 extern struct iscsi_queue_req *iscsit_get_cmd_from_response_queue(struct iscsi_conn *);
-extern void iscsit_remove_cmd_from_tx_queues(struct iscsi_cmd *, struct iscsi_conn *);
+extern void iscsit_remove_cmd_from_tx_queues(struct iscsit_cmd *, struct iscsi_conn *);
 extern bool iscsit_conn_all_queues_empty(struct iscsi_conn *);
 extern void iscsit_free_queue_reqs_for_conn(struct iscsi_conn *);
-extern void iscsit_release_cmd(struct iscsi_cmd *);
-extern void __iscsit_free_cmd(struct iscsi_cmd *, bool);
-extern void iscsit_free_cmd(struct iscsi_cmd *, bool);
-extern int iscsit_check_session_usage_count(struct iscsi_session *);
+extern void iscsit_release_cmd(struct iscsit_cmd *);
+extern void __iscsit_free_cmd(struct iscsit_cmd *, bool);
+extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
+extern bool iscsit_check_session_usage_count(struct iscsi_session *sess, bool can_sleep);
 extern void iscsit_dec_session_usage_count(struct iscsi_session *);
 extern void iscsit_inc_session_usage_count(struct iscsi_session *);
 extern struct iscsi_conn *iscsit_get_conn_from_cid(struct iscsi_session *, u16);
@@ -56,8 +56,8 @@ extern void iscsit_handle_nopin_timeout(struct timer_list *t);
 extern void __iscsit_start_nopin_timer(struct iscsi_conn *);
 extern void iscsit_start_nopin_timer(struct iscsi_conn *);
 extern void iscsit_stop_nopin_timer(struct iscsi_conn *);
-extern int iscsit_send_tx_data(struct iscsi_cmd *, struct iscsi_conn *, int);
-extern int iscsit_fe_sendpage_sg(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsi_conn *, int);
+extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsi_conn *);
 extern int iscsit_tx_login_rsp(struct iscsi_conn *, u8, u8);
 extern void iscsit_print_session_params(struct iscsi_session *);
 extern int iscsit_print_dev_to_proc(char *, char **, off_t, int);
diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index f8f1594bea43..8bfa8315b56f 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -571,7 +571,8 @@ static bool is_normal_memory(pgprot_t p)
 	return (((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEALLOC) ||
 		((pgprot_val(p) & L_PTE_MT_MASK) == L_PTE_MT_WRITEBACK));
 #elif defined(CONFIG_ARM64)
-	return (pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL);
+	return ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL)) ||
+	       ((pgprot_val(p) & PTE_ATTRINDX_MASK) == PTE_ATTRINDX(MT_NORMAL_TAGGED));
 #else
 #error "Unuspported architecture"
 #endif
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 66e0639da4bf..7bb75fdde4ed 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1737,9 +1737,9 @@ static void soctherm_init_hw_throt_cdev(struct platform_device *pdev)
 			stc->init = true;
 		} else {
 
-			tcd = thermal_of_cooling_device_register(np_stcc,
-							 (char *)name, ts,
-							 &throt_cooling_ops);
+			tcd = devm_thermal_of_cooling_device_register(dev, np_stcc,
+								      (char *)name, ts,
+								      &throt_cooling_ops);
 			if (IS_ERR_OR_NULL(tcd)) {
 				dev_err(dev,
 					"throttle-cfg: %s: failed to register cooling device\n",
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 545ed25b705d..2584e05d06b4 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -56,7 +56,7 @@ static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
 	if (!ev)
 		return;
 
-	ev->tb = tb;
+	ev->tb = tb_domain_get(tb);
 	ev->route = route;
 	ev->port = port;
 	ev->unplug = unplug;
@@ -1213,6 +1213,9 @@ static void tb_handle_hotplug(struct work_struct *work)
 	pm_runtime_mark_last_busy(&tb->dev);
 	pm_runtime_put_autosuspend(&tb->dev);
 
+	/* Undo the refcount increased in tb_queue_hotplug() */
+	tb_domain_put(tb);
+
 	kfree(ev);
 }
 
@@ -1261,6 +1264,7 @@ static void tb_stop(struct tb *tb)
 		tb_tunnel_free(tunnel);
 	}
 	tb_switch_remove(tb->root_switch);
+	tb->root_switch = NULL;
 	tcm->hotplug_active = false; /* signal tb_handle_hotplug to quit */
 }
 
diff --git a/drivers/thunderbolt/xdomain.c b/drivers/thunderbolt/xdomain.c
index 47ccebf42c5a..eeff6b1b498e 100644
--- a/drivers/thunderbolt/xdomain.c
+++ b/drivers/thunderbolt/xdomain.c
@@ -97,6 +97,7 @@ static int __tb_xdomain_response(struct tb_ctl *ctl, const void *response,
 				 size_t size, enum tb_cfg_pkg_type type)
 {
 	struct tb_cfg_request *req;
+	int ret;
 
 	req = tb_cfg_request_alloc();
 	if (!req)
@@ -108,7 +109,11 @@ static int __tb_xdomain_response(struct tb_ctl *ctl, const void *response,
 	req->request_size = size;
 	req->request_type = type;
 
-	return tb_cfg_request(ctl, req, response_ready, req);
+	ret = tb_cfg_request(ctl, req, response_ready, req);
+	if (ret)
+		tb_cfg_request_put(req);
+
+	return ret;
 }
 
 /**
@@ -572,7 +577,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 
 	mutex_lock(&tb->lock);
 	if (tb->root_switch)
-		uuid = tb->root_switch->uuid;
+		uuid = kmemdup(tb->root_switch->uuid, sizeof(*uuid), GFP_KERNEL);
 	else
 		uuid = NULL;
 	mutex_unlock(&tb->lock);
@@ -633,6 +638,7 @@ static void tb_xdp_handle_request(struct work_struct *work)
 	}
 
 out:
+	kfree(uuid);
 	kfree(xw->pkg);
 	kfree(xw);
 
@@ -1491,6 +1497,9 @@ static struct tb_xdomain *switch_find_xdomain(struct tb_switch *sw,
 {
 	struct tb_port *port;
 
+	if (!sw)
+		return NULL;
+
 	tb_switch_for_each_port(sw, port) {
 		struct tb_xdomain *xd;
 
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 4b9c54ee00e8..691b83295136 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1894,6 +1894,13 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 
 	status = serial_port_in(port, UART_LSR);
 
+	/*
+	 * Recover from no-data-ready and FIFO error condition to avoid getting
+	 * stuck in the ISR.
+	 */
+	if (!(status & UART_LSR_DR) && (status & UART_LSR_FIFOE))
+		serial8250_clear_and_reinit_fifos(up);
+
 	/*
 	 * If port is stopped and there are no error conditions in the
 	 * FIFO, then don't drain the FIFO, as this may lead to TTY buffer
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 0e54f6f18348..eb0de366fb03 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -473,7 +473,8 @@ rh_string(int id, struct usb_hcd const *hcd, u8 *data, unsigned len)
 
 
 /* Root hub control transfers execute synchronously */
-static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
+static int rh_call_control(struct usb_hcd *hcd,
+		struct urb *urb, gfp_t mem_flags)
 {
 	struct usb_ctrlrequest *cmd;
 	u16		typeReq, wValue, wIndex, wLength;
@@ -508,8 +509,8 @@ static int rh_call_control (struct usb_hcd *hcd, struct urb *urb)
 	 * tbuf should be at least as big as the
 	 * USB hub descriptor.
 	 */
-	tbuf_size =  max_t(u16, sizeof(struct usb_hub_descriptor), wLength);
-	tbuf = kzalloc(tbuf_size, GFP_KERNEL);
+	tbuf_size = max_t(u16, sizeof(struct usb_hub_descriptor), wLength);
+	tbuf = kzalloc(tbuf_size, mem_flags);
 	if (!tbuf) {
 		status = -ENOMEM;
 		goto err_alloc;
@@ -839,12 +840,13 @@ static int rh_queue_status (struct usb_hcd *hcd, struct urb *urb)
 	return retval;
 }
 
-static int rh_urb_enqueue (struct usb_hcd *hcd, struct urb *urb)
+static int rh_urb_enqueue(struct usb_hcd *hcd,
+		struct urb *urb, gfp_t mem_flags)
 {
 	if (usb_endpoint_xfer_int(&urb->ep->desc))
 		return rh_queue_status (hcd, urb);
 	if (usb_endpoint_xfer_control(&urb->ep->desc))
-		return rh_call_control (hcd, urb);
+		return rh_call_control(hcd, urb, mem_flags);
 	return -EINVAL;
 }
 
@@ -1549,7 +1551,7 @@ int usb_hcd_submit_urb (struct urb *urb, gfp_t mem_flags)
 	 */
 
 	if (is_root_hub(urb->dev)) {
-		status = rh_urb_enqueue(hcd, urb);
+		status = rh_urb_enqueue(hcd, urb, mem_flags);
 	} else {
 		status = map_urb_for_dma(hcd, urb, mem_flags);
 		if (likely(status == 0)) {
diff --git a/drivers/usb/gadget/udc/goku_udc.c b/drivers/usb/gadget/udc/goku_udc.c
index 3e1267d38774..b9c4adb767ef 100644
--- a/drivers/usb/gadget/udc/goku_udc.c
+++ b/drivers/usb/gadget/udc/goku_udc.c
@@ -1615,7 +1615,8 @@ static irqreturn_t goku_irq(int irq, void *_dev)
 		if (stat & INT_USBRESET) {		/* hub reset done */
 			ACK(INT_USBRESET);
 			INFO(dev, "USB reset done, gadget %s\n",
-				dev->driver->driver.name);
+				dev->driver ? dev->driver->driver.name :
+					      "<not bound>");
 		}
 		// and INT_ERR on some endpoint's crc/bitstuff/... problem
 	}
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index ab12c4bf0ef1..d9bce38d4276 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -72,7 +72,7 @@ config USB_XHCI_HISTB
 config USB_XHCI_MTK
 	tristate "xHCI support for MediaTek SoCs"
 	select MFD_SYSCON
-	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || COMPILE_TEST
+	depends on (MIPS && SOC_MT7621) || ARCH_MEDIATEK || ARCH_AIROHA || COMPILE_TEST
 	help
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in MediaTek SoCs.
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 67804954e146..0e0045a81f92 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -4199,6 +4199,7 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 			 u32 field3, u32 field4, bool command_must_succeed)
 {
 	int reserved_trbs = xhci->cmd_ring_reserved_trbs;
+	struct usb_hcd *hcd = xhci_to_hcd(xhci);
 	int ret;
 
 	if ((xhci->xhc_state & XHCI_STATE_DYING) ||
@@ -4208,6 +4209,11 @@ static int queue_command(struct xhci_hcd *xhci, struct xhci_command *cmd,
 		return -ESHUTDOWN;
 	}
 
+	if (!HCD_HW_ACCESSIBLE(hcd)) {
+		xhci_warn(xhci, "Can't queue command, xHC not accessible\n");
+		return -ESHUTDOWN;
+	}
+
 	if (!command_must_succeed)
 		reserved_trbs++;
 
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 2cc27dba08e2..4d33130f1378 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -1034,6 +1034,10 @@ int xhci_suspend(struct xhci_hcd *xhci, bool do_wakeup)
 	/* step 1: stop endpoint */
 	/* skipped assuming that port suspend has done */
 
+	/* Check if command ring is empty */
+	if (!list_empty(&xhci->cmd_list))
+		xhci_warn(xhci, "Suspending and stopping xHC with pending command!\n");
+
 	/* step 2: clear Run/Stop bit */
 	command = readl(&xhci->op_regs->command);
 	command &= ~CMD_RUN;
diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
index ebc7be1d9820..47768e326896 100644
--- a/drivers/usb/usbip/vhci_sysfs.c
+++ b/drivers/usb/usbip/vhci_sysfs.c
@@ -59,6 +59,29 @@ static void port_show_vhci(char **out, int hub, int port, struct vhci_device *vd
 	*out += sprintf(*out, "\n");
 }
 
+static ssize_t status_show_not_ready(int pdev_nr, char *out)
+{
+	char *s = out;
+	int i = 0;
+
+	for (i = 0; i < VHCI_HC_PORTS; i++) {
+		out += sprintf(out, "hs  %04u %03u ",
+				    (pdev_nr * VHCI_PORTS) + i,
+				    VDEV_ST_NOTASSIGNED);
+		out += sprintf(out, "000 00000000 0000000000000000 0-0");
+		out += sprintf(out, "\n");
+	}
+
+	for (i = 0; i < VHCI_HC_PORTS; i++) {
+		out += sprintf(out, "ss  %04u %03u ",
+				    (pdev_nr * VHCI_PORTS) + VHCI_HC_PORTS + i,
+				    VDEV_ST_NOTASSIGNED);
+		out += sprintf(out, "000 00000000 0000000000000000 0-0");
+		out += sprintf(out, "\n");
+	}
+	return out - s;
+}
+
 /* Sysfs entry to show port status */
 static ssize_t status_show_vhci(int pdev_nr, char *out)
 {
@@ -76,6 +99,12 @@ static ssize_t status_show_vhci(int pdev_nr, char *out)
 	}
 
 	hcd = platform_get_drvdata(pdev);
+
+	if (!hcd) {
+		usbip_dbg_vhci_sysfs("show status error (hcd is NULL)\n");
+		return status_show_not_ready(pdev_nr, out);
+	}
+
 	vhci_hcd = hcd_to_vhci_hcd(hcd);
 	vhci = vhci_hcd->vhci;
 
@@ -104,29 +133,6 @@ static ssize_t status_show_vhci(int pdev_nr, char *out)
 	return out - s;
 }
 
-static ssize_t status_show_not_ready(int pdev_nr, char *out)
-{
-	char *s = out;
-	int i = 0;
-
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
-		out += sprintf(out, "hs  %04u %03u ",
-				    (pdev_nr * VHCI_PORTS) + i,
-				    VDEV_ST_NOTASSIGNED);
-		out += sprintf(out, "000 00000000 0000000000000000 0-0");
-		out += sprintf(out, "\n");
-	}
-
-	for (i = 0; i < VHCI_HC_PORTS; i++) {
-		out += sprintf(out, "ss  %04u %03u ",
-				    (pdev_nr * VHCI_PORTS) + VHCI_HC_PORTS + i,
-				    VDEV_ST_NOTASSIGNED);
-		out += sprintf(out, "000 00000000 0000000000000000 0-0");
-		out += sprintf(out, "\n");
-	}
-	return out - s;
-}
-
 static int status_name_to_id(const char *name)
 {
 	char *c;
diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
index ec9691f6594d..3b15955751fa 100644
--- a/drivers/vhost/scsi.c
+++ b/drivers/vhost/scsi.c
@@ -1937,9 +1937,10 @@ vhost_scsi_ioctl(struct file *f,
 	default:
 		mutex_lock(&vs->dev.mutex);
 		r = vhost_dev_ioctl(&vs->dev, ioctl, argp);
-		/* TODO: flush backend after dev ioctl. */
 		if (r == -ENOIOCTLCMD)
 			r = vhost_vring_ioctl(&vs->dev, ioctl, argp);
+		else
+			vhost_scsi_flush(vs);
 		mutex_unlock(&vs->dev.mutex);
 		return r;
 	}
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index c1fb70f84034..db488b98cc9f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -331,18 +331,14 @@ static long vhost_vdpa_set_config_call(struct vhost_vdpa *v, u32 __user *argp)
 		return  -EFAULT;
 
 	ctx = fd == VHOST_FILE_UNBIND ? NULL : eventfd_ctx_fdget(fd);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
 	swap(ctx, v->config_ctx);
 
-	if (!IS_ERR_OR_NULL(ctx))
+	if (ctx)
 		eventfd_ctx_put(ctx);
 
-	if (IS_ERR(v->config_ctx)) {
-		long ret = PTR_ERR(v->config_ctx);
-
-		v->config_ctx = NULL;
-		return ret;
-	}
-
 	v->vdpa->config->set_config_cb(v->vdpa, &cb);
 
 	return 0;
diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 87b6a929a6b3..d7145a6c7354 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -1706,6 +1706,7 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
  err_exit_both:
 	kfree(info->pixmap.addr);
  err_exit_pixmap:
+	arch_phys_wc_del(default_par->wc_cookie);
 	iounmap(info->screen_base);
 	release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
  err_exit_mmio:
diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 95d3c59867d0..019c6c5c2b10 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -78,6 +78,13 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
 static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma);
 
+static void vfb_destroy(struct fb_info *info)
+{
+	vfree(info->screen_buffer);
+	fb_dealloc_cmap(&info->cmap);
+	framebuffer_release(info);
+}
+
 static const struct fb_ops vfb_ops = {
 	.fb_read        = fb_sys_read,
 	.fb_write       = fb_sys_write,
@@ -89,6 +96,7 @@ static const struct fb_ops vfb_ops = {
 	.fb_copyarea	= sys_copyarea,
 	.fb_imageblit	= sys_imageblit,
 	.fb_mmap	= vfb_mmap,
+	.fb_destroy	= vfb_destroy,
 };
 
     /*
@@ -485,9 +493,6 @@ static int vfb_remove(struct platform_device *dev)
 
 	if (info) {
 		unregister_framebuffer(info);
-		vfree(videomemory);
-		fb_dealloc_cmap(&info->cmap);
-		framebuffer_release(info);
 	}
 	return 0;
 }
diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
index a6f375417fd5..437622cd079f 100644
--- a/drivers/virtio/virtio_pci_common.c
+++ b/drivers/virtio/virtio_pci_common.c
@@ -96,7 +96,9 @@ static irqreturn_t vp_interrupt(int irq, void *opaque)
 	if (isr & VIRTIO_PCI_ISR_CONFIG)
 		vp_config_changed(irq, opaque);
 
-	return vp_vring_interrupt(irq, opaque);
+	vp_vring_interrupt(irq, opaque);
+
+	return IRQ_HANDLED;
 }
 
 static int vp_request_msix_vectors(struct virtio_device *vdev, int nvectors,
diff --git a/drivers/watchdog/digicolor_wdt.c b/drivers/watchdog/digicolor_wdt.c
index 073d37867f47..de1a3267a972 100644
--- a/drivers/watchdog/digicolor_wdt.c
+++ b/drivers/watchdog/digicolor_wdt.c
@@ -25,6 +25,7 @@ struct dc_wdt {
 	void __iomem		*base;
 	struct clk		*clk;
 	spinlock_t		lock;
+	unsigned long		rate;
 };
 
 static unsigned timeout;
@@ -61,7 +62,7 @@ static int dc_wdt_start(struct watchdog_device *wdog)
 {
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
-	dc_wdt_set(wdt, wdog->timeout * clk_get_rate(wdt->clk));
+	dc_wdt_set(wdt, wdog->timeout * wdt->rate);
 
 	return 0;
 }
@@ -79,7 +80,7 @@ static int dc_wdt_set_timeout(struct watchdog_device *wdog, unsigned int t)
 {
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 
-	dc_wdt_set(wdt, t * clk_get_rate(wdt->clk));
+	dc_wdt_set(wdt, t * wdt->rate);
 	wdog->timeout = t;
 
 	return 0;
@@ -90,7 +91,7 @@ static unsigned int dc_wdt_get_timeleft(struct watchdog_device *wdog)
 	struct dc_wdt *wdt = watchdog_get_drvdata(wdog);
 	uint32_t count = readl_relaxed(wdt->base + TIMER_A_COUNT);
 
-	return count / clk_get_rate(wdt->clk);
+	return count / wdt->rate;
 }
 
 static const struct watchdog_ops dc_wdt_ops = {
@@ -130,7 +131,11 @@ static int dc_wdt_probe(struct platform_device *pdev)
 	wdt->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(wdt->clk))
 		return PTR_ERR(wdt->clk);
-	dc_wdt_wdd.max_timeout = U32_MAX / clk_get_rate(wdt->clk);
+
+	wdt->rate = clk_get_rate(wdt->clk);
+	if (!wdt->rate)
+		return -EINVAL;
+	dc_wdt_wdd.max_timeout = U32_MAX / wdt->rate;
 	dc_wdt_wdd.timeout = dc_wdt_wdd.max_timeout;
 	dc_wdt_wdd.parent = dev;
 
diff --git a/drivers/watchdog/sp5100_tco.c b/drivers/watchdog/sp5100_tco.c
index 0db77c90b4b6..e155c6ca92cf 100644
--- a/drivers/watchdog/sp5100_tco.c
+++ b/drivers/watchdog/sp5100_tco.c
@@ -479,8 +479,10 @@ static int __init sp5100_tco_init(void)
 	pr_info("SP5100/SB800 TCO WatchDog Timer Driver\n");
 
 	err = platform_driver_register(&sp5100_tco_driver);
-	if (err)
+	if (err) {
+		pci_dev_put(sp5100_tco_pci);
 		return err;
+	}
 
 	sp5100_tco_platform_device =
 		platform_device_register_simple(TCO_DRIVER_NAME, -1, NULL, 0);
@@ -493,6 +495,7 @@ static int __init sp5100_tco_init(void)
 
 unreg_platform_driver:
 	platform_driver_unregister(&sp5100_tco_driver);
+	pci_dev_put(sp5100_tco_pci);
 	return err;
 }
 
@@ -500,6 +503,7 @@ static void __exit sp5100_tco_exit(void)
 {
 	platform_device_unregister(sp5100_tco_platform_device);
 	platform_driver_unregister(&sp5100_tco_driver);
+	pci_dev_put(sp5100_tco_pci);
 }
 
 module_init(sp5100_tco_init);
diff --git a/drivers/watchdog/sunxi_wdt.c b/drivers/watchdog/sunxi_wdt.c
index b50757882a98..11725ca82eff 100644
--- a/drivers/watchdog/sunxi_wdt.c
+++ b/drivers/watchdog/sunxi_wdt.c
@@ -125,6 +125,38 @@ static int sunxi_wdt_ping(struct watchdog_device *wdt_dev)
 	return 0;
 }
 
+static bool sunxi_wdt_is_running(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
+
+	return readl(sunxi_wdt->wdt_base + regs->wdt_mode) & WDT_MODE_EN;
+}
+
+static unsigned int sunxi_wdt_get_timeout(struct watchdog_device *wdt_dev)
+{
+	struct sunxi_wdt_dev *sunxi_wdt = watchdog_get_drvdata(wdt_dev);
+	const struct sunxi_wdt_reg *regs = sunxi_wdt->wdt_regs;
+	unsigned int timeout;
+	u32 interval;
+
+	interval = readl(sunxi_wdt->wdt_base + regs->wdt_mode);
+	interval >>= regs->wdt_timeout_shift;
+	interval &= WDT_TIMEOUT_MASK;
+	/* Round the 0.5-second interval up to the minimum representable timeout. */
+	if (!interval)
+		return WDT_MIN_TIMEOUT;
+
+	for (timeout = WDT_MIN_TIMEOUT;
+	     timeout < ARRAY_SIZE(wdt_timeout_map); timeout++) {
+		if (wdt_timeout_map[timeout] == interval)
+			return timeout;
+	}
+
+	/* Reserved interval encoding. */
+	return 0;
+}
+
 static int sunxi_wdt_set_timeout(struct watchdog_device *wdt_dev,
 		unsigned int timeout)
 {
@@ -231,6 +263,7 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct sunxi_wdt_dev *sunxi_wdt;
+	unsigned int running_timeout;
 	int err;
 
 	sunxi_wdt = devm_kzalloc(dev, sizeof(*sunxi_wdt), GFP_KERNEL);
@@ -258,7 +291,17 @@ static int sunxi_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&sunxi_wdt->wdt_dev, sunxi_wdt);
 
-	sunxi_wdt_stop(&sunxi_wdt->wdt_dev);
+	if (sunxi_wdt_is_running(&sunxi_wdt->wdt_dev)) {
+		running_timeout = sunxi_wdt_get_timeout(&sunxi_wdt->wdt_dev);
+		if (running_timeout)
+			sunxi_wdt->wdt_dev.timeout = running_timeout;
+
+		err = sunxi_wdt_start(&sunxi_wdt->wdt_dev);
+		if (err)
+			return err;
+
+		set_bit(WDOG_HW_RUNNING, &sunxi_wdt->wdt_dev.status);
+	}
 
 	watchdog_stop_on_reboot(&sunxi_wdt->wdt_dev);
 	err = devm_watchdog_register_device(dev, &sunxi_wdt->wdt_dev);
diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index edb0acd0b832..e95dd0b9b6ba 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -275,6 +275,7 @@ static long gntalloc_ioctl_alloc(struct gntalloc_file_private_data *priv,
 	int rc = 0;
 	struct ioctl_gntalloc_alloc_gref op;
 	uint32_t *gref_ids;
+	unsigned int limit_snapshot;
 
 	pr_debug("%s: priv %p\n", __func__, priv);
 
@@ -283,6 +284,12 @@ static long gntalloc_ioctl_alloc(struct gntalloc_file_private_data *priv,
 		goto out;
 	}
 
+	limit_snapshot = READ_ONCE(limit);
+	if (op.count > limit_snapshot) {
+		rc = -ENOSPC;
+		goto out;
+	}
+
 	gref_ids = kcalloc(op.count, sizeof(gref_ids[0]), GFP_KERNEL);
 	if (!gref_ids) {
 		rc = -ENOMEM;
@@ -295,14 +302,16 @@ static long gntalloc_ioctl_alloc(struct gntalloc_file_private_data *priv,
 	 * are about to enforce, removing them here is a good idea.
 	 */
 	do_cleanup();
-	if (gref_size + op.count > limit) {
+	limit_snapshot = READ_ONCE(limit);
+	if (gref_size > limit_snapshot ||
+	    op.count > limit_snapshot - gref_size) {
 		mutex_unlock(&gref_mutex);
 		rc = -ENOSPC;
 		goto out_free;
 	}
 	gref_size += op.count;
 	op.index = priv->index;
-	priv->index += op.count * PAGE_SIZE;
+	priv->index += (uint64_t)op.count * PAGE_SIZE;
 	mutex_unlock(&gref_mutex);
 
 	rc = add_grefs(&op, gref_ids, priv);
diff --git a/drivers/xen/xen-front-pgdir-shbuf.c b/drivers/xen/xen-front-pgdir-shbuf.c
index 48a658dc7ccf..4d67f91da5b3 100644
--- a/drivers/xen/xen-front-pgdir-shbuf.c
+++ b/drivers/xen/xen-front-pgdir-shbuf.c
@@ -449,8 +449,10 @@ static int grant_references(struct xen_front_pgdir_shbuf *buf)
 		unsigned long frame;
 
 		cur_ref = gnttab_claim_grant_reference(&priv_gref_head);
-		if (cur_ref < 0)
-			return cur_ref;
+		if (cur_ref < 0) {
+			ret = cur_ref;
+			goto out_free_refs;
+		}
 
 		frame = xen_page_to_gfn(virt_to_page(buf->directory +
 						     PAGE_SIZE * i));
@@ -461,11 +463,13 @@ static int grant_references(struct xen_front_pgdir_shbuf *buf)
 	if (buf->ops->grant_refs_for_buffer) {
 		ret = buf->ops->grant_refs_for_buffer(buf, &priv_gref_head, j);
 		if (ret)
-			return ret;
+			goto out_free_refs;
 	}
 
+	ret = 0;
+out_free_refs:
 	gnttab_free_grant_references(priv_gref_head);
-	return 0;
+	return ret;
 }
 
 /**
diff --git a/fs/9p/vfs_dir.c b/fs/9p/vfs_dir.c
index 67438cef1d34..9e0979078719 100644
--- a/fs/9p/vfs_dir.c
+++ b/fs/9p/vfs_dir.c
@@ -30,6 +30,7 @@
  * struct p9_rdir - readdir accounting
  * @head: start offset of current dirread buffer
  * @tail: end offset of current dirread buffer
+ * @offset: file position the data at @head corresponds to
  * @buf: dirread buffer
  *
  * private structure for keeping track of readdir
@@ -39,6 +40,7 @@
 struct p9_rdir {
 	int head;
 	int tail;
+	loff_t offset;
 	uint8_t buf[];
 };
 
@@ -104,6 +106,9 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 	kvec.iov_base = rdir->buf;
 	kvec.iov_len = buflen;
 
+	if (rdir->head < rdir->tail && rdir->offset != ctx->pos)
+		rdir->head = rdir->tail = 0;
+
 	while (1) {
 		if (rdir->tail == rdir->head) {
 			struct iov_iter to;
@@ -118,6 +123,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 
 			rdir->head = 0;
 			rdir->tail = n;
+			rdir->offset = ctx->pos;
 		}
 		while (rdir->head < rdir->tail) {
 			err = p9stat_read(fid->clnt, rdir->buf + rdir->head,
@@ -135,6 +141,7 @@ static int v9fs_dir_readdir(struct file *file, struct dir_context *ctx)
 
 			rdir->head += err;
 			ctx->pos += err;
+			rdir->offset = ctx->pos;
 		}
 	}
 }
@@ -162,6 +169,9 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 	if (!rdir)
 		return -ENOMEM;
 
+	if (rdir->head < rdir->tail && rdir->offset != ctx->pos)
+		rdir->head = rdir->tail = 0;
+
 	while (1) {
 		if (rdir->tail == rdir->head) {
 			err = p9_client_readdir(fid, rdir->buf, buflen,
@@ -171,6 +181,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			rdir->head = 0;
 			rdir->tail = err;
+			rdir->offset = ctx->pos;
 		}
 
 		while (rdir->head < rdir->tail) {
@@ -191,6 +202,7 @@ static int v9fs_dir_readdir_dotl(struct file *file, struct dir_context *ctx)
 
 			ctx->pos = curdirent.d_off;
 			rdir->head += err;
+			rdir->offset = ctx->pos;
 		}
 	}
 }
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index a755bef7c4c7..ccb5c02ecfd4 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -220,11 +220,6 @@ static inline bool affs_validblock(struct super_block *sb, int block)
 	       block < AFFS_SB(sb)->s_partition_size);
 }
 
-static inline void
-affs_set_blocksize(struct super_block *sb, int size)
-{
-	sb_set_blocksize(sb, size);
-}
 static inline struct buffer_head *
 affs_bread(struct super_block *sb, int block)
 {
diff --git a/fs/affs/super.c b/fs/affs/super.c
index c6c2a513ec92..a7073d814e15 100644
--- a/fs/affs/super.c
+++ b/fs/affs/super.c
@@ -392,7 +392,8 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 	size = i_size_read(sb->s_bdev->bd_inode) >> 9;
 	pr_debug("initial blocksize=%d, #blocks=%d\n", 512, size);
 
-	affs_set_blocksize(sb, PAGE_SIZE);
+	if (!sb_set_blocksize(sb, PAGE_SIZE))
+		return -EINVAL;
 	/* Try to find root block. Its location depends on the block size. */
 
 	i = bdev_logical_block_size(sb->s_bdev);
@@ -407,7 +408,8 @@ static int affs_fill_super(struct super_block *sb, void *data, int silent)
 		if (root_block < 0)
 			sbi->s_root_block = (reserved + size - 1) / 2;
 		pr_debug("setting blocksize to %d\n", blocksize);
-		affs_set_blocksize(sb, blocksize);
+		if (!sb_set_blocksize(sb, blocksize))
+			return -EINVAL;
 		sbi->s_partition_size = size;
 
 		/* The root block location that was calculated above is not
diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 9edf243713eb..94870bdb4cb2 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -49,6 +49,10 @@ void autofs_kill_sb(struct super_block *sb)
 	if (sbi) {
 		/* Free wait queues, close pipe */
 		autofs_catatonic_mode(sbi);
+		if (sbi->pipe) {
+			fput(sbi->pipe);
+			sbi->pipe = NULL;
+		}
 		put_pid(sbi->oz_pgrp);
 	}
 
diff --git a/fs/befs/linuxvfs.c b/fs/befs/linuxvfs.c
index c1ba13d19024..0d12000e20b9 100644
--- a/fs/befs/linuxvfs.c
+++ b/fs/befs/linuxvfs.c
@@ -891,7 +891,8 @@ befs_fill_super(struct super_block *sb, void *data, int silent)
 	 */
 	sb->s_magic = BEFS_SUPER_MAGIC;
 	/* Set real blocksize of fs */
-	sb_set_blocksize(sb, (ulong) befs_sb->block_size);
+	if (!sb_set_blocksize(sb, (ulong) befs_sb->block_size))
+		goto unacquire_priv_sbp;
 	sb->s_op = &befs_sops;
 	sb->s_export_op = &befs_export_operations;
 	sb->s_time_min = 0;
diff --git a/fs/bfs/inode.c b/fs/bfs/inode.c
index fa4e00292585..56f6bca4246f 100644
--- a/fs/bfs/inode.c
+++ b/fs/bfs/inode.c
@@ -343,7 +343,8 @@ static int bfs_fill_super(struct super_block *s, void *data, int silent)
 	s->s_time_min = 0;
 	s->s_time_max = U32_MAX;
 
-	sb_set_blocksize(s, BFS_BSIZE);
+	if (!sb_set_blocksize(s, BFS_BSIZE))
+		goto out;
 
 	sbh = sb_bread(s, 0);
 	if (!sbh)
diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 5b921e6ed94e..34be7160cc9c 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -1600,6 +1600,17 @@ static void insert_dirty_subvol(struct btrfs_trans_handle *trans,
 	}
 }
 
+static void clear_reloc_root(struct btrfs_root *root)
+{
+	root->reloc_root = NULL;
+	/*
+	 * Need barrier to ensure clear_bit() only happens after
+	 * root->reloc_root = NULL. Pairs with have_reloc_root().
+	 */
+	smp_wmb();
+	clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+}
+
 static int clean_dirty_subvols(struct reloc_control *rc)
 {
 	struct btrfs_root *root;
@@ -1614,13 +1625,7 @@ static int clean_dirty_subvols(struct reloc_control *rc)
 			struct btrfs_root *reloc_root = root->reloc_root;
 
 			list_del_init(&root->reloc_dirty_list);
-			root->reloc_root = NULL;
-			/*
-			 * Need barrier to ensure clear_bit() only happens after
-			 * root->reloc_root = NULL. Pairs with have_reloc_root.
-			 */
-			smp_wmb();
-			clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE, &root->state);
+			clear_reloc_root(root);
 			if (reloc_root) {
 				/*
 				 * btrfs_drop_snapshot drops our ref we hold for
@@ -1940,21 +1945,39 @@ void merge_reloc_roots(struct reloc_control *rc)
 			BUG_ON(IS_ERR(root));
 			BUG_ON(root->reloc_root != reloc_root);
 			ret = merge_reloc_root(rc, root);
-			btrfs_put_root(root);
 			if (ret) {
-				if (list_empty(&reloc_root->root_list))
+				/*
+				 * Clear the reloc root since below we will call
+				 * free_reloc_roots(), otherwise we leave
+				 * root->reloc_root pointing to a freed reloc
+				 * root and trigger a use-after-free during
+				 * unmount or elsewhere.
+				 */
+				clear_reloc_root(root);
+				btrfs_put_root(root);
+				/*
+				 * We are adding the reloc_root to the local
+				 * reloc_roots list, so we add a ref for this
+				 * list which will be dropped below by the call
+				 * to free_reloc_roots().
+				 */
+				if (list_empty(&reloc_root->root_list)) {
 					list_add_tail(&reloc_root->root_list,
 						      &reloc_roots);
+					btrfs_grab_root(reloc_root);
+				}
+				/* Now drop the ref for root->reloc_root. */
+				btrfs_put_root(reloc_root);
 				goto out;
 			}
+			btrfs_put_root(root);
 		} else {
 			if (!IS_ERR(root)) {
 				if (root->reloc_root == reloc_root) {
-					root->reloc_root = NULL;
+					clear_reloc_root(root);
+					/* Drop the ref for root->reloc_root. */
 					btrfs_put_root(reloc_root);
 				}
-				clear_bit(BTRFS_ROOT_DEAD_RELOC_TREE,
-					  &root->state);
 				btrfs_put_root(root);
 			}
 
diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index f9b27cf776c9..e5ff67abe91b 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -404,6 +404,7 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 			       int force)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
+	int ret = 0;
 
 	if ((test_bit(BTRFS_ROOT_SHAREABLE, &root->state) &&
 	    root->last_trans < trans->transid) || force) {
@@ -451,12 +452,23 @@ static int record_root_in_trans(struct btrfs_trans_handle *trans,
 		 * through btrfs_record_root_in_trans without having to take the
 		 * lock.  smp_wmb() makes sure that all the writes above are
 		 * done before we pop in the zero below
+		 *
+		 * If @force is true, it means the call is from
+		 * qgroup_account_snapshot(), which only requires radix tree
+		 * tracking.
+		 * We should not force reloc root creation here, as the root
+		 * may have already been modified, and in that case
+		 * root->commit_root has already been dropped.
+		 *
+		 * Using that commit root will cause the reloc root to refer
+		 * to a deleted extent, causing extent tree corruption.
 		 */
-		btrfs_init_reloc_root(trans, root);
+		if (!force)
+			ret = btrfs_init_reloc_root(trans, root);
 		smp_mb__before_atomic();
 		clear_bit(BTRFS_ROOT_IN_TRANS_SETUP, &root->state);
 	}
-	return 0;
+	return ret;
 }
 
 
diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
index dd27fdb9521a..48f8172bb15f 100644
--- a/fs/btrfs/tree-checker.c
+++ b/fs/btrfs/tree-checker.c
@@ -1608,7 +1608,7 @@ static int check_dev_extent_item(const struct extent_buffer *leaf,
 				 sectorsize))) {
 		generic_err(leaf, slot,
 			    "invalid dev extent chunk offset, has %llu not aligned to %u",
-			    btrfs_dev_extent_chunk_objectid(leaf, de),
+			    btrfs_dev_extent_chunk_offset(leaf, de),
 			    sectorsize);
 		return -EUCLEAN;
 	}
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index da77493f4c17..a36a816696f5 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2821,6 +2821,8 @@ int btrfs_init_new_device(struct btrfs_fs_info *fs_info, const char *device_path
 	btrfs_sysfs_remove_device(device);
 	mutex_lock(&fs_info->fs_devices->device_list_mutex);
 	mutex_lock(&fs_info->chunk_mutex);
+	if (!list_empty(&device->post_commit_list))
+		list_del_init(&device->post_commit_list);
 	list_del_rcu(&device->dev_list);
 	list_del(&device->dev_alloc_list);
 	fs_info->fs_devices->num_devices--;
@@ -3296,7 +3298,11 @@ static int btrfs_may_alloc_data_chunk(struct btrfs_fs_info *fs_info,
 	u64 chunk_type;
 
 	cache = btrfs_lookup_block_group(fs_info, chunk_offset);
-	ASSERT(cache);
+	if (unlikely(!cache)) {
+		btrfs_err(fs_info, "balance: chunk at bytenr %llu has no corresponding block group",
+			  chunk_offset);
+		return -EUCLEAN;
+	}
 	chunk_type = cache->flags;
 	btrfs_put_block_group(cache);
 
diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index c8a0a2edc650..d7f08116c4d5 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -76,6 +76,9 @@ cifs_idmap_key_instantiate(struct key *key, struct key_preparsed_payload *prep)
 {
 	char *payload;
 
+	if (prep->datalen > U16_MAX)
+		return -EINVAL;
+
 	/*
 	 * If the payload is less than or equal to the size of a pointer, then
 	 * an allocation here is wasteful. Just copy the data directly to the
diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index ef86e4510c1c..e2134e51108e 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1083,15 +1083,12 @@ static int configfs_dump(struct configfs_dirent *sd, int level)
  * much on the stack, though, so folks that need this function - be careful
  * about your stack!  Patches will be accepted to make it iterative.
  */
-static int configfs_depend_prep(struct dentry *origin,
+static int configfs_depend_prep(struct configfs_dirent *sd,
 				struct config_item *target)
 {
-	struct configfs_dirent *child_sd, *sd;
+	struct configfs_dirent *child_sd;
 	int ret = 0;
 
-	BUG_ON(!origin || !origin->d_fsdata);
-	sd = origin->d_fsdata;
-
 	if (sd->s_element == target)  /* Boo-yah */
 		goto out;
 
@@ -1099,8 +1096,7 @@ static int configfs_depend_prep(struct dentry *origin,
 		if ((child_sd->s_type & CONFIGFS_DIR) &&
 		    !(child_sd->s_type & CONFIGFS_USET_DROPPING) &&
 		    !(child_sd->s_type & CONFIGFS_USET_CREATING)) {
-			ret = configfs_depend_prep(child_sd->s_dentry,
-						   target);
+			ret = configfs_depend_prep(child_sd, target);
 			if (!ret)
 				goto out;  /* Child path boo-yah */
 		}
@@ -1121,7 +1117,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
 
 	spin_lock(&configfs_dirent_lock);
 	/* Scan the tree, return 0 if found */
-	ret = configfs_depend_prep(subsys_dentry, target);
+	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
 	if (ret)
 		goto out_unlock_dirent_lock;
 
diff --git a/fs/exec.c b/fs/exec.c
index 9796ba95e3ea..a2f72a503b7a 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1267,6 +1267,20 @@ int begin_new_exec(struct linux_binprm * bprm)
 	if (retval)
 		goto out;
 
+	/*
+	 * We have to apply CLOEXEC before we change whether the process is
+	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
+	 * trying to access the should-be-closed file descriptors of a process
+	 * undergoing exec(2).
+	 *
+	 * This can block on filesystem ->flush() handlers, including waiting
+	 * for FUSE daemons, so do it before exec_mmap takes the
+	 * exec_update_lock.
+	 * This must happen after the point of no return, and after unsharing
+	 * the FD table.
+	 */
+	do_close_on_exec(me->files);
+
 	/*
 	 * Must be called _before_ exec_mmap() as bprm->mm is
 	 * not visibile until then. This also enables the update
@@ -1315,14 +1329,6 @@ int begin_new_exec(struct linux_binprm * bprm)
 	flush_thread();
 	me->personality &= ~bprm->per_clear;
 
-	/*
-	 * We have to apply CLOEXEC before we change whether the process is
-	 * dumpable (in setup_new_exec) to avoid a race with a process in userspace
-	 * trying to access the should-be-closed file descriptors of a process
-	 * undergoing exec(2).
-	 */
-	do_close_on_exec(me->files);
-
 	if (bprm->secureexec) {
 		/* Make sure parent cannot signal privileged process. */
 		me->pdeath_signal = 0;
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 8cd6383be332..5393190f9d1e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -478,6 +478,12 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 			bit_pos++;
 			continue;
 		}
+		if (unlikely(le16_to_cpu(de->name_len) > F2FS_NAME_LEN ||
+			     bit_pos + GET_DENTRY_SLOTS(le16_to_cpu(de->name_len)) >
+			     d.max)) {
+			err = -EFSCORRUPTED;
+			goto punch_dentry_pages;
+		}
 
 		/*
 		 * We only need the disk_name and hash to move the dentry.
@@ -498,6 +504,7 @@ static int f2fs_add_inline_entries(struct inode *dir, void *inline_dentry)
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 	}
 	return 0;
+
 punch_dentry_pages:
 	truncate_inode_pages(&dir->i_data, 0);
 	f2fs_truncate_blocks(dir, 0, false);
diff --git a/fs/freevxfs/vxfs_bmap.c b/fs/freevxfs/vxfs_bmap.c
index 1fd41cf98b9f..6e032ae15513 100644
--- a/fs/freevxfs/vxfs_bmap.c
+++ b/fs/freevxfs/vxfs_bmap.c
@@ -251,7 +251,8 @@ vxfs_bmap_typed(struct inode *ip, long iblock)
 			return 0;
 		}
 		default:
-			BUG();
+			WARN_ON_ONCE(1);
+			return 0;
 		}
 	}
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a8c080b485d0..956c01a42d31 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2570,8 +2570,9 @@ static int fuse_file_flock(struct file *file, int cmd, struct file_lock *fl)
 		struct fuse_file *ff = file->private_data;
 
 		/* emulate flock with POSIX locks */
-		ff->flock = true;
 		err = fuse_setlk(file, fl, 1);
+		if (!err)
+			ff->flock = true;
 	}
 
 	return err;
diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index d365bf0b8c77..41e09f209f74 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -222,7 +222,6 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 {
 	struct super_block *sb;
 	struct hfs_find_data fd;
-	struct hfs_readdir_data *rd;
 	int res, type;
 
 	hfs_dbg(CAT_MOD, "delete_cat: %s,%u\n", str ? str->name : NULL, cnid);
@@ -248,14 +247,6 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 		}
 	}
 
-	/* we only need to take spinlock for exclusion with ->release() */
-	spin_lock(&HFS_I(dir)->open_dir_lock);
-	list_for_each_entry(rd, &HFS_I(dir)->open_dir_list, list) {
-		if (fd.tree->keycmp(fd.search_key, (void *)&rd->key) < 0)
-			rd->file->f_pos--;
-	}
-	spin_unlock(&HFS_I(dir)->open_dir_lock);
-
 	res = hfs_brec_remove(&fd);
 	if (res)
 		goto out;
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index 3bf2ae0e467c..950551e38bef 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -97,7 +97,15 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (ctx->pos >= inode->i_size)
 		goto out;
-	err = hfs_brec_goto(&fd, ctx->pos - 1);
+	rd = file->private_data;
+	if (rd && rd->pos == ctx->pos) {
+		memcpy(fd.search_key, &rd->key, sizeof(struct hfs_cat_key));
+		err = hfs_brec_find(&fd);
+		if (err == -ENOENT)
+			err = hfs_brec_goto(&fd, 1);
+	} else {
+		err = hfs_brec_goto(&fd, ctx->pos - 1);
+	}
 	if (err)
 		goto out;
 
@@ -146,7 +154,6 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 		if (err)
 			goto out;
 	}
-	rd = file->private_data;
 	if (!rd) {
 		rd = kmalloc(sizeof(struct hfs_readdir_data), GFP_KERNEL);
 		if (!rd) {
@@ -154,15 +161,8 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		file->private_data = rd;
-		rd->file = file;
-		spin_lock(&HFS_I(inode)->open_dir_lock);
-		list_add(&rd->list, &HFS_I(inode)->open_dir_list);
-		spin_unlock(&HFS_I(inode)->open_dir_lock);
 	}
-	/*
-	 * Can be done after the list insertion; exclusion with
-	 * hfs_delete_cat() is provided by directory lock.
-	 */
+	rd->pos = ctx->pos;
 	memcpy(&rd->key, &fd.key->cat, sizeof(struct hfs_cat_key));
 out:
 	hfs_find_exit(&fd);
@@ -171,13 +171,7 @@ static int hfs_readdir(struct file *file, struct dir_context *ctx)
 
 static int hfs_dir_release(struct inode *inode, struct file *file)
 {
-	struct hfs_readdir_data *rd = file->private_data;
-	if (rd) {
-		spin_lock(&HFS_I(inode)->open_dir_lock);
-		list_del(&rd->list);
-		spin_unlock(&HFS_I(inode)->open_dir_lock);
-		kfree(rd);
-	}
+	kfree(file->private_data);
 	return 0;
 }
 
diff --git a/fs/hfs/hfs.h b/fs/hfs/hfs.h
index 6f194d0768b6..f46d12ce04a3 100644
--- a/fs/hfs/hfs.h
+++ b/fs/hfs/hfs.h
@@ -281,8 +281,7 @@ struct hfs_mdb {
 /*======== Data structures kept in memory ========*/
 
 struct hfs_readdir_data {
-	struct list_head list;
-	struct file *file;
+	loff_t pos;
 	struct hfs_cat_key key;
 };
 
diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
index ea0508c7bc84..25c189a3b22b 100644
--- a/fs/hfs/hfs_fs.h
+++ b/fs/hfs/hfs_fs.h
@@ -68,8 +68,6 @@ struct hfs_inode_info {
 
 	struct hfs_cat_key cat_key;
 
-	struct list_head open_dir_list;
-	spinlock_t open_dir_lock;
 	struct inode *rsrc_inode;
 
 	struct mutex extents_lock;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index e5c866b10d31..b6809766fde7 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -188,8 +188,6 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 		return NULL;
 
 	mutex_init(&HFS_I(inode)->extents_lock);
-	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
-	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 	hfs_cat_build_key(sb, (btree_key *)&HFS_I(inode)->cat_key, dir->i_ino, name);
 	inode->i_ino = HFS_SB(sb)->next_id++;
 	inode->i_mode = mode;
@@ -323,8 +321,6 @@ static int hfs_read_inode(struct inode *inode, void *data)
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	mutex_init(&HFS_I(inode)->extents_lock);
-	INIT_LIST_HEAD(&HFS_I(inode)->open_dir_list);
-	spin_lock_init(&HFS_I(inode)->open_dir_lock);
 
 	/* Initialize the inode */
 	inode->i_uid = hsb->s_uid;
diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
index 9a82bdf4caf2..2db185c67b2c 100644
--- a/fs/hfsplus/catalog.c
+++ b/fs/hfsplus/catalog.c
@@ -332,7 +332,6 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 	struct super_block *sb = dir->i_sb;
 	struct hfs_find_data fd;
 	struct hfsplus_fork_raw fork;
-	struct list_head *pos;
 	int err, off;
 	u16 type;
 
@@ -390,16 +389,6 @@ int hfsplus_delete_cat(u32 cnid, struct inode *dir, const struct qstr *str)
 		hfsplus_free_fork(sb, cnid, &fork, HFSPLUS_TYPE_RSRC);
 	}
 
-	/* we only need to take spinlock for exclusion with ->release() */
-	spin_lock(&HFSPLUS_I(dir)->open_dir_lock);
-	list_for_each(pos, &HFSPLUS_I(dir)->open_dir_list) {
-		struct hfsplus_readdir_data *rd =
-			list_entry(pos, struct hfsplus_readdir_data, list);
-		if (fd.tree->keycmp(fd.search_key, (void *)&rd->key) < 0)
-			rd->file->f_pos--;
-	}
-	spin_unlock(&HFSPLUS_I(dir)->open_dir_lock);
-
 	err = hfs_brec_remove(&fd);
 	if (err)
 		goto out;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index e74662198185..4f3ef53b95d9 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -185,7 +185,15 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 	}
 	if (ctx->pos >= inode->i_size)
 		goto out;
-	err = hfs_brec_goto(&fd, ctx->pos - 1);
+	rd = file->private_data;
+	if (rd && rd->pos == ctx->pos) {
+		memcpy(fd.search_key, &rd->key, sizeof(struct hfsplus_cat_key));
+		err = hfs_brec_find(&fd, hfs_find_rec_by_key);
+		if (err == -ENOENT)
+			err = hfs_brec_goto(&fd, 1);
+	} else {
+		err = hfs_brec_goto(&fd, ctx->pos - 1);
+	}
 	if (err)
 		goto out;
 	for (;;) {
@@ -261,7 +269,6 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 		if (err)
 			goto out;
 	}
-	rd = file->private_data;
 	if (!rd) {
 		rd = kmalloc(sizeof(struct hfsplus_readdir_data), GFP_KERNEL);
 		if (!rd) {
@@ -269,15 +276,8 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 			goto out;
 		}
 		file->private_data = rd;
-		rd->file = file;
-		spin_lock(&HFSPLUS_I(inode)->open_dir_lock);
-		list_add(&rd->list, &HFSPLUS_I(inode)->open_dir_list);
-		spin_unlock(&HFSPLUS_I(inode)->open_dir_lock);
 	}
-	/*
-	 * Can be done after the list insertion; exclusion with
-	 * hfsplus_delete_cat() is provided by directory lock.
-	 */
+	rd->pos = ctx->pos;
 	memcpy(&rd->key, fd.key, sizeof(struct hfsplus_cat_key));
 out:
 	kfree(strbuf);
@@ -287,13 +287,7 @@ static int hfsplus_readdir(struct file *file, struct dir_context *ctx)
 
 static int hfsplus_dir_release(struct inode *inode, struct file *file)
 {
-	struct hfsplus_readdir_data *rd = file->private_data;
-	if (rd) {
-		spin_lock(&HFSPLUS_I(inode)->open_dir_lock);
-		list_del(&rd->list);
-		spin_unlock(&HFSPLUS_I(inode)->open_dir_lock);
-		kfree(rd);
-	}
+	kfree(file->private_data);
 	return 0;
 }
 
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 489208819e72..ae4e8f304116 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -246,8 +246,6 @@ struct hfsplus_inode_info {
 	sector_t fs_blocks;
 	u8 userflags;		/* BSD user file flags */
 	u32 subfolders;		/* Subfolder count (HFSX only) */
-	struct list_head open_dir_list;
-	spinlock_t open_dir_lock;
 	loff_t phys_size;
 
 	struct inode vfs_inode;
@@ -297,8 +295,7 @@ struct hfs_find_data {
 };
 
 struct hfsplus_readdir_data {
-	struct list_head list;
-	struct file *file;
+	loff_t pos;
 	struct hfsplus_cat_key key;
 };
 
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 57123b206877..e708f94bb52d 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -128,9 +128,44 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	struct file *file = iocb->ki_filp;
 	struct address_space *mapping = file->f_mapping;
 	struct inode *inode = mapping->host;
+	loff_t isize;
 	size_t count = iov_iter_count(iter);
+	loff_t end = iocb->ki_pos + count;
 	ssize_t ret;
 
+	/*
+	 * The hfsplus_get_block() only allows creating the next sequential block.
+	 * For direct writes beyond EOF, expand the file first.
+	 */
+	if (iov_iter_rw(iter) == WRITE && iocb->ki_pos > i_size_read(inode)) {
+		loff_t start_off, end_off;
+		loff_t start_page, end_page;
+
+		isize = i_size_read(inode);
+
+		/*
+		 * Wait for any in-flight DIO on this inode to finish before
+		 * calling generic_cont_expand_simple().
+		 */
+		inode_dio_wait(inode);
+
+		ret = generic_cont_expand_simple(inode, iocb->ki_pos);
+		if (ret)
+			return ret;
+
+		start_off = isize;
+		end_off = (end > 0) ? end - 1 : end;
+
+		ret = filemap_write_and_wait_range(mapping, start_off, end_off);
+		if (ret)
+			return ret;
+
+		start_page = start_off >> PAGE_SHIFT;
+		end_page = end_off >> PAGE_SHIFT;
+
+		invalidate_inode_pages2_range(mapping, start_page, end_page);
+	}
+
 	ret = blockdev_direct_IO(iocb, inode, iter, hfsplus_get_block);
 
 	/*
@@ -138,8 +173,7 @@ static ssize_t hfsplus_direct_IO(struct kiocb *iocb, struct iov_iter *iter)
 	 * blocks outside i_size. Trim these off again.
 	 */
 	if (unlikely(iov_iter_rw(iter) == WRITE && ret < 0)) {
-		loff_t isize = i_size_read(inode);
-		loff_t end = iocb->ki_pos + count;
+		isize = i_size_read(inode);
 
 		if (end > isize)
 			hfsplus_write_failed(mapping, end);
@@ -401,8 +435,6 @@ struct inode *hfsplus_new_inode(struct super_block *sb, struct inode *dir,
 	inode->i_mtime = inode->i_atime = inode->i_ctime = current_time(inode);
 
 	hip = HFSPLUS_I(inode);
-	INIT_LIST_HEAD(&hip->open_dir_list);
-	spin_lock_init(&hip->open_dir_lock);
 	mutex_init(&hip->extents_lock);
 	atomic_set(&hip->opencnt, 0);
 	hip->extent_state = 0;
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index fdc07f67d4d3..413fd61daf3f 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -90,8 +90,6 @@ struct inode *hfsplus_iget(struct super_block *sb, unsigned long ino)
 	HFSPLUS_I(inode)->fs_blocks = 0;
 	HFSPLUS_I(inode)->userflags = 0;
 	HFSPLUS_I(inode)->subfolders = 0;
-	INIT_LIST_HEAD(&HFSPLUS_I(inode)->open_dir_list);
-	spin_lock_init(&HFSPLUS_I(inode)->open_dir_lock);
 	HFSPLUS_I(inode)->phys_size = 0;
 
 	if (inode->i_ino >= HFSPLUS_FIRSTUSER_CNID ||
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index a7dbfc892022..a7c1f3ed0459 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -584,7 +584,8 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 	}
 
 	/*sbi->sb_mounting = 1;*/
-	sb_set_blocksize(s, 512);
+	if (!sb_set_blocksize(s, 512))
+		goto bail0;
 	sbi->sb_fs_size = -1;
 	if (!(bootblock = hpfs_map_sector(s, 0, &bh0, 0))) goto bail1;
 	if (!(superblock = hpfs_map_sector(s, 16, &bh1, 1))) goto bail2;
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5ad3bf906b35..d0a141816f12 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1434,7 +1434,7 @@ iomap_writepage_map(struct iomap_writepage_ctx *wpc,
 	if (!count)
 		end_page_writeback(page);
 done:
-	mapping_set_error(page->mapping, error);
+	mapping_set_error(inode->i_mapping, error);
 	return error;
 }
 
diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index a5385b91275f..eb905f8d6c48 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -858,7 +858,8 @@ static int isofs_fill_super(struct super_block *s, void *data, int silent)
 	 * entries.  By forcing the blocksize in this way, we ensure
 	 * that we will never be required to do this.
 	 */
-	sb_set_blocksize(s, orig_zonesize);
+	if (!sb_set_blocksize(s, orig_zonesize))
+		goto out_freesbi;
 
 	sbi->s_nls_iocharset = NULL;
 
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index b2dc4d1f9dcc..3cd344c649cc 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -529,7 +529,8 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	/*
 	 * Initialize blocksize to 4K.
 	 */
-	sb_set_blocksize(sb, PSIZE);
+	if (!sb_set_blocksize(sb, PSIZE))
+		goto out_unload;
 
 	/*
 	 * Set method vectors.
diff --git a/fs/minix/inode.c b/fs/minix/inode.c
index 5b2056d00121..2b4ef99cd6db 100644
--- a/fs/minix/inode.c
+++ b/fs/minix/inode.c
@@ -270,7 +270,8 @@ static int minix_fill_super(struct super_block *s, void *data, int silent)
 		sbi->s_namelen = 60;
 		sbi->s_version = MINIX_V3;
 		sbi->s_mount_state = MINIX_VALID_FS;
-		sb_set_blocksize(s, m3s->s_blocksize);
+		if (!sb_set_blocksize(s, m3s->s_blocksize))
+			goto out;
 		s->s_max_links = MINIX2_LINK_MAX;
 	} else
 		goto out_no_fs;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index db6ea2ebc968..118e368ec76b 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -332,13 +332,8 @@ static int ocfs2_mknod(struct inode *dir,
 		goto leave;
 
 	/* calculate meta data/clusters for setting security and acl xattr */
-	status = ocfs2_calc_xattr_init(dir, mode, &si, &want_clusters,
-				       &xattr_credits, &want_meta,
-				       &acl_state);
-	if (status < 0) {
-		mlog_errno(status);
-		goto leave;
-	}
+	ocfs2_calc_xattr_init(dir, mode, &si, &want_clusters, &xattr_credits,
+			      &want_meta, &acl_state);
 
 	/* Reserve a cluster if creating an extent based directory. */
 	if (S_ISDIR(mode) && !ocfs2_supports_inline_data(osb)) {
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 967a21022513..0f8fdb29d53b 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -613,12 +613,11 @@ int ocfs2_calc_security_init(struct inode *dir,
 	return ret;
 }
 
-int ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
-			  struct ocfs2_security_xattr_info *si,
-			  int *want_clusters, int *xattr_credits,
-			  int *want_meta, struct ocfs2_acl_state *acl_state)
+void ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
+			   struct ocfs2_security_xattr_info *si,
+			   int *want_clusters, int *xattr_credits,
+			   int *want_meta, struct ocfs2_acl_state *acl_state)
 {
-	int ret = 0;
 	struct ocfs2_super *osb = OCFS2_SB(dir->i_sb);
 	int s_size = 0, a_size = 0, acl_len = 0, new_clusters;
 
@@ -640,7 +639,7 @@ int ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
 	}
 
 	if (!(s_size + a_size))
-		return ret;
+		return;
 
 	/*
 	 * The max space of security xattr taken inline is
@@ -706,8 +705,6 @@ int ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
 			}
 		}
 	}
-
-	return ret;
 }
 
 static int ocfs2_xattr_extend_allocation(struct inode *inode,
diff --git a/fs/ocfs2/xattr.h b/fs/ocfs2/xattr.h
index e3e2476efe1a..c78bf7e99f1e 100644
--- a/fs/ocfs2/xattr.h
+++ b/fs/ocfs2/xattr.h
@@ -59,10 +59,10 @@ int ocfs2_calc_security_init(struct inode *,
 			     int *, int *, struct ocfs2_alloc_context **);
 
 struct ocfs2_acl_state;
-int ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
-			  struct ocfs2_security_xattr_info *si,
-			  int *want_clusters, int *xattr_credits,
-			  int *want_meta, struct ocfs2_acl_state *acl_state);
+void ocfs2_calc_xattr_init(struct inode *dir, umode_t mode,
+			   struct ocfs2_security_xattr_info *si,
+			   int *want_clusters, int *xattr_credits,
+			   int *want_meta, struct ocfs2_acl_state *acl_state);
 
 /*
  * xattrs can live inside an inode, as part of an external xattr block,
diff --git a/fs/omfs/inode.c b/fs/omfs/inode.c
index 5abd152406f5..01f8e6f16207 100644
--- a/fs/omfs/inode.c
+++ b/fs/omfs/inode.c
@@ -480,7 +480,8 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_time_min = 0;
 	sb->s_time_max = U64_MAX / MSEC_PER_SEC;
 
-	sb_set_blocksize(sb, 0x200);
+	if (!sb_set_blocksize(sb, 0x200))
+		goto end;
 
 	bh = sb_bread(sb, 0);
 	if (!bh)
@@ -532,7 +533,8 @@ static int omfs_fill_super(struct super_block *sb, void *data, int silent)
 	 * Use sys_blocksize as the fs block since it is smaller than a
 	 * page while the fs blocksize can be larger.
 	 */
-	sb_set_blocksize(sb, sbi->s_sys_blocksize);
+	if (!sb_set_blocksize(sb, sbi->s_sys_blocksize))
+		goto out_brelse_bh;
 
 	/*
 	 * ...and the difference goes into a shift.  sys_blocksize is always
diff --git a/fs/qnx4/inode.c b/fs/qnx4/inode.c
index 3fb7fc819b4f..73eeb22d0f50 100644
--- a/fs/qnx4/inode.c
+++ b/fs/qnx4/inode.c
@@ -195,7 +195,8 @@ static int qnx4_fill_super(struct super_block *s, void *data, int silent)
 		return -ENOMEM;
 	s->s_fs_info = qs;
 
-	sb_set_blocksize(s, QNX4_BLOCK_SIZE);
+	if (!sb_set_blocksize(s, QNX4_BLOCK_SIZE))
+		return -EINVAL;
 
 	s->s_op = &qnx4_sops;
 	s->s_magic = QNX4_SUPER_MAGIC;
diff --git a/fs/squashfs/xz_wrapper.c b/fs/squashfs/xz_wrapper.c
index e80419aed862..b787d49a11b8 100644
--- a/fs/squashfs/xz_wrapper.c
+++ b/fs/squashfs/xz_wrapper.c
@@ -57,10 +57,10 @@ static void *squashfs_xz_comp_opts(struct squashfs_sb_info *msblk,
 
 		opts->dict_size = le32_to_cpu(comp_opts->dictionary_size);
 
-		/* the dictionary size should be 2^n or 2^n+2^(n+1) */
+		/* the dictionary size should be positive and 2^n or 2^n+2^(n+1) */
 		n = ffs(opts->dict_size) - 1;
-		if (opts->dict_size != (1 << n) && opts->dict_size != (1 << n) +
-						(1 << (n + 1))) {
+		if (opts->dict_size <= 0 || (opts->dict_size != (1 << n) &&
+			opts->dict_size != (1 << n) + (1 << (n + 1)))) {
 			err = -EIO;
 			goto out;
 		}
diff --git a/fs/ufs/cylinder.c b/fs/ufs/cylinder.c
index 1abe5454de47..5781c7db9727 100644
--- a/fs/ufs/cylinder.c
+++ b/fs/ufs/cylinder.c
@@ -66,6 +66,16 @@ static void ufs_read_cylinder (struct super_block * sb,
 	ucpi->c_clustersumoff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clustersumoff);
 	ucpi->c_clusteroff = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_clusteroff);
 	ucpi->c_nclusterblks = fs32_to_cpu(sb, ucg->cg_u.cg_44.cg_nclusterblks);
+
+	/* these on-disk values become array and bitmap indices */
+	if (ucpi->c_cgx != cgno ||
+	    ucpi->c_rotor >= uspi->s_fpg ||
+	    ucpi->c_frotor >= uspi->s_fpg ||
+	    ucpi->c_irotor >= uspi->s_ipg) {
+		ufs_error(sb, __func__,
+			  "inconsistent metadata in cylinder group %u\n", cgno);
+		goto failed;
+	}
 	UFSD("EXIT\n");
 	return;	
 	
diff --git a/fs/ufs/super.c b/fs/ufs/super.c
index 983558b572c7..911f0252d469 100644
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -1269,6 +1269,15 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_maxbytes = ufs_max_bytes(sb);
 	sb->s_max_links = UFS_LINK_MAX;
 
+	ufs_setup_cstotal(sb);
+	/*
+	 * Read cylinder group structures
+	 */
+	if (!sb_rdonly(sb))
+		if (!ufs_read_cylinder_structures(sb))
+			goto failed;
+
+	/* create the root dentry last, once UFS_SB(sb) is fully set up */
 	inode = ufs_iget(sb, UFS_ROOTINO);
 	if (IS_ERR(inode)) {
 		ret = PTR_ERR(inode);
@@ -1280,14 +1289,6 @@ static int ufs_fill_super(struct super_block *sb, void *data, int silent)
 		goto failed;
 	}
 
-	ufs_setup_cstotal(sb);
-	/*
-	 * Read cylinder group structures
-	 */
-	if (!sb_rdonly(sb))
-		if (!ufs_read_cylinder_structures(sb))
-			goto failed;
-
 	UFSD("EXIT\n");
 	return 0;
 
diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index 01e42ee5f409..464636278c4f 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -22,7 +22,7 @@ struct request_key_auth {
 	const struct cred	*cred;
 	void			*callout_info;
 	size_t			callout_len;
-	pid_t			pid;
+	struct pid		*pid;
 	char			op[8];
 } __randomize_layout;
 
diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 3db9434afcfe..78beaebb5815 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -40,7 +40,7 @@
  *  reg |= FIELD_PREP(REG_FIELD_C, c);
  */
 
-#define __bf_shf(x) (__builtin_ffsll(x) - 1)
+#define __bf_shf __builtin_ctzll
 
 #define __scalar_type_to_unsigned_cases(type)				\
 		unsigned type:	(unsigned type)0,			\
diff --git a/include/linux/kcsan-checks.h b/include/linux/kcsan-checks.h
index cf14840609ce..d941147053b2 100644
--- a/include/linux/kcsan-checks.h
+++ b/include/linux/kcsan-checks.h
@@ -196,7 +196,7 @@ static inline void __kcsan_disable_current(void) { }
  * @size: size of access
  */
 #define __kcsan_check_write(ptr, size)                                         \
-	__kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+	__kcsan_check_access(absolute_pointer(ptr), size, KCSAN_ACCESS_WRITE)
 
 /**
  * __kcsan_check_read_write - check regular read-write access for races
@@ -222,7 +222,7 @@ static inline void __kcsan_disable_current(void) { }
  * @size: size of access
  */
 #define kcsan_check_write(ptr, size)                                           \
-	kcsan_check_access(ptr, size, KCSAN_ACCESS_WRITE)
+	kcsan_check_access(absolute_pointer(ptr), size, KCSAN_ACCESS_WRITE)
 
 /**
  * kcsan_check_read_write - check regular read-write access for races
@@ -245,7 +245,7 @@ static inline void __kcsan_disable_current(void) { }
 #define kcsan_check_atomic_read(ptr, size)                                     \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC)
 #define kcsan_check_atomic_write(ptr, size)                                    \
-	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
+	kcsan_check_access(absolute_pointer(ptr), size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE)
 #define kcsan_check_atomic_read_write(ptr, size)                               \
 	kcsan_check_access(ptr, size, KCSAN_ACCESS_ATOMIC | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_COMPOUND)
 #endif
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 6fee33cb52f5..02e54ac37a6c 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -108,6 +108,7 @@ struct mbox_controller {
  * @txdone_method:	Way to detect TXDone chosen by the API
  * @cl:			Pointer to the current owner of this channel
  * @tx_complete:	Transmission completion
+ * @tx_status:		Transmission status
  * @active_req:		Currently active request hook
  * @msg_count:		No. of mssg currently queued
  * @msg_free:		Index of next available mssg slot
@@ -120,6 +121,7 @@ struct mbox_chan {
 	unsigned txdone_method;
 	struct mbox_client *cl;
 	struct completion tx_complete;
+	int tx_status;
 	void *active_req;
 	unsigned msg_count, msg_free;
 	void *msg_data[MBOX_TX_QUEUE_LEN];
diff --git a/include/linux/platform_data/asoc-ux500-msp.h b/include/linux/platform_data/asoc-ux500-msp.h
deleted file mode 100644
index b8d0f730dda8..000000000000
--- a/include/linux/platform_data/asoc-ux500-msp.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Author: Rabin Vincent <rabin.vincent@stericsson.com> for ST-Ericsson
- */
-
-#ifndef __MSP_H
-#define __MSP_H
-
-#include <linux/platform_data/dma-ste-dma40.h>
-
-/* Platform data structure for a MSP I2S-device */
-struct msp_i2s_platform_data {
-	int id;
-	struct stedma40_chan_cfg *msp_i2s_dma_rx;
-	struct stedma40_chan_cfg *msp_i2s_dma_tx;
-};
-
-#endif
diff --git a/include/linux/rculist.h b/include/linux/rculist.h
index f8633d37e358..5be4dd041f98 100644
--- a/include/linux/rculist.h
+++ b/include/linux/rculist.h
@@ -213,6 +213,35 @@ static inline void list_replace_rcu(struct list_head *old,
 	old->prev = LIST_POISON2;
 }
 
+static inline void __list_splice_rcu(struct list_head *list,
+				     struct list_head *prev,
+				     struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	last->next = next;
+	first->prev = prev;
+	next->prev = last;
+	rcu_assign_pointer(list_next_rcu(prev), first);
+}
+
+/**
+ * list_splice_rcu - splice a non-RCU list into an RCU-protected list,
+ *                   designed for stacks.
+ * @list:	the non RCU-protected list to splice
+ * @head:	the place in the existing RCU-protected list to splice
+ *
+ * The list pointed to by @head can be RCU-read traversed concurrently with
+ * this function.
+ */
+static inline void list_splice_rcu(struct list_head *list,
+				   struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice_rcu(list, head, head->next);
+}
+
 /**
  * __list_splice_init_rcu - join an RCU-protected list into an existing list.
  * @list:	the RCU-protected list to splice
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 01eb7bc4e84b..0a7b1a7f1ae1 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1416,6 +1416,11 @@ static inline unsigned int skb_end_offset(const struct sk_buff *skb)
 {
 	return skb->end;
 }
+
+static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
+{
+	skb->end = offset;
+}
 #else
 static inline unsigned char *skb_end_pointer(const struct sk_buff *skb)
 {
@@ -1426,6 +1431,11 @@ static inline unsigned int skb_end_offset(const struct sk_buff *skb)
 {
 	return skb->end - skb->head;
 }
+
+static inline void skb_set_end_offset(struct sk_buff *skb, unsigned int offset)
+{
+	skb->end = skb->head + offset;
+}
 #endif
 
 /* Internal */
@@ -1645,6 +1655,22 @@ static inline int skb_unclone(struct sk_buff *skb, gfp_t pri)
 	return 0;
 }
 
+/* This variant of skb_unclone() makes sure skb->truesize
+ * and skb_end_offset() are not changed, whenever a new skb->head is needed.
+ *
+ * Indeed there is no guarantee that ksize(kmalloc(X)) == ksize(kmalloc(X))
+ * when various debugging features are in place.
+ */
+int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri);
+static inline int skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
+{
+	might_sleep_if(gfpflags_allow_blocking(pri));
+
+	if (skb_cloned(skb))
+		return __skb_unclone_keeptruesize(skb, pri);
+	return 0;
+}
+
 /**
  *	skb_header_cloned - is the header a clone
  *	@skb: buffer to check
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index 572a07976116..18a2c0c8ac4d 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -196,7 +196,7 @@ struct tty_ldisc_ops {
 	void	(*set_termios)(struct tty_struct *tty, struct ktermios *old);
 	__poll_t (*poll)(struct tty_struct *, struct file *,
 			     struct poll_table_struct *);
-	int	(*hangup)(struct tty_struct *tty);
+	void	(*hangup)(struct tty_struct *tty);
 
 	/*
 	 * The following routines are called from below.
diff --git a/include/media/v4l2-hevc.h b/include/media/v4l2-hevc.h
new file mode 100644
index 000000000000..973c96be16be
--- /dev/null
+++ b/include/media/v4l2-hevc.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Helper functions for HEVC stateless codecs.
+ */
+
+#ifndef _MEDIA_V4L2_HEVC_H
+#define _MEDIA_V4L2_HEVC_H
+
+#include <linux/minmax.h>
+#include <media/v4l2-ctrls.h>
+
+/**
+ * v4l2_hevc_pps_num_tile_columns - number of HEVC tile columns, bounded
+ * @pps: the V4L2 HEVC PPS control
+ *
+ * Return the number of tile columns (num_tile_columns_minus1 + 1) clamped to
+ * the capacity of column_width_minus1[]. The control validation already
+ * rejects out-of-range counts; this keeps the consuming drivers bounded too.
+ */
+static inline unsigned int
+v4l2_hevc_pps_num_tile_columns(const struct v4l2_ctrl_hevc_pps *pps)
+{
+	return min_t(unsigned int, pps->num_tile_columns_minus1 + 1,
+		     ARRAY_SIZE(pps->column_width_minus1));
+}
+
+/**
+ * v4l2_hevc_pps_num_tile_rows - number of HEVC tile rows, bounded
+ * @pps: the V4L2 HEVC PPS control
+ *
+ * Return the number of tile rows (num_tile_rows_minus1 + 1) clamped to the
+ * capacity of row_height_minus1[].
+ */
+static inline unsigned int
+v4l2_hevc_pps_num_tile_rows(const struct v4l2_ctrl_hevc_pps *pps)
+{
+	return min_t(unsigned int, pps->num_tile_rows_minus1 + 1,
+		     ARRAY_SIZE(pps->row_height_minus1));
+}
+
+#endif /* _MEDIA_V4L2_HEVC_H */
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5595c2a94939..a2758f9ce340 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -6482,7 +6482,7 @@ void cfg80211_ibss_joined(struct net_device *dev, const u8 *bssid,
  * cfg80211 then sends a notification to userspace.
  */
 void cfg80211_notify_new_peer_candidate(struct net_device *dev,
-		const u8 *macaddr, const u8 *ie, u8 ie_len,
+		const u8 *macaddr, const u8 *ie, size_t ie_len,
 		int sig_dbm, gfp_t gfp);
 
 /**
diff --git a/include/net/gue.h b/include/net/gue.h
index e5246d5d3e87..3d8a4e971ad9 100644
--- a/include/net/gue.h
+++ b/include/net/gue.h
@@ -81,8 +81,9 @@ static inline size_t guehdr_priv_flags_len(__be32 flags)
 }
 
 /* Validate standard and private flags. Returns non-zero (meaning invalid)
- * if there is an unknown standard or private flags, or the options length for
- * the flags exceeds the options length specific in hlen of the GUE header.
+ * if there is an unknown standard or private flags, if the options length for
+ * the flags exceeds the options length specified in hlen of the GUE header, or
+ * if a private option contains invalid data.
  */
 static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 {
@@ -100,8 +101,8 @@ static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 		/* Private flags are last four bytes accounted in
 		 * guehdr_flags_len
 		 */
-		__be32 pflags = *(__be32 *)((void *)&guehdr[1] +
-					    len - GUE_LEN_PRIV);
+		void *data = (void *)&guehdr[1] + len;
+		__be32 pflags = *(__be32 *)(data - GUE_LEN_PRIV);
 
 		if (pflags & ~GUE_PFLAGS_ALL)
 			return 1;
@@ -109,6 +110,16 @@ static inline int validate_gue_flags(struct guehdr *guehdr, size_t optlen)
 		len += guehdr_priv_flags_len(pflags);
 		if (len > optlen)
 			return 1;
+
+		if (pflags & GUE_PFLAG_REMCSUM) {
+			__be16 *pd = data;
+
+			/* The field offset pd[1] must not be less
+			 * than the start pd[0].
+			 */
+			if (ntohs(pd[1]) < ntohs(pd[0]))
+				return 1;
+		}
 	}
 
 	return 0;
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 5cf23a23f3c4..08a3d282751d 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -166,6 +166,11 @@ static inline void nf_ct_put(struct nf_conn *ct)
 int nf_ct_l3proto_try_module_get(unsigned short l3proto);
 void nf_ct_l3proto_module_put(unsigned short l3proto);
 
+static inline bool nf_ct_shared(const struct nf_conn *ct)
+{
+	return refcount_read(&ct->ct_general.use) > 1;
+}
+
 /* load module; enable/disable conntrack in this namespace */
 int nf_ct_netns_get(struct net *net, u8 nfproto);
 void nf_ct_netns_put(struct net *net, u8 nfproto);
diff --git a/include/net/netfilter/nf_flow_table.h b/include/net/netfilter/nf_flow_table.h
index b338638f2279..d7c81aa90c80 100644
--- a/include/net/netfilter/nf_flow_table.h
+++ b/include/net/netfilter/nf_flow_table.h
@@ -127,6 +127,7 @@ enum nf_flow_flags {
 	NF_FLOW_HW_DYING,
 	NF_FLOW_HW_DEAD,
 	NF_FLOW_HW_PENDING,
+	NF_FLOW_HW_BIDIRECTIONAL,
 };
 
 enum flow_offload_type {
diff --git a/include/net/netns/xfrm.h b/include/net/netns/xfrm.h
index 7b87da22b295..47bc0ec051eb 100644
--- a/include/net/netns/xfrm.h
+++ b/include/net/netns/xfrm.h
@@ -58,7 +58,7 @@ struct netns_xfrm {
 	struct list_head	inexact_bins;
 
 
-	struct sock		*nlsk;
+	struct sock		__rcu *nlsk;
 	struct sock		*nlsk_stash;
 
 	u32			sysctl_aevent_etime;
diff --git a/include/net/nfc/hci.h b/include/net/nfc/hci.h
index b35f37a57686..26af67df30a3 100644
--- a/include/net/nfc/hci.h
+++ b/include/net/nfc/hci.h
@@ -144,7 +144,7 @@ struct nfc_hci_dev {
 	data_exchange_cb_t async_cb;
 	void *async_cb_context;
 
-	u8 *gb;
+	u8 gb[NFC_MAX_GT_LEN];
 	size_t gb_len;
 
 	unsigned long quirks;
diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index 91f153d0bbb0..19883b5c2333 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -269,7 +269,8 @@ struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
 				 const u8 *gt, u8 gt_len);
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb,
+				size_t gb_max_len, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
 			 u32 result);
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 1eccb2ac7d02..a11350ffed66 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -143,7 +143,7 @@ enum tiqn_state_table {
 	TIQN_STATE_SHUTDOWN			= 2,
 };
 
-/* struct iscsi_cmd->cmd_flags */
+/* struct iscsit_cmd->cmd_flags */
 enum cmd_flags_table {
 	ICF_GOT_LAST_DATAOUT			= 0x00000001,
 	ICF_GOT_DATACK_SNACK			= 0x00000002,
@@ -157,7 +157,7 @@ enum cmd_flags_table {
 	ICF_SENDTARGETS_SINGLE			= 0x00000200,
 };
 
-/* struct iscsi_cmd->i_state */
+/* struct iscsit_cmd->i_state */
 enum cmd_i_state_table {
 	ISTATE_NO_STATE			= 0,
 	ISTATE_NEW_CMD			= 1,
@@ -297,7 +297,7 @@ struct iscsi_sess_ops {
 
 struct iscsi_queue_req {
 	int			state;
-	struct iscsi_cmd	*cmd;
+	struct iscsit_cmd	*cmd;
 	struct list_head	qr_list;
 };
 
@@ -327,7 +327,7 @@ struct iscsi_ooo_cmdsn {
 	u32			batch_count;
 	u32			cmdsn;
 	u32			exp_cmdsn;
-	struct iscsi_cmd	*cmd;
+	struct iscsit_cmd	*cmd;
 	struct list_head	ooo_list;
 } ____cacheline_aligned;
 
@@ -349,7 +349,7 @@ struct iscsi_r2t {
 	struct list_head	r2t_list;
 } ____cacheline_aligned;
 
-struct iscsi_cmd {
+struct iscsit_cmd {
 	enum iscsi_timer_flags_table dataout_timer_flags;
 	/* DataOUT timeout retries */
 	u8			dataout_timeout_retries;
@@ -405,22 +405,22 @@ struct iscsi_cmd {
 	u32			outstanding_r2ts;
 	/* Next R2T Offset when DataSequenceInOrder=Yes */
 	u32			r2t_offset;
-	/* Iovec current and orig count for iscsi_cmd->iov_data */
+	/* Iovec current and orig count for iscsit_cmd->iov_data */
 	u32			iov_data_count;
 	u32			orig_iov_data_count;
 	/* Number of miscellaneous iovecs used for IP stack calls */
 	u32			iov_misc_count;
-	/* Number of struct iscsi_pdu in struct iscsi_cmd->pdu_list */
+	/* Number of struct iscsi_pdu in struct iscsit_cmd->pdu_list */
 	u32			pdu_count;
-	/* Next struct iscsi_pdu to send in struct iscsi_cmd->pdu_list */
+	/* Next struct iscsi_pdu to send in struct iscsit_cmd->pdu_list */
 	u32			pdu_send_order;
-	/* Current struct iscsi_pdu in struct iscsi_cmd->pdu_list */
+	/* Current struct iscsi_pdu in struct iscsit_cmd->pdu_list */
 	u32			pdu_start;
-	/* Next struct iscsi_seq to send in struct iscsi_cmd->seq_list */
+	/* Next struct iscsi_seq to send in struct iscsit_cmd->seq_list */
 	u32			seq_send_order;
-	/* Number of struct iscsi_seq in struct iscsi_cmd->seq_list */
+	/* Number of struct iscsi_seq in struct iscsit_cmd->seq_list */
 	u32			seq_count;
-	/* Current struct iscsi_seq in struct iscsi_cmd->seq_list */
+	/* Current struct iscsi_seq in struct iscsit_cmd->seq_list */
 	u32			seq_no;
 	/* Lowest offset in current DataOUT sequence */
 	u32			seq_start_offset;
@@ -444,12 +444,12 @@ struct iscsi_cmd {
 	enum dma_data_direction	data_direction;
 	/* iSCSI PDU Header + CRC */
 	unsigned char		pdu[ISCSI_HDR_LEN + ISCSI_CRC_LEN];
-	/* Number of times struct iscsi_cmd is present in immediate queue */
+	/* Number of times struct iscsit_cmd is present in immediate queue */
 	atomic_t		immed_queue_count;
 	atomic_t		response_queue_count;
 	spinlock_t		datain_lock;
 	spinlock_t		dataout_timeout_lock;
-	/* spinlock for protecting struct iscsi_cmd->i_state */
+	/* spinlock for protecting struct iscsit_cmd->i_state */
 	spinlock_t		istate_lock;
 	/* spinlock for adding within command recovery entries */
 	spinlock_t		error_lock;
@@ -503,7 +503,7 @@ struct iscsi_cmd {
 struct iscsi_tmr_req {
 	bool			task_reassign:1;
 	u32			exp_data_sn;
-	struct iscsi_cmd	*ref_cmd;
+	struct iscsit_cmd	*ref_cmd;
 	struct iscsi_conn_recovery *conn_recovery;
 	struct se_tmr_req	*se_tmr_req;
 };
@@ -582,7 +582,7 @@ struct iscsi_conn {
 	cpumask_var_t		conn_cpumask;
 	unsigned int		conn_rx_reset_cpumask:1;
 	unsigned int		conn_tx_reset_cpumask:1;
-	/* list_head of struct iscsi_cmd for this connection */
+	/* list_head of struct iscsit_cmd for this connection */
 	struct list_head	conn_cmd_list;
 	struct list_head	immed_queue_list;
 	struct list_head	response_queue_list;
@@ -896,7 +896,7 @@ static inline u32 session_get_next_ttt(struct iscsi_session *session)
 	return ttt;
 }
 
-extern struct iscsi_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
+extern struct iscsit_cmd *iscsit_find_cmd_from_itt(struct iscsi_conn *, itt_t);
 
 static inline void iscsit_thread_check_cpumask(
 	struct iscsi_conn *conn,
diff --git a/include/target/iscsi/iscsi_transport.h b/include/target/iscsi/iscsi_transport.h
index b8feba7ffebc..645de3542022 100644
--- a/include/target/iscsi/iscsi_transport.h
+++ b/include/target/iscsi/iscsi_transport.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include "iscsi_target_core.h" /* struct iscsi_cmd */
+#include "iscsi_target_core.h" /* struct iscsit_cmd */
 
 struct sockaddr_storage;
 
@@ -18,23 +18,23 @@ struct iscsit_transport {
 	void (*iscsit_free_conn)(struct iscsi_conn *);
 	int (*iscsit_get_login_rx)(struct iscsi_conn *, struct iscsi_login *);
 	int (*iscsit_put_login_tx)(struct iscsi_conn *, struct iscsi_login *, u32);
-	int (*iscsit_immediate_queue)(struct iscsi_conn *, struct iscsi_cmd *, int);
-	int (*iscsit_response_queue)(struct iscsi_conn *, struct iscsi_cmd *, int);
-	int (*iscsit_get_dataout)(struct iscsi_conn *, struct iscsi_cmd *, bool);
-	int (*iscsit_queue_data_in)(struct iscsi_conn *, struct iscsi_cmd *);
-	int (*iscsit_queue_status)(struct iscsi_conn *, struct iscsi_cmd *);
-	void (*iscsit_aborted_task)(struct iscsi_conn *, struct iscsi_cmd *);
-	int (*iscsit_xmit_pdu)(struct iscsi_conn *, struct iscsi_cmd *,
+	int (*iscsit_immediate_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_response_queue)(struct iscsi_conn *, struct iscsit_cmd *, int);
+	int (*iscsit_get_dataout)(struct iscsi_conn *, struct iscsit_cmd *, bool);
+	int (*iscsit_queue_data_in)(struct iscsi_conn *, struct iscsit_cmd *);
+	int (*iscsit_queue_status)(struct iscsi_conn *, struct iscsit_cmd *);
+	void (*iscsit_aborted_task)(struct iscsi_conn *, struct iscsit_cmd *);
+	int (*iscsit_xmit_pdu)(struct iscsi_conn *, struct iscsit_cmd *,
 			       struct iscsi_datain_req *, const void *, u32);
-	void (*iscsit_unmap_cmd)(struct iscsi_conn *, struct iscsi_cmd *);
+	void (*iscsit_unmap_cmd)(struct iscsi_conn *, struct iscsit_cmd *);
 	void (*iscsit_get_rx_pdu)(struct iscsi_conn *);
 	int (*iscsit_validate_params)(struct iscsi_conn *);
-	void (*iscsit_get_r2t_ttt)(struct iscsi_conn *, struct iscsi_cmd *,
+	void (*iscsit_get_r2t_ttt)(struct iscsi_conn *, struct iscsit_cmd *,
 				   struct iscsi_r2t *);
 	enum target_prot_op (*iscsit_get_sup_prot_ops)(struct iscsi_conn *);
 };
 
-static inline void *iscsit_priv_cmd(struct iscsi_cmd *cmd)
+static inline void *iscsit_priv_cmd(struct iscsit_cmd *cmd)
 {
 	return (void *)(cmd + 1);
 }
@@ -51,61 +51,61 @@ extern void iscsit_put_transport(struct iscsit_transport *);
 /*
  * From iscsi_target.c
  */
-extern int iscsit_setup_scsi_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern void iscsit_set_unsolicited_dataout(struct iscsi_cmd *);
-extern int iscsit_process_scsi_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern void iscsit_set_unsolicited_dataout(struct iscsit_cmd *);
+extern int iscsit_process_scsi_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_scsi_req *);
 extern int
 __iscsit_check_dataout_hdr(struct iscsi_conn *, void *,
-			   struct iscsi_cmd *, u32, bool *);
+			   struct iscsit_cmd *, u32, bool *);
 extern int
 iscsit_check_dataout_hdr(struct iscsi_conn *conn, void *buf,
-			 struct iscsi_cmd **out_cmd);
-extern int iscsit_check_dataout_payload(struct iscsi_cmd *, struct iscsi_data *,
+			 struct iscsit_cmd **out_cmd);
+extern int iscsit_check_dataout_payload(struct iscsit_cmd *, struct iscsi_data *,
 				bool);
-extern int iscsit_setup_nop_out(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_process_nop_out(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_process_nop_out(struct iscsi_conn *, struct iscsit_cmd *,
 				struct iscsi_nopout *);
-extern int iscsit_handle_logout_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_handle_logout_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_handle_task_mgt_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_handle_task_mgt_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				unsigned char *);
-extern int iscsit_setup_text_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_setup_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				 struct iscsi_text *);
-extern int iscsit_process_text_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_process_text_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				   struct iscsi_text *);
-extern void iscsit_build_rsp_pdu(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_rsp_pdu(struct iscsit_cmd *, struct iscsi_conn *,
 				bool, struct iscsi_scsi_rsp *);
-extern void iscsit_build_nopin_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_nopin_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_nopin *, bool);
-extern void iscsit_build_task_mgt_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_task_mgt_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_tm_rsp *);
-extern int iscsit_build_text_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern int iscsit_build_text_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_text_rsp *,
 				enum iscsit_transport_type);
-extern void iscsit_build_reject(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_reject(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_reject *);
-extern int iscsit_build_logout_rsp(struct iscsi_cmd *, struct iscsi_conn *,
+extern int iscsit_build_logout_rsp(struct iscsit_cmd *, struct iscsi_conn *,
 				struct iscsi_logout_rsp *);
-extern int iscsit_logout_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
-extern int iscsit_queue_rsp(struct iscsi_conn *, struct iscsi_cmd *);
-extern void iscsit_aborted_task(struct iscsi_conn *, struct iscsi_cmd *);
+extern int iscsit_logout_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
+extern int iscsit_queue_rsp(struct iscsi_conn *, struct iscsit_cmd *);
+extern void iscsit_aborted_task(struct iscsi_conn *, struct iscsit_cmd *);
 extern int iscsit_add_reject(struct iscsi_conn *, u8, unsigned char *);
-extern int iscsit_reject_cmd(struct iscsi_cmd *, u8, unsigned char *);
+extern int iscsit_reject_cmd(struct iscsit_cmd *, u8, unsigned char *);
 extern int iscsit_handle_snack(struct iscsi_conn *, unsigned char *);
-extern void iscsit_build_datain_pdu(struct iscsi_cmd *, struct iscsi_conn *,
+extern void iscsit_build_datain_pdu(struct iscsit_cmd *, struct iscsi_conn *,
 				    struct iscsi_datain *,
 				    struct iscsi_data_rsp *, bool);
-extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern int iscsit_build_r2ts_for_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 				     bool);
-extern int iscsit_immediate_queue(struct iscsi_conn *, struct iscsi_cmd *, int);
-extern int iscsit_response_queue(struct iscsi_conn *, struct iscsi_cmd *, int);
+extern int iscsit_immediate_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
+extern int iscsit_response_queue(struct iscsi_conn *, struct iscsit_cmd *, int);
 /*
  * From iscsi_target_device.c
  */
-extern void iscsit_increment_maxcmdsn(struct iscsi_cmd *, struct iscsi_session *);
+extern void iscsit_increment_maxcmdsn(struct iscsit_cmd *, struct iscsi_session *);
 /*
  * From iscsi_target_erl0.c
  */
@@ -113,24 +113,24 @@ extern void iscsit_cause_connection_reinstatement(struct iscsi_conn *, int);
 /*
  * From iscsi_target_erl1.c
  */
-extern void iscsit_stop_dataout_timer(struct iscsi_cmd *);
+extern void iscsit_stop_dataout_timer(struct iscsit_cmd *);
 
 /*
  * From iscsi_target_tmr.c
  */
-extern int iscsit_tmr_post_handler(struct iscsi_cmd *, struct iscsi_conn *);
+extern int iscsit_tmr_post_handler(struct iscsit_cmd *, struct iscsi_conn *);
 
 /*
  * From iscsi_target_util.c
  */
-extern struct iscsi_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
-extern int iscsit_sequence_cmd(struct iscsi_conn *, struct iscsi_cmd *,
+extern struct iscsit_cmd *iscsit_allocate_cmd(struct iscsi_conn *, int);
+extern int iscsit_sequence_cmd(struct iscsi_conn *, struct iscsit_cmd *,
 			       unsigned char *, __be32);
-extern void iscsit_release_cmd(struct iscsi_cmd *);
-extern void iscsit_free_cmd(struct iscsi_cmd *, bool);
-extern void iscsit_add_cmd_to_immediate_queue(struct iscsi_cmd *,
+extern void iscsit_release_cmd(struct iscsit_cmd *);
+extern void iscsit_free_cmd(struct iscsit_cmd *, bool);
+extern void iscsit_add_cmd_to_immediate_queue(struct iscsit_cmd *,
 					      struct iscsi_conn *, u8);
-extern struct iscsi_cmd *
+extern struct iscsit_cmd *
 iscsit_find_cmd_from_itt_or_dump(struct iscsi_conn *conn,
 				 itt_t init_task_tag, u32 length);
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index cfbb038d150c..bcdd5a64c43b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -2443,14 +2443,29 @@ static void btf_modifier_show(const struct btf *btf,
 	else
 		t = btf_type_skip_modifiers(btf, type_id, NULL);
 
-	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
+	/*
+	 * A modifier can resolve to void, which has no show op; print a
+	 * placeholder rather than dereferencing NULL.
+	 */
+	if (!btf_type_ops(t))
+		btf_df_show(btf, t, type_id, data, bits_offset, show);
+	else
+		btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
 
 static void btf_var_show(const struct btf *btf, const struct btf_type *t,
 			 u32 type_id, void *data, u8 bits_offset,
 			 struct btf_show *show)
 {
-	t = btf_type_id_resolve(btf, &type_id);
+	/*
+	 * btf_type_id_resolve() dereferences btf->resolved_ids, which is NULL
+	 * for a base BTF (e.g. the vmlinux BTF that bpf_snprintf_btf() uses).
+	 * Resolve the var's type directly in that case.
+	 */
+	if (btf->resolved_ids)
+		t = btf_type_id_resolve(btf, &type_id);
+	else
+		t = btf_type_skip_modifiers(btf, t->type, &type_id);
 
 	btf_type_ops(t)->show(btf, t, type_id, data, bits_offset, show);
 }
diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 72fc467b7397..ee272477a460 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -1727,6 +1727,7 @@ BPF_CALL_3(bpf_sysctl_set_new_value, struct bpf_sysctl_kern *, ctx,
 		return -E2BIG;
 
 	memcpy(ctx->new_val, buf, buf_len);
+	((char *)ctx->new_val)[buf_len] = '\0';
 	ctx->new_len = buf_len;
 	ctx->new_updated = 1;
 
diff --git a/kernel/dma/coherent.c b/kernel/dma/coherent.c
index 49aaad3936f1..f8199ba854d8 100644
--- a/kernel/dma/coherent.c
+++ b/kernel/dma/coherent.c
@@ -37,51 +37,44 @@ static inline dma_addr_t dma_get_device_base(struct device *dev,
 	return mem->device_base;
 }
 
-static int dma_init_coherent_memory(phys_addr_t phys_addr,
-		dma_addr_t device_addr, size_t size,
-		struct dma_coherent_mem **mem)
+static struct dma_coherent_mem *dma_init_coherent_memory(phys_addr_t phys_addr,
+		dma_addr_t device_addr, size_t size, bool use_dma_pfn_offset)
 {
-	struct dma_coherent_mem *dma_mem = NULL;
-	void *mem_base = NULL;
+	struct dma_coherent_mem *dma_mem;
 	int pages = size >> PAGE_SHIFT;
 	int bitmap_size = BITS_TO_LONGS(pages) * sizeof(long);
-	int ret;
+	void *mem_base;
 
-	if (!size) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!size)
+		return ERR_PTR(-EINVAL);
 
 	mem_base = memremap(phys_addr, size, MEMREMAP_WC);
-	if (!mem_base) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!mem_base)
+		return ERR_PTR(-EINVAL);
+
 	dma_mem = kzalloc(sizeof(struct dma_coherent_mem), GFP_KERNEL);
-	if (!dma_mem) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem)
+		goto out_unmap_membase;
 	dma_mem->bitmap = kzalloc(bitmap_size, GFP_KERNEL);
-	if (!dma_mem->bitmap) {
-		ret = -ENOMEM;
-		goto out;
-	}
+	if (!dma_mem->bitmap)
+		goto out_free_dma_mem;
 
 	dma_mem->virt_base = mem_base;
 	dma_mem->device_base = device_addr;
 	dma_mem->pfn_base = PFN_DOWN(phys_addr);
 	dma_mem->size = pages;
+	dma_mem->use_dev_dma_pfn_offset = use_dma_pfn_offset;
 	spin_lock_init(&dma_mem->spinlock);
 
-	*mem = dma_mem;
-	return 0;
+	return dma_mem;
 
-out:
+out_free_dma_mem:
 	kfree(dma_mem);
-	if (mem_base)
-		memunmap(mem_base);
-	return ret;
+out_unmap_membase:
+	memunmap(mem_base);
+	pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %zd MiB\n",
+		&phys_addr, size / SZ_1M);
+	return ERR_PTR(-ENOMEM);
 }
 
 static void _dma_release_coherent_memory(struct dma_coherent_mem *mem)
@@ -130,9 +123,9 @@ int dma_declare_coherent_memory(struct device *dev, phys_addr_t phys_addr,
 	struct dma_coherent_mem *mem;
 	int ret;
 
-	ret = dma_init_coherent_memory(phys_addr, device_addr, size, &mem);
-	if (ret)
-		return ret;
+	mem = dma_init_coherent_memory(phys_addr, device_addr, size, false);
+	if (IS_ERR(mem))
+		return PTR_ERR(mem);
 
 	ret = dma_assign_coherent_memory(dev, mem);
 	if (ret)
@@ -328,21 +321,21 @@ static struct reserved_mem *dma_reserved_default_memory __initdata;
 static int rmem_dma_device_init(struct reserved_mem *rmem, struct device *dev)
 {
 	struct dma_coherent_mem *mem = rmem->priv;
-	int ret;
 
 	if (!mem) {
-		ret = dma_init_coherent_memory(rmem->base, rmem->base,
-					       rmem->size, &mem);
-		if (ret) {
-			pr_err("Reserved memory: failed to init DMA memory pool at %pa, size %ld MiB\n",
-				&rmem->base, (unsigned long)rmem->size / SZ_1M);
-			return ret;
-		}
+		mem = dma_init_coherent_memory(rmem->base, rmem->base,
+					       rmem->size, true);
+		if (IS_ERR(mem))
+			return PTR_ERR(mem);
+		rmem->priv = mem;
 	}
-	mem->use_dev_dma_pfn_offset = true;
-	rmem->priv = mem;
-	dma_assign_coherent_memory(dev, mem);
-	return 0;
+
+	/* Warn if the device potentially can't use the reserved memory */
+	if (mem->device_base + rmem->size - 1 >
+	    min_not_zero(dev->coherent_dma_mask, dev->bus_dma_limit))
+		dev_warn(dev, "reserved memory is beyond device's set DMA address range\n");
+
+	return dma_assign_coherent_memory(dev, mem);
 }
 
 static void rmem_dma_device_release(struct reserved_mem *rmem,
diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_perf.c
index b3a863c10c0a..cccb8540d301 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -494,7 +494,17 @@ static int perf_ftrace_function_register(struct perf_event *event)
 static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops = &event->ftrace_ops;
-	int ret = unregister_ftrace_function(ops);
+	int ret = 0;
+
+	/*
+	 * Perf will call this unconditionally even if the ops is not
+	 * enabled. The unregister_ftrace_function() will warn if called
+	 * when not enabled. Just bypass the unregistering if ops isn't
+	 * enabled here.
+	 */
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		ret = unregister_ftrace_function(ops);
+
 	ftrace_free_filter(ops);
 	return ret;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 32f9ab82a881..a3556edc5904 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1853,7 +1853,7 @@ static struct hist_field *create_var_ref(struct hist_trigger_data *hist_data,
 	ref_field = create_hist_field(var_field->hist_data, NULL, flags, NULL);
 	if (ref_field) {
 		if (init_var_ref(ref_field, var_field, system, event_name)) {
-			destroy_hist_field(ref_field, 0);
+			__destroy_hist_field(ref_field);
 			return NULL;
 		}
 
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index d839736e6f72..8613b16bb11f 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -927,19 +927,60 @@ int traceprobe_set_print_fmt(struct trace_probe *tp, bool is_return)
 int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 				 size_t offset, struct trace_probe *tp)
 {
+	struct trace_probe_event *tpe = trace_probe_event_from_call(event_call);
 	int ret, i;
 
+	/*
+	 * A field created by trace_define_field() only stores the name and
+	 * type pointers, it does not copy the strings. Here they point into
+	 * the probe_arg of @tp, which is freed when @tp is removed. For an
+	 * event with multiple probes attached, the field list is defined
+	 * once by the first probe but kept alive by the surviving siblings,
+	 * so removing that first probe would leave the fields referencing
+	 * freed memory. Duplicate the strings and anchor the copies on the
+	 * trace_probe_event, which lives as long as the field list itself.
+	 *
+	 * event_define_fields() ignores the return value of this hook, so
+	 * if a previous attempt failed before creating any field, it may
+	 * call here again. Release duplicates left behind by such an
+	 * attempt before starting over.
+	 */
+	for (i = 0; i < tpe->nr_field_strings; i++)
+		kfree(tpe->field_strings[i]);
+	kfree(tpe->field_strings);
+	tpe->field_strings = NULL;
+	tpe->nr_field_strings = 0;
+
+	if (tp->nr_args) {
+		tpe->field_strings = kcalloc(tp->nr_args * 2, sizeof(char *),
+					     GFP_KERNEL);
+		if (!tpe->field_strings)
+			return -ENOMEM;
+	}
+
 	/* Set argument names as fields */
 	for (i = 0; i < tp->nr_args; i++) {
 		struct probe_arg *parg = &tp->args[i];
 		const char *fmt = parg->type->fmttype;
 		int size = parg->type->size;
+		char *name, *type;
 
 		if (parg->fmt)
 			fmt = parg->fmt;
 		if (parg->count)
 			size *= parg->count;
-		ret = trace_define_field(event_call, fmt, parg->name,
+
+		name = kstrdup(parg->name, GFP_KERNEL);
+		type = kstrdup(fmt, GFP_KERNEL);
+		if (!name || !type) {
+			kfree(name);
+			kfree(type);
+			return -ENOMEM;
+		}
+		tpe->field_strings[tpe->nr_field_strings++] = name;
+		tpe->field_strings[tpe->nr_field_strings++] = type;
+
+		ret = trace_define_field(event_call, type, name,
 					 offset + parg->offset, size,
 					 parg->type->is_signed,
 					 FILTER_OTHER);
@@ -951,6 +992,11 @@ int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 
 static void trace_probe_event_free(struct trace_probe_event *tpe)
 {
+	int i;
+
+	for (i = 0; i < tpe->nr_field_strings; i++)
+		kfree(tpe->field_strings[i]);
+	kfree(tpe->field_strings);
 	kfree(tpe->class.system);
 	kfree(tpe->call.name);
 	kfree(tpe->call.print_fmt);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0f7a584ac21b..8bd8d82bccda 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -236,6 +236,8 @@ struct trace_probe_event {
 	struct trace_event_call		call;
 	struct list_head 		files;
 	struct list_head		probes;
+	char				**field_strings;
+	int				nr_field_strings;
 	struct trace_uprobe_filter	filter[];
 };
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index eeda0e263cbf..44525db555a6 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2617,7 +2617,7 @@ static void check_flush_dependency(struct workqueue_struct *target_wq,
 	WARN_ONCE(current->flags & PF_MEMALLOC,
 		  "workqueue: PF_MEMALLOC task %d(%s) is flushing !WQ_MEM_RECLAIM %s:%ps",
 		  current->pid, current->comm, target_wq->name, target_func);
-	WARN_ONCE(worker && ((worker->current_pwq->wq->flags &
+	WARN_ONCE(worker && worker->current_pwq && ((worker->current_pwq->wq->flags &
 			      (WQ_MEM_RECLAIM | __WQ_LEGACY)) == WQ_MEM_RECLAIM),
 		  "workqueue: WQ_MEM_RECLAIM %s:%ps is flushing !WQ_MEM_RECLAIM %s:%ps",
 		  worker->current_pwq->wq->name, worker->current_func,
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index c134f8210b21..9949369e3633 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -53,6 +53,11 @@ static int vlan_dev_hard_header(struct sk_buff *skb, struct net_device *dev,
 	int rc;
 
 	if (!(vlan->flags & VLAN_FLAG_REORDER_HDR)) {
+		unsigned int hlen = READ_ONCE(dev->hard_header_len) +
+				    READ_ONCE(dev->needed_headroom);
+
+		if (skb_cow_head(skb, hlen) < 0)
+			return -ENOMEM;
 		vhdr = skb_push(skb, VLAN_HLEN);
 
 		vlan_tci = vlan->vlan_id;
diff --git a/net/appletalk/aarp.c b/net/appletalk/aarp.c
index 17d9cb380e7b..1c91f1e6c281 100644
--- a/net/appletalk/aarp.c
+++ b/net/appletalk/aarp.c
@@ -573,6 +573,11 @@ int aarp_send_ddp(struct net_device *dev, struct sk_buff *skb,
 		struct ddpehdr *ddp = (struct ddpehdr *)skb->data;
 		int ft = 2;
 
+		if (!at) {
+			kfree_skb(skb);
+			return NET_XMIT_DROP;
+		}
+
 		/*
 		 * Compressible ?
 		 *
diff --git a/net/batman-adv/distributed-arp-table.c b/net/batman-adv/distributed-arp-table.c
index 4277fd832f4d..6ff856a803dd 100644
--- a/net/batman-adv/distributed-arp-table.c
+++ b/net/batman-adv/distributed-arp-table.c
@@ -377,18 +377,19 @@ batadv_dat_entry_hash_find(struct batadv_priv *bat_priv, __be32 ip,
 static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 				 u8 *mac_addr, unsigned short vid)
 {
+	u64 u64_mac = ether_addr_to_u64(mac_addr);
 	struct batadv_dat_entry *dat_entry;
 	int hash_added;
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip, vid);
 	/* if this entry is already known, just update it */
 	if (dat_entry) {
-		if (!batadv_compare_eth(dat_entry->mac_addr, mac_addr))
-			ether_addr_copy(dat_entry->mac_addr, mac_addr);
+		atomic64_set(&dat_entry->mac_addr, u64_mac);
+
 		dat_entry->last_update = jiffies;
 		batadv_dbg(BATADV_DBG_DAT, bat_priv,
 			   "Entry updated: %pI4 %pM (vid: %d)\n",
-			   &dat_entry->ip, dat_entry->mac_addr,
+			   &dat_entry->ip, mac_addr,
 			   batadv_print_vid(vid));
 		goto out;
 	}
@@ -399,7 +400,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 
 	dat_entry->ip = ip;
 	dat_entry->vid = vid;
-	ether_addr_copy(dat_entry->mac_addr, mac_addr);
+	atomic64_set(&dat_entry->mac_addr, u64_mac);
 	dat_entry->last_update = jiffies;
 	kref_init(&dat_entry->refcount);
 
@@ -415,7 +416,7 @@ static void batadv_dat_entry_add(struct batadv_priv *bat_priv, __be32 ip,
 	}
 
 	batadv_dbg(BATADV_DBG_DAT, bat_priv, "New entry added: %pI4 %pM (vid: %d)\n",
-		   &dat_entry->ip, dat_entry->mac_addr, batadv_print_vid(vid));
+		   &dat_entry->ip, mac_addr, batadv_print_vid(vid));
 
 out:
 	if (dat_entry)
@@ -876,6 +877,8 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 	struct hlist_head *head;
 	unsigned long last_seen_jiffies;
 	int last_seen_msecs, last_seen_secs, last_seen_mins;
+	u8 mac[ETH_ALEN] __aligned(2);
+	u64 u64_mac;
 	u32 i;
 
 	primary_if = batadv_seq_print_text_primary_if_get(seq);
@@ -897,8 +900,11 @@ int batadv_dat_cache_seq_print_text(struct seq_file *seq, void *offset)
 			last_seen_msecs = last_seen_msecs % 60000;
 			last_seen_secs = last_seen_msecs / 1000;
 
+			u64_mac = atomic64_read(&dat_entry->mac_addr);
+			u64_to_ether_addr(u64_mac, mac);
+
 			seq_printf(seq, " * %15pI4 %pM %4i %6i:%02i\n",
-				   &dat_entry->ip, dat_entry->mac_addr,
+				   &dat_entry->ip, mac,
 				   batadv_print_vid(dat_entry->vid),
 				   last_seen_mins, last_seen_secs);
 		}
@@ -927,6 +933,8 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 			    struct netlink_callback *cb,
 			    struct batadv_dat_entry *dat_entry)
 {
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int msecs;
 	void *hdr;
 
@@ -939,11 +947,12 @@ batadv_dat_cache_dump_entry(struct sk_buff *msg, u32 portid,
 	genl_dump_check_consistent(cb, hdr);
 
 	msecs = jiffies_to_msecs(jiffies - dat_entry->last_update);
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
 
 	if (nla_put_in_addr(msg, BATADV_ATTR_DAT_CACHE_IP4ADDRESS,
 			    dat_entry->ip) ||
-	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN,
-		    dat_entry->mac_addr) ||
+	    nla_put(msg, BATADV_ATTR_DAT_CACHE_HWADDRESS, ETH_ALEN, mac) ||
 	    nla_put_u16(msg, BATADV_ATTR_DAT_CACHE_VID, dat_entry->vid) ||
 	    nla_put_u32(msg, BATADV_ATTR_LAST_SEEN_MSECS, msecs)) {
 		genlmsg_cancel(msg, hdr);
@@ -1220,6 +1229,8 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 	struct net_device *soft_iface = bat_priv->soft_iface;
 	int hdr_size = 0;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1247,6 +1258,9 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_dst, vid);
 	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
 		/* If the ARP request is destined for a local client the local
 		 * client will answer itself. DAT would only generate a
 		 * duplicate packet.
@@ -1255,7 +1269,7 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * additional DAT answer may trigger kernel warnings about
 		 * a packet coming from the wrong port.
 		 */
-		if (batadv_is_my_client(bat_priv, dat_entry->mac_addr, vid)) {
+		if (batadv_is_my_client(bat_priv, mac, vid)) {
 			ret = true;
 			goto out;
 		}
@@ -1265,18 +1279,16 @@ bool batadv_dat_snoop_outgoing_arp_request(struct batadv_priv *bat_priv,
 		 * the backbone gws belonging to our backbone has claimed the
 		 * destination.
 		 */
-		if (!batadv_bla_check_claim(bat_priv,
-					    dat_entry->mac_addr, vid)) {
+		if (!batadv_bla_check_claim(bat_priv, mac, vid)) {
 			batadv_dbg(BATADV_DBG_DAT, bat_priv,
 				   "Device %pM claimed by another backbone gw. Don't send ARP reply!",
-				   dat_entry->mac_addr);
+				   mac);
 			ret = true;
 			goto out;
 		}
 
 		skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-						      dat_entry->mac_addr,
-						      hw_src, vid);
+						      mac, hw_src, vid);
 		if (!skb_new)
 			goto out;
 
@@ -1319,6 +1331,8 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	struct batadv_dat_entry *dat_entry = NULL;
 	bool ret = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 	int err;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
@@ -1346,8 +1360,11 @@ bool batadv_dat_snoop_incoming_arp_request(struct batadv_priv *bat_priv,
 	if (!dat_entry)
 		goto out;
 
+	u64_mac = atomic64_read(&dat_entry->mac_addr);
+	u64_to_ether_addr(u64_mac, mac);
+
 	skb_new = batadv_dat_arp_create_reply(bat_priv, ip_dst, ip_src,
-					      dat_entry->mac_addr, hw_src, vid);
+					      mac, hw_src, vid);
 	if (!skb_new)
 		goto out;
 
@@ -1439,6 +1456,8 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	u8 *hw_src, *hw_dst;
 	bool dropped = false;
 	unsigned short vid;
+	u8 mac[ETH_ALEN];
+	u64 u64_mac;
 
 	if (!atomic_read(&bat_priv->distributed_arp_table))
 		goto out;
@@ -1467,11 +1486,17 @@ bool batadv_dat_snoop_incoming_arp_reply(struct batadv_priv *bat_priv,
 	 * this frame would lead to doubled receive of an ARP reply.
 	 */
 	dat_entry = batadv_dat_entry_hash_find(bat_priv, ip_src, vid);
-	if (dat_entry && batadv_compare_eth(hw_src, dat_entry->mac_addr)) {
-		batadv_dbg(BATADV_DBG_DAT, bat_priv, "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
-			   hw_src, &ip_src, hw_dst, &ip_dst,
-			   dat_entry->mac_addr,	&dat_entry->ip);
-		dropped = true;
+	if (dat_entry) {
+		u64_mac = atomic64_read(&dat_entry->mac_addr);
+		u64_to_ether_addr(u64_mac, mac);
+
+		if (batadv_compare_eth(hw_src, mac)) {
+			batadv_dbg(BATADV_DBG_DAT, bat_priv,
+				   "Doubled ARP reply removed: ARP MSG = [src: %pM-%pI4 dst: %pM-%pI4]; dat_entry: %pM-%pI4\n",
+				   hw_src, &ip_src, hw_dst, &ip_dst,
+				   mac, &dat_entry->ip);
+			dropped = true;
+		}
 	}
 
 	/* Update our internal cache with both the IP addresses the node got
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index 790f62abfe03..49cef1a85639 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2387,7 +2387,7 @@ struct batadv_dat_entry {
 	__be32 ip;
 
 	/** @mac_addr: the MAC address associated to the stored IPv4 */
-	u8 mac_addr[ETH_ALEN];
+	atomic64_t mac_addr;
 
 	/** @vid: the vlan ID associated to this entry */
 	unsigned short vid;
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index b34e4bb0e750..96d41267f14a 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -268,9 +268,14 @@ static int bnep_rx_extension(struct bnep_session *s, struct sk_buff *skb)
 
 		BT_DBG("type 0x%x len %d", h->type, h->len);
 
+		if (skb->len < h->len) {
+			err = -EILSEQ;
+			break;
+		}
+
 		switch (h->type & BNEP_TYPE_MASK) {
 		case BNEP_EXT_CONTROL:
-			bnep_rx_control(s, skb->data, skb->len);
+			bnep_rx_control(s, skb->data, h->len);
 			break;
 
 		default:
@@ -354,6 +359,11 @@ static int bnep_rx_frame(struct bnep_session *s, struct sk_buff *skb)
 			goto badframe;
 	}
 
+	if ((type & BNEP_TYPE_MASK) == BNEP_CONTROL) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	/* Strip 802.1p header */
 	if (ntohs(s->eh.h_proto) == ETH_P_8021Q) {
 		if (!skb_pull(skb, 4))
@@ -432,6 +442,11 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 		goto send;
 	}
 
+	if (skb->len < ETH_HLEN) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	iv[il++] = (struct kvec) { &type, 1 };
 	len++;
 
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
index cc1cff63194f..5d9d851db926 100644
--- a/net/bluetooth/bnep/netdev.c
+++ b/net/bluetooth/bnep/netdev.c
@@ -169,6 +169,12 @@ static netdev_tx_t bnep_net_xmit(struct sk_buff *skb,
 
 	BT_DBG("skb %p, dev %p", skb, dev);
 
+	if (!pskb_may_pull(skb, ETH_HLEN)) {
+		dev->stats.tx_dropped++;
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 #ifdef CONFIG_BT_BNEP_MC_FILTER
 	if (bnep_net_mc_filter(skb, s)) {
 		kfree_skb(skb);
@@ -221,7 +227,7 @@ void bnep_net_setup(struct net_device *dev)
 	dev->addr_len = ETH_ALEN;
 
 	ether_setup(dev);
-	dev->min_mtu = 0;
+	dev->min_mtu = ETH_MIN_MTU;
 	dev->max_mtu = ETH_MAX_MTU;
 	dev->priv_flags &= ~IFF_TX_SKB_SHARING;
 	dev->netdev_ops = &bnep_netdev_ops;
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index 78c583dd64a6..2f1d0ccb5f9c 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -165,6 +165,7 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 {
 	struct hci_filter *flt;
 	int flt_type, flt_event;
+	u8 event;
 
 	/* Apply filter */
 	flt = &hci_pi(sk)->filter;
@@ -178,7 +179,11 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	if (hci_skb_pkt_type(skb) != HCI_EVENT_PKT)
 		return false;
 
-	flt_event = (*(__u8 *)skb->data & HCI_FLT_EVENT_BITS);
+	if (skb->len < 1)
+		return true;
+
+	event = *(__u8 *)skb->data;
+	flt_event = event & HCI_FLT_EVENT_BITS;
 
 	if (!hci_test_bit(flt_event, &flt->event_mask))
 		return true;
@@ -187,11 +192,17 @@ static bool is_filtered_packet(struct sock *sk, struct sk_buff *skb)
 	if (!flt->opcode)
 		return false;
 
-	if (flt_event == HCI_EV_CMD_COMPLETE &&
+	if (event == HCI_EV_CMD_COMPLETE && skb->len < 5)
+		return true;
+
+	if (event == HCI_EV_CMD_COMPLETE &&
 	    flt->opcode != get_unaligned((__le16 *)(skb->data + 3)))
 		return true;
 
-	if (flt_event == HCI_EV_CMD_STATUS &&
+	if (event == HCI_EV_CMD_STATUS && skb->len < 6)
+		return true;
+
+	if (event == HCI_EV_CMD_STATUS &&
 	    flt->opcode != get_unaligned((__le16 *)(skb->data + 4)))
 		return true;
 
@@ -1837,7 +1848,8 @@ static int hci_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 		u16 ocf = hci_opcode_ocf(opcode);
 
 		if (((ogf > HCI_SFLT_MAX_OGF) ||
-		     !hci_test_bit(ocf & HCI_FLT_OCF_BITS,
+		     (ocf > HCI_FLT_OCF_BITS) ||
+		     !hci_test_bit(ocf,
 				   &hci_sec_filter.ocf_mask[ogf])) &&
 		    !capable(CAP_NET_RAW)) {
 			err = -EPERM;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1122566c4b50..15466df70019 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1477,7 +1477,7 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	if (chan == conn->chan)
 		return;
 
-	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+	if (!test_bit(FLAG_DEFER_SETUP, &chan->flags))
 		return;
 
 	pid = chan->ops->get_peer_pid(chan);
@@ -1487,6 +1487,9 @@ static void l2cap_ecred_defer_connect(struct l2cap_chan *chan, void *data)
 	    chan->mode != L2CAP_MODE_EXT_FLOWCTL || chan->state != BT_CONNECT)
 		return;
 
+	if (!test_and_clear_bit(FLAG_DEFER_SETUP, &chan->flags))
+		return;
+
 	if (test_and_set_bit(FLAG_ECRED_CONN_REQ_SENT, &chan->flags))
 		return;
 
@@ -4061,6 +4064,9 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 {
 	struct l2cap_ecred_rsp_data *rsp = data;
 
+	if (chan->mode != L2CAP_MODE_EXT_FLOWCTL)
+		return;
+
 	/* Check if channel for outgoing connection or if it wasn't deferred
 	 * since in those cases it must be skipped.
 	 */
@@ -4071,6 +4077,10 @@ static void l2cap_ecred_rsp_defer(struct l2cap_chan *chan, void *data)
 	/* Reset ident so only one response is sent */
 	chan->ident = 0;
 
+	/* Unreachable, check in l2cap_ecred_conn_req. If reached, drop rest */
+	if (WARN_ON_ONCE(rsp->count >= ARRAY_SIZE(rsp->pdu.scid)))
+		rsp->pdu.rsp.result = cpu_to_le16(L2CAP_CR_LE_NO_MEM);
+
 	/* Include all channels pending with the same ident */
 	if (!rsp->pdu.rsp.result)
 		rsp->pdu.rsp.dcid[rsp->count++] = cpu_to_le16(chan->scid);
@@ -6048,6 +6058,7 @@ static int l2cap_le_connect_req(struct l2cap_conn *conn,
 	__set_chan_timer(chan, chan->ops->get_sndtimeo(chan));
 
 	chan->ident = cmd->ident;
+	chan->mode = L2CAP_MODE_LE_FLOWCTL;
 
 	if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 		l2cap_state_change(chan, BT_CONNECT2);
@@ -7685,9 +7696,17 @@ static int l2cap_stream_rx(struct l2cap_chan *chan, struct l2cap_ctrl *control,
 static int l2cap_data_rcv(struct l2cap_chan *chan, struct sk_buff *skb)
 {
 	struct l2cap_ctrl *control = &bt_cb(skb)->l2cap;
-	u16 len;
+	u16 len, min_len;
 	u8 event;
 
+	min_len = test_bit(FLAG_EXT_CTRL, &chan->flags) ?
+		  L2CAP_EXT_CTRL_SIZE : L2CAP_ENH_CTRL_SIZE;
+	if (chan->fcs == L2CAP_FCS_CRC16)
+		min_len += L2CAP_FCS_SIZE;
+
+	if (skb->len < min_len)
+		goto drop;
+
 	__unpack_control(chan, skb);
 
 	len = skb->len;
@@ -8044,6 +8063,8 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
+	l2cap_chan_lock(chan);
+
 	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
@@ -8061,6 +8082,7 @@ static void l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm,
 	}
 
 drop:
+	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 free_skb:
 	kfree_skb(skb);
@@ -8106,6 +8128,11 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 		break;
 
 	case L2CAP_CID_CONN_LESS:
+		if (skb->len < L2CAP_PSMLEN_SIZE) {
+			kfree_skb(skb);
+			break;
+		}
+
 		psm = get_unaligned((__le16 *) skb->data);
 		skb_pull(skb, L2CAP_PSMLEN_SIZE);
 		l2cap_conless_channel(conn, psm, skb);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9d834f225462..018b5a0c87ce 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1548,18 +1548,9 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 	struct l2cap_pinfo *pi;
 	int err;
 
-	/* To avoid race with sock_release, a chan lock needs to be added here
-	 * to synchronize the sock.
-	 */
-	l2cap_chan_hold(chan);
-	l2cap_chan_lock(chan);
 	sk = chan->data;
-
-	if (!sk) {
-		l2cap_chan_unlock(chan);
-		l2cap_chan_put(chan);
+	if (!sk)
 		return -ENXIO;
-	}
 
 	pi = l2cap_pi(sk);
 	lock_sock(sk);
@@ -1611,8 +1602,6 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *skb)
 
 done:
 	release_sock(sk);
-	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
 
 	return err;
 }
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 828c18d91e82..99347e95805b 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1782,6 +1782,12 @@ static struct rfcomm_session *rfcomm_recv_frame(struct rfcomm_session *s,
 		return s;
 	}
 
+	if (skb->len < sizeof(*hdr) + 1 ||
+	    (!__test_ea(hdr->len) && skb->len < sizeof(*hdr) + 2)) {
+		kfree_skb(skb);
+		return s;
+	}
+
 	dlci = __get_dlci(hdr->addr);
 	type = __get_type(hdr->ctrl);
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 03b6d0f0d34b..60bfa61a2005 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -783,8 +783,10 @@ static int rfcomm_sock_getsockopt_old(struct socket *sock, int optname, char __u
 		break;
 
 	case RFCOMM_CONNINFO:
-		if (sk->sk_state != BT_CONNECTED &&
-					!rfcomm_pi(sk)->dlc->defer_setup) {
+		if ((sk->sk_state != BT_CONNECTED &&
+		     !(sk->sk_state == BT_CONNECT2 &&
+		       rfcomm_pi(sk)->dlc->defer_setup)) ||
+		    !rfcomm_pi(sk)->dlc->session) {
 			err = -ENOTCONN;
 			break;
 		}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index eb572c8ea49b..9ebf350a28d4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -2296,6 +2296,23 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* SMP over BR/EDR only covers cross-transport key derivation; the
+	 * Security Request procedure has no BR/EDR counterpart. Reject it
+	 * here, otherwise smp_ltk_encrypt() finds the peer's LE LTK
+	 * (ADDR_LE_DEV_PUBLIC and BDADDR_BREDR are both 0) and issues
+	 * HCI_OP_LE_START_ENC on the ACL handle, which the controller
+	 * rejects and hci_cs_le_start_enc() turns into a disconnect. Reply
+	 * without smp_failure(): this is not an authentication failure, and
+	 * MGMT_EV_AUTH_FAILED would make bluetoothd drop the device.
+	 */
+	if (hcon->type != LE_LINK) {
+		u8 reason = SMP_CMD_NOTSUPP;
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(reason),
+			     &reason);
+		return 0;
+	}
+
 	if (skb->len < sizeof(*rp))
 		return SMP_INVALID_PARAMS;
 
diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
index 742b3a24f9c8..a411b7fa5f9d 100644
--- a/net/bridge/br_arp_nd_proxy.c
+++ b/net/bridge/br_arp_nd_proxy.c
@@ -162,7 +162,7 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, struct net_bridge *br,
 			return;
 		if (parp->ar_op != htons(ARPOP_RREQUEST) &&
 		    parp->ar_op != htons(ARPOP_RREPLY) &&
-		    (ipv4_is_zeronet(sip) || sip == tip)) {
+		    sip == tip) {
 			/* prevent flooding to neigh suppress ports */
 			BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
 			return;
@@ -260,6 +260,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	int ns_olen;
 	int i, len;
 	u8 *daddr;
+	bool dad;
 	u16 pvid;
 
 	if (!dev || skb_linearize(request))
@@ -298,8 +299,13 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 		}
 	}
 
+	dad = ipv6_addr_any(&ipv6_hdr(request)->saddr);
+
 	/* Ethernet header */
-	ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
+	if (dad)
+		ipv6_eth_mc_map(&in6addr_linklocal_allnodes, eth_hdr(reply)->h_dest);
+	else
+		ether_addr_copy(eth_hdr(reply)->h_dest, daddr);
 	ether_addr_copy(eth_hdr(reply)->h_source, n->ha);
 	eth_hdr(reply)->h_proto = htons(ETH_P_IPV6);
 	reply->protocol = htons(ETH_P_IPV6);
@@ -315,7 +321,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	pip6->priority = ipv6_hdr(request)->priority;
 	pip6->nexthdr = IPPROTO_ICMPV6;
 	pip6->hop_limit = 255;
-	pip6->daddr = ipv6_hdr(request)->saddr;
+	pip6->daddr = dad ? in6addr_linklocal_allnodes : ipv6_hdr(request)->saddr;
 	pip6->saddr = *(struct in6_addr *)n->primary_key;
 
 	skb_pull(reply, sizeof(struct ipv6hdr));
@@ -328,7 +334,7 @@ static void br_nd_send(struct net_bridge *br, struct net_bridge_port *p,
 	na->icmph.icmp6_type = NDISC_NEIGHBOUR_ADVERTISEMENT;
 	na->icmph.icmp6_router = (n->flags & NTF_ROUTER) ? 1 : 0;
 	na->icmph.icmp6_override = 1;
-	na->icmph.icmp6_solicited = 1;
+	na->icmph.icmp6_solicited = dad ? 0 : 1;
 	na->target = ns->target;
 	ether_addr_copy(&na->opt[2], n->ha);
 	na->opt[0] = ND_OPT_TARGET_LL_ADDR;
@@ -429,7 +435,7 @@ void br_do_suppress_nd(struct sk_buff *skb, struct net_bridge *br,
 	saddr = &iphdr->saddr;
 	daddr = &iphdr->daddr;
 
-	if (ipv6_addr_any(saddr) || !ipv6_addr_cmp(saddr, daddr)) {
+	if (!ipv6_addr_cmp(saddr, daddr)) {
 		/* prevent flooding to neigh suppress ports */
 		BR_INPUT_SKB_CB(skb)->proxyarp_replied = 1;
 		return;
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index ab04397dfe36..5cc65f51b378 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -3357,8 +3357,6 @@ void br_multicast_dev_del(struct net_bridge *br)
 
 	br_multicast_gc(&deleted_head);
 	cancel_work_sync(&br->mcast_gc_work);
-
-	rcu_barrier();
 }
 
 int br_multicast_set_router(struct net_bridge *br, unsigned long val)
diff --git a/net/bridge/br_stp_bpdu.c b/net/bridge/br_stp_bpdu.c
index 0e4572f31330..1917d11411d7 100644
--- a/net/bridge/br_stp_bpdu.c
+++ b/net/bridge/br_stp_bpdu.c
@@ -52,7 +52,10 @@ static void br_send_bpdu(struct net_bridge_port *p,
 			    LLC_SAP_BSPAN, LLC_PDU_CMD);
 	llc_pdu_init_as_ui_cmd(skb);
 
-	llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr);
+	if (llc_mac_hdr_init(skb, p->dev->dev_addr, p->br->group_addr)) {
+		kfree_skb(skb);
+		return;
+	}
 
 	skb_reset_mac_header(skb);
 
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index e1f01aef263e..fac52fe7a587 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -59,7 +59,7 @@ static struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
 
 	num_mon = ceph_decode_32(&p);
 
-	if (num_mon > CEPH_MAX_MON)
+	if (num_mon == 0 || num_mon > CEPH_MAX_MON)
 		goto bad;
 	m = kmalloc(struct_size(m, mon_inst, num_mon), GFP_NOFS);
 	if (m == NULL)
diff --git a/net/core/dev.c b/net/core/dev.c
index 9183fbc434d2..244dc6f7929d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2638,7 +2638,7 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 		dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
 
 		tc = netdev_txq_to_tc(dev, index);
-		if (tc < 0)
+		if (tc < 0 || tc >= num_tc)
 			return -EINVAL;
 	}
 
@@ -8715,7 +8715,7 @@ int dev_change_tx_queue_len(struct net_device *dev, unsigned long new_len)
 	unsigned int orig_len = dev->tx_queue_len;
 	int res;
 
-	if (new_len != (unsigned int)new_len)
+	if (new_len > S16_MAX)
 		return -ERANGE;
 
 	if (new_len != orig_len) {
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index 66112797f1aa..712f151aa4e2 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -140,9 +140,8 @@ static struct sk_buff *reset_per_cpu_data(struct per_cpu_dm_data *data)
 
 	al = sizeof(struct net_dm_alert_msg);
 	al += dm_hit_limit * sizeof(struct net_dm_drop_point);
-	al += sizeof(struct nlattr);
 
-	skb = genlmsg_new(al, GFP_KERNEL);
+	skb = genlmsg_new(nla_total_size(al), GFP_KERNEL);
 
 	if (!skb)
 		goto err;
@@ -1149,6 +1148,7 @@ static int net_dm_trace_on_set(struct netlink_ext_ack *extack)
 
 err_unregister_trace:
 	unregister_trace_kfree_skb(ops->kfree_skb_probe, NULL);
+	tracepoint_synchronize_unregister();
 err_module_put:
 	for_each_possible_cpu(cpu) {
 		struct per_cpu_dm_data *data = &per_cpu(dm_cpu_data, cpu);
diff --git a/net/core/filter.c b/net/core/filter.c
index 0338dc0bf1e9..b885b8b9b4af 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3777,12 +3777,6 @@ static u32 __bpf_skb_min_len(const struct sk_buff *skb)
 		if (offset > 0)
 			min_len = offset;
 	}
-	if (skb->ip_summed == CHECKSUM_PARTIAL) {
-		offset = skb_checksum_start_offset(skb) +
-			 skb->csum_offset + sizeof(__sum16);
-		if (offset > 0)
-			min_len = offset;
-	}
 	return min_len;
 }
 
@@ -3799,6 +3793,11 @@ static int bpf_skb_grow_rcsum(struct sk_buff *skb, unsigned int new_len)
 
 static int bpf_skb_trim_rcsum(struct sk_buff *skb, unsigned int new_len)
 {
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    new_len < skb_checksum_start_offset(skb) + skb->csum_offset +
+		      sizeof(__sum16))
+		skb->ip_summed = CHECKSUM_NONE;
+
 	return __skb_trim_rcsum(skb, new_len);
 }
 
@@ -7626,6 +7625,8 @@ static const struct bpf_func_proto *
 lwt_seg6local_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 {
 	switch (func_id) {
+	case BPF_FUNC_skb_pull_data:
+		return NULL;
 #if IS_ENABLED(CONFIG_IPV6_SEG6_BPF)
 	case BPF_FUNC_lwt_seg6_store_bytes:
 		return &bpf_lwt_seg6_store_bytes_proto;
@@ -8972,11 +8973,12 @@ u32 bpf_sock_convert_ctx_access(enum bpf_access_type type,
 				       target_size));
 		*insn++ = BPF_JMP_IMM(BPF_JNE, si->dst_reg, NO_QUEUE_MAPPING,
 				      1);
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #else
-		*insn++ = BPF_MOV64_IMM(si->dst_reg, -1);
-		*target_size = 2;
+		*insn++ = BPF_MOV32_IMM(si->dst_reg, -1);
 #endif
+		*target_size = sizeof_field(struct bpf_sock, rx_queue_mapping);
+
 		break;
 	}
 
@@ -9516,18 +9518,7 @@ static u32 sock_ops_convert_ctx_access(enum bpf_access_type type,
 		break;
 
 	case offsetof(struct bpf_sock_ops, rtt_min):
-		BUILD_BUG_ON(sizeof_field(struct tcp_sock, rtt_min) !=
-			     sizeof(struct minmax));
-		BUILD_BUG_ON(sizeof(struct minmax) <
-			     sizeof(struct minmax_sample));
-
-		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(
-						struct bpf_sock_ops_kern, sk),
-				      si->dst_reg, si->src_reg,
-				      offsetof(struct bpf_sock_ops_kern, sk));
-		*insn++ = BPF_LDX_MEM(BPF_W, si->dst_reg, si->dst_reg,
-				      offsetof(struct tcp_sock, rtt_min) +
-				      sizeof_field(struct minmax_sample, t));
+		SOCK_OPS_GET_FIELD(rtt_min, rtt_min.s[0].v, struct tcp_sock);
 		break;
 
 	case offsetof(struct bpf_sock_ops, bpf_sock_ops_cb_flags):
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index faea3bf36d49..224348001368 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -278,7 +278,7 @@ static struct sk_buff *__build_skb_around(struct sk_buff *skb,
 	skb->head = data;
 	skb->data = data;
 	skb_reset_tail_pointer(skb);
-	skb->end = skb->tail + size;
+	skb_set_end_offset(skb, size);
 	skb->mac_header = (typeof(skb->mac_header))~0U;
 	skb->transport_header = (typeof(skb->transport_header))~0U;
 
@@ -1686,11 +1686,10 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	skb->head     = data;
 	skb->head_frag = 0;
 	skb->data    += off;
+
+	skb_set_end_offset(skb, size);
 #ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end      = size;
 	off           = nhead;
-#else
-	skb->end      = skb->head + size;
 #endif
 	skb->tail	      += off;
 	skb_headers_offset_update(skb, nhead);
@@ -1738,6 +1737,38 @@ struct sk_buff *skb_realloc_headroom(struct sk_buff *skb, unsigned int headroom)
 }
 EXPORT_SYMBOL(skb_realloc_headroom);
 
+int __skb_unclone_keeptruesize(struct sk_buff *skb, gfp_t pri)
+{
+	unsigned int saved_end_offset, saved_truesize;
+	struct skb_shared_info *shinfo;
+	int res;
+
+	saved_end_offset = skb_end_offset(skb);
+	saved_truesize = skb->truesize;
+
+	res = pskb_expand_head(skb, 0, 0, pri);
+	if (res)
+		return res;
+
+	skb->truesize = saved_truesize;
+
+	if (likely(skb_end_offset(skb) == saved_end_offset))
+		return 0;
+
+	shinfo = skb_shinfo(skb);
+
+	/* We are about to change back skb->end,
+	 * we need to move skb_shinfo() to its new location.
+	 */
+	memmove(skb->head + saved_end_offset,
+		shinfo,
+		offsetof(struct skb_shared_info, frags[shinfo->nr_frags]));
+
+	skb_set_end_offset(skb, saved_end_offset);
+
+	return 0;
+}
+
 /**
  *	skb_expand_head - reallocate header of &sk_buff
  *	@skb: buffer to reallocate
@@ -3388,19 +3419,7 @@ EXPORT_SYMBOL(skb_split);
  */
 static int skb_prepare_for_shift(struct sk_buff *skb)
 {
-	int ret = 0;
-
-	if (skb_cloned(skb)) {
-		/* Save and restore truesize: pskb_expand_head() may reallocate
-		 * memory where ksize(kmalloc(S)) != ksize(kmalloc(S)), but we
-		 * cannot change truesize at this point.
-		 */
-		unsigned int save_truesize = skb->truesize;
-
-		ret = pskb_expand_head(skb, 0, 0, GFP_ATOMIC);
-		skb->truesize = save_truesize;
-	}
-	return ret;
+	return skb_unclone_keeptruesize(skb, GFP_ATOMIC);
 }
 
 /**
@@ -5104,7 +5123,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct ipv6_opt_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct ipv6_opt_hdr));
 			if (err < 0)
 				goto out;
 
@@ -5119,7 +5139,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct ip_auth_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct ip_auth_hdr));
 			if (err < 0)
 				goto out;
 
@@ -5134,7 +5155,8 @@ static int skb_checksum_setup_ipv6(struct sk_buff *skb, bool recalculate)
 			err = skb_maybe_pull_tail(skb,
 						  off +
 						  sizeof(struct frag_hdr),
-						  MAX_IPV6_HDR_LEN);
+						  off +
+						  sizeof(struct frag_hdr));
 			if (err < 0)
 				goto out;
 
@@ -5924,6 +5946,13 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	}
 	skb->protocol = next_proto;
 
+	/* The last label is gone, so the inner header recorded by
+	 * skb_mpls_push() no longer describes this packet. Drop it, or a
+	 * later push keeps the stale offset.
+	 */
+	if (!eth_p_mpls(next_proto))
+		skb->inner_protocol = 0;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(skb_mpls_pop);
@@ -6117,11 +6146,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb->head = data;
 	skb->data = data;
 	skb->head_frag = 0;
-#ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end = size;
-#else
-	skb->end = skb->head + size;
-#endif
+	skb_set_end_offset(skb, size);
 	skb_set_tail_pointer(skb, skb_headlen(skb));
 	skb_headers_offset_update(skb, 0);
 	skb->cloned = 0;
@@ -6261,11 +6286,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 	skb->head = data;
 	skb->head_frag = 0;
 	skb->data = data;
-#ifdef NET_SKBUFF_DATA_USES_OFFSET
-	skb->end = size;
-#else
-	skb->end = skb->head + size;
-#endif
+	skb_set_end_offset(skb, size);
 	skb_reset_tail_pointer(skb);
 	skb_headers_offset_update(skb, 0);
 	skb->cloned   = 0;
diff --git a/net/core/sock.c b/net/core/sock.c
index b51a154ec591..07a90a08a4ed 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3172,7 +3172,14 @@ int sock_gettstamp(struct socket *sock, void __user *userstamp,
 	struct sock *sk = sock->sk;
 	struct timespec64 ts;
 
-	sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+	/* sk->sk_flags must only be changed under the socket lock,
+	 * because sock_set_flag() uses non atomic operations.
+	 */
+	if (!sock_flag(sk, SOCK_TIMESTAMP)) {
+		lock_sock(sk);
+		sock_enable_timestamp(sk, SOCK_TIMESTAMP);
+		release_sock(sk);
+	}
 	ts = ktime_to_timespec64(sock_read_timestamp(sk));
 	if (ts.tv_sec == -1)
 		return -ENOENT;
diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index f3c8f91dbe2c..8cd712727c49 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -209,7 +209,8 @@ void hsr_nl_ringerror(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN],
 		goto nla_put_failure;
 
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(port->dev),
+				skb, 0, 0, GFP_ATOMIC);
 
 	return;
 
@@ -245,8 +246,12 @@ void hsr_nl_nodedown(struct hsr_priv *hsr, unsigned char addr[ETH_ALEN])
 	if (res < 0)
 		goto nla_put_failure;
 
+	rcu_read_lock();
+	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	genlmsg_end(skb, msg_head);
-	genlmsg_multicast(&hsr_genl_family, skb, 0, 0, GFP_ATOMIC);
+	genlmsg_multicast_netns(&hsr_genl_family, dev_net(master->dev),
+				skb, 0, 0, GFP_ATOMIC);
+	rcu_read_unlock();
 
 	return;
 
diff --git a/net/ieee802154/6lowpan/core.c b/net/ieee802154/6lowpan/core.c
index 3297e7fa9945..e6f64b6ed184 100644
--- a/net/ieee802154/6lowpan/core.c
+++ b/net/ieee802154/6lowpan/core.c
@@ -145,7 +145,7 @@ static int lowpan_newlink(struct net *src_net, struct net_device *ldev,
 	wdev = dev_get_by_index(dev_net(ldev), nla_get_u32(tb[IFLA_LINK]));
 	if (!wdev)
 		return -ENODEV;
-	if (wdev->type != ARPHRD_IEEE802154) {
+	if (wdev->type != ARPHRD_IEEE802154 || !wdev->ieee802154_ptr) {
 		dev_put(wdev);
 		return -EINVAL;
 	}
diff --git a/net/ipv4/arp.c b/net/ipv4/arp.c
index 5f2788b87dfd..3739f109cd16 100644
--- a/net/ipv4/arp.c
+++ b/net/ipv4/arp.c
@@ -1201,6 +1201,7 @@ int arp_ioctl(struct net *net, unsigned int cmd, void __user *arg)
 		err = copy_from_user(&r, arg, sizeof(struct arpreq));
 		if (err)
 			return -EFAULT;
+		r.arp_dev[IFNAMSIZ - 1] = '\0';
 		break;
 	default:
 		return -EINVAL;
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index a270951386e1..cdf85a540800 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -202,6 +202,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	return 1;
 }
 
+#define FIB_MAX_AUTO_TABLE_ID  4096
+
 static struct fib_table *fib_empty_table(struct net *net)
 {
 	u32 id = 1;
@@ -210,7 +212,7 @@ static struct fib_table *fib_empty_table(struct net *net)
 		if (!fib_get_table(net, id))
 			return fib_new_table(net, id);
 
-		if (id++ == RT_TABLE_MAX)
+		if (id++ == FIB_MAX_AUTO_TABLE_ID)
 			break;
 	}
 	return NULL;
diff --git a/net/ipv4/fou_core.c b/net/ipv4/fou_core.c
index 118b48279da3..556323c687e5 100644
--- a/net/ipv4/fou_core.c
+++ b/net/ipv4/fou_core.c
@@ -610,6 +610,10 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	/* Initial for fou type */
 	switch (cfg->type) {
 	case FOU_ENCAP_DIRECT:
+		if (!cfg->protocol) {
+			err = -EINVAL;
+			goto error;
+		}
 		tunnel_cfg.encap_rcv = fou_udp_recv;
 		tunnel_cfg.gro_receive = fou_gro_receive;
 		tunnel_cfg.gro_complete = fou_gro_complete;
@@ -639,9 +643,9 @@ static int fou_create(struct net *net, struct fou_cfg *cfg,
 	return 0;
 
 error:
-	kfree(fou);
 	if (sock)
 		udp_tunnel_sock_release(sock);
+	kfree_rcu(fou, rcu);
 
 	return err;
 }
diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 213d29fe190c..edab2f31fd85 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -1410,6 +1410,12 @@ static int ipgre_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
+	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
+		NL_SET_ERR_MSG(extack,
+			       "Enabling collect_md on an existing device is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
@@ -1442,6 +1448,12 @@ static int erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (!rtnl_dev_link_net_capable(dev, t->net))
 		return -EPERM;
 
+	if (data && data[IFLA_GRE_COLLECT_METADATA] && !t->collect_md) {
+		NL_SET_ERR_MSG(extack,
+			       "Enabling collect_md on an existing device is not supported");
+		return -EOPNOTSUPP;
+	}
+
 	err = ipgre_newlink_encap_setup(dev, data);
 	if (err)
 		return err;
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index b35153758fdf..ef523a29b0bb 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -250,6 +250,9 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	eth_header(skb, skb->dev, htons(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
 
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
 	return skb->len;
 }
 
@@ -353,6 +356,9 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	eth_header(skb, skb->dev, htons(eh.h_proto), eh.h_source, eh.h_dest, 0);
 	skb_reset_mac_header(skb);
 
+	if (skb_valid_dst(skb))
+		skb_dst_drop(skb);
+
 	return skb->len;
 }
 
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 8de1a9d5fc15..6861d3ecec64 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -51,6 +51,8 @@ static int comp_sack_nr_max = 255;
 static u32 u32_max_div_HZ = UINT_MAX / HZ;
 static int one_day_secs = 24 * 3600;
 
+static int tcp_min_rcvbuf = 4096;
+
 /* obsolete */
 static int sysctl_tcp_low_latency __read_mostly;
 
@@ -1262,7 +1264,7 @@ static struct ctl_table ipv4_net_table[] = {
 		.maxlen		= sizeof(init_net.ipv4.sysctl_tcp_rmem),
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
-		.extra1		= SYSCTL_ONE,
+		.extra1		= &tcp_min_rcvbuf,
 	},
 	{
 		.procname	= "tcp_comp_sack_delay_ns",
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 50af55778617..43b718dd9583 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5829,6 +5829,7 @@ static bool tcp_validate_incoming(struct sock *sk, struct sk_buff *skb,
  *	  or pure receivers (this means either the sequence number or the ack
  *	  value must stay constant)
  *	- Unexpected TCP option.
+ *	- ACK sequence number is outside [SND.UNA, SND.NXT].
  *
  *	When these conditions are not satisfied it drops into a standard
  *	receive procedure patterned after RFC793 to handle all cases.
@@ -5876,7 +5877,7 @@ void tcp_rcv_established(struct sock *sk, struct sk_buff *skb)
 
 	if ((tcp_flag_word(th) & TCP_HP_BITS) == tp->pred_flags &&
 	    TCP_SKB_CB(skb)->seq == tp->rcv_nxt &&
-	    !after(TCP_SKB_CB(skb)->ack_seq, tp->snd_nxt)) {
+	    between(TCP_SKB_CB(skb)->ack_seq, tp->snd_una, tp->snd_nxt)) {
 		int tcp_header_len = tp->tcp_header_len;
 
 		/* Timestamp header prediction: tcp_header_len
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index e469f689cd5c..6bde4c463a89 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1560,7 +1560,7 @@ int tcp_fragment(struct sock *sk, enum tcp_queue tcp_queue,
 		return -ENOMEM;
 	}
 
-	if (skb_unclone(skb, gfp))
+	if (skb_unclone_keeptruesize(skb, gfp))
 		return -ENOMEM;
 
 	/* Get a new skb... force flag on. */
@@ -1669,7 +1669,7 @@ int tcp_trim_head(struct sock *sk, struct sk_buff *skb, u32 len)
 {
 	u32 delta_truesize;
 
-	if (skb_unclone(skb, GFP_ATOMIC))
+	if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
 		return -ENOMEM;
 
 	delta_truesize = __pskb_trim_head(skb, len);
@@ -3227,7 +3227,7 @@ int __tcp_retransmit_skb(struct sock *sk, struct sk_buff *skb, int segs)
 				 cur_mss, GFP_ATOMIC))
 			return -ENOMEM; /* We'll try again later. */
 	} else {
-		if (skb_unclone(skb, GFP_ATOMIC))
+		if (skb_unclone_keeptruesize(skb, GFP_ATOMIC))
 			return -ENOMEM;
 
 		diff = tcp_skb_pcount(skb);
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 3bb1855cdcb8..ad00a29ca7d4 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1160,6 +1160,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
 	ipv6_link_dev_addr(idev, ifa);
 
 	if (ifa->flags&IFA_F_TEMPORARY) {
+		/* manage_tempaddrs() relies on addresses being added to the head */
 		list_add(&ifa->tmp_list, &idev->tempaddr_list);
 		in6_ifa_hold(ifa);
 	}
@@ -2532,8 +2533,10 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			     __u32 valid_lft, __u32 prefered_lft,
 			     bool create, unsigned long now)
 {
-	u32 flags;
+	u32 orig_prefered_lft = prefered_lft;
 	struct inet6_ifaddr *ift;
+	bool reset_done = false;
+	u32 flags;
 
 	read_lock_bh(&idev->lock);
 	/* update all temporary addresses in the list */
@@ -2568,6 +2571,11 @@ static void manage_tempaddrs(struct inet6_dev *idev,
 			prefered_lft = max_prefered;
 
 		spin_lock(&ift->lock);
+		/* the first match is the most recent temp address */
+		if (!reset_done && orig_prefered_lft > 0) {
+			ift->regen_count = 0;
+			reset_done = true;
+		}
 		flags = ift->flags;
 		ift->valid_lft = valid_lft;
 		ift->prefered_lft = prefered_lft;
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 0230fa98a348..53b79a83e0e5 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -439,7 +439,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 	hdr->segments_left--;
 	addr = hdr->segments + hdr->segments_left;
 
-	skb_push(skb, sizeof(struct ipv6hdr));
+	skb_push(skb, -skb_network_offset(skb));
 
 	if (skb->ip_summed == CHECKSUM_COMPLETE)
 		seg6_update_csum(skb);
@@ -465,7 +465,7 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 		}
 		ipv6_hdr(skb)->hop_limit--;
 
-		skb_pull(skb, sizeof(struct ipv6hdr));
+		skb_pull(skb, skb_transport_offset(skb));
 		goto looped_back;
 	}
 
diff --git a/net/ipv6/exthdrs_core.c b/net/ipv6/exthdrs_core.c
index 49e31e4ae7b7..ce3724f49e33 100644
--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -271,6 +271,9 @@ int ipv6_find_hdr(const struct sk_buff *skb, unsigned int *offset,
 			hdrlen = ipv6_optlen(hp);
 
 		if (!found) {
+			if (skb->len - start < hdrlen)
+				return -EBADMSG;
+
 			nexthdr = hp->nexthdr;
 			start += hdrlen;
 		}
diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
index 12568b7ab703..306ce089dd07 100644
--- a/net/ipv6/ip6_fib.c
+++ b/net/ipv6/ip6_fib.c
@@ -83,7 +83,7 @@ static void fib6_walker_link(struct net *net, struct fib6_walker *w)
 static void fib6_walker_unlink(struct net *net, struct fib6_walker *w)
 {
 	write_lock_bh(&net->ipv6.fib6_walker_lock);
-	list_del(&w->lh);
+	list_del_init(&w->lh);
 	write_unlock_bh(&net->ipv6.fib6_walker_lock);
 }
 
@@ -2637,7 +2637,7 @@ static void *ipv6_route_seq_start(struct seq_file *seq, loff_t *pos)
 static bool ipv6_route_iter_active(struct ipv6_route_iter *iter)
 {
 	struct fib6_walker *w = &iter->w;
-	return w->node && !(w->state == FWS_U && w->node == w->root);
+	return w->node && !list_empty(&w->lh);
 }
 
 static void ipv6_route_native_seq_stop(struct seq_file *seq, void *v)
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index ff4a205ae73f..0c7211540402 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -2294,7 +2294,7 @@ static int ip6erspan_changelink(struct net_device *dev, struct nlattr *tb[],
 		return PTR_ERR(t);
 
 	ip6erspan_set_version(data, &p);
-	ip6gre_tunnel_unlink_md(ign, t);
+	ip6erspan_tunnel_unlink_md(ign, t);
 	ip6gre_tunnel_unlink(ign, t);
 	ip6erspan_tnl_change(t, &p, !tb[IFLA_MTU]);
 	ip6erspan_tunnel_link_md(ign, t);
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index c4a9866ea45b..7b141c227eef 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -2146,21 +2146,21 @@ static void mld_send_cr(struct inet6_dev *idev)
 
 static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 {
-	struct net *net = dev_net(dev);
-	struct sock *sk = net->ipv6.igmp_sk;
+	const struct in6_addr *snd_addr, *saddr;
+	int err, len, payload_len, full_len;
+	struct in6_addr addr_buf;
 	struct inet6_dev *idev;
 	struct sk_buff *skb;
 	struct mld_msg *hdr;
-	const struct in6_addr *snd_addr, *saddr;
-	struct in6_addr addr_buf;
 	int hlen = LL_RESERVED_SPACE(dev);
 	int tlen = dev->needed_tailroom;
-	int err, len, payload_len, full_len;
 	u8 ra[8] = { IPPROTO_ICMPV6, 0,
 		     IPV6_TLV_ROUTERALERT, 2, 0, 0,
 		     IPV6_TLV_PADN, 0 };
-	struct flowi6 fl6;
 	struct dst_entry *dst;
+	struct flowi6 fl6;
+	struct net *net;
+	struct sock *sk;
 
 	if (type == ICMPV6_MGM_REDUCTION)
 		snd_addr = &in6addr_linklocal_allrouters;
@@ -2171,20 +2171,21 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 	payload_len = len + sizeof(ra);
 	full_len = sizeof(struct ipv6hdr) + payload_len;
 
-	rcu_read_lock();
-	IP6_UPD_PO_STATS(net, __in6_dev_get(dev),
-		      IPSTATS_MIB_OUT, full_len);
-	rcu_read_unlock();
+	skb = alloc_skb(hlen + tlen + full_len, GFP_KERNEL);
 
-	skb = sock_alloc_send_skb(sk, hlen + tlen + full_len, 1, &err);
+	rcu_read_lock();
 
+	net = dev_net_rcu(dev);
+	idev = __in6_dev_get(dev);
+	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, full_len);
 	if (!skb) {
-		rcu_read_lock();
-		IP6_INC_STATS(net, __in6_dev_get(dev),
-			      IPSTATS_MIB_OUTDISCARDS);
+		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		rcu_read_unlock();
 		return;
 	}
+	sk = net->ipv6.igmp_sk;
+	skb_set_owner_w(skb, sk);
+
 	skb->priority = TC_PRIO_CONTROL;
 	skb_reserve(skb, hlen);
 
@@ -2209,9 +2210,6 @@ static void igmp6_send(struct in6_addr *addr, struct net_device *dev, int type)
 					 IPPROTO_ICMPV6,
 					 csum_partial(hdr, len, 0));
 
-	rcu_read_lock();
-	idev = __in6_dev_get(skb->dev);
-
 	icmpv6_flow_init(sk, &fl6, type,
 			 &ipv6_hdr(skb)->saddr, &ipv6_hdr(skb)->daddr,
 			 skb->dev->ifindex);
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index da136d25701a..9d5a2b4c6e2a 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -649,6 +649,11 @@ check_entry_size_and_hooks(struct ip6t_entry *e,
 	/* Clear counters and comefrom */
 	e->counters = ((struct xt_counters) { 0, 0 });
 	e->comefrom = 0;
+
+	/* set F_PROTO, else ip6_packet_match won't do the right thing. */
+	if (e->ipv6.proto)
+		e->ipv6.flags |= IP6T_F_PROTO;
+
 	return 0;
 }
 
diff --git a/net/ipv6/netfilter/ip6t_rpfilter.c b/net/ipv6/netfilter/ip6t_rpfilter.c
index 67c87a88cde4..b5def30c3127 100644
--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -61,7 +61,7 @@ static bool rpfilter_lookup_reverse6(struct net *net, const struct sk_buff *skb,
 		fl6.flowi6_oif = dev->ifindex;
 
 	rt = (void *)ip6_route_lookup(net, &fl6, skb, lookup_flags);
-	if (rt->dst.error)
+	if (rt->dst.error || !rt->rt6i_idev)
 		goto out;
 
 	if (rt->rt6i_flags & (RTF_REJECT|RTF_ANYCAST))
diff --git a/net/ipv6/netfilter/ip6t_rt.c b/net/ipv6/netfilter/ip6t_rt.c
index 278b52752f36..2f6261d06a07 100644
--- a/net/ipv6/netfilter/ip6t_rt.c
+++ b/net/ipv6/netfilter/ip6t_rt.c
@@ -96,7 +96,8 @@ static bool rt_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 			unsigned int i = 0;
 
 			for (temp = 0;
-			     temp < (unsigned int)((hdrlen - 8) / 16);
+			     temp < (unsigned int)((hdrlen - 8) / 16) &&
+			     i < rtinfo->addrnr;
 			     temp++) {
 				ap = skb_header_pointer(skb,
 							ptr
@@ -112,8 +113,6 @@ static bool rt_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 
 				if (ipv6_addr_equal(ap, &rtinfo->addrs[i]))
 					i++;
-				if (i == rtinfo->addrnr)
-					break;
 			}
 			if (i == rtinfo->addrnr)
 				return ret;
@@ -162,6 +161,12 @@ static int rt_mt6_check(const struct xt_mtchk_param *par)
 		pr_debug("too many addresses specified\n");
 		return -EINVAL;
 	}
+
+	if ((rtinfo->flags & IP6T_RT_FST_MASK) && !rtinfo->addrnr) {
+		pr_info_ratelimited("address list match requested but addrnr is 0\n");
+		return -EINVAL;
+	}
+
 	if ((rtinfo->flags & (IP6T_RT_RES | IP6T_RT_FST_MASK)) &&
 	    (!(rtinfo->flags & IP6T_RT_TYP) ||
 	     (rtinfo->rt_type != 0) ||
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 8e91efd45039..0439d9e6a960 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -775,9 +775,11 @@ static int rt6_nh_find_match(struct fib6_nh *nh, void *_arg)
 {
 	struct fib6_nh_frl_arg *arg = _arg;
 
-	arg->nh = nh;
-	return find_match(nh, arg->flags, arg->oif, arg->strict,
-			  arg->mpri, arg->do_rr);
+	if (find_match(nh, arg->flags, arg->oif, arg->strict, arg->mpri,
+		       arg->do_rr))
+		arg->nh = nh;
+
+	return 0;
 }
 
 static void __find_rr_leaf(struct fib6_info *f6i_start,
@@ -817,11 +819,10 @@ static void __find_rr_leaf(struct fib6_info *f6i_start,
 				res->nh = nexthop_fib6_nh(f6i->nh);
 				return;
 			}
-			if (nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_find_match,
-						     &arg)) {
-				matched = true;
-				nh = arg.nh;
-			}
+			nexthop_for_each_fib6_nh(f6i->nh, rt6_nh_find_match,
+						 &arg);
+			matched = !!arg.nh;
+			nh = arg.nh;
 		} else {
 			nh = f6i->fib6_nh;
 			if (find_match(nh, f6i->fib6_flags, oif, strict,
@@ -2206,6 +2207,7 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 {
 	struct fib6_result res = {};
 	struct rt6_info *rt = NULL;
+	bool have_oif_match;
 	int strict = 0;
 
 	WARN_ON_ONCE((flags & RT6_LOOKUP_F_DST_NOREF) &&
@@ -2222,7 +2224,9 @@ struct rt6_info *ip6_pol_route(struct net *net, struct fib6_table *table,
 	if (res.f6i == net->ipv6.fib6_null_entry)
 		goto out;
 
-	fib6_select_path(net, &res, fl6, oif, false, skb, strict);
+	have_oif_match = fl6->flowi6_iif == LOOPBACK_IFINDEX &&
+			 oif == res.nh->fib_nh_dev->ifindex;
+	fib6_select_path(net, &res, fl6, oif, have_oif_match, skb, strict);
 
 	/*Search through exception table */
 	rt = rt6_find_cached_rt(&res, &fl6->daddr, &fl6->saddr);
diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index cb494c67c944..5225946e0025 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -81,8 +81,8 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
 static struct genl_family seg6_genl_family;
 
 static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
-	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
-		.len = sizeof(struct in6_addr) },
+	[SEG6_ATTR_DST]				=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_ATTR_DSTLEN]			= { .type = NLA_S32, },
 	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
 	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 3c022d694a4e..ddec0f26b222 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -140,10 +140,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 		return false;
 
 	if (proto == IPPROTO_IPIP) {
+		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
 		int iif = IP6CB(skb)->iif;
 
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->iif = iif;
+		if (l3slave)
+			IPCB(skb)->flags |= IPSKB_L3SLAVE;
 	} else if (proto == IPPROTO_IPV6) {
 		bool l3slave = ipv6_l3mdev_skb(IP6CB(skb)->flags);
 		int iif = IP6CB(skb)->iif;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 12118d5d98a1..23310e6a0277 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1471,7 +1471,8 @@ static int tcp_v6_do_rcv(struct sock *sk, struct sk_buff *skb)
 	   by tcp. Feel free to propose better solution.
 					       --ANK (980728)
 	 */
-	if (np->rxopt.all && sk->sk_state != TCP_LISTEN)
+	if (np->rxopt.all &&
+	    !((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)))
 		opt_skb = skb_clone_and_charge_r(skb, sk);
 
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index a8fc778ce465..21128e50c2b9 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -26,7 +26,10 @@ EXPORT_SYMBOL(xfrm6_find_1stfragopt);
 void xfrm6_local_rxpmtu(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	fl6.flowi6_oif = sk->sk_bound_dev_if;
 	fl6.daddr = ipv6_hdr(skb)->daddr;
@@ -38,7 +41,10 @@ void xfrm6_local_error(struct sk_buff *skb, u32 mtu)
 {
 	struct flowi6 fl6;
 	const struct ipv6hdr *hdr;
-	struct sock *sk = skb->sk;
+	struct sock *sk = skb_to_full_sk(skb);
+
+	if (!sk)
+		return;
 
 	hdr = skb->encapsulation ? inner_ipv6_hdr(skb) : ipv6_hdr(skb);
 	fl6.fl6_dport = inet_sk(sk)->inet_dport;
diff --git a/net/llc/llc_c_ac.c b/net/llc/llc_c_ac.c
index 647c0554d04c..8e18b264408a 100644
--- a/net/llc/llc_c_ac.c
+++ b/net/llc/llc_c_ac.c
@@ -443,7 +443,7 @@ int llc_conn_ac_resend_i_xxx_x_set_0_or_send_rr(struct sock *sk,
 		if (likely(!rc))
 			llc_conn_send_pdu(sk, nskb);
 		else
-			kfree_skb(skb);
+			kfree_skb(nskb);
 	}
 	if (rc) {
 		nr = LLC_I_GET_NR(pdu);
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 942ace4af18d..188d8f92b024 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -127,6 +127,8 @@ int llc_sap_action_send_xid_r(struct llc_sap *sap, struct sk_buff *skb)
 	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
 	if (likely(!rc))
 		rc = dev_queue_xmit(nskb);
+	else
+		kfree_skb(nskb);
 out:
 	return rc;
 }
@@ -176,6 +178,8 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	rc = llc_mac_hdr_init(nskb, mac_sa, mac_da);
 	if (likely(!rc))
 		rc = dev_queue_xmit(nskb);
+	else
+		kfree_skb(nskb);
 out:
 	return rc;
 }
diff --git a/net/llc/llc_sap.c b/net/llc/llc_sap.c
index 6805ce43a055..2c1f0943e4c7 100644
--- a/net/llc/llc_sap.c
+++ b/net/llc/llc_sap.c
@@ -25,12 +25,12 @@
 #include <linux/llc.h>
 #include <linux/slab.h>
 
-static int llc_mac_header_len(unsigned short devtype)
+static int llc_mac_header_len(struct net_device *dev)
 {
-	switch (devtype) {
+	switch (dev->type) {
 	case ARPHRD_ETHER:
 	case ARPHRD_LOOPBACK:
-		return sizeof(struct ethhdr);
+		return LL_RESERVED_SPACE(dev);
 	}
 	return 0;
 }
@@ -51,7 +51,7 @@ struct sk_buff *llc_alloc_frame(struct sock *sk, struct net_device *dev,
 	int hlen = type == LLC_PDU_TYPE_U ? 3 : 4;
 	struct sk_buff *skb;
 
-	hlen += llc_mac_header_len(dev->type);
+	hlen += llc_mac_header_len(dev);
 	skb = alloc_skb(hlen + data_size, GFP_ATOMIC);
 
 	if (skb) {
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index f2629e56d1a5..afb1ad3e6ea1 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2951,6 +2951,9 @@ static int ieee80211_set_bitrate_mask(struct wiphy *wiphy,
 	if (!ieee80211_sdata_running(sdata))
 		return -ENETDOWN;
 
+	if (!(sdata->flags & IEEE80211_SDATA_IN_DRIVER))
+		return -ENETDOWN;
+
 	/*
 	 * If active validate the setting and reject it if it doesn't leave
 	 * at least one basic rate usable, since we really have to be able
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index fe8a7a87e513..0f79cb14763c 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -522,6 +522,9 @@ static ssize_t ieee80211_if_fmt_tsf(
 	struct ieee80211_local *local = sdata->local;
 	u64 tsf;
 
+	if (!ieee80211_sdata_running((struct ieee80211_sub_if_data *)sdata))
+		return -ENETDOWN;
+
 	tsf = drv_get_tsf(local, (struct ieee80211_sub_if_data *)sdata);
 
 	return scnprintf(buf, buflen, "0x%016llx\n", (unsigned long long) tsf);
@@ -535,6 +538,9 @@ static ssize_t ieee80211_if_parse_tsf(
 	int ret;
 	int tsf_is_delta = 0;
 
+	if (!ieee80211_sdata_running(sdata))
+		return -ENETDOWN;
+
 	if (strncmp(buf, "reset", 5) == 0) {
 		if (local->ops->reset_tsf) {
 			drv_reset_tsf(local, sdata);
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 9abec4f929ca..bb42a8588321 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -522,6 +522,8 @@ static void ieee80211_do_stop(struct ieee80211_sub_if_data *sdata,
 		RCU_INIT_POINTER(sdata->vif.chanctx_conf, NULL);
 		/* see comment in the default case below */
 		ieee80211_free_keys(sdata, true);
+		/* increased by AP value on ifup, so reset on ifdown */
+		sdata->crypto_tx_tailroom_needed_cnt = 0;
 		/* no need to tell driver */
 		break;
 	case NL80211_IFTYPE_MONITOR:
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 4b09cd19c4e0..6af86da48995 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1379,7 +1379,6 @@ int ieee80211_mesh_csa_beacon(struct ieee80211_sub_if_data *sdata,
 
 	ret = ieee80211_mesh_rebuild_beacon(sdata);
 	if (ret) {
-		tmp_csa_settings = rcu_dereference(ifmsh->csa);
 		RCU_INIT_POINTER(ifmsh->csa, NULL);
 		kfree_rcu(tmp_csa_settings, rcu_head);
 		return ret;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 66276122aed6..79f7f3812da9 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3119,13 +3119,15 @@ static void ieee80211_rx_mgmt_deauth(struct ieee80211_sub_if_data *sdata,
 				     struct ieee80211_mgmt *mgmt, size_t len)
 {
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	u16 reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+	u16 reason_code;
 
 	sdata_assert_lock(sdata);
 
-	if (len < 24 + 2)
+	if (len < offsetofend(struct ieee80211_mgmt, u.deauth.reason_code))
 		return;
 
+	reason_code = le16_to_cpu(mgmt->u.deauth.reason_code);
+
 	if (!ether_addr_equal(mgmt->bssid, mgmt->sa)) {
 		ieee80211_tdls_handle_disconnect(sdata, mgmt->sa, reason_code);
 		return;
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 695874db4fb2..87fc10959595 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3695,7 +3695,7 @@ struct sk_buff *ieee80211_tx_dequeue(struct ieee80211_hw *hw,
 		 * injected frames or EAPOL frames from the local station.
 		 */
 		if (unlikely(!(info->flags & IEEE80211_TX_CTL_INJECTED) &&
-			     ieee80211_is_data(hdr->frame_control) &&
+			     ieee80211_is_data_present(hdr->frame_control) &&
 			     !ieee80211_vif_is_mesh(&tx.sdata->vif) &&
 			     tx.sdata->vif.type != NL80211_IFTYPE_OCB &&
 			     !is_multicast_ether_addr(hdr->addr1) &&
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 7cb32340108e..16b286511977 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -2519,11 +2519,7 @@ int ieee80211_reconfig(struct ieee80211_local *local)
 			}
 			break;
 		case NL80211_IFTYPE_NAN:
-			res = ieee80211_reconfig_nan(sdata);
-			if (res < 0) {
-				ieee80211_handle_reconfig_failure(local);
-				return res;
-			}
+			WARN_ON(ieee80211_reconfig_nan(sdata));
 			break;
 		case NL80211_IFTYPE_WDS:
 		case NL80211_IFTYPE_AP_VLAN:
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2c6aef813473..fdebc451e23a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -581,11 +581,11 @@ static bool __mptcp_move_skbs_from_subflow(struct mptcp_sock *msk,
 			if (unlikely(map_remaining < len))
 				mptcp_dss_corruption(msk, ssk);
 		} else {
-			if (unlikely(!fin))
-				mptcp_dss_corruption(msk, ssk);
-
 			sk_eat_skb(ssk, skb);
 			done = true;
+
+			if (unlikely(!fin))
+				mptcp_dss_corruption(msk, ssk);
 		}
 
 		WRITE_ONCE(tp->copied_seq, seq);
@@ -1381,7 +1381,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	mptcp_set_timeout(sk, ssk);
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg->msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 
@@ -1891,7 +1891,7 @@ static void mptcp_worker(struct work_struct *work)
 		if (!mptcp_ext_cache_refill(msk))
 			break;
 	}
-	if (copied) {
+	if (copied && mss_now) {
 		tcp_push(ssk, msg.msg_flags, mss_now, tcp_sk(ssk)->nonagle,
 			 size_goal);
 		WRITE_ONCE(msk->allow_infinite_fallback, false);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index ac064c44079d..b64a50b22d62 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -314,7 +314,8 @@ struct mptcp_subflow_context {
 		mpc_map : 1,
 		backup : 1,
 		rx_eof : 1,
-		can_ack : 1;	    /* only after processing the remote a key */
+		can_ack : 1,	    /* only after processing the remote a key */
+		resetting : 1;	    /* subflow is resetting */
 	enum mptcp_data_avail data_avail;
 	u32	remote_nonce;
 	u64	thmac;
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index c9cf0fdbfbdc..fff70a5b06db 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -279,11 +279,20 @@ void mptcp_subflow_reset(struct sock *ssk)
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(ssk);
 	struct sock *sk = subflow->conn;
 
+	/* must hold: tcp_done() could drop last reference on parent */
+	sock_hold(sk);
+
+	subflow->resetting = 1;
+
+	/* No need to delay the actual close for to-be discarded data. */
+	__skb_queue_purge(&ssk->sk_receive_queue);
 	tcp_send_active_reset(ssk, GFP_ATOMIC);
 	tcp_done(ssk);
 	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags) &&
 	    schedule_work(&mptcp_sk(sk)->work))
-		sock_hold(sk);
+		return; /* worker will put sk for us */
+
+	sock_put(sk);
 }
 
 static void subflow_finish_connect(struct sock *sk, const struct sk_buff *skb)
@@ -1297,6 +1306,13 @@ static void subflow_state_change(struct sock *sk)
 
 	__subflow_state_change(sk);
 
+	/* Rx queue processing is unneeded, error reporting will take place at
+	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
+	 * fallback: subflow_sched_work_if_closed() would be a no-op.
+	 */
+	if (subflow->resetting)
+		return;
+
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_do_fallback(sk);
 		mptcp_rcv_space_init(mptcp_sk(parent), sk);
diff --git a/net/mptcp/syncookies.c b/net/mptcp/syncookies.c
index b5cac5701122..9474706641c1 100644
--- a/net/mptcp/syncookies.c
+++ b/net/mptcp/syncookies.c
@@ -26,7 +26,8 @@ struct join_entry {
 	u32 local_nonce;
 	u8 join_id;
 	u8 local_id;
-	u8 backup;
+	u8 backup:1,
+	   request_bkup:1;
 	u8 valid;
 };
 
@@ -63,6 +64,7 @@ static void mptcp_join_store_state(struct join_entry *entry,
 	entry->remote_nonce = subflow_req->remote_nonce;
 	entry->local_nonce = subflow_req->local_nonce;
 	entry->backup = subflow_req->backup;
+	entry->request_bkup = subflow_req->request_bkup;
 	entry->join_id = subflow_req->remote_id;
 	entry->local_id = subflow_req->local_id;
 	entry->valid = 1;
@@ -117,6 +119,7 @@ bool mptcp_token_join_cookie_init_state(struct mptcp_subflow_request_sock *subfl
 	subflow_req->remote_nonce = e->remote_nonce;
 	subflow_req->local_nonce = e->local_nonce;
 	subflow_req->backup = e->backup;
+	subflow_req->request_bkup = e->request_bkup;
 	subflow_req->remote_id = e->join_id;
 	subflow_req->local_id = e->local_id;
 	subflow_req->token = e->token;
diff --git a/net/netfilter/ipset/ip_set_hash_gen.h b/net/netfilter/ipset/ip_set_hash_gen.h
index 25550a694edc..6412215e638b 100644
--- a/net/netfilter/ipset/ip_set_hash_gen.h
+++ b/net/netfilter/ipset/ip_set_hash_gen.h
@@ -581,9 +581,10 @@ mtype_gc(struct work_struct *work)
 	set = gc->set;
 	h = set->data;
 
-	spin_lock_bh(&set->lock);
-	t = ipset_dereference_set(h->table, set);
+	rcu_read_lock_bh();
+	t = rcu_dereference_bh(h->table);
 	atomic_inc(&t->uref);
+	rcu_read_unlock_bh();
 	numof_locks = ahash_numof_locks(t->htable_bits);
 	r = gc->region++;
 	if (r >= numof_locks) {
@@ -592,7 +593,6 @@ mtype_gc(struct work_struct *work)
 	next_run = (IPSET_GC_PERIOD(set->timeout) * HZ) / numof_locks;
 	if (next_run < HZ/10)
 		next_run = HZ/10;
-	spin_unlock_bh(&set->lock);
 
 	mtype_gc_do(set, h, t, r);
 
@@ -868,15 +868,13 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 	key = HKEY(value, h->initval, t->htable_bits);
 	r = ahash_region(key);
 	atomic_inc(&t->uref);
+	rcu_read_unlock_bh();
 	elements = t->hregion[r].elements;
 	maxelem = t->maxelem;
 	if (elements >= maxelem) {
 		u32 e;
-		if (SET_WITH_TIMEOUT(set)) {
-			rcu_read_unlock_bh();
+		if (SET_WITH_TIMEOUT(set))
 			mtype_gc_do(set, h, t, r);
-			rcu_read_lock_bh();
-		}
 		maxelem = h->maxelem;
 		elements = 0;
 		for (e = 0; e < ahash_numof_locks(t->htable_bits); e++)
@@ -884,7 +882,6 @@ mtype_add(struct ip_set *set, void *value, const struct ip_set_ext *ext,
 		if (elements >= maxelem && SET_WITH_FORCEADD(set))
 			forceadd = true;
 	}
-	rcu_read_unlock_bh();
 
 	spin_lock_bh(&t->hregion[r].lock);
 	n = rcu_dereference_bh(hbucket(t, key));
diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index c3d2e70bb007..a49dd1a2ed08 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1841,6 +1841,12 @@ ip_vs_in_icmp(struct netns_ipvs *ipvs, struct sk_buff *skb, int *related,
 		/* Ensure the IP header is present in headroom */
 		if (!pskb_may_pull(skb, hlen_orig))
 			goto ignore_tunnel;
+		skb_set_transport_header(skb, hlen_orig);
+		/* Before now we may used ihl from skb frag, revalidate it after
+		 * copying it into skb head to prevent out-of-bounds access
+		 */
+		if (ip_hdr(skb)->ihl * 4 != hlen_orig)
+			goto ignore_tunnel;
 		IP_VS_DBG(12, "Sending ICMP for %pI4->%pI4: t=%u, c=%u, i=%u\n",
 			&ip_hdr(skb)->saddr, &ip_hdr(skb)->daddr,
 			type, code, ntohl(info));
diff --git a/net/netfilter/ipvs/ip_vs_sync.c b/net/netfilter/ipvs/ip_vs_sync.c
index 04ae99aacb85..f5c172432017 100644
--- a/net/netfilter/ipvs/ip_vs_sync.c
+++ b/net/netfilter/ipvs/ip_vs_sync.c
@@ -748,9 +748,9 @@ void ip_vs_sync_conn(struct netns_ipvs *ipvs, struct ip_vs_conn *cp, int pkts)
 	if (cp->flags & IP_VS_CONN_F_SEQ_MASK) {
 		*(p++) = IPVS_OPT_SEQ_DATA;
 		*(p++) = sizeof(struct ip_vs_sync_conn_options);
-		hton_seq((struct ip_vs_seq *)p, &cp->in_seq);
+		hton_seq(&cp->in_seq, (struct ip_vs_seq *)p);
 		p += sizeof(struct ip_vs_seq);
-		hton_seq((struct ip_vs_seq *)p, &cp->out_seq);
+		hton_seq(&cp->out_seq, (struct ip_vs_seq *)p);
 		p += sizeof(struct ip_vs_seq);
 	}
 	/* Handle pe data */
@@ -1000,10 +1000,10 @@ static void ip_vs_process_message_v0(struct netns_ipvs *ipvs, const char *buffer
 					pp->name, state);
 				continue;
 			}
-		} else {
-			if (state >= IP_VS_CTPL_S_LAST)
-				IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
-					  state);
+		} else if (state >= IP_VS_CTPL_S_LAST) {
+			IP_VS_DBG(7, "BACKUP v0, Invalid tpl state %u\n",
+				  state);
+			continue;
 		}
 
 		ip_vs_conn_fill_param(ipvs, AF_INET, s->protocol,
@@ -1160,10 +1160,10 @@ static inline int ip_vs_proc_sync_conn(struct netns_ipvs *ipvs, __u8 *p, __u8 *m
 			retc = 40;
 			goto out;
 		}
-	} else {
-		if (state >= IP_VS_CTPL_S_LAST)
-			IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n",
-				  state);
+	} else if (state >= IP_VS_CTPL_S_LAST) {
+		IP_VS_DBG(7, "BACKUP, Invalid tpl state %u\n", state);
+		retc = 40;
+		goto out;
 	}
 	if (ip_vs_conn_fill_param_sync(ipvs, af, s, &param, pe_data,
 				       pe_data_len, pe_name, pe_name_len)) {
diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
index 516a9f05a87a..3ea601a090e5 100644
--- a/net/netfilter/nf_conntrack_expect.c
+++ b/net/netfilter/nf_conntrack_expect.c
@@ -283,7 +283,7 @@ struct nf_conntrack_expect *nf_ct_expect_alloc(struct nf_conn *me)
 {
 	struct nf_conntrack_expect *new;
 
-	new = kmem_cache_alloc(nf_ct_expect_cachep, GFP_ATOMIC);
+	new = kmem_cache_zalloc(nf_ct_expect_cachep, GFP_ATOMIC);
 	if (!new)
 		return NULL;
 
@@ -347,6 +347,7 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
 #if IS_ENABLED(CONFIG_NF_NAT)
 	memset(&exp->saved_addr, 0, sizeof(exp->saved_addr));
 	memset(&exp->saved_proto, 0, sizeof(exp->saved_proto));
+	exp->dir = 0;
 #endif
 }
 EXPORT_SYMBOL_GPL(nf_ct_expect_init);
diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 46bdc3808116..ae8d13ec8599 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -989,6 +989,8 @@ static int ctnetlink_start(struct netlink_callback *cb)
 	}
 
 	cb->data = filter;
+	if (filter)
+		cb->answer_flags = NLM_F_DUMP_FILTERED;
 	return 0;
 }
 
@@ -3540,8 +3542,6 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 	if (cda[CTA_EXPECT_FLAGS]) {
 		exp->flags = ntohl(nla_get_be32(cda[CTA_EXPECT_FLAGS]));
 		exp->flags &= ~NF_CT_EXPECT_USERSPACE;
-	} else {
-		exp->flags = 0;
 	}
 	if (cda[CTA_EXPECT_FN]) {
 		const char *name = nla_data(cda[CTA_EXPECT_FN]);
@@ -3553,8 +3553,7 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 			goto err_out;
 		}
 		exp->expectfn = expfn->expectfn;
-	} else
-		exp->expectfn = NULL;
+	}
 
 	exp->class = class;
 	exp->master = ct;
@@ -3568,12 +3567,6 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 						 exp, nf_ct_l3num(ct));
 		if (err < 0)
 			goto err_out;
-#if IS_ENABLED(CONFIG_NF_NAT)
-	} else {
-		memset(&exp->saved_addr, 0, sizeof(exp->saved_addr));
-		memset(&exp->saved_proto, 0, sizeof(exp->saved_proto));
-		exp->dir = 0;
-#endif
 	}
 	return exp;
 err_out:
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index 133e17715bbc..7ddc751f979e 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -411,11 +411,11 @@ static void tcp_sack(const struct sk_buff *skb, unsigned int dataoff,
 	BUG_ON(ptr == NULL);
 
 	/* Fast path for timestamp-only option */
-	if (length == TCPOLEN_TSTAMP_ALIGNED
-	    && *(__be32 *)ptr == htonl((TCPOPT_NOP << 24)
-				       | (TCPOPT_NOP << 16)
-				       | (TCPOPT_TIMESTAMP << 8)
-				       | TCPOLEN_TIMESTAMP))
+	if (length == TCPOLEN_TSTAMP_ALIGNED &&
+	    get_unaligned_be32(ptr) == ((TCPOPT_NOP << 24) |
+					(TCPOPT_NOP << 16) |
+					(TCPOPT_TIMESTAMP << 8) |
+					TCPOLEN_TIMESTAMP))
 		return;
 
 	while (length > 0) {
diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
index 7a9c07fff57a..44b21e180241 100644
--- a/net/netfilter/nf_conntrack_sip.c
+++ b/net/netfilter/nf_conntrack_sip.c
@@ -429,7 +429,7 @@ static const char *sip_skip_whitespace(const char *dptr, const char *limit)
 		dptr = sip_follow_continuation(dptr, limit);
 		break;
 	}
-	return dptr;
+	return dptr < limit ? dptr : NULL;
 }
 
 /* Search within a SIP header value, dealing with continuation lines */
diff --git a/net/netfilter/nf_flow_table_core.c b/net/netfilter/nf_flow_table_core.c
index 8f6b791918ae..1d4a236b5bc2 100644
--- a/net/netfilter/nf_flow_table_core.c
+++ b/net/netfilter/nf_flow_table_core.c
@@ -173,6 +173,14 @@ static void flow_offload_route_release(struct flow_offload *flow)
 	dst_release(flow->tuplehash[FLOW_OFFLOAD_DIR_REPLY].tuple.dst_cache);
 }
 
+static void flow_offload_free_rcu(struct rcu_head *rcu_head)
+{
+	struct flow_offload *flow = container_of(rcu_head, struct flow_offload, rcu_head);
+
+	nf_ct_put(flow->ct);
+	kfree(flow);
+}
+
 void flow_offload_free(struct flow_offload *flow)
 {
 	switch (flow->type) {
@@ -182,8 +190,7 @@ void flow_offload_free(struct flow_offload *flow)
 	default:
 		break;
 	}
-	nf_ct_put(flow->ct);
-	kfree_rcu(flow, rcu_head);
+	call_rcu(&flow->rcu_head, flow_offload_free_rcu);
 }
 EXPORT_SYMBOL_GPL(flow_offload_free);
 
@@ -584,6 +591,7 @@ static int __init nf_flow_table_module_init(void)
 
 static void __exit nf_flow_table_module_exit(void)
 {
+	rcu_barrier();
 	nf_flow_table_offload_exit();
 }
 
diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index f6275d93f8a5..7b94c63fb1ef 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -734,8 +734,9 @@ static int flow_offload_rule_add(struct flow_offload_work *offload,
 
 	ok_count += flow_offload_tuple_add(offload, flow_rule[0],
 					   FLOW_OFFLOAD_DIR_ORIGINAL);
-	ok_count += flow_offload_tuple_add(offload, flow_rule[1],
-					   FLOW_OFFLOAD_DIR_REPLY);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		ok_count += flow_offload_tuple_add(offload, flow_rule[1],
+						   FLOW_OFFLOAD_DIR_REPLY);
 	if (ok_count == 0)
 		return -ENOENT;
 
@@ -765,8 +766,8 @@ static void flow_offload_work_del(struct flow_offload_work *offload)
 {
 	clear_bit(IPS_HW_OFFLOAD_BIT, &offload->flow->ct->status);
 	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_ORIGINAL);
-	flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
-	set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_del(offload, FLOW_OFFLOAD_DIR_REPLY);
 }
 
 static void flow_offload_tuple_stats(struct flow_offload_work *offload,
@@ -784,7 +785,9 @@ static void flow_offload_work_stats(struct flow_offload_work *offload)
 	u64 lastused;
 
 	flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_ORIGINAL, &stats[0]);
-	flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_REPLY, &stats[1]);
+	if (test_bit(NF_FLOW_HW_BIDIRECTIONAL, &offload->flow->flags))
+		flow_offload_tuple_stats(offload, FLOW_OFFLOAD_DIR_REPLY,
+					 &stats[1]);
 
 	lastused = max_t(u64, stats[0].lastused, stats[1].lastused);
 	offload->flow->timeout = max_t(u64, offload->flow->timeout,
@@ -822,6 +825,12 @@ static void flow_offload_work_handler(struct work_struct *work)
 	}
 
 	clear_bit(NF_FLOW_HW_PENDING, &offload->flow->flags);
+	if (offload->cmd == FLOW_CLS_DESTROY) {
+		/* Publish after the worker's last flow access. */
+		smp_mb__before_atomic();
+		set_bit(NF_FLOW_HW_DEAD, &offload->flow->flags);
+	}
+
 	kfree(offload);
 }
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 5e3f863c487f..63592c73a7a1 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8797,8 +8797,8 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 							   nft_trans_flowtable(trans),
 							   &nft_trans_flowtable_hooks(trans),
 							   NFT_MSG_NEWFLOWTABLE);
-				list_splice(&nft_trans_flowtable_hooks(trans),
-					    &nft_trans_flowtable(trans)->hook_list);
+				list_splice_rcu(&nft_trans_flowtable_hooks(trans),
+						&nft_trans_flowtable(trans)->hook_list);
 			} else {
 				nft_clear(net, nft_trans_flowtable(trans));
 				nf_tables_flowtable_notify(&trans->ctx,
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 8c967bd772ec..042d417eb5ec 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -213,13 +213,18 @@ static void __nfulnl_flush(struct nfulnl_instance *inst);
 static void
 __instance_destroy(struct nfulnl_instance *inst)
 {
+	spin_lock(&inst->lock);
+	if (inst->copy_mode == NFULNL_COPY_DISABLED) {
+		/* attempt to UNBIND a queue already pending
+		 * destruction via netlink close event. Ignore.
+		 */
+		spin_unlock(&inst->lock);
+		return;
+	}
+
 	/* first pull it out of the global list */
 	hlist_del_rcu(&inst->hlist);
 
-	/* then flush all pending packets from skb */
-
-	spin_lock(&inst->lock);
-
 	/* lockless readers wont be able to use us */
 	inst->copy_mode = NFULNL_COPY_DISABLED;
 
diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index f91cc1b8804d..8c40a934f0e4 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -119,17 +119,9 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 	unsigned int h;
 	int err;
 
-	spin_lock(&q->instances_lock);
-	if (instance_lookup(q, queue_num)) {
-		err = -EEXIST;
-		goto out_unlock;
-	}
-
-	inst = kzalloc(sizeof(*inst), GFP_ATOMIC);
-	if (!inst) {
-		err = -ENOMEM;
-		goto out_unlock;
-	}
+	inst = kzalloc(sizeof(*inst), GFP_KERNEL_ACCOUNT);
+	if (!inst)
+		return ERR_PTR(-ENOMEM);
 
 	inst->queue_num = queue_num;
 	inst->peer_portid = portid;
@@ -139,9 +131,15 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 	spin_lock_init(&inst->lock);
 	INIT_LIST_HEAD(&inst->queue_list);
 
+	spin_lock(&q->instances_lock);
+	if (instance_lookup(q, queue_num)) {
+		err = -EEXIST;
+		goto out_unlock;
+	}
+
 	if (!try_module_get(THIS_MODULE)) {
 		err = -EAGAIN;
-		goto out_free;
+		goto out_unlock;
 	}
 
 	h = instance_hashfn(queue_num);
@@ -151,10 +149,9 @@ instance_create(struct nfnl_queue_net *q, u_int16_t queue_num, u32 portid)
 
 	return inst;
 
-out_free:
-	kfree(inst);
 out_unlock:
 	spin_unlock(&q->instances_lock);
+	kfree(inst);
 	return ERR_PTR(err);
 }
 
@@ -987,6 +984,7 @@ nfqnl_rcv_nl_event(struct notifier_block *this,
 	if (event == NETLINK_URELEASE && n->protocol == NETLINK_NETFILTER) {
 		int i;
 
+		nfnl_lock(NFNL_SUBSYS_QUEUE);
 		/* destroy all instances for this portid */
 		spin_lock(&q->instances_lock);
 		for (i = 0; i < INSTANCE_BUCKETS; i++) {
@@ -1000,6 +998,7 @@ nfqnl_rcv_nl_event(struct notifier_block *this,
 			}
 		}
 		spin_unlock(&q->instances_lock);
+		nfnl_unlock(NFNL_SUBSYS_QUEUE);
 	}
 	return NOTIFY_DONE;
 }
@@ -1271,7 +1270,8 @@ static int nfqnl_recv_config(struct net *net, struct sock *ctnl,
 	struct nfqnl_msg_config_cmd *cmd = NULL;
 	struct nfnl_queue_net *q = nfnl_queue_pernet(net);
 	__u32 flags = 0, mask = 0;
-	int ret = 0;
+
+	WARN_ON_ONCE(!lockdep_nfnl_is_held(NFNL_SUBSYS_QUEUE));
 
 	if (nfqa[NFQA_CFG_CMD]) {
 		cmd = nla_data(nfqa[NFQA_CFG_CMD]);
@@ -1317,47 +1317,44 @@ static int nfqnl_recv_config(struct net *net, struct sock *ctnl,
 		}
 	}
 
+	/* Lookup queue under RCU. After peer_portid check (or for new queue
+	 * in BIND case), the queue is owned by the socket sending this message.
+	 * nfqnl_rcv_nl_event() will block on the nfnl subsys mutex that is
+	 * held by the caller, so the queue cannot be destroyed in parallel,
+	 * even after we drop the RCU read lock.
+	 */
 	rcu_read_lock();
 	queue = instance_lookup(q, queue_num);
 	if (queue && queue->peer_portid != NETLINK_CB(skb).portid) {
-		ret = -EPERM;
-		goto err_out_unlock;
+		rcu_read_unlock();
+		return -EPERM;
 	}
+	rcu_read_unlock();
 
 	if (cmd != NULL) {
 		switch (cmd->command) {
 		case NFQNL_CFG_CMD_BIND:
-			if (queue) {
-				ret = -EBUSY;
-				goto err_out_unlock;
-			}
-			queue = instance_create(q, queue_num,
-						NETLINK_CB(skb).portid);
-			if (IS_ERR(queue)) {
-				ret = PTR_ERR(queue);
-				goto err_out_unlock;
-			}
+			if (queue)
+				return -EBUSY;
+			queue = instance_create(q, queue_num, NETLINK_CB(skb).portid);
+			if (IS_ERR(queue))
+				return PTR_ERR(queue);
 			break;
 		case NFQNL_CFG_CMD_UNBIND:
-			if (!queue) {
-				ret = -ENODEV;
-				goto err_out_unlock;
-			}
+			if (!queue)
+				return -ENODEV;
 			instance_destroy(q, queue);
-			goto err_out_unlock;
+			return 0;
 		case NFQNL_CFG_CMD_PF_BIND:
 		case NFQNL_CFG_CMD_PF_UNBIND:
 			break;
 		default:
-			ret = -ENOTSUPP;
-			goto err_out_unlock;
+			return -EOPNOTSUPP;
 		}
 	}
 
-	if (!queue) {
-		ret = -ENODEV;
-		goto err_out_unlock;
-	}
+	if (!queue)
+		return -ENODEV;
 
 	if (nfqa[NFQA_CFG_PARAMS]) {
 		struct nfqnl_msg_config_params *params =
@@ -1382,9 +1379,7 @@ static int nfqnl_recv_config(struct net *net, struct sock *ctnl,
 		spin_unlock_bh(&queue->lock);
 	}
 
-err_out_unlock:
-	rcu_read_unlock();
-	return ret;
+	return 0;
 }
 
 static const struct nfnl_callback nfqnl_cb[NFQNL_MSG_MAX] = {
diff --git a/net/netfilter/nft_nat.c b/net/netfilter/nft_nat.c
index 2e1ee7d9d9c3..2538f0c32f88 100644
--- a/net/netfilter/nft_nat.c
+++ b/net/netfilter/nft_nat.c
@@ -64,8 +64,8 @@ static void nft_nat_setup_netmap(struct nf_nat_range2 *range,
 				 const struct nft_pktinfo *pkt,
 				 const struct nft_nat *priv)
 {
+	union nf_inet_addr new_addr = {};
 	struct sk_buff *skb = pkt->skb;
-	union nf_inet_addr new_addr;
 	__be32 netmask;
 	int i, len = 0;
 
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index 3f01952a3e10..bb8204210c27 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1248,6 +1248,7 @@ bool nft_pipapo_avx2_lookup(const struct net *net, const struct nft_set *set,
 out:
 	if (i % 2)
 		scratch->map_index = !map_index;
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 	local_bh_enable();
 
diff --git a/net/netfilter/nft_synproxy.c b/net/netfilter/nft_synproxy.c
index aaba34ed0f71..b02b193a4255 100644
--- a/net/netfilter/nft_synproxy.c
+++ b/net/netfilter/nft_synproxy.c
@@ -117,7 +117,8 @@ static void nft_synproxy_do_eval(const struct nft_synproxy *priv,
 		return;
 	}
 
-	if (nf_ip_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP)) {
+	if (nf_checksum(skb, nft_hook(pkt), thoff, IPPROTO_TCP,
+			nft_pf(pkt))) {
 		regs->verdict.code = NF_DROP;
 		return;
 	}
diff --git a/net/netlabel/netlabel_unlabeled.c b/net/netlabel/netlabel_unlabeled.c
index e6b34be6fc28..145545e627e3 100644
--- a/net/netlabel/netlabel_unlabeled.c
+++ b/net/netlabel/netlabel_unlabeled.c
@@ -295,7 +295,7 @@ static int netlbl_unlhsh_add_addr6(struct netlbl_unlhsh_iface *iface,
 
 	if (ret_val != 0)
 		kfree(entry);
-	return 0;
+	return ret_val;
 }
 #endif /* IPv6 */
 
diff --git a/net/nfc/core.c b/net/nfc/core.c
index 2e32af33df7d..87908f5cff1f 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -278,10 +278,10 @@ static struct nfc_target *nfc_find_target(struct nfc_dev *dev, u32 target_idx)
 
 int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 {
-	int rc = 0;
-	u8 *gb;
-	size_t gb_len;
 	struct nfc_target *target;
+	u8 gb[NFC_MAX_GT_LEN];
+	size_t gb_len = 0;
+	int rc = 0;
 
 	pr_debug("dev_name=%s comm %d\n", dev_name(&dev->dev), comm_mode);
 
@@ -300,7 +300,7 @@ int nfc_dep_link_up(struct nfc_dev *dev, int target_index, u8 comm_mode)
 		goto error;
 	}
 
-	gb = nfc_llcp_general_bytes(dev, &gb_len);
+	nfc_get_local_general_bytes(dev, gb, sizeof(gb), &gb_len);
 	if (gb_len > NFC_MAX_GT_LEN) {
 		rc = -EINVAL;
 		goto error;
@@ -642,11 +642,10 @@ int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 }
 EXPORT_SYMBOL(nfc_set_remote_general_bytes);
 
-u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len)
+u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, u8 *out_gb,
+				size_t gb_max_len, size_t *gb_len)
 {
-	pr_debug("dev_name=%s\n", dev_name(&dev->dev));
-
-	return nfc_llcp_general_bytes(dev, gb_len);
+	return nfc_llcp_general_bytes(dev, out_gb, gb_max_len, gb_len);
 }
 EXPORT_SYMBOL(nfc_get_local_general_bytes);
 
diff --git a/net/nfc/digital_dep.c b/net/nfc/digital_dep.c
index dc21b4141b0a..0ee6bfea6dbe 100644
--- a/net/nfc/digital_dep.c
+++ b/net/nfc/digital_dep.c
@@ -1490,14 +1490,14 @@ static int digital_tg_send_atr_res(struct nfc_digital_dev *ddev,
 				   struct digital_atr_req *atr_req)
 {
 	struct digital_atr_res *atr_res;
+	u8 gb[NFC_MAX_GT_LEN];
 	struct sk_buff *skb;
-	u8 *gb, payload_bits;
+	u8 payload_bits;
 	size_t gb_len;
 	int rc;
 
-	gb = nfc_get_local_general_bytes(ddev->nfc_dev, &gb_len);
-	if (!gb)
-		gb_len = 0;
+	nfc_get_local_general_bytes(ddev->nfc_dev, gb, sizeof(gb),
+				    &gb_len);
 
 	skb = digital_skb_alloc(ddev, sizeof(struct digital_atr_res) + gb_len);
 	if (!skb)
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index a81893bc06ce..ce8c990ff39a 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -92,6 +92,7 @@ struct nfc_llcp_local {
 	struct hlist_head pending_sdreqs;
 	struct timer_list sdreq_timer;
 	struct work_struct sdreq_timeout_work;
+	struct work_struct release_work;
 	u8 sdreq_next_tid;
 
 	/* sockets array */
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 48d02c968601..52645afa3ac9 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -135,7 +135,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 {
 	struct nfc_llcp_sdp_tlv *sdreq;
 
-	pr_debug("uri: %s, len: %zu\n", uri, uri_len);
+	pr_debug("uri: %.*s, len: %zu\n", (int)uri_len, uri, uri_len);
 
 	/* sdreq->tlv_len is u8, takes uri_len, + 3 for header, + 1 for NULL */
 	if (WARN_ON_ONCE(uri_len > U8_MAX - 4))
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index a0b4559d8edc..d59ccd9e1304 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -20,6 +20,8 @@ static LIST_HEAD(llcp_devices);
 /* Protects llcp_devices list */
 static DEFINE_SPINLOCK(llcp_devices_lock);
 
+static struct workqueue_struct *llcp_wq;
+
 static void nfc_llcp_rx_skb(struct nfc_llcp_local *local, struct sk_buff *skb);
 
 void nfc_llcp_sock_link(struct llcp_sock_list *l, struct sock *sk)
@@ -65,21 +67,33 @@ static void nfc_llcp_socket_purge(struct nfc_llcp_sock *sock)
 	}
 }
 
+static struct sock *nfc_llcp_sock_list_pop(struct llcp_sock_list *l)
+{
+	struct sock *sk;
+
+	write_lock(&l->lock);
+	sk = sk_head(&l->head);
+	if (sk) {
+		sock_hold(sk);
+		sk_del_node_init(sk);
+	}
+	write_unlock(&l->lock);
+
+	return sk;
+}
+
 static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 				    int err)
 {
 	struct sock *sk;
-	struct hlist_node *tmp;
 	struct nfc_llcp_sock *llcp_sock;
 
 	skb_queue_purge(&local->tx_queue);
 
-	write_lock(&local->sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -93,17 +107,27 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 			list_for_each_entry_safe(lsk, n,
 						 &llcp_sock->accept_queue,
 						 accept_queue) {
-				accept_sk = &lsk->sk;
-				bh_lock_sock(accept_sk);
+				bool put_creation = false;
 
-				nfc_llcp_accept_unlink(accept_sk);
-
-				if (err)
-					accept_sk->sk_err = err;
-				accept_sk->sk_state = LLCP_CLOSED;
-				accept_sk->sk_state_change(sk);
+				accept_sk = &lsk->sk;
+				lock_sock_nested(accept_sk,
+						 SINGLE_DEPTH_NESTING);
+
+				if (nfc_llcp_sock(accept_sk)->parent == sk) {
+					nfc_llcp_accept_unlink(accept_sk);
+					nfc_llcp_sock_unlink(&local->sockets, accept_sk);
+
+					if (err)
+						accept_sk->sk_err = err;
+					accept_sk->sk_state = LLCP_CLOSED;
+					accept_sk->sk_state_change(accept_sk);
+					sock_orphan(accept_sk);
+					put_creation = true;
+				}
 
-				bh_unlock_sock(accept_sk);
+				release_sock(accept_sk);
+				if (put_creation)
+					sock_put(accept_sk); /* creation ref */
 			}
 		}
 
@@ -112,23 +136,18 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
 
-	write_unlock(&local->sockets.lock);
-
 	/* If we still have a device, we keep the RAW sockets alive */
 	if (device == true)
 		return;
 
-	write_lock(&local->raw_sockets.lock);
-
-	sk_for_each_safe(sk, tmp, &local->raw_sockets.head) {
+	while ((sk = nfc_llcp_sock_list_pop(&local->raw_sockets))) {
 		llcp_sock = nfc_llcp_sock(sk);
 
-		bh_lock_sock(sk);
+		lock_sock(sk);
 
 		nfc_llcp_socket_purge(llcp_sock);
 
@@ -137,26 +156,20 @@ static void nfc_llcp_socket_release(struct nfc_llcp_local *local, bool device,
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 
-		bh_unlock_sock(sk);
-
-		sk_del_node_init(sk);
+		release_sock(sk);
+		sock_put(sk);
 	}
-
-	write_unlock(&local->raw_sockets.lock);
 }
 
 static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
 {
-	/* Since using nfc_llcp_local may result in usage of nfc_dev, whenever
-	 * we hold a reference to local, we also need to hold a reference to
-	 * the device to avoid UAF.
-	 */
-	if (!nfc_get_device(local->dev->idx))
+	if (!local)
 		return NULL;
 
-	kref_get(&local->ref);
+	if (kref_get_unless_zero(&local->ref))
+		return local;
 
-	return local;
+	return NULL;
 }
 
 static void local_cleanup(struct nfc_llcp_local *local)
@@ -174,30 +187,34 @@ static void local_cleanup(struct nfc_llcp_local *local)
 	nfc_llcp_free_sdp_tlv_list(&local->pending_sdreqs);
 }
 
-static void local_release(struct kref *ref)
+static void local_release_work(struct work_struct *work)
 {
 	struct nfc_llcp_local *local;
+	struct nfc_dev *dev;
 
-	local = container_of(ref, struct nfc_llcp_local, ref);
+	local = container_of(work, struct nfc_llcp_local, release_work);
+	dev = local->dev;
 
 	local_cleanup(local);
 	kfree(local);
+	nfc_put_device(dev);
 }
 
-int nfc_llcp_local_put(struct nfc_llcp_local *local)
+static void local_release(struct kref *ref)
 {
-	struct nfc_dev *dev;
-	int ret;
+	struct nfc_llcp_local *local;
 
-	if (local == NULL)
-		return 0;
+	local = container_of(ref, struct nfc_llcp_local, ref);
 
-	dev = local->dev;
+	queue_work(llcp_wq, &local->release_work);
+}
 
-	ret = kref_put(&local->ref, local_release);
-	nfc_put_device(dev);
+int nfc_llcp_local_put(struct nfc_llcp_local *local)
+{
+	if (!local)
+		return 0;
 
-	return ret;
+	return kref_put(&local->ref, local_release);
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get(struct nfc_llcp_local *local,
@@ -341,7 +358,7 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
-	pr_debug("%s\n", service_name);
+	pr_debug("%.*s\n", (int)service_name_len, service_name);
 
 	if (service_name == NULL)
 		return -EINVAL;
@@ -352,7 +369,8 @@ static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 		if (wks[sap] == NULL)
 			continue;
 
-		if (strncmp(wks[sap], service_name, service_name_len) == 0)
+		if (strlen(wks[sap]) == service_name_len &&
+		    !strncmp(wks[sap], service_name, service_name_len))
 			return sap;
 	}
 
@@ -635,23 +653,32 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 	return ret;
 }
 
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len,
+			   size_t *general_bytes_len)
 {
 	struct nfc_llcp_local *local;
 
+	if (!out_gb || !general_bytes_len)
+		return NULL;
+
 	local = nfc_llcp_find_local(dev);
-	if (local == NULL) {
+	if (!local) {
 		*general_bytes_len = 0;
 		return NULL;
 	}
 
 	nfc_llcp_build_gb(local);
 
-	*general_bytes_len = local->gb_len;
+	if (local->gb_len) {
+		*general_bytes_len = min_t(size_t, local->gb_len, gb_max_len);
+		memcpy(out_gb, local->gb, *general_bytes_len);
+	} else {
+		*general_bytes_len = 0;
+	}
 
 	nfc_llcp_local_put(local);
 
-	return local->gb;
+	return out_gb;
 }
 
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
@@ -1081,6 +1108,9 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	struct sock *sk;
 	u8 dsap, ssap, ptype, ns, nr;
 
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE + LLCP_SEQUENCE_SIZE))
+		return;
+
 	ptype = nfc_llcp_ptype(skb);
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
@@ -1258,6 +1288,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
 	u8 dsap, ssap, reason;
+	bool connecting = false;
 
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
@@ -1269,6 +1300,7 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	case LLCP_DM_NOBOUND:
 	case LLCP_DM_REJ:
 		llcp_sock = nfc_llcp_connecting_sock_get(local, dsap);
+		connecting = true;
 		break;
 
 	default:
@@ -1283,10 +1315,33 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 
 	sk = &llcp_sock->sk;
 
+	lock_sock(sk);
+
+	/* Check if socket was destroyed whilst waiting for the lock */
+	if (!sk_hashed(sk)) {
+		release_sock(sk);
+		nfc_llcp_sock_put(llcp_sock);
+		return;
+	}
+
+	/*
+	 * For DM(NOBOUND)/DM(REJ) the socket is still linked on the
+	 * connecting_sockets list.  Unlink it here, under the socket lock,
+	 * before moving it to LLCP_CLOSED: llcp_sock_release() selects the
+	 * list to unlink from by sk_state, so leaving a connecting socket
+	 * in the CLOSED state would make it unlink from the wrong list and
+	 * corrupt the connecting_sockets list / desync the socket refcount.
+	 * This mirrors nfc_llcp_recv_cc().
+	 */
+	if (connecting)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
+
 	sk->sk_err = ENXIO;
 	sk->sk_state = LLCP_CLOSED;
 	sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	nfc_llcp_sock_put(llcp_sock);
 }
 
@@ -1688,6 +1743,7 @@ int nfc_llcp_register_device(struct nfc_dev *ndev)
 	INIT_WORK(&local->rx_work, nfc_llcp_rx_work);
 
 	INIT_WORK(&local->timeout_work, nfc_llcp_timeout_work);
+	INIT_WORK(&local->release_work, local_release_work);
 
 	rwlock_init(&local->sockets.lock);
 	rwlock_init(&local->connecting_sockets.lock);
@@ -1731,10 +1787,23 @@ void nfc_llcp_unregister_device(struct nfc_dev *dev)
 
 int __init nfc_llcp_init(void)
 {
-	return nfc_llcp_sock_init();
+	int ret;
+
+	llcp_wq = alloc_workqueue("nfc_llcp_wq", WQ_UNBOUND, 0);
+	if (!llcp_wq)
+		return -ENOMEM;
+
+	ret = nfc_llcp_sock_init();
+	if (ret) {
+		destroy_workqueue(llcp_wq);
+		return ret;
+	}
+
+	return 0;
 }
 
 void nfc_llcp_exit(void)
 {
 	nfc_llcp_sock_exit();
+	destroy_workqueue(llcp_wq);
 }
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 85767c13543b..f0e722933c1e 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -387,11 +387,12 @@ void nfc_llcp_accept_unlink(struct sock *sk)
 
 	pr_debug("state %d\n", sk->sk_state);
 
-	list_del_init(&llcp_sock->accept_queue);
-	sk_acceptq_removed(llcp_sock->parent);
-	llcp_sock->parent = NULL;
-
-	sock_put(sk);
+	if (llcp_sock->parent) {
+		list_del_init(&llcp_sock->accept_queue);
+		sk_acceptq_removed(llcp_sock->parent);
+		llcp_sock->parent = NULL;
+		sock_put(sk);
+	}
 }
 
 void nfc_llcp_accept_enqueue(struct sock *parent, struct sock *sk)
@@ -418,12 +419,20 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *parent,
 
 	list_for_each_entry_safe(lsk, n, &llcp_parent->accept_queue,
 				 accept_queue) {
+		struct nfc_llcp_local *local;
+
 		sk = &lsk->sk;
-		lock_sock(sk);
+		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
 
 		if (sk->sk_state == LLCP_CLOSED) {
-			release_sock(sk);
+			local = nfc_llcp_sock(sk)->local;
+
 			nfc_llcp_accept_unlink(sk);
+			if (local)
+				nfc_llcp_sock_unlink(&local->sockets, sk);
+			sock_orphan(sk);
+			release_sock(sk);
+			sock_put(sk);
 			continue;
 		}
 
@@ -459,7 +468,7 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
 
 	pr_debug("parent %p\n", sk);
 
-	lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+	lock_sock(sk);
 
 	if (sk->sk_state != LLCP_LISTEN) {
 		ret = -EBADFD;
@@ -485,7 +494,12 @@ static int llcp_sock_accept(struct socket *sock, struct socket *newsock,
 
 		release_sock(sk);
 		timeo = schedule_timeout(timeo);
-		lock_sock_nested(sk, SINGLE_DEPTH_NESTING);
+		lock_sock(sk);
+
+		if (sk->sk_state != LLCP_LISTEN) {
+			ret = -EBADFD;
+			break;
+		}
 	}
 	__set_current_state(TASK_RUNNING);
 	remove_wait_queue(sk_sleep(sk), &wait);
@@ -624,13 +638,24 @@ static int llcp_sock_release(struct socket *sock)
 
 		list_for_each_entry_safe(lsk, n, &llcp_sock->accept_queue,
 					 accept_queue) {
+			bool put_creation = false;
+
 			accept_sk = &lsk->sk;
-			lock_sock(accept_sk);
+			lock_sock_nested(accept_sk, SINGLE_DEPTH_NESTING);
 
-			nfc_llcp_send_disconnect(lsk);
-			nfc_llcp_accept_unlink(accept_sk);
+			if (nfc_llcp_sock(accept_sk)->parent == sk) {
+				nfc_llcp_send_disconnect(lsk);
+				nfc_llcp_accept_unlink(accept_sk);
+				nfc_llcp_sock_unlink(&local->sockets, accept_sk);
+
+				accept_sk->sk_state = LLCP_CLOSED;
+				sock_orphan(accept_sk);
+				put_creation = true;
+			}
 
 			release_sock(accept_sk);
+			if (put_creation)
+				sock_put(accept_sk); /* creation ref */
 		}
 	}
 
@@ -736,12 +761,16 @@ static int llcp_sock_connect(struct socket *sock, struct sockaddr *_addr,
 	llcp_sock->service_name_len = min_t(unsigned int,
 					    addr->service_name_len,
 					    NFC_LLCP_MAX_SERVICE_NAME);
-	llcp_sock->service_name = kmemdup(addr->service_name,
-					  llcp_sock->service_name_len,
-					  GFP_KERNEL);
-	if (!llcp_sock->service_name) {
-		ret = -ENOMEM;
-		goto sock_llcp_release;
+	if (llcp_sock->service_name_len == 0) {
+		llcp_sock->service_name = NULL;
+	} else {
+		llcp_sock->service_name = kmemdup(addr->service_name,
+						  llcp_sock->service_name_len,
+						  GFP_KERNEL);
+		if (!llcp_sock->service_name) {
+			ret = -ENOMEM;
+			goto sock_llcp_release;
+		}
 	}
 
 	nfc_llcp_sock_link(&local->connecting_sockets, sk);
diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 78472b192970..7c03b73d3c49 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -749,15 +749,15 @@ static int nci_set_local_general_bytes(struct nfc_dev *nfc_dev)
 {
 	struct nci_dev *ndev = nfc_get_drvdata(nfc_dev);
 	struct nci_set_config_param param;
+	u8 gb[NFC_MAX_GT_LEN];
 	int rc;
 
-	param.val = nfc_get_local_general_bytes(nfc_dev, &param.len);
-	if ((param.val == NULL) || (param.len == 0))
+	nfc_get_local_general_bytes(nfc_dev, gb, sizeof(gb),
+				    &param.len);
+	if (param.len == 0)
 		return 0;
 
-	if (param.len > NFC_MAX_GT_LEN)
-		return -EINVAL;
-
+	param.val = gb;
 	param.id = NCI_PN_ATR_REQ_GEN_BYTES;
 
 	rc = nci_request(ndev, nci_set_config_req, (unsigned long)&param,
diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
index 1c5b3ce1e8b1..9a503a8a43fb 100644
--- a/net/nfc/netlink.c
+++ b/net/nfc/netlink.c
@@ -1178,7 +1178,7 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 
 		if (rc != 0) {
 			rc = -EINVAL;
-			goto put_local;
+			goto free_list;
 		}
 
 		if (!sdp_attrs[NFC_SDP_ATTR_URI])
@@ -1197,7 +1197,7 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 		sdreq = nfc_llcp_build_sdreq_tlv(tid, uri, uri_len);
 		if (sdreq == NULL) {
 			rc = -ENOMEM;
-			goto put_local;
+			goto free_list;
 		}
 
 		tlvs_len += sdreq->tlv_len;
@@ -1212,6 +1212,9 @@ static int nfc_genl_llc_sdreq(struct sk_buff *skb, struct genl_info *info)
 
 	rc = nfc_llcp_send_snl_sdreq(local, &sdreq_list, tlvs_len);
 
+free_list:
+	nfc_llcp_free_sdp_tlv_list(&sdreq_list);
+
 put_local:
 	nfc_llcp_local_put(local);
 
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 0b1e6466f4fb..82c5dfdad10e 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -49,7 +49,8 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
 int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
-u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
+u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, u8 *out_gb, size_t gb_max_len,
+			   size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
 int nfc_llcp_local_put(struct nfc_llcp_local *local);
diff --git a/net/openvswitch/conntrack.c b/net/openvswitch/conntrack.c
index 45a4e39d8bcb..340f7dde559f 100644
--- a/net/openvswitch/conntrack.c
+++ b/net/openvswitch/conntrack.c
@@ -355,7 +355,7 @@ static struct nf_conn_labels *ovs_ct_get_conn_labels(struct nf_conn *ct)
 	struct nf_conn_labels *cl;
 
 	cl = nf_ct_labels_find(ct);
-	if (!cl) {
+	if (!cl && !nf_ct_is_confirmed(ct)) {
 		nf_ct_labels_ext_add(ct);
 		cl = nf_ct_labels_find(ct);
 	}
@@ -955,6 +955,18 @@ static int __ovs_ct_lookup(struct net *net, struct sw_flow_key *key,
 	enum ip_conntrack_info ctinfo;
 	struct nf_conn *ct;
 
+	/* If the ct entry is not confirmed and shared with some other skb,
+	 * e.g., a cloned one, we can't just modify it with the commit as we
+	 * must not modify the extension set.  Reset.
+	 */
+	if (cached && info->commit) {
+		ct = nf_ct_get(skb, &ctinfo);
+		if (ct && !nf_ct_is_confirmed(ct) && nf_ct_shared(ct)) {
+			nf_reset_ct(skb);
+			cached = false;
+		}
+	}
+
 	if (!cached) {
 		struct nf_hook_state state = {
 			.hook = NF_INET_PRE_ROUTING,
diff --git a/net/openvswitch/flow_table.c b/net/openvswitch/flow_table.c
index c89c8da99f1a..79469388ed89 100644
--- a/net/openvswitch/flow_table.c
+++ b/net/openvswitch/flow_table.c
@@ -261,11 +261,13 @@ static int tbl_mask_array_realloc(struct flow_table *tbl, int size)
 			if (ovsl_dereference(old->masks[i]))
 				new->masks[new->count++] = old->masks[i];
 		}
-		call_rcu(&old->rcu, mask_array_rcu_cb);
 	}
 
 	rcu_assign_pointer(tbl->mask_array, new);
 
+	if (old)
+		call_rcu(&old->rcu, mask_array_rcu_cb);
+
 	return 0;
 }
 
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index d756ecc75a41..7c7aab0cc14b 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -599,7 +599,7 @@ static int prb_calc_retire_blk_tmo(struct packet_sock *po,
 		return DEFAULT_PRB_RETIRE_TOV;
 
 	div = ecmd.base.speed / 1000;
-	mbits = (blk_size_in_bytes * 8) / (1024 * 1024);
+	mbits = (u64)blk_size_in_bytes * 8 / (1024 * 1024);
 
 	if (div)
 		mbits /= div;
@@ -2397,7 +2397,9 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
 				    sizeof(struct virtio_net_hdr),
 				    vio_le(), true, 0)) {
-		if (po->tp_version == TPACKET_V3)
+		if (po->tp_version <= TPACKET_V2)
+			__clear_bit(slot_id, po->rx_ring.rx_owner_map);
+		else
 			prb_clear_blk_fill_status(&po->rx_ring);
 		goto drop_n_account;
 	}
@@ -2679,7 +2681,8 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 				int size_max, void **data)
 {
 	union tpacket_uhdr ph;
-	int tp_len, off;
+	u32 tp_len;
+	int off;
 
 	ph.raw = frame;
 
@@ -2699,7 +2702,7 @@ static int tpacket_parse_header(struct packet_sock *po, void *frame,
 		break;
 	}
 	if (unlikely(tp_len > size_max)) {
-		pr_err("packet size is too long (%d > %d)\n", tp_len, size_max);
+		pr_err("packet size is too long (%u > %d)\n", tp_len, size_max);
 		return -EMSGSIZE;
 	}
 
diff --git a/net/packet/internal.h b/net/packet/internal.h
index 69e58cb74492..c24e9977abb9 100644
--- a/net/packet/internal.h
+++ b/net/packet/internal.h
@@ -21,7 +21,7 @@ struct tpacket_kbdq_core {
 	unsigned char	reset_pending_on_curr_blk;
 	unsigned char   delete_blk_timer;
 	unsigned short	kactive_blk_num;
-	unsigned short	blk_sizeof_priv;
+	unsigned int	blk_sizeof_priv;
 
 	/* last_kactive_blk_num:
 	 * trick to see if user-space has caught up
diff --git a/net/phonet/pn_dev.c b/net/phonet/pn_dev.c
index 2c48dcf6a740..50d85de59811 100644
--- a/net/phonet/pn_dev.c
+++ b/net/phonet/pn_dev.c
@@ -336,16 +336,34 @@ static struct pernet_operations phonet_net_ops = {
 /* Initialize Phonet devices list */
 int __init phonet_device_init(void)
 {
-	int err = register_pernet_subsys(&phonet_net_ops);
+	int err;
+
+	err = register_pernet_subsys(&phonet_net_ops);
 	if (err)
 		return err;
 
-	proc_create_net("pnresource", 0, init_net.proc_net, &pn_res_seq_ops,
-			sizeof(struct seq_net_private));
-	register_netdevice_notifier(&phonet_device_notifier);
+	if (!proc_create_net("pnresource", 0, init_net.proc_net,
+			     &pn_res_seq_ops, sizeof(struct seq_net_private))) {
+		err = -ENOMEM;
+		goto err_pernet;
+	}
+
+	err = register_netdevice_notifier(&phonet_device_notifier);
+	if (err)
+		goto err_proc;
+
 	err = phonet_netlink_register();
 	if (err)
-		phonet_device_exit();
+		goto err_notifier;
+
+	return 0;
+
+err_notifier:
+	unregister_netdevice_notifier(&phonet_device_notifier);
+err_proc:
+	remove_proc_entry("pnresource", init_net.proc_net);
+err_pernet:
+	unregister_pernet_subsys(&phonet_net_ops);
 	return err;
 }
 
@@ -353,8 +371,8 @@ void phonet_device_exit(void)
 {
 	rtnl_unregister_all(PF_PHONET);
 	unregister_netdevice_notifier(&phonet_device_notifier);
-	unregister_pernet_subsys(&phonet_net_ops);
 	remove_proc_entry("pnresource", init_net.proc_net);
+	unregister_pernet_subsys(&phonet_net_ops);
 }
 
 int phonet_route_add(struct net_device *dev, u8 daddr)
diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 31371f3c1a57..465c1ddd11f5 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -1003,8 +1003,10 @@ static int qrtr_send_resume_tx(struct qrtr_cb *cb)
 		return -EINVAL;
 
 	skb = qrtr_alloc_ctrl_packet(&pkt, GFP_KERNEL);
-	if (!skb)
+	if (!skb) {
+		qrtr_node_release(node);
 		return -ENOMEM;
+	}
 
 	pkt->cmd = cpu_to_le32(QRTR_TYPE_RESUME_TX);
 	pkt->client.node = cpu_to_le32(cb->dst_node);
diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
index ca1b52372ab2..5fc38d2b411d 100644
--- a/net/rds/af_rds.c
+++ b/net/rds/af_rds.c
@@ -43,7 +43,6 @@
 
 /* this is just used for stats gathering :/ */
 static DEFINE_SPINLOCK(rds_sock_lock);
-static unsigned long rds_sock_count;
 static LIST_HEAD(rds_sock_list);
 DECLARE_WAIT_QUEUE_HEAD(rds_poll_waitq);
 
@@ -82,7 +81,6 @@ static int rds_release(struct socket *sock)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_del_init(&rs->rs_item);
-	rds_sock_count--;
 	spin_unlock_bh(&rds_sock_lock);
 
 	rds_trans_put(rs->rs_transport);
@@ -219,7 +217,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 
 	poll_wait(file, sk_sleep(sk), wait);
 
-	if (rs->rs_seen_congestion)
+	if (READ_ONCE(rs->rs_seen_congestion))
 		poll_wait(file, &rds_poll_waitq, wait);
 
 	read_lock_irqsave(&rs->rs_recv_lock, flags);
@@ -247,7 +245,7 @@ static __poll_t rds_poll(struct file *file, struct socket *sock,
 
 	/* clear state any time we wake a seen-congested socket */
 	if (mask)
-		rs->rs_seen_congestion = 0;
+		WRITE_ONCE(rs->rs_seen_congestion, 0);
 
 	return mask;
 }
@@ -695,7 +693,6 @@ static int __rds_create(struct socket *sock, struct sock *sk, int protocol)
 
 	spin_lock_bh(&rds_sock_lock);
 	list_add_tail(&rs->rs_item, &rds_sock_list);
-	rds_sock_count++;
 	spin_unlock_bh(&rds_sock_lock);
 
 	return 0;
@@ -736,6 +733,7 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 			      struct rds_info_iterator *iter,
 			      struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_sock *rs;
 	struct rds_incoming *inc;
 	unsigned int total = 0;
@@ -745,6 +743,9 @@ static void rds_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -775,6 +776,7 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 			       struct rds_info_iterator *iter,
 			       struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_incoming *inc;
 	unsigned int total = 0;
 	struct rds_sock *rs;
@@ -784,6 +786,9 @@ static void rds6_sock_inc_info(struct socket *sock, unsigned int len,
 	spin_lock_bh(&rds_sock_lock);
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		read_lock(&rs->rs_recv_lock);
 
 		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
@@ -807,7 +812,9 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 			  struct rds_info_iterator *iter,
 			  struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds_info_socket sinfo;
+	unsigned int copied = 0;
 	unsigned int cnt = 0;
 	struct rds_sock *rs;
 
@@ -815,12 +822,24 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count) {
-		cnt = rds_sock_count;
-		goto out;
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
+			continue;
+		cnt++;
 	}
 
+	if (len < cnt)
+		goto out;
+
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (copied >= cnt)
+			break;
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		/* This option only supports IPv4 sockets. */
 		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
 			continue;
@@ -833,8 +852,13 @@ static void rds_sock_info(struct socket *sock, unsigned int len,
 		sinfo.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo, sizeof(sinfo));
-		cnt++;
+		copied++;
 	}
+	/* A concurrent rds_bind() can change rs_bound_addr between the
+	 * two passes without holding rds_sock_lock, so copied may be
+	 * less than cnt. Report what was actually copied.
+	 */
+	cnt = copied;
 
 out:
 	lens->nr = cnt;
@@ -848,17 +872,32 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 			   struct rds_info_iterator *iter,
 			   struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_socket sinfo6;
+	unsigned int copied = 0;
+	unsigned int cnt = 0;
 	struct rds_sock *rs;
 
 	len /= sizeof(struct rds6_info_socket);
 
 	spin_lock_bh(&rds_sock_lock);
 
-	if (len < rds_sock_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
+		cnt++;
+	}
+
+	if (len < cnt)
 		goto out;
 
 	list_for_each_entry(rs, &rds_sock_list, rs_item) {
+		if (copied >= cnt)
+			break;
+		/* Only show sockets in the caller's netns. */
+		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
+			continue;
 		sinfo6.sndbuf = rds_sk_sndbuf(rs);
 		sinfo6.rcvbuf = rds_sk_rcvbuf(rs);
 		sinfo6.bound_addr = rs->rs_bound_addr;
@@ -868,10 +907,12 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
 		sinfo6.inum = sock_i_ino(rds_rs_to_sk(rs));
 
 		rds_info_copy(iter, &sinfo6, sizeof(sinfo6));
+		copied++;
 	}
+	cnt = copied;
 
  out:
-	lens->nr = rds_sock_count;
+	lens->nr = cnt;
 	lens->each = sizeof(struct rds6_info_socket);
 
 	spin_unlock_bh(&rds_sock_lock);
diff --git a/net/rds/connection.c b/net/rds/connection.c
index cd41f83863c8..a273af94df2d 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -105,10 +105,12 @@ static struct rds_connection *rds_conn_lookup(struct net *net,
 }
 
 /*
- * This is called by transports as they're bringing down a connection.
- * It clears partial message state so that the transport can start sending
- * and receiving over this connection again in the future.  It is up to
- * the transport to have serialized this call with its send and recv.
+ * This is called by rds_conn_shutdown() once the transport has brought
+ * a path down.  It clears partial message state so that the transport
+ * can start sending and receiving over this path again in the future.
+ * The caller owns RDS_IN_XMIT and RDS_RECV_REFILL across this call,
+ * which is what serializes it against the send and receive-refill
+ * paths.
  */
 static void rds_conn_path_reset(struct rds_conn_path *cp)
 {
@@ -119,7 +121,16 @@ static void rds_conn_path_reset(struct rds_conn_path *cp)
 
 	rds_stats_inc(s_conn_reset);
 	rds_send_path_reset(cp);
-	cp->cp_flags = 0;
+
+	/* Clear the bits the reset is responsible for individually: a
+	 * blanket cp_flags = 0 is a plain store that can clobber a
+	 * concurrent atomic read-modify-write on the same word.
+	 * RDS_IN_XMIT and RDS_RECV_REFILL are held as locks by the
+	 * caller, rds_conn_shutdown(), which releases them once the
+	 * teardown is complete.
+	 */
+	clear_bit(RDS_LL_SEND_FULL, &cp->cp_flags);
+	clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
 
 	/* Do not clear next_rx_seq here, else we cannot distinguish
 	 * retransmitted packets from new packets, and will hand all
@@ -392,28 +403,70 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
 		}
 		mutex_unlock(&cp->cp_cm_lock);
 
+		/* Quiesce the transmit and receive-refill paths by
+		 * acquiring their bit locks, not merely waiting for
+		 * them to be released: with a plain wait, either path
+		 * can re-take its lock the instant after we sample it
+		 * clear and then run concurrently with the transport
+		 * shutdown and the path reset below.  Holding both
+		 * locks across the teardown makes that structurally
+		 * impossible.
+		 */
 		wait_event(cp->cp_waitq,
-			   !test_bit(RDS_IN_XMIT, &cp->cp_flags));
+			   !test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags));
 		wait_event(cp->cp_waitq,
-			   !test_bit(RDS_RECV_REFILL, &cp->cp_flags));
+			   !test_and_set_bit(RDS_RECV_REFILL, &cp->cp_flags));
 
 		conn->c_trans->conn_path_shutdown(cp);
 		rds_conn_path_reset(cp);
 
+		/* Release the two locks and wake any waiter (e.g.
+		 * rds_tcp_reset_callbacks()) that blocked on them while
+		 * we held them.  The unlock orders the transport's ring
+		 * re-initialization and the path reset above before
+		 * either bit is seen clear.  rds_conn_path_reset() leaves
+		 * both bits alone: ownership ends here, not inside the
+		 * reset.
+		 */
+		clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
+		clear_bit_unlock(RDS_RECV_REFILL, &cp->cp_flags);
+		wake_up_all(&cp->cp_waitq);
+
 		if (!rds_conn_path_transition(cp, RDS_CONN_DISCONNECTING,
-					      RDS_CONN_DOWN) &&
-		    !rds_conn_path_transition(cp, RDS_CONN_ERROR,
 					      RDS_CONN_DOWN)) {
-			/* This can happen - eg when we're in the middle of tearing
-			 * down the connection, and someone unloads the rds module.
-			 * Quite reproducible with loopback connections.
-			 * Mostly harmless.
+			/* The path was dropped again while we tore it
+			 * down: by a socket state-change callback in
+			 * irq context on receipt of a FIN, or by an
+			 * accept that claimed the path just before a
+			 * drop put it back to RDS_CONN_ERROR and then
+			 * installed a fresh socket on it.  Unless a
+			 * pending destroy suppressed it, the drop also
+			 * queued another shutdown pass, and that pass
+			 * must run, because it is what tears down
+			 * whatever attached to the path after the
+			 * transport shutdown above sampled its state.
+			 * Consuming the RDS_CONN_ERROR here would turn
+			 * that pass into a no-op: leave the state
+			 * alone, and let the pass finish the job.
 			 *
-			 * Note that this also happens with rds-tcp because
-			 * we could have triggered rds_conn_path_drop in irq
-			 * mode from rds_tcp_state change on the receipt of
-			 * a FIN, thus we need to recheck for RDS_CONN_ERROR
-			 * here.
+			 * Quiesce the reconnect timer before bailing
+			 * out, though.  When a pending destroy did
+			 * suppress the queue, no later pass runs, and
+			 * rds_conn_path_destroy() is about to flush
+			 * cp_down_w and free the path: it must not
+			 * find cp_conn_w still armed.  A successor
+			 * pass, when there is one, re-arms the
+			 * reconnect from its own tail.
+			 */
+			cancel_delayed_work_sync(&cp->cp_conn_w);
+			clear_bit(RDS_RECONNECT_PENDING, &cp->cp_flags);
+
+			if (rds_conn_path_state(cp) == RDS_CONN_ERROR)
+				return;
+			/* No current cp_state writer leaves a
+			 * DISCONNECTING path in any state but
+			 * RDS_CONN_ERROR; report loudly if one ever
+			 * does.
 			 */
 			rds_conn_path_error(cp, "%s: failed to transition "
 					    "to state DOWN, current state "
@@ -540,6 +593,7 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 				      struct rds_info_lengths *lens,
 				      int want_send, bool isv6)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct list_head *list;
 	struct rds_connection *conn;
@@ -562,6 +616,9 @@ static void rds_conn_message_info_cmn(struct socket *sock, unsigned int len,
 			struct rds_conn_path *cp;
 			int npaths;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 			if (!isv6 && conn->c_isv6)
 				continue;
 
@@ -660,6 +717,7 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 			  u64 *buffer,
 			  size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -672,6 +730,9 @@ void rds_for_each_conn_info(struct socket *sock, unsigned int len,
 	for (i = 0, head = rds_conn_hash; i < ARRAY_SIZE(rds_conn_hash);
 	     i++, head++) {
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
 
 			/* Zero the per-item buffer before handing it to the
 			 * visitor so any field the visitor does not write -
@@ -705,6 +766,7 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 				    u64 *buffer,
 				    size_t item_len)
 {
+	struct net *net = sock_net(sock->sk);
 	struct hlist_head *head;
 	struct rds_connection *conn;
 	size_t i;
@@ -719,6 +781,10 @@ static void rds_walk_conn_path_info(struct socket *sock, unsigned int len,
 		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
 			struct rds_conn_path *cp;
 
+			/* Only show connections in the caller's netns. */
+			if (!net_eq(rds_conn_net(conn), net))
+				continue;
+
 			/* XXX We only copy the information from the first
 			 * path for now.  The problem is that if there are
 			 * more than one underlying paths, we cannot report
diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
index f23233e0a53c..5cdfd4310bce 100644
--- a/net/rds/ib_cm.c
+++ b/net/rds/ib_cm.c
@@ -141,7 +141,7 @@ void rds_ib_cm_connect_complete(struct rds_connection *conn, struct rdma_cm_even
 				  &conn->c_laddr, &conn->c_faddr,
 				  RDS_PROTOCOL_MAJOR(conn->c_version),
 				  RDS_PROTOCOL_MINOR(conn->c_version));
-			rds_conn_destroy(conn);
+			rds_conn_drop(conn);
 			return;
 		}
 	}
@@ -1076,6 +1076,19 @@ int rds_ib_conn_path_connect(struct rds_conn_path *cp)
 	return ret;
 }
 
+static unsigned long rds_ib_conn_path_shutdown_check_wait(struct rds_conn_path *cp)
+{
+	struct rds_connection *conn = cp->cp_conn;
+	struct rds_ib_connection *ic = conn->c_transport_data;
+
+	return (!ic->i_cm_id ||
+		(rds_ib_ring_empty(&ic->i_recv_ring) &&
+		 (atomic_read(&ic->i_signaled_sends) == 0) &&
+		 (atomic_read(&ic->i_fastreg_inuse_count)) == 0 &&
+		 (atomic_read(&ic->i_fastreg_wrs) == RDS_IB_DEFAULT_FR_WR))) ? 0
+		: msecs_to_jiffies(1000);
+}
+
 /*
  * This is so careful about only cleaning up resources that were built up
  * so that it can be called at any point during startup.  In fact it
@@ -1116,11 +1129,13 @@ void rds_ib_conn_path_shutdown(struct rds_conn_path *cp)
 		 * sends to complete we're ensured that there will be no
 		 * more tx processing.
 		 */
-		wait_event(rds_ib_ring_empty_wait,
-			   rds_ib_ring_empty(&ic->i_recv_ring) &&
-			   (atomic_read(&ic->i_signaled_sends) == 0) &&
-			   (atomic_read(&ic->i_fastreg_inuse_count) == 0) &&
-			   (atomic_read(&ic->i_fastreg_wrs) == RDS_IB_DEFAULT_FR_WR));
+		while (!wait_event_timeout(rds_ib_ring_empty_wait,
+					   rds_ib_conn_path_shutdown_check_wait(cp) == 0,
+					   msecs_to_jiffies(1000))) {
+			tasklet_schedule(&ic->i_send_tasklet);
+			tasklet_schedule(&ic->i_recv_tasklet);
+		}
+
 		tasklet_kill(&ic->i_send_tasklet);
 		tasklet_kill(&ic->i_recv_tasklet);
 
diff --git a/net/rds/ib_frmr.c b/net/rds/ib_frmr.c
index bd861191157b..8397aa4a17ac 100644
--- a/net/rds/ib_frmr.c
+++ b/net/rds/ib_frmr.c
@@ -204,19 +204,16 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 	 */
 	rds_ib_teardown_mr(ibmr);
 
-	ibmr->sg = sg;
-	ibmr->sg_len = sg_len;
-	ibmr->sg_dma_len = 0;
 	frmr->sg_byte_len = 0;
-	WARN_ON(ibmr->sg_dma_len);
-	ibmr->sg_dma_len = ib_dma_map_sg(dev, ibmr->sg, ibmr->sg_len,
+	ibmr->sg_dma_len = ib_dma_map_sg(dev, sg, sg_len,
 					 DMA_BIDIRECTIONAL);
 	if (unlikely(!ibmr->sg_dma_len)) {
 		pr_warn("RDS/IB: %s failed!\n", __func__);
 		return -EBUSY;
 	}
 
-	frmr->sg_byte_len = 0;
+	ibmr->sg = sg;
+	ibmr->sg_len = sg_len;
 	frmr->dma_npages = 0;
 	len = 0;
 
@@ -264,6 +261,8 @@ static int rds_ib_map_frmr(struct rds_ib_device *rds_ibdev,
 	ib_dma_unmap_sg(rds_ibdev->dev, ibmr->sg, ibmr->sg_len,
 			DMA_BIDIRECTIONAL);
 	ibmr->sg_dma_len = 0;
+	ibmr->sg = NULL;
+	ibmr->sg_len = 0;
 	return ret;
 }
 
diff --git a/net/rds/ib_recv.c b/net/rds/ib_recv.c
index cfbf0e129cba..89aef2fffc1e 100644
--- a/net/rds/ib_recv.c
+++ b/net/rds/ib_recv.c
@@ -362,15 +362,14 @@ static int acquire_refill(struct rds_connection *conn)
 
 static void release_refill(struct rds_connection *conn)
 {
-	clear_bit(RDS_RECV_REFILL, &conn->c_flags);
-	smp_mb__after_atomic();
+	clear_bit_unlock(RDS_RECV_REFILL, &conn->c_flags);
 
 	/* We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
 	 * the system-wide hashed waitqueue buckets in the fast path only to
 	 * almost never find waiters.
 	 */
-	if (waitqueue_active(&conn->c_waitq))
+	if (wq_has_sleeper(&conn->c_waitq))
 		wake_up_all(&conn->c_waitq);
 }
 
@@ -391,7 +390,9 @@ void rds_ib_recv_refill(struct rds_connection *conn, int prefill, gfp_t gfp)
 
 	/* the goal here is to just make sure that someone, somewhere
 	 * is posting buffers.  If we can't get the refill lock,
-	 * let them do their thing
+	 * let them do their thing.  The holder may also be
+	 * rds_conn_shutdown() tearing the path down, in which case
+	 * there is nothing to post.
 	 */
 	if (!acquire_refill(conn))
 		return;
diff --git a/net/rds/message.c b/net/rds/message.c
index 987ef9ca5a8f..7444594a02e1 100644
--- a/net/rds/message.c
+++ b/net/rds/message.c
@@ -364,8 +364,10 @@ struct rds_message *rds_message_map_pages(unsigned long *page_addrs, unsigned in
 
 	for (i = 0; i < rm->data.op_nents; ++i) {
 		sg_set_page(&rm->data.op_sg[i],
-				virt_to_page(page_addrs[i]),
-				PAGE_SIZE, 0);
+				virt_to_page((void *)page_addrs[i]),
+				i == rm->data.op_nents - 1
+					? total_len - (i * PAGE_SIZE)
+					: PAGE_SIZE, 0);
 	}
 
 	return rm;
diff --git a/net/rds/send.c b/net/rds/send.c
index 131c59cd5abb..48132826ba00 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -114,8 +114,13 @@ static void release_in_xmit(struct rds_conn_path *cp)
 	 * hot path and finding waiters is very rare.  We don't want to walk
 	 * the system-wide hashed waitqueue buckets in the fast path only to
 	 * almost never find waiters.
+	 *
+	 * wq_has_sleeper() supplies the full barrier that orders the wait
+	 * queue read after the bit clear; clear_bit_unlock() alone is only
+	 * a release and would let this check read a stale empty queue,
+	 * losing the wake-up.
 	 */
-	if (waitqueue_active(&cp->cp_waitq))
+	if (wq_has_sleeper(&cp->cp_waitq))
 		wake_up_all(&cp->cp_waitq);
 }
 
@@ -180,8 +185,11 @@ int rds_send_xmit(struct rds_conn_path *cp)
 	WRITE_ONCE(cp->cp_send_gen, send_gen);
 
 	/*
-	 * rds_conn_shutdown() sets the conn state and then tests RDS_IN_XMIT,
-	 * we do the opposite to avoid races.
+	 * rds_conn_shutdown() sets the conn state and then acquires
+	 * RDS_IN_XMIT; we take the lock first and then check the state.
+	 * Ownership is decided by the atomic RMW on the cp_flags word:
+	 * if the teardown won the bit we back off here, and if we won
+	 * it the teardown waits until we release it.
 	 */
 	if (!rds_conn_path_up(cp)) {
 		release_in_xmit(cp);
@@ -1340,7 +1348,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 
 	ret = rds_cong_wait(conn->c_fcong, dport, nonblock, rs);
 	if (ret) {
-		rs->rs_seen_congestion = 1;
+		WRITE_ONCE(rs->rs_seen_congestion, 1);
 		goto out;
 	}
 	while (!rds_send_queue_rm(rs, conn, cpath, rm, rs->rs_bound_port,
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index f66cbf0b9895..fba2c7a2210b 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -46,14 +46,6 @@
 static DEFINE_SPINLOCK(rds_tcp_tc_list_lock);
 static LIST_HEAD(rds_tcp_tc_list);
 
-/* rds_tcp_tc_count counts only IPv4 connections.
- * rds6_tcp_tc_count counts both IPv4 and IPv6 connections.
- */
-static unsigned int rds_tcp_tc_count;
-#if IS_ENABLED(CONFIG_IPV6)
-static unsigned int rds6_tcp_tc_count;
-#endif
-
 /* Track rds_tcp_connection structs so they can be cleaned up */
 static DEFINE_SPINLOCK(rds_tcp_conn_lock);
 static LIST_HEAD(rds_tcp_conn_list);
@@ -109,11 +101,6 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_del_init(&tc->t_list_item);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count--;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count--;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	tc->t_sock = NULL;
@@ -127,46 +114,90 @@ void rds_tcp_restore_callbacks(struct socket *sock,
 }
 
 /*
- * rds_tcp_reset_callbacks() switches the to the new sock and
- * returns the existing tc->t_sock.
+ * rds_tcp_reset_callbacks() switches a path to a new socket and
+ * releases the old one it finds in tc->t_sock, resolving a duelling
+ * SYN.
  *
- * The only functions that set tc->t_sock are rds_tcp_set_callbacks
- * and rds_tcp_reset_callbacks.  Send and receive trust that
- * it is set.  The absence of RDS_CONN_UP bit protects those paths
- * from being called while it isn't set.
+ * tc->t_sock is set by rds_tcp_set_callbacks() and cleared by
+ * rds_tcp_restore_callbacks().  Four paths write it: the active
+ * connect in rds_tcp_conn_path_connect(), which sets it and clears it
+ * again on failure; the accept path in rds_tcp_accept_one(), which
+ * sets it for a path with no socket yet; the teardown in
+ * rds_tcp_conn_path_shutdown(), which clears it; and the swap done
+ * here, which does both.  The connect and accept paths are serialized
+ * against each other by t_conn_path_lock.  Send and receive trust
+ * that it is set: the absence of RDS_CONN_UP protects those paths
+ * from being called while it isn't, and the swap done here runs under
+ * RDS_IN_XMIT so that it cannot interleave with a sender already
+ * inside rds_send_xmit().
  */
 void rds_tcp_reset_callbacks(struct socket *sock,
 			     struct rds_conn_path *cp)
 {
 	struct rds_tcp_connection *tc = cp->cp_transport_data;
-	struct socket *osock = tc->t_sock;
-
-	if (!osock)
-		goto newsock;
+	struct socket *osock;
 
 	/* Need to resolve a duelling SYN between peers.
 	 * We have an outstanding SYN to this peer, which may
 	 * potentially have transitioned to the RDS_CONN_UP state,
 	 * so we must quiesce any send threads before resetting
-	 * cp_transport_data. We quiesce these threads by setting
-	 * cp_state to something other than RDS_CONN_UP, and then
-	 * waiting for any existing threads in rds_send_xmit to
-	 * complete release_in_xmit(). (Subsequent threads entering
-	 * rds_send_xmit() will bail on !rds_conn_up().
+	 * cp_transport_data.  Setting cp_state to something other
+	 * than RDS_CONN_UP stops new senders, and owning RDS_IN_XMIT
+	 * excludes any thread already inside rds_send_xmit() - or a
+	 * teardown in rds_conn_shutdown(), which holds the same lock
+	 * for the duration of the transport shutdown - for the whole
+	 * socket swap and the rds_send_path_reset() below.
+	 *
+	 * An incoming syn-ack at this point would end up marking the
+	 * conn as RDS_CONN_UP, and would again permit rds_send_xmit()
+	 * threads through, so ideally we would synchronize on
+	 * RDS_CONN_UP after lock_sock(), but cannot do that: acquiring
+	 * RDS_IN_XMIT after lock_sock() may end up deadlocking with
+	 * tcp_sendmsg(), which takes the socket lock while holding
+	 * RDS_IN_XMIT.  As a result, we set c_state to
+	 * RDS_CONN_RESETTING, to ensure that rds_tcp_state_change
+	 * cannot mark rds_conn_path_up() in the window before
+	 * lock_sock().
+	 *
+	 * Only make that transition if the path is still connecting
+	 * (or already resetting from an earlier duel).  A path in any
+	 * other state - typically RDS_CONN_DISCONNECTING or
+	 * RDS_CONN_ERROR with a shutdown in flight - is dropped
+	 * instead.  That still replaces its state, with RDS_CONN_ERROR,
+	 * and, unless a pending destroy is about to reap the whole
+	 * connection anyway, queues one more shutdown pass.  A shutdown
+	 * already in flight leaves that RDS_CONN_ERROR alone when it
+	 * finishes; the queued pass then completes the transition to
+	 * RDS_CONN_DOWN and tears down anything that attached to the
+	 * path in the meantime.
+	 */
+	if (!rds_conn_path_transition(cp, RDS_CONN_CONNECTING,
+				      RDS_CONN_RESETTING) &&
+	    !rds_conn_path_transition(cp, RDS_CONN_RESETTING,
+				      RDS_CONN_RESETTING))
+		rds_conn_path_drop(cp, 0);
+	wait_event(cp->cp_waitq,
+		   !test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags));
+
+	/* Read t_sock only while owning RDS_IN_XMIT, never before the
+	 * wait: the teardown in rds_conn_shutdown() releases the old
+	 * socket and clears t_sock, so a pointer sampled earlier can
+	 * be stale by the time we wake up.  The teardown holds the
+	 * same lock while it does so, so what we read here cannot
+	 * change under us until we release it.
+	 */
+	osock = tc->t_sock;
+	if (!osock)
+		goto newsock;
+
+	/* reset receive side state for rds_tcp_data_recv() for osock.
 	 *
-	 * However an incoming syn-ack at this point would end up
-	 * marking the conn as RDS_CONN_UP, and would again permit
-	 * rds_send_xmi() threads through, so ideally we would
-	 * synchronize on RDS_CONN_UP after lock_sock(), but cannot
-	 * do that: waiting on !RDS_IN_XMIT after lock_sock() may
-	 * end up deadlocking with tcp_sendmsg(), and the RDS_IN_XMIT
-	 * would not get set. As a result, we set c_state to
-	 * RDS_CONN_RESETTTING, to ensure that rds_tcp_state_change
-	 * cannot mark rds_conn_path_up() in the window before lock_sock()
+	 * The sync cancels while owning RDS_IN_XMIT rely on cp_wq
+	 * being ordered: a teardown blocked on the bit occupies
+	 * cp_wq's only execution slot, so cp_send_w and cp_recv_w are
+	 * pending at most and the cancels never flush.  Nothing here
+	 * may flush or wait on cp_wq itself.
 	 */
-	atomic_set(&cp->cp_state, RDS_CONN_RESETTING);
-	wait_event(cp->cp_waitq, !test_bit(RDS_IN_XMIT, &cp->cp_flags));
-	/* reset receive side state for rds_tcp_data_recv() for osock  */
 	cancel_delayed_work_sync(&cp->cp_send_w);
 	cancel_delayed_work_sync(&cp->cp_recv_w);
 	lock_sock(osock->sk);
@@ -184,6 +215,9 @@ void rds_tcp_reset_callbacks(struct socket *sock,
 	lock_sock(sock->sk);
 	rds_tcp_set_callbacks(sock, cp);
 	release_sock(sock->sk);
+
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
+	wake_up_all(&cp->cp_waitq);
 }
 
 /* Add tc to rds_tcp_tc_list and set tc->t_sock. See comments
@@ -200,11 +234,6 @@ void rds_tcp_set_callbacks(struct socket *sock, struct rds_conn_path *cp)
 	/* done under the callback_lock to serialize with write_space */
 	spin_lock(&rds_tcp_tc_list_lock);
 	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
-#if IS_ENABLED(CONFIG_IPV6)
-	rds6_tcp_tc_count++;
-#endif
-	if (!tc->t_cpath->cp_conn->c_isv6)
-		rds_tcp_tc_count++;
 	spin_unlock(&rds_tcp_tc_list_lock);
 
 	/* accepted sockets need our listen data ready undone */
@@ -232,20 +261,37 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 			    struct rds_info_iterator *iter,
 			    struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(rds_sock->sk);
 	struct rds_info_tcp_socket tsinfo;
 	struct rds_tcp_connection *tc;
+	unsigned int copied = 0;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo) < rds_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (tc->t_cpath->cp_conn->c_isv6)
+			continue;
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct inet_sock *inet = inet_sk(tc->t_sock->sk);
 
+		if (copied >= cnt)
+			break;
 		if (tc->t_cpath->cp_conn->c_isv6)
 			continue;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
 
 		tsinfo.local_addr = inet->inet_saddr;
 		tsinfo.local_port = inet->inet_sport;
@@ -260,10 +306,12 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
 		tsinfo.tos = tc->t_cpath->cp_conn->c_tos;
 
 		rds_info_copy(iter, &tsinfo, sizeof(tsinfo));
+		copied++;
 	}
+	cnt = copied;
 
 out:
-	lens->nr = rds_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
@@ -278,19 +326,35 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 			     struct rds_info_iterator *iter,
 			     struct rds_info_lengths *lens)
 {
+	struct net *net = sock_net(sock->sk);
 	struct rds6_info_tcp_socket tsinfo6;
 	struct rds_tcp_connection *tc;
+	unsigned int copied = 0;
+	unsigned int cnt = 0;
 	unsigned long flags;
 
 	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
 
-	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count)
+	/* First pass: count entries visible in the caller's netns. */
+	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+		cnt++;
+	}
+
+	if (len / sizeof(tsinfo6) < cnt)
 		goto out;
 
 	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
 		struct sock *sk = tc->t_sock->sk;
 		struct inet_sock *inet = inet_sk(sk);
 
+		if (copied >= cnt)
+			break;
+		/* Only show connections in the caller's netns. */
+		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
+			continue;
+
 		tsinfo6.local_addr = sk->sk_v6_rcv_saddr;
 		tsinfo6.local_port = inet->inet_sport;
 		tsinfo6.peer_addr = sk->sk_v6_daddr;
@@ -303,10 +367,12 @@ static void rds6_tcp_tc_info(struct socket *sock, unsigned int len,
 		tsinfo6.last_seen_una = tc->t_last_seen_una;
 
 		rds_info_copy(iter, &tsinfo6, sizeof(tsinfo6));
+		copied++;
 	}
+	cnt = copied;
 
 out:
-	lens->nr = rds6_tcp_tc_count;
+	lens->nr = cnt;
 	lens->each = sizeof(tsinfo6);
 
 	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 7b6d0088ae33..b42183adcee5 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -193,7 +193,11 @@ int rds_tcp_accept_one(struct socket *sock)
 	if (rs_tcp->t_sock) {
 		/* Duelling SYN has been handled in rds_tcp_accept_one() */
 		rds_tcp_reset_callbacks(new_sock, cp);
-		/* rds_connect_path_complete() marks RDS_CONN_UP */
+		/* rds_connect_path_complete() marks RDS_CONN_UP, or,
+		 * if a concurrent shutdown won the duel, drops the
+		 * path again and the pass that drop queues reaps the
+		 * socket installed above.
+		 */
 		rds_connect_path_complete(cp, RDS_CONN_RESETTING);
 	} else {
 		rds_tcp_set_callbacks(new_sock, cp);
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index c724eea8cf8c..4bdfac2f8082 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -192,12 +192,21 @@ static size_t tcf_action_shared_attrs_size(const struct tc_action *act)
 		+ nla_total_size(IFNAMSIZ) /* TCA_ACT_KIND */
 		+ cookie_len /* TCA_ACT_COOKIE */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_HW_STATS */
+		/* TCA_ACT_USED_HW_STATS */
+		+ nla_total_size(sizeof(struct nla_bitfield32))
+		+ nla_total_size(sizeof(u32)) /* TCA_ACT_IN_HW_COUNT */
 		+ nla_total_size(0) /* TCA_ACT_STATS nested */
 		+ nla_total_size(sizeof(struct nla_bitfield32)) /* TCA_ACT_FLAGS */
 		/* TCA_STATS_BASIC */
 		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
-		/* TCA_STATS_PKT64 */
-		+ nla_total_size_64bit(sizeof(u64))
+		/* TCA_STATS_BASIC_HW */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_basic))
+		/* TCA_STATS_PKT64, emitted by both of the basic copies above */
+		+ 2 * nla_total_size_64bit(sizeof(u64))
+		/* TCA_STATS_RATE_EST */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est))
+		/* TCA_STATS_RATE_EST64 */
+		+ nla_total_size_64bit(sizeof(struct gnet_stats_rate_est64))
 		/* TCA_STATS_QUEUE */
 		+ nla_total_size_64bit(sizeof(struct gnet_stats_queue))
 		+ nla_total_size(0) /* TCA_OPTIONS nested */
@@ -392,7 +401,7 @@ static int tcf_idr_delete_index(struct tcf_idrinfo *idrinfo, u32 index)
 
 	mutex_lock(&idrinfo->lock);
 	p = idr_find(&idrinfo->action_idr, index);
-	if (!p) {
+	if (IS_ERR_OR_NULL(p)) {
 		mutex_unlock(&idrinfo->lock);
 		return -ENOENT;
 	}
@@ -1235,12 +1244,12 @@ static int tca_get_fill(struct sk_buff *skb, struct tc_action *actions[],
 
 static int
 tcf_get_notify(struct net *net, u32 portid, struct nlmsghdr *n,
-	       struct tc_action *actions[], int event,
+	       struct tc_action *actions[], size_t attr_size, int event,
 	       struct netlink_ext_ack *extack)
 {
 	struct sk_buff *skb;
 
-	skb = alloc_skb(NLMSG_GOODSIZE, GFP_KERNEL);
+	skb = alloc_skb(max(attr_size, NLMSG_GOODSIZE), GFP_KERNEL);
 	if (!skb)
 		return -ENOBUFS;
 	if (tca_get_fill(skb, actions, portid, n->nlmsg_seq, 0, event,
@@ -1474,7 +1483,8 @@ tca_action_gd(struct net *net, struct nlattr *nla, struct nlmsghdr *n,
 	attr_size = tcf_action_full_attrs_size(attr_size);
 
 	if (event == RTM_GETACTION)
-		ret = tcf_get_notify(net, portid, n, actions, event, extack);
+		ret = tcf_get_notify(net, portid, n, actions, attr_size, event,
+				     extack);
 	else { /* delete */
 		ret = tcf_del_notify(net, n, actions, portid, attr_size, extack);
 		if (ret)
diff --git a/net/sched/act_csum.c b/net/sched/act_csum.c
index 107dc690de05..39836a30867f 100644
--- a/net/sched/act_csum.c
+++ b/net/sched/act_csum.c
@@ -257,7 +257,9 @@ static int tcf_csum_ipv4_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct iphdr *iph;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
@@ -313,7 +315,9 @@ static int tcf_csum_ipv6_udp(struct sk_buff *skb, unsigned int ihl,
 	const struct ipv6hdr *ip6h;
 	u16 ul;
 
-	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type & SKB_GSO_UDP)
+	if (skb_is_gso(skb) && skb_shinfo(skb)->gso_type &
+	    (SKB_GSO_UDP | SKB_GSO_UDP_L4 |
+	     SKB_GSO_UDP_TUNNEL | SKB_GSO_UDP_TUNNEL_CSUM))
 		return 1;
 
 	/*
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index adb421684440..64084162b283 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -375,11 +375,10 @@ static void tcf_ct_flow_table_add(struct tcf_ct_flow_table *ct_ft,
 	if (test_and_set_bit(IPS_OFFLOAD_BIT, &ct->status))
 		return;
 
+	/* NULL if ct is dying (raced flush) or the atomic alloc failed. */
 	entry = flow_offload_alloc(ct);
-	if (!entry) {
-		WARN_ON_ONCE(1);
+	if (!entry)
 		goto err_alloc;
-	}
 
 	if (tcp) {
 		ct->proto.tcp.seen[0].flags |= IP_CT_TCP_FLAG_BE_LIBERAL;
diff --git a/net/sched/act_gate.c b/net/sched/act_gate.c
index 30bd6eefb461..21ebfdec7798 100644
--- a/net/sched/act_gate.c
+++ b/net/sched/act_gate.c
@@ -700,7 +700,35 @@ static int tcf_gate_search(struct net *net, struct tc_action **a, u32 index)
 
 static size_t tcf_gate_get_fill_size(const struct tc_action *act)
 {
-	return nla_total_size(sizeof(struct tc_gate));
+	struct tcf_gate *gact = to_gate(act);
+	const struct tcf_gate_params *p;
+	struct tcfg_gate_entry *entry;
+	size_t size = nla_total_size(sizeof(struct tc_gate)) /* TCA_GATE_PARMS */
+		+ 3 * nla_total_size_64bit(sizeof(u64)) /* TCA_GATE_BASE_TIME
+							 * TCA_GATE_CYCLE_TIME
+							 * TCA_GATE_CYCLE_TIME_EXT
+							 */
+		+ nla_total_size(sizeof(s32)) /* TCA_GATE_CLOCKID */
+		+ nla_total_size(sizeof(u32)) /* TCA_GATE_FLAGS */
+		+ nla_total_size(sizeof(s32)) /* TCA_GATE_PRIORITY */
+		+ nla_total_size(0); /* TCA_GATE_ENTRY_LIST */
+	/* TCA_GATE_TM is budgeted by tcf_action_shared_attrs_size() */
+
+	rcu_read_lock();
+	p = rcu_dereference(gact->param);
+	if (p) {
+		list_for_each_entry_rcu(entry, &p->entries, list)
+			/* TCA_GATE_ONE_ENTRY nest and its attributes */
+			size += nla_total_size(0)
+				+ nla_total_size(sizeof(u32)) /* TCA_GATE_ENTRY_INDEX */
+				+ nla_total_size(0) /* TCA_GATE_ENTRY_GATE */
+				+ nla_total_size(sizeof(u32)) /* TCA_GATE_ENTRY_INTERVAL */
+				+ nla_total_size(sizeof(s32)) /* TCA_GATE_ENTRY_MAX_OCTETS */
+				+ nla_total_size(sizeof(s32)); /* TCA_GATE_ENTRY_IPV */
+	}
+	rcu_read_unlock();
+
+	return size;
 }
 
 static struct tc_action_ops act_gate_ops = {
diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
index 27847fae053d..81ebfcdf00bd 100644
--- a/net/sched/cls_api.c
+++ b/net/sched/cls_api.c
@@ -2927,7 +2927,7 @@ static int tc_ctl_chain(struct sk_buff *skb, struct nlmsghdr *n,
 	tcf_chain_put(chain);
 errout_block:
 	tcf_block_release(q, block, true);
-	if (err == -EAGAIN)
+	if (err == -EAGAIN && n->nlmsg_type == RTM_NEWCHAIN)
 		/* Replay the request. */
 		goto replay;
 	return err;
diff --git a/net/sched/cls_route.c b/net/sched/cls_route.c
index 695c91961e33..e30bcd3734e1 100644
--- a/net/sched/cls_route.c
+++ b/net/sched/cls_route.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/errno.h>
+#include <linux/refcount.h>
 #include <linux/skbuff.h>
 #include <net/dst.h>
 #include <net/route.h>
@@ -40,6 +41,7 @@ struct route4_head {
 struct route4_bucket {
 	/* 16 FROM buckets + 16 IIF buckets + 1 wildcard bucket */
 	struct route4_filter __rcu	*ht[16 + 16 + 1];
+	refcount_t			filters_ref;
 	struct rcu_head			rcu;
 };
 
@@ -334,7 +336,7 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 	struct route4_filter *nf;
 	struct route4_bucket *b;
 	unsigned int h = 0;
-	int i, h1;
+	int h1;
 
 	if (!head || !f)
 		return -EINVAL;
@@ -360,23 +362,14 @@ static int route4_delete(struct tcf_proto *tp, void *arg, bool *last,
 			tcf_exts_get_net(&f->exts);
 			tcf_queue_work(&f->rwork, route4_delete_filter_work);
 
-			/* Strip RTNL protected tree */
-			for (i = 0; i <= 32; i++) {
-				struct route4_filter *rt;
-
-				rt = rtnl_dereference(b->ht[i]);
-				if (rt)
-					goto out;
+			if (refcount_dec_and_test(&b->filters_ref)) {
+				RCU_INIT_POINTER(head->table[to_hash(h)], NULL);
+				kfree_rcu(b, rcu);
 			}
-
-			/* OK, session has no flows */
-			RCU_INIT_POINTER(head->table[to_hash(h)], NULL);
-			kfree_rcu(b, rcu);
 			break;
 		}
 	}
 
-out:
 	*last = true;
 	for (h1 = 0; h1 <= 256; h1++) {
 		if (rcu_access_pointer(head->table[h1])) {
@@ -453,6 +446,7 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		if (b == NULL)
 			return -ENOBUFS;
 
+		refcount_set(&b->filters_ref, 1);
 		rcu_assign_pointer(head->table[h1], b);
 	} else {
 		unsigned int h2 = from_hash(nhandle >> 16);
@@ -462,6 +456,8 @@ static int route4_set_parms(struct net *net, struct tcf_proto *tp,
 		     fp = rtnl_dereference(fp->next))
 			if (fp->handle == f->handle)
 				return -EEXIST;
+
+		refcount_inc(&b->filters_ref);
 	}
 
 	if (tb[TCA_ROUTE4_TO])
@@ -495,7 +491,7 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	struct route4_bucket *b;
 	struct nlattr *opt = tca[TCA_OPTIONS];
 	struct nlattr *tb[TCA_ROUTE4_MAX + 1];
-	unsigned int h, th;
+	unsigned int h;
 	int err;
 	bool new = true;
 
@@ -553,17 +549,20 @@ static int route4_change(struct net *net, struct sk_buff *in_skb,
 	rcu_assign_pointer(*fp, f);
 
 	if (fold) {
-		th = to_hash(fold->handle);
+		b = fold->bkt;
 		h = from_hash(fold->handle >> 16);
-		b = rtnl_dereference(head->table[th]);
-		if (b) {
-			fp = &b->ht[h];
-			for (pfp = rtnl_dereference(*fp); pfp;
-			     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
-				if (pfp == fold) {
-					rcu_assign_pointer(*fp, fold->next);
-					break;
+		fp = &b->ht[h];
+		for (pfp = rtnl_dereference(*fp); pfp;
+		     fp = &pfp->next, pfp = rtnl_dereference(*fp)) {
+			if (pfp == fold) {
+				rcu_assign_pointer(*fp, fold->next);
+				if (refcount_dec_and_test(&b->filters_ref)) {
+					unsigned int th = to_hash(fold->handle);
+
+					RCU_INIT_POINTER(head->table[th], NULL);
+					kfree_rcu(b, rcu);
 				}
+				break;
 			}
 		}
 	}
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 5b78ce01b1e7..763beca62f5f 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -83,8 +83,9 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			NL_SET_ERR_MSG(extack, "Specified DRR quantum cannot be zero");
 			return -EINVAL;
 		}
+		quantum = clamp_t(u32, quantum, 256, 1 << 20);
 	} else
-		quantum = psched_mtu(qdisc_dev(sch));
+		quantum = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 
 	if (cl != NULL) {
 		if (tca[TCA_RATE]) {
@@ -99,10 +100,8 @@ static int drr_change_class(struct Qdisc *sch, u32 classid, u32 parentid,
 			}
 		}
 
-		sch_tree_lock(sch);
 		if (tb[TCA_DRR_QUANTUM])
-			cl->quantum = quantum;
-		sch_tree_unlock(sch);
+			WRITE_ONCE(cl->quantum, quantum);
 
 		return 0;
 	}
@@ -251,7 +250,7 @@ static int drr_dump_class(struct Qdisc *sch, unsigned long arg,
 	nest = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (nest == NULL)
 		goto nla_put_failure;
-	if (nla_put_u32(skb, TCA_DRR_QUANTUM, cl->quantum))
+	if (nla_put_u32(skb, TCA_DRR_QUANTUM, READ_ONCE(cl->quantum)))
 		goto nla_put_failure;
 	return nla_nest_end(skb, nest);
 
@@ -370,7 +369,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (!cl_is_active(cl)) {
 		list_add_tail(&cl->alist, &q->active);
-		WRITE_ONCE(cl->deficit, cl->quantum);
+		WRITE_ONCE(cl->deficit, READ_ONCE(cl->quantum));
 	}
 
 	sch->qstats.backlog += len;
@@ -411,7 +410,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			return skb;
 		}
 
-		WRITE_ONCE(cl->deficit, cl->deficit + cl->quantum);
+		WRITE_ONCE(cl->deficit, cl->deficit + READ_ONCE(cl->quantum));
 		list_move_tail(&cl->alist, &q->active);
 	}
 out:
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index cecd7209a86c..0c2349c08f8c 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -83,11 +83,7 @@ static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
 {
-	*quantum = nla_get_u32(attr);
-	if (!*quantum) {
-		NL_SET_ERR_MSG(extack, "ETS quantum cannot be zero");
-		return -EINVAL;
-	}
+	*quantum = clamp_t(u32, nla_get_u32(attr), 256, 1 << 20);
 	return 0;
 }
 
@@ -647,11 +643,13 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
 			return err;
 	}
 	/* If there are more bands than strict + quanta provided, the remaining
-	 * ones are ETS with quantum of MTU. Initialize the missing values here.
+	 * ones are ETS with quantum of max(MTU, 256). Initialize the missing
+	 * values here.
 	 */
 	for (i = nstrict; i < nbands; i++) {
 		if (!quanta[i])
-			quanta[i] = psched_mtu(qdisc_dev(sch));
+			quanta[i] = clamp_t(u32, (u32)psched_mtu(qdisc_dev(sch)),
+					    256, 1 << 20);
 	}
 
 	/* Before commit, make sure we can allocate all new qdiscs */
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index c5c728576c16..9e9b6cb6baae 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -301,8 +301,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_PIE_LIMIT]) {
 		u32 limit = nla_get_u32(tb[TCA_FQ_PIE_LIMIT]);
 
-		q->p_params.limit = limit;
-		sch->limit = limit;
+		WRITE_ONCE(q->p_params.limit, limit);
+		WRITE_ONCE(sch->limit, limit);
 	}
 	if (tb[TCA_FQ_PIE_FLOWS]) {
 		if (q->flows) {
@@ -324,39 +324,46 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 		u32 target = nla_get_u32(tb[TCA_FQ_PIE_TARGET]);
 
 		/* convert to pschedtime */
-		q->p_params.target =
-			PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC);
+		WRITE_ONCE(q->p_params.target,
+			   PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC));
 	}
 
 	/* tupdate is in jiffies */
 	if (tb[TCA_FQ_PIE_TUPDATE])
-		q->p_params.tupdate =
-			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE]));
+		WRITE_ONCE(q->p_params.tupdate,
+			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));
 
 	if (tb[TCA_FQ_PIE_ALPHA])
-		q->p_params.alpha = nla_get_u32(tb[TCA_FQ_PIE_ALPHA]);
+		WRITE_ONCE(q->p_params.alpha,
+			   nla_get_u32(tb[TCA_FQ_PIE_ALPHA]));
 
 	if (tb[TCA_FQ_PIE_BETA])
-		q->p_params.beta = nla_get_u32(tb[TCA_FQ_PIE_BETA]);
+		WRITE_ONCE(q->p_params.beta,
+			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		q->quantum = nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]);
+		WRITE_ONCE(q->quantum,
+			   max(256U, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM])));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
-		q->memory_limit = nla_get_u32(tb[TCA_FQ_PIE_MEMORY_LIMIT]);
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_FQ_PIE_MEMORY_LIMIT]));
 
 	if (tb[TCA_FQ_PIE_ECN_PROB])
-		q->ecn_prob = nla_get_u32(tb[TCA_FQ_PIE_ECN_PROB]);
+		WRITE_ONCE(q->ecn_prob,
+			   nla_get_u32(tb[TCA_FQ_PIE_ECN_PROB]));
 
 	if (tb[TCA_FQ_PIE_ECN])
-		q->p_params.ecn = nla_get_u32(tb[TCA_FQ_PIE_ECN]);
+		WRITE_ONCE(q->p_params.ecn,
+			   nla_get_u32(tb[TCA_FQ_PIE_ECN]));
 
 	if (tb[TCA_FQ_PIE_BYTEMODE])
-		q->p_params.bytemode = nla_get_u32(tb[TCA_FQ_PIE_BYTEMODE]);
+		WRITE_ONCE(q->p_params.bytemode,
+			   nla_get_u32(tb[TCA_FQ_PIE_BYTEMODE]));
 
 	if (tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR])
-		q->p_params.dq_rate_estimator =
-			nla_get_u32(tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR]);
+		WRITE_ONCE(q->p_params.dq_rate_estimator,
+			   nla_get_u32(tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR]));
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
@@ -472,22 +479,23 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	/* convert target from pschedtime to us */
-	if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_FLOWS, q->flows_cnt) ||
+	if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_FLOWS, READ_ONCE(q->flows_cnt)) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_TARGET,
-			((u32)PSCHED_TICKS2NS(q->p_params.target)) /
+			((u32)PSCHED_TICKS2NS(READ_ONCE(q->p_params.target))) /
 			NSEC_PER_USEC) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_TUPDATE,
-			jiffies_to_usecs(q->p_params.tupdate)) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ALPHA, q->p_params.alpha) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_BETA, q->p_params.beta) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_QUANTUM, q->quantum) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_MEMORY_LIMIT, q->memory_limit) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ECN_PROB, q->ecn_prob) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ECN, q->p_params.ecn) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_BYTEMODE, q->p_params.bytemode) ||
+			jiffies_to_usecs(READ_ONCE(q->p_params.tupdate))) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ALPHA, READ_ONCE(q->p_params.alpha)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_BETA, READ_ONCE(q->p_params.beta)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_QUANTUM, READ_ONCE(q->quantum)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_MEMORY_LIMIT,
+			READ_ONCE(q->memory_limit)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ECN_PROB, READ_ONCE(q->ecn_prob)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ECN, READ_ONCE(q->p_params.ecn)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_BYTEMODE, READ_ONCE(q->p_params.bytemode)) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_DQ_RATE_ESTIMATOR,
-			q->p_params.dq_rate_estimator))
+			READ_ONCE(q->p_params.dq_rate_estimator)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b5e7eb023812..8b8f03e71a5c 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -387,6 +387,15 @@ cftree_update(struct hfsc_class *cl)
 #define	SM_MASK		((1ULL << SM_SHIFT) - 1)
 #define	ISM_MASK	((1ULL << ISM_SHIFT) - 1)
 
+/*
+ * Cap on the non-descending hops a classify walk may take before its
+ * filter chain is treated as misconfigured. A flowid binding that was
+ * legal at bind time can become lateral once hfsc_adjust_levels()
+ * raises a class level; a few such hops are legitimate, an unbounded
+ * run means the chain cycles.
+ */
+#define	HFSC_CLASSIFY_MAX_DRIFT	8
+
 static inline u64
 seg_x2y(u64 x, u64 sm)
 {
@@ -1132,6 +1141,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 	struct hfsc_class *head, *cl;
 	struct tcf_result res;
 	struct tcf_proto *tcf;
+	unsigned int drift;
 	int result;
 
 	if (TC_H_MAJ(skb->priority ^ sch->handle) == 0 &&
@@ -1141,6 +1151,7 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 
 	*qerr = NET_XMIT_SUCCESS | __NET_XMIT_BYPASS;
 	head = &q->root;
+	drift = HFSC_CLASSIFY_MAX_DRIFT;
 	tcf = rcu_dereference_bh(q->root.filter_list);
 	while (tcf && (result = tcf_classify(skb, tcf, &res, false)) >= 0) {
 #ifdef CONFIG_NET_CLS_ACT
@@ -1166,6 +1177,17 @@ hfsc_classify(struct sk_buff *skb, struct Qdisc *sch, int *qerr)
 		if (cl->level == 0)
 			return cl; /* hit leaf class */
 
+		/*
+		 * flowid binds skip the level check above (res.class is set
+		 * at bind time and levels drift after), so a walk can follow
+		 * lateral hops without descending; a bounded number of them
+		 * is legal, more means the chain cycles.
+		 */
+		if (cl->level >= head->level && drift-- == 0) {
+			pr_warn_ratelimited("hfsc: classify hop budget exhausted, dropping packet\n");
+			return NULL;
+		}
+
 		/* apply inner filter chain */
 		tcf = rcu_dereference_bh(cl->filter_list);
 		head = cl;
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index ba67eed62d31..e7f2483e686d 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -526,7 +526,7 @@ static void hhf_destroy(struct Qdisc *sch)
 static const struct nla_policy hhf_policy[TCA_HHF_MAX + 1] = {
 	[TCA_HHF_BACKLOG_LIMIT]	 = { .type = NLA_U32 },
 	[TCA_HHF_QUANTUM]	 = { .type = NLA_U32 },
-	[TCA_HHF_HH_FLOWS_LIMIT] = { .type = NLA_U32 },
+	[TCA_HHF_HH_FLOWS_LIMIT] = NLA_POLICY_MAX(NLA_U32, 2 * HH_FLOWS_CNT),
 	[TCA_HHF_RESET_TIMEOUT]	 = { .type = NLA_U32 },
 	[TCA_HHF_ADMIT_BYTES]	 = { .type = NLA_U32 },
 	[TCA_HHF_EVICT_TIMEOUT]	 = { .type = NLA_U32 },
@@ -548,12 +548,12 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	err = nla_parse_nested_deprecated(tb, TCA_HHF_MAX, opt, hhf_policy,
-					  NULL);
+					  extack);
 	if (err < 0)
 		return err;
 
 	if (tb[TCA_HHF_QUANTUM])
-		new_quantum = nla_get_u32(tb[TCA_HHF_QUANTUM]);
+		new_quantum = max(256U, nla_get_u32(tb[TCA_HHF_QUANTUM]));
 
 	if (tb[TCA_HHF_NON_HH_WEIGHT])
 		new_hhf_non_hh_weight = nla_get_u32(tb[TCA_HHF_NON_HH_WEIGHT]);
@@ -609,7 +609,7 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	int i;
 
 	sch->limit = 1000;
-	q->quantum = psched_mtu(qdisc_dev(sch));
+	q->quantum = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 256, 1 << 20);
 	get_random_bytes(&q->perturbation, sizeof(q->perturbation));
 	INIT_LIST_HEAD(&q->new_buckets);
 	INIT_LIST_HEAD(&q->old_buckets);
@@ -620,9 +620,8 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 	q->hhf_evict_timeout = HZ;      /* 1  sec */
 	q->hhf_non_hh_weight = 2;
 
-	if ((int)q->quantum <= 0 ||
-	    (u64)q->quantum * q->hhf_non_hh_weight > INT_MAX)
-		q->quantum = 256;
+	/* Cap max active HHs at twice len of hh_flows table. */
+	q->hh_flows_limit = 2 * HH_FLOWS_CNT;
 
 	if (opt) {
 		int err = hhf_change(sch, opt, extack);
@@ -640,8 +639,6 @@ static int hhf_init(struct Qdisc *sch, struct nlattr *opt,
 		for (i = 0; i < HH_FLOWS_CNT; i++)
 			INIT_LIST_HEAD(&q->hh_flows[i]);
 
-		/* Cap max active HHs at twice len of hh_flows table. */
-		q->hh_flows_limit = 2 * HH_FLOWS_CNT;
 		q->hh_flows_overlimit = 0;
 		q->hh_flows_total_cnt = 0;
 		q->hh_flows_current_cnt = 0;
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 4d0f86c3ae70..e924de350887 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -35,7 +35,7 @@ bool pie_drop_early(struct Qdisc *sch, struct pie_params *params,
 {
 	u64 rnd;
 	u64 local_prob = vars->prob;
-	u32 mtu = psched_mtu(qdisc_dev(sch));
+	u32 mtu = clamp_t(u32, psched_mtu(qdisc_dev(sch)), 1, 1 << 20);
 
 	/* If there is still burst allowance left skip random early drop */
 	if (vars->burst_time > 0)
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 7b81cd8a2ef0..bb97610114ab 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -654,6 +654,11 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 	}
 
+	if (ctl->quantum > 1 << 20) {
+		NL_SET_ERR_MSG_MOD(extack, "quantum too large");
+		return -EINVAL;
+	}
+
 	if (ctl->perturb_period < 0 ||
 	    ctl->perturb_period > INT_MAX / HZ) {
 		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
@@ -682,7 +687,7 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 
 	/* update and validate configuration */
 	if (ctl->quantum)
-		quantum = ctl->quantum;
+		quantum = max(256U, ctl->quantum);
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index e78a849fb1b0..00ac4386627c 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -242,14 +242,11 @@ __teql_resolve(struct sk_buff *skb, struct sk_buff *skb_res,
 	}
 
 	if (neigh_event_send(n, skb_res) == 0) {
-		int err;
 		char haddr[MAX_ADDR_LEN];
 
 		neigh_ha_snapshot(haddr, n, dev);
-		err = dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
-				      haddr, NULL, skb->len);
-
-		if (err < 0)
+		if (dev_hard_header(skb, dev, ntohs(skb_protocol(skb, false)),
+				    haddr, NULL, skb->len) < 0)
 			err = -EINVAL;
 	} else {
 		err = (skb_res == NULL) ? -EAGAIN : 1;
diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index 8fc11f06ab23..ad1a7368f6ab 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -1295,18 +1295,19 @@ void sctp_assoc_update_retran_path(struct sctp_association *asoc)
 		/* Manually skip the head element. */
 		if (&trans->transports == &asoc->peer.transport_addr_list)
 			continue;
-		if (trans->state == SCTP_UNCONFIRMED)
-			continue;
-		trans_next = sctp_trans_elect_best(trans, trans_next);
-		/* Active is good enough for immediate return. */
-		if (trans_next->state == SCTP_ACTIVE)
-			break;
+		if (trans->state != SCTP_UNCONFIRMED) {
+			trans_next = sctp_trans_elect_best(trans, trans_next);
+			/* Active is good enough for immediate return. */
+			if (trans_next->state == SCTP_ACTIVE)
+				break;
+		}
 		/* We've reached the end, time to update path. */
 		if (trans == asoc->peer.retran_path)
 			break;
 	}
 
-	asoc->peer.retran_path = trans_next;
+	if (trans_next)
+		asoc->peer.retran_path = trans_next;
 
 	pr_debug("%s: association:%p updated new path to addr:%pISpc\n",
 		 __func__, asoc, &asoc->peer.retran_path->ipaddr.sa);
diff --git a/net/sctp/ipv6.c b/net/sctp/ipv6.c
index 48bd3b52d56d..d56e4bdaa9c1 100644
--- a/net/sctp/ipv6.c
+++ b/net/sctp/ipv6.c
@@ -1149,11 +1149,17 @@ void sctp_v6_protosw_exit(void)
 /* Register with inet6 layer. */
 int sctp_v6_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet6 address additions/deletions. */
-	register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	ret = register_inet6addr_notifier(&sctp_inet6addr_notifier);
+	if (ret)
+		return ret;
 
-	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0)
+	if (inet6_add_protocol(&sctpv6_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inet6addr_notifier(&sctp_inet6addr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index 6e3d0872491a..5305a5be74de 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -1178,12 +1178,18 @@ static void sctp_v4_protosw_exit(void)
 
 static int sctp_v4_add_protocol(void)
 {
+	int ret;
+
 	/* Register notifier for inet address additions/deletions. */
-	register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	ret = register_inetaddr_notifier(&sctp_inetaddr_notifier);
+	if (ret)
+		return ret;
 
 	/* Register SCTP with inet layer.  */
-	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0)
+	if (inet_add_protocol(&sctp_protocol, IPPROTO_SCTP) < 0) {
+		unregister_inetaddr_notifier(&sctp_inetaddr_notifier);
 		return -EAGAIN;
+	}
 
 	return 0;
 }
diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
index 06309c1869da..3425554931a3 100644
--- a/net/sctp/sm_make_chunk.c
+++ b/net/sctp/sm_make_chunk.c
@@ -3192,6 +3192,9 @@ bool sctp_verify_asconf(const struct sctp_association *asoc,
 		*errp = param.p;
 		switch (param.p->type) {
 		case SCTP_PARAM_ERR_CAUSE:
+			if (length < sizeof(struct sctp_addip_param) +
+				     sizeof(struct sctp_errhdr))
+				return false;
 			break;
 		case SCTP_PARAM_IPV4_ADDRESS:
 			if (length != sizeof(struct sctp_ipv4addr_param))
@@ -3425,20 +3428,15 @@ static __be16 sctp_get_asconf_response(struct sctp_chunk *asconf_ack,
 			case SCTP_PARAM_ERR_CAUSE:
 				length = sizeof(*asconf_ack_param);
 				err_param = (void *)asconf_ack_param + length;
-				asconf_ack_len -= length;
-				if (asconf_ack_len > 0)
-					return err_param->cause;
-				else
-					return SCTP_ERROR_INV_PARAM;
-				break;
+				return err_param->cause;
 			default:
 				return SCTP_ERROR_INV_PARAM;
 			}
 		}
 
 		length = ntohs(asconf_ack_param->param_hdr.length);
-		asconf_ack_param = (void *)asconf_ack_param + length;
-		asconf_ack_len -= length;
+		asconf_ack_param = (void *)asconf_ack_param + SCTP_PAD4(length);
+		asconf_ack_len -= SCTP_PAD4(length);
 	}
 
 	return err_code;
diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index a9fb38de8b12..9ad5dd28329f 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1534,17 +1534,8 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
 			timeout = asoc->timeouts[cmd->obj.to];
 			BUG_ON(!timeout);
 
-			/*
-			 * SCTP has a hard time with timer starts.  Because we process
-			 * timer starts as side effects, it can be hard to tell if we
-			 * have already started a timer or not, which leads to BUG
-			 * halts when we call add_timer. So here, instead of just starting
-			 * a timer, if the timer is already started, and just mod
-			 * the timer with the shorter of the two expiration times
-			 */
-			if (!timer_pending(timer))
+			if (!timer_reduce(timer, jiffies + timeout))
 				sctp_association_hold(asoc);
-			timer_reduce(timer, jiffies + timeout);
 			break;
 
 		case SCTP_CMD_TIMER_RESTART:
diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index ea5c941821ec..759e73919e95 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -2544,6 +2544,8 @@ static enum sctp_disposition sctp_sf_do_5_2_6_stale(
 
 	sctp_add_cmd_sf(commands, SCTP_CMD_REPLY, SCTP_CHUNK(reply));
 
+	sctp_add_cmd_sf(commands, SCTP_CMD_DISCARD_PACKET, SCTP_NULL());
+
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem:
diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
index bdbe82b306c5..8d72865dd7fb 100644
--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -47,7 +47,6 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 	struct smc_clc_msg_hdr *hdr = &pclc->hdr;
 	struct smc_clc_v2_extension *v2_ext;
 
-	v2_ext = smc_get_clc_v2_ext(pclc);
 	pclc_prfx = smc_clc_proposal_get_prefix(pclc);
 	if (!pclc_prfx ||
 	    pclc_prfx->ipv6_prefixes_cnt > SMC_CLC_MAX_V6_PREFIX)
@@ -64,6 +63,13 @@ static bool smc_clc_msg_prop_valid(struct smc_clc_msg_proposal *pclc)
 			sizeof(struct smc_clc_msg_trail))
 			return false;
 	} else {
+		v2_ext = smc_get_clc_v2_ext(pclc);
+		if ((hdr->typev2 != SMC_TYPE_N &&
+		     (!v2_ext || v2_ext->hdr.eid_cnt > SMC_CLC_MAX_UEID)) ||
+		    (smcd_indicated(hdr->typev2) &&
+		     v2_ext->hdr.ism_gid_cnt > SMC_MAX_ISM_DEVS))
+			return false;
+
 		if (ntohs(hdr->length) !=
 			sizeof(*pclc) +
 			sizeof(struct smc_clc_msg_smcd) +
diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h
index a57a3489df4a..0c8e752f09f4 100644
--- a/net/smc/smc_clc.h
+++ b/net/smc/smc_clc.h
@@ -153,6 +153,7 @@ struct smc_clc_msg_proposal {	/* clc proposal message sent by Linux */
 } __aligned(4);
 
 #define SMC_CLC_MAX_V6_PREFIX		8
+#define SMC_CLC_MAX_UEID		8
 
 struct smc_clc_msg_proposal_area {
 	struct smc_clc_msg_proposal		pclc_base;
@@ -292,8 +293,14 @@ static inline struct smc_clc_v2_extension *
 smc_get_clc_v2_ext(struct smc_clc_msg_proposal *prop)
 {
 	struct smc_clc_msg_smcd *prop_smcd = smc_get_clc_msg_smcd(prop);
+	u16 max_offset;
 
-	if (!prop_smcd || !ntohs(prop_smcd->v2_ext_offset))
+	max_offset = offsetof(struct smc_clc_msg_proposal_area, pclc_v2_ext) -
+		     offsetof(struct smc_clc_msg_proposal_area, pclc_smcd) -
+		     offsetofend(struct smc_clc_msg_smcd, v2_ext_offset);
+
+	if (!prop_smcd || !ntohs(prop_smcd->v2_ext_offset) ||
+	    ntohs(prop_smcd->v2_ext_offset) > max_offset)
 		return NULL;
 
 	return (struct smc_clc_v2_extension *)
@@ -306,9 +313,15 @@ smc_get_clc_v2_ext(struct smc_clc_msg_proposal *prop)
 static inline struct smc_clc_smcd_v2_extension *
 smc_get_clc_smcd_v2_ext(struct smc_clc_v2_extension *prop_v2ext)
 {
+	u16 max_offset = offsetof(struct smc_clc_msg_proposal_area, pclc_smcd_v2_ext) -
+		offsetof(struct smc_clc_msg_proposal_area, pclc_v2_ext) -
+		offsetof(struct smc_clc_v2_extension, hdr) -
+		offsetofend(struct smc_clnt_opts_area_hdr, smcd_v2_ext_offset);
+
 	if (!prop_v2ext)
 		return NULL;
-	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset))
+	if (!ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) ||
+	    ntohs(prop_v2ext->hdr.smcd_v2_ext_offset) > max_offset)
 		return NULL;
 
 	return (struct smc_clc_smcd_v2_extension *)
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 9262c94a13c1..257acdb5bf56 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1054,6 +1054,22 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 		rpcrdma_rep_destroy(rep);
 }
 
+static unsigned int rpcrdma_req_pool_slack(unsigned int max_reqs)
+{
+	/* The sendctx ring can hold up to one Send-signaling batch
+	 * (re_send_batch, set by frwr_open() to re_max_requests >> 3)
+	 * of unfinished Sends. Each pins its req until a signaled Send
+	 * completion releases the sendctx. Size the pool above max_reqs
+	 * by that batch so the recycle delay does not stall a slot
+	 * allocation that the RPC/RDMA credit window would admit.
+	 *
+	 * Round up: re_max_requests >> 3 is zero when max_reqs < 8, but
+	 * a single unsignaled Send is still enough to pin one req. One
+	 * slack slot covers that case.
+	 */
+	return DIV_ROUND_UP(max_reqs, 8);
+}
+
 /**
  * rpcrdma_buffer_create - Create initial set of req/rep objects
  * @r_xprt: transport instance to (re)initialize
@@ -1063,6 +1079,7 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
+	unsigned int max_reqs;
 	int i, rc;
 
 	buf->rb_bc_srv_max_requests = 0;
@@ -1076,7 +1093,9 @@ int rpcrdma_buffer_create(struct rpcrdma_xprt *r_xprt)
 	INIT_LIST_HEAD(&buf->rb_all_reps);
 
 	rc = -ENOMEM;
-	for (i = 0; i < r_xprt->rx_xprt.max_reqs; i++) {
+	max_reqs = r_xprt->rx_xprt.max_reqs;
+	max_reqs += rpcrdma_req_pool_slack(max_reqs);
+	for (i = 0; i < max_reqs; i++) {
 		struct rpcrdma_req *req;
 
 		req = rpcrdma_req_create(r_xprt, RPCRDMA_V1_DEF_INLINE_SIZE * 2,
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 5dccad3271fe..4ec6516a53e0 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1666,7 +1666,12 @@ static int xs_get_srcport(struct sock_xprt *transport)
 unsigned short get_srcport(struct rpc_xprt *xprt)
 {
 	struct sock_xprt *sock = container_of(xprt, struct sock_xprt, xprt);
-	return xs_sock_getport(sock->sock);
+	unsigned short ret = 0;
+	mutex_lock(&sock->recv_mutex);
+	if (sock->sock)
+		ret = xs_sock_getport(sock->sock);
+	mutex_unlock(&sock->recv_mutex);
+	return ret;
 }
 EXPORT_SYMBOL(get_srcport);
 
diff --git a/net/tipc/group.c b/net/tipc/group.c
index cae497418dc9..74ff6f811527 100644
--- a/net/tipc/group.c
+++ b/net/tipc/group.c
@@ -796,10 +796,10 @@ void tipc_group_proto_rcv(struct tipc_group *grp, bool *usr_wakeup,
 		tipc_group_open(m, usr_wakeup);
 		return;
 	case GRP_ACK_MSG:
-		if (!m)
+		if (!m || !grp->bc_ackers)
 			return;
 		acked = msg_grp_bc_acked(hdr);
-		if (less_eq(acked, m->bc_acked))
+		if (acked != grp->bc_snd_nxt || m->bc_acked == acked)
 			return;
 		m->bc_acked = acked;
 		if (--grp->bc_ackers)
diff --git a/net/tipc/monitor.c b/net/tipc/monitor.c
index ba0a308d41d8..0b5832640b32 100644
--- a/net/tipc/monitor.c
+++ b/net/tipc/monitor.c
@@ -601,9 +601,10 @@ static void mon_timeout(struct timer_list *t)
 {
 	struct tipc_monitor *mon = from_timer(mon, t, timer);
 	struct tipc_peer *self;
-	int best_member_cnt = dom_size(mon->peer_cnt) - 1;
+	int best_member_cnt;
 
 	write_lock_bh(&mon->lock);
+	best_member_cnt = dom_size(mon->peer_cnt) - 1;
 	self = mon->self;
 	if (self && (best_member_cnt != self->applied)) {
 		mon_update_local_domain(mon);
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 974a33015f37..f0c6291d3924 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -314,7 +314,7 @@ static void hvs_open_connection(struct vmbus_channel *chan)
 		goto out;
 
 	if (conn_from_host) {
-		if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog)
+		if (sk_acceptq_is_full(sk))
 			goto out;
 
 		new = vsock_create_connected(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index aa6f2a142966..4085163bb92d 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -1004,7 +1004,7 @@ static int vmci_transport_recv_listen(struct sock *sk,
 	 * reset.  Otherwise we create and initialize a child socket and reply
 	 * with a connection negotiation.
 	 */
-	if (sk->sk_ack_backlog >= sk->sk_max_ack_backlog) {
+	if (sk_acceptq_is_full(sk)) {
 		vmci_transport_reply_reset(pkt);
 		return -ECONNREFUSED;
 	}
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3b2a70b467de..506d621212e4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -16259,7 +16259,7 @@ void nl80211_send_ibss_bssid(struct cfg80211_registered_device *rdev,
 }
 
 void cfg80211_notify_new_peer_candidate(struct net_device *dev, const u8 *addr,
-					const u8 *ie, u8 ie_len,
+					const u8 *ie, size_t ie_len,
 					int sig_dbm, gfp_t gfp)
 {
 	struct wireless_dev *wdev = dev->ieee80211_ptr;
diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7d0ddc467232..058f3c1f8791 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1860,6 +1860,13 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 			if (!hidden)
 				hidden = rb_find_bss(rdev, tmp,
 						     BSS_CMP_HIDE_NUL);
+			/*
+			 * Only group with an entry with beacon data, otherwise
+			 * beacon data can never be filled/updated.
+			 */
+			if (hidden &&
+			    !rcu_access_pointer(hidden->pub.beacon_ies))
+				hidden = NULL;
 			if (hidden) {
 				new->pub.hidden_beacon_bss = &hidden->pub;
 				list_add(&new->hidden_list,
@@ -2733,11 +2740,6 @@ void cfg80211_update_assoc_bss_entry(struct wireless_dev *wdev,
 	cbss->pub.channel = chan;
 
 	list_for_each_entry(bss, &rdev->bss_list, list) {
-		if (!cfg80211_bss_type_match(bss->pub.capability,
-					     bss->pub.channel->band,
-					     wdev->conn_bss_type))
-			continue;
-
 		if (bss == cbss)
 			continue;
 
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 29b8233d4a9c..fe096f5e5e64 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -856,12 +856,30 @@ unsigned int cfg80211_classify8021d(struct sk_buff *skb,
 	}
 
 	switch (skb->protocol) {
-	case htons(ETH_P_IP):
-		dscp = ipv4_get_dsfield(ip_hdr(skb)) & 0xfc;
+	case htons(ETH_P_IP): {
+		const struct iphdr *iph;
+		struct iphdr _iph;
+
+		iph = skb_header_pointer(skb, sizeof(struct ethhdr),
+					 sizeof(*iph), &_iph);
+		if (!iph)
+			return 0;
+
+		dscp = ipv4_get_dsfield(iph) & 0xfc;
 		break;
-	case htons(ETH_P_IPV6):
-		dscp = ipv6_get_dsfield(ipv6_hdr(skb)) & 0xfc;
+	}
+	case htons(ETH_P_IPV6): {
+		const struct ipv6hdr *ip6h;
+		struct ipv6hdr _ip6h;
+
+		ip6h = skb_header_pointer(skb, sizeof(struct ethhdr),
+					  sizeof(*ip6h), &_ip6h);
+		if (!ip6h)
+			return 0;
+
+		dscp = ipv6_get_dsfield(ip6h) & 0xfc;
 		break;
+	}
 	case htons(ETH_P_MPLS_UC):
 	case htons(ETH_P_MPLS_MC): {
 		struct mpls_label mpls_tmp, *mpls;
diff --git a/net/wireless/wext-sme.c b/net/wireless/wext-sme.c
index 73df23570d43..d27ec0163b08 100644
--- a/net/wireless/wext-sme.c
+++ b/net/wireless/wext-sme.c
@@ -333,6 +333,15 @@ int cfg80211_wext_siwgenie(struct net_device *dev,
 		goto out;
 
 	if (ie_len) {
+		const struct element *elem;
+
+		for_each_element(elem, extra, ie_len) {
+			/* nothing */
+		}
+
+		if (!for_each_element_completed(elem, extra, ie_len))
+			return -EINVAL;
+
 		ie = kmemdup(extra, ie_len, GFP_KERNEL);
 		if (!ie) {
 			err = -ENOMEM;
diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
index 49da2b8ace8b..3ef6d12bb9ac 100644
--- a/net/xdp/xskmap.c
+++ b/net/xdp/xskmap.c
@@ -138,7 +138,7 @@ static int xsk_map_gen_lookup(struct bpf_map *map, struct bpf_insn *insn_buf)
 	struct bpf_insn *insn = insn_buf;
 
 	*insn++ = BPF_LDX_MEM(BPF_W, ret, index, 0);
-	*insn++ = BPF_JMP_IMM(BPF_JGE, ret, map->max_entries, 5);
+	*insn++ = BPF_JMP32_IMM(BPF_JGE, ret, map->max_entries, 5);
 	*insn++ = BPF_ALU64_IMM(BPF_LSH, ret, ilog2(sizeof(struct xsk_sock *)));
 	*insn++ = BPF_ALU64_IMM(BPF_ADD, mp, offsetof(struct xsk_map, xsk_map));
 	*insn++ = BPF_ALU64_REG(BPF_ADD, ret, mp);
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index c929bef82368..ce97c28dd579 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -31,7 +31,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 {
 	struct tcp_skb_cb *tcp_cb = (struct tcp_skb_cb *)skb->cb;
 
-	skb_reset_transport_header(skb);
+	if (!skb_reset_transport_header_careful(skb)) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		return;
+	}
 
 	/* restore IP CB, we need at least IP6CB->nhoff */
 	memmove(skb->cb, &tcp_cb->header, sizeof(tcp_cb->header));
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 27c5ad0e3d6c..9a9e291dd964 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -34,7 +34,17 @@
 #endif
 #include <asm/unaligned.h>
 
-static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
+static struct sock *xfrm_net_nlsk(const struct net *net, const struct sk_buff *skb)
+{
+	/* get the source of this request, see netlink_unicast_kernel */
+	const struct sock *sk = NETLINK_CB(skb).sk;
+
+	/* sk is refcounted, the netns stays alive and nlsk with it */
+	return rcu_dereference_protected(net->xfrm.nlsk, sk->sk_net_refcnt);
+}
+
+static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type,
+			  struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[type];
 	struct xfrm_algo *algp;
@@ -43,8 +53,10 @@ static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 		return 0;
 
 	algp = nla_data(rt);
-	if (nla_len(rt) < (int)xfrm_alg_len(algp))
+	if (nla_len(rt) < (int)xfrm_alg_len(algp)) {
+		NL_SET_ERR_MSG(extack, "Invalid AUTH/CRYPT/COMP attribute length");
 		return -EINVAL;
+	}
 
 	switch (type) {
 	case XFRMA_ALG_AUTH:
@@ -53,6 +65,7 @@ static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 		break;
 
 	default:
+		NL_SET_ERR_MSG(extack, "Invalid algorithm attribute type");
 		return -EINVAL;
 	}
 
@@ -60,7 +73,8 @@ static int verify_one_alg(struct nlattr **attrs, enum xfrm_attr_type_t type)
 	return 0;
 }
 
-static int verify_auth_trunc(struct nlattr **attrs)
+static int verify_auth_trunc(struct nlattr **attrs,
+			     struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_ALG_AUTH_TRUNC];
 	struct xfrm_algo_auth *algp;
@@ -69,14 +83,16 @@ static int verify_auth_trunc(struct nlattr **attrs)
 		return 0;
 
 	algp = nla_data(rt);
-	if (nla_len(rt) < (int)xfrm_alg_auth_len(algp))
+	if (nla_len(rt) < (int)xfrm_alg_auth_len(algp)) {
+		NL_SET_ERR_MSG(extack, "Invalid AUTH_TRUNC attribute length");
 		return -EINVAL;
+	}
 
 	algp->alg_name[sizeof(algp->alg_name) - 1] = '\0';
 	return 0;
 }
 
-static int verify_aead(struct nlattr **attrs)
+static int verify_aead(struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_ALG_AEAD];
 	struct xfrm_algo_aead *algp;
@@ -85,8 +101,10 @@ static int verify_aead(struct nlattr **attrs)
 		return 0;
 
 	algp = nla_data(rt);
-	if (nla_len(rt) < (int)aead_len(algp))
+	if (nla_len(rt) < (int)aead_len(algp)) {
+		NL_SET_ERR_MSG(extack, "Invalid AEAD attribute length");
 		return -EINVAL;
+	}
 
 	algp->alg_name[sizeof(algp->alg_name) - 1] = '\0';
 	return 0;
@@ -101,7 +119,7 @@ static void verify_one_addr(struct nlattr **attrs, enum xfrm_attr_type_t type,
 		*addrp = nla_data(rt);
 }
 
-static inline int verify_sec_ctx_len(struct nlattr **attrs)
+static inline int verify_sec_ctx_len(struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct nlattr *rt = attrs[XFRMA_SEC_CTX];
 	struct xfrm_user_sec_ctx *uctx;
@@ -111,8 +129,10 @@ static inline int verify_sec_ctx_len(struct nlattr **attrs)
 
 	uctx = nla_data(rt);
 	if (uctx->len > nla_len(rt) ||
-	    uctx->len != (sizeof(struct xfrm_user_sec_ctx) + uctx->ctx_len))
+	    uctx->len != (sizeof(struct xfrm_user_sec_ctx) + uctx->ctx_len)) {
+		NL_SET_ERR_MSG(extack, "Invalid security context length");
 		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -146,7 +166,8 @@ static inline int verify_replay(struct xfrm_usersa_info *p,
 }
 
 static int verify_newsa_info(struct xfrm_usersa_info *p,
-			     struct nlattr **attrs)
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack)
 {
 	int err;
 	u16 family = p->sel.family;
@@ -161,10 +182,12 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		break;
 #else
 		err = -EAFNOSUPPORT;
+		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
 		goto out;
 #endif
 
 	default:
+		NL_SET_ERR_MSG(extack, "Invalid address family");
 		goto out;
 	}
 
@@ -176,65 +199,98 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		break;
 
 	case AF_INET:
-		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32)
+		if (p->sel.prefixlen_d > 32 || p->sel.prefixlen_s > 32) {
+			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 32 for IPv4)");
 			goto out;
+		}
 
 		break;
 
 	case AF_INET6:
 #if IS_ENABLED(CONFIG_IPV6)
-		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128)
+		if (p->sel.prefixlen_d > 128 || p->sel.prefixlen_s > 128) {
+			NL_SET_ERR_MSG(extack, "Invalid prefix length in selector (must be <= 128 for IPv6)");
 			goto out;
+		}
 
 		break;
 #else
+		NL_SET_ERR_MSG(extack, "IPv6 support disabled");
 		err = -EAFNOSUPPORT;
 		goto out;
 #endif
 
 	default:
+		NL_SET_ERR_MSG(extack, "Invalid address family in selector");
 		goto out;
 	}
 
 	err = -EINVAL;
 	switch (p->id.proto) {
 	case IPPROTO_AH:
-		if ((!attrs[XFRMA_ALG_AUTH]	&&
-		     !attrs[XFRMA_ALG_AUTH_TRUNC]) ||
-		    attrs[XFRMA_ALG_AEAD]	||
+		if (!attrs[XFRMA_ALG_AUTH]	&&
+		    !attrs[XFRMA_ALG_AUTH_TRUNC]) {
+			NL_SET_ERR_MSG(extack, "Missing required attribute for AH: AUTH_TRUNC or AUTH");
+			goto out;
+		}
+
+		if (attrs[XFRMA_ALG_AEAD]	||
 		    attrs[XFRMA_ALG_CRYPT]	||
 		    attrs[XFRMA_ALG_COMP]	||
-		    attrs[XFRMA_TFCPAD])
+		    attrs[XFRMA_TFCPAD]) {
+			NL_SET_ERR_MSG(extack, "Invalid attributes for AH: AEAD, CRYPT, COMP, TFCPAD");
 			goto out;
+		}
 		break;
 
 	case IPPROTO_ESP:
-		if (attrs[XFRMA_ALG_COMP])
+		if (attrs[XFRMA_ALG_COMP]) {
+			NL_SET_ERR_MSG(extack, "Invalid attribute for ESP: COMP");
 			goto out;
+		}
+
 		if (!attrs[XFRMA_ALG_AUTH] &&
 		    !attrs[XFRMA_ALG_AUTH_TRUNC] &&
 		    !attrs[XFRMA_ALG_CRYPT] &&
-		    !attrs[XFRMA_ALG_AEAD])
+		    !attrs[XFRMA_ALG_AEAD]) {
+			NL_SET_ERR_MSG(extack, "Missing required attribute for ESP: at least one of AUTH, AUTH_TRUNC, CRYPT, AEAD");
 			goto out;
+		}
+
 		if ((attrs[XFRMA_ALG_AUTH] ||
 		     attrs[XFRMA_ALG_AUTH_TRUNC] ||
 		     attrs[XFRMA_ALG_CRYPT]) &&
-		    attrs[XFRMA_ALG_AEAD])
+		    attrs[XFRMA_ALG_AEAD]) {
+			NL_SET_ERR_MSG(extack, "Invalid attribute combination for ESP: AEAD can't be used with AUTH, AUTH_TRUNC, CRYPT");
 			goto out;
+		}
+
 		if (attrs[XFRMA_TFCPAD] &&
-		    p->mode != XFRM_MODE_TUNNEL)
+		    p->mode != XFRM_MODE_TUNNEL) {
+			NL_SET_ERR_MSG(extack, "TFC padding can only be used in tunnel mode");
 			goto out;
+		}
 		break;
 
 	case IPPROTO_COMP:
-		if (!attrs[XFRMA_ALG_COMP]	||
-		    attrs[XFRMA_ALG_AEAD]	||
+		if (!attrs[XFRMA_ALG_COMP]) {
+			NL_SET_ERR_MSG(extack, "Missing required attribute for COMP: COMP");
+			goto out;
+		}
+
+		if (attrs[XFRMA_ALG_AEAD]	||
 		    attrs[XFRMA_ALG_AUTH]	||
 		    attrs[XFRMA_ALG_AUTH_TRUNC]	||
 		    attrs[XFRMA_ALG_CRYPT]	||
-		    attrs[XFRMA_TFCPAD]		||
-		    (ntohl(p->id.spi) >= 0x10000))
+		    attrs[XFRMA_TFCPAD]) {
+			NL_SET_ERR_MSG(extack, "Invalid attributes for COMP: AEAD, AUTH, AUTH_TRUNC, CRYPT, TFCPAD");
+			goto out;
+		}
+
+		if (ntohl(p->id.spi) >= 0x10000) {
+			NL_SET_ERR_MSG(extack, "SPI is too large for COMP (must be < 0x10000)");
 			goto out;
+		}
 		break;
 
 #if IS_ENABLED(CONFIG_IPV6)
@@ -247,27 +303,34 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		    attrs[XFRMA_ALG_CRYPT]	||
 		    attrs[XFRMA_ENCAP]		||
 		    attrs[XFRMA_SEC_CTX]	||
-		    attrs[XFRMA_TFCPAD]		||
-		    !attrs[XFRMA_COADDR])
+		    attrs[XFRMA_TFCPAD]) {
+			NL_SET_ERR_MSG(extack, "Invalid attributes for DSTOPTS/ROUTING");
+			goto out;
+		}
+
+		if (!attrs[XFRMA_COADDR]) {
+			NL_SET_ERR_MSG(extack, "Missing required COADDR attribute for DSTOPTS/ROUTING");
 			goto out;
+		}
 		break;
 #endif
 
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported protocol");
 		goto out;
 	}
 
-	if ((err = verify_aead(attrs)))
+	if ((err = verify_aead(attrs, extack)))
 		goto out;
-	if ((err = verify_auth_trunc(attrs)))
+	if ((err = verify_auth_trunc(attrs, extack)))
 		goto out;
-	if ((err = verify_one_alg(attrs, XFRMA_ALG_AUTH)))
+	if ((err = verify_one_alg(attrs, XFRMA_ALG_AUTH, extack)))
 		goto out;
-	if ((err = verify_one_alg(attrs, XFRMA_ALG_CRYPT)))
+	if ((err = verify_one_alg(attrs, XFRMA_ALG_CRYPT, extack)))
 		goto out;
-	if ((err = verify_one_alg(attrs, XFRMA_ALG_COMP)))
+	if ((err = verify_one_alg(attrs, XFRMA_ALG_COMP, extack)))
 		goto out;
-	if ((err = verify_sec_ctx_len(attrs)))
+	if ((err = verify_sec_ctx_len(attrs, extack)))
 		goto out;
 	if ((err = verify_replay(p, attrs)))
 		goto out;
@@ -281,14 +344,19 @@ static int verify_newsa_info(struct xfrm_usersa_info *p,
 		break;
 
 	default:
+		NL_SET_ERR_MSG(extack, "Unsupported mode");
 		goto out;
 	}
 
 	err = 0;
 
-	if (attrs[XFRMA_MTIMER_THRESH])
-		if (!attrs[XFRMA_ENCAP])
+	if (attrs[XFRMA_MTIMER_THRESH]) {
+		if (!attrs[XFRMA_ENCAP]) {
+			NL_SET_ERR_MSG(extack, "MTIMER_THRESH attribute can only be set on ENCAP states");
 			err = -EINVAL;
+			goto out;
+		}
+	}
 
 out:
 	return err;
@@ -681,7 +749,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 }
 
 static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_usersa_info *p = nlmsg_data(nlh);
@@ -689,7 +757,7 @@ static int xfrm_add_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	struct km_event c;
 
-	err = verify_newsa_info(p, attrs);
+	err = verify_newsa_info(p, attrs, extack);
 	if (err)
 		return err;
 
@@ -760,7 +828,7 @@ static struct xfrm_state *xfrm_user_state_lookup(struct net *net,
 }
 
 static int xfrm_del_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
@@ -1206,7 +1274,8 @@ static int build_spdinfo(struct sk_buff *skb, struct net *net,
 }
 
 static int xfrm_set_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
-			    struct nlattr **attrs)
+			    struct nlattr **attrs,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrmu_spdhthresh *thresh4 = NULL;
@@ -1251,7 +1320,8 @@ static int xfrm_set_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			    struct nlattr **attrs,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct sk_buff *r_skb;
@@ -1267,7 +1337,7 @@ static int xfrm_get_spdinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_spdinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static inline unsigned int xfrm_sadinfo_msgsize(void)
@@ -1310,7 +1380,8 @@ static int build_sadinfo(struct sk_buff *skb, struct net *net,
 }
 
 static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			    struct nlattr **attrs,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct sk_buff *r_skb;
@@ -1326,11 +1397,11 @@ static int xfrm_get_sadinfo(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_sadinfo(r_skb, net, sportid, seq, *flags);
 	BUG_ON(err < 0);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, sportid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, sportid);
 }
 
 static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_usersa_id *p = nlmsg_data(nlh);
@@ -1346,7 +1417,7 @@ static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (IS_ERR(resp_skb)) {
 		err = PTR_ERR(resp_skb);
 	} else {
-		err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+		err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 	}
 	xfrm_state_put(x);
 out_noput:
@@ -1354,12 +1425,12 @@ static int xfrm_get_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			      struct nlattr **attrs,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
 	struct xfrm_userspi_info *p;
-	struct xfrm_translator *xtr;
 	struct sk_buff *resp_skb;
 	xfrm_address_t *daddr;
 	int family;
@@ -1410,18 +1481,7 @@ static int xfrm_alloc_userspi(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto out;
 	}
 
-	xtr = xfrm_get_translator();
-	if (xtr) {
-		err = xtr->alloc_compat(skb, nlmsg_hdr(skb));
-
-		xfrm_put_translator(xtr);
-		if (err) {
-			kfree_skb(resp_skb);
-			goto out;
-		}
-	}
-
-	err = nlmsg_unicast(net->xfrm.nlsk, resp_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb, NETLINK_CB(skb).portid);
 
 out:
 	xfrm_state_put(x);
@@ -1706,7 +1766,8 @@ static struct xfrm_policy *xfrm_policy_construct(struct net *net, struct xfrm_us
 }
 
 static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			   struct nlattr **attrs,
+			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_userpolicy_info *p = nlmsg_data(nlh);
@@ -1718,7 +1779,7 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = verify_newpolicy_info(p);
 	if (err)
 		return err;
-	err = verify_sec_ctx_len(attrs);
+	err = verify_sec_ctx_len(attrs, extack);
 	if (err)
 		return err;
 
@@ -1970,7 +2031,7 @@ static bool xfrm_userpolicy_is_valid(__u8 policy)
 }
 
 static int xfrm_set_default(struct sk_buff *skb, struct nlmsghdr *nlh,
-			    struct nlattr **attrs)
+			    struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_userpolicy_default *up = nlmsg_data(nlh);
@@ -1991,7 +2052,7 @@ static int xfrm_set_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_get_default(struct sk_buff *skb, struct nlmsghdr *nlh,
-			    struct nlattr **attrs)
+			    struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct sk_buff *r_skb;
 	struct nlmsghdr *r_nlh;
@@ -2017,11 +2078,12 @@ static int xfrm_get_default(struct sk_buff *skb, struct nlmsghdr *nlh,
 	r_up->out = net->xfrm.policy_default[XFRM_POLICY_OUT];
 	nlmsg_end(r_skb, r_nlh);
 
-	return nlmsg_unicast(net->xfrm.nlsk, r_skb, portid);
+	return nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, portid);
 }
 
 static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			   struct nlattr **attrs,
+			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_policy *xp;
@@ -2056,7 +2118,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct nlattr *rt = attrs[XFRMA_SEC_CTX];
 		struct xfrm_sec_ctx *ctx;
 
-		err = verify_sec_ctx_len(attrs);
+		err = verify_sec_ctx_len(attrs, extack);
 		if (err)
 			return err;
 
@@ -2082,7 +2144,7 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 		if (IS_ERR(resp_skb)) {
 			err = PTR_ERR(resp_skb);
 		} else {
-			err = nlmsg_unicast(net->xfrm.nlsk, resp_skb,
+			err = nlmsg_unicast(xfrm_net_nlsk(net, skb), resp_skb,
 					    NETLINK_CB(skb).portid);
 		}
 	} else {
@@ -2104,7 +2166,8 @@ static int xfrm_get_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_flush_sa(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			 struct nlattr **attrs,
+			 struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct km_event c;
@@ -2204,7 +2267,7 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
 }
 
 static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
@@ -2241,14 +2304,14 @@ static int xfrm_get_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = build_aevent(r_skb, x, &c);
 	BUG_ON(err < 0);
 
-	err = nlmsg_unicast(net->xfrm.nlsk, r_skb, NETLINK_CB(skb).portid);
+	err = nlmsg_unicast(xfrm_net_nlsk(net, skb), r_skb, NETLINK_CB(skb).portid);
 	spin_unlock_bh(&x->lock);
 	xfrm_state_put(x);
 	return err;
 }
 
 static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+		       struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
@@ -2299,7 +2362,8 @@ static int xfrm_new_ae(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_flush_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			     struct nlattr **attrs,
+			     struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct km_event c;
@@ -2327,7 +2391,8 @@ static int xfrm_flush_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			       struct nlattr **attrs,
+			       struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_policy *xp;
@@ -2358,7 +2423,7 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 		struct nlattr *rt = attrs[XFRMA_SEC_CTX];
 		struct xfrm_sec_ctx *ctx;
 
-		err = verify_sec_ctx_len(attrs);
+		err = verify_sec_ctx_len(attrs, extack);
 		if (err)
 			return err;
 
@@ -2393,7 +2458,8 @@ static int xfrm_add_pol_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			      struct nlattr **attrs,
+			      struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_state *x;
@@ -2427,7 +2493,8 @@ static int xfrm_add_sa_expire(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
-		struct nlattr **attrs)
+			    struct nlattr **attrs,
+			    struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
 	struct xfrm_policy *xp;
@@ -2448,7 +2515,7 @@ static int xfrm_add_acquire(struct sk_buff *skb, struct nlmsghdr *nlh,
 	err = verify_newpolicy_info(&ua->policy);
 	if (err)
 		goto free_state;
-	err = verify_sec_ctx_len(attrs);
+	err = verify_sec_ctx_len(attrs, extack);
 	if (err)
 		goto free_state;
 
@@ -2532,7 +2599,7 @@ static int copy_from_user_migrate(struct xfrm_migrate *ma,
 }
 
 static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
-			   struct nlattr **attrs)
+			   struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	struct xfrm_userpolicy_id *pi = nlmsg_data(nlh);
 	struct xfrm_migrate m[XFRM_MAX_DEPTH];
@@ -2578,7 +2645,7 @@ static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 #else
 static int xfrm_do_migrate(struct sk_buff *skb, struct nlmsghdr *nlh,
-			   struct nlattr **attrs)
+			   struct nlattr **attrs, struct netlink_ext_ack *extack)
 {
 	return -ENOPROTOOPT;
 }
@@ -2775,7 +2842,8 @@ static const struct nla_policy xfrma_spd_policy[XFRMA_SPD_MAX+1] = {
 };
 
 static const struct xfrm_link {
-	int (*doit)(struct sk_buff *, struct nlmsghdr *, struct nlattr **);
+	int (*doit)(struct sk_buff *, struct nlmsghdr *, struct nlattr **,
+		    struct netlink_ext_ack *);
 	int (*start)(struct netlink_callback *);
 	int (*dump)(struct sk_buff *, struct netlink_callback *);
 	int (*done)(struct netlink_callback *);
@@ -2862,7 +2930,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 			goto err;
 		}
 
-		err = netlink_dump_start(net->xfrm.nlsk, skb, nlh, &c);
+		err = netlink_dump_start(xfrm_net_nlsk(net, skb), skb, nlh, &c);
 		goto err;
 	}
 
@@ -2877,7 +2945,7 @@ static int xfrm_user_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		goto err;
 	}
 
-	err = link->doit(skb, nlh, attrs);
+	err = link->doit(skb, nlh, attrs, extack);
 
 	/* We need to free skb allocated in xfrm_alloc_compat() before
 	 * returning from this function, because consume_skb() won't take
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 379d03d0c5e6..f5c166bf20fd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2146,8 +2146,17 @@ void __attribute__((format(printf, 2, 3))) buf_printf(struct buffer *buf,
 
 	va_start(ap, fmt);
 	len = vsnprintf(tmp, SZ, fmt, ap);
-	buf_write(buf, tmp, len);
 	va_end(ap);
+
+	if (len < 0) {
+		perror("vsnprintf failed");
+		exit(1);
+	}
+	if (len >= SZ)
+		fatal("buf_printf output truncated for string %s: %d bytes needed, %d available\n",
+		      tmp, len + 1, SZ);
+
+	buf_write(buf, tmp, len);
 }
 
 void buf_write(struct buffer *buf, const char *s, int len)
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 615a20b9eb52..0b8de87ca39b 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -81,6 +81,11 @@ static int ima_fix_xattr(struct dentry *dentry,
 	int rc, offset;
 	u8 algo = iint->ima_hash->algo;
 
+	if (IS_RDONLY(d_inode(dentry)))
+		return -EROFS;
+	if (IS_IMMUTABLE(d_inode(dentry)))
+		return -EPERM;
+
 	if (algo <= HASH_ALGO_SHA1) {
 		offset = 1;
 		iint->ima_hash->xattr.sha1.type = IMA_XATTR_DIGEST;
diff --git a/security/keys/gc.c b/security/keys/gc.c
index eaddaceda14e..285ebbf490f0 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -324,9 +324,7 @@ static void key_garbage_collector(struct work_struct *work)
 
 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
-		smp_mb();
-		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
+		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}
 
 	if (gc_state & KEY_GC_REAP_AGAIN)
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 20f3f1f4893e..2ced8c4726b1 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -9,6 +9,8 @@
 
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/pid.h>
+#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
-		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
+		seq_printf(m, " pid:%d ci:%zu",
+			   pid_nr_ns(rka->pid,
+				     proc_pid_ns(file_inode(m->file)->i_sb)),
+			   rka->callout_len);
 }
 
 /*
@@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	if (rka->cred)
 		put_cred(rka->cred);
 	kfree(rka->callout_info);
+	put_pid(rka->pid);
 	kfree(rka);
 }
 
@@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 		irka = cred->request_key_auth->payload.data[0];
 		rka->cred = get_cred(irka->cred);
-		rka->pid = irka->pid;
+		rka->pid = get_pid(irka->pid);
 
 		up_read(&cred->request_key_auth->sem);
 	}
 	else {
 		/* it isn't - use this process as the context */
 		rka->cred = get_cred(cred);
-		rka->pid = current->pid;
+		rka->pid = get_pid(task_pid(current));
 	}
 
 	rka->target_key = key_get(target);
diff --git a/security/selinux/avc.c b/security/selinux/avc.c
index ab71d0948205..441ff3e77389 100644
--- a/security/selinux/avc.c
+++ b/security/selinux/avc.c
@@ -1145,8 +1145,11 @@ inline int avc_has_perm_noaudit(struct selinux_state *state,
 	int rc = 0;
 	u32 denied;
 
-	if (WARN_ON(!requested))
+	if (WARN_ON(!requested)) {
+		/* Provide a deny-all, audit-all decision to the caller. */
+		*avd = (struct av_decision){ .auditdeny = 0xffffffff };
 		return -EACCES;
+	}
 
 	rcu_read_lock();
 
diff --git a/sound/core/pcm_timer.c b/sound/core/pcm_timer.c
index c43484b22b34..725a7272cd07 100644
--- a/sound/core/pcm_timer.c
+++ b/sound/core/pcm_timer.c
@@ -112,12 +112,15 @@ void snd_pcm_timer_init(struct snd_pcm_substream *substream)
 				"capture" : "playback",
 			tid.card, tid.device, tid.subdevice);
 	timer->hw = snd_pcm_timer;
+	/* Set before registering: a concurrent reader can invoke our hw
+	 * callbacks as soon as the timer is on the global list.
+	 */
+	timer->private_data = substream;
+	timer->private_free = snd_pcm_timer_free;
 	if (snd_device_register(timer->card, timer) < 0) {
 		snd_device_free(timer->card, timer);
 		return;
 	}
-	timer->private_data = substream;
-	timer->private_free = snd_pcm_timer_free;
 	substream->timer = timer;
 }
 
diff --git a/sound/core/seq/oss/seq_oss_rw.c b/sound/core/seq/oss/seq_oss_rw.c
index e89a2d8bf4f2..312b56ff2669 100644
--- a/sound/core/seq/oss/seq_oss_rw.c
+++ b/sound/core/seq/oss/seq_oss_rw.c
@@ -57,7 +57,8 @@ snd_seq_oss_read(struct seq_oss_devinfo *dp, char __user *buf, int count)
 			break;
 		}
 		ev_len = ev_length(&rec);
-		if (ev_len < count) {
+		if (count < ev_len) {
+			err = -EINVAL;
 			snd_seq_oss_readq_unlock(readq, flags);
 			break;
 		}
diff --git a/sound/isa/es18xx.c b/sound/isa/es18xx.c
index 5f8d7e8a5477..3780460fc8f3 100644
--- a/sound/isa/es18xx.c
+++ b/sound/isa/es18xx.c
@@ -1820,6 +1820,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 	for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_base_controls); idx++) {
 		struct snd_kcontrol *kctl;
 		kctl = snd_ctl_new1(&snd_es18xx_base_controls[idx], chip);
+		if (!kctl)
+			return -ENOMEM;
 		if (chip->caps & ES18XX_HWV) {
 			switch (idx) {
 			case 0:
@@ -1874,6 +1876,8 @@ static int snd_es18xx_mixer(struct snd_card *card)
 		for (idx = 0; idx < ARRAY_SIZE(snd_es18xx_hw_volume_controls); idx++) {
 			struct snd_kcontrol *kctl;
 			kctl = snd_ctl_new1(&snd_es18xx_hw_volume_controls[idx], chip);
+			if (!kctl)
+				return -ENOMEM;
 			if (idx == 0)
 				chip->hw_volume = kctl;
 			else
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 85d1fc76f59e..6b75c714d5c6 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -993,6 +993,7 @@ static int daio_mgr_dao_init(void *blk, unsigned int idx, unsigned int conf)
 		/* S/PDIF output */
 		switch ((conf & 0xf)) {
 		case 1:
+		case 9:
 			set_field(&ctl->txctl[idx], ATXCTL_NUC, 0);
 			break;
 		case 2:
diff --git a/sound/pci/hda/hda_controller.c b/sound/pci/hda/hda_controller.c
index ea76395d71d3..16e47468cd66 100644
--- a/sound/pci/hda/hda_controller.c
+++ b/sound/pci/hda/hda_controller.c
@@ -588,11 +588,11 @@ static int azx_pcm_open(struct snd_pcm_substream *substream)
 	snd_hda_codec_pcm_get(apcm->info);
 	mutex_lock(&chip->open_mutex);
 	azx_dev = azx_assign_device(chip, substream);
-	trace_azx_pcm_open(chip, azx_dev);
 	if (azx_dev == NULL) {
 		err = -EBUSY;
 		goto unlock;
 	}
+	trace_azx_pcm_open(chip, azx_dev);
 	runtime->private_data = azx_dev;
 
 	runtime->hw = azx_pcm_hw;
diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 4d0bd1903ccb..6a7fcb4c77dd 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -237,6 +237,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10,
 	CXT_PINCFG_TOP_SPEAKER,
 	CXT_FIXUP_HP_A_U,
 	CXT_FIXUP_ACER_SWIFT_HP,
@@ -771,6 +772,12 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* Lenovo IdeaPad Slim 5 16AKP10 with SN6140 */
+static const struct hda_pintbl cxt_pincfg_lenovo_ideapad_slim5_16akp10[] = {
+	{ 0x1a, 0x95a60130 }, /* Internal mic, fixed/always-connected */
+	{}
+};
+
 /* SuoWoSi/South-holding JS201D with sn6140 */
 static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{ 0x16, 0x03211040 }, /* hp out */
@@ -962,6 +969,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lenovo_ideapad_slim5_16akp10,
+	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = cxt_fixup_sirius_top_speaker,
@@ -1067,6 +1078,7 @@ static const struct snd_pci_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
+	SND_PCI_QUIRK(0x17aa, 0x38b6, "Lenovo IdeaPad Slim 5 16AKP10", CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10),
 	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 31cf426f026c..ea10ee4de2f5 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9266,6 +9266,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x869d, "HP", ALC236_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x86c1, "HP Laptop 15-da3001TU", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPIO),
+	SND_PCI_QUIRK(0x103c, 0x86c8, "HP Laptop 14s-dr1xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x863e, "HP Spectre x360 15-df1xxx", ALC285_FIXUP_HP_SPECTRE_X360_DF1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_HP_SPECTRE_X360_EB1),
@@ -9355,6 +9356,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x18f1, "Asus FX505DT", ALC256_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x194e, "ASUS UX563FD", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x1970, "ASUS UX550VE", ALC289_FIXUP_ASUS_GA401),
+	SND_PCI_QUIRK(0x1043, 0x197e, "ASUS VivoBook X509DAP", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1982, "ASUS B1400CEPE", ALC256_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19ce, "ASUS B9450FA", ALC294_FIXUP_ASUS_HPE),
 	SND_PCI_QUIRK(0x1043, 0x19e1, "ASUS UX581LV", ALC295_FIXUP_ASUS_MIC_NO_PRESENCE),
diff --git a/sound/soc/amd/renoir/acp3x-pdm-dma.c b/sound/soc/amd/renoir/acp3x-pdm-dma.c
index ca794c2b272d..c23f3d9be588 100644
--- a/sound/soc/amd/renoir/acp3x-pdm-dma.c
+++ b/sound/soc/amd/renoir/acp3x-pdm-dma.c
@@ -99,7 +99,7 @@ static void disable_pdm_interrupts(void __iomem *acp_base)
 	u32 ext_int_ctrl;
 
 	ext_int_ctrl = rn_readl(acp_base + ACP_EXTERNAL_INTR_CNTL);
-	ext_int_ctrl |= ~PDM_DMA_INTR_MASK;
+	ext_int_ctrl &= ~PDM_DMA_INTR_MASK;
 	rn_writel(ext_int_ctrl, acp_base + ACP_EXTERNAL_INTR_CNTL);
 }
 
diff --git a/sound/soc/bcm/bcm63xx-i2s-whistler.c b/sound/soc/bcm/bcm63xx-i2s-whistler.c
index 246a57ac6679..cf8a6cb47697 100644
--- a/sound/soc/bcm/bcm63xx-i2s-whistler.c
+++ b/sound/soc/bcm/bcm63xx-i2s-whistler.c
@@ -299,6 +299,7 @@ static const struct of_device_id snd_soc_bcm_audio_match[] = {
 	{.compatible = "brcm,bcm63xx-i2s"},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, snd_soc_bcm_audio_match);
 #endif
 
 static struct platform_driver bcm63xx_i2s_driver = {
diff --git a/sound/soc/codecs/ab8500-codec.c b/sound/soc/codecs/ab8500-codec.c
index b4bf411124fa..ac7a2e360715 100644
--- a/sound/soc/codecs/ab8500-codec.c
+++ b/sound/soc/codecs/ab8500-codec.c
@@ -312,7 +312,7 @@ static const struct snd_kcontrol_new dapm_anc_in_select[] = {
 /* ANC - Enable/Disable */
 static const struct snd_kcontrol_new dapm_anc_enable[] = {
 	SOC_DAPM_SINGLE("Switch", AB8500_ANCCONF1,
-			AB8500_ANCCONF1_ENANC, 0, 0),
+			AB8500_ANCCONF1_ENANC, 1, 0),
 };
 
 /* ANC to Earpiece - Mute */
@@ -394,12 +394,6 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 
 	/* DA/AD */
 
-	SND_SOC_DAPM_INPUT("ADC Input"),
-	SND_SOC_DAPM_ADC("ADC", "ab8500_0c", SND_SOC_NOPM, 0, 0),
-
-	SND_SOC_DAPM_DAC("DAC", NULL, SND_SOC_NOPM, 0, 0),
-	SND_SOC_DAPM_OUTPUT("DAC Output"),
-
 	SND_SOC_DAPM_AIF_IN("DA_IN1", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("DA_IN2", NULL, 0, SND_SOC_NOPM, 0, 0),
 	SND_SOC_DAPM_AIF_IN("DA_IN3", NULL, 0, SND_SOC_NOPM, 0, 0),
@@ -591,9 +585,8 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("AD3 Channel Volume",
 			SND_SOC_NOPM, 0, 0,
 			NULL, 0),
-	SND_SOC_DAPM_MIXER("AD3 Enable",
-			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD34, 0,
-			NULL, 0),
+	SND_SOC_DAPM_SUPPLY("AD34 Enable", AB8500_ADPATHENA,
+			    AB8500_ADPATHENA_ENAD34, 0, NULL, 0),
 
 	/* Mic 2 */
 
@@ -652,9 +645,8 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 			SND_SOC_NOPM, 0, 0,
 			NULL, 0),
 
-	SND_SOC_DAPM_MIXER("AD12 Enable",
-			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD12, 0,
-			NULL, 0),
+	SND_SOC_DAPM_SUPPLY("AD12 Enable", AB8500_ADPATHENA,
+			    AB8500_ADPATHENA_ENAD12, 0, NULL, 0),
 
 	/* HD Capture path */
 
@@ -668,12 +660,8 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("AD6 Channel Volume",
 			SND_SOC_NOPM, 0, 0,
 			NULL, 0),
-	SND_SOC_DAPM_MIXER("AD57 Enable",
-			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD5768, 0,
-			NULL, 0),
-	SND_SOC_DAPM_MIXER("AD68 Enable",
-			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD5768, 0,
-			NULL, 0),
+	SND_SOC_DAPM_SUPPLY("AD5768 Enable", AB8500_ADPATHENA,
+			    AB8500_ADPATHENA_ENAD5768, 0, NULL, 0),
 
 	/* Digital Microphone path */
 
@@ -705,10 +693,6 @@ static const struct snd_soc_dapm_widget ab8500_dapm_widgets[] = {
 	SND_SOC_DAPM_MIXER("AD4 Channel Volume",
 			SND_SOC_NOPM, 0, 0,
 			NULL, 0),
-	SND_SOC_DAPM_MIXER("AD4 Enable",
-			AB8500_ADPATHENA, AB8500_ADPATHENA_ENAD34,
-			0, NULL, 0),
-
 	/* Acoustical Noise Cancellation path */
 
 	SND_SOC_DAPM_INPUT("ANC Configure Input"),
@@ -756,24 +740,17 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	{"Main Supply", NULL, "Audio Power"},
 	{"Main Supply", NULL, "Audio Analog Power"},
 
-	{"DAC", NULL, "ab8500_0p"},
-	{"DAC", NULL, "Main Supply"},
-	{"ADC", NULL, "ab8500_0c"},
-	{"ADC", NULL, "Main Supply"},
-
 	/* ANC Configure */
 	{"ANC Configure Input", NULL, "Main Supply"},
 	{"ANC Configure Output", NULL, "ANC Configure Input"},
 
-	/* AD/DA */
-	{"ADC", NULL, "ADC Input"},
-	{"DAC Output", NULL, "DAC"},
-
 	/* Powerup charge pump if DA1/2 is in use */
 
 	{"DA_IN1", NULL, "ab8500_0p"},
+	{"DA_IN1", NULL, "Main Supply"},
 	{"DA_IN1", NULL, "Charge Pump"},
 	{"DA_IN2", NULL, "ab8500_0p"},
+	{"DA_IN2", NULL, "Main Supply"},
 	{"DA_IN2", NULL, "Charge Pump"},
 
 	/* Headset path */
@@ -808,8 +785,10 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	/* HF or LineOut path */
 
 	{"DA_IN3", NULL, "ab8500_0p"},
+	{"DA_IN3", NULL, "Main Supply"},
 	{"DA3 Channel Volume", NULL, "DA_IN3"},
 	{"DA_IN4", NULL, "ab8500_0p"},
+	{"DA_IN4", NULL, "Main Supply"},
 	{"DA4 Channel Volume", NULL, "DA_IN4"},
 
 	{"Speaker Left Source", "Audio Path", "DA3 Channel Volume"},
@@ -867,8 +846,10 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	/* Vibrator path */
 
 	{"DA_IN5", NULL, "ab8500_0p"},
+	{"DA_IN5", NULL, "Main Supply"},
 	{"DA5 Channel Volume", NULL, "DA_IN5"},
 	{"DA_IN6", NULL, "ab8500_0p"},
+	{"DA_IN6", NULL, "Main Supply"},
 	{"DA6 Channel Volume", NULL, "DA_IN6"},
 
 	{"VIB1 DAC", NULL, "DA5 Channel Volume"},
@@ -910,13 +891,15 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	{"AD1 Channel Volume", NULL, "AD1 Source Select"},
 	{"AD2 Channel Volume", NULL, "AD2 Source Select"},
 
-	{"AD12 Enable", NULL, "AD1 Channel Volume"},
-	{"AD12 Enable", NULL, "AD2 Channel Volume"},
+	{"AD1 Channel Volume", NULL, "AD12 Enable"},
+	{"AD2 Channel Volume", NULL, "AD12 Enable"},
 
-	{"AD_OUT1", NULL, "ab8500_0c"},
-	{"AD_OUT1", NULL, "AD12 Enable"},
-	{"AD_OUT2", NULL, "ab8500_0c"},
-	{"AD_OUT2", NULL, "AD12 Enable"},
+	{"ab8500_0c", NULL, "AD_OUT1"},
+	{"AD_OUT1", NULL, "Main Supply"},
+	{"AD_OUT1", NULL, "AD1 Channel Volume"},
+	{"ab8500_0c", NULL, "AD_OUT2"},
+	{"AD_OUT2", NULL, "Main Supply"},
+	{"AD_OUT2", NULL, "AD2 Channel Volume"},
 
 	/* Mic 1 */
 
@@ -933,11 +916,11 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	{"AD3 Source Select", "Mic 1", "MIC1 ADC"},
 
 	{"AD3 Channel Volume", NULL, "AD3 Source Select"},
+	{"AD3 Channel Volume", NULL, "AD34 Enable"},
 
-	{"AD3 Enable", NULL, "AD3 Channel Volume"},
-
-	{"AD_OUT3", NULL, "ab8500_0c"},
-	{"AD_OUT3", NULL, "AD3 Enable"},
+	{"ab8500_0c", NULL, "AD_OUT3"},
+	{"AD_OUT3", NULL, "Main Supply"},
+	{"AD_OUT3", NULL, "AD3 Channel Volume"},
 
 	/* HD Capture path */
 
@@ -946,14 +929,15 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 
 	{"AD5 Channel Volume", NULL, "AD5 Source Select"},
 	{"AD6 Channel Volume", NULL, "AD6 Source Select"},
+	{"AD5 Channel Volume", NULL, "AD5768 Enable"},
+	{"AD6 Channel Volume", NULL, "AD5768 Enable"},
 
-	{"AD57 Enable", NULL, "AD5 Channel Volume"},
-	{"AD68 Enable", NULL, "AD6 Channel Volume"},
-
-	{"AD_OUT57", NULL, "ab8500_0c"},
-	{"AD_OUT57", NULL, "AD57 Enable"},
-	{"AD_OUT68", NULL, "ab8500_0c"},
-	{"AD_OUT68", NULL, "AD68 Enable"},
+	{"ab8500_0c", NULL, "AD_OUT57"},
+	{"AD_OUT57", NULL, "Main Supply"},
+	{"AD_OUT57", NULL, "AD5 Channel Volume"},
+	{"ab8500_0c", NULL, "AD_OUT68"},
+	{"AD_OUT68", NULL, "Main Supply"},
+	{"AD_OUT68", NULL, "AD6 Channel Volume"},
 
 	/* Digital Microphone path */
 
@@ -964,17 +948,25 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 	{"DMic 5", NULL, "V-DMIC"},
 	{"DMic 6", NULL, "V-DMIC"},
 
-	{"AD1 Source Select", NULL, "DMic 1"},
-	{"AD2 Source Select", NULL, "DMic 2"},
-	{"AD3 Source Select", NULL, "DMic 3"},
-	{"AD5 Source Select", NULL, "DMic 5"},
-	{"AD6 Source Select", NULL, "DMic 6"},
+	{"DMIC1", NULL, "DMic 1"},
+	{"DMIC2", NULL, "DMic 2"},
+	{"DMIC3", NULL, "DMic 3"},
+	{"DMIC4", NULL, "DMic 4"},
+	{"DMIC5", NULL, "DMic 5"},
+	{"DMIC6", NULL, "DMic 6"},
+
+	{"AD1 Source Select", "DMic 1", "DMIC1"},
+	{"AD2 Source Select", "DMic 2", "DMIC2"},
+	{"AD3 Source Select", "DMic 3", "DMIC3"},
+	{"AD5 Source Select", "DMic 5", "DMIC5"},
+	{"AD6 Source Select", "DMic 6", "DMIC6"},
 
-	{"AD4 Channel Volume", NULL, "DMic 4"},
-	{"AD4 Enable", NULL, "AD4 Channel Volume"},
+	{"AD4 Channel Volume", NULL, "DMIC4"},
+	{"AD4 Channel Volume", NULL, "AD34 Enable"},
 
-	{"AD_OUT4", NULL, "ab8500_0c"},
-	{"AD_OUT4", NULL, "AD4 Enable"},
+	{"ab8500_0c", NULL, "AD_OUT4"},
+	{"AD_OUT4", NULL, "Main Supply"},
+	{"AD_OUT4", NULL, "AD4 Channel Volume"},
 
 	/* LineIn Bypass path */
 
@@ -999,13 +991,13 @@ static const struct snd_soc_dapm_route ab8500_dapm_routes[] = {
 
 	/* Sidetone Filter path */
 
-	{"Sidetone Left Source", "LineIn Left", "AD12 Enable"},
-	{"Sidetone Left Source", "LineIn Right", "AD12 Enable"},
-	{"Sidetone Left Source", "Mic 1", "AD3 Enable"},
+	{"Sidetone Left Source", "LineIn Left", "AD1 Channel Volume"},
+	{"Sidetone Left Source", "LineIn Right", "AD2 Channel Volume"},
+	{"Sidetone Left Source", "Mic 1", "AD3 Channel Volume"},
 	{"Sidetone Left Source", "Headset Left", "DA_IN1"},
-	{"Sidetone Right Source", "LineIn Right", "AD12 Enable"},
-	{"Sidetone Right Source", "Mic 1", "AD3 Enable"},
-	{"Sidetone Right Source", "DMic 4", "AD4 Enable"},
+	{"Sidetone Right Source", "LineIn Right", "AD2 Channel Volume"},
+	{"Sidetone Right Source", "Mic 1", "AD3 Channel Volume"},
+	{"Sidetone Right Source", "DMic 4", "AD4 Channel Volume"},
 	{"Sidetone Right Source", "Headset Right", "DA_IN2"},
 
 	{"STFIR1 Control", NULL, "Sidetone Left Source"},
@@ -1926,18 +1918,18 @@ enum ab8500_filter {
 static int ab8500_audio_init_audioblock(struct snd_soc_component *component)
 {
 	int status;
+	u8 mask = AB8500_STW4500CTRL3_CLK32KOUT2DIS |
+		  AB8500_STW4500CTRL3_RESETAUDN;
 
 	dev_dbg(component->dev, "%s: Enter.\n", __func__);
 
-	/* Reset audio-registers and disable 32kHz-clock output 2 */
-	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3,
-				AB8500_STW4500CTRL3_CLK32KOUT2DIS |
-					AB8500_STW4500CTRL3_RESETAUDN,
-				AB8500_STW4500CTRL3_RESETAUDN);
+	/* Reset the audio registers and disable the unused 32 kHz output. */
+	status = ab8500_sysctrl_write(AB8500_STW4500CTRL3, mask,
+				      AB8500_STW4500CTRL3_CLK32KOUT2DIS);
 	if (status < 0)
 		return status;
 
-	return 0;
+	return ab8500_sysctrl_write(AB8500_STW4500CTRL3, mask, mask);
 }
 
 static int ab8500_audio_setup_mics(struct snd_soc_component *component,
@@ -2033,149 +2025,91 @@ static int ab8500_audio_set_ear_cmv(struct snd_soc_component *component,
 	return 0;
 }
 
-static int ab8500_audio_set_bit_delay(struct snd_soc_dai *dai,
-				unsigned int delay)
-{
-	unsigned int mask, val;
-	struct snd_soc_component *component = dai->component;
-
-	mask = BIT(AB8500_DIGIFCONF2_IF0DEL);
-	val = 0;
-
-	switch (delay) {
-	case 0:
-		break;
-	case 1:
-		val |= BIT(AB8500_DIGIFCONF2_IF0DEL);
-		break;
-	default:
-		dev_err(dai->component->dev,
-			"%s: ERROR: Unsupported bit-delay (0x%x)!\n",
-			__func__, delay);
-		return -EINVAL;
-	}
-
-	dev_dbg(dai->component->dev, "%s: IF0 Bit-delay: %d bits.\n",
-		__func__, delay);
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF2, mask, val);
-
-	return 0;
-}
-
-/* Gates clocking according format mask */
-static int ab8500_codec_set_dai_clock_gate(struct snd_soc_component *component,
-					unsigned int fmt)
-{
-	unsigned int mask;
-	unsigned int val;
-
-	mask = BIT(AB8500_DIGIFCONF1_ENMASTGEN) |
-			BIT(AB8500_DIGIFCONF1_ENFSBITCLK0);
-
-	val = BIT(AB8500_DIGIFCONF1_ENMASTGEN);
-
-	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
-	case SND_SOC_DAIFMT_CONT: /* continuous clock */
-		dev_dbg(component->dev, "%s: IF0 Clock is continuous.\n",
-			__func__);
-		val |= BIT(AB8500_DIGIFCONF1_ENFSBITCLK0);
-		break;
-	case SND_SOC_DAIFMT_GATED: /* clock is gated */
-		dev_dbg(component->dev, "%s: IF0 Clock is gated.\n",
-			__func__);
-		break;
-	default:
-		dev_err(component->dev,
-			"%s: ERROR: Unsupported clock mask (0x%x)!\n",
-			__func__, fmt & SND_SOC_DAIFMT_CLOCK_MASK);
-		return -EINVAL;
-	}
-
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF1, mask, val);
-
-	return 0;
-}
-
 static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 {
-	unsigned int mask;
-	unsigned int val;
 	struct snd_soc_component *component = dai->component;
-	int status;
+	unsigned int conf1_mask, conf1_val = 0;
+	unsigned int conf2_mask, conf2_val = 0;
+	unsigned int conf3_mask, conf3_val = 0;
+	bool provider = false;
+	int ret;
 
 	dev_dbg(component->dev, "%s: Enter (fmt = 0x%x)\n", __func__, fmt);
 
-	mask = BIT(AB8500_DIGIFCONF3_IF1DATOIF0AD) |
+	conf3_mask = BIT(AB8500_DIGIFCONF3_IF1DATOIF0AD) |
 			BIT(AB8500_DIGIFCONF3_IF1CLKTOIF0CLK) |
 			BIT(AB8500_DIGIFCONF3_IF0BFIFOEN) |
 			BIT(AB8500_DIGIFCONF3_IF0MASTER);
-	val = 0;
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM: /* codec clk & FRM master */
-		dev_dbg(dai->component->dev,
-			"%s: IF0 Master-mode: AB8500 master.\n", __func__);
-		val |= BIT(AB8500_DIGIFCONF3_IF0MASTER);
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		dev_dbg(component->dev,
+			"%s: IF0 Master-mode: AB8500 provider.\n", __func__);
+		conf3_val |= BIT(AB8500_DIGIFCONF3_IF0MASTER);
+		provider = true;
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS: /* codec clk & FRM slave */
-		dev_dbg(dai->component->dev,
-			"%s: IF0 Master-mode: AB8500 slave.\n", __func__);
+	case SND_SOC_DAIFMT_CBC_CFC:
+		dev_dbg(component->dev,
+			"%s: IF0 Master-mode: AB8500 consumer.\n", __func__);
 		break;
-	case SND_SOC_DAIFMT_CBS_CFM: /* codec clk slave & FRM master */
-	case SND_SOC_DAIFMT_CBM_CFS: /* codec clk master & frame slave */
-		dev_err(dai->component->dev,
-			"%s: ERROR: The device is either a master or a slave.\n",
+	case SND_SOC_DAIFMT_CBC_CFP:
+	case SND_SOC_DAIFMT_CBP_CFC:
+		dev_err(component->dev,
+			"%s: ERROR: The device is either a provider or a consumer.\n",
 			__func__);
 		fallthrough;
 	default:
-		dev_err(dai->component->dev,
-			"%s: ERROR: Unsupporter master mask 0x%x\n",
-			__func__, fmt & SND_SOC_DAIFMT_MASTER_MASK);
+		dev_err(component->dev,
+			"%s: ERROR: Unsupported clocking mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK);
 		return -EINVAL;
 	}
 
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF3, mask, val);
-
-	/* Set clock gating */
-	status = ab8500_codec_set_dai_clock_gate(component, fmt);
-	if (status) {
-		dev_err(dai->component->dev,
-			"%s: ERROR: Failed to set clock gate (%d).\n",
-			__func__, status);
-		return status;
+	conf1_mask = BIT(AB8500_DIGIFCONF1_ENMASTGEN) |
+		     BIT(AB8500_DIGIFCONF1_ENFSBITCLK0);
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
+	case SND_SOC_DAIFMT_CONT:
+		if (provider)
+			conf1_val = conf1_mask;
+		break;
+	case SND_SOC_DAIFMT_GATED:
+		if (provider)
+			conf1_val = BIT(AB8500_DIGIFCONF1_ENMASTGEN);
+		break;
+	default:
+		dev_err(component->dev, "%s: Unsupported clock mask 0x%x\n",
+			__func__, fmt & SND_SOC_DAIFMT_CLOCK_MASK);
+		return -EINVAL;
 	}
 
-	/* Setting data transfer format */
-
-	mask = BIT(AB8500_DIGIFCONF2_IF0FORMAT0) |
-		BIT(AB8500_DIGIFCONF2_IF0FORMAT1) |
-		BIT(AB8500_DIGIFCONF2_FSYNC0P) |
-		BIT(AB8500_DIGIFCONF2_BITCLK0P);
-	val = 0;
+	conf2_mask = BIT(AB8500_DIGIFCONF2_IF0FORMAT0) |
+		     BIT(AB8500_DIGIFCONF2_IF0FORMAT1) |
+		     BIT(AB8500_DIGIFCONF2_IF0DEL) |
+		     BIT(AB8500_DIGIFCONF2_FSYNC0P) |
+		     BIT(AB8500_DIGIFCONF2_BITCLK0P);
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S: /* I2S mode */
-		dev_dbg(dai->component->dev, "%s: IF0 Protocol: I2S\n", __func__);
-		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT1);
-		ab8500_audio_set_bit_delay(dai, 0);
+		dev_dbg(component->dev, "%s: IF0 Protocol: I2S\n", __func__);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT1) |
+			     BIT(AB8500_DIGIFCONF2_IF0DEL);
 		break;
 
 	case SND_SOC_DAIFMT_DSP_A: /* L data MSB after FRM LRC */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0 Protocol: DSP A (TDM)\n", __func__);
-		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0);
-		ab8500_audio_set_bit_delay(dai, 1);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0) |
+			     BIT(AB8500_DIGIFCONF2_IF0DEL);
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B: /* L data MSB during FRM LRC */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0 Protocol: DSP B (TDM)\n", __func__);
-		val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0);
-		ab8500_audio_set_bit_delay(dai, 0);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0FORMAT0);
 		break;
 
 	default:
-		dev_err(dai->component->dev,
+		dev_err(component->dev,
 			"%s: ERROR: Unsupported format (0x%x)!\n",
 			__func__, fmt & SND_SOC_DAIFMT_FORMAT_MASK);
 		return -EINVAL;
@@ -2183,39 +2117,50 @@ static int ab8500_codec_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF: /* normal bit clock + frame */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0: Normal bit clock, normal frame\n",
 			__func__);
 		break;
 	case SND_SOC_DAIFMT_NB_IF: /* normal BCLK + inv FRM */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0: Normal bit clock, inverted frame\n",
 			__func__);
-		val |= BIT(AB8500_DIGIFCONF2_FSYNC0P);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_FSYNC0P);
 		break;
 	case SND_SOC_DAIFMT_IB_NF: /* invert BCLK + nor FRM */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0: Inverted bit clock, normal frame\n",
 			__func__);
-		val |= BIT(AB8500_DIGIFCONF2_BITCLK0P);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_BITCLK0P);
 		break;
 	case SND_SOC_DAIFMT_IB_IF: /* invert BCLK + FRM */
-		dev_dbg(dai->component->dev,
+		dev_dbg(component->dev,
 			"%s: IF0: Inverted bit clock, inverted frame\n",
 			__func__);
-		val |= BIT(AB8500_DIGIFCONF2_FSYNC0P);
-		val |= BIT(AB8500_DIGIFCONF2_BITCLK0P);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_FSYNC0P) |
+			     BIT(AB8500_DIGIFCONF2_BITCLK0P);
 		break;
 	default:
-		dev_err(dai->component->dev,
+		dev_err(component->dev,
 			"%s: ERROR: Unsupported INV mask 0x%x\n",
 			__func__, fmt & SND_SOC_DAIFMT_INV_MASK);
 		return -EINVAL;
 	}
 
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF2, mask, val);
+	ret = snd_soc_component_update_bits(component, AB8500_DIGIFCONF3,
+					    conf3_mask, conf3_val);
+	if (ret < 0)
+		return ret;
 
-	return 0;
+	ret = snd_soc_component_update_bits(component, AB8500_DIGIFCONF1,
+					    conf1_mask, conf1_val);
+	if (ret < 0)
+		return ret;
+
+	ret = snd_soc_component_update_bits(component, AB8500_DIGIFCONF2,
+					    conf2_mask, conf2_val);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
@@ -2223,23 +2168,27 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
-	unsigned int val, mask, slot, slots_active;
+	unsigned int active_mask, clock_ratio, slot, value, ad_out, reg;
+	unsigned int tx_active, rx_active;
+	unsigned int conf1_val, conf2_val;
+	unsigned int mask;
+	int channel, ret;
 
 	mask = BIT(AB8500_DIGIFCONF2_IF0WL0) |
 		BIT(AB8500_DIGIFCONF2_IF0WL1);
-	val = 0;
+	conf2_val = 0;
 
 	switch (slot_width) {
 	case 16:
 		break;
 	case 20:
-		val |= BIT(AB8500_DIGIFCONF2_IF0WL0);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0WL0);
 		break;
 	case 24:
-		val |= BIT(AB8500_DIGIFCONF2_IF0WL1);
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0WL1);
 		break;
 	case 32:
-		val |= BIT(AB8500_DIGIFCONF2_IF0WL1) |
+		conf2_val |= BIT(AB8500_DIGIFCONF2_IF0WL1) |
 			BIT(AB8500_DIGIFCONF2_IF0WL0);
 		break;
 	default:
@@ -2248,27 +2197,11 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	dev_dbg(dai->component->dev, "%s: IF0 slot-width: %d bits.\n",
-		__func__, slot_width);
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF2, mask, val);
-
-	/* Setup TDM clocking according to slot count */
-	dev_dbg(dai->component->dev, "%s: Slots, total: %d\n", __func__, slots);
-	mask = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
-			BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
 	switch (slots) {
 	case 2:
-		val = AB8500_MASK_NONE;
-		break;
 	case 4:
-		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0);
-		break;
 	case 8:
-		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
-		break;
 	case 16:
-		val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
-			BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
 		break;
 	default:
 		dev_err(dai->component->dev,
@@ -2276,92 +2209,134 @@ static int ab8500_codec_set_dai_tdm_slot(struct snd_soc_dai *dai,
 			__func__, slots);
 		return -EINVAL;
 	}
-	snd_soc_component_update_bits(component, AB8500_DIGIFCONF1, mask, val);
-
-	/* Setup TDM DA according to active tx slots */
-
-	if (tx_mask & ~0xff)
-		return -EINVAL;
-
-	mask = AB8500_DASLOTCONFX_SLTODAX_MASK;
-	tx_mask = tx_mask << AB8500_DA_DATA0_OFFSET;
-	slots_active = hweight32(tx_mask);
-
-	dev_dbg(dai->component->dev, "%s: Slots, active, TX: %d\n", __func__,
-		slots_active);
 
-	switch (slots_active) {
-	case 0:
+	clock_ratio = slots * slot_width;
+	switch (clock_ratio) {
+	case 32:
+		conf1_val = 0;
 		break;
-	case 1:
-		slot = ffs(tx_mask);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF1, mask, slot);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF3, mask, slot);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF2, mask, slot);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF4, mask, slot);
+	case 64:
+		conf1_val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0);
 		break;
-	case 2:
-		slot = ffs(tx_mask);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF1, mask, slot);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF3, mask, slot);
-		slot = fls(tx_mask);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF2, mask, slot);
-		snd_soc_component_update_bits(component, AB8500_DASLOTCONF4, mask, slot);
+	case 128:
+		conf1_val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
 		break;
-	case 8:
-		dev_dbg(dai->component->dev,
-			"%s: In 8-channel mode DA-from-slot mapping is set manually.",
-			__func__);
+	case 256:
+		conf1_val = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
+			    BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
 		break;
 	default:
-		dev_err(dai->component->dev,
-			"%s: Unsupported number of active TX-slots (%d)!\n",
-			__func__, slots_active);
+		dev_err(component->dev, "%s: Unsupported BCLK ratio (%u)!\n",
+			__func__, clock_ratio);
 		return -EINVAL;
 	}
 
-	/* Setup TDM AD according to active RX-slots */
+	active_mask = GENMASK(min(slots, 8) - 1, 0);
+	if ((tx_mask | rx_mask) & ~active_mask) {
+		dev_err(component->dev, "%s: Slot mask exceeds slot count\n",
+			__func__);
+		return -EINVAL;
+	}
 
-	if (rx_mask & ~0xff)
+	tx_active = hweight32(tx_mask);
+	rx_active = hweight32(rx_mask);
+	if (tx_active != 0 && tx_active != 1 && tx_active != 2 &&
+	    tx_active != 8) {
+		dev_err(component->dev, "%s: Unsupported active TX slots (%u)!\n",
+			__func__, tx_active);
 		return -EINVAL;
+	}
+	if (rx_active != 0 && rx_active != 1 && rx_active != 2 &&
+	    rx_active != 8) {
+		dev_err(component->dev, "%s: Unsupported active RX slots (%u)!\n",
+			__func__, rx_active);
+		return -EINVAL;
+	}
 
-	rx_mask = rx_mask << AB8500_AD_DATA0_OFFSET;
-	slots_active = hweight32(rx_mask);
+	dev_dbg(component->dev,
+		"%s: %d slots of %d bits, TX active: %u, RX active: %u\n",
+		__func__, slots, slot_width, tx_active, rx_active);
 
-	dev_dbg(dai->component->dev, "%s: Slots, active, RX: %d\n", __func__,
-		slots_active);
+	ret = snd_soc_component_update_bits(component, AB8500_DIGIFCONF2,
+					    mask, conf2_val);
+	if (ret < 0)
+		return ret;
 
-	switch (slots_active) {
-	case 0:
-		break;
-	case 1:
-		slot = ffs(rx_mask);
-		snd_soc_component_update_bits(component, AB8500_ADSLOTSEL(slot),
-				AB8500_MASK_SLOT(slot),
-				AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT3, slot));
-		break;
-	case 2:
-		slot = ffs(rx_mask);
-		snd_soc_component_update_bits(component,
-				AB8500_ADSLOTSEL(slot),
-				AB8500_MASK_SLOT(slot),
-				AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT3, slot));
-		slot = fls(rx_mask);
-		snd_soc_component_update_bits(component,
-				AB8500_ADSLOTSEL(slot),
-				AB8500_MASK_SLOT(slot),
-				AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT2, slot));
-		break;
-	case 8:
-		dev_dbg(dai->component->dev,
-			"%s: In 8-channel mode AD-to-slot mapping is set manually.",
-			__func__);
-		break;
-	default:
-		dev_err(dai->component->dev,
-			"%s: Unsupported number of active RX-slots (%d)!\n",
-			__func__, slots_active);
-		return -EINVAL;
+	mask = BIT(AB8500_DIGIFCONF1_IF0BITCLKOS0) |
+	       BIT(AB8500_DIGIFCONF1_IF0BITCLKOS1);
+	ret = snd_soc_component_update_bits(component, AB8500_DIGIFCONF1,
+					    mask, conf1_val);
+	if (ret < 0)
+		return ret;
+
+	mask = AB8500_DASLOTCONFX_SLTODAX_MASK;
+	if (tx_active == 1 || tx_active == 2) {
+		slot = __ffs(tx_mask) + AB8500_DA_DATA0_OFFSET;
+		reg = AB8500_DASLOTCONF1;
+		ret = snd_soc_component_update_bits(component, reg, mask, slot);
+		if (ret < 0)
+			return ret;
+		reg = AB8500_DASLOTCONF3;
+		ret = snd_soc_component_update_bits(component, reg, mask, slot);
+		if (ret < 0)
+			return ret;
+
+		if (tx_active == 2)
+			slot = __fls(tx_mask) + AB8500_DA_DATA0_OFFSET;
+		reg = AB8500_DASLOTCONF2;
+		ret = snd_soc_component_update_bits(component, reg, mask, slot);
+		if (ret < 0)
+			return ret;
+		reg = AB8500_DASLOTCONF4;
+		ret = snd_soc_component_update_bits(component, reg, mask, slot);
+		if (ret < 0)
+			return ret;
+	} else if (tx_active == 8) {
+		channel = 0;
+		for (slot = 0; slot < 8; slot++) {
+			if (!(tx_mask & BIT(slot)))
+				continue;
+			reg = AB8500_DASLOTCONF1 + channel++;
+			value = slot + AB8500_DA_DATA0_OFFSET;
+			ret = snd_soc_component_update_bits(component, reg, mask, value);
+			if (ret < 0)
+				return ret;
+		}
+	}
+
+	if (rx_active == 1 || rx_active == 2) {
+		slot = __ffs(rx_mask) + AB8500_AD_DATA0_OFFSET;
+		value = AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT3,
+							 slot);
+		reg = AB8500_ADSLOTSEL(slot);
+		mask = AB8500_MASK_SLOT(slot);
+		ret = snd_soc_component_update_bits(component, reg, mask, value);
+		if (ret < 0)
+			return ret;
+
+		if (rx_active == 2) {
+			slot = __fls(rx_mask) + AB8500_AD_DATA0_OFFSET;
+			value = AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(AB8500_AD_OUT2,
+								 slot);
+			reg = AB8500_ADSLOTSEL(slot);
+			mask = AB8500_MASK_SLOT(slot);
+			ret = snd_soc_component_update_bits(component, reg, mask, value);
+			if (ret < 0)
+				return ret;
+		}
+	} else if (rx_active == 8) {
+		channel = 0;
+		for (slot = 0; slot < 8; slot++) {
+			if (!(rx_mask & BIT(slot)))
+				continue;
+			ad_out = AB8500_AD_OUT1 + channel++;
+			value = AB8500_ADSLOTSELX_AD_OUT_TO_SLOT(ad_out, slot);
+			reg = AB8500_ADSLOTSEL(slot);
+			mask = AB8500_MASK_SLOT(slot);
+			ret = snd_soc_component_update_bits(component, reg, mask, value);
+			if (ret < 0)
+				return ret;
+		}
 	}
 
 	return 0;
@@ -2470,6 +2445,13 @@ static int ab8500_codec_probe(struct snd_soc_component *component)
 
 	ab8500_codec_of_probe(dev, np, &codec_pdata);
 
+	status = ab8500_audio_init_audioblock(component);
+	if (status < 0) {
+		dev_err(dev, "%s: failed to init audio-block (%d)!\n",
+			__func__, status);
+		return status;
+	}
+
 	status = ab8500_audio_setup_mics(component, &codec_pdata.amics);
 	if (status < 0) {
 		pr_err("%s: Failed to setup mics (%d)!\n", __func__, status);
@@ -2482,13 +2464,6 @@ static int ab8500_codec_probe(struct snd_soc_component *component)
 		return status;
 	}
 
-	status = ab8500_audio_init_audioblock(component);
-	if (status < 0) {
-		dev_err(dev, "%s: failed to init audio-block (%d)!\n",
-			__func__, status);
-		return status;
-	}
-
 	/* Override HW-defaults */
 	snd_soc_component_write(component, AB8500_ANACONF5,
 		      BIT(AB8500_ANACONF5_HSAUTOEN));
diff --git a/sound/soc/codecs/cx20442.c b/sound/soc/codecs/cx20442.c
index 161be8b7d131..3a23d4a0ee0c 100644
--- a/sound/soc/codecs/cx20442.c
+++ b/sound/soc/codecs/cx20442.c
@@ -252,10 +252,9 @@ static void v253_close(struct tty_struct *tty)
 }
 
 /* Line discipline .hangup() */
-static int v253_hangup(struct tty_struct *tty)
+static void v253_hangup(struct tty_struct *tty)
 {
 	v253_close(tty);
-	return 0;
 }
 
 /* Line discipline .receive_buf() */
diff --git a/sound/soc/codecs/mt6351.c b/sound/soc/codecs/mt6351.c
index 5c0536eb1044..cb6c5bd7a233 100644
--- a/sound/soc/codecs/mt6351.c
+++ b/sound/soc/codecs/mt6351.c
@@ -1481,6 +1481,7 @@ static const struct of_device_id mt6351_of_match[] = {
 	{.compatible = "mediatek,mt6351-sound",},
 	{}
 };
+MODULE_DEVICE_TABLE(of, mt6351_of_match);
 
 static struct platform_driver mt6351_codec_driver = {
 	.driver = {
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 821e7395f90f..1056a38992cf 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -813,15 +813,6 @@ int pcm3168a_probe(struct device *dev, struct regmap *regmap)
 }
 EXPORT_SYMBOL_GPL(pcm3168a_probe);
 
-static void pcm3168a_disable(struct device *dev)
-{
-	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
-
-	regulator_bulk_disable(ARRAY_SIZE(pcm3168a->supplies),
-			       pcm3168a->supplies);
-	clk_disable_unprepare(pcm3168a->scki);
-}
-
 void pcm3168a_remove(struct device *dev)
 {
 	struct pcm3168a_priv *pcm3168a = dev_get_drvdata(dev);
@@ -833,10 +824,12 @@ void pcm3168a_remove(struct device *dev)
 	 * The asserted level of GPIO_ACTIVE_LOW is LOW.
 	 */
 	gpiod_set_value_cansleep(pcm3168a->gpio_rst, 1);
+
 	pm_runtime_disable(dev);
-#ifndef CONFIG_PM
-	pcm3168a_disable(dev);
-#endif
+	if (!pm_runtime_status_suspended(dev)) {
+		regulator_bulk_disable(ARRAY_SIZE(pcm3168a->supplies), pcm3168a->supplies);
+		clk_disable_unprepare(pcm3168a->scki);
+	}
 }
 EXPORT_SYMBOL_GPL(pcm3168a_remove);
 
@@ -892,7 +885,8 @@ static int pcm3168a_rt_suspend(struct device *dev)
 
 	regcache_cache_only(pcm3168a->regmap, true);
 
-	pcm3168a_disable(dev);
+	regulator_bulk_disable(ARRAY_SIZE(pcm3168a->supplies), pcm3168a->supplies);
+	clk_disable_unprepare(pcm3168a->scki);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/rk3328_codec.c b/sound/soc/codecs/rk3328_codec.c
index e40b97929f6c..f9756a72e2d6 100644
--- a/sound/soc/codecs/rk3328_codec.c
+++ b/sound/soc/codecs/rk3328_codec.c
@@ -426,7 +426,6 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	struct rk3328_codec_priv *rk3328;
 	struct regmap *grf;
 	void __iomem *base;
-	int ret = 0;
 
 	rk3328 = devm_kzalloc(&pdev->dev, sizeof(*rk3328), GFP_KERNEL);
 	if (!rk3328)
@@ -442,14 +441,13 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 	regmap_write(grf, RK3328_GRF_SOC_CON2,
 		     (BIT(14) << 16 | BIT(14)));
 
-	ret = of_property_read_u32(rk3328_np, "spk-depop-time-ms",
-				   &rk3328->spk_depop_time);
-	if (ret < 0) {
+	if (of_property_read_u32(rk3328_np, "spk-depop-time-ms",
+				 &rk3328->spk_depop_time)) {
 		dev_info(&pdev->dev, "spk_depop_time use default value.\n");
 		rk3328->spk_depop_time = 200;
 	}
 
-	rk3328->mute = gpiod_get_optional(&pdev->dev, "mute", GPIOD_OUT_HIGH);
+	rk3328->mute = devm_gpiod_get_optional(&pdev->dev, "mute", GPIOD_OUT_HIGH);
 	if (IS_ERR(rk3328->mute))
 		return PTR_ERR(rk3328->mute);
 	/*
@@ -462,57 +460,31 @@ static int rk3328_platform_probe(struct platform_device *pdev)
 		regmap_write(grf, RK3328_GRF_SOC_CON10, BIT(17) | BIT(1));
 	}
 
-	rk3328->mclk = devm_clk_get(&pdev->dev, "mclk");
+	rk3328->mclk = devm_clk_get_enabled(&pdev->dev, "mclk");
 	if (IS_ERR(rk3328->mclk))
 		return PTR_ERR(rk3328->mclk);
 
-	ret = clk_prepare_enable(rk3328->mclk);
-	if (ret)
-		return ret;
 	clk_set_rate(rk3328->mclk, INITIAL_FREQ);
 
-	rk3328->pclk = devm_clk_get(&pdev->dev, "pclk");
-	if (IS_ERR(rk3328->pclk)) {
-		dev_err(&pdev->dev, "can't get acodec pclk\n");
-		ret = PTR_ERR(rk3328->pclk);
-		goto err_unprepare_mclk;
-	}
-
-	ret = clk_prepare_enable(rk3328->pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable acodec pclk\n");
-		goto err_unprepare_mclk;
-	}
+	rk3328->pclk = devm_clk_get_enabled(&pdev->dev, "pclk");
+	if (IS_ERR(rk3328->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(rk3328->pclk),
+				     "failed to get or enable acodec pclk\n");
 
 	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		ret = PTR_ERR(base);
-		goto err_unprepare_pclk;
-	}
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	rk3328->regmap = devm_regmap_init_mmio(&pdev->dev, base,
 					       &rk3328_codec_regmap_config);
-	if (IS_ERR(rk3328->regmap)) {
-		ret = PTR_ERR(rk3328->regmap);
-		goto err_unprepare_pclk;
-	}
+	if (IS_ERR(rk3328->regmap))
+		return PTR_ERR(rk3328->regmap);
 
 	platform_set_drvdata(pdev, rk3328);
 
-	ret = devm_snd_soc_register_component(&pdev->dev, &soc_codec_rk3328,
+	return devm_snd_soc_register_component(&pdev->dev, &soc_codec_rk3328,
 					       rk3328_dai,
 					       ARRAY_SIZE(rk3328_dai));
-	if (ret)
-		goto err_unprepare_pclk;
-
-	return 0;
-
-err_unprepare_pclk:
-	clk_disable_unprepare(rk3328->pclk);
-
-err_unprepare_mclk:
-	clk_disable_unprepare(rk3328->mclk);
-	return ret;
 }
 
 static const struct of_device_id rk3328_codec_of_match[] = {
diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index ac403827a229..c7cacde51641 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3441,6 +3441,10 @@ static int rt5645_probe(struct snd_soc_component *component)
 	if (!rt5645->eq_param)
 		return -ENOMEM;
 
+	/* no machine driver to call rt5645_set_jack_detect(), so detect here */
+	if (!rt5645->pdata.jd_mode && rt5645->gpiod_hp_det)
+		rt5645_irq(0, rt5645);
+
 	return 0;
 }
 
diff --git a/sound/soc/intel/atom/sst/sst_pci.c b/sound/soc/intel/atom/sst/sst_pci.c
index f7ad991bf04d..900e3d42e3d5 100644
--- a/sound/soc/intel/atom/sst/sst_pci.c
+++ b/sound/soc/intel/atom/sst/sst_pci.c
@@ -179,6 +179,7 @@ static const struct pci_device_id intel_sst_ids[] = {
 	{ PCI_VDEVICE(INTEL, SST_MRFLD_PCI_ID), 0},
 	{ 0, }
 };
+MODULE_DEVICE_TABLE(pci, intel_sst_ids);
 
 static struct pci_driver sst_driver = {
 	.name = SST_DRV_NAME,
diff --git a/sound/soc/intel/catpt/ipc.c b/sound/soc/intel/catpt/ipc.c
index 5b718a846fda..3341a3a190e6 100644
--- a/sound/soc/intel/catpt/ipc.c
+++ b/sound/soc/intel/catpt/ipc.c
@@ -205,6 +205,7 @@ static void catpt_dsp_process_response(struct catpt_dev *cdev, u32 header)
 		memcpy_fromio(&config, cdev->lpe_ba + off, sizeof(config));
 		trace_catpt_ipc_payload((u8 *)&config, sizeof(config));
 
+		dev_dbg(cdev->dev, "FW READY 0x%08x\n", header);
 		catpt_ipc_arm(ipc, &config);
 		complete(&cdev->fw_ready);
 		return;
@@ -215,6 +216,13 @@ static void catpt_dsp_process_response(struct catpt_dev *cdev, u32 header)
 		dev_err(cdev->dev, "ADSP device coredump received\n");
 		ipc->ready = false;
 		catpt_coredump(cdev);
+
+		if (catpt_readl_dram(cdev, COREDUMP) == CATPT_COREDUMP_REQUEST) {
+			dev_dbg(cdev->dev, "releasing firmware from the coredump state\n");
+			catpt_writel_dram(cdev, COREDUMP, CATPT_COREDUMP_RELEASE);
+		}
+
+		complete(&cdev->fw_ready);
 		/* TODO: attempt recovery */
 		break;
 
diff --git a/sound/soc/intel/catpt/loader.c b/sound/soc/intel/catpt/loader.c
index 8a5f20abcadb..8b91e3327cee 100644
--- a/sound/soc/intel/catpt/loader.c
+++ b/sound/soc/intel/catpt/loader.c
@@ -626,6 +626,9 @@ int catpt_boot_firmware(struct catpt_dev *cdev, bool restore)
 	if (!ret) {
 		dev_err(cdev->dev, "firmware ready timeout\n");
 		return -ETIMEDOUT;
+	/* Wake up does not mean FW is ready, an exception could occur. */
+	} else if (!cdev->ipc.ready) {
+		return -EREMOTEIO;
 	}
 
 	/* update sram pg & clock once done booting */
diff --git a/sound/soc/intel/catpt/registers.h b/sound/soc/intel/catpt/registers.h
index 47280d82842e..a6da59dff76e 100644
--- a/sound/soc/intel/catpt/registers.h
+++ b/sound/soc/intel/catpt/registers.h
@@ -124,6 +124,11 @@
 #define CATPT_SSCR2_DEFAULT		0x0
 #define CATPT_SSPSP2_DEFAULT		0x0
 
+/* Coredump register and its states */
+#define CATPT_DRAM_COREDUMP		0x1F4
+#define CATPT_COREDUMP_REQUEST		UINT_MAX
+#define CATPT_COREDUMP_RELEASE		0
+
 /* Physically the same block, access address differs between host and dsp */
 #define CATPT_DSP_DRAM_OFFSET		0x400000
 #define catpt_to_host_offset(offset)	((offset) & ~(CATPT_DSP_DRAM_OFFSET))
@@ -137,6 +142,8 @@
 
 /* registry I/O helpers */
 
+#define catpt_dram_addr(cdev) \
+	((cdev)->lpe_ba + (cdev)->spec->host_dram_offset)
 #define catpt_shim_addr(cdev) \
 	((cdev)->lpe_ba + (cdev)->spec->host_shim_offset)
 #define catpt_dma_addr(cdev, dma) \
@@ -151,6 +158,11 @@
 #define catpt_writel_ssp(cdev, ssp, reg, val) \
 	writel(val, catpt_ssp_addr(cdev, ssp) + (reg))
 
+#define catpt_readl_dram(cdev, reg) \
+	readl(catpt_dram_addr(cdev) + CATPT_DRAM_##reg)
+#define catpt_writel_dram(cdev, reg, val) \
+	writel(val, catpt_dram_addr(cdev) + CATPT_DRAM_##reg)
+
 #define catpt_readl_shim(cdev, reg) \
 	readl(catpt_shim_addr(cdev) + CATPT_SHIM_##reg)
 #define catpt_writel_shim(cdev, reg, val) \
diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 94cfbc90390b..736d21147974 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -260,6 +260,7 @@ static int rockchip_pdm_set_fmt(struct snd_soc_dai *cpu_dai,
 {
 	struct rk_pdm_dev *pdm = to_info(cpu_dai);
 	unsigned int mask = 0, val = 0;
+	int ret;
 
 	mask = PDM_CKP_MSK;
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -273,7 +274,10 @@ static int rockchip_pdm_set_fmt(struct snd_soc_dai *cpu_dai,
 		return -EINVAL;
 	}
 
-	pm_runtime_get_sync(cpu_dai->dev);
+	ret = pm_runtime_resume_and_get(cpu_dai->dev);
+	if (ret)
+		return ret;
+
 	regmap_update_bits(pdm->regmap, PDM_CLK_CTRL, mask, val);
 	pm_runtime_put(cpu_dai->dev);
 
@@ -360,16 +364,16 @@ static int rockchip_pdm_runtime_resume(struct device *dev)
 	struct rk_pdm_dev *pdm = dev_get_drvdata(dev);
 	int ret;
 
-	ret = clk_prepare_enable(pdm->clk);
+	ret = clk_prepare_enable(pdm->hclk);
 	if (ret) {
-		dev_err(pdm->dev, "clock enable failed %d\n", ret);
+		dev_err(pdm->dev, "hclock enable failed %d\n", ret);
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pdm->hclk);
+	ret = clk_prepare_enable(pdm->clk);
 	if (ret) {
-		clk_disable_unprepare(pdm->clk);
-		dev_err(pdm->dev, "hclock enable failed %d\n", ret);
+		clk_disable_unprepare(pdm->hclk);
+		dev_err(pdm->dev, "clock enable failed %d\n", ret);
 		return ret;
 	}
 
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index ccddcd9926af..310e5ec7e674 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -96,6 +96,7 @@ static int __maybe_unused rk_spdif_runtime_resume(struct device *dev)
 
 	ret = regcache_sync(spdif->regmap);
 	if (ret) {
+		regcache_cache_only(spdif->regmap, true);
 		clk_disable_unprepare(spdif->mclk);
 		clk_disable_unprepare(spdif->hclk);
 	}
diff --git a/sound/soc/sprd/sprd-pcm-compress.c b/sound/soc/sprd/sprd-pcm-compress.c
index 6507c03cc80e..8027880704fa 100644
--- a/sound/soc/sprd/sprd-pcm-compress.c
+++ b/sound/soc/sprd/sprd-pcm-compress.c
@@ -17,7 +17,7 @@
 
 /* Default values if userspace does not set */
 #define SPRD_COMPR_MIN_FRAGMENT_SIZE	SZ_8K
-#define SPRD_COMPR_MAX_FRAGMENT_SIZE	SZ_128K
+#define SPRD_COMPR_MAX_FRAGMENT_SIZE	SZ_32K
 #define SPRD_COMPR_MIN_NUM_FRAGMENTS	4
 #define SPRD_COMPR_MAX_NUM_FRAGMENTS	64
 
@@ -271,6 +271,19 @@ static int sprd_platform_compr_set_params(struct snd_soc_component *component,
 	struct sprd_compr_params compr_params = { };
 	int ret;
 
+	/*
+	 * The stage 0 IRAM buffer and the stage 1 DDR buffer are allocated
+	 * with fixed sizes at open time, so the requested fragment size and
+	 * fragments must fit into them, otherwise sprd_platform_compr_copy()
+	 * would overflow the buffers. Note the compress core only checks the
+	 * fragment size and fragments against an u32 overflow, not against
+	 * the buffer sizes advertised by get_caps.
+	 */
+	if (params->buffer.fragment_size > SPRD_COMPR_IRAM_BUF_SIZE ||
+	    (u64)params->buffer.fragment_size * params->buffer.fragments >
+	    SPRD_COMPR_AREA_BUF_SIZE)
+		return -EINVAL;
+
 	/*
 	 * Configure the DMA engine 2-stage transfer mode. Channel 1 set as the
 	 * destination channel, and channel 0 set as the source channel, that
diff --git a/sound/soc/sti/uniperif_reader.c b/sound/soc/sti/uniperif_reader.c
index 065c5f0d1f5f..729b57c68ec2 100644
--- a/sound/soc/sti/uniperif_reader.c
+++ b/sound/soc/sti/uniperif_reader.c
@@ -421,6 +421,8 @@ int uni_reader_init(struct platform_device *pdev,
 	else
 		reader->hw = &uni_reader_pcm_hw;
 
+	spin_lock_init(&reader->irq_lock);
+
 	ret = devm_request_irq(&pdev->dev, reader->irq,
 			       uni_reader_irq_handler, IRQF_SHARED,
 			       dev_name(&pdev->dev), reader);
@@ -429,8 +431,6 @@ int uni_reader_init(struct platform_device *pdev,
 		return -EBUSY;
 	}
 
-	spin_lock_init(&reader->irq_lock);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(uni_reader_init);
diff --git a/sound/soc/ti/ams-delta.c b/sound/soc/ti/ams-delta.c
index fbd75732a68b..b83e36db6367 100644
--- a/sound/soc/ti/ams-delta.c
+++ b/sound/soc/ti/ams-delta.c
@@ -332,10 +332,9 @@ static void cx81801_close(struct tty_struct *tty)
 }
 
 /* Line discipline .hangup() */
-static int cx81801_hangup(struct tty_struct *tty)
+static void cx81801_hangup(struct tty_struct *tty)
 {
 	cx81801_close(tty);
-	return 0;
 }
 
 /* Line discipline .receive_buf() */
diff --git a/sound/soc/ti/omap3pandora.c b/sound/soc/ti/omap3pandora.c
index a287e9747c2a..3cec2eaafe62 100644
--- a/sound/soc/ti/omap3pandora.c
+++ b/sound/soc/ti/omap3pandora.c
@@ -11,12 +11,12 @@
 #include <linux/delay.h>
 #include <linux/regulator/consumer.h>
 #include <linux/module.h>
+#include <linux/of.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
 #include <sound/soc.h>
 
-#include <asm/mach-types.h>
 #include <linux/platform_data/asoc-ti-mcbsp.h>
 
 #include "omap-mcbsp.h"
@@ -224,7 +224,8 @@ static int __init omap3pandora_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap3_pandora())
+	if (!of_machine_is_compatible("openpandora,omap3-pandora-600mhz") &&
+		!of_machine_is_compatible("openpandora,omap3-pandora-1ghz"))
 		return -ENODEV;
 
 	pr_info("OMAP3 Pandora SoC init\n");
diff --git a/sound/soc/ux500/mop500.c b/sound/soc/ux500/mop500.c
index cdae1190b930..cb35e8d022ba 100644
--- a/sound/soc/ux500/mop500.c
+++ b/sound/soc/ux500/mop500.c
@@ -111,11 +111,9 @@ static int mop500_probe(struct platform_device *pdev)
 
 	mop500_card.dev = &pdev->dev;
 
-	if (np) {
-		ret = mop500_of_probe(pdev, np);
-		if (ret)
-			return ret;
-	}
+	ret = mop500_of_probe(pdev, np);
+	if (ret)
+		return ret;
 
 	dev_dbg(&pdev->dev, "%s: Card %s: Set platform drvdata.\n",
 		__func__, mop500_card.name);
diff --git a/sound/soc/ux500/ux500_msp_dai.c b/sound/soc/ux500/ux500_msp_dai.c
index 21052378a32e..97f514d89fda 100644
--- a/sound/soc/ux500/ux500_msp_dai.c
+++ b/sound/soc/ux500/ux500_msp_dai.c
@@ -17,7 +17,6 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
@@ -37,8 +36,10 @@ static int setup_pcm_multichan(struct snd_soc_dai *dai,
 	if (drvdata->slots > 1) {
 		msp_config->multichannel_configured = 1;
 
-		multi->tx_multichannel_enable = true;
-		multi->rx_multichannel_enable = true;
+		multi->tx_multichannel_enable =
+			msp_config->direction & MSP_DIR_TX;
+		multi->rx_multichannel_enable =
+			msp_config->direction & MSP_DIR_RX;
 		multi->rx_comparison_enable_mode = MSP_COMPARISON_DISABLED;
 
 		multi->tx_channel_0_enable = drvdata->tx_mask;
@@ -60,72 +61,21 @@ static int setup_pcm_multichan(struct snd_soc_dai *dai,
 	return 0;
 }
 
-static int setup_frameper(struct snd_soc_dai *dai, unsigned int rate,
-			struct msp_protdesc *prot_desc)
+static void setup_frameper(struct snd_soc_dai *dai,
+			   struct msp_protdesc *prot_desc)
 {
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
 
-	switch (drvdata->slots) {
-	case 1:
-		switch (rate) {
-		case 8000:
-			prot_desc->frame_period =
-				FRAME_PER_SINGLE_SLOT_8_KHZ;
-			break;
-
-		case 16000:
-			prot_desc->frame_period =
-				FRAME_PER_SINGLE_SLOT_16_KHZ;
-			break;
-
-		case 44100:
-			prot_desc->frame_period =
-				FRAME_PER_SINGLE_SLOT_44_1_KHZ;
-			break;
-
-		case 48000:
-			prot_desc->frame_period =
-				FRAME_PER_SINGLE_SLOT_48_KHZ;
-			break;
-
-		default:
-			dev_err(dai->dev,
-				"%s: Error: Unsupported sample-rate (freq = %d)!\n",
-				__func__, rate);
-			return -EINVAL;
-		}
-		break;
-
-	case 2:
-		prot_desc->frame_period = FRAME_PER_2_SLOTS;
-		break;
-
-	case 8:
-		prot_desc->frame_period = FRAME_PER_8_SLOTS;
-		break;
-
-	case 16:
-		prot_desc->frame_period = FRAME_PER_16_SLOTS;
-		break;
-	default:
-		dev_err(dai->dev,
-			"%s: Error: Unsupported slot-count (slots = %d)!\n",
-			__func__, drvdata->slots);
-		return -EINVAL;
-	}
-
-	prot_desc->clocks_per_frame =
-			prot_desc->frame_period+1;
+	prot_desc->clocks_per_frame = drvdata->slots * drvdata->slot_width;
+	prot_desc->frame_period = prot_desc->clocks_per_frame - 1;
 
 	dev_dbg(dai->dev, "%s: Clocks per frame: %u\n",
 		__func__,
 		prot_desc->clocks_per_frame);
-
-	return 0;
 }
 
-static int setup_pcm_framing(struct snd_soc_dai *dai, unsigned int rate,
-			struct msp_protdesc *prot_desc)
+static int setup_pcm_framing(struct snd_soc_dai *dai,
+			     struct msp_protdesc *prot_desc)
 {
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
 
@@ -166,7 +116,9 @@ static int setup_pcm_framing(struct snd_soc_dai *dai, unsigned int rate,
 	prot_desc->tx_elem_len_2 = MSP_ELEM_LEN_16;
 	prot_desc->rx_elem_len_2 = MSP_ELEM_LEN_16;
 
-	return setup_frameper(dai, rate, prot_desc);
+	setup_frameper(dai, prot_desc);
+
+	return 0;
 }
 
 static int setup_clocking(struct snd_soc_dai *dai,
@@ -180,7 +132,16 @@ static int setup_clocking(struct snd_soc_dai *dai,
 	case SND_SOC_DAIFMT_NB_IF:
 		msp_config->tx_fsync_pol ^= 1 << TFSPOL_SHIFT;
 		msp_config->rx_fsync_pol ^= 1 << RFSPOL_SHIFT;
+		break;
 
+	case SND_SOC_DAIFMT_IB_NF:
+		msp_config->bclk_inverted = true;
+		break;
+
+	case SND_SOC_DAIFMT_IB_IF:
+		msp_config->bclk_inverted = true;
+		msp_config->tx_fsync_pol ^= 1 << TFSPOL_SHIFT;
+		msp_config->rx_fsync_pol ^= 1 << RFSPOL_SHIFT;
 		break;
 
 	default:
@@ -195,6 +156,7 @@ static int setup_clocking(struct snd_soc_dai *dai,
 	case SND_SOC_DAIFMT_CBM_CFM:
 		dev_dbg(dai->dev, "%s: Codec is master.\n", __func__);
 
+		msp_config->clock_provider = false;
 		msp_config->iodelay = 0x20;
 		msp_config->rx_fsync_sel = 0;
 		msp_config->tx_fsync_sel = 1 << TFSSEL_SHIFT;
@@ -207,6 +169,7 @@ static int setup_clocking(struct snd_soc_dai *dai,
 	case SND_SOC_DAIFMT_CBS_CFS:
 		dev_dbg(dai->dev, "%s: Codec is slave.\n", __func__);
 
+		msp_config->clock_provider = true;
 		msp_config->tx_clk_sel = TX_CLK_SEL_SRG;
 		msp_config->tx_fsync_sel = TX_SYNC_SRG_PROG;
 		msp_config->rx_clk_sel = RX_CLK_SEL_SRG;
@@ -365,7 +328,7 @@ static int setup_msp_config(struct snd_pcm_substream *substream,
 		if (ret < 0)
 			return ret;
 
-		ret = setup_pcm_framing(dai, runtime->rate, prot_desc);
+		ret = setup_pcm_framing(dai, prot_desc);
 		if (ret < 0)
 			return ret;
 
@@ -467,7 +430,9 @@ static int ux500_msp_dai_prepare(struct snd_pcm_substream *substream,
 	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter (rate = %d).\n", __func__,
 		dai->id, snd_pcm_stream_str(substream), runtime->rate);
 
-	setup_msp_config(substream, dai, &msp_config);
+	ret = setup_msp_config(substream, dai, &msp_config);
+	if (ret)
+		return ret;
 
 	ret = ux500_msp_i2s_open(drvdata->msp, &msp_config);
 	if (ret < 0) {
@@ -499,7 +464,6 @@ static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
 {
 	unsigned int mask, slots_active;
-	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
 
 	dev_dbg(dai->dev, "%s: MSP %d (%s): Enter.\n",
@@ -507,9 +471,8 @@ static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
 
 	switch (drvdata->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
-		snd_pcm_hw_constraint_minmax(runtime,
-				SNDRV_PCM_HW_PARAM_CHANNELS,
-				1, 2);
+		if (params_channels(params) < 1 || params_channels(params) > 2)
+			return -EINVAL;
 		break;
 
 	case SND_SOC_DAIFMT_DSP_B:
@@ -521,9 +484,8 @@ static int ux500_msp_dai_hw_params(struct snd_pcm_substream *substream,
 		slots_active = hweight32(mask);
 		dev_dbg(dai->dev, "TDM-slots active: %d", slots_active);
 
-		snd_pcm_hw_constraint_single(runtime,
-				SNDRV_PCM_HW_PARAM_CHANNELS,
-				slots_active);
+		if (!slots_active || params_channels(params) != slots_active)
+			return -EINVAL;
 		break;
 
 	default:
@@ -556,20 +518,21 @@ static int ux500_msp_dai_set_dai_fmt(struct snd_soc_dai *dai,
 	default:
 		dev_err(dai->dev,
 			"%s: Error: Unsupported protocol/master (fmt = 0x%x)!\n",
-			__func__, drvdata->fmt);
+			__func__, fmt);
 		return -EINVAL;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
 	case SND_SOC_DAIFMT_NB_IF:
+	case SND_SOC_DAIFMT_IB_NF:
 	case SND_SOC_DAIFMT_IB_IF:
 		break;
 
 	default:
 		dev_err(dai->dev,
 			"%s: Error: Unsupported inversion (fmt = 0x%x)!\n",
-			__func__, drvdata->fmt);
+			__func__, fmt);
 		return -EINVAL;
 	}
 
@@ -603,17 +566,23 @@ static int ux500_msp_dai_set_tdm_slot(struct snd_soc_dai *dai,
 			__func__, slots);
 		return -EINVAL;
 	}
-	drvdata->slots = slots;
 
-	if (!(slot_width == 16)) {
+	if (slot_width != 16) {
 		dev_err(dai->dev, "%s: Error: Unsupported slot-width (%d)!\n",
 			__func__, slot_width);
 		return -EINVAL;
 	}
-	drvdata->slot_width = slot_width;
 
-	drvdata->tx_mask = tx_mask & cap;
-	drvdata->rx_mask = rx_mask & cap;
+	if ((tx_mask | rx_mask) & ~cap) {
+		dev_err(dai->dev, "%s: Slot mask exceeds %d slots\n",
+			__func__, slots);
+		return -EINVAL;
+	}
+
+	drvdata->slots = slots;
+	drvdata->slot_width = slot_width;
+	drvdata->tx_mask = tx_mask;
+	drvdata->rx_mask = rx_mask;
 
 	return 0;
 }
@@ -673,8 +642,8 @@ static int ux500_msp_dai_of_probe(struct snd_soc_dai *dai)
 	if (!capture_dma_data)
 		return -ENOMEM;
 
-	playback_dma_data->addr = drvdata->msp->playback_dma_data.tx_rx_addr;
-	capture_dma_data->addr = drvdata->msp->capture_dma_data.tx_rx_addr;
+	playback_dma_data->addr = drvdata->msp->tx_rx_addr;
+	capture_dma_data->addr = drvdata->msp->tx_rx_addr;
 
 	playback_dma_data->maxburst = 4;
 	capture_dma_data->maxburst = 4;
@@ -684,26 +653,6 @@ static int ux500_msp_dai_of_probe(struct snd_soc_dai *dai)
 	return 0;
 }
 
-static int ux500_msp_dai_probe(struct snd_soc_dai *dai)
-{
-	struct ux500_msp_i2s_drvdata *drvdata = dev_get_drvdata(dai->dev);
-	struct msp_i2s_platform_data *pdata = dai->dev->platform_data;
-	int ret;
-
-	if (!pdata) {
-		ret = ux500_msp_dai_of_probe(dai);
-		return ret;
-	}
-
-	drvdata->msp->playback_dma_data.data_size = drvdata->slot_width;
-	drvdata->msp->capture_dma_data.data_size = drvdata->slot_width;
-
-	snd_soc_dai_init_dma_data(dai,
-				  &drvdata->msp->playback_dma_data,
-				  &drvdata->msp->capture_dma_data);
-	return 0;
-}
-
 static const struct snd_soc_dai_ops ux500_msp_dai_ops[] = {
 	{
 		.set_sysclk = ux500_msp_dai_set_dai_sysclk,
@@ -718,7 +667,7 @@ static const struct snd_soc_dai_ops ux500_msp_dai_ops[] = {
 };
 
 static struct snd_soc_dai_driver ux500_msp_dai_drv = {
-	.probe                 = ux500_msp_dai_probe,
+	.probe                 = ux500_msp_dai_of_probe,
 	.playback.channels_min = UX500_MSP_MIN_CHANNELS,
 	.playback.channels_max = UX500_MSP_MAX_CHANNELS,
 	.playback.rates        = UX500_I2S_RATES,
@@ -738,15 +687,8 @@ static const struct snd_soc_component_driver ux500_msp_component = {
 static int ux500_msp_drv_probe(struct platform_device *pdev)
 {
 	struct ux500_msp_i2s_drvdata *drvdata;
-	struct msp_i2s_platform_data *pdata = pdev->dev.platform_data;
-	struct device_node *np = pdev->dev.of_node;
 	int ret = 0;
 
-	if (!pdata && !np) {
-		dev_err(&pdev->dev, "No platform data or Device Tree found\n");
-		return -ENODEV;
-	}
-
 	drvdata = devm_kzalloc(&pdev->dev,
 				sizeof(struct ux500_msp_i2s_drvdata),
 				GFP_KERNEL);
@@ -758,7 +700,6 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 	drvdata->tx_mask = 0x01;
 	drvdata->rx_mask = 0x01;
 	drvdata->slot_width = 16;
-	drvdata->master_clk = MSP_INPUT_FREQ_APB;
 
 	drvdata->reg_vape = devm_regulator_get(&pdev->dev, "v-ape");
 	if (IS_ERR(drvdata->reg_vape)) {
@@ -787,10 +728,14 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
 			__func__, ret);
 		return ret;
 	}
+	drvdata->master_clk = clk_get_rate(drvdata->clk);
+	if (!drvdata->master_clk) {
+		dev_err(&pdev->dev, "MSP clock has no rate\n");
+		return -EINVAL;
+	}
 
-	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp,
-				pdev->dev.platform_data);
-	if (!drvdata->msp) {
+	ret = ux500_msp_i2s_init_msp(pdev, &drvdata->msp);
+	if (ret) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to init MSP-struct (%d)!",
 			__func__, ret);
diff --git a/sound/soc/ux500/ux500_msp_dai.h b/sound/soc/ux500/ux500_msp_dai.h
index fcd4b26f5d2d..731f87d62673 100644
--- a/sound/soc/ux500/ux500_msp_dai.h
+++ b/sound/soc/ux500/ux500_msp_dai.h
@@ -24,17 +24,6 @@
 
 #define UX500_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE)
 
-#define FRAME_PER_SINGLE_SLOT_8_KHZ		31
-#define FRAME_PER_SINGLE_SLOT_16_KHZ	124
-#define FRAME_PER_SINGLE_SLOT_44_1_KHZ	63
-#define FRAME_PER_SINGLE_SLOT_48_KHZ	49
-#define FRAME_PER_2_SLOTS				31
-#define FRAME_PER_8_SLOTS				138
-#define FRAME_PER_16_SLOTS				277
-
-#define UX500_MSP_INTERNAL_CLOCK_FREQ  40000000
-#define UX500_MSP1_INTERNAL_CLOCK_FREQ UX500_MSP_INTERNAL_CLOCK_FREQ
-
 #define UX500_MSP_MIN_CHANNELS		1
 #define UX500_MSP_MAX_CHANNELS		8
 
diff --git a/sound/soc/ux500/ux500_msp_i2s.c b/sound/soc/ux500/ux500_msp_i2s.c
index fd0b88bb7921..86193f158393 100644
--- a/sound/soc/ux500/ux500_msp_i2s.c
+++ b/sound/soc/ux500/ux500_msp_i2s.c
@@ -16,7 +16,6 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/of.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
 
 #include <sound/soc.h>
 
@@ -204,10 +203,12 @@ static int configure_protocol(struct ux500_msp *msp,
 
 	/* The code below should not be separated. */
 	temp_reg = readl(msp->registers + MSP_GCR) & ~TX_CLK_POL_RISING;
-	temp_reg |= MSP_TX_CLKPOL_BIT(~protdesc->tx_clk_pol);
+	temp_reg |= MSP_TX_CLKPOL_BIT(!protdesc->tx_clk_pol ^
+					  config->bclk_inverted);
 	writel(temp_reg, msp->registers + MSP_GCR);
 	temp_reg = readl(msp->registers + MSP_GCR) & ~RX_CLK_POL_RISING;
-	temp_reg |= MSP_RX_CLKPOL_BIT(protdesc->rx_clk_pol);
+	temp_reg |= MSP_RX_CLKPOL_BIT(protdesc->rx_clk_pol ^
+					  config->bclk_inverted);
 	writel(temp_reg, msp->registers + MSP_GCR);
 
 	return 0;
@@ -215,35 +216,20 @@ static int configure_protocol(struct ux500_msp *msp,
 
 static int setup_bitclk(struct ux500_msp *msp, struct ux500_msp_config *config)
 {
+	struct msp_protdesc *protdesc;
+	u64 desired_bitclk;
+	unsigned int bitclk;
 	u32 reg_val_GCR;
-	u32 frame_per = 0;
-	u32 sck_div = 0;
-	u32 frame_width = 0;
-	u32 temp_reg = 0;
-	struct msp_protdesc *protdesc = NULL;
+	u32 sck_div;
+	u32 temp_reg;
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
 	writel(reg_val_GCR & ~SRG_ENABLE, msp->registers + MSP_GCR);
 
-	if (config->default_protdesc)
-		protdesc =
-			(struct msp_protdesc *)&prot_descs[config->protocol];
-	else
-		protdesc = (struct msp_protdesc *)&config->protdesc;
-
 	switch (config->protocol) {
 	case MSP_PCM_PROTOCOL:
 	case MSP_PCM_COMPAND_PROTOCOL:
-		frame_width = protdesc->frame_width;
-		sck_div = config->f_inputclk / (config->frame_freq *
-			(protdesc->clocks_per_frame));
-		frame_per = protdesc->frame_period;
-		break;
 	case MSP_I2S_PROTOCOL:
-		frame_width = protdesc->frame_width;
-		sck_div = config->f_inputclk / (config->frame_freq *
-			(protdesc->clocks_per_frame));
-		frame_per = protdesc->frame_period;
 		break;
 	default:
 		dev_err(msp->dev, "%s: ERROR: Unknown protocol (%d)!\n",
@@ -252,12 +238,35 @@ static int setup_bitclk(struct ux500_msp *msp, struct ux500_msp_config *config)
 		return -EINVAL;
 	}
 
+	if (config->default_protdesc)
+		protdesc = (struct msp_protdesc *)&prot_descs[config->protocol];
+	else
+		protdesc = &config->protdesc;
+
+	if (!config->frame_freq || !protdesc->clocks_per_frame)
+		return -EINVAL;
+
+	desired_bitclk = (u64)config->frame_freq * protdesc->clocks_per_frame;
+	if (desired_bitclk > config->f_inputclk)
+		return -EINVAL;
+	bitclk = desired_bitclk;
+	if (config->f_inputclk % bitclk) {
+		dev_err(msp->dev,
+			"Input clock %u cannot generate bit clock %u\n",
+			config->f_inputclk, bitclk);
+		return -EINVAL;
+	}
+
+	sck_div = config->f_inputclk / bitclk;
+	if (!sck_div || sck_div > SCK_DIV_MASK + 1)
+		return -EINVAL;
+
 	temp_reg = (sck_div - 1) & SCK_DIV_MASK;
-	temp_reg |= FRAME_WIDTH_BITS(frame_width);
-	temp_reg |= FRAME_PERIOD_BITS(frame_per);
+	temp_reg |= FRAME_WIDTH_BITS(protdesc->frame_width);
+	temp_reg |= FRAME_PERIOD_BITS(protdesc->frame_period);
 	writel(temp_reg, msp->registers + MSP_SRG);
 
-	msp->f_bitclk = (config->f_inputclk)/(sck_div + 1);
+	msp->f_bitclk = config->f_inputclk / sck_div;
 
 	/* Enable bit-clock */
 	udelay(100);
@@ -347,34 +356,27 @@ static int configure_multichannel(struct ux500_msp *msp,
 	return 0;
 }
 
-static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
+static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config,
+		      bool first)
 {
-	int status = 0;
-	u32 reg_val_DMACR, reg_val_GCR;
+	int status;
+	u32 reg_val_DMACR;
 
 	/* Configure msp with protocol dependent settings */
-	configure_protocol(msp, config);
-	setup_bitclk(msp, config);
-	if (config->multichannel_configured == 1) {
-		status = configure_multichannel(msp, config);
+	status = configure_protocol(msp, config);
+	if (status)
+		return status;
+
+	if (first && config->clock_provider) {
+		status = setup_bitclk(msp, config);
 		if (status)
-			dev_warn(msp->dev,
-				"%s: WARN: configure_multichannel failed (%d)!\n",
-				__func__, status);
+			return status;
 	}
 
-	/* Make sure the correct DMA-directions are configured */
-	if ((config->direction & MSP_DIR_RX) &&
-			!msp->capture_dma_data.dma_cfg) {
-		dev_err(msp->dev, "%s: ERROR: MSP RX-mode is not configured!",
-			__func__);
-		return -EINVAL;
-	}
-	if ((config->direction == MSP_DIR_TX) &&
-			!msp->playback_dma_data.dma_cfg) {
-		dev_err(msp->dev, "%s: ERROR: MSP TX-mode is not configured!",
-			__func__);
-		return -EINVAL;
+	if (config->multichannel_configured == 1) {
+		status = configure_multichannel(msp, config);
+		if (status)
+			return status;
 	}
 
 	reg_val_DMACR = readl(msp->registers + MSP_DMACR);
@@ -386,11 +388,7 @@ static int enable_msp(struct ux500_msp *msp, struct ux500_msp_config *config)
 
 	writel(config->iodelay, msp->registers + MSP_IODLY);
 
-	/* Enable frame generation logic */
-	reg_val_GCR = readl(msp->registers + MSP_GCR);
-	writel(reg_val_GCR | FRAME_GEN_ENABLE, msp->registers + MSP_GCR);
-
-	return status;
+	return 0;
 }
 
 static void flush_fifo_rx(struct ux500_msp *msp)
@@ -428,12 +426,37 @@ static void flush_fifo_tx(struct ux500_msp *msp)
 	writel(reg_val_GCR, msp->registers + MSP_GCR);
 }
 
+static bool ux500_msp_config_compatible(struct ux500_msp *msp,
+					struct ux500_msp_config *config)
+{
+	struct ux500_msp_config *active = &msp->config;
+
+	return active->f_inputclk == config->f_inputclk &&
+	       active->tx_clk_sel == config->tx_clk_sel &&
+	       active->rx_clk_sel == config->rx_clk_sel &&
+	       active->srg_clk_sel == config->srg_clk_sel &&
+	       active->rx_fsync_pol == config->rx_fsync_pol &&
+	       active->tx_fsync_pol == config->tx_fsync_pol &&
+	       active->rx_fsync_sel == config->rx_fsync_sel &&
+	       active->tx_fsync_sel == config->tx_fsync_sel &&
+	       active->default_protdesc == config->default_protdesc &&
+	       active->protocol == config->protocol &&
+	       active->frame_freq == config->frame_freq &&
+	       active->data_size == config->data_size &&
+	       active->def_elem_len == config->def_elem_len &&
+	       active->clock_provider == config->clock_provider &&
+	       active->bclk_inverted == config->bclk_inverted &&
+	       !memcmp(&active->protdesc, &config->protdesc,
+		       sizeof(active->protdesc));
+}
+
 int ux500_msp_i2s_open(struct ux500_msp *msp,
 		struct ux500_msp_config *config)
 {
 	u32 old_reg, new_reg, mask;
 	int res;
 	unsigned int tx_sel, rx_sel, tx_busy, rx_busy;
+	bool first;
 
 	if (in_interrupt()) {
 		dev_err(msp->dev,
@@ -461,40 +484,68 @@ int ux500_msp_i2s_open(struct ux500_msp *msp,
 		return -EBUSY;
 	}
 
-	msp->dir_busy |= (tx_sel ? MSP_DIR_TX : 0) | (rx_sel ? MSP_DIR_RX : 0);
-
-	/* First do the global config register */
-	mask = RX_CLK_SEL_MASK | TX_CLK_SEL_MASK | RX_FSYNC_MASK |
-	    TX_FSYNC_MASK | RX_SYNC_SEL_MASK | TX_SYNC_SEL_MASK |
-	    RX_FIFO_ENABLE_MASK | TX_FIFO_ENABLE_MASK | SRG_CLK_SEL_MASK |
-	    LOOPBACK_MASK | TX_EXTRA_DELAY_MASK;
-
-	new_reg = (config->tx_clk_sel | config->rx_clk_sel |
-		config->rx_fsync_pol | config->tx_fsync_pol |
-		config->rx_fsync_sel | config->tx_fsync_sel |
-		config->rx_fifo_config | config->tx_fifo_config |
-		config->srg_clk_sel | config->loopback_enable |
-		config->tx_data_enable);
+	first = !msp->dir_busy;
+	if (!first && !ux500_msp_config_compatible(msp, config)) {
+		dev_err(msp->dev, "%s: Incompatible duplex configuration\n",
+			__func__);
+		return -EBUSY;
+	}
 
-	old_reg = readl(msp->registers + MSP_GCR);
-	old_reg &= ~mask;
-	new_reg |= old_reg;
-	writel(new_reg, msp->registers + MSP_GCR);
+	if (first) {
+		/* First do the global config register */
+		mask = RX_CLK_SEL_MASK | TX_CLK_SEL_MASK | RX_FSYNC_MASK |
+		       TX_FSYNC_MASK | RX_SYNC_SEL_MASK | TX_SYNC_SEL_MASK |
+		       RX_FIFO_ENABLE_MASK | TX_FIFO_ENABLE_MASK |
+		       SRG_CLK_SEL_MASK | LOOPBACK_MASK | TX_EXTRA_DELAY_MASK;
+
+		new_reg = config->tx_clk_sel | config->rx_clk_sel |
+			  config->rx_fsync_pol | config->tx_fsync_pol |
+			  config->rx_fsync_sel | config->tx_fsync_sel |
+			  config->rx_fifo_config | config->tx_fifo_config |
+			  config->srg_clk_sel | config->loopback_enable |
+			  config->tx_data_enable;
+
+		old_reg = readl(msp->registers + MSP_GCR);
+		old_reg &= ~mask;
+		new_reg |= old_reg;
+		writel(new_reg, msp->registers + MSP_GCR);
+		writel(MSP_WMRK_TX_4_ELEMENTS | MSP_WMRK_RX_4_ELEMENTS,
+		       msp->registers + MSP_WMRK);
+	}
 
-	res = enable_msp(msp, config);
+	res = enable_msp(msp, config, first);
 	if (res < 0) {
 		dev_err(msp->dev, "%s: ERROR: enable_msp failed (%d)!\n",
 			__func__, res);
-		return -EBUSY;
+		if (tx_sel)
+			writel(0, msp->registers + MSP_TCF);
+		if (rx_sel)
+			writel(0, msp->registers + MSP_RCF);
+		if (first) {
+			writel(0, msp->registers + MSP_GCR);
+			writel(0, msp->registers + MSP_DMACR);
+			writel(0, msp->registers + MSP_SRG);
+			writel(0, msp->registers + MSP_MCR);
+		}
+		return res;
+	}
+
+	msp->dir_busy |= config->direction;
+	if (first) {
+		msp->config = *config;
+		msp->clock_provider = config->clock_provider;
 	}
 	if (config->loopback_enable & 0x80)
 		msp->loopback_enable = 1;
 
 	/* Flush FIFOs */
-	flush_fifo_tx(msp);
-	flush_fifo_rx(msp);
+	if (tx_sel)
+		flush_fifo_tx(msp);
+	if (rx_sel)
+		flush_fifo_rx(msp);
 
-	msp->msp_state = MSP_STATE_CONFIGURED;
+	if (!msp->dir_running)
+		msp->msp_state = MSP_STATE_CONFIGURED;
 	return 0;
 }
 
@@ -511,7 +562,6 @@ static void disable_msp_rx(struct ux500_msp *msp)
 			~(RX_SERVICE_INT | RX_OVERRUN_ERROR_INT),
 			msp->registers + MSP_IMSC);
 
-	msp->dir_busy &= ~MSP_DIR_RX;
 }
 
 static void disable_msp_tx(struct ux500_msp *msp)
@@ -527,7 +577,6 @@ static void disable_msp_tx(struct ux500_msp *msp)
 			~(TX_SERVICE_INT | TX_UNDERRUN_ERR_INT),
 			msp->registers + MSP_IMSC);
 
-	msp->dir_busy &= ~MSP_DIR_TX;
 }
 
 static int disable_msp(struct ux500_msp *msp, unsigned int dir)
@@ -537,7 +586,7 @@ static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 
 	reg_val_GCR = readl(msp->registers + MSP_GCR);
 	disable_tx = dir & MSP_DIR_TX;
-	disable_rx = dir & MSP_DIR_TX;
+	disable_rx = dir & MSP_DIR_RX;
 	if (disable_tx && disable_rx) {
 		reg_val_GCR = readl(msp->registers + MSP_GCR);
 		writel(reg_val_GCR | LOOPBACK_MASK,
@@ -570,7 +619,15 @@ static int disable_msp(struct ux500_msp *msp, unsigned int dir)
 
 int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
 {
-	u32 reg_val_GCR, enable_bit;
+	u32 reg_val_DMACR, reg_val_GCR, dma_enable_bit, enable_bit;
+	unsigned int dir;
+
+	if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		dir = MSP_DIR_TX;
+	else if (direction == SNDRV_PCM_STREAM_CAPTURE)
+		dir = MSP_DIR_RX;
+	else
+		return -EINVAL;
 
 	if (msp->msp_state == MSP_STATE_IDLE) {
 		dev_err(msp->dev, "%s: ERROR: MSP is not configured!\n",
@@ -582,21 +639,44 @@ int ux500_msp_i2s_trigger(struct ux500_msp *msp, int cmd, int direction)
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			enable_bit = TX_ENABLE;
-		else
+			dma_enable_bit = TX_DMA_ENABLE;
+		} else {
 			enable_bit = RX_ENABLE;
+			dma_enable_bit = RX_DMA_ENABLE;
+		}
+		if (!(msp->dir_busy & dir))
+			return -EINVAL;
+		reg_val_DMACR = readl(msp->registers + MSP_DMACR);
+		writel(reg_val_DMACR | dma_enable_bit,
+		       msp->registers + MSP_DMACR);
 		reg_val_GCR = readl(msp->registers + MSP_GCR);
+		if (msp->clock_provider)
+			enable_bit |= FRAME_GEN_ENABLE;
 		writel(reg_val_GCR | enable_bit, msp->registers + MSP_GCR);
+		msp->dir_running |= dir;
+		msp->msp_state = MSP_STATE_RUNNING;
 		break;
 
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-		if (direction == SNDRV_PCM_STREAM_PLAYBACK)
+		if (!(msp->dir_busy & dir))
+			return -EINVAL;
+		if (direction == SNDRV_PCM_STREAM_PLAYBACK) {
 			disable_msp_tx(msp);
-		else
+			msp->dir_running &= ~MSP_DIR_TX;
+		} else {
 			disable_msp_rx(msp);
+			msp->dir_running &= ~MSP_DIR_RX;
+		}
+		if (!msp->dir_running) {
+			reg_val_GCR = readl(msp->registers + MSP_GCR);
+			writel(reg_val_GCR & ~FRAME_GEN_ENABLE,
+			       msp->registers + MSP_GCR);
+			msp->msp_state = MSP_STATE_CONFIGURED;
+		}
 		break;
 	default:
 		return -EINVAL;
@@ -611,7 +691,18 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 
 	dev_dbg(msp->dev, "%s: Enter (dir = 0x%01x).\n", __func__, dir);
 
+	if (!dir || dir & ~(MSP_DIR_TX | MSP_DIR_RX) ||
+	    (msp->dir_busy & dir) != dir)
+		return -EINVAL;
+
 	status = disable_msp(msp, dir);
+	msp->dir_busy &= ~dir;
+	msp->dir_running &= ~dir;
+	if (msp->dir_busy && !msp->dir_running) {
+		writel(readl(msp->registers + MSP_GCR) & ~FRAME_GEN_ENABLE,
+		       msp->registers + MSP_GCR);
+		msp->msp_state = MSP_STATE_CONFIGURED;
+	}
 	if (msp->dir_busy == 0) {
 		/* disable sample rate and frame generators */
 		msp->msp_state = MSP_STATE_IDLE;
@@ -635,86 +726,31 @@ int ux500_msp_i2s_close(struct ux500_msp *msp, unsigned int dir)
 		writel(0, msp->registers + MSP_RCE1);
 		writel(0, msp->registers + MSP_RCE2);
 		writel(0, msp->registers + MSP_RCE3);
+		memset(&msp->config, 0, sizeof(msp->config));
+		msp->clock_provider = false;
 	}
 
 	return status;
 
 }
 
-static int ux500_msp_i2s_of_init_msp(struct platform_device *pdev,
-				struct ux500_msp *msp,
-				struct msp_i2s_platform_data **platform_data)
-{
-	struct msp_i2s_platform_data *pdata;
-
-	*platform_data = devm_kzalloc(&pdev->dev,
-				     sizeof(struct msp_i2s_platform_data),
-				     GFP_KERNEL);
-	pdata = *platform_data;
-	if (!pdata)
-		return -ENOMEM;
-
-	msp->playback_dma_data.dma_cfg = devm_kzalloc(&pdev->dev,
-					sizeof(struct stedma40_chan_cfg),
-					GFP_KERNEL);
-	if (!msp->playback_dma_data.dma_cfg)
-		return -ENOMEM;
-
-	msp->capture_dma_data.dma_cfg = devm_kzalloc(&pdev->dev,
-					sizeof(struct stedma40_chan_cfg),
-					GFP_KERNEL);
-	if (!msp->capture_dma_data.dma_cfg)
-		return -ENOMEM;
-
-	return 0;
-}
-
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
-			struct ux500_msp **msp_p,
-			struct msp_i2s_platform_data *platform_data)
+			struct ux500_msp **msp_p)
 {
-	struct resource *res = NULL;
-	struct device_node *np = pdev->dev.of_node;
+	struct resource *res;
 	struct ux500_msp *msp;
-	int ret;
 
 	*msp_p = devm_kzalloc(&pdev->dev, sizeof(struct ux500_msp), GFP_KERNEL);
 	msp = *msp_p;
 	if (!msp)
 		return -ENOMEM;
 
-	if (!platform_data) {
-		if (np) {
-			ret = ux500_msp_i2s_of_init_msp(pdev, msp,
-							&platform_data);
-			if (ret)
-				return ret;
-		} else
-			return -EINVAL;
-	} else {
-		msp->playback_dma_data.dma_cfg = platform_data->msp_i2s_dma_tx;
-		msp->capture_dma_data.dma_cfg = platform_data->msp_i2s_dma_rx;
-		msp->id = platform_data->id;
-	}
-
 	msp->dev = &pdev->dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (res == NULL) {
-		dev_err(&pdev->dev, "%s: ERROR: Unable to get resource!\n",
-			__func__);
-		return -ENOMEM;
-	}
-
-	msp->playback_dma_data.tx_rx_addr = res->start + MSP_DR;
-	msp->capture_dma_data.tx_rx_addr = res->start + MSP_DR;
-
-	msp->registers = devm_ioremap(&pdev->dev, res->start,
-				      resource_size(res));
-	if (msp->registers == NULL) {
-		dev_err(&pdev->dev, "%s: ERROR: ioremap failed!\n", __func__);
-		return -ENOMEM;
-	}
+	msp->registers = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(msp->registers))
+		return PTR_ERR(msp->registers);
+	msp->tx_rx_addr = res->start + MSP_DR;
 
 	msp->msp_state = MSP_STATE_IDLE;
 	msp->loopback_enable = 0;
diff --git a/sound/soc/ux500/ux500_msp_i2s.h b/sound/soc/ux500/ux500_msp_i2s.h
index 756b3973af9a..4e4f140912f9 100644
--- a/sound/soc/ux500/ux500_msp_i2s.h
+++ b/sound/soc/ux500/ux500_msp_i2s.h
@@ -13,9 +13,6 @@
 #define UX500_MSP_I2S_H
 
 #include <linux/platform_device.h>
-#include <linux/platform_data/asoc-ux500-msp.h>
-
-#define MSP_INPUT_FREQ_APB 48000000
 
 /*** Stereo mode. Used for APB data accesses as 16 bits accesses (mono),
  *   32 bits accesses (stereo).
@@ -67,6 +64,7 @@ enum msp_direction {
 #define MSP_SRG		0x10
 #define MSP_FLR		0x14
 #define MSP_DMACR	0x18
+#define MSP_WMRK	0x1c
 
 #define MSP_IMSC	0x20
 #define MSP_RIS		0x24
@@ -151,8 +149,8 @@ enum msp_direction {
 #define RCKPOL_MASK		BIT(0)
 #define TCKPOL_MASK		BIT(0)
 #define SPICKM_MASK		(BIT(1) | BIT(0))
-#define MSP_RX_CLKPOL_BIT(n)     ((n & RCKPOL_MASK) << RCKPOL_SHIFT)
-#define MSP_TX_CLKPOL_BIT(n)     ((n & TCKPOL_MASK) << TCKPOL_SHIFT)
+#define MSP_RX_CLKPOL_BIT(n)     (((n) & RCKPOL_MASK) << RCKPOL_SHIFT)
+#define MSP_TX_CLKPOL_BIT(n)     (((n) & TCKPOL_MASK) << TCKPOL_SHIFT)
 
 #define P1ELEN_SHIFT		0
 #define P1FLEN_SHIFT		3
@@ -233,6 +231,10 @@ enum msp_direction {
 #define RDMAE_SHIFT		0
 #define TDMAE_SHIFT		1
 
+/* FIFO watermark register */
+#define MSP_WMRK_RX_4_ELEMENTS	BIT(0)
+#define MSP_WMRK_TX_4_ELEMENTS	BIT(3)
+
 /* Interrupt Register */
 #define RX_SERVICE_INT		BIT(0)
 #define RX_OVERRUN_ERROR_INT	BIT(1)
@@ -463,31 +465,27 @@ struct ux500_msp_config {
 	enum msp_data_size data_size;
 	unsigned int def_elem_len;
 	unsigned int iodelay;
-};
-
-struct ux500_msp_dma_params {
-	unsigned int data_size;
-	dma_addr_t tx_rx_addr;
-	struct stedma40_chan_cfg *dma_cfg;
+	bool clock_provider;
+	bool bclk_inverted;
 };
 
 struct ux500_msp {
 	int id;
 	void __iomem *registers;
 	struct device *dev;
-	struct ux500_msp_dma_params playback_dma_data;
-	struct ux500_msp_dma_params capture_dma_data;
+	dma_addr_t tx_rx_addr;
 	enum msp_state msp_state;
 	int def_elem_len;
 	unsigned int dir_busy;
+	unsigned int dir_running;
 	int loopback_enable;
 	unsigned int f_bitclk;
+	bool clock_provider;
+	struct ux500_msp_config config;
 };
 
-struct msp_i2s_platform_data;
 int ux500_msp_i2s_init_msp(struct platform_device *pdev,
-			struct ux500_msp **msp_p,
-			struct msp_i2s_platform_data *platform_data);
+			struct ux500_msp **msp_p);
 void ux500_msp_i2s_cleanup_msp(struct platform_device *pdev,
 			struct ux500_msp *msp);
 int ux500_msp_i2s_open(struct ux500_msp *msp, struct ux500_msp_config *config);
diff --git a/sound/soc/ux500/ux500_pcm.c b/sound/soc/ux500/ux500_pcm.c
index 18191084b8b8..972913e4c64c 100644
--- a/sound/soc/ux500/ux500_pcm.c
+++ b/sound/soc/ux500/ux500_pcm.c
@@ -15,7 +15,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/slab.h>
-#include <linux/platform_data/dma-ste-dma40.h>
 
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
@@ -31,76 +30,17 @@
 #define UX500_PLATFORM_PERIODS_MAX		48
 #define UX500_PLATFORM_BUFFER_BYTES_MAX		(2048 * PAGE_SIZE)
 
-static const struct snd_pcm_hardware ux500_pcm_hw = {
-	.info = SNDRV_PCM_INFO_INTERLEAVED |
-		SNDRV_PCM_INFO_MMAP |
-		SNDRV_PCM_INFO_RESUME |
-		SNDRV_PCM_INFO_PAUSE,
-	.buffer_bytes_max = UX500_PLATFORM_BUFFER_BYTES_MAX,
-	.period_bytes_min = UX500_PLATFORM_PERIODS_BYTES_MIN,
-	.period_bytes_max = UX500_PLATFORM_PERIODS_BYTES_MAX,
-	.periods_min = UX500_PLATFORM_PERIODS_MIN,
-	.periods_max = UX500_PLATFORM_PERIODS_MAX,
-};
-
-static struct dma_chan *ux500_pcm_request_chan(struct snd_soc_pcm_runtime *rtd,
-	struct snd_pcm_substream *substream)
-{
-	struct snd_soc_dai *dai = asoc_rtd_to_cpu(rtd, 0);
-	u16 per_data_width, mem_data_width;
-	struct stedma40_chan_cfg *dma_cfg;
-	struct ux500_msp_dma_params *dma_params;
-
-	dma_params = snd_soc_dai_get_dma_data(dai, substream);
-	dma_cfg = dma_params->dma_cfg;
-
-	mem_data_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-
-	switch (dma_params->data_size) {
-	case 32:
-		per_data_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-		break;
-	case 16:
-		per_data_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
-		break;
-	case 8:
-		per_data_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
-		break;
-	default:
-		per_data_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
-	}
-
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		dma_cfg->src_info.data_width = mem_data_width;
-		dma_cfg->dst_info.data_width = per_data_width;
-	} else {
-		dma_cfg->src_info.data_width = per_data_width;
-		dma_cfg->dst_info.data_width = mem_data_width;
-	}
-
-	return snd_dmaengine_pcm_request_channel(stedma40_filter, dma_cfg);
-}
-
 static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 		struct snd_pcm_hw_params *params,
 		struct dma_slave_config *slave_config)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
-	struct msp_i2s_platform_data *pdata = asoc_rtd_to_cpu(rtd, 0)->dev->platform_data;
 	struct snd_dmaengine_dai_dma_data *snd_dma_params;
-	struct ux500_msp_dma_params *ste_dma_params;
 	dma_addr_t dma_addr;
 	int ret;
 
-	if (pdata) {
-		ste_dma_params =
-			snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
-		dma_addr = ste_dma_params->tx_rx_addr;
-	} else {
-		snd_dma_params =
-			snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
-		dma_addr = snd_dma_params->addr;
-	}
+	snd_dma_params = snd_soc_dai_get_dma_data(asoc_rtd_to_cpu(rtd, 0), substream);
+	dma_addr = snd_dma_params->addr;
 
 	ret = snd_hwparams_to_dma_slave_config(substream, params, slave_config);
 	if (ret)
@@ -120,31 +60,16 @@ static int ux500_pcm_prepare_slave_config(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static const struct snd_dmaengine_pcm_config ux500_dmaengine_pcm_config = {
-	.pcm_hardware = &ux500_pcm_hw,
-	.compat_request_channel = ux500_pcm_request_chan,
-	.prealloc_buffer_size = 128 * 1024,
-	.prepare_slave_config = ux500_pcm_prepare_slave_config,
-};
-
 static const struct snd_dmaengine_pcm_config ux500_dmaengine_of_pcm_config = {
-	.compat_request_channel = ux500_pcm_request_chan,
 	.prepare_slave_config = ux500_pcm_prepare_slave_config,
 };
 
 int ux500_pcm_register_platform(struct platform_device *pdev)
 {
-	const struct snd_dmaengine_pcm_config *pcm_config;
-	struct device_node *np = pdev->dev.of_node;
 	int ret;
 
-	if (np)
-		pcm_config = &ux500_dmaengine_of_pcm_config;
-	else
-		pcm_config = &ux500_dmaengine_pcm_config;
-
-	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config,
-					 SND_DMAENGINE_PCM_FLAG_COMPAT);
+	ret = snd_dmaengine_pcm_register(&pdev->dev,
+					 &ux500_dmaengine_of_pcm_config, 0);
 	if (ret < 0) {
 		dev_err(&pdev->dev,
 			"%s: ERROR: Failed to register platform '%s' (%d)!\n",
diff --git a/sound/usb/caiaq/audio.c b/sound/usb/caiaq/audio.c
index 1308415b55ed..4a7f9ff318a2 100644
--- a/sound/usb/caiaq/audio.c
+++ b/sound/usb/caiaq/audio.c
@@ -853,16 +853,13 @@ int snd_usb_caiaq_audio_init(struct snd_usb_caiaqdev *cdev)
 
 	cdev->data_urbs_in = alloc_urbs(cdev, SNDRV_PCM_STREAM_CAPTURE, &ret);
 	if (ret < 0) {
-		kfree(cdev->data_cb_info);
-		free_urbs(cdev->data_urbs_in);
+		snd_usb_caiaq_audio_free(cdev);
 		return ret;
 	}
 
 	cdev->data_urbs_out = alloc_urbs(cdev, SNDRV_PCM_STREAM_PLAYBACK, &ret);
 	if (ret < 0) {
-		kfree(cdev->data_cb_info);
-		free_urbs(cdev->data_urbs_in);
-		free_urbs(cdev->data_urbs_out);
+		snd_usb_caiaq_audio_free(cdev);
 		return ret;
 	}
 
@@ -883,6 +880,9 @@ void snd_usb_caiaq_audio_free(struct snd_usb_caiaqdev *cdev)
 
 	dev_dbg(dev, "%s(%p)\n", __func__, cdev);
 	free_urbs(cdev->data_urbs_in);
+	cdev->data_urbs_in = NULL;
 	free_urbs(cdev->data_urbs_out);
+	cdev->data_urbs_out = NULL;
 	kfree(cdev->data_cb_info);
+	cdev->data_cb_info = NULL;
 }
diff --git a/sound/usb/caiaq/device.c b/sound/usb/caiaq/device.c
index ba1029f8eeb7..bb7672d76b7a 100644
--- a/sound/usb/caiaq/device.c
+++ b/sound/usb/caiaq/device.c
@@ -148,14 +148,22 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 	struct device *dev = &urb->dev->dev;
 	struct snd_usb_caiaqdev *cdev = urb->context;
 	unsigned char *buf = urb->transfer_buffer;
+	unsigned int payload_len;
+	unsigned int copy_len;
 
 	if (urb->status || !cdev) {
 		dev_warn(dev, "received EP1 urb->status = %i\n", urb->status);
 		return;
 	}
+	if (urb->actual_length < 1)
+		return;
+
+	payload_len = urb->actual_length - 1;
 
 	switch(buf[0]) {
 	case EP1_CMD_GET_DEVICE_INFO:
+		if (payload_len < sizeof(struct caiaq_device_spec))
+			break;
 	 	memcpy(&cdev->spec, buf+1, sizeof(struct caiaq_device_spec));
 		cdev->spec.fw_version = le16_to_cpu(cdev->spec.fw_version);
 		dev_dbg(dev, "device spec (firmware %d): audio: %d in, %d out, "
@@ -171,18 +179,21 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 		wake_up(&cdev->ep1_wait_queue);
 		break;
 	case EP1_CMD_AUDIO_PARAMS:
+		if (payload_len < 1)
+			break;
 		cdev->audio_parm_answer = buf[1];
 		wake_up(&cdev->ep1_wait_queue);
 		break;
 	case EP1_CMD_MIDI_READ:
+		if (urb->actual_length < 3 || urb->actual_length - 3 < buf[2])
+			break;
 		snd_usb_caiaq_midi_handle_input(cdev, buf[1], buf + 3, buf[2]);
 		break;
 	case EP1_CMD_READ_IO:
 		if (cdev->chip.usb_id ==
 			USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_AUDIO8DJ)) {
-			if (urb->actual_length > sizeof(cdev->control_state))
-				urb->actual_length = sizeof(cdev->control_state);
-			memcpy(cdev->control_state, buf + 1, urb->actual_length);
+			copy_len = min_t(unsigned int, payload_len, sizeof(cdev->control_state));
+			memcpy(cdev->control_state, buf + 1, copy_len);
 			wake_up(&cdev->ep1_wait_queue);
 			break;
 		}
@@ -195,8 +206,8 @@ static void usb_ep1_command_reply_dispatch (struct urb* urb)
 		break;
 	}
 
-	cdev->ep1_in_urb.actual_length = 0;
-	ret = usb_submit_urb(&cdev->ep1_in_urb, GFP_ATOMIC);
+	cdev->ep1_in_urb->actual_length = 0;
+	ret = usb_submit_urb(cdev->ep1_in_urb, GFP_ATOMIC);
 	if (ret < 0)
 		dev_err(dev, "unable to submit urb. OOM!?\n");
 }
@@ -411,6 +422,10 @@ static void card_free(struct snd_card *card)
 #endif
 	snd_usb_caiaq_audio_free(cdev);
 	usb_put_dev(cdev->chip.dev);
+	usb_free_urb(cdev->ep1_in_urb);
+	cdev->ep1_in_urb = NULL;
+	usb_free_urb(cdev->midi_out_urb);
+	cdev->midi_out_urb = NULL;
 }
 
 static int create_card(struct usb_device *usb_dev,
@@ -460,22 +475,30 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 		return -EIO;
 	}
 
-	usb_init_urb(&cdev->ep1_in_urb);
-	usb_init_urb(&cdev->midi_out_urb);
+	cdev->ep1_in_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!cdev->ep1_in_urb)
+		return -ENOMEM;
+
+	cdev->midi_out_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!cdev->midi_out_urb) {
+		usb_free_urb(cdev->ep1_in_urb);
+		cdev->ep1_in_urb = NULL;
+		return -ENOMEM;
+	}
 
-	usb_fill_bulk_urb(&cdev->ep1_in_urb, usb_dev,
+	usb_fill_bulk_urb(cdev->ep1_in_urb, usb_dev,
 			  usb_rcvbulkpipe(usb_dev, 0x1),
 			  cdev->ep1_in_buf, EP1_BUFSIZE,
 			  usb_ep1_command_reply_dispatch, cdev);
 
-	usb_fill_bulk_urb(&cdev->midi_out_urb, usb_dev,
+	usb_fill_bulk_urb(cdev->midi_out_urb, usb_dev,
 			  usb_sndbulkpipe(usb_dev, 0x1),
 			  cdev->midi_out_buf, EP1_BUFSIZE,
 			  snd_usb_caiaq_midi_output_done, cdev);
 
 	/* sanity checks of EPs before actually submitting */
-	if (usb_urb_ep_type_check(&cdev->ep1_in_urb) ||
-	    usb_urb_ep_type_check(&cdev->midi_out_urb)) {
+	if (usb_urb_ep_type_check(cdev->ep1_in_urb) ||
+	    usb_urb_ep_type_check(cdev->midi_out_urb)) {
 		dev_err(dev, "invalid EPs\n");
 		return -EINVAL;
 	}
@@ -483,7 +506,7 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 	init_waitqueue_head(&cdev->ep1_wait_queue);
 	init_waitqueue_head(&cdev->prepare_wait_queue);
 
-	if (usb_submit_urb(&cdev->ep1_in_urb, GFP_KERNEL) != 0)
+	if (usb_submit_urb(cdev->ep1_in_urb, GFP_KERNEL) != 0)
 		return -EIO;
 
 	err = snd_usb_caiaq_send_command(cdev, EP1_CMD_GET_DEVICE_INFO, NULL, 0);
@@ -533,7 +556,7 @@ static int init_card(struct snd_usb_caiaqdev *cdev)
 	return 0;
 
  err_kill_urb:
-	usb_kill_urb(&cdev->ep1_in_urb);
+	usb_kill_urb(cdev->ep1_in_urb);
 	return err;
 }
 
@@ -579,8 +602,8 @@ static void snd_disconnect(struct usb_interface *intf)
 #endif
 	snd_usb_caiaq_audio_disconnect(cdev);
 
-	usb_kill_urb(&cdev->ep1_in_urb);
-	usb_kill_urb(&cdev->midi_out_urb);
+	usb_kill_urb(cdev->ep1_in_urb);
+	usb_kill_urb(cdev->midi_out_urb);
 
 	snd_card_free_when_closed(card);
 }
diff --git a/sound/usb/caiaq/device.h b/sound/usb/caiaq/device.h
index 50fea085765b..5ad6cebd639c 100644
--- a/sound/usb/caiaq/device.h
+++ b/sound/usb/caiaq/device.h
@@ -60,8 +60,8 @@ struct snd_usb_caiaq_cb_info;
 struct snd_usb_caiaqdev {
 	struct snd_usb_audio chip;
 
-	struct urb ep1_in_urb;
-	struct urb midi_out_urb;
+	struct urb *ep1_in_urb;
+	struct urb *midi_out_urb;
 	struct urb **data_urbs_in;
 	struct urb **data_urbs_out;
 	struct snd_usb_caiaq_cb_info *data_cb_info;
diff --git a/sound/usb/caiaq/input.c b/sound/usb/caiaq/input.c
index 2db4d1332df1..c12eeb971000 100644
--- a/sound/usb/caiaq/input.c
+++ b/sound/usb/caiaq/input.c
@@ -203,6 +203,8 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *cdev,
 
 	switch (cdev->chip.usb_id) {
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL2):
+		if (len < 6)
+			return;
 		snd_caiaq_input_report_abs(cdev, ABS_X, buf, 2);
 		snd_caiaq_input_report_abs(cdev, ABS_Y, buf, 0);
 		snd_caiaq_input_report_abs(cdev, ABS_Z, buf, 1);
@@ -210,11 +212,15 @@ static void snd_caiaq_input_read_analog(struct snd_usb_caiaqdev *cdev,
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_RIGKONTROL3):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER):
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_KORECONTROLLER2):
+		if (len < 6)
+			return;
 		snd_caiaq_input_report_abs(cdev, ABS_X, buf, 0);
 		snd_caiaq_input_report_abs(cdev, ABS_Y, buf, 1);
 		snd_caiaq_input_report_abs(cdev, ABS_Z, buf, 2);
 		break;
 	case USB_ID(USB_VID_NATIVEINSTRUMENTS, USB_PID_TRAKTORKONTROLX1):
+		if (len < 16)
+			return;
 		snd_caiaq_input_report_abs(cdev, ABS_HAT0X, buf, 4);
 		snd_caiaq_input_report_abs(cdev, ABS_HAT0Y, buf, 2);
 		snd_caiaq_input_report_abs(cdev, ABS_HAT1X, buf, 6);
diff --git a/sound/usb/caiaq/midi.c b/sound/usb/caiaq/midi.c
index 512fbb3ee604..025fda784f75 100644
--- a/sound/usb/caiaq/midi.c
+++ b/sound/usb/caiaq/midi.c
@@ -43,7 +43,7 @@ static int snd_usb_caiaq_midi_output_close(struct snd_rawmidi_substream *substre
 {
 	struct snd_usb_caiaqdev *cdev = substream->rmidi->private_data;
 	if (cdev->midi_out_active) {
-		usb_kill_urb(&cdev->midi_out_urb);
+		usb_kill_urb(cdev->midi_out_urb);
 		cdev->midi_out_active = 0;
 	}
 	return 0;
@@ -64,9 +64,9 @@ static void snd_usb_caiaq_midi_send(struct snd_usb_caiaqdev *cdev,
 		return;
 
 	cdev->midi_out_buf[2] = len;
-	cdev->midi_out_urb.transfer_buffer_length = len+3;
+	cdev->midi_out_urb->transfer_buffer_length = len+3;
 
-	ret = usb_submit_urb(&cdev->midi_out_urb, GFP_ATOMIC);
+	ret = usb_submit_urb(cdev->midi_out_urb, GFP_ATOMIC);
 	if (ret < 0)
 		dev_err(dev,
 			"snd_usb_caiaq_midi_send(%p): usb_submit_urb() failed,"
diff --git a/sound/usb/mixer_maps.c b/sound/usb/mixer_maps.c
index 08082fdf8218..5e8c91c9f152 100644
--- a/sound/usb/mixer_maps.c
+++ b/sound/usb/mixer_maps.c
@@ -603,6 +603,16 @@ static const struct usbmix_ctl_map usbmix_ctl_maps[] = {
 		.id = USB_ID(0x1b1c, 0x0a42),
 		.map = corsair_virtuoso_map,
 	},
+	{
+		/* Corsair Virtuoso (wired mode, later revision) */
+		.id = USB_ID(0x1b1c, 0x0a43),
+		.map = corsair_virtuoso_map,
+	},
+	{
+		/* Corsair Virtuoso (wireless mode, later revision) */
+		.id = USB_ID(0x1b1c, 0x0a44),
+		.map = corsair_virtuoso_map,
+	},
 	{
 		/* Corsair HS80 RGB Wireless (wired mode) */
 		.id = USB_ID(0x1b1c, 0x0a6a),
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 119c0bde7446..3891952e1747 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -484,6 +484,20 @@ YAMAHA_DEVICE(0x105d, NULL),
 		}
 	}
 },
+{
+	USB_DEVICE(0x0499, 0x150d),
+	QUIRK_DRIVER_INFO {
+		/* .vendor_name = "Yamaha", */
+		/* .product_name = "CDS3000", */
+		QUIRK_DATA_COMPOSITE {
+			{ QUIRK_DATA_STANDARD_AUDIO(1) },
+			{ QUIRK_DATA_STANDARD_AUDIO(2) },
+			{ QUIRK_DATA_MIDI_YAMAHA(3) },
+			{ QUIRK_DATA_IGNORE(4) },
+			QUIRK_COMPOSITE_END
+		}
+	}
+},
 {
 	USB_DEVICE(0x0499, 0x1718),
 	QUIRK_DRIVER_INFO {
@@ -2814,6 +2828,14 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 		}
 	}
 },
+{
+	USB_DEVICE(0x1235, 0x001e),
+	QUIRK_DRIVER_INFO {
+		/* .vendor_name = "Novation", */
+		/* .product_name = "Mininova", */
+		QUIRK_DATA_RAW_BYTES(0)
+	}
+},
 {
 	USB_DEVICE_VENDOR_SPEC(0x1235, 0x4661),
 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index bccb47d38c6d..af92ebaf6e99 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -209,9 +209,12 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	mutex_lock(&us122l->mutex);
 	s = us122l->sk.s;
 	read = offset < s->read_size;
-	if (read && area->vm_flags & VM_WRITE) {
-		err = -EPERM;
-		goto out;
+	if (read) {
+		if (area->vm_flags & VM_WRITE) {
+			err = -EPERM;
+			goto out;
+		}
+		area->vm_flags &= ~VM_MAYWRITE;
 	}
 	snd_printdd(KERN_DEBUG "%lu %u\n", size,
 		    read ? s->read_size : s->write_size);
diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index ac584795606c..bb29f19eb6d1 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -180,7 +180,7 @@ static void i_usx2y_in04_int(struct urb *urb)
 	struct usx2ydev		*usx2y = urb->context;
 	struct us428ctls_sharedmem	*us428ctls = usx2y->us428ctls_sharedmem;
 	struct us428_p4out *p4out;
-	int i, j, n, diff, send;
+	int i, j, n, diff, send, len;
 
 	usx2y->in04_int_calls++;
 
@@ -223,24 +223,31 @@ static void i_usx2y_in04_int(struct urb *urb)
 			} while (!err && usx2y->us04->submitted < usx2y->us04->len);
 		}
 	} else {
-		if (us428ctls && us428ctls->p4out_last >= 0 && us428ctls->p4out_last < N_US428_P4OUT_BUFS) {
-			if (us428ctls->p4out_last != us428ctls->p4out_sent) {
-				send = us428ctls->p4out_sent + 1;
-				if (send >= N_US428_P4OUT_BUFS)
-					send = 0;
-				for (j = 0; j < URBS_ASYNC_SEQ && !err; ++j) {
-					if (!usx2y->as04.urb[j]->status) {
-						p4out = us428ctls->p4out + send;	// FIXME if more than 1 p4out is new, 1 gets lost.
-						usb_fill_bulk_urb(usx2y->as04.urb[j], usx2y->dev,
-								  usb_sndbulkpipe(usx2y->dev, 0x04), &p4out->val.vol,
-								  p4out->type == ELT_LIGHT ? sizeof(struct us428_lights) : 5,
-								  i_usx2y_out04_int, usx2y);
-						err = usb_submit_urb(usx2y->as04.urb[j], GFP_ATOMIC);
+		while (us428ctls &&
+		       us428ctls->p4out_last >= 0 &&
+		       us428ctls->p4out_last < N_US428_P4OUT_BUFS &&
+		       us428ctls->p4out_last != us428ctls->p4out_sent) {
+			for (j = 0; j < URBS_ASYNC_SEQ && !err; ++j) {
+				if (!usx2y->as04.urb[j]->status) {
+					send = us428ctls->p4out_sent + 1;
+					if (send >= N_US428_P4OUT_BUFS)
+						send = 0;
+
+					p4out = us428ctls->p4out + send;
+					len = p4out->type == ELT_LIGHT ?
+						sizeof(struct us428_lights) : 5;
+					memcpy(usx2y->as04.urb[j]->transfer_buffer,
+					       &p4out->val.vol, len);
+					usx2y->as04.urb[j]->transfer_buffer_length = len;
+					err = usb_submit_urb(usx2y->as04.urb[j], GFP_ATOMIC);
+					if (!err)
 						us428ctls->p4out_sent = send;
-						break;
-					}
+
+					break;
 				}
 			}
+			if (j >= URBS_ASYNC_SEQ || err)
+				break;
 		}
 	}
 
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 9a6e8db74c5f..2055d582a8a4 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1065,7 +1065,8 @@ cs_etm__get_trace(struct cs_etm_queue *etmq)
 	etmq->buf_used = 0;
 	etmq->buf_len = aux_buffer->size;
 	etmq->buf = aux_buffer->data;
-	return 0;
+
+	return etmq->buf_len;
 }
 
 static void cs_etm__set_pid_tid_cpu(struct cs_etm_auxtrace *etm,
@@ -1608,45 +1609,6 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq,
 
 	return 0;
 }
-
-static int cs_etm__flush_stack_cb(struct thread *thread,
-				  void *data __maybe_unused)
-{
-	thread_stack__flush(thread);
-	return 0;
-}
-
-static void cs_etm__flush_machine_stack(struct cs_etm_queue *etmq, pid_t pid)
-{
-	struct machine *machine;
-
-	machine = machines__find(&etmq->etm->session->machines, pid);
-	if (machine)
-		machine__for_each_thread(machine, cs_etm__flush_stack_cb, NULL);
-}
-
-static void cs_etm__flush_all_stack(struct cs_etm_queue *etmq)
-{
-	enum cs_etm_pid_fmt pid_fmt = cs_etm__get_pid_fmt(etmq);
-
-	if (!etmq->etm->synth_opts.last_branch)
-		return;
-
-	switch (pid_fmt) {
-	case CS_ETM_PIDFMT_CTXTID2:
-		/* Clear the guest stack if virtualization is supported */
-		cs_etm__flush_machine_stack(etmq, DEFAULT_GUEST_KERNEL_ID);
-		fallthrough;
-	case CS_ETM_PIDFMT_CTXTID:
-		cs_etm__flush_machine_stack(etmq, HOST_KERNEL_ID);
-		break;
-	case CS_ETM_PIDFMT_NONE:
-	default:
-		break;
-
-	}
-}
-
 /*
  * cs_etm__get_data_block: Fetch a block from the auxtrace_buffer queue
  *			   if need be.
@@ -1658,33 +1620,20 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
 {
 	int ret;
 
-	/* The current block is not finished */
-	if (etmq->buf_len)
-		return 1;
-
-	ret = cs_etm__get_trace(etmq);
-	if (ret < 0)
-		return ret;
-
-	/* No more buffer to read */
-	if (!etmq->buf_len)
-		return 0;
-
-	/*
-	 * We cannot assume consecutive blocks in the data file
-	 * are contiguous, reset the decoder to force re-sync.
-	 */
-	ret = cs_etm_decoder__reset(etmq->decoder);
-	if (ret)
-		return ret;
-
-	/*
-	 * Since the decoder is reset, this causes a global trace
-	 * discontinuity. Flush all thread stacks.
-	 */
-	cs_etm__flush_all_stack(etmq);
+	if (!etmq->buf_len) {
+		ret = cs_etm__get_trace(etmq);
+		if (ret <= 0)
+			return ret;
+		/*
+		 * We cannot assume consecutive blocks in the data file
+		 * are contiguous, reset the decoder to force re-sync.
+		 */
+		ret = cs_etm_decoder__reset(etmq->decoder);
+		if (ret)
+			return ret;
+	}
 
-	return 1;
+	return etmq->buf_len;
 }
 
 static bool cs_etm__is_svc_instr(struct cs_etm_queue *etmq, u8 trace_chan_id,
diff --git a/tools/testing/selftests/cgroup/test_kmem.c b/tools/testing/selftests/cgroup/test_kmem.c
index 0941aa16157e..3810dd798aeb 100644
--- a/tools/testing/selftests/cgroup/test_kmem.c
+++ b/tools/testing/selftests/cgroup/test_kmem.c
@@ -140,7 +140,7 @@ static int cg_run_in_subcgroups(const char *parent,
 			return -1;
 		}
 
-		if (cg_run(child, fn, NULL)) {
+		if (cg_run(child, fn, arg)) {
 			cg_destroy(child);
 			free(child);
 			return -1;
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
index bc9514428dba..07b1177c1634 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
@@ -6,7 +6,7 @@
 SYMBOL='name_show'
 
 # We skip this test on kernel where SYMBOL is unique or does not exist.
-if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}" /proc/kallsyms)" -le '1' ]; then
+if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
 	exit_unsupported
 fi
 
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index cdc7c0ff090f..bd9448be9dfe 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -405,6 +405,20 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 61 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
 
@@ -485,6 +499,20 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
diff --git a/tools/testing/selftests/net/pmtu.sh b/tools/testing/selftests/net/pmtu.sh
index f4116f0723e3..f0eccc936b28 100755
--- a/tools/testing/selftests/net/pmtu.sh
+++ b/tools/testing/selftests/net/pmtu.sh
@@ -1105,7 +1105,7 @@ test_pmtu_ipvX_over_bridged_vxlanY_or_geneveY_exception() {
 	mtu "${ns_b}" ${type}_b $((${ll_mtu} + 1000))
 
 	run_cmd ${ns_c} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
-	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -w 1  -s $((${ll_mtu} + 500)) ${dst} || return 1
+	run_cmd ${ns_a} ${ping} -q -M want -i 0.1 -c 10 -s $((${ll_mtu} + 500)) ${dst} || return 1
 
 	# Check that exceptions were created
 	pmtu="$(route_get_dst_pmtu_from_exception "${ns_c}" ${dst})"
diff --git a/tools/testing/selftests/powerpc/tm/tm.h b/tools/testing/selftests/powerpc/tm/tm.h
index c5a1e5c163fc..19d77c3a5706 100644
--- a/tools/testing/selftests/powerpc/tm/tm.h
+++ b/tools/testing/selftests/powerpc/tm/tm.h
@@ -69,8 +69,12 @@ static inline bool failure_is_nesting(void)
 static inline int tcheck(void)
 {
 	long cr;
-	asm volatile ("tcheck 0" : "=r"(cr) : : "cr0");
-	return (cr >> 28) & 4;
+	asm volatile("tcheck 0;"
+		     "mfcr %0;"
+		     : "=r"(cr)
+		     :
+		     : "cr0");
+	return (cr >> 28) & 0xf;
 }
 
 static inline bool tcheck_doomed(void)
