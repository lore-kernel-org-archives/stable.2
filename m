Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794204678;
	b=3TREXcNIOQTXyo/bfthusbL7NFwN/ypyJhj4r2mRqxlvrPCZW1JFktce+0t/GvoOX80J
	 Pehu8+7e47lNnfRm7OI3r06SFveTDV1dmG0c4R9bF9dxvIwQJxYVaMUlak+4T+BuFVlb7
	 zXnKDQ+xPZ3sakpAMJyre2+to93SY87s+MN1kBRrphNyFpZeM8XujCIbA+vfgi1LZXKUC
	 F/y/Al+MbF2+m2VKsppbPNUUO6X42Tq16hR5uogEF6qgGEXUE1K6omFwBcf3nc+yl7WJh
	 iBP4Tnxq+IhJbHc8BZfB1P9cQnkELfGiuEwn0l+jDpptarEsqr3+lHR7poXTGuwuA0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794204678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
	b=ySZQKDWNSW+8f820dWRdVG3MniiwSSYyDIENAIf7A/rkkXRB/P+oa0g0qSPBW0el90AA
	 humuaalBsS9baHry3lbGcPSaR9pCt4gp5pRNtf3l3laxDKNuVa7XCmYxGzWLxGRayeg+p
	 KHIjG7bLgXDoyk4kVrJIDwX73O3d+/moCbaEVGJoo2DyiBei4co3yCVCX3clxLrEe4hvG
	 3L6HLiMTGuxLh/zQJJwRutx34yhk7+G74svMZyb+7vbbpreAMYXiIiL/xTkuGxf2pRLwo
	 basZleHOAr91SC5vp9EPL72FEzC79FiFqUEPVL8Kh5FjMZeVs6l9aSjOmjY1mbV6lPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="N/cIv6lV";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07937606D820
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 06:11:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07937606D820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N/cIv6lV
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3704d30b84fso639004eec.1
        for <stable@vger.kernel.org>; Sun, 08 Nov 2026 22:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794204672; x=1794809472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
        b=N/cIv6lV8NTkVBBSUycvVcrj7rND78t8AE/YqsYo9OzA1BJ91Kx6BTU4uJzZt9RUwe
         8fZ8kUzRGssO/FOseDzPt43d5H7XzWtIhH720k+ooYQHcQCPUOOytdFMfUThBb01wXKC
         jX8nFtWoMdW90I8yXPcWVSopiLvkeglrIuH2AUnGZpndpQruDTVKYqL6aXJnCZ+rgzs1
         9RVnMCEgIG69vnjXPkoie2QaDGHm3P/U4cKvD+rTuv7ZykvSWx6nK5RB09Og1n23NwuK
         oCn5V688CYorifP/d4IymWPHOLsBkzh2WEwO9csFIj96qmlipgvwlUaSwYbFm6wFhUDX
         BkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794204672; x=1794809472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TomoyXuW3KzDnQ4RGzocEg0P8W0o7cjVqZCap0ep/+M=;
        b=aIbAK7O6sJfNGabGNWvzpYlJMoDT+erLsb8TuZfGksXRgpZ2FtmIf1JCfu461aKQ1F
         +LgazNhTOvaUauwJVgXql31b1tNnNdzrKdaiaLcV/29qHlLvf3nb11aX/hSxOxqpJPkn
         b9JFcVtgza0CF0nwAW7KKaf/71SObTLNHa6cncK/I5tnj8sFuD24wCkLK0aOd1A777ut
         SR53gutZ+b/oYpuVouDrUVWU9nyg1kp9xPMH6eeuSnYT/oYalijwKYsq/OO7hOCdlxgu
         hbr7Jd3+NHFtCixUgvDj1dAgCpE2B0MFeYSLgjK+czeDuFbIGc/irzZ+NNhRr8CE8WI4
         qWXg==
X-Forwarded-Encrypted: i=1; AL+hErFFzrPLYcHmfrv43QZGVea0StHJ79nAAR0TQGnIq969G+L5e5TnXdSVJdcIy8W/Tk8xLhlY450=@vger.kernel.org
X-Gm-Message-State: APuU4Z8wvWk1w849io06qnNfWdtdB6VXq/fRv9Q4FpOI6uhoxv9Qno44
	UkP9ur8XFDtuLP0vB/vx8IvG3Ujfo58A8Vp/HRFEX7LP431lCoiQB/o8
