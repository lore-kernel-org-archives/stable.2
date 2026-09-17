Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1D148F025
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789634351; cv=none; b=pYkPjbyWI9bE2QBQKaZCaVfTyDgL/SgeaJjUHsnHnVK7io0+1SH1c4B0eQzcQcNjIxuImWuVrNHkdhIBzLPBq52xZB05cnMZL4dzMktyWOn+IiWlfh2wiUdZ5naEGnkvW3KJLeA1svXyG6u9bPjL8el9Mp5VwH/DN6Ci9x3Ybs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789634351; c=relaxed/simple;
	bh=Haa1z/DghnZT1qkXm5SKTSly5CBcdv1q5VCtlQW+b8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vtx6KjUwkzM4oCdBR2lYIYTXNLB/tf6H18RF29Cw56RFpuQ9NZc2nAi0tGpXDW6Gb6X9bNlihJ82Z9yhw9JDG+JwTuXZMUyLt1tuGMo6r3yAJlFf6n3+7Wc/EBPGiFLlXpfAxAaV5M9QZT6XZ6kiR+A8ut8aPIGWCpoGTETMszo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwRqLRT3; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwRqLRT3"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so515704a91.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789634331; x=1790239131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T87rxYlu6jlwQQ8pbt3sOEyP8di5cJFMReAsYyBJE5U=;
        b=RwRqLRT3E/I5+GyUW6iiUaS5UrbEM0+7CLmwl4kIN2NIa1cMKGQUHq0Bd3mQk8PFnh
         W7bj6qi+UfmgbetWwYPFwLUCrxLotWtenhESEvQoBfS6tuaXTQbzDGgAK4ukMVxGwpgh
         3rniXTUhp8rHA7FgCqvH7xjLZRsdERoxxCNW/0AwENaJm522hX2T3Zv936xlBIexs+RW
         MyLlvoki2J5inSvJsWVUUU+lxLkWhHe9SkAz4YSIy+hsCd0sQ8KvWWxeT9SKUXx3LVsl
         FFNXS6mjYbyrgt72IYQ8oNfRHj75nipqBefyMAkm3oT6cIN2Sn2hP5lowyHEg3c/oJnc
         kkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789634331; x=1790239131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=T87rxYlu6jlwQQ8pbt3sOEyP8di5cJFMReAsYyBJE5U=;
        b=LshAJQSRsNDcl5MmbyS363rjk6wAYXWoZfCWxunRDRcXF0LYomeqrTWW4PLkuhA5vn
         UKLYFtvKNwVJIQQTw+zLV1J2MtLRa4VxMgRLxSUKuhfljJ0Sjg4zVw6RGlI9URZAy1yH
         RE46kh2GaQVli8S0eFx57+/e9yA2K7+PmJBYssWSf/RiLmzkKQHCr2IRy7bserQAdL1M
         0MervJDTW0YL3fEANj5OD0EcG9gABKIVly5lO01k7401cluSVs3Nxd25Pr5wfpaAaL+q
         5pDVg5c4y+iTQZmG7nUA6BlX9wJHtJ2FvKFrnFJ/Tq9tWtUluXdjcjrTMZ+ncJEgIS0A
         4xMQ==
X-Forwarded-Encrypted: i=1; AKwUvBxR8P6bmRFirwiFB7q/FzE5FLv38Q5UhD2xGUMFYP6QbOP9bUb8lQYiuQh3uwxm4UoRaGcrkY8=@vger.kernel.org
X-Gm-Message-State: AFuF++kcJGrJ1s3y7Xoiw47rpZCzmJm6pACd4xmA+h4SlzaJsfSGG2az
	mbFYpf8H7/diDP7e16qhLGaHxJ2PTKT1lnFKrV61RK2kJ56iht05ps3T
