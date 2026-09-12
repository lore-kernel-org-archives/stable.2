Received: from mail-pz2-f31.google.com (mail-pz2-f31.google.com [74.125.228.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80F306B3B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789220934; cv=none; b=Jj50/iiPuv0G/mzem4zky6pNaFVeaHrv5IwEJU5Lo4XIP5SUtwtJWxTh/PeB4Jpiwlw78uLyFFcwHgof+lmoKRCfZ5IBRLw0hIu6IX6mVsKNIs0pDRvW8WicwAeXWkO588WmII9dvFavxAoYnFZpASFkSk+8t/ooQTzOpGEyet4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789220934; c=relaxed/simple;
	bh=6pVt0PUQ4LIcwar5ugRNpizavgzQxLUwL/Y0pJ784AY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sqWPPmar6Ks5E6PNKt3b9jjBAbZBXk/cJiV87i0i/2Cz7Cj+iQMRnGE89t0lHArZOPdr+aQDLZkuR1DaL+sFXW9nRUW11i1GDlUKgU7wAkn2+ux0FzmCTA8aE01Ql1voJ4p5B+LiW9YyIEokJzl+Zqg1Bot+us9zTjVjCt2/zKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noFLW9/R; arc=none smtp.client-ip=74.125.228.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noFLW9/R"
Received: by mail-pz2-f31.google.com with SMTP id 41be03b00d2f7-cc1ceb47d55so73181a12.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 06:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789220933; x=1789825733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IRE9clLLWxIBFYz3gEl3LiQKErgqN/9gBQjM8vZ0D3o=;
        b=noFLW9/RvD48s1Bzji5giq64hw/CN0vnaB37wiuJrOT3kmOVhLEpldiR2JrG9ga5k7
         wV7JcpDb4uiGR0VP70bAH4SXgjVZ6k/+TISyQxocLUzmbF+Dvfc/08db8ghV4arH+cu3
         9th/uzeE6upQfpyqKFn2ZU8McvEdcnqN2ytI7i4NmYvrpASfZNXZJXnZsNaR8mPYy68K
         M+Bk5SpoJFprIiZQX9ninYR7eI3TeXNc8K53Ye4JovFaRzJ+0dG6kZU4Wz7fbvP5tqIy
         piQkPCBXUL2Toulo8jTcxzSYMupitNr3hrHo9jBMOzeu8zKdF1EkdLc7SuHz7fgVnb61
         UMxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789220933; x=1789825733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRE9clLLWxIBFYz3gEl3LiQKErgqN/9gBQjM8vZ0D3o=;
        b=CgTzyErAAn3LyUQowzAzEnQTRy09tNdVrgMgXHZ12L3I+L5jQlT931O5uwk/P8W7V0
         DBdA0Gy8DQMvjXI3yjtIHHgCTde9ykzIW+Sh3kuD2j5r229DTz4tCLKXUqZjVxUxXqbd
         7XiT5W71TvdXbW0WBnKpG5czuZWuvJIbvKI7Lfz6FMc6bWOj7YV+HoiIsuYPlDsHLwKE
         8Ye/UO+ew444ZzVLeiqiawOrPh3sC8I0N71LGGzy9hH9/pWqKWDvVgE1y8yw0vnFuHMg
         BFnThsqro3M2HQEXtIdxd8uS56DimNy8/Tj1aZ9e/MxS4um1apg8U0d0VMVN4G/9rRDy
         siHg==
X-Gm-Message-State: AFuF++kJFIvWBm8XXtjRTWgheNPAFqJog34VJfmWqDLFIL1ZcMBRTTwv
	yLXfhr9Pk8BRXNsYij0q6a2n6i44zwxJxw3xu1kubPynZvwsCiFmOdbA
X-Gm-Gg: AYBFou2Q4XPx8S4z+tlj1uPj9TnMnCVCeeITtvEpq65aHcwgAz/qJPSMlAeVLgLqMWr
	mdiM62U4yriRF2xE7Qn8OyZnzeR5y0o2m2dbofP0VqJV0eedR0QiXQQ+GPbAq8zcBKM/sSsYXra
	MpgXddDhGQ62kusPA4kx2mOUA2l6/SSREWzkbcUzaC4AcJmzZfjbM0ici1Qg7H21nFkxwL7Tf3y
	ZU3F3ZUJbpmvAwgVRGbh36FkO6dEBfS5J1T7q4cdw54bp8bG/Ee8vu1MqnaHJnhTMtvQv7E7hJ3
	VY/VL3OKKE9aGjGJDmMhUulqzpJaRvkofAYdhuOof1z9puPxC2QfhesVU8vkBsZJM2890PVp4A3
	TpWx3a+W4V6DMuToLBRGPb2Xv4XA8ycz1nlj0UZ+7paGfIhFl7mwXJFN/AlgWx87m9AYzgUaobw
	hVFhE8JWOEaB6Ruy1vE6n41RgNsaCEZMQizYds5Mj3k36k72YJAJXFrHqqoJA8ZDnm
X-Received: by 2002:a17:90a:d410:b0:398:9bd3:d6d2 with SMTP id 98e67ed59e1d1-39d980ac288mr8416579a91.12.1789220932772;
        Sat, 12 Sep 2026 06:48:52 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm11078347a91.0.2026.09.12.06.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 06:48:52 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Paul Mundt <lethal@linux-sh.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] cdrom: gdrom: fix gendisk reference leak
Date: Sat, 12 Sep 2026 21:48:21 +0800
Message-ID: <20260912134821.981705-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

probe_gdrom() allocates a gendisk with blk_mq_alloc_disk(), but
remove_gdrom() only calls del_gendisk() during driver removal.

del_gendisk() unregisters the disk but does not drop the driver's
reference to the gendisk. Without a matching put_disk(), the reference
remains held and the gendisk is leaked.

Call put_disk() during remove_gdrom() to release the reference acquired
during disk allocation.

This issue was found by manual code inspection.

Fixes: 74ee1a7590b78 ("cdrom: Add support for Sega Dreamcast GD-ROM.")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/cdrom/gdrom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 4ba4dd06cbf4..cd8c79e4a5ac 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -841,6 +841,7 @@ static void remove_gdrom(struct platform_device *devptr)
 	if (gdrom_major)
 		unregister_blkdev(gdrom_major, GDROM_DEV_NAME);
 	unregister_cdrom(gd.cd_info);
+	put_disk(gd.disk);
 	kfree(gd.cd_info);
 	kfree(gd.toc);
 }
-- 
2.43.0

