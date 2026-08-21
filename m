Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CC4449B3E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787304192; cv=none; b=IfS90yG3riePRNJ7XQeDb9GkgNx/MmLHW3Nx+clxrfTNVzEMB8ZPkYgNFHI65PPicFGvi/TkpGmuNGHCsOSyXDZ4LpQKK1eT6BXtatPPhB+KqKAyFM+Sxq1/UOsizNpa+H1d7AV4tUvZuV678klkAyOaPImuRBZq33JvzmR3BQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787304192; c=relaxed/simple;
	bh=hQO8OzIVbst3gIhi1BPiKl2+n+sX9ZozFDZUJ3vY23Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iy+ayWGwZyH6X9BYs0TsOOi12Ow4zvJawgeaDo1Ud0em59SkOcOtb6rb6p2wsX5RFoFx/V8/iI8U83IRed1RZd+7JcrySnU8JjmPGA9uUHbZ8MAXdrgZxMk1Bd2KT385x8fJirT7lrbZBwqDVth1eearrDnYekS9A2Ei0QW3How=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H05LaDIo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H05LaDIo"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15c42a45adso318440166b.0
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787304182; x=1787908982; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=j7hSy5Nj3BqLZ1Scok/M+zpbpluheWEAaRTYJge3A/4=;
        b=H05LaDIoFQX5KjsQqfRCMPBz/A/jtPBdT5ByeMJqWW1HjN0oP55pEdbuCO5tnZ5/KE
         deA66oKZJnw1rZtKSavlH2RWLONshsffE7qhNX3tF/NaiHqBR+V/ubSeuN96Pa5/BF2a
         bkwdMGzm2ymOo//DFN9ecu9fZAbA+s500xTAVyi8vkd9EFjYRRyuBuDXV6M03sR+vbjC
         ElSNQByROTcSJDPScD5WR9aVjGLnjI5v5w+3MbLli6AVniXLrHLsTQ+kWsu9nRL1Oifq
         ZapnF5xX9LETH18/NaYtOckioe9mpg9HTyRhb5kFtlLEgSyVzEf+zNUbb2kxa4Z6Bgxe
         cBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787304182; x=1787908982;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=j7hSy5Nj3BqLZ1Scok/M+zpbpluheWEAaRTYJge3A/4=;
        b=GpnxWmt6lJ9VTJLAPMXOGifreTmH7XAyWBqN3AeC/MRixqZ4zJKjVx4T1q9uT0U5ju
         9oBJa9yWSsn9uTuFkTaDqnz6l8g5glEFmxNNN/+osAN2Fp/f2cAj0UA/35E64QxX8abo
         bse7Xki3lUCBYEQvDGU26SjmAKaL7Qg7cfAcRk3j4AeX0ji+TN0hFAXX5nbux54pOdPu
         yLrYek/LoC4M1mxbv53Pqqdw5SE/aIJE3//kQMcKsSQp6dZcvc7189st3xcvxTQtrxRa
         wVrMBGmcdSvwfcHIG1MR8UdwwXYZpe9KEPbXhD4gzCvi8c0ppv4Aaivvcmh028vgqnzw
         VveA==
X-Forwarded-Encrypted: i=1; AHgh+RohoISAW/CQeq3JfIZCWkBShqM9rxVUNvBx6ipVKepdHJqDeEMCy0MoAjnyag8HC8Trq/jZtLc=@vger.kernel.org
X-Gm-Message-State: AFuF++loE8tj3qgf4hP+EeY8KrbmKpsx+wzVZbCXMDdOqbUlCGfZV44r
	Wx7A9cWdQmbo958IZdFZBtGe7yFBApbIi7CyuD5xAlg7uWlGNa0JUMUo
X-Gm-Gg: AR+sD13M8wAr1RaKEbbQ4mKASpuPrxRTTuix8HZ/VLwm/opeTcmpFYIsDTm7r0VMzN8
	EIKi1rMcLtH0KMbdb5R9i4TsX4SIGUSpEh5wlHe/CZt1vqiYGGL8HDdc1/5Cm1OKO1dM0eaMVjF
	/+iEhviMw0Pesc1UmiQhgTVCUXEM+BvSaMG5DTV6i3FDGKGBxgz1YNOPxt3CAHZBdLufFd7yp85
	VeWxTos0ZOQegg+M/U8xO/myyp+vAVpj6izns7LTOxuDE0y2PKHyJzaydbPEUWtwPz17EaCWAA6
	qhmwR4J5bsWbE9x1TMaVh3m43myvg5B/GNnNG1mQqaXr/W4Y3OgbD59SC/X185pllbrfkDkjPPI
	KhZD9XpcrwRxr5zAEM/YoJVzV7YUZfUJ97C8HxY3Hl7/CSmd087sBucnvLA5WUykH4RVse03NJg
	XAeojl1F5MKQvUL6p+y+apqoXT0Hl1fCA26LuD+APiIP8Fo5TIl8uOSU8Bwu75rXxCyFiISUJO5
	AixHORFtgE=
X-Received: by 2002:a17:907:8d8e:b0:c20:61e0:e3ab with SMTP id a640c23a62f3a-c244d45a6b4mr1004196066b.3.1787304181932;
        Fri, 21 Aug 2026 02:23:01 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:104:2029:f763:df3e:9cca:dd59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2458b648f9sm364054766b.28.2026.08.21.02.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:23:01 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 21 Aug 2026 11:22:58 +0200
