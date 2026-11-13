Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532576;
	b=EDgfZ4nOtZnlxIsU3TSL8B2Quyjl2zGPWa7+72F48L65gNH1knKv35k5So/OtKkqN0bx
	 7Jc8sKWoQIC/nBVLuzZrbWGNIMcmNODmhX2QKzHsl30cFyi0mW9OgRXVT2vWAftLvnRcz
	 PzGgbVIroqBZvf5w4xYAGE8KNk4mlqCOlo1TKMHX0C0Ttxg5qOqM+7ApAmC2tRHsnDYGy
	 4BlMm9mvaT3HH6eAFwN0fXDIPJuOd9At7eG9IqxwNtk/99HBccqlCjnniiPw4qeCzUuU5
	 XlGxh2AwHexjfClQUmx3UiDaaEbh69QS7EAjXQ5cPeEdgY8e6MXefCTYcGuwPutRbyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532576;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JNdBAOa+TFV1IP3lxTmaS3RQ5HdEY6SUzwA1WIODDeU=;
	b=NBRdagPzgb/VtTiPElBJRnxy6GVwP3vCSpsIVv7vShbuWIHKMX7ebvgb6W2APeSSXzrt
	 llX4vTycGJC8awaOkWJ42MgvnT/4guE5N0qTcukZ6JCI9O1VAoHcRQ39/VEfnp+12Q9TI
	 LWQFZLmWeG4q4bJOeZlFDMfk8F5gme1aZMT3A+Fg19Xn5jDj0KwiRl1a46jx0LH2hdsVK
	 5uDE82rx7elOJPV1zpP/41KV0C0m1KcDe2LO5pmMrg6Gdh5qr5ntgSrT0Wq8Fb1LuB4TX
	 syRoYm0xCTDBPh0NxgbCmE0N3Vi62IQK23dxc4NtC7TYKZq9MPYQL7HzyALTvtpwPWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKgx1JC+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30FF606A332
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cKgx1JC+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E01F000C5;
	Fri, 13 Nov 2026 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794532575;
	bh=JNdBAOa+TFV1IP3lxTmaS3RQ5HdEY6SUzwA1WIODDeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cKgx1JC+GHhUTXp3Yxal3fvz0xRDLlhji6pVmDhOjG6R0vi/V86n3rzKpVIhId9tD
	 F/YSk77VuJqPXf4T/sUkxSRyt8TGBe+BNXMCoqFYFhkoSN2r37EclA6gTa2lDqVxi1
	 1dqL5cd1yZUybuBTmsi+mbbrbRavgQOMB1A8Re6PqOsU9sa+PiEdMQkAbxl6oBmC8/
	 EZs+3BG1l8rcfAqcD8cGbynY0okx0uMY8Vf7rx++GBMUyDt47aHC95MwFLdcXJqvgp
	 jnZ22HL8SLBCkgY28y/Cbad6/g+gqPdx8Z6aJd4bINYvpPfFzK3smrssBuB8d/xUMx
	 p5uygDQLtjhUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: pcm: Optimize cpu_latency_qos_*() calls
Date: Thu, 12 Nov 2026 20:16:12 -0500
Message-ID: <20261113011600.592705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201441-failed-6.6-9017bc3d13da@kernel.org>
References: <20261109201441-failed-6.6-9017bc3d13da@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 9f6f4e97fd53908aecb0979507d9ff10a22288eb ]

We have a few cpu_latency_qos_*() calls in PCM callbacks, but they
seem suboptimal in a few aspects:
- We call them at each time when the hw_params changed, but explicitly
  do remove and (re-)add; this could be
  cpu_latency_qos_update_request(), instead
- The setup of cpu_latency_qos_*() doesn't have to be in hw_params at
  all; it's not the place where the actual parameters are set up, but
  rather better at the prepare callback.
- The hw_free calls cpu_latency_qos_remove_request() unconditionally,
  which may be poking a WARNING when it wasn't queued.

For addressing the issues above, this patch cleans up and reorganize
the cpu_latency_qos_*() calls in the PCM core by a couple helper
functions.  Now, they are set up at prepare callback, and cleared at
hw_free and release callbacks via the new helpers.

Link: https://patch.msgid.link/20261002150420.879056-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Stable-dep-of: 9017bc3d13da ("ALSA: pcm: Prevent O_APPEND open on OSS streams")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/pcm_native.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 4b570d8aa80eb..989e822c1059c 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -726,11 +726,32 @@ EXPORT_SYMBOL_GPL(snd_pcm_runtime_buffer_set_silence);
 #define is_oss_stream(substream)	false
 #endif
 
+static void pcm_qos_req_clear(struct snd_pcm_substream *substream)
+{
+	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
+		cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
+}
+
+static void pcm_qos_req_update(struct snd_pcm_substream *substream, int usecs)
+{
+	if (usecs < 0) {
+		pcm_qos_req_clear(substream);
+		return;
+	}
+
+	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
+		cpu_latency_qos_update_request(&substream->latency_pm_qos_req,
+					       usecs);
+	else
+		cpu_latency_qos_add_request(&substream->latency_pm_qos_req,
+					    usecs);
+}
+
 static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params)
 {
 	struct snd_pcm_runtime *runtime;
-	int err, usecs;
+	int err;
 	unsigned int bits;
 	snd_pcm_uframes_t frames;
 
@@ -837,12 +858,6 @@ static int snd_pcm_hw_params(struct snd_pcm_substream *substream,
 	snd_pcm_timer_resolution_change(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_SETUP);
 
-	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
-		cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
-	usecs = period_to_usecs(runtime);
-	if (usecs >= 0)
-		cpu_latency_qos_add_request(&substream->latency_pm_qos_req,
-					    usecs);
 	err = 0;
  _error:
 	if (err) {
@@ -921,7 +936,7 @@ static int snd_pcm_hw_free(struct snd_pcm_substream *substream)
 		goto unlock;
 	result = do_hw_free(substream);
 	snd_pcm_set_state(substream, SNDRV_PCM_STATE_OPEN);
-	cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
+	pcm_qos_req_clear(substream);
  unlock:
 	snd_pcm_buffer_access_unlock(runtime);
 	return result;
@@ -1976,6 +1991,7 @@ static int snd_pcm_do_prepare(struct snd_pcm_substream *substream,
 	err = substream->ops->prepare(substream);
 	if (err < 0)
 		return err;
+	pcm_qos_req_update(substream, period_to_usecs(substream->runtime));
 	return snd_pcm_do_reset(substream, state);
 }
 
@@ -2750,8 +2766,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
 		substream->ops->close(substream);
 		substream->hw_opened = 0;
 	}
-	if (cpu_latency_qos_request_active(&substream->latency_pm_qos_req))
-		cpu_latency_qos_remove_request(&substream->latency_pm_qos_req);
+	pcm_qos_req_clear(substream);
 	if (substream->pcm_release) {
 		substream->pcm_release(substream);
 		substream->pcm_release = NULL;
-- 
2.53.0

