Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794211754;
	b=we7zUJjVHw764WWGA6WvVE0h9CbbFY93lYCnfsTSngeRfM5MonnVjYOcdzmlRue6jwjr
	 iwqY4/F4+KaEPi712iQv1hvf7JJAaBt7AA3EdTxxU7H8UVkUYAQT9SugKSK3LUzAyplT4
	 1l17/+jYs8ajU7LpHF3Rmsg8bR9C9g+kOoalLy1FPOPAqn4qb9neiYDgR1LOIqxS0gYw9
	 8QUTrB3s9LzSz2zg+YgZxRBfdDGYtPVhTJN3hnOk3pAmpLu0MRCr9AWNriT0BUVhOUlk0
	 +4+XoCCj7Mzu9WWy6wwJz6hpoz5RTi0cztXquNwwzRoevlYJDd12ZMk8f0pSZbBGqiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794211754;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=fjTEmDzxoVFEEMmS1so5Ss3MMDrcv3SEwWr9U0l0Eak=;
	b=uislSixVhY06Jf9uW/rC5UBkYMjojQfWn/e8Ll88T8FRYjOkYL4hkbmLxLniA4CxN1yQ
	 CxB+VTgNSy1eqtsHQu4sVKZswvNO2FnSXF34ta69DxNkzR4uG8hrWz5n/n2dpbzZ0JX63
	 A9/4MriJ90O2FZuBXzwV93ChdS/w4dxscIH1xm8X8mGVEH+wXYsrEwTW5xEvVDbOSnRWf
	 Mb44BCfKrUC3RWBR6aHYphsAAqMjSRTqgpLOHd928TYxa+HCwc95OwcI42yZhOFH1rIpT
	 BO0rmfq3uKBA60py3TmN3mW16j60ura/cfmzV26PWd12EVbq10sTzYmMFKlm0PQUauQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B58606A323;
	Mon,  9 Nov 2026 08:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57B58606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8DxpvCnf_Fqp78dAA--.20556S3;
	Mon, 09 Nov 2026 16:09:11 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJAxmM2lf_FqdCQzAA--.37921S2;
	Mon, 09 Nov 2026 16:09:10 +0800 (CST)
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
Subject: [PATCH v9 3/7] thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
Date: Mon,  9 Nov 2026 16:08:59 +0800
Message-ID: <9fce0a1190fcad566a5fa477d657ef74b79f0744.1794211535.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1794211535.git.zhoubinbin@loongson.cn>
References: <cover.1794211535.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJAxmM2lf_FqdCQzAA--.37921S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEGCGrxOf4ETgAAsb
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1rCrW5Wryxtw15Ww13KFX_yoWfXFy7p3
	47C3y3KrWqqr48uw4UZ3WkWr4Yvr47tasxZFs7Gw13Xw4rt34agryvyFn3XFWakF9rJFy7
	ZrWq9FW7ua1DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
	0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4ZqXDUUUU

The Loongson-2K2000 splits its 16-bit gate value across the control
register (low byte) and a dedicated HI_GATE register (high byte), and
derives the gate value from the target temperature with a different
formula than the Loongson-2K1000.

Add a per-SoC set_trips_regs callback and implement the Loongson-2K2000
variant alongside the existing Loongson-2K1000 one.

Cc: stable@vger.kernel.org
Fixes: 734b5def91b5 ("thermal/drivers/loongson2: Add Loongson-2K2000 support")
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 122 +++++++++++++++++++++-------
 1 file changed, 93 insertions(+), 29 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 9256cd3663e6..2d24d310c0a7 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
@@ -25,9 +26,30 @@
 
 #define LOONGSON2_THSENS_INT_LO		BIT(0)
 #define LOONGSON2_THSENS_INT_HIGH	BIT(1)
-#define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
+#define LOONGSON2_THSENS_INT_CLR	(LOONGSON2_THSENS_INT_LO | \
 					 LOONGSON2_THSENS_INT_HIGH)
-#define LOONGSON2_THSENS_OUT_MASK	0xFF
+
+#define LOONGSON2_THSENS_CTRL_GATE_MASK	GENMASK(7, 0)
+#define LOONGSON2_THSENS_CTRL_INTEN	BIT(8)
+#define LOONGSON2_THSENS_CTRL_SEL_MASK	GENMASK(11, 10)
+
+#define LOONGSON2_THSENS_OUT_8B_MASK	GENMASK(7, 0)
+#define LOONGSON2_THSENS_OUT_16B_MASK	GENMASK(15, 0)
+
+#define LOONGSON2_LOWEST_VALID_TEMP     (-40000)
+#define LOONGSON2_HIGHEST_VALID_TEMP    (125000)
+
+/* Loongson-2K2000-Specific Registers */
+#define LS2K2000_THSENS_HI_GATE_HI_REG	0x18
+#define LS2K2000_THSENS_HI_GATE_LOW_REG	0x1c
+
+#define LS2K2000_TEMP_MUL		(820)
+#define LS2K2000_TEMP_DIV		(0x4000)
+#define LS2K2000_TEMP_OFFSET		(311)
+
+/* 16-bit gate value is split into low and high bytes */
+#define LS2K2000_GATE_LO_MASK		GENMASK(7, 0)
+#define LS2K2000_GATE_HI_MASK		GENMASK(15, 8)
 
 /*
  * This flag is used to indicate the temperature reading
@@ -35,9 +57,13 @@
  */
 #define LS2K2000_THSENS_OUT_FLAG	BIT(0)
 
