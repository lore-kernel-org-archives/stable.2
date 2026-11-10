Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314555;
	b=Kmp2QA/xDIhdpcjjmIbecCGDK/nSkI7mE328TmDP9dwZQzK1IXSVr/qWTSBRhepEw+EL
	 zksZoWDJ23fqO5UbDxq9AcSh9FavVE7Cd+vRSbO4oWD6e73VniHDjxP6b6eJ/DtoY0g+W
	 +Y2NXs9F1NimAli8T0NDaVGRNYC5I2Jd8KNLvh3i4IOL634cqFhBDzwWvhgrwdTGQ5ED6
	 CwcOQG9BjJimY7GR0SLCb5AlPRFvQ+GcfngY9to+CvY7TPrFb9xt3lCHspsttOqBqMX3g
	 ggoi/kyNEAoPEt2goIK6IzwnFgTrZT87UBm9TGeMuJdXUaxXox5SAWtEfKR3YaOB0Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314555;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fO9BO0wbmDeL50UnCAUhyfaB7huGMM7FTR+c+p07gCM=;
	b=y9uT3u5kuswEqmB9gis83BysuxMqkz6rchLFHOD121f7U/l5QY0DP2YOL0rGR2nGmzmS
	 FRNqvldhJ0J0tlFaTFQy1Ra5mNmzjbeQNXfump1Vc57IhMQwFGdYndTSuzr9DSrmiccd4
	 bOQahF160k0/WIoRWhXXMO5r1Mcnr4JocDosmb+wfwz1yIFSh0bgaqfwbd8ZWp0ya1U9U
	 Eepcq3Q8egY1UGtA9sd2UvExOy2VbNNL09cjdOoN9JQqb4gpiX2P0Sx3a/RlKPT/s4iRV
	 911hC8tj7676bVszcg9Vv06f20cPOvWfzvF6K9YxFUjEz3jZ6fsrcZ/sXDdUJGuXPOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZbqyunQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3135860A2616
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZbqyunQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672821F008A1;
	Tue, 10 Nov 2026 12:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794314555;
	bh=fO9BO0wbmDeL50UnCAUhyfaB7huGMM7FTR+c+p07gCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZbqyunQN0B/EDpkKw98uY89r4wSdFtyjwRYAzSk0h5jK4fVS3VpqslOjHz0Ur3eJ
	 IRFI0oEiOuPbS5SGkk+lWXIz5uuG3AfpMC+u2rG3LgBf8Zntw+wvDRnLFDY05DY3y4
	 ptvfvAz/0uZ2SrLMK+ygotIZ5uj5qMfJudERUwVh7DVPg6cfqIlFGcIhes7M0rbHea
	 Xn0C3pKEcGrjLcWFO1V65Cm1eHAF0sZv7Ellq8CHTQS6fQkngnG0DD7o5y5j4Vz0/5
	 H9sBvkMOLA/4nCU6UhJGzZp3Tde4nZmmOHrVdvQQMDikLJ+wuME3PKirStGhqroOaT
	 aEKmrhnC5F+XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ali Resool Tuama <aliresool567@gmail.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] USB: quirks: add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for GameSir G7 SE
Date: Tue, 10 Nov 2026 07:42:32 -0500
Message-ID: <20261110124211.1465892-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110124211.1465892-1-sashal@kernel.org>
References: <20261107054630-failed-6.1-40224df29729@kernel.org>
 <20261110124211.1465892-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ali Resool Tuama <aliresool567@gmail.com>

[ Upstream commit 40224df29729618ecd88c5c0077e71b1e82c7a3a ]

The GameSir G7 SE wired controller first enumerates as 3537:10a0 and
then re-enumerates in a mode it picks from how the host enumerated it.

When the configuration descriptor is fetched the Linux way, 9 bytes
followed by the full 80, the controller disconnects about 1 ms after
its string descriptors have been read, before SET_CONFIGURATION, and
comes back as 3537:1082, a generic HID gamepad without force feedback.

When the configuration descriptor is fetched in one 255-byte request,
as Windows does, it comes back as 3537:1010 in Xbox One (GIP) mode,
which xpad already supports, including rumble.

Skipping the device qualifier requests (USB_QUIRK_DEVICE_QUALIFIER)
makes no difference; the configuration descriptor request size alone
decides the mode. Add USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE for the 10a0
identity, as is already done for the ShanWan Wireless Gamepad.

Cc: stable <stable@kernel.org>
Assisted-by: claude-opus-5-5
Signed-off-by: Ali Resool Tuama <aliresool567@gmail.com>
Link: https://patch.msgid.link/20261002-master-v2-1-24b05d8792b5@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index 23d5c30332ffb..ee439a2ddf316 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -607,6 +607,9 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* ezcap401 - BOS descriptor fetch hangs at SuperSpeed Plus */
 	{ USB_DEVICE(0x32ed, 0x0401), .driver_info = USB_QUIRK_NO_BOS },
 
+	/* GameSir G7 SE */
+	{ USB_DEVICE(0x3537, 0x10a0), .driver_info = USB_QUIRK_WINDOWS_CONFIG_REQ_SIZE },
+
 	/* DELL USB GEN2 */
 	{ USB_DEVICE(0x413c, 0xb062), .driver_info = USB_QUIRK_NO_LPM | USB_QUIRK_RESET_RESUME },
 
-- 
2.53.0

