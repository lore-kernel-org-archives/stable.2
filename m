Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164065;
	b=aQe3ilEDt8QIZq2kOIktWprOgC6Dy4xbJYVhD8NyFb0xbi5ChNYa1I4rWZu0ghLo/DUB
	 OyjCtS31D2eqdRhXC9SSdfW2x7P2G0BOahyapNWGPGNYk7pw+tqj8kQJiT+TdrLMIUhUE
	 21+XDYHsa/5n+iN9foMwQkl71bm+CL0F9deUU2KjslAYA/QY5SE/SpszP+oMR7g/h/AQr
	 RkfW7k4XFGbgcC65PeQrlBQTlNhADTr4Kf9pwBK5LsGfu5DkRbpoIBia4KJAgZGOTP/lC
	 CLBBLVWSWBDT6MTU+PgSk4IY05xh51hXScnEJzpMcb8FYHjEgCHMdY3iE2bMFdsfccQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164065;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
	b=S+RxmzzgjMpIhjhSPtAS4COjVOdOjrbVtjYq8vaPIOptZEkFua2cqO/16LPfrSXwWxap
	 8wgFLndAI0DPKJvEouIRe3QObuXPOGoJQzv9TYBTeAjF1rO7lENDqlsvrYfN4/Hot4ZJ6
	 XzxYYgOzjBM+s6+JmNits84wD43B8cPBBMrDpZLQ6rG41qskyzzdVncD52eK7K9MQEy6+
	 wqaZIbYipc3Nsv/sIr/kuAXBtol9J+MLsFEQKO2uRWD599q/S4RZvlt53gaPMTV+/Zi2p
	 7fH3nLM7pGL9eFfMexlUFy3RV3ndbZbG5bEHL3jbDKRRWGLlGxx6O0PzZC2c8nNy/yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UVPBQkQu;
	arc=none smtp.remote-ip=74.125.82.54
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7596760A380A
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7596760A380A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UVPBQkQu
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-1ae58d17cd9so656814c88.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164064; x=1795768864; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
        b=UVPBQkQul5d5hGJi9LEsCi4HC1Y8wHc7Q7prFHIIYy/TdiZpZ68ChYJK5k6dR2x3XC
         RlhjqVYuIgxpltaVjXqGnNUbzSFPsDU0H/mF46DFV8hktQPBY91untQx6YI12kry8E8H
         yxUveY4GUAHbQxErgx3q+WCcgwe9U07Hdogzxwy6PHgqfeZo07z4CF3wP24xrB8nOEq0
         ENgNy5B4yyn8UoSRtFfuvy7y+5Z/Jlef4PzcHEYT/Ik2GrH/fZrfdB0cMW/DhS31cDnv
         bY3M5f1fSFKT/ayIeCfxmjpWdMNZhIfz2X3E2YhpqWBkQ2jV68ZQGd/WL8UljTyfDu4H
         eJVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164064; x=1795768864;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Bt2PgIzmfYYqWvlsp18IRDzNq07DsE0CJgcW25urB8=;
        b=04IIYebIblrUfmTEeRPMKSo5WJaHI3ybs4zvz6/ILxkcW5+ybyfjS5NgKF1W+PQXpL
         YHb0NTSdZaTkmIBqd+i6KqV2/0zAkBvAm5bq7Z1bT9IseneAAf5rcVEzzjMZQzfRAiqP
         +Ony/9dX2EJCWGgxU27YnGdONZ/8/tPIeG/xAz2JBhsbyRkUZX15sVT0TEGOzLpBIKuS
         IF37hTBUbb6uCsIQmKvrtE3rJXEzgUloA5MiiWVpjDpQSerN2L5aR/rASwfPYOaNJv45
         sJFgDb1XdN8YqCza0JxNkK5eTSOmm1HU14g5HGRdJhwS6IBgRAAci7ADO8cqBipWUXy0
         n05Q==
X-Forwarded-Encrypted: i=1; AL+hErHXRzsZZOXaFtH04OtMxqImshSD/1c0QYfgnprobWwRxcCgHRynXNc0dnDLid+elWvVpTGYz14=@vger.kernel.org
X-Gm-Message-State: APuU4Z9tGeCQyhf5LwAKGDiiZpJX4/URa+xo2/++2FSMjiWTV+u6ichH
	bU1lwFxQ13lpUa8mHb1l3dGlnGHen89IQweyTsqHDyCIvrbCuWNbCnlk
