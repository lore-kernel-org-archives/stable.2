Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380206;
	b=YJVog9hRFOk+u9dqKQO89U/BsinLDzDY7B4sL+RjzZSHhPf7NZtDbx5q9f9QUK8KeTDq
	 tYr+dlmrsIoorAOe8+/J2tqTvvRL77SUAPleRZ6rK/ueieSqbM/+74GOCTm2MyZ3Mpbwb
	 /A6P+WD8hqMmttVTJfudBwJ1ttLBnvvMrUtN6tWs/Swjlju4/mioYzzFr8+8iNodMvpL1
	 IY2ohmvzu7J4Bsy0onwYKWiu3aSVn5x+wSv2hichIy+CckDOHkuCgheB3aoaLMq2fzhfj
	 hIc4l0pPDemVfSqf5bQD4fUUWx6Q99/nZweGd42+uQ5f3aAOmBbvLDjUsMrlq4IkrGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
	b=D60XA/+f/EEPlsl/aPAYLqQcu0V3zaS899AWdGicDyy/W85R4JoiZVoZn5TwFd6ClzBh
	 HSD582KEUpitmCYvQc0+yO8rYxGeGwIjrk+cx2jFHosQDPIbvt/3plp2XTvMp6h1fLYkD
	 3Tkvp29OlaYwCka7DsUh7FnIP21TtvT44ojllrzwL7LxG+M/Bz+36gC91gXLqcrZ3sGJ8
	 Opx6diha+P0j6ACXkHlE0Ow5v0TN5qfAuEVBLL8B6AsPnstJodQ7KXhRVvI6+aZTykNkH
	 /cCiwlsr6h1ReU/oopkW4dOKlCFcGIhu34HcxJo9raDB3XnYjTC8i+Lh5xlIQWnUxBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzCsqm0O;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9187360A6F75
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9187360A6F75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qzCsqm0O
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37628596783so1712014eec.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380205; x=1794985005; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
        b=qzCsqm0Ov4zq78nTlrvSlkNvKa1AjVMSX2+8EyVkC9mifpb7lSSzD3zuTciPyYlYQT
         Up2WEpjuwqCeFQ2dGCRM1bD9/f+vyN50TbAebx6MZOgoxMR0EZNy33Xqz8tSow3BLza0
         NLgsIcPrviyQTei0d0br81aMWiM9i15C2LAaSXj2cnBksbeualEO4CHE+k8eEr/rsDpt
         8LqO7tSwGeTtIz1Ele+GAxDTmKwjs956NgzZCXBQFuKieKiWjowMJyE4Ds7zFLhUnjhf
         8RMhhfAyXNVeoSq+Jt1xWNeT/Hoa5qAQMyMDsEjRkLhjZG3eG0dlvJs6QIzwqPZSUWcg
         LbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380205; x=1794985005;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tRiGUdZDbUH6e6UAZLEy4irsPtafHp9cuwISJdPL7/4=;
        b=CyeJdhr+xPT6H7K3/A8XdihLiKB/wckMShybnIJaMwmS52Q+ZM9lOqm2HCyepQxSYN
         hIw7bTjODE1ESSH15A9aLhi4IzvGvIY61DxO2Dd4dfNWP+UqY/Qj3mvEsixOAeHSVSgS
         CkaF9OPBl+d2cjHAi2ZPMqAmLKpCOjpJdKvUHVVo4kWiLC3z+9UyCi3H/GULwj8lJfkE
         lwyK1e184Q8+D6OstpvlvZChwobr/AVK8ratnxAa5nEgVn/TGibRgRtZ+IcT1tsjMBfB
         l+/hpfaaR5muqZInEkj6EgdJl9mEDnR6D/8QF24YucZODBn79WOpCGNreEa4FGHnXpkx
         VeOg==
X-Forwarded-Encrypted: i=1; AL+hErH0wqyWArToxeQfBaGgzdiU4YZkRYqReY1e8dFQzsBresn0jLn8xk/ky/bHArBO2zuAq44VNqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z8rbX/n8l/t+1dESd6OClhsNhEgoRlfLQx+ks0B7sTldkO1A3r3
	Wvge+RJGumnqBP7pY4kMVrvpdLreEm5Sfu6s+2EjNDYj5K+0OrVg8Xx7qcVE+g==
