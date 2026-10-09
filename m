Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F243D4A32;
	Fri,  9 Oct 2026 02:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791514707; cv=none; b=YpT85rjULh+1uDvFEFifM0UMD/KtLsnqgHDBve4yZA9UT0hd84Hkbr4Q+BB5JPQ9mD+v793Kk4/8ePwTikMJ0aLx/pqN5bolW/9HE5b04nGQAWkkfIQ8VvNfVBB/bcTUQ7iWqbhlnRZ3tEbpowM/EhD6Idt6Q7PHatCFP+NnEUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791514707; c=relaxed/simple;
	bh=3PfvAjZjGpyFcLwQg+lYGMHCs6q26czKbJ4mqsMssHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QJleUBXxONIScIXkmHhOHjI/ryGUvINVvjIg6EVen0vVE4bAEBb3+gScG++Z4l7kmXjZZDnab0ORQu1njXa4e9GXVxLXqgopmcOoKPbbFN3MT7mhguHja3nAG2xDU7TzOwTDFKpTX++em5pCh+pRzHHK/0yq0L3yU9XoA6aKyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8AxXdJOWMhqVfwTAA--.58653S3;
	Fri, 09 Oct 2026 10:58:22 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxBc1IWMhqs0wqAA--.61609S2;
	Fri, 09 Oct 2026 10:58:17 +0800 (CST)
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
Subject: [PATCH v7 3/8] thermal/drivers/loongson2: Fix Loongson-2K2000 trip point programming
Date: Fri,  9 Oct 2026 10:58:09 +0800
Message-ID: <93d78dbedc091117d8fc7ecb29a0fdf2a6d096b7.1791512067.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791512067.git.zhoubinbin@loongson.cn>
References: <cover.1791512067.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxBc1IWMhqs0wqAA--.61609S2
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/1tbiAgEPCGrHCfokXwAAsh
X-Coremail-Antispam: 1Uk129KBj93XoW3Gr1xGry5XrW3Zr4xuFWUZFc_yoWxGFy7p3
	47A3s8KF4DJr4ku398A34kXrWYyry3t3sxZFs7G34fW395G343Wry8tF1FqFWIkFyDJFyj
	vrWkKFWUua1DW3gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jz-eOUUUUU=

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
 drivers/thermal/loongson2_thermal.c | 78 +++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 22 deletions(-)

diff --git a/drivers/thermal/loongson2_thermal.c b/drivers/thermal/loongson2_thermal.c
index 46785bafab16..2a31a1f8673e 100644
--- a/drivers/thermal/loongson2_thermal.c
+++ b/drivers/thermal/loongson2_thermal.c
@@ -29,15 +29,23 @@
 					 LOONGSON2_THSENS_INT_HIGH)
 #define LOONGSON2_THSENS_OUT_MASK	0xFF
 
+/* Loongson-2K2000-Specific Registers */
+#define LS2K2000_THSENS_HI_GATE_HI_REG	0x18
+#define LS2K2000_THSENS_HI_GATE_LOW_REG	0x1c
+
 /*
  * This flag is used to indicate the temperature reading
  * method of the Loongson-2K2000
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
@@ -46,30 +54,40 @@ struct loongson2_thermal_data {
 	const struct loongson2_thermal_chip_data *chip_data;
 };
 
-static void loongson2_set_ctrl_regs(struct loongson2_thermal_data *data,
-				    int ctrl_data, bool low, bool enable)
+static void loongson2_thermal_set_trip_temp(struct loongson2_thermal_data *data,
+					    int low, int high, bool enable)
 {
-	int reg_ctrl = 0;
-	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
-	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	low = clamp(low, -40000, 125000);
+	high = clamp(high, -40000, 125000);
 
-	reg_ctrl = ctrl_data + HECTO;
-	reg_ctrl |= enable ? 0x100 : 0;
-	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
+	/* Set low temperature threshold */
+	data->chip_data->set_trips_regs(data, low / (int)MILLI, true, enable);
+
+	/* Set high temperature threshold */
+	data->chip_data->set_trips_regs(data, high / (int)MILLI, false, enable);
 }
 
