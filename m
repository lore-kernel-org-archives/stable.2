Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117038236E
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363436; cv=none; b=WYBAHl5CCYzL0SIe9v6JkTE29Ymi7syaKTL0oQWUZf3TKdW20VP6Ak8uzwHLvRd6+E4B/Xx8cNX4Rjb6gJtBIHkLXya4cd1XU/oBtnJ2KPS6uIk14/Idridc08mVY5/D2YxICtPhuhRvHpYEOvOBrVXo+veoHmBNqrr5MlOSLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363436; c=relaxed/simple;
	bh=j6r1yM0Nj2g7ZVK6IoYOqBzm9qH0abhm+U7Ll+RV5so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvX/XSlnz1FE+dTZgwERjtgSC1TQ93MrrKwMGvi0NWasHbptietklm2tHW7DcnTsoB8HJBXUokPHo6Q23pfjwmJYaucMwqT+QhzjrI75bkALWuwv+e4XekpgS2Zyz7RVWFONIWK6HwVoJWqbAR+kMoBgnqjC62AkrvxWiB9nxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMCv2C6g; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMCv2C6g"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-354ba08cfd1so2620056eec.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792363434; x=1792968234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRaL3m+hn3zzK9EEds28lDnI6OFgmnj9tIFxBXhk9kw=;
        b=rMCv2C6ghzAKMr0zyRfyNjMYktE/0iE+jUs9+LLtOOWhB4M0nx3UmXsU9nEmzFdO9u
         b7ItjVClZ72msV8dcrFuseUA2lGC4nGoeTHy5+mVH+crcg7D85jL26qJskroJcRGR17J
         oU6ZLGumZpOzH4yqKmSwsGjvNEE9r9fK/KiYTtWdzn73EeAO8rnRS61Ym5c/6ieFxsa4
         V8xJb7VlAUjBzq1JWUsPMG3sg8dWhIidHQKS7vKAoArSwN7bbphrtD0Mgh7Z5McnOPoZ
         Y92TeS2959q/qSPQUFlyFNIWlUwHGRwNlrc/JnGyqyaG3ahulSbhfgHzmA0Ylg1kHnaI
         LeHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792363434; x=1792968234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRaL3m+hn3zzK9EEds28lDnI6OFgmnj9tIFxBXhk9kw=;
        b=oUrXy43TYFOG57K5sjacreqBGcaAnv35ImvnyRhZao1xzQqC9aA6bgGMf0yB2WAMMX
         Nzfq14i3dt6IUYvrjWTVWh1234rTVSBlv5/iDpe2V4uA1FOP1xsInha7wOR3oaKHD2sB
         9/1Uhnrz4jnKZR+aEMz9Aybi4XCdUXZRV6OPSeOx6EVJfqvXEjnhn85JiWNZfSvwiwL2
         2I0LKlYbGJkGfJRJiWPNK220kURHT38fotgrJQIxbtdu593Cl/O8IJTiNYJwg+AAfWoo
         ElEM8sI128o+vkPd/mtnB7oiK2K3oqnod4/sFOcw4qiq7HIviR418jjjI1gB5yb9ilZa
         s3zw==
X-Gm-Message-State: AFq9FYIuj6BOiRg9XbGXyQyKnIhuml4iRORRe7o+8vQt6f7IcBCgBZpJ
	KiQrD9zf4+LQjklI8c/IIPeILf9r+YPAJ145EgXhOwNhn2pCK6k3rzoLIdtK4w==
