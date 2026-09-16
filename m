Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3C497B63
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574866; cv=none; b=iJaKlXfnHHkNteohkhR8zE6MSkHJ/DFoiEum6cgQ1UWZNL8cLc9qATIeWblL8ASfVlsy+/iFyYpEFcTy3OXgsKgfkY0ruN65TnryjbI3kS1oeykxh3T6NKnbNtQMgR42wGrqtU4rSiQcC/QbHan+yNTLnA2B+Y65jLcrqRnMjzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574866; c=relaxed/simple;
	bh=xDHsxa6Oh80UcbnhAXhq7noE3vuBpCJ5YPVD/292664=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jw5P7QKoo0rY67TDT7eXvg6bPvbIbUvEoCqa8nLLPX+aEhlbtBNc9iPLAZ0g/93N/KKMikCKj/GbEgzs/VplN15BpvVCOy0wKmi6ZURjHgazq700trKxMc2zHlAKSZcV2GPFw4Bq57KKvDX2egxQNHIx04nXHL/0IOFeiCFz954=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C+uLpyGp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C+uLpyGp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AAF1F000FF;
	Wed, 16 Sep 2026 16:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574864;
	bh=SBSia90TlWvyBSWthZgHec8jSIQXIBd4N/beu5W622I=;
	h=Subject:To:Cc:From:Date;
	b=C+uLpyGpOfXo8RWvSYCSl1H99A617ZCV0w3Ofngkd6aoqa/ipjfqHI8E7vQd2olL/
	 MtcmdW8guhzRxoIZtr0JZXZxIgHCvyn8zL4KQYnscwmjfKQFOS4JcjlSzNKIqcbt9V
	 BaryuiCh6/itI41135qpShqi466cwzPu03Kjs78Y=
Subject: FAILED: patch "[PATCH] s390/crypto: Fix use of mutex in atomic context" failed to apply to 5.15-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:48:41 +0100
Message-ID: <2026091641-slogan-deluge-2d5f@gregkh>
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
git cherry-pick -x d1c44a7d085473173bb360b7218a43699c3f56c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091641-slogan-deluge-2d5f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d1c44a7d085473173bb360b7218a43699c3f56c7 Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:37:35 +0200
Subject: [PATCH] s390/crypto: Fix use of mutex in atomic context

The AES CTR implementation used a mutex to lock one page of exclusive
memory for fast CTR processing. Unfortunately a mutex is not save to
use in atomic or interrupt context. So use a binary semaphore instead
which is save to use in such environments.

Furthermore rework the code to get rid of conditional locking. So
restructure the AES CRT code by extracting the main loop into a
separate function and just give in information about the (locked) page
can be used or not (is not locked).

Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 5.5+
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/crypto/aes_s390.c b/arch/s390/crypto/aes_s390.c
index 10561aa687c7..0be6fa779d2c 100644
--- a/arch/s390/crypto/aes_s390.c
+++ b/arch/s390/crypto/aes_s390.c
@@ -26,14 +26,14 @@
 #include <linux/module.h>
 #include <linux/cpufeature.h>
 #include <linux/init.h>
-#include <linux/mutex.h>
 #include <linux/fips.h>
+#include <linux/semaphore.h>
 #include <linux/string.h>
 #include <crypto/xts.h>
 #include <asm/cpacf.h>
 
 static u8 *ctrblk;
-static DEFINE_MUTEX(ctrblk_lock);
+static DEFINE_SEMAPHORE(ctrblk_sem, 1);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions,
 		    kma_functions;
@@ -562,46 +562,61 @@ static unsigned int __ctrblk_init(u8 *ctrptr, u8 *iv, unsigned int nbytes)
 	return n;
 }
 
+static int __ctr_aes_crypt(struct s390_aes_ctx *sctx,
+			   struct skcipher_walk *walk, bool locked)
+{
+	unsigned int n, nbytes;
+	int ret = 0;
+	u8 *ctrptr;
+
+	while (!ret && ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE)) {
+		n = AES_BLOCK_SIZE;
+		if (nbytes >= 2 * AES_BLOCK_SIZE && locked)
+			n = __ctrblk_init(ctrblk, walk->iv, nbytes);
+		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;
+		cpacf_kmctr(sctx->fc, sctx->key, walk->dst.virt.addr,
+			    walk->src.virt.addr, n, ctrptr);
+		if (ctrptr == ctrblk)
+			memcpy(walk->iv, ctrptr + n - AES_BLOCK_SIZE,
+			       AES_BLOCK_SIZE);
+		crypto_inc(walk->iv, AES_BLOCK_SIZE);
+		ret = skcipher_walk_done(walk, nbytes - n);
+	}
+
+	return ret;
+}
+
 static int ctr_aes_crypt(struct skcipher_request *req)
 {
 	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
 	struct s390_aes_ctx *sctx = crypto_skcipher_ctx(tfm);
-	u8 buf[AES_BLOCK_SIZE], *ctrptr;
 	struct skcipher_walk walk;
-	unsigned int n, nbytes;
-	int ret, locked;
+	u8 buf[AES_BLOCK_SIZE];
+	int ret;
 
 	if (unlikely(!sctx->fc))
 		return fallback_skcipher_crypt(sctx, req, 0);
 
-	locked = mutex_trylock(&ctrblk_lock);
-
 	ret = skcipher_walk_virt(&walk, req, false);
-	while (!ret && ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE)) {
-		n = AES_BLOCK_SIZE;
+	if (ret)
+		return ret;
 
-		if (nbytes >= 2*AES_BLOCK_SIZE && locked)
-			n = __ctrblk_init(ctrblk, walk.iv, nbytes);
-		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk.iv;
-		cpacf_kmctr(sctx->fc, sctx->key, walk.dst.virt.addr,
-			    walk.src.virt.addr, n, ctrptr);
-		if (ctrptr == ctrblk)
-			memcpy(walk.iv, ctrptr + n - AES_BLOCK_SIZE,
-			       AES_BLOCK_SIZE);
-		crypto_inc(walk.iv, AES_BLOCK_SIZE);
-		ret = skcipher_walk_done(&walk, nbytes - n);
+	if (down_trylock(&ctrblk_sem) == 0) {
+		ret = __ctr_aes_crypt(sctx, &walk, true);
+		up(&ctrblk_sem);
+	} else {
+		ret = __ctr_aes_crypt(sctx, &walk, false);
 	}
-	if (locked)
-		mutex_unlock(&ctrblk_lock);
+
 	/*
 	 * final block may be < AES_BLOCK_SIZE, copy only nbytes
 	 */
-	if (!ret && nbytes) {
+	if (!ret && walk.nbytes > 0) {
 		memset(buf, 0, AES_BLOCK_SIZE);
-		memcpy(buf, walk.src.virt.addr, nbytes);
+		memcpy(buf, walk.src.virt.addr, walk.nbytes);
 		cpacf_kmctr(sctx->fc, sctx->key, buf, buf,
 			    AES_BLOCK_SIZE, walk.iv);
-		memcpy(walk.dst.virt.addr, buf, nbytes);
+		memcpy(walk.dst.virt.addr, buf, walk.nbytes);
 		crypto_inc(walk.iv, AES_BLOCK_SIZE);
 		ret = skcipher_walk_done(&walk, 0);
 		memzero_explicit(buf, sizeof(buf));

