Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B33B2D1D
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546940; cv=none; b=pMfcD8hIbw1Zs0PCLm7nN31zTuC3G1wp4KUX8uXlWobcs+OHovZ5sxOwkrq16vxlKodXOcZSu2P+eBOw6HK7/Ce9/eOQ+nfDvI9kwR5mR7XuBE10x+GDAguz6q/d188uRPlrBW560cWzB3C9+0vZUqqnYfbGm5zLPubYTtEBHJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546940; c=relaxed/simple;
	bh=8pmKcxyNHEVOyw1w3hRjdCFoTcsTjYlelU9blI8o3Ww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKziQ/VYgb3XuP3NU7V7UIQ9X/jjH48RkU/bAR0IyB/VMqBN2BGNGlUIUG/SWZY176vYNitqj6acQn9yVkhdslD0LqBIwujxCsFV0KEZBldqOC9SC/Gmvd0nOcbg4cvQCnq9TVXwSAVHsaq7DcpoOXYeIYO8mbRDnhUVhuJF4pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnk/LWB+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnk/LWB+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B451F00ACF;
	Fri,  4 Sep 2026 18:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788546934;
	bh=fREYi7D+OXbKPcakcWGx/7bPaIrsyv7nwmuMn/RmQLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dnk/LWB+ycQ+FJLWprQuj/gUEKxnk/mMvYyduyhLYYP4G/G23RB8AeOmufbD+ETNt
	 Dn52PcZXbL7P2tO47M15d4laoDcf6k0L/j1s05Uj44RV8NGQpdjG7/nMNb9TqOsPfU
	 581g2RPSvJTAS3BQvztYf+GGH8XQjF8HXVPOHETekPbUi0nrfwd6sF/gvTR+41iZC4
	 mHinNMm4lZSTWFUAwjChns/RMAHdYf21qofWEebZWQKAE4xDcXIFpzORTFAX0zOFi9
	 r2j+IPGqGSPZviQ8bmzmZSojoMGjrgBw7sxLdU4dTV2PNQNBzpMBFN1mq+VshLs/Qi
	 ODxBnC6P4vLcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Chris Mason <clm@meta.com>,
	Brian Geffon <bgeffon@google.com>,
	David Stevens <stevensd@google.com>,
	Minchan Kim <minchan@google.com>,
	Richard Chang <richardycc@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] zram: fixup read_block_state()
Date: Fri,  4 Sep 2026 14:35:30 -0400
Message-ID: <20260904183531.1325433-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090353-upstart-iron-3320@gregkh>
References: <2026090353-upstart-iron-3320@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 8b05d2d8af817c6a1e23032df51e7ad83030d543 ]

ac_time is now in seconds, do not use ktime_to_timespec64()

[akpm@linux-foundation.org: remove now-unused local `ts']
[akpm@linux-foundation.org: fix build]
Link: https://lkml.kernel.org/r/20260115033031.3818977-1-senozhatsky@chromium.org
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reported-by: Chris Mason <clm@meta.com>
Closes: https://lkml.kernel.org/r/20260114124522.1326519-1-clm@meta.com
Cc: Brian Geffon <bgeffon@google.com>
Cc: David Stevens <stevensd@google.com>
Cc: Minchan Kim <minchan@google.com>
Cc: Richard Chang <richardycc@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

[ Stable tree note: The ac_time conversion described above is not present
  here, so retain the ktime_t conversion and microsecond output.  Move the
  timespec64 temporary into the scan loop instead, allowing the follow-up
  bounds fix to move nr_pages initialization under init_lock cleanly. ]

Stable-dep-of: 391f057f44a5 ("zram: fix out-of-bounds access in read_block_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index bef5388e4e28e..de5533fadc675 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -904,7 +904,6 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 	ssize_t index, written = 0;
 	struct zram *zram = file->private_data;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
-	struct timespec64 ts;
 
 	kbuf = kvmalloc(count, GFP_KERNEL);
 	if (!kbuf)
@@ -919,6 +918,7 @@ static ssize_t read_block_state(struct file *file, char __user *buf,
 
 	for (index = *ppos; index < nr_pages; index++) {
 		int copied;
+		struct timespec64 ts;
 
 		zram_slot_lock(zram, index);
 		if (!zram_allocated(zram, index))
-- 
2.53.0

