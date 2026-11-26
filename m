Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703801;
	b=sNU62YO02fv/1h/VmnNKjIbPpPjaCwI3oydaEzsbikcPY6yj46IaAoF23CxTjNEjRFbZ
	 Dns8Di0/stRQpAxEDpSL1FgjtsGo4mq3tXo39WsMDpkHk4ZdVW+y8Rua64drfGvEjq6yM
	 sKzlNHytDgr0MM6mdPWZYNDgGjcwWOTSvTCnntYV/aU7tQPVZ9BcUM2ZSmdgPgROQduhx
	 4R/Gp5De4AfVBO+loXY+gcjH8TcmveFrSQp+XhmMMUYTuLGJDhooFEhgMCSk4BrOKsvZp
	 HgiJQVhVNjuqarKicPyPfJwaMuzsnZ1VqFD30aHRka6+aXNS2Hky5WM/Y7ga6RKkX+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703801;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
	b=2/tOBO9vy3kEIMNBcmh9DDxXlMkm4IBCp6mA1zP24kLA2BtiODKFXwP+yUAx26NUOP0N
	 XjNd+rJdJulV9M7xGph9UGLBEjrwPpj04BARNqjIV7s9R7ljK1A2v4ESZ8YK1jTpw0n7s
	 6a/b65PRCl5zkkk3ONNdgwarjbCD+vik71QqFxORgYuifI0W35ydHwT23XMHGVyndUDxk
	 /XaomPCxHs0/Gl76lG33mtsa21bx+WN8hKGAktnRVr7x6IPNEielKK0H17vzwqR5aooRN
	 Q1DWapyculgZfDOSEh3hIupaHwjVCBhFMDia9zPG00HThTP14BsQKca6DM4+mkNaFoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJEFTgK2;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DB3606A326
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 14:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2DB3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=LJEFTgK2
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c1a947b4adso5973219e87.2
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 06:36:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795703799; x=1796308599; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
        b=LJEFTgK2y+bSpXry0PbbjVe1EY/gQIxL0YjKFkbtnmSeP2S3iAFI4cpcJpA0QfgVf2
         t1p7/r5jtP5ruD7Zaniry3wA6I29YfBMO67y/KyyN1YFvJHJrUNO5NowSSA4mm3hKTAm
         jsDENlFJr0+j8Ohz8rimlhi1RnEn3SNcnGzDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795703799; x=1796308599;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wZ2A4qfQpgB1E9Hmrqw85vL60jFNYPf3t/HcdS6s4Lc=;
        b=1qnJ0SNmt81rBXuz3ave07pQxMoGxqL7biWj+wItoSU9JWdlwctMmZpbIGCnUB52Sz
         GPt8QcH2F5QG6y54RzDu+9l6U3VZFjXy+7lxe7AC/UQmV9MJYZ1G6YMtYDy1vD0CYvJX
         xspFvPID+S5ySRvMHy3KnbCN/4Vpxvj83aEH/dH0qtoCWN4MZ14PGxS1PsOfas/WYv58
         ZsbLbwc8+NNoFs7WPbae95xfxeNrsnFeHjIuz5EA/NoEcD2U2W8BP6u8C6pj6Ha45mVj
         YuFqLQ8koj+ljNluhjv4pzvc57OwQRE/jAUAxR4759PiuO0SBlxie6ehdn90NYeIDpHj
         WLRw==
X-Forwarded-Encrypted: i=1; AL+hErG8BSoy09dsvzO5VRDL/qZUXpNnRqLeFOMILhXBVfYYfyozitVvAVSugMom9+fdtXCPGp4/nqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z88f0katTnSB8/N1HIIK586SuwBFR0k4taP7wPGeToCHqHbV31B
	FtXtbazO6aOO0YCBm5MJvkYrWzcPCX18vzPzzrc9Z7S13AfBXTk/vdPiXd6OEG0D+A==
X-Gm-Gg: AZFdTZdl0mqKYN9N9U1zA55Q6dOae7EkoKIBss4efhMta+m65vWrfUvFCBPd3LjQa5R
	BseB2rtbvJQ62KTpD+2Jy7tsb1lNm9qxMg16FlTJcTM7iyIz1DCt/vKBJ4H1W5AyI2mPT1I5wyP
	8TGfzV6ds5cUqyxAj5YLgkuKNo408TgVHq4BwIgitp9FtwIIkKIDMt3S4QwQ1AbA/E+6Ebbj+dX
	IEg/B4J6XSRVzesnZGEH82G16ylykrbPg+OJGs72qa6R0UtkD430XT9700Pd2E8WIstmkNMKMMx
	QkeQEHHLucdgK0X9kRs/ftigP9xiads0KAEPDuykiEfaF1pNQBByDA6m5m5X7Xj+hhniD4tV7Mi
	hmc1jeWkqgbh4Xz5VooGQbRIys/oXneZYCKkMmCCNlH7h8P8gGBBiDiKOVyXCEGsYQLPGgtFTMG
	6ko8Khvn6ejPN/lYuVA4IP1B8zLHD+/1Mcyv7czX2RX40BhyrgsRJw6t/C4D/poltqDyV3IyZfi
	kEtjHAmRQDhPQReeYMt3pzc6Pkk5OTW5Xo5J93VTvKLmsWnHjNx89/ro/nqIwd/Qcdjuvroo8HV
	3Z6fNUbp2/RBDJlYsJug8uS6LpW/cTAEOfhVREv969HNF54Wnk+f02u0F6rW1K8ETjdaGPZ5KuJ
	8xXUiB27QcjGoVojxmloFNDF715/de2Y=
