Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380202;
	b=mITVqNndBmjaI9mYc9BfQN0hry6CqXGo0tE+I9YMMoveyYIol8J/L1un6g/lggsjXuMT
	 OEGJhqFBCyHRGc+twXIsUSzsLq862Yg6uVyPxEj698YIGrXxHW2cAOTkaawJLjMSvNWpZ
	 PiACBGonEZ4Fc24Juy/WXx8s6gsk0E+ZOSoBC0G9/rRVzxWjSlL9TAbG66uIeLHNZXMto
	 XjVpFzotyxzutskpz7da7ErMYtZqMMmJb2Pz5DPzrEITtbda28F29xAmvK3uoVX5Lb9lY
	 AUdp1ufagUBllLl3FCBU5/Ym09uZjCbTU3sR9IqVzLwk8OUGodad0CVB3/STP66cHFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
	b=WDTfllDGabOMqZllsCzKP7jCjXgCqDwVmTQjH7i1QpHlizqODRfv7/yJE9l2/h937K8i
	 UMLosazajiGemJ3u+vXi4wVmwKNoLZ6CF1WmZ9SCIVC9q5TO4mF3l9HrW/YV2CW6oarLy
	 0Z0ypTD2hdofOC2PputIMFlvEjptSUsWiV4tx0IaNsT78eIePqa2cyMShjJs+wcFtIYxy
	 dnMzreoOuYKM0RCsmGi/V1SysaNGJquO1tpQBgLk6b9cawWdPwXc5AfBhlyBf3pOdIszU
	 Q89VmNRi8RPeP0QJOMHsVHEdKo5/wy+HtBou322IKJaU9yzUlsyfjSPya/j/QGXchiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPl5TzAq;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EAB60A6F4F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00EAB60A6F4F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zPl5TzAq
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2761c69fbso4759238c88.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380201; x=1794985001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
        b=zPl5TzAqaAandcmyf93fMP/SKnmJFwqHEkWQEndip5DNWbt/eDobWVihWYuECbfMxA
         oR1/YK5tWXzWXDZMBqOsQ+F6VpVljf0ycYIC0hHiJPc9xGsyQCSmD8JBM9eaHfAKfWyP
         G1/ia4qD8Vjn6iogDMfSMOtalQjXpsW+Nmu+cfVaxey5h3y3cC2oKgfk8UYMArcSDIgE
         zEsPsfhBEfrrB/jKQQU/DmPDsVKkigtr+Irbw+jVJ1jDa4Y09dFhNzN/rbFC3wQ1ouX2
         eeHEikZkG4N6kebZuq7LFrMMmgyPVIslYG1xvjgK2xLlvgbGRJr0gyx6KgvFkz8tXxtB
         4LwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380201; x=1794985001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1Yt98aftbzappM4NZjAdKvDjSZighEgA8WJl219P+eE=;
        b=SESIfvx3wofiXpBZLvTi/4ScPrNTNWnsLppqd11hxceodRuECNdfspmaaoWQmTgt3H
         OHzQpjzFHYf7Jvdtq7oFy5YgQnhh/M1c8YvjZRzkRGliNdIfHdMqDqG0cyxLpvf+TE+7
         CZfwXSOq5M8USFW7trzDRAiQDur+vFRGiAQNY4J4+Bq68bWcX/oH4YQCOXilar+AFnZm
         79vqcq16JrsoNJWhc5AvaizEvtbb8g9a6cWEXOQdlO8MF8vJAF+6V4wL9oHCj4TUgfxx
         cnLQm07rIlXlIMcvDJeZGnFc3g4fQ8S3SdAUOAnBXyJOWVl0a1dd0ErgtxTKxeCpldKa
         OsPg==
X-Forwarded-Encrypted: i=1; AL+hErEJDcPUMEZD4vPFClQSZlGN3Myfw7Gyd2pl7w4mlq3j29avxi5ANS5WfVV5klcfs2/7dGllXe0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IpZlL4Ml6Zty61NFb0veTjG5G0QzxOAMxjXXb6Od8mTgFjTOw
	q0w2MCdPyQz/5wt7CGMzyVCTgra8/64lDTkKBQvpEbqVxfMITE0+LE1K
