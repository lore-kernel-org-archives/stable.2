Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.134
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216661;
	b=Njfta1pSHT/H9sQhwAnVnrtieNlgEE7mxRbQD1rPdJG1SNN7bsaR1W3rESnfUbL7uI2U
	 bxdFhxxqjx7F1W0sFQGrxbS8JfgFpUBPaod0Yr8pOsWyfMPSntSf3Mt1VEinFWhFiISfT
	 N8FkDQve39JFNf8Pf+A1PO1uCco3jnV1hLvwThkGy5jUoorCLMYur+InCZZ49j2iBOg3K
	 zocYsSVJEE9kCUr/cGExJp5+XIjtM8lOuROr+t+9S+W1jey7LqsDK1ai/NvBCZBvvp6X9
	 pysWukjSov8IE5Fp/Nn0c1F1xf2LyVVwJo5iYv6zZnBi72l5IuJCFPfTDJ4Z0irHpjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216661;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=JgAKUlEUuz6maqK7hbvvEeeZ7/qE4Qo5HQOFPDSQICY=;
	b=W+pnNts//KIzi6DZcjidfXJZbqFvOofmeaf+Tg1hatYpg529AdKFiUIP/OupcewLwUlC
	 hb7DpTdhWk0XOIfPi+ln9jNFOaKvaroqaoiRh4OTBAzqfEGfPMQRsOwSQn8kaNa3mCih0
	 02CpPcQNtGCln572cJmUsb0rwARtuT5IHWpLFHot4to7aR3nKEdtiRge8OWtY4yxMtRhS
	 41iRDU+xIJ4/qDkFc3o6U3Hz42ZB/J3ATMyD9rY2qPFH35up7xjXAgAQ0GDHeRfpReSQN
	 KCIYwS079/s9wVzPd0j9TcGl8rcESJSuHCwadKkyvt6OVvtVanzEIS6DucSHO0M3nSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=Q0uQe5ze;
	arc=none smtp.remote-ip=210.130.202.134
Received: from mo-csw.securemx.jp (mo-csw1800.securemx.jp [210.130.202.134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7BD606A686
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 23:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7BD606A686
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=Q0uQe5ze
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1795216620;x=1796426220;bh=cIbodR/XVhsbWAIiVgFLKO6Mw6icryVrfaDYCtM7rrU=;b=Q0u
	Qe5zeEE+uJe1ajSkkMNoQ8IOhGIVAC/V3Z3QO7SR6en71T1LLxUsmPyewN6SwjPSdU7qFNXlOb3OA
	UTbdZxaeg4JMqh29jbYr920FeT1AIqxkIro5KMqsV2pWvtxP+FOP/USanySuVPGF4Q4asHUB3jv44
	BR3oD+wagBOvE3bAvWHNeDqMfPDY+8FwqIttn9PpyCLFp8bMxhvqcXzaGB3xJPzqMytIXCo/eGHbP
	shsriiguRUbQWvle0X/B49zBibgL4TLAS/eCm/vC8mwpk/lcEp6e7ZEe5lAcnkXjW5zeZ2mmVTI2W
	2NHTKczrttQgPpLfqPWJW+jpO/FXM4Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 6AKNGxOJ1562708; Sat, 21 Nov 2026 08:16:59 +0900
X-Iguazu-Qid: 2yAbofA4l2UX7hebhq
X-Iguazu-QSIG: v=2; s=1; t=1795216619; q=2yAbofA4l2UX7hebhq; m=EYKGd8QtqtflUoNl79Cob+/9un5NQTHETAPQ1vtAxN4=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jWWSW27n0z1xnZ; Sat, 21 Nov 2026 08:16:59 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH v2 5.10.y] ASoC: rt7*-sdw: harden jack_detect_handler
Date: Sat, 21 Nov 2026 08:16:44 +0900
X-TSB-HOP2: ON
Message-Id: <1795216604-17006-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
X-Mailer: git-send-email 2.7.4
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

commit 0484271ab0ce50649329fa9dc23c50853c5b26a4 upstream.

Realtek headset codec drivers typically check if the card is
instantiated before proceeding with the jack detection.

The rt700, rt711 and rt711-sdca are however missing a check on the
card pointer, which can lead to NULL dereferences encountered in
driver bind/unbind tests.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://lore.kernel.org/r/20220606203752.144159-6-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[iwamatsu: Drop patch for sound/soc/codecs/rt711-sdca.c]
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro.iwamatsu.x90@mail.toshiba>
---
 sound/soc/codecs/rt700.c | 2 +-
 sound/soc/codecs/rt711.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index 80acf0daabf8..7d221f93523b 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -162,7 +162,7 @@ static void rt700_jack_detect_handler(struct work_struct *work)
 	if (!rt700->hs_jack)
 		return;
 
-	if (!rt700->component->card->instantiated)
+	if (!rt700->component->card || !rt700->component->card->instantiated)
 		return;
 
 	reg = RT700_VERB_GET_PIN_SENSE | RT700_HP_OUT;
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 0e343ad205fc..e0117e576fd3 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -242,7 +242,7 @@ static void rt711_jack_detect_handler(struct work_struct *work)
 	if (!rt711->hs_jack)
 		return;
 
-	if (!rt711->component->card->instantiated)
+	if (!rt711->component->card || !rt711->component->card->instantiated)
 		return;
 
 	reg = RT711_VERB_GET_PIN_SENSE | RT711_HP_OUT;
-- 
2.55.0


