Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092494AA1F0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788440818; cv=none; b=n2YB2HcxBMNNongArRv4qr/f+ioXeyTwHN7k2EJBJI5TExGTlGZsiPbyz6ufi9J62nFChyFb7ry37Z9HzweuqG40LkRiBWlfVhjDAfGslFjsLdLmf2UTRXoMYekjR17nnV21rqN5/H2PPpxRQEmatnswh9bq8GEbzQt5ijrCaVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788440818; c=relaxed/simple;
	bh=wmuewEe5eJqtsRh/afSJ4GdyKE9pYfOyp4gGNsPrNVo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mYAcYDwTC1ffahbHfwZfw6LDCAIjMz9gzhJSTjzLYdcNtoo3KXt2g0ibNs2WTxvouXTAsknWOHN94FYt0/r+TNPi2NjO2Z0cjGNZnaDY1OKm4R7/IngQDuyl/stYfS2n6Gw9Ri/R+hM+11eSUUAauz2l98HNyoIFTCGrBdpmkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T1/zE3Fm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T1/zE3Fm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF3D1F000E9;
	Thu,  3 Sep 2026 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788440807;
	bh=V4ZV6r/UJfnt0wcn86MuKI5n+grMJM4K8aSCKDevDI8=;
	h=Subject:To:Cc:From:Date;
	b=T1/zE3Fmq+MlB9WcxFG7JarrU+t1ZDf4NLhkm3Dx/b99mDMj3pCusuy1gdbzJQVLP
	 JIVTModF/bvzt5kzk+cBAuWqSR1ZmrGalpVFsi0eLwW+86UIqCWwdtzLQVMSM0mYS3
	 iUFoOHoFmOjaDpgG66hwLncWa9hNxdr1rNCFFtK8=
Subject: FAILED: patch "[PATCH] zram: set default primary compressor in zram_destroy_comps()" failed to apply to 6.12-stable tree
To: senozhatsky@chromium.org,akpm@linux-foundation.org,haoqinhuang7@gmail.com,minchan@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:01:23 +0200
Message-ID: <2026090323-reflux-devoutly-8bce@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x dde75313eed0b014c437f48dd75c0308b592cbf9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090323-reflux-devoutly-8bce@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dde75313eed0b014c437f48dd75c0308b592cbf9 Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Wed, 29 Jul 2026 13:57:35 +0900
Subject: [PATCH] zram: set default primary compressor in zram_destroy_comps()

Patch series "zram: fix zram issues reported by sashiko".

Sashiko drove by and reported [1] a couple of zram issues:
a possible BUG_ON() in zlib code due to missing winbits range
validation and one possible NULL-ptr dereference in zcomp.
Both are low risk yet still worth fixing.


This patch (of 2):

zram_destroy_comps() resets all compressors and leaves them set to NULL,
including the primary one, which is invalid device state, as now
comp_algorithm_show()->strcmp() can be called on a NULL compressor.  Set
default primary compressor in zram_destroy_comps().

Link: https://lore.kernel.org/20260729045745.775973-2-senozhatsky@chromium.org
Fixes: 486fd58af7ac ("zram: don't free statically defined names")
Link: https://sashiko.dev/#/patchset/20260728092935.31139-1-haoqinhuang7@gmail.com [1]
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Haoqin Huang <haoqinhuang7@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 4bfe63a5225d..cfa98846ac48 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -2828,6 +2828,7 @@ static void zram_destroy_comps(struct zram *zram)
 		zram->comp_algs[prio] = NULL;
 
 	zram_comp_params_reset(zram);
+	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static void zram_reset_device(struct zram *zram)
@@ -2845,8 +2846,6 @@ static void zram_reset_device(struct zram *zram)
 	zram_destroy_comps(zram);
 	memset(&zram->stats, 0, sizeof(zram->stats));
 	reset_bdev(zram);
-
-	comp_algorithm_set(zram, ZRAM_PRIMARY_COMP, default_compressor);
 }
 
 static ssize_t disksize_store(struct device *dev, struct device_attribute *attr,

