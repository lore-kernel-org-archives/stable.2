Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C76470EB2
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268338; cv=none; b=pYaakPK+H9Zr93unGqIlgUzoChZT6tc4CrJ4ibyXOEgA0rGsJ8MQvqlwGo9BUlL4sEeXXi2wtI+mC+CXVskhNZRmDe6bEA5wq3Ert2lAYOTtUcjfAM7GsQkDT7LfTEtc3oW9xZV4UGvZ4YIWUA7guoOGQKfjqehRh/9oWbuxq0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268338; c=relaxed/simple;
	bh=zr85cf5OM4ACF/oZP+D0He7J6hHB3ill7heyRNrcFAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MZ6O31iXsaB4EzDNy9whZLLNVFp5ZP1UQ6DGSKdwWt46+PNtgGrE5hABY4XkzFK9GLxhAnXvhSfq2j0FZOlgiqxY/A2Vtq5aEWOUV0ZVobo6gwKc166bROExTBHY1tP09MvSsr9FqwvvbzdHdiTqpETQMb922UwqufYD0nTQPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r8aQ+5NU; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8aQ+5NU"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso249865a91.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785268337; x=1785873137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K777BRooUawVspr/rUZWKDKbuSCg0hJqOA2h4aegueE=;
        b=r8aQ+5NUNsLqkdzeqQYTySi6Snbb7U2y/iHAMEhZYLdX78XlyLkDDZhw8K21HUgrCF
         EJdwj3L1LnlnsmECojQP82yhRTBlS8b12rQ/kiZCY65QAWFNz5c1AcF1iO7aAtyRI/W1
         iJjJVbvaI8WgHhuurqo5oAMz7QujIo00jcd02p769NDGDAJ7lzL8J7BQyZyTejgLa66+
         u1PNCsBqCT7YFbqTemc3zC9atIJsk/WLnwnJEJa6DaNpYuHoH4CAy59PAVUEer+57Ed7
         fQshJxtQgUgJxVNcB9ZJ43eZbN4Q5A9IYoB6N0nBIW3bPAJwqn/GWvHqN53IsTcQD1Zr
         hZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268337; x=1785873137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K777BRooUawVspr/rUZWKDKbuSCg0hJqOA2h4aegueE=;
        b=jdlJOLz8mZ5LsI9jFDOdecJrMw/+sJctVLUqdw2Wf9zMDDlp8SsU+N+8wrf1TwN6QO
         Q4XjvNLvn0heZGSyJPT6QFlxJ4BZZ30diS3Jent47iYGzbiKUkCRVi++WTEbjVS2/tJV
         uJ6MlzXQpDYn1nIZhzWN7goPynwEe5kVRZY/PxJVjBEPI6iU4TbiSU+i4cMcf3FgcOIl
         gcBRcoKUETEjS13WumESswN683CLFRdvgCK2jRXejL9gkiJDV/sN2n7VuQuNfhVxfiDd
         PbZQ4RXF2MrO7qDb37ORn0vApl8YK5MkkIgPyku+9YA2qBfs+yJFUxeqtGBlwhllsF/5
         O9yg==
X-Forwarded-Encrypted: i=1; AHgh+RqKLPENcL9sEV02nMLvejAv0SGqXJdkyl3XbeKAMpm6Cv5ars0K6q52caNATS/qBSUBRYLMf5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjrhdcJNf+fS6GDjNqFYwI5n2WI3O2mRqPADvju+jEC2JCfevp
	pW9Cd1RW8BB5/br3DS6iz0JT91Nl2zjYgMSYGLkvg2PMU6OExroRjm7h
X-Gm-Gg: AR+sD135S47lB3JZAfzvS57af/G1TA+u163K3s3EgYhQXuESxOGzDy5+eQs0QibtxrQ
	Q4bHmh5V0MJDotf3IydRH4XLNuL6CL2A/jcJowbdNONNfizOBIBMFhq+zLgwGC42nPkonJy228n
	9hWC1+6hsv3hrWq8aKU0g7M7GrWRdAGZooC7gVeX6bJ3aBlZ3S5wPxmXVOEri4zixxfg/d8Wtua
	GqcRbtDgoyM4QAh/Oh896FeP/SEBWYVfW5qgxW4e68+w3vM6vuYDZW1ieIBqKIbezuYg04M9mRt
	Xyqp51MS14xKiMpoDeOwaEdtzWPzPTX0Mo34fYeseb7wgtozczyS7YK+YCdvwnTkcyHbnszBZZk
	+Oi7BK2NOQk+4WIJlfeK+hYNj52gXd+qLGJAIqJ0gT8B6jFo7Vm39Myi7X5UOmWyTr1LTdd7Lby
	cWMdo/vPu9kbWbdijEQ9ctZrABz++O+R7AB3InsLwkZ8i/HaN4TSArzPC0ZzqOrZWylg==
