Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5F249E5EA;
	Wed,  2 Sep 2026 12:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788353060; cv=none; b=VL0Xi+7yHQSdVbEIVrSFBNa11oI7Dpl1/6SjraAUAHxKXwkyStRZZGsHiIbreXgSdgvHfAx5fZx8QQ44QzJkFz0T0DI7aFge4DxcTYP7uBHB7N5F7N77DWJyCPLAC6KdOWtHMc6FyaOlnKF45llbiZRbKIuFVz++m6+NQrA4mP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788353060; c=relaxed/simple;
	bh=atJ+NxINAcwfLBje7heDdM3UNr/yH+XfIEhk/0w3FZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYMMyw1lcYwz5z+gQMn07YCK4ANKnAO2SRSyWdKcGfHtcKHyCCmnSg0T3p3wxNf6SnCj8Ge+BfMLLdTXfsP3Fra8Xf5ALEmcSAK/xsZYLUtEMXcNg6JsxCaJT9f/YGgzBHCGFi0FwzO4h3K5m/odshOIFdnAoktO6M4phTpa1vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QOu05WBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QOu05WBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1515A1F000E9;
	Wed,  2 Sep 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788353052;
	bh=ef8aF/D+/FosBjxhyR2aFfJhQvxywxU7RxMOSBXlcJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QOu05WBA4wrkCxAIVYBb6RcVSPzYL3bqIH/4D3VeMaFKb1PnqXmkotkL0CVXlfn4y
	 UtJP2aD6ngpegspGobh8+Mrgc5tIJrbXOHuQkQowfpd8MA+ibBcsHDVw2rN/PopgM7
	 VXnF3tCTOJwYTEpIlkYpd/8q9eUGLYr8vSIWAbYk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.2.3
Date: Wed,  2 Sep 2026 14:43:57 +0200
Message-ID: <2026090257-bulge-frosted-6e3b@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090256-starlight-pope-8a2a@gregkh>
References: <2026090256-starlight-pope-8a2a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index c0dd35f1af12..e4882b73120e 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1238,6 +1238,10 @@ astute users may notice some differences in behavior:
 
 - DAX (Direct Access) is not supported on encrypted files.
 
+- Encrypted files cannot be used directly as swap files.  To swap to
+  an encrypted file, set up a loopback device on top of it.
+  Alternatively, encrypted swap can use a dm-crypt device.
+
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
diff --git a/Makefile b/Makefile
index ee964fb0c056..150b1c1d7bed 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 2
-SUBLEVEL = 2
+SUBLEVEL = 3
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index eea24562e7db..0a7d8dfab6b7 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -173,6 +173,7 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
 			    sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
+	memset(apcb_s, 0, sizeof(*apcb_s));
 	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
 	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
 	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 0f0ea7896af5..8b9af7d4c7f6 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -1283,9 +1283,28 @@ static void *sev_dbg_crypt_slow_alloc(struct page *page, unsigned long __va,
 	if (WARN_ON_ONCE((*pa & PAGE_MASK) != ((*pa + *nr_bytes - 1) & PAGE_MASK)))
 		return NULL;
 
+	/*
+	 * If SNP is enabled, i.e. the RMP is active, allocate a full page to
+	 * prevent concurrent accesses to the page.  As required by firmware,
+	 * the PSP driver updates the RMP to temporarily transfer ownership of
+	 * the page to Firmware while the {DE,EN}CRYPT operation is in-progress,
+	 * and so concurrent software accesses to the page will encounter
+	 * seemingly spurious RMP #PF violations
+	 */
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		return (void *)__get_free_page(GFP_KERNEL);
+
 	return kmalloc(*nr_bytes, GFP_KERNEL);
 }
 
+static void sev_dbg_crypt_slow_free(void *buf)
+{
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		free_page((unsigned long)buf);
+	else
+		kfree(buf);
+}
+
 static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 				struct page *src_p, unsigned long dst,
 				unsigned int len, int *err)
@@ -1307,7 +1326,7 @@ static int sev_dbg_decrypt_slow(struct kvm *kvm, unsigned long src,
 	if (copy_to_user((void __user *)dst, buf + (src & 15), len))
 		r = -EFAULT;
 out:
-	kfree(buf);
+	sev_dbg_crypt_slow_free(buf);
 	return r;
 }
 
@@ -1340,7 +1359,7 @@ static int sev_dbg_encrypt_slow(struct kvm *kvm, unsigned long src,
 		r = sev_issue_dbg_cmd(kvm, __sme_set(__pa(buf)), dst_pa,
 				      nr_bytes, KVM_SEV_DBG_ENCRYPT, err);
 out:
-	kfree(buf);
+	sev_dbg_crypt_slow_free(buf);
 	return r;
 }
 
@@ -2757,8 +2776,12 @@ int sev_mem_enc_register_region(struct kvm *kvm,
 	if (!region)
 		return -ENOMEM;
 
+	/*
+	 * Do NOT specify FOLL_WRITE, as KVM isn't using the pinned pages to
+	 * write memory, and FOLL_LONGTERM itself triggers CoW unshare.
+	 */
 	region->pages = sev_pin_memory(kvm, range->addr, range->size, &region->npages,
-				       FOLL_WRITE | FOLL_LONGTERM);
+				       FOLL_LONGTERM);
 	if (IS_ERR(region->pages)) {
 		ret = PTR_ERR(region->pages);
 		goto e_free;
@@ -3998,30 +4021,19 @@ static int snp_begin_psc(struct vcpu_svm *svm)
 	return snp_do_psc(svm);
 }
 
-/*
- * Invoked as part of svm_vcpu_reset() processing of an init event.
- */
-static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+static void sev_snp_reload_vmsa(struct kvm_vcpu *vcpu, gpa_t gpa)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
 	struct kvm_memory_slot *slot;
+	gfn_t gfn = gpa_to_gfn(gpa);
 	struct page *page;
 	kvm_pfn_t pfn;
-	gfn_t gfn;
-
-	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
-
-	if (!svm->sev_es.snp_ap_waiting_for_reset)
-		return;
 
-	svm->sev_es.snp_ap_waiting_for_reset = false;
-
-	/* Mark the vCPU as offline and not runnable */
-	vcpu->arch.pv.pv_unhalted = false;
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
+	lockdep_assert_held(&svm->sev_es.snp_vmsa_mutex);
 
-	/* Clear use of the VMSA */
+	/* Clear use of the VMSA. */
 	svm->vmcb->control.vmsa_pa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	/*
 	 * When replacing the VMSA during SEV-SNP AP creation,
@@ -4029,12 +4041,9 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	 */
 	vmcb_mark_all_dirty(svm->vmcb);
 
-	if (!VALID_PAGE(svm->sev_es.snp_vmsa_gpa))
+	if (!VALID_PAGE(gpa))
 		return;
 
-	gfn = gpa_to_gfn(svm->sev_es.snp_vmsa_gpa);
-	svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
-
 	slot = gfn_to_memslot(vcpu->kvm, gfn);
 	if (!slot)
 		return;
@@ -4058,11 +4067,9 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	svm->sev_es.snp_has_guest_vmsa = true;
 
 	/* Use the new VMSA */
+	svm->sev_es.snp_guest_vmsa_gpa = gpa;
 	svm->vmcb->control.vmsa_pa = pfn_to_hpa(pfn);
 
-	/* Mark the vCPU as runnable */
-	kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
-
 	/*
 	 * gmem pages aren't currently migratable, but if this ever changes
 	 * then care should be taken to ensure svm->sev_es.vmsa is pinned
@@ -4071,6 +4078,40 @@ static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
 	kvm_release_page_clean(page);
 }
 
+/*
+ * Invoked as part of svm_vcpu_reset() processing of an init event.
+ */
+static void sev_snp_init_protected_guest_state(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+	gpa_t gpa;
+
+	guard(mutex)(&svm->sev_es.snp_vmsa_mutex);
+
+	if (!svm->sev_es.snp_ap_waiting_for_reset)
+		return;
+
+	svm->sev_es.snp_ap_waiting_for_reset = false;
+
+	/* Mark the vCPU as offline and not runnable */
+	vcpu->arch.pv.pv_unhalted = false;
+	kvm_set_mp_state(vcpu, KVM_MP_STATE_HALTED);
+
+	gpa = svm->sev_es.snp_pending_vmsa_gpa;
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+
+	sev_snp_reload_vmsa(vcpu, gpa);
+
+	/*
+	 * Mark the vCPU as runnable for CREATE requests, indicated by a valid
+	 * VMSA GPA, even if installing the VMSA failed, so that KVM_RUN will
+	 * fail instead of blocking indefinitely and hanging the vCPU, e.g. if
+	 * the backing guest_memfd page is unavailable.
+	 */
+	if (VALID_PAGE(gpa))
+		kvm_set_mp_state(vcpu, KVM_MP_STATE_RUNNABLE);
+}
+
 static int sev_snp_ap_creation(struct vcpu_svm *svm)
 {
 	struct kvm_sev_info *sev = to_kvm_sev_info(svm->vcpu.kvm);
@@ -4124,10 +4165,10 @@ static int sev_snp_ap_creation(struct vcpu_svm *svm)
 			return -EINVAL;
 		}
 
-		target_svm->sev_es.snp_vmsa_gpa = svm->vmcb->control.exit_info_2;
+		target_svm->sev_es.snp_pending_vmsa_gpa = svm->vmcb->control.exit_info_2;
 		break;
 	case SVM_VMGEXIT_AP_DESTROY:
-		target_svm->sev_es.snp_vmsa_gpa = INVALID_PAGE;
+		target_svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
 		break;
 	default:
 		vcpu_unimpl(vcpu, "vmgexit: invalid AP creation request [%#x] from guest\n",
@@ -4810,6 +4851,8 @@ int sev_vcpu_create(struct kvm_vcpu *vcpu)
 		return -ENOMEM;
 
 	svm->sev_es.vmsa = page_address(vmsa_page);
+	svm->sev_es.snp_pending_vmsa_gpa = INVALID_PAGE;
+	svm->sev_es.snp_guest_vmsa_gpa = INVALID_PAGE;
 
 	vcpu->arch.guest_tsc_protected = snp_is_secure_tsc_enabled(vcpu->kvm);
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 60495447f0ca..1158f3e28200 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -5466,6 +5466,10 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 
 	.vm_copy_enc_context_from = sev_vm_copy_enc_context_from,
 	.vm_move_enc_context_from = sev_vm_move_enc_context_from,
+
+	.gmem_prepare = sev_gmem_prepare,
+	.gmem_invalidate = sev_gmem_invalidate,
+	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 #endif
 	.check_emulate_instruction = svm_check_emulate_instruction,
 
@@ -5477,10 +5481,6 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
 	.vcpu_get_apicv_inhibit_reasons = avic_vcpu_get_apicv_inhibit_reasons,
 	.alloc_apic_backing_page = svm_alloc_apic_backing_page,
-
-	.gmem_prepare = sev_gmem_prepare,
-	.gmem_invalidate = sev_gmem_invalidate,
-	.gmem_max_mapping_level = sev_gmem_max_mapping_level,
 };
 
 /*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index d63e5878988a..344312bd1fd4 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -272,7 +272,8 @@ struct vcpu_sev_es_state {
 	u64 ghcb_registered_gpa;
 
 	struct mutex snp_vmsa_mutex; /* Used to handle concurrent updates of VMSA. */
-	gpa_t snp_vmsa_gpa;
+	gpa_t snp_pending_vmsa_gpa;
+	gpa_t snp_guest_vmsa_gpa;
 	bool snp_ap_waiting_for_reset;
 	bool snp_has_guest_vmsa;
 };
@@ -1035,16 +1036,6 @@ static inline int sev_cpu_init(struct svm_cpu_data *sd) { return 0; }
 static inline int sev_dev_get_attr(u32 group, u64 attr, u64 *val) { return -ENXIO; }
 #define max_sev_asid 0
 static inline void sev_handle_rmp_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u64 error_code) {}
-static inline int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_order)
-{
-	return 0;
-}
-static inline void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end) {}
-static inline int sev_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn, bool is_private)
-{
-	return 0;
-}
-
 static inline struct vmcb_save_area *sev_decrypt_vmsa(struct kvm_vcpu *vcpu)
 {
 	return NULL;
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 03395b89cc61..b377f4f7558d 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -263,10 +263,10 @@ struct crypto_aead *crypto_krb5_prepare_encryption(const struct krb5_enctype *kr
 		goto err;
 	}
 
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ci;
 err:
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_encryption);
@@ -333,10 +333,10 @@ struct crypto_shash *crypto_krb5_prepare_checksum(const struct krb5_enctype *krb
 		goto err;
 	}
 
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ci;
 err:
-	kfree(keys.data);
+	kfree_sensitive(keys.data);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL(crypto_krb5_prepare_checksum);
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 78a77dd789a2..a632a65e9037 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -2444,6 +2444,7 @@ static int __init speakup_init(void)
 	mutex_lock(&spk_mutex);
 	synth_release();
 	mutex_unlock(&spk_mutex);
+	spk_ttyio_unregister_ldisc();
 	speakup_kobj_exit();
 
 error_kobjects:
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 216a00bad5d7..eb834d15d614 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -641,7 +641,6 @@ config CRYPTO_DEV_QCOM_RNG
 	tristate "Qualcomm Random Number Generator Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HW_RANDOM
-	select CRYPTO_RNG
 	help
 	  This driver provides support for the Random Number
 	  Generator hardware found on Qualcomm SoCs.
diff --git a/drivers/crypto/allwinner/Kconfig b/drivers/crypto/allwinner/Kconfig
index 06ea0e9fe6f2..d86ae005fbe2 100644
--- a/drivers/crypto/allwinner/Kconfig
+++ b/drivers/crypto/allwinner/Kconfig
@@ -70,14 +70,6 @@ config CRYPTO_DEV_SUN8I_CE_HASH
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
@@ -113,14 +105,6 @@ config CRYPTO_DEV_SUN8I_SS_DEBUG
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
index f3b58ed6aed0..c6402e87f8a0 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -12,7 +12,6 @@
 
 #include <crypto/engine.h>
 #include <crypto/internal/hash.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -49,7 +48,6 @@ static const struct ce_variant ce_h3_variant = {
 		{ "mod", 50000000, 0 },
 		},
 	.esr = ESR_H3,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -66,7 +64,6 @@ static const struct ce_variant ce_h5_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_H5,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -80,7 +77,6 @@ static const struct ce_variant ce_h6_variant = {
 	},
 	.cipher_t_dlen_in_bytes = true,
 	.hash_t_dlen_in_bits = true,
-	.prng_t_dlen_in_bytes = true,
 	.trng_t_dlen_in_bytes = true,
 	.ce_clks = {
 		{ "bus", 0, 200000000 },
@@ -88,7 +84,6 @@ static const struct ce_variant ce_h6_variant = {
 		{ "ram", 0, 400000000 },
 		},
 	.esr = ESR_H6,
-	.prng = CE_ALG_PRNG_V2,
 	.trng = CE_ALG_TRNG_V2,
 };
 
@@ -102,7 +97,6 @@ static const struct ce_variant ce_h616_variant = {
 	},
 	.cipher_t_dlen_in_bytes = true,
 	.hash_t_dlen_in_bits = true,
-	.prng_t_dlen_in_bytes = true,
 	.trng_t_dlen_in_bytes = true,
 	.needs_word_addresses = true,
 	.ce_clks = {
@@ -112,7 +106,6 @@ static const struct ce_variant ce_h616_variant = {
 		{ "trng", 0, 0 },
 		},
 	.esr = ESR_H6,
-	.prng = CE_ALG_PRNG_V2,
 	.trng = CE_ALG_TRNG_V2,
 };
 
@@ -129,7 +122,6 @@ static const struct ce_variant ce_a64_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_A64,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -148,7 +140,6 @@ static const struct ce_variant ce_d1_variant = {
 		{ "trng", 0, 0 },
 		},
 	.esr = ESR_D1,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ALG_TRNG,
 };
 
