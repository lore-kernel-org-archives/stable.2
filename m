Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794192925;
	b=CnmL+/tYt6a3dmSoEn76/3sRGRb6X+CflkMLVw/TnRjkyOh3qMJQMK7pYVxYICK1rkzm
	 YoG7/zuefHO80sOS052xHdmIMfa+tXpgAMq0sjJ5PXu4L6hxlrUalQq6iWDc3WbkR+h5c
	 Ggev3g6t/kJ6KvMeToTAbLUJbxkdtaztil+1gD+x2rpuap/+DjYJ7hzmbsgIB3Q4ULh/P
	 B9N5PpTCoIhq1UrQy9Ya8UYu0hOnAqYqYqIerVaiUcTm7E/S3Wr4myAq4ZPT2yU1A2YXb
	 P/YW0EoUKSbzMMSeUsqBjJxB+RW1uroyCo1T97zbZGThPnxB77rHASOM0jV4A+Vtdpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794192925;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=vkkouqD3eOmaURIuuANcpABZWjGjROFkU+zwwnKEs6w=;
	b=MDhK/ODOP/o2JkzwYiyFZ0d3bXt28vxaWIOExikADxDpU2Kjw+MEWKPdLEq9R+TckorP
	 yZ9dsirBWoNxAkjxW0XFMmpKhlYKMyfh0z9jd0ZBy94x4Es32VnVcKSyu03Gsmh5m86hc
	 XS/3wQqwSV6Z3PlZN2RWaYBf6FB4sBVSeT6+VwEXIvOUb1pqiTBUlsl817Xzt5oa/HdmG
	 XFD+3ak7PgHDQ7SktwU6XwWDjcO56s8PRvUgI3+KJqKNPcSrDOBwG9Qy4l+t9D5DfFBqr
	 U7JObgkWiETmJIPWO3T/RYxtzXht59Sf/UvTh9KBHtomzEJJLCyvBTc+aRueg9G1w1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FicrlcsA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C2606A325
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 02:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FicrlcsA
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794192924;
	b=FZgPPhN93WyVh+zg7uS3voezj8Ouyrjx4OX70prirJlqzgf4r7+BKu9KE2FlyBVE4s1Y
	 GKMlXiF7cl95maPeHjMMQ91jZ7jfqzjw8flff2zkaRRw5XDphKCBYTONyZpE+j0JekN33
	 OzfghcQeURaaY4DJWQ3l8VfL/RtuPDVuUJldFnFy3UD1R3/++AuyQtEvz+CTEH6jQHKWM
	 ldI/LJujxt//aVL410bNg99xb2DArSSKk5484tFYSREU5exauWvScBihjOJoM8YfrGsKv
	 hEODYP+dvznov1rXborIG/dhk7Rh0q1NIwbKHlnWCRwhRFGHCSnP6bhesgIhmCnDG9g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794192924;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=vkkouqD3eOmaURIuuANcpABZWjGjROFkU+zwwnKEs6w=;
	b=ZLlX8XMGWJIsjjQOcE0KL2N5fPe1BTjYgsEQS8z7LcSF6NrfuHp1vhvhw4+nwrmeKyhm
	 YZCxmDT/1VA4X1H4/BoPZQ0wZRi6pPXnZ8RYEwkoCPy5euONIoGXeQaZC39sSrqRzRo+i
	 KZcvJRe4oRG73Oi8fat1pyJtNlB4p7IqP3xM1tOfx5WP9m59ONt7hyXI1c62aWc8JtXZL
	 hdaL3FtFCvimPdg11UguWXjCIwQ+/shhXdA/znMIDAlJhcfQnMaytYGAVIypDLVC6h3K9
	 SWLjkA5/JYNb3brokH6Cj+tnN4CuPdFCeLSKUG7B2bem+42jqaBjxqba3CNMT40W0ng==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0A5EB1F008BC;
	Mon,  9 Nov 2026 02:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794192924;
	bh=vkkouqD3eOmaURIuuANcpABZWjGjROFkU+zwwnKEs6w=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=FicrlcsA8IC/QmfgFwVhGava0+CNIkIfDMi4ZYaeCHoijcE/raVn8eoi9LDvz8pQU
	 ngG8dCefMdx7wvGSadskk13jRdxFkdMsy5BjT/rE3bZPnn04Q4sDxHUhCHoWEF8UMq
	 I8FeRBf5G/IuiIeHCe5PqrZ9wcsw4z5ndwIVKfKZLhpLq//7NWw79I2R3gCPFVMzpM
	 kQbvY7+7U8yY4Zhh7zWsxo+FXoIWkaNyqHiEqgCybSgg27PJy/3kZaALnEW6O1ba6o
	 EfeHaap8SIl5dY4SioX6hapmcejxi2/4xADZHBRsGr1DJvW62NFnKXqOhQ9x38B19V
	 iQm+oR8UgDqeg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 925774820F;
	Mon,  9 Nov 2026 02:55:22 +0000 (UTC)
From: Daejun Park via B4 Relay <devnull+daejun7.park.samsung.com@kernel.org>
Date: Mon, 09 Nov 2026 11:55:23 +0900
Subject: [PATCH 5.15.y] jbd2: don't advance j_fc_off before the buffer is
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
Message-Id: <20261109-jbd2-fcoff-5-15-y-v1-1-bdc09d7a5941@samsung.com>
X-B4-Tracking: v=1; b=H4sIABo28WoC/x3MTQqEMAxA4atI1kZMpf5dZZiFtonGhUoLMkW8+
 xSX3+K9GyIH5QhjcUPgS6MeewaVBbh12hdG9dlgatMS1QNuszco7hBBi2QxoWv6bjY0tV4ayN0
 ZWPT3Pj9gK7JVgu/z/AG4GjEnawAAAA==
To: stable@vger.kernel.org
Cc: stable@kernel.org, Yu Junzhe <junzheyu1@gmail.com>, 
 Daejun Park <daejun7.park@samsung.com>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794192922; l=3814;
 i=daejun7.park@samsung.com; s=20261006; h=from:subject:message-id;
 bh=aNMRLzNGeQ2Hr9k5cA1DrM/EJdykIjHPjOOgkVLRuQE=;
 b=M9ntVClVhk+1VHfYFUJ6+B+mKTe1se5Z0ZbC9u+ZeToT8a+ySuFKyzpm/LJ2JbXJwyxA0rhnl
 ifP5/usBecfAiwE44dNlTGSpQnzVCNPFH63E29nqjsQhmVzzXbn2Vjt
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

[ Context: in 5.15.y, jbd2_fc_get_buf() still advances j_fc_off inside
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
Tested on 5.15.225 with KASAN and slub_debug=P, using the reproducer
from the upstream commit. Without the patch the second fsync hits a
KASAN wild-memory-access and a GPF in jbd2_fc_release_bufs(). With
the patch all six fsyncs complete cleanly.
---
 fs/jbd2/journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 96fc25907c..449b4a1286 100644
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
base-commit: 29c6cdaac04a6989a7ed4ae4275ce4244e617f58
change-id: 20261109-jbd2-fcoff-5-15-y-c387b21a6df3

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>


