Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA783559C9
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792363634; cv=none; b=VGc9tC1C47z2P1PrrTUhZVy7yK/+8BpRaSBJy3lKYUymmVLikkN5/sSdxuTwM3s24yRc6ZYvk8r/FQ9xXy6jaCyCKJKklMZMIPsktm7zyUXg3weFCEZPyNUQm7ooozo/mn/XJPZp+Wp5dmlgGT3QGJ2mEWcJRgyjnqOyWvtFY6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792363634; c=relaxed/simple;
	bh=j6r1yM0Nj2g7ZVK6IoYOqBzm9qH0abhm+U7Ll+RV5so=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WNOVybriaix/lCYP3kocF8hBL5uAel5X1KAbS9QomFu56Ylmv2X9dyYeFNZvsFsVAhCCUtNvYWnmqO4RYXduE+a7EvtF1YzhS2sXjGwJJHfmbCP8F2M42oyCRB7widnVkM0iiuQbLxbON7leI5UyF+0yyb/AwEYBPFk5DL7P4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SF5xvDTN; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SF5xvDTN"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-35829219da8so2917711eec.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 15:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792363632; x=1792968432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SRaL3m+hn3zzK9EEds28lDnI6OFgmnj9tIFxBXhk9kw=;
        b=SF5xvDTNo+3n+HfbuJxjOMILj8uf6e09EpbK4CuDoHWrBrTm7ccWV6RZ5dH1w0xBDe
         zCOyYjEo9Tz7xgedOtmCzJQulLXTVBoUaG50/t3USPbWL8wg+53AGgEvbNWYj6j4YQb3
         aRE3ouVzH9M+uEAABBFwqQ2nCg9Nt7JFnSwPj5CDM8p7rzZuSzGpZwVrdR5wLOGHNj9l
         t/AplPLN0K0JPhxeUs6jZsj7EKnmNT0DTfC12Jr+tnnRTBeJwUp5EFEaIyiaPQqy2r0Q
         Z1iSDej8wvEtq5IZ/JtNq1fWOPy5oDOyZoGFFVXGKGPb716PcoS0NJBSRAyvEEz8/nht
         rA2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792363632; x=1792968432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SRaL3m+hn3zzK9EEds28lDnI6OFgmnj9tIFxBXhk9kw=;
        b=YtwEeWDj6baRdMi33pn03hzdq0HMbRoA/aY2e8iRZVl3Nui4qKkcgN2PVoHys5Watp
         wiObd4Gg1CvHJbfxLTFP3VJKDcdeBa3+HpmcGbInW+vYA5bcpl79Li9TCvAzEyZYhZrZ
         cyPzcu44k9h4M0Ad1jLywXPRqqui01xSZMZdNyypMX19E9dwYw66Dop1XCKUE7pZ8coi
         KQv2gvKLWV5bwLbjQ8ONori0f5jryZjHAezK+85JrJS3ljQqwRsOYmTHBfgO0RTwwr/K
         nAaSQnBDUH8JtwZbnkkicPMsIFtgFwCTRZ2aLV0U5OKnSwfhYpjwW5JFcXCHZbWyZ9nw
         QRFA==
X-Forwarded-Encrypted: i=1; AKwUvBy4t1m/XpQTNM/HWQcj3tKBN+gpQBnEH/BqmrWXbQmGN8IjlrxbARl/BlrGL07MeL86Mb3FURk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI4IRnc8BesB9fFBRPMgPg3cAMks8onHqSdFuwPN72Xj+eCtboc
	v7O6jQc2ivQRz6DDUEuhZpCM3OkqeMVFOBXzDbIQntIBWPTY/t12LTrj
X-Gm-Gg: AYBFou0L7CtIw+7leg+eKAA2Y5iOL/bIpg6Uwjh8r8Arz2TaCDqf4SXS2RGdeUfOgm6
	M6hMOyFwdIDCy6ua+bmIDk5An9cnpJHX+I0zrF3oWtHe/jqc0kcFMNf4I+QkFudf97674zN2/dE
	McqJHkrlobiLUZMgKkBOIO51pHUEbs68HPleDg7Xlq0v3aWcUb1jzIIqXFmOlSbs5OzJy6oTAol
	Zd2VcVE5+sCnPFLKJx6Bwtrq1gF5IDW/vv//P0FrXDTwmjhOvEjE5bmaFKUP83ZZ7EoM4GtMml/
	W+0t3+FX+UA81CTfpm6Mg1nZOyHY+87N1WOeGQggxKkmxpFvB6t7fV/YFV5gjmGo/B0neeC8qi8
	Nukr4fldWOnP0eOxmECRxEO68kQ2McEBQowMFb2mMjTVR4RmagoZ2j7tsK+x8KONq/RoY92TYlH
	zbSik4XeNfMpFwccqdDeupUow1LYfkla+799/MHH0rmEjX19pHlJ20cs/05yRIJPSIPq7yc5m4X
	OwKDDPBoyZTd1LXEUvT7os6zUk/lT/FX3SG3xXIP58=
X-Received: by 2002:a05:7022:438d:b0:143:1bb1:3305 with SMTP id a92af1059eb24-1825b20a2ddmr17210769c88.22.1792363631761;
        Sun, 18 Oct 2026 15:47:11 -0700 (PDT)
Received: from siegeengine2 (c-73-158-156-210.hsd1.ca.comcast.net. [73.158.156.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a02b8sm29221886eec.17.2026.10.18.15.47.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 15:47:11 -0700 (PDT)
From: Mark Pariente <markpariente@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@riseup.net>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Pariente <markpariente@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] HID: logitech-dj: Re-announce connected devices on reset-resume
Date: Sun, 18 Oct 2026 15:46:27 -0700
Message-ID: <20261018224627.60328-1-markpariente@gmail.com>
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