@@ -165,7 +156,6 @@ static const struct ce_variant ce_r40_variant = {
 		{ "mod", 300000000, 0 },
 		},
 	.esr = ESR_R40,
-	.prng = CE_ALG_PRNG,
 	.trng = CE_ID_NOTSUPP,
 };
 
@@ -614,25 +604,6 @@ static struct sun8i_ce_alg_template ce_algs[] = {
 	},
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
 
 static int sun8i_ce_debugfs_show(struct seq_file *seq, void *v)
@@ -693,14 +664,6 @@ static int sun8i_ce_debugfs_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "\tFallback due to SG numbers: %lu\n",
 				   ce_algs[i].stat_fb_maxsg);
 			break;
-#endif
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s reqs=%lu bytes=%lu\n",
-				   ce_algs[i].alg.rng.base.cra_driver_name,
-				   ce_algs[i].alg.rng.base.cra_name,
-				   ce_algs[i].stat_req, ce_algs[i].stat_bytes);
-			break;
 #endif
 		}
 	}
@@ -930,25 +893,6 @@ static int sun8i_ce_register_algs(struct sun8i_ce_dev *ce)
 				return err;
 			}
 			break;
-#endif
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG
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
 #endif
 		default:
 			ce_algs[i].ce = NULL;
@@ -977,13 +921,6 @@ static void sun8i_ce_unregister_algs(struct sun8i_ce_dev *ce)
 				 ce_algs[i].alg.hash.base.halg.base.cra_name);
 			crypto_engine_unregister_ahash(&ce_algs[i].alg.hash);
 			break;
-#endif
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_CE_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			dev_info(ce->dev, "Unregister %d %s\n", i,
-				 ce_algs[i].alg.rng.base.cra_name);
-			crypto_unregister_rng(&ce_algs[i].alg.rng);
-			break;
 #endif
 		}
 	}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
deleted file mode 100644
index d0a1ac66738b..000000000000
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-prng.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sun8i-ce-prng.c - hardware cryptographic offloader for
- * Allwinner H3/A64/H5/H2+/H6/R40 SoC
- *
- * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
- *
- * This file handle the PRNG
- *
- * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
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
-	kfree_sensitive(ctx->seed);
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
-		kfree_sensitive(ctx->seed);
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
-		err = -EFAULT;
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
-	err = pm_runtime_resume_and_get(ce->dev);
-	if (err < 0)
-		goto err_pm;
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
-	cet->t_key = desc_addr_val_le32(ce, dma_iv);
-	cet->t_iv = desc_addr_val_le32(ce, dma_iv);
-
-	cet->t_dst[0].addr = desc_addr_val_le32(ce, dma_dst);
-	cet->t_dst[0].len = cpu_to_le32(todo / 4);
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
-err_iv:
-	kfree_sensitive(d);
-err_mem:
-	return err;
-}
diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
index 71f5a0cd3d45..468d99bf5bf6 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h
@@ -15,7 +15,6 @@
 #include <linux/hw_random.h>
 #include <crypto/internal/hash.h>
 #include <crypto/md5.h>
-#include <crypto/rng.h>
 #include <crypto/sha1.h>
 #include <crypto/sha2.h>
 
@@ -58,9 +57,7 @@
 #define CE_ALG_SHA384           20
 #define CE_ALG_SHA512           21
 #define CE_ALG_TRNG		48
-#define CE_ALG_PRNG		49
 #define CE_ALG_TRNG_V2		0x1c
-#define CE_ALG_PRNG_V2		0x1d
 
 /* Used in ce_variant */
 #define CE_ID_NOTSUPP		0xFF
@@ -96,10 +93,6 @@
 #define ESR_H6	4
 #define ESR_D1	5
 
-#define PRNG_DATA_SIZE (160 / 8)
-#define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
-#define PRNG_LD BIT(17)
-
 #define CE_DIE_ID_SHIFT	16
 #define CE_DIE_ID_MASK	0x07
 
@@ -136,13 +129,10 @@ struct ce_clock {
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
@@ -151,12 +141,10 @@ struct ce_variant {
 	u32 op_mode[CE_ID_OP_MAX];
 	bool cipher_t_dlen_in_bytes;
 	bool hash_t_dlen_in_bits;
-	bool prng_t_dlen_in_bytes;
 	bool trng_t_dlen_in_bytes;
 	bool needs_word_addresses;
 	struct ce_clock ce_clks[CE_MAX_CLOCKS];
 	int esr;
-	unsigned char prng;
 	unsigned char trng;
 };
 
@@ -327,16 +315,6 @@ struct sun8i_ce_hash_reqctx {
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
@@ -357,7 +335,6 @@ struct sun8i_ce_alg_template {
 	union {
 		struct skcipher_engine_alg skcipher;
 		struct ahash_engine_alg hash;
-		struct rng_alg rng;
 	} alg;
 	unsigned long stat_req;
 	unsigned long stat_fb;
@@ -398,11 +375,5 @@ int sun8i_ce_hash_finup(struct ahash_request *areq);
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
index 59c9bc45ec0f..0b22fcddb882 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c
@@ -11,7 +11,6 @@
  */
 
 #include <crypto/engine.h>
-#include <crypto/internal/rng.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
@@ -283,25 +282,6 @@ static struct sun8i_ss_alg_template ss_algs[] = {
 		.do_one_request = sun8i_ss_handle_cipher_request,
 	},
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
@@ -501,14 +481,6 @@ static int sun8i_ss_debugfs_show(struct seq_file *seq, void *v)
 			seq_printf(seq, "\tFallback due to SG numbers: %lu\n",
 				   ss_algs[i].stat_fb_sgnum);
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			seq_printf(seq, "%s %s reqs=%lu tsize=%lu\n",
-				   ss_algs[i].alg.rng.base.cra_driver_name,
-				   ss_algs[i].alg.rng.base.cra_name,
-				   ss_algs[i].stat_req, ss_algs[i].stat_bytes);
-			break;
-#endif
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_HASH
 		case CRYPTO_ALG_TYPE_AHASH:
 			seq_printf(seq, "%s %s reqs=%lu fallback=%lu\n",
@@ -711,16 +683,6 @@ static int sun8i_ss_register_algs(struct sun8i_ss_dev *ss)
 				return err;
 			}
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			err = crypto_register_rng(&ss_algs[i].alg.rng);
-			if (err) {
-				dev_err(ss->dev, "Fail to register %s\n",
-					ss_algs[i].alg.rng.base.cra_name);
-				ss_algs[i].ss = NULL;
-			}
-			break;
-#endif
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_HASH
 		case CRYPTO_ALG_TYPE_AHASH:
 			id = ss_algs[i].ss_algo_id;
@@ -764,13 +726,6 @@ static void sun8i_ss_unregister_algs(struct sun8i_ss_dev *ss)
 				 ss_algs[i].alg.skcipher.base.base.cra_name);
 			crypto_engine_unregister_skcipher(&ss_algs[i].alg.skcipher);
 			break;
-#ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_PRNG
-		case CRYPTO_ALG_TYPE_RNG:
-			dev_info(ss->dev, "Unregister %d %s\n", i,
-				 ss_algs[i].alg.rng.base.cra_name);
-			crypto_unregister_rng(&ss_algs[i].alg.rng);
-			break;
-#endif
 #ifdef CONFIG_CRYPTO_DEV_SUN8I_SS_HASH
 		case CRYPTO_ALG_TYPE_AHASH:
 			dev_info(ss->dev, "Unregister %d %s\n", i,
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
deleted file mode 100644
index a923cfc6553f..000000000000
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-prng.c
+++ /dev/null
@@ -1,177 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * sun8i-ss-prng.c - hardware cryptographic offloader for
- * Allwinner A80/A83T SoC
- *
- * Copyright (C) 2015-2020 Corentin Labbe <clabbe@baylibre.com>
- *
- * This file handle the PRNG found in the SS
- *
- * You could find a link for the datasheet in Documentation/arch/arm/sunxi.rst
- */
-#include "sun8i-ss.h"
-#include <linux/dma-mapping.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/pm_runtime.h>
-#include <crypto/internal/rng.h>
-
-int sun8i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed,
-		       unsigned int slen)
-{
-	struct sun8i_ss_rng_tfm_ctx *ctx = crypto_rng_ctx(tfm);
-
-	if (ctx->seed && ctx->slen != slen) {
-		kfree_sensitive(ctx->seed);
-		ctx->slen = 0;
-		ctx->seed = NULL;
-	}
-	if (!ctx->seed)
-		ctx->seed = kmalloc(slen, GFP_KERNEL);
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
-	kfree_sensitive(ctx->seed);
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
-	unsigned int todo_with_padding;
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
-	todo_with_padding = ALIGN(todo, dma_get_cache_alignment());
-	if (todo_with_padding < todo || todo < dlen)
-		return -EOVERFLOW;
-
-	d = kzalloc(todo_with_padding, GFP_KERNEL);
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
-	err = pm_runtime_resume_and_get(ss->dev);
-	if (err < 0)
-		goto err_pm;
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
-err_free:
-	kfree_sensitive(d);
-
-	return err;
-}
diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 3fc86225edaf..289fb22abfa2 100644
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
@@ -27,7 +26,6 @@
 #define SS_ALG_DES		(1 << 2)
 #define SS_ALG_3DES		(2 << 2)
 #define SS_ALG_MD5		(3 << 2)
-#define SS_ALG_PRNG		(4 << 2)
 #define SS_ALG_SHA1		(6 << 2)
 #define SS_ALG_SHA224		(7 << 2)
 #define SS_ALG_SHA256		(8 << 2)
@@ -68,8 +66,6 @@
 #define SS_FLOW0	BIT(30)
 #define SS_FLOW1	BIT(31)
 
-#define SS_PRNG_CONTINUE	BIT(18)
-
 #define MAX_SG 8
 
 #define MAXFLOW 2
@@ -79,9 +75,6 @@
 #define SS_DIE_ID_SHIFT	20
 #define SS_DIE_ID_MASK	0x07
 
-#define PRNG_DATA_SIZE (160 / 8)
-#define PRNG_SEED_SIZE DIV_ROUND_UP(175, 8)
-
 #define MAX_PAD_SIZE 4096
 
 /*
@@ -213,16 +206,6 @@ struct sun8i_cipher_tfm_ctx {
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
  * @fallback_tfm:	pointer to the fallback TFM
@@ -274,7 +257,6 @@ struct sun8i_ss_alg_template {
 	struct sun8i_ss_dev *ss;
 	union {
 		struct skcipher_engine_alg skcipher;
-		struct rng_alg rng;
 		struct ahash_engine_alg hash;
 	} alg;
 	unsigned long stat_req;
@@ -300,11 +282,6 @@ int sun8i_ss_skencrypt(struct skcipher_request *areq);
 int sun8i_ss_get_engine_number(struct sun8i_ss_dev *ss);
 
 int sun8i_ss_run_task(struct sun8i_ss_dev *ss, struct sun8i_cipher_req_ctx *rctx, const char *name);
-int sun8i_ss_prng_generate(struct crypto_rng *tfm, const u8 *src,
-			   unsigned int slen, u8 *dst, unsigned int dlen);
-int sun8i_ss_prng_seed(struct crypto_rng *tfm, const u8 *seed, unsigned int slen);
-int sun8i_ss_prng_init(struct crypto_tfm *tfm);
-void sun8i_ss_prng_exit(struct crypto_tfm *tfm);
 
 int sun8i_ss_hash_init_tfm(struct crypto_ahash *tfm);
 void sun8i_ss_hash_exit_tfm(struct crypto_ahash *tfm);
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 3c0eacacfc87..48cd537f001e 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -462,14 +462,13 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
 			IS_ALIGNED(dd->out_sg->length, dd->ctx->block_size);
 		fast = in && out;
 
-		if (sg_dma_len(dd->in_sg) != sg_dma_len(dd->out_sg))
+		if (dd->in_sg->length != dd->out_sg->length)
 			fast = 0;
 	}
 
 
 	if (fast)  {
-		count = min_t(size_t, dd->total, sg_dma_len(dd->in_sg));
-		count = min_t(size_t, count, sg_dma_len(dd->out_sg));
+		count = min_t(size_t, dd->total, dd->in_sg->length);
 
 		err = dma_map_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
 		if (!err) {
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index f62b994e18e5..904d9413ba18 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2021 Intel Corporation. All rights rsvd. */
 
 #include <linux/init.h>
+#include <linux/crypto.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -996,6 +997,19 @@ static int deflate_generic_decompress(struct acomp_req *req)
 	return ret;
 }
 
+static int deflate_generic_compress(struct acomp_req *req)
+{
+	ACOMP_FBREQ_ON_STACK(fbreq, req);
+	int ret;
+
+	ret = crypto_acomp_compress(fbreq);
+	req->dlen = fbreq->dlen;
+
+	update_total_sw_comp_calls();
+
+	return ret;
+}
+
 static int iaa_remap_for_verify(struct device *dev, struct iaa_wq *iaa_wq,
 				struct acomp_req *req,
 				dma_addr_t *src_addr, dma_addr_t *dst_addr);
@@ -1472,7 +1486,7 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	struct iaa_compression_ctx *compression_ctx;
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
+	int cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct idxd_wq *wq;
 	struct device *dev;
@@ -1484,11 +1498,15 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		return -ENODEV;
 	}
 
-	if (!req->src || !req->slen) {
-		pr_debug("invalid src, not compressing\n");
+	if (!req->src || !req->slen || !req->dst) {
+		pr_debug("invalid req, not compressing\n");
 		return -EINVAL;
 	}
 
+	/* Fall back to software if src or dst has multiple sg entries */
+	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+		return deflate_generic_compress(req);
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1507,30 +1525,25 @@ static int iaa_comp_acompress(struct acomp_req *req)
 
 	dev = &wq->idxd->pdev->dev;
 
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
+	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		iaa_wq_put(wq);
+		return deflate_generic_compress(req);
 	}
 	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
 		req->src, req->slen, sg_dma_len(req->src));
 
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
+	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+		iaa_wq_put(wq);
+		return deflate_generic_compress(req);
 	}
 	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_compress(tfm, req, wq, src_addr, req->slen, dst_addr,
@@ -1550,8 +1563,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 		if (ret)
 			dev_dbg(dev, "asynchronous compress verification failed ret=%d\n", ret);
 
-		dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_TO_DEVICE);
-		dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_FROM_DEVICE);
+		dma_unmap_sg(dev, req->dst, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(dev, req->src, 1, DMA_FROM_DEVICE);
 
 		goto out;
 	}
@@ -1559,9 +1572,8 @@ static int iaa_comp_acompress(struct acomp_req *req)
 	if (ret)
 		dev_dbg(dev, "asynchronous compress failed ret=%d\n", ret);
 
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
+	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
 out:
 	iaa_wq_put(wq);
 
@@ -1572,7 +1584,7 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 {
 	struct crypto_tfm *tfm = req->base.tfm;
 	dma_addr_t src_addr, dst_addr;
-	int nr_sgs, cpu, ret = 0;
+	int cpu, ret = 0;
 	struct iaa_wq *iaa_wq;
 	struct device *dev;
 	struct idxd_wq *wq;
@@ -1582,11 +1594,15 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 		return -ENODEV;
 	}
 
