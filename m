Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB481400996
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785156742; cv=none; b=ItnhhBrHjIWKqYsOXuqhTRupstDnmQN9UPyUyzXyxvN2Qf5omDnfDKcqhwYzft+rkKQCwXLgMjVY4UkGay4xKojfpoFbzKN9ZBt9ocvMR34LQZbhNdeJcZrUHwYe6ynkQ7ep9pWArOie3HvwjxyRzp994wetRXjVLVoct9R0gc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785156742; c=relaxed/simple;
	bh=Mk+aSmRtnc7VXZ1Sj0oftf32acPUng9c8JpD9JPtNbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MejfRgwes4zhiE3LqLDN8izNXCCqQGZyk8vCjl9Ud9ibSzjWxBPSMYxfUQg/LF3pBNGVyxj5+RS/Z6NbhTjjGX/IlvM/aZAn4IB8s3YX5OBijm7AMAvmERJSCmfuhCs3X8LFm9m/MoUrDP6gDSxcjnmmpFVdaHrkuH2dsDSaAEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqUrykoT; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqUrykoT"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ceb096e675so31106685ad.0
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 05:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785156740; x=1785761540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5rmvb0S4tEI37DfKVdNdDGK3575sQGIUhWUSJ2ESEpw=;
        b=CqUrykoT3wtf6vyKTG7VZyEo8sE4Y1phu6bO5ERarMvYoQK8rMUQMjcVlRDYH2i7Wh
         8mZsBtE1QfYSrfFf4V3z5YsW5KIJ+fSeeZ6O7FgpNF+CCKkLZItmRfLBFw9sA8bE10GH
         mjZeHx23lmAZ4T9gZ7SHXxQGHmifyX2qifgg+TyMDm8U7gvf92X+PWoLc4bhTY3RXAnI
         qhcRd2jjyZb3jaebyb/y0iDa5NGJPBayEz0sAvFWWs21kjX4aZtanBHy5dVNJwAeKAfp
         Svbj9PrBVzxNe1n5k2Ub7dkVsy+5WVF8ub7zQBeMcPuRh3b3w5To8zvrfUh+MhkO6GNd
         K85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785156740; x=1785761540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5rmvb0S4tEI37DfKVdNdDGK3575sQGIUhWUSJ2ESEpw=;
        b=TzSOY2CJpN33KPPTNweYAnCYaen999PJ26ESuQAha5JxgR4SV9KKLW9YnZjF4arp2y
         TxXdtKHvCoBqp4m2xh4z1mPT5nz//wbfYPBtize53uWI9H6gtn1RnBcohjxkp/nSfxcq
         CChBHdfNHuUj+zPS01g8jdeORTSWPUtDd2WcjZKeAEFRjVzMFT6lVjvLNWGbStef34Ar
         1UMO+sUd/uSBEdr9wDkzEVCjBm8eZeQEC0Ch1uK9EhSKqrl0ECxdS2joYQXKHRvs2+Qd
         l6wimsHaY/SuJLhc1fQxeNqbLZ63ce2BP/gesbiKpja8Sh5SR9RvO8N+Zb7LE3tkr1o+
         yppw==
X-Gm-Message-State: AOJu0Yw5gZCIvfMTSvQGTl29XtE1o15VdfVF8KOQnXboiTxChrYR/7n0
	BsfBcs8b8ua0mr/dxSTVaWR9RohD9humdKt7od+I0jlgTbw0g6gwViG0
