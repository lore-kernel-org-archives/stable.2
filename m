Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120154BE426
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789574885; cv=none; b=hF6Dzp7wt6Mki2p0QcPtbywdNjb9y0rejUQMEMLkIiVJ099ZinEjan83sOgtsBHKx182GVBm8GuexMsBHWQ17sJuJNnzeD6bxiB44GXxA0fY5o0H65+H7/iJG/x9I51u4iPE6fFjDnafB11syhTegsnE5sq90+jHdufaqnqERfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789574885; c=relaxed/simple;
	bh=dhQqBg5OAkETSmSCC2QtAylDFSrszE3KgKCGeO2kkTg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=jSuxZHeQUFlksZbJb0gF3ngugWyb77vKUTcWB2RkpQ1Wzd5yJ6nnQSvCrb2RkVOXiZx+iw3ZUA2Wu18ykkWbCLSmKa/uOwNbSJZztDkA0IDyt3/XqeLNnbyAAGKVACnV1JB518ar0qZIwLVzENIm0geDpD3ssndRsELEDO9Kf3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JIFIZA59; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JIFIZA59"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365A81F000FF;
	Wed, 16 Sep 2026 16:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789574882;
	bh=K3oPA0716NjPebWL3iM6swhxZsRuBCustHo58aWgvBw=;
	h=Subject:To:Cc:From:Date;
	b=JIFIZA597nW4bE21kmHnz9dBQfAO0ID2mzLrXfcLukFN366zoGJ0WfqvirrMQDPn6
	 y3n0iazqGIymRw3g9VTqXAZeCXMXuN2hnqdXsS/CS0y0Bao/iMZHj+kE2ti1DaKtnx
	 DlI+kQy44wXq4xkDEjnW2tbnpdVhcNnV4wpyFxmI=
Subject: FAILED: patch "[PATCH] s390/crypto: Fix use of mutex in atomic context in PAES" failed to apply to 6.18-stable tree
To: freude@linux.ibm.com,dengler@linux.ibm.com,gor@linux.ibm.com,hca@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 16:50:45 +0100
Message-ID: <2026091645-sudoku-liquefy-ac94@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 749990db95d45cc3d96aab999ac7f110259b200c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091645-sudoku-liquefy-ac94@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 749990db95d45cc3d96aab999ac7f110259b200c Mon Sep 17 00:00:00 2001
From: Harald Freudenberger <freude@linux.ibm.com>
Date: Mon, 31 Aug 2026 10:38:32 +0200
Subject: [PATCH] s390/crypto: Fix use of mutex in atomic context in PAES

The PAES CTR implementation used a mutex to lock one page of exclusive
memory for fast CTR processing. Unfortunately a mutex is not save to
use in atomic or interrupt context. So use a binary semaphore instead
which is save to use in such environments.

Furthermore rework the code to get rid of conditional locking. So
restructure the PAES CRT code by extracting the main loop into a
separate function and just give in information about the (locked) page
can be used or not (is not locked).

Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asynch support")
Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Cc: stable@vger.kernel.org # 6.16+
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
index 9c8f9e2570f2..991a26766d40 100644
--- a/arch/s390/crypto/paes_s390.c
+++ b/arch/s390/crypto/paes_s390.c
@@ -19,7 +19,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
+#include <linux/semaphore.h>
 #include <linux/spinlock.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
@@ -45,7 +45,7 @@ module_param_named(clrkey, pkey_clrkey_allowed, bool, 0444);
 MODULE_PARM_DESC(clrkey, "Allow clear key material (default N)");
 
 static u8 *ctrblk;
-static DEFINE_MUTEX(ctrblk_lock);
+static DEFINE_SEMAPHORE(ctrblk_sem, 1);
 
 static cpacf_mask_t km_functions, kmc_functions, kmctr_functions;
 
@@ -919,15 +919,62 @@ static inline unsigned int __ctrblk_init(u8 *ctrptr, u8 *iv, unsigned int nbytes
 	return n;
 }
 