X-Gm-Gg: AYBFou3vpWa/gwb9RPl1AovkmmQEGVq6CX/sMAKZjGc8rO3+j4vKDweVxVihje5VYtJ
	8X7KMyWLSsKaYAGvsxGsfTRvNX2ppcfWJ5NQ4D0cbiEv4l0LIqcF5OSWwZB/iAYkQJ8LL9+H32o
	dzwID5yL9PtJl25g1oDWJiY60EAfHHanJ7e8quRke+2UbeTn5fVbHLh0wor5+nneSuXCkpJn/ZY
	xKXim2eHvsR2hViTK7oGixHSCE5TSvAq3+ObrLoEt44oM8yRs3Pt8mtvlwXYjcm/SCdPGiYons5
	JAtwIIbJWlUVfbje3bSNJT/GISgYumIw6BFyVOtyGWcpcXhlyX+HP/rphu1gqwVrjZQpAIkXsk5
	CRfK9sPjKqScuTwlZZf+8IjVIR5/ugViBTWhxcABcL9AtjCv7Q0weh86fwM4+9ADbkdxoSA9ytp
	UyhA5fKTXZjheOUiShWGrAzRnwtH1X0lhIPuAFzxlDiCa/yXLKai2TiZFrcWiSAuu6cag46bbxe
	f0hqc2NUdVz/X2t2ScT5hvxbzKYjYdL4RvHDhmiP3xyo/vBdNerB/V8HeaC5bEu7UNhJ4goY7Wb
	1c0J2bt3mRWRgH387LjJOihyzavNfpPAPTbnGz7kbwlLog8NEmvu30JXzOTbkoUpqi/ziJk/LkZ
	0qrlu//7htH0DmJF7
X-Received: by 2002:a05:693c:415a:10b0:36c:9af3:2309 with SMTP id 5a478bee46e88-3725827055emr6050311eec.0.1794204672142;
        Sun, 08 Nov 2026 22:11:12 -0800 (PST)
Received: from dtor-ws.sjc.corp.google.com ([2a00:79e0:2ebe:8:3588:b56:78bf:db5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-372661ede11sm12201192eec.21.2026.11.08.22.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 22:11:11 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Gideon Heinz <gideonheinz02@gmail.com>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	Bastien Nocera <hadess@hadess.net>,
	Hans de Goede <hansg@kernel.org>,
	Edwin Velds <e.velds@gmail.com>,
	Stuart Hayhurst <stuart.a.hayhurst@gmail.com>,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/18] HID: logitech-hidpp: drain G920 FF workqueue before closing transport
Date: Sun,  8 Nov 2026 22:10:47 -0800
Message-ID: <20261109061103.2887636-4-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.56.0.506.g506a7eabc5-goog
In-Reply-To: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
References: <20261109061103.2887636-1-dmitry.torokhov@gmail.com>
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

Probe no longer keeps the HID transport open indefinitely, so the
underlying USB interrupt IN endpoint only stays active while the HID
transport is held open. When the last input user closes the device
after input core flushes active effects, or when the device is
inhibited with commands still queued, releasing the HID transport
shuts down transport I/O unless another client holds it open. Queued
force-feedback commands then fail to receive their HID++ replies,
causing command timeouts and leaving stale slot mappings behind.

Override the input close callback once G920 force feedback is
initialized so the force-feedback send queue drains completely before
closing the HID transport.

Fixes: 91cf9a98ae41 ("HID: logitech-hidpp: make .probe usbhid capable")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 40ebab5241b7..476c0f0eb086 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2815,6 +2815,15 @@ static void hidpp_ff_destroy(struct ff_device *ff)
 	kfree(data->effect_ids);
 }
 
+static void hidpp_ff_close(struct input_dev *dev)
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
@@ -2897,6 +2906,8 @@ static int hidpp_ff_init(struct hidpp_device *hidpp,
 	ff->set_autocenter = hidpp_ff_set_autocenter;
 	ff->destroy = hidpp_ff_destroy;
 
+	dev->close = hidpp_ff_close;
+
 	/* Create sysfs interface */
 	error = device_create_file(&(hidpp->hid_dev->dev), &dev_attr_range);
 	if (error)
-- 
2.56.0.506.g506a7eabc5-goog

