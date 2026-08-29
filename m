Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828EE277CAD
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788023966; cv=none; b=jLXWImMzD6lT6pXeWAzSMyTfkoChCOjBD8VgGHGP85wR7nbAEKd6OUHXw8MF7NFrJ6sGvMZ5JX0oktffR7I/ySnNhcb9iAFcl4hCj27y/tWh1EkawXtfEui4b24xY1yeFfSsd8o1FcjcxasKqcbdhCXAmNw6D9QlfS8f7LCPHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788023966; c=relaxed/simple;
	bh=O+wxVmw71itIPx8p6M3uCMg4PxYrKBzmlO3zU/mCCLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LseB3OGdfL9TMBVssu8P1dMrq+Ll0g0T96ygj4uH7LRQlnAgctt50IZ4LrzBjsCCsK26JLF2h2BzHNSG/QjCITyRhkq8s+XsjQ2RVYhOSAAmCkNvQbyqCJTYwYwWkLzu2Ad15RVHlhkFFOpiTB1y/a7CNGYSi+uTPoGrqHaAc8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaWMha+L; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaWMha+L"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-46f88060e8dso274789f8f.2
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 10:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788023962; x=1788628762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sONVEZiNDD/vWuq0jYfSacz0G46fBZ+XyTkV+lYzYaM=;
        b=BaWMha+LMe6KJjqeN9+LRhT+kFFpw8zM/yXZUNoIN/ln4L5p2VhpV2+VwJVASKyd7D
         EiOWwPFKxCtKPcTTqn0i81BGD8dao8D6PVtwg7zrtgxVBu6+gQ3YJkBZwIUk7Uz58nsA
         uc4gmxZWNMl42Bsqa4yQ2Nu8a9l4T6nPxLs4rhZomvwR3MpZwbT/dUPGcyhAAGbMcOYR
         p01BE2wLuXzr+HWZyS8Ezx1dVZvM+cT/vpdlZZSmfYgxYiHAw2HSYeRfKzhR3zphGcRL
         6TlXH3HF0WwawK7WaG3qVADXQih0QXOrgBYhPJ71xK3kcFGI/rKJKupS/Bz8mGFLpMGM
         WZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788023962; x=1788628762;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sONVEZiNDD/vWuq0jYfSacz0G46fBZ+XyTkV+lYzYaM=;
        b=XgaSWIB/eR5p1XNulTMws0qWmSNPWfK+dRoUeMsS0vNKnR+draPHtvdWn0gsRMizZF
         iBcmNTjWIN8xq5L1R+U2a6ZnWJLuRsSW7uddZUHoud6ULmTFA8rQfk7YoCPgMijpTjT/
         h9UadP++lTya4gGp1lhPgGbnd2HAcQEH7uGNSB2q4jOw1PlimdPCys8thNHRXnUC8IWb
         mTE9+K4qN/MU3zdU8rfjtDXp9vFEy0ZkopFYhDzo98rryZ3wKOYaVEY4ErJynAmst48a
         l6d6hc1FR+D+3b48kJ8d8RoWl5wX4WCKMHCeKMHbMNwI9TjX/MiUiU0aHJwbuhZ216sK
         xM8g==
X-Gm-Message-State: AFuF++luk/v9REFcsJCzcUUpc3vVr6a6f/w91NPczLzipEbhSCaas7Bi
	5sQuT6P0Gy/bVY5kvrXyhAcCD08bK/0vWFr+cvfGOCmjsIZe4Wl9UYSh3B83s3zVmyM=
