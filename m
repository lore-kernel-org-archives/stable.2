Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272612;
	b=ddjea/G+TLppRvdB1kkwDSKpglDhKgHiqdL8buPngClHzfY5tk8o4zZupv1Q5DvsY5pU
	 4aMeMo+cnvREiDgnIoag/cqZT4Zv69eNHP11Z1SsZDI3AQge48Kxul3aMFsG+2HD2+MHS
	 TbIuNlgKnW9o5OQ3KxisQ+Q22ALDsvnKLYI6ydUXliNmVcyHINGe6HOYlxAO0Haxs+43l
	 W3VPTiqWM3H0boUEdYptf8XxllW3TsfncPGc+6LfI94fl+aKQm3imDVesKTjCDX0Pg8Rp
	 Oc6ESsXkaKV8YUmwFa/uDXyS0tYhBeot5XkVTjO0huiikm+D88f5PeH/rxcJrp6i2zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YzJm892c+nGJNHp6MQC4h8EAbuHdDPEksX+/hAYTEls=;
	b=UAkV6GH5Z+EhoJaCz0keTU/sNk4YKrE+pUmmTopkUmD1QwXhu2xqI7K4zFOqi8h8WdSN
	 gN54iIehtm/Hb7HmFZfhqZo0LoaJktK2mWjOtLux+QETIZmOvS0CsOXgVRbure4medFM/
	 5r/Bcv/hfJdo8Gze60/5TVvox4LEaI0bRDD4MrbRBgbbyDTU2GekpPmPBtjG12QMfE99D
	 E3s0mLUjIK6Km6XGTpO6i1VX3ZqUk/pXlIl+Rq85KNpPuYpooLCSVm4iX4HNiiRFYlg4Z
	 f/bCqHEeZuWQTCiV8BjG/2vw8tbD0OK3P1dICh7u09590PAJbxs1WLVUA6dTQVCPR3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+RKlFmB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D817A606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I+RKlFmB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFE11F0089F;
	Tue, 10 Nov 2026 01:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272611;
	bh=YzJm892c+nGJNHp6MQC4h8EAbuHdDPEksX+/hAYTEls=;
	h=From:To:Cc:Subject:Date;
	b=I+RKlFmBNr668584x/f+raPNLO4vC8rdZwpRubtVo/f3XpuEColkL9kfsopXC6uS7
	 dtg682gNpBGmp5aj5IYpoDpsYBpK1aGvH2EiCpZ0oEQ0XNQbfUeaLiynbUVnEPWfDz
	 qnaYQMSCsZrltN0mkOEEuUll32/+t1dbVkSsszZCETfuXj89Wg/pepNAsGtlHkbTuE
	 fZGwroYPl1+AiKO0g7LZtBILdWfgrK3yUiB49ksznK2HY6OaYFS3I4vNuB4bi4FaXq
	 8JFP+WU8L/0FupIW1iLthdy/RD60MoSVduVkGlZ/rXQJu4S/RBcl4NsUe0OnuTj8+l
	 5ECSUsNJAfcRQ==
From: Sasha Levin <sashal@kernel.org>
To: javier.carrasco.cruz@gmail.com,
	linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: chipcap2: fix IRQ teardown ordering" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:03:30 -0500
Message-ID: <20261109200330-failed-6.18-d2a66c515d77@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d2a66c515d7730fd453485ffb306c412f1f46d72
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200330-failed-6.18-d2a66c515d77@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d2a66c515d7730fd453485ffb306c412f1f46d72 Mon Sep 17 00:00:00 2001
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:04 +0200
Subject: [PATCH] hwmon: chipcap2: fix IRQ teardown ordering

The threaded IRQs are currently requested before the hwmon device
is registered. Since devres releases resources in reverse order,
the hwmon device is unregistered before the IRQs are freed during
driver teardown. An IRQ may therefore still run after the hwmon
device has been released and access the stale data->hwmon pointer.

