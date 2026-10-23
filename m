Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781823;
	b=nSo4+j7oVaPr9B+7SquxdConbBDRS9+Q9OwnS1DhNucHN98ipTYlNpMSzyzhRCRA1Ioc
	 RPn7kmkfYCbqzAoHs6Xi4hzHPVIZmWegyHt9Vhur1ti0kPzAAaMd3PS6503eS1McaTR5N
	 P218N6QuvX7bpAW8HnkvVZ2sYFwOFKou3NTS5/WGfr3n6zjUVEPgAG3N8jZhj8f9T0k2I
	 unXge016jLhc3GlkvThmCeoCac2nUTRxU9KxK4mbGQc6OxHNLMGtVmpkbQ4Kc3X9BqqXN
	 XwrZB6lF3cxN/3IRjQZZVcKyJbd0yYJjcYSny9LozXoTZIn+7005or+KYah5BW8tlJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
	b=TzJ7FGs2iDn4SsorUrqSSTMamVYI/MtBDX7FYgsDSYqESnXq7K9Oo24fZGD8k5vV6QrC
	 2KaqeS025HsWfOnZF3QF9yFCp7pZQpoZetj4Aajx9Bg7FWUenYpQ3efXk3wPlJ+vrMrRe
	 ayVmJ1WqUt2s9TvZLO5aUe7Z7iH3wCh/wE+b3eZm1FbDrVZsdTYvdbs/I82BHWRYN2Bxm
	 jEODdRK2pxDA+hBl0C/nirkoaeY5TnKMzGkF1kBu/8v0rTT/vY4+rFHyVjfaB9N613wRJ
	 HMG9ctkx2mzHoQKSoIPOAMleSmJg8cP4npWX8JoA5ckOE+UXLRfnumvETywXFamyGYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a2HoFB;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41DA606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 18:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C41DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=h1a2HoFB
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3535a54bed9so1892767eec.1
        for <stable@vger.kernel.org>; Fri, 23 Oct 2026 11:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781822; x=1793386622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
        b=h1a2HoFBhB90ULo62DPYUdFx0VbproVRlBQpsPUL/4hrs9G6K58Lh2Ifvb2Ge52K9T
         1hIz7rTRHCkklodOUST+fRNVWggtny6YDXlL9u5/CcQIokKPAMl+HqOJhTmyIBQpt6MF
         GP6ny49KGymaaFif6ND1MJM87WE0zs5xhaygHZo1fPb8sJjwgGPKXe0j0yUCAO9nPmvD
         /R+PjUElHFFwInh+Mmcm5iMzDqJB6YXE+a4opx45aAWU5NlsudUk0iCZ+fouI3fETe7f
         eTGdW08XFZ+/UJU1OL6nd+zEOwSXpGvJoqV/5SFZw98Ih29FX5EbGMXswA106nKd6/BY
         HpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781822; x=1793386622;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tF8DCvJy02dv/dGl/c2kjNebK24DBSFwD813ICPFVCg=;
        b=Skc7aJc3rpxwQs6QHCgB+5QB0rxC3jRUxfzCb9TE8h8yeUk/XEwrHSWCo9Tzrf5ULk
         kCmUjzzKDW4R6WO/BDA+lXtP1F0j5W0yy3bvanQN/8rnxzSCgkK9JkUqdWB1rJAXOBOY
         QoWopRp7xoUa8TW9derErYW2EMYKM4C9HuIx3iBtcwH22z0IbJB4k6J9+DAfgOWGd+08
         4bN81j8ZZE9m6pagxEGqh2ykwPxGw+lLn4VFjH1FH16RLx4te2xm4AWsjmFdSxtAwguE
         o69focF24vBrSHP9BoFUe90MNHQceHqszSQry4yWScYA3vkVNNaUCY/ikYb9in+Iil87
         xH4w==
X-Forwarded-Encrypted: i=1; AKwUvBwYdB1ghgwJvbeph7d1wqQ10LP9/GDriqgSINqHBljc/rKMmQlcfMbhLE/8mBbVxF/f2cN+TsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLu4PAoBY6fTT9ekhK6MJOvtDtjpj5LY/sqqMShMGsG20o9SZ8T
	PC6CWkGvqlJSZdB21lYgWxppDa/M43mHzbya4FTJzAC45MUwbJVUcHSS
X-Gm-Gg: AYBFou35AgYPkzfu1QW+U18Pe0stQgFaUbIKjp0IxtirNCU+XocsHX9oMHD+bbbz1Mk
	QjzIdIQr5Ui2kWD+7HrroOw66BU0nJ0jPCtZO9TDgE295ZTLoxr+UcMkEQ/vj1T1qMaT5Ab37m8
	c0+nhRDfyK9Lh25yTRIZQgs2YBDpHznSJtkB5sIUa0xUF8MsXAUQrCljLD5G6469oqiu0H7oRIF
	p25TPM65NwIyBO+uxRpzTr62mxeX90FNIdZRHkHiNUNY9my81rj+zy4fXvDiRELvH1dBCG+LGiz
	g4Sc8AbkTqfJ/eoBpvfxryh42trmDiT1cujrv4z2qpMOYYkvS9LkprT59N8Vab8aG3z1Py5Pj91
	24x080sb4BQSd8E+sYx0O72fAfkM1d95QBTZT4sdB1qnxlk5P3uhzUQz0gjpjsxVWK4ZCzWFx2U
	LR9YNOcURxRgHktjnHE6RJtudfmztV3kXrFdclqrOuh79bEYQx2wi5KDSL2pM8WKnPFg4OYBDaw
	WhnW/YV3EpmxzxK/otQE+4Tmh+YkZr8S1ffZTRuAamnblKT5qBot9w/lL8ULhTIGPf9qlfjwUyu
	E08Bt3c+iQOeBVVyxz6eexO7cPngXw1+h3Qfn2xoEYlUitDblQraGzh8PLfzr6e0oxZKw6EEqSG
	yUrRpEbZH3s8=
X-Received: by 2002:a05:701b:4587:b0:195:238:b632 with SMTP id a92af1059eb24-195c72d8a3bmr3336033c88.38.1792781821511;
        Fri, 23 Oct 2026 11:57:01 -0700 (PDT)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2e32479sm308388c88.21.2026.10.23.11.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 11:57:00 -0700 (PDT)
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
Date: Sat, 24 Oct 2026 00:26:48 +0530
Message-ID: <20261023185652.195025-1-kapoorarnav43@gmail.com>
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

