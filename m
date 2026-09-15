Received: from mail-vs2-f43.google.com (mail-vs2-f43.google.com [74.125.227.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF099340D90
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 04:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789445401; cv=none; b=AQQD3oUwmy8JD6nMH1iggZ8Vnn6w67bZf4ctx+UC/0JPeMWHTNSGyLNp6UL/VVxJOiQFLYfKaRWckqkfbyMqNZjErxEQ5ZtJVn6SKrEVZBDnhdfX6wZjMNozl0PMYK4wkzfpca6Mxd7TME7HijTZRPdLWEIn6ibUsT97ilAU2FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789445401; c=relaxed/simple;
	bh=eycpq7ZGf9c0AnYvssHjHkaOZs7yH+Qf2uYDXQ+Yv/4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qj2AW3vYLzveN1w28jnuvzmcNg5RH9fm4yMyxatQ5mfyjmNSTa69OwT80uw8HqVYEibem84wqYf3dB4hEyYe7uaAIWo2j2+OVowH1Cb+hFP2llO+2s1HzIlUMEw6Okm8ZpP69YttUmi+ITPydBt5RqUv9oY5QYeYyqERGik9GpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6asINI6; arc=none smtp.client-ip=74.125.227.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6asINI6"
Received: by mail-vs2-f43.google.com with SMTP id 71dfb90a1353d-5c67e5059f8so791648e0c.1
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 21:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789445398; x=1790050198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7ZpgQuMw74S9FkdqF0b5yylYR5td4Wwe0O790DHV/I=;
        b=o6asINI6dORUyTMRKlhm6vqKyfmDxFqSlU/KmhnOzqD+NaQUYArY8RP53ykFJzshYK
         GZMK7fiA4prHKTxpus7o4tltbF5lu9FNPObqQmd4IGvowrk8il06c+mJ0JRSfWfPC4Yk
         v5tRH4UN+9McYIht61nQ7diIUJd2ieIn9SjQ9L25byN3yud4K0GYw9HS2VmVVud3WtGv
         GRsUDxlqt49PCmAlOKEUMLgXSuvO2t48MCFDzHPb3Ko7V8pWuVzgpiZkthFFw59va67d
         5w9TiaEVo3TZ1dzqt+VTG4sFPN+XAfO/fkvKY/a6npKcmZ4D9QeurkRrgs+8c0LFGYUJ
         E/SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789445398; x=1790050198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7ZpgQuMw74S9FkdqF0b5yylYR5td4Wwe0O790DHV/I=;
        b=dCIl9G+DWbqdGSmTKm2NREsI8eP4PWYPCXBtsfh18Z/8/LZ3l6l1dN8vXZ8lzu55rG
         YFF0DWTw+85IF9FgrOi0I+teJ1ycHZvvQVtmpM6JMMTVFEnQXpSGRiGmY2KJyNwmbnds
         QstekdJJbok2lTFHLnh+a+OqkTiQz5y5/eYBbMX1XyvfSXtg2Ct5e7nwNavbqt9VtOlp
         itGeiFpVBHkXVl07mXK3jP2jt/RxOR+6tZhP1DV3rfOWn0gSp4tuvIGCZVStHM8j/eHK
         R00YgDFuiBj345A+xDyYnE43k/Ylpc7nRtklk2i59iVr6nC1xCH9yGK1xIVobw6E0oOU
         udoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWMSbJ7RvlgIuRFpw58bFsYV2HKVyrct8n8T7eK29difi5x66LOybIsl23hAO77InnlcXSk6k=@vger.kernel.org
X-Gm-Message-State: AFuF++kRA1wNBxR06dHTgBNv9cutplR1O13DHFbvoT6Kuq7mFkMONdcj
	fsKoIHgdd/97DF2wqzoL7Z7Bu3jWt1KmjeQon9qu270S7U1JOLr8tZYY
X-Gm-Gg: AYBFou2OBqUd6d4SDR9Xn9dJW5iuMB2um3LRanGqqw0nnpeq+lSDma6tlZ0QpcOqp8p
	25YjnqssvkPesf4gaybX4xG6yQBCqWGFa8wqylppPolzOtMCZRShPhWgUHYKvY8XWBh8DgfBreN
	TE0K+z8Iy9wZhUcQC4kOPCGH803o2IUPsm7BfKtpUKHQbzUhmme0Q/UWtVucnddclLtmG5XXMej
	W8wd6fgroXZ3WEqyl1B0z054Q/9AYiT2fN8/vmAa0xDg9TVB81YZrnl1dQ4gnkfQxO5AG25FIrb
	ZUB0p1ni+FV/JWsHMRl36Bfcjb9KmvDlcCilYyCVO7ylLY/4kUJuPqWMTO82I1pI957LPKJV6Na
	n0L6O0UjKOVGqk/lJp2MjIoaKlD8xa/500ie5HQCeuuafGO1V62EuOz2O1fTZaQ+r44z/9z+aYH
	yLPZ9Dk4eAAF3L2GlwtCTZL96iS5P1S86yz3vDRxPo1YIycDXGqW3sEPfvtCq8yR1j
X-Received: by 2002:a05:6122:616b:b0:5c6:5daf:52ea with SMTP id 71dfb90a1353d-5c9820dac02mr7036787e0c.6.1789445398559;
        Mon, 14 Sep 2026 21:09:58 -0700 (PDT)
Received: from beelink.. ([187.13.206.89])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5c8470e7ef4sm14496006e0c.9.2026.09.14.21.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 21:09:58 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	Chris Mason <clm@meta.com>
Subject: [PATCH] usb: gadget: composite: pass the validated interface index
Date: Tue, 15 Sep 2026 01:09:47 -0300
Message-ID: <20260915040947.2426239-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

composite_setup() validates the low byte of wIndex as an interface
number, but passes the full 16-bit wIndex to the function's get_alt and
set_alt callbacks.  FunctionFS reverse-maps the low byte and then uses
the original callback argument to index its fixed-size cur_alt array.

Pass the decoded and validated interface number to the callbacks.  This
matches the callback contract and prevents an out-of-bounds cur_alt
access when the high byte of wIndex is nonzero.

Fixes: 2f550553e23c ("usb: gadget: f_fs: Add the missing get_alt callback")
Reported-by: Chris Mason <clm@meta.com>
Link: https://lore.kernel.org/r/3984c9bd-2ac8-424e-9390-7170fdab3c03@meta.com
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 drivers/usb/gadget/composite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index df39e3487..2aa07eafc 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -1930,7 +1930,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			break;
 
 		spin_lock(&cdev->lock);
-		value = f->set_alt(f, w_index, w_value);
+		value = f->set_alt(f, intf, w_value);
 		if (value == USB_GADGET_DELAYED_STATUS) {
 			DBG(cdev,
 			 "%s: interface %d (%s) requested delayed status\n",
@@ -1950,7 +1950,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 		if (!f)
 			break;
 		/* lots of interfaces only need altsetting zero... */
-		value = f->get_alt ? f->get_alt(f, w_index) : 0;
+		value = f->get_alt ? f->get_alt(f, intf) : 0;
 		if (value < 0)
 			break;
 		*((u8 *)req->buf) = value;
-- 
2.43.0

