Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046345;
	b=3m6RpP3fdIMauPg6O0Lq38SVAwaCu126n+JPIvSHDB6dk91GjWZjrNWrzsdHqqMXz74c
	 GpSSapCvXSVG+h7cAgosUw2MC5ETfS9l43eEFyDxOkCGLl+WIBglU7AG9dOjW0ta2sIcR
	 MWO+o8sueEFOYW/gh6iW5drDVXt0PTD2VBdlvLscfIMM9mRtPJyYKPBW6CBTiHpTDsqXC
	 1W5T8MimzhV+iyGFmbYK8kRZZiix1GEl+blK2h1cP0Y0ea9L6ZKRRFUWsUage1qkXMS22
	 dgjASP/g5mTHsYH443/RqvezzfesxmE5GqN929gLoah3+Vw7F4a+fAhX+wz8+HDI43g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046345;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=3p9pczKJe9nYOGvb8iFxFk/MPLCA/kuxdGrtYNKN350=;
	b=TlFKZdoVRwGD05+oGE2i/SII3Bl14UQi0JElLdGQQ4UM4X7Au92q/oBHMeDQad7QrC57
	 ZjJyHz96MeeMRrFS7fHZ7nQxDplGHzrJivsvmQ3pWOfOuyYy1ZasvjyNISJJVIXo6H4HG
	 9BHAyh78yykOk5u5jFy2OsbIYL97yxHG/j+jDyn5s8Xojx9qMyhy/Db39GfSBE1lzoGkw
	 mg103njr5V+U06bZmWKrzx8BGyEo6lBML+nOqlS1W9OEop2/VfioBeADfcSo0yQZIfXXx
	 IuN+TNt1c2o/lX7Pdsnh5lA+8PwRW/Hqk8e3rv91P7K5LysJyJG1BIL4AbBupk84jTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivc1xJzG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F70606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivc1xJzG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A511F0089F;
	Sat,  7 Nov 2026 10:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046344;
	bh=3p9pczKJe9nYOGvb8iFxFk/MPLCA/kuxdGrtYNKN350=;
	h=From:To:Cc:Subject:Date;
	b=ivc1xJzGfq3qQjmn2no7EMmUU9byeaRxhVni7CKjoG+yHs4i8nkTdZyIiEiY/jLOK
	 2kiZBykgW0ewEtw1SwTKuc2gLRcAV5t+Rh6BeVq6x1D5506WTDbWxT9Ce/DhOGz60F
	 6EOrfih+faz4rL9r8iZywTzALE5xBwVTO4csxto8Yl37Wnf8DWT/xX7tySGJwDLZ4N
	 ZSN2+g5DTIledo0GzpIZfYFWlKBTYwW0WibFCLxaNP2DqUmTSGZPAQL82G5si2kJAu
	 DIkuVG90jhEWTDZbjOyNwAOHeqiJ6fmGieNTv6Z/wiTvU8pQaPabDIFyxbwwGR5kLl
	 0I5u3Xv6I0pkg==
From: Sasha Levin <sashal@kernel.org>
To: josstamy@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable mute LEDs on HP OmniBook X Flip 14-fm0xxx" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:12:23 -0500
Message-ID: <20261107051223-failed-6.18-c80286aaa4ac@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x c80286aaa4acd52f9bd0b0d4914d2069fe6ba3a8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051223-failed-6.18-c80286aaa4ac@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




