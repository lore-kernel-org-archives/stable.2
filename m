Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF524D990D
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546322; cv=none; b=a5PMeLEtu8JwrYE/xdfJrVFa9nrwLcnKZk3fl/VqFq8QXq4DbYnuukIz+xLhMnuVoDf9reCbW9v2JM4RYITDhups5LbR/AGtBi6/NrlNqNvtynoKuOXLuqUZUD7dakIC1x3N2ydeyt3X4pHz4I0oPs40x6Krhc/NiKoB/yWfCYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546322; c=relaxed/simple;
	bh=E1XMyad7VnkVzB7/p/Kp/l/hcMQbzp3Rdwh357Rvu5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c98w2HYOFIETJkes1w0PVypswwZZD6YDvY0QnEZKwDrnJ4FPVy2EYAFoU+5WDs1X9+UH+3nXI3r6k+e75yOTW8dlkeIea0+PFf+WrlyZWvNor46q/ByTJnSQUrxunNkUO9JmmGvyL9yFI8i79pDsT6aH1RdPffb08gFZQdSbHIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzEDyHU2; arc=none smtp.client-ip=74.125.231.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzEDyHU2"
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f4cbeaed17so472838b6e.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 04:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791546313; x=1792151113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aQv3jnCfnGYGyZdLu9hITrZVCdW0zrEfT+n6BY05h+8=;
        b=dzEDyHU2wxFXFDt6Me4PEeRfJQtoK8Ay4yAywJ+GG3mHldb40IqHL9e9Xeqci+WqOZ
         9OrSo3kvRB5s290L6damegaOlBHav0N2mBxyCJD9W7F7kxE1IrlebyAYkdGEfdT3ahUD
         dhXTvsJg6PJY7INY+mi9QVxXPYrUKiRRQD0887OcU9Kwx3/QTKYEwRpCeuDlK/RovHd2
         M2N4/KQvyIEDTCsjA7hdpejlcH3kGS2zqbli5IokLOI7bPNl4NaDV6QI5apjTH3jgC1a
         v5Htt7iRmyE7+1C0gA+fgrGw/Qo0LXamSlDCZOHgqavnmwNFoyPWVMdM7diisDRSHv0x
         18kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791546313; x=1792151113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aQv3jnCfnGYGyZdLu9hITrZVCdW0zrEfT+n6BY05h+8=;
        b=pATlNXSt91jTnISvgQT3cchS2JJYfBwQgQ7Ps3GRpLM+E9EeNHwXPNjxVOQNvpFXVw
         xG2b0vKL7m50IsoXW2zcBYekeztlfBHl9O/e4f2zNypo9Gag0F18gu+LvOMspSMjsBsE
         yCcIcwPH/f8QAFWKW9Nem5px6CoMTP4GKOXi2R32RCwWLXGew8TuEkTSlzuNy2zAxe/Y
         ztUkHcIaOFPl3kKHQaA6orhN5kpKFVlTVYANUpS128zsMOlPMwRkuQo4tJCCIEselv7r
         SfQ28167oF5X8Ecxxqa/NKp6qWDLbPwYepVq1ab4TCCwMuSrKTK+EhOxwBq16E+9C0CY
         2B5g==
X-Forwarded-Encrypted: i=1; AKwUvBy7/+DTDGZqPrrL8Z+yi/VeHvFHzXaHFVLC6OPBEY/3qLwKls+Q8SrVDdbOhWtGUGfm7DwlnX0=@vger.kernel.org
X-Gm-Message-State: AFuF++nSBHQj9Wtp2tNm979OWjgWO6Luz3eboEO8DHcYb8D0rJe7vQve
	mWo/fUTMM3/aRpPyCVOtiMC4/zsJOJx7AZehrYebVA9jTE7NA0VxH/20