-static int loongson2_thermal_set(struct loongson2_thermal_data *data,
-				 int low, int high, bool enable)
+static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
 {
-	/* Set low temperature threshold */
-	loongson2_set_ctrl_regs(data, clamp(low, -40, 125), true, enable);
+	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
 
-	/* Set high temperature threshold */
-	loongson2_set_ctrl_regs(data, clamp(high, -40, 125), false, enable);
+	loongson2_thermal_set_trip_temp(data, low, high, true);
 
 	return 0;
 }
 
+static void loongson2_2k1000_set_trips_regs(struct loongson2_thermal_data *data,
+					    int temp, bool low, bool enable)
+{
+	int reg_ctrl = 0;
+	int reg_off  = data->chip_data->thermal_sensor_sel * 2;
+	int ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+
+	reg_ctrl = temp + HECTO;
+	reg_ctrl |= enable ? 0x100 : 0;
+	writew(reg_ctrl, data->ctrl_reg + ctrl_reg + reg_off);
+}
+
 static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int val;
@@ -81,6 +99,27 @@ static int loongson2_2k1000_get_temp(struct thermal_zone_device *tz, int *temp)
 	return 0;
 }
 
+static void loongson2_2k2000_set_trips_regs(struct loongson2_thermal_data *data,
+					    int temp, bool low, bool enable)
+{
+	unsigned int sel = data->chip_data->thermal_sensor_sel;
+	int hi_reg, ctrl_reg, val, gate;
+
+	gate = (temp + 311) * 0x4000 / 820;
+
+	/* Low byte of the gate value goes to the control register */
+	ctrl_reg = low ? LOONGSON2_THSENS_CTRL_LOW_REG : LOONGSON2_THSENS_CTRL_HI_REG;
+	val = gate & 0xff;
+	val |= enable ? 0x100 : 0;
+	val |= sel << 10;
+	writew(val, data->ctrl_reg + ctrl_reg + sel * 2);
+
+	/* High byte of the gate value goes to the low byte of the HI_GATE register */
+	hi_reg = low ? LS2K2000_THSENS_HI_GATE_LOW_REG : LS2K2000_THSENS_HI_GATE_HI_REG;
+	val = (gate >> 8) & 0xff;
+	writeb(val, data->ctrl_reg + hi_reg + sel);
+}
+
 static int loongson2_2k2000_get_temp(struct thermal_zone_device *tz, int *temp)
 {
 	int val;
@@ -104,13 +143,6 @@ static irqreturn_t loongson2_thermal_irq_thread(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
-static int loongson2_thermal_set_trips(struct thermal_zone_device *tz, int low, int high)
-{
-	struct loongson2_thermal_data *data = thermal_zone_device_priv(tz);
-
-	return loongson2_thermal_set(data, low / (int)MILLI, high / (int)MILLI, true);
-}
-
 static const struct thermal_zone_device_ops loongson2_2k1000_of_thermal_ops = {
 	.get_temp = loongson2_2k1000_get_temp,
 	.set_trips = loongson2_thermal_set_trips,
@@ -156,7 +188,7 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
 
 	writeb(LOONGSON2_THSENS_INT_EN, data->ctrl_reg + LOONGSON2_THSENS_STATUS_REG);
 
-	loongson2_thermal_set(data, 0, 0, false);
+	loongson2_thermal_set_trip_temp(data, 0, 0, false);
 
 	for (i = 0; i <= LOONGSON2_MAX_SENSOR_SEL_NUM; i++) {
 		tzd = devm_thermal_of_zone_register(dev, i, data, thermal_ops);
@@ -183,11 +215,13 @@ static int loongson2_thermal_probe(struct platform_device *pdev)
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

