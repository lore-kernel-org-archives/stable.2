Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049669;
	b=wPWIVyAXX7WkeXe4v7M2ZySHgv4iM4E522mI2g/4Dnj6nY/n1ejcB2oLbOU5kVAGLUC7
	 PH4xbd2jbmQ6qXUFPuO66rP3CrTkBxBCK+IsyfYyNH2VSW9HkZpaIk3YXkW6HY3BBsoAH
	 lxGAeJOCbA8ANGtTykJ1+5ZRwYfB+YofYSLug+hTT5NO1r+IaYdoXQHbzr9ORogg+pExv
	 swidOI7FfJWLTUbAgOg1a2GSL4Afz+37kYfaAa2QbIccmON7/dO/qRF1m2OFFaYMeYHha
	 gqXz4Am0z9+MHs0w5q4+cXP6Gl7qW6Xx5REapeA0mggZglj8VdkKFVjBCkRzErYq3Lg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Bx7vWCu5ubKktHTVr04MrmQRBFwxaf0G0E7jrw/qDd0=;
	b=ooj/WPyyjLKSJGViVTK4u7KGUD9T/WlYb4Fgk9KcBPv1UoQZQmHJQkqWKNBlQtVXad2E
	 IEAk7Xdb8ngcRqDjMum7NQBnhgkeA4o43WMDHz/HObBE2uucGA8A0o0DSHQSNnw+zFbMe
	 A2RExbsqXvyUfw9yQVRAldndZvtId9kUJ3QwvVTNXcsxRD22TLxVn+rz01kU5b99NhFp5
	 yQtiPhVcA9E3Jz+CotMXthHal/dAX26SZ59Pk8y32HDrhPvzpWOe5Y9134lcqVCUEHwv7
	 cTe8H7LrrMml4aQ/iy8ksAotxyjcllIHFn8mDQbhGRHSST5KMqLF15Tan1m7M83ZelA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffujza7E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4157F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ffujza7E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B538D1F0089F;
	Sat,  7 Nov 2026 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049669;
	bh=Bx7vWCu5ubKktHTVr04MrmQRBFwxaf0G0E7jrw/qDd0=;
	h=From:To:Cc:Subject:Date;
	b=Ffujza7EqOiWG2xz1oduBANA9aBcB5piVfY6ADcHUJ1NRaA+eRvjuXAPHuS0Pwszg
	 zXWyykxOU20Yc05ZGfDz6wKtEz88TE+PtTqmv9EYJYas6E4qjy+gjwQbqNTo4Ce5hz
	 W0TCQM0CXR/PwTLGEz+VtH6A8tiH4o+ioaat7IiiWpUpSXN/V/oBjsJ3qJBb66Ovkx
	 rmsQYh5E+GosL2csVrHdj/Beikev6Y6sWOUTVbieJPNwX/6sBUE4dzEpAnwwgjhg6U
	 kV5mr11wBPVJOEnMAzs6/LTP2123riY9hNOJrwipFxx8DoBpwV7Oezvr2ic/KMT/Xg
	 ngJ/LBhB4bBUQ==
From: Sasha Levin <sashal@kernel.org>
To: gamaerry@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:07:47 -0500
Message-ID: <20261107060747-failed-5.15-d933955c456e@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d933955c456e0573b40eae4f72a3af37ab1c15c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060747-failed-5.15-d933955c456e@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




