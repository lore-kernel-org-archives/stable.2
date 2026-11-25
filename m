Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629641;
	b=IM/JS4XRLzFbUUYYxyG2rR37qfSfevrbHvkcRk6lvLOIF5NxofUloDl+MPvU96BnRftr
	 HxVoVehvKMfRBRM1Ad/tuIbK0RgRqvYhnKkYmi/ULvuJdPDWyEtf0Njant935HGNbHxvM
	 0Gc3j3M7FhK4gzDTmP3YaPwiIL3g5SyXNtAInaZwe2KnRa3HCH5nyB6ZgGjIW2kOazugp
	 I8m76AxSJnOmTY7o4XZvmAUpOPVrgWYeY8B2vyVgmm4A1Z1NnEVzXtdKDOjWkf2lgIgHV
	 pOESlstmxRNtbh+8VhgM24k28o37bmnNHOST7kTNM9pWMU5ByGdfkjiEA4tm215VLag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629641;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zQjov6sK9RWdETI95+fsmKpdN3giI3s6c3wsdFT1SbA=;
	b=zYhKUOpVKjQo6q/bX4kkpI57LA9W+wGwv0PEh488sAqwCkHqHrxcY0M8ZyPECb7FNxLo
	 cNawPI0itSB9jFAEa7u0pAjNs2Z9/j8bWrU36mmk+/8gqmKAQvN14EdNxRqXpV7ueaeb3
	 7V1z89hd+LwIa6j+w3gUzlQp+SmZOr/AW9RyyfQtF4BjQgxxk9dO5YfvGn1VQW9rKgOqp
	 2vTxSKYdhJjBrUdxnkyZcWRidA3D4GI5KeoCzc/qtcNWQDRmQq3DeiZkRzeYQnzd7wOvW
	 njpC4Cski2va9D5Yo5HdVVAJdTw8EOsBllKIBY72QQ0c1fkV4nlxmHDj7O/zf6EtGcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eM7rnXFf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21415606A6A4
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eM7rnXFf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08DED1F00AD4;
	Wed, 25 Nov 2026 18:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629640;
	bh=zQjov6sK9RWdETI95+fsmKpdN3giI3s6c3wsdFT1SbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eM7rnXFfl5ApbrvyYPvoXPLpo3h2nPiRRDwY7b+FweA8XgTQ2QQPMGeCz8usjuPYf
	 7ZhO8k//U9tsI20nV/+JYhIriB/DBRtdWDG3g6AoAPY6JoAUkd7sflJGsyMXTkmRnp
	 ONwYzu2bdVnhS2rKL/38h2kUKVfH5OiRa84GbSJt/0fSmZ1QVLzasggkuQauQ2kILY
	 s4ogh96KwMxnJWbr0XhLqLcF3va+4V/RZNlig3rHK4Hs5EphI2THmlErqc013LFQj0
	 e3ZI40VZellIkfwUPhxak9YHSQYbH0EkMYBpbtTiLw43GxXdeatcYBewkT8znaxvCE
	 U0BinN2oS509w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Pauk <pauk.denis@gmail.com>,
	Bernhard Seibold <mail@bernhard-seibold.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] hwmon: (nct6775) Use nct6775_*() function pointers in nct6775_data.
Date: Wed, 25 Nov 2026 13:00:37 -0500
Message-ID: <20261125180018.1111857-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112510-freezable-rebalance-5328@gregkh>
References: <2026112510-freezable-rebalance-5328@gregkh>
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

From: Denis Pauk <pauk.denis@gmail.com>

[ Upstream commit 4914036eb66bdffe4cf4150c7d055c18d389d398 ]

