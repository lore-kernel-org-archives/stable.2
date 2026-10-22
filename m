Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677985;
	b=cGMBKttVOtrgjGc0NvkaHBIhv3zcRB1tXwgbnzAtnBs86ZPZQxqXjFko6EWV3u0QNv6C
	 5qMXTTbL9Id81Q6U9wBLgO3VEPcZuUisia+1XJ3m/cCPth5sl2vpxMca0oAeVkQB91THv
	 m01gNEaYdeVZJorlenn9SHP++k1tL7MlxTF6/G8O6NocYC0rw6JVtCbwh9TFfSusU8oOJ
	 W52tCUvebSyDNZYk0HSX49Um2hAwXM4E1ZodI6GBVmKKPqkAxj5TC26s20Dhba/3aobPR
	 IFHdyWiDFA+Sjf1TFaxBiI18jirhoGRMwqlOGVdrJQ4hb1eiVf1uE22gPIbQUS1C4Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
	b=Qvoan9M7VHIP0y5HahRAbJiB3Pk5VdaWRiCiQKy+rp97eGamaQb5i9Abk+sco9IXNe+f
	 pNyEGdv2bCdAzUsjWig/rLEEH08iqign04cbmH6o7fH3XaB8A7xpjPklCPmbwnCRnML4r
	 5o9HKfapRM8zdxYevjP6mkbrmvI7ciytKV6VjbkKlW9niOgDU4YVrOLaGHXmrCQQvJ/N3
	 RhFOQ6vHWSjeLNhJ7ntusv5/raPvYsDMIq7sHfRWIeBmhVnhjLJJZACjkHyXW23SvlGcs
	 ndL00XSK9+APn4mpXgJAfos/7vJBzL60tInk7rGLlSARXGCVaCE07aVP/+ECerb/YWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I73p09gQ;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2885F606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2885F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I73p09gQ
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33fb4680717so4561644eec.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677984; x=1793282784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
        b=I73p09gQ/KJIuHA6CQVeOcWZU5MX4hhQyxC5umZbySnjBIbHOxucJkBoMaL5uH/JnD
         uugF2MYQWLR+kYmSjvfHBBMPvJgSTTpFyxsGQc88dOKTxpZf3eINmeEVODJhLWSkqNv8
         PTCLvp4Bg5Hsln9m38+/a4u3zyUMcVPFEe7f6L574dfDUY9Oh78vRkO0NCcvQdUZbbjA
         tTb+zORfip5y2Yd7VR5t5CSMo0Y77GX7ImGJ48KkcY6ExMR/Wz0NP8Z5WpVVRrhfS6/J
         kDYJKEq5+9XYtB7so9OV90V6c5AjXLVDblkl9+zXzkNSS2jTP5HxeI1a/yt6KtszH3mQ
         SV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677984; x=1793282784;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3RexKatP1kjoAD+7UX1aOwf4BjKeEG2GX7OI7aVWc0=;
        b=TZ73t7JJTcasdxLeUWvhV/sM8G4YgSaA4xEEeLsEusuyEHJ2JP+1luzlTciDCS1q54
         deQCltjwNE3wl4Tl9yMMFhjaIi7KhKXZjYSML24P7WdjGYGzCFGxk2rAQkavGd01bW28
         1J5QzVRM0/+bazXmnXYfHw7Fg4Kk507rRYV4qvSzGHWIpO3zS3osjGEJmjISu7J8rGUm
         bG7wP4fmezR1t8Ht9VO4idcXG4ET4Z16PnMtDP+7DN+9TnYU7ZoPysFmC6nutUEOvgbO
         iLWyEC71AvuXu1+QtjDqexfD1ky/jlwHOdSLDVAIeMgIBWBvzBPvwzB50uJh0e27ErhR
         KXwQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDVJlIe8VXUhnK8AmvGrIQdBwkdzD5/q5wH8eqwflqBeVtgzclcV4ikplBCUpRweVeoNmaVC0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIlkokifZwGILbJlpMUK2aMlmi39r/vLWiHWc3KA6MIi2H3AgdA
	wBAX2cOtAcYhlwnULzAdFNpfexKWm23cxbzYB0fJdkKm3UR/h9deMFm3
