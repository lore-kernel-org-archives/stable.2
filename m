Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1EE35C183
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 23:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713321; cv=none; b=ulIvkgswUNXa0j5vM+rFawj+iyobKRF0WGnf7aPPfDWc08DyZaE0+R3w6K6skdUoZnPlVGSdsdjlot5AtVkvQEYQHK0d+oWz5r+lhsFt2jRVjGgwApMSci4zslivQOJbegQ5/D9WuFs7o0n9+yRvlNd0UKzDmDvfEVzZ5wD1yAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713321; c=relaxed/simple;
	bh=H1lVJxUhCPfGvC+UgDjNS363K4vk26nMs63+FyWoKGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tg1nXO+N8aKWdyIk0f4UUK019E/KU/1xyzCS1YvPgGALDqTSfrVuBEquQaA78sm25RF0Ex98snqj2df/W1DictJ3yfag6wgQ3fFCcvKhrvH2Yhc9LxsvBP39PD/VfCi/kBB6L0kZXtt/H1vZIp8CeIYDRBxCPH/0s/XFkdUnsKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKVIZi4+; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKVIZi4+"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c0ecfaee7so16331911cf.0
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 16:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713319; x=1786318119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WtWsszqVORiGbzEMc9bRW/MM4TSHLERgRdJFuPi15b0=;
        b=kKVIZi4+M3TllcaS1qmc9g4A3LGTI/xfky+DSw8dowpWrrON6MANHTirI/KM98XC5W
         QYgQC3+neni0VXmvwjwPrOCoqImsQLapAMcUjvtzxM8e7sI1rEL0mgPaMjLZ/cWFU30x
         eKFgPz7LJ6OIHmvkCm5Dpfo12jJeBP7Qu50LHPIvuLGQbZzXdhDZad2jNjVIy560yfpO
         U6T5uQj6UFZRLXLjU96Tl0xgczjuH84aXsOwSpRNklepMcIZpeVNpa9pxNeszqaWSCCa
         vWfApC+qHN6LAoomCA5cznj8pAfF8WCYwfCYwZ047Wv8jLkkJzb/FJ1jRVz+FCAZQTN7
         8T2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713319; x=1786318119;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WtWsszqVORiGbzEMc9bRW/MM4TSHLERgRdJFuPi15b0=;
        b=fCy15H8lgTe8igEC466WrnvYqi9AWXXbdAvFZmWgaH0tsLI6ZwDEofdV6FvAsaK7M9
         oOfCb/MxSk3Xir/Bh0W81InzSEdDDS9eXQx1j5tz/FZ0GiuewqHHps7EUEMHa5PBradP
         xTW4tvNWbUs0vJDKigYMvP3p12YICgn7xCjRCH6250NoWIFSHgG2e3HnwXWES9KKRpGv
         gDC5HKwU7CLN7lxFJIxLUQjkhcJb08jyY7CpIy8xpT/4HPzMtWP7OT2EO2Gz5Qk+iCBi
         TNh23Q5HKK/tZ5Es07/3j9+T4UvhCASyhIVREPjV87BuBOkmVyJyXOIbuIAd5ZfceNqp
         ldhw==
X-Forwarded-Encrypted: i=1; AHgh+Rq77t0EZmzohRjQfzeAJyY9qgPAq7isI8RPq4FvzxNfqDEk2vfK632a7Bg6M4ooEOIgG9Cc7C8=@vger.kernel.org
X-Gm-Message-State: AOJu0YymQ1wu6sWhLcvOFkd3fWw+8WhuPq7pcDS+XlgFPovEt4ZOnbp2
	ukKrPGlMk/NLrjUywk6j8t/gusJOUz6vVOelM44O1KcVM7xhgZx8MQ/s
X-Gm-Gg: AR+sD12/l+ZTcKmy4Umg2eLcc+mJeZW7Hd5rUO19y/9RsiJaxfMSNHx3Zj41wMlEY4V
	sYpLy0JjkWq/L+VOJ272dZkZypuu6DZZUY2fokMUEs9O/cNExTF20OTjt6BFK975wDP3CsET42H
	zjoGCo/t4hQzhsqiZSY5KwoMQNe0U7qIoN6vqbGmJ+gk2z+M7hduuYxiu6ELob/yxzxbHrrkupv
	ETf046WcxJ2sA1j65ORfegHdULNQoLDR2hLdNMP4v5zry5t2q29sdjcsgIF2cE2rbTjWAAwetfQ
	SOZFX9hsBCwTxFP7nX/3AxPr3MxDWv49aVEWexhywyXWtt/5/ik3RFH9FMvT5j7TUUNZcWTitwy
	G+Glmj3ubU08mYR5wh4iP2vZECDToeFwZub09vbtckC1+pQUiM6KPGhAA69uL9zmpymyTY6hWGX
	CrzZce4jetgHmKQ0F/6Htj65AMEW8byUpO1Z09bel75BBINFjtk6kE6EP4EaXnNaw3NXrPAuYJT
	0vcztLmUdw9YntdOSVG3NKNxzUX
X-Received: by 2002:ac8:690e:0:b0:51b:fc67:c73c with SMTP id d75a77b69052e-52b566dbe08mr183487601cf.16.1785713319079;
        Sun, 02 Aug 2026 16:28:39 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4eb6a862sm50621961cf.16.2026.08.02.16.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:28:38 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: linux-btrfs@vger.kernel.org
Cc: clm@fb.com,
	dsterba@suse.com,
	naohiro.aota@wdc.com,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] btrfs: zoned: fix use-after-free in btrfs_reset_unused_block_groups()
Date: Sun,  2 Aug 2026 19:28:15 -0400
Message-ID: <20260802232815.3180433-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btrfs_mark_bg_unused() takes a block group reference when adding it to
unused_bgs. btrfs_reset_unused_block_groups() removes a selected block
group from the list and immediately drops that reference before accessing
bg->physical_map and updating the block group.

A concurrent unused block group deletion can then drop the remaining
references and free both bg and its physical_map, resulting in a
use-after-free.

Keep the unused_bgs reference as a local processing reference after
removing the block group from the list, and drop it only after the zone
reset and block group update have finished. Also release it on the error
and read-only paths.

Fixes: 453a73c3069a ("btrfs: zoned: reclaim unused zone by zone resetting")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 fs/btrfs/zoned.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index a016cb471beb..e30b6a61c781 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -3158,7 +3158,6 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 		}
 
 		list_del_init(&bg->bg_list);
-		btrfs_put_block_group(bg);
 		spin_unlock(&fs_info->unused_bgs_lock);
 
 		/*
@@ -3182,6 +3181,7 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 
 			if (ret) {
 				up_read(&fs_info->dev_replace.rwsem);
+				btrfs_put_block_group(bg);
 				return ret;
 			}
 		}
@@ -3193,6 +3193,7 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 		if (bg->ro) {
 			spin_unlock(&bg->lock);
 			spin_unlock(&space_info->lock);
+			btrfs_put_block_group(bg);
 			continue;
 		}
 
@@ -3221,6 +3222,7 @@ int btrfs_reset_unused_block_groups(struct btrfs_space_info *space_info, u64 num
 		spin_unlock(&bg->lock);
 		btrfs_return_free_space(space_info, reclaimed);
 		spin_unlock(&space_info->lock);
+		btrfs_put_block_group(bg);
 
 		if (num_bytes <= reclaimed)
 			break;
-- 
2.43.0