X-Gm-Gg: AYBFou0IeGnbOr/kFPH2nSj9qoQKCF7jqXrMPHeVpF0LCXcg3R/QlNQbJKAh7BgB18U
	DZRUP0sqFWOQeTuiPcKCsktXmjKqgNiKvzepARuE9tawj98AlXRhswPTO7y6h+M6PQ01BD83xTT
	eTSEdtzlwAYEsqS8dN2PJ1vMgLKgczkeOHquQnPunNusZM1VAAw/9Cf4EXIREyic66OPdeuQa3V
	ioP92LWROyy5Iwf5NxpUGJ0CGrJWCPnceISQAj9qoF46zn1wr7rbBuWTgoyGSh1hDW+HwPkKndN
	FmeD/shlMTgfNIu2NoVS2+WV18R6sfu0bFpC3sbVPCjGpKi75vGCpvnSZj/5erMReopitPYelep
	Vy4M3UG7xYCLtEE2hgFWY4OSxzDFSEi6O+A+jeqAIOk3ICaJiMWnt9qDPrXnmYa/YrCEgAHi4Og
	pi9T5XrLhWc77E+c7508uqkF4bbN85N088HxcOpJ5f/F5KHk9r0WwWRuTehPN5+aeX8rwB8V0Id
	uMfKgF9xEbHLlIaeRuyB6LtvRJ5nYLjDzb8iHNdhglkf7FI5qYaZaxaSYaM9l97WaCMgPOtL9gH
	LaD5NpybFP7yn2GC4FGW6BfrLsnvIJYpNHo0kZfohm6sLtUzQ8whtCAcpReSXrMcDwzZ1IhW0uO
	dtf1VcsJDNBgpnXeYlgBdqI44TRXWRokqWG8EvsA=
X-Received: by 2002:a05:7022:1e08:b0:1ab:aaf3:389d with SMTP id a92af1059eb24-1b3c023c0d1mr1325386c88.1.1794380201027;
        Tue, 10 Nov 2026 22:56:41 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:40 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:10 -0800
Subject: [PATCH v2 12/33] HID: logitech-hidpp: mark device online on
 unified battery 0x1004 events
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
Message-Id: <20261110-hid-logitech-hidpp-v2-12-30743e91d83b@gmail.com>
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

When a wireless device disconnects, its battery state is marked offline.
However, when the device reconnects and sends an unsolicited unified
battery status event (feature 0x1004), hidpp20_battery_event_1004()
never updated hidpp->battery.online to true and did not include the
online state in the changed check.

As a result, sysfs POWER_SUPPLY_PROP_ONLINE stayed 0, power supply
listeners were not notified of the online transition, and the 0 to 1
online transition check in hidpp_raw_hidpp_event() failed to schedule
reset_hi_res_work to reconfigure high-resolution scrolling on reconnect.

Include !hidpp->battery.online in the changed check and mark
hidpp->battery.online true when receiving a 0x1004 status event.

Fixes: e037acf0b1ae ("HID: logitech-hidpp: add support for Unified Battery (1004) feature")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 28402baf04fb..f717f0308454 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1761,12 +1761,15 @@ static int hidpp20_battery_event_1004(struct hidpp_device *hidpp,
 	status = hidpp20_unifiedbattery_map_status(hidpp, params[2], params[3]);
 	level = hidpp20_unifiedbattery_map_level(hidpp, params[1]);
 
-	changed = status != hidpp->battery.status ||
+	changed = !hidpp->battery.online ||
+		  status != hidpp->battery.status ||
 		  (state_of_charge != hidpp->battery.capacity &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_PERCENTAGE) ||
 		  (level != hidpp->battery.level &&
 		   hidpp->capabilities & HIDPP_CAPABILITY_BATTERY_LEVEL_STATUS);
 
+	hidpp->battery.online = true;
+
 	if (changed) {
 		hidpp->battery.capacity = state_of_charge;
 		hidpp->battery.status = status;

-- 
2.56.0.542.g3ef89b7020-goog

