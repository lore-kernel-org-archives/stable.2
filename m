Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047025;
	b=kGaY3Upj2Wn+HX8YWLFLlPuDYpf3C2bizozdIGcFsSQ1Um/FzdsKOS4aWQAKDZtpaYts
	 V0czZeUyJe0aC5ATvK2dquZYiP5o3d18JqO8PFc2/W/tvOnCWoKTXjGOkMgbbX6qrblPy
	 W9QdK3uG3i7xAEDZRfxWsCpdI8Jrny4DNlWxZuVFj0+ncxdej3xC6/ZR6W3Xyst3NlfGz
	 IzZhFHICDTcsYtQq3+gMYwCEegDQlapkw6mIzrDLiEE9AJutSwdEOqc1zeFgcGwEWG5H8
	 Kqi7wz/MAWjw2anMxoXviQvhC11bXSFK2aqsWTEADivi3yudHD8m16ZYWWzbNEHg1uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047025;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yp72GomLNA694fK27iAGKNcHYKq6TJF480gXiQcpdL0=;
	b=oU5d1jRGsfhBTIweoGa8qQsXsKT+KEK09W53eaqWPjPoS/C89Jx6rhbOp2QlxiJu+JFa
	 j5RIj5clNrAjYNPSlxELK6U4DvOqWtXO4iQ7T46zGjgFQldTorwJP2Ub7qqGDUP+fdk4u
	 FvpPDXcyYi+qlpRZXvYrpeHkIM2gITK2vtNAUA9Kq4n2EA02g7guZzXKKO4uTGKpyund9
	 wZqkr5SfdJM2X3/EyKToHeeJ/LfVBg14CCyDMPhdCSjjyaD2bJUeuX5/VpD2dItvmiVXE
	 ndP8MV+880LnqCayKDSnnVKJUECXPWpVnAfe2I7PmiOIHiAzqwtCrN/u+pDzKfW4dWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeNKss1I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A529606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jeNKss1I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7871F0089F;
	Sat,  7 Nov 2026 10:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047024;
	bh=yp72GomLNA694fK27iAGKNcHYKq6TJF480gXiQcpdL0=;
	h=From:To:Cc:Subject:Date;
	b=jeNKss1ICDcEHxbWWJOUyptAx1nBaQ8NqjKW5+DV7BMEQzIRaGnxYU5VRcj/9qDpM
	 Lf17Xskm3b7YmKVbOuC07L5TKorh2EAf/7jT9UNSsTNX8utKWaog5kK6cLp1X8AIim
	 r9m0HCCzMrPwHHpVjMy5/T/aqojo0MBrYJxNWX64DMQrjLJR4biEnDcwZSqWlAXyZD
	 2ubQfwO0sLd6017XuyAKrwWrxSC8j9mG+79v7O/NBCHfkwpAORxP/j9EcSg/VUsEwn
	 IBl5Dpvs3cHepEMRf+rNJ2zOS2lmbgs7K/LnRrYtQaA7O1/J/iMucEXwDMgAP5H8Jj
	 0VeUcxlZImmBA==
From: Sasha Levin <sashal@kernel.org>
To: josstamy@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:23:43 -0500
Message-ID: <20261107052343-failed-6.12-c80286aaa4ac@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c80286aaa4acd52f9bd0b0d4914d2069fe6ba3a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052343-failed-6.12-c80286aaa4ac@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c80286aaa4acd52f9bd0b0d4914d2069fe6ba3a8 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Jos=C3=A9=20Miguel=20Castellanos=20Valladolid?=
 <josstamy@gmail.com>
Date: Fri, 16 Oct 2026 23:06:15 -0600
Subject: [PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip
 14-fm0xxx
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

Fixes: 29951021367f ("ALSA: hda/realtek: Add support for various HP Laptops using CS35L41 HDA")
Cc: stable@vger.kernel.org
Signed-off-by: José Miguel Castellanos Valladolid <josstamy@gmail.com>
Link: https://patch.msgid.link/20261017050615.14481-1-josstamy@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 36d3bc23a2df4..c33a385982f2b 100644
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
2.53.0




