Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047773;
	b=FcsJsG2zYb5J2TSEUQjGTTtdoaYCHVRebGXWBiLCvAhAhHrpGd7mQeP+giOByw/Iaxs7
	 LEpHRWwzYi4rEcKfsJwn3EWYgyGKCEehNcYyDMhdVxi2Vq5HjdGTD/l8OzHP719qby6w4
	 jn/l2hm8QYtEl4NT7YVMKhu2hwlyvBc+5z6RvhDifLT2RtBcNmNJdsWdEyjqzmpXRdDOP
	 DwkUAcCm1n69BoclqCiFwaMzyDXbNpD3WBS34MnSJfw8WxABV4hpfKj52y2zLtPV3DXpC
	 E8xDWCAN369q0ubyvrbhuJU6/OiNzFV5GC7xguaxToKJN5lwiEP0DjaSxH1KJnd0u+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047773;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MNcu1GBAnfF6G7QdWZfH+y8x96C6H+al3qbDfiMmcBs=;
	b=F7TwDZiBuUo0745xJ1+1T1shoyrm6fYm+RtGa1sfjXgBwue93VhUcOR88fhGo1LG4X/5
	 HfrL1hRNoThgpQEpE9Yy4s4En0ufEVhd/6CGjLtyAB6mfKCtTPzSQbLI/dQ0emKXXT2LS
	 4xqdkYkCt9r9tPSaw3SSAzLxZ8+szgyhUvCeJARa5rbfiqu9caaPgd+1HWjLrTthRgmMN
	 zQt5U0RAymBbj9rDEK9Wc5tUuQS193YMEh16Ve2m/tbhM3GeM8iws/wIyKEQ4IicSSeel
	 VYrDSYupQmN3to0hc69fFyoSAQDH/YYEHVGWyW9uZO4whNy80vwLls6RfqPubob6Diw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzu1uzgA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD7D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kzu1uzgA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC1E1F0089F;
	Sat,  7 Nov 2026 10:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047773;
	bh=MNcu1GBAnfF6G7QdWZfH+y8x96C6H+al3qbDfiMmcBs=;
	h=From:To:Cc:Subject:Date;
	b=kzu1uzgABGKaUqb3m+7UlonRNXkgyjOEzwRYvaZ2zHxuH1P6HjWQZ6N1XjFi/b3nO
	 vx8/+T+F5dVYZbBUAyoAtLbR74kjjrZfrWuVGT+s73SEnofOXNl0KKPGQe2PDwNA5i
	 qRmu2lTZsSyvJT8Tc/9ZAp8xdLj67ztXgstn+SyOumm7ptb1Ce92R529zVp4mI9KUp
	 Np4dxuGfy3d5XACuWdcFhNL/wRTkI+3fKqg7aDNmDyEs7xF4dz9QaO92nljdDBrUwf
	 RtxbTT/uodGuJmbnW9gB86lWHvuyuufKa6LE3uVbYwOfr/6sNK65LtVPRdN/rsLRpP
	 QPy3VIB71hiVQ==
From: Sasha Levin <sashal@kernel.org>
To: gamaerry@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:36:11 -0500
Message-ID: <20261107053611-failed-6.6-d933955c456e@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d933955c456e0573b40eae4f72a3af37ab1c15c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053611-failed-6.6-d933955c456e@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d933955c456e0573b40eae4f72a3af37ab1c15c3 Mon Sep 17 00:00:00 2001
From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Date: Fri, 16 Oct 2026 18:50:39 -0600
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire
 AL16-31P

The Acer Aspire AL16-31P (Intel Alder Lake-N, Realtek ALC269VC,
PCI/codec SSID 2782:1718) has its internal speakers wired to pin 0x1b,
but the BIOS marks that pin as not connected (0x411111f0) and only
exposes pin 0x14 as the speaker. As a result the internal speakers are
silent while headphones, HDMI and Bluetooth work.

This is the same layout as the Infinix Y4 Max and MEDION E15433, which
share the 0x2782 subsystem vendor. Reuse their fixup, which configures
pin 0x1b as an internal speaker and limits the internal mic boost.

Tested by booting with snd-hda-intel model=2782:1705: the fixup is
picked, pin 0x1b is used as a speaker output, the internal speakers
work, and they are muted when headphones are plugged in.

Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>
Link: https://patch.msgid.link/20261017005039.9139-1-gamaerry@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index c33a385982f2b..af43e7fb99b71 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -8671,6 +8671,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x4900, "MEDION E15443", ALC233_FIXUP_MEDION_MTL_SPK),
 	SND_PCI_QUIRK(0x2782, 0xa128, "Positivo N15RPE-S", ALC269_FIXUP_LIMIT_INT_MIC_BOOST),
 	SND_PCI_QUIRK(0x2782, 0xa212, "Lunnen Ground 14", ALC269VC_FIXUP_LUNNEN_GROUND_14),
-- 
2.53.0




