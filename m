Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164063;
	b=fDgPEFjgRQ63q6ke3cFUkqDy1kSQ6+EL2bvVisSRX09dyeHEa9AY+m05YbOOqz6mE65s
	 GA2AXfFnrxPYBd3H+Sn8o+bqLVksGbUFHOBwFJH2FdwL9tutr3jNdcbE6TFfKCUK9mIaS
	 mSIwv4c/4djsAmW8AcSWYOJscFCI7tyuXyVooaQQLLwhXAjIv/b8BPfVYhG5OZA1qI7Sg
	 Hldw/e1A/EDrbJg+wWUcYBxaoV6P2g2d7rwJ4riAWE2NDk3gcfiK5J588Zp4HDzfH3XRk
	 3hXdCL6/d4OLmkuEHDYCKDdKLRiT13dkbK4qg3OhYXFfIEe+KFN0Bx5BrASvI2No7Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164063;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
	b=kCsGtE+PmdeV8mOTnW28USfp3H+5EzYuunvafr3f+iOQ8b143U1xzkfqjN/JpATwqTrp
	 FNmGQX9iu5rj7KpLQ4Q8Re6EuL1SBWgQjAswX5lIcQKx6uvnYvm/r6jCGEkVsr8ZFJGbr
	 7kR2WaAk0HKI27u1Hei3ArFAFs/Cq0qzR1LhAeCxKcvzEnhkUSVb6cNJdfr10v00uqnom
	 T4b9OA35Gql0ozVA9mHC5Wfh2lUuzAmdqNiV8L6UGADTVCzNOyDzEl+fNpqVqWVS5tQGc
	 yFHQvrOWHViN6lERp1c/lOm/1LAGFnfFtGShV6/rB9JEW0p5Floy1HnJmqiwr6B6bFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNBO5qbH;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D6360A2630
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 08:41:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E6D6360A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FNBO5qbH
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-385d8a00598so493613eec.1
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795164062; x=1795768862; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
        b=FNBO5qbHu5un6qZDgqdgOTovjvjk1B0NCyZz8G96RXegY/7Jj2TYhD9gbeXWx6gRjf
         4/xKNjdHAozARhc9/qHe3nYRcuTxe4wIX+31WM9TneaJranELlCDCBxpgQdvJZnSmZqD
         XH2l1Sl+Pw6UO2UPeO11gCUJ4Fu2lJqgg5GIf6KvAjuORAwP9CeCO0oNYh/EUqrSBnh2
         euFi6JLkmEwdd97PPb44xKzZ3pFZlHGR8ZtTml9T2kdAG4kRRu7DwiSrCBVaGHyqKJ+1
         fuqV1aisW32oPFAlAkbznbZ1Jx/DK6oq5ItzHOYTnkL/5XZJFVouy1gtaaQVy/oOFgAK
         xREQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795164062; x=1795768862;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qt1Ybyqn6dGdqD6Fu8N2/lYm0CmAcHxTPwGIdEQURII=;
        b=InNpCWVkeBiHOuF3UdCyZ+kveLFY24gPbYhoCO3wc3lYu4h9zKMpSgTTFvwuq+f0WY
         UDZnEv1v0hxPCgqJn7xorF3B+Xm9oqXyi32XN+XqLQJw53Gl5FQvgPgQaS2Z+bIFMyZp
         cY1J7jH5ELlySk5M8tsjH7Q2cqTKesUAWquyVckN+5RtN7ze0/w1DdvWw8/n40xppQtE
         hyPy1/43TrLsNVAm1AGIYOQi1Wuzx4AnqU8pMgGuMpXNACiPX1XPscm7MrBnzaAhGiiD
         fjbx6asHz/Ga498/Et6L+45kmtGu+WPjYU0LLZoUUuHYIqFwVl+F8ldYzP7fBgHK1Civ
         pb8g==
X-Forwarded-Encrypted: i=1; AL+hErFJvg8Cnr5mKRC1eZltJxDd0g7z3m+EK1kZFNMq5OQfW87iQAdgoYwDJc44HPv0o1HCnT4ytGM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ff+lJaHWeXmWnPVEodVOqJMopdqVVy97m3k3n7P50Ljk6Az5A
	0FxOjdO2jL+fxuiFhP0DHgvYqM7WT+N1ZjWDF8yQzkQ9dCZJ2RIrEv7y
