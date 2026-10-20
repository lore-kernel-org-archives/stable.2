Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484848;
	b=YVOiL/rcwPl0Qhtm/vV73ATLys5cl3rkQlKoxen6Bx4j75dOjO7xLiB3CmSl/wjN0E+G
	 dFFQ29Cgrv1K7T6Yvr95OB17QxspHqrusdaWVY0DAFnBCqBNK3StCnAKH3OgAJUNY0KHu
	 i84hucc+1Tq+CaeoHWj4GhIu2ZuvZdGMMBErJt+YPgts7HvFYx0cpcfVgOOi3CQNRM+ua
	 iN1dnKWnHqeqV+po7Xu9o+3azj1af4Sb00JKveJxC7UZ1drl1uM6eG4yDy56UhZCsfxal
	 2a4JQwCPwVw/2+XK4X7LReqQmGrOF781ZHKnPUp9CVp0HiDndFPtz7xl/SQb9Fs0qwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484848;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yIxpS/nuJ0i6AS7+eZWK91Iqf/SzxpUyTm1wvTNr/u0=;
	b=iMO3ZYLxATd34/mZmkO0gR//un5HlU/iQa9KBU4RvGhV0osOoEezVtRV7Qq6ZOXeohaQ
	 /GzmBhmJekBuqdWs+NQgXQ0mO4Kqb5bczfeRiF1/aBinagg8gQDpESCLjIem4req0KsOe
	 mqUtp5J8yVEbwjOKQmKVhCX7uUqRlHCkQlxqgRwzJ7jAHDVpgAseWArp3qHbjuH9Y4QJZ
	 C/+y/4+9Hryw1+h4p9DvjuxGctym+2mTbVX0NDyFqTp4DqqntZrGL9CrSbGAQZNL2/SuI
	 28SmCAGFBvR2thvfTfEvakCCIHcq/ODU8GLJE4Dpf0SfjDiTVRgCw6bkaol+pK8V/xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=fS8M2vLn;
	arc=none smtp.remote-ip=91.218.175.105
Received: from mta0.migadu.com (out-105.mta0.migadu.com [91.218.175.105])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31760A261D
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 08:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F31760A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=fS8M2vLn
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=oOYcLk8SgSFDbJWze+I2ylWBx/emk3yDYK2BxxUumHM=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792484845; v=1; x=1793089645;
 b=fS8M2vLnm5JXRpF2X4MlviCyLPU8Nxzy6AuKhy/obZNC5zS59PtD+8fNnSGAkqq4KQNHjzyB
 KbTWFwW/725TEDmJMF6RGQZWCs2hrDBmqf3nu1ElubPTyq2a7dJHnBsSTBdvnz0E44mo7Ebw7CG
 OYbDOGqwUeKF+YirVZ9KEtCxRzy3wTVitViakdAu6kyj/RlzjkXYyx6z9KvH0agQQpMCbI57DNG
 Zrbwt9AsDzuj2zvPp4WSUL4g0/z/P1Jjl276hDJZMW810OBtVzdo44EAKjXXIGniX9HX7DQ632Q
 p0lp6KckzXa5m1sRzdU8C01wzXj9uqhRlujY+ahtvJA/Q==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 0ee227f5af125605;
	Tue, 20 Oct 2026 08:27:25 +0000
X-Mizu-Trace-ID: 0ee227f5af125605
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
Subject: [PATCH v2 3/4] ASoC: codecs: wcd-mbhc: guard against NULL cfg in typec_report_(un)plug
Date: Tue, 20 Oct 2026 05:26:25 -0300
Message-ID: <20261020082631.1509275-4-val@packett.cool>
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

mbhc->cfg is only set by wcd_mbhc_start() which is called by the codec's
set_jack op. wcd_mbhc_typec_report_plug/unplug are called by the platform
device's typec callbacks, which are not synchronized with codec ops, so
a hotplug could be reported before set_jack was called. Though unlikely
to happen in practice, add a check to be safe.

Found by sashiko-bot via review of wcd937x Type-C integration patches.

Cc: stable@vger.kernel.org
Fixes: 0c105997eefd ("ASoC: codec: wcd-mbhc-v2: add support when connected behind an USB-C audio mux")
Signed-off-by: Val Packett <val@packett.cool>
---
 sound/soc/codecs/wcd-mbhc-v2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 850be84d65ce..fd40c1686d66 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -594,7 +594,7 @@ static irqreturn_t wcd_mbhc_mech_plug_detect_irq(int irq, void *data)
 int wcd_mbhc_typec_report_unplug(struct wcd_mbhc *mbhc)
 {
 
-	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+	if (!mbhc || !mbhc->cfg || !mbhc->cfg->typec_analog_mux)
 		return -EINVAL;
 
 	if (mbhc->mbhc_cb->clk_setup)
@@ -611,7 +611,7 @@ EXPORT_SYMBOL_GPL(wcd_mbhc_typec_report_unplug);
 
 int wcd_mbhc_typec_report_plug(struct wcd_mbhc *mbhc)
 {
-	if (!mbhc || !mbhc->cfg->typec_analog_mux)
+	if (!mbhc || !mbhc->cfg || !mbhc->cfg->typec_analog_mux)
 		return -EINVAL;
 
 	if (mbhc->mbhc_cb->clk_setup)
-- 
2.55.0

