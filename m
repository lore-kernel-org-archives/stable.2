Received: from 4.mo576.mail-out.ovh.net (4.mo576.mail-out.ovh.net [46.105.42.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F34334AA
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.105.42.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141445; cv=none; b=DV8oGN65PX1RlrklHoHnoDcbcZ9nSgcQBnVTTUeQFiOK2aTi4pzqdZQ4TZxLCKm19t9RuiK3RMyjDr3rwNlQ3XGeTmBEYSOrA+q85pl6iBm1b8qio+TAy3O2/X+WtazLmybt2Sxu6ucQfWv1TpRTHIiPZC788ScixYlM64Mewn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141445; c=relaxed/simple;
	bh=2itXlY4WWJcPLw4e4JalWJkACvlyR6sDXGe9P8c+phs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tzcLmuFdp8yKOqynoUsgWiU9gEBGfznPKNfdl6I5L1Gd6MzsWGquuXXJRxCohaS7QgibPlhfnaOtoRahMGRB6TR8sOapOs1ogfwzkfQY3ZvmlnbhZ34v38bYrmMqHL8ofSUjeBHW/ZWFdR37Som2L8aJS9yvEKsrq6c4wzAP6os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cynove.com; spf=pass smtp.mailfrom=cynove.com; dkim=pass (2048-bit key) header.d=cynove.com header.i=@cynove.com header.b=RXn2gXGg; arc=none smtp.client-ip=46.105.42.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cynove.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cynove.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cynove.com header.i=@cynove.com header.b="RXn2gXGg"
Received: from director3.ghost.mail-out.ovh.net (unknown [10.109.231.242])
	by mo576.mail-out.ovh.net (Postfix) with ESMTP id 4j5fBJ4bvYz5wq7
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 09:03:52 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-4kjr4 (unknown [10.111.174.188])
	by director3.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 05CA7C03E0;
	Fri, 16 Oct 2026 09:03:51 +0000 (UTC)
Received: from cynove.com ([37.59.142.97])
	by ghost-submission-7ccd8bbbb6-4kjr4 with ESMTPSA
	id fClPE3Xo0WpZ/AEAmtFogg:T3
	(envelope-from <stephane.debusne@cynove.com>); Fri, 16 Oct 2026 09:03:51 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-97G002e07fcbaa-f78b-4434-88ca-256de4d93e96,
                    49BC7871EA8B080B249AF49F55FA702C3B4DE52D) smtp.auth=Stephane.Debusne@cynove.com
X-OVh-ClientIp:176.150.47.247
From: Stephane Debusne <stephane.debusne@cynove.com>
To: herbert@gondor.apana.org.au,
	lukas@wunner.de
Cc: ignat@cloudflare.com,
	davem@davemloft.net,
	horia.geanta@nxp.com,
	pankaj.gupta@nxp.com,
	gaurav.jain@nxp.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stephane Debusne <stephane.debusne@cynove.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] crypto: rsassa-pkcs1 - use a separate buffer for the RSA output
Date: Fri, 16 Oct 2026 11:03:33 +0200
Message-ID: <20261016090333.2247764-3-stephane.debusne@cynove.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016090333.2247764-1-stephane.debusne@cynove.com>
References: <20261016090333.2247764-1-stephane.debusne@cynove.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 16751138816091151131
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGD4nW62LQB9KssNcZQuK5kWrFQh+w6Vz+V+RAD8MnUAde72M/FLWE8ieu2/logkQIvP3h+HxkwhNQElJPI8dksBAWHsBdG4nOBhE97wdBgSrq7i9Dr7HTzEIPNJ9r0nStZP+4SxoAOI00vFHP+uMc2VAR7sYwcGJsPfO6GsKeTbDbZqUoT/dClNmsHiZliUHARqZfNmZpbXqR+OyK7tCsyhTiGvjmRA5ZoJHO4AiXlGsWEh0ULl2YyjVayzCXrjJyQQpi+DCuYI7TAzwqHsddO0+B9C81cyWecg6aiOCtYZJ4PPYAinicFtLLV81oPd4bQfiHnVg0dZa0FsvCqAOufT3it24uPeaqcndZRbjDRWO0Waaj4np6CCpC6gszDa87hFLP7Xlr0NCBN2x5BZPieKittVK8wbTyYcCWnzHtYuVTeoQZclhIKBls4tP2O1XbGjlobwwWAflK/hqLMfcvylG0usAdC6X5RWKavxuUtNW0Qo42EKart8PhErqf2ebXmIeNJ9+AdxuyaX5geLsrzAeXYbe1Pf3lY6Z1Mwv94uE4JrgmlG9jv9BA9dTTKg63gxbq3gYgTQE/QFrUspvb8zv+uK/0LpXCrvh10mYq4wcpq0j6GaecO7zj7yndk+vNKcvaikfO+P8lVE1H2KpjoWiQktpTsK2a1ar0I82z34g
DKIM-Signature: a=rsa-sha256; bh=/nyx8E1BJm42jAE/tXOKFc+YlYeMaXu9CSxvpmY+cXU=;
 c=relaxed/relaxed; d=cynove.com; h=From; s=ovhmo4616632-selector1;
 t=1792141432; v=1;
 b=RXn2gXGg/TY5dpuxR6xz/xqezEYUB3lhXJ6eQdK3UTI+PPfHQGZzff+JAy7lMe0qCtqnaRNJ
 yen8cnJ007XQn9eKRTGmlcigU8EpRdPT9XymuCscm0k0gm0mDxBxFQ6ooWC7y5YB61NycCWvMLV
 AkZIwMvEtqKtZWXVyQL2lgl8A3uVzeY1T8A9X0ET5f6pmD0EhoJoWCSSYAQVGC3xoxqbs0z6fet
 hKiYVrMbefk7M15aMeFFEi21ImuU8I9zzyEPUAJ2wLAYiNkXExPKzegoXoVvNtmCvfLiBQm3lqH
 0Pp3L3F+6ESinGOWY/deOez8Q2ehkPzQk3QWb2B+FbUlQ==

