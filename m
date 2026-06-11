Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0B43314B7;
	Thu, 11 Jun 2026 03:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781150188; cv=none; b=QAUGPkgWXszjwE/OAQHE29TGT+UhRp1zFLoaR24g3IIqIaZEg9U2w2oFbHKY14sO7A1zFpI1RgmkQ3lkixIy9aUj9e+315b2geUFtX+n7YX/kCNBufFS8qtZgzwYrqX6XMon7FjFyO06Ay2QIXISRzA47PvHtt14xLrHBUSn6HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781150188; c=relaxed/simple;
	bh=0Rtqmc6efXIydn0WxSiX1lOQQP7FHUZ/FlnPWtmI3rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kR6m5plQQ7tFTk0uR/lfmdyFliWhPjHMJbcHCzOowWx+DWOjX9nFYJdSE8RtZwRPZNDeSRqtzWK8KvodPBIIJM+tdQSoHULs/VezNfqqGIl1N1lEgdI18tXrU2lbMQY7qZUlSYM3AtYoEzLecaN81t2l949Cno3z1hJFmcRVD0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.76])
	by APP-05 (Coremail) with SMTP id zQCowACnAdXcMSpqxrALEw--.28779S2;
	Thu, 11 Jun 2026 11:56:14 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: alexandre.belloni@bootlin.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	p.zabel@pengutronix.de
Cc: jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com,
	ben.dooks@codethink.co.uk,
	linux-rtc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	WenTao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] rtc: meson: fix refcount leak in meson_rtc_get_bus
Date: Thu, 11 Jun 2026 11:56:05 +0800
Message-ID: <20260611035605.59906-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACnAdXcMSpqxrALEw--.28779S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43JFWxWw1rJw17Zw1kKrg_yoW8Gryfpr
	43KFy7tryDtr4fJanrGw4ruFW3ZFnIqFWUGrsFyw1S9w1fJa1UJry2kF4rJayUWr1kG3y5
	XFsrGF1F9F1DKF7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr
	1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E
	8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7sRi_HU3UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwkPA2op-r7IegABsy

In meson_rtc_get_bus(), reset_control_reset() is called to trigger
a hardware reset when the serial bus is not ready. The function may
retry up to three times, but neither the successful nor the failure
path calls reset_control_rearm() to balance the reference count,
leaking the triggered_count on shared reset controls.

Fix this by adding reset_control_rearm() after reset_control_reset()
on both the error return path and the success path within the retry
loop, ensuring the reset control can be re-triggered on subsequent
bus acquisition attempts.

Cc: stable@vger.kernel.org
Fixes: d8fe6009aa3e ("rtc: support for the Amlogic Meson RTC")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 drivers/rtc/rtc-meson.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-meson.c b/drivers/rtc/rtc-meson.c
index 21eceb9e2e13..729384dceb12 100644
--- a/drivers/rtc/rtc-meson.c
+++ b/drivers/rtc/rtc-meson.c
@@ -146,8 +146,12 @@ static int meson_rtc_get_bus(struct meson_rtc *rtc)
 		dev_warn(rtc->dev, "failed to get bus, resetting RTC\n");
 
 		ret = reset_control_reset(rtc->reset);
-		if (ret)
+		if (ret) {
+			reset_control_rearm(rtc->reset);
 			return ret;
+		}
+
+		reset_control_rearm(rtc->reset);
 	}
 
 	dev_err(rtc->dev, "bus is not ready\n");
-- 
2.50.1 (Apple Git-155)

