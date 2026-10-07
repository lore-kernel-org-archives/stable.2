Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796213C1D62
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791362334; cv=none; b=GATl/d9iIjID8zYIf4pBjDtzlt0uZk4X1UGrnoGDtqBj6UmKFhfYgEAcID9+6Fqi1VS3HsR4JVdHG5uetLf0EJPis9xJIXLjvNv0Lbq2Bdh9pTiVUJMY0wyTmab5s6GQtZkYUUCtouyLU7lqFrwDg0enFWb098SxtJuW4+KPcR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791362334; c=relaxed/simple;
	bh=Lr9vcYwkNUrCAHbDEL6/H4UYL6nkVVf4skXto01Lhq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R99ZiaXjNTiFadmqaeQ99SfHmvLf+kyrgP9tsuwJyqL+AbKatkhnlkJNLTLBxjuiQcQspq1L9ycZ5xorbpwF5XTRKEFNevGbCgRJXB9uw+WFIDJA3fFgpwWyG4G/RkBT+jt4dMmSKLtimOhmv3UOV2kqPtdYImM7Io42Or6eCAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0Zypk4a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0Zypk4a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D006C1F0089B;
	Wed,  7 Oct 2026 08:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791362331;
	bh=djdlY4i50mOgUmrlq80twj8A5uliu42VZnlKf5ysf6I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0Zypk4a92uOajxW8gQcsYQEoUtSqlB4SxC1NYNBNJxRST4lPTMxq2k+bIJvk0NY8
	 nOtBouBUEmNiI1yxeeHD1u+lIpXByzNOdD9i5a7y0X29xF+xeIo6SrW9JepvMHhYi6
	 cwMtndmup+5tFHSh9v4GckDG2nCrLy00+zH/g2D7DcEHPWe92/cX0a2Mr/Q9igy1GF
	 i5Kb88CVoxafE5d8Rl4z/U/Mwx/xo+4RHWOi318r4UDIavgyZnvXzGMblmxht1BC/X
	 0+gXAbWRGjUtGQgko/Ph1feihS+MkalCBW8n4NraUSUP8zCNPaEnysKxKXli0URMJk
	 Sps90jrXZu05g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] iio: adc: aspeed: propagate reset deassert errors
Date: Wed,  7 Oct 2026 04:38:48 -0400
Message-ID: <20261007083727.1934265-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100601-tartly-curing-0008@gregkh>
References: <2026100601-tartly-curing-0008@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 95e4eb426b4bd666fa2f37886c0ddf74a0cc6167 ]

aspeed_adc_probe() continues to register ADC resources after deasserting
the shared reset, even if the reset controller reports a failure.

A failed deassertion leaves the hardware unavailable, so stop probing
before installing the cleanup action and enabling the ADC.

Fixes: edf7550a1f93 ("iio: adc: aspeed: Deassert reset in probe")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Changed the direct error return to a jump to the existing reset_error label. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/aspeed_adc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
index 34ec0c28b2dff..012cc9291bef3 100644
--- a/drivers/iio/adc/aspeed_adc.c
+++ b/drivers/iio/adc/aspeed_adc.c
@@ -221,7 +221,9 @@ static int aspeed_adc_probe(struct platform_device *pdev)
 		ret = PTR_ERR(data->rst);
 		goto reset_error;
 	}
-	reset_control_deassert(data->rst);
+	ret = reset_control_deassert(data->rst);
+	if (ret)
+		goto reset_error;
 
 	model_data = of_device_get_match_data(&pdev->dev);
 
-- 
2.53.0