X-Gm-Gg: AYBFou1FxV8i6kQzJ8fE4FSz1nWOSPeL4CKbPWjSYnFO6/P1ZKf15oyNX+W4TVOxB7d
	0hoO85y7S/wWEHePG4uNL5CuakFgEHjjJKH1+aZLunhXLzvpn4OnyWP3KkJ72gkkY5hacZHFC9y
	Reknf9KFI7rpBCcxTnUp+6D0+Oual0fwj+E0qgFmvUmZnl8QW6mjN7d3d91Ci0NN2MD7bdqCFvr
	+CanP88DkZnahkvXHjaJNtqbAUkLEvWuVSeMwOqmtIwn3pVs55NpgVURCk0kPLmUbbHL8ZPg7P6
	kLav3KmgsVxoFYk5zwoiVFesPxrqIJT9OLjDD5pawwRfLpRIHcNgQhXHtqa+8mar+0Z2TlRbU2k
	KFMLl5PtUKEjMZCPojr3tKjcQCwR53bW3ATDoEiuboU79FA8bT3XlSR/y9qMMN1C6va/afs5rV8
	RrSsPAujuNGNJ1S/5xeEXUmdWRHo0SS5z+v4xKG/2S4XZdwGxv4QP3yl6EhwtStofxG4rSgJ3Ov
	WJ1zT/9QAunHlHFZSB1VA6cs8kj
X-Received: by 2002:a17:90b:2d45:b0:39e:261:4e0d with SMTP id 98e67ed59e1d1-39e1e506786mr15054330a91.25.1789634331347;
        Thu, 17 Sep 2026 01:38:51 -0700 (PDT)
Received: from localhost.localdomain ([183.194.144.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e35e56298sm3871317a91.9.2026.09.17.01.38.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Sep 2026 01:38:50 -0700 (PDT)
From: zjamg <ndaugoing@gmail.com>
To: Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	NeilBrown <neil@brown.name>,
	linux-raid@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zjamg <ndaugoing@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] md: fix bblog_size-driven OOB read in super_1_load() and super_1_sync()
Date: Thu, 17 Sep 2026 16:38:19 +0800
Message-ID: <20260917083820.57091-2-ndaugoing@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260917083820.57091-1-ndaugoing@gmail.com>
References: <20260917083820.57091-1-ndaugoing@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In super_1_load(), when the on-disk feature_map does not have the
MD_FEATURE_BAD_BLOCKS flag set, but sb->bblog_offset is non-zero,
rdev->badblocks.shift is initialized to 0 while completely bypassing
the sectors > (PAGE_SIZE / 512) validation check on sb->bblog_size.

Subsequently, when badblocks are updated, super_1_sync() enables the
MD_FEATURE_BAD_BLOCKS feature flag and assigns bb->size directly from
sb->bblog_size without validating that bb->size fits within the single
allocated rdev->bb_page (which is PAGE_SIZE, or PAGE_SIZE / 512 sectors).

When md_update_sb() later writes metadata via md_write_metadata(), an
unvalidated bb->size (e.g. 0xFFFF) results in a bio whose length exceeds
the backing page, causing out-of-bounds reads into kernel memory during
block I/O and leaking kernel slab/page contents to disk.

Fix this by:
1. Validating sb->bblog_size in the 'else if (sb->bblog_offset != 0)'
   branch of super_1_load(), returning -EINVAL on oversized values.
2. Clamping bb->size in super_1_sync() to PAGE_SIZE / 512 to ensure it
   never exceeds the backing rdev->bb_page capacity.

Fixes: 2699b67223ac ("md: load/store badblock list from v1.x metadata")
Cc: stable@vger.kernel.org
Signed-off-by: zjamg <ndaugoing@gmail.com>
---
 drivers/md/md.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 680b34a63cb3..d2433cf41e65 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1934,8 +1934,11 @@ static int super_1_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor_
 			if (!badblocks_set(&rdev->badblocks, sector, count, 1))
 				return -EINVAL;
 		}
-	} else if (sb->bblog_offset != 0)
+	} else if (sb->bblog_offset != 0) {
+		if (le16_to_cpu(sb->bblog_size) > (PAGE_SIZE / 512))
+			return -EINVAL;
 		rdev->badblocks.shift = 0;
+	}
 
 	if ((le32_to_cpu(sb->feature_map) &
 	    (MD_FEATURE_PPL | MD_FEATURE_MULTIPLE_PPLS))) {
@@ -2313,7 +2316,8 @@ static void super_1_sync(struct mddev *mddev, struct md_rdev *rdev)
 
 			bb->sector = (rdev->sb_start +
 				      (int)le32_to_cpu(sb->bblog_offset));
-			bb->size = le16_to_cpu(sb->bblog_size);
+			bb->size = min_t(sector_t, le16_to_cpu(sb->bblog_size),
+					 PAGE_SIZE / 512);
 		}
 	}
 
-- 
2.53.0

