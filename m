Received: from mail-07.mail-europe.com (mail-07.mail-europe.com [37.187.220.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2604A3D16EF
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.187.220.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788164768; cv=none; b=Lnji6GlIoqyvzNfiLJ4zt2iv2MnGTA72gZS37ZJ1kWlbnDDaA07Pi5398jhOMpn1JCV/pp74y7Zl7q3ABXQuqxbx75QhPMeAWBZhik0/Ewt+NaWNJm6YY2riE/ufEuXaTXyVaT7kuE15TTqTk2KRb9JOtfJYeXDkhYLOUBVJ4+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788164768; c=relaxed/simple;
	bh=LC32bx4buY8+xqOpBc5EJnaO4rGmOf7j4BLQfXrglKg=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=YSjFdiQshgdTu511UYtejEJJBj1hxW3uSYedH5cSl+chtl9OtEcknTZtr97tVrxAW/p5+twVEUHGSv/CPeJWqUoV2dQNtS6erYpY8V0Rw9aW2eo7hgYCDUXG5Pr1qnexJmcJvXHt874WDJ2rKEarjybxQWbwH+4UjTkxFaKpiQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luites.com; spf=pass smtp.mailfrom=luites.com; dkim=pass (2048-bit key) header.d=luites.com header.i=@luites.com header.b=kGp1ZHIz; arc=none smtp.client-ip=37.187.220.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=luites.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luites.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=luites.com header.i=@luites.com header.b="kGp1ZHIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=luites.com;
	s=protonmail; t=1788164754; x=1788423954;
	bh=LC32bx4buY8+xqOpBc5EJnaO4rGmOf7j4BLQfXrglKg=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kGp1ZHIz22gESbubnvN1MOiO2P+JiF7ne39IfceQZiz9lh3/qqjGF4opQ01iyiT3I
	 oTv42nmAiYy05RkjH/qTCxDxtlK2Ld39fv+yD/aY0FsFA0+hCbSJKA84AZDqBjX6nB
	 3uR7yTgC0lL3pfn04fbUL7bYZaMwYCchqkvqjGJax+S5YvpDWxLCdlaEdQGnZvG8Gh
	 Ds51wv5e167q3//nK2GBCBGnsDpmoYoTwa1jWvA6w+I7kWlxvoMn1f1K7/G8kFiqZO
	 GFvarSLnZZeKtO1wBYW3GbMRNLTemkOWIr/M3O3hfDkpEcqWzxj47Ufq3esxDg4dHY
	 R9TrkyHzhXvYQ==
Date: Mon, 31 Aug 2026 08:25:47 +0000
To: Vinod Koul <vkoul@kernel.org>
From: Ian Luites <ian@luites.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Ian Luites <ian@luites.com>
Subject: [PATCH] soundwire: dmi-quirks: Disable ghost Realtek on Asus GX651AX
Message-ID: <20260831082534.224716-1-ian@luites.com>
Feedback-ID: 196833966:user:proton
X-Pm-Message-ID: 63d591cc6fdcf620e988376798c5e88949e2347d
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The Asus ROG Zephyrus Duo GX651AX exposes a Realtek RT722 device in
ACPI which does not exist in the physical hardware. The device remains
unattached while the CS42L43 and both CS35L56 devices attach
successfully.

This confuses the function topology machine driver into creating
duplicate DAI links named SDW3-Playback-SimpleJack, and the sof_sdw
probe fails with error -12. Add a model-specific quirk to remove the
ghost RT722 device.

Fixes: 45cf24da0a10 ("ASoC: Intel: soc-acpi-intel-ptl-match: Remove unneces=
sary cs42l43 match")
Cc: <stable@vger.kernel.org> # 7.2.x
Assisted-by: LLM
Signed-off-by: Ian Luites <ian@luites.com>
---
 drivers/soundwire/dmi-quirks.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.=
c
index 768255dd12..62fa64b224 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -200,6 +200,13 @@ static const struct dmi_system_id adr_remap_quirk_tabl=
e[] =3D {
 =09=09},
 =09=09.driver_data =3D (void *)ghost_realtek,
 =09},
+=09{
+=09=09.matches =3D {
+=09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
+=09=09=09DMI_MATCH(DMI_BOARD_NAME, "GX651AX"),
+=09=09},
+=09=09.driver_data =3D (void *)ghost_realtek,
+=09},
 =09{
 =09=09.matches =3D {
 =09=09=09DMI_MATCH(DMI_SYS_VENDOR, "ASUS"),
--=20
2.55.0


