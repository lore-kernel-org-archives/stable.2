Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322722;
	b=C5tAzlfem1jqF/CxJBOBSu1QTzSJZcpxvFRb3cNgAAAO8BtNFTyN/l39HLxFKbxVpwop
	 pFjptBXI11mAkMa7dLgWYnIEipVNwFnpyrtUs9GDwiOvxlOq3CVv9DSfB5Upx4kIN+IV3
	 bjiRSfp0Sh/RRSwsrmPJm1qBnqn7LHbrYDLHbsKZOKkjCFE68+D5Cezs2VjXcnOve/7he
	 KuaWBqjf8UqORp8gcLKnDyYWXB7Ej9t7l4TQ5UWzuM8TKGm0ahudfXYath/EY3NvEfzL8
	 hTpkzVgDGz5ZGSczc0WELqA1dgV8FTWIvf+Unm0NNr9SUfXormtDYURnmVus99/XB5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322722;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=k3X7KTbafhEj4o/vNSx4l13TgV1n6orwx43ZlhXLS1k=;
	b=iJ7qOqZA21YvyUOIIvPihdEZJZ6IRq/QE6cCRHS0EXQERVHvTdrNoW01L/ZkwPGLGqMD
	 HttICyY3di8g1PBOExHZAcIiT4T80OulGqip6Wdwy9cbZ6h1Yz4rsjE7jhQ+lZDhXeTEq
	 lmr1j38u4DYn4tx+vFmv25j5PdUxq5+GyKFvOoP4vNmjQ962fYR7BGCbH+8sdgppera6p
	 WJ44GpBEIYa/VLwjfhtfNvdkHpkQf4M7Fz9uSTJmjsxvqsU4/vZO2OqFreHrlhoQDvmcK
	 htjyx2Ep/7MLeS1Cf1qJasrqPTgUxf+BL43JCmvgq7MpwGP3VshOiFOY9FlN3hfTe/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVWtDAj+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A59D606A323
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HVWtDAj+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351EB1F008A7;
	Tue, 10 Nov 2026 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322721;
	bh=k3X7KTbafhEj4o/vNSx4l13TgV1n6orwx43ZlhXLS1k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HVWtDAj+s4NkkJugg98NKjNzLWhiu8DsDKj492/vm+p9X7Ip4G0stoDlQ7B9+iZcV
	 6jST4ScBXnawdc9/A/X3dbrXSTeeUfQaukHkKDmilSopSgklGSt1FldVlO84ixa6tZ
	 cb9gfNcPuOI3vc85FtEvM3c9P1vsnAfVtfZzFw5IcJeo3JWvImePPnpAxBh/bE36Fd
	 +MlkuneyxcxzKKpkVVQjonkFCks8ugw98Xtb0s9w70TLkn9d+Nk3n+RZEWAbQIDAGQ
	 1/Q7thaaJ1Qwabt+f6rTxjmEkH2jdWRCbIamRkGJ1f1F27/BGHhdt1hP4fTmTmYJBI
	 Fy3AfRC2fJ3vQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Tue, 10 Nov 2026 09:58:39 -0500
Message-ID: <20261110145827.1816925-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060327-failed-5.15-874323b68c93@kernel.org>
References: <20261107060327-failed-5.15-874323b68c93@kernel.org>
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

From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>

[ Upstream commit 874323b68c93c6808e034dc0113681e822e6fb42 ]

The C200 (046d:0802) reports a mic capture volume range of
1536..7680 with a resolution of 1 (6144 steps), triggering
"Warning! Unlikely big volume step count (=6144), linear volume or
wrong cval->res?" at probe and exposing a uselessly fine-grained
mixer control.  This is the same firmware behavior as the other
UVC-era Logitech webcams already carrying QUIRK_FLAG_MIC_RES_384
(C500, C600, C210, C270, C310, C510, C525, ...), so apply the same
quirk: CTL_MSG_DELAY_1M (which the Logitech VENDOR_FLG would provide
if the device-specific entry did not short-circuit the lookup) plus
MIC_RES_384.

Verified on real hardware: with the quirk the warning disappears and
the driver logs "set resolution quirk: cval->res = 384".

Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261008230844.11246-1-olivier.kaloudoff@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: Replaced the flag-based device entry with a USB_ID case in volume_control_quirks(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index fa2c740249e33..fdd3efd297c2b 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1169,6 +1169,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
+	case USB_ID(0x046d, 0x0802): /* Logitech Webcam C200 */
 	case USB_ID(0x046d, 0x0807): /* Logitech Webcam C500 */
 	case USB_ID(0x046d, 0x0808):
 	case USB_ID(0x046d, 0x0809):
-- 
2.53.0

