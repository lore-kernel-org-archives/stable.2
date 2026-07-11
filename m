Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C5B352C4F
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783791418; cv=none; b=hoo+MPE1oIDyvBsxhds0oz9r/vvn2dZVtLq4ogWSxLUwULvRqVNe7KX9sYv6MECyVh++0ikSZBKX3rs37yqMn3hPkfrAyH7L3m3+wnQJc0HCGCXqKCGa40zG2s9QQDUJXTdFY06++dWOELYBWrjEnp/Ks69KS5bKHuzno03UM+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783791418; c=relaxed/simple;
	bh=jbfHrlAjkv5OnUm/u91dXhvA8JlKqFlHyF3b08FCsHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WZ/pXc85kc3ZQ9WQtV1sMqQzeZUDAZs1nvU+GpqDE6ZRBLnmkkJAms1R5/YOq8IhM3+elziGDP1VIwi0hTbxwkjau+x/hQJF/oq1VSM3o0P7GIaHLhPdyHk/ZV7MX/a4d606PLoL/9NbCWryd7DepiPWFfYdpyJ1cPZhHqYgORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pxWixwJb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pxWixwJb"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15c42a45adso422485066b.0
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783791416; x=1784396216; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wca6Q2ByJhx9cqNK7zsckufMd/P/6VmwN01iQ4whYvk=;
        b=pxWixwJb8qAClZbcu9RUph+iwIFqRFJSTP9eH7nvOPsT9ulzOQJ+6J9OM8JbBZnNWs
         9oFQuuuH/qBlWR6KCCB5IXtFNS62RwGG6851YqLj+aNgGKAaT7XV9+raGwO08JaLwba2
         mT9vzIbd7IdDyQ/ZbeL96PZBMsjKjfd3uu2xwSBvtIcmTtJjdeTU58qF2Hcr81vQl0I5
         fEhDpUpLRODFSZv5mm64zbBaNsPDw/BBkb2c1mXrZdxGo92TCm4EKSEndTL/Fkjl+a4G
         mWvZ3ryqfIg0aydKw01hCxvUkQl52RTuPE06enXRjVq0/UWkOIfh+clCTfrX9cWycHb+
         7U8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783791416; x=1784396216;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=wca6Q2ByJhx9cqNK7zsckufMd/P/6VmwN01iQ4whYvk=;
        b=V3JgLGpnb68rOWhfwHiwbQvBASUaMrlsvc6hMByeV2bsINFOTiWMAzybBVizUgNj8G
         wzfx94oXM9PTg/e8hyz0jMEo9cdHxd2ELmro5FHiAIImJQ0eR5X2TuPjtNLGAb25ER8k
         O5IwhVV+Fmtysao+QC2L3q8GAYTjDCfUBpJbGoix4I03w278eS30rE6U7J3jUDpaUwlf
         tv0g6T7kCaVHDpZHIds+Vb2GTASWX5SlxX40HS/t8TcI0Zy86+8ZSquguQZoA2LnAIh3
         NG/cZ4FtcyAgjdk5QERwu3U/Ea2E7VepszoBkfnCCyE7Jv84XNFXHxo/WFlcTD5rkDQ2
         gmdA==
X-Forwarded-Encrypted: i=1; AHgh+Ro09ogLs5siIxT7gGeOx3o8MlL8bc3iDjHKNlR0T8w2U4x70Nh3jJk9JOd7Yk34/ZGZ03XqLqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkJOJcrbnv7zq4bw8tlXAidloWPc4+8dQtJUMaOsqUfajxnYdb
	V7JkxlePAak4SwINml3IGiJ/JFJ9/RM1Xa0VEwxuf+UOBmBi68g96RQ1