-	if (!req->src || !req->slen) {
-		pr_debug("invalid src, not decompressing\n");
+	if (!req->src || !req->slen || !req->dst) {
+		pr_debug("invalid req, not decompressing\n");
 		return -EINVAL;
 	}
 
+	/* Fall back to software if src or dst has multiple sg entries */
+	if (sg_nents(req->src) > 1 || sg_nents(req->dst) > 1)
+		return deflate_generic_decompress(req);
+
 	cpu = get_cpu();
 	wq = wq_table_next_wq(cpu);
 	put_cpu();
@@ -1605,30 +1621,25 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 
 	dev = &wq->idxd->pdev->dev;
 
-	nr_sgs = dma_map_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map src sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto out;
+	if (!dma_map_sg(dev, req->src, 1, DMA_TO_DEVICE)) {
+		dev_dbg(dev, "couldn't map src sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		iaa_wq_put(wq);
+		return deflate_generic_decompress(req);
 	}
 	src_addr = sg_dma_address(req->src);
-	dev_dbg(dev, "dma_map_sg, src_addr %llx, nr_sgs %d, req->src %p,"
-		" req->slen %d, sg_dma_len(sg) %d\n", src_addr, nr_sgs,
+	dev_dbg(dev, "map src %llx req->src %p slen %d sg_len %d\n", src_addr,
 		req->src, req->slen, sg_dma_len(req->src));
 
-	nr_sgs = dma_map_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-	if (nr_sgs <= 0 || nr_sgs > 1) {
-		dev_dbg(dev, "couldn't map dst sg for iaa device %d,"
-			" wq %d: ret=%d\n", iaa_wq->iaa_device->idxd->id,
-			iaa_wq->wq->id, ret);
-		ret = -EIO;
-		goto err_map_dst;
+	if (!dma_map_sg(dev, req->dst, 1, DMA_FROM_DEVICE)) {
+		dev_dbg(dev, "couldn't map dst sg for iaa device %d, wq %d\n",
+			iaa_wq->iaa_device->idxd->id, iaa_wq->wq->id);
+		dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
+		iaa_wq_put(wq);
+		return deflate_generic_decompress(req);
 	}
 	dst_addr = sg_dma_address(req->dst);
-	dev_dbg(dev, "dma_map_sg, dst_addr %llx, nr_sgs %d, req->dst %p,"
-		" req->dlen %d, sg_dma_len(sg) %d\n", dst_addr, nr_sgs,
+	dev_dbg(dev, "map dst %llx req->dst %p dlen %d sg_len %d\n", dst_addr,
 		req->dst, req->dlen, sg_dma_len(req->dst));
 
 	ret = iaa_decompress(tfm, req, wq, src_addr, req->slen,
@@ -1639,10 +1650,8 @@ static int iaa_comp_adecompress(struct acomp_req *req)
 	if (ret != 0)
 		dev_dbg(dev, "asynchronous decompress failed ret=%d\n", ret);
 
-	dma_unmap_sg(dev, req->dst, sg_nents(req->dst), DMA_FROM_DEVICE);
-err_map_dst:
-	dma_unmap_sg(dev, req->src, sg_nents(req->src), DMA_TO_DEVICE);
-out:
+	dma_unmap_sg(dev, req->dst, 1, DMA_FROM_DEVICE);
+	dma_unmap_sg(dev, req->src, 1, DMA_TO_DEVICE);
 	iaa_wq_put(wq);
 
 	return ret;
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.c b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
index f5cc3d29ca19..2f2ed88c8812 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.c
@@ -19,6 +19,7 @@
 
 static atomic64_t total_comp_calls;
 static atomic64_t total_decomp_calls;
+static atomic64_t total_sw_comp_calls;
 static atomic64_t total_sw_decomp_calls;
 static atomic64_t total_comp_bytes_out;
 static atomic64_t total_decomp_bytes_in;
@@ -43,6 +44,11 @@ void update_total_decomp_calls(void)
 	atomic64_inc(&total_decomp_calls);
 }
 
+void update_total_sw_comp_calls(void)
+{
+	atomic64_inc(&total_sw_comp_calls);
+}
+
 void update_total_sw_decomp_calls(void)
 {
 	atomic64_inc(&total_sw_decomp_calls);
@@ -104,6 +110,7 @@ static void reset_iaa_crypto_stats(void)
 {
 	atomic64_set(&total_comp_calls, 0);
 	atomic64_set(&total_decomp_calls, 0);
+	atomic64_set(&total_sw_comp_calls, 0);
 	atomic64_set(&total_sw_decomp_calls, 0);
 	atomic64_set(&total_comp_bytes_out, 0);
 	atomic64_set(&total_decomp_bytes_in, 0);
@@ -174,6 +181,8 @@ static int global_stats_show(struct seq_file *m, void *v)
 		   atomic64_read(&total_comp_calls));
 	seq_printf(m, "  total_decomp_calls: %llu\n",
 		   atomic64_read(&total_decomp_calls));
+	seq_printf(m, "  total_sw_comp_calls: %llu\n",
+		   atomic64_read(&total_sw_comp_calls));
 	seq_printf(m, "  total_sw_decomp_calls: %llu\n",
 		   atomic64_read(&total_sw_decomp_calls));
 	seq_printf(m, "  total_comp_bytes_out: %llu\n",
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_stats.h b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
index 3787a5f507eb..6e0c6f9939bf 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_stats.h
+++ b/drivers/crypto/intel/iaa/iaa_crypto_stats.h
@@ -11,6 +11,7 @@ void	iaa_crypto_debugfs_cleanup(void);
 void	update_total_comp_calls(void);
 void	update_total_comp_bytes_out(int n);
 void	update_total_decomp_calls(void);
+void	update_total_sw_comp_calls(void);
 void	update_total_sw_decomp_calls(void);
 void	update_total_decomp_bytes_in(int n);
 void	update_completion_einval_errs(void);
@@ -29,6 +30,7 @@ static inline void	iaa_crypto_debugfs_cleanup(void) {}
 static inline void	update_total_comp_calls(void) {}
 static inline void	update_total_comp_bytes_out(int n) {}
 static inline void	update_total_decomp_calls(void) {}
+static inline void	update_total_sw_comp_calls(void) {}
 static inline void	update_total_sw_decomp_calls(void) {}
 static inline void	update_total_decomp_bytes_in(int n) {}
 static inline void	update_completion_einval_errs(void) {}
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index 133ebc998236..595b2fd84667 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -353,7 +353,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	for_each_sg(req->src, src, sg_nents(req->src), i) {
 		src_buf = sg_virt(src);
-		len = sg_dma_len(src);
+		len = src->length;
 		tlen += len;
 		limit_hit = tlen > req->cryptlen;
 
diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 9cb11fada2c4..a9642c67f476 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -9,8 +9,6 @@
 #include <crypto/gcm.h>
 #include <crypto/authenc.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/des.h>
-#include <crypto/sha1.h>
 #include <crypto/sha2.h>
 #include <crypto/scatterwalk.h>
 #include "aead.h"
@@ -198,7 +196,7 @@ qce_aead_ccm_prepare_buf_assoclen(struct aead_request *req)
 	/* Get the msg */
 	msg_sg = scatterwalk_ffwd(__sg, req->src, req->assoclen);
 
-	rctx->adata = kzalloc((ALIGN(assoclen, 16) + MAX_CCM_ADATA_HEADER_LEN) *
+	rctx->adata = kzalloc(ALIGN(assoclen + MAX_CCM_ADATA_HEADER_LEN, 16) *
 			       sizeof(unsigned char), GFP_ATOMIC);
 	if (!rctx->adata)
 		return -ENOMEM;
@@ -592,7 +590,6 @@ static int qce_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct crypto_authenc_keys authenc_keys;
 	unsigned long flags = to_aead_tmpl(tfm)->alg_flags;
-	u32 _key[6];
 	int err;
 
 	err = crypto_authenc_extractkeys(&authenc_keys, key, keylen);
@@ -603,26 +600,7 @@ static int qce_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int
 	    authenc_keys.authkeylen > QCE_MAX_KEY_SIZE)
 		return -EINVAL;
 
-	if (IS_DES(flags)) {
-		err = verify_aead_des_key(tfm, authenc_keys.enckey, authenc_keys.enckeylen);
-		if (err)
-			return err;
-	} else if (IS_3DES(flags)) {
-		err = verify_aead_des3_key(tfm, authenc_keys.enckey, authenc_keys.enckeylen);
-		if (err)
-			return err;
-		/*
-		 * The crypto engine does not support any two keys
-		 * being the same for triple des algorithms. The
-		 * verify_skcipher_des3_key does not check for all the
-		 * below conditions. Schedule fallback in this case.
-		 */
-		memcpy(_key, authenc_keys.enckey, DES3_EDE_KEY_SIZE);
-		if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) ||
-		    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) ||
-		    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
-			ctx->need_fallback = true;
-	} else if (IS_AES(flags)) {
+	if (IS_AES(flags)) {
 		/* No random key sizes */
 		if (authenc_keys.enckeylen != AES_KEYSIZE_128 &&
 		    authenc_keys.enckeylen != AES_KEYSIZE_192 &&
@@ -693,38 +671,6 @@ struct qce_aead_def {
 };
 
 static const struct qce_aead_def aead_def[] = {
-	{
-		.flags          = QCE_ALG_DES | QCE_MODE_CBC | QCE_HASH_SHA1_HMAC,
-		.name           = "authenc(hmac(sha1),cbc(des))",
-		.drv_name       = "authenc-hmac-sha1-cbc-des-qce",
-		.blocksize      = DES_BLOCK_SIZE,
-		.ivsize         = DES_BLOCK_SIZE,
-		.maxauthsize	= SHA1_DIGEST_SIZE,
-	},
-	{
-		.flags          = QCE_ALG_3DES | QCE_MODE_CBC | QCE_HASH_SHA1_HMAC,
-		.name           = "authenc(hmac(sha1),cbc(des3_ede))",
-		.drv_name       = "authenc-hmac-sha1-cbc-3des-qce",
-		.blocksize      = DES3_EDE_BLOCK_SIZE,
-		.ivsize         = DES3_EDE_BLOCK_SIZE,
-		.maxauthsize	= SHA1_DIGEST_SIZE,
-	},
-	{
-		.flags          = QCE_ALG_DES | QCE_MODE_CBC | QCE_HASH_SHA256_HMAC,
-		.name           = "authenc(hmac(sha256),cbc(des))",
-		.drv_name       = "authenc-hmac-sha256-cbc-des-qce",
-		.blocksize      = DES_BLOCK_SIZE,
-		.ivsize         = DES_BLOCK_SIZE,
-		.maxauthsize	= SHA256_DIGEST_SIZE,
-	},
-	{
-		.flags          = QCE_ALG_3DES | QCE_MODE_CBC | QCE_HASH_SHA256_HMAC,
-		.name           = "authenc(hmac(sha256),cbc(des3_ede))",
-		.drv_name       = "authenc-hmac-sha256-cbc-3des-qce",
-		.blocksize      = DES3_EDE_BLOCK_SIZE,
-		.ivsize         = DES3_EDE_BLOCK_SIZE,
-		.maxauthsize	= SHA256_DIGEST_SIZE,
-	},
 	{
 		.flags          =  QCE_ALG_AES | QCE_MODE_CBC | QCE_HASH_SHA256_HMAC,
 		.name           = "authenc(hmac(sha256),cbc(aes))",
diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 54a78a57f630..3081d765a0f2 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -8,7 +8,6 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <crypto/scatterwalk.h>
-#include <crypto/sha1.h>
 #include <crypto/sha2.h>
 
 #include "cipher.h"
@@ -115,18 +114,16 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size, u32 auth_size)
 			cfg |= AUTH_KEY_SZ_AES256 << AUTH_KEY_SIZE_SHIFT;
 	}
 
-	if (IS_SHA1(flags) || IS_SHA1_HMAC(flags))
-		cfg |= AUTH_SIZE_SHA1 << AUTH_SIZE_SHIFT;
-	else if (IS_SHA256(flags) || IS_SHA256_HMAC(flags))
+	if (IS_SHA256(flags) || IS_SHA256_HMAC(flags))
 		cfg |= AUTH_SIZE_SHA256 << AUTH_SIZE_SHIFT;
 	else if (IS_CMAC(flags))
 		cfg |= AUTH_SIZE_ENUM_16_BYTES << AUTH_SIZE_SHIFT;
 	else if (IS_CCM(flags))
 		cfg |= (auth_size - 1) << AUTH_SIZE_SHIFT;
 
-	if (IS_SHA1(flags) || IS_SHA256(flags))
+	if (IS_SHA256(flags))
 		cfg |= AUTH_MODE_HASH << AUTH_MODE_SHIFT;
-	else if (IS_SHA1_HMAC(flags) || IS_SHA256_HMAC(flags))
+	else if (IS_SHA256_HMAC(flags))
 		cfg |= AUTH_MODE_HMAC << AUTH_MODE_SHIFT;
 	else if (IS_CCM(flags))
 		cfg |= AUTH_MODE_CCM << AUTH_MODE_SHIFT;
@@ -191,7 +188,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	else
 		qce_cpu_to_be32p_array(auth, rctx->digest, digestsize);
 
-	iv_words = (IS_SHA1(rctx->flags) || IS_SHA1_HMAC(rctx->flags)) ? 5 : 8;
+	iv_words = 8;
 	qce_write_array(qce, REG_AUTH_IV0, (u32 *)auth, iv_words);
 
 	if (rctx->first_blk)
@@ -243,19 +240,8 @@ static u32 qce_encr_cfg(unsigned long flags, u32 aes_key_size)
 
 	if (IS_AES(flags))
 		cfg |= ENCR_ALG_AES << ENCR_ALG_SHIFT;
-	else if (IS_DES(flags) || IS_3DES(flags))
-		cfg |= ENCR_ALG_DES << ENCR_ALG_SHIFT;
-
-	if (IS_DES(flags))
-		cfg |= ENCR_KEY_SZ_DES << ENCR_KEY_SZ_SHIFT;
-
-	if (IS_3DES(flags))
-		cfg |= ENCR_KEY_SZ_3DES << ENCR_KEY_SZ_SHIFT;
 
 	switch (flags & QCE_MODE_MASK) {
-	case QCE_MODE_ECB:
-		cfg |= ENCR_MODE_ECB << ENCR_MODE_SHIFT;
-		break;
 	case QCE_MODE_CBC:
 		cfg |= ENCR_MODE_CBC << ENCR_MODE_SHIFT;
 		break;
@@ -340,13 +326,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 
 	encr_cfg = qce_encr_cfg(flags, keylen);
 
-	if (IS_DES(flags)) {
-		enciv_words = 2;
-		enckey_words = 2;
-	} else if (IS_3DES(flags)) {
-		enciv_words = 2;
-		enckey_words = 6;
-	} else if (IS_AES(flags)) {
+	if (IS_AES(flags)) {
 		if (IS_XTS(flags))
 			qce_xtskey(qce, ctx->enc_key, ctx->enc_keylen,
 				   rctx->cryptlen);
@@ -357,14 +337,12 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 
 	qce_write_array(qce, REG_ENCR_KEY0, (u32 *)enckey, enckey_words);
 
-	if (!IS_ECB(flags)) {
-		if (IS_XTS(flags))
-			qce_xts_swapiv(enciv, rctx->iv, ivsize);
-		else
-			qce_cpu_to_be32p_array(enciv, rctx->iv, ivsize);
+	if (IS_XTS(flags))
+		qce_xts_swapiv(enciv, rctx->iv, ivsize);
+	else
+		qce_cpu_to_be32p_array(enciv, rctx->iv, ivsize);
 
-		qce_write_array(qce, REG_CNTR0_IV0, (u32 *)enciv, enciv_words);
-	}
+	qce_write_array(qce, REG_CNTR0_IV0, (u32 *)enciv, enciv_words);
 
 	if (IS_ENCRYPT(flags))
 		encr_cfg |= BIT(ENCODE_SHIFT);
@@ -393,10 +371,6 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 #endif
 
 #ifdef CONFIG_CRYPTO_DEV_QCE_AEAD
-static const u32 std_iv_sha1[SHA256_DIGEST_SIZE / sizeof(u32)] = {
-	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4, 0, 0, 0
-};
-
 static const u32 std_iv_sha256[SHA256_DIGEST_SIZE / sizeof(u32)] = {
 	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7
@@ -473,13 +447,8 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
 	/* Write initial authentication IV only for HMAC algorithms */
 	if (IS_SHA_HMAC(rctx->flags)) {
 		/* Write default authentication iv */
-		if (IS_SHA1_HMAC(rctx->flags)) {
-			auth_ivsize = SHA1_DIGEST_SIZE;
-			memcpy(authiv, std_iv_sha1, auth_ivsize);
-		} else if (IS_SHA256_HMAC(rctx->flags)) {
-			auth_ivsize = SHA256_DIGEST_SIZE;
-			memcpy(authiv, std_iv_sha256, auth_ivsize);
-		}
+		auth_ivsize = SHA256_DIGEST_SIZE;
+		memcpy(authiv, std_iv_sha256, auth_ivsize);
 		authiv_words = auth_ivsize / sizeof(u32);
 		qce_write_array(qce, REG_AUTH_IV0, (u32 *)authiv, authiv_words);
 	} else if (IS_CCM(rctx->flags)) {
diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 02e63ad9f245..9cd2e6ed8bbb 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -22,7 +22,7 @@
 
 /* IV length in bytes */
 #define QCE_AES_IV_LENGTH		AES_BLOCK_SIZE
-/* max of AES_BLOCK_SIZE, DES3_EDE_BLOCK_SIZE */
+/* max of AES_BLOCK_SIZE */
 #define QCE_MAX_IV_SIZE			AES_BLOCK_SIZE
 
 /* maximum nonce bytes  */
@@ -33,14 +33,10 @@
 #define QCE_MAX_ALIGN_SIZE		64
 
 /* cipher algorithms */
-#define QCE_ALG_DES			BIT(0)
-#define QCE_ALG_3DES			BIT(1)
 #define QCE_ALG_AES			BIT(2)
 
 /* hash and hmac algorithms */
-#define QCE_HASH_SHA1			BIT(3)
 #define QCE_HASH_SHA256			BIT(4)
-#define QCE_HASH_SHA1_HMAC		BIT(5)
 #define QCE_HASH_SHA256_HMAC		BIT(6)
 #define QCE_HASH_AES_CMAC		BIT(7)
 
@@ -58,21 +54,15 @@
 #define QCE_ENCRYPT			BIT(30)
 #define QCE_DECRYPT			BIT(31)
 
-#define IS_DES(flags)			(flags & QCE_ALG_DES)
-#define IS_3DES(flags)			(flags & QCE_ALG_3DES)
 #define IS_AES(flags)			(flags & QCE_ALG_AES)
 
-#define IS_SHA1(flags)			(flags & QCE_HASH_SHA1)
 #define IS_SHA256(flags)		(flags & QCE_HASH_SHA256)
-#define IS_SHA1_HMAC(flags)		(flags & QCE_HASH_SHA1_HMAC)
 #define IS_SHA256_HMAC(flags)		(flags & QCE_HASH_SHA256_HMAC)
 #define IS_CMAC(flags)			(flags & QCE_HASH_AES_CMAC)
-#define IS_SHA(flags)			(IS_SHA1(flags) || IS_SHA256(flags))
-#define IS_SHA_HMAC(flags)		\
-		(IS_SHA1_HMAC(flags) || IS_SHA256_HMAC(flags))
+#define IS_SHA(flags)			IS_SHA256(flags)
+#define IS_SHA_HMAC(flags)		IS_SHA256_HMAC(flags)
 
 #define IS_CBC(mode)			(mode & QCE_MODE_CBC)
-#define IS_ECB(mode)			(mode & QCE_MODE_ECB)
 #define IS_CTR(mode)			(mode & QCE_MODE_CTR)
 #define IS_XTS(mode)			(mode & QCE_MODE_XTS)
 #define IS_CCM(mode)			(mode & QCE_MODE_CCM)
diff --git a/drivers/crypto/qce/regs-v5.h b/drivers/crypto/qce/regs-v5.h
index d59ed2798906..431a7db1a4e7 100644
--- a/drivers/crypto/qce/regs-v5.h
+++ b/drivers/crypto/qce/regs-v5.h
@@ -203,7 +203,6 @@
 
 #define AUTH_SIZE_SHIFT			9
 #define AUTH_SIZE_MASK			GENMASK(13, 9)
-#define AUTH_SIZE_SHA1			0
 #define AUTH_SIZE_SHA256		1
 #define AUTH_SIZE_ENUM_1_BYTES		0
 #define AUTH_SIZE_ENUM_2_BYTES		1
@@ -284,15 +283,12 @@
 
 #define ENCR_KEY_SZ_SHIFT		3
 #define ENCR_KEY_SZ_MASK		GENMASK(5, 3)
-#define ENCR_KEY_SZ_DES			0
-#define ENCR_KEY_SZ_3DES		1
 #define ENCR_KEY_SZ_AES128		0
 #define ENCR_KEY_SZ_AES256		2
 
 #define ENCR_ALG_SHIFT			0
 #define ENCR_ALG_MASK			GENMASK(2, 0)
 #define ENCR_ALG_NONE			0
-#define ENCR_ALG_DES			1
 #define ENCR_ALG_AES			2
 #define ENCR_ALG_KASUMI			4
 #define ENCR_ALG_SNOW_3G		5
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 1b37121cbcdc..cd9391219b1f 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -25,10 +25,6 @@ struct qce_sha_saved_state {
 
 static LIST_HEAD(ahash_algs);
 
-static const u32 std_iv_sha1[SHA256_DIGEST_SIZE / sizeof(u32)] = {
-	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4, 0, 0, 0
-};
-
 static const u32 std_iv_sha256[SHA256_DIGEST_SIZE / sizeof(u32)] = {
 	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7
@@ -349,9 +345,7 @@ static int qce_ahash_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 		return 0;
 	}
 
-	if (digestsize == SHA1_DIGEST_SIZE)
-		alg_name = "sha1-qce";
-	else if (digestsize == SHA256_DIGEST_SIZE)
+	if (digestsize == SHA256_DIGEST_SIZE)
 		alg_name = "sha256-qce";
 	else
 		return -EINVAL;
@@ -412,15 +406,6 @@ struct qce_ahash_def {
 };
 
 static const struct qce_ahash_def ahash_def[] = {
-	{
-		.flags		= QCE_HASH_SHA1,
-		.name		= "sha1",
-		.drv_name	= "sha1-qce",
-		.digestsize	= SHA1_DIGEST_SIZE,
-		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct qce_sha_saved_state),
-		.std_iv		= std_iv_sha1,
-	},
 	{
 		.flags		= QCE_HASH_SHA256,
 		.name		= "sha256",
@@ -430,15 +415,6 @@ static const struct qce_ahash_def ahash_def[] = {
 		.statesize	= sizeof(struct qce_sha_saved_state),
 		.std_iv		= std_iv_sha256,
 	},
-	{
-		.flags		= QCE_HASH_SHA1_HMAC,
-		.name		= "hmac(sha1)",
-		.drv_name	= "hmac-sha1-qce",
-		.digestsize	= SHA1_DIGEST_SIZE,
-		.blocksize	= SHA1_BLOCK_SIZE,
-		.statesize	= sizeof(struct qce_sha_saved_state),
-		.std_iv		= std_iv_sha1,
-	},
 	{
 		.flags		= QCE_HASH_SHA256_HMAC,
 		.name		= "hmac(sha256)",
@@ -476,9 +452,7 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	alg->halg.digestsize = def->digestsize;
 	alg->halg.statesize = def->statesize;
 
-	if (IS_SHA1(def->flags))
-		tmpl->hash_zero = sha1_zero_message_hash;
-	else if (IS_SHA256(def->flags))
+	if (IS_SHA256(def->flags))
 		tmpl->hash_zero = sha256_zero_message_hash;
 
 	base = &alg->halg.base;
diff --git a/drivers/crypto/qce/sha.h b/drivers/crypto/qce/sha.h
index a22695361f16..cb822fc334dc 100644
--- a/drivers/crypto/qce/sha.h
+++ b/drivers/crypto/qce/sha.h
@@ -7,7 +7,6 @@
 #define _SHA_H_
 
 #include <crypto/scatterwalk.h>
-#include <crypto/sha1.h>
 #include <crypto/sha2.h>
 
 #include "common.h"
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index db0b648a56eb..ff4ee9541f7c 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -11,7 +11,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <crypto/aes.h>
-#include <crypto/internal/des.h>
 #include <crypto/internal/skcipher.h>
 
 #include "cipher.h"
@@ -209,51 +208,6 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
 	return ret;
 }
 
-static int qce_des_setkey(struct crypto_skcipher *ablk, const u8 *key,
-			  unsigned int keylen)
-{
-	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(ablk);
-	int err;
-
-	err = verify_skcipher_des_key(ablk, key);
-	if (err)
-		return err;
-
-	ctx->enc_keylen = keylen;
-	memcpy(ctx->enc_key, key, keylen);
-	return 0;
-}
-
-static int qce_des3_setkey(struct crypto_skcipher *ablk, const u8 *key,
-			   unsigned int keylen)
-{
-	struct qce_cipher_ctx *ctx = crypto_skcipher_ctx(ablk);
-	u32 _key[6];
-	int err;
-
-	err = verify_skcipher_des3_key(ablk, key);
-	if (err)
-		return err;
-
-	/*
-	 * The crypto engine does not support any two keys
-	 * being the same for triple des algorithms. The
-	 * verify_skcipher_des3_key does not check for all the
-	 * below conditions. Return -ENOKEY in case any two keys
-	 * are the same. Revisit to see if a fallback cipher
-	 * is needed to handle this condition.
-	 */
-	memcpy(_key, key, DES3_EDE_KEY_SIZE);
-	if (!((_key[0] ^ _key[2]) | (_key[1] ^ _key[3])) ||
-	    !((_key[2] ^ _key[4]) | (_key[3] ^ _key[5])) ||
-	    !((_key[0] ^ _key[4]) | (_key[1] ^ _key[5])))
-		return -ENOKEY;
-
-	ctx->enc_keylen = keylen;
-	memcpy(ctx->enc_key, key, keylen);
-	return 0;
-}
-
 static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
@@ -276,7 +230,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * ECB and CBC algorithms require message lengths to be
 	 * multiples of block size.
 	 */
-	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+	if (IS_CBC(rctx->flags))
 		if (!IS_ALIGNED(req->cryptlen, blocksize))
 			return -EINVAL;
 
@@ -359,15 +313,6 @@ struct qce_skcipher_def {
 };
 
 static const struct qce_skcipher_def skcipher_def[] = {
-	{
-		.flags		= QCE_ALG_AES | QCE_MODE_ECB,
-		.name		= "ecb(aes)",
-		.drv_name	= "ecb-aes-qce",
-		.blocksize	= AES_BLOCK_SIZE,
-		.ivsize		= 0,
-		.min_keysize	= AES_MIN_KEY_SIZE,
-		.max_keysize	= AES_MAX_KEY_SIZE,
-	},
 	{
 		.flags		= QCE_ALG_AES | QCE_MODE_CBC,
 		.name		= "cbc(aes)",
@@ -396,42 +341,6 @@ static const struct qce_skcipher_def skcipher_def[] = {
 		.min_keysize	= AES_MIN_KEY_SIZE * 2,
 		.max_keysize	= AES_MAX_KEY_SIZE * 2,
 	},
-	{
-		.flags		= QCE_ALG_DES | QCE_MODE_ECB,
-		.name		= "ecb(des)",
-		.drv_name	= "ecb-des-qce",
-		.blocksize	= DES_BLOCK_SIZE,
-		.ivsize		= 0,
-		.min_keysize	= DES_KEY_SIZE,
-		.max_keysize	= DES_KEY_SIZE,
-	},
-	{
-		.flags		= QCE_ALG_DES | QCE_MODE_CBC,
-		.name		= "cbc(des)",
-		.drv_name	= "cbc-des-qce",
-		.blocksize	= DES_BLOCK_SIZE,
-		.ivsize		= DES_BLOCK_SIZE,
-		.min_keysize	= DES_KEY_SIZE,
-		.max_keysize	= DES_KEY_SIZE,
-	},
-	{
-		.flags		= QCE_ALG_3DES | QCE_MODE_ECB,
-		.name		= "ecb(des3_ede)",
-		.drv_name	= "ecb-3des-qce",
-		.blocksize	= DES3_EDE_BLOCK_SIZE,
-		.ivsize		= 0,
-		.min_keysize	= DES3_EDE_KEY_SIZE,
-		.max_keysize	= DES3_EDE_KEY_SIZE,
-	},
-	{
-		.flags		= QCE_ALG_3DES | QCE_MODE_CBC,
-		.name		= "cbc(des3_ede)",
-		.drv_name	= "cbc-3des-qce",
-		.blocksize	= DES3_EDE_BLOCK_SIZE,
-		.ivsize		= DES3_EDE_BLOCK_SIZE,
-		.min_keysize	= DES3_EDE_KEY_SIZE,
-		.max_keysize	= DES3_EDE_KEY_SIZE,
-	},
 };
 
 static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
@@ -455,9 +364,7 @@ static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
 	alg->ivsize			= def->ivsize;
 	alg->min_keysize		= def->min_keysize;
 	alg->max_keysize		= def->max_keysize;
-	alg->setkey			= IS_3DES(def->flags) ? qce_des3_setkey :
-					  IS_DES(def->flags) ? qce_des_setkey :
-					  qce_skcipher_setkey;
+	alg->setkey			= qce_skcipher_setkey;
 	alg->encrypt			= qce_skcipher_encrypt;
 	alg->decrypt			= qce_skcipher_decrypt;
 
diff --git a/drivers/crypto/qcom-rng.c b/drivers/crypto/qcom-rng.c
index 150e5802e351..4d046caafe5b 100644
--- a/drivers/crypto/qcom-rng.c
+++ b/drivers/crypto/qcom-rng.c
@@ -3,10 +3,8 @@
 //
 // Based on msm-rng.c and downstream driver
 
-#include <crypto/internal/rng.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
-#include <linux/crypto.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
@@ -32,24 +30,15 @@
 #define QCOM_TRNG_QUALITY	1024
 
 struct qcom_rng {
-	struct mutex lock;
 	void __iomem *base;
 	struct clk *clk;
 	struct hwrng hwrng;
-	struct qcom_rng_match_data *match_data;
-};
-
-struct qcom_rng_ctx {
-	struct qcom_rng *rng;
 };
 
 struct qcom_rng_match_data {
-	bool skip_init;
 	bool hwrng_support;
 };
 
-static struct qcom_rng *qcom_rng_dev;
-
 static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 {
 	unsigned int currsize = 0;
@@ -65,8 +54,6 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 			return ret;
 
 		val = readl_relaxed(rng->base + PRNG_DATA_OUT);
-		if (!val)
-			return -EINVAL;
 
 		if ((max - currsize) >= WORD_SZ) {
 			memcpy(data, &val, WORD_SZ);
@@ -82,35 +69,11 @@ static int qcom_rng_read(struct qcom_rng *rng, u8 *data, unsigned int max)
 	return currsize;
 }
 
-static int qcom_rng_generate(struct crypto_rng *tfm,
-			     const u8 *src, unsigned int slen,
-			     u8 *dstn, unsigned int dlen)
+static int qcom_hwrng_init(struct hwrng *hwrng)
 {
-	struct qcom_rng_ctx *ctx = crypto_rng_ctx(tfm);
-	struct qcom_rng *rng = ctx->rng;
-	int ret;
-
-	ret = clk_prepare_enable(rng->clk);
-	if (ret)
-		return ret;
-
-	mutex_lock(&rng->lock);
-
-	ret = qcom_rng_read(rng, dstn, dlen);
-
-	mutex_unlock(&rng->lock);
-	clk_disable_unprepare(rng->clk);
-
-	if (ret >= 0)
-		ret = 0;
-
-	return ret;
-}
+	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
 
-static int qcom_rng_seed(struct crypto_rng *tfm, const u8 *seed,
-			 unsigned int slen)
-{
-	return 0;
+	return clk_prepare_enable(qrng->clk);
 }
 
 static int qcom_hwrng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
@@ -120,74 +83,33 @@ static int qcom_hwrng_read(struct hwrng *hwrng, void *data, size_t max, bool wai
 	return qcom_rng_read(qrng, data, max);
 }
 
-static int qcom_rng_enable(struct qcom_rng *rng)
+static void qcom_hwrng_cleanup(struct hwrng *hwrng)
 {
-	u32 val;
-	int ret;
-
-	ret = clk_prepare_enable(rng->clk);
-	if (ret)
-		return ret;
-
-	/* Enable PRNG only if it is not already enabled */
-	val = readl_relaxed(rng->base + PRNG_CONFIG);
-	if (val & PRNG_CONFIG_HW_ENABLE)
-		goto already_enabled;
-
-	val = readl_relaxed(rng->base + PRNG_LFSR_CFG);
-	val &= ~PRNG_LFSR_CFG_MASK;
-	val |= PRNG_LFSR_CFG_CLOCKS;
-	writel(val, rng->base + PRNG_LFSR_CFG);
-
-	val = readl_relaxed(rng->base + PRNG_CONFIG);
-	val |= PRNG_CONFIG_HW_ENABLE;
-	writel(val, rng->base + PRNG_CONFIG);
-
-already_enabled:
-	clk_disable_unprepare(rng->clk);
-
-	return 0;
-}
-
-static int qcom_rng_init(struct crypto_tfm *tfm)
-{
-	struct qcom_rng_ctx *ctx = crypto_tfm_ctx(tfm);
-
-	ctx->rng = qcom_rng_dev;
-
-	if (!ctx->rng->match_data->skip_init)
-		return qcom_rng_enable(ctx->rng);
+	struct qcom_rng *qrng = container_of(hwrng, struct qcom_rng, hwrng);
 
-	return 0;
+	clk_disable_unprepare(qrng->clk);
 }
 
-static struct rng_alg qcom_rng_alg = {
-	.generate	= qcom_rng_generate,
-	.seed		= qcom_rng_seed,
-	.seedsize	= 0,
-	.base		= {
-		.cra_name		= "stdrng",
-		.cra_driver_name	= "qcom-rng",
-		.cra_flags		= CRYPTO_ALG_TYPE_RNG,
-		.cra_priority		= 300,
-		.cra_ctxsize		= sizeof(struct qcom_rng_ctx),
-		.cra_module		= THIS_MODULE,
-		.cra_init		= qcom_rng_init,
-	}
-};
-
 static int qcom_rng_probe(struct platform_device *pdev)
 {
+	const struct qcom_rng_match_data *match_data;
 	struct qcom_rng *rng;
 	int ret;
 
+	match_data = device_get_match_data(&pdev->dev);
+	if (match_data == NULL || !match_data->hwrng_support) {
+		dev_info(&pdev->dev, "TRNG support not detected\n");
+		/*
+		 * In this case the driver does nothing except the dev_info(),
+		 * but bind the device anyway to avoid effects on GCC state.
+		 */
+		return 0;
+	}
+
 	rng = devm_kzalloc(&pdev->dev, sizeof(*rng), GFP_KERNEL);
 	if (!rng)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, rng);
-	mutex_init(&rng->lock);
-
 	rng->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(rng->base))
 		return PTR_ERR(rng->base);
@@ -196,53 +118,26 @@ static int qcom_rng_probe(struct platform_device *pdev)
 	if (IS_ERR(rng->clk))
 		return PTR_ERR(rng->clk);
 
-	rng->match_data = (struct qcom_rng_match_data *)device_get_match_data(&pdev->dev);
-
-	qcom_rng_dev = rng;
-	ret = crypto_register_rng(&qcom_rng_alg);
-	if (ret) {
-		dev_err(&pdev->dev, "Register crypto rng failed: %d\n", ret);
-		qcom_rng_dev = NULL;
-		return ret;
-	}
-
-	if (rng->match_data->hwrng_support) {
-		rng->hwrng.name = "qcom_hwrng";
-		rng->hwrng.read = qcom_hwrng_read;
-		rng->hwrng.quality = QCOM_TRNG_QUALITY;
-		ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
-		if (ret) {
-			dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
-			qcom_rng_dev = NULL;
-			goto fail;
-		}
-	}
-
-	return ret;
-fail:
-	crypto_unregister_rng(&qcom_rng_alg);
+	rng->hwrng.name = "qcom_hwrng";
+	rng->hwrng.init = qcom_hwrng_init;
+	rng->hwrng.read = qcom_hwrng_read;
+	rng->hwrng.cleanup = qcom_hwrng_cleanup;
+	rng->hwrng.quality = QCOM_TRNG_QUALITY;
+	ret = devm_hwrng_register(&pdev->dev, &rng->hwrng);
+	if (ret)
+		dev_err(&pdev->dev, "Register hwrng failed: %d\n", ret);
 	return ret;
 }
 
-static void qcom_rng_remove(struct platform_device *pdev)
-{
-	crypto_unregister_rng(&qcom_rng_alg);
-
-	qcom_rng_dev = NULL;
-}
-
 static struct qcom_rng_match_data qcom_prng_match_data = {
-	.skip_init = false,
 	.hwrng_support = false,
 };
 
 static struct qcom_rng_match_data qcom_prng_ee_match_data = {
-	.skip_init = true,
 	.hwrng_support = false,
 };
 
 static struct qcom_rng_match_data qcom_trng_match_data = {
-	.skip_init = true,
 	.hwrng_support = true,
 };
 
@@ -262,7 +157,6 @@ MODULE_DEVICE_TABLE(of, qcom_rng_of_match);
 
 static struct platform_driver qcom_rng_driver = {
 	.probe = qcom_rng_probe,
-	.remove =  qcom_rng_remove,
 	.driver = {
 		.name = KBUILD_MODNAME,
 		.of_match_table = qcom_rng_of_match,
diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index d8d452cac391..64ea141f018c 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -88,7 +88,8 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	}
 
 	/* actual length may be less than dst buffer */
-	akcipher_req->dst_len = len - sizeof(vc_req->status);
+	akcipher_req->dst_len = min_t(unsigned int, len - sizeof(vc_req->status),
+				      akcipher_req->dst_len);
 	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
 			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 7422d2bc6f37..db56d52411ef 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index f3dff1aea96a..370d98385c93 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
 		}
 		kfree(qp->resp.resources);
 		qp->resp.resources = NULL;
+		qp->resp.res = NULL;
 	}
 }
 
@@ -707,13 +708,24 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
 			roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
 
-		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
-
+		/*
+		 * Not gated by IB_QP_STATE, so the responder task is live.
+		 * Quiesce recv_task like rxe_qp_reset() before swapping the
+		 * rd_atomic array, so rxe_receiver() cannot race the free/
+		 * realloc.
+		 */
+		rxe_disable_task(&qp->recv_task);
 		free_rd_atomic_resources(qp);
-
+		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
+		/*
+		 * On ENOMEM leave recv_task quiesced: qp->resp.resources is
+		 * NULL and rxe_prepare_res()/find_resource() would deref it.
+		 * Re-enable only after a fresh array is installed.
+		 */
 		if (err)
 			return err;
+		rxe_enable_task(&qp->recv_task);
 	}
 
 	if (mask & IB_QP_EN_SQD_ASYNC_NOTIFY)
diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 9a12cc53da00..2f6e77cce385 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -12,6 +12,7 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/skbuff.h>
 #include <linux/udp.h>
 #include <linux/rculist.h>
@@ -108,6 +109,7 @@ struct gtp_net {
 };
 
 static u32 gtp_h_initval;
+static DEFINE_MUTEX(gtp_pdp_lock);
 
 static struct genl_family gtp_genl_family;
 
@@ -151,7 +153,8 @@ static struct pdp_ctx *gtp0_pdp_find(struct gtp_dev *gtp, u64 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp0_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V0 &&
 		    pdp->u.v0.tid == tid)
@@ -168,7 +171,8 @@ static struct pdp_ctx *gtp1_pdp_find(struct gtp_dev *gtp, u32 tid, u16 family)
 
 	head = &gtp->tid_hash[gtp1u_hashfn(tid) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_tid) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_tid,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == family &&
 		    pdp->gtp_version == GTP_V1 &&
 		    pdp->u.v1.i_tei == tid)
@@ -185,7 +189,8 @@ static struct pdp_ctx *ipv4_pdp_find(struct gtp_dev *gtp, __be32 ms_addr)
 
 	head = &gtp->addr_hash[ipv4_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET &&
 		    pdp->ms.addr.s_addr == ms_addr)
 			return pdp;
@@ -220,7 +225,8 @@ static struct pdp_ctx *ipv6_pdp_find(struct gtp_dev *gtp,
 
 	head = &gtp->addr_hash[ipv6_hashfn(ms_addr) % gtp->hash_size];
 
-	hlist_for_each_entry_rcu(pdp, head, hlist_addr) {
+	hlist_for_each_entry_rcu(pdp, head, hlist_addr,
+				 lockdep_is_held(&gtp_pdp_lock)) {
 		if (pdp->af == AF_INET6 &&
 		    ipv6_pdp_addr_equal(&pdp->ms.addr6, ms_addr))
 			return pdp;
@@ -1555,9 +1561,11 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 	struct pdp_ctx *pctx;
 	int i;
 
+	mutex_lock(&gtp_pdp_lock);
 	for (i = 0; i < gtp->hash_size; i++)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
+	mutex_unlock(&gtp_pdp_lock);
 
 	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
@@ -2053,6 +2061,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		goto out_unlock;
 	}
 
+	mutex_lock(&gtp_pdp_lock);
 	pctx = gtp_pdp_add(gtp, sk, info);
 	if (IS_ERR(pctx)) {
 		err = PTR_ERR(pctx);
@@ -2060,6 +2069,7 @@ static int gtp_genl_new_pdp(struct sk_buff *skb, struct genl_info *info)
 		gtp_tunnel_notify(pctx, GTP_CMD_NEWPDP, GFP_KERNEL);
 		err = 0;
 	}
+	mutex_unlock(&gtp_pdp_lock);
 
 out_unlock:
 	rtnl_unlock();
@@ -2134,6 +2144,8 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 	if (!info->attrs[GTPA_VERSION])
 		return -EINVAL;
 
+	mutex_lock(&gtp_pdp_lock);
+
 	rcu_read_lock();
 
 	pctx = gtp_find_pdp(sock_net(skb->sk), info->attrs);
@@ -2154,6 +2166,7 @@ static int gtp_genl_del_pdp(struct sk_buff *skb, struct genl_info *info)
 
 out_unlock:
 	rcu_read_unlock();
+	mutex_unlock(&gtp_pdp_lock);
 	return err;
 }
 
diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 824144bb7774..fbb6ddbb7f89 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -3058,18 +3058,19 @@ vxlan_fdb_flush_match_remotes(struct vxlan_fdb *f, struct vxlan_dev *vxlan,
 			      const struct vxlan_fdb_flush_desc *desc,
 			      bool *p_destroy_fdb)
 {
-	bool remotes_flushed = false;
 	struct vxlan_rdst *rd, *tmp;
 
 	list_for_each_entry_safe(rd, tmp, &f->remotes, list) {
 		if (!vxlan_fdb_flush_remote_matches(desc, rd))
 			continue;
 
+		if (list_is_singular(&f->remotes)) {
+			*p_destroy_fdb = true;
+			return;
+		}
+
 		vxlan_fdb_dst_destroy(vxlan, f, rd, true);
-		remotes_flushed = true;
 	}
-
-	*p_destroy_fdb = remotes_flushed && list_empty(&f->remotes);
 }
 
 /* Purge the forwarding table */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 6b0cd1996ecb..c7a07c727444 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1434,6 +1434,10 @@ int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	if (!wcid)
 		wcid = &dev->mt76.global_wcid;
 
+	err = skb_cow_head(skb, MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE);
+	if (err)
+		return err;
+
 	if (sta) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..dd40798bc248 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -108,6 +108,7 @@ struct nvme_tcp_queue {
 
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		pf_cache_lock;
 	struct llist_head	req_list;
 	struct list_head	send_list;
 
@@ -550,9 +551,11 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
 	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	req->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!req->pdu)
 		return -ENOMEM;
 
@@ -1417,9 +1420,11 @@ static int nvme_tcp_alloc_async_req(struct nvme_tcp_ctrl *ctrl)
 	struct nvme_tcp_request *async = &ctrl->async_req;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 
+	mutex_lock(&queue->pf_cache_lock);
 	async->pdu = page_frag_alloc(&queue->pf_cache,
 		sizeof(struct nvme_tcp_cmd_pdu) + hdgst,
 		GFP_KERNEL | __GFP_ZERO);
+	mutex_unlock(&queue->pf_cache_lock);
 	if (!async->pdu)
 		return -ENOMEM;
 
@@ -1461,6 +1466,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nctrl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	lockdep_unregister_key(&queue->nvme_tcp_sk_key);
@@ -1788,6 +1794,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
+	mutex_init(&queue->pf_cache_lock);
 
 	if (qid > 0)
 		queue->cmnd_capsule_len = nctrl->ioccsz * 16;
@@ -1928,6 +1935,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 err_destroy_mutex:
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->pf_cache_lock);
 	return ret;
 }
 
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index 166dbf4c4061..ab8f81650710 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -690,6 +690,14 @@ static void target_fabric_port_unlink(
 	}
 
 	core_dev_del_lun(se_tpg, lun);
+
+	if (tf->tf_ops->fabric_post_unlink) {
+		/*
+		 * Allow fabrics to release state that must remain valid until
+		 * core_dev_del_lun() has drained all active LUN references.
+		 */
+		tf->tf_ops->fabric_post_unlink(se_tpg, lun);
+	}
 }
 
 static void target_fabric_port_release(struct config_item *item)
diff --git a/drivers/usb/c67x00/c67x00-sched.c b/drivers/usb/c67x00/c67x00-sched.c
index a832f5696f2a..ae6c94f41cb3 100644
--- a/drivers/usb/c67x00/c67x00-sched.c
+++ b/drivers/usb/c67x00/c67x00-sched.c
@@ -761,13 +761,13 @@ static int c67x00_add_iso_urb(struct c67x00_hcd *c67x00, struct urb *urb)
 				ret);
 			urb->iso_frame_desc[urbp->cnt].actual_length = 0;
 			urb->iso_frame_desc[urbp->cnt].status = ret;
-			if (urbp->cnt + 1 == urb->number_of_packets)
-				c67x00_giveback_urb(c67x00, urb, 0);
 		}
 
 		urbp->ep_data->next_frame =
 		    frame_add(urbp->ep_data->next_frame, urb->interval);
 		urbp->cnt++;
+		if (ret && urbp->cnt == urb->number_of_packets)
+			c67x00_giveback_urb(c67x00, urb, 0);
 	}
 	return 0;
 }
diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index e191934623c7..486ced74405e 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1113,7 +1113,6 @@ static int usbdev_release(struct inode *inode, struct file *file)
 	if (!ps->suspend_allowed)
 		usb_autosuspend_device(dev);
 	usb_unlock_device(dev);
-	usb_put_dev(dev);
 	put_pid(ps->disc_pid);
 	put_cred(ps->cred);
 
@@ -1122,6 +1121,7 @@ static int usbdev_release(struct inode *inode, struct file *file)
 		free_async(as);
 		as = async_getcompleted(ps);
 	}
+	usb_put_dev(dev);
 
 	kfree(ps);
 	return 0;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index d92bf887739d..068c7bea3102 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -753,10 +753,12 @@ void usb_wakeup_notification(struct usb_device *hdev,
 {
 	struct usb_hub *hub;
 	struct usb_port *port_dev;
+	unsigned long flags;
 
 	if (!hdev)
 		return;
 
+	spin_lock_irqsave(&device_state_lock, flags);
 	hub = usb_hub_to_struct_hub(hdev);
 	if (hub) {
 		port_dev = hub->ports[portnum - 1];
@@ -766,6 +768,7 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		set_bit(portnum, hub->wakeup_bits);
 		kick_hub_wq(hub);
 	}
+	spin_unlock_irqrestore(&device_state_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_wakeup_notification);
 
@@ -991,10 +994,12 @@ static int hub_hub_status(struct usb_hub *hub,
 
 	mutex_lock(&hub->status_mutex);
 	ret = get_hub_status(hub->hdev, &hub->status->hub);
-	if (ret < 0) {
+	if (ret < (int)sizeof(hub->status->hub)) {
 		if (ret != -ENODEV)
 			dev_err(hub->intfdev,
 				"%s failed (err = %d)\n", __func__, ret);
+		if (ret >= 0)
+			ret = -EIO;
 	} else {
 		*status = le16_to_cpu(hub->status->hub.wHubStatus);
 		*change = le16_to_cpu(hub->status->hub.wHubChange);
diff --git a/drivers/usb/gadget/function/f_tcm.c b/drivers/usb/gadget/function/f_tcm.c
index b3fa5a17fd2d..98414e7611c0 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -2024,7 +2024,7 @@ static const struct target_core_fabric_ops usbg_ops = {
 	.fabric_enable_tpg		= usbg_enable_tpg,
 	.fabric_drop_tpg		= usbg_drop_tpg,
 	.fabric_post_link		= usbg_port_link,
-	.fabric_pre_unlink		= usbg_port_unlink,
+	.fabric_post_unlink		= usbg_port_unlink,
 	.fabric_init_nodeacl		= usbg_init_nodeacl,
 
 	.tfc_wwn_attrs			= usbg_wwn_attrs,
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 2e7384c6b6ec..7e44e62d6ea9 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -628,8 +628,8 @@ int dbc_tty_init(void)
 	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(dbc_tty_driver)) {
-		idr_destroy(&dbc_tty_minors);
-		return PTR_ERR(dbc_tty_driver);
+		ret = PTR_ERR(dbc_tty_driver);
+		goto fail;
 	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
@@ -649,10 +649,17 @@ int dbc_tty_init(void)
 	ret = tty_register_driver(dbc_tty_driver);
 	if (ret) {
 		pr_err("Can't register dbc tty driver\n");
-		tty_driver_kref_put(dbc_tty_driver);
-		idr_destroy(&dbc_tty_minors);
+		goto fail_put;
 	}
 
+	return ret;
+
+fail_put:
+	tty_driver_kref_put(dbc_tty_driver);
+fail:
+	idr_destroy(&dbc_tty_minors);
+	dbc_tty_driver = NULL;
+
 	return ret;
 }
 
diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4f98d8269625..567d7c37a7da 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2025,7 +2025,7 @@ static void handle_port_status(struct xhci_hcd *xhci, union xhci_trb *event)
 		vdev = xhci->devs[port->slot_id];
 
 	/* We might get interrupts after shared_hcd is removed */
-	if (port->rhub == &xhci->usb3_rhub && xhci->shared_hcd == NULL) {
+	if (port->rhub == &xhci->usb3_rhub && xhci_get_usb3_hcd(xhci) == NULL) {
 		xhci_dbg(xhci, "ignore port event for removed USB3 hcd\n");
 		bogus_port_status = true;
 		goto cleanup;
@@ -2600,6 +2600,17 @@ static bool xhci_spurious_success_tx_event(struct xhci_hcd *xhci,
 	}
 }
 
+static struct xhci_td *find_td_by_dma(struct xhci_ring *ep_ring, dma_addr_t dma)
+{
+	struct xhci_td *td;
+
+	if (dma)
+		list_for_each_entry(td, &ep_ring->td_list, td_list)
+			if (trb_in_td(td, dma))
+				return td;
+	return NULL;
+}
+
 /*
  * If this function returns an error condition, it means it got a Transfer
  * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
@@ -2794,8 +2805,11 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 		xhci_dequeue_td(xhci, td, ep_ring, td->status);
 	}
 
-	/* If the TRB pointer is NULL, missed TDs will be skipped on the next event */
-	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb_dma)
+	/*
+	 * We don't know how many TDs were missed when ep_trb_dma is zero (as permitted by
+	 * xHCI 1.0) or bogus. Bail out leaving ep->skip set, next event will sort it out.
+	 */
+	if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !find_td_by_dma(ep_ring, ep_trb_dma))
 		return 0;
 
 	if (list_empty(&ep_ring->td_list)) {
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index 091c82ca8ee2..5c759ad28199 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -5433,6 +5433,7 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	struct device		*dev = hcd->self.sysdev;
 	int			retval;
 	u32			hcs_params1;
+	u32			hc_capbase;
 
 	/* Accept arbitrarily long scatter-gather lists */
 	hcd->self.sg_tablesize = ~0;
@@ -5453,15 +5454,19 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get_quirks_t get_quirks)
 	mutex_init(&xhci->mutex);
 	xhci->main_hcd = hcd;
 	xhci->cap_regs = hcd->regs;
-	xhci->op_regs = hcd->regs +
-		HC_LENGTH(readl(&xhci->cap_regs->hc_capbase));
+	hc_capbase = readl(&xhci->cap_regs->hc_capbase);
+	if (hc_capbase == U32_MAX) {
+		xhci_warn(xhci, "Host controller not accessible, removed?\n");
+		return -ENODEV;
+	}
+	xhci->op_regs = hcd->regs + HC_LENGTH(hc_capbase);
 	xhci->run_regs = hcd->regs +
 		(readl(&xhci->cap_regs->run_regs_off) & RTSOFF_MASK);
 	/* Cache read-only capability registers */
 	hcs_params1 = readl(&xhci->cap_regs->hcs_params1);
 	xhci->hcs_params2 = readl(&xhci->cap_regs->hcs_params2);
 	xhci->hcs_params3 = readl(&xhci->cap_regs->hcs_params3);
-	xhci->hci_version = HC_VERSION(readl(&xhci->cap_regs->hc_capbase));
+	xhci->hci_version = HC_VERSION(hc_capbase);
 	xhci->hcc_params = readl(&xhci->cap_regs->hcc_params);
 	if (xhci->hci_version > 0x100)
 		xhci->hcc_params2 = readl(&xhci->cap_regs->hcc_params2);
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 98071b25ac07..8759df49be28 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -3054,6 +3054,7 @@ static struct usb_driver usbtest_driver = {
 	.disconnect =	usbtest_disconnect,
 	.suspend =	usbtest_suspend,
 	.resume =	usbtest_resume,
+	.no_dynamic_id = 1,
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 580f06f5ce5e..e4ad14375d6a 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2689,12 +2689,26 @@ static void option_instat_callback(struct urb *urb)
 			dev_dbg(dev, "%s: NULL req_pkt\n", __func__);
 			return;
 		}
+
+		if (urb->actual_length < sizeof(*req_pkt)) {
+			dev_err(dev, "%s: short packet: %u bytes\n", __func__,
+				urb->actual_length);
+			return;
+		}
+
 		if ((req_pkt->bRequestType == 0xA1) &&
 				(req_pkt->bRequest == 0x20)) {
+			unsigned char signals;
 			int old_dcd_state;
-			unsigned char signals = *((unsigned char *)
-					urb->transfer_buffer +
-					sizeof(struct usb_ctrlrequest));
+
+			if (urb->actual_length < sizeof(*req_pkt) + 1) {
+				dev_err(dev, "%s: short interrupt transfer: %u bytes\n",
+					__func__, urb->actual_length);
+				return;
+			}
+
+			signals = *((unsigned char *)urb->transfer_buffer +
+					sizeof(*req_pkt));
 
 			dev_dbg(dev, "%s: signal x%x\n", __func__, signals);
 
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index c11d64bf08fb..f610aef6bf59 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -235,18 +235,6 @@ static void spcp8x5_set_work_mode(struct usb_serial_port *port, u16 value,
 		dev_err(&port->dev, "failed to set work mode: %d\n", ret);
 }
 
-static int spcp8x5_carrier_raised(struct usb_serial_port *port)
-{
-	u8 msr;
-	int ret;
-
-	ret = spcp8x5_get_msr(port, &msr);
-	if (ret || msr & MSR_STATUS_LINE_DCD)
-		return 1;
-
-	return 0;
-}
-
 static void spcp8x5_dtr_rts(struct usb_serial_port *port, int on)
 {
 	struct spcp8x5_private *priv = usb_get_serial_port_data(port);
@@ -458,7 +446,6 @@ static struct usb_serial_driver spcp8x5_device = {
 	.num_bulk_out		= 1,
 	.open			= spcp8x5_open,
 	.dtr_rts		= spcp8x5_dtr_rts,
-	.carrier_raised		= spcp8x5_carrier_raised,
 	.set_termios		= spcp8x5_set_termios,
 	.init_termios		= spcp8x5_init_termios,
 	.tiocmget		= spcp8x5_tiocmget,
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 5763a7cd3b37..95df51880db2 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -85,7 +85,13 @@ void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_param *pa
 
 static bool fuse_block_alloc(struct fuse_chan *fch, bool for_background)
 {
-	return !fch->initialized || (for_background && fch->blocked) ||
+	if (!fch->initialized)
+		return true;
+
+	/* Pairs with smp_wmb() in fuse_chan_set_initialized() */
+	smp_rmb();
+
+	return (for_background && fch->blocked) ||
 	       (fch->io_uring && fch->connected && !fuse_uring_ready(fch));
 }
 
@@ -120,9 +126,6 @@ static struct fuse_req *fuse_get_req(struct fuse_chan *fch, bool for_background)
 			goto out;
 	}
 
-	/* Matches smp_wmb() in fuse_chan_set_initialized() */
-	smp_rmb();
-
 	err = -ENOTCONN;
 	if (!fch->connected)
 		goto out;
@@ -240,7 +243,8 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	spin_lock(&fiq->lock);
-	if (list_empty(&req->intr_entry)) {
+	/* Repeat FR_SENT test after obtaining the lock to prevent race with fuse_resend() */
+	if (list_empty(&req->intr_entry) && test_bit(FR_SENT, &req->flags)) {
 		list_add_tail(&req->intr_entry, &fiq->interrupts);
 		/*
 		 * Pairs with smp_mb() implied by test_and_set_bit()
@@ -725,7 +729,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 		if (req->args->abort_on_kill) {
 			fuse_chan_abort(fch, false);
-			return;
+			goto wait_for_finish;
 		}
 
 		if (test_bit(FR_URING, &req->flags))
@@ -736,6 +740,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 	}
 
+wait_for_finish:
 	/*
 	 * Either request is already in userspace, or it was forced.
 	 * Wait it out.
@@ -1760,7 +1765,7 @@ static ssize_t fuse_dev_splice_read(struct file *in, loff_t *ppos,
 void fuse_chan_resend(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
-	struct fuse_req *req, *next;
+	struct fuse_req *req;
 	struct fuse_iqueue *fiq = &fch->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
@@ -1775,24 +1780,20 @@ void fuse_chan_resend(struct fuse_chan *fch)
 		struct fuse_pqueue *fpq = &fud->pq;
 
 		spin_lock(&fpq->lock);
-		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-			list_splice_tail_init(&fpq->processing[i], &to_queue);
+		for (i = 0; i < FUSE_PQ_HASH_SIZE; i++) {
+			struct list_head *this_queue = &fpq->processing[i];
+
+			list_for_each_entry(req, this_queue, list)
+				clear_bit(FR_SENT, &req->flags);
+			list_splice_tail_init(this_queue, &to_queue);
+		}
 		spin_unlock(&fpq->lock);
 	}
 	spin_unlock(&fch->lock);
 
-	list_for_each_entry_safe(req, next, &to_queue, list) {
-		set_bit(FR_PENDING, &req->flags);
-		clear_bit(FR_SENT, &req->flags);
-		/* mark the request as resend request */
-		req->in.h.unique |= FUSE_UNIQUE_RESEND;
-	}
-
 	spin_lock(&fiq->lock);
 	if (!fiq->connected) {
 		spin_unlock(&fiq->lock);
-		list_for_each_entry(req, &to_queue, list)
-			clear_bit(FR_PENDING, &req->flags);
 		fuse_dev_end_requests(&to_queue);
 		return;
 	}
@@ -1801,6 +1802,10 @@ void fuse_chan_resend(struct fuse_chan *fch)
 	 * intr_entry on fiq->interrupts after the request is re-queued.
 	 */
 	list_for_each_entry(req, &to_queue, list) {
+		set_bit(FR_PENDING, &req->flags);
+		/* mark the request as resend request */
+		req->in.h.unique |= FUSE_UNIQUE_RESEND;
+
 		if (test_bit(FR_INTERRUPTED, &req->flags))
 			list_del_init(&req->intr_entry);
 	}
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 77c8cec43d9c..6872266bae1b 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -204,7 +204,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 		return;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 		struct fuse_ring_ent *ent, *next;
 
 		if (!queue)
@@ -223,7 +223,7 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 
 		kfree(queue->fpq.processing);
 		kfree(queue);
-		ring->queues[qid] = NULL;
+		WRITE_ONCE(ring->queues[qid], NULL);
 	}
 
 	kfree(ring->queues);
@@ -321,9 +321,11 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	}
 
 	/*
-	 * write_once and lock as the caller mostly doesn't take the lock at all
+	 * fch->lock serializes concurrent creators for this qid.
+	 * smp_store_release() are for the lockless readers who must see a
+	 * fully initialized queue after &ring->queues[qid] is set
 	 */
-	WRITE_ONCE(ring->queues[qid], queue);
+	smp_store_release(&ring->queues[qid], queue);
 	spin_unlock(&fch->lock);
 
 	return queue;
@@ -434,7 +436,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	struct fuse_ring_ent *ent;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
-		struct fuse_ring_queue *queue = ring->queues[qid];
+		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
 			continue;
@@ -967,7 +969,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (qid >= ring->nr_queues)
 		return -EINVAL;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue)
 		return err;
 	fpq = &queue->fpq;
@@ -1035,7 +1037,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 		if (current_qid == qid)
 			continue;
 
-		queue = ring->queues[qid];
+		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue) {
 			ready = false;
 			break;
@@ -1191,7 +1193,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	if (!queue) {
 		queue = fuse_uring_create_queue(ring, qid);
 		if (!queue)
@@ -1330,7 +1332,7 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 		      ring->nr_queues))
 		qid = 0;
 
-	queue = ring->queues[qid];
+	queue = READ_ONCE(ring->queues[qid]);
 	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
 
 	return queue;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e2a1039fa43..48763bc192f3 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2161,10 +2161,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
-		if (err) {
-			filemap_invalidate_unlock(mapping);
-			return err;
-		}
+		if (err)
+			goto unlock;
 	}
 
 	if (attr->ia_valid & ATTR_OPEN) {
@@ -2191,7 +2189,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 ATTR_TIMES_SET)) {
 		err = write_inode_now(inode, true);
 		if (err)
-			return err;
+			goto unlock;
 
 		fuse_set_nowrite(inode);
 		fuse_release_nowrite(inode);
@@ -2299,6 +2297,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+unlock:
 	if (fault_blocked)
 		filemap_invalidate_unlock(mapping);
 	return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index ceada75310b8..e7b2a839f081 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -272,7 +272,7 @@ static int fuse_open(struct inode *inode, struct file *file)
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
-			goto out_inode_unlock;
+			goto out_unlock;
 	}
 
 	if (is_wb_truncate || dax_truncate)
@@ -296,9 +296,9 @@ static int fuse_open(struct inode *inode, struct file *file)
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+out_unlock:
 	if (dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
-out_inode_unlock:
 	if (is_wb_truncate || dax_truncate)
 		inode_unlock(inode);
 
diff --git a/include/kunit/run-in-irq-context.h b/include/kunit/run-in-irq-context.h
index bfe60d6cf28d..3802b6fb218e 100644
--- a/include/kunit/run-in-irq-context.h
+++ b/include/kunit/run-in-irq-context.h
@@ -38,11 +38,13 @@ static enum hrtimer_restart kunit_irq_test_timer_func(struct hrtimer *timer)
 	softirq_calls = atomic_read(&state->softirq_func_calls);
 
 	/*
-	 * If the timer is firing too often for the softirq or task to ever have
-	 * a chance to run, increase the timer interval.  This is needed on very
-	 * slow systems.
+	 * If the hrtimer is running much faster than the bh_work or the task,
+	 * then it is firing too fast and might be starving those contexts as
+	 * well as the actual system timer tick.  Increase the interval.
 	 */
-	if (hardirq_calls >= 20 && (softirq_calls == 0 || task_calls == 0))
+	if (hardirq_calls >= 20 &&
+	    (hardirq_calls / 2 > softirq_calls ||
+	     hardirq_calls / 2 > task_calls))
 		state->interval = ktime_add_ns(state->interval, 250);
 
 	if (!state->func(state->test_specific_state))
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 22eda1d54a0e..ed6a2bc23db5 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3126,6 +3126,30 @@ static inline void skb_set_transport_header(struct sk_buff *skb,
 	skb->transport_header += offset;
 }
 
+/**
+ * skb_set_transport_header_careful - conditionally set transport header
+ * @skb: buffer to alter
+ * @offset: offset to add to skb->data
+ *
+ * Hardened version of skb_set_transport_header().
+ *
+ * Returns: true if the operation was a success.
+ */
+static inline bool __must_check
+skb_set_transport_header_careful(struct sk_buff *skb, const int offset)
+{
+	long thoff = skb->data - skb->head + offset;
+
+	if (unlikely(thoff != (typeof(skb->transport_header))thoff))
+		return false;
+
+	if (unlikely(thoff == (typeof(skb->transport_header))~0U))
+		return false;
+
+	skb->transport_header = thoff;
+	return true;
+}
+
 static inline unsigned char *skb_network_header(const struct sk_buff *skb)
 {
 	return skb->head + skb->network_header;
diff --git a/include/net/ip.h b/include/net/ip.h
index 7f2fe1a8401b..a8f57b4f4aa2 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -506,6 +506,31 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	return res;
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip_dst_mtu_maybe_forward(), this deliberately ignores the
+ * ICMP-learned path MTU (rt->rt_pmtu).  The advertised MSS bounds what the
+ * peer may send to us and must reflect our receive capability (the device or
+ * route-configured MTU), not a path MTU learned on the reverse (send)
+ * direction, which may not apply to the peer->us path and outlives the fnhe
+ * for the whole connection.  See RFC 2923 section 2.3 and the comment above
+ * tcp_advertise_mss().
+ */
+static inline unsigned int ip_dst_mtu_configured(const struct dst_entry *dst)
+{
+	unsigned int mtu, res;
+
+	rcu_read_lock();
+	mtu = dst_metric_raw(dst, RTAX_MTU);
+	if (!mtu)
+		mtu = READ_ONCE(dst_dev_rcu(dst)->mtu);
+	mtu = min_t(unsigned int, mtu, IP_MAX_MTU);
+	res = mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+	rcu_read_unlock();
+
+	return res;
+}
+
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 09ffe0f13ce7..ac1acc0b7436 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -385,6 +385,43 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
+/* Configured/administrative MTU of a route, for advertising the TCP MSS.
+ *
+ * Unlike ip6_dst_mtu_maybe_forward(), this ignores any ICMPv6-learned path
+ * MTU (which is kept on the RTF_CACHE exception route) and returns the MTU of
+ * the underlying route (fib6_pmtu) or the egress device.  The advertised MSS
+ * bounds what the peer may send to us and must reflect our receive
+ * capability, not a path MTU learned on the reverse (send) direction.  See
+ * RFC 2923 section 2.3 and the comment above tcp_advertise_mss().
+ */
+static inline unsigned int ip6_dst_mtu_configured(const struct dst_entry *dst)
+{
+	const struct rt6_info *rt = dst_rt6_info(dst);
+	const struct fib6_info *from;
+	struct inet6_dev *idev;
+	unsigned int mtu = 0;
+
+	rcu_read_lock();
+	/* IPv6 keeps the learned PMTU and the configured MTU in the same
+	 * RTAX_MTU slot: the learned value sits on this (possibly RTF_CACHE)
+	 * dst, the configured one on the underlying route.  Reach the latter
+	 * via ->from (fib6_pmtu), populated by ip6_route_info_create().
+	 */
+	from = rcu_dereference(rt->from);
+	if (from)
+		mtu = from->fib6_pmtu;
+	if (!mtu) {
+		mtu = IPV6_MIN_MTU;
+		idev = __in6_dev_get(dst_dev_rcu(dst));
+		if (idev)
+			mtu = max_t(unsigned int, mtu, READ_ONCE(idev->cnf.mtu6));
+	}
+	rcu_read_unlock();
+
+	mtu = min_t(unsigned int, mtu, IP6_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
+}
+
 u32 ip6_mtu_from_fib6(const struct fib6_result *res,
 		      const struct in6_addr *daddr,
 		      const struct in6_addr *saddr);
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..670c20876f26 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1782,6 +1782,11 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
+static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
+{
+	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
+}
+
 static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
 {
 	int unused_mem = sk_unused_reserved_mem(sk);
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index e9039e73d058..390ace5bb252 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -95,6 +95,8 @@ struct target_core_fabric_ops {
 				struct se_lun *);
 	void (*fabric_pre_unlink)(struct se_portal_group *,
 				struct se_lun *);
+	void (*fabric_post_unlink)(struct se_portal_group *se_tpg,
+				   struct se_lun *lun);
 	struct se_tpg_np *(*fabric_make_np)(struct se_portal_group *,
 				struct config_group *, const char *);
 	void (*fabric_drop_np)(struct se_tpg_np *);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 78b49b0658ad..8538659acb9e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3650,6 +3650,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
 		error = -EBUSY;
 		goto bad_swap_unlock_inode;
 	}
+	if (IS_ENCRYPTED(inode)) {
+		pr_warn_once(
+			"Filesystem-level encrypted swapfile '%s' is unsupported. Create a loop device over it, or use dm-crypt\n",
+			name->name);
+		error = -EINVAL;
+		goto bad_swap_unlock_inode;
+	}
 
 	/*
 	 * The swap subsystem needs a major overhaul to support this.
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index ec2569b3f8da..2859cbac3f26 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
 	.parse_protocol = vlan_parse_protocol,
 };
 
-static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
-				     unsigned short type,
-				     const void *daddr, const void *saddr,
-				     unsigned int len)
-{
-	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
-	struct net_device *real_dev = vlan->real_dev;
-
-	if (saddr == NULL)
-		saddr = dev->dev_addr;
-
-	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
-}
-
-static const struct header_ops vlan_passthru_header_ops = {
-	.create	 = vlan_passthru_hard_header,
-	.parse	 = eth_header_parse,
-	.parse_protocol = vlan_parse_protocol,
-};
-
 static const struct device_type vlan_type = {
 	.name	= "vlan",
 };
@@ -580,14 +560,10 @@ static int vlan_dev_init(struct net_device *dev)
 	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
 #endif
 
-	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
-		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
-		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
+	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
+	dev->needed_tailroom = real_dev->needed_tailroom;
+	dev->header_ops      = &vlan_header_ops;
+	dev->hard_header_len = real_dev->hard_header_len;
 
 	dev->netdev_ops = &vlan_netdev_ops;
 
@@ -1029,10 +1005,9 @@ static void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
+	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
+	vlandev->needed_tailroom = dev->needed_tailroom;
+	vlandev->hard_header_len = dev->hard_header_len;
 
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
diff --git a/net/batman-adv/tvlv.c b/net/batman-adv/tvlv.c
index 1c9fb21985f6..c384db16bcac 100644
--- a/net/batman-adv/tvlv.c
+++ b/net/batman-adv/tvlv.c
@@ -433,8 +433,11 @@ static int batadv_tvlv_call_handler(struct batadv_priv *bat_priv,
 			return NET_RX_SUCCESS;
 
 		tvlv_offset = (unsigned char *)tvlv_value - skb->data;
+		if (!skb_set_transport_header_careful(skb,
+						      tvlv_offset + tvlv_value_len))
+			return -EINVAL;
+
 		skb_set_network_header(skb, tvlv_offset);
-		skb_set_transport_header(skb, tvlv_offset + tvlv_value_len);
 
 		return tvlv_handler->mcast_handler(bat_priv, skb);
 	}
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 00aa9b2879d6..ec0339e204bd 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4312,8 +4312,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 	if (br_vlan_is_master(vlan)) {
 		br = vlan->br;
 
-		if (!br_vlan_is_brentry(vlan) ||
-		    (on &&
+		if (on &&
+		    (!br_vlan_is_brentry(vlan) ||
 		     br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
 			return;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index b82401a6baed..f07231447883 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1358,8 +1358,8 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 
 	rcu_read_lock();
 	net = dst_dev_net_rcu(dst);
-	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
-				   net->ipv4.ip_rt_min_advmss);
+	advmss = max_t(unsigned int, ip_dst_mtu_configured(dst) - header_size,
+		       net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
 
 	return min(advmss, IPV4_MAX_PMTU - header_size);
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index e4ec60a33496..bb7bbc20ba3f 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1160,6 +1160,15 @@ void tcp_ao_connect_init(struct sock *sk)
 	l3index = l3mdev_master_ifindex_by_index(sock_net(sk),
 						 sk->sk_bound_dev_if);
 
+	hlist_for_each_entry(key, &ao_info->head, node) {
+		if (tcp_ao_key_cmp(key, l3index, addr, key->prefixlen,
+				   family, -1, -1)) {
+			/* pairs with tcp_inbound_ao_hash() */
+			synchronize_rcu();
+			break;
+		}
+	}
+
 	hlist_for_each_entry_safe(key, next, &ao_info->head, node) {
 		if (!tcp_ao_key_cmp(key, l3index, addr, key->prefixlen, family, -1, -1))
 			continue;
@@ -1187,12 +1196,7 @@ void tcp_ao_connect_init(struct sock *sk)
 		ao_info->lisn = htonl(tp->write_seq);
 		ao_info->snd_sne = 0;
 	} else {
-		/* Can't happen: tcp_connect() verifies that there's
-		 * at least one tcp-ao key that matches the remote peer.
-		 */
-		WARN_ON_ONCE(1);
-		rcu_assign_pointer(tp->ao_info, NULL);
-		kfree(ao_info);
+		tcp_ao_destroy_sock(sk, false);
 	}
 }
 
@@ -1825,6 +1829,9 @@ static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
 	if (cmd.ifindex && !(cmd.keyflags & TCP_AO_KEYF_IFINDEX))
 		return -EINVAL;
 
+	if (cmd.keyflags & TCP_AO_KEYF_IFINDEX)
+		l3index = cmd.ifindex;
+
 	ao_info = setsockopt_ao_info(sk);
 	if (IS_ERR(ao_info))
 		return PTR_ERR(ao_info);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7d..497b1a0370cd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1736,7 +1736,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b431..fb901b368ecc 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -440,7 +440,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..7b761edf86ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -143,7 +143,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3972,7 +3972,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -4127,7 +4127,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 76f7a2de9108..c96f7e0d0a48 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -232,26 +232,28 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *des
  *	Rearrange the destination address in @iph and the addresses in @rthdr
  *	so that they appear in the order they will at the final destination.
  *	See Appendix A2 of RFC 2402 for details.
+ *
+ * Return: 0 on success, -EINVAL if segments_left exceeds the number of
+ * addresses described by hdrlen.
  */
-static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
+static int ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 {
-	int segments, segments_left;
+	unsigned int segments, segments_left;
 	struct in6_addr *addrs;
 	struct in6_addr final_addr;
 
 	segments_left = rthdr->segments_left;
 	if (segments_left == 0)
-		return;
-	rthdr->segments_left = 0;
+		return 0;
 
-	/* The value of rthdr->hdrlen has been verified either by the system
-	 * call if it is locally generated, or by ipv6_rthdr_rcv() for incoming
-	 * packets.  So we can assume that it is even and that segments is
-	 * greater than or equal to segments_left.
-	 *
-	 * For the same reason we can assume that this option is of type 0.
+	/* Raw locally generated packets can reach AH6 without the invariant
+	 * required by the rt0-style address rearrangement below.
 	 */
 	segments = rthdr->hdrlen >> 1;
+	if (segments_left > segments)
+		return -EINVAL;
+
+	rthdr->segments_left = 0;
 
 	addrs = ((struct rt0_hdr *)rthdr)->addr;
 	final_addr = addrs[segments - 1];
@@ -261,6 +263,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 
 	addrs[0] = iph->daddr;
 	iph->daddr = final_addr;
+
+	return 0;
 }
 
 static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
@@ -273,6 +277,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 	} exthdr = { .iph = iph };
 	char *end = exthdr.raw + len;
 	int nexthdr = iph->nexthdr;
+	int err;
 
 	exthdr.iph++;
 
@@ -292,7 +297,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 			break;
 
 		case NEXTHDR_ROUTING:
-			ipv6_rearrange_rthdr(iph, exthdr.rth);
+			err = ipv6_rearrange_rthdr(iph, exthdr.rth);
+			if (err)
+				return err;
 			break;
 
 		default:
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 5968ce5ad150..e2056bd0df3c 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3261,7 +3261,7 @@ void ip6_sk_redirect(struct sk_buff *skb, struct sock *sk)
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	unsigned int mtu = dst6_mtu(dst);
+	unsigned int mtu = ip6_dst_mtu_configured(dst);
 	struct net *net;
 
 	mtu -= sizeof(struct ipv6hdr) + sizeof(struct tcphdr);
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 2b41e4c0dddd..95ea0b62729a 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -256,6 +256,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
 	if (iptunnel_pull_offloads(skb))
 		return false;
 
+	if (proto == IPPROTO_IPIP) {
+		int iif = IP6CB(skb)->iif;
+
+		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
+		IPCB(skb)->iif = iif;
+	}
+
 	return true;
 }
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..df9c29eb5c1f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1487,7 +1487,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index af357f6c5070..3a7c8f7a6304 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8715,18 +8715,17 @@ static int nf_tables_delobj(struct sk_buff *skb, const struct nfnl_info *info,
 	return nft_delobj(&ctx, obj);
 }
 
-static void
-__nft_obj_notify(struct net *net, const struct nft_table *table,
-		 struct nft_object *obj, u32 portid, u32 seq, int event,
-		 u16 flags, int family, int report, gfp_t gfp)
+static struct sk_buff *
+nft_obj_notify_alloc(struct net *net, const struct nft_table *table,
+		     struct nft_object *obj, u32 portid, u32 seq, int event,
+		     u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
 	int err;
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
-		return;
+		return NULL;
 
 	skb = nlmsg_new(NLMSG_GOODSIZE, gfp);
 	if (skb == NULL)
@@ -8740,10 +8739,10 @@ __nft_obj_notify(struct net *net, const struct nft_table *table,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, report, &nft_net->notify_list);
-	return;
+	return skb;
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
+	return NULL;
 }
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
@@ -8752,6 +8751,7 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 {
 	char *buf = kasprintf(gfp, "%s:%u",
 			      table->name, nft_base_seq(net));
+	struct sk_buff *skb;
 
 	audit_log_nfcfg(buf,
 			family,
@@ -8762,17 +8762,27 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 			gfp);
 	kfree(buf);
 
-	__nft_obj_notify(net, table, obj, portid, seq, event,
-			 flags, family, report, gfp);
+	/* Called from the packet path, holding no mutex: notify_list is
+	 * serialised by commit_mutex, so send this notification directly.
+	 */
+	skb = nft_obj_notify_alloc(net, table, obj, portid, seq, event,
+				   flags, family, report, gfp);
+	if (skb)
+		nfnetlink_send(skb, net, portid, NFNLGRP_NFTABLES, report, gfp);
 }
 EXPORT_SYMBOL_GPL(nft_obj_notify);
 
 static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
-	__nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid,
-			 ctx->seq, event, ctx->flags, ctx->family,
-			 ctx->report, GFP_KERNEL);
+	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
+	struct sk_buff *skb;
+
+	skb = nft_obj_notify_alloc(ctx->net, ctx->table, obj, ctx->portid,
+				   ctx->seq, event, ctx->flags, ctx->family,
+				   ctx->report, GFP_KERNEL);
+	if (skb)
+		nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 }
 
 /*
diff --git a/net/netfilter/nft_set_pipapo_avx2.c b/net/netfilter/nft_set_pipapo_avx2.c
index b3f105520a85..21f5be68c703 100644
--- a/net/netfilter/nft_set_pipapo_avx2.c
+++ b/net/netfilter/nft_set_pipapo_avx2.c
@@ -1134,6 +1134,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 	struct nft_pipapo_scratch *scratch;
 	const struct nft_pipapo_field *f;
 	unsigned long *res, *fill, *map;
+	struct nft_pipapo_elem *e;
 	bool map_index;
 	int ret = 0;
 	int i;
@@ -1207,14 +1208,11 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 next_match:
 		if (ret < 0) {
 			scratch->map_index = map_index;
-			kernel_fpu_end();
-			__local_unlock_nested_bh(&scratch->bh_lock);
-			return NULL;
+			e = NULL;
+			goto out;
 		}
 
 		if (last) {
-			struct nft_pipapo_elem *e;
-
 			e = f->mt[ret].e;
 			if (unlikely(__nft_set_elem_expired(&e->ext, tstamp) ||
 				     !nft_set_elem_active(&e->ext, genmask))) {
@@ -1224,9 +1222,7 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 			}
 
 			scratch->map_index = map_index;
-			kernel_fpu_end();
-			__local_unlock_nested_bh(&scratch->bh_lock);
-			return e;
+			goto out;
 		}
 
 		map_index = !map_index;
@@ -1234,9 +1230,12 @@ struct nft_pipapo_elem *pipapo_get_avx2(const struct nft_pipapo_match *m,
 		data += NFT_PIPAPO_GROUPS_PADDED_SIZE(f);
 	}
 
+	e = NULL;
+out:
+	asm volatile("vzeroupper");
 	kernel_fpu_end();
 	__local_unlock_nested_bh(&scratch->bh_lock);
-	return NULL;
+	return e;
 }
 
 /**
diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 1168bd6b09cd..b22cda322136 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -88,6 +88,7 @@
 #include <linux/errqueue.h>
 #include <linux/net_tstamp.h>
 #include <linux/percpu.h>
+#include <linux/workqueue.h>
 #ifdef CONFIG_INET
 #include <net/inet_common.h>
 #endif
@@ -1341,6 +1342,8 @@ static void packet_sock_destruct(struct sock *sk)
 	WARN_ON(atomic_read(&sk->sk_rmem_alloc));
 	WARN_ON(refcount_read(&sk->sk_wmem_alloc));
 
+	packet_free_pending(pkt_sk(sk));
+
 	if (!sock_flag(sk, SOCK_DEAD)) {
 		pr_err("Attempt to release alive packet socket: %p\n", sk);
 		return;
@@ -2534,11 +2537,11 @@ static void tpacket_destruct_skb(struct sk_buff *skb)
 		__u32 ts;
 
 		ph = skb_zcopy_get_nouarg(skb);
-		packet_dec_pending(&po->tx_ring);
 
 		ts = __packet_set_timestamp(po, ph, skb);
 		__packet_set_status(po, ph, TP_STATUS_AVAILABLE | ts);
 
+		packet_dec_pending(&po->tx_ring);
 		complete(&po->skb_completion);
 	}
 
@@ -3207,7 +3210,6 @@ static int packet_release(struct socket *sock)
 	/* Purge queues */
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	packet_free_pending(po);
 
 	sock_put(sk);
 	return 0;
@@ -4370,11 +4372,26 @@ static const struct vm_operations_struct packet_mmap_ops = {
 	.close	=	packet_mm_close,
 };
 
+struct packet_pg_vec {
+	struct packet_pg_vec_free *deferred;
+	unsigned int order;
+	unsigned int len;
+	struct pgv pg_vec[] __counted_by(len);
+};
+
+struct packet_pg_vec_free {
+	struct delayed_work work;
+	struct sock *sk;
+	struct packet_pg_vec *vec;
+};
+
 static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			unsigned int len)
 {
+	struct packet_pg_vec *vec;
 	int i;
 
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
 	for (i = 0; i < len; i++) {
 		if (likely(pg_vec[i].buffer)) {
 			if (is_vmalloc_addr(pg_vec[i].buffer))
@@ -4385,7 +4402,46 @@ static void free_pg_vec(struct pgv *pg_vec, unsigned int order,
 			pg_vec[i].buffer = NULL;
 		}
 	}
-	kfree(pg_vec);
+	kfree(vec->deferred);
+	kfree(vec);
+}
+
+static void packet_free_pg_vec_work(struct work_struct *work)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+	struct sock *sk;
+
+	deferred = container_of_const(to_delayed_work(work),
+				      struct packet_pg_vec_free, work);
+	vec = deferred->vec;
+	sk = deferred->sk;
+	if (sk_wmem_alloc_get(sk)) {
+		queue_delayed_work(system_long_wq, &deferred->work, 1);
+		return;
+	}
+
+	free_pg_vec(vec->pg_vec, vec->order, vec->len);
+	sock_put(sk);
+}
+
+static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
+				unsigned int order, unsigned int len)
+{
+	struct packet_pg_vec_free *deferred;
+	struct packet_pg_vec *vec;
+
+	vec = container_of_const(pg_vec, struct packet_pg_vec, pg_vec[0]);
+	deferred = vec->deferred;
+	if (!deferred || !sk_wmem_alloc_get(sk)) {
+		free_pg_vec(pg_vec, order, len);
+		return;
+	}
+
+	/* A detached ring's pending count can miss late skb destructors. */
+	deferred->sk = sk;
+	sock_hold(sk);
+	queue_delayed_work(system_long_wq, &deferred->work, 0);
 }
 
 static char *alloc_one_pg_vec_page(unsigned long order)
