Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795415878;
	b=K1tCiejWiqGschZFNeRuRy3Bozh1DJBiIKzpoc+hv2ihZuCSYOhvI6hvHEE2jW7F93J+
	 sCxK5htLe4VAICWEMZGo6U15fat3AVjfBqS1x+dejHsrZHFqebhqi+dBlyiy36Vt5dbip
	 fxPYx99VRsJ9ITAL2RQ6ppbCFBnrZjE+X7P/XDaZffVJivc2Z5513yaOrX3DkGCQ89Cd7
	 sqH193qAOIbjOPXCc84ltHBad1PP3iqBBbahRXRAQ2OYFYHBx7puI4OT5URqrbBqmOKm5
	 b0FCgY71d0ABH2Vkcmtnfj263qQ0HUtL3HOD2Ql6C8DiIjBraY1gV/cTwlMTKIlWvmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795415878;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=afbt2rmomwUI+307ATY0ZNant7Tutup0OxSCpoe3UL8=;
	b=bRDH1rFw8iXvBQmJroxUYtXO8Cazg0L63OJ4K138wCFbs5wNM6p0c+U7JaCcaXS+ZcHb
	 yGGRNWbK7oTS28dkyY+CLE3CYjC7T1FpqZXROPZOxQrJLu0RoSryHTxzTWbTcBqCTva5f
	 BGcIEmoT/EnqryAEz1K93JqWlBhjsPrTATEzc9h06nMSgwRsyCRlXQHd9s+MRg6I6QOkz
	 QlD1GYB1L6Zphs3ZTCqUqEI6ZPHw0lvx+YIyQYR62GDoqLgA9WSD6I1otas318dZX9/0W
	 Vm+snGwyzxR9Amq0UZamb9d6U4AlwoQoPyDb3u9xuL7GG5zUDWLYjR2ge5oeBP1EN9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HF8ETJgy;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423E606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 06:37:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6423E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HF8ETJgy
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1b3beeaf6f9so3549701c88.0
        for <stable@vger.kernel.org>; Sun, 22 Nov 2026 22:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795415877; x=1796020677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=afbt2rmomwUI+307ATY0ZNant7Tutup0OxSCpoe3UL8=;
        b=HF8ETJgy3K3P7rv90VlZFwWi6J86eea2v2fnG0piKVB5kjIpj0a0AQ9G7cHH7YngGz
         KXfKEwtvjrnuQZtt/HZ54IUDoUm0nwhMjsgTAn8+A7vUYiARe/zVs0WCd2Cb4JAb9k2T
         k8fgvsLynXsXqE2U/hGr5zmeZHCRiuHHDIPJPEOQh4D7Fus3hMMwWdKx8mOUqvuquXFI
         iP8TvCgSp+qnE00Vx/he9GuRfMQYyzGxumdM0f+DWb3gilrBstStbjI0qyMZHq4wsm26
         HGvDecJuiGSpyMatqkkTWh2l4vN5DBG3rPGGlQB3nxr3P7+4+7kUKgqAAuBLLny2pJoi
         xJYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795415877; x=1796020677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afbt2rmomwUI+307ATY0ZNant7Tutup0OxSCpoe3UL8=;
        b=UYtlVhDiM1wpZOPkFftAVl+IwI4bzXzYeZ8ujYbBHIDYzokWtjXjXWq3c4HkrCYU8z
         47rCDI/2+xuGC0O0nyCK5yrauQ8KFnpjnwvc4hRhyaWyZsRbhXsVjpmtdEXw0FG9PEXT
         JrVsh55ugYdXiwdoGP7qqmo0rzaQYEWwmkk15Bs0DjFu9aAZ/8aq+QGER/B3W3vII/qU
         VZz2L1ExeDCCTKZnkgu2V0R/SFoe51eRov8ApnhO2CRcZ/MVMNFPkaQYGst0NKAmpqOy
         cWkee2ue18+R29VMEOIfH16XrvimT/0m1RzLytKBSiPMlIR38YTBqBJVZDZ73N6SfFJq
         nuAA==
X-Forwarded-Encrypted: i=1; AL+hErF1NrVUgzfNkiVltoZEzKsTOOYUIJqu03qwamalO3a9w3THgWZMS7jWOQGyz6ISvu2J+j868rI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8nyZTZMmHWojrqt/QdDmB2PZ8+0hm9xUHgQ7v5sDLsZyDUhei
	+PDcNXisIR6Zuv1ZtNap1j4501nUF8kW3kZCr+SH0VSiyTJZV1Ye07YhWJE6S9Ty