Prepare for platform specific callbacks usage:
* Use nct6775 function pointers in struct nct6775_data instead direct
  calls.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Co-developed-by: Bernhard Seibold <mail@bernhard-seibold.de>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20210917220240.56553-3-pauk.denis@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: ca1abdd1a9b9 ("hwmon: (nct6775) Handle dual use registers")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775.c | 283 ++++++++++++++++++++--------------------
 1 file changed, 143 insertions(+), 140 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 5428b5b4043da..35a296768fde3 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1215,6 +1215,10 @@ struct nct6775_data {
 	u8 fandiv1;
 	u8 fandiv2;
 	u8 sio_reg_enable;
+
+	/* nct6775_*() callbacks  */
+	u16 (*read_value)(struct nct6775_data *data, u16 reg);
+	int (*write_value)(struct nct6775_data *data, u16 reg, u16 value);
 };
 
 struct nct6775_sio_data {
@@ -1459,7 +1463,7 @@ static u16 nct6775_read_temp(struct nct6775_data *data, u16 reg)
 {
 	u16 res;
 
-	res = nct6775_read_value(data, reg);
+	res = data->read_value(data, reg);
 	if (!is_word_sized(data, reg))
 		res <<= 8;
 
@@ -1470,7 +1474,7 @@ static int nct6775_write_temp(struct nct6775_data *data, u16 reg, u16 value)
 {
 	if (!is_word_sized(data, reg))
 		value >>= 8;
-	return nct6775_write_value(data, reg, value);
+	return data->write_value(data, reg, value);
 }
 
 /* This function assumes that the caller holds data->update_lock */
@@ -1480,24 +1484,24 @@ static void nct6775_write_fan_div(struct nct6775_data *data, int nr)
 
 	switch (nr) {
 	case 0:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x70)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV1) & 0x70)
 		    | (data->fan_div[0] & 0x7);
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		data->write_value(data, NCT6775_REG_FANDIV1, reg);
 		break;
 	case 1:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV1) & 0x7)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV1) & 0x7)
 		    | ((data->fan_div[1] << 4) & 0x70);
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, reg);
+		data->write_value(data, NCT6775_REG_FANDIV1, reg);
 		break;
 	case 2:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x70)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV2) & 0x70)
 		    | (data->fan_div[2] & 0x7);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		data->write_value(data, NCT6775_REG_FANDIV2, reg);
 		break;
 	case 3:
-		reg = (nct6775_read_value(data, NCT6775_REG_FANDIV2) & 0x7)
+		reg = (data->read_value(data, NCT6775_REG_FANDIV2) & 0x7)
 		    | ((data->fan_div[3] << 4) & 0x70);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, reg);
+		data->write_value(data, NCT6775_REG_FANDIV2, reg);
 		break;
 	}
 }
@@ -1512,10 +1516,10 @@ static void nct6775_update_fan_div(struct nct6775_data *data)
 {
 	u8 i;
 
-	i = nct6775_read_value(data, NCT6775_REG_FANDIV1);
+	i = data->read_value(data, NCT6775_REG_FANDIV1);
 	data->fan_div[0] = i & 0x7;
 	data->fan_div[1] = (i & 0x70) >> 4;
-	i = nct6775_read_value(data, NCT6775_REG_FANDIV2);
+	i = data->read_value(data, NCT6775_REG_FANDIV2);
 	data->fan_div[2] = i & 0x7;
 	if (data->has_fan & BIT(3))
 		data->fan_div[3] = (i & 0x70) >> 4;
@@ -1563,11 +1567,11 @@ static void nct6775_init_fan_common(struct device *dev,
 	 */
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (data->has_fan_min & BIT(i)) {
-			reg = nct6775_read_value(data, data->REG_FAN_MIN[i]);
+			reg = data->read_value(data, data->REG_FAN_MIN[i]);
 			if (!reg)
-				nct6775_write_value(data, data->REG_FAN_MIN[i],
-						    data->has_fan_div ? 0xff
-								      : 0xff1f);
+				data->write_value(data, data->REG_FAN_MIN[i],
+						  data->has_fan_div ? 0xff
+								    : 0xff1f);
 		}
 	}
 }
@@ -1611,8 +1615,8 @@ static void nct6775_select_fan_div(struct device *dev,
 			}
 			if (fan_min != data->fan_min[nr]) {
 				data->fan_min[nr] = fan_min;
-				nct6775_write_value(data, data->REG_FAN_MIN[nr],
-						    fan_min);
+				data->write_value(data, data->REG_FAN_MIN[nr],
+						  fan_min);
 			}
 		}
 		data->fan_div[nr] = fan_div;
@@ -1632,16 +1636,15 @@ static void nct6775_update_pwm(struct device *dev)
 			continue;
 
 		duty_is_dc = data->REG_PWM_MODE[i] &&
