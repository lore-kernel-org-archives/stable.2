Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90A3264D8
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719462; cv=none; b=pgE+QO8F9kNGG8awdOyIOZrzqk78BVgCkf9AL4ZfL2XHmMWNfnPav93w3WK++uGccsXjkwnf2pv+PvZ+ld7KffswWhKnW0OMLHSP25bG7v8oaO1Rl9dgxEU9gxD+33OvcM3HOSDZXpbfpj8MYROZPd1q57htLRNWHDijO/9mVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719462; c=relaxed/simple;
	bh=zRkIdp8i0Z1q4k/Lint4s1PsVI5vGI+tdVdMDWI2DPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kxy/yg91qFfJH9Zgrc9fHQnnh9IDXWGkI2xNu5cBHHMWuo+6MSn2tDMi8UZ7Yq6ij6Evu3negzQCKuW/JhHak3FrgPwTUJfMpI2H5ASiBvYSKoAMpRgmfPh+mg9mELCRm17z3d7LQGLpL6xsMj0OQekY3Ry4LJpkOXZY+eB3Sac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGNXVBWl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGNXVBWl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D42A41F000E9;
	Wed, 22 Jul 2026 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784719461;
	bh=jK5ywpNFsp8uUqwLqrYZJ1MhwJfcbaWsJf3htZvaVM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGNXVBWlCGZ3thsNHdBW1zbqMoOM7xmdUSWbp5QJc6MmuwbiCK4+C6jmXk9XU6lz2
	 7wlYna8B6r4r6hcpOh6DHnGd7ELcWUBcU2Pqb+/YxjuEwfwxDtEgWSQEiAGcJcy7Wo
	 TwNny6b+8Y/BfFMQpBv000GCFqtrM6B2Ci28l/DQEFB/pM0Bkz6NG6yLazubNwFV5l
	 YT4PHH7l3msxCx8YmavpWurI927qE6gO/sO19j4OZkfMGxNI1YiePAs/CESFsPDXfu
	 meDme3Hjj2gNwaEdj5NwQdtO+NIAIGhhJ3qx0ZG8IUAeEDaIKnXSZM7yeTkDvM2zXO
	 u5Z1ksgJXls3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: hda: conexant: Remove mic bias threshold override
Date: Wed, 22 Jul 2026 07:24:19 -0400
Message-ID: <20260722112419.1114390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072002-drinkable-verbally-6958@gregkh>
References: <2026072002-drinkable-verbally-6958@gregkh>
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

