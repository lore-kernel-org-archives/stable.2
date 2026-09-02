Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8C390CB7;
	Wed,  2 Sep 2026 12:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788352918; cv=none; b=p6JWJ8Ked8md8DMEzp0cQrYJRhupGuLjwMgLvAz/xStjEbNUy530FQaYXsFtDCKEd0Ke8SimYst2INUZGosnsXcK/gKLlbSCRf/wiV+d51fkd3FuHLVqOtKN821fh9YwjkuwRqXuxox0HkZBbz+iH52iVQeJdQCxyHQjEpxWucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788352918; c=relaxed/simple;
	bh=ZrNuCMBELaU83q6hNahWEBTSllal99NV9E1aUbv/aM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohGyD9r1P87sBb5NzPmSORAKggbDFq9iSXm75vBX/7u7q5IB06uKcFE3NG60/yu5M4d6QHf4+SAKsvkzbYWWupaI7+B+FYGPc7eYhBGQxy+VLPdNJ1AfpAT4cK6wu526mqAB9EhOTyJ7mcClY7cGsGeAyKzn69rnZXTSImY3aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EecrKaZW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EecrKaZW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD911F000E9;
	Wed,  2 Sep 2026 12:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788352909;
	bh=uATcEbsfJLxoOUApK1t9WPjdLdaaM4ji7hQa+unCnJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EecrKaZWPyFxs/WNWxJPYsZ2ZJxe4K9+CUDdsSSSeXXuXCs0WfOi4RzTgTT2zPIOO
	 A1G4heTZkdDEX9whJsT9XEs307f3qvJr06niXc5NaHa/Y5b27DY86u2EmTiqVCDXaS
	 UF2NBuAD6uwexDvzhzkrXO2LHvVrBj8EDj+VDpn4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.15.220
Date: Wed,  2 Sep 2026 14:41:35 +0200
Message-ID: <2026090235-sizzle-oat-27d5@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026090235-gear-alabaster-a24c@gregkh>
References: <2026090235-gear-alabaster-a24c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Documentation/filesystems/fscrypt.rst b/Documentation/filesystems/fscrypt.rst
index 7940a45d3952..d39abc884352 100644
--- a/Documentation/filesystems/fscrypt.rst
+++ b/Documentation/filesystems/fscrypt.rst
@@ -1063,6 +1063,10 @@ astute users may notice some differences in behavior:
 
 - DAX (Direct Access) is not supported on encrypted files.
 
+- Encrypted files cannot be used directly as swap files.  To swap to
+  an encrypted file, set up a loopback device on top of it.
+  Alternatively, encrypted swap can use a dm-crypt device.
+
 - The maximum length of an encrypted symlink is 2 bytes shorter than
   the maximum length of an unencrypted symlink.  For example, on an
   EXT4 filesystem with a 4K block size, unencrypted symlinks can be up
diff --git a/Makefile b/Makefile
index d74985973e40..a0301cb41ba6 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 15
-SUBLEVEL = 219
+SUBLEVEL = 220
 EXTRAVERSION =
 NAME = Trick or Treat
 
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 5ca8782edb96..ca69ae7f86d7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1313,6 +1313,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_GET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (kvm_arm_vcpu_get_events(vcpu, &events))
 			return -EINVAL;
 
@@ -1324,6 +1327,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_VCPU_EVENTS: {
 		struct kvm_vcpu_events events;
 
+		if (!kvm_vcpu_initialized(vcpu))
+			return -ENOEXEC;
+
 		if (copy_from_user(&events, argp, sizeof(events)))
 			return -EFAULT;
 
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index b95677c4855a..6da03eaae925 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -145,6 +145,7 @@ static int setup_apcb10(struct kvm_vcpu *vcpu, struct kvm_s390_apcb1 *apcb_s,
 	if (read_guest_real(vcpu, apcb_o, &tmp, sizeof(struct kvm_s390_apcb0)))
 		return -EFAULT;
 
+	memset(apcb_s, 0, sizeof(*apcb_s));
 	apcb_s->apm[0] = apcb_h->apm[0] & tmp.apm[0];
 	apcb_s->aqm[0] = apcb_h->aqm[0] & tmp.aqm[0] & 0xffff000000000000UL;
 	apcb_s->adm[0] = apcb_h->adm[0] & tmp.adm[0] & 0xffff000000000000UL;
diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 3c3e91114164..088357a3ecc3 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -2430,6 +2430,7 @@ static int __init speakup_init(void)
 	mutex_lock(&spk_mutex);
 	synth_release();
 	mutex_unlock(&spk_mutex);
+	spk_ttyio_unregister_ldisc();
 	speakup_kobj_exit();
 
 error_kobjects:
diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 3d3e710f7173..9cd0a837af42 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -102,7 +102,7 @@ void device_pm_sleep_init(struct device *dev)
 	dev->power.is_noirq_suspended = false;
 	dev->power.is_late_suspended = false;
 	init_completion(&dev->power.completion);
-	complete(&dev->power.completion);
+	complete_all(&dev->power.completion);
 	dev->power.wakeup = NULL;
 	INIT_LIST_HEAD(&dev->power.entry);
 }
@@ -239,10 +239,6 @@ static void dpm_wait(struct device *dev, bool async)
 	if (!dev)
 		return;
 
-	/* Devices with no PM support don't use the completion. */
-	if (dev->power.no_pm)
-		return;
-
 	if (async || (pm_async_enabled && dev->power.async_suspend))
 		wait_for_completion(&dev->power.completion);
 }
diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 2c51b427d0b6..a44ea6fec000 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -499,14 +499,13 @@ static int atmel_tdes_crypt_start(struct atmel_tdes_dev *dd)
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
diff --git a/drivers/crypto/mxs-dcp.c b/drivers/crypto/mxs-dcp.c
index d6f9e2fe863d..702ab2c6c38e 100644
--- a/drivers/crypto/mxs-dcp.c
+++ b/drivers/crypto/mxs-dcp.c
@@ -333,7 +333,7 @@ static int mxs_dcp_aes_block_crypt(struct crypto_async_request *arq)
 
 	for_each_sg(req->src, src, sg_nents(req->src), i) {
 		src_buf = sg_virt(src);
-		len = sg_dma_len(src);
+		len = src->length;
 		tlen += len;
 		limit_hit = tlen > req->cryptlen;
 
diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 6f766bbb8cbb..db5d52f420cd 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -8,8 +8,6 @@
 #include <crypto/gcm.h>
 #include <crypto/authenc.h>
 #include <crypto/internal/aead.h>
-#include <crypto/internal/des.h>
-#include <crypto/sha1.h>
 #include <crypto/sha2.h>
 #include <crypto/scatterwalk.h>
 #include "aead.h"
@@ -203,7 +201,7 @@ qce_aead_ccm_prepare_buf_assoclen(struct aead_request *req)
 	/* Get the msg */
 	msg_sg = scatterwalk_ffwd(__sg, req->src, req->assoclen);
 
-	rctx->adata = kzalloc((ALIGN(assoclen, 16) + MAX_CCM_ADATA_HEADER_LEN) *
+	rctx->adata = kzalloc(ALIGN(assoclen + MAX_CCM_ADATA_HEADER_LEN, 16) *
 			       sizeof(unsigned char), GFP_ATOMIC);
 	if (!rctx->adata)
 		return -ENOMEM;
@@ -597,7 +595,6 @@ static int qce_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct crypto_authenc_keys authenc_keys;
 	unsigned long flags = to_aead_tmpl(tfm)->alg_flags;
-	u32 _key[6];
 	int err;
 
 	err = crypto_authenc_extractkeys(&authenc_keys, key, keylen);
@@ -608,26 +605,7 @@ static int qce_aead_setkey(struct crypto_aead *tfm, const u8 *key, unsigned int
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
@@ -698,38 +676,6 @@ struct qce_aead_def {
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
index 7c612ba5068f..f328a68a5448 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -7,7 +7,6 @@
 #include <linux/interrupt.h>
 #include <linux/types.h>
 #include <crypto/scatterwalk.h>
-#include <crypto/sha1.h>
 #include <crypto/sha2.h>
 
 #include "cipher.h"
@@ -114,18 +113,16 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size, u32 auth_size)
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
@@ -190,7 +187,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 	else
 		qce_cpu_to_be32p_array(auth, rctx->digest, digestsize);
 
-	iv_words = (IS_SHA1(rctx->flags) || IS_SHA1_HMAC(rctx->flags)) ? 5 : 8;
+	iv_words = 8;
 	qce_write_array(qce, REG_AUTH_IV0, (u32 *)auth, iv_words);
 
 	if (rctx->first_blk)
@@ -242,19 +239,8 @@ static u32 qce_encr_cfg(unsigned long flags, u32 aes_key_size)
 
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
@@ -339,13 +325,7 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 
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
@@ -356,14 +336,12 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 
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
@@ -392,10 +370,6 @@ static int qce_setup_regs_skcipher(struct crypto_async_request *async_req)
 #endif
 
 #ifdef CONFIG_CRYPTO_DEV_QCE_AEAD
-static const u32 std_iv_sha1[SHA256_DIGEST_SIZE / sizeof(u32)] = {
-	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4, 0, 0, 0
-};
-
 static const u32 std_iv_sha256[SHA256_DIGEST_SIZE / sizeof(u32)] = {
 	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7
@@ -472,13 +446,8 @@ static int qce_setup_regs_aead(struct crypto_async_request *async_req)
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
index 18b15970e408..59dcf183679a 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -24,10 +24,6 @@ struct qce_sha_saved_state {
 
 static LIST_HEAD(ahash_algs);
 
-static const u32 std_iv_sha1[SHA256_DIGEST_SIZE / sizeof(u32)] = {
-	SHA1_H0, SHA1_H1, SHA1_H2, SHA1_H3, SHA1_H4, 0, 0, 0
-};
-
 static const u32 std_iv_sha256[SHA256_DIGEST_SIZE / sizeof(u32)] = {
 	SHA256_H0, SHA256_H1, SHA256_H2, SHA256_H3,
 	SHA256_H4, SHA256_H5, SHA256_H6, SHA256_H7
@@ -346,9 +342,7 @@ static int qce_ahash_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 		return 0;
 	}
 
-	if (digestsize == SHA1_DIGEST_SIZE)
-		alg_name = "sha1-qce";
-	else if (digestsize == SHA256_DIGEST_SIZE)
+	if (digestsize == SHA256_DIGEST_SIZE)
 		alg_name = "sha256-qce";
 	else
 		return -EINVAL;
@@ -409,15 +403,6 @@ struct qce_ahash_def {
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
@@ -427,15 +412,6 @@ static const struct qce_ahash_def ahash_def[] = {
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
@@ -473,9 +449,7 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
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
index 4eff380dc45e..7ac2eb3d5aa5 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -10,7 +10,6 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <crypto/aes.h>
-#include <crypto/internal/des.h>
 #include <crypto/internal/skcipher.h>
 
 #include "cipher.h"
@@ -208,51 +207,6 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
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
@@ -275,7 +229,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * ECB and CBC algorithms require message lengths to be
 	 * multiples of block size.
 	 */
-	if (IS_ECB(rctx->flags) || IS_CBC(rctx->flags))
+	if (IS_CBC(rctx->flags))
 		if (!IS_ALIGNED(req->cryptlen, blocksize))
 			return -EINVAL;
 
@@ -358,15 +312,6 @@ struct qce_skcipher_def {
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
@@ -395,42 +340,6 @@ static const struct qce_skcipher_def skcipher_def[] = {
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
 
diff --git a/drivers/fpga/dfl-fme-perf.c b/drivers/fpga/dfl-fme-perf.c
index 587c82be12f7..17231c44d059 100644
--- a/drivers/fpga/dfl-fme-perf.c
+++ b/drivers/fpga/dfl-fme-perf.c
@@ -925,6 +925,8 @@ static int fme_perf_pmu_register(struct platform_device *pdev,
 				PERF_PMU_CAP_NO_EXCLUDE;
 
 	name = devm_kasprintf(priv->dev, GFP_KERNEL, "dfl_fme%d", pdev->id);
+	if (!name)
+		return -ENOMEM;
 
 	ret = perf_pmu_register(pmu, name, -1);
 	if (ret)
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 183eeb3863b3..e878f8b842d0 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -30,12 +30,21 @@ MODULE_PARM_DESC(debug, "Toggle FT260 debugging messages");
 
 #define FT260_REPORT_MAX_LENGTH (64)
 #define FT260_I2C_DATA_REPORT_ID(len) (FT260_I2C_REPORT_MIN + (len - 1) / 4)
+
+#define FT260_WAKEUP_NEEDED_AFTER_MS (4800) /* 5s minus 200ms margin */
+
 /*
- * The input report format assigns 62 bytes for the data payload, but ft260
- * returns 60 and 2 in two separate transactions. To minimize transfer time
- * in reading chunks mode, set the maximum read payload length to 60 bytes.
- */
-#define FT260_RD_DATA_MAX (60)
+ * The ft260 input report format defines 62 bytes for the data payload, but
+ * when requested 62 bytes, the controller returns 60 and 2 in separate input
+ * reports. To achieve better performance with the multi-report read data
+ * transfers, we set the maximum read payload length to a multiple of 60.
+ * With a 100 kHz I2C clock, one 240 bytes read takes about 1/27 second,
+ * which is excessive; On the other hand, some higher layer drivers like at24
+ * or optoe limit the i2c reads to 128 bytes. To not block other drivers out
+ * of I2C for potentially troublesome amounts of time, we select the maximum
+ * read payload length to be 180 bytes.
+*/
+#define FT260_RD_DATA_MAX (180)
 #define FT260_WR_DATA_MAX (60)
 
 /*
@@ -230,6 +239,9 @@ struct ft260_device {
 	struct completion wait;
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
+	unsigned long need_wakeup_at;
+	/* Protects read_buf, read_idx and read_len against ft260_raw_event() */
+	spinlock_t read_lock;
 	u8 *read_buf;
 	u16 read_idx;
 	u16 read_len;
@@ -293,12 +305,26 @@ static int ft260_i2c_reset(struct hid_device *hdev)
 	return ret;
 }
 
-static int ft260_xfer_status(struct ft260_device *dev)
+static int ft260_xfer_status(struct ft260_device *dev, u8 bus_busy)
 {
 	struct hid_device *hdev = dev->hdev;
 	struct ft260_get_i2c_status_report report;
 	int ret;
 
+	if (time_is_before_jiffies(dev->need_wakeup_at)) {
+		ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
+						(u8 *)&report, sizeof(report));
+		if (unlikely(ret < 0)) {
+			hid_err(hdev, "failed to retrieve status: %d, no wakeup\n",
+				ret);
+		} else {
+			dev->need_wakeup_at = jiffies +
+				msecs_to_jiffies(FT260_WAKEUP_NEEDED_AFTER_MS);
+			ft260_dbg("bus_status %#02x, wakeup\n",
+				  report.bus_status);
+		}
+	}
+
 	ret = ft260_hid_feature_report_get(hdev, FT260_I2C_STATUS,
 					   (u8 *)&report, sizeof(report));
 	if (unlikely(ret < 0)) {
@@ -310,7 +336,7 @@ static int ft260_xfer_status(struct ft260_device *dev)
 	ft260_dbg("bus_status %#02x, clock %u\n", report.bus_status,
 		  dev->clock);
 
-	if (report.bus_status & FT260_I2C_STATUS_CTRL_BUSY)
+	if (report.bus_status & (FT260_I2C_STATUS_CTRL_BUSY | bus_busy))
 		return -EAGAIN;
 
 	if (report.bus_status & FT260_I2C_STATUS_BUS_BUSY)
@@ -355,8 +381,11 @@ static int ft260_hid_output_report(struct hid_device *hdev, u8 *data,
 static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 						u8 *data, int len)
 {
-	int ret, usec, try = 3;
+	u8 bus_busy;
+	int ret, usec, try = 100;
 	struct hid_device *hdev = dev->hdev;
+	struct ft260_i2c_write_request_report *rep =
+		(struct ft260_i2c_write_request_report *)data;
 
 	ret = ft260_hid_output_report(hdev, data, len);
 	if (ret < 0) {
@@ -366,12 +395,26 @@ static int ft260_hid_output_report_check_status(struct ft260_device *dev,
 		return ret;
 	}
 
-	/* transfer time = 1 / clock(KHz) * 10 bits * bytes */
-	usec = 10000 / dev->clock * len;
-	usleep_range(usec, usec + 100);
-	ft260_dbg("wait %d usec, len %d\n", usec, len);
+	/* transfer time = 1 / clock(KHz) * 9 bits * bytes */
+	usec = len * 9000 / dev->clock;
+	if (usec > 2000) {
+		usec -= 1500;
+		usleep_range(usec, usec + 100);
+		ft260_dbg("wait %d usec, len %d\n", usec, len);
+	}
+
+	/*
+	 * Do not check the busy bit for combined transactions
+	 * since the controller keeps the bus busy between writing
+	 * and reading IOs to ensure an atomic operation.
+	 */
+	if (rep->flag == FT260_FLAG_START)
+		bus_busy = 0;
+	else
+		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+
 	do {
-		ret = ft260_xfer_status(dev);
+		ret = ft260_xfer_status(dev, bus_busy);
 		if (ret != -EAGAIN)
 			break;
 	} while (--try);
@@ -457,20 +500,17 @@ static int ft260_smbus_write(struct ft260_device *dev, u8 addr, u8 cmd,
 static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			  u16 len, u8 flag)
 {
+	int timeout, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
-	int timeout;
-	int ret;
+	unsigned long irqflags;
+	u8 bus_busy = 0;
 
 	if (len > FT260_RD_DATA_MAX) {
 		hid_err(hdev, "%s: unsupported rd len: %d\n", __func__, len);
 		return -EINVAL;
 	}
 
-	dev->read_idx = 0;
-	dev->read_buf = data;
-	dev->read_len = len;
-
 	rep.report = FT260_I2C_READ_REQ;
 	rep.length = cpu_to_le16(len);
 	rep.address = addr;
@@ -481,25 +521,45 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 	reinit_completion(&dev->wait);
 
+	spin_lock_irqsave(&dev->read_lock, irqflags);
+	dev->read_idx = 0;
+	dev->read_buf = data;
+	dev->read_len = len;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
+
 	ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 	if (ret < 0) {
 		hid_err(hdev, "%s: failed to start transaction, ret %d\n",
 			__func__, ret);
-		return ret;
+		goto ft260_i2c_read_exit;
 	}
 
 	timeout = msecs_to_jiffies(5000);
 	if (!wait_for_completion_timeout(&dev->wait, timeout)) {
+		ret = -ETIMEDOUT;
 		ft260_i2c_reset(hdev);
-		return -ETIMEDOUT;
+		goto ft260_i2c_read_exit;
 	}
 
-	ret = ft260_xfer_status(dev);
-	if (ret == 0)
-		return 0;
+	spin_lock_irqsave(&dev->read_lock, irqflags);
+	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
-	ft260_i2c_reset(hdev);
-	return -EIO;
+	if (flag & FT260_FLAG_STOP)
+		bus_busy = FT260_I2C_STATUS_BUS_BUSY;
+
+	ret = ft260_xfer_status(dev, bus_busy);
+	if (ret < 0) {
+		ret = -EIO;
+		ft260_i2c_reset(hdev);
+		goto ft260_i2c_read_exit;
+	}
+
+ft260_i2c_read_exit:
+	spin_lock_irqsave(&dev->read_lock, irqflags);
+	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
+	return ret;
 }
 
 /*
@@ -967,26 +1027,26 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 ((struct hidraw *)hdev->hidraw)->minor);
 
 	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
+	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
+	if (ret)
+		ft260_i2c_reset(hdev);
+
+	i2c_set_adapdata(&dev->adap, dev);
 	ret = i2c_add_adapter(&dev->adap);
 	if (ret) {
 		hid_err(hdev, "failed to add i2c adapter\n");
 		goto err_hid_close;
 	}
 
-	i2c_set_adapdata(&dev->adap, dev);
-
 	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
 	if (ret < 0) {
 		hid_err(hdev, "failed to create sysfs attrs\n");
 		goto err_i2c_free;
 	}
 
-	ret = ft260_xfer_status(dev);
-	if (ret)
-		ft260_i2c_reset(hdev);
-
 	return 0;
 
 err_i2c_free:
@@ -1017,17 +1077,49 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
+	unsigned long irqflags;
+
+	if (size < offsetof(struct ft260_i2c_input_report, data)) {
+		hid_err(hdev, "short report %d\n", size);
+		return -1;
+	}
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
-		ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
-			  xfer->length);
+		bool complete_read;
+
+		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
+			  xfer->report, xfer->length, size);
+
+		if (xfer->length > size -
+		    offsetof(struct ft260_i2c_input_report, data)) {
+			hid_err(hdev, "report %#02x: length %d exceeds HID report size\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
+
+		/*
+		 * Hold read_lock so a timed-out ft260_i2c_read() cannot
+		 * clear read_buf between the NULL check and the memcpy.
+		 */
+		spin_lock_irqsave(&dev->read_lock, irqflags);
+
+		if ((dev->read_buf == NULL) ||
+		    (xfer->length > dev->read_len - dev->read_idx)) {
+			spin_unlock_irqrestore(&dev->read_lock, irqflags);
+			hid_err(hdev, "unexpected report %#02x, length %d\n",
+				xfer->report, xfer->length);
+			return -1;
+		}
 
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
+		complete_read = dev->read_idx == dev->read_len;
+
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
-		if (dev->read_idx == dev->read_len)
+		if (complete_read)
 			complete(&dev->wait);
 
 	} else {
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index d03a447dbe6b..12b94ea3b64d 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -367,19 +367,27 @@ static int hidinput_query_battery_capacity(struct hid_device *dev)
 {
 	u8 *buf;
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + dev->battery_report_offset / 8;
+	int len = offset + 1;
 
-	buf = kmalloc(4, GFP_KERNEL);
+	buf = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, 4,
+	ret = hid_hw_raw_request(dev, dev->battery_report_id, buf, max(len, 4),
 				 dev->battery_report_type, HID_REQ_GET_REPORT);
-	if (ret < 2) {
+	if (ret < len) {
 		kfree(buf);
 		return -ENODATA;
 	}
 
-	ret = hidinput_scale_battery_capacity(dev, buf[1]);
+	ret = hidinput_scale_battery_capacity(dev, buf[offset]);
 	kfree(buf);
 	return ret;
 }
@@ -497,6 +505,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	dev->battery_max = max;
 	dev->battery_report_type = report_type;
 	dev->battery_report_id = field->report->id;
+	dev->battery_report_offset = field->report_offset;
 
 	/*
 	 * Stylus is normally not connected to the device and thus we
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 52ae2102d4ec..e1bd8c9ecce0 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -368,8 +368,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -480,6 +480,15 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		 * packet.
 		 */
 
+		/*
+		 * A double report only ever wraps two normal reports, so it is
+		 * never nested. Refuse to recurse a second time; otherwise a
+		 * malicious device could chain DOUBLE_REPORT_ID packets to drive
+		 * unbounded recursion and overflow the kernel stack.
+		 */
+		if (nested)
+			return 0;
+
 		/* Ensure that we have at least 2 elements (report type and size) */
 		if (size < 2)
 			return 0;
@@ -491,9 +500,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 			return 0;
 		}
 
-		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+		__magicmouse_raw_event(hdev, report, data + 2, data[1], true);
+		__magicmouse_raw_event(hdev, report, data + 2 + data[1],
+			size - 2 - data[1], true);
 		return 0;
 	default:
 		return 0;
@@ -516,6 +525,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	return __magicmouse_raw_event(hdev, report, data, size, false);
+}
+
 static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index 340f92cfc812..5cc0742ac38b 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -346,7 +346,17 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	del_timer_sync(&drvdata->inrange_timer);
+	/*
+	 * Shut the in-range timer down before stopping the device.
+	 * uclogic_raw_event_pen() re-arms inrange_timer on every pen report
+	 * and keeps running until hid_hw_stop() stops the transport, so a
+	 * plain timer_delete_sync() here can be undone by a report landing in
+	 * the window before hid_hw_stop().  timer_shutdown_sync() cancels the
+	 * timer and makes any later re-arm a no-op, so it is provably dead
+	 * before hid_hw_stop() frees the input device drvdata->pen_input
+	 * points at.
+	 */
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
index 13b237d93a61..b09e0516c409 100644
--- a/drivers/infiniband/sw/rxe/rxe_qp.c
+++ b/drivers/infiniband/sw/rxe/rxe_qp.c
@@ -598,10 +598,9 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
 		int max_dest_rd_atomic = attr->max_dest_rd_atomic ?
 			roundup_pow_of_two(attr->max_dest_rd_atomic) : 0;
 
-		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
-
 		free_rd_atomic_resources(qp);
 
+		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
 		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
 		if (err)
 			return err;
diff --git a/drivers/mtd/maps/vmu-flash.c b/drivers/mtd/maps/vmu-flash.c
index ad10f7887dfa..f96a165fccc7 100644
--- a/drivers/mtd/maps/vmu-flash.c
+++ b/drivers/mtd/maps/vmu-flash.c
@@ -610,7 +610,7 @@ static int vmu_connect(struct maple_device *mdev)
 
 	basic_flash_data = be32_to_cpu(mdev->devinfo.function_data[c - 1]);
 
-	card = kzalloc_obj(struct memcard);
+	card = kmalloc(sizeof(struct memcard), GFP_KERNEL);
 	if (!card) {
 		error = -ENOMEM;
 		goto fail_nomem;
@@ -628,13 +628,15 @@ static int vmu_connect(struct maple_device *mdev)
 	* Not sure there are actually any multi-partition devices in the
 	* real world, but the hardware supports them, so, so will we
 	*/
-	card->parts = kzalloc_objs(struct vmupart, card->partitions);
+	card->parts = kmalloc_array(card->partitions, sizeof(struct vmupart),
+				    GFP_KERNEL);
 	if (!card->parts) {
 		error = -ENOMEM;
 		goto fail_partitions;
 	}
 
-	card->mtd = kzalloc_objs(struct mtd_info, card->partitions);
+	card->mtd = kmalloc_array(card->partitions, sizeof(struct mtd_info),
+				  GFP_KERNEL);
 	if (!card->mtd) {
 		error = -ENOMEM;
 		goto fail_mtd_info;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1bd1fe72db7..0429ddda73be 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -308,7 +308,7 @@ static void nvme_retry_req(struct request *req)
 	u16 crd;
 
 	/* The mask and shift result must be <= 3 */
-	crd = (nvme_req(req)->status & NVME_SC_CRD) >> 11;
+	crd = (nvme_req(req)->status & NVME_STATUS_CRD) >> 11;
 	if (crd)
 		delay = nvme_req(req)->ctrl->crdt[crd - 1] * 100;
 
@@ -329,7 +329,7 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 		return COMPLETE;
 
 	if (blk_noretry_request(req) ||
-	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	    (nvme_req(req)->status & NVME_STATUS_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
@@ -1519,7 +1519,7 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_free_id;
 	}
 
-	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	error = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
 
@@ -4015,7 +4015,7 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 {
 	struct nvme_id_ns *id;
-	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	int ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
@@ -4024,7 +4024,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	if (ret)
 		goto out;
 
-	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	ret = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
@@ -4042,7 +4042,7 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 	 *
 	 * TODO: we should probably schedule a delayed retry here.
 	 */
-	if (ret > 0 && (ret & NVME_SC_DNR))
+	if (ret > 0 && (ret & NVME_STATUS_DNR))
 		nvme_ns_remove(ns);
 }
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index d4028c669a2b..9aee34476f66 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -161,7 +161,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 
 	return ret;
 }
@@ -207,7 +207,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	if (unlikely(ret != 0))
 		dev_err(ctrl->device,
 			"Property Get error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_read64);
@@ -249,7 +249,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
-			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
+			ret > 0 ? ret & ~NVME_STATUS_DNR : ret, off);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvmf_reg_write32);
@@ -284,7 +284,7 @@ static void nvmf_log_connect_error(struct nvme_ctrl *ctrl,
 		int errval, int offset, struct nvme_command *cmd,
 		struct nvmf_connect_data *data)
 {
-	int err_sctype = errval & ~NVME_SC_DNR;
+	int err_sctype = errval & ~NVME_STATUS_DNR;
 
 	switch (err_sctype) {
 	case (NVME_SC_CONNECT_INVALID_PARAM):
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index 1352159733b0..a6685e018b0d 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -75,7 +75,7 @@ void nvme_should_fail(struct request *req)
 		/* inject status code and DNR bit */
 		status = fault_inject->status;
 		if (fault_inject->dont_retry)
-			status |= NVME_SC_DNR;
+			status |= NVME_STATUS_DNR;
 		nvme_req(req)->status =	status;
 	}
 }
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9381655c1ec5..b947c536a9d1 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3108,7 +3108,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->ctrl.icdoff) {
 		dev_err(ctrl->ctrl.device, "icdoff %d is not supported!\n",
 				ctrl->ctrl.icdoff);
-		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		ret = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out_disconnect_admin_queue;
 	}
 
@@ -3116,7 +3116,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (!nvme_ctrl_sgl_supported(&ctrl->ctrl)) {
 		dev_err(ctrl->ctrl.device,
 			"Mandatory sgls are not supported!\n");
-		ret = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		ret = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out_disconnect_admin_queue;
 	}
 
@@ -3287,7 +3287,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: reset: Reconnect attempt failed (%d)\n",
 			ctrl->cnum, status);
-		if (status > 0 && (status & NVME_SC_DNR))
+		if (status > 0 && (status & NVME_STATUS_DNR))
 			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
@@ -3304,7 +3304,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 		queue_delayed_work(nvme_wq, &ctrl->connect_work, recon_delay);
 	} else {
 		if (portptr->port_state == FC_OBJSTATE_ONLINE) {
-			if (status > 0 && (status & NVME_SC_DNR))
+			if (status > 0 && (status & NVME_STATUS_DNR))
 				dev_warn(ctrl->ctrl.device,
 					 "NVME-FC{%d}: reconnect failure\n",
 					 ctrl->cnum);
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ec13f568785e..270ba1fa23cc 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -342,7 +342,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
 
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
@@ -491,7 +491,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -657,7 +657,7 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 
 	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
 			off) != NVME_IDENTIFY_DATA_SIZE - off)
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
 out:
 	nvmet_req_complete(req, status);
@@ -814,7 +814,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 
 	if (val32 & ~mask) {
 		req->error_loc = offsetof(struct nvme_common_command, cdw11);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	WRITE_ONCE(req->sq->ctrl->aen_enabled, val32);
@@ -840,7 +840,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		ncqr = (cdw11 >> 16) & 0xffff;
 		nsqr = cdw11 & 0xffff;
 		if (ncqr == 0xffff || nsqr == 0xffff) {
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 		nvmet_set_result(req,
@@ -853,14 +853,14 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 		status = nvmet_set_feat_async_event(req, NVMET_AEN_CFG_ALL);
 		break;
 	case NVME_FEAT_HOST_ID:
-		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		status = NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 		break;
 	case NVME_FEAT_WRITE_PROTECT:
 		status = nvmet_set_feat_write_protect(req);
 		break;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, cdw10);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -946,7 +946,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
 			req->error_loc =
 				offsetof(struct nvme_common_command, cdw11);
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 
@@ -959,7 +959,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -976,7 +976,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 	mutex_lock(&ctrl->lock);
 	if (ctrl->nr_async_event_cmds >= NVMET_ASYNC_EVENTS) {
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_ASYNC_LIMIT | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_ASYNC_LIMIT | NVME_STATUS_DNR);
 		return;
 	}
 	ctrl->async_event_cmds[ctrl->nr_async_event_cmds++] = req;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 30177f42a2aa..0483a85850ea 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -53,18 +53,18 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 		return NVME_SC_SUCCESS;
 	case -ENOSPC:
 		req->error_loc = offsetof(struct nvme_rw_command, length);
-		return NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		return NVME_SC_CAP_EXCEEDED | NVME_STATUS_DNR;
 	case -EREMOTEIO:
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
-		return  NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		return  NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	case -EOPNOTSUPP:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
-			return NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			return NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
 		default:
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		}
 		break;
 	case -ENODATA:
@@ -74,7 +74,7 @@ inline u16 errno_to_nvme_status(struct nvmet_req *req, int errno)
 		fallthrough;
 	default:
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	}
 }
 
@@ -84,7 +84,7 @@ u16 nvmet_report_invalid_opcode(struct nvmet_req *req)
 		 req->sq->qid);
 
 	req->error_loc = offsetof(struct nvme_common_command, opcode);
-	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 }
 
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
@@ -95,7 +95,7 @@ u16 nvmet_copy_to_sgl(struct nvmet_req *req, off_t off, const void *buf,
 {
 	if (sg_pcopy_from_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -104,7 +104,7 @@ u16 nvmet_copy_from_sgl(struct nvmet_req *req, off_t off, void *buf, size_t len)
 {
 	if (sg_pcopy_to_buffer(req->sg, req->sg_cnt, buf, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -113,7 +113,7 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 {
 	if (sg_zero_buffer(req->sg, req->sg_cnt, len, off) != len) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -143,7 +143,7 @@ static void nvmet_async_events_failall(struct nvmet_ctrl *ctrl)
 	while (ctrl->nr_async_event_cmds) {
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		mutex_unlock(&ctrl->lock);
-		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_STATUS_DNR);
 		mutex_lock(&ctrl->lock);
 	}
 	mutex_unlock(&ctrl->lock);
@@ -427,7 +427,7 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+		return NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 	}
 
 	percpu_ref_get(&req->ns->ref);
@@ -942,7 +942,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -953,7 +953,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	 */
 	if (unlikely((flags & NVME_CMD_SGL_ALL) != NVME_CMD_SGL_METABUF)) {
 		req->error_loc = offsetof(struct nvme_common_command, flags);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -971,7 +971,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	trace_nvmet_req_init(req, req->cmd);
 
 	if (unlikely(!percpu_ref_tryget_live(&sq->ref))) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto fail;
 	}
 
@@ -998,7 +998,7 @@ bool nvmet_check_transfer_len(struct nvmet_req *req, size_t len)
 {
 	if (unlikely(len != req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -1010,7 +1010,7 @@ bool nvmet_check_data_len_lte(struct nvmet_req *req, size_t data_len)
 {
 	if (unlikely(data_len > req->transfer_len)) {
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
-		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_SC_DNR);
+		nvmet_req_complete(req, NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR);
 		return false;
 	}
 
@@ -1275,13 +1275,13 @@ u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
 		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
 		       req->cmd->common.opcode, req->sq->qid);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
 		       req->cmd->common.opcode, req->sq->qid);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 	}
 	return 0;
 }
@@ -1355,7 +1355,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	int ret;
 	u16 status;
 
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
@@ -1371,7 +1371,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			hostnqn, subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
-		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_HOST | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_common_command, dptr);
 		goto out_put_subsystem;
 	}
@@ -1417,7 +1417,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
-		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 		goto out_free_sqs;
 	}
 	ctrl->cntlid = ret;
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7aa62bc6ae84..cb8d4f48d8b3 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -178,7 +178,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -186,7 +186,7 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 	if (offset & 0x3) {
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lpo);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -251,7 +251,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	if (req->cmd->identify.cns != NVME_ID_CNS_CTRL) {
 		req->error_loc = offsetof(struct nvme_identify, cns);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -313,7 +313,7 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		stat = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -338,7 +338,7 @@ static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_common_command, cdw10);
-		stat = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		stat = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		break;
 	}
 
@@ -354,7 +354,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 		       cmd->common.opcode);
 		req->error_loc =
 			offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	switch (cmd->common.opcode) {
@@ -379,7 +379,7 @@ u16 nvmet_parse_discovery_cmd(struct nvmet_req *req)
 	default:
 		pr_debug("unhandled cmd %d\n", cmd->common.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 }
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index a12f80869d6f..cfc3e979aed2 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -18,7 +18,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	if (req->cmd->prop_set.attrib & 1) {
 		req->error_loc =
 			offsetof(struct nvmf_property_set_command, attrib);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -29,7 +29,7 @@ static void nvmet_execute_prop_set(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvmf_property_set_command, offset);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 out:
 	nvmet_req_complete(req, status);
@@ -50,7 +50,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			val = ctrl->cap;
 			break;
 		default:
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 	} else {
@@ -65,7 +65,7 @@ static void nvmet_execute_prop_get(struct nvmet_req *req)
 			val = ctrl->csts;
 			break;
 		default:
-			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
 		}
 	}
@@ -97,7 +97,7 @@ u16 nvmet_parse_fabrics_cmd(struct nvmet_req *req)
 		pr_debug("received unknown capsule type 0x%x\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	return 0;
@@ -116,14 +116,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
-		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		goto err;
 	}
 
 	if (ctrl->sqs[qid] != NULL) {
 		pr_warn("qid %u has already been created\n", qid);
 		req->error_loc = offsetof(struct nvmf_connect_command, qid);
-		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+		return NVME_SC_CMD_SEQ_ERROR | NVME_STATUS_DNR;
 	}
 
 	if (sqsize > mqes) {
@@ -131,14 +131,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 				sqsize, mqes, ctrl->cntlid);
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
-		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 	}
 
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
 	if (old) {
 		pr_warn("queue already connected!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
-		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+		return NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
 	}
 
 	/* note: convert queue size from 0's-based value to 1's-based value */
@@ -191,14 +191,14 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
 		req->error_loc = offsetof(struct nvmf_connect_command, recfmt);
-		status = NVME_SC_CONNECT_FORMAT | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(d->cntlid != cpu_to_le16(0xffff))) {
 		pr_warn("connect attempt for invalid controller ID %#x\n",
 			d->cntlid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
 		goto out;
 	}
@@ -255,7 +255,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-		status = NVME_SC_CONNECT_FORMAT | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_FORMAT | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -264,13 +264,13 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
 				   le16_to_cpu(d->cntlid), req);
 	if (!ctrl) {
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
-		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
 		goto out_ctrl_put;
 	}
@@ -303,13 +303,13 @@ u16 nvmet_parse_connect_cmd(struct nvmet_req *req)
 		pr_debug("invalid command 0x%x on unconnected queue.\n",
 			cmd->fabrics.opcode);
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 	if (cmd->fabrics.fctype != nvme_fabrics_type_connect) {
 		pr_debug("invalid capsule type 0x%x on unconnected queue.\n",
 			cmd->fabrics.fctype);
 		req->error_loc = offsetof(struct nvmf_common_command, fctype);
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	if (cmd->connect.qid == 0)
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 58da949696c2..46752d5d526c 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -124,11 +124,11 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 	 */
 	switch (blk_sts) {
 	case BLK_STS_NOSPC:
-		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		status = NVME_SC_CAP_EXCEEDED | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_rw_command, length);
 		break;
 	case BLK_STS_TARGET:
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
 		break;
 	case BLK_STS_NOTSUPP:
@@ -136,10 +136,10 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_dsm:
 		case nvme_cmd_write_zeroes:
-			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_STATUS_DNR;
 			break;
 		default:
-			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			status = NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		}
 		break;
 	case BLK_STS_MEDIUM:
@@ -148,7 +148,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		break;
 	case BLK_STS_IOERR:
 	default:
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
 	}
 
@@ -339,7 +339,7 @@ static void nvmet_bdev_execute_flush(struct nvmet_req *req)
 u16 nvmet_bdev_flush(struct nvmet_req *req)
 {
 	if (blkdev_issue_flush(req->ns->bdev))
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
+		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 17dd84551458..4ab5b5580856 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -653,7 +653,7 @@ static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
 	pr_debug("unhandled identify cns %d on qid %d\n",
 	       req->cmd->identify.cns, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_STATUS_DNR);
 }
 
 static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9b5929754195..4a5da03da158 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		ns = nvme_find_get_ns(ctrl, nsid);
 		if (unlikely(!ns)) {
 			pr_err("failed to get passthru ns nsid:%u\n", nsid);
-			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+			status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 			goto out;
 		}
 
@@ -362,7 +362,7 @@ u16 nvmet_parse_passthru_io_cmd(struct nvmet_req *req)
 		 * emulated in the future if regular targets grow support for
 		 * this feature.
 		 */
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 
 	return nvmet_setup_passthru_command(req);
@@ -414,7 +414,7 @@ static u16 nvmet_passthru_get_set_features(struct nvmet_req *req)
 	case NVME_FEAT_RESV_PERSIST:
 		/* No reservations, see nvmet_parse_passthru_io_cmd() */
 	default:
-		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 	}
 }
 