X-Gm-Gg: AYBFou2Xz/xYN1lNMRcXZwwGMB/h4BCk/JVyPVbEHvsm3f6WfjEJXAuvNmNul32IS64
	SgEN1iBspGkTSycs5Y8ZF4dL5sDFkZaRESYtNy+q8m75PIJ9fiBsGSTBvME6GVmBvOjqT/jQuPr
	MyolFKLaKw75hwpQdGu9owq2iCLLpQQIPauJ6VJMfkqozkN/ruqsQm78EydeymvywcZiqV/L/Bh
	bs54eoNdvWpOxTvpSQ5kzNtpf0SyZ0YMcP8JOasMyPsXgZ0FtwOxe45GomWsptQBsPybQOfQkXA
	wAqehtcX34o0iKt4/9zuhi6EiWEHGj7khWjahxLP1Q7m+TseiLGkdZa36MjZUW8wNz7q2TQzaGL
	7UrPEkEJJeNt8uD4/E7Yfs/z9fLvksqFfcrJ40/HiRRcVinqnHrz4rO1bfGjCTiyyjym/GutIW6
	xKxvc5Z4RpKYt9UmAsL3ttXLUmWK+DUOLCtQxIUfRvS+bQeFZI8lFDsPjb15vGEtDXI0kdxl1sc
	k39nvtfnnj11OIKKl3OUCjnqIPyDRulNQuPWDm8PGxt15J8NST2dUR3y87GS3fKDuGqTqmW/6Fi
	J/Xgys/tof/5Cw==
X-Received: by 2002:a05:6000:2f8a:b0:482:e0f3:462c with SMTP id ffacd0b85a97d-482f7826e4cmr11932558f8f.0.1788023961957;
        Sat, 29 Aug 2026 10:19:21 -0700 (PDT)
Received: from pop-os.. (98.102.222.87.dynamic.jazztel.es. [87.222.102.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb20793sm10999986f8f.17.2026.08.29.10.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 10:19:20 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-block@vger.kernel.org,
	syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com,
	syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH 6.1.y v2] block: make bio_check_eod work for zero sized devices
Date: Sat, 29 Aug 2026 19:19:18 +0200
Message-ID: <20260829171918.134829-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025041215-grudge-rearrange-7123@gregkh>
References: <2025041215-grudge-rearrange-7123@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Christoph Hellwig <hch@lst.de>

commit 3eb96946f0be6bf447cbdf219aba22bc42672f92 upstream.

Since the dawn of time bio_check_eod has a check for a non-zero size of
the device.  This doesn't really make any sense as we never want to send
I/O to a device that's been set to zero size, or never moved out of that.

I am a bit surprised we haven't caught this for a long time, but the
removal of the extra validation inside of zram caused syzbot to trip
over this issue recently.  I've added a Fixes tag for that commit, but
the issue really goes back way before git history.

Fixes: 9fe95babc742 ("zram: remove valid_io_request")
Reported-by: syzbot+b8d61a58b7c7ebd2c8e0@syzkaller.appspotmail.com
Signed-off-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20230524060538.1593686-1-hch@lst.de
Signed-off-by: Jens Axboe <axboe@kernel.dk>

Backport note for 6.1.y:

The same underlying bug affects 6.1.y even though 9fe95babc742 is not in
that tree.  The syzbot reproducer attaches a socket to /dev/nbd0 without
setting its capacity, then mounts it as BEFS.  BEFS calls sb_bread() while
bdev_nr_sectors() is zero.  The maxsector guard makes bio_check_eod() accept
that read, which reaches NBD and waits for a response instead of failing
with -EIO.  syzbot reproduced the resulting __bread_gfp() hang on 6.1.y and
identified this upstream commit by fix bisection.

Reported-by: syzbot+2aca91e1d3ae43aef10c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2aca91e1d3ae43aef10c
Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---
Changes in v2:
- Explain the 6.1.y NBD and BEFS failure path, as requested by Greg:
  https://lore.kernel.org/r/2025041215-grudge-rearrange-7123@gregkh
- Preserve both syzbot reports and the upstream commit metadata.
- Refresh against v6.1.186.

Older stable trees are not included here because this backport and its local
validation are scoped to the syzbot report for 6.1.y.

v1: https://lore.kernel.org/r/20250412102424.56383-1-miguelgarciaroman8@gmail.com

 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 25b4733..1fcd80a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -515,7 +515,7 @@ static inline int bio_check_eod(struct bio *bio)
 	sector_t maxsector = bdev_nr_sectors(bio->bi_bdev);
 	unsigned int nr_sectors = bio_sectors(bio);
 
-	if (nr_sectors && maxsector &&
+	if (nr_sectors &&
 	    (nr_sectors > maxsector ||
 	     bio->bi_iter.bi_sector > maxsector - nr_sectors)) {
 		pr_info_ratelimited("%s: attempt to access beyond end of device\n"
-- 
2.43.0
