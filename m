Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454784;
	b=4KWlA6RoDaIoE8UA9qknWknSZ7d1U74Vcfs7VpkA+4iUJkeCyUkkBv8k8edT8XqgxUGg
	 nARSAv55HWS3m9XZc/4h8LX2bY/VsUByP2KUEVJQasdxy0XR4S9udHZAMv/tpMltvwpTW
	 255q4/fmnYOVkhTnNKSvZvhrM4RXjy2PftJquXIMnpP9K2D3p8FqJdJpGexRON80obbfr
	 U0/8ktOMQfvyLm5LAbTfh4On2Ir9cP4fPJ/HWiSFtWwUyhGaxeKspuF5Jg7xNfRwZHyqP
	 dJ5tJpaALgV3uKMwdkUraoqmInlypjMtbRvkYnXtwhPjsV/X+1vBdSG/j015jlgd5sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454784;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=XaGOLczXpyyvsphQaPFxlTinqrrutDHY1SeOEjGh1Wk=;
	b=CCtKzx4t73Oqx4Q6J+t8Yfl3d6kliLV1as8YskshBxwbaLpxFsw0f8OWv3EAacM8NEsF
	 J0CWwM0cuQRK4nKaMSVkUM2rzXtyWgS5mv571pQjGqxzB6gNunAo75HJowPQO/zNNWMvJ
	 qabOd/r6033xQhiHO/+n4ZSJghTxYss8pwXxphX0qwWJw1m5qxD7atDCQKjth+p/LPqcV
	 rJmTVmPS1KbOsB6pizANrqEDwES8VmJAdWqSj8c+8FZbmh9ragMIlsllNAyVv3TEM//1D
	 wcSxqdoxDjKrSxjhoIChojdyWv+pXVYQZh6W2ZeX+Jy9WZuMnx9L9vVNSqZLnra8k5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8kLZKBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF414606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E8kLZKBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B75E1F00A05;
	Thu, 12 Nov 2026 03:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454784;
	bh=XaGOLczXpyyvsphQaPFxlTinqrrutDHY1SeOEjGh1Wk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E8kLZKBWreNCvb7XaeweStQm3+2mK0C8gkXiQGYRynGx+q9Uyxrvf/HGC1KMA7WLJ
	 UHdJ9Ek/iARMS59ZX56fXkt5QB870+7pNL2YSUUAFzY09P1uAvO1+Qsh6u40J3gBdE
	 9jsHJwOsty2SyUiLoOqPgIZw8F/H+/7IM3L5ZszErFFY50/qGHLiJJhYcxQmpARacK
	 31vbkwC2H2qMAXYTncgLS6V1JhSxvmHE39dXNpyjd25Y5+1Uh39hE1Myxpd6/8uaOb
	 a+6bQm2/c7mN4+zqGQVWjx+o4PFnrrsFx7LWpnljWwhz9N2BJVvcHn62UIJbYooZzK
	 P6svTmYnjUWWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] hwmon: (pmbus) Check return value from pmbus_thermal_add_sensor()
Date: Wed, 11 Nov 2026 22:39:42 -0500
Message-ID: <20261112033924.1558745-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201619-failed-6.1-11dfbd835b17@kernel.org>
References: <20261109201619-failed-6.1-11dfbd835b17@kernel.org>
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
[ sashal: adapted sensor creation to the existing device_attribute layout and PMBus interfaces without writeonly or per-limit permission fields ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/pmbus/pmbus_core.c | 42 ++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 4328978228c18..de3bf69386f20 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -1347,10 +1347,11 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 {
 	struct pmbus_sensor *sensor;
 	struct device_attribute *a;
+	int err;
 
 	sensor = devm_kzalloc(data->dev, sizeof(*sensor), GFP_KERNEL);
 	if (!sensor)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	a = &sensor->attribute;
 
 	if (type)
@@ -1375,14 +1376,17 @@ static struct pmbus_sensor *pmbus_add_sensor(struct pmbus_data *data,
 			    pmbus_show_sensor, pmbus_set_sensor);
 
 	if (pmbus_add_attribute(data, &a->attr))
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
@@ -1483,8 +1487,8 @@ static int pmbus_add_limit_attrs(struct i2c_client *client,
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
@@ -1523,8 +1527,8 @@ static int pmbus_add_sensor_attrs_one(struct i2c_client *client,
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
@@ -2154,8 +2158,8 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
 				  0xff, PMBUS_VIRT_FAN_TARGET_1 + id, PSC_FAN,
 				  false, false, true);
 
-	if (!sensor)
-		return -ENOMEM;
+	if (IS_ERR(sensor))
+		return PTR_ERR(sensor);
 
 	if (!((data->info->func[page] & PMBUS_HAVE_PWM12) ||
 			(data->info->func[page] & PMBUS_HAVE_PWM34)))
@@ -2165,15 +2169,15 @@ static int pmbus_add_fan_ctrl(struct i2c_client *client,
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
@@ -2190,6 +2194,7 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
 		int f;
 
 		for (f = 0; f < ARRAY_SIZE(pmbus_fan_registers); f++) {
+			struct pmbus_sensor *sensor;
 			int regval;
 
 			if (!(info->func[page] & pmbus_fan_flags[f]))
@@ -2210,10 +2215,11 @@ static int pmbus_add_fan_attributes(struct i2c_client *client,
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

