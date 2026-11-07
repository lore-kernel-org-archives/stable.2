Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045914;
	b=v82iP5kPsw/5Cj99H2c80kYPubv50+arggh7ehopk+0xFqhJ2a7WNmRmFBBr7agh1Tpc
	 MlFYr1dTbDV89mcWOq2FKDyqE6KPDqKFSD5VXlgLhMajctMgy/p+DKHKU4yJJz3qq54EO
	 hO4uTjz5CzPcmUnGRi+7V8B9OFCzHVVBO/WRc7YlRINJVTpo0cvElT6EnFGz/5///BPzk
	 odKpPzHZ4fRkIDrBZ2SJbUihVbiyta+nJXhClDjvUaMoh5bEqZFuGCn7EUTtmXh4n3Mdz
	 xAfUAifknjF+q+Mp1FCQQ01dDJekPql/9qTYvQ3sX3OI6VLc/2txvGAC2ae02veh8Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=nLiM/ROmDjeuM8cfuHury5Iw6YyXV7gF8ZxgByRFLjo=;
	b=vjw7hvFSLKLOHTOzzWLLxd/Wg9vrtfL3WrouvcbcNbJm4lc37Q+y3PYhPL3Y2wOSMvxT
	 fL8paGIAGiQ25oHfs50fiIDWVVpquXYHNDn/qGRdUu6FpnNoHcri166Rg9moN71+OymRK
	 dIGfnOo/dFI65Vns2Zp9uoK10KF4uK31yIhrYfKgb+N11jU4lTB4vS4k3LO2Ko6vzR6MH
	 rVyeOTDoRP9gmadJOmtdhncR/H2Xu24tHKRbPVyZmfchBzTf7Gk3VJhQMQUOPH3UfNmBc
	 HdhXWLqJUq4BOkY2JOB0Ixkz6ic22GkWQ7mln9P5DWqQ/KyVN/kSZCxvuMnpxN35vSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="R/Mhv+Zs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B614606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R/Mhv+Zs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DC9F1F0089F;
	Sat,  7 Nov 2026 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045914;
	bh=nLiM/ROmDjeuM8cfuHury5Iw6YyXV7gF8ZxgByRFLjo=;
	h=From:To:Cc:Subject:Date;
	b=R/Mhv+ZsLSE3/CQLy5LMGGH/BLUnbUVb8UmLSo32HwOWvNODTfP4yXesig8dszv6s
	 dDKaJBGhmK3C/iSRsLIvAR8UwdXLWGPYg7gzyAWn4rcimzt/RAJ2WtLIdUC8d3o4da
	 ljmeXzUQsLvbebM+NQrdNYPXBna+xf02DWj2jM0rJssOe5bublUdpPpzEOEwNqnQ3H
	 4yF5+8B//auwHPF6cx93aAICpZFhmv2/NzioYI5ruAYUs5Fp0pvrDxVTLsVBlq1SOV
	 cTDKMhiuASIu3u7vT0TNbGKKTDSxwXc2BwY1kNKCogGRbjv0M15IKivJDqBcf5/R9a
	 eAu0a2iywIcng==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	daehojeong@google.com,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid potential reference count leak in do_garbage_collect()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:05:12 -0500
Message-ID: <20261107050512-failed-7.3-894ca8b85666@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 894ca8b856668a82426dbd0a0042b61541a1a9ec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050512-failed-7.3-894ca8b85666@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 894ca8b856668a82426dbd0a0042b61541a1a9ec Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Fri, 16 Oct 2026 10:17:37 +0800
Subject: [PATCH] f2fs: fix to avoid potential reference count leak in
 do_garbage_collect()

In do_garbage_collect(), we have reserved reference counts on summary cache
of all segments, once gc_thread encounter freezing, we need to release all
reference counts.

Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Fixes: 02d91398a602 ("f2fs: fix to freeze GC and discard threads quickly")
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/gc.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 540769ad58acc..18aa6a12e805d 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1871,6 +1871,9 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		if (block_end_segno > end_segno)
 			block_end_segno = end_segno;
 
+		if (unlikely(freezing(current)))
+			goto next_block;
+
 		if (is_cursec(sbi, GET_SEC_FROM_SEG(sbi, segno))) {
 			f2fs_err(sbi, "%s: segment %u is used by log",
 							__func__, segno);
@@ -1938,12 +1941,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 				sbi->next_victim_seg[gc_type] =
 					(cur_segno + 1 < sec_end_segno) ?
 					cur_segno + 1 : NULL_SEGNO;
-
-			if (unlikely(freezing(current))) {
-				f2fs_put_cache(sum_entry, false);
-				f2fs_put_cache(sum_entry, false);
-				goto stop;
-			}
 		}
 next_block:
 		f2fs_put_cache(sum_entry, false);
@@ -1951,7 +1948,6 @@ static int do_garbage_collect(struct f2fs_sb_info *sbi,
 		segno = block_end_segno;
 	}
 
-stop:
 	if (submitted)
 		f2fs_submit_merged_write(sbi, data_type);
 
-- 
2.53.0