@@ -482,7 +482,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		case NVME_ID_CNS_NS:
 			req->execute = nvmet_passthru_execute_cmd;
 			req->p.use_workqueue = true;
@@ -494,7 +494,7 @@ u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 				req->p.use_workqueue = true;
 				return NVME_SC_SUCCESS;
 			}
-			return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+			return NVME_SC_INVALID_OPCODE | NVME_STATUS_DNR;
 		default:
 			return nvmet_setup_passthru_command(req);
 		}
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index f82280d90497..ca21cd66b1f4 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -852,12 +852,12 @@ static u16 nvmet_rdma_map_sgl_inline(struct nvmet_rdma_rsp *rsp)
 	if (!nvme_is_write(rsp->req.cmd)) {
 		rsp->req.error_loc =
 			offsetof(struct nvme_common_command, opcode);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	if (off + len > rsp->queue->dev->inline_data_size) {
 		pr_err("invalid inline data offset!\n");
-		return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 	}
 
 	/* no data command? */
@@ -921,7 +921,7 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
 			rsp->req.error_loc =
 				offsetof(struct nvme_common_command, dptr);
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		}
 	case NVME_KEY_SGL_FMT_DATA_DESC:
 		switch (sgl->type & 0xf) {
@@ -933,12 +933,12 @@ static u16 nvmet_rdma_map_sgl(struct nvmet_rdma_rsp *rsp)
 			pr_err("invalid SGL subtype: %#x\n", sgl->type);
 			rsp->req.error_loc =
 				offsetof(struct nvme_common_command, dptr);
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		}
 	default:
 		pr_err("invalid SGL type: %#x\n", sgl->type);
 		rsp->req.error_loc = offsetof(struct nvme_common_command, dptr);
