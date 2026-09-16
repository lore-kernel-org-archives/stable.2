Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CECF49E5E6;
	Wed, 16 Sep 2026 10:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554219; cv=none; b=H51GxYYmVmflQOzOhJ1ON4V87c0RKm2NnFKJhi5CzTtGbFdgr+7PPamW1jD01drDnZtQTN0gQ9s2FH57Yhh8owlvCFmN/lMa0CxeqLQzhgEKzAirUKwQWbBmCTFcQcOGS+15q6NvIiEhcOSfCdx08GgudGadZN2GSoh7ti5n4j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554219; c=relaxed/simple;
	bh=uFQjaP6Ot+RC8020d5qhZIUj9k2STd3WAVm0TM1m108=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uNmc5FgsfNOFGitZ1cE7c5x35w7m7sbvbvIF03XzrRqIb6iZbrBo3Q/oRH61sLD3EQsehq9/r5MzpwMgJz59aXHTFyc9C+9VDYEVWz+Bz9GC/kpMCWvuS/Nj4HbAyn5Ipbx+LTuAObPaDNWTsSshe/SiryE0AOI4Z5Y8+tlYsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowACXmjgebqpqawfhBw--.61860S2;
	Wed, 16 Sep 2026 18:23:26 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: andriy.shevchenko@linux.intel.com
Cc: brgl@kernel.org,
	heiko@sntech.de,
	linusw@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sebastian.reichel@collabora.com,
	ye.zhang@rock-chips.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] gpio: rockchip: Fix bank clock leak in rockchip_get_bank_data()
Date: Wed, 16 Sep 2026 10:22:58 +0000
Message-Id: <20260916102258.2018689-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXmjgebqpqawfhBw--.61860S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrykZr47uw4UKrWrXr1kZrb_yoW8WFy7pF
	s0kFyFkrsrJFnFgF1DAFZ3Ar4FyanrJFW3GFyxG3WxCw13tFyUtay5uayv9FWUArWIkw4a
	9r1DJFy8WrW7Zr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRUMA2qqP4e3zAAAsQ

rockchip_get_bank_data() obtains the bank clock with of_clk_get() and
enables it before reading the GPIO version ID.  The reference returned
by of_clk_get() is never dropped on the error paths that follow:

When the debounce clock is missing, the bank clock is disabled with
clk_disable_unprepare() but the reference is never released with
clk_put().  When the version ID is unsupported, the function returns
-ENODEV leaving the bank clock prepared, enabled and referenced.

Drop the reference with clk_put() on both error paths and disable and
unprepare the bank clock on the unsupported version path so that probe
failures no longer leak the clock.

Fixes: 41209307cad7 ("gpio: rockchip: change the GPIO version judgment logic")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpio/gpio-rockchip.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
index 44d7ebd12724..69a7cd8c9a1a 100644
--- a/drivers/gpio/gpio-rockchip.c
+++ b/drivers/gpio/gpio-rockchip.c
@@ -673,6 +673,7 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 		if (IS_ERR(bank->db_clk)) {
 			dev_err(bank->dev, "cannot find debounce clk\n");
 			clk_disable_unprepare(bank->clk);
+			clk_put(bank->clk);
 			return -EINVAL;
 		}
 		break;
@@ -682,6 +683,8 @@ static int rockchip_get_bank_data(struct rockchip_pin_bank *bank)
 		break;
 	default:
 		dev_err(bank->dev, "unsupported version ID: 0x%08x\n", id);
+		clk_disable_unprepare(bank->clk);
+		clk_put(bank->clk);
 		return -ENODEV;
 	}
 
-- 
2.34.1

