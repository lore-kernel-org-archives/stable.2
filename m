Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F9337A83F
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 03:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790738173; cv=none; b=qE5alvRxXk/dtpZdQlGIiPOYPw0DoHolpdRNvX6S5UvpqYU343IQuq4HVH3fj6Hf9YkNfSwlCTK1TbL5xaohDQZ/NLAj78azxWg4ygosM5PKn9ppLgC1P3o6n03ZcNv3AzlGlQmMHg7+Ty4Yz6uQFCk3XY946JBf02DvJhUeI6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790738173; c=relaxed/simple;
	bh=cCh5Yyrw+WTMc8LZj6fD2Tm+WKPAQKfaSqn6wwbd9no=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvUsJe4Cxm6q9uko9rhhnac18oMnIS/5iJbqH+cMFgEZSinB+tOSEbqT51tegmw189cYdvB9a9NU1HKRNIkflRS+FcIyJ/eVTd7V63KWzvuv6o2sR0pRQPJgevCVOdbNuAUTnet1imLuTBBkZedhcQEif0lRqdgqh52EcUMZa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YDp0XEMy; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YDp0XEMy"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc4cdc0d663so2017698a12.3
        for <stable@vger.kernel.org>; Tue, 29 Sep 2026 20:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790738170; x=1791342970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvCQxPtK7+AK7DvJPFUusYMdwxE4hgp8/u1LNz01hVY=;
        b=YDp0XEMyh/5RYiT7rZNaffXMRuK7G3FPz3AXgBriNThCzs2FOTdJcBCapZuKD/krK5
         4wXkPcVkKX+ECANwQYuntiEjHaB9sorlZc9dG3GqjOUOqFTHXX4Qf6eHqWIhqexhPzH8
         Gksd8G+glexXTDABU1LuDfgY04W/i02Jzwnp3VjzPJxoPjgwy3rgYQ1vJTpBz2yBU2Sm
         akF3B2bolNjgdNUrO6wnUOqIbbxuAJB7M1hZx7urKiV6rsFXvaMRyh6/Xx4XpikqV/4m
         37wAdr1gNSCMDGSsoF31PbQFI/Omho25kgYkgVaU8/j+VLApXu4yirLbrTKsf+d3gLvz
         B+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790738170; x=1791342970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kvCQxPtK7+AK7DvJPFUusYMdwxE4hgp8/u1LNz01hVY=;
        b=kZQ0QNX2jLGCpK1+kg3MHPq7JAvT/awEcwQcDkyaiEGDz1nTnxcsEBUuhkMik3nwRT
         ArO4UcvyZN4CdBHzSShQ1F2ZYBcBbu7JkOzEvWKzS0cfQQQwdMEB6c3CzIfI9M8Bpbmi
         pcdZeXjGtag07R3NC1EwcJc6wIOf4pGiyYtZ71VdjaVHnoxIcwWqEO2yX2dNTZbxakmA
         S3fs6L2eu76nOpmzNmFWk85N4R32wsT4Ugt9z717hmc6fAcGshp3Yu8cld/FOCDAKULV
         q7Mb9Hvd7Goxx58Sd31GE6xrx2cadpFdcYPKl7x7QwJTQsoa5zA2mwdcSnitYWUMAtAR
         xktg==
X-Forwarded-Encrypted: i=1; AKwUvBylwVsy1PwYv4fjU6i5MJQR6khHPbjPDbF2Rcb+YOp2wjtpLSurlOYibKtfSBxRDEYTxSEeg7g=@vger.kernel.org
X-Gm-Message-State: AFq9FYIwOyjI+95Nn81hM27PWhVQT3aI2xqsY0jm8sfTbTfNG66czPBf
	NCcdTdCR9wAe0N2JBKWkUiDcERMSGAT+GPogWPeAtncx4H/kVtIClHL9XXvP4Fcs
