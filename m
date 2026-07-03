Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEDA2D12F3
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 15:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783093566; cv=none; b=a+/peXWxooLf3Kh96BxOwHfla29b235uNex64wpHCaNfX0XpfcF58lRyvUQum5hfh2CqcgXImvxDnyKlCADD6iFSvKqpZMqpc1ToX/nbjOXpgG22P+jSaFgoqzvNsNvChvlC413pHWfwc3NJ3+9TQ5u1C6tP+yqVaD5mH247EeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783093566; c=relaxed/simple;
	bh=XFFg61obA3qsjXJjqH4r33ESGnevy+fzfPZQQs8QGPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rHcyRIy/CcIcT0v/MD5Btm+YYpDgTCgY/QAqcJEWaNGH1MxrOOZJ+LFndyXWVNuTN5M3IjRsbcKyZ6zokCsGnx0mJoWLiL/TrGj9pgFTAyWRDr5YwMBQX1TF36Y2MtDwkfDiVYuTflJoT12RHh4QaNJWWPcfEzdiHuJvd+mcIhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Suxx448H; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Suxx448H"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-493b8d99342so187895e9.1
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 08:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783093559; x=1783698359; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8s+kQBALUfBmxcLdBRHfyiAZoSnCeSt/tQ8n5wZfgzY=;
        b=Suxx448HmRwfR8Y/1ac4Exj57+Pen7+ch36OV/EGZmjRV5WW8mumSlBttNqC2vJjc0
         iHZGUhNyk3BMnRA/yUTV3sI5WumBfSaIY4TGWH3LPEphlhknn2bh6W3BGsfTXovEOFAz
         xXXfOazuUtU7cHbMogf7Bm7CbZgeQ3YStXV8xUZ4IcJU38Sbou+UpcNk71wq1d6wZDxX
         z1XEwLGc2zIWFp+F26pyuhM5hzXUKCnzP4bf9XSxM6byaFeEfMnXTC8CoaJ0spMUJ4U7
         q8GwD4GhIgL8fwP/Yty03TFCHVaddmw0ISG16ctC6EiSc79INPdA7g7USTaVOf0yJk1J
         zl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783093559; x=1783698359;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8s+kQBALUfBmxcLdBRHfyiAZoSnCeSt/tQ8n5wZfgzY=;
        b=EayDiR5HX7XoSdRyGolqB8H4DNQFCrTsCgTAxvb1YkTsNpRoTA42d/ZnOPYGRfkCMT
         3zqpETisCp6T0fVMfMnDDCwPjn111gbQJELlCSiBDoZwtqZOWaggH8kkN6n1R3CM3R6M
         jeeXs0jJC97A4Rp9G2tKHyoyJbxXvznukz6mCHYtk6SWoGrMKLt0/uCV4LTIXiXXMAMy
         oxcLR9cCFYQ3gAtQIC2+zIE8DvN6B0WOlL7PIpSEj34kKFWW9Ie9hqTNFgO6xnrF0uC9
         qf2pMUjrFgnOMQM6ykU2JT/MNdZZu/ZmlyF6zckMWkorXPgxoDcw9F4kJFobmHi96adk
         sfUQ==
X-Forwarded-Encrypted: i=1; AFNElJ8plt1P9uY5iIlSlESZ3EE+TpBW9ihNVFLiQV0u7/tdUocshHXMpY4fT06h2kLKUK1M9guuFFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjoiwQnDs0OJGE6CTVLi9v9BbhaMk/Uieyk9USsDuR4/eqoTZY
	j2i0eOf+MLnwgI46iIPru8HdAb5WgY8Ia1zdd5wtQgJb1KUthH9Te3wozqMxhHfL/g==
X-Gm-Gg: AfdE7cmNbOGXZFJHt20nf5Cg724KweZl7mkSzYRAyA+OC0mr/r2owfM9YG3CNMF52mZ
	5aASZmyNkBwRLsB5E2utJR6hhVCt5tGBi6cJ1GFQdB2d7cW6Ny2plPgEhdW8qxAUpWqcGXITd8o
	lGw3cXYaosUYLvYU2CLifPT++81PIQ5tRIBHVN9h863Ll7MofokLqaH9wnSjVLatAbnLizvgZ19
	eB8+WaIvnFSBnOh6ciqcjPi6T7WkdKHuXIcrQi+rDZ+035Ww4G1NenasZe7BCZxloLDnHXy8R1t
	Qk6/ql+dWoTJIAQcunjP+OlGziNyAHjSmEllqMCO7W9BO/MyI2zHwWMhJCM0sOdGwDUKEsUwd7+
	06vQEp5uNbaIFubU8XHdyu7DECJ0crh9lrwGRGzNVU0RL18UqqI/z5sOuIsPPyvlEw9NAnd7VIy
	yL7d+O6TIXML962B2jLzPxyr9BohBoAyjRGW9mst8hytbW3AE46tY/oUwoX1Pe3MVyMV7B36Hxk
	qEBjhKRuA==
X-Received: by 2002:a05:600d:8445:20b0:493:adf3:d892 with SMTP id 5b1f17b1804b1-493d10200abmr56435e9.3.1783093559225;
        Fri, 03 Jul 2026 08:45:59 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:c0d:89b8:4c51:d7de])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bfe616f5sm137501715e9.1.2026.07.03.08.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 08:45:58 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 03 Jul 2026 17:45:53 +0200
Subject: [PATCH v2 2/3] HID: huawei: fix missing hid_is_usb() check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-hid-usbcheck-v2-2-c5ed7bc94772@google.com>
References: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
In-Reply-To: <20260703-hid-usbcheck-v2-0-c5ed7bc94772@google.com>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
Cc: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Miao Li <limiao@kylinos.cn>, 
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783093554; l=1562;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=XFFg61obA3qsjXJjqH4r33ESGnevy+fzfPZQQs8QGPk=;
 b=mnBycHTL2p3hZ6n7utSe2RTTKnQ23wf+/oTBHuVscfc4S1PkXdAnNfoGpSPG3NZVNGjSeYAsn
 F97BbhKccQKAvp0qDAkP88ksq6ZfIREs5iyXxb8DbZ9qsuFDDo1IzcE
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

