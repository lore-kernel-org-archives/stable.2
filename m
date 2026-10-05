Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D918B377019;
	Mon,  5 Oct 2026 07:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791184247; cv=none; b=egqmPCac9bXvTuBLwocmY0F6ft+l7CZ4eYSRUH3yZ/HCmKS3A4ezhH1vylnMNZIVXjh6AUmZ7ivwy3rf23TnDkjzwMOdisHftS6fzO+CLeIkIzh4OdFJ2Uyd/TTmoVYPst/V5lxcbPyKSdjiNka0bkvLj4bNxOyG6chz3+S0iGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791184247; c=relaxed/simple;
	bh=/FTZKXzlSbj1Qu4aUjm3DPWDwD4aGAHpPQhwec2f760=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g1tCjLgMkd0fJTdV9ESLBnKcJGxTdMQEonjMGCYbbiEplsTnejusA/ETotsQ0KAF9ogCvYdsdhv22I5gXKJEWIjttiahE32LoRRgflVol++A3+xvzphn56EiZXHSanndygYN9h/PevWJH/Orwy6FQvdBmvooGZZv+Pk4Hpqlgtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa2bZ0Hn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa2bZ0Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 679C9C4AF0B;
	Mon,  5 Oct 2026 07:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791184247;
	bh=/FTZKXzlSbj1Qu4aUjm3DPWDwD4aGAHpPQhwec2f760=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Sa2bZ0HnA8sak6TN/VzHR/qzl1S6U19EKIcdDpG/glqCBiaSEOG2OSTFhPsmNuapo
	 +q8Dm9ESHOUzMLy9exM09eqDFnzQcKSDAPYWcMrDwcX7yuIM4L50O62CYon2qabq5g
	 LfNSAxf8J5DSoboiynqHQ9gVFe1zae4+QGPuza6VrcPkOY2jgQZdlz3xkVCdODhE7u
	 jqk3YfW9l9nLxApq6LxnEdM9liOA/Ar5k/vH8X3Kp0kxeUSJ4oYFC0zBUJu1IEVhJb
	 W9lsj/nx6E8ssaHk0wMU5C2tlJYV1WoeZdEVT0GhPadCTjZXY9cjKf8Yr4LUoSCbET
	 u5lEcNWv/Owsw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 516BECA5FFD;
	Mon,  5 Oct 2026 07:10:47 +0000 (UTC)
From: Michael Garland via B4 Relay <devnull+minimelkav.gmail.com@kernel.org>
Date: Mon, 05 Oct 2026 01:10:32 -0600
Subject: [PATCH] ASoC: amd: yc: Add DMI quirk for Acer Aspire Go 15
 (AG15-21P)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-acp6x-herbag2-quirk-v1-1-a1f2683d758f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQqDMBBA4avIrDuQCak/vUpxEeOo04LaiYog3
 r1pXX6L9w6IrMIRHtkByptEmcYEumUQBj/2jNImgzU2J2Pu6MOc7ziwNr63+FlF3+gckQtFWVH
 rIZWzcif7//qsL8e1eXFYfis4zy9UYpbSdwAAAA==
X-Change-ID: 20261005-acp6x-herbag2-quirk-44114c7891da
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Michael Garland <minimelkav@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791184246; l=1417;
 i=minimelkav@gmail.com; s=20261005; h=from:subject:message-id;
 bh=Rc372Nll5VxRtwlHdHYkmK+PKfsdL8c4K22pmtyJb7E=;
 b=Q7WbuefFzM3v8XRdrT7tEayQ3HnLgqisFG8NVVaLcVLDclOEm1h6lmzaqqryhtlNflI/Bq7dN
 Wx0jHN9JUqMDMqgjKfrJBBkKhvEZyFHspRvzcOQx+3ZIZeo4ZQX0vHK
X-Developer-Key: i=minimelkav@gmail.com; a=ed25519;
 pk=YgP8zoqOpwmElHd5xoqUtKJTkGSY9Jg/LavDAoXazjs=
X-Endpoint-Received: by B4 Relay for minimelkav@gmail.com/20261005 with
 auth_id=1113
X-Original-From: Michael Garland <minimelkav@gmail.com>
Reply-To: minimelkav@gmail.com

From: Michael Garland <minimelkav@gmail.com>

The Acer Aspire Go 15 (AG15-21P, board MDC Herbag2_MDU) has two PDM
DMICs connected to the ACP. The BIOS does not set the AcpDmicConnected
_DSD property, so the acp6x machine driver never registers the DMIC
card. The existing Herbag_MDU entry does not match this board name, so
add a DMI quirk for it.

Tested on BIOS V1.11: the acp6x DMIC capture device is registered and
records audio on both channels.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Garland <minimelkav@gmail.com>
---
The board name differs from the existing Herbag_MDU entry by one
character, so DMI_MATCH() does not cover it.
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index e798bf6a9cd0..1be8504571ad 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -787,6 +787,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "Herbag_MDU"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "MDC"),
+			DMI_MATCH(DMI_BOARD_NAME, "Herbag2_MDU"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {

---
base-commit: 695f659d296fb05a76f03967733e79b6c2085bae
change-id: 20261005-acp6x-herbag2-quirk-44114c7891da

Best regards,
--  
Michael Garland <minimelkav@gmail.com>


