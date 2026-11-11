Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363284;
	b=k3Iy0fmtPvSD4pWI1qBP6gDw5m77IF3z5ID7Lbmp9WKIuYz2WC8CYwvh1Kyry/08B0bq
	 U/Q4i2O+CFIDUaiJ3AT2am8DF1Vdjw1hkQF2fdsslKcDHTOU/A6AIO+sbriNro4qQ1dIS
	 AhkWwrX6RdE3mT21/iL+1VQGkpk5Ye+onJAUx58DcaAn42yUP+ILyiSUl1djOHvnsBLli
	 4fIYeqBAvES3wpiAPjm7C8tdX4pmUt3VvadDZYvpJEg+7OB/UHIyfA/TTkXkf1A8BwtM3
	 OzA/SVdMrOQ8Js8M/6ngHgdCD2q7cGuTK4eRId9LqQeHJ67+nBcCxHf+iuducmRr/5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363284;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5gCR7ECW+4Ue1ASbnRTbNSEAVs6fBNY+xi63F/OML0g=;
	b=SlOUdmydbegZW8zXDQoZhOqHWIE1MenqOY9ZxdLSdZmWAZUiHSBk9AGSRI0Q0AqVbut/
	 WlU4s5+x6AAWQR24oxzWj5wJdFAFCtdffWDm0asAWZxY2fCeE4XpKlUgGeXd9uh1McaQO
	 SwUn+fgeLCem0QkqtAi0KlbmLYZhNmT4l1UlZEmv7Dw0xuASGMGD8dg4AOSA4iKIG6Erz
	 rsfbzAxFsmg0S1JB5KsiJKPmlpmt9SwfxThWWgNZBhfk0698Du22ykF6WpXhGlTkUPAEN
	 A/fr06gK8i6jNscfOq3BIg5K0V79ZRn0Lzrk5WF1BA+emlWII6eA3fmboW0B/7sLHTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izByW0IY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E18606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izByW0IY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5EC41F0093C;
	Wed, 11 Nov 2026 02:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363284;
	bh=5gCR7ECW+4Ue1ASbnRTbNSEAVs6fBNY+xi63F/OML0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=izByW0IY3kvx91fNYqsuClKHMJfSFu3qraaIoYdmrXh2X9GD7E2NNXO7RTc04d0w+
	 vN537GGeijLgxAytkO1WLVFk21Wj2rDYHGHWX90hQafuG4+l6jXUVENK9GAlBT8uxu
	 UMw65NTSKYAzjPeW6c2T1Nz5WtgYRw/udU1keH1nqpmmwWmB2idtO8KIhdJqg7fXbZ
	 /bn9DP5VH86SSNhs5CBGeYFrIGBzSvekjl4s3A9DWcsxb/+CWpsldNMZpW672DBSfm
	 N1Bblyc3/RncHNewSxDDplx+DJH25iEIuLeeQVymV6GSJdqr50owjYqzLVof9/IAOO
	 Cnhz4lZmRKwBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] nvmem: rockchip-otp: alloc clks with main struct
Date: Tue, 10 Nov 2026 21:14:40 -0500
Message-ID: <20261111021433.580869-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021433.580869-1-sashal@kernel.org>
References: <20261107054624-failed-6.1-9fc6a1592d84@kernel.org>
 <20261111021433.580869-1-sashal@kernel.org>
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
index b5a84b379da40..aaa044bb231b8 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -64,9 +64,9 @@ struct rockchip_data {
 struct rockchip_otp {
 	struct device *dev;
 	void __iomem *base;
-	struct clk_bulk_data *clks;
 	struct reset_control *rst;
 	const struct rockchip_data *data;
+	struct clk_bulk_data clks[];
 };
 
 static int rockchip_otp_reset(struct rockchip_otp *otp)
@@ -239,7 +239,7 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	otp = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_otp),
+	otp = devm_kzalloc(&pdev->dev, struct_size(otp, clks, data->num_clks),
 			   GFP_KERNEL);
 	if (!otp)
 		return -ENOMEM;
@@ -250,11 +250,6 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
-				 GFP_KERNEL);
-	if (!otp->clks)
-		return -ENOMEM;
-
 	for (i = 0; i < data->num_clks; ++i)
 		otp->clks[i].id = data->clks[i];
 
-- 
2.53.0

