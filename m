Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80827414DEE
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091840; cv=none; b=TA4F/FZlJ4YmdhBfHD262BNe9NeEVBVf8mQhEuSnUwUv8fxdY+pQ2QbbpITX/4w07+v3EAOwm9jPhMcRYRAzyM0fXZYAiq6SV/q8p0wSPy2uFKyqOhNGr8EoybRzF6o+4mE2NyMbjxwqf/QuYhRZt0LtkySvtFtHEqUgjdGMASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091840; c=relaxed/simple;
	bh=XFFg61obA3qsjXJjqH4r33ESGnevy+fzfPZQQs8QGPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VV1YsOwhRzrra8SoNsSVKfrCAWBXVv0a+c3uIrNazrB6U/7VBcFe75n1pkZ+tmlvQloLA7x/GQs4c0FiJ8M/AnVtn0OdYaGhGDwkqMIXXLMaI/mJZeiFHDeLjs3/JsPpSVXICMEVzITJyX3hzyOxUgK2RNKfJAS11wSIUM+o7vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yx3AUNm2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx3AUNm2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493be0fbcc5so184245e9.0
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783091837; x=1783696637; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8s+kQBALUfBmxcLdBRHfyiAZoSnCeSt/tQ8n5wZfgzY=;
        b=Yx3AUNm2e2vC68NN2OyCd12c2TscOjdYjAWxX+wSL7JmnWn3BlrYxyJb8J8n4+CgzK
         MlISIbXmnNojAKEkrOdsSXvullvd08Ax1GC+UG7jcxoF9h7mVGUWjLtQssXLrUm7ahzp
         asqid1lVOwNW9UbRqqjwd8dXcroCzmHUWJ2SuEetUetj5QkZO/Z84N5Y2QcFPLCJ5f29
         UUzU8uzy16JyTNTMsgvx2nRkhYYynyweqbKqtG+8m+abGBKMq5D5Vpnatgvnryb9Ojnk
         dnzFof9eEF9Sfik2nbEwmFDzfKncIv15jCFTGg04QslUrP9OtFK+VpXHSn6K3A1L9n1A
         omow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783091837; x=1783696637;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8s+kQBALUfBmxcLdBRHfyiAZoSnCeSt/tQ8n5wZfgzY=;
        b=iAyxCbB0TM0/9YwanCUD+E4zcjxSMyawmYI2Wa0DYw3WRo+ZJGsbOIwFVh5JP5fAcF
         /4qgRwS5Wqh7TnBiy3rDeCHcH7np+wXm7eUfAVFmcgJGjRS1haC303ooJmov/pEWkhYA
         KoRTaaGj/N7PNN5LEshDoi951QmkunHfCGjaZTydChCt3Lpx7hCeUnMtRtsG7eUPA9cX
         s9s45s+OsOVxJ2JWWlGk2JFjOiuHjMtD8pdLxO8rOnI3/GF/z8xek+WIRRaZCcCVzGrU
         dyMFzimYIVjwvYM6T50aq7NU1Pd17geVYmYnlvDVnut8tnVY80cJX8tZ02qWu2qrCcBI
         rfLg==
X-Forwarded-Encrypted: i=1; AFNElJ/e0Rg+6Ozhj0AORu2Pg0E0Ijyi6Ckdz2FxBqhDGHzEBqbavgHeVSgsg+lYa58et2x3UbKT02k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwX5KfS0fFHzUzvp4ckYNjyIToIjNc0/Ee+O4sCIvG9J1vMjMHN
	XWxOZ845H1zbA0xE/gP+QwCkN1XSKB9Gok1rN+mW2F5TTXJO7id1Q6sINwtlWQM1aw==
X-Gm-Gg: AfdE7cmRspG2qSbEjcLJk6LbsQRzyOlGqzEaLDQh1KvUSOBvgeVrVRQfEY/UKnvj0uD
	E/uPXusYaw3OXSiGzdAIByc9cQTg70o+5UPxRGg5/fHSX7Xzh3C5tQC+GKLpTfKRhP3/hu/ioS0
	IRJT7Z40MXUNv6G6epyb4TN6EqjJeXWkCTw0klrq0VlRWQIdRv5etMAGgaS+bUIdw0GkK/HBMA5
	3jUV0Zn+WsEM9ZIlYCFU08NJuo8jPd+1fnPfvxbjI6QVrGgQtzXUE9dQeDgjVuHMBFW3H2leGel
	apwL2IM+oiTeRaNH9PgLiPQR25JOoqYD411JHaGzpxNksgY2y3DIrxvAIJHAI39dr/CRIwWn7DE
	uEcZXzDNCxqawKPmL+K8cNCAVDhWvvJI/pmP08u3LxGz5oam4A94ADj/w2KFNNyejXFpWxxZbyf
	ekkZZdDS1GJRcgGcVtvqmVwod7MGi5bcvPy60U6GBMvqglOtnQZSeN2/BH0H9yDa17Akw6/7Y=
X-Received: by 2002:a05:600c:b4e:b0:493:c1a0:7fdc with SMTP id 5b1f17b1804b1-493d0fe58a3mr22775e9.0.1783091836475;
        Fri, 03 Jul 2026 08:17:16 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0a55be4sm8843f8f.31.2026.07.03.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:17:16 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:16:48 +0200
Subject: [PATCH 2/3] HID: huawei: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v1-2-e80259ff625d@google.com>
References: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
In-Reply-To: <20260703-hid-usbcheck-v1-0-e80259ff625d@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783091826; l=1562;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=XFFg61obA3qsjXJjqH4r33ESGnevy+fzfPZQQs8QGPk=;
 b=nhtictv0Odwlgk6Awml9jwFofS+SYnOW+CcJLL4GvrTICK+lA1ED+SbtsWfno6SVm/lP0qFn/
 0Vwse06VGsrCALRWKfQjqDXA4HuhHRRn8lvINQBmwTB16wnGhoS67hy
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

to_usb_interface() can only be used on a hid_device whose parent is really
USB; uhid can create devices that identify as being on BUS_USB, but don't
actually have a USB parent.
Fix the use of to_usb_interface() without a hid_is_usb() check.

I have verified that it is currently possible to trigger a kernel splat due
to this bug in an ASAN build, and that this commit fixes the issue.

Fixes: e93faaca84b7 ("HID: huawei: fix CD30 keyboard report descriptor issue")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/hid/hid-huawei.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-huawei.c b/drivers/hid/hid-huawei.c
index 6a616bf21b38..ee3fc6f68475 100644
--- a/drivers/hid/hid-huawei.c
+++ b/drivers/hid/hid-huawei.c
@@ -44,11 +44,12 @@ static const __u8 huawei_cd30_kbd_rdesc_fixed[] = {
 static const __u8 *huawei_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				  unsigned int *rsize)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_interface *intf = hid_is_usb(hdev) ?
+			to_usb_interface(hdev->dev.parent) : NULL;
 
 	switch (hdev->product) {
 	case USB_DEVICE_ID_HUAWEI_CD30KBD:
-		if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+		if (!intf || intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 			if (*rsize != sizeof(huawei_cd30_kbd_rdesc_fixed) ||
 				memcmp(huawei_cd30_kbd_rdesc_fixed, rdesc,
 					sizeof(huawei_cd30_kbd_rdesc_fixed)) != 0) {

-- 
2.55.0.rc0.799.gd6f94ed593-goog

