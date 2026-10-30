Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365091;
	b=dlphovBk61efD/R1WngBadU6M0Kb9/+2/Paiydo7wYmn/gpXU5u/e4gXSOJmY4Vv/5hc
	 vaPBLfPVBbZpgIw6hUW/wvF6py2jadbx5/cT3FBFsQGMILqpz9jsokUyv9Z2QJbgQnX1g
	 u7a1XsVz9vKfpdSKvFlqHO6TkPDxG9zPPRl/u4IVrZJcOjoX9EeETg4crG15/v4ZLmn5C
	 ft5HPbWD/Uja3Y9gp6+nmTIMV+Ur7Omb2UkmnFzUJ1GUrEgP0zX5RpBuZDhpi11+BR2dI
	 ZdNUTzDHJ48oDTbEUoWa2iiCmlHamMKndGWDuL9G2dIsZ+n2MIcl80ehe1jW+AVt0dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365091;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nr2poFoMvvJOEs9J5T9w49KLVyT7hxGdGiKW6jCRoc4=;
	b=RsiSo0K8cmdORFd5T5WfA7QHY5VkX3++AGuayGF4u70jRPFGcQWNOQpU0UT7NH0E0oaK
	 Ivr0zorEOOsWShlJcsq2Q7c62YzWcTAzaVEmDPPNpjBakCH+7DCZGHtLa3Myawe7ry67k
	 tN81c4FJx+MTCeCS4Ppu2ac/smxAcfGRfnth5s2qVH2WlYONhcrP7FZNTfWJC8Obzq6Sn
	 mcf/ZNE+pK6AuOVLJ1AbhA7HUsqV5bkZejP517roE696KTpGKDsanXqu+0D0h5WGnfPKz
	 aBbo1Zy2Zr1JwNN6DeqrWz+RUiIZQ96eQPkNvdZS64r7YZmMGGx7/FJ5rHAMJG5ufpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PnqqQciT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC0160A2635;
	Fri, 30 Oct 2026 12:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PnqqQciT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 742E61F00A1D;
	Fri, 30 Oct 2026 12:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793365089;
	bh=nr2poFoMvvJOEs9J5T9w49KLVyT7hxGdGiKW6jCRoc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PnqqQciTms2otTvmaaW0T5qykTsnjjWY6kn5FBYQ2/P4gs3hgYDYXlAUCO5TcESzV
	 2YHMO1iYr867ZJJkAIoY4y0+rQCF6eR3MXxhigDRlwZmCvEPAdhFl0k3/3fX9bsxit
	 toQVipNX3FoO0s5oWBzxoHAtJfscfuscwApdovVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.12.115
Date: Fri, 30 Oct 2026 13:57:59 +0100
Message-ID: <2026103058-nape-steering-fa5c@gregkh>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026103058-gestation-hyphen-79df@gregkh>
References: <2026103058-gestation-hyphen-79df@gregkh>
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

diff --git a/Makefile b/Makefile
index fe02bbac2151..82dfb3e137ea 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 12
-SUBLEVEL = 114
+SUBLEVEL = 115
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
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
diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index 2d03af60ed88..f907e916aa20 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -443,17 +443,10 @@ void do_secure_storage_access(struct pt_regs *regs)
 		folio = phys_to_folio(addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-		rc = uv_convert_from_secure(folio_to_phys(folio));
-		if (!rc)
-			clear_bit(PG_arch_1, &folio->flags.f);
+		rc = arch_make_folio_accessible(folio);
 		folio_put(folio);
-		/*
-		 * There are some valid fixup types for kernel
-		 * accesses to donated secure memory. zeropad is one
-		 * of them.
-		 */
 		if (rc)
-			return handle_fault_error_nolock(regs, 0);
+			BUG();
 	} else {
 		if (faulthandler_disabled())
 			return handle_fault_error_nolock(regs, 0);
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index 56df97850c94..08511c173834 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -150,6 +150,9 @@ static ssize_t report_error_write(struct file *filp, struct kobject *kobj,
 	if (off || (count < sizeof(*report)))
 		return -EINVAL;
 
+	if (count < (report->length + sizeof(*report)))
+		return -EINVAL;
+
 	ret = sclp_pci_report(report, zdev->fh, zdev->fid);
 
 	return ret ? ret : count;
diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 5d7e5b53e33e..733802ffcc66 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -750,7 +750,8 @@ int hv_apicid_to_vp_index(u32 apic_id)
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	/* Treat input as having 2 APIC IDs so output is 64-bit aligned */
+	output = (void *)input + struct_size(input, apic_ids, 2);
 
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index a4c78026eea0..2c5f1afd58ea 100644
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
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index ab6d3f565b0a..1dfc568631e2 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2500,7 +2500,9 @@ static int mmu_page_zap_pte(struct kvm *kvm, struct kvm_mmu_page *sp,
 			 * avoids retaining a large number of stale nested SPs.
 			 */
 			if (tdp_enabled && invalid_list &&
-			    child->role.guest_mode && !child->parent_ptes.val)
+			    child->role.guest_mode &&
+			    !child->root_count &&
+			    !child->parent_ptes.val)
 				return kvm_mmu_prepare_zap_page(kvm, child,
 								invalid_list);
 		}
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index bd9f41a78ec1..a107b2a6d115 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3689,8 +3689,10 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 vmentry_fail_vmexit:
 	vmx_switch_vmcs(vcpu, &vmx->vmcs01);
 
-	if (!from_vmentry)
+	if (!from_vmentry) {
+		nested_ept_uninit_mmu_context(vcpu);
 		return NVMX_VMENTRY_VMEXIT;
+	}
 
 	kvm_vcpu_unmap(vcpu, &vmx->nested.apic_access_page_map, false);
 	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e3d6e7a18868..d6f7e487bfe5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -1408,11 +1408,20 @@ static int disk_alloc_zone_resources(struct gendisk *disk,
 	if (!disk->zone_wplugs_pool)
 		goto free_hash;
 
-	disk->zone_wplugs_wq =
-		alloc_workqueue("%s_zwplugs", WQ_MEM_RECLAIM | WQ_HIGHPRI,
-				pool_size, disk->disk_name);
-	if (!disk->zone_wplugs_wq)
-		goto destroy_pool;
+	/*
+	 * We may already have a zone write plug workqueue as this function may
+	 * be called after disk_free_zone_resources(), which does not destroy
+	 * the workqueue (the zone write plugs workqueue is destroyed at
+	 * disk_release() time).
+	 */
+	if (!disk->zone_wplugs_wq) {
+		disk->zone_wplugs_wq =
+			alloc_workqueue("%s_zwplugs",
+					WQ_MEM_RECLAIM | WQ_HIGHPRI,
+					pool_size, disk->disk_name);
+		if (!disk->zone_wplugs_wq)
+			goto destroy_pool;
+	}
 
 	return 0;
 
@@ -1469,15 +1478,13 @@ static unsigned int disk_set_conv_zones_bitmap(struct gendisk *disk,
 	return nr_conv_zones;
 }
 
-void disk_free_zone_resources(struct gendisk *disk)
+static void disk_free_zone_resources(struct gendisk *disk)
 {
 	if (!disk->zone_wplugs_pool)
 		return;
 
-	if (disk->zone_wplugs_wq) {
-		destroy_workqueue(disk->zone_wplugs_wq);
-		disk->zone_wplugs_wq = NULL;
-	}
+	if (disk->zone_wplugs_wq)
+		drain_workqueue(disk->zone_wplugs_wq);
 
 	disk_destroy_zone_wplugs_hash_table(disk);
 
@@ -1496,6 +1503,16 @@ void disk_free_zone_resources(struct gendisk *disk)
 	disk->nr_zones = 0;
 }
 
+void disk_release_zone_resources(struct gendisk *disk)
+{
+	if (disk->zone_wplugs_wq) {
+		destroy_workqueue(disk->zone_wplugs_wq);
+		disk->zone_wplugs_wq = NULL;
+	}
+
+	disk_free_zone_resources(disk);
+}
+
 static inline bool disk_need_zone_resources(struct gendisk *disk)
 {
 	/*
diff --git a/block/blk.h b/block/blk.h
index b3a7e518d799..4500ba33dc7a 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -489,7 +489,7 @@ static inline struct bio *blk_queue_bounce(struct bio *bio,
 
 #ifdef CONFIG_BLK_DEV_ZONED
 void disk_init_zone_resources(struct gendisk *disk);
-void disk_free_zone_resources(struct gendisk *disk);
+void disk_release_zone_resources(struct gendisk *disk);
 static inline bool bio_zone_write_plugging(struct bio *bio)
 {
 	return bio_flagged(bio, BIO_ZONE_WRITE_PLUGGING);
@@ -550,7 +550,7 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, blk_mode_t mode,
 static inline void disk_init_zone_resources(struct gendisk *disk)
 {
 }
-static inline void disk_free_zone_resources(struct gendisk *disk)
+static inline void disk_release_zone_resources(struct gendisk *disk)
 {
 }
 static inline bool bio_zone_write_plugging(struct bio *bio)
diff --git a/block/bsg-lib.c b/block/bsg-lib.c
index 32da4a4429ce..d84fff80159f 100644
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
diff --git a/block/genhd.c b/block/genhd.c
index f4f18ca70aa0..4063ee78c27b 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1219,7 +1219,7 @@ static void disk_release(struct device *dev)
 
 	disk_release_events(disk);
 	kfree(disk->random);
-	disk_free_zone_resources(disk);
+	disk_release_zone_resources(disk);
 	xa_destroy(&disk->part_tbl);
 
 	disk->queue->disk = NULL;
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index afcd4d101ac5..4988c4ab9722 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -240,10 +240,14 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			if (IS_ERR(key))
 				key = NULL;
 		} else if (trusted->type == &key_type_asymmetric) {
+			const struct asymmetric_key_ids *kids;
 			const struct asymmetric_key_id **signer_ids;
 
-			signer_ids = (const struct asymmetric_key_id **)
-				asymmetric_key_ids(trusted)->id;
+			kids = asymmetric_key_ids(trusted);
+			if (!kids)
+				return -ENOKEY;
+
+			signer_ids = (const struct asymmetric_key_id **)kids->id;
 
 			/*
 			 * The auth_ids come from the candidate key (the
diff --git a/drivers/base/regmap/internal.h b/drivers/base/regmap/internal.h
index bdb450436cbc..e3ce87ffdd8c 100644
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
index 34440e188f92..82d941059165 100644
--- a/drivers/base/regmap/regcache-maple.c
+++ b/drivers/base/regmap/regcache-maple.c
@@ -296,16 +296,21 @@ static int regcache_maple_exit(struct regmap *map)
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
index d3659ba3cc11..5592cd704cf0 100644
--- a/drivers/base/regmap/regcache.c
+++ b/drivers/base/regmap/regcache.c
@@ -195,14 +195,26 @@ int regcache_init(struct regmap *map, const struct regmap_config *config)
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
@@ -225,9 +237,7 @@ void regcache_exit(struct regmap *map)
 	if (map->cache_ops->exit) {
 		dev_dbg(map->dev, "Destroying %s cache\n",
 			map->cache_ops->name);
-		map->lock(map->lock_arg);
 		map->cache_ops->exit(map);
-		map->unlock(map->lock_arg);
 	}
 }
 
diff --git a/drivers/gpio/gpio-mxc.c b/drivers/gpio/gpio-mxc.c
index a61bc17b2708..30e03acbe859 100644
--- a/drivers/gpio/gpio-mxc.c
+++ b/drivers/gpio/gpio-mxc.c
@@ -7,6 +7,8 @@
 // Authors: Daniel Mack, Juergen Beisert.
 // Copyright (C) 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
 
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/err.h>
 #include <linux/init.h>
@@ -66,11 +68,11 @@ struct mxc_gpio_port {
 	struct irq_domain *domain;
 	struct gpio_chip gc;
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
@@ -161,13 +163,12 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct mxc_gpio_port *port = gc->private;
-	unsigned long flags;
 	u32 bit, val;
 	u32 gpio_idx = d->hwirq;
 	int edge;
 	void __iomem *reg = port->base;
 
-	port->both_edges &= ~(1 << gpio_idx);
+	clear_bit(gpio_idx, &port->both_edges);
 	switch (type) {
 	case IRQ_TYPE_EDGE_RISING:
 		edge = GPIO_INT_RISE_EDGE;
@@ -187,7 +188,7 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 				edge = GPIO_INT_HIGH_LEV;
 				pr_debug("mxc: set GPIO %d to high trigger\n", gpio_idx);
 			}
-			port->both_edges |= 1 << gpio_idx;
+			set_bit(gpio_idx, &port->both_edges);
 		}
 		break;
 	case IRQ_TYPE_LEVEL_LOW:
@@ -200,41 +201,38 @@ static int gpio_set_irq_type(struct irq_data *d, u32 type)
 		return -EINVAL;
 	}
 
-	raw_spin_lock_irqsave(&port->gc.bgpio_lock, flags);
+	scoped_guard(raw_spinlock_irqsave, &port->gc.bgpio_lock) {
+		if (GPIO_EDGE_SEL >= 0) {
+			val = readl(port->base + GPIO_EDGE_SEL);
+			if (edge == GPIO_INT_BOTH_EDGES)
+				writel(val | (1 << gpio_idx),
+				       port->base + GPIO_EDGE_SEL);
+			else
+				writel(val & ~(1 << gpio_idx),
+				       port->base + GPIO_EDGE_SEL);
+		}
 
-	if (GPIO_EDGE_SEL >= 0) {
-		val = readl(port->base + GPIO_EDGE_SEL);
-		if (edge == GPIO_INT_BOTH_EDGES)
-			writel(val | (1 << gpio_idx),
-				port->base + GPIO_EDGE_SEL);
-		else
-			writel(val & ~(1 << gpio_idx),
-				port->base + GPIO_EDGE_SEL);
-	}
+		if (edge != GPIO_INT_BOTH_EDGES) {
+			reg += GPIO_ICR1 + ((gpio_idx & 0x10) >> 2); /* lower or upper register */
+			bit = gpio_idx & 0xf;
+			val = readl(reg) & ~(0x3 << (bit << 1));
+			writel(val | (edge << (bit << 1)), reg);
+		}
 
-	if (edge != GPIO_INT_BOTH_EDGES) {
-		reg += GPIO_ICR1 + ((gpio_idx & 0x10) >> 2); /* lower or upper register */
-		bit = gpio_idx & 0xf;
-		val = readl(reg) & ~(0x3 << (bit << 1));
-		writel(val | (edge << (bit << 1)), reg);
+		writel(1 << gpio_idx, port->base + GPIO_ISR);
+		port->pad_type[gpio_idx] = type;
 	}
 
-	writel(1 << gpio_idx, port->base + GPIO_ISR);
-	port->pad_type[gpio_idx] = type;
-
-	raw_spin_unlock_irqrestore(&port->gc.bgpio_lock, flags);
-
 	return port->gc.direction_input(&port->gc, gpio_idx);
 }
 
 static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 {
 	void __iomem *reg = port->base;
-	unsigned long flags;
 	u32 bit, val;
 	int edge;
 
-	raw_spin_lock_irqsave(&port->gc.bgpio_lock, flags);
+	guard(raw_spinlock_irqsave)(&port->gc.bgpio_lock);
 
 	reg += GPIO_ICR1 + ((gpio & 0x10) >> 2); /* lower or upper register */
 	bit = gpio & 0xf;
@@ -250,12 +248,9 @@ static void mxc_flip_edge(struct mxc_gpio_port *port, u32 gpio)
 	} else {
 		pr_err("mxc: invalid configuration for GPIO %d: %x\n",
 		       gpio, edge);
-		goto unlock;
+		return;
 	}
 	writel(val | (edge << (bit << 1)), reg);
-
-unlock:
-	raw_spin_unlock_irqrestore(&port->gc.bgpio_lock, flags);
 }
 
 /* handle 32 interrupts in one status register */
@@ -264,7 +259,7 @@ static void mxc_gpio_irq_handler(struct mxc_gpio_port *port, u32 irq_stat)
 	while (irq_stat != 0) {
 		int irqoffset = fls(irq_stat) - 1;
 
-		if (port->both_edges & (1 << irqoffset))
+		if (test_bit(irqoffset, &port->both_edges))
 			mxc_flip_edge(port, irqoffset);
 
 		generic_handle_domain_irq(port->domain, irqoffset);
@@ -335,16 +330,18 @@ static int gpio_set_wake_irq(struct irq_data *d, u32 enable)
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
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 144f1e174c54..bffdaa91d86c 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3578,16 +3578,17 @@ int gpiod_set_array_value_complex(bool raw, bool can_sleep,
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
index eb5f528459ec..528f0aeac36c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1449,6 +1449,7 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_cs_parser parser;
 	int r;
 
@@ -1503,6 +1504,11 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
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
index acaf7228a143..aab7b75ebc3f 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index 37275b38bca8..905941e99f4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -455,6 +455,9 @@ static void sdma_v3_0_ring_emit_hdp_flush(struct amdgpu_ring *ring)
 	else
 		ref_and_mask = REG_SET_FIELD(ref_and_mask, GPU_HDP_FLUSH_DONE, SDMA1, 1);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(1) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_FUNC(3)); /* == */
@@ -482,6 +485,10 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
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
@@ -490,7 +497,11 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 
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
@@ -1031,6 +1042,9 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	uint32_t seq = ring->fence_drv.sync_seq;
 	uint64_t addr = ring->fence_drv.gpu_addr;
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for idle */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1059,6 +1073,9 @@ static void sdma_v3_0_ring_emit_vm_flush(struct amdgpu_ring *ring,
 {
 	amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
 
+	/* Hang workaround */
+	amdgpu_ring_write(ring, SDMA_PKT_NOP_HEADER_OP(SDMA_OP_NOP));
+
 	/* wait for flush */
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_POLL_REGMEM) |
 			  SDMA_PKT_POLL_REGMEM_HEADER_HDP_FLUSH(0) |
@@ -1568,11 +1585,11 @@ static const struct amdgpu_ring_funcs sdma_v3_0_ring_funcs = {
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
index ff0b7438ac76..4c7f6c2e1ade 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
@@ -959,7 +959,7 @@ static const struct amdgpu_ring_funcs vce_v3_0_ring_phys_funcs = {
 
 static const struct amdgpu_ring_funcs vce_v3_0_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCE,
-	.align_mask = 0xf,
+	.align_mask = 0x1f,
 	.nop = VCE_CMD_NO_OP,
 	.support_64bit_ptrs = false,
 	.no_user_fence = true,
diff --git a/drivers/gpu/drm/drm_exec.c b/drivers/gpu/drm/drm_exec.c
index 3d5aaea0c212..a88132e8ff0c 100644
--- a/drivers/gpu/drm/drm_exec.c
+++ b/drivers/gpu/drm/drm_exec.c
@@ -49,6 +49,16 @@
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
@@ -59,8 +69,7 @@ static void drm_exec_unlock_all(struct drm_exec *exec)
 		drm_gem_object_put(obj);
 	}
 
-	drm_gem_object_put(exec->prelocked);
-	exec->prelocked = NULL;
+	drm_exec_drop_prelocked(exec);
 }
 
 /**
@@ -119,6 +128,14 @@ EXPORT_SYMBOL(drm_exec_fini);
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
@@ -176,16 +193,16 @@ static int drm_exec_lock_contended(struct drm_exec *exec)
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
@@ -213,35 +230,31 @@ int drm_exec_lock_obj(struct drm_exec *exec, struct drm_gem_object *obj)
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
diff --git a/drivers/gpu/drm/i915/display/intel_dmc.c b/drivers/gpu/drm/i915/display/intel_dmc.c
index 7c756d5ba2a2..641dabf275e7 100644
--- a/drivers/gpu/drm/i915/display/intel_dmc.c
+++ b/drivers/gpu/drm/i915/display/intel_dmc.c
@@ -796,7 +796,7 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 	}
 
 	/* Cache the dmc header info. */
-	if (mmio_count > mmio_count_max) {
+	if (!mmio_count || mmio_count > mmio_count_max) {
 		drm_err(&i915->drm, "DMC firmware has wrong mmio count %u\n", mmio_count);
 		return 0;
 	}
@@ -819,13 +819,21 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 			    disable_dmc_evt(i915, dmc_id, dmc_info->mmioaddr[i],
 					    dmc_info->mmiodata[i]) ? " (disabling)" : "");
 	}
-	dmc_info->mmio_count = mmio_count;
-	dmc_info->start_mmioaddr = start_mmioaddr;
 
 	rem_size -= header_len_bytes;
 
 	/* fw_size is in dwords, so multiplied by 4 to convert into bytes. */
-	payload_size = dmc_header->fw_size * 4;
+	if (check_mul_overflow(dmc_header->fw_size, 4u, &payload_size)) {
+		drm_err(&i915->drm, "DMC fw_size too large (%u dwords)\n",
+			dmc_header->fw_size);
+		return 0;
+	}
+
+	if (!payload_size) {
+		drm_err(&i915->drm, "DMC firmware has empty payload\n");
+		return 0;
+	}
+
 	if (rem_size < payload_size)
 		goto error_truncated;
 
@@ -833,12 +841,15 @@ static u32 parse_dmc_fw_header(struct intel_dmc *dmc,
 		drm_err(&i915->drm, "DMC FW too big (%u bytes)\n", payload_size);
 		return 0;
 	}
-	dmc_info->dmc_fw_size = dmc_header->fw_size;
 
 	dmc_info->payload = kmalloc(payload_size, GFP_KERNEL);
 	if (!dmc_info->payload)
 		return 0;
 
+	dmc_info->mmio_count = mmio_count;
+	dmc_info->start_mmioaddr = start_mmioaddr;
+	dmc_info->dmc_fw_size = dmc_header->fw_size;
+
 	payload = (u8 *)(dmc_header) + header_len_bytes;
 	memcpy(dmc_info->payload, payload, payload_size);
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9655027f1c0a..7ea1622377b5 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -857,7 +857,7 @@ static void vc4_hdmi_encoder_post_crtc_disable(struct drm_encoder *encoder,
 
 	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
 
-	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
 
 	HDMI_WRITE(HDMI_VID_CTL, HDMI_READ(HDMI_VID_CTL) | VC4_HD_VID_CTL_CLRRGB);
 
@@ -1616,9 +1616,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ONCE(ret, "Timeout waiting for "
 			  "VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE\n");
 	} else {
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   HDMI_READ(HDMI_RAM_PACKET_CONFIG) &
-			   ~(VC4_HDMI_RAM_PACKET_ENABLE));
 		HDMI_WRITE(HDMI_SCHEDULER_CONTROL,
 			   HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			   ~VC4_HDMI_SCHEDULER_CONTROL_MODE_HDMI);
@@ -1637,9 +1634,6 @@ static void vc4_hdmi_encoder_post_crtc_enable(struct drm_encoder *encoder,
 		WARN_ON(!(HDMI_READ(HDMI_SCHEDULER_CONTROL) &
 			  VC4_HDMI_SCHEDULER_CONTROL_HDMI_ACTIVE));
 
-		HDMI_WRITE(HDMI_RAM_PACKET_CONFIG,
-			   VC4_HDMI_RAM_PACKET_ENABLE);
-
 		spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 		vc4_hdmi->packet_ram_enabled = true;
 
@@ -3125,6 +3119,11 @@ static int vc5_hdmi_init_resources(struct drm_device *drm,
 static int vc4_hdmi_runtime_suspend(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
+	unsigned long flags;
+
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, 0);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
 
 	clk_disable_unprepare(vc4_hdmi->hsm_clock);
 
@@ -3134,9 +3133,8 @@ static int vc4_hdmi_runtime_suspend(struct device *dev)
 static int vc4_hdmi_runtime_resume(struct device *dev)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
-	unsigned long __maybe_unused flags;
+	unsigned long rate, flags;
 	u32 __maybe_unused value;
-	unsigned long rate;
 	int ret;
 
 	ret = clk_prepare_enable(vc4_hdmi->hsm_clock);
@@ -3178,6 +3176,10 @@ static int vc4_hdmi_runtime_resume(struct device *dev)
 	}
 #endif
 
+	spin_lock_irqsave(&vc4_hdmi->hw_lock, flags);
+	HDMI_WRITE(HDMI_RAM_PACKET_CONFIG, VC4_HDMI_RAM_PACKET_ENABLE);
+	spin_unlock_irqrestore(&vc4_hdmi->hw_lock, flags);
+
 	return 0;
 
 err_disable_clk:
diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
index 04a88c16d835..03af3704ee68 100644
--- a/drivers/gpu/drm/xe/xe_exec.c
+++ b/drivers/gpu/drm/xe/xe_exec.c
@@ -330,11 +330,8 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
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
diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
index da148df42105..d53cb4e62517 100644
--- a/drivers/gpu/drm/xe/xe_vm.c
+++ b/drivers/gpu/drm/xe/xe_vm.c
@@ -439,6 +439,33 @@ int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
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
@@ -552,9 +579,7 @@ static void preempt_rebind_work_func(struct work_struct *w)
 
 #undef retry_required
 
-	spin_lock(&vm->xe->ttm.lru_lock);
-	ttm_lru_bulk_move_tail(&vm->lru_bulk_move);
-	spin_unlock(&vm->xe->ttm.lru_lock);
+	xe_vm_bump_lru(vm, &exec);
 
 	/* Point of no return. */
 	arm_preempt_fences(vm, &preempt_fences);
diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
index d2406532fcc5..b0a864618ecc 100644
--- a/drivers/gpu/drm/xe/xe_vm.h
+++ b/drivers/gpu/drm/xe/xe_vm.h
@@ -248,6 +248,8 @@ int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
 int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
 			  unsigned int num_fences);
 
+void xe_vm_bump_lru(struct xe_vm *vm, struct drm_exec *exec);
+
 /**
  * xe_vm_resv() - Return's the vm's reservation object
  * @vm: The vm
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 3c6011a48dab..914d479d7872 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -743,13 +743,14 @@ static void init_vp_index(struct vmbus_channel *channel)
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
@@ -771,14 +772,19 @@ static void init_vp_index(struct vmbus_channel *channel)
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
index 3cdba13b132f..722c07ec05be 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -340,7 +340,6 @@ int vmbus_connect(void)
 cleanup:
 	pr_err("Unable to connect to host\n");
 
-	vmbus_connection.conn_state = DISCONNECTED;
 	vmbus_disconnect();
 
 	kfree(msginfo);
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 1ddbbc80cf13..153633bda142 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2899,7 +2899,6 @@ static void __exit vmbus_exit(void)
 
 	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
-	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
 	vmbus_disconnect();
 	if (vmbus_irq == -1) {
diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
index c0309bf61595..86d45f075234 100644
--- a/drivers/i2c/busses/i2c-qcom-cci.c
+++ b/drivers/i2c/busses/i2c-qcom-cci.c
@@ -168,12 +168,12 @@ static irqreturn_t cci_isr(int irq, void *dev)
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
 
diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
index 3415683dab91..029473ef3fc5 100644
--- a/drivers/i2c/busses/i2c-viai2c-wmt.c
+++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
@@ -44,16 +44,13 @@ static int wmt_i2c_reset_hardware(struct viai2c *i2c)
 	int err;
 
 	err = clk_prepare_enable(i2c->clk);
-	if (err) {
-		dev_err(i2c->dev, "failed to enable clock\n");
-		return err;
-	}
+	if (err)
+		return dev_err_probe(i2c->dev, err, "failed to enable clock\n");
 
 	err = clk_set_rate(i2c->clk, 20000000);
 	if (err) {
-		dev_err(i2c->dev, "failed to set clock = 20Mhz\n");
 		clk_disable_unprepare(i2c->clk);
-		return err;
+		return dev_err_probe(i2c->dev, err, "failed to set clock = 20Mhz\n");
 	}
 
 	writew(0, i2c->base + VIAI2C_REG_CR);
@@ -120,11 +117,10 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, err,
 				"failed to request irq %i\n", i2c->irq);
 
-	i2c->clk = of_clk_get(np, 0);
-	if (IS_ERR(i2c->clk)) {
-		dev_err(&pdev->dev, "unable to request clock\n");
-		return PTR_ERR(i2c->clk);
-	}
+	i2c->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(i2c->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(i2c->clk),
+				     "unable to request clock\n");
 
 	err = of_property_read_u32(np, "clock-frequency", &clk_rate);
 	if (!err && clk_rate == I2C_MAX_FAST_MODE_FREQ)
@@ -139,10 +135,8 @@ static int wmt_i2c_probe(struct platform_device *pdev)
 	adap->dev.of_node = pdev->dev.of_node;
 
 	err = wmt_i2c_reset_hardware(i2c);
-	if (err) {
-		dev_err(&pdev->dev, "error initializing hardware\n");
+	if (err)
 		return err;
-	}
 
 	err = i2c_add_adapter(adap);
 	if (err)
diff --git a/drivers/md/dm-cache-target.c b/drivers/md/dm-cache-target.c
index 3a7881c0a5b1..f57627cea606 100644
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
@@ -2597,8 +2598,10 @@ static int cache_create(struct cache_args *ca, struct cache **result)
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
index 7042b73a5c88..3c2334232cd0 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -1837,7 +1837,6 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 {
 	struct crypt_config *cc = io->cc;
 	struct bio *base_bio = io->base_bio;
-	blk_status_t error = io->error;
 
 	if (!atomic_dec_and_test(&io->io_pending))
 		return;
@@ -1859,7 +1858,7 @@ static void crypt_dec_pending(struct dm_crypt_io *io)
 	else
 		kfree(io->integrity_metadata);
 
-	base_bio->bi_status = error;
+	base_bio->bi_status = io->error;
 
 	bio_endio(base_bio);
 }
diff --git a/drivers/md/dm-ebs-target.c b/drivers/md/dm-ebs-target.c
index bb8dcfd56e4b..eb8d4f28292f 100644
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
index b1313077de7a..cc0d49510434 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1856,7 +1856,7 @@ static void integrity_metadata(struct work_struct *w)
 
 		if (unlikely(dio->op == REQ_OP_DISCARD)) {
 			unsigned int bi_size = dio->bio_details.bi_iter.bi_size;
-			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : HASH_MAX_DIGESTSIZE;
+			unsigned int max_size = likely(checksums != checksums_onstack) ? PAGE_SIZE : sizeof(checksums_onstack);
 			unsigned int max_blocks = (max_size - extra_space) / ic->tag_size;
 			sector_t sector = dio->range.logical_sector;
 
@@ -3979,6 +3979,10 @@ static void dm_integrity_io_hints(struct dm_target *ti, struct queue_limits *lim
 		limits->discard_granularity = ic->sectors_per_block << SECTOR_SHIFT;
 	}
 
+	if (ic->internal_hash &&
+	    (ic->mode == 'D' || ic->mode == 'B' || ic->mode == 'I'))
+		limits->features |= BLK_FEAT_STABLE_WRITES;
+
 	if (!ic->internal_hash) {
 		struct blk_integrity *bi = &limits->integrity;
 
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 7da4a2114a77..0402e8f69c6f 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -2095,6 +2095,16 @@ static netdev_tx_t bcmgenet_xmit(struct sk_buff *skb, struct net_device *dev)
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
index 0d33b30ec2f6..f96801d1c833 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1312,9 +1312,11 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
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
@@ -1334,8 +1336,13 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
 
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
index 65006eceaf39..669a063a3168 100644
--- a/drivers/pinctrl/pinctrl-amd.c
+++ b/drivers/pinctrl/pinctrl-amd.c
@@ -871,6 +871,15 @@ static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
 
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
index 68f65b57003e..2bbc409924f8 100644
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
diff --git a/drivers/power/supply/ds2780_battery.c b/drivers/power/supply/ds2780_battery.c
index 1e7f297f6cb1..7219ee3def5a 100644
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
index 7bdc6b263609..aebc824aa2ed 100644
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
diff --git a/drivers/s390/net/ctcm_mpc.c b/drivers/s390/net/ctcm_mpc.c
index 48ea517ff567..d50660a3fe7f 100644
--- a/drivers/s390/net/ctcm_mpc.c
+++ b/drivers/s390/net/ctcm_mpc.c
@@ -826,7 +826,7 @@ static void mpc_action_go_ready(fsm_instance *fsm, int event, void *arg)
 
 	fsm_deltimer(&grp->timer);
 
-	if (grp->saved_xid2->xid2_flag2 == 0x40) {
+	if (priv->xid->xid2_flag2 == 0x40) {
 		priv->xid->xid2_flag2 = 0x00;
 		if (grp->estconnfunc) {
 			grp->estconnfunc(grp->port_num, 1,
@@ -1636,7 +1636,6 @@ static int mpc_validate_xid(struct mpcg_info *mpcginfo)
 			"The XID used in the MPC protocol is not valid, "
 			"rc = %d\n", rc);
 		priv->xid->xid2_flag2 = 0x40;
-		grp->saved_xid2->xid2_flag2 = 0x40;
 	}
 
 	return rc;
diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 0f169f243475..266c999083a7 100644
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
index 2b8004eb6f1b..165c0c588c68 100644
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
@@ -2165,6 +2169,11 @@ void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
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
@@ -2172,6 +2181,7 @@ void sas_smp_handler(struct bsg_job *job, struct Scsi_Host *shost,
 		rcvlen = job->reply_payload.payload_len - ret;
 		ret = 0;
 	}
+	pm_runtime_put(dev->port->ha->dev);
 
 out:
 	bsg_job_done(job, ret, rcvlen);
diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 1532436f0f3a..047a906aaf0b 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -2968,7 +2968,7 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 	}
 
 	q = bsg_setup_queue(bsg_dev, dev_name(bsg_dev), &lim,
-			mpi3mr_bsg_request, NULL, 0);
+			mpi3mr_bsg_request, NULL, 0, SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		ioc_err(mrioc, "%s: bsg registration failed\n",
 		    dev_name(bsg_dev));
diff --git a/drivers/scsi/scsi_transport_fc.c b/drivers/scsi/scsi_transport_fc.c
index 33632952ff95..ec7b9b3922f9 100644
--- a/drivers/scsi/scsi_transport_fc.c
+++ b/drivers/scsi/scsi_transport_fc.c
@@ -4290,7 +4290,8 @@ fc_bsg_hostadd(struct Scsi_Host *shost, struct fc_host_attrs *fc_host)
 	scsi_init_limits(shost, &lim);
 	lim.max_segments = min_not_zero(lim.max_segments, i->f->max_bsg_segments);
 	q = bsg_setup_queue(dev, bsg_name, &lim, fc_bsg_dispatch,
-			fc_bsg_job_timeout, i->f->dd_bsg_size);
+			fc_bsg_job_timeout, i->f->dd_bsg_size,
+			SCSI_SENSE_BUFFERSIZE);
 	if (IS_ERR(q)) {
 		dev_err(dev,
 			"fc_host%d: bsg interface failed to initialize - setup queue\n",
@@ -4323,7 +4324,8 @@ fc_bsg_rportadd(struct Scsi_Host *shost, struct fc_rport *rport)
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
index 7528bb7c06bb..f158fdcc957c 100644
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
index 01358879c0ad..29c18da28cc0 100644
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
index 3e982c166baf..53d37c849771 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3194,14 +3194,20 @@ static int set_location(struct scsi_tape *STp, unsigned int block, int partition
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
 
@@ -4442,11 +4448,11 @@ static int st_remove(struct device *dev)
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
index 9ec55ddc1204..659e3e82da25 100644
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
index e2ca5d55fd31..b506ed40e108 100644
--- a/drivers/soc/tegra/fuse/tegra-apbmisc.c
+++ b/drivers/soc/tegra/fuse/tegra-apbmisc.c
@@ -277,7 +277,7 @@ void tegra_acpi_init_apbmisc(void)
 
 	ret = acpi_dev_get_memory_resources(adev, &resource_list);
 	if (ret < 0) {
-		pr_err("failed to get APBMISC memory resources");
+		pr_err("failed to get APBMISC memory resources\n");
 		goto out_put_acpi_dev;
 	}
 
diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 5b8bd34e6bfd..622bcaa0fe6e 100644
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
index 88db94f382bb..5e01ab65cec5 100644
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
index a1090863ea46..937819181fdb 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -264,6 +264,8 @@ struct afs_super_info {
 	struct afs_volume	*volume;	/* volume record */
 	enum afs_flock_mode	flock_mode:8;	/* File locking emulation mode */
 	bool			dyn_root;	/* True if dynamic root */
+	/* afs_atcell_get_link() reads ->net_ns in rcu pathwalk */
+	struct rcu_head		rcu;
 };
 
 static inline struct afs_super_info *AFS_FS_S(struct super_block *sb)