+static int __ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
+			       struct ctr_param *param,
+			       struct skcipher_walk *walk,
+			       bool tested, bool maysleep, bool locked)
+{
+	unsigned int nbytes, n, k;
+	u8 *ctrptr;
+	int rc = 0;
+
+	/*
+	 * Note that in case of partial processing or failure the walk
+	 * is NOT unmapped here. So a follow up task may reuse the walk
+	 * or in case of unrecoverable failure needs to unmap it.
+	 */
+	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
+		n = AES_BLOCK_SIZE;
+		if (nbytes >= 2 * AES_BLOCK_SIZE && locked)
+			n = __ctrblk_init(ctrblk, walk->iv, nbytes);
+		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;
+		k = cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
+				walk->src.virt.addr, n, ctrptr);
+		if (k) {
+			if (ctrptr == ctrblk)
+				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
+				       AES_BLOCK_SIZE);
+			crypto_inc(walk->iv, AES_BLOCK_SIZE);
+			rc = skcipher_walk_done(walk, nbytes - k);
+			if (rc)
+				goto out;
+		}
+		if (k < n) {
+			if (!maysleep) {
+				rc = -EKEYEXPIRED;
+				goto out;
+			}
+			rc = paes_convert_key(ctx, tested);
+			if (rc)
+				goto out;
+			spin_lock_bh(&ctx->pk_lock);
+			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
+			spin_unlock_bh(&ctx->pk_lock);
+		}
+	}
+
+out:
+	return rc;
+}
+
 static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 			     struct s390_pctr_req_ctx *req_ctx,
 			     bool tested, bool maysleep)
 {
 	struct ctr_param *param = &req_ctx->param;
 	struct skcipher_walk *walk = &req_ctx->walk;
-	u8 buf[AES_BLOCK_SIZE], *ctrptr;
-	unsigned int nbytes, n, k;
-	int pk_state, locked, rc = 0;
+	u8 buf[AES_BLOCK_SIZE];
+	int pk_state, rc = 0;
 
 	if (!req_ctx->param_init_done) {
 		/* fetch and check protected key state */
@@ -953,57 +1000,17 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 	if (rc)
 		goto out;
 
-	locked = mutex_trylock(&ctrblk_lock);
-
-	/*
-	 * Note that in case of partial processing or failure the walk
-	 * is NOT unmapped here. So a follow up task may reuse the walk
-	 * or in case of unrecoverable failure needs to unmap it.
-	 */
-	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
-		n = AES_BLOCK_SIZE;
-		if (nbytes >= 2 * AES_BLOCK_SIZE && locked)
-			n = __ctrblk_init(ctrblk, walk->iv, nbytes);
-		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;
-		k = cpacf_kmctr(ctx->fc, param, walk->dst.virt.addr,
-				walk->src.virt.addr, n, ctrptr);
-		if (k) {
-			if (ctrptr == ctrblk)
-				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
-				       AES_BLOCK_SIZE);
-			crypto_inc(walk->iv, AES_BLOCK_SIZE);
-			rc = skcipher_walk_done(walk, nbytes - k);
-			if (rc) {
-				if (locked)
-					mutex_unlock(&ctrblk_lock);
-				goto out;
-			}
-		}
-		if (k < n) {
-			if (!maysleep) {
-				if (locked)
-					mutex_unlock(&ctrblk_lock);
-				rc = -EKEYEXPIRED;
-				goto out;
-			}
-			rc = paes_convert_key(ctx, tested);
-			if (rc) {
-				if (locked)
-					mutex_unlock(&ctrblk_lock);
-				goto out;
-			}
-			spin_lock_bh(&ctx->pk_lock);
-			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
-			spin_unlock_bh(&ctx->pk_lock);
-		}
+	if (down_trylock(&ctrblk_sem) == 0) {
+		rc = __ctr_paes_do_crypt(ctx, param, walk, tested, maysleep, true);
+		up(&ctrblk_sem);
+	} else {
+		rc = __ctr_paes_do_crypt(ctx, param, walk, tested, maysleep, false);
 	}
-	if (locked)
-		mutex_unlock(&ctrblk_lock);
 
 	/* final block may be < AES_BLOCK_SIZE, copy only nbytes */
-	if (nbytes) {
+	if (!rc && walk->nbytes > 0) {
 		memset(buf, 0, AES_BLOCK_SIZE);
-		memcpy(buf, walk->src.virt.addr, nbytes);
+		memcpy(buf, walk->src.virt.addr, walk->nbytes);
 		while (1) {
 			if (cpacf_kmctr(ctx->fc, param, buf,
 					buf, AES_BLOCK_SIZE,
@@ -1020,7 +1027,7 @@ static int ctr_paes_do_crypt(struct s390_paes_ctx *ctx,
 			memcpy(param->key, ctx->pk.protkey, sizeof(param->key));
 			spin_unlock_bh(&ctx->pk_lock);
 		}
-		memcpy(walk->dst.virt.addr, buf, nbytes);
+		memcpy(walk->dst.virt.addr, buf, walk->nbytes);
 		crypto_inc(walk->iv, AES_BLOCK_SIZE);
 		rc = skcipher_walk_done(walk, 0);
 	}

