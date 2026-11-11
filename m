Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362864;
	b=A15Dxkp0rMtDoKz7usA3KbBoaeQxDVL025vtrpmQ/njCiwRqcOyEGwGB0A6SOQgpHkYQ
	 2P5yR1gKYEQY6KQ9l4MqMWZkgIR+kU5JkKyEvBdgpjrylsI6itNNtfcR+qCiTDw3ztJwW
	 3fJ98KH0S7fQmNhvNklrhrEntVpu4obAK2lEaIi8MRcbZ2qOs7EqJFgNO+ILDm6I19EZu
	 52+Zpxand53wzVsy8HRk7laW+EQTfLriWAkzR7ENstopwd6I1VMgJ1cl+XMvoCYie9a8K
	 dEhv7hdYvwYXD/fuGwYcWX4SUwf9LzBfie9HyC++RKrO/H4pYNA5IC8tOyO7KLchREw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xOT5gpvgv2YbkWv6OCXdTN4n6EZlXcqBb8X4Ehy/LYw=;
	b=l6HM4W+3AG1a0pIh1Fp4grYiRNG453gK6uh9IrRrD50mSMinsgZoL/NtFPB+oQ0jIxhL
	 OSLDBPjT22w2imIlO2rC4vqR+XnOhhRU089081v9xh8OSWdkXYzVdEHEwAH9EuSjf2q7d
	 EsH/Lz9jFHedlGt5h7P4rPQs1zJEWMIOSHBaESDKyOTSOaOy+vhRGHkEaf2BAY/pmc0x7
	 UInptcWjHqT2m+kF4cijC/ChqBZ17mIlMO8+NXSH0LEoRZ7xZFhpj+6NG3cMNbogxLY17
	 o5sB0n0p49MtyGcZ10B2nRQUAyT3KEsDq1zyOkXyRK3AoDMSwKW1mule1gUPV4/kwfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnUPpQ8e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C34C606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fnUPpQ8e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15ADA1F0093C;
	Wed, 11 Nov 2026 02:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362863;
	bh=xOT5gpvgv2YbkWv6OCXdTN4n6EZlXcqBb8X4Ehy/LYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fnUPpQ8epGRzMuZScBSHehuXy91jFczgQQo3+0zpMdZvDO3AlxUXnVocLfa7cgO4g
	 36+/PSvbSO5hP71PDxBG/WKyUbZP2j91b6OQu7HLn/Gj7SdYTgzsuhCYWrpRzqTJxI
	 QnnvIJvSRAq5c8i2GjwefxVwhMs0FCEFWz9KmCBNzqp++ZVPN2tGHZtMYnKXZhu1PK
	 YdtG1dGr4fwjmYVUH7/Jea9iqQ0L8F1jRrzyF1SAVf94UZ0kBI+R76sQovRmZdMZcR
	 z3MOetW2u7ohRXPzqcaRDSuK+LM7+L5/gZZtovpXf+ONU+0bBVrWaNrQeKojVNgJFb
	 3yGAd0xYX7+Nw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nvmem: rockchip-otp: alloc clks with main struct
Date: Tue, 10 Nov 2026 21:07:40 -0500
Message-ID: <20261111020643.543837-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053315-failed-6.6-9fc6a1592d84@kernel.org>
References: <20261107053315-failed-6.6-9fc6a1592d84@kernel.org>
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
index c6684ab14e742..f5b7d3f6986b5 100644
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
@@ -326,7 +326,7 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (!data)
 		return dev_err_probe(dev, -EINVAL, "failed to get match data\n");
 
-	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
+	otp = devm_kzalloc(&pdev->dev, struct_size(otp, clks, data->num_clks),
 			   GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
@@ -338,11 +338,6 @@ static int rockchip_otp_probe(struct platform_device *pdev)
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