-		return NVME_SC_SGL_INVALID_TYPE | NVME_SC_DNR;
+		return NVME_SC_SGL_INVALID_TYPE | NVME_STATUS_DNR;
 	}
 }
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 904bbb10f5d0..2c4ceea34271 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -394,13 +394,26 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (!len)
 		return 0;
 
+	/*
+	 * inline_data_size only bounds the in-capsule (type 0x01) SGL
+	 * descriptor below. A non-inline transport SGL data-block
+	 * descriptor skips that check entirely and would otherwise reach
+	 * sgl_alloc() with an attacker-controlled len of up to 4 GiB,
+	 * pinning that much kernel memory for a command that may never
+	 * complete. Bound every descriptor type here, before allocating
+	 * anything, using the same ceiling this file already applies to
+	 * per-PDU H2C data.
+	 */
+	if (len > NVMET_TCP_MAXH2CDATA)
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
-			return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+			return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 
 		if (len > cmd->req.port->inline_data_size)
-			return NVME_SC_SGL_INVALID_OFFSET | NVME_SC_DNR;
+			return NVME_SC_SGL_INVALID_OFFSET | NVME_STATUS_DNR;
 		cmd->pdu_len = len;
 	}
 	cmd->req.transfer_len += len;
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index ae617d66b137..6b9b22cc8adb 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -104,7 +104,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		status = NVME_SC_INVALID_NS | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -125,7 +125,7 @@ void nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
 	}
 
 	if (!bdev_is_zoned(req->ns->bdev)) {
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		req->error_loc = offsetof(struct nvme_identify, nsid);
 		goto out;
 	}
@@ -162,17 +162,17 @@ static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
 
 	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, slba);
-		return NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		return NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 	}
 
 	if (out_bufsize < sizeof(struct nvme_zone_report)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, numd);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	if (req->cmd->zmr.zra != NVME_ZRA_ZONE_REPORT) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, zra);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	switch (req->cmd->zmr.pr) {
@@ -181,7 +181,7 @@ static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
 		break;
 	default:
 		req->error_loc = offsetof(struct nvme_zone_mgmt_recv_cmd, pr);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	switch (req->cmd->zmr.zrasf) {
@@ -197,7 +197,7 @@ static u16 nvmet_bdev_validate_zone_mgmt_recv(struct nvmet_req *req)
 	default:
 		req->error_loc =
 			offsetof(struct nvme_zone_mgmt_recv_cmd, zrasf);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	return NVME_SC_SUCCESS;
@@ -346,7 +346,7 @@ static u16 blkdev_zone_mgmt_errno_to_nvme_status(int ret)
 		return NVME_SC_SUCCESS;
 	case -EINVAL:
 	case -EIO:
-		return NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
+		return NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_DNR;
 	default:
 		return NVME_SC_INTERNAL;
 	}
@@ -470,7 +470,7 @@ static u16 nvmet_bdev_execute_zmgmt_send_all(struct nvmet_req *req)
 	default:
 		/* this is needed to quiet compiler warning */
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
-		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
 
 	return NVME_SC_SUCCESS;
@@ -488,7 +488,7 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 
 	if (op == REQ_OP_LAST) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, zsa);
