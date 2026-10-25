Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792898565;
	b=ZBV2B3+6wjs/GJal/b3fZxqEghzhIXnjMmi5aHcP1LqNPPTt9IDWrIWgHZbCdQVJm2nM
	 9CRlw0MMrDT18aJ++fmnz4qHQubAk6f4QE2ACJU8vBwEURpTt7HEcymnU+q9+B6rO5IbO
	 1TKtqWyvi7KrCKVBBP5wnHdfVP0JOh0MHD2FC2lKL6/xXliy1mGzkPDpHMnB5XhKOrKpj
	 wChX689iS8HIr8dq1aireAG0T3lDd6qHPDD2PLR0y5GKBXCj9pq9UrtV15YEYMh0kImNj
	 jWlN34/wLY58PVS2hN8CMxAOlXv0Dz8cc2Oc2fumJkgNVVe7xfGLTvloQ/8VHhysCIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792898565;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=AGASU0krO4dcW1R4gKRMwQopKJJbDchm1ha/pJWZAsA=;
	b=IGg87jWPR6kWvJDI0ZIYdhTEi7ctMa+GKTSLzrrnFbtmWEJH/K2J42LSqshtm3dDkFOC
	 8s6Tp8FZzL8vwI6l24sofRPUTVmp/d7KIsp4A7eBCA7hYEpu41E7YOgYSbVtSGWjUVslN
	 DgdP5Q628RFN7DujP9sx6lFqhJjXlysLm3ZFzdf6mCkZ9+fup6bFGcC/+qsIRLhddYJ2l
	 m4y0pE0TWvecT3PvVjQYvKNOk3lyrgfZknuO6BVynfzugTdA22OJu9NB+Qcbt4idQRckA
	 x7nIMaIUGM3piwbYdJcGDCQSMoYtTUQazjZXMZTD17mA/rpr/0K4x6GGk6ykLa3RJhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=No8+gWTg;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77C606A31B
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 03:22:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F77C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=No8+gWTg
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-3514b90bb89so4750492eec.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 20:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792898564; x=1793503364; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AGASU0krO4dcW1R4gKRMwQopKJJbDchm1ha/pJWZAsA=;
        b=No8+gWTgwfulpHDt96mwihycd+Wu9qfSllEKE9t+HvO6m+kDhTow7SPHSag94h5mtO
         k9SV/0wj8JHhzjC9EWT1cYqSeb10oiisvS4P3LNsY+WfYeIskMw43EEbpopd8T05oTBc
         bS5tmHMpqzax1P5VSqrqqTn7Wa06sff2b2E7tavdtI00AVS9qtLp2PUxypWhOjnDwKpr
         OV/ATf8CH3msdfm6vwpSzRXmXDlLKOfzlLDi0YMeLdBFN85Sb45LqfNOGT+1uHLSqdqm
         IdNYNyDhsoaRb6PNXjBd26eFw+MyQzkk6jNPjY20PDrtFomjycE9kO0fN3L3bkhiPcf+
         YCPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792898564; x=1793503364;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=AGASU0krO4dcW1R4gKRMwQopKJJbDchm1ha/pJWZAsA=;
        b=zL9+wro0CUgfp9g5KDfLuHmgtuQLkakJiZBxLV/5Hu/AueeME/sLy79xXApioq3Dqx
         tsFRUTbjLC5Rm6RM4c8g1rCXqAAmu9bpxWRbm9wdakreQ8GHFxFvVCC4SINfUXgwj94G
         uCGG1zYmbns+EY6hkVgP5NAQuol6JEf4n8BqNKQH9oQq51+89grBFCplpC6LRIhL6wbi
         XKUnPTGCuR4UMLTOuh1oOfrBhhZe7pHSeknlibodSOY/mzp5Jmfkb11g3CbnYSrcO4kX
         QRuRarvfxclkiNGVzlii8b3/VKuQXWnnpb1HpnTwZ2tN4FMLzSJUxwngxiK8scqepPzU
         et2A==
