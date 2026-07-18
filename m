Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2575A283C93
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343315; cv=none; b=WpoULhIa+KJQTgY0s5DQk/22qIwllpLlFkyJEdf8nGDpLOmRwFGGy0b1AwDEKAQ2hdnDRiPYkz2Jwoi5kqxjJJKyW5rVeQCZzjKu0P/LlnvI7ccxw8LPfyTPK/4cF9N/PZGGwNW3x/WlCHeRGiTFklHjAj+j5OfmR/XlrI+i8SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343315; c=relaxed/simple;
	bh=Ul0DFw3Ej73eiCwcTexNy8jh0poOMPwPODq7wz9FOLo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GdxKCjbsGEkW5FdiIcyy0cd5z5FmGCILDAswq6hydsmRm+2LSn8XOexe1R7v+zn4My0bnDnRYXy6XGIR1oV9DVeeKoSp9WAurQfOsx8E0FwcJFA8843veoMFxMycVJuXMwdoosXuoYSe8FKzWbbfBXx2G3nii/PX9bC90f30/gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RvgJ5Vio; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RvgJ5Vio"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-902f92b8504so78995476d6.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343312; x=1784948112; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=47ZO/fVoFhUn5pOP6KZbb4HeOIXd+WNQBMG6RHvVVbs=;
        b=RvgJ5ViotQLfRJiSoeDnezx0MSxNBQrQhs1y/0aA3Lc4gB4efOA9SsmL9lNInY91Bo
         BHii1kkunIXszvkFdLmUMdwBqx8feuJNjK7EPwG21Y497bYfH5gKiGgIaZqE9zkr2eoc
         3tpU3Oy+CW6yygTJ9+id/LdfSWvC+pde91Y2xFmvw8WBLhgF2pRfSJTuf6ek4i0p7k44
         kr5Zv60T5M5OQfbPQEOnDENEryu68zeNh5cn/Tc3Dyxj0wDyDkjisBlII63/jLj5I0h1
         Wywvz+L1guefGKMynuFzgj12D4oK1teUgCGDuDM9Ew6AkRl14UX9hDAKKzDfo3XEzUCD
         079g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343312; x=1784948112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=47ZO/fVoFhUn5pOP6KZbb4HeOIXd+WNQBMG6RHvVVbs=;
        b=UcZrgxubdFbhcMrcW7WrRWN6MUKsZUbLnNY9V/cVffq5jytW+hRzoGS+6+LrSaPm/n
         UiY9TpdWjtlDsH0Cpy9effLJmz5rJky9oPJjD4jSU0CgawAJtvg0T8+L94bdtnbNRqeD
         QS+uU1jHLImdUWg8QhxMbOhysbqlc7YT0T4bO5OInsPTdMN+HslJgRT0swSYO7BvlMXZ
         OOXafALXlEnG9q2zrxKQ9PKdWS7qTavygULP9UhZV70BRhGgbtpntljZXOr6HrsUOgdU
         /AeXDN2wW1XzzFlJHmPHJo2PHk/hNSxiVvNr07SLP791aG8dkB0nSIl2IxUcgrblrGCa
         Ip5Q==
X-Forwarded-Encrypted: i=1; AHgh+RoYiGNxY8+cLxm3mS4UXSxGdh4l73pZavQHVulgZ03+x3Zsng30no1e0t8pKVexdEFacLUe+Go=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxx7TVo2l7lc11qTUN6jaqq6fIw50AlrxJcQZ6/o9uxi6TVX0f
	sXzdJ0DRH0cWV/Iq+qO1lU95MioRca6gyTYhYQ565m8RgCyoTGt03uTlh0540LGZ
X-Gm-Gg: AfdE7clEJ6Uqx8Kqpiit583MdT1nRPIWNM1/UglZvWAPNH7e7q/ZnWBZugQCCynsacB
	oylAqknG3oVgLgbmfAys5vGHjHsqP2sLtxgXLGikNbtGkBXx7gMxYc6qfX3u3TDOkPcxVn7n2eG
	CIjSbJtC7RWV9YUbnB7McPFIUtrZ82tS/6ZsV1XuUtVGDcvsfc2TVh5pZqWCu1JariN3R84E9Ar
	xBfAIRpCl/6b+vTH+ZBhfULXhLVTwoZXsT2YjovGO2jTbjhycBOacDTtSwqYx8vFhY6fjkrf7DS
	VTgqhkxQttduekrvyT/aJYKnamwhI9YLnpxrX3Z5tZtWdo2yXpGTbBWc/5IZBFJXEo/Sjb1FhKl
	wi1znwO1jB+W6RU6uTdxlc83AkFnjspcjPuUEdkUYWPabAZ75beI6yuGMNlag8FyDBwRTGNsD9i
	skZ7oJndrjdGUKVT5hs65hfgRDhCyKHig=
X-Received: by 2002:a05:6214:331b:b0:907:8374:6abb with SMTP id 6a1803df08f44-90783746d93mr18429716d6.59.1784343311874;
        Fri, 17 Jul 2026 19:55:11 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90778728a50sm31883066d6.47.2026.07.17.19.55.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 19:55:11 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: hverkuil@kernel.org,
	mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Subject: [PATCH] media: gspca: hold a usb_device reference while registered
Date: Fri, 17 Jul 2026 22:54:34 -0400
Message-ID: <20260718025434.2259756-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gspca keeps a pointer to the probed struct usb_device in
gspca_dev->dev, but it does not hold a reference to it. The
V4L2/video-device reference can keep the outer gspca_dev alive after USB
disconnect, and the streaming queue can then be canceled from the last
file release path.

That late release path still calls into gspca_stream_off(), which may
call sub-driver stop callbacks or usb_set_interface() and dereference
gspca_dev->dev after the USB core has freed the device.

Take a reference to the usb_device when storing it in gspca_dev and drop
it from the final gspca_release() path. Balance the reference in the
probe error path as well.

Fixes: 63eb9546dcb5 ("V4L/DVB (8152): Initial release of gspca with only one driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/media/usb/gspca/gspca.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/gspca/gspca.c b/drivers/media/usb/gspca/gspca.c
index 594d73e50b9f..59eb4cec1aed 100644
--- a/drivers/media/usb/gspca/gspca.c
+++ b/drivers/media/usb/gspca/gspca.c
@@ -1178,6 +1178,7 @@ static void gspca_release(struct v4l2_device *v4l2_device)
 	v4l2_ctrl_handler_free(gspca_dev->vdev.ctrl_handler);
 	v4l2_device_unregister(&gspca_dev->v4l2_dev);
 	kfree(gspca_dev->usb_buf);
+	usb_put_dev(gspca_dev->dev);
 	kfree(gspca_dev);
 }
 
@@ -1462,7 +1463,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
 		ret = -ENOMEM;
 		goto out;
 	}
-	gspca_dev->dev = dev;
+	gspca_dev->dev = usb_get_dev(dev);
 	gspca_dev->iface = intf->cur_altsetting->desc.bInterfaceNumber;
 	gspca_dev->xfer_ep = -1;
 
@@ -1574,6 +1575,7 @@ int gspca_dev_probe2(struct usb_interface *intf,
 	if (sd_desc->probe_error)
 		sd_desc->probe_error(gspca_dev);
 	kfree(gspca_dev->usb_buf);
+	usb_put_dev(gspca_dev->dev);
 	kfree(gspca_dev);
 	return ret;
 }
-- 
2.43.0

