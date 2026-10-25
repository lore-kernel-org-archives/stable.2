Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792952985;
	b=g/i5EdGtUi7jDi8ipZZRsJup7hUVRRqB1LpcgnKe/ZgBuXNGJSVfezjaPbkH3VrBnwfL
	 IcjlaVhoaBPVhQbUREZzSdOoVbplfTOpgvkkIAKPZUfLDCH/EDrQWNAHnxhNhjsZHFhpL
	 h6+20+k+JZSQVHzLYOeWlKuIDCHYGoT+NXvPQtDlFQ+Wno95zVmWXLOCv9k2Y8BDVrKAx
	 LuaBjh6jMAOQi+4ed8AEYaAHQlkQeWPaEj2euEFV+qOd30WoQYPTR9wD5rWEGTCdAkBkv
	 ZgsqAz41kvNs3BSZ0hLTnGZSu3JEAFpGwYSlgsH8nEPOEr51PFD64qkwwTJFh5T9p9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792952985;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=0ViJzLMdjNwSjsUaA4gnJdS3+jHjilI1Xx8EQmtZsBo=;
	b=4MMmRvgz+76RQSM6/fbcg3IgfNG8Q79Y3EAP/dqJ8mszbJ6jYKsYVhT1pdpxlvxg2pec
	 um0J63dkktCznZJali8+zb74yzxNQ5hogy/HVtI/VIADmDltVWyrhvOkfiYRhPShZhxkF
	 0QL3ftnLifKDtRJKwXf5jNqAeb0chEqqH8XrkX3LTvbDPBgFzSGEoHS9HnqCjiVI/4Ga6
	 23bgUfUmurlQNBlcpKNjElAbiRkA2j9qSz7TAskYALcLFUReiCikm+aVqCYVfphk08J5G
	 s0c1Pp8owJUoAXLThV36aQA0Irlie37kQ9U4d30FRehfAomfDN0pcCRMgPFDhxZtyvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icSy9Y9Y;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F010606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 18:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F010606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=icSy9Y9Y
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so2389818f8f.0
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 11:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792952984; x=1793557784; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0ViJzLMdjNwSjsUaA4gnJdS3+jHjilI1Xx8EQmtZsBo=;
        b=icSy9Y9YJ04aGQdKdAOrjwcthPXedZz8fp5YPu4eDeg7MeYZGdW5Jmq1rLomS7e3P5
         LGVtFtjkrwWrHkmEZAkNUSw8oas7Wf1OtIjYbqyJpoHHrxZ1cOmALIrwVKT0/bqAu4HV
         YsVe8DP7CWvFzQEo3+5RazKTsniwxYD0GTWzmDytlWc8nrflINzmNP/E6NirbuSFOrQH
         7882gkXQYmFw5Ao5FhVlm8CjXUW3JSF0o4LfntlvnPkMX4uxzrc+i1eNr6pep7mtTOMn
         96IPUvk5+QZgmHa2VA4wy3nY8/LzEkwKkvcFsLgnIhiArEkYhAmnrvBk+zzrCV7Grobz
         5oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792952984; x=1793557784;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0ViJzLMdjNwSjsUaA4gnJdS3+jHjilI1Xx8EQmtZsBo=;
        b=HVR854J6UdpC5GsPq0jqy/4dIKXNKN1DqhMLbgTmSQHiElDppDg3hFzpOF3qEAxuXy
         0Rox8X2GiezYH4yFBl47nWOGKrV+AAeiomPE/V9nokxsnj9W5bVZE6af0TWNobfj9hZJ
         OMmqGsNokliGG3QX/CxNnSVTBBunSOLD2syEwZvMnHikSonwWMYEFj8Yl1Zj6XBZX+ma
         lOrHBc8SBQN1hZM2UaLPh80Ayra7EmXiojfvouKopihEobXs7K+hMN4EVP1ve6K0SOec
         XpFpwk9FI6azIN3uAeYBEqDeRUgR05TMNUyDzfC8ND6XArelHld0Z3Ae+iScRAOHe2Uk
         JnYQ==
X-Forwarded-Encrypted: i=1; AKwUvByrT5TQfaUZV+/26pYTu6KznoYonIxJoNVG0blAKw/reDHaYf4QBIwGrsqvMDOl9v/T2xK/qz4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRXAzPGrN1csvALGNjaFiwzvegwV/GgH0q1MQoiuAGg6A0rdoc
	BoXVTSl2woFlmEcLBsFanGEWdZ87444fYAI2FKUwisY2ik94jpgErZ9b
