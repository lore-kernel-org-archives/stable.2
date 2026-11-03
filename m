Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793693458;
	b=dV9qtc/brLSvNhSZXMjXmVHz03sLijruxPlXvviQTRJOj/+8lPbWIozTVSGZdwRDcY5j
	 0jlh376Gn0LRsBhmj4vedE8qTgbpAPQijDq1MsUid+cITaQ5G8hWXmMXCPZ3lrAl/M97h
	 hc0nqBC+5FseGA4yyPCzrgRYOvgkL2uW1iHlIkmJeys8jJw0QDbpHGUN4WaYCWRPi8pwu
	 5VPRR7lepBMYs/JB2rtnTqriaIGdt9hsPWTWslXPhU1k7xrmQlaQSITrIxtW4NGM4LvX/
	 iiOoQ7xiI4Plmjzl5ZNmxA1MhFyRByInGJqRNclh4kMDjZRNrYe5G/l2WBx+k7ht8xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793693458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OCBEogtd4WQ6NFtESpTyBkJzNayzM85qVHDRTKTymcA=;
	b=Muo9VMGiM6q3yV0aIaQZk2+lkDkxhXSHYbFRX8W9D5uYrBCci38TpMcJiNDWvugTTwXF
	 Fs4WOiUT0iyY0AeywDwyrxdZawQnoMbtSqEgYvZpfYmqcyYO23TrlCJ7hSOZh9rfdY1FL
	 vK6qGfN8UWj/z8GNI2gb+jVZZJbCslgLKw86mk8ZVhHeTii7lZ7+iXsQVKhu5Yb/FxidR
	 4qb/hhNB49WyiQt8Rk9uhyPG8bH3rIPe+oSIYz2cBISwh+H6HGsGppUBREO7B6yimDeTD
	 dVUdzIK9eWN4bK9OZRpmGVH5fFq47hRzece08hmdqWccf6vUlj6UXImTUBvQMc/u/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwIpZWkd;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C1F606D806
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 64C1F606D806
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iwIpZWkd
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-3678f64d078so5877776eec.1
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 00:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793693457; x=1794298257; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OCBEogtd4WQ6NFtESpTyBkJzNayzM85qVHDRTKTymcA=;
        b=iwIpZWkd/OIVCNYDKv/ylUfUbC6RRjGeOfXP+TJDBfgUTZYPifM7e+YeHVHoaxgV06
         27Zu7jZqrCgKe/0hb9AjB/DCdFPCeaXPrNqcn755+x8CMHrj27EZr29LL5aiYZMgkBCf
         5p3nCi/0rijZhRnj5rTfwpJmGaMeNdLFyZboD7UOiCa1qdyjlkMvmMkovmipe1L9LaFA
         U856VuuPf5w9JD7un/GhGqPTCFIdWS74vSddSxP5l5BVPwGsxi2227F9uBJUG8NV7UXD
         h0q4A92rR0G9wVXLgAXMzzyH/LsGJKPTtuahj+b1O0YDfk0ulWH+7wbkGRUV6PD5/ZT3
         a+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793693457; x=1794298257;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OCBEogtd4WQ6NFtESpTyBkJzNayzM85qVHDRTKTymcA=;
        b=xLgubz8LRpHMHZWelm7U3Jw/IDLU0jXWymRtxH0+fAaNxUWLMQB9KQrcVX2fksPr8k
         8qNN6IelD9iJfo5wGjo/MYd1NH2SEppK7pE1cftXHPTHf+oi41rQbKFR/9LeQ2DXtbeu
         gTkdxUaxas44AaGhH/XX/xg3Ud7e6Pd980n7zmD8Gr3ZNCJzM81Nz5WaZxs8fYDU8d5U
         ghXN8qg5swhWZg22NUE9CdQH9jFt0PPCN352xyrZoaQBDvEHDByrrgzKVfXPaLt5ObWL
         ohtMCHB9oRElAhOSb1KeqbD5m4iSI0nV8TKua6M90GAPiIzmigVyCcvzWS6AUEK1dv9+
         D5NQ==
X-Forwarded-Encrypted: i=1; AKwUvBwBY/LvIcNaL0HBrssFR98AqnoaFaiF5IshFwtUa2uHJeEUAWo+lW1H0Ol7/eeGHujHCP5j1QM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/X5DXgdY4HSZwkZvYh21HqJHupPSUECoF3Z1nDDSDx8/hvV+m3
	zxvd+xy+e901sYHRDWNElCGlnnHrd/Of5czxT2BgSAFDtGMHJcd7tzu2
