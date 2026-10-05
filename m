Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190436F90F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239086; cv=none; b=F6UOXj47Y4nazu3oNl0MBOzh/ZK8X3BgUmoOffxtWJnNumsT6zG7tNHCEO4pYyf98not+yRkc6GiV06AC288i53ujoTbAoFxaqUYJipv+pgS2RxcFxJ2wLuWWItLEhPhQI6TkKsfUCRe3tbA4uUzxPWCfr+wMdAz8N/AlammT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239086; c=relaxed/simple;
	bh=k4OJiq2Mo2aITU9HdLPK9bRz20KkPoLsgMNjsfGSkqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GtmoAR+9Vn4O5Zq6HsM1HqDkc4ugetDpYEpN4lylHU4vHH1Zj5WDR7Fnje53e0eBxSIBiLRng8GzSDXxg3vBBzo7WrqhXr1KJbgRcnx/NAaynN7O07luI3Bgzez3AcPzso8tX9HRhqy/09nPSVsE8Iv3K/I/GcB/GFR4gt9+ZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkpqP81I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkpqP81I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE9DD1F000FF;
	Mon,  5 Oct 2026 22:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239084;
	bh=ImRt6E4LyZn+IkN9baZ1RtljyZ1L4k/c1nEp4PIXuoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DkpqP81IPP3UIutV1eKTMAuORLfQ7T/3uiNx3O9zEchLvoabL9e0BBjx6/hX05jJ/
	 Rhv/WTccuXQ9gZ2xb3JVpIK9RoFTo/VZak4X0P4KWtnca26uTNJA/zDfT3F6lQssMt
	 kgC6y1oP3xKTG4Mlg7IEaw/qfm63yY/7/gWl3jpWZvZULI0RAFzw/S6pcmtE0gg9lN
	 UwQN5cYZVkad3gV2ZCQ0Cgz1O/A0q4kJDk8R/7hEUHdp3BkmPGcxGTX7F9bjkyeskA
	 vbIqeSjOXIi+JPlL4dDrbvSIENSluhcgmpHuIp2UQZjN+egWF7UoHYMqh3Ob2uhZHi
	 Bt9m/FOzpsbew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Aaron Kling <webgeek1234@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
Date: Mon,  5 Oct 2026 18:24:41 -0400
Message-ID: <20261005222431.3492789-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100518-penniless-browsing-d792@gregkh>
References: <2026100518-penniless-browsing-d792@gregkh>
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

