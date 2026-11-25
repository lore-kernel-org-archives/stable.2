Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592403;
	b=uN7ExXeb1hw7PVGOP9+/uJXOLMSiRiRYhRJCnFC5vqiQ78WcrqmgPXz3KjUVn3xcR+n+
	 /NhHGLyq9NGxuDD5znsRGHCvP9eGurbJJ9sjp72Dfoz1FMcJO/PYFfP/9bk8tRal4jUy0
	 zB7+jQJ1ZECA9R8gNNG5vSU6EfFXOrbmcV+CDHMNVWwhoNwUSDCP6feOMSdFimZiDxvZ1
	 3U/6WqYlwCmEaiV8fGZkP3ucDwEz+36xlYZzqbwLCQJ8J05VKEv6v5MwA6f/WvyC0cdXS
	 L7oftqWQCW6SA1XSTu4vbLVuZIYmOwJdlP8gRQIbmHrt+ZeJE9P+9+Or5TKspEC9emA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592403;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=;
	b=WN4whdTMNZSBqrkQztxHVXweDXFaAqrkFm7ZyIE0MH+JmTGEW1IwhELyZ3NhsPnJIN1O
	 K2PiVocuOAF6zZzNH6sMKT2BXLqGmx6UDEZfmAHx9Yw+QJr3A5ndo+qxxAULRanSquQ/R
	 6LFkE7jI7EG19WSjky32nzIyrPfx1b0tggH10i9hKCeza0uBFgYpD2Y1gWQJzKxCmKnt4
	 4TxqE1CGh1/zheAgYbF/fUaUUfagiVRcL5s5sFjNJlAtHPiXlvXngZYhgyuLaLuco+k1W
	 6siuTL3npK+JTFEEdmjKtYfFmRlG3+FjvcGiv5GzG0IobdaiKrsq+MEx409FivUcGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yn8zhuGE;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DF606A329
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 07:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A7DF606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yn8zhuGE
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b40f4d4b5dso2379980a91.1
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 23:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795592402; x=1796197202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=;
        b=yn8zhuGEiYOBs+G0CA5akukskDI+rIipDX81IBJVIiJLqm0RB5JOepNYCAY3KD1Cia
         4fBN0zx0wekfGGSTEW+QKdDKGXtSi9ti/u0TkXEi4BrQwY8Fkm6yqe3oi3rqEMqCO/Rw
         MQIt+Vz3OwRhDUZe52DAd1wuGOxrfr/Wsi2Av70x8mRMNN73LwV8Lc0zesjj1jNWiF4q
         rf4Eiyvx7ygsJNMYRdZmoK1xrBaqSsNrl60JXhPFOwIFkdG31ZJjAYSjkLaz/Ha41HLQ
         E2EQayf7WDcBxoVHWIo2w3VyKfzoosATZcqanM7XcXrYs7mZsM3lirIG40K/X+WiwFEr
         Z3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795592402; x=1796197202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ibF4F7cNLXhO57E2X85h4/Efme6fANRGzvwJmw8UpCU=;
        b=LXugmzGAbnS2vhRT/RvjS4CSa4hkaHU/eWEKR92WXzxxbGzwPOfI4DaVNFeu+zoUPy
         a/f7sta0PzrGRHNDiSEwMKFzi05VpG38xhbb1MhL9Z89ojmQ59F6HlA4bERAm91zgz08
         CcPNVeIsuHqthHJc9nSp0zijWsD51yJ0nN0zH6GciXQjwl/NUag9kHpnHWruDJYpIr9/
         8QW++N6UuzPh6U5cr+QKU/Kug/8VZSKJZXKBui4SEVpfp7cnMAjyXha51+EfJzEF8LKm
         vHONEM5O9Ijp57UlvDVj4fPkk8h67mjRhySrEIdXFF7pYQRdbTv3FjMhpHJE5x966Iop
         uj8A==
X-Forwarded-Encrypted: i=1; AL+hErEm1oP7FxnQsEYb3dV9RHcvXWXHEKsmeZNTHk/Q6J+J5Rh3PXHmjoVJ35WDPi4rwQn2+o357Io=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wtmC/E0d5evu6VzbYRNld56orQgf6wc5zs6iY4tIAyQuqoWZy
	oPIvPnFIsrWyCyi7zBS8z942gKyHpOIVtjAd38YRuqh2aaOT6iVsqQs6
