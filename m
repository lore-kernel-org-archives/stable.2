Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC9A409114
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274129; cv=none; b=YbBufOsFNu7ktMcRd3nnC46s6SynTVlaW4l/UWHhMaIYfqApNN0ApkAE7jlXsKeFzncsuNtwXanGi39Nq+W4tZOQ/GmJaChG5OoN4+5/bsKUmhsmRw3wXoM9F7Xt/2nV4u+ssYXWnGHgn5sRdv+mBtg3BoEOPuMZ8fPSS4gogxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274129; c=relaxed/simple;
	bh=yAE/JcdRRGIlaRDqD7Al7T4+uX4Xen1rU9xE44FYIs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YicvP/1Bd6LxjfMOOwOY09oBYhE6yKWZaBls0QZcpVPo3R5kn0rln55L3XTtcOm1sycdMDn2N8ag0PaCWcQ1kDSJmC2ZhdEbfVZq0BldDoTMI0bfBiDSJYspGG6RoS+cML2D2cmhzcIa5SRzNB4CuVRBf2sfxzhJE3335d278mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpANzvkk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpANzvkk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0681F00A3D;
	Tue,  1 Sep 2026 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274127;
	bh=4PwDjfW8pBr2JRX1liaVyo7fVbjaVYXm2pFI3ESt0d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpANzvkkJ4GauYIptVZwTNFyMWMaXokBXlvGGHA7mJ4uTYuk00eFmNnCdkxgXEspa
	 txkJgQfdkRVnlHuv/8VPjsGAbYzsuPkskyyMdeCQ5nwNJAbKFuvi7C8pLMT8VWHaQ3
	 IJqQbjELuZ23g9nRc6FaUckA0b2qsBll5iNbmONNx14ezXUihuVaLx9gR6Exh9DbHM
	 u463o/3D0DA0NK4xxadmibhhZ/bnIWtDNl7uguNgWF2MeHVX3+82hZ0HFV5Rv2I0yq
	 hukLqVa5g6SYYsru1k8aM7dRwcPiPV2bR3ZR0jhUlOCuPALSNzn3sQByV5YjhpUlid
	 kMcigc4Qcj6fQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Gonglei <arei.gonglei@huawei.com>,
	Justin Stitt <justinstitt@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/5] crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection
Date: Tue,  1 Sep 2026 10:48:41 -0400
Message-ID: <20260901144845.1102445-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083111-ahoy-glove-a297@gregkh>
References: <2026083111-ahoy-glove-a297@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Markus Elfring <elfring@users.sourceforge.net>

[ Upstream commit e01966e643c97eb8916bbbbbeceb687afb11f345 ]

The kfree() function was called in up to two cases by the
__virtio_crypto_akcipher_do_req() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

* Adjust jump targets.

* Delete two initialisations which became unnecessary
  with this refactoring.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: f77a956f6a19 ("crypto: virtio - bound the akcipher result length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/virtio/virtio_crypto_akcipher_algs.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
index d2df97cfcb294..b1953aec93945 100644
--- a/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
+++ b/drivers/crypto/virtio/virtio_crypto_akcipher_algs.c
@@ -225,11 +225,11 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	struct virtio_crypto *vcrypto = ctx->vcrypto;
 	struct virtio_crypto_op_data_req *req_data = vc_req->req_data;
 	struct scatterlist *sgs[4], outhdr_sg, inhdr_sg, srcdata_sg, dstdata_sg;
-	void *src_buf = NULL, *dst_buf = NULL;
+	void *src_buf, *dst_buf = NULL;
 	unsigned int num_out = 0, num_in = 0;
 	int node = dev_to_node(&vcrypto->vdev->dev);
 	unsigned long flags;
-	int ret = -ENOMEM;
+	int ret;
 	bool verify = vc_akcipher_req->opcode == VIRTIO_CRYPTO_AKCIPHER_VERIFY;
 	unsigned int src_len = verify ? req->src_len + req->dst_len : req->src_len;
 
@@ -240,7 +240,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	/* src data */
 	src_buf = kcalloc_node(src_len, 1, GFP_KERNEL, node);
 	if (!src_buf)
-		goto err;
+		return -ENOMEM;
 
 	if (verify) {
 		/* for verify operation, both src and dst data work as OUT direction */
@@ -255,7 +255,7 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 		/* dst data */
 		dst_buf = kcalloc_node(req->dst_len, 1, GFP_KERNEL, node);
 		if (!dst_buf)
-			goto err;
+			goto free_src;
 
 		sg_init_one(&dstdata_sg, dst_buf, req->dst_len);
 		sgs[num_out + num_in++] = &dstdata_sg;
@@ -278,9 +278,9 @@ static int __virtio_crypto_akcipher_do_req(struct virtio_crypto_akcipher_request
 	return 0;
 
 err:
-	kfree(src_buf);
 	kfree(dst_buf);
-
+free_src:
+	kfree(src_buf);
 	return -ENOMEM;
 }
 
-- 
2.53.0

