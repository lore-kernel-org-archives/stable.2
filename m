Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com [74.125.227.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99C485CF9
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789470844; cv=none; b=WLKTyFteePav9dU9R58sQMfRZklHTNswO7eejpJ4Xk0ZSRa8A4nzsC/irocieBxG/M9qIDR2fTyqvZ3USJbXAzbes/VMmKMkMZHr2hc2avDMqbk0fI0r4Xa9rvwofVTS1mgkroHFmXo4SHgSGy69/8vgraAhsiGArN4cUjy0u4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789470844; c=relaxed/simple;
	bh=sJrFySi4bYC5wzYpLo3wzSMqebdql/9/GrvU2FaX1d0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ThEzJiUJaszblhi+3eFLlPzLv9bxsA0U0O2NZJ+c8yupqCf4jx4oG1U83Cj5Bbm0F7P74wSBqiERp1Hjk0oPUZHYaVHLH2a/kM9G3gqLbeKSqa1gwnMHXOrv3QSa6XXGSJ0f42WI+VMBW7QSTojX8LIpf1EZjj3n06oKVt5kseI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iaaVaaA6; arc=none smtp.client-ip=74.125.227.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iaaVaaA6"
Received: by mail-vs2-f42.google.com with SMTP id 71dfb90a1353d-5c963a787c9so1099340e0c.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789470842; x=1790075642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bz3i5Bjgy+qhtJ2RiKqbQXOaeVHp9WfJ3fh43+g/sbs=;
        b=iaaVaaA6IUwirkHWEJtUbSt0AG/Fpl7Vu6TvTnrFn9LNqCexAWDsiWi17NxaQAc63W
         u38KMjoM8xpF0/W0c3i8l2E3KeiiCbrvC/hMwCrS9PR2ylH+DE9poabPl9l2G73a10w+
         9BmgJj4cRzRqS/bMxlnvFIyuDL/adzE3itUgPJbT9GA2IGGazEGFsMVcWWgYHRLlxpW9
         8Ed2g5K9XRp0VipgyhJF5CdkgctEmsJYtglUhuCvBof3LNnlg/XkTck6ckwCA0iEKXxO
         jh4hvkN5PE5umO5BHXM4m+ZcFnu3mEUN/DfKpMi2VB6v7rS+btH5VXtbmxoJUvesG3EN
         lLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789470842; x=1790075642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Bz3i5Bjgy+qhtJ2RiKqbQXOaeVHp9WfJ3fh43+g/sbs=;
        b=JB026lgUe2DZpJHI0+LoZt2olryAQalPrF2/HRUB/y+Hj8nEiOm6pyELwJcp644Pqb
         tlfPvtNtLmooj7JYjtb0+Go5bjstW8W9Zt7NOn4OXZ+PRXwHLRQxlmv7GXQ3+taA9c4F
         b68BIO2/1Sg1dGXabnA78JVxrCVqAzxVjcg8Yk6Znfwwji+H96TWQ+8eVmx4/KsU/RtZ
         Uh8qWYD7odXSz9fs4Uxb7bvIQV9ivpIeCRo/pjm6o1m8Q6KxZp+IFSXPXG98M3qGrJKD
         Ueq88LRb2pw3m2EGt4iFrAl9cKw+yQzx5NHx6wIZVzY1CMkCe6W6h4BEh50BzkCaPRk+
         37yg==
X-Forwarded-Encrypted: i=1; AKwUvBxglJPfPZlhPuZmGQS9oYZdHsI6H3AU6+GZImCByDxh2g3i2XnaPb9rZeG1VkrotjAyPNM5M0g=@vger.kernel.org
X-Gm-Message-State: AFuF++mTYcwL0CFDkhHyLrJO5DRSDWmU+KXOP/uETcWBNOf74IthuD63
	KuPr7VCe3auv1x1AgfZdw2oQtiL6jkgpBD8RgAxMDZmR/T3V2QeSiJ7x
X-Gm-Gg: AYBFou22GNaKXVyLL+biR3WvaLJcGeMFG7mUDodjih/DqGreQbP5vVavMrpgFpZ1+g8
	PBCpT6xBoOLY47tWvrf5hJ/rgRy1MumLV2vXdtNq+8Tk903yKgXp2DGDVcfrwavw1sEY61M5lQ7
	rsajDWhEDZk+l+iTmQz4eem0zUL8LyGy246jSbHH/3yauYcStiluLX++Juea6hOuH0YJCxUm4UW
	PerWDU8GPUwkvRQE6+dYEUuSBcSwUD56SwLaIqEmaI6KsyC+IEydmLjlxWUCveaSIGDiZLoqHei
	fzn3WCin4dcCd6J0nUz/2TcgrLT5GFfSPZujqVoVTaiEYFMBXPPdBNTXHmKUYyO7dBJ06MYUSmM
	X2+QjR3R8RyBTYgwBI7EfIGulxEHNA/XMsMH38Ek5qMx/s8WIF8uSVQFnIjAm1pks8jrUwo1oIF
	SXG8Uwpda99msBufZjlz32clpUG1Y7kanwlncNyxgAXQzOmC8dkgEX4jt6RKvJqzfG
X-Received: by 2002:a05:6122:32d0:b0:5c9:72ea:141b with SMTP id 71dfb90a1353d-5c981d701dbmr8067066e0c.6.1789470841672;
        Tue, 15 Sep 2026 04:14:01 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470ae56asm16455579e0c.6.2026.09.15.04.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 04:14:01 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: Viacheslav Dubeyko <slava@dubeyko.com>,
	linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nilfs2: validate file block counts during recovery
Date: Tue, 15 Sep 2026 08:13:51 -0300
Message-ID: <20260915111351.2726334-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nilfs_scan_dsync_log() trusts the block counts in each on-disk file
information entry. If fi_ndatablk is greater than fi_nblocks, the data
block loop can consume excessive summary entries and the later subtraction
used to derive the number of node blocks underflows.

Reject inconsistent file information entries before consuming their block
information.

Fixes: 0f3e1c7f23f8 ("nilfs2: recovery functions")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 fs/nilfs2/recovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 4d5a6aa521..6e4e0cf4cc 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -322,6 +322,7 @@ static void nilfs_skip_summary_info(struct the_nilfs *nilfs,
  *
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
+ * * %-EINVAL	- Invalid block counts in a file information entry.
  * * %-EIO	- I/O error.
  * * %-ENOMEM	- Insufficient memory available.
  */
@@ -359,6 +360,10 @@ static int nilfs_scan_dsync_log(struct the_nilfs *nilfs, sector_t start_blocknr,
 		ino = le64_to_cpu(finfo->fi_ino);
 		nblocks = le32_to_cpu(finfo->fi_nblocks);
 		ndatablk = le32_to_cpu(finfo->fi_ndatablk);
+		if (ndatablk > nblocks) {
+			err = -EINVAL;
+			goto out;
+		}
 		nnodeblk = nblocks - ndatablk;
 
 		while (ndatablk-- > 0) {
-- 
2.43.0