X-Gm-Gg: AZFdTZeFrmb0Zf49SnkXjZ8QgFW6dUxSgmzUdAW6R+lyHtVNqaNgWhJypuQRWf0eg2z
	OaSv1P23oIr3h+QHk+BCbN4h0n1GfLR3FK+OI5ebY3aJNDqfpaXvoCMABOWmU/RPrr2orrPDuz8
	oBNlFSlnhTwKla1A9A1BArTaIoBlcTg3pNwqXRkHu2QGVTA91e2ZE6aJchw/WfiniZ2H67p5Fz8
	Svw9nMBHYNML3A34/FyAhlMaOhQahj3tC/GSNdvDqGa8L9WpR+rmpeaABmYx/Acf0VytDTc2ofS
	iNHYNt9A7XaiLq7iF+arAh1oxV7iP6YBQljR25xWmYaejet0uQEkP/H3cEAcj2jxpaLadFKanyL
	d9zOImH78z/BtFkgMLPDJIzb3zlXB8nj0QoLrbGbn9XU1p3EFRLwQqOOePIIyL4GCEr3y0lFUzi
	qesk7TRjRBu3DiNEyCn8GdmYMPr6+DWWnNnzNfc4LPNeHs9wSKol2gF2p9GOJyTg83FE9yTAMeV
	N2hWqudbv4H1cZtvSs4d4dgrpLolfnbQ1ow335ie0kg+UZr8bEa/cjcWwfu6hTkOYlcEW6x63Al
	nJYJWXBjfttswCmLq0KfVMSJEY7UBkukM911/AC1SmHKYQ==
X-Received: by 2002:a17:90b:48d0:b0:3a7:b260:9ced with SMTP id 98e67ed59e1d1-3b41c96cef8mr16857502a91.58.1795592402400;
        Tue, 24 Nov 2026 23:40:02 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41abb2076sm26773960a91.2.2026.11.24.23.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 23:40:01 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: yangguikun19@qq.com,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: don't BUG_ON an inconsistent node ino in roll-forward recovery
Date: Wed, 25 Nov 2026 15:39:56 +0800
Message-ID: <20261125073956.2927907-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhan Xusheng <zhanxusheng@xiaomi.com>

do_recover_data() asserts that the ino in the NAT entry of the node it
recovers into matches the ino in the footer of the fsynced node block.
Both are read from disk and nothing checks one against the other
before, so mounting an image with a wrong ino in that NAT entry hits
the f2fs_bug_on(): a kernel BUG with CONFIG_F2FS_CHECK_FS, and without
it a warning, after which the NAT ino is written into the footer of the
recovered node.

To reproduce, create a file, sync, write and fsync it, crash, and change
the ino of the file's entry in the NAT journal of the checkpoint pack.
The next mount gives:

  kernel BUG at fs/f2fs/recovery.c:698!

Fail the recovery with -EFSCORRUPTED instead, as the ofs_of_node check
right after it does.

Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_5CEF90115E2715D386A8349FCA28D7D4D607@qq.com/
Cc: stable@vger.kernel.org
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
Tested on f2fs/dev b61a029304bb with CONFIG_F2FS_CHECK_FS and KASAN.
With the ino of the victim's NAT journal entry changed from 4 to 5:

  unfixed  kernel BUG at fs/f2fs/recovery.c:698
  fixed    "Inconsistent ino_of_node, nid:4, ino:5, 4", recovery fails
           with -EFSCORRUPTED, the mount is retried without
           roll-forward and succeeds, and fsck.f2fs reports the same
           mismatch for nid 4

The unmodified image recovers the same way with and without the patch.

 fs/f2fs/recovery.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 54b5246609de..c92da18f553f 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -695,7 +695,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 	if (err)
 		goto err;
 
-	f2fs_bug_on(sbi, ni.ino != ino_of_node(sbi, entry));
+	if (ni.ino != ino_of_node(sbi, entry)) {
+		f2fs_warn(sbi, "Inconsistent ino_of_node, nid:%u, ino:%u, %u",
+			  dn.nid, ni.ino, ino_of_node(sbi, entry));
+		err = -EFSCORRUPTED;
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+		fserror_report_file_metadata(dn.inode, err, GFP_NOFS);
+		goto err;
+	}
 
 	if (ofs_of_node(sbi, dn.node_entry) != ofs_of_node(sbi, entry)) {
 		f2fs_warn(sbi, "Inconsistent ofs_of_node, ino:%llu, ofs:%u, %u",
-- 
2.43.0

