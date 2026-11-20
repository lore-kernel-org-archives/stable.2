Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164075;
	b=BJAzskpBm18XhhkJxpLVpDGVTFaeRt2gx5PKqO36fjPRI34uCmLsjlZbc3NEMhZN8TbQ
	 +XXXzLKj/fWFsPEQG5dZ0mASIH4yMtygrVPZ4OAXRmArVDzl73sBSGCeLrIRKg9Wwt0VU
	 iSjuPHQqp0r/bUGb24lUMg6PPM8MMUNq/SNlzuddkRDSwLv1ZDEzrIV/htojXhdIcBBiU
	 p5BMWhiqoYz1pqwRHxrWXyJWWM+fA9v26FEOHa2KzSpPBbZxENsheE3TJ4bE2jOVMFO5a
	 qjSmeI64a7pBmDpJOIOjVxHyGANN3ZDnbg6ZF2K3JuEpb6gJ35owj2MbbqObyJ9wY0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
	b=cjr7OBhNSM4D1b0JNp3KqoHS9XfJQ7zj+fqrzGB/uf+bhm7j6cxYFqbhrYQu6qBLTFG1
	 5yJFqcRotdTHg9e1+Q/LDT3xFcoTfwby2PAeMyhhCsXGQb9RctKLQpauUVZozvM4/76Z3
	 ta1nXiUn+ztFLHVM/SlMBvfDupitLn2M9tIcwox86EsgD1hNfggxaEVq3pvBoNZeRnnti
	 flzwIyoaw/gAd3xoskYwSsAV2U/CC/CeK+s7T/cldLTGOp17sfMzmXXWZYkRAv0Ww6EPs
	 OAukqm2uGN0rQKQAh3KHrFSO2O25bcCcWnlmeFGMwEXOvU/IOVmMq0dQOfC9axHqxgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zalxmY5k;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689FC60A6F6C
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689FC60A6F6C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zalxmY5k
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-38644aedba1so123286eec.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164075; x=1795768875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
        b=zalxmY5ktb5q1XhAa6vkc7KDCqft8ehVrCQR8UAfYIseCffLXh2tfM4A//m+HSe31A
         qOgWnLMMUWwV2ujE8uB8rkqzSS+RxLIEhur5RgW7Y1vUPQd7zQNqqQUf5VBPM4q6mJ87
         dQi2dfWRe/IURzT7nLFAik58d6IH5qaxzCAZbdG6zP4EVdm4LdDxQyUSgKFGhSNUgGc4
         TgsTg1CfrxuYMYT/NeCxwGY24nW6gaCrzw+uDgSI9vLOFi7OeS+XcwLfR6BE4LkQcsU2
         ZEjUzb+2pmSMd9gPZn04LQuv5ScGLdfyAsWgRJo8zA2GB+kU9aIRVcCkdT8fQFU3Nx+k
         SUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164075; x=1795768875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HGzRbKnELJ8qkWoVQZYvDioaGdGM1A2dPzzsZl9uGoE=;
        b=rLi8qf4Vifj0q6QKm3chybsfuUYIc2tfVbxLoDVfrLiMXX0bnhqRzs7C8G6qezMM9q
         eZXKQJoj+Mh540tkKuBHUwQrNOLkK6IO7GVQ+aTiETLnbGiebbT1nU4xSfct9IiefWMK
         7vu4towvUO8EORRb2BWLTo+d54fEmOHgNq3fDOWJ4rrvjgDkqNYQ6R1whfGigUmacmzQ
         /hXVFUAkGOAgIXT1R0NiJvxiZZpb6MwvpsLk3Ytns5wAS406rcXymlExLKppK0nlygdJ
         i3H9sNibScKomZMt3Tzf2Ed7ExQfo6o0VLKmpAnrt/yw8UP0DmAX2xw351lsbbCM7CeP
         CpmQ==
X-Forwarded-Encrypted: i=1; AL+hErHM8bq9CqAlQt4PtHAPt+ItLU4iaWSDSzSmsjDnNZmWsmaNn1aeY54lSye7vmhpmvqaEBhMUWs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WgjHiJX+mEk1Uz5hi1/omyf56AIGNfQ1lChZTfbe295mxtB0c
	RmPwULHBc2DjQkBkdqtoVP50jTNIy8YO7tvxdpccWJ6zUpOvnHIShReX
