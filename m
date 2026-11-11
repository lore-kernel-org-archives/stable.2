Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362016;
	b=d5794yr7B1cCyOrfkvKh0IZPOmbzJ97q8k1UyjchDBPRd4sLgVecysfGkMFrixXmAfYt
	 vCVUkqjnk4jet1ndQhEbsiJ/xV4EDXZdXtrMo8Co6ZB9py1xGuIzSgSAGrP5f/XPOlXrv
	 OV6RndEaseqD64REbPVFH3IbEOJSDksKmkalRJ7ko+KSoecpI1DV4k+ihJ1geAONo+rFv
	 cP31eZfw2KegT1U9XKo5Nu4FkJAWhUV39eZ32rwgF3rPKx1iQcZ5qW9HcZ1/cpjqCCiUL
	 aFJlVE3654E2NGBvrFH/a5//UR+qisUFhFjoB0mk1gzzMQ0KIqSV3IuJjzAVhmXZc7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hpmyh8KhbTvFItUU/X52N8b9ibqwoW61tSaPJ5uqD4M=;
	b=ry0tBiezg10hAk+DBv7NQksvk737A1f5nCqpF2AUXQZe4DI1f5weGgob69FgVOb8O+U9
	 9MfJCrq3t3SKtxq3QaFGpkNi6HWOgN2D+4s3GBJl5zppDjrJLL8sEa0glWuXKufYpy8Ax
	 V9UBHQvDGm4qpHkQGHczCDPegwSHRgrX2oi5O0qBZFr84pCM0kSHCKABHxuyMsEP1WClN
	 lqQFnkGsP0t9JK1U0T12L+hWDoaGiSsSlcXZ2wyic9Qe7unSoq2qxhAcsLDqrD2SbppWv
	 sCSQ/eH3XDWiptpfwFNG47sKBDcJ2c0qJ+lJYECOGq0DFVLN4ftxdZmNS+6B15/F+4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZTolEtz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47184606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TZTolEtz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CC11F0089F;
	Wed, 11 Nov 2026 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362015;
	bh=Hpmyh8KhbTvFItUU/X52N8b9ibqwoW61tSaPJ5uqD4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TZTolEtzSjVItsCfZiDfn6Bjg3HhkXUcAW1ercxadxmTtz1V5IWu+jUTa10TrnjUU
	 jN89YQ5o7I+Fx1tvRnhzJk4JVMktzIxPBMsEKcQWxtMAVhdybbytvX6mKdBp+akLRL
	 4tiuJvK3b3mGNWDulF0Qxy3KQnQK6+FFKGKmMopy+Tj+DoE62o+1xwd4lkvr1Y393x
	 5yfEbeqkkbRtnUnZfHJN3v+WYfwcXz79+9BJy7HaJS3FG5oL5l+SlZg+LtuI7KylwU
	 Y4umyN+bGwfmVlhkuRV4DpLtR6xDDRNMSJnVe4kisXgkrHomBUMYmmpGayZL/la1Bc
	 kVvtMIz0LYkXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] nvmem: rockchip-otp: alloc clks with main struct
Date: Tue, 10 Nov 2026 20:53:33 -0500
Message-ID: <20261111015225.442438-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050959-failed-6.18-9fc6a1592d84@kernel.org>
References: <20261107050959-failed-6.18-9fc6a1592d84@kernel.org>
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

From: Rosen Penev <rosenp@gmail.com>

[ Upstream commit 9f99bb979f930e52e6861114fe03535d4bc2f374 ]

Use a flexible array member to simplify allocation slightly. No need for
a separate calloc.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530205333.117458-3-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 9fc6a1592d84 ("nvmem: rockchip-otp: Serialize reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index d88f12c532426..00921b9fe9aae 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -77,9 +77,9 @@ struct rockchip_data {
 struct rockchip_otp {
 	struct device *dev;
 	void __iomem *base;
-	struct clk_bulk_data *clks;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	struct clk_bulk_data clks[];
 };
 
 static int rockchip_otp_reset(struct rockchip_otp *otp)
@@ -327,7 +327,7 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (!data)
 		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
 
-	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
+	otp = devm_kzalloc(&pdev->dev, struct_size(otp, clks, data->num_clks),
 			   GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
@@ -339,11 +339,6 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(otp->base),
 				     "failed to ioremap resource\n");
 
-	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
-				 GFP_KERNEL);
-	if (!otp->clks)
-		return -ENOMEM;
-
 	for (i = 0; i < data->num_clks; ++i)
 		otp->clks[i].id = data->clks[i];
 
-- 
2.53.0

