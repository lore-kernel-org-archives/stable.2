Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4492F3C0E
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 06:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790489148; cv=none; b=gbS8jN57P3/PA2raBEapsi8p78OTgt8Ns49f1XhqnWzAM1qghHavOe1KXxfHHQ/DgBiAlof39KjX3EUNUW5qMZe8X8U410AgTz8caVMHw2faglF5JKaXDWrJStqR4ES0p2/zLLzYjvAx9QZ9S4tmgA4LaZO6SYUa3QBbSAQJn/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790489148; c=relaxed/simple;
	bh=gg1fTloAjx85KyDcaj3H4GjUAHYKAPVTPeTCe6G8rzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDaYYBQjluZx3m+a9PxDX7LmeuN5ee8j/EHCT7HD0U8muCCBlR7/euoXpRSnkc5xlbb5BX6OrVwY5CBbTSHP/nLDbjwdLyn+d6DpKL6EY2xrbWOKKYYJFl4SxNtk0XsPzKiuTSyym4/fWwQFkXZxPC8LftJyIJ8f+veci/jXqcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kVHhFSVv; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVHhFSVv"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1564622a91.1
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 23:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790489147; x=1791093947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XzS8pDscla2FyBguyotkXaPJuuUXNofAIDN+EtvzBco=;
        b=kVHhFSVv6wYeAf6LQqvBAuwH5nglVKb6QaFHxGhLHHP8e92X5oZkXE45zJdEFAebuN
         BriubbE76Kwo6nRcQXw6l7f9ZzbVjyvpqADdf0oFPEZhdoNdfCehPT2oL9N11hrBp0jd
         QCZJNr641/b7DD5yZtiguTT5emWc2hoCQVxuLc9zFhfadRD5LoxTwUh8/Oab5yPDFWU3
         /taijnHNGm8gkmDAxHOuNARcAYnl0WJvWc6v7AulFD9er1tnxGOdMmPZoglJXNkziXv6
         AN4U8GQgeHQewSPeR7VyFrqBJ+h/XL+mfWL1mO08wbWUdELkomgXvsueIuyVYKUQh0Zr
         TgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790489147; x=1791093947;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XzS8pDscla2FyBguyotkXaPJuuUXNofAIDN+EtvzBco=;
        b=1dYF/le4/SPCbfBmDHY+A726VTvW1MrUqnAqCas0YEWJj4Gp86o0t+vPZU+ct5ndaR
         5uT38vvilo8T+mSlBh2Mzrz9W3DkwQNvhLn3XZFBhi+9sPK0dfXlUAXW6MShlsWDBM6S
         iOsHYSfytyTcxRN3GdChBgam5H1HoQHn4Q7koQuQs02IZGEQfuxxgEG6aCx0l1ArLNBn
         rUvHf5XOGsWdkykxaa8XdQtwxgIAID0pykVAxNWQmygb3p8OIrs1EVlP9e4DHyTs+8F0
         MqtAbDrrQrBh2I8hB0CMIj46noaWvKhJOCAOwVrNBgRTnEBKkSKKUqOpKtMF4xwuloFL
         WSog==
X-Forwarded-Encrypted: i=1; AKwUvBx06xkxhz2XrOgNzqf0ILu4+F/pw6ZVqaX5SzPGdq0cskTT8y1Y30uAnA003Q06UisyuN4SwuI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdjqTgdfHR3WeX+S10RtXhnI5ecCx9K3C6aYXoGbLXb0uGTCES
	kXlkgEly43o1k7gjlGYabPio7powjGKkFeAi+THyFww/d0/TiO5d3zSg
