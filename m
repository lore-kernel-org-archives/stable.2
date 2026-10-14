Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442C51EE12
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991522; cv=none; b=EUXH3yYowqPd3IMkm3nx3OiPN9RKQBqKcUKhTR4xRrm95lz7rXj0gqryayGKtg+88NBfMs+Y+t4fLnVObq/C2LD+3g6Mc7WZRMZRgdilsBPG774GlxCkAicroFZwByPIuwAcL/vvVi9YWBHDPF+sfueb5MRgnV6FdJBLhvFz2q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991522; c=relaxed/simple;
	bh=4xtlwMXyWzq87oKXlTSUTSJUcCXtxizVzZJcF/3R7OM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SfKEBL8Sai1ld1NIMopiOXJfn7n1KqRVp8OZT4lNSmwRclquGtJymtwbeEM7VWuVlOxKuzKaNObV9Ufh3jgYPOFezm8R+rqn/PyLb2WmninYPr2tPAPiwejGhQQJChGggo2p+XIGUOCFlPF9o0FaCCXEu7MdrZgzjaXKmzt4UGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OvV3QGR4; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OvV3QGR4"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7c0466d653fso183129137.3
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791991520; x=1792596320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xZlacUVzzy4HBA3NrxiUhpJFwP6Wb2PV4OZMdQ09R7I=;
        b=OvV3QGR4FZThAftPriNMh0Z49gdzBDi90bON/J2qGK4x6casf1MCH7iu0i1QXdMSA8
         BFyJfzLwcxt3JPev9LG1y+5VFqIIjSghbVMKzuB5xyqs4/68DP4kv6fVzv83zMymDsRX
         1qrn+koBA5ex4K3dDF0QYhHc56uAqHiRM6OIDLgzhtp1jpswVE9dKA5VU43IH4PR4PxM
         G3t9zI2cftnG/bVhkAMewxJOTecsfyxbw+/gLlhrTs/IEh+CI69jHmYi+lNLiJtZg/+m
         4J3ogY8xF8roffMtybaOz/QyRuHixaK1iSrl7cPnIt/uMsOcnuoy/Z+UdshEdh0pdDjY
         Z9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991520; x=1792596320;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xZlacUVzzy4HBA3NrxiUhpJFwP6Wb2PV4OZMdQ09R7I=;
        b=ciYHG7Z0B1j2sls2TID4CLpWN8+T7jE4wR+GJy3wW75HcP9IWg022C7DQLTdiCYZY2
         8bT7BwtqP/nqejO5ufpuCbZexwG2ps8cKo7NjFg5dmoQMjbFAAtpqovgOsl0froyzHNL
         8W5FhwmvGAp5JzpjLtfMU2IB3fXxIwi/pZieHUWGp6S6teNKULgkLMEu//RrW3VfJ8li
         NmvQK4Db78VggNDDAgTGZijw5kKobVZHJEa+JAWDp+MdQ0JrNDEnVHCDNl6A/w8i9k/K
         HSgSbx0aYgdwT4913fs/ZAiYniwN0Qq2dHNIpMBUrTkjrj98sssGXI6ZFMBsmg0tz4F6
         51gg==
X-Forwarded-Encrypted: i=1; AKwUvBzNCL6MsM6xnWjuwGDJm9yQPi856NUM75Zrexmw1236N0ymbU7p2zuJWpW28h6/SrFLPlwxEW0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJr+WyjlejAeDU5K0ctj39XYEOdtVwRt1fVq2r+BORACrOGyntP
	nfvAqitMOW6lhbb4eI/lQYdJH06XGro7g6KnE1XzIXBfcmjQKYr6CMTD