X-Received: by 2002:a05:6512:3b21:b0:5c1:5746:9c3a with SMTP id 2adb3069b0e04-5c1bc8f3c5emr6643497e87.62.1795703798763;
        Thu, 26 Nov 2026 06:36:38 -0800 (PST)
Received: from ribalda.c.googlers.com (214.118.88.34.bc.googleusercontent.com. [34.88.118.214])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0563casm5231653e87.67.2026.11.26.06.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 06:36:38 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 26 Nov 2026 14:36:35 +0000
Subject: [PATCH v2] HID: Merge duplicated documentation for Lenovo Legion
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
Message-Id: <20261126-lenovo-go-v2-1-99db2904513e@chromium.org>
X-B4-Tracking: v=1; b=H4sIAPNDCGsC/23MQQ6CMBCF4auQWVvTVsDiynsYFlKGdhJhSKuNh
 vTuVtYu/5eXb4OIgTDCpdogYKJIvJTQhwqsvy8OBY2lQUvdSnNS4oELJxaOxXmo0dbDJO3YQPm
 vASd679atL+0pPjl8djqp3/pPSUoogV2jWzQGUXZX6wPP9JqPHBz0OecvWQpfj6UAAAA=
X-Change-ID: 20260831-lenovo-go-7b4ec4bf0cd5
To: "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Jiri Kosina <jikos@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.3

Lenovo Legion Go and Lenovo Legion Go S share some definitions. Merge them in
sysfs-driver-hid-lenovo-go to avoid this warning:

WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:364; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:234
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:373; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:243
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:636; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:252
[WARNING] /sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index is defined 2 times: ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go:645; ./Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s:261

Cc: stable@vger.kernel.org
Fixes: 168c91839139 ("HID: Add documentation for Lenovo Legion Go drivers")
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Revert unrelated "built in" -> "built-in" typo change in os_mode description (Mark Pearson)
- Pick up Reviewed-by from Mark Pearson
- Add Jonathan Corbet and linux-doc@vger.kernel.org to Cc (Mark Pearson)
- Link to v1: https://lore.kernel.org/r/20260831-lenovo-go-v1-1-e9526e88ee09@chromium.org
---
 .../ABI/testing/sysfs-driver-hid-lenovo-go         |  9 +++---
 .../ABI/testing/sysfs-driver-hid-lenovo-go-s       | 35 ----------------------
 2 files changed, 5 insertions(+), 39 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
index c8221373ef76..07f3ea054383 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go
@@ -365,10 +365,11 @@ What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-
 Date:		April 2026
 Contact:	linux-input@vger.kernel.org
 Description:	This controls the behavior of built in chord combinations.
+		For the Legion Go S, this controls the touchpad's operating mode.
 
 		Values are windows or linux.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
 Date:		April 2026
@@ -377,7 +378,7 @@ Description:	This displays the available options for the os_mode attribute.
 
 		Values are windows or linux.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/product_version
 Date:		April 2026
@@ -640,7 +641,7 @@ Description:	This controls enabling or disabling the touchpad.
 
 		Values are true, false.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
 Date:		April 2026
@@ -649,7 +650,7 @@ Description:	This displays the available options for the touchpad/enabled attrib
 
 		Values are true, false.
 
-		Applies to Lenovo Legion Go and Go 2 line of handheld devices.
+		Applies to Lenovo Legion Go, Go 2, and Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/vibration_enabled
 Date:		April 2026
diff --git a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
index 4d317074bb7e..218164cfe544 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
+++ b/Documentation/ABI/testing/sysfs-driver-hid-lenovo-go-s
@@ -231,41 +231,6 @@ Description:	This displays the available options for the mouse/step attribute.
 
 		Applies to Lenovo Legion Go S line of handheld devices.
 
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This controls which value is used for the touchpads operating mode.
-
-		Values are windows or linux.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/os_mode_index
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This displays the available options for the os_mode attribute.
-
-		Values are windows or linux.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This controls enabling or disabling the built-in touchpad.
-
-		Values are true or false.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
-
-What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/enabled_index
-Date:		April 2026
-Contact:	linux-input@vger.kernel.org
-Description:	This displays the available options for the touchpad/enabled attribute.
-
-		Values are true or false.
-
-		Applies to Lenovo Legion Go S line of handheld devices.
 
 What:		/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface num>/<hid-bus>:<vendor-id>:<product-id>.<num>/touchpad/linux_mode
 Date:		April 2026

---
base-commit: 25faec9ce61c01fb45abf812a222c5b43c3cd5c5
change-id: 20260831-lenovo-go-7b4ec4bf0cd5

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>