X-Gm-Gg: AYBFou27udljwUPyh7CwkNNTPaYaAFmveB9dueMq5epiGVIOFtx2D9IPCkdWD8oPmeb
	2PizhaL6+XwC4lvLdkoz1fw6hgaMuvDZTJITmfDcQUHF4h1uVU+gdZIyOPOVOvj+HWGChBXje05
	uW6VGr1VOcNXBYBgMZ+mtps/Z7ux4eH/vO0oSw1L0GDSISis1YUYt7+CMi8pZonJtvUN1v3yGfn
	1u7Rd1WU6jDXLeBtjbdZsQZDwGubRt52z3Kk7lydNaf4lMpF3nPaOG98QvoOEEt8T6N8BxPay51
	R90ye7X4tclq6ifYy2fQ0AfB+XoCKsrAiVp0KhbOt8TNnGOpkXTHsX5q9oj9TVJ2TtOGGIQNnUz
	dxewbQfGzzehsxY8YtTmnTSOf3n+k1+t7D9aFilkPNyz4V/+EFC0ne1tk8Up0of6XttxfkUuolb
	nxO2V06rIjA0VYhj5bcRuPYC4xgRE2/wop3rD1cDKE4vxTjLnrOJF8Edx1OV3KvYkKUnAc57R7l
	T3by74dCz8uJKTGW66BoONPABHuUaLQl74KkmeQx97LkVVR49+4SV19M1TniFwsuoZorNJ9Z4Ii
	qtjVDghvmgV5ysjcL7eWg8MgX2x+REZlaALoOqpVdFwPAgoM2IR3DCdHIOxOlyMhAum6IOrgp+b
	iR08qfjqxjxJJ2uRuVw==
X-Received: by 2002:a05:7023:a47:10b0:1b3:b67e:9fcf with SMTP id a92af1059eb24-1b3c03108bcmr1532997c88.17.1794380204475;
        Tue, 10 Nov 2026 22:56:44 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:43 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:12 -0800
Subject: [PATCH v2 14/33] HID: logitech-hidpp: expose charge_type property
 for battery voltage feature
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-hid-logitech-hidpp-v2-14-30743e91d83b@gmail.com>
References: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
In-Reply-To: <20261110-hid-logitech-hidpp-v2-0-30743e91d83b@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-e56a4

Commit be281368f297 ("hid-logitech-hidpp: read battery voltage from newer
devices") added support for the 0x1001 battery voltage feature, populated
battery->charge_type, and handled POWER_SUPPLY_PROP_CHARGE_TYPE in
hidpp_battery_get_property(). However, it did not add a placeholder slot
in hidpp_battery_props[] or register POWER_SUPPLY_PROP_CHARGE_TYPE in
hidpp_initialize_battery() when HIDPP_CAPABILITY_BATTERY_VOLTAGE is set.
Consequently, the charge_type attribute was never exposed via sysfs.
Furthermore, hidpp20_battery_voltage_event() only checked whether voltage
or status changed before updating cached battery values and notifying
user space, ignoring changes in level and charge_type.

Add a placeholder slot to hidpp_battery_props[], update the fixed
property count in hidpp_initialize_battery(), append
POWER_SUPPLY_PROP_CHARGE_TYPE when HIDPP_CAPABILITY_BATTERY_VOLTAGE is
set, and include level and charge_type in the change detection condition
in hidpp20_battery_voltage_event().

Fixes: be281368f297 ("hid-logitech-hidpp: read battery voltage from newer devices")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index cdeb1b3c2f21..fb9ad4cfc583 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1553,7 +1553,10 @@ static int hidpp20_battery_voltage_event(struct hidpp_device *hidpp,
 
 	hidpp->battery.online = status != POWER_SUPPLY_STATUS_NOT_CHARGING;
 
-	if (voltage != hidpp->battery.voltage || status != hidpp->battery.status) {
+	if (voltage != hidpp->battery.voltage ||
+	    status != hidpp->battery.status ||
+	    level != hidpp->battery.level ||
+	    charge_type != hidpp->battery.charge_type) {
 		hidpp->battery.voltage = voltage;
 		hidpp->battery.capacity = hidpp20_map_battery_capacity(hidpp->hid_dev,
 								       voltage);
@@ -1795,6 +1798,7 @@ static enum power_supply_property hidpp_battery_props[] = {
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY, */
 	0, /* placeholder for POWER_SUPPLY_PROP_CAPACITY_LEVEL, */
 	0, /* placeholder for POWER_SUPPLY_PROP_VOLTAGE_NOW, */
+	0, /* placeholder for POWER_SUPPLY_PROP_CHARGE_TYPE, */
 };
 
 static int hidpp_battery_get_property(struct power_supply *psy,
@@ -4398,7 +4402,7 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 	if (!battery_props)
 		return -ENOMEM;
 
-	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 3;
+	num_battery_props = ARRAY_SIZE(hidpp_battery_props) - 4;
 
 	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_MILEAGE ||
 	    hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE ||
@@ -4416,6 +4420,10 @@ static int hidpp_initialize_battery(struct hidpp_device *hidpp)
 		battery_props[num_battery_props++] =
 			POWER_SUPPLY_PROP_VOLTAGE_NOW;
 
+	if (hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_VOLTAGE)
+		battery_props[num_battery_props++] =
+				POWER_SUPPLY_PROP_CHARGE_TYPE;
+
 	battery = &hidpp->battery;
 
 	n = atomic_inc_return(&battery_no) - 1;

-- 
2.56.0.542.g3ef89b7020-goog

