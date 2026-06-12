Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF63E9C2D
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264520; cv=none; b=ZIxkVumg1RPx8XydeavHShVgnU0u4hvVw8q9ZCFy4igZAgfTK+gqqz5zf0gmGq0nNBimWVxNM6PChJy7mlc1U64DiFv4zlyYhjiOgZgpCKiEbPol4zhhQeTolB1Ilsuogjyq7gta8lFJBaLFZPr0RHbyuy/jF+CTiBjMr25OanM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264520; c=relaxed/simple;
	bh=foR7FDI0458xlh+ugYqRvXItyPjd8fdWRXmqavzCmwE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDX3ogqsRru5fbjPGO7vlZhQtzDCr719KaFD787mGGsJuO+xrvNmLE1VVeqfSuM+M9EQK51EK+bq/TjEhPBKn9Q0ziAQ53UToUf/OTTNMYF9Kau5w0X1G1SL4QbemkeHGHEn+5PYTlP1r8EN2PjalXguD6SvNV6+NgjANChlmbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv/yMtR1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv/yMtR1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso5982185e9.3
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264517; x=1781869317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PsfAOfi1Tsu5nPJOTn7sIWBkXPhQghFPoGo70TQpeaM=;
        b=Iv/yMtR1HzxzhrCnT6IgnTKDWXfRAek14KBOyEgza3MLsekBO7g6g4MAQdVFZ8DodL
         Z4QI3kjFQUE7sGAmhkRpVu+MwfILCI6zOUe4D3lhRij4L8nvd4koArB5YkLt3VyUvll1
         RO0PhZesoqv1PngNZM8YDFMiQgtUdI1aw8pn3snThYfm0gFmOYC1YEXjbf3FjdfJwMwI
         z4+JASfEvfvEQmfHgDNigDFtpiYe7hs+LHDtWyeJTWa9iZ7HPzLv185IVGKfoBwBKdFp
         tlBMg2YgGDEGRAWDywUYutXnj8YuI0eBM83cc/ySQnwLRAZnIF6z82vXA/7lZtXhml1U
         0YjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264517; x=1781869317;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsfAOfi1Tsu5nPJOTn7sIWBkXPhQghFPoGo70TQpeaM=;
        b=Gc5DPYAe75jI/TIoc8Ab7sJbqB1geH3ut+vSs3a+TPjh9jDFD0mYBcwF8lu4poyLg6
         ZNensIDdWUeR+gWd/NmTZy5ndA40D+SfLQ8iAGSvDm/vM2/EVqHJqmx4uS6jZKDBWOz3
         2xTWbSDLn4RkWCiiOKxxuzioMkhAR7wPxzEdqEjh54u+SLeLhoiraw23uqIxctxQctgq
         4YnFN3koDhHX75EcpNQNi1HbewSjemwf4qBsz8SDT4fOEWZzMEW78oawCRW4w4XJ5oi+
         6GFtoMJazdqZKRt6y1LvUyDdSPtupKhuCplFdkj9zd1s3SJnN91wVSYD6UR70OaeRarH
         XkEg==
X-Forwarded-Encrypted: i=1; AFNElJ946YpBO53T3if/6ZaN/ijtR5qOzU3zZuf0tztsvCMpGARJYvpDqNb2tA36TVyBCx2KxcNhJWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsPNjAo9qlHSq/YTHnA62IyQORM4F6Si2InM0uhR+0nULEaXy1
	Hlqp812Wp1Kpu/1h3hOuIt9zR5/gEFkMv+81XhfOhgC1E+WaoKUDnpfB
X-Gm-Gg: Acq92OHTrVfNr+pnzqDwMZSO6J3I1rV81x1ZEcSEr81SidUG4MGyUr+RB8ROeYwkT61
	gbQFuDuV9ovoqqsL+liiGkKdPFS/3D8bRGjDmegNO4pxDBqb6ZHYZO0cICbo8RURsNpqeTBhf96
	XEUVLNzzOoVfjwCjwhP+9ZOyonjOAnkq96qQ3evKidq4AhN+9xUZaEJor4e0HgTz23rCzz6ntbA
	tkLJME7HIZXl0qtkhFMKhBhI86sAelj2Jb2GZjM4WjmoLnJ+TSWGWwmpNa0H5U2VsnXrbyKJS56
	biSuoJdzE28/1DgF3+YowKzKCmuUK/t1604exQiNeINDKxtXu4oD210/QJ/twOnm+zMQGwsVsx3
	xsFslOdXiSlyuvLQfEDuJmaI9FMA4cppm0zQUGeuCXuyVztul6pJ861gticopMW9Z6FLKtRlQtB
	GlAnppHYVdqsqJhItuEMnuX8B/laOvpByC5H0=
X-Received: by 2002:a05:600c:2d84:b0:490:c2a3:1781 with SMTP id 5b1f17b1804b1-490ec50a93dmr19734205e9.34.1781264516906;
        Fri, 12 Jun 2026 04:41:56 -0700 (PDT)
Received: from localhost.localdomain ([92.180.79.206])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ea4a128csm72735105e9.0.2026.06.12.04.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:41:55 -0700 (PDT)
From: Jipa Alexandru-Ionut <jipaionut@gmail.com>
To: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jipa Alexandru-Ionut <jipaionut@gmail.com>
Subject: [PATCH] usbip: vudc: fix NULL pointer dereference in vep_dequeue
Date: Fri, 12 Jun 2026 14:41:48 +0300
Message-ID: <20260612114148.6849-1-jipaionut@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vep_dequeue() reads the udc from req->udc, but struct vrequest's udc
field is never assigned anywhere in the driver, so it is always NULL.
The following dereference of udc->driver then oopses.

vep_queue(), the symmetric path, correctly derives the udc from the
endpoint via ep_to_vudc(ep); vep_dequeue() must do the same.

This is only reached when a request is queued at the time of dequeue.
A FunctionFS gadget keeps OUT requests queued, so unbinding such a
gadget from a usbip-vudc UDC (ffs_func_unbind -> usb_ep_dequeue)
hits it and wedges the vudc subsystem.

Fixes: b6a0ca111867 ("usbip: vudc: Add UDC specific ops")
Cc: stable@vger.kernel.org
Signed-off-by: Jipa Alexandru-Ionut <jipaionut@gmail.com>
---
 drivers/usb/usbip/vudc_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_dev.c b/drivers/usb/usbip/vudc_dev.c
index 100000000000..100000000001 100644
--- a/drivers/usb/usbip/vudc_dev.c
+++ b/drivers/usb/usbip/vudc_dev.c
@@ -344,7 +344,7 @@ static int vep_dequeue(struct usb_ep *_ep, struct usb_request *_req)

 	ep = to_vep(_ep);
 	req = to_vrequest(_req);
-	udc = req->udc;
+	udc = ep_to_vudc(ep);

 	if (!udc->driver)
 		return -ESHUTDOWN;
--
2.47.0