@@ -4413,20 +4469,35 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 	return NULL;
 }
 
-static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order)
+static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring)
 {
 	unsigned int block_nr = req->tp_block_nr;
+	struct packet_pg_vec *vec;
 	struct pgv *pg_vec;
 	int i;
 
-	pg_vec = kzalloc_objs(struct pgv, block_nr, GFP_KERNEL | __GFP_NOWARN);
-	if (unlikely(!pg_vec))
-		goto out;
+	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
+	if (unlikely(!vec))
+		return NULL;
+	vec->order = order;
+	vec->len = block_nr;
+	pg_vec = vec->pg_vec;
 
 	for (i = 0; i < block_nr; i++) {
 		pg_vec[i].buffer = alloc_one_pg_vec_page(order);
 		if (unlikely(!pg_vec[i].buffer))
 			goto out_free_pgvec;
+
+		if (tx_ring && !vec->deferred &&
+		    is_vmalloc_addr(pg_vec[i].buffer)) {
+			vec->deferred = kzalloc_obj(*vec->deferred,
+						    GFP_KERNEL | __GFP_NOWARN);
+			if (!vec->deferred)
+				goto out_free_pgvec;
+			vec->deferred->vec = vec;
+			INIT_DELAYED_WORK(&vec->deferred->work,
+					  packet_free_pg_vec_work);
+		}
 	}
 
 out:
@@ -4509,7 +4580,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 
 		err = -ENOMEM;
 		order = get_order(req->tp_block_size);
-		pg_vec = alloc_pg_vec(req, order);
+		pg_vec = alloc_pg_vec(req, order, tx_ring);
 		if (unlikely(!pg_vec))
 			goto out;
 		switch (po->tp_version) {
@@ -4561,6 +4632,9 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 	err = -EBUSY;
 	mutex_lock(&po->pg_vec_lock);
 	if (closing || atomic_long_read(&po->mapped) == 0) {
+		if (tx_ring && !closing && packet_read_pending(rb))
+			goto out_unlock;
+
 		err = 0;
 		spin_lock_bh(&rb_queue->lock);
 		swap(rb->pg_vec, pg_vec);
@@ -4582,6 +4656,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 			pr_err("packet_mmap: vma is busy: %ld\n",
 			       atomic_long_read(&po->mapped));
 	}
+out_unlock:
 	mutex_unlock(&po->pg_vec_lock);
 
 	spin_lock(&po->bind_lock);
@@ -4603,7 +4678,10 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 out_free_pg_vec:
 	if (pg_vec) {
 		bitmap_free(rx_owner_map);
-		free_pg_vec(pg_vec, order, req->tp_block_nr);
+		if (tx_ring && closing)
+			packet_free_tx_ring(sk, pg_vec, order, req->tp_block_nr);
+		else
+			free_pg_vec(pg_vec, order, req->tp_block_nr);
 	}
 out:
 	return err;
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index 37bb06a8e8f5..f11d0528fc43 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -531,7 +531,8 @@ static int tls_push_data(struct sock *sk,
 		if (!size) {
 last_record:
 			tls_push_record_flags = flags;
-			if (flags & MSG_MORE) {
+			if ((flags & MSG_MORE) &&
+			    record->num_frags < MAX_SKB_FRAGS - 1) {
 				more = true;
 				break;
 			}
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 374e1b964438..674aedc5af5a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -37,6 +37,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
 	rcu_read_lock();
 	skb->dev = dev_get_by_index_rcu(sock_net(sk), skb->skb_iif);
+	if (!skb->dev) {
+		XFRM_INC_STATS(sock_net(sk), LINUX_MIB_XFRMINERROR);
+		kfree_skb(skb);
+		goto out;
+	}
 	local_bh_disable();
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6)
@@ -45,6 +50,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
@@ -515,7 +521,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	strp_stop(&ctx->strp);
 
 	sk->sk_prot = &tcp_prot;
-	barrier();
+
+	synchronize_rcu();
 
 	disable_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index eb1b6f67739e..5cd6d43164db 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -155,25 +155,50 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 	}
 }
 
+enum {
+	NAT_KEEPALIVE_BATCH_SIZE = 16,
+	NAT_KEEPALIVE_BATCH_FULL = 1,
+};
+
 struct nat_keepalive_work_ctx {
+	struct xfrm_state *batch[NAT_KEEPALIVE_BATCH_SIZE];
+	unsigned int nr;
 	time64_t next_run;
 	time64_t now;
 };
 
-static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
+static int nat_keepalive_work_collect(struct xfrm_state *x, int count, void *ptr)
 {
 	struct nat_keepalive_work_ctx *ctx = ptr;
+
+	if (!READ_ONCE(x->nat_keepalive_interval))
+		return 0;
+
+	if (ctx->nr == ARRAY_SIZE(ctx->batch))
+		return NAT_KEEPALIVE_BATCH_FULL;
+
+	xfrm_state_hold(x);
+	ctx->batch[ctx->nr++] = x;
+	return 0;
+}
+
+static void nat_keepalive_work_single(struct xfrm_state *x,
+				      struct nat_keepalive_work_ctx *ctx)
+{
 	bool send_keepalive = false;
 	struct nat_keepalive ka;
-	time64_t next_run;
+	time64_t next_run = 0;
 	u32 interval;
 	int delta;
 
+	spin_lock_bh(&x->lock);
+
+	if (x->km.state == XFRM_STATE_DEAD)
+		goto out;
+
 	interval = x->nat_keepalive_interval;
 	if (!interval)
-		return 0;
-
-	spin_lock(&x->lock);
+		goto out;
 
 	delta = (int)(ctx->now - x->lastused);
 	if (delta < interval) {
@@ -187,14 +212,14 @@ static int nat_keepalive_work_single(struct xfrm_state *x, int count, void *ptr)
 		send_keepalive = true;
 	}
 
-	spin_unlock(&x->lock);
+out:
+	spin_unlock_bh(&x->lock);
 
 	if (send_keepalive)
 		nat_keepalive_send(&ka);
 
-	if (!ctx->next_run || next_run < ctx->next_run)
+	if (next_run && (!ctx->next_run || next_run < ctx->next_run))
 		ctx->next_run = next_run;
-	return 0;
 }
 
 static void nat_keepalive_work(struct work_struct *work)
@@ -202,13 +227,23 @@ static void nat_keepalive_work(struct work_struct *work)
 	struct nat_keepalive_work_ctx ctx;
 	struct xfrm_state_walk walk;
 	struct net *net;
+	int err, i;
 
 	ctx.next_run = 0;
 	ctx.now = ktime_get_real_seconds();
 
 	net = container_of(work, struct net, xfrm.nat_keepalive_work.work);
 	xfrm_state_walk_init(&walk, IPPROTO_ESP, NULL);
-	xfrm_state_walk(net, &walk, nat_keepalive_work_single, &ctx);
+	do {
+		ctx.nr = 0;
+		err = xfrm_state_walk(net, &walk, nat_keepalive_work_collect, &ctx);
+		local_bh_disable();
+		for (i = 0; i < ctx.nr; i++) {
+			nat_keepalive_work_single(ctx.batch[i], &ctx);
+			xfrm_state_put(ctx.batch[i]);
+		}
+		local_bh_enable();
+	} while (err == NAT_KEEPALIVE_BATCH_FULL);
 	xfrm_state_walk_done(&walk, net);
 	if (ctx.next_run)
 		schedule_delayed_work(&net->xfrm.nat_keepalive_work,
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index d6db63304ba6..6266a92cf302 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -940,7 +940,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
 				     attrs[XFRMA_ALG_AUTH_TRUNC], extack)))
 		goto error;
