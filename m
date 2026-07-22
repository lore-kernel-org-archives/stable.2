Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4451DED5C
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784717467; cv=none; b=GdzBCtxnuVE5r9nKdBVnDFKg4sHNZPbF1fK7sseBi46em6rOkz6fm5OXZcGaUOwcqABiqBSQ10Ey5sFo69Arbtz/ts3yzGQ1bBG0nXx20zV483wjCB0ySNi581/T7AuW+HN/SQGdUYOUjN3TdaetIQQg+x+/zKz61Qr9k+btfug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784717467; c=relaxed/simple;
	bh=mwKAQwcS7eE20mgmeBDxXXzw8CKZ+mp6E+Vp8wnBbV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g/b1HwaxrR/LHuEJTM/iqOOdVxe77Za5Eb6MXz7mREgoUmlN2W8kJPHNbrzuOZ3GB67Kz/bBqUyuRDSE3nAqjMat0+8420ISPDV4whkJmuHIh+3N1oi/oFwc5j3T3OK4lEhPCGSa5DK6/Lbq26RkxVhtV7ecJQJqXgiP1z4atGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYTLnmxW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYTLnmxW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAF5A1F000E9;
	Wed, 22 Jul 2026 10:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784717466;
	bh=SGLnvQVM5nP+Lfv9L4ZaOmPbCjyZ7bJBSFvvo7cBdtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYTLnmxWJV4bWPhRCOK7QbDx6KQCNfzlpg5ClqtosYpV9ILbslMaJrMHI4T6fQJwN
	 9rEbBCSyyLQKx/PWuO6d9NbnXxtGjpOZlenq0aPY7hGWQnaMgGEZtj9Sw/Hz0gG6vH
	 vLXKG5ttE/5LU1x3Tv4mdZSw+6FhbkdS8RVeDFzFx0R/hR29ruHGq8+KXEYjyUbWHl
	 2m6iiaF+NjRSkhw4oDWd0K5X1DgP7uXCMM6x4rP4EQfokL3jioxtcaDIjuZgKs8rrB
	 dH1/sqxKOJQR1Oo5+uSRpjLtrx5ZjmeJzoM5iM+KBUvrukDjmfClKEYB6WTEIs5INr
	 XeiLX7m1IxieQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ALSA: hda: conexant: Remove mic bias threshold override
Date: Wed, 22 Jul 2026 06:51:04 -0400
Message-ID: <20260722105104.989130-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072001-reference-frosted-9a1e@gregkh>
References: <2026072001-reference-frosted-9a1e@gregkh>
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
index 0296777bb380b4..90089fc131859b 100644
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

