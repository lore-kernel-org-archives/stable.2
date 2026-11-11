Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794380188;
	b=crd/MN7ClQh1QeuoaBeZcKDimj4aSwuRhrC0D4U5WAkiDtOmmulqulP3sOQQr6/qlxN5
	 QpZLZx1k4I9KN6kJJwKtKs+4r0Be0NhnZ9xdA2hCf1F2VOuRxnMOd9lsFqMw9zKkblJls
	 EhZzckXzcISzmBL4eFtEZ3G00+LG3acfValopPT72RvaKqSJAUj13DUlwgozKo2WtE3sv
	 Dy0yFMUPm6P2ZIiwhoXnfh7Vuk6McDwwDILRx+rhXDVEXRn81T0SEs088mKG2q2Qh/vAa
	 EPPLhmttUJg61zW6W984dDxK+Qivavit4gNZgr6oGqlvwLFG13AJPkH27xwaG/avAqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794380188;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
	b=vJXfvaR9OU7LcxHHCIbDNAgqH5XwZwqqqx46yL1xWw52r5SjFhOmIlj41/xRitHnwM+C
	 UFprSOlvTmZhDaX2jK9tIyvQkk64OpR1b6znNVLQR22fmi/pBOeifaRmnC3SbynnKNkY7
	 X7S65WcS8uP0ofSGd0vuWbESmRXcThesQik6zBP9wzAyGRm7u5Zb0p61jEvR4iuW/Ksmq
	 p95cFLD0giVyaLrYnTbanY/slbXNQYWtyN0pR43zEPXbC8Bpc2ADmDFBg2JGtN1/fjbuK
	 XJC60tYbyF0G4hHYYH8X15jAqA1uJcCPyXTjELxLIt7wnNJgAwLt9lUlXLOMBUTWfBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcmqKOta;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607C9606A33F
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 06:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 607C9606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HcmqKOta
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-15dd124bbe7so4047727c88.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794380187; x=1794984987; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
        b=HcmqKOtaMbIzdNmicEoa8MVYrUmafrpOod9uwkTFjrysRnVzHZGMtl/av70cp5gync
         UzLIHltQXWLwB0bjPI0sv9CbgJBEXfE+hR73UkaYi99hP5CzsCFiG439hf4AKU5TKBcN
         wMeRqeo+6b0JA2siQOn0OYuap106vWCvd/0ekC2l+c9AlCFYvFMvcXCjxU/J97rLn7DE
         iDlfejyL+izOL/hUyiDI9cJrU7ZgmQUEF+98Hdl75vZ/t5gE14XG18w1rrQdWOMkbAfT
         M0/iuaRkAk21O6hnTxqU5nPY4Y81Ek5jAoWbl5WOPi0RLQRi4PUKwCSLjy2ST4KS1n6/
         ZvsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794380187; x=1794984987;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jda2LN7LPQB2P8XOQ+k0o80LxadgQqre8h5FmC/7gKE=;
        b=J/CGXyAKW9Tdhj6XGabVXF1w2zSaSxkHrYOeH+OjdptEM8Asd4FSrlUNJgAONLMmTY
         954D8S91yd+V3sbIclxzD1XFBC3+Slj/EWu8yJwtgRrwj0bJZAbtXflNt3BsBH8BQwYa
         eKYVHJ32KN1TmJjS8WVog2RIWrQsPOz9vmTJIJVA6frb60l82fHPKvl9LHzUmMw0fHrf
         k8ZZal7Hz5aeWBBTxuveSzLJIJfi7lW88WkRL2NHM0nx5Lu0xP7j6kzPRFfquG0mgbpe
         0lO/rkoB0ZUvZ97Xe2Jv5AblnyAX5xvft502TFh9+5qeCFxLtGIJOaCuon5AmCLtIiLQ
         zqeg==
X-Forwarded-Encrypted: i=1; AL+hErFPLClOO5LUg+orgnx4K4YBg2dhoV+M1jfsBmqhQC0C/laWA/Y8gnI2eHyskhvvVqAQkq6EebU=@vger.kernel.org
X-Gm-Message-State: APuU4Z92QIjV+K6VzNGRCU6NRbhztKQXL6f/CQUWMhAvF1x9bnj/zs9x
	SFOlSs5h3zbNmtEiqzVnZ6IvwrGuHXLHVEJyldwRt7vD9UQQCL36RUQ4
X-Gm-Gg: AYBFou1DDGL2c4ffo3lnyrN8kMM0BvVpdirKuFyN7AVOp1K7N8zGDM1aYb4mZkNS8Jc
	jZcGW6+8xn8f+R20gj7nI39Zuh/QAuEsv1X1H6SB2K44ZSdVdhERLm/hd1JoZBDAkFqs5xeq5Pt
	6qQQFyErHxAxPt29ETymuhZgo5fuOeDlF+YF8TJgEMW2wqKKXiNnhz9gHXK1Va5oicDsFisq1Fz
	F1ixP8FmtjzfzRfheg+sBUPoBcRCa2niqIbP6BLTLdMyxIkc0GAVnjx3mFIijEF93fk28oY8Glq
	Viy/iLgtwQUo4ePWng6E8eImJxU1rdGdr2agfxTqMrtcXsv1Z70hvgJ7GbxkNryr/ePaBCSs/sx
	Swr7vTtgIY+HmY1QLNR1PR+mjWLquWl1sMMWvb6+KoX6CPMDS60Znhxz/YahyMBP9dcEoR/bNdb
	Cl2c2FPXoZ3UOGqYxMlcySRqK8KUEOrkHAMO0V4Ull71SmH4xHMz0bwwtpaMHT0KssAFq+J0ego
	W0ZysZCInmzwOj3cdWESp5zfbDAMjINYKGxoxRoXLO26KrT0ITgMHLysBGqM0MLQxvgcJdAYost
	T95ro3i3HIdEydywDQYhVH6PwAqMaAU3cKhV0jqSJbgj9p7TiwpdAGBEfERw18EwEeaY9n8kCOT
	/LpKatRtxi9ZbHq/qIQ==
X-Received: by 2002:a05:701b:2504:b0:15a:9834:73f2 with SMTP id a92af1059eb24-1b3c0346852mr1464685c88.38.1794380187278;
        Tue, 10 Nov 2026 22:56:27 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:311a:ad7a:93f8:96c8])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b11435sm13858121c88.4.2026.11.10.22.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 22:56:26 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Tue, 10 Nov 2026 22:48:02 -0800
Subject: [PATCH v2 04/33] HID: logitech-hidpp: disable works before
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
Message-Id: <20261110-hid-logitech-hidpp-v2-4-30743e91d83b@gmail.com>
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
2.56.0.542.g3ef89b7020-goog

