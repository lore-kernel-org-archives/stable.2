Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8F1366048
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 14:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272302; cv=none; b=fSGM7sjPelj5DW2NPYgTCgAULS6f7YRBzNVxKb/L3UkLSXhztDEvy+ggF26OWq0Cw+HGwMK151VWzjNRX4SMUzZ7OBuMW8bpYWLxnAdOwxIBhIUprLp0xz1P7PbZtE1m6i4YPnWNQEdyfrwKDNI17kWJj/V8uzHGv044jd+6XYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272302; c=relaxed/simple;
	bh=6YJejkbFd7vC+PUCrzm6GIC0jNQEKuYOZ9Klfs0RhXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjZRrG+s8BOTNlCWV/jD0MjDadGSVppfOQNIYp2gH9CDndgU1utw+EGrqRV++nuXCt3iFjgwM+6wHaIw66KTTkFcVb4UC7Dg2tu2BPq++1NjhbGeP3AQbYDiQkOrtj7NE+45k5IGPzY3un8ccX+YE4zBGmav6yR/Uwh6ECTxU9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHg8MYl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHg8MYl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A11F000E9;
	Tue,  1 Sep 2026 14:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788272301;
	bh=Rn1di16pKo5ZI+jvCNJ3n1cqaEWMpmjJY4ySesq2Un0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kHg8MYl1YtxmtlehMRLfakde6YnogixXzrUcA9VMdhD9kbap091qhLNzNa5ChL/Oa
	 CVhvQ5aRQW78I0C/LD7ZpAPIx38SIO+QUVAOwwL5U6cnQfnXbTf028g2ixr0KuIRd5
	 Gq+pCdBg6pmqJQORrVRyRIwEg1Ru1pvuUSt7F8tgojFlP8/WbtzOoZ2Ldd4V8ef+tU
	 z0uZdX3MeyL9Ceaz7VL7+6lXx4jn2xd3lPKyqtfqrnx2ioiUCuoTTPiG0i812kbQr3
	 4Y/VXiZVU+DV0Ug8qbdB/3GAJF52cPjc8kexQqEe3+u9tXnXrwXPUj/QbArc9VlWaV
	 ttpmZfYqLyBfg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Markus Elfring <elfring@users.sourceforge.net>,
	Gonglei <arei.gonglei@huawei.com>,
	Justin Stitt <justinstitt@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/5] crypto: virtio - Less function calls in __virtio_crypto_akcipher_do_req() after error detection
Date: Tue,  1 Sep 2026 10:18:14 -0400
Message-ID: <20260901141818.1033381-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083110-repugnant-jingle-50dd@gregkh>
References: <2026083110-repugnant-jingle-50dd@gregkh>
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
index de53eddf6796b..cb92b7fa99c6f 100644
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

