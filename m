Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273107;
	b=06M21bLw/JmSJ4mknpcB9c62klgd0U5jmCa81R8xRrFFeJaP0fukxjTbwt+9eBTtbvHB
	 FArCTdGfTXbkcn3p/rlgwfPNIbpELhUEuEy40fF1uB1VHKqpqIRwAgltbuE0xz89DcFkM
	 oFVZosQyzFIolrHNEsg8sBgFRzWa30UinTT1gYQDU8Bbctn/d6rDu58GmecNHV16KLlBk
	 BaqgY+pwxZ9sUBtsYoA5WjQr3TEi8d3xOT25v+Cc/i8IMJjWcBfBYWxUApH94Sk5FeDLK
	 nO4Mgk9icjGb382M9/keJNNR1CcUQK54BKGh+vZkJm9zuXy+ojKzDm2NPw+BGHkq8yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=dw9NrsH78nSsZkDOH5CCb/Qr7sSieyG40HpE6+aK6wU=;
	b=piEHAsuFmFFH8CZmYuvdflgu+u5VaGsQ/9bV5b1LRXsLfkKUsUCXDJVzw1OHimS0YXCl
	 61Xhxa6uSPP73BVKFfrmI9I5aYQoNirULvzxs3BMesY2ENf32ZI7TU1kfY40zHdTGh32g
	 U/R5RlBaBrhRMqmg14AmI6cl7ycJ+yoFAPdbZ9ddS/shVC836TPRTONkA1uaMtygQxulS
	 /RLKub9hdSv8pAsWWkFcHcWtMsTTVgI802VKNNdFkFD3Ds1YF0l6OpcTqr6W/DDAZwaSl
	 4BlEDBNY83QC+Msnqo2Ngm3TsbYR1g7/tOlmHu4GSnB0mvt48LiJjppquHK4NU87H3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLNyyREI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5201606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLNyyREI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC6A1F0089F;
	Tue, 10 Nov 2026 01:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273106;
	bh=dw9NrsH78nSsZkDOH5CCb/Qr7sSieyG40HpE6+aK6wU=;
	h=From:To:Cc:Subject:Date;
	b=NLNyyREIQYi3HpCYEbIdQh8KsAI8B5mtOh36uQyk71yxj1zrHZ//Iwqs/vXNDT6Di
	 N0wu07bh2j2pDeLTz6B+Pb7lbZBg0vBuN0kX0+j/i5N9zKOC8IiYrqB3jlqSw7bYtO
	 UW1AX7maszj8BYXJG7HhpP/TnWV6JKEQiDj8lbLZvBdtfULuHtXC63imKLu0knEtvw
	 Avhpak5HX5YNRPpbbZbDXVtpl3DOCS56wPnR9n5/oy5FQsEj6LniGcFpFIZNeJrniF
	 V5C8oWCkh6vKH0r1vegzMzuPGBbniezIX/AXan80zPkLsUOmECmu2Zh6F3hDuiK6kG
	 NLzA34W2ooxSw==
From: Sasha Levin <sashal@kernel.org>
To: linux@roeck-us.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:11:45 -0500
Message-ID: <20261109201145-failed-6.6-11dfbd835b17@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 11dfbd835b17b75f7cc7a4a969f33ff702b1b081
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201145-failed-6.6-11dfbd835b17@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 11dfbd835b17b75f7cc7a4a969f33ff702b1b081 Mon Sep 17 00:00:00 2001
From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 29 Oct 2026 23:34:04 -0700
Subject: [PATCH] hwmon: (pmbus) Check return value from
 pmbus_thermal_add_sensor()

During PMBus device probe, if registering a temperature sensor with the
thermal subsystem fails, pmbus_add_sensor() silently ignores the error and
returns success.
When a valid temperature sensor is detected (class PSC_TEMPERATURE and type
"input"), pmbus_add_sensor() invokes pmbus_thermal_add_sensor() to hook it
into the kernel's thermal framework. However, the return value of this call
is completely discarded. If thermal registration fails, such as from an
-ENOMEM allocation failure or an invalid device tree configuration like a
malformed #thermal-sensor-cells property, no error is propagated.

