Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1037F5372D5
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790075061; cv=none; b=fEju/WuPCfVMeAOoysQk6TpTel3iHeTcs7NBMQ3yh3LimMnLozFWrh4m6SHnVwF1vnq2prAOCC6Yzuk/fQG1CJHzpLARarli50XS0vWFfofvcWC1hkusyBz/cz6YU0ApSJD903A8RHDQZyk3YU5vjoJTtkwLEHGTajYAUcAcL4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790075061; c=relaxed/simple;
	bh=x/SDQx8QLbnBSbP8zjWzBDv97EwW29fLkrjE/jdjMhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cS96XyQIcnX7fwGpZI1OwSDA+LcpQOD9WCsPh8EqEvoUuzaF9mktG35LFe7ozXyVTwYx3+LgCZk+XonhbiQ+r6t6ZnHMqR4XLGpmLjKf6Ezg7PPb60rLgBJ4fGy0YfEXwr2zsbmac6O09Y9zsEMA3LU+r1oBxDASifEtEiL9UG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+Lef58i; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+Lef58i"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso11172615e9.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 04:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790075058; x=1790679858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hSVVDMjzEguiMUvpWG2niuIt11omSWzOqCLOFnzvVPY=;
        b=a+Lef58iI8OorBLeVk4l3HLpYmqrMQ7yK3IqlGK+0XE1kfBB+Pmo9Xk5NjmfxeL8BL
         Fc/OyCdqbvEZYojwdGZSW3QVcaiK5riGmq+sL+LqizwMFiXy2+6YzpHRO3pvBXZ+CJUW
         TA38Uv8A4rR9DhQ74jHfPBkMwPEcoO5EmlGKEhy5u6a0Klpd7j46g4DynhbzMdq2IEWt
         q4IQQFE01vPpETqUCJ92BkrgGEwT/RCsk2pyeAq9OHDaOfSQfKu/ycfzNcMKnBWrqEBd
         Mmhs1iohxF7AHC+piM+j1tpcPoJjGDz3sP8iBpcgZgX+Psu0abHjCj+oQf/ms3ttI5Yn
         8Ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790075058; x=1790679858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hSVVDMjzEguiMUvpWG2niuIt11omSWzOqCLOFnzvVPY=;
        b=1tU/FmdAgUBRkc5c2WbxSE77aA/buLsX970O0E01XdfXSUI6D1IUFPhZw5DE2Q6MUa
         G4dpgOX9QLgN37X2X1xYDG9c27SBvxhUusQa8c3b6+M+Gf+B7daEsvyC8VTYzTdaYSrz
         UifuTlqAcLFVHj28repTuCzq6d9dAse+kzYm2Mz+TaXDkIf7UY0fZkQllZn54SKiMphR
         QmGCaM1blHTHY1QYAo12O4lzieCprP3UCqYfhRx6YaNxFfYoHbDYlG7d0qE3HmDKCBUd
         eE7muVzEhPnjCFSVmuo9shHoEiIWEof17nQw7T4aa88MpUoY4PmLsIJ+hh7qupLXvU7n
         lNpQ==
X-Forwarded-Encrypted: i=1; AKwUvBywveKxZE6CG7STMEPnWkPsv7jtdupVklfMSctSu+u9C8V2UdO0DvrX8jEhA9tvRBFGsvpNc0M=@vger.kernel.org
X-Gm-Message-State: AFuF++k+86V1Kvmn8bFyQh1FLNgq8I6bN0XwtVVlQPWwVyzrGmS6q9Fj
	cHNYAdwANE/AMqRgSjPLYDebxg3X7ug9HmHGdDAE9Kv6s3ROj+/N7499
X-Gm-Gg: AYBFou1t19cEGkuSZQjWpVhzm5+WuweKrdkFeSPJ9OZhT60OsCHJESdPL1U+a9vxOtV
	yY54RuMqwB3hJpPSYeESf+iEEe8VJZibC3d3Ef645tBhwTH/KMZlhPMq+erXWdPVmpzOgix85WW
	n6OiOcSxp7iBBdGhD5DazFVX2xHDYD4/ywJ3ZsdaVbhxHhIybyQ0uyGFrbUcQZv1gqBEn1h6PKl
	tRiq2bgnj8MaYXHk1aB7KMvOj/GTWbpZJtPXAhoAjUDtfZSNZ6oogClvgVlCguiqTNgYiCo6n0t
	A+qUZwXRUW37HaUVSoGPzLzMHjluSSMv/KOA7MskCrZymXTKO5u6iSgL6dLq8F4jVNbFzg/MT+u
	yQ1vdMUFNXadtGGC83S+/wTcA5zI+7Y0ENnWsBnJkVYFzOTJ3REfw1zu1Ifr9jdfcNQp2x2MggV
	4q9tpBJ8IuqeKDuYWFoxuIRktc20HmJUMffZ4dZAz9NBUBOti2VnpGdjdaWgUSRzmbve9r9ayG1
	hh7tB7SJmmL
X-Received: by 2002:a05:600c:4515:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-49fd88534a9mr40122485e9.2.1790075058304;
        Tue, 22 Sep 2026 04:04:18 -0700 (PDT)
Received: from localhost.localdomain ([194.9.6.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fd8ccd185sm74611795e9.8.2026.09.22.04.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 04:04:18 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: hackerowskiy@gmail.com
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	stable@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>
Subject: [PATCH 07/26] xfs: check padding field in xfs_ioc_commit_range
Date: Tue, 22 Sep 2026 13:02:02 +0200
Message-ID: <20260922110221.1431-7-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922110221.1431-1-hackerowskiy@gmail.com>
References: <20260922110221.1431-1-hackerowskiy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

LOLLM points out that we don't check the ioctl padding field here, so
let's do that.  I don't think there are many users yet since exchrange
requires a new feature flag, so it's a good time to try to plug this
hole.

Cc: stable@vger.kernel.org # v6.12
Fixes: 398597c3ef7fb1 ("xfs: introduce new file range commit ioctls")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
---
 fs/xfs/xfs_exchrange.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_exchrange.c b/fs/xfs/xfs_exchrange.c
index c69ecd6a19de..07090487c581 100644
--- a/fs/xfs/xfs_exchrange.c
+++ b/fs/xfs/xfs_exchrange.c
@@ -902,7 +902,7 @@ xfs_ioc_commit_range(
 
 	if (copy_from_user(&args, argp, sizeof(args)))
 		return -EFAULT;
-	if (args.flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS)
+	if (args.pad || (args.flags & ~XFS_EXCHANGE_RANGE_ALL_FLAGS))
 		return -EINVAL;
 	if (kern_f->magic != XCR_FRESH_MAGIC)
 		return -EBUSY;
-- 
2.55.0

