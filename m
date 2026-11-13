Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582358;
	b=AFEzjT8ORHWWM+UhzToWiMgTEnZH4/TE4fn0QlwTdNUGqsf8g3dwXx6dvqbsDlAH4s1S
	 bGCFwXesL/s2HPX9eAPhuVsMoeRrXrQg5EPsd1rEBijdy7X6m5I9SgTM8v4bwVZst1lXW
	 2A1y0WEA6J8/7IeS4qVFFOLDIEcdOW6I1gyck1b59ZIQpS952hzer+WgAbw1LqbPJKinp
	 4oPK7RYjkd9WWs8INI/3yTN+P7UP4BQvJnPxME3yEez6wnUlVgX17zxUMSmBdQNXmJ5qN
	 2Tm38aw64JIj2GesvJjymdS2BfgnvN/oiddY6GPJ7p1nHWAUqXGKSgZavw57kvp4MbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gle08ePPT65t/dXx2aFi4iem1gzW7QmkLycDlCQNupg=;
	b=L8BtYsXMAEcCoPBjuUraZluDXgWKvPL4WO9XaZMJVVmD43vm9tBAQdh/32Lan0Mpp2Ec
	 RhO9pP9U19IfTpLLzODWh/yVGuVJweAH0STGZczfeQBL6q16jLexZ1y8YJtf46M9fIoX/
	 5f/3GrEvy5vSZ7w2GfcGIhs/jL8pwQf36lJnXZyJLa3na2hhdedrje6M6KdA3GHQ4SABG
	 Tvnu+RGfBaX2KOEil8m/kYym542VGSDW6ZLfu3c3NLS/58htRvs02XqiSXlqsk99vj0nz
	 n7SWsVRV+81MfBF447Qw1eJmFrxYmCSVT1K8G2hwl25TLSqONHmadUwZ4iSdT4oHmWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEQqT6zo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7BD606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEQqT6zo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD551F000C5;
	Fri, 13 Nov 2026 15:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582358;
	bh=gle08ePPT65t/dXx2aFi4iem1gzW7QmkLycDlCQNupg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XEQqT6zolSo5Z7nFWAG1na3HTf0CJCkHpXdJ19Qg//ONBxTZ3FxOQ6eRG3paE0dLi
	 N1+0T7L5o2KbliA5zMLJNwGg3t1lbR0k9Tjzri4mbw9XCWrsctmJh1YpasBWqUnzgb
	 U5xA7OUQSjcLIFNaCLq116slysef9x80GMGylzz7P4Sa+GNHKZ4PljGCEMhWamSOvN
	 2ig17puk7k1hynuPbiwY8cvRKMjGJB/WKggkgN40qkBoPaPAe8B8p65NyGMxRG8aC9
	 gyvcXM3sf8Y+zc5v8ExvxdDUy1aKbNVABVqaU4juuD7aCEWH+65LzpY03ub7L1Mn4L
	 cl/RW335UnhgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] hwmon: (chipcap2) Switch to guard() for mutext handling
Date: Fri, 13 Nov 2026 10:05:54 -0500
Message-ID: <20261113150539.1843706-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200719-failed-6.12-bed5f0c075eb@kernel.org>
References: <20261109200719-failed-6.12-bed5f0c075eb@kernel.org>
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

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 232ba88182083b4410df41cf310c9a16b84e547e ]

Switch to guard() for mutex handling to simplify the code, getting rid
of the 'ret = x, break; return ret;' construct and return the result
of the operation instead.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Stable-dep-of: bed5f0c075eb ("hwmon: chipcap2: serialize access to the alarm indicators")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/chipcap2.c | 63 ++++++++++++----------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 46a3e22f43ade..5f4b0fd535af8 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
 #include <linux/hwmon.h>
@@ -568,55 +569,40 @@ static int cc2_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		    int channel, long *val)
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
-	int ret = 0;
 
-	mutex_lock(&data->dev_access_lock);
+	guard(mutex)(&data->dev_access_lock);
 
 	switch (type) {
 	case hwmon_temp:
-		ret = cc2_measurement(data, type, val);
-		break;
+		return cc2_measurement(data, type, val);
 	case hwmon_humidity:
 		switch (attr) {
 		case hwmon_humidity_input:
-			ret = cc2_measurement(data, type, val);
-			break;
+			return cc2_measurement(data, type, val);
 		case hwmon_humidity_min:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_L_ON, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_L_ON, val);
 		case hwmon_humidity_min_hyst:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_L_OFF, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_L_OFF, val);
 		case hwmon_humidity_max:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_H_ON, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_H_ON, val);
 		case hwmon_humidity_max_hyst:
-			ret = cc2_get_reg_val(data, CC2_R_ALARM_H_OFF, val);
-			break;
+			return cc2_get_reg_val(data, CC2_R_ALARM_H_OFF, val);
 		case hwmon_humidity_min_alarm:
-			ret = cc2_humidity_min_alarm_status(data, val);
-			break;
+			return cc2_humidity_min_alarm_status(data, val);
 		case hwmon_humidity_max_alarm:
-			ret = cc2_humidity_max_alarm_status(data, val);
-			break;
+			return cc2_humidity_max_alarm_status(data, val);
 		default:
-			ret = -EOPNOTSUPP;
+			return -EOPNOTSUPP;
 		}
-		break;
 	default:
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
-
-	mutex_unlock(&data->dev_access_lock);
-
-	return ret;
 }
 
 static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 		     int channel, long val)
 {
 	struct cc2_data *data = dev_get_drvdata(dev);
-	int ret;
 	u16 arg;
 	u8 cmd;
 
@@ -626,41 +612,28 @@ static int cc2_write(struct device *dev, enum hwmon_sensor_types type, u32 attr,
 	if (val < 0 || val > CC2_RH_MAX)
 		return -EINVAL;
 
-	mutex_lock(&data->dev_access_lock);
+	guard(mutex)(&data->dev_access_lock);
 
 	switch (attr) {
 	case hwmon_humidity_min:
 		cmd = CC2_W_ALARM_L_ON;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_min_hyst:
 		cmd = CC2_W_ALARM_L_OFF;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_max:
 		cmd = CC2_W_ALARM_H_ON;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	case hwmon_humidity_max_hyst:
 		cmd = CC2_W_ALARM_H_OFF;
 		arg = cc2_rh_to_reg(val);
-		ret = cc2_write_reg(data, cmd, arg);
-		break;
-
+		return cc2_write_reg(data, cmd, arg);
 	default:
-		ret = -EOPNOTSUPP;
-		break;
+		return -EOPNOTSUPP;
 	}
-
-	mutex_unlock(&data->dev_access_lock);
-
-	return ret;
 }
 
 static int cc2_request_ready_irq(struct cc2_data *data, struct device *dev)
-- 
2.53.0

