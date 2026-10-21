Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792623245;
	b=gt3YphBFy65EhVED/J5bjdKqTGClqijKFU0HG34wxVjz/QSC8J5CxZYstPiZeK7lonKE
	 z9GXd2sHo6+kcct66kpuz5dTjY1Z1IL2/n9utit4JIHxnYV0L/weZho0faKB7UCKeMXID
	 +V6Oad86yV7IhWlMgUd/oNHxK+sFSfbfMr41SOu/cTLpOw2/Ry3oeM9NkcnffdyHAO/iE
	 kp2qOouBrN2VMVAYJUBoVO8JnGG+FnH6x/pJLPImm5b1GXkS/lG8eoWHRuOLWZ5p4PEMm
	 UH1ZsGouDZZ0rs4+M1NWQ1XwPPJ2RaB3AUFWTPoW84ee8LEm3YjeW2zI2MJNJ8V9lRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792623245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Og+YgCk31Ft1aKtiGGPovDF1opI3usAtawTXGFK4Kuo=;
	b=AC3EMhihQ8Gv8Nm+3maaRUUMZ5eQHWm0ra5oS0OyLO3CUIhbC/zIjsWx5k3+P4mXIEnX
	 4SS/a2GyPBqOMA1bZhCYnn8Yatuox4HSSPv4JFGci+N4353vpI86ej81Qvf0nEZvv3R4F
	 dBtmzMYyKWMJEY9kYvuLt85SflJ8GCOkGGar7yY+bXSFvZWWVPdVkhhI6EDtAxFSZcPiP
	 yNDQ+dXNrVkK1Zs9GgqIYCRpcgJ6ipayJ4Hbg/okRRLC73fKrbbgWeIpDIUkiYIGL9Gcz
	 LcGTHpHSxaCbLe77mEFPCiOC7bGC5Q2yEuEmNRYAo6zWyjZ5z7etskcW2fJh26W8bcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YvPKHfMT;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FB0606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 22:54:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12FB0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=YvPKHfMT
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-35f036b17easo1437607eec.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792623244; x=1793228044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Og+YgCk31Ft1aKtiGGPovDF1opI3usAtawTXGFK4Kuo=;
        b=YvPKHfMTH8xkUFhhJ+uX4L4AW2Y6H/f2dIb6RgYs29EEX/7AiY2hZ192tuLRv2FwKZ
         4JOWRCBKRcJ3ilpIuZno2sMLiYqHd3Yr4Xy30VOJg7tQHo0zH/IRm3Z1gYKXiT+QBk0/
         /Cr/gO9gDYKQEjXpfsRkRtAV/ZJwVW5DSJ8KquWPkDmiRIWMkMzToPEPXJOY9Xsb9BOt
         XrvrKJtD+jxjsTMxb4MtUjczburSVjFbsvLJN32tQ8DJ3DPhkO3TBm11wbD0WWcicrwM
         6cz5IDC3A0aImPA3zNASlM1dSb/7xNJKGw0kXkTZ/f+wIJaY38M7Sm8y+wHap7J6Ahud
         q+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792623244; x=1793228044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Og+YgCk31Ft1aKtiGGPovDF1opI3usAtawTXGFK4Kuo=;
        b=TYYPH0dV+su74ELzCeZZ/k0nsH+iMN3eWCtDn5ceTjwBy0C7FHOK8IXG7G/gANNSEr
         houfSSXajPUp691mpX8dJpuMSCdl2WQvkkQsGW4YWbzUhfVA2p822Qvz8vXVk5WU+eo8
         Z/YbRoRE+PtBEBuS6kUJZiy+3UAO2IEgy+f171QYPmoH60hf26hYmOuu3PgpvHnFX2mN
         mYhbG0FkGLQW0lcI+Cr5R2CaiSVHoWrq/YSSMyMHIn/cxn+QHGPudoaZLDWtEUE/npVC
         DC3rGaXQWy1DzZfp67pC3ngPsmAln+aDRI3CREzX7qsr+lSW9KD/tzMQa4HIHfZTbLTM
         Dd2Q==
X-Forwarded-Encrypted: i=1; AKwUvByyynot9wTGSExuLikUsbPgIzkRr5rOLStHhz/Dh/VO4sSubrekA7T2jrrHytjcfUxSy9zWmIM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUiXstotLHLz1HdU6T0NbtelPDj74TzA1IdAiEcgTiaWxjSUjF
	r3fXE1pwZiw6jyl7geXgg0geKlVgQvPP9wkgNAavw/J8vcl1Zy/PtCdj
