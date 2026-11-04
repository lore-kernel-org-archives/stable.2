Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779387;
	b=hxEbRWtUeKWg6wBumKMfGFk3G6hJn6hjINn9oLKRia9oLtUz929CYmTzM5bWdx8mGHhl
	 0tARKB90ohb0fErUydgHb8kEXfGkG0KPeLtijLAnwVku/Ixb34WlSWKH4NeQqLPT4n7PO
	 fYpHQbbz3+S4RMajlS6TKmbo1osiPyTi87I/GBWx0GVWIPlVjsZkgJRdvrBusH1wHaNUl
	 GoMSbjHDy2T1EF29/PQWev+0G4R7riz7m32e8b2d6ffLNW3TiXr7PBtKrdBMNALlmQbaP
	 Oprvb6g2IRucxi5wjyfuRjizleLnhZe/TEB/ug49q50T3DgYIIsFfOL+cmL6iWQkl9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779387;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XV9GMZ9ARnbEUDTmpGeUALzqWg3SZrmQDiIpPzkxOHI=;
	b=rcEIwYF5J+qr6m2zxTifudMuukIvueK3rw21qb5PFgYM5JbNRrwAC7ul10RdZ6ZA541g
	 kflLeHB8xGMTKnaiSBX6gFKFMLox09XaRR8Dk05XClTYVpJK2Laup/hVTEGriKBJRV63+
	 9Gfm6806eLusZYClQUnOMODHZeycahTr8HFVYT00lugMmdJDreM7RvGRDnoUjPocHEUlk
	 h2AvdUq4FketeMCR0HmnfGjhu1PCKzssr9PWbanQx1QekWp+qvG/r7HgsNZiOohHIGwM5
	 N91f145MPfGBXt8ukImmEG8p+L9d5KUX5HAzGDmjicB2OEIaHNCqHnwEagq1qczkGGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mOSchalZ;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9A606A31B;
	Wed,  4 Nov 2026 08:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41A9A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=mOSchalZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=mOSchalZAy9EbFRbwYZ23/2idFY6qoZH4i8Zc0A9n1e6BDtESptFrxoLCKMVzeQF3ZZDx6nQ2p96C
	 +FRlxF/ewXV8gmhwkCbTc6ebxpqf9VH/+sihytAD7U9Zi8egDE0Tgp0mQO4yCc982LO5nvgzbwCqdi
	 0d46hUrpXaFIEeUE=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee46aeae6b46a9-3b0fa;
	Wed, 04 Nov 2026 16:03:03 +0800 (CST)
X-RM-TRANSID:2ee46aeae6b46a9-3b0fa
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHA-W6400298 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr09-12009 (RichMail) with SMTP id 2ee96aeae6b10a5-19406;
	Wed, 04 Nov 2026 16:03:01 +0800 (CST)
X-RM-TRANSID:2ee96aeae6b10a5-19406
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-kernel@vger.kernel.org,
	tangbin@cmss.chinamobile.com,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: cs42l43: leak MCLK when PLL enable fails on PRE_PMU
Date: Wed,  4 Nov 2026 16:02:57 +0800
Message-ID: <20261104080257.1144-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.52.0.windows.1
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

cs42l43_pll_ev() PRE_PMU arm enables mclk (when refclk_src is MCLK) then
calls cs42l43_enable_pll(). If PLL enable fails, ret is negative and DAPM
does not power up the widget, so POST_PMD never runs and the matching
clk_disable_unprepare(mclk) at line 1621 is skipped - mclk refcount leaked.
Roll back the mclk enable on PLL failure.

Fixes: fc918cbe874e ("ASoC: cs42l43: Add support for the cs42l43")
Cc: stable@vger.kernel.org
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/cs42l43.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 1b817e1a6..0ac9e2361 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -1613,6 +1613,8 @@ static int cs42l43_pll_ev(struct snd_soc_dapm_widget *w,
 		}
 
 		ret = cs42l43_enable_pll(priv);
+		if (ret && priv->refclk_src == CS42L43_SYSCLK_MCLK)
+			clk_disable_unprepare(priv->mclk);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
 		ret = cs42l43_disable_pll(priv);
-- 
2.52.0.windows.1



