Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834893E1CF4
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785913725; cv=none; b=IRvYeFp/tLyVjPTADhMB0KPWPFMowhUukqW1ja8iQJoBKSvLtOOsHL+9j98ZDKwfzPPi/Mxd9HYJJb28E8iBXVCqSUhHIXcx4iCpSSsrkVB63/jQjW22aZTV59r2jPmAp8lnMwqvknOv356I43u955fgvB0LyRbswZFeoHzx7Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785913725; c=relaxed/simple;
	bh=7HiAf+EpVjkitp9J9mLgx1LeCBjQIRcocIrQjiEIkm0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=raKmtLO0YQrfyiYNUAVtUWKyUPV3n/NlefsCJnvZxBpRmxdjVEORJSUtWx2VgMcnBaSzZID35z2TGcekenoy1wWw93H4suaX/zs4VLpfVNGU8m1Zu15IZhNyi5DxpohERWNrwfObv8kj9vh4Xm2q88BDqZqgyJAi1lyHOhQQ30w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZ0vZ1hx; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZ0vZ1hx"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso781136a91.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785913723; x=1786518523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g/DUUT6RMx4jLkGvR4e26W85aURX7BHuSfTbyD0AJW0=;
        b=iZ0vZ1hxqyo5FIUeI3oN19XuFcfDYOuPw8jzXZyKVGa4yeo75GjOh6PWgxPhLD+d/+
         funQsQYBZtrW4aPzyPX0hGwGllL2zByw4tyBn45gTeQ2dFa1vC8mFb9L+KqHBPiWR6NK
         ZTTp7kiSRqHJNdQJe53zKla9KKGHlNx+j9fC8y6VD7tVJULaMGmOdS1eb/AUNTdDtPFD
         s8VqklQ+fa9VUHY34Rd+KHCrmYCtyemYE0B0a8kYmx5kY5P4nty9YONMi9sJsNVdmJEe
         t86ZZq70Itu+dYRx2QyvfpTSEcEcbZIoKi/X8K+39T+qgruIa66QXJzjn0+/H03Wwwcg
         oQ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785913723; x=1786518523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g/DUUT6RMx4jLkGvR4e26W85aURX7BHuSfTbyD0AJW0=;
        b=QjnTfY9ET0NZwpqG0jif+tqmArR9VZOdv8KUfy/Hw2VAo1FDx7vv3zLmaRGKVnnGXs
         8n41jVBHSNQV0UwgZmxIZg8tdsJID2r2tDn0rybBdDL6xyiCC8rT08IqYJu6ovzHGD+Z
         tW84zLHXDvgHjD7HNEGMmtmIiFv49iDnWTbwlyt70UYGPjKwjQ9NF1VyJss44NNB8nH1
         ekClFFMJl+B/6h2pYyQagVkQS/qVbemjGrqd5ppSo9wKLfGTBKAR+SHbwj8JmLAwv5NL
         0Ik2/FmyXO2vzB8u+qJZV8A3oheGfcsSth/53lcRbHRwmSIDwRYV1u9z5BOMzzqlJ6mR
         CIwQ==
X-Forwarded-Encrypted: i=1; AHgh+RpfGyiUpP5NpFBu8kQkNEouKDX8BHvoytIZ0jYl56y1+L7fWOj0JyaSgVT+i1WHOo9rf/ASPXM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIKjFAqx1THmHzmuvj5otC/O2P9cx45KtotpLtZdtar3mTzjG
	f2ReDPoFD4aEu/sroEio+gPMWyYM0sH6c/xoSStDzV5ioMiw+plFeVGX
X-Gm-Gg: AR+sD10ZCQFg4kWrnksNenxJAH5fZB6T08fjBh5FhtM9SpOPBmqf9nkL19/mkiPbuCY
	m6rB/uHPBrHe7eVYtIsYYRfN5Kgbba5tXQyYGdRZNdXN6q0Wi7yA8QeBO/fouP/XlJhH54YlCgq
	HliZIZW7slFlGzVLHwrHl6bWALe6h61mV1tQCzaiMUvFUN0TRYQ/Rh5MM4lSxtp5QqwlmbOXyrr
	Q5Du+CAHE3wfoSlxBAmKonglrSYF+p+2VZDLG9L4p0vfk5TWWv0GGSFT8reBqKrQCmEuaktb3J0
	wGj2cmt9T9levsAd2pL0QLrJrt2Qm66HJCvE87dTR6Lm/6EnnQxtusaMot6Cb351ormypnQyBC5
	x3lj5txA3K/TxXGvcClfVnAMWFm9+SLlOlhls8VutjZJizt2fvPf40cndxjlEx8QccZcwXHm+2S
	+WN3GCzZk3OXKmjuzM77SY3zWRooDPOLDXIOqHEvnxhI3IgVHGW7zL3mrRnQx1E8J2lrjbo0YXE
	Y1iDI/0Sn/lVt1axeXEop31PCSz6WZ8FV78cmeDIm08VrEH2vJpN1Q1rYuDDIFIcze9U5+2QjLO
	b2ToG3eyWUkqfflXtu7L8SiPFH8eShkjd1Iidx/wB/xdbX/F89gTDqNvT41Cn9rC
X-Received: by 2002:a17:90b:584c:b0:38e:2f21:3bb5 with SMTP id 98e67ed59e1d1-3903c63373emr5263359a91.21.1785913722666;
        Wed, 05 Aug 2026 00:08:42 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903927dddbsm2136523a91.9.2026.08.05.00.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:08:42 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: ocfs2-devel@lists.linux.dev
Cc: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	glass.su@suse.com,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Matthias Goergens <matthias.goergens@gmail.com>
Subject: [PATCH] ocfs2: fix cached cluster count after suballocator reclaim
Date: Wed,  5 Aug 2026 15:08:37 +0800
Message-ID: <20260805070837.3390148-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When reclaiming a suballocator block group, first reduce the on-disk
cluster count by cl_cpg.  The current code then subtracts that new count
from the old cached count.

For an allocator with N groups, that leaves the cache at

    N * cl_cpg - (N - 1) * cl_cpg = cl_cpg

regardless of N.  This happens to be correct when reclaiming from two
groups, but undercounts the clusters from three groups onwards.  The
incorrect cache value is also used immediately to update i_blocks.

Assign the updated on-disk count to the cache, matching the allocation and
inode refresh paths.

In a QEMU test using a clean 256 MiB OCFS2 image and a 10,000-file
create/delete workload, the first buggy reclaim left the on-disk and cached
counts at 2048 and 512 clusters respectively; later reclaims underflowed
the cache.  With this change, the cache matched the on-disk count across
all four reclaims: 2048, 1536, 1024, and 512 clusters.

Fixes: 4a54331616b3 ("ocfs2: give ocfs2 the ability to reclaim suballocator free bg")
Cc: stable@vger.kernel.org
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 fs/ocfs2/suballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
index a4a2b87a45fe3..20c3aec6b9873 100644
--- a/fs/ocfs2/suballoc.c
+++ b/fs/ocfs2/suballoc.c
@@ -2759,7 +2759,7 @@ static int _ocfs2_reclaim_suballoc_to_main(handle_t *handle,
 	fe->i_clusters = cpu_to_le32(tmp_used - le16_to_cpu(cl->cl_cpg));
 
 	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
-	OCFS2_I(alloc_inode)->ip_clusters -= le32_to_cpu(fe->i_clusters);
+	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
 	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
 					     le32_to_cpu(fe->i_clusters)));
 	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
-- 
2.55.0

