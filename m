Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453975;
	b=HwZ5I+nukxv3DfT39LhNczgC5zm3Kgxhrpx/jXnbItIVT82vqv78l/CjUyMlOZbfQ6Eo
	 kXJqAn+7cl3KreF+CY+viOLlGDoWgnCSdHJz49UZPQqE6NEu3JlKlWeD9n27dCLmVbTzY
	 hJgFR70KWul9tC7/JHNuyR9U4Hyj7Cb9h3+XQHZkORO1r5kuOIrBfv3THl2j7YykukyE5
	 FED8GfgFXsCTF8xPsNiurBAtmjNoAmZfxQJJkQrhOx5AXsR8XzjLNF4c9nTSfOgrXclBX
	 IuUPM7Aiz0ZjFTYdunx/V/07CDyo3PIr1/FrHpfrlfrA3zGHM3SJiZU4ZsoFpnBeoxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Cwu9uN2xsFX+8xXweGyl07mV7+X3MKV5DN8L+W6j9BM=;
	b=fd9If+IUEqWKJtOKzERZwdJ0o89OOXTsck1zp3Waza+r77A0Fy431szp4iJxslQJEX8X
	 WpgH/DkAif5/szxlszTWAfYGmzQhKn3f+YGnLbKbK7WJJURKq69q6aGWGavrfFm03n/y+
	 qSKzKi/+OWjxPaK+vB4eqvU13UXtzbIzMT5KJ0ATosVvYyQyURNgp4JCugiQLToSPdSDb
	 yix5liwIg3v4oLd0OOBEQKKCBnpaA0vY+8yaB5WH9KXLqgNt3rtYpB56tulTDVPjnQKKk
	 hcs7gdd0OfLno03vbNQXQyzpxxnm0T4ZAcWPWT1iA6TeRkk5kjAcsn/RAXgnzumJLVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CF3fIUl5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9E606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CF3fIUl5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5CC1F00A05;
	Thu, 12 Nov 2026 03:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453975;
	bh=Cwu9uN2xsFX+8xXweGyl07mV7+X3MKV5DN8L+W6j9BM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CF3fIUl5YF5lkue2kY+AgXq/PK8F5BpxtPH4RKftsGB6EBDm731A6DqbwAFjY2du2
	 p+yhU5rQVe7Jak2+74/0LvkAo+m1Kjlk6Sh4yJFaSmk82NmHar/JdODOlucyoP6YnM
	 vYqgxLbPzxvOs/ikYGB3kiAXg5mto2++UypeGRWorJh/XK8fIM8CVzK7E+D/BQKYcm
	 O/sM9P9EhdPspOSgpExQ/FclpaQRoj2O/UaXwsnXadFMBt2znPzOOflBT4XQ1BMaPz
	 12Q86A71qEsghtSZJ577+aNaniNW4affXqR1DLjL0eG2V0ONAqQ8w5SuUXFs5G1hRV
	 GCasQDCyXsRdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
Date: Wed, 11 Nov 2026 22:26:13 -0500
Message-ID: <20261112032548.1518180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201145-failed-6.6-11dfbd835b17@kernel.org>
References: <20261109201145-failed-6.6-11dfbd835b17@kernel.org>
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

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 11dfbd835b17b75f7cc7a4a969f33ff702b1b081 ]

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
[ sashal: adapted pmbus_add_sensor() calls for the missing writeonly argument and readonly/writeonly limit-attribute fields ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 42 ++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 5500f1827ae68..973ad91a3368b 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1374,10 +1374,11 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
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
@@ -1401,14 +1402,17 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 			pmbus_show_sensor, pmbus_set_sensor, -1);
 
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
@@ -1509,8 +1513,8 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
 						page, 0xff, l->reg, attr->class,
 						attr->update || l->update,
 						false, true);
-			if (!curr)
-				return -ENOMEM;
+			if (IS_ERR(curr))
+				return PTR_ERR(curr);
 			if (l->sbit && (info->func[page] & attr->sfunc)) {
 				ret = pmbus_add_boolean(data, name,
 					l->alarm, index,
@@ -1549,8 +1553,8 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
 	}
 	base = pmbus_add_sensor(data, name, "input", index, page, phase,
 				attr->reg, attr->class, true, true, true);
-	if (!base)
-		return -ENOMEM;
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 	/* No limit and alarm attributes for phase specific sensors */
 	if (attr->sfunc && phase == 0xff) {
 		ret = pmbus_add_limit_attrs(client, data, info, name,
@@ -2180,8 +2184,8 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
 				  false, false, true);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	if (!((data->info->func[page] & PMBUS_HAVE_PWM12) ||
 			(data->info->func[page] & PMBUS_HAVE_PWM34)))
@@ -2191,15 +2195,15 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 				  0xff, PMBUS_VIRT_PWM_1 + id, PSC_PWM,
 				  false, false, true);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	sensor = pmbus_add_sensor(data, "pwm", "enable", index, page,
 				  0xff, PMBUS_VIRT_PWM_ENABLE_1 + id, PSC_PWM,
 				  true, false, false);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	return 0;
 }
@@ -2216,6 +2220,7 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 		int f;
 
 		for (f = 0; f < ARRAY_SIZE(pmbus_fan_registers); f++) {
+			struct pmbus_sensor *sensor;
 			int regval;
 
 			if (!(info->func[page] & pmbus_fan_flags[f]))
@@ -2236,10 +2241,11 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
 				continue;
 
-			if (pmbus_add_sensor(data, "fan", "input", index,
-					     page, 0xff, pmbus_fan_registers[f],
-					     PSC_FAN, true, true, true) == NULL)
-				return -ENOMEM;
+			sensor = pmbus_add_sensor(data, "fan", "input", index,
+						  page, 0xff, pmbus_fan_registers[f],
+						  PSC_FAN, true, true, true);
+			if (IS_ERR(sensor))
+				return PTR_ERR(sensor);
 
 			/* Fan control */
 			if (pmbus_check_word_register(client, page,
-- 
2.53.0

