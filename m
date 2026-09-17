Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B8F3AAF73;
	Thu, 17 Sep 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648734; cv=none; b=Gab7taqzIORrE8xJBEvrP9NFBoNvAvVKRNqNdkouJhh8oA0fFAQSNBZwrkLIeqfhD9ralhqLaI4vCZc784d0IRNPTZ0F3+uJOwTW/LQB/MVqwfXreLxsaNDasYitSrXtCGlSyfMjYxu5KW0GgKogJ297+0W26B9UapKiMdsC2Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648734; c=relaxed/simple;
	bh=zTxGOmfYlK1id7i8JfywQEIszFfdO/5WF3wPB7aqQqo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FT/BZGw+/DlyYGwS30vGR1GQRViQ196Uk09GI9cCGWEkgL+mtEOkFraa+Tu/1OaZDJpKn09YqAZ7Q774Z0FYowFMm1YMF+NOC6jkFIix1u3Z/UDaYA9d3J/ld24U4TNsXRBCYi+YGTGfAmB8+L/d17c45o2FzhjRo87nRsF1jw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnF0JP36tqiq6ACA--.2858S2;
	Thu, 17 Sep 2026 20:38:39 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: a.fatoum@pengutronix.de
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rafal@milecki.pl,
	srini@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: u-boot-env: Fix mtd reference leak in u_boot_env_probe()
Date: Thu, 17 Sep 2026 12:38:39 +0000
Message-Id: <20260917123839.2151503-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnF0JP36tqiq6ACA--.2858S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cry8AFy5Zr4xCr47Zr4ruFg_yoW8WrWkpa
	1DCFyrtrW3KFW2gw17XF4UZF90kw4Igay3GF17GaySk3WSyry5trZ5tF90yFyYyFyrur4Y
	yrW3tFWUCF45A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
	CY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU2G-eUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwcNA2qrrRmZrwAAsN

of_get_mtd_device_by_node() takes a reference on the returned MTD device
that the caller has to drop with put_mtd_device(). The probe function
returns early when devm_nvmem_register() or u_boot_env_parse() fails
without releasing that reference, so add the missing put_mtd_device()
calls on both error paths.

Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/nvmem/u-boot-env.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/u-boot-env.c b/drivers/nvmem/u-boot-env.c
index ced414fc9e60..893fbd2a8520 100644
--- a/drivers/nvmem/u-boot-env.c
+++ b/drivers/nvmem/u-boot-env.c
@@ -52,6 +52,7 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct u_boot_env *priv;
+	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -71,10 +72,16 @@ static int u_boot_env_probe(struct platform_device *pdev)
 	config.size = priv->mtd->size;
 
 	priv->nvmem = devm_nvmem_register(dev, &config);
-	if (IS_ERR(priv->nvmem))
+	if (IS_ERR(priv->nvmem)) {
+		put_mtd_device(priv->mtd);
 		return PTR_ERR(priv->nvmem);
+	}
+
+	ret = u_boot_env_parse(dev, priv->nvmem, priv->format);
+	if (ret)
+		put_mtd_device(priv->mtd);
 
-	return u_boot_env_parse(dev, priv->nvmem, priv->format);
+	return ret;
 }
 
 static const struct of_device_id u_boot_env_of_match_table[] = {
-- 
2.34.1