X-Forwarded-Encrypted: i=1; AKwUvBxhhzTFNcVZUJbXu1hCv/kE2pF+raP0FwG+lOY/ibBF8+1SsJXA+d8QB8ZKkCVoD9Bgxmucfyc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiOww6KYeF08gcb+4Kvov4dVWInfgW/90bl2tVUR9uSouCDnqu
	9fjilEv0wKS+ZQXxo3io9t0umgD/ewaxKgWQEDBeHvTLG9TvlnMRZB/V
X-Gm-Gg: AYBFou31IpZLxGicXIYQuH68qDBmhi1cL41gQgWG83pKKzn36P2Di157JU8tie0dFkb
	5mCMQWd/q1RRvkwLEKqTeiR+RXkP+xDNKNOUKSsRy1kfvICpI7dslZc7bsrxKyjUIlgxyr4r6Mr
	YRFfCkfKDXOjvq73owev+25Ou3+yWUkhTSFcZkqGcktDBZ1qTUd/1g/fVIJamhRlgPu4wcFxftb
	wGoyO3ntXKpFuDgpV9XvLA1SVqMnaOBStEEgPbGqf92SqpTphLgpT14O3dkTor9KIpekdZvxjoE
	JOhPJxultHfuzw9Y7SG3VrH3UpiJsUG4NdXG5Nov1Mr3znl2EkI5zeD1PsDNv1leSR0h5PEexEw
	IDa615rJGfga+T+YG8JRN4olev4Lyq42PJ06DgV7J44onnDk5pBdIh+EfjZhqjZjba0M4gO4KYc
	G2HyXN+hxVyDELYQ/Gs4o71jIueCGKSZETqM1T3QP7UZ+QN483uXNtl971m3jkJwQK3KSBW+HsH
	lOxsWhOtxq2DOwtl7Q7kMh3z7avcy7F3iVtwP/K6+y4VB3ygRj+ijciC190UU0NaEf/kdOSvL8V
	GMiWHEyNY1EQvFKFC56yTevTxpm4QMgSR8CYxlBMrceHLv+31LrfGyBRaEhHQqtZBuUt8Rhxznx
	iCIeW8YcIT5aXZFHINFoUKuwre9sO
X-Received: by 2002:a05:7301:2293:b0:353:5908:36fc with SMTP id 5a478bee46e88-369e8483d0dmr5753055eec.17.1792898563532;
        Sat, 24 Oct 2026 20:22:43 -0700 (PDT)