X-Gm-Gg: AYBFou0046VNjIQe8F0Ktg6SaN7RGJTL98jf1TAXKK7p0W86l6peqhEkAWivF9Ra24u
	nmOPH6ad8DGDRskTQRtBSQ4Xd3oVNmd43SHT7iMOjJ5mZZYllfe/DpKeJzniDBgd7e3DX7azJEQ
	vYnCVzxgmuPIqkTX7J3AQsA7d6XLbwLoRcmnjL/FHuRIDtR3Dwe12arCo/PqYAtQzlPKK7qTI5B
	CpzVwMA0yKx8J98XquVv8oWOgj7O+fOP2skqqY6q8IG8kvsCXEb3NGH+LpIupbxO0cUMVU0qcJn
	23xN5Ljcc3pBzalDeXmBzFgG8PGa3I2nMchTiLcz1WeMkgyk42QHV4uH0Pez6MpuAdbOxtIfIdQ
	bcJo1NP72m0WvrbA9NOQzn2gNbmMVMwV4L+PmPqDNRKHqcIztpqfY3mnwqqJfJOUHcwU0QPhfXp
	Z8Dq1smqyTYVQ8O2ne3O8pNIQNwB/hWARgSLYnRfIutXueOAQtTPN2SO8iEo2IwczkdfiyTSt6P
	tKMCZMkkar2iq/7gX3qkzAVg9zFUSpi37D9
X-Received: by 2002:a05:6808:1907:b0:4c3:cec9:fd18 with SMTP id 5614622812f47-50c4e681ad4mr1048459b6e.11.1791546312802;
        Fri, 09 Oct 2026 04:45:12 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.165])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-50c1a325a38sm1682405b6e.12.2026.10.09.04.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 04:45:11 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: "Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] xfs: fix out-of-bounds cursor access from rtrmap level off-by-one
Date: Fri,  9 Oct 2026 19:45:03 +0800
Message-ID: <20261009114503.3669142-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

m_rtrmap_maxlevels includes the inode root level, so a valid on-disk
bb_level is strictly less than m_rtrmap_maxlevels.  Both
xfs_rtrmapbt_verify() and xfs_iformat_rtrmap() compare with ">"
instead of ">=", letting a forged block with level == maxlevels pass
validation.  The cursor is then sized for maxlevels entries while
bc_nlevels is set to level + 1, so the generic btree code indexes one
element past bc_levels[] - an out-of-bounds read/write on the cursor
allocation.

xfs_rtrmapbt_mem_verify() in the same file (from commit
4a61f12eb1195 "xfs: create a shadow rmap btree during realtime rmap
repair") already uses ">=".

This vulnerability was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: fc6856c6ff086 ("xfs: introduce realtime rmap btree ondisk definitions")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 fs/xfs/libxfs/xfs_rtrmap_btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_rtrmap_btree.c b/fs/xfs/libxfs/xfs_rtrmap_btree.c
index a15e460a1ec7..6833c924a383 100644
--- a/fs/xfs/libxfs/xfs_rtrmap_btree.c
+++ b/fs/xfs/libxfs/xfs_rtrmap_btree.c
@@ -256,7 +256,7 @@ xfs_rtrmapbt_verify(
 	if (fa)
 		return fa;
 	level = be16_to_cpu(block->bb_level);
-	if (level > mp->m_rtrmap_maxlevels)
+	if (level >= mp->m_rtrmap_maxlevels)
 		return __this_address;

 	return xfs_btree_fsblock_verify(bp, mp->m_rtrmap_mxr[level != 0]);
@@ -888,7 +888,7 @@ xfs_iformat_rtrmap(
 	numrecs = be16_to_cpu(dfp->bb_numrecs);
 	level = be16_to_cpu(dfp->bb_level);

-	if (level > mp->m_rtrmap_maxlevels ||
+	if (level >= mp->m_rtrmap_maxlevels ||
 	    xfs_rtrmap_droot_space_calc(level, numrecs) > dsize) {
 		xfs_inode_mark_sick(ip, XFS_SICK_INO_CORE);
 		return -EFSCORRUPTED;
--
2.43.7

