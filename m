Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A412A3F58DF;
	Tue,  9 Jun 2026 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002405; cv=none; b=n1vvYPaaf4FveQhn7sxosTQWxxcMTywFgh0uMELCWtVBGSLCTUD0XoaW0IQ29tQnQ5ayqECJb8jwuF4i2faUQzrRxjkdE9MIA1xr9s7imPxnNwJC5f9f32HBXhyJLgKm4IdDLjh1w3kFtAonnBWgMU233FfenQihfQ8EQ+OaiuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002405; c=relaxed/simple;
	bh=kbxOrz8eTn/6KLJyT7KOpc/9f5sWAsKZETj8Hp6oymc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnD9jm9fc2HlhzCBM3DmpbsOx9pPqV4/0dDkkLEAFs9HhAb1plpxwGAcwYjDWI00OZ2u0EF8yLPYfAdW8VctWcJPna7K+Fm/Evs42gHWDWCZi2pj1z/b7Qyj1kfkSybONg72zKSZ5hQO+8WTyf39JjnmMHPwaRIib+4a5OMQTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LSxWzTSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LSxWzTSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6010A1F00898;
	Tue,  9 Jun 2026 10:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781002386;
	bh=An2mC0m3GolZ+pMVczK1SMU3RVZQJzOn67azx42GfJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSxWzTSi09RIWPHWJblE0Ney3KjNE1wwgBOmY4/0l+LrUWauArCoFDiTZqXaypJXE
	 +1KPw7ZW4MfCqYC9WDckpHjlWCo0+D0zlXwD+HP3R9nNfNorFO//oB9ZkwIyFk0DE2
	 c/9h30Hy3N7oBjZjg6P5SKiwAJbKy0O1+RyNCD1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.0.12
Date: Tue,  9 Jun 2026 12:51:55 +0200
Message-ID: <2026060955-giddy-shininess-42e6@gregkh>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <2026060955-finer-jokingly-c5e7@gregkh>
References: <2026060955-finer-jokingly-c5e7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
index 41c3b1b98991..658260619423 100644
--- a/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
+++ b/Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
@@ -41,12 +41,13 @@ properties:
       - const: usb_en
 
   resets:
-    maxItems: 2
+    maxItems: 3
 
   reset-names:
     items:
       - const: vaux
       - const: usb_rst
+      - const: usb_phy
 
   eswin,hsp-sp-csr:
     description:
@@ -85,8 +86,8 @@ examples:
         interrupt-parent = <&plic>;
         interrupts = <85>;
         interrupt-names = "peripheral";
-        resets = <&reset 84>, <&hspcrg 2>;
-        reset-names = "vaux", "usb_rst";
+        resets = <&reset 84>, <&hspcrg 2>, <&hspcrg 4>;
+        reset-names = "vaux", "usb_rst", "usb_phy";
         dr_mode = "peripheral";
         maximum-speed = "high-speed";
         phy_type = "utmi";
diff --git a/Documentation/netlink/genetlink-c.yaml b/Documentation/netlink/genetlink-c.yaml
index 57f59fe23e3f..4ea31e8fc4d1 100644
--- a/Documentation/netlink/genetlink-c.yaml
+++ b/Documentation/netlink/genetlink-c.yaml
@@ -69,6 +69,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/genetlink-legacy.yaml b/Documentation/netlink/genetlink-legacy.yaml
index 66fb8653a344..f9c44747729a 100644
--- a/Documentation/netlink/genetlink-legacy.yaml
+++ b/Documentation/netlink/genetlink-legacy.yaml
@@ -83,6 +83,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/Documentation/netlink/genetlink.yaml b/Documentation/netlink/genetlink.yaml
index b020a537d8ac..79f527974f1e 100644
--- a/Documentation/netlink/genetlink.yaml
+++ b/Documentation/netlink/genetlink.yaml
@@ -55,6 +55,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags ]
         doc:
diff --git a/Documentation/netlink/netlink-raw.yaml b/Documentation/netlink/netlink-raw.yaml
index 0166a7e4afbb..64a4340e6c36 100644
--- a/Documentation/netlink/netlink-raw.yaml
+++ b/Documentation/netlink/netlink-raw.yaml
@@ -81,6 +81,15 @@ properties:
         header:
           description: For C-compatible languages, header which already defines this value.
           type: string
+        scope:
+          description: |
+            Visibility of this definition. "uapi" (default) renders into
+            the uAPI header, "kernel" renders into the kernel-side
+            generated header, "user" renders into the user-side
+            generated header. When combined with `header:`, the
+            definition is not rendered, and the named header is
+            included only by code matching the scope.
+          enum: [ uapi, kernel, user ]
         type:
           enum: [ const, enum, flags, struct ] # Trim
         doc:
diff --git a/Documentation/netlink/specs/handshake.yaml b/Documentation/netlink/specs/handshake.yaml
index 95c3fade7a8d..1024297b3851 100644
--- a/Documentation/netlink/specs/handshake.yaml
+++ b/Documentation/netlink/specs/handshake.yaml
@@ -12,6 +12,12 @@ protocol: genetlink
 doc: Netlink protocol to request a transport layer security handshake.
 
 definitions:
+  -
+    type: const
+    name: max-errno
+    value: 4095
+    header: linux/err.h
+    scope: kernel
   -
     type: enum
     name: handler-class
@@ -80,6 +86,8 @@ attribute-sets:
       -
         name: status
         type: u32
+        checks:
+          max: max-errno
       -
         name: sockfd
         type: s32
diff --git a/Makefile b/Makefile
index d2a1c3a1ab44..7c25748018cb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 0
-SUBLEVEL = 11
+SUBLEVEL = 12
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 9d82f9a644cd..35622773969f 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -495,7 +495,6 @@ enum vcpu_sysreg {
 	ACTLR_EL2,	/* Auxiliary Control Register (EL2) */
 	CPTR_EL2,	/* Architectural Feature Trap Register (EL2) */
 	HACR_EL2,	/* Hypervisor Auxiliary Control Register */
-	ZCR_EL2,	/* SVE Control Register (EL2) */
 	TTBR0_EL2,	/* Translation Table Base Register 0 (EL2) */
 	TTBR1_EL2,	/* Translation Table Base Register 1 (EL2) */
 	TCR_EL2,	/* Translation Control Register (EL2) */
@@ -527,6 +526,7 @@ enum vcpu_sysreg {
 	SCTLR2_EL2,	/* System Control Register 2 (EL2) */
 	MDCR_EL2,	/* Monitor Debug Configuration Register (EL2) */
 	CNTHCTL_EL2,	/* Counter-timer Hypervisor Control register */
+	ZCR_EL2,	/* SVE Control Register (EL2) */
 
 	/* Any VNCR-capable reg goes after this point */
 	MARKER(__VNCR_START__),
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 8d762607285c..b3b863c919fe 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -53,7 +53,7 @@ static inline int tlb_get_level(struct mmu_gather *tlb)
 static inline void tlb_flush(struct mmu_gather *tlb)
 {
 	struct vm_area_struct vma = TLB_FLUSH_VMA(tlb->mm, 0);
-	bool last_level = !tlb->freed_tables;
+	bool last_level = !(tlb->freed_tables || tlb->unshared_tables);
 	unsigned long stride = tlb_get_unmap_size(tlb);
 	int tlb_level = tlb_get_level(tlb);
 
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 2597e8bda867..4ca856f6f5fb 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -431,11 +431,13 @@ static inline bool kvm_hyp_handle_mops(struct kvm_vcpu *vcpu, u64 *exit_code)
 
 static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 {
+	u64 zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
 	/*
 	 * The vCPU's saved SVE state layout always matches the max VL of the
 	 * vCPU. Start off with the max VL so we can load the SVE state.
 	 */
-	sve_cond_update_zcr_vq(vcpu_sve_max_vq(vcpu) - 1, SYS_ZCR_EL2);
+	sve_cond_update_zcr_vq(zcr_el2, SYS_ZCR_EL2);
 	__sve_restore_state(vcpu_sve_pffr(vcpu),
 			    &vcpu->arch.ctxt.fp_regs.fpsr,
 			    true);
@@ -445,8 +447,10 @@ static inline void __hyp_sve_restore_guest(struct kvm_vcpu *vcpu)
 	 * nested guest, as the guest hypervisor could select a smaller VL. Slap
 	 * that into hardware before wrapping up.
 	 */
-	if (is_nested_ctxt(vcpu))
-		sve_cond_update_zcr_vq(__vcpu_sys_reg(vcpu, ZCR_EL2), SYS_ZCR_EL2);
+	if (is_nested_ctxt(vcpu)) {
+		zcr_el2 = min(zcr_el2, __vcpu_sys_reg(vcpu, ZCR_EL2));
+		sve_cond_update_zcr_vq(zcr_el2, SYS_ZCR_EL2);
+	}
 
 	write_sysreg_el1(__vcpu_sys_reg(vcpu, vcpu_sve_zcr_elx(vcpu)), SYS_ZCR);
 }
@@ -470,11 +474,11 @@ static inline void fpsimd_lazy_switch_to_guest(struct kvm_vcpu *vcpu)
 		return;
 
 	if (vcpu_has_sve(vcpu)) {
+		zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+
 		/* A guest hypervisor may restrict the effective max VL. */
 		if (is_nested_ctxt(vcpu))
-			zcr_el2 = __vcpu_sys_reg(vcpu, ZCR_EL2);
-		else
-			zcr_el2 = vcpu_sve_max_vq(vcpu) - 1;
+			zcr_el2 = min(zcr_el2, __vcpu_sys_reg(vcpu, ZCR_EL2));
 
 		write_sysreg_el2(zcr_el2, SYS_ZCR);
 
diff --git a/arch/arm64/kvm/nested.c b/arch/arm64/kvm/nested.c
index 2c43097248b2..f7092e9a6fa2 100644
--- a/arch/arm64/kvm/nested.c
+++ b/arch/arm64/kvm/nested.c
@@ -89,21 +89,28 @@ int kvm_vcpu_init_nested(struct kvm_vcpu *vcpu)
 	 * again, and there is no reason to affect the whole VM for this.
 	 */
 	num_mmus = atomic_read(&kvm->online_vcpus) * S2_MMU_PER_VCPU;
-	tmp = kvrealloc(kvm->arch.nested_mmus,
-			size_mul(sizeof(*kvm->arch.nested_mmus), num_mmus),
-			GFP_KERNEL_ACCOUNT | __GFP_ZERO);
-	if (!tmp)
-		return -ENOMEM;
 
-	swap(kvm->arch.nested_mmus, tmp);
+	if (num_mmus > kvm->arch.nested_mmus_size) {
+		tmp = kvcalloc(num_mmus, sizeof(*tmp), GFP_KERNEL_ACCOUNT);
+		if (!tmp)
+			return -ENOMEM;
 
-	/*
-	 * If we went through a realocation, adjust the MMU back-pointers in
-	 * the previously initialised kvm_pgtable structures.
-	 */
-	if (kvm->arch.nested_mmus != tmp)
-		for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
-			kvm->arch.nested_mmus[i].pgt->mmu = &kvm->arch.nested_mmus[i];
+		write_lock(&kvm->mmu_lock);
+
+		if (kvm->arch.nested_mmus_size) {
+			memcpy(tmp, kvm->arch.nested_mmus,
+			       size_mul(sizeof(*tmp), kvm->arch.nested_mmus_size));
+
+			for (int i = 0; i < kvm->arch.nested_mmus_size; i++)
+				tmp[i].pgt->mmu = &tmp[i];
+		}
+
+		swap(kvm->arch.nested_mmus, tmp);
+
+		write_unlock(&kvm->mmu_lock);
+
+		kvfree(tmp);
+	}
 
 	for (int i = kvm->arch.nested_mmus_size; !ret && i < num_mmus; i++)
 		ret = init_nested_s2_mmu(kvm, &kvm->arch.nested_mmus[i]);
@@ -1825,6 +1832,11 @@ int kvm_init_nv_sysregs(struct kvm_vcpu *vcpu)
 	resx.res1 = VNCR_EL2_RES1;
 	set_sysreg_masks(kvm, VNCR_EL2, resx);
 
+	/* ZCR_EL2 - bits 8:4 are RAZ/WI so treat them as RES0 */
+	resx.res0 = ZCR_ELx_RES0 | GENMASK_ULL(8, 4);
+	resx.res1 = ZCR_ELx_RES1;
+	set_sysreg_masks(kvm, ZCR_EL2, resx);
+
 out:
 	for (enum vcpu_sysreg sr = __SANITISED_REG_START__; sr < NR_SYS_REGS; sr++)
 		__vcpu_rmw_sys_reg(vcpu, sr, |=, 0);
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 93cc9bbb5cec..5e7ead957ed6 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -174,8 +174,8 @@ static void kvm_pmu_set_pmc_value(struct kvm_pmc *pmc, u64 val, bool force)
 		 * action is to use PMCR.P, which will reset them to
 		 * 0 (the only use of the 'force' parameter).
 		 */
-		val  = __vcpu_sys_reg(vcpu, reg) & GENMASK(63, 32);
-		val |= lower_32_bits(val);
+		val = (__vcpu_sys_reg(vcpu, reg) & GENMASK(63, 32)) |
+		      lower_32_bits(val);
 	}
 
 	__vcpu_assign_sys_reg(vcpu, reg, val);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 1b4cacb6e918..9d980ad6e7c5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -2764,21 +2764,16 @@ static bool access_zcr_el2(struct kvm_vcpu *vcpu,
 			   struct sys_reg_params *p,
 			   const struct sys_reg_desc *r)
 {
-	unsigned int vq;
-
 	if (guest_hyp_sve_traps_enabled(vcpu)) {
 		kvm_inject_nested_sve_trap(vcpu);
 		return false;
 	}
 
-	if (!p->is_write) {
+	if (!p->is_write)
 		p->regval = __vcpu_sys_reg(vcpu, ZCR_EL2);
-		return true;
-	}
+	else
+		__vcpu_assign_sys_reg(vcpu, ZCR_EL2, p->regval);
 
-	vq = SYS_FIELD_GET(ZCR_ELx, LEN, p->regval) + 1;
-	vq = min(vq, vcpu_sve_max_vq(vcpu));
-	__vcpu_assign_sys_reg(vcpu, ZCR_EL2, vq - 1);
 	return true;
 }
 
diff --git a/arch/arm64/kvm/vgic/vgic-its.c b/arch/arm64/kvm/vgic/vgic-its.c
index 1d7e5d560af4..1e3706ac3b8e 100644
--- a/arch/arm64/kvm/vgic/vgic-its.c
+++ b/arch/arm64/kvm/vgic/vgic-its.c
@@ -597,8 +597,10 @@ static void vgic_its_invalidate_cache(struct vgic_its *its)
 	unsigned long idx;
 
 	xa_for_each(&its->translation_cache, idx, irq) {
-		xa_erase(&its->translation_cache, idx);
-		vgic_put_irq(kvm, irq);
+		/* Only the context that erases the entry drops its cache ref. */
+		irq = xa_erase(&its->translation_cache, idx);
+		if (irq)
+			vgic_put_irq(kvm, irq);
 	}
 }
 
diff --git a/arch/mips/dec/platform.c b/arch/mips/dec/platform.c
index c4fcb8c58e01..723ce16cbfc0 100644
--- a/arch/mips/dec/platform.c
+++ b/arch/mips/dec/platform.c
@@ -10,6 +10,14 @@
 #include <linux/mc146818rtc.h>
 #include <linux/platform_device.h>
 
+#include <asm/bootinfo.h>
+
+#include <asm/dec/interrupts.h>
+#include <asm/dec/ioasic_addrs.h>
+#include <asm/dec/kn01.h>
+#include <asm/dec/kn02.h>
+#include <asm/dec/system.h>
+
 static struct resource dec_rtc_resources[] = {
 	{
 		.name = "rtc",
@@ -30,11 +38,110 @@ static struct platform_device dec_rtc_device = {
 	.num_resources = ARRAY_SIZE(dec_rtc_resources),
 };
 
+static struct resource dec_dz_resources[] = {
+	{ .name = "dz", .flags = IORESOURCE_MEM, },
+	{ .name = "dz", .flags = IORESOURCE_IRQ, },
+};
+
+static struct platform_device dec_dz_device = {
+	.name = "dz",
+	.id = PLATFORM_DEVID_NONE,
+	.resource = dec_dz_resources,
+	.num_resources = ARRAY_SIZE(dec_dz_resources),
+};
+
+static struct platform_device *dec_dz_devices[] __initdata = {
+	&dec_dz_device,
+};
+
+static struct resource dec_zs_resources[][2] = {
+	{
+		{ .name = "scc0", .flags = IORESOURCE_MEM, },
+		{ .name = "scc0", .flags = IORESOURCE_IRQ, },
+	},
+	{
+		{ .name = "scc1", .flags = IORESOURCE_MEM, },
+		{ .name = "scc1", .flags = IORESOURCE_IRQ, },
+	},
+};
+
+static struct platform_device dec_zs_device[] = {
+	{
+		.name = "zs",
+		.id = 0,
+		.resource = dec_zs_resources[0],
+		.num_resources = ARRAY_SIZE(dec_zs_resources[0]),
+	},
+	{
+		.name = "zs",
+		.id = 1,
+		.resource = dec_zs_resources[1],
+		.num_resources = ARRAY_SIZE(dec_zs_resources[1]),
+	},
+};
+
 static int __init dec_add_devices(void)
 {
+	struct platform_device *dec_zs_devices[ARRAY_SIZE(dec_zs_device)];
+	int ret1, ret2, ret3;
+	int num_dz, num_zs;
+	int irq, i;
+
 	dec_rtc_resources[0].start = RTC_PORT(0);
 	dec_rtc_resources[0].end = RTC_PORT(0) + dec_kn_slot_size - 1;
-	return platform_device_register(&dec_rtc_device);
+
+	i = 0;
+	irq = dec_interrupt[DEC_IRQ_DZ11];
+	if (IS_ENABLED(CONFIG_32BIT) && irq >= 0) {
+		resource_size_t base;
+
+		switch (mips_machtype) {
+		case MACH_DS23100:
+		case MACH_DS5100:
+			base = dec_kn_slot_base + KN01_DZ11;
+			break;
+		default:
+			base = dec_kn_slot_base + KN02_DZ11;
+			break;
+		}
+		dec_dz_device.resource[0].start = base;
+		dec_dz_device.resource[0].end = base + dec_kn_slot_size - 1;
+		dec_dz_device.resource[1].start = irq;
+		dec_dz_device.resource[1].end = irq;
+		i++;
+	}
+	num_dz = i;
+
+	i = 0;
+	irq = dec_interrupt[DEC_IRQ_SCC0];
+	if (irq >= 0) {
+		resource_size_t base = dec_kn_slot_base + IOASIC_SCC0;
+
+		dec_zs_device[i].resource[0].start = base;
+		dec_zs_device[i].resource[0].end = base + dec_kn_slot_size - 1;
+		dec_zs_device[i].resource[1].start = irq;
+		dec_zs_device[i].resource[1].end = irq;
+		dec_zs_devices[i] = &dec_zs_device[i];
+		i++;
+	}
+	irq = dec_interrupt[DEC_IRQ_SCC1];
+	if (irq >= 0) {
+		resource_size_t base = dec_kn_slot_base + IOASIC_SCC1;
+
+		dec_zs_device[i].resource[0].start = base;
+		dec_zs_device[i].resource[0].end = base + dec_kn_slot_size - 1;
+		dec_zs_device[i].resource[1].start = irq;
+		dec_zs_device[i].resource[1].end = irq;
+		dec_zs_devices[i] = &dec_zs_device[i];
+		i++;
+	}
+	num_zs = i;
+
+	ret1 = platform_device_register(&dec_rtc_device);
+	ret2 = IS_ENABLED(CONFIG_32BIT) ?
+	       platform_add_devices(dec_dz_devices, num_dz) : 0;
+	ret3 = platform_add_devices(dec_zs_devices, num_zs);
+	return ret1 ? ret1 : ret2 ? ret2 : ret3;
 }
 
 device_initcall(dec_add_devices);
diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index ac80216549ff..226289c3b5c8 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -32,6 +32,10 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
 	__diag_push();									\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",					\
 			"Type aliasing is used to sanitize syscall arguments");		\
+	__diag_ignore(clang, 23, "-Wunknown-warning-option",				\
+		      "Avoid breaking versions without -Wattribute-alias");		\
+	__diag_ignore(clang, 23, "-Wattribute-alias",					\
+			"Type aliasing is used to sanitize syscall arguments");		\
 	static long __se_##prefix##name(ulong, ulong, ulong, ulong, ulong, ulong, 	\
 					ulong)						\
 			__attribute__((alias(__stringify(___se_##prefix##name))));	\
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index c3ec2512f2bb..20b638c507ca 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -27,14 +27,19 @@
 static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 					    struct _fpx_sw_bytes *fx_sw)
 {
+	int min_xstate_size = sizeof(struct fxregs_state) +
+			      sizeof(struct xstate_header);
 	void __user *fpstate = fxbuf;
 	unsigned int magic2;
 
 	if (__copy_from_user(fx_sw, &fxbuf->sw_reserved[0], sizeof(*fx_sw)))
 		return false;
 
-	/* Check for the first magic field */
-	if (fx_sw->magic1 != FP_XSTATE_MAGIC1)
+	/* Check for the first magic field and other error scenarios. */
+	if (fx_sw->magic1 != FP_XSTATE_MAGIC1 ||
+	    fx_sw->xstate_size < min_xstate_size ||
+	    fx_sw->xstate_size > x86_task_fpu(current)->fpstate->user_size ||
+	    fx_sw->xstate_size > fx_sw->extended_size)
 		goto setfx;
 
 	/*
@@ -43,7 +48,7 @@ static inline bool check_xstate_in_sigframe(struct fxregs_state __user *fxbuf,
 	 * fpstate layout with out copying the extended state information
 	 * in the memory layout.
 	 */
-	if (__get_user(magic2, (__u32 __user *)(fpstate + x86_task_fpu(current)->fpstate->user_size)))
+	if (__get_user(magic2, (__u32 __user *)(fpstate + fx_sw->xstate_size)))
 		return false;
 
 	if (likely(magic2 == FP_XSTATE_MAGIC2))
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index 0543b57f54ee..17d6edfcb7e0 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -375,6 +375,13 @@ create_trampoline(struct ftrace_ops *ops, unsigned int *tramp_size)
 			goto fail;
 	}
 
+	/*
+	 * Generated trampoline may contain rIP-relative addressing which
+	 * displacement needs to be fixed.
+	 */
+	text_poke_apply_relocation(trampoline, trampoline, size,
+				   (void *)start_offset, size);
+
 	/*
 	 * The address of the ftrace_ops that is used for this trampoline
 	 * is stored at the end of the trampoline. This will be used to
diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
index 02beb15d7428..b95d2117e427 100644
--- a/arch/x86/kvm/svm/avic.c
+++ b/arch/x86/kvm/svm/avic.c
@@ -195,6 +195,35 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 
 	svm_clr_intercept(svm, INTERCEPT_CR8_WRITE);
 
+	/*
+	 * Flush the TLB when enabling (x2)AVIC and when transitioning between
+	 * xAVIC and x2AVIC, as the CPU may have inserted a TLB entry for the
+	 * "wrong" mapping.
+	 *
+	 * KVM uses a per-VM "scratch" page to back the APIC memslot, because
+	 * KVM also uses per-VM page tables *and* maintains the page table (NPT
+	 * or shadow page) mappings for said memslot even if one or more vCPUs
+	 * have their local APIC hardware-disabled or are in x2APIC mode, i.e.
+	 * even if one or more vCPUs' APIC MMIO BAR is effectively disabled.
+	 *
+	 * If xAVIC is fully enabled, hardware ignores the physical address in
+	 * KVM's page tables, i.e. in the leaf SPTE for the APIC memslot, and
+	 * instead redirects the access to the AVIC backing page, i.e. to the
+	 * vCPU's virtual APIC page.  If xAVIC is not enabled (APIC is either
+	 * hardware-disabled or in x2APIC mode), then guest accesses will use
+	 * the page table mapping verbatim, i.e. will access the per-VM scratch
+	 * page, as normal memory.
+	 *
+	 * In both cases, the CPU is allowed to cache TLB entries for the APIC
+	 * base GPA.  So, KVM needs to flush the TLB when enabling xAVIC, as
+	 * accesses need to be redirected to the virtual APIC page, but the TLB
+	 * may contain entries pointing at the scratch page.  KVM also needs to
+	 * flush the TLB when enabling x2AVIC, as accesses need to go to the
+	 * scratch page, but the TLB may contain entries tagged as xAVIC, i.e.
+	 * entries pointing to the vCPU's virtual APIC page.
+	 */
+	kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
+
 	/*
 	 * Note: KVM supports hybrid-AVIC mode, where KVM emulates x2APIC MSR
 	 * accesses, while interrupt injection to a running vCPU can be
@@ -208,12 +237,6 @@ static void avic_activate_vmcb(struct vcpu_svm *svm)
 		/* Disabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, false);
 	} else {
-		/*
-		 * Flush the TLB, the guest may have inserted a non-APIC
-		 * mapping into the TLB while AVIC was disabled.
-		 */
-		kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, &svm->vcpu);
-
 		/* Enabling MSR intercept for x2APIC registers */
 		avic_set_x2apic_msr_interception(svm, true);
 	}
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index fb278fb1652d..2a4ce7ca1415 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -3617,23 +3617,26 @@ int pre_sev_run(struct vcpu_svm *svm, int cpu)
 }
 
 #define GHCB_SCRATCH_AREA_LIMIT		(16ULL * PAGE_SIZE)
-static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
+static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 min_len)
 {
 	struct vmcb_control_area *control = &svm->vmcb->control;
 	u64 ghcb_scratch_beg, ghcb_scratch_end;
 	u64 scratch_gpa_beg, scratch_gpa_end;
 	void *scratch_va;
 
+	if (WARN_ON_ONCE(!min_len))
+		goto e_scratch;
+
 	scratch_gpa_beg = svm->sev_es.sw_scratch;
 	if (!scratch_gpa_beg) {
 		pr_err("vmgexit: scratch gpa not provided\n");
 		goto e_scratch;
 	}
 
-	scratch_gpa_end = scratch_gpa_beg + len;
+	scratch_gpa_end = scratch_gpa_beg + min_len;
 	if (scratch_gpa_end < scratch_gpa_beg) {
 		pr_err("vmgexit: scratch length (%#llx) not valid for scratch address (%#llx)\n",
-		       len, scratch_gpa_beg);
+		       min_len, scratch_gpa_beg);
 		goto e_scratch;
 	}
 
@@ -3657,21 +3660,27 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 
 		scratch_va = (void *)svm->sev_es.ghcb;
 		scratch_va += (scratch_gpa_beg - control->ghcb_gpa);
+
+		svm->sev_es.ghcb_sa_len = ghcb_scratch_end - scratch_gpa_beg;
 	} else {
+		/* GHCB v2 requires the scratch area to be within the GHCB. */
+		if (to_kvm_sev_info(svm->vcpu.kvm)->ghcb_version >= 2)
+			goto e_scratch;
+
 		/*
 		 * The guest memory must be read into a kernel buffer, so
 		 * limit the size
 		 */
-		if (len > GHCB_SCRATCH_AREA_LIMIT) {
+		if (min_len > GHCB_SCRATCH_AREA_LIMIT) {
 			pr_err("vmgexit: scratch area exceeds KVM limits (%#llx requested, %#llx limit)\n",
-			       len, GHCB_SCRATCH_AREA_LIMIT);
+			       min_len, GHCB_SCRATCH_AREA_LIMIT);
 			goto e_scratch;
 		}
-		scratch_va = kvzalloc(len, GFP_KERNEL_ACCOUNT);
+		scratch_va = kvzalloc(min_len, GFP_KERNEL_ACCOUNT);
 		if (!scratch_va)
 			return -ENOMEM;
 
-		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, len)) {
+		if (kvm_read_guest(svm->vcpu.kvm, scratch_gpa_beg, scratch_va, min_len)) {
 			/* Unable to copy scratch area from guest */
 			pr_err("vmgexit: kvm_read_guest for scratch area failed\n");
 
@@ -3687,11 +3696,10 @@ static int setup_vmgexit_scratch(struct vcpu_svm *svm, bool sync, u64 len)
 		 */
 		svm->sev_es.ghcb_sa_sync = sync;
 		svm->sev_es.ghcb_sa_free = true;
+		svm->sev_es.ghcb_sa_len = min_len;
 	}
 
 	svm->sev_es.ghcb_sa = scratch_va;
-	svm->sev_es.ghcb_sa_len = len;
-
 	return 0;
 
 e_scratch:
@@ -3788,7 +3796,7 @@ struct psc_buffer {
 	struct psc_entry entries[];
 } __packed;
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc);
+static int snp_begin_psc(struct vcpu_svm *svm);
 
 static void snp_complete_psc(struct vcpu_svm *svm, u64 psc_ret)
 {
@@ -3819,9 +3827,9 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 	 */
 	for (idx = svm->sev_es.psc_idx; svm->sev_es.psc_inflight;
 	     svm->sev_es.psc_inflight--, idx++) {
-		struct psc_entry *entry = &entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
-		entry->cur_page = entry->pagesize ? 512 : 1;
+		entries[idx].cur_page = entry.pagesize ? 512 : 1;
 	}
 
 	hdr->cur_entry = idx;
@@ -3830,7 +3838,6 @@ static void __snp_complete_one_psc(struct vcpu_svm *svm)
 static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
-	struct psc_buffer *psc = svm->sev_es.ghcb_sa;
 
 	if (vcpu->run->hypercall.ret) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
@@ -3840,16 +3847,18 @@ static int snp_complete_one_psc(struct kvm_vcpu *vcpu)
 	__snp_complete_one_psc(svm);
 
 	/* Handle the next range (if any). */
-	return snp_begin_psc(svm, psc);
+	return snp_begin_psc(svm);
 }
 
-static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
+static int snp_begin_psc(struct vcpu_svm *svm)
 {
+	struct vcpu_sev_es_state *sev_es = &svm->sev_es;
+	struct psc_buffer *psc = sev_es->ghcb_sa;
 	struct psc_entry *entries = psc->entries;
 	struct kvm_vcpu *vcpu = &svm->vcpu;
 	struct psc_hdr *hdr = &psc->hdr;
 	struct psc_entry entry_start;
-	u16 idx, idx_start, idx_end;
+	u16 idx, idx_start, idx_end, max_nr_entries;
 	int npages;
 	bool huge;
 	u64 gfn;
@@ -3859,6 +3868,19 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
 		return 1;
 	}
 
+	/*
+	 * GHCB v2 requires the scratch area to reside within the GHCB itself,
+	 * and PSC requests are only supported for GHCB v2+.  Thus it should be
+	 * impossible to exceed the max PSC entry count (which is derived from
+	 * the size of the shared GHCB buffer).
+	 */
+	max_nr_entries = (sev_es->ghcb_sa_len - sizeof(struct psc_hdr)) /
+			 sizeof(struct psc_entry);
+	if (WARN_ON_ONCE(max_nr_entries > VMGEXIT_PSC_MAX_COUNT)) {
+		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_GENERIC);
+		return 1;
+	}
+
 next_range:
 	/* There should be no other PSCs in-flight at this point. */
 	if (WARN_ON_ONCE(svm->sev_es.psc_inflight)) {
@@ -3871,17 +3893,17 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
 	 * validation, so take care to only use validated copies of values used
 	 * for things like array indexing.
 	 */
-	idx_start = hdr->cur_entry;
-	idx_end = hdr->end_entry;
+	idx_start = READ_ONCE(hdr->cur_entry);
+	idx_end = READ_ONCE(hdr->end_entry);
 
-	if (idx_end >= VMGEXIT_PSC_MAX_COUNT) {
+	if (idx_end >= max_nr_entries) {
 		snp_complete_psc(svm, VMGEXIT_PSC_ERROR_INVALID_HDR);
 		return 1;
 	}
 
 	/* Find the start of the next range which needs processing. */
 	for (idx = idx_start; idx <= idx_end; idx++, hdr->cur_entry++) {
-		entry_start = entries[idx];
+		entry_start = READ_ONCE(entries[idx]);
 
 		gfn = entry_start.gfn;
 		huge = entry_start.pagesize;
@@ -3925,7 +3947,7 @@ static int snp_begin_psc(struct vcpu_svm *svm, struct psc_buffer *psc)
 	 * KVM_HC_MAP_GPA_RANGE exit.
 	 */
 	while (++idx <= idx_end) {
-		struct psc_entry entry = entries[idx];
+		struct psc_entry entry = READ_ONCE(entries[idx]);
 
 		if (entry.operation != entry_start.operation ||
 		    entry.gfn != entry_start.gfn + npages ||
@@ -4515,11 +4537,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 		vcpu->run->system_event.data[0] = control->ghcb_gpa;
 		break;
 	case SVM_VMGEXIT_PSC:
-		ret = setup_vmgexit_scratch(svm, true, control->exit_info_2);
+		ret = setup_vmgexit_scratch(svm, true, sizeof(struct psc_hdr));
 		if (ret)
 			break;
 
-		ret = snp_begin_psc(svm, svm->sev_es.ghcb_sa);
+		ret = snp_begin_psc(svm);
 		break;
 	case SVM_VMGEXIT_AP_CREATION:
 		ret = sev_snp_ap_creation(svm);
@@ -4541,6 +4563,11 @@ int sev_handle_vmgexit(struct kvm_vcpu *vcpu)
 			    control->exit_info_1, control->exit_info_2);
 		ret = -EINVAL;
 		break;
+	case SVM_EXIT_IOIO:
+		if (!((control->exit_info_1 & SVM_IOIO_SIZE_MASK) >> SVM_IOIO_SIZE_SHIFT))
+			return 1;
+
+		fallthrough;
 	default:
 		ret = svm_invoke_exit_handler(vcpu, control->exit_code);
 	}
@@ -4561,6 +4588,9 @@ int sev_es_string_io(struct vcpu_svm *svm, int size, unsigned int port, int in)
 	if (unlikely(check_mul_overflow(count, size, &bytes)))
 		return -EINVAL;
 
+	if (!bytes)
+		return 1;
+
 	r = setup_vmgexit_scratch(svm, in, bytes);
 	if (r)
 		return r;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 39986a742b98..061c8ef4484a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3244,7 +3244,7 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!rq)
 		blk_queue_exit(q);
 	else
-		blk_mq_free_request(rq);
+		rq_list_add_head(&plug->cached_rqs, rq);
 }
 
 #ifdef CONFIG_BLK_MQ_STACKING
diff --git a/drivers/accel/ivpu/ivpu_debugfs.c b/drivers/accel/ivpu/ivpu_debugfs.c
index a09f54fc4302..e93883914bc2 100644
--- a/drivers/accel/ivpu/ivpu_debugfs.c
+++ b/drivers/accel/ivpu/ivpu_debugfs.c
@@ -440,7 +440,7 @@ priority_bands_fops_write(struct file *file, const char __user *user_buf, size_t
 	u32 band;
 	int ret;
 
-	if (size >= sizeof(buf))
+	if (*pos != 0 || size >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, pos, user_buf, size);
diff --git a/drivers/accel/rocket/rocket_gem.c b/drivers/accel/rocket/rocket_gem.c
index c8084719208a..a5fffa51ff35 100644
--- a/drivers/accel/rocket/rocket_gem.c
+++ b/drivers/accel/rocket/rocket_gem.c
@@ -79,11 +79,6 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	rkt_obj->size = args->size;
 	rkt_obj->offset = 0;
 
-	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
-	drm_gem_object_put(gem_obj);
-	if (ret)
-		goto err;
-
 	sgt = drm_gem_shmem_get_pages_sgt(shmem_obj);
 	if (IS_ERR(sgt)) {
 		ret = PTR_ERR(sgt);
@@ -95,6 +90,8 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 					 rkt_obj->size, PAGE_SIZE,
 					 0, 0);
 	mutex_unlock(&rocket_priv->mm_lock);
+	if (ret)
+		goto err;
 
 	ret = iommu_map_sgtable(rocket_priv->domain->domain,
 				rkt_obj->mm.start,
@@ -112,8 +109,18 @@ int rocket_ioctl_create_bo(struct drm_device *dev, void *data, struct drm_file *
 	args->offset = drm_vma_node_offset_addr(&gem_obj->vma_node);
 	args->dma_address = rkt_obj->mm.start;
 
+	ret = drm_gem_handle_create(file, gem_obj, &args->handle);
+	if (ret)
+		goto err_unmap;
+
+	drm_gem_object_put(gem_obj);
+
 	return 0;
 
+err_unmap:
+	iommu_unmap(rocket_priv->domain->domain,
+		    rkt_obj->mm.start, rkt_obj->size);
+
 err_remove_node:
 	mutex_lock(&rocket_priv->mm_lock);
 	drm_mm_remove_node(&rkt_obj->mm);
diff --git a/drivers/acpi/acpica/evxfgpe.c b/drivers/acpi/acpica/evxfgpe.c
index 60dacec1b121..4074b5908db3 100644
--- a/drivers/acpi/acpica/evxfgpe.c
+++ b/drivers/acpi/acpica/evxfgpe.c
@@ -78,18 +78,22 @@ ACPI_EXPORT_SYMBOL(acpi_update_all_gpes)
 
 /*******************************************************************************
  *
- * FUNCTION:    acpi_enable_gpe
+ * FUNCTION:    acpi_enable_gpe_cond
  *
  * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
  *              gpe_number          - GPE level within the GPE block
+ *              dispatch_type       - GPE dispatch type to match
  *
  * RETURN:      Status
  *
- * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
- *              hardware-enabled.
+ * DESCRIPTION: Add a reference to a GPE so long as its dispatch type matches
+ *              the supplied one, or it is different from ACPI_GPE_DISPATCH_NONE
+ *              if the supplied one is ACPI_GPE_DISPATCH_MASK. On the first
+ *              reference, the GPE is hardware-enabled.
  *
  ******************************************************************************/
-acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+acpi_status acpi_enable_gpe_cond(acpi_handle gpe_device, u32 gpe_number,
+				 u8 dispatch_type)
 {
 	acpi_status status = AE_BAD_PARAMETER;
 	struct acpi_gpe_event_info *gpe_event_info;
@@ -100,14 +104,18 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
 
 	/*
-	 * Ensure that we have a valid GPE number and that there is some way
-	 * of handling the GPE (handler or a GPE method). In other words, we
-	 * won't allow a valid GPE to be enabled if there is no way to handle it.
+	 * Ensure that we have a valid GPE number and that the dispatch type of
+	 * the GPE matches the supplied one (or it is not ACPI_GPE_DISPATCH_NONE
+	 * if the supplied one is ACPI_GPE_DISPATCH_MASK).
 	 */
 	gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
 	if (gpe_event_info) {
-		if (ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags) !=
-		    ACPI_GPE_DISPATCH_NONE) {
+		if (dispatch_type == ACPI_GPE_DISPATCH_MASK)
+			dispatch_type = ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags);
+		else if (dispatch_type != ACPI_GPE_DISPATCH_TYPE(gpe_event_info->flags))
+			dispatch_type = ACPI_GPE_DISPATCH_NONE;
+
+		if (dispatch_type != ACPI_GPE_DISPATCH_NONE) {
 			status = acpi_ev_add_gpe_reference(gpe_event_info, TRUE);
 			if (ACPI_SUCCESS(status) &&
 			    ACPI_GPE_IS_POLLING_NEEDED(gpe_event_info)) {
@@ -128,6 +136,30 @@ acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
 	acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
 	return_ACPI_STATUS(status);
 }
+ACPI_EXPORT_SYMBOL(acpi_enable_gpe_cond)
+
+/*******************************************************************************
+ *
+ * FUNCTION:    acpi_enable_gpe
+ *
+ * PARAMETERS:  gpe_device          - Parent GPE Device. NULL for GPE0/GPE1
+ *              gpe_number          - GPE level within the GPE block
+ *
+ * RETURN:      Status
+ *
+ * DESCRIPTION: Add a reference to a GPE. On the first reference, the GPE is
+ *              hardware-enabled.
+ *
+ ******************************************************************************/
+acpi_status acpi_enable_gpe(acpi_handle gpe_device, u32 gpe_number)
+{
+	/*
+	 * Ensure that there is some way of handling the GPE (handler or a GPE
+	 * method). In other words, we won't allow a valid GPE to be enabled if
+	 * there is no way to handle it.
+	 */
+	return acpi_enable_gpe_cond(gpe_device, gpe_number, ACPI_GPE_DISPATCH_MASK);
+}
 ACPI_EXPORT_SYMBOL(acpi_enable_gpe)
 
 /*******************************************************************************
diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
index ff30f993b150..0ddbcfd0b104 100644
--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -179,6 +179,7 @@ struct acpi_button {
 	ktime_t last_time;
 	bool suspended;
 	bool lid_state_initialized;
+	bool gpe_enabled;
 };
 
 static struct acpi_device *lid_device;
@@ -647,6 +648,21 @@ static int acpi_button_probe(struct platform_device *pdev)
 		status = acpi_install_notify_handler(device->handle,
 						     ACPI_ALL_NOTIFY, handler,
 						     button);
+		if (ACPI_SUCCESS(status) && device->wakeup.flags.valid) {
+			acpi_status st;
+
+			/*
+			 * If the wakeup GPE has a handler method, enable it in
+			 * case it is also used for signaling runtime events.
+			 */
+			st = acpi_enable_gpe_cond(device->wakeup.gpe_device,
+						   device->wakeup.gpe_number,
+						   ACPI_GPE_DISPATCH_METHOD);
+			button->gpe_enabled = ACPI_SUCCESS(st);
+			if (button->gpe_enabled)
+				dev_dbg(button->dev, "Enabled ACPI GPE%02llx\n",
+					device->wakeup.gpe_number);
+		}
 		break;
 	}
 	if (ACPI_FAILURE(status)) {
@@ -690,7 +706,13 @@ static void acpi_button_remove(struct platform_device *pdev)
 						acpi_button_event);
 		break;
 	default:
-		acpi_remove_notify_handler(adev->handle, ACPI_DEVICE_NOTIFY,
+		if (button->gpe_enabled) {
+			dev_dbg(button->dev, "Disabling ACPI GPE%02llx\n",
+				adev->wakeup.gpe_number);
+			acpi_disable_gpe(adev->wakeup.gpe_device,
+					 adev->wakeup.gpe_number);
+		}
+		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
 					   button->type == ACPI_BUTTON_TYPE_LID ?
 						acpi_lid_notify :
 						acpi_button_notify);
diff --git a/drivers/android/binder/allocation.rs b/drivers/android/binder/allocation.rs
index 7f65a9c3a0e5..d9113e9b98b2 100644
--- a/drivers/android/binder/allocation.rs
+++ b/drivers/android/binder/allocation.rs
@@ -160,6 +160,14 @@ pub(crate) fn set_info_target_node(&mut self, target_node: NodeRef) {
         self.get_or_init_info().target_node = Some(target_node);
     }
 
+    pub(crate) fn take_oneway_node(&mut self) -> Option<DArc<Node>> {
+        if let Some(info) = self.allocation_info.as_mut() {
+            info.oneway_node.take()
+        } else {
+            None
+        }
+    }
+
     /// Reserve enough space to push at least `num_fds` fds.
     pub(crate) fn info_add_fd_reserve(&mut self, num_fds: usize) -> Result {
         self.get_or_init_info()
diff --git a/drivers/android/binder/process.rs b/drivers/android/binder/process.rs
index f06498129aa9..9812c52dc16e 100644
--- a/drivers/android/binder/process.rs
+++ b/drivers/android/binder/process.rs
@@ -1402,7 +1402,12 @@ fn deferred_release(self: Arc<Self>) {
         // Clear delivered_deaths list.
         //
         // Scope ensures that MutexGuard is dropped while executing the body.
-        while let Some(delivered_death) = { self.inner.lock().delivered_deaths.pop_front() } {
+        while let Some(delivered_death) = {
+            // Explicitly bind to avoid tail expression lifetime extension of the lockguard
+            // Can be removed when the kernel moves to edition 2024
+            let maybe_death = self.inner.lock().delivered_deaths.pop_front();
+            maybe_death
+        } {
             drop(delivered_death);
         }
 
diff --git a/drivers/android/binder/transaction.rs b/drivers/android/binder/transaction.rs
index 75e6f5fbaaae..e1b578c87446 100644
--- a/drivers/android/binder/transaction.rs
+++ b/drivers/android/binder/transaction.rs
@@ -250,7 +250,8 @@ fn drop_outstanding_txn(&self) {
     /// Not used for replies.
     pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
         // Defined before `process_inner` so that the destructor runs after releasing the lock.
-        let mut _t_outdated;
+        let _t_outdated;
+        let _oneway_node;
 
         let oneway = self.flags & TF_ONE_WAY != 0;
         let process = self.to.clone();
@@ -267,6 +268,14 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
                         if let Some(t_outdated) =
                             target_node.take_outdated_transaction(&self, &mut process_inner)
                         {
+                            let mut alloc_guard = t_outdated.allocation.lock();
+                            if let Some(alloc) = (*alloc_guard).as_mut() {
+                                // Take the oneway node to prevent `Allocation::drop` from calling
+                                // `pending_oneway_finished()`, which would be incorrect as this
+                                // transaction is not being submitted.
+                                _oneway_node = alloc.take_oneway_node();
+                            }
+                            drop(alloc_guard);
                             // Save the transaction to be dropped after locks are released.
                             _t_outdated = t_outdated;
                         }
diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index fb6d9294140d..915eb5cd96b2 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -173,7 +173,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 		count = strlen(msg);
 
 	/* if the string ends with a newline, trim it */
-	if (msg[count - 1] == '\n')
+	if (count && msg[count - 1] == '\n')
 		count--;
 
 	if (!count) {
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index aaaef8dd8253..b672ecf5d72c 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -33,6 +33,7 @@
 #include <linux/cpuhotplug.h>
 #include <linux/part_stat.h>
 #include <linux/kernel_read_file.h>
+#include <linux/rcupdate.h>
 
 #include "zram_drv.h"
 
@@ -504,6 +505,7 @@ struct zram_wb_ctl {
 	wait_queue_head_t done_wait;
 	spinlock_t done_lock;
 	atomic_t num_inflight;
+	struct rcu_head rcu;
 };
 
 struct zram_wb_req {
@@ -847,7 +849,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 		release_wb_req(req);
 	}
 
-	kfree(wb_ctl);
+	kfree_rcu(wb_ctl, rcu);
 }
 
 static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
@@ -964,11 +966,13 @@ static void zram_writeback_endio(struct bio *bio)
 	struct zram_wb_ctl *wb_ctl = bio->bi_private;
 	unsigned long flags;
 
+	rcu_read_lock();
 	spin_lock_irqsave(&wb_ctl->done_lock, flags);
 	list_add(&req->entry, &wb_ctl->done_reqs);
 	spin_unlock_irqrestore(&wb_ctl->done_lock, flags);
 
 	wake_up(&wb_ctl->done_wait);
+	rcu_read_unlock();
 }
 
 static void zram_submit_wb_request(struct zram *zram,
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5c535f3ab722..a5143eb08f43 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3511,7 +3511,13 @@ static int btusb_setup_qca_load_rampatch(struct hci_dev *hdev,
 		    "firmware rome 0x%x build 0x%x",
 		    rver_rom, rver_patch, ver_rom, ver_patch);
 
-	if (rver_rom != ver_rom || rver_patch <= ver_patch) {
+	/* Allow rampatch when the patch version equals the firmware version.
+	 * A firmware download may be aborted by a transient USB error (e.g.
+	 * disconnect) after the controller updates version info but before
+	 * completion.
+	 * Allowing equal versions enables re-flashing during recovery.
+	 */
+	if (rver_rom != ver_rom || rver_patch < ver_patch) {
 		bt_dev_err(hdev, "rampatch file version did not match with firmware");
 		err = -EINVAL;
 		goto done;
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a18480c46b24..e4c6b81c7c68 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1677,8 +1677,8 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		mod_timer(&qca->tx_idle_timer, jiffies +
 				  msecs_to_jiffies(qca->tx_idle_delay));
 
-		/* Controller reset completion time is 50ms */
-		msleep(50);
+		/* Wait for the controller to load the rampatch and NVM. */
+		msleep(100);
 
 		clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
 		clear_bit(QCA_IBS_DISABLED, &qca->flags);
diff --git a/drivers/comedi/drivers/comedi_test.c b/drivers/comedi/drivers/comedi_test.c
index 01aafce20ef8..1f430ffc7bd9 100644
--- a/drivers/comedi/drivers/comedi_test.c
+++ b/drivers/comedi/drivers/comedi_test.c
@@ -274,6 +274,7 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 	/* Step 2a : make sure trigger sources are unique */
 
 	err |= comedi_check_trigger_is_unique(cmd->convert_src);
+	err |= comedi_check_trigger_is_unique(cmd->scan_begin_src);
 	err |= comedi_check_trigger_is_unique(cmd->stop_src);
 
 	/* Step 2b : and mutually compatible */
@@ -324,10 +325,10 @@ static int waveform_ai_cmdtest(struct comedi_device *dev,
 		arg = min(arg,
 			  rounddown(UINT_MAX, (unsigned int)NSEC_PER_USEC));
 		arg = NSEC_PER_USEC * DIV_ROUND_CLOSEST(arg, NSEC_PER_USEC);
-		if (cmd->scan_begin_arg == TRIG_TIMER) {
+		if (cmd->scan_begin_src == TRIG_TIMER) {
 			/* limit convert_arg to keep scan_begin_arg in range */
 			limit = UINT_MAX / cmd->scan_end_arg;
-			limit = rounddown(limit, (unsigned int)NSEC_PER_SEC);
+			limit = rounddown(limit, (unsigned int)NSEC_PER_USEC);
 			arg = min(arg, limit);
 		}
 		err |= comedi_check_trigger_arg_is(&cmd->convert_arg, arg);
diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-core.c
index 50bd30ba3d03..0b1dac61b7b5 100644
--- a/drivers/counter/counter-core.c
+++ b/drivers/counter/counter-core.c
@@ -124,7 +124,8 @@ struct counter_device *counter_alloc(size_t sizeof_priv)
 
 err_dev_set_name:
 
-	counter_chrdev_remove(counter);
+	put_device(dev);
+	return NULL;
 err_chrdev_add:
 
 	ida_free(&counter_ida, dev->id);
diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
index 11711874a325..958bf2b1133d 100644
--- a/drivers/dma-buf/dma-buf.c
+++ b/drivers/dma-buf/dma-buf.c
@@ -792,9 +792,13 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
 
-	fd = FD_ADD(flags, dmabuf->file);
+	fd = get_unused_fd_flags(flags);
+	if (fd < 0)
+		return fd;
+
 	DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);
 
+	fd_install(fd, dmabuf->file);
 	return fd;
 }
 EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");
diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
index 95ae786e98aa..72aa5f4d5d31 100644
--- a/drivers/dpll/dpll_netlink.c
+++ b/drivers/dpll/dpll_netlink.c
@@ -771,12 +771,21 @@ int dpll_device_delete_ntf(struct dpll_device *dpll)
 	return dpll_device_event_send(DPLL_CMD_DEVICE_DELETE_NTF, dpll);
 }
 
-static int
-__dpll_device_change_ntf(struct dpll_device *dpll)
+/**
+ * __dpll_device_change_ntf - notify that the dpll device has been changed
+ * @dpll: registered dpll pointer
+ *
+ * Context: caller must hold dpll_lock. Suitable for use inside device
+ *          callbacks which are already invoked under dpll_lock.
+ * Return: 0 if succeeds, error code otherwise.
+ */
+int __dpll_device_change_ntf(struct dpll_device *dpll)
 {
+	lockdep_assert_held(&dpll_lock);
 	dpll_device_notify(dpll, DPLL_DEVICE_CHANGED);
 	return dpll_device_event_send(DPLL_CMD_DEVICE_CHANGE_NTF, dpll);
 }
+EXPORT_SYMBOL_GPL(__dpll_device_change_ntf);
 
 /**
  * dpll_device_change_ntf - notify that the dpll device has been changed
diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
index 37f3c33570ee..10e036ccf08f 100644
--- a/drivers/dpll/zl3073x/core.c
+++ b/drivers/dpll/zl3073x/core.c
@@ -20,79 +20,30 @@
 #include "dpll.h"
 #include "regs.h"
 
-/* Chip IDs for zl30731 */
-static const u16 zl30731_ids[] = {
-	0x0E93,
-	0x1E93,
-	0x2E93,
+#define ZL_CHIP_INFO(_id, _nchannels, _flags)				\
+	{ .id = (_id), .num_channels = (_nchannels), .flags = (_flags) }
+
+static const struct zl3073x_chip_info zl3073x_chip_ids[] = {
+	ZL_CHIP_INFO(0x0E30, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E93, 1, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E94, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E95, 3, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E96, 4, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x0E97, 5, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x1E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1E97, 5, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x1F60, 2, ZL3073X_FLAG_REF_PHASE_COMP_32),
+	ZL_CHIP_INFO(0x2E93, 1, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E94, 2, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E95, 3, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E96, 4, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x2E97, 5, ZL3073X_FLAG_DIE_TEMP),
+	ZL_CHIP_INFO(0x3FC4, 2, ZL3073X_FLAG_DIE_TEMP),
 };
 
-const struct zl3073x_chip_info zl30731_chip_info = {
-	.ids = zl30731_ids,
-	.num_ids = ARRAY_SIZE(zl30731_ids),
-	.num_channels = 1,
-};
-EXPORT_SYMBOL_NS_GPL(zl30731_chip_info, "ZL3073X");
-
-/* Chip IDs for zl30732 */
-static const u16 zl30732_ids[] = {
-	0x0E30,
-	0x0E94,
-	0x1E94,
-	0x1F60,
-	0x2E94,
-	0x3FC4,
-};
-
-const struct zl3073x_chip_info zl30732_chip_info = {
-	.ids = zl30732_ids,
-	.num_ids = ARRAY_SIZE(zl30732_ids),
-	.num_channels = 2,
-};
-EXPORT_SYMBOL_NS_GPL(zl30732_chip_info, "ZL3073X");
-
-/* Chip IDs for zl30733 */
-static const u16 zl30733_ids[] = {
-	0x0E95,
-	0x1E95,
-	0x2E95,
-};
-
-const struct zl3073x_chip_info zl30733_chip_info = {
-	.ids = zl30733_ids,
-	.num_ids = ARRAY_SIZE(zl30733_ids),
-	.num_channels = 3,
-};
-EXPORT_SYMBOL_NS_GPL(zl30733_chip_info, "ZL3073X");
-
-/* Chip IDs for zl30734 */
-static const u16 zl30734_ids[] = {
-	0x0E96,
-	0x1E96,
-	0x2E96,
-};
-
-const struct zl3073x_chip_info zl30734_chip_info = {
-	.ids = zl30734_ids,
-	.num_ids = ARRAY_SIZE(zl30734_ids),
-	.num_channels = 4,
-};
-EXPORT_SYMBOL_NS_GPL(zl30734_chip_info, "ZL3073X");
-
-/* Chip IDs for zl30735 */
-static const u16 zl30735_ids[] = {
-	0x0E97,
-	0x1E97,
-	0x2E97,
-};
-
-const struct zl3073x_chip_info zl30735_chip_info = {
-	.ids = zl30735_ids,
-	.num_ids = ARRAY_SIZE(zl30735_ids),
-	.num_channels = 5,
-};
-EXPORT_SYMBOL_NS_GPL(zl30735_chip_info, "ZL3073X");
-
 #define ZL_RANGE_OFFSET		0x80
 #define ZL_PAGE_SIZE		0x80
 #define ZL_NUM_PAGES		256
@@ -942,7 +893,7 @@ static void zl3073x_dev_dpll_fini(void *ptr)
 }
 
 static int
-zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
+zl3073x_devm_dpll_init(struct zl3073x_dev *zldev)
 {
 	struct kthread_worker *kworker;
 	struct zl3073x_dpll *zldpll;
@@ -952,7 +903,7 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 	INIT_LIST_HEAD(&zldev->dplls);
 
 	/* Allocate all DPLLs */
-	for (i = 0; i < num_dplls; i++) {
+	for (i = 0; i < zldev->info->num_channels; i++) {
 		zldpll = zl3073x_dpll_alloc(zldev, i);
 		if (IS_ERR(zldpll)) {
 			dev_err_probe(zldev->dev, PTR_ERR(zldpll),
@@ -992,14 +943,12 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
 /**
  * zl3073x_dev_probe - initialize zl3073x device
  * @zldev: pointer to zl3073x device
- * @chip_info: chip info based on compatible
  *
  * Common initialization of zl3073x device structure.
  *
  * Returns: 0 on success, <0 on error
  */
-int zl3073x_dev_probe(struct zl3073x_dev *zldev,
-		      const struct zl3073x_chip_info *chip_info)
+int zl3073x_dev_probe(struct zl3073x_dev *zldev)
 {
 	u16 id, revision, fw_ver;
 	unsigned int i;
@@ -1011,18 +960,17 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 	if (rc)
 		return rc;
 
-	/* Check it matches */
-	for (i = 0; i < chip_info->num_ids; i++) {
-		if (id == chip_info->ids[i])
+	/* Detect chip variant */
+	for (i = 0; i < ARRAY_SIZE(zl3073x_chip_ids); i++) {
+		if (zl3073x_chip_ids[i].id == id)
 			break;
 	}
 
-	if (i == chip_info->num_ids) {
+	if (i == ARRAY_SIZE(zl3073x_chip_ids))
 		return dev_err_probe(zldev->dev, -ENODEV,
-				     "Unknown or non-match chip ID: 0x%0x\n",
-				     id);
-	}
-	zldev->chip_id = id;
+				     "Unknown chip ID: 0x%04x\n", id);
+
+	zldev->info = &zl3073x_chip_ids[i];
 
 	/* Read revision, firmware version and custom config version */
 	rc = zl3073x_read_u16(zldev, ZL_REG_REVISION, &revision);
@@ -1061,7 +1009,7 @@ int zl3073x_dev_probe(struct zl3073x_dev *zldev,
 				     "Failed to initialize mutex\n");
 
 	/* Register DPLL channels */
-	rc = zl3073x_devm_dpll_init(zldev, chip_info->num_channels);
+	rc = zl3073x_devm_dpll_init(zldev);
 	if (rc)
 		return rc;
 
diff --git a/drivers/dpll/zl3073x/core.h b/drivers/dpll/zl3073x/core.h
index fd2af3c62a7d..b6f22ee1c0bd 100644
--- a/drivers/dpll/zl3073x/core.h
+++ b/drivers/dpll/zl3073x/core.h
@@ -30,12 +30,34 @@ struct zl3073x_dpll;
 #define ZL3073X_NUM_PINS	(ZL3073X_NUM_INPUT_PINS + \
 				 ZL3073X_NUM_OUTPUT_PINS)
 
+enum zl3073x_flags {
+	ZL3073X_FLAG_REF_PHASE_COMP_32_BIT,
+	ZL3073X_FLAG_DIE_TEMP_BIT,
+	ZL3073X_FLAGS_NBITS /* must be last */
+};
+
+#define __ZL3073X_FLAG(name)	BIT(ZL3073X_FLAG_ ## name ## _BIT)
+#define ZL3073X_FLAG_REF_PHASE_COMP_32	__ZL3073X_FLAG(REF_PHASE_COMP_32)
+#define ZL3073X_FLAG_DIE_TEMP		__ZL3073X_FLAG(DIE_TEMP)
+
+/**
+ * struct zl3073x_chip_info - chip variant identification
+ * @id: chip ID
+ * @num_channels: number of DPLL channels supported by this variant
+ * @flags: chip variant flags
+ */
+struct zl3073x_chip_info {
+	u16		id;
+	u8		num_channels;
+	unsigned long	flags;
+};
+
 /**
  * struct zl3073x_dev - zl3073x device
  * @dev: pointer to device
  * @regmap: regmap to access device registers
+ * @info: detected chip info
  * @multiop_lock: to serialize multiple register operations
- * @chip_id: chip ID read from hardware
  * @ref: array of input references' invariants
  * @out: array of outs' invariants
  * @synth: array of synths' invariants
@@ -46,10 +68,10 @@ struct zl3073x_dpll;
  * @phase_avg_factor: phase offset measurement averaging factor
  */
 struct zl3073x_dev {
-	struct device		*dev;
-	struct regmap		*regmap;
-	struct mutex		multiop_lock;
-	u16			chip_id;
+	struct device			*dev;
+	struct regmap			*regmap;
+	const struct zl3073x_chip_info	*info;
+	struct mutex			multiop_lock;
 
 	/* Invariants */
 	struct zl3073x_ref	ref[ZL3073X_NUM_REFS];
@@ -68,22 +90,10 @@ struct zl3073x_dev {
 	u8			phase_avg_factor;
 };
 
-struct zl3073x_chip_info {
-	const u16	*ids;
-	size_t		num_ids;
-	int		num_channels;
-};
-
-extern const struct zl3073x_chip_info zl30731_chip_info;
-extern const struct zl3073x_chip_info zl30732_chip_info;
-extern const struct zl3073x_chip_info zl30733_chip_info;
-extern const struct zl3073x_chip_info zl30734_chip_info;
-extern const struct zl3073x_chip_info zl30735_chip_info;
 extern const struct regmap_config zl3073x_regmap_config;
 
 struct zl3073x_dev *zl3073x_devm_alloc(struct device *dev);
-int zl3073x_dev_probe(struct zl3073x_dev *zldev,
-		      const struct zl3073x_chip_info *chip_info);
+int zl3073x_dev_probe(struct zl3073x_dev *zldev);
 
 int zl3073x_dev_start(struct zl3073x_dev *zldev, bool full);
 void zl3073x_dev_stop(struct zl3073x_dev *zldev);
@@ -158,18 +168,7 @@ int zl3073x_ref_phase_offsets_update(struct zl3073x_dev *zldev, int channel);
 static inline bool
 zl3073x_dev_is_ref_phase_comp_32bit(struct zl3073x_dev *zldev)
 {
-	switch (zldev->chip_id) {
-	case 0x0E30:
-	case 0x0E93:
-	case 0x0E94:
-	case 0x0E95:
-	case 0x0E96:
-	case 0x0E97:
-	case 0x1F60:
-		return true;
-	default:
-		return false;
-	}
+	return zldev->info->flags & ZL3073X_FLAG_REF_PHASE_COMP_32;
 }
 
 static inline bool
diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index aaa14ea5e670..70c91948c7da 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -1065,6 +1065,25 @@ zl3073x_dpll_output_pin_state_on_dpll_get(const struct dpll_pin *dpll_pin,
 	return 0;
 }
 
+static int
+zl3073x_dpll_temp_get(const struct dpll_device *dpll, void *dpll_priv,
+		      s32 *temp, struct netlink_ext_ack *extack)
+{
+	struct zl3073x_dpll *zldpll = dpll_priv;
+	struct zl3073x_dev *zldev = zldpll->dev;
+	u16 val;
+	int rc;
+
+	rc = zl3073x_read_u16(zldev, ZL_REG_DIE_TEMP_STATUS, &val);
+	if (rc)
+		return rc;
+
+	/* Register value is in units of 0.1 C, convert to millidegrees */
+	*temp = (s16)val * 100;
+
+	return 0;
+}
+
 static int
 zl3073x_dpll_lock_status_get(const struct dpll_device *dpll, void *dpll_priv,
 			     enum dpll_lock_status *status,
@@ -1174,15 +1193,6 @@ zl3073x_dpll_phase_offset_avg_factor_get(const struct dpll_device *dpll,
 	return 0;
 }
 
-static void
-zl3073x_dpll_change_work(struct work_struct *work)
-{
-	struct zl3073x_dpll *zldpll;
-
-	zldpll = container_of(work, struct zl3073x_dpll, change_work);
-	dpll_device_change_ntf(zldpll->dpll_dev);
-}
-
 static int
 zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 					 void *dpll_priv, u32 factor,
@@ -1208,8 +1218,10 @@ zl3073x_dpll_phase_offset_avg_factor_set(const struct dpll_device *dpll,
 	 * we have to send a notification for other DPLL devices.
 	 */
 	list_for_each_entry(item, &zldpll->dev->dplls, list) {
-		if (item != zldpll)
-			schedule_work(&item->change_work);
+		struct dpll_device *dpll_dev = READ_ONCE(item->dpll_dev);
+
+		if (item != zldpll && dpll_dev)
+			__dpll_device_change_ntf(dpll_dev);
 	}
 
 	return 0;
@@ -1671,6 +1683,10 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 	zldpll->forced_ref = FIELD_GET(ZL_DPLL_MODE_REFSEL_REF,
 				       dpll_mode_refsel);
 
+	zldpll->ops = zl3073x_dpll_device_ops;
+	if (zldev->info->flags & ZL3073X_FLAG_DIE_TEMP)
+		zldpll->ops.temp_get = zl3073x_dpll_temp_get;
+
 	zldpll->dpll_dev = dpll_device_get(zldev->clock_id, zldpll->id,
 					   THIS_MODULE, &zldpll->tracker);
 	if (IS_ERR(zldpll->dpll_dev)) {
@@ -1682,7 +1698,7 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 
 	rc = dpll_device_register(zldpll->dpll_dev,
 				  zl3073x_prop_dpll_type_get(zldev, zldpll->id),
-				  &zl3073x_dpll_device_ops, zldpll);
+				  &zldpll->ops, zldpll);
 	if (rc) {
 		dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
 		zldpll->dpll_dev = NULL;
@@ -1701,14 +1717,13 @@ zl3073x_dpll_device_register(struct zl3073x_dpll *zldpll)
 static void
 zl3073x_dpll_device_unregister(struct zl3073x_dpll *zldpll)
 {
-	WARN(!zldpll->dpll_dev, "DPLL device is not registered\n");
+	struct dpll_device *dpll_dev = READ_ONCE(zldpll->dpll_dev);
 
-	cancel_work_sync(&zldpll->change_work);
+	WARN(!dpll_dev, "DPLL device is not registered\n");
 
-	dpll_device_unregister(zldpll->dpll_dev, &zl3073x_dpll_device_ops,
-			       zldpll);
-	dpll_device_put(zldpll->dpll_dev, &zldpll->tracker);
-	zldpll->dpll_dev = NULL;
+	WRITE_ONCE(zldpll->dpll_dev, NULL);
+	dpll_device_unregister(dpll_dev, &zldpll->ops, zldpll);
+	dpll_device_put(dpll_dev, &zldpll->tracker);
 }
 
 /**
@@ -1954,7 +1969,6 @@ zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch)
 	zldpll->dev = zldev;
 	zldpll->id = ch;
 	INIT_LIST_HEAD(&zldpll->pins);
-	INIT_WORK(&zldpll->change_work, zl3073x_dpll_change_work);
 
 	return zldpll;
 }
diff --git a/drivers/dpll/zl3073x/dpll.h b/drivers/dpll/zl3073x/dpll.h
index c65c798c3792..241253212f7d 100644
--- a/drivers/dpll/zl3073x/dpll.h
+++ b/drivers/dpll/zl3073x/dpll.h
@@ -17,11 +17,11 @@
  * @forced_ref: selected reference in forced reference lock mode
  * @check_count: periodic check counter
  * @phase_monitor: is phase offset monitor enabled
+ * @ops: DPLL device operations for this instance
  * @dpll_dev: pointer to registered DPLL device
  * @tracker: tracking object for the acquired reference
  * @lock_status: last saved DPLL lock status
  * @pins: list of pins
- * @change_work: device change notification work
  */
 struct zl3073x_dpll {
 	struct list_head		list;
@@ -31,11 +31,11 @@ struct zl3073x_dpll {
 	u8				forced_ref;
 	u8				check_count;
 	bool				phase_monitor;
+	struct dpll_device_ops		ops;
 	struct dpll_device		*dpll_dev;
 	dpll_tracker			tracker;
 	enum dpll_lock_status		lock_status;
 	struct list_head		pins;
-	struct work_struct		change_work;
 };
 
 struct zl3073x_dpll *zl3073x_dpll_alloc(struct zl3073x_dev *zldev, u8 ch);
diff --git a/drivers/dpll/zl3073x/i2c.c b/drivers/dpll/zl3073x/i2c.c
index 7bbfdd4ed867..979df85826ab 100644
--- a/drivers/dpll/zl3073x/i2c.c
+++ b/drivers/dpll/zl3073x/i2c.c
@@ -22,40 +22,25 @@ static int zl3073x_i2c_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(zldev->regmap),
 				     "Failed to initialize regmap\n");
 
-	return zl3073x_dev_probe(zldev, i2c_get_match_data(client));
+	return zl3073x_dev_probe(zldev);
 }
 
 static const struct i2c_device_id zl3073x_i2c_id[] = {
-	{
-		.name = "zl30731",
-		.driver_data = (kernel_ulong_t)&zl30731_chip_info,
-	},
-	{
-		.name = "zl30732",
-		.driver_data = (kernel_ulong_t)&zl30732_chip_info,
-	},
-	{
-		.name = "zl30733",
-		.driver_data = (kernel_ulong_t)&zl30733_chip_info,
-	},
-	{
-		.name = "zl30734",
-		.driver_data = (kernel_ulong_t)&zl30734_chip_info,
-	},
-	{
-		.name = "zl30735",
-		.driver_data = (kernel_ulong_t)&zl30735_chip_info,
-	},
+	{ "zl30731" },
+	{ "zl30732" },
+	{ "zl30733" },
+	{ "zl30734" },
+	{ "zl30735" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, zl3073x_i2c_id);
 
 static const struct of_device_id zl3073x_i2c_of_match[] = {
-	{ .compatible = "microchip,zl30731", .data = &zl30731_chip_info },
-	{ .compatible = "microchip,zl30732", .data = &zl30732_chip_info },
-	{ .compatible = "microchip,zl30733", .data = &zl30733_chip_info },
-	{ .compatible = "microchip,zl30734", .data = &zl30734_chip_info },
-	{ .compatible = "microchip,zl30735", .data = &zl30735_chip_info },
+	{ .compatible = "microchip,zl30731" },
+	{ .compatible = "microchip,zl30732" },
+	{ .compatible = "microchip,zl30733" },
+	{ .compatible = "microchip,zl30734" },
+	{ .compatible = "microchip,zl30735" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, zl3073x_i2c_of_match);
diff --git a/drivers/dpll/zl3073x/regs.h b/drivers/dpll/zl3073x/regs.h
index 5573d7188406..19c598daa784 100644
--- a/drivers/dpll/zl3073x/regs.h
+++ b/drivers/dpll/zl3073x/regs.h
@@ -78,6 +78,8 @@
 #define ZL_REG_RESET_STATUS			ZL_REG(0, 0x18, 1)
 #define ZL_REG_RESET_STATUS_RESET		BIT(0)
 
+#define ZL_REG_DIE_TEMP_STATUS			ZL_REG(0, 0x44, 2)
+
 /*************************
  * Register Page 2, Status
  *************************/
diff --git a/drivers/dpll/zl3073x/spi.c b/drivers/dpll/zl3073x/spi.c
index af901b4d6dda..f024f42b78d0 100644
--- a/drivers/dpll/zl3073x/spi.c
+++ b/drivers/dpll/zl3073x/spi.c
@@ -22,40 +22,25 @@ static int zl3073x_spi_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(zldev->regmap),
 				     "Failed to initialize regmap\n");
 
-	return zl3073x_dev_probe(zldev, spi_get_device_match_data(spi));
+	return zl3073x_dev_probe(zldev);
 }
 
 static const struct spi_device_id zl3073x_spi_id[] = {
-	{
-		.name = "zl30731",
-		.driver_data = (kernel_ulong_t)&zl30731_chip_info
-	},
-	{
-		.name = "zl30732",
-		.driver_data = (kernel_ulong_t)&zl30732_chip_info,
-	},
-	{
-		.name = "zl30733",
-		.driver_data = (kernel_ulong_t)&zl30733_chip_info,
-	},
-	{
-		.name = "zl30734",
-		.driver_data = (kernel_ulong_t)&zl30734_chip_info,
-	},
-	{
-		.name = "zl30735",
-		.driver_data = (kernel_ulong_t)&zl30735_chip_info,
-	},
+	{ "zl30731" },
+	{ "zl30732" },
+	{ "zl30733" },
+	{ "zl30734" },
+	{ "zl30735" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, zl3073x_spi_id);
 
 static const struct of_device_id zl3073x_spi_of_match[] = {
-	{ .compatible = "microchip,zl30731", .data = &zl30731_chip_info },
-	{ .compatible = "microchip,zl30732", .data = &zl30732_chip_info },
-	{ .compatible = "microchip,zl30733", .data = &zl30733_chip_info },
-	{ .compatible = "microchip,zl30734", .data = &zl30734_chip_info },
-	{ .compatible = "microchip,zl30735", .data = &zl30735_chip_info },
+	{ .compatible = "microchip,zl30731" },
+	{ .compatible = "microchip,zl30732" },
+	{ .compatible = "microchip,zl30733" },
+	{ .compatible = "microchip,zl30734" },
+	{ .compatible = "microchip,zl30735" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, zl3073x_spi_of_match);
diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
index e5ac2d211013..fe5bcaa90496 100644
--- a/drivers/gpio/gpio-adnp.c
+++ b/drivers/gpio/gpio-adnp.c
@@ -237,7 +237,9 @@ static irqreturn_t adnp_irq(int irq, void *data)
 		unsigned long pending;
 		int err;
 
-		scoped_guard(mutex, &adnp->i2c_lock) {
+		{
+			guard(mutex)(&adnp->i2c_lock);
+
 			err = adnp_read(adnp, GPIO_PLR(adnp) + i, &level);
 			if (err < 0)
 				continue;
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 647b6f4861b7..12f11a6c9665 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -469,7 +469,7 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 		 * the handler is needed only once, but doing it for every port
 		 * is more robust and easier.
 		 */
-		port->irq_high = -1;
+		port->irq_high = 0;
 		port->mx_irq_handler = mx2_gpio_irq_handler;
 	} else
 		port->mx_irq_handler = mx3_gpio_irq_handler;
diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 0fff4a699f12..1ef0ba956cfd 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -638,10 +638,17 @@ static int rockchip_gpiolib_register(struct rockchip_pin_bank *bank)
 	return ret;
 }
 
+static void rockchip_clk_put(void *data)
+{
+	struct clk *clk = data;
+
+	clk_put(clk);
+}
+
 static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 {
 	struct resource res;
-	int id = 0;
+	int id = 0, ret;
 
 	if (of_address_to_resource(bank->of_node, 0, &res)) {
 		dev_err(bank->dev, "cannot find IO resource for bank\n");
@@ -656,11 +663,10 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 	if (!bank->irq)
 		return -EINVAL;
 
-	bank->clk = of_clk_get(bank->of_node, 0);
+	bank->clk = devm_clk_get_enabled(bank->dev, NULL);
 	if (IS_ERR(bank->clk))
 		return PTR_ERR(bank->clk);
 
-	clk_prepare_enable(bank->clk);
 	id = readl(bank->reg_base + gpio_regs_v2.version_id);
 
 	switch (id) {
@@ -672,9 +678,13 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 		bank->db_clk = of_clk_get(bank->of_node, 1);
 		if (IS_ERR(bank->db_clk)) {
 			dev_err(bank->dev, "cannot find debounce clk\n");
-			clk_disable_unprepare(bank->clk);
 			return -EINVAL;
 		}
+
+		ret = devm_add_action_or_reset(bank->dev, rockchip_clk_put,
+					       bank->db_clk);
+		if (ret)
+			return ret;
 		break;
 	case GPIO_TYPE_V1:
 		bank->gpio_regs = &gpio_regs_v1;
@@ -751,7 +761,6 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
-		clk_disable_unprepare(bank->clk);
 		mutex_unlock(&bank->deferred_lock);
 		return ret;
 	}
@@ -792,7 +801,9 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 {
 	struct rockchip_pin_bank *bank = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(bank->clk);
+	irq_set_chained_handler_and_data(bank->irq, NULL, NULL);
+	if (bank->domain)
+		irq_domain_remove(bank->domain);
 	gpiochip_remove(&bank->gpio_chip);
 }
 
diff --git a/drivers/gpio/gpio-shared-proxy.c b/drivers/gpio/gpio-shared-proxy.c
index 29d7d2e4dfc0..6941e4be6cf1 100644
--- a/drivers/gpio/gpio-shared-proxy.c
+++ b/drivers/gpio/gpio-shared-proxy.c
@@ -103,9 +103,18 @@ static void gpio_shared_proxy_free(struct gpio_chip *gc, unsigned int offset)
 {
 	struct gpio_shared_proxy_data *proxy = gpiochip_get_data(gc);
 	struct gpio_shared_desc *shared_desc = proxy->shared_desc;
+	int ret;
 
 	guard(gpio_shared_desc_lock)(shared_desc);
 
+	if (proxy->voted_high) {
+		ret = gpio_shared_proxy_set_unlocked(proxy,
+			shared_desc->can_sleep ? gpiod_set_value_cansleep : gpiod_set_value, 0);
+		if (ret)
+			dev_err(proxy->dev,
+				"Failed to unset the shared GPIO value on release: %d\n", ret);
+	}
+
 	proxy->shared_desc->usecnt--;
 
 	dev_dbg(proxy->dev, "Shared GPIO freed, number of users: %u\n",
diff --git a/drivers/gpio/gpio-virtuser.c b/drivers/gpio/gpio-virtuser.c
index 955b5efc283e..c6f16cb02bf6 100644
--- a/drivers/gpio/gpio-virtuser.c
+++ b/drivers/gpio/gpio-virtuser.c
@@ -399,7 +399,7 @@ static ssize_t gpio_virtuser_direction_do_write(struct file *file,
 	char buf[32], *trimmed;
 	int ret, dir, val = 0;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, user_buf, count);
@@ -624,7 +624,7 @@ static ssize_t gpio_virtuser_consumer_write(struct file *file,
 	char buf[GPIO_VIRTUSER_NAME_BUF_LEN + 2];
 	int ret;
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -EINVAL;
 
 	ret = simple_write_to_buffer(buf, GPIO_VIRTUSER_NAME_BUF_LEN, ppos,
diff --git a/drivers/gpio/gpiolib-shared.c b/drivers/gpio/gpiolib-shared.c
index e02d6b93a4ab..de72776fb154 100644
--- a/drivers/gpio/gpiolib-shared.c
+++ b/drivers/gpio/gpiolib-shared.c
@@ -53,7 +53,7 @@ struct gpio_shared_entry {
 	unsigned int offset;
 	/* Index in the property value array. */
 	size_t index;
-	/* Synchronizes the modification of shared_desc. */
+	/* Synchronizes the modification of shared_desc and offset. */
 	struct mutex lock;
 	struct gpio_shared_desc *shared_desc;
 	struct kref ref;
@@ -598,16 +598,13 @@ void gpio_device_teardown_shared(struct gpio_device *gdev)
 	struct gpio_shared_ref *ref;
 
 	list_for_each_entry(entry, &gpio_shared_list, list) {
-		guard(mutex)(&entry->lock);
-
 		if (!device_match_fwnode(&gdev->dev, entry->fwnode))
 			continue;
 
-		gpiod_free_commit(&gdev->descs[entry->offset]);
+		scoped_guard(mutex, &entry->lock)
+			gpiod_free_commit(&gdev->descs[entry->offset]);
 
 		list_for_each_entry(ref, &entry->refs, list) {
-			guard(mutex)(&ref->lock);
-
 			if (ref->lookup) {
 				gpiod_remove_lookup_table(ref->lookup);
 				kfree(ref->lookup->table[0].key);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a6107109a2b8..ded95c72c043 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -1095,9 +1095,16 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		 * If that number is larger than the size of the array, the ioctl must
 		 * be retried.
 		 */
+		if (args->num_entries > INT_MAX / sizeof(*vm_entries)) {
+			r = -EINVAL;
+			goto out_exec;
+		}
+
 		vm_entries = kvcalloc(args->num_entries, sizeof(*vm_entries), GFP_KERNEL);
-		if (!vm_entries)
-			return -ENOMEM;
+		if (!vm_entries) {
+			r = -ENOMEM;
+			goto out_exec;
+		}
 
 		amdgpu_vm_bo_va_for_each_valid_mapping(bo_va, mapping) {
 			if (num_mappings < args->num_entries) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index f72990ac046e..5bfa5a84b09c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -51,8 +51,6 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_hmm.h"
 
-#define MAX_WALK_BYTE	(2UL << 30)
-
 /**
  * amdgpu_hmm_invalidate_gfx - callback to notify about mm change
  *
@@ -78,6 +76,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
 
 	mmu_interval_set_seq(mni, cur_seq);
 
+	amdgpu_vm_bo_invalidate(bo, false);
 	r = dma_resv_wait_timeout(bo->tbo.base.resv, DMA_RESV_USAGE_BOOKKEEP,
 				  false, MAX_SCHEDULE_TIMEOUT);
 	mutex_unlock(&adev->notifier_lock);
@@ -170,11 +169,13 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       void *owner,
 			       struct amdgpu_hmm_range *range)
 {
-	unsigned long end;
+	const u64 max_bytes = SZ_2G;
+
+	struct hmm_range *hmm_range = &range->hmm_range;
 	unsigned long timeout;
 	unsigned long *pfns;
-	int r = 0;
-	struct hmm_range *hmm_range = &range->hmm_range;
+	unsigned long end;
+	int r;
 
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (unlikely(!pfns)) {
@@ -191,8 +192,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	end = start + npages * PAGE_SIZE;
 	hmm_range->dev_private_owner = owner;
 
+	hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 	do {
-		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
+		hmm_range->end = min(hmm_range->start + max_bytes, end);
 
 		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
 			hmm_range->start, hmm_range->end);
@@ -200,7 +202,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
-		hmm_range->notifier_seq = mmu_interval_read_begin(notifier);
 		r = hmm_range_fault(hmm_range);
 		if (unlikely(r)) {
 			if (r == -EBUSY && !time_after(jiffies, timeout))
@@ -210,7 +211,7 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 		if (hmm_range->end == end)
 			break;
-		hmm_range->hmm_pfns += MAX_WALK_BYTE >> PAGE_SHIFT;
+		hmm_range->hmm_pfns += max_bytes >> PAGE_SHIFT;
 		hmm_range->start = hmm_range->end;
 	} while (hmm_range->end < end);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a677e38a493b..1a46410a1b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1613,6 +1613,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
+	struct amdgpu_bo *bo;
 	bool clear, unlock;
 	int r;
 
@@ -1632,11 +1633,13 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
+		bo = bo_va->base.bo;
+		resv = bo->tbo.base.resv;
 		spin_unlock(&vm->status_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && dma_resv_trylock(resv)) {
+		if (!adev->debug_vm && !amdgpu_ttm_tt_get_usermm(bo->tbo.ttm) &&
+		    dma_resv_trylock(resv)) {
 			clear = false;
 			unlock = true;
 		/* The caller is already holding the reservation lock */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f95bf6d95534..0a2e3561f6d7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2278,6 +2278,11 @@ static int criu_restore_devices(struct kfd_process *p,
 			ret = -EINVAL;
 			goto exit;
 		}
+
+		if (pdd->drm_file) {
+			ret = -EINVAL;
+			goto exit;
+		}
 		pdd->user_gpu_id = device_buckets[i].user_gpu_id;
 
 		drm_file = fget(device_buckets[i].drm_fd);
@@ -2288,11 +2293,6 @@ static int criu_restore_devices(struct kfd_process *p,
 			goto exit;
 		}
 
-		if (pdd->drm_file) {
-			ret = -EINVAL;
-			goto exit;
-		}
-
 		/* create the vm using render nodes for kfd pdd */
 		if (kfd_process_device_init_vm(pdd, drm_file)) {
 			pr_err("could not init vm for given pdd\n");
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c4cf595abca6..ed5e1e26f51b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -3296,12 +3296,14 @@ static void copy_context_work_handler(struct work_struct *work)
 
 static uint32_t *get_queue_ids(uint32_t num_queues, uint32_t *usr_queue_id_array)
 {
-	size_t array_size = num_queues * sizeof(uint32_t);
-
 	if (!usr_queue_id_array)
 		return NULL;
 
-	return memdup_user(usr_queue_id_array, array_size);
+	if (num_queues > KFD_MAX_NUM_OF_QUEUES_PER_PROCESS)
+		return ERR_PTR(-EINVAL);
+
+	return memdup_user(usr_queue_id_array,
+			   array_size(num_queues, sizeof(uint32_t)));
 }
 
 int resume_queues(struct kfd_process *p,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3d2c603f2085..99d55276ec95 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -3718,6 +3718,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	svms = &p->svms;
 
+	if (!process_info)
+		return -EINVAL;
+
 	mutex_lock(&process_info->lock);
 
 	svm_range_list_lock_and_flush_work(svms, mm);
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 36942467d4ad..c3aff5d0c53d 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3076,6 +3076,10 @@ static bool si_dpm_vblank_too_short(void *handle)
 	/* we never hit the non-gddr5 limit so disable it */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 0;
 
+	/* Disregard vblank time when there are no displays connected */
+	if (!adev->pm.pm_display_cfg.num_display)
+		return false;
+
 	/* Consider zero vblank time too short and disable MCLK switching.
 	 * Note that the vblank time is set to maximum when no displays are attached,
 	 * so we'll still enable MCLK switching in that case.
diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 52151452adf9..76f1fe9b2c91 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -1047,6 +1047,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 	       goto out_unlock;
        }
 
+	idr_replace(&file_priv->object_idr, NULL, args->handle);
 	spin_unlock(&file_priv->table_lock);
 
 	if (obj->dma_buf) {
@@ -1055,6 +1056,7 @@ int drm_gem_change_handle_ioctl(struct drm_device *dev, void *data,
 		if (ret < 0) {
 			spin_lock(&file_priv->table_lock);
 			idr_remove(&file_priv->object_idr, handle);
+			idr_replace(&file_priv->object_idr, obj, args->handle);
 			spin_unlock(&file_priv->table_lock);
 			goto out_unlock;
 		}
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index 051ecc526832..4e6f703a1b33 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -391,8 +391,11 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 		return -ETIMEDOUT;
 	}
 
-	if (msg->resolution_resp.resolution_count == 0) {
-		drm_err(dev, "No supported resolutions\n");
+	if (msg->resolution_resp.resolution_count == 0 ||
+	    msg->resolution_resp.resolution_count >
+	    SYNTHVID_MAX_RESOLUTION_COUNT) {
+		drm_err(dev, "Invalid resolution count: %d\n",
+			msg->resolution_resp.resolution_count);
 		return -ENODEV;
 	}
 
@@ -417,30 +420,92 @@ static int hyperv_get_supported_resolution(struct hv_device *hdev)
 	return 0;
 }
 
-static void hyperv_receive_sub(struct hv_device *hdev)
+static void hyperv_receive_sub(struct hv_device *hdev, u32 bytes_recvd)
 {
 	struct hyperv_drm_device *hv = hv_get_drvdata(hdev);
 	struct synthvid_msg *msg;
+	size_t hdr_size;
+	size_t need;
 
 	if (!hv)
 		return;
 
-	msg = (struct synthvid_msg *)hv->recv_buf;
-
-	/* Complete the wait event */
-	if (msg->vid_hdr.type == SYNTHVID_VERSION_RESPONSE ||
-	    msg->vid_hdr.type == SYNTHVID_RESOLUTION_RESPONSE ||
-	    msg->vid_hdr.type == SYNTHVID_VRAM_LOCATION_ACK) {
-		memcpy(hv->init_buf, msg, VMBUS_MAX_PACKET_SIZE);
-		complete(&hv->wait);
+	hdr_size = sizeof(struct pipe_msg_hdr) +
+		   sizeof(struct synthvid_msg_hdr);
+	if (bytes_recvd < hdr_size) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for header: %u\n",
+				    bytes_recvd);
 		return;
 	}
 
-	if (msg->vid_hdr.type == SYNTHVID_FEATURE_CHANGE) {
+	msg = (struct synthvid_msg *)hv->recv_buf;
+	need = hdr_size;
+
+	switch (msg->vid_hdr.type) {
+	case SYNTHVID_VERSION_RESPONSE:
+		need += sizeof(struct synthvid_version_resp);
+		break;
+	case SYNTHVID_RESOLUTION_RESPONSE:
+		/*
+		 * The resolution response is variable length: the host
+		 * fills resolution_count entries, not the full
+		 * SYNTHVID_MAX_RESOLUTION_COUNT array. Require the fixed
+		 * prefix first so resolution_count can be read, then
+		 * demand exactly the count-sized array.
+		 */
+		need += offsetof(struct synthvid_supported_resolution_resp,
+				 supported_resolution);
+		if (bytes_recvd < need)
+			break;
+		if (msg->resolution_resp.resolution_count >
+		    SYNTHVID_MAX_RESOLUTION_COUNT) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid resolution count too large: %u\n",
+					    msg->resolution_resp.resolution_count);
+			return;
+		}
+		need += msg->resolution_resp.resolution_count *
+			sizeof(struct hvd_screen_info);
+		break;
+	case SYNTHVID_VRAM_LOCATION_ACK:
+		need += sizeof(struct synthvid_vram_location_ack);
+		break;
+	case SYNTHVID_FEATURE_CHANGE:
+		/*
+		 * Not a completion-driving message: validate its own payload
+		 * and consume it here rather than falling through to the
+		 * memcpy/complete shared by the wait-event responses.
+		 */
+		if (bytes_recvd < need +
+		    sizeof(struct synthvid_feature_change)) {
+			drm_err_ratelimited(&hv->dev,
+					    "synthvid feature change packet too small: %u\n",
+					    bytes_recvd);
+			return;
+		}
 		hv->dirt_needed = msg->feature_chg.is_dirt_needed;
 		if (hv->dirt_needed)
 			hyperv_hide_hw_ptr(hv->hdev);
+		return;
+	default:
+		return;
+	}
+
+	/*
+	 * Shared completion path for the wait-event responses
+	 * (VERSION_RESPONSE, RESOLUTION_RESPONSE, VRAM_LOCATION_ACK):
+	 * require the type-specific payload before handing the buffer to
+	 * the waiter.
+	 */
+	if (bytes_recvd < need) {
+		drm_err_ratelimited(&hv->dev,
+				    "synthvid packet too small for type %u: %u < %zu\n",
+				    msg->vid_hdr.type, bytes_recvd, need);
+		return;
 	}
+	memcpy(hv->init_buf, msg, bytes_recvd);
+	complete(&hv->wait);
 }
 
 static void hyperv_receive(void *ctx)
@@ -461,9 +526,21 @@ static void hyperv_receive(void *ctx)
 		ret = vmbus_recvpacket(hdev->channel, recv_buf,
 				       VMBUS_MAX_PACKET_SIZE,
 				       &bytes_recvd, &req_id);
-		if (bytes_recvd > 0 &&
-		    recv_buf->pipe_hdr.type == PIPE_MSG_DATA)
-			hyperv_receive_sub(hdev);
+		if (ret) {
+			/*
+			 * A nonzero return (e.g. -ENOBUFS for an oversized
+			 * packet) is itself a malformed message: bytes_recvd
+			 * then reports the required length rather than a copied
+			 * payload, so it must not be forwarded to the
+			 * sub-handler. Channel recovery is not attempted.
+			 */
+			drm_err_ratelimited(&hv->dev,
+					    "vmbus_recvpacket failed: %d (need %u)\n",
+					    ret, bytes_recvd);
+		} else if (bytes_recvd > 0 &&
+			   recv_buf->pipe_hdr.type == PIPE_MSG_DATA) {
+			hyperv_receive_sub(hdev, bytes_recvd);
+		}
 	} while (bytes_recvd > 0 && ret == 0);
 }
 
@@ -508,9 +585,13 @@ int hyperv_connect_vsp(struct hv_device *hdev)
 		ret = hyperv_get_supported_resolution(hdev);
 		if (ret)
 			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	} else {
+	}
+
+	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
 		hv->screen_height_max = SYNTHVID_HEIGHT_WIN8;
+		hv->preferred_width = SYNTHVID_WIDTH_WIN8;
+		hv->preferred_height = SYNTHVID_HEIGHT_WIN8;
 	}
 
 	hv->mmio_megabytes = hdev->channel->offermsg.offer.mmio_megabytes;
diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index e7950655434b..6d1cffc6d2be 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -3976,7 +3976,7 @@ xelpd_program_plane_pre_csc_lut(struct intel_dsb *dsb,
 				intel_de_write_dsb(display, dsb,
 						   PLANE_PRE_CSC_GAMC_DATA_ENH(pipe, plane, 0),
 						   (1 << 24));
-			} while (i++ > 130);
+			} while (i++ < 130);
 		} else {
 			for (i = 0; i < lut_size; i++) {
 				u32 v = (i * ((1 << 24) - 1)) / (lut_size - 1);
diff --git a/drivers/gpu/drm/i915/display/intel_display_core.h b/drivers/gpu/drm/i915/display/intel_display_core.h
index d708d322aa85..f6976ce9df40 100644
--- a/drivers/gpu/drm/i915/display/intel_display_core.h
+++ b/drivers/gpu/drm/i915/display/intel_display_core.h
@@ -494,6 +494,7 @@ struct intel_display {
 		u8 vblank_enabled;
 
 		int vblank_enable_count;
+		bool vblank_status_last_notified;
 
 		struct work_struct vblank_notify_work;
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_irq.c b/drivers/gpu/drm/i915/display/intel_display_irq.c
index 6e7e4654eb79..ebb1f79e1451 100644
--- a/drivers/gpu/drm/i915/display/intel_display_irq.c
+++ b/drivers/gpu/drm/i915/display/intel_display_irq.c
@@ -1773,8 +1773,12 @@ static void intel_display_vblank_notify_work(struct work_struct *work)
 	struct intel_display *display =
 		container_of(work, typeof(*display), irq.vblank_notify_work);
 	int vblank_enable_count = READ_ONCE(display->irq.vblank_enable_count);
+	bool vblank_status = !!vblank_enable_count;
 
-	intel_psr_notify_vblank_enable_disable(display, vblank_enable_count);
+	if (display->irq.vblank_status_last_notified != vblank_status) {
+		intel_psr_notify_vblank_enable_disable(display, vblank_status);
+		display->irq.vblank_status_last_notified = vblank_status;
+	}
 }
 
 int bdw_enable_vblank(struct drm_crtc *_crtc)
@@ -1787,10 +1791,10 @@ int bdw_enable_vblank(struct drm_crtc *_crtc)
 	if (gen11_dsi_configure_te(crtc, true))
 		return 0;
 
+	spin_lock_irqsave(&display->irq.lock, irqflags);
 	if (crtc->vblank_psr_notify && display->irq.vblank_enable_count++ == 0)
 		schedule_work(&display->irq.vblank_notify_work);
 
-	spin_lock_irqsave(&display->irq.lock, irqflags);
 	bdw_enable_pipe_irq(display, pipe, GEN8_PIPE_VBLANK);
 	spin_unlock_irqrestore(&display->irq.lock, irqflags);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index ced0e5a5989b..0d3006fa3b95 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -583,6 +583,7 @@ struct intel_connector {
 
 		struct {
 			u8 dpcd[EDP_PSR_RECEIVER_CAP_SIZE];
+			u8 intel_wa_dpcd;
 
 			bool support;
 			bool su_support;
@@ -1784,6 +1785,8 @@ struct intel_psr {
 	u8 active_non_psr_pipes;
 
 	const char *no_psr_reason;
+
+	struct ref_tracker *vblank_wakeref;
 };
 
 struct intel_dp {
diff --git a/drivers/gpu/drm/i915/display/intel_dp_aux.c b/drivers/gpu/drm/i915/display/intel_dp_aux.c
index b20ec3e589fa..9c9b6410366d 100644
--- a/drivers/gpu/drm/i915/display/intel_dp_aux.c
+++ b/drivers/gpu/drm/i915/display/intel_dp_aux.c
@@ -12,6 +12,7 @@
 #include "intel_dp.h"
 #include "intel_dp_aux.h"
 #include "intel_dp_aux_regs.h"
+#include "intel_parent.h"
 #include "intel_pps.h"
 #include "intel_quirks.h"
 #include "intel_tc.h"
@@ -60,18 +61,29 @@ intel_dp_aux_wait_done(struct intel_dp *intel_dp)
 	struct intel_display *display = to_intel_display(intel_dp);
 	i915_reg_t ch_ctl = intel_dp->aux_ch_ctl_reg(intel_dp);
 	const unsigned int timeout_ms = 10;
+	bool done = true;
 	u32 status;
-	bool done;
+	int ret;
 
+	if (intel_parent_irq_enabled(display)) {
 #define C (((status = intel_de_read_notrace(display, ch_ctl)) & DP_AUX_CH_CTL_SEND_BUSY) == 0)
-	done = wait_event_timeout(display->gmbus.wait_queue, C,
-				  msecs_to_jiffies_timeout(timeout_ms));
+		done = wait_event_timeout(display->gmbus.wait_queue, C,
+					  msecs_to_jiffies_timeout(timeout_ms));
+
+#undef C
+	} else {
+		ret = intel_de_wait_ms(display, ch_ctl,
+				       DP_AUX_CH_CTL_SEND_BUSY, 0,
+				       timeout_ms, &status);
+
+		if (ret == -ETIMEDOUT)
+			done = false;
+	}
 
 	if (!done)
 		drm_err(display->drm,
 			"%s: did not complete or timeout within %ums (status 0x%08x)\n",
 			intel_dp->aux.name, timeout_ms, status);
-#undef C
 
 	return status;
 }
diff --git a/drivers/gpu/drm/i915/display/intel_dpcd.h b/drivers/gpu/drm/i915/display/intel_dpcd.h
new file mode 100644
index 000000000000..4aea5326f2ed
--- /dev/null
+++ b/drivers/gpu/drm/i915/display/intel_dpcd.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright © 2026 Intel Corporation
+ */
+
+#ifndef __INTEL_DPCD_H__
+#define __INTEL_DPCD_H__
+
+#define INTEL_DPCD_INTEL_WA_REGISTER_CAPS					0x3f0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK	REG_GENMASK(1, 0)
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1			0
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE		1
+# define INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE		2
+
+#endif /* __INTEL_DPCD_H__ */
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 8a7075c4a248..2808d5ab354e 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -43,6 +43,7 @@
 #include "intel_display_utils.h"
 #include "intel_dmc.h"
 #include "intel_dp.h"
+#include "intel_dpcd.h"
 #include "intel_dp_aux.h"
 #include "intel_dsb.h"
 #include "intel_frontbuffer.h"
@@ -708,8 +709,14 @@ static void _psr_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *co
 			    connector->dp.psr_caps.su_support ? "" : "not ");
 	}
 
-	if (connector->dp.psr_caps.su_support)
+	if (connector->dp.psr_caps.su_support) {
+		ret = drm_dp_dpcd_read_byte(&intel_dp->aux,
+					    INTEL_DPCD_INTEL_WA_REGISTER_CAPS,
+					    &connector->dp.psr_caps.intel_wa_dpcd);
+		if (ret < 0)
+			return;
 		_psr_compute_su_granularity(intel_dp, connector);
+	}
 }
 
 void intel_psr_init_dpcd(struct intel_dp *intel_dp, struct intel_connector *connector)
@@ -1350,9 +1357,35 @@ static bool psr2_granularity_check(struct intel_crtc_state *crtc_state,
 	return true;
 }
 
-static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_dp,
-							struct intel_crtc_state *crtc_state)
+static bool apply_scanline_indication_wa(struct intel_crtc_state *crtc_state,
+					 struct intel_connector *connector)
 {
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
+	u8 early_scanline_support = connector->dp.psr_caps.intel_wa_dpcd &
+		INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_EARLYSCANLINE_SDP_SUPPORT_MASK;
+
+	if (intel_dp->edp_dpcd[0] >= DP_EDP_15)
+		return true;
+
+	switch (early_scanline_support)	{
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_FALL_BACK_TO_PSR1:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return false;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITH_EARLY_SCANLINE:
+		return true;
+	case INTEL_DPCD_INTEL_WA_REGISTER_CAPS_PSR2_WITHOUT_EARLY_SCANLINE:
+		crtc_state->req_psr2_sdp_prior_scanline = false;
+		return true;
+	default:
+		MISSING_CASE(early_scanline_support);
+		return false;
+	}
+}
+
+static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_crtc_state *crtc_state,
+							struct intel_connector *connector)
+{
+	struct intel_dp *intel_dp = intel_attached_dp(connector);
 	struct intel_display *display = to_intel_display(intel_dp);
 	const struct drm_display_mode *adjusted_mode = &crtc_state->uapi.adjusted_mode;
 	u32 hblank_total, hblank_ns, req_ns;
@@ -1371,7 +1404,8 @@ static bool _compute_psr2_sdp_prior_scanline_indication(struct intel_dp *intel_d
 		return false;
 
 	crtc_state->req_psr2_sdp_prior_scanline = true;
-	return true;
+
+	return apply_scanline_indication_wa(crtc_state, connector);
 }
 
 static int intel_psr_entry_setup_frames(struct intel_dp *intel_dp,
@@ -1653,7 +1687,7 @@ static bool intel_sel_update_config_valid(struct intel_crtc_state *crtc_state,
 								      conn_state))
 		goto unsupported;
 
-	if (!_compute_psr2_sdp_prior_scanline_indication(intel_dp, crtc_state)) {
+	if (!_compute_psr2_sdp_prior_scanline_indication(crtc_state, connector)) {
 		drm_dbg_kms(display->drm,
 			    "Selective update not enabled, SDP indication do not fit in hblank\n");
 		goto unsupported;
@@ -4112,27 +4146,22 @@ void intel_psr_notify_vblank_enable_disable(struct intel_display *display,
 		struct intel_dp *intel_dp = enc_to_intel_dp(encoder);
 
 		mutex_lock(&intel_dp->psr.lock);
-		if (intel_dp->psr.panel_replay_enabled) {
-			mutex_unlock(&intel_dp->psr.lock);
-			break;
+		if (CAN_PANEL_REPLAY(intel_dp)) {
+			if (enable)
+				intel_dp->psr.vblank_wakeref =
+					intel_display_power_get(display,
+								POWER_DOMAIN_DC_OFF);
+			else
+				intel_display_power_put(display, POWER_DOMAIN_DC_OFF,
+							intel_dp->psr.vblank_wakeref);
 		}
 
-		if (intel_dp->psr.enabled && intel_dp->psr.pkg_c_latency_used)
+		if (intel_dp->psr.enabled && !intel_dp->psr.panel_replay_enabled &&
+		    intel_dp->psr.pkg_c_latency_used)
 			intel_psr_apply_underrun_on_idle_wa_locked(intel_dp);
 
 		mutex_unlock(&intel_dp->psr.lock);
-		return;
 	}
-
-	/*
-	 * NOTE: intel_display_power_set_target_dc_state is used
-	 * only by PSR * code for DC3CO handling. DC3CO target
-	 * state is currently disabled in * PSR code. If DC3CO
-	 * is taken into use we need take that into account here
-	 * as well.
-	 */
-	intel_display_power_set_target_dc_state(display, enable ? DC_STATE_DISABLE :
-						DC_STATE_EN_UPTO_DC6);
 }
 
 static void
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
index 033eda38e4b5..e0e12cb627ef 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_ttm.c
@@ -419,8 +419,6 @@ void i915_ttm_free_cached_io_rsgt(struct drm_i915_gem_object *obj)
 int i915_ttm_purge(struct drm_i915_gem_object *obj)
 {
 	struct ttm_buffer_object *bo = i915_gem_to_ttm(obj);
-	struct i915_ttm_tt *i915_tt =
-		container_of(bo->ttm, typeof(*i915_tt), ttm);
 	struct ttm_operation_ctx ctx = {
 		.interruptible = true,
 		.no_wait_gpu = false,
@@ -435,16 +433,22 @@ int i915_ttm_purge(struct drm_i915_gem_object *obj)
 	if (ret)
 		return ret;
 
-	if (bo->ttm && i915_tt->filp) {
-		/*
-		 * The below fput(which eventually calls shmem_truncate) might
-		 * be delayed by worker, so when directly called to purge the
-		 * pages(like by the shrinker) we should try to be more
-		 * aggressive and release the pages immediately.
-		 */
-		shmem_truncate_range(file_inode(i915_tt->filp),
-				     0, (loff_t)-1);
-		fput(fetch_and_zero(&i915_tt->filp));
+	if (bo->ttm) {
+		struct i915_ttm_tt *i915_tt =
+			container_of(bo->ttm, typeof(*i915_tt), ttm);
+
+		if (i915_tt->filp) {
+			/*
+			 * The below fput(which eventually calls shmem_truncate)
+			 * might be delayed by worker, so when directly called
+			 * to purge the pages(like by the shrinker) we should
+			 * try to be more aggressive and release the pages
+			 * immediately.
+			 */
+			shmem_truncate_range(file_inode(i915_tt->filp),
+					     0, (loff_t)-1);
+			fput(fetch_and_zero(&i915_tt->filp));
+		}
 	}
 
 	obj->write_domain = 0;
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index f4cbc030f4c8..904225cbff0d 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -770,6 +770,11 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
 		}
 	}
 
+	if (XE_GT_WA(hwe->gt, 16023105232))
+		guc_mmio_regset_write_one(ads, regset_map,
+					  RING_IDLEDLY(hwe->mmio_base),
+					  count++);
+
 	return count;
 }
 
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c1e4a6ce9631..1b634801fe7b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1261,6 +1261,7 @@
 
 #define USB_VENDOR_ID_SIGMA_MICRO	0x1c4f
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD	0x0002
+#define USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE	0x0034
 #define USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD2	0x0059
 
 #define USB_VENDOR_ID_SIGMATEL		0x066F
diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
index 5e754b0a5032..93b21cd7ddc0 100644
--- a/drivers/hid/hid-quirks.c
+++ b/drivers/hid/hid-quirks.c
@@ -186,6 +186,7 @@ static const struct hid_device_id hid_quirks[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SEMICO, USB_DEVICE_ID_SEMICO_USB_KEYKOARD), HID_QUIRK_NO_INIT_REPORTS },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SENNHEISER, USB_DEVICE_ID_SENNHEISER_BTD500USB), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_KEYBOARD), HID_QUIRK_NO_INIT_REPORTS },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMA_MICRO, USB_DEVICE_ID_SIGMA_MICRO_USB_MOUSE), HID_QUIRK_ALWAYS_POLL },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIGMATEL, USB_DEVICE_ID_SIGMATEL_STMP3780), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS1030_TOUCH), HID_QUIRK_NOGET },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SIS_TOUCH, USB_DEVICE_ID_SIS817_TOUCH), HID_QUIRK_NOGET },
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index a32320b351e3..2220168bf116 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -356,6 +356,7 @@ static void wacom_feature_mapping(struct hid_device *hdev,
 
 		hid_data->inputmode = field->report->id;
 		hid_data->inputmode_index = usage->usage_index;
+		hid_data->inputmode_field_index = field->index;
 		break;
 
 	case HID_UP_DIGITIZER:
@@ -571,9 +572,14 @@ static int wacom_hid_set_device_mode(struct hid_device *hdev)
 
 	re = &(hdev->report_enum[HID_FEATURE_REPORT]);
 	r = re->report_id_hash[hid_data->inputmode];
-	if (r) {
-		r->field[0]->value[hid_data->inputmode_index] = 2;
-		hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+	if (r && hid_data->inputmode_field_index >= 0 &&
+	    hid_data->inputmode_field_index < r->maxfield) {
+		struct hid_field *field = r->field[hid_data->inputmode_field_index];
+
+		if (field && hid_data->inputmode_index < field->report_count) {
+			field->value[hid_data->inputmode_index] = 2;
+			hid_hw_request(hdev, r, HID_REQ_SET_REPORT);
+		}
 	}
 	return 0;
 }
@@ -2846,6 +2852,7 @@ static int wacom_probe(struct hid_device *hdev,
 		return -ENODEV;
 
 	wacom_wac->hid_data.inputmode = -1;
+	wacom_wac->hid_data.inputmode_field_index = -1;
 	wacom_wac->mode_report = -1;
 
 	if (hid_is_usb(hdev)) {
diff --git a/drivers/hid/wacom_wac.h b/drivers/hid/wacom_wac.h
index d4f7d8ca1e7e..126bec6e5c0c 100644
--- a/drivers/hid/wacom_wac.h
+++ b/drivers/hid/wacom_wac.h
@@ -295,6 +295,7 @@ struct wacom_shared {
 struct hid_data {
 	__s16 inputmode;	/* InputMode HID feature, -1 if non-existent */
 	__s16 inputmode_index;	/* InputMode HID feature index in the report */
+	__s16 inputmode_field_index; /* InputMode HID feature field index in the report */
 	bool sense_state;
 	bool inrange_state;
 	bool eraser;
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 9631a64cb1eb..58917ef0f304 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -173,6 +173,8 @@ static int adm1266_gpio_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		pmbus_cmd = ADM1266_PDIO_STATUS;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, pmbus_cmd, read_buf);
 	if (ret < 0)
 		return ret;
@@ -195,6 +197,8 @@ static int adm1266_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask
 	unsigned int gpio_nr;
 	int ret;
 
+	guard(pmbus_lock)(data->client);
+
 	ret = i2c_smbus_read_block_data(data->client, ADM1266_GPIO_STATUS, read_buf);
 	if (ret < 0)
 		return ret;
@@ -236,6 +240,8 @@ static void adm1266_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 	int ret;
 	int i;
 
+	guard(pmbus_lock)(data->client);
+
 	for (i = 0; i < ADM1266_GPIO_NR; i++) {
 		write_cmd = adm1266_gpio_mapping[i][1];
 		ret = adm1266_pmbus_block_xfer(data, ADM1266_GPIO_CONFIG, 1, &write_cmd, read_buf);
@@ -328,6 +334,7 @@ static int adm1266_state_read(struct seq_file *s, void *pdata)
 	struct i2c_client *client = to_i2c_client(dev);
 	int ret;
 
+	guard(pmbus_lock)(client);
 	ret = i2c_smbus_read_word_data(client, ADM1266_READ_STATE);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index d2e9bfb5320f..e499cdae9442 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -10,6 +10,7 @@
 #define PMBUS_H
 
 #include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/regulator/driver.h>
 
 /*
@@ -563,7 +564,11 @@ int pmbus_get_fan_rate_device(struct i2c_client *client, int page, int id,
 int pmbus_get_fan_rate_cached(struct i2c_client *client, int page, int id,
 			      enum pmbus_fan_mode mode);
 int pmbus_lock_interruptible(struct i2c_client *client);
+void pmbus_lock(struct i2c_client *client);
 void pmbus_unlock(struct i2c_client *client);
+
+DEFINE_GUARD(pmbus_lock, struct i2c_client *, pmbus_lock(_T), pmbus_unlock(_T))
+
 int pmbus_update_fan(struct i2c_client *client, int page, int id,
 		     u8 config, u8 mask, u16 command);
 struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client);
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 572be3ebc03d..7150f12d2630 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -3871,6 +3871,14 @@ struct dentry *pmbus_get_debugfs_dir(struct i2c_client *client)
 }
 EXPORT_SYMBOL_NS_GPL(pmbus_get_debugfs_dir, "PMBUS");
 
+void pmbus_lock(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	mutex_lock(&data->update_lock);
+}
+EXPORT_SYMBOL_NS_GPL(pmbus_lock, "PMBUS");
+
 int pmbus_lock_interruptible(struct i2c_client *client)
 {
 	struct pmbus_data *data = i2c_get_clientdata(client);
diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index a773ba082321..66c23535656b 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -117,7 +117,7 @@
 /* timeout for pm runtime autosuspend */
 #define DAVINCI_I2C_PM_TIMEOUT	1000	/* ms */
 
-#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100
+#define DAVINCI_I2C_DEFAULT_BUS_FREQ	100000
 
 struct davinci_i2c_dev {
 	struct device           *dev;
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index b8d7a406ef04..23c9b91b14dd 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -445,25 +445,22 @@ static int tegra_i2c_mutex_lock(struct tegra_i2c_dev *i2c_dev)
 	return ret;
 }
 
-static int tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
+static void tegra_i2c_mutex_unlock(struct tegra_i2c_dev *i2c_dev)
 {
 	unsigned int reg = tegra_i2c_reg_addr(i2c_dev, I2C_SW_MUTEX);
 	u32 val, id;
 
 	if (!i2c_dev->hw->has_mutex)
-		return 0;
+		return;
 
 	val = readl(i2c_dev->base + reg);
 
 	id = FIELD_GET(I2C_SW_MUTEX_GRANT, val);
-	if (id && id != I2C_SW_MUTEX_ID_CCPLEX) {
-		dev_warn(i2c_dev->dev, "unable to unlock mutex, mutex is owned by: %u\n", id);
-		return -EPERM;
-	}
+	if (WARN(id && id != I2C_SW_MUTEX_ID_CCPLEX,
+		 "unable to unlock mutex, mutex is owned by: %u\n", id))
+		return;
 
 	writel(0, i2c_dev->base + reg);
-
-	return 0;
 }
 
 static void tegra_i2c_mask_irq(struct tegra_i2c_dev *i2c_dev, u32 mask)
@@ -1556,7 +1553,7 @@ static int tegra_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[],
 			break;
 	}
 
-	ret = tegra_i2c_mutex_unlock(i2c_dev);
+	tegra_i2c_mutex_unlock(i2c_dev);
 	pm_runtime_put(i2c_dev->dev);
 
 	return ret ?: i;
diff --git a/drivers/iio/adc/ad4695.c b/drivers/iio/adc/ad4695.c
index cda419638d9a..53642de7330d 100644
--- a/drivers/iio/adc/ad4695.c
+++ b/drivers/iio/adc/ad4695.c
@@ -876,14 +876,14 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err_unoptimize_message;
 
-	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
-					 &config);
+	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
 	if (ret)
 		goto err_disable_busy_output;
 
-	ret = ad4695_enter_advanced_sequencer_mode(st, num_slots);
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
 	if (ret)
-		goto err_offload_trigger_disable;
+		goto err_exit_conversion_mode;
 
 	mutex_lock(&st->cnv_pwm_lock);
 	pwm_get_state(st->cnv_pwm, &state);
@@ -895,23 +895,16 @@ static int ad4695_offload_buffer_postenable(struct iio_dev *indio_dev)
 	ret = pwm_apply_might_sleep(st->cnv_pwm, &state);
 	mutex_unlock(&st->cnv_pwm_lock);
 	if (ret)
-		goto err_offload_exit_conversion_mode;
+		goto err_offload_trigger_disable;
 
 	return 0;
 
-err_offload_exit_conversion_mode:
-	/*
-	 * We have to unwind in a different order to avoid triggering offload.
-	 * ad4695_exit_conversion_mode() triggers a conversion, so it has to be
-	 * done after spi_offload_trigger_disable().
-	 */
-	spi_offload_trigger_disable(st->offload, st->offload_trigger);
-	ad4695_exit_conversion_mode(st);
-	goto err_disable_busy_output;
-
 err_offload_trigger_disable:
 	spi_offload_trigger_disable(st->offload, st->offload_trigger);
 
+err_exit_conversion_mode:
+	ad4695_exit_conversion_mode(st);
+
 err_disable_busy_output:
 	regmap_clear_bits(st->regmap, AD4695_REG_GP_MODE,
 			  AD4695_REG_GP_MODE_BUSY_GP_EN);
diff --git a/drivers/iio/adc/mt6359-auxadc.c b/drivers/iio/adc/mt6359-auxadc.c
index f426a289e867..67ca23d37a21 100644
--- a/drivers/iio/adc/mt6359-auxadc.c
+++ b/drivers/iio/adc/mt6359-auxadc.c
@@ -497,6 +497,7 @@ static int mt6358_read_imp(struct mt6359_auxadc *adc_dev,
 		return ret;
 
 	/* Read the params before stopping */
+	val_v = 0;
 	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
 
 	mt6358_stop_imp_conv(adc_dev);
diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
index c8283873cdee..0418ecfbabaa 100644
--- a/drivers/iio/adc/npcm_adc.c
+++ b/drivers/iio/adc/npcm_adc.c
@@ -231,7 +231,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	if (IS_ERR(info->reset))
 		return PTR_ERR(info->reset);
 
-	info->adc_clk = devm_clk_get(&pdev->dev, NULL);
+	info->adc_clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(info->adc_clk)) {
 		dev_warn(&pdev->dev, "ADC clock failed: can't read clk\n");
 		return PTR_ERR(info->adc_clk);
@@ -244,17 +244,13 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	info->adc_sample_hz = clk_get_rate(info->adc_clk) / ((div + 1) * 2);
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		ret = irq;
-		goto err_disable_clk;
-	}
+	if (irq < 0)
+		return irq;
 
 	ret = devm_request_irq(&pdev->dev, irq, npcm_adc_isr, 0,
 			       "NPCM_ADC", indio_dev);
-	if (ret < 0) {
-		dev_err(dev, "failed requesting interrupt\n");
-		goto err_disable_clk;
-	}
+	if (ret < 0)
+		return ret;
 
 	reg_con = ioread32(info->regs + NPCM_ADCCON);
 	info->vref = devm_regulator_get_optional(&pdev->dev, "vref");
@@ -262,7 +258,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		ret = regulator_enable(info->vref);
 		if (ret) {
 			dev_err(&pdev->dev, "Can't enable ADC reference voltage\n");
-			goto err_disable_clk;
+			return ret;
 		}
 
 		iowrite32(reg_con & ~NPCM_ADCCON_REFSEL,
@@ -272,10 +268,8 @@ static int npcm_adc_probe(struct platform_device *pdev)
 		 * Any error which is not ENODEV indicates the regulator
 		 * has been specified and so is a failure case.
 		 */
-		if (PTR_ERR(info->vref) != -ENODEV) {
-			ret = PTR_ERR(info->vref);
-			goto err_disable_clk;
-		}
+		if (PTR_ERR(info->vref) != -ENODEV)
+			return PTR_ERR(info->vref);
 
 		/* Use internal reference */
 		iowrite32(reg_con | NPCM_ADCCON_REFSEL,
@@ -314,8 +308,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
 	iowrite32(reg_con & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-err_disable_clk:
-	clk_disable_unprepare(info->adc_clk);
 
 	return ret;
 }
@@ -332,7 +324,6 @@ static void npcm_adc_remove(struct platform_device *pdev)
 	iowrite32(regtemp & ~NPCM_ADCCON_ADC_EN, info->regs + NPCM_ADCCON);
 	if (!IS_ERR(info->vref))
 		regulator_disable(info->vref);
-	clk_disable_unprepare(info->adc_clk);
 }
 
 static struct platform_driver npcm_adc_driver = {
diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 58103bf16aff..9f6724355687 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,6 +198,15 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+{
+	u64 rate;
+
+	rate = clk_get_rate(info->clk);
+	if (rate)
+		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+}
+
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 {
 	u32 mcr;
@@ -221,7 +230,7 @@ static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
 	 * configuration of NCMR and the setting of NSTART.
 	 */
 	if (enable)
-		ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk) * 3));
+		nxp_sar_adc_wait_for(info, 3);
 
 	return pwdn;
 }
@@ -468,7 +477,7 @@ static void nxp_sar_adc_stop_conversion(struct nxp_sar_adc *info)
 	 * only when the capture finishes. The delay will be very
 	 * short, usec-ish, which is acceptable in the atomic context.
 	 */
-	ndelay(div64_u64(NSEC_PER_SEC, clk_get_rate(info->clk)) * 80);
+	nxp_sar_adc_wait_for(info, 80);
 }
 
 static int nxp_sar_adc_start_conversion(struct nxp_sar_adc *info, bool raw)
@@ -559,6 +568,9 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		/*
 		 * Configures the sample period duration in terms of the SAR
 		 * controller clock. The minimum acceptable value is 8.
@@ -567,7 +579,11 @@ static int nxp_sar_adc_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 		 * sampling timing which gives us the number of cycles expected.
 		 * The value is 8-bit wide, consequently the max value is 0xFF.
 		 */
-		inpsamp = clk_get_rate(info->clk) / val - NXP_SAR_ADC_CONV_TIME;
+		inpsamp = clk_get_rate(info->clk) / val;
+		if (inpsamp < NXP_SAR_ADC_CONV_TIME)
+			return -EINVAL;
+
+		inpsamp -= NXP_SAR_ADC_CONV_TIME;
 		nxp_sar_adc_conversion_timing_set(info, inpsamp);
 		return 0;
 
@@ -659,7 +675,7 @@ static void nxp_sar_adc_dma_cb(void *data)
 static int nxp_sar_adc_start_cyclic_dma(struct iio_dev *indio_dev)
 {
 	struct nxp_sar_adc *info = iio_priv(indio_dev);
-	struct dma_slave_config config;
+	struct dma_slave_config config = { };
 	struct dma_async_tx_descriptor *desc;
 	int ret;
 
diff --git a/drivers/iio/adc/viperboard_adc.c b/drivers/iio/adc/viperboard_adc.c
index 9bb0b83c8f67..6efe1c618ef7 100644
--- a/drivers/iio/adc/viperboard_adc.c
+++ b/drivers/iio/adc/viperboard_adc.c
@@ -70,8 +70,10 @@ static int vprbrd_iio_read_raw(struct iio_dev *iio_dev,
 			VPRBRD_USB_TYPE_OUT, 0x0000, 0x0000, admsg,
 			sizeof(struct vprbrd_adc_msg), VPRBRD_USB_TIMEOUT_MS);
 		if (ret != sizeof(struct vprbrd_adc_msg)) {
-			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			mutex_unlock(&vb->lock);
 			error = -EREMOTEIO;
+			dev_err(&iio_dev->dev, "usb send error on adc read\n");
+			goto error;
 		}
 
 		ret = usb_control_msg(vb->usb_dev,
diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e257c1b94a5f..3980dfacbcd7 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -817,6 +817,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long scan_mask;
+	int seq_mode;
 	int ret;
 	int i;
 
@@ -824,6 +825,12 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	for (i = 0; i < indio_dev->num_channels; i++)
 		scan_mask |= BIT(indio_dev->channels[i].scan_index);
 
+	/*
+	 * Use the correct sequencer mode for the idle state: simultaneous
+	 * mode for dual external mux configurations, continuous otherwise.
+	 */
+	seq_mode = xadc_get_seq_mode(xadc, scan_mask);
+
 	/* Enable all channels and calibration */
 	ret = xadc_write_adc_reg(xadc, XADC_REG_SEQ(0), scan_mask & 0xffff);
 	if (ret)
@@ -834,11 +841,11 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 		return ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_CONTINUOUS);
+				  seq_mode);
 	if (ret)
 		return ret;
 
-	return xadc_power_adc_b(xadc, XADC_CONF1_SEQ_CONTINUOUS);
+	return xadc_power_adc_b(xadc, seq_mode);
 }
 
 static int xadc_preenable(struct iio_dev *indio_dev)
diff --git a/drivers/iio/buffer/industrialio-hw-consumer.c b/drivers/iio/buffer/industrialio-hw-consumer.c
index cb771ef8eeb3..861b43e877c2 100644
--- a/drivers/iio/buffer/industrialio-hw-consumer.c
+++ b/drivers/iio/buffer/industrialio-hw-consumer.c
@@ -82,7 +82,7 @@ static struct hw_consumer_buffer *iio_hw_consumer_get_buffer(
  */
 struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 {
-	struct hw_consumer_buffer *buf;
+	struct hw_consumer_buffer *buf, *tmp;
 	struct iio_hw_consumer *hwc;
 	struct iio_channel *chan;
 	int ret;
@@ -113,7 +113,7 @@ struct iio_hw_consumer *iio_hw_consumer_alloc(struct device *dev)
 	return hwc;
 
 err_put_buffers:
-	list_for_each_entry(buf, &hwc->buffers, head)
+	list_for_each_entry_safe(buf, tmp, &hwc->buffers, head)
 		iio_buffer_put(&buf->buffer);
 	iio_channel_release_all(hwc->channels);
 err_free_hwc:
diff --git a/drivers/iio/chemical/mhz19b.c b/drivers/iio/chemical/mhz19b.c
index 3c64154918b1..9d4cf432919e 100644
--- a/drivers/iio/chemical/mhz19b.c
+++ b/drivers/iio/chemical/mhz19b.c
@@ -52,6 +52,8 @@ struct mhz19b_state {
 	struct completion buf_ready;
 
 	u8 buf_idx;
+	bool buf_overflow;
+
 	/*
 	 * Serdev receive buffer.
 	 * When data is received from the MH-Z19B,
@@ -106,6 +108,10 @@ static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, u16 arg)
 	cmd_buf[8] = mhz19b_get_checksum(cmd_buf);
 
 	/* Write buf to uart ctrl synchronously */
+	st->buf_idx = 0;
+	st->buf_overflow = false;
+	reinit_completion(&st->buf_ready);
+
 	ret = serdev_device_write(serdev, cmd_buf, MHZ19B_CMD_SIZE, 0);
 	if (ret < 0)
 		return ret;
@@ -121,6 +127,9 @@ static int mhz19b_serdev_cmd(struct iio_dev *indio_dev, int cmd, u16 arg)
 		if (!ret)
 			return -ETIMEDOUT;
 
+		if (st->buf_overflow)
+			return -EMSGSIZE;
+
 		if (st->buf[8] != mhz19b_get_checksum(st->buf)) {
 			dev_err(dev, "checksum err");
 			return -EINVAL;
@@ -240,6 +249,14 @@ static size_t mhz19b_receive_buf(struct serdev_device *serdev,
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(&serdev->dev);
 	struct mhz19b_state *st = iio_priv(indio_dev);
+	size_t remaining = MHZ19B_CMD_SIZE - st->buf_idx;
+
+	if (len > remaining) {
+		st->buf_idx = 0;
+		st->buf_overflow = true;
+		complete(&st->buf_ready);
+		return len;
+	}
 
 	memcpy(st->buf + st->buf_idx, data, len);
 	st->buf_idx += len;
diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..11d6bc1b63e6 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -256,7 +256,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;
diff --git a/drivers/iio/common/ssp_sensors/ssp_dev.c b/drivers/iio/common/ssp_sensors/ssp_dev.c
index da09c9f3ceb6..e2538a84c812 100644
--- a/drivers/iio/common/ssp_sensors/ssp_dev.c
+++ b/drivers/iio/common/ssp_sensors/ssp_dev.c
@@ -590,6 +590,7 @@ static void ssp_remove(struct spi_device *spi)
 	ssp_clean_pending_list(data);
 
 	free_irq(data->spi->irq, data);
+	cancel_delayed_work_sync(&data->work_refresh);
 
 	timer_delete_sync(&data->wdt_timer);
 	cancel_work_sync(&data->work_wdt);
diff --git a/drivers/iio/dac/ad3530r.c b/drivers/iio/dac/ad3530r.c
index b97b46090d80..d9db3226ecd6 100644
--- a/drivers/iio/dac/ad3530r.c
+++ b/drivers/iio/dac/ad3530r.c
@@ -105,6 +105,12 @@ static const char * const ad3530r_powerdown_modes[] = {
 	"32kohm_to_gnd",
 };
 
+static const char * const ad3531r_powerdown_modes[] = {
+	"500ohm_to_gnd",
+	"3.85kohm_to_gnd",
+	"16kohm_to_gnd",
+};
+
 static int ad3530r_get_powerdown_mode(struct iio_dev *indio_dev,
 				      const struct iio_chan_spec *chan)
 {
@@ -133,6 +139,13 @@ static const struct iio_enum ad3530r_powerdown_mode_enum = {
 	.set = ad3530r_set_powerdown_mode,
 };
 
+static const struct iio_enum ad3531r_powerdown_mode_enum = {
+	.items = ad3531r_powerdown_modes,
+	.num_items = ARRAY_SIZE(ad3531r_powerdown_modes),
+	.get = ad3530r_get_powerdown_mode,
+	.set = ad3530r_set_powerdown_mode,
+};
+
 static ssize_t ad3530r_get_dac_powerdown(struct iio_dev *indio_dev,
 					 uintptr_t private,
 					 const struct iio_chan_spec *chan,
@@ -276,7 +289,20 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
 	{ }
 };
 
-#define AD3530R_CHAN(_chan)					\
+static const struct iio_chan_spec_ext_info ad3531r_ext_info[] = {
+	{
+		.name = "powerdown",
+		.shared = IIO_SEPARATE,
+		.read = ad3530r_get_dac_powerdown,
+		.write = ad3530r_set_dac_powerdown,
+	},
+	IIO_ENUM("powerdown_mode", IIO_SEPARATE, &ad3531r_powerdown_mode_enum),
+	IIO_ENUM_AVAILABLE("powerdown_mode", IIO_SHARED_BY_TYPE,
+			   &ad3531r_powerdown_mode_enum),
+	{ }
+};
+
+#define AD3530R_CHAN(_chan, _ext_info)				\
 {								\
 	.type = IIO_VOLTAGE,					\
 	.indexed = 1,						\
@@ -284,25 +310,25 @@ static const struct iio_chan_spec_ext_info ad3530r_ext_info[] = {
 	.output = 1,						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
 			      BIT(IIO_CHAN_INFO_SCALE),		\
-	.ext_info = ad3530r_ext_info,				\
+	.ext_info = _ext_info,					\
 }
 
 static const struct iio_chan_spec ad3530r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
-	AD3530R_CHAN(4),
-	AD3530R_CHAN(5),
-	AD3530R_CHAN(6),
-	AD3530R_CHAN(7),
+	AD3530R_CHAN(0, ad3530r_ext_info),
+	AD3530R_CHAN(1, ad3530r_ext_info),
+	AD3530R_CHAN(2, ad3530r_ext_info),
+	AD3530R_CHAN(3, ad3530r_ext_info),
+	AD3530R_CHAN(4, ad3530r_ext_info),
+	AD3530R_CHAN(5, ad3530r_ext_info),
+	AD3530R_CHAN(6, ad3530r_ext_info),
+	AD3530R_CHAN(7, ad3530r_ext_info),
 };
 
 static const struct iio_chan_spec ad3531r_channels[] = {
-	AD3530R_CHAN(0),
-	AD3530R_CHAN(1),
-	AD3530R_CHAN(2),
-	AD3530R_CHAN(3),
+	AD3530R_CHAN(0, ad3531r_ext_info),
+	AD3530R_CHAN(1, ad3531r_ext_info),
+	AD3530R_CHAN(2, ad3531r_ext_info),
+	AD3530R_CHAN(3, ad3531r_ext_info),
 };
 
 static const struct ad3530r_chip_info ad3530_chip = {
diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4b18498aa074..a7213bc6b156 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,22 +25,37 @@ static const char * const ad5686_powerdown_modes[] = {
 	"three_state"
 };
 
+static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
+{
+	if (chan->channel == chan->address)
+		return chan->channel * 2;
+
+	/* one-hot encoding is used in dual/quad channel devices */
+	return __ffs(chan->address) * 2;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	guard(mutex)(&st->lock);
+
+	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	guard(mutex)(&st->lock);
+
+	st->pwr_down_mode &= ~(0x3U << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -55,10 +70,12 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	guard(mutex)(&st->lock);
+
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -77,10 +94,12 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
+	guard(mutex)(&st->lock);
+
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -154,7 +173,7 @@ static int ad5686_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > (1 << chan->scan_type.realbits) || val < 0)
+		if (val >= (1 << chan->scan_type.realbits) || val < 0)
 			return -EINVAL;
 
 		mutex_lock(&st->lock);
@@ -460,7 +479,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	bool has_external_vref;
 	u8 cmd;
 	int ret, i;
@@ -484,9 +503,18 @@ int ad5686_probe(struct device *dev,
 	has_external_vref = ret != -ENODEV;
 	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
+	/* Initialize masks to all ones provided the max shift (last channel) */
+	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
+	st->pwr_down_mask = GENMASK(shift + 1, 0);
+	st->pwr_down_mode = GENMASK(shift + 1, 0);
+
 	/* Set all the power down mode for all channels to 1K pulldown */
-	for (i = 0; i < st->chip_info->num_channels; i++)
-		st->pwr_down_mode |= (0x01 << (i * 2));
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
+		st->pwr_down_mask &= ~(0x3U << shift); /* powered up state */
+		st->pwr_down_mode &= ~(0x3U << shift);
+		st->pwr_down_mode |= 0x01U << shift;
+	}
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;
@@ -509,7 +537,7 @@ int ad5686_probe(struct device *dev,
 		break;
 	case AD5686_REGMAP:
 		cmd = AD5686_CMD_INTERNAL_REFER_SETUP;
-		ref_bit_msk = 0;
+		ref_bit_msk = AD5686_REF_BIT_MSK;
 		break;
 	case AD5693_REGMAP:
 		cmd = AD5686_CMD_CONTROL_REG;
@@ -520,9 +548,9 @@ int ad5686_probe(struct device *dev,
 		return -EINVAL;
 	}
 
-	val = (has_external_vref | ref_bit_msk);
+	val = has_external_vref ? ref_bit_msk : 0;
 
-	ret = st->write(st, cmd, 0, !!val);
+	ret = st->write(st, cmd, 0, val);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
index e7d36bae3e59..36e16c5c4581 100644
--- a/drivers/iio/dac/ad5686.h
+++ b/drivers/iio/dac/ad5686.h
@@ -46,6 +46,7 @@
 
 #define AD5310_REF_BIT_MSK			BIT(8)
 #define AD5683_REF_BIT_MSK			BIT(12)
+#define AD5686_REF_BIT_MSK			BIT(0)
 #define AD5693_REF_BIT_MSK			BIT(12)
 
 /**
diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index e7e29359f8fe..dd4e35460195 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -90,6 +90,7 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 				       const struct iio_chan_spec *chan)
 {
 	u8 outbuf[2];
+	int ret;
 
 	outbuf[0] = MAX5821_EXTENDED_COMMAND_MODE;
 
@@ -103,7 +104,13 @@ static int max5821_sync_powerdown_mode(struct max5821_data *data,
 	else
 		outbuf[1] |= MAX5821_EXTENDED_POWER_UP;
 
-	return i2c_master_send(data->client, outbuf, 2);
+	ret = i2c_master_send(data->client, outbuf, sizeof(outbuf));
+	if (ret < 0)
+		return ret;
+	if (ret != sizeof(outbuf))
+		return -EIO;
+
+	return 0;
 }
 
 static ssize_t max5821_write_dac_powerdown(struct iio_dev *indio_dev,
diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 586e6cfa14a9..91b9c5f18ec4 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -287,6 +287,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else
diff --git a/drivers/iio/gyro/itg3200_buffer.c b/drivers/iio/gyro/itg3200_buffer.c
index cf97adfa9727..87efa2c74ca4 100644
--- a/drivers/iio/gyro/itg3200_buffer.c
+++ b/drivers/iio/gyro/itg3200_buffer.c
@@ -34,7 +34,7 @@ static int itg3200_read_all_channels(struct i2c_client *i2c, __be16 *buf)
 			.addr = i2c->addr,
 			.flags = i2c->flags | I2C_M_RD,
 			.len = ITG3200_SCAN_ELEMENTS * sizeof(s16),
-			.buf = (char *)&buf,
+			.buf = (char *)buf,
 		},
 	};
 
diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
index 1f2af506f4bd..75679612052f 100644
--- a/drivers/iio/imu/adis16550.c
+++ b/drivers/iio/imu/adis16550.c
@@ -836,7 +836,7 @@ static irqreturn_t adis16550_trigger_handler(int irq, void *p)
 	u16 dummy;
 	bool valid;
 	struct iio_poll_func *pf = p;
-	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8);
+	__be32 data[ADIS16550_MAX_SCAN_DATA] __aligned(8) = { };
 	struct iio_dev *indio_dev = pf->indio_dev;
 	struct adis16550 *st = iio_priv(indio_dev);
 	struct adis *adis = iio_device_get_drvdata(indio_dev);
diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
index 5b28a3ffcc3d..48291203d1cd 100644
--- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
+++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_buffer.c
@@ -609,7 +609,7 @@ int st_lsm6dsx_read_tagged_fifo(struct st_lsm6dsx_hw *hw)
 	 * must be passed a buffer that is aligned to 8 bytes so
 	 * as to allow insertion of a naturally aligned timestamp.
 	 */
-	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8);
+	u8 iio_buff[ST_LSM6DSX_IIO_BUFF_SIZE] __aligned(8) = { };
 	u8 tag;
 	bool reset_ts = false;
 	int i, err, read_len;
diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 46f36a6ed271..5c3df993bea2 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -1909,6 +1909,7 @@ static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
 
 	dma_resv_add_fence(dmabuf->resv, &fence->base,
 			   dma_to_ram ? DMA_RESV_USAGE_WRITE : DMA_RESV_USAGE_READ);
+	dma_fence_put(&fence->base);
 	dma_resv_unlock(dmabuf->resv);
 
 	cookie = dma_fence_begin_signalling();
diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 0df0ab3de270..9ce20cb05a9b 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -738,7 +738,11 @@ int iio_read_channel_processed_scale(struct iio_channel *chan, int *val,
 		if (ret < 0)
 			return ret;
 
-		return iio_multiply_value(val, scale, ret, pval, pval2);
+		ret = iio_multiply_value(val, scale, ret, pval, pval2);
+		if (ret < 0)
+			return ret;
+
+		return 0;
 	} else {
 		ret = iio_channel_read(chan, val, NULL, IIO_CHAN_INFO_RAW);
 		if (ret < 0)
diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
index 79ad6e2209ca..0fe61b8a7029 100644
--- a/drivers/iio/light/cm3323.c
+++ b/drivers/iio/light/cm3323.c
@@ -89,15 +89,14 @@ static int cm3323_init(struct iio_dev *indio_dev)
 
 	/* enable sensor and set auto force mode */
 	ret &= ~(CM3323_CONF_SD_BIT | CM3323_CONF_AF_BIT);
+	data->reg_conf = ret;
 
-	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, ret);
+	ret = i2c_smbus_write_word_data(data->client, CM3323_CMD_CONF, data->reg_conf);
 	if (ret < 0) {
 		dev_err(&data->client->dev, "Error writing reg_conf\n");
 		return ret;
 	}
 
-	data->reg_conf = ret;
-
 	return 0;
 }
 
diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 74d7246e5225..4bbd86d0cb46 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -245,13 +245,6 @@ static const struct iio_info veml6070_info = {
 	.write_raw = veml6070_write_raw,
 };
 
-static void veml6070_i2c_unreg(void *p)
-{
-	struct veml6070_data *data = p;
-
-	i2c_unregister_device(data->client2);
-}
-
 static int veml6070_probe(struct i2c_client *client)
 {
 	struct veml6070_data *data;
@@ -281,7 +274,8 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	data->client2 = i2c_new_dummy_device(client->adapter, VEML6070_ADDR_DATA_LSB);
+	data->client2 = devm_i2c_new_dummy_device(&client->dev, client->adapter,
+						  VEML6070_ADDR_DATA_LSB);
 	if (IS_ERR(data->client2))
 		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
 				     "i2c device for second chip address failed\n");
@@ -292,10 +286,6 @@ static int veml6070_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
-	ret = devm_add_action_or_reset(&client->dev, veml6070_i2c_unreg, data);
-	if (ret < 0)
-		return ret;
-
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
diff --git a/drivers/iio/magnetometer/st_magn_core.c b/drivers/iio/magnetometer/st_magn_core.c
index ef348d316c00..7644bd04654b 100644
--- a/drivers/iio/magnetometer/st_magn_core.c
+++ b/drivers/iio/magnetometer/st_magn_core.c
@@ -506,6 +506,11 @@ static const struct st_sensors_platform_data default_magn_pdata = {
 	.drdy_int_pin = 2,
 };
 
+/* LIS2MDL only supports DRDY on INT1 */
+static const struct st_sensors_platform_data alt_magn_pdata = {
+	.drdy_int_pin = 1,
+};
+
 static int st_magn_read_raw(struct iio_dev *indio_dev,
 			struct iio_chan_spec const *ch, int *val,
 							int *val2, long mask)
@@ -628,8 +633,12 @@ int st_magn_common_probe(struct iio_dev *indio_dev)
 	mdata->current_fullscale = &mdata->sensor_settings->fs.fs_avl[0];
 	mdata->odr = mdata->sensor_settings->odr.odr_avl[0].hz;
 
-	if (!pdata)
-		pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+	if (!pdata) {
+		if (mdata->sensor_settings->drdy_irq.int2.mask)
+			pdata = (struct st_sensors_platform_data *)&default_magn_pdata;
+		else
+			pdata = (struct st_sensors_platform_data *)&alt_magn_pdata;
+	}
 
 	err = st_sensors_init_sensor(indio_dev, pdata);
 	if (err < 0)
diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
index d983ce9c0b99..9b489766e457 100644
--- a/drivers/iio/pressure/bmp280-core.c
+++ b/drivers/iio/pressure/bmp280-core.c
@@ -2616,7 +2616,7 @@ static irqreturn_t bmp580_trigger_handler(int irq, void *p)
 		__le32 comp_temp;
 		__le32 comp_press;
 		aligned_s64 timestamp;
-	} buffer;
+	} buffer = { };
 	int ret;
 
 	guard(mutex)(&data->lock);
diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 334bba6fdae6..104dd45598b0 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -119,7 +119,7 @@ static bool tsys01_crc_valid(u16 *n_prom)
 	u8 sum = 0;
 
 	for (cnt = 0; cnt < TSYS01_PROM_WORDS_NB; cnt++)
-		sum += ((n_prom[0] >> 8) + (n_prom[0] & 0xFF));
+		sum += ((n_prom[cnt] >> 8) + (n_prom[cnt] & 0xFF));
 
 	return (sum == 0);
 }
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d6fc3d6006bb..6e87126de59a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -220,6 +220,10 @@ static const struct xpad_device {
 	{ 0x07ff, 0xffff, "Mad Catz GamePad", 0, XTYPE_XBOX360 },
 	{ 0x0b05, 0x1a38, "ASUS ROG RAIKIRI", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0b05, 0x1abb, "ASUS ROG RAIKIRI PRO", 0, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1c91, "ASUS ROG RAIKIRI II", 0, XTYPE_XBOX360 },
+	{ 0x0b05, 0x1c92, "ASUS ROG RAIKIRI II WIRELESS", 0, XTYPE_XBOX360 },
+	{ 0x0b05, 0x1c96, "ASUS ROG RAIKIRI II XBOX", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
+	{ 0x0b05, 0x1d04, "ASUS ROG RAIKIRI II XBOX WIRELESS", MAP_SHARE_BUTTON, XTYPE_XBOXONE },
 	{ 0x0c12, 0x0005, "Intec wireless", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8801, "Nyko Xbox Controller", 0, XTYPE_XBOX },
 	{ 0x0c12, 0x8802, "Zeroplus Xbox Controller", 0, XTYPE_XBOX },
@@ -425,6 +429,7 @@ static const struct xpad_device {
 	{ 0x3285, 0x0662, "Nacon Revolution5 Pro", 0, XTYPE_XBOX360 },
 	{ 0x3285, 0x0663, "Nacon Evol-X", 0, XTYPE_XBOXONE },
 	{ 0x3537, 0x1004, "GameSir T4 Kaleid", 0, XTYPE_XBOX360 },
+	{ 0x3537, 0x100f, "GameSir Nova 2 Lite", 0, XTYPE_XBOX360 },
 	{ 0x3537, 0x1010, "GameSir G7 SE", 0, XTYPE_XBOXONE },
 	{ 0x3651, 0x1000, "CRKD SG", 0, XTYPE_XBOX360 },
 	{ 0x366c, 0x0005, "ByoWave Proteus Controller", MAP_SHARE_BUTTON, XTYPE_XBOXONE, FLAG_DELAY_INIT },
@@ -541,6 +546,7 @@ static const struct usb_device_id xpad_table[] = {
 	{ USB_DEVICE(0x0738, 0x4540) },		/* Mad Catz Beat Pad */
 	XPAD_XBOXONE_VENDOR(0x0738),		/* Mad Catz FightStick TE 2 */
 	XPAD_XBOX360_VENDOR(0x07ff),		/* Mad Catz Gamepad */
+	XPAD_XBOX360_VENDOR(0x0b05),		/* ASUS controllers */
 	XPAD_XBOXONE_VENDOR(0x0b05),		/* ASUS controllers */
 	XPAD_XBOX360_VENDOR(0x0c12),		/* Zeroplus X-Box 360 controllers */
 	XPAD_XBOX360_VENDOR(0x0db0),		/* Micro Star International X-Box 360 controllers */
@@ -1110,10 +1116,10 @@ static void xpadone_process_packet(struct usb_xpad *xpad, u16 cmd, unsigned char
 		input_report_key(dev, BTN_START,  data[4] & BIT(2));
 		input_report_key(dev, BTN_SELECT, data[4] & BIT(3));
 		if (xpad->mapping & MAP_SHARE_BUTTON) {
-			if (xpad->mapping & MAP_SHARE_OFFSET)
-				input_report_key(dev, KEY_RECORD, data[len - 26] & BIT(0));
-			else
-				input_report_key(dev, KEY_RECORD, data[len - 18] & BIT(0));
+			u32 offset = (xpad->mapping & MAP_SHARE_OFFSET) ? 26 : 18;
+
+			if (len >= offset)
+				input_report_key(dev, KEY_RECORD, data[len - offset] & BIT(0));
 		}
 
 		/* buttons A,B,X,Y */
diff --git a/drivers/input/misc/ims-pcu.c b/drivers/input/misc/ims-pcu.c
index f69de9762c4e..a19e2d2582d9 100644
--- a/drivers/input/misc/ims-pcu.c
+++ b/drivers/input/misc/ims-pcu.c
@@ -1604,7 +1604,7 @@ static void ims_pcu_buffers_free(struct ims_pcu *pcu)
 	usb_kill_urb(pcu->urb_in);
 	usb_free_urb(pcu->urb_in);
 
-	usb_free_coherent(pcu->udev, pcu->max_out_size,
+	usb_free_coherent(pcu->udev, pcu->max_in_size,
 			  pcu->urb_in_buf, pcu->read_dma);
 
 	kfree(pcu->urb_out_buf);
diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
index fee1796da3d0..74f822cd8774 100644
--- a/drivers/input/mouse/elan_i2c_core.c
+++ b/drivers/input/mouse/elan_i2c_core.c
@@ -645,6 +645,11 @@ static ssize_t elan_sysfs_update_fw(struct device *dev,
 		return error;
 	}
 
+	if (fw->size < data->fw_signature_address + sizeof(signature)) {
+		dev_err(dev, "firmware file too small\n");
+		return -EBADF;
+	}
+
 	/* Firmware file must match signature data */
 	fw_signature = &fw->data[data->fw_signature_address];
 	if (memcmp(fw_signature, signature, sizeof(signature)) != 0) {
diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 26071128f43a..c70502e24031 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -190,6 +190,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN2044", /* L470  */
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
+	"LEN2058", /* E490 */
 	"LEN2068", /* T14 Gen 1 */
 	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index dd0544cc1bc1..15bac83ea92e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -1477,7 +1477,7 @@ static int mxt_prepare_cfg_mem(struct mxt_data *data, struct mxt_cfg *cfg)
 			}
 			cfg->raw_pos += offset;
 
-			if (i > mxt_obj_size(object))
+			if (i >= mxt_obj_size(object))
 				continue;
 
 			byte_offset = reg + i - cfg->start_ofs;
diff --git a/drivers/input/touchscreen/usbtouchscreen.c b/drivers/input/touchscreen/usbtouchscreen.c
index 657555c8796c..866d4a7fbe42 100644
--- a/drivers/input/touchscreen/usbtouchscreen.c
+++ b/drivers/input/touchscreen/usbtouchscreen.c
@@ -1070,6 +1070,11 @@ static int nexio_read_data(struct usbtouch_usb *usbtouch, unsigned char *pkt)
 	if (x_len > 0xff)
 		x_len -= 0x80;
 
+	if (data_len > usbtouch->data_size - sizeof(*packet))
+		data_len = usbtouch->data_size - sizeof(*packet);
+	if (x_len > data_len)
+		x_len = data_len;
+
 	/* send ACK */
 	ret = usb_submit_urb(priv->ack, GFP_ATOMIC);
 	if (ret)
diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
index 40e33257d3c2..1dbef8c55007 100644
--- a/drivers/iommu/io-pgtable-arm-v7s.c
+++ b/drivers/iommu/io-pgtable-arm-v7s.c
@@ -777,21 +777,27 @@ struct io_pgtable_init_fns io_pgtable_arm_v7s_init_fns = {
 
 static struct io_pgtable_cfg *cfg_cookie __initdata;
 
-static void __init dummy_tlb_flush_all(void *cookie)
+/*
+ * __noipa prevents gcc from turning indirect iommu_flush_ops calls
+ * into direct calls from a specialized __arm_v7s_unmap() that triggers
+ * a build time section mismatch assertion.
+ */
+static __noipa void __init dummy_tlb_flush_all(void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 }
 
-static void __init dummy_tlb_flush(unsigned long iova, size_t size,
-				   size_t granule, void *cookie)
+static __noipa void __init dummy_tlb_flush(unsigned long iova, size_t size,
+					   size_t granule, void *cookie)
 {
 	WARN_ON(cookie != cfg_cookie);
 	WARN_ON(!(size & cfg_cookie->pgsize_bitmap));
 }
 
-static void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
-				      unsigned long iova, size_t granule,
-				      void *cookie)
+static __noipa void __init dummy_tlb_add_page(struct iommu_iotlb_gather *gather,
+					      unsigned long iova,
+					      size_t granule,
+					      void *cookie)
 {
 	dummy_tlb_flush(iova, granule, granule, cookie);
 }
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index b77162db509f..60866e8417c9 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -52,7 +52,7 @@ static void msg_submit(struct mbox_chan *chan)
 	int err = -EBUSY;
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
-		if (!chan->msg_count || chan->active_req)
+		if (!chan->msg_count || chan->active_req != MBOX_NO_MSG)
 			break;
 
 		count = chan->msg_count;
@@ -87,13 +87,13 @@ static void tx_tick(struct mbox_chan *chan, int r)
 
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		mssg = chan->active_req;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 	}
 
 	/* Submit next message */
 	msg_submit(chan);
 
-	if (!mssg)
+	if (mssg == MBOX_NO_MSG)
 		return;
 
 	/* Notify the client */
@@ -114,7 +114,7 @@ static enum hrtimer_restart txdone_hrtimer(struct hrtimer *hrtimer)
 	for (i = 0; i < mbox->num_chans; i++) {
 		struct mbox_chan *chan = &mbox->chans[i];
 
-		if (chan->active_req && chan->cl) {
+		if (chan->active_req != MBOX_NO_MSG && chan->cl) {
 			txdone = chan->mbox->ops->last_tx_done(chan);
 			if (txdone)
 				tx_tick(chan, 0);
@@ -246,7 +246,7 @@ int mbox_send_message(struct mbox_chan *chan, void *mssg)
 {
 	int t;
 
-	if (!chan || !chan->cl)
+	if (!chan || !chan->cl || mssg == MBOX_NO_MSG)
 		return -EINVAL;
 
 	t = add_to_rbuf(chan, mssg);
@@ -319,7 +319,7 @@ static int __mbox_bind_client(struct mbox_chan *chan, struct mbox_client *cl)
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->msg_free = 0;
 		chan->msg_count = 0;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		chan->cl = cl;
 		init_completion(&chan->tx_complete);
 
@@ -477,7 +477,7 @@ void mbox_free_channel(struct mbox_chan *chan)
 	/* The queued TX requests are simply aborted, no callbacks are made */
 	scoped_guard(spinlock_irqsave, &chan->lock) {
 		chan->cl = NULL;
-		chan->active_req = NULL;
+		chan->active_req = MBOX_NO_MSG;
 		if (chan->txdone_method == TXDONE_BY_ACK)
 			chan->txdone_method = TXDONE_BY_POLL;
 	}
@@ -531,6 +531,7 @@ int mbox_controller_register(struct mbox_controller *mbox)
 
 		chan->cl = NULL;
 		chan->mbox = mbox;
+		chan->active_req = MBOX_NO_MSG;
 		chan->txdone_method = txdone;
 		spin_lock_init(&chan->lock);
 	}
diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index ed9a0bb2bcd8..7991e8dba579 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -497,7 +497,7 @@ static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
 			mbox_chan_txdone(chan, 0);
 
 			/* Wait until channel is empty */
-			if (chan->active_req != NULL)
+			if (chan->active_req != MBOX_NO_MSG)
 				continue;
 
 			return 0;
diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 6627a381f65a..97d9adb0bf96 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1378,7 +1378,8 @@ static CLOSURE_CALLBACK(cached_dev_free)
 	 * The sb_bio is embedded in struct cached_dev, so we must
 	 * ensure no I/O is in progress.
 	 */
-	closure_sync(&dc->sb_write);
+	down(&dc->sb_write_mutex);
+	up(&dc->sb_write_mutex);
 
 	if (dc->sb_disk)
 		folio_put(virt_to_folio(dc->sb_disk));
diff --git a/drivers/media/rc/igorplugusb.c b/drivers/media/rc/igorplugusb.c
index 6938d9a90c58..b0b8c0dd3831 100644
--- a/drivers/media/rc/igorplugusb.c
+++ b/drivers/media/rc/igorplugusb.c
@@ -184,7 +184,7 @@ static int igorplugusb_probe(struct usb_interface *intf,
 	if (!ir->buf_in)
 		goto fail;
 	usb_fill_control_urb(ir->urb, udev,
-		usb_rcvctrlpipe(udev, 0), (uint8_t *)&ir->request,
+		usb_rcvctrlpipe(udev, 0), (uint8_t *)ir->request,
 		ir->buf_in, MAX_PACKET, igorplugusb_callback, ir);
 
 	usb_make_path(udev, ir->phys, sizeof(ir->phys));
diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
index d210da84c30a..81685e3f3296 100644
--- a/drivers/misc/rp1/rp1_pci.c
+++ b/drivers/misc/rp1/rp1_pci.c
@@ -143,6 +143,7 @@ static int rp1_irq_activate(struct irq_domain *d, struct irq_data *irqd,
 	struct rp1_dev *rp1 = d->host_data;
 
 	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_ENABLE);
+	msix_cfg_set(rp1, (unsigned int)irqd->hwirq, MSIX_CFG_IACK);
 
 	return 0;
 }
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index eb49ce486992..d6a1e814878f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1892,6 +1892,12 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	struct sockaddr_storage ss;
 	int res = 0, i;
 
+	if (slave_dev->type == ARPHRD_CAN) {
+		BOND_NL_ERR(bond_dev, extack,
+			    "CAN devices cannot be enslaved");
+		return -EPERM;
+	}
+
 	if (slave_dev->flags & IFF_MASTER &&
 	    !netif_is_bond_master(slave_dev)) {
 		BOND_NL_ERR(bond_dev, extack,
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
index 068da2fd1fea..f721e9893804 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_main.c
@@ -420,6 +420,9 @@ static int hbg_pci_init(struct pci_dev *pdev)
 		return -ENOMEM;
 
 	pci_set_master(pdev);
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL,
+				   PCI_EXP_DEVCTL_RELAX_EN);
+	pci_save_state(pdev);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
index a4ea92c31c2f..0ae314994676 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
@@ -452,12 +452,12 @@ static bool hbg_sync_data_from_hw(struct hbg_priv *priv,
 {
 	struct hbg_rx_desc *rx_desc;
 
-	/* make sure HW write desc complete */
-	dma_rmb();
-
 	dma_sync_single_for_cpu(&priv->pdev->dev, buffer->page_dma,
 				buffer->page_size, DMA_FROM_DEVICE);
 
+	/* make sure HW write desc complete */
+	dma_rmb();
+
 	rx_desc = (struct hbg_rx_desc *)buffer->page_addr;
 	return FIELD_GET(HBG_RX_DESC_W2_PKT_LEN_M, rx_desc->word2) != 0;
 }
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
index 5b1129558e8b..e2364c0667d1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.c
@@ -435,7 +435,7 @@ struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc)
 		return &rvu->pf[rvu_get_pf(rvu->pdev, pcifunc)];
 }
 
-static bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc)
 {
 	int pf, vf, nvfs;
 	u64 cfg;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
index e85dac2c806d..3f76ec6c5cf3 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu.h
@@ -910,6 +910,7 @@ u16 rvu_get_rsrc_mapcount(struct rvu_pfvf *pfvf, int blkaddr);
 struct rvu_pfvf *rvu_get_pfvf(struct rvu *rvu, int pcifunc);
 void rvu_get_pf_numvfs(struct rvu *rvu, int pf, int *numvfs, int *hwvf);
 bool is_block_implemented(struct rvu_hwinfo *hw, int blkaddr);
+bool is_pf_func_valid(struct rvu *rvu, u16 pcifunc);
 bool is_pffunc_map_valid(struct rvu *rvu, u16 pcifunc, int blktype);
 int rvu_get_lf(struct rvu *rvu, struct rvu_block *block, u16 pcifunc, u16 slot);
 int rvu_lf_reset(struct rvu *rvu, struct rvu_block *block, int lf);
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
index 901f6fd40fd4..a2781e0f504e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
@@ -97,6 +97,14 @@ int rvu_mbox_handler_rep_event_notify(struct rvu *rvu, struct rep_event *req,
 {
 	struct rep_evtq_ent *qentry;
 
+	/* The mailbox dispatcher normalises only the header pcifunc; the
+	 * nested struct rep_event::pcifunc body field is sender-controlled
+	 * and is later used by rvu_rep_up_notify() to index rvu->pf[] /
+	 * rvu->hwvf[].  Reject out-of-range body selectors before queueing.
+	 */
+	if (!is_pf_func_valid(rvu, req->pcifunc))
+		return -EINVAL;
+
 	qentry = kmalloc_obj(*qentry, GFP_ATOMIC);
 	if (!qentry)
 		return -ENOMEM;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index aca77853abb8..5a172c572a68 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -1320,8 +1320,10 @@ mlx5_cmd_hws_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns,
 		break;
 	case MLX5_REFORMAT_TYPE_REMOVE_HDR:
 		hws_action = mlx5_fs_get_action_remove_header_vlan(fs_ctx, params);
-		if (!hws_action)
+		if (!hws_action) {
 			mlx5_core_err(dev, "Only vlan remove header supported\n");
+			return -EOPNOTSUPP;
+		}
 		break;
 	default:
 		mlx5_core_err(ns->dev, "Packet-reformat not supported(%d)\n",
diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 14d6f68eaa69..13a0af0456c9 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -1713,6 +1713,9 @@ static void mana_fence_rqs(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	int err;
 
+	if (!apc->rxqs)
+		return;
+
 	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
 		rxq = apc->rxqs[rxq_idx];
 		err = mana_fence_rq(apc, rxq);
@@ -2821,13 +2824,16 @@ static void mana_destroy_vport(struct mana_port_context *apc)
 	struct mana_rxq *rxq;
 	u32 rxq_idx;
 
-	for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
-		rxq = apc->rxqs[rxq_idx];
-		if (!rxq)
-			continue;
+	if (apc->rxqs) {
+
+		for (rxq_idx = 0; rxq_idx < apc->num_queues; rxq_idx++) {
+			rxq = apc->rxqs[rxq_idx];
+			if (!rxq)
+				continue;
 
-		mana_destroy_rxq(apc, rxq, true);
-		apc->rxqs[rxq_idx] = NULL;
+			mana_destroy_rxq(apc, rxq, true);
+			apc->rxqs[rxq_idx] = NULL;
+		}
 	}
 
 	mana_destroy_txq(apc);
@@ -3232,7 +3238,8 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	if (apc->port_is_up)
 		return -EINVAL;
 
-	mana_chn_setxdp(apc, NULL);
+	if (apc->rxqs)
+		mana_chn_setxdp(apc, NULL);
 
 	if (gd->gdma_context->is_pf && !apc->ac->bm_hostmode)
 		mana_pf_deregister_filter(apc);
@@ -3250,33 +3257,38 @@ static int mana_dealloc_queues(struct net_device *ndev)
 	 * number of queues.
 	 */
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		tsleep = 1000;
-		while (atomic_read(&txq->pending_sends) > 0 &&
-		       time_before(jiffies, timeout)) {
-			usleep_range(tsleep, tsleep + 1000);
-			tsleep <<= 1;
-		}
-		if (atomic_read(&txq->pending_sends)) {
-			err = pcie_flr(to_pci_dev(gd->gdma_context->dev));
-			if (err) {
-				netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
-					   err, atomic_read(&txq->pending_sends),
-					   txq->gdma_txq_id);
+	if (apc->tx_qp) {
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			tsleep = 1000;
+			while (atomic_read(&txq->pending_sends) > 0 &&
+			       time_before(jiffies, timeout)) {
+				usleep_range(tsleep, tsleep + 1000);
+				tsleep <<= 1;
+			}
+			if (atomic_read(&txq->pending_sends)) {
+				err =
+				    pcie_flr(to_pci_dev(gd->gdma_context->dev));
+				if (err) {
+					netdev_err(ndev, "flr failed %d with %d pkts pending in txq %u\n",
+						   err,
+					    atomic_read(&txq->pending_sends),
+					    txq->gdma_txq_id);
+				}
+				break;
 			}
-			break;
 		}
-	}
 
-	for (i = 0; i < apc->num_queues; i++) {
-		txq = &apc->tx_qp[i].txq;
-		while ((skb = skb_dequeue(&txq->pending_skbs))) {
-			mana_unmap_skb(skb, apc);
-			dev_kfree_skb_any(skb);
+		for (i = 0; i < apc->num_queues; i++) {
+			txq = &apc->tx_qp[i].txq;
+			while ((skb = skb_dequeue(&txq->pending_skbs))) {
+				mana_unmap_skb(skb, apc);
+				dev_kfree_skb_any(skb);
+			}
+			atomic_set(&txq->pending_sends, 0);
 		}
-		atomic_set(&txq->pending_sends, 0);
 	}
+
 	/* We're 100% sure the queues can no longer be woken up, because
 	 * we're sure now mana_poll_tx_cq() can't be running.
 	 */
@@ -3301,6 +3313,12 @@ int mana_detach(struct net_device *ndev, bool from_close)
 
 	ASSERT_RTNL();
 
+	/* If already detached (indicates detach succeeded but attach failed
+	 * previously). Now skip mana detach and just retry mana_attach.
+	 */
+	if (!from_close && !netif_device_present(ndev))
+		return 0;
+
 	apc->port_st_save = apc->port_is_up;
 	apc->port_is_up = false;
 
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index 6147ee8b1d78..1d1d2696324d 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -804,7 +804,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		if (pn + 1 > rx_sa->next_pn_halves.lower) {
 			rx_sa->next_pn_halves.lower = pn + 1;
 		} else if (secy->xpn &&
-			   !pn_same_half(pn, rx_sa->next_pn_halves.lower)) {
+			   (pn + 1 == 0 ||
+			    !pn_same_half(pn, rx_sa->next_pn_halves.lower))) {
 			rx_sa->next_pn_halves.upper++;
 			rx_sa->next_pn_halves.lower = pn + 1;
 		}
diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index c12f8087af9b..a753bd88cbc2 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -129,6 +129,9 @@ static int mtk_pcs_config_polarity(struct mtk_pcs_lynxi *mpcs,
 	unsigned int val = 0;
 	int ret;
 
+	if (!fwnode)
+		return 0;
+
 	if (fwnode_property_read_bool(fwnode, "mediatek,pnswap"))
 		default_pol = PHY_POL_INVERT;
 
diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index c6b011a9d636..23305be8c7fa 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -4548,6 +4548,13 @@ static int lan8814_config_init(struct phy_device *phydev)
 	struct kszphy_priv *lan8814 = phydev->priv;
 	int ret;
 
+	if (phy_package_init_once(phydev))
+		/* Reset the PHY */
+		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
+				       LAN8814_QSGMII_SOFT_RESET,
+				       LAN8814_QSGMII_SOFT_RESET_BIT,
+				       LAN8814_QSGMII_SOFT_RESET_BIT);
+
 	/* Based on the interface type select how the advertise ability is
 	 * encoded, to set as SGMII or as USGMII.
 	 */
@@ -4655,13 +4662,7 @@ static int lan8814_probe(struct phy_device *phydev)
 	priv->is_ptp_available = err == LAN8814_REV_LAN8814 ||
 				 err == LAN8814_REV_LAN8818;
 
-	if (phy_package_init_once(phydev)) {
-		/* Reset the PHY */
-		lanphy_modify_page_reg(phydev, LAN8814_PAGE_COMMON_REGS,
-				       LAN8814_QSGMII_SOFT_RESET,
-				       LAN8814_QSGMII_SOFT_RESET_BIT,
-				       LAN8814_QSGMII_SOFT_RESET_BIT);
-
+	if (phy_package_probe_once(phydev)) {
 		err = lan8814_release_coma_mode(phydev);
 		if (err)
 			return err;
diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index a590e07ce0a9..fae115915c8e 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1052,6 +1052,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	int err, depth;
 
 	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -EINVAL;
 		goto err;
 	}
@@ -1061,6 +1062,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		err = -ENOMEM;
 		goto err;
 	}
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index c492fda6fc15..ca0ae5df73af 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2392,8 +2392,10 @@ static int tun_xdp_one(struct tun_struct *tun,
 	bool skb_xdp = false;
 	struct page *page;
 
-	if (unlikely(datasize < ETH_HLEN))
+	if (unlikely(datasize < ETH_HLEN)) {
+		put_page(virt_to_head_page(xdp->data));
 		return -EINVAL;
+	}
 
 	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
@@ -2435,6 +2437,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 build:
 	skb = build_skb(xdp->data_hard_start, buflen);
 	if (!skb) {
+		put_page(virt_to_head_page(xdp->data));
 		ret = -ENOMEM;
 		goto out;
 	}
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a94ac82a6136..0cc3b34add5e 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2534,7 +2534,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip4_dst_hoplimit(&rt->dst);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct iphdr),
 				      vni, md, flags, udp_sum);
@@ -2608,7 +2608,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 			goto out_unlock;
 		}
 
-		tos = ip_tunnel_ecn_encap(tos, old_iph, skb);
+		tos = ip_tunnel_ecn_encap(tos, ip_hdr(skb), skb);
 		ttl = ttl ? : ip6_dst_hoplimit(ndst);
 		skb_scrub_packet(skb, xnet);
 		err = vxlan_build_skb(skb, ndst, sizeof(struct ipv6hdr),
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 26e09c30d596..67d01478eb76 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -177,16 +177,6 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 	trailer_len = padding_len + noise_encrypted_len(0);
 	plaintext_len = skb->len + padding_len;
 
-	/* Expand data section to have room for padding and auth tag. */
-	num_frags = skb_cow_data(skb, trailer_len, &trailer);
-	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
-		return false;
-
-	/* Set the padding to zeros, and make sure it and the auth tag are part
-	 * of the skb.
-	 */
-	memset(skb_tail_pointer(trailer), 0, padding_len);
-
 	/* Expand head section to have room for our header and the network
 	 * stack's headers.
 	 */
@@ -198,6 +188,16 @@ static bool encrypt_packet(struct sk_buff *skb, struct noise_keypair *keypair)
 		     skb_checksum_help(skb)))
 		return false;
 
+	/* Expand data section to have room for padding and auth tag. */
+	num_frags = skb_cow_data(skb, trailer_len, &trailer);
+	if (unlikely(num_frags < 0 || num_frags > ARRAY_SIZE(sg)))
+		return false;
+
+	/* Set the padding to zeros, and make sure it and the auth tag are part
+	 * of the skb.
+	 */
+	memset(skb_tail_pointer(trailer), 0, padding_len);
+
 	/* Only after checksumming can we safely add on the padding at the end
 	 * and the header.
 	 */
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index b3d34433bd14..a6c08175d9dd 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <linux/gpio/consumer.h>
@@ -267,6 +268,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct nxp_nci_i2c_phy *phy;
+	unsigned long irqflags;
 	int r;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -303,9 +305,26 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 	if (r < 0)
 		return r;
 
+	/*
+	 * ACPI platforms may report incorrect IRQ trigger types
+	 * (e.g. level-high), which can lead to interrupt storms.
+	 *
+	 * Use the historically stable rising-edge trigger for ACPI devices.
+	 *
+	 * On non-ACPI systems (e.g. Device Tree), prefer the firmware-
+	 * provided trigger type, falling back to rising-edge if not set.
+	 */
+	if (ACPI_COMPANION(dev)) {
+		irqflags = IRQF_TRIGGER_RISING;
+	} else {
+		irqflags = irq_get_trigger_type(client->irq);
+		if (!irqflags)
+			irqflags = IRQF_TRIGGER_RISING;
+	}
+
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_ONESHOT,
+				 irqflags | IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..29f9ba0bdd3f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1688,7 +1688,7 @@ static void nvme_tcp_tls_done(void *data, int status, key_serial_t pskid)
 		qid, pskid, status);
 
 	if (status) {
-		queue->tls_err = -status;
+		queue->tls_err = status;
 		goto out_complete;
 	}
 
diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index ba5292828703..eb0977ca1605 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -214,10 +214,14 @@ static void get_lowlevel_driver(void)
 static int port_check(struct device *dev, void *dev_drv)
 {
 	struct parport_driver *drv = dev_drv;
+	struct parport *port;
 
 	/* only send ports, do not send other devices connected to bus */
-	if (is_parport(dev))
-		drv->match_port(to_parport_dev(dev));
+	if (is_parport(dev)) {
+		port = to_parport_dev(dev);
+		if (test_bit(PARPORT_ANNOUNCED, &port->devflags))
+			drv->match_port(port);
+	}
 	return 0;
 }
 
@@ -532,6 +536,7 @@ void parport_announce_port(struct parport *port)
 		if (slave)
 			attach_driver_chain(slave);
 	}
+	set_bit(PARPORT_ANNOUNCED, &port->devflags);
 	mutex_unlock(&registration_lock);
 }
 EXPORT_SYMBOL(parport_announce_port);
@@ -561,6 +566,8 @@ void parport_remove_port(struct parport *port)
 
 	mutex_lock(&registration_lock);
 
+	clear_bit(PARPORT_ANNOUNCED, &port->devflags);
+
 	/* Spread the word. */
 	detach_driver_chain(port);
 
diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
index 5059d320edf8..f3174972f44c 100644
--- a/drivers/platform/x86/intel/vsec.c
+++ b/drivers/platform/x86/intel/vsec.c
@@ -42,7 +42,7 @@ enum vsec_device_state {
 };
 
 struct vsec_priv {
-	struct intel_vsec_platform_info *info;
+	const struct intel_vsec_platform_info *info;
 	struct device *suppliers[VSEC_FEATURE_COUNT];
 	struct oobmsm_plat_info plat_info;
 	enum vsec_device_state state[VSEC_FEATURE_COUNT];
@@ -270,15 +270,14 @@ int intel_vsec_add_aux(struct pci_dev *pdev, struct device *parent,
 EXPORT_SYMBOL_NS_GPL(intel_vsec_add_aux, "INTEL_VSEC");
 
 static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *header,
-			      struct intel_vsec_platform_info *info,
-			      unsigned long cap_id)
+			      const struct intel_vsec_platform_info *info,
+			      unsigned long cap_id, u64 base_addr)
 {
 	struct intel_vsec_device __free(kfree) *intel_vsec_dev = NULL;
 	struct resource __free(kfree) *res = NULL;
 	struct resource *tmp;
 	struct device *parent;
 	unsigned long quirks = info->quirks;
-	u64 base_addr;
 	int i;
 
 	if (info->parent)
@@ -310,11 +309,6 @@ static int intel_vsec_add_dev(struct pci_dev *pdev, struct intel_vsec_header *he
 	if (quirks & VSEC_QUIRK_TABLE_SHIFT)
 		header->offset >>= TABLE_OFFSET_SHIFT;
 
-	if (info->base_addr)
-		base_addr = info->base_addr;
-	else
-		base_addr = pdev->resource[header->tbir].start;
-
 	/*
 	 * The DVSEC/VSEC contains the starting offset and count for a block of
 	 * discovery tables. Create a resource array of these tables to the
@@ -412,7 +406,8 @@ static int get_cap_id(u32 header_id, unsigned long *cap_id)
 
 static int intel_vsec_register_device(struct pci_dev *pdev,
 				      struct intel_vsec_header *header,
-				      struct intel_vsec_platform_info *info)
+				      const struct intel_vsec_platform_info *info,
+				      u64 base_addr)
 {
 	const struct vsec_feature_dependency *consumer_deps;
 	struct vsec_priv *priv;
@@ -428,7 +423,7 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 	 * For others using the exported APIs, add the device directly.
 	 */
 	if (!pci_match_id(intel_vsec_pci_ids, pdev))
-		return intel_vsec_add_dev(pdev, header, info, cap_id);
+		return intel_vsec_add_dev(pdev, header, info, cap_id, base_addr);
 
 	priv = pci_get_drvdata(pdev);
 	if (priv->state[cap_id] == STATE_REGISTERED ||
@@ -444,7 +439,7 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 
 	consumer_deps = get_consumer_dependencies(priv, cap_id);
 	if (!consumer_deps || suppliers_ready(priv, consumer_deps, cap_id)) {
-		ret = intel_vsec_add_dev(pdev, header, info, cap_id);
+		ret = intel_vsec_add_dev(pdev, header, info, cap_id, base_addr);
 		if (ret)
 			priv->state[cap_id] = STATE_SKIP;
 		else
@@ -457,14 +452,14 @@ static int intel_vsec_register_device(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_header(struct pci_dev *pdev,
-				   struct intel_vsec_platform_info *info)
+				   const struct intel_vsec_platform_info *info)
 {
 	struct intel_vsec_header **header = info->headers;
 	bool have_devices = false;
 	int ret;
 
 	for ( ; *header; header++) {
-		ret = intel_vsec_register_device(pdev, *header, info);
+		ret = intel_vsec_register_device(pdev, *header, info, info->base_addr);
 		if (!ret)
 			have_devices = true;
 	}
@@ -473,7 +468,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
-				  struct intel_vsec_platform_info *info)
+				  const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -512,7 +507,8 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
 		pci_read_config_dword(pdev, pos + PCI_DVSEC_HEADER2, &hdr);
 		header.id = PCI_DVSEC_HEADER2_ID(hdr);
 
-		ret = intel_vsec_register_device(pdev, &header, info);
+		ret = intel_vsec_register_device(pdev, &header, info,
+						 pci_resource_start(pdev, header.tbir));
 		if (ret)
 			continue;
 
@@ -523,7 +519,7 @@ static bool intel_vsec_walk_dvsec(struct pci_dev *pdev,
 }
 
 static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
-				 struct intel_vsec_platform_info *info)
+				 const struct intel_vsec_platform_info *info)
 {
 	bool have_devices = false;
 	int pos = 0;
@@ -557,7 +553,8 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
 		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
 
-		ret = intel_vsec_register_device(pdev, &header, info);
+		ret = intel_vsec_register_device(pdev, &header, info,
+						 pci_resource_start(pdev, header.tbir));
 		if (ret)
 			continue;
 
@@ -568,7 +565,7 @@ static bool intel_vsec_walk_vsec(struct pci_dev *pdev,
 }
 
 int intel_vsec_register(struct pci_dev *pdev,
-			 struct intel_vsec_platform_info *info)
+			const struct intel_vsec_platform_info *info)
 {
 	if (!pdev || !info || !info->headers)
 		return -EINVAL;
@@ -581,7 +578,7 @@ int intel_vsec_register(struct pci_dev *pdev,
 EXPORT_SYMBOL_NS_GPL(intel_vsec_register, "INTEL_VSEC");
 
 static bool intel_vsec_get_features(struct pci_dev *pdev,
-				    struct intel_vsec_platform_info *info)
+				    const struct intel_vsec_platform_info *info)
 {
 	bool found = false;
 
@@ -623,29 +620,13 @@ static void intel_vsec_skip_missing_dependencies(struct pci_dev *pdev)
 	}
 }
 
-static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int intel_vsec_pci_init(struct pci_dev *pdev)
 {
-	struct intel_vsec_platform_info *info;
-	struct vsec_priv *priv;
-	int num_caps, ret;
+	struct vsec_priv *priv = pci_get_drvdata(pdev);
+	const struct intel_vsec_platform_info *info = priv->info;
 	int run_once = 0;
 	bool found_any = false;
-
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	pci_save_state(pdev);
-	info = (struct intel_vsec_platform_info *)id->driver_data;
-	if (!info)
-		return -EINVAL;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	priv->info = info;
-	pci_set_drvdata(pdev, priv);
+	int num_caps;
 
 	num_caps = hweight_long(info->caps);
 	while (num_caps--) {
@@ -666,6 +647,31 @@ static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id
 	return 0;
 }
 
+static int intel_vsec_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	const struct intel_vsec_platform_info *info;
+	struct vsec_priv *priv;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_save_state(pdev);
+	info = (const struct intel_vsec_platform_info *)id->driver_data;
+	if (!info)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->info = info;
+	pci_set_drvdata(pdev, priv);
+
+	return intel_vsec_pci_init(pdev);
+}
+
 int intel_vsec_set_mapping(struct oobmsm_plat_info *plat_info,
 			   struct intel_vsec_device *vsec_dev)
 {
@@ -803,7 +809,6 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 {
 	struct intel_vsec_device *intel_vsec_dev;
 	pci_ers_result_t status = PCI_ERS_RESULT_DISCONNECT;
-	const struct pci_device_id *pci_dev_id;
 	unsigned long index;
 
 	dev_info(&pdev->dev, "Resetting PCI slot\n");
@@ -824,10 +829,8 @@ static pci_ers_result_t intel_vsec_pci_slot_reset(struct pci_dev *pdev)
 		devm_release_action(&pdev->dev, intel_vsec_remove_aux,
 				    &intel_vsec_dev->auxdev);
 	}
-	pci_disable_device(pdev);
 	pci_restore_state(pdev);
-	pci_dev_id = pci_match_id(intel_vsec_pci_ids, pdev);
-	intel_vsec_pci_probe(pdev, pci_dev_id);
+	intel_vsec_pci_init(pdev);
 
 out:
 	return status;
diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 02cd4410efca..496ddd45f74d 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -1385,7 +1385,7 @@ static void fcoe_ctlr_recv_clr_vlink(struct fcoe_ctlr *fip,
 
 	while (rlen >= sizeof(*desc)) {
 		dlen = desc->fip_dlen * FIP_BPW;
-		if (dlen > rlen)
+		if (dlen < sizeof(*desc) || dlen > rlen)
 			goto err;
 		/* Drop CVL if there are duplicate critical descriptors */
 		if ((desc->fip_dtype < 32) &&
diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1515495fd9ea..040c5e1e713a 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -6953,7 +6953,7 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 	++num_dev_resets;
 
 	if (SDEBUG_OPT_ALL_NOISE & sdebug_opts)
-		sdev_printk(KERN_INFO, sdp, "doing device reset");
+		sdev_printk(KERN_INFO, sdp, "doing device reset\n");
 
 	scsi_debug_stop_all_queued(sdp);
 	if (devip) {
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d3a8cd4166f9..1da52f07d299 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -574,10 +574,33 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
 void scsi_run_host_queues(struct Scsi_Host *shost)
 {
-	struct scsi_device *sdev;
+	struct scsi_device *sdev, *prev = NULL;
+	unsigned long flags;
 
-	shost_for_each_device(sdev, shost)
+	spin_lock_irqsave(shost->host_lock, flags);
+	__shost_for_each_device(sdev, shost) {
+		/*
+		 * Only skip devices so deep into removal they will never need
+		 * another kick to their queues. Thus scsi_device_get() cannot
+		 * be used as it would skip devices in SDEV_CANCEL state which
+		 * may need a queue kick.
+		 */
+		if (sdev->sdev_state == SDEV_DEL ||
+		    !get_device(&sdev->sdev_gendev))
+			continue;
+		spin_unlock_irqrestore(shost->host_lock, flags);
+
+		if (prev)
+			put_device(&prev->sdev_gendev);
 		scsi_run_queue(sdev->request_queue);
+
+		prev = sdev;
+
+		spin_lock_irqsave(shost->host_lock, flags);
+	}
+	spin_unlock_irqrestore(shost->host_lock, flags);
+	if (prev)
+		put_device(&prev->sdev_gendev);
 }
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index dce95e361daf..173ed6373f04 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -737,6 +737,37 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 	}
 }
 
+static void
+fc_fpin_pname_stats_update(struct Scsi_Host *shost,
+			   struct fc_rport *attach_rport, u16 event_type,
+			   u32 desc_len, u32 fixed_len, u32 pname_count,
+			   __be64 *pname_list,
+			   void (*stats_update)(u16 event_type,
+						struct fc_fpin_stats *stats))
+{
+	u32 i;
+	struct fc_rport *rport;
+	u64 wwpn;
+
+	if (desc_len < fixed_len)
+		pname_count = 0;
+	else
+		pname_count = min(pname_count, (desc_len - fixed_len) /
+				   sizeof(pname_list[0]));
+
+	for (i = 0; i < pname_count; i++) {
+		wwpn = be64_to_cpu(pname_list[i]);
+		rport = fc_find_rport_by_wwpn(shost, wwpn);
+		if (rport &&
+		    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
+		     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
+			if (rport == attach_rport)
+				continue;
+			stats_update(event_type, &rport->fpin_stats);
+		}
+	}
+}
+
 /*
  * fc_fpin_li_stats_update - routine to update Link Integrity
  * event statistics.
@@ -747,13 +778,11 @@ fc_cn_stats_update(u16 event_type, struct fc_fpin_stats *stats)
 static void
 fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_host_attrs *fc_host = shost_to_fc_host(shost);
 	struct fc_fn_li_desc *li_desc = (struct fc_fn_li_desc *)tlv;
 	u16 event_type = be16_to_cpu(li_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(li_desc->attached_wwpn));
@@ -764,22 +793,11 @@ fc_fpin_li_stats_update(struct Scsi_Host *shost, struct fc_tlv_desc *tlv)
 		fc_li_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(li_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(li_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(li_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			    rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_li_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(li_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*li_desc),
+				   be32_to_cpu(li_desc->pname_count),
+				   li_desc->pname_list, fc_li_stats_update);
 
 	if (fc_host->port_name == be64_to_cpu(li_desc->attached_wwpn))
 		fc_li_stats_update(event_type, &fc_host->fpin_stats);
@@ -827,13 +845,11 @@ static void
 fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 				struct fc_tlv_desc *tlv)
 {
-	u8 i;
 	struct fc_rport *rport = NULL;
 	struct fc_rport *attach_rport = NULL;
 	struct fc_fn_peer_congn_desc *pc_desc =
 	    (struct fc_fn_peer_congn_desc *)tlv;
 	u16 event_type = be16_to_cpu(pc_desc->event_type);
-	u64 wwpn;
 
 	rport = fc_find_rport_by_wwpn(shost,
 				      be64_to_cpu(pc_desc->attached_wwpn));
@@ -844,22 +860,11 @@ fc_fpin_peer_congn_stats_update(struct Scsi_Host *shost,
 		fc_cn_stats_update(event_type, &attach_rport->fpin_stats);
 	}
 
-	if (be32_to_cpu(pc_desc->pname_count) > 0) {
-		for (i = 0;
-		    i < be32_to_cpu(pc_desc->pname_count);
-		    i++) {
-			wwpn = be64_to_cpu(pc_desc->pname_list[i]);
-			rport = fc_find_rport_by_wwpn(shost, wwpn);
-			if (rport &&
-			    (rport->roles & FC_PORT_ROLE_FCP_TARGET ||
-			     rport->roles & FC_PORT_ROLE_NVME_TARGET)) {
-				if (rport == attach_rport)
-					continue;
-				fc_cn_stats_update(event_type,
-						   &rport->fpin_stats);
-			}
-		}
-	}
+	fc_fpin_pname_stats_update(shost, attach_rport, event_type,
+				   be32_to_cpu(pc_desc->desc_len),
+				   FC_TLV_DESC_LENGTH_FROM_SZ(*pc_desc),
+				   be32_to_cpu(pc_desc->pname_count),
+				   pc_desc->pname_list, fc_cn_stats_update);
 }
 
 /*
diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
index a09371a075d2..93266848c6df 100644
--- a/drivers/spi/spi-mem.c
+++ b/drivers/spi/spi-mem.c
@@ -279,13 +279,20 @@ static bool spi_mem_internal_supports_op(struct spi_mem *mem,
  */
 bool spi_mem_supports_op(struct spi_mem *mem, const struct spi_mem_op *op)
 {
-	/* Make sure the operation frequency is correct before going futher */
-	spi_mem_adjust_op_freq(mem, (struct spi_mem_op *)op);
+	struct spi_mem_op eval_op = *op;
+
+	/*
+	 * Work on a local copy; this is a pure capability check and must
+	 * not modify the caller's op. Stored templates with max_freq == 0
+	 * must remain unset so their frequency is always re-capped to the
+	 * current device maximum at execution time.
+	 */
+	spi_mem_adjust_op_freq(mem, &eval_op);
 
-	if (spi_mem_check_op(op))
+	if (spi_mem_check_op(&eval_op))
 		return false;
 
-	return spi_mem_internal_supports_op(mem, op);
+	return spi_mem_internal_supports_op(mem, &eval_op);
 }
 EXPORT_SYMBOL_GPL(spi_mem_supports_op);
 
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index e80449f6ce15..f3b7569f49da 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -2281,7 +2281,9 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 			goto reject;
 
 		if (conn->conn_ops->DataDigest) {
-			data_crc = iscsit_crc_buf(text_in, rx_size, 0, NULL);
+			data_crc = iscsit_crc_buf(text_in,
+						  ALIGN(payload_length, 4),
+						  0, NULL);
 			if (checksum != data_crc) {
 				pr_err("Text data CRC32C DataDigest"
 					" 0x%08x does not match computed"
@@ -2300,6 +2302,7 @@ iscsit_handle_text_cmd(struct iscsit_conn *conn, struct iscsit_cmd *cmd,
 					" Command CmdSN: 0x%08x due to"
 					" DataCRC error.\n", hdr->cmdsn);
 					kfree(text_in);
+					cmd->text_in_ptr = NULL;
 					return 0;
 				}
 			} else {
diff --git a/drivers/target/iscsi/iscsi_target_auth.c b/drivers/target/iscsi/iscsi_target_auth.c
index c46c69a28e97..a3ad2d244dbe 100644
--- a/drivers/target/iscsi/iscsi_target_auth.c
+++ b/drivers/target/iscsi/iscsi_target_auth.c
@@ -340,13 +340,22 @@ static int chap_server_compute_hash(
 			goto out;
 		}
 		break;
-	case BASE64:
+	case BASE64: {
+		size_t r_len = strlen(chap_r);
+
+		while (r_len > 0 && chap_r[r_len - 1] == '=')
+			r_len--;
+		if (r_len > DIV_ROUND_UP(chap->digest_size * 4, 3)) {
+			pr_err("Malformed CHAP_R: base64 payload too long\n");
+			goto out;
+		}
 		if (chap_base64_decode(client_digest, chap_r, strlen(chap_r)) !=
 		    chap->digest_size) {
 			pr_err("Malformed CHAP_R: invalid BASE64\n");
 			goto out;
 		}
 		break;
+	}
 	default:
 		pr_err("Could not find CHAP_R\n");
 		goto out;
@@ -473,6 +482,14 @@ static int chap_server_compute_hash(
 		}
 		break;
 	case BASE64:
+		/*
+		 * No overflow check needed: initiatorchg_binhex is
+		 * CHAP_CHALLENGE_STR_LEN bytes and extract_param() caps
+		 * initiatorchg at CHAP_CHALLENGE_STR_LEN characters, so
+		 * the decoded output is at most DIV_ROUND_UP(
+		 * (CHAP_CHALLENGE_STR_LEN - 1) * 3, 4) bytes, which is
+		 * less than CHAP_CHALLENGE_STR_LEN.
+		 */
 		initiatorchg_len = chap_base64_decode(initiatorchg_binhex,
 						      initiatorchg,
 						      strlen(initiatorchg));
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 832588f21f91..b03ed154ca34 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -899,10 +899,14 @@ static int iscsi_target_handle_csg_zero(
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
-	if (ret < 0)
+	if (ret < 0) {
+		iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_INITIATOR_ERR,
+				ISCSI_LOGIN_STATUS_INIT_ERR);
 		return -1;
+	}
 
 	if (!iscsi_check_negotiated_keys(conn->param_list)) {
 		bool auth_required = iscsi_conn_auth_required(conn);
@@ -986,6 +990,7 @@ static int iscsi_target_handle_csg_one(struct iscsit_conn *conn, struct iscsi_lo
 			SENDER_TARGET,
 			login->rsp_buf,
 			&login->rsp_length,
+			MAX_KEY_VALUE_PAIRS,
 			conn->param_list,
 			conn->tpg->tpg_attrib.login_keys_workaround);
 	if (ret < 0) {
diff --git a/drivers/target/iscsi/iscsi_target_parameters.c b/drivers/target/iscsi/iscsi_target_parameters.c
index 4ed578c7b98d..2b318b13268e 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.c
+++ b/drivers/target/iscsi/iscsi_target_parameters.c
@@ -1371,19 +1371,42 @@ int iscsi_decode_text_input(
 	return -1;
 }
 
+/*
+ * Append "key=value" plus a trailing NUL into @textbuf at *@length.
+ * Returns 0 on success and advances *@length, or -EMSGSIZE if the
+ * record (including the NUL) would not fit in the remaining buffer.
+ */
+static int iscsi_encode_text_record(char *textbuf, u32 *length,
+				    u32 textbuf_size,
+				    const char *key, const char *value)
+{
+	int n;
+	u32 avail;
+
+	if (*length >= textbuf_size)
+		return -EMSGSIZE;
+
+	avail = textbuf_size - *length;
+	n = snprintf(textbuf + *length, avail, "%s=%s", key, value);
+	if (n < 0 || (u32)n + 1 > avail)
+		return -EMSGSIZE;
+
+	*length += n + 1;
+	return 0;
+}
+
 int iscsi_encode_text_output(
 	u8 phase,
 	u8 sender,
 	char *textbuf,
 	u32 *length,
+	u32 textbuf_size,
 	struct iscsi_param_list *param_list,
 	bool keys_workaround)
 {
-	char *output_buf = NULL;
 	struct iscsi_extra_response *er;
 	struct iscsi_param *param;
-
-	output_buf = textbuf + *length;
+	int ret;
 
 	if (iscsi_enforce_integrity_rules(phase, param_list) < 0)
 		return -1;
@@ -1395,10 +1418,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_RESPONSE_SENT(param) &&
 		    !IS_PSTATE_REPLY_OPTIONAL(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_RESPONSE_SENT(param);
 			pr_debug("Sending key: %s=%s\n",
 				param->name, param->value);
@@ -1408,10 +1433,12 @@ int iscsi_encode_text_output(
 		    !IS_PSTATE_ACCEPTOR(param) &&
 		    !IS_PSTATE_PROPOSER(param) &&
 		    (param->phase & phase)) {
-			*length += sprintf(output_buf, "%s=%s",
-				param->name, param->value);
-			*length += 1;
-			output_buf = textbuf + *length;
+			ret = iscsi_encode_text_record(textbuf, length,
+						       textbuf_size,
+						       param->name,
+						       param->value);
+			if (ret < 0)
+				goto err_overflow;
 			SET_PSTATE_PROPOSER(param);
 			iscsi_check_proposer_for_optional_reply(param,
 							        keys_workaround);
@@ -1421,14 +1448,21 @@ int iscsi_encode_text_output(
 	}
 
 	list_for_each_entry(er, &param_list->extra_response_list, er_list) {
-		*length += sprintf(output_buf, "%s=%s", er->key, er->value);
-		*length += 1;
-		output_buf = textbuf + *length;
+		ret = iscsi_encode_text_record(textbuf, length, textbuf_size,
+					       er->key, er->value);
+		if (ret < 0)
+			goto err_overflow;
 		pr_debug("Sending key: %s=%s\n", er->key, er->value);
 	}
 	iscsi_release_extra_responses(param_list);
 
 	return 0;
+
+err_overflow:
+	pr_err("iSCSI login response buffer (%u bytes) exhausted, dropping login.\n",
+	       textbuf_size);
+	iscsi_release_extra_responses(param_list);
+	return -1;
 }
 
 int iscsi_check_negotiated_keys(struct iscsi_param_list *param_list)
diff --git a/drivers/target/iscsi/iscsi_target_parameters.h b/drivers/target/iscsi/iscsi_target_parameters.h
index c672a971fcb7..38d2238dfe08 100644
--- a/drivers/target/iscsi/iscsi_target_parameters.h
+++ b/drivers/target/iscsi/iscsi_target_parameters.h
@@ -43,7 +43,7 @@ extern struct iscsi_param *iscsi_find_param_from_key(char *, struct iscsi_param_
 extern int iscsi_extract_key_value(char *, char **, char **);
 extern int iscsi_update_param_value(struct iscsi_param *, char *);
 extern int iscsi_decode_text_input(u8, u8, char *, u32, struct iscsit_conn *);
-extern int iscsi_encode_text_output(u8, u8, char *, u32 *,
+extern int iscsi_encode_text_output(u8, u8, char *, u32 *, u32,
 			struct iscsi_param_list *, bool);
 extern int iscsi_check_negotiated_keys(struct iscsi_param_list *);
 extern void iscsi_set_connection_parameters(struct iscsi_conn_ops *,
diff --git a/drivers/thunderbolt/property.c b/drivers/thunderbolt/property.c
index 50cbfc92fe65..da2c59a17db5 100644
--- a/drivers/thunderbolt/property.c
+++ b/drivers/thunderbolt/property.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/uuid.h>
@@ -34,10 +35,11 @@ struct tb_property_dir_entry {
 };
 
 #define TB_PROPERTY_ROOTDIR_MAGIC	0x55584401
+#define TB_PROPERTY_MAX_DEPTH		8
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	size_t block_len, unsigned int dir_offset, size_t dir_len,
-	bool is_root);
+	bool is_root, unsigned int depth);
 
 static inline void parse_dwdata(void *dst, const void *src, size_t dwords)
 {
@@ -52,13 +54,16 @@ static inline void format_dwdata(void *dst, const void *src, size_t dwords)
 static bool tb_property_entry_valid(const struct tb_property_entry *entry,
 				  size_t block_len)
 {
+	u32 end;
+
 	switch (entry->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 	case TB_PROPERTY_TYPE_DATA:
 	case TB_PROPERTY_TYPE_TEXT:
 		if (entry->length > block_len)
 			return false;
-		if (entry->value + entry->length > block_len)
+		if (check_add_overflow(entry->value, entry->length, &end) ||
+		    end > block_len)
 			return false;
 		break;
 
@@ -93,7 +98,8 @@ tb_property_alloc(const char *key, enum tb_property_type type)
 }
 
 static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
-					const struct tb_property_entry *entry)
+					const struct tb_property_entry *entry,
+					unsigned int depth)
 {
 	char key[TB_PROPERTY_KEY_SIZE + 1];
 	struct tb_property *property;
@@ -114,7 +120,7 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 	switch (property->type) {
 	case TB_PROPERTY_TYPE_DIRECTORY:
 		dir = __tb_property_parse_dir(block, block_len, entry->value,
-					      entry->length, false);
+					      entry->length, false, depth + 1);
 		if (!dir) {
 			kfree(property);
 			return NULL;
@@ -159,21 +165,31 @@ static struct tb_property *tb_property_parse(const u32 *block, size_t block_len,
 }
 
 static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
-	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root)
+	size_t block_len, unsigned int dir_offset, size_t dir_len, bool is_root,
+	unsigned int depth)
 {
 	const struct tb_property_entry *entries;
 	size_t i, content_len, nentries;
 	unsigned int content_offset;
 	struct tb_property_dir *dir;
 
+	if (depth > TB_PROPERTY_MAX_DEPTH)
+		return NULL;
+
 	dir = kzalloc_obj(*dir);
 	if (!dir)
 		return NULL;
 
+	INIT_LIST_HEAD(&dir->properties);
+
 	if (is_root) {
 		content_offset = dir_offset + 2;
 		content_len = dir_len;
 	} else {
+		if (dir_len < 4) {
+			tb_property_free_dir(dir);
+			return NULL;
+		}
 		dir->uuid = kmemdup(&block[dir_offset], sizeof(*dir->uuid),
 				    GFP_KERNEL);
 		if (!dir->uuid) {
@@ -187,12 +203,10 @@ static struct tb_property_dir *__tb_property_parse_dir(const u32 *block,
 	entries = (const struct tb_property_entry *)&block[content_offset];
 	nentries = content_len / (sizeof(*entries) / 4);
 
-	INIT_LIST_HEAD(&dir->properties);
-
 	for (i = 0; i < nentries; i++) {
 		struct tb_property *property;
 
-		property = tb_property_parse(block, block_len, &entries[i]);
+		property = tb_property_parse(block, block_len, &entries[i], depth);
 		if (!property) {
 			tb_property_free_dir(dir);
 			return NULL;
@@ -231,7 +245,7 @@ struct tb_property_dir *tb_property_parse_dir(const u32 *block,
 		return NULL;
 
 	return __tb_property_parse_dir(block, block_len, 0, rootdir->length,
-				       true);
+				       true, 0);
 }
 
 /**
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 94beadb4024d..2af0c4d0ad82 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -427,7 +427,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 
-	guard(uart_port_lock_irqsave)(p);
+	guard(uart_port_lock_check_sysrq_irqsave)(p);
 
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 328711b5df1a..c2cdc2955d59 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -1784,7 +1784,10 @@ static bool handle_rx_dma(struct uart_8250_port *up, unsigned int iir)
 }
 
 /*
- * Context: port's lock must be held by the caller.
+ * Context: port's lock must be held by the caller. The caller must
+ * release it via guard(uart_port_lock_check_sysrq_irqsave) or
+ * uart_unlock_and_check_sysrq_irqrestore(), which captures SysRq
+ * character on unlock.
  */
 void serial8250_handle_irq_locked(struct uart_port *port, unsigned int iir)
 {
@@ -1837,7 +1840,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	guard(uart_port_lock_irqsave)(port);
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
 	serial8250_handle_irq_locked(port, iir);
 
 	return 1;
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index d47a62d1c9f7..20f079fe11d8 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -379,6 +379,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	struct resource *res_mem;
 	int i = pdev->id;
 	int irq;
+	int ret;
 
 	/* -1 emphasizes that the platform must have one port, no .N suffix */
 	if (i == -1)
@@ -418,7 +419,11 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	port->flags = UPF_BOOT_AUTOCONF;
 	port->dev = &pdev->dev;
 
-	uart_add_one_port(&altera_jtaguart_driver, port);
+	ret = uart_add_one_port(&altera_jtaguart_driver, port);
+	if (ret) {
+		iounmap(port->membase);
+		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index eba91daedef8..67b12d7a647d 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -40,6 +40,7 @@
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/module.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/sysrq.h>
@@ -48,14 +49,6 @@
 
 #include <linux/atomic.h>
 #include <linux/io.h>
-#include <asm/bootinfo.h>
-
-#include <asm/dec/interrupts.h>
-#include <asm/dec/kn01.h>
-#include <asm/dec/kn02.h>
-#include <asm/dec/machtype.h>
-#include <asm/dec/prom.h>
-#include <asm/dec/system.h>
 
 #include "dz.h"
 
@@ -65,7 +58,9 @@ MODULE_LICENSE("GPL");
 
 
 static char dz_name[] __initdata = "DECstation DZ serial driver version ";
-static char dz_version[] __initdata = "1.04";
+static char dz_version[] __initdata = "1.05";
+
+#define DZ_IO_SIZE 0x20			/* IOMEM space size.  */
 
 struct dz_port {
 	struct dz_mux		*mux;
@@ -81,6 +76,7 @@ struct dz_mux {
 };
 
 static struct dz_mux dz_mux;
+static struct uart_driver dz_reg;
 
 static inline struct dz_port *to_dport(struct uart_port *uport)
 {
@@ -542,14 +538,47 @@ static int dz_encode_baud_rate(unsigned int baud)
 static void dz_reset(struct dz_port *dport)
 {
 	struct dz_mux *mux = dport->mux;
+	unsigned short tcr;
+	int loops = 10000;
 
 	if (mux->initialised)
 		return;
 
+	tcr = dz_in(dport, DZ_TCR);
+
+	/* Do not disturb any ongoing transmissions.  */
+	if (dz_in(dport, DZ_CSR) & DZ_MSE) {
+		unsigned short csr, mask;
+
+		mask = tcr;
+		while ((mask & DZ_LNENB) && loops--) {
+			csr = dz_in(dport, DZ_CSR);
+			if (!(csr & DZ_TRDY))
+				continue;
+			mask &= ~(1 << ((csr & DZ_TLINE) >> 8));
+			dz_out(dport, DZ_TCR, mask);
+			iob();
+			udelay(2);		/* 1.4us TRDY recovery.  */
+		}
+		fsleep(1200);			/* Transmitter drain.  */
+	}
+
 	dz_out(dport, DZ_CSR, DZ_CLR);
 	while (dz_in(dport, DZ_CSR) & DZ_CLR);
 	iob();
 
+	/*
+	 * Set parameters across all lines such as not to interfere
+	 * with the initial PROM-based console.  Otherwise any output
+	 * produced before the console handover would cause the system
+	 * firmware to produce rubbish.
+	 */
+	for (int line = 0; line < DZ_NB_PORT; line++)
+		dz_out(dport, DZ_LPR, DZ_B9600 | DZ_CS8 | line);
+
+	/* Re-enable transmission for the initial PROM-based console.  */
+	dz_out(dport, DZ_TCR, tcr);
+
 	/* Enable scanning.  */
 	dz_out(dport, DZ_CSR, DZ_MSE);
 
@@ -633,26 +662,6 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 	uart_port_unlock_irqrestore(&dport->port, flags);
 }
 
-/*
- * Hack alert!
- * Required solely so that the initial PROM-based console
- * works undisturbed in parallel with this one.
- */
-static void dz_pm(struct uart_port *uport, unsigned int state,
-		  unsigned int oldstate)
-{
-	struct dz_port *dport = to_dport(uport);
-	unsigned long flags;
-
-	uart_port_lock_irqsave(&dport->port, &flags);
-	if (state < 3)
-		dz_start_tx(&dport->port);
-	else
-		dz_stop_tx(&dport->port);
-	uart_port_unlock_irqrestore(&dport->port, flags);
-}
-
-
 static const char *dz_type(struct uart_port *uport)
 {
 	return "DZ";
@@ -668,14 +677,13 @@ static void dz_release_port(struct uart_port *uport)
 
 	map_guard = atomic_add_return(-1, &mux->map_guard);
 	if (!map_guard)
-		release_mem_region(uport->mapbase, dec_kn_slot_size);
+		release_mem_region(uport->mapbase, DZ_IO_SIZE);
 }
 
 static int dz_map_port(struct uart_port *uport)
 {
 	if (!uport->membase)
-		uport->membase = ioremap(uport->mapbase,
-						 dec_kn_slot_size);
+		uport->membase = ioremap(uport->mapbase, DZ_IO_SIZE);
 	if (!uport->membase) {
 		printk(KERN_ERR "dz: Cannot map MMIO\n");
 		return -ENOMEM;
@@ -691,8 +699,7 @@ static int dz_request_port(struct uart_port *uport)
 
 	map_guard = atomic_add_return(1, &mux->map_guard);
 	if (map_guard == 1) {
-		if (!request_mem_region(uport->mapbase, dec_kn_slot_size,
-					"dz")) {
+		if (!request_mem_region(uport->mapbase, DZ_IO_SIZE, "dz")) {
 			atomic_add(-1, &mux->map_guard);
 			printk(KERN_ERR
 			       "dz: Unable to reserve MMIO resource\n");
@@ -703,7 +710,7 @@ static int dz_request_port(struct uart_port *uport)
 	if (ret) {
 		map_guard = atomic_add_return(-1, &mux->map_guard);
 		if (!map_guard)
-			release_mem_region(uport->mapbase, dec_kn_slot_size);
+			release_mem_region(uport->mapbase, DZ_IO_SIZE);
 		return ret;
 	}
 	return 0;
@@ -748,7 +755,6 @@ static const struct uart_ops dz_ops = {
 	.startup	= dz_startup,
 	.shutdown	= dz_shutdown,
 	.set_termios	= dz_set_termios,
-	.pm		= dz_pm,
 	.type		= dz_type,
 	.release_port	= dz_release_port,
 	.request_port	= dz_request_port,
@@ -756,20 +762,15 @@ static const struct uart_ops dz_ops = {
 	.verify_port	= dz_verify_port,
 };
 
-static void __init dz_init_ports(void)
+static int __init dz_probe(struct platform_device *pdev)
 {
-	static int first = 1;
-	unsigned long base;
+	struct resource *mem_resource, *irq_resource;
 	int line;
 
-	if (!first)
-		return;
-	first = 0;
-
-	if (mips_machtype == MACH_DS23100 || mips_machtype == MACH_DS5100)
-		base = dec_kn_slot_base + KN01_DZ11;
-	else
-		base = dec_kn_slot_base + KN02_DZ11;
+	mem_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_resource = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mem_resource || !irq_resource)
+		return -ENODEV;
 
 	for (line = 0; line < DZ_NB_PORT; line++) {
 		struct dz_port *dport = &dz_mux.dport[line];
@@ -777,14 +778,33 @@ static void __init dz_init_ports(void)
 
 		dport->mux	= &dz_mux;
 
-		uport->irq	= dec_interrupt[DEC_IRQ_DZ11];
+		uport->dev	= &pdev->dev;
+		uport->irq	= irq_resource->start;
 		uport->fifosize	= 1;
 		uport->iotype	= UPIO_MEM;
 		uport->flags	= UPF_BOOT_AUTOCONF;
 		uport->ops	= &dz_ops;
 		uport->line	= line;
-		uport->mapbase	= base;
+		uport->mapbase	= mem_resource->start;
 		uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_DZ_CONSOLE);
+
+		if (uart_add_one_port(&dz_reg, uport))
+			uport->dev = NULL;
+	}
+
+	return 0;
+}
+
+static void __exit dz_remove(struct platform_device *pdev)
+{
+	int line;
+
+	for (line = DZ_NB_PORT - 1; line >= 0; line--) {
+		struct dz_port *dport = &dz_mux.dport[line];
+		struct uart_port *uport = &dport->port;
+
+		if (uport->dev)
+			uart_remove_one_port(&dz_reg, uport);
 	}
 }
 
@@ -867,24 +887,14 @@ static int __init dz_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-	int ret;
-
-	ret = dz_map_port(uport);
-	if (ret)
-		return ret;
-
-	spin_lock_init(&dport->port.lock);	/* For dz_pm().  */
-
-	dz_reset(dport);
-	dz_pm(uport, 0, -1);
 
+	if (!dport->mux)
+		return -ENODEV;
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-
-	return uart_set_options(&dport->port, co, baud, parity, bits, flow);
+	return uart_set_options(uport, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver dz_reg;
 static struct console dz_console = {
 	.name	= "ttyS",
 	.write	= dz_console_print,
@@ -895,18 +905,6 @@ static struct console dz_console = {
 	.data	= &dz_reg,
 };
 
-static int __init dz_serial_console_init(void)
-{
-	if (!IOASIC) {
-		dz_init_ports();
-		register_console(&dz_console);
-		return 0;
-	} else
-		return -ENXIO;
-}
-
-console_initcall(dz_serial_console_init);
-
 #define SERIAL_DZ_CONSOLE	&dz_console
 #else
 #define SERIAL_DZ_CONSOLE	NULL
@@ -922,25 +920,32 @@ static struct uart_driver dz_reg = {
 	.cons			= SERIAL_DZ_CONSOLE,
 };
 
+static struct platform_driver dz_driver = {
+	.remove = __exit_p(dz_remove),
+	.driver = { .name = "dz" },
+};
+
 static int __init dz_init(void)
 {
-	int ret, i;
-
-	if (IOASIC)
-		return -ENXIO;
+	int ret;
 
 	printk("%s%s\n", dz_name, dz_version);
 
-	dz_init_ports();
-
 	ret = uart_register_driver(&dz_reg);
 	if (ret)
 		return ret;
+	ret = platform_driver_probe(&dz_driver, dz_probe);
+	if (ret)
+		uart_unregister_driver(&dz_reg);
 
-	for (i = 0; i < DZ_NB_PORT; i++)
-		uart_add_one_port(&dz_reg, &dz_mux.dport[i].port);
+	return ret;
+}
 
-	return 0;
+static void __exit dz_exit(void)
+{
+	platform_driver_unregister(&dz_driver);
+	uart_unregister_driver(&dz_reg);
 }
 
 module_init(dz_init);
+module_exit(dz_exit);
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1bd7ec9c81ea..b7919c05f0fb 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1379,7 +1379,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 
 	if (!nent) {
 		dev_err(sport->port.dev, "DMA Rx mapping error\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_free_buf;
 	}
 
 	dma_rx_sconfig.src_addr = lpuart_dma_datareg_addr(sport);
@@ -1391,7 +1392,7 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	if (ret < 0) {
 		dev_err(sport->port.dev,
 				"DMA Rx slave config failed, err = %d\n", ret);
-		return ret;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc = dmaengine_prep_dma_cyclic(chan,
@@ -1402,7 +1403,8 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 				 DMA_PREP_INTERRUPT);
 	if (!sport->dma_rx_desc) {
 		dev_err(sport->port.dev, "Cannot prepare cyclic DMA\n");
-		return -EFAULT;
+		ret = -ENOMEM;
+		goto err_unmap_sg;
 	}
 
 	sport->dma_rx_desc->callback = lpuart_dma_rx_complete;
@@ -1426,6 +1428,13 @@ static inline int lpuart_start_rx_dma(struct lpuart_port *sport)
 	}
 
 	return 0;
+
+err_unmap_sg:
+	dma_unmap_sg(chan->device->dev, &sport->rx_sgl, 1, DMA_FROM_DEVICE);
+err_free_buf:
+	kfree(ring->buf);
+	ring->buf = NULL;
+	return ret;
 }
 
 static void lpuart_dma_rx_free(struct uart_port *port)
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 6729d8e83c3c..ba1fcd663fe2 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -689,8 +689,7 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Tx)\n",
 			__func__);
-		pci_dev_put(dma_dev);
-		return;
+		goto err_pci_get;
 	}
 	priv->chan_tx = chan;
 
@@ -704,18 +703,26 @@ static void pch_request_dma(struct uart_port *port)
 	if (!chan) {
 		dev_err(priv->port.dev, "%s:dma_request_channel FAILS(Rx)\n",
 			__func__);
-		dma_release_channel(priv->chan_tx);
-		priv->chan_tx = NULL;
-		pci_dev_put(dma_dev);
-		return;
+		goto err_req_tx;
 	}
 
 	/* Get Consistent memory for DMA */
 	priv->rx_buf_virt = dma_alloc_coherent(port->dev, port->fifosize,
 				    &priv->rx_buf_dma, GFP_KERNEL);
+	if (!priv->rx_buf_virt)
+		goto err_req_rx;
 	priv->chan_rx = chan;
 
 	pci_dev_put(dma_dev);
+	return;
+
+err_req_rx:
+	dma_release_channel(chan);
+err_req_tx:
+	dma_release_channel(priv->chan_tx);
+	priv->chan_tx = NULL;
+err_pci_get:
+	pci_dev_put(dma_dev);
 }
 
 static void pch_dma_rx_complete(void *arg)
diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index e6b0a55f0cfb..774c0b7f8508 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -50,7 +50,7 @@
 #define TX_STOP_BIT_LEN_2		2
 
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_PAR_EN			BIT(3)
+#define UART_RX_PAR_EN			BIT(4)
 
 /* SE_UART_RX_WORD_LEN */
 #define RX_WORD_LEN_MASK		GENMASK(9, 0)
@@ -1030,8 +1030,20 @@ static void qcom_geni_serial_handle_tx_dma(struct uart_port *uport)
 {
 	struct qcom_geni_serial_port *port = to_dev_port(uport);
 	struct tty_port *tport = &uport->state->port;
+	unsigned int fifo_len = kfifo_len(&tport->xmit_fifo);
+
+	/*
+	 * Only advance the kfifo if it still contains the bytes that were
+	 * transferred. uart_flush_buffer() may have run before this IRQ
+	 * fired: it calls kfifo_reset() under the port lock, making
+	 * fifo_len = 0 while tx_remaining remains non-zero. Calling
+	 * uart_xmit_advance() in that case would underflow kfifo->out past
+	 * kfifo->in, making kfifo_len() wrap to UART_XMIT_SIZE - tx_remaining
+	 * and triggering a spurious large DMA transfer of stale data.
+	 */
+	if (fifo_len >= port->tx_remaining)
+		uart_xmit_advance(uport, port->tx_remaining);
 
-	uart_xmit_advance(uport, port->tx_remaining);
 	geni_se_tx_dma_unprep(&port->se, port->tx_dma_addr, port->tx_remaining);
 	port->tx_dma_addr = 0;
 	port->tx_remaining = 0;
diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c1fabad6ba1f..e82e2014560e 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -245,12 +245,9 @@ static bool s3c24xx_serial_txempty_nofifo(const struct uart_port *port)
 static void s3c24xx_serial_rx_enable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	int count = 10000;
 	u32 ucon, ufcon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	while (--count && !s3c24xx_serial_txempty_nofifo(port))
 		udelay(100);
 
@@ -263,23 +260,18 @@ static void s3c24xx_serial_rx_enable(struct uart_port *port)
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 1;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_rx_disable(struct uart_port *port)
 {
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
-	unsigned long flags;
 	u32 ucon;
 
-	uart_port_lock_irqsave(port, &flags);
-
 	ucon = rd_regl(port, S3C2410_UCON);
 	ucon &= ~S3C2410_UCON_RXIRQMODE;
 	wr_regl(port, S3C2410_UCON, ucon);
 
 	ourport->rx_enabled = 0;
-	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void s3c24xx_serial_stop_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index bd7486315338..9e619db27237 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3024,7 +3024,7 @@ int sci_request_port(struct uart_port *port)
 
 	ret = sci_remap_port(port);
 	if (unlikely(ret != 0)) {
-		release_resource(res);
+		release_mem_region(port->mapbase, sport->reg_size);
 		return ret;
 	}
 
diff --git a/drivers/tty/serial/zs.c b/drivers/tty/serial/zs.c
index 79ea7108a0f3..8cafb79912cf 100644
--- a/drivers/tty/serial/zs.c
+++ b/drivers/tty/serial/zs.c
@@ -56,6 +56,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/major.h>
+#include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 #include <linux/spinlock.h>
@@ -66,10 +67,6 @@
 
 #include <linux/atomic.h>
 
-#include <asm/dec/interrupts.h>
-#include <asm/dec/ioasic_addrs.h>
-#include <asm/dec/system.h>
-
 #include "zs.h"
 
 
@@ -79,7 +76,7 @@ MODULE_LICENSE("GPL");
 
 
 static char zs_name[] __initdata = "DECstation Z85C30 serial driver version ";
-static char zs_version[] __initdata = "0.10";
+static char zs_version[] __initdata = "0.11";
 
 /*
  * It would be nice to dynamically allocate everything that
@@ -98,25 +95,27 @@ static char zs_version[] __initdata = "0.10";
 
 #define to_zport(uport) container_of(uport, struct zs_port, port)
 
-struct zs_parms {
-	resource_size_t scc[ZS_NUM_SCCS];
-	int irq[ZS_NUM_SCCS];
-};
-
 static struct zs_scc zs_sccs[ZS_NUM_SCCS];
+static struct uart_driver zs_reg;
 
+/*
+ * Set parameters in WR5, WR12, WR13 such as not to interfere
+ * with the initial PROM-based console.  Otherwise any output
+ * produced before the console handover would cause the system
+ * firmware to hang (TxENAB) or produce rubbish (Tx8, B9600).
+ */
 static u8 zs_init_regs[ZS_NUM_REGS] __initdata = {
 	0,				/* write 0 */
 	PAR_SPEC,			/* write 1 */
 	0,				/* write 2 */
 	0,				/* write 3 */
 	X16CLK | SB1,			/* write 4 */
-	0,				/* write 5 */
+	Tx8 | TxENAB,			/* write 5 */
 	0, 0, 0,			/* write 6, 7, 8 */
 	MIE | DLC | NV,			/* write 9 */
 	NRZ,				/* write 10 */
 	TCBR | RCBR,			/* write 11 */
-	0, 0,				/* BRG time constant, write 12 + 13 */
+	0x16, 0x00,			/* BRG time constant, write 12 + 13 */
 	BRSRC | BRENABL,		/* write 14 */
 	0,				/* write 15 */
 };
@@ -680,9 +679,9 @@ static void zs_status_handle(struct zs_port *zport, struct zs_port *zport_a)
 			uart_handle_dcd_change(uport,
 					       zport->mctrl & TIOCM_CAR);
 		if (delta & TIOCM_RNG)
-			uport->icount.dsr++;
-		if (delta & TIOCM_DSR)
 			uport->icount.rng++;
+		if (delta & TIOCM_DSR)
+			uport->icount.dsr++;
 
 		if (delta)
 			wake_up_interruptible(&uport->state->port.delta_msr_wait);
@@ -826,22 +825,22 @@ static void zs_shutdown(struct uart_port *uport)
 
 static void zs_reset(struct zs_port *zport)
 {
+	struct zs_port *zport_a = &zport->scc->zport[ZS_CHAN_A];
 	struct zs_scc *scc = zport->scc;
 	int irq;
 	unsigned long flags;
 
 	spin_lock_irqsave(&scc->zlock, flags);
 	irq = !irqs_disabled_flags(flags);
-	if (!scc->initialised) {
-		/* Reset the pointer first, just in case...  */
-		read_zsreg(zport, R0);
-		/* And let the current transmission finish.  */
-		zs_line_drain(zport, irq);
-		write_zsreg(zport, R9, FHWRES);
-		udelay(10);
-		write_zsreg(zport, R9, 0);
-		scc->initialised = 1;
-	}
+
+	/* Reset the pointer first, just in case...  */
+	read_zsreg(zport, R0);
+	/* And let the current transmission finish.  */
+	zs_line_drain(zport, irq);
+	write_zsreg(zport, R9, zport == zport_a ? CHRA : CHRB);
+	udelay(10);
+	write_zsreg(zport, R9, 0);
+
 	load_zsregs(zport, zport->regs, irq);
 	spin_unlock_irqrestore(&scc->zlock, flags);
 }
@@ -956,23 +955,6 @@ static void zs_set_termios(struct uart_port *uport, struct ktermios *termios,
 	spin_unlock_irqrestore(&scc->zlock, flags);
 }
 
-/*
- * Hack alert!
- * Required solely so that the initial PROM-based console
- * works undisturbed in parallel with this one.
- */
-static void zs_pm(struct uart_port *uport, unsigned int state,
-		  unsigned int oldstate)
-{
-	struct zs_port *zport = to_zport(uport);
-
-	if (state < 3)
-		zport->regs[5] |= TxENAB;
-	else
-		zport->regs[5] &= ~TxENAB;
-	write_zsreg(zport, R5, zport->regs[5]);
-}
-
 
 static const char *zs_type(struct uart_port *uport)
 {
@@ -1055,7 +1037,6 @@ static const struct uart_ops zs_ops = {
 	.startup	= zs_startup,
 	.shutdown	= zs_shutdown,
 	.set_termios	= zs_set_termios,
-	.pm		= zs_pm,
 	.type		= zs_type,
 	.release_port	= zs_release_port,
 	.request_port	= zs_request_port,
@@ -1066,63 +1047,62 @@ static const struct uart_ops zs_ops = {
 /*
  * Initialize Z85C30 port structures.
  */
-static int __init zs_probe_sccs(void)
+static int __init zs_probe(struct platform_device *pdev)
 {
-	static int probed;
-	struct zs_parms zs_parms;
-	int chip, side, irq;
-	int n_chips = 0;
+	struct resource *mem_resource, *irq_resource;
+	int chip, side;
 	int i;
 
-	if (probed)
-		return 0;
+	mem_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	irq_resource = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!mem_resource || !irq_resource)
+		return -ENODEV;
 
-	irq = dec_interrupt[DEC_IRQ_SCC0];
-	if (irq >= 0) {
-		zs_parms.scc[n_chips] = IOASIC_SCC0;
-		zs_parms.irq[n_chips] = dec_interrupt[DEC_IRQ_SCC0];
-		n_chips++;
-	}
-	irq = dec_interrupt[DEC_IRQ_SCC1];
-	if (irq >= 0) {
-		zs_parms.scc[n_chips] = IOASIC_SCC1;
-		zs_parms.irq[n_chips] = dec_interrupt[DEC_IRQ_SCC1];
-		n_chips++;
-	}
-	if (!n_chips)
-		return -ENXIO;
-
-	probed = 1;
-
-	for (chip = 0; chip < n_chips; chip++) {
-		spin_lock_init(&zs_sccs[chip].zlock);
-		for (side = 0; side < ZS_NUM_CHAN; side++) {
-			struct zs_port *zport = &zs_sccs[chip].zport[side];
-			struct uart_port *uport = &zport->port;
-
-			zport->scc	= &zs_sccs[chip];
-			zport->clk_mode	= 16;
-
-			uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ZS_CONSOLE);
-			uport->irq	= zs_parms.irq[chip];
-			uport->uartclk	= ZS_CLOCK;
-			uport->fifosize	= 1;
-			uport->iotype	= UPIO_MEM;
-			uport->flags	= UPF_BOOT_AUTOCONF;
-			uport->ops	= &zs_ops;
-			uport->line	= chip * ZS_NUM_CHAN + side;
-			uport->mapbase	= dec_kn_slot_base +
-					  zs_parms.scc[chip] +
-					  (side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE;
-
-			for (i = 0; i < ZS_NUM_REGS; i++)
-				zport->regs[i] = zs_init_regs[i];
-		}
+	chip = pdev->id;
+	spin_lock_init(&zs_sccs[chip].zlock);
+	for (side = 0; side < ZS_NUM_CHAN; side++) {
+		struct zs_port *zport = &zs_sccs[chip].zport[side];
+		struct uart_port *uport = &zport->port;
+
+		zport->scc	= &zs_sccs[chip];
+		zport->clk_mode	= 16;
+
+		uport->dev	= &pdev->dev;
+		uport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_ZS_CONSOLE);
+		uport->irq	= irq_resource->start;
+		uport->uartclk	= ZS_CLOCK;
+		uport->fifosize	= 1;
+		uport->iotype	= UPIO_MEM;
+		uport->flags	= UPF_BOOT_AUTOCONF;
+		uport->ops	= &zs_ops;
+		uport->line	= chip * ZS_NUM_CHAN + side;
+		uport->mapbase	= mem_resource->start +
+				  (side ^ ZS_CHAN_B) * ZS_CHAN_IO_SIZE;
+
+		for (i = 0; i < ZS_NUM_REGS; i++)
+			zport->regs[i] = zs_init_regs[i];
+
+		if (uart_add_one_port(&zs_reg, uport))
+			uport->dev = NULL;
 	}
 
 	return 0;
 }
 
+static void __exit zs_remove(struct platform_device *pdev)
+{
+	int chip, side;
+
+	chip = pdev->id;
+	for (side = ZS_NUM_CHAN - 1; side >= 0; side--) {
+		struct zs_port *zport = &zs_sccs[chip].zport[side];
+		struct uart_port *uport = &zport->port;
+
+		if (uport->dev)
+			uart_remove_one_port(&zs_reg, uport);
+	}
+}
+
 
 #ifdef CONFIG_SERIAL_ZS_CONSOLE
 static void zs_console_putchar(struct uart_port *uport, unsigned char ch)
@@ -1203,21 +1183,14 @@ static int __init zs_console_setup(struct console *co, char *options)
 	int bits = 8;
 	int parity = 'n';
 	int flow = 'n';
-	int ret;
-
-	ret = zs_map_port(uport);
-	if (ret)
-		return ret;
-
-	zs_reset(zport);
-	zs_pm(uport, 0, -1);
 
+	if (!zport->scc)
+		return -ENODEV;
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	return uart_set_options(uport, co, baud, parity, bits, flow);
 }
 
-static struct uart_driver zs_reg;
 static struct console zs_console = {
 	.name	= "ttyS",
 	.write	= zs_console_write,
@@ -1228,23 +1201,6 @@ static struct console zs_console = {
 	.data	= &zs_reg,
 };
 
-/*
- *	Register console.
- */
-static int __init zs_serial_console_init(void)
-{
-	int ret;
-
-	ret = zs_probe_sccs();
-	if (ret)
-		return ret;
-	register_console(&zs_console);
-
-	return 0;
-}
-
-console_initcall(zs_serial_console_init);
-
 #define SERIAL_ZS_CONSOLE	&zs_console
 #else
 #define SERIAL_ZS_CONSOLE	NULL
@@ -1260,47 +1216,31 @@ static struct uart_driver zs_reg = {
 	.cons			= SERIAL_ZS_CONSOLE,
 };
 
+static struct platform_driver zs_driver = {
+	.remove = __exit_p(zs_remove),
+	.driver = { .name = "zs" },
+};
+
 /* zs_init inits the driver. */
 static int __init zs_init(void)
 {
-	int i, ret;
+	int ret;
 
 	pr_info("%s%s\n", zs_name, zs_version);
 
-	/* Find out how many Z85C30 SCCs we have.  */
-	ret = zs_probe_sccs();
-	if (ret)
-		return ret;
-
 	ret = uart_register_driver(&zs_reg);
 	if (ret)
 		return ret;
+	ret = platform_driver_probe(&zs_driver, zs_probe);
+	if (ret)
+		uart_unregister_driver(&zs_reg);
 
-	for (i = 0; i < ZS_NUM_SCCS * ZS_NUM_CHAN; i++) {
-		struct zs_scc *scc = &zs_sccs[i / ZS_NUM_CHAN];
-		struct zs_port *zport = &scc->zport[i % ZS_NUM_CHAN];
-		struct uart_port *uport = &zport->port;
-
-		if (zport->scc)
-			uart_add_one_port(&zs_reg, uport);
-	}
-
-	return 0;
+	return ret;
 }
 
 static void __exit zs_exit(void)
 {
-	int i;
-
-	for (i = ZS_NUM_SCCS * ZS_NUM_CHAN - 1; i >= 0; i--) {
-		struct zs_scc *scc = &zs_sccs[i / ZS_NUM_CHAN];
-		struct zs_port *zport = &scc->zport[i % ZS_NUM_CHAN];
-		struct uart_port *uport = &zport->port;
-
-		if (zport->scc)
-			uart_remove_one_port(&zs_reg, uport);
-	}
-
+	platform_driver_unregister(&zs_driver);
 	uart_unregister_driver(&zs_reg);
 }
 
diff --git a/drivers/tty/serial/zs.h b/drivers/tty/serial/zs.h
index 26ef8eafa1c1..e0d3c189b33f 100644
--- a/drivers/tty/serial/zs.h
+++ b/drivers/tty/serial/zs.h
@@ -41,7 +41,6 @@ struct zs_scc {
 	struct zs_port	zport[2];
 	spinlock_t	zlock;
 	atomic_t	irq_guard;
-	int		initialised;
 };
 
 #endif /* __KERNEL__ */
diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
index 4a46acd994a8..d05ef77f7e32 100644
--- a/drivers/uio/uio_pci_generic_sva.c
+++ b/drivers/uio/uio_pci_generic_sva.c
@@ -129,15 +129,13 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	ret = devm_uio_register_device(&pdev->dev, &udev->info);
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to register uio device\n");
-		goto out_free;
+		goto out_disable;
 	}
 
 	pci_set_drvdata(pdev, udev);
 
 	return 0;
 
-out_free:
-	kfree(udev);
 out_disable:
 	pci_disable_device(pdev);
 
@@ -146,11 +144,8 @@ static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 static void remove(struct pci_dev *pdev)
 {
-	struct uio_pci_sva_dev *udev = pci_get_drvdata(pdev);
-
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-	kfree(udev);
 }
 
 static ssize_t pasid_show(struct device *dev,
diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index 8382231af357..1db8db1b7cc3 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2817,9 +2817,19 @@ int __cdns3_gadget_ep_clear_halt(struct cdns3_endpoint *priv_ep)
 	priv_ep->flags &= ~(EP_STALLED | EP_STALL_PENDING);
 
 	if (request) {
-		if (trb)
+		if (trb) {
 			*trb = trb_tmp;
 
+			/*
+			 * Per datasheet, EPRST causes DMA to reposition to the next TD.
+			 * Manually reset EP_TRADDR to the current TRB to prevent
+			 * the hardware from skipping the interrupted request.
+			 */
+			writel(EP_TRADDR_TRADDR(priv_ep->trb_pool_dma +
+						priv_req->start_trb * TRB_SIZE),
+						&priv_dev->regs->ep_traddr);
+		}
+
 		cdns3_rearm_transfer(priv_ep, 1);
 	}
 
diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 735df88774e4..94e9706a1806 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -126,15 +126,15 @@ static int cdns3_plat_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(cdns->usb2_phy),
 				     "Failed to get cdn3,usb2-phy\n");
 
-	ret = phy_init(cdns->usb2_phy);
-	if (ret)
-		return ret;
-
 	cdns->usb3_phy = devm_phy_optional_get(dev, "cdns3,usb3-phy");
 	if (IS_ERR(cdns->usb3_phy))
 		return dev_err_probe(dev, PTR_ERR(cdns->usb3_phy),
 				     "Failed to get cdn3,usb3-phy\n");
 
+	ret = phy_init(cdns->usb2_phy);
+	if (ret)
+		return ret;
+
 	ret = phy_init(cdns->usb3_phy);
 	if (ret)
 		goto err_phy3_init;
@@ -186,6 +186,9 @@ static void cdns3_plat_remove(struct platform_device *pdev)
 	struct device *dev = cdns->dev;
 
 	pm_runtime_get_sync(dev);
+	if (!(cdns->pdata && (cdns->pdata->quirks & CDNS3_DEFAULT_PM_RUNTIME_ALLOW)))
+		pm_runtime_allow(dev);
+
 	pm_runtime_disable(dev);
 	pm_runtime_put_noidle(dev);
 	cdns_remove(cdns);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 57d2816cf05f..85ebc6651dba 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -670,12 +670,6 @@ static enum ci_role ci_get_role(struct ci_hdrc *ci)
 	return role;
 }
 
-static struct usb_role_switch_desc ci_role_switch = {
-	.set = ci_usb_role_switch_set,
-	.get = ci_usb_role_switch_get,
-	.allow_userspace_control = true,
-};
-
 static int ci_get_platdata(struct device *dev,
 		struct ci_hdrc_platform_data *platdata)
 {
@@ -802,9 +796,6 @@ static int ci_get_platdata(struct device *dev,
 			cable->connected = false;
 	}
 
-	if (device_property_read_bool(dev, "usb-role-switch"))
-		ci_role_switch.fwnode = dev->fwnode;
-
 	platdata->pctl = devm_pinctrl_get(dev);
 	if (!IS_ERR(platdata->pctl)) {
 		struct pinctrl_state *p;
@@ -1048,6 +1039,7 @@ ATTRIBUTE_GROUPS(ci);
 
 static int ci_hdrc_probe(struct platform_device *pdev)
 {
+	struct usb_role_switch_desc ci_role_switch = {};
 	struct device	*dev = &pdev->dev;
 	struct ci_hdrc	*ci;
 	struct resource	*res;
@@ -1194,7 +1186,11 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (ci_role_switch.fwnode) {
+	if (device_property_read_bool(dev, "usb-role-switch")) {
+		ci_role_switch.set = ci_usb_role_switch_set;
+		ci_role_switch.get = ci_usb_role_switch_get;
+		ci_role_switch.allow_userspace_control = true;
+		ci_role_switch.fwnode = dev_fwnode(dev);
 		ci_role_switch.driver_data = ci;
 		ci->role_switch = usb_role_switch_register(dev,
 					&ci_role_switch);
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index 54059e4fc6ed..ddf0b5963859 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -114,8 +114,6 @@ static int acm_ctrl_msg(struct acm *acm, int request, int value,
 	int retval;
 
 	retval = usb_autopm_get_interface(acm->control);
-#define VENDOR_CLASS_DATA_IFACE		BIT(9)  /* data interface uses vendor-specific class */
-#define ALWAYS_POLL_CTRL		BIT(10) /* keep ctrl URB active even without an open TTY */
 	if (retval)
 		return retval;
 
diff --git a/drivers/usb/class/cdc-acm.h b/drivers/usb/class/cdc-acm.h
index 25fd5329a878..01f448a783c0 100644
--- a/drivers/usb/class/cdc-acm.h
+++ b/drivers/usb/class/cdc-acm.h
@@ -115,3 +115,5 @@ struct acm {
 #define DISABLE_ECHO			BIT(7)
 #define MISSING_CAP_BRK			BIT(8)
 #define NO_UNION_12			BIT(9)
+#define VENDOR_CLASS_DATA_IFACE		BIT(10)  /* data interface uses vendor-specific class */
+#define ALWAYS_POLL_CTRL		BIT(11) /* keep ctrl URB active even without an open TTY */
diff --git a/drivers/usb/class/usbtmc.c b/drivers/usb/class/usbtmc.c
index bd9347804dec..af9ae55dae14 100644
--- a/drivers/usb/class/usbtmc.c
+++ b/drivers/usb/class/usbtmc.c
@@ -2306,6 +2306,14 @@ static void usbtmc_interrupt(struct urb *urb)
 
 	switch (status) {
 	case 0: /* SUCCESS */
+		/* ensure at least two bytes of headers were transferred */
+		if (urb->actual_length < 2) {
+			dev_warn(dev,
+				"actual length %d not sufficient for interrupt headers\n",
+				urb->actual_length);
+			goto exit;
+		}
+
 		/* check for valid STB notification */
 		if (data->iin_buffer[0] > 0x81) {
 			data->bNotify1 = data->iin_buffer[0];
@@ -2432,6 +2440,12 @@ static int usbtmc_probe(struct usb_interface *intf,
 		data->iin_ep = int_in->bEndpointAddress;
 		data->iin_wMaxPacketSize = usb_endpoint_maxp(int_in);
 		data->iin_interval = int_in->bInterval;
+		/* wMaxPacketSize should be 0x02 or more as per USB488 Table 22 */
+		if (iface_desc->desc.bInterfaceProtocol == 1 &&
+		    data->iin_wMaxPacketSize < 2) {
+			retcode = -EINVAL;
+			goto err_put;
+		}
 		dev_dbg(&intf->dev, "Found Int in endpoint at %u\n",
 				data->iin_ep);
 	}
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 6a1fd967e0a6..74945cd30cd2 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -191,7 +191,14 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 			(desc->bMaxBurst + 1);
 	else
 		max_tx = 999999;
-	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
+	/*
+	 * wBytesPerInterval > max_tx is bogus, but USB3 spec doesn't forbid the opposite.
+	 * Experience shows that wBytesPerInterval < wMaxPacketSize on common interrupt IN
+	 * endpoints is usually bogus too, and recent HCs enforce interrupt BW limits.
+	 */
+	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx ||
+	    (le16_to_cpu(desc->wBytesPerInterval) < usb_endpoint_maxp(&ep->desc) &&
+	     usb_endpoint_is_int_in(&ep->desc))) {
 		dev_notice(ddev, "%s endpoint with wBytesPerInterval of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to %d\n",
diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 89221f1ce769..b181b43a35dc 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -328,9 +328,7 @@ static const u8 ss_rh_config_descriptor[] = {
 	USB_DT_ENDPOINT, /* __u8 ep_bDescriptorType; Endpoint */
 	0x81,       /*  __u8  ep_bEndpointAddress; IN Endpoint 1 */
 	0x03,       /*  __u8  ep_bmAttributes; Interrupt */
-		    /* __le16 ep_wMaxPacketSize; 1 + (MAX_ROOT_PORTS / 8)
-		     * see hub.c:hub_configure() for details. */
-	(USB_MAXCHILDREN + 1 + 7) / 8, 0x00,
+	0x02, 0x00, /* __le16 ep_wMaxPacketSize; 2 bytes per USB3 10.15.1 */
 	0x0c,       /*  __u8  ep_bInterval; (256ms -- usb 2.0 spec) */
 
 	/* one SuperSpeed endpoint companion descriptor */
diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 0ffdaefba508..87810eff974e 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -513,6 +513,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Lenovo ThinkPad USB-C Dock Gen2 Ethernet (RTL8153 GigE) */
 	{ USB_DEVICE(0x17ef, 0xa387), .driver_info = USB_QUIRK_NO_LPM },
 
+	/* Lenovo ThinkPad USB-C Dock Gen2 USB 3.1 and USB 2.0 hub controllers */
+	{ USB_DEVICE(0x17ef, 0xa391), .driver_info = USB_QUIRK_NO_LPM },
+	{ USB_DEVICE(0x17ef, 0xa392), .driver_info = USB_QUIRK_NO_LPM },
+
 	/* BUILDWIN Photo Frame */
 	{ USB_DEVICE(0x1908, 0x1315), .driver_info =
 			USB_QUIRK_HONOR_BNUMINTERFACES },
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index 1a763ad4f721..2414291aa908 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4804,6 +4804,7 @@ static int _dwc2_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
 	struct dwc2_hsotg *hsotg = dwc2_hcd_to_hsotg(hcd);
 	int rc;
 	unsigned long flags;
+	int urb_status;
 
 	dev_dbg(hsotg->dev, "DWC OTG HCD URB Dequeue\n");
 	dwc2_dump_urb_info(hcd, urb, "urb_dequeue");
@@ -4828,11 +4829,12 @@ static int _dwc2_hcd_urb_dequeue(struct usb_hcd *hcd, struct urb *urb,
 
 	/* Higher layer software sets URB status */
 	spin_unlock(&hsotg->lock);
+	urb_status = urb->status;
 	usb_hcd_giveback_urb(hcd, urb, status);
 	spin_lock(&hsotg->lock);
 
 	dev_dbg(hsotg->dev, "Called usb_hcd_giveback_urb()\n");
-	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb->status);
+	dev_dbg(hsotg->dev, "  urb->status = %d\n", urb_status);
 out:
 	spin_unlock_irqrestore(&hsotg->lock, flags);
 
diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index f41b0da5e89d..9b9525592a85 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -184,15 +184,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	ret = phy_init(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
+	if (ret < 0)
 		goto err;
-	}
 
 	ret = reset_control_deassert(apbrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release APB reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	if (priv_data->usb3_phy) {
@@ -208,26 +206,24 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	ret = reset_control_deassert(crst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release core reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = reset_control_deassert(hibrst);
 	if (ret < 0) {
 		dev_err(dev, "Failed to release hibernation reset\n");
-		goto err;
+		goto err_phy_exit;
 	}
 
 	ret = phy_power_on(priv_data->usb3_phy);
-	if (ret < 0) {
-		phy_exit(priv_data->usb3_phy);
-		goto err;
-	}
+	if (ret < 0)
+		goto err_phy_exit;
 
 	/* ulpi reset via gpio-modepin or gpio-framework driver */
 	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(reset_gpio)) {
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
-				     "Failed to request reset GPIO\n");
+		ret = PTR_ERR(reset_gpio);
+		goto err_phy_power_off;
 	}
 
 	if (reset_gpio) {
@@ -237,6 +233,13 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx *priv_data)
 	}
 
 	dwc3_xlnx_set_coherency(priv_data, XLNX_USB_TRAFFIC_ROUTE_CONFIG);
+
+	return 0;
+
+err_phy_power_off:
+	phy_power_off(priv_data->usb3_phy);
+err_phy_exit:
+	phy_exit(priv_data->usb3_phy);
 err:
 	return ret;
 }
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index a902184bdf82..dc3664374596 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -2172,7 +2172,10 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 				sizeof(url_descriptor->URL)
 				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset);
 
-			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
+			if (w_length < WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH)
+				landing_page_length = landing_page_offset;
+			else if (w_length <
+				 WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_length)
 				landing_page_length = w_length
 				- WEBUSB_URL_DESCRIPTOR_HEADER_LENGTH + landing_page_offset;
 
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 002c3441bea3..75912ce6ab55 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -150,6 +150,8 @@ struct ffs_dma_fence {
 	struct dma_fence base;
 	struct ffs_dmabuf_priv *priv;
 	struct work_struct work;
+	struct usb_ep *ep;
+	struct usb_request *req;
 };
 
 struct ffs_epfile {
@@ -619,7 +621,7 @@ static ssize_t ffs_ep0_read(struct file *file, char __user *buf,
 
 		/* unlocks spinlock */
 		ret = __ffs_ep0_queue_wait(ffs, data, len);
-		if ((ret > 0) && (copy_to_user(buf, data, len)))
+		if ((ret > 0) && (copy_to_user(buf, data, ret)))
 			ret = -EFAULT;
 		goto done_mutex;
 
@@ -1385,6 +1387,21 @@ static void ffs_dmabuf_cleanup(struct work_struct *work)
 	struct ffs_dmabuf_priv *priv = dma_fence->priv;
 	struct dma_buf_attachment *attach = priv->attach;
 	struct dma_fence *fence = &dma_fence->base;
+	struct usb_request *req = dma_fence->req;
+	struct usb_ep *ep = dma_fence->ep;
+
+	/*
+	 * eps_lock pairs with the cancel paths so they cannot pass a freed
+	 * req to usb_ep_dequeue().  Only clear if priv->req still names ours;
+	 * a re-queue on the same attachment may have taken that slot.
+	 */
+	spin_lock_irq(&priv->ffs->eps_lock);
+	if (priv->req == req)
+		priv->req = NULL;
+	spin_unlock_irq(&priv->ffs->eps_lock);
+
+	if (ep && req)
+		usb_ep_free_request(ep, req);
 
 	ffs_dmabuf_put(attach);
 	dma_fence_put(fence);
@@ -1414,8 +1431,8 @@ static void ffs_epfile_dmabuf_io_complete(struct usb_ep *ep,
 					  struct usb_request *req)
 {
 	pr_vdebug("FFS: DMABUF transfer complete, status=%d\n", req->status);
+	/* req is freed by ffs_dmabuf_cleanup() under eps_lock. */
 	ffs_dmabuf_signal_done(req->context, req->status);
-	usb_ep_free_request(ep, req);
 }
 
 static const char *ffs_dmabuf_get_driver_name(struct dma_fence *fence)
@@ -1699,6 +1716,10 @@ static int ffs_dmabuf_transfer(struct file *file,
 	usb_req->context  = fence;
 	usb_req->complete = ffs_epfile_dmabuf_io_complete;
 
+	/* ffs_dmabuf_cleanup() frees usb_req via these two fields. */
+	fence->req = usb_req;
+	fence->ep = ep->ep;
+
 	cookie = dma_fence_begin_signalling();
 	ret = usb_ep_queue(ep->ep, usb_req, GFP_ATOMIC);
 	dma_fence_end_signalling(cookie);
@@ -1708,7 +1729,6 @@ static int ffs_dmabuf_transfer(struct file *file,
 	} else {
 		pr_warn("FFS: Failed to queue DMABUF: %d\n", ret);
 		ffs_dmabuf_signal_done(fence, ret);
-		usb_ep_free_request(ep->ep, usb_req);
 	}
 
 	spin_unlock_irq(&epfile->ffs->eps_lock);
diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index e0c3f39ee95e..3ca1c70d315a 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -1620,7 +1620,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	hidg->dev.devt = MKDEV(major, opts->minor);
 	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
 	if (ret)
-		goto err_unlock;
+		goto err_put_device;
 
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
@@ -1657,7 +1657,6 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 
 err_put_device:
 	put_device(&hidg->dev);
-err_unlock:
 	mutex_unlock(&opts->lock);
 	return ERR_PTR(ret);
 }
diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 8d404d88391c..73dc7e42875f 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -768,6 +768,16 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
 
+	/*
+	 * Hold opts->lock across both the XU string-descriptor fixup below and
+	 * the descriptor-copy block further down.  Without this, configfs
+	 * uvcg_extension_drop() (which takes opts->lock) can race with the
+	 * list_for_each_entry() walks here and inside uvc_copy_descriptors(),
+	 * leading to a UAF on a freed struct uvcg_extension.  See
+	 * drivers/usb/gadget/function/uvc_configfs.c::uvcg_extension_drop().
+	 */
+	mutex_lock(&opts->lock);
+
 	/*
 	 * XUs can have an arbitrary string descriptor describing them. If they
 	 * have one pick up the ID.
@@ -785,7 +795,7 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 				 ARRAY_SIZE(uvc_en_us_strings));
 	if (IS_ERR(us)) {
 		ret = PTR_ERR(us);
-		goto error;
+		goto error_unlock;
 	}
 
 	uvc_iad.iFunction = opts->iad_index ? cdev->usb_strings[opts->iad_index].id :
@@ -799,14 +809,14 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* Allocate interface IDs. */
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_iad.bFirstInterface = ret;
 	uvc_control_intf.bInterfaceNumber = ret;
 	uvc->control_intf = ret;
 	opts->control_interface = ret;
 
 	if ((ret = usb_interface_id(c, f)) < 0)
-		goto error;
+		goto error_unlock;
 	uvc_streaming_intf_alt0.bInterfaceNumber = ret;
 	uvc_streaming_intf_alt1.bInterfaceNumber = ret;
 	uvc->streaming_intf = ret;
@@ -817,30 +827,32 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 	if (IS_ERR(f->fs_descriptors)) {
 		ret = PTR_ERR(f->fs_descriptors);
 		f->fs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->hs_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_HIGH);
 	if (IS_ERR(f->hs_descriptors)) {
 		ret = PTR_ERR(f->hs_descriptors);
 		f->hs_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ss_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER);
 	if (IS_ERR(f->ss_descriptors)) {
 		ret = PTR_ERR(f->ss_descriptors);
 		f->ss_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
 	f->ssp_descriptors = uvc_copy_descriptors(uvc, USB_SPEED_SUPER_PLUS);
 	if (IS_ERR(f->ssp_descriptors)) {
 		ret = PTR_ERR(f->ssp_descriptors);
 		f->ssp_descriptors = NULL;
-		goto error;
+		goto error_unlock;
 	}
 
+	mutex_unlock(&opts->lock);
+
 	/* Preallocate control endpoint request. */
 	uvc->control_req = usb_ep_alloc_request(cdev->gadget->ep0, GFP_KERNEL);
 	uvc->control_buf = kmalloc(UVC_MAX_REQUEST_SIZE, GFP_KERNEL);
@@ -872,6 +884,8 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 
 	return 0;
 
+error_unlock:
+	mutex_unlock(&opts->lock);
 v4l2_error:
 	v4l2_device_unregister(&uvc->v4l2_dev);
 error:
diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f094491b1041..f47903461ed5 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -2134,6 +2134,8 @@ static int dummy_hub_control(
 	case ClearHubFeature:
 		break;
 	case ClearPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
 			if (hcd->speed == HCD_USB3) {
@@ -2248,6 +2250,8 @@ static int dummy_hub_control(
 		retval = -EPIPE;
 		break;
 	case SetPortFeature:
+		if (wIndex != 1)
+			goto error;
 		switch (wValue) {
 		case USB_PORT_FEAT_LINK_STATE:
 			if (hcd->speed != HCD_USB3) {
diff --git a/drivers/usb/gadget/udc/net2280.c b/drivers/usb/gadget/udc/net2280.c
index d02765bd49ce..7c5f30cfd24d 100644
--- a/drivers/usb/gadget/udc/net2280.c
+++ b/drivers/usb/gadget/udc/net2280.c
@@ -3790,10 +3790,8 @@ static int net2280_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	return 0;
 
 done:
-	if (dev) {
+	if (dev)
 		net2280_remove(pdev);
-		kfree(dev);
-	}
 	return retval;
 }
 
diff --git a/drivers/usb/host/xhci-tegra.c b/drivers/usb/host/xhci-tegra.c
index 3f6aa2440b05..ddc52d1e0eda 100644
--- a/drivers/usb/host/xhci-tegra.c
+++ b/drivers/usb/host/xhci-tegra.c
@@ -247,6 +247,7 @@ struct tegra_xusb_soc {
 	bool has_ipfs;
 	bool lpm_support;
 	bool otg_reset_sspi;
+	bool otg_set_port_power;
 
 	bool has_bar2;
 };
@@ -1352,14 +1353,17 @@ static void tegra_xhci_id_work(struct work_struct *work)
 	struct tegra_xusb_mbox_msg msg;
 	struct phy *phy = tegra_xusb_get_phy(tegra, "usb2",
 						    tegra->otg_usb2_port);
+	bool host_mode;
 	u32 status;
 	int ret;
 
-	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(tegra->host_mode));
-
 	mutex_lock(&tegra->lock);
 
-	if (tegra->host_mode)
+	host_mode = tegra->host_mode;
+
+	dev_dbg(tegra->dev, "host mode %s\n", str_on_off(host_mode));
+
+	if (host_mode)
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_HOST);
 	else
 		phy_set_mode_ext(phy, PHY_MODE_USB_OTG, USB_ROLE_NONE);
@@ -1370,41 +1374,43 @@ static void tegra_xhci_id_work(struct work_struct *work)
 								    tegra->otg_usb2_port);
 
 	pm_runtime_get_sync(tegra->dev);
-	if (tegra->host_mode) {
-		/* switch to host mode */
-		if (tegra->otg_usb3_port >= 0) {
-			if (tegra->soc->otg_reset_sspi) {
-				/* set PP=0 */
-				tegra_xhci_hc_driver.hub_control(
-					xhci->shared_hcd, GetPortStatus,
-					0, tegra->otg_usb3_port+1,
-					(char *) &status, sizeof(status));
-				if (status & USB_SS_PORT_STAT_POWER)
-					tegra_xhci_set_port_power(tegra, false,
-								  false);
-
-				/* reset OTG port SSPI */
-				msg.cmd = MBOX_CMD_RESET_SSPI;
-				msg.data = tegra->otg_usb3_port+1;
-
-				ret = tegra_xusb_mbox_send(tegra, &msg);
-				if (ret < 0) {
-					dev_info(tegra->dev,
-						"failed to RESET_SSPI %d\n",
-						ret);
+	if (tegra->soc->otg_set_port_power) {
+		if (host_mode) {
+			/* switch to host mode */
+			if (tegra->otg_usb3_port >= 0) {
+				if (tegra->soc->otg_reset_sspi) {
+					/* set PP=0 */
+					tegra_xhci_hc_driver.hub_control(
+						xhci->shared_hcd, GetPortStatus,
+						0, tegra->otg_usb3_port+1,
+						(char *) &status, sizeof(status));
+					if (status & USB_SS_PORT_STAT_POWER)
+						tegra_xhci_set_port_power(tegra, false,
+									  false);
+
+					/* reset OTG port SSPI */
+					msg.cmd = MBOX_CMD_RESET_SSPI;
+					msg.data = tegra->otg_usb3_port+1;
+
+					ret = tegra_xusb_mbox_send(tegra, &msg);
+					if (ret < 0) {
+						dev_info(tegra->dev,
+							"failed to RESET_SSPI %d\n",
+							ret);
+					}
 				}
-			}
 
-			tegra_xhci_set_port_power(tegra, false, true);
-		}
+				tegra_xhci_set_port_power(tegra, false, true);
+			}
 
-		tegra_xhci_set_port_power(tegra, true, true);
+			tegra_xhci_set_port_power(tegra, true, true);
 
-	} else {
-		if (tegra->otg_usb3_port >= 0)
-			tegra_xhci_set_port_power(tegra, false, false);
+		} else {
+			if (tegra->otg_usb3_port >= 0)
+				tegra_xhci_set_port_power(tegra, false, false);
 
-		tegra_xhci_set_port_power(tegra, true, false);
+			tegra_xhci_set_port_power(tegra, true, false);
+		}
 	}
 	pm_runtime_put_autosuspend(tegra->dev);
 }
@@ -2557,6 +2563,7 @@ static const struct tegra_xusb_soc tegra124_soc = {
 	.scale_ss_clock = true,
 	.has_ipfs = true,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2595,6 +2602,7 @@ static const struct tegra_xusb_soc tegra210_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = true,
 	.otg_reset_sspi = true,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2638,6 +2646,7 @@ static const struct tegra_xusb_soc tegra186_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = true,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0xe4,
@@ -2671,6 +2680,7 @@ static const struct tegra_xusb_soc tegra194_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra124_ops,
 	.mbox = {
 		.cmd = 0x68,
@@ -2704,6 +2714,7 @@ static const struct tegra_xusb_soc tegra234_soc = {
 	.scale_ss_clock = false,
 	.has_ipfs = false,
 	.otg_reset_sspi = false,
+	.otg_set_port_power = false,
 	.ops = &tegra234_ops,
 	.mbox = {
 		.cmd = XUSB_BAR2_ARU_MBOX_CMD,
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 48bb9bfb2204..333ab79f0ca9 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -337,7 +337,6 @@ static int omap2430_probe(struct platform_device *pdev)
 	} else {
 		device_set_of_node_from_dev(&musb->dev, &pdev->dev);
 	}
-	of_node_put(np);
 
 	glue->dev			= &pdev->dev;
 	glue->musb			= musb;
@@ -455,6 +454,7 @@ static int omap2430_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to register musb device\n");
 		goto err_disable_rpm;
 	}
+	of_node_put(np);
 
 	return 0;
 
@@ -464,6 +464,7 @@ static int omap2430_probe(struct platform_device *pdev)
 	if (!IS_ERR(glue->control_otghs))
 		put_device(glue->control_otghs);
 err_put_musb:
+	of_node_put(np);
 	platform_device_put(musb);
 
 	return ret;
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 38ac910b1082..7bbd9523d4e9 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -194,6 +194,9 @@ static void belkin_sa_read_int_callback(struct urb *urb)
 
 	usb_serial_debug_data(&port->dev, __func__, urb->actual_length, data);
 
+	if (urb->actual_length < BELKIN_SA_MSR_INDEX + 1)
+		goto exit;
+
 	/* Handle known interrupt data */
 	/* ignore data[0] and data[1] */
 
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index afff1a0f4298..bcf302e88ca4 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -445,6 +445,14 @@ static int cypress_generic_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * The buffer must be large enough for the one or two-byte header (and
+	 * following data), but assume anything smaller than eight bytes is
+	 * broken.
+	 */
+	if (port->interrupt_out_size < 8)
+		return -EINVAL;
+
 	priv = kzalloc_obj(struct cypress_private);
 	if (!priv)
 		return -ENOMEM;
@@ -1017,8 +1025,8 @@ static void cypress_read_int_callback(struct urb *urb)
 	char tty_flag = TTY_NORMAL;
 	int bytes = 0;
 	int result;
-	int i = 0;
 	int status = urb->status;
+	int i;
 
 	switch (status) {
 	case 0: /* success */
@@ -1056,22 +1064,32 @@ static void cypress_read_int_callback(struct urb *urb)
 
 	spin_lock_irqsave(&priv->lock, flags);
 	result = urb->actual_length;
+	i = 0;
 	switch (priv->pkt_fmt) {
 	default:
 	case packet_format_1:
 		/* This is for the CY7C64013... */
+		if (result < 2)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = data[1] + 2;
 		i = 2;
 		break;
 	case packet_format_2:
 		/* This is for the CY7C63743... */
+		if (result < 1)
+			break;
 		priv->current_status = data[0] & 0xF8;
 		bytes = (data[0] & 0x07) + 1;
 		i = 1;
 		break;
 	}
 	spin_unlock_irqrestore(&priv->lock, flags);
+	if (i == 0) {
+		dev_dbg(dev, "%s - short packet received: %d bytes\n",
+			__func__, result);
+		goto continue_read;
+	}
 	if (result < bytes) {
 		dev_dbg(dev,
 			"%s - wrong packet size - received %d bytes but packet said %d bytes\n",
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index d515df045c4c..c481208255eb 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -1229,15 +1229,34 @@ static int digi_port_init(struct usb_serial_port *port, unsigned port_num)
 static int digi_startup(struct usb_serial *serial)
 {
 	struct digi_serial *serial_priv;
+	int oob_port_num;
 	int ret;
+	int i;
+
+	/*
+	 * The port bulk-out buffers must be large enough for header and
+	 * buffered data.
+	 */
+	for (i = 0; i < serial->type->num_ports; i++) {
+		if (serial->port[i]->bulk_out_size < DIGI_OUT_BUF_SIZE + 2)
+			return -EINVAL;
+	}
+
+	/*
+	 * The OOB port bulk-out buffer must be large enough for the two
+	 * commands in digi_set_modem_signals().
+	 */
+	oob_port_num = serial->type->num_ports;
+	if (serial->port[oob_port_num]->bulk_out_size < 8)
+		return -EINVAL;
 
 	serial_priv = kzalloc_obj(*serial_priv);
 	if (!serial_priv)
 		return -ENOMEM;
 
 	spin_lock_init(&serial_priv->ds_serial_lock);
-	serial_priv->ds_oob_port_num = serial->type->num_ports;
-	serial_priv->ds_oob_port = serial->port[serial_priv->ds_oob_port_num];
+	serial_priv->ds_oob_port_num = oob_port_num;
+	serial_priv->ds_oob_port = serial->port[oob_port_num];
 
 	ret = digi_port_init(serial_priv->ds_oob_port,
 						serial_priv->ds_oob_port_num);
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 46448843541a..28b80607cebd 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1187,6 +1187,10 @@ static void usa49wg_indat_callback(struct urb *urb)
 	len = 0;
 
 	while (i < urb->actual_length) {
+		if (urb->actual_length - i < 3) {
+			dev_warn_ratelimited(&urb->dev->dev, "malformed indat packet\n");
+			break;
+		}
 
 		/* Check port number from message */
 		if (data[i] >= serial->num_ports) {
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 18844b92bd08..163161881d2d 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -378,6 +378,7 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 {
 	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv;
+	u16 pid;
 
 	/* check first to simplify error handling */
 	if (!serial->port[1] || !serial->port[1]->interrupt_in_urb) {
@@ -385,6 +386,16 @@ static int mct_u232_port_probe(struct usb_serial_port *port)
 		return -ENODEV;
 	}
 
+	/*
+	 * Compensate for a hardware bug: although the Sitecom U232-P25
+	 * device reports a maximum output packet size of 32 bytes,
+	 * it seems to be able to accept only 16 bytes (and that's what
+	 * SniffUSB says too...)
+	 */
+	pid = le16_to_cpu(serial->dev->descriptor.idProduct);
+	if (pid == MCT_U232_SITECOM_PID)
+		port->bulk_out_size = min(16, port->bulk_out_size);
+
 	priv = kzalloc_obj(*priv);
 	if (!priv)
 		return -ENOMEM;
@@ -410,7 +421,6 @@ static void mct_u232_port_remove(struct usb_serial_port *port)
 
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
-	struct usb_serial *serial = port->serial;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 	int retval = 0;
 	unsigned int control_state;
@@ -418,15 +428,6 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	unsigned char last_lcr;
 	unsigned char last_msr;
 
-	/* Compensate for a hardware bug: although the Sitecom U232-P25
-	 * device reports a maximum output packet size of 32 bytes,
-	 * it seems to be able to accept only 16 bytes (and that's what
-	 * SniffUSB says too...)
-	 */
-	if (le16_to_cpu(serial->dev->descriptor.idProduct)
-						== MCT_U232_SITECOM_PID)
-		port->bulk_out_size = 16;
-
 	/* Do a defined restart: the normal serial device seems to
 	 * always turn on DTR and RTS here, so do the same. I'm not
 	 * sure if this is really necessary. But it should not harm
@@ -543,6 +544,11 @@ static void mct_u232_read_int_callback(struct urb *urb)
 		goto exit;
 	}
 
+	if (urb->actual_length < 2) {
+		dev_warn_ratelimited(&port->dev, "short interrupt-in packet\n");
+		goto exit;
+	}
+
 	/*
 	 * The interrupt-in pipe signals exceptional conditions (modem line
 	 * signal changes and errors). data[0] holds MSR, data[1] holds LSR.
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index ad5fdf55a02e..c9b9928c473a 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -962,6 +962,14 @@ static int mxuport_calc_num_ports(struct usb_serial *serial,
 	 */
 	BUILD_BUG_ON(ARRAY_SIZE(epds->bulk_out) < 16);
 
+	/*
+	 * The bulk-out buffers must be large enough for the four-byte header
+	 * (and following data), but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	if (usb_endpoint_maxp(epds->bulk_out[0]) < 8)
+		return -EINVAL;
+
 	for (i = 1; i < num_ports; ++i)
 		epds->bulk_out[i] = epds->bulk_out[0];
 
diff --git a/drivers/usb/serial/omninet.c b/drivers/usb/serial/omninet.c
index aa1e9745f967..b59982ed8b25 100644
--- a/drivers/usb/serial/omninet.c
+++ b/drivers/usb/serial/omninet.c
@@ -30,6 +30,10 @@
 /* This one seems to be a re-branded ZyXEL device */
 #define BT_IGNITIONPRO_ID	0x2000
 
+#define OMNINET_HEADERLEN	4
+#define OMNINET_BULKOUTSIZE	64
+#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
+
 /* function prototypes */
 static void omninet_process_read_urb(struct urb *urb);
 static int omninet_prepare_write_buffer(struct usb_serial_port *port,
@@ -54,6 +58,7 @@ static struct usb_serial_driver zyxel_omninet_device = {
 	.description =		"ZyXEL - omni.net usb",
 	.id_table =		id_table,
 	.num_bulk_out =		2,
+	.bulk_out_size =	OMNINET_BULKOUTSIZE,
 	.calc_num_ports =	omninet_calc_num_ports,
 	.port_probe =		omninet_port_probe,
 	.port_remove =		omninet_port_remove,
@@ -130,10 +135,6 @@ static void omninet_port_remove(struct usb_serial_port *port)
 	kfree(od);
 }
 
-#define OMNINET_HEADERLEN	4
-#define OMNINET_BULKOUTSIZE	64
-#define OMNINET_PAYLOADSIZE	(OMNINET_BULKOUTSIZE - OMNINET_HEADERLEN)
-
 static void omninet_process_read_urb(struct urb *urb)
 {
 	struct usb_serial_port *port = urb->context;
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 42e4cecd28ac..48ae0188f2e9 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2450,6 +2450,12 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x30) },	/* MeiG Smart SRM825WN (Diag) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x40) },	/* MeiG Smart SRM825WN (AT) */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d38, 0xff, 0xff, 0x60) },	/* MeiG Smart SRM825WN (NMEA) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d63, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x30) },	/* MeiG SRM813Q (Diag) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x40) },	/* MeiG SRM813Q (AT) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2dee, 0x4d64, 0xff, 0xff, 0x60) },	/* MeiG SRM813Q (NMEA) */
+
 	{ USB_DEVICE_INTERFACE_CLASS(0x2df3, 0x9d03, 0xff) },			/* LongSung M5710 */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1404, 0xff) },			/* GosunCn GM500 RNDIS */
 	{ USB_DEVICE_INTERFACE_CLASS(0x305a, 0x1405, 0xff) },			/* GosunCn GM500 MBIM */
@@ -2470,7 +2476,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0302, 0xff) },			/* Rolling RW101R-GL (laptop MBIM) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x0802, 0xff),			/* Rolling RW350-GL (laptop MBIM) */
 	  .driver_info = RSVD(5) },
-	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff) },			/* Rolling RW135R-GL (laptop MBIM) */
+	{ USB_DEVICE_INTERFACE_CLASS(0x33f8, 0x1003, 0xff),			/* Rolling RW135R-GL (laptop MBIM) */
+	  .driver_info = RSVD(5) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x30) },	/* NetPrisma LCUK54-WWD for Global */
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0x00, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(0x3731, 0x0100, 0xff, 0xff, 0x40) },
diff --git a/drivers/usb/serial/safe_serial.c b/drivers/usb/serial/safe_serial.c
index 238b54993446..d267a31dcccf 100644
--- a/drivers/usb/serial/safe_serial.c
+++ b/drivers/usb/serial/safe_serial.c
@@ -259,6 +259,7 @@ static int safe_prepare_write_buffer(struct usb_serial_port *port,
 static int safe_startup(struct usb_serial *serial)
 {
 	struct usb_interface_descriptor	*desc;
+	int bulk_out_size;
 
 	if (serial->dev->descriptor.bDeviceClass != CDC_DEVICE_CLASS)
 		return -ENODEV;
@@ -279,6 +280,16 @@ static int safe_startup(struct usb_serial *serial)
 	default:
 		return -EINVAL;
 	}
+
+	/*
+	 * The bulk-out buffer needs to be large enough for the two-byte
+	 * trailer in safe mode, but assume anything smaller than eight bytes
+	 * is broken.
+	 */
+	bulk_out_size = serial->port[0]->bulk_out_size;
+	if (bulk_out_size > 0 && bulk_out_size < 8)
+		return -EINVAL;
+
 	return 0;
 }
 
diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index 939a98c2d3f7..d6f86d5db3bf 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -132,6 +132,13 @@ UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NO_REPORT_OPCODES),
 
+/* Reported-by: Sam Burkels <sam@1a38.nl> */
+UNUSUAL_DEV(0x154b, 0xf009, 0x0000, 0x9999,
+		"PNY",
+		"PNY ELITE PSSD",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_ATA_1X | US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
 UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
 		"PNY",
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/altmodes/displayport.c
index 35d9c3086990..263a89c5f324 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -405,6 +405,8 @@ static int dp_altmode_vdm(struct typec_altmode *alt,
 				dp->state = DP_STATE_EXIT_PRIME;
 			break;
 		case DP_CMD_STATUS_UPDATE:
+			if (count < 2)
+				break;
 			dp->data.status = *vdo;
 			ret = dp_altmode_status_update(dp);
 			break;
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim_core.c b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
index 19f638650796..cdf6489e1924 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim_core.c
+++ b/drivers/usb/typec/tcpm/tcpci_maxim_core.c
@@ -186,6 +186,15 @@ static void process_rx(struct max_tcpci_chip *chip, u16 status)
 	rx_buf_ptr = rx_buf + TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET;
 	msg.header = cpu_to_le16(*(u16 *)rx_buf_ptr);
 	rx_buf_ptr = rx_buf_ptr + sizeof(msg.header);
+
+	if (count < TCPC_RECEIVE_BUFFER_RX_BYTE_BUF_OFFSET + sizeof(msg.header) +
+		    pd_header_cnt_le(msg.header) * sizeof(msg.payload[0])) {
+		max_tcpci_write16(chip, TCPC_ALERT, TCPC_ALERT_RX_STATUS);
+		dev_err(chip->dev, "Invalid TCPC_RX_BYTE_CNT %d for header cnt %d\n",
+			count, pd_header_cnt_le(msg.header));
+		return;
+	}
+
 	for (payload_index = 0; payload_index < pd_header_cnt_le(msg.header); payload_index++,
 	     rx_buf_ptr += sizeof(msg.payload[0]))
 		msg.payload[payload_index] = cpu_to_le32(*(u32 *)rx_buf_ptr);
diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 7612a078bdd1..1e89909b1fcc 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -1708,6 +1708,9 @@ static void svdm_consume_identity(struct tcpm_port *port, const u32 *p, int cnt)
 	u32 vdo = p[VDO_INDEX_IDH];
 	u32 product = p[VDO_INDEX_PRODUCT];
 
+	if (cnt <= VDO_INDEX_PRODUCT)
+		return;
+
 	memset(&port->mode_data, 0, sizeof(port->mode_data));
 
 	port->partner_ident.id_header = vdo;
@@ -1728,6 +1731,9 @@ static void svdm_consume_identity_sop_prime(struct tcpm_port *port, const u32 *p
 	u32 product = p[VDO_INDEX_PRODUCT];
 	int svdm_version;
 
+	if (cnt <= VDO_INDEX_CABLE_1)
+		return;
+
 	/*
 	 * Attempt to consume identity only if cable currently is not set
 	 */
@@ -1751,7 +1757,7 @@ static void svdm_consume_identity_sop_prime(struct tcpm_port *port, const u32 *p
 	switch (port->negotiated_rev_prime) {
 	case PD_REV30:
 		port->cable_desc.pd_revision = 0x0300;
-		if (port->cable_desc.active)
+		if (port->cable_desc.active && cnt > VDO_INDEX_CABLE_2)
 			port->cable_ident.vdo[1] = p[VDO_INDEX_CABLE_2];
 		break;
 	case PD_REV20:
@@ -1839,23 +1845,19 @@ static void svdm_consume_modes(struct tcpm_port *port, const u32 *p, int cnt,
 	switch (rx_sop_type) {
 	case TCPC_TX_SOP_PRIME:
 		pmdata = &port->mode_data_prime;
-		if (pmdata->altmodes >= ARRAY_SIZE(port->plug_prime_altmode)) {
-			/* Already logged in svdm_consume_svids() */
-			return;
-		}
 		break;
 	case TCPC_TX_SOP:
 		pmdata = &port->mode_data;
-		if (pmdata->altmodes >= ARRAY_SIZE(port->partner_altmode)) {
-			/* Already logged in svdm_consume_svids() */
-			return;
-		}
 		break;
 	default:
 		return;
 	}
 
 	for (i = 1; i < cnt; i++) {
+		if (pmdata->altmodes >= ALTMODE_DISCOVERY_MAX) {
+			/* Already logged in svdm_consume_svids() */
+			return;
+		}
 		paltmode = &pmdata->altmode_desc[pmdata->altmodes];
 		memset(paltmode, 0, sizeof(*paltmode));
 
@@ -2000,6 +2002,55 @@ static bool tcpm_cable_vdm_supported(struct tcpm_port *port)
 	       tcpm_can_communicate_sop_prime(port);
 }
 
+static int tcpm_handle_discover_mode(struct tcpm_port *port, u32 *response,
+				     enum tcpm_transmit_type rx_sop_type,
+				     enum tcpm_transmit_type *response_tx_sop_type)
+{
+	struct typec_port *typec = port->typec_port;
+	struct pd_mode_data *modep;
+
+	if (rx_sop_type == TCPC_TX_SOP) {
+		modep = &port->mode_data;
+		modep->svid_index++;
+
+		if (modep->svid_index < modep->nsvids) {
+			u16 svid = modep->svids[modep->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP;
+			response[0] = VDO(svid, 1,
+					  typec_get_negotiated_svdm_version(typec),
+					  CMD_DISCOVER_MODES);
+			return 1;
+		}
+
+		if (tcpm_cable_vdm_supported(port)) {
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(USB_SID_PD, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_SVID);
+			return 1;
+		}
+
+		tcpm_register_partner_altmodes(port);
+	} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
+		modep = &port->mode_data_prime;
+		modep->svid_index++;
+
+		if (modep->svid_index < modep->nsvids) {
+			u16 svid = modep->svids[modep->svid_index];
+			*response_tx_sop_type = TCPC_TX_SOP_PRIME;
+			response[0] = VDO(svid, 1,
+					  typec_get_cable_svdm_version(typec),
+					  CMD_DISCOVER_MODES);
+			return 1;
+		}
+
+		tcpm_register_plug_altmodes(port);
+		tcpm_register_partner_altmodes(port);
+	}
+
+	return 0;
+}
+
 static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			const u32 *p, int cnt, u32 *response,
 			enum adev_actions *adev_action,
@@ -2257,41 +2308,11 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 			}
 			break;
 		case CMD_DISCOVER_MODES:
-			if (rx_sop_type == TCPC_TX_SOP) {
-				/* 6.4.4.3.3 */
-				svdm_consume_modes(port, p, cnt, rx_sop_type);
-				modep->svid_index++;
-				if (modep->svid_index < modep->nsvids) {
-					u16 svid = modep->svids[modep->svid_index];
-					*response_tx_sop_type = TCPC_TX_SOP;
-					response[0] = VDO(svid, 1, svdm_version,
-							  CMD_DISCOVER_MODES);
-					rlen = 1;
-				} else if (tcpm_cable_vdm_supported(port)) {
-					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
-					response[0] = VDO(USB_SID_PD, 1,
-							  typec_get_cable_svdm_version(typec),
-							  CMD_DISCOVER_SVID);
-					rlen = 1;
-				} else {
-					tcpm_register_partner_altmodes(port);
-				}
-			} else if (rx_sop_type == TCPC_TX_SOP_PRIME) {
-				/* 6.4.4.3.3 */
-				svdm_consume_modes(port, p, cnt, rx_sop_type);
-				modep_prime->svid_index++;
-				if (modep_prime->svid_index < modep_prime->nsvids) {
-					u16 svid = modep_prime->svids[modep_prime->svid_index];
-					*response_tx_sop_type = TCPC_TX_SOP_PRIME;
-					response[0] = VDO(svid, 1,
-							  typec_get_cable_svdm_version(typec),
-							  CMD_DISCOVER_MODES);
-					rlen = 1;
-				} else {
-					tcpm_register_plug_altmodes(port);
-					tcpm_register_partner_altmodes(port);
-				}
-			}
+			/* 6.4.4.3.3 */
+			svdm_consume_modes(port, p, cnt, rx_sop_type);
+			rlen = tcpm_handle_discover_mode(port, response,
+							 rx_sop_type,
+							 response_tx_sop_type);
 			break;
 		case CMD_ENTER_MODE:
 			*response_tx_sop_type = rx_sop_type;
@@ -2334,9 +2355,15 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
 		switch (cmd) {
 		case CMD_DISCOVER_IDENT:
 		case CMD_DISCOVER_SVID:
-		case CMD_DISCOVER_MODES:
 		case VDO_CMD_VENDOR(0) ... VDO_CMD_VENDOR(15):
 			break;
+		case CMD_DISCOVER_MODES:
+			tcpm_log(port, "Skip SVID 0x%04x (failed to discover mode)",
+				 PD_VDO_SVID_SVID0(p[0]));
+			rlen = tcpm_handle_discover_mode(port, response,
+							 rx_sop_type,
+							 response_tx_sop_type);
+			break;
 		case CMD_ENTER_MODE:
 			/* Back to USB Operation */
 			*adev_action = ADEV_NOTIFY_USB_AND_QUEUE_VDM;
diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 759c982bb16a..0e5a3e277c3e 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -444,9 +444,11 @@ static int wcove_start_toggling(struct tcpc_dev *tcpc,
 	return regmap_write(wcove->regmap, USBC_CONTROL1, usbc_ctrl);
 }
 
-static int wcove_read_rx_buffer(struct wcove_typec *wcove, void *msg)
+static int wcove_read_rx_buffer(struct wcove_typec *wcove,
+				struct pd_message *msg)
 {
-	unsigned int info;
+	unsigned int info, val, len;
+	u8 *buf = (u8 *)msg;
 	int ret;
 	int i;
 
@@ -454,12 +456,13 @@ static int wcove_read_rx_buffer(struct wcove_typec *wcove, void *msg)
 	if (ret)
 		return ret;
 
-	/* FIXME: Check that USBC_RXINFO_RXBYTES(info) matches the header */
+	len = min(USBC_RXINFO_RXBYTES(info), sizeof(*msg));
 
-	for (i = 0; i < USBC_RXINFO_RXBYTES(info); i++) {
-		ret = regmap_read(wcove->regmap, USBC_RX_DATA + i, msg + i);
+	for (i = 0; i < len; i++) {
+		ret = regmap_read(wcove->regmap, USBC_RX_DATA + i, &val);
 		if (ret)
 			return ret;
+		buf[i] = val;
 	}
 
 	return regmap_write(wcove->regmap, USBC_RXSTATUS,
diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 43faec794b95..d0b769333bd9 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1835,6 +1835,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_role_put;
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
+		ret = -EINVAL;
 		if (!tps6598x_read_power_status(tps))
 			goto err_unregister_port;
 		if (!tps->data->read_data_status(tps))
diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 8aae80b457d7..67a0991a7b76 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -240,6 +240,10 @@ static int ucsi_displayport_vdm(struct typec_altmode *alt,
 				dp->header |= VDO_CMDT(CMDT_RSP_ACK);
 			break;
 		case DP_CMD_CONFIGURE:
+			if (count < 2) {
+				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
+				break;
+			}
 			dp->data.conf = *data;
 			if (ucsi_displayport_configure(dp)) {
 				dp->header |= VDO_CMDT(CMDT_RSP_NAK);
diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 46262ee0d192..203dd8091b9d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1267,7 +1267,7 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 						  work);
 	struct ucsi *ucsi = con->ucsi;
 	u8 curr_scale, volt_scale;
-	enum typec_role role;
+	enum typec_role role, prev_role;
 	u16 change;
 	int ret;
 	u32 val;
@@ -1278,6 +1278,8 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 		dev_err_once(ucsi->dev, "%s entered without EVENT_PENDING\n",
 			     __func__);
 
+	prev_role = UCSI_CONSTAT(con, PWR_DIR);
+
 	ret = ucsi_get_connector_status(con, true);
 	if (ret) {
 		dev_err(ucsi->dev, "%s: GET_CONNECTOR_STATUS failed (%d)\n",
@@ -1294,9 +1296,14 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	change = UCSI_CONSTAT(con, CHANGE);
 	role = UCSI_CONSTAT(con, PWR_DIR);
 
-	if (change & UCSI_CONSTAT_POWER_DIR_CHANGE) {
+	if ((change & UCSI_CONSTAT_POWER_DIR_CHANGE) && role != prev_role) {
 		typec_set_pwr_role(con->port, role);
-		ucsi_port_psy_changed(con);
+
+		/* Some power_supply properties vary depending on the power direction when
+		 * connected
+		 */
+		if (UCSI_CONSTAT(con, CONNECTED))
+			ucsi_port_psy_changed(con);
 
 		/* Complete pending power role swap */
 		if (!completion_done(&con->complete))
@@ -1370,13 +1377,22 @@ static void ucsi_handle_connector_change(struct work_struct *work)
  */
 void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 {
-	struct ucsi_connector *con = &ucsi->connector[num - 1];
+	struct ucsi_connector *con;
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
 		dev_dbg(ucsi->dev, "Early connector change event\n");
 		return;
 	}
 
+	if (!num || num > ucsi->cap.num_connectors) {
+		dev_warn_ratelimited(ucsi->dev,
+				     "Bogus connector change on %u (max %u)\n",
+				     num, ucsi->cap.num_connectors);
+		return;
+	}
+
+	con = &ucsi->connector[num - 1];
+
 	if (!test_and_set_bit(EVENT_PENDING, &ucsi->flags))
 		schedule_work(&con->work);
 }
diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
index 199799b319c2..4463c1ae96bd 100644
--- a/drivers/usb/typec/ucsi/ucsi_ccg.c
+++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
@@ -1243,6 +1243,11 @@ static int do_flash(struct ucsi_ccg *uc, enum enum_flash_mode mode)
 	 *****************************************************************/
 
 	p = strnchr(fw->data, fw->size, ':');
+	if (!p) {
+		dev_err(dev, "Bad FW format: no ':' record header found\n");
+		err = -EINVAL;
+		goto release_mem;
+	}
 	while (p < eof) {
 		s = strnchr(p + 1, eof - p - 1, ':');
 
diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 90383107b660..c5f079c5a1ea 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -632,6 +632,7 @@ void vudc_remove(struct platform_device *pdev)
 {
 	struct vudc *udc = platform_get_drvdata(pdev);
 
+	v_stop_timer(udc);
 	usb_del_gadget_udc(&udc->gadget);
 	cleanup_vudc_hw(udc);
 	kfree(udc);
diff --git a/drivers/usb/usbip/vudc_transfer.c b/drivers/usb/usbip/vudc_transfer.c
index a4f02ea3e3ef..d4ce85c4c6a2 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -490,7 +490,8 @@ void v_stop_timer(struct vudc *udc)
 {
 	struct transfer_timer *t = &udc->tr_timer;
 
-	/* timer itself will take care of stopping */
+	/* Delete the timer synchronously before teardown frees udc. */
 	dev_dbg(&udc->pdev->dev, "timer stop");
+	timer_delete_sync(&t->timer);
 	t->state = VUDC_TR_STOPPED;
 }
diff --git a/fs/hpfs/alloc.c b/fs/hpfs/alloc.c
index 66617b1557c6..f5150372618e 100644
--- a/fs/hpfs/alloc.c
+++ b/fs/hpfs/alloc.c
@@ -372,8 +372,8 @@ int hpfs_check_free_dnodes(struct super_block *s, int n)
 				return 0;
 			}
 		}
+		hpfs_brelse4(&qbh);
 	}
-	hpfs_brelse4(&qbh);
 	i = 0;
 	if (hpfs_sb(s)->sb_c_bitmap != -1) {
 		bmp = hpfs_map_bitmap(s, b, &qbh, "chkdn1");
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 3f70c47981de..20dd073a3936 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -96,15 +96,8 @@ static const struct fs_parameter_spec hugetlb_fs_parameters[] = {
 #define PGOFF_LOFFT_MAX \
 	(((1UL << (PAGE_SHIFT + 1)) - 1) <<  (BITS_PER_LONG - (PAGE_SHIFT + 1)))
 
-static int hugetlb_file_mmap_prepare_success(const struct vm_area_struct *vma)
+static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
-	/* Unfortunate we have to reassign vma->vm_private_data. */
-	return hugetlb_vma_lock_alloc((struct vm_area_struct *)vma);
-}
-
-static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
-{
-	struct file *file = desc->file;
 	struct inode *inode = file_inode(file);
 	loff_t len, vma_len;
 	int ret;
@@ -119,8 +112,8 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * way when do_mmap unwinds (may be important on powerpc
 	 * and ia64).
 	 */
-	vma_desc_set_flags(desc, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
-	desc->vm_ops = &hugetlb_vm_ops;
+	vma_set_flags(vma, VMA_HUGETLB_BIT, VMA_DONTEXPAND_BIT);
+	vma->vm_ops = &hugetlb_vm_ops;
 
 	/*
 	 * page based offset in vm_pgoff could be sufficiently large to
@@ -129,16 +122,16 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 	 * sizeof(unsigned long).  So, only check in those instances.
 	 */
 	if (sizeof(unsigned long) == sizeof(loff_t)) {
-		if (desc->pgoff & PGOFF_LOFFT_MAX)
+		if (vma->vm_pgoff & PGOFF_LOFFT_MAX)
 			return -EINVAL;
 	}
 
 	/* must be huge page aligned */
-	if (desc->pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
+	if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
 		return -EINVAL;
 
-	vma_len = (loff_t)vma_desc_size(desc);
-	len = vma_len + ((loff_t)desc->pgoff << PAGE_SHIFT);
+	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
+	len = vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	/* check for overflow */
 	if (len < vma_len)
 		return -EINVAL;
@@ -148,7 +141,7 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 
 	ret = -ENOMEM;
 
-	vma_flags = desc->vma_flags;
+	vma_flags = vma->flags;
 	/*
 	 * for SHM_HUGETLB, the pages are reserved in the shmget() call so skip
 	 * reserving here. Note: only for SHM hugetlbfs file, the inode
@@ -158,30 +151,17 @@ static int hugetlbfs_file_mmap_prepare(struct vm_area_desc *desc)
 		vma_flags_set(&vma_flags, VMA_NORESERVE_BIT);
 
 	if (hugetlb_reserve_pages(inode,
-			desc->pgoff >> huge_page_order(h),
-			len >> huge_page_shift(h), desc,
-			vma_flags) < 0)
+				vma->vm_pgoff >> huge_page_order(h),
+				len >> huge_page_shift(h), vma,
+				vma_flags) < 0)
 		goto out;
 
 	ret = 0;
-	if (vma_desc_test_flags(desc, VMA_WRITE_BIT) && inode->i_size < len)
+	if (vma_flags_test(&vma->flags, VMA_WRITE_BIT) && inode->i_size < len)
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);
 
-	if (!ret) {
-		/* Allocate the VMA lock after we set it up. */
-		desc->action.success_hook = hugetlb_file_mmap_prepare_success;
-		/*
-		 * We cannot permit the rmap finding this VMA in the time
-		 * between the VMA being inserted into the VMA tree and the
-		 * completion/success hook being invoked.
-		 *
-		 * This is because we establish a per-VMA hugetlb lock which can
-		 * be raced by rmap.
-		 */
-		desc->action.hide_from_rmap_until_complete = true;
-	}
 	return ret;
 }
 
@@ -1238,7 +1218,7 @@ static void init_once(void *foo)
 
 static const struct file_operations hugetlbfs_file_operations = {
 	.read_iter		= hugetlbfs_read_iter,
-	.mmap_prepare		= hugetlbfs_file_mmap_prepare,
+	.mmap			= hugetlbfs_file_mmap,
 	.fsync			= noop_fsync,
 	.get_unmapped_area	= hugetlb_get_unmapped_area,
 	.llseek			= default_llseek,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 967047894a1e..253a96bc7bab 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4943,7 +4943,7 @@ smb2_writev_callback(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	unsigned int rreq_debug_id = wdata->rreq->debug_id;
 	unsigned int subreq_debug_index = wdata->subreq.debug_index;
 	ssize_t result = 0;
-	size_t written;
+	size_t written = 0;
 
 	WARN_ONCE(wdata->server != server,
 		  "wdata server %p != mid server %p",
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 3a8a739c025f..64ef1b8b37f8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -8202,9 +8202,20 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 	int ret = 0;
 	__le32 old_fattr;
 
+	if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
+		ksmbd_debug(SMB, "User does not have write permission\n");
+		return -EACCES;
+	}
+
 	fp = ksmbd_lookup_fd_fast(work, id);
 	if (!fp)
 		return -ENOENT;
+
+	if (!(fp->daccess & (FILE_WRITE_DATA_LE | FILE_WRITE_ATTRIBUTES_LE))) {
+		ret = -EACCES;
+		goto out;
+	}
+
 	idmap = file_mnt_idmap(fp->filp);
 
 	old_fattr = fp->f_ci->m_fattr;
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index c2d9be52a311..664b1b4a3233 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -1446,8 +1446,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 		ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 		aces_size = acl_size - sizeof(struct smb_acl);
 		for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-			if (offsetof(struct smb_ace, sid) +
-			    aces_size < CIFS_SID_BASE_SIZE)
+			if (aces_size < offsetof(struct smb_ace, sid) +
+			    CIFS_SID_BASE_SIZE)
 				break;
 			ace_size = le16_to_cpu(ace->size);
 			if (ace_size > aces_size ||
@@ -1467,8 +1467,8 @@ int smb_check_perm_dacl(struct ksmbd_conn *conn, const struct path *path,
 	ace = (struct smb_ace *)((char *)pdacl + sizeof(struct smb_acl));
 	aces_size = acl_size - sizeof(struct smb_acl);
 	for (i = 0; i < le16_to_cpu(pdacl->num_aces); i++) {
-		if (offsetof(struct smb_ace, sid) +
-		    aces_size < CIFS_SID_BASE_SIZE)
+		if (aces_size < offsetof(struct smb_ace, sid) +
+		    CIFS_SID_BASE_SIZE)
 			break;
 		ace_size = le16_to_cpu(ace->size);
 		if (ace_size > aces_size ||
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 49d1749f30bb..a4b562700151 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -725,6 +725,11 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
  */
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_update_all_gpes(void))
 
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
+				acpi_enable_gpe_cond(acpi_handle gpe_device,
+						     u32 gpe_number,
+						     u8 dispatch_type))
+
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 				acpi_enable_gpe(acpi_handle gpe_device,
 						u32 gpe_number))
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9cd1594ab697..ce0573e196ce 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -613,6 +613,7 @@ unsigned long kunit_vm_mmap(struct kunit *test, struct file *file,
 			    unsigned long offset);
 
 void kunit_cleanup(struct kunit *test);
+void kunit_free_boot_suites(void);
 
 void __printf(2, 3) kunit_log_append(struct string_stream *log, const char *fmt, ...);
 
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 56cebaff0c91..8da0a15c95f4 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -72,6 +72,10 @@
 	__diag_push();								\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",				\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(clang, 23, "-Wunknown-warning-option",			\
+		      "Avoid breaking versions without -Wattribute-alias");	\
+	__diag_ignore(clang, 23, "-Wattribute-alias",				\
+		      "Type aliasing is used to sanitize syscall arguments");	\
 	asmlinkage long compat_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_compat_sys##name))));	\
 	ALLOW_ERROR_INJECTION(compat_sys##name, ERRNO);				\
diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index e1123dd28486..527e4e136020 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -131,6 +131,12 @@
 #define __diag_str(s)		__diag_str1(s)
 #define __diag(s)		_Pragma(__diag_str(clang diagnostic s))
 
+#if CONFIG_CLANG_VERSION >= 230000
+#define __diag_clang_23(s)	__diag(s)
+#else
+#define __diag_clang_23(s)
+#endif
+
 #define __diag_clang_13(s)	__diag(s)
 
 #define __diag_ignore_all(option, comment) \
diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index c16d4199bf92..836a50f5917a 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -396,6 +396,17 @@
 # define __disable_sanitizer_instrumentation
 #endif
 
+/*
+ * Optional: not supported by clang
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Attributes.html#index-noipa
+ */
+#if __has_attribute(noipa)
+# define __noipa __attribute__((noipa))
+#else
+# define __noipa
+#endif
+
 /*
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-weak-function-attribute
  *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html#index-weak-variable-attribute
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 890076d0974b..5a55e81e53b1 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -718,6 +718,10 @@ struct ftrace_likely_data {
 #define __diag_GCC(version, severity, string)
 #endif
 
+#ifndef __diag_clang
+#define __diag_clang(version, severity, string)
+#endif
+
 #define __diag_push()	__diag(push)
 #define __diag_pop()	__diag(pop)
 
diff --git a/include/linux/dpll.h b/include/linux/dpll.h
index 8f97120ee7b3..a77d5741dd39 100644
--- a/include/linux/dpll.h
+++ b/include/linux/dpll.h
@@ -274,6 +274,7 @@ void dpll_pin_on_pin_unregister(struct dpll_pin *parent, struct dpll_pin *pin,
 int dpll_pin_ref_sync_pair_add(struct dpll_pin *pin,
 			       struct dpll_pin *ref_sync_pin);
 
+int __dpll_device_change_ntf(struct dpll_device *dpll);
 int dpll_device_change_ntf(struct dpll_device *dpll);
 
 int __dpll_pin_change_ntf(struct dpll_pin *pin);
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 101e05acf931..c9e0ebe9c752 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -1284,8 +1284,6 @@ void hid_quirks_exit(__u16 bus);
 	dev_notice(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_warn(hid, fmt, ...)				\
 	dev_warn(&(hid)->dev, fmt, ##__VA_ARGS__)
-#define hid_warn_ratelimited(hid, fmt, ...)				\
-	dev_warn_ratelimited(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_info(hid, fmt, ...)				\
 	dev_info(&(hid)->dev, fmt, ##__VA_ARGS__)
 #define hid_dbg(hid, fmt, ...)				\
diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 67d4f0924646..4308a1b58431 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -148,7 +148,7 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 			     struct folio **foliop);
 #endif /* CONFIG_USERFAULTFD */
 long hugetlb_reserve_pages(struct inode *inode, long from, long to,
-			   struct vm_area_desc *desc, vma_flags_t vma_flags);
+			   struct vm_area_struct *vma, vma_flags_t vma_flags);
 long hugetlb_unreserve_pages(struct inode *inode, long start, long end,
 						long freed);
 bool folio_isolate_hugetlb(struct folio *folio, struct list_head *list);
@@ -276,7 +276,6 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 void hugetlb_unshare_all_pmds(struct vm_area_struct *vma);
 void fixup_hugetlb_reservations(struct vm_area_struct *vma);
 void hugetlb_split(struct vm_area_struct *vma, unsigned long addr);
-int hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 
 unsigned int arch_hugetlb_cma_order(void);
 
@@ -469,11 +468,6 @@ static inline void fixup_hugetlb_reservations(struct vm_area_struct *vma)
 
 static inline void hugetlb_split(struct vm_area_struct *vma, unsigned long addr) {}
 
-static inline int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
-{
-	return 0;
-}
-
 #endif /* !CONFIG_HUGETLB_PAGE */
 
 #ifndef pgd_write
diff --git a/include/linux/hugetlb_inline.h b/include/linux/hugetlb_inline.h
index 755281fab23d..5c29cd3223a1 100644
--- a/include/linux/hugetlb_inline.h
+++ b/include/linux/hugetlb_inline.h
@@ -6,11 +6,6 @@
 
 #ifdef CONFIG_HUGETLB_PAGE
 
-static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
-{
-	return !!(vm_flags & VM_HUGETLB);
-}
-
 static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 {
 	return vma_flags_test(flags, VMA_HUGETLB_BIT);
@@ -18,11 +13,6 @@ static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 
 #else
 
-static inline bool is_vm_hugetlb_flags(vm_flags_t vm_flags)
-{
-	return false;
-}
-
 static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 {
 	return false;
@@ -32,7 +22,7 @@ static inline bool is_vma_hugetlb_flags(const vma_flags_t *flags)
 
 static inline bool is_vm_hugetlb_page(const struct vm_area_struct *vma)
 {
-	return is_vm_hugetlb_flags(vma->vm_flags);
+	return is_vma_hugetlb_flags(&vma->flags);
 }
 
 #endif
diff --git a/include/linux/intel_vsec.h b/include/linux/intel_vsec.h
index 1a0f357c2427..d551174b0049 100644
--- a/include/linux/intel_vsec.h
+++ b/include/linux/intel_vsec.h
@@ -200,13 +200,13 @@ static inline struct intel_vsec_device *auxdev_to_ivdev(struct auxiliary_device
 
 #if IS_ENABLED(CONFIG_INTEL_VSEC)
 int intel_vsec_register(struct pci_dev *pdev,
-			 struct intel_vsec_platform_info *info);
+			const struct intel_vsec_platform_info *info);
 int intel_vsec_set_mapping(struct oobmsm_plat_info *plat_info,
 			   struct intel_vsec_device *vsec_dev);
 struct oobmsm_plat_info *intel_vsec_get_mapping(struct pci_dev *pdev);
 #else
 static inline int intel_vsec_register(struct pci_dev *pdev,
-				       struct intel_vsec_platform_info *info)
+				      const struct intel_vsec_platform_info *info)
 {
 	return -ENODEV;
 }
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 80a427c7ca29..1db0069c27c5 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -11,6 +11,9 @@
 
 struct mbox_chan;
 
+/* Sentinel value distinguishing "no active request" from "NULL message data" */
+#define MBOX_NO_MSG	((void *)-1)
+
 /**
  * struct mbox_chan_ops - methods to control mailbox channels
  * @send_data:	The API asks the MBOX controller driver, in atomic
diff --git a/include/linux/parport.h b/include/linux/parport.h
index 464c2ad28039..f64cb0676e3b 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -240,6 +240,7 @@ struct parport {
 
 	unsigned long devflags;
 #define PARPORT_DEVPROC_REGISTERED	0
+#define PARPORT_ANNOUNCED		1
 	struct pardevice *proc_device;	/* Currently register proc device */
 
 	struct list_head full_list;
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 666430b47899..110ad4e2aef9 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1274,6 +1274,18 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
+/*
+ * Variant of guard(uart_port_lock_irqsave) for IRQ handlers that may capture
+ * a SysRq character via uart_prepare_sysrq_char(). The destructor uses the
+ * sysrq-aware unlock helper so that a captured port->sysrq_ch is dispatched
+ * to handle_sysrq() on scope exit. The plain guard variant silently drops
+ * sysrq_ch and must not be used by callers that process RX.
+ */
+DEFINE_LOCK_GUARD_1(uart_port_lock_check_sysrq_irqsave, struct uart_port,
+                    uart_port_lock_irqsave(_T->lock, &_T->flags),
+                    uart_unlock_and_check_sysrq_irqrestore(_T->lock, _T->flags),
+                    unsigned long flags);
+
 /*
  * We do the SysRQ and SAK checking like this...
  */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2f278ce376b7..a58ff8903e53 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -821,6 +821,7 @@ enum skb_tstamp_type {
  *	@_sk_redir: socket redirection information for skmsg
  *	@_nfct: Associated connection, if any (with nfctinfo bits)
  *	@skb_iif: ifindex of device we arrived on
+ *	@tc_depth: counter for packet duplication
  *	@tc_index: Traffic control index
  *	@hash: the packet hash
  *	@queue_mapping: Queue mapping for multiqueue devices
@@ -1030,6 +1031,7 @@ struct sk_buff {
 	__u8			csum_not_inet:1;
 #endif
 	__u8			unreadable:1;
+	__u8			tc_depth:2;
 #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
 	__u16			tc_index;	/* traffic control index */
 #endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 8787b3511c86..2606a18ebaae 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -247,6 +247,10 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	__diag_push();							\
 	__diag_ignore(GCC, 8, "-Wattribute-alias",			\
 		      "Type aliasing is used to sanitize syscall arguments");\
+	__diag_ignore(clang, 23, "-Wunknown-warning-option",		\
+		      "Avoid breaking versions without -Wattribute-alias");\
+	__diag_ignore(clang, 23, "-Wattribute-alias",			\
+		      "Type aliasing is used to sanitize syscall arguments");\
 	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
 		__attribute__((alias(__stringify(__se_sys##name))));	\
 	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 3ec41574af77..668b401f5147 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -187,6 +187,13 @@ static inline u64 nft_reg_load64(const u32 *sreg)
 	return get_unaligned((u64 *)sreg);
 }
 
+static inline bool nft_reg_overlap(u8 src, u8 dst, u32 len)
+{
+	unsigned int n = DIV_ROUND_UP(len, sizeof(u32));
+
+	return src != dst && src < dst + n && dst < src + n;
+}
+
 static inline void nft_data_copy(u32 *dst, const struct nft_data *src,
 				 unsigned int len)
 {
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 10d3edde6b2f..874409127e29 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -715,6 +715,7 @@ struct xfrm_mgr {
 					   const struct xfrm_migrate *m,
 					   int num_bundles,
 					   const struct xfrm_kmaddress *k,
+					   struct net *net,
 					   const struct xfrm_encap_tmpl *encap);
 	bool			(*is_alive)(const struct km_event *c);
 };
@@ -1891,7 +1892,7 @@ int xfrm_sk_policy_insert(struct sock *sk, int dir, struct xfrm_policy *pol);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_bundles,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap);
 struct xfrm_state *xfrm_migrate_state_find(struct xfrm_migrate *m, struct net *net,
 						u32 if_id);
diff --git a/ipc/util.c b/ipc/util.c
index 9eb89820594e..1737d776bc08 100644
--- a/ipc/util.c
+++ b/ipc/util.c
@@ -253,7 +253,7 @@ static inline int ipc_idr_alloc(struct ipc_ids *ids, struct kern_ipc_perm *new)
 	} else {
 		new->seq = ipcid_to_seqx(next_id);
 		idx = idr_alloc(&ids->ipcs_idr, new, ipcid_to_idx(next_id),
-				0, GFP_NOWAIT);
+				ipc_mni, GFP_NOWAIT);
 	}
 	if (idx >= 0)
 		new->id = (new->seq << ipcmni_seq_shift()) + idx;
diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 12f50de85b62..374e891743b1 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1212,7 +1212,7 @@ struct self_test {
 
 static __initconst const struct debug_obj_descr descr_type_test;
 
-static bool __init is_static_object(void *addr)
+static __noipa bool __init is_static_object(void *addr)
 {
 	struct self_test *obj = addr;
 
diff --git a/lib/kunit/executor.c b/lib/kunit/executor.c
index 1fef217de11d..b0f8a41d61d3 100644
--- a/lib/kunit/executor.c
+++ b/lib/kunit/executor.c
@@ -15,6 +15,16 @@ extern struct kunit_suite * const __kunit_suites_end[];
 extern struct kunit_suite * const __kunit_init_suites_start[];
 extern struct kunit_suite * const __kunit_init_suites_end[];
 
+static struct kunit_suite_set kunit_boot_suites;
+
+void kunit_free_boot_suites(void)
+{
+	if (kunit_boot_suites.start) {
+		kunit_free_suite_set(kunit_boot_suites);
+		kunit_boot_suites = (struct kunit_suite_set){ NULL, NULL };
+	}
+}
+
 static char *action_param;
 
 module_param_named(action, action_param, charp, 0400);
@@ -411,9 +421,12 @@ int kunit_run_all_tests(void)
 		pr_err("kunit executor: unknown action '%s'\n", action_param);
 
 free_out:
-	if (filter_glob_param || filter_param)
-		kunit_free_suite_set(suite_set);
-	else if (init_num_suites > 0)
+	if (filter_glob_param || filter_param) {
+		if (err)
+			kunit_free_suite_set(suite_set);
+		else
+			kunit_boot_suites = suite_set;
+	} else if (init_num_suites > 0)
 		/* Don't use kunit_free_suite_set because suites aren't individually allocated */
 		kfree(suite_set.start);
 
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 41e1c89799b6..99773e000e1b 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -1075,6 +1075,7 @@ static void __exit kunit_exit(void)
 	kunit_bus_shutdown();
 
 	kunit_debugfs_cleanup();
+	kunit_free_boot_suites();
 }
 module_exit(kunit_exit);
 
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 05da14101cdd..fb0246f95f98 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -88,7 +88,6 @@ static void damon_sysfs_scheme_region_release(struct kobject *kobj)
 	struct damon_sysfs_scheme_region *region = container_of(kobj,
 			struct damon_sysfs_scheme_region, kobj);
 
-	list_del(&region->list);
 	kfree(region);
 }
 
@@ -164,7 +163,7 @@ static void damon_sysfs_scheme_regions_rm_dirs(
 	struct damon_sysfs_scheme_region *r, *next;
 
 	list_for_each_entry_safe(r, next, &regions->regions_list, list) {
-		/* release function deletes it from the list */
+		list_del(&r->list);
 		kobject_put(&r->kobj);
 		regions->nr_regions--;
 	}
@@ -2870,14 +2869,15 @@ void damos_sysfs_populate_region_dir(struct damon_sysfs_schemes *sysfs_schemes,
 	if (!region)
 		return;
 	region->sz_filter_passed = sz_filter_passed;
-	list_add_tail(&region->list, &sysfs_regions->regions_list);
-	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
 				&damon_sysfs_scheme_region_ktype,
 				&sysfs_regions->kobj, "%d",
 				sysfs_regions->nr_regions++)) {
 		kobject_put(&region->kobj);
+		return;
 	}
+	list_add_tail(&region->list, &sysfs_regions->regions_list);
+	sysfs_regions->nr_regions++;
 }
 
 int damon_sysfs_schemes_clear_regions(
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9fda39132d26..0a9abb6794e5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -116,6 +116,7 @@ struct mutex *hugetlb_fault_mutex_table __ro_after_init;
 /* Forward declaration */
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
 static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 static void hugetlb_unshare_pmds(struct vm_area_struct *vma,
 		unsigned long start, unsigned long end, bool take_locks);
@@ -413,21 +414,17 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	}
 }
 
-/*
- * vma specific semaphore used for pmd sharing and fault/truncation
- * synchronization
- */
-int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
+static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 {
 	struct hugetlb_vma_lock *vma_lock;
 
 	/* Only establish in (flags) sharable vmas */
 	if (!vma || !(vma->vm_flags & VM_MAYSHARE))
-		return 0;
+		return;
 
 	/* Should never get here with non-NULL vm_private_data */
 	if (vma->vm_private_data)
-		return -EINVAL;
+		return;
 
 	vma_lock = kmalloc_obj(*vma_lock);
 	if (!vma_lock) {
@@ -442,15 +439,13 @@ int hugetlb_vma_lock_alloc(struct vm_area_struct *vma)
 		 * allocation failure.
 		 */
 		pr_warn_once("HugeTLB: unable to allocate vma specific lock\n");
-		return -EINVAL;
+		return;
 	}
 
 	kref_init(&vma_lock->refs);
 	init_rwsem(&vma_lock->rw_sema);
 	vma_lock->vma = vma;
 	vma->vm_private_data = vma_lock;
-
-	return 0;
 }
 
 /* Helper that removes a struct file_region from the resv_map cache and returns
@@ -1183,28 +1178,20 @@ static struct resv_map *vma_resv_map(struct vm_area_struct *vma)
 	}
 }
 
-static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
+static void set_vma_resv_map(struct vm_area_struct *vma, struct resv_map *map)
 {
 	VM_WARN_ON_ONCE_VMA(!is_vm_hugetlb_page(vma), vma);
-	VM_WARN_ON_ONCE_VMA(vma->vm_flags & VM_MAYSHARE, vma);
+	VM_WARN_ON_ONCE_VMA(vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT), vma);
 
-	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
+	set_vma_private_data(vma, (unsigned long)map);
 }
 
-static void set_vma_desc_resv_map(struct vm_area_desc *desc, struct resv_map *map)
-{
-	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
-
-	desc->private_data = map;
-}
-
-static void set_vma_desc_resv_flags(struct vm_area_desc *desc, unsigned long flags)
+static void set_vma_resv_flags(struct vm_area_struct *vma, unsigned long flags)
 {
-	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-	VM_WARN_ON_ONCE(vma_desc_test_flags(desc, VMA_MAYSHARE_BIT));
+	VM_WARN_ON_ONCE_VMA(!is_vm_hugetlb_page(vma), vma);
+	VM_WARN_ON_ONCE_VMA(vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT), vma);
 
-	desc->private_data = (void *)((unsigned long)desc->private_data | flags);
+	set_vma_private_data(vma, get_vma_private_data(vma) | flags);
 }
 
 static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
@@ -1214,13 +1201,6 @@ static int is_vma_resv_set(struct vm_area_struct *vma, unsigned long flag)
 	return (get_vma_private_data(vma) & flag) != 0;
 }
 
-static bool is_vma_desc_resv_set(struct vm_area_desc *desc, unsigned long flag)
-{
-	VM_WARN_ON_ONCE(!is_vma_hugetlb_flags(&desc->vma_flags));
-
-	return ((unsigned long)desc->private_data) & flag;
-}
-
 bool __vma_private_lock(struct vm_area_struct *vma)
 {
 	return !(vma->vm_flags & VM_MAYSHARE) &&
@@ -6572,7 +6552,7 @@ long hugetlb_change_protection(struct vm_area_struct *vma,
 
 long hugetlb_reserve_pages(struct inode *inode,
 		long from, long to,
-		struct vm_area_desc *desc,
+		struct vm_area_struct *vma,
 		vma_flags_t vma_flags)
 {
 	long chg = -1, add = -1, spool_resv, gbl_resv;
@@ -6589,6 +6569,12 @@ long hugetlb_reserve_pages(struct inode *inode,
 		return -EINVAL;
 	}
 
+	/*
+	 * vma specific semaphore used for pmd sharing and fault/truncation
+	 * synchronization
+	 */
+	hugetlb_vma_lock_alloc(vma);
+
 	/*
 	 * Only apply hugepage reservation if asked. At fault time, an
 	 * attempt will be made for VM_NORESERVE to allocate a page
@@ -6601,9 +6587,9 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * Shared mappings base their reservation on the number of pages that
 	 * are already allocated on behalf of the file. Private mappings need
 	 * to reserve the full area even if read-only as mprotect() may be
-	 * called to make the mapping read-write. Assume !desc is a shm mapping
+	 * called to make the mapping read-write. Assume !vma is a shm mapping
 	 */
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
+	if (!vma || vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT)) {
 		/*
 		 * resv_map can not be NULL as hugetlb_reserve_pages is only
 		 * called for inodes for which resv_maps were created (see
@@ -6622,8 +6608,8 @@ long hugetlb_reserve_pages(struct inode *inode,
 
 		chg = to - from;
 
-		set_vma_desc_resv_map(desc, resv_map);
-		set_vma_desc_resv_flags(desc, HPAGE_RESV_OWNER);
+		set_vma_resv_map(vma, resv_map);
+		set_vma_resv_flags(vma, HPAGE_RESV_OWNER);
 	}
 
 	if (chg < 0) {
@@ -6637,7 +6623,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	if (err < 0)
 		goto out_err;
 
-	if (desc && !vma_desc_test_flags(desc, VMA_MAYSHARE_BIT) && h_cg) {
+	if (vma && !vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT) && h_cg) {
 		/* For private mappings, the hugetlb_cgroup uncharge info hangs
 		 * of the resv_map.
 		 */
@@ -6674,7 +6660,7 @@ long hugetlb_reserve_pages(struct inode *inode,
 	 * consumed reservations are stored in the map. Hence, nothing
 	 * else has to be done for private mappings here
 	 */
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT)) {
+	if (!vma || vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT)) {
 		add = region_add(resv_map, from, to, regions_needed, h, h_cg);
 
 		if (unlikely(add < 0)) {
@@ -6738,15 +6724,16 @@ long hugetlb_reserve_pages(struct inode *inode,
 	hugetlb_cgroup_uncharge_cgroup_rsvd(hstate_index(h),
 					    chg * pages_per_huge_page(h), h_cg);
 out_err:
-	if (!desc || vma_desc_test_flags(desc, VMA_MAYSHARE_BIT))
+	hugetlb_vma_lock_free(vma);
+	if (!vma || vma_flags_test(&vma->flags, VMA_MAYSHARE_BIT))
 		/* Only call region_abort if the region_chg succeeded but the
 		 * region_add failed or didn't run.
 		 */
 		if (chg >= 0 && add < 0)
 			region_abort(resv_map, from, to, regions_needed);
-	if (desc && is_vma_desc_resv_set(desc, HPAGE_RESV_OWNER)) {
+	if (vma && is_vma_resv_set(vma, HPAGE_RESV_OWNER)) {
 		kref_put(&resv_map->refs, resv_map_release);
-		set_vma_desc_resv_map(desc, NULL);
+		set_vma_resv_map(vma, NULL);
 	}
 	return err;
 }
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 96786a4af753..382c387c775a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4085,6 +4085,9 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			lstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			memcg->vmstats->state[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 		if (atomic_read(&pn->slab_unreclaimable)) {
 			int slab = atomic_xchg(&pn->slab_unreclaimable, 0);
@@ -4093,6 +4096,9 @@ static void flush_nmi_stats(struct mem_cgroup *memcg, struct mem_cgroup *parent,
 			lstats->state[index] += slab;
 			if (plstats)
 				plstats->state_pending[index] += slab;
+			memcg->vmstats->state[index] += slab;
+			if (parent)
+				parent->vmstats->state_pending[index] += slab;
 		}
 	}
 }
diff --git a/mm/memfd.c b/mm/memfd.c
index 919c2a53eb96..c9cac8f53a56 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -283,6 +283,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		goto unlock;
 	}
 
+	/*
+	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	if ((seals & F_SEAL_WRITE) && !(*file_seals & F_SEAL_WRITE)) {
 		error = mapping_deny_writable(file->f_mapping);
 		if (error)
@@ -295,12 +301,6 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
-	/*
-	 * SEAL_EXEC implies SEAL_WRITE, making W^X from the start.
-	 */
-	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
-		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
-
 	*file_seals |= seals;
 	error = 0;
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index a83bac73e3bc..4795787bad2e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -846,7 +846,7 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 	} else {
 		if (folio_is_zone_device(folio) &&
 		    !folio_is_device_coherent(folio)) {
-			goto abort;
+			goto free_abort;
 		}
 		entry = folio_mk_pmd(folio, vma->vm_page_prot);
 		if (vma->vm_flags & VM_WRITE)
@@ -899,6 +899,8 @@ static int migrate_vma_insert_huge_pmd_page(struct migrate_vma *migrate,
 
 unlock_abort:
 	spin_unlock(ptl);
+free_abort:
+	pte_free(vma->vm_mm, pgtable);
 abort:
 	for (i = 0; i < HPAGE_PMD_NR; i++)
 		src[i] &= ~MIGRATE_PFN_MIGRATE;
diff --git a/mm/rmap.c b/mm/rmap.c
index 8f08090d7eb9..cf243d503046 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2024,6 +2024,8 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 	mmu_notifier_invalidate_range_start(&range);
 
 	while (page_vma_mapped_walk(&pvmw)) {
+		nr_pages = 1;
+
 		/*
 		 * If the folio is in an mlock()d vma, we must not swap it out.
 		 */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 2c2f74a07f39..5b5e9caa3fd2 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3209,7 +3209,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 	struct vm_struct *area;
 	unsigned long requested_size = size;
 
-	BUG_ON(in_interrupt());
+	BUG_ON(in_nmi() || in_hardirq());
 	size = ALIGN(size, 1ul << shift);
 	if (unlikely(!size))
 		return NULL;
diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
index 2f03b780b40d..960a19b3e26d 100644
--- a/net/bluetooth/6lowpan.c
+++ b/net/bluetooth/6lowpan.c
@@ -486,6 +486,8 @@ static int send_mcast_pkt(struct sk_buff *skb, struct net_device *netdev)
 			int ret;
 
 			local_skb = skb_clone(skb, GFP_ATOMIC);
+			if (!local_skb)
+				continue;
 
 			BT_DBG("xmit %s to %pMR type %u IP %pI6c chan %p",
 			       netdev->name,
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9fa6901aae9f..36e80fbfe358 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -803,8 +803,10 @@ static int hci_le_big_terminate(struct hci_dev *hdev, struct hci_conn *conn)
 			d->big_sync_term = true;
 	}
 
-	if (!d->pa_sync_term && !d->big_sync_term)
+	if (!d->pa_sync_term && !d->big_sync_term) {
+		kfree(d);
 		return 0;
+	}
 
 	ret = hci_cmd_sync_queue(hdev, big_terminate_sync, d,
 				 terminate_big_destroy);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 426f465be355..8a92fec9d9e3 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5301,6 +5301,12 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	bt_dev_dbg(hdev, "");
 
+	/* Set HCI_DRAIN_WORKQUEUE flag to prevent queuing work during
+	 * reset/close. See hci_cmd_work() and handle_cmd_cnt_and_timer().
+	 */
+	hci_dev_set_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
+	synchronize_rcu();
+
 	if (hci_dev_test_flag(hdev, HCI_UNREGISTER)) {
 		disable_delayed_work(&hdev->power_off);
 		disable_delayed_work(&hdev->ncmd_timer);
@@ -5324,6 +5330,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 
 	if (!test_and_clear_bit(HCI_UP, &hdev->flags)) {
 		cancel_delayed_work_sync(&hdev->cmd_timer);
+		hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 		return err;
 	}
 
@@ -5386,6 +5393,10 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Reset device */
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
+	hdev->acl_cnt = 0;
+	hdev->sco_cnt = 0;
+	hdev->le_cnt = 0;
+	hdev->iso_cnt = 0;
 	if (hci_test_quirk(hdev, HCI_QUIRK_RESET_ON_CLOSE) &&
 	    !auto_off && !hci_dev_test_flag(hdev, HCI_UNCONFIGURED)) {
 		set_bit(HCI_INIT, &hdev->flags);
@@ -5423,6 +5434,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
 	/* Clear flags */
 	hdev->flags &= BIT(HCI_RAW);
 	hci_dev_clear_volatile_flags(hdev);
+	hci_dev_clear_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE);
 
 	memset(hdev->eir, 0, sizeof(hdev->eir));
 	memset(hdev->dev_class, 0, sizeof(hdev->dev_class));
@@ -6699,6 +6711,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	DEFINE_FLEX(struct hci_cp_le_create_cis, cmd, cis, num_cis, 0x1f);
 	size_t aux_num_cis = 0;
 	struct hci_conn *conn;
+	u16 timeout = 0;
 	u8 cig = BT_ISO_QOS_CIG_UNSET;
 
 	/* The spec allows only one pending LE Create CIS command at a time. If
@@ -6769,6 +6782,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 		set_bit(HCI_CONN_CREATE_CIS, &conn->flags);
 		cis->acl_handle = cpu_to_le16(conn->parent->handle);
 		cis->cis_handle = cpu_to_le16(conn->handle);
+		timeout = conn->conn_timeout;
 		aux_num_cis++;
 
 		if (aux_num_cis >= cmd->num_cis)
@@ -6788,7 +6802,7 @@ int hci_le_create_cis_sync(struct hci_dev *hdev)
 	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_CREATE_CIS,
 					struct_size(cmd, cis, cmd->num_cis),
 					cmd, HCI_EVT_LE_CIS_ESTABLISHED,
-					conn->conn_timeout, NULL);
+					timeout, NULL);
 }
 
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle)
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 7bcf8c5ceaee..117b6b9dcd98 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -179,12 +179,21 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 {
 	struct input_dev *dev = session->input;
 	unsigned char *keys = session->keys;
-	unsigned char *udata = skb->data + 1;
-	signed char *sdata = skb->data + 1;
-	int i, size = skb->len - 1;
+	unsigned char *udata;
+	signed char *sdata;
+	u8 *hdr;
+	int i;
+
+	hdr = skb_pull_data(skb, 1);
+	if (!hdr)
+		return;
 
-	switch (skb->data[0]) {
+	switch (*hdr) {
 	case 0x01:	/* Keyboard report */
+		udata = skb_pull_data(skb, 8);
+		if (!udata)
+			break;
+
 		for (i = 0; i < 8; i++)
 			input_report_key(dev, hidp_keycode[i + 224], (udata[0] >> i) & 1);
 
@@ -213,6 +222,10 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		break;
 
 	case 0x02:	/* Mouse report */
+		sdata = skb_pull_data(skb, 3);
+		if (!sdata)
+			break;
+
 		input_report_key(dev, BTN_LEFT,   sdata[0] & 0x01);
 		input_report_key(dev, BTN_RIGHT,  sdata[0] & 0x02);
 		input_report_key(dev, BTN_MIDDLE, sdata[0] & 0x04);
@@ -222,7 +235,7 @@ static void hidp_input_report(struct hidp_session *session, struct sk_buff *skb)
 		input_report_rel(dev, REL_X, sdata[1]);
 		input_report_rel(dev, REL_Y, sdata[2]);
 
-		if (size > 3)
+		if (skb->len > 0)
 			input_report_rel(dev, REL_WHEEL, sdata[3]);
 		break;
 	}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index c72830744d56..a6bd608cbda6 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -572,7 +572,7 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	struct sock *sk;
 
 	iso_conn_lock(conn);
-	sk = conn->sk;
+	sk = iso_sock_hold(conn);
 	iso_conn_unlock(conn);
 
 	if (!sk)
@@ -581,11 +581,15 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
-		goto drop;
+		goto drop_put;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sock_queue_rcv_skb(sk, skb)) {
+		sock_put(sk);
 		return;
+	}
 
+drop_put:
+	sock_put(sk);
 drop:
 	kfree_skb(skb);
 }
@@ -868,8 +872,8 @@ static void __iso_sock_close(struct sock *sk)
 /* Must be called on unlocked socket. */
 static void iso_sock_close(struct sock *sk)
 {
-	iso_sock_clear_timer(sk);
 	lock_sock(sk);
+	iso_sock_clear_timer(sk);
 	__iso_sock_close(sk);
 	release_sock(sk);
 	iso_sock_kill(sk);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 99297d8f2c1f..9975a9126b84 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -411,8 +411,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
 
-	if (!conn)
+	if (!conn) {
+		l2cap_chan_put(chan);
 		return;
+	}
 
 	mutex_lock(&conn->lock);
 	/* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
@@ -5268,6 +5270,7 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 	cmd_len -= sizeof(*rsp);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
+		struct l2cap_chan *orig;
 		u16 dcid;
 
 		if (chan->ident != cmd->ident ||
@@ -5289,8 +5292,10 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 
 		BT_DBG("dcid[%d] 0x%4.4x", i, dcid);
 
+		orig = __l2cap_get_chan_by_dcid(conn, dcid);
+
 		/* Check if dcid is already in use */
-		if (dcid && __l2cap_get_chan_by_dcid(conn, dcid)) {
+		if (dcid && orig) {
 			/* If a device receives a
 			 * L2CAP_CREDIT_BASED_CONNECTION_RSP packet with an
 			 * already-assigned Destination CID, then both the
@@ -5299,10 +5304,24 @@ static inline int l2cap_ecred_conn_rsp(struct l2cap_conn *conn,
 			 */
 			l2cap_chan_del(chan, ECONNREFUSED);
 			l2cap_chan_unlock(chan);
-			chan = __l2cap_get_chan_by_dcid(conn, dcid);
-			l2cap_chan_lock(chan);
-			l2cap_chan_del(chan, ECONNRESET);
-			l2cap_chan_unlock(chan);
+
+			/* Check that the dcid channel mode is
+			 * L2CAP_MODE_EXT_FLOWCTL since this procedure is only
+			 * valid for that mode and shouldn't disconnect a dcid
+			 * in other modes.
+			 */
+			if (orig->mode == L2CAP_MODE_EXT_FLOWCTL) {
+				l2cap_chan_lock(orig);
+				/* Disconnect the original channel as it may be
+				 * considered connected since dcid has already
+				 * been assigned; don't call l2cap_chan_close
+				 * directly since that could lead to
+				 * l2cap_chan_del and then removing the channel
+				 * from the list while we're iterating over it.
+				 */
+				__set_chan_timer(orig, 0);
+				l2cap_chan_unlock(orig);
+			}
 			continue;
 		}
 
@@ -5466,14 +5485,20 @@ static inline int l2cap_ecred_reconf_rsp(struct l2cap_conn *conn,
 
 	BT_DBG("result 0x%4.4x", result);
 
-	if (!result)
+	if (!result) {
+		list_for_each_entry(chan, &conn->chan_l, list) {
+			if (chan->ident == cmd->ident)
+				chan->ident = 0;
+		}
 		return 0;
+	}
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		if (chan->ident != cmd->ident)
 			continue;
 
-		l2cap_chan_hold(chan);
+		if (!l2cap_chan_hold_unless_zero(chan))
+			continue;
 		l2cap_chan_lock(chan);
 
 		l2cap_chan_del(chan, ECONNRESET);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b34e7da8d906..c138aa4ae266 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1499,6 +1499,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	 * pin it (hold_unless_zero() additionally skips a chan already past
 	 * its last reference).  We then drop the sk lock before taking
 	 * chan->lock, so sk and chan locks are never held together.
+	 *
+	 * Since we cannot call l2cap_chan_close() without conn->lock,
+	 * schedule l2cap_chan_timeout to close the channel; it already
+	 * acquires conn->lock -> chan->lock in the correct order.
 	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan;
@@ -1516,14 +1520,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 		       state_to_string(chan->state));
 
 		l2cap_chan_lock(chan);
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		/* l2cap_conn_del() may already have killed this socket
-		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
-		 * double sock_put()/l2cap_chan_put().
+		/* Since we cannot call l2cap_chan_close() without
+		 * conn->lock, schedule its timer to trigger the close
+		 * and cleanup of this channel.
 		 */
-		if (!sock_flag(sk, SOCK_DEAD))
-			l2cap_sock_kill(sk);
+		if (chan->conn)
+			__set_chan_timer(chan, 0);
 		l2cap_chan_unlock(chan);
 
 		l2cap_chan_put(chan);
diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index 0264730938f4..2ad502bfbd55 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1000,19 +1000,25 @@ static int br_setport(struct net_bridge_port *p, struct nlattr *tb[],
 	br_port_flags_change(p, changed_mask);
 
 	if (tb[IFLA_BRPORT_COST]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_stp_set_path_cost(p, nla_get_u32(tb[IFLA_BRPORT_COST]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
 
 	if (tb[IFLA_BRPORT_PRIORITY]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_stp_set_port_priority(p, nla_get_u16(tb[IFLA_BRPORT_PRIORITY]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
 
 	if (tb[IFLA_BRPORT_STATE]) {
+		spin_lock_bh(&p->br->lock);
 		err = br_set_port_state(p, nla_get_u8(tb[IFLA_BRPORT_STATE]));
+		spin_unlock_bh(&p->br->lock);
 		if (err)
 			return err;
 	}
@@ -1114,9 +1120,7 @@ int br_setlink(struct net_device *dev, struct nlmsghdr *nlh, u16 flags,
 			if (err)
 				return err;
 
-			spin_lock_bh(&p->br->lock);
 			err = br_setport(p, tb, extack);
-			spin_unlock_bh(&p->br->lock);
 		} else {
 			/* Binary compatibility with old RSTP */
 			if (nla_len(protinfo) < sizeof(u8))
@@ -1203,17 +1207,10 @@ static int br_port_slave_changelink(struct net_device *brdev,
 				    struct nlattr *data[],
 				    struct netlink_ext_ack *extack)
 {
-	struct net_bridge *br = netdev_priv(brdev);
-	int ret;
-
 	if (!data)
 		return 0;
 
-	spin_lock_bh(&br->lock);
-	ret = br_setport(br_port_get_rtnl(dev), data, extack);
-	spin_unlock_bh(&br->lock);
-
-	return ret;
+	return br_setport(br_port_get_rtnl(dev), data, extack);
 }
 
 static int br_port_fill_slave_info(struct sk_buff *skb,
diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index 4fac002922d2..58257e9e9d30 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -99,7 +99,6 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.u.brport_flags.val = flags;
 	attr.u.brport_flags.mask = mask;
 
-	/* We run from atomic context here */
 	err = call_switchdev_notifiers(SWITCHDEV_PORT_ATTR_SET, p->dev,
 				       &info.info, extack);
 	err = notifier_to_errno(err);
diff --git a/net/bridge/br_sysfs_if.c b/net/bridge/br_sysfs_if.c
index 1f57c36a7fc0..d6df81fa0d13 100644
--- a/net/bridge/br_sysfs_if.c
+++ b/net/bridge/br_sysfs_if.c
@@ -86,16 +86,34 @@ static ssize_t show_path_cost(struct net_bridge_port *p, char *buf)
 	return sysfs_emit(buf, "%d\n", p->path_cost);
 }
 
-static BRPORT_ATTR(path_cost, 0644,
-		   show_path_cost, br_stp_set_path_cost);
+static int store_path_cost(struct net_bridge_port *p, unsigned long v)
+{
+	int ret;
+
+	spin_lock_bh(&p->br->lock);
+	ret = br_stp_set_path_cost(p, v);
+	spin_unlock_bh(&p->br->lock);
+	return ret;
+}
+
+static BRPORT_ATTR(path_cost, 0644, show_path_cost, store_path_cost);
 
 static ssize_t show_priority(struct net_bridge_port *p, char *buf)
 {
 	return sysfs_emit(buf, "%d\n", p->priority);
 }
 
-static BRPORT_ATTR(priority, 0644,
-			 show_priority, br_stp_set_port_priority);
+static int store_priority(struct net_bridge_port *p, unsigned long v)
+{
+	int ret;
+
+	spin_lock_bh(&p->br->lock);
+	ret = br_stp_set_port_priority(p, v);
+	spin_unlock_bh(&p->br->lock);
+	return ret;
+}
+
+static BRPORT_ATTR(priority, 0644, show_priority, store_priority);
 
 static ssize_t show_designated_root(struct net_bridge_port *p, char *buf)
 {
@@ -334,17 +352,13 @@ static ssize_t brport_store(struct kobject *kobj,
 			ret = -ENOMEM;
 			goto out_unlock;
 		}
-		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store_raw(p, buf_copy);
-		spin_unlock_bh(&p->br->lock);
 		kfree(buf_copy);
 	} else if (brport_attr->store) {
 		val = simple_strtoul(buf, &endp, 0);
 		if (endp == buf)
 			goto out_unlock;
-		spin_lock_bh(&p->br->lock);
 		ret = brport_attr->store(p, val);
-		spin_unlock_bh(&p->br->lock);
 	}
 
 	if (!ret) {
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index b9f4daac09af..8a6a069329d2 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1956,6 +1956,25 @@ enum compat_mwt {
 	EBT_COMPAT_TARGET,
 };
 
+static bool match_size_ok(const struct xt_match *match, unsigned int match_size)
+{
+	u16 csize;
+
+	if (match->matchsize == -1) /* cannot validate ebt_among */
+		return true;
+
+	csize = match->compatsize ? : match->matchsize;
+
+	return match_size >= csize;
+}
+
+static bool tgt_size_ok(const struct xt_target *tgt, unsigned int tgt_size)
+{
+	u16 csize = tgt->compatsize ? : tgt->targetsize;
+
+	return tgt_size >= csize;
+}
+
 static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 				enum compat_mwt compat_mwt,
 				struct ebt_entries_buf_state *state,
@@ -1981,6 +2000,11 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 		if (IS_ERR(match))
 			return PTR_ERR(match);
 
+		if (!match_size_ok(match, match_size)) {
+			module_put(match->me);
+			return -EINVAL;
+		}
+
 		off = ebt_compat_match_offset(match, match_size);
 		if (dst) {
 			if (match->compat_from_user)
@@ -2000,6 +2024,12 @@ static int compat_mtw_from_user(const struct compat_ebt_entry_mwt *mwt,
 					    mwt->u.revision);
 		if (IS_ERR(wt))
 			return PTR_ERR(wt);
+
+		if (!tgt_size_ok(wt, match_size)) {
+			module_put(wt->me);
+			return -EINVAL;
+		}
+
 		off = xt_compat_target_offset(wt);
 
 		if (dst) {
diff --git a/net/core/filter.c b/net/core/filter.c
index d8a853a61b53..e4ed3b343ed9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2865,7 +2865,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
-		rsge.offset += start;
+		rsge.offset += start - offset;
 
 		sk_msg_iter_var_next(i);
 		sg_unmark_end(psge);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 28bd8304796d..9edad9b88433 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2811,6 +2811,8 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 		skb->data_len  = 0;
 		skb_set_tail_pointer(skb, len);
 	}
+	if (!skb_shinfo(skb)->nr_frags && !skb_has_frag_list(skb))
+		skb->unreadable = 0;
 
 	if (!skb->sk || skb->destructor == sock_edemux)
 		skb_condense(skb);
@@ -2818,16 +2820,37 @@ int ___pskb_trim(struct sk_buff *skb, unsigned int len)
 }
 EXPORT_SYMBOL(___pskb_trim);
 
+static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
+{
+	int delta = skb->len - len;
+
+	if (skb_frags_readable(skb)) {
+		skb->csum = csum_block_sub(skb->csum,
+					   skb_checksum(skb, len, delta, 0),
+					   len);
+		return 0;
+	}
+
+	if (len > skb_headlen(skb))
+		return -EFAULT;
+
+	/* The trimmed bytes are unreadable, but the remaining packet can be
+	 * checksummed by software after trimming.
+	 */
+	skb->ip_summed = CHECKSUM_NONE;
+	return 0;
+}
+
 /* Note : use pskb_trim_rcsum() instead of calling this directly
  */
 int pskb_trim_rcsum_slow(struct sk_buff *skb, unsigned int len)
 {
 	if (skb->ip_summed == CHECKSUM_COMPLETE) {
-		int delta = skb->len - len;
+		int err;
 
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		err = pskb_trim_rcsum_complete(skb, len);
+		if (err)
+			return err;
 	} else if (skb->ip_summed == CHECKSUM_PARTIAL) {
 		int hdlen = (len > skb_headlen(skb)) ? skb_headlen(skb) : len;
 		int offset = skb_checksum_start_offset(skb) + skb->csum_offset;
@@ -6824,6 +6847,11 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 	skb_copy_from_linear_data_offset(skb, off, data, new_hlen);
 	skb->len -= off;
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb),
 	       offsetof(struct skb_shared_info,
@@ -6834,6 +6862,8 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_kfree_head(data, size);
 			return -ENOMEM;
 		}
+		if (skb_zcopy(skb))
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6935,6 +6965,11 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		return -ENOMEM;
 	size = SKB_WITH_OVERHEAD(size);
 
+	/* Remove SKBFL_MANAGED_FRAG_REFS instead of trying to honour it
+	 * while refcounting frags below.
+	 */
+	skb_zcopy_downgrade_managed(skb);
+
 	memcpy((struct skb_shared_info *)(data + size),
 	       skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
 	if (skb_orphan_frags(skb, gfp_mask)) {
@@ -6977,6 +7012,8 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data, size);
 		return -ENOMEM;
 	}
+	if (skb_zcopy(skb))
+		net_zcopy_get(skb_zcopy(skb));
 	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;
diff --git a/net/ethtool/cmis.h b/net/ethtool/cmis.h
index 4a9a946cabf0..778783a0f23c 100644
--- a/net/ethtool/cmis.h
+++ b/net/ethtool/cmis.h
@@ -63,9 +63,9 @@ struct ethtool_cmis_cdb_request {
  * struct ethtool_cmis_cdb_cmd_args - CDB commands execution arguments
  * @req: CDB command fields as described in the CMIS standard.
  * @max_duration: Maximum duration time for command completion in msec.
+ * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @read_write_len_ext: Allowable additional number of byte octets to the LPL
  *			in a READ or a WRITE commands.
- * @msleep_pre_rpl: Waiting time before checking reply in msec.
  * @rpl_exp_len: Expected reply length in bytes.
  * @flags: Validation flags for CDB commands.
  * @err_msg: Error message to be sent to user space.
@@ -73,8 +73,8 @@ struct ethtool_cmis_cdb_request {
 struct ethtool_cmis_cdb_cmd_args {
 	struct ethtool_cmis_cdb_request req;
 	u16				max_duration;
+	u16				msleep_pre_rpl;
 	u8				read_write_len_ext;
-	u8				msleep_pre_rpl;
 	u8                              rpl_exp_len;
 	u8				flags;
 	char				*err_msg;
diff --git a/net/ethtool/cmis_cdb.c b/net/ethtool/cmis_cdb.c
index 3670ca42dd40..f3a53a984460 100644
--- a/net/ethtool/cmis_cdb.c
+++ b/net/ethtool/cmis_cdb.c
@@ -513,8 +513,13 @@ static int cmis_cdb_process_reply(struct net_device *dev,
 	}
 
 	rpl = (struct ethtool_cmis_cdb_rpl *)page_data->data;
-	if ((args->rpl_exp_len > rpl->hdr.rpl_len + rpl_hdr_len) ||
-	    !rpl->hdr.rpl_chk_code) {
+	if (rpl->hdr.rpl_len != args->rpl_exp_len) {
+		netdev_warn(dev, "CDB reply length mismatch, expected %u got %u\n",
+			    args->rpl_exp_len, rpl->hdr.rpl_len);
+		err = -EIO;
+		goto out;
+	}
+	if (!rpl->hdr.rpl_chk_code) {
 		err = -EIO;
 		goto out;
 	}
diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
index df5f344209c4..291d04d2776a 100644
--- a/net/ethtool/cmis_fw_update.c
+++ b/net/ethtool/cmis_fw_update.c
@@ -44,6 +44,20 @@ enum cmis_cdb_fw_write_mechanism {
 	CMIS_CDB_FW_WRITE_MECHANISM_BOTH	= 0x11,
 };
 
+/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
+ * revision 5.2.
+ * struct cmis_cdb_start_fw_download_pl is a structured layout of the
+ * flat array, ethtool_cmis_cdb_request::payload.
+ */
+struct cmis_cdb_start_fw_download_pl {
+	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
+			__be32	image_size;
+			__be32	resv1;
+	);
+	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
+		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
+};
+
 static int
 cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 				   struct net_device *dev,
@@ -86,6 +100,14 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	 */
 	cdb->read_write_len_ext = rpl->read_write_len_ext;
 	fw_mng->start_cmd_payload_size = rpl->start_cmd_payload_size;
+	if (fw_mng->start_cmd_payload_size >
+	    sizeof_field(struct cmis_cdb_start_fw_download_pl, vendor_data)) {
+		ethnl_module_fw_flash_ntf_err(dev, ntf_params,
+					      "Start cmd payload size exceeds max LPL payload",
+					      NULL);
+		return -EINVAL;
+	}
+
 	fw_mng->write_mechanism =
 		rpl->write_mechanism == CMIS_CDB_FW_WRITE_MECHANISM_LPL ?
 		CMIS_CDB_FW_WRITE_MECHANISM_LPL :
@@ -97,20 +119,6 @@ cmis_fw_update_fw_mng_features_get(struct ethtool_cmis_cdb *cdb,
 	return 0;
 }
 
-/* See section 9.7.2 "CMD 0101h: Start Firmware Download" in CMIS standard
- * revision 5.2.
- * struct cmis_cdb_start_fw_download_pl is a structured layout of the
- * flat array, ethtool_cmis_cdb_request::payload.
- */
-struct cmis_cdb_start_fw_download_pl {
-	__struct_group(cmis_cdb_start_fw_download_pl_h, head, /* no attrs */,
-			__be32	image_size;
-			__be32	resv1;
-	);
-	u8 vendor_data[ETHTOOL_CMIS_CDB_LPL_MAX_PL_LENGTH -
-		sizeof(struct cmis_cdb_start_fw_download_pl_h)];
-};
-
 static int
 cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
 			      struct ethtool_cmis_fw_update_params *fw_update,
@@ -122,6 +130,14 @@ cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
 	u8 lpl_len;
 	int err;
 
+	if (fw_update->fw->size < vendor_data_size) {
+		ethnl_module_fw_flash_ntf_err(fw_update->dev,
+					      &fw_update->ntf_params,
+					      "Firmware image too small for module's start payload",
+					      NULL);
+		return -EINVAL;
+	}
+
 	pl.image_size = cpu_to_be32(fw_update->fw->size);
 	memcpy(pl.vendor_data, fw_update->fw->data, vendor_data_size);
 
diff --git a/net/ethtool/coalesce.c b/net/ethtool/coalesce.c
index 3e18ca1ccc5e..cace02d964cb 100644
--- a/net/ethtool/coalesce.c
+++ b/net/ethtool/coalesce.c
@@ -463,6 +463,12 @@ static int ethnl_update_profile(struct net_device *dev,
 
 	nla_for_each_nested_type(nest, ETHTOOL_A_PROFILE_IRQ_MODERATION,
 				 nests, rem) {
+		if (i >= NET_DIM_PARAMS_NUM_PROFILES) {
+			NL_SET_BAD_ATTR(extack, nest);
+			ret = -E2BIG;
+			goto err_out;
+		}
+
 		ret = nla_parse_nested(tb, len_irq_moder - 1, nest,
 				       coalesce_irq_moderation_policy,
 				       extack);
diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
index 3b8209e930fd..80af38a6c76a 100644
--- a/net/ethtool/eeprom.c
+++ b/net/ethtool/eeprom.c
@@ -43,6 +43,9 @@ static int fallback_set_params(struct eeprom_req_info *request,
 	if (offset >= modinfo->eeprom_len)
 		return -EINVAL;
 
+	if (length > modinfo->eeprom_len - offset)
+		return -EINVAL;
+
 	eeprom->cmd = ETHTOOL_GMODULEEEPROM;
 	eeprom->len = length;
 	eeprom->offset = offset;
@@ -68,7 +71,7 @@ static int eeprom_fallback(struct eeprom_req_info *request,
 	if (err < 0)
 		return err;
 
-	data = kmalloc(eeprom.len, GFP_KERNEL);
+	data = kzalloc(eeprom.len, GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 	err = ethtool_get_module_eeprom_call(dev, &eeprom, data);
@@ -140,12 +143,11 @@ static int eeprom_prepare_data(const struct ethnl_req_info *req_base,
 	return 0;
 
 err_ops:
+	if (ret == -EOPNOTSUPP)
+		ret = eeprom_fallback(request, reply);
 	ethnl_ops_complete(dev);
 err_free:
 	kfree(page_data.data);
-
-	if (ret == -EOPNOTSUPP)
-		return eeprom_fallback(request, reply);
 	return ret;
 }
 
diff --git a/net/ethtool/linkstate.c b/net/ethtool/linkstate.c
index 05a5f72c99fa..3dc52a39d345 100644
--- a/net/ethtool/linkstate.c
+++ b/net/ethtool/linkstate.c
@@ -105,10 +105,8 @@ static int linkstate_prepare_data(const struct ethnl_req_info *req_base,
 
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_LINKSTATE_HEADER,
 				      info->extack);
-	if (IS_ERR(phydev)) {
-		ret = PTR_ERR(phydev);
-		goto out;
-	}
+	if (IS_ERR(phydev))
+		return PTR_ERR(phydev);
 
 	ret = ethnl_ops_begin(dev);
 	if (ret < 0)
diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 0a761bf4771e..6eb83f6b3d26 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -120,12 +120,6 @@ ethnl_set_module_validate(struct ethnl_req_info *req_info,
 	if (!tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY])
 		return 0;
 
-	if (req_info->dev->ethtool->module_fw_flash_in_progress) {
-		NL_SET_ERR_MSG(info->extack,
-			       "Module firmware flashing is in progress");
-		return -EBUSY;
-	}
-
 	if (!ops->get_module_power_mode || !ops->set_module_power_mode) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY],
@@ -148,6 +142,12 @@ ethnl_set_module(struct ethnl_req_info *req_info, struct genl_info *info)
 
 	ops = dev->ethtool_ops;
 
+	if (dev->ethtool->module_fw_flash_in_progress) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Module firmware flashing is in progress");
+		return -EBUSY;
+	}
+
 	power_new.policy = nla_get_u8(tb[ETHTOOL_A_MODULE_POWER_MODE_POLICY]);
 	ret = ops->get_module_power_mode(dev, &power, info->extack);
 	if (ret < 0)
@@ -221,14 +221,22 @@ static void module_flash_fw_work_list_del(struct list_head *list)
 static void module_flash_fw_work(struct work_struct *work)
 {
 	struct ethtool_module_fw_flash *module_fw;
+	struct net_device *dev;
 
 	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
+	dev = module_fw->fw_update.dev;
 
 	ethtool_cmis_fw_update(&module_fw->fw_update);
 
 	module_flash_fw_work_list_del(&module_fw->list);
-	module_fw->fw_update.dev->ethtool->module_fw_flash_in_progress = false;
-	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
+
+	rtnl_lock();
+	netdev_lock_ops(dev);
+	dev->ethtool->module_fw_flash_in_progress = false;
+	netdev_unlock_ops(dev);
+	rtnl_unlock();
+
+	netdev_put(dev, &module_fw->dev_tracker);
 	release_firmware(module_fw->fw_update.fw);
 	kfree(module_fw);
 }
@@ -283,11 +291,9 @@ void ethnl_module_fw_flash_sock_destroy(struct ethnl_sock_priv *sk_priv)
 
 	spin_lock(&module_fw_flash_work_list_lock);
 	list_for_each_entry(work, &module_fw_flash_work_list, list) {
-		if (work->fw_update.dev == sk_priv->dev &&
-		    work->fw_update.ntf_params.portid == sk_priv->portid) {
+		if (work->fw_update.ntf_params.portid == sk_priv->portid &&
+		    dev_net(work->fw_update.dev) == sk_priv->net)
 			work->fw_update.ntf_params.closed_sock = true;
-			break;
-		}
 	}
 	spin_unlock(&module_fw_flash_work_list_lock);
 }
@@ -319,14 +325,13 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	if (err < 0)
 		goto err_release_firmware;
 
-	dev->ethtool->module_fw_flash_in_progress = true;
-	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
 	fw_update->dev = dev;
 	fw_update->ntf_params.portid = info->snd_portid;
 	fw_update->ntf_params.seq = info->snd_seq;
 	fw_update->ntf_params.closed_sock = false;
 
-	err = ethnl_sock_priv_set(skb, dev, fw_update->ntf_params.portid,
+	err = ethnl_sock_priv_set(skb, dev_net(dev),
+				  fw_update->ntf_params.portid,
 				  ETHTOOL_SOCK_TYPE_MODULE_FW_FLASH);
 	if (err < 0)
 		goto err_release_firmware;
@@ -335,6 +340,9 @@ module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 	if (err < 0)
 		goto err_release_firmware;
 
+	dev->ethtool->module_fw_flash_in_progress = true;
+	netdev_hold(dev, &module_fw->dev_tracker, GFP_KERNEL);
+
 	schedule_work(&module_fw->work);
 
 	return 0;
@@ -427,10 +435,11 @@ int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
 
 	ret = ethnl_module_fw_flash_validate(dev, info->extack);
 	if (ret < 0)
-		goto out_unlock;
+		goto out_complete;
 
 	ret = module_flash_fw(dev, tb, skb, info);
 
+out_complete:
 	ethnl_ops_complete(dev);
 
 out_unlock:
diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 6e5f0f4f815a..4cf928da6072 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -52,7 +52,7 @@ const struct nla_policy ethnl_header_policy_phy_stats[] = {
 	[ETHTOOL_A_HEADER_PHY_INDEX]		= NLA_POLICY_MIN(NLA_U32, 1),
 };
 
-int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net *net, u32 portid,
 			enum ethnl_sock_type type)
 {
 	struct ethnl_sock_priv *sk_priv;
@@ -61,7 +61,7 @@ int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
 	if (IS_ERR(sk_priv))
 		return PTR_ERR(sk_priv);
 
-	sk_priv->dev = dev;
+	sk_priv->net = net;
 	sk_priv->portid = portid;
 	sk_priv->type = type;
 
diff --git a/net/ethtool/netlink.h b/net/ethtool/netlink.h
index 89010eaa67df..65c24f627b21 100644
--- a/net/ethtool/netlink.h
+++ b/net/ethtool/netlink.h
@@ -318,12 +318,12 @@ enum ethnl_sock_type {
 };
 
 struct ethnl_sock_priv {
-	struct net_device *dev;
+	struct net *net;
 	u32 portid;
 	enum ethnl_sock_type type;
 };
 
-int ethnl_sock_priv_set(struct sk_buff *skb, struct net_device *dev, u32 portid,
+int ethnl_sock_priv_set(struct sk_buff *skb, struct net *net, u32 portid,
 			enum ethnl_sock_type type);
 
 /**
diff --git a/net/ethtool/pse-pd.c b/net/ethtool/pse-pd.c
index 24def9c9dd54..aa4514333d13 100644
--- a/net/ethtool/pse-pd.c
+++ b/net/ethtool/pse-pd.c
@@ -61,14 +61,14 @@ static int pse_prepare_data(const struct ethnl_req_info *req_base,
 	struct phy_device *phydev;
 	int ret;
 
-	ret = ethnl_ops_begin(dev);
-	if (ret < 0)
-		return ret;
-
 	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_PSE_HEADER,
 				      info->extack);
 	if (IS_ERR(phydev))
-		return -ENODEV;
+		return PTR_ERR(phydev);
+
+	ret = ethnl_ops_begin(dev);
+	if (ret < 0)
+		return ret;
 
 	ret = pse_get_pse_attributes(phydev, info->extack, data);
 
diff --git a/net/ethtool/rss.c b/net/ethtool/rss.c
index da5934cceb07..b122f67dbde1 100644
--- a/net/ethtool/rss.c
+++ b/net/ethtool/rss.c
@@ -132,8 +132,7 @@ rss_get_data_alloc(struct net_device *dev, struct rss_reply_data *data)
 	if (!rss_config)
 		return -ENOMEM;
 
-	if (data->indir_size)
-		data->indir_table = (u32 *)rss_config;
+	data->indir_table = (u32 *)rss_config;
 	if (data->hkey_size)
 		data->hkey = rss_config + indir_bytes;
 
@@ -168,8 +167,10 @@ rss_prepare_get(const struct rss_req_info *request, struct net_device *dev,
 	rxfh.key = data->hkey;
 
 	ret = ops->get_rxfh(dev, &rxfh);
-	if (ret)
+	if (ret) {
+		rss_get_data_free(data);
 		goto out_unlock;
+	}
 
 	data->hfunc = rxfh.hfunc;
 	data->input_xfrm = rxfh.input_xfrm;
@@ -684,7 +685,7 @@ rss_set_prep_indir(struct net_device *dev, struct genl_info *info,
 				ethtool_rxfh_indir_default(i, num_rx_rings);
 	}
 
-	*mod |= memcmp(rxfh->indir, data->indir_table, data->indir_size);
+	*mod |= memcmp(rxfh->indir, data->indir_table, alloc_size);
 
 	return 0;
 
@@ -974,11 +975,17 @@ ethnl_rss_create_validate(struct net_device *dev, struct genl_info *info)
 }
 
 static void
-ethnl_rss_create_send_ntf(struct sk_buff *rsp, struct net_device *dev)
+ethnl_rss_create_send_ntf(const struct sk_buff *rsp, struct net_device *dev)
 {
-	struct nlmsghdr *nlh = (void *)rsp->data;
 	struct genlmsghdr *genl_hdr;
+	struct nlmsghdr *nlh;
+	struct sk_buff *ntf;
+
+	ntf = skb_copy_expand(rsp, 0, 0, GFP_KERNEL);
+	if (!ntf)
+		return;
 
+	nlh = nlmsg_hdr(ntf);
 	/* Convert the reply into a notification */
 	nlh->nlmsg_pid = 0;
 	nlh->nlmsg_seq = ethnl_bcast_seq_next();
@@ -986,7 +993,7 @@ ethnl_rss_create_send_ntf(struct sk_buff *rsp, struct net_device *dev)
 	genl_hdr = nlmsg_data(nlh);
 	genl_hdr->cmd =	ETHTOOL_MSG_RSS_CREATE_NTF;
 
-	ethnl_multicast(rsp, dev);
+	ethnl_multicast(ntf, dev);
 }
 
 int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
@@ -1089,17 +1096,13 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	ntf_fail |= rss_fill_reply(rsp, &req.base, &data.base);
 	if (WARN_ON(!hdr || ntf_fail)) {
 		ret = -EMSGSIZE;
-		goto exit_unlock;
+		goto err_remove_ctx;
 	}
 
 	genlmsg_end(rsp, hdr);
 
-	/* Use the same skb for the response and the notification,
-	 * genlmsg_reply() will copy the skb if it has elevated user count.
-	 */
-	skb_get(rsp);
-	ret = genlmsg_reply(rsp, info);
 	ethnl_rss_create_send_ntf(rsp, dev);
+	ret = genlmsg_reply(rsp, info);
 	rsp = NULL;
 
 exit_unlock:
@@ -1121,6 +1124,10 @@ int ethnl_rss_create_doit(struct sk_buff *skb, struct genl_info *info)
 	nlmsg_free(rsp);
 	return ret;
 
+err_remove_ctx:
+	if (ops->remove_rxfh_context(dev, ctx, req.rss_context, NULL))
+		/* leave the context on failure, like ethnl_rss_delete_doit() */
+		goto exit_unlock;
 err_ctx_id_free:
 	xa_erase(&dev->ethtool->rss_ctx, req.rss_context);
 err_unlock_free_ctx:
@@ -1158,8 +1165,10 @@ int ethnl_rss_delete_doit(struct sk_buff *skb, struct genl_info *info)
 	dev = req.dev;
 	ops = dev->ethtool_ops;
 
-	if (!ops->create_rxfh_context)
+	if (!ops->create_rxfh_context) {
+		ret = -EOPNOTSUPP;
 		goto exit_free_dev;
+	}
 
 	rtnl_lock();
 	netdev_lock_ops(dev);
diff --git a/net/ethtool/strset.c b/net/ethtool/strset.c
index f6a67109beda..872ca593b976 100644
--- a/net/ethtool/strset.c
+++ b/net/ethtool/strset.c
@@ -309,7 +309,7 @@ static int strset_prepare_data(const struct ethnl_req_info *req_base,
 		return 0;
 	}
 
-	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_HEADER_FLAGS,
+	phydev = ethnl_req_get_phydev(req_base, tb, ETHTOOL_A_STRSET_HEADER,
 				      info->extack);
 
 	/* phydev can be NULL, check for errors only */
diff --git a/net/ethtool/tsconfig.c b/net/ethtool/tsconfig.c
index e49e612a68c2..990dca9a3fc5 100644
--- a/net/ethtool/tsconfig.c
+++ b/net/ethtool/tsconfig.c
@@ -69,8 +69,10 @@ static int tsconfig_prepare_data(const struct ethnl_req_info *req_base,
 		if (ret)
 			goto out;
 
-		if (ts_info.phc_index == -1)
-			return -ENODEV;
+		if (ts_info.phc_index == -1) {
+			ret = -ENODEV;
+			goto out;
+		}
 
 		data->hwprov_desc.index = ts_info.phc_index;
 		data->hwprov_desc.qualifier = ts_info.phc_qualifier;
@@ -224,16 +226,21 @@ static int tsconfig_send_reply(struct net_device *dev, struct genl_info *info)
 	reply_len = ret + ethnl_reply_header_size();
 	rskb = ethnl_reply_init(reply_len, dev, ETHTOOL_MSG_TSCONFIG_SET_REPLY,
 				ETHTOOL_A_TSCONFIG_HEADER, info, &reply_payload);
-	if (!rskb)
+	if (!rskb) {
+		ret = -ENOMEM;
 		goto err_cleanup;
+	}
 
 	ret = tsconfig_fill_reply(rskb, &req_info->base, &reply_data->base);
 	if (ret < 0)
-		goto err_cleanup;
+		goto err_free_msg;
 
 	genlmsg_end(rskb, reply_payload);
 	ret = genlmsg_reply(rskb, info);
+	rskb = NULL;
 
+err_free_msg:
+	nlmsg_free(rskb);
 err_cleanup:
 	kfree(reply_data);
 	kfree(req_info);
diff --git a/net/ethtool/tsinfo.c b/net/ethtool/tsinfo.c
index c0145c752d2f..64e6016a7a17 100644
--- a/net/ethtool/tsinfo.c
+++ b/net/ethtool/tsinfo.c
@@ -81,6 +81,11 @@ tsinfo_parse_request(struct ethnl_req_info *req_base, struct nlattr **tb,
 	if (!tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER])
 		return 0;
 
+	if (req_base->flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(extack, "can't query statistics for a provider");
+		return -EOPNOTSUPP;
+	}
+
 	return ts_parse_hwtst_provider(tb[ETHTOOL_A_TSINFO_HWTSTAMP_PROVIDER],
 				       &req->hwprov_desc, extack, &mod);
 }
@@ -400,10 +405,8 @@ static int ethnl_tsinfo_dump_one_netdev(struct sk_buff *skb,
 			continue;
 
 		ehdr = ethnl_tsinfo_prepare_dump(skb, dev, reply_data, cb);
-		if (IS_ERR(ehdr)) {
-			ret = PTR_ERR(ehdr);
-			goto err;
-		}
+		if (IS_ERR(ehdr))
+			return PTR_ERR(ehdr);
 
 		reply_data->ts_info.phc_qualifier = ctx->pos_phcqualifier;
 		ret = ops->get_ts_info(dev, &reply_data->ts_info);
@@ -521,6 +524,12 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 	if (ret < 0)
 		goto free_reply_data;
 
+	if (req_info->base.flags & ETHTOOL_FLAG_STATS) {
+		NL_SET_ERR_MSG(cb->extack, "stats not supported in dump");
+		ret = -EOPNOTSUPP;
+		goto err_dev_put;
+	}
+
 	ctx->req_info = req_info;
 	ctx->reply_data = reply_data;
 	ctx->pos_ifindex = 0;
@@ -530,6 +539,8 @@ int ethnl_tsinfo_start(struct netlink_callback *cb)
 
 	return 0;
 
+err_dev_put:
+	ethnl_parse_header_dev_put(&req_info->base);
 free_reply_data:
 	kfree(reply_data);
 free_req_info:
diff --git a/net/handshake/genl.c b/net/handshake/genl.c
index 870612609491..4b20cd9cdd0e 100644
--- a/net/handshake/genl.c
+++ b/net/handshake/genl.c
@@ -10,6 +10,7 @@
 #include "genl.h"
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 /* HANDSHAKE_CMD_ACCEPT - do */
 static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HANDLER_CLASS + 1] = {
@@ -18,7 +19,7 @@ static const struct nla_policy handshake_accept_nl_policy[HANDSHAKE_A_ACCEPT_HAN
 
 /* HANDSHAKE_CMD_DONE - do */
 static const struct nla_policy handshake_done_nl_policy[HANDSHAKE_A_DONE_REMOTE_AUTH + 1] = {
-	[HANDSHAKE_A_DONE_STATUS] = { .type = NLA_U32, },
+	[HANDSHAKE_A_DONE_STATUS] = NLA_POLICY_MAX(NLA_U32, MAX_ERRNO),
 	[HANDSHAKE_A_DONE_SOCKFD] = { .type = NLA_S32, },
 	[HANDSHAKE_A_DONE_REMOTE_AUTH] = { .type = NLA_U32, },
 };
diff --git a/net/handshake/genl.h b/net/handshake/genl.h
index 8d3e18672daf..46b65f131669 100644
--- a/net/handshake/genl.h
+++ b/net/handshake/genl.h
@@ -11,6 +11,7 @@
 #include <net/genetlink.h>
 
 #include <uapi/linux/handshake.h>
+#include <linux/err.h>
 
 int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info);
 int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info);
diff --git a/net/handshake/handshake-test.c b/net/handshake/handshake-test.c
index 55442b2f518a..9cc7a95f4120 100644
--- a/net/handshake/handshake-test.c
+++ b/net/handshake/handshake-test.c
@@ -25,7 +25,7 @@ static int test_accept_func(struct handshake_req *req, struct genl_info *info,
 	return 0;
 }
 
-static void test_done_func(struct handshake_req *req, unsigned int status,
+static void test_done_func(struct handshake_req *req, int status,
 			   struct genl_info *info)
 {
 }
@@ -375,6 +375,10 @@ static void handshake_req_cancel_test2(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Act */
 	result = handshake_req_cancel(sock->sk);
@@ -417,6 +421,10 @@ static void handshake_req_cancel_test3(struct kunit *test)
 	/* Pretend to accept this request */
 	next = handshake_req_next(hn, HANDSHAKE_HANDLER_CLASS_TLSHD);
 	KUNIT_ASSERT_PTR_EQ(test, req, next);
+	/* Simulate FD_PREPARE() consuming the file reference handed
+	 * off by handshake_req_next(); see handshake_nl_accept_doit().
+	 */
+	fput(filp);
 
 	/* Pretend to complete this request */
 	handshake_complete(next, -ETIMEDOUT, NULL);
diff --git a/net/handshake/handshake.h b/net/handshake/handshake.h
index a48163765a7a..da61cadd1ad3 100644
--- a/net/handshake/handshake.h
+++ b/net/handshake/handshake.h
@@ -24,6 +24,7 @@ enum hn_flags_bits {
 	HANDSHAKE_F_NET_DRAINING,
 };
 
+struct file;
 struct handshake_proto;
 
 /* One handshake request */
@@ -32,6 +33,7 @@ struct handshake_req {
 	struct rhash_head		hr_rhash;
 	unsigned long			hr_flags;
 	const struct handshake_proto	*hr_proto;
+	struct file			*hr_file;
 	struct sock			*hr_sk;
 	void				(*hr_odestruct)(struct sock *sk);
 
@@ -57,7 +59,7 @@ struct handshake_proto {
 	int			(*hp_accept)(struct handshake_req *req,
 					     struct genl_info *info, int fd);
 	void			(*hp_done)(struct handshake_req *req,
-					   unsigned int status,
+					   int status,
 					   struct genl_info *info);
 	void			(*hp_destroy)(struct handshake_req *req);
 };
@@ -86,7 +88,7 @@ struct handshake_req *handshake_req_hash_lookup(struct sock *sk);
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class);
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags);
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info);
 bool handshake_req_cancel(struct sock *sk);
 
diff --git a/net/handshake/netlink.c b/net/handshake/netlink.c
index b989456fc4c5..3fd4fef9bab1 100644
--- a/net/handshake/netlink.c
+++ b/net/handshake/netlink.c
@@ -92,7 +92,6 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net *net = sock_net(skb->sk);
 	struct handshake_net *hn = handshake_pernet(net);
 	struct handshake_req *req = NULL;
-	struct socket *sock;
 	int class, err;
 
 	err = -EOPNOTSUPP;
@@ -107,15 +106,13 @@ int handshake_nl_accept_doit(struct sk_buff *skb, struct genl_info *info)
 	err = -EAGAIN;
 	req = handshake_req_next(hn, class);
 	if (req) {
-		sock = req->hr_sk->sk_socket;
-
-		FD_PREPARE(fdf, O_CLOEXEC, sock->file);
+		FD_PREPARE(fdf, O_CLOEXEC, req->hr_file);
 		if (fdf.err) {
+			fput(req->hr_file); /* drop ref from handshake_req_next() */
 			err = fdf.err;
 			goto out_complete;
 		}
 
-		get_file(sock->file); /* FD_PREPARE() consumes a reference. */
 		err = req->hr_proto->hp_accept(req, info, fd_prepare_fd(fdf));
 		if (err)
 			goto out_complete; /* Automatic cleanup handles fput */
@@ -160,7 +157,7 @@ int handshake_nl_done_doit(struct sk_buff *skb, struct genl_info *info)
 
 	status = -EIO;
 	if (info->attrs[HANDSHAKE_A_DONE_STATUS])
-		status = nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
+		status = -(int)nla_get_u32(info->attrs[HANDSHAKE_A_DONE_STATUS]);
 
 	handshake_complete(req, status, info);
 	sockfd_put(sock);
@@ -202,21 +199,21 @@ static void __net_exit handshake_net_exit(struct net *net)
 	 * accepted and are in progress will be destroyed when
 	 * the socket is closed.
 	 */
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	set_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags);
-	list_splice_init(&requests, &hn->hn_requests);
-	spin_unlock(&hn->hn_lock);
+	list_splice_init(&hn->hn_requests, &requests);
+	list_for_each_entry(req, &requests, hr_list)
+		get_file(req->hr_file);
+	spin_unlock_bh(&hn->hn_lock);
 
 	while (!list_empty(&requests)) {
-		req = list_first_entry(&requests, struct handshake_req, hr_list);
-		list_del(&req->hr_list);
-
-		/*
-		 * Requests on this list have not yet been
-		 * accepted, so they do not have an fd to put.
-		 */
+		struct file *file;
 
+		req = list_first_entry(&requests, struct handshake_req, hr_list);
+		file = req->hr_file;
+		list_del_init(&req->hr_list);
 		handshake_complete(req, -ETIMEDOUT, NULL);
+		fput(file);
 	}
 }
 
diff --git a/net/handshake/request.c b/net/handshake/request.c
index 2829adbeb149..2f1ab6eb9538 100644
--- a/net/handshake/request.c
+++ b/net/handshake/request.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/skbuff.h>
 #include <linux/inet.h>
+#include <linux/file.h>
 #include <linux/rhashtable.h>
 
 #include <net/sock.h>
@@ -162,35 +163,56 @@ static void __remove_pending_locked(struct handshake_net *hn,
  * otherwise %false.
  *
  * If @req was on a pending list, it has not yet been accepted.
+ * Returns %false when the net namespace is draining; the drain
+ * loop has taken ownership of the pending list.
  */
 static bool remove_pending(struct handshake_net *hn, struct handshake_req *req)
 {
 	bool ret = false;
 
-	spin_lock(&hn->hn_lock);
-	if (!list_empty(&req->hr_list)) {
+	spin_lock_bh(&hn->hn_lock);
+	if (!test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags) &&
+	    !list_empty(&req->hr_list)) {
 		__remove_pending_locked(hn, req);
 		ret = true;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return ret;
 }
 
+/**
+ * handshake_req_next - Return the next queued handshake request
+ * @hn: per-net handshake state
+ * @class: handler class to match
+ *
+ * On a non-NULL return, the caller owns an extra reference
+ * on @req->hr_file.  FD_PREPARE() consumes it on success; on
+ * the FD_PREPARE() failure path the caller must fput() it.
+ *
+ * Return: pointer to a removed handshake_req, or NULL.
+ */
 struct handshake_req *handshake_req_next(struct handshake_net *hn, int class)
 {
 	struct handshake_req *req, *pos;
 
 	req = NULL;
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	list_for_each_entry(pos, &hn->hn_requests, hr_list) {
 		if (pos->hr_proto->hp_handler_class != class)
 			continue;
 		__remove_pending_locked(hn, pos);
+		/* Hand off a file reference to the accept side under
+		 * hn_lock.  A concurrent handshake_req_cancel() can drop
+		 * hr_file before accept reaches FD_PREPARE(); this extra
+		 * reference keeps the file alive until FD_PREPARE() takes
+		 * ownership.
+		 */
+		get_file(pos->hr_file);
 		req = pos;
 		break;
 	}
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	return req;
 }
@@ -215,9 +237,16 @@ EXPORT_SYMBOL_IF_KUNIT(handshake_req_next);
  * A zero return value from handshake_req_submit() means that
  * exactly one subsequent completion callback is guaranteed.
  *
- * A negative return value from handshake_req_submit() means that
- * no completion callback will be done and that @req has been
- * destroyed.
+ * A negative return value from handshake_req_submit() guarantees that
+ * no completion callback will occur and that @req is no longer owned by
+ * the caller. If cancellation wins the completion race after the request
+ * has been published, final destruction is deferred until socket teardown.
+ *
+ * The caller must hold a reference on @sock->file for the duration
+ * of this call. Once the request is published to the accept side, a
+ * concurrent completion or cancellation may release the request's pin on
+ * @sock->file; the caller's reference is what keeps @sock->sk valid until
+ * handshake_req_submit() returns.
  */
 int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			 gfp_t flags)
@@ -236,6 +265,14 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		kfree(req);
 		return -EINVAL;
 	}
+
+	/*
+	 * Pin sock->file for the lifetime of the request so the
+	 * accept side does not race a consumer that releases the
+	 * socket while a handshake is pending.
+	 */
+	req->hr_file = get_file(sock->file);
+
 	req->hr_odestruct = req->hr_sk->sk_destruct;
 	req->hr_sk->sk_destruct = handshake_sk_destruct;
 
@@ -249,7 +286,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 	if (READ_ONCE(hn->hn_pending) >= hn->hn_pending_max)
 		goto out_err;
 
-	spin_lock(&hn->hn_lock);
+	spin_lock_bh(&hn->hn_lock);
 	ret = -EOPNOTSUPP;
 	if (test_bit(HANDSHAKE_F_NET_DRAINING, &hn->hn_flags))
 		goto out_unlock;
@@ -258,7 +295,7 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 		goto out_unlock;
 	if (!__add_pending_locked(hn, req))
 		goto out_unlock;
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 
 	ret = handshake_genl_notify(net, req->hr_proto, flags);
 	if (ret) {
@@ -267,35 +304,46 @@ int handshake_req_submit(struct socket *sock, struct handshake_req *req,
 			goto out_err;
 	}
 
-	/* Prevent socket release while a handshake request is pending */
+	/*
+	 * Pin struct sock so sk_destruct does not run until the
+	 * handshake completion path releases it; struct socket is
+	 * held separately via hr_file above.
+	 */
 	sock_hold(req->hr_sk);
 
 	trace_handshake_submit(net, req, req->hr_sk);
 	return 0;
 
 out_unlock:
-	spin_unlock(&hn->hn_lock);
+	spin_unlock_bh(&hn->hn_lock);
 out_err:
-	/* Restore original destructor so socket teardown still runs on failure */
-	req->hr_sk->sk_destruct = req->hr_odestruct;
 	trace_handshake_submit_err(net, req, req->hr_sk, ret);
-	handshake_req_destroy(req);
+	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		/* Restore original destructor so socket teardown still runs. */
+		req->hr_sk->sk_destruct = req->hr_odestruct;
+		fput(req->hr_file);
+		handshake_req_destroy(req);
+	}
 	return ret;
 }
 EXPORT_SYMBOL(handshake_req_submit);
 
-void handshake_complete(struct handshake_req *req, unsigned int status,
+void handshake_complete(struct handshake_req *req, int status,
 			struct genl_info *info)
 {
 	struct sock *sk = req->hr_sk;
 	struct net *net = sock_net(sk);
 
 	if (!test_and_set_bit(HANDSHAKE_F_REQ_COMPLETED, &req->hr_flags)) {
+		struct file *file = req->hr_file;
+
 		trace_handshake_complete(net, req, sk, status);
 		req->hr_proto->hp_done(req, status, info);
 
 		/* Handshake request is no longer pending */
 		sock_put(sk);
+
+		fput(file);
 	}
 }
 EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
@@ -344,6 +392,7 @@ bool handshake_req_cancel(struct sock *sk)
 
 	/* Handshake request is no longer pending */
 	sock_put(sk);
+	fput(req->hr_file);
 	return true;
 }
 EXPORT_SYMBOL(handshake_req_cancel);
diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index 8f9532a15f43..7567150c2a4f 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -93,7 +93,7 @@ static void tls_handshake_remote_peerids(struct tls_handshake_req *treq,
  *
  */
 static void tls_handshake_done(struct handshake_req *req,
-			       unsigned int status, struct genl_info *info)
+			       int status, struct genl_info *info)
 {
 	struct tls_handshake_req *treq = handshake_req_private(req);
 
@@ -104,7 +104,7 @@ static void tls_handshake_done(struct handshake_req *req,
 	if (!status)
 		set_bit(HANDSHAKE_F_REQ_SESSION, &req->hr_flags);
 
-	treq->th_consumer_done(treq->th_consumer_data, -status,
+	treq->th_consumer_done(treq->th_consumer_data, status,
 			       treq->th_peerid[0]);
 }
 
@@ -425,6 +425,8 @@ EXPORT_SYMBOL(tls_server_hello_psk);
  * Request cancellation races with request completion. To determine
  * who won, callers examine the return value from this function.
  *
+ * Context: May be called from process or softirq context.
+ *
  * Return values:
  *   %true - Uncompleted handshake request was canceled
  *   %false - Handshake request already completed or not found
diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
index aefc9b6936ba..299de290ddaa 100644
--- a/net/hsr/hsr_forward.c
+++ b/net/hsr/hsr_forward.c
@@ -84,7 +84,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 	/* Get next tlv */
 	total_length += hsr_sup_tag->tlv.HSR_TLV_length;
-	if (!pskb_may_pull(skb, total_length))
+	if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 		return false;
 	skb_pull(skb, total_length);
 	hsr_sup_tlv = (struct hsr_sup_tlv *)skb->data;
@@ -100,7 +100,7 @@ static bool is_supervision_frame(struct hsr_priv *hsr, struct sk_buff *skb)
 
 		/* make sure another tlv follows */
 		total_length += sizeof(struct hsr_sup_tlv) + hsr_sup_tlv->HSR_TLV_length;
-		if (!pskb_may_pull(skb, total_length))
+		if (!pskb_may_pull(skb, total_length + sizeof(struct hsr_sup_tlv)))
 			return false;
 
 		/* get next tlv */
diff --git a/net/ipv4/ah4.c b/net/ipv4/ah4.c
index 4366cbac3f06..6fd642d2278d 100644
--- a/net/ipv4/ah4.c
+++ b/net/ipv4/ah4.c
@@ -143,7 +143,7 @@ static void ah_output_done(void *data, int err)
 	}
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah_output(struct xfrm_state *x, struct sk_buff *skb)
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 6a5febbdbee4..513c8215c947 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -419,8 +419,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv4/ip_tunnel_core.c b/net/ipv4/ip_tunnel_core.c
index f430d6f0463e..fc993c78cbcc 100644
--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iptunnel_handle_offloads);
  */
 static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct iphdr *iph = ip_hdr(skb);
+	const struct iphdr *iph;
 	struct icmphdr *icmph;
 	struct iphdr *niph;
 	struct ethhdr eh;
@@ -226,7 +226,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, 576 - sizeof(*niph) - sizeof(*icmph));
 	if (err)
@@ -236,7 +235,7 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
 	err = skb_cow(skb, sizeof(*niph) + sizeof(*icmph) + ETH_HLEN);
 	if (err)
 		return err;
-
+	iph = ip_hdr(skb);
 	icmph = skb_push(skb, sizeof(*icmph));
 	*icmph = (struct icmphdr) {
 		.type			= ICMP_DEST_UNREACH,
@@ -281,7 +280,6 @@ static int iptunnel_pmtud_build_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 {
-	const struct icmphdr *icmph = icmp_hdr(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 
 	if (mtu < 576 || iph->frag_off != htons(IP_DF))
@@ -292,9 +290,17 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
 	    ipv4_is_lbcast(iph->saddr)  || ipv4_is_multicast(iph->saddr))
 		return 0;
 
-	if (iph->protocol == IPPROTO_ICMP && icmp_is_err(icmph->type))
-		return 0;
+	if (iph->protocol == IPPROTO_ICMP) {
+		const struct icmphdr *icmph;
 
+		if (!pskb_network_may_pull(skb, iph->ihl * 4 +
+						offsetofend(struct icmphdr, type)))
+			return 0;
+		iph = ip_hdr(skb);
+		icmph = (void *)iph + iph->ihl * 4;
+		if (icmp_is_err(icmph->type))
+			return 0;
+	}
 	return iptunnel_pmtud_build_icmp(skb, mtu);
 }
 
@@ -308,7 +314,7 @@ static int iptunnel_pmtud_check_icmp(struct sk_buff *skb, int mtu)
  */
 static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
+	const struct ipv6hdr *ip6h;
 	struct icmp6hdr *icmp6h;
 	struct ipv6hdr *nip6h;
 	struct ethhdr eh;
@@ -323,7 +329,6 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 
 	skb_copy_bits(skb, skb_mac_offset(skb), &eh, ETH_HLEN);
 	pskb_pull(skb, ETH_HLEN);
-	skb_reset_network_header(skb);
 
 	err = pskb_trim(skb, IPV6_MIN_MTU - sizeof(*nip6h) - sizeof(*icmp6h));
 	if (err)
@@ -334,6 +339,7 @@ static int iptunnel_pmtud_build_icmpv6(struct sk_buff *skb, int mtu)
 	if (err)
 		return err;
 
+	ip6h = ipv6_hdr(skb);
 	icmp6h = skb_push(skb, sizeof(*icmp6h));
 	*icmp6h = (struct icmp6hdr) {
 		.icmp6_type		= ICMPV6_PKT_TOOBIG,
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 5654cc9c8a0b..e47df4d706a9 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1698,10 +1698,10 @@ static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
 	const struct ctl_table *table;
 
-	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.ipv4_hdr);
 	kfree(table);
+	kfree(net->ipv4.sysctl_local_reserved_ports);
 }
 
 static __net_initdata struct pernet_operations ipv4_sysctl_ops = {
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index dd0b4d80e0f8..e5276be71062 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1012,7 +1012,7 @@ ipv6_link_dev_addr(struct inet6_dev *idev, struct inet6_ifaddr *ifp)
 	list_for_each(p, &idev->addr_list) {
 		struct inet6_ifaddr *ifa
 			= list_entry(p, struct inet6_ifaddr, if_list);
-		if (ifp_scope > ipv6_addr_src_scope(&ifa->addr))
+		if (ifp_scope >= ipv6_addr_src_scope(&ifa->addr))
 			break;
 	}
 
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index de1e68199a01..76f7a2de9108 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -337,7 +337,7 @@ static void ah6_output_done(void *data, int err)
 	ah6_restore_hdrs(top_iph, iph_ext, extlen);
 
 	kfree(AH_SKB_CB(skb)->tmp);
-	xfrm_output_resume(skb->sk, skb, err);
+	xfrm_output_resume(skb_to_full_sk(skb), skb, err);
 }
 
 static int ah6_output(struct xfrm_state *x, struct sk_buff *skb)
diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 993e2d76fc1f..5367619115ba 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -618,6 +618,18 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	}
 }
 
+static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
+{
+	u16 len;
+
+	if (ptr + 2 > skb_tail_pointer(skb))
+		return 0;
+
+	len = (ptr[1] + 1) << 3;
+
+	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;
+}
+
 void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 				    struct sk_buff *skb)
 {
@@ -644,7 +656,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	/* HbH is allowed only once */
 	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, len, ptr);
 	}
 
 	if (opt->lastopt &&
@@ -665,26 +680,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 			unsigned int len;
 			u8 *ptr = nh + off;
 
+			if (ptr + 2 > skb_tail_pointer(skb))
+				return;
+
 			switch (nexthdr) {
 			case IPPROTO_DSTOPTS:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.dstopts)
 					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
 				break;
 			case IPPROTO_ROUTING:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.srcrt)
 					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 2) << 2;
+				if (ptr + len > skb_tail_pointer(skb))
+					return;
 				break;
 			default:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				break;
 			}
 
@@ -706,19 +732,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	}
 	if (np->rxopt.bits.ohopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst0) {
 		u8 *ptr = nh + opt->dst0;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.osrcrt && opt->srcrt) {
 		struct ipv6_rt_hdr *rthdr = (struct ipv6_rt_hdr *)(nh + opt->srcrt);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, (rthdr->hdrlen+1) << 3, rthdr);
+		u16 len = ipv6_get_exthdr_len(skb, (u8 *)rthdr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, len, rthdr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst1) {
 		u8 *ptr = nh + opt->dst1;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 9c06c5a1419d..57481e423e59 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -448,8 +448,8 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 			return err;
 	}
 
-	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
-	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
+	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
+	    PAGE_SIZE)
 		goto cow;
 
 	if (!skb_cloned(skb)) {
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index cf90f933ca1a..43f46ef9c53b 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -184,6 +184,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_JUMBO:
 					if (!ipv6_hop_jumbo(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 				case IPV6_TLV_CALIPSO:
 					if (!ipv6_hop_calipso(skb, off))
@@ -201,6 +203,8 @@ static bool ip6_parse_tlv(bool hopbyhop,
 				case IPV6_TLV_HAO:
 					if (!ipv6_dest_hao(skb, off))
 						return false;
+
+					nh = skb_network_header(skb);
 					break;
 #endif
 				default:
@@ -544,7 +548,7 @@ static int ipv6_rpl_srh_rcv(struct sk_buff *skb)
 	 * unsigned char which is segments_left field. Should not be
 	 * higher than that.
 	 */
-	if (r || (n + 1) > 255) {
+	if (r || (n + 1) > 127) {
 		kfree_skb(skb);
 		return -1;
 	}
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index ad5290be4dd6..df793c8bfffb 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -722,10 +722,11 @@ vti6_tnl_change(struct ip6_tnl *t, const struct __ip6_tnl_parm *p,
 static int vti6_update(struct ip6_tnl *t, struct __ip6_tnl_parm *p,
 		       bool keep_mtu)
 {
-	struct net *net = dev_net(t->dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct net *net = t->net;
+	struct vti6_net *ip6n;
 	int err;
 
+	ip6n = net_generic(net, vti6_net_id);
 	vti6_tnl_unlink(ip6n, t);
 	synchronize_net();
 	err = vti6_tnl_change(t, p, keep_mtu);
@@ -834,17 +835,24 @@ vti6_siocdevprivate(struct net_device *dev, struct ifreq *ifr, void __user *data
 		if (p.proto != IPPROTO_IPV6  && p.proto != 0)
 			break;
 		vti6_parm_from_user(&p1, &p);
-		t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		if (dev != ip6n->fb_tnl_dev && cmd == SIOCCHGTUNNEL) {
+			struct ip6_tnl *self = netdev_priv(dev);
+
+			err = -EPERM;
+			if (!ns_capable(self->net->user_ns, CAP_NET_ADMIN))
+				break;
+			t = vti6_locate(self->net, &p1, false);
 			if (t) {
 				if (t->dev != dev) {
 					err = -EEXIST;
 					break;
 				}
 			} else
-				t = netdev_priv(dev);
+				t = self;
 
 			err = vti6_update(t, &p1, false);
+		} else {
+			t = vti6_locate(net, &p1, cmd == SIOCADDTUNNEL);
 		}
 		if (t) {
 			err = 0;
@@ -1031,11 +1039,12 @@ static int vti6_changelink(struct net_device *dev, struct nlattr *tb[],
 			   struct nlattr *data[],
 			   struct netlink_ext_ack *extack)
 {
-	struct ip6_tnl *t;
+	struct ip6_tnl *t = netdev_priv(dev);
+	struct net *net = t->net;
 	struct __ip6_tnl_parm p;
-	struct net *net = dev_net(dev);
-	struct vti6_net *ip6n = net_generic(net, vti6_net_id);
+	struct vti6_net *ip6n;
 
+	ip6n = net_generic(net, vti6_net_id);
 	if (dev == ip6n->fb_tnl_dev)
 		return -EINVAL;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index cb521700cee7..9a45ecdd7b85 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -481,6 +481,9 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		const struct fib6_nh *nh = sibling->fib6_nh;
 		int nh_upper_bound;
 
+		if (!READ_ONCE(first->fib6_nsiblings))
+			break;
+
 		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
 		if (hash > nh_upper_bound)
 			continue;
@@ -5891,6 +5894,8 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 
 				goto nla_put_failure;
 			}
+			if (!READ_ONCE(rt->fib6_nsiblings))
+				break;
 		}
 
 		rcu_read_unlock();
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 6554d2cffc19..30cbd98f941a 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -1538,7 +1538,7 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 	struct sock *sk = sock->sk;
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int val;
-	int len;
+	int len, rc;
 
 	if (level != SOL_IUCV)
 		return -ENOPROTOOPT;
@@ -1551,26 +1551,34 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
 
 	len = min_t(unsigned int, len, sizeof(int));
 
+	rc = 0;
+
+	lock_sock(sk);
 	switch (optname) {
 	case SO_IPRMDATA_MSG:
 		val = (iucv->flags & IUCV_IPRMDATA) ? 1 : 0;
 		break;
 	case SO_MSGLIMIT:
-		lock_sock(sk);
 		val = (iucv->path != NULL) ? iucv->path->msglim	/* connected */
 					   : iucv->msglimit;	/* default */
-		release_sock(sk);
 		break;
 	case SO_MSGSIZE:
-		if (sk->sk_state == IUCV_OPEN)
-			return -EBADFD;
+		if (sk->sk_state == IUCV_OPEN) {
+			rc = -EBADFD;
+			break;
+		}
 		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
 				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
 				0x7fffffff;
 		break;
 	default:
-		return -ENOPROTOOPT;
+		rc = -ENOPROTOOPT;
+		break;
 	}
+	release_sock(sk);
+
+	if (rc)
+		return rc;
 
 	if (put_user(len, optlen))
 		return -EFAULT;
diff --git a/net/key/af_key.c b/net/key/af_key.c
index 5d480ae39405..bcc0cbfbcf75 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3564,7 +3564,7 @@ static int set_ipsecrequest(struct sk_buff *skb,
 #ifdef CONFIG_NET_KEY_MIGRATE
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	int i;
@@ -3669,7 +3669,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* broadcast migrate message to sockets */
-	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, &init_net);
+	pfkey_broadcast(skb, GFP_ATOMIC, BROADCAST_ALL, NULL, net);
 
 	return 0;
 
@@ -3680,7 +3680,7 @@ static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int pfkey_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			      const struct xfrm_migrate *m, int num_bundles,
-			      const struct xfrm_kmaddress *k,
+			      const struct xfrm_kmaddress *k, struct net *net,
 			      const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1455f67e01dd..9419c8555d22 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -441,12 +441,13 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
 		if (tunnel) {
 			list_for_each_entry_rcu(session, &tunnel->session_list, list) {
-				if (!strcmp(session->ifname, ifname)) {
-					refcount_inc(&session->ref_count);
-					rcu_read_unlock_bh();
+				if (strcmp(session->ifname, ifname))
+					continue;
+				if (!refcount_inc_not_zero(&session->ref_count))
+					continue;
+				rcu_read_unlock_bh();
 
-					return session;
-				}
+				return session;
 			}
 		}
 	}
diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
index b67426c2189b..e99ab1e88e9f 100644
--- a/net/netfilter/nf_conntrack_proto_tcp.c
+++ b/net/netfilter/nf_conntrack_proto_tcp.c
@@ -1221,7 +1221,8 @@ int nf_conntrack_tcp_packet(struct nf_conn *ct,
 			new_state = old_state;
 		}
 		if (((test_bit(IPS_SEEN_REPLY_BIT, &ct->status)
-			 && ct->proto.tcp.last_index == TCP_SYN_SET)
+			 && ct->proto.tcp.last_index == TCP_SYN_SET
+			 && ct->proto.tcp.last_dir != dir)
 			|| (!test_bit(IPS_ASSURED_BIT, &ct->status)
 			    && ct->proto.tcp.last_index == TCP_ACK_SET))
 		    && ntohl(th->ack_seq) == ct->proto.tcp.last_end) {
diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 57f57e2fc80a..036c8586f49b 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -200,6 +200,8 @@ synproxy_tstamp_adjust(struct sk_buff *skb, unsigned int protoff,
 	if (skb_ensure_writable(skb, optend))
 		return 0;
 
+	th = (struct tcphdr *)(skb->data + protoff);
+
 	while (optoff < optend) {
 		unsigned char *op = skb->data + optoff;
 
diff --git a/net/netfilter/nft_bitwise.c b/net/netfilter/nft_bitwise.c
index af990c600745..1afb36fb5994 100644
--- a/net/netfilter/nft_bitwise.c
+++ b/net/netfilter/nft_bitwise.c
@@ -43,8 +43,10 @@ static void nft_bitwise_eval_lshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = DIV_ROUND_UP(priv->len, sizeof(u32)); i > 0; i--) {
-		dst[i - 1] = (src[i - 1] << shift) | carry;
-		carry = src[i - 1] >> (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i - 1];
+
+		dst[i - 1] = (tmp_src << shift) | carry;
+		carry = tmp_src >> (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -56,8 +58,10 @@ static void nft_bitwise_eval_rshift(u32 *dst, const u32 *src,
 	u32 carry = 0;
 
 	for (i = 0; i < DIV_ROUND_UP(priv->len, sizeof(u32)); i++) {
-		dst[i] = carry | (src[i] >> shift);
-		carry = src[i] << (BITS_PER_TYPE(u32) - shift);
+		u32 tmp_src = src[i];
+
+		dst[i] = carry | (tmp_src >> shift);
+		carry = tmp_src << (BITS_PER_TYPE(u32) - shift);
 	}
 }
 
@@ -235,6 +239,9 @@ static int nft_bitwise_init_bool(const struct nft_ctx *ctx,
 					      &priv->sreg2, priv->len);
 		if (err < 0)
 			return err;
+
+		if (nft_reg_overlap(priv->sreg2, priv->dreg, priv->len))
+			return -EINVAL;
 	}
 
 	return 0;
@@ -265,6 +272,9 @@ static int nft_bitwise_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
 	if (tb[NFTA_BITWISE_OP]) {
 		priv->op = ntohl(nla_get_be32(tb[NFTA_BITWISE_OP]));
 		switch (priv->op) {
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index af9206a3afd1..5e7a7841b789 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -144,9 +144,16 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	return nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
-					&priv->dreg, NULL, NFT_DATA_VALUE,
-					priv->len);
+	err = nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
+				       &priv->dreg, NULL, NFT_DATA_VALUE,
+				       priv->len);
+	if (err < 0)
+		return err;
+
+	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+		return -EINVAL;
+
+	return 0;
 }
 
 static int nft_byteorder_dump(struct sk_buff *skb,
diff --git a/net/netfilter/xt_cpu.c b/net/netfilter/xt_cpu.c
index 3bdc302a0f91..9cb259902a58 100644
--- a/net/netfilter/xt_cpu.c
+++ b/net/netfilter/xt_cpu.c
@@ -34,7 +34,7 @@ static bool cpu_mt(const struct sk_buff *skb, struct xt_action_param *par)
 {
 	const struct xt_cpu_info *info = par->matchinfo;
 
-	return (info->cpu == smp_processor_id()) ^ info->invert;
+	return (info->cpu == raw_smp_processor_id()) ^ info->invert;
 }
 
 static struct xt_match cpu_mt_reg __read_mostly = {
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index 4d609d5cf406..c47f530b9ff7 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1482,9 +1482,14 @@ static void do_one_broadcast(struct sock *sk,
 		p->skb2 = NULL;
 		goto out;
 	}
-	NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
-	if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
-		NETLINK_CB(p->skb2).nsid_is_set = true;
+
+	NETLINK_CB(p->skb2).nsid_is_set = false;
+	if (!net_eq(sock_net(sk), p->net)) {
+		NETLINK_CB(p->skb2).nsid = peernet2id(sock_net(sk), p->net);
+		if (NETLINK_CB(p->skb2).nsid != NETNSA_NSID_NOT_ASSIGNED)
+			NETLINK_CB(p->skb2).nsid_is_set = true;
+	}
+
 	val = netlink_broadcast_deliver(sk, p->skb2);
 	if (val < 0) {
 		netlink_overrun(sk);
diff --git a/net/nfc/hci/core.c b/net/nfc/hci/core.c
index 0d33c81a15fe..ba6f0310ffd7 100644
--- a/net/nfc/hci/core.c
+++ b/net/nfc/hci/core.c
@@ -861,6 +861,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	struct sk_buff *frag_skb;
 	int msg_len;
 
+	if (!pskb_may_pull(skb, NFC_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)skb->data;
 	if ((packet->header & ~NFC_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&hdev->rx_hcp_frags, skb);
@@ -904,6 +909,11 @@ static void nfc_hci_recv_from_llc(struct nfc_hci_dev *hdev, struct sk_buff *skb)
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NFC_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct hcp_packet *)hcp_skb->data;
 	type = HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NFC_HCI_HCP_RESPONSE) {
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a878dd..dc65c719f35f 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1218,6 +1218,15 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 
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
 	/* Unlink from connecting and link to the client array */
 	nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	nfc_llcp_sock_link(&local->sockets, sk);
@@ -1229,6 +1238,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
 	sk->sk_state = LLCP_CONNECTED;
 	sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	nfc_llcp_sock_put(llcp_sock);
 }
 
diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index f1be1e84f665..feab29fc62f4 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -633,6 +633,8 @@ static int llcp_sock_release(struct socket *sock)
 
 	if (sock->type == SOCK_RAW)
 		nfc_llcp_sock_unlink(&local->raw_sockets, sk);
+	else if (sk->sk_state == LLCP_CONNECTING)
+		nfc_llcp_sock_unlink(&local->connecting_sockets, sk);
 	else
 		nfc_llcp_sock_unlink(&local->sockets, sk);
 
diff --git a/net/nfc/nci/hci.c b/net/nfc/nci/hci.c
index 40ae8e5a7ec7..c03e8a0bd3bd 100644
--- a/net/nfc/nci/hci.c
+++ b/net/nfc/nci/hci.c
@@ -439,6 +439,11 @@ void nci_hci_data_received_cb(void *context,
 		return;
 	}
 
+	if (!pskb_may_pull(skb, NCI_HCI_HCP_PACKET_HEADER_LEN)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)skb->data;
 	if ((packet->header & ~NCI_HCI_FRAGMENT) == 0) {
 		skb_queue_tail(&ndev->hci_dev->rx_hcp_frags, skb);
@@ -482,6 +487,11 @@ void nci_hci_data_received_cb(void *context,
 	 * unblock waiting cmd context. Otherwise, enqueue to dispatch
 	 * in separate context where handler can also execute command.
 	 */
+	if (!pskb_may_pull(hcp_skb, NCI_HCI_HCP_HEADER_LEN)) {
+		kfree_skb(hcp_skb);
+		return;
+	}
+
 	packet = (struct nci_hcp_packet *)hcp_skb->data;
 	type = NCI_HCP_MSG_GET_TYPE(packet->message.header);
 	if (type == NCI_HCI_HCP_RESPONSE) {
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 783367eea798..98f2165159d7 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -307,15 +307,16 @@ struct rxrpc_security {
 				    struct sk_buff *challenge);
 
 	/* verify a response */
-	int (*verify_response)(struct rxrpc_connection *,
-			       struct sk_buff *);
+	int (*verify_response)(struct rxrpc_connection *conn,
+			       struct sk_buff *response_skb,
+			       void *response, unsigned int len);
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
 
 	/* Default ticket -> key decoder */
 	int (*default_decode_ticket)(struct rxrpc_connection *conn, struct sk_buff *skb,
-				     unsigned int ticket_offset, unsigned int ticket_len,
+				     void *ticket, unsigned int ticket_len,
 				     struct key **_key);
 };
 
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 442414d90ba1..c96ca615b787 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -243,28 +243,22 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 static int rxrpc_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb)
 {
+	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
+	void *buffer;
 	int ret;
 
-	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
-	    skb_has_shared_frag(skb)) {
-		/* Copy the packet if shared so that we can do in-place
-		 * decryption.
-		 */
-		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
-
-		if (nskb) {
-			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
-			ret = conn->security->verify_response(conn, nskb);
-			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
-		} else {
-			/* OOM - Drop the packet. */
-			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
-			ret = -ENOMEM;
-		}
-	} else {
-		ret = conn->security->verify_response(conn, skb);
-	}
+	buffer = kmalloc(len, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, len);
+	if (ret < 0)
+		goto out;
+
+	ret = conn->security->verify_response(conn, skb, buffer, len);
 
+out:
+	kfree(buffer);
 	return ret;
 }
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 7a26c6097d03..0b39046bdc61 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -54,9 +54,10 @@ static int none_sendmsg_respond_to_challenge(struct sk_buff *challenge,
 }
 
 static int none_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *response_skb,
+				void *response, unsigned int len)
 {
-	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+	return rxrpc_abort_conn(conn, response_skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_response);
 }
 
diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
index f81703ee7ac3..a1ee102abae1 100644
--- a/net/rxrpc/rxgk.c
+++ b/net/rxrpc/rxgk.c
@@ -1084,11 +1084,12 @@ static int rxgk_sendmsg_respond_to_challenge(struct sk_buff *challenge,
  *	unsigned int call_numbers<>;
  * };
  */
-static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
-					const struct krb5_enctype *krb5,
-					struct sk_buff *skb,
-					__be32 *p, __be32 *end)
+static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
+				     const struct krb5_enctype *krb5,
+				     struct sk_buff *skb,
+				     void *auth, unsigned int auth_len)
 {
+	__be32 *p = auth, *end = auth + auth_len;
 	u32 app_len, call_count, level, epoch, cid, i;
 
 	_enter("");
@@ -1151,37 +1152,6 @@ static int rxgk_do_verify_authenticator(struct rxrpc_connection *conn,
 	return 0;
 }
 
-/*
- * Extract the authenticator and verify it.
- */
-static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
-				     const struct krb5_enctype *krb5,
-				     struct sk_buff *skb,
-				     unsigned int auth_offset, unsigned int auth_len)
-{
-	void *auth;
-	__be32 *p;
-	int ret;
-
-	auth = kmalloc(auth_len, GFP_NOFS);
-	if (!auth)
-		return -ENOMEM;
-
-	ret = skb_copy_bits(skb, auth_offset, auth, auth_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EPROTO,
-				       rxgk_abort_resp_short_auth);
-		goto error;
-	}
-
-	p = auth;
-	ret = rxgk_do_verify_authenticator(conn, krb5, skb, p,
-					   p + auth_len / sizeof(*p));
-error:
-	kfree(auth);
-	return ret;
-}
-
 /*
  * Verify a response.
  *
@@ -1192,49 +1162,45 @@ static int rxgk_verify_authenticator(struct rxrpc_connection *conn,
  * };
  */
 static int rxgk_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *skb,
+				void *buffer, unsigned int len)
 {
 	const struct krb5_enctype *krb5;
 	struct rxrpc_key_token *token;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
-	struct rxgk_response rhdr;
+	struct rxgk_response *rhdr;
 	struct rxgk_context *gk;
 	struct key *key = NULL;
-	unsigned int offset = sizeof(struct rxrpc_wire_header);
-	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
-	unsigned int token_offset, token_len;
-	unsigned int auth_offset, auth_len;
+	unsigned int resp_token_len, auth_len;
+	void *resp_token, *auth;
 	__be32 xauth_len;
 	int ret, ec;
 
 	_enter("{%d}", conn->debug_id);
 
 	/* Parse the RXGK_Response object */
-	if (sizeof(rhdr) + sizeof(__be32) > len)
-		goto short_packet;
-
-	if (skb_copy_bits(skb, offset, &rhdr, sizeof(rhdr)) < 0)
+	if (len < sizeof(*rhdr) + sizeof(__be32))
 		goto short_packet;
-	offset	+= sizeof(rhdr);
-	len	-= sizeof(rhdr);
-
-	token_offset	= offset;
-	token_len	= ntohl(rhdr.token_len);
-	if (token_len > len ||
-	    xdr_round_up(token_len) + sizeof(__be32) > len)
+	rhdr = buffer;
+	buffer	+= sizeof(*rhdr);
+	len	-= sizeof(*rhdr);
+
+	resp_token	= buffer;
+	resp_token_len	= ntohl(rhdr->token_len);
+	if (resp_token_len > len ||
+	    xdr_round_up(resp_token_len) + sizeof(__be32) > len)
 		goto short_packet;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, 0, sp->hdr.cksum, resp_token_len);
 
-	offset	+= xdr_round_up(token_len);
-	len	-= xdr_round_up(token_len);
+	buffer	+= xdr_round_up(resp_token_len);
+	len	-= xdr_round_up(resp_token_len);
 
-	if (skb_copy_bits(skb, offset, &xauth_len, sizeof(xauth_len)) < 0)
-		goto short_packet;
-	offset	+= sizeof(xauth_len);
+	xauth_len = *(__be32 *)buffer;
+	buffer	+= sizeof(xauth_len);
 	len	-= sizeof(xauth_len);
 
-	auth_offset	= offset;
+	auth		= buffer;
 	auth_len	= ntohl(xauth_len);
 	if (auth_len > len)
 		goto short_packet;
@@ -1249,7 +1215,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 * to the app to deal with - which might mean a round trip to
 	 * userspace.
 	 */
-	ret = rxgk_extract_token(conn, skb, token_offset, token_len, &key);
+	ret = rxgk_extract_token(conn, skb, resp_token, resp_token_len, &key);
 	if (ret < 0)
 		goto out;
 
@@ -1263,7 +1229,7 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 	 */
 	token = key->payload.data[0];
 	conn->security_level = token->rxgk->level;
-	conn->rxgk.start_time = __be64_to_cpu(rhdr.start_time);
+	conn->rxgk.start_time = __be64_to_cpu(rhdr->start_time);
 
 	gk = rxgk_generate_transport_key(conn, token->rxgk, sp->hdr.cksum, GFP_NOFS);
 	if (IS_ERR(gk)) {
@@ -1273,18 +1239,18 @@ static int rxgk_verify_response(struct rxrpc_connection *conn,
 
 	krb5 = gk->krb5;
 
-	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum, token_len);
+	trace_rxrpc_rx_response(conn, sp->hdr.serial, krb5->etype, sp->hdr.cksum,
+				resp_token_len);
 
 	/* Decrypt, parse and verify the authenticator. */
-	ret = rxgk_decrypt_skb(krb5, gk->resp_enc, skb,
-			       &auth_offset, &auth_len, &ec);
+	ret = rxgk_decrypt(krb5, gk->resp_enc, &auth, &auth_len, &ec);
 	if (ret < 0) {
 		rxrpc_abort_conn(conn, skb, RXGK_SEALEDINCON, ret,
 				 rxgk_abort_resp_auth_dec);
 		goto out_gk;
 	}
 
-	ret = rxgk_verify_authenticator(conn, krb5, skb, auth_offset, auth_len);
+	ret = rxgk_verify_authenticator(conn, krb5, skb, auth, auth_len);
 	if (ret < 0)
 		goto out_gk;
 
diff --git a/net/rxrpc/rxgk_app.c b/net/rxrpc/rxgk_app.c
index 0ef2a29eb695..200a30064fae 100644
--- a/net/rxrpc/rxgk_app.c
+++ b/net/rxrpc/rxgk_app.c
@@ -40,7 +40,7 @@
  * };
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *buffer, unsigned int ticket_len,
 			   struct key **_key)
 {
 	struct rxrpc_key_token *token;
@@ -49,7 +49,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	size_t pre_ticket_len, payload_len;
 	unsigned int klen, enctype;
 	void *payload, *ticket;
-	__be32 *t, *p, *q, tmp[2];
+	__be32 *t, *p, *q, *tmp;
 	int ret;
 
 	_enter("");
@@ -59,10 +59,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 					rxgk_abort_resp_short_yfs_tkt);
 
 	/* Get the session key length */
-	ret = skb_copy_bits(skb, ticket_offset, tmp, sizeof(tmp));
-	if (ret < 0)
-		return rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-					rxgk_abort_resp_short_yfs_klen);
+	tmp = buffer;
 	enctype = ntohl(tmp[0]);
 	klen = ntohl(tmp[1]);
 
@@ -84,12 +81,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * it.
 	 */
 	ticket = payload + pre_ticket_len;
-	ret = skb_copy_bits(skb, ticket_offset, ticket, ticket_len);
-	if (ret < 0) {
-		ret = rxrpc_abort_conn(conn, skb, RXGK_INCONSISTENCY, -EPROTO,
-				       rxgk_abort_resp_short_yfs_tkt);
-		goto error;
-	}
+	memcpy(ticket, buffer, ticket_len);
 
 	/* Fill out the form header. */
 	p = payload;
@@ -131,7 +123,7 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
 		goto error;
 	}
 
-	/* Ticket read in with skb_copy_bits above */
+	/* Ticket appended above. */
 	q += xdr_round_up(ticket_len) / 4;
 	if (WARN_ON((unsigned long)q - (unsigned long)payload != payload_len)) {
 		ret = -EIO;
@@ -182,14 +174,15 @@ int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
  * [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-afs-08 sec 6.1]
  */
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key)
 {
 	const struct krb5_enctype *krb5;
 	const struct krb5_buffer *server_secret;
 	struct crypto_aead *token_enc = NULL;
 	struct key *server_key;
-	unsigned int ticket_offset, ticket_len;
+	unsigned int ticket_len;
+	void *ticket;
 	u32 kvno, enctype;
 	int ret, ec = 0;
 
@@ -197,24 +190,23 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		__be32 kvno;
 		__be32 enctype;
 		__be32 token_len;
-	} container;
+	} *container;
 
-	if (token_len < sizeof(container))
+	if (token_len < sizeof(*container))
 		goto short_packet;
 
 	/* Decode the RXGK_TokenContainer object.  This tells us which server
 	 * key we should be using.  We can then fetch the key, get the secret
 	 * and set up the crypto to extract the token.
 	 */
-	if (skb_copy_bits(skb, token_offset, &container, sizeof(container)) < 0)
-		goto short_packet;
+	container = token;
+	token += sizeof(*container);
 
-	kvno		= ntohl(container.kvno);
-	enctype		= ntohl(container.enctype);
-	ticket_len	= ntohl(container.token_len);
-	ticket_offset	= token_offset + sizeof(container);
+	kvno		= ntohl(container->kvno);
+	enctype		= ntohl(container->enctype);
+	ticket_len	= ntohl(container->token_len);
 
-	if (ticket_len > xdr_round_down(token_len - sizeof(container)))
+	if (ticket_len > xdr_round_down(token_len - sizeof(*container)))
 		goto short_packet;
 
 	_debug("KVNO %u", kvno);
@@ -237,8 +229,8 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 	 * gain access to K0, from which we can derive the transport key and
 	 * thence decode the authenticator.
 	 */
-	ret = rxgk_decrypt_skb(krb5, token_enc, skb,
-			       &ticket_offset, &ticket_len, &ec);
+	ticket = token;
+	ret = rxgk_decrypt(krb5, token_enc, &ticket, &ticket_len, &ec);
 	crypto_free_aead(token_enc);
 	token_enc = NULL;
 	if (ret < 0) {
@@ -248,7 +240,7 @@ int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
 		return ret;
 	}
 
-	ret = conn->security->default_decode_ticket(conn, skb, ticket_offset,
+	ret = conn->security->default_decode_ticket(conn, skb, ticket,
 						    ticket_len, _key);
 	if (ret < 0)
 		goto cant_get_token;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
index 112b5366ce11..3deed5863f5a 100644
--- a/net/rxrpc/rxgk_common.h
+++ b/net/rxrpc/rxgk_common.h
@@ -41,10 +41,10 @@ struct rxgk_context {
  * rxgk_app.c
  */
 int rxgk_yfs_decode_ticket(struct rxrpc_connection *conn, struct sk_buff *skb,
-			   unsigned int ticket_offset, unsigned int ticket_len,
+			   void *ticket, unsigned int ticket_len,
 			   struct key **_key);
 int rxgk_extract_token(struct rxrpc_connection *conn, struct sk_buff *skb,
-		       unsigned int token_offset, unsigned int token_len,
+		       void *token, unsigned int token_len,
 		       struct key **_key);
 
 /*
@@ -61,50 +61,6 @@ int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
 			     const struct krb5_enctype **_krb5,
 			     gfp_t gfp);
 
-/*
- * Apply decryption and checksumming functions to part of an skbuff.  The
- * offset and length are updated to reflect the actual content of the encrypted
- * region.
- */
-static inline
-int rxgk_decrypt_skb(const struct krb5_enctype *krb5,
-		     struct crypto_aead *aead,
-		     struct sk_buff *skb,
-		     unsigned int *_offset, unsigned int *_len,
-		     int *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_decrypt(krb5, aead, sg, nr_sg,
-				  &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch. */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Apply decryption and checksumming functions a flat data buffer.  The data
  * point and length are updated to reflect the actual content of the encrypted
@@ -148,50 +104,6 @@ static inline int rxgk_decrypt(const struct krb5_enctype *krb5,
 	return ret;
 }
 
-/*
- * Check the MIC on a region of an skbuff.  The offset and length are updated
- * to reflect the actual content of the secure region.
- */
-static inline
-int rxgk_verify_mic_skb(const struct krb5_enctype *krb5,
-			struct crypto_shash *shash,
-			const struct krb5_buffer *metadata,
-			struct sk_buff *skb,
-			unsigned int *_offset, unsigned int *_len,
-			u32 *_error_code)
-{
-	struct scatterlist sg[16];
-	size_t offset = 0, len = *_len;
-	int nr_sg, ret;
-
-	sg_init_table(sg, ARRAY_SIZE(sg));
-	nr_sg = skb_to_sgvec(skb, sg, *_offset, len);
-	if (unlikely(nr_sg < 0))
-		return nr_sg;
-
-	ret = crypto_krb5_verify_mic(krb5, shash, metadata, sg, nr_sg,
-				     &offset, &len);
-	switch (ret) {
-	case 0:
-		*_offset += offset;
-		*_len = len;
-		break;
-	case -EBADMSG: /* Checksum mismatch */
-	case -EPROTO:
-		*_error_code = RXGK_SEALEDINCON;
-		break;
-	case -EMSGSIZE:
-		*_error_code = RXGK_PACKETSHORT;
-		break;
-	case -ENOPKG: /* Would prefer RXGK_BADETYPE, but not available for YFS. */
-	default:
-		*_error_code = RXGK_INCONSISTENCY;
-		break;
-	}
-
-	return ret;
-}
-
 /*
  * Check the MIC on a flat buffer.  The data pointer and length are updated to
  * reflect the actual content of the secure region.
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 075936337836..6fbd883401ac 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -963,7 +963,6 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1112,14 +1111,15 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
  * verify a response
  */
 static int rxkad_verify_response(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
+				 struct sk_buff *skb,
+				 void *buffer, unsigned int len)
 {
 	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket = NULL;
+	void *ticket;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1142,13 +1142,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 		}
 	}
 
-	ret = -ENOMEM;
-	response = kzalloc_obj(struct rxkad_response, GFP_NOFS);
-	if (!response)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  response, sizeof(*response)) < 0) {
+	response = buffer;
+	if (len < sizeof(*response)) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short);
 		goto error;
@@ -1160,6 +1155,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1179,13 +1177,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
-	ret = -ENOMEM;
-	ticket = kmalloc(ticket_len, GFP_NOFS);
-	if (!ticket)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
-			  ticket, ticket_len) < 0) {
+	ticket = buffer;
+	if (ticket_len > len) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short_tkt);
 		goto error;
@@ -1265,8 +1258,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 2c5a7a321a94..553342c55cf7 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -26,6 +26,10 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_wrapper.h>
 
+#define MIRRED_DEFER_LIMIT 3
+_Static_assert(MIRRED_DEFER_LIMIT <= 3,
+	       "MIRRED_DEFER_LIMIT exceeds tc_depth bitfield width");
+
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
@@ -234,12 +238,15 @@ tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
-	if (!want_ingress)
+	if (!want_ingress) {
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (!at_ingress)
-		err = netif_rx(skb);
-	else
-		err = netif_receive_skb(skb);
+	} else {
+		skb->tc_depth++;
+		if (!at_ingress)
+			err = netif_rx(skb);
+		else
+			err = netif_receive_skb(skb);
+	}
 
 	return err;
 }
@@ -365,7 +372,8 @@ static int tcf_blockcast_redir(struct sk_buff *skb, struct tcf_mirred *m,
 					 dev_is_mac_header_xmit(dev_prev),
 					 m_eaction, retval);
 
-	return retval;
+	/* If the packet wasn't redirected, we have to register as a drop */
+	return TC_ACT_SHOT;
 }
 
 static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
@@ -389,14 +397,12 @@ static int tcf_blockcast_mirror(struct sk_buff *skb, struct tcf_mirred *m,
 
 static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 			 const u32 blockid, struct tcf_result *res,
-			 int retval)
+			 int m_eaction, int retval)
 {
 	const u32 exception_ifindex = skb->dev->ifindex;
 	struct tcf_block *block;
 	bool is_redirect;
-	int m_eaction;
 
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 
 	/* we are already under rcu protection, so can call block lookup
@@ -405,7 +411,7 @@ static int tcf_blockcast(struct sk_buff *skb, struct tcf_mirred *m,
 	block = tcf_block_lookup(dev_net(skb->dev), blockid);
 	if (!block || xa_empty(&block->ports)) {
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		return is_redirect ? TC_ACT_SHOT : retval;
 	}
 
 	if (is_redirect)
@@ -423,9 +429,10 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 {
 	struct tcf_mirred *m = to_mirred(a);
 	int retval = READ_ONCE(m->tcf_action);
+	bool m_mac_header_xmit, is_redirect;
 	struct netdev_xmit *xmit;
-	bool m_mac_header_xmit;
 	struct net_device *dev;
+	bool want_ingress;
 	int i, m_eaction;
 	u32 blockid;
 
@@ -434,7 +441,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT ||
+		     skb->tc_depth >= MIRRED_DEFER_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
@@ -444,34 +452,51 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	tcf_action_update_bstats(&m->common, skb);
 
 	blockid = READ_ONCE(m->tcfm_blockid);
-	if (blockid)
-		return tcf_blockcast(skb, m, blockid, res, retval);
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	if (blockid) {
+		if (!want_ingress)
+			xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = NULL;
+		retval = tcf_blockcast(skb, m, blockid, res, m_eaction, retval);
+		if (!want_ingress)
+			xmit->sched_mirred_nest--;
+		return retval;
+	}
+
+	is_redirect = tcf_mirred_is_act_redirect(m_eaction);
 
 	dev = rcu_dereference_bh(m->tcfm_dev);
 	if (unlikely(!dev)) {
 		pr_notice_once("tc mirred: target device is gone\n");
 		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
-	}
-	for (i = 0; i < xmit->sched_mirred_nest; i++) {
-		if (xmit->sched_mirred_dev[i] != dev)
-			continue;
-		pr_notice_once("tc mirred: loop on device %s\n",
-			       netdev_name(dev));
-		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
+		goto err_out;
 	}
 
-	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	if (!want_ingress) {
+		for (i = 0; i < xmit->sched_mirred_nest; i++) {
+			if (xmit->sched_mirred_dev[i] != dev)
+				continue;
+			pr_notice_once("tc mirred: loop on device %s\n",
+				       netdev_name(dev));
+			tcf_action_inc_overlimit_qstats(&m->common);
+			goto err_out;
+		}
+		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	}
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 
 	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
 				   retval);
-	xmit->sched_mirred_nest--;
+	if (!want_ingress)
+		xmit->sched_mirred_nest--;
 
 	return retval;
+
+err_out:
+	if (is_redirect)
+		retval = TC_ACT_SHOT;
+	return retval;
 }
 
 static void tcf_stats_update(struct tc_action *a, u64 bytes, u64 packets,
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index bc18e1976b6e..17a79fe2f091 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && skb->tc_depth == 0 &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -540,11 +541,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		skb2->tc_depth++; /* prevent duplicating a dup... */
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
@@ -1007,41 +1006,6 @@ static int parse_attr(struct nlattr *tb[], int maxtype, struct nlattr *nla,
 	return 0;
 }
 
-static const struct Qdisc_class_ops netem_class_ops;
-
-static int check_netem_in_tree(struct Qdisc *sch, bool duplicates,
-			       struct netlink_ext_ack *extack)
-{
-	struct Qdisc *root, *q;
-	unsigned int i;
-
-	root = qdisc_root_sleeping(sch);
-
-	if (sch != root && root->ops->cl_ops == &netem_class_ops) {
-		if (duplicates ||
-		    ((struct netem_sched_data *)qdisc_priv(root))->duplicate)
-			goto err;
-	}
-
-	if (!qdisc_dev(root))
-		return 0;
-
-	hash_for_each(qdisc_dev(root)->qdisc_hash, i, q, hash) {
-		if (sch != q && q->ops->cl_ops == &netem_class_ops) {
-			if (duplicates ||
-			    ((struct netem_sched_data *)qdisc_priv(q))->duplicate)
-				goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	NL_SET_ERR_MSG(extack,
-		       "netem: cannot mix duplicating netems with other netems in tree");
-	return -EINVAL;
-}
-
 /* Parse netlink message to set options */
 static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 			struct netlink_ext_ack *extack)
@@ -1118,11 +1082,6 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	q->gap = qopt->gap;
 	q->counter = 0;
 	q->loss = qopt->loss;
-
-	ret = check_netem_in_tree(sch, qopt->duplicate, extack);
-	if (ret)
-		goto unlock;
-
 	q->duplicate = qopt->duplicate;
 
 	/* for compatibility with earlier versions.
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 00286c930b8d..14ac88977847 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -441,7 +441,7 @@ static struct sk_buff *sfb_dequeue(struct Qdisc *sch)
 	struct Qdisc *child = q->qdisc;
 	struct sk_buff *skb;
 
-	skb = child->dequeue(q->qdisc);
+	skb = qdisc_dequeue_peeked(child);
 
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index aeffa10ff2d3..59e04788e1c7 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -9403,6 +9403,8 @@ static int sctp_wait_for_connect(struct sctp_association *asoc, long *timeo_p)
 		release_sock(sk);
 		current_timeo = schedule_timeout(current_timeo);
 		lock_sock(sk);
+		if (sk != asoc->base.sk)
+			goto do_error;
 
 		*timeo_p = current_timeo;
 	}
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f744f7911217..de034a3e5d80 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -188,10 +188,12 @@ static bool smc_hs_congested(const struct sock *sk)
 
 struct smc_hashinfo smc_v4_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v4_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 struct smc_hashinfo smc_v6_hashinfo = {
 	.lock = __RW_LOCK_UNLOCKED(smc_v6_hashinfo.lock),
+	.ht = HLIST_HEAD_INIT,
 };
 
 int smc_hash_sk(struct sock *sk)
@@ -3522,8 +3524,6 @@ static int __init smc_init(void)
 		pr_err("%s: sock_register fails with %d\n", __func__, rc);
 		goto out_proto6;
 	}
-	INIT_HLIST_HEAD(&smc_v4_hashinfo.ht);
-	INIT_HLIST_HEAD(&smc_v6_hashinfo.ht);
 
 	rc = smc_ib_register_client();
 	if (rc) {
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 08f4dfb9782c..0a93873eb467 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -628,7 +628,7 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
 		 */
 		sock_reset_flag(sk, SOCK_DONE);
 		sk->sk_state = TCP_CLOSE;
-		vsk->peer_shutdown = 0;
+		WRITE_ONCE(vsk->peer_shutdown, 0);
 	}
 
 	if (sk->sk_type == SOCK_SEQPACKET) {
@@ -919,7 +919,7 @@ static struct sock *__vsock_create(struct net *net,
 	vsk->rejected = false;
 	vsk->sent_request = false;
 	vsk->ignore_connecting_rst = false;
-	vsk->peer_shutdown = 0;
+	WRITE_ONCE(vsk->peer_shutdown, 0);
 	INIT_DELAYED_WORK(&vsk->connect_work, vsock_connect_timeout);
 	INIT_DELAYED_WORK(&vsk->pending_work, vsock_pending_work);
 
@@ -1227,6 +1227,25 @@ static int vsock_shutdown(struct socket *sock, int mode)
 	return err;
 }
 
+static __poll_t vsock_poll_shutdown(struct sock *sk, u32 peer_shutdown)
+{
+	__poll_t mask = 0;
+
+	/* INET sockets treat local write shutdown and peer write shutdown as a
+	 * case of EPOLLHUP set.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK ||
+	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
+	     (peer_shutdown & SEND_SHUTDOWN)))
+		mask |= EPOLLHUP;
+
+	if (sk->sk_shutdown & RCV_SHUTDOWN ||
+	    peer_shutdown & SEND_SHUTDOWN)
+		mask |= EPOLLRDHUP;
+
+	return mask;
+}
+
 static __poll_t vsock_poll(struct file *file, struct socket *sock,
 			       poll_table *wait)
 {
@@ -1244,24 +1263,17 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		/* Signify that there has been an error on this socket. */
 		mask |= EPOLLERR;
 
-	/* INET sockets treat local write shutdown and peer write shutdown as a
-	 * case of EPOLLHUP set.
-	 */
-	if ((sk->sk_shutdown == SHUTDOWN_MASK) ||
-	    ((sk->sk_shutdown & SEND_SHUTDOWN) &&
-	     (vsk->peer_shutdown & SEND_SHUTDOWN))) {
-		mask |= EPOLLHUP;
-	}
-
-	if (sk->sk_shutdown & RCV_SHUTDOWN ||
-	    vsk->peer_shutdown & SEND_SHUTDOWN) {
-		mask |= EPOLLRDHUP;
-	}
-
 	if (sk_is_readable(sk))
 		mask |= EPOLLIN | EPOLLRDNORM;
 
 	if (sock->type == SOCK_DGRAM) {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
+		/* DGRAM sockets do not take lock_sock() in poll(), so use one
+		 * lockless snapshot for all shutdown-derived mask bits.
+		 */
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
+
 		/* For datagram sockets we can read if there is something in
 		 * the queue and write as long as the socket isn't shutdown for
 		 * sending.
@@ -1276,6 +1288,7 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 
 	} else if (sock_type_connectible(sk->sk_type)) {
 		const struct vsock_transport *transport;
+		u32 peer_shutdown;
 
 		lock_sock(sk);
 
@@ -1308,8 +1321,10 @@ static __poll_t vsock_poll(struct file *file, struct socket *sock,
 		 * terminated should also be considered read, and we check the
 		 * shutdown flag for that.
 		 */
+		peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+		mask |= vsock_poll_shutdown(sk, peer_shutdown);
 		if (sk->sk_shutdown & RCV_SHUTDOWN ||
-		    vsk->peer_shutdown & SEND_SHUTDOWN) {
+		    peer_shutdown & SEND_SHUTDOWN) {
 			mask |= EPOLLIN | EPOLLRDNORM;
 		}
 
diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index d5b0fd0a8897..842510f7dda2 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -264,7 +264,7 @@ static void hvs_do_close_lock_held(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -593,7 +593,9 @@ static int hvs_update_recv_data(struct hvsock *hvs)
 		return -EIO;
 
 	if (payload_len == 0)
-		hvs->vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(hvs->vsk->peer_shutdown,
+			   READ_ONCE(hvs->vsk->peer_shutdown) |
+			   SEND_SHUTDOWN);
 
 	hvs->recv_data_len = payload_len;
 	hvs->recv_data_off = 0;
@@ -736,7 +738,8 @@ static s64 hvs_stream_has_data(struct vsock_sock *vsk)
 			return ret;
 		return hvs->recv_data_len;
 	case 0:
-		vsk->peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown,
+			   READ_ONCE(vsk->peer_shutdown) | SEND_SHUTDOWN);
 		ret = 0;
 		break;
 	default: /* -1 */
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index e8fb2e20db0f..abe7bfcedc5a 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -207,6 +207,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
 static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 						  size_t payload_len,
 						  bool zcopy,
+						  struct ubuf_info *uarg,
 						  u32 src_cid,
 						  u32 src_port,
 						  u32 dst_cid,
@@ -247,6 +248,12 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
 	if (info->msg && payload_len > 0) {
 		int err;
 
+		/* Bind the zerocopy lifetime before filling frags so error
+		 * rollback frees managed fixed-buffer pages through
+		 * the uarg-aware path.
+		 */
+		skb_zcopy_set(skb, uarg, NULL);
+
 		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
 		if (err)
 			goto out;
@@ -366,6 +373,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 		skb_len = min(max_skb_len, rest_len);
 
 		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
+						 uarg,
 						 src_cid, src_port,
 						 dst_cid, dst_port);
 		if (!skb) {
@@ -373,8 +381,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 			break;
 		}
 
-		skb_zcopy_set(skb, uarg, NULL);
-
 		virtio_transport_inc_tx_pkt(vvs, skb);
 
 		ret = t_ops->send_pkt(skb, info->net);
@@ -1176,7 +1182,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 	if (!t)
 		return -ENOTCONN;
 
-	reply = virtio_transport_alloc_skb(&info, 0, false,
+	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
 					   le64_to_cpu(hdr->dst_cid),
 					   le32_to_cpu(hdr->dst_port),
 					   le64_to_cpu(hdr->src_cid),
@@ -1221,7 +1227,7 @@ static void virtio_transport_do_close(struct vsock_sock *vsk,
 	struct sock *sk = sk_vsock(vsk);
 
 	sock_set_flag(sk, SOCK_DONE);
-	vsk->peer_shutdown = SHUTDOWN_MASK;
+	WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 	if (vsock_stream_has_data(vsk) <= 0)
 		sk->sk_state = TCP_CLOSING;
 	sk->sk_state_change(sk);
@@ -1424,12 +1430,15 @@ virtio_transport_recv_connected(struct sock *sk,
 	case VIRTIO_VSOCK_OP_CREDIT_UPDATE:
 		sk->sk_write_space(sk);
 		break;
-	case VIRTIO_VSOCK_OP_SHUTDOWN:
+	case VIRTIO_VSOCK_OP_SHUTDOWN: {
+		u32 peer_shutdown = READ_ONCE(vsk->peer_shutdown);
+
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
-			vsk->peer_shutdown |= RCV_SHUTDOWN;
+			peer_shutdown |= RCV_SHUTDOWN;
 		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
-			vsk->peer_shutdown |= SEND_SHUTDOWN;
-		if (vsk->peer_shutdown == SHUTDOWN_MASK) {
+			peer_shutdown |= SEND_SHUTDOWN;
+		WRITE_ONCE(vsk->peer_shutdown, peer_shutdown);
+		if (peer_shutdown == SHUTDOWN_MASK) {
 			if (vsock_stream_has_data(vsk) <= 0 && !sock_flag(sk, SOCK_DONE)) {
 				(void)virtio_transport_reset(vsk, NULL);
 				virtio_transport_do_close(vsk, true);
@@ -1444,6 +1453,7 @@ virtio_transport_recv_connected(struct sock *sk,
 		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
 			sk->sk_state_change(sk);
 		break;
+	}
 	case VIRTIO_VSOCK_OP_RST:
 		virtio_transport_do_close(vsk, true);
 		break;
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index d2579380f51e..5c1ecd5bfdbc 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -819,7 +819,7 @@ static void vmci_transport_handle_detach(struct sock *sk)
 		/* On a detach the peer will not be sending or receiving
 		 * anymore.
 		 */
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 
 		/* We should not be sending anymore since the peer won't be
 		 * there to receive, but we can still receive if there is data
@@ -1542,7 +1542,9 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		if (pkt->u.mode) {
 			vsk = vsock_sk(sk);
 
-			vsk->peer_shutdown |= pkt->u.mode;
+			WRITE_ONCE(vsk->peer_shutdown,
+				   READ_ONCE(vsk->peer_shutdown) |
+				   pkt->u.mode);
 			sk->sk_state_change(sk);
 		}
 		break;
@@ -1559,7 +1561,7 @@ static int vmci_transport_recv_connected(struct sock *sk,
 		 * a clean shutdown.
 		 */
 		sock_set_flag(sk, SOCK_DONE);
-		vsk->peer_shutdown = SHUTDOWN_MASK;
+		WRITE_ONCE(vsk->peer_shutdown, SHUTDOWN_MASK);
 		if (vsock_stream_has_data(vsk) <= 0)
 			sk->sk_state = TCP_CLOSING;
 
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..e4c2cd24936d 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -797,9 +797,12 @@ static void xfrm_trans_reinject(struct work_struct *work)
 	spin_unlock_bh(&trans->queue_lock);
 
 	local_bh_disable();
-	while ((skb = __skb_dequeue(&queue)))
-		XFRM_TRANS_SKB_CB(skb)->finish(XFRM_TRANS_SKB_CB(skb)->net,
-					       NULL, skb);
+	while ((skb = __skb_dequeue(&queue))) {
+		struct net *net = XFRM_TRANS_SKB_CB(skb)->net;
+
+		XFRM_TRANS_SKB_CB(skb)->finish(net, NULL, skb);
+		put_net(net);
+	}
 	local_bh_enable();
 }
 
@@ -808,6 +811,7 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 				       struct sk_buff *))
 {
 	struct xfrm_trans_tasklet *trans;
+	struct net *hold_net;
 
 	trans = this_cpu_ptr(&xfrm_trans_tasklet);
 
@@ -816,8 +820,12 @@ int xfrm_trans_queue_net(struct net *net, struct sk_buff *skb,
 
 	BUILD_BUG_ON(sizeof(struct xfrm_trans_cb) > sizeof(skb->cb));
 
+	hold_net = maybe_get_net(net);
+	if (!hold_net)
+		return -ENODEV;
+
 	XFRM_TRANS_SKB_CB(skb)->finish = finish;
-	XFRM_TRANS_SKB_CB(skb)->net = net;
+	XFRM_TRANS_SKB_CB(skb)->net = hold_net;
 	spin_lock_bh(&trans->queue_lock);
 	__skb_queue_tail(&trans->queue, skb);
 	spin_unlock_bh(&trans->queue_lock);
diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
index 5f38dff16177..671d48f8c937 100644
--- a/net/xfrm/xfrm_ipcomp.c
+++ b/net/xfrm/xfrm_ipcomp.c
@@ -51,11 +51,15 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 	struct scatterlist *dsg;
 	int len, dlen;
 
-	if (unlikely(err))
-		goto out_free_req;
+	if (unlikely(!req))
+		return err;
 
 	extra = acomp_request_extra(req);
 	dsg = extra->sg;
+
+	if (unlikely(err))
+		goto out_free_req;
+
 	dlen = req->dlen;
 
 	pskb_trim_unique(skb, 0);
@@ -84,10 +88,10 @@ static int ipcomp_post_acomp(struct sk_buff *skb, int err, int hlen)
 		skb_shinfo(skb)->nr_frags++;
 	} while ((dlen -= len));
 
-	for (; dsg; dsg = sg_next(dsg))
+out_free_req:
+	for (; dsg && sg_page(dsg); dsg = sg_next(dsg))
 		__free_page(sg_page(dsg));
 
-out_free_req:
 	acomp_request_free(req);
 	return err;
 }
diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 97bc979e55ba..6c6bbc040517 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -2650,7 +2650,8 @@ static void __iptfs_init_state(struct xfrm_state *x,
 	x->props.enc_hdr_len = sizeof(struct ip_iptfs_hdr);
 
 	/* Always keep a module reference when x->mode_data is set */
-	__module_get(x->mode_cbs->owner);
+	if (x->mode_data != xtfs)
+		__module_get(x->mode_cbs->owner);
 
 	x->mode_data = xtfs;
 	xtfs->x = x;
@@ -2658,22 +2659,39 @@ static void __iptfs_init_state(struct xfrm_state *x,
 
 static int iptfs_clone_state(struct xfrm_state *x, struct xfrm_state *orig)
 {
+	struct skb_wseq *w_saved = NULL;
 	struct xfrm_iptfs_data *xtfs;
 
 	xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
 	if (!xtfs)
 		return -ENOMEM;
 
-	xtfs->ra_newskb = NULL;
 	if (xtfs->cfg.reorder_win_size) {
-		xtfs->w_saved = kzalloc_objs(*xtfs->w_saved,
-					     xtfs->cfg.reorder_win_size);
-		if (!xtfs->w_saved) {
+		w_saved = kzalloc_objs(*w_saved, xtfs->cfg.reorder_win_size);
+		if (!w_saved) {
 			kfree_sensitive(xtfs);
 			return -ENOMEM;
 		}
 	}
+	xtfs->w_saved = w_saved;
+
+	__skb_queue_head_init(&xtfs->queue);
+	xtfs->queue_size = 0;
+	hrtimer_setup(&xtfs->iptfs_timer, iptfs_delay_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
+
+	spin_lock_init(&xtfs->drop_lock);
+	hrtimer_setup(&xtfs->drop_timer, iptfs_drop_timer, CLOCK_MONOTONIC,
+		      IPTFS_HRTIMER_MODE);
 
+	xtfs->w_seq_set = false;
+	xtfs->w_wantseq = 0;
+	xtfs->w_savedlen = 0;
+	xtfs->ra_newskb = NULL;
+	xtfs->ra_wantseq = 0;
+	xtfs->ra_runtlen = 0;
+
+	__module_get(x->mode_cbs->owner);
 	x->mode_data = xtfs;
 	xtfs->x = x;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a872af5610dc..d904352fb242 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4276,21 +4276,21 @@ static int __net_init xfrm_policy_init(struct net *net)
 	return -ENOMEM;
 }
 
-static void xfrm_policy_fini(struct net *net)
+static void __net_exit xfrm_net_pre_exit(struct net *net)
 {
-	struct xfrm_pol_inexact_bin *b, *t;
-	unsigned int sz;
-	int dir;
-
 	disable_work_sync(&net->xfrm.policy_hthresh.work);
-
 	flush_work(&net->xfrm.policy_hash_work);
 #ifdef CONFIG_XFRM_SUB_POLICY
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_SUB, false);
 #endif
 	xfrm_policy_flush(net, XFRM_POLICY_TYPE_MAIN, false);
+}
 
-	synchronize_rcu();
+static void xfrm_policy_fini(struct net *net)
+{
+	struct xfrm_pol_inexact_bin *b, *t;
+	unsigned int sz;
+	int dir;
 
 	WARN_ON(!list_empty(&net->xfrm.policy_all));
 
@@ -4368,6 +4368,7 @@ static void __net_exit xfrm_net_exit(struct net *net)
 
 static struct pernet_operations __net_initdata xfrm_net_ops = {
 	.init = xfrm_net_init,
+	.pre_exit = xfrm_net_pre_exit,
 	.exit = xfrm_net_exit,
 };
 
@@ -4703,7 +4704,7 @@ int xfrm_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	}
 
 	/* Stage 5 - announce */
-	km_migrate(sel, dir, type, m, num_migrate, k, encap);
+	km_migrate(sel, dir, type, m, num_migrate, k, net, encap);
 
 	xfrm_pol_put(pol);
 
diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index 686014d39429..589c3b6e4679 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -2837,7 +2837,7 @@ EXPORT_SYMBOL(km_policy_expired);
 #ifdef CONFIG_XFRM_MIGRATE
 int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	       const struct xfrm_migrate *m, int num_migrate,
-	       const struct xfrm_kmaddress *k,
+	       const struct xfrm_kmaddress *k, struct net *net,
 	       const struct xfrm_encap_tmpl *encap)
 {
 	int err = -EINVAL;
@@ -2848,7 +2848,7 @@ int km_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 	list_for_each_entry_rcu(km, &xfrm_km_list, list) {
 		if (km->migrate) {
 			ret = km->migrate(sel, dir, type, m, num_migrate, k,
-					  encap);
+					  net, encap);
 			if (!ret)
 				err = ret;
 		}
@@ -3114,10 +3114,14 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 	const struct xfrm_type *type = READ_ONCE(x->type);
 	struct crypto_aead *aead;
 	u32 blksize, net_adj = 0;
+	u32 overhead, payload_mtu;
 
 	if (x->km.state != XFRM_STATE_VALID ||
-	    !type || type->proto != IPPROTO_ESP)
+	    !type || type->proto != IPPROTO_ESP) {
+		if (mtu <= x->props.header_len)
+			return 1;
 		return mtu - x->props.header_len;
+	}
 
 	aead = x->data;
 	blksize = ALIGN(crypto_aead_blocksize(aead), 4);
@@ -3140,8 +3144,17 @@ u32 xfrm_state_mtu(struct xfrm_state *x, int mtu)
 		break;
 	}
 
-	return ((mtu - x->props.header_len - crypto_aead_authsize(aead) -
-		 net_adj) & ~(blksize - 1)) + net_adj - 2;
+	overhead = x->props.header_len + crypto_aead_authsize(aead) + net_adj;
+	if (mtu <= overhead)
+		return 1;
+
+	payload_mtu = mtu - overhead;
+	payload_mtu &= ~(blksize - 1);
+	if (payload_mtu <= 2)
+		return 1;
+
+	return payload_mtu + net_adj - 2;
+
 }
 EXPORT_SYMBOL_GPL(xfrm_state_mtu);
 
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 38a90e5ee3d9..71a4b7278eba 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3271,10 +3271,9 @@ static int build_migrate(struct sk_buff *skb, const struct xfrm_migrate *m,
 
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
-	struct net *net = &init_net;
 	struct sk_buff *skb;
 	int err;
 
@@ -3292,7 +3291,7 @@ static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 #else
 static int xfrm_send_migrate(const struct xfrm_selector *sel, u8 dir, u8 type,
 			     const struct xfrm_migrate *m, int num_migrate,
-			     const struct xfrm_kmaddress *k,
+			     const struct xfrm_kmaddress *k, struct net *net,
 			     const struct xfrm_encap_tmpl *encap)
 {
 	return -ENOPROTOOPT;
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index 6af26ec2ecfd..b1b4c7d017be 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2968,8 +2968,10 @@ static void snd_pcm_oss_proc_read(struct snd_info_entry *entry,
 				  struct snd_info_buffer *buffer)
 {
 	struct snd_pcm_str *pstr = entry->private_data;
-	struct snd_pcm_oss_setup *setup = pstr->oss.setup_list;
+	struct snd_pcm_oss_setup *setup;
+
 	guard(mutex)(&pstr->oss.setup_mutex);
+	setup = pstr->oss.setup_list;
 	while (setup) {
 		snd_iprintf(buffer, "%s %u %u%s%s%s%s%s%s\n",
 			    setup->task_name,
@@ -3054,6 +3056,13 @@ static void snd_pcm_oss_proc_write(struct snd_info_entry *entry,
 				buffer->error = -ENOMEM;
 				return;
 			}
+			template.task_name = kstrdup(task_name, GFP_KERNEL);
+			if (!template.task_name) {
+				kfree(setup);
+				buffer->error = -ENOMEM;
+				return;
+			}
+			*setup = template;
 			if (pstr->oss.setup_list == NULL)
 				pstr->oss.setup_list = setup;
 			else {
@@ -3061,12 +3070,7 @@ static void snd_pcm_oss_proc_write(struct snd_info_entry *entry,
 				     setup1->next; setup1 = setup1->next);
 				setup1->next = setup;
 			}
-			template.task_name = kstrdup(task_name, GFP_KERNEL);
-			if (! template.task_name) {
-				kfree(setup);
-				buffer->error = -ENOMEM;
-				return;
-			}
+			continue;
 		}
 		*setup = template;
 	}
diff --git a/sound/firewire/motu/motu-register-dsp-message-parser.c b/sound/firewire/motu/motu-register-dsp-message-parser.c
index a8053e3ef065..4ec23e6880d9 100644
--- a/sound/firewire/motu/motu-register-dsp-message-parser.c
+++ b/sound/firewire/motu/motu-register-dsp-message-parser.c
@@ -386,6 +386,8 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 {
 	struct msg_parser *parser = motu->message_parser;
 
+	guard(spinlock_irqsave)(&parser->lock);
+
 	if (parser->pull_pos > parser->push_pos)
 		return EVENT_QUEUE_SIZE - parser->pull_pos + parser->push_pos;
 	else
@@ -395,13 +397,14 @@ unsigned int snd_motu_register_dsp_message_parser_count_event(struct snd_motu *m
 bool snd_motu_register_dsp_message_parser_copy_event(struct snd_motu *motu, u32 *event)
 {
 	struct msg_parser *parser = motu->message_parser;
-	unsigned int pos = parser->pull_pos;
-
-	if (pos == parser->push_pos)
-		return false;
+	unsigned int pos;
 
 	guard(spinlock_irqsave)(&parser->lock);
 
+	if (parser->pull_pos == parser->push_pos)
+		return false;
+
+	pos = parser->pull_pos;
 	*event = parser->event_queue[pos];
 
 	++pos;
diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c59021c15d66..04064ffd820c 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4132,6 +4132,7 @@ enum {
 	ALC245_FIXUP_ACER_MICMUTE_LED,
 	ALC245_FIXUP_CS35L41_I2C_2_MUTE_LED,
 	ALC236_FIXUP_HP_DMIC,
+	ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX,
 };
 
 /* A special fixup for Lenovo C940 and Yoga Duet 7;
@@ -6678,6 +6679,12 @@ static const struct hda_fixup alc269_fixups[] = {
 			{ 0x12, 0x90a60160 }, /* use as internal mic */
 			{ }
 		},
+	},
+	[ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = cs35l41_fixup_i2c_two,
+		.chained = true,
+		.chain_id = ALC245_FIXUP_HP_X360_MUTE_LEDS
 	}
 };
 
@@ -7096,7 +7103,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8be6, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8be7, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8be8, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8be9, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8be9, "HP Envy x360 2-in-1 Laptop 15-fh0xxx", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8c15, "HP Spectre x360 2-in-1 Laptop 14-eu0xxx", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8c16, "HP Spectre x360 2-in-1 Laptop 16-aa0xxx", ALC245_FIXUP_HP_SPECTRE_X360_16_AA0XXX),
@@ -7175,7 +7182,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
@@ -7260,6 +7267,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x11c0, "ASUS X556UR", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	HDA_CODEC_QUIRK(0x1043, 0x1204, "ASUS Strix G16 G615JMR", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1204, "ASUS Strix G615JHR_JMR_JPR", ALC287_FIXUP_TAS2781_I2C),
+	HDA_CODEC_QUIRK(0x1043, 0x1214, "ASUS ROG Strix G615LP", ALC287_FIXUP_TXNW2781_I2C_ASUS),
 	SND_PCI_QUIRK(0x1043, 0x1214, "ASUS Strix G615LH_LM_LP", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x1043, 0x125e, "ASUS Q524UQK", ALC255_FIXUP_ASUS_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1043, 0x1271, "ASUS X430UN", ALC256_FIXUP_ASUS_MIC_NO_PRESENCE),
diff --git a/sound/hda/codecs/side-codecs/cs35l56_hda.c b/sound/hda/codecs/side-codecs/cs35l56_hda.c
index cdbc576569ef..a0ea08eb96a9 100644
--- a/sound/hda/codecs/side-codecs/cs35l56_hda.c
+++ b/sound/hda/codecs/side-codecs/cs35l56_hda.c
@@ -1025,7 +1025,7 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 	u32 values[HDA_MAX_COMPONENTS];
 	char hid_string[8];
 	struct acpi_device *adev;
-	const char *property, *sub;
+	const char *property;
 	int i, ret;
 
 	/*
@@ -1047,7 +1047,8 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 	/* Initialize things that could be overwritten by a fixup */
 	cs35l56->index = -1;
 
-	sub = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
+	const char *sub __free(kfree) = acpi_get_subsystem_id(ACPI_HANDLE(cs35l56->base.dev));
+
 	ret = cs35l56_hda_apply_platform_fixups(cs35l56, sub, &id);
 	if (ret)
 		return ret;
@@ -1095,15 +1096,16 @@ static int cs35l56_hda_read_acpi(struct cs35l56_hda *cs35l56, int hid, int id)
 		ret = cirrus_scodec_get_speaker_id(cs35l56->base.dev, cs35l56->index,
 						   cs35l56->num_amps, -1);
 		if (ret == -ENOENT) {
-			cs35l56->system_name = sub;
+			cs35l56->system_name = devm_kstrdup(cs35l56->base.dev, sub, GFP_KERNEL);
 		} else if (ret >= 0) {
-			cs35l56->system_name = kasprintf(GFP_KERNEL, "%s-spkid%d", sub, ret);
-			kfree(sub);
-			if (!cs35l56->system_name)
-				return -ENOMEM;
+			cs35l56->system_name = devm_kasprintf(cs35l56->base.dev, GFP_KERNEL,
+							      "%s-spkid%d", sub, ret);
 		} else {
 			return ret;
 		}
+
+		if (!cs35l56->system_name)
+			return -ENOMEM;
 	}
 
 	cs35l56->base.reset_gpio = devm_gpiod_get_index_optional(cs35l56->base.dev,
@@ -1254,7 +1256,6 @@ void cs35l56_hda_remove(struct device *dev)
 
 	cs_dsp_remove(&cs35l56->cs_dsp);
 
-	kfree(cs35l56->system_name);
 	pm_runtime_put_noidle(cs35l56->base.dev);
 
 	gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
diff --git a/sound/soc/codecs/simple-mux.c b/sound/soc/codecs/simple-mux.c
index 069555f35f73..c2f906a3f074 100644
--- a/sound/soc/codecs/simple-mux.c
+++ b/sound/soc/codecs/simple-mux.c
@@ -51,7 +51,7 @@ static int simple_mux_control_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *c = snd_soc_dapm_to_component(dapm);
 	struct simple_mux *priv = snd_soc_component_get_drvdata(c);
 
-	if (ucontrol->value.enumerated.item[0] > e->items)
+	if (ucontrol->value.enumerated.item[0] >= e->items)
 		return -EINVAL;
 
 	if (priv->mux == ucontrol->value.enumerated.item[0])
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 192e2a394ff3..ea387dc74273 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -40,6 +40,7 @@ struct byt_cht_es8316_private {
 	struct gpio_desc *speaker_en_gpio;
 	struct device *codec_dev;
 	bool speaker_en;
+	bool mclk_enabled;
 };
 
 enum {
@@ -170,6 +171,15 @@ static struct snd_soc_jack_pin byt_cht_es8316_jack_pins[] = {
 	},
 };
 
+static void byt_cht_es8316_disable_mclk(struct byt_cht_es8316_private *priv)
+{
+	if (!priv->mclk_enabled)
+		return;
+
+	clk_disable_unprepare(priv->mclk);
+	priv->mclk_enabled = false;
+}
+
 static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 {
 	struct snd_soc_component *codec = snd_soc_rtd_to_codec(runtime, 0)->component;
@@ -227,12 +237,14 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 	ret = clk_prepare_enable(priv->mclk);
 	if (ret)
 		dev_err(card->dev, "unable to enable MCLK\n");
+	else
+		priv->mclk_enabled = true;
 
 	ret = snd_soc_dai_set_sysclk(snd_soc_rtd_to_codec(runtime, 0), 0, 19200000,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0) {
 		dev_err(card->dev, "can't set codec clock %d\n", ret);
-		return ret;
+		goto err_disable_mclk;
 	}
 
 	ret = snd_soc_card_jack_new_pins(card, "Headset",
@@ -241,13 +253,25 @@ static int byt_cht_es8316_init(struct snd_soc_pcm_runtime *runtime)
 					 ARRAY_SIZE(byt_cht_es8316_jack_pins));
 	if (ret) {
 		dev_err(card->dev, "jack creation failed %d\n", ret);
-		return ret;
+		goto err_disable_mclk;
 	}
 
 	snd_jack_set_key(priv->jack.jack, SND_JACK_BTN_0, KEY_PLAYPAUSE);
 	snd_soc_component_set_jack(codec, &priv->jack, NULL);
 
 	return 0;
+
+err_disable_mclk:
+	byt_cht_es8316_disable_mclk(priv);
+	return ret;
+}
+
+static void byt_cht_es8316_exit(struct snd_soc_pcm_runtime *runtime)
+{
+	struct snd_soc_card *card = runtime->card;
+	struct byt_cht_es8316_private *priv = snd_soc_card_get_drvdata(card);
+
+	byt_cht_es8316_disable_mclk(priv);
 }
 
 static int byt_cht_es8316_codec_fixup(struct snd_soc_pcm_runtime *rtd,
@@ -353,6 +377,7 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 						| SND_SOC_DAIFMT_CBC_CFC,
 		.be_hw_params_fixup = byt_cht_es8316_codec_fixup,
 		.init = byt_cht_es8316_init,
+		.exit = byt_cht_es8316_exit,
 		SND_SOC_DAILINK_REG(ssp2_port, ssp2_codec, platform),
 	},
 };
diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index 9e3d176f50c2..6951c27e351e 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -186,7 +186,6 @@ static void event_handler(uint32_t opcode, uint32_t token,
 	case ASM_CLIENT_EVENT_CMD_RUN_DONE:
 		break;
 	case ASM_CLIENT_EVENT_CMD_EOS_DONE:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		break;
 	case ASM_CLIENT_EVENT_DATA_WRITE_DONE: {
 		snd_pcm_period_elapsed(substream);
@@ -227,9 +226,19 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	/* rate and channels are sent to audio driver */
 	if (prtd->state == Q6ASM_STREAM_RUNNING) {
 		/* clear the previous setup if any  */
-		q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
-		q6asm_unmap_memory_regions(substream->stream,
-					   prtd->audio_client);
+		ret = q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
+		if (ret < 0) {
+			dev_err(dev, "Failed to close q6asm stream %d\n", prtd->stream_id);
+			return ret;
+		}
+
+		ret = q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
+		if (ret < 0) {
+			dev_err(dev, "Failed to unmap memory regions for q6asm stream %d\n",
+				prtd->stream_id);
+			return ret;
+		}
+
 		q6routing_stream_close(soc_prtd->dai_link->id,
 					 substream->stream);
 		prtd->state = Q6ASM_STREAM_STOPPED;
@@ -297,8 +306,6 @@ static int q6asm_dai_prepare(struct snd_soc_component *component,
 	q6asm_cmd(prtd->audio_client, prtd->stream_id,  CMD_CLOSE);
 open_err:
 	q6asm_unmap_memory_regions(substream->stream, prtd->audio_client);
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 
 	return ret;
 }
@@ -341,7 +348,6 @@ static int q6asm_dai_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
@@ -457,12 +463,12 @@ static int q6asm_dai_close(struct snd_soc_component *component,
 	struct q6asm_dai_rtd *prtd = runtime->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state)
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
-
-		q6asm_unmap_memory_regions(substream->stream,
+			q6asm_unmap_memory_regions(substream->stream,
 					   prtd->audio_client);
+		}
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -555,8 +561,6 @@ static void compress_event_handler(uint32_t opcode, uint32_t token,
 			snd_compr_drain_notify(prtd->cstream);
 			prtd->notify_on_drain = false;
 
-		} else {
-			prtd->state = Q6ASM_STREAM_STOPPED;
 		}
 		break;
 
@@ -674,7 +678,7 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 	struct snd_soc_pcm_runtime *rtd = stream->private_data;
 
 	if (prtd->audio_client) {
-		if (prtd->state) {
+		if (prtd->state == Q6ASM_STREAM_RUNNING) {
 			q6asm_cmd(prtd->audio_client, prtd->stream_id,
 				  CMD_CLOSE);
 			if (prtd->next_track_stream_id) {
@@ -682,11 +686,11 @@ static int q6asm_dai_compr_free(struct snd_soc_component *component,
 					  prtd->next_track_stream_id,
 					  CMD_CLOSE);
 			}
-		}
 
-		snd_dma_free_pages(&prtd->dma_buffer);
-		q6asm_unmap_memory_regions(stream->direction,
+			q6asm_unmap_memory_regions(stream->direction,
 					   prtd->audio_client);
+		}
+		snd_dma_free_pages(&prtd->dma_buffer);
 		q6asm_audio_client_free(prtd->audio_client);
 		prtd->audio_client = NULL;
 	}
@@ -916,7 +920,7 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 			      prtd->session_id, dir);
 	if (ret) {
 		dev_err(dev, "Stream reg failed ret:%d\n", ret);
-		goto q6_err;
+		goto routing_err;
 	}
 
 	ret = __q6asm_dai_compr_set_codec_params(component, stream,
@@ -942,11 +946,11 @@ static int q6asm_dai_compr_set_params(struct snd_soc_component *component,
 	return 0;
 
 q6_err:
+	q6routing_stream_close(rtd->dai_link->id, dir);
+routing_err:
 	q6asm_cmd(prtd->audio_client, prtd->stream_id, CMD_CLOSE);
 
 open_err:
-	q6asm_audio_client_free(prtd->audio_client);
-	prtd->audio_client = NULL;
 	return ret;
 }
 
@@ -1014,7 +1018,6 @@ static int q6asm_dai_compr_trigger(struct snd_soc_component *component,
 				       0, 0, 0);
 		break;
 	case SNDRV_PCM_TRIGGER_STOP:
-		prtd->state = Q6ASM_STREAM_STOPPED;
 		ret = q6asm_cmd_nowait(prtd->audio_client, prtd->stream_id,
 				       CMD_EOS);
 		break;
diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index 8e80a7165faf..a4fac4652201 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -2504,6 +2504,27 @@ static int scarlett2_has_config_item(
 	return !!private->config_set->items[config_item_num].offset;
 }
 
+/* Return the configuration item's offset, applying any per-firmware
+ * overrides.
+ *
+ * Firmware 2417 for the 2i2 Gen 4 moved DIRECT_MONITOR_GAIN by 4
+ * bytes. Apply that shift here so that the rest of the driver can
+ * keep using the single config set. This override can be removed
+ * once the multi-config-set framework lands.
+ */
+static int scarlett2_config_item_offset(
+	struct scarlett2_data *private, int config_item_num)
+{
+	int offset = private->config_set->items[config_item_num].offset;
+
+	if (config_item_num == SCARLETT2_CONFIG_DIRECT_MONITOR_GAIN &&
+	    private->info == &s2i2_gen4_info &&
+	    private->firmware_version >= 2417)
+		offset = 0x2a4;
+
+	return offset;
+}
+
 /* Send a USB message to get configuration parameters; result placed in *buf */
 static int scarlett2_usb_get_config(
 	struct usb_mixer_interface *mixer,
@@ -2513,6 +2534,7 @@ static int scarlett2_usb_get_config(
 	const struct scarlett2_config *config_item =
 		&private->config_set->items[config_item_num];
 	int size, err, i;
+	int item_offset;
 	u8 *buf_8;
 	u8 value;
 
@@ -2522,13 +2544,15 @@ static int scarlett2_usb_get_config(
 	if (!config_item->offset)
 		return -EFAULT;
 
+	item_offset = scarlett2_config_item_offset(private, config_item_num);
+
 	/* Writes to the parameter buffer are always 1 byte */
 	size = config_item->size ? config_item->size : 8;
 
 	/* For byte-sized parameters, retrieve directly into buf */
 	if (size >= 8) {
 		size = size / 8 * count;
-		err = scarlett2_usb_get(mixer, config_item->offset, buf, size);
+		err = scarlett2_usb_get(mixer, item_offset, buf, size);
 		if (err < 0)
 			return err;
 		if (config_item->size == 16) {
@@ -2546,7 +2570,7 @@ static int scarlett2_usb_get_config(
 	}
 
 	/* For bit-sized parameters, retrieve into value */
-	err = scarlett2_usb_get(mixer, config_item->offset, &value, 1);
+	err = scarlett2_usb_get(mixer, item_offset, &value, 1);
 	if (err < 0)
 		return err;
 
@@ -2696,7 +2720,8 @@ static int scarlett2_usb_set_config(
 	 */
 	if (config_item->size >= 8) {
 		size = config_item->size / 8;
-		offset = config_item->offset + index * size;
+		offset = scarlett2_config_item_offset(private, config_item_num) +
+			 index * size;
 
 	/* If updating a bit, retrieve the old value, set/clear the
 	 * bit as needed, and update value
@@ -2705,7 +2730,7 @@ static int scarlett2_usb_set_config(
 		u8 tmp;
 
 		size = 1;
-		offset = config_item->offset;
+		offset = scarlett2_config_item_offset(private, config_item_num);
 
 		err = scarlett2_usb_get(mixer, offset, &tmp, 1);
 		if (err < 0)
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index 643f707b8f1d..ddabde20585f 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -390,8 +390,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
 
 	/* Backup the bootconfig data */
 	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
-	if (!data)
+	if (!data) {
+		free(buf);
 		return -ENOMEM;
+	}
 	memcpy(data, buf, size);
 
 	/* Check the data format */
diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index 0e1e486c1185..cdc3646f2642 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -3212,6 +3212,8 @@ def render_uapi(family, cw):
     for const in family['definitions']:
         if const.get('header'):
             continue
+        if const.get('scope', 'uapi') != 'uapi':
+            continue
 
         if const['type'] != 'const':
             cw.writes_defines(defines)
@@ -3339,6 +3341,25 @@ def render_uapi(family, cw):
     cw.p(f'#endif /* {hdr_prot} */')
 
 
+def render_scoped_consts(family, cw, scope):
+    defines = []
+    for const in family['definitions']:
+        if const['type'] != 'const':
+            continue
+        if const.get('header'):
+            continue
+        if const.get('scope') != scope:
+            continue
+        name_pfx = const.get('name-prefix', f"{family.ident_name}-")
+        defines.append([
+            c_upper(family.get('c-define-name',
+                               f"{name_pfx}{const['name']}")),
+            const['value']])
+    if defines:
+        cw.writes_defines(defines)
+        cw.nl()
+
+
 def _render_user_ntf_entry(ri, op):
     if not ri.family.is_classic():
         ri.cw.block_start(line=f"[{op.enum_name}] = ")
@@ -3504,8 +3525,12 @@ def main():
             cw.p('#include "ynl.h"')
         headers = []
     for definition in parsed['definitions'] + parsed['attribute-sets']:
-        if 'header' in definition:
-            headers.append(definition['header'])
+        if 'header' not in definition:
+            continue
+        scope = definition.get('scope', 'uapi')
+        if scope != 'uapi' and scope != args.mode:
+            continue
+        headers.append(definition['header'])
     if args.mode == 'user':
         headers.append(parsed.uapi_header)
     seen_header = []
@@ -3522,6 +3547,7 @@ def main():
             for one in args.user_header:
                 cw.p(f'#include "{one}"')
         else:
+            render_scoped_consts(parsed, cw, 'user')
             cw.p('struct ynl_sock;')
             cw.nl()
             render_user_family(parsed, cw, True)
@@ -3529,6 +3555,7 @@ def main():
 
     if args.mode == "kernel":
         if args.header:
+            render_scoped_consts(parsed, cw, 'kernel')
             for _, struct in sorted(parsed.pure_nested_structs.items()):
                 if struct.request:
                     cw.p('/* Common nested types */')
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81e2aef3627a..f4c26441fc41 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1144,6 +1144,23 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_64G (SZ_32G * 2)
 #endif
 
+static int cxl_mock_platform_device_add(struct platform_device *pdev,
+					struct platform_device **ppdev)
+{
+	int rc;
+
+	if (ppdev)
+		*ppdev = pdev;
+	rc = platform_device_add(pdev);
+	if (rc) {
+		platform_device_put(pdev);
+		if (ppdev)
+			*ppdev = NULL;
+	}
+
+	return rc;
+}
+
 static __init int cxl_rch_topo_init(void)
 {
 	int rc, i;
@@ -1158,13 +1175,10 @@ static __init int cxl_rch_topo_init(void)
 			goto err_bridge;
 
 		mock_companion(adev, &pdev->dev);
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_rch[i]);
+		if (rc)
 			goto err_bridge;
-		}
 
-		cxl_rch[i] = pdev;
 		mock_pci_bus[idx].bridge = &pdev->dev;
 		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
 				       "firmware_node");
@@ -1216,13 +1230,10 @@ static __init int cxl_single_topo_init(void)
 			goto err_bridge;
 
 		mock_companion(adev, &pdev->dev);
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_hb_single[i]);
+		if (rc)
 			goto err_bridge;
-		}
 
-		cxl_hb_single[i] = pdev;
 		mock_pci_bus[i + NR_CXL_HOST_BRIDGES].bridge = &pdev->dev;
 		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
 				       "physical_node");
@@ -1241,12 +1252,9 @@ static __init int cxl_single_topo_init(void)
 			goto err_port;
 		pdev->dev.parent = &bridge->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_root_single[i]);
+		if (rc)
 			goto err_port;
-		}
-		cxl_root_single[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_swu_single); i++) {
@@ -1259,12 +1267,9 @@ static __init int cxl_single_topo_init(void)
 			goto err_uport;
 		pdev->dev.parent = &root_port->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_swu_single[i]);
+		if (rc)
 			goto err_uport;
-		}
-		cxl_swu_single[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_swd_single); i++) {
@@ -1278,12 +1283,9 @@ static __init int cxl_single_topo_init(void)
 			goto err_dport;
 		pdev->dev.parent = &uport->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_swd_single[i]);
+		if (rc)
 			goto err_dport;
-		}
-		cxl_swd_single[i] = pdev;
 	}
 
 	return 0;
@@ -1356,12 +1358,9 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
+		if (rc)
 			goto err_mem;
-		}
-		cxl_mem[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_mem_single); i++) {
@@ -1374,12 +1373,9 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &dport->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
+		if (rc)
 			goto err_single;
-		}
-		cxl_mem_single[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_rcd); i++) {
@@ -1393,12 +1389,9 @@ static int cxl_mem_init(void)
 		pdev->dev.parent = &rch->dev;
 		set_dev_node(&pdev->dev, i % 2);
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
+		if (rc)
 			goto err_rcd;
-		}
-		cxl_rcd[i] = pdev;
 	}
 
 	return 0;
@@ -1463,13 +1456,10 @@ static __init int cxl_test_init(void)
 			goto err_bridge;
 
 		mock_companion(adev, &pdev->dev);
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_host_bridge[i]);
+		if (rc)
 			goto err_bridge;
-		}
 
-		cxl_host_bridge[i] = pdev;
 		mock_pci_bus[i].bridge = &pdev->dev;
 		rc = sysfs_create_link(&pdev->dev.kobj, &pdev->dev.kobj,
 				       "physical_node");
@@ -1487,12 +1477,9 @@ static __init int cxl_test_init(void)
 			goto err_port;
 		pdev->dev.parent = &bridge->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_root_port[i]);
+		if (rc)
 			goto err_port;
-		}
-		cxl_root_port[i] = pdev;
 	}
 
 	BUILD_BUG_ON(ARRAY_SIZE(cxl_switch_uport) != ARRAY_SIZE(cxl_root_port));
@@ -1505,12 +1492,9 @@ static __init int cxl_test_init(void)
 			goto err_uport;
 		pdev->dev.parent = &root_port->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_uport[i]);
+		if (rc)
 			goto err_uport;
-		}
-		cxl_switch_uport[i] = pdev;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(cxl_switch_dport); i++) {
@@ -1523,12 +1507,9 @@ static __init int cxl_test_init(void)
 			goto err_dport;
 		pdev->dev.parent = &uport->dev;
 
-		rc = platform_device_add(pdev);
-		if (rc) {
-			platform_device_put(pdev);
+		rc = cxl_mock_platform_device_add(pdev, &cxl_switch_dport[i]);
+		if (rc)
 			goto err_dport;
-		}
-		cxl_switch_dport[i] = pdev;
 	}
 
 	rc = cxl_single_topo_init();
@@ -1546,9 +1527,9 @@ static __init int cxl_test_init(void)
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
 
-	rc = platform_device_add(cxl_acpi);
+	rc = cxl_mock_platform_device_add(cxl_acpi, NULL);
 	if (rc)
-		goto err_root;
+		goto err_rch;
 
 	rc = cxl_mem_init();
 	if (rc)
diff --git a/tools/testing/selftests/net/ioam6.sh b/tools/testing/selftests/net/ioam6.sh
index b2b99889942f..845c26dd01a9 100755
--- a/tools/testing/selftests/net/ioam6.sh
+++ b/tools/testing/selftests/net/ioam6.sh
@@ -273,8 +273,8 @@ setup()
   ip -netns $ioam_node_beta link set ioam-veth-betaR name veth1 &>/dev/null
   ip -netns $ioam_node_gamma link set ioam-veth-gamma name veth0 &>/dev/null
 
-  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha addr add 2001:db8:1::50/64 dev veth0 &>/dev/null
+  ip -netns $ioam_node_alpha addr add 2001:db8:1::2/64 dev veth0 &>/dev/null
   ip -netns $ioam_node_alpha link set veth0 up &>/dev/null
   ip -netns $ioam_node_alpha link set lo up &>/dev/null
   ip -netns $ioam_node_alpha route add 2001:db8:2::/64 \
