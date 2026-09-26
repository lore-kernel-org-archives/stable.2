Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8AE33F589;
	Sat, 26 Sep 2026 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407470; cv=none; b=AGySIVeHGuoIWPtJrgSsf95c/GMfZQAo0gPDksk3fwZkrklVaKAwYRFnwJ4V/DPhAOWmCDGbC+xy/qt+kIH87vEChhHjce3vSVyTPDzHd1OpSxahZStZR/hbMC5Y4ET6C7sVIJLIuMWowIBRATa2ZPCUVnQSKcRjoliRU0pttwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407470; c=relaxed/simple;
	bh=LSFWMmwZm9AOOui3G9yO6os/W4ndoAnTIvP6M1MFVyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Tp/AB1nLcE7ssaCIWMVluR2RIURcCyUKuG2QeyUe7OczsXpLUbiKUkfPNLY0/yutcEsJjFTH3+WH3q0EtA01BW5m1apZ6Dw1vBSiaQsTrYAI5jxVNjUTpWF+QxFhajjBSMM9iBVEoiKR03sZYxuGjQGi7tTtbRWaBMV6lBPTJAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F70k0EEf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F70k0EEf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21047C2BCB8;
	Sat, 26 Sep 2026 07:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790407470;
	bh=LSFWMmwZm9AOOui3G9yO6os/W4ndoAnTIvP6M1MFVyw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F70k0EEfDlYyHcVUO1ludQ5Sq/5NlWWVaNpChhgYfOyEtspuKDmcTMX0TdJ7UxnmC
	 e4em7lAOgJGOqqeiLMSXcQaTFlGFqEitG6JVaAXORSOcDXTZTAbCjUnSRm/2Ei3721
	 DdF/rpRUglY+fs+3/7lcx/9Y+ruvOKaUF+/YosFeUOvbwoC+vQaJKKSF6EsjtHMaqD
	 wOdtscZz+70I7FVyRbpejHuh3GOoL/kQHDw/pHdJRg6egT9mNi4XzH6MVgJw86TvPn
	 LuqIONOpKtzopWldB8pCZblI2g4ba1ijQ83Kh9hGIZO51tymrZJiKz9WIRa6wYDNAT
	 B3DpTnduGWJ3g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDEFC98318;
	Sat, 26 Sep 2026 07:24:29 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Sat, 26 Sep 2026 02:24:19 -0500
Subject: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBtQKdGuEi1Ep5qNhkYE4d2Tl
 m/x/wuVClOFWbxQ6ObKOXWoQUA4fNoJOXaDltpIpw1etBev3IhH9FhjRhXtGIy0k3IWenYW2vj
 5l8va2gf4fpxUYgAAAA==
X-Change-ID: 20260926-tegra194-hda-sdo-1d84c6085198
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790407469; l=1584;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=8rAycl98UAJVNpg4nxLeFSEwU8WePutSW40I7utV8vY=;
 b=jpT6mRhj6kFaT03vLb78Ga/cCq4a5oFDhA6+ifoHcGRLo0Q1WygeZdjkILrQ2wRqTUOIgSoJj
 ur/C6Ic/N/jCoPadVejJRrh2MNXBWbwY9PtMqbgCOK/Yg6KbL8H5cHw
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

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
---
ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
---
 sound/hda/controllers/tegra.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/hda/controllers/tegra.c b/sound/hda/controllers/tegra.c
index 31c14c4bbe683..674cc0f79c3c8 100644
--- a/sound/hda/controllers/tegra.c
+++ b/sound/hda/controllers/tegra.c
@@ -374,7 +374,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
 	 * in powers of 2, next available ratio is 16 which can be
 	 * used as a limiting factor here.
 	 */
-	if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
+	if (of_device_is_compatible(np, "nvidia,tegra30-hda") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-hda"))
 		chip->bus.core.sdo_limit = 16;
 
 	/* codec detection */

---
base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
change-id: 20260926-tegra194-hda-sdo-1d84c6085198

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


