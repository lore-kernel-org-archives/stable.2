Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602935;
	b=kI7X1eJtSYfMNZXiTIH0A7Lj+Ml0vkDY67j13wCjx8GnQwSm3jURtmNxjd2FW0WwpRDu
	 eAk5gwpwCQXalaEHsmhWPM2BSw9+Liz33SpoClx7iBhAgSYie18NbMNSHomCOxxBjLFUB
	 ScaVJ9+Qtc3K/q7sbMf9kNMjd7S4MEPPwxnMYc7sQIT7VoiHaM39HbEUjArK2jQgSTDTw
	 YlFDytffEpLW5PuKZMeajNUnHi3fcQkW1QTU9Lone8tv36BnjIbRnU8CqK/EWTsn6QT9/
	 F07h0HI/d09uqW1M6sS0vRv0EkfAI7Ylxxs5IPHBr4aT+T4P5whtYCrQ8lQhaqCiqZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602935;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=L28HCrPvG2cheYb5MZAbWcLByLhWGcxJiEVEuJFNd2M=;
	b=EMXj6pYuB2YhKSyoP9TZF0tMTgoTk7cCtGst3AfNFl1g+pe4m4Va19+v80iZ9ErB9jDc
	 sQvDFwUqOKrlE/nFs7CoqcXvp0PXkIp25hs2+zXa1DsR8G+gH1wmACW+U8nf2Z91Nn+Xp
	 vnyjky4qz0/FAxKBzTnjPZCaoQ6RnLhsXyFOULpVX7yBI/+Ss5Jow1yttjOjf1fTKRgm8
	 6Z1D8Elay2ehFddVqfjIlDgLC9Tp0ejfekZYdMuwXm/LY10mbA/5fjgA49IzhptEtSOhn
	 e//cFLypCB98FayjnyMxGhfdTqeXIRroaw01DTZCrqK74jUYC1wR6VGJONkhb+vNhZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AcZreidP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AcZreidP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968711F000C6;
	Wed, 25 Nov 2026 10:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795602935;
	bh=L28HCrPvG2cheYb5MZAbWcLByLhWGcxJiEVEuJFNd2M=;
	h=Subject:To:Cc:From:Date;
	b=AcZreidPT0gnp3BT2ihBY+DHjsCVIB9TIKV79rlpbSgpMw2feLcHAu4DFUZBIzLl6
	 dBTFfaXR3swsFbDzSo0bzy6KBH2R+2Gcpn8WKeb0anSR1N6J/45cuzcs4s0IWPbi6o
	 0swVn0grpavxvAW2FXqwLjkhJ2QLBlvLqT3jKyb4=
Subject: FAILED: patch "[PATCH] hwmon: (pmbus/mp2975) Get vout fault limits dynamically" failed to apply to 5.15-stable tree
To: fradensky@nvidia.com,linux@roeck-us.net,vadimp@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:18:24 +0100
Message-ID: <2026112524-maverick-yapping-77b2@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 00944852275efd39706fe7b9ce75c28edde983eb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112524-maverick-yapping-77b2@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 00944852275efd39706fe7b9ce75c28edde983eb Mon Sep 17 00:00:00 2001
From: Felix Radensky <fradensky@nvidia.com>
Date: Thu, 5 Nov 2026 21:32:00 +0200
Subject: [PATCH] hwmon: (pmbus/mp2975) Get vout fault limits dynamically

The over- and under-voltage fault limits of the tracking mode are
relative to the voltage reference, which follows the VID/AVS requests
issued to the device and therefore changes at runtime.

The driver reads the voltage reference once during probe and derives the
limits from that snapshot, which the PMBus core caches in addition. As a
result in2_crit and in2_lcrit reflect the operating point at probe, rather
than the thresholds the device enforces. On systems where the device
supplies the CPU core voltage, in2_crit was reported anywhere between
1.15V and 1.70V across identical systems, causing false over-voltage
reports once the CPU voltage exceeded the value latched at probe.

Read the voltage reference and the over-voltage offset selector whenever
a limit is requested, and mark both limits with pmbus_set_update(), so
that the core does not cache them. The voltage reference is available on
page 3 only. Let the core change the page, so that the page it caches
matches the device, except for a single rail configuration, for which the
core does not issue PAGE commands, and the page is changed directly.

With the selector read at runtime, a device configured with an
unsupported selector no longer fails to probe. The OVP1 threshold, which
does not depend on the selector, is reported for it instead, with a
warning.

Clamp the under-voltage limit to zero, since the offset can exceed a low
voltage reference, while a negative value would be reported as a read
error.

