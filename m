Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690661;
	b=F+CHq4XBT9NvP56pQ2el2ZYvfDH2si023P6+c+q546P6UVaMie+WGLe0JPfjsHFtxXdw
	 nQ+BdH6FIr1c5tknqjWLem8JLv1cIq/vQ35sANyBmz6wCrzwrdyet+N/R6UatCuK7di9n
	 zfxjvTqqlpu/aQljnjNMTIEY912iAvIyMYGiYCOVMGcUdzAtK3Cqv3qlWJdLN4I3xLlUD
	 zXT9UFvhbGV2f0LCDMqqAXZlEVLl6ZzmcXoYZWpZ8LUKH9YD/lBQ2kl9bIW20bfApUXo9
	 R9+H81+mCOt8JHZr+fnMK5swQ/LJC8CRhVd+XvMEXQlnNgrD1PyVS+zKDK+Mvq4ih3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690661;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=JTbIuCE3NJIqXnZqTc/A3VxouAEQ0U5NKNLCXoF0qNw=;
	b=SWSPY9nWilvizk0Qt6YWE5FMvPM6HSTQap3au6jT1nFLjeCNgropF9B0HCuOlC63jrXD
	 dw42cuCf4T+UUwItPKBhLgbkLg5c54wQANuNKcsKemcMejwZsfctcq8I3P4yZMZ0p/CfV
	 D8FQESiJXRqM9pCzsJJNHgozJRSYshG5PjTICAzLQ7LbWDsE50ordi7XIAYh4uHqHSgTg
	 C9gAPvjYFHaclr2pROguAYrd2g3TyhvUO7F1hBkFFae/nmY5kDBBhSNsxFJapC3W+3zC6
	 prVL70kNLbNe8uIoguBL1sueYZIxgXbs2bnc8IgMsxqlnWw7lVbfXDRt32OrD+wnYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4833F606A32D;
	Tue,  3 Nov 2026 07:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4833F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8BxLNIhjOlqyN0bAA--.15275S3;
	Tue, 03 Nov 2026 15:24:17 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJBxpMwYjOlqxRUyAA--.11093S3;
	Tue, 03 Nov 2026 15:24:16 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH v8 1/7] thermal/drivers/loongson2: Fix negative trip conversion in set_trips
Date: Tue,  3 Nov 2026 15:23:50 +0800
Message-ID: <efffabbb8f7b59efdc0f8b3ecc86bfd2ef633ac6.1793690276.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1793690276.git.zhoubinbin@loongson.cn>
References: <cover.1793690276.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJBxpMwYjOlqxRUyAA--.11093S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0DvgAAsY
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw4xuFy3XFWxGw17ZF18JFc_yoW8Aw4xpa
	y3C34DCrZrJrWqvw1DAayrXFZ8A343tFZrWF4xGw15Aws8J3yagryUtFy5Z3yfGFy8XFyY
	vr95KFWDuFWDA3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7hFxUUUUU

The `MILLI` is defined as an unsigned long constant. When the
temperatures passed to loongson2_thermal_set_trips() are negative, the
expression `low / MILLI` triggers implicit conversion of the signed
operand to unsigned long, and the division is then carried out in
unsigned arithmetic.

For example, with a low trip of -40000 (milli-degree Celsius):

    -40000 / 1000UL = 18446744073709511   /* unsigned long */

After truncation to the 32-bit register field this becomes
1271310379, instead of the expected 60 (i.e. -40 + HECTO). Writing such
bogus value into the trip register leaves most of the upper bits set,
which may hit status/trigger bits and cause spurious thermal interrupts.

Use MILLIDEGREE_PER_DEGREE instead of MILLI so that the division is
performed in signed arithmetic.

Cc: stable@vger.kernel.org
Fixes: e7e3a7c35791 ("thermal/drivers/loongson-2: Add thermal management support")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 4d40fc706a53..54ddee47cb32 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -108,7 +108,8 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	return loongson2_thermal_set(data, low/MILLI, high/MILLI, true);
+	return loongson2_thermal_set(data, low / MILLIDEGREE_PER_DEGREE,
+				     high / MILLIDEGREE_PER_DEGREE, true);
 }
 
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
-- 
2.52.0