X-Received: by 2002:a17:90b:448c:b0:38e:a205:c84b with SMTP id 98e67ed59e1d1-38f6a4e2d36mr3992072a91.28.1785268336559;
        Tue, 28 Jul 2026 12:52:16 -0700 (PDT)
Received: from localhost ([103.170.252.6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504d3250asm1448051eec.20.2026.07.28.12.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:52:16 -0700 (PDT)
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
To: linux-usb@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stern@rowland.harvard.edu,
	michal.pecio@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	linux-doc@vger.kernel.org,
	ishaan.dandekar@gmail.com,
	Nikhil Solanke <nikhilsolanke5@gmail.com>
Subject: [PATCH v5 2/2] usb: hub: Split announce_device() to log device identity before enumeration
Date: Wed, 29 Jul 2026 01:21:58 +0530
Message-ID: <20260728195158.65162-3-nikhilsolanke5@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728195158.65162-1-nikhilsolanke5@gmail.com>
References: <20260728195158.65162-1-nikhilsolanke5@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

announce_device() currently logs the device VID:PID and string
descriptors only after successful enumeration. This means that if
enumeration fails, no identifying information about the device appears
in the kernel log, making it difficult to diagnose failures.

Split announce_device() into announce_device_ids(), which logs the
VID:PID and bcdDevice immediately after the device descriptor is read,
and announce_device_strings(), which logs the product, manufacturer,
and serial number strings after successful enumeration. This ensures
that a device's identity is always visible in the log regardless of
whether enumeration succeeds or fails.

Suggested-by: Michal Pecio <michal.pecio@gmail.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Nikhil Solanke <nikhilsolanke5@gmail.com>
---
 drivers/usb/core/hub.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5262e11c12cd..d92bf887739d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2401,7 +2401,7 @@ static void show_string(struct usb_device *udev, char *id, char *string)
 	dev_info(&udev->dev, "%s: %s\n", id, string);
 }
 
-static void announce_device(struct usb_device *udev)
+static void announce_device_ids(struct usb_device *udev)
 {
 	u16 bcdDevice = le16_to_cpu(udev->descriptor.bcdDevice);
 
@@ -2410,6 +2410,10 @@ static void announce_device(struct usb_device *udev)
 		le16_to_cpu(udev->descriptor.idVendor),
 		le16_to_cpu(udev->descriptor.idProduct),
 		bcdDevice >> 8, bcdDevice & 0xff);
+}
+
+static void announce_device_strings(struct usb_device *udev)
+{
 	dev_info(&udev->dev,
 		"New USB device strings: Mfr=%d, Product=%d, SerialNumber=%d\n",
 		udev->descriptor.iManufacturer,
@@ -2420,7 +2424,8 @@ static void announce_device(struct usb_device *udev)
 	show_string(udev, "SerialNumber", udev->serial);
 }
 #else
-static inline void announce_device(struct usb_device *udev) { }
+static inline void announce_device_ids(struct usb_device *udev) { }
+static inline void announce_device_strings(struct usb_device *udev) { }
 #endif
 
 
@@ -2651,6 +2656,9 @@ int usb_new_device(struct usb_device *udev)
 		device_init_wakeup(&udev->dev, 0);
 	}
 
+	/* Announce the device identity */
+	announce_device_ids(udev);
+
 	/* Tell the runtime-PM framework the device is active */
 	pm_runtime_set_active(&udev->dev);
 	pm_runtime_get_noresume(&udev->dev);
@@ -2672,8 +2680,8 @@ int usb_new_device(struct usb_device *udev)
 	udev->dev.devt = MKDEV(USB_DEVICE_MAJOR,
 			(((udev->bus->busnum-1) * 128) + (udev->devnum-1)));
 
-	/* Tell the world! */
-	announce_device(udev);
+	/* Announce the device's product, manufacturer and serial number */
+	announce_device_strings(udev);
 
 	if (udev->serial)
 		add_device_randomness(udev->serial, strlen(udev->serial));
-- 
2.54.0