X-Gm-Gg: AYBFou0XQqVqI5vV++NwKUOefDy/FtLBrquM/JV1t/ZPwntsGQnCA7Y5Ukcd+Ilt9Fb
	Hg6BMb5PyhnFz9GUBRP9LYFvzoeMF9dVEvGPXCM0ymf/pXaZAMweuTsGFpZR3Phlr+0Bn6dzuVs
	WBL4ogsrBXtKI0loEBL+zG1M0uEd6uyGWkIv8GAHXiOhziTxojLgwv1xKHcOa+2p3mSAOfxk5ji
	vpNvuX2JEIDV8Yzoj8cKLYNq4EB42JEmcW8S1cVrbFBvjh4KOTNlORIk1w7b7MDI59yOOwEGxRT
	5g4mOKqVip9cTQiDR27NAYukWNRrELV24dvsf/WY9i7WSzFq7pax9EW+nEbvoM+0ID6I9EAlwVZ
	aXo/BeoQUR69D+jtlD/wPLgHWMF7PrLyP+SJrAi9KeSREtGZisYAcaA4COew1I/GNqpOm87SjRY
	4EQP/G2u+Ay3ZRcuK43aJVYRrWnl7vop4/m80IqppMbH6eGW5I6Hf/sPJpZcWVrITIuilHHcrJj
	M/K2qH9Ujl/J68wG3MF28InHHwYsoHR8xXeUg82ElIoQFkSS9pF50e6Si7Xk+hvRsbYsQ+2v2f/
	zKsVBNFuG4SUhJaF3foLC2Y6Pz+hk7YI6FWyTyjG+eQztKTIEMWnmcO26q3/Yd083k2FaiRNvfH
	MsPNhK4qsfgQ=
X-Received: by 2002:a05:7300:d58a:b0:35b:9f06:e383 with SMTP id 5a478bee46e88-3674e450e8emr5262441eec.8.1792623244093;
        Wed, 21 Oct 2026 15:54:04 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-367411b4145sm11999808eec.15.2026.10.21.15.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 15:54:03 -0700 (PDT)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	"Conall O'Griofa" <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
	Manish Narani <manish.narani@xilinx.com>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	stable@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: xilinx-ams: fix out-of-bounds accesses when
Date: Thu, 22 Oct 2026 04:23:34 +0530
Message-ID: <20261021225356.625288-1-kapoorarnav43@gmail.com>
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

This was previously reported by Weigang He, but the thread stalled
before the changes were picked up.

Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
Cc: stable@vger.kernel.org
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/adc/xilinx-ams.c | 57 ++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/xilinx-ams.c b/drivers/iio/adc/xilinx-ams.c
index 158e6133abf5..0077a88da52c 100644
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
+			    int max_channels)
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
@@ -1183,7 +1201,7 @@ static void ams_iounmap_pl(void *data)
 
 static int ams_init_module(struct iio_dev *indio_dev,
 			   struct fwnode_handle *fwnode,
-			   struct iio_chan_spec *channels)
+			   struct iio_chan_spec *channels, int max_channels)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct ams *ams = iio_priv(indio_dev);
@@ -1191,6 +1209,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 	int ret;
 
 	if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-ps")) {
+		if (max_channels < ARRAY_SIZE(ams_ps_channels))
+			return -ENOSPC;
+
 		ams->ps_base = fwnode_iomap(fwnode, 0);
 		if (!ams->ps_base)
 			return -ENXIO;
@@ -1202,6 +1223,9 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		memcpy(channels, ams_ps_channels, sizeof(ams_ps_channels));
 		num_channels = ARRAY_SIZE(ams_ps_channels);
 	} else if (fwnode_device_is_compatible(fwnode, "xlnx,zynqmp-ams-pl")) {
+		if (max_channels < AMS_PL_MAX_FIXED_CHANNEL)
+			return -ENOSPC;
+
 		ams->pl_base = fwnode_iomap(fwnode, 0);
 		if (!ams->pl_base)
 			return -ENXIO;
@@ -1213,9 +1237,15 @@ static int ams_init_module(struct iio_dev *indio_dev,
 		/* Copy only first 10 fix channels */
 		memcpy(channels, ams_pl_channels, AMS_PL_MAX_FIXED_CHANNEL * sizeof(*channels));
 		num_channels += AMS_PL_MAX_FIXED_CHANNEL;
-		num_channels = ams_get_ext_chan(fwnode, channels,
-						num_channels);
+		ret = ams_get_ext_chan(fwnode, channels, num_channels,
+					max_channels);
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
@@ -1234,7 +1264,7 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	struct fwnode_handle *fwnode = dev_fwnode(dev);
 	size_t ams_size;
 	int ret, ch_cnt = 0, i, rising_off, falling_off;
-	unsigned int num_channels = 0;
+	int num_channels = 0;
 
 	ams_size = ARRAY_SIZE(ams_ps_channels) + ARRAY_SIZE(ams_pl_channels) +
 		ARRAY_SIZE(ams_ctrl_channels);
@@ -1245,7 +1275,8 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 		return -ENOMEM;
 
 	if (fwnode_device_is_available(fwnode)) {
-		ret = ams_init_module(indio_dev, fwnode, ams_channels);
+		ret = ams_init_module(indio_dev, fwnode, ams_channels,
+				      (int)(ams_size - num_channels));
 		if (ret < 0)
 			return ret;
 
@@ -1253,7 +1284,9 @@ static int ams_parse_firmware(struct iio_dev *indio_dev)
 	}
 
 	device_for_each_child_node_scoped(dev, child) {
-		ret = ams_init_module(indio_dev, child, ams_channels + num_channels);
+		ret = ams_init_module(indio_dev, child,
+				      ams_channels + num_channels,
+				      (int)(ams_size - num_channels));
 		if (ret < 0)
 			return ret;
 

