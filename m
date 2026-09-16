Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CE84DF4D7;
	Wed, 16 Sep 2026 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554389; cv=none; b=YSiq5Mf9VL8QLG1kDuY3WOf2RrKwnf6NvscMoJ7niIFfyemM06vWGs27DLgMJdSaaK7fyRHKcbYpsvZuDqZp29kU1NYWDEkXKjvTty/bl6fOAAV/FtUdLn50yKe6H4ytB1ChAXFwFhqcfZZ9FNlPCm6m1tfaxuP20oQfK4620yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554389; c=relaxed/simple;
	bh=LmLa9GYYojBO6JjdUuWQyCWYT9dH4opPHgxeBmT7i9A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G9hAdqpFEPdkdUs4yrx5BJR3XO26/sQVe5C8OYpWL1t5ub0x/7B2rJCo+cbxSvqA5+Mu0hP7k/rRMGr2ZiRE2Uip83NtC3gLW4JN6+mHsWcCC3csvmAxsJLtMzCVTZydyZesrUMOdnow/7waTaNDA8CSEFI69Bmsm4ekAdIvZ/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAD3+Te1bqpq6A3hBw--.1939S2;
	Wed, 16 Sep 2026 18:25:58 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: brgl@kernel.org
Cc: heiko@sntech.de,
	jay.xu@rock-chips.com,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: rockchip: Fix debounce clock leak in rockchip_get_bank_data()
Date: Wed, 16 Sep 2026 10:25:29 +0000
Message-Id: <20260916102529.2019277-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAD3+Te1bqpq6A3hBw--.1939S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFy8KrW7tw4UZF13WFW3KFg_yoW8WF13pa
	n8WrW5Kwn7GFn2gF1DAF15AFWFv3ZFyay3Wrn7G3WxCw13tFy7tFWUWFWvqF45Aryvkay5
	Ar43Ga4UGr43Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9S14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4
	IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1r
	MI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCV
	W8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Cr1j6r
	xdYxBIdaVFxhVjvjDU0xZFpf9x0JUJWrAUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAEMA2qqP7m20QAAsj

rockchip_get_bank_data() obtains the debounce clock with of_clk_get()
for GPIO v2 banks and stores it in bank->db_clk for later use by the
debounce handling, but the reference is never released anywhere in the
driver.  When rockchip_gpiolib_register() fails in rockchip_gpio_probe()
or when the device unbinds, the debounce clock reference leaks.

Release the references returned by of_clk_get() with clk_put() when
probe fails after the gpiochip registration and when the device is
removed.  The bank clock reference is dropped as well since it suffers
from the same problem.

Fixes: 3bcbd1a85b68 ("gpio/rockchip: support next version gpio controller")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpio/gpio-rockchip.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 69a7cd8c9a1a..cab1ac78c48f 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -755,6 +755,8 @@ static int rockchip_gpio_probe(struct platform_device *pdev)
 	ret = rockchip_gpiolib_register(bank);
 	if (ret) {
 		clk_disable_unprepare(bank->clk);
+		clk_put(bank->clk);
+		clk_put(bank->db_clk);
 		mutex_unlock(&bank->deferred_lock);
 		return ret;
 	}
@@ -797,6 +799,8 @@ static void rockchip_gpio_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(bank->clk);
 	gpiochip_remove(&bank->gpio_chip);
+	clk_put(bank->clk);
+	clk_put(bank->db_clk);
 }
 
 static const struct of_device_id rockchip_gpio_match[] = {
-- 
2.34.1

