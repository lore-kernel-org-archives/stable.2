Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C518C008
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 23:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791500930; cv=none; b=MPYVeZxx7B2efBNVm8f7bKEYIWhBGOWNUmktst9/xZ8drmBmNuvfZ2ky0h5nIg0CTz6cAIJCOtpke7jLAD6bQ2DnuNbtmW7cqmGpuNzovZ+fhN1PiuuC+t8Lkt8fXKd335Ou4rkBhPKKjSxmnAhSY0RGAHKSOIdaI1/412YDPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791500930; c=relaxed/simple;
	bh=V0/16htqebB/8TM85S/qozxMSwXr5jIDRFTSzbN3uG8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHkwzMW0/ueF/ixozKTb/4E2Nm50CnQUYvhYj1/t8m/upa3iDzKQNa1zZB4K6e0YV5LzVjIQo4mo5l1CIq7qcMmx0zmCnkXxVBSMQS4nrZiQ5eFjKBNnPV44YRikm4jOAQzLJJh9JpmazDpiAuxJl8kVseYQCdTr9mBXKyhEmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiC5cvmw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiC5cvmw"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a171b677d2so25444575e9.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 16:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791500927; x=1792105727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H0IFuL9k0j9ydZbshhVfJaOod4wFMCM2kpIm/qPno78=;
        b=LiC5cvmwXhm/lk4pVirajN401Y3bhim6/QXfpdyGFjUsQC38DtMOXAqBEmnRIGydE/
         kPB9BP1iARb9LKbfnHsbgHDc07zAUFiZZhe7Z9P2x/KuryAVG5YEwR9nS8RDjFCoJmSZ
         /RtOWG9MiizgtBggsOh4SSzu9DrKJ9HMq7DX11TuEc6YUBr4CZzmwF3dIpKGNMZIOEnj
         JCAV2/iAb2RdDXpgSFXghfJoTO0fn2bZwHuU5N68umFPiI+gBEIaOEYWt2wEmVKsENop
         SQc4l0x5HFH/zfntjcoqABNYHJMXAi7dn84XW+W2gXkE7pvlnmH1Akix/QRsBWO6ejZP
         lbYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791500927; x=1792105727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H0IFuL9k0j9ydZbshhVfJaOod4wFMCM2kpIm/qPno78=;
        b=QAwVLtSOAo475cMFnB6f2xu5rJqDpcTX+IxJJu7eH4fQNjrvmsUP4glJgoa24anbUT
         9Omt6kBwKBRCPS52mzrZ+4Rp7F2lXdCmcZXXyVNquZq8r3un5pCDorVVCe2jKOYCkCR/
         +BDcrtxW+YDjyhNA7x9Rx7F/jc2plAZDyAgPUO88JnZL/dSvGPCTjEiTn+A5a6jLcihJ
         IYn4KZlB7bpdx3HcEi2ltTvd1SaAhLUFqexPzqHSz8KLFtNJrsPavpAzY820vvtM9WF5
         agQryl84zryqGZWTPWYbcLEIXeBqUNB0J75iZ/SBm+10SBZ4u20g6N3GgddSF60/5+PE
         JqmQ==
X-Forwarded-Encrypted: i=1; AKwUvBxucRitknZwyIPJttam6krx6iaNkAVMeqMUzNuhF/gvouhcy/tG5CfKhIWTUKf5YLziJwptQZQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kd3UaYy8SIBbPCyONG1nDbG3oBsOFm/UgO5EaFp/8GaSjUl7C7
	0jOWnrRW0eET703/Riq2gacNFJ03lX3OuAP70vKCQOLDHnWf3YQF39xe
X-Gm-Gg: AYBFou2TSIKv2vkAsISM1II6BEPh49iZbEBD4N1lhQbToLoPdHKGWXHC0pybfHsVvhH
	LVfhKZAdbpWA/cvfsBwMwg1Zx3+gL15fUaYy3LDIjQJGmnhX9dNr+9UcXlWmuShUzDf/gZTmsvV
	G239OdfvVZDa9fkqDcOX7e1FZuXc+OpHP2LLW7tAzwaACJaawlSFOO9bHHOd/XuK7fVR07+dB75
	dO1PA+Qi4kiyNuCTzDKm6R0JljtTIVxtmbk334O5K9g8TpFG9HJswDmfRPrRssir87FaIju3xki
	lofxoCES8r095DY/AcbEODLo3nTZERUvzSGmorwhKSh/O4lOJAjVKtNVvEfNVmJGz85f51u3Gs/
	WzQPMy7AOPxYXw2gF6X3QGOktxVjl2G2jz1ic3tYRV3YCKP2zC7hSDdKTNOp0Cs+DTDgC/6CiJx
	omB/C227Uyjaqpux5sM0QFS11Eb8DoE+Nt6S8lo/FAt8a9FIZPJHd98/ano3jc3Y4HPe/6e3zZO
	dUBzxhm7Q+ZvI/Kr/nNvw3J+qZ5a/jVaCOkmAhFXYB3jX0HXHjadQZ+diPAHSm9GisOS7YIdIX6
	UrsdNn2q1tEhALuIWAjDPhdO5A2/zi0DM02T2SouHQ4MWrF3LyLpO7gwzC6dsMtZQOMCwbCjQLs
	ZMCEbbIZq9AVD2hn5bK0bSR1870cKWA0ZRldi/DTHlhMfPmHLyqX0UO8WvpI+cXAES7MCpGK8Gb
	HE6YEBqPTqaQWgCf/BGbygaTknkQ==
X-Received: by 2002:a05:600c:4ecc:b0:49e:7a10:1b71 with SMTP id 5b1f17b1804b1-4a1802e95d7mr127375585e9.11.1791500927140;
        Thu, 08 Oct 2026 16:08:47 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:415e:bf71:e574:69b7:f11e:4204])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bead84esm14244115e9.13.2026.10.08.16.08.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 16:08:46 -0700 (PDT)
From: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-usb@vger.kernel.org,
	Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: usb-audio: Add mic resolution quirk for Logitech Webcam C200
Date: Fri,  9 Oct 2026 01:08:44 +0200
Message-ID: <20261008230844.11246-1-olivier.kaloudoff@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index c5870901a..16cb57f2c 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2249,6 +2249,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_DISABLE_AUTOSUSPEND),
 	DEVICE_FLG(0x045e, 0x070f, /* MS LifeChat LX-3000 Headset */
 		   QUIRK_FLAG_MIXER_PLAYBACK_MIN_MUTE),
+	DEVICE_FLG(0x046d, 0x0802, /* Logitech Webcam C200 */
+		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0807, /* Logitech Webcam C500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_MIC_RES_384),
 	DEVICE_FLG(0x046d, 0x0808, /* Logitech Webcam C600 */
-- 
2.47.3

