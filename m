Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326678;
	b=4Cvw7DkS8ZKIgnNn/wpyAoSu9D3n+nrxtfetxRpO2069J6v8K4O3qjQFLzhvh9LRSydm
	 HfzjOSFXCxxcdEL8P8AKOLcWdpNl9eztioXJ1fK13eyIgN5Xiypa2FqtoLYB1qj0+1Jqr
	 H91CJCWzD7CsUWsmLh5RUOPHgqJOlbWluF1EV2Br0saGAiw205JIYUmqAsFdVqi0Vx7HT
	 /MiGgQniJebGwg1vjGv5poN9ICEptAFp/NSVbzebPQrrVJiA812fgT1yYpvirYzO03ef8
	 x7lbOarV6M6H+k+nxn0Q5JbZre3FhkFsEnloiylK6X+0p1O+LGgIFnDaYUQYc4fV7WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326678;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=i97+GIW9Hh9sCNQH9Swro3UvlSWHzf/UNcjDp3k7ORo=;
	b=wW9VcuF83eKpEx+m3Z+S545tzDYghdwHAxqC0EW8Bdt6ShEQGfpDSjNRJ+mVuOszHnFX
	 TvzS/tFxXOTSCKT/poRt83cDZZb0u2T7iFU6m08X3knFVmyPkevP8dyDDFsMcjnKRuADN
	 xQdC1LToq2chVgm7KVYT/4kVtcDuIDYGO9WuUS/4oQGIGSg+20t16/ag1zfG5lgmWFA88
	 gGdapqzYaCxzLO0myMTSWRWynC2hz6HlnJvKRwHoc7a2cbXCj6H3aufCqbUu351JK/aPw
	 3KPZGwSe3paqGqcxkL4YY0oWsBQrCBQ8K3JuiawCBw0u4eR+XMS+zmo0dyK6i+LAOWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFj7hNjZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1E606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFj7hNjZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D1F1F0089F;
	Tue, 10 Nov 2026 16:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794326677;
	bh=i97+GIW9Hh9sCNQH9Swro3UvlSWHzf/UNcjDp3k7ORo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFj7hNjZcyPa+SzH/HyMHanEOBv1Z/gSb0c2wjx6ZmsDrZ6+0nRCJJPTZMWLWYd7U
	 r2PqQbzq3G6NgbcwHVHxdxRI6e3adRSngMzNiAbrQxFitz2HuVXL1NcdspgEtRIXqD
	 IUOxEUzVY+VeKSqtfwBpW0hpTiRPsAKB1DW6ZyWu0fYzRolQ868Pn8ADbhZ1RZmiCh
	 PyXxBhbVSQ6qIxgWQpMdkA+3bH3lIjS4zyXcqawO2+uI8V898c2b58kwt5RXCjL4fY
	 LwkPZ8Ufpd4FpHmfAD+6QEIF23kc4CnarPc4jUo7X63c4bPcOdmKhq4MGjdLnk4MUl
	 KlWLpDeyQ5FcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Tue, 10 Nov 2026 11:04:35 -0500
Message-ID: <20261110160421.2032791-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062007-failed-5.10-874323b68c93@kernel.org>
References: <20261107062007-failed-5.10-874323b68c93@kernel.org>
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
[ sashal: Replaced the quirk flag table entry with a USB_ID case in volume_control_quirks(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/mixer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 7f64199139d31..48178272bf422 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1163,6 +1163,7 @@ static void volume_control_quirks(struct usb_mixer_elem_info *cval,
 		}
 		break;
 
+	case USB_ID(0x046d, 0x0802): /* Logitech Webcam C200 */
 	case USB_ID(0x046d, 0x0807): /* Logitech Webcam C500 */
 	case USB_ID(0x046d, 0x0808):
 	case USB_ID(0x046d, 0x0809):
-- 
2.53.0

