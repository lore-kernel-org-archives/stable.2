Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192913;
	b=EfuyRH8muy1npZF8HCkIIXtJhoPpGNds77CmnJNg/Whvd+r2TBvbu+w4hDdIjMu0oOje
	 cyLPwi3C3A03mDRo6jfMb7eqOx2wsCBcwG3ErwLqaC8tUGHOmWLu+hpeCQphmimiDtckg
	 /6ZBHCsW25EwZj7Tw92kTXDRO++HNX8jw50JcubzXEn3FahPWC7IuENIr3uJ/U76zCAiP
	 8O7cwdRtdqLNTBUClUsE9DvZ6Y0rqL9yHYZhys3wym7JU+dDHzHxUMUEHfu94eNCbP1eU
	 lzeGUOfqiR/Xb9ehKRqlioRtXZLurOSu1mIy1Bxl866hOyoEj0dzhnOPE9J8s1LJ/Gg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192913;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=IKnBSmft09ioP6+ZxR9KKOZCCZtmeF7vNHm7XlyFfro=;
	b=FBLe7fQNgsHVEbDJrchPn+6+d7Uf/t7b3GI51KVnnMl2xmCdHo/i/rswijKOnHz8dm4D
	 Fp8wo2+TSkoZK7YpNcepzrzb1LRRRgpACwlGVI6oOIFO2hEyWVFFQnETSSt7VPN2jfy7Y
	 WKDAi9bus7Pe8Dh9qAMZzOw4SsDB50F4vt/WtXnxfNnNIDuP2d3k987G92Z3ztQZx2c+k
	 2oOysJPlbhIR19xe63cWvdSLitNvnWG81+1DMtc6ugBk7D8jH615pEW+stV44uNR4Kfyx
	 o5G9ZUM0/I6oMDRb4G1zWDjpRCLcr3uBLXHN2JdCwyJov3T/Swgx4JelXg6mDfehQLA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CC/YaZmH";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DC0606A326
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CC/YaZmH
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192912;
	b=lrHaEQDUYqkp9kkU3dzNtrKIyAbhCg7DjtlypjnT8YaowO74zjGGL2GuhL2bwrrpVAlr
	 M2DSbGACZrAqd90v7rpb3Skqktf59H14pz3FvTJrKh6DiZIaeyarOwcZIb0X8BrJoTLC1
	 EeeY3ajvtE2HQG67pQyHaBe9+7xX3//mz41Wx+zGNyg5WXJlADhnc0DenJhNR/fXBT3lT
	 24JVz9l/1f6y9YA2VX8JhXAnQDhFiAEmB6RJkpsTkF9vaakGKFOhM9X8ZE9KkD9VRQl0j
	 23GAyknv6d9UvCNb4HSY/t/jZyiceigR+wXyqjw78YveW8P27sHb33SVcosbJtVWWhA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192912;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=IKnBSmft09ioP6+ZxR9KKOZCCZtmeF7vNHm7XlyFfro=;
	b=yrl8NaXrLPvMHULXX+BDe+seaZX713frgiGzZQymB/M9KUw3TgGIyMJ2FOYYWqYSZHcQ
	 uRwDfwa56XAdoraSE3ikRoCjmfbalZeK1z3y50DsWc7kLN4P20Y5EJz9i1UkM4+9CKKAZ
	 AEBp1E/3bS973+kYJLcueInTbnHpIfM1KSCdUBygBIL4habvi1VPXPaF4lCRM3jXXLwsL
	 KfhcnYAwQL1s6193yGFrJ/LtFByey5yADFCJInfP9/BJCOIsAvcj0FA41b/mjl/rDBafV
	 Wl1g1a4enXzDGKSDEcFn8lY3WA28fb/iaic1mbpT3pvzzFZc4QaO0i36xk1gqO1qiuw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59F1E1F008BF;
	Mon,  9 Nov 2026 02:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192912;
	bh=IKnBSmft09ioP6+ZxR9KKOZCCZtmeF7vNHm7XlyFfro=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=CC/YaZmH6qFqXEXrXYIvtJ9ST6vxmS0iubY7mZahJwR4osiHPvX/gUeN+6t7Y3qZo
	 2HALn2vHmoLPnhRD55KwjeG/KTCYFgdiWQ5lca8EyIroroKquAF/Btmed1h0LAMwBs
	 CHNumNoFA8s9WFpgZ2QMNt70AyYQuF7NbDUp9yZn2Ym5QI3RbFjC0a8DMC8aEd3A9W
	 UGmzU/YDFrBFgNWtWz9W3NDG2+W7w3gBF8UnSwNgaA0cS8gc/sbLaBWm8THpzNjzWE
	 lycQTtYpnu4VF1I3BWGs7jTlitXjxty583gt84Tp7uLFxVAYfGA7mArtIPh79Ke0Ro
	 ysWQFYmRWtdaw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E1ED94820F;
	Mon,  9 Nov 2026 02:55:11 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Mon, 09 Nov 2026 11:55:12 +0900