X-Gm-Gg: AYBFou0T1jvZ7QWKjgcnxoO5QJ6MqMft9U43fxI/LDlFa1z4xHVOkw1ijemUZSbWFJM
	CxEdqeECVvOd3EKmtaqXvboKzJO5rUGNfNGefkugZ+RjpgRn/smZF4i+8FLiOiG+4pz6S9YqrEb
	qMHBK5ywV5i3Vglb2Fk5usiEdN4gI8cv0YVDSMSW/uCWQSfEu6acQbV9mi+EGg07ln9GocGo/Aa
	VpuJEk9p3x4HKGAuKHrBv0GXo3GYvGBlM1x4hk5mh9MArX5PHkTi02KgIDM4XvDA9KFguxXPYW2
	OT2ENRSbn0aNWW0ElOPXnAe56IREYybecW9czdzTgKzKXKFfFn5MLVVyOiY4PCOXZzDuxnmwEpg
	xr+dqd42Fv5hhSNb7m2oKMxYbYTGqmp+8QOfRJziMFsRw/UAtFzgNM5ljO0XzsT5uePekzkzbPv
	6F9FkOWmQ2dZmwdNvU7PTMnMJrM9Bh2csobTo6lli2dWC1kWjYr74/hO1/LcZvnf2DZOMr0nfEF
	yXw8jsK7L33EmiqN38gxg7qVBoY8gPrPga0MG8biiJarmOo/yeTuK3ZAlCyVVbGnHEneCnzyAcj
	G+pxdxWDowof3cI2Ar0QDPhp9IDvZCY9GWnBpM76SUS6jhk9
X-Received: by 2002:a05:6102:4193:b0:7a7:12b0:fd03 with SMTP id ada2fe7eead31-7cb50ad7b90mr3825371137.0.1791991519989;
        Wed, 14 Oct 2026 08:25:19 -0700 (PDT)
Received: from debian-t14-gen1-fuhrysteve.ts.fuhry.app (235.sub-75-230-129.myvzw.com. [75.230.129.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b5e5b1sm54887516d6.18.2026.10.14.08.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 08:25:19 -0700 (PDT)
From: "Stephen J. Fuhry" <fuhrysteve@gmail.com>
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Stephen J. Fuhry" <fuhrysteve@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: input: ignore the battery of Keychron keyboards over Bluetooth
Date: Wed, 14 Oct 2026 11:25:05 -0400
Message-ID: <20261014152505.2523337-1-fuhrysteve@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keychron keyboards identify as Apple's wired aluminium keyboard, rev B
ANSI (05ac:024f), when connected over Bluetooth. hid-apple has bound
that ID over Bluetooth since commit ebe0b42a4252 ("HID: apple: Add
support for Keychron K1 wireless keyboard"). The Keychron K8 tested
here does the same, whichever position its Mac/Windows switch is in.

The report descriptor declares a battery, so hid-input creates a
power_supply node for it. The keyboard never answers the battery
feature report. Every read of the node blocks for the full 5 second
uhid timeout and then returns -ENODATA:

  $ time cat .../power_supply/hid-<addr>-battery/capacity
  cat: ...: No data available
  real    0m5.10s

Anything that enumerates devices pays this on every pass. With the
keyboard connected, "udevadm info --export-db" took 10 to 26 seconds;
with it disconnected, 0.11 seconds. KDE's Solid library enumerates
devices on the GUI thread, so Dolphin and the Plasma panel froze for the
same 10 to 26 seconds. upower already gives up on the device and does
not list it.

0x024f is a wired-only Apple product, so a Bluetooth device using it is
not a genuine Apple keyboard. Ignore its battery so the node is never
created. AVOID_QUERY would stop the blocking read, but the K8 does not
send the battery in its input reports either. The node would then stay
at its initial capacity of 0 with status Unknown, which looks like an
empty battery.

Cc: stable@vger.kernel.org
Signed-off-by: Stephen J. Fuhry <fuhrysteve@gmail.com>
---
Tested on 7.2.6 (Debian trixie-backports base) on a ThinkPad T14
Gen 3 with a Keychron K8 paired over Bluetooth: no battery node is
created and "udevadm info --export-db" takes 0.12 s with the keyboard
connected. The keyboard types normally and hid-apple still binds it.

I have only the K8 to test. If another Keychron model on this ID does
answer the battery report, this hides its battery level. I do not know
whether any does.

 drivers/hid/hid-input.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index edd6bbf..380ff8a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -381,6 +381,15 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	/*
+	 * Keychron keyboards in Bluetooth mode reuse the product ID of
+	 * Apple's wired aluminium keyboard. They declare a battery but never
+	 * answer the battery feature report, so each read blocks for the full
+	 * uhid timeout and then fails with -ENODATA.
+	 */
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_ALU_REVB_ANSI),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
 		USB_DEVICE_ID_SYMBOL_SCANNER_3),
 	  HID_BATTERY_QUIRK_IGNORE },
-- 
2.47.3

