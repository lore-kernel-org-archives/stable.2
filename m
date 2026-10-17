Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD13DEFFA
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792213253; cv=none; b=hvPqpH5S527Kmk50QNchZW1SYjKmzLkuNIFw/mEOZjva5/iNhw1DNIrssjlOuxWp7tyoISjdvjzPd/kscUJdz1WzvgWwQE73qTWMNjU291eY8Zyq0zuTA7yNRnpE8wZEZ2rMPD0z1M0KRt51kNrymaZKa5SvrkW6bJ05HRtp5ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792213253; c=relaxed/simple;
	bh=UxEGsDp+X8XVGsojDB6p8Pq7U4zHWN6nO0KwXXBjwTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mVnOOdzBkLGDm1HYA9gUVELtsfYCp7WfYJ8lwq05GzXla/sN9DQ4Lv/wkTDAfVFRtfhv3PmjNd1Iek2dL8SZ0FQhPKvVbvr+CDEyON2TmTtlgrUMxCfgfj56V9SwTBfMxV5yJ4xQOcljPf4XM6HTUFkw8Este5AmEiw3Wkfs7tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gk9jGtU6; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk9jGtU6"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-843cf077f10so523615a34.1
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 22:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792213251; x=1792818051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2QPqiCPtv6mBsOEA+xwRq+Gvryl1g6t6b+sIBHTwo/w=;
        b=gk9jGtU6mcwxmm5YveCtn7/a9ZGRRMOSYnc68qmOhKs6fkvuLkYWlpjceGF2QV2mFA
         BsujIx7AcVRPH8M5DdXLut+t+QmaBphC/yA9XOVKfDHosZHGKrBoL1xqspqCZz2LyH1u
         Upx53rbEsxbxT7pxqfL5h8j/HpjiOfIYdm/DYewNofeT7oISclQLqjHm0Jjaa9QyYtza
         jcR+X6zkPThmtbauDzARreSnPXPphZ5S4PKMDgTTTc7oTebYnck7fMR2B/62CnPm44/5
         wXdYsHEzD+IhDrtvvfgWY8iETi+UukAJO/7k623D7vxv10DiGeHfT8yggOOfqLN7bj8J
         YSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792213251; x=1792818051;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2QPqiCPtv6mBsOEA+xwRq+Gvryl1g6t6b+sIBHTwo/w=;
        b=egcpYNcX2j7MEYW/NXgNnZzB9ilT2H2QGoCF3KPWxMFNhH8rrAokyrSTCyU1MY7JmT
         UrxwekqE5WQMYeeOAtoX7zYf8BTYRSlmvcFpOlqxSVtHz+eKOM8NJG6YUPefDwCOLPcM
         hshH03Y63Z2Gzw2QbLZM012ab3wYTulucbpLEgiEPIua3hlzDDjb3BtpJ5IkI7tMS69a
         pe7GSUDoRVLFgr1sxAKEMQJsJmky8p+Lg05GUqfiPrb4lKHHrxOYwCks4VLQUU7dJH4Z
         lXxF2wKnC+P5Xoym8yNF0Z3PwVKqb+n9iF0zOwgg3BrjRoWQNQWpK4roGOhIwdlpEnTj
         wLBA==
X-Gm-Message-State: AFq9FYLBU/wDZqncsUeFRatv8Oww9r7K0p5os9il8L3+IbcfdkUREAmZ
	x3j+3JwPNP87TyhDSTeUip3MRy53SoZdC8UWW2vG0MmsT7P61CU7XBZUoY2mDQ==
X-Gm-Gg: AYBFou0JWK2nuakCCpXanSfEUmm3a0MIBmYL7B+xmJUUIQUqifIqjGX8YN8AKB80nXu
	BKfMA6wYzYck/57/yB1LtEzlgRKSdlWNf8dw0mjPdP4OjLgaJWKHe1ZKykD/FxyTna0UlMdklfg
	RlVB66+czNszcCpieWZa7PDg1BeZIpo9pNdVAB9F9ELRqb16fzQuJLfNsODmjYuBHZUMytea1bT
	c9/SalKjGIX1fRGofgJtsT18d5wukNxVyKIEDueDA4IyMWCyL/rkgQFQ9mVq7BPbb5J4msYNdPF
	btEESMaS/V+BMosQcN7zf/MqyUCFl+hU+wEkAut8F51gxpTP7HmiKqKSI8EijfgfP+TkaNXYm1c
	R5D4VlH7JBwXSg6lqb6voWdsvpnAwszYm3pYlqM2xyY55hHRmw2Krs01nXIAJcmvoyyZZ1OGc2C
	mLlDreswaC5MnLvLvK1kuyKmf69jvnBoJFluYfkUjJ6324qhiNBLioihTohkClJVJxlQjmHWSNN
	Hwo8EXd9L8gFlsUneVmwp58pZkaAQ==
X-Received: by 2002:a05:6830:310c:b0:81c:37e2:2008 with SMTP id 46e09a7af769-844fe0afaa6mr2245162a34.14.1792213251272;
        Fri, 16 Oct 2026 22:00:51 -0700 (PDT)
Received: from fedora (fixed-189-203-106-166.totalplay.net. [189.203.106.166])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8462659e3f0sm224078a34.17.2026.10.16.22.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:00:50 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?= <josstamy@gmail.com>
To: josstamy@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx
Date: Fri, 16 Oct 2026 23:00:14 -0600
Message-ID: <20261017050014.13594-1-josstamy@gmail.com>
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

