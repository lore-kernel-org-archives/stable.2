Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536774;
	b=xYkruRXrLnZkwbOoXCLz1M2CDkxBzm5eoKXdLoIHBm2wrz1VE6Mr5FTcugHhwztcufMP
	 Xb2GqQY3+bxbd9JgOWhjhDrc1GabKD+1nJlejzY7RUEyIIzK5CNKdq5RtXYj0c6BSDQv2
	 M9aisEGc0ipD8zQBKhUvkZDmpPuJo1Gphfg3rc+Eox+yi9HNrMp59h771h8ds+hUYzDVK
	 ykBLOpPjmEXRqilFzlYOlbMaqAfmU2dSqs4Z/FoXOcvzXvQ35gfOQ7cIdczcAbCN200Cz
	 kQ7qEEn64VOz07bFi+j1qeXe5GPZhVhMa2n10qpMFJG0g1OuS6+fiVklm/s+mxD+FSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536774;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7RQ9RBA5x9Nd+4ZMBKcqKPnw0EDZGiwzB1t6FDXJBqY=;
	b=ZP1Q2uPDphvlkGecS2dP+/y7Z2FWqIAoFNlME2LNJoqfBo1W5bz1J2MdU4XCbHMpWc+C
	 cfnfTyFxyChHD2HAvytMEeYKiCHjBS5FapMQG+/+3iWZJHt7ooeqnWTJgDFv+78s7n/Ev
	 dz+s52POvTn6nXcpcxQpu5PHmTq+BLtUFSefEiij5fdd2b2dxPXEpXojkDQk2KmBhVoon
	 /zXcjjfx6875y5jJ3hE5BFMkFjEwwcUqp+s/jmhl6yqEC1AQ3v5I7zzheykR2nzGlo8DA
	 YNDM+Dd+BM/XEWX2d4YsjnnRajBqJxR/RfXqD7fruiXnwkDt5rzOrSB1h2su+VOvPkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe+dKnqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47320606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qe+dKnqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8362B1F000C4;
	Fri, 13 Nov 2026 02:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794536773;
	bh=7RQ9RBA5x9Nd+4ZMBKcqKPnw0EDZGiwzB1t6FDXJBqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qe+dKnqyMkJH1hx6ionrUNs1zv0+2UcQ49ygkHDFN89W5kJwmhIWrpcujWMZzMfm5
	 vPzAs4RNsi7soEvguPVL7NaJSWR4iLwrQt3okCeCMUrVlA5ZziR0ro5w52PTvGCZsQ
	 wjm5q+BD1bjkhGK5r0f1qdaac8kJfNHlqDAwYORdix9ogcmbQdiXfIRK1xs7DlL96S
	 7au+MFIsKG8wmQsiOFuLMm8ocQ7pTCpRzHUNUfEb1210ltHc1ohynPOi2G37eE/SVL
	 jnqAqLh6ScVlZ+J4CJwQdIkbw54rKhY0azkmeHdw1P6ai3UyPis+NuGhhkXJO0Y57s
	 N/kYI94T+QKcg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] ALSA: pcm: Optimize cpu_latency_qos_*() calls
Date: Thu, 12 Nov 2026 21:26:11 -0500
Message-ID: <20261113022215.632821-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202443-failed-5.15-9017bc3d13da@kernel.org>
References: <20261109202443-failed-5.15-9017bc3d13da@kernel.org>
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
index e085d061daaa4..e861404d393b6 100644
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
@@ -1972,6 +1987,7 @@ static int snd_pcm_do_prepare(struct snd_pcm_substream *substream,
 	err = substream->ops->prepare(substream);
 	if (err < 0)
 		return err;
+	pcm_qos_req_update(substream, period_to_usecs(substream->runtime));
 	return snd_pcm_do_reset(substream, state);
 }
 
@@ -2746,8 +2762,7 @@ void snd_pcm_release_substream(struct snd_pcm_substream *substream)
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

