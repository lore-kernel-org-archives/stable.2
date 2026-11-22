Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795342804;
	b=WjPmFQPwZR4UcdlMgZP6ahGxwy6is5ewcXMi60PeIwEIsowY/PbhJyiKX2cwsE4cqL8C
	 CLmWgBqFV1NrNAnqngf/M4CTOfclUR+DvkRigk2ranVDNTLy9QCpxJHntt5OGAQr6217/
	 fHhiJUe7xNf6m64TP7c6a0aibbKQ6tN3zVNnPCHodHUf2of6nyqoXRC+lNKvEvYybAkLF
	 2ElQJGALnIc83KXNOkTsXB2c2y6xF6UZScEXacT9ZRkgBl/jLGCLHOzbnw0E6OAkiW0ZM
	 b4sbcd1u8mRT/p/bvY1MI/StlOSg1d9GqrNXsfWLGcS9b8pliUIBWVULWgMPyDKBsdw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795342804;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=91gqtW4A9hjSh5iScq2FZO46j4FBUtpr76vY0eFs1hM=;
	b=TloayYlB7B/gTAc4Avzi7DBnYInc404DcC7FZ01+eUxjYaNuwHf8yQAiT011In75BpGy
	 B0rxQzz+dnM5u1hBhhPzzqEheYuV06E0cJDXPjShk9/gqC2GN+SCKvT5jdX2wRU65UIkY
	 850tzore9IIHWMck7+H30IJowpxQ49DsfkTztdv+1RXkjt2FhFdb7t32RxRlMARUr+8a8
	 h81paG/8joZBYD8Z/Sk+Oqh8VR4urTGnjU45QlN1cdsUWI/T1aNGR50tvwtSZnbjc+BbS
	 +Xt7PL4LI+yE+DdMQfkStkOoTbjn/hIHv1+KjVMX0VgR2kzRxNmmZCk9F8Iomjk1dRA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRn+WBiQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C76606A320;
	Sun, 22 Nov 2026 10:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mRn+WBiQ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795342803;
	b=WQcdzKeIk5/68DvQlToAuO/roer+sl2zMWAAfGe1Ejgaf2sKbcNG42lxdQjfjX54909K
	 D5Z+mkTCqlf6zuS6WDyGvgITrPm8N6FgWbJSmTFznt7aEIiOEpInoJ7HE99deBc2sxrMI
	 fIo7+1B0iOJ8CgCYTbhr61WaBTUQCcBUwm1IOtT2957E9AxMe6vIQw5ZxCXXsuUNnZRoS
	 3pTI6pH4bYkMWeCRxBOm+Rg2VhAP6HvTVf5dbw1OF0vBI8reFa/kcV8kh2ljghkG3hCrk
	 XV+Y9wdPkULJF91880+mgcLFA9nr+qPdaeEHS0SU0OQxqwEEa9c7BxJBuhsMmKWj6ig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795342803;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=91gqtW4A9hjSh5iScq2FZO46j4FBUtpr76vY0eFs1hM=;
	b=EbYtYQjlvmI8xDhZH2JI8wEcip7J0t6+cy8UJHWm/sAXvIehNW+wgdBxTpBOk0YBwN0A
	 OdSs7DtaT9WWqFwZtYcdeu9SLfFVCV4fj8L4cTB9TiFResXHaUfBJMjkhATZ1iP4Rf+Qf
	 MMUMA9qDRg3+IpQWYBLl/qpPVX9iCqWY6o6qacK8dMWr96ND2D/sw9/AbboBPFCRpxZfq
	 92WtrpyQ3LhowD8Zl3ZoTg033lItTobTQBk2SmY2VB+iYCrzBQi6qsbAJXNhAV8W+7HmY
	 EtERaIjKz5ZZVWS41TwaPjyUN4ADyqScFe5NUm34xLjdKfqfHiViikpvmPTVidZQ3CA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 297471F000C6;
	Sun, 22 Nov 2026 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795342803;
	bh=91gqtW4A9hjSh5iScq2FZO46j4FBUtpr76vY0eFs1hM=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=mRn+WBiQa31nxxO9VffIBelOWrPuMHwuIryYFMWZLQxS3CeLuVCyDAa5yYuA0qiw8
	 zOtTr9wsbkf8N1paU+HlVCfI3/LHNyG/qX/56es3kgpJ9mAzHfgYwhDiXsyFyKfbgs
	 OZFJlPhbTowGkUhF0D1pfDs34OlKaeMx8Ueduz00nlTEQMl+BQ4T47JVadE52Li0uF
	 uF7JugDhDzWyrb5K6qYrtlMu0CmUPIDJyMZrvNqLnp/9q49lDb6c1AMx4ToQ8JoFzU
	 O2TepBmuWLavw2Q9Uxo8IQrzymiGkdiPMNOpTEqsvT61hBDcLHJJ01g6HqNJzQ58vG
	 RfBoxj1G/iyLA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7C8994BFF3;
	Sun, 22 Nov 2026 10:20:02 +0000 (UTC)
