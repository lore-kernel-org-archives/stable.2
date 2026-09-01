Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FC232B102
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272303; cv=none; b=KAVfs67u5aWYiSFsHIFybYUM7+Idmy4IW9ikZwsunFtGRahzuCdx9sQkmCOuD4L7UstYD9/LWlxDVmC/vH4Xt7X99a0JCEUcdLzb7NnOAXctwU2+TABpbZ3mqx1xtO5o0r4jIi78ytdUYhPKvcw2Y0UvygwMEb8N0xspufwjP+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272303; c=relaxed/simple;
	bh=3Ckw062vAHX8+sV/WaLDvhdKYpXXyYQ8kSagTkJZFJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HVHTvxhM5G0IG4Ae5iNJ/Bbb9Hvc+9YXIIXPfsE9vKLRU6ZX6k5iksnV2vOZxpYzoWUkYElHLY9PBaspESR+RftPX98EwGtrEaSGMcA0OpaagMSZTWpSB/EOdX12ebWcHMVwl3eunHed6AHfEqA8d7Sg1hYucMsohSdKCo3OMm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTpHvDYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTpHvDYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BD0A1F00A3E;
	Tue,  1 Sep 2026 14:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272301;
	bh=bHjw9S3UCM3ri3K4YoZ6igvAc91CEHHnHFd7SosOsOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nTpHvDYFFqmJf4M17+c9WGFUf+PTkDadT7PHbxCbVDBCuFQgXKDlRp7ARbatnMcZI
	 hwmic8nQvznFPrz7dnf3SFj7thKJZ9la6u3s52+wYfCU6X6ZuY3HeFDMwiQLj2jMFi
	 7ni623Zv1bpCujgA79K7W6opxYuie/a16Y5Fns6CruNHHvsHRVvZlz394oaNBFVB+f
	 IQLz6mBmcfSxopMdG7xmrnlT3MsR6+xJJpH3w2F8zwHSxkvgPELwtwx5r1w+VlsMf+
	 vWgg5Vo8h1HSEOKPXTYqRHuixwI0G2ZEEJNNWBPwb6tmuA3nr8rNlhZg2rY+fvcy1x
	 mN9eduhyfxGig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] crypto: virtio - Drop sign/verify operations
Date: Tue,  1 Sep 2026 10:18:15 -0400
Message-ID: <20260901141818.1033381-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901141818.1033381-1-sashal@kernel.org>
References: <2026083110-repugnant-jingle-50dd@gregkh>
 <20260901141818.1033381-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Wunner <lukas@wunner.de>

[ Upstream commit 5b553e06b3215fa97d222ebddc2bc964f1824c5b ]

The virtio crypto driver exposes akcipher sign/verify operations in a
user space ABI.  This blocks removal of sign/verify from akcipher_alg.

Herbert opines:

   "I would say that this is something that we can break.  Breaking it
    is no different to running virtio on a host that does not support
    these algorithms.  After all, a software implementation must always
    be present.

    I deliberately left akcipher out of crypto_user because the API
    is still in flux.  We should not let virtio constrain ourselves."
    https://lore.kernel.org/all/ZtqoNAgcnXnrYhZZ@gondor.apana.org.au/

   "I would remove virtio akcipher support in its entirety.  This API
    was never meant to be exposed outside of the kernel."
    https://lore.kernel.org/all/Ztqql_gqgZiMW8zz@gondor.apana.org.au/

Drop sign/verify support from virtio crypto.  There's no strong reason
to also remove encrypt/decrypt support, so keep it.

A key selling point of virtio crypto is to allow guest access to crypto
accelerators on the host.  So far the only akcipher algorithm supported
by virtio crypto is RSA.  Dropping sign/verify merely means that the
PKCS#1 padding is now always generated or verified inside the guest,
but the actual signature generation/verification (which is an RSA
decrypt/encrypt operation) may still use an accelerator on the host.

Generating or verifying the PKCS#1 padding is cheap, so a hardware
accelerator won't be of much help there.  Which begs the question
whether virtio crypto support for sign/verify makes sense at all.

It would make sense for the sign operation if the host has a security
chip to store asymmetric private keys.  But the kernel doesn't even
have an asymmetric_key_subtype yet for hardware-based private keys.
There's at least one rudimentary driver for such chips (atmel-ecc.c for
ATECC508A), but it doesn't implement the sign operation.  The kernel
would first have to grow support for a hardware asymmetric_key_subtype
and at least one driver implementing the sign operation before exposure
to guests via virtio makes sense.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f77a956f6a19 ("crypto: virtio - bound the akcipher result length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../virtio/virtio_crypto_akcipher_algs.c      | 65 ++++++-------------
 include/uapi/linux/virtio_crypto.h            |  1 +
 2 files changed, 22 insertions(+), 44 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index cb92b7fa99c6f..48fee07b7e517 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -83,23 +83,16 @@ static void virtio_crypto_dataq_akcipher_callback(struct virtio_crypto_request *
 	case VIRTIO_CRYPTO_BADMSG:
 		error = -EBADMSG;
 		break;
-
-	case VIRTIO_CRYPTO_KEY_REJECTED:
-		error = -EKEYREJECTED;
-		break;
-
 	default:
 		error = -EIO;
 		break;
 	}
 
 	akcipher_req = vc_akcipher_req->akcipher_req;
-	if (vc_akcipher_req->opcode != VIRTIO_CRYPTO_AKCIPHER_VERIFY) {
-		/* actuall length maybe less than dst buffer */
-		akcipher_req->dst_len = len - sizeof(vc_req->status);
-		sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
-				    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
-	}
+	/* actual length maybe less than dst buffer */
+	akcipher_req->dst_len = len - sizeof(vc_req->status);
+	sg_copy_from_buffer(akcipher_req->dst, sg_nents(akcipher_req->dst),
+			    vc_akcipher_req->dst_buf, akcipher_req->dst_len);
 	virtio_crypto_akcipher_finalize_req(vc_akcipher_req, akcipher_req, error);
 }
 
