Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484856;
	b=BuuSYmayCnVpRWSWKZMAAIV+d3JuuAYXcqi+VpmMgyMHPvhjhay4o7/J+10oYw8ANSz0
	 HJN76H0uDJdMo90CuQ+cqkmBq+awV292QZwtQHcikzJwqE2mxBVXB34u4g4aroHLxsm15
	 CDlWRA7eaFd9cp+WbjManBI2A/x6HG6vnEaqdhaC3f4a5o6Qb+sCREginomgq9GiA25sL
	 49QihQfwvcT1kPrruyQ8AlpbGFX9QwfQxSSH6OlBWJYe6hvIr4LN4ERnibdje+V7vYxk7
	 mk0JNlqeBx0J2HWEMg38GJ+DW+IdD9Y6JDXICI8+yPsfKJWiuQEnKoAjKecB4Vz8Pqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484856;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=guE7ZJZ3qLp7RsghCUoXrScsS8RkMWxfffDe/dOb2Ac=;
	b=O6wi0Iphw5EJkDFptkZ9t2TJ5AscqRiRaPMWTKs+Dk4DdYRqQbtNT0FTtL9pH2d7PmcO
	 g0a1X/oqrM3uFQm7dM1QQfSB04N1FbUKs9ZYQgWn9MlqD369FKjRV9m5X1db2ShpBe5oH
	 1KXjyGfFaiS8o6cOkQzRaJ5PUQsJy53KUSESqMW9bBavGELFOg/U6yxNWkjXVHLtAJ1X0
	 OFRpMV6E9U61lIt24klGD1iilWdFZcaVC65u2R9Xobd98fCl2Ent1a2cXMCFFsapNby4N
	 0NbWWbIT8tcbNyZpJrFOj0VrKNEgEHRUoRb7boA8jvNCzxqnGI1BDqUbioz+4o8grJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=AGFUYe9G;
	arc=none smtp.remote-ip=91.218.175.112
Received: from mta0.migadu.com (out-112.mta0.migadu.com [91.218.175.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A7606A33D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D93A7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=AGFUYe9G
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=1VR5x+ugKPEt0b9SEHSYjBwUNYlANCVfeg67lrVVgdg=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792484853; v=1; x=1793089653;
 b=AGFUYe9GpRlVhE9nlzvo13UF5KTU2V93loI0eYip8n/rMyuIbHaqkW3ByvxxiuVH/JVBq/5X
 FisurBgG15DkPS14VlE6r86cz+kSinJqGl9XwlOovTS//67zN5EtDnt/hGrwIXjaEGiubWJd/qy
 h5kNakn76vKOEpavUP115DMk1v2BNy7GV1LuxAHl1vrYdlhAJ8CAr5t3utJf41xmgGqeoSi5Am0
 kDvkI8kFktUCi5CMSYDJMX6ncmsIqbSNVxMEwv41AlOVIM8OvBqBgzD7NGYoriy/GbLQrIau8yr
 IPqpWsjBB9wsN4voyB260+AvYa89M499upDFKz5F2FNbg==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bf7a3a9bbbdbd63e;
	Tue, 20 Oct 2026 08:27:32 +0000
X-Mizu-Trace-ID: bf7a3a9bbbdbd63e
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Srinivas Kandagatla <srini@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Val Packett <val@packett.cool>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] ASoC: codecs: wcd939x: fix ref leak and NULL deref with USB-C audio
Date: Tue, 20 Oct 2026 05:26:26 -0300
Message-ID: <20261020082631.1509275-5-val@packett.cool>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261020082631.1509275-1-val@packett.cool>
References: <20261020082631.1509275-1-val@packett.cool>
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

Some code issues were found during review of a port of typec code from
wcd939x to wcd937x, pointed out by sashiko-bot:

* wcd939x->wcd_mbhc may be accessed by the typec callbacks which are
  independent of the ASoC codec lifecycle, don't leave it as NULL/PTR_ERR;
* wcd939x->typec_switch reference was leaked on unbind, put it there;
* the device_node reference returned by of_graph_get_remote_node() was
  being leaked, add a __free annotation to the declaration.

Fix them in wcd939x as well.

Cc: stable@vger.kernel.org
Fixes: 10f514bd172a ("ASoC: codecs: Add WCD939x Codec driver")
Signed-off-by: Val Packett <val@packett.cool>
---
 sound/soc/codecs/wcd939x.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wcd939x.c b/sound/soc/codecs/wcd939x.c
index 26fe0b6313cd..56e041e70fd4 100644
--- a/sound/soc/codecs/wcd939x.c
+++ b/sound/soc/codecs/wcd939x.c
@@ -2466,6 +2466,7 @@ static int wcd939x_mbhc_init(struct snd_soc_component *component)
 {
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
 	struct wcd_mbhc_intr *intr_ids = &wcd939x->intr_ids;
+	struct wcd_mbhc *mbhc;
 
 	intr_ids->mbhc_sw_intr = regmap_irq_get_virq(wcd939x->irq_chip,
 						     WCD939X_IRQ_MBHC_SW_DET);
@@ -2482,9 +2483,12 @@ static int wcd939x_mbhc_init(struct snd_soc_component *component)
 	intr_ids->hph_right_ocp = regmap_irq_get_virq(wcd939x->irq_chip,
 						      WCD939X_IRQ_HPHR_OCP_INT);
 
-	wcd939x->wcd_mbhc = wcd_mbhc_init(component, &mbhc_cb, intr_ids, wcd_mbhc_fields, true);
-	if (IS_ERR(wcd939x->wcd_mbhc))
-		return PTR_ERR(wcd939x->wcd_mbhc);
+	mbhc = wcd_mbhc_init(component, &mbhc_cb, intr_ids, wcd_mbhc_fields, true);
+	if (IS_ERR(mbhc))
+		return PTR_ERR(mbhc);
+
+	/* May be accessed by platform dev typec callbacks, only set if valid */
+	wcd939x->wcd_mbhc = mbhc;
 
 	snd_soc_add_component_controls(component, impedance_detect_controls,
 				       ARRAY_SIZE(impedance_detect_controls));
@@ -2499,6 +2503,8 @@ static void wcd939x_mbhc_deinit(struct snd_soc_component *component)
 	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
 
 	wcd_mbhc_deinit(wcd939x->wcd_mbhc);
+	/* May be accessed by platform dev typec callbacks, clear */
+	wcd939x->wcd_mbhc = NULL;
 }
 
 /* END MBHC */
@@ -3171,7 +3177,7 @@ static int wcd939x_populate_dt_data(struct wcd939x_priv *wcd939x, struct device
 {
 	struct wcd_mbhc_config *cfg = &wcd939x->mbhc_cfg;
 #if IS_ENABLED(CONFIG_TYPEC)
-	struct device_node *np;
+	struct device_node *np __free(device_node);
 #endif /* CONFIG_TYPEC */
 	int ret;
 
@@ -3434,6 +3440,10 @@ static void wcd939x_unbind(struct device *dev)
 	put_device(wcd939x->txdev);
 	put_device(wcd939x->rxdev);
 	component_unbind_all(dev, wcd939x);
+#if IS_ENABLED(CONFIG_TYPEC)
+	if (wcd939x->typec_analog_mux)
+		typec_switch_put(wcd939x->typec_switch);
+#endif /* CONFIG_TYPEC */
 }
 
 static const struct component_master_ops wcd939x_comp_ops = {
-- 
2.55.0

