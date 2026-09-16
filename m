Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01805402BAB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574862; cv=none; b=dTCdAyjkLa5cseV0/MR7u3WtyAzxUdbBBZa0+x5upM2lQQPwShY3g2A+/SlfJLC5lMXRO8Q4sO8N3ya6jAZXp+e6jlQ/WP1O4Q/uOo90rn7PuM6pfaYuDiHyodK2Xg/n8OU4OktJMk4g2Be5oRMmREzF2bFL5yCMJgMwv692utk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574862; c=relaxed/simple;
	bh=nnUe+1X8ZWGwca3KfZ451rd3zrOFaB37NOtkmWH1nzU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=aJ20xBe16HZHEBiL+M9LnGfECZbydkHvk9yh8yvsBay+wzbwuF6fBZbcrsVqN5BdQdG+29U1uknutaY5zn7BputuS8+WWvjA30LjfguapvGbRkj/0zb4ELZi+g7vdcyLVB1bF5lM47uKaMXW30UEdzM9t7JjJnEqU+P+AqhIGb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fv7mcJf7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fv7mcJf7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50E011F000FF;
	Wed, 16 Sep 2026 16:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574860;
	bh=hjPDpHiLWUY7qy7x0Eu3k/Vz4ZnpnmlWCU5xAERqrTA=;
	h=Subject:To:Cc:From:Date;
	b=Fv7mcJf7+7L9SZoYrM8SwvN1dhzLzqFr4G816ucuSQf5ARsBRbRmJaBAPPF2qa+iy
	 j9E1cCR46axwwLz/8TZ2Ept6n+iNePlKLcCAdNlwH1VVEmkNTBm0QpF2KstGnaYKxP
	 xsBjRv8JqqgJdd9bbbn3EqwEJD5EyaQFTIy/EEqE=
Subject: FAILED: patch "[PATCH] s390/crypto: Fix use of mutex in atomic context" failed to apply to 6.1-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:48:40 +0100
Message-ID: <2026091639-barmaid-yogurt-f4c1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x d1c44a7d085473173bb360b7218a43699c3f56c7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091639-barmaid-yogurt-f4c1@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

