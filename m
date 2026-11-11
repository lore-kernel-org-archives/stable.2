Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363283;
	b=Jyh7r0ufJtn8H4jgT9qYLuT1rvytnrvgkzVxnzBWROHbLi0gGQVii0fKPxjdXAzj6mOa
	 gHs5qw9SJSc9nNDpkbN8iwbPhSTz9FKnpoEsGMCx1jUXogMbLcZlIKN5a9Rmedg5atJSc
	 wqa24YZHkui9Hnq8sDExm0ERMY2Yp3VupniI9T7YBHATWUAIWBNHw4D1m3MIU5GLETVAB
	 tNxQrz9EvbQEYgGqJx08m+zNiYsjZSEEmFgjMtkWyAh3buIi0kaOaPQDUPguVhpXSxH46
	 VkbBIZbG1vJDT6/Pk4kWKaoWmcJ9y8Nq7EQon+e4fKnnWcEvrFyyP3sb4IoCfRI/qZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363283;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2uVxbiotD9un69M9tCD5Fr0I4KpEpUc1LUsIKm9MmL8=;
	b=fBQtUPs6CDd+QL+SqK6vn/H22CywKgtbutf0lwju+yghygqb5X/Why9me05arJisT/vn
	 WlBrAJjrBbTsCo5XJ7C6b79J+ab7kWYCmHs0iS8/JWcQ5CyVYRwc/5Q9iSoT6O1Vk922V
	 qCw0gfhwa0xbvLk7ixI983Osg4aERZIPxRFHOfmaQBG88tedpu+GxEu637YS9+5X/d5lx
	 OYuZftq5EzMnqlt3RJngWRDj2WSNxneTrLOLZ/anMsZWSOdQP+ZqDLjNU7HGbefA9eaoM
	 7ypKCE73FtWxn67bkD7GCVv/9oFDys1NlArwjJ3QYlwf61ZE0C2DO8BUd9dvowELo7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIRQDnAe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851A606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIRQDnAe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3C581F0089F;
	Wed, 11 Nov 2026 02:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794363283;
	bh=2uVxbiotD9un69M9tCD5Fr0I4KpEpUc1LUsIKm9MmL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OIRQDnAeL5YIrNL5OmGng+N16jceptyTaYag+eZxgQNIQyubRz0Jna2ecps4QQwnr
	 FoIzVLs19VPJ+DGMUJTEK07eCPjd/u6yidDYg9MYceyUd3pdcuoPE0xpZPR2pZr6Pm
	 4NIVPF/z74GLusk6IqAQ86ks62MDv+FIGb3GO7TI29weAxVTaKeZzHRrCKqF17zx4P
	 fQvWhlSoEI8wmTuZsrwwNPFhAwNbnuKjch9cfjyHNea5qvFwYc5mCbS47z1e1iUM0u
	 eUT5PhXEyuPoVFa8fpeFeW66kgPiOrGfeKc+m4cw9KHkMGsYE5HzPpIirGWUfUXBPv
	 niN9zQmyAwFlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Vincent Legoll <vincent.legoll@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] nvmem: rockchip-otp: Add clks and reg_read to rockchip_data
Date: Tue, 10 Nov 2026 21:14:39 -0500
Message-ID: <20261111021433.580869-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054624-failed-6.1-9fc6a1592d84@kernel.org>
References: <20261107054624-failed-6.1-9fc6a1592d84@kernel.org>
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

From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

[ Upstream commit 8dc61364164e79e44c07fa2ac0a7b6939f00d5db ]

In preparation to support new Rockchip OTP memory devices with different
clock configurations and register layout, extend rockchip_data struct
with the related members: clks, num_clks, reg_read.

Additionally, to avoid managing redundant driver data, drop num_clks
member from rockchip_otp struct and update all references to point to
the equivalent member in rockchip_data.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Tested-by: Vincent Legoll <vincent.legoll@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20230611140330.154222-10-srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 9fc6a1592d84 ("nvmem: rockchip-otp: Serialize reads")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/rockchip-otp.c | 79 ++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 30 deletions(-)

diff --git a/drivers/nvmem/rockchip-otp.c b/drivers/nvmem/rockchip-otp.c
index 9f53bcce2f877..b5a84b379da40 100644
--- a/drivers/nvmem/rockchip-otp.c
+++ b/drivers/nvmem/rockchip-otp.c
@@ -54,21 +54,19 @@
 
 #define OTPC_TIMEOUT			10000
 