X-Gm-Gg: AfdE7cl+VO9ywxxuRgubIB2R8jThnDTnk2l/d66wVeYxRV5A+z9bdwGnQyr+fhq6Eds
	UBb+1+H9shypErAkZJYeFD14mo/h2E1amGRPZfnIHtX4fb0SunpUpWWWhjmhm18somEnR0F1g5S
	yvqdoZVXZD4mR+pUyRJfC7cDYUT+r/jD8aV4zyVjoEgaNq6zMLrK9rRpDyXOaK4YiL0apTFXwpX
	BUAaGhshwGiETZoCzamRYRQVjDBPHhbQg5SsNVzq3hHo/M8XCEP9aQfjYfRpJdoL0AeziIf+BB5
	XQp4Gr0178+h/QOgEw8FtlCPqo6N9XcNg0773e3jOrpPucLzZCpeVTZ9WwHHZV8tuwsSplZHRV+
	qgpvhPZFycZVr4v+kPpIkQ1x/Wi/U1xwij72z/nepqrQwZ3N6rxS8iXXwk60F1UDmmzQYyPlFBw
	2e8s63jzxvNg==
X-Received: by 2002:a17:906:f59d:b0:c12:c15f:217c with SMTP id a640c23a62f3a-c15fe781f44mr354962466b.16.1783791415460;
        Sat, 11 Jul 2026 10:36:55 -0700 (PDT)
Received: from [127.0.0.1] ([4.180.183.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15f7137225sm294459566b.53.2026.07.11.10.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 10:36:53 -0700 (PDT)
From: Tim Pambor <timpambor@gmail.com>
Date: Sat, 11 Jul 2026 17:36:30 +0000
Subject: [PATCH] USB: serial: ftdi_sio: add support for E+H FXA291
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260711-fxa291-v1-1-cbd0b2652a9f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAB1/UmoC/yXMQQ5AMBCF4avIrDVpR5C6ilhUTRkLpEUk0rsrl
 l/yv3dDIM8UoMlu8HRy4HVJUHkGdjLLSIKHZECJlayVEu4yqJVAKrVE1K4qJKR48+T4+o7a7nc
 4+pns/q4hxgekcIIPagAAAA==
X-Change-ID: 20260711-fxa291-2e590229f630
To: Johan Hovold <johan@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tim Pambor <timpambor@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2

The Commubox FXA291 by Endress+Hauser AG is a USB serial converter
based on FT232B which is used to communicate with field devices.

It enumerates using the FTDI vendor ID and a custom PID.

usb 1-9: New USB device found, idVendor=0403, idProduct=e510, bcdDevice= 4.00
usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 1-9: Product: FXA291
usb 1-9: Manufacturer: Endress+Hauser
usb 1-9: SerialNumber: 00000000
ftdi_sio 1-9:1.0: FTDI USB Serial Device converter detected
usb 1-9: Detected FT232B
usb 1-9: FTDI USB Serial Device converter now attached to ttyUSB0

Signed-off-by: Tim Pambor <timpambor@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/usb/serial/ftdi_sio.c     | 2 ++
 drivers/usb/serial/ftdi_sio_ids.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 88dd32da82c2b..c6ffa23bcc8f7 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1072,6 +1072,8 @@ static const struct usb_device_id id_table_combined[] = {
 	{ USB_DEVICE_INTERFACE_NUMBER(ALTERA_VID, ALTERA_UB3_602E_PID, 3) },
 	/* Abacus Electrics */
 	{ USB_DEVICE(FTDI_VID, ABACUS_OPTICAL_PROBE_PID) },
+	/* Endress+Hauser AG devices */
+	{ USB_DEVICE(FTDI_VID, FTDI_EH_FXA291_PID) },
 	{ }					/* Terminating entry */
 };
 
diff --git a/drivers/usb/serial/ftdi_sio_ids.h b/drivers/usb/serial/ftdi_sio_ids.h
index 6c76cfebfd0e4..968e6ea3177f7 100644
--- a/drivers/usb/serial/ftdi_sio_ids.h
+++ b/drivers/usb/serial/ftdi_sio_ids.h
@@ -617,6 +617,11 @@
 #define FTDI_CUSTOMWARE_MINIPLEX2WI_PID	0xfd4a	/* MiniPlex-2Wi */
 #define FTDI_CUSTOMWARE_MINIPLEX3_PID	0xfd4b	/* MiniPlex-3 series */
 
+/*
+ * Endress+Hauser AG product ids (FTDI_VID)
+ */
+#define FTDI_EH_FXA291_PID	0xE510
+
 
 /********************************/
 /** third-party VID/PID combos **/

---
base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
change-id: 20260711-fxa291-2e590229f630

Best regards,
--  
Tim Pambor <timpambor@gmail.com>

