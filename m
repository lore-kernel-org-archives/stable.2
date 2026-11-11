Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410500;
	b=I1ddNcUBPHy5Hese26Q8R3vaQerHmX+iSeHkJjBt947X5/vzJwMNT/ht12dqFEYSJycC
	 kgvAt7HUp6IHQTbbHhAw3fPY5mQ4hz4H5dufgLT4AErZ4VLHjGHPL09RKi/KenQetH5ia
	 gR3Mf1NqixJpXmuEWbVBnD69aOk7TrQJ9KZIuMudnY7HNDDH7eWRR6Rw9JKj5PVoiB5s2
	 kbdnKfPv29qGVBeElnCCBgos6eoAjGaAsrFKjbeg8lfAYjTiuOPUNP/HQWSFjpbumCxW/
	 TVvt4vtRAWj7jZpRTiyP3wd5mPkWQXIHBHgR+STXzqsUn52b8D+YrfvKBz8kOY84kyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410500;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GPArO0mrg49sftABkRMXyC5qoluNGdoA73xdGW23tuY=;
	b=UdtyIkbFEMdlpcGmIkBu+htXTdGlzYpDqQBmLcYRtZ4ipED9YC76047MOnBwjI++2Bd2
	 +Sg3tjhWtWQXeqZImquwJc4Pc20zntjMc6zXD9bDAjEzMh/KJWnhwSomKq67CfUCKWwqN
	 I8sIkEMjs+AhjlyW/nsoju1YJ2LIigY8pdGANk/XQ3wLgzZ9vhm0yZ1LwxJ+owHbcnOkR
	 JJ52DA5QaCnLsSXFODDIChJcRgur4vAXg7+VylRCcecQVAfuGP6HeQcLDxkT/SqDNf8fA
	 QUrtvq7VpwuI2UBcG2rM+iUr6+yyBj48cQXYHztQEt+Kmtu2g4Om/bed4+2kYm4QQpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pto0Pvqa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B20606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pto0Pvqa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F611F00A05;
	Wed, 11 Nov 2026 15:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410499;
	bh=GPArO0mrg49sftABkRMXyC5qoluNGdoA73xdGW23tuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pto0PvqaRaug4cIWDCZIcmtnndpVjjXJLp9k77P1N3YkmAiXu1CuoF8wrXW5rVbjf
	 QvXnyTZxx2W2CL5yit6JTm4ZfSf4It9ojhtiEc4wQhJYhUdbufp8/i6NJSLV4H1jVL
	 ukT/SAWjDp66JREpCTqlXkjRLsRJ6tbaOHvbCWh9FiXpyUbuBC8B/88XGh1s7zMYjz
	 Ws5x4O9DwLOa2eU4foAQAcrNhHMIYMW3xXHFA2TVg6KSp5BkkvTAC1TOAQGHs0T3Rg
	 w83Xo7iXc/fWRFQw+V5u5nvoae2TJPmepyG3Od67MlIwHezlyJy4D8mYQi9c5Lx7PB
	 SuwY+024c4onw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] Documentation/kernel-parameters: Move the kernel build options
Date: Wed, 11 Nov 2026 10:21:36 -0500
Message-ID: <20261111152043.2571247-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051540-failed-6.18-799203afd298@kernel.org>
References: <20261107051540-failed-6.18-799203afd298@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

[ Upstream commit f690e07859e67505e7106ef5b4fae5e8b71b2109 ]

Move the kernel build options abbreviations to the .txt file so that
they are together instead of one having to go hunt them in the .rst
file.