-		  (nct6775_read_value(data, data->REG_PWM_MODE[i])
+		  (data->read_value(data, data->REG_PWM_MODE[i])
 		   & data->PWM_MODE_MASK[i]);
 		data->pwm_mode[i] = !duty_is_dc;
 
-		fanmodecfg = nct6775_read_value(data, data->REG_FAN_MODE[i]);
+		fanmodecfg = data->read_value(data, data->REG_FAN_MODE[i]);
 		for (j = 0; j < ARRAY_SIZE(data->REG_PWM); j++) {
 			if (data->REG_PWM[j] && data->REG_PWM[j][i]) {
-				data->pwm[j][i]
-				  = nct6775_read_value(data,
-						       data->REG_PWM[j][i]);
+				data->pwm[j][i] = data->read_value(data,
+								   data->REG_PWM[j][i]);
 			}
 		}
 
@@ -1656,17 +1659,17 @@ static void nct6775_update_pwm(struct device *dev)
 			u8 t = fanmodecfg & 0x0f;
 
 			if (data->REG_TOLERANCE_H) {
-				t |= (nct6775_read_value(data,
+				t |= (data->read_value(data,
 				      data->REG_TOLERANCE_H[i]) & 0x70) >> 1;
 			}
 			data->target_speed_tolerance[i] = t;
 		}
 
 		data->temp_tolerance[1][i] =
-			nct6775_read_value(data,
-					data->REG_CRITICAL_TEMP_TOLERANCE[i]);
+			data->read_value(data,
+					 data->REG_CRITICAL_TEMP_TOLERANCE[i]);
 
-		reg = nct6775_read_value(data, data->REG_TEMP_SEL[i]);
+		reg = data->read_value(data, data->REG_TEMP_SEL[i]);
 		data->pwm_temp_sel[i] = reg & 0x1f;
 		/* If fan can stop, report floor as 0 */
 		if (reg & 0x80)
@@ -1675,7 +1678,7 @@ static void nct6775_update_pwm(struct device *dev)
 		if (!data->REG_WEIGHT_TEMP_SEL[i])
 			continue;
 
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[i]);
 		data->pwm_weight_temp_sel[i] = reg & 0x1f;
 		/* If weight is disabled, report weight source as 0 */
 		if (!(reg & 0x80))
@@ -1683,9 +1686,8 @@ static void nct6775_update_pwm(struct device *dev)
 
 		/* Weight temp data */
 		for (j = 0; j < ARRAY_SIZE(data->weight_temp); j++) {
-			data->weight_temp[j][i]
-			  = nct6775_read_value(data,
-					       data->REG_WEIGHT_TEMP[j][i]);
+			data->weight_temp[j][i] = data->read_value(data,
+								   data->REG_WEIGHT_TEMP[j][i]);
 		}
 	}
 }
@@ -1703,10 +1705,10 @@ static void nct6775_update_pwm_limits(struct device *dev)
 
 		for (j = 0; j < ARRAY_SIZE(data->fan_time); j++) {
 			data->fan_time[j][i] =
-			  nct6775_read_value(data, data->REG_FAN_TIME[j][i]);
+			  data->read_value(data, data->REG_FAN_TIME[j][i]);
 		}
 
-		reg_t = nct6775_read_value(data, data->REG_TARGET[i]);
+		reg_t = data->read_value(data, data->REG_TARGET[i]);
 		/* Update only in matching mode or if never updated */
 		if (!data->target_temp[i] ||
 		    data->pwm_enable[i] == thermal_cruise)