X-Gm-Gg: AYBFou279ERsjUmiNJXwVcfFMDOhRSVtRH+1iSo7bpbrZoH0qLG2dw6a2rkp5BKb6tE
	BE3BSVXV/g+MbxofkygRqO7GSnPTtkTGjJTPBUsBvIKx7fmJa+XBVKb0Fra84Jg5JCfkUBAc/Mp
	QU65CRgGaVia9fGJWFR1iXimVIDqiDtxt8QAP2NuvNxrZirxYM2rgtdSFwqnkRkhaqeaBfzgLhR
	WBP+7evW9n19ZwD6FbUKp+M3syrnozj/r62lZXU+OMOK+Oz0OJuBw8j7YJWGfc6AeOwYmIN2H1q
	MpooU/Wq4Am1cHnXx+jW0KA55aMJhp6fnQpYB0xJqEI24aVL/fDQHJXc6l7LmERA1gtQa6rQ+Y/
	Whc652mXiAUIc/DEPonWfFx8Y4f0tZCtqY+dAtbWkDjOAZwObASA/f1fwU+aUFpNQ3C0GPCHyjg
	tZf89KXpGLwgY+fBJAiXowbaX8Nht9PSy4HRK6vRInddNpNT62KxyLa+Ttm0Aw8RabKr1XtKRUp
	PAoumhg2SMym1CMLkEKR/2bqI8d39y+jveuhWp3ktg22Nh+YC3UxA==
X-Received: by 2002:a05:7301:d813:b0:353:7b68:4f6e with SMTP id 5a478bee46e88-361a0e86000mr7261093eec.12.1792363434201;
        Sun, 18 Oct 2026 15:43:54 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm48425750eec.24.2026.10.18.15.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:43:53 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: markpariente@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] HID: logitech-dj: Re-announce connected devices on reset-resume
Date: Sun, 18 Oct 2026 15:41:32 -0700
Message-ID: <20261018224132.55912-1-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If a receiver is reset on resume, for example because a USB KVM switch
moved it to another host while the system was suspended, its paired
devices may have reconnected to it while the host was not listening.
The connection notification the receiver queued for the host is lost
in the USB reset, so hid-logitech-hidpp never re-runs its connect
handling for the device.

Devices drop host-configured state when they reconnect, so whatever
hidpp configured on connect is silently lost. The most visible case is
HID++ 2.0 hi-res scrolling: the mouse reverts to low-resolution wheel
reports while hidpp keeps scaling them by the hi-res multiplier, so
scrolling becomes extremely slow (1/15 of the normal speed on an MX
Master 3) until the receiver is replugged or the mouse power cycled.

logi_dj_reset_resume() only switches the receiver back to DJ mode. Also
ask the receiver to re-announce its connected devices with the HID++
"fake device arrival" request, which is already used to query paired
devices on non-DJ receivers, and which Solaar sends to all receivers on
startup. The resulting connect notifications are forwarded to the
existing child devices, whose drivers then reconfigure them.

Reproduced with an MX Master 3 on a Unifying receiver (046d:c52b)
behind a USB KVM switch: suspend, switch the KVM away and back, move
the mouse while the host is still suspended, then resume. Without this
change the wheel stays in low-res mode with the hi-res multiplier
applied; with it, hidpp re-enables hi-res scrolling after resume.

Fixes: 534a7b8e10ec ("HID: Add full support for Logitech Unifying receivers")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=203421
Link: https://gitlab.freedesktop.org/libinput/libinput/-/issues/528
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Mark Pariente <markpariente@gmail.com>
---
Tested on Fedora's 7.2.11 kernel, with this change applied to the v7.2
driver and loaded as an out-of-tree module. Only tested with a Unifying
receiver (046d:c52b) and an MX Master 3; Lightspeed, Nano and 27 MHz
receivers were not tested. Investigation, patch and changelog were
drafted with an LLM coding assistant, then reviewed and tested by me.

 drivers/hid/hid-logitech-dj.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6e8db01d27ec..cdb20fdc7b21 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2010,6 +2010,16 @@ static int logi_dj_reset_resume(struct hid_device *hdev)
 		return 0;
 
 	logi_dj_recv_switch_to_dj_mode(djrcv_dev, 0);
+
+	/*
+	 * Paired devices may have reconnected and lost their configuration
+	 * (e.g. hi-res scrolling) while the receiver was unpowered or switched
+	 * away by a KVM. Have the receiver re-announce connected devices so
+	 * the child drivers run their connect handling again.
+	 */
+	if (djrcv_dev->dj_mode && logi_dj_recv_query_hidpp_devices(djrcv_dev))
+		hid_err(hdev, "%s: failed to query connected devices\n", __func__);
+
 	return 0;
 }
 

base-commit: ae6927c533a4454570950125ca8ba909c45f20f9
-- 
2.56.0