Fixes: 2c6fcbb21149 ("hwmon: (pmbus) Add support for MPS Multi-phase mp2975 controller")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Radensky <fradensky@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://patch.msgid.link/20261105193200.1570996-1-fradensky@nvidia.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index a11ec6756990..2ad6b7d831c8 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -109,10 +109,7 @@ struct mp2975_data {
 	int vout_scale;
 	int max_phases[MP2975_PAGE_NUM];
 	int vid_step[MP2975_PAGE_NUM];
-	int vref[MP2975_PAGE_NUM];
-	int vref_off[MP2975_PAGE_NUM];
 	int vout_max[MP2975_PAGE_NUM];
-	int vout_ov_fixed[MP2975_PAGE_NUM];
 	int curr_sense_gain[MP2975_PAGE_NUM];
 };
 
@@ -460,12 +457,77 @@ static int mp2973_write_word_data(struct i2c_client *client, int page,
 	return pmbus_write_word_data(client, 0, PMBUS_SMBALERT_MASK, ret);
 }
 
+/*
+ * Let the PMBus core change the page, so that the page it caches matches the
+ * device. The core does not issue PAGE commands for a single rail
+ * configuration, thus change the page directly then.
+ */
+static int
+mp2975_page_set(struct i2c_client *client, struct mp2975_data *data, int page)
+{
+	if (data->info.pages > 1)
+		return pmbus_set_page(client, page, 0xff);
+
+	return i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+}
+
+/*
+ * Voltage reference is available on page 3 only. The callers read a register
+ * of the rail through the core first, thus the core caches the rail page.
+ */
+static int
+mp2975_vref_get(struct i2c_client *client, struct mp2975_data *data, int page)
+{
+	int ret, vref;
+
+	ret = mp2975_page_set(client, data, 3);
+	if (ret < 0)
+		return ret;
+
+	vref = i2c_smbus_read_word_data(client, page ? MP2975_MFR_READ_VREF_R2 :
+						       MP2975_MFR_READ_VREF_R1);
+
+	ret = mp2975_page_set(client, data, page);
+	if (ret < 0)
+		return ret;
+
+	return (vref < 0) ? vref : vref * data->vid_step[page];
+}
+
+static int
+mp2975_ovp2_offset_get(int ovp_th_set)
+{
+	switch ((ovp_th_set & GENMASK(5, 3)) >> 3) {
+	case 1:
+		return 140;
+	case 2:
+		return 220;
+	case 4:
+		return 400;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int
+mp2975_vout_ovp2_get(struct i2c_client *client, struct mp2975_data *data,
+		     int page, int vref_off)
+{
+	int vref;
+
+	vref = mp2975_vref_get(client, data, page);
+	if (vref < 0)
+		return vref;
+
+	return vref + DIV_ROUND_CLOSEST(vref_off * data->vout_scale, 10);
+}
+
 static int mp2975_read_word_data(struct i2c_client *client, int page,
 				 int phase, int reg)
 {
 	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
 	struct mp2975_data *data = to_mp2975_data(info);
-	int ret;
+	int ret, ovp1, vref_off, uv_off;
 
 	switch (reg) {
 	case PMBUS_OT_FAULT_LIMIT:
@@ -482,19 +544,35 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 		break;
 	case PMBUS_VOUT_OV_FAULT_LIMIT:
 		/*
-		 * Register provides two values for over-voltage protection
-		 * threshold for fixed (ovp2) and tracking (ovp1) modes. The
-		 * minimum of these two values is provided as over-voltage
-		 * fault alarm.
+		 * Device provides dual over-voltage protection. OVP1 is
+		 * referred to the maximum reference voltage, while OVP2 is
+		 * referred to the current voltage reference, which is changed
+		 * at runtime. Protection is tripped by any of them, thus the
+		 * minimum of the two is exposed as over-voltage fault alarm,
+		 * and OVP2 is obtained on each read.
 		 */
 		ret = mp2975_read_word_helper(client, page, phase,
 					      MP2975_MFR_OVP_TH_SET,
-					      GENMASK(2, 0));
+					      GENMASK(5, 0));
 		if (ret < 0)
 			return ret;
 
-		ret = min_t(int, data->vout_max[page] + 50 * (ret + 1),
-			    data->vout_ov_fixed[page]);
+		ovp1 = data->vout_max[page] + 50 * ((ret & GENMASK(2, 0)) + 1);
+
+		/* OVP1 still applies if the OVP2 threshold is unknown. */
+		vref_off = mp2975_ovp2_offset_get(ret);
+		if (vref_off < 0) {
+			dev_warn_once(&client->dev,
+				      "unsupported OVP2 selector, reporting OVP1 threshold\n");
+			ret = ovp1;
+			break;
+		}
+
+		ret = mp2975_vout_ovp2_get(client, data, page, vref_off);
+		if (ret < 0)
+			return ret;
+
+		ret = min_t(int, ovp1, ret);
 		break;
 	case PMBUS_VOUT_UV_FAULT_LIMIT:
 		ret = mp2975_read_word_helper(client, page, phase,
@@ -503,8 +581,17 @@ static int mp2975_read_word_data(struct i2c_client *client, int page,
 		if (ret < 0)
 			return ret;
 
-		ret = DIV_ROUND_CLOSEST(data->vref[page] * 10 - 50 *
-					(ret + 1) * data->vout_scale, 10);
+		uv_off = 50 * (ret + 1) * data->vout_scale;
+
+		ret = mp2975_vref_get(client, data, page);
+		if (ret < 0)
+			return ret;
+
+		/*
+		 * Offset can exceed the voltage reference, while a negative
+		 * value would be reported as a read error.
+		 */
+		ret = max_t(int, DIV_ROUND_CLOSEST(ret * 10 - uv_off, 10), 0);
 		break;
 	case PMBUS_VIRT_READ_POUT_MAX:
 		ret = mp2975_read_word_helper(client, page, phase,
@@ -753,60 +840,6 @@ mp2975_current_sense_gain_get(struct i2c_client *client,
 	return 0;
 }
 
-static int
-mp2975_vref_get(struct i2c_client *client, struct mp2975_data *data,
-		struct pmbus_driver_info *info)
-{
-	int ret;
-
-	ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, 3);
-	if (ret < 0)
-		return ret;
-
-	/* Get voltage reference value for rail 1. */
-	ret = i2c_smbus_read_word_data(client, MP2975_MFR_READ_VREF_R1);
-	if (ret < 0)
-		return ret;
-
-	data->vref[0] = ret * data->vid_step[0];
-
-	/* Get voltage reference value for rail 2, if connected. */
-	if (data->info.pages == MP2975_PAGE_NUM) {
-		ret = i2c_smbus_read_word_data(client, MP2975_MFR_READ_VREF_R2);
-		if (ret < 0)
-			return ret;
-
-		data->vref[1] = ret * data->vid_step[1];
-	}
-	return 0;
-}
-
-static int
-mp2975_vref_offset_get(struct i2c_client *client, struct mp2975_data *data,
-		       int page)
-{
-	int ret;
-
-	ret = i2c_smbus_read_word_data(client, MP2975_MFR_OVP_TH_SET);
-	if (ret < 0)
-		return ret;
-
-	switch ((ret & GENMASK(5, 3)) >> 3) {
-	case 1:
-		data->vref_off[page] = 140;
-		break;
-	case 2:
-		data->vref_off[page] = 220;
-		break;
-	case 4:
-		data->vref_off[page] = 400;
-		break;
-	default:
-		return -EINVAL;
-	}
-	return 0;
-}
-
 static int
 mp2975_vout_max_get(struct i2c_client *client, struct mp2975_data *data,
 		    struct pmbus_driver_info *info, int page)
@@ -911,25 +944,6 @@ mp2975_vout_per_rail_config_get(struct i2c_client *client,
 		ret = mp2975_vout_max_get(client, data, info, i);
 		if (ret < 0)
 			return ret;
-
-		/* Skip if reading Vref is unsupported */
-		if (data->chip_id != mp2975)
-			continue;
-
-		/* Obtain voltage reference offsets. */
-		ret = mp2975_vref_offset_get(client, data, i);
-		if (ret < 0)
-			return ret;
-
-		/*
-		 * Set over-voltage fixed value. Thresholds are provided as
-		 * fixed value, and tracking value. The minimum of them are
-		 * exposed as over-voltage critical threshold.
-		 */
-		data->vout_ov_fixed[i] = data->vref[i] +
-					 DIV_ROUND_CLOSEST(data->vref_off[i] *
-							   data->vout_scale,
-							   10);
 	}
 
 	return 0;
@@ -1042,11 +1056,6 @@ static int mp2975_probe(struct i2c_client *client)
 		if (ret)
 			return ret;
 
-		/* Obtain voltage reference values. */
-		ret = mp2975_vref_get(client, data, info);
-		if (ret)
-			return ret;
-
 		/* Obtain vout over-voltage scales. */
 		ret = mp2975_vout_ov_scale_get(client, data, info);
 		if (ret < 0)
@@ -1063,7 +1072,21 @@ static int mp2975_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	return pmbus_do_probe(client, info);
+	ret = pmbus_do_probe(client, info);
+	if (ret)
+		return ret;
+
+	/*
+	 * Vout over- and under-voltage fault limits are relative to the
+	 * voltage reference, which is changed at runtime. Do not allow the
+	 * PMBus core to cache them.
+	 */
+	if (data->chip_id == mp2975) {
+		pmbus_set_update(client, PMBUS_VOUT_OV_FAULT_LIMIT, true);
+		pmbus_set_update(client, PMBUS_VOUT_UV_FAULT_LIMIT, true);
+	}
+
+	return 0;
 }
 
 static const struct of_device_id mp2975_of_match[] = {