X-Gm-Gg: AYBFou2DkZ907ONzPuUiD72TA9nPwi5gdqA4T0skYbY6nGhcjQ8CbKx63+/dyjTlTcA
	UEJ/68fu4XqlIlZdSd6bWuS9fBZR61CO9t9d1ONdGxBkY8/K6gIgWbPrxaiqBj5tp52EROoOo+5
	3kCUJxUnur3fmCSODr6uGOUsqUDiMbepUzT3lhw3Q7GPsGOQQitE3eDAXomPWTfl9Plgv5sh0BB
	a4kMtx9na4lGSZVSDdrXUxlvzAczoYMY4kUJ6DKhdUJpKO0rn6ZZJvEHT6bzmX9MYGyAFf8E29P
	yISK+7JmtYLVFv5JD0Li5ix4a+MtDd3HIRzxdv+iKDAtBVnzQQw7EOjWRxZkmcRVn/+VOq62Y85
	Vhvz4xwmcmbMvHwTmHVjshIFpNC3DELCiljieoYpFjjnaDFXLT3nqE42mr/0SxzvSL5Dm6UVVT+
	AN7rzoAnFBB/0LHmME34zYE5xdLtbqwMI2XnfMcN8VALgf6MEiAdbhdMGTwbcYlHVFnNDhMjbE0
	xyN/HPbIuUtqNz37N9EcR3qZjTVZA6uonUkFgRY2ujT+pRsYHlMFHUbZJx16XX/RoDRmWlYjn00
	UupR7ONYrw==
X-Received: by 2002:a17:90b:2888:b0:3a0:9c9d:eb0b with SMTP id 98e67ed59e1d1-3a4d19262ddmr104610a91.58.1790738170170;
        Tue, 29 Sep 2026 20:16:10 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (25.187.82.34.bc.googleusercontent.com. [34.82.187.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ce1c9045sm588743a91.12.2026.09.29.20.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 20:16:09 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Anders Larsen <al@alarsen.net>
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH v4 6/6] qnx6: validate sb_blocksize before dividing in qnx6_mmi_fill_super()
Date: Wed, 30 Sep 2026 03:16:04 +0000
Message-ID: <20260930031604.70544-7-benquike@gmail.com>
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

In qnx6_mmi_fill_super(), sb1->sb_blocksize is read from disk and used as a
divisor in QNX6_SUPERBLOCK_AREA / fs32_to_cpu(sbi, sb1->sb_blocksize). If
sb1->sb_blocksize is 0, it causes a division by zero in kernel space.

Validate sb1->sb_blocksize is non-zero before performing the division and
abort mount if it is zero.

Tested in QEMU against tip of mainline commit 62f4c998b297 ("Merge tag 'parisc-for-7.3-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux")
using a loop-device reproducer mounting an image with sb_blocksize = 0:
verified that mount is rejected cleanly with -EINVAL (rc=-1 errno=22)
before division occurs.

Fixes: 5d026c724220 ("fs: initial qnx6fs addition")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Rebased cleanly onto upstream mainline commit 62f4c998b297.
- Added QEMU test procedure and verification details in commit message body.

 fs/qnx6/super_mmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/qnx6/super_mmi.c b/fs/qnx6/super_mmi.c
index 5f62df30467b..5d41f028bf80 100644
--- a/fs/qnx6/super_mmi.c
+++ b/fs/qnx6/super_mmi.c
@@ -63,6 +63,11 @@ struct qnx6_super_block *qnx6_mmi_fill_super(struct super_block *s, int silent)
 		goto out;
 	}
 
+	if (!fs32_to_cpu(sbi, sb1->sb_blocksize)) {
+		pr_err("invalid blocksize 0 in superblock #1\n");
+		goto out;
+	}
+
 	/* calculate second superblock blocknumber */
 	offset = fs32_to_cpu(sbi, sb1->sb_num_blocks) + QNX6_SUPERBLOCK_AREA /
 					fs32_to_cpu(sbi, sb1->sb_blocksize);
-- 
2.55.0.1082.g2b9226bbc0-goog