X-Gm-Gg: AYBFou0HIZ5vEoam/a7hZVhC+oiIwRRK3baUHLuJUOimcDDCm/v2mLmIPa4u+JnMVXi
	yS6iUdBnypjQRdzkQIfTT1F7TQnCo2hd3qePjhiuqE6Um3NrmuDNecHydBv/m1px4wpTG4UHEqr
	Ay9BZLs6VyFYhzYnvwiASVyk2TFgEuQ0csCUUFtDjggRYk77cVq6CmBWPC7Qruzin15zymPbl5u
	VMVoJ0z/x4O+x8pQdg7dTSjTSQFRfm0T75zWaHtGWvLJ3kjbDeSjgrNHUmNsPyB/Jv6tA8xJzJh
	FvBY9sEmvqFHnN8lTqut4/ScU3ibPa0gXJB/+hZ2qHsTF3qXg8K+C9ml4X0CEGZRIuBN8ZRx4De
	IEdmaiP29saXvahfXs/xjH8R70t1IFwXnmfAB93bNmKEGbw5fq+tmYAr2OnfdrMk5ryGc8+cpKo
	Rot+285u5cnmDm45bqRoNt7yo/xXaEvHvl1OfljNzPgcdSGOjrNEKzwbgdhw/iH77ocpD1p8pOv
	sY5lwrTQe5+UpXL
X-Received: by 2002:a17:90a:ce:b0:3a0:4146:2955 with SMTP id 98e67ed59e1d1-3a0bb6596f3mr3436071a91.61.1790489146838;
        Sat, 26 Sep 2026 23:05:46 -0700 (PDT)
Received: from thangnn-ASUS.. ([2405:4802:1d4a:e90:3a0c:2ea9:4ab7:bd1b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0976ca5f9sm20181545a91.14.2026.09.26.23.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 23:05:46 -0700 (PDT)
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Subject: [PATCH] squashfs: fix leaked page locks when page actor allocation fails
Date: Sun, 27 Sep 2026 13:05:41 +0700
Message-ID: <20260927060541.45780-1-ngocthang2710.1999@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Phillip,

syzbot reports a hang in evict() during umount of a squashfs mount
(INFO: task hung in evict (2)):

  https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96

Root cause: squashfs_readpage_block() grabs and locks the sibling pages
of the block with grab_cache_page_nowait(), and only afterwards allocates
the page actor.  If squashfs_page_actor_init_special() fails, the code
does "goto out", which only kfree()s the page array. The locked, referenced
sibling pages are never unlocked or put. A later truncate_inode_pages_range()
from evict() blocks on the leaked folio lock forever.

The ordering was introduced by f268eedddf35 ("squashfs: extend "page actor"
to handle missing pages"); before it the actor was allocated first.

Fix: use "goto mark_errored", which already unlocks and puts every page
except the target page (owned by the caller, which unlocks it via
folio_end_read()). res is still -ENOMEM at that point.

Testing: QEMU (KVM, KASAN, lockdep, IMA tcb policy) running the syzbot C
reproducer, with fail-nth swept over 1..400 in openat().  The failslab
hit lands in squashfs_page_actor_init_special() from
squashfs_readpage_block() via ima_calc_file_hash().
  - before: hung task in evict()/truncate_inode_pages_range() after ~12s,
    same trace as the syzbot report
  - after: 170s of runs, 174 injected failures at that site, no hang

The patch is below / attached.

----- patch -----
From f686b39f997dc20222f455c5ac6421f6a5d6c8d8 Mon Sep 17 00:00:00 2001
From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Date: Sun, 27 Sep 2026 12:40:12 +0700
Subject: [PATCH] squashfs: fix leaked page locks when page actor allocation
 fails

squashfs_readpage_block() grabs and locks the sibling pages of the
target block before it allocates the page actor.  If that allocation
fails it jumps to "out", which only frees the page array, so the locked
pages are never unlocked or released.

A later truncate_inode_pages_range() on the inode, e.g. from evict() at
umount, then waits forever on the leaked folio lock and the task hangs.

Go through mark_errored instead, which unlocks and puts every page
except the target, which the caller handles.

Fixes: f268eedddf35 ("squashfs: extend "page actor" to handle missing pages")
Reported-by: syzbot+65b1e2d8f2d618a93e96@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=65b1e2d8f2d618a93e96
Cc: stable@vger.kernel.org
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
---
 fs/squashfs/file_direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 2c3e809d6891..177357443543 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -70,7 +70,7 @@ int squashfs_readpage_block(struct folio *folio, u64 block, int bsize,
 	actor = squashfs_page_actor_init_special(msblk, page, pages, expected,
 						start_index << PAGE_SHIFT);
 	if (actor == NULL)
-		goto out;
+		goto mark_errored;
 
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
-- 
2.43.0