Separate IRQ discovery from IRQ registration so that the IRQ numbers
and alarm visibility flags are initialized before registering the
hwmon device while the IRQs are released before the hwmon device
during devres cleanup.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Link: https://patch.msgid.link/20261014-chipcap2_locks-v3-5-27ebfc2c5b9e@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/chipcap2.c | 52 ++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 37dbf6a76fbce..21dc6db27c401 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -631,32 +631,47 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	}
 }
 
-static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
+static int cc2_get_irqs(struct cc2_data *data, struct device *dev)
 {
-	int ret = 0;
-
 	data->irq_ready = fwnode_irq_get_byname(dev_fwnode(dev), "ready");
 	if (data->irq_ready == -EPROBE_DEFER)
 		return data->irq_ready;
-	if (data->irq_ready > 0) {
+	if (data->irq_ready > 0)
 		init_completion(&data->complete);
+
+	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
+	if (data->irq_low == -EPROBE_DEFER)
+		return data->irq_low;
+	if (data->irq_low > 0)
+		data->rh_alarm.low_alarm_visible = true;
+
+	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
+	if (data->irq_high == -EPROBE_DEFER)
+		return data->irq_high;
+	if (data->irq_high > 0)
+		data->rh_alarm.high_alarm_visible = true;
+
+	return 0;
+}
+
+static int cc2_request_data_ready(struct cc2_data *data, struct device *dev)
+{
+	int ret = 0;
+
+	if (data->irq_ready > 0)
 		ret = devm_request_threaded_irq(dev, data->irq_ready, NULL,
 						cc2_ready_interrupt,
 						IRQF_ONESHOT |
 						IRQF_TRIGGER_RISING,
 						dev_name(dev), data);
-	}
 
 	return ret;
 }
 
-static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
+static int cc2_request_alarms(struct cc2_data *data, struct device *dev)
 {
 	int ret = 0;
 
-	data->irq_low = fwnode_irq_get_byname(dev_fwnode(dev), "low");
-	if (data->irq_low == -EPROBE_DEFER)
-		return data->irq_low;
 	if (data->irq_low > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_low, NULL,
 						cc2_low_interrupt,
@@ -665,13 +680,8 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						dev_name(dev), data);
 		if (ret)
 			return ret;
-
-		data->rh_alarm.low_alarm_visible = true;
 	}
 
-	data->irq_high = fwnode_irq_get_byname(dev_fwnode(dev), "high");
-	if (data->irq_high == -EPROBE_DEFER)
-		return data->irq_high;
 	if (data->irq_high > 0) {
 		ret = devm_request_threaded_irq(dev, data->irq_high, NULL,
 						cc2_high_interrupt,
@@ -680,8 +690,6 @@ static int cc2_request_alarm_irqs(struct cc2_data *data, struct device *dev)
 						dev_name(dev), data);
 		if (ret)
 			return ret;
-
-		data->rh_alarm.high_alarm_visible = true;
 	}
 
 	return ret;
@@ -732,13 +740,13 @@ static int cc2_probe(struct i2c_client *client)
 
 	device_property_read_string(dev, "label", &data->label);
 
-	ret = cc2_request_ready_irq(data, dev);
+	ret = cc2_get_irqs(data, dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
+		return dev_err_probe(dev, ret, "Failed to get IRQs\n");
 
-	ret = cc2_request_alarm_irqs(data, dev);
+	ret = cc2_request_data_ready(data, dev);
 	if (ret)
-		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+		return dev_err_probe(dev, ret, "Failed to request ready irq\n");
 
 	data->hwmon = devm_hwmon_device_register_with_info(dev, client->name,
 							   data, &cc2_chip_info,
@@ -747,6 +755,10 @@ static int cc2_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(data->hwmon),
 				     "Failed to register hwmon device\n");
 
+	ret = cc2_request_alarms(data, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to request alarm irqs\n");
+
 	return 0;
 }
 
-- 
2.53.0