X-Gm-Gg: AZFdTZcFxi5NOQpJrK/na3i4g+v20qWHs1RQLmr6ig6YD8YDnzWtApMLFTTwMHGcUmE
	QU4gT9TVMtzx5y3H3/pzPJQd4GnDyIa+Whx7sYgeubcWpptvaCWhTjwbRQmnldRPzTBjM2lQ/6n
	TG65km8og8zms8aBueGEOjgoSqib5NMtd4MASfVhGSexOcOEDq7jmsGFS9tf3O+3P4Y8nnAzdw/
	7xfKPQ5VK/rp3Qkku+k7RmiFgrUCFih5xM1sDbX1qf7ApH45/Gh6uecEZ7QXReQAQmkRB2mFmea
	HnE5R+HBIfmvK1kbr2xeWjxU2tLUuh6mmLtsizrSm4IEd82KHVzJvXG1Fto5yMsdqVwtlstQCZm
	TKwUWetjgBAxs4Wmn85Eg/Y+rWFVxJ4WhmOiG7OJyvTB9w/hekRt6UCO7E1YE3WfXW2whJLkVeG
	gJvpp0fkFQx5NNZwcVq8subKMoUOusaa/TUfS2CBeLlHWiXJWnaM8igEtsnk8H/COdZFI+fYLrO
	Tc8/3sG2+YGvheQ3cVo2NCXTgESMbniQHgYPN1aOeRSAXkNjsc7ZooWcgXOxoN8Jiolb3EZXldy
	4AHrQBKJzo0APbt2iskeNV6yYPSkyogH+5P4Zo2p0u0F9x2JHLfrgkaEYkjXnR257ubKofi1API
	DZr4VRvET3Nbhrvmtgg==
X-Received: by 2002:a05:7301:182b:b0:36d:9900:bb92 with SMTP id 5a478bee46e88-3856f256533mr1782564eec.10.1795164074557;
        Fri, 20 Nov 2026 00:41:14 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:14 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:59 -0800
Subject: [PATCH v3 11/14] HID: logitech-hidpp: handle negative errors in
 hidpp20_get_adc_measurement_1f20()
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
Message-Id: <20261120-hid-logitech-hidpp-v3-11-cfe2caa1d0eb@gmail.com>
References: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
In-Reply-To: <20261120-hid-logitech-hidpp-v3-0-cfe2caa1d0eb@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?utf-8?q?Filipe_La=C3=ADns?= <lains@riseup.net>, 
 Bastien Nocera <hadess@hadess.net>, Hans de Goede <hansg@kernel.org>, 
 Edwin Velds <e.velds@gmail.com>, 
 Stuart Hayhurst <stuart.a.hayhurst@gmail.com>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-6b8b8

When hidpp_send_fap_command_sync() fails with a negative transport or
timeout error (-ETIMEDOUT, -ENODEV, etc.),
hidpp20_get_adc_measurement_1f20() only checked if (ret > 0) for
protocol errors and fell through. It then parsed zeroed response
parameters (0 mV) and returned true, marking a disconnected or
unresponsive device online and triggering spurious "possibly using the
wrong voltage curve" warnings.

Return false whenever ret is non-zero, logging the debug message only
when ret is a positive protocol error.

Fixes: c361982a13c9 ("HID: logitech-hidpp: Add support for ADC measurement feature")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 0ec2f2fd6dec..28402baf04fb 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -1952,9 +1952,10 @@ static bool hidpp20_get_adc_measurement_1f20(struct hidpp_device *hidpp,
 					  CMD_ADC_MEASUREMENT_GET_ADC_MEASUREMENT,
 					  NULL, 0, &response);
 
-	if (ret > 0) {
-		hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
-			__func__, ret);
+	if (ret) {
+		if (ret > 0)
+			hid_dbg(hidpp->hid_dev, "%s: received protocol error 0x%02x\n",
+				__func__, ret);
 		return false;
 	}
 

-- 
2.56.1.750.gf70dc682cf-goog