Received: from [192.168.2.3] ([2403:581e:d87e:0:fc2d:ed31:e80e:412d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8d93663sm13602486eec.13.2026.10.24.20.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 20:22:43 -0700 (PDT)
From: James Calligeros <jcalligeros99@gmail.com>
Date: Sun, 25 Oct 2026 13:22:18 +1000
Subject: [PATCH v2] ASoC: tas2770: Fix error detection in
 tas2770_set_dai_tdm_idle
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261025-tas2770-idle-fix-v2-1-6c8096a87f44@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NzQ6CMBCEX4Xs2ZrtBqh68j0Mh1JWWMOPaZFoC
 O9ui3eP32TmmxUCe+EAl2wFz4sEmcYIdMjAdXZsWUkTGQip1Ei5mm0gYzDGPau7vFWNGnMuzro
 wJ4izp+cY78pb9ePwqh/s5uRJjU7CPPnP/rno1PujX7TSCk2N1OQlO+JrO1jpj24aoNq27QsrL
 QzewgAAAA==
X-Change-ID: 20261024-tas2770-idle-fix-b0104e591578
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, 
 Baojun Xu <baojun.xu@ti.com>, Sen Wang <sen@ti.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 asahi@lists.linux.dev, stable@vger.kernel.org, 
 James Calligeros <jcalligeros99@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066;
 i=jcalligeros99@gmail.com; h=from:subject:message-id;
 bh=+JeNkcg7xxI+ILpKkc9D2dhooDxOFAaRNmDxxxAetxE=;
 b=owGbwMvMwCV2xczoYuD3ygTG02pJDFl3S/9PC2C6sMlpjWb5kqiQAxK+y/QFU7w49D/mz5PUL
 bx6ZuWljoksDGJcDJZiiiwbmoQ8Zhux3ewXqdwLM4eVCWSItEgDAxCwMPDlJuaVGukY6ZlqG+oZ
 GukY6xgxcHEKwFSvk2b4Z/jZrKwqzDrcjN225MTJ+ibNTeFn9/eeXh3wr6hbZO7qnwz/XZ/mrv/
 ctLmwZ3Zd2rrmFSv+F9fMWTR5deCbaa9X1Isf5AQA
X-Developer-Key: i=jcalligeros99@gmail.com; a=openpgp;
 fpr=B08212489B3206D98F1479BDD43632D151F77960

snd_soc_component_update_bits returns 1 on a successful update, and
we were returning from tas2770_set_dai_tdm_idle early on any nonzero
return code. Change this so that only negative return codes are
treated as errors.

Fixes: af176d0787d2 ("ASoC: tas2770: expose SDOUT bus keeper via set_tdm_idle")
Cc: stable@vger.kernel.org
Signed-off-by: James Calligeros <jcalligeros99@gmail.com>
---
Changes in v2:
- Make commit header more concise
- CC stable
- Link to v1: https://patch.msgid.link/20261024-tas2770-idle-fix-v1-1-07b02d46ec2e@gmail.com

To: Shenghao Ding <shenghao-ding@ti.com>
To: Kevin Lu <kevin-lu@ti.com>
To: Baojun Xu <baojun.xu@ti.com>
To: Sen Wang <sen@ti.com>
To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>
To: Takashi Iwai <tiwai@suse.com>
To: James Calligeros <jcalligeros99@gmail.com>
Cc: linux-sound@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 sound/soc/codecs/tas2770.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index 882e19857697..6b9ec8f630fe 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -513,7 +513,7 @@ static int tas2770_set_dai_tdm_idle(struct snd_soc_dai *dai,
 		ret = snd_soc_component_update_bits(component, TAS2770_DIN_PD,
 						    TAS2770_DIN_PD_SDOUT,
 						    TAS2770_DIN_PD_SDOUT);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		break;
@@ -521,12 +521,12 @@ static int tas2770_set_dai_tdm_idle(struct snd_soc_dai *dai,
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 						    TAS2770_TDM_CFG_REG4_TX_KEEPER,
 						    TAS2770_TDM_CFG_REG4_TX_KEEPER);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 						    TAS2770_TDM_CFG_REG4_TX_FILL, 0);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		break;
@@ -534,25 +534,25 @@ static int tas2770_set_dai_tdm_idle(struct snd_soc_dai *dai,
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 						    TAS2770_TDM_CFG_REG4_TX_KEEPER,
 						    TAS2770_TDM_CFG_REG4_TX_KEEPER);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 						    TAS2770_TDM_CFG_REG4_TX_FILL,
 						    TAS2770_TDM_CFG_REG4_TX_FILL);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		break;
 	case SND_SOC_DAI_TDM_IDLE_OFF:
 		ret = snd_soc_component_update_bits(component, TAS2770_DIN_PD,
 						    TAS2770_DIN_PD_SDOUT, 0);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		ret = snd_soc_component_update_bits(component, TAS2770_TDM_CFG_REG4,
 						    TAS2770_TDM_CFG_REG4_TX_KEEPER, 0);
-		if (ret)
+		if (ret < 0)
 			return ret;
 
 		break;

---
base-commit: cc3fc99f1bce93c3ae3771ef98cb91a566da857e
change-id: 20261024-tas2770-idle-fix-b0104e591578

Best regards,
--  
James Calligeros <jcalligeros99@gmail.com>

