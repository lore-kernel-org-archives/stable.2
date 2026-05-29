Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7A52DA749
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780097916; cv=none; b=duRbOtoMnXZJix8OCwyyWgi4g0PQNVmfmyLPqTtPciKSjEurYJ268DFmqqBADfOwKpsUFwvF+lDGBCh+M8m0LbWjchPOHTW0LlHotYYeND2LivdbWOpSQM1WCOsc7+PdQPcyT2KHS8zccL18KgxKky+OTHRZlQ/CcJLc5WLMoJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780097916; c=relaxed/simple;
	bh=pVAU6vYYneFTLLIh6bQvgnYqSo0maGdKuVbeVj0GFW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZflKU4hkEfBwn3LBQr+Si56sHPDVnqPJTDQfsE68vlaLjXXwLatPDsq+yjW2CiviPwxAs57tEP/YyTFgGcBNIlBYQ+aIY2a5RejxDXGjD9Oa6NHfeyM4tM2uw2es6J55HXxUlG0+XIJPg4eTWkI3kvLk52OFoQAJn27ILZiW+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/r2+9i3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/r2+9i3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECBF1F00899;
	Fri, 29 May 2026 23:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780097915;
	bh=G4e/e1+8qjbGLilPhfD+1e5GFqKvT5FD3cGIHXaP+nU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O/r2+9i3XYbVwVjrKWWLj1Y226SExxW5TvQaHqCx/gSvXOrvZaMeMPvFjCzWhazOl
	 IIYJfYaJUDVh2FfwFgB1LayfrzgpoTB6VYjqaqctyOaBhcqrJYwRq8KprBVXvBPN2Q
	 lCUTr3CHXPsUA8ogAfdtlS+8RDBFYRA/NGQvGacrfz1VJ8DWOhTCUbm7e+kKB9970H
	 R23IFH2nqdK6qhuN2GCjOm6vD56WynJfDyAp/3oxnzGq57F+mA1BukOQWwdDosH8lz
	 lnnM40qBAvawnAPrUO6H4x3XJq2S6ifBYdp+nVl+EUKTzZTmSO3g7LFSZhCTA4x6Sx
	 XKQ40KROLsLdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0.y 2/2] ALSA: hda/realtek: Fix mute and mic-mute LEDs for HP 16 Piston OmniBook X
Date: Fri, 29 May 2026 19:38:33 -0400
Message-ID: <20260529233833.1909329-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529233833.1909329-1-sashal@kernel.org>
References: <2026052801-harmonize-cosmos-d0b2@gregkh>
 <20260529233833.1909329-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit 9e5fb6098d21e1f9be9982b46c3e5b8329d4e7d2 ]

The ALC245 sound card on this machine requires the quirk
`ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX` to fix the mic and mute LED.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221509
Cc: <stable@vger.kernel.org>
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260519015535.891156-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 9f69a888ffbed..2c56f574c86d6 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7182,7 +7182,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8da0, "HP 16 Clipper OmniBook 7(X360)", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da1, "HP 16 Clipper OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8da7, "HP 14 Enstrom OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x103c, 0x8da8, "HP 16 Piston OmniBook X", ALC245_FIXUP_HP_ENVY_X360_15_FH0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8dc9, "HP Laptop 15-fc0xxx", ALC236_FIXUP_HP_DMIC),
 	SND_PCI_QUIRK(0x103c, 0x8dd4, "HP EliteStudio 8 AIO", ALC274_FIXUP_HP_AIO_BIND_DACS),
 	SND_PCI_QUIRK(0x103c, 0x8dd7, "HP Laptop 15-fd0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
-- 
2.53.0