X-Gm-Gg: AYBFou0pJ/XbhXNKcbnJtptbLY5yx01jxpQxensk/TsXXrmfr5PNlglM15EM4qBIOEt
	T0oZhVKqjeZFNn0A27pK1Qjoo/Sb0ZR9zWhnl1X3PJ7HaEe7X6KgUGuMecATFAsjdFpwJQbAk0J
	1rWohgmdZBeP8q/4fKDQVUa5RcYq2UaBYuV0lPHzvvfFyjjIDzRWk5bt8MbsjPdomks+ebVFMih
	pOXyJ0ey7IyqFa1GkEBn0yadsQSAqd20mvLAgHp6Ef3ljLePbUgC+dCUtRf8BA67NvnOkiYhDra
	3m3PmwCL/L9fx6AsD5l98c8mM5i7W4GGiEd4BZM1FEDjtvYKMmPmSLDWZFDg/A9pGXt8twwbPuh
	xaRNH/B4ZAotxE//52LeYl2b7rpg7m0EYBQkrF362JNVrICKfGKTc95UvnyqQ2i4Pi2sKwxw3s7
	fH8qEjg/He8F7mAZhZvyywNNIyYy+vAeDrtdEcYqeilFWhB4cJfoempNYQB52BnczDP1YxJpiGt
	ZUV82MgNJO24GmkWUFuYlo19nhBRNw3C8VyZRzG9tPQiqNC0nCt2Q==
X-Received: by 2002:a05:600c:3e14:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a35ae8806amr89044655e9.8.1792952983503;
        Sun, 25 Oct 2026 11:29:43 -0700 (PDT)
Received: from [127.0.1.1] ([85.105.252.11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a2e8f25sm138255175e9.14.2026.10.25.11.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 11:29:43 -0700 (PDT)
From: Bartu Alev <bartualev@gmail.com>
Subject: [PATCH 0/2] platform/x86: asus-wmi: fix and unify keyboard
 brightness key handling
Date: Sun, 25 Oct 2026 21:29:35 +0300
Message-Id: <20261025-b4-asus-kbd-fixes-v1-0-fa4dcf7d2a69@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4auEWXcgSatpexXpwiRTnRZUMipC8
 O6Ndvnx+F8GocQk8FQZEq0sPA4F5qIg9O3QEXIsBqttbbSt0N+wlUXw6yO+eSPBOji6uruuHs5
 D6aZE51Cy5vW3LP5DYT6OYN9/8CK9MXUAAAA=
X-Change-ID: 20261025-b4-asus-kbd-fixes-6c7e3780597b
To: Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Antheas Kapenekakis <lkml@antheas.dev>, 
 Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <benato.denis96@gmail.com>, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartu Alev <bartualev@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The WMI hotkey path and the HID event path in asus-wmi step the
keyboard backlight with two separate copies of the same arithmetic, and
the two copies disagree. The WMI copy stores the new level without
clamping it, so holding brightness-down at zero drives the cached level
one step below zero per keypress, the "value >= 0" apply check then
drops every following transition, and the hardware-changed notification
hands the wrapped negative to userspace as 4294967294+. Pressing
brightness-up at maximum reports 4, above max_brightness.

The first patch fixes the bounds on its own, so stable trees can pick
it up without the rest of the series. The second patch removes the
duplication: both paths now step through one shared helper that reads,
computes, and writes the level inside a single hold of asus_ref.lock.

With the series applied the level stays
within [0, ASUS_EV_MAX_BRIGHTNESS] on every transition and userspace
sees no wrapped or out-of-range values.

Signed-off-by: Bartu Alev <bartualev@gmail.com>
---
Bartu Alev (2):
      platform/x86: asus-wmi: clamp keyboard brightness hotkey updates
      platform/x86: asus-wmi: unify WMI and HID keyboard brightness stepping

 drivers/platform/x86/asus-wmi.c | 79 +++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 39 deletions(-)
---
base-commit: 9d3475065167197742b0882aff21cf8e78393277
change-id: 20261025-b4-asus-kbd-fixes-6c7e3780597b

Best regards,
--  
Bartu Alev <bartualev@gmail.com>

