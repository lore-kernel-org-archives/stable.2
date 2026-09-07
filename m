Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC153AC0C9
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 06:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762524; cv=none; b=uBCIHDHpwzLUY4/WHxF+cZh74fTJrs3I1cEURaKuW3tFK4AKprS7C398q3bJ176yQs5G+Cb9l+5B3iMedshp3qSjIPDZOQt3rEYGO4u+sZzFjErg81r2j90rgKNQn7QL48nWbWsBlSv/530cqeEQckNy650b2HKEILcGPbRtarI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762524; c=relaxed/simple;
	bh=Eczviqg/1I0bF4Nop5EFAxHliXvYylccF8WSRSrMDJk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DdNq76TaJtVxTtSamnG0UHZFun9FM5I7cYyGG/5c9s15NyoajTD69e4Xq8wRxdgmzSzNyOtAZjNw5OYj/nM/KcYmBb+WRsTtFQM6nB9a1+sB21dimzZ6P6x+FBoKRojnIyMx3anj6Iwc4NMMNv9DV1GQctL9hrCuKWD+5G3Z2/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SWI1vo4Q; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWI1vo4Q"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cace91f112so25960715ad.0
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 23:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762521; x=1789367321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EPO3XgKtW39x62BjixAoLRnOdq38lit6qHUtJ4zQNAE=;
        b=SWI1vo4QtD1kaRxhqS3nwYpllbba9vDiftF/CILJmsfQEspilXMZ2WMrz/w7G1U478
         qbFwA54S8iq/jXfVusu4+u3Iz6nu55n4oilV0ix7TvtwkaBkRUjfIM12QyIyo0nrJIQn
         0QfEKmHa4cf+cQ41HCzo9XvfXH+F71TySi1/5ecnLmbOsozVwO6kHkUrpCSDd7DCMFH7
         +Qd7D8L8rQhjb7w2pEJ6TG4Cb4VBstvOjmCNIyX1Sdxg5bekpOl2yFbqQXAHGU3V7uzM
         NKMrSoxlU4puoQZG5Tu3YL7pVhAh8HmjkoK3pN/UC3q+s7ThsJRgzENGipsi3hiP3Yy5
         ENJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762521; x=1789367321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EPO3XgKtW39x62BjixAoLRnOdq38lit6qHUtJ4zQNAE=;
        b=otAeoFtJdFRpOMmBGugln6+Fih0jicFwkzLNWugKRemXgCXEyj6Nm0X7U5ojHlAWTo
         M6J3ryLky+gI7RLogqtYvxw/e+APL0qWrde/+2IcSZ3i7BnTdowemhlFiT6MNBBT1S0s
         Rdj6y1p7uQD/CNzDQBlkxVWQ6/VaQp78XNQWM99hf6Ik4FEI6aEXcZh1wbXKDNCp2Jsg
         Fta21g4v/sTvVRqMsrSGxqhn0vNjU3yG1hRXXHUOHYRZ0IFnwpCT1Xiki4NkjXm3k4Jt
         yf0JOy+RkBCRI6VK0lSstujfLG7C7QwJKM2CZc77KOA6nM8Q42lhWD8OcPWrGlZTm3fR
         VVdg==
X-Forwarded-Encrypted: i=1; AKwUvBx+htM75k8j+YsrAQkeXyF/O0h1dTKfHVqUZO0Jsm479PNxYkTw7JJKngBYrnRC2lYDrzI3w8g=@vger.kernel.org
X-Gm-Message-State: AFuF++mW4IRu8aeoC507bTbSylxKVI8qWwe5Hdh3+R0lYt97naif6ByZ
	JcF4ZzrOheUIS6IU1XZETVYfYO+vryZmvV8dPygb7e8N0UcHvjxUgkQ4
