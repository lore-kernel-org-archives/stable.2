Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C584D4AC155;
	Wed, 16 Sep 2026 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552067; cv=none; b=YXFqfrOCkLSBm5puwnD4t6874Zj8v8md7ixsAWv9qLnc7KvVmcX/l90v9utNVrmKrF73EhQn+4h6S/Chc9YgTKoFH3EKWA7u3HDE/r0O/N4sIwSlzze/d4VUnsbcLnp+i3XT7NyR/px8qiz7niHkmaBRpg7zxabi6V3/kyRlRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552067; c=relaxed/simple;
	bh=ujR+fO7LDMYfWlYYuykajoiD8rKB1XvwX0zioPI/lsw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VS+qNytq50MIZUQM+ujR14JyG7twxtmqtN4dVReegPCpOoG2zWW69+tmezbexE3kaYmd/Pu+hYqHDBYM32Kvl1AYuFv1KZPJSpAr4JprtGou0phbDCH0xTneUIM9M/94Yt8aIWLcY9Ann1gPXkgpOMHZwVqh5ov3xe9e2Y38rxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABHUT+wZapq4aHgBw--.14706S2;
	Wed, 16 Sep 2026 17:47:29 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: ckeepax@opensource.wolfsonmicro.com,
	linusw@kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: arizona: Fix runtime PM leak in arizona_gpio_direction_out()
Date: Wed, 16 Sep 2026 09:47:01 +0000
Message-Id: <20260916094701.2007509-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABHUT+wZapq4aHgBw--.14706S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF13Aw13tF1DJF4DKr1UAwb_yoW8GF45pF
	Z0k3y29FW8Jw17K340v3Z3Z3Z0ka47KFyfKay8Kw10v34jq3yktFWDtFWFgr1UCr98Zr45
	Zw13tFyDu3WkZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
	khL5UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7mb8gAAst

Switching a persistent GPIO line from input to output acquires a
runtime PM reference on the parent device, but if the subsequent
regmap_update_bits() fails the reference is never dropped and no later
direction_in() can balance it since the direction was never changed.
Drop the reference on the update failure path.

Fixes: 27a49ed17e22 ("gpio: arizona: Add support for GPIOs that need to be maintained")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpio/gpio-arizona.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-arizona.c b/drivers/gpio/gpio-arizona.c
index a7e98d395d8e..88cf013f0d90 100644
--- a/drivers/gpio/gpio-arizona.c
+++ b/drivers/gpio/gpio-arizona.c
@@ -115,8 +115,12 @@ static int arizona_gpio_direction_out(struct gpio_chip *chip,
 	if (value)
 		value = ARIZONA_GPN_LVL;
 
-	return regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
-				  ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
+	ret = regmap_update_bits(arizona->regmap, ARIZONA_GPIO1_CTRL + offset,
+				 ARIZONA_GPN_DIR | ARIZONA_GPN_LVL, value);
+	if (ret < 0 && (val & ARIZONA_GPN_DIR) && persistent)
+		pm_runtime_put_autosuspend(chip->parent);
+
+	return ret;
 }
 
 static int arizona_gpio_set(struct gpio_chip *chip, unsigned int offset,
-- 
2.34.1

