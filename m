Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047573;
	b=hNRIngCQa4Vzo6TDtefQ8zngXl1EP6wJ/WTGf6pH1pwYzWOwDiMzE3DU+cVYh0M6PEq/
	 N14QJzjEqAFMxmLKJy09L0jhJ1A4ioDAoLF4pgqsRciYNCsDiu2AdABTr9DYVIutw+u9L
	 xPa8X+8aRVhs9GtupeT3wPWlG7QjgDvSeg1DU9GCHeeo7QT1pvswCABqXt57ekiu2HFDj
	 87bPsV9RXeHe3tvC05PeceIbwi1dN5x0kvQkplOKpE/mdIxR/TfErgce4WNbt1YwhviWL
	 jgUyAtUiu8qSI/5f93GfZnk8XuLY3FPTytOmEfCaZYfjiNdNB0q0AQaelEfZf32C89g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047573;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aTA6To6rSKw9ZdZBi1MCpy9t0Pee8b1VKsdgalSWcMM=;
	b=yVYj2BC4fR7KdcJkVUx1lYp6oLMMSlPqsrOlezAYo75kmchF/Tz2epvEmPPYEr+JQm6D
	 O3g2wZ8iGy2m4XFbl37CSzHOKhZXsPUWFmO0qrpiAtlFJvxqLHYmSKdy2clpvEtFyc5BL
	 Vu+LypKMh0Fmmn9tvVwZ1VO6ZN/gRer/2ixazOHM4NNNuWJeiT236VEXXqpklmlvTTlRg
	 MmWnqerY085qVp9u4qfIhdgUE+rdk5AduQfYyafMfzPzbEb0ZWMQRsjDYigY6ucHKXCyf
	 AC+pnzSGiQBRDjwIN1Dat8Xr29m8rZCIC353fGz2VpSNIobzTLjZ8NvSRoEDRC3g/6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPc8H5r+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D0606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KPc8H5r+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E061F0089F;
	Sat,  7 Nov 2026 10:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047572;
	bh=aTA6To6rSKw9ZdZBi1MCpy9t0Pee8b1VKsdgalSWcMM=;
	h=From:To:Cc:Subject:Date;
	b=KPc8H5r+PHuN5HWaR18YbCxYo/TCb8dKZHBigLn5+hwO5TCWxz1aKAa60lQ3N0VU0
	 OZ1jICrXxbhfAKZv1ekCTQeM60Cm1Cx1ZQnfYqQMMw6E/W4aLgy/VbqIYxTej7rmy1
	 EQ55dq5Bu9cwXVN+lk1mUBBSdbYUc/JUoZIzQ01FsUlyOBgfxPh+cjQFDYoLOShA/2
	 RMPkkzNYio7oBcFgX0FU1RtB5Wq0xSZN5EB1odmRQAjjziIK9HFSLMAnu5OrbS13GV
	 tKqm9L9kI7wgUBqU0Ol4okUHHWGld55aZQvvPIxIfuSlv6OQdOU8xpBPaSIQT1URyV
	 w/rwSWmwRsHLQ==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	junzheyu1@gmail.com,
	jack@suse.cz,
	tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] jbd2: don't advance j_fc_off before the buffer is recorded" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:51 -0500
Message-ID: <20261107053250-failed-6.6-9f359c031885@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9f359c031885bb50add7d23c7a5a0e9755b134c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053250-failed-6.6-9f359c031885@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 9f359c031885bb50add7d23c7a5a0e9755b134c9 Mon Sep 17 00:00:00 2001
From: Daejun Park <daejun7.park@samsung.com>
Date: Wed, 19 Aug 2026 15:09:39 +0900
Subject: [PATCH] jbd2: don't advance j_fc_off before the buffer is recorded

jbd2_fc_get_buf() increments journal->j_fc_off before jbd2_journal_bmap()
and __getblk() have had a chance to fail.  When either does, the slot
j_fc_wbuf[fc_off] is never assigned, but j_fc_off already counts it.

ext4 then fails the fast commit and falls back, and the fallback path
reaches jbd2_fc_release_bufs() via ext4_fc_commit ->
jbd2_fc_end_commit_fallback -> __jbd2_fc_end_commit -> ext4_fc_cleanup.
That walks down from j_fc_off - 1 and put_bh()es every slot until it
sees NULL, so it also touches the slot that was never written.
j_fc_wbuf comes from a plain kmalloc() and is never zeroed, so a slot
used for the first time holds uninitialised heap data.

Advance j_fc_off only after the buffer head has been stored.  That
restores the invariant that j_fc_off covers exactly the filled slots,
which is what jbd2_fc_release_bufs() relies on: the live buffers of the
current fast commit sit above the NULLs the previous one released, so
stopping at the first NULL is correct.

Reproduced on a KASAN kernel with an ext4 fast_commit filesystem on a
loop device, truncating the backing file under the live mount so that
only the journal's fast-commit region falls past the end of the device.
__getblk() then fails for the first fast-commit block while the rest of
the journal is still addressable, so the journal is not aborted and the
fast commit reaches the fallback path.  j_fc_wbuf was poisoned to make
the read of the never-written slot visible:

  BUG: KASAN: wild-memory-access in jbd2_fc_release_bufs+0x6b/0xd0
  Write of size 4 at addr 5a5a5a5a5a5a5ab2 by task sync/961
   jbd2_fc_release_bufs+0x6b/0xd0
   ext4_fc_cleanup+0x97/0x830
   __jbd2_fc_end_commit+0x37/0xc0
   ext4_fc_commit+0x524/0x560
   ext4_sync_file+0x3c4/0x4b0
   __x64_sys_fsync+0x20/0x30

With this patch the same run leaves j_fc_off at 0 across repeated
__getblk() failures and completes cleanly.

Fixes: ff780b91efe9 ("jbd2: add fast commit machinery")
Cc: stable@kernel.org
Reported-by: Yu Junzhe <junzheyu1@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/7e4b109d-64c3-444f-a5dc-93c2ca4576cc@gmail.com/
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260819060939epcms2p37bb8589b2f8a52a2b14bef38fadcf69d@epcms2p3
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 00f5a98f3d4fe..55b4ce0102289 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -843,7 +843,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 
 	fc_off = journal->j_fc_off;
 	blocknr = journal->j_fc_first + fc_off;
-	journal->j_fc_off++;
 	ret = jbd2_journal_bmap(journal, blocknr, &pblock);
 	if (ret)
 		return ret;
@@ -853,6 +852,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 		return -ENOMEM;
 
 	journal->j_fc_wbuf[fc_off] = bh;
+	journal->j_fc_off++;
 
 	*bh_out = bh;
 
-- 
2.53.0




