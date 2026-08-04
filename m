Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC23C0A13;
	Tue,  4 Aug 2026 12:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847422; cv=none; b=Pr836Fbdreo3iK42cFUSzg6CJbbRZQS5659u04jGYEWCvKifd8m2P6V7uO3ft9Lw6vCyvRxxD/kU8znRXs5lbMcrtc5sghVWAIDiBQAVhWwTGWSsye7p1LRqQhNwJbGPYykk8qSjW8ZlUwrftjWgPQe3R7uRcfcPqMpW0hX1apA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847422; c=relaxed/simple;
	bh=9E8GdqP31dgwfZYT4f13k2PUrM5L41eD1gFxUICd/xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxG3vcxfgaW5mj3hpF1QgFkzQvmASKvXQlCX7anBnsR3w8eNwONxkHh0oQfIHBYjmwGBUqXLHe0vv4thAAnv0oyrj4jOg+kwGtTulkEb0BV5ykYqYsn52HkAOk55f6wA+gR5ojT4g6eMrgio3P6H9tOyAgocWdV+EZxU1ksZ4bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.205])
	by gateway (Coremail) with SMTP id _____8DxPJt43nFqAUUKAA--.10256S3;
	Tue, 04 Aug 2026 20:43:36 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.205])
	by front1 (Coremail) with SMTP id qMiowJAxTOVx3nFqYHAjAA--.43S2;
	Tue, 04 Aug 2026 20:43:33 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Lee Jones <lee@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/5] thermal/drivers/loongson2: Correct thermal sensor registration loop
Date: Tue,  4 Aug 2026 20:42:13 +0800
Message-ID: <1c0f32f83a43a11a35e151fe97e9b5d4b21ea459.1785829933.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785829933.git.zhoubinbin@loongson.cn>
References: <cover.1785829933.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxTOVx3nFqYHAjAA--.43S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEJCGpxbi8nxQAAs6
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1UCFW8ZFy5Jw13Wr43CFX_yoW8Cr1rpF
	sxC3WYkr98GFs7Z34DArWUXan0ya4ftFW7WF4xWw1rWrn3J34agryrJFW2qa40yFy8ZF1Y
	qr98tFWDCayDZrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8XTm3UUUUU==

The registration loop in loongson2_thermal_probe() incorrectly uses
dev_err_probe() when the sensor is not present (-ENODEV). In that case,
the driver should continue to the next sensor index rather than treating
it as a fatal error.

Fix this by correctly handling -ENODEV and only returning on other
errors. Also add a final check to ensure at least one thermal zone was
registered.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1783670011.git.zhoubinbin@loongson.cn?part=2
Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index ea4dd2fb1f47..5f47fa51fb90 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -161,16 +161,18 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
 		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
-
 		if (!IS_ERR(tzd))
 			break;
 
-		if (PTR_ERR(tzd) != -ENODEV)
+		if (PTR_ERR(tzd) == -ENODEV)
 			continue;
 
-		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register");
+		return dev_err_probe(dev, PTR_ERR(tzd), "failed to register sensor %d\n", i);
 	}
 
+	if (IS_ERR(tzd))
+		return dev_err_probe(dev, -ENODEV, "No thermal sensor registered\n");
+
 	ret = devm_request_threaded_irq(dev, irq, NULL, loongson2_thermal_irq_thread,
 					IRQF_ONESHOT, "loongson2_thermal", tzd);
 	if (ret < 0)
-- 
2.52.0