+struct rockchip_data {
+	int size;
+	const char * const *clks;
+	int num_clks;
+	nvmem_reg_read_t reg_read;
+};
+
 struct rockchip_otp {
 	struct device *dev;
 	void __iomem *base;
-	struct clk_bulk_data	*clks;
-	int num_clks;
+	struct clk_bulk_data *clks;
 	struct reset_control *rst;
-};
-
-/* list of required clocks */
-static const char * const rockchip_otp_clocks[] = {
-	"otp", "apb_pclk", "phy",
-};
-
-struct rockchip_data {
-	int size;
+	const struct rockchip_data *data;
 };
 
 static int rockchip_otp_reset(struct rockchip_otp *otp)
@@ -132,29 +130,23 @@ static int rockchip_otp_ecc_enable(struct rockchip_otp *otp, bool enable)
 	return ret;
 }
 
-static int rockchip_otp_read(void *context, unsigned int offset,
-			     void *val, size_t bytes)
+static int px30_otp_read(void *context, unsigned int offset,
+			 void *val, size_t bytes)
 {
 	struct rockchip_otp *otp = context;
 	u8 *buf = val;
-	int ret = 0;
-
-	ret = clk_bulk_prepare_enable(otp->num_clks, otp->clks);
-	if (ret < 0) {
-		dev_err(otp->dev, "failed to prepare/enable clks\n");
-		return ret;
-	}
+	int ret;
 
 	ret = rockchip_otp_reset(otp);
 	if (ret) {
 		dev_err(otp->dev, "failed to reset otp phy\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	ret = rockchip_otp_ecc_enable(otp, false);
 	if (ret < 0) {
 		dev_err(otp->dev, "rockchip_otp_ecc_enable err\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	writel(OTPC_USE_USER | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
@@ -174,8 +166,28 @@ static int rockchip_otp_read(void *context, unsigned int offset,
 
 read_end:
 	writel(0x0 | OTPC_USE_USER_MASK, otp->base + OTPC_USER_CTRL);
-disable_clks:
-	clk_bulk_disable_unprepare(otp->num_clks, otp->clks);
+
+	return ret;
+}
+
+static int rockchip_otp_read(void *context, unsigned int offset,
+			     void *val, size_t bytes)
+{
+	struct rockchip_otp *otp = context;
+	int ret;
+
+	if (!otp->data || !otp->data->reg_read)
+		return -EINVAL;
+
+	ret = clk_bulk_prepare_enable(otp->data->num_clks, otp->clks);
+	if (ret < 0) {
+		dev_err(otp->dev, "failed to prepare/enable clks\n");
+		return ret;
+	}
+
+	ret = otp->data->reg_read(context, offset, val, bytes);
+
+	clk_bulk_disable_unprepare(otp->data->num_clks, otp->clks);
 
 	return ret;
 }
@@ -189,8 +201,15 @@ static struct nvmem_config otp_config = {
 	.reg_read = rockchip_otp_read,
 };
 
+static const char * const px30_otp_clocks[] = {
+	"otp", "apb_pclk", "phy",
+};
+
 static const struct rockchip_data px30_data = {
 	.size = 0x40,
+	.clks = px30_otp_clocks,
+	.num_clks = ARRAY_SIZE(px30_otp_clocks),
+	.reg_read = px30_otp_read,
 };
 
 static const struct of_device_id rockchip_otp_match[] = {
@@ -225,21 +244,21 @@ static int rockchip_otp_probe(struct platform_device *pdev)
 	if (!otp)
 		return -ENOMEM;
 
+	otp->data = data;
 	otp->dev = dev;
 	otp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(otp->base))
 		return PTR_ERR(otp->base);
 
-	otp->num_clks = ARRAY_SIZE(rockchip_otp_clocks);
-	otp->clks = devm_kcalloc(dev, otp->num_clks,
-				     sizeof(*otp->clks), GFP_KERNEL);
+	otp->clks = devm_kcalloc(dev, data->num_clks, sizeof(*otp->clks),
+				 GFP_KERNEL);
 	if (!otp->clks)
 		return -ENOMEM;
 
-	for (i = 0; i < otp->num_clks; ++i)
-		otp->clks[i].id = rockchip_otp_clocks[i];
+	for (i = 0; i < data->num_clks; ++i)
+		otp->clks[i].id = data->clks[i];
 
-	ret = devm_clk_bulk_get(dev, otp->num_clks, otp->clks);
+	ret = devm_clk_bulk_get(dev, data->num_clks, otp->clks);
 	if (ret)
 		return ret;
 
-- 
2.53.0