Subject: [PATCH 6.6.y] jbd2: don't advance j_fc_off before the buffer is
 recorded
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-jbd2-fcoff-6-6-y-v1-1-4ec879f3b004@samsung.com>
X-B4-Tracking: v=1; b=H4sIAA828WoC/x2MQQ5AMBAAvyJ7to1Ws8JXxIF2yzogbSJE/F0jc
 5rDzAOJo3CCrngg8ilJ9i2LLgtwy7jNjOKzg6kMaV21uE7eYHB7CEiZG3VDvibnrJ0IcnZEDnL
 9yx5IkbpheN8PDeEmAWkAAAA=
To: stable@vger.kernel.org
Cc: stable@kernel.org, Yu Junzhe <junzheyu1@gmail.com>, 
 Daejun Park <daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192911; l=3811;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=Uu0LmmE04GoLGajdvXMq0EfJHZxjCivUpI5io4+iJvA=;
 b=q+xpgXV54Q7rBbSBqWi0bs3UY7UhttXJBrz946Mz+MRG0nxt8dB40JLNc9MAhP4jv5ohTufAe
 ZvW37qmgzLwBzYM73zsBkg3go9rFfoUCTItobwXH8HgniJe33a5Dqqd
X-Developer-Key: i=daejun7.park@samsung.com; a=ed25519;
 pk=4yUfDqGRZTIj0Ik43z1GoMZRWCNm/rgX6uJuM9dtNIg=
X-Endpoint-Received: by B4 Relay for daejun7.park@samsung.com/20261006 with
 auth_id=1122
X-Original-From: Daejun Park <daejun7.park@samsung.com>
Reply-To: daejun7.park@samsung.com
Content-Transfer-Encoding: 7bit

From: Daejun Park <daejun7.park@samsung.com>

commit 9f359c031885bb50add7d23c7a5a0e9755b134c9 upstream.

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

[ Context: in 6.6.y, jbd2_fc_get_buf() still advances j_fc_off inside
  the if/else bounds check, so the increment is removed from there.
  The change is otherwise the same as upstream. ]

Fixes: ff780b91efe9 ("jbd2: add fast commit machinery")
Cc: stable@kernel.org
Reported-by: Yu Junzhe <junzheyu1@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/7e4b109d-64c3-444f-a5dc-93c2ca4576cc@gmail.com/
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20260819060939epcms2p37bb8589b2f8a52a2b14bef38fadcf69d@epcms2p3
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
Tested on 6.6.162 with KASAN and slub_debug=P, using the reproducer
from the upstream commit. Without the patch the second fsync hits a
KASAN wild-memory-access and a GPF in jbd2_fc_release_bufs(). With
the patch all six fsyncs complete cleanly.
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e0d82f83ab..ad3f522101 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -869,7 +869,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
 		fc_off = journal->j_fc_off;
 		blocknr = journal->j_fc_first + fc_off;
-		journal->j_fc_off++;
 	} else {
 		ret = -EINVAL;
 	}
@@ -887,6 +886,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 
 
 	journal->j_fc_wbuf[fc_off] = bh;
+	journal->j_fc_off++;
 
 	*bh_out = bh;
 

---
base-commit: 5139929c698c273e07cb0635732f6a918a7b8e78
change-id: 20261109-jbd2-fcoff-6-6-y-176d36cc44b6

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


