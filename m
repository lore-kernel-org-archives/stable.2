Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420430;
	b=xqCLItjtyc/yhEPT1A4fAW4lgsu0jPsO5YvDrJYmId4tayoxT90JUuv8rfgYkJNaiFsS
	 r+0gm6/VFo2BlA0IsJQL+mk9Ckq4DrQfyjAF5UtGkzvuXdvPfloO4MdO3+Zmts7KXlQw/
	 NlEm29rpuZBIzsQjvzZ5UFlM2RO9i2UJI+HnvMx0f+XCfUO4rGZDx+rD+19Gwk3CrLxwT
	 h/FKbJgH2OX5wVfpvUnruliXwvraEoEWaxzJ1ocU5LxD/7K/PBI78ER15sZ6hVoWMefHN
	 fvJLN/Tx3C1j/o/USt+b1DkLpXPesn9LvIuOe8mmMGzTnvLyQJ0Np11+YG6Ts/0xqrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420430;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wCflPhiBOM2wwLKapiZUlRiMMbL5Bsuewp71SnPqdqw=;
	b=2m0wmcvv/Y8k+CMGCaD/i7bP3KrYD3FJYduWvuoaWBszoloImZkrkpiRNFEwFO+fFoU4
	 8L4D2maUOXqP5QaZ8g+bEedOr/Zda1DOuGd1+q5/nQc4NHvg1eaMRg+RimcEobi53pczE
	 hRyngCe+1/gJwsBi6tH2rotdTvBmCKHMA8vBJxik81PRrSjaYuu4mU+LNRvq/xuTuQCH/
	 Pq+Hw7juahzJqlg8PkdN/IJ4DrTSdg4GpZFypcHWxLwMGeWy3I6IMamnOBXzXR+hzr1NG
	 AZs5Wxfbv2B/a4pRDSojWTnUmA4V7qALro4nEHCiOGrBqXvEYQnDw2Z1SOUwjWKlsww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD5yUT6h;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D2606A31E;
	Mon, 23 Nov 2026 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RD5yUT6h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415871F000C0;
	Mon, 23 Nov 2026 07:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420430;
	bh=wCflPhiBOM2wwLKapiZUlRiMMbL5Bsuewp71SnPqdqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RD5yUT6hus4AHMI4YNvF8LI1wOEXsfLFEkxAT/PM8MlAWEtOzF67ThIgDxVJHcrds
	 D6KuVV2wcNEdCsNyjNqskJL9mfFjnfPVeuKuxJO1VombSqBVa2sGQQ/jt3XJQKqMnm
	 c/Wahjxub1JH/1flx0owuDWYf4BRaWpM/xHqa3VQ3twRwaRue0848QG94gv/Rvb4dl
	 HcCBM17Q4tZYvtGwNqvtWuVXqJ+Axc2Awe93URgiKcDNaxnQVxy9Y5bQjU7IQKmAMG
	 IFT0ruOtk27Agj1jpsP+A0TWq5y0fUZHzWF3SUpfa4dc06o1IUpTU9TxgYpFmxnd6C
	 a4Zght/K/G1rA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>,
	Chen Wang <chen.wang@linux.dev>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Joachim Eastwood <manabian@gmail.com>,
	NeilBrown <neil@brown.name>,
	Grant Erickson <marathon96@gmail.com>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/5] pwm: omap-dmtimer: Propagate get_pwm_status() errors in apply()
Date: Mon, 23 Nov 2026 07:52:53 +0000
Message-ID: <20261123075320.379664-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075320.379664-1-lee@kernel.org>
References: <20261123075320.379664-1-lee@kernel.org>
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

omap->pdata->get_pwm_status() returns a signed int that can be a
negative error code on runtime PM failure or invalid timer cookie.
pwm_omap_dmtimer_is_enabled() and pwm_omap_dmtimer_polarity() store the
return value in an unsigned u32 and test OMAP_TIMER_CTRL_ST (BIT(0)) and
OMAP_TIMER_CTRL_SCPWM (BIT(7)), misinterpreting negative error codes
(such as -EINVAL or -EACCES) as an enabled or inverted timer.

Store the return value in a signed int and propagate negative error
codes through to pwm_omap_dmtimer_apply().

