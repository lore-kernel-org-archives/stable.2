Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.130.202.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795139011;
	b=JsY7tYeh0xiI8x5+SEVW8KwE1dLJbl7hN3xmIEFtJ8I0VP8SN+H9JwWFuomlz61rj1gG
	 EmcJrTbLk3oHfd42IlXR76AXdNt/EO8kPjPXq7frNSj3Y+Wcd/mbfbFtNw8GSsQF2I9mj
	 ou+FWS/M9BQH3V63nUvKJl8vj8VuJ4BewVoN47Dpm/qEFgp8d+fGHcqxqI2EEprV8M+jc
	 blNA+2PvzA4PqSMmSvf+1LL1WX3XApl23JRZKs8CC96/g9C2ciPzhOdXSFsVmEMDmUD3p
	 SMwprQJi3H9aHjHS5jhziSag0HNLNq+R7TMFUq6eDu6InhNhTEnOLt9rySfGX1dkXSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795139011;
	h=DMARC-Filter:DKIM-Signature:Received:X-Iguazu-Qid:X-Iguazu-QSIG:
	 Received:From:To:Cc:Subject:Date:X-TSB-HOP2:Message-Id:X-Mailer;
	bh=JgAKUlEUuz6maqK7hbvvEeeZ7/qE4Qo5HQOFPDSQICY=;
	b=mCf3Cxs8GPVYdMC/HHux/NXA/86Rwe0ykkxseLDl+eqWeJZ7zFG+4jc1bMRSxVqHY2sp
	 zqSgUcwhFHnNauVya2kVow6CPrxqJ2mpCvUg+Re67oO9ohmalvonB0RtWeZCX5SH3mey2
	 drdkMaYtwkkrQ/4HtdRgkIgVtdZcE8e/iYTs1+h6gkT7hE71+uigDJ2ViiphBR9ePJTuc
	 N/ZCLc6UsEVLjJxcOxCy/qWVxSeAVoW8MYe6geschYP8KH2VtXaKHcsSHH4FSNih/77pd
	 xh0foXCZux6KI6D5oF+mMzTO6bOqAPh/MSeV3agtwVUI+Z9zKRpZw7mNcS1+imxNxtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.toshiba;
	spf=pass smtp.mailfrom=mail.toshiba;
	dkim=pass header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=BqJGfMSZ;
	arc=none smtp.remote-ip=210.130.202.152
Received: from mo-csw.securemx.jp (mo-csw1802.securemx.jp [210.130.202.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952D2606A325
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 01:43:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 952D2606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.toshiba
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mail.toshiba header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.a=rsa-sha256 header.s=key2.smx header.b=BqJGfMSZ
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:Cc:
	Subject:Date:Message-Id;i=nobuhiro.iwamatsu.x90@mail.toshiba;s=key2.smx;t=
	1795138987;x=1796348587;bh=cIbodR/XVhsbWAIiVgFLKO6Mw6icryVrfaDYCtM7rrU=;b=BqJ
	GfMSZDNesKBoOHajBVagHUQztUqWrqjrLq1VC7FfsQ0WNuHpklGrdMwMNQBS2K/oWojLM0PmFPKtk
	Sox8HJpeGJ+fhu8FEdymRpDWR6fI6LjdOnNRNOdJMwHBKQ5Z4eqScWuC5BMxRp0chuKEHsniy4lVz
	rYOG20C9DrLYDj3UP84/eT4zrOeaZgQlGiRzgmX+s7sh+Qn8LABcOUov3qBNSF5hYKFiI948FNT24
	dh2o7ZzqbQUQwC0HirgqvUR0ZpWnHgOFQoFbcAiWtOi0+c8RHb9FyVaMbWw560D3FrYf0NHLFfwCi
	tGyk2DL8X3+Y5Lu5DE1ZHPJXOXhHfUw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 6AK1h70Y2083118; Fri, 20 Nov 2026 10:43:07 +0900
X-Iguazu-Qid: 2yAbgtIaJNNIPR6lWm
X-Iguazu-QSIG: v=2; s=1; t=1795138986; q=2yAbgtIaJNNIPR6lWm; m=heTbTaw5WzBZuA0jRSebcjnTAjQFnESsVEChbLPJTWs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4jVylZ5HV2zyPQ; Fri, 20 Nov 2026 10:43:06 +0900 (JST)
From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sashal@kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Subject: [PATCH] ASoC: rt7*-sdw: harden jack_detect_handler
Date: Fri, 20 Nov 2026 10:42:57 +0900
X-TSB-HOP2: ON
Message-Id: <1795138977-10812-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
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


