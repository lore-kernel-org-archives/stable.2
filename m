Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D68390CA3;
	Thu,  1 Oct 2026 10:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850284; cv=none; b=flJgyNV3jCMkXTLvfTvJBNaoiWGgvkexRMkzFi6PerMjFHpmXOHVjrul40FVf0GwuLc9PRBYb+nA6OTz5Wjw/0MjthTsEH+Yp5t9Pss1ELdnSI7Unq464wAeu2579AP9yHdOuW6+RnCkqmBpFnEPr9wsHTsK5mQW5NLTKrF08Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850284; c=relaxed/simple;
	bh=CRMGvrIMhxAA7R7htoEPEdyfO/addHuufpE8klIHLlk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oeCrQ2BNfPa/Fz4D8HO/wUXpZK1TDjwjoZViqV2Gkmi9KCcZQ/RXoEdatEJqeDIr5KAMy+L82icidaUmO01O0a5h7yrNbZexKCDxYPYrao23px0QSzOwUDlDqbTClOWAQK+moQUcK62Li2u95sTtjdI9NekYBsX+L3Aa+2uNQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEpwBdgv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEpwBdgv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42954C2BCC7;
	Thu,  1 Oct 2026 10:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790850284;
	bh=CRMGvrIMhxAA7R7htoEPEdyfO/addHuufpE8klIHLlk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=hEpwBdgvJpUDfp+h2y5dfRYH2hashkv1J+U1ZRyDG8l3Vog9TWb0mqEsAzc3I0LlC
	 WoohPMofkv95MIjnYfVnPkUm9eFCHE+RFP6YZ5OLLbqTgybr/kQNRTMCYNl4T5IdS1
	 gHd/Tl2b0kNOmobGPzkDI+wYdylmQBIXaaV+P4GPfmSJjpG0S2urxP4PCGggT05R7c
	 VQXV7vpYwuGlU/hegMvPUFQN5O8mX4qxvtE0D/dUpi6fh/n213xCTBxu3lomMfb9+d
	 ndMLv0g5rVOK7jNbWqsf5VYhxaooc9WDlL062vbkvdg/RPWYz2KH74ye9vIZ2ZGFFW
	 6hs2GWxjsYAtw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D527CA5FCE;
	Thu,  1 Oct 2026 10:24:44 +0000 (UTC)
From: Mohamed Yassine Jebabli via B4 Relay <devnull+med.jebabli.gmail.com@kernel.org>
Date: Thu, 01 Oct 2026 12:24:42 +0200
Subject: [PATCH] ALSA: hda/tas2781: Accept V1 calibration data without CRC
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-tas2781-v1-nocrc-v1-1-ff0c1032ce76@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MMQqAMAxA0atIZgNNoFq8ijhojJqlSisiiHe3O
 L7h/weyJtMMXfVA0suy7bGA6gpkG+OqaHMxsOOGnCM8x8xtILwI4y5JUJuJxc/sJQQo2ZF0sft
 f9sP7fhBIAW1iAAAA
X-Change-ID: 20261001-tas2781-v1-nocrc-e6b2c5d25c88
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Shenghao Ding <shenghao-ding@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Mohamed Yassine Jebabli <med.jebabli@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790850283; l=2533;
 i=med.jebabli@gmail.com; s=20261001; h=from:subject:message-id;
 bh=CENQtlJ1LypGiyn5qauAiaLgNcBd83EMwaUm18pDmiQ=;
 b=JhDI0NDil2dH/dtMHaKh1TRVF7lJpLA0hTz5AI9YQ5xLACAmNcB5dvoecqoxf83jO6oQsg0oP
 AaMv3Rb3b9OBC8dWRYdxcbG+nOFLphpLvjLK5RlVjFnX59as93p0+5A
X-Developer-Key: i=med.jebabli@gmail.com; a=ed25519;
 pk=DrcY8DXRRRL44W1NDZ4mXZmW9PRCASf9qYo1sm0KFYE=
X-Endpoint-Received: by B4 Relay for med.jebabli@gmail.com/20261001 with
 auth_id=1095
X-Original-From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
Reply-To: med.jebabli@gmail.com

From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>

Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H, SSID 17aa:38cd) store
valid V1 calibration data in the CALI_DATA EFI variable but leave the
TimeStamp and CRC fields zeroed. The driver rejects such data, so the
amplifiers always run with default parameters on these machines.

The rejection was silent until
commit 4fe238513407 ("ALSA: hda/tas2781: Move and unified the
calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
turned it into "V1 CRC error".

The stored values are consistent (R0 = 3.82/3.83 ohm, 1/R0 matching
within 1e-4), so accept V1 data when both TimeStamp and CRC are zero
and the first device entry is non-zero, and emit a warning.

Fixes: 5be27f1e3ec9 ("ALSA: hda/tas2781: Add tas2781 HDA driver")
Cc: stable@vger.kernel.org
Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
---
Tested on a Lenovo Legion Pro 7 16IRX9H (BIOS N2CN32WW) with Ubuntu
7.0.0-34: the calibration data is now applied instead of being
rejected.

CALI_DATA payload (128 bytes, 2 devices populated):
  00: 5d02871e 312d8b21 6258f817 85bca500 0000e02e
  14: 263dad1e c45f6121 f85c1618 912aa500 0000e02e
  28..7f: all zero (incl. TimeStamp at 0x50 and CRC at 0x54)
---
 sound/hda/codecs/side-codecs/tas2781_hda.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda.c b/sound/hda/codecs/side-codecs/tas2781_hda.c
index b22f93424c62..e0da299df780 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda.c
@@ -139,9 +139,21 @@ static void tas2781_apply_calib(struct tasdevice_priv *p)
 		 */
 		crc = crc32(~0, data, 84) ^ ~0;
 		if (crc != tmp_val[21]) {
-			cali_data->total_sz = 0;
-			dev_err(p->dev, "%s: V1 CRC error\n", __func__);
-			return;
+			/*
+			 * Some Lenovo BIOSes (e.g. Legion Pro 7 16IRX9H,
+			 * SSID 17aa:38cd) store valid V1 calibration data
+			 * but leave TimeStamp and CRC zeroed.
+			 */
+			if (!tmp_val[20] && !tmp_val[21] &&
+			    tmp_val[0] && tmp_val[1]) {
+				dev_warn(p->dev,
+					 "%s: V1 data without CRC, accepting\n",
+					 __func__);
+			} else {
+				cali_data->total_sz = 0;
+				dev_err(p->dev, "%s: V1 CRC error\n", __func__);
+				return;
+			}
 		}
 
 		for (j = p->ndev - 1; j >= 0; j--) {

---
base-commit: 1f2f457b771554777e3a3bee9b0cbb646ca2278f
change-id: 20261001-tas2781-v1-nocrc-e6b2c5d25c88

Best regards,
-- 
Mohamed Yassine Jebabli <med.jebabli@gmail.com>