Fixes: 6b28fb6f3ca3 ("pwm: omap-dmtimer: Implement .apply callback")
Closes: https://sashiko.dev/#/bug/linux-f4782faa-466d-43a8-85d8-6d6181ee2243
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Propagate negative get_pwm_status() error codes through to
   pwm_omap_dmtimer_apply() (Uwe)

 drivers/pwm/pwm-omap-dmtimer.c | 54 +++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 14 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 51830a87275c..08d444b3928e 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -107,13 +107,15 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
  * pwm_omap_dmtimer_is_enabled() -  Detect if the pwm is enabled.
  * @omap:	Pointer to pwm omap dm timer chip
  *
- * Return true if pwm is enabled else false.
+ * Return: 1 if pwm is enabled, 0 if disabled, or negative error code.
  */
-static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
+static int pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
 {
-	u32 status;
+	int status;
 
 	status = omap->pdata->get_pwm_status(omap->dm_timer);
+	if (status < 0)
+		return status;
 
 	return !!(status & OMAP_TIMER_CTRL_ST);
 }
@@ -122,13 +124,15 @@ static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
  * pwm_omap_dmtimer_polarity() -  Detect the polarity of pwm.
  * @omap:	Pointer to pwm omap dm timer chip
  *
- * Return the polarity of pwm.
+ * Return: Polarity of pwm, or negative error code.
  */
 static int pwm_omap_dmtimer_polarity(struct pwm_omap_dmtimer_chip *omap)
 {
-	u32 status;
+	int status;
 
 	status = omap->pdata->get_pwm_status(omap->dm_timer);
+	if (status < 0)
+		return status;
 
 	return !!(status & OMAP_TIMER_CTRL_SCPWM);
 }
@@ -237,16 +241,21 @@ static int pwm_omap_dmtimer_config(struct pwm_chip *chip,
  * @chip:	Pointer to PWM controller
  * @pwm:	Pointer to PWM channel
  * @polarity:	New pwm polarity to be set
+ *
+ * Return: 0 if successfully changed the polarity else appropriate error.
  */
-static void pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
-					  struct pwm_device *pwm,
-					  enum pwm_polarity polarity)
+static int pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
+					 struct pwm_device *pwm,
+					 enum pwm_polarity polarity)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-	bool enabled;
+	int enabled;
 
 	/* Disable the PWM before changing the polarity. */
 	enabled = pwm_omap_dmtimer_is_enabled(omap);
+	if (enabled < 0)
+		return enabled;
+
 	if (enabled)
 		omap->pdata->stop(omap->dm_timer);
 
@@ -257,6 +266,8 @@ static void pwm_omap_dmtimer_set_polarity(struct pwm_chip *chip,
 
 	if (enabled)
 		pwm_omap_dmtimer_start(omap);
+
+	return 0;
 }
 
 /**
@@ -272,22 +283,37 @@ static int pwm_omap_dmtimer_apply(struct pwm_chip *chip,
 				  const struct pwm_state *state)
 {
 	struct pwm_omap_dmtimer_chip *omap = to_pwm_omap_dmtimer_chip(chip);
-	int ret;
+	int enabled, polarity, ret;
 
-	if (pwm_omap_dmtimer_is_enabled(omap) && !state->enabled) {
+	enabled = pwm_omap_dmtimer_is_enabled(omap);
+	if (enabled < 0)
+		return enabled;
+
+	if (enabled && !state->enabled) {
 		omap->pdata->stop(omap->dm_timer);
 		return 0;
 	}
 
-	if (pwm_omap_dmtimer_polarity(omap) != state->polarity)
-		pwm_omap_dmtimer_set_polarity(chip, pwm, state->polarity);
+	polarity = pwm_omap_dmtimer_polarity(omap);
+	if (polarity < 0)
+		return polarity;
+
+	if (polarity != state->polarity) {
+		ret = pwm_omap_dmtimer_set_polarity(chip, pwm, state->polarity);
+		if (ret)
+			return ret;
+	}
 
 	ret = pwm_omap_dmtimer_config(chip, pwm, state->duty_cycle,
 				      state->period);
 	if (ret)
 		return ret;
 
-	if (!pwm_omap_dmtimer_is_enabled(omap) && state->enabled) {
+	enabled = pwm_omap_dmtimer_is_enabled(omap);
+	if (enabled < 0)
+		return enabled;
+
+	if (!enabled && state->enabled) {
 		omap->pdata->set_pwm(omap->dm_timer,
 				     state->polarity == PWM_POLARITY_INVERSED,
 				     true,
-- 
2.56.1.750.gf70dc682cf-goog

