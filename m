Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AE392829
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239592; cv=none; b=CVJU8y/DjY+fOIzOlae9L0a6n8MWs4EnCGw/zUqDvomsKQCbnEOzxE0u+5PpT2NApVGB2jcK/MVt0/WB0oE6//udSonWPJ9s3mZG2a21s0fMxCM2nTTX0SAoXolgXifrc5L5fMJh7nNnrnP9sxvW/hhFoukDpiYmL8RkPa9JzYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239592; c=relaxed/simple;
	bh=k4OJiq2Mo2aITU9HdLPK9bRz20KkPoLsgMNjsfGSkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Az9L0C+Ap7uj7FtMvIhJ8Yjbg3IxV2exEsi078tlb1ggy/GEbJwm30Pxd8GNSgUihvAY3/l3DYsPutj5b7ENZIkyFUJuqVruJRRlQR+QuRrCDGABrD8tjzMR8M9cHYlCoKAKz4UH10cYd2fq2Igw4PelQuFeGb61xLEu8H+Xqqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jK5S0UeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jK5S0UeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0971F00893;
	Mon,  5 Oct 2026 22:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239589;
	bh=ImRt6E4LyZn+IkN9baZ1RtljyZ1L4k/c1nEp4PIXuoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jK5S0UeBo/kp+pH7e4A9Y4Y1ecZR80jMmRRwfymm403DH8S7MsjYHT6GPwZbyMWmC
	 9odpAn9DpKmTu/5mVWJjP1Aisd78w2id9tvbOOSOZveWhnMqJHtQexv10f7FRzoMxl
	 uNcckIyUsXLNz9KajtBrr27OhAgqt1O2c1pl6OyI9RW+KbcB1DFxnoPpl0wabIBSKC
	 YSnML/PhbLUjdWhSf6v8dnDNeKqBgWzbPARcLyh7zgr+5GYzW6bmF/97lo4ptrAkIV
	 r1zlJXC7/EATFt9q5I3BghPy6cX/bBkXtkc6445wVk5Na0mHG58+0ECFq+4FifghAs
	 3feCkoM/pmM9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aaron Kling <webgeek1234@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
Date: Mon,  5 Oct 2026 18:33:06 -0400
Message-ID: <20261005223255.3500832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100518-diagnosis-entomb-8d1e@gregkh>
References: <2026100518-diagnosis-entomb-8d1e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Kling <webgeek1234@gmail.com>

[ Upstream commit 89365897f4210979966aa808d7b013edf4080558 ]

This workaround was originally added for Tegra194, but no longer gets
applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
tegra30 soc") changed the guard to tegra30-hda, which worked because all
affected archs had the fallback compatible. However, commit 7f0ea5acfc19
("arm64: tegra: Use correct compatible string for Tegra194 HDA") removed
the fallback compatible for Tegra194, causing this to break.

Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Tegra194 HDA")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
Link: https://patch.msgid.link/20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/hda_tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
index 12a144a269ee8..de47ea7b9ee13 100644
--- a/sound/pci/hda/hda_tegra.c
+++ b/sound/pci/hda/hda_tegra.c
@@ -376,7 +376,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * in powers of 2, next available ratio is 16 which can be
 	 * used as a limiting factor here.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
+	if (of_device_is_compatible(np, "nvidia,tegra30-hda") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-hda"))
 		chip->bus.core.sdo_limit = 16;
 
 	/* codec detection */
-- 
2.53.0

