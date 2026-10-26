Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793028671;
	b=H+M+CcwYIh7MIrluHoMCqGoczvXn8sBVg2Imcz3BDx/2rXd/SOeduFcx/1V27UTrHRWn
	 2rErTylJENVa5NfuqQf3SF9DFU8wLsEtfyzL5YD7rqYPBdHO9b/Y38EPgjjdvvQ8mxT7m
	 zGG70nqsRTiijrWv1kW9VKcXKC5JiYcYUbH8CSAZczuh5m/PRzDqQnoul3rxk2NshBshK
	 fJqO8WxSoMP3LxPDcDcKg6BNyax+SgHo/iYOPVT8MD8mhsB68yh8ZeOXCF/RMiK27FZic
	 b9MAdavJY0OEOMlwaAlZqvqPX8JbdpTb+5yDx654iSP4UTRGOCpExVxyZ8c6mnwvGdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793028671;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GHAyCN/K1uJLWCT8INHIIjw+5HyNtwtGqh6Y6ZEUe9w=;
	b=T3wXx9Z97biEBRjvGj6DhZw4jmlDVEpptV03F1pAlYbDYd7yVVAgO2Er1EsD9JFtdvE9
	 nhPswKCJ1o6OxGHVMGuNi1mgdtXWhNFpVuikcFS8LB+/jaemEB4gNwnPDJF6M7hAlRUHb
	 oXXPrGexpat9H4PDJw3EPjFCjaQHgGKCkLGNX9rz/97zcgw7MPpwOD+KKSvqstdu6RR7y
	 m5Fz80tu4GMnTp1eWW9uOeo/JFvAFny/suUVy89USo6FVpk7ZHTiu11DDKdNk9IcjlG5q
	 JDGFRmjkBr9I0onJN1BSNBTqSi0hJZxmaD8ENDYRxoqgS+YUTH+w9WFz1ZFdPJvkMCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1tNxqA1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70282606A321;
	Mon, 26 Oct 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=1tNxqA1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711031F031E2;
	Mon, 26 Oct 2026 15:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793028669;
	bh=GHAyCN/K1uJLWCT8INHIIjw+5HyNtwtGqh6Y6ZEUe9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1tNxqA1IfR1D1BWUXRwJsgLeqDS99LTjcuGRJZLPTFD3uoP8n0wjM0pLMhBZcmTUe
	 EmDJ1fWJ44feYDKmY5058K/H0N1axHDTpib+xoPWexfmZPcRFsabgIVdkVrMwaEEqe
	 iYNepfaL8Yaj/h7+BhvBdSBK52FsiASnmcYoh7Xs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.18.59
Date: Mon, 26 Oct 2026 16:31:02 +0100
Message-ID: <2026102602-doorpost-suitably-655a@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026102602-catalyst-appraiser-a88a@gregkh>
References: <2026102602-catalyst-appraiser-a88a@gregkh>
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

diff --git a/Documentation/netlink/specs/conntrack.yaml b/Documentation/netlink/specs/conntrack.yaml
index db7cddcda50a..b1eb102ab843 100644
--- a/Documentation/netlink/specs/conntrack.yaml
+++ b/Documentation/netlink/specs/conntrack.yaml
@@ -360,6 +360,17 @@ attribute-sets:
         name: tsoff
         type: u32
         byte-order: big-endian
+  -
+    name: filter-attrs
+    attributes:
+      -
+        name: orig-flags
+        type: u32
+        doc: bitmask of tuple fields to filter on, original direction
+      -
+        name: reply-flags
+        type: u32
+        doc: bitmask of tuple fields to filter on, reply direction
   -
     name: conntrack-attrs
     attributes:
@@ -466,7 +477,7 @@ attribute-sets:
       -
         name: filter
         type: nest
-        nested-attributes: tuple-attrs
+        nested-attributes: filter-attrs
       -
         name: status-mask
         type: u32
@@ -591,10 +602,14 @@ operations:
         request:
           value: 0x101
           attributes:
-            - mark
-            - filter
+            - tuple-orig
+            - tuple-reply
             - status
+            - mark
             - zone
+            - mark-mask
+            - filter
+            - status-mask
         reply:
           value: 0x100
           attributes:
diff --git a/Makefile b/Makefile
index 4b6869e045e6..dbe46057221c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 58
+SUBLEVEL = 59
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi b/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
index 0de16ee262cf..615a8fb47776 100644
--- a/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/ti/omap/dra7xx-clocks.dtsi
@@ -1376,8 +1376,8 @@ optfclk_pciephy_div: clock-optfclk-pciephy-div-8@4a00821c {
 		clocks = <&apll_pcie_ck>;
 		#clock-cells = <0>;
 		reg = <0x021c>;
+		ti,dividers = <2>, <1>;
 		ti,bit-shift = <8>;
-		ti,max-div = <2>;
 	};
 
 	apll_pcie_clkvcoldo: clock-apll-pcie-clkvcoldo {
diff --git a/arch/nios2/include/asm/checksum.h b/arch/nios2/include/asm/checksum.h
index 69004e07a1ba..b6b415ae17a0 100644
--- a/arch/nios2/include/asm/checksum.h
+++ b/arch/nios2/include/asm/checksum.h
@@ -27,7 +27,7 @@ static inline __sum16 csum_fold(__wsum sum)
 		"add	%0, %0, r8\n"
 		"nor	%0, %0, %0\n"
 		: "=r" (sum)
-		: "r" (sum << 16), "0" (sum)
+		: "r" ((__force u32)sum << 16), "0" (sum)
 		: "r8");
 	return (__force __sum16) sum;
 }
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 12060870e2aa..f3b2c624bf89 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -154,6 +154,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 	if (off || (count < sizeof(*report)))
 		return -EINVAL;
 
+	if (count < (report->length + sizeof(*report)))
+		return -EINVAL;
+
 	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
 
 	return ret ? ret : count;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 085ef4f2e73a..498d48b575e5 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -713,7 +713,8 @@ int hv_apicid_to_vp_index(u32 apic_id)
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	/* Treat input as having 2 APIC IDs so output is 64-bit aligned */
+	output = (void *)input + struct_size(input, apic_ids, 2);
 
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_INDEX_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 1500852ba03c..38c7509e16de 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -255,11 +255,39 @@ noinstr u32 kvm_read_and_reset_apf_flags(void)
 }
 EXPORT_SYMBOL_GPL(kvm_read_and_reset_apf_flags);
 
+static __always_inline bool kvm_apf_reason_pending(void)
+{
+	return __this_cpu_read(async_pf_enabled) &&
+	       __this_cpu_read(apf_reason.flags);
+}
+
 noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 {
-	u32 flags = kvm_read_and_reset_apf_flags();
 	irqentry_state_t state;
+	u32 flags;
+
+	if (!kvm_apf_reason_pending())
+		return false;
+
+	/*
+	 * The guest does not enable KVM_ASYNC_PF_SEND_ALWAYS, so the host
+	 * delivers async #PF only to user mode (or as a #PF VM-exit, which KVM
+	 * reads itself). A #PF from kernel mode can still arrive between that
+	 * delivery and the read of the reason flags, inside an NMI that
+	 * interrupted it, for instance perf reading user memory for a call
+	 * chain. Such a fault is not async, so leave the async PF flags
+	 * untouched for the outer handler.  Outside NMI context, on the other
+	 * hand, async PF flags on a kernel-mode fault mean the host is broken.
+	 */
+	if (!user_mode(regs)) {
+		if (likely(in_nmi()))
+			return false;
+		state = irqentry_enter(regs);
+		instrumentation_begin();
+		panic("Host injected async #PF in kernel mode\n");
+	}
 
+	flags = kvm_read_and_reset_apf_flags();
 	if (!flags)
 		return false;
 
@@ -275,8 +303,6 @@ noinstr bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
 		panic("Host injected async #PF in interrupt disabled region\n");
 
 	if (flags & KVM_PV_REASON_PAGE_NOT_PRESENT) {
-		if (unlikely(!(user_mode(regs))))
-			panic("Host injected async #PF in kernel mode\n");
 		/* Page is swapped out by the host. */
 		kvm_async_pf_task_wait_schedule(token);
 	} else {
diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index f63074048ec6..64b785ad6fd6 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -186,8 +186,18 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 				  unsigned pte_access, unsigned pte_pkey,
 				  u64 access)
 {
-	/* strip nested paging fault error codes */
-	unsigned int pfec = access;
+	/*
+	 * Of the error codes that do not contribute to the index in
+	 * mmu->permissions, PK and SS are not supported by shadow paging
+	 * and also not provided to EPT violations, but SS *is* included
+	 * in the NPT exit code.  RSVD faults are handled elsewhere.
+	 */
+	unsigned int pfec = access & ~PFERR_SS_MASK;
+	if (WARN_ON_ONCE(pfec & ~(PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+				  PFERR_USER_MASK | PFERR_FETCH_MASK)))
+		pfec &= (PFERR_PRESENT_MASK | PFERR_WRITE_MASK |
+			 PFERR_USER_MASK | PFERR_FETCH_MASK);
+
 	unsigned long rflags = kvm_x86_call(get_rflags)(vcpu);
 
 	/*
@@ -211,8 +221,6 @@ static inline u8 permission_fault(struct kvm_vcpu *vcpu, struct kvm_mmu *mmu,
 	kvm_mmu_refresh_passthrough_bits(vcpu, mmu);
 
 	fault = (mmu->permissions[index] >> pte_access) & 1;
-
-	WARN_ON_ONCE(pfec & (PFERR_PK_MASK | PFERR_SS_MASK | PFERR_RSVD_MASK));
 	if (unlikely(mmu->pkru_mask)) {
 		u32 pkru_bits, offset;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 205d314a7583..1fa251ca4dcc 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2630,6 +2630,7 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 */
 			if (tdp_enabled && invalid_list &&
 			    child->role.guest_mode &&
+			    !child->root_count &&
 			    !atomic_long_read(&child->parent_ptes.val))
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 6e2ce54a13b3..07b0ddd15b9d 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -474,7 +474,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 	return 1;
 
 error:
-	errcode |= write_fault | user_fault;
+	errcode |= write_fault | user_fault | (access & PFERR_SS_MASK);
 	if (fetch_fault && (is_efer_nx(mmu) || is_cr4_smep(mmu)))
 		errcode |= PFERR_FETCH_MASK;
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 335b214aa371..5f3c6d7974fb 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -981,10 +981,14 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 			svm_set_intercept(svm, INTERCEPT_RDTSCP);
 	}
 
+	/*
+	 * No need to toggle VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK here, it is
+	 * always set if vls is enabled. If the intercepts are set, the bit is
+	 * meaningless anyway.
+	 */
 	if (guest_cpuid_is_intel_compatible(vcpu)) {
 		svm_set_intercept(svm, INTERCEPT_VMLOAD);
 		svm_set_intercept(svm, INTERCEPT_VMSAVE);
-		svm->vmcb->control.virt_ext &= ~VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 	} else {
 		/*
 		 * If hardware supports Virtual VMLOAD VMSAVE then enable it
@@ -993,7 +997,6 @@ static void svm_recalc_instruction_intercepts(struct kvm_vcpu *vcpu)
 		if (vls) {
 			svm_clr_intercept(svm, INTERCEPT_VMLOAD);
 			svm_clr_intercept(svm, INTERCEPT_VMSAVE);
-			svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
 		}
 	}
 }
@@ -1137,6 +1140,9 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 		svm->vmcb->control.int_ctl |= V_GIF_ENABLE_MASK;
 	}
 
+	if (vls)
+		svm->vmcb->control.virt_ext |= VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK;
+
 	if (vcpu->kvm->arch.bus_lock_detection_enabled)
 		svm_set_intercept(svm, INTERCEPT_BUSLOCK);
 
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 97ef2ebc2477..be2ab71cd9ea 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3821,8 +3821,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
-	if (!from_vmentry)
+	if (!from_vmentry) {
+		nested_ept_uninit_mmu_context(vcpu);
 		return NVMX_VMENTRY_VMEXIT;
+	}
 
 	nested_put_vmcs12_pages(vcpu);
 
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 9ceb5d0832f5..da05b28cc867 100644
--- a/block/bsg-lib.c
+++ b/block/bsg-lib.c
@@ -23,11 +23,14 @@ struct bsg_set {
 	struct bsg_device	*bd;
 	bsg_job_fn		*job_fn;
 	bsg_timeout_fn		*timeout_fn;
+	unsigned int		reply_len;
 };
 
 static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 		bool open_for_write, unsigned int timeout)
 {
+	struct bsg_set *bset =
+		container_of(q->tag_set, struct bsg_set, tag_set);
 	struct bsg_job *job;
 	struct request *rq;
 	struct bio *bio;
@@ -50,7 +53,7 @@ static int bsg_transport_sg_io_fn(struct request_queue *q, struct sg_io_v4 *hdr,
 	reply = job->reply;
 	memset(job, 0, sizeof(*job));
 	job->reply = reply;
-	job->reply_len = SCSI_SENSE_BUFFERSIZE;
+	job->reply_len = bset->reply_len;
 	job->dd_data = job + 1;
 
 	job->request_len = hdr->request_len;
@@ -301,9 +304,10 @@ static blk_status_t bsg_queue_rq(struct blk_mq_hw_ctx *hctx,
 static int bsg_init_rq(struct blk_mq_tag_set *set, struct request *req,
 		       unsigned int hctx_idx, unsigned int numa_node)
 {
+	struct bsg_set *bset = container_of(set, struct bsg_set, tag_set);
 	struct bsg_job *job = blk_mq_rq_to_pdu(req);
 
-	job->reply = kzalloc(SCSI_SENSE_BUFFERSIZE, GFP_KERNEL);
+	job->reply = kzalloc(bset->reply_len, GFP_KERNEL);
 	if (!job->reply)
 		return -ENOMEM;
 	return 0;
@@ -358,10 +362,12 @@ static const struct blk_mq_ops bsg_mq_ops = {
  * @job_fn: bsg job handler
  * @timeout: timeout handler function pointer
  * @dd_job_size: size of LLD data needed for each job
+ * @reply_len: size of the reply buffer needed for each job
  */
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		struct queue_limits *lim, bsg_job_fn *job_fn,
-		bsg_timeout_fn *timeout, int dd_job_size)
+		bsg_timeout_fn *timeout, int dd_job_size,
+		unsigned int reply_len)
 {
 	struct bsg_set *bset;
 	struct blk_mq_tag_set *set;
@@ -374,6 +380,7 @@ struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 
 	bset->job_fn = job_fn;
 	bset->timeout_fn = timeout;
+	bset->reply_len = reply_len;
 
 	set = &bset->tag_set;
 	set->ops = &bsg_mq_ops;
diff --git a/drivers/accel/rocket/rocket_device.c b/drivers/accel/rocket/rocket_device.c
index 46e6ee1e72c5..efd004194c1a 100644
--- a/drivers/accel/rocket/rocket_device.c
+++ b/drivers/accel/rocket/rocket_device.c
@@ -31,6 +31,8 @@ struct rocket_device *rocket_device_init(struct platform_device *pdev,
 		if (of_device_is_available(core_node))
 			num_cores++;
 
+	rdev->max_cores = num_cores;
+
 	rdev->cores = devm_kcalloc(dev, num_cores, sizeof(*rdev->cores), GFP_KERNEL);
 	if (!rdev->cores)
 		return ERR_PTR(-ENOMEM);
diff --git a/drivers/accel/rocket/rocket_device.h b/drivers/accel/rocket/rocket_device.h
index ce662abc01d3..c62d56701069 100644
--- a/drivers/accel/rocket/rocket_device.h
+++ b/drivers/accel/rocket/rocket_device.h
@@ -19,6 +19,7 @@ struct rocket_device {
 
 	struct rocket_core *cores;
 	unsigned int num_cores;
+	unsigned int max_cores;
 };
 
 struct rocket_device *rocket_device_init(struct platform_device *pdev,
diff --git a/drivers/accel/rocket/rocket_drv.c b/drivers/accel/rocket/rocket_drv.c
index f6ef4c7aeef1..53e2d9452ce9 100644
--- a/drivers/accel/rocket/rocket_drv.c
+++ b/drivers/accel/rocket/rocket_drv.c
@@ -165,8 +165,11 @@ static int rocket_probe(struct platform_device *pdev)
 		/* First core probing, initialize DRM device. */
 		rdev = rocket_device_init(drm_dev, &rocket_drm_driver);
 		if (IS_ERR(rdev)) {
+			int err = PTR_ERR(rdev);
+
 			dev_err(&pdev->dev, "failed to initialize rocket device\n");
-			return PTR_ERR(rdev);
+			rdev = NULL;
+			return err;
 		}
 	}
 
@@ -222,7 +225,7 @@ static int find_core_for_dev(struct device *dev)
 {
 	struct rocket_device *rdev = dev_get_drvdata(dev);
 
-	for (unsigned int core = 0; core < rdev->num_cores; core++) {
+	for (unsigned int core = 0; core < rdev->max_cores; core++) {
 		if (dev == rdev->cores[core].dev)
 			return core;
 	}
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index 6f31240ee4a9..6efed02c21c5 100644
--- a/drivers/base/regmap/internal.h
+++ b/drivers/base/regmap/internal.h
@@ -186,6 +186,7 @@ struct regcache_ops {
 	enum regcache_type type;
 	int (*init)(struct regmap *map);
 	int (*exit)(struct regmap *map);
+	int (*populate)(struct regmap *map);
 #ifdef CONFIG_DEBUG_FS
 	void (*debugfs_init)(struct regmap *map);
 #endif
diff --git a/drivers/base/regmap/regcache-maple.c b/drivers/base/regmap/regcache-maple.c
index 9cf0384ce7b9..38a648efa606 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -295,16 +295,21 @@ static int regcache_maple_exit(struct regmap *map)
 	struct maple_tree *mt = map->cache;
 	MA_STATE(mas, mt, 0, UINT_MAX);
 	unsigned int *entry;
+	unsigned long flags;
 
 	/* if we've already been called then just return */
 	if (!mt)
 		return 0;
 
-	mas_lock(&mas);
+	/*
+	 * Register access may take the Maple lock from hard IRQ context, so
+	 * preserve its IRQ-safe lockdep state during teardown.
+	 */
+	mas_lock_irqsave(&mas, flags);
 	mas_for_each(&mas, entry, UINT_MAX)
 		kfree(entry);
 	__mt_destroy(mt);
-	mas_unlock(&mas);
+	mas_unlock_irqrestore(&mas, flags);
 
 	kfree(mt);
 	map->cache = NULL;
diff --git a/drivers/base/regmap/regcache.c b/drivers/base/regmap/regcache.c
index c7650fa434ad..57757adad1f5 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -215,14 +215,26 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
 	if (map->cache_ops->init) {
 		dev_dbg(map->dev, "Initializing %s cache\n",
 			map->cache_ops->name);
-		map->lock(map->lock_arg);
 		ret = map->cache_ops->init(map);
-		map->unlock(map->lock_arg);
 		if (ret)
 			goto err_free;
 	}
+
+	if (map->num_reg_defaults && map->cache_ops->populate) {
+		dev_dbg(map->dev, "Populating %s cache\n", map->cache_ops->name);
+		map->lock(map->lock_arg);
+		ret = map->cache_ops->populate(map);
+		map->unlock(map->lock_arg);
+		if (ret)
+			goto err_exit;
+	}
 	return 0;
 
+err_exit:
+	if (map->cache_ops->exit) {
+		dev_dbg(map->dev, "Destroying %s cache\n", map->cache_ops->name);
+		map->cache_ops->exit(map);
+	}
 err_free:
 	kfree(map->reg_defaults);
 	if (map->cache_free)
@@ -245,9 +257,7 @@ void regcache_exit(struct regmap *map)
 	if (map->cache_ops->exit) {
 		dev_dbg(map->dev, "Destroying %s cache\n",
 			map->cache_ops->name);
-		map->lock(map->lock_arg);
 		map->cache_ops->exit(map);
-		map->unlock(map->lock_arg);
 	}
 }
 
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index 12f11a6c9665..32ded7b548fb 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -7,6 +7,7 @@
 // Authors: Daniel Mack, Juergen Beisert.
 // Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
+#include <linux/bitops.h>
 #include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
@@ -68,11 +69,11 @@ struct mxc_gpio_port {
 	struct irq_domain *domain;
 	struct gpio_generic_chip gen_gc;
 	struct device *dev;
-	u32 both_edges;
+	unsigned long both_edges;
 	struct mxc_gpio_reg_saved gpio_saved_reg;
 	bool power_off;
-	u32 wakeup_pads;
 	bool is_pad_wakeup;
+	unsigned long wakeup_pads;
 	u32 pad_type[32];
 	const struct mxc_gpio_hwdata *hwdata;
 };
@@ -168,7 +169,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 	int edge;
 	void __iomem *reg = port->base;
 
-	port->both_edges &= ~(1 << gpio_idx);
+	clear_bit(gpio_idx, &port->both_edges);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		edge = GPIO_INT_RISE_EDGE;
@@ -188,7 +189,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 				edge = GPIO_INT_HIGH_LEV;
 				pr_debug("mxc: set GPIO %d to high trigger\n", gpio_idx);
 			}
-			port->both_edges |= 1 << gpio_idx;
+			set_bit(gpio_idx, &port->both_edges);
 		}
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
@@ -259,7 +260,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
 
-		if (port->both_edges & (1 << irqoffset))
+		if (test_bit(irqoffset, &port->both_edges))
 			mxc_flip_edge(port, irqoffset);
 
 		generic_handle_domain_irq(port->domain, irqoffset);
@@ -330,16 +331,18 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
 			ret = enable_irq_wake(port->irq_high);
 		else
 			ret = enable_irq_wake(port->irq);
-		port->wakeup_pads |= (1 << gpio_idx);
 	} else {
 		if (port->irq_high && (gpio_idx >= 16))
 			ret = disable_irq_wake(port->irq_high);
 		else
 			ret = disable_irq_wake(port->irq);
-		port->wakeup_pads &= ~(1 << gpio_idx);
 	}
+	if (ret)
+		return ret;
 
-	return ret;
+	assign_bit(gpio_idx, &port->wakeup_pads, enable);
+
+	return 0;
 }
 
 static int mxc_gpio_init_gc(struct mxc_gpio_port *port, int irq_base)
@@ -474,8 +477,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	} else
 		port->mx_irq_handler = mx3_gpio_irq_handler;
 
-	mxc_update_irq_chained_handler(port, true);
-
 	config.dev = &pdev->dev;
 	config.sz = 4;
 	config.dat = port->base + GPIO_PSR;
@@ -499,10 +500,6 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	else /* silence boot time warning */
 		port->gen_gc.gc.base = -1;
 
-	err = devm_gpiochip_add_data(&pdev->dev, &port->gen_gc.gc, port);
-	if (err)
-		goto out_bgio;
-
 	irq_base = devm_irq_alloc_descs(&pdev->dev, -1, 0, 32, numa_node_id());
 	if (irq_base < 0) {
 		err = irq_base;
@@ -523,8 +520,19 @@ static int mxc_gpio_probe(struct platform_device *pdev)
 	if (err < 0)
 		goto out_irqdomain_remove;
 
+	/*
+	 * Register the GPIO chip last: devm_gpiochip_add_data() makes the
+	 * chip visible to consumers immediately, so the IRQ domain and
+	 * generic irq chip must be ready before any to_irq() call.
+	 */
+	err = devm_gpiochip_add_data(&pdev->dev, &port->gen_gc.gc, port);
+	if (err)
+		goto out_irqdomain_remove;
+
 	list_add_tail(&port->node, &mxc_gpio_ports);
 
+	mxc_update_irq_chained_handler(port, true);
+
 	platform_set_drvdata(pdev, port);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
diff --git a/drivers/gpio/gpio-nct6694.c b/drivers/gpio/gpio-nct6694.c
index a8607f0d9915..a38add1cde29 100644
--- a/drivers/gpio/gpio-nct6694.c
+++ b/drivers/gpio/gpio-nct6694.c
@@ -444,7 +444,7 @@ static int nct6694_gpio_probe(struct platform_device *pdev)
 	data->gpio.set_config		= nct6694_set_config;
 	data->gpio.init_valid_mask	= nct6694_init_valid_mask;
 	data->gpio.base			= -1;
-	data->gpio.can_sleep		= false;
+	data->gpio.can_sleep		= true;
 	data->gpio.owner		= THIS_MODULE;
 	data->gpio.ngpio		= NCT6694_NR_GPIO;
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 9d3c33e1c9f9..d0efcb96d276 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3798,16 +3798,17 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
 		} while ((i < array_size) &&
 			 gpio_device_chip_cmp(desc_array[i]->gdev, guard.gc));
 		/* push collected bits to outputs */
-		if (count != 0) {
+		ret = 0;
+		if (count != 0)
 			ret = gpiochip_set_multiple(guard.gc, mask, bits);
-			if (ret)
-				return ret;
-		}
 
 		if (mask != fastpath_mask)
 			bitmap_free(mask);
 		if (bits != fastpath_bits)
 			bitmap_free(bits);
+
+		if (ret)
+			return ret;
 	}
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 38ce4d7c86f0..f8a2c9e41ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1448,6 +1448,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1502,6 +1503,11 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 
 error_backoff:
+	/* amdgpu_cs_submit() only drops the ranges once it got that far. */
+	amdgpu_bo_list_for_each_userptr_entry(e, parser.bo_list) {
+		amdgpu_ttm_tt_get_user_pages_done(e->bo->tbo.ttm, e->range);
+		e->range = NULL;
+	}
 	mutex_unlock(&parser.bo_list->bo_list_mutex);
 
 error_fini:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index cda4696d2dd4..04939a9711e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1164,7 +1164,6 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 {
 	struct amdgpu_device *adev = f->f_inode->i_private;
 	int r;
-	ssize_t result = 0;
 	uint32_t offset, se, sh, cu, wave, simd, thread, bank, *data;
 
 	if (size > 4096 || size & 3 || *pos & 3)
@@ -1209,25 +1208,11 @@ static ssize_t amdgpu_debugfs_gpr_read(struct file *f, char __user *buf,
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
+	amdgpu_virt_disable_access_debugfs(adev);
 
-	while (size) {
-		uint32_t value;
-
-		value = data[result >> 2];
-		r = put_user(value, (uint32_t *)buf);
-		if (r) {
-			amdgpu_virt_disable_access_debugfs(adev);
-			goto err;
-		}
-
-		result += 4;
-		buf += 4;
-		size -= 4;
-	}
-
+	r = copy_to_user(buf, data, size) ? -EFAULT : size;
 	kfree(data);
-	amdgpu_virt_disable_access_debugfs(adev);
-	return result;
+	return r;
 
 err:
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 81c6003b3e79..3b03157faa7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -325,11 +325,14 @@ static void amdgpu_gem_object_close(struct drm_gem_object *obj,
 			goto out_unlock;
 	}
 
+	bo_va = amdgpu_vm_bo_find(vm, bo);
+	/* the fence is attached once per bo_va, so keep it for other handles */
+	if (bo_va && --bo_va->ref_count)
+		goto out_unlock;
+
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		amdgpu_eviction_fence_detach(&fpriv->evf_mgr, bo);
-
-	bo_va = amdgpu_vm_bo_find(vm, bo);
-	if (!bo_va || --bo_va->ref_count)
+	if (!bo_va)
 		goto out_unlock;
 
 	amdgpu_vm_bo_del(adev, bo_va);
@@ -1217,7 +1220,7 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
 		bo_entry->alloc_flags = bo->flags & AMDGPU_GEM_CREATE_SETTABLE_MASK;
 		bo_entry->preferred_domains = bo->preferred_domains;
 		bo_entry->gem_handle = id;
-		bo_entry->alignment = bo->tbo.page_alignment;
+		bo_entry->alignment = (u64)bo->tbo.page_alignment << PAGE_SHIFT;
 
 		if (bo->tbo.base.import_attach)
 			bo_entry->flags |= AMDGPU_GEM_LIST_HANDLES_FLAG_IS_IMPORT;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 1c076bd1cf73..8ffab53b4c27 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -457,6 +457,9 @@ static void sdma_v3_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	else
 		ref_and_mask = REG_SET_FIELD(ref_and_mask, GPU_HDP_FLUSH_DONE, SDMA1, 1);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
@@ -484,6 +487,10 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 				      unsigned flags)
 {
 	bool write64bit = flags & AMDGPU_FENCE_FLAG_64BIT;
+
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* write the fence */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 	amdgpu_ring_write(ring, lower_32_bits(addr));
@@ -492,7 +499,11 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 
 	/* optionally write high bits as well */
 	if (write64bit) {
+		/* Hang workaround */
+		amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 		addr += 4;
+
 		amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_FENCE));
 		amdgpu_ring_write(ring, lower_32_bits(addr));
 		amdgpu_ring_write(ring, upper_32_bits(addr));
@@ -1033,6 +1044,9 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for idle */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1061,6 +1075,9 @@ static void sdma_v3_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 {
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for flush */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1563,11 +1580,11 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
 	.get_wptr = sdma_v3_0_ring_get_wptr,
 	.set_wptr = sdma_v3_0_ring_set_wptr,
 	.emit_frame_size =
-		6 + /* sdma_v3_0_ring_emit_hdp_flush */
+		6 + 1 + /* sdma_v3_0_ring_emit_hdp_flush */
 		3 + /* hdp invalidate */
-		6 + /* sdma_v3_0_ring_emit_pipeline_sync */
-		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + /* sdma_v3_0_ring_emit_vm_flush */
-		10 + 10 + 10, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
+		6 + 1 + /* sdma_v3_0_ring_emit_pipeline_sync */
+		VI_FLUSH_GPU_TLB_NUM_WREG * 3 + 6 + 1 + /* sdma_v3_0_ring_emit_vm_flush */
+		(10 + 1) * 3, /* sdma_v3_0_ring_emit_fence x3 for user fence, vm fence */
 	.emit_ib_size = 7 + 6, /* sdma_v3_0_ring_emit_ib */
 	.emit_ib = sdma_v3_0_ring_emit_ib,
 	.emit_fence = sdma_v3_0_ring_emit_fence,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
index b54359efac06..9c4c782c99aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -955,7 +955,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
 
 static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCE,
-	.align_mask = 0xf,
+	.align_mask = 0x1f,
 	.nop = VCE_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 9e42cc8dd133..f8761a64a6e1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -80,6 +80,7 @@
 #define PP_OD_FEATURE_FAN_TARGET_TEMPERATURE		9
 #define PP_OD_FEATURE_FAN_MINIMUM_PWM			10
 #define PP_OD_FEATURE_FAN_ZERO_RPM_ENABLE		11
+#define PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP		12
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -1034,6 +1035,10 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		od_min_setting = overdrive_lowerlimits->FanZeroRpmEnable;
 		od_max_setting = overdrive_upperlimits->FanZeroRpmEnable;
 		break;
+	case PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP:
+		od_min_setting = pptable->SkuTable.MsgLimits.FanStopTempMin;
+		od_max_setting = pptable->SkuTable.MsgLimits.FanStopTempMax;
+		break;
 	default:
 		od_min_setting = od_max_setting = INT_MAX;
 		break;
@@ -1330,6 +1335,24 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 				      min_value, max_value);
 		break;
 
+	case SMU_OD_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu,
+							 PP_OD_FEATURE_ZERO_FAN_BIT))
+			break;
+
+		size += sysfs_emit_at(buf, size, "FAN_ZERO_RPM_STOP_TEMPERATURE:\n");
+		size += sysfs_emit_at(buf, size, "%d\n",
+					(int)od_table->OverDriveTable.FanZeroRpmStopTemp);
+
+		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &min_value,
+						  &max_value);
+		size += sysfs_emit_at(buf, size, "ZERO_RPM_STOP_TEMPERATURE: %u %u\n",
+				      min_value, max_value);
+		break;
+
 	case SMU_OD_RANGE:
 		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_GFXCLK_BIT) &&
 		    !smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_UCLK_BIT) &&
@@ -2317,7 +2340,9 @@ static void smu_v14_0_2_set_supported_od_feature_mask(struct smu_context *smu)
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_RETRIEVE |
 					    OD_OPS_SUPPORT_FAN_MINIMUM_PWM_SET |
 					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_RETRIEVE |
-					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET;
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_ENABLE_SET |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_RETRIEVE |
+					    OD_OPS_SUPPORT_FAN_ZERO_RPM_STOP_TEMP_SET;
 }
 
 static int smu_v14_0_2_get_overdrive_table(struct smu_context *smu,
@@ -2398,6 +2423,8 @@ static int smu_v14_0_2_set_default_od_settings(struct smu_context *smu)
 			user_od_table_bak.OverDriveTable.FanMinimumPwm;
 		user_od_table->OverDriveTable.FanZeroRpmEnable =
 			user_od_table_bak.OverDriveTable.FanZeroRpmEnable;
+		user_od_table->OverDriveTable.FanZeroRpmStopTemp =
+			user_od_table_bak.OverDriveTable.FanZeroRpmStopTemp;
 	}
 
 	smu_v14_0_2_set_supported_od_feature_mask(smu);
@@ -2452,6 +2479,11 @@ static int smu_v14_0_2_od_restore_table_single(struct smu_context *smu, long inp
 					boot_overdrive_table->OverDriveTable.FanZeroRpmEnable;
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		od_table->OverDriveTable.FanZeroRpmStopTemp =
+					boot_overdrive_table->OverDriveTable.FanZeroRpmStopTemp;
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
 	case PP_OD_EDIT_ACOUSTIC_LIMIT:
 		od_table->OverDriveTable.AcousticLimitRpmThreshold =
 					boot_overdrive_table->OverDriveTable.AcousticLimitRpmThreshold;
@@ -2758,6 +2790,27 @@ static int smu_v14_0_2_od_edit_dpm_table(struct smu_context *smu,
 		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
 		break;
 
+	case PP_OD_EDIT_FAN_ZERO_RPM_STOP_TEMP:
+		if (!smu_v14_0_2_is_od_feature_supported(smu, PP_OD_FEATURE_ZERO_FAN_BIT)) {
+			dev_warn(adev->dev, "Zero RPM setting not supported!\n");
+			return -ENOTSUPP;
+		}
+
+		smu_v14_0_2_get_od_setting_limits(smu,
+						  PP_OD_FEATURE_FAN_ZERO_RPM_STOP_TEMP,
+						  &minimum,
+						  &maximum);
+		if (input[0] < minimum ||
+		    input[0] > maximum) {
+			dev_info(adev->dev, "zero RPM stop temperature setting(%ld) must be within [%d, %d]!\n",
+				 input[0], minimum, maximum);
+			return -EINVAL;
+		}
+
+		od_table->OverDriveTable.FanZeroRpmStopTemp = input[0];
+		od_table->OverDriveTable.FeatureCtrlMask |= BIT(PP_OD_FEATURE_ZERO_FAN_BIT);
+		break;
+
 	case PP_OD_RESTORE_DEFAULT_TABLE:
 		if (size == 1) {
 			ret = smu_v14_0_2_od_restore_table_single(smu, input[0]);
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 5c97f8ba8498..3e775cefa3d0 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -51,6 +51,16 @@
 /* Dummy value used to initially enter the retry loop */
 #define DRM_EXEC_DUMMY ((void *)~0)
 
+/* Unlock and put the prelocked obj */
+static void drm_exec_drop_prelocked(struct drm_exec *exec)
+{
+	if (exec->prelocked) {
+		dma_resv_unlock(exec->prelocked->resv);
+		drm_gem_object_put(exec->prelocked);
+		exec->prelocked = NULL;
+	}
+}
+
 /* Unlock all objects and drop references */
 static void drm_exec_unlock_all(struct drm_exec *exec)
 {
@@ -61,8 +71,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 		drm_gem_object_put(obj);
 	}
 
-	drm_gem_object_put(exec->prelocked);
-	exec->prelocked = NULL;
+	drm_exec_drop_prelocked(exec);
 }
 
 /**
@@ -121,6 +130,14 @@ EXPORT_SYMBOL(drm_exec_fini);
 bool drm_exec_cleanup(struct drm_exec *exec)
 {
 	if (likely(!exec->contended)) {
+
+		/*
+		 * The contended and prelocked object might never be passed to
+		 * drm_exec_lock_obj() again. This can happen when the object
+		 * is about to be cleaned up and we now hold the last reference
+		 * to it. Make sure that we don't unnecessarily keep it around.
+		 */
+		drm_exec_drop_prelocked(exec);
 		ww_acquire_done(&exec->ticket);
 		return false;
 	}
@@ -178,16 +195,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
 		dma_resv_lock_slow(obj->resv, &exec->ticket);
 	}
 
-	ret = drm_exec_obj_locked(exec, obj);
-	if (unlikely(ret))
-		goto error_unlock;
+	/*
+	 * It is perfectly possible that we see another contention before the
+	 * first one is fully handled.
+	 */
+	drm_exec_drop_prelocked(exec);
 
+	/* We move the reference from contended to prelocked here */
 	exec->prelocked = obj;
 	return 0;
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
-
 error_dropref:
 	drm_gem_object_put(obj);
 	return ret;
@@ -215,35 +232,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
 	if (exec->prelocked == obj) {
 		drm_gem_object_put(exec->prelocked);
 		exec->prelocked = NULL;
-		return 0;
-	}
+	} else {
+		if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
+			ret = dma_resv_lock_interruptible(obj->resv,
+							  &exec->ticket);
+		else
+			ret = dma_resv_lock(obj->resv, &exec->ticket);
+
+		if (unlikely(ret == -EDEADLK)) {
+			drm_gem_object_get(obj);
+			exec->contended = obj;
+			return -EDEADLK;
+		}
 
-	if (exec->flags & DRM_EXEC_INTERRUPTIBLE_WAIT)
-		ret = dma_resv_lock_interruptible(obj->resv, &exec->ticket);
-	else
-		ret = dma_resv_lock(obj->resv, &exec->ticket);
+		if (unlikely(ret == -EALREADY) &&
+		    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
+			return 0;
 
-	if (unlikely(ret == -EDEADLK)) {
-		drm_gem_object_get(obj);
-		exec->contended = obj;
-		return -EDEADLK;
+		if (unlikely(ret))
+			return ret;
 	}
 
-	if (unlikely(ret == -EALREADY) &&
-	    exec->flags & DRM_EXEC_IGNORE_DUPLICATES)
-		return 0;
-
-	if (unlikely(ret))
-		return ret;
-
 	ret = drm_exec_obj_locked(exec, obj);
 	if (ret)
-		goto error_unlock;
-
-	return 0;
+		dma_resv_unlock(obj->resv);
 
-error_unlock:
-	dma_resv_unlock(obj->resv);
 	return ret;
 }
 EXPORT_SYMBOL(drm_exec_lock_obj);
diff --git a/drivers/gpu/drm/i915/display/intel_cx0_phy.c b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
index a2d2cecf7121..93e795307ea6 100644
--- a/drivers/gpu/drm/i915/display/intel_cx0_phy.c
+++ b/drivers/gpu/drm/i915/display/intel_cx0_phy.c
@@ -2202,12 +2202,14 @@ static void intel_c10pll_dump_hw_state(struct intel_display *display,
 static bool is_arrowlake_s_by_host_bridge(void)
 {
 	struct pci_dev *pdev = NULL;
-	u16 host_bridge_pci_dev_id;
-
-	while ((pdev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, pdev)))
-		host_bridge_pci_dev_id = pdev->device;
+	while ((pdev = pci_get_class(PCI_CLASS_BRIDGE_HOST << 8, pdev))) {
+		if (IS_ARROWLAKE_S_BY_HOST_BRIDGE_ID(pdev->device)) {
+			pci_dev_put(pdev);
+			return true;
+		}
+	}
 
-	return pdev && IS_ARROWLAKE_S_BY_HOST_BRIDGE_ID(host_bridge_pci_dev_id);
+	return false;
 }
 
 static u16 intel_c20_hdmi_tmds_tx_cgf_1(struct intel_crtc_state *crtc_state)
diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 9b6b90be02fe..a341a3fb1e47 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -986,6 +986,55 @@ static void dmc_set_fw_offset(struct intel_dmc *dmc,
 	}
 }
 
+/*
+ * Check if the load address is within the valid range for the given DMC ID.
+ */
+static bool dmc_load_addr_sanity_check(struct intel_dmc *dmc,
+				       u32 start_addr, u32 payload_size,
+				       int header_ver, enum intel_dmc_id dmc_id)
+{
+	u32 start_range, end_range, end_addr;
+
+	if (header_ver != 3)
+		return true;
+
+	switch (dmc_id) {
+	case DMC_FW_MAIN:
+		start_range = DMC_MAIN_PROGRAM_BASE_START;
+		end_range = DMC_MAIN_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEA:
+		start_range = DMC_PIPEA_PROGRAM_BASE_START;
+		end_range = DMC_PIPEA_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEB:
+		start_range = DMC_PIPEB_PROGRAM_BASE_START;
+		end_range = DMC_PIPEB_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPEC:
+		start_range = DMC_PIPEC_PROGRAM_BASE_START;
+		end_range = DMC_PIPEC_PROGRAM_BASE_END;
+		break;
+	case DMC_FW_PIPED:
+		start_range = DMC_PIPED_PROGRAM_BASE_START;
+		end_range = DMC_PIPED_PROGRAM_BASE_END;
+		break;
+	default:
+		MISSING_CASE(dmc_id);
+		return false;
+	}
+
+	if (payload_size == 0)
+		end_addr = start_addr;
+	else if (check_add_overflow(start_addr, payload_size - 1, &end_addr))
+		return false;
+
+	if (start_addr < start_range || end_addr > end_range)
+		return false;
+
+	return true;
+}
+
 static bool dmc_mmio_addr_sanity_check(struct intel_dmc *dmc,
 				       const u32 *mmioaddr, u32 mmio_count,
 				       int header_ver, enum intel_dmc_id dmc_id)
@@ -1083,7 +1132,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(display->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -1129,13 +1178,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 			    disable_dmc_evt(display, dmc_id, dmc_info->mmioaddr[i],
 					    dmc_info->mmiodata[i]) ? " (disabling)" : "");
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(display->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(display->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -1143,12 +1200,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(display->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
+	if (!dmc_load_addr_sanity_check(dmc, start_mmioaddr, payload_size,
+					dmc_header->header_ver, dmc_id)) {
+		drm_err(display->drm, "DMC %d: firmware has wrong load address\n", dmc_id);
+		return 0;
+	}
 
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!dmc_info->payload)
 		return 0;
 
+	dmc_info->mmio_count = mmio_count;
+	dmc_info->start_mmioaddr = start_mmioaddr;
+	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(dmc_info->payload, payload, payload_size);
 
diff --git a/drivers/gpu/drm/i915/display/intel_dmc_regs.h b/drivers/gpu/drm/i915/display/intel_dmc_regs.h
index c5aa49921cb9..b6eecdbc7614 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc_regs.h
+++ b/drivers/gpu/drm/i915/display/intel_dmc_regs.h
@@ -521,6 +521,18 @@ enum pipedmc_event_id {
 #define TGL_PIPE_MMIO_END(dmc_id)	_PICK_EVEN(((dmc_id) - 1), _TGL_PIPEA_MMIO_END,\
 					      _TGL_PIPEB_MMIO_END)
 
+/* For DMC header version v3*/
+#define DMC_MAIN_PROGRAM_BASE_START	0x80000
+#define DMC_MAIN_PROGRAM_BASE_END	0x86fff
+#define DMC_PIPEA_PROGRAM_BASE_START	0x90000
+#define DMC_PIPEA_PROGRAM_BASE_END	0x96fff
+#define DMC_PIPEB_PROGRAM_BASE_START	0x98000
+#define DMC_PIPEB_PROGRAM_BASE_END	0x9efff
+#define DMC_PIPEC_PROGRAM_BASE_START	0x52000
+#define DMC_PIPEC_PROGRAM_BASE_END	0x53fff
+#define DMC_PIPED_PROGRAM_BASE_START	0x59000
+#define DMC_PIPED_PROGRAM_BASE_END	0x5afff
+
 #define SKL_DMC_DC3_DC5_COUNT	_MMIO(0x80030)
 #define SKL_DMC_DC5_DC6_COUNT	_MMIO(0x8002C)
 #define BXT_DMC_DC3_DC5_COUNT	_MMIO(0x80038)
diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
index 4f2858114e5e..9a567e4f0956 100644
--- a/drivers/gpu/drm/panthor/panthor_hw.c
+++ b/drivers/gpu/drm/panthor/panthor_hw.c
@@ -27,7 +27,7 @@ static char *get_gpu_model_name(struct panthor_device *ptdev)
 	case GPU_PROD_ID_MAKE(10, 7):
 		return "Mali-G610";
 	case GPU_PROD_ID_MAKE(11, 2):
-		if (shader_core_count > 10 && ray_intersection)
+		if (shader_core_count >= 10 && ray_intersection)
 			return "Mali-G715-Immortalis";
 		else if (shader_core_count >= 7)
 			return "Mali-G715";
diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 493471012820..de04814a2e96 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1176,7 +1176,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 34b974f46f87..2f854386c338 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -816,7 +816,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
-	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
 
 	HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_CLRRGB);
 
@@ -1588,9 +1588,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ONCE(ret, "Timeout waiting for "
 			  "VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE\n");
 	} else {
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   HDMI_READ(HDMI_RAM_PACKET_CONFIG) &
-			   ~(VC4_HDMI_RAM_PACKET_ENABLE));
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			   ~VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
@@ -1609,9 +1606,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
 
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   VC4_HDMI_RAM_PACKET_ENABLE);
-
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 		vc4_hdmi->packet_ram_enabled = true;
 
@@ -3072,6 +3066,11 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 
 	clk_disable_unprepare(vc4_hdmi->audio_clock);
 	clk_disable_unprepare(vc4_hdmi->hsm_clock);
@@ -3082,9 +3081,8 @@ static int vc4_hdmi_runtime_suspend(struct device *dev)
 static int vc4_hdmi_runtime_resume(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
-	unsigned long __maybe_unused flags;
+	unsigned long rate, flags;
 	u32 __maybe_unused value;
-	unsigned long rate;
 	int ret;
 
 	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
@@ -3130,6 +3128,10 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	}
 #endif
 
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
+
 	return 0;
 
 err_disable_clk:
diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 6d3db1517c8a..2496b24840be 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -313,6 +313,12 @@ static void xe_evict_flags(struct ttm_buffer_object *tbo,
 		return;
 	}
 
+	/* No resource: nothing is placed/mapped, so there is nothing to evict. */
+	if (!tbo->resource) {
+		placement->num_placement = 0;
+		return;
+	}
+
 	bo = ttm_to_xe_bo(tbo);
 	if (bo->flags & XE_BO_FLAG_CPU_ADDR_MIRROR) {
 		*placement = sys_placement;
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index c156cf4661f2..25124159a363 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -346,11 +346,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
 	xe_sched_job_push(job);
 	xe_vm_reactivate_rebind(vm);
 
-	if (!err && !xe_vm_in_lr_mode(vm)) {
-		spin_lock(&xe->ttm.lru_lock);
-		ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-		spin_unlock(&xe->ttm.lru_lock);
-	}
+	if (!err && !xe_vm_in_lr_mode(vm))
+		xe_vm_bump_lru(vm, exec);
 
 	if (mode == EXEC_MODE_LR)
 		xe_hw_engine_group_resume_faulting_lr_jobs(group);
diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index a753ac7ecc86..b88d3d39aea6 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -893,6 +893,13 @@ static int xe_oa_alloc_oa_buffer(struct xe_oa_stream *stream, size_t size)
 	if (IS_ERR(bo))
 		return PTR_ERR(bo);
 
+	/*
+	 * ttm_bo_type_kernel BOs are not zeroed on allocation, so the buffer can
+	 * hold stale data from previously freed pages. Since the OA buffer is
+	 * mmap'able by userspace, clear it here to avoid leaking kernel memory.
+	 */
+	xe_map_memset(stream->oa->xe, &bo->vmap, 0, 0, xe_bo_size(bo));
+
 	stream->oa_buffer.bo = bo;
 	/* mmap implementation requires OA buffer to be in system memory */
 	xe_assert(stream->oa->xe, bo->vmap.is_iomem == 0);
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index a4272bc248ec..72ec3f1533d0 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -376,6 +376,33 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 	return 0;
 }
 
+/**
+ * xe_vm_bump_lru() - Bump the LRU position of BOs used by a submission
+ * @vm: The vm for which we are bumping LRUs.
+ * @exec: The struct drm_exec with the locked GEM objects.
+ *
+ * Move the VM's private BOs, and all external objects locked by @exec,
+ * to the LRU tail. Private BOs are moved in bulk using @vm's
+ * &xe_vm.lru_bulk_move. External objects, which may be shared with other
+ * VMs, are not part of that bulk move and are bumped individually.
+ */
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec)
+{
+	spinlock_t *lru_lock = &vm->xe->ttm.lru_lock;
+	struct drm_gem_object *obj;
+
+	spin_lock(lru_lock);
+	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
+	drm_exec_for_each_locked_object(exec, obj) {
+		if (!drm_gpuvm_is_extobj(&vm->gpuvm, obj))
+			continue;
+
+		ttm_bo_move_to_lru_tail(&gem_to_xe_bo(obj)->ttm);
+		cond_resched_lock(lru_lock);
+	}
+	spin_unlock(lru_lock);
+}
+
 static int xe_preempt_work_begin(struct drm_exec *exec, struct xe_vm *vm,
 				 bool *done)
 {
@@ -524,9 +551,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 #undef retry_required
 
-	spin_lock(&vm->xe->ttm.lru_lock);
-	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-	spin_unlock(&vm->xe->ttm.lru_lock);
+	xe_vm_bump_lru(vm, &exec);
 
 	/* Point of no return. */
 	arm_preempt_fences(vm, &preempt_fences);
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index 016f6786134c..6589b36d49d6 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -265,6 +265,8 @@ int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences);
 
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec);
+
 struct dma_fence *xe_vm_bind_kernel_bo(struct xe_vm *vm, struct xe_bo *bo,
 				       struct xe_exec_queue *q, u64 addr,
 				       enum xe_cache_level cache_lvl);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index d5348195e4fb..5f013d4582d7 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -744,13 +744,14 @@ static void init_vp_index(struct vmbus_channel *channel)
 	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
 	struct cpumask *allocated_mask;
+	const struct cpumask *node_mask;
 	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	u32 target_cpu;
 	int numa_node;
 
 	if (!perf_chn ||
 	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
-	    cpumask_empty(hk_mask)) {
+	    !cpumask_intersects(hk_mask, cpu_online_mask)) {
 		/*
 		 * If the channel is not a performance critical
 		 * channel, bind it to VMBUS_CONNECT_CPU.
@@ -772,14 +773,19 @@ static void init_vp_index(struct vmbus_channel *channel)
 				next_numa_node_id = 0;
 				continue;
 			}
-			if (cpumask_empty(cpumask_of_node(numa_node)))
+			/*
+			 * Try next NUMA node if current NUMA node has no CPU
+			 * or doesn't contain any housekeeping CPU.
+			 */
+			node_mask = cpumask_of_node(numa_node);
+			if (!cpumask_intersects(node_mask, hk_mask))
 				continue;
 			break;
 		}
 		allocated_mask = &hv_context.hv_numa_map[numa_node];
 
 retry:
-		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
+		cpumask_xor(available_mask, allocated_mask, node_mask);
 		cpumask_and(available_mask, available_mask, hk_mask);
 
 		if (cpumask_empty(available_mask)) {
diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 9be2af772867..4a3bb9ae9250 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -340,7 +340,6 @@ int vmbus_connect(void)
 cleanup:
 	pr_err("Unable to connect to host\n");
 
-	vmbus_connection.conn_state = DISCONNECTED;
 	vmbus_disconnect();
 
 	kfree(msginfo);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b1552a26b8d3..1dc371eb5340 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -3018,7 +3018,6 @@ static void __exit vmbus_exit(void)
 
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
-	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	if (vmbus_irq == -1) {
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index 52ef7f07c51c..38d7d4f479bd 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -167,12 +167,12 @@ static irqreturn_t cci_isr(int irq, void *dev)
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M0_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M0_MASK;
+		reset |= CCI_RESET_CMD_M0_MASK;
 		ret = IRQ_HANDLED;
 	}
 
 	if (unlikely(val & CCI_IRQ_STATUS_0_I2C_M1_Q0Q1_HALT_ACK)) {
-		reset = CCI_RESET_CMD_M1_MASK;
+		reset |= CCI_RESET_CMD_M1_MASK;
 		ret = IRQ_HANDLED;
 	}
 
diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 307e2e4030af..fbfffbec05e1 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -169,28 +169,31 @@ static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
 static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
-	unsigned long res_freq;
+	unsigned long req_freq, res_freq;
+	int ret;
 
 	/*
-	 * Frequency counter tables are calibrated for a specific source
-	 * clock frequency and are not valid for any multiple of it
-	 * (e.g. 64 MHz, 128 MHz).
-	 * Use exact=true and verify res_freq matches req_freq literally
-	 * to reject harmonics: a 64 MHz clock that divides evenly to
-	 * 32 MHz would pass exact matching but produce double the intended
-	 * I2C frequency with these counter values.
+	 * Use 32 MHz only if already selected, otherwise use 19.2 MHz.
+	 * Preferring 32 MHz merely because DFS supports it breaks I2C
+	 * transfers on X1E80100 CRD.
 	 */
-	if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_32MHZ,
-				    &gi2c->clk_idx, &res_freq, true) &&
-	    res_freq == GENI_SE_CLK_32MHZ) {
+	if (clk_get_rate(gi2c->se.clk) == GENI_SE_CLK_32MHZ) {
+		req_freq = GENI_SE_CLK_32MHZ;
 		itr = geni_i2c_clk_map_32mhz;
-	} else if (!geni_se_clk_freq_match(&gi2c->se, GENI_SE_CLK_19P2MHZ,
-					   &gi2c->clk_idx, &res_freq, true) &&
-		   res_freq == GENI_SE_CLK_19P2MHZ) {
-		itr = geni_i2c_clk_map_19p2mhz;
 	} else {
-		dev_err(gi2c->se.dev,
-			"Unsupported SE source clock: must be exactly 32 MHz or 19.2 MHz\n");
+		req_freq = GENI_SE_CLK_19P2MHZ;
+		itr = geni_i2c_clk_map_19p2mhz;
+	}
+
+	ret = geni_se_clk_freq_match(&gi2c->se, req_freq, &gi2c->clk_idx,
+				     &res_freq, true);
+	if (ret)
+		return dev_err_probe(gi2c->se.dev, ret,
+				     "Failed to find SE source clock %lu Hz\n",
+				     req_freq);
+	if (res_freq != req_freq) {
+		dev_err(gi2c->se.dev, "Unsupported SE source clock %lu Hz\n",
+			res_freq);
 		return -EINVAL;
 	}
 
diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index 2cf3cc0165fb..74ca93b44347 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				"failed to request irq %i\n", i2c->irq);
 
-	i2c->clk = of_clk_get(np, 0);
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(i2c->clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
 				     "unable to request clock\n");
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index bb0b484d4d68..849c4866e632 100644
--- a/drivers/md/dm-cache-target.c
+++ b/drivers/md/dm-cache-target.c
@@ -339,8 +339,6 @@ struct cache {
 	struct list_head invalidation_requests;
 
 	sector_t migration_threshold;
-	wait_queue_head_t migration_wait;
-	atomic_t nr_allocated_migrations;
 
 	/*
 	 * The number of in flight migrations that are performing
@@ -396,7 +394,11 @@ struct cache {
 	bool loaded_mappings:1;
 	bool loaded_discards:1;
 
-	struct rw_semaphore background_work_lock;
+	/* background work management */
+	bool background_work_allowed;
+	unsigned background_work_nr;
+	spinlock_t background_work_lock;
+	wait_queue_head_t background_work_wait;
 
 	struct batcher committer;
 	struct work_struct commit_ws;
@@ -487,19 +489,13 @@ static struct dm_cache_migration *alloc_migration(struct cache *cache)
 	memset(mg, 0, sizeof(*mg));
 
 	mg->cache = cache;
-	atomic_inc(&cache->nr_allocated_migrations);
 
 	return mg;
 }
 
 static void free_migration(struct dm_cache_migration *mg)
 {
-	struct cache *cache = mg->cache;
-
-	if (atomic_dec_and_test(&cache->nr_allocated_migrations))
-		wake_up(&cache->migration_wait);
-
-	mempool_free(mg, &cache->migration_pool);
+	mempool_free(mg, &mg->cache->migration_pool);
 }
 
 /*----------------------------------------------------------------*/
@@ -1029,34 +1025,39 @@ static void calc_discard_block_range(struct cache *cache, struct bio *bio,
 
 static void prevent_background_work(struct cache *cache)
 {
-	lockdep_off();
-	down_write(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	cache->background_work_allowed = false;
+	wait_event_lock_irq(cache->background_work_wait,
+			    cache->background_work_nr == 0,
+			    cache->background_work_lock);
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 static void allow_background_work(struct cache *cache)
 {
-	lockdep_off();
-	up_write(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	cache->background_work_allowed = true;
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 static bool background_work_begin(struct cache *cache)
 {
 	bool r;
 
-	lockdep_off();
-	r = down_read_trylock(&cache->background_work_lock);
-	lockdep_on();
-
+	spin_lock_irq(&cache->background_work_lock);
+	r = cache->background_work_allowed;
+	if (r)
+		cache->background_work_nr++;
+	spin_unlock_irq(&cache->background_work_lock);
 	return r;
 }
 
 static void background_work_end(struct cache *cache)
 {
-	lockdep_off();
-	up_read(&cache->background_work_lock);
-	lockdep_on();
+	spin_lock_irq(&cache->background_work_lock);
+	if (--cache->background_work_nr == 0)
+		wake_up(&cache->background_work_wait);
+	spin_unlock_irq(&cache->background_work_lock);
 }
 
 /*----------------------------------------------------------------*/
@@ -1461,6 +1462,9 @@ static void invalidate_complete(struct dm_cache_migration *mg, bool success)
 	struct bio_list bios;
 	struct cache *cache = mg->cache;
 
+	if (success)
+		atomic_inc(&cache->stats.demotion);
+
 	bio_list_init(&bios);
 	if (mg->cell) {
 		if (dm_cell_unlock_v2(cache->prison, mg->cell, &bios))
@@ -1732,7 +1736,6 @@ static int map_bio(struct cache *cache, struct bio *bio, dm_oblock_t block,
 		if (passthrough_mode(cache)) {
 			if (bio_data_dir(bio) == WRITE) {
 				bio_drop_shared_lock(cache, bio);
-				atomic_inc(&cache->stats.demotion);
 				invalidate_start(cache, cblock, block, bio);
 				return DM_MAPIO_SUBMITTED;
 			} else
@@ -2513,9 +2516,7 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 
 	spin_lock_init(&cache->lock);
 	bio_list_init(&cache->deferred_bios);
-	atomic_set(&cache->nr_allocated_migrations, 0);
 	atomic_set(&cache->nr_io_migrations, 0);
-	init_waitqueue_head(&cache->migration_wait);
 
 	r = -ENOMEM;
 	atomic_set(&cache->nr_dirty, 0);
@@ -2598,8 +2599,10 @@ static int cache_create(struct cache_args *ca, struct cache **result)
 		     issue_op, cache, cache->wq);
 	dm_iot_init(&cache->tracker);
 
-	init_rwsem(&cache->background_work_lock);
-	prevent_background_work(cache);
+	init_waitqueue_head(&cache->background_work_wait);
+	spin_lock_init(&cache->background_work_lock);
+	cache->background_work_allowed = false;
+	cache->background_work_nr = 0;
 
 	*result = cache;
 	return 0;
diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index db8108acb312..893355ee7d8e 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1820,7 +1820,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 	struct bio *base_bio = io->base_bio;
-	blk_status_t error = io->error;
 
 	if (!atomic_dec_and_test(&io->io_pending))
 		return;
@@ -1842,7 +1841,7 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 	else
 		kfree(io->integrity_metadata);
 
-	base_bio->bi_status = error;
+	base_bio->bi_status = io->error;
 
 	bio_endio(base_bio);
 }
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index b354e74a670e..9301c9f55085 100644
--- a/drivers/md/dm-ebs-target.c
+++ b/drivers/md/dm-ebs-target.c
@@ -265,8 +265,7 @@ static int ebs_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 
 	r = -EINVAL;
 	if (sscanf(argv[1], "%llu%c", &tmp, &dummy) != 1 ||
-	    tmp != (sector_t)tmp ||
-	    (sector_t)tmp >= ti->len) {
+	    tmp != (sector_t)tmp) {
 		ti->error = "Invalid device offset sector";
 		goto bad;
 	}
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 24d2e76c21a9..400bb77f33ed 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1979,7 +1979,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = (max_size - extra_space) / ic->tag_size;
 			sector_t sector = dio->range.logical_sector;
 
@@ -4179,6 +4179,10 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->discard_granularity = ic->sectors_per_block << SECTOR_SHIFT;
 	}
 
+	if (ic->internal_hash &&
+	    (ic->mode == 'D' || ic->mode == 'B' || ic->mode == 'I'))
+		limits->features |= BLK_FEAT_STABLE_WRITES;
+
 	if (!ic->internal_hash) {
 		struct blk_integrity *bi = &limits->integrity;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 5a891cf59f10..75bfd74b391b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2149,6 +2149,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
 		goto out;
 	}
 
+	/* We store Tx state in the control block, so the skb must not be
+	 * shared, but ether_setup() leaves IFF_TX_SKB_SHARING set.
+	 */
+	skb = skb_share_check(skb, GFP_ATOMIC);
+	if (!skb) {
+		BCMGENET_STATS64_INC((&ring->stats64), dropped);
+		ret = NETDEV_TX_OK;
+		goto out;
+	}
+
 	/* Retain how many bytes will be sent on the wire, without TSB inserted
 	 * by transmit checksum offload
 	 */
diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 122ee23497e6..288fa8ce53af 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -296,6 +296,7 @@ config ICE
 	depends on GNSS || GNSS = n
 	select AUXILIARY_BUS
 	select DIMLIB
+	select LIBETH_XDP
 	select LIBIE
 	select LIBIE_ADMINQ
 	select LIBIE_FWLOG if DEBUG_FS
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 2b285ffa9d4b..c2332a7a8c87 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -374,6 +374,8 @@ struct ice_vsi {
 	spinlock_t arfs_lock;	/* protects aRFS hash table and filter state */
 	atomic_t *arfs_last_fltr_id;
 
+	u16 max_frame;
+
 	struct ice_aqc_vsi_props info;	 /* VSI properties */
 	struct ice_vsi_vlan_info vlan_info;	/* vlan config to be restored */
 
@@ -509,7 +511,6 @@ enum ice_pf_flags {
 	ICE_FLAG_MOD_POWER_UNSUPPORTED,
 	ICE_FLAG_PHY_FW_LOAD_FAILED,
 	ICE_FLAG_ETHTOOL_CTXT,		/* set when ethtool holds RTNL lock */
-	ICE_FLAG_LEGACY_RX,
 	ICE_FLAG_VF_TRUE_PROMISC_ENA,
 	ICE_FLAG_MDD_AUTO_RESET_VF,
 	ICE_FLAG_VF_VLAN_PRUNING,
diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 2d35a278c555..2d3d23450783 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019, Intel Corporation. */
 
 #include <net/xdp_sock_drv.h>
+#include <linux/net/intel/libie/rx.h>
 #include "ice_base.h"
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
@@ -123,6 +124,8 @@ static int ice_vsi_alloc_q_vector(struct ice_vsi *vsi, u16 v_idx)
 	if (vsi->type == ICE_VSI_VF) {
 		ice_calc_vf_reg_idx(vsi->vf, q_vector);
 		goto out;
+	} else if (vsi->type == ICE_VSI_LB) {
+		goto skip_alloc;
 	} else if (vsi->type == ICE_VSI_CTRL && vsi->vf) {
 		struct ice_vsi *ctrl_vsi = ice_get_vf_ctrl_vsi(pf, vsi);
 
@@ -461,19 +464,6 @@ u16 ice_calc_ts_ring_count(struct ice_tx_ring *tx_ring)
 	return tx_ring->count + max_fetch_desc;
 }
 
-/**
- * ice_rx_offset - Return expected offset into page to access data
- * @rx_ring: Ring we are requesting offset of
- *
- * Returns the offset value for ring into the data buffer.
- */
-static unsigned int ice_rx_offset(struct ice_rx_ring *rx_ring)
-{
-	if (ice_ring_uses_build_skb(rx_ring))
-		return ICE_SKB_PAD;
-	return 0;
-}
-
 /**
  * ice_setup_rx_ctx - Configure a receive ring context
  * @ring: The Rx ring to configure
@@ -549,7 +539,7 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	/* Max packet size for this queue - must not be set to a larger value
 	 * than 5 x DBUF
 	 */
-	rlan_ctx.rxmax = min_t(u32, ring->max_frame,
+	rlan_ctx.rxmax = min_t(u32, vsi->max_frame,
 			       ICE_MAX_CHAINED_RX_BUFS * ring->rx_buf_len);
 
 	/* Rx queue threshold in units of 64 */
@@ -586,14 +576,6 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	if (vsi->type == ICE_VSI_VF)
 		return 0;
 
-	/* configure Rx buffer alignment */
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		ice_clear_ring_build_skb_ena(ring);
-	else
-		ice_set_ring_build_skb_ena(ring);
-
-	ring->rx_offset = ice_rx_offset(ring);
-
 	/* init queue specific tail register */
 	ring->tail = hw->hw_addr + QRX_TAIL(pf_q);
 	writel(0, ring->tail);
@@ -601,38 +583,6 @@ static int ice_setup_rx_ctx(struct ice_rx_ring *ring)
 	return 0;
 }
 
-static void ice_xsk_pool_fill_cb(struct ice_rx_ring *ring)
-{
-	void *ctx_ptr = &ring->pkt_ctx;
-	struct xsk_cb_desc desc = {};
-
-	XSK_CHECK_PRIV_TYPE(struct ice_xdp_buff);
-	desc.src = &ctx_ptr;
-	desc.off = offsetof(struct ice_xdp_buff, pkt_ctx) -
-		   sizeof(struct xdp_buff);
-	desc.bytes = sizeof(ctx_ptr);
-	xsk_pool_fill_cb(ring->xsk_pool, &desc);
-}
-
-/**
- * ice_get_frame_sz - calculate xdp_buff::frame_sz
- * @rx_ring: the ring being configured
- *
- * Return frame size based on underlying PAGE_SIZE
- */
-static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
-{
-	unsigned int frame_sz;
-
-#if (PAGE_SIZE >= 8192)
-	frame_sz = rx_ring->rx_buf_len;
-#else
-	frame_sz = ice_rx_pg_size(rx_ring) / 2;
-#endif
-
-	return frame_sz;
-}
-
 /**
  * ice_vsi_cfg_rxq - Configure an Rx queue
  * @ring: the ring being configured
@@ -641,11 +591,19 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
  */
 static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
+	struct libeth_fq fq = {
+		.count		= ring->count,
+		.nid		= NUMA_NO_NODE,
+		.xdp		= ice_is_xdp_ena_vsi(ring->vsi),
+		.buf_len	= LIBIE_MAX_RX_BUF_LEN,
+	};
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
-	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
+	u32 num_bufs = ICE_DESC_UNUSED(ring);
+	u32 rx_buf_len;
 	int err;
 
-	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF) {
+	if (ring->vsi->type == ICE_VSI_PF || ring->vsi->type == ICE_VSI_SF ||
+	    ring->vsi->type == ICE_VSI_LB) {
 		if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
@@ -656,15 +614,19 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 		}
 
 		ice_rx_xsk_pool(ring);
+		err = ice_realloc_rx_xdp_bufs(ring, ring->xsk_pool);
+		if (err)
+			return err;
+
 		if (ring->xsk_pool) {
 			xdp_rxq_info_unreg(&ring->xdp_rxq);
 
-			ring->rx_buf_len =
+			rx_buf_len =
 				xsk_pool_get_rx_frame_size(ring->xsk_pool);
 			err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 						 ring->q_index,
 						 ring->q_vector->napi.napi_id,
-						 ring->rx_buf_len);
+						 rx_buf_len);
 			if (err)
 				return err;
 			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
@@ -673,36 +635,38 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 			if (err)
 				return err;
 			xsk_pool_set_rxq_info(ring->xsk_pool, &ring->xdp_rxq);
-			ice_xsk_pool_fill_cb(ring);
 
 			dev_info(dev, "Registered XDP mem model MEM_TYPE_XSK_BUFF_POOL on Rx ring %d\n",
 				 ring->q_index);
 		} else {
+			err = libeth_rx_fq_create(&fq, &ring->q_vector->napi);
+			if (err)
+				return err;
+
+			ring->pp = fq.pp;
+			ring->rx_fqes = fq.fqes;
+			ring->truesize = fq.truesize;
+			ring->rx_buf_len = fq.buf_len;
+
 			if (!xdp_rxq_info_is_reg(&ring->xdp_rxq)) {
 				err = __xdp_rxq_info_reg(&ring->xdp_rxq, ring->netdev,
 							 ring->q_index,
 							 ring->q_vector->napi.napi_id,
 							 ring->rx_buf_len);
 				if (err)
-					return err;
+					goto err_destroy_fq;
 			}
-
-			err = xdp_rxq_info_reg_mem_model(&ring->xdp_rxq,
-							 MEM_TYPE_PAGE_SHARED,
-							 NULL);
-			if (err)
-				return err;
+			xdp_rxq_info_attach_page_pool(&ring->xdp_rxq,
+						      ring->pp);
 		}
 	}
 
-	xdp_init_buff(&ring->xdp, ice_get_frame_sz(ring), &ring->xdp_rxq);
 	ring->xdp.data = NULL;
-	ring->xdp_ext.pkt_ctx = &ring->pkt_ctx;
 	err = ice_setup_rx_ctx(ring);
 	if (err) {
 		dev_err(dev, "ice_setup_rx_ctx failed for RxQ %d, err %d\n",
 			ring->q_index, err);
-		return err;
+		goto err_destroy_fq;
 	}
 
 	if (ring->xsk_pool) {
@@ -730,9 +694,19 @@ static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	if (ring->vsi->type == ICE_VSI_CTRL)
 		ice_init_ctrl_rx_descs(ring, num_bufs);
 	else
-		ice_alloc_rx_bufs(ring, num_bufs);
+		err = ice_alloc_rx_bufs(ring, num_bufs);
+
+	if (err)
+		goto err_destroy_fq;
 
 	return 0;
+
+err_destroy_fq:
+	libeth_rx_fq_destroy(&fq);
+	ring->rx_fqes = NULL;
+	ring->pp = NULL;
+
+	return err;
 }
 
 int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
@@ -753,18 +727,10 @@ int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
  */
 static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi, struct ice_rx_ring *ring)
 {
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		ring->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		ring->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		ring->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		ring->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
+	if (!vsi->netdev) {
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
 	} else {
-		ring->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		ring->rx_buf_len = ICE_RXBUF_3072;
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
 	}
 }
 
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index ec33586b6da5..428118475e2f 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -10,6 +10,7 @@
 #include "ice_lib.h"
 #include "ice_dcb_lib.h"
 #include <net/dcbnl.h>
+#include <net/libeth/rx.h>
 
 struct ice_stats {
 	char stat_string[ETH_GSTRING_LEN];
@@ -340,7 +341,6 @@ static const struct ice_priv_flag ice_gstrings_priv_flags[] = {
 		      ICE_FLAG_VF_TRUE_PROMISC_ENA),
 	ICE_PRIV_FLAG("mdd-auto-reset-vf", ICE_FLAG_MDD_AUTO_RESET_VF),
 	ICE_PRIV_FLAG("vf-vlan-pruning", ICE_FLAG_VF_VLAN_PRUNING),
-	ICE_PRIV_FLAG("legacy-rx", ICE_FLAG_LEGACY_RX),
 };
 
 #define ICE_PRIV_FLAG_ARRAY_SIZE	ARRAY_SIZE(ice_gstrings_priv_flags)
@@ -1223,8 +1223,9 @@ static int ice_diag_send(struct ice_tx_ring *tx_ring, u8 *data, u16 size)
  */
 static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
 {
-	struct ice_rx_buf *rx_buf;
+	struct libeth_fqe *rx_buf;
 	int valid_frames, i;
+	struct page *page;
 	u8 *received_buf;
 
 	valid_frames = 0;
@@ -1239,8 +1240,10 @@ static int ice_lbtest_receive_frames(struct ice_rx_ring *rx_ring)
 		     cpu_to_le16(BIT(ICE_RX_FLEX_DESC_STATUS0_EOF_S)))))
 			continue;
 
-		rx_buf = &rx_ring->rx_buf[i];
-		received_buf = page_address(rx_buf->page) + rx_buf->page_offset;
+		rx_buf = &rx_ring->rx_fqes[i];
+		page = __netmem_to_page(rx_buf->netmem);
+		received_buf = page_address(page) + rx_buf->offset +
+			       page->pp->p.offset;
 
 		if (ice_lbtest_check_frame(received_buf))
 			valid_frames++;
@@ -1278,6 +1281,10 @@ static u64 ice_loopback_test(struct net_device *netdev)
 	test_vsi->netdev = netdev;
 	tx_ring = test_vsi->tx_rings[0];
 	rx_ring = test_vsi->rx_rings[0];
+	/* Dummy q_vector and napi. Fill the minimum required for
+	 * ice_rxq_pp_create().
+	 */
+	rx_ring->q_vector->napi.dev = netdev;
 
 	if (ice_lbtest_prepare_rings(test_vsi)) {
 		ret = 2;
@@ -1848,10 +1855,6 @@ static int ice_set_priv_flags(struct net_device *netdev, u32 flags)
 			ice_nway_reset(netdev);
 		}
 	}
-	if (test_bit(ICE_FLAG_LEGACY_RX, change_flags)) {
-		/* down and up VSI so that changes of Rx cfg are reflected. */
-		ice_down_up(vsi);
-	}
 	/* don't allow modification of this flag when a single VF is in
 	 * promiscuous mode because it's not supported
 	 */
@@ -3309,7 +3312,8 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		rx_rings[i].count = new_rx_cnt;
 		rx_rings[i].cached_phctime = pf->ptp.cached_phc_time;
 		rx_rings[i].desc = NULL;
-		rx_rings[i].rx_buf = NULL;
+		rx_rings[i].xdp_buf = NULL;
+
 		/* this is to allow wr32 to have something to write to
 		 * during early allocation of Rx buffers
 		 */
@@ -3318,10 +3322,6 @@ ice_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		err = ice_setup_rx_ring(&rx_rings[i]);
 		if (err)
 			goto rx_unwind;
-
-		/* allocate Rx buffers */
-		err = ice_alloc_rx_bufs(&rx_rings[i],
-					ICE_RX_DESC_UNUSED(&rx_rings[i]));
 rx_unwind:
 		if (err) {
 			while (i) {
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 6de55d2424f4..80eb5c9f8a9b 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -107,10 +107,6 @@ static int ice_vsi_alloc_arrays(struct ice_vsi *vsi)
 	if (!vsi->rxq_map)
 		goto err_rxq_map;
 
-	/* There is no need to allocate q_vectors for a loopback VSI. */
-	if (vsi->type == ICE_VSI_LB)
-		return 0;
-
 	/* allocate memory for q_vector pointers */
 	vsi->q_vectors = devm_kcalloc(dev, vsi->num_q_vectors,
 				      sizeof(*vsi->q_vectors), GFP_KERNEL);
@@ -239,6 +235,8 @@ static void ice_vsi_set_num_qs(struct ice_vsi *vsi)
 	case ICE_VSI_LB:
 		vsi->alloc_txq = 1;
 		vsi->alloc_rxq = 1;
+		/* A dummy q_vector, no actual IRQ. */
+		vsi->num_q_vectors = 1;
 		break;
 	default:
 		dev_warn(ice_pf_to_dev(pf), "Unknown VSI type %d\n", vsi_type);
@@ -1431,7 +1429,6 @@ static int ice_vsi_alloc_rings(struct ice_vsi *vsi)
 		ring->reg_idx = vsi->rxq_map[i];
 		ring->vsi = vsi;
 		ring->netdev = vsi->netdev;
-		ring->dev = dev;
 		ring->count = vsi->num_rx_desc;
 		ring->cached_phctime = pf->ptp.cached_phc_time;
 
@@ -2425,14 +2422,21 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 		}
 		break;
 	case ICE_VSI_LB:
-		ret = ice_vsi_alloc_rings(vsi);
+		ret = ice_vsi_alloc_q_vectors(vsi);
 		if (ret)
 			goto unroll_vsi_init;
 
+		ret = ice_vsi_alloc_rings(vsi);
+		if (ret)
+			goto unroll_alloc_q_vector;
+
 		ret = ice_vsi_alloc_ring_stats(vsi);
 		if (ret)
 			goto unroll_vector_base;
 
+		/* Simply map the dummy q_vector to the only rx_ring */
+		vsi->rx_rings[0]->q_vector = vsi->q_vectors[0];
+
 		break;
 	default:
 		/* clean up the resources and exit */
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f85051072ba2..9cc323801b94 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -37,6 +37,8 @@ static const char ice_copyright[] = "Copyright (c) 2018, Intel Corporation.";
 #define ICE_DDP_PKG_FILE	ICE_DDP_PKG_PATH "ice.pkg"
 
 MODULE_DESCRIPTION(DRV_SUMMARY);
+MODULE_IMPORT_NS("LIBETH");
+MODULE_IMPORT_NS("LIBETH_XDP");
 MODULE_IMPORT_NS("LIBIE");
 MODULE_IMPORT_NS("LIBIE_ADMINQ");
 MODULE_IMPORT_NS("LIBIE_FWLOG");
@@ -2957,10 +2959,7 @@ int ice_vsi_determine_xdp_res(struct ice_vsi *vsi)
  */
 static int ice_max_xdp_frame_size(struct ice_vsi *vsi)
 {
-	if (test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags))
-		return ICE_RXBUF_1664;
-	else
-		return ICE_RXBUF_3072;
+	return ICE_RXBUF_3072;
 }
 
 /**
@@ -3018,19 +3017,11 @@ ice_xdp_setup_prog(struct ice_vsi *vsi, struct bpf_prog *prog,
 			}
 		}
 		xdp_features_set_redirect_target(vsi->netdev, true);
-		/* reallocate Rx queues that are used for zero-copy */
-		xdp_ring_err = ice_realloc_zc_buf(vsi, true);
-		if (xdp_ring_err)
-			NL_SET_ERR_MSG_MOD(extack, "Setting up XDP Rx resources failed");
 	} else if (ice_is_xdp_ena_vsi(vsi) && !prog) {
 		xdp_features_clear_redirect_target(vsi->netdev);
 		xdp_ring_err = ice_destroy_xdp_rings(vsi, ICE_XDP_CFG_FULL);
 		if (xdp_ring_err)
 			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Tx resources failed");
-		/* reallocate Rx queues that were used for zero-copy */
-		xdp_ring_err = ice_realloc_zc_buf(vsi, false);
-		if (xdp_ring_err)
-			NL_SET_ERR_MSG_MOD(extack, "Freeing XDP Rx resources failed");
 	}
 
 resume_if:
@@ -7879,12 +7870,6 @@ int ice_change_mtu(struct net_device *netdev, int new_mtu)
 				   frame_size - ICE_ETH_PKT_HDR_PAD);
 			return -EINVAL;
 		}
-	} else if (test_bit(ICE_FLAG_LEGACY_RX, pf->flags)) {
-		if (new_mtu + ICE_ETH_PKT_HDR_PAD > ICE_MAX_FRAME_LEGACY_RX) {
-			netdev_err(netdev, "Too big MTU for legacy-rx; Max is %d\n",
-				   ICE_MAX_FRAME_LEGACY_RX - ICE_ETH_PKT_HDR_PAD);
-			return -EINVAL;
-		}
 	}
 
 	/* if a reset is in progress, wait for some time for it to complete */
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
index 4831b9a5ac83..cc3c07847c35 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.c
@@ -7,6 +7,8 @@
 #include <linux/netdevice.h>
 #include <linux/prefetch.h>
 #include <linux/bpf_trace.h>
+#include <linux/net/intel/libie/rx.h>
+#include <net/libeth/xdp.h>
 #include <net/dsfield.h>
 #include <net/mpls.h>
 #include <net/xdp.h>
@@ -111,7 +113,7 @@ ice_prgm_fdir_fltr(struct ice_vsi *vsi, struct ice_fltr_desc *fdir_desc,
 static void
 ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 {
-	if (dma_unmap_len(tx_buf, len))
+	if (tx_buf->type != ICE_TX_BUF_XDP_TX && dma_unmap_len(tx_buf, len))
 		dma_unmap_page(ring->dev,
 			       dma_unmap_addr(tx_buf, dma),
 			       dma_unmap_len(tx_buf, len),
@@ -125,7 +127,7 @@ ice_unmap_and_free_tx_buf(struct ice_tx_ring *ring, struct ice_tx_buf *tx_buf)
 		dev_kfree_skb_any(tx_buf->skb);
 		break;
 	case ICE_TX_BUF_XDP_TX:
-		page_frag_free(tx_buf->raw_buf);
+		libeth_xdp_return_va(tx_buf->raw_buf, false);
 		break;
 	case ICE_TX_BUF_XDP_XMIT:
 		xdp_return_frame(tx_buf->xdpf);
@@ -513,54 +515,44 @@ int ice_setup_tx_ring(struct ice_tx_ring *tx_ring)
  */
 void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 {
-	struct xdp_buff *xdp = &rx_ring->xdp;
-	struct device *dev = rx_ring->dev;
+	struct libeth_fq fq = {
+		.fqes	= rx_ring->rx_fqes,
+		.pp	= rx_ring->pp,
+	};
 	u32 size;
-	u16 i;
-
-	/* ring already cleared, nothing to do */
-	if (!rx_ring->rx_buf)
-		return;
 
 	if (rx_ring->xsk_pool) {
 		ice_xsk_clean_rx_ring(rx_ring);
 		goto rx_skip_free;
 	}
 
-	if (xdp->data) {
-		xdp_return_buff(xdp);
-		xdp->data = NULL;
-	}
+	/* ring already cleared, nothing to do */
+	if (!rx_ring->rx_fqes)
+		return;
+
+	libeth_xdp_return_stash(&rx_ring->xdp);
 
 	/* Free all the Rx ring sk_buffs */
-	for (i = 0; i < rx_ring->count; i++) {
-		struct ice_rx_buf *rx_buf = &rx_ring->rx_buf[i];
+	for (u32 i = rx_ring->next_to_clean; i != rx_ring->next_to_use; ) {
+		const struct libeth_fqe *rx_fqes = &rx_ring->rx_fqes[i];
 
-		if (!rx_buf->page)
-			continue;
+		libeth_rx_recycle_slow(rx_fqes->netmem);
 
-		/* Invalidate cache lines that may have been written to by
-		 * device so that we avoid corrupting memory.
-		 */
-		dma_sync_single_range_for_cpu(dev, rx_buf->dma,
-					      rx_buf->page_offset,
-					      rx_ring->rx_buf_len,
-					      DMA_FROM_DEVICE);
-
-		/* free resources associated with mapping */
-		dma_unmap_page_attrs(dev, rx_buf->dma, ice_rx_pg_size(rx_ring),
-				     DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
-
-		rx_buf->page = NULL;
-		rx_buf->page_offset = 0;
+		if (unlikely(++i == rx_ring->count))
+			i = 0;
+	}
+
+	if (rx_ring->vsi->type == ICE_VSI_PF &&
+	    xdp_rxq_info_is_reg(&rx_ring->xdp_rxq)) {
+		xdp_rxq_info_detach_mem_model(&rx_ring->xdp_rxq);
+		xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	}
 
+	libeth_rx_fq_destroy(&fq);
+	rx_ring->rx_fqes = NULL;
+	rx_ring->pp = NULL;
+
 rx_skip_free:
-	if (rx_ring->xsk_pool)
-		memset(rx_ring->xdp_buf, 0, array_size(rx_ring->count, sizeof(*rx_ring->xdp_buf)));
-	else
-		memset(rx_ring->rx_buf, 0, array_size(rx_ring->count, sizeof(*rx_ring->rx_buf)));
 
 	/* Zero out the descriptor ring */
 	size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
@@ -569,7 +561,6 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
 
 	rx_ring->next_to_alloc = 0;
 	rx_ring->next_to_clean = 0;
-	rx_ring->first_desc = 0;
 	rx_ring->next_to_use = 0;
 }
 
@@ -581,26 +572,20 @@ void ice_clean_rx_ring(struct ice_rx_ring *rx_ring)
  */
 void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
 {
+	struct device *dev = ice_pf_to_dev(rx_ring->vsi->back);
 	u32 size;
 
 	ice_clean_rx_ring(rx_ring);
-	if (rx_ring->vsi->type == ICE_VSI_PF)
-		if (xdp_rxq_info_is_reg(&rx_ring->xdp_rxq))
-			xdp_rxq_info_unreg(&rx_ring->xdp_rxq);
 	WRITE_ONCE(rx_ring->xdp_prog, NULL);
 	if (rx_ring->xsk_pool) {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-	} else {
-		kfree(rx_ring->rx_buf);
-		rx_ring->rx_buf = NULL;
 	}
 
 	if (rx_ring->desc) {
 		size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
 			     PAGE_SIZE);
-		dmam_free_coherent(rx_ring->dev, size,
-				   rx_ring->desc, rx_ring->dma);
+		dmam_free_coherent(dev, size, rx_ring->desc, rx_ring->dma);
 		rx_ring->desc = NULL;
 	}
 }
@@ -613,19 +598,9 @@ void ice_free_rx_ring(struct ice_rx_ring *rx_ring)
  */
 int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 {
-	struct device *dev = rx_ring->dev;
+	struct device *dev = ice_pf_to_dev(rx_ring->vsi->back);
 	u32 size;
 
-	if (!dev)
-		return -ENOMEM;
-
-	/* warn if we are about to overwrite the pointer */
-	WARN_ON(rx_ring->rx_buf);
-	rx_ring->rx_buf =
-		kcalloc(rx_ring->count, sizeof(*rx_ring->rx_buf), GFP_KERNEL);
-	if (!rx_ring->rx_buf)
-		return -ENOMEM;
-
 	/* round up to nearest page */
 	size = ALIGN(rx_ring->count * sizeof(union ice_32byte_rx_desc),
 		     PAGE_SIZE);
@@ -634,22 +609,16 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
 	if (!rx_ring->desc) {
 		dev_err(dev, "Unable to allocate memory for the Rx descriptor ring, size=%d\n",
 			size);
-		goto err;
+		return -ENOMEM;
 	}
 
 	rx_ring->next_to_use = 0;
 	rx_ring->next_to_clean = 0;
-	rx_ring->first_desc = 0;
 
 	if (ice_is_xdp_ena_vsi(rx_ring->vsi))
 		WRITE_ONCE(rx_ring->xdp_prog, rx_ring->vsi->xdp_prog);
 
 	return 0;
-
-err:
-	kfree(rx_ring->rx_buf);
-	rx_ring->rx_buf = NULL;
-	return -ENOMEM;
 }
 
 /**
@@ -663,7 +632,7 @@ int ice_setup_rx_ring(struct ice_rx_ring *rx_ring)
  * Returns any of ICE_XDP_{PASS, CONSUMED, TX, REDIR}
  */
 static u32
-ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
+ice_run_xdp(struct ice_rx_ring *rx_ring, struct libeth_xdp_buff *xdp,
 	    struct bpf_prog *xdp_prog, struct ice_tx_ring *xdp_ring,
 	    union ice_32b_rx_flex_desc *eop_desc)
 {
@@ -673,23 +642,23 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 	if (!xdp_prog)
 		goto exit;
 
-	ice_xdp_meta_set_desc(xdp, eop_desc);
+	xdp->desc = eop_desc;
 
-	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	act = bpf_prog_run_xdp(xdp_prog, &xdp->base);
 	switch (act) {
 	case XDP_PASS:
 		break;
 	case XDP_TX:
 		if (static_branch_unlikely(&ice_xdp_locking_key))
 			spin_lock(&xdp_ring->tx_lock);
-		ret = __ice_xmit_xdp_ring(xdp, xdp_ring, false);
+		ret = __ice_xmit_xdp_ring(&xdp->base, xdp_ring, false);
 		if (static_branch_unlikely(&ice_xdp_locking_key))
 			spin_unlock(&xdp_ring->tx_lock);
 		if (ret == ICE_XDP_CONSUMED)
 			goto out_failure;
 		break;
 	case XDP_REDIRECT:
-		if (xdp_do_redirect(rx_ring->netdev, xdp, xdp_prog))
+		if (xdp_do_redirect(rx_ring->netdev, &xdp->base, xdp_prog))
 			goto out_failure;
 		ret = ICE_XDP_REDIR;
 		break;
@@ -701,8 +670,10 @@ ice_run_xdp(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
 		trace_xdp_exception(rx_ring->netdev, xdp_prog, act);
 		fallthrough;
 	case XDP_DROP:
+		libeth_xdp_return_buff(xdp);
 		ret = ICE_XDP_CONSUMED;
 	}
+
 exit:
 	return ret;
 }
@@ -790,53 +761,6 @@ ice_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	return nxmit;
 }
 
-/**
- * ice_alloc_mapped_page - recycle or make a new page
- * @rx_ring: ring to use
- * @bi: rx_buf struct to modify
- *
- * Returns true if the page was successfully allocated or
- * reused.
- */
-static bool
-ice_alloc_mapped_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *bi)
-{
-	struct page *page = bi->page;
-	dma_addr_t dma;
-
-	/* since we are recycling buffers we should seldom need to alloc */
-	if (likely(page))
-		return true;
-
-	/* alloc new page for storage */
-	page = dev_alloc_pages(ice_rx_pg_order(rx_ring));
-	if (unlikely(!page)) {
-		rx_ring->ring_stats->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	/* map page for use */
-	dma = dma_map_page_attrs(rx_ring->dev, page, 0, ice_rx_pg_size(rx_ring),
-				 DMA_FROM_DEVICE, ICE_RX_DMA_ATTR);
-
-	/* if mapping failed free memory back to system since
-	 * there isn't much point in holding memory we can't use
-	 */
-	if (dma_mapping_error(rx_ring->dev, dma)) {
-		__free_pages(page, ice_rx_pg_order(rx_ring));
-		rx_ring->ring_stats->rx_stats.alloc_page_failed++;
-		return false;
-	}
-
-	bi->dma = dma;
-	bi->page = page;
-	bi->page_offset = rx_ring->rx_offset;
-	page_ref_add(page, USHRT_MAX - 1);
-	bi->pagecnt_bias = USHRT_MAX;
-
-	return true;
-}
-
 /**
  * ice_init_ctrl_rx_descs - Initialize Rx descriptors for control vsi.
  * @rx_ring: ring to init descriptors on
@@ -883,9 +807,14 @@ void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 count)
  */
 bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 {
+	const struct libeth_fq_fp fq = {
+		.pp		= rx_ring->pp,
+		.fqes		= rx_ring->rx_fqes,
+		.truesize	= rx_ring->truesize,
+		.count		= rx_ring->count,
+	};
 	union ice_32b_rx_flex_desc *rx_desc;
 	u16 ntu = rx_ring->next_to_use;
-	struct ice_rx_buf *bi;
 
 	/* do nothing if no valid netdev defined */
 	if (!rx_ring->netdev || !cleaned_count)
@@ -893,30 +822,25 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 
 	/* get the Rx descriptor and buffer based on next_to_use */
 	rx_desc = ICE_RX_DESC(rx_ring, ntu);
-	bi = &rx_ring->rx_buf[ntu];
 
 	do {
-		/* if we fail here, we have work remaining */
-		if (!ice_alloc_mapped_page(rx_ring, bi))
-			break;
+		dma_addr_t addr;
 
-		/* sync the buffer for use by the device */
-		dma_sync_single_range_for_device(rx_ring->dev, bi->dma,
-						 bi->page_offset,
-						 rx_ring->rx_buf_len,
-						 DMA_FROM_DEVICE);
+		addr = libeth_rx_alloc(&fq, ntu);
+		if (addr == DMA_MAPPING_ERROR) {
+			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
+			break;
+		}
 
 		/* Refresh the desc even if buffer_addrs didn't change
 		 * because each write-back erases this info.
 		 */
-		rx_desc->read.pkt_addr = cpu_to_le64(bi->dma + bi->page_offset);
+		rx_desc->read.pkt_addr = cpu_to_le64(addr);
 
 		rx_desc++;
-		bi++;
 		ntu++;
 		if (unlikely(ntu == rx_ring->count)) {
 			rx_desc = ICE_RX_DESC(rx_ring, 0);
-			bi = rx_ring->rx_buf;
 			ntu = 0;
 		}
 
@@ -932,402 +856,6 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
 	return !!cleaned_count;
 }
 
-/**
- * ice_rx_buf_adjust_pg_offset - Prepare Rx buffer for reuse
- * @rx_buf: Rx buffer to adjust
- * @size: Size of adjustment
- *
- * Update the offset within page so that Rx buf will be ready to be reused.
- * For systems with PAGE_SIZE < 8192 this function will flip the page offset
- * so the second half of page assigned to Rx buffer will be used, otherwise
- * the offset is moved by "size" bytes
- */
-static void
-ice_rx_buf_adjust_pg_offset(struct ice_rx_buf *rx_buf, unsigned int size)
-{
-#if (PAGE_SIZE < 8192)
-	/* flip page offset to other buffer */
-	rx_buf->page_offset ^= size;
-#else
-	/* move offset up to the next cache line */
-	rx_buf->page_offset += size;
-#endif
-}
-
-/**
- * ice_can_reuse_rx_page - Determine if page can be reused for another Rx
- * @rx_buf: buffer containing the page
- *
- * If page is reusable, we have a green light for calling ice_reuse_rx_page,
- * which will assign the current buffer to the buffer that next_to_alloc is
- * pointing to; otherwise, the DMA mapping needs to be destroyed and
- * page freed
- */
-static bool
-ice_can_reuse_rx_page(struct ice_rx_buf *rx_buf)
-{
-	unsigned int pagecnt_bias = rx_buf->pagecnt_bias;
-	struct page *page = rx_buf->page;
-
-	/* avoid re-using remote and pfmemalloc pages */
-	if (!dev_page_is_reusable(page))
-		return false;
-
-	/* if we are only owner of page we can reuse it */
-	if (unlikely(rx_buf->pgcnt - pagecnt_bias > 1))
-		return false;
-#if (PAGE_SIZE >= 8192)
-#define ICE_LAST_OFFSET \
-	(SKB_WITH_OVERHEAD(PAGE_SIZE) - ICE_RXBUF_3072)
-	if (rx_buf->page_offset > ICE_LAST_OFFSET)
-		return false;
-#endif /* PAGE_SIZE >= 8192) */
-
-	/* If we have drained the page fragment pool we need to update
-	 * the pagecnt_bias and page count so that we fully restock the
-	 * number of references the driver holds.
-	 */
-	if (unlikely(pagecnt_bias == 1)) {
-		page_ref_add(page, USHRT_MAX - 1);
-		rx_buf->pagecnt_bias = USHRT_MAX;
-	}
-
-	return true;
-}
-
-/**
- * ice_add_xdp_frag - Add contents of Rx buffer to xdp buf as a frag
- * @rx_ring: Rx descriptor ring to transact packets on
- * @xdp: xdp buff to place the data into
- * @rx_buf: buffer containing page to add
- * @size: packet length from rx_desc
- *
- * This function will add the data contained in rx_buf->page to the xdp buf.
- * It will just attach the page as a frag.
- */
-static int
-ice_add_xdp_frag(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-		 struct ice_rx_buf *rx_buf, const unsigned int size)
-{
-	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
-
-	if (!size)
-		return 0;
-
-	if (!xdp_buff_has_frags(xdp)) {
-		sinfo->nr_frags = 0;
-		sinfo->xdp_frags_size = 0;
-		xdp_buff_set_frags_flag(xdp);
-	}
-
-	if (unlikely(sinfo->nr_frags == MAX_SKB_FRAGS))
-		return -ENOMEM;
-
-	__skb_fill_page_desc_noacc(sinfo, sinfo->nr_frags++, rx_buf->page,
-				   rx_buf->page_offset, size);
-	sinfo->xdp_frags_size += size;
-
-	if (page_is_pfmemalloc(rx_buf->page))
-		xdp_buff_set_frag_pfmemalloc(xdp);
-
-	return 0;
-}
-
-/**
- * ice_reuse_rx_page - page flip buffer and store it back on the ring
- * @rx_ring: Rx descriptor ring to store buffers on
- * @old_buf: donor buffer to have page reused
- *
- * Synchronizes page for reuse by the adapter
- */
-static void
-ice_reuse_rx_page(struct ice_rx_ring *rx_ring, struct ice_rx_buf *old_buf)
-{
-	u16 nta = rx_ring->next_to_alloc;
-	struct ice_rx_buf *new_buf;
-
-	new_buf = &rx_ring->rx_buf[nta];
-
-	/* update, and store next to alloc */
-	nta++;
-	rx_ring->next_to_alloc = (nta < rx_ring->count) ? nta : 0;
-
-	/* Transfer page from old buffer to new buffer.
-	 * Move each member individually to avoid possible store
-	 * forwarding stalls and unnecessary copy of skb.
-	 */
-	new_buf->dma = old_buf->dma;
-	new_buf->page = old_buf->page;
-	new_buf->page_offset = old_buf->page_offset;
-	new_buf->pagecnt_bias = old_buf->pagecnt_bias;
-}
-
-/**
- * ice_get_rx_buf - Fetch Rx buffer and synchronize data for use
- * @rx_ring: Rx descriptor ring to transact packets on
- * @size: size of buffer to add to skb
- * @ntc: index of next to clean element
- *
- * This function will pull an Rx buffer from the ring and synchronize it
- * for use by the CPU.
- */
-static struct ice_rx_buf *
-ice_get_rx_buf(struct ice_rx_ring *rx_ring, const unsigned int size,
-	       const unsigned int ntc)
-{
-	struct ice_rx_buf *rx_buf;
-
-	rx_buf = &rx_ring->rx_buf[ntc];
-	prefetchw(rx_buf->page);
-
-	if (!size)
-		return rx_buf;
-	/* we are reusing so sync this buffer for CPU use */
-	dma_sync_single_range_for_cpu(rx_ring->dev, rx_buf->dma,
-				      rx_buf->page_offset, size,
-				      DMA_FROM_DEVICE);
-
-	/* We have pulled a buffer for use, so decrement pagecnt_bias */
-	rx_buf->pagecnt_bias--;
-
-	return rx_buf;
-}
-
-/**
- * ice_get_pgcnts - grab page_count() for gathered fragments
- * @rx_ring: Rx descriptor ring to store the page counts on
- * @ntc: the next to clean element (not included in this frame!)
- *
- * This function is intended to be called right before running XDP
- * program so that the page recycling mechanism will be able to take
- * a correct decision regarding underlying pages; this is done in such
- * way as XDP program can change the refcount of page
- */
-static void ice_get_pgcnts(struct ice_rx_ring *rx_ring, unsigned int ntc)
-{
-	u32 idx = rx_ring->first_desc;
-	struct ice_rx_buf *rx_buf;
-	u32 cnt = rx_ring->count;
-
-	while (idx != ntc) {
-		rx_buf = &rx_ring->rx_buf[idx];
-		rx_buf->pgcnt = page_count(rx_buf->page);
-
-		if (++idx == cnt)
-			idx = 0;
-	}
-}
-
-/**
- * ice_build_skb - Build skb around an existing buffer
- * @rx_ring: Rx descriptor ring to transact packets on
- * @xdp: xdp_buff pointing to the data
- *
- * This function builds an skb around an existing XDP buffer, taking care
- * to set up the skb correctly and avoid any memcpy overhead. Driver has
- * already combined frags (if any) to skb_shared_info.
- */
-static struct sk_buff *
-ice_build_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
-{
-	u8 metasize = xdp->data - xdp->data_meta;
-	struct skb_shared_info *sinfo = NULL;
-	unsigned int nr_frags;
-	struct sk_buff *skb;
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-
-	/* Prefetch first cache line of first page. If xdp->data_meta
-	 * is unused, this points exactly as xdp->data, otherwise we
-	 * likely have a consumer accessing first few bytes of meta
-	 * data, and then actual data.
-	 */
-	net_prefetch(xdp->data_meta);
-	/* build an skb around the page buffer */
-	skb = napi_build_skb(xdp->data_hard_start, xdp->frame_sz);
-	if (unlikely(!skb))
-		return NULL;
-
-	/* must to record Rx queue, otherwise OS features such as
-	 * symmetric queue won't work
-	 */
-	skb_record_rx_queue(skb, rx_ring->q_index);
-
-	/* update pointers within the skb to store the data */
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	__skb_put(skb, xdp->data_end - xdp->data);
-	if (metasize)
-		skb_metadata_set(skb, metasize);
-
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		xdp_update_skb_frags_info(skb, nr_frags, sinfo->xdp_frags_size,
-					  nr_frags * xdp->frame_sz,
-					  xdp_buff_get_skb_flags(xdp));
-
-	return skb;
-}
-
-/**
- * ice_construct_skb - Allocate skb and populate it
- * @rx_ring: Rx descriptor ring to transact packets on
- * @xdp: xdp_buff pointing to the data
- *
- * This function allocates an skb. It then populates it with the page
- * data from the current receive descriptor, taking care to set up the
- * skb correctly.
- */
-static struct sk_buff *
-ice_construct_skb(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
-{
-	unsigned int size = xdp->data_end - xdp->data;
-	struct skb_shared_info *sinfo = NULL;
-	struct ice_rx_buf *rx_buf;
-	unsigned int nr_frags = 0;
-	unsigned int headlen;
-	struct sk_buff *skb;
-
-	/* prefetch first cache line of first page */
-	net_prefetch(xdp->data);
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-
-	/* allocate a skb to store the frags */
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, ICE_RX_HDR_SIZE);
-	if (unlikely(!skb))
-		return NULL;
-
-	rx_buf = &rx_ring->rx_buf[rx_ring->first_desc];
-	skb_record_rx_queue(skb, rx_ring->q_index);
-	/* Determine available headroom for copy */
-	headlen = size;
-	if (headlen > ICE_RX_HDR_SIZE)
-		headlen = eth_get_headlen(skb->dev, xdp->data, ICE_RX_HDR_SIZE);
-
-	/* align pull length to size of long to optimize memcpy performance */
-	memcpy(__skb_put(skb, headlen), xdp->data, ALIGN(headlen,
-							 sizeof(long)));
-
-	/* if we exhaust the linear part then add what is left as a frag */
-	size -= headlen;
-	if (size) {
-		/* besides adding here a partial frag, we are going to add
-		 * frags from xdp_buff, make sure there is enough space for
-		 * them
-		 */
-		if (unlikely(nr_frags >= MAX_SKB_FRAGS - 1)) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		skb_add_rx_frag(skb, 0, rx_buf->page,
-				rx_buf->page_offset + headlen, size,
-				xdp->frame_sz);
-	} else {
-		/* buffer is unused, restore biased page count in Rx buffer;
-		 * data was copied onto skb's linear part so there's no
-		 * need for adjusting page offset and we can reuse this buffer
-		 * as-is
-		 */
-		rx_buf->pagecnt_bias++;
-	}
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-
-		memcpy(&skinfo->frags[skinfo->nr_frags], &sinfo->frags[0],
-		       sizeof(skb_frag_t) * nr_frags);
-
-		xdp_update_skb_frags_info(skb, skinfo->nr_frags + nr_frags,
-					  sinfo->xdp_frags_size,
-					  nr_frags * xdp->frame_sz,
-					  xdp_buff_get_skb_flags(xdp));
-	}
-
-	return skb;
-}
-
-/**
- * ice_put_rx_buf - Clean up used buffer and either recycle or free
- * @rx_ring: Rx descriptor ring to transact packets on
- * @rx_buf: Rx buffer to pull data from
- *
- * This function will clean up the contents of the rx_buf. It will either
- * recycle the buffer or unmap it and free the associated resources.
- */
-static void
-ice_put_rx_buf(struct ice_rx_ring *rx_ring, struct ice_rx_buf *rx_buf)
-{
-	if (!rx_buf)
-		return;
-
-	if (ice_can_reuse_rx_page(rx_buf)) {
-		/* hand second half of page back to the ring */
-		ice_reuse_rx_page(rx_ring, rx_buf);
-	} else {
-		/* we are not reusing the buffer so unmap it */
-		dma_unmap_page_attrs(rx_ring->dev, rx_buf->dma,
-				     ice_rx_pg_size(rx_ring), DMA_FROM_DEVICE,
-				     ICE_RX_DMA_ATTR);
-		__page_frag_cache_drain(rx_buf->page, rx_buf->pagecnt_bias);
-	}
-
-	/* clear contents of buffer_info */
-	rx_buf->page = NULL;
-}
-
-/**
- * ice_put_rx_mbuf - ice_put_rx_buf() caller, for all buffers in frame
- * @rx_ring: Rx ring with all the auxiliary data
- * @xdp: XDP buffer carrying linear + frags part
- * @ntc: the next to clean element (not included in this frame!)
- * @verdict: return code from XDP program execution
- *
- * Called after XDP program is completed, or on error with verdict set to
- * ICE_XDP_CONSUMED.
- *
- * Walk through buffers from first_desc to the end of the frame, releasing
- * buffers and satisfying internal page recycle mechanism. The action depends
- * on verdict from XDP program.
- */
-static void ice_put_rx_mbuf(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp,
-			    u32 ntc, u32 verdict)
-{
-	u32 idx = rx_ring->first_desc;
-	u32 cnt = rx_ring->count;
-	struct ice_rx_buf *buf;
-	u32 xdp_frags = 0;
-	int i = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp)))
-		xdp_frags = xdp_get_shared_info_from_buff(xdp)->nr_frags;
-
-	while (idx != ntc) {
-		buf = &rx_ring->rx_buf[idx];
-		if (++idx == cnt)
-			idx = 0;
-
-		/* An XDP program could release fragments from the end of the
-		 * buffer. For these, we need to keep the pagecnt_bias as-is.
-		 * To do this, only adjust pagecnt_bias for fragments up to
-		 * the total remaining after the XDP program has run.
-		 */
-		if (verdict != ICE_XDP_CONSUMED)
-			ice_rx_buf_adjust_pg_offset(buf, xdp->frame_sz);
-		else if (i++ <= xdp_frags)
-			buf->pagecnt_bias++;
-
-		ice_put_rx_buf(rx_ring, buf);
-	}
-
-	xdp->data = NULL;
-	rx_ring->first_desc = ntc;
-}
-
 /**
  * ice_clean_ctrl_rx_irq - Clean descriptors from flow director Rx ring
  * @rx_ring: Rx descriptor ring for ctrl_vsi to transact packets on
@@ -1362,9 +890,8 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
 		total_rx_pkts++;
 	}
 
-	rx_ring->first_desc = ntc;
 	rx_ring->next_to_clean = ntc;
-	ice_init_ctrl_rx_descs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
+	ice_init_ctrl_rx_descs(rx_ring, ICE_DESC_UNUSED(rx_ring));
 }
 
 /**
@@ -1382,16 +909,17 @@ void ice_clean_ctrl_rx_irq(struct ice_rx_ring *rx_ring)
 static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 {
 	unsigned int total_rx_bytes = 0, total_rx_pkts = 0;
-	unsigned int offset = rx_ring->rx_offset;
-	struct xdp_buff *xdp = &rx_ring->xdp;
 	struct ice_tx_ring *xdp_ring = NULL;
 	struct bpf_prog *xdp_prog = NULL;
 	u32 ntc = rx_ring->next_to_clean;
+	LIBETH_XDP_ONSTACK_BUFF(xdp);
 	u32 cached_ntu, xdp_verdict;
 	u32 cnt = rx_ring->count;
 	u32 xdp_xmit = 0;
 	bool failure;
 
+	libeth_xdp_init_buff(xdp, &rx_ring->xdp, &rx_ring->xdp_rxq);
+
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	if (xdp_prog) {
 		xdp_ring = rx_ring->xdp_ring;
@@ -1401,7 +929,7 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 	/* start the loop to process Rx packets bounded by 'budget' */
 	while (likely(total_rx_pkts < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
-		struct ice_rx_buf *rx_buf;
+		struct libeth_fqe *rx_buf;
 		struct sk_buff *skb;
 		unsigned int size;
 		u16 stat_err_bits;
@@ -1430,68 +958,47 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 		size = le16_to_cpu(rx_desc->wb.pkt_len) &
 			ICE_RX_FLX_DESC_PKT_LEN_M;
 
+		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
+		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
+					      stat_err_bits)))
+			size = 0;
+
 		/* retrieve a buffer from the ring */
-		rx_buf = ice_get_rx_buf(rx_ring, size, ntc);
+		rx_buf = &rx_ring->rx_fqes[ntc];
+		libeth_xdp_process_buff(xdp, rx_buf, size);
 
-		/* Increment ntc before calls to ice_put_rx_mbuf() */
 		if (++ntc == cnt)
 			ntc = 0;
 
-		if (!xdp->data) {
-			void *hard_start;
-
-			hard_start = page_address(rx_buf->page) + rx_buf->page_offset -
-				     offset;
-			xdp_prepare_buff(xdp, hard_start, offset, size, !!offset);
-			xdp_buff_clear_frags_flag(xdp);
-		} else if (ice_add_xdp_frag(rx_ring, xdp, rx_buf, size)) {
-			ice_put_rx_mbuf(rx_ring, xdp, ntc, ICE_XDP_CONSUMED);
-			break;
-		}
-
 		/* skip if it is NOP desc */
-		if (ice_is_non_eop(rx_ring, rx_desc))
+		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!xdp->data))
 			continue;
 
-		ice_get_pgcnts(rx_ring, ntc);
 		xdp_verdict = ice_run_xdp(rx_ring, xdp, xdp_prog, xdp_ring, rx_desc);
 		if (xdp_verdict == ICE_XDP_PASS)
 			goto construct_skb;
-		total_rx_bytes += xdp_get_buff_len(xdp);
-		total_rx_pkts++;
 
-		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
-		xdp_xmit |= xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR);
+		if (xdp_verdict & (ICE_XDP_TX | ICE_XDP_REDIR))
+			xdp_xmit |= xdp_verdict;
+		total_rx_bytes += xdp_get_buff_len(&xdp->base);
+		total_rx_pkts++;
 
+		xdp->data = NULL;
 		continue;
+
 construct_skb:
-		if (likely(ice_ring_uses_build_skb(rx_ring)))
-			skb = ice_build_skb(rx_ring, xdp);
-		else
-			skb = ice_construct_skb(rx_ring, xdp);
+		skb = xdp_build_skb_from_buff(&xdp->base);
+		xdp->data = NULL;
+
 		/* exit if we failed to retrieve a buffer */
 		if (!skb) {
+			libeth_xdp_return_buff_slow(xdp);
 			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
-			xdp_verdict = ICE_XDP_CONSUMED;
-		}
-		ice_put_rx_mbuf(rx_ring, xdp, ntc, xdp_verdict);
-
-		if (!skb)
-			break;
-
-		stat_err_bits = BIT(ICE_RX_FLEX_DESC_STATUS0_RXE_S);
-		if (unlikely(ice_test_staterr(rx_desc->wb.status_error0,
-					      stat_err_bits))) {
-			dev_kfree_skb_any(skb);
 			continue;
 		}
 
 		vlan_tci = ice_get_vlan_tci(rx_desc);
 
-		/* pad the skb if needed, to make a valid ethernet frame */
-		if (eth_skb_pad(skb))
-			continue;
-
 		/* probably a little skewed due to removing CRC */
 		total_rx_bytes += skb->len;
 
@@ -1508,11 +1015,13 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
 
 	rx_ring->next_to_clean = ntc;
 	/* return up to cleaned_count buffers to hardware */
-	failure = ice_alloc_rx_bufs(rx_ring, ICE_RX_DESC_UNUSED(rx_ring));
+	failure = ice_alloc_rx_bufs(rx_ring, ICE_DESC_UNUSED(rx_ring));
 
 	if (xdp_xmit)
 		ice_finalize_xdp_rx(xdp_ring, xdp_xmit, cached_ntu);
 
+	libeth_xdp_save_buff(&rx_ring->xdp, xdp);
+
 	if (rx_ring->ring_stats)
 		ice_update_rx_ring_stats(rx_ring, total_rx_pkts,
 					 total_rx_bytes);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.h b/drivers/net/ethernet/intel/ice/ice_txrx.h
index 51b23ec1953e..8db875c0fef8 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx.h
@@ -4,6 +4,8 @@
 #ifndef _ICE_TXRX_H_
 #define _ICE_TXRX_H_
 
+#include <net/libeth/types.h>
+
 #include "ice_type.h"
 
 #define ICE_DFLT_IRQ_WORK	256
@@ -27,72 +29,6 @@
 
 #define ICE_MAX_TXQ_PER_TXQG	128
 
-/* Attempt to maximize the headroom available for incoming frames. We use a 2K
- * buffer for MTUs <= 1500 and need 1536/1534 to store the data for the frame.
- * This leaves us with 512 bytes of room.  From that we need to deduct the
- * space needed for the shared info and the padding needed to IP align the
- * frame.
- *
- * Note: For cache line sizes 256 or larger this value is going to end
- *	 up negative.  In these cases we should fall back to the legacy
- *	 receive path.
- */
-#if (PAGE_SIZE < 8192)
-#define ICE_2K_TOO_SMALL_WITH_PADDING \
-	((unsigned int)(NET_SKB_PAD + ICE_RXBUF_1536) > \
-			SKB_WITH_OVERHEAD(ICE_RXBUF_2048))
-
-/**
- * ice_compute_pad - compute the padding
- * @rx_buf_len: buffer length
- *
- * Figure out the size of half page based on given buffer length and
- * then subtract the skb_shared_info followed by subtraction of the
- * actual buffer length; this in turn results in the actual space that
- * is left for padding usage
- */
-static inline int ice_compute_pad(int rx_buf_len)
-{
-	int half_page_size;
-
-	half_page_size = ALIGN(rx_buf_len, PAGE_SIZE / 2);
-	return SKB_WITH_OVERHEAD(half_page_size) - rx_buf_len;
-}
-
-/**
- * ice_skb_pad - determine the padding that we can supply
- *
- * Figure out the right Rx buffer size and based on that calculate the
- * padding
- */
-static inline int ice_skb_pad(void)
-{
-	int rx_buf_len;
-
-	/* If a 2K buffer cannot handle a standard Ethernet frame then
-	 * optimize padding for a 3K buffer instead of a 1.5K buffer.
-	 *
-	 * For a 3K buffer we need to add enough padding to allow for
-	 * tailroom due to NET_IP_ALIGN possibly shifting us out of
-	 * cache-line alignment.
-	 */
-	if (ICE_2K_TOO_SMALL_WITH_PADDING)
-		rx_buf_len = ICE_RXBUF_3072 + SKB_DATA_ALIGN(NET_IP_ALIGN);
-	else
-		rx_buf_len = ICE_RXBUF_1536;
-
-	/* if needed make room for NET_IP_ALIGN */
-	rx_buf_len -= NET_IP_ALIGN;
-
-	return ice_compute_pad(rx_buf_len);
-}
-
-#define ICE_SKB_PAD ice_skb_pad()
-#else
-#define ICE_2K_TOO_SMALL_WITH_PADDING false
-#define ICE_SKB_PAD (NET_SKB_PAD + NET_IP_ALIGN)
-#endif
-
 /* We are assuming that the cache line is always 64 Bytes here for ice.
  * In order to make sure that is a correct assumption there is a check in probe
  * to print a warning if the read from GLPCI_CNF2 tells us that the cache line
@@ -112,10 +48,6 @@ static inline int ice_skb_pad(void)
 	(u16)((((R)->next_to_clean > (R)->next_to_use) ? 0 : (R)->count) + \
 	      (R)->next_to_clean - (R)->next_to_use - 1)
 
-#define ICE_RX_DESC_UNUSED(R)	\
-	((((R)->first_desc > (R)->next_to_use) ? 0 : (R)->count) + \
-	      (R)->first_desc - (R)->next_to_use - 1)
-
 #define ICE_RING_QUARTER(R) ((R)->count >> 2)
 
 #define ICE_TX_FLAGS_TSO	BIT(0)
@@ -197,14 +129,6 @@ struct ice_tx_offload_params {
 	u8 header_len;
 };
 
-struct ice_rx_buf {
-	dma_addr_t dma;
-	struct page *page;
-	unsigned int page_offset;
-	unsigned int pgcnt;
-	unsigned int pagecnt_bias;
-};
-
 struct ice_q_stats {
 	u64 pkts;
 	u64 bytes;
@@ -270,15 +194,6 @@ struct ice_pkt_ctx {
 	__be16 vlan_proto;
 };
 
-struct ice_xdp_buff {
-	struct xdp_buff xdp_buff;
-	const union ice_32b_rx_flex_desc *eop_desc;
-	const struct ice_pkt_ctx *pkt_ctx;
-};
-
-/* Required for compatibility with xdp_buffs from xsk_pool */
-static_assert(offsetof(struct ice_xdp_buff, xdp_buff) == 0);
-
 /* indices into GLINT_ITR registers */
 #define ICE_RX_ITR	ICE_IDX_ITR0
 #define ICE_TX_ITR	ICE_IDX_ITR1
@@ -331,7 +246,7 @@ struct ice_tstamp_ring {
 struct ice_rx_ring {
 	/* CL1 - 1st cacheline starts here */
 	void *desc;			/* Descriptor ring memory */
-	struct device *dev;		/* Used for DMA mapping */
+	struct page_pool *pp;
 	struct net_device *netdev;	/* netdev ring maps to */
 	struct ice_vsi *vsi;		/* Backreference to associated VSI */
 	struct ice_q_vector *q_vector;	/* Backreference to associated vector */
@@ -343,14 +258,16 @@ struct ice_rx_ring {
 	u16 next_to_alloc;
 
 	union {
-		struct ice_rx_buf *rx_buf;
+		struct libeth_fqe *rx_fqes;
 		struct xdp_buff **xdp_buf;
 	};
+
 	/* CL2 - 2nd cacheline starts here */
 	union {
-		struct ice_xdp_buff xdp_ext;
-		struct xdp_buff xdp;
+		struct libeth_xdp_buff_stash xdp;
+		struct libeth_xdp_buff *xsk;
 	};
+
 	/* CL3 - 3rd cacheline starts here */
 	union {
 		struct ice_pkt_ctx pkt_ctx;
@@ -360,12 +277,11 @@ struct ice_rx_ring {
 		};
 	};
 	struct bpf_prog *xdp_prog;
-	u16 rx_offset;
 
 	/* used in interrupt processing */
 	u16 next_to_use;
 	u16 next_to_clean;
-	u16 first_desc;
+	u32 truesize;
 
 	/* stats structs */
 	struct ice_ring_stats *ring_stats;
@@ -376,12 +292,10 @@ struct ice_rx_ring {
 	struct ice_tx_ring *xdp_ring;
 	struct ice_rx_ring *next;	/* pointer to next ring in q_vector */
 	struct xsk_buff_pool *xsk_pool;
-	u16 max_frame;
 	u16 rx_buf_len;
 	dma_addr_t dma;			/* physical address of ring */
 	u8 dcb_tc;			/* Traffic class of ring */
 	u8 ptp_rx;
-#define ICE_RX_FLAGS_RING_BUILD_SKB	BIT(1)
 #define ICE_RX_FLAGS_CRC_STRIP_DIS	BIT(2)
 #define ICE_RX_FLAGS_MULTIDEV		BIT(3)
 #define ICE_RX_FLAGS_RING_GCS		BIT(4)
@@ -439,21 +353,6 @@ struct ice_tx_ring {
 	__cacheline_group_end_aligned(cold);
 } ____cacheline_internodealigned_in_smp;
 
-static inline bool ice_ring_uses_build_skb(struct ice_rx_ring *ring)
-{
-	return !!(ring->flags & ICE_RX_FLAGS_RING_BUILD_SKB);
-}
-
-static inline void ice_set_ring_build_skb_ena(struct ice_rx_ring *ring)
-{
-	ring->flags |= ICE_RX_FLAGS_RING_BUILD_SKB;
-}
-
-static inline void ice_clear_ring_build_skb_ena(struct ice_rx_ring *ring)
-{
-	ring->flags &= ~ICE_RX_FLAGS_RING_BUILD_SKB;
-}
-
 static inline bool ice_ring_ch_enabled(struct ice_tx_ring *ring)
 {
 	return !!ring->ch;
@@ -508,15 +407,9 @@ struct ice_coalesce_stored {
 
 static inline unsigned int ice_rx_pg_order(struct ice_rx_ring *ring)
 {
-#if (PAGE_SIZE < 8192)
-	if (ring->rx_buf_len > (PAGE_SIZE / 2))
-		return 1;
-#endif
 	return 0;
 }
 
-#define ice_rx_pg_size(_ring) (PAGE_SIZE << ice_rx_pg_order(_ring))
-
 union ice_32b_rx_flex_desc;
 
 void ice_init_ctrl_rx_descs(struct ice_rx_ring *rx_ring, u32 num_descs);
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
index 45cfaabc41cb..956da38d63b0 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.c
@@ -3,6 +3,7 @@
 
 #include <linux/filter.h>
 #include <linux/net/intel/libie/rx.h>
+#include <net/libeth/xdp.h>
 
 #include "ice_txrx_lib.h"
 #include "ice_eswitch.h"
@@ -230,9 +231,12 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 
 		if (ice_is_port_repr_netdev(netdev))
 			ice_repr_inc_rx_stats(netdev, skb->len);
+
+		/* __skb_push() is needed because xdp_build_skb_from_buff()
+		 * calls eth_type_trans()
+		 */
+		__skb_push(skb, ETH_HLEN);
 		skb->protocol = eth_type_trans(skb, netdev);
-	} else {
-		skb->protocol = eth_type_trans(skb, rx_ring->netdev);
 	}
 
 	ice_rx_csum(rx_ring, skb, rx_desc, ptype);
@@ -270,19 +274,18 @@ static void
 ice_clean_xdp_tx_buf(struct device *dev, struct ice_tx_buf *tx_buf,
 		     struct xdp_frame_bulk *bq)
 {
-	dma_unmap_single(dev, dma_unmap_addr(tx_buf, dma),
-			 dma_unmap_len(tx_buf, len), DMA_TO_DEVICE);
-	dma_unmap_len_set(tx_buf, len, 0);
-
 	switch (tx_buf->type) {
 	case ICE_TX_BUF_XDP_TX:
-		page_frag_free(tx_buf->raw_buf);
+		libeth_xdp_return_va(tx_buf->raw_buf, true);
 		break;
 	case ICE_TX_BUF_XDP_XMIT:
+		dma_unmap_single(dev, dma_unmap_addr(tx_buf, dma),
+				 dma_unmap_len(tx_buf, len), DMA_TO_DEVICE);
 		xdp_return_frame_bulk(tx_buf->xdpf, bq);
 		break;
 	}
 
+	dma_unmap_len_set(tx_buf, len, 0);
 	tx_buf->type = ICE_TX_BUF_EMPTY;
 }
 
@@ -377,9 +380,11 @@ int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 	struct ice_tx_buf *tx_buf;
 	u32 cnt = xdp_ring->count;
 	void *data = xdp->data;
+	struct page *page;
 	u32 nr_frags = 0;
 	u32 free_space;
 	u32 frag = 0;
+	u32 offset;
 
 	free_space = ICE_DESC_UNUSED(xdp_ring);
 	if (free_space < ICE_RING_QUARTER(xdp_ring))
@@ -399,24 +404,28 @@ int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 	tx_head = &xdp_ring->tx_buf[ntu];
 	tx_buf = tx_head;
 
+	page = virt_to_page(data);
+	offset = offset_in_page(xdp->data);
+
 	for (;;) {
 		dma_addr_t dma;
 
-		dma = dma_map_single(dev, data, size, DMA_TO_DEVICE);
-		if (dma_mapping_error(dev, dma))
-			goto dma_unmap;
-
-		/* record length, and DMA address */
-		dma_unmap_len_set(tx_buf, len, size);
-		dma_unmap_addr_set(tx_buf, dma, dma);
-
 		if (frame) {
+			dma = dma_map_single(dev, data, size, DMA_TO_DEVICE);
+			if (dma_mapping_error(dev, dma))
+				goto dma_unmap;
 			tx_buf->type = ICE_TX_BUF_FRAG;
 		} else {
+			dma = page_pool_get_dma_addr(page) + offset;
+			dma_sync_single_for_device(dev, dma, size, DMA_BIDIRECTIONAL);
 			tx_buf->type = ICE_TX_BUF_XDP_TX;
 			tx_buf->raw_buf = data;
 		}
 
+		/* record length, and DMA address */
+		dma_unmap_len_set(tx_buf, len, size);
+		dma_unmap_addr_set(tx_buf, dma, dma);
+
 		tx_desc->buf_addr = cpu_to_le64(dma);
 		tx_desc->cmd_type_offset_bsz = ice_build_ctob(0, 0, size, 0);
 
@@ -430,6 +439,8 @@ int __ice_xmit_xdp_ring(struct xdp_buff *xdp, struct ice_tx_ring *xdp_ring,
 		tx_desc = ICE_TX_DESC(xdp_ring, ntu);
 		tx_buf = &xdp_ring->tx_buf[ntu];
 
+		page = skb_frag_page(&sinfo->frags[frag]);
+		offset = skb_frag_off(&sinfo->frags[frag]);
 		data = skb_frag_address(&sinfo->frags[frag]);
 		size = skb_frag_size(&sinfo->frags[frag]);
 		frag++;
@@ -514,10 +525,13 @@ void ice_finalize_xdp_rx(struct ice_tx_ring *xdp_ring, unsigned int xdp_res,
  */
 static int ice_xdp_rx_hw_ts(const struct xdp_md *ctx, u64 *ts_ns)
 {
-	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	struct ice_rx_ring *rx_ring;
 
-	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->eop_desc,
-				     xdp_ext->pkt_ctx);
+	rx_ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*rx_ring), xdp_rxq);
+
+	*ts_ns = ice_ptp_get_rx_hwts(xdp_ext->desc,
+				     &rx_ring->pkt_ctx);
 	if (!*ts_ns)
 		return -ENODATA;
 
@@ -545,10 +559,10 @@ ice_xdp_rx_hash_type(const union ice_32b_rx_flex_desc *eop_desc)
 static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 			   enum xdp_rss_hash_type *rss_type)
 {
-	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
 
-	*hash = ice_get_rx_hash(xdp_ext->eop_desc);
-	*rss_type = ice_xdp_rx_hash_type(xdp_ext->eop_desc);
+	*hash = ice_get_rx_hash(xdp_ext->desc);
+	*rss_type = ice_xdp_rx_hash_type(xdp_ext->desc);
 	if (!likely(*hash))
 		return -ENODATA;
 
@@ -567,13 +581,16 @@ static int ice_xdp_rx_hash(const struct xdp_md *ctx, u32 *hash,
 static int ice_xdp_rx_vlan_tag(const struct xdp_md *ctx, __be16 *vlan_proto,
 			       u16 *vlan_tci)
 {
-	const struct ice_xdp_buff *xdp_ext = (void *)ctx;
+	const struct libeth_xdp_buff *xdp_ext = (void *)ctx;
+	struct ice_rx_ring *rx_ring;
+
+	rx_ring = libeth_xdp_buff_to_rq(xdp_ext, typeof(*rx_ring), xdp_rxq);
 
-	*vlan_proto = xdp_ext->pkt_ctx->vlan_proto;
+	*vlan_proto = rx_ring->pkt_ctx.vlan_proto;
 	if (!*vlan_proto)
 		return -ENODATA;
 
-	*vlan_tci = ice_get_vlan_tci(xdp_ext->eop_desc);
+	*vlan_tci = ice_get_vlan_tci(xdp_ext->desc);
 	if (!*vlan_tci)
 		return -ENODATA;
 
diff --git a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
index 99717730f21a..6a3f10f7a53f 100644
--- a/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_txrx_lib.h
@@ -135,13 +135,4 @@ ice_process_skb_fields(struct ice_rx_ring *rx_ring,
 void
 ice_receive_skb(struct ice_rx_ring *rx_ring, struct sk_buff *skb, u16 vlan_tci);
 
-static inline void
-ice_xdp_meta_set_desc(struct xdp_buff *xdp,
-		      union ice_32b_rx_flex_desc *eop_desc)
-{
-	struct ice_xdp_buff *xdp_ext = container_of(xdp, struct ice_xdp_buff,
-						    xdp_buff);
-
-	xdp_ext->eop_desc = eop_desc;
-}
 #endif /* !_ICE_TXRX_LIB_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 575fd48f485f..989ff1fd9110 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -3,6 +3,7 @@
 
 #include <linux/bpf_trace.h>
 #include <linux/unroll.h>
+#include <net/libeth/xdp.h>
 #include <net/xdp_sock_drv.h>
 #include <net/xdp.h>
 #include "ice.h"
@@ -169,50 +170,18 @@ ice_xsk_pool_enable(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
  * If allocation was successful, substitute buffer with allocated one.
  * Returns 0 on success, negative on failure
  */
-static int
+int
 ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present)
 {
-	size_t elem_size = pool_present ? sizeof(*rx_ring->xdp_buf) :
-					  sizeof(*rx_ring->rx_buf);
-	void *sw_ring = kcalloc(rx_ring->count, elem_size, GFP_KERNEL);
-
-	if (!sw_ring)
-		return -ENOMEM;
-
 	if (pool_present) {
-		kfree(rx_ring->rx_buf);
-		rx_ring->rx_buf = NULL;
-		rx_ring->xdp_buf = sw_ring;
+		rx_ring->xdp_buf = kcalloc(rx_ring->count,
+					   sizeof(*rx_ring->xdp_buf),
+					   GFP_KERNEL);
+		if (!rx_ring->xdp_buf)
+			return -ENOMEM;
 	} else {
 		kfree(rx_ring->xdp_buf);
 		rx_ring->xdp_buf = NULL;
-		rx_ring->rx_buf = sw_ring;
-	}
-
-	return 0;
-}
-
-/**
- * ice_realloc_zc_buf - reallocate XDP ZC queue pairs
- * @vsi: Current VSI
- * @zc: is zero copy set
- *
- * Reallocate buffer for rx_rings that might be used by XSK.
- * XDP requires more memory, than rx_buf provides.
- * Returns 0 on success, negative on failure
- */
-int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc)
-{
-	struct ice_rx_ring *rx_ring;
-	uint i;
-
-	ice_for_each_rxq(vsi, i) {
-		rx_ring = vsi->rx_rings[i];
-		if (!rx_ring->xsk_pool)
-			continue;
-
-		if (ice_realloc_rx_xdp_bufs(rx_ring, zc))
-			return -ENOMEM;
 	}
 
 	return 0;
@@ -228,6 +197,7 @@ int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc)
  */
 int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 {
+	struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
 	bool if_running, pool_present = !!pool;
 	int ret = 0, pool_failure = 0;
 
@@ -241,8 +211,6 @@ int ice_xsk_pool_setup(struct ice_vsi *vsi, struct xsk_buff_pool *pool, u16 qid)
 		     ice_is_xdp_ena_vsi(vsi);
 
 	if (if_running) {
-		struct ice_rx_ring *rx_ring = vsi->rx_rings[qid];
-
 		ret = ice_qp_dis(vsi, qid);
 		if (ret) {
 			netdev_err(vsi->netdev, "ice_qp_dis error = %d\n", ret);
@@ -303,11 +271,6 @@ static u16 ice_fill_rx_descs(struct xsk_buff_pool *pool, struct xdp_buff **xdp,
 		rx_desc->read.pkt_addr = cpu_to_le64(dma);
 		rx_desc->wb.status_error0 = 0;
 
-		/* Put private info that changes on a per-packet basis
-		 * into xdp_buff_xsk->cb.
-		 */
-		ice_xdp_meta_set_desc(*xdp, rx_desc);
-
 		rx_desc++;
 		xdp++;
 	}
@@ -392,69 +355,6 @@ bool ice_alloc_rx_bufs_zc(struct ice_rx_ring *rx_ring,
 	return __ice_alloc_rx_bufs_zc(rx_ring, xsk_pool, leftover);
 }
 
-/**
- * ice_construct_skb_zc - Create an sk_buff from zero-copy buffer
- * @rx_ring: Rx ring
- * @xdp: Pointer to XDP buffer
- *
- * This function allocates a new skb from a zero-copy Rx buffer.
- *
- * Returns the skb on success, NULL on failure.
- */
-static struct sk_buff *
-ice_construct_skb_zc(struct ice_rx_ring *rx_ring, struct xdp_buff *xdp)
-{
-	unsigned int totalsize = xdp->data_end - xdp->data_meta;
-	unsigned int metasize = xdp->data - xdp->data_meta;
-	struct skb_shared_info *sinfo = NULL;
-	struct sk_buff *skb;
-	u32 nr_frags = 0;
-
-	if (unlikely(xdp_buff_has_frags(xdp))) {
-		sinfo = xdp_get_shared_info_from_buff(xdp);
-		nr_frags = sinfo->nr_frags;
-	}
-	net_prefetch(xdp->data_meta);
-
-	skb = napi_alloc_skb(&rx_ring->q_vector->napi, totalsize);
-	if (unlikely(!skb))
-		return NULL;
-
-	memcpy(__skb_put(skb, totalsize), xdp->data_meta,
-	       ALIGN(totalsize, sizeof(long)));
-
-	if (metasize) {
-		skb_metadata_set(skb, metasize);
-		__skb_pull(skb, metasize);
-	}
-
-	if (likely(!xdp_buff_has_frags(xdp)))
-		goto out;
-
-	for (int i = 0; i < nr_frags; i++) {
-		struct skb_shared_info *skinfo = skb_shinfo(skb);
-		skb_frag_t *frag = &sinfo->frags[i];
-		struct page *page;
-		void *addr;
-
-		page = dev_alloc_page();
-		if (!page) {
-			dev_kfree_skb(skb);
-			return NULL;
-		}
-		addr = page_to_virt(page);
-
-		memcpy(addr, skb_frag_page(frag), skb_frag_size(frag));
-
-		__skb_fill_page_desc_noacc(skinfo, skinfo->nr_frags++,
-					   addr, 0, skb_frag_size(frag));
-	}
-
-out:
-	xsk_buff_free(xdp);
-	return skb;
-}
-
 /**
  * ice_clean_xdp_irq_zc - produce AF_XDP descriptors to CQ
  * @xdp_ring: XDP Tx ring
@@ -669,10 +569,10 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 			struct xsk_buff_pool *xsk_pool,
 			int budget)
 {
+	struct xdp_buff *first = (struct xdp_buff *)rx_ring->xsk;
 	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
 	u32 ntc = rx_ring->next_to_clean;
 	u32 ntu = rx_ring->next_to_use;
-	struct xdp_buff *first = NULL;
 	struct ice_tx_ring *xdp_ring;
 	unsigned int xdp_xmit = 0;
 	struct bpf_prog *xdp_prog;
@@ -686,9 +586,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 	xdp_prog = READ_ONCE(rx_ring->xdp_prog);
 	xdp_ring = rx_ring->xdp_ring;
 
-	if (ntc != rx_ring->first_desc)
-		first = *ice_xdp_buf(rx_ring, rx_ring->first_desc);
-
 	while (likely(total_rx_packets < (unsigned int)budget)) {
 		union ice_32b_rx_flex_desc *rx_desc;
 		unsigned int size, xdp_res = 0;
@@ -724,15 +621,17 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 			first = xdp;
 		} else if (likely(size) && !xsk_buff_add_frag(first, xdp)) {
 			xsk_buff_free(first);
-			break;
+			first = NULL;
 		}
 
 		if (++ntc == cnt)
 			ntc = 0;
 
-		if (ice_is_non_eop(rx_ring, rx_desc))
+		if (ice_is_non_eop(rx_ring, rx_desc) || unlikely(!first))
 			continue;
 
+		((struct libeth_xdp_buff *)first)->desc = rx_desc;
+
 		xdp_res = ice_run_xdp_zc(rx_ring, first, xdp_prog, xdp_ring,
 					 xsk_pool);
 		if (likely(xdp_res & (ICE_XDP_TX | ICE_XDP_REDIR))) {
@@ -740,7 +639,6 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		} else if (xdp_res == ICE_XDP_EXIT) {
 			failure = true;
 			first = NULL;
-			rx_ring->first_desc = ntc;
 			break;
 		} else if (xdp_res == ICE_XDP_CONSUMED) {
 			xsk_buff_free(first);
@@ -752,24 +650,20 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 		total_rx_packets++;
 
 		first = NULL;
-		rx_ring->first_desc = ntc;
 		continue;
 
 construct_skb:
 		/* XDP_PASS path */
-		skb = ice_construct_skb_zc(rx_ring, first);
+		skb = xdp_build_skb_from_zc(first);
 		if (!skb) {
+			xsk_buff_free(first);
+			first = NULL;
+
 			rx_ring->ring_stats->rx_stats.alloc_buf_failed++;
-			break;
+			continue;
 		}
 
 		first = NULL;
-		rx_ring->first_desc = ntc;
-
-		if (eth_skb_pad(skb)) {
-			skb = NULL;
-			continue;
-		}
 
 		total_rx_bytes += skb->len;
 		total_rx_packets++;
@@ -781,7 +675,9 @@ int ice_clean_rx_irq_zc(struct ice_rx_ring *rx_ring,
 	}
 
 	rx_ring->next_to_clean = ntc;
-	entries_to_alloc = ICE_RX_DESC_UNUSED(rx_ring);
+	rx_ring->xsk = (struct libeth_xdp_buff *)first;
+
+	entries_to_alloc = ICE_DESC_UNUSED(rx_ring);
 	if (entries_to_alloc > ICE_RING_QUARTER(rx_ring))
 		failure |= !ice_alloc_rx_bufs_zc(rx_ring, xsk_pool,
 						 entries_to_alloc);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.h b/drivers/net/ethernet/intel/ice/ice_xsk.h
index 600cbeeaa203..5275fcedc9e1 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.h
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.h
@@ -22,7 +22,7 @@ bool ice_xsk_any_rx_ring_ena(struct ice_vsi *vsi);
 void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring);
 void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring);
 bool ice_xmit_zc(struct ice_tx_ring *xdp_ring, struct xsk_buff_pool *xsk_pool);
-int ice_realloc_zc_buf(struct ice_vsi *vsi, bool zc);
+int ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring, bool pool_present);
 void ice_qvec_cfg_msix(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
 		       u16 qid);
 void ice_qvec_toggle_napi(struct ice_vsi *vsi, struct ice_q_vector *q_vector,
@@ -77,8 +77,8 @@ static inline void ice_xsk_clean_rx_ring(struct ice_rx_ring *rx_ring) { }
 static inline void ice_xsk_clean_xdp_ring(struct ice_tx_ring *xdp_ring) { }
 
 static inline int
-ice_realloc_zc_buf(struct ice_vsi __always_unused *vsi,
-		   bool __always_unused zc)
+ice_realloc_rx_xdp_bufs(struct ice_rx_ring *rx_ring,
+			bool __always_unused pool_present)
 {
 	return 0;
 }
diff --git a/drivers/net/ethernet/intel/ice/virt/queues.c b/drivers/net/ethernet/intel/ice/virt/queues.c
index 0765ee901b7c..431c9c546b04 100644
--- a/drivers/net/ethernet/intel/ice/virt/queues.c
+++ b/drivers/net/ethernet/intel/ice/virt/queues.c
@@ -863,18 +863,20 @@ int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
 			    (qpi->rxq.databuffer_size > ((16 * 1024) - 128) ||
 			     qpi->rxq.databuffer_size < 128))
 				goto error_param;
+
 			ring->rx_buf_len = qpi->rxq.databuffer_size;
+
 			if (qpi->rxq.max_pkt_size > max_frame_size ||
 			    qpi->rxq.max_pkt_size < 64)
 				goto error_param;
 
-			ring->max_frame = qpi->rxq.max_pkt_size;
+			vsi->max_frame = qpi->rxq.max_pkt_size;
 			/* add space for the port VLAN since the VF driver is
 			 * not expected to account for it in the MTU
 			 * calculation
 			 */
 			if (ice_vf_is_port_vlan_ena(vf))
-				ring->max_frame += VLAN_HLEN;
+				vsi->max_frame += VLAN_HLEN;
 
 			if (ice_vsi_cfg_single_rxq(vsi, q_idx)) {
 				dev_warn(ice_pf_to_dev(pf), "VF-%d failed to configure RX queue %d\n",
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index c45a7ca66ad8..5745ba84c3a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -931,6 +931,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 			goto free_actions;
 		}
 		(*ractions)[num_actions].aso_meter.offset =
+			(fte_action->exe_aso.object_id - fte_action->exe_aso.base_id) * 2 +
 			fte_action->exe_aso.flow_meter.meter_idx;
 		(*ractions)[num_actions].aso_meter.init_color =
 			fte_action->exe_aso.flow_meter.init_color;
@@ -1401,8 +1402,8 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
-		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
-						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+		pr_pool = mlx5_fs_get_pr_encap_pool(dev, &hws_pool->el2tol3tnl_pools,
+						    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3,
 						    pr_data->data_size);
 		break;
 	case MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2:
diff --git a/drivers/net/wireless/intersil/p54/fwio.c b/drivers/net/wireless/intersil/p54/fwio.c
index 3baf8ab01e22..4b8e6cf711d8 100644
--- a/drivers/net/wireless/intersil/p54/fwio.c
+++ b/drivers/net/wireless/intersil/p54/fwio.c
@@ -52,6 +52,13 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 		u32 code = le32_to_cpu(bootrec->code);
 		switch (code) {
 		case BR_CODE_COMPONENT_ID:
+			if (len < sizeof(struct bootrec_comp_id) /
+				sizeof(*bootrec->data)) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component ID is too short\n");
+				return -EINVAL;
+			}
+
 			priv->fw_interface = be32_to_cpup((__be32 *)
 					     bootrec->data);
 			switch (priv->fw_interface) {
@@ -72,16 +79,41 @@ int p54_parse_firmware(struct ieee80211_hw *dev, const struct firmware *fw)
 			}
 			break;
 		case BR_CODE_COMPONENT_VERSION:
+			if (len < DIV_ROUND_UP(sizeof(struct bootrec_comp_ver),
+					       sizeof(*bootrec->data))) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware component version is too short\n");
+				return -EINVAL;
+			}
+
 			/* 24 bytes should be enough for all firmwares */
-			if (strnlen((unsigned char *) bootrec->data, 24) < 24)
-				fw_version = (unsigned char *) bootrec->data;
+			if (strnlen((unsigned char *)bootrec->data,
+				    sizeof(struct bootrec_comp_ver)) <
+				    sizeof(struct bootrec_comp_ver))
+				fw_version = (unsigned char *)bootrec->data;
 			break;
 		case BR_CODE_DESCR: {
 			struct bootrec_desc *desc =
 				(struct bootrec_desc *)bootrec->data;
-			priv->rx_start = le32_to_cpu(desc->rx_start);
-			/* FIXME add sanity checking */
-			priv->rx_end = le32_to_cpu(desc->rx_end) - 0x3500;
+			u32 rx_start, rx_end;
+
+			/* 0xa is the shortest descriptor in supported firmware. */
+			if (len < 0xa) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor is too short\n");
+				return -EINVAL;
+			}
+
+			rx_start = le32_to_cpu(desc->rx_start);
+			rx_end = le32_to_cpu(desc->rx_end);
+			if (rx_end < 0x3500 || rx_end - 0x3500 <= rx_start) {
+				wiphy_err(priv->hw->wiphy,
+					  "firmware descriptor has invalid RX range\n");
+				return -EINVAL;
+			}
+
+			priv->rx_start = rx_start;
+			priv->rx_end = rx_end - 0x3500;
 			priv->headroom = desc->headroom;
 			priv->tailroom = desc->tailroom;
 			priv->privacy_caps = desc->privacy_caps;
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 264213aa7630..78d4411e3255 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1227,9 +1227,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 	 * initialize.
 	 *
 	 * If the device is below a Root Port with Configuration RRS
-	 * Software Visibility enabled, reading the Vendor ID returns a
+	 * Software Visibility enabled, reading the Vendor ID may return a
 	 * special data value if the device responded with RRS.  Read the
-	 * Vendor ID until we get non-RRS status.
+	 * Vendor ID until we get non-RRS status and something other than
+	 * ~0.  The Vendor ID of VFs reads ~0, so check their Command
+	 * register instead.
 	 *
 	 * If there's no Root Port or Configuration RRS Software Visibility
 	 * is not enabled, the device may still respond with RRS, but
@@ -1249,8 +1251,13 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
 		if (root && root->config_rrs_sv) {
 			pci_read_config_dword(dev, PCI_VENDOR_ID, &id);
-			if (!pci_bus_rrs_vendor_id(id))
-				break;
+			if (!pci_bus_rrs_vendor_id(id)) {
+				if (PCI_POSSIBLE_ERROR(id) && dev->is_virtfn)
+					pci_read_config_dword(dev, PCI_COMMAND,
+							      &id);
+				if (!PCI_POSSIBLE_ERROR(id))
+					break;
+			}
 		} else {
 			pci_read_config_dword(dev, PCI_COMMAND, &id);
 			if (!PCI_POSSIBLE_ERROR(id))
diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
index d962f2e1d2ac..33c43f2ea991 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -888,6 +888,15 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
 	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
 
+#ifdef CONFIG_ACPI
+	/*
+	 * Platforms without _AEI leave GPIO wake sources to firmware, so
+	 * preserve their S4 wake bits.
+	 */
+	if (acpi_has_method(ACPI_HANDLE(&gpio_dev->pdev->dev), "_AEI"))
+		mask |= BIT(WAKE_CNTRL_OFF_S4);
+#endif
+
 	for (i = 0; i < desc->npins; i++) {
 		int pin = desc->pins[i].number;
 		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);
diff --git a/drivers/pinctrl/qcom/pinctrl-ipq5018.c b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
index cbf34854f882..c6e52615b36e 100644
--- a/drivers/pinctrl/qcom/pinctrl-ipq5018.c
+++ b/drivers/pinctrl/qcom/pinctrl-ipq5018.c
@@ -363,7 +363,7 @@ static const char * const blsp1_uart0_groups[] = {
 };
 
 static const char * const gcc_plltest_groups[] = {
-	"gpio10", "gpio12",
+	"gpio10",
 };
 
 static const char * const gcc_tlmm_groups[] = {
@@ -557,7 +557,7 @@ static const char * const qdss_cti_trig_in_b0_groups[] = {
 };
 
 static const char * const pwm2_groups[] = {
-	"gpio44",
+	"gpio12", "gpio44",
 };
 
 static const char * const qdss_cti_trig_out_b1_groups[] = {
@@ -565,7 +565,7 @@ static const char * const qdss_cti_trig_out_b1_groups[] = {
 };
 
 static const char * const pwm3_groups[] = {
-	"gpio45",
+	"gpio45", "gpio13",
 };
 
 static const char * const qdss_cti_trig_in_b1_groups[] = {
@@ -690,8 +690,8 @@ static const struct msm_pingroup ipq5018_groups[] = {
 	PINGROUP(9, sdc1_clk, qspi_clk, _, qdss_tracedata_a, _, _, _, _, _),
 	PINGROUP(10, blsp0_spi, blsp1_uart0, led0, gcc_plltest, qdss_tracedata_a, _, _, _, _),
 	PINGROUP(11, blsp0_spi, blsp1_uart0, _, gcc_tlmm, qdss_tracedata_a, _, _, _, _),
-	PINGROUP(12, blsp0_spi, blsp0_i2c, blsp1_uart0, _, gcc_plltest, qdss_tracedata_a, _, _, _),
-	PINGROUP(13, blsp0_spi, blsp0_i2c, blsp1_uart0, _, qdss_tracedata_a, _, _, _, _),
+	PINGROUP(12, blsp0_spi, blsp0_i2c, blsp1_uart0, _, pwm2, qdss_tracedata_a, _, _, _),
+	PINGROUP(13, blsp0_spi, blsp0_i2c, blsp1_uart0, pwm3, qdss_tracedata_a, _, _, _, _),
 	PINGROUP(14, pcie0_clk, _, _, cri_trng0, qdss_tracedata_a, _, _, _, _),
 	PINGROUP(15, _, _, cri_trng1, qdss_tracedata_a, _, _, _, _, _),
 	PINGROUP(16, pcie0_wake, _, _, cri_trng, qdss_tracedata_a, _, _, _, _),
diff --git a/drivers/pinctrl/qcom/pinctrl-qcs8300.c b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
index f1af1a620684..0819a2935346 100644
--- a/drivers/pinctrl/qcom/pinctrl-qcs8300.c
+++ b/drivers/pinctrl/qcom/pinctrl-qcs8300.c
@@ -46,6 +46,7 @@
 		.intr_enable_bit = 0,		\
 		.intr_status_bit = 0,		\
 		.intr_target_bit = 5,		\
+		.intr_target_width = 4,		\
 		.intr_target_kpss_val = 3,	\
 		.intr_raw_status_bit = 4,	\
 		.intr_polarity_bit = 1,		\
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
index 50a16f3bd131..8bcd566593ae 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi-dt.c
@@ -84,6 +84,7 @@ static struct sunxi_desc_pin *init_pins_table(struct device *dev,
 	 * Find the total number of pins.
 	 * Also work out how much memory we need to store all the pin names.
 	 */
+	desc->npins = 0;
 	for (i = 0; i < SUNXI_PINCTRL_MAX_BANKS; i++) {
 		desc->npins += pins_per_bank[i];
 		if (pins_per_bank[i] < 10) {
diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 5b57bbba79d4..ef2446386c2a 100644
--- a/drivers/power/supply/ds2780_battery.c
+++ b/drivers/power/supply/ds2780_battery.c
@@ -304,7 +304,7 @@ static int ds2780_get_capacity(struct ds2780_device_info *dev_info,
 		return ret;
 
 	*capacity = raw;
-	return raw;
+	return 0;
 }
 
 static int ds2780_get_status(struct ds2780_device_info *dev_info, int *status)
diff --git a/drivers/power/supply/generic-adc-battery.c b/drivers/power/supply/generic-adc-battery.c
index f5f2566b3a32..c69c9b9fa0eb 100644
--- a/drivers/power/supply/generic-adc-battery.c
+++ b/drivers/power/supply/generic-adc-battery.c
@@ -90,12 +90,17 @@ static int gab_read_channel(struct gab *adc_bat, enum gab_chan_type channel,
 	int ret;
 
 	ret = iio_read_channel_processed(adc_bat->channel[channel], result);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(&adc_bat->psy->dev, "read channel error: %d\n", ret);
+		return ret;
+	}
+
+	if (channel == GAB_TEMP)
+		*result /= 100; /* Convert from milli- to deci-degree */
 	else
 		*result *= 1000;
 
-	return ret;
+	return 0;
 }
 
 static int gab_get_property(struct power_supply *psy,
diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 42ad333394d9..615dc27089a3 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -1377,6 +1377,19 @@ void power_supply_external_power_changed(struct power_supply *psy)
 			!psy->desc->external_power_changed)
 		return;
 
+	/*
+	 * Keep power_supply_unregister() from returning, and thus from letting
+	 * the driver's data be freed, while the callback is running. The
+	 * ->removing check has to happen under the lock: on its own, just like
+	 * the use_cnt check above, it only tells us the supply was still there
+	 * when we looked, not that it still is by the time the callback
+	 * dereferences its driver data.
+	 */
+	guard(rwsem_read)(&psy->epc_sem);
+
+	if (psy->removing)
+		return;
+
 	psy->desc->external_power_changed(psy);
 }
 EXPORT_SYMBOL_GPL(power_supply_external_power_changed);
@@ -1621,6 +1634,7 @@ __power_supply_register(struct device *parent,
 	}
 
 	spin_lock_init(&psy->changed_lock);
+	init_rwsem(&psy->epc_sem);
 	init_rwsem(&psy->extensions_sem);
 	INIT_LIST_HEAD(&psy->extensions);
 
@@ -1753,7 +1767,17 @@ EXPORT_SYMBOL_GPL(devm_power_supply_register);
 void power_supply_unregister(struct power_supply *psy)
 {
 	WARN_ON(atomic_dec_return(&psy->use_cnt));
-	psy->removing = true;
+
+	/*
+	 * Publish ->removing so that no new ->external_power_changed() call can
+	 * start, and wait via semaphore for one that is already running: it may
+	 * be a supplier's changed_work, which cancel_work_sync() below does not
+	 * cover, and it may still dereference driver data that the caller is
+	 * about to free.
+	 */
+	scoped_guard(rwsem_write, &psy->epc_sem)
+		psy->removing = true;
+
 	cancel_work_sync(&psy->changed_work);
 	cancel_delayed_work_sync(&psy->deferred_register_work);
 	sysfs_remove_link(&psy->dev.kobj, "powers");
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 407b7c516658..bca949cbfb36 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -827,7 +827,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
 
 	fsm_deltimer(&grp->timer);
 
-	if (grp->saved_xid2->xid2_flag2 == 0x40) {
+	if (priv->xid->xid2_flag2 == 0x40) {
 		priv->xid->xid2_flag2 = 0x00;
 		if (grp->estconnfunc) {
 			grp->estconnfunc(grp->port_num, 1,
@@ -1637,7 +1637,6 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
 			"The XID used in the MPC protocol is not valid, "
 			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
-		grp->saved_xid2->xid2_flag2 = 0x40;
 	}
 
 	return rc;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index e2adebc80b3a..0a6c3ab0ffcd 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -1142,13 +1142,15 @@ static int iscsi_handle_reject(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 			spin_unlock(&conn->session->frwd_lock);
 			spin_lock(&conn->session->back_lock);
 		} else {
-			struct iscsi_task *task;
+			struct iscsi_task *task = NULL;
 			/*
 			 * Our nop as ping got dropped. We know the target
 			 * and transport are ok so just clean up
 			 */
-			task = iscsi_itt_to_task(conn, rejected_pdu.itt);
-			if (!task) {
+			if (!iscsi_verify_itt(conn, rejected_pdu.itt))
+				task = iscsi_itt_to_task(conn, rejected_pdu.itt);
+			if (!task || task->state == ISCSI_TASK_FREE ||
+			    task->sc) {
 				iscsi_conn_printk(KERN_ERR, conn,
 						 "Invalid pdu reject. Could "
 						 "not lookup rejected task.\n");
@@ -1191,7 +1193,7 @@ struct iscsi_task *iscsi_itt_to_task(struct iscsi_conn *conn, itt_t itt)
 		session->tt->parse_pdu_itt(conn, itt, &i, NULL);
 	else
 		i = get_itt(itt);
-	if (i >= session->cmds_max)
+	if (i < 0 || i >= session->cmds_max)
 		return NULL;
 
 	return session->cmds[i];
@@ -1284,7 +1286,7 @@ int __iscsi_complete_pdu(struct iscsi_conn *conn, struct iscsi_hdr *hdr,
 	case ISCSI_OP_SCSI_TMFUNC_RSP:
 	case ISCSI_OP_NOOP_IN:
 		task = iscsi_itt_to_task(conn, hdr->itt);
-		if (!task)
+		if (!task || task->state == ISCSI_TASK_FREE || task->sc)
 			return ISCSI_ERR_BAD_ITT;
 		break;
 	default:
@@ -1384,7 +1386,7 @@ int iscsi_verify_itt(struct iscsi_conn *conn, itt_t itt)
 		return ISCSI_ERR_BAD_ITT;
 	}
 
-	if (i >= session->cmds_max) {
+	if (i < 0 || i >= session->cmds_max) {
 		iscsi_conn_printk(KERN_ERR, conn,
 				  "received invalid itt index %u (max cmds "
 				   "%u.\n", i, session->cmds_max);
diff --git a/drivers/scsi/libsas/sas_expander.c b/drivers/scsi/libsas/sas_expander.c
index d953225f6cc2..c9a7a55a5917 100644
--- a/drivers/scsi/libsas/sas_expander.c
+++ b/drivers/scsi/libsas/sas_expander.c
@@ -62,7 +62,11 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		to_sas_internal(dev->port->ha->shost->transportt);
 	struct sas_ha_struct *ha = dev->port->ha;
 
-	pm_runtime_get_sync(ha->dev);
+	/*
+	 * Non-blocking: a sync resume here would deadlock against
+	 * sas_drain_work() during HA resume.
+	 */
+	pm_runtime_get_noresume(ha->dev);
 	mutex_lock(&dev->ex_dev.cmd_mutex);
 	for (retry = 0; retry < 3; retry++) {
 		if (test_bit(SAS_DEV_GONE, &dev->state)) {
@@ -135,7 +139,7 @@ static int smp_execute_task_sg(struct domain_device *dev,
 		}
 	}
 	mutex_unlock(&dev->ex_dev.cmd_mutex);
-	pm_runtime_put_sync(ha->dev);
+	pm_runtime_put(ha->dev);
 
 	BUG_ON(retry == 3 && task != NULL);
 	sas_free_task(task);
@@ -2162,6 +2166,11 @@ void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		goto out;
 	}
 
+	/* The host may have autosuspended, resume it here. */
+	ret = pm_runtime_resume_and_get(dev->port->ha->dev);
+	if (ret)
+		goto out;
+
 	ret = smp_execute_task_sg(dev, job->request_payload.sg_list,
 			job->reply_payload.sg_list);
 	if (ret >= 0) {
@@ -2169,6 +2178,7 @@ void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		rcvlen = job->reply_payload.payload_len - ret;
 		ret = 0;
 	}
+	pm_runtime_put(dev->port->ha->dev);
 
 out:
 	bsg_job_done(job, ret, rcvlen);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 0e5478d62580..f4174d549fe6 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -3053,7 +3053,7 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 	}
 
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
-			mpi3mr_bsg_request, NULL, 0);
+			mpi3mr_bsg_request, NULL, 0, SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		ioc_err(mrioc, "%s: bsg registration failed\n",
 		    dev_name(bsg_dev));
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 2661cf9908a5..5b222802fad1 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -4302,7 +4302,8 @@ fc_bsg_hostadd(struct Scsi_Host *shost, struct fc_host_attrs *fc_host)
 	scsi_init_limits(shost, &lim);
 	lim.max_segments = min_not_zero(lim.max_segments, i->f->max_bsg_segments);
 	q = bsg_setup_queue(dev, bsg_name, &lim, fc_bsg_dispatch,
-			fc_bsg_job_timeout, i->f->dd_bsg_size);
+			fc_bsg_job_timeout, i->f->dd_bsg_size,
+			SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		dev_err(dev,
 			"fc_host%d: bsg interface failed to initialize - setup queue\n",
@@ -4335,7 +4336,8 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
 	scsi_init_limits(shost, &lim);
 	lim.max_segments = min_not_zero(lim.max_segments, i->f->max_bsg_segments);
 	q = bsg_setup_queue(dev, dev_name(dev), &lim, fc_bsg_dispatch_prep,
-				fc_bsg_job_timeout, i->f->dd_bsg_size);
+				fc_bsg_job_timeout, i->f->dd_bsg_size,
+				SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		dev_err(dev, "failed to setup bsg queue\n");
 		return PTR_ERR(q);
diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 743b4c792ceb..5ef807335e27 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -1545,7 +1545,7 @@ iscsi_bsg_host_add(struct Scsi_Host *shost, struct iscsi_cls_host *ihost)
 	snprintf(bsg_name, sizeof(bsg_name), "iscsi_host%d", shost->host_no);
 	scsi_init_limits(shost, &lim);
 	q = bsg_setup_queue(dev, bsg_name, &lim, iscsi_bsg_host_dispatch, NULL,
-			0);
+			0, SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		shost_printk(KERN_ERR, shost, "bsg interface failed to "
 			     "initialize - no request queue\n");
diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
index bbbc2f448e7d..860cab565c59 100644
--- a/drivers/scsi/scsi_transport_sas.c
+++ b/drivers/scsi/scsi_transport_sas.c
@@ -199,7 +199,8 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 
 	if (rphy) {
 		q = bsg_setup_queue(&rphy->dev, dev_name(&rphy->dev), NULL,
-				sas_smp_dispatch, NULL, 0);
+				sas_smp_dispatch, NULL, 0,
+				SCSI_SENSE_BUFFERSIZE);
 		if (IS_ERR(q))
 			return PTR_ERR(q);
 		rphy->q = q;
@@ -208,7 +209,8 @@ static int sas_bsg_initialize(struct Scsi_Host *shost, struct sas_rphy *rphy)
 
 		snprintf(name, sizeof(name), "sas_host%d", shost->host_no);
 		q = bsg_setup_queue(&shost->shost_gendev, name, NULL,
-				sas_smp_dispatch, NULL, 0);
+				sas_smp_dispatch, NULL, 0,
+				SCSI_SENSE_BUFFERSIZE);
 		if (IS_ERR(q))
 			return PTR_ERR(q);
 		to_sas_host_attrs(shost)->q = q;
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 74a6830b7ed8..476a45fdf787 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3216,14 +3216,20 @@ static int set_location(struct scsi_tape *STp, unsigned int block, int partition
 	    partition >= ST_NBR_PARTITIONS)
 		return (-EINVAL);
 	if (partition != STp->partition) {
-		if (get_location(STp, &blk, &p, 1))
+		/*
+		 * Save the location for the partition the drive reports,
+		 * not for STp->partition: after a reset STp->partition may
+		 * not match the partition the drive is in.
+		 */
+		if (get_location(STp, &blk, &p, 1) ||
+		    p < 0 || p >= ST_NBR_PARTITIONS)
 			STps->last_block_valid = 0;
 		else {
-			STps->last_block_valid = 1;
-			STps->last_block_visited = blk;
+			STp->ps[p].last_block_valid = 1;
+			STp->ps[p].last_block_visited = blk;
 			DEBC_printk(STp, "Visited block %d for "
 				    "partition %d saved.\n",
-				    blk, STp->partition);
+				    blk, p);
 		}
 	}
 
@@ -4465,11 +4471,11 @@ static int st_remove(struct device *dev)
 	remove_cdevs(tpnt);
 
 	mutex_lock(&st_ref_mutex);
-	kref_put(&tpnt->kref, scsi_tape_release);
-	mutex_unlock(&st_ref_mutex);
 	spin_lock(&st_index_lock);
 	idr_remove(&st_index_idr, index);
 	spin_unlock(&st_index_lock);
+	kref_put(&tpnt->kref, scsi_tape_release);
+	mutex_unlock(&st_ref_mutex);
 	return 0;
 }
 
diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 924025305753..59928be4c273 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -367,6 +367,7 @@ static void scsifront_do_response(struct vscsifrnt_info *info,
 	struct vscsifrnt_shadow *shadow;
 
 	if (ring_rsp->rqid >= VSCSIIF_MAX_REQS ||
+	    !info->shadow[ring_rsp->rqid] ||
 	    !info->shadow[ring_rsp->rqid]->inflight) {
 		scsifront_set_error(info, "illegal rqid returned by backend!");
 		return;
diff --git a/drivers/soc/tegra/fuse/tegra-apbmisc.c b/drivers/soc/tegra/fuse/tegra-apbmisc.c
index 0ce94fdc536f..1c25b36c2f3c 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -278,7 +278,7 @@ void tegra_acpi_init_apbmisc(void)
 
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0) {
-		pr_err("failed to get APBMISC memory resources");
+		pr_err("failed to get APBMISC memory resources\n");
 		goto out_put_acpi_dev;
 	}
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index a28597b6b80d..b696c34d83de 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -859,6 +859,13 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 		command1 |= SPI_BIT_LENGTH(bits_per_word - 1);
 	}
 
+	/*
+	 * Re-assert the CS GPIO for every transfer: transfer_end() drops it
+	 * on cs_change, and the assert above only covers is_first_of_msg.
+	 */
+	if (spi_get_csgpiod(spi, 0))
+		gpiod_set_value(spi_get_csgpiod(spi, 0), 1);
+
 	return command1;
 }
 
diff --git a/drivers/target/iscsi/iscsi_target_configfs.c b/drivers/target/iscsi/iscsi_target_configfs.c
index efe8cdb20060..3b4e7a8d3d31 100644
--- a/drivers/target/iscsi/iscsi_target_configfs.c
+++ b/drivers/target/iscsi/iscsi_target_configfs.c
@@ -1306,17 +1306,24 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 		return -EINVAL;
 	}
 
+	if (iscsit_get_tpg(discovery_tpg) < 0)
+		return -EINVAL;
+
 	param = iscsi_find_param_from_key(AUTHMETHOD,
 				discovery_tpg->param_list);
-	if (!param)
-		return -EINVAL;
+	if (!param) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	if (op) {
 		/*
 		 * Reset the AuthMethod key to CHAP.
 		 */
-		if (iscsi_update_param_value(param, CHAP) < 0)
-			return -EINVAL;
+		if (iscsi_update_param_value(param, CHAP) < 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		discovery_tpg->tpg_attrib.authentication = 1;
 		iscsit_global->discovery_acl.node_auth.enforce_discovery_auth = 1;
@@ -1327,8 +1334,10 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 		/*
 		 * Reset the AuthMethod key to CHAP,None
 		 */
-		if (iscsi_update_param_value(param, "CHAP,None") < 0)
-			return -EINVAL;
+		if (iscsi_update_param_value(param, "CHAP,None") < 0) {
+			err = -EINVAL;
+			goto out;
+		}
 
 		discovery_tpg->tpg_attrib.authentication = 0;
 		iscsit_global->discovery_acl.node_auth.enforce_discovery_auth = 0;
@@ -1337,7 +1346,10 @@ static ssize_t iscsi_disc_enforce_discovery_auth_store(struct config_item *item,
 			" Discovery TPG\n");
 	}
 
-	return count;
+	err = count;
+out:
+	iscsit_put_tpg(discovery_tpg);
+	return err;
 }
 
 CONFIGFS_ATTR(iscsi_disc_, enforce_discovery_auth);
diff --git a/drivers/ufs/core/ufs_bsg.c b/drivers/ufs/core/ufs_bsg.c
index 252186124669..bb6ff8ca5c7a 100644
--- a/drivers/ufs/core/ufs_bsg.c
+++ b/drivers/ufs/core/ufs_bsg.c
@@ -257,7 +257,7 @@ int ufs_bsg_probe(struct ufs_hba *hba)
 		goto out;
 
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), NULL, ufs_bsg_request,
-			NULL, 0);
+			NULL, 0, sizeof(struct ufs_rpmb_reply));
 	if (IS_ERR(q)) {
 		ret = PTR_ERR(q);
 		device_del(bsg_dev);
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 61cba72f0c40..a0798e4f7512 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -252,6 +252,8 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	/* afs_atcell_get_link() reads ->net_ns in rcu pathwalk */
+	struct rcu_head		rcu;
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 0612dd76a18e..bb32c19fea29 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -523,7 +523,7 @@ static void afs_destroy_sbi(struct afs_super_info *as)
 		afs_put_volume(as->volume, afs_volume_trace_put_destroy_sbi);
 		afs_unuse_cell(as->cell, afs_cell_trace_unuse_sbi);
 		put_net(as->net_ns);
-		kfree(as);
+		kfree_rcu(as, rcu);
 	}
 }
 
diff --git a/fs/autofs/waitq.c b/fs/autofs/waitq.c
index 33dd4660d82f..cab26ca65873 100644
--- a/fs/autofs/waitq.c
+++ b/fs/autofs/waitq.c
@@ -12,15 +12,13 @@
  */
 static autofs_wqt_t autofs_next_wait_queue = 1;
 
-void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+static void autofs_catatonic_mode_locked(struct autofs_sb_info *sbi)
 {
 	struct autofs_wait_queue *wq, *nwq;
 
-	mutex_lock(&sbi->wq_mutex);
-	if (sbi->flags & AUTOFS_SBI_CATATONIC) {
-		mutex_unlock(&sbi->wq_mutex);
+	lockdep_assert_held(&sbi->wq_mutex);
+	if (sbi->flags & AUTOFS_SBI_CATATONIC)
 		return;
-	}
 
 	pr_debug("entering catatonic mode\n");
 
@@ -40,6 +38,21 @@ void autofs_catatonic_mode(struct autofs_sb_info *sbi)
 	fput(sbi->pipe);	/* Close the pipe */
 	sbi->pipe = NULL;
 	sbi->pipefd = -1;
+}
+
+void autofs_catatonic_mode(struct autofs_sb_info *sbi)
+{
+	mutex_lock(&sbi->wq_mutex);
+	autofs_catatonic_mode_locked(sbi);
+	mutex_unlock(&sbi->wq_mutex);
+}
+
+static void autofs_catatonic_mode_for_pipe(struct autofs_sb_info *sbi,
+					   struct file *pipe)
+{
+	mutex_lock(&sbi->wq_mutex);
+	if (sbi->pipe == pipe)
+		autofs_catatonic_mode_locked(sbi);
 	mutex_unlock(&sbi->wq_mutex);
 }
 
@@ -170,7 +183,7 @@ static void autofs_notify_daemon(struct autofs_sb_info *sbi,
 		autofs_wait_release(sbi, wq->wait_queue_token, ret);
 		break;
 	default:
-		autofs_catatonic_mode(sbi);
+		autofs_catatonic_mode_for_pipe(sbi, pipe);
 		break;
 	}
 	fput(pipe);
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index da6428312c36..dae7fb8bc598 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1694,6 +1694,8 @@ struct ext4_sb_info {
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
+	/* ext4_get_link() reads the sbi in rcu pathwalk */
+	struct rcu_head s_rcu;
 	struct mb_cache *s_ea_block_cache;
 	struct mb_cache *s_ea_inode_cache;
 	spinlock_t s_es_lock ____cacheline_aligned_in_smp;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 31dc0496f8d0..fbfd1937d07d 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1796,12 +1796,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
 }
 
 void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi)
+{
+	shrinker_free(sbi->s_es_shrinker);
+}
+
+/* ext4_get_link() bumps the hit and miss counters in rcu pathwalk */
+void ext4_es_destroy_stats(struct ext4_sb_info *sbi)
 {
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_hits);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_cache_misses);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_all_cnt);
 	percpu_counter_destroy(&sbi->s_es_stats.es_stats_shk_cnt);
-	shrinker_free(sbi->s_es_shrinker);
 }
 
 /*
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index 8f9c008d11e8..502d9110a73c 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -238,6 +238,7 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 
 extern int ext4_es_register_shrinker(struct ext4_sb_info *sbi);
 extern void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi);
+extern void ext4_es_destroy_stats(struct ext4_sb_info *sbi);
 
 extern int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 9b45d27515f9..3f5e9d825a5e 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1268,6 +1268,14 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
 	}
 }
 
+static void ext4_put_sbi_rcu(struct rcu_head *head)
+{
+	struct ext4_sb_info *sbi = container_of(head, struct ext4_sb_info, s_rcu);
+
+	ext4_es_destroy_stats(sbi);
+	kfree(sbi);
+}
+
 static void ext4_put_super(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -1361,7 +1369,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_stop_mmpd(sbi);
 
 	brelse(sbi->s_sbh);
-	sb->s_fs_info = NULL;
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1374,7 +1381,8 @@ static void ext4_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
+	/* ext4_get_link() reads the sbi and the counters in rcu pathwalk */
+	call_rcu(&sbi->s_rcu, ext4_put_sbi_rcu);
 }
 
 static struct kmem_cache *ext4_inode_cachep;
@@ -5692,6 +5700,7 @@ failed_mount8: __maybe_unused
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
diff --git a/fs/namei.c b/fs/namei.c
index 2e86733b4bac..fc2f463c6ea4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3864,8 +3864,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 		return dentry;
 
 	if (open_flag & O_CREAT) {
-		/* Discard negative dentries. Need inode_lock to do the create */
-		if (!dentry->d_inode) {
+		if (d_is_negative(dentry)) {
 			if (!(nd->flags & LOOKUP_RCU))
 				dput(dentry);
 			dentry = NULL;
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 78338075f08a..6be5f4c96119 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -786,6 +786,11 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 		goto restart;
 	}
 
+	if (conn->flags & FSNOTIFY_CONN_FLAG_DESTROYING) {
+		err = -ENOENT;
+		goto out_err;
+	}
+
 	/* is mark the first mark? */
 	if (hlist_empty(&conn->list)) {
 		hlist_add_head_rcu(&mark->obj_list, &conn->list);
@@ -973,6 +978,12 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
 	conn = fsnotify_grab_connector(connp);
 	if (!conn)
 		return;
+	/*
+	 * New marks could be inserted before our cursor and survive the final
+	 * detachment of the connector from the object. Prevent additions to
+	 * this connector before dropping its lock.
+	 */
+	conn->flags |= FSNOTIFY_CONN_FLAG_DESTROYING;
 	/*
 	 * We have to be careful since we can race with e.g.
 	 * fsnotify_clear_marks_by_group() and once we drop the conn->lock, the
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 99a78204b986..9cacca339705 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -209,6 +209,7 @@ struct ntfs_index {
 /* Ntfs file system in-core superblock data. */
 struct ntfs_sb_info {
 	struct super_block *sb;
+	struct rcu_head rcu;
 
 	u32 discard_granularity;
 	u64 discard_granularity_mask_inv; // ~(discard_granularity_mask_inv-1)
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 346c52f95207..dc799ebc6c88 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -194,7 +194,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 	void *ret = NULL;
 	int i, j = -1;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (!s_shared[i].cnt) {
 			j = i;
@@ -212,7 +212,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 		s_shared[j].cnt = 1;
 		ret = ptr;
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -229,7 +229,7 @@ void *ntfs_put_shared(void *ptr)
 	void *ret = ptr;
 	int i;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (s_shared[i].cnt && s_shared[i].ptr == ptr) {
 			if (--s_shared[i].cnt)
@@ -237,7 +237,7 @@ void *ntfs_put_shared(void *ptr)
 			break;
 		}
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -684,6 +684,8 @@ static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 
 static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
+	if (sbi->options)
+		put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kvfree(sbi->def_table);
@@ -695,6 +697,11 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 	kfree(sbi);
 }
 
+static void ntfs3_free_sbi_rcu(struct rcu_head *head)
+{
+	ntfs3_free_sbi(container_of(head, struct ntfs_sb_info, rcu));
+}
+
 static void ntfs_put_super(struct super_block *sb)
 {
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
@@ -703,6 +710,12 @@ static void ntfs_put_super(struct super_block *sb)
 
 	/* Mark rw ntfs as clear, if possible. */
 	ntfs_set_state(sbi, NTFS_DIRTY_CLEAR);
+
+	/*
+	 * The mount options stay until the sbi is freed: ->d_hash() and
+	 * ->d_compare() of a pathwalk in rcu mode read the nls table through
+	 * them.
+	 */
 	ntfs3_put_sbi(sbi);
 }
 
@@ -1221,7 +1234,8 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	int err;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
 	struct block_device *bdev = sb->s_bdev;
-	struct ntfs_mount_options *options;
+	struct ntfs_mount_options *fc_opts;
+	struct ntfs_mount_options *options = NULL;
 	struct inode *inode;
 	struct ntfs_inode *ni;
 	size_t i, tt, bad_len, bad_frags;
@@ -1238,20 +1252,35 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	ref.high = 0;
 
 	sbi->sb = sb;
-	sbi->options = options = fc->fs_private;
-	fc->fs_private = NULL;
+	fc_opts = fc->fs_private;
+	if (!fc_opts) {
+		errorf(fc, "missing mount options");
+		return -EINVAL;
+	}
+	options = kmemdup(fc_opts, sizeof(*fc_opts), GFP_KERNEL);
+	if (!options)
+		return -ENOMEM;
+
+	if (fc_opts->nls_name) {
+		options->nls_name = kstrdup(fc_opts->nls_name, GFP_KERNEL);
+		if (!options->nls_name) {
+			kfree(options);
+			return -ENOMEM;
+		}
+	}
+	sbi->options = options;
 	sb->s_flags |= SB_NODIRATIME;
 	sb->s_magic = 0x7366746e; // "ntfs"
 	sb->s_op = &ntfs_sops;
 	sb->s_export_op = &ntfs_export_ops;
 	sb->s_time_gran = NTFS_TIME_GRAN; // 100 nsec
 	sb->s_xattr = ntfs_xattr_handlers;
-	set_default_d_op(sb, options->nocase ? &ntfs_dentry_ops : NULL);
+	set_default_d_op(sb, sbi->options->nocase ? &ntfs_dentry_ops : NULL);
 
-	options->nls = ntfs_load_nls(options->nls_name);
-	if (IS_ERR(options->nls)) {
-		options->nls = NULL;
-		errorf(fc, "Cannot load nls %s", options->nls_name);
+	sbi->options->nls = ntfs_load_nls(sbi->options->nls_name);
+	if (IS_ERR(sbi->options->nls)) {
+		sbi->options->nls = NULL;
+		errorf(fc, "Cannot load nls %s", fc_opts->nls_name);
 		err = -EINVAL;
 		goto out;
 	}
@@ -1668,6 +1697,11 @@ static int ntfs_fill_super(struct super_block *sb, struct fs_context *fc)
 put_inode_out:
 	iput(inode);
 out:
+	if (sbi && sbi->options) {
+		put_mount_options(sbi->options);
+		sbi->options = NULL;
+	}
+
 	ntfs3_put_sbi(sbi);
 	kfree(boot2);
 	return err;
@@ -1838,9 +1872,11 @@ static void ntfs3_kill_sb(struct super_block *sb)
 
 	kill_block_super(sb);
 
-	if (sbi->options)
-		put_mount_options(sbi->options);
-	ntfs3_free_sbi(sbi);
+	/*
+	 * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare()
+	 * and read the upcase table and the nls table through the sbi.
+	 */
+	call_rcu(&sbi->rcu, ntfs3_free_sbi_rcu);
 }
 
 // clang-format off
diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
index 20f790a47484..58b28dfa8d34 100644
--- a/fs/ocfs2/dlm/dlmcommon.h
+++ b/fs/ocfs2/dlm/dlmcommon.h
@@ -435,6 +435,8 @@ enum {
 	DLM_DEREF_LOCKRES_DONE		= 522,
 };
 
+extern spinlock_t dlm_reco_state_lock;
+
 struct dlm_reco_node_data
 {
 	int state;
diff --git a/fs/ocfs2/dlm/dlmdebug.c b/fs/ocfs2/dlm/dlmdebug.c
index 564567358620..38a6a99603a9 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -740,8 +740,11 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
 				 buf + out, len - out);
 	out += scnprintf(buf + out, len - out, "\n");
 
+	spin_unlock(&dlm->spinlock);
+
 	/* Recovery Node State: */
 	out += scnprintf(buf + out, len - out, "Recovery Node State:\n");
+	spin_lock(&dlm_reco_state_lock);
 	list_for_each_entry(node, &dlm->reco.node_data, list) {
 		switch (node->state) {
 		case DLM_RECO_NODE_DATA_INIT:
@@ -773,7 +776,7 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
 				node->node_num, state);
 	}
 
-	spin_unlock(&dlm->spinlock);
+	spin_unlock(&dlm_reco_state_lock);
 
 	return out;
 }
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 2379225f0ee6..a55787282eaf 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -80,7 +80,7 @@ static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
 
 static u64 dlm_get_next_mig_cookie(void);
 
-static DEFINE_SPINLOCK(dlm_reco_state_lock);
+DEFINE_SPINLOCK(dlm_reco_state_lock);
 static DEFINE_SPINLOCK(dlm_mig_cookie_lock);
 static u64 dlm_mig_cookie = 1;
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 42fead1efe52..ec1742bad3e7 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -755,9 +755,11 @@ pipe_fasync(int fd, struct file *filp, int on)
 	if (filp->f_mode & FMODE_READ)
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_readers);
 	if ((filp->f_mode & FMODE_WRITE) && retval >= 0) {
+		int read_ret = retval;
+
 		retval = fasync_helper(fd, filp, on, &pipe->fasync_writers);
-		if (retval < 0 && (filp->f_mode & FMODE_READ))
-			/* this can happen only if on == T */
+		/* Undo only a reader entry added by this call. */
+		if (retval < 0 && read_ret > 0)
 			fasync_helper(-1, filp, 0, &pipe->fasync_readers);
 	}
 	mutex_unlock(&pipe->mutex);
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index f63519a0b1d8..0429e90dcfd6 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1463,9 +1463,13 @@ static loff_t cifs_remap_file_range(struct file *src_file, loff_t off,
 			target_cifsi->netfs.zero_point = new_size;
 	}
 
-	/* force revalidate of size and timestamps of target file now
-	   that target is updated on the server */
-	CIFS_I(target_inode)->time = 0;
+	/*
+	 * On success, duplicate_extents already updated the target inode attrs
+	 * or marked them stale if the refresh failed.  On failure, mark attrs
+	 * stale because EOF may have changed before the clone failed.
+	 */
+	if (rc)
+		CIFS_I(target_inode)->time = 0;
 unlock:
 	/* although unlocking in the reverse order from locking is not
 	   strictly necessary here it is a little cleaner to be consistent */
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 0a5b580e5227..0f293819d5e1 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3502,6 +3502,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count, data_count, param_offset, offset;
+	size_t cifs_acl_size, bytes_available;
 
 	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
 setAclRetry:
@@ -3520,8 +3521,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	params = 6 + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
-	/* BB find max SMB size from sess */
-	pSMB->MaxDataCount = cpu_to_le16(1000);
+	pSMB->MaxDataCount = cpu_to_le16(min_t(unsigned int, CIFSMaxBufSize, USHRT_MAX));
 	pSMB->MaxSetupCount = 0;
 	pSMB->Reserved = 0;
 	pSMB->Flags = 0;
@@ -3533,6 +3533,15 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	parm_data = ((char *)pSMB) + sizeof(pSMB->hdr.smb_buf_length) + offset;
 	pSMB->ParameterOffset = cpu_to_le16(param_offset);
 
+	/* make sure we can fit the larger cifs_posix_aces in the buffer */
+	cifs_acl_size = sizeof(struct cifs_posix_acl) +
+		       (acl->a_count * sizeof(struct cifs_posix_ace));
+	bytes_available = (CIFSMaxBufSize + MAX_HEADER_SIZE(tcon->ses->server)) - offset;
+	if (cifs_acl_size > bytes_available || cifs_acl_size > USHRT_MAX) {
+		rc = -E2BIG;
+		goto setACLerrorExit;
+	}
+
 	/* convert to on the wire format for POSIX ACL */
 	data_count = posix_acl_to_cifs(parm_data, acl, acl_type);
 
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 151399de7d6a..e908d522920c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4224,14 +4224,25 @@ cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
 	return rc;
 }
 
-static int
-cifs_set_vol_auth(struct smb3_fs_context *ctx, struct cifs_ses *ses)
+static int set_fs_context_auth(struct smb3_fs_context *ctx,
+			       struct cifs_ses *ses)
 {
 	ctx->sectype = ses->sectype;
 
-	/* krb5 is special, since we don't need username or pw */
-	if (ctx->sectype == Kerberos)
+	/*
+	 * krb5 is special as we might need to pass username (passwordless) down
+	 * to cifs.upcall(8) for keytab.
+	 */
+	if (ctx->sectype == Kerberos) {
+		if (ses->user_name && ses->user_name[0]) {
+			ctx->username = kstrndup(ses->user_name,
+						 CIFS_MAX_USERNAME_LEN,
+						 GFP_KERNEL);
+			if (!ctx->username)
+				return -ENOMEM;
+		}
 		return 0;
+	}
 
 	return cifs_set_cifscreds(ctx, ses);
 }
@@ -4271,7 +4282,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	ctx->dfs_root_ses = master_tcon->ses->dfs_root_ses;
 	ctx->unicode = master_tcon->ses->unicode;
 
-	rc = cifs_set_vol_auth(ctx, master_tcon->ses);
+	rc = set_fs_context_auth(ctx, master_tcon->ses);
 	if (rc) {
 		tcon = ERR_PTR(rc);
 		goto out;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 4eb1ac4f7b60..b24a7e191928 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -990,26 +990,52 @@ static int cifs_do_truncate(const unsigned int xid, struct dentry *dentry)
 	struct cifs_tcon *tcon;
 	int rc;
 
-	rc = filemap_write_and_wait(inode->i_mapping);
-	if (is_interrupt_error(rc))
+	rc = inode_lock_killable(inode);
+	if (rc)
 		return -ERESTARTSYS;
+
+	filemap_invalidate_lock(inode->i_mapping);
+
+	rc = filemap_write_and_wait(inode->i_mapping);
+	if (is_interrupt_error(rc)) {
+		rc = -ERESTARTSYS;
+		goto out;
+	}
 	mapping_set_error(inode->i_mapping, rc);
 
+	netfs_wait_for_outstanding_io(inode);
+
 	cfile = find_writable_file(cinode, FIND_WR_FSUID_ONLY);
 	rc = cifs_file_flush(xid, inode, cfile);
 	if (!rc) {
 		if (cfile) {
+			struct netfs_inode *ictx = netfs_inode(inode);
+
 			tcon = tlink_tcon(cfile->tlink);
 			server = tcon->ses->server;
+			mutex_lock(&ictx->wb_lock);
 			rc = server->ops->set_file_size(xid, tcon,
 							cfile, 0, false);
-		}
-		if (!rc) {
-			netfs_resize_file(&cinode->netfs, 0, true);
-			cifs_setsize(inode, 0);
+			if (!rc) {
+				netfs_resize_file(&cinode->netfs, 0, true);
+				cifs_setsize(inode, 0);
+				cifs_invalidate_cache(inode, 0);
+			}
+			mutex_unlock(&ictx->wb_lock);
+		} else {
+			/*
+			 * No cached handle; evict stale pages so they can't
+			 * be served after the file is later extended; let
+			 * the server's O_TRUNC open response set the i_size
+			 */
+			truncate_inode_pages(inode->i_mapping, 0);
 			cifs_invalidate_cache(inode, 0);
 		}
 	}
+
+out:
+	filemap_invalidate_unlock(inode->i_mapping);
+	inode_unlock(inode);
 	if (cfile)
 		cifsFileInfo_put(cfile);
 	return rc;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2026e627bc44..600ecf4382fa 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2271,10 +2271,14 @@ smb2_duplicate_extents(const unsigned int xid,
 			u64 len, u64 dest_off)
 {
 	int rc;
+	int qrc;
 	unsigned int ret_data_len;
 	struct inode *inode;
+	struct smb2_file_all_info file_inf;
 	struct duplicate_extents_to_file dup_ext_buf;
+	struct timespec64 ts;
 	struct cifs_tcon *tcon = tlink_tcon(trgtfile->tlink);
+	u64 asize;
 
 	/* server fileays advertise duplicate extent support with this flag */
 	if ((le32_to_cpu(tcon->fsAttrInfo.Attributes) &
@@ -2292,7 +2296,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2309,6 +2313,35 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	} else {
+		qrc = SMB2_query_info(xid, tcon, trgtfile->fid.persistent_fid,
+				      trgtfile->fid.volatile_fid, &file_inf);
+		spin_lock(&inode->i_lock);
+		if (qrc == 0) {
+			asize = le64_to_cpu(file_inf.AllocationSize);
+			CIFS_I(inode)->time = jiffies;
+			if (file_inf.LastWriteTime) {
+				ts = cifs_NTtimeToUnix(file_inf.LastWriteTime);
+				inode_set_mtime_to_ts(inode, ts);
+			}
+			if (file_inf.ChangeTime) {
+				ts = cifs_NTtimeToUnix(file_inf.ChangeTime);
+				inode_set_ctime_to_ts(inode, ts);
+			}
+			if (file_inf.LastAccessTime) {
+				ts = cifs_NTtimeToUnix(file_inf.LastAccessTime);
+				inode_set_atime_to_ts(inode, ts);
+			}
+			inode->i_blocks = CIFS_INO_BLOCKS(asize);
+		} else {
+			CIFS_I(inode)->time = 0; /* force reval */
+		}
+		spin_unlock(&inode->i_lock);
+	}
+
 duplicate_extents_out:
 	if (rc)
 		trace_smb3_clone_err(xid, srcfile->fid.volatile_fid,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 27a6e47fe7a9..c97f2a128651 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5712,6 +5712,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		struct object_id_info *info;
 
 		info = (struct object_id_info *)(rsp->Buffer);
+		memset(info, 0, sizeof(*info));
 
 		if (path.mnt->mnt_sb->s_uuid_len == 16)
 			memcpy(info->objid, path.mnt->mnt_sb->s_uuid.b,
@@ -5766,6 +5767,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FreeSpaceStopFiltering = 0;
 		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->FileSystemControlFlags = 0;
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
 		fixed_len = 48;
@@ -5788,6 +5790,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->UserBlocksAvail = cpu_to_le64(stfs.f_bavail);
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
+			info->FileSysIdentifier =
+				cpu_to_le64((u64)(u32)stfs.f_fsid.val[1] << 32 |
+					    (u32)stfs.f_fsid.val[0]);
 			rsp->OutputBufferLength = cpu_to_le32(56);
 			fixed_len = 56;
 		}
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index abb0ea57601b..a992c2919f79 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -91,6 +91,14 @@ static void free_ei_rcu(struct rcu_head *rcu)
 	}
 }
 
+/* read under eventfs_srcu and, by tracefs_d_revalidate(), in rcu pathwalk */
+static void free_ei_srcu(struct rcu_head *rcu)
+{
+	struct eventfs_inode *ei = container_of(rcu, struct eventfs_inode, rcu);
+
+	call_rcu(&ei->rcu, free_ei_rcu);
+}
+
 /*
  * eventfs_inode reference count management.
  *
@@ -112,7 +120,7 @@ static void release_ei(struct kref *ref)
 			entry->release(entry->name, ei->data);
 	}
 
-	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_rcu);
+	call_srcu(&eventfs_srcu, &ei->rcu, free_ei_srcu);
 }
 
 static inline void put_ei(struct eventfs_inode *ei)
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 6fc9ab8667e6..0c15d18ae5c9 100644
--- a/fs/unicode/utf8-core.c
+++ b/fs/unicode/utf8-core.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/rcupdate.h>
 #include <linux/parser.h>
 #include <linux/errno.h>
 #include <linux/stringhash.h>
@@ -205,12 +206,24 @@ struct unicode_map *utf8_load(unsigned int version)
 }
 EXPORT_SYMBOL(utf8_load);
 
+static void utf8_unload_rcu(struct rcu_head *head)
+{
+	struct unicode_map *um = container_of(head, struct unicode_map, rcu);
+
+	symbol_put(utf8_data_table);
+	kfree(um);
+}
+
+/*
+ * A pathwalk in rcu mode may still be in ->d_hash() or ->d_compare() of a
+ * filesystem that is being torn down and read the map through its
+ * superblock, so the map and the tables it points to have to outlive the
+ * grace period.
+ */
 void utf8_unload(struct unicode_map *um)
 {
-	if (um) {
-		symbol_put(utf8_data_table);
-		kfree(um);
-	}
+	if (um)
+		call_rcu(&um->rcu, utf8_unload_rcu);
 }
 EXPORT_SYMBOL(utf8_unload);
 
diff --git a/fs/xfs/libxfs/xfs_rtgroup.h b/fs/xfs/libxfs/xfs_rtgroup.h
index a94e925ae67c..a4a336f3927c 100644
--- a/fs/xfs/libxfs/xfs_rtgroup.h
+++ b/fs/xfs/libxfs/xfs_rtgroup.h
@@ -367,7 +367,11 @@ static inline int xfs_initialize_rtgroups(struct xfs_mount *mp,
 # define xfs_rtgroup_unlock(rtg, gf)		((void)0)
 # define xfs_rtgroup_trans_join(tp, rtg, gf)	((void)0)
 # define xfs_update_rtsb(bp, sb_bp)	((void)0)
-# define xfs_log_rtsb(tp, sb_bp)	(NULL)
+static inline struct xfs_buf *xfs_log_rtsb(struct xfs_trans *tp,
+		const struct xfs_buf *sb_bp)
+{
+	return NULL;
+}
 # define xfs_rtgroup_get_geometry(rtg, rgeo)	(-EOPNOTSUPP)
 #endif /* CONFIG_XFS_RT */
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index 823ff59ba711..33ce787729ce 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1467,36 +1467,33 @@ xfs_sync_sb_buf(
 	bool			update_rtsb)
 {
 	struct xfs_trans	*tp;
-	struct xfs_buf		*bp;
-	struct xfs_buf		*rtsb_bp = NULL;
 	int			error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
-	bp = xfs_trans_getsb(tp);
 	xfs_log_sb(tp);
-	xfs_trans_bhold(tp, bp);
-	if (update_rtsb) {
-		rtsb_bp = xfs_log_rtsb(tp, bp);
-		if (rtsb_bp)
-			xfs_trans_bhold(tp, rtsb_bp);
-	}
+	if (update_rtsb)
+		xfs_log_rtsb(tp, xfs_trans_getsb(tp));
 	xfs_trans_set_sync(tp);
 	error = xfs_trans_commit(tp);
 	if (error)
-		goto out;
-	/*
-	 * write out the sb buffer to get the changes to disk
-	 */
-	error = xfs_bwrite(bp);
-	if (!error && rtsb_bp)
-		error = xfs_bwrite(rtsb_bp);
-out:
-	if (rtsb_bp)
-		xfs_buf_relse(rtsb_bp);
-	xfs_buf_relse(bp);
+		return error;
+
+	/* Re-acquire and write the sb and rtsb to disk. */
+	xfs_buf_lock(mp->m_sb_bp);
+	error = xfs_bwrite(mp->m_sb_bp);
+	xfs_buf_unlock(mp->m_sb_bp);
+	if (error)
+		return error;
+
+	if (update_rtsb && mp->m_rtsb_bp) {
+		xfs_buf_lock(mp->m_rtsb_bp);
+		error = xfs_bwrite(mp->m_rtsb_bp);
+		xfs_buf_unlock(mp->m_rtsb_bp);
+	}
+
 	return error;
 }
 
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index a26f79815533..9845a5fcf857 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -616,11 +616,10 @@ xfs_zoned_map_blocks(
 	xfs_iunlock(ip, XFS_ILOCK_EXCL);
 
 	wpc->iomap.type = IOMAP_MAPPED;
-	wpc->iomap.flags = IOMAP_F_DIRTY;
 	wpc->iomap.bdev = mp->m_rtdev_targp->bt_bdev;
 	wpc->iomap.offset = offset;
 	wpc->iomap.length = XFS_FSB_TO_B(mp, count_fsb);
-	wpc->iomap.flags = IOMAP_F_ANON_WRITE;
+	wpc->iomap.flags = IOMAP_F_ANON_WRITE | IOMAP_F_DIRTY;
 
 	trace_xfs_zoned_map_blocks(ip, offset, wpc->iomap.length);
 	return 0;
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index af68c7de8ee8..0921d288b590 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -1175,7 +1175,7 @@ xfs_getfsmap(
 		return -EINVAL;
 
 	use_rmap = xfs_has_rmapbt(mp) &&
-		   has_capability_noaudit(current, CAP_SYS_ADMIN);
+		   ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index a6bb7ee7a27a..7084311ace79 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -619,7 +619,7 @@ xfs_ioctl_setattr_get_trans(
 		goto out_error;
 
 	error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
-			has_capability_noaudit(current, CAP_FOWNER), &tp);
+			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
 	if (error)
 		goto out_error;
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index dcea927e0d3a..a1c88df45dd0 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1078,11 +1078,10 @@ xfs_zoned_direct_write_iomap_begin(
 	}
 
 	iomap->type = IOMAP_MAPPED;
-	iomap->flags = IOMAP_F_DIRTY;
 	iomap->bdev = ip->i_mount->m_rtdev_targp->bt_bdev;
 	iomap->offset = offset;
 	iomap->length = length;
-	iomap->flags = IOMAP_F_ANON_WRITE;
+	iomap->flags = IOMAP_F_ANON_WRITE | IOMAP_F_DIRTY;
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index caff0125faea..65d68347bf76 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -835,7 +835,7 @@ xfs_setattr_nonsize(
 	}
 
 	error = xfs_trans_alloc_ichange(ip, udqp, gdqp, NULL,
-			has_capability_noaudit(current, CAP_FOWNER), &tp);
+			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
 	if (error)
 		goto out_dqrele;
 
diff --git a/include/drm/drm_exec.h b/include/drm/drm_exec.h
index dee6ebdbe416..1962f8d2056d 100644
--- a/include/drm/drm_exec.h
+++ b/include/drm/drm_exec.h
@@ -67,13 +67,15 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
 
 /* Helper for drm_exec_for_each_locked_object(). Internal use only. */
 #define __drm_exec_for_each_locked_object(exec, obj, __index)		\
-	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); ++__index)
+	for (unsigned long __index = 0; ((obj) = drm_exec_obj(exec, __index)); \
+	     ++__index)
 /**
  * drm_exec_for_each_locked_object - iterate over all the locked objects
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container, except for the contended and implicit prelocked one.
  */
 #define drm_exec_for_each_locked_object(exec, obj)			\
 	__drm_exec_for_each_locked_object(exec, obj, __UNIQUE_ID(drm_exec))
@@ -88,12 +90,13 @@ drm_exec_obj(struct drm_exec *exec, unsigned long index)
  * @exec: drm_exec object
  * @obj: the current GEM object
  *
- * Iterate over all the locked GEM objects inside the drm_exec object in
- * reverse locking order. Note that the internal index may wrap around,
- * but that will be caught by drm_exec_obj(), returning a NULL object.
+ * Iterate over all the explicitly locked GEM objects inside the drm_exec
+ * container in reverse locking order. Note that the internal index may wrap
+ * around, but that will be caught by drm_exec_obj(), returning a NULL object.
  */
 #define drm_exec_for_each_locked_object_reverse(exec, obj)		\
-	__drm_exec_for_each_locked_object_reverse(exec, obj, __UNIQUE_ID(drm_exec))
+	__drm_exec_for_each_locked_object_reverse(exec, obj,		\
+						  __UNIQUE_ID(drm_exec))
 
 /**
  * drm_exec_until_all_locked - loop until all GEM objects are locked
diff --git a/include/linux/bsg-lib.h b/include/linux/bsg-lib.h
index 14fa93268630..a697246feeac 100644
--- a/include/linux/bsg-lib.h
+++ b/include/linux/bsg-lib.h
@@ -66,7 +66,8 @@ void bsg_job_done(struct bsg_job *job, int result,
 		  unsigned int reply_payload_rcv_len);
 struct request_queue *bsg_setup_queue(struct device *dev, const char *name,
 		struct queue_limits *lim, bsg_job_fn *job_fn,
-		bsg_timeout_fn *timeout, int dd_job_size);
+		bsg_timeout_fn *timeout, int dd_job_size,
+		unsigned int reply_len);
 void bsg_remove_queue(struct request_queue *q);
 void bsg_job_put(struct bsg_job *job);
 int __must_check bsg_job_get(struct bsg_job *job);
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index b760a3c470a5..23b6bb0d3077 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -518,7 +518,10 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
-	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	/*
+	 * Sequence number for cgroup.kill. Incremented with both cgroup_mutex
+	 * and css_set_lock held. Readers hold either one.
+	 */
 	unsigned int kill_seq;
 
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 4affacb909ae..d67a893d75fa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -546,6 +546,7 @@ struct fsnotify_mark_connector {
 	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_DESTROYING	0x04
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
diff --git a/include/linux/futex.h b/include/linux/futex.h
index e93f2be22779..01febbc9ef1e 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,28 +23,32 @@ struct task_struct;
  *  01 : Shared futex (PTHREAD_PROCESS_SHARED)
  *	mapped on a file (reference on the underlying inode)
  *  10 : Shared futex (PTHREAD_PROCESS_SHARED)
- *       (but private mapping on an mm, and reference taken on it)
+ *       (but private mapping on an mm)
 */
 
-#define FUT_OFF_INODE    1 /* We set bit 0 if key has a reference on inode */
-#define FUT_OFF_MMSHARED 2 /* We set bit 1 if key has a reference on mm */
+#define FUT_OFF_INODE    1 /* We set bit 0 if shared key identifies an inode */
+#define FUT_OFF_MMSHARED 2 /* We set bit 1 if shared key identifies an mm */
 
 union futex_key {
+	/* For FUT_OFF_INODE */
 	struct {
 		u64 i_seq;
 		unsigned long pgoff;
 		unsigned int offset;
 		/* unsigned int node; */
 	} shared;
+
+	/* For FUT_OFF_MMSHARED or private */
 	struct {
 		union {
-			struct mm_struct *mm;
-			u64 __tmp;
+			struct mm_struct *mm; /* for private */
+			u64 mm_seq; /* for FUT_OFF_MMSHARED */
 		};
 		unsigned long address;
 		unsigned int offset;
 		/* unsigned int node; */
 	} private;
+
 	struct {
 		u64 ptr;
 		unsigned long word;
@@ -83,15 +87,15 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4);
 
+int futex_mm_init(struct mm_struct *mm);
+
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 int futex_hash_allocate_default(void);
 void futex_hash_free(struct mm_struct *mm);
-int futex_mm_init(struct mm_struct *mm);
 
 #else /* !CONFIG_FUTEX_PRIVATE_HASH */
 static inline int futex_hash_allocate_default(void) { return 0; }
 static inline int futex_hash_free(struct mm_struct *mm) { return 0; }
-static inline int futex_mm_init(struct mm_struct *mm) { return 0; }
 #endif /* CONFIG_FUTEX_PRIVATE_HASH */
 
 #else /* !CONFIG_FUTEX */
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index 7294e4e89b79..c5541096a286 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -126,6 +126,28 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
 	       skb_network_header_len(skb);
 }
 
+static inline unsigned int
+ipv6_payload_len(const struct sk_buff *skb, const struct ipv6hdr *ip6)
+{
+	u32 len = ntohs(ip6->payload_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+		len :
+		skb->len - skb_network_offset(skb) - sizeof(struct ipv6hdr);
+}
+
+static inline unsigned int skb_ipv6_payload_len(const struct sk_buff *skb)
+{
+	return ipv6_payload_len(skb, ipv6_hdr(skb));
+}
+
+#define IPV6_MAXPLEN		65535
+
+static inline void ipv6_set_payload_len(struct ipv6hdr *ip6, unsigned int len)
+{
+	ip6->payload_len = len <= IPV6_MAXPLEN ? htons(len) : 0;
+}
+
 /* 
    This structure contains results of exthdrs parsing
    as offsets from skb->nh.
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index 2ba53c065467..983a57400563 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -470,9 +470,13 @@ struct ma_wr_state {
 };
 
 #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
+#define mas_lock_irqsave(mas, flags) \
+		spin_lock_irqsave(&((mas)->tree->ma_lock), flags)
 #define mas_lock_nested(mas, subclass) \
 		spin_lock_nested(&((mas)->tree->ma_lock), subclass)
 #define mas_unlock(mas)         spin_unlock(&((mas)->tree->ma_lock))
+#define mas_unlock_irqrestore(mas, flags) \
+		spin_unlock_irqrestore(&((mas)->tree->ma_lock), flags)
 
 /*
  * Special values for ma_state.node.
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index f9c552744b71..08495d38572f 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1079,6 +1079,9 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
+#ifdef CONFIG_FUTEX
+		atomic64_t			futex_unique_id;
+#endif
 #ifdef CONFIG_FUTEX_PRIVATE_HASH
 		struct mutex			futex_hash_lock;
 		struct futex_private_hash	__rcu *futex_phash;
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 360ffdf272da..8f9e4d084305 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -335,6 +335,16 @@ struct power_supply {
 	bool removing;
 	atomic_t use_cnt;
 	struct power_supply_battery_info *battery_info;
+	/*
+	 * Held for read while ->external_power_changed() runs, and for write by
+	 * power_supply_unregister() when it publishes @removing, so that it
+	 * waits for an in-flight callback to finish. Without this a driver's
+	 * data, typically devm-allocated on its own device, can be freed while
+	 * the callback is still using it.
+	 * Must not be shared with extensions_sem: callbacks may read their own
+	 * properties, which takes that one for read.
+	 */
+	struct rw_semaphore epc_sem;
 	struct rw_semaphore extensions_sem; /* protects "extensions" */
 	struct list_head extensions;
 #ifdef CONFIG_THERMAL
@@ -397,9 +407,9 @@ struct power_supply_vbat_ri_table {
  * @charge_voltage_max_uv: maintenance charging voltage that is usually a bit
  *   lower than the constant_charge_voltage_max_uv. We can apply this settings
  *   charge_current_max_ua until we get back up to this voltage.
- * @safety_timer_minutes: maintenance charging safety timer, with an expiry
- *   time in minutes. We will only use maintenance charging in this setting
- *   for a certain amount of time, then we will first move to the next
+ * @charge_safety_timer_minutes: maintenance charging safety timer, with an
+ *   expiry time in minutes. We will only use maintenance charging in this
+ *   setting for a certain amount of time, then we will first move to the next
  *   maintenance charge current and voltage pair in respective array and wait
  *   for the next safety timer timeout, or, if we reached the last maintencance
  *   charging setting, disable charging until we reach
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 8d7e5521f7cd..ec262b605437 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -23,11 +23,13 @@ struct user_struct {
 	struct hlist_node uidhash_node;
 	kuid_t uid;
 
-#if defined(CONFIG_PERF_EVENTS) || defined(CONFIG_BPF_SYSCALL) || \
-	defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
+#if defined(CONFIG_NET) || defined(CONFIG_IO_URING) || \
 	defined(CONFIG_VFIO_PCI_ZDEV_KVM) || IS_ENABLED(CONFIG_IOMMUFD) || \
 	defined(CONFIG_SECRETMEM)
-	atomic_long_t locked_vm;
+	atomic_long_t locked_vm;	/* pinned pages charged to RLIMIT_MEMLOCK */
+#endif
+#ifdef CONFIG_PERF_EVENTS
+	atomic_long_t perf_mlock;	/* perf buffer pages within perf_event_mlock_kb */
 #endif
 #ifdef CONFIG_WATCH_QUEUE
 	atomic_t nr_watches;	/* The number of watches this user currently has */
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 5e6b212a2aed..609e8f5da415 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -53,6 +53,7 @@ struct unicode_map {
 	unsigned int version;
 	const struct utf8data *ntab[UTF8_NMAX];
 	const struct utf8data_table *tables;
+	struct rcu_head rcu;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index d40e978126e3..bb3af3e97e0f 100644
--- a/include/net/af_vsock.h
+++ b/include/net/af_vsock.h
@@ -216,6 +216,9 @@ void vsock_remove_connected(struct vsock_sock *vsk);
 struct sock *vsock_find_bound_socket(struct sockaddr_vm *addr);
 struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 					 struct sockaddr_vm *dst);
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src);
 void vsock_remove_sock(struct vsock_sock *vsk);
 void vsock_for_each_connected_socket(struct vsock_transport *transport,
 				     void (*fn)(struct sock *sk));
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index cd798f3569cb..b03467b337f4 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -25,8 +25,6 @@ struct ip_tunnel_info;
 
 #define SIN6_LEN_RFC2133	24
 
-#define IPV6_MAXPLEN		65535
-
 /*
  *	NextHeader field of IPv6 header
  */
diff --git a/include/net/netfilter/nf_tables_ipv6.h b/include/net/netfilter/nf_tables_ipv6.h
index a0633eeaec97..c53ac00bb974 100644
--- a/include/net/netfilter/nf_tables_ipv6.h
+++ b/include/net/netfilter/nf_tables_ipv6.h
@@ -42,7 +42,7 @@ static inline int __nft_set_pktinfo_ipv6_validate(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		return -1;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	skb_len = pkt->skb->len - skb_network_offset(pkt->skb);
 	if (pkt_len + sizeof(*ip6h) > skb_len)
 		return -1;
@@ -86,7 +86,7 @@ static inline int nft_set_pktinfo_ipv6_ingress(struct nft_pktinfo *pkt)
 	if (ip6h->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(ip6h->payload_len);
+	pkt_len = ipv6_payload_len(pkt->skb, ip6h);
 	if (pkt_len + sizeof(*ip6h) > pkt->skb->len) {
 		idev = __in6_dev_get(nft_in(pkt));
 		__IP6_INC_STATS(nft_net(pkt), idev, IPSTATS_MIB_INTRUNCATEDPKTS);
diff --git a/include/net/rose.h b/include/net/rose.h
index 0d957b8dd0ba..49140668b3dd 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -180,6 +180,18 @@ static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 		 */
 		timer_shutdown_sync(&rose_neigh->ftimer);
 		timer_shutdown_sync(&rose_neigh->t0timer);
+		/* rose_transmit_link() queues a frame here instead of sending
+		 * it immediately whenever the neighbour isn't "restarted" yet
+		 * (link not up) -- e.g. the CLEAR_REQUEST built by
+		 * rose_write_internal() when a socket is released while its
+		 * underlying AX.25 link is still coming up. If this neighbour
+		 * is freed before that link ever comes up, nothing else ever
+		 * empties this queue: kfree() below only frees the
+		 * rose_neigh struct itself (including the three next/prev/len
+		 * words of the sk_buff_head), not the skbs it points to,
+		 * leaking every frame still queued here.
+		 */
+		skb_queue_purge(&rose_neigh->queue);
 		if (rose_neigh->ax25)
 			ax25_cb_put(rose_neigh->ax25);
 		kfree(rose_neigh->digipeat);
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index 64b51e82baa2..299071d28441 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -14,6 +14,8 @@
 #include "filetable.h"
 #include "io_uring.h"
 #include "tctx.h"
+#include "sqpoll.h"
+#include "uring_cmd.h"
 #include "poll.h"
 #include "timeout.h"
 #include "waitid.h"
@@ -384,3 +386,270 @@ int io_cancel_remove(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 	io_ring_submit_unlock(ctx, issue_flags);
 	return nr ?: -ENOENT;
 }
+
+static bool io_match_linked(struct io_kiocb *head)
+{
+	struct io_kiocb *req;
+
+	io_for_each_link(req, head) {
+		if (req->flags & REQ_F_INFLIGHT)
+			return true;
+	}
+	return false;
+}
+
+/*
+ * As io_match_task() but protected against racing with linked timeouts.
+ * User must not hold timeout_lock.
+ */
+bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
+			bool cancel_all)
+{
+	bool matched;
+
+	if (tctx && head->tctx != tctx)
+		return false;
+	if (cancel_all)
+		return true;
+
+	if (head->flags & REQ_F_LINK_TIMEOUT) {
+		struct io_ring_ctx *ctx = head->ctx;
+
+		/* protect against races with linked timeouts */
+		raw_spin_lock_irq(&ctx->timeout_lock);
+		matched = io_match_linked(head);
+		raw_spin_unlock_irq(&ctx->timeout_lock);
+	} else {
+		matched = io_match_linked(head);
+	}
+	return matched;
+}
+
+void __io_uring_cancel(bool cancel_all)
+{
+	io_uring_unreg_ringfd();
+	io_uring_cancel_generic(cancel_all, NULL);
+}
+
+struct io_task_cancel {
+	struct io_uring_task *tctx;
+	bool all;
+};
+
+static bool io_cancel_task_cb(struct io_wq_work *work, void *data)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+	struct io_task_cancel *cancel = data;
+
+	return io_match_task_safe(req, cancel->tctx, cancel->all);
+}
+
+static __cold bool io_cancel_defer_files(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all)
+{
+	struct io_defer_entry *de;
+	LIST_HEAD(list);
+
+	list_for_each_entry_reverse(de, &ctx->defer_list, list) {
+		if (io_match_task_safe(de->req, tctx, cancel_all)) {
+			list_cut_position(&list, &ctx->defer_list, &de->list);
+			break;
+		}
+	}
+	if (list_empty(&list))
+		return false;
+
+	while (!list_empty(&list)) {
+		de = list_first_entry(&list, struct io_defer_entry, list);
+		list_del_init(&de->list);
+		ctx->nr_drained -= io_linked_nr(de->req);
+		io_req_task_queue_fail(de->req, -ECANCELED);
+		kfree(de);
+	}
+	return true;
+}
+
+__cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data)
+{
+	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
+
+	return req->ctx == data;
+}
+
+static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
+{
+	struct io_tctx_node *node;
+	enum io_wq_cancel cret;
+	bool ret = false;
+
+	mutex_lock(&ctx->uring_lock);
+	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
+		struct io_uring_task *tctx = node->task->io_uring;
+
+		/*
+		 * io_wq will stay alive while we hold uring_lock, because it's
+		 * killed after ctx nodes, which requires to take the lock.
+		 */
+		if (!tctx || !tctx->io_wq)
+			continue;
+		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_ctx_cb, ctx, true);
+		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
+	}
+	mutex_unlock(&ctx->uring_lock);
+
+	return ret;
+}
+
+__cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all, bool is_sqpoll_thread)
+{
+	struct io_task_cancel cancel = { .tctx = tctx, .all = cancel_all, };
+	enum io_wq_cancel cret;
+	bool ret = false;
+
+	/* set it so io_req_local_work_add() would wake us up */
+	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
+		atomic_set(&ctx->cq_wait_nr, 1);
+		smp_mb();
+	}
+
+	/* failed during ring init, it couldn't have issued any requests */
+	if (!ctx->rings)
+		return false;
+
+	if (!tctx) {
+		ret |= io_uring_try_cancel_iowq(ctx);
+	} else if (tctx->io_wq) {
+		/*
+		 * Cancels requests of all rings, not only @ctx, but
+		 * it's fine as the task is in exit/exec.
+		 */
+		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_task_cb,
+				       &cancel, true);
+		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
+	}
+
+	/* SQPOLL thread does its own polling */
+	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
+	    is_sqpoll_thread) {
+		while (!wq_list_empty(&ctx->iopoll_list)) {
+			io_iopoll_try_reap_events(ctx);
+			ret = true;
+			cond_resched();
+		}
+	}
+
+	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
+	    io_allowed_defer_tw_run(ctx))
+		ret |= io_run_local_work(ctx, INT_MAX, INT_MAX) > 0;
+	mutex_lock(&ctx->uring_lock);
+	ret |= io_cancel_defer_files(ctx, tctx, cancel_all);
+	ret |= io_poll_remove_all(ctx, tctx, cancel_all);
+	ret |= io_waitid_remove_all(ctx, tctx, cancel_all);
+	ret |= io_futex_remove_all(ctx, tctx, cancel_all);
+	ret |= io_uring_try_cancel_uring_cmd(ctx, tctx, cancel_all);
+	mutex_unlock(&ctx->uring_lock);
+	ret |= io_kill_timeouts(ctx, tctx, cancel_all);
+	if (tctx)
+		ret |= io_run_task_work() > 0;
+	else
+		ret |= flush_delayed_work(&ctx->fallback_work);
+	return ret;
+}
+
+static s64 tctx_inflight(struct io_uring_task *tctx, bool tracked)
+{
+	if (tracked)
+		return atomic_read(&tctx->inflight_tracked);
+	return percpu_counter_sum(&tctx->inflight);
+}
+
+/*
+ * Find any io_uring ctx that this task has registered or done IO on, and cancel
+ * requests. @sqd should be not-null IFF it's an SQPOLL thread cancellation.
+ */
+__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
+{
+	struct io_uring_task *tctx = current->io_uring;
+	struct io_ring_ctx *ctx;
+	struct io_tctx_node *node;
+	unsigned long index;
+	s64 inflight;
+	DEFINE_WAIT(wait);
+
+	WARN_ON_ONCE(sqd && sqpoll_task_locked(sqd) != current);
+
+	if (!current->io_uring)
+		return;
+	if (tctx->io_wq)
+		io_wq_exit_start(tctx->io_wq);
+
+	atomic_inc(&tctx->in_cancel);
+	do {
+		bool loop = false;
+
+		io_uring_drop_tctx_refs(current);
+		if (!tctx_inflight(tctx, !cancel_all))
+			break;
+
+		/* read completions before cancelations */
+		inflight = tctx_inflight(tctx, false);
+		if (!inflight)
+			break;
+
+		if (!sqd) {
+			xa_for_each(&tctx->xa, index, node) {
+				/* sqpoll task will cancel all its requests */
+				if (node->ctx->sq_data)
+					continue;
+				loop |= io_uring_try_cancel_requests(node->ctx,
+							current->io_uring,
+							cancel_all,
+							false);
+			}
+		} else {
+			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
+				loop |= io_uring_try_cancel_requests(ctx,
+								     current->io_uring,
+								     cancel_all,
+								     true);
+		}
+
+		if (loop) {
+			cond_resched();
+			continue;
+		}
+
+		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
+		io_run_task_work();
+		io_uring_drop_tctx_refs(current);
+		/* only skip the sleep for local work this task may run */
+		xa_for_each(&tctx->xa, index, node) {
+			if (io_local_work_pending(node->ctx) &&
+			    io_allowed_defer_tw_run(node->ctx))
+				goto end_wait;
+		}
+		/*
+		 * If we've seen completions, retry without waiting. This
+		 * avoids a race where a completion comes in before we did
+		 * prepare_to_wait().
+		 */
+		if (inflight == tctx_inflight(tctx, !cancel_all))
+			schedule();
+end_wait:
+		finish_wait(&tctx->wait, &wait);
+	} while (1);
+
+	io_uring_clean_tctx(tctx);
+	if (cancel_all) {
+		/*
+		 * We shouldn't run task_works after cancel, so just leave
+		 * ->in_cancel set for normal exit.
+		 */
+		atomic_dec(&tctx->in_cancel);
+		/* for exec all current's requests should be gone, kill tctx */
+		__io_uring_free(current);
+	}
+}
diff --git a/io_uring/cancel.h b/io_uring/cancel.h
index eaa4069e258c..1b201a094303 100644
--- a/io_uring/cancel.h
+++ b/io_uring/cancel.h
@@ -21,14 +21,20 @@ int io_try_cancel(struct io_uring_task *tctx, struct io_cancel_data *cd,
 
 int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg);
 bool io_cancel_req_match(struct io_kiocb *req, struct io_cancel_data *cd);
+bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
+			bool cancel_all);
 
 bool io_cancel_remove_all(struct io_ring_ctx *ctx, struct io_uring_task *tctx,
 			  struct hlist_head *list, bool cancel_all,
 			  bool (*cancel)(struct io_kiocb *));
-
 int io_cancel_remove(struct io_ring_ctx *ctx, struct io_cancel_data *cd,
 		     unsigned int issue_flags, struct hlist_head *list,
 		     bool (*cancel)(struct io_kiocb *));
+__cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
+					 struct io_uring_task *tctx,
+					 bool cancel_all, bool is_sqpoll_thread);
+__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd);
+__cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data);
 
 static inline bool io_cancel_match_sequence(struct io_kiocb *req, int sequence)
 {
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index ad5e203e0d5f..668662b74d73 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -124,11 +124,6 @@
 #define IO_REQ_ALLOC_BATCH		8
 #define IO_LOCAL_TW_DEFAULT_MAX		20
 
-struct io_defer_entry {
-	struct list_head	list;
-	struct io_kiocb		*req;
-};
-
 /* requests with any of those set should undergo io_disarm_next() */
 #define IO_DISARM_MASK (REQ_F_ARM_LTIMEOUT | REQ_F_LINK_TIMEOUT | REQ_F_FAIL)
 
@@ -140,11 +135,6 @@ struct io_defer_entry {
 /* Forced wake up if there is a waiter regardless of ->cq_wait_nr */
 #define IO_CQ_WAKE_FORCE	(IO_CQ_WAKE_INIT >> 1)
 
-static bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
-					 struct io_uring_task *tctx,
-					 bool cancel_all,
-					 bool is_sqpoll_thread);
-
 static void io_queue_sqe(struct io_kiocb *req, unsigned int extra_flags);
 static void __io_req_caches_free(struct io_ring_ctx *ctx);
 
@@ -210,44 +200,6 @@ static inline unsigned int __io_cqring_events_user(struct io_ring_ctx *ctx)
 	return READ_ONCE(rings->cq.tail) - READ_ONCE(rings->cq.head);
 }
 
-static bool io_match_linked(struct io_kiocb *head)
-{
-	struct io_kiocb *req;
-
-	io_for_each_link(req, head) {
-		if (req->flags & REQ_F_INFLIGHT)
-			return true;
-	}
-	return false;
-}
-
-/*
- * As io_match_task() but protected against racing with linked timeouts.
- * User must not hold timeout_lock.
- */
-bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
-			bool cancel_all)
-{
-	bool matched;
-
-	if (tctx && head->tctx != tctx)
-		return false;
-	if (cancel_all)
-		return true;
-
-	if (head->flags & REQ_F_LINK_TIMEOUT) {
-		struct io_ring_ctx *ctx = head->ctx;
-
-		/* protect against races with linked timeouts */
-		raw_spin_lock_irq(&ctx->timeout_lock);
-		matched = io_match_linked(head);
-		raw_spin_unlock_irq(&ctx->timeout_lock);
-	} else {
-		matched = io_match_linked(head);
-	}
-	return matched;
-}
-
 static inline void req_fail_link_node(struct io_kiocb *req, int res)
 {
 	req_set_fail(req);
@@ -553,7 +505,7 @@ void io_req_queue_iowq(struct io_kiocb *req)
 	io_req_task_work_add(req);
 }
 
-static unsigned io_linked_nr(struct io_kiocb *req)
+unsigned io_linked_nr(struct io_kiocb *req)
 {
 	struct io_kiocb *tmp;
 	unsigned nr = 0;
@@ -724,7 +676,7 @@ void io_task_refs_refill(struct io_uring_task *tctx)
 	tctx->cached_refs += refill;
 }
 
-static __cold void io_uring_drop_tctx_refs(struct task_struct *task)
+__cold void io_uring_drop_tctx_refs(struct task_struct *task)
 {
 	struct io_uring_task *tctx = task->io_uring;
 	unsigned int refs = tctx->cached_refs;
@@ -1483,8 +1435,7 @@ static inline int io_run_local_work_locked(struct io_ring_ctx *ctx,
 					max(IO_LOCAL_TW_DEFAULT_MAX, min_events));
 }
 
-static int io_run_local_work(struct io_ring_ctx *ctx, int min_events,
-			     int max_events)
+int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events)
 {
 	struct io_tw_state ts = {};
 	int ret;
@@ -1638,7 +1589,7 @@ static unsigned io_cqring_events(struct io_ring_ctx *ctx)
  * We can't just wait for polled events to come to us, we have to actively
  * find and complete them.
  */
-static __cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
+__cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx)
 {
 	if (!(ctx->flags & IORING_SETUP_IOPOLL))
 		return;
@@ -3049,13 +3000,6 @@ static __cold void io_tctx_exit_cb(struct callback_head *cb)
 	complete(&work->completion);
 }
 
-static __cold bool io_cancel_ctx_cb(struct io_wq_work *work, void *data)
-{
-	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-
-	return req->ctx == data;
-}
-
 static __cold void io_ring_exit_work(struct work_struct *work)
 {
 	struct io_ring_ctx *ctx = container_of(work, struct io_ring_ctx, exit_work);
@@ -3189,230 +3133,6 @@ static int io_uring_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-struct io_task_cancel {
-	struct io_uring_task *tctx;
-	bool all;
-};
-
-static bool io_cancel_task_cb(struct io_wq_work *work, void *data)
-{
-	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
-	struct io_task_cancel *cancel = data;
-
-	return io_match_task_safe(req, cancel->tctx, cancel->all);
-}
-
-static __cold bool io_cancel_defer_files(struct io_ring_ctx *ctx,
-					 struct io_uring_task *tctx,
-					 bool cancel_all)
-{
-	struct io_defer_entry *de;
-	LIST_HEAD(list);
-
-	list_for_each_entry_reverse(de, &ctx->defer_list, list) {
-		if (io_match_task_safe(de->req, tctx, cancel_all)) {
-			list_cut_position(&list, &ctx->defer_list, &de->list);
-			break;
-		}
-	}
-	if (list_empty(&list))
-		return false;
-
-	while (!list_empty(&list)) {
-		de = list_first_entry(&list, struct io_defer_entry, list);
-		list_del_init(&de->list);
-		ctx->nr_drained -= io_linked_nr(de->req);
-		io_req_task_queue_fail(de->req, -ECANCELED);
-		kfree(de);
-	}
-	return true;
-}
-
-static __cold bool io_uring_try_cancel_iowq(struct io_ring_ctx *ctx)
-{
-	struct io_tctx_node *node;
-	enum io_wq_cancel cret;
-	bool ret = false;
-
-	mutex_lock(&ctx->uring_lock);
-	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
-		struct io_uring_task *tctx = node->task->io_uring;
-
-		/*
-		 * io_wq will stay alive while we hold uring_lock, because it's
-		 * killed after ctx nodes, which requires to take the lock.
-		 */
-		if (!tctx || !tctx->io_wq)
-			continue;
-		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_ctx_cb, ctx, true);
-		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
-	}
-	mutex_unlock(&ctx->uring_lock);
-
-	return ret;
-}
-
-static __cold bool io_uring_try_cancel_requests(struct io_ring_ctx *ctx,
-						struct io_uring_task *tctx,
-						bool cancel_all,
-						bool is_sqpoll_thread)
-{
-	struct io_task_cancel cancel = { .tctx = tctx, .all = cancel_all, };
-	enum io_wq_cancel cret;
-	bool ret = false;
-
-	/* set it so io_req_local_work_add() would wake us up */
-	if (ctx->flags & IORING_SETUP_DEFER_TASKRUN) {
-		atomic_set(&ctx->cq_wait_nr, 1);
-		smp_mb();
-	}
-
-	/* failed during ring init, it couldn't have issued any requests */
-	if (!ctx->rings)
-		return false;
-
-	if (!tctx) {
-		ret |= io_uring_try_cancel_iowq(ctx);
-	} else if (tctx->io_wq) {
-		/*
-		 * Cancels requests of all rings, not only @ctx, but
-		 * it's fine as the task is in exit/exec.
-		 */
-		cret = io_wq_cancel_cb(tctx->io_wq, io_cancel_task_cb,
-				       &cancel, true);
-		ret |= (cret != IO_WQ_CANCEL_NOTFOUND);
-	}
-
-	/* SQPOLL thread does its own polling */
-	if ((!(ctx->flags & IORING_SETUP_SQPOLL) && cancel_all) ||
-	    is_sqpoll_thread) {
-		while (!wq_list_empty(&ctx->iopoll_list)) {
-			io_iopoll_try_reap_events(ctx);
-			ret = true;
-			cond_resched();
-		}
-	}
-
-	if ((ctx->flags & IORING_SETUP_DEFER_TASKRUN) &&
-	    io_allowed_defer_tw_run(ctx))
-		ret |= io_run_local_work(ctx, INT_MAX, INT_MAX) > 0;
-	mutex_lock(&ctx->uring_lock);
-	ret |= io_cancel_defer_files(ctx, tctx, cancel_all);
-	ret |= io_poll_remove_all(ctx, tctx, cancel_all);
-	ret |= io_waitid_remove_all(ctx, tctx, cancel_all);
-	ret |= io_futex_remove_all(ctx, tctx, cancel_all);
-	ret |= io_uring_try_cancel_uring_cmd(ctx, tctx, cancel_all);
-	mutex_unlock(&ctx->uring_lock);
-	ret |= io_kill_timeouts(ctx, tctx, cancel_all);
-	if (tctx)
-		ret |= io_run_task_work() > 0;
-	else
-		ret |= flush_delayed_work(&ctx->fallback_work);
-	return ret;
-}
-
-static s64 tctx_inflight(struct io_uring_task *tctx, bool tracked)
-{
-	if (tracked)
-		return atomic_read(&tctx->inflight_tracked);
-	return percpu_counter_sum(&tctx->inflight);
-}
-
-/*
- * Find any io_uring ctx that this task has registered or done IO on, and cancel
- * requests. @sqd should be not-null IFF it's an SQPOLL thread cancellation.
- */
-__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
-{
-	struct io_uring_task *tctx = current->io_uring;
-	struct io_ring_ctx *ctx;
-	struct io_tctx_node *node;
-	unsigned long index;
-	s64 inflight;
-	DEFINE_WAIT(wait);
-
-	WARN_ON_ONCE(sqd && sqpoll_task_locked(sqd) != current);
-
-	if (!current->io_uring)
-		return;
-	if (tctx->io_wq)
-		io_wq_exit_start(tctx->io_wq);
-
-	atomic_inc(&tctx->in_cancel);
-	do {
-		bool loop = false;
-
-		io_uring_drop_tctx_refs(current);
-		if (!tctx_inflight(tctx, !cancel_all))
-			break;
-
-		/* read completions before cancelations */
-		inflight = tctx_inflight(tctx, false);
-		if (!inflight)
-			break;
-
-		if (!sqd) {
-			xa_for_each(&tctx->xa, index, node) {
-				/* sqpoll task will cancel all its requests */
-				if (node->ctx->sq_data)
-					continue;
-				loop |= io_uring_try_cancel_requests(node->ctx,
-							current->io_uring,
-							cancel_all,
-							false);
-			}
-		} else {
-			list_for_each_entry(ctx, &sqd->ctx_list, sqd_list)
-				loop |= io_uring_try_cancel_requests(ctx,
-								     current->io_uring,
-								     cancel_all,
-								     true);
-		}
-
-		if (loop) {
-			cond_resched();
-			continue;
-		}
-
-		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
-		io_run_task_work();
-		io_uring_drop_tctx_refs(current);
-		xa_for_each(&tctx->xa, index, node) {
-			if (io_local_work_pending(node->ctx)) {
-				WARN_ON_ONCE(node->ctx->submitter_task &&
-					     node->ctx->submitter_task != current);
-				goto end_wait;
-			}
-		}
-		/*
-		 * If we've seen completions, retry without waiting. This
-		 * avoids a race where a completion comes in before we did
-		 * prepare_to_wait().
-		 */
-		if (inflight == tctx_inflight(tctx, !cancel_all))
-			schedule();
-end_wait:
-		finish_wait(&tctx->wait, &wait);
-	} while (1);
-
-	io_uring_clean_tctx(tctx);
-	if (cancel_all) {
-		/*
-		 * We shouldn't run task_works after cancel, so just leave
-		 * ->in_cancel set for normal exit.
-		 */
-		atomic_dec(&tctx->in_cancel);
-		/* for exec all current's requests should be gone, kill tctx */
-		__io_uring_free(current);
-	}
-}
-
-void __io_uring_cancel(bool cancel_all)
-{
-	io_uring_unreg_ringfd();
-	io_uring_cancel_generic(cancel_all, NULL);
-}
-
 static struct io_uring_reg_wait *io_get_ext_arg_reg(struct io_ring_ctx *ctx,
 			const struct io_uring_getevents_arg __user *uarg)
 {
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index 042bdd766571..36918faff5af 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -95,6 +95,11 @@ enum {
 	IOU_REQUEUE		= -3072,
 };
 
+struct io_defer_entry {
+	struct list_head	list;
+	struct io_kiocb		*req;
+};
+
 struct io_wait_queue {
 	struct wait_queue_entry wq;
 	struct io_ring_ctx *ctx;
@@ -145,6 +150,7 @@ unsigned long rings_size(unsigned int flags, unsigned int sq_entries,
 int io_uring_fill_params(unsigned entries, struct io_uring_params *p);
 bool io_cqe_cache_refill(struct io_ring_ctx *ctx, bool overflow, bool cqe32);
 int io_run_task_work_sig(struct io_ring_ctx *ctx);
+int io_run_local_work(struct io_ring_ctx *ctx, int min_events, int max_events);
 void io_req_defer_failed(struct io_kiocb *req, s32 res);
 bool io_post_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
 void io_add_aux_cqe(struct io_ring_ctx *ctx, u64 user_data, s32 res, u32 cflags);
@@ -152,6 +158,7 @@ bool io_req_post_cqe(struct io_kiocb *req, s32 res, u32 cflags);
 bool io_req_post_cqe32(struct io_kiocb *req, struct io_uring_cqe src_cqe[2]);
 void __io_commit_cqring_flush(struct io_ring_ctx *ctx);
 
+unsigned io_linked_nr(struct io_kiocb *req);
 void io_req_track_inflight(struct io_kiocb *req);
 struct file *io_file_get_normal(struct io_kiocb *req, int fd);
 struct file *io_file_get_fixed(struct io_kiocb *req, int fd,
@@ -166,7 +173,7 @@ void io_req_task_submit(struct io_tw_req tw_req, io_tw_token_t tw);
 struct llist_node *io_handle_tw_list(struct llist_node *node, unsigned int *count, unsigned int max_entries);
 struct llist_node *tctx_task_work_run(struct io_uring_task *tctx, unsigned int max_entries, unsigned int *count);
 void tctx_task_work(struct callback_head *cb);
-__cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd);
+__cold void io_uring_drop_tctx_refs(struct task_struct *task);
 
 int io_ring_add_registered_file(struct io_uring_task *tctx, struct file *file,
 				     int start, int end);
@@ -175,6 +182,7 @@ void io_req_queue_iowq(struct io_kiocb *req);
 int io_poll_issue(struct io_kiocb *req, io_tw_token_t tw);
 int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr);
 int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
+__cold void io_iopoll_try_reap_events(struct io_ring_ctx *ctx);
 void __io_submit_flush_completions(struct io_ring_ctx *ctx);
 
 struct io_wq_work *io_wq_free_work(struct io_wq_work *work);
@@ -185,9 +193,6 @@ void io_queue_next(struct io_kiocb *req);
 void io_task_refs_refill(struct io_uring_task *tctx);
 bool __io_alloc_req_refill(struct io_ring_ctx *ctx);
 
-bool io_match_task_safe(struct io_kiocb *head, struct io_uring_task *tctx,
-			bool cancel_all);
-
 void io_activate_pollwq(struct io_ring_ctx *ctx);
 
 static inline void io_lockdep_assert_cq_locked(struct io_ring_ctx *ctx)
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index e22f072c7d5f..74c1a130cd87 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -19,6 +19,7 @@
 #include "io_uring.h"
 #include "tctx.h"
 #include "napi.h"
+#include "cancel.h"
 #include "sqpoll.h"
 
 #define IORING_SQPOLL_CAP_ENTRIES_VALUE 8
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 5ae4c27e3b3d..275c335c02a7 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6734,10 +6734,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	spin_lock_irq(&css_set_lock);
 	cset = task_css_set(current);
 	get_css_set(cset);
-	if (kargs->cgrp)
-		kargs->kill_seq = kargs->cgrp->kill_seq;
-	else
-		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
+	kargs->kill_seq = cset->dfl_cgrp->kill_seq;
 	spin_unlock_irq(&css_set_lock);
 
 	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
@@ -6801,6 +6798,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 
 	put_css_set(cset);
 	kargs->cgrp = dst_cgrp;
+	kargs->kill_seq = dst_cgrp->kill_seq;
 	return ret;
 
 err:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 018a1e4ef5b0..9007f2b36c44 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4496,6 +4496,7 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 
 	if (cpu_event) {
 		update_context_time(&cpuctx->ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
@@ -6779,7 +6780,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_mlock);
 		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
@@ -6961,11 +6962,11 @@ static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra,
 	/* Increase the limit linearly with more CPUs */
 	user_lock_limit *= num_online_cpus();
 
-	user_locked = atomic_long_read(&user->locked_vm);
+	user_locked = atomic_long_read(&user->perf_mlock);
 
 	/*
 	 * sysctl_perf_event_mlock may have changed, so that
-	 *     user->locked_vm > user_lock_limit
+	 *     user->perf_mlock > user_lock_limit
 	 */
 	if (user_locked > user_lock_limit)
 		user_locked = user_lock_limit;
@@ -6973,7 +6974,7 @@ static bool perf_mmap_calc_limits(struct vm_area_struct *vma, long *user_extra,
 
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
+		 * charge perf_mlock until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
 		 */
 		*extra = user_locked - user_lock_limit;
@@ -6991,7 +6992,7 @@ static void perf_mmap_account(struct vm_area_struct *vma, long user_extra, long
 {
 	struct user_struct *user = current_user();
 
-	atomic_long_add(user_extra, &user->locked_vm);
+	atomic_long_add(user_extra, &user->perf_mlock);
 	atomic64_add(extra, &vma->vm_mm->pinned_vm);
 }
 
@@ -7000,7 +7001,7 @@ static void perf_mmap_unaccount(struct vm_area_struct *vma, struct perf_buffer *
 	struct user_struct *user = rb->mmap_user;
 
 	atomic_long_sub((perf_data_size(rb) >> PAGE_SHIFT) + 1 - rb->mmap_locked,
-			&user->locked_vm);
+			&user->perf_mlock);
 	atomic64_sub(rb->mmap_locked, &vma->vm_mm->pinned_vm);
 }
 
@@ -13978,23 +13979,18 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 }
 EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);
 
-static void __perf_pmu_remove(struct perf_event_context *ctx,
-			      int cpu, struct pmu *pmu,
-			      struct perf_event_groups *groups,
+static void __perf_pmu_remove(struct perf_event_context *ctx, struct pmu *pmu,
 			      struct list_head *events)
 {
-	struct perf_event *event, *sibling;
+	struct perf_event *event, *tmp;
+
+	list_for_each_entry_safe(event, tmp, &ctx->event_list, event_entry) {
+		if (event->pmu_ctx->pmu != pmu)
+			continue;
 
-	perf_event_groups_for_cpu_pmu(event, groups, cpu, pmu) {
 		perf_remove_from_context(event, 0);
 		put_pmu_ctx(event->pmu_ctx);
 		list_add(&event->migrate_entry, events);
-
-		for_each_sibling_event(sibling, event) {
-			perf_remove_from_context(sibling, 0);
-			put_pmu_ctx(sibling->pmu_ctx);
-			list_add(&sibling->migrate_entry, events);
-		}
 	}
 }
 
@@ -14070,8 +14066,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	 */
 	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
 
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->pinned_groups, &events);
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->flexible_groups, &events);
+	__perf_pmu_remove(src_ctx, pmu, &events);
 
 	if (!list_empty(&events)) {
 		/*
diff --git a/kernel/exit.c b/kernel/exit.c
index e38b2bb85097..4dac7d188d74 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1725,7 +1725,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 69f340cddfd1..e6fbeb2ac190 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -441,45 +441,51 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 }
 
 /*
- * Generate a machine wide unique identifier for this inode.
+ * Generate a machine wide unique identifier for this object (inode or mm).
  *
  * This relies on u64 not wrapping in the life-time of the machine; which with
  * 1ns resolution means almost 585 years.
- *
- * This further relies on the fact that a well formed program will not unmap
- * the file while it has a (shared) futex waiting on it. This mapping will have
- * a file reference which pins the mount and inode.
- *
- * If for some reason an inode gets evicted and read back in again, it will get
- * a new sequence number and will _NOT_ match, even though it is the exact same
- * file.
- *
- * It is important that futex_match() will never have a false-positive, esp.
- * for PI futexes that can mess up the state. The above argues that false-negatives
- * are only possible for malformed programs.
  */
-static u64 get_inode_sequence_number(struct inode *inode)
+static u64 get_object_id(atomic64_t *object_seq)
 {
-	static atomic64_t i_seq;
+	static atomic64_t last_assigned_seq;
 	u64 old;
 
-	/* Does the inode already have a sequence number? */
-	old = atomic64_read(&inode->i_sequence);
+	/* Does the object already have a sequence number? */
+	old = atomic64_read(object_seq);
 	if (likely(old))
 		return old;
 
 	for (;;) {
-		u64 new = atomic64_inc_return(&i_seq);
+		u64 new = atomic64_inc_return(&last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
 		old = 0;
-		if (!atomic64_try_cmpxchg_relaxed(&inode->i_sequence, &old, new))
+		if (!atomic64_try_cmpxchg_relaxed(object_seq, &old, new))
 			return old;
 		return new;
 	}
 }
 
+/*
+ * This relies on the fact that a well formed program will not unmap
+ * the file while it has a (shared) futex waiting on it. This mapping will have
+ * a file reference which pins the mount and inode.
+ *
+ * If for some reason an inode gets evicted and read back in again, it will get
+ * a new sequence number and will _NOT_ match, even though it is the exact same
+ * file.
+ *
+ * It is important that futex_match() will never have a false-positive, esp.
+ * for PI futexes that can mess up the state. The above argues that false-negatives
+ * are only possible for malformed programs.
+ */
+static u64 get_inode_sequence_number(struct inode *inode)
+{
+	return get_object_id(&inode->i_sequence);
+}
+
 /**
  * get_futex_key() - Get parameters which are the keys for a futex
  * @uaddr:	virtual address of the futex
@@ -685,8 +691,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -1724,18 +1730,6 @@ static bool futex_ref_is_dead(struct futex_private_hash *fph)
 	return atomic_long_read(&mm->futex_atomic) == 0;
 }
 
-int futex_mm_init(struct mm_struct *mm)
-{
-	mutex_init(&mm->futex_hash_lock);
-	RCU_INIT_POINTER(mm->futex_phash, NULL);
-	mm->futex_phash_new = NULL;
-	/* futex-ref */
-	mm->futex_ref = NULL;
-	atomic_long_set(&mm->futex_atomic, 0);
-	mm->futex_batches = get_state_synchronize_rcu();
-	return 0;
-}
-
 void futex_hash_free(struct mm_struct *mm)
 {
 	struct futex_private_hash *fph;
@@ -1982,6 +1976,21 @@ static int futex_hash_get_slots(void)
 
 #endif
 
+int futex_mm_init(struct mm_struct *mm)
+{
+	atomic64_set(&mm->futex_unique_id, 0);
+#ifdef CONFIG_FUTEX_PRIVATE_HASH
+	mutex_init(&mm->futex_hash_lock);
+	RCU_INIT_POINTER(mm->futex_phash, NULL);
+	mm->futex_phash_new = NULL;
+	/* futex-ref */
+	mm->futex_ref = NULL;
+	atomic_long_set(&mm->futex_atomic, 0);
+	mm->futex_batches = get_state_synchronize_rcu();
+#endif
+	return 0;
+}
+
 int futex_hash_prctl(unsigned long arg2, unsigned long arg3, unsigned long arg4)
 {
 	unsigned int flags = FH_CUSTOM;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 9fe5d14f1ec5..9691f6bc2fba 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -1054,7 +1054,7 @@ static int __kho_abort(void)
 		unsigned long phys;
 
 		xa_for_each(&physxa->phys_bits, phys, bits)
-			kfree(bits);
+			free_page((unsigned long)bits);
 
 		xa_destroy(&physxa->phys_bits);
 		kfree(physxa);
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index 650be58d8d18..a3dd5fc55e85 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -268,7 +268,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * free_pid() will awaken this task.
 	 */
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
 		schedule();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index dffdbbfa4a00..d555d05ffa8d 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3819,7 +3819,7 @@ static int __init printk_set_kthreads_ready(void)
 
 	return 0;
 }
-early_initcall(printk_set_kthreads_ready);
+subsys_initcall(printk_set_kthreads_ready);
 #endif /* CONFIG_PRINTK */
 
 static int __read_mostly keep_bootcon;
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 55072a105cd6..f3e3146e5feb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2409,8 +2409,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 *
 		 * Core scheduling can force this CPU idle while @p stays
 		 * runnable. @p's cookie then won't match the core's, so skip
@@ -2420,6 +2419,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
 				     !(sch->ops.flags & SCX_OPS_ENQ_LAST));
 			do_enqueue_task(rq, p, SCX_ENQ_LAST, -1);
+
+			/*
+			 * A task put on the local DSQ runs, as anywhere else.
+			 * Here the insert can't reschedule on its own: the pick
+			 * has settled on @next and @p is still curr, so
+			 * resched_curr() would flag @p and __schedule() clears
+			 * that right after the pick. Flag @next instead.
+			 */
+			if (p->scx.dsq == &rq->scx.local_dsq)
+				set_tsk_need_resched(next);
 		} else {
 			do_enqueue_task(rq, p, 0, -1);
 		}
diff --git a/kernel/sched/ext_idle.c b/kernel/sched/ext_idle.c
index d16a1de07865..d2024279939d 100644
--- a/kernel/sched/ext_idle.c
+++ b/kernel/sched/ext_idle.c
@@ -889,12 +889,43 @@ static bool is_bpf_migration_disabled(const struct task_struct *p)
 	return p->migration_disabled;
 }
 
+static s32 select_cpu_restricted(struct task_struct *p, s32 prev_cpu,
+				 const struct cpumask *allowed, u64 flags,
+				 bool migration_disabled)
+{
+	s32 cpu;
+
+	if (migration_disabled)
+		cpu = task_cpu(p);
+	else
+		cpu = cpumask_first(p->cpus_ptr);
+
+	if (!cpumask_test_cpu(cpu, p->cpus_ptr))
+		return -EBUSY;
+
+	if (allowed && !cpumask_test_cpu(cpu, allowed))
+		return -EBUSY;
+
+	if (flags & SCX_PICK_IDLE_IN_NODE) {
+		int node = scx_cpu_node_if_enabled(prev_cpu);
+
+		if (scx_cpu_node_if_enabled(cpu) != node)
+			return -EBUSY;
+	}
+
+	if (!scx_idle_test_and_clear_cpu(cpu))
+		return -EBUSY;
+
+	return cpu;
+}
+
 static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 				 s32 prev_cpu, u64 wake_flags,
 				 const struct cpumask *allowed, u64 flags)
 {
 	struct rq *rq;
 	struct rq_flags rf;
+	bool migration_disabled;
 	s32 cpu;
 
 	if (!ops_cpu_valid(sch, prev_cpu, NULL))
@@ -928,20 +959,17 @@ static s32 select_cpu_from_kfunc(struct scx_sched *sch, struct task_struct *p,
 
 	/*
 	 * This may also be called from ops.enqueue(), so we need to handle
-	 * per-CPU tasks as well. For these tasks, we can skip all idle CPU
-	 * selection optimizations and simply check whether the previously
-	 * used CPU is idle and within the allowed cpumask.
+	 * per-CPU tasks as well. For these tasks, skip general idle CPU
+	 * selection and validate the task's only usable CPU directly.
 	 */
-	if (p->nr_cpus_allowed == 1 || is_bpf_migration_disabled(p)) {
-		if (cpumask_test_cpu(prev_cpu, allowed ?: p->cpus_ptr) &&
-		    scx_idle_test_and_clear_cpu(prev_cpu))
-			cpu = prev_cpu;
-		else
-			cpu = -EBUSY;
-	} else {
+	migration_disabled = is_bpf_migration_disabled(p);
+
+	if (p->nr_cpus_allowed == 1 || migration_disabled)
+		cpu = select_cpu_restricted(p, prev_cpu, allowed, flags,
+					    migration_disabled);
+	else
 		cpu = scx_select_cpu_dfl(p, prev_cpu, wake_flags,
 					 allowed ?: p->cpus_ptr, flags);
-	}
 
 	if (scx_kf_allowed_if_unlocked())
 		task_rq_unlock(rq, p, &rf);
diff --git a/kernel/sched/ext_internal.h b/kernel/sched/ext_internal.h
index 7cb9c8725b65..ed25c130b999 100644
--- a/kernel/sched/ext_internal.h
+++ b/kernel/sched/ext_internal.h
@@ -949,8 +949,9 @@ enum scx_enq_flags {
 	 * %SCX_OPS_ENQ_LAST is specified, they're ops.enqueue()'d with the
 	 * %SCX_ENQ_LAST flag set.
 	 *
-	 * The BPF scheduler is responsible for triggering a follow-up
-	 * scheduling event. Otherwise, Execution may stall.
+	 * If the task is queued on the local DSQ of the CPU it was running on,
+	 * it continues to run. Otherwise, the CPU goes idle. A scheduler that
+	 * wants a full dispatch cycle on the CPU should kick it.
 	 */
 	SCX_ENQ_LAST		= 1LLU << 41,
 
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index c6d3730eb6f3..f74acc78866d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2293,6 +2293,9 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	struct seq_file *m;
 	int ret;
 
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -ENODEV;
+
 	ret = seq_open(file, &rb_meta_seq_ops);
 	if (ret)
 		return ret;
@@ -3373,10 +3376,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 /* Return the index into the sub-buffers for a given sub-buffer */
 static int rb_meta_subbuf_idx(struct ring_buffer_cpu_meta *meta, void *subbuf)
 {
-	void *subbuf_array;
+	void *subbuf_array = rb_subbufs_from_meta(meta);
 
-	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
-	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
 	return (subbuf - subbuf_array) / meta->subbuf_size;
 }
 
@@ -7542,12 +7543,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
 		goto out;
 	}
 
-	/* Did the reader catch up with the writer? */
-	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
-		goto out;
-
 	reader = rb_get_reader_page(cpu_buffer);
-	if (WARN_ON(!reader))
+	if (!reader)
 		goto out;
 
 	/* Check if any events were dropped */
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 54bdc493498b..a76743475e9f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7127,7 +7127,7 @@ static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 
 	ret = ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);
 	if (ret < 0)
-		__trace_array_put(tr);
+		trace_array_put(tr);
 	return ret;
 }
 
@@ -7811,9 +7811,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
 		if (iter->cpu_file != RING_BUFFER_ALL_CPUS)
 			return -EINVAL;
 #endif
-		if (tr->allocated_snapshot)
+		if (tr->allocated_snapshot) {
 			ret = resize_buffer_duplicate_size(&tr->max_buffer,
 					&tr->array_buffer, iter->cpu_file);
+			if (ret < 0)
+				return ret;
+		}
 
 		ret = tracing_arm_snapshot_locked(tr);
 		if (ret)
@@ -10730,6 +10733,12 @@ static struct notifier_block trace_module_nb = {
 
 static __init void tracer_init_tracefs_work_func(struct work_struct *work)
 {
+	/*
+	 * Do not attempt to initialize tracefs if tracing was disabled or
+	 * failed to allocate
+	 */
+	if (tracing_disabled)
+		return;
 
 	event_trace_init();
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 9c63ea51c8be..7985bbdf2ba6 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -482,18 +482,17 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 	int len;
 	int N = 0;
 	int i;
-
-	nr_preds += 2; /* For TRUE and FALSE */
+	int nr_preds_alloc = nr_preds + 2; /* For TRUE and FALSE */
 
 	op_stack = kmalloc_array(nr_parens, sizeof(*op_stack), GFP_KERNEL);
 	if (!op_stack)
 		return ERR_PTR(-ENOMEM);
-	prog_stack = kcalloc(nr_preds, sizeof(*prog_stack), GFP_KERNEL);
+	prog_stack = kcalloc(nr_preds_alloc, sizeof(*prog_stack), GFP_KERNEL);
 	if (!prog_stack) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
 	}
-	inverts = kmalloc_array(nr_preds, sizeof(*inverts), GFP_KERNEL);
+	inverts = kmalloc_array(nr_preds_alloc, sizeof(*inverts), GFP_KERNEL);
 	if (!inverts) {
 		parse_error(pe, -ENOMEM, 0);
 		goto out_free;
@@ -512,7 +511,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 
 		switch (*next) {
 		case '(':					/* #2 */
-			if (top - op_stack > nr_parens) {
+			if (top - op_stack >= nr_parens - 1) {
 				ret = -EINVAL;
 				goto out_free;
 			}
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9152f63cfb4c..20d23a08b5b8 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -284,7 +284,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 
 	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
-	return (u64) ilog2(roundup_pow_of_two(val));
+	return order_base_2(val);
 }
 
 static u64 hist_field_bucket(struct hist_field *hist_field,
@@ -868,7 +868,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
 
-	u64 ts = ring_buffer_event_time_stamp(buffer, rbe);
+	u64 ts = tracing_event_time_stamp(buffer, rbe);
 
 	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
 		ts = ns2usecs(ts);
@@ -2115,7 +2115,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -3307,6 +3308,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret =  -ENOMEM;
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var->var = var;
 	field_var->val = val;
@@ -3925,7 +3927,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
@@ -4466,7 +4471,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
 		update_var_execname(hist_data->fields[val_idx]);
 
-	if (!ret && hist_data->fields[val_idx]->flags &
+	if (!ret && !(hist_data->fields[val_idx]->flags & HIST_FIELD_FL_ALIAS) &&
+	    hist_data->fields[val_idx]->flags &
 	    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
@@ -5207,7 +5213,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
-			if (hist_field->flags &
+			if (!(hist_field->flags & HIST_FIELD_FL_ALIAS) &&
+			    hist_field->flags &
 			    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE)) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index a0fe68cff4d3..7202fb4aced1 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1847,7 +1847,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx)
 {
-	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
 	const char **new_argv __free(kfree) = NULL;
 
@@ -1865,7 +1864,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);
-			return (const char **)params;
+			return ERR_PTR(-EOPNOTSUPP);
 		}
 		*new_argc = argc;
 		return NULL;
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 7e45559521af..bc8d6b641ed4 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,7 +101,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, note, offset, len;
+	unsigned int head, tail, note, offset, len, nr_notes;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
@@ -111,8 +111,10 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	if (pipe_full(head, tail, pipe->ring_size))
 		goto lost;
 
-	note = find_first_bit(wqueue->notes_bitmap, wqueue->nr_notes);
-	if (note >= wqueue->nr_notes)
+	/* Pairs with the smp_store_release() in watch_queue_set_size(). */
+	nr_notes = smp_load_acquire(&wqueue->nr_notes);
+	note = find_first_bit(wqueue->notes_bitmap, nr_notes);
+	if (note >= nr_notes)
 		goto lost;
 
 	page = wqueue->notes[note / WATCH_QUEUE_NOTES_PER_PAGE];
@@ -297,7 +299,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-	wqueue->nr_notes = nr_notes;
+	/* Pairs with the smp_load_acquire() in post_one_notification(). */
+	smp_store_release(&wqueue->nr_notes, nr_notes);
 	return 0;
 
 error_p:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 162137855058..8c74f199cd70 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1562,6 +1562,9 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+/* True if @pool is a static per-cpu pool rather than an unbound one. */
+#define is_percpu_pool(pool) ((pool)->cpu >= 0)
+
 /**
  * wq_node_nr_active - Determine wq_node_nr_active to use
  * @wq: workqueue of interest
@@ -2689,7 +2692,7 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	if (pool->cpu < 0 && pool->attrs->affn_strict)
+	if (!is_percpu_pool(pool) && pool->attrs->affn_strict)
 		return pool->attrs->__pod_cpumask;
 	else
 		return pool->attrs->cpumask;
@@ -3115,7 +3118,16 @@ __acquires(&pool->lock)
 #ifdef CONFIG_PREEMPT_RT
 static void worker_lock_callback(struct worker_pool *pool)
 {
-	spin_lock(&pool->cb_lock);
+	/*
+	 * SINGLE_DEPTH_NESTING is for a dead pool's bh_worker() running from
+	 * drain_dead_softirq_workfn() inside a live pool's bh_worker(). The
+	 * unlocked read is stable: the flag is only set while @pool's CPU is
+	 * dead, inside a serialized hotplug operation. data_race() as the value
+	 * only affects the lockdep annotation and the read can be elided when
+	 * lockdep is disabled.
+	 */
+	spin_lock_nested(&pool->cb_lock,
+			 data_race(pool->flags) & POOL_BH_DRAINING ? SINGLE_DEPTH_NESTING : 0);
 }
 
 static void worker_unlock_callback(struct worker_pool *pool)
@@ -5021,7 +5033,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		return;
 
 	/* sanity checks */
-	if (WARN_ON(!(pool->cpu < 0)) ||
+	if (WARN_ON(is_percpu_pool(pool)) ||
 	    WARN_ON(!list_empty(&pool->worklist)))
 		return;
 
@@ -5173,12 +5185,6 @@ static void pwq_release_workfn(struct kthread_work *work)
 		mutex_unlock(&wq->mutex);
 	}
 
-	if (wq->flags & WQ_UNBOUND) {
-		mutex_lock(&wq_pool_mutex);
-		put_unbound_pool(pool);
-		mutex_unlock(&wq_pool_mutex);
-	}
-
 	if (!list_empty(&pwq->pending_node)) {
 		struct wq_node_nr_active *nna =
 			wq_node_nr_active(pwq->wq, pwq->pool->node);
@@ -5188,6 +5194,12 @@ static void pwq_release_workfn(struct kthread_work *work)
 		raw_spin_unlock_irq(&nna->lock);
 	}
 
+	if (!is_percpu_pool(pool)) {
+		mutex_lock(&wq_pool_mutex);
+		put_unbound_pool(pool);
+		mutex_unlock(&wq_pool_mutex);
+	}
+
 	kfree_rcu(pwq, rcu);
 
 	/*
@@ -7711,7 +7723,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
-			if (pool->cpu >= 0 && !(pool->flags & POOL_BH)) {
+			if (is_percpu_pool(pool) && !(pool->flags & POOL_BH)) {
 				pool->cpu_stall = true;
 				cpu_pool_stall = true;
 			}
@@ -7808,12 +7820,12 @@ static inline void wq_watchdog_init(void) { }
 
 static void bh_pool_kick_normal(struct irq_work *irq_work)
 {
-	raise_softirq_irqoff(TASKLET_SOFTIRQ);
+	raise_softirq(TASKLET_SOFTIRQ);
 }
 
 static void bh_pool_kick_highpri(struct irq_work *irq_work)
 {
-	raise_softirq_irqoff(HI_SOFTIRQ);
+	raise_softirq(HI_SOFTIRQ);
 }
 
 static void __init restrict_unbound_cpumask(const char *name, const struct cpumask *mask)
diff --git a/lib/crypto/arm64/poly1305-armv8.pl b/lib/crypto/arm64/poly1305-armv8.pl
index f1930c6b55ce..234398ff6b60 100644
--- a/lib/crypto/arm64/poly1305-armv8.pl
+++ b/lib/crypto/arm64/poly1305-armv8.pl
@@ -375,7 +375,7 @@ poly1305_blocks_neon:
 	adc	$h1,$h1,xzr
 	lsr	$h2,x14,#24
 	adds	$h1,$h1,x14,lsl#40
-	adc	$d2,$h2,xzr		// can be partially reduced...
+	adc	$h2,$h2,xzr		// preserve carry into top limb
 
 	ldp	$d0,$d1,[$inp],#16	// load input
 	sub	$len,$len,#16
diff --git a/lib/crypto/poly1305.c b/lib/crypto/poly1305.c
index f313ccc4b4dd..048c7afe8613 100644
--- a/lib/crypto/poly1305.c
+++ b/lib/crypto/poly1305.c
@@ -78,7 +78,7 @@ void poly1305_final(struct poly1305_desc_ctx *desc, u8 *dst)
 	}
 
 	poly1305_emit(&desc->state.h, dst, desc->s);
-	*desc = (struct poly1305_desc_ctx){};
+	memzero_explicit(desc, sizeof(*desc));
 }
 EXPORT_SYMBOL(poly1305_final);
 
diff --git a/net/ax25/ax25_std_in.c b/net/ax25/ax25_std_in.c
index ba176196ae06..f280683f83fc 100644
--- a/net/ax25/ax25_std_in.c
+++ b/net/ax25/ax25_std_in.c
@@ -196,6 +196,38 @@ static int ax25_std_state3_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
 		if (ax25_validate_nr(ax25, nr)) {
 			ax25_frames_acked(ax25, nr);
 			ax25_calculate_rtt(ax25);
+			/*
+			 * REJ triggers an immediate go-back-N retransmit,
+			 * deliberately bypassing the T1/N2 backoff that
+			 * paces every other recovery path in this state
+			 * machine -- that is the whole point of REJ, fast
+			 * recovery from a single lost/out-of-order frame.
+			 * But unlike every other recovery path here, this
+			 * one never touches n2count, so it has no bound: if
+			 * something keeps corrupting or reordering each
+			 * retransmitted burst (lossy RF, or reordering over
+			 * a UDP-based link such as axudp), every attempt
+			 * draws an immediate fresh REJ and the link is
+			 * retransmitted at wire/CPU speed indefinitely
+			 * ("machine-gun" storm), never reaching the N2 give
+			 * up that bounds every other recovery attempt.
+			 * Count consecutive REJ-driven fast retransmits the
+			 * same way a T1 timeout would in this state, and
+			 * once N2 of them have failed to make it through,
+			 * fall back to the normal paced state 4 enquiry
+			 * (which will genuinely give up and disconnect after
+			 * N2 further tries if the link stays bad). A single
+			 * frame accepted in sequence resets the counter (see
+			 * the AX25_I case below), so an isolated REJ during
+			 * otherwise healthy traffic never gets close to N2.
+			 */
+			if (ax25->n2count == ax25->n2) {
+				ax25->n2count = 1;
+				ax25_std_transmit_enquiry(ax25);
+				ax25->state = AX25_STATE_4;
+				break;
+			}
+			ax25->n2count++;
 			ax25_stop_t1timer(ax25);
 			ax25_start_t3timer(ax25);
 			ax25_requeue_frames(ax25);
@@ -226,6 +258,10 @@ static int ax25_std_state3_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
 			if (ax25->condition & AX25_COND_OWN_RX_BUSY)
 				ax25->vr = ns;	/* ax25->vr - 1 */
 			ax25->condition &= ~AX25_COND_REJECT;
+			/* Genuine forward progress: a frame made it through in
+			 * sequence, so this is not part of a REJ storm.
+			 */
+			ax25->n2count = 0;
 			if (pf) {
 				ax25_std_enquiry_response(ax25);
 			} else {
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 78682aace574..c437cb684aeb 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -813,7 +813,11 @@ static void __br_multicast_del_pg(struct net_bridge_mdb_entry *mp,
 	struct hlist_node *tmp;
 
 	rcu_assign_pointer(*pp, pg->next);
-	hlist_del_init(&pg->mglist);
+	/* Keep ->next (held under multicast_lock, freed later by the GC work):
+	 * a port->mglist teardown walk may have latched this node as its next,
+	 * and deleting other groups of the same port must not truncate it.
+	 */
+	hlist_del_init_rcu(&pg->mglist);
 	br_multicast_eht_clean_sets(pg);
 	hlist_for_each_entry_safe(ent, tmp, &pg->src_list, node)
 		br_multicast_del_group_src(ent, false);
@@ -848,6 +852,13 @@ static void br_multicast_find_del_pg(struct net_bridge *br,
 	struct net_bridge_mdb_entry *mp;
 	struct net_bridge_port_group *p;
 
+	/* A teardown walk over port->mglist can reach a group that an earlier
+	 * iteration already deleted as a side effect. It is off mp->ports by
+	 * now, so skip it instead of falling through to the WARN_ON() below.
+	 */
+	if (hlist_unhashed(&pg->mglist))
+		return;
+
 	mp = br_mdb_ip_get(br, &pg->key.addr);
 	if (WARN_ON(!mp))
 		return;
diff --git a/net/bridge/br_netfilter_ipv6.c b/net/bridge/br_netfilter_ipv6.c
index e0421eaa3abc..76ce70b4e7f3 100644
--- a/net/bridge/br_netfilter_ipv6.c
+++ b/net/bridge/br_netfilter_ipv6.c
@@ -58,7 +58,7 @@ int br_validate_ipv6(struct net *net, struct sk_buff *skb)
 	if (hdr->version != 6)
 		goto inhdr_error;
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 	if (hdr->nexthdr == NEXTHDR_HOP && nf_ip6_check_hbh_len(skb, &pkt_len))
 		goto drop;
 
diff --git a/net/bridge/netfilter/nf_conntrack_bridge.c b/net/bridge/netfilter/nf_conntrack_bridge.c
index cfa809110242..b17962672ebf 100644
--- a/net/bridge/netfilter/nf_conntrack_bridge.c
+++ b/net/bridge/netfilter/nf_conntrack_bridge.c
@@ -234,7 +234,7 @@ static int nf_ct_br_ipv6_check(const struct sk_buff *skb)
 	if (hdr->version != 6)
 		return -1;
 
-	len = ntohs(hdr->payload_len) + sizeof(struct ipv6hdr) + nhoff;
+	len = ipv6_payload_len(skb, hdr) + sizeof(struct ipv6hdr) + nhoff;
 	if (skb->len < len)
 		return -1;
 
@@ -274,7 +274,7 @@ static unsigned int nf_ct_bridge_pre(void *priv, struct sk_buff *skb,
 		if (!pskb_may_pull(skb, sizeof(struct ipv6hdr)))
 			return NF_ACCEPT;
 
-		len = sizeof(struct ipv6hdr) + ntohs(ipv6_hdr(skb)->payload_len);
+		len = sizeof(struct ipv6hdr) + skb_ipv6_payload_len(skb);
 		if (pskb_trim_rcsum(skb, len))
 			return NF_ACCEPT;
 
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index e02bdee3c5fd..e2a169d6f7b0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1071,7 +1071,8 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (WARN_ON(size > max_size))
 		return 0;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 __alignof__(struct skb_shared_info)));
 	*offset = pool->frag_offset;
 
 	if (netmem && *offset + size > max_size) {
diff --git a/net/core/sock.c b/net/core/sock.c
index 4dc2b03509f8..b8c723d6ac59 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2471,6 +2471,9 @@ struct sock *sk_clone_lock(const struct sock *sk, const gfp_t priority)
 #ifdef CONFIG_BPF_SYSCALL
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 #endif
+#if IS_ENABLED(CONFIG_INET_PSP)
+	RCU_INIT_POINTER(newsk->psp_assoc, NULL);
+#endif
 
 	/* SANITY */
 	if (likely(newsk->sk_net_refcnt)) {
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 08d1bbaafc79..d194701fe0ad 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -881,7 +881,7 @@ static void fib_rebalance(struct fib_info *fi)
 	change_nexthops(fi) {
 		int upper_bound;
 
-		if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
+		if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
 			upper_bound = -1;
 		} else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
 			   nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index ec8958688c48..56e7e7ef5e5c 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4540,9 +4540,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 
-		ca_ops = icsk->icsk_ca_ops;
+		rcu_read_lock();
+		ca_ops = READ_ONCE(icsk->icsk_ca_ops);
 		if (ca_ops && ca_ops->get_info)
 			sz = ca_ops->get_info(sk, ~0U, &attr, &info);
+		rcu_read_unlock();
 
 		len = min_t(unsigned int, len, sz);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
@@ -4555,16 +4557,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = !inet_csk_in_pingpong_mode(sk);
 		break;
 
-	case TCP_CONGESTION:
+	case TCP_CONGESTION: {
+		char ca_name[TCP_CA_NAME_MAX] = {};
+
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
 		len = min_t(unsigned int, len, TCP_CA_NAME_MAX);
 		if (copy_to_sockptr(optlen, &len, sizeof(int)))
 			return -EFAULT;
-		if (copy_to_sockptr(optval, icsk->icsk_ca_ops->name, len))
+
+		rcu_read_lock();
+		memcpy(ca_name, READ_ONCE(icsk->icsk_ca_ops)->name,
+		       sizeof(ca_name));
+		rcu_read_unlock();
+
+		if (copy_to_sockptr(optval, ca_name, len))
 			return -EFAULT;
 		return 0;
-
+	}
 	case TCP_ULP:
 		if (copy_from_sockptr(&len, optlen, sizeof(int)))
 			return -EFAULT;
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index e9f6c77e0631..8e83ef81fc18 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -223,7 +223,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -253,7 +253,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 6f103038b015..0492728fa613 100644
--- a/net/ipv4/tcp_dctcp.c
+++ b/net/ipv4/tcp_dctcp.c
@@ -111,7 +111,7 @@ __bpf_kfunc static void dctcp_init(struct sock *sk)
 	/* No ECN support? Fall back to Reno. Also need to clear
 	 * ECT from sk since it is set during 3WHS for DCTCP.
 	 */
-	inet_csk(sk)->icsk_ca_ops = &dctcp_reno;
+	WRITE_ONCE(inet_csk(sk)->icsk_ca_ops, &dctcp_reno);
 	INET_ECN_dontxmit(sk);
 }
 
@@ -224,7 +224,7 @@ static size_t dctcp_get_info(struct sock *sk, u32 ext, int *attr,
 	if (ext & (1 << (INET_DIAG_DCTCPINFO - 1)) ||
 	    ext & (1 << (INET_DIAG_VEGASINFO - 1))) {
 		memset(&info->dctcp, 0, sizeof(info->dctcp));
-		if (inet_csk(sk)->icsk_ca_ops != &dctcp_reno) {
+		if (READ_ONCE(inet_csk(sk)->icsk_ca_ops) != &dctcp_reno) {
 			info->dctcp.dctcp_enabled = 1;
 			info->dctcp.dctcp_ce_state = (u16) ca->ce_state;
 			info->dctcp.dctcp_alpha = ca->dctcp_alpha;
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a496c26737fd..d05009f985af 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -508,7 +508,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3f9e11a43f35..ddcc7e53f2e3 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4030,7 +4030,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 341786983d42..a7ae0d098f2c 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1033,7 +1033,16 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
-	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
+	const int type = icmp_hdr(skb)->type;
+	const int code = icmp_hdr(skb)->code;
+	struct net *net = dev_net(skb->dev);
+
+	if (type == ICMP_DEST_UNREACH && code == ICMP_FRAG_NEEDED)
+		ipv4_update_pmtu(skb, net, info, 0, IPPROTO_UDP);
+	else if (type == ICMP_REDIRECT)
+		ipv4_redirect(skb, net, 0, IPPROTO_UDP);
+
+	return __udp4_lib_err(skb, info, net->ipv4.udp_table);
 }
 
 /*
diff --git a/net/ipv6/calipso.c b/net/ipv6/calipso.c
index 21f6ed126253..22008f5a2973 100644
--- a/net/ipv6/calipso.c
+++ b/net/ipv6/calipso.c
@@ -1319,7 +1319,7 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 	struct ipv6hdr *ip6_hdr;
 	struct ipv6_opt_hdr *hop;
 	unsigned char buf[CALIPSO_MAX_BUFFER];
-	int len_delta, new_end, pad, payload;
+	int len_delta, new_end, pad;
 	unsigned int start, end;
 
 	ip6_hdr = ipv6_hdr(skb);
@@ -1358,8 +1358,8 @@ static int calipso_skbuff_setattr(struct sk_buff *skb,
 			sizeof(*ip6_hdr) + start);
 		skb_reset_network_header(skb);
 		ip6_hdr = ipv6_hdr(skb);
-		payload = ntohs(ip6_hdr->payload_len);
-		ip6_hdr->payload_len = htons(payload + len_delta);
+		/* 0 above IPV6_MAXPLEN (BIG TCP), the real length otherwise */
+		ipv6_set_payload_len(ip6_hdr, skb->len - sizeof(*ip6_hdr));
 	}
 
 	hop = (struct ipv6_opt_hdr *)(ip6_hdr + 1);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index b59b2b119a1c..673c6f0ce617 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -262,7 +262,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	skb->transport_header = skb->network_header + sizeof(*hdr);
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
-	pkt_len = ntohs(hdr->payload_len);
+	pkt_len = ipv6_payload_len(skb, hdr);
 
 	/* pkt_len may be zero if Jumbo payload option is present */
 	if (pkt_len || hdr->nexthdr != NEXTHDR_HOP) {
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a..6762ce7909c8 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -372,12 +372,11 @@ INDIRECT_CALLABLE_SCOPE int ipv6_gro_complete(struct sk_buff *skb, int nhoff)
 		hop_jumbo->jumbo_payload_len = htonl(payload_len + hoplen);
 
 		iph->nexthdr = NEXTHDR_HOP;
-		iph->payload_len = 0;
-	} else {
-		iph = (struct ipv6hdr *)(skb->data + nhoff);
-		iph->payload_len = htons(payload_len);
 	}
 
+	iph = (struct ipv6hdr *)(skb->data + nhoff);
+	ipv6_set_payload_len(iph, payload_len);
+
 	nhoff += sizeof(*iph) + ipv6_exthdrs_len(iph, &ops);
 	if (WARN_ON(!ops || !ops->callbacks.gro_complete))
 		goto out;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 1c9b283a4132..cba1684a3f30 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -125,12 +125,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
 int __ip6_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	int len;
-
-	len = skb->len - sizeof(struct ipv6hdr);
-	if (len > IPV6_MAXPLEN)
-		len = 0;
-	ipv6_hdr(skb)->payload_len = htons(len);
+	ipv6_set_payload_len(ipv6_hdr(skb), skb->len - sizeof(struct ipv6hdr));
 	IP6CB(skb)->nhoff = offsetof(struct ipv6hdr, nexthdr);
 
 	/* if egress device is enslaved to an L3 master device pass the
diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
index 5b48bd30efd2..8ec56556be3b 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -208,12 +208,6 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	phs_hdr->flags = flags;
 	if (flags == AF_IUCV_FLAG_SYN)
 		phs_hdr->window = iucv->msglimit;
-	else if ((flags == AF_IUCV_FLAG_WIN) || !flags) {
-		confirm_recv = atomic_read(&iucv->msg_recv);
-		phs_hdr->window = confirm_recv;
-		if (confirm_recv)
-			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
-	}
 	memcpy(phs_hdr->destUserID, iucv->dst_user_id, 8);
 	memcpy(phs_hdr->destAppName, iucv->dst_name, 8);
 	memcpy(phs_hdr->srcUserID, iucv->src_user_id, 8);
@@ -248,13 +242,22 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
 	}
 	skb->protocol = cpu_to_be16(ETH_P_AF_IUCV);
 
+	/* Claim the receive credit here, not while building the header: every
+	 * way this frame can be dropped has now been ruled out, so the window
+	 * is zeroed only for as long as the transmit itself takes.
+	 */
+	if (flags == AF_IUCV_FLAG_WIN || !flags) {
+		confirm_recv = atomic_xchg(&iucv->msg_recv, 0);
+		phs_hdr->window = confirm_recv;
+		if (confirm_recv)
+			phs_hdr->flags = phs_hdr->flags | AF_IUCV_FLAG_WIN;
+	}
+
 	atomic_inc(&iucv->skbs_in_xmit);
 	err = dev_queue_xmit(skb);
 	if (net_xmit_eval(err)) {
 		atomic_dec(&iucv->skbs_in_xmit);
-	} else {
-		atomic_sub(confirm_recv, &iucv->msg_recv);
-		WARN_ON(atomic_read(&iucv->msg_recv) < 0);
+		atomic_add(confirm_recv, &iucv->msg_recv);
 	}
 	return net_xmit_eval(err);
 
@@ -1238,6 +1241,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win = false;
 	int err = 0;
 	u32 offset;
 
@@ -1328,16 +1332,20 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		if (skb_queue_empty(&iucv->backlog_skb_q)) {
 			if (!list_empty(&iucv->message_q.list))
 				iucv_process_message_q(sk);
-			if (atomic_read(&iucv->msg_recv) >=
-							iucv->msglimit / 2) {
-				err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
-				if (err) {
-					sk->sk_state = IUCV_DISCONN;
-					sk->sk_state_change(sk);
-				}
-			}
+			if (iucv->transport == AF_IUCV_TRANS_HIPER &&
+			    atomic_read(&iucv->msg_recv) >=
+							iucv->msglimit / 2)
+				send_win = true;
 		}
 		spin_unlock_bh(&iucv->message_q.lock);
+
+		if (send_win) {
+			err = iucv_send_ctrl(sk, AF_IUCV_FLAG_WIN);
+			if (err) {
+				sk->sk_state = IUCV_DISCONN;
+				sk->sk_state_change(sk);
+			}
+		}
 	}
 
 done:
diff --git a/net/mac802154/ieee802154_i.h b/net/mac802154/ieee802154_i.h
index 279ff4e9b11e..992ce6698c20 100644
--- a/net/mac802154/ieee802154_i.h
+++ b/net/mac802154/ieee802154_i.h
@@ -80,7 +80,12 @@ struct ieee802154_local {
 	spinlock_t rx_lock;
 
 	/* Association */
-	struct ieee802154_pan_device *assoc_dev;
+	/* assoc_lock protects assoc_dev_extended_addr, assoc_addr,
+	 * assoc_status, the assoc_done reinit/complete pairing and the
+	 * IEEE802154_IS_ASSOCIATING bit in @ongoing.
+	 */
+	spinlock_t assoc_lock;
+	__le64 assoc_dev_extended_addr;
 	struct completion assoc_done;
 	__le16 assoc_addr;
 	u8 assoc_status;
diff --git a/net/mac802154/main.c b/net/mac802154/main.c
index 386c086c79d1..8ed6de111f5a 100644
--- a/net/mac802154/main.c
+++ b/net/mac802154/main.c
@@ -105,6 +105,7 @@ ieee802154_alloc_hw(size_t priv_data_len, const struct ieee802154_ops *ops)
 	INIT_WORK(&local->rx_mac_cmd_work, mac802154_rx_mac_cmd_worker);
 
 	init_completion(&local->assoc_done);
+	spin_lock_init(&local->assoc_lock);
 
 	/* init supported flags with 802.15.4 default ranges */
 	phy->supported.max_minbe = 8;
diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
index e507a3ad35d0..fb63a2e9068d 100644
--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -532,7 +532,9 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 	struct ieee802154_association_req_frame frame = {};
 	struct ieee802154_local *local = sdata->local;
 	struct wpan_dev *wpan_dev = &sdata->wpan_dev;
+	__le16 resp_short_addr;
 	struct sk_buff *skb;
+	u8 resp_status;
 	int ret;
 
 	frame.mhr.fc.type = IEEE802154_FC_TYPE_MAC_CMD;
@@ -574,9 +576,11 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 		return ret;
 	}
 
-	local->assoc_dev = coord;
+	spin_lock(&local->assoc_lock);
 	reinit_completion(&local->assoc_done);
+	local->assoc_dev_extended_addr = coord->extended_addr;
 	set_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	spin_unlock(&local->assoc_lock);
 
 	ret = ieee802154_mlme_tx_one_locked(local, sdata, skb);
 	if (ret) {
@@ -595,25 +599,37 @@ int mac802154_perform_association(struct ieee802154_sub_if_data *sdata,
 		goto clear_assoc;
 	}
 
-	if (local->assoc_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
-		if (local->assoc_status == IEEE802154_PAN_AT_CAPACITY)
+	/* The association is complete: mac802154_process_association_resp()
+	 * cleared the associating bit before waking us, so a second (e.g.
+	 * malicious) ASSOC RESP can no longer pass the recheck and overwrite
+	 * the result.  Snapshot assoc_status/assoc_addr under the lock.
+	 */
+	spin_lock(&local->assoc_lock);
+	resp_status = local->assoc_status;
+	resp_short_addr = local->assoc_addr;
+	spin_unlock(&local->assoc_lock);
+
+	if (resp_status != IEEE802154_ASSOCIATION_SUCCESSFUL) {
+		if (resp_status == IEEE802154_PAN_AT_CAPACITY)
 			ret = -ERANGE;
 		else
 			ret = -EPERM;
 
 		dev_warn(&sdata->dev->dev,
 			 "Negative ASSOC RESP received from %8phC: %s\n", &ceaddr,
-			 local->assoc_status == IEEE802154_PAN_AT_CAPACITY ?
+			 resp_status == IEEE802154_PAN_AT_CAPACITY ?
 			 "PAN at capacity" : "access denied");
-		goto clear_assoc;
+		return ret;
 	}
 
-	ret = 0;
-	*short_addr = local->assoc_addr;
+	*short_addr = resp_short_addr;
+
+	return 0;
 
 clear_assoc:
+	spin_lock(&local->assoc_lock);
 	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
-	local->assoc_dev = NULL;
+	spin_unlock(&local->assoc_lock);
 
 	return ret;
 }
@@ -635,19 +651,28 @@ int mac802154_process_association_resp(struct ieee802154_sub_if_data *sdata,
 		     dest->mode != IEEE802154_EXTENDED_ADDRESSING))
 		return -EINVAL;
 
-	if (unlikely(dest->extended_addr != wpan_dev->extended_addr ||
-		     src->extended_addr != local->assoc_dev->extended_addr))
+	spin_lock(&local->assoc_lock);
+	if (unlikely(!test_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing) ||
+		     dest->extended_addr != wpan_dev->extended_addr ||
+		     src->extended_addr != local->assoc_dev_extended_addr)) {
+		spin_unlock(&local->assoc_lock);
 		return -ENODEV;
+	}
 
 	memcpy(&resp_pl, skb->data, sizeof(resp_pl));
 	local->assoc_addr = resp_pl.short_addr;
 	local->assoc_status = resp_pl.status;
+	/* Clear the associating bit before waking the waiter: once the result
+	 * is saved, any subsequent (e.g. malicious) ASSOC RESP must fail the
+	 * test_bit() recheck above and can no longer overwrite the result.
+	 */
+	clear_bit(IEEE802154_IS_ASSOCIATING, &local->ongoing);
+	complete(&local->assoc_done);
+	spin_unlock(&local->assoc_lock);
 
 	dev_dbg(&skb->dev->dev,
 		"ASSOC RESP 0x%x received from %8phC, getting short address %04x\n",
-		local->assoc_status, &deaddr, local->assoc_addr);
-
-	complete(&local->assoc_done);
+		resp_pl.status, &deaddr, resp_pl.short_addr);
 
 	return 0;
 }
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index fa66e3168550..9d92e92a966c 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -985,7 +985,7 @@ ip_vs_prepare_tunneled_skb(struct sk_buff *skb, int skb_af,
 		*next_protocol = IPPROTO_IPV6;
 		if (payload_len)
 			*payload_len =
-				ntohs(old_ipv6h->payload_len) +
+				ipv6_payload_len(skb, old_ipv6h) +
 				sizeof(*old_ipv6h);
 		old_dsfield = ipv6_get_dsfield(old_ipv6h);
 		*ttl = old_ipv6h->hop_limit;
diff --git a/net/netfilter/nf_conntrack_ovs.c b/net/netfilter/nf_conntrack_ovs.c
index 068e9489e1c2..a6988eeb1579 100644
--- a/net/netfilter/nf_conntrack_ovs.c
+++ b/net/netfilter/nf_conntrack_ovs.c
@@ -121,7 +121,7 @@ int nf_ct_skb_network_trim(struct sk_buff *skb, int family)
 		len = skb_ip_totlen(skb);
 		break;
 	case NFPROTO_IPV6:
-		len = ntohs(ipv6_hdr(skb)->payload_len);
+		len = skb_ipv6_payload_len(skb);
 		if (ipv6_hdr(skb)->nexthdr == NEXTHDR_HOP) {
 			int err = nf_ip6_check_hbh_len(skb, &len);
 
diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 6782c72bcfc2..f368e090e645 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -564,7 +564,7 @@ dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
 
 	/* Max length: 44 "LEN=65535 TC=255 HOPLIMIT=255 FLOWLBL=FFFFF " */
 	nf_log_buf_add(m, "LEN=%zu TC=%u HOPLIMIT=%u FLOWLBL=%u ",
-		       ntohs(ih->payload_len) + sizeof(struct ipv6hdr),
+		       ipv6_payload_len(skb, ih) + sizeof(struct ipv6hdr),
 		       (ntohl(*(__be32 *)ih) & 0x0ff00000) >> 20,
 		       ih->hop_limit,
 		       (ntohl(*(__be32 *)ih) & 0x000fffff));
diff --git a/net/netfilter/nft_byteorder.c b/net/netfilter/nft_byteorder.c
index 74548b4c114b..391aade36ef3 100644
--- a/net/netfilter/nft_byteorder.c
+++ b/net/netfilter/nft_byteorder.c
@@ -19,7 +19,6 @@ struct nft_byteorder {
 	u8			sreg;
 	u8			dreg;
 	enum nft_byteorder_ops	op:8;
-	u8			len;
 	u8			size;
 };
 
@@ -28,13 +27,8 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 			const struct nft_pktinfo *pkt)
 {
 	const struct nft_byteorder *priv = nft_expr_priv(expr);
-	u32 *src = &regs->data[priv->sreg];
+	const u32 *src = &regs->data[priv->sreg];
 	u32 *dst = &regs->data[priv->dreg];
-	u16 *s16, *d16;
-	unsigned int i;
-
-	s16 = (void *)src;
-	d16 = (void *)dst;
 
 	switch (priv->size) {
 	case 8: {
@@ -43,18 +37,14 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i = 0; i < priv->len / 8; i++) {
-				src64 = nft_reg_load64(&src[i]);
-				nft_reg_store64(&dst64[i],
-						be64_to_cpu((__force __be64)src64));
-			}
+			src64 = nft_reg_load64(src);
+
+			nft_reg_store64(dst64, be64_to_cpu((__force __be64)src64));
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i = 0; i < priv->len / 8; i++) {
-				src64 = (__force __u64)
-					cpu_to_be64(nft_reg_load64(&src[i]));
-				nft_reg_store64(&dst64[i], src64);
-			}
+			src64 = (__force __u64)cpu_to_be64(nft_reg_load64(src));
+
+			nft_reg_store64(dst64, src64);
 			break;
 		}
 		break;
@@ -62,24 +52,20 @@ void nft_byteorder_eval(const struct nft_expr *expr,
 	case 4:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i = 0; i < priv->len / 4; i++)
-				dst[i] = ntohl((__force __be32)src[i]);
+			*dst = ntohl((__force __be32)*src);
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i = 0; i < priv->len / 4; i++)
-				dst[i] = (__force __u32)htonl(src[i]);
+			*dst = (__force __u32)htonl(*src);
 			break;
 		}
 		break;
 	case 2:
 		switch (priv->op) {
 		case NFT_BYTEORDER_NTOH:
-			for (i = 0; i < priv->len / 2; i++)
-				d16[i] = ntohs((__force __be16)s16[i]);
+			nft_reg_store16(dst, ntohs(nft_reg_load_be16(src)));
 			break;
 		case NFT_BYTEORDER_HTON:
-			for (i = 0; i < priv->len / 2; i++)
-				d16[i] = (__force __u16)htons(s16[i]);
+			nft_reg_store_be16(dst, htons(nft_reg_load16(src)));
 			break;
 		}
 		break;
@@ -137,20 +123,22 @@ static int nft_byteorder_init(const struct nft_ctx *ctx,
 	if (err < 0)
 		return err;
 
-	priv->len = len;
+	/* no longer support multi-reg conversions */
+	if (len != size)
+		return -EOPNOTSUPP;
 
 	err = nft_parse_register_load(ctx, tb[NFTA_BYTEORDER_SREG], &priv->sreg,
-				      priv->len);
+				      len);
 	if (err < 0)
 		return err;
 
 	err = nft_parse_register_store(ctx, tb[NFTA_BYTEORDER_DREG],
 				       &priv->dreg, NULL, NFT_DATA_VALUE,
-				       priv->len);
+				       len);
 	if (err < 0)
 		return err;
 
-	if (nft_reg_overlap(priv->sreg, priv->dreg, priv->len))
+	if (nft_reg_overlap(priv->sreg, priv->dreg, len))
 		return -EINVAL;
 
 	return 0;
@@ -167,10 +155,11 @@ static int nft_byteorder_dump(struct sk_buff *skb,
 		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_BYTEORDER_OP, htonl(priv->op)))
 		goto nla_put_failure;
-	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->len)))
-		goto nla_put_failure;
 	if (nla_put_be32(skb, NFTA_BYTEORDER_SIZE, htonl(priv->size)))
 		goto nla_put_failure;
+	/* compatibility for old userspace which permitted size != len */
+	if (nla_put_be32(skb, NFTA_BYTEORDER_LEN, htonl(priv->size)))
+		goto nla_put_failure;
 	return 0;
 
 nla_put_failure:
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index fd8e9cfe6171..6c0aabca5dba 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -463,7 +463,7 @@ netlink_unlock_table(void)
 
 struct netlink_compare_arg
 {
-	possible_net_t pnet;
+	u64 net_cookie;
 	u32 portid;
 };
 
@@ -478,14 +478,14 @@ static inline int netlink_compare(struct rhashtable_compare_arg *arg,
 	const struct netlink_sock *nlk = ptr;
 
 	return nlk->portid != x->portid ||
-	       !net_eq(sock_net(&nlk->sk), read_pnet(&x->pnet));
+	       sock_net(&nlk->sk)->net_cookie != x->net_cookie;
 }
 
 static void netlink_compare_arg_init(struct netlink_compare_arg *arg,
 				     struct net *net, u32 portid)
 {
 	memset(arg, 0, sizeof(*arg));
-	write_pnet(&arg->pnet, net);
+	arg->net_cookie = net->net_cookie;
 	arg->portid = portid;
 }
 
@@ -1345,6 +1345,8 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	if (netlink_is_kernel(sk))
 		return netlink_unicast_kernel(sk, skb, ssk);
 
+	skb_reset_network_header(skb);
+	skb_reset_mac_header(skb);
 	if (sk_filter(sk, skb)) {
 		err = skb->len;
 		kfree_skb(skb);
@@ -1479,6 +1481,8 @@ static void do_one_broadcast(struct sock *sk,
 		goto out;
 	}
 
+	skb_reset_network_header(p->skb2);
+	skb_reset_mac_header(p->skb2);
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
diff --git a/net/rds/rdma_transport.c b/net/rds/rdma_transport.c
index b15cf316b23a..7be38be1228e 100644
--- a/net/rds/rdma_transport.c
+++ b/net/rds/rdma_transport.c
@@ -52,7 +52,7 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 {
 	/* this can be null in the listening path */
 	struct rds_connection *conn = cm_id->context;
-	struct rds_transport *trans;
+	struct rds_transport *trans = &rds_ib_transport;
 	int ret = 0;
 	int *err;
 	u8 len;
@@ -60,9 +60,6 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 	rdsdebug("conn %p id %p handling event %u (%s)\n", conn, cm_id,
 		 event->event, rdma_event_msg(event->event));
 
-	if (cm_id->device->node_type == RDMA_NODE_IB_CA)
-		trans = &rds_ib_transport;
-
 	/* Prevent shutdown from tearing down the connection
 	 * while we're executing. */
 	if (conn) {
@@ -82,16 +79,47 @@ static int rds_rdma_cm_event_handler_cmn(struct rdma_cm_id *cm_id,
 
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
+		/* Only the IB transport is supported, but RDS listens on
+		 * every RDMA device: reject a request that arrived on any
+		 * other kind.  A non-zero return has rdma_cm destroy the
+		 * request's id, which is what we want here and only here.
+		 */
+		if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+			ret = 1;
+			break;
+		}
 		ret = trans->cm_handle_connect(cm_id, event, isv6);
 		break;
 
 	case RDMA_CM_EVENT_ADDR_RESOLVED:
 		if (conn) {
+			/* The address resolved to a device RDS has no
+			 * transport for.  Do not go on to resolve a route:
+			 * an iWARP route leaves cm_id->route.path_rec
+			 * unset, which the ROUTE_RESOLVED case below
+			 * dereferences.  Drop the connection instead; the
+			 * id is still ic->i_cm_id, so return 0 and let the
+			 * shutdown destroy it.
+			 */
+			if (cm_id->device->node_type != RDMA_NODE_IB_CA) {
+				rds_conn_drop(conn);
+				break;
+			}
 			rdma_set_service_type(cm_id, conn->c_tos);
 			rdma_set_min_rnr_timer(cm_id, IB_RNR_TIMER_000_32);
-			/* XXX do we need to clean up if this fails? */
 			ret = rdma_resolve_route(cm_id,
 						 RDS_RDMA_RESOLVE_TIMEOUT_MS);
+			if (ret) {
+				/* A non-zero return has the rdma_cm destroy
+				 * the id, but it is still ic->i_cm_id, which
+				 * the connection's shutdown would then
+				 * disconnect and destroy again.  Drop the
+				 * connection and keep the id for that
+				 * shutdown.
+				 */
+				rds_conn_drop(conn);
+				ret = 0;
+			}
 		}
 		break;
 
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index a0e8f74ca075..382d6706f2c4 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -372,9 +372,10 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 {
 	struct tcf_idrinfo *idrinfo = p->idrinfo;
 
-	if (refcount_dec_and_mutex_lock(&p->tcfa_refcnt, &idrinfo->lock)) {
-		if (bind)
-			atomic_dec(&p->tcfa_bindcnt);
+	mutex_lock(&idrinfo->lock);
+	if (bind)
+		atomic_dec(&p->tcfa_bindcnt);
+	if (refcount_dec_and_test(&p->tcfa_refcnt)) {
 		idr_remove(&idrinfo->action_idr, p->tcfa_index);
 		mutex_unlock(&idrinfo->lock);
 
@@ -382,9 +383,7 @@ static int __tcf_action_put(struct tc_action *p, bool bind)
 		return 1;
 	}
 
-	if (bind)
-		atomic_dec(&p->tcfa_bindcnt);
-
+	mutex_unlock(&idrinfo->lock);
 	return 0;
 }
 
diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
index 5e61bf334ed8..cf1f94b559f4 100644
--- a/net/sched/cls_flower.c
+++ b/net/sched/cls_flower.c
@@ -1707,6 +1707,11 @@ static int fl_set_enc_opt(struct nlattr **tb, struct fl_flow_key *key,
 			return -EINVAL;
 		}
 		nla_opt_msk = nla_next(nla_opt_msk, &msk_depth);
+
+		if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
+			NL_SET_ERR_MSG(extack, "A mask attribute is invalid");
+			return -EINVAL;
+		}
 	}
 
 	return 0;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 0e7007c545e8..9e89300d5aa2 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1266,7 +1266,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
 			    ipv6_addr_cmp(&ipv6h_check->daddr, &ipv6h->daddr))
 				continue;
 
-			seglen = ntohs(ipv6h_check->payload_len);
+			seglen = ipv6_payload_len(skb, ipv6h_check);
 		} else {
 			continue;
 		}
diff --git a/net/sctp/inqueue.c b/net/sctp/inqueue.c
index 5f988b3a8814..d666cec6b194 100644
--- a/net/sctp/inqueue.c
+++ b/net/sctp/inqueue.c
@@ -212,8 +212,10 @@ struct sctp_chunk *sctp_inq_pop(struct sctp_inq *queue)
 	chunk->chunk_end = ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
 	skb_pull(chunk->skb, sizeof(*ch));
 	chunk->subh.v = NULL; /* Subheader is no longer valid.  */
-
-	if (chunk->chunk_end + sizeof(*ch) <= skb_tail_pointer(chunk->skb)) {
+	if (unlikely(ntohs(ch->length) < sizeof(*ch))) {
+		chunk->pdiscard = 1;
+	} else if (chunk->chunk_end + sizeof(*ch) <=
+		   skb_tail_pointer(chunk->skb)) {
 		/* This is not a singleton */
 		chunk->singleton = 0;
 	} else if (chunk->chunk_end > skb_tail_pointer(chunk->skb)) {
diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index 0559f58c6cab..03588ac5c382 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1785,6 +1785,18 @@ static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
 	return 1;
 }
 
+static int sctp_sendmsg_check_stream(struct sctp_association *asoc,
+				     struct sctp_sndrcvinfo *sinfo)
+{
+	if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt))
+		return -EINVAL;
+
+	if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext))
+		return sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_stream);
+
+	return 0;
+}
+
 static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 				struct msghdr *msg, size_t msg_len,
 				struct sctp_transport *transport,
@@ -1799,16 +1811,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 	long timeo;
 	int err;
 
-	if (sinfo->sinfo_stream >= asoc->stream.outcnt) {
-		err = -EINVAL;
+	err = sctp_sendmsg_check_stream(asoc, sinfo);
+	if (err)
 		goto err;
-	}
-
-	if (unlikely(!SCTP_SO(&asoc->stream, sinfo->sinfo_stream)->ext)) {
-		err = sctp_stream_init_ext(&asoc->stream, sinfo->sinfo_stream);
-		if (err)
-			goto err;
-	}
 
 	if (sp->disable_fragments && msg_len > asoc->frag_point) {
 		err = -EMSGSIZE;
@@ -1829,10 +1834,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 		err = sctp_wait_for_sndbuf(asoc, transport, &timeo, msg_len);
 		if (err)
 			goto err;
-		if (unlikely(sinfo->sinfo_stream >= asoc->stream.outcnt)) {
-			err = -EINVAL;
+		err = sctp_sendmsg_check_stream(asoc, sinfo);
+		if (err)
 			goto err;
-		}
 	}
 
 	if (sctp_state(asoc, CLOSED)) {
@@ -1847,6 +1851,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
 				err = -ESRCH;
 				goto err;
 			}
+			err = sctp_sendmsg_check_stream(asoc, sinfo);
+			if (err) {
+				err = -ESRCH;
+				goto err;
+			}
 		} else {
 			wait_connect = true;
 		}
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 768c5501b42e..4a40cc2e6d1b 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -1333,7 +1333,9 @@ static void tipc_node_reset_links(struct tipc_node *n)
 
 	pr_warn("Resetting all links to %x\n", n->addr);
 
+	tipc_node_write_lock(n);
 	trace_tipc_node_reset_links(n, true, " ");
+	tipc_node_write_unlock_fast(n);
 	for (i = 0; i < MAX_BEARERS; i++) {
 		tipc_node_link_down(n, i, false);
 	}
diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index a540b3d29f9b..049bd852e689 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -335,6 +335,38 @@ struct sock *vsock_find_connected_socket(struct sockaddr_vm *src,
 }
 EXPORT_SYMBOL_GPL(vsock_find_connected_socket);
 
+/**
+ * vsock_check_source - validate a packet source against a socket peer
+ * @vsk: socket receiving the packet
+ * @transport: transport receiving the packet
+ * @src: source address from the packet
+ *
+ * Return: true if the packet arrived on the socket's assigned transport and
+ * its source matches the stored peer. Loopback packets are generated
+ * internally and always use the local CID as their source, including
+ * connections using a valid CID alias.
+ *
+ * The caller must hold the socket lock and must not call this for listening
+ * sockets, which accept packets from any source and have no assigned
+ * transport.
+ */
+bool vsock_check_source(const struct vsock_sock *vsk,
+			const struct vsock_transport *transport,
+			const struct sockaddr_vm *src)
+{
+	if (vsk->transport != transport)
+		return false;
+
+	if (src->svm_port != vsk->remote_addr.svm_port)
+		return false;
+
+	if (src->svm_cid == vsk->remote_addr.svm_cid)
+		return true;
+
+	return transport->get_local_cid() == VMADDR_CID_LOCAL;
+}
+EXPORT_SYMBOL_GPL(vsock_check_source);
+
 void vsock_remove_sock(struct vsock_sock *vsk)
 {
 	/* Transport reassignment must not remove the binding. */
@@ -1678,23 +1710,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
 		timeout = schedule_timeout(timeout);
 		lock_sock(sk);
 
-		/* Connection established. Whatever happens to socket once we
-		 * release it, that's not connect()'s concern. No need to go
+		/* Connection was established. Whatever happens to socket once
+		 * we release it, that's not connect()'s concern. No need to go
 		 * into signal and timeout handling. Call it a day.
 		 *
 		 * Note that allowing to "reset" an already established socket
 		 * here is racy and insecure.
 		 */
-		if (sk->sk_state == TCP_ESTABLISHED)
-			break;
+		if (sk->sk_state == TCP_ESTABLISHED ||
+		    sk->sk_state == TCP_CLOSING) {
+			err = 0;
+			goto out_wait;
+		}
 
 		/* If connection was _not_ established and a signal/timeout came
 		 * to be, we want the socket's state reset. User space may want
-		 * to retry.
-		 *
-		 * sk_state != TCP_ESTABLISHED implies that socket is not on
-		 * vsock_connected_table. We keep the binding and the transport
-		 * assigned.
+		 * to retry, so we keep the binding and the transport assigned.
 		 */
 		if (signal_pending(current) || timeout == 0) {
 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 829feae9c0e0..9010d1a1535c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1312,6 +1312,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 		.op = VIRTIO_VSOCK_OP_RST,
 		.type = le16_to_cpu(hdr->type),
 		.reply = true,
+
+		/* Set sk owner to socket we are replying to (may be NULL for
+		 * non-loopback). This keeps a reference to the sock and
+		 * sock_net(sk) until the reply skb is freed.
+		 */
+		.vsk = vsock_sk(skb->sk),
 	};
 	struct sk_buff *reply;
 
@@ -1813,7 +1819,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
index 4f02a6f269cd..df0c472f9dd6 100644
--- a/net/vmw_vsock/vmci_transport.c
+++ b/net/vmw_vsock/vmci_transport.c
@@ -676,11 +676,13 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	struct vmci_transport_packet *pkt;
 	struct vsock_sock *vsk;
 	bool bh_process_pkt;
+	bool drop_pkt;
 	int err;
 
 	sk = NULL;
 	err = VMCI_SUCCESS;
 	bh_process_pkt = false;
+	drop_pkt = false;
 
 	/* Ignore incoming packets from contexts without sockets, or resources
 	 * that aren't vsock implementations.
@@ -757,17 +759,32 @@ static int vmci_transport_recv_stream_cb(void *data, struct vmci_datagram *dg)
 	bh_lock_sock(sk);
 
 	if (!sock_owned_by_user(sk)) {
-		/* The local context ID may be out of date, update it. */
-		vsk->local_addr.svm_cid = dst.svm_cid;
+		if (sk->sk_state != TCP_LISTEN &&
+		    (vsk->transport != &vmci_transport ||
+		     src.svm_port != vsk->remote_addr.svm_port ||
+		     (src.svm_cid != vsk->remote_addr.svm_cid &&
+		      vmci_transport.get_local_cid() != VMADDR_CID_LOCAL))) {
+			drop_pkt = true;
+			err = VMCI_ERROR_NO_ACCESS;
+		} else {
+			/* The local context ID may be out of date, update it. */
+			vsk->local_addr.svm_cid = dst.svm_cid;
 
-		if (sk->sk_state == TCP_ESTABLISHED)
-			vmci_trans(vsk)->notify_ops->handle_notify_pkt(
-					sk, pkt, true, &dst, &src,
-					&bh_process_pkt);
+			if (sk->sk_state == TCP_ESTABLISHED)
+				vmci_trans(vsk)->notify_ops->handle_notify_pkt(sk, pkt, true,
+									       &dst, &src,
+									       &bh_process_pkt);
+		}
 	}
 
 	bh_unlock_sock(sk);
 
+	if (drop_pkt) {
+		if (vmci_transport_send_reset_bh(&dst, &src, pkt) < 0)
+			pr_err("unable to send reset\n");
+		goto out;
+	}
+
 	if (!bh_process_pkt) {
 		struct vmci_transport_recv_pkt_info *recv_pkt_info;
 
@@ -892,6 +909,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 {
 	struct vmci_transport_recv_pkt_info *recv_pkt_info;
 	struct vmci_transport_packet *pkt;
+	struct sockaddr_vm src;
 	struct sock *sk;
 
 	recv_pkt_info =
@@ -900,6 +918,15 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 	pkt = &recv_pkt_info->pkt;
 
 	lock_sock(sk);
+	vsock_addr_init(&src, pkt->dg.src.context, pkt->src_port);
+	if (sk->sk_state != TCP_LISTEN &&
+	    (vsock_sk(sk)->transport != &vmci_transport ||
+	     src.svm_port != vsock_sk(sk)->remote_addr.svm_port ||
+	     (src.svm_cid != vsock_sk(sk)->remote_addr.svm_cid &&
+	      vmci_transport.get_local_cid() != VMADDR_CID_LOCAL))) {
+		vmci_transport_reply_reset(pkt);
+		goto out;
+	}
 
 	/* The local context ID may be out of date. */
 	vsock_sk(sk)->local_addr.svm_cid = pkt->dg.dst.context;
@@ -929,6 +956,7 @@ static void vmci_transport_recv_pkt_work(struct work_struct *work)
 		break;
 	}
 
+out:
 	release_sock(sk);
 	kfree(recv_pkt_info);
 	/* Release reference obtained in the stream callback when we fetched
diff --git a/samples/pidfd/Makefile b/samples/pidfd/Makefile
index 9754e2d81f70..d82409f7061f 100644
--- a/samples/pidfd/Makefile
+++ b/samples/pidfd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-usertprogs-always-y += pidfd-metadata
+userprogs-always-y += pidfd-metadata
 
 userccflags += -I usr/include
diff --git a/sound/pci/ctxfi/ctatc.c b/sound/pci/ctxfi/ctatc.c
index 7cb33d7c43d2..da728549ce42 100644
--- a/sound/pci/ctxfi/ctatc.c
+++ b/sound/pci/ctxfi/ctatc.c
@@ -981,6 +981,11 @@ static int atc_select_mic_in(struct ct_atc *atc)
 	return 0;
 }
 
+static inline enum DAIOTYP atc_spdif_in_type(struct ct_atc *atc)
+{
+	return (atc->model == CTSB073X) ? SPDIFI_BAY : SPDIFIO;
+}
+
 static struct capabilities atc_capabilities(struct ct_atc *atc)
 {
 	struct hw *hw = atc->hw;
@@ -1096,7 +1101,7 @@ static int atc_spdif_out_unmute(struct ct_atc *atc, unsigned char state)
 
 static int atc_spdif_in_unmute(struct ct_atc *atc, unsigned char state)
 {
-	return atc_daio_unmute(atc, state, SPDIFIO);
+	return atc_daio_unmute(atc, state, atc_spdif_in_type(atc));
 }
 
 static int atc_spdif_out_get_status(struct ct_atc *atc, unsigned int *status)
@@ -1401,10 +1406,11 @@ static int atc_get_resources(struct ct_atc *atc)
 	daio_mgr = (struct daio_mgr *)atc->rsc_mgrs[DAIO];
 	da_desc.msr = atc->msr;
 	for (i = 0; i < NUM_DAIOTYP; i++) {
-		if ((i == MIC) && !cap.dedicated_mic)
+		if (((i == SPDIFIO) && (atc->model == CTSB073X)) ||
+			((i == SPDIFI_BAY) && (atc->model != CTSB073X)) ||
+			((i == MIC) && !cap.dedicated_mic))
 			continue;
-		da_desc.type = (atc->model != CTSB073X) ? i :
-			     ((i == SPDIFIO) ? SPDIFI1 : i);
+		da_desc.type = i;
 		da_desc.output = i < LINEIM;
 		err = daio_mgr->get_daio(daio_mgr, &da_desc,
 					(struct daio **)&atc->daios[i]);
@@ -1533,7 +1539,7 @@ static void atc_connect_resources(struct ct_atc *atc)
 		mixer->set_input_right(mixer, MIX_MIC_IN, &src->rsc);
 	}
 
-	dai = container_of(atc->daios[SPDIFIO], struct dai, daio);
+	dai = container_of(atc->daios[atc_spdif_in_type(atc)], struct dai, daio);
 	atc_connect_dai(atc->rsc_mgrs[SRC], dai,
 			(struct src **)&atc->srcs[0],
 			(struct srcimp **)&atc->srcimps[0]);
diff --git a/sound/pci/ctxfi/ctdaio.c b/sound/pci/ctxfi/ctdaio.c
index fe40fcee3673..1c12fffce1a2 100644
--- a/sound/pci/ctxfi/ctdaio.c
+++ b/sound/pci/ctxfi/ctdaio.c
@@ -35,7 +35,7 @@ static const struct daio_rsc_idx idx_20k1[NUM_DAIOTYP] = {
 	[LINEIM] = {.left = 0x1b5, .right = 0x1bd},
 	[SPDIFOO] = {.left = 0x20, .right = 0x21},
 	[SPDIFIO] = {.left = 0x15, .right = 0x1d},
-	[SPDIFI1] = {.left = 0x95, .right = 0x9d},
+	[SPDIFI_BAY] = {.left = 0x95, .right = 0x9d},
 };
 
 static const struct daio_rsc_idx idx_20k2[NUM_DAIOTYP] = {
@@ -105,7 +105,7 @@ static int daio_device_index(enum DAIOTYP type, struct hw *hw)
 		switch (type) {
 		case SPDIFOO:	return 0;
 		case SPDIFIO:	return 0;
-		case SPDIFI1:	return 1;
+		case SPDIFI_BAY:	return 1;
 		case LINEO1:	return 4;
 		case LINEO2:	return 7;
 		case LINEO3:	return 5;
@@ -119,7 +119,6 @@ static int daio_device_index(enum DAIOTYP type, struct hw *hw)
 		switch (type) {
 		case SPDIFOO:	return 0;
 		case SPDIFIO:	return 0;
-		case SPDIFI1:	return 1;
 		case LINEO1:	return 4;
 		case LINEO2:	return 7;
 		case LINEO3:	return 5;
diff --git a/sound/pci/ctxfi/ctdaio.h b/sound/pci/ctxfi/ctdaio.h
index b337da2de8b5..cc2e93a3edda 100644
--- a/sound/pci/ctxfi/ctdaio.h
+++ b/sound/pci/ctxfi/ctdaio.h
@@ -31,7 +31,7 @@ enum DAIOTYP {
 	LINEIM,
 	SPDIFIO,	/* S/PDIF In (Flexijack/Optical) on the card */
 	MIC,		/* Dedicated mic on Titanium HD */
-	SPDIFI1,	/* S/PDIF In on internal Drive Bay */
+	SPDIFI_BAY,	/* S/PDIF In on internal drive bay */
 	NUM_DAIOTYP
 };
 
diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
index 1140ed1cbb3d..b72b7ae1a256 100644
--- a/sound/soc/amd/yc/pci-acp6x.c
+++ b/sound/soc/amd/yc/pci-acp6x.c
@@ -289,7 +289,7 @@ static int snd_acp6x_suspend(struct device *dev)
 	return ret;
 }
 
-static int snd_acp6x_resume(struct device *dev)
+static int snd_acp6x_runtime_resume(struct device *dev)
 {
 	struct acp6x_dev_data *adata;
 	int ret;
@@ -301,8 +301,42 @@ static int snd_acp6x_resume(struct device *dev)
 	return ret;
 }
 
+static void acp6x_disable_msi_on_resume(struct pci_dev *pdev)
+{
+	u16 control;
+
+	if (!pdev->msi_cap)
+		return;
+
+	pci_read_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS, &control);
+	if (control & PCI_MSI_FLAGS_ENABLE) {
+		dev_warn(&pdev->dev,
+			 "ACP: MSI unexpectedly enabled after resume (flags=0x%04x), disabling\n",
+			 control);
+		control &= ~PCI_MSI_FLAGS_ENABLE;
+		pci_write_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS, control);
+	}
+}
+
+static int snd_acp6x_resume(struct device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	/*
+	 * BIOS/firmware may re-enable MSI in PCI config space during
+	 * system resume even though this driver only uses legacy INTx
+	 * interrupts. If MSI is left enabled with stale address/data
+	 * registers, the device will write interrupts to a bogus address
+	 * causing IOMMU IO_PAGE_FAULT and interrupt delivery failure.
+	 * Explicitly clear the MSI Enable bit before reinitializing
+	 * the ACP hardware.
+	 */
+	acp6x_disable_msi_on_resume(pdev);
+	return snd_acp6x_runtime_resume(dev);
+}
+
 static const struct dev_pm_ops acp6x_pm = {
-	RUNTIME_PM_OPS(snd_acp6x_suspend, snd_acp6x_resume, NULL)
+	RUNTIME_PM_OPS(snd_acp6x_suspend, snd_acp6x_runtime_resume, NULL)
 	SYSTEM_SLEEP_PM_OPS(snd_acp6x_suspend, snd_acp6x_resume)
 };
 
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index a9ffba62aaf8..4a7cfd52e583 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -290,7 +290,7 @@ static const char * const cs42l52_ng_type_text[] = {
 };
 
 static SOC_ENUM_SINGLE_DECL(ng_type_enum,
-			    CS42L52_NOISE_GATE_CTL, 6,
+			    CS42L52_NOISE_GATE_CTL, 7,
 			    cs42l52_ng_type_text);
 
 static const char * const left_swap_text[] = {
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 98fa812bc07b..4e46b8ba9248 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -481,7 +481,7 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
 			0, 0x3f, 0, 0),
 	SOC_SINGLE_TLV("Limiter MAX", CS42L56_LIM_THRESHOLD_CTL,
 			5, 0x07, 1, alc_tlv),
-	SOC_SINGLE_TLV("Limiter Cushion", CS42L56_ALC_THRESHOLD,
+	SOC_SINGLE_TLV("Limiter Cushion", CS42L56_LIM_THRESHOLD_CTL,
 			2, 0x07, 1, alc_tlv),
 
 	SOC_SINGLE("NG Switch", CS42L56_NOISE_GATE_CTL, 6, 1, 1),
diff --git a/sound/soc/codecs/max98371.c b/sound/soc/codecs/max98371.c
index 852db211ba1e..c53f76f0ade7 100644
--- a/sound/soc/codecs/max98371.c
+++ b/sound/soc/codecs/max98371.c
@@ -166,7 +166,7 @@ static const struct snd_kcontrol_new max98371_snd_controls[] = {
 			0, (1<<MAX98371_DHT_MAX_WIDTH)-1, 0,
 			max98371_dht_max_gain),
 	SOC_SINGLE_TLV("Speaker DHT Min Volume", MAX98371_DHT_GAIN,
-			0, (1<<MAX98371_DHT_GAIN_WIDTH)-1, 0,
+			4, (1<<MAX98371_DHT_GAIN_WIDTH)-1, 0,
 			max98371_dht_min_gain),
 	SOC_SINGLE_TLV("Speaker DHT Rotation Volume", MAX98371_DHT_GAIN,
 			0, (1<<MAX98371_DHT_ROT_WIDTH)-1, 0,
diff --git a/sound/soc/codecs/nau8822.c b/sound/soc/codecs/nau8822.c
index 15d6f8d01f78..1386ba604199 100644
--- a/sound/soc/codecs/nau8822.c
+++ b/sound/soc/codecs/nau8822.c
@@ -380,9 +380,9 @@ static const struct snd_kcontrol_new nau8822_snd_controls[] = {
 		NAU8822_REG_RIGHT_ADC_BOOST_CONTROL, 0, 7, 0, boost_tlv),
 
 	SOC_SINGLE("DAC 128x Oversampling Switch",
-		NAU8822_REG_DAC_CONTROL, 5, 1, 0),
+		NAU8822_REG_DAC_CONTROL, 3, 1, 0),
 	SOC_SINGLE("ADC 128x Oversampling Switch",
-		NAU8822_REG_ADC_CONTROL, 5, 1, 0),
+		NAU8822_REG_ADC_CONTROL, 3, 1, 0),
 };
 
 /* LMAIN and RMAIN Mixer */
diff --git a/sound/soc/codecs/pcm3168a.c b/sound/soc/codecs/pcm3168a.c
index 2066cf6c1e97..68d914148bf3 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -103,7 +103,7 @@ static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_func, PCM3168A_DAC_ATT_DEMP_ZF,
 static const char *const pcm3168a_pol[] = { "Active High", "Active Low" };
 
 static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_pol, PCM3168A_DAC_ATT_DEMP_ZF,
-		PCM3168A_DAC_ATSPDA_SHIFT, pcm3168a_pol);
+		PCM3168A_DAC_ZREV_SHIFT, pcm3168a_pol);
 
 static const char *const pcm3168a_con[] = { "Differential", "Single-Ended" };
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 8c45ba6fc4c3..e9ef9bf4be09 100644
--- a/sound/soc/codecs/wm8978.c
+++ b/sound/soc/codecs/wm8978.c
@@ -255,9 +255,9 @@ static const struct snd_kcontrol_new wm8978_snd_controls[] = {
 
 	/* DAC / ADC oversampling */
 	SOC_SINGLE("DAC 128x Oversampling Switch", WM8978_DAC_CONTROL,
-		   5, 1, 0),
+		   3, 1, 0),
 	SOC_SINGLE("ADC 128x Oversampling Switch", WM8978_ADC_CONTROL,
-		   5, 1, 0),
+		   3, 1, 0),
 };
 
 /* Mixer #1: Output (OUT1, OUT2) Mixer: mix AUX, Input mixer output and DAC */
diff --git a/sound/soc/intel/avs/pcm.c b/sound/soc/intel/avs/pcm.c
index a2c05a4ced72..8f09d539e224 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -756,7 +756,7 @@ static int avs_dai_fe_prepare(struct snd_pcm_substream *substream, struct snd_so
 	data = snd_soc_dai_get_dma_data(dai, substream);
 	host_stream = data->host_stream;
 
-	if (runtime->state == SNDRV_PCM_STATE_XRUN)
+	if (runtime->state != SNDRV_PCM_STATE_PREPARED)
 		hdac_stream(host_stream)->prepared = false;
 	if (hdac_stream(host_stream)->prepared)
 		return 0;
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 5701e4d1ac13..7178279ddfb7 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2286,8 +2286,20 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 				ch_map >>= 4;
 			}
 
-			step = ch_count / blob->alh_cfg.device_count;
-			mask =  GENMASK(step - 1, 0);
+			if (ch_count < blob->alh_cfg.device_count) {
+				/*
+				 * When there are fewer channels than aggregated devices
+				 * (e.g. a mono capture stream split across multiple links),
+				 * set step = 0 to ensure all the ch_mask is applied to all
+				 * alh mappings.
+				 */
+				mask = ch_mask;
+				step = 0;
+			} else {
+				step = ch_count / blob->alh_cfg.device_count;
+				mask =  GENMASK(step - 1, 0);
+			}
+
 			/*
 			 * Set each gtw_cfg.node_id to blob->alh_cfg.mapping[]
 			 * for all widgets with the same stream name
diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 57b711c44278..47cd3efcadc1 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -728,7 +728,7 @@ static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
 
 	if (err) {
 		regmap_read(spdifrx->regmap, STM32_SPDIFRX_CR, &cr);
-		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) &&
+		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) ==
 			     SPDIFRX_SPDIFEN_SYNC;
 
 		/* SPDIFRX is in STATE_STOP. Disable SPDIFRX to clear errors */
diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
index bf455757aab9..6f5d60045f90 100644
--- a/tools/bootconfig/main.c
+++ b/tools/bootconfig/main.c
@@ -458,7 +458,8 @@ static int apply_xbc(const char *path, const char *xbc_path)
 	footer.size = htole32(size);
 	footer.csum = htole32(csum);
 	memcpy(footer.magic, BOOTCONFIG_MAGIC, BOOTCONFIG_MAGIC_LEN);
-	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE);
+	static_assert(sizeof(footer) == BOOTCONFIG_FOOTER_SIZE,
+		      "bootconfig footer size mismatch");
 	memcpy(data + size, &footer, BOOTCONFIG_FOOTER_SIZE);
 
 	total_size = size + BOOTCONFIG_FOOTER_SIZE;
diff --git a/tools/gpio/Makefile b/tools/gpio/Makefile
index 342e056c8c66..1cd7636b9cac 100644
--- a/tools/gpio/Makefile
+++ b/tools/gpio/Makefile
@@ -7,7 +7,13 @@ bindir ?= /usr/bin
 # isn't set and when invoked from selftests build, where srctree
 # is set to ".". building_out_of_srctree is undefined for in srctree
 # builds
+ifeq ($(srctree),)
+update_srctree := 1
+endif
 ifndef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 313872f64a9a..3bab2677b067 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -1919,8 +1919,11 @@ const struct dirent *pmt_diriter_begin(struct pmt_diriter_t *iter, const char *p
 			return NULL;
 
 		num_names = scandir(pmt_root_path, &iter->namelist, pmt_telemdir_filter, pmt_telemdir_sort);
-		if (num_names == -1)
+		if (num_names == -1) {
+			closedir(iter->dir);
+			iter->dir = NULL;
 			return NULL;
+		}
 	}
 
 	iter->current_name_idx = 0;
@@ -1948,8 +1951,10 @@ void pmt_diriter_remove(struct pmt_diriter_t *iter)
 	iter->num_names = 0;
 	iter->current_name_idx = 0;
 
-	closedir(iter->dir);
-	iter->dir = NULL;
+	if (iter->dir) {
+		closedir(iter->dir);
+		iter->dir = NULL;
+	}
 }
 
 unsigned int pmt_counter_get_width(const struct pmt_counter *p)
@@ -5768,7 +5773,7 @@ void free_fd_msr(void)
 	if (!msr_counter_info)
 		return;
 
-	for (int cpu = 0; cpu < topo.max_cpu_num; ++cpu) {
+	for (int cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
 		if (msr_counter_info[cpu].fd_perf != -1)
 			close(msr_counter_info[cpu].fd_perf);
 	}
@@ -9961,7 +9966,7 @@ void pmt_init(void)
 		mod_num = 0;	/* Relative module number for current PMT file. */
 
 		/* Open the counter for each CPU. */
-		for (cpu_num = 0; cpu_num < topo.max_cpu_num;) {
+		for (cpu_num = 0; cpu_num <= topo.max_cpu_num;) {
 
 			if (cpu_is_not_allowed(cpu_num))
 				goto next_loop_iter;
@@ -10190,10 +10195,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_thread_counters++ >= MAX_ADDED_THREAD_COUNTERS) {
+		if (sys.added_thread_counters >= MAX_ADDED_THREAD_COUNTERS) {
 			warnx("ignoring thread counter %s", name);
 			return -1;
 		}
+		sys.added_thread_counters++;
 		break;
 	case SCOPE_CORE:
 		msrp = find_msrp_by_name(sys.cp, name);
@@ -10202,10 +10208,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_core_counters++ >= MAX_ADDED_CORE_COUNTERS) {
+		if (sys.added_core_counters >= MAX_ADDED_CORE_COUNTERS) {
 			warnx("ignoring core counter %s", name);
 			return -1;
 		}
+		sys.added_core_counters++;
 		break;
 	case SCOPE_PACKAGE:
 		msrp = find_msrp_by_name(sys.pp, name);
@@ -10214,10 +10221,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
 				fprintf(stderr, "%s: %s FOUND\n", __func__, name);
 			break;
 		}
-		if (sys.added_package_counters++ >= MAX_ADDED_PACKAGE_COUNTERS) {
+		if (sys.added_package_counters >= MAX_ADDED_PACKAGE_COUNTERS) {
 			warnx("ignoring package counter %s", name);
 			return -1;
 		}
+		sys.added_package_counters++;
 		break;
 	default:
 		warnx("ignoring counter %s with unknown scope", name);
