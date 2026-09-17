Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9FA544890;
	Thu, 17 Sep 2026 13:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652521; cv=none; b=g2X6ISvELAEHoZ6MC5+6hdvMvKnf5dTO/m3ePOUJ9dY+Lt0ea6xR+g9BvlVqRVD61ZhjKQQSawNJKzSpLTNkgeib++pTNx+r3c7QwW10+Itn07MvgVPy0kGLwTwqA3GApqLs0ElcO0KzYy1Ib+MCMrsLkc4MQtWKR8utduybrhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652521; c=relaxed/simple;
	bh=wkc4DlQHslJvg66Z28cVZsHjcmZfVlD4hNGuWjaoWZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PuDhciNlN3Tr0lq61fL/MApFIZnx9ikL++ku2xm7k0A+TeofxELTQkHrVTdznAG96dipAlQihkzdk0TgS9w6EOaD6gt+xFFcOfR6Nmidjd8LC+B18nUxbmr0Vxu9XAPxfm44ndiTe1hDQY7MS6fsTONCPKMGAAc3lOP9DV6Wh5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oz0Y7qtqAK6BCA--.3930S2;
	Thu, 17 Sep 2026 21:41:45 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-phy@lists.infradead.org,
	mani@kernel.org,
	mchehab+huawei@kernel.org,
	neil.armstrong@linaro.org,
	vkoul@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] phy: HiSilicon: Fix device node reference leak in hi3670_pcie_get_resources_from_pcie()
Date: Thu, 17 Sep 2026 13:41:44 +0000
Message-Id: <20260917134144.2153731-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oz0Y7qtqAK6BCA--.3930S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GF1xJr1xuFW3JF45Kr1fCrg_yoW8Jrykpr
	W7KFW2kFyUGa1fZr1qkF1YgFy5C3WYkFW3G3yxCw13ZFn5ZFyUZayjqFy0qF42kFZ7Za4U
	KF4UtFyDJF40yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VAI37AI020EjII2zVCS5cI20VAGYxC7MxkF
	7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07b818PUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwENA2qrrRnEtgAAsP

hi3670_pcie_get_resources_from_pcie() obtains the "pcie" child node
with of_get_child_by_name(), which takes a reference on the node, but
never releases it: both the "Didn't find pcie device" and the "Failed
to get APB regmap" error paths, as well as the success path, return
without calling of_node_put().

The node is only needed for the device lookup, so drop the reference
right after bus_find_device_by_of_node().

Fixes: 73075011ffff ("phy: HiSilicon: Add driver for Kirin 970 PCIe PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/phy/hisilicon/phy-hi3670-pcie.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/phy/hisilicon/phy-hi3670-pcie.c b/drivers/phy/hisilicon/phy-hi3670-pcie.c
index 87eac058a4bc..35e634279794 100644
--- a/drivers/phy/hisilicon/phy-hi3670-pcie.c
+++ b/drivers/phy/hisilicon/phy-hi3670-pcie.c
@@ -570,6 +570,7 @@ static int hi3670_pcie_get_resources_from_pcie(struct hi3670_pcie_phy *phy)
 	}
 
 	pcie_dev = bus_find_device_by_of_node(&platform_bus_type, pcie_port);
+	of_node_put(pcie_port);
 	if (!pcie_dev) {
 		dev_err(dev, "Didn't find pcie device\n");
 		return -ENODEV;
-- 
2.34.1

