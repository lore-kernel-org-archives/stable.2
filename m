Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363552;
	b=ZyEngFTPatp42VuOA1RkwAI+ubZIR4okOvQLWoditdvrODkNNXzClS+lecx20uDHYcUu
	 8VUkDDfuKG0gOCHsdBP0ffIPusBZnr3rClo3vj5Ubp0q03kqLhNqskXNGEKW+9/HXUXcU
	 PGY04ur4SEpyIJrol7xy8QG+E6faXbQrCTg8W2wq2P7doT9YAZatBxjkypIsH7/qh+i4M
	 Tcb8EksKh6Wf760zI3nRUFpbC3rHrUFdYh+NZg8yAzjUsYiuerI50cIBSH6YhDLwalacj
	 AMcStcM+vXBaxBwbQSrUQCZPa9hwsG4qNbhbzM9GDvi8mxHBJFMQgm9L4WNiO6ERaCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363552;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5gCR7ECW+4Ue1ASbnRTbNSEAVs6fBNY+xi63F/OML0g=;
	b=IS6O5Yt+S28Nhh4kU4wA3fbu2NNe04HZ9Zfp5R5Lf8yvSkGrhMd+6VmT5iZKdMyv6dNX
	 n3OCXpE5Ma/0uajCatA/7it+SBKmFxP8+8b8SNaWokocwESWCrZVUbBagJfOL4kQ1NTY+
	 Rya6bqp49gaVyqHZ5IUCVYRjY8+7HPSENtjruiLMTM+Dt6natpLwOwO3Sr04EHxOQeWAJ
	 HtP1AZcxCKjC4CSJC/8w/791/vTULpfDAkRUcCoWtypfpARvT5zoCWg16dQL2w8EbV7B4
	 Lj4LtkElbzeps8YsfRUs5byyZBuhaGkbVRE4zSAuVsqvw0OBDaVGTYefne9rm+s4G+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YxuW8/M/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC449606A327
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxuW8/M/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F4D1F0093C;
	Wed, 11 Nov 2026 02:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363552;
	bh=5gCR7ECW+4Ue1ASbnRTbNSEAVs6fBNY+xi63F/OML0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YxuW8/M/KB4r4DFNrmfQxKZRLcm09GtUpz4yfh6pMmv8AXM0T/8eLMeh9G3UkZhxz
	 1dVvLMeZi89Q/r9gxEoNbp0oXhc68k27h5PYatcCflvhzXtQXcyiRqvCZ041kX+QXd
	 /fk9zKzhrF5cZk8Z+2cfvgsqeVwRfx1u50tme31ELa6gviF134qfoPK34RvVc+d2NU
	 SjgXNru6cBMnb3LhpkZWMWYbQrKwGpgoCEd+AeNT0BNUj0UDUAijLN5pyhQJRGNY8L
	 TL5rymHWMU1pGrzlT93uWGxJkrzhMUpH458aa2xiH0UUEzyllK8oBBfHAJ/oIxF+FZ
	 EbZKhn92rC7ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rosen Penev <rosenp@gmail.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] nvmem: rockchip-otp: alloc clks with main struct
Date: Tue, 10 Nov 2026 21:19:08 -0500
Message-ID: <20261111021904.642613-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111021904.642613-1-sashal@kernel.org>
References: <20261107060352-failed-5.15-9fc6a1592d84@kernel.org>
 <20261111021904.642613-1-sashal@kernel.org>
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

