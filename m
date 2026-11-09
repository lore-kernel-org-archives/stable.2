Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192929;
	b=aVweX6zdUk3W8o7It1BiEarBomltLwKePdv15ZEswLB/e+awRqLDkVA/7eqyyS1FKUfy
	 NLM3iGrPBkgBDhBjxmU/RQ7YndzkqUgaWuT+Zxd7ayKKz9FLgi/BbBgLi5iWX61Tg1mP4
	 13JPXFPkgU9MkWkay16MJdzpbr4UL8x9pxecWBCev7tj287klzGJrd4h7K4drYKIRmIPF
	 VjITxGTMTkHjijBoKU4UbaqDe1QlniMd+l3GMJvZvMgr060f65ftw1rgewzfWz2FJmtBp
	 GD+hRQHCJ2J6sJQdtUUGfhVhlAQU1aG0SRwrHFvHOazDuFu2kU+cNMse317uWWPMYkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192929;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Vysd62ktjSIcOycS1ZnevzG04JVAWFgGHG9Ws7rDxoY=;
	b=ubHsYMj6jvxcv+K16y0g0ZQAFNyk2/8GDy/1t91K+ACBBcwhEBWJaxZNmGbEbYw0iaLb
	 89Vj5dSJKK22StWZLgIjWGdKQb13npnoxe6KgYCk95iyhn3z+im+eRu6O9M+5GxhUW3cO
	 lG3OeCCEq1vub+T+5Y+tQVnV1JjJMpByR+QmAApo0lBpblZYQs80/9C5TGIIKVDDOLlME
	 VY5rJ6Znh2nev23EaDGexRd91xpzf8YCgkmJ6UpsbjJTZWrGUsg7RbBkHszp7fmgaCuq9
	 De5i7S1iqUmYZqEBQAS4wQvZPchz3CBxMG+F5J9N5A36HLjkacC6QWpYZvtmKVnzlSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEMJ6HU+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE7606A321
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dEMJ6HU+
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192928;
	b=ZEmf3dMylRbbKT3JORH6gcFjeiBG4wgxNMjFERyK1LWrsrLbdS5TB7D96j/p5WQg0OMX
	 MkAlFZfN2OnpqBmAlhbQ573DeV1cwoUYd6+g9bd+47z0LSff1r+zK/jjY/VXdNkgBBO5t
	 7SGvuJGY/uJT88nJS9n7aXSxHvHTTqT3qoNz2VhAxn5W2rv+LkBCrcWAvUTpZz04vQScP
	 So9hgvAYcZO3qxCZnu/25e0n7I/Ogz7yeCC7KH/GvJtTL7GU8QYHPcp0c04xy/wzuKs/k
	 qAJJIrg7mrnYKsyk27VJ+C6vRvspOi0YIA+8/EkH/YY0/MHXeQhk2gwnuZ2DcMT+qHg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192928;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=Vysd62ktjSIcOycS1ZnevzG04JVAWFgGHG9Ws7rDxoY=;
	b=wPeLC5djZOB8uJKghzFUa2gXtcRZJD2kSL5jdg+o7uxcBrACDB8jJrdq1lo3rKI8IbGc
	 Y/Oj/E2YmdSeNx45N7G7cBgcXbJx6B5pLMFldmpsldy2KNpgGcKLehfYXiaeopUIci2x4
	 0pVlYWJew4J1dkTvelmBWrKT/sJPUfDQXwWj/C5bMYuwwNYlmbKVSRXXYbE/zpEPCJjof
	 VQ0cRv6wN4daXj3PMFxmMbTN9HY5wRMV1vJToabkj+wggiW9yV3WHt4cneBruyPCeoDWM
	 sBTNQS3/N6pfq32MDqdXR3ovjN1z4PfsfzuUcDla0mMro2LYlqXBx1XHFmxTSW8zbfg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E4DC61F0089F;
	Mon,  9 Nov 2026 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192928;
	bh=Vysd62ktjSIcOycS1ZnevzG04JVAWFgGHG9Ws7rDxoY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=dEMJ6HU+Wjc66qOrtDEmCtIDlMMzcsTAqioqAaQS7nGaMlBFPeNqo8uzjhPQLUFlh
	 AvT+dgy97wLgnuO9Kl3udTw2NJYLDeYtAAH3Wu4R9yRR31dWZEFEcHmIzbsI0Ypx0G
	 afZ+AUH4fGPa6zN0TphUi/0L4tMzIrPueXppIMusUqYTsLrJ7VrL59VJ+dU/Xl0n6u
	 PxEgTWzcybG0zTrpPv9tm46EAlk33EtkPUW3inNBn/VYgzak93LtKmFJa+Od9QiZzs
	 cHQtpkt0xzQVa8ih1SFklId6gNGQrTBn8aZWpudXw0j8Zp4SOatpGTjEWQZ2fJkZ0I
	 efw3mkylPCJmA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 78F804820F;
	Mon,  9 Nov 2026 02:55:27 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Mon, 09 Nov 2026 11:55:28 +0900
Subject: [PATCH 5.10.y] jbd2: don't advance j_fc_off before the buffer is
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
Message-Id: <20261109-jbd2-fcoff-5-10-y-v1-1-7e8776914093@samsung.com>
X-B4-Tracking: v=1; b=H4sIAB828WoC/x3MQQ5AMBBA0avIrI3MVBCuIha0U8YCaRMh4u4ay
 7f4/4EoQSVClz0Q5NSo+5bAeQZ2GbdZUF0yGDI1M7W4Ts6gt7v3WCET3jiyWEdiGykZUncE8Xr
 9zx6qgqm4YXjfD4vhPNprAAAA
To: stable@vger.kernel.org
Cc: stable@kernel.org, Yu Junzhe <junzheyu1@gmail.com>, 
 Daejun Park <daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192927; l=3814;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=jNg7fCEqlITeuBHL8iWeTRYL2C6UibsFVXsTp24IYfQ=;
 b=S8BkF0GcE8dW8jMlbLmBFuPe8TI2qRvK8lr5iyPd2HTgdKg/xe3jzKV4WXTP+aoteVi7uYIQf
 Xob7BI3k8QGA/U+3AmjrYC2lJJN0ntrkoww0Qwg+3lIefyHIl7TOEVH
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

[ Context: in 5.10.y, jbd2_fc_get_buf() still advances j_fc_off inside
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
Tested on 5.10.274 with KASAN and slub_debug=P, using the reproducer
from the upstream commit. Without the patch the second fsync hits a
KASAN wild-memory-access and a GPF in jbd2_fc_release_bufs(). With
the patch all six fsyncs complete cleanly.
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 526d2971f1..cc2d3209a4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -884,7 +884,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
 		fc_off = journal->j_fc_off;
 		blocknr = journal->j_fc_first + fc_off;
-		journal->j_fc_off++;
 	} else {
 		ret = -EINVAL;
 	}
@@ -902,6 +901,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 
 
 	journal->j_fc_wbuf[fc_off] = bh;
+	journal->j_fc_off++;
 
 	*bh_out = bh;
 

---
base-commit: 3a323bc22b881a5bdc1646080f93f5ecb22850bf
change-id: 20261109-jbd2-fcoff-5-10-y-a1ecd0ec7e31

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