Subject: [PATCH] hwmon: chipcap2: serialize access to low/high_alarm
 indicators
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-chipcap2_locks-v1-1-1d8ccabfc1b2@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPEYiGoC/x3MQQqAMAwAwa9IzhbSKCJ+RURKjBqUtrQggvh3i
 8c57D6QJalkGKoHklyaNfgCW1fAu/ObGF2KgZA67AkN7xrZRZrPwEc2jBZt46h1yFCimGTV+x+
 O0/t+AsOkw2AAAAA=
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787304180; l=3705;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=hQO8OzIVbst3gIhi1BPiKl2+n+sX9ZozFDZUJ3vY23Q=;
 b=gn6eIx5NH+nYnnoXMg3uiFNVQ7ZcHyk3qw7tztgrwlY7P2AfXUb254l2Bzvi9xA0g9HLZp2r1
 VexGu29P6rNAn9ZCNX0580w6Qt7JXhaCUdw7V0VrLnAEq4lq8H40V9t
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

Access to low_alarm and high_alarm from the threaded interrupt handlers
and sysfs is not protected by any locking mechanism at the moment, which
can lead to missed events.

Add a per-interrupt mutex as the two alarm indicators are completely
independent.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
This issue was found by Sashiko[1] when an unrelated patch affected
chipcap2.c. The issue is real as the access to the variables is not
protected by any locking mechanism although 2 different sources
(threaded interrupts and sysfs) could modify them.

The fix has been validated on real hardware with an Amphenol
ChipCap 2 CC2D23S sensor.

Link: [1] https://lore.kernel.org/linux-hwmon/20260625162114.417EA1F000E9@smtp.kernel.org/
---
 drivers/hwmon/chipcap2.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 086571d556b7..1bb4ec96514e 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -73,7 +73,11 @@
 
 struct cc2_rh_alarm_info {
 	bool low_alarm;
+	/* Serialize accesses to low_alarm from threaded IRQ and sysfs */
+	struct mutex low_alarm_lock;
 	bool high_alarm;
+	/* Serialize accesses to high_alarm from threaded IRQ and sysfs */
+	struct mutex high_alarm_lock;
 	bool low_alarm_visible;
 	bool high_alarm_visible;
 };
@@ -500,6 +504,7 @@ static irqreturn_t cc2_low_interrupt(int irq, void *data)
 	if (cc2->process_irqs) {
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
 				   hwmon_humidity_min_alarm, CC2_CHAN_HUMIDITY);
+		guard(mutex)(&cc2->rh_alarm.low_alarm_lock);
 		cc2->rh_alarm.low_alarm = true;
 	}
 
@@ -513,6 +518,7 @@ static irqreturn_t cc2_high_interrupt(int irq, void *data)
 	if (cc2->process_irqs) {
 		hwmon_notify_event(cc2->hwmon, hwmon_humidity,
 				   hwmon_humidity_max_alarm, CC2_CHAN_HUMIDITY);
+		guard(mutex)(&cc2->rh_alarm.high_alarm_lock);
 		cc2->rh_alarm.high_alarm = true;
 	}
 
@@ -529,11 +535,13 @@ static int cc2_humidity_min_alarm_status(struct cc2_data *data, long *val)
 	if (ret < 0)
 		return ret;
 
-	if (data->rh_alarm.low_alarm) {
-		*val = (measurement < min_hyst) ? 1 : 0;
-		data->rh_alarm.low_alarm = *val;
-	} else {
-		*val = 0;
+	scoped_guard(mutex, &data->rh_alarm.low_alarm_lock) {
+		if (data->rh_alarm.low_alarm) {
+			*val = (measurement < min_hyst) ? 1 : 0;
+			data->rh_alarm.low_alarm = *val;
+		} else {
+			*val = 0;
+		}
 	}
 
 	return 0;
@@ -549,11 +557,13 @@ static int cc2_humidity_max_alarm_status(struct cc2_data *data, long *val)
 	if (ret < 0)
 		return ret;
 
-	if (data->rh_alarm.high_alarm) {
-		*val = (measurement > max_hyst) ? 1 : 0;
-		data->rh_alarm.high_alarm = *val;
-	} else {
-		*val = 0;
+	scoped_guard(mutex, &data->rh_alarm.high_alarm_lock) {
+		if (data->rh_alarm.high_alarm) {
+			*val = (measurement > max_hyst) ? 1 : 0;
+			data->rh_alarm.high_alarm = *val;
+		} else {
+			*val = 0;
+		}
 	}
 
 	return 0;
@@ -720,6 +730,14 @@ static int cc2_probe(struct i2c_client *client)
 	if (!data)
 		return -ENOMEM;
 
+	ret = devm_mutex_init(dev, &data->rh_alarm.low_alarm_lock);
+	if (ret)
+		return ret;
+
+	ret = devm_mutex_init(dev, &data->rh_alarm.high_alarm_lock);
+	if (ret)
+		return ret;
+
 	i2c_set_clientdata(client, data);
 
 	data->client = client;

---
base-commit: 818bebeb63dd6bf5f4e07e145f6cdbace520a34c
change-id: 20260820-chipcap2_locks-c01013a24a0c

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>