rsassa_pkcs1_verify() places the buffer it hands to the akcipher driver
right after the driver's request context, in the same allocation, and
since commit 8552cb04e083 ("crypto: rsassa-pkcs1 - Copy source data for
SG list") uses it in place (src == dst).

On non-coherent DMA, the start of this buffer may share a cache line
with the end of the request context. The CAAM driver (caampkc) writes
req_ctx->edesc and req_ctx->akcipher_op_done after dma_map_sg() of the
destination, which dirties that line. On arm64,
dma_unmap_sg(DMA_FROM_DEVICE) cleans and invalidates partial lines
(dc civac), so the stale CPU copy is written back over the result
written by the device.

On i.MX8M Mini (CAAM era 9, rsa-caam, 6.18), the buffer starts 168 bytes
into the allocation, at offset 40 of the 64-byte line that also holds
edesc and akcipher_op_done: the first 24 bytes of the RSA output are
replaced by the signature bytes, and rsassa_pkcs1_verify() returns
-EINVAL in 398 of 400 calls over two runs (the rare successes are
consistent with the dirty line being evicted before the device writes).
Visible effects: cfg80211 rejects regulatory.db ("loaded regulatory.db
is malformed or signature is missing/invalid"), and adding a valid
self-signed X.509 certificate to a keyring fails with EINVAL. The
akcipher self-tests pass, as they use separate buffers.

A test module comparing rsa-caam with rsa-generic shows that only the
position of the destination matters: separate or in-place buffers from
their own kmalloc() give correct results, while a destination right
after the request context is corrupted, in place or not (200 of 200
calls, the 24 first bytes always holding the previous content of the
buffer).

Allocate the output buffer separately, so that it is DMA-safe like any
kmalloc() buffer.

Fixes: 1e562deacecc ("crypto: rsassa-pkcs1 - Migrate to sig_alg backend")
Cc: stable@vger.kernel.org
Signed-off-by: Stephane Debusne <stephane.debusne@cynove.com>
---
 crypto/rsassa-pkcs1.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/crypto/rsassa-pkcs1.c b/crypto/rsassa-pkcs1.c
index 94fa5e960..205493037 100644
--- a/crypto/rsassa-pkcs1.c
+++ b/crypto/rsassa-pkcs1.c
@@ -223,6 +223,7 @@ static int rsassa_pkcs1_verify(struct crypto_sig *tfm,
 	struct rsassa_pkcs1_ctx *ctx = crypto_sig_ctx(tfm);
 	unsigned int child_reqsize = crypto_akcipher_reqsize(ctx->child);
 	struct akcipher_request *child_req __free(kfree_sensitive) = NULL;
+	u8 *out_alloc __free(kfree_sensitive) = NULL;
 	struct crypto_wait cwait;
 	struct scatterlist sg;
 	unsigned int dst_len;
@@ -237,12 +238,21 @@ static int rsassa_pkcs1_verify(struct crypto_sig *tfm,
 		return -EINVAL;
 
 	/* RFC 8017 sec 8.2.2 step 2 - RSA verification */
-	child_req = kmalloc(sizeof(*child_req) + child_reqsize + ctx->key_size,
-			    GFP_KERNEL);
+	child_req = kmalloc(sizeof(*child_req) + child_reqsize, GFP_KERNEL);
 	if (!child_req)
 		return -ENOMEM;
 
-	out_buf = (u8 *)(child_req + 1) + child_reqsize;
+	/*
+	 * The output buffer is mapped for DMA by hardware RSA drivers. Keep
+	 * it in its own allocation: placed right after the request context,
+	 * it may share a cache line with fields the driver writes while the
+	 * buffer is mapped, which corrupts the output on non-coherent DMA.
+	 */
+	out_alloc = kmalloc(ctx->key_size, GFP_KERNEL);
+	if (!out_alloc)
+		return -ENOMEM;
+
+	out_buf = out_alloc;
 	memcpy(out_buf, src, slen);
 
 	crypto_init_wait(&cwait);
-- 
2.43.0