-		status = NVME_SC_ZONE_INVALID_TRANSITION | NVME_SC_DNR;
+		status = NVME_SC_ZONE_INVALID_TRANSITION | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -500,13 +500,13 @@ static void nvmet_bdev_zmgmt_send_work(struct work_struct *w)
 
 	if (sect >= get_capacity(bdev->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, slba);
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (sect & (zone_sectors - 1)) {
 		req->error_loc = offsetof(struct nvme_zone_mgmt_send_cmd, slba);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -557,13 +557,13 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 
 	if (sect >= get_capacity(req->ns->bdev->bd_disk)) {
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
-		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		status = NVME_SC_LBA_RANGE | NVME_STATUS_DNR;
 		goto out;
 	}
 
 	if (sect & (bdev_zone_sectors(req->ns->bdev) - 1)) {
 		req->error_loc = offsetof(struct nvme_rw_command, slba);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 		goto out;
 	}
 
@@ -597,7 +597,7 @@ void nvmet_bdev_execute_zone_append(struct nvmet_req *req)
 	}
 
 	if (total_len != nvmet_rw_data_len(req)) {
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
 		goto out_put_bio;
 	}
 
diff --git a/drivers/target/target_core_fabric_configfs.c b/drivers/target/target_core_fabric_configfs.c
index fc7edc04ee09..6c854fbc0096 100644
--- a/drivers/target/target_core_fabric_configfs.c
+++ b/drivers/target/target_core_fabric_configfs.c
@@ -689,6 +689,14 @@ static void target_fabric_port_unlink(
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
index c7d3e907be81..c702997f5713 100644
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
index 5cd0a724b425..c2976944aa83 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1099,7 +1099,6 @@ static int usbdev_release(struct inode *inode, struct file *file)
 	if (!ps->suspend_allowed)
 		usb_autosuspend_device(dev);
 	usb_unlock_device(dev);
-	usb_put_dev(dev);
 	put_pid(ps->disc_pid);
 	put_cred(ps->cred);
 
@@ -1108,6 +1107,7 @@ static int usbdev_release(struct inode *inode, struct file *file)
 		free_async(as);
 		as = async_getcompleted(ps);
 	}
+	usb_put_dev(dev);
 
 	kfree(ps);
 	return 0;
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 89a93f3d1ecd..c26303dd0645 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -714,10 +714,12 @@ void usb_wakeup_notification(struct usb_device *hdev,
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
@@ -727,6 +729,7 @@ void usb_wakeup_notification(struct usb_device *hdev,
 		set_bit(portnum, hub->wakeup_bits);
 		kick_hub_wq(hub);
 	}
+	spin_unlock_irqrestore(&device_state_lock, flags);
 }
 EXPORT_SYMBOL_GPL(usb_wakeup_notification);
 
@@ -952,10 +955,12 @@ static int hub_hub_status(struct usb_hub *hub,
 
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
index 002cc7a33344..30ab1ccf0920 100644
--- a/drivers/usb/gadget/function/f_tcm.c
+++ b/drivers/usb/gadget/function/f_tcm.c
@@ -1714,7 +1714,7 @@ static const struct target_core_fabric_ops usbg_ops = {
 	.fabric_make_tpg		= usbg_make_tpg,
 	.fabric_drop_tpg		= usbg_drop_tpg,
 	.fabric_post_link		= usbg_port_link,
-	.fabric_pre_unlink		= usbg_port_unlink,
+	.fabric_post_unlink		= usbg_port_unlink,
 	.fabric_init_nodeacl		= usbg_init_nodeacl,
 
 	.tfc_wwn_attrs			= usbg_wwn_attrs,
diff --git a/drivers/usb/host/xhci-dbgtty.c b/drivers/usb/host/xhci-dbgtty.c
index 32f8c3d40fb0..740f5df8368e 100644
--- a/drivers/usb/host/xhci-dbgtty.c
+++ b/drivers/usb/host/xhci-dbgtty.c
@@ -576,8 +576,8 @@ static int dbc_tty_init(void)
 	dbc_tty_driver = tty_alloc_driver(64, TTY_DRIVER_REAL_RAW |
 					  TTY_DRIVER_DYNAMIC_DEV);
 	if (IS_ERR(dbc_tty_driver)) {
-		idr_destroy(&dbc_tty_minors);
-		return PTR_ERR(dbc_tty_driver);
+		ret = PTR_ERR(dbc_tty_driver);
+		goto fail;
 	}
 
 	dbc_tty_driver->driver_name = "dbc_serial";
@@ -597,10 +597,17 @@ static int dbc_tty_init(void)
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
 
diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index 150090ee4ec1..1b3e4718cfca 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -3053,6 +3053,7 @@ static struct usb_driver usbtest_driver = {
 	.disconnect =	usbtest_disconnect,
 	.suspend =	usbtest_suspend,
 	.resume =	usbtest_resume,
+	.no_dynamic_id = 1,
 };
 
 /*-------------------------------------------------------------------------*/
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 500472b34855..dd018abda6c3 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -2691,12 +2691,26 @@ static void option_instat_callback(struct urb *urb)
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
index 7039dc918827..e61903640f7d 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -247,18 +247,6 @@ static void spcp8x5_set_work_mode(struct usb_serial_port *port, u16 value,
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
@@ -470,7 +458,6 @@ static struct usb_serial_driver spcp8x5_device = {
 	.num_bulk_out		= 1,
 	.open			= spcp8x5_open,
 	.dtr_rts		= spcp8x5_dtr_rts,
-	.carrier_raised		= spcp8x5_carrier_raised,
 	.set_termios		= spcp8x5_set_termios,
 	.init_termios		= spcp8x5_init_termios,
 	.tiocmget		= spcp8x5_tiocmget,
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 9727cb925080..3aaa45375d8b 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3736,7 +3736,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 	if (rc)
 		goto out;
 
-	buf = kvzalloc(1024 * 1024, GFP_KERNEL);
+	buf = kzalloc(1024 * 1024, GFP_KERNEL);
 	if (buf == NULL) {
 		rc = -ENOMEM;
 		goto out;
@@ -3803,7 +3803,7 @@ static int smb3_simple_fallocate_range(unsigned int xid,
 
  out:
 	kfree(out_data);
-	kvfree(buf);
+	kfree(buf);
 	return rc;
 }
 
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index b0c7d8e28337..84b219cde46c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1780,8 +1780,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, NULL, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1843,9 +1845,10 @@ static int ext4_fc_replay_add_range(struct super_block *sb,
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -1906,9 +1909,10 @@ ext4_fc_replay_del_range(struct super_block *sb,
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 2ee7467c0a6a..9f5d8acf31db 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -997,6 +997,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 		err = fscrypt_prepare_new_inode(dir, inode, &encrypt);
 		if (err)
 			goto out;
+		if (encrypt)
+			i_flags |= EXT4_ENCRYPT_FL;
 	}
 
 	err = dquot_initialize(inode);
@@ -1312,6 +1314,8 @@ struct inode *__ext4_new_inode(struct user_namespace *mnt_userns,
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
 	if (ext4_has_feature_inline_data(sb) &&
+	    /* Encrypted inodes cannot have inline data */
+	    !(ei->i_flags & EXT4_ENCRYPT_FL) &&
 	    (!(ei->i_flags & EXT4_DAX_FL) || S_ISDIR(mode)))
 		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = inode;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 48628e917b70..c89e460180b8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1487,7 +1487,13 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (inode->i_ino == EXT4_ROOT_INO)
 		return -EPERM;
 
-	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+	/*
+	 * For new encrypted inodes, S_DAX is never set in the first place.
+	 *
+	 * For existing inodes, this is called only on empty directories.  ext4
+	 * never sets S_DAX on directories.
+	 */
+	if (WARN_ON_ONCE(IS_DAX(inode)))
 		return -EINVAL;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
@@ -1506,21 +1512,18 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	 */
 
 	if (handle) {
-		res = ext4_xattr_set_handle(handle, inode,
-					    EXT4_XATTR_INDEX_ENCRYPTION,
-					    EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-					    ctx, len, 0);
-		if (!res) {
-			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-			ext4_clear_inode_state(inode,
-					EXT4_STATE_MAY_INLINE_DATA);
-			/*
-			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-			 * S_DAX may be disabled
-			 */
-			ext4_set_inode_flags(inode, false);
-		}
-		return res;
+		/*
+		 * __ext4_new_inode() should have already set the encrypt flag
+		 * on the inode and avoided enabling inline data.
+		 */
+		if (WARN_ON_ONCE(!IS_ENCRYPTED(inode)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)))
+			return -EINVAL;
+		return ext4_xattr_set_handle(handle, inode,
+					     EXT4_XATTR_INDEX_ENCRYPTION,
+					     EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
+					     ctx, len, 0);
 	}
 
 	res = dquot_initialize(inode);
@@ -1541,10 +1544,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-		/*
-		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-		 * S_DAX may be disabled
-		 */
+		/* Update inode->i_flags to set S_ENCRYPTED. */
 		ext4_set_inode_flags(inode, false);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 43d311ff246b..32c84d463794 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1601,10 +1601,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
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
@@ -1631,7 +1629,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 			 ATTR_TIMES_SET)) {
 		err = write_inode_now(inode, true);
 		if (err)
-			return err;
+			goto unlock;
 
 		fuse_set_nowrite(inode);
 		fuse_release_nowrite(inode);
@@ -1728,6 +1726,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+unlock:
 	if (fault_blocked)
 		filemap_invalidate_unlock(mapping);
 	return err;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2bcb3bbcc4b5..db9211464f1e 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -261,7 +261,7 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		filemap_invalidate_lock(inode->i_mapping);
 		err = fuse_dax_break_layouts(inode, 0, -1);
 		if (err)
-			goto out_inode_unlock;
+			goto out_unlock;
 	}
 
 	if (is_wb_truncate || dax_truncate)
@@ -281,9 +281,9 @@ int fuse_open_common(struct inode *inode, struct file *file, bool isdir)
 		else if (!(ff->open_flags & FOPEN_KEEP_CACHE))
 			invalidate_inode_pages2(inode->i_mapping);
 	}
+out_unlock:
 	if (dax_truncate)
 		filemap_invalidate_unlock(inode->i_mapping);
-out_inode_unlock:
 	if (is_wb_truncate || dax_truncate)
 		inode_unlock(inode);
 
diff --git a/fs/jfs/inode.c b/fs/jfs/inode.c
index 6d6425cdb118..84e79c757403 100644
--- a/fs/jfs/inode.c
+++ b/fs/jfs/inode.c
@@ -386,7 +386,7 @@ void jfs_truncate_nolock(struct inode *ip, loff_t length)
 
 	ASSERT(length >= 0);
 
-	if (test_cflag(COMMIT_Nolink, ip)) {
+	if (test_cflag(COMMIT_Nolink, ip) || isReadOnly(ip)) {
 		xtTruncate(0, ip, length, COMMIT_WMAP);
 		return;
 	}
diff --git a/fs/jfs/jfs_extent.c b/fs/jfs/jfs_extent.c
index 6420b6749d48..25b5a866ee18 100644
--- a/fs/jfs/jfs_extent.c
+++ b/fs/jfs/jfs_extent.c
@@ -77,6 +77,11 @@ extAlloc(struct inode *ip, s64 xlen, s64 pno, xad_t * xp, bool abnr)
 	int rc;
 	int xflag;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EIO;
+	}
+
 	/* This blocks if we are low on resources */
 	txBeginAnon(ip->i_sb);
 
@@ -412,6 +417,11 @@ int extRecord(struct inode *ip, xad_t * xp)
 {
 	int rc;
 
+	if (isReadOnly(ip)) {
+		jfs_error(ip->i_sb, "read-only filesystem\n");
+		return -EIO;
+	}
+
 	txBeginAnon(ip->i_sb);
 
 	mutex_lock(&JFS_IP(ip)->commit_mutex);
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 77e6bae7d5c9..baa43a13b7a8 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -32,17 +32,14 @@
  * @dofunc: concrete function of get/set metadata info
  *
  * Description: nilfs_ioctl_wrap_copy() gets/sets metadata info by means of
- * calling dofunc() function on the basis of @argv argument.
- *
- * Return Value: On success, 0 is returned and requested metadata info
- * is copied into userspace. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * calling dofunc() function on the basis of @argv argument.  If successful,
+ * the requested metadata information is copied to userspace memory.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during execution of requested operation.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_wrap_copy(struct the_nilfs *nilfs,
 				 struct nilfs_argv *argv, int dir,
@@ -176,13 +173,10 @@ static int nilfs_ioctl_getversion(struct inode *inode, void __user *argp)
  * given checkpoint between checkpoint and snapshot state. This ioctl
  * is used in chcp and mkcp utilities.
  *
- * Return Value: On success, 0 is returned and mode of a checkpoint is
- * changed. On error, one of the following negative error codes
- * is returned.
- *
- * %-EPERM - Operation not permitted.
- *
- * %-EFAULT - Failure during checkpoint mode changing.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * %-EFAULT	- Failure during checkpoint mode changing.
+ * %-EPERM	- Operation not permitted.
  */
 static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
 				     unsigned int cmd, void __user *argp)
@@ -230,13 +224,10 @@ static int nilfs_ioctl_change_cpmode(struct inode *inode, struct file *filp,
  * checkpoint from NILFS2 file system. This ioctl is used in rmcp
  * utility.
  *
- * Return Value: On success, 0 is returned and a checkpoint is
- * removed. On error, one of the following negative error codes
- * is returned.
- *
- * %-EPERM - Operation not permitted.
- *
- * %-EFAULT - Failure during checkpoint removing.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * %-EFAULT	- Failure during checkpoint removing.
+ * %-EPERM	- Operation not permitted.
  */
 static int
 nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
@@ -282,7 +273,7 @@ nilfs_ioctl_delete_checkpoint(struct inode *inode, struct file *filp,
  * requested checkpoints. The NILFS_IOCTL_GET_CPINFO ioctl is used in
  * lscp utility and by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_cpinfo structures in output buffer.
+ * Return: Count of nilfs_cpinfo structures in output buffer.
  */
 static ssize_t
 nilfs_ioctl_do_get_cpinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -306,17 +297,14 @@ nilfs_ioctl_do_get_cpinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_get_cpstat() returns information about checkpoints.
  * The NILFS_IOCTL_GET_CPSTAT ioctl is used by lscp, rmcp utilities
- * and by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and checkpoints information is
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting checkpoints statistics.
+ * and by nilfs_cleanerd daemon.  The checkpoint statistics are copied to
+ * the userspace memory pointed to by @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting checkpoints statistics.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_cpstat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -349,7 +337,8 @@ static int nilfs_ioctl_get_cpstat(struct inode *inode, struct file *filp,
  * info about requested segments. The NILFS_IOCTL_GET_SUINFO ioctl is used
  * in lssu, nilfs_resize utilities and by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_suinfo structures in output buffer.
+ * Return: Count of nilfs_suinfo structures in output buffer on success,
+ * or a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_suinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -373,17 +362,14 @@ nilfs_ioctl_do_get_suinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_get_sustat() returns segment usage statistics.
  * The NILFS_IOCTL_GET_SUSTAT ioctl is used in lssu, nilfs_resize utilities
- * and by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and segment usage information is
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting segment usage statistics.
+ * and by nilfs_cleanerd daemon.  The requested segment usage information is
+ * copied to the userspace memory pointed to by @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting segment usage statistics.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_sustat(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -416,7 +402,8 @@ static int nilfs_ioctl_get_sustat(struct inode *inode, struct file *filp,
  * on virtual block addresses. The NILFS_IOCTL_GET_VINFO ioctl is used
  * by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_vinfo structures in output buffer.
+ * Return: Count of nilfs_vinfo structures in output buffer on success, or
+ * a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_vinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -443,7 +430,8 @@ nilfs_ioctl_do_get_vinfo(struct the_nilfs *nilfs, __u64 *posp, int flags,
  * about descriptors of disk block numbers. The NILFS_IOCTL_GET_BDESCS ioctl
  * is used by nilfs_cleanerd daemon.
  *
- * Return value: count of nilfs_bdescs structures in output buffer.
+ * Return: Count of nilfs_bdescs structures in output buffer on success, or
+ * a negative error code on failure.
  */
 static ssize_t
 nilfs_ioctl_do_get_bdescs(struct the_nilfs *nilfs, __u64 *posp, int flags,
@@ -480,19 +468,15 @@ nilfs_ioctl_do_get_bdescs(struct the_nilfs *nilfs, __u64 *posp, int flags,
  *
  * Description: nilfs_ioctl_do_get_bdescs() function returns information
  * about descriptors of disk block numbers. The NILFS_IOCTL_GET_BDESCS ioctl
- * is used by nilfs_cleanerd daemon.
- *
- * Return Value: On success, 0 is returned, and disk block descriptors are
- * copied into userspace pointer @argp. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during getting disk block descriptors.
+ * is used by nilfs_cleanerd daemon.  If successful, disk block descriptors
+ * are copied to userspace pointer @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during getting disk block descriptors.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
 				  unsigned int cmd, void __user *argp)
@@ -526,31 +510,43 @@ static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
  * Description: nilfs_ioctl_move_inode_block() function registers data/node
  * buffer in the GC pagecache and submit read request.
  *
- * Return Value: On success, 0 is returned. On error, one of the following
- * negative error codes is returned.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-ENOENT - Requested block doesn't exist.
- *
- * %-EEXIST - Blocks conflict is detected.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EEXIST	- Block conflict detected.
+ * * %-EINVAL	- Invalid virtual block descriptor.
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Requested block doesn't exist.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_move_inode_block(struct inode *inode,
 					struct nilfs_vdesc *vdesc,
 					struct list_head *buffers)
 {
 	struct buffer_head *bh;
+	__u64 limit_blkidx = (__u64)inode->i_sb->s_maxbytes >> inode->i_blkbits;
 	int ret;
 
-	if (vdesc->vd_flags == 0)
+	/*
+	 * vblocknr 0 is reserved as an invalid pointer.  Also, limit_blkidx
+	 * ensures that the page index converted from vd_vblocknr never
+	 * overflows the page cache limit and respects the architecture's bmap
+	 * key width.
+	 */
+	if (unlikely(vdesc->vd_vblocknr == 0 ||
+			vdesc->vd_vblocknr >= limit_blkidx))
+		return -EINVAL;
+
+	if (vdesc->vd_flags == 0) {
+		if (unlikely(vdesc->vd_offset >= limit_blkidx))
+			return -EINVAL;
+
 		ret = nilfs_gccache_submit_read_data(
 			inode, vdesc->vd_offset, vdesc->vd_blocknr,
 			vdesc->vd_vblocknr, &bh);
-	else
+	} else {
 		ret = nilfs_gccache_submit_read_node(
 			inode, vdesc->vd_blocknr, vdesc->vd_vblocknr, &bh);
+	}
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
@@ -590,8 +586,8 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
  * blocks that garbage collector specified with the array of nilfs_vdesc
  * structures and stores them into page caches of GC inodes.
  *
- * Return Value: Number of processed nilfs_vdesc structures or
- * error code, otherwise.
+ * Return: Number of processed nilfs_vdesc structures on success, or
+ * a negative error code on failure.
  */
 static int nilfs_ioctl_move_blocks(struct super_block *sb,
 				   struct nilfs_argv *argv, void *buf)
@@ -668,14 +664,11 @@ static int nilfs_ioctl_move_blocks(struct super_block *sb,
  * in the period from p_start to p_end, excluding p_end itself. The checkpoints
  * which have been already deleted are ignored.
  *
- * Return Value: Number of processed nilfs_period structures or
- * error code, otherwise.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EINVAL - invalid checkpoints.
+ * Return: Number of processed nilfs_period structures on success, or one of
+ * the following negative error codes on failure:
+ * * %-EINVAL	- invalid checkpoints.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_delete_checkpoints(struct the_nilfs *nilfs,
 					  struct nilfs_argv *argv, void *buf)
@@ -703,14 +696,11 @@ static int nilfs_ioctl_delete_checkpoints(struct the_nilfs *nilfs,
  * Description: nilfs_ioctl_free_vblocknrs() function frees
  * the virtual block numbers specified by @buf and @argv->v_nmembs.
  *
- * Return Value: Number of processed virtual block numbers or
- * error code, otherwise.
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-ENOENT - The virtual block number have not been allocated.
+ * Return: Number of processed virtual block numbers on success, or one of the
+ * following negative error codes on failure:
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Unallocated virtual block number.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_free_vblocknrs(struct the_nilfs *nilfs,
 				      struct nilfs_argv *argv, void *buf)
@@ -732,14 +722,11 @@ static int nilfs_ioctl_free_vblocknrs(struct the_nilfs *nilfs,
  * Description: nilfs_ioctl_mark_blocks_dirty() function marks
  * metadata file or data blocks as dirty.
  *
- * Return Value: Number of processed block descriptors or
- * error code, otherwise.
- *
- * %-ENOMEM - Insufficient memory available.
- *
- * %-EIO - I/O error
- *
- * %-ENOENT - the specified block does not exist (hole block)
+ * Return: Number of processed block descriptors on success, or one of the
+ * following negative error codes on failure:
+ * * %-EIO	- I/O error.
+ * * %-ENOENT	- Non-existent block (hole block).
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_mark_blocks_dirty(struct the_nilfs *nilfs,
 					 struct nilfs_argv *argv, void *buf)
@@ -844,7 +831,7 @@ int nilfs_ioctl_prepare_clean_segments(struct the_nilfs *nilfs,
  * from userspace. The NILFS_IOCTL_CLEAN_SEGMENTS ioctl is used by
  * nilfs_cleanerd daemon.
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 				      unsigned int cmd, void __user *argp)
@@ -970,20 +957,14 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
  * and metadata are written out to the device when it successfully
  * returned.
  *
- * Return Value: On success, 0 is retured. On errors, one of the following
- * negative error code is returned.
- *
- * %-EROFS - Read only filesystem.
- *
- * %-EIO - I/O error
- *
- * %-ENOSPC - No space left on device (only in a panic state).
- *
- * %-ERESTARTSYS - Interrupted.
- *
- * %-ENOMEM - Insufficient memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT		- Failure during execution of requested operation.
+ * * %-EIO		- I/O error.
+ * * %-ENOMEM		- Insufficient memory available.
+ * * %-ENOSPC		- No space left on device (only in a panic state).
+ * * %-ERESTARTSYS	- Interrupted.
+ * * %-EROFS		- Read only filesystem.
  */
 static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
 			    unsigned int cmd, void __user *argp)
@@ -1017,7 +998,7 @@ static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
  * @filp: file object
  * @argp: pointer on argument from userspace
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
 			      void __user *argp)
@@ -1053,7 +1034,7 @@ static int nilfs_ioctl_resize(struct inode *inode, struct file *filp,
  * checks the arguments from userspace and calls nilfs_sufile_trim_fs, which
  * performs the actual trim operation.
  *
- * Return Value: On success, 0 is returned or negative error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
 {
@@ -1095,7 +1076,7 @@ static int nilfs_ioctl_trim_fs(struct inode *inode, void __user *argp)
  * of segments in bytes and upper limit of segments in bytes.
  * The NILFS_IOCTL_SET_ALLOC_RANGE is used by nilfs_resize utility.
  *
- * Return Value: On success, 0 is returned or error code, otherwise.
+ * Return: 0 on success, or a negative error code on failure.
  */
 static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
 {
@@ -1146,17 +1127,15 @@ static int nilfs_ioctl_set_alloc_range(struct inode *inode, void __user *argp)
  * @dofunc: concrete function of getting metadata info
  *
  * Description: nilfs_ioctl_get_info() gets metadata info by means of
- * calling dofunc() function.
- *
- * Return Value: On success, 0 is returned and requested metadata info
- * is copied into userspace. On error, one of the following
- * negative error codes is returned.
- *
- * %-EINVAL - Invalid arguments from userspace.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EFAULT - Failure during execution of requested operation.
+ * calling dofunc() function.  The requested metadata information is copied
+ * to userspace memory @argp.
+ *
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EFAULT	- Failure during execution of requested operation.
+ * * %-EINVAL	- Invalid arguments from userspace.
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
  */
 static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
 				unsigned int cmd, void __user *argp,
@@ -1196,18 +1175,14 @@ static int nilfs_ioctl_get_info(struct inode *inode, struct file *filp,
  * encapsulated in nilfs_argv and updates the segment usage info
  * according to the flags in nilfs_suinfo_update.
  *
- * Return Value: On success, 0 is returned. On error, one of the
- * following negative error codes is returned.
- *
- * %-EPERM - Not enough permissions
- *
- * %-EFAULT - Error copying input data
- *
- * %-EIO - I/O error.
- *
- * %-ENOMEM - Insufficient amount of memory available.
- *
- * %-EINVAL - Invalid values in input (segment number, flags or nblocks)
+ * Return: 0 on success, or one of the following negative error codes on
+ * failure:
+ * * %-EEXIST	- Block conflict detected.
+ * * %-EFAULT	- Error copying input data.
+ * * %-EINVAL	- Invalid values in input (segment number, flags or nblocks).
+ * * %-EIO	- I/O error.
+ * * %-ENOMEM	- Insufficient memory available.
+ * * %-EPERM	- Not enough permissions.
  */
 static int nilfs_ioctl_set_suinfo(struct inode *inode, struct file *filp,
 				unsigned int cmd, void __user *argp)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index a321d4c293a9..515b645f7abc 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -620,6 +620,7 @@ struct hid_device {							/* device report descriptor */
 	__s32 battery_max;
 	__s32 battery_report_type;
 	__s32 battery_report_id;
+	__s32 battery_report_offset;					/* bit offset of the capacity field within its report */
 	enum hid_battery_status battery_status;
 	bool battery_avoid_query;
 	ktime_t battery_ratelimit_time;
diff --git a/include/linux/inetdevice.h b/include/linux/inetdevice.h
index a038feb63f23..3990f74806e0 100644
--- a/include/linux/inetdevice.h
+++ b/include/linux/inetdevice.h
@@ -277,6 +277,11 @@ static inline void in_dev_put(struct in_device *idev)
 #define __in_dev_put(idev)  refcount_dec(&(idev)->refcnt)
 #define in_dev_hold(idev)   refcount_inc(&(idev)->refcnt)
 
+static inline bool in_dev_hold_safe(struct in_device *idev)
+{
+	return refcount_inc_not_zero(&idev->refcnt);
+}
+
 #endif /* __KERNEL__ */
 
 static __inline__ __be32 inet_make_mask(int logmask)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 94fa0184c153..8531f375d061 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1622,8 +1622,8 @@ enum {
 	NVME_SC_HOST_PATH_ERROR		= 0x370,
 	NVME_SC_HOST_ABORTED_CMD	= 0x371,
 
-	NVME_SC_CRD			= 0x1800,
-	NVME_SC_DNR			= 0x4000,
+	NVME_STATUS_CRD			= 0x1800,
+	NVME_STATUS_DNR			= 0x4000,
 };
 
 struct nvme_completion {
diff --git a/include/linux/sched.h b/include/linux/sched.h
index df4817deee20..561fb81675fa 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1398,6 +1398,14 @@ struct task_struct {
 
 	/* Collect coverage from softirq context: */
 	unsigned int			kcov_softirq;
+
+	/* Temporary storage for preempting remote coverage collection: */
+	unsigned int			kcov_saved_mode;
+	unsigned int			kcov_saved_size;
+	void				*kcov_saved_area;
+	struct kcov			*kcov_saved_kcov;
+	int				kcov_saved_sequence;
+
 #endif
 
 #ifdef CONFIG_MEMCG
diff --git a/include/target/target_core_fabric.h b/include/target/target_core_fabric.h
index 3c5ade7a04a6..90724365d4df 100644
--- a/include/target/target_core_fabric.h
+++ b/include/target/target_core_fabric.h
@@ -94,6 +94,8 @@ struct target_core_fabric_ops {
 				struct se_lun *);
 	void (*fabric_pre_unlink)(struct se_portal_group *,
 				struct se_lun *);
+	void (*fabric_post_unlink)(struct se_portal_group *se_tpg,
+				   struct se_lun *lun);
 	struct se_tpg_np *(*fabric_make_np)(struct se_portal_group *,
 				struct config_group *, const char *);
 	void (*fabric_drop_np)(struct se_tpg_np *);
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index edcb5af514b5..f57743d911b4 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -195,9 +195,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = wqe->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&worker->wqe->lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&worker->wqe->lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&worker->wqe->lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&worker->wqe->lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);
diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index fcdd28224f53..b3850bd8a2c5 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -274,9 +274,8 @@ static struct ns_common *bpf_prog_offload_info_fill_ns(void *private_data)
 
 	if (aux->offload) {
 		args->info->ifindex = aux->offload->netdev->ifindex;
-		net = dev_net(aux->offload->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(aux->offload->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
@@ -501,9 +500,8 @@ static struct ns_common *bpf_map_offload_info_fill_ns(void *private_data)
 
 	if (args->offmap->netdev) {
 		args->info->ifindex = args->offmap->netdev->ifindex;
-		net = dev_net(args->offmap->netdev);
-		get_net(net);
-		ns = &net->ns;
+		net = maybe_get_net(dev_net(args->offmap->netdev));
+		ns = net ? &net->ns : NULL;
 	} else {
 		args->info->ifindex = 0;
 		ns = NULL;
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3260a65a9def..84c3da9c481f 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -84,19 +84,17 @@ struct kcov_remote {
 
 static DEFINE_SPINLOCK(kcov_remote_lock);
 static DEFINE_HASHTABLE(kcov_remote_map, 4);
-static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
+static struct list_head kcov_remote_areas[2] = {
+	LIST_HEAD_INIT(kcov_remote_areas[0]), LIST_HEAD_INIT(kcov_remote_areas[1])
+};
 
 struct kcov_percpu_data {
-	void			*irq_area;
-
-	unsigned int		saved_mode;
-	unsigned int		saved_size;
-	void			*saved_area;
-	struct kcov		*saved_kcov;
-	int			saved_sequence;
+	local_lock_t		lock;
 };
 
-static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
+	.lock = INIT_LOCAL_LOCK(lock),
+};
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -127,12 +125,13 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 }
 
 /* Must be called with kcov_remote_lock locked. */
-static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
+static struct kcov_remote_area *kcov_remote_area_get(unsigned int size, bool irq)
 {
 	struct kcov_remote_area *area;
 	struct list_head *pos;
+	struct list_head *list = &kcov_remote_areas[irq];
 
-	list_for_each(pos, &kcov_remote_areas) {
+	list_for_each(pos, list) {
 		area = list_entry(pos, struct kcov_remote_area, list);
 		if (area->size == size) {
 			list_del(&area->list);
@@ -144,11 +143,11 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 
 /* Must be called with kcov_remote_lock locked. */
 static void kcov_remote_area_put(struct kcov_remote_area *area,
-					unsigned int size)
+				 unsigned int size, bool irq)
 {
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
-	list_add(&area->list, &kcov_remote_areas);
+	list_add(&area->list, &kcov_remote_areas[irq]);
 }
 
 /*
@@ -366,6 +365,12 @@ void kcov_task_init(struct task_struct *t)
 {
 	kcov_task_reset(t);
 	t->kcov_handle = current->kcov_handle;
+	t->kcov_softirq = 0;
+	t->kcov_saved_mode = 0;
+	t->kcov_saved_size = 0;
+	t->kcov_saved_area = NULL;
+	t->kcov_saved_kcov = NULL;
+	t->kcov_saved_sequence = 0;
 }
 
 static void kcov_reset(struct kcov *kcov)
@@ -787,34 +792,31 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 
 static void kcov_remote_softirq_start(struct task_struct *t)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
 	unsigned int mode;
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (kcov_mode_enabled(mode)) {
-		data->saved_mode = mode;
-		data->saved_size = t->kcov_size;
-		data->saved_area = t->kcov_area;
-		data->saved_sequence = t->kcov_sequence;
-		data->saved_kcov = t->kcov;
+		t->kcov_saved_mode = mode;
+		t->kcov_saved_size = t->kcov_size;
+		t->kcov_saved_area = t->kcov_area;
+		t->kcov_saved_sequence = t->kcov_sequence;
+		t->kcov_saved_kcov = t->kcov;
 		kcov_stop(t);
 	}
 }
 
 static void kcov_remote_softirq_stop(struct task_struct *t)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
-
-	if (data->saved_kcov) {
-		kcov_start(t, data->saved_kcov, data->saved_size,
-				data->saved_area, data->saved_mode,
-				data->saved_sequence);
-		data->saved_mode = 0;
-		data->saved_size = 0;
-		data->saved_area = NULL;
-		data->saved_sequence = 0;
-		data->saved_kcov = NULL;
+	if (t->kcov_saved_kcov) {
+		kcov_start(t, t->kcov_saved_kcov, t->kcov_saved_size,
+			   t->kcov_saved_area, t->kcov_saved_mode,
+			   t->kcov_saved_sequence);
+		t->kcov_saved_mode = 0;
+		t->kcov_saved_size = 0;
+		t->kcov_saved_area = NULL;
+		t->kcov_saved_sequence = 0;
+		t->kcov_saved_kcov = NULL;
 	}
 }
 
@@ -834,7 +836,7 @@ void kcov_remote_start(u64 handle)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
 
 	/*
 	 * Check that kcov_remote_start() is not called twice in background
@@ -842,7 +844,7 @@ void kcov_remote_start(u64 handle)
 	 */
 	mode = READ_ONCE(t->kcov_mode);
 	if (WARN_ON(in_task() && kcov_mode_enabled(mode))) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -851,14 +853,15 @@ void kcov_remote_start(u64 handle)
 	 * happened while collecting coverage from a background thread.
 	 */
 	if (WARN_ON(in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 
 	spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		spin_unlock_irqrestore(&kcov_remote_lock, flags);
+		spin_unlock(&kcov_remote_lock);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	kcov_debug("handle = %llx, context: %s\n", handle,
@@ -874,24 +877,24 @@ void kcov_remote_start(u64 handle)
 	sequence = kcov->sequence;
 	if (in_task()) {
 		size = kcov->remote_size;
-		area = kcov_remote_area_get(size);
+		area = kcov_remote_area_get(size, false);
 	} else {
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
-		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
+		area = kcov_remote_area_get(size, true);
 	}
-	spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	spin_unlock(&kcov_remote_lock);
 
-	/* Can only happen when in_task(). */
+	/* Allocate new buffer if we can sleep. */
 	if (!area) {
-		area = vmalloc(size * sizeof(unsigned long));
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
+		area = in_task() ? vmalloc(size * sizeof(unsigned long)) : NULL;
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
+		local_lock_irqsave(&kcov_percpu_data.lock, flags);
 	}
 
-	local_irq_save(flags);
-
 	/* Reset coverage size. */
 	*(u64 *)area = 0;
 
@@ -901,7 +904,7 @@ void kcov_remote_start(u64 handle)
 	}
 	kcov_start(t, kcov, size, area, mode, sequence);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -975,12 +978,12 @@ void kcov_remote_stop(void)
 	if (!in_task() && !in_softirq_really())
 		return;
 
-	local_irq_save(flags);
+	local_lock_irqsave(&kcov_percpu_data.lock, flags);
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (!kcov_mode_enabled(mode)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/*
@@ -988,12 +991,12 @@ void kcov_remote_stop(void)
 	 * actually found the remote handle and started collecting coverage.
 	 */
 	if (in_serving_softirq() && !t->kcov_softirq) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 	/* Make sure that kcov_softirq is only set when in softirq. */
 	if (WARN_ON(!in_serving_softirq() && t->kcov_softirq)) {
-		local_irq_restore(flags);
+		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 		return;
 	}
 
@@ -1017,13 +1020,11 @@ void kcov_remote_stop(void)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
 	spin_unlock(&kcov->lock);
 
-	if (in_task()) {
-		spin_lock(&kcov_remote_lock);
-		kcov_remote_area_put(area, size);
-		spin_unlock(&kcov_remote_lock);
-	}
+	spin_lock(&kcov_remote_lock);
+	kcov_remote_area_put(area, size, !in_task());
+	spin_unlock(&kcov_remote_lock);
 
-	local_irq_restore(flags);
+	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 
 	/* Get in kcov_remote_start(). */
 	kcov_put(kcov);
@@ -1041,14 +1042,21 @@ EXPORT_SYMBOL(kcov_common_handle);
 
 static int __init kcov_init(void)
 {
-	int cpu;
+	int cpu = num_possible_cpus();
+
+#ifdef CONFIG_PREEMPT_RT
+	/* Allocate some extra buffers in order to prepare for softirq preemption. */
+	cpu = cpu >= 4 ? cpu * 2 : cpu + 4;
+#endif
+	while (cpu--) {
+		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE * sizeof(unsigned long));
+		unsigned long flags;
 
-	for_each_possible_cpu(cpu) {
-		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE *
-				sizeof(unsigned long));
 		if (!area)
 			return -ENOMEM;
-		per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area = area;
+		spin_lock_irqsave(&kcov_remote_lock, flags);
+		kcov_remote_area_put(area, CONFIG_KCOV_IRQ_AREA_SIZE, true);
+		spin_unlock_irqrestore(&kcov_remote_lock, flags);
 	}
 
 	/*
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index db4f8ac489d4..6749581d920e 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2032,10 +2032,11 @@ config KCOV_INSTRUMENT_ALL
 config KCOV_IRQ_AREA_SIZE
 	hex "Size of interrupt coverage collection area in words"
 	depends on KCOV
+	range 0x80 0x1000000
 	default 0x40000
 	help
-	  KCOV uses preallocated per-cpu areas to collect coverage from
-	  soft interrupts. This specifies the size of those areas in the
+	  KCOV uses preallocated areas to collect coverage from soft
+	  interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
 menuconfig RUNTIME_TESTING_MENU
diff --git a/mm/swapfile.c b/mm/swapfile.c
index c9b9053c7969..04f10e9c36c5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3209,6 +3209,13 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
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
 	 * Read the swap header.
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 6fc431e0c424..66c23203c3d3 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4113,8 +4113,8 @@ void br_multicast_toggle_one_vlan(struct net_bridge_vlan *vlan, bool on)
 	if (br_vlan_is_master(vlan)) {
 		br = vlan->br;
 
-		if (!br_vlan_is_brentry(vlan) ||
-		    (on &&
+		if (on &&
+		    (!br_vlan_is_brentry(vlan) ||
 		     br_multicast_ctx_vlan_global_disabled(&vlan->br_mcast_ctx)))
 			return;
 
diff --git a/net/can/j1939/j1939-priv.h b/net/can/j1939/j1939-priv.h
index 31a93cae5111..81f58924b4ac 100644
--- a/net/can/j1939/j1939-priv.h
+++ b/net/can/j1939/j1939-priv.h
@@ -212,6 +212,7 @@ void j1939_priv_get(struct j1939_priv *priv);
 
 /* notify/alert all j1939 sockets bound to ifindex */
 void j1939_sk_netdev_event_netdown(struct j1939_priv *priv);
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv);
 int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk);
 void j1939_tp_init(struct j1939_priv *priv);
 
diff --git a/net/can/j1939/main.c b/net/can/j1939/main.c
index cc03ea2f897f..503d344fe628 100644
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -373,6 +373,11 @@ static int j1939_netdev_notify(struct notifier_block *nb,
 		j1939_sk_netdev_event_netdown(priv);
 		j1939_ecu_unmap_all(priv);
 		break;
+	case NETDEV_UNREGISTER:
+		j1939_cancel_active_session(priv, NULL);
+		j1939_sk_netdev_event_netdown(priv);
+		j1939_sk_netdev_event_unregister(priv);
+		break;
 	}
 
 	j1939_priv_put(priv);
diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 540836c4964d..c088f1d8150f 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -481,6 +481,12 @@ static int j1939_sk_bind(struct socket *sock, struct sockaddr *uaddr, int len)
 			goto out_release_sock;
 		}
 
+		if (ndev->reg_state != NETREG_REGISTERED) {
+			dev_put(ndev);
+			ret = -ENODEV;
+			goto out_release_sock;
+		}
+
 		can_ml = can_get_ml_priv(ndev);
 		if (!can_ml) {
 			dev_put(ndev);
@@ -1298,6 +1304,55 @@ void j1939_sk_netdev_event_netdown(struct j1939_priv *priv)
 	read_unlock_bh(&priv->j1939_socks_lock);
 }
 
+void j1939_sk_netdev_event_unregister(struct j1939_priv *priv)
+{
+	struct sock *sk;
+	struct j1939_sock *jsk;
+	bool wait_rcu = false;
+
+rescan: /* The caller is holding a ref on this "priv" via j1939_priv_get_by_ndev(). */
+	read_lock_bh(&priv->j1939_socks_lock);
+	list_for_each_entry(jsk, &priv->j1939_socks, list) {
+		/* Skip if j1939_jsk_add() is not called on this socket. */
+		if (!(jsk->state & J1939_SOCK_BOUND))
+			continue;
+		sk = &jsk->sk;
+		sock_hold(sk);
+		read_unlock_bh(&priv->j1939_socks_lock);
+		/* Check if j1939_jsk_del() is not yet called on this socket after holding
+		 * socket's lock, for both j1939_sk_bind() and j1939_sk_release() call
+		 * j1939_jsk_del() with socket's lock held.
+		 */
+		lock_sock(sk);
+		if (jsk->state & J1939_SOCK_BOUND) {
+			/* Neither j1939_sk_bind() nor j1939_sk_release() called j1939_jsk_del().
+			 * Make this socket no longer bound, by pretending as if j1939_sk_bind()
+			 * dropped old references but did not get new references.
+			 */
+			j1939_jsk_del(priv, jsk);
+			j1939_local_ecu_put(priv, jsk->addr.src_name, jsk->addr.sa);
+			j1939_netdev_stop(priv);
+			/* Call j1939_priv_put() now and prevent j1939_sk_sock_destruct() from
+			 * calling the corresponding j1939_priv_put().
+			 *
+			 * j1939_sk_sock_destruct() is supposed to call j1939_priv_put() after
+			 * an RCU grace period. But since the caller is holding a ref on this
+			 * "priv", we can defer synchronize_rcu() until immediately before
+			 * the caller calls j1939_priv_put().
+			 */
+			j1939_priv_put(priv);
+			jsk->priv = NULL;
+			wait_rcu = true;
+		}
+		release_sock(sk);
+		sock_put(sk);
+		goto rescan;
+	}
+	read_unlock_bh(&priv->j1939_socks_lock);
+	if (wait_rcu)
+		synchronize_rcu();
+}
+
 static int j1939_sk_no_ioctlcmd(struct socket *sock, unsigned int cmd,
 				unsigned long arg)
 {
diff --git a/net/core/filter.c b/net/core/filter.c
index af34e922836c..6c81daf9efc9 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10419,7 +10419,6 @@ const struct bpf_verifier_ops lwt_seg6local_verifier_ops = {
 };
 
 const struct bpf_prog_ops lwt_seg6local_prog_ops = {
-	.test_run		= bpf_prog_test_run_skb,
 };
 
 const struct bpf_verifier_ops cg_sock_verifier_ops = {
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index f47f3972f981..ed0e342e9bc6 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -232,16 +232,20 @@ static void igmp_gq_start_timer(struct in_device *in_dev)
 		return;
 
 	in_dev->mr_gq_running = 1;
-	if (!mod_timer(&in_dev->mr_gq_timer, exp))
-		in_dev_hold(in_dev);
+	if (in_dev_hold_safe(in_dev)) {
+		if (mod_timer(&in_dev->mr_gq_timer, exp))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_ifc_start_timer(struct in_device *in_dev, int delay)
 {
-	int tv = prandom_u32() % delay;
+	if (in_dev_hold_safe(in_dev)) {
+		int tv = prandom_u32() % delay;
 
-	if (!mod_timer(&in_dev->mr_ifc_timer, jiffies+tv+2))
-		in_dev_hold(in_dev);
+		if (mod_timer(&in_dev->mr_ifc_timer, jiffies + tv + 2))
+			in_dev_put(in_dev);
+	}
 }
 
 static void igmp_mod_timer(struct ip_mc_list *im, int max_delay)
diff --git a/net/ipv6/ah6.c b/net/ipv6/ah6.c
index 2d2a7a60e4a8..b2172bc6a097 100644
--- a/net/ipv6/ah6.c
+++ b/net/ipv6/ah6.c
@@ -235,26 +235,28 @@ static void ipv6_rearrange_destopt(struct ipv6hdr *iph, struct ipv6_opt_hdr *des
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
@@ -264,6 +266,8 @@ static void ipv6_rearrange_rthdr(struct ipv6hdr *iph, struct ipv6_rt_hdr *rthdr)
 
 	addrs[0] = iph->daddr;
 	iph->daddr = final_addr;
+
+	return 0;
 }
 
 static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
@@ -276,6 +280,7 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 	} exthdr = { .iph = iph };
 	char *end = exthdr.raw + len;
 	int nexthdr = iph->nexthdr;
+	int err;
 
 	exthdr.iph++;
 
@@ -295,7 +300,9 @@ static int ipv6_clear_mutable_options(struct ipv6hdr *iph, int len, int dir)
 			break;
 
 		case NEXTHDR_ROUTING:
-			ipv6_rearrange_rthdr(iph, exthdr.rth);
+			err = ipv6_rearrange_rthdr(iph, exthdr.rth);
+			if (err)
+				return err;
 			break;
 
 		default:
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index 98af48b3fcce..8e27c1ac781e 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -193,6 +193,13 @@ static bool decap_and_validate(struct sk_buff *skb, int proto)
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
 
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 9e199f00eea7..40a1d31b4054 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -718,15 +718,13 @@ int
 ip_vs_bypass_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 		  struct ip_vs_protocol *pp, struct ip_vs_iphdr *ipvsh)
 {
-	struct iphdr  *iph = ip_hdr(skb);
-
 	EnterFunction(10);
 
-	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, iph->daddr,
+	if (__ip_vs_get_out_rt(cp->ipvs, cp->af, skb, NULL, ip_hdr(skb)->daddr,
 			       IP_VS_RT_MODE_NON_LOCAL, NULL, ipvsh) < 0)
 		goto tx_error;
 
-	ip_send_check(iph);
+	ip_send_check(ip_hdr(skb));
 
 	/* Another hack: avoid icmp_send in ip_fragment */
 	skb->ignore_df = 1;
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 59e349957e7a..a853f5dfd0c4 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
 
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, 20);
+		data_len--;
+		nfca_poll->rats_res_len = min_t(__u8, nfca_poll->rats_res_len, data_len);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 		break;
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
+		nfcb_poll->attrib_res_len = min_t(__u8, nfcb_poll->attrib_res_len, data_len);
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
 			memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll = &ntf->activation_params.poll_nfc_dep;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
+		poll->atr_res_len = min_t(__u8, poll->atr_res_len, data_len);
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
 		if (poll->atr_res_len > 0)
 			memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen = &ntf->activation_params.listen_nfc_dep;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
+		listen->atr_req_len = min_t(__u8, listen->atr_req_len, data_len);
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
 		if (listen->atr_req_len > 0)
 			memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -790,12 +806,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
 			err = nci_extract_activation_params_iso_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_NFC_DEP:
 			err = nci_extract_activation_params_nfc_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_FRAME:
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 37614dcf1919..f6119f29b44c 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1612,35 +1612,32 @@ static int smc_vlan_by_tcpsk_walk(struct net_device *lower_dev,
 /* Determine vlan of internal TCP socket. */
 int smc_vlan_by_tcpsk(struct socket *clcsock, struct smc_init_info *ini)
 {
-	struct dst_entry *dst = sk_dst_get(clcsock->sk);
 	struct netdev_nested_priv priv;
 	struct net_device *ndev;
+	struct dst_entry *dst;
 	int rc = 0;
 
 	ini->vlan_id = 0;
-	if (!dst) {
-		rc = -ENOTCONN;
-		goto out;
-	}
-	if (!dst->dev) {
+
+	rcu_read_lock();
+
+	dst = __sk_dst_get(clcsock->sk);
+	ndev = dst ? dst_dev_rcu(dst) : NULL;
+	if (!ndev) {
 		rc = -ENODEV;
-		goto out_rel;
+		goto out;
 	}
 
-	ndev = dst->dev;
 	if (is_vlan_dev(ndev)) {
 		ini->vlan_id = vlan_dev_vlan_id(ndev);
-		goto out_rel;
+		goto out;
 	}
 
 	priv.data = (void *)&ini->vlan_id;
-	rtnl_lock();
-	netdev_walk_all_lower_dev(ndev, smc_vlan_by_tcpsk_walk, &priv);
-	rtnl_unlock();
-
-out_rel:
-	dst_release(dst);
+	netdev_walk_all_lower_dev_rcu(ndev, smc_vlan_by_tcpsk_walk, &priv);
 out:
+	rcu_read_unlock();
+
 	return rc;
 }
 
diff --git a/net/xfrm/espintcp.c b/net/xfrm/espintcp.c
index 59247f0bd4e7..47212b6f917a 100644
--- a/net/xfrm/espintcp.c
+++ b/net/xfrm/espintcp.c
@@ -38,6 +38,11 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 
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
@@ -46,6 +51,7 @@ static void handle_esp(struct sk_buff *skb, struct sock *sk)
 #endif
 		xfrm4_rcv_encap(skb, IPPROTO_ESP, 0, TCP_ENCAP_ESPINTCP);
 	local_bh_enable();
+out:
 	rcu_read_unlock();
 }
 
@@ -508,7 +514,8 @@ static void espintcp_close(struct sock *sk, long timeout)
 	strp_stop(&ctx->strp);
 
 	sk->sk_prot = &tcp_prot;
-	barrier();
+
+	synchronize_rcu();
 
 	cancel_work_sync(&ctx->work);
 	strp_done(&ctx->strp);
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index c07b95e31822..cd83ac8f8f56 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -614,7 +614,7 @@ static struct xfrm_state *xfrm_state_construct(struct net *net,
 	if ((err = attach_auth_trunc(&x->aalg, &x->props.aalgo,
 				     attrs[XFRMA_ALG_AUTH_TRUNC])))
 		goto error;
-	if (!x->props.aalgo) {
+	if (!x->aalg) {
 		if ((err = attach_auth(&x->aalg, &x->props.aalgo,
 				       attrs[XFRMA_ALG_AUTH])))
 			goto error;
diff --git a/security/selinux/ss/conditional.c b/security/selinux/ss/conditional.c
index feb206f3acb4..12a2c5ef8081 100644
--- a/security/selinux/ss/conditional.c
+++ b/security/selinux/ss/conditional.c
@@ -166,9 +166,9 @@ void cond_policydb_destroy(struct policydb *p)
 int cond_init_bool_indexes(struct policydb *p)
 {
 	kfree(p->bool_val_to_struct);
-	p->bool_val_to_struct = kmalloc_array(p->p_bools.nprim,
-					      sizeof(*p->bool_val_to_struct),
-					      GFP_KERNEL);
+	p->bool_val_to_struct = kcalloc(p->p_bools.nprim,
+					sizeof(*p->bool_val_to_struct),
+					GFP_KERNEL);
 	if (!p->bool_val_to_struct)
 		return -ENOMEM;
 	return 0;
@@ -716,9 +716,9 @@ static int duplicate_policydb_bools(struct policydb *newdb,
 	struct cond_bool_datum **cond_bool_array;
 	int rc;
 
-	cond_bool_array = kmalloc_array(orig->p_bools.nprim,
-					sizeof(*orig->bool_val_to_struct),
-					GFP_KERNEL);
+	cond_bool_array = kcalloc(orig->p_bools.nprim,
+				  sizeof(*orig->bool_val_to_struct),
+				  GFP_KERNEL);
 	if (!cond_bool_array)
 		return -ENOMEM;
 
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index f319e4298b87..38671c4737f5 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1877,15 +1877,14 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		if (substream->wait_time) {
 			wait_time = substream->wait_time;
 		} else {
-			wait_time = 10;
+			wait_time = 100;
 
 			if (runtime->rate) {
-				long t = runtime->period_size * 2 /
-					 runtime->rate;
+				long t = runtime->buffer_size * 1100 / runtime->rate;
 				wait_time = max(t, wait_time);
 			}
-			wait_time = msecs_to_jiffies(wait_time * 1000);
 		}
+		wait_time = msecs_to_jiffies(wait_time);
 	}
 
 	for (;;) {
@@ -1933,8 +1932,8 @@ static int wait_for_avail(struct snd_pcm_substream *substream,
 		}
 		if (!tout) {
 			pcm_dbg(substream->pcm,
-				"%s write error (DMA or IRQ trouble?)\n",
-				is_playback ? "playback" : "capture");
+				"%s timeout (DMA or IRQ trouble?)\n",
+				is_playback ? "playback write" : "capture read");
 			err = -EIO;
 			break;
 		}
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 94e3e3ba6a33..e45ca7793959 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2144,6 +2144,10 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 	for (;;) {
 		long tout;
 		struct snd_pcm_runtime *to_check;
+		unsigned int drain_rate;
+		snd_pcm_uframes_t drain_bufsz;
+		bool drain_no_period_wakeup;
+
 		if (signal_pending(current)) {
 			result = -ERESTARTSYS;
 			break;
@@ -2163,19 +2167,27 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		snd_pcm_group_unref(group, substream);
 		if (!to_check)
 			break; /* all drained */
-		init_waitqueue_entry(&wait, current);
-		set_current_state(TASK_INTERRUPTIBLE);
-		add_wait_queue(&to_check->sleep, &wait);
+		/*
+		 * Cache the runtime fields needed after unlock.
+		 * A concurrent close() on the linked stream may free
+		 * its runtime via snd_pcm_detach_substream() once we
+		 * release the stream lock below.
+		 */
+		drain_no_period_wakeup = to_check->no_period_wakeup;
+		drain_rate = to_check->rate;
+		drain_bufsz = to_check->buffer_size;
+		init_wait_entry(&wait, 0);
+		prepare_to_wait(&to_check->sleep, &wait, TASK_INTERRUPTIBLE);
 		snd_pcm_stream_unlock_irq(substream);
-		if (runtime->no_period_wakeup)
+		if (drain_no_period_wakeup)
 			tout = MAX_SCHEDULE_TIMEOUT;
 		else {
-			tout = 10;
-			if (runtime->rate) {
-				long t = runtime->period_size * 2 / runtime->rate;
+			tout = 100;
+			if (drain_rate) {
+				long t = drain_bufsz * 1100 / drain_rate;
 				tout = max(t, tout);
 			}
-			tout = msecs_to_jiffies(tout * 1000);
+			tout = msecs_to_jiffies(tout);
 		}
 		tout = schedule_timeout(tout);
 
@@ -2183,7 +2195,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 		group = snd_pcm_stream_group_ref(substream);
 		snd_pcm_group_for_each_entry(s, substream) {
 			if (s->runtime == to_check) {
-				remove_wait_queue(&to_check->sleep, &wait);
+				finish_wait(&to_check->sleep, &wait);
 				break;
 			}
 		}
@@ -2198,7 +2210,7 @@ static int snd_pcm_drain(struct snd_pcm_substream *substream,
 				result = -ESTRPIPE;
 			else {
 				dev_dbg(substream->pcm->card->dev,
-					"playback drain error (DMA or IRQ trouble?)\n");
+					"playback drain timeout (DMA or IRQ trouble?)\n");
 				snd_pcm_stop(substream, SNDRV_PCM_STATE_SETUP);
 				result = -EIO;
 			}
diff --git a/sound/soc/tegra/tegra_pcm.c b/sound/soc/tegra/tegra_pcm.c
index ef1e74d95236..e5a2091090cd 100644
--- a/sound/soc/tegra/tegra_pcm.c
+++ b/sound/soc/tegra/tegra_pcm.c
@@ -111,6 +111,9 @@ int tegra_pcm_open(struct snd_soc_component *component,
 		return ret;
 	}
 
+	/* Set wait time to 500ms by default */
+	substream->wait_time = 500;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(tegra_pcm_open);
diff --git a/sound/usb/card.c b/sound/usb/card.c
index 33ffa62032ab..591bb8451f10 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -1121,8 +1121,11 @@ static int usb_audio_resume(struct usb_interface *intf)
 
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
@@ -1131,8 +1134,11 @@ static int usb_audio_resume(struct usb_interface *intf)
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
index f48e1e7e1c80..9610c0711957 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -878,6 +878,8 @@ static void snd_usbmidi_novation_output(struct snd_usb_midi_out_endpoint *ep,
 
 	if (!ep->ports[0].active)
 		return;
+	if (ep->max_transfer < 3)
+		return;
 	transfer_buffer = urb->transfer_buffer;
 	count = snd_rawmidi_transmit(ep->ports[0].substream,
 				     &transfer_buffer[2],