X-Gm-Gg: AYBFou3p5S0rD5kLwHM1feuB99t67LD1q+zWu+hBS/sDNqOKDN/30yl4+JO0BnojYZE
	RvcG4K5+/AP6WhpICKHofMvHZ5xAmSsNfNkzygWGOSQPUlyb+g7qC0rXhKtG3q/YwtP/WYFXr/w
	WDTKdnvV7gOfKN6/qmkGlUSc8m9A282H87c6NdiFwW4KcsdmDTdXny5LUpMHynq6N8tenL35mcy
	TOdBHD2hFJolya2AAVtN1gYZYnR0jBeXDxhIZAW/k433UITQMeYy5VP8+7jX8mA7npJoFhshPly
	OagWidMyJOCsbLYysIKGbrWw8uQWqlNHwHjcSzlyGGT0H4nqlzh6E+3cSHGB/rob3nsl4jnncvu
	VkwzA+ghVwLlFy3AEyLp2FmId2Gh6cRjhq7W/Nz3Vv2cFfLWnN9sgaVbYlwM7cCM4ZoBGVLcV9O
	A9G2C3C40P5aPMa15u/zlfE/NtI0P3Xj8Pz9mHfZGAePk9akIEcl/HdoxmfRQRhqxc/Ax7Usszr
	9aL4kL4xDMGIH96AdGtx6EvVVe6YvRCYFVzr+Cvn2/gGVFwRkFshe+5nYzQ7F/AnykDKEAWmSFV
	edzHwXLNpnc2RGK9k7hB453Tev+F8873nmtvR1FIOTGnt1JV0MNGMYiipkSjecm+TA8gnDYSWGC
	u7yxiFDwdKvc=
X-Received: by 2002:a05:693c:810e:b0:367:941:c253 with SMTP id 5a478bee46e88-3674c93b096mr7616489eec.11.1792677983998;
        Thu, 22 Oct 2026 07:06:23 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367405ee5eesm14960559eec.8.2026.10.22.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:06:23 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	stable@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] iio: adc: xilinx-ams: fix out-of-bounds accesses when parsing channels
Date: Thu, 22 Oct 2026 19:36:13 +0530
Message-ID: <20261022140615.30710-1-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
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

ams_parse_firmware() allocates room for ARRAY_SIZE(ams_ps_channels) +
ARRAY_SIZE(ams_pl_channels) + ARRAY_SIZE(ams_ctrl_channels) = 51
channel specs and lets ams_init_module() fill them for the AMS node and
each of its children, without telling it how much room is left.

For the PL-SYSMON node, ams_get_ext_chan() appends one channel per
"channel@N" child after the 10 fixed PL channels. The binding allows
reg values 20..50, so a PL node can have up to 31 such children, i.e.
up to 41 PL channels, while only 31 are budgeted for it. Together with
the 13 PS and 7 AMS control channels, this writes past the end of the
buffer. Since the modules are filled in device tree order, the fixed
channel blocks copied after the PL node can overflow as well.

ams_get_ext_chan() also only checks the upper bound of reg. ext_chan is
unsigned, so a reg below 20 makes it wrap and ams_pl_channels[] is read
far out of bounds.

Pass the remaining capacity down to ams_init_module() and
ams_get_ext_chan() and fail with -ENOSPC when a module does not fit,
instead of writing past the buffer. Also reject reg values below 20, as
the binding requires.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
Changes in v2:
- Fix the truncated subject line (Andy)
- Drop the paragraph about an earlier report, I could not find that
  thread again to reference it properly
- Pass the remaining capacity as unsigned int and drop the casts (Andy)
- Keep the ams_get_ext_chan() call on one line (Andy)
- Rebase on fixes-togreg
- Drop the bouncing @xilinx.com and @huawei.com addresses from Cc

