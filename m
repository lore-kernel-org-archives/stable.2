Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2723552B1D4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788954254; cv=none; b=Wqfma0GCIfzUxidKIeuOIaY1m5yNeprw1tukL8BQ1xdR347EbZRwlaXQmxVnbOTFoJaMFnAR8E0QAXU7Hvc9Ht0v7Fa4CdyieliYh0/5/9OVMjULp4PGK2IBHUv7Rblt+P1eemcpdvcMViPcQ77axhE/dmCXIYPY4IkddGFiZqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788954254; c=relaxed/simple;
	bh=8ifKmGKLG8iRYi2Jh6KIxnaXOtspWI5x0Ivdg5Jlb+U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qCjPGYQ0bUjghOXou+ydhcV2+WcBJkKxM7hcThqPigPdPX8di4W7M/HGhpnA1ThmCpPUfyUH/O12wNj8QwDjZFq//ZjaXjefTKec0p7Ghu4KrADgoFe1dhgSqX0tMZrudwI2DVKBHLwheyob6UTfB9DhFNzEGCrAMTCArKRt1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h0QcRFn3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h0QcRFn3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8393B1F00A3A;
	Wed,  9 Sep 2026 11:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788954253;
	bh=MCPhP7SjeMN25fNNSVINL1Zo16JR6i1/L8XpJ2YWNr8=;
	h=Subject:To:Cc:From:Date;
	b=h0QcRFn3bnobTZ4s2Ya/l5/kinmeQ4DKU8a0tLa9/AhHRtTrSeEKeCS5DjmmIxUpN
	 7ZIIA7ql14lpwxK2WwOM/4L4LtfUgcVHwwLc3/+8dy1/qXJonsw4T4UhvKjRQrTYcX
	 rUmhf8i1qSqpqemVhQIEQokkP/KHJjlcMoVllUQw=
Subject: FAILED: patch "[PATCH] f2fs: fix to migrate all curseg types during" failed to apply to 5.15-stable tree
To: daehojeong@google.com,chao@kernel.org,jaegeuk@kernel.org,s_min.jeong@samsung.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:26:47 +0200
Message-ID: <2026090947-hardwired-robust-7d28@gregkh>
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
git cherry-pick -x 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090947-hardwired-robust-7d28@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8ec06f50ddd8d201bd7e55b896ae28ed9d4cb7d1 Mon Sep 17 00:00:00 2001
From: Daeho Jeong <daehojeong@google.com>
Date: Wed, 19 Aug 2026 11:06:35 -0700
Subject: [PATCH] f2fs: fix to migrate all curseg types during
 free_segment_range

In free_segment_range(), the curseg evacuation loop only iterates up to
NR_CURSEG_PERSIST_TYPE (0..5), missing non-persistent in-memory curseg
types such as CURSEG_COLD_DATA_PINNED and CURSEG_ALL_DATA_ATGC.

Even though these in-memory curseg types are not saved in the on-disk
checkpoint header, they still occupy active physical segments at runtime.
If an active in-memory curseg happens to be allocated within the segment
range being truncated during filesystem shrink, failing to evacuate it
will cause subsequent writes to the curseg attempting out-of-bounds I/O
on the truncated storage range.

Fix this by expanding the curseg evacuation loop upper bound to
NR_CURSEG_TYPE to ensure all active curseg types are safely migrated
out of the target range.

Fixes: d0b9e42ab615 ("f2fs: introduce inmem curseg")
Cc: stable@vger.kernel.org
Signed-off-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Sunmin Jeong <s_min.jeong@samsung.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 3215630c353d..5917ee917d87 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -2240,7 +2240,7 @@ static int free_segment_range(struct f2fs_sb_info *sbi,
 	f2fs_reset_gc_victim_resource(sbi, start, end);
 
 	/* Move out cursegs from the target range */
-	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_PERSIST_TYPE; type++) {
+	for (type = CURSEG_HOT_DATA; type < NR_CURSEG_TYPE; type++) {
 		err = f2fs_allocate_segment_for_resize(sbi, type, start, end);
 		if (err)
 			goto out;

