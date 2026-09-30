Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1F621E097
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738172; cv=none; b=cl63htubY2gt5RtPElJTkFmYOUwYLSmeDJw2k/Z+HC0G35sjvmxMe03uTRk+5oVimo8lDYsfeFs0zDq5Fwip4GjRWxL39/tJpJTav3e2oFBvC3yWrxvH3AAXpNONL54REdsW9Xjp5WaRmbl5TRlF0JfgcIWIOyX/MxxBz5x2tfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738172; c=relaxed/simple;
	bh=roecPC4KNfRBgR7bV/ESvlsnTUyjo5wG2Hm0Hg0DTg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUlGoTi38X2/GkPw1+0JbqkAHhRYgTp/gnESKLxBtlfjZCPysnMMOD5pBplUIKy4QPC/mEASBvqF3jL2+6bGLLMDr2Z5+mUV6kfxOPOheUaDCOr7TcbmbCTSZgNRUoCeBPJF6YFnf3NBma2tYAcNjo69j72IuBZ1ocuRq8pHtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESilTwaO; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESilTwaO"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4805e15cfso1410872a91.0
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738169; x=1791342969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0KXgNpEX25c+Amu+sqbzUoyIr1sz44/W+AZ1ZSlYE64=;
        b=ESilTwaOYnVYfJwiAsvEMNbDpUGKF+P8/M1X6CEuuvzU3WMUKXOfU7sMOQh4OEKsvE
         Mp45MGyJSktlBsOI5UafCT8FyFwCYfGgF8Mc7HK2IlVXPQWiwGR8efwQQRf+Jt0PbHLI
         KxbAevxmpxsqwWz2sHeMITDkctUDbIT56ZgHhuBHVlTDri8QDFygxQIwHePwBpi13Q8J
         twfGQszHYqpZCS0jM1Bq2j6HNIlzOypRWPpKr1h0FEffumj5vKivvTi4O2tF41ZKgq13
         s9btjx3Dj6GRSuq2q/se1AZ9BKx0G2JslT4yTo8I4G427g+hMM5k6lg9PthgJxHSFC2b
         y1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738169; x=1791342969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0KXgNpEX25c+Amu+sqbzUoyIr1sz44/W+AZ1ZSlYE64=;
        b=Qpi+jhSrUY8nH+8u2bv5qSgmBJkN9sYh0nEsJha/0alOW5hokx6UrX+batkxlus8Jm
         uLVQT2uGvuNPiGw2ST6nFpapgrTLQa2RU95XcKCpb5UpBM0CH5ZVKvM9IAxapYtgX7Hi
         OTdWQHzWVt1vD7IOdinIcdU5LkKrqQmJeEU5qoKzwqNwI0z1WhU+3R8trpiSg2PXKuEd
         MD2QwjDNXgqER1F9+OxlpNmWSuY5XtF8145nw71yNflKmU8hDFueKI2rRquikueaDFnb
         SICvtfkNLwEVqjRrF2WdNpk3wIxPv0LniWYUavv2Fak5vDbnmpqcdWBOX0UgwHkXYpTR
         x26Q==
X-Forwarded-Encrypted: i=1; AKwUvBxyopNvqrPIa0FNopw9ac89rrzH0i6LlBH2PKQOz1rnkuIrPlZnNq9kPLwYGK2Z/LRXD3GgRqk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJPAr5Jdx4cYSr/pfc74WTdP2oun37ZWidsshxwVCeZzwPBUyoN
	cjkl1M49dhg7SNqGPO54C4v2pVyoFe3rMJlFjaTHEAXCHUKZNqYGkDiU
X-Gm-Gg: AYBFou1cV/oYD3cBfzypeizeIxRWTyNtryH5rIDL6s6UREA0XTJ3hLTyDURZna3j19N
	VRKRh5M6LdQRkCNqOpNLkcbsto2EmF4sBhTETRXD44vtn0mnWcTyLWzZ0NAbU+J3FD5IEXttTkA
	Nff7Wd1dPcWQLnCR2GT0nkwWN/jmoYD/YF0d4FAyGqu0DjFSzkoP1xW57vUJ0ZXj+J4ii1s4A29
	+ChI4zznnXErJ0EmK4LF4wt5O34YcDKgfKb1X10eow58R7l1XOnGGZA4o5fgRZFL30htZBg97yy
	aHybzEAXs2w5p3fWfrm1UR/KQJ20j2M+H2F04wXIYCE9cYY9Z/QwGElxPn9prukuEZbPIRhlhq3
	Zo9Z5lPP2rFcXo9Tg29dQo2HrVyYMJqam5WT2gd7NHgl/m2fcm1b72M2s/NlDcN+pm7V/kDWOB1
	0oIoejKRzH2mURTVlku/sFTziFwj7r3a918IlraZ/89ZSP2HJskice7NF2GenqLRa6P5NUrhxV7
	bbBYpZNI8WnnEblmACdcBPnv9h9b6z4/EriEIzXh2Y6jppIfV0xylK6n7UgaYlDLEDzAJ0G7m9o
	3FDQXL40nA==
X-Received: by 2002:a17:90b:3ec2:b0:3a0:b223:683e with SMTP id 98e67ed59e1d1-3a4d18bdcafmr79615a91.48.1790738168850;
        Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:08 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 4/6] qnx6: release bh2/bh1 on active superblock selection in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 03:16:02 +0000
Message-ID: <20260930031604.70544-5-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
In-Reply-To: <20260924073920.2782917-1-benquike@gmail.com>
References: <20260924073920.2782917-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In qnx6_mmi_fill_super(), when selecting active superblock 1 or 2,
brelse(bh2) or brelse(bh1) is called without resetting bh2 or bh1 to
NULL. If memory allocation for qsb fails or a checksum error occurs
later, label out: calls brelse(bh1) and brelse(bh2), causing a double
free.

Clear bh2 = NULL and bh1 = NULL after releasing the inactive buffer head
in qnx6_mmi_fill_super().

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting an MMI QNX6 filesystem: verified
that inactive superblock pointers are cleared on selection, avoiding
double brelse() when error handling unwinds.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/super_mmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index b8afb6f388b2..797d8c238bbb 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -118,6 +118,7 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		sbi->sb_buf = bh1;
 		sbi->sb = (struct qnx6_super_block *)bh1->b_data;
 		brelse(bh2);
+		bh2 = NULL;
 		pr_info("superblock #1 active\n");
 	} else {
 		/* superblock #2 active */
@@ -130,6 +131,7 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		sbi->sb_buf = bh2;
 		sbi->sb = (struct qnx6_super_block *)bh2->b_data;
 		brelse(bh1);
+		bh1 = NULL;
 		pr_info("superblock #2 active\n");
 	}
 	kfree(qsb);
-- 
2.55.0.1082.g2b9226bbc0-goog
