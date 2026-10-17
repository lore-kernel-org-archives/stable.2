Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A8E34DCD2
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213616; cv=none; b=g9t9cCZAUzrLH/Y0qyE/yWMSDN6xVcIdrh/DF5sIXlLx7Z+Oc3svctKUh5JOwE8+2IHcQxrKBlCpRyHlj14R5+D98IY23c6UhRj2Qohtu1229msm4Lb9UJQ7vrgWbNlI03AQdg/FSVMraXdwxSw9CfVkDywN3S3GSkXxaf/duRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213616; c=relaxed/simple;
	bh=UxEGsDp+X8XVGsojDB6p8Pq7U4zHWN6nO0KwXXBjwTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rhdhd6PKF0qGcFZPLQ8BG/HMdv2yoIxUchVcroSJnx+H/roRgBmtcS6Qm/UIifDJoRTsQgF0/y/vkZMcNKuo8b9LSNRoG/9dXXQgPeNWk5ikTTQ9TN4VgwkkMfOdkbKFiHNSpuLSrfyjNykf//tWGDAndmtBf4eXn7I9huKSKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rG7bTMiV; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rG7bTMiV"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-823e4047037so351653a34.2
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213614; x=1792818414; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QPqiCPtv6mBsOEA+xwRq+Gvryl1g6t6b+sIBHTwo/w=;
        b=rG7bTMiV27I2A4OpBqK+mMADpNRgZ2ml1KduiGZcmIBFOTVPuazF39SXvRcF/x6Ps5
         hlDyUYtC2fAPNuE4rC8ZAFpAqzqj6dZ8C/2e6uFAeMGATLxumEmOJjQ9iuc53pJ93k7K
         Jt1mUXYOO8g7uPi05mVdU0gfl0xBZUAHMgFW/lvnLLTEXaKRFlI1TEzpw0pV3fnsU0mG
         OQICOph2JBVGJRyxCfB7bXq1CA8tnd9H1doaZmMgCHQPnAKNAihfsNvIl1VIyKxoUg1A
         eHwemBZzRLVPKCFW/lStKADIdYiBNUrFWnplKWBfWSu0f3sR97pUUhk4DnO8aTr9UGhI
         baPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213614; x=1792818414;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QPqiCPtv6mBsOEA+xwRq+Gvryl1g6t6b+sIBHTwo/w=;
        b=I3eGCQlUPGi6PfCeY42JFt6o1LLu32z97wdJhVYb6Yu+LxEcFSGU0vQrXmGy+K4Nvv
         TP6NYW1YBOGdcV3fVDYFzwn2RR8dOeXw+Vem5PVMvz043mTPhV4ujKm7eIfEo2/k34/d
         jwGl4uDD5B6z66XzAMi+lRcTbnK6cc8B6HpS9mWCQu7w/51Cyqs3n27x9HeVTTZh8eEx
         nwyFH9PlnOKtXMH7bx3XWFxGzovgz3Yek6OeWQt27T4UgVxtlqR/rH1pMMttlBkCfx7/
         hF/gkYbltAYC7johz3OsDxTVvS3SK6DH3qykajruOHvgU8OtxyTnyCqJivHNNMip3MUl
         y1yA==
X-Forwarded-Encrypted: i=1; AKwUvBzUO33Bb2vS0WLhh4nD+cJ7pcNlWvX8Jj5poCZoKgFEq+n2u/iQAYbq4oLfb9Ygd1d5dDitZ50=@vger.kernel.org
X-Gm-Message-State: AFq9FYLVCQQ/j7wX4+ypU0RJgQYW1CMF+7rgPoL5+nxAOnz1kvVl8VJf
	x2HFjwhzbM24dhJp+8Q1SP6Lzo6gQb2zBY1YieaF97PSqqSlh01lUC0R
X-Gm-Gg: AYBFou0nLSPEf0ld/L2Y4sJcssb2zIXT8GrCGA41G+EVEme9ryYqaPmV1xTSZQG751T
	PFYz7iQy+bue0n3Lz7UyOShY8Q+r4KYH/Q74e4uOGkrQg0zqmAPewVl0awGp7OdNeO2mUtOWy1B
	shaT+OYzWwDKcUuDPKZWNxAHnRFLthq9+pjFvdVpnz7lyGE2KQjeTYPLSWEdLBdm1kCGUrMz56W
	8KhzIMI/LaCRQV64PgQDl6XZmfs/fMvOAG73jh551Cn5DdjOF7lCKaCPw2pUAkcYjRUS0EIuSsy
	ZotNsy6Wx3nKzGkgK9Vyhvvs3d/T/cRtI4QwGybc9rU7e+pzhi5muFXVrSBWywSlte52oFGMpOv
	fFiM69B780MK3cZeqtLADcgp8JJNulYz/eEePOX+PWT93lFlr2Py+n2qn4pIPF49kFSyJsaHb/Q
	IeAFaRb9+V5eQVpTda1f4ySSluxgO0UdI2vA+Qb6rET1fWJeHn+cnJeiaBmuZYvTJUFU/c4lh4l
	L6VA1BhudpvfukW5M+PjSALx5/3xg==
X-Received: by 2002:a05:6830:2e05:b0:80c:d34f:5f65 with SMTP id 46e09a7af769-84501a1395fmr1739782a34.30.1792213614098;
        Fri, 16 Oct 2026 22:06:54 -0700 (PDT)
Received: from fedora (fixed-189-203-106-166.totalplay.net. [189.203.106.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-842a0f31614sm3504872a34.3.2026.10.16.22.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:06:53 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>
To: tiwai@suse.com
Cc: perex@perex.cz,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx
Date: Fri, 16 Oct 2026 23:06:15 -0600
Message-ID: <20261017050615.14481-1-josstamy@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The HP OmniBook X Flip Laptop 14-fm0xxx (subsystem ID 0x103c8d9f, ALC245
with two CS35L41 amplifiers over I2C) is currently handled by
ALC287_FIXUP_CS35L41_I2C_2. That binds the amplifiers but does not set up
the mute LEDs, so neither the speaker mute key LED nor the microphone mute
key LED lights up under Linux. With that fixup the codec GPIOs stay
disabled (IO[0..2] enable=0).

Switch the entry to ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains
cs35l41_fixup_i2c_two with ALC245_FIXUP_HP_X360_MUTE_LEDS. This keeps the
amplifier setup and adds the speaker mute LED through the ALC245 COEF
register and the mic mute LED through codec GPIO2. It is the same fixup
already used for the 17 Turbine OmniBook 7 DIS (0x103c8d9c).

Tested on the affected laptop with v7.2.11 using the equivalent
ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX fixup, which has the identical
cs35l41_fixup_i2c_two + ALC245_FIXUP_HP_X360_MUTE_LEDS chain: hda::mute
and hda::micmute LED class devices appear and both key LEDs light up
when muting.

Cc: stable@vger.kernel.org
Signed-off-by: José Miguel Castellanos Valladolid <josstamy@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36d3bc23a..c33a38598 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7957,7 +7957,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8d9c, "HP 17 Turbine OmniBook 7 DIS", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8d9d, "HP 17 Turbine OmniBook X UMA", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8d9e, "HP 17 Turbine OmniBook X DIS", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8d9f, "HP 14 Cadet (x360)", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.56.0

