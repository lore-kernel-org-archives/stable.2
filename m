Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=51.250.56.165
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793370445;
	b=wctlYeZ0dfhFQ4Lthx9A06iOA1esZmzdywfFuQs0VNnqc7+9G/eoNvzg/LBL1AQCK/bg
	 X1gBXaJyMwvGZ7E+xr0yl8SdUu1vaY/RkgL3jcFxZFpD4PwJH2akYH3czWp+PiUDNrpQc
	 csjlpSAOSUwpvAr3u3Sp3UCBWgGlV7e2xRsoAIIjz+Vl3YdpW3SdJn8i7cu9fGLxemjpx
	 jIEscK2stsAJ21ppAhke1Oqjq+23J+sFc6jz2AQyvquyDRshz9twcrxxPGHdmWOb1YWoH
	 b2lJKWNbXYZnUT1EXcjfn+OhKd3a4sdwFo8nhXN+OsLm8AI0pNBBlcTUytPlwxc34vw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793370445;
	h=DMARC-Filter:Received:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=l1vEPyv4ZEYEenWJIonE0gIqYnvnC3U2rXltIEBtB7Y=;
	b=blZsw0G1D13jkOi4NGglItM0dN4Hgs3uPQZNcvlGAn73IwSwajWP8Tfg+LbY+5E6R4Kw
	 E2SeaPMF1p6W2jrAIaxbvnx8JZZGMOV8yLEQABfOLa8y3M2mOb2pDcgViA6w2flkum1s5
	 invGem7uZ9RVMTY2lH0D/Z32sUuSsiS208RMimkLolx5DF3R1vIdiwGW6zjGAq8/qQD0m
	 EObCC9I82HoKDvbhT+YAVjBL7Q/MPjmQpEqJlKsDmdoKtxvvztLowZWMirPyLqwaMQRZ/
	 1ZRhbVMfJG8ATgbWMFwRiQLVrg5BmLXGd2yOJIXJ9byiyc5XXtewNPcTF+J8giI2pDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideco.ru;
	spf=pass smtp.mailfrom=ideco.ru;
	dkim=pass header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=i7iEdlRe;
	arc=none smtp.remote-ip=51.250.56.165
Received: from smtp.ideco.ru (smtp.ideco.ru [51.250.56.165])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0B606A31E;
	Fri, 30 Oct 2026 14:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E0B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ideco.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideco.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ideco.ru header.i=@ideco.ru header.a=rsa-sha256 header.s=ics header.b=i7iEdlRe
Received: from [169.254.254.254] (localhost [127.0.0.1])
	by smtp.ideco.ru (Postfix) with ESMTP id E9ECD35F16;
	Fri, 30 Oct 2026 19:27:21 +0500 (+05)
Received: from fedora (5cfcac1b.dynamic.mv.ru [92.252.172.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.ideco.ru (Postfix) with ESMTPSA id B20D530F77;
	Fri, 30 Oct 2026 19:26:52 +0500 (+05)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.ideco.ru B20D530F77
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ideco.ru; s=ics;
	t=1793370440; bh=l1vEPyv4ZEYEenWJIonE0gIqYnvnC3U2rXltIEBtB7Y=;
	h=From:To:Cc:Subject:Date;
	b=i7iEdlReoUtWXOiVr/e7HRfg1DnyewpSJuXcns3CXhgW2wBHW3eC+OA9KC+d/XFuH
	 xpkK23F0sUFGX17csS8IUn5M+KNwFtfqNyz/o3F8zZYHMwVDb0YpLoBh5xXnBl1DSM
	 6GYwlFWLz1Iw64Ke2KjR/pBOtBRmYgvBWHa0vAUS0Ok1gSmnrwVLOooh1vcSBFDQ19
	 2wLKMN4ifgn0Q9ZTx23Hcm+qWcTcmAe5AfkA2BZfRl9fRbrkArvJ9vW6yq56W/FXw2
	 /WU48viIDAo3Zvdfjf4Tx5mxlgfas8Yy8F9yTHunIGjz7qeU330eG41F1Kas+Ppjbt
	 DenkuxWx/l/5Q==
From: Alex Kazinsky <a.kazinsky@ideco.ru>
To: David Rhodes <david.rhodes@cirrus.com>
Cc: Alex Kazinsky <a.kazinsky@ideco.ru>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Brian Austin <brian.austin@cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	James Schulman <james.schulman@cirrus.com>,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: cs35l36: Handle zero sysclk frequency
Date: Fri, 30 Oct 2026 18:26:36 +0400
Message-ID: <20261030142637.415971-1-a.kazinsky@ideco.ru>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

simple_util_shutdown() calls snd_soc_dai_set_sysclk() with a zero
frequency when mclk-fs is configured, the clock is not fixed and the
last active stream on the DAI is closed.

cs35l36_dai_set_sysclk() passes this frequency to DIV_ROUND_UP() when
calculating the FS monitor windows, resulting in division by zero.

Return success without updating the FS monitor windows when the
frequency is zero, as there is no running clock to monitor.

Found by Linux Verification Center (linuxtesting.org) with SVACE
static analysis tool.

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>
---
 sound/soc/codecs/cs35l36.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index 5fc8ec292e3c..266b95397873 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -910,6 +910,9 @@ static int cs35l36_dai_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 			snd_soc_component_get_drvdata(component);
 	int fs1, fs2;
 
+	if (!freq)
+		return 0;
+
 	if (freq > CS35L36_FS_NOM_6MHZ) {
 		fs1 = CS35L36_FS1_DEFAULT_VAL;
 		fs2 = CS35L36_FS2_DEFAULT_VAL;
-- 
2.56.0


