Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690712;
	b=AHYxL3WIFqzkdUxzgWitiiYS/C64wiMKSaLMc8gbS2ECgCilxdmxEUl6H/mWweJf1yBF
	 DhAngdIOsAOCkgdBqz/LsF6/LTjRWL2rcPS+tLBCbsMUXppp5NZT1rfcafrmN8UOAJb9K
	 CKdL3nOiU6Er6UWM80Wyy9oYV0BQ6TUPmI39cqqiZQHoTeHXGirJs+FCZebuy0QCixWBS
	 ac/RO84mwN3w94Npcg0c/u23KDGiLU7Z/lF7dzXA2BUrAyrLLP7hppaaQgkdQryRnrzhN
	 1KDuQ7tEetK+vFIDupngP7ij6MMVUsEHSQ1/izkAwscvHDF67gRhdj3IP0yAO15FA5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690712;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=GKZt7E+6RFvUkOi9WjhHDYw3H/mOmjALdsjcmsLaYOA=;
	b=opxOMJfXMMm1mNsHYYq5Gwv34q0wz5G+Pa5DyaJMQ7R4e2zA6mbyYAHV7eTiXG5cqSpO
	 4Qyrq97dYgLEC0XZxKYHAwMnwEnFnRLqnm3nFOdY5zac92bzRMY/62Kjq7tF3MuUSFFTu
	 BpfcM2evRbIE3JGT1Busp1x0JdumHnWMit/L7q6j4e+YaTKd+VEMUB5w6flb8sjRcUQWe
	 13AktNQ/JiN0Ghb9SZernoEgLG9iieQaiCVsVFvfiyyJQ+akJQUdz0XEr2mK36Qd1LyfO
	 jSPaOZ92gpiobjoJK4qpHvscho4xR6HNojfSWJvqou+SNSv1t9zdU39ssISzFerw+cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7C606A329;
	Tue,  3 Nov 2026 07:25:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5BA7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.17])
	by gateway (Coremail) with SMTP id _____8CxfdJVjOlqDd4bAA--.15173S3;
	Tue, 03 Nov 2026 15:25:09 +0800 (CST)
Received: from kernelserver (unknown [223.64.69.17])
	by front1 (Coremail) with SMTP id qMiowJCxNs1TjOlq5hUyAA--.24081S2;
	Tue, 03 Nov 2026 15:25:08 +0800 (CST)
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
Subject: [PATCH v8 3/7] thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
Date: Tue,  3 Nov 2026 15:24:58 +0800
Message-ID: <be63b7587997d75507ac2a28f2276ad45ace4196.1793690276.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowJCxNs1TjOlq5hUyAA--.24081S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEACGrpUP0D0QAAs3
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1xGry5XrW3ury7JrWDGFX_yoW3Gr18p3
	47C3y3KFs8Jr48uw4UA3WkWrWYyrW3tasxZFs7Gw13Xws5t34agry8tF1FqFWIkFyDJFy2
	vrWv9FW7ua1DX3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
	wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	Jw0_WrylYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjxU25fHUUUUU

The Loongson-2K2000 splits its 16-bit gate value across the control
register (low byte) and a dedicated HI_GATE register (high byte), and
derives the gate value from the target temperature with a different
formula than the Loongson-2K1000.

Add a per-SoC set_trips_regs callback and implement the Loongson-2K2000
variant alongside the existing Loongson-2K1000 one.

Cc: stable@vger.kernel.org
Fixes: 734b5def91b5 ("thermal/drivers/loongson2: Add Loongson-2K2000 support")
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 drivers/thermal/loongson2_thermal.c | 102 +++++++++++++++++++++-------
 1 file changed, 76 insertions(+), 26 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 9256cd3663e6..8be0c6a29efe 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
  */
 
+#include <linux/bitfield.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/minmax.h>
@@ -27,7 +28,24 @@
 #define LOONGSON2_THSENS_INT_HIGH	BIT(1)
 #define LOONGSON2_THSENS_INT_EN		(LOONGSON2_THSENS_INT_LO | \
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
 
 /*
  * This flag is used to indicate the temperature reading
@@ -35,9 +53,13 @@
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
@@ -46,52 +68,77 @@ struct loongson2_thermal_data {
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
+	low = clamp(low, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
+	high = clamp(high, LOONGSON2_LOWEST_VALID_TEMP, LOONGSON2_HIGHEST_VALID_TEMP);
 
-	reg_ctrl = ctrl_data + HECTO;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
-}
-
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
+	unsigned int sel = data->chip_data->thermal_sensor_sel;
+	int hi_reg, ctrl_reg, val, gate;
+
+	gate = (temp + LS2K2000_TEMP_OFFSET) * LS2K2000_TEMP_DIV / LS2K2000_TEMP_MUL;
+
+	/* Low byte of the gate value goes to the control register */
+	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	val = FIELD_PREP(LOONGSON2_THSENS_CTRL_GATE_MASK, gate) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_INTEN, enable) |
+	      FIELD_PREP(LOONGSON2_THSENS_CTRL_SEL_MASK, sel);
+	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
+
+	/* High byte of the gate value goes to the low byte of the HI_GATE register */
+	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
+	val = FIELD_GET(GENMASK(15, 8), gate);
+	writeb(val, data->ctrl_reg + hi_reg + sel);
+}
+
 static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 {
 	struct thermal_zone_device *tzd = dev;
@@ -108,8 +155,9 @@ static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low,
 {
 	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	return loongson2_thermal_set(data, low / MILLIDEGREE_PER_DEGREE,
-				     high / MILLIDEGREE_PER_DEGREE, true);
+	loongson2_thermal_set(data, low, high, true);
+
+	return 0;
 }
 
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
@@ -184,11 +232,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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