X-Gm-Gg: AZFdTZdaCsrn6EpLQWTOlHNvdNBcXYo+0b0p7has4GPIzcGCOIlGhLNTxCKeWa1WmUe
	M8tUu+IkcFp5bnrW1SezHmlREY0/Xu86EEg3cf4satqnpuQRlEUAf6ODaSyO35LUS+8ORW58fRq
	kCz8qFp+9jhQDY0DxQrfFlOn61QQUYnD1kYoTSkdl+Ed2810c+fl9X2hysGd6IjI7V7GVSxhruv
	tiZDlzwZM4iNPIMbG60cLkTUvxr3LJfjRqkYhtm91c45cYGVfh7IOoE91PgS2rzMecJdKU7yxNL
	4bDimlROUjv7UHq/zG8DdXODLTBaNBeJyITZRNN7ALRzhJvixgR1jzsey08HP1XWznqOcVNXmch
	fN51a784e+nAKlc7MIaVf5sSgXomadUOfN8cR8Kym4Yb94IINJKCy00y310piQCYZNOOoJAUJiC
	kpPCbiPwMkkltaGAk426av7Bf1HNlwgg+JsL/r5OsW2o2lMXUUfvBYHHW3PbFWLFBo4v3A15meP
	2qviE7AwY7cXS3Dc4rv3Vy8R2mrTjPf7Uvg6oN9PUTix1Oo2g+82c69j53A93QSdWtjsUUoBQNx
	d+1T8pT9gX09/1dTXNog4K94nWOlmZmACDfyCkGN84sj8/quCj6YigGKy8kGbLihygPvagFldnW
	EB1tE9IZUAmEBP8iIfQ==
X-Received: by 2002:a05:7300:cf87:b0:386:565b:4f9b with SMTP id 5a478bee46e88-386565b529dmr81358eec.36.1795164062085;
        Fri, 20 Nov 2026 00:41:02 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:ea97:e47d:2ebc:210c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c371esm5793181eec.23.2026.11.20.00.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 00:41:01 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 20 Nov 2026 00:40:51 -0800
Subject: [PATCH v3 03/14] HID: logitech-hidpp: drain G920 FF workqueue
 before closing transport
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
Message-Id: <20261120-hid-logitech-hidpp-v3-3-cfe2caa1d0eb@gmail.com>
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

Probe no longer keeps the HID transport open indefinitely, so the
underlying USB interrupt IN endpoint only stays active while the HID
transport is held open. When the last input user closes the device
after input core flushes active effects, or when the device is
inhibited with commands still queued, releasing the HID transport
shuts down transport I/O unless another client holds it open. Queued
force-feedback commands then fail to receive their HID++ replies,
causing command timeouts and leaving stale slot mappings behind.

Override the input open and close callbacks once G920 force feedback is
initialized so the force-feedback send queue drains completely before
closing the HID transport.

Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Tested-by: Gideon Heinz <gideonheinz02@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index d9342a3e8122..d5f53b35ac6f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2815,6 +2815,22 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	kfree(data->effect_ids);
 }
 
+static int g920_input_open(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+
+	return hid_hw_open(hid);
+}
+
+static void g920_input_close(struct input_dev *dev)
+{
+	struct hid_device *hid = input_get_drvdata(dev);
+	struct hidpp_ff_private_data *data = dev->ff->private;
+
+	flush_workqueue(data->wq);
+	hid_hw_close(hid);
+}
+
 static int hidpp_ff_init(struct hidpp_device *hidpp,
 			 struct hidpp_ff_private_data *data)
 {
@@ -2897,6 +2913,9 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	ff->set_autocenter = hidpp_ff_set_autocenter;
 	ff->destroy = hidpp_ff_destroy;
 
+	dev->open = g920_input_open;
+	dev->close = g920_input_close;
+
 	/* Create sysfs interface */
 	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
 	if (error)

-- 
2.56.1.750.gf70dc682cf-goog