From: =?utf-8?q?Omar_Yi=C4=9Fitcan_Meng=C3=BC_via_B4_Relay?= <devnull+menguomary.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 13:20:02 +0300
Subject: [PATCH] jfs: fix integer overflow in dbDiscardAG() and validate
 dn_agfree
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
Message-Id: <20261122-jfs-fix-dbdiscardag-overflow-v1-1-c3b3230242dc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yXMwQrCMAwA0F8pOS9gg1Ttr4iHrk1mhqzSzDkY+
 3dRj+/yNjBuygbRbdB4UdM6QXS+c5DvaRoYtUB0QAcK3hPhKIaiK5a+qOXUShqwLtzkUd94PFO
 Q4BNd5ASdg2dj0fXXX29/26sfOc/fE/b9A5fMHyCAAAAA
X-Change-ID: 20261122-jfs-fix-dbdiscardag-overflow-4826f61a29f7
To: Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, 
 Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+29eda1328acf6cf2dbfb@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, 
 =?utf-8?q?Omar_Yi=C4=9Fitcan_Meng=C3=BC?= <menguomary@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795342801; l=2536;
 i=menguomary@gmail.com; s=20261121; h=from:subject:message-id;
 bh=hMHH4yTPBHZUdEF0MQBMA04GLD3DPYMcNION+cySEUY=;
 b=kFsqLNKFTA0bRSTpgK1ZizBPkY3/f3o5uFzQfSnERdVJVQeHu8RAQUcJumcVCIJDH3fcg7nxg
 EkbDzhuT90/B3FTj/M3cuwHSXd3FU+dqk0eFGzUfN9R6zORfLYpM7Um
X-Developer-Key: i=menguomary@gmail.com; a=ed25519;
 pk=dgRbAFBMBZdJfvBTw9RBcE3WxXn6Yt7GOZFPRpQqpkY=
X-Endpoint-Received: by B4 Relay for menguomary@gmail.com/20261121 with
 auth_id=1595
X-Original-From: =?utf-8?q?Omar_Yi=C4=9Fitcan_Meng=C3=BC?= <menguomary@gmail.com>
Reply-To: menguomary@gmail.com
Content-Transfer-Encoding: 8bit

From: Omar Yiğitcan Mengü <menguomary@gmail.com>

If a corrupted JFS image has a negative per-AG free block count such as
dn_agfree[agno] == -1, dbMount() currently accepts it without validation
and stores -1 in bmp->db_agfree[agno].

When FITRIM later calls dbDiscardAG() with minlen == 1, the signed s64
value nblocks = -1 is implicitly converted to u64 max_ranges = U64_MAX.
After do_div(max_ranges, minlen), max_ranges + 1 overflows u64 to 0,
causing range_cnt to be 0 and kmalloc_objs(struct range2trim, 0, ...)
to return ZERO_SIZE_PTR (0x10). Since totrim != NULL and the while loop
(nblocks >= minlen) is skipped, tt->nblocks = 0 dereferences 0x18 and
triggers a general protection fault.

Fix this in two places:
1. Validate bmp->db_agfree[i] >= 0 in dbMount() to reject corrupted
   on-disk metadata at mount time with -EINVAL.
2. Return early in dbDiscardAG() when nblocks < minlen, preventing any
   negative nblocks (for example from runtime corruption) from
   overflowing max_ranges + 1 and avoiding an unnecessary allocation
   when an AG has fewer than minlen free blocks.

Reported-by: syzbot+29eda1328acf6cf2dbfb@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=29eda1328acf6cf2dbfb
Fixes: b40c2e665cd5 ("fs/jfs: TRIM support for JFS Filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Yiğitcan Mengü <menguomary@gmail.com>
---
 fs/jfs/jfs_dmap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index a841cf21d..94542ed93 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -293,8 +293,13 @@ int dbMount(struct inode *ipbmap)
 		goto err_release_metapage;
 	}
 
-	for (i = 0; i < MAXAG; i++)
+	for (i = 0; i < MAXAG; i++) {
 		bmp->db_agfree[i] = le64_to_cpu(dbmp_le->dn_agfree[i]);
+		if (bmp->db_agfree[i] < 0) {
+			err = -EINVAL;
+			goto err_release_metapage;
+		}
+	}
 	bmp->db_agsize = le64_to_cpu(dbmp_le->dn_agsize);
 	bmp->db_maxfreebud = dbmp_le->dn_maxfreebud;
 
@@ -1677,6 +1682,10 @@ s64 dbDiscardAG(struct inode *ip, int agno, s64 minlen)
 	IWRITE_LOCK(ipbmap, RDWRLOCK_DMAP);
 
 	nblocks = bmp->db_agfree[agno];
+	if (nblocks < minlen) {
+		IWRITE_UNLOCK(ipbmap);
+		return 0;
+	}
 	max_ranges = nblocks;
 	do_div(max_ranges, minlen);
 	range_cnt = min_t(u64, max_ranges + 1, 32 * 1024);

---
base-commit: 4843f6873f7c4835e62f2c73ba0fd538e57a2f22
change-id: 20261122-jfs-fix-dbdiscardag-overflow-4826f61a29f7

Best regards,
--  
Omar Yiğitcan Mengü <menguomary@gmail.com>


