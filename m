Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3752FDC57;
	Tue,  9 Jun 2026 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996070; cv=none; b=qnn6LYvLJJvXKz6TDb7/gH4I0FUuA3J/LoBx77D1AEVzcNSPlgu//7BUH04+Vk6fLXNjkGRoLdpytLfNqbmwUj2RMxuqyJq9uZHxBXw+4oFOVfHrTRT2HD3Q8JrsMmjHm8varNoLXwsMdzFE8+NX1w9vLBdv5eWiza3J79P4aDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996070; c=relaxed/simple;
	bh=4GKX7Ex9N+3GfI/w4ItbvDUbzRZT2dNXKX1T7SPfp5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UFUhtSm2CSZzy56kiWueeS2gohQhaDli1TarPWBNQcVGnVLPRUEEjhTo9+cJ8O8oh6a24nhAukMDuvWrjH8C3Gx0kF6MIRYEW5dzIOIakMtC8JveidWavPFhTclrcQODzOivCdY5tavo/0Zaw4ZdM8kAd6yn7uNBoA5VohHIzbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowABXq87Y1ydqcKvPEg--.154S2;
	Tue, 09 Jun 2026 17:07:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mdio-airoha: fix refcount leak in airoha_mdio_probe()
Date: Tue,  9 Jun 2026 09:07:29 +0000
Message-Id: <20260609090729.219120-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXq87Y1ydqcKvPEg--.154S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFyrKFy8WF4DXry8Cw48JFb_yoW8JFWkpr
	4jkF1ayayUJrs5Aay8Aa1rZFyFgF13ta4UGFWav39Yvwn3Gr47XrWjvFyqvFyUCFW0qrZ8
	Gr4UJ3WruF4DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26rWY6Fy7McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCT
	nIWIevJa73UjIFyTuYvjfU5o7KDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgwNA2onp6StJAACsB

In airoha_mdio_probe(), after calling reset_control_deassert(),
if clk_set_rate() fails, the function returns immediately without
calling reset_control_assert().  This leaves the reset line
deasserted and causes a reference count leak on shared reset
controllers.  The devm cleanup does not assert the reset line, so
the unbalanced deassert persists.

Fix this by adding a reset_control_assert() call on the
clk_set_rate() error path, matching the existing error handling
for devm_of_mdiobus_register().

Cc: stable@vger.kernel.org
Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/mdio/mdio-airoha.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
index 52e7475121ea..030482b8318f 100644
--- a/drivers/net/mdio/mdio-airoha.c
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -245,8 +245,10 @@ static int airoha_mdio_probe(struct platform_device *pdev)
 		freq = 2500000;
 
 	ret = clk_set_rate(priv->clk, freq);
-	if (ret)
+	if (ret) {
+		reset_control_assert(priv->reset);
 		return ret;
+	}
 
 	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
 	if (ret) {
-- 
2.34.1

