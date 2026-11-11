Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362359;
	b=pFkonMYtYWsor7A5gh2oz6ome0Qio7xZPXAeb7VOy1+cr4BLUkwS2Ex9EAnQydOdY8jN
	 kQpevx33zJbZ8i0sdcX0aTm011F+VrBeFb/qQS9BKs+c2BdXauNlntc+CC54go0xxyRkA
	 A26fIC60Ssr3rB6UurK0X2erLnDqu0m3QoiNYcy79Hzd3qhTKMHhpR0VmgnKG9mx7RXJP
	 /x2fWUhuAtQpAY77Iz5YCizC24+YRfu/bsRnBteAtP5KDx+xDw1tb8rmqRwVOdtUjEGRA
	 QUbDxY8CozYTCf8vJCyIF3+Jn31eX0i6u8gYHAXzitDWe0VdXggRQ5jg4sc8aCsSJfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362359;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Hpmyh8KhbTvFItUU/X52N8b9ibqwoW61tSaPJ5uqD4M=;
	b=TQzFVKFejJfUhHZ2CTN/vSwzifKmd2U0PBMOW6pKvxjrA29bjC6GhtyR22njOJPHo5Wh
	 NTtzVuCqdu49NXZRuQkmy0jwbwcjjqT/LgxuF75KYCGgs9HRerYo60mPqWnG7quXfv2YJ
	 7s7MEjwoxi1UaRDO4tvtGGeJnGBElOp7ImkLzeiydM3tSiARheP4TkCe7CHd6H8vRmI7G
	 yJ0Ky9AQYxX1NRWsIRxP+wWWGfqATJMUGryyEtFVYG4mo7NKXsAPELrVMRmT8B9n39z9D
	 MwKlkmuXBTgTz5sPXDctlaETGFWs53PFwHl/UgGtBJmbwm6p6gZo5Ya7BSSWyg2i3NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="RM/QeU0B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E03606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RM/QeU0B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 826EA1F0089F;
	Wed, 11 Nov 2026 01:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362359;
	bh=Hpmyh8KhbTvFItUU/X52N8b9ibqwoW61tSaPJ5uqD4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RM/QeU0BIPN/pV77UupC3qyZeIAqqcGOEVSXeBsCSroEPIA9G8RukYcN6R3HytqX+
	 wgrYBWnyvGcnORB97RkhJOFnIptsKoT9VSLdt6KA21R6czaChrbMUAOr3s/x9EjCgg
	 Bp3QXxXUjyI69cgzjnddtIRs+zXsGyKhWZ/HXQiCOkWNeQCCoswDCDedyuCBpAm/nP
	 As9cGHmSw4TuUqi1H1vcR3HsHABuHHspSRPOal/loDThLYvIwApQqawFspiPjDYbkN
	 Sd9HJ8L5H+Tfe6WP/x2iNhRQ0IRmEkjhtyjTgrz4Xi8rx3DMJHNjFfu5LztQHQRJ8y
	 mtSyk5Ic/b49w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] nvmem: rockchip-otp: alloc clks with main struct
Date: Tue, 10 Nov 2026 20:59:16 -0500
Message-ID: <20261111015901.481553-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052051-failed-6.12-9fc6a1592d84@kernel.org>
References: <20261107052051-failed-6.12-9fc6a1592d84@kernel.org>
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