X-Gm-Gg: AYBFou3dT125qkT0vgWGVegQYCPP4hCY3E10rpJHaRcnsaHjhEju+p/UOd8yfUsTI3C
	IoZ+LG8w+3ON8yZPogmYWVtbtPVrO40slci3okszd7lWrmC8SNt0oD4nUFidR+PyH2iDfExX5eW
	tqRtbklKAdf2lggYsGLrEyZEylc5oeSya/wj6Vw5QNgEEhU+bXBaNLNwchFagrNQpu9fupURgl4
	joaaxjZL5pmywy1vWAbmAlmi3PRKrtTHT5m0KyuYw13UDg48zIkxTmK+YOqEAe7UrKoXn8E+wq6
	bAA5inHV5BZaozujgi+stIsNmVGCv1S+ygChgzFS1rtekkui6ouNgtf4zPGmtry5ecJngzlDhZQ
	98kuUb4o/twJeoJ5C/I0UaTsfow9RBD+pEaPH5eEInmpXrZ7DLaboL1HspQneIYIjGIIoBewVu+
	HKih/yKYo0CJRMfM+c7+qDcvkIvhRA3XnXgzDrKLIEOu40+5ULDMdtKes14/lnP40FNUJ2jWB4q
	Q3UHh4L68mTdrgiy6Zc+AhROLmL2ifr7zw1ZmewW4PDfrk9Y9y1WlOCSKR108qgmfDulPapT/oT
	iKC5mgIc3UStl+S9j+g7jG3QWktQhQ+jVVIZ4ngBYizVutUSag/PfWCN
X-Received: by 2002:a05:7300:c39f:b0:366:6644:2839 with SMTP id 5a478bee46e88-36a42203e90mr19153100eec.3.1793693457451;
        Tue, 03 Nov 2026 00:10:57 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36b13bd87b2sm4621906eec.28.2026.11.03.00.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 00:10:56 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: miklos@szeredi.hu
Cc: fuse-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	shawnq1@163.com,
	jamz@amazon.com,
	stable@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] fuse: clear the old EOF tail when copying past EOF
Date: Tue,  3 Nov 2026 08:08:46 +0000
Message-ID: <20261103080846.55656-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__fuse_copy_file_range() invalidates the copied range before updating the
destination size, but does not clear the tail of the old EOF page. If that
tail was modified through a shared mapping and the copy starts in a later
page, the newly exposed gap can contain stale data instead of zeros. A
subsequent writeback can also send those stale bytes to the server.

Remember the destination size before sending the COPY request. After a
positive copy result, clear the gap from the old EOF to the copy start
before publishing the new size. Keep the existing invalidation of the
copied range. Apply the page-cache cleanup to non-DAX inodes and cover
both write-through and writeback-cache connections.

Fixes: 88bc7d5097a1 ("fuse: add support for copy_file_range()")
Reported-by: shaos <shawnq1@163.com>
Link: https://lore.kernel.org/r/20261020003429.1009226-1-shawnq1@163.com
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/fuse/file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d5e1cb53d86a6b35e63ca31b1065068ea5bdb6be..d3fa2bac9903acbd15cdbe9483fe3605f7ab5da5 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3000,6 +3000,7 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	struct fuse_copy_file_range_out outarg_64;
 	u64 bytes_copied;
 	ssize_t err;
+	loff_t oldsize;
 	/* mark unstable when write-back is not used, and file_out gets
 	 * extended */
 	bool is_unstable = (!fc->writeback_cache) &&
@@ -3047,6 +3048,8 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	if (err)
 		goto out;
 
+	oldsize = i_size_read(inode_out);
+
 	if (is_unstable)
 		set_bit(FUSE_I_SIZE_UNSTABLE, &fi_out->state);
 
@@ -3087,6 +3090,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 		goto out;
 	}
 
+	if (bytes_copied && !IS_DAX(inode_out) && pos_out > oldsize)
+		truncate_pagecache_range(inode_out, oldsize, pos_out - 1);
+
 	if (bytes_copied)
 		invalidate_inode_pages2_range(inode_out->i_mapping,
 					      pos_out >> PAGE_SHIFT,

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.43.0