@@ -1714,7 +1716,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		if (!data->target_speed[i] ||
 		    data->pwm_enable[i] == speed_cruise) {
 			if (data->REG_TOLERANCE_H) {
-				reg_t |= (nct6775_read_value(data,
+				reg_t |= (data->read_value(data,
 					data->REG_TOLERANCE_H[i]) & 0x0f) << 8;
 			}
 			data->target_speed[i] = reg_t;
@@ -1722,21 +1724,21 @@ static void nct6775_update_pwm_limits(struct device *dev)
 
 		for (j = 0; j < data->auto_pwm_num; j++) {
 			data->auto_pwm[i][j] =
-			  nct6775_read_value(data,
-					     NCT6775_AUTO_PWM(data, i, j));
+			  data->read_value(data,
+					   NCT6775_AUTO_PWM(data, i, j));
 			data->auto_temp[i][j] =
-			  nct6775_read_value(data,
-					     NCT6775_AUTO_TEMP(data, i, j));
+			  data->read_value(data,
+					   NCT6775_AUTO_TEMP(data, i, j));
 		}
 
 		/* critical auto_pwm temperature data */
 		data->auto_temp[i][data->auto_pwm_num] =
-			nct6775_read_value(data, data->REG_CRITICAL_TEMP[i]);
+			data->read_value(data, data->REG_CRITICAL_TEMP[i]);
 
 		switch (data->kind) {
 		case nct6775:
-			reg = nct6775_read_value(data,
-						 NCT6775_REG_CRITICAL_ENAB[i]);
+			reg = data->read_value(data,
+					       NCT6775_REG_CRITICAL_ENAB[i]);
 			data->auto_pwm[i][data->auto_pwm_num] =
 						(reg & 0x02) ? 0xff : 0x00;
 			break;
@@ -1753,10 +1755,10 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		case nct6796:
 		case nct6797:
 		case nct6798:
-			reg = nct6775_read_value(data,
+			reg = data->read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[i]);
 			if (reg & data->CRITICAL_PWM_ENABLE_MASK)
-				reg = nct6775_read_value(data,
+				reg = data->read_value(data,
 					data->REG_CRITICAL_PWM[i]);
 			else
 				reg = 0xff;
@@ -1783,11 +1785,11 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			if (!(data->have_in & BIT(i)))
 				continue;
 
-			data->in[i][0] = nct6775_read_value(data,
-							    data->REG_VIN[i]);
-			data->in[i][1] = nct6775_read_value(data,
+			data->in[i][0] = data->read_value(data,
+							  data->REG_VIN[i]);
+			data->in[i][1] = data->read_value(data,
 					  data->REG_IN_MINMAX[0][i]);
-			data->in[i][2] = nct6775_read_value(data,
+			data->in[i][2] = data->read_value(data,
 					  data->REG_IN_MINMAX[1][i]);
 		}
 
@@ -1798,18 +1800,18 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 			if (!(data->has_fan & BIT(i)))
 				continue;
 
-			reg = nct6775_read_value(data, data->REG_FAN[i]);
+			reg = data->read_value(data, data->REG_FAN[i]);
 			data->rpm[i] = data->fan_from_reg(reg,
 							  data->fan_div[i]);
 
 			if (data->has_fan_min & BIT(i))
-				data->fan_min[i] = nct6775_read_value(data,
+				data->fan_min[i] = data->read_value(data,
 					   data->REG_FAN_MIN[i]);
 
 			if (data->REG_FAN_PULSES[i]) {
 				data->fan_pulses[i] =
-				  (nct6775_read_value(data,
-						      data->REG_FAN_PULSES[i])
+				  (data->read_value(data,
+						    data->REG_FAN_PULSES[i])
 				   >> data->FAN_PULSE_SHIFT[i]) & 0x03;
 			}
 
@@ -1825,15 +1827,14 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 				continue;
 			for (j = 0; j < ARRAY_SIZE(data->reg_temp); j++) {
 				if (data->reg_temp[j][i])
-					data->temp[j][i]
-					  = nct6775_read_temp(data,
-						data->reg_temp[j][i]);
+					data->temp[j][i] = nct6775_read_temp(data,
+									     data->reg_temp[j][i]);
 			}
 			if (i >= NUM_TEMP_FIXED ||
 			    !(data->have_temp_fixed & BIT(i)))
 				continue;
-			data->temp_offset[i]
-			  = nct6775_read_value(data, data->REG_TEMP_OFFSET[i]);
+			data->temp_offset[i] = data->read_value(data,
+								   data->REG_TEMP_OFFSET[i]);
 		}
 
 		data->alarms = 0;
@@ -1842,7 +1843,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 
 			if (!data->REG_ALARM[i])
 				continue;
-			alarm = nct6775_read_value(data, data->REG_ALARM[i]);
+			alarm = data->read_value(data, data->REG_ALARM[i]);
 			data->alarms |= ((u64)alarm) << (i << 3);
 		}
 
@@ -1852,7 +1853,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 
 			if (!data->REG_BEEP[i])
 				continue;
-			beep = nct6775_read_value(data, data->REG_BEEP[i]);
+			beep = data->read_value(data, data->REG_BEEP[i]);
 			data->beeps |= ((u64)beep) << (i << 3);
 		}
 
@@ -1894,8 +1895,8 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		return err;
 	mutex_lock(&data->update_lock);
 	data->in[nr][index] = in_to_reg(val, nr);
-	nct6775_write_value(data, data->REG_IN_MINMAX[index - 1][nr],
-			    data->in[nr][index]);
+	data->write_value(data, data->REG_IN_MINMAX[index - 1][nr],
+			  data->in[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -1919,8 +1920,8 @@ static int find_temp_source(struct nct6775_data *data, int index, int count)
 	for (nr = 0; nr < count; nr++) {
 		int src;
 
-		src = nct6775_read_value(data,
-					 data->REG_TEMP_SOURCE[nr]) & 0x1f;
+		src = data->read_value(data,
+				       data->REG_TEMP_SOURCE[nr]) & 0x1f;
 		if (src == source)
 			return nr;
 	}
@@ -1981,8 +1982,8 @@ store_beep(struct device *dev, struct device_attribute *attr, const char *buf,
 		data->beeps |= (1ULL << nr);
 	else
 		data->beeps &= ~(1ULL << nr);
-	nct6775_write_value(data, data->REG_BEEP[regindex],
-			    (data->beeps >> (regindex << 3)) & 0xff);
+	data->write_value(data, data->REG_BEEP[regindex],
+			  (data->beeps >> (regindex << 3)) & 0xff);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2037,8 +2038,8 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 		data->beeps |= (1ULL << bit);
 	else
 		data->beeps &= ~(1ULL << bit);
-	nct6775_write_value(data, data->REG_BEEP[regindex],
-			    (data->beeps >> (regindex << 3)) & 0xff);
+	data->write_value(data, data->REG_BEEP[regindex],
+			  (data->beeps >> (regindex << 3)) & 0xff);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2205,7 +2206,7 @@ store_fan_min(struct device *dev, struct device_attribute *attr,
 	}
 
 write_min:
-	nct6775_write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
+	data->write_value(data, data->REG_FAN_MIN[nr], data->fan_min[nr]);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2241,10 +2242,10 @@ store_fan_pulses(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->fan_pulses[nr] = val & 3;
-	reg = nct6775_read_value(data, data->REG_FAN_PULSES[nr]);
+	reg = data->read_value(data, data->REG_FAN_PULSES[nr]);
 	reg &= ~(0x03 << data->FAN_PULSE_SHIFT[nr]);
 	reg |= (val & 3) << data->FAN_PULSE_SHIFT[nr];
-	nct6775_write_value(data, data->REG_FAN_PULSES[nr], reg);
+	data->write_value(data, data->REG_FAN_PULSES[nr], reg);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2378,7 +2379,7 @@ store_temp_offset(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->temp_offset[nr] = val;
-	nct6775_write_value(data, data->REG_TEMP_OFFSET[nr], val);
+	data->write_value(data, data->REG_TEMP_OFFSET[nr], val);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2417,8 +2418,8 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	data->temp_type[nr] = val;
 	vbit = 0x02 << nr;
 	dbit = data->DIODE_MASK << nr;
-	vbat = nct6775_read_value(data, data->REG_VBAT) & ~vbit;
-	diode = nct6775_read_value(data, data->REG_DIODE) & ~dbit;
+	vbat = data->read_value(data, data->REG_VBAT) & ~vbit;
+	diode = data->read_value(data, data->REG_DIODE) & ~dbit;
 	switch (val) {
 	case 1:	/* CPU diode (diode, current mode) */
 		vbat |= vbit;
@@ -2430,8 +2431,8 @@ store_temp_type(struct device *dev, struct device_attribute *attr,
 	case 4:	/* thermistor */
 		break;
 	}
-	nct6775_write_value(data, data->REG_VBAT, vbat);
-	nct6775_write_value(data, data->REG_DIODE, diode);
+	data->write_value(data, data->REG_VBAT, vbat);
+	data->write_value(data, data->REG_DIODE, diode);
 
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -2555,11 +2556,11 @@ store_pwm_mode(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->pwm_mode[nr] = val;
-	reg = nct6775_read_value(data, data->REG_PWM_MODE[nr]);
+	reg = data->read_value(data, data->REG_PWM_MODE[nr]);
 	reg &= ~data->PWM_MODE_MASK[nr];
 	if (!val)
 		reg |= data->PWM_MODE_MASK[nr];
-	nct6775_write_value(data, data->REG_PWM_MODE[nr], reg);
+	data->write_value(data, data->REG_PWM_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2578,7 +2579,7 @@ show_pwm(struct device *dev, struct device_attribute *attr, char *buf)
 	 * Otherwise, show the configured value.
 	 */
 	if (index == 0 && data->pwm_enable[nr] > manual)
-		pwm = nct6775_read_value(data, data->REG_PWM_READ[nr]);
+		pwm = data->read_value(data, data->REG_PWM_READ[nr]);
 	else
 		pwm = data->pwm[index][nr];
 
@@ -2607,13 +2608,13 @@ store_pwm(struct device *dev, struct device_attribute *attr, const char *buf,
 
 	mutex_lock(&data->update_lock);
 	data->pwm[index][nr] = val;
-	nct6775_write_value(data, data->REG_PWM[index][nr], val);
+	data->write_value(data, data->REG_PWM[index][nr], val);
 	if (index == 2)	{ /* floor: disable if val == 0 */
-		reg = nct6775_read_value(data, data->REG_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_TEMP_SEL[nr]);
 		reg &= 0x7f;
 		if (val)
 			reg |= 0x80;
-		nct6775_write_value(data, data->REG_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_TEMP_SEL[nr], reg);
 	}
 	mutex_unlock(&data->update_lock);
 	return count;
@@ -2652,29 +2653,29 @@ static void pwm_update_registers(struct nct6775_data *data, int nr)
 	case manual:
 		break;
 	case speed_cruise:
-		reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+		reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 		reg = (reg & ~data->tolerance_mask) |
 		  (data->target_speed_tolerance[nr] & data->tolerance_mask);
-		nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
-		nct6775_write_value(data, data->REG_TARGET[nr],
+		data->write_value(data, data->REG_FAN_MODE[nr], reg);
+		data->write_value(data, data->REG_TARGET[nr],
 				    data->target_speed[nr] & 0xff);
 		if (data->REG_TOLERANCE_H) {
 			reg = (data->target_speed[nr] >> 8) & 0x0f;
 			reg |= (data->target_speed_tolerance[nr] & 0x38) << 1;
-			nct6775_write_value(data,
-					    data->REG_TOLERANCE_H[nr],
-					    reg);
+			data->write_value(data,
+					  data->REG_TOLERANCE_H[nr],
+					  reg);
 		}
 		break;
 	case thermal_cruise:
-		nct6775_write_value(data, data->REG_TARGET[nr],
-				    data->target_temp[nr]);
+		data->write_value(data, data->REG_TARGET[nr],
+				  data->target_temp[nr]);
 		fallthrough;
 	default:
-		reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+		reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 		reg = (reg & ~data->tolerance_mask) |
 		  data->temp_tolerance[0][nr];
-		nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+		data->write_value(data, data->REG_FAN_MODE[nr], reg);
 		break;
 	}
 }
@@ -2722,13 +2723,13 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 		 * turn off pwm control: select manual mode, set pwm to maximum
 		 */
 		data->pwm[0][nr] = 255;
-		nct6775_write_value(data, data->REG_PWM[0][nr], 255);
+		data->write_value(data, data->REG_PWM[0][nr], 255);
 	}
 	pwm_update_registers(data, nr);
-	reg = nct6775_read_value(data, data->REG_FAN_MODE[nr]);
+	reg = data->read_value(data, data->REG_FAN_MODE[nr]);
 	reg &= 0x0f;
 	reg |= pwm_enable_to_reg(val) << 4;
-	nct6775_write_value(data, data->REG_FAN_MODE[nr], reg);
+	data->write_value(data, data->REG_FAN_MODE[nr], reg);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -2781,10 +2782,10 @@ store_pwm_temp_sel(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	src = data->temp_src[val - 1];
 	data->pwm_temp_sel[nr] = src;
-	reg = nct6775_read_value(data, data->REG_TEMP_SEL[nr]);
+	reg = data->read_value(data, data->REG_TEMP_SEL[nr]);
 	reg &= 0xe0;
 	reg |= src;
-	nct6775_write_value(data, data->REG_TEMP_SEL[nr], reg);
+	data->write_value(data, data->REG_TEMP_SEL[nr], reg);
 	mutex_unlock(&data->update_lock);
 
 	return count;
@@ -2826,15 +2827,15 @@ store_pwm_weight_temp_sel(struct device *dev, struct device_attribute *attr,
 	if (val) {
 		src = data->temp_src[val - 1];
 		data->pwm_weight_temp_sel[nr] = src;
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
 		reg &= 0xe0;
 		reg |= (src | 0x80);
-		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
 	} else {
 		data->pwm_weight_temp_sel[nr] = 0;
-		reg = nct6775_read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
+		reg = data->read_value(data, data->REG_WEIGHT_TEMP_SEL[nr]);
 		reg &= 0x7f;
-		nct6775_write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
+		data->write_value(data, data->REG_WEIGHT_TEMP_SEL[nr], reg);
 	}
 	mutex_unlock(&data->update_lock);
 
@@ -2946,9 +2947,9 @@ store_temp_tolerance(struct device *dev, struct device_attribute *attr,
 	if (index)
 		pwm_update_registers(data, nr);
 	else
-		nct6775_write_value(data,
-				    data->REG_CRITICAL_TEMP_TOLERANCE[nr],
-				    val);
+		data->write_value(data,
+				  data->REG_CRITICAL_TEMP_TOLERANCE[nr],
+				  val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3071,7 +3072,7 @@ store_weight_temp(struct device *dev, struct device_attribute *attr,
 
 	mutex_lock(&data->update_lock);
 	data->weight_temp[index][nr] = val;
-	nct6775_write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
+	data->write_value(data, data->REG_WEIGHT_TEMP[index][nr], val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3120,7 +3121,7 @@ store_fan_time(struct device *dev, struct device_attribute *attr,
 	val = step_time_to_reg(val, data->pwm_mode[nr]);
 	mutex_lock(&data->update_lock);
 	data->fan_time[index][nr] = val;
-	nct6775_write_value(data, data->REG_FAN_TIME[index][nr], val);
+	data->write_value(data, data->REG_FAN_TIME[index][nr], val);
 	mutex_unlock(&data->update_lock);
 	return count;
 }
@@ -3162,21 +3163,21 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	data->auto_pwm[nr][point] = val;
 	if (point < data->auto_pwm_num) {
-		nct6775_write_value(data,
+		data->write_value(data,
 				    NCT6775_AUTO_PWM(data, nr, point),
 				    data->auto_pwm[nr][point]);
 	} else {
 		switch (data->kind) {
 		case nct6775:
 			/* disable if needed (pwm == 0) */
-			reg = nct6775_read_value(data,
-						 NCT6775_REG_CRITICAL_ENAB[nr]);
+			reg = data->read_value(data,
+					       NCT6775_REG_CRITICAL_ENAB[nr]);
 			if (val)
 				reg |= 0x02;
 			else
 				reg &= ~0x02;
-			nct6775_write_value(data, NCT6775_REG_CRITICAL_ENAB[nr],
-					    reg);
+			data->write_value(data, NCT6775_REG_CRITICAL_ENAB[nr],
+					  reg);
 			break;
 		case nct6776:
 			break; /* always enabled, nothing to do */
@@ -3190,17 +3191,17 @@ store_auto_pwm(struct device *dev, struct device_attribute *attr,
 		case nct6796:
 		case nct6797:
 		case nct6798:
-			nct6775_write_value(data, data->REG_CRITICAL_PWM[nr],
+			data->write_value(data, data->REG_CRITICAL_PWM[nr],
 					    val);
-			reg = nct6775_read_value(data,
+			reg = data->read_value(data,
 					data->REG_CRITICAL_PWM_ENABLE[nr]);
 			if (val == 255)
 				reg &= ~data->CRITICAL_PWM_ENABLE_MASK;
 			else
 				reg |= data->CRITICAL_PWM_ENABLE_MASK;
-			nct6775_write_value(data,
-					    data->REG_CRITICAL_PWM_ENABLE[nr],
-					    reg);
+			data->write_value(data,
+					  data->REG_CRITICAL_PWM_ENABLE[nr],
+					  reg);
 			break;
 		}
 	}
@@ -3243,11 +3244,11 @@ store_auto_temp(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&data->update_lock);
 	data->auto_temp[nr][point] = DIV_ROUND_CLOSEST(val, 1000);
 	if (point < data->auto_pwm_num) {
-		nct6775_write_value(data,
+		data->write_value(data,
 				    NCT6775_AUTO_TEMP(data, nr, point),
 				    data->auto_temp[nr][point]);
 	} else {
-		nct6775_write_value(data, data->REG_CRITICAL_TEMP[nr],
+		data->write_value(data, data->REG_CRITICAL_TEMP[nr],
 				    data->auto_temp[nr][point]);
 	}
 	mutex_unlock(&data->update_lock);
@@ -3506,9 +3507,9 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 
 	/* Start monitoring if needed */
 	if (data->REG_CONFIG) {
-		tmp = nct6775_read_value(data, data->REG_CONFIG);
+		tmp = data->read_value(data, data->REG_CONFIG);
 		if (!(tmp & 0x01))
-			nct6775_write_value(data, data->REG_CONFIG, tmp | 0x01);
+			data->write_value(data, data->REG_CONFIG, tmp | 0x01);
 	}
 
 	/* Enable temperature sensors if needed */
@@ -3517,18 +3518,18 @@ static inline void nct6775_init_device(struct nct6775_data *data)
 			continue;
 		if (!data->reg_temp_config[i])
 			continue;
-		tmp = nct6775_read_value(data, data->reg_temp_config[i]);
+		tmp = data->read_value(data, data->reg_temp_config[i]);
 		if (tmp & 0x01)
-			nct6775_write_value(data, data->reg_temp_config[i],
+			data->write_value(data, data->reg_temp_config[i],
 					    tmp & 0xfe);
 	}
 
 	/* Enable VBAT monitoring if needed */
-	tmp = nct6775_read_value(data, data->REG_VBAT);
+	tmp = data->read_value(data, data->REG_VBAT);
 	if (!(tmp & 0x01))
-		nct6775_write_value(data, data->REG_VBAT, tmp | 0x01);
+		data->write_value(data, data->REG_VBAT, tmp | 0x01);
 
-	diode = nct6775_read_value(data, data->REG_DIODE);
+	diode = data->read_value(data, data->REG_DIODE);
 
 	for (i = 0; i < data->temp_fixed_num; i++) {
 		if (!(data->have_temp_fixed & BIT(i)))
@@ -3774,7 +3775,7 @@ static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
 
 		if (!regp[i])
 			continue;
-		src = nct6775_read_value(data, regp[i]);
+		src = data->read_value(data, regp[i]);
 		src &= 0x1f;
 		if (!src || (*mask & BIT(src)))
 			continue;
@@ -3782,7 +3783,7 @@ static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
 			continue;
 
 		index = __ffs(*available);
-		nct6775_write_value(data, data->REG_TEMP_SOURCE[index], src);
+		data->write_value(data, data->REG_TEMP_SOURCE[index], src);
 		*available &= ~BIT(index);
 		*mask |= BIT(src);
 	}
@@ -3818,6 +3819,8 @@ static int nct6775_probe(struct platform_device *pdev)
 	data->kind = sio_data->kind;
 	data->sioreg = sio_data->sioreg;
 	data->addr = res->start;
+	data->read_value = nct6775_read_value;
+	data->write_value = nct6775_write_value;
 	mutex_init(&data->update_lock);
 	data->name = nct6775_device_names[data->kind];
 	data->bank = 0xff;		/* Force initial bank selection */
@@ -4337,7 +4340,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
 		if (!src || (mask & BIT(src)))
 			available |= BIT(i);
 
@@ -4357,7 +4360,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SOURCE[i]) & 0x1f;
 		if (!src || (mask & BIT(src)))
 			continue;
 
@@ -4417,7 +4420,7 @@ static int nct6775_probe(struct platform_device *pdev)
 		if (reg_temp_mon[i] == 0)
 			continue;
 
-		src = nct6775_read_value(data, data->REG_TEMP_SEL[i]) & 0x1f;
+		src = data->read_value(data, data->REG_TEMP_SEL[i]) & 0x1f;
 		if (!src)
 			continue;
 
@@ -4630,10 +4633,10 @@ static int __maybe_unused nct6775_suspend(struct device *dev)
 	struct nct6775_data *data = nct6775_update_device(dev);
 
 	mutex_lock(&data->update_lock);
-	data->vbat = nct6775_read_value(data, data->REG_VBAT);
+	data->vbat = data->read_value(data, data->REG_VBAT);
 	if (data->kind == nct6775) {
-		data->fandiv1 = nct6775_read_value(data, NCT6775_REG_FANDIV1);
-		data->fandiv2 = nct6775_read_value(data, NCT6775_REG_FANDIV2);
+		data->fandiv1 = data->read_value(data, NCT6775_REG_FANDIV1);
+		data->fandiv2 = data->read_value(data, NCT6775_REG_FANDIV2);
 	}
 	mutex_unlock(&data->update_lock);
 
@@ -4672,18 +4675,18 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 		if (!(data->have_in & BIT(i)))
 			continue;
 
-		nct6775_write_value(data, data->REG_IN_MINMAX[0][i],
-				    data->in[i][1]);
-		nct6775_write_value(data, data->REG_IN_MINMAX[1][i],
-				    data->in[i][2]);
+		data->write_value(data, data->REG_IN_MINMAX[0][i],
+				  data->in[i][1]);
+		data->write_value(data, data->REG_IN_MINMAX[1][i],
+				  data->in[i][2]);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (!(data->has_fan_min & BIT(i)))
 			continue;
 
-		nct6775_write_value(data, data->REG_FAN_MIN[i],
-				    data->fan_min[i]);
+		data->write_value(data, data->REG_FAN_MIN[i],
+				  data->fan_min[i]);
 	}
 
 	for (i = 0; i < NUM_TEMP; i++) {
@@ -4697,10 +4700,10 @@ static int __maybe_unused nct6775_resume(struct device *dev)
 	}
 
 	/* Restore other settings */
-	nct6775_write_value(data, data->REG_VBAT, data->vbat);
+	data->write_value(data, data->REG_VBAT, data->vbat);
 	if (data->kind == nct6775) {
-		nct6775_write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
-		nct6775_write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
+		data->write_value(data, NCT6775_REG_FANDIV1, data->fandiv1);
+		data->write_value(data, NCT6775_REG_FANDIV2, data->fandiv2);
 	}
 
 abort:
-- 
2.53.0

