Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192918;
	b=VqhqgB/Rf+fvdd/s8LtuWt+ft/LWSV5PPZHOi02jWE2PMgH8pte4+TE4Bw3mNq5EabDl
	 Ec+ZJsFeWZxXtBlCsYzTFVsOnfqrnRNAAvvq6KhUAiXVv9quA4hlfe2dqfcWr9CT7YA8f
	 ZFPs+EV3JvuSa9Hq1mnMWVj7ZczlJEm1AkNz+6KBgGMnTAKpSgptClOYM7aIY6C8TDgXZ
	 uFacEqJHlNGlEc1PgBYJas35Ir6KxTBC7exvkHqYQDA2Pb7K9OwchpKlJdfy2cvBn7QAF
	 zbb51UQIqk7oDSsIHQaQABUkzKuqNpDzq8ZJ3P86cz4X62mOFJGlVmhxYs9GVUjdrWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192918;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZgE24YUplArNeIjJudSvxDbwjm9PEaCmJ4MFBFx1iQ8=;
	b=k02yl01pSPwcf+1UVqK324tJZzsoBC3OjuxlgZXxHe1ljzhkFamWIos2snooGIOBBvKe
	 TvG4CTkv7hAOzTdcOq6ETs7CzAnH9KsKaNL1MsV8hf4MgRQk8SA4K4mNyMX2c0CwDPq46
	 ciosnFGrz+kYx5aRfAw9OpuNs7iC7l7IDbHhgAFOSrfmh2zr2OhTo1a9w/5ym9oSIfWuO
	 FuFPXFMfSaNxpME4hgfj3y9JT7KHeoWja5c5dcnj9WvxS5hyzzqfyyiyiHDawyegxx0Pr
	 /7SOdzbFQEMkDBzuChpfMCMuOr1zyvt7wJ1d8FbPc+JmNYo+QCZWV3FKx1yVYrfZKyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P8jb/LTd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD12606A332
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8jb/LTd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192918;
	b=sJOBoB824VzgaflYSCM9lb/qcjpoNcLCRDK7K6Nx7kqbnnwemc8MDxOGJ/Q/v6+msvAS
	 s+QGu2TveOuv+oueBiC2YkpCGM3MjfB4iJMmCnab5upk7QVZSsWW3s/r9ga8jWi9/1bfX
	 ol0iDujMlyT9PFniqij89T5ho4apPPvA0X67qoMcqBbGBHDgKiQaUcd8XiXr0O3VqRDJc
	 rUIxrXOavATE4aDY9lZV+c+3To9fwyyQF5j2XewLcnuYjr1B/JzOpadMSykNxK47Amxv3
	 YleJfJgDEJbogQ3P4aFkez8YbPhbcO8RPVwIx66tanYuRfM1aVVj2bRyWf9Bi02psgw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192918;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=ZgE24YUplArNeIjJudSvxDbwjm9PEaCmJ4MFBFx1iQ8=;
	b=n104XdEyYbgiLqJaZS8d3yV3nP0sXXJZngWT0k8Afi0cPGVCHxmeJH94QbhTgH/YKVy6
	 3L0TMyh7cioSm1f9Mt2KOkhguZpDkFC+fFcrX0OsmYyZkVqULYXyyCl2m24a6VkGNCLkV
	 Bmd47WpCaEbsQpkzBZOxRVQZFuy/ptTTLcePFwwFiccKroYr0sLMTTQQjMHvP/yDO48+1
	 NWISfdAft+HqXJ4FxwOxWfpLG05wAj5x0sPN1A6wUWa+dO7eLiJCxhtSmOtYjMjltV4Eb
	 dwpaCsHkPMstcze8er22QcKhL+BWjQKfdbY60SLIoa+Ullzg+A6A1lf6iRNclhctJPw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B27831F008A2;
	Mon,  9 Nov 2026 02:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192918;
	bh=ZgE24YUplArNeIjJudSvxDbwjm9PEaCmJ4MFBFx1iQ8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=P8jb/LTdQNLTme8KVEG1sCO9JssYfjuZr5SPaj3gaJC3MwMC43B9PE6XDNGD752TF
	 euRVAxUngx1pnakLnlj8KLRcLPwDOuVk09zBFOU9HLca64qMRxpeyk/lEHtq2kPP76
	 8A7foKZWovaW5uJz4hXsKQkClpMnAS5xgYpuITpzNvkj2yvAj6D3SHfFKCyCj9mulS
	 npbVi/BQkvaly22SUVifNhTDfqDYhN5LnT8/0dsHmeE50BvZ9HRSCyT/KcDVKAt/Q0
	 xFGpm7Ip71EmWvaGUBGxVUhl6yo0sq+dvODhnBlezcPqrb0Iobu7fsv835WyurHJIS
	 twiwkd9dp7wqQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 466934820F;
	Mon,  9 Nov 2026 02:55:17 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Mon, 09 Nov 2026 11:55:17 +0900
Subject: [PATCH 6.1.y] jbd2: don't advance j_fc_off before the buffer is
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
Message-Id: <20261109-jbd2-fcoff-6-1-y-v1-1-e11d3a042ed9@samsung.com>
X-B4-Tracking: v=1; b=H4sIABQ28WoC/x3MMQqAMAxA0atIZiNNhIJeRRxam2ocVFoQRby7x
 fEN/z+QJalk6KsHkpyadd8KqK5gWtw2C2ooBjZsiUyHqw+McdpjRIuEN7JzPghZMi1DyY4kUa9
 /OYBtqLlhfN8P/vbViGkAAAA=
To: stable@vger.kernel.org
Cc: stable@kernel.org, Yu Junzhe <junzheyu1@gmail.com>, 
 Daejun Park <daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192916; l=3811;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=DB4jju35q/lOLZ1lgLy/or9OriED2O77j2nEtkbVCqI=;
 b=ZsodZpVCCGe/ZdKzkj0PmsglfEtu/FrYZnegZ2AZrNfiNJh6yu0suf0Ox5nH7mpwINyHowffE
 8Q6XfUOQ80uDM83tes8DvajOEGcFm/6lj6sAEOzqDdSyCSw7HjRZpRs
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

[ Context: in 6.1.y, jbd2_fc_get_buf() still advances j_fc_off inside
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
Tested on 6.1.192 with KASAN and slub_debug=P, using the reproducer
from the upstream commit. Without the patch the second fsync hits a
KASAN wild-memory-access and a GPF in jbd2_fc_release_bufs(). With
the patch all six fsyncs complete cleanly.
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index f54836c1da..4d26457f2e 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -881,7 +881,6 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 	if (journal->j_fc_off + journal->j_fc_first < journal->j_fc_last) {
 		fc_off = journal->j_fc_off;
 		blocknr = journal->j_fc_first + fc_off;
-		journal->j_fc_off++;
 	} else {
 		ret = -EINVAL;
 	}
@@ -899,6 +898,7 @@ int jbd2_fc_get_buf(journal_t *journal, struct buffer_head **bh_out)
 
 
 	journal->j_fc_wbuf[fc_off] = bh;
+	journal->j_fc_off++;
 
 	*bh_out = bh;
 

---
base-commit: c75b0cf0982c00cddfd88d1acf3872f79b40980c
change-id: 20261109-jbd2-fcoff-6-1-y-2aabde161032

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


