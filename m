Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A043BCD34
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574853; cv=none; b=RfkURg0eCYcxkHKcrJoytxdqQhxaxBNxSzA3fYt7G5S4yFcwtpKtEX6fohTHFqLVTXg+0e+kENqhvpsA0DuppqGTE00+VeT80bL8eXmzemKcnIygttZGszEZaf4Y5ewEXyxajXjwsf74wGsMzI4y0gD03Gu3N0ThOTv6kayeo88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574853; c=relaxed/simple;
	bh=jAEOd3ZDnR8ht86PEDLElNQEwIxmQsJ5NXXygY5PUZo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pVr8WXV5MdDtxstV7Hl8kxWweRIELg8OE5iGjdy0Ay2oEVm7AdOgGzsFLQBelPj/XXqgwpXfZ+xPUwnTEwK2jBHsXrO37EKmBEAJwVDhaFP5QG7PGGlBw3t72kFuSPV2kPBrjweTsvxyZl8Qpefp2BwpqEuRdSGWJMbfUEEMFT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZBlVHaVt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZBlVHaVt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0A1F00898;
	Wed, 16 Sep 2026 16:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574851;
	bh=ioRzjzHaqltJ5fp948aGUwH5Ggh1SPxH7nclkwh70Kc=;
	h=Subject:To:Cc:From:Date;
	b=ZBlVHaVt+GJ6XsFlq4KpYxlEO/8cWKaLUlKH1PY8rn00wVZKKjsbSO/nvLMLDpU9D
	 blTSXWbzDroKc5/C27YVQq8oraXt9/cJ4u9Hi9xbWYHB+x00q9VDcLqZqPGk6TRo4j
	 RYGM/cog3RNhmdUx/jZw9uT3TgBAZmwlLcoIJ63Q=
Subject: FAILED: patch "[PATCH] s390/crypto: Fix skcipher_walk return code handling in" failed to apply to 5.15-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:48:21 +0100
Message-ID: <2026091621-penholder-stipend-8ee8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 15fa028589c3a2545f0bff355eff06d5844196bf
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091621-penholder-stipend-8ee8@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 15fa028589c3a2545f0bff355eff06d5844196bf Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:37:33 +0200
Subject: [PATCH] s390/crypto: Fix skcipher_walk return code handling in
 aes_s390

The return codes from skcipher_walk_virt() were not properly checked
before entering the processing loops in ecb_aes_crypt() and ctr_aes_crypt().
If skcipher_walk_virt() fails, the walk structure may be in an undefined
state, and attempting to process data could lead to incorrect behavior
or accessing uninitialized memory.

Add proper return code checking to ensure correct handling of the walk
initialization and walk advance and eventually return to the caller
with that return code.

Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 62edc66d5478..366ce22d3623 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -129,7 +129,7 @@ static int ecb_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 		return fallback_skcipher_crypt(sctx, req, modifier);
 
 	ret = skcipher_walk_virt(&walk, req, false);
-	while ((nbytes = walk.nbytes) != 0) {
+	while (!ret && ((nbytes = walk.nbytes) != 0)) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
 		cpacf_km(sctx->fc | modifier, sctx->key,
@@ -233,7 +233,7 @@ static int cbc_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 		return ret;
 	memcpy(param.iv, walk.iv, AES_BLOCK_SIZE);
 	memcpy(param.key, sctx->key, sctx->key_len);
-	while ((nbytes = walk.nbytes) != 0) {
+	while (!ret && ((nbytes = walk.nbytes) != 0)) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
 		cpacf_kmc(sctx->fc | modifier, &param,
@@ -359,7 +359,7 @@ static int xts_aes_crypt(struct skcipher_request *req, unsigned long modifier)
 	memcpy(xts_param.key + offset, xts_ctx->key, xts_ctx->key_len);
 	memcpy(xts_param.init, pcc_param.xts, 16);
 
-	while ((nbytes = walk.nbytes) != 0) {
+	while (!ret && ((nbytes = walk.nbytes) != 0)) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
 		cpacf_km(xts_ctx->fc | modifier, xts_param.key + offset,
@@ -487,7 +487,7 @@ static int fullxts_aes_crypt(struct skcipher_request *req,  unsigned long modifi
 	memcpy(fxts_param.tweak, req->iv, AES_BLOCK_SIZE);
 	fxts_param.nap[0] = 0x01; /* initial alpha power (1, little-endian) */
 
-	while ((nbytes = walk.nbytes) != 0) {
+	while (!ret && ((nbytes = walk.nbytes) != 0)) {
 		/* only use complete blocks */
 		n = nbytes & ~(AES_BLOCK_SIZE - 1);
 		cpacf_km(xts_ctx->fc | modifier, fxts_param.key + offset,
@@ -577,7 +577,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 	locked = mutex_trylock(&ctrblk_lock);
 
 	ret = skcipher_walk_virt(&walk, req, false);
-	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
+	while (!ret && ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE)) {
 		n = AES_BLOCK_SIZE;
 
 		if (nbytes >= 2*AES_BLOCK_SIZE && locked)
@@ -596,7 +596,7 @@ static int ctr_aes_crypt(struct skcipher_request *req)
 	/*
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
-	if (nbytes) {
+	if (!ret && nbytes) {
 		memset(buf, 0, AES_BLOCK_SIZE);
 		memcpy(buf, walk.src.virt.addr, nbytes);
 		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,

