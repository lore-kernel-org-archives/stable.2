Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404D9396D2C;
	Tue, 11 Aug 2026 02:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786416757; cv=none; b=H0BOuT6EmU8SG1K0wkWpw9XAK9nbwjNvXMQ+SaEM20PHP+mwFB4bgnKbJISLUKsk+3L810XJW7RY5G/C+BNQgF+FD3Htg6wDbrnfzga1ejtXbOca4rVWKzb2GsUQCm5syzxYcHjLwbzFHUQ1SYXTYTq5keKGa1gP8n4Uz/GhpUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786416757; c=relaxed/simple;
	bh=o5x6GgUnH9uewKMiYcW6HBynOwozcPIh+6R+cXqKehM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P8kbcORpGG915ZKMkR1hNt1YxcoPZcZ0m8wk/la9y/BNlIp9tZUWz0p4Yb05EWIGSETO0weZ29kJk8FOK7dsDtC0/NH1VGiHyJw11rOHpyJox49l0PGc97thlqfhNaQfjTePh0wK+HDEYOjhpLHl7inL1mzLRLjK2sG2P+/ayGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: b0d9996a952f11f1aa26b74ffac11d73-20260811
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6262ae7c-cd74-4562-8e3a-360b83bcdc0b,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:4ab242ce31caa993ef41e8048278bcde,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b0d9996a952f11f1aa26b74ffac11d73-20260811
X-User: zenghongling@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zenghongling@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1303893939; Tue, 11 Aug 2026 10:52:28 +0800
From: Hongling Zeng <zenghongling@kylinos.cn>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhongling0719@126.com,
	Hongling Zeng <zenghongling@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] ntfs3: fix buffer overflow in CreateAttribute validation
Date: Tue, 11 Aug 2026 10:52:24 +0800
Message-Id: <20260811025224.21540-1-zenghongling@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the CreateAttribute action, the validation checks whether dlen
fits within the available MFT record space, but the actual memcpy
uses asize (the attribute size from the log record) as the copy length.

A malicious NTFS journal record can set a small dlen to pass the
validation while setting a large asize that exceeds the MFT record
buffer size, causing a buffer overflow when memcpy copies asize bytes
into the destination buffer.

The validation must use the same size that is later passed to memcpy().

Fix this by using asize in the bounds check instead of dlen, since
asize is the actual length used by memcpy. The source buffer boundary
is already validated by the existing check:
      Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len)

Fixes: b46acd6a6a62 ("fs/ntfs3: Add NTFS journal")
Cc: stable@vger.kernel.org
Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
---
 fs/ntfs3/fslog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ntfs3/fslog.c b/fs/ntfs3/fslog.c
index 3440212ecb12..294d7a2f4e2c 100644
--- a/fs/ntfs3/fslog.c
+++ b/fs/ntfs3/fslog.c
@@ -3288,7 +3288,7 @@ static int do_action(struct ntfs_log *log, struct OPEN_ATTR_ENRTY *oe,
 		if (!check_if_attr(rec, lrh) || dlen < SIZEOF_RESIDENT ||
 		    !IS_ALIGNED(asize, 8) ||
 		    Add2Ptr(attr2, asize) > Add2Ptr(lrh, rec_len) ||
-		    dlen > record_size - used) {
+		    asize > record_size - used) {
 			goto dirty_vol;
 		}
 
-- 
2.25.1

