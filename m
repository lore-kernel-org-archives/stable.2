Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793814852;
	b=isuydTFLIzqMjGeDHvVjA3KLiLRm63+AmTqp2sFYPEbcc5k+bciqb1ApUnI1Mds+GLgV
	 DRgyRYIrNsbLz5PZ8w1VEOzryP8Dix/qiwmKu5LRghdDa0UxG7OaobMp4UsQY46QUNdld
	 Lc8+KZSx22e9eroAZxdyVtDTglB5nxu7h9WMcEvVp+SSO8aSSumAzKsmof7GLjmmfFi/x
	 /v1czaKWz5zeEq6DUBX166CHEDBYQiTaVDy5vEDHoNvGR7DS7y10V8zijLR/9Oc7DCW+U
	 7wjntL/pA+8P/YiMdRIyMixenS1fLo2NdjI+JPg9o8KYodsl6QZf9lBuQT1S4I5c2xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814852;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=cBq5AGmPXyb+82gAIWNBux3ZCfbSKFy5JGzIXQDYujM=;
	b=yxdW2o8srgABIR4TPnd8m2cYPjOpyfzR0ZbAk55rZ+0YZXHPPl7uN5+h9425MxKB43RO
	 fHvsi2EF5J/aq5+QfODwARMcjvgOIGAlPbGJok1Jxw2H47W+FDUEwZ24z/Asm8wOO3n4I
	 8TI+rsj+H0QvcSrm+npHJMnLNl9ocIG7CnVWvGfy8Ll3LGjWmIDT0dXahO27MMHMsrTIz
	 IImy9GOcj2uYkGkG5HS1Mv7SvM1pzsX1X+FiMY12qbZcQagXmhWa61t6ht2UcxPaGy+fR
	 zk+OQASEDswbOckAhR/JDD8PphSt7W2mqfa7JzOyYY6TOcMeC51UNHeeFikFX49w2Ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JBiD7rk5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5036860756F9
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 17:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=JBiD7rk5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DEA1F00A15;
	Wed,  4 Nov 2026 17:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793814852;
	bh=cBq5AGmPXyb+82gAIWNBux3ZCfbSKFy5JGzIXQDYujM=;
	h=Subject:To:Cc:From:Date;
	b=JBiD7rk5YXteTzU3bY1GeIrYD+VcmR9nmSHMjxn4ygzTKCZG+DbdW/DMNgyljHY04
	 3kVl9skOBu5mqz1sk1V6s1X+g49NnhfxjRpcMK32PdnwmQblT1FxbNaDNTHQELOnjL
	 9s+HNnO6laQGzPu4LsJnoKNbxbeSydc1w5FZmnTE=
Subject: FAILED: patch "[PATCH] xfs: don't rescan ifree and icount when frozen" failed to apply to 5.10-stable tree
To: djwong@kernel.org,cem@kernel.org,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 12:53:43 -0500
Message-ID: <2026110443-backlit-matrimony-a308@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 18028768415e3c05ab7edb22d740e2f4dc52836a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110443-backlit-matrimony-a308@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 18028768415e3c05ab7edb22d740e2f4dc52836a Mon Sep 17 00:00:00 2001
From: "Darrick J. Wong" <djwong@kernel.org>
Date: Mon, 12 Oct 2026 23:08:51 -0700
Subject: [PATCH] xfs: don't rescan ifree and icount when frozen

LOLLM points out that it's pointless to rescan the AGs if we've already
frozen the filesystem because there won't be any more perturbations.
Fix this to mark the scan incomplete and exit.

Cc: stable@vger.kernel.org # v5.2
Fixes: 75efa57d0bf5fc ("xfs: add online scrub for superblock counters")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>

diff --git a/fs/xfs/scrub/fscounters.c b/fs/xfs/scrub/fscounters.c
index eb1a095a0fa9..5984fe13a973 100644
--- a/fs/xfs/scrub/fscounters.c
+++ b/fs/xfs/scrub/fscounters.c
@@ -379,6 +379,11 @@ xchk_fscount_aggregate_agcounts(
 	 * to maintain ifree <= icount before giving up.
 	 */
 	if (fsc->ifree > fsc->icount) {
+		if (fsc->frozen) {
+			xchk_set_incomplete(sc);
+			return -EFSCORRUPTED;
+		}
+
 		if (tries--)
 			goto retry;
 		return -EDEADLOCK;