X-Gm-Gg: AZFdTZcdXy7uY/xHDygYRtwy7MC5b2So94/4YTu0GiOZzGbTe7wNz8a9jty20k7hl1K
	8GhN5G1RQnIxUPQUA9uYJ/dcFJgBDPoxe6U+gglGw02Pj0hZbfvMFdDf5iNM4XYoM0NE1mq+4U/
	BUCitxP85utPZd7EBCrRabsGFSfK8Fu0HvrYLJ49FW+C5prxZcy7F+ea7C2EPcp8sDU8N7annU1
	F7vAV1Hk6wmZBVZsAhLzKnMa0d8CZkRkzZLrDDVIRJVtWkwa7mDaaVAp/rZ0saLxdZqhggS5Gd/
	oFY0E1laJrqGmKFRPQn6WWfxqAscd2yUlKYIybz9Eoj3LSMetFecXF8Hl9IR7Hc8Vy85H9F32kt
	60O6WRS1dgd3nwHmpYgeXaD/UOWFlcnM/Xm33wOYWFqhYa4izcsEvL3oB8o5j5hZvpz6RUlsWWc
	3X+4LpXgYR9M/s4rq+DXoTiOmHuLm65M/5BeKLQbhNOb+i6W367QIF+Qa4nW66cyIQw+oDJuG8N
	Q9MCF888sKzcEw+KGUKtdzJqqyYTPMoiXYf8HPkC8WZzOwF6aV0bpmmONee3DV+u3O3w7onsIed
	npFnC3oWjyNH6tR/VqPETTN7eimAMtfCbrmwH5DtRBMb0ePuhbxAlBnjHCLPZKyhvWA68rYCMd6
	irZJe8TJII4DTzsEWDeWyWHY992YB0vuLszsWS/WGMGa5
X-Received: by 2002:a05:7022:f106:b0:1b3:afa2:2d7e with SMTP id a92af1059eb24-1b5567dab3cmr9096340c88.1.1795415877349;
        Sun, 22 Nov 2026 22:37:57 -0800 (PST)
Received: from acemagic-m1.tail4fb79.ts.net ([2401:7400:c804:b668:a7dc:f03c:3f60:caaf])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm35934568c88.14.2026.11.22.22.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 22:37:57 -0800 (PST)
From: Ho Jie Feng <hjf3108@gmail.com>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>
Cc: Ho Jie Feng <hjf3108@gmail.com>,
	stable@vger.kernel.org,
	Ho Jie Feng <hj3108@gmail.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb-usb: do not clear the raw IR change_protocol
Date: Mon, 23 Nov 2026 14:37:31 +0800
Message-ID: <20261123063732.1615570-1-hjf3108@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Since commit ec7cb49871e5 ("media: rc: Fix race condition during
rc_register_device()"), rc_allocate_device() prepares raw IR handling,
which sets dev->change_protocol for RC_DRIVER_IR_RAW devices.

dvb-usb and dvb-usb-v2 then overwrite dev->change_protocol with the
callback from the device properties, which is NULL for raw IR devices
such as rtl28xxu. Without it, rc-core enables no protocol decoder
when the device is registered, so keys are no longer decoded.

Only set change_protocol when the device provides one.

Tested with a rtl28xxu device.

Fixes: ec7cb49871e5 ("media: rc: Fix race condition during rc_register_device()")
Cc: stable@vger.kernel.org
Signed-off-by: Ho Jie Feng <hj3108@gmail.com>
---
 drivers/media/usb/dvb-usb-v2/dvb_usb_core.c | 3 ++-
 drivers/media/usb/dvb-usb/dvb-usb-remote.c  | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
index bd86d25043..218397cc68 100644
--- a/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
+++ b/drivers/media/usb/dvb-usb-v2/dvb_usb_core.c
@@ -149,7 +149,8 @@ static int dvb_usbv2_remote_init(struct dvb_usb_device *d)
 	dev->driver_name = d->props->driver_name;
 	dev->map_name = d->rc.map_name;
 	dev->allowed_protocols = d->rc.allowed_protos;
-	dev->change_protocol = d->rc.change_protocol;
+	if (d->rc.change_protocol)
+		dev->change_protocol = d->rc.change_protocol;
 	dev->timeout = d->rc.timeout;
 	dev->priv = d;
 
diff --git a/drivers/media/usb/dvb-usb/dvb-usb-remote.c b/drivers/media/usb/dvb-usb/dvb-usb-remote.c
index 6dc11718df..f5f30d714e 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-remote.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-remote.c
@@ -277,7 +277,8 @@ static int rc_core_dvb_usb_remote_init(struct dvb_usb_device *d)
 
 	dev->driver_name = d->props.rc.core.module_name;
 	dev->map_name = d->props.rc.core.rc_codes;
-	dev->change_protocol = d->props.rc.core.change_protocol;
+	if (d->props.rc.core.change_protocol)
+		dev->change_protocol = d->props.rc.core.change_protocol;
 	dev->allowed_protocols = d->props.rc.core.allowed_protos;
 	usb_to_input_id(d->udev, &dev->input_id);
 	dev->device_name = d->desc->name;

base-commit: b7ac871daee981f1963f632586ff9b9d898ce5dd
-- 
2.53.0