v1: https://lore.kernel.org/all/20261021225356.625288-1-kapoorarnav43@gmail.com/

Compile-tested only (W=1); I don't have ZynqMP hardware.

 drivers/iio/adc/xilinx-ams.c | 54 ++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf5..7f0f7778d6aa 100644
--- a/drivers/iio/adc/xilinx-ams.c
+++ b/drivers/iio/adc/xilinx-ams.c
@@ -144,7 +144,14 @@
 #define AMS_PL_CSTS_ACCESS_MASK		BIT(1)
 
 #define AMS_PL_MAX_FIXED_CHANNEL	10
-#define AMS_PL_MAX_EXT_CHANNEL		20
+/*
+ * The external PL channels are addressed by their channel number. The
+ * binding allows the range from AMS_PL_EXT_CHANNEL_MIN to
+ * AMS_PL_EXT_CHANNEL_MAX. AMS_PL_EXT_CHANNEL_MIN maps onto the first
+ * ams_pl_channels[] entry, AMS_PL_EXT_CHANNEL_MAX onto the last one.
+ */
+#define AMS_PL_EXT_CHANNEL_MIN		20
+#define AMS_PL_EXT_CHANNEL_MAX		50
 
 #define AMS_INIT_POLL_TIME_US		200
 #define AMS_INIT_TIMEOUT_US		10000
@@ -1142,20 +1149,31 @@ static const struct iio_chan_spec ams_ctrl_channels[] = {
 };
 
 static int ams_get_ext_chan(struct fwnode_handle *chan_node,
-			    struct iio_chan_spec *channels, int num_channels)
+			    struct iio_chan_spec *channels, int num_channels,
+			    unsigned int max_channels)
 {
 	struct iio_chan_spec *chan;
-	struct fwnode_handle *child;
 	unsigned int reg, ext_chan;
 	int ret;
 
-	fwnode_for_each_child_node(chan_node, child) {
+	fwnode_for_each_child_node_scoped(chan_node, child) {
 		ret = fwnode_property_read_u32(child, "reg", &reg);
-		if (ret || reg > AMS_PL_MAX_EXT_CHANNEL + 30)
+		if (ret)
+			continue;
+
+		/*
+		 * Anything outside of the range of channel numbers allowed
+		 * by the binding is not a valid channel.
+		 */
+		if (reg < AMS_PL_EXT_CHANNEL_MIN ||
+		    reg > AMS_PL_EXT_CHANNEL_MAX)
 			continue;
 
+		if (num_channels >= max_channels)
+			return -ENOSPC;
+
 		chan = &channels[num_channels];
-		ext_chan = reg + AMS_PL_MAX_FIXED_CHANNEL - 30;
+		ext_chan = reg - AMS_PL_EXT_CHANNEL_MIN;
 		memcpy(chan, &ams_pl_channels[ext_chan], sizeof(*channels));
 
 		if (fwnode_property_read_bool(child, "xlnx,bipolar"))
@@ -1183,7 +1201,8 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels,
+			   unsigned int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1210,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -ENOSPC;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1224,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -ENOSPC;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1213,9 +1238,14 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* Copy only first 10 fix channels */
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
-		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+		ret = ams_get_ext_chan(fwnode, channels, num_channels, max_channels);
+		if (ret < 0)
+			return ret;
+		num_channels = ret;
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams")) {
+		if (max_channels < ARRAY_SIZE(ams_ctrl_channels))
+			return -ENOSPC;
+
 		/* add AMS channels to iio device channels */
 		memcpy(channels, ams_ctrl_channels, sizeof(ams_ctrl_channels));
 		num_channels += ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1275,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels, ams_size);
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1283,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child,
+				      ams_channels + num_channels,
+				      ams_size - num_channels);
 		if (ret < 0)
 			return ret;
 

base-commit: 2ef6f5c4ee56e90c237c5f7687f09e635f7d30a9
-- 
2.53.0