+struct loongson2_thermal_data;
+
 struct loongson2_thermal_chip_data {
 	unsigned int thermal_sensor_sel;
 	unsigned int flags;
+	void (*set_trips_regs)(struct loongson2_thermal_data *data,
+			       int temp, bool low, bool enable);
 };
 
 struct loongson2_thermal_data {
@@ -46,58 +72,93 @@ struct loongson2_thermal_data {
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
-static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
-				    int ctrl_data, bool low, bool enable)
+static void loongson2_thermal_set(struct loongson2_thermal_data *data,
+				  int low, int high, bool enable)
 {
-	int reg_ctrl = 0;
-	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
-	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
-
-	reg_ctrl = ctrl_data + HECTO;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
-}
+	low = clamp(low, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
+	high = clamp(high, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
 
-static int loongson2_thermal_set(struct loongson2_thermal_data *data,
-				 int low, int high, bool enable)
-{
 	/* Set low temperature threshold */
-	loongson2_set_ctrl_regs(data, clamp(low, -40, 125), true, enable);
+	data->chip_data->set_trips_regs(data, low / MILLIDEGREE_PER_DEGREE, true, enable);
 
 	/* Set high temperature threshold */
-	loongson2_set_ctrl_regs(data, clamp(high, -40, 125), false, enable);
-
-	return 0;
+	data->chip_data->set_trips_regs(data, high / MILLIDEGREE_PER_DEGREE, false, enable);
 }
 
 static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+	int val;
 
-	val = readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG);
-	*temp = ((val & LOONGSON2_THSENS_OUT_MASK) - HECTO) * KILO;
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_8B_MASK,
+			readl(data->ctrl_reg + LOONGSON2_THSENS_OUT_REG));
+	*temp = (val - HECTO) * KILO;
 
 	return 0;
 }
 
+static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
+					    int temp, bool low, bool enable)
+{
+	u32 sel = data->chip_data->thermal_sensor_sel;
+	int ctrl_reg;
+	u16 val;
+
+	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	val = FIELD_PREP(LOONGSON2_THSENS_CTRL_GATE_MASK, temp + HECTO) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_INTEN, enable) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_SEL_MASK, sel);
+	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
+}
+
 static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
-	int val;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
+	int val;
 
-	val = readl(data->temp_reg);
-	*temp = ((val & 0xffff) * 820 / 0x4000 - 311) * KILO;
+	val = FIELD_GET(LOONGSON2_THSENS_OUT_16B_MASK, readl(data->temp_reg));
+	*temp = (val * LS2K2000_TEMP_MUL / LS2K2000_TEMP_DIV - LS2K2000_TEMP_OFFSET) * KILO;
 
 	return 0;
 }
 
+static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
+					    int temp, bool low, bool enable)
+{
+	u32 sel = data->chip_data->thermal_sensor_sel;
+	u32 hi_reg, ctrl_reg;
+	u8 gate_lo, gate_hi;
+	int val, gate;
+
+	gate = (temp + LS2K2000_TEMP_OFFSET) * LS2K2000_TEMP_DIV / LS2K2000_TEMP_MUL;
+	gate_lo = FIELD_GET(LS2K2000_GATE_LO_MASK, gate);
+	gate_hi = FIELD_GET(LS2K2000_GATE_HI_MASK, gate);
+
+	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
+
+	/* Disable INTEN first so a torn 16-bit gate is never compared */
+	val = FIELD_PREP(LOONGSON2_THSENS_CTRL_GATE_MASK, gate_lo) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_INTEN, 0) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_SEL_MASK, sel);
+	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
+
+	/* High byte of the gate value goes to the low byte of the HI_GATE register */
+	writeb(gate_hi, data->ctrl_reg + hi_reg + sel);
+
+	/* Re-enable with the complete {gate_hi, gate_lo} in place */
+	val = FIELD_PREP(LOONGSON2_THSENS_CTRL_GATE_MASK, gate_lo) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_INTEN, enable) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_SEL_MASK, sel);
+	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
+}
+
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 {
 	struct thermal_zone_device *tzd = dev;
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tzd);
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	thermal_zone_device_update(tzd, THERMAL_EVENT_UNSPECIFIED);
 
@@ -108,8 +169,9 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	return loongson2_thermal_set(data, low / MILLIDEGREE_PER_DEGREE,
-				     high / MILLIDEGREE_PER_DEGREE, true);
+	loongson2_thermal_set(data, low, high, true);
+
+	return 0;
 }
 
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
@@ -155,7 +217,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 	if (irq < 0)
 		return irq;
 
-	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
+	writeb(LOONGSON2_THSENS_INT_CLR, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
 	loongson2_thermal_set(data, 0, 0, false);
 
@@ -184,11 +246,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k1000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = 0,
+	.set_trips_regs = loongson2_2k1000_set_trips_regs,
 };
 
 static const struct loongson2_thermal_chip_data loongson2_thermal_ls2k2000_data = {
 	.thermal_sensor_sel = 0,
 	.flags = LS2K2000_THSENS_OUT_FLAG,
+	.set_trips_regs = loongson2_2k2000_set_trips_regs,
 };
 
 static const struct of_device_id of_loongson2_thermal_match[] = {
-- 
2.52.0