Tweak the formatting so that the inclusion of kernel-parameters.txt
still keeps the whole thing somewhat presentable in the html output too.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Message-ID: <20251112114641.8230-1-bp@kernel.org>
Stable-dep-of: 799203afd298 ("nvme-tcp: validate the TLS handshake timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../admin-guide/kernel-parameters.rst         | 97 +-----------------
 .../admin-guide/kernel-parameters.txt         | 98 +++++++++++++++++++
 2 files changed, 99 insertions(+), 96 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 7bf8cc7df6b54..02a725536cc50 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -110,102 +110,7 @@ The parameters listed below are only valid if certain kernel build options
 were enabled and if respective hardware is present. This list should be kept
 in alphabetical order. The text in square brackets at the beginning
 of each description states the restrictions within which a parameter
-is applicable::
-
-	ACPI	ACPI support is enabled.
-	AGP	AGP (Accelerated Graphics Port) is enabled.
-	ALSA	ALSA sound support is enabled.
-	APIC	APIC support is enabled.
-	APM	Advanced Power Management support is enabled.
-	APPARMOR AppArmor support is enabled.
-	ARM	ARM architecture is enabled.
-	ARM64	ARM64 architecture is enabled.
-	AX25	Appropriate AX.25 support is enabled.
-	CLK	Common clock infrastructure is enabled.
-	CMA	Contiguous Memory Area support is enabled.
-	DRM	Direct Rendering Management support is enabled.
-	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
-	EARLY	Parameter processed too early to be embedded in initrd.
-	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
-	EFI	EFI Partitioning (GPT) is enabled
-	EVM	Extended Verification Module
-	FB	The frame buffer device is enabled.
-	FTRACE	Function tracing enabled.
-	GCOV	GCOV profiling is enabled.
-	HIBERNATION HIBERNATION is enabled.
-	HW	Appropriate hardware is enabled.
-	HYPER_V HYPERV support is enabled.
-	IMA     Integrity measurement architecture is enabled.
-	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
-	IPV6	IPv6 support is enabled.
-	ISAPNP	ISA PnP code is enabled.
-	ISDN	Appropriate ISDN support is enabled.
-	ISOL	CPU Isolation is enabled.
-	JOY	Appropriate joystick support is enabled.
-	KGDB	Kernel debugger support is enabled.
-	KVM	Kernel Virtual Machine support is enabled.
-	LIBATA  Libata driver is enabled
-	LOONGARCH LoongArch architecture is enabled.
-	LOOP	Loopback device support is enabled.
-	LP	Printer support is enabled.
-	M68k	M68k architecture is enabled.
-			These options have more detailed description inside of
-			Documentation/arch/m68k/kernel-options.rst.
-	MDA	MDA console support is enabled.
-	MIPS	MIPS architecture is enabled.
-	MOUSE	Appropriate mouse support is enabled.
-	MSI	Message Signaled Interrupts (PCI).
-	MTD	MTD (Memory Technology Device) support is enabled.
-	NET	Appropriate network support is enabled.
-	NFS	Appropriate NFS support is enabled.
-	NUMA	NUMA support is enabled.
-	OF	Devicetree is enabled.
-	PARISC	The PA-RISC architecture is enabled.
-	PCI	PCI bus support is enabled.
-	PCIE	PCI Express support is enabled.
-	PCMCIA	The PCMCIA subsystem is enabled.
-	PNP	Plug & Play support is enabled.
-	PPC	PowerPC architecture is enabled.
-	PPT	Parallel port support is enabled.
-	PS2	Appropriate PS/2 support is enabled.
-	PV_OPS	A paravirtualized kernel is enabled.
-	RAM	RAM disk support is enabled.
-	RDT	Intel Resource Director Technology.
-	RISCV	RISCV architecture is enabled.
-	S390	S390 architecture is enabled.
-	SCSI	Appropriate SCSI support is enabled.
-			A lot of drivers have their options described inside
-			the Documentation/scsi/ sub-directory.
-        SDW     SoundWire support is enabled.
-	SECURITY Different security models are enabled.
-	SELINUX SELinux support is enabled.
-	SERIAL	Serial support is enabled.
-	SH	SuperH architecture is enabled.
-	SMP	The kernel is an SMP kernel.
-	SPARC	Sparc architecture is enabled.
-	SUSPEND	System suspend states are enabled.
-	SWSUSP	Software suspend (hibernation) is enabled.
-	TPM	TPM drivers are enabled.
-	UMS	USB Mass Storage support is enabled.
-	USB	USB support is enabled.
-	USBHID	USB Human Interface Device support is enabled.
-	V4L	Video For Linux support is enabled.
-	VGA	The VGA console has been enabled.
-	VMMIO   Driver for memory mapped virtio devices is enabled.
-	VT	Virtual terminal support is enabled.
-	WDT	Watchdog support is enabled.
-	X86-32	X86-32, aka i386 architecture is enabled.
-	X86-64	X86-64 architecture is enabled.
-	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
-	X86_UV	SGI UV support is enabled.
-	XEN	Xen support is enabled
-	XTENSA	xtensa architecture is enabled.
-
-In addition, the following text indicates that the option::
-
-	BOOT	Is a boot loader parameter.
-	BUGS=	Relates to possible processor bugs on the said processor.
-	KNL	Is a kernel start-up parameter.
+is applicable.
 
 Parameters denoted with BOOT are actually interpreted by the boot
 loader, and have no meaning to the kernel directly.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 362ff32252209..5bf1df91607eb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1,3 +1,101 @@
+	ACPI	ACPI support is enabled.
+	AGP	AGP (Accelerated Graphics Port) is enabled.
+	ALSA	ALSA sound support is enabled.
+	APIC	APIC support is enabled.
+	APM	Advanced Power Management support is enabled.
+	APPARMOR AppArmor support is enabled.
+	ARM	ARM architecture is enabled.
+	ARM64	ARM64 architecture is enabled.
+	AX25	Appropriate AX.25 support is enabled.
+	CLK	Common clock infrastructure is enabled.
+	CMA	Contiguous Memory Area support is enabled.
+	DRM	Direct Rendering Management support is enabled.
+	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
+	EARLY	Parameter processed too early to be embedded in initrd.
+	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
+	EFI	EFI Partitioning (GPT) is enabled
+	EVM	Extended Verification Module
+	FB	The frame buffer device is enabled.
+	FTRACE	Function tracing enabled.
+	GCOV	GCOV profiling is enabled.
+	HIBERNATION HIBERNATION is enabled.
+	HW	Appropriate hardware is enabled.
+	HYPER_V HYPERV support is enabled.
+	IMA     Integrity measurement architecture is enabled.
+	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
+	IPV6	IPv6 support is enabled.
+	ISAPNP	ISA PnP code is enabled.
+	ISDN	Appropriate ISDN support is enabled.
+	ISOL	CPU Isolation is enabled.
+	JOY	Appropriate joystick support is enabled.
+	KGDB	Kernel debugger support is enabled.
+	KVM	Kernel Virtual Machine support is enabled.
+	LIBATA  Libata driver is enabled
+	LOONGARCH LoongArch architecture is enabled.
+	LOOP	Loopback device support is enabled.
+	LP	Printer support is enabled.
+	M68k	M68k architecture is enabled.
+			These options have more detailed description inside of
+			Documentation/arch/m68k/kernel-options.rst.
+	MDA	MDA console support is enabled.
+	MIPS	MIPS architecture is enabled.
+	MOUSE	Appropriate mouse support is enabled.
+	MSI	Message Signaled Interrupts (PCI).
+	MTD	MTD (Memory Technology Device) support is enabled.
+	NET	Appropriate network support is enabled.
+	NFS	Appropriate NFS support is enabled.
+	NUMA	NUMA support is enabled.
+	OF	Devicetree is enabled.
+	PARISC	The PA-RISC architecture is enabled.
+	PCI	PCI bus support is enabled.
+	PCIE	PCI Express support is enabled.
+	PCMCIA	The PCMCIA subsystem is enabled.
+	PNP	Plug & Play support is enabled.
+	PPC	PowerPC architecture is enabled.
+	PPT	Parallel port support is enabled.
+	PS2	Appropriate PS/2 support is enabled.
+	PV_OPS	A paravirtualized kernel is enabled.
+	RAM	RAM disk support is enabled.
+	RDT	Intel Resource Director Technology.
+	RISCV	RISCV architecture is enabled.
+	S390	S390 architecture is enabled.
+	SCSI	Appropriate SCSI support is enabled.
+			A lot of drivers have their options described inside
+			the Documentation/scsi/ sub-directory.
+        SDW     SoundWire support is enabled.
+	SECURITY Different security models are enabled.
+	SELINUX SELinux support is enabled.
+	SERIAL	Serial support is enabled.
+	SH	SuperH architecture is enabled.
+	SMP	The kernel is an SMP kernel.
+	SPARC	Sparc architecture is enabled.
+	SUSPEND	System suspend states are enabled.
+	SWSUSP	Software suspend (hibernation) is enabled.
+	TPM	TPM drivers are enabled.
+	UMS	USB Mass Storage support is enabled.
+	USB	USB support is enabled.
+	USBHID	USB Human Interface Device support is enabled.
+	V4L	Video For Linux support is enabled.
+	VGA	The VGA console has been enabled.
+	VMMIO   Driver for memory mapped virtio devices is enabled.
+	VT	Virtual terminal support is enabled.
+	WDT	Watchdog support is enabled.
+	X86-32	X86-32, aka i386 architecture is enabled.
+	X86-64	X86-64 architecture is enabled.
+	X86	Either 32-bit or 64-bit x86 (same as X86-32+X86-64)
+	X86_UV	SGI UV support is enabled.
+	XEN	Xen support is enabled
+	XTENSA	xtensa architecture is enabled.
+
+In addition, the following text indicates that the option
+
+	BOOT	Is a boot loader parameter.
+	BUGS=	Relates to possible processor bugs on the said processor.
+	KNL	Is a kernel start-up parameter.
+
+
+Kernel parameters
+
 	accept_memory=  [MM]
 			Format: { eager | lazy }
 			default: lazy
-- 
2.53.0