-	if (!x->props.aalgo) {
+	if (!x->aalg) {
 		if ((err = attach_auth(&x->aalg, &x->props.aalgo,
 				       attrs[XFRMA_ALG_AUTH], extack)))
 			goto error;
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 6a3b576fb067..8b9d2ebf1809 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1276,8 +1276,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 
 	list_for_each_entry(as, &chip->pcm_list, list) {
 		err = snd_usb_pcm_resume(as);
-		if (err < 0)
-			goto err_out;
+		if (err < 0) {
+			if (!chip->system_suspend)
+				goto err_out;
+			goto out;
+		}
 	}
 
 	/*
@@ -1286,8 +1289,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 	 */
 	list_for_each_entry(mixer, &chip->mixer_list, list) {
 		err = snd_usb_mixer_resume(mixer);
-		if (err < 0)
-			goto err_out;
+		if (err < 0) {
+			if (!chip->system_suspend)
+				goto err_out;
+			goto out;
+		}
 	}
 
 	list_for_each(p, &chip->midi_list) {
diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index f8996416c3be..8a9bc37f0b6e 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -875,6 +875,8 @@ static void snd_usbmidi_novation_output(struct snd_usb_midi_out_endpoint *ep,
 
 	if (!ep->ports[0].active)
 		return;
+	if (ep->max_transfer < 3)
+		return;
 	transfer_buffer = urb->transfer_buffer;
 	count = snd_rawmidi_transmit(ep->ports[0].substream,
 				     &transfer_buffer[2],
diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 71444c2898b4..9a28d7c6d923 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -2692,6 +2692,7 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 			{
 				QUIRK_DATA_AUDIOFORMAT(2) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 2,
 					.iface = 2,
 					.altsetting = 1,
@@ -2703,11 +2704,16 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
 					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					},
 				}
 			},
 			{
 				QUIRK_DATA_AUDIOFORMAT(3) {
 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
+					.fmt_bits = 24,
 					.channels = 2,
 					.iface = 3,
 					.altsetting = 1,
@@ -2719,6 +2725,10 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 						 SNDRV_PCM_RATE_48000,
 					.rate_min = 44100,
 					.rate_max = 48000,
+					.nr_rates = 2,
+					.rate_table = (unsigned int[]) {
+						44100, 48000
+					},
 				}
 			},
 			QUIRK_COMPOSITE_END
diff --git a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
index 0660f29dca95..3177bc5b733a 100644
--- a/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
+++ b/tools/testing/selftests/bpf/progs/sockmap_verdict_prog.c
@@ -44,8 +44,18 @@ int bpf_prog2(struct __sk_buff *skb)
 	__sink(lport);
 	__sink(rport);
 
-	if (data + 8 > data_end)
-		return SK_DROP;
+	if (data + 8 > data_end) {
+		if (bpf_skb_pull_data(skb, 8))
+			return SK_DROP;
+
+		data = (void *)(long)skb->data;
+		data_end = (void *)(long)skb->data_end;
+
+		if (data + 8 > data_end)
+			return SK_DROP;
+
+		d = data;
+	}
 
 	map = d[0];
 	sk = d[1];
