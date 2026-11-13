Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794588707;
	b=VuYtYRAqlBXRXnA6dz5kA3cWtG8nv9FdlaAN0Ssy0olocci/LVotVnhX9A5VCO94ARCY
	 KwAiZjXgNhCLj4NdE3NbNMCv5IOCgctjQ1ry1QQn5t0tY3Clswt2DjAZfU6YyG+jh7uos
	 lqWzdJzPF2KSTFiRSyuiR49TLiTm8UEO2DbwZARUmxCQE2e0C1bT5hL5RaJXHOOifNScL
	 7AotibWum9HZGW8u+WcUKd5AdIWPTtMF+kNEARdrSiZdULAQaP7H29+L7XyS/z9gQMNGH
	 ndCKQb4SzMuiEVaCzYz6/O79gF8y9zH1ST2DOBN8R14RKbHybzCY+024gsWA532lhEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794588707;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2ImFqAy81mm1GsxsTj7gMZAZzx6KCHVEfKNHYYvpVIs=;
	b=l6/a+3pyVHGk0zmzXj/QPxxe9w502kgBPfsNG3nyNZt4bE58wr0fkPQT+cMhF5+rzrMy
	 9AYiD9HdPdYVvmlbJiTVpUUjjacw1y23eVFnjniNjn04ltTBH10nIptci7anEYKr1unFm
	 VokNtAxGJuoKiBedtBYKDO277lYj8Fgumd3LZI4u18cYyTo6bMyXOiulHP7eHBZZEU8Az
	 TJt5Cz/7uFTT/s8NmDCdTZcE9ZlMweSYvQVYgAa7LgZq3v2Kqy5kf8jpJ+O5gpCmMnyk3
	 5dJbcqyPHKyeTFpYhQKIuS3oa5bD9UU1xevJGCq8G+0Yf6Tjft2RAcj1O+MU18+gzBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRa8KyTf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BA1606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRa8KyTf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD801F000C4;
	Fri, 13 Nov 2026 16:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794588706;
	bh=2ImFqAy81mm1GsxsTj7gMZAZzx6KCHVEfKNHYYvpVIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LRa8KyTfFKWI+Gltiz/Jne5afYFAQVQbgh3Ezx8PbSOTXpJT1/JOW+uASjTmEkqik
	 iX27oOy522Y66ruFe8W2cN1Np/wPxbQpaEIe0oQVAtEqW/S3zIulQl8aFhlnhmXdUz
	 JmZ2tw0Jg2upw5T1OJ6haMIQ/27ZjbmG8mhw7WDr/rw5P+ncZ3H4hs29BHRLO8KKGk
	 foOCnXP4Z4Y6vGbIOWpeUri3ojCoTwD/R+o8vQLnZC8xe3BZHnuRc4Rfp7dXHD85+L
	 dDVdrVqeFoCh/1s42hQ3sgT/OQksZ7k43+zEvQ2O4LGL8IE8Fe0wGPf7sF+UZjLO3e
	 7OSH5TdCF6Aeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/realtek: Fix internal speakers on Acer Aspire AL16-31P
Date: Fri, 13 Nov 2026 11:51:44 -0500
Message-ID: <20261113165131.2129939-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053611-failed-6.6-d933955c456e@kernel.org>
References: <20261107053611-failed-6.6-d933955c456e@kernel.org>
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

From: Luis Gerardo Lopez Hernandez <gamaerry@gmail.com>

[ Upstream commit d933955c456e0573b40eae4f72a3af37ab1c15c3 ]

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
[ sashal: Adjusted quirk-table context for the older driver layout with missing neighboring device entries. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d711cd7292b2e..17b81ffb6ff5b 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10770,6 +10770,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x2782, 0x1701, "Infinix Y4 Max", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1705, "MEDION E15433", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x2782, 0x1707, "Vaio VJFE-ADL", ALC298_FIXUP_SPK_VOLUME),
+	SND_PCI_QUIRK(0x2782, 0x1718, "Acer Aspire AL16-31P", ALC269VC_FIXUP_INFINIX_Y4_MAX),
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
-- 
2.53.0

