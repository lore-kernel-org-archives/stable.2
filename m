Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889577;
	b=DEtg/b/uIYuNiC/ihr5X5VuPdedUv+lWsAFWMrdCOp9+jLWoLKpZVf33asD23LSCgwS6
	 1W8DgHnyhkiTugykBjdBTErRi41ybBnlSnVWtcwg89CI7mmBXejSGvazkaPxiK7vsVX34
	 /wUEYxqlItgBltLAIR5vkzFBzr3coUHAM4HDNY+Mrpzaipk4Gh3HA7+fJA52mvQCmuuGf
	 NdXtCSxUMa3cG1dThLPxQhsEdUXJpMODtZOUiiPXRiSnbIEn4DGXvvfo2EQo6HohJtgNd
	 Gj6+PK1taGK76o1q1IS7tu9SUU63e9Rsm+GXJfqZHCpA7e/847FZWw9xN+Ev8Rt87zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889577;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=njgf5UPHo8Faorvq6/FKdPgFNJJSzJEgyKnAWBFh7GM=;
	b=n/1EHBPhfzA4kOOSLEemBqLvaIBMvcvaWqtlE5m4u/j6GapHh/CXRgpGRlyKP/Ax7+CF
	 C8J8YmzrsuaHi+0qUdHhZDGJ8avvOQ/hmP9IIqTCFsiioEwGDYNi/1MPCfTQjPiriUf0g
	 QJCLa07jVrPJ3lPnkbIXHAUyoOEJpNF8Vinn0GVV4rr62NqdwR98eESEzMWlZrnnj0LMh
	 hHXFCErM4e981/01ZM8I/WvEcIbFA5Is4HJemDHhxy1jQ+oXap8mjsg5QOPXL54y0YuIa
	 58GxdNzXtOerQqccw6JxKYXpfK+JU8YgsSazcVM13/ugUApYrZ6IUoHIz8rStQOvF2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzD1YAW9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79685606A329;
	Thu,  5 Nov 2026 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DzD1YAW9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483D91F000C1;
	Thu,  5 Nov 2026 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793889577;
	bh=njgf5UPHo8Faorvq6/FKdPgFNJJSzJEgyKnAWBFh7GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DzD1YAW9uCjWYYmjVIX+iMXDNfWjxtBB/0Kzw60zW5x3QU0ZvTGp/QuQb+qJ12DHN
	 l+vHP8r6o8kPuSeJ8Hdi/AXNWj4nJ9KLWST36jTWpdcKrbmNKgaqva+1j5Af3GYvaY
	 t91ixKpMoRSEhdU0+yNeNT2VxadIq0H6uKmSAnlU6qjLj++XAvTFZthbcY9S/pyI9O
	 5x+Cm4Z+PBN3qEwKuZuLukR0/cco0TPYvlN5F4PKBrzrcK9pZHWk6EwaMcSgy64xr6
	 BFj5NsJxZQiQY/R2rgdgcd8OPyOxp+1gFs3nfL91t8FUogdcl0ial5IEPJKKDjnSl6
	 qfdCOf2OQLvUg==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Joachim Eastwood <manabian@gmail.com>,
	NeilBrown <neil@brown.name>,
	Grant Erickson <marathon96@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lokesh Vutla <lokeshvutla@ti.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6/8] pwm: omap-dmtimer: Handle negative error codes from get_pwm_status()
Date: Thu,  5 Nov 2026 14:38:08 +0000
Message-ID: <20261105143847.2559586-7-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
In-Reply-To: <20261105143847.2559586-1-lee@kernel.org>
References: <20261105143847.2559586-1-lee@kernel.org>
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

Store the return value in a signed int and check for negative error
codes before testing register bits.

Fixes: 6b28fb6f3ca3 ("pwm: omap-dmtimer: Implement .apply callback")
Closes: https://sashiko.dev/#/bug/linux-f4782faa-466d-43a8-85d8-6d6181ee2243
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/pwm/pwm-omap-dmtimer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtimer.c
index 51830a87275c..1e4d8b9e224f 100644
--- a/drivers/pwm/pwm-omap-dmtimer.c
+++ b/drivers/pwm/pwm-omap-dmtimer.c
@@ -111,9 +111,11 @@ static void pwm_omap_dmtimer_start(struct pwm_omap_dmtimer_chip *omap)
  */
 static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
 {
-	u32 status;
+	int status;
 
 	status = omap->pdata->get_pwm_status(omap->dm_timer);
+	if (status < 0)
+		return false;
 
 	return !!(status & OMAP_TIMER_CTRL_ST);
 }
@@ -126,9 +128,11 @@ static bool pwm_omap_dmtimer_is_enabled(struct pwm_omap_dmtimer_chip *omap)
  */
 static int pwm_omap_dmtimer_polarity(struct pwm_omap_dmtimer_chip *omap)
 {
-	u32 status;
+	int status;
 
 	status = omap->pdata->get_pwm_status(omap->dm_timer);
+	if (status < 0)
+		return PWM_POLARITY_NORMAL;
 
 	return !!(status & OMAP_TIMER_CTRL_SCPWM);
 }
Cc: Lokesh Vutla <lokeshvutla@ti.com>
-- 
2.56.0.398.g882cbad275-goog