diff --git a/fs/afs/super.c b/fs/afs/super.c
index 32bb1b7a498d..b1ec0ab6c243 100644
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
diff --git a/fs/coredump.c b/fs/coredump.c
index 64894ba6efca..d23c57eb2e05 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -420,7 +420,9 @@ static int zap_threads(struct task_struct *tsk,
 	int nr = -EAGAIN;
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task) {
+	/* A freeze requested before the dump would be lost with TIF_SIGPENDING. */
+	if (!(signal->flags & SIGNAL_GROUP_EXIT) && !signal->group_exec_task &&
+	    !freezing(tsk) && !(tsk->jobctl & JOBCTL_TRAP_FREEZE)) {
 		/* Allow SIGKILL, see prepare_signal() */
 		signal->core_state = core_state;
 		nr = zap_process(signal, exit_code);
@@ -474,6 +476,8 @@ static void coredump_finish(bool core_dumped)
 	current->signal->core_state = NULL;
 	spin_unlock_irq(&current->sighand->siglock);
 
+	/* A released thread may exit and be freed before it is woken. */
+	guard(rcu)();
 	while ((curr = next) != NULL) {
 		next = curr->next;
 		task = curr->task;
@@ -482,6 +486,7 @@ static void coredump_finish(bool core_dumped)
 		 * ->task == NULL before we read ->next.
 		 */
 		smp_mb();
+		/* Any wakeup now lets the thread exit, rcu keeps it alive. */
 		curr->task = NULL;
 		wake_up_process(task);
 	}
@@ -489,13 +494,8 @@ static void coredump_finish(bool core_dumped)
 
 static bool dump_interrupted(void)
 {
-	/*
-	 * SIGKILL or freezing() interrupt the coredumping. Perhaps we
-	 * can do try_to_freeze() and check __fatal_signal_pending(),
-	 * but then we need to teach dump_write() to restart and clear
-	 * TIF_SIGPENDING.
-	 */
-	return fatal_signal_pending(current) || freezing(current);
+	/* Only SIGKILL and the freezers set it after zap_threads(). */
+	return task_sigpending(current);
 }
 
 static void wait_for_dump_helpers(struct file *file)
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 21de942bb6fb..3e0c29434ae3 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1663,6 +1663,8 @@ struct ext4_sb_info {
 	struct list_head s_es_list;	/* List of inodes with reclaimable extents */
 	long s_es_nr_inode;
 	struct ext4_es_stats s_es_stats;
+	/* ext4_get_link() reads the sbi in rcu pathwalk */
+	struct rcu_head s_rcu;
 	struct mb_cache *s_ea_block_cache;
 	struct mb_cache *s_ea_inode_cache;
 	spinlock_t s_es_lock ____cacheline_aligned_in_smp;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3..425a613683c0 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -1766,12 +1766,17 @@ int ext4_es_register_shrinker(struct ext4_sb_info *sbi)
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
index 4424232de298..c1e45f6ab664 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -237,6 +237,7 @@ static inline void ext4_es_store_pblock_status(struct extent_status *es,
 
 extern int ext4_es_register_shrinker(struct ext4_sb_info *sbi);
 extern void ext4_es_unregister_shrinker(struct ext4_sb_info *sbi);
+extern void ext4_es_destroy_stats(struct ext4_sb_info *sbi);
 
 extern int ext4_seq_es_shrinker_info_show(struct seq_file *seq, void *v);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 08f84ed65ad1..25aae8165f07 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1289,6 +1289,14 @@ static void ext4_flex_groups_free(struct ext4_sb_info *sbi)
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
@@ -1381,7 +1389,6 @@ static void ext4_put_super(struct super_block *sb)
 	ext4_stop_mmpd(sbi);
 
 	brelse(sbi->s_sbh);
-	sb->s_fs_info = NULL;
 	/*
 	 * Now that we are completely done shutting down the
 	 * superblock, we need to actually destroy the kobject.
@@ -1396,7 +1403,8 @@ static void ext4_put_super(struct super_block *sb)
 #if IS_ENABLED(CONFIG_UNICODE)
 	utf8_unload(sb->s_encoding);
 #endif
-	kfree(sbi);
+	/* ext4_get_link() reads the sbi and the counters in rcu pathwalk */
+	call_rcu(&sbi->s_rcu, ext4_put_sbi_rcu);
 }
 
 static struct kmem_cache *ext4_inode_cachep;
@@ -5659,6 +5667,7 @@ failed_mount8: __maybe_unused
 	}
 failed_mount3a:
 	ext4_es_unregister_shrinker(sbi);
+	ext4_es_destroy_stats(sbi);
 failed_mount3:
 	/* flush s_sb_upd_work before sbi destroy */
 	flush_work(&sbi->s_sb_upd_work);
diff --git a/fs/fat/dir.c b/fs/fat/dir.c
index acbec5bdd521..ce6b87210e18 100644
--- a/fs/fat/dir.c
+++ b/fs/fat/dir.c
@@ -128,6 +128,31 @@ static inline int fat_get_entry(struct inode *dir, loff_t *pos,
 	return fat__get_entry(dir, pos, bh, de);
 }
 
+/*
+ * Like fat_get_entry(), but honour the FAT end-of-directory marker:
+ * a dirent whose first name byte is NUL terminates iteration per the
+ * spec, which also guarantees that every following slot is zeroed.
+ * Skip straight to the end of the directory so the next call returns
+ * -1 from fat_bmap() without re-reading the trailing zero slots, and
+ * so callers that persist *pos across invocations (e.g. readdir's
+ * ctx->pos) keep reporting EOD.  Release *bh and set it to NULL to
+ * match fat_get_entry()'s contract that *bh is NULL on the -1 return.
+ */
+static int fat_get_entry_eod(struct inode *dir, loff_t *pos,
+			     struct buffer_head **bh,
+			     struct msdos_dir_entry **de)
+{
+	int err = fat_get_entry(dir, pos, bh, de);
+
+	if (err == 0 && (*de)->name[0] == 0) {
+		brelse(*bh);
+		*bh = NULL;
+		*pos = dir->i_size;
+		return -1;
+	}
+	return err;
+}
+
 /*
  * Convert Unicode 16 to UTF-8, translated Unicode, or ASCII.
  * If uni_xlate is enabled and we can't get a 1:1 conversion, use a
@@ -325,7 +350,7 @@ static int fat_parse_long(struct inode *dir, loff_t *pos,
 
 		if (ds->id & 0x40)
 			(*unicode)[offset + 13] = 0;
-		if (fat_get_entry(dir, pos, bh, de) < 0)
+		if (fat_get_entry_eod(dir, pos, bh, de) < 0)
 			return PARSE_EOF;
 		if (slot == 0)
 			break;
@@ -487,7 +512,7 @@ int fat_search_long(struct inode *inode, const unsigned char *name,
 
 	err = -ENOENT;
 	while (1) {
-		if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+		if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 			goto end_of_dir;
 parse_record:
 		nr_slots = 0;
@@ -599,7 +624,7 @@ static int __fat_readdir(struct inode *inode, struct file *file,
 
 	bh = NULL;
 get_new:
-	if (fat_get_entry(inode, &cpos, &bh, &de) == -1)
+	if (fat_get_entry_eod(inode, &cpos, &bh, &de) == -1)
 		goto end_of_dir;
 parse_record:
 	nr_slots = 0;
@@ -882,7 +907,7 @@ static int fat_get_short_entry(struct inode *dir, loff_t *pos,
 			       struct buffer_head **bh,
 			       struct msdos_dir_entry **de)
 {
-	while (fat_get_entry(dir, pos, bh, de) >= 0) {
+	while (fat_get_entry_eod(dir, pos, bh, de) >= 0) {
 		/* free entry or long name entry or volume label */
 		if (!IS_FREE((*de)->name) && !((*de)->attr & ATTR_VOLUME))
 			return 0;
@@ -1299,6 +1324,7 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	struct msdos_dir_entry *de;
 	int err, free_slots, i, nr_bhs;
 	loff_t pos, i_pos;
+	bool saw_eod;
 
 	sinfo->nr_slots = nr_slots;
 
@@ -1307,12 +1333,15 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 	bh = prev = NULL;
 	pos = 0;
 	err = -ENOSPC;
+	saw_eod = false;
 	while (fat_get_entry(dir, &pos, &bh, &de) > -1) {
 		/* check the maximum size of directory */
 		if (pos >= FAT_MAX_DIR_SIZE)
 			goto error;
 
 		if (IS_FREE(de->name)) {
+			if (de->name[0] == 0)
+				saw_eod = true;
 			if (prev != bh) {
 				get_bh(bh);
 				bhs[nr_bhs] = prev = bh;
@@ -1322,6 +1351,13 @@ int fat_add_entries(struct inode *dir, void *slots, int nr_slots,
 			if (free_slots == nr_slots)
 				goto found;
 		} else {
+			if (saw_eod) {
+				fat_fs_error_ratelimit(sb,
+					"allocated dir entry found after end-of-directory marker (i_pos %lld)",
+					MSDOS_I(dir)->i_pos);
+				err = -EIO;
+				goto error;
+			}
 			for (i = 0; i < nr_bhs; i++)
 				brelse(bhs[i]);
 			prev = NULL;
diff --git a/fs/namei.c b/fs/namei.c
index 0c47a14e88a6..a73b055dcd39 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3726,8 +3726,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 		return dentry;
 
 	if (open_flag & O_CREAT) {
-		/* Discard negative dentries. Need inode_lock to do the create */
-		if (!dentry->d_inode) {
+		if (d_is_negative(dentry)) {
 			if (!(nd->flags & LOOKUP_RCU))
 				dput(dentry);
 			dentry = NULL;
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index a263305ed7c8..f6e00d103f3f 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -779,6 +779,11 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
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
@@ -965,6 +970,12 @@ void fsnotify_destroy_marks(fsnotify_connp_t *connp)
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
index 11be9a6f041c..934dcb136d6d 100644
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
index 4b1941e3f3a6..c7c1896acc2c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -187,7 +187,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 	void *ret = NULL;
 	int i, j = -1;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (!s_shared[i].cnt) {
 			j = i;
@@ -205,7 +205,7 @@ void *ntfs_set_shared(void *ptr, u32 bytes)
 		s_shared[j].cnt = 1;
 		ret = ptr;
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -222,7 +222,7 @@ void *ntfs_put_shared(void *ptr)
 	void *ret = ptr;
 	int i;
 
-	spin_lock(&s_shared_lock);
+	spin_lock_bh(&s_shared_lock);
 	for (i = 0; i < ARRAY_SIZE(s_shared); i++) {
 		if (s_shared[i].cnt && s_shared[i].ptr == ptr) {
 			if (--s_shared[i].cnt)
@@ -230,7 +230,7 @@ void *ntfs_put_shared(void *ptr)
 			break;
 		}
 	}
-	spin_unlock(&s_shared_lock);
+	spin_unlock_bh(&s_shared_lock);
 
 	return ret;
 }
@@ -630,6 +630,8 @@ static noinline void ntfs3_put_sbi(struct ntfs_sb_info *sbi)
 
 static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
 {
+	if (sbi->options)
+		put_mount_options(sbi->options);
 	kfree(sbi->new_rec);
 	kvfree(ntfs_put_shared(sbi->upcase));
 	kvfree(sbi->def_table);
@@ -641,6 +643,11 @@ static void ntfs3_free_sbi(struct ntfs_sb_info *sbi)
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
@@ -657,6 +664,12 @@ static void ntfs_put_super(struct super_block *sb)
 
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
 
@@ -1806,9 +1819,11 @@ static void ntfs3_kill_sb(struct super_block *sb)
 
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
index e62ed98df7de..afaea6396b6f 100644
--- a/fs/ocfs2/dlm/dlmdebug.c
+++ b/fs/ocfs2/dlm/dlmdebug.c
@@ -792,8 +792,11 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
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
@@ -825,7 +828,7 @@ static int debug_state_print(struct dlm_ctxt *dlm, char *buf, int len)
 				node->node_num, state);
 	}
 
-	spin_unlock(&dlm->spinlock);
+	spin_unlock(&dlm_reco_state_lock);
 
 	return out;
 }
diff --git a/fs/ocfs2/dlm/dlmrecovery.c b/fs/ocfs2/dlm/dlmrecovery.c
index 739da8bd7dbf..591dd17ef4f5 100644
--- a/fs/ocfs2/dlm/dlmrecovery.c
+++ b/fs/ocfs2/dlm/dlmrecovery.c
@@ -80,7 +80,7 @@ static int dlm_lockres_master_requery(struct dlm_ctxt *dlm,
 
 static u64 dlm_get_next_mig_cookie(void);
 
-static DEFINE_SPINLOCK(dlm_reco_state_lock);
+DEFINE_SPINLOCK(dlm_reco_state_lock);
 static DEFINE_SPINLOCK(dlm_mig_cookie_lock);
 static u64 dlm_mig_cookie = 1;
 
diff --git a/fs/pipe.c b/fs/pipe.c
index 12b22c2723b7..d2e75e726e63 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -753,9 +753,11 @@ pipe_fasync(int fd, struct file *filp, int on)
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
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 3e23c1c754c7..3485e8866536 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3188,6 +3188,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc = 0;
 	int bytes_returned = 0;
 	__u16 params, byte_count, data_count, param_offset, offset;
+	size_t cifs_acl_size, bytes_available;
 
 	cifs_dbg(FYI, "In SetPosixACL (Unix) for path %s\n", fileName);
 setAclRetry:
@@ -3206,8 +3207,7 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	params = 6 + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
-	/* BB find max SMB size from sess */
-	pSMB->MaxDataCount = cpu_to_le16(1000);
+	pSMB->MaxDataCount = cpu_to_le16(min_t(unsigned int, CIFSMaxBufSize, USHRT_MAX));
 	pSMB->MaxSetupCount = 0;
 	pSMB->Reserved = 0;
 	pSMB->Flags = 0;
@@ -3219,6 +3219,15 @@ int cifs_do_set_acl(const unsigned int xid, struct cifs_tcon *tcon,
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
index 7db347fc8faa..81961a54c9f1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4151,14 +4151,25 @@ cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
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
@@ -4197,7 +4208,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	ctx->witness = master_tcon->use_witness;
 	ctx->dfs_root_ses = master_tcon->ses->dfs_root_ses;
 
-	rc = cifs_set_vol_auth(ctx, master_tcon->ses);
+	rc = set_fs_context_auth(ctx, master_tcon->ses);
 	if (rc) {
 		tcon = ERR_PTR(rc);
 		goto out;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 6ef0fcd9a05c..7cd2e88a86b7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2292,7 +2292,7 @@ smb2_duplicate_extents(const unsigned int xid,
 			       trgtfile->fid.volatile_fid, tcon->tid,
 			       tcon->ses->Suid, src_off, dest_off, len);
 	inode = d_inode(trgtfile->dentry);
-	if (inode->i_size < dest_off + len) {
+	if (i_size_read(inode) < dest_off + len) {
 		rc = smb2_set_file_size(xid, tcon, trgtfile, dest_off + len, false);
 		if (rc)
 			goto duplicate_extents_out;
@@ -2318,6 +2318,11 @@ smb2_duplicate_extents(const unsigned int xid,
 	if (ret_data_len > 0)
 		cifs_dbg(FYI, "Non-zero response length in duplicate extents\n");
 
+	if (rc) {
+		CIFS_I(inode)->time = 0; /* force reval */
+		cifs_invalidate_cache(inode, 0);
+	}
+
 duplicate_extents_out:
 	if (rc)
 		trace_smb3_clone_err(xid, srcfile->fid.volatile_fid,
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 2b06ff081a9b..95c8ec3bd213 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -5698,6 +5698,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		struct object_id_info *info;
 
 		info = (struct object_id_info *)(rsp->Buffer);
+		memset(info, 0, sizeof(*info));
 
 		if (path.mnt->mnt_sb->s_uuid_len == 16)
 			memcpy(info->objid, path.mnt->mnt_sb->s_uuid.b,
@@ -5752,6 +5753,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FreeSpaceStopFiltering = 0;
 		info->DefaultQuotaThreshold = cpu_to_le64(SMB2_NO_FID);
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
+		info->FileSystemControlFlags = 0;
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
 		fixed_len = 48;
@@ -5774,6 +5776,9 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
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
index abb0ea57601b..e060dfe7cdac 100644
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
@@ -670,8 +678,10 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
 		 * Matches the smp_wmb() in free_ei()
 		 */
 		smp_rmb();
-		if (ei->is_freed)
-			return -EINVAL;
+		if (ei->is_freed) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		if (c > 0) {
 			c--;
diff --git a/fs/unicode/utf8-core.c b/fs/unicode/utf8-core.c
index 0400824ef493..a82673af2e66 100644
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
 
diff --git a/fs/xfs/libxfs/xfs_sb.c b/fs/xfs/libxfs/xfs_sb.c
index eb46712e27d9..de10b1adbf8a 100644
--- a/fs/xfs/libxfs/xfs_sb.c
+++ b/fs/xfs/libxfs/xfs_sb.c
@@ -1186,26 +1186,23 @@ xfs_sync_sb_buf(
 	struct xfs_mount	*mp)
 {
 	struct xfs_trans	*tp;
-	struct xfs_buf		*bp;
 	int			error;
 
 	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_sb, 0, 0, 0, &tp);
 	if (error)
 		return error;
 
-	bp = xfs_trans_getsb(tp);
 	xfs_log_sb(tp);
-	xfs_trans_bhold(tp, bp);
 	xfs_trans_set_sync(tp);
 	error = xfs_trans_commit(tp);
 	if (error)
-		goto out;
-	/*
-	 * write out the sb buffer to get the changes to disk
-	 */
-	error = xfs_bwrite(bp);
-out:
-	xfs_buf_relse(bp);
+		return error;
+
+	/* Re-acquire and write the sb to disk. */
+	xfs_buf_lock(mp->m_sb_bp);
+	error = xfs_bwrite(mp->m_sb_bp);
+	xfs_buf_unlock(mp->m_sb_bp);
+
 	return error;
 }
 
diff --git a/fs/xfs/xfs_fsmap.c b/fs/xfs/xfs_fsmap.c
index 8712b891defb..1eceae97a9f4 100644
--- a/fs/xfs/xfs_fsmap.c
+++ b/fs/xfs/xfs_fsmap.c
@@ -916,7 +916,7 @@ xfs_getfsmap(
 		return -EINVAL;
 
 	use_rmap = xfs_has_rmapbt(mp) &&
-		   has_capability_noaudit(current, CAP_SYS_ADMIN);
+		   ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
 	head->fmh_entries = 0;
 
 	/* Set up our device handlers. */
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 2567fd2a0994..7394781978a8 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -573,7 +573,7 @@ xfs_ioctl_setattr_get_trans(
 		goto out_error;
 
 	error = xfs_trans_alloc_ichange(ip, NULL, NULL, pdqp,
-			has_capability_noaudit(current, CAP_FOWNER), &tp);
+			ns_capable_noaudit(&init_user_ns, CAP_FOWNER), &tp);
 	if (error)
 		goto out_error;
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index ee79cf161312..39beb686f040 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -735,7 +735,7 @@ xfs_setattr_nonsize(
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
index 252eed781a6e..d75b8024c273 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -458,7 +458,10 @@ struct cgroup {
 
 	int nr_threaded_children;	/* # of live threaded child cgroups */
 
-	/* sequence number for cgroup.kill, serialized by css_set_lock. */
+	/*
+	 * Sequence number for cgroup.kill. Incremented with both cgroup_mutex
+	 * and css_set_lock held. Readers hold either one.
+	 */
 	unsigned int kill_seq;
 
 	struct kernfs_node *kn;		/* cgroup kernfs entry */
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 2343136c4e9d..c88c8191c230 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -468,6 +468,7 @@ struct fsnotify_mark_connector {
 	unsigned char prio;	/* Highest priority group */
 #define FSNOTIFY_CONN_FLAG_IS_WATCHED	0x01
 #define FSNOTIFY_CONN_FLAG_HAS_IREF	0x02
+#define FSNOTIFY_CONN_FLAG_DESTROYING	0x04
 	unsigned short flags;	/* flags [lock] */
 	union {
 		/* Object pointer [lock] */
diff --git a/include/linux/futex.h b/include/linux/futex.h
index b70df27d7e85..09f757f14d01 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -23,26 +23,30 @@ struct task_struct;
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
 	} private;
+
 	struct {
 		u64 ptr;
 		unsigned long word;
diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index bd34b70dd0cf..10e41e8b1634 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -254,7 +254,7 @@ static inline unsigned long thp_vma_suitable_orders(struct vm_area_struct *vma,
 	return orders;
 }
 
-static inline bool file_thp_enabled(struct vm_area_struct *vma)
+static inline bool file_thp_enabled(const struct vm_area_struct *vma)
 {
 	struct inode *inode;
 
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 7711d9920141..15da758064b0 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -403,6 +403,9 @@ struct io_ring_ctx {
 	u32				iowq_limits[2];
 
 	struct callback_head		poll_wq_task_work;
+	/* deferred ->poll_wq wake up for local task_work */
+	struct rcu_head			poll_wq_rcu;
+	atomic_t			poll_wq_rcu_pending;
 	struct list_head		defer_list;
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
diff --git a/include/linux/ipv6.h b/include/linux/ipv6.h
index ad5f09765e0c..6f3c5d4049e2 100644
--- a/include/linux/ipv6.h
+++ b/include/linux/ipv6.h
@@ -125,6 +125,28 @@ static inline unsigned int ipv6_transport_len(const struct sk_buff *skb)
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
diff --git a/include/linux/key-type.h b/include/linux/key-type.h
index 5caf3ce82373..1336c14138ab 100644
--- a/include/linux/key-type.h
+++ b/include/linux/key-type.h
@@ -158,6 +158,7 @@ struct key_type {
 				     const void *in, const void *in2);
 
 	/* internal fields */
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	struct list_head	link;		/* link in types list */
 	struct lock_class_key	lock_class;	/* key->sem lock class */
 } __randomize_layout;
diff --git a/include/linux/key.h b/include/linux/key.h
index ba05de8579ec..af9d22150e71 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -107,6 +107,7 @@ struct keyring_name;
 
 struct key_tag {
 	struct rcu_head		rcu;
+	atomic64_t		index_id;	/* Opaque keyring index ID */
 	refcount_t		usage;
 	bool			removed;	/* T when subject removed */
 };
@@ -129,6 +130,8 @@ struct keyring_index_key {
 	struct key_type		*type;
 	struct key_tag		*domain_tag;	/* Domain of operation */
 	const char		*description;
+	u64			type_id;	/* Cached index IDs */
+	u64			domain_id;
 };
 
 union key_payload {
@@ -251,6 +254,8 @@ struct key {
 			struct key_type	*type;		/* type of key */
 			struct key_tag	*domain_tag;	/* Domain of operation */
 			char		*description;
+			u64		type_id;
+			u64		domain_id;
 		};
 	};
 
diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
index ecbcc2b3e59a..4300f7746f2d 100644
--- a/include/linux/maple_tree.h
+++ b/include/linux/maple_tree.h
@@ -466,9 +466,13 @@ struct ma_wr_state {
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
index f9a280a27e5c..3deb3f1d5ad2 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -945,6 +945,9 @@ struct mm_struct {
 		 */
 		seqcount_t mm_lock_seq;
 #endif
+#ifdef CONFIG_FUTEX
+		atomic64_t futex_unique_id;
+#endif
 
 
 		unsigned long hiwater_rss; /* High-watermark of RSS usage */
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 910d407ebe63..b03991a29a65 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -360,9 +360,9 @@ struct power_supply_vbat_ri_table {
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
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 0fb5bb6c30d3..1c584a1f0b83 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1712,7 +1712,7 @@ extern struct pid __rcu *cad_pid;
 						 * I am cleaning dirty pages from some other bdi. */
 #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
 #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
-#define PF__HOLE__00800000	0x00800000
+#define PF_NO_NOTIFY_SIGNAL	0x00800000	/* see no_notify_signal_save() */
 #define PF__HOLE__01000000	0x01000000
 #define PF__HOLE__02000000	0x02000000
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 21e496bb1c1b..32c464f94d6d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_SCHED_SIGNAL_H
 #define _LINUX_SCHED_SIGNAL_H
 
+#include <linux/cleanup.h>
 #include <linux/rculist.h>
 #include <linux/signal.h>
 #include <linux/sched.h>
@@ -380,14 +381,36 @@ static inline int task_sigpending(struct task_struct *p)
 	return unlikely(test_tsk_thread_flag(p,TIF_SIGPENDING));
 }
 
+/* Prevent TIF_NOTIFY_SIGNAL from interrupting this task. */
+static inline unsigned int no_notify_signal_save(void)
+{
+	unsigned int flags = current->flags;
+
+	current->flags |= PF_NO_NOTIFY_SIGNAL;
+	return flags;
+}
+
+/* Restore the previous PF_NO_NOTIFY_SIGNAL state. */
+static inline void no_notify_signal_restore(unsigned int flags)
+{
+	current_restore_flags(flags, PF_NO_NOTIFY_SIGNAL);
+}
+
+DEFINE_LOCK_GUARD_0(no_notify_signal,
+		    _T->flags = no_notify_signal_save(),
+		    no_notify_signal_restore(_T->flags),
+		    unsigned int flags)
+
 static inline int signal_pending(struct task_struct *p)
 {
 	/*
 	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
 	 * behavior in terms of ensuring that we break out of wait loops
-	 * so that notify signal callbacks can be processed.
+	 * so that notify signal callbacks can be processed. Not for a task
+	 * that asked not to be interrupted by it, see no_notify_signal_save().
 	 */
-	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
+	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)) &&
+	    likely(!(READ_ONCE(p->flags) & PF_NO_NOTIFY_SIGNAL)))
 		return 1;
 	return task_sigpending(p);
 }
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
diff --git a/include/linux/srcutiny.h b/include/linux/srcutiny.h
index 6f39d3d8ef87..4d96bbdb45f0 100644
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -11,7 +11,6 @@
 #ifndef _LINUX_SRCU_TINY_H
 #define _LINUX_SRCU_TINY_H
 
-#include <linux/irq_work_types.h>
 #include <linux/swait.h>
 
 struct srcu_struct {
@@ -25,21 +24,18 @@ struct srcu_struct {
 	struct rcu_head *srcu_cb_head;	/* Pending callbacks: Head. */
 	struct rcu_head **srcu_cb_tail;	/* Pending callbacks: Tail. */
 	struct work_struct srcu_work;	/* For driving grace periods. */
-	struct irq_work srcu_irq_work;	/* Defer schedule_work() to irq work. */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map dep_map;
 #endif /* #ifdef CONFIG_DEBUG_LOCK_ALLOC */
 };
 
 void srcu_drive_gp(struct work_struct *wp);
-void srcu_tiny_irq_work(struct irq_work *irq_work);
 
 #define __SRCU_STRUCT_INIT(name, __ignored, ___ignored)			\
 {									\
 	.srcu_wq = __SWAIT_QUEUE_HEAD_INITIALIZER(name.srcu_wq),	\
 	.srcu_cb_tail = &name.srcu_cb_head,				\
 	.srcu_work = __WORK_INITIALIZER(name.srcu_work, srcu_drive_gp),	\
-	.srcu_irq_work = { .func = srcu_tiny_irq_work },		\
 	__SRCU_DEP_MAP_INIT(name)					\
 }
 
diff --git a/include/linux/unicode.h b/include/linux/unicode.h
index 4d39e6e11a95..f5ee53dc4dff 100644
--- a/include/linux/unicode.h
+++ b/include/linux/unicode.h
@@ -51,6 +51,7 @@ struct unicode_map {
 	unsigned int version;
 	const struct utf8data *ntab[UTF8_NMAX];
 	const struct utf8data_table *tables;
+	struct rcu_head rcu;
 };
 
 int utf8_validate(const struct unicode_map *um, const struct qstr *str);
diff --git a/include/net/af_vsock.h b/include/net/af_vsock.h
index 70302c92d329..20bbe02d2cfc 100644
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
diff --git a/include/net/ax25.h b/include/net/ax25.h
index a7bba42dde15..e3c10a939594 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -252,6 +252,11 @@ typedef struct ax25_cb {
 	struct sk_buff_head	reseq_queue;
 	struct sk_buff_head	ack_queue;
 	struct sk_buff_head	frag_queue;
+	/* I frames numbered by ax25_kick(), waiting to go to the device */
+	struct sk_buff_head	xmit_queue;
+	/* serialises V(S)/V(A) and the write, ack and xmit queues */
+	spinlock_t		lock;
+	unsigned char		xmit_running;
 	unsigned char		window;
 	struct timer_list	timer, dtimer;
 	struct sock		*sk;		/* Backlink to socket */
@@ -306,6 +311,7 @@ static inline __be16 ax25_type_trans(struct sk_buff *skb, struct net_device *dev
 extern struct hlist_head ax25_list;
 extern spinlock_t ax25_list_lock;
 void ax25_cb_add(ax25_cb *);
+ax25_cb *ax25_cb_add_unique(ax25_cb *ax25);
 struct sock *ax25_find_listener(ax25_address *, int, struct net_device *, int);
 struct sock *ax25_get_socket(ax25_address *, ax25_address *, int);
 ax25_cb *ax25_find_cb(const ax25_address *, ax25_address *, ax25_digi *,
diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index 78a27ac73070..b2c359c6dd1b 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -158,6 +158,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	bool drop;
 
 	if (!skb) {
+		vars->first_above_time = 0;
 		vars->dropping = false;
 		return skb;
 	}
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 3f3e312bced4..e87eb9769516 100644
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
diff --git a/include/net/netrom.h b/include/net/netrom.h
index f0565a5987d1..2b4685d52bd8 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -46,6 +46,7 @@ enum {
 #define	NR_COND_REJECT			0x02
 #define	NR_COND_PEER_RX_BUSY		0x04
 #define	NR_COND_OWN_RX_BUSY		0x08
+#define	NR_COND_FRAG_DISCARD		0x10
 
 #define NR_DEFAULT_T1			120000		/* Outstanding frames - 120 seconds */
 #define NR_DEFAULT_T2			5000		/* Response delay     - 5 seconds */
@@ -74,7 +75,7 @@ struct nr_sock {
 	unsigned short		vs, vr, va, vl;
 	unsigned char		n2, n2count;
 	unsigned long		t1, t2, t4, idle;
-	unsigned short		fraglen;
+	unsigned int		fraglen;
 	struct timer_list	t1timer;
 	struct timer_list	t2timer;
 	struct timer_list	t4timer;
@@ -114,7 +115,6 @@ struct nr_node {
 	unsigned char		count;
 	struct nr_route		routes[3];
 	refcount_t		refcount;
-	spinlock_t		node_lock;
 };
 
 /*********************************************************************
@@ -144,20 +144,6 @@ static __inline__ void nr_neigh_put(struct nr_neigh *nr_neigh)
 	}
 }
 
-/* nr_node_lock and nr_node_unlock also hold/put the node's refcounter.
- */
-static __inline__ void nr_node_lock(struct nr_node *nr_node)
-{
-	nr_node_hold(nr_node);
-	spin_lock_bh(&nr_node->node_lock);
-}
-
-static __inline__ void nr_node_unlock(struct nr_node *nr_node)
-{
-	spin_unlock_bh(&nr_node->node_lock);
-	nr_node_put(nr_node);
-}
-
 #define nr_neigh_for_each(__nr_neigh, list) \
 	hlist_for_each_entry(__nr_neigh, list, neigh_node)
 
diff --git a/include/net/rose.h b/include/net/rose.h
index 95d1f9c582dc..2fa0331e36f0 100644
--- a/include/net/rose.h
+++ b/include/net/rose.h
@@ -161,17 +161,37 @@ static inline void rose_neigh_put(struct rose_neigh *rose_neigh)
 {
 	if (refcount_dec_and_test(&rose_neigh->use)) {
 		/* We are dropping the last reference, so we are about to free the
-		 * neighbour.  Its timers may still be armed -- t0timer in particular
-		 * re-arms itself in rose_t0timer_expiry().  rose_remove_neigh()
-		 * cancels them before its own put, but callers that drop the final
-		 * reference without first calling rose_remove_neigh() (the socket
-		 * heartbeat reaping path) would otherwise kfree() a neighbour with a
-		 * live timer -> use-after-free.  timer_delete_sync() (not the async
-		 * variant) is required: it waits out a concurrently running handler
-		 * and loops until the self-rearming timer stays stopped.
+		 * neighbour.  t0timer is self-rearming: rose_t0timer_expiry() calls
+		 * rose_start_t0timer() at its own tail, so a plain timer_delete_sync()
+		 * is not enough here.  It only guarantees that the callback is not
+		 * running *at the moment it returns* -- it does nothing to stop the
+		 * very invocation we just waited out from re-arming the timer on its
+		 * way out, which races the kfree() below (syzbot: use-after-free read
+		 * in ax25_find_cb(), reached via rose_t0timer_expiry() ->
+		 * rose_transmit_restart_request() -> rose_send_frame() ->
+		 * ax25_send_frame(), dereferencing the freed neigh->digipeat).
+		 * timer_shutdown_sync() closes that hole: once it returns, any
+		 * further add_timer()/mod_timer() on this timer is silently ignored,
+		 * so a self-rearm racing the free can no longer bring the timer back
+		 * to life on freed memory.  ftimer's handler is a no-op and never
+		 * re-arms, but it is shut down the same way here for consistency --
+		 * this is final teardown, neither timer has any business firing
+		 * again.
 		 */
-		timer_delete_sync(&rose_neigh->ftimer);
-		timer_delete_sync(&rose_neigh->t0timer);
+		timer_shutdown_sync(&rose_neigh->ftimer);
+		timer_shutdown_sync(&rose_neigh->t0timer);
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
@@ -207,6 +227,8 @@ void rose_setup(struct net_device *);
 
 /* rose_in.c */
 int rose_process_rx_frame(struct sock *, struct sk_buff *);
+int rose_rcv_frame(struct sock *sk, struct sk_buff *skb);
+int rose_backlog_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* rose_link.c */
 void rose_start_ftimer(struct rose_neigh *);
@@ -217,6 +239,8 @@ void rose_link_rx_restart(struct sk_buff *, struct rose_neigh *,
 			  unsigned short);
 void rose_transmit_clear_request(struct rose_neigh *, unsigned int,
 				 unsigned char, unsigned char);
+void rose_link_restart(struct rose_neigh *neigh);
+void rose_link_bring_up(struct rose_neigh *neigh);
 void rose_transmit_link(struct sk_buff *, struct rose_neigh *);
 
 /* rose_loopback.c */
@@ -246,6 +270,7 @@ struct rose_neigh *rose_get_neigh(rose_address *, unsigned char *,
 				  unsigned char *, int);
 int rose_rt_ioctl(unsigned int, void __user *);
 void rose_link_failed(ax25_cb *, int);
+void rose_link_restarted(struct rose_neigh *);
 int rose_route_frame(struct sk_buff *, ax25_cb *);
 void rose_rt_free(void);
 
diff --git a/io_uring/cancel.c b/io_uring/cancel.c
index a6e58a20efdd..13d5d4f2924f 100644
--- a/io_uring/cancel.c
+++ b/io_uring/cancel.c
@@ -70,7 +70,16 @@ static bool io_cancel_cb(struct io_wq_work *work, void *data)
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_cancel_data *cd = data;
 
-	return io_cancel_req_match(req, cd);
+	if (!io_cancel_req_match(req, cd))
+		return false;
+	/*
+	 * Pending work is gone once it has matched. Work that is running may
+	 * park the request where the same cancellation looks next. Don't make
+	 * it skip the request as one that it has dealt with.
+	 */
+	if (cd->flags & (IORING_ASYNC_CANCEL_ALL | IORING_ASYNC_CANCEL_ANY))
+		req->cancel_seq_set = false;
+	return true;
 }
 
 static int io_async_cancel_one(struct io_uring_task *tctx,
@@ -115,6 +124,8 @@ int io_try_cancel(struct io_uring_task *tctx, struct io_cancel_data *cd,
 	 */
 	if (!ret)
 		return 0;
+	if (ret == -EALREADY)
+		cd->running = true;
 
 	ret = io_poll_cancel(ctx, cd, issue_flags);
 	if (ret != -ENOENT)
@@ -171,6 +182,7 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 	struct io_tctx_node *node;
 	int ret, nr = 0;
 
+	cd->running = false;
 	do {
 		ret = io_try_cancel(tctx, cd, issue_flags);
 		if (ret == -ENOENT)
@@ -184,6 +196,9 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 	io_ring_submit_lock(ctx, issue_flags);
 	ret = -ENOENT;
 	list_for_each_entry(node, &ctx->tctx_list, ctx_node) {
+		/* has been done above, don't count what is running there */
+		if (all && node->task->io_uring == tctx)
+			continue;
 		ret = io_async_cancel_one(node->task->io_uring, cd);
 		if (ret != -ENOENT) {
 			if (!all)
@@ -192,7 +207,15 @@ static int __io_async_cancel(struct io_cancel_data *cd,
 		}
 	}
 	io_ring_submit_unlock(ctx, issue_flags);
-	return all ? nr : ret;
+	if (all)
+		return nr;
+	/*
+	 * The worker may be done with the work that was found running, and
+	 * flagged, above. That isn't the same as not having found it.
+	 */
+	if (ret == -ENOENT && cd->running)
+		ret = -EALREADY;
+	return ret;
 }
 
 int io_async_cancel(struct io_kiocb *req, unsigned int issue_flags)
@@ -304,7 +327,7 @@ int io_sync_cancel(struct io_ring_ctx *ctx, void __user *arg)
 	if (ret != -EALREADY)
 		goto out;
 
-	if (sc.timeout.tv_sec != -1UL || sc.timeout.tv_nsec != -1UL) {
+	if (sc.timeout.tv_sec != -1 || sc.timeout.tv_nsec != -1) {
 		struct timespec64 ts = {
 			.tv_sec		= sc.timeout.tv_sec,
 			.tv_nsec	= sc.timeout.tv_nsec
diff --git a/io_uring/cancel.h b/io_uring/cancel.h
index da13a1d82062..3f54b040efe4 100644
--- a/io_uring/cancel.h
+++ b/io_uring/cancel.h
@@ -11,6 +11,8 @@ struct io_cancel_data {
 	u8 opcode;
 	u32 flags;
 	int seq;
+	/* io_try_cancel() has found it being run by io-wq, and flagged it */
+	bool running;
 };
 
 int io_async_cancel_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 589769761cea..990568baf393 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -307,6 +307,8 @@ int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags)
 		 */
 		__set_current_state(TASK_RUNNING);
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
+		if (io_wq_cancel_seen(req, issue_flags))
+			__io_futex_cancel(ctx, req);
 	} else {
 		iof->futexv_unqueued = 1;
 		if (woken != -1)
@@ -348,9 +350,10 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 			       &ifd->q, &hb);
 	if (!ret) {
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
-		io_ring_submit_unlock(ctx, issue_flags);
-
 		futex_queue(&ifd->q, hb, NULL);
+		if (io_wq_cancel_seen(req, issue_flags))
+			__io_futex_cancel(ctx, req);
+		io_ring_submit_unlock(ctx, issue_flags);
 		return IOU_ISSUE_SKIP_COMPLETE;
 	}
 
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 3c1818e8feaa..965dc487f240 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -54,6 +54,8 @@ struct io_worker {
 	struct io_wq *wq;
 
 	struct io_wq_work *cur_work;
+	/* rest of the hashed chain ->cur_work was taken off the list with */
+	struct io_wq_work *next_work;
 	raw_spinlock_t lock;
 
 	struct completion ref_done;
@@ -98,6 +100,7 @@ enum {
 struct io_wq {
 	unsigned long state;
 
+	put_work_fn *put_work;
 	free_work_fn *free_work;
 	io_wq_work_fn *do_work;
 
@@ -534,6 +537,17 @@ static struct io_wq_work *io_get_next_work(struct io_wq_acct *acct,
 	return NULL;
 }
 
+static void __io_assign_current_work(struct io_worker *worker,
+				     struct io_wq_work *work)
+{
+	raw_spin_lock(&worker->lock);
+	worker->cur_work = work;
+	/* stays valid while in between two items of a chain */
+	if (work)
+		worker->next_work = wq_next_work(work);
+	raw_spin_unlock(&worker->lock);
+}
+
 static void io_assign_current_work(struct io_worker *worker,
 				   struct io_wq_work *work)
 {
@@ -542,9 +556,7 @@ static void io_assign_current_work(struct io_worker *worker,
 		cond_resched();
 	}
 
-	raw_spin_lock(&worker->lock);
-	worker->cur_work = work;
-	raw_spin_unlock(&worker->lock);
+	__io_assign_current_work(worker, work);
 }
 
 /*
@@ -575,9 +587,7 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 			 * work list, but isn't yet discoverable as the
 			 * current work item for this worker.
 			 */
-			raw_spin_lock(&worker->lock);
-			worker->cur_work = work;
-			raw_spin_unlock(&worker->lock);
+			__io_assign_current_work(worker, work);
 		}
 
 		raw_spin_unlock(&acct->lock);
@@ -593,18 +603,26 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 		/* handle a whole dependent link */
 		do {
 			bool do_kill = test_bit(IO_WQ_BIT_EXIT, &wq->state);
-			struct io_wq_work *next_hashed, *linked;
+			struct io_wq_work *next_hashed, *linked, *done = work;
 			unsigned int hash = io_get_work_hash(work);
+			bool last;
 
 			next_hashed = wq_next_work(work);
 
+			/*
+			 * io_wq_exit_workers() signals us once, so that we
+			 * don't sleep for ever. If that was before this work
+			 * became the current one, the signal is gone.
+			 */
 			if (do_kill &&
 			    (atomic_read(&work->flags) & IO_WQ_WORK_UNBOUND))
 				atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
+			else if (do_kill)
+				set_notify_signal(current);
 			wq->do_work(work);
 			io_assign_current_work(worker, NULL);
 
-			linked = wq->free_work(work);
+			last = wq->put_work(work, &linked);
 			work = next_hashed;
 			if (!work && linked && !io_wq_is_hashed(linked)) {
 				work = linked;
@@ -613,6 +631,13 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 			io_assign_current_work(worker, work);
 			if (linked)
 				io_wq_enqueue(wq, linked);
+			/*
+			 * Not before the link is current or pending work again.
+			 * This may be the last time that a task is woken up
+			 * which exits and looks for requests to cancel.
+			 */
+			if (last)
+				wq->free_work(done);
 
 			if (hash != -1U && !next_hashed) {
 				/* serialize hash clear with wake_up() */
@@ -631,6 +656,37 @@ static void io_worker_handle_work(struct io_wq_acct *acct,
 	} while (1);
 }
 
+/*
+ * The worker has decided to exit, and has given up its ->nr_workers slot and
+ * its place on the free list. io_wq_enqueue() may have picked it from that
+ * list, or seen it running, after it last looked at the work list. Leave
+ * ->nr_running as well and check again. Returns false if the worker has to
+ * stay.
+ */
+static bool io_worker_retire(struct io_wq_acct *acct, struct io_worker *worker)
+{
+	struct io_wq *wq = worker->wq;
+
+	/* turns io_wq_dec_running() and the scheduler hooks into no-ops */
+	clear_bit(IO_WORKER_F_UP, &worker->flags);
+	atomic_dec(&acct->nr_running);
+	if (!io_acct_run_queue(acct))
+		return true;
+	raw_spin_unlock(&acct->lock);
+
+	raw_spin_lock(&wq->lock);
+	if (acct->nr_workers >= acct->max_workers) {
+		/* a worker was created in our place, the work is its business */
+		raw_spin_unlock(&wq->lock);
+		return true;
+	}
+	acct->nr_workers++;
+	raw_spin_unlock(&wq->lock);
+	atomic_inc(&acct->nr_running);
+	set_bit(IO_WORKER_F_UP, &worker->flags);
+	return false;
+}
+
 static int io_wq_worker(void *data)
 {
 	struct io_worker *worker = data;
@@ -661,12 +717,21 @@ static int io_wq_worker(void *data)
 		/*
 		 * Last sleep timed out. Exit if we're not the last worker,
 		 * or if someone modified our affinity.
+		 * Not as long as a request of ours for another worker is
+		 * pending, though. It is accounted as a running worker, which
+		 * others rely on, and io_worker_exit() would cancel it.
 		 */
-		if (last_timeout && (exit_mask || acct->nr_workers > 1)) {
+		if (last_timeout && (exit_mask || acct->nr_workers > 1) &&
+		    !test_bit(0, &worker->create_state)) {
 			acct->nr_workers--;
+			if (test_and_clear_bit(IO_WORKER_F_FREE, &worker->flags))
+				hlist_nulls_del_init_rcu(&worker->nulls_node);
 			raw_spin_unlock(&wq->lock);
 			__set_current_state(TASK_RUNNING);
-			break;
+			if (io_worker_retire(acct, worker))
+				break;
+			last_timeout = false;
+			continue;
 		}
 		last_timeout = false;
 		__io_worker_idle(wq, worker);
@@ -913,9 +978,13 @@ static bool io_wq_worker_wake(struct io_worker *worker, void *data)
 static void io_run_cancel(struct io_wq_work *work, struct io_wq *wq)
 {
 	do {
+		struct io_wq_work *linked;
+
 		atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
 		wq->do_work(work);
-		work = wq->free_work(work);
+		if (wq->put_work(work, &linked))
+			wq->free_work(work);
+		work = linked;
 	} while (work);
 }
 
@@ -1023,6 +1092,7 @@ static bool __io_wq_worker_cancel(struct io_worker *worker,
 static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 {
 	struct io_cb_cancel_data *match = data;
+	struct io_wq_work *work;
 
 	/*
 	 * Hold the lock to avoid ->cur_work going out of scope, caller
@@ -1031,6 +1101,19 @@ static bool io_wq_worker_cancel(struct io_worker *worker, void *data)
 	raw_spin_lock(&worker->lock);
 	if (__io_wq_worker_cancel(worker, match, worker->cur_work))
 		match->nr_running++;
+	/*
+	 * Hashed work is taken off the work list a chain at a time, what the
+	 * worker hasn't started yet can only be found here. It doesn't move on
+	 * without the lock. Just mark the work, it fails once it is its turn.
+	 */
+	for (work = worker->next_work; work; work = wq_next_work(work)) {
+		if (match->nr_running && !match->cancel_all)
+			break;
+		if (match->fn(work, match->data)) {
+			atomic_or(IO_WQ_WORK_CANCEL, &work->flags);
+			match->nr_running++;
+		}
+	}
 	raw_spin_unlock(&worker->lock);
 
 	return match->nr_running && !match->cancel_all;
@@ -1167,7 +1250,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 	int ret, i;
 	struct io_wq *wq;
 
-	if (WARN_ON_ONCE(!data->free_work || !data->do_work))
+	if (WARN_ON_ONCE(!data->put_work || !data->free_work || !data->do_work))
 		return ERR_PTR(-EINVAL);
 	if (WARN_ON_ONCE(!bounded))
 		return ERR_PTR(-EINVAL);
@@ -1178,6 +1261,7 @@ struct io_wq *io_wq_create(unsigned bounded, struct io_wq_data *data)
 
 	refcount_inc(&data->hash->refs);
 	wq->hash = data->hash;
+	wq->put_work = data->put_work;
 	wq->free_work = data->free_work;
 	wq->do_work = data->do_work;
 
@@ -1234,6 +1318,8 @@ static bool io_task_work_match(struct callback_head *cb, void *data)
 void io_wq_exit_start(struct io_wq *wq)
 {
 	set_bit(IO_WQ_BIT_EXIT, &wq->state);
+	/* Pairs with task_work_add() in io_queue_worker_create(). */
+	smp_mb__after_atomic();
 }
 
 static void io_wq_cancel_tw_create(struct io_wq *wq)
diff --git a/io_uring/io-wq.h b/io_uring/io-wq.h
index b3b004a7b625..aeddc5b2b867 100644
--- a/io_uring/io-wq.h
+++ b/io_uring/io-wq.h
@@ -21,7 +21,8 @@ enum io_wq_cancel {
 	IO_WQ_CANCEL_NOTFOUND,	/* work not found */
 };
 
-typedef struct io_wq_work *(free_work_fn)(struct io_wq_work *);
+typedef bool (put_work_fn)(struct io_wq_work *, struct io_wq_work **);
+typedef void (free_work_fn)(struct io_wq_work *);
 typedef void (io_wq_work_fn)(struct io_wq_work *);
 
 struct io_wq_hash {
@@ -40,6 +41,7 @@ struct io_wq_data {
 	struct io_wq_hash *hash;
 	struct task_struct *task;
 	io_wq_work_fn *do_work;
+	put_work_fn *put_work;
 	free_work_fn *free_work;
 };
 
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 0076c7599c94..fdf7c646da1a 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -48,6 +48,7 @@
 #include <linux/uio.h>
 #include <linux/bits.h>
 
+#include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/fs.h>
 #include <linux/file.h>
@@ -481,17 +482,46 @@ static void io_prep_async_link(struct io_kiocb *req)
 	}
 }
 
+/* Called for every request that is issued: keep it inline */
+static __always_inline bool io_assign_file(struct io_kiocb *req,
+					   const struct io_issue_def *def,
+					   unsigned int issue_flags)
+{
+	if (req->file || !def->needs_file)
+		return true;
+
+	if (req->flags & REQ_F_FIXED_FILE)
+		req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
+	else
+		req->file = io_file_get_normal(req, req->cqe.fd);
+
+	return !!req->file;
+}
+
 static void io_queue_iowq(struct io_kiocb *req)
 {
 	struct io_uring_task *tctx = req->task->io_uring;
 
 	BUG_ON(!tctx);
+	lockdep_assert_held(&req->ctx->uring_lock);
 
 	if ((current->flags & PF_KTHREAD) || !tctx->io_wq) {
 		io_req_task_queue_fail(req, -ECANCELED);
 		return;
 	}
 
+	/*
+	 * The file is looked up as late as possible, as it may be the result
+	 * of an earlier request of the link. This one is up now, and what kind
+	 * of work it is depends on the file. If that fails, leave the error
+	 * handling to the worker.
+	 *
+	 * Not for a splice: whatever it writes to, it may wait for its input
+	 * for ever. It has to remain unbound work that isn't hashed.
+	 */
+	if (req->opcode != IORING_OP_SPLICE)
+		io_assign_file(req, &io_issue_defs[req->opcode], 0);
+
 	/* init ->work of the whole link before punting */
 	io_prep_async_link(req);
 
@@ -1143,6 +1173,31 @@ void tctx_task_work(struct callback_head *cb)
 	WARN_ON_ONCE(ret);
 }
 
+static void io_poll_wq_wake_rcu(struct rcu_head *rcu)
+{
+	struct io_ring_ctx *ctx = container_of(rcu, struct io_ring_ctx,
+					       poll_wq_rcu);
+
+	atomic_set(&ctx->poll_wq_rcu_pending, 0);
+	io_poll_wq_wake(ctx);
+	percpu_ref_put(&ctx->refs);
+}
+
+/*
+ * io_uring_poll() reports pending local work as EPOLLIN, as it takes a trip to
+ * the kernel to turn it into CQEs. Let those know who are asleep already.
+ * This may be called from a wake up handler with some wait queue lock held,
+ * and this wake up could lead back to it. Do it from a clean context.
+ */
+static void io_local_work_wake_poll(struct io_ring_ctx *ctx)
+{
+	if (!wq_has_sleeper(&ctx->poll_wq) ||
+	    atomic_xchg(&ctx->poll_wq_rcu_pending, 1))
+		return;
+	percpu_ref_get(&ctx->refs);
+	call_rcu_hurry(&ctx->poll_wq_rcu, io_poll_wq_wake_rcu);
+}
+
 static inline void io_req_local_work_add(struct io_kiocb *req,
 					 struct io_ring_ctx *ctx,
 					 unsigned flags)
@@ -1202,6 +1257,9 @@ static inline void io_req_local_work_add(struct io_kiocb *req,
 			atomic_or(IORING_SQ_TASKRUN, &ctx->rings->sq_flags);
 		if (ctx->has_evfd)
 			io_eventfd_signal(ctx, flags & IOU_F_TWQ_IN_WAKE);
+		/* whoever sets the flag wakes ->poll_wq afterwards */
+		if (ctx->poll_activated)
+			io_local_work_wake_poll(ctx);
 	}
 
 	nr_wait = atomic_read(&ctx->cq_wait_nr);
@@ -1696,20 +1754,6 @@ static __cold void io_drain_req(struct io_kiocb *req)
 	spin_unlock(&ctx->completion_lock);
 }
 
-static bool io_assign_file(struct io_kiocb *req, const struct io_issue_def *def,
-			   unsigned int issue_flags)
-{
-	if (req->file || !def->needs_file)
-		return true;
-
-	if (req->flags & REQ_F_FIXED_FILE)
-		req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
-	else
-		req->file = io_file_get_normal(req, req->cqe.fd);
-
-	return !!req->file;
-}
-
 #define REQ_ISSUE_SLOW_FLAGS	(REQ_F_CREDS | REQ_F_ARM_LTIMEOUT)
 
 static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
@@ -1745,6 +1789,9 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	if (ret == IOU_OK) {
+		/* not all handlers take care of the internal restart codes */
+		if (unlikely(req->cqe.res <= -ERESTARTSYS))
+			req->cqe.res = io_fixup_restart_res(req->cqe.res);
 		if (issue_flags & IO_URING_F_COMPLETE_DEFER)
 			io_req_complete_defer(req);
 		else
@@ -1760,6 +1807,8 @@ static int io_issue_sqe(struct io_kiocb *req, unsigned int issue_flags)
 		if ((req->ctx->flags & IORING_SETUP_IOPOLL) && def->iopoll_queue)
 			io_iopoll_req_issued(req, issue_flags);
 	}
+	if (unlikely(ret <= -ERESTARTSYS))
+		ret = io_fixup_restart_res(ret);
 	return ret;
 }
 
@@ -1770,17 +1819,30 @@ int io_poll_issue(struct io_kiocb *req, struct io_tw_state *ts)
 				 IO_URING_F_COMPLETE_DEFER);
 }
 
-struct io_wq_work *io_wq_free_work(struct io_wq_work *work)
+/*
+ * io-wq is done with @work. Returns true if it held the last reference, and
+ * hands out the next request of the link then. The caller has to make sure
+ * that cancellations can find the latter before it calls io_wq_free_work().
+ */
+bool io_wq_put_work(struct io_wq_work *work, struct io_wq_work **linked)
 {
 	struct io_kiocb *req = container_of(work, struct io_kiocb, work);
 	struct io_kiocb *nxt = NULL;
 
-	if (req_ref_put_and_test_atomic(req)) {
-		if (req->flags & IO_REQ_LINK_FLAGS)
-			nxt = io_req_find_next(req);
-		io_free_req(req);
-	}
-	return nxt ? &nxt->work : NULL;
+	*linked = NULL;
+	if (!req_ref_put_and_test_atomic(req))
+		return false;
+
+	if (req->flags & IO_REQ_LINK_FLAGS)
+		nxt = io_req_find_next(req);
+	if (nxt)
+		*linked = &nxt->work;
+	return true;
+}
+
+void io_wq_free_work(struct io_wq_work *work)
+{
+	io_free_req(container_of(work, struct io_kiocb, work));
 }
 
 void io_wq_submit_work(struct io_wq_work *work)
@@ -1791,7 +1853,7 @@ void io_wq_submit_work(struct io_wq_work *work)
 	bool needs_poll = false;
 	int ret = 0, err = -ECANCELED;
 
-	/* one will be dropped by ->io_wq_free_work() after returning to io-wq */
+	/* one will be dropped by ->put_work() after returning to io-wq */
 	if (!(req->flags & REQ_F_REFCOUNT))
 		__io_req_set_refcount(req, 2);
 	else
@@ -2343,7 +2405,8 @@ static int io_wake_function(struct wait_queue_entry *curr, unsigned int mode,
 	 */
 	if (io_should_wake(iowq) || io_has_work(iowq->ctx))
 		return autoremove_wake_function(curr, mode, wake_flags, key);
-	return -1;
+	/* keep going, a waiter further down may be content with less */
+	return 0;
 }
 
 int io_run_task_work_sig(struct io_ring_ctx *ctx)
@@ -2393,9 +2456,16 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	if (iowq->timeout == KTIME_MAX ||
 	    ktime_compare(iowq->min_timeout, iowq->timeout) >= 0)
 		goto out_wake;
-	/* work we may need to run, wake function will see if we need to wake */
-	if (io_has_work(ctx))
-		goto out_wake;
+	/*
+	 * Work we need to run. It isn't known if that is going to post a CQE,
+	 * so this isn't a timeout. Carry on with the normal one if it doesn't.
+	 */
+	if (io_has_work(ctx)) {
+		iowq->min_timeout = 0;
+		iowq->cq_tail = iowq->cq_min_tail + 1;
+		wake_up_process(iowq->wq.private);
+		return HRTIMER_NORESTART;
+	}
 	/* got events since we started waiting, min timeout is done */
 	if (iowq->cq_min_tail != READ_ONCE(ctx->rings->cq.tail))
 		goto out_wake;
@@ -2426,12 +2496,21 @@ static enum hrtimer_restart io_cqring_min_timer_wakeup(struct hrtimer *timer)
 	return io_cqring_timer_wakeup(timer);
 }
 
+/* Same policy as for hrtimer sleepers, see __hrtimer_setup_sleeper(). */
+static enum hrtimer_mode io_cqring_timer_mode(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && rt_or_dl_task_policy(current))
+		return HRTIMER_MODE_ABS_HARD;
+	return HRTIMER_MODE_ABS;
+}
+
 static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 				      clockid_t clock_id, ktime_t start_time)
 {
+	enum hrtimer_mode mode = io_cqring_timer_mode();
 	ktime_t timeout;
 
-	hrtimer_init_on_stack(&iowq->t, clock_id, HRTIMER_MODE_ABS);
+	hrtimer_init_on_stack(&iowq->t, clock_id, mode);
 	if (iowq->min_timeout) {
 		timeout = ktime_add_ns(iowq->min_timeout, start_time);
 		iowq->t.function = io_cqring_min_timer_wakeup;
@@ -2441,7 +2520,7 @@ static int io_cqring_schedule_timeout(struct io_wait_queue *iowq,
 	}
 
 	hrtimer_set_expires_range_ns(&iowq->t, timeout, 0);
-	hrtimer_start_expires(&iowq->t, HRTIMER_MODE_ABS);
+	hrtimer_start_expires(&iowq->t, mode);
 
 	if (!READ_ONCE(iowq->hit_timeout))
 		schedule();
@@ -2608,9 +2687,18 @@ static int io_cqring_wait(struct io_ring_ctx *ctx, int min_events, u32 flags,
 
 		check_cq = READ_ONCE(ctx->check_cq);
 		if (unlikely(check_cq)) {
-			/* let the caller flush overflows, retry */
-			if (check_cq & BIT(IO_CHECK_CQ_OVERFLOW_BIT))
+			if (check_cq & BIT(IO_CHECK_CQ_OVERFLOW_BIT)) {
 				io_cqring_do_overflow_flush(ctx);
+				/*
+				 * No room for what has overflown. It takes the
+				 * application to change that, so return to it.
+				 */
+				if (test_bit(IO_CHECK_CQ_OVERFLOW_BIT,
+					     &ctx->check_cq)) {
+					ret = 0;
+					break;
+				}
+			}
 			if (check_cq & BIT(IO_CHECK_CQ_DROPPED_BIT)) {
 				ret = -EBADR;
 				break;
@@ -2851,6 +2939,7 @@ struct io_tctx_exit {
 	struct callback_head		task_work;
 	struct completion		completion;
 	struct io_ring_ctx		*ctx;
+	bool				in_cancel;
 };
 
 static __cold void io_tctx_exit_cb(struct callback_head *cb)
@@ -2865,7 +2954,8 @@ static __cold void io_tctx_exit_cb(struct callback_head *cb)
 	 * tctx can be NULL if the queueing of this task_work raced with
 	 * work cancelation off the exec path.
 	 */
-	if (tctx && !atomic_read(&tctx->in_cancel))
+	work->in_cancel = tctx && atomic_read(&tctx->in_cancel);
+	if (tctx && !work->in_cancel)
 		io_uring_del_tctx_node((unsigned long)work->ctx);
 	complete(&work->completion);
 }
@@ -2959,6 +3049,14 @@ static __cold void io_ring_exit_work(struct work_struct *work)
 		 * wait is marked as interruptible.
 		 */
 		wait_for_completion_interruptible(&exit.completion);
+		/*
+		 * The task removes the node when it is done with its
+		 * cancellation. Give it the time for that: it doesn't get back
+		 * to it as long as it finds new task_work each time it has run
+		 * the old one, and we may be one of many who send it.
+		 */
+		if (exit.in_cancel)
+			schedule_timeout_idle(HZ / 20);
 		mutex_lock(&ctx->uring_lock);
 	}
 	mutex_unlock(&ctx->uring_lock);
@@ -3190,12 +3288,11 @@ __cold void io_uring_cancel_generic(bool cancel_all, struct io_sq_data *sqd)
 		prepare_to_wait(&tctx->wait, &wait, TASK_INTERRUPTIBLE);
 		io_run_task_work();
 		io_uring_drop_tctx_refs(current);
+		/* only skip the sleep for local work this task may run */
 		xa_for_each(&tctx->xa, index, node) {
-			if (!llist_empty(&node->ctx->work_llist)) {
-				WARN_ON_ONCE(node->ctx->submitter_task &&
-					     node->ctx->submitter_task != current);
+			if (!llist_empty(&node->ctx->work_llist) &&
+			    io_allowed_defer_tw_run(node->ctx))
 				goto end_wait;
-			}
 		}
 		/*
 		 * If we've seen completions, retry without waiting. This
diff --git a/io_uring/io_uring.h b/io_uring/io_uring.h
index f1d3b4928997..628ced4b44b2 100644
--- a/io_uring/io_uring.h
+++ b/io_uring/io_uring.h
@@ -101,7 +101,8 @@ int io_submit_sqes(struct io_ring_ctx *ctx, unsigned int nr);
 int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin);
 void __io_submit_flush_completions(struct io_ring_ctx *ctx);
 
-struct io_wq_work *io_wq_free_work(struct io_wq_work *work);
+bool io_wq_put_work(struct io_wq_work *work, struct io_wq_work **linked);
+void io_wq_free_work(struct io_wq_work *work);
 void io_wq_submit_work(struct io_wq_work *work);
 
 void io_free_req(struct io_kiocb *req);
@@ -202,6 +203,24 @@ static __always_inline bool io_fill_cqe_req(struct io_ring_ctx *ctx,
 	return true;
 }
 
+static inline ssize_t io_fixup_restart_res(ssize_t ret)
+{
+	switch (ret) {
+	case -ERESTARTSYS:
+	case -ERESTARTNOINTR:
+	case -ERESTARTNOHAND:
+	case -ERESTART_RESTARTBLOCK:
+		/*
+		 * We can't just restart the syscall, since previously
+		 * submitted sqes may already be in progress. Just fail
+		 * this IO with EINTR.
+		 */
+		return -EINTR;
+	default:
+		return ret;
+	}
+}
+
 static inline void req_set_fail(struct io_kiocb *req)
 {
 	req->flags |= REQ_F_FAIL;
@@ -250,6 +269,29 @@ static inline void io_ring_submit_lock(struct io_ring_ctx *ctx,
 	lockdep_assert_held(&ctx->uring_lock);
 }
 
+/*
+ * For a handler that is run by io-wq and parks the request on a list where
+ * cancellations find it, rather than completing it. Whoever tried to cancel
+ * the request before that found it running. It has flagged the work item,
+ * has searched the list in vain, and won't come back. To be called with
+ * the lock the search takes held: if the search came first, the flag is
+ * visible. For most lists that is ->uring_lock, timeouts use ->timeout_lock.
+ */
+static inline bool __io_wq_cancel_seen(struct io_kiocb *req,
+				       unsigned int issue_flags)
+{
+	return (issue_flags & IO_URING_F_IOWQ) &&
+	       (atomic_read(&req->work.flags) & IO_WQ_WORK_CANCEL);
+}
+
+static inline bool io_wq_cancel_seen(struct io_kiocb *req,
+				     unsigned int issue_flags)
+{
+	lockdep_assert_held(&req->ctx->uring_lock);
+
+	return __io_wq_cancel_seen(req, issue_flags);
+}
+
 static inline void io_commit_cqring(struct io_ring_ctx *ctx)
 {
 	/* order cqe stores with ring update */
diff --git a/io_uring/kbuf.c b/io_uring/kbuf.c
index df5ba0d7fbb3..b1c5e80b94fa 100644
--- a/io_uring/kbuf.c
+++ b/io_uring/kbuf.c
@@ -181,7 +181,7 @@ static struct io_br_sel io_ring_buffer_select(struct io_kiocb *req, size_t *len,
 	if (unlikely(tail == head))
 		return sel;
 
-	if (head + 1 == tail)
+	if ((__u16)(head + 1) == tail)
 		req->flags |= REQ_F_BL_EMPTY;
 
 	buf = io_ring_head_to_buf(br, head, bl->mask);
diff --git a/io_uring/napi.c b/io_uring/napi.c
index 5542d78a4bd8..bdae13367e0f 100644
--- a/io_uring/napi.c
+++ b/io_uring/napi.c
@@ -6,7 +6,7 @@
 #ifdef CONFIG_NET_RX_BUSY_POLL
 
 /* Timeout for cleanout of stale entries. */
-#define NAPI_TIMEOUT		(60 * SEC_CONVERSION)
+#define NAPI_TIMEOUT		(60 * HZ)
 
 struct io_napi_entry {
 	unsigned int		napi_id;
@@ -288,6 +288,8 @@ void __io_napi_busy_loop(struct io_ring_ctx *ctx, struct io_wait_queue *iowq)
 	if (iowq->timeout != KTIME_MAX) {
 		ktime_t dt = ktime_sub(iowq->timeout, io_get_time(ctx));
 
+		/* an absolute timeout may have passed already */
+		dt = max_t(ktime_t, dt, 0);
 		iowq->napi_busy_poll_dt = min_t(u64, iowq->napi_busy_poll_dt, dt);
 	}
 
diff --git a/io_uring/net.c b/io_uring/net.c
index f738f0da87a5..b7f7c5fa0bf8 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -500,6 +500,24 @@ static int io_bundle_nbufs(struct io_async_msghdr *kmsg, int ret)
 	return nbufs;
 }
 
+/*
+ * A receive that is retried after a partial transfer keeps writing to what it
+ * has mapped. io_net_kbuf_recyle() only commits what was filled so far, which
+ * takes a buffer out of circulation if it's a single one that is consumed as a
+ * whole. The tail of an incrementally consumed buffer, or the yet unused
+ * buffers of a bundle, would be up for grabs. They can't be committed in
+ * advance either, the CQE has no way to tell if they end up not being used.
+ */
+static bool io_net_kbuf_can_retry(struct io_kiocb *req,
+				  struct io_buffer_list *bl,
+				  struct io_async_msghdr *kmsg)
+{
+	/* not ring provided, or committed at selection time */
+	if (!(req->flags & REQ_F_BUFFERS_COMMIT))
+		return true;
+	return !(bl->flags & IOBL_INC) && iter_is_ubuf(&kmsg->msg.msg_iter);
+}
+
 static int io_net_kbuf_recyle(struct io_kiocb *req, struct io_buffer_list *bl,
 			      struct io_async_msghdr *kmsg, int len)
 {
@@ -1086,7 +1104,8 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 				return IOU_ISSUE_SKIP_COMPLETE;
 			return -EAGAIN;
 		}
-		if (ret > 0 && io_net_retry(sock, flags)) {
+		if (ret > 0 && io_net_retry(sock, flags) &&
+		    io_net_kbuf_can_retry(req, sel.buf_list, kmsg)) {
 			sr->done_io += ret;
 			return io_net_kbuf_recyle(req, sel.buf_list, kmsg, ret);
 		}
@@ -1169,6 +1188,8 @@ static int io_recv_buf_select(struct io_kiocb *req, struct io_async_msghdr *kmsg
 		*sel = io_buffer_select(req, &len, issue_flags);
 		if (!sel->addr)
 			return -ENOBUFS;
+		/* ring provided buffers can be up to 4G, keep len an int */
+		len = min_t(size_t, len, MAX_RW_COUNT);
 		sr->buf = sel->addr;
 		sr->len = len;
 map_ubuf:
@@ -1233,7 +1254,8 @@ int io_recv(struct io_kiocb *req, unsigned int issue_flags)
 				return IOU_ISSUE_SKIP_COMPLETE;
 			return -EAGAIN;
 		}
-		if (ret > 0 && io_net_retry(sock, flags)) {
+		if (ret > 0 && io_net_retry(sock, flags) &&
+		    io_net_kbuf_can_retry(req, sel.buf_list, kmsg)) {
 			sr->len -= ret;
 			sr->buf += ret;
 			sr->done_io += ret;
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 1a6179ac491b..31454c27072b 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -264,12 +264,14 @@ static inline void io_poll_execute(struct io_kiocb *req, int res,
  */
 static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 {
+	bool again;
 	int v;
 
 	if (unlikely(io_should_terminate_tw(req->ctx)))
 		return -ECANCELED;
 
 	do {
+		again = false;
 		v = atomic_read(&req->poll_refs);
 
 		if (unlikely(v != 1)) {
@@ -331,9 +333,15 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 		} else {
 			int ret;
 
-			/* multiple refs and HUP, ensure we loop once more */
-			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1)
-				v--;
+			/*
+			 * Multiple refs and HUP, ensure we loop once more. Drop
+			 * down to one ref now, so the next pass ends unless a
+			 * wake up came in.
+			 */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1) {
+				atomic_sub(v - 1, &req->poll_refs);
+				again = true;
+			}
 			ret = io_poll_issue(req, ts);
 			if (ret == IOU_STOP_MULTISHOT)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
@@ -350,7 +358,8 @@ static int io_poll_check_events(struct io_kiocb *req, struct io_tw_state *ts)
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
+		v &= IO_POLL_REF_MASK;
+	} while (again || atomic_cmpxchg(&req->poll_refs, v, 0) != v);
 
 	io_napi_add(req);
 	return IOU_POLL_NO_ACTION;
@@ -656,6 +665,18 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 
 	io_poll_add_hash(req);
 
+	/*
+	 * Whoever tried to cancel the request while io-wq was running it has
+	 * flagged the work item. If it searched the hash table before the
+	 * request got there it found nothing, and it won't come back. Both
+	 * the search and the insertion are done with ->uring_lock held, and
+	 * the flag is set before the search. If the search came first,
+	 * the flag is visible by now.
+	 */
+	if (ipt->owning &&
+	    (atomic_read(&req->work.flags) & IO_WQ_WORK_CANCEL))
+		io_poll_mark_cancelled(req);
+
 	if (mask && (poll->events & EPOLLET) &&
 	    io_poll_can_finish_inline(req, ipt)) {
 		__io_poll_execute(req, mask, 0);
@@ -984,6 +1005,18 @@ int io_poll_add(struct io_kiocb *req, unsigned int issue_flags)
 	if (req->ctx->flags & (IORING_SETUP_SQPOLL|IORING_SETUP_SINGLE_ISSUER))
 		req->flags |= REQ_F_HASH_LOCKED;
 
+	/*
+	 * A poll update or a spurious wake up arms the request again. Forget
+	 * the entries of the previous round like io_arm_apoll() does, a stale
+	 * second entry would be taken for a third wait queue.
+	 */
+	if (req_has_async_data(req)) {
+		kfree(req->async_data);
+		req->async_data = NULL;
+		req->flags &= ~REQ_F_ASYNC_DATA;
+	}
+	req->flags &= ~(REQ_F_SINGLE_POLL | REQ_F_DOUBLE_POLL);
+
 	ret = __io_arm_poll_handler(req, poll, &ipt, poll->events, issue_flags);
 	if (ret > 0) {
 		io_req_set_res(req, ipt.result_mask, 0);
diff --git a/io_uring/rw.c b/io_uring/rw.c
index c8a536ce2fe3..b18b10cdbb52 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -560,24 +560,6 @@ static void io_complete_rw_iopoll(struct kiocb *kiocb, long res)
 	smp_store_release(&req->iopoll_completed, 1);
 }
 
-static inline ssize_t io_fixup_restart_res(ssize_t ret)
-{
-	switch (ret) {
-	case -ERESTARTSYS:
-	case -ERESTARTNOINTR:
-	case -ERESTARTNOHAND:
-	case -ERESTART_RESTARTBLOCK:
-		/*
-		 * We can't just restart the syscall, since previously
-		 * submitted sqes may already be in progress. Just fail
-		 * this IO with EINTR.
-		 */
-		return -EINTR;
-	default:
-		return ret;
-	}
-}
-
 static inline void io_rw_done(struct kiocb *kiocb, ssize_t ret)
 {
 	/* IO was queued async, completion will happen later */
diff --git a/io_uring/sqpoll.c b/io_uring/sqpoll.c
index b39067a049fd..1ea2e35e4ce8 100644
--- a/io_uring/sqpoll.c
+++ b/io_uring/sqpoll.c
@@ -387,6 +387,13 @@ static int io_sq_thread(void *data)
 				 */
 				smp_mb__after_atomic();
 
+				/*
+				 * Nothing gets submitted before the ring is
+				 * enabled, which comes with a wake up.
+				 */
+				if (READ_ONCE(ctx->flags) & IORING_SETUP_R_DISABLED)
+					continue;
+
 				if (io_sqring_entries(ctx)) {
 					needs_sched = false;
 					break;
diff --git a/io_uring/tctx.c b/io_uring/tctx.c
index 84f6a8385720..8597bcb903b2 100644
--- a/io_uring/tctx.c
+++ b/io_uring/tctx.c
@@ -35,6 +35,7 @@ static struct io_wq *io_init_wq_offload(struct io_ring_ctx *ctx,
 
 	data.hash = hash;
 	data.task = task;
+	data.put_work = io_wq_put_work;
 	data.free_work = io_wq_free_work;
 	data.do_work = io_wq_submit_work;
 
diff --git a/io_uring/timeout.c b/io_uring/timeout.c
index 9cc5776103fe..ef215accd284 100644
--- a/io_uring/timeout.c
+++ b/io_uring/timeout.c
@@ -113,6 +113,14 @@ __cold void io_flush_timeouts(struct io_ring_ctx *ctx)
 	spin_lock_irq(&ctx->timeout_lock);
 	seq = ctx->cached_cq_tail - atomic_read(&ctx->cq_timeouts);
 
+	/*
+	 * A fired timeout bumps ->cq_timeouts before its CQE is posted, which
+	 * leaves the sequence behind the last flush until it is. No event has
+	 * happened then, see io_timeout().
+	 */
+	if ((s32)(seq - ctx->cq_last_tm_flush) < 0)
+		seq = ctx->cq_last_tm_flush;
+
 	list_for_each_entry_safe(timeout, tmp, &ctx->timeout_list, list) {
 		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
 		u32 events_needed, events_got;
@@ -254,22 +262,29 @@ static enum hrtimer_restart io_timeout_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-static struct io_kiocb *io_timeout_extract(struct io_ring_ctx *ctx,
-					   struct io_cancel_data *cd)
+static struct io_kiocb *io_timeout_find(struct io_ring_ctx *ctx,
+					struct io_cancel_data *cd)
 	__must_hold(&ctx->timeout_lock)
 {
 	struct io_timeout *timeout;
-	struct io_timeout_data *io;
-	struct io_kiocb *req = NULL;
 
 	list_for_each_entry(timeout, &ctx->timeout_list, list) {
-		struct io_kiocb *tmp = cmd_to_io_kiocb(timeout);
+		struct io_kiocb *req = cmd_to_io_kiocb(timeout);
 
-		if (io_cancel_req_match(tmp, cd)) {
-			req = tmp;
-			break;
-		}
+		if (io_cancel_req_match(req, cd))
+			return req;
 	}
+	return NULL;
+}
+
+static struct io_kiocb *io_timeout_extract(struct io_ring_ctx *ctx,
+					   struct io_cancel_data *cd)
+	__must_hold(&ctx->timeout_lock)
+{
+	struct io_kiocb *req = io_timeout_find(ctx, cd);
+	struct io_timeout *timeout;
+	struct io_timeout_data *io;
+
 	if (!req)
 		return ERR_PTR(-ENOENT);
 
@@ -310,6 +325,9 @@ static void io_req_task_link_timeout(struct io_kiocb *req, struct io_tw_state *t
 			};
 
 			ret = io_try_cancel(req->task->io_uring, &cd, 0);
+			/* a number of requests for futex and waitid */
+			if (ret > 0)
+				ret = 0;
 		}
 		io_req_set_res(req, ret ?: -ETIME, 0);
 		io_req_task_complete(req, ts);
@@ -400,15 +418,24 @@ static int io_timeout_update(struct io_ring_ctx *ctx, __u64 user_data,
 	__must_hold(&ctx->timeout_lock)
 {
 	struct io_cancel_data cd = { .ctx = ctx, .data = user_data, };
-	struct io_kiocb *req = io_timeout_extract(ctx, &cd);
+	struct io_kiocb *req = io_timeout_find(ctx, &cd);
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_timeout_data *data;
 
-	if (IS_ERR(req))
-		return PTR_ERR(req);
+	if (!req)
+		return -ENOENT;
 
-	timeout->off = 0; /* noseq */
 	data = req->async_data;
+	/* multishot requests only make sense with rel values */
+	if ((data->flags & IORING_TIMEOUT_MULTISHOT) && mode == HRTIMER_MODE_ABS)
+		return -EINVAL;
+
+	req = io_timeout_extract(ctx, &cd);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+	/* for a multishot request this isn't a sequence, keep the repeats */
+	if (!(data->flags & IORING_TIMEOUT_MULTISHOT))
+		timeout->off = 0; /* noseq */
 	data->ts = *ts;
 
 	list_add_tail(&timeout->list, &ctx->timeout_list);
@@ -574,11 +601,19 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_timeout *timeout = io_kiocb_to_cmd(req, struct io_timeout);
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_timeout_data *data = req->async_data;
+	struct io_timeout *first;
 	struct list_head *entry;
-	u32 tail, off = timeout->off;
+	u32 tail, base, off = timeout->off;
 
 	spin_lock_irq(&ctx->timeout_lock);
 
+	/* the list is searched under ->timeout_lock, see io_wq_cancel_seen() */
+	if (__io_wq_cancel_seen(req, issue_flags)) {
+		spin_unlock_irq(&ctx->timeout_lock);
+		io_req_task_queue_fail(req, -ECANCELED);
+		return IOU_ISSUE_SKIP_COMPLETE;
+	}
+
 	/*
 	 * sqe->off holds how many events that need to occur for this
 	 * timeout event to be satisfied. If it isn't set, then this is
@@ -590,13 +625,27 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	tail = data_race(ctx->cached_cq_tail) - atomic_read(&ctx->cq_timeouts);
-	timeout->target_seq = tail + off;
 
-	/* Update the last seq here in case io_flush_timeouts() hasn't.
-	 * This is safe because ->completion_lock is held, and submissions
-	 * and completions are never mixed in the same ->completion_lock section.
+	/*
+	 * Update the last seq here in case io_flush_timeouts() hasn't, it only
+	 * gets called once sequences are in use. Leave it alone if there are
+	 * timeouts waiting for one. CQEs may have been posted since the last
+	 * flush, and a target that has been reached must not fall behind it.
 	 */
-	ctx->cq_last_tm_flush = tail;
+	first = list_first_entry_or_null(&ctx->timeout_list, struct io_timeout,
+					 list);
+	if (!first || io_is_timeout_noseq(cmd_to_io_kiocb(first)))
+		ctx->cq_last_tm_flush = tail;
+	base = ctx->cq_last_tm_flush;
+
+	/*
+	 * A fired timeout bumps ->cq_timeouts before its CQE is posted, which
+	 * leaves the sequence behind the last flush until it is. Nothing else
+	 * separates the two then, so count from the flush.
+	 */
+	if ((s32)(tail - base) < 0)
+		tail = base;
+	timeout->target_seq = tail + off;
 
 	/*
 	 * Insertion sort, ensuring the first entry in the list is always
@@ -608,8 +657,8 @@ int io_timeout(struct io_kiocb *req, unsigned int issue_flags)
 
 		if (io_is_timeout_noseq(nxt))
 			continue;
-		/* nxt.seq is behind @tail, otherwise would've been completed */
-		if (off >= nextt->target_seq - tail)
+		/* no target is behind the last flush, see io_flush_timeouts() */
+		if (timeout->target_seq - base >= nextt->target_seq - base)
 			break;
 	}
 add:
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index e5d0cc8a8a56..08d7e93c63cf 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -85,7 +85,7 @@ static void io_uring_cmd_del_cancelable(struct io_uring_cmd *cmd,
 
 	cmd->flags &= ~IORING_URING_CMD_CANCELABLE;
 	io_ring_submit_lock(ctx, issue_flags);
-	hlist_del(&req->hash_node);
+	hlist_del_init(&req->hash_node);
 	io_ring_submit_unlock(ctx, issue_flags);
 }
 
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 4475b02bafba..8811b5e275cc 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -161,9 +161,12 @@ static bool __io_waitid_cancel(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	/*
 	 * Mark us canceled regardless of ownership. This will prevent a
-	 * potential retry from a spurious wakeup.
+	 * potential retry from a spurious wakeup. Only the first cancel
+	 * attempt should take a reference for the ownership handoff.
 	 */
-	atomic_or(IO_WAITID_CANCEL_FLAG, &iw->refs);
+	if (atomic_fetch_or(IO_WAITID_CANCEL_FLAG, &iw->refs) &
+	    IO_WAITID_CANCEL_FLAG)
+		return false;
 
 	/* claim ownership */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
@@ -291,12 +294,18 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 		return 0;
 
 	list_del_init(&wait->entry);
-	smp_store_release(&iw->head, NULL);
 
-	/* cancel is in progress */
+	/*
+	 * Cancel or issue is in progress. Leave ->head alone, so that whoever
+	 * owns the request has to take the wait queue lock, which we hold,
+	 * before it can complete and free it.
+	 */
 	if (atomic_fetch_inc(&iw->refs) & IO_WAITID_REF_MASK)
 		return 1;
 
+	/* pairs with the smp_load_acquire() in io_waitid_remove_wq() */
+	smp_store_release(&iw->head, NULL);
+
 	req->io_task_work.func = io_waitid_cb;
 	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 	return 1;
@@ -369,6 +378,8 @@ int io_waitid(struct io_kiocb *req, unsigned int issue_flags)
 		 * a waitqueue callback, or if someone cancels it.
 		 */
 		if (!io_waitid_drop_issue_ref(req)) {
+			if (io_wq_cancel_seen(req, issue_flags))
+				__io_waitid_cancel(ctx, req, true);
 			io_ring_submit_unlock(ctx, issue_flags);
 			return IOU_ISSUE_SKIP_COMPLETE;
 		}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 97d9818db244..4983d7b71cd4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6602,10 +6602,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
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
@@ -6670,6 +6667,7 @@ static int cgroup_css_set_fork(struct kernel_clone_args *kargs)
 	put_css_set(cset);
 	fput(f);
 	kargs->cgrp = dst_cgrp;
+	kargs->kill_seq = dst_cgrp->kill_seq;
 	return ret;
 
 err:
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6c9c3bfc0da2..d14cf23a16a6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4451,6 +4451,7 @@ static bool perf_rotate_context(struct perf_cpu_pmu_context *cpc)
 
 	if (cpu_event) {
 		update_context_time(&cpuctx->ctx);
+		update_cgrp_time_from_cpuctx(cpuctx, false);
 		__pmu_ctx_sched_out(cpu_epc, EVENT_FLEXIBLE);
 		rotate_ctx(&cpuctx->ctx, cpu_event);
 		__pmu_ctx_sched_in(cpu_epc, EVENT_FLEXIBLE);
@@ -6533,7 +6534,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 		perf_pmu_output_stop(event);
 
 		/* now it's safe to free the pages */
-		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->locked_vm);
+		atomic_long_sub(rb->aux_nr_pages - rb->aux_mmap_locked, &mmap_user->perf_mlock);
 		atomic64_sub(rb->aux_mmap_locked, &vma->vm_mm->pinned_vm);
 
 		/* this has to be the last one */
@@ -6608,7 +6609,7 @@ static void perf_mmap_close(struct vm_area_struct *vma)
 	 */
 
 	atomic_long_sub((size >> PAGE_SHIFT) + 1 - mmap_locked,
-			&mmap_user->locked_vm);
+			&mmap_user->perf_mlock);
 	atomic64_sub(mmap_locked, &vma->vm_mm->pinned_vm);
 	free_uid(mmap_user);
 
@@ -6768,11 +6769,11 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	 */
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
@@ -6780,7 +6781,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 	if (user_locked > user_lock_limit) {
 		/*
-		 * charge locked_vm until it hits user_lock_limit;
+		 * charge perf_mlock until it hits user_lock_limit;
 		 * charge the rest from pinned_vm
 		 */
 		extra = user_locked - user_lock_limit;
@@ -6832,7 +6833,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 unlock:
 	if (!ret) {
-		atomic_long_add(user_extra, &user->locked_vm);
+		atomic_long_add(user_extra, &user->perf_mlock);
 		atomic64_add(extra, &vma->vm_mm->pinned_vm);
 
 		atomic_inc(&event->mmap_count);
@@ -13326,23 +13327,18 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
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
 
@@ -13418,8 +13414,7 @@ void perf_pmu_migrate_context(struct pmu *pmu, int src_cpu, int dst_cpu)
 	 */
 	mutex_lock_double(&src_ctx->mutex, &dst_ctx->mutex);
 
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->pinned_groups, &events);
-	__perf_pmu_remove(src_ctx, src_cpu, pmu, &src_ctx->flexible_groups, &events);
+	__perf_pmu_remove(src_ctx, pmu, &events);
 
 	if (!list_empty(&events)) {
 		/*
diff --git a/kernel/exit.c b/kernel/exit.c
index 8ae45b2b8cf9..5b1b1c52e72c 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -1696,7 +1696,7 @@ static long do_wait(struct wait_opts *wo)
 	add_wait_queue(&current->signal->wait_chldexit, &wo->child_wait);
 
 	do {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_INTERRUPTIBLE | TASK_FREEZABLE);
 		retval = __do_wait(wo);
 		if (retval != -ERESTARTSYS)
 			break;
diff --git a/kernel/fork.c b/kernel/fork.c
index c0ecb097aa1d..f22b79d9954a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1304,6 +1304,9 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
+#ifdef CONFIG_FUTEX
+	atomic64_set(&mm->futex_unique_id, 0);
+#endif
 
 	if (current->mm) {
 		mm->flags = mmf_init_flags(current->mm->flags);
@@ -1811,6 +1814,7 @@ static int copy_files(unsigned long clone_flags, struct task_struct *tsk,
 
 	if (clone_flags & CLONE_FILES) {
 		atomic_inc(&oldf->count);
+		tsk->files = oldf;
 		return 0;
 	}
 
@@ -2302,6 +2306,8 @@ __latent_entropy struct task_struct *copy_process(
 	INIT_LIST_HEAD(&p->sibling);
 	rcu_copy_process(p);
 	p->vfork_done = NULL;
+	/* Set by copy_files(), exit_files() on the error path skips NULL. */
+	p->files = NULL;
 	spin_lock_init(&p->alloc_lock);
 
 	init_sigpending(&p->pending);
@@ -2399,7 +2405,7 @@ __latent_entropy struct task_struct *copy_process(
 		goto bad_fork_cleanup_semundo;
 	retval = copy_fs(clone_flags, p);
 	if (retval)
-		goto bad_fork_cleanup_files;
+		goto bad_fork_cleanup_semundo;
 	retval = copy_sighand(clone_flags, p);
 	if (retval)
 		goto bad_fork_cleanup_fs;
@@ -2678,8 +2684,6 @@ __latent_entropy struct task_struct *copy_process(
 	__cleanup_sighand(p->sighand);
 bad_fork_cleanup_fs:
 	exit_fs(p); /* blocking */
-bad_fork_cleanup_files:
-	exit_files(p); /* blocking */
 bad_fork_cleanup_semundo:
 	exit_sem(p);
 bad_fork_cleanup_security:
@@ -2690,6 +2694,8 @@ __latent_entropy struct task_struct *copy_process(
 	perf_event_free_task(p);
 bad_fork_sched_cancel_fork:
 	sched_cancel_fork(p);
+	/* ->release() of a file may need scx_fork_rwsem for write. */
+	exit_files(p); /* blocking */
 bad_fork_cleanup_policy:
 	lockdep_free_task(p);
 #ifdef CONFIG_NUMA
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index c37d2263c21f..fa6ea7e235b1 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -153,39 +153,27 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
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
-		u64 new = atomic64_add_return(1, &i_seq);
+		u64 new = atomic64_add_return(1, &last_assigned_seq);
 		if (WARN_ON_ONCE(!new))
 			continue;
 
-		old = atomic64_cmpxchg_relaxed(&inode->i_sequence, 0, new);
+		old = atomic64_cmpxchg_relaxed(object_seq, 0, new);
 		if (old)
 			return old;
 		return new;
@@ -208,7 +196,7 @@ static u64 get_inode_sequence_number(struct inode *inode)
  *
  *   ( inode->i_sequence, page->index, offset_within_page )
  *
- * [ also see get_inode_sequence_number() ]
+ * [ also see get_object_id() ]
  *
  * For private mappings (or when !@fshared), the key is:
  *
@@ -362,8 +350,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			goto out;
 		}
 
-		key->both.offset |= FUT_OFF_MMSHARED; /* ref taken on mm */
-		key->private.mm = mm;
+		key->both.offset |= FUT_OFF_MMSHARED;
+		key->private.mm_seq = get_object_id(&mm->futex_unique_id);
 		key->private.address = address;
 
 	} else {
@@ -398,7 +386,20 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
-		key->shared.i_seq = get_inode_sequence_number(inode);
+		/*
+		 * This relies on the fact that a well formed program will not unmap
+		 * the file while it has a (shared) futex waiting on it. This mapping will have
+		 * a file reference which pins the mount and inode.
+		 *
+		 * If for some reason an inode gets evicted and read back in again, it will get
+		 * a new sequence number and will _NOT_ match, even though it is the exact same
+		 * file.
+		 *
+		 * It is important that futex_match() will never have a false-positive, esp.
+		 * for PI futexes that can mess up the state. The above argues that false-negatives
+		 * are only possible for malformed programs.
+		 */
+		key->shared.i_seq = get_object_id(&inode->i_sequence);
 		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
 		rcu_read_unlock();
 	}
diff --git a/kernel/pid_namespace.c b/kernel/pid_namespace.c
index d70ab49d5b4a..2c8c67753f3c 100644
--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -216,9 +216,10 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * kernel_wait4() will also block until our children traced from the
 	 * parent namespace are detached and become EXIT_DEAD.
 	 */
+	/* Task work must not busy-loop the reaper, see signal_pending(). */
+	guard(no_notify_signal)();
 	do {
 		clear_thread_flag(TIF_SIGPENDING);
-		clear_thread_flag(TIF_NOTIFY_SIGNAL);
 		rc = kernel_wait4(-1, NULL, __WALL, NULL);
 	} while (rc != -ECHILD);
 
@@ -246,7 +247,7 @@ void zap_pid_ns_processes(struct pid_namespace *pid_ns)
 	 * free_pid() will awaken this task.
 	 */
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		if (pid_ns->pid_allocated == init_pids)
 			break;
 		schedule();
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index d5c1dff1617c..72845f87089b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3767,7 +3767,7 @@ static int __init printk_set_kthreads_ready(void)
 
 	return 0;
 }
-early_initcall(printk_set_kthreads_ready);
+subsys_initcall(printk_set_kthreads_ready);
 #endif /* CONFIG_PRINTK */
 
 static int __read_mostly keep_bootcon;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 75bcc152606c..2fe09bb83e23 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -1086,6 +1086,12 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_SETSIGMASK: {
 		sigset_t new_set;
 
+		/* A user worker only ever takes SIGKILL and SIGSTOP. */
+		if (child->flags & PF_USER_WORKER) {
+			ret = -EPERM;
+			break;
+		}
+
 		if (addr != sizeof(sigset_t)) {
 			ret = -EINVAL;
 			break;
diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
index ddea40b68e5f..4dcbf8aa80ff 100644
--- a/kernel/rcu/srcutiny.c
+++ b/kernel/rcu/srcutiny.c
@@ -9,7 +9,6 @@
  */
 
 #include <linux/export.h>
-#include <linux/irq_work.h>
 #include <linux/mutex.h>
 #include <linux/preempt.h>
 #include <linux/rcupdate_wait.h>
@@ -38,7 +37,6 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp)
 	ssp->srcu_idx_max = 0;
 	INIT_WORK(&ssp->srcu_work, srcu_drive_gp);
 	INIT_LIST_HEAD(&ssp->srcu_work.entry);
-	init_irq_work(&ssp->srcu_irq_work, srcu_tiny_irq_work);
 	return 0;
 }
 
@@ -82,7 +80,6 @@ EXPORT_SYMBOL_GPL(init_srcu_struct);
 void cleanup_srcu_struct(struct srcu_struct *ssp)
 {
 	WARN_ON(ssp->srcu_lock_nesting[0] || ssp->srcu_lock_nesting[1]);
-	irq_work_sync(&ssp->srcu_irq_work);
 	flush_work(&ssp->srcu_work);
 	WARN_ON(ssp->srcu_gp_running);
 	WARN_ON(ssp->srcu_gp_waiting);
@@ -171,20 +168,6 @@ void srcu_drive_gp(struct work_struct *wp)
 }
 EXPORT_SYMBOL_GPL(srcu_drive_gp);
 
-/*
- * Use an irq_work to defer schedule_work() to avoid acquiring the workqueue
- * pool->lock while the caller might hold scheduler locks, causing lockdep
- * splats due to workqueue_init() doing a wakeup.
- */
-void srcu_tiny_irq_work(struct irq_work *irq_work)
-{
-	struct srcu_struct *ssp;
-
-	ssp = container_of(irq_work, struct srcu_struct, srcu_irq_work);
-	schedule_work(&ssp->srcu_work);
-}
-EXPORT_SYMBOL_GPL(srcu_tiny_irq_work);
-
 static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 {
 	unsigned long cookie;
@@ -198,7 +181,7 @@ static void srcu_gp_start_if_needed(struct srcu_struct *ssp)
 	WRITE_ONCE(ssp->srcu_idx_max, cookie);
 	if (!READ_ONCE(ssp->srcu_gp_running)) {
 		if (likely(srcu_init_done))
-			irq_work_queue(&ssp->srcu_irq_work);
+			schedule_work(&ssp->srcu_work);
 		else if (list_empty(&ssp->srcu_work.entry))
 			list_add(&ssp->srcu_work.entry, &srcu_boot_list);
 	}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 876adf5568ed..ded7a0dd2e53 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -730,8 +730,9 @@ enum scx_enq_flags {
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
 
@@ -3083,8 +3084,7 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 		/*
 		 * If @p is runnable but we're about to enter a lower
 		 * sched_class, %SCX_OPS_ENQ_LAST must be set. Tell
-		 * ops.enqueue() that @p is the only one available for this cpu,
-		 * which should trigger an explicit follow-up scheduling event.
+		 * ops.enqueue() that @p is the only one available for this cpu.
 		 *
 		 * Core scheduling can force this CPU idle while @p stays
 		 * runnable. @p's cookie then won't match the core's, so skip
@@ -3094,6 +3094,16 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p,
 			WARN_ON_ONCE(sched_cpu_cookie_match(rq, p) &&
 				     !static_branch_unlikely(&scx_ops_enq_last));
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 1a6cd0503beb..a3ee3c6960cb 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2999,6 +2999,10 @@ static void retarget_shared_pending(struct task_struct *tsk, sigset_t *which)
 	sigset_t retarget;
 	struct task_struct *t;
 
+	/* Nobody dequeues them in a dying group, see get_signal(). */
+	if (tsk->signal->flags & SIGNAL_GROUP_EXIT)
+		return;
+
 	sigandsets(&retarget, &tsk->signal->shared_pending.signal, which);
 	if (sigisemptyset(&retarget))
 		return;
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 79dfbdd218ac..fc9c8707dac1 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4316,9 +4316,9 @@ subsys_initcall(ftrace_check_for_weak_functions);
 
 static int print_rec(struct seq_file *m, unsigned long ip)
 {
-	unsigned long offset;
+	unsigned long offset = 0;
 	char str[KSYM_SYMBOL_LEN];
-	char *modname;
+	char *modname = NULL;
 	const char *ret;
 
 	ret = kallsyms_lookup(ip, NULL, &offset, &modname, str);
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 6e84f2f1eb20..e894a5686be3 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2106,6 +2106,9 @@ int ring_buffer_meta_seq_init(struct file *file, struct trace_buffer *buffer, in
 	struct seq_file *m;
 	int ret;
 
+	if (!cpumask_test_cpu(cpu, buffer->cpumask))
+		return -ENODEV;
+
 	ret = seq_open(file, &rb_meta_seq_ops);
 	if (ret)
 		return ret;
@@ -3200,10 +3203,8 @@ static void rb_inc_iter(struct ring_buffer_iter *iter)
 /* Return the index into the sub-buffers for a given sub-buffer */
 static int rb_meta_subbuf_idx(struct ring_buffer_meta *meta, void *subbuf)
 {
-	void *subbuf_array;
+	void *subbuf_array = rb_subbufs_from_meta(meta);
 
-	subbuf_array = (void *)meta + sizeof(int) * meta->nr_subbufs;
-	subbuf_array = (void *)ALIGN((unsigned long)subbuf_array, meta->subbuf_size);
 	return (subbuf - subbuf_array) / meta->subbuf_size;
 }
 
@@ -7357,12 +7358,8 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
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
index 115963797fab..2816708932d6 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6839,7 +6839,7 @@ static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
 
 	ret = ring_buffer_meta_seq_init(filp, tr->array_buffer.buffer, cpu);
 	if (ret < 0)
-		__trace_array_put(tr);
+		trace_array_put(tr);
 	return ret;
 }
 
@@ -7275,9 +7275,12 @@ tracing_snapshot_write(struct file *filp, const char __user *ubuf, size_t cnt,
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
@@ -10005,6 +10008,12 @@ static struct notifier_block trace_module_nb = {
 
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
index b6fc33ddb228..ad80649b8a65 100644
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
@@ -596,6 +595,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 			top--;					/* #12 */
 		}
 	}
+	/* Only the inner loop can complete a non-empty expression. */
+	if (N) {
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
+		goto out_free;
+	}
  out:
 	if (top != op_stack) {
 		/* Too many '(' */
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 59f9b54a6d0a..c44b9921edb3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -283,7 +283,7 @@ static u64 hist_field_log2(struct hist_field *hist_field,
 
 	u64 val = hist_fn_call(operand, elt, buffer, rbe, event);
 
-	return (u64) ilog2(roundup_pow_of_two(val));
+	return order_base_2(val);
 }
 
 static u64 hist_field_bucket(struct hist_field *hist_field,
@@ -460,7 +460,7 @@ static u64 hist_field_unary_minus(struct hist_field *hist_field,
 {									\
 	type *addr = (type *)(event + hist_field->field->offset);	\
 									\
-	return (u64)(unsigned long)*addr;				\
+	return (u64)*addr;						\
 }
 
 DEFINE_HIST_FIELD_FN(s64);
@@ -542,7 +542,7 @@ struct field_var {
 };
 
 struct field_var_hist {
-	struct hist_trigger_data	*hist_data;
+	struct trace_event_file		*file;
 	char				*cmd;
 };
 
@@ -866,7 +866,7 @@ static u64 hist_field_timestamp(struct hist_field *hist_field,
 	struct hist_trigger_data *hist_data = hist_field->hist_data;
 	struct trace_array *tr = hist_data->event_file->tr;
 
-	u64 ts = ring_buffer_event_time_stamp(buffer, rbe);
+	u64 ts = tracing_event_time_stamp(buffer, rbe);
 
 	if (hist_data->attrs->ts_in_usecs && trace_clock_in_ns(tr))
 		ts = ns2usecs(ts);
@@ -2098,7 +2098,8 @@ static int init_var_ref(struct hist_field *ref_field,
 	ref_field->size = var_field->size;
 	ref_field->is_signed = var_field->is_signed;
 	ref_field->flags |= var_field->flags &
-		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS);
+		(HIST_FIELD_FL_TIMESTAMP | HIST_FIELD_FL_TIMESTAMP_USECS |
+		 HIST_FIELD_FL_STACKTRACE);
 
 	if (system) {
 		ref_field->system = kstrdup(system, GFP_KERNEL);
@@ -3076,8 +3077,8 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	/* Save the compatible histogram information */
-	var_hist->hist_data = hist_data;
+	/* Needed to remove the histogram when the target goes away */
+	var_hist->file = file;
 
 	/* Create the new histogram with our variable */
 	ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
@@ -3092,20 +3093,18 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 
 	kfree(cmd);
 
+	n = target_hist_data->n_field_var_hists;
+	target_hist_data->field_var_hists[n] = var_hist;
+	target_hist_data->n_field_var_hists++;
+
 	/* If we can't find the variable, something went wrong */
 	event_var = find_synthetic_field_var(target_hist_data, subsys_name,
 					     event_name, field_name);
 	if (IS_ERR_OR_NULL(event_var)) {
-		kfree(var_hist->cmd);
-		kfree(var_hist);
 		hist_err(tr, HIST_ERR_SYNTH_VAR_NOT_FOUND, errpos(field_name));
 		return ERR_PTR(-EINVAL);
 	}
 
-	n = target_hist_data->n_field_var_hists;
-	target_hist_data->field_var_hists[n] = var_hist;
-	target_hist_data->n_field_var_hists++;
-
 	return event_var;
 }
 
@@ -3286,6 +3285,7 @@ static struct field_var *create_field_var(struct hist_trigger_data *hist_data,
 		ret =  -ENOMEM;
 		goto err;
 	}
+	var->flags |= val->flags & HIST_FIELD_FL_STACKTRACE;
 
 	field_var->var = var;
 	field_var->val = val;
@@ -3904,7 +3904,10 @@ static int check_synth_field(struct synth_event *event,
 	    && field->is_dynamic)
 		return 0;
 
-	if (strstr(hist_field->type, "long[") && field->is_stack)
+	if (!!(hist_field->flags & HIST_FIELD_FL_STACKTRACE) != field->is_stack)
+		return -EINVAL;
+
+	if (field->is_stack)
 		return 0;
 
 	if (strcmp(field->type, hist_field->type) != 0) {
@@ -4443,7 +4446,8 @@ static int create_var_field(struct hist_trigger_data *hist_data,
 	if (!ret && hist_data->fields[val_idx]->flags & HIST_FIELD_FL_EXECNAME)
 		update_var_execname(hist_data->fields[val_idx]);
 
-	if (!ret && hist_data->fields[val_idx]->flags &
+	if (!ret && !(hist_data->fields[val_idx]->flags & HIST_FIELD_FL_ALIAS) &&
+	    hist_data->fields[val_idx]->flags &
 	    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE))
 		hist_data->fields[val_idx]->var_str_idx = hist_data->n_var_str++;
 
@@ -5184,7 +5188,8 @@ static void hist_trigger_elt_update(struct hist_trigger_data *hist_data,
 		if (hist_field->flags & HIST_FIELD_FL_VAR) {
 			var_idx = hist_field->var.idx;
 
-			if (hist_field->flags &
+			if (!(hist_field->flags & HIST_FIELD_FL_ALIAS) &&
+			    hist_field->flags &
 			    (HIST_FIELD_FL_STRING | HIST_FIELD_FL_STACKTRACE)) {
 				unsigned int str_start, var_str_idx, idx;
 				char *str, *val_str;
@@ -6292,7 +6297,7 @@ static void unregister_field_var_hists(struct hist_trigger_data *hist_data)
 	int ret;
 
 	for (i = 0; i < hist_data->n_field_var_hists; i++) {
-		file = hist_data->field_var_hists[i]->hist_data->event_file;
+		file = hist_data->field_var_hists[i]->file;
 		cmd = hist_data->field_var_hists[i]->cmd;
 		ret = event_hist_trigger_parse(&trigger_hist_cmd, file,
 					       "!hist", "hist", cmd);
@@ -6720,7 +6725,6 @@ static void hist_unreg_all(struct trace_event_file *file)
 	struct event_trigger_data *test, *n;
 	struct hist_trigger_data *hist_data;
 	struct synth_event *se;
-	const char *se_name;
 
 	lockdep_assert_held(&event_mutex);
 
@@ -6733,8 +6737,7 @@ static void hist_unreg_all(struct trace_event_file *file)
 			list_del_rcu(&test->list);
 			trace_event_trigger_enable_disable(file, 0);
 
-			se_name = trace_event_name(file->event_call);
-			se = find_synth_event(se_name);
+			se = find_synth_event_call(file->event_call);
 			if (se)
 				se->ref--;
 
@@ -6758,7 +6761,6 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	struct hist_trigger_data *hist_data;
 	char *param, *filter, *p, *start;
 	struct synth_event *se;
-	const char *se_name;
 	bool remove;
 	int ret = 0;
 
@@ -6852,8 +6854,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 		}
 
 		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
-		se_name = trace_event_name(file->event_call);
-		se = find_synth_event(se_name);
+		se = find_synth_event_call(file->event_call);
 		if (se)
 			se->ref--;
 		ret = 0;
@@ -6888,8 +6889,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 	if (ret)
 		goto out_unreg;
 
-	se_name = trace_event_name(file->event_call);
-	se = find_synth_event(se_name);
+	se = find_synth_event_call(file->event_call);
 	if (se)
 		se->ref++;
  out:
@@ -6908,6 +6908,8 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	trigger_data_free(trigger_data);
 
+	unregister_field_var_hists(hist_data);
+
 	destroy_hist_data(hist_data);
 	goto out;
 }
diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index 28d701780ce9..8a19016f1317 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -857,6 +857,16 @@ struct synth_event *find_synth_event(const char *name)
 	return NULL;
 }
 
+struct synth_event *find_synth_event_call(struct trace_event_call *call)
+{
+	struct synth_event *se;
+	const char *name;
+
+	name = trace_event_name(call);
+	se = find_synth_event(name);
+	return se && &se->call == call ? se : NULL;
+}
+
 static struct trace_event_fields synth_event_fields_array[] = {
 	{ .type = TRACE_FUNCTION_TYPE,
 	  .define_fields = synth_event_define_fields },
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 95201c0daa8f..c7e4758505f2 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1709,7 +1709,6 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 					 int *new_argc, char *buf, int bufsize,
 					 struct traceprobe_parse_context *ctx)
 {
-	const struct btf_param *params = NULL;
 	int i, j, n, used, ret, args_idx = -1;
 	const char **new_argv = NULL;
 
@@ -1727,7 +1726,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
 		if (args_idx != -1) {
 			/* $arg* requires BTF info */
 			trace_probe_log_err(0, NOSUP_BTFARG);
-			return (const char **)params;
+			return ERR_PTR(-EOPNOTSUPP);
 		}
 		*new_argc = argc;
 		return NULL;
diff --git a/kernel/trace/trace_synth.h b/kernel/trace/trace_synth.h
index 43f6fb6078db..d4ebf01b7049 100644
--- a/kernel/trace/trace_synth.h
+++ b/kernel/trace/trace_synth.h
@@ -37,5 +37,6 @@ struct synth_event {
 };
 
 extern struct synth_event *find_synth_event(const char *name);
+extern struct synth_event *find_synth_event_call(struct trace_event_call *call);
 
 #endif /* __TRACE_SYNTH_H */
diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 6d1936fb8ff0..8f809cc60c03 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -101,19 +101,20 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	struct pipe_inode_info *pipe = wqueue->pipe;
 	struct pipe_buffer *buf;
 	struct page *page;
-	unsigned int head, tail, mask, note, offset, len;
+	unsigned int head, tail, note, offset, len, nr_notes;
 	bool done = false;
 
 	spin_lock_irq(&pipe->rd_wait.lock);
 
-	mask = pipe->ring_size - 1;
 	head = pipe->head;
 	tail = pipe->tail;
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
@@ -124,7 +125,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	memcpy(p + offset, n, len);
 	kunmap_atomic(p);
 
-	buf = &pipe->bufs[head & mask];
+	buf = pipe_buf(pipe, head);
 	buf->page = page;
 	buf->private = (unsigned long)wqueue;
 	buf->ops = &watch_queue_pipe_buf_ops;
@@ -147,7 +148,7 @@ static bool post_one_notification(struct watch_queue *wqueue,
 	return done;
 
 lost:
-	buf = &pipe->bufs[(head - 1) & mask];
+	buf = pipe_buf(pipe, head - 1);
 	buf->flags |= PIPE_BUF_FLAG_LOSS;
 	goto out;
 }
@@ -298,7 +299,8 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 	wqueue->notes = pages;
 	wqueue->notes_bitmap = bitmap;
 	wqueue->nr_pages = nr_pages;
-	wqueue->nr_notes = nr_notes;
+	/* Pairs with the smp_load_acquire() in post_one_notification(). */
+	smp_store_release(&wqueue->nr_notes, nr_notes);
 	return 0;
 
 error_p:
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index d1ce5aeb012f..f6dde83c9466 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1559,6 +1559,8 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
+#define is_percpu_pool(pool) ((pool)->cpu >= 0)
+
 /**
  * wq_node_nr_active - Determine wq_node_nr_active to use
  * @wq: workqueue of interest
@@ -2683,7 +2685,7 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	if (pool->cpu < 0 && pool->attrs->affn_strict)
+	if (!is_percpu_pool(pool) && pool->attrs->affn_strict)
 		return pool->attrs->__pod_cpumask;
 	else
 		return pool->attrs->cpumask;
@@ -4969,7 +4971,7 @@ static void put_unbound_pool(struct worker_pool *pool)
 		return;
 
 	/* sanity checks */
-	if (WARN_ON(!(pool->cpu < 0)) ||
+	if (WARN_ON(is_percpu_pool(pool)) ||
 	    WARN_ON(!list_empty(&pool->worklist)))
 		return;
 
@@ -5121,12 +5123,6 @@ static void pwq_release_workfn(struct kthread_work *work)
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
@@ -5136,6 +5132,12 @@ static void pwq_release_workfn(struct kthread_work *work)
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
@@ -7639,7 +7641,7 @@ static void wq_watchdog_timer_fn(struct timer_list *unused)
 		/* did we stall? */
 		if (time_after(now, ts + thresh)) {
 			lockup_detected = true;
-			if (pool->cpu >= 0 && !(pool->flags & POOL_BH)) {
+			if (is_percpu_pool(pool) && !(pool->flags & POOL_BH)) {
 				pool->cpu_stall = true;
 				cpu_pool_stall = true;
 			}
@@ -7738,12 +7740,12 @@ static inline void wq_watchdog_init(void) { }
 
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
diff --git a/mm/filemap.c b/mm/filemap.c
index c2287a1d1c6b..64c2325b9238 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -125,15 +125,6 @@
  *    ->private_lock		(zap_pte_range->block_dirty_folio)
  */
 
-static void mapping_set_update(struct xa_state *xas,
-		struct address_space *mapping)
-{
-	if (dax_mapping(mapping) || shmem_mapping(mapping))
-		return;
-	xas_set_update(xas, workingset_update_node);
-	xas_set_lru(xas, &shadow_nodes);
-}
-
 static void page_cache_delete(struct address_space *mapping,
 				   struct folio *folio, void *shadow)
 {
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 348fb144e63b..d175e93988a9 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -86,6 +86,62 @@ unsigned long huge_anon_orders_madvise __read_mostly;
 unsigned long huge_anon_orders_inherit __read_mostly;
 static bool anon_orders_configured __initdata;
 
+static bool vma_file_bypass_thp_tuneables(const struct vm_area_struct *vma,
+		unsigned long tva_flags)
+{
+	const bool has_huge_fault = vma->vm_ops->huge_fault;
+
+	/* MADV_COLLAPSE ignores tuneables. */
+	if (!(tva_flags & TVA_ENFORCE_SYSFS))
+		return true;
+	/* Huge PFN mappings are uncompactable so the policy doesn't apply. */
+	if ((vma->vm_flags & VM_PFNMAP) && has_huge_fault)
+		return true;
+	return false;
+}
+
+static bool vma_file_allow_thp_tuneables(vm_flags_t vm_flags)
+{
+	/* THP=always? */
+	if (hugepage_global_always())
+		return true;
+	/* THP=madvise and marked MADV_HUGEPAGE? */
+	if (hugepage_global_enabled() && (vm_flags & VM_HUGEPAGE))
+		return true;
+	return false;
+}
+
+static bool vma_file_check_thp_tuneables(const struct vm_area_struct *vma,
+		vm_flags_t vm_flags, unsigned long tva_flags)
+{
+	return vma_file_bypass_thp_tuneables(vma, tva_flags) ||
+		vma_file_allow_thp_tuneables(vm_flags);
+}
+
+static bool vma_can_map_huge_file(const struct vm_area_struct *vma,
+		vm_flags_t vm_flags, unsigned long tva_flags)
+{
+	const bool has_huge_fault = vma->vm_ops->huge_fault;
+
+	/*
+	 * Enforce THP collapse requirements as necessary. Anonymous vmas
+	 * were already handled in thp_vma_allowable_orders().
+	 */
+	if (!vma_file_check_thp_tuneables(vma, vm_flags, tva_flags))
+		return false;
+
+	/*
+	 * Trust that ->huge_fault() handlers know what they are doing
+	 * in fault path.
+	 */
+	if (tva_flags & TVA_IN_PF)
+		return has_huge_fault;
+	if ((tva_flags & TVA_SMAPS) && has_huge_fault)
+		return true;
+	/* Only regular file is valid in collapse path. */
+	return file_thp_enabled(vma);
+}
+
 unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 					 unsigned long vm_flags,
 					 unsigned long tva_flags,
@@ -158,27 +214,8 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 						   vma, vma->vm_pgoff, 0,
 						   !enforce_sysfs);
 
-	if (!vma_is_anonymous(vma)) {
-		/*
-		 * Enforce sysfs THP requirements as necessary. Anonymous vmas
-		 * were already handled in thp_vma_allowable_orders().
-		 */
-		if (enforce_sysfs &&
-		    (!hugepage_global_enabled() || (!(vm_flags & VM_HUGEPAGE) &&
-						    !hugepage_global_always())))
-			return 0;
-
-		/*
-		 * Trust that ->huge_fault() handlers know what they are doing
-		 * in fault path.
-		 */
-		if (((in_pf || smaps)) && vma->vm_ops->huge_fault)
-			return orders;
-		/* Only regular file is valid in collapse path */
-		if (((!in_pf || smaps)) && file_thp_enabled(vma))
-			return orders;
-		return 0;
-	}
+	if (!vma_is_anonymous(vma))
+		return vma_can_map_huge_file(vma, vm_flags, tva_flags) ? orders : 0;
 
 	if (vma_is_temporary_stack(vma))
 		return 0;
@@ -3532,6 +3569,8 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			goto out;
 		}
 
+		mapping_set_update(&xas, mapping);
+
 		xas_split_alloc(&xas, folio, folio_order(folio), gfp);
 		if (xas_error(&xas)) {
 			ret = xas_error(&xas);
diff --git a/mm/internal.h b/mm/internal.h
index 9d277bc2c26e..7aca909c5405 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1526,6 +1526,12 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
 /* Only track the nodes of mappings with shadow entries */
 void workingset_update_node(struct xa_node *node);
 extern struct list_lru shadow_nodes;
+#define mapping_set_update(xas, mapping) do {			\
+	if (!dax_mapping(mapping) && !shmem_mapping(mapping)) {	\
+		xas_set_update(xas, workingset_update_node);	\
+		xas_set_lru(xas, &shadow_nodes);		\
+	}							\
+} while (0)
 
 /* mremap.c */
 unsigned long move_page_tables(struct vm_area_struct *vma,
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 84bacd7e1962..769e2f9f9992 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -20,6 +20,7 @@
 #include <linux/rcupdate_wait.h>
 #include <linux/swapops.h>
 #include <linux/shmem_fs.h>
+#include <linux/dax.h>
 #include <linux/ksm.h>
 
 #include <asm/tlb.h>
@@ -1823,6 +1824,8 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	if (result != SCAN_SUCCEED)
 		goto out;
 
+	mapping_set_update(&xas, mapping);
+
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 3d795ad47a89..150e641d0391 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -108,6 +108,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 	pmd = pmd_offset(pud, addr);
 	do {
 again:
+		walk->action = ACTION_SUBTREE;
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd)) {
 			if (ops->pte_hole)
@@ -117,8 +118,6 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		walk->action = ACTION_SUBTREE;
-
 		/*
 		 * This implies that each ->pmd_entry() handler
 		 * needs to know about pmd_trans_huge() pmds
@@ -167,6 +166,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 	pud = pud_offset(p4d, addr);
 	do {
  again:
+		walk->action = ACTION_SUBTREE;
 		next = pud_addr_end(addr, end);
 		if (pud_none(*pud)) {
 			if (ops->pte_hole)
@@ -176,8 +176,6 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
 			continue;
 		}
 
-		walk->action = ACTION_SUBTREE;
-
 		if (ops->pud_entry)
 			err = ops->pud_entry(pud, addr, next, walk);
 		if (err)
diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 3ee7dba34310..95224600b5a1 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -81,7 +81,17 @@ static void ax25_kill_by_device(struct net_device *dev)
 
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		return;
-	ax25_dev->device_up = false;
+	WRITE_ONCE(ax25_dev->device_up, false);
+
+	/*
+	 * ax25_send_frame() and ax25_rcv() create connections that hold no
+	 * reference on the ax25_dev: they rely on the walk below to detach
+	 * them before the ax25_dev is freed. Both run under rcu_read_lock()
+	 * and give up when device_up is clear, so once this returns every
+	 * connection they were setting up is complete and on the list, and
+	 * no new one can appear behind the walk.
+	 */
+	synchronize_rcu();
 
 	spin_lock_bh(&ax25_list_lock);
 again:
@@ -91,7 +101,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			if (!sk) {
 				spin_unlock_bh(&ax25_list_lock);
 				ax25_disconnect(s, ENETUNREACH);
-				s->ax25_dev = NULL;
+				WRITE_ONCE(s->ax25_dev, NULL);
 				ax25_cb_del(s);
 				spin_lock_bh(&ax25_list_lock);
 				goto again;
@@ -100,7 +110,7 @@ static void ax25_kill_by_device(struct net_device *dev)
 			spin_unlock_bh(&ax25_list_lock);
 			lock_sock(sk);
 			ax25_disconnect(s, ENETUNREACH);
-			s->ax25_dev = NULL;
+			WRITE_ONCE(s->ax25_dev, NULL);
 			if (sk->sk_socket) {
 				netdev_put(ax25_dev->dev,
 					   &s->dev_tracker);
@@ -172,6 +182,7 @@ void ax25_cb_add(ax25_cb *ax25)
 struct sock *ax25_find_listener(ax25_address *addr, int digi,
 	struct net_device *dev, int type)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 
 	spin_lock(&ax25_list_lock);
@@ -181,7 +192,8 @@ struct sock *ax25_find_listener(ax25_address *addr, int digi,
 		if (s->sk && !ax25cmp(&s->source_addr, addr) &&
 		    s->sk->sk_type == type && s->sk->sk_state == TCP_LISTEN) {
 			/* If device is null we match any device */
-			if (s->ax25_dev == NULL || s->ax25_dev->dev == dev) {
+			ax25_dev = READ_ONCE(s->ax25_dev);
+			if (ax25_dev == NULL || ax25_dev->dev == dev) {
 				sock_hold(s->sk);
 				spin_unlock(&ax25_list_lock);
 				return s->sk;
@@ -222,18 +234,20 @@ struct sock *ax25_get_socket(ax25_address *my_addr, ax25_address *dest_addr,
  *	Find an AX.25 control block given both ends. It will only pick up
  *	floating AX.25 control blocks or non Raw socket bound control blocks.
  */
-ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
-	ax25_digi *digi, struct net_device *dev)
+static ax25_cb *__ax25_find_cb(const ax25_address *src_addr,
+			       ax25_address *dest_addr, ax25_digi *digi,
+			       struct net_device *dev)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 
-	spin_lock_bh(&ax25_list_lock);
 	ax25_for_each(s, &ax25_list) {
 		if (s->sk && s->sk->sk_type != SOCK_SEQPACKET)
 			continue;
-		if (s->ax25_dev == NULL)
+		ax25_dev = READ_ONCE(s->ax25_dev);
+		if (ax25_dev == NULL)
 			continue;
-		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr, dest_addr) == 0 && s->ax25_dev->dev == dev) {
+		if (ax25cmp(&s->source_addr, src_addr) == 0 && ax25cmp(&s->dest_addr, dest_addr) == 0 && ax25_dev->dev == dev) {
 			if (digi != NULL && digi->ndigi != 0) {
 				if (s->digipeat == NULL)
 					continue;
@@ -243,30 +257,67 @@ ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
 				if (s->digipeat != NULL && s->digipeat->ndigi != 0)
 					continue;
 			}
-			ax25_cb_hold(s);
-			spin_unlock_bh(&ax25_list_lock);
-
 			return s;
 		}
 	}
-	spin_unlock_bh(&ax25_list_lock);
 
 	return NULL;
 }
 
+ax25_cb *ax25_find_cb(const ax25_address *src_addr, ax25_address *dest_addr,
+		      ax25_digi *digi, struct net_device *dev)
+{
+	ax25_cb *s;
+
+	spin_lock_bh(&ax25_list_lock);
+	s = __ax25_find_cb(src_addr, dest_addr, digi, dev);
+	if (s)
+		ax25_cb_hold(s);
+	spin_unlock_bh(&ax25_list_lock);
+
+	return s;
+}
+
 EXPORT_SYMBOL(ax25_find_cb);
 
+/*
+ *	Add a new connection to the list unless one already exists for the
+ *	same addresses, path and device. Returns NULL when the control block
+ *	has been added, or the existing one, held, when there is one: looking
+ *	it up and adding it are done under the same lock, so that two senders
+ *	cannot both create a connection for the same link.
+ */
+ax25_cb *ax25_cb_add_unique(ax25_cb *ax25)
+{
+	ax25_cb *s;
+
+	spin_lock_bh(&ax25_list_lock);
+	s = __ax25_find_cb(&ax25->source_addr, &ax25->dest_addr,
+			   ax25->digipeat, ax25->ax25_dev->dev);
+	if (s) {
+		ax25_cb_hold(s);
+	} else {
+		ax25_cb_hold(ax25);
+		hlist_add_head(&ax25->ax25_node, &ax25_list);
+	}
+	spin_unlock_bh(&ax25_list_lock);
+
+	return s;
+}
+
 void ax25_send_to_raw(ax25_address *addr, struct sk_buff *skb, int proto)
 {
+	ax25_dev *ax25_dev;
 	ax25_cb *s;
 	struct sk_buff *copy;
 
 	spin_lock(&ax25_list_lock);
 	ax25_for_each(s, &ax25_list) {
+		ax25_dev = READ_ONCE(s->ax25_dev);
 		if (s->sk != NULL && ax25cmp(&s->source_addr, addr) == 0 &&
 		    s->sk->sk_type == SOCK_RAW &&
 		    s->sk->sk_protocol == proto &&
-		    s->ax25_dev->dev == skb->dev &&
+		    ax25_dev && ax25_dev->dev == skb->dev &&
 		    atomic_read(&s->sk->sk_rmem_alloc) <= s->sk->sk_rcvbuf) {
 			if ((copy = skb_clone(skb, GFP_ATOMIC)) == NULL)
 				continue;
@@ -537,6 +588,8 @@ ax25_cb *ax25_create_cb(void)
 	skb_queue_head_init(&ax25->frag_queue);
 	skb_queue_head_init(&ax25->ack_queue);
 	skb_queue_head_init(&ax25->reseq_queue);
+	skb_queue_head_init(&ax25->xmit_queue);
+	spin_lock_init(&ax25->lock);
 
 	ax25_setup_timers(ax25);
 
diff --git a/net/ax25/ax25_ds_in.c b/net/ax25/ax25_ds_in.c
index c62f8fb06189..b78a577760c6 100644
--- a/net/ax25/ax25_ds_in.c
+++ b/net/ax25/ax25_ds_in.c
@@ -58,6 +58,8 @@ static int ax25_ds_state1_machine(ax25_cb *ax25, struct sk_buff *skb, int framet
 		ax25->vr      = 0;
 		ax25->state   = AX25_STATE_3;
 		ax25->n2count = 0;
+		/* I frames left unacknowledged by a link reset: send them again */
+		ax25_requeue_frames(ax25);
 		if (ax25->sk != NULL) {
 			bh_lock_sock(ax25->sk);
 			ax25->sk->sk_state = TCP_ESTABLISHED;
diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index f2d66af86359..1bcb5e321467 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -35,12 +35,22 @@ static int ax25_rx_fragment(ax25_cb *ax25, struct sk_buff *skb)
 {
 	struct sk_buff *skbn, *skbo;
 
+	if (!pskb_may_pull(skb, 1))
+		return 0;
+
 	if (ax25->fragno != 0) {
 		if (!(*skb->data & AX25_SEG_FIRST)) {
 			if ((ax25->fragno - 1) == (*skb->data & AX25_SEG_REM)) {
 				/* Enqueue fragment */
 				ax25->fragno = *skb->data & AX25_SEG_REM;
 				skb_pull(skb, 1);	/* skip fragno */
+				if (ax25->fraglen + skb->len > USHRT_MAX) {
+					kfree_skb(skb);
+					skb_queue_purge(&ax25->frag_queue);
+					ax25->fragno = 0;
+					ax25->fraglen = 0;
+					return 1;
+				}
 				ax25->fraglen += skb->len;
 				skb_queue_tail(&ax25->frag_queue, skb);
 
@@ -104,6 +114,10 @@ int ax25_rx_iframe(ax25_cb *ax25, struct sk_buff *skb)
 
 	if (skb == NULL) return 0;
 
+	/* An I frame must at least carry its PID byte */
+	if (skb->len < 1)
+		return 0;
+
 	ax25_start_idletimer(ax25);
 
 	pid = *skb->data;
@@ -199,6 +213,18 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		goto free;
 
+	if (skb_linearize(skb))
+		goto free;
+
+	/*
+	 * A connection made below on an incoming SABM holds no reference on
+	 * the ax25_dev either. We are called under rcu_read_lock(), which
+	 * ax25_kill_by_device() waits for after it has cleared device_up:
+	 * leave a device that is going down alone.
+	 */
+	if (!READ_ONCE(ax25_dev->device_up))
+		goto free;
+
 	/*
 	 *	Parse the address header.
 	 */
@@ -217,6 +243,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 1)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
@@ -227,6 +256,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* UI frame - bypass LAPB processing */
 	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
+		if (skb->len < 2)
+			goto free;
+
 		skb_set_transport_header(skb, 2); /* skip control and pid */
 
 		ax25_send_to_raw(&dest, skb, skb->data[1]);
@@ -351,6 +383,24 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 		}
 
 		ax25 = sk_to_ax25(make);
+
+		/*
+		 * Get the digipeater path before the skb goes on the
+		 * listener's queue: once queued it belongs to that queue
+		 * and cannot simply be freed if the allocation fails.
+		 */
+		if (dp.ndigi && !ax25->digipeat) {
+			ax25->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC);
+			if (!ax25->digipeat) {
+				kfree_skb(skb);
+				ax25_destroy_socket(ax25);
+				bh_unlock_sock(sk);
+				sock_put(sk);
+
+				return 0;
+			}
+		}
+
 		skb_set_owner_r(skb, make);
 		skb_queue_head(&sk->sk_receive_queue, skb);
 
@@ -374,14 +424,13 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	ax25->dest_addr   = src;
 
 	/*
-	 *	Sort out any digipeated paths.
+	 *	Sort out any digipeated paths. A socket made from a listener
+	 *	already has its path allocated, see above.
 	 */
 	if (dp.ndigi && !ax25->digipeat &&
 	    (ax25->digipeat = kmalloc(sizeof(ax25_digi), GFP_ATOMIC)) == NULL) {
 		kfree_skb(skb);
 		ax25_destroy_socket(ax25);
-		if (sk)
-			sock_put(sk);
 		return 0;
 	}
 
diff --git a/net/ax25/ax25_out.c b/net/ax25/ax25_out.c
index 8bca2ace98e5..7c4ebef5ae6c 100644
--- a/net/ax25/ax25_out.c
+++ b/net/ax25/ax25_out.c
@@ -32,36 +32,36 @@ static DEFINE_SPINLOCK(ax25_frag_lock);
 ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *src, ax25_address *dest, ax25_digi *digi, struct net_device *dev)
 {
 	ax25_dev *ax25_dev;
-	ax25_cb *ax25;
+	ax25_cb *ax25, *existing;
+
+	/*
+	 * The connection made or used here holds no reference on the
+	 * ax25_dev. ax25_kill_by_device() clears device_up, waits for the RCU
+	 * readers and only then detaches the connections of the device: stay
+	 * under the RCU read lock until the frame is queued, and do not start
+	 * anything on a device that is going down.
+	 */
+	rcu_read_lock();
+	ax25_dev = ax25_dev_ax25dev(dev);
+	if (!ax25_dev || !READ_ONCE(ax25_dev->device_up)) {
+		rcu_read_unlock();
+		return NULL;
+	}
 
 	/*
 	 * Take the default packet length for the device if zero is
 	 * specified.
 	 */
-	if (paclen == 0) {
-		rcu_read_lock();
-		ax25_dev = ax25_dev_ax25dev(dev);
-		if (!ax25_dev) {
-			rcu_read_unlock();
-			return NULL;
-		}
+	if (paclen == 0)
 		paclen = ax25_dev->values[AX25_VALUES_PACLEN];
-		rcu_read_unlock();
-	}
 
 	/*
 	 * Look for an existing connection.
 	 */
 	if ((ax25 = ax25_find_cb(src, dest, digi, dev)) != NULL) {
 		ax25_output(ax25, paclen, skb);
-		return ax25;		/* It already existed */
-	}
-
-	rcu_read_lock();
-	ax25_dev = ax25_dev_ax25dev(dev);
-	if (!ax25_dev) {
 		rcu_read_unlock();
-		return NULL;
+		return ax25;		/* It already existed */
 	}
 
 	if ((ax25 = ax25_create_cb()) == NULL) {
@@ -69,7 +69,6 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		return NULL;
 	}
 	ax25_fillin_cb(ax25, ax25_dev);
-	rcu_read_unlock();
 
 	ax25->source_addr = *src;
 	ax25->dest_addr   = *dest;
@@ -78,11 +77,25 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 		ax25->digipeat = kmemdup(digi, sizeof(*digi), GFP_ATOMIC);
 		if (ax25->digipeat == NULL) {
 			ax25_cb_put(ax25);
+			rcu_read_unlock();
 			return NULL;
 		}
 	}
 
-	switch (ax25->ax25_dev->values[AX25_VALUES_PROTOCOL]) {
+	/*
+	 * Another sender may have created the connection since the lookup
+	 * above: the list is searched again and the new control block added
+	 * under one lock. If we lost, use the other one.
+	 */
+	existing = ax25_cb_add_unique(ax25);
+	if (existing) {
+		ax25_cb_put(ax25);
+		ax25_output(existing, paclen, skb);
+		rcu_read_unlock();
+		return existing;
+	}
+
+	switch (ax25_dev->values[AX25_VALUES_PROTOCOL]) {
 	case AX25_PROTO_STD_SIMPLEX:
 	case AX25_PROTO_STD_DUPLEX:
 		ax25_std_establish_data_link(ax25);
@@ -104,13 +117,12 @@ ax25_cb *ax25_send_frame(struct sk_buff *skb, int paclen, const ax25_address *sr
 	 */
 	ax25_cb_hold(ax25);
 
-	ax25_cb_add(ax25);
-
 	ax25->state = AX25_STATE_1;
 
 	ax25_start_heartbeat(ax25);
 
 	ax25_output(ax25, paclen, skb);
+	rcu_read_unlock();
 
 	return ax25;			/* We had to create it */
 }
@@ -218,6 +230,11 @@ void ax25_output(ax25_cb *ax25, int paclen, struct sk_buff *skb)
  *  This procedure is passed a buffer descriptor for an iframe. It builds
  *  the rest of the control part of the frame and then writes it out.
  */
+/*
+ *	Number an I frame and queue it for the device. Called by ax25_kick()
+ *	with ax25->lock held: the frame is sent by ax25_run_xmit_queue() once
+ *	the lock is dropped.
+ */
 static void ax25_send_iframe(ax25_cb *ax25, struct sk_buff *skb, int poll_bit)
 {
 	unsigned char *frame;
@@ -245,7 +262,34 @@ static void ax25_send_iframe(ax25_cb *ax25, struct sk_buff *skb, int poll_bit)
 
 	ax25_start_idletimer(ax25);
 
-	ax25_transmit_buffer(ax25, skb, AX25_COMMAND);
+	skb_queue_tail(&ax25->xmit_queue, skb);
+}
+
+/*
+ *	Hand the frames numbered by ax25_kick() to the device, in order. Only
+ *	one context does it at a time, so that frames queued by two senders
+ *	cannot overtake each other; the one already running picks up whatever
+ *	the others have queued. The lock is not held while transmitting.
+ */
+static void ax25_run_xmit_queue(ax25_cb *ax25)
+{
+	struct sk_buff *skb;
+
+	spin_lock_bh(&ax25->lock);
+	if (ax25->xmit_running) {
+		spin_unlock_bh(&ax25->lock);
+		return;
+	}
+	ax25->xmit_running = 1;
+
+	while ((skb = skb_dequeue(&ax25->xmit_queue)) != NULL) {
+		spin_unlock_bh(&ax25->lock);
+		ax25_transmit_buffer(ax25, skb, AX25_COMMAND);
+		spin_lock_bh(&ax25->lock);
+	}
+
+	ax25->xmit_running = 0;
+	spin_unlock_bh(&ax25->lock);
 }
 
 void ax25_kick(ax25_cb *ax25)
@@ -260,14 +304,25 @@ void ax25_kick(ax25_cb *ax25)
 	if (ax25->condition & AX25_COND_PEER_RX_BUSY)
 		return;
 
+	/*
+	 * ax25_kick() is called from process context by the senders and
+	 * from softirq context by the receive path and the timers, possibly
+	 * for several ROSE or NET/ROM circuits sharing this connection. Two
+	 * of them running here at the same time would read the same V(S) and
+	 * send two different frames under the same N(S); the peer keeps one
+	 * and the other is never sent again. Take the frames off the write
+	 * queue and number them under the lock.
+	 */
+	spin_lock_bh(&ax25->lock);
+
 	if (skb_peek(&ax25->write_queue) == NULL)
-		return;
+		goto out;
 
 	start = (skb_peek(&ax25->ack_queue) == NULL) ? ax25->va : ax25->vs;
 	end   = (ax25->va + ax25->window) % ax25->modulus;
 
 	if (start == end)
-		return;
+		goto out;
 
 	/*
 	 * Transmit data until either we're out of data to send or
@@ -281,12 +336,21 @@ void ax25_kick(ax25_cb *ax25)
 	 */
 	skb  = skb_dequeue(&ax25->write_queue);
 	if (!skb)
-		return;
+		goto out;
 
 	ax25->vs = start;
 
 	do {
-		if ((skbn = skb_clone(skb, GFP_ATOMIC)) == NULL) {
+		/*
+		 * Send a private copy, not a clone. The frame stays on the
+		 * ack queue and is sent again after a REJ or a T1 timeout,
+		 * while the previous copy may still be waiting in the device
+		 * queue. A clone shares its data with the original: building
+		 * the frame again would rewrite the control field, and so
+		 * the N(R), of the copy already queued.
+		 */
+		skbn = skb_copy(skb, GFP_ATOMIC);
+		if (!skbn) {
 			skb_queue_head(&ax25->write_queue, skb);
 			break;
 		}
@@ -331,6 +395,11 @@ void ax25_kick(ax25_cb *ax25)
 		ax25_calculate_t1(ax25);
 		ax25_start_t1timer(ax25);
 	}
+
+out:
+	spin_unlock_bh(&ax25->lock);
+
+	ax25_run_xmit_queue(ax25);
 }
 
 void ax25_transmit_buffer(ax25_cb *ax25, struct sk_buff *skb, int type)
diff --git a/net/ax25/ax25_std_in.c b/net/ax25/ax25_std_in.c
index ba176196ae06..d0269ece4fc5 100644
--- a/net/ax25/ax25_std_in.c
+++ b/net/ax25/ax25_std_in.c
@@ -66,6 +66,14 @@ static int ax25_std_state1_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
 			ax25->vr      = 0;
 			ax25->state   = AX25_STATE_3;
 			ax25->n2count = 0;
+			/*
+			 * The link may have been re-established from state
+			 * 3 or 4 with I frames still waiting for their
+			 * acknowledgment. V(S) and V(A) start again from
+			 * zero: send those frames again, as is done when
+			 * the peer resets the link with a SABM.
+			 */
+			ax25_requeue_frames(ax25);
 			if (ax25->sk != NULL) {
 				bh_lock_sock(ax25->sk);
 				ax25->sk->sk_state = TCP_ESTABLISHED;
@@ -196,6 +204,38 @@ static int ax25_std_state3_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
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
@@ -226,6 +266,10 @@ static int ax25_std_state3_machine(ax25_cb *ax25, struct sk_buff *skb, int frame
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
diff --git a/net/ax25/ax25_subr.c b/net/ax25/ax25_subr.c
index 9ff98f46dc6b..fbfeb0978411 100644
--- a/net/ax25/ax25_subr.c
+++ b/net/ax25/ax25_subr.c
@@ -34,6 +34,7 @@ void ax25_clear_queues(ax25_cb *ax25)
 {
 	skb_queue_purge(&ax25->write_queue);
 	skb_queue_purge(&ax25->ack_queue);
+	skb_queue_purge(&ax25->xmit_queue);
 	skb_queue_purge(&ax25->reseq_queue);
 	skb_queue_purge(&ax25->frag_queue);
 }
@@ -45,31 +46,51 @@ void ax25_clear_queues(ax25_cb *ax25)
  */
 void ax25_frames_acked(ax25_cb *ax25, unsigned short nr)
 {
+	struct sk_buff_head acked;
 	struct sk_buff *skb;
 
+	__skb_queue_head_init(&acked);
+
 	/*
-	 * Remove all the ack-ed frames from the ack queue.
+	 * Remove all the ack-ed frames from the ack queue. ax25_kick() may be
+	 * filling it from another CPU: move V(A) and the queue together, and
+	 * free the frames once the lock is dropped.
 	 */
-	if (ax25->va != nr) {
-		while (skb_peek(&ax25->ack_queue) != NULL && ax25->va != nr) {
-			skb = skb_dequeue(&ax25->ack_queue);
-			kfree_skb(skb);
-			ax25->va = (ax25->va + 1) % ax25->modulus;
-		}
+	spin_lock_bh(&ax25->lock);
+	/*
+	 * ax25_clear_queues() purges the ack queue without ax25->lock: test
+	 * what skb_dequeue() returns, not what skb_peek() saw before it.
+	 */
+	while (ax25->va != nr && (skb = skb_dequeue(&ax25->ack_queue)) != NULL) {
+		__skb_queue_tail(&acked, skb);
+		ax25->va = (ax25->va + 1) % ax25->modulus;
 	}
+	spin_unlock_bh(&ax25->lock);
+
+	__skb_queue_purge(&acked);
 }
 
 void ax25_requeue_frames(ax25_cb *ax25)
 {
+	struct sk_buff_head stale;
 	struct sk_buff *skb;
 
+	__skb_queue_head_init(&stale);
+
 	/*
 	 * Requeue all the un-ack-ed frames on the output queue to be picked
 	 * up by ax25_kick called from the timer. This arrangement handles the
-	 * possibility of an empty output queue.
+	 * possibility of an empty output queue. Copies that ax25_kick() has
+	 * numbered but not sent yet are stale: they will be sent again.
 	 */
+	spin_lock_bh(&ax25->lock);
+	while ((skb = skb_dequeue(&ax25->xmit_queue)) != NULL)
+		__skb_queue_tail(&stale, skb);
 	while ((skb = skb_dequeue_tail(&ax25->ack_queue)) != NULL)
 		skb_queue_head(&ax25->write_queue, skb);
+	spin_unlock_bh(&ax25->lock);
+
+	__skb_queue_purge(&stale);
 }
 
 /*
@@ -102,6 +123,9 @@ int ax25_decode(ax25_cb *ax25, struct sk_buff *skb, int *ns, int *nr, int *pf)
 	frame = skb->data;
 	*ns = *nr = *pf = 0;
 
+	if (skb->len < 1)
+		return frametype;
+
 	if (ax25->modulus == AX25_MODULUS) {
 		if ((frame[0] & AX25_S) == 0) {
 			frametype = AX25_I;			/* I frame - carries NR/NS/PF */
@@ -118,6 +142,10 @@ int ax25_decode(ax25_cb *ax25, struct sk_buff *skb, int *ns, int *nr, int *pf)
 		}
 		skb_pull(skb, 1);
 	} else {
+		/* I and S frames carry a two-byte control field here */
+		if ((frame[0] & AX25_U) != 3 && skb->len < 2)
+			return frametype;
+
 		if ((frame[0] & AX25_S) == 0) {
 			frametype = AX25_I;			/* I frame - carries NR/NS/PF */
 			*ns = (frame[0] >> 1) & 0x7F;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 61914f280d6f..894fcd779bd0 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -625,6 +625,10 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 	       __le16_to_cpu(chan->psm), chan->dcid);
 
+	/* Caller must ensure l2cap_chan is linked to l2cap_conn only once */
+	if (WARN_ON_ONCE(chan->conn || test_bit(FLAG_DEL, &chan->flags)))
+		return;
+
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = l2cap_conn_get(conn);
@@ -7388,7 +7392,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
 		}
 	}
 
-	if (cid && __l2cap_get_chan_by_dcid(conn, cid)) {
+	if ((cid && __l2cap_get_chan_by_dcid(conn, cid)) || chan->conn ||
+	    test_bit(FLAG_DEL, &chan->flags)) {
 		hci_conn_drop(hcon);
 		err = -EBUSY;
 		goto chan_unlock;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ef3af57e4637..f08512a57ab5 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -112,6 +112,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			return -EINVAL;
 	}
 
+	l2cap_chan_lock(chan);
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -177,6 +178,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 
 done:
 	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return err;
 }
 
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 5bddd04b76ba..50bd0b3f56bb 100644
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
index ce4569a56887..ac20edd3a926 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1040,7 +1040,8 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	if (WARN_ON(size > max_size))
 		return 0;
 
-	size = ALIGN(size, dma_get_cache_alignment());
+	size = ALIGN(size, max_t(unsigned int, dma_get_cache_alignment(),
+				 __alignof__(struct skb_shared_info)));
 	*offset = pool->frag_offset;
 
 	if (netmem && *offset + size > max_size) {
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index 1e7961b8a7ce..9599bdb30c19 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -856,7 +856,7 @@ static void fib_rebalance(struct fib_info *fi)
 	change_nexthops(fi) {
 		int upper_bound;
 
-		if (nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
+		if (!total || nexthop_nh->fib_nh_flags & RTNH_F_DEAD) {
 			upper_bound = -1;
 		} else if (ip_ignore_linkdown(nexthop_nh->fib_nh_dev) &&
 			   nexthop_nh->fib_nh_flags & RTNH_F_LINKDOWN) {
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7df7ce86b690..5c2314e600ab 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4403,9 +4403,11 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
@@ -4418,16 +4420,24 @@ int do_tcp_getsockopt(struct sock *sk, int level,
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
index 0306d257fa64..f3c516da0a94 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -222,7 +222,7 @@ void tcp_assign_congestion_control(struct sock *sk)
 	ca = rcu_dereference(net->ipv4.tcp_congestion_control);
 	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
 		ca = &tcp_reno;
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	rcu_read_unlock();
 
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
@@ -252,7 +252,7 @@ static void tcp_reinit_congestion_control(struct sock *sk,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_cleanup_congestion_control(sk);
-	icsk->icsk_ca_ops = ca;
+	WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	icsk->icsk_ca_setsockopt = 1;
 	memset(icsk->icsk_ca_priv, 0, sizeof(icsk->icsk_ca_priv));
 
diff --git a/net/ipv4/tcp_dctcp.c b/net/ipv4/tcp_dctcp.c
index 8a45a4aea933..f489eb5fc775 100644
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
index 05fae88526ec..a43f082b871e 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -468,7 +468,7 @@ void tcp_ca_openreq_child(struct sock *sk, const struct dst_entry *dst)
 		ca = tcp_ca_find_key(ca_key);
 		if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 			icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-			icsk->icsk_ca_ops = ca;
+			WRITE_ONCE(icsk->icsk_ca_ops, ca);
 			ca_got_dst = true;
 		}
 		rcu_read_unlock();
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index feb94fd45c59..6f4da22ccbdf 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3888,7 +3888,7 @@ static void tcp_ca_dst_init(struct sock *sk, const struct dst_entry *dst)
 	if (likely(ca && bpf_try_module_get(ca, ca->owner))) {
 		bpf_module_put(icsk->icsk_ca_ops, icsk->icsk_ca_ops->owner);
 		icsk->icsk_ca_dst_locked = tcp_ca_dst_locked(dst);
-		icsk->icsk_ca_ops = ca;
+		WRITE_ONCE(icsk->icsk_ca_ops, ca);
 	}
 	rcu_read_unlock();
 }
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 69e689733741..22eee4fdd5d8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -869,7 +869,16 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
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
index f5cc02ea3092..3ab22f9b416e 100644
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
index f0a98c61a087..54fc4b0eb57b 100644
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
index d21fe27fe21e..4396a6b58b60 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -123,12 +123,7 @@ EXPORT_SYMBOL(ip6_dst_hoplimit);
 
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
index 5d9d595b9984..c7017ab56b1e 100644
--- a/net/iucv/af_iucv.c
+++ b/net/iucv/af_iucv.c
@@ -207,12 +207,6 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
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
@@ -247,13 +241,22 @@ static int afiucv_hs_send(struct iucv_message *imsg, struct sock *sock,
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
 
@@ -1237,6 +1240,7 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 	struct iucv_sock *iucv = iucv_sk(sk);
 	unsigned int copied, rlen;
 	struct sk_buff *skb, *rskb, *cskb;
+	bool send_win = false;
 	int err = 0;
 	u32 offset;
 
@@ -1327,16 +1331,20 @@ static int iucv_sock_recvmsg(struct socket *sock, struct msghdr *msg,
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
index 7684999b8634..66e61197bcd2 100644
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
index 835d02e14640..aba981f3845c 100644
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
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index da774b1a9460..00997357d4bc 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -74,6 +74,13 @@ bool __mptcp_try_fallback(struct mptcp_sock *msk, int fb_mib)
 	if (__mptcp_check_fallback(msk))
 		return true;
 
+	/* The caller possibly is not holding the msk socket lock, but
+	 * in the fallback case only the current subflow is touching
+	 * the OoO queue.
+	 */
+	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
+		return false;
+
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_infinite_fallback) {
 		spin_unlock_bh(&msk->fallback_lock);
@@ -943,13 +950,6 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	if (sk->sk_state != TCP_ESTABLISHED)
 		return false;
 
-	/* The caller possibly is not holding the msk socket lock, but
-	 * in the fallback case only the current subflow is touching
-	 * the OoO queue.
-	 */
-	if (!RB_EMPTY_ROOT(&msk->out_of_order_queue))
-		return false;
-
 	spin_lock_bh(&msk->fallback_lock);
 	if (!msk->allow_subflows) {
 		spin_unlock_bh(&msk->fallback_lock);
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index e0c2820be57e..9589abea2f03 100644
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
index de51b15cf53d..e2c109d5f069 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -562,7 +562,7 @@ dump_ipv6_packet(struct net *net, struct nf_log_buf *m,
 
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
index e250d4a3d030..7e1c087a9864 100644
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
 
@@ -1338,6 +1338,8 @@ int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
 	if (netlink_is_kernel(sk))
 		return netlink_unicast_kernel(sk, skb, ssk);
 
+	skb_reset_network_header(skb);
+	skb_reset_mac_header(skb);
 	if (sk_filter(sk, skb)) {
 		err = skb->len;
 		kfree_skb(skb);
@@ -1472,6 +1474,8 @@ static void do_one_broadcast(struct sock *sk,
 		goto out;
 	}
 
+	skb_reset_network_header(p->skb2);
+	skb_reset_mac_header(p->skb2);
 	if (sk_filter(sk, p->skb2)) {
 		kfree_skb(p->skb2);
 		p->skb2 = NULL;
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 6ee148f0e6d0..fc7bd19ad0e3 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -162,7 +162,8 @@ static struct sock *nr_find_listener(ax25_address *addr)
 /*
  *	Find a connected NET/ROM socket given my circuit IDs.
  */
-static struct sock *nr_find_socket(unsigned char index, unsigned char id)
+static struct sock *nr_find_socket(unsigned char index, unsigned char id,
+				   const ax25_address *src)
 {
 	struct sock *s;
 
@@ -170,7 +171,8 @@ static struct sock *nr_find_socket(unsigned char index, unsigned char id)
 	sk_for_each(s, &nr_list) {
 		struct nr_sock *nr = nr_sk(s);
 
-		if (nr->my_index == index && nr->my_id == id) {
+		if (nr->my_index == index && nr->my_id == id &&
+		    (!src || !ax25cmp(&nr->dest_addr, src))) {
 			sock_hold(s);
 			goto found;
 		}
@@ -219,7 +221,8 @@ static unsigned short nr_find_next_circuit(void)
 		j = id % 256;
 
 		if (i != 0 && j != 0) {
-			if ((sk=nr_find_socket(i, j)) == NULL)
+			sk = nr_find_socket(i, j, NULL);
+			if (!sk)
 				break;
 			sock_put(sk);
 		}
@@ -885,6 +888,11 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 	 *	skb->data points to the netrom frame start
 	 */
 
+	if (skb_linearize(skb))
+		return 0;
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN)
+		return 0;
+
 	src  = (ax25_address *)(skb->data + 0);
 	dest = (ax25_address *)(skb->data + 7);
 
@@ -923,10 +931,21 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		if (frametype == NR_CONNREQ)
 			sk = nr_find_peer(circuit_index, circuit_id, src);
 		else
-			sk = nr_find_socket(circuit_index, circuit_id);
+			sk = nr_find_socket(circuit_index, circuit_id, src);
 	}
 
 	if (sk != NULL) {
+		/*
+		 * nr_state1_machine() reads the window size at byte 20, but
+		 * only for a plain CONNACK. A CONNACK with the choke flag set
+		 * is a refusal or a reset, sent as a 20-byte frame by
+		 * __nr_transmit_reply(), and must not be dropped here.
+		 */
+		if (frametype == NR_CONNACK && !flags &&
+		    skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1) {
+			sock_put(sk);
+			return 0;
+		}
 		bh_lock_sock(sk);
 		skb_reset_transport_header(skb);
 
@@ -961,10 +980,14 @@ int nr_rx_frame(struct sk_buff *skb, struct net_device *dev)
 		return 0;
 	}
 
-	sk = nr_find_listener(dest);
+	/* Need window (byte 20) and user address (bytes 21-27) */
+	if (skb->len < NR_NETWORK_LEN + NR_TRANSPORT_LEN + 1 + AX25_ADDR_LEN)
+		return 0;
 
 	user = (ax25_address *)(skb->data + 21);
 
+	sk = nr_find_listener(dest);
+
 	if (sk == NULL || sk_acceptq_is_full(sk) ||
 	    (make = nr_make_new(sk)) == NULL) {
 		nr_transmit_refusal(skb, 0);
diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 97944db6b5ac..b90a47dcf165 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -26,6 +26,9 @@
 #include <linux/interrupt.h>
 #include <net/netrom.h>
 
+/* nr_sendmsg() never sends more than this in one message */
+#define NR_MAX_REASM_LEN	65536
+
 static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 {
 	struct sk_buff *skbo, *skbn = skb;
@@ -35,6 +38,29 @@ static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 
 	nr_start_idletimer(sk);
 
+	/* Rest of a message already found to be too long: drop it */
+	if (nr->condition & NR_COND_FRAG_DISCARD) {
+		if (!more)
+			nr->condition &= ~NR_COND_FRAG_DISCARD;
+		kfree_skb(skb);
+		return 0;
+	}
+
+	/*
+	 * Give up on a message that would grow beyond what a peer may
+	 * send. The frame is consumed rather than handed back to the
+	 * caller, which would queue it again after skb_pull().
+	 */
+	if ((more || nr->fraglen > 0) &&
+	    nr->fraglen + skb->len > NR_MAX_REASM_LEN) {
+		skb_queue_purge(&nr->frag_queue);
+		nr->fraglen = 0;
+		if (more)
+			nr->condition |= NR_COND_FRAG_DISCARD;
+		kfree_skb(skb);
+		return 0;
+	}
+
 	if (more) {
 		nr->fraglen += skb->len;
 		skb_queue_tail(&nr->frag_queue, skb);
diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 9cc29ae85b06..288c4a91ea9b 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -36,46 +36,58 @@
 
 static unsigned int nr_neigh_no = 1;
 
+/*
+ * nr_route_lock protects both lists and the routing data hanging off them:
+ * which, count and routes[] of every node. It is taken with bottom halves
+ * disabled, is never nested with itself, and may be held while calling into
+ * AX.25 (nr_route_frame() -> ax25_send_frame()), so it must never be taken
+ * with an AX.25 list lock held.
+ */
+static DEFINE_SPINLOCK(nr_route_lock);
 static HLIST_HEAD(nr_node_list);
-static DEFINE_SPINLOCK(nr_node_list_lock);
 static HLIST_HEAD(nr_neigh_list);
-static DEFINE_SPINLOCK(nr_neigh_list_lock);
 
-static struct nr_node *nr_node_get(ax25_address *callsign)
+static struct nr_node *__nr_node_get(ax25_address *callsign)
 {
-	struct nr_node *found = NULL;
 	struct nr_node *nr_node;
 
-	spin_lock_bh(&nr_node_list_lock);
+	lockdep_assert_held(&nr_route_lock);
+
 	nr_node_for_each(nr_node, &nr_node_list)
 		if (ax25cmp(callsign, &nr_node->callsign) == 0) {
 			nr_node_hold(nr_node);
-			found = nr_node;
-			break;
+			return nr_node;
 		}
-	spin_unlock_bh(&nr_node_list_lock);
+	return NULL;
+}
+
+static struct nr_node *nr_node_get(ax25_address *callsign)
+{
+	struct nr_node *found;
+
+	spin_lock_bh(&nr_route_lock);
+	found = __nr_node_get(callsign);
+	spin_unlock_bh(&nr_route_lock);
 	return found;
 }
 
-static struct nr_neigh *nr_neigh_get_dev(ax25_address *callsign,
-					 struct net_device *dev)
+static struct nr_neigh *__nr_neigh_get_dev(ax25_address *callsign,
+					   struct net_device *dev)
 {
-	struct nr_neigh *found = NULL;
 	struct nr_neigh *nr_neigh;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	lockdep_assert_held(&nr_route_lock);
+
 	nr_neigh_for_each(nr_neigh, &nr_neigh_list)
 		if (ax25cmp(callsign, &nr_neigh->callsign) == 0 &&
 		    nr_neigh->dev == dev) {
 			nr_neigh_hold(nr_neigh);
-			found = nr_neigh;
-			break;
+			return nr_neigh;
 		}
-	spin_unlock_bh(&nr_neigh_list_lock);
-	return found;
+	return NULL;
 }
 
-static void nr_remove_neigh(struct nr_neigh *);
+static void nr_remove_neigh_locked(struct nr_neigh *nr_neigh);
 
 /*      re-sort the routes in quality order.    */
 static void re_sort_routes(struct nr_node *nr_node, int x, int y)
@@ -90,6 +102,66 @@ static void re_sort_routes(struct nr_node *nr_node, int x, int y)
 	}
 }
 
+/*
+ * Allocate a neighbour and link it into nr_neigh_list. The list holds one
+ * reference and the caller gets another one. Called with nr_route_lock held.
+ */
+static struct nr_neigh *nr_neigh_create_locked(ax25_address *callsign,
+					       ax25_digi *ax25_digi,
+					       struct net_device *dev,
+					       unsigned int quality,
+					       unsigned char locked)
+{
+	struct nr_neigh *nr_neigh;
+
+	lockdep_assert_held(&nr_route_lock);
+
+	nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC);
+	if (!nr_neigh)
+		return NULL;
+
+	nr_neigh->callsign = *callsign;
+	nr_neigh->digipeat = NULL;
+	nr_neigh->ax25     = NULL;
+	nr_neigh->dev      = dev;
+	nr_neigh->quality  = quality;
+	nr_neigh->locked   = locked;
+	nr_neigh->count    = 0;
+	nr_neigh->number   = nr_neigh_no++;
+	nr_neigh->failed   = 0;
+	refcount_set(&nr_neigh->refcount, 1);
+
+	if (ax25_digi && ax25_digi->ndigi > 0) {
+		nr_neigh->digipeat = kmemdup(ax25_digi, sizeof(*ax25_digi),
+					     GFP_ATOMIC);
+		if (!nr_neigh->digipeat) {
+			kfree(nr_neigh);
+			return NULL;
+		}
+	}
+
+	hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
+	nr_neigh_hold(nr_neigh);
+
+	return nr_neigh;
+}
+
+/*
+ * Drop one route's use of a neighbour. The neighbour is unlinked when no
+ * route uses it any more and it was not added explicitly; count and locked
+ * are read before the route's reference is dropped, since that reference
+ * may be the last one. Called with nr_route_lock held.
+ */
+static void nr_neigh_route_put_locked(struct nr_neigh *nr_neigh)
+{
+	lockdep_assert_held(&nr_route_lock);
+
+	nr_neigh->count--;
+	if (nr_neigh->count == 0 && !nr_neigh->locked)
+		nr_remove_neigh_locked(nr_neigh);
+	nr_neigh_put(nr_neigh);
+}
+
 /*
  *	Add a new route to a node, and in the process add the node and the
  *	neighbour if it is new.
@@ -100,7 +172,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 {
 	struct nr_node  *nr_node;
 	struct nr_neigh *nr_neigh;
-	int i, found;
+	int i, found, ret = 0;
 	struct net_device *odev;
 
 	if ((odev=nr_dev_get(nr)) != NULL) {	/* Can't add routes to ourself */
@@ -108,9 +180,15 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		return -EINVAL;
 	}
 
-	nr_node = nr_node_get(nr);
+	/*
+	 * Look up and update under one critical section, so that a node or
+	 * neighbour found here cannot be unlinked before it is used.
+	 */
+	spin_lock_bh(&nr_route_lock);
+
+	nr_node = __nr_node_get(nr);
 
-	nr_neigh = nr_neigh_get_dev(ax25, dev);
+	nr_neigh = __nr_neigh_get_dev(ax25, dev);
 
 	/*
 	 * The L2 link to a neighbour has failed in the past
@@ -121,16 +199,12 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	if (nr_neigh != NULL && nr_neigh->failed != 0 && quality == 0) {
 		struct nr_node *nr_nodet;
 
-		spin_lock_bh(&nr_node_list_lock);
 		nr_node_for_each(nr_nodet, &nr_node_list) {
-			nr_node_lock(nr_nodet);
 			for (i = 0; i < nr_nodet->count; i++)
 				if (nr_nodet->routes[i].neighbour == nr_neigh)
 					if (i < nr_nodet->which)
 						nr_nodet->which = i;
-			nr_node_unlock(nr_nodet);
 		}
-		spin_unlock_bh(&nr_node_list_lock);
 	}
 
 	if (nr_neigh != NULL)
@@ -139,43 +213,19 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	if (quality == 0 && nr_neigh != NULL && nr_node != NULL) {
 		nr_neigh_put(nr_neigh);
 		nr_node_put(nr_node);
-		return 0;
+		goto out;
 	}
 
 	if (nr_neigh == NULL) {
-		if ((nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC)) == NULL) {
+		unsigned int q = READ_ONCE(sysctl_netrom_default_path_quality);
+
+		nr_neigh = nr_neigh_create_locked(ax25, ax25_digi, dev, q, 0);
+		if (!nr_neigh) {
 			if (nr_node)
 				nr_node_put(nr_node);
-			return -ENOMEM;
-		}
-
-		nr_neigh->callsign = *ax25;
-		nr_neigh->digipeat = NULL;
-		nr_neigh->ax25     = NULL;
-		nr_neigh->dev      = dev;
-		nr_neigh->quality  = READ_ONCE(sysctl_netrom_default_path_quality);
-		nr_neigh->locked   = 0;
-		nr_neigh->count    = 0;
-		nr_neigh->number   = nr_neigh_no++;
-		nr_neigh->failed   = 0;
-		refcount_set(&nr_neigh->refcount, 1);
-
-		if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
-			nr_neigh->digipeat = kmemdup(ax25_digi,
-						     sizeof(*ax25_digi),
-						     GFP_KERNEL);
-			if (nr_neigh->digipeat == NULL) {
-				kfree(nr_neigh);
-				if (nr_node)
-					nr_node_put(nr_node);
-				return -ENOMEM;
-			}
+			ret = -ENOMEM;
+			goto out;
 		}
-
-		spin_lock_bh(&nr_neigh_list_lock);
-		hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
-		nr_neigh_hold(nr_neigh);
-		spin_unlock_bh(&nr_neigh_list_lock);
 	}
 
 	if (quality != 0 && ax25cmp(nr, ax25) == 0 && !nr_neigh->locked)
@@ -183,9 +233,9 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 
 	if (nr_node == NULL) {
 		if ((nr_node = kmalloc(sizeof(*nr_node), GFP_ATOMIC)) == NULL) {
-			if (nr_neigh)
-				nr_neigh_put(nr_neigh);
-			return -ENOMEM;
+			nr_neigh_put(nr_neigh);
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		nr_node->callsign = *nr;
@@ -194,7 +244,6 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_node->which = 0;
 		nr_node->count = 1;
 		refcount_set(&nr_node->refcount, 1);
-		spin_lock_init(&nr_node->node_lock);
 
 		nr_node->routes[0].quality   = quality;
 		nr_node->routes[0].obs_count = obs_count;
@@ -203,15 +252,12 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		nr_neigh_hold(nr_neigh);
 		nr_neigh->count++;
 
-		spin_lock_bh(&nr_node_list_lock);
 		hlist_add_head(&nr_node->node_node, &nr_node_list);
 		/* refcount initialized at 1 */
-		spin_unlock_bh(&nr_node_list_lock);
 
 		nr_neigh_put(nr_neigh);
-		return 0;
+		goto out;
 	}
-	nr_node_lock(nr_node);
 
 	if (quality != 0)
 		strscpy(nr_node->mnemonic, mnemonic);
@@ -242,11 +288,7 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 		} else {
 			/* It must be better than the worst */
 			if (quality > nr_node->routes[2].quality) {
-				nr_node->routes[2].neighbour->count--;
-				nr_neigh_put(nr_node->routes[2].neighbour);
-
-				if (nr_node->routes[2].neighbour->count == 0 && !nr_node->routes[2].neighbour->locked)
-					nr_remove_neigh(nr_node->routes[2].neighbour);
+				nr_neigh_route_put_locked(nr_node->routes[2].neighbour);
 
 				nr_node->routes[2].quality   = quality;
 				nr_node->routes[2].obs_count = obs_count;
@@ -280,35 +322,28 @@ static int __must_check nr_add_node(ax25_address *nr, const char *mnemonic,
 	}
 
 	nr_neigh_put(nr_neigh);
-	nr_node_unlock(nr_node);
 	nr_node_put(nr_node);
-	return 0;
+out:
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 static void nr_remove_node_locked(struct nr_node *nr_node)
 {
-	lockdep_assert_held(&nr_node_list_lock);
+	lockdep_assert_held(&nr_route_lock);
 
 	hlist_del_init(&nr_node->node_node);
 	nr_node_put(nr_node);
 }
 
-static inline void __nr_remove_neigh(struct nr_neigh *nr_neigh)
+static void nr_remove_neigh_locked(struct nr_neigh *nr_neigh)
 {
+	lockdep_assert_held(&nr_route_lock);
+
 	hlist_del_init(&nr_neigh->neigh_node);
 	nr_neigh_put(nr_neigh);
 }
 
-#define nr_remove_neigh_locked(__neigh) \
-	__nr_remove_neigh(__neigh)
-
-static void nr_remove_neigh(struct nr_neigh *nr_neigh)
-{
-	spin_lock_bh(&nr_neigh_list_lock);
-	__nr_remove_neigh(nr_neigh);
-	spin_unlock_bh(&nr_neigh_list_lock);
-}
-
 /*
  *	"Delete" a node. Strictly speaking remove a route to a node. The node
  *	is only deleted if no routes are left to it.
@@ -317,29 +352,25 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 {
 	struct nr_node  *nr_node;
 	struct nr_neigh *nr_neigh;
-	int i;
+	int i, ret = -EINVAL;
 
-	nr_node = nr_node_get(callsign);
+	spin_lock_bh(&nr_route_lock);
+
+	nr_node = __nr_node_get(callsign);
 
 	if (nr_node == NULL)
-		return -EINVAL;
+		goto out;
 
-	nr_neigh = nr_neigh_get_dev(neighbour, dev);
+	nr_neigh = __nr_neigh_get_dev(neighbour, dev);
 
 	if (nr_neigh == NULL) {
 		nr_node_put(nr_node);
-		return -EINVAL;
+		goto out;
 	}
 
-	spin_lock_bh(&nr_node_list_lock);
-	nr_node_lock(nr_node);
 	for (i = 0; i < nr_node->count; i++) {
 		if (nr_node->routes[i].neighbour == nr_neigh) {
-			nr_neigh->count--;
-			nr_neigh_put(nr_neigh);
-
-			if (nr_neigh->count == 0 && !nr_neigh->locked)
-				nr_remove_neigh(nr_neigh);
+			nr_neigh_route_put_locked(nr_neigh);
 			nr_neigh_put(nr_neigh);
 
 			nr_node->count--;
@@ -357,20 +388,18 @@ static int nr_del_node(ax25_address *callsign, ax25_address *neighbour, struct n
 				case 2:
 					break;
 				}
-				nr_node_put(nr_node);
 			}
-			nr_node_unlock(nr_node);
-			spin_unlock_bh(&nr_node_list_lock);
-
-			return 0;
+			/* Drop the reference taken by __nr_node_get() */
+			nr_node_put(nr_node);
+			ret = 0;
+			goto out;
 		}
 	}
 	nr_neigh_put(nr_neigh);
-	nr_node_unlock(nr_node);
-	spin_unlock_bh(&nr_node_list_lock);
 	nr_node_put(nr_node);
-
-	return -EINVAL;
+out:
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 /*
@@ -380,44 +409,25 @@ static int __must_check nr_add_neigh(ax25_address *callsign,
 	ax25_digi *ax25_digi, struct net_device *dev, unsigned int quality)
 {
 	struct nr_neigh *nr_neigh;
+	int ret = 0;
 
-	nr_neigh = nr_neigh_get_dev(callsign, dev);
+	spin_lock_bh(&nr_route_lock);
+
+	nr_neigh = __nr_neigh_get_dev(callsign, dev);
 	if (nr_neigh) {
 		nr_neigh->quality = quality;
 		nr_neigh->locked  = 1;
-		nr_neigh_put(nr_neigh);
-		return 0;
-	}
-
-	if ((nr_neigh = kmalloc(sizeof(*nr_neigh), GFP_ATOMIC)) == NULL)
-		return -ENOMEM;
-
-	nr_neigh->callsign = *callsign;
-	nr_neigh->digipeat = NULL;
-	nr_neigh->ax25     = NULL;
-	nr_neigh->dev      = dev;
-	nr_neigh->quality  = quality;
-	nr_neigh->locked   = 1;
-	nr_neigh->count    = 0;
-	nr_neigh->number   = nr_neigh_no++;
-	nr_neigh->failed   = 0;
-	refcount_set(&nr_neigh->refcount, 1);
-
-	if (ax25_digi != NULL && ax25_digi->ndigi > 0) {
-		nr_neigh->digipeat = kmemdup(ax25_digi, sizeof(*ax25_digi),
-					     GFP_KERNEL);
-		if (nr_neigh->digipeat == NULL) {
-			kfree(nr_neigh);
-			return -ENOMEM;
-		}
+	} else {
+		nr_neigh = nr_neigh_create_locked(callsign, ax25_digi, dev,
+						  quality, 1);
+		if (!nr_neigh)
+			ret = -ENOMEM;
 	}
+	if (nr_neigh)
+		nr_neigh_put(nr_neigh);
 
-	spin_lock_bh(&nr_neigh_list_lock);
-	hlist_add_head(&nr_neigh->neigh_node, &nr_neigh_list);
-	/* refcount is initialized at 1 */
-	spin_unlock_bh(&nr_neigh_list_lock);
-
-	return 0;
+	spin_unlock_bh(&nr_route_lock);
+	return ret;
 }
 
 /*
@@ -428,17 +438,23 @@ static int nr_del_neigh(ax25_address *callsign, struct net_device *dev, unsigned
 {
 	struct nr_neigh *nr_neigh;
 
-	nr_neigh = nr_neigh_get_dev(callsign, dev);
+	spin_lock_bh(&nr_route_lock);
 
-	if (nr_neigh == NULL) return -EINVAL;
+	nr_neigh = __nr_neigh_get_dev(callsign, dev);
+
+	if (nr_neigh == NULL) {
+		spin_unlock_bh(&nr_route_lock);
+		return -EINVAL;
+	}
 
 	nr_neigh->quality = quality;
 	nr_neigh->locked  = 0;
 
 	if (nr_neigh->count == 0)
-		nr_remove_neigh(nr_neigh);
+		nr_remove_neigh_locked(nr_neigh);
 	nr_neigh_put(nr_neigh);
 
+	spin_unlock_bh(&nr_route_lock);
 	return 0;
 }
 
@@ -454,9 +470,8 @@ static int nr_dec_obs(void)
 	struct hlist_node *nodet;
 	int i;
 
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_node_for_each_safe(s, nodet, &nr_node_list) {
-		nr_node_lock(s);
 		for (i = 0; i < s->count; i++) {
 			switch (s->routes[i].obs_count) {
 			case 0:		/* A locked entry */
@@ -465,11 +480,7 @@ static int nr_dec_obs(void)
 			case 1:		/* From 1 -> 0 */
 				nr_neigh = s->routes[i].neighbour;
 
-				nr_neigh->count--;
-				nr_neigh_put(nr_neigh);
-
-				if (nr_neigh->count == 0 && !nr_neigh->locked)
-					nr_remove_neigh(nr_neigh);
+				nr_neigh_route_put_locked(nr_neigh);
 
 				s->count--;
 
@@ -494,9 +505,8 @@ static int nr_dec_obs(void)
 
 		if (s->count <= 0)
 			nr_remove_node_locked(s);
-		nr_node_unlock(s);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 
 	return 0;
 }
@@ -511,14 +521,15 @@ void nr_rt_device_down(struct net_device *dev)
 	struct nr_node  *t;
 	int i;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_neigh_for_each_safe(s, nodet, &nr_neigh_list) {
 		if (s->dev == dev) {
-			spin_lock_bh(&nr_node_list_lock);
 			nr_node_for_each_safe(t, node2t, &nr_node_list) {
-				nr_node_lock(t);
 				for (i = 0; i < t->count; i++) {
 					if (t->routes[i].neighbour == s) {
+						s->count--;
+						nr_neigh_put(s);
+
 						t->count--;
 
 						switch (i) {
@@ -536,14 +547,12 @@ void nr_rt_device_down(struct net_device *dev)
 
 				if (t->count <= 0)
 					nr_remove_node_locked(t);
-				nr_node_unlock(t);
 			}
-			spin_unlock_bh(&nr_node_list_lock);
 
 			nr_remove_neigh_locked(s);
 		}
 	}
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 /*
@@ -707,36 +716,35 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	struct nr_neigh *s, *nr_neigh = NULL;
 	struct nr_node  *nr_node = NULL;
 
-	spin_lock_bh(&nr_neigh_list_lock);
+	/*
+	 * nr_route_frame() replaces nr_neigh->ax25 under nr_route_lock;
+	 * clear it and drop its reference under the same lock, so that the
+	 * two paths cannot both put the same ax25_cb.
+	 */
+	spin_lock_bh(&nr_route_lock);
 	nr_neigh_for_each(s, &nr_neigh_list) {
 		if (s->ax25 == ax25) {
-			nr_neigh_hold(s);
 			nr_neigh = s;
 			break;
 		}
 	}
-	spin_unlock_bh(&nr_neigh_list_lock);
 
 	if (nr_neigh == NULL)
-		return;
+		goto out;
 
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
-		nr_neigh_put(nr_neigh);
-		return;
-	}
-	spin_lock_bh(&nr_node_list_lock);
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count))
+		goto out;
+
 	nr_node_for_each(nr_node, &nr_node_list) {
-		nr_node_lock(nr_node);
 		if (nr_node->which < nr_node->count &&
 		    nr_node->routes[nr_node->which].neighbour == nr_neigh)
 			nr_node->which++;
-		nr_node_unlock(nr_node);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
-	nr_neigh_put(nr_neigh);
+out:
+	spin_unlock_bh(&nr_route_lock);
 }
 
 /*
@@ -755,10 +763,11 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	struct sk_buff *nskb, *oskb;
 
 	/*
-	 * Reject malformed packets early. Check that it contains at least 2
-	 * addresses and 1 byte more for Time-To-Live
+	 * Reject malformed packets early. Check that it contains at least
+	 * the network and transport headers (20 bytes), and that they are
+	 * in the linear part of the skb.
 	 */
-	if (skb->len < 2 * sizeof(ax25_address) + 1)
+	if (!pskb_may_pull(skb, NR_NETWORK_LEN + NR_TRANSPORT_LEN))
 		return 0;
 
 	nr_src  = (ax25_address *)(skb->data + 0);
@@ -792,10 +801,10 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nr_node = nr_node_get(nr_dest);
 	if (nr_node == NULL)
 		return 0;
-	nr_node_lock(nr_node);
+	spin_lock_bh(&nr_route_lock);
 
 	if (nr_node->which >= nr_node->count) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		return 0;
 	}
@@ -803,7 +812,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nr_neigh = nr_node->routes[nr_node->which].neighbour;
 
 	if ((dev = nr_dev_first()) == NULL) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		return 0;
 	}
@@ -814,7 +823,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 	nskb = skb_copy_expand(skb, dev->hard_header_len, 0, GFP_ATOMIC);
 
 	if (!nskb) {
-		nr_node_unlock(nr_node);
+		spin_unlock_bh(&nr_route_lock);
 		nr_node_put(nr_node);
 		dev_put(dev);
 		return 0;
@@ -836,7 +845,7 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 
 	dev_put(dev);
 	ret = (nr_neigh->ax25 != NULL);
-	nr_node_unlock(nr_node);
+	spin_unlock_bh(&nr_route_lock);
 	nr_node_put(nr_node);
 
 	if (ret)
@@ -848,9 +857,9 @@ int nr_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 #ifdef CONFIG_PROC_FS
 
 static void *nr_node_start(struct seq_file *seq, loff_t *pos)
-	__acquires(&nr_node_list_lock)
+	__acquires(&nr_route_lock)
 {
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	return seq_hlist_start_head(&nr_node_list, *pos);
 }
 
@@ -860,9 +869,9 @@ static void *nr_node_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void nr_node_stop(struct seq_file *seq, void *v)
-	__releases(&nr_node_list_lock)
+	__releases(&nr_route_lock)
 {
-	spin_unlock_bh(&nr_node_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 static int nr_node_show(struct seq_file *seq, void *v)
@@ -877,7 +886,6 @@ static int nr_node_show(struct seq_file *seq, void *v)
 		struct nr_node *nr_node = hlist_entry(v, struct nr_node,
 						      node_node);
 
-		nr_node_lock(nr_node);
 		seq_printf(seq, "%-9s %-7s  %d %d",
 			ax2asc(buf, &nr_node->callsign),
 			(nr_node->mnemonic[0] == '\0') ? "*" : nr_node->mnemonic,
@@ -890,7 +898,6 @@ static int nr_node_show(struct seq_file *seq, void *v)
 				nr_node->routes[i].obs_count,
 				nr_node->routes[i].neighbour->number);
 		}
-		nr_node_unlock(nr_node);
 
 		seq_puts(seq, "\n");
 	}
@@ -905,9 +912,9 @@ const struct seq_operations nr_node_seqops = {
 };
 
 static void *nr_neigh_start(struct seq_file *seq, loff_t *pos)
-	__acquires(&nr_neigh_list_lock)
+	__acquires(&nr_route_lock)
 {
-	spin_lock_bh(&nr_neigh_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	return seq_hlist_start_head(&nr_neigh_list, *pos);
 }
 
@@ -917,9 +924,9 @@ static void *nr_neigh_next(struct seq_file *seq, void *v, loff_t *pos)
 }
 
 static void nr_neigh_stop(struct seq_file *seq, void *v)
-	__releases(&nr_neigh_list_lock)
+	__releases(&nr_route_lock)
 {
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
 
 static int nr_neigh_show(struct seq_file *seq, void *v)
@@ -970,12 +977,9 @@ void nr_rt_free(void)
 	struct nr_node  *t = NULL;
 	struct hlist_node *nodet;
 
-	spin_lock_bh(&nr_neigh_list_lock);
-	spin_lock_bh(&nr_node_list_lock);
+	spin_lock_bh(&nr_route_lock);
 	nr_node_for_each_safe(t, nodet, &nr_node_list) {
-		nr_node_lock(t);
 		nr_remove_node_locked(t);
-		nr_node_unlock(t);
 	}
 	nr_neigh_for_each_safe(s, nodet, &nr_neigh_list) {
 		while(s->count) {
@@ -984,6 +988,5 @@ void nr_rt_free(void)
 		}
 		nr_remove_neigh_locked(s);
 	}
-	spin_unlock_bh(&nr_node_list_lock);
-	spin_unlock_bh(&nr_neigh_list_lock);
+	spin_unlock_bh(&nr_route_lock);
 }
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
 
diff --git a/net/rose/af_rose.c b/net/rose/af_rose.c
index 03a298ecb832..d8a86006c744 100644
--- a/net/rose/af_rose.c
+++ b/net/rose/af_rose.c
@@ -211,8 +211,21 @@ static void rose_kill_by_device(struct net_device *dev)
 		spin_lock_bh(&rose_list_lock);
 		if (rose->device == dev) {
 			rose_disconnect(sk, ENETUNREACH, ROSE_OUT_OF_ORDER, 0);
-			if (rose->neighbour)
+			/* Mark for destruction so rose_heartbeat_expiry()
+			 * cleans up the socket at its next tick rather than
+			 * looping forever in ROSE_STATE_0 with no owner.
+			 */
+			sock_set_flag(sk, SOCK_DESTROY);
+			if (rose->neighbour) {
 				rose_neigh_put(rose->neighbour);
+				/* Clear the pointer after dropping the reference, as
+				 * every other rose_neigh_put() site does.  Otherwise
+				 * rose_heartbeat_expiry() (STATE_0 reaping) sees a stale
+				 * rose->neighbour and puts it a second time -> rose_neigh
+				 * refcount underflow / use-after-free.
+				 */
+				rose->neighbour = NULL;
+			}
 			netdev_put(rose->device, &rose->dev_tracker);
 			rose->device = NULL;
 		}
@@ -358,6 +371,7 @@ static void rose_destroy_timer(struct timer_list *t)
  */
 void rose_destroy_socket(struct sock *sk)
 {
+	struct rose_sock *rose = rose_sk(sk);
 	struct sk_buff *skb;
 
 	rose_remove_socket(sk);
@@ -365,14 +379,36 @@ void rose_destroy_socket(struct sock *sk)
 	rose_stop_idletimer(sk);
 	rose_stop_timer(sk);
 
+	/* Drop any device reference not already released by rose_kill_by_device()
+	 * or rose_release() -- e.g. incoming sockets that were never accepted.
+	 */
+	if (rose->device) {
+		netdev_put(rose->device, &rose->dev_tracker);
+		rose->device = NULL;
+	}
+
 	rose_clear_queues(sk);		/* Flush the queues */
 
 	while ((skb = skb_dequeue(&sk->sk_receive_queue)) != NULL) {
-		if (skb->sk != sk) {	/* A pending connection */
-			/* Queue the unaccepted socket for death */
-			sock_set_flag(skb->sk, SOCK_DEAD);
-			rose_start_heartbeat(skb->sk);
-			rose_sk(skb->sk)->state = ROSE_STATE_0;
+		struct sock *child = skb->sk;
+
+		if (child != sk) {	/* A pending connection */
+			/* Queue the unaccepted socket for death, unless
+			 * rose_heartbeat_expiry() has already reaped it or is
+			 * about to (SOCK_DESTROY).
+			 */
+			local_bh_disable();
+			bh_lock_sock_nested(child);
+			if (!sock_flag(child, SOCK_DESTROY)) {
+				sock_set_flag(child, SOCK_DEAD);
+				rose_start_heartbeat(child);
+				rose_sk(child)->state = ROSE_STATE_0;
+			}
+			bh_unlock_sock(child);
+			local_bh_enable();
+
+			skb->sk = NULL;
+			sock_put(child);	/* the queue's reference */
 		}
 
 		kfree_skb(skb);
@@ -562,6 +598,7 @@ static int rose_create(struct net *net, struct socket *sock, int protocol,
 	rose = rose_sk(sk);
 
 	sock_init_data(sock, sk);
+	sk->sk_backlog_rcv = rose_backlog_rcv;
 
 	skb_queue_head_init(&rose->ack_queue);
 #ifdef M_BIT
@@ -601,6 +638,7 @@ static struct sock *rose_make_new(struct sock *osk)
 	rose = rose_sk(sk);
 
 	sock_init_data(NULL, sk);
+	sk->sk_backlog_rcv = rose_backlog_rcv;
 
 	skb_queue_head_init(&rose->ack_queue);
 #ifdef M_BIT
@@ -958,6 +996,7 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
 	 *	The write queue this time is holding sockets ready to use
 	 *	hooked into the SABM we saved
 	 */
+again:
 	for (;;) {
 		prepare_to_wait(sk_sleep(sk), &wait, TASK_INTERRUPTIBLE);
 
@@ -983,12 +1022,27 @@ static int rose_accept(struct socket *sock, struct socket *newsock,
 		goto out_release;
 
 	newsk = skb->sk;
+	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
+	if (sock_flag(newsk, SOCK_DESTROY)) {
+		/* The call went away and rose_heartbeat_expiry() reaped (or
+		 * is about to reap) the socket before it was accepted: drop
+		 * it and wait for the next one.
+		 */
+		release_sock(newsk);
+		skb->sk = NULL;
+		kfree_skb(skb);
+		sk_acceptq_removed(sk);
+		sock_put(newsk);	/* the queue's reference */
+		goto again;
+	}
 	sock_graft(newsk, newsock);
+	release_sock(newsk);
 
 	/* Now attach up the new socket */
 	skb->sk = NULL;
 	kfree_skb(skb);
 	sk_acceptq_removed(sk);
+	sock_put(newsk);		/* the queue's reference */
 
 out_release:
 	release_sock(sk);
@@ -1102,6 +1156,10 @@ int rose_rx_call_request(struct sk_buff *skb, struct net_device *dev, struct ros
 
 	rose_insert_socket(make);
 
+	/* The listener's queue holds a reference on the pending socket
+	 * until rose_accept() or rose_destroy_socket() takes it off.
+	 */
+	sock_hold(make);
 	skb_queue_head(&sk->sk_receive_queue, skb);
 
 	rose_start_heartbeat(make);
@@ -1270,7 +1328,10 @@ static int rose_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	skb_queue_tail(&sk->sk_write_queue, skb);	/* Shove it onto the queue */
 #endif
 
+	/* The receive path and the timers run rose_kick() too */
+	lock_sock(sk);
 	rose_kick(sk);
+	release_sock(sk);
 
 	return len;
 }
diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 666153a3dd8f..7a556254ee79 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -202,7 +202,18 @@ static int rose_state3_machine(struct sock *sk, struct sk_buff *skb, int framety
 		break;
 
 	default:
-		printk(KERN_WARNING "ROSE: unknown %02X in state 3\n", frametype);
+		/*
+		 * CALL_ACCEPTED (0x0F) and CLEAR_CONFIRMATION (0x17) may show
+		 * up in state 3 as a late or duplicated Call Accepted, or as
+		 * crossed clearing / a reused logical channel on a slow AX.25
+		 * link. These are harmless protocol races, so drop them
+		 * silently. Any other frame type is genuinely unexpected and
+		 * is still reported, rate limited to avoid flooding the log.
+		 */
+		if (frametype != ROSE_CALL_ACCEPTED &&
+		    frametype != ROSE_CLEAR_CONFIRMATION)
+			net_warn_ratelimited("ROSE: unknown %02X in state 3\n",
+					     frametype);
 		break;
 	}
 
@@ -298,3 +309,34 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 
 	return queued;
 }
+
+/*
+ * Frames for a socket are processed with the socket locked, as the timers
+ * already do: rose_kick() may be running in rose_sendmsg() on another CPU,
+ * and two of them reading the same V(S) send two different frames under the
+ * same N(S). If a process owns the socket the frame goes to its backlog and
+ * is processed when the socket is released. Returns non-zero if the skb has
+ * been consumed.
+ */
+int rose_rcv_frame(struct sock *sk, struct sk_buff *skb)
+{
+	int queued;
+
+	bh_lock_sock(sk);
+	if (!sock_owned_by_user(sk))
+		queued = rose_process_rx_frame(sk, skb);
+	else
+		queued = !sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf) +
+						  READ_ONCE(sk->sk_sndbuf));
+	bh_unlock_sock(sk);
+
+	return queued;
+}
+
+int rose_backlog_rcv(struct sock *sk, struct sk_buff *skb)
+{
+	if (!rose_process_rx_frame(sk, skb))
+		kfree_skb(skb);
+
+	return 0;
+}
diff --git a/net/rose/rose_link.c b/net/rose/rose_link.c
index 0f77ae8ef944..9cfd4aa174f8 100644
--- a/net/rose/rose_link.c
+++ b/net/rose/rose_link.c
@@ -142,6 +142,14 @@ void rose_link_rx_restart(struct sk_buff *skb, struct rose_neigh *neigh, unsigne
 
 	switch (frametype) {
 	case ROSE_RESTART_REQUEST:
+		/*
+		 * A Restart Request on a link that is already up means that
+		 * the other end has lost its virtual circuits, clear ours.
+		 * Nothing is established over a link that is not up yet, and
+		 * the calls waiting in neigh->queue must be left alone.
+		 */
+		if (neigh->restarted)
+			rose_link_restarted(neigh);
 		rose_stop_t0timer(neigh);
 		neigh->restarted = 1;
 		neigh->dce_mode  = (skb->data[3] == ROSE_DTE_ORIGINATED);
@@ -259,10 +267,49 @@ void rose_transmit_clear_request(struct rose_neigh *neigh, unsigned int lci, uns
 		kfree_skb(skb);
 }
 
+/*
+ * A neighbour has just been created while an AX.25 connection to it is
+ * already up, e.g. it was removed from the routing tables and added back.
+ * The other end still regards the link as restarted and will not restart it,
+ * and through calls only use restarted neighbours, so nothing would ever
+ * restart it from this end either: do it now.
+ */
+void rose_link_restart(struct rose_neigh *neigh)
+{
+	if (neigh->loopback || neigh->restarted || rose_t0timer_running(neigh))
+		return;
+
+	if (!rose_link_up(neigh))
+		return;
+
+	rose_transmit_restart_request(neigh);
+	neigh->dce_mode = 0;
+	rose_start_t0timer(neigh);
+}
+
+/*
+ * Start the restart procedure on a link that is down without waiting for
+ * a frame to send over it. Nothing is done while a restart is under way.
+ */
+void rose_link_bring_up(struct rose_neigh *neigh)
+{
+	if (neigh->loopback || neigh->restarted || rose_t0timer_running(neigh))
+		return;
+
+	rose_transmit_restart_request(neigh);
+	neigh->dce_mode = 0;
+	rose_start_t0timer(neigh);
+}
+
 void rose_transmit_link(struct sk_buff *skb, struct rose_neigh *neigh)
 {
 	unsigned char *dptr;
 
+	if (!neigh) {
+		kfree_skb(skb);
+		return;
+	}
+
 	if (neigh->loopback) {
 		rose_loopback_queue(skb, neigh);
 		return;
diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index fd4e4795776a..4e4a473910cc 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -107,7 +107,7 @@ static void rose_loopback_timer(struct timer_list *unused)
 
 		sk = rose_find_socket(lci_o, rose_loopback_neigh);
 		if (sk) {
-			if (rose_process_rx_frame(sk, skb) == 0)
+			if (rose_rcv_frame(sk, skb) == 0)
 				kfree_skb(skb);
 			continue;
 		}
diff --git a/net/rose/rose_out.c b/net/rose/rose_out.c
index 9050e33c9604..6672fc65a765 100644
--- a/net/rose/rose_out.c
+++ b/net/rose/rose_out.c
@@ -34,6 +34,7 @@ static void rose_send_iframe(struct sock *sk, struct sk_buff *skb)
 	if (skb == NULL)
 		return;
 
+	skb->data[2] &= ROSE_M_BIT;
 	skb->data[2] |= (rose->vr << 5) & 0xE0;
 	skb->data[2] |= (rose->vs << 1) & 0x0E;
 
diff --git a/net/rose/rose_route.c b/net/rose/rose_route.c
index 28746ae5a258..6a1de0055e28 100644
--- a/net/rose/rose_route.c
+++ b/net/rose/rose_route.c
@@ -53,6 +53,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 {
 	struct rose_node  *rose_node, *rose_tmpn, *rose_tmpp;
 	struct rose_neigh *rose_neigh;
+	bool new_neigh = false;
 	int i, res = 0;
 
 	spin_lock_bh(&rose_node_list_lock);
@@ -125,6 +126,7 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 
 		rose_neigh->next = rose_neigh_list;
 		rose_neigh_list  = rose_neigh;
+		new_neigh        = true;
 	}
 
 	/*
@@ -192,6 +194,14 @@ static int __must_check rose_add_node(struct rose_route_struct *rose_route,
 	}
 
 out:
+	/*
+	 * The AX.25 connection of a neighbour that was removed from the tables
+	 * outlives it. If it is still there, the other end will not restart
+	 * the link: do it from here.
+	 */
+	if (new_neigh && res == 0)
+		rose_link_restart(rose_neigh);
+
 	spin_unlock_bh(&rose_neigh_list_lock);
 	spin_unlock_bh(&rose_node_list_lock);
 
@@ -229,8 +239,14 @@ static void rose_remove_neigh(struct rose_neigh *rose_neigh)
 {
 	struct rose_neigh *s;
 
-	del_timer_sync(&rose_neigh->ftimer);
-	del_timer_sync(&rose_neigh->t0timer);
+	/* Being removed from the list is final teardown for this neighbour:
+	 * shut the timers down rather than just deleting them, so a t0timer
+	 * self-rearm losing the race with this removal can't bring it back to
+	 * life later.  See the comment in rose_neigh_put() (include/net/rose.h)
+	 * for the full story.
+	 */
+	timer_shutdown_sync(&rose_neigh->ftimer);
+	timer_shutdown_sync(&rose_neigh->t0timer);
 
 	skb_queue_purge(&rose_neigh->queue);
 
@@ -279,6 +295,49 @@ static void rose_remove_route(struct rose_route *rose_route)
 	}
 }
 
+/*
+ *	A neighbour is being removed from the tables while its link may still
+ *	be up (route deleted or routes cleared by the configuration). Clear the
+ *	through routes using it, on both sides since both can still be reached,
+ *	instead of leaving them in rose_route_list for ever: no frame can reach
+ *	them once the neighbour is gone. Local connections using it are cut too,
+ *	as rose_link_failed() does.
+ *
+ *	Caller is holding rose_node_list_lock and rose_neigh_list_lock, taken
+ *	before rose_route_list_lock as in rose_route_frame() and
+ *	rose_link_failed().
+ */
+static void rose_neigh_clear_routes(struct rose_neigh *rose_neigh)
+{
+	struct rose_route *rose_route, *s;
+
+	spin_lock_bh(&rose_route_list_lock);
+
+	rose_route = rose_route_list;
+	while (rose_route != NULL) {
+		s = rose_route->next;
+
+		if (rose_route->neigh1 == rose_neigh ||
+		    rose_route->neigh2 == rose_neigh) {
+			if (rose_route->neigh1 != NULL)
+				rose_transmit_clear_request(rose_route->neigh1,
+							    rose_route->lci1,
+							    ROSE_OUT_OF_ORDER, 0);
+			if (rose_route->neigh2 != NULL)
+				rose_transmit_clear_request(rose_route->neigh2,
+							    rose_route->lci2,
+							    ROSE_OUT_OF_ORDER, 0);
+			rose_remove_route(rose_route);
+		}
+
+		rose_route = s;
+	}
+
+	spin_unlock_bh(&rose_route_list_lock);
+
+	rose_kill_by_neigh(rose_neigh);
+}
+
 /*
  *	"Delete" a node. Strictly speaking remove a route to a node. The node
  *	is only deleted if no routes are left to it.
@@ -327,6 +386,7 @@ static int rose_del_node(struct rose_route_struct *rose_route,
 			rose_neigh_put(rose_neigh);
 
 			if (rose_neigh->count == 0) {
+				rose_neigh_clear_routes(rose_neigh);
 				rose_remove_neigh(rose_neigh);
 				rose_neigh_put(rose_neigh);
 			}
@@ -541,8 +601,8 @@ void rose_route_device_down(struct net_device *dev)
 #endif
 
 /*
- *	Clear all nodes and neighbours out, except for neighbours with
- *	active connections going through them.
+ *	Clear all nodes and neighbours out, with the through routes and
+ *	connections using those neighbours.
  *  Do not clear loopback neighbour and nodes.
  */
 static int rose_clear_routes(void)
@@ -573,6 +633,7 @@ static int rose_clear_routes(void)
 		rose_neigh = rose_neigh->next;
 
 		if (!s->loopback) {
+			rose_neigh_clear_routes(s);
 			rose_remove_neigh(s);
 			rose_neigh_put(s);
 		}
@@ -680,6 +741,7 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 	unsigned char *diagnostic, int route_frame)
 {
 	struct rose_neigh *res = NULL;
+	struct rose_neigh *down = NULL;
 	struct rose_node *node;
 	int failed = 0;
 	int i;
@@ -691,8 +753,21 @@ struct rose_neigh *rose_get_neigh(rose_address *addr, unsigned char *cause,
 				if (node->neighbour[i]->restarted) {
 					res = node->neighbour[i];
 					rose_neigh_hold(node->neighbour[i]);
+					/*
+					 * A neighbour of a more specific route
+					 * was passed over because its link is
+					 * down: this call does not wait for it,
+					 * but have the link brought up for the
+					 * next ones.
+					 */
+					if (down)
+						rose_link_bring_up(down);
 					goto out;
 				}
+				/* The first one is the preferred one. */
+				if (!route_frame && !down &&
+				    !rose_ftimer_running(node->neighbour[i]))
+					down = node->neighbour[i];
 			}
 		}
 	}
@@ -766,19 +841,15 @@ int rose_rt_ioctl(unsigned int cmd, void __user *arg)
 	return 0;
 }
 
-static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
+/*
+ *	Blow away the through routes using this neighbour: the half on the
+ *	neighbour is dropped and the other half is told with a Clear Request.
+ *	The caller holds rose_route_list_lock.
+ */
+static void rose_clear_routes_by_neigh(struct rose_neigh *rose_neigh)
 {
 	struct rose_route *rose_route, *s;
 
-	rose_neigh->restarted = 0;
-
-	rose_stop_t0timer(rose_neigh);
-	rose_start_ftimer(rose_neigh);
-
-	skb_queue_purge(&rose_neigh->queue);
-
-	spin_lock_bh(&rose_route_list_lock);
-
 	rose_route = rose_route_list;
 
 	while (rose_route != NULL) {
@@ -805,9 +876,37 @@ static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
 
 		rose_route = rose_route->next;
 	}
+}
+
+static void rose_del_route_by_neigh(struct rose_neigh *rose_neigh)
+{
+	rose_neigh->restarted = 0;
+
+	rose_stop_t0timer(rose_neigh);
+	rose_start_ftimer(rose_neigh);
+
+	skb_queue_purge(&rose_neigh->queue);
+
+	spin_lock_bh(&rose_route_list_lock);
+	rose_clear_routes_by_neigh(rose_neigh);
 	spin_unlock_bh(&rose_route_list_lock);
 }
 
+/*
+ *	The neighbour has restarted a link that was up: it has lost every
+ *	virtual circuit that ran over it. Blow away the through routes and
+ *	the connections using this neighbour, the link itself stays up.
+ *	Called from rose_route_frame() with rose_neigh_list_lock and
+ *	rose_route_list_lock held.
+ */
+void rose_link_restarted(struct rose_neigh *rose_neigh)
+{
+	lockdep_assert_held(&rose_route_list_lock);
+
+	rose_clear_routes_by_neigh(rose_neigh);
+	rose_kill_by_neigh(rose_neigh);
+}
+
 /*
  * 	A level 2 link has timed out, therefore it appears to be a poor link,
  *	then don't use that neighbour until it is reset. Blow away all through
@@ -851,6 +950,21 @@ void rose_link_device_down(struct net_device *dev)
 	}
 }
 
+/*
+ *	Is this Call Request the very same call as the one an existing route
+ *	was built for?  Both the loop detection and the reuse of a stale LCI
+ *	below rely on this test.
+ */
+static bool rose_same_call(const struct rose_route *rose_route,
+			   const rose_address *src_addr,
+			   const struct rose_facilities_struct *facilities)
+{
+	return rose_route->rand == facilities->rand &&
+	       rosecmp(src_addr, &rose_route->src_addr) == 0 &&
+	       ax25cmp(&facilities->dest_call, &rose_route->src_call) == 0 &&
+	       ax25cmp(&facilities->source_call, &rose_route->dest_call) == 0;
+}
+
 /*
  *	Route a frame to an appropriate AX.25 connection.
  *	A NULL ax25_cb indicates an internally generated frame.
@@ -941,7 +1055,7 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		}
 		else {
 			skb_reset_transport_header(skb);
-			res = rose_process_rx_frame(sk, skb);
+			res = rose_rcv_frame(sk, skb);
 			goto out;
 		}
 	}
@@ -961,6 +1075,16 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		goto out;
 	}
 
+	memset(&facilities, 0x00, sizeof(struct rose_facilities_struct));
+
+	if (frametype == ROSE_CALL_REQUEST &&
+	    !rose_parse_facilities(skb->data + ROSE_CALL_REQ_FACILITIES_OFF,
+				   skb->len - ROSE_CALL_REQ_FACILITIES_OFF,
+				   &facilities)) {
+		rose_transmit_clear_request(rose_neigh, lci, ROSE_INVALID_FACILITY, 76);
+		goto out;
+	}
+
 	/*
 	 *	Route it to the next in line if we have an entry for it.
 	 */
@@ -969,7 +1093,21 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		if (rose_route->lci1 == lci &&
 		    rose_route->neigh1 == rose_neigh) {
 			if (frametype == ROSE_CALL_REQUEST) {
-				/* F6FBB - Remove an existing unused route */
+				if (rose_same_call(rose_route, src_addr,
+						   &facilities)) {
+					/*
+					 *	The very same call coming back
+					 *	to us: a routing loop.  Keep
+					 *	the route, the loop detection
+					 *	below is what matches on it.
+					 */
+					rose_transmit_clear_request(rose_neigh,
+								    lci,
+								    ROSE_NOT_OBTAINABLE,
+								    120);
+					goto out;
+				}
+				/* Remove an existing unused route */
 				rose_remove_route(rose_route);
 				break;
 			} else if (rose_route->neigh2 != NULL) {
@@ -990,7 +1128,21 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		if (rose_route->lci2 == lci &&
 		    rose_route->neigh2 == rose_neigh) {
 			if (frametype == ROSE_CALL_REQUEST) {
-				/* F6FBB - Remove an existing unused route */
+				if (rose_same_call(rose_route, src_addr,
+						   &facilities)) {
+					/*
+					 *	The very same call coming back
+					 *	to us: a routing loop.  Keep
+					 *	the route, the loop detection
+					 *	below is what matches on it.
+					 */
+					rose_transmit_clear_request(rose_neigh,
+								    lci,
+								    ROSE_NOT_OBTAINABLE,
+								    120);
+					goto out;
+				}
+				/* Remove an existing unused route */
 				rose_remove_route(rose_route);
 				break;
 			} else if (rose_route->neigh1 != NULL) {
@@ -1021,24 +1173,12 @@ int rose_route_frame(struct sk_buff *skb, ax25_cb *ax25)
 		goto out;
 	}
 
-	memset(&facilities, 0x00, sizeof(struct rose_facilities_struct));
-
-	if (!rose_parse_facilities(skb->data + ROSE_CALL_REQ_FACILITIES_OFF,
-				   skb->len - ROSE_CALL_REQ_FACILITIES_OFF,
-				   &facilities)) {
-		rose_transmit_clear_request(rose_neigh, lci, ROSE_INVALID_FACILITY, 76);
-		goto out;
-	}
-
 	/*
 	 *	Check for routing loops.
 	 */
 	rose_route = rose_route_list;
 	while (rose_route != NULL) {
-		if (rose_route->rand == facilities.rand &&
-		    rosecmp(src_addr, &rose_route->src_addr) == 0 &&
-		    ax25cmp(&facilities.dest_call, &rose_route->src_call) == 0 &&
-		    ax25cmp(&facilities.source_call, &rose_route->dest_call) == 0) {
+		if (rose_same_call(rose_route, src_addr, &facilities)) {
 			rose_transmit_clear_request(rose_neigh, lci, ROSE_NOT_OBTAINABLE, 120);
 			goto out;
 		}
diff --git a/net/rose/rose_timer.c b/net/rose/rose_timer.c
index 53d198ac96e8..5ba0c89e4ee1 100644
--- a/net/rose/rose_timer.c
+++ b/net/rose/rose_timer.c
@@ -126,12 +126,73 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 		sk_reset_timer(sk, &sk->sk_timer, jiffies + HZ/20);
 		goto out;
 	}
+
+	/* The bound device went down while we still hold a reference on it.
+	 * This catches the narrow race where rose_loopback_timer() created a
+	 * socket in the window after rose_kill_by_device()'s NETDEV_DOWN sweep
+	 * but before rose_insert_socket() -- leaving a STATE_3 socket that no
+	 * other branch reaps.  A down device means the link is dead, so tear
+	 * the socket down regardless of state.  rose_destroy_socket() releases
+	 * the held netdev reference (rose->device still set).
+	 */
+	if (rose->device && !netif_running(rose->device)) {
+		if (rose->neighbour) {
+			rose_neigh_put(rose->neighbour);
+			rose->neighbour = NULL;
+		}
+		rose_disconnect(sk, ENETDOWN, -1, -1);
+
+		/* Only reap the socket if userspace no longer holds it.  A socket
+		 * still attached to a struct socket (sk->sk_socket != NULL -- e.g.
+		 * a connection an fpad client has accepted and kept open) is owned
+		 * by that fd: rose_release() will destroy it on close().  Dropping
+		 * the last reference here leaves the open fd dangling, so the
+		 * eventual close() touches freed memory -> slab-use-after-free in
+		 * rose_release().  Unaccepted incoming sockets and post-close
+		 * orphans have sk->sk_socket == NULL and stay safe to reap here.
+		 */
+		if (!sk->sk_socket) {
+			sock_set_flag(sk, SOCK_DESTROY);
+			bh_unlock_sock(sk);
+			rose_destroy_socket(sk);
+			sock_put(sk);
+			return;
+		}
+
+		/* Owned by userspace: the link is down and the socket is now
+		 * disconnected (rose_disconnect() moved it to STATE_0).  Fall
+		 * through to the switch, which re-arms the heartbeat; the close()
+		 * will tear the socket down. */
+	}
+
 	switch (rose->state) {
 	case ROSE_STATE_0:
-		/* Magic here: If we listen() and a new link dies before it
-		   is accepted() it isn't 'dead' so doesn't get removed. */
-		if (sock_flag(sk, SOCK_DESTROY) ||
-		    (sk->sk_state == TCP_LISTEN && sock_flag(sk, SOCK_DEAD))) {
+		/* Destroy any orphaned STATE_0 socket: either explicitly
+		 * flagged SOCK_DESTROY, or SOCK_DEAD (covers both unaccepted
+		 * incoming connections and listening sockets whose link died).
+		 */
+		if ((sock_flag(sk, SOCK_DESTROY) || sock_flag(sk, SOCK_DEAD)) &&
+		    !sk->sk_socket) {
+			/* Reap only orphaned sockets (sk->sk_socket == NULL).  A
+			 * socket still owned by a userspace fd reaches here via the
+			 * STATE_2 device-gone branch, which sets SOCK_DESTROY without
+			 * knowing about the fd; freeing it would race rose_release()
+			 * at close() -> use-after-free.  Leave it for close().
+			 *
+			 * Orphaned incoming sockets (rose_rx_call_request) hold a
+			 * neighbour reference; release it before teardown, as the
+			 * STATE_2 and device-down branches do.  rose_destroy_socket()
+			 * does not drop it.
+			 */
+			if (rose->neighbour) {
+				rose_neigh_put(rose->neighbour);
+				rose->neighbour = NULL;
+			}
+			/* Tell rose_accept() and the listener's teardown, which
+			 * may still hold this socket on their queue, that it is
+			 * gone.
+			 */
+			sock_set_flag(sk, SOCK_DESTROY);
 			bh_unlock_sock(sk);
 			rose_destroy_socket(sk);
 			sock_put(sk);
@@ -139,6 +200,20 @@ static void rose_heartbeat_expiry(struct timer_list *t)
 		}
 		break;
 
+	case ROSE_STATE_2:
+		/* Device gone before CLEAR CONFIRM arrived: stop waiting for T3
+		 * and disconnect now instead of blocking rmmod for up to 180s. */
+		if (!rose->device) {
+			rose_stop_timer(sk);
+			if (rose->neighbour) {
+				rose_neigh_put(rose->neighbour);
+				rose->neighbour = NULL;
+			}
+			rose_disconnect(sk, ENETDOWN, -1, -1);
+			sock_set_flag(sk, SOCK_DESTROY);
+		}
+		break;
+
 	case ROSE_STATE_3:
 		/*
 		 * Check for the state of the receive buffer.
diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index 94feb3961dcd..29a6bf863083 100644
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
index a60aae42398a..62390153abcc 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1263,7 +1263,7 @@ static struct sk_buff *cake_ack_filter(struct cake_sched_data *q,
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
index 56115ad6a59a..4c089e041cae 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -1786,6 +1786,18 @@ static int sctp_sendmsg_check_sflags(struct sctp_association *asoc,
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
@@ -1800,16 +1812,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
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
@@ -1830,10 +1835,9 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
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
@@ -1848,6 +1852,11 @@ static int sctp_sendmsg_to_asoc(struct sctp_association *asoc,
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
diff --git a/net/socket.c b/net/socket.c
index 723bc3a1ba5c..b8d662e19310 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -77,6 +77,7 @@
 #include <linux/mount.h>
 #include <linux/pseudo_fs.h>
 #include <linux/security.h>
+#include <linux/uio.h>
 #include <linux/syscalls.h>
 #include <linux/compat.h>
 #include <linux/kmod.h>
@@ -2345,11 +2346,45 @@ SYSCALL_DEFINE5(setsockopt, int, fd, int, level, int, optname,
 INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
 							 int optname));
 
+/*
+ * Initialize a sockopt_t from sockptr optval/optlen, setting up iov_iter
+ * for both input and output directions.
+ * It is important to remember that both iov points to the same data, but,
+ * .iter_in is read-only and .iter_out is write-only by the protocol callbacks
+ */
+static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
+			      sockptr_t optlen, struct kvec *kvec)
+{
+	int koptlen;
+
+	if (copy_from_sockptr(&koptlen, optlen, sizeof(int)))
+		return -EFAULT;
+
+	if (koptlen < 0)
+		return -EINVAL;
+
+	if (optval.is_kernel) {
+		kvec->iov_base = optval.kernel;
+		kvec->iov_len = koptlen;
+		iov_iter_kvec(&opt->iter_out, ITER_DEST, kvec, 1, koptlen);
+		iov_iter_kvec(&opt->iter_in, ITER_SOURCE, kvec, 1, koptlen);
+	} else {
+		iov_iter_ubuf(&opt->iter_out, ITER_DEST, optval.user, koptlen);
+		iov_iter_ubuf(&opt->iter_in, ITER_SOURCE, optval.user,
+			      koptlen);
+	}
+	opt->optlen = koptlen;
+
+	return 0;
+}
+
 int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 		       int optname, sockptr_t optval, sockptr_t optlen)
 {
 	int max_optlen __maybe_unused = 0;
 	const struct proto_ops *ops;
+	struct kvec kvec;
+	sockopt_t opt;
 	int err;
 
 	err = security_socket_getsockopt(sock, level, optname);
@@ -2362,15 +2397,28 @@ int do_sock_getsockopt(struct socket *sock, bool compat, int level,
 	ops = READ_ONCE(sock->ops);
 	if (level == SOL_SOCKET) {
 		err = sk_getsockopt(sock->sk, level, optname, optval, optlen);
-	} else if (unlikely(!ops->getsockopt)) {
-		err = -EOPNOTSUPP;
-	} else {
+	} else if (ops->getsockopt_iter) {
+		err = sockptr_to_sockopt(&opt, optval, optlen, &kvec);
+		if (err)
+			return err;
+
+		err = ops->getsockopt_iter(sock, level, optname, &opt);
+
+		/* Always write back optlen, even on failure. Some protocols
+		 * (e.g. CAN raw) return -ERANGE and set optlen to the
+		 * required buffer size so userspace can discover it.
+		 */
+		if (copy_to_sockptr(optlen, &opt.optlen, sizeof(int)))
+			return -EFAULT;
+	} else if (ops->getsockopt) {
 		if (WARN_ONCE(optval.is_kernel || optlen.is_kernel,
 			      "Invalid argument type"))
 			return -EOPNOTSUPP;
 
 		err = ops->getsockopt(sock, level, optname, optval.user,
 				      optlen.user);
+	} else {
+		err = -EOPNOTSUPP;
 	}
 
 	if (!compat)
diff --git a/net/tipc/node.c b/net/tipc/node.c
index 19562970e5b2..8807fd60e800 100644
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
index 1fa4dd2ca405..999cccb323f7 100644
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
@@ -1633,23 +1665,22 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
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
index 8552173aafe1..cf7f3dcc075c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1313,6 +1313,12 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
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
 
@@ -1831,7 +1837,8 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 * lock_sock (note: listener sockets are not assigned to any transport)
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
-	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
+	    (sk->sk_state != TCP_LISTEN &&
+	     !vsock_check_source(vsk, &t->transport, &src))) {
 		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
diff --git a/samples/pidfd/Makefile b/samples/pidfd/Makefile
index 9754e2d81f70..d82409f7061f 100644
--- a/samples/pidfd/Makefile
+++ b/samples/pidfd/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-usertprogs-always-y += pidfd-metadata
+userprogs-always-y += pidfd-metadata
 
 userccflags += -I usr/include
diff --git a/security/keys/key.c b/security/keys/key.c
index 4fc404432a35..d3114fdd4d5f 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -587,11 +587,18 @@ int key_reject_and_link(struct key *key,
 	ret = -EBUSY;
 
 	if (keyring) {
-		if (keyring->restrict_link)
-			return -EPERM;
-
 		link_ret = __key_link_lock(keyring, &key->index_key);
 		if (link_ret == 0) {
+			/*
+			 * Check the restriction under the keyring semaphore.
+			 * keyring_restrict() installs it while holding the
+			 * semaphore, so testing it beforehand races with a
+			 * concurrent restriction install.
+			 */
+			if (keyring->restrict_link) {
+				__key_link_end(keyring, &key->index_key, edit);
+				return -EPERM;
+			}
 			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
 			if (link_ret < 0)
 				__key_link_end(keyring, &key->index_key, edit);
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 11bedca4e1c6..0fc520de9995 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -677,12 +677,14 @@ long keyctl_describe_key(key_serial_t keyid,
 
 	/* calculate how much information we're going to return */
 	ret = -ENOMEM;
+	down_read(&key->sem);
 	infobuf = kasprintf(GFP_KERNEL,
 			    "%s;%d;%d;%08x;",
 			    key->type->name,
 			    from_kuid_munged(current_user_ns(), key->uid),
 			    from_kgid_munged(current_user_ns(), key->gid),
 			    key->perm);
+	up_read(&key->sem);
 	if (!infobuf)
 		goto error2;
 	infolen = strlen(infobuf);
@@ -806,8 +808,12 @@ static long __keyctl_read_key(struct key *key, char *buffer, size_t buflen)
 
 	down_read(&key->sem);
 	ret = key_validate(key);
-	if (ret == 0)
-		ret = key->type->read(key, buffer, buflen);
+	if (ret == 0) {
+		if (key->type->read)
+			ret = key->type->read(key, buffer, buflen);
+		else
+			ret = -EOPNOTSUPP;
+	}
 	up_read(&key->sem);
 	return ret;
 }
@@ -861,11 +867,6 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
-	if (!key->type->read) {
-		ret = -EOPNOTSUPP;
-		goto key_put_out;
-	}
-
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
 		ret = __keyctl_read_key(key, NULL, 0);
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index fd95a0eb7a46..74ed1372d22c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -14,6 +14,9 @@
 #include <linux/err.h>
 #include <linux/user_namespace.h>
 #include <linux/nsproxy.h>
+#include <linux/once.h>
+#include <linux/random.h>
+#include <linux/siphash.h>
 #include <keys/keyring-type.h>
 #include <keys/user-type.h>
 #include <linux/assoc_array_priv.h>
@@ -147,49 +150,46 @@ static int keyring_instantiate(struct key *keyring,
 }
 
 /*
- * Multiply 64-bits by 32-bits to 96-bits and fold back to 64-bit.  Ideally we'd
- * fold the carry back too, but that requires inline asm.
+ * Give key types and domains address-independent identities.  Zero means that
+ * an ID has not yet been allocated.  As with inode sequence numbers used by
+ * futexes, this relies on the 64-bit counter not wrapping in a machine's
+ * lifetime.
  */
-static u64 mult_64x32_and_fold(u64 x, u32 y)
+static u64 key_index_id(atomic64_t *id)
 {
-	u64 hi = (u64)(u32)(x >> 32) * y;
-	u64 lo = (u64)(u32)(x) * y;
-	return lo + ((u64)(u32)hi << 32) + (u32)(hi >> 32);
+	static atomic64_t next_id;
+	u64 old, new;
+
+	old = atomic64_read(id);
+	if (likely(old))
+		return old;
+
+	do {
+		new = atomic64_inc_return(&next_id);
+	} while (WARN_ON_ONCE(!new));
+
+	old = 0;
+	if (!atomic64_try_cmpxchg_relaxed(id, &old, new))
+		return old;
+	return new;
 }
 
 /*
- * Hash a key type and description.
+ * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
+ * traversal order, so no part of the index may contain kernel addresses.
  */
 static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 {
 	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
 	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
-	const char *description = index_key->description;
-	unsigned long hash, type;
-	u32 piece;
+	static siphash_key_t hash_key __read_mostly;
+	unsigned long hash;
 	u64 acc;
-	int n, desc_len = index_key->desc_len;
-
-	type = (unsigned long)index_key->type;
-	acc = mult_64x32_and_fold(type, desc_len + 13);
-	acc = mult_64x32_and_fold(acc, 9207);
-	piece = (unsigned long)index_key->domain_tag;
-	acc = mult_64x32_and_fold(acc, piece);
-	acc = mult_64x32_and_fold(acc, 9207);
-
-	for (;;) {
-		n = desc_len;
-		if (n <= 0)
-			break;
-		if (n > 4)
-			n = 4;
-		piece = 0;
-		memcpy(&piece, description, n);
-		description += n;
-		desc_len -= n;
-		acc = mult_64x32_and_fold(acc, piece);
-		acc = mult_64x32_and_fold(acc, 9207);
-	}
+
+	get_random_once(&hash_key, sizeof(hash_key));
+	acc = siphash(index_key->description, index_key->desc_len, &hash_key);
+	acc = siphash_3u64(index_key->type_id, index_key->domain_id, acc,
+			   &hash_key);
 
 	/* Fold the hash down to 32 bits if need be. */
 	hash = acc;
@@ -209,7 +209,7 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
 
 /*
  * Finalise an index key to include a part of the description actually in the
- * index key, to set the domain tag and to calculate the hash.
+ * index key, to set the domain tag and index IDs, and to calculate the hash.
  */
 void key_set_index_key(struct keyring_index_key *index_key)
 {
@@ -225,6 +225,14 @@ void key_set_index_key(struct keyring_index_key *index_key)
 			index_key->domain_tag = &default_domain_tag;
 	}
 
+	/* Preserve the IDs when copying an existing key's index.  In
+	 * particular, its type may already have been unregistered.
+	 */
+	if (!index_key->type_id)
+		index_key->type_id = key_index_id(&index_key->type->index_id);
+	if (!index_key->domain_id)
+		index_key->domain_id = key_index_id(&index_key->domain_tag->index_id);
+
 	hash_key_type_and_desc(index_key);
 }
 
@@ -263,15 +271,19 @@ void key_remove_domain(struct key_tag *domain_tag)
 /*
  * Build the next index key chunk.
  *
+ * The hash and inline description are followed by the 64-bit type and domain
+ * IDs, low word first, and then by the rest of the description.
  * We return it one word-sized chunk at a time.
  */
 static unsigned long keyring_get_key_chunk(const void *data, int level)
 {
+	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
 	const struct keyring_index_key *index_key = data;
+	int desc_len = index_key->desc_len;
 	unsigned long chunk = 0;
-	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int n = sizeof(chunk);
 	unsigned int offset;
+	const u8 *d;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -279,27 +291,30 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return index_key->hash;
 	case 1:
 		return index_key->x;
-	case 2:
-		return (unsigned long)index_key->type;
-	case 3:
-		return (unsigned long)index_key->domain_tag;
-	default:
-		level -= 4;
-		offset = sizeof(index_key->desc) + level * sizeof(long);
-		if (desc_len <= offset)
-			return 0;
-
-		d = index_key->description + offset;
-		desc_len -= offset;
-		if (desc_len > n)
-			desc_len = n;
-		d += desc_len;
-		do {
-			chunk <<= 8;
-			chunk |= *--d;
-		} while (--desc_len > 0);
-		return chunk;
 	}
+
+	level -= 2;
+	if (level < id_chunks)
+		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+	if (level < id_chunks)
+		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
+	level -= id_chunks;
+
+	offset = sizeof(index_key->desc) + level * sizeof(long);
+	if (desc_len <= offset)
+		return 0;
+
+	d = index_key->description + offset;
+	desc_len -= offset;
+	if (desc_len > n)
+		desc_len = n;
+	d += desc_len;
+	do {
+		chunk <<= 8;
+		chunk |= *--d;
+	} while (--desc_len > 0);
+	return chunk;
 }
 
 static unsigned long keyring_get_object_key_chunk(const void *object, int level)
@@ -331,6 +346,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	const struct keyring_index_key *b = data;
 	unsigned long seg_a, seg_b;
 	int level, i;
+	u64 diff;
 
 	level = 0;
 	seg_a = a->hash;
@@ -339,28 +355,22 @@ static int keyring_diff_objects(const void *object, const void *data)
 		goto differ;
 	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
 
-	/* The number of bits contributed by the hash is controlled by a
-	 * constant in the assoc_array headers.  Everything else thereafter we
-	 * can deal with as being machine word-size dependent.
-	 */
+	/* The inline description contributes one machine-word-sized chunk. */
 	seg_a = a->x;
 	seg_b = b->x;
 	if ((seg_a ^ seg_b) != 0)
 		goto differ;
 	level += sizeof(unsigned long);
 
-	/* The next bit may not work on big endian */
-	seg_a = (unsigned long)a->type;
-	seg_b = (unsigned long)b->type;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->type_id ^ b->type_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
-	seg_a = (unsigned long)a->domain_tag;
-	seg_b = (unsigned long)b->domain_tag;
-	if ((seg_a ^ seg_b) != 0)
-		goto differ;
-	level += sizeof(unsigned long);
+	diff = a->domain_id ^ b->domain_id;
+	if (diff)
+		return level * 8 + __ffs64(diff);
+	level += sizeof(u64);
 
 	i = sizeof(a->desc);
 	if (a->desc_len <= i)
@@ -1158,7 +1168,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
 	 * grants Search permission and that hasn't been revoked
 	 */
 	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
-		if (!kuid_has_mapping(ns, keyring->user->uid))
+		if (!kuid_has_mapping(ns, keyring->uid))
 			continue;
 
 		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..4b2b8a75eb1f 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -556,9 +556,8 @@ key_ref_t search_process_keyrings_rcu(struct keyring_search_context *ctx)
 	    ) {
 		const struct cred *cred = ctx->cred;
 
-		if (key_validate(cred->request_key_auth) == 0) {
-			rka = ctx->cred->request_key_auth->payload.data[0];
-
+		rka = dereference_key_rcu(cred->request_key_auth);
+		if (rka && key_validate(cred->request_key_auth) == 0) {
 			//// was search_process_keyrings() [ie. recursive]
 			ctx->cred = rka->cred;
 			key_ref = search_cred_keyrings_rcu(ctx);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index b5781c507139..736cec9b768f 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -970,8 +970,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = tpm2_unseal_trusted(chip, p, options);
 	else
 		ret = key_unseal(p, options);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("key_unseal failed (%d)\n", ret);
+		goto out;
+	}
 
 	if (options->pcrlock) {
 		ret = pcrlock(options->pcrlock);
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index aae81332e33d..e841014a44d2 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -124,7 +124,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 7128d4c62f50..dda012be02b9 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -273,7 +273,7 @@ static const char * const cs42l52_ng_type_text[] = {
 };
 
 static SOC_ENUM_SINGLE_DECL(ng_type_enum,
-			    CS42L52_NOISE_GATE_CTL, 6,
+			    CS42L52_NOISE_GATE_CTL, 7,
 			    cs42l52_ng_type_text);
 
 static const char * const left_swap_text[] = {
diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index aaa10c459b52..0058ce2d55e8 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -449,7 +449,7 @@ static const struct snd_kcontrol_new cs42l56_snd_controls[] = {
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
index fd4a96a12060..dcf317ec9751 100644
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
index ad1564e7d8fa..ce68b239b9ef 100644
--- a/sound/soc/codecs/pcm3168a.c
+++ b/sound/soc/codecs/pcm3168a.c
@@ -103,7 +103,7 @@ static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_func, PCM3168A_DAC_ATT_DEMP_ZF,
 static const char *const pcm3168a_pol[] = { "Active High", "Active Low" };
 
 static SOC_ENUM_SINGLE_DECL(pcm3168a_dac_zf_pol, PCM3168A_DAC_ATT_DEMP_ZF,
-		PCM3168A_DAC_ATSPDA_SHIFT, pcm3168a_pol);
+		PCM3168A_DAC_ZREV_SHIFT, pcm3168a_pol);
 
 static const char *const pcm3168a_con[] = { "Differential", "Single-Ended" };
 
diff --git a/sound/soc/codecs/wm8978.c b/sound/soc/codecs/wm8978.c
index 40d22b36b7a9..a80538722dfd 100644
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
index 81fe4f0218c1..78b330e22570 100644
--- a/sound/soc/intel/avs/pcm.c
+++ b/sound/soc/intel/avs/pcm.c
@@ -660,7 +660,7 @@ static int avs_dai_fe_prepare(struct snd_pcm_substream *substream, struct snd_so
 	data = snd_soc_dai_get_dma_data(dai, substream);
 	host_stream = data->host_stream;
 
-	if (runtime->state == SNDRV_PCM_STATE_XRUN)
+	if (runtime->state != SNDRV_PCM_STATE_PREPARED)
 		hdac_stream(host_stream)->prepared = false;
 	if (hdac_stream(host_stream)->prepared)
 		return 0;
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 6af0cc154f3d..5cf272fe93ff 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1973,8 +1973,20 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
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
index 9e30852de93c..6cc6ff5f6c28 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -728,7 +728,7 @@ static irqreturn_t stm32_spdifrx_isr(int irq, void *devid)
 
 	if (err) {
 		regmap_read(spdifrx->regmap, STM32_SPDIFRX_CR, &cr);
-		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) &&
+		sync_state = FIELD_GET(SPDIFRX_CR_SPDIFEN_MASK, cr) ==
 			     SPDIFRX_SPDIFEN_SYNC;
 
 		/* SPDIFRX is in STATE_STOP. Disable SPDIFRX to clear errors */
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
index fb1c65f6ff9d..4947c38fc4f3 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -5194,7 +5194,7 @@ void free_fd_msr(void)
 	if (!msr_counter_info)
 		return;
 
-	for (int cpu = 0; cpu < topo.max_cpu_num; ++cpu) {
+	for (int cpu = 0; cpu <= topo.max_cpu_num; ++cpu) {
 		if (msr_counter_info[cpu].fd_perf != -1)
 			close(msr_counter_info[cpu].fd_perf);
 	}
@@ -9330,10 +9330,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
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
@@ -9342,10 +9343,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
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
@@ -9354,10 +9356,11 @@ int add_counter(unsigned int msr_num, char *path, char *name,
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
diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
new file mode 100644
index 000000000000..cc6df762845f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - reject incomplete logical expressions
+# requires: events/sched/sched_switch/filter
+# flags: instance
+
+filter=events/sched/sched_switch/filter
+
+for base in \
+    'common_pid == 1' \
+    'common_pid == 1 || common_pid == 2' \
+    'common_pid == 1 && common_pid == 2' \
+    '!(common_pid == 1 || common_pid == 2)'
+do
+    printf '%s' "$base" > "$filter"
+    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
+        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
+            echo "Accepted incomplete filter: $base $tail"
+            exit_fail
+        fi
+    done
+done
+
+echo 0 > "$filter"