Because the hardware monitor probe falsely succeeds despite the failure to
register the thermal zone, the system is left without thermal mitigation
for the affected PMBus device. This silently blinds the system to actual
PMIC temperatures, preventing the execution of necessary cooling mechanisms
or emergency shutdowns and risking localized overheating.

Pass the return value from pmbus_thermal_add_sensor() to the calling code
to fix the problem. To enable passing the actual error, change the error
return from pmbus_add_sensor() from NULL to ERR_PTR() and extract the error
from in the calling code.

Fixes: 3aa74796cfd0 ("hwmon: (pmbus) Register with thermal for PSC_TEMPERATURE")
Cc: stable@vger.kernel.org
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/pmbus/pmbus_core.c | 42 ++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index af13408c62f9b..9bccbf41c8844 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1551,10 +1551,11 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 {
 	struct sensor_device_attribute *a;
 	struct pmbus_sensor *sensor;
+	int err;
 
 	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	a = &sensor->attribute;
 
 	if (type)
@@ -1579,14 +1580,17 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 			pmbus_set_sensor, -1);
 
 	if (pmbus_add_attribute(data, &a->dev_attr.attr))
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	sensor->next = data->sensors;
 	data->sensors = sensor;
 
 	/* temperature sensors with _input values are registered with thermal */
-	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0)
-		pmbus_thermal_add_sensor(data, sensor, seq);
+	if (class == PSC_TEMPERATURE && strcmp(type, "input") == 0) {
+		err = pmbus_thermal_add_sensor(data, sensor, seq);
+		if (err)
+			return ERR_PTR(err);
+	}
 
 	return sensor;
 }
@@ -1687,8 +1691,8 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 						page, 0xff, l->reg, attr->class,
 						attr->update || l->update,
 						l->readonly, l->writeonly, true);
-			if (!curr)
-				return -ENOMEM;
+			if (IS_ERR(curr))
+				return PTR_ERR(curr);
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
 				ret = pmbus_add_boolean(data, name,
 					l->alarm, index,
@@ -1727,8 +1731,8 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 	}
 	base = pmbus_add_sensor(data, name, "input", index, page, phase,
 				attr->reg, attr->class, true, true, false, true);
-	if (!base)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	/* No limit and alarm attributes for phase specific sensors */
 	if (attr->sfunc && phase == 0xff) {
 		ret = pmbus_add_limit_attrs(client, data, info, name,
@@ -2401,8 +2405,8 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
 				  false, false, false, true);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	if (!((data->info->func[page] & PMBUS_HAVE_PWM12) ||
 	      (data->info->func[page] & PMBUS_HAVE_PWM34)))
@@ -2412,15 +2416,15 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 				  0xff, PMBUS_VIRT_PWM_1 + id, PSC_PWM,
 				  false, false, false, true);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	sensor = pmbus_add_sensor(data, "pwm", "enable", index, page,
 				  0xff, PMBUS_VIRT_PWM_ENABLE_1 + id, PSC_PWM,
 				  true, false, false, false);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	return 0;
 }
@@ -2437,6 +2441,7 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 		int f;
 
 		for (f = 0; f < ARRAY_SIZE(pmbus_fan_registers); f++) {
+			struct pmbus_sensor *sensor;
 			int regval;
 
 			if (!(info->func[page] & pmbus_fan_flags[f]))
@@ -2457,10 +2462,11 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
 				continue;
 
-			if (pmbus_add_sensor(data, "fan", "input", index,
-					     page, 0xff, pmbus_fan_registers[f],
-					     PSC_FAN, true, true, false, true) == NULL)
-				return -ENOMEM;
+			sensor = pmbus_add_sensor(data, "fan", "input", index,
+						  page, 0xff, pmbus_fan_registers[f],
+						  PSC_FAN, true, true, false, true);
+			if (IS_ERR(sensor))
+				return PTR_ERR(sensor);
 
 			/* Fan control */
 			if (pmbus_check_word_register(client, page,
-- 
2.53.0