X-Gm-Gg: AYBFou0dhqPe6Aa4X+8ek3CNwZj7YFrCqJgNPGSGWoXwMo0EloenIPlp6sZRI296U1s
	uOn7T+vTSg0wamcNBA9ueyM8IW/7g90cS4i7YHjQspHs8GfvB6HmJhij8eHH9XsXUvAhJB38jbI
	AIlPad0p6TPiMZVKqN5qDep5DkfGl35tzd464gw/lzuJ3v/IZXGAqOtEyp4GoXZe2roUE0byTJ5
	MkIATxZaWgkrVPQvef2201ONjgEfErFiRXw8AnPg31uzPTtM74GVgeGuh89HjOf6NIBS5kBkxZ2
	6welt8DoTIVgAa4tpOVODO94IyCFn+gXMHVJarS6u/xeqGjdXiROOQCG1WMf8tkUFy3Ez3uBaf7
	j/fgG+Jtl7kfXUeJ5olCdY9Kqbt1e/FRF0Xp3DS8atZPG+huxgk2KndCw1LdClWZl54QDSN4G/g
	NfP7/eH6JMlF5dWj6OGQho6YHhKAAPcqL9LhhHmPNATlzIvoXyLm/rdTTKpPDks3UXrTgTVk0HP
	ZMoNda9tuErr3VFgO0nHHfQaJUEX0ABoHjk2pv+1w8MyrLc4M0TR2Rbh5nDs3lT7odR6okT6EIG
	R08Epx8mSDtDOjYLjQpvImQ60YOnL412jjag2d6shNEc0PET2RbrsbFkEAY3qN5tY5RWrMvakFo
	Su3dt0lcAtvJQRylnpOnV5sz7oTa4tOgxnV1pGiE=
X-Received: by 2002:a05:7022:6985:b0:1af:16c4:d06b with SMTP id a92af1059eb24-1b55686d5c1mr2567968c88.10.1795164063592;
        Fri, 20 Nov 2026 00:41:03 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:02 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:52 -0800
Subject: [PATCH v3 04/14] HID: logitech-hidpp: disable works before
 stopping transport
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
Message-Id: <20261120-hid-logitech-hidpp-v3-4-cfe2caa1d0eb@gmail.com>
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

Device removal and the probe error unwind path cancel the connect-event
and hi-res-reset work items only after closing and stopping the HID
transport, leaving in-flight work handlers able to issue HID++ transfers
or register power-supply and input devices while transport teardown is
underway. Moving cancel_work_sync() ahead of transport shutdown is not
sufficient because incoming reports remain active until the transport
stops and can re-schedule the work items before hid_hw_stop() completes.

Disable both work items synchronously before closing or stopping the
HID transport on device removal and on the post-I/O probe failure path,
and drop the unreachable cancellations from early transport start and
open failure paths where incoming packets have not been enabled yet.

On device removal where HID core enters with device I/O stopped and
driver_input_lock held, temporarily re-enable device I/O to flush
pending work handlers and disconnect input devices before stopping the
transport. Clear HID_CLAIMED_INPUT and hidpp->input upfront so incoming
reports can still wake synchronous commands without dispatching events
to the disconnecting input device.

Fixes: 7bfd2927adca ("HID: hid-logitech-hidpp: Add basic support for Logitech G920")
Fixes: ed80cc4667ac ("HID: logitech-hidpp: Add HIDPP_QUIRK_RESET_HI_RES_SCROLL")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d5f53b35ac6f..0e1a9fd98faf 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -4805,13 +4805,13 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	return ret;
 
 hid_hw_init_fail:
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
 	hid_hw_close(hdev);
 hid_hw_open_fail:
 	hid_hw_stop(hdev);
 hid_hw_start_fail:
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 	return ret;
 }
@@ -4819,15 +4819,26 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
 static void hidpp_remove(struct hid_device *hdev)
 {
 	struct hidpp_device *hidpp = hid_get_drvdata(hdev);
+	bool claimed_input;
 
 	if (!hidpp)
 		return hid_hw_stop(hdev);
 
 	sysfs_remove_group(&hdev->dev.kobj, &ps_attribute_group);
 
+	claimed_input = hdev->claimed & HID_CLAIMED_INPUT;
+	hdev->claimed &= ~HID_CLAIMED_INPUT;
+	if (claimed_input)
+		hidpp->input = NULL;
+
+	hid_device_io_start(hdev);
+	disable_work_sync(&hidpp->work);
+	disable_work_sync(&hidpp->reset_hi_res_work);
+	if (claimed_input)
+		hidinput_disconnect(hdev);
+	hid_device_io_stop(hdev);
+
 	hid_hw_stop(hdev);
-	cancel_work_sync(&hidpp->work);
-	cancel_work_sync(&hidpp->reset_hi_res_work);
 	mutex_destroy(&hidpp->send_mutex);
 }
 

-- 
2.56.1.750.gf70dc682cf-goog