X-Gm-Gg: AYBFou3E2VMMIf+g/ggiUunwqbsW/2l1+RiwR5d/ey8wZAHVqwvUkj1pJEhTIEYZnZ4
	yFFUALYXOAekZa+6GJGlaa6AWZdHuVVJBdGjF+uMkQMb/oduf27EHha92IOAI38B1pwUNH33o1P
	f6v1knCijh8uzEDLrgX6F7xmHX45KdIX8KEn/6MgLwHyAMdS+2qhEZ5nTbSUv4d/DPmRzuEuBFl
	Ptvdl1tPTfKGhS3DnMJWrwJ1ksk2zJvkqioeCpSL8kUgpsqon4BTwc43GTxMbJ9DDwvjXOtlrt+
	6gyH7XgWCbcqaRq9F6rpwHvr/zjm36f57Wo0qoQugPAro2W3iqKZVoSxHotkfOmsTQO3Wfm01hJ
	HDhScgVOuLb0JG3bVuJDFBGaKEz/A4SD81kvj75phy8oB6SYsqfTpVjDZEhs1OYJxhTF56Oqu2O
	Dz6bLF3Ig1pYyUHdtNMEDzjDZErdwrAbYgVQET/JSyywQgJ3Lztw67kXCdT3TPhtPqGzAUlvMgY
	ui9JWpZicENnEIQ8/A8NVX1HstFyWqrzgLtSQtzJErS7wSIfxaOf9k26DO64gmzSsgaBuZD
X-Received: by 2002:a17:90b:3c48:b0:398:e436:384 with SMTP id 98e67ed59e1d1-39b260d335dmr32816359a91.1.1788762520616;
        Sun, 06 Sep 2026 23:28:40 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([129.126.57.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25c974cfsm18978042a91.0.2026.09.06.23.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:28:40 -0700 (PDT)
From: Wei Jie Law <98lawweijie@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans de Goede <hansg@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] media: uvcvideo: Fix out-of-bounds read in uvc_ctrl_status_event()
Date: Mon,  7 Sep 2026 14:28:18 +0800
Message-ID: <20260907062819.2519878-3-98lawweijie@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260907062819.2519878-1-98lawweijie@gmail.com>
References: <20260907062819.2519878-1-98lawweijie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An out-of-bounds read exists in v6.12.105 and upstream. KASAN crash log:

  BUG: KASAN: slab-use-after-free in uvc_get_le_value+0x314/0x350
  Read of size 1 at addr ffff88802df955e4 by task kworker/0:2/128
  Workqueue: events uvc_ctrl_status_event_work
   uvc_ctrl_status_event+0x128/0x280
   uvc_ctrl_status_event_work+0x82/0x240
  The buggy address belongs to the object at ffff88802df955e0
   which belongs to the cache kmalloc-16 of size 16

uvc_ctrl_add_mapping() validates mapping->offset against the control
data buffer, sized from the device's GET_LEN answer.
uvc_ctrl_status_event() applies the same offset to the 11 byte bValue
field of a control change event, so uvc_get_le_value() reads past the
16 byte struct uvc_status and the value is reported to userspace as a
V4L2_EVENT_CTRL change.  offset is a u8 bit offset, so the read reaches
24 bytes into the neighbouring objects; KASAN calls it a use-after-free
because the neighbour it read had just been freed.

Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Cc: stable@vger.kernel.org
Signed-off-by: Wei Jie Law <98lawweijie@gmail.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/media/usb/uvc/uvc_ctrl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 21802f9b1b61..d082bcb8d98d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2156,11 +2156,16 @@ void uvc_ctrl_status_event(struct uvc_video_chain *chain,
 		uvc_ctrl_clear_handle(ctrl);
 
 	list_for_each_entry(mapping, &ctrl->info.mappings, list) {
-		s32 value;
+		s32 value = 0;
 
-		if (uvc_ctrl_mapping_is_compound(mapping))
-			value = 0;
-		else
+		/*
+		 * The offset is validated against the control size, not
+		 * against the event payload, so a mapping can reach past
+		 * bValue[].
+		 */
+		if (!uvc_ctrl_mapping_is_compound(mapping) &&
+		    mapping->offset + mapping->size <=
+			8 * sizeof_field(struct uvc_status_control, bValue))
 			value = uvc_mapping_get_s32(mapping, UVC_GET_CUR, data);
 
 		/*
-- 
2.43.0