@@ -230,36 +223,27 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	int node = dev_to_node(&vcrypto->vdev->dev);
 	unsigned long flags;
 	int ret;
-	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
-	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
 
 	/* out header */
 	sg_init_one(&outhdr_sg, req_data, sizeof(*req_data));
 	sgs[num_out++] = &outhdr_sg;
 
 	/* src data */
-	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
+	src_buf = kcalloc_node(req->src_len, 1, GFP_KERNEL, node);
 	if (!src_buf)
 		return -ENOMEM;
 
-	if (verify) {
-		/* for verify operation, both src and dst data work as OUT direction */
-		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
-		sg_init_one(&srcdata_sg, src_buf, src_len);
-		sgs[num_out++] = &srcdata_sg;
-	} else {
-		sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, src_len);
-		sg_init_one(&srcdata_sg, src_buf, src_len);
-		sgs[num_out++] = &srcdata_sg;
+	sg_copy_to_buffer(req->src, sg_nents(req->src), src_buf, req->src_len);
+	sg_init_one(&srcdata_sg, src_buf, req->src_len);
+	sgs[num_out++] = &srcdata_sg;
 
-		/* dst data */
-		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
-		if (!dst_buf)
-			goto free_src;
+	/* dst data */
+	dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
+	if (!dst_buf)
+		goto free_src;
 
-		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
-		sgs[num_out + num_in++] = &dstdata_sg;
-	}
+	sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
+	sgs[num_out + num_in++] = &dstdata_sg;
 
 	vc_akcipher_req->src_buf = src_buf;
 	vc_akcipher_req->dst_buf = dst_buf;
@@ -352,16 +336,6 @@ static int virtio_crypto_rsa_decrypt(struct akcipher_request *req)
 	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_DECRYPT);
 }
 
-static int virtio_crypto_rsa_sign(struct akcipher_request *req)
-{
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_SIGN);
-}
-
-static int virtio_crypto_rsa_verify(struct akcipher_request *req)
-{
-	return virtio_crypto_rsa_req(req, VIRTIO_CRYPTO_AKCIPHER_VERIFY);
-}
-
 static int virtio_crypto_rsa_set_key(struct crypto_akcipher *tfm,
 				     const void *key,
 				     unsigned int keylen,
@@ -524,16 +498,19 @@ static struct virtio_crypto_akcipher_algo virtio_crypto_akcipher_algs[] = {
 		.algo.base = {
 			.encrypt = virtio_crypto_rsa_encrypt,
 			.decrypt = virtio_crypto_rsa_decrypt,
-			.sign = virtio_crypto_rsa_sign,
-			.verify = virtio_crypto_rsa_verify,
+			/*
+			 * Must specify an arbitrary hash algorithm upon
+			 * set_{pub,priv}_key (even though it's not used
+			 * by encrypt/decrypt) because qemu checks for it.
+			 */
 			.set_pub_key = virtio_crypto_p1pad_rsa_sha1_set_pub_key,
 			.set_priv_key = virtio_crypto_p1pad_rsa_sha1_set_priv_key,
 			.max_size = virtio_crypto_rsa_max_size,
 			.init = virtio_crypto_rsa_init_tfm,
 			.exit = virtio_crypto_rsa_exit_tfm,
 			.base = {
-				.cra_name = "pkcs1pad(rsa,sha1)",
-				.cra_driver_name = "virtio-pkcs1-rsa-with-sha1",
+				.cra_name = "pkcs1pad(rsa)",
+				.cra_driver_name = "virtio-pkcs1-rsa",
 				.cra_priority = 150,
 				.cra_module = THIS_MODULE,
 				.cra_ctxsize = sizeof(struct virtio_crypto_akcipher_ctx),
diff --git a/include/uapi/linux/virtio_crypto.h b/include/uapi/linux/virtio_crypto.h
index 71a54a6849ca9..2fccb64c9d6bf 100644
--- a/include/uapi/linux/virtio_crypto.h
+++ b/include/uapi/linux/virtio_crypto.h
@@ -329,6 +329,7 @@ struct virtio_crypto_op_header {
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x00)
 #define VIRTIO_CRYPTO_AKCIPHER_DECRYPT \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x01)
+	/* akcipher sign/verify opcodes are deprecated */
 #define VIRTIO_CRYPTO_AKCIPHER_SIGN \
 	VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AKCIPHER, 0x02)
 #define VIRTIO_CRYPTO_AKCIPHER_VERIFY \
-- 
2.53.0

