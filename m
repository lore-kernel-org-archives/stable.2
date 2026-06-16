Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6C932D0FC
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618209; cv=none; b=pwR8aN595KyfyDXkMpBIJfxFFmpxMCzK4lbTYeoq49u3rkSqCOPKli7OFiAV8AYUidyn9f1P48ifxPez/zKpoWbrP2DXWCAv3RNSrcbQjuGL50E+SfvP6qxiSIW3Le1RktdPGhHfbdUXlvX71BUWag4n48wgFpe79p4X88pJ+cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618209; c=relaxed/simple;
	bh=pzkCjeIwaAWRaa3ER7qo2m/enxolHd2bgsECYrxA5fE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YoucBZNc5lZR6hRC1axTqi2/UULwvxyoWT/NyQ/kY/ZSBDBlB1oqLcqSXpKyNFF1XAF8IwTHUTYVikYng4t7fJQ2wVGNGKNTPB+NhhjtnsaT1z/UpBH/VQ0pP8BEhOIITr3JOpTyw0qLzBIr2yLhcJhtD30LEWFPH27etPI57/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkz6Ovai; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkz6Ovai"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3078e0dcd67so4813226eec.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 06:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781618207; x=1782223007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=;
        b=fkz6OvaiXxKQ2XVv3ytfuGzpMKDjOMd25yhWzZUpaVz+o7nQZSFTzV8nYyduZ147Xg
         ++oDPTgUTxYqoIhnCafmjAEW2S0fs7TUr70FS4tpAYudFoK9Snqy2qLIalaK/4NoR4HJ
         oDb8nQ9hv94BbWoU6Knyt8R1xs9crdoVfHSCmxsO620O9DOIKaSbk4l7ZOV8eKX6ocDb
         FHOucuTWThYF4K7mkxc0kAOTiDYnyh5SwZN7gfwrHb7H9C9XyfN3j7fxboyYg09zXsr9
         OnjiuK+eH5mU7y/KQoojz5lIi7Zd4aPhaETfoj7ovcovtAgYoKHWqC8/6DKW9ShUA4fp
         6CGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781618207; x=1782223007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/yKpIl7fnTH/Z8cujrZ2kgityIQr3NnutG1Y8WhoW4=;
        b=bcvXAbZ8J0iZp7fEacyILP13zNks8/Pxp10EiHX19fULanmYwUlgNZ7sDohRI3/yei
         seGjz8fAhNAHUrWDEikFhmXzkTaPlDa42zoKQhLQEgpmU5uFKwIVepbczdwg/xwz4nRC
         vfjFeuzZ2JxJYDMGPnfKzmD3zzGVWhNRpeahM+mvwMMh1RdOg/smC125lVrh+aqrCcz4
         UgnCCUcnGmWMP8cbWEXoF5TNnRd0aER9iJg6ygHLAGrS+NnyVvx9+ANPZ8+Wz9zFkZjX
         nV0v6kdtg9paUeA8Gl8gFWeSk1e557/aj5wZnEQwYMoLfFEVDhBiyIX7c4PcKlx+AwgS
         Af+Q==
X-Forwarded-Encrypted: i=1; AFNElJ97A/bXLYkO1onjjqn/U2WY8+pTQiiRKcMjU2L7dr24lWKR9w+ZBCActMMlYik6d8bGDHDsaaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWoWmJEdlnE9RyZj6vUdjwZ47IYNpxrB/P0Y9mqBmsKUbLO+Lx
	+vnS470T7WGsO8Ys3SX97mUxBqBg+t4jkKK/Hp6/8Sn/3wH9C5NwPURr
X-Gm-Gg: Acq92OHQ62zf5ElKwzC6gEnjbU6zgHUaRQgqGpRFswdpE79Qbc55LYEn/Nn04MEVCC9
	CUhB6Ijq0VXLe8rVwsSaP94gAoxhW+jHZyMPlNMdTT3ttMLihObZd0oToBtPI4lTmh2AJIozNjs
	moqrEg9WillY8AXb1cQigrpl4kCMV11te2SNqDWrjCnawjzQ4xaP43O4omwpnRGEOR4rkkAQOEg
	xmx84IumegnV66gNYEjma8PTv19aZVgMLZk3DqJ6+ThoM5x3936cjWtJiMVJqiecy6nbDSYKZ0S
	ZVAMv/XAl1b/3N5BDHPxoHFZzv4BcIJmxJ9bI/h2MWrrBB7tfbE5Jv1gzDk/GBXgAfs3d+CQfMY
	zTmf6v6DYuypZvMQ00RqK4kd8cLRcNI0ZfSjfYWggzP/xtdsqhjIqk3RW45pNBmSAxCDYkDhw4k
	Xyx8KZ8PN/Pi5P3BcqYmiRL7bca68pvWPePpxYuAGimv2mGQDfYWcWzVmul6c=
X-Received: by 2002:a05:693c:3945:b0:307:91f5:93f7 with SMTP id 5a478bee46e88-3092b94dc86mr7904991eec.0.1781618207060;
        Tue, 16 Jun 2026 06:56:47 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30bc1e2bd13sm626947eec.2.2026.06.16.06.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:56:46 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Cc: yangyongpeng@xiaomi.com,
	geoo115@gmail.com,
	stable@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	qiwenjie@xiaomi.com,
	qwjhust@gmail.com
Subject: [PATCH v5] f2fs: use post-decrement count for cp_wait wakeup
Date: Tue, 16 Jun 2026 21:56:37 +0800
Message-ID: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

f2fs_write_end_io() decrements the writeback page counter and then
reads it again with get_pages() to decide whether the last
F2FS_WB_CP_DATA completion should wake cp_wait.

Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
decision is made from the value produced by the decrement itself. Keep
the existing dec_page_count() path for other writeback counters.

Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/data.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d83a21998ec2..58d23eb74ec2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
 		if (f2fs_in_warm_node_list(folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
-		dec_page_count(sbi, type);
-
 		/*
 		 * we should access sbi before folio_end_writeback() to
 		 * avoid racing w/ kill_f2fs_super()
 		 */
-		if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
-				wq_has_sleeper(&sbi->cp_wait))
-			wake_up(&sbi->cp_wait);
+		if (type == F2FS_WB_CP_DATA) {
+			if (!atomic_dec_return(&sbi->nr_pages[type]) &&
+			    wq_has_sleeper(&sbi->cp_wait))
+				wake_up(&sbi->cp_wait);
+		} else {
+			dec_page_count(sbi, type);
+		}
 
 		folio_clear_f2fs_gcing(folio);
 		folio_end_writeback(folio);

base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
-- 
2.43.0

