Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685A938F649
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999302; cv=none; b=hu4t7zRcLvxg021+tmS2+SNI2FTIRCBAN/QqxZnppwP5JYfihKkEo/Z8S3AK5C3/E1QEDPoJpd3yA8Q80iQ7Oz6kcQzSiXS97NMXePwum41PQb8Hi8OLHe6ngaqvYaQrRrgOzBw60JV7PmnQmbbvD+4LfMRavmYg7dNgKrAtPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999302; c=relaxed/simple;
	bh=zgGxT3SSOQ24bRUL2XXVVhCBJgNk6SJsnyd9GJ0KTEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OE6sfOt8IU5ekLwoCdBrj/GBWSXA3lPefocVtIY1pBMOKNbjZEGQ+gJTK33Mce8q5L45rtbwxNF+KzrwU99ZMqKUrLC5ainp8Ht8Bvdlai1ouMBelRP5TMhhRWMR12O352U7l9RX1v6nS4/TKv0wy1lKxQglrr/N8lUxAyl3HVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YJxQImRG; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJxQImRG"
Received: by mail-pj2-f11.google.com with SMTP id d9443c01a7336-2cf02ecb572so20200605ad.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 23:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999301; x=1786604101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LHiVelN5mh9CVmWnGQoTnlP7xVCZ+d8Y4Ey2Z8wrXTE=;
        b=YJxQImRGhd8aRCFHmTM1Qdgy5q0grduSRh+S3B83EhfHkidCooiTf4LNzdudEJLkze
         ZCj43wXBpsSrYXXS/vPd+tXDEQ1/8tPDeBUfo2UPl5JhHWGXZjRFlGBnmITTc0tqPSlo
         ywNfUiY59QsipPcSdTC6mhje17n1p+m7FSU/rzATkPGP+zWY+TCDL2pmBqMIvEUNKYeT
         NhlpTjaYvBFOTyysE8jQNlGlW+xZ1xtk+OigwnP1IPtjDeKg5Lqusgd/dg2bJpxPAGTH
         S/hmzOQxggJlKKQvjHsRfU/RellxFt7FZ7dNEiSs6MVCz5Erm+gjMiEW23R91ZiR6rON
         mibg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999301; x=1786604101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LHiVelN5mh9CVmWnGQoTnlP7xVCZ+d8Y4Ey2Z8wrXTE=;
        b=Oo1GdKpXKT4dOEAnYcpErpJSxRxBX3R/3gM0cpu4UcP/35MVxonTwfRAI9SQewvL7M
         dJEmZRmT6cRAO/+9ffBkMHMIw4oUmmflIfXrpGT/hzBR9eYzAQyl0aBauqG4KCUZOyP3
         In9Kx1+iD96E7/5n3WniupsDGDNYVjsssH1gzXPHOj1vFIuP5CtT/xtLziftBc6OTL3t
         hZT3NXRWETKgjdwEozxvquCCeiHOuhORxufWr+wecbfEosJUWkjFcSTyIc6XXuQTwanN
         FFU/TBlma9K4W9DN5gT1yTh2mNUqsR7U4Jn0ffS0WoRm35buf0Z/piQ58D4K9fAddajT
         8qmg==
X-Forwarded-Encrypted: i=1; AHgh+RqWcONjQh/WEZhZ3FfTRsXlV7AoUGsQq+/EfFbj4yn4x54JlRoTeQTtVZmuKydCdlSDlNqnjCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39LiFP3d9dHw41vh2Pd/ex/bW1Q4cWEPSztN4t/ZmdXNFA4k1
	5jsF2DwK8McfU79yjXoJMlVe0Wwk3+adaYcHTGckqBLZi5K6zIaGc/1eVxENeQboJ2sna+jQ5JE
	=
X-Gm-Gg: AR+sD10gfp6UVLGob6ecqI47i6AK87BJvCnLyEZ22mpGuP3wldq+3a87qKWvXjDOivh
	pdzcbzFxXuKVc/u+vFL3+QRevCrzOT42fOJPXgla54svt9YmRnaxovI9mr18qKmJHL4/MTg5nzs
	dXkwGmWVNIiZJWtPF+S/qWyoXahddzIE0tJcdZofretjyl0h2FFnDy4d7EZrxkYFHOdFjsAzcRM
	ZgtPJPxFmiXmC3bot57H4ocv1iIVNmDOzFcUO9JopSCu3QG9jp1G9rdgNoJZcxSjV8V8Ck4hlVs
	RZkE+nBI9ipj3zuiq6pMgGJKdweb4a9FDhkz8kUN8ccy/P98NFwZwWD6vNpXhluvnWwWOHAIgaW
	gn3Je0cNwgMoolImRjD82W2Qbkb7n820KxjNqrLtffCDDmN/fdI5QOns9WSks82OEQqF0xlD9m2
	YeRKQZU0R35JQ7XlsRl1jNJ0YY5AcDWijIMDBdXugXGJGXLSqo9pn55iPo11kVum7/+GvnBD6jN
	8vas+xPMynai4Dw1X7ZuDtGYHVv
X-Received: by 2002:a17:903:2392:b0:2d0:cc92:f7a3 with SMTP id d9443c01a7336-2d0cc930281mr137694955ad.2.1785999300646;
        Wed, 05 Aug 2026 23:55:00 -0700 (PDT)
Received: from yde24-ubuntu ([39.155.246.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9f93657sm26417645ad.17.2026.08.05.23.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:55:00 -0700 (PDT)
From: Haiyang Huang <huanghaiyang83@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Cc: linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Haiyang Huang <huanghaiyang83@gmail.com>
Subject: [PATCH] erofs: fix out-of-bounds read in INTERLACED pi computation
Date: Thu,  6 Aug 2026 14:52:52 +0800
Message-ID: <20260806065253.1083865-1-huanghaiyang83@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In z_erofs_transform_plain(), the page offset `pi` for the INTERLACED
initial tail copy is computed using the unclamped value of `cur`:

    cur = bs - (rq->pageofs_out & (bs - 1));
    pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
    cur = min(cur, rq->outputsize);

When cur > pageofs_in + inputsize (which is the common case for
ztailpacking pclusters since pageofs_in + inputsize <= bs), the
subtraction underflows in unsigned arithmetic. The subsequent
& ~PAGE_MASK extracts a bogus intra-page offset, and the memcpy/
memmove reads up to inputsize bytes from past the kmap'd page boundary.

Fix this by clamping cur before computing pi, so the subtraction uses
the actual copy size rather than the raw block-alignment distance.

Fixes: 1ca01520148a ("erofs: refine z_erofs_transform_plain() for sub-page block support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Haiyang Huang <huanghaiyang83@gmail.com>
---
 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 3c54e95964c9..9c65364ed002 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -299,8 +299,8 @@ static const char *z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		return ERR_PTR(-EOPNOTSUPP);
 	if (rq->alg == Z_EROFS_COMPRESSION_INTERLACED) {
 		cur = bs - (rq->pageofs_out & (bs - 1));
-		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
 		cur = min(cur, rq->outputsize);
+		pi = (rq->pageofs_in + rq->inputsize - cur) & ~PAGE_MASK;
 		if (cur && rq->out[0]) {
 			kin = kmap_local_page(rq->in[nrpages_in - 1]);
 			if (rq->out[0] == rq->in[nrpages_in - 1])
-- 
2.53.0

