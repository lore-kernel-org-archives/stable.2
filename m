Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFF23E1713
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720029; cv=none; b=Te9EZwCXyxeC/zSoHdOc9jR6dk1SjVpzqszOpGUSZXo1RRa1fz5aChUqvmAtOOt0AyqM0hDm/eyeHNx0mJZ95ymYQlNRFiyEoM1EGUvksCNDR1bGcZMMF5d2yIFmaIdP5aggphkFMnI9W+aimJw11a5tRDLpSp3sHP74yEZTvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720029; c=relaxed/simple;
	bh=zRkIdp8i0Z1q4k/Lint4s1PsVI5vGI+tdVdMDWI2DPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=An0HPJlgOh7KBDAK6CED7h2dv+5QgJo3je3eFiUx58nhDTFQbKfUg2M+Q8hdusITM4di8eEdWxh3vKzxjy6qcZbcKavM1zphZqvR9ImjOdseVoyTiMtAo8TLbziKJpAP4nRTuR5jL20dBjN8vLsOF0wz50e8iM8MinV87Irbqhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGubhDtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGubhDtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6251F000E9;
	Wed, 22 Jul 2026 11:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720028;
	bh=jK5ywpNFsp8uUqwLqrYZJ1MhwJfcbaWsJf3htZvaVM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZGubhDtSe1am5O7skL9Ymsr7cUvQI4dqFsurZtB78RaQ08bUJ3RibP+nNaI6nG1oJ
	 zmIs0FYPBIBSJ/iu0lMW8NQrdBkmtqJPirH/RbULN791Vlr7ReJwb4VYz6WCgvjcNd
	 /B2wkVKJlKUP7sDPcm9TOG/QiIxZ/xifou9A4Zw9mIsjwIfimBk2XAnxvTL4usQgOB
	 qJbTvErALK3fs7xkbPsGdj60l1Bh4Y919xEsbDW+zBh3egUDCW3V+EqQTKNEDkksBN
	 O8xmDdAqza6YIXWEeZJfUIRMRupueIpa14rXyAMhxAXb8HTr3iaeZCQy4bMkUKYN95
	 zFifZe1Gbwgyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: hda: conexant: Remove mic bias threshold override
Date: Wed, 22 Jul 2026 07:33:46 -0400
Message-ID: <20260722113346.1150776-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072003-jargon-yeah-7882@gregkh>
References: <2026072003-jargon-yeah-7882@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit f52524da7084c1a54683ae9fbc73e93fff19dd64 ]

Remove the mic bias current comparator threshold override (NID 0x1c,
verb 0x320, value 0x010) from Conexant codec driver.

This override was originally intended to support volume up/down controls on
headsets with inline remote controls, but it causes microphone detection
failures on some headsets with impedance less than 1k ohm.

After consulting with the vendor's engineers, it was confirmed that this
setting is board-specific and should be handled by BIOS/firmware rather
than the generic codec driver, especially since inline remote support
is not currently implemented.

Fixes: 7aeb25908648 ("ALSA: hda/conexant: Fix headset auto detect fail in cx8070 and SN6140")
Cc: stable@vger.kernel.org
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260713100329.306892-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_conexant.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index 82186c4364c9b8..0aed86820402c5 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -168,9 +168,6 @@ static void cx_fixup_headset_recog(struct hda_codec *codec)
 {
 	unsigned int mic_present;
 
-	/* fix some headset type recognize fail issue, such as EDIFIER headset */
-	/* set micbias output current comparator threshold from 66% to 55%. */
-	snd_hda_codec_write(codec, 0x1c, 0, 0x320, 0x010);
 	/* set OFF voltage for DFET from -1.2V to -0.8V, set headset micbias register
 	 * value adjustment trim from 2.2K ohms to 2.0K ohms.
 	 */
-- 
2.53.0