X-Gm-Gg: AR+sD12JX1riwun/6+5j2G59drDoDeEBnx/hyXBgxUrmYExBVO16Fmk1t40o4R4yKmg
	M9x2aWUydAZM2hwRlJkm3+TOGpn/IyTw6uW6KpMUHPnvddeYL10eMW5IvLaZRCJGoyIqzP16BAN
	wyWNvZPzkA8BWbdoVArKMaVoEf7spufNjg/kfYaUd3PQ/cLc61+1PYXpZMslq6YWwt/pjJ2Yofk
	xr5L6PnU+50Go0FCDNFz5XhNuJSX48/TsaUP/nxMkOTitgy0gw4CBxyudPYF74d+My2sAYvLmJ9
	m9/j7fsevBFf9AD4O9guw+Uv9akrmNjnpGkUCixM5zPDcknbwIgc8douCFZLrOnmpfhgyzYXjNm
	72cGd1yJxr6kL5BPB5DaF7XzH+gqhDL6ddEi+Di/i1uQPsShGrNPOTSoLks36e4oSFdeHW2U567
	rNuqKh46gmgcpB5uJ/D2cNhvhxPXxoLn+i1GBJ8C6+R4WY
X-Received: by 2002:a17:902:ecd0:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2cfde85f81bmr79315895ad.23.1785156739927;
        Mon, 27 Jul 2026 05:52:19 -0700 (PDT)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde81dcc1sm35033385ad.84.2026.07.27.05.52.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 05:52:19 -0700 (PDT)
From: Lin Jiapeng <ljp1205831794@gmail.com>
X-Google-Original-From: Lin Jiapeng <jiapenglin@tencent.com>
To: cem@kernel.org,
	linux-xfs@vger.kernel.org
Cc: stable@vger.kernel.org,
	jiapenglin@tencent.com
Subject: [PATCH] xfs: fix exchange-range reflink flag clearing issue with  INO1_WRITTEN
Date: Mon, 27 Jul 2026 20:52:03 +0800
Message-ID: <20260727125210.28329-1-jiapenglin@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When exchanging two full-file ranges, xmi_can_exchange_reflink_flags()
can move the reflink inode flag from the file that currently has it to
the other file, as long as exactly one side is marked.  This assumes
that the file contents, and therefore all shared extents, are exchanged.

That assumption is not true when XFS_EXCHMAPS_INO1_WRITTEN is set.
xfs_exchmaps_can_skip_mapping() can skip hole and unwritten mappings
from file1, so an exchange can complete without moving every mapping
that the earlier flag-swap decision accounted for.  In that case the
post-operation cleanup can clear the reflink flag from an inode that
still owns shared written extents.  Later writes then take the
non-reflink write path and may update blocks that should still have
been protected by CoW, which shows up as data corruption between
reflink-related files.

Fix this by disabling the reflink flag exchange whenever
XFS_EXCHMAPS_INO1_WRITTEN is requested.  The contents exchange can still
proceed; the conservative outcome is that both inodes keep the reflink
flag.  The regular reflink flag cleanup path can drop the extra flag
later once the inode no longer has shared extents.

Reported-by: Lin Jiapeng(TencentOS Red Team) <jiapenglin@tencent.com>
Fixes: 966ceafc7a43 ("xfs: create deferred log items for file mapping exchanges")
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 fs/xfs/libxfs/xfs_exchmaps.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/xfs/libxfs/xfs_exchmaps.c b/fs/xfs/libxfs/xfs_exchmaps.c
index dcd0bd0b13b4..3efed37cb98a 100644
--- a/fs/xfs/libxfs/xfs_exchmaps.c
+++ b/fs/xfs/libxfs/xfs_exchmaps.c
@@ -959,6 +959,16 @@ xmi_can_exchange_reflink_flags(
 {
 	struct xfs_mount		*mp = req->ip1->i_mount;
 
+	/*
+	 * The INO1_WRITTEN optimization can skip exchanging hole and
+	 * unwritten mappings, which means we cannot guarantee that all
+	 * shared extents actually moved to the other file.  Clearing the
+	 * reflink flag of an inode that still holds shared extents breaks
+	 * the CoW write path, so refuse to exchange the flags in that case.
+	 */
+	if (req->flags & XFS_EXCHMAPS_INO1_WRITTEN)
+		return false;
+
 	if (hweight32(reflink_state) != 1)
 		return false;
 	if (req->startoff1 != 0 || req->startoff2 != 0)
-- 
2.50.1 (Apple Git-155)

