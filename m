Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049395;
	b=IPTZEXFhAEExtFnehHUi8OPM+7DixNKtMVJhsCSpXY5+e6omNPffYLCX/imosWeN8DEI
	 7zIOykqgNT97LfQgQX17U7IvE5qnTu1vOdC4pLJKcKYI0pR7J+1sDHVSR9U2jM+4FQRbH
	 HUHh4RpSQV0X0dhzvyt2C2J0+xN/oG0ALWMvFo3TQYOiRLatxy7GGo5cUvl80KfBHH3JC
	 k0S2HNzj5BsY/cozzHn07Dd04/mnIU/4huAplgw223itaZxH2ntI4bjwhPelqP3B7jCSK
	 ArCCLVSr9yBPpa8X0MPntlJxfACBdjEVcaGuCL6HWM6TkuCKu7ruwE+evXlncDl1GVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049395;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Jj2W2AHA2wGKiYNtDEa1hZPofpGl5IKMqwIr72+gTm8=;
	b=bD+MGgFdVQ9PJCXJlhThBKIz6bBKFvpFBN2S12VwshnabwLKl5sPjo661kUH++PAXMWq
	 M1cEOL+hBqVB5qQOJPeWSX7Tij2ClXA/84CJ3nEAdvy+XtAtweJh9SuxSPS9HJA79YHfA
	 uwGNiDhE1A9fO0DwllUJAIZk4/sEarutawoNqOrY4+r/aeX87EpnotS7d6XH+s7mhFG0Z
	 ChBtmHXGq8oJ3SprOBlYW8zg65f3610CGsFnrZ7sHfL4GsOAUCIeCtEHCYrLbSTW5Qtbb
	 2VuxMXFB5BC3RDPYohG1IwhWPY8j6Fin2zWecd8Fs12mZshocGeFAQGBzn2OZH0pZFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGm4Lurw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85666606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGm4Lurw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3A11F0089F;
	Sat,  7 Nov 2026 11:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049395;
	bh=Jj2W2AHA2wGKiYNtDEa1hZPofpGl5IKMqwIr72+gTm8=;
	h=From:To:Cc:Subject:Date;
	b=bGm4Lurw5GeVzDWfNYVSHwZUlwDHIBNC0y4/fuxwfwqmIL7vgjsCiKHmrNSBBGqT+
	 UGqByyJIoJT1ToASYjSPTBJuIPEyTjr8CnOWFwcTWFVq6KGgERbO5sEJrE9jguGF1m
	 nzLazgQhE+1sam+SwbDTaVIMtTwDiOYHtC8hG9xep103DmtyHq5h/3jf2AkK/7eHZ6
	 MpRw6Ql41U9cni5If11eEUrU2geVut3z9A+n3qu1Unzu5ShjaQBukciOdO9HHrwq1N
	 0xgOJGcAb0G506sc6642czu03Qi3p2jOEge7NtjFuCAAw9jZ9N+GhYgfrs2YvSANu+
	 BghJwVIpcfMbg==
From: Sasha Levin <sashal@kernel.org>
To: daejun7.park@samsung.com,
	junzheyu1@gmail.com,
	jack@suse.cz,
	tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] jbd2: don't advance j_fc_off before the buffer is recorded" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:03:13 -0500
Message-ID: <20261107060313-failed-5.15-9f359c031885@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 9f359c031885bb50add7d23c7a5a0e9755b134c9
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060313-failed-5.15-9f359c031885@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




