Received: from pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.35.192.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4CB4E3EF6;
	Fri,  9 Oct 2026 13:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.35.192.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554097; cv=none; b=PokSwzc9yCW/BZmB60jXtY2s0pXKAfHYf6UTkAaGOPOl/wilxlmJiDrSNpSsBxCTtmZrhM1fr711Z/tkZkf0gQFtGw5/eSXZ09Mr1MNnTdMLbm7FS/AF5vt+WXQja5i6CUq7qhZ8DOdVULEonYH00Upsagu3ZT23bfsDn6VuQ7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554097; c=relaxed/simple;
	bh=3576nKO5NiuQ5i2Jw+4CtNQ7xmTo3PzbBVFLp/Rv6JA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ew4JoR2iySV37mucwzJal8rzp5bnI0YjTSsx0kOzts/WV3/1/fm6RCRTbWolMrbU732Q/E1du5b/iOsm2mK4sgn4p1xE/j3pO+1+uHXFbZWaIT9I5PNaQWZi3uww4olgukJuxjM8PTX49cLB/cxWlO5AuY2qUgLGASIMwpLNOLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=alS0a+V4; arc=none smtp.client-ip=52.35.192.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="alS0a+V4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1791554096; x=1823090096;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nfiX4F5Lo1fmzmU808ne3EPfejKbtSgBMbK0l0IPFqQ=;
  b=alS0a+V4KEnuyETzsyDrXAWKrajknxzuNjPaJbtO1wrFHxGWUwJezCTq
   RNB+/EUeCwTE4BNZFn3KMArihLRhEE5t6gY1gKx9QpYmu/Zjz/RZyu45V
   QGB2BDxLu4xhFyhEoHvuKSHSrrlU5lWp7yUpFTsWkGBVJ3gcdPHf0tkNu
   dtEZM+72d7FL2btLOaoZtlKEO0/TtdzZAdmanUxhdG/dF8eWB3W+sYHtx
   5O8hda7zE5DRsjK83wJoMg8afWUKNQD9O6VBnkePGPX+MFFK5rxm7ZjmN
   x2R9jgOp/HKD3kvNy0sr9xIitfbNQaiwdoc2rDXaNgCevh0QbXSfU8CZS
   w==;
X-CSE-ConnectionGUID: EkURN3wXRKmCElcol5PLUw==
X-CSE-MsgGUID: DIWS334PQjaukb+liziEfA==
X-IronPort-AV: E=Sophos;i="6.27,148,1787011200"; 
   d="scan'208";a="30602260"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-011.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:54:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:22667]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.153:2525] with esmtp (Farcaster)
 id 150b3868-ecb8-455f-8a07-9796f850417b; Fri, 9 Oct 2026 13:54:49 +0000 (UTC)
X-Farcaster-Flow-ID: 150b3868-ecb8-455f-8a07-9796f850417b
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49;
 Fri, 9 Oct 2026 13:54:49 +0000
Received: from dev-dsk-nagornyi-2b-f14a9408.us-west-2.amazon.com
 (10.153.215.117) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.49; Fri, 9 Oct 2026
 13:54:48 +0000
From: Nikita Nagornyi <nagornyi@amazon.de>
To: <stable@vger.kernel.org>, Konstantin Komarov
	<almaz.alexandrovich@paragon-software.com>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
CC: Sasha Levin <sashal@kernel.org>, Nirbhay Sharma <nirbhay.lkd@gmail.com>,
	<syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com>
Subject: [PATCH 6.1.y v2 3/4] fs/ntfs3: fix KMSAN uninit-value in ni_create_attr_list
Date: Fri, 9 Oct 2026 13:54:14 +0000
Message-ID: <20261009135415.850568-4-nagornyi@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261009135415.850568-1-nagornyi@amazon.de>
References: <20261009135415.850568-1-nagornyi@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: Nirbhay Sharma <nirbhay.lkd@gmail.com>

[ Upstream commit 5f33da04e6ceee849e76e6592cc283c72fef7af9 ]

The call to kmalloc() to allocate the attribute list buffer is given a
size of al_aligned(rs). This size can be larger than the data
subsequently copied into the buffer, leaving trailing bytes uninitialized.

This can trigger a KMSAN "uninit-value" warning if that memory is
later accessed.

Fix this by using kzalloc() instead, which ensures the entire
allocated buffer is zero-initialized, preventing the warning.

Reported-by: syzbot+83c9dd5c0dcf6184fdbf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=83c9dd5c0dcf6184fdbf
Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Backport to 6.1.y: only kmalloc -> kzalloc applied; 6.1.y lacks
  14f527d44de6 ("fs/ntfs3: Correct checking while generating attr_list")
  error-path rework. ]

Signed-off-by: Nikita Nagornyi <nagornyi@amazon.de>
---
 fs/ntfs3/frecord.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 17559fca5984c..c9d0947651c4e 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -819,7 +819,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
 	 * Skip estimating exact memory requirement.
 	 * Looks like one record_size is always enough.
 	 */
-	le = kmalloc(al_aligned(rs), GFP_NOFS);
+	le = kzalloc(al_aligned(rs), GFP_NOFS);
 	if (!le) {
 		err = -ENOMEM;
 		goto out;
-- 
2.50.1

