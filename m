Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96977331203;
	Sun, 18 Oct 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792342595; cv=none; b=Cax6bxSySCNWO+lamiXDDKtamukDuumeWHLJ3484KZNJzzqfv2Vl77Yc+7VlpDarIeu0HJ031d2CR6ZB9+BBbSjUjMS+0Jm0r+aAwQHSS6ESxSk+t7Rf9UB0mEsbkP/FQQuNK1F3iiYhOPYG68kh4/MDZV8SHldv0G5XRPvJUhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792342595; c=relaxed/simple;
	bh=d3ay5FXVBDcidVSbB5fN4cGPC7NcpEA77jmvawpdrdI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZhVoGp3uBB84dKSpvtX4J4XU3tjh3ziM3XP+4xOOvLhRyQWX2Mvgu+JeY6nozSI2zWXtfScTXNypGVSqgK9yMUhTI4WeJGec4MKBFBwC9t10kkM/3BjficW0bnq+0TUCCvqg5QJBY5x7oGGiL800k/SdO83meCl5UsVgwvUtH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JCl/OMXx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JCl/OMXx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36708C2BCC7;
	Sun, 18 Oct 2026 16:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792342595;
	bh=d3ay5FXVBDcidVSbB5fN4cGPC7NcpEA77jmvawpdrdI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=JCl/OMXxBcGhi2Ll/A5UPVqONZLV0PSFH4cwDTB9PnRFNj1hXb5UcFENGP2WMZLOp
	 NED5yX0u80HjEt9JhGv5pLjurLBFDaqLgLWPbsLxDsXY1WpyUmGJE/v6PGH7v6XO1o
	 fGZASlgyqToSsH3lNiGrGGEXdFxlOj/K+NuymrOwroxaz4yKcJKHnBU91mIxaLkR1d
	 hYEFNIQ3xPP0R+N0u07kHjTyOlvh7KlSrHNf7Mn8pcRmx9EjInwQeksPaDo3Gb1QiS
	 ZGii2oC3rKREujlC9rgS95Fm/TwtpW+qJj/rIClxhdjPyq5Q8dExHNi98TKVhbK8MU
	 ToioVsYHRXRFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ADACCA490;
	Sun, 18 Oct 2026 16:56:35 +0000 (UTC)
From: George Christidis via B4 Relay <devnull+gxristidis.gmail.com@kernel.org>
Date: Sun, 18 Oct 2026 18:56:31 +0200
Subject: [PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14
 UX3402VA
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-for-linus-v1-1-4d8e9ff27d89@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXM0QpAMBSA4VfRubbaVkZeRS6MM4402jEpeXfD5
 Vd//wWMgZChzi4IeBDT6hNUnkE/dX5EQUMyaKmNkqoSbg1iIR9ZaGt1aWRnC2cg9VtAR+f3atr
 fHO2M/f4O4L4f5zB/zG0AAAA=
X-Change-ID: 20261018-for-linus-2bb2760ab5f6
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, George Christidis <gxristidis@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792342594; l=1568;
 i=gxristidis@gmail.com; s=20261018; h=from:subject:message-id;
 bh=WO42s5RZ6hbZHX1anwLnUs6RiGT8aq0KXyrmR3Fn9vI=;
 b=QgWJrj9Qpp1fCpRoh16U+axun5rMtlsLJ/obgxrMZptprt+QU8kMl0U/dMuYYg3D9Y0nsg0hy
 p0h9w83tomhAJA7xDeWYteWFx+8QV5fZZetdGYyjRhH+OnU7W0ftD9Q
X-Developer-Key: i=gxristidis@gmail.com; a=ed25519;
 pk=LWp/LBe13KlT/70ZpW3a73MV3ESP4a0DmOo2Zrz0Dhg=
X-Endpoint-Received: by B4 Relay for gxristidis@gmail.com/20261018 with
 auth_id=1227
X-Original-From: George Christidis <gxristidis@gmail.com>
Reply-To: gxristidis@gmail.com

From: George Christidis <gxristidis@gmail.com>

The UX3402VA (1043:16a3) BIOS leaves pin 0x19 unconfigured, so the
headset mic does not work. Use ALC294_FIXUP_ASUS_SPI_HEADSET_MIC like
the UX3405MA, it sets up the mic and keeps the CS35L41 speaker fixup.

Tested on a UX3402VA: headset mic, internal mic and speakers work.

Cc: stable@vger.kernel.org
Signed-off-by: George Christidis <gxristidis@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 1623cf926..cea8c7091 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7867,7 +7867,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x1663, "ASUS GU603ZI/ZJ/ZQ/ZU/ZV", ALC285_FIXUP_ASUS_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x1664, "ASUS ExpertBook PM3406CHA", ALC256_FIXUP_ASUS_PM3406CHA),
 	SND_PCI_QUIRK(0x1043, 0x1683, "ASUS UM3402YAR", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC245_FIXUP_CS35L41_SPI_2),
+	SND_PCI_QUIRK(0x1043, 0x16a3, "ASUS UX3402VA", ALC294_FIXUP_ASUS_SPI_HEADSET_MIC),
 	SND_PCI_QUIRK(0x1043, 0x16b2, "ASUS GU603", ALC289_FIXUP_ASUS_GA401),
 	SND_PCI_QUIRK(0x1043, 0x16d3, "ASUS UX5304VA", ALC245_FIXUP_CS35L41_SPI_2),
 	SND_PCI_QUIRK(0x1043, 0x16e3, "ASUS UX50", ALC269_FIXUP_STEREO_DMIC),

---
base-commit: 8e8cd9a4c6dc006e9bd51b8ad0079fb4576b48d3
change-id: 20261018-for-linus-2bb2760ab5f6

Best regards,
--  
George Christidis <gxristidis@gmail.com>


