Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932DD3E172B
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 23:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792366055; cv=none; b=uz/7HMu5DmWR/iHuck/LB6Sl+UNNf5ZdmpTERpOHvB2esFKDa5o9nI/xhlhOqUlXfsFDlvn9AWKJVzwinc1HkqHLqv2auQx3HXYQifsXJrxl2Oa5LgSqBlG/HpCCyhWMKk8/q10kdYWXv54SBEIBipLwd1mp1eVW4z/USe+jvaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792366055; c=relaxed/simple;
	bh=QhtqZ8JvQkNYctbC8ezaeTjXmAvSIP2MXRV9jfw2V/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GA+LksIVO0zfGR7/E1TU0MFs2L9CN75CQu7oHcPNqWQGyOJxPj/Fn428MH7ipcZ6TZxQgbYA/HG6RRSIgfD9eUiif/3jSHkiPNHynvAKnjBIJZMyLtIg90KML6rk1dYbNeSYVyeBbsdiF1/IXgs3IMRp93lxVM7zawQDCKbAAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv18tJBL; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv18tJBL"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35943f55c06so2262247eec.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 16:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792366054; x=1792970854; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QWI86/f7dXA4qQFC/2INoo9kMVa4RadmnPFerxfI+FA=;
        b=Hv18tJBLQO3Qp93x/LuYf6SydUKBxNuNba/pcuy31gxGzBY2YtnrbNigY1nig3636J
         dL72i1ftSqvDUIvS8U/GBfIsKvocSvyeVxTpdu778ym5uxBYY+ec+Qt3whtn/3Zl3XBv
         GUQax2CKBXhwAxnEbKHtNihbMcGk/leileTC1rwQhq42IUnuX9mgFQPB6KfMuJeQbIh5
         nwj4CNtQHW0E/GSPFV0ZWxUGB4M/4dlUhE61PR/r2u36ZUoOao73IFvQE+CNd1Lr2NR4
         XaJeBntiMR2PVDIH6OXV0Y49LhS9z8LbRLYUAVoG8GaTaKc8QTdMSsB9m29CZ/uV1VaZ
         uleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792366054; x=1792970854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QWI86/f7dXA4qQFC/2INoo9kMVa4RadmnPFerxfI+FA=;
        b=JceFPcqfDq5pndsiRDYUbFy4yyJBlgqBO7kFBbLawsU7dAJ8ZpN+53HfMl8LI/k706
         6vekdhmCI54ydxvSGH2Wm/FwjBBKQEGwtYclx5k4i/3c1nMb2bH3FQeZYb2j3hRU3h49
         ahk6LA11oZfJwFLqdTm919bj5OjC9wJeB9FdTyQiE55XQvTzsKrCBjSjBrHMgDYF60du
         KxOVQzzuv49OWIUpJLiQvnqbSbgQjB4hvWaUbz9hG4ds0tEV439IHlwH9ssf+ElfGJmJ
         DQ/W+HqdH9Q93JhssC31GsLhrGmIsViOtgX9LBqK+cpeqIla6UIb+uY2VRrhBZuNcKHa
         mNIw==
X-Forwarded-Encrypted: i=1; AKwUvBz1m2DKlOE4K7QveOAcyN0eaOe+G7wnCc7vjm0LmVVr/WlnwcoasRZgHZPWnBQH03wy50olObw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoje3ogiWAJ7IJUJr9Wp6x+YzOk3IiERjnyQ6MGxfSjaEG+rQ/
	7s9w0oN5YgcZGtavqFF9c/YC2WdGtcMU6L2tWkI73KKa2lfj1t3KiRVI
X-Gm-Gg: AYBFou3HF//FY9ZIIdr/ZaM5KRgnj4AbnGda0wWOSFPLv2pG7lmdGo2qThj/bLOthvn
	Z/yN+jz0pDQ6YSA+7ufCCkwxB7qMGHPCy/yxyXHBy2KocWP1PRIDFy7iCcvZkxT12vKDrXYUht6
	b+fd/GcoN1K7KAJaeWqEwcCuQpF7O6a7+wKS8/1TI3b6MX5RiopDZwHItKOcfa8i6FWqmmYt9bp
	hmienNRHglyRkrfDISlAQ0rGWrSdpT9NwhMSWarNOx36Sdjh9gAjLeF4AC+SnZTNX1DG1Cxvm+f
	ZbAPYqoTjLhdL+LODChwAYKUTLYz2W3DBagm+CPyRxPg59BA+yLUAIYK0mgM2QpeoXHcuDgx+Uh
	PEIkoJ42zn9pNq7Yus0Qp6RcC8Y0dITNeV/AEbpFYjSvylrwQGcoZn+ewLs16IPhTZ8/N35k9wK
	MfeIZCa1tpXeUlJydgmC5WAcYCNS/rX7rh2RGwJKd83m4UeYno7rg/K0D2NPJXVBeNKR3UaMQQ6
	1QqdKcTewAL/qCwiBWw+AaIFGk3IQ5YO3QbnMfg7Quwv0jGWkQTBQ==
X-Received: by 2002:a05:7301:2503:b0:359:fb64:11d7 with SMTP id 5a478bee46e88-361a2b3bfdbmr7682577eec.11.1792366053498;
        Sun, 18 Oct 2026 16:27:33 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360813b6ca5sm25571908eec.9.2026.10.18.16.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 16:27:33 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>
Subject: [PATCH v2 2/2] HID: logitech-dj: Re-announce connected devices on reset-resume
Date: Sun, 18 Oct 2026 16:26:54 -0700
Message-ID: <20261018232654.70571-3-markpariente@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018232654.70571-1-markpariente@gmail.com>
References: <20261018224627.60328-1-markpariente@gmail.com>
 <20261018232654.70571-1-markpariente@gmail.com>
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

On Unifying receivers, slots without a known device are then
enumerated through DJ notifications; this depends on the previous
patch, which stops HID++ connect notifications from adding them.

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
 drivers/hid/hid-logitech-dj.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 383c762c503f..4230c47713ee 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -2016,6 +2016,16 @@ static int logi_dj_reset_resume(struct hid_device *hdev)
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
 
-- 
2.56.0

