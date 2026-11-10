Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273010;
	b=OzbKLuVWUxcqf07VjWpcxNwh0x7fTiR4wZiDs3lGjF6NjOBOvJl0cJnKblYR28aBdTZO
	 j+y76Mlj4Nrn2aac8rXeef6LlwySsBegu3AsSkX+9G23884xpCKBGcduZR1g4f0wohzqT
	 /PSqsMouTBgdhSvAh1rS8pgGUVkAdpm9VKZ7VHNqjMzBggOfn3mjTg9ep6EWstB80ii3U
	 GP6EC85ZMt7wkODOY+PKxuAxsR7LhVOHoGtt8wkxXiT12ehue2TrO21hOvFV+vpmJkR4Q
	 yV+l6D1MdR7iacBdL+GlOR1TJi4s2JxYcAeIK6UTobdJfBI2eDMSNzmJFmFIcPVAimg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=P7TjA2iVLyRCaPcHy0q45gs+SuwYXSo6rI7FLvyWiGg=;
	b=AYoJJk8IaeMKXDlRDy4qSX6wa8BlkC/zq+DzqrnKQ+InUYU/GzItQjgQrK0ttMv2hxjD
	 OU43ITEysviMLuaLMfe8ZG7/cPerrSDd9GXUvKU7RfUKujzhXCOnKKUrWm1XBgchrvMLe
	 AtRxTMbvN4+6AWyvLC1bfPOLuVATv5p+85LEIl2UaiWl4FnGwid+JQECFlHb8xldzQqQo
	 vV6IXztwqEJ9MEmFn3ug8OH/5HIJIR5qzt9smKyntvq+x8UJNDfMoHQmciMC4xSfJMiBd
	 Qhu1opxn7WfmQX8eKLgvy4jzYfhOqPrAn39+jXairYJY/l9hSx/lqJoxVXD/YEPOqzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndXRfuM5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD9A606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndXRfuM5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003521F0089F;
	Tue, 10 Nov 2026 01:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273010;
	bh=P7TjA2iVLyRCaPcHy0q45gs+SuwYXSo6rI7FLvyWiGg=;
	h=From:To:Cc:Subject:Date;
	b=ndXRfuM5UmA390cAkqPDR9snGyU21kd2Ck29eWRo3meWw/A8hQK/5mzpO6FVY2waA
	 7H0d2oGFeaTlZcsF7TEcpv7yAiYrudDnMVdEq85fOBlYdPNOQGn/RBuCl563nRZg61
	 NlZQ76ShCvKO6SD9zF/dGqq0a/RlKnGJblgQicqd2LFUR5OZxp4i72c8YW5nz8lnc0
	 H3CDt0HpjDNfiluhuNWGReM7Chcqj5IORsODjMJi1Uvuj3nX3QTG4en1W8/NukeKJc
	 6mCWQWlEeAsVaRmdGcOANMJgoGbdM+MJFaBkG8FLXYFdgvV125iKPWyhjTS2FI4fOP
	 sWMXTCSAs01iQ==
From: Sasha Levin <sashal@kernel.org>
To: youdoit@mail.ru,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY 17-cr0xxx" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:10:08 -0500
Message-ID: <20261109201008-failed-6.12-cf79cc4996bf@kernel.org>
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
git cherry-pick -x cf79cc4996bf936fe159af2a600519b3ebd4ccb7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201008-failed-6.12-cf79cc4996bf@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cf79cc4996bf936fe159af2a600519b3ebd4ccb7 Mon Sep 17 00:00:00 2001
From: Alexandr <youdoit@mail.ru>
Date: Tue, 3 Nov 2026 21:21:21 +0700
Subject: [PATCH] ALSA: hda/realtek: Enable mute and mic-mute LEDs on HP ENVY
 17-cr0xxx

The HP ENVY Laptop 17-cr0xxx (subsystem ID 103c:8a2e) has mute and
mic-mute LEDs on the F8 and F5 keys that never light up on Linux: the
existing quirk entry only sets up the CS35L41 amplifiers.

The board uses the same LED wiring as the HP ENVY x360 15-ey0xxx
(103c:8a31): the mute LED is driven by COEF 0x0b bits 3:2 and the
mic-mute LED by GPIO2 with inverted polarity. Both were verified with
hda-verb on the actual hardware. Switch the entry to
ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS, which chains the amplifier
setup with ALC245_FIXUP_HP_X360_MUTE_LEDS, and use the DMI product name
of the board.

Fixes: aa8e3ef4fe53 ("ALSA: hda/realtek: Add quirks for various HP ENVY models")
Cc: <stable@vger.kernel.org>
Signed-off-by: Alexandr <youdoit@mail.ru>
Link: https://patch.msgid.link/20261103142121.74032-1-youdoit@mail.ru
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a75204d328656..cac3018069948 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7878,7 +7878,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8a2b, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2c, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a2d, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP Envy 16", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8a2e, "HP ENVY Laptop 17-cr0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a30, "HP Envy 17", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8a31, "HP ENVY x360 2-in-1 Laptop 15-ey0xxx", ALC287_FIXUP_CS35L41_I2C_2_HP_MUTE_LEDS),
 	SND_PCI_QUIRK(0x103c, 0x8a34, "HP Pavilion x360 2-in-1 Laptop 14-ek0xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.53.0




