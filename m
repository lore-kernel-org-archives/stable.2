Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794860190;
	b=Ok5vjQLgwGwuldWGZ1IyMO0r1h1A0+Pm8w2exbvpspMsp8311mHY1QlxqKV/R1ebIxwX
	 NGe7xPilt+xhjBJDVvLjUcgczd6u3UU/R5tvbYqVQuQPSQ9EoxJNrQIFx6p1hbLAzPgB/
	 CG3t6e+aIL4Cy1npnCj+7lXs8aXKHK6Gq6AhJUfu1c8bwzF/R+cRTkX9D1VOEx4mpGYGB
	 xjlYDamG3GN3amxempGgb2yYlmTlbkciNPDFsru3mGYG2jy4CZI5YTaFUZah+RRsV3a2l
	 8thqEyc/zIk25zul2m8C5lxzCkkOGbbdAK2DSWl/gbjMujsGqBadoIn1yZcfUxoKtfw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860190;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=72vSkN7QWDjTb/UUTmMIDRQ1rcbFn8s8bM+JdHjC0lg=;
	b=qq2FLf/wqQPmJ9NCJGHNtS8XBWZPFgpSJ4z/AcHkiWDskTC1Oa8kHXJgvMLJcNnKh32l
	 qJLatlKSpeSqwBn5mkasCnJ/MR27ImPGiwWPhLLuXzQPzaSK0Ias5SWsXz+S7c1TGKshS
	 tHF5LLsY4EcKZk82g10QXcTWjhNLKx7/TCToqXXhzZS0kqdfq7u5O0Q+jYnA3nw7b3NPq
	 oDwAnTgI0aYJWOzUZFd+fEfvpL5w2gYWtgiq1+LwizIzSXQt7p89a/MxyNbGRD80Ogb7p
	 FixDmXkU45j1aaXxU+84Vv7vkla1Tjy4pA81yunthyZkNk2T85bIzsMCn7jRK9BRH2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwItsvUt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5753606A322;
	Mon, 16 Nov 2026 20:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QwItsvUt
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794860190;
	b=Cedlzh64XYdQxMxKi9aJiyWtNhE7dGPbeGldh09Vn6KpDhmiyo5OYoS5t9fQD801sVOp
	 PyyyBxs46TaCKGgtXNzwaLibqszTsgqaWq7W1G8kBwyynLZmtGtqV3CTMFCrJBdbZifhT
	 czeJEh6Gc78MAzTxrh2sDGDYqLFiWM3hZmuwZEaOxnMRqTOLy+XuwnBczMFHlhOuBfa1M
	 P5c3xSiC1vv9H9XTzStGAjTu/et13emSqDWx714vRtVzziMhvRZ6j+Q9osBlhGoAD6EmN
	 0GUwNCvnZhU1bkKMqTaB8s8109zny8ddjinhxpsvt3oTPG8vZ5RQqT8Vu0uRca63ZSw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794860190;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=72vSkN7QWDjTb/UUTmMIDRQ1rcbFn8s8bM+JdHjC0lg=;
	b=sBhQblsRBcUnE7I7iGBWI+ZyanLajGSEuoLrtBUbwbvTwzTirw5C6kYOzyBA8IjujTyf
	 isK9TMp+N0+D6MbeXl5sAlaZ3WkSvp7Eb6RBuhuYogJMExQrxy5w1I7EqemWzLND6yN5L
	 fvX5I1LK63vnVLzJ5PLG81V9d2JEAEOIr3xQh3T0Mt8XNjLHfdmm8FEaQdV/5v6DsGQ36
	 4UWORvgY5JVGJEmJ4VtmpZJns8aZeolbN5A+w4YiqrKjV1qKZVSk9VywZidUIi9dzBRbx
	 uktjhwdrZ6iPrOSig3T3S6VvsMsvqLZ7iOLrS9GCg/qrt0m8FC8Pd2kVGmPRmmOwdfw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0F2CD1F000C4;
	Mon, 16 Nov 2026 20:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794860190;
	bh=72vSkN7QWDjTb/UUTmMIDRQ1rcbFn8s8bM+JdHjC0lg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QwItsvUtw8gDoWsbt0gs7QSlghEZAOqv/3HA2rgIbsYkMhHY20PGWdnybE0Ez/hZx
	 EnYyjPqDdADujMbAbNDwRdM6tMl9JW/zvZWPzJy08E8HyA5XJynb6VzW2COuA0HGNs
	 irJHjzQOldgPg1H8XkMJG0/U1unQraapr2jMUbFB3uoCmgQVHIZ2560+TpXRi9dlQJ
	 EX+5aC+KK3LY0gormylNCOuPIHA6/Wr14YWso/9l1DY4TgQGnK7meIgnkZ3QewSzOo
	 DVCm5WOpRAG9ioJypkmQPdr9Q8106mLfMje2/nr3E2/zRkrkx280o4f3PjuHmQYwQf
	 /bHye9TQigeyA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 965124A5B5;
	Mon, 16 Nov 2026 20:16:29 +0000 (UTC)
From: Marc Herrero via B4 Relay <devnull+marcht.proton.me@kernel.org>
Date: Mon, 16 Nov 2026 20:16:29 +0000
Subject: [PATCH v2] ASoC: qcom: audioreach: apply volume changes to a
 running graph
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
Message-Id: <20261116-q6apm-vol-live-v2-1-fbeba4402984@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WMQQ7CIBBFr9LM2jFCFK0r72G6KDC1k7RAoSGah
 ruL3ft37yfvbZAoMiW4NxtEypzYuwry0IAZe/ciZFsZ5EkqUYeL6sOM2U84cSa0SmthNZmraaF
 KIdLA7z347CqPnFYfP3s/i9/7N5UFCtR0uxAN6twa8QjRr94dZ4KulPIF6Y/zRKwAAAA=
X-Change-ID: 20261111-q6apm-vol-live-d6bb1dbec7c9
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Marc Herrero <marcht@proton.me>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794860189; l=5278;
 i=marcht@proton.me; s=20261111; h=from:subject:message-id;
 bh=mp2MbI2XiexMCnav2onYjsf+zW4C1sDOoQtZdybVDJk=;
 b=uWiabstwfrwXapwCEIJ2z2qJ6Bro5hEqxGWwLMW3uDhCYHmT2E99Vw3EjNByte2HbhREeY3Dz
 KVuNWySWd8gAvHKEH8VPFKD/x3rxY0eECoB45g/r+eDSsjvYBQR21K0
X-Developer-Key: i=marcht@proton.me; a=ed25519;
 pk=pIPy6L+INgiuJt7L7umVilPgpzy/Ni3QS77ToLj/H9c=
X-Endpoint-Received: by B4 Relay for marcht@proton.me/20261111 with
 auth_id=1490
X-Original-From: Marc Herrero <marcht@proton.me>
Reply-To: marcht@proton.me
Content-Transfer-Encoding: 7bit

From: Marc Herrero <marcht@proton.me>

audioreach_put_vol_ctrl_audio_mixer() only stores the new gain in the
module. The gain reaches the DSP from audioreach_pga_event() on
SND_SOC_DAPM_POST_PMU, that is when a stream starts, so changing the
"<stream> Playback Volume" control while playing has no effect until the
next stream.

On QCS6490 (Radxa Dragon Q6A) shairport-sync uses this control as its
hardware volume: the volume set when an AirPlay session starts is
applied, but every later change from the phone is ignored.

Send the gain to the DSP right away when the widget is powered and the
graph holding the volume module has been started, since the DSP rejects
the parameter before that. Otherwise only store it, and the PGA event
applies it at power up as before. Hold the DAPM lock so the power state
cannot change between the check and the update, keep the old gain and
return the error if the DSP does not take the new one, and report no
change when the value is the same.

Fixes: 36ad9bf1d93d ("ASoC: qdsp6: audioreach: add topology support")
Cc: stable@vger.kernel.org
Signed-off-by: Marc Herrero <marcht@proton.me>
---
Found on the Radxa Dragon Q6A together with the two fixes in
"[PATCH v2 0/2] ASoC: qcom: audioreach: fix S24_LE playback and route
mixer disconnects". This one is independent of them.

Tested on 7.2.9: with the patch, moving the AirPlay volume while
playing changes the output immediately; without it nothing changes
until the next stream. Builds on asoc/for-next.
---
Changes in v2:
- Only send the gain when the graph holding the volume module has been
  started, since the DSP rejects it before that (Srini). Add
  q6apm_is_graph_started() for this.
- Take the DAPM lock so the widget power state cannot change between
  the check and the update (Mark).
- Return the error and keep the old gain if the DSP does not take the
  new one, so writing the same value again retries (Sashiko).
- Link to v1: https://lore.kernel.org/r/20261111-q6apm-vol-live-v1-1-be85eef649c1@proton.me
---
 sound/soc/qcom/qdsp6/q6apm.c    | 13 +++++++++++++
 sound/soc/qcom/qdsp6/q6apm.h    |  1 +
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index 8e3314a2738c..034d42edde22 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -839,6 +839,19 @@ int q6apm_graph_stop(struct q6apm_graph *graph)
 }
 EXPORT_SYMBOL_GPL(q6apm_graph_stop);
 
+bool q6apm_is_graph_started(struct q6apm *apm, uint32_t graph_id)
+{
+	struct audioreach_graph *graph;
+	bool started;
+
+	mutex_lock(&apm->lock);
+	graph = idr_find(&apm->graph_idr, graph_id);
+	started = graph && graph->start_count > 0;
+	mutex_unlock(&apm->lock);
+
+	return started;
+}
+
 int q6apm_graph_flush(struct q6apm_graph *graph)
 {
 	return audioreach_graph_mgmt_cmd(graph->ar_graph, APM_CMD_GRAPH_FLUSH);
diff --git a/sound/soc/qcom/qdsp6/q6apm.h b/sound/soc/qcom/qdsp6/q6apm.h
index 9092359ccf90..b84ccbee4926 100644
--- a/sound/soc/qcom/qdsp6/q6apm.h
+++ b/sound/soc/qcom/qdsp6/q6apm.h
@@ -120,6 +120,7 @@ int q6apm_graph_prepare(struct q6apm_graph *graph);
 int q6apm_graph_start(struct q6apm_graph *graph);
 int q6apm_graph_stop(struct q6apm_graph *graph);
 int q6apm_graph_flush(struct q6apm_graph *graph);
+bool q6apm_is_graph_started(struct q6apm *apm, uint32_t graph_id);
 
 /* Media Format */
 int q6apm_graph_media_format_pcm(struct q6apm_graph *graph,
diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 612d8f03e6e9..956f8e9e6a76 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -1322,11 +1322,33 @@ static int audioreach_put_vol_ctrl_audio_mixer(struct snd_kcontrol *kcontrol,
 					       struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_dapm_widget *dw = snd_soc_dapm_kcontrol_to_widget(kcontrol);
+	struct snd_soc_component *c = snd_soc_dapm_to_component(dw->dapm);
 	struct audioreach_module *mod = dw->dobj.private;
+	struct q6apm *apm = dev_get_drvdata(c->dev);
+	long gain = ucontrol->value.integer.value[0];
+	int ret = 0;
 
-	mod->gain = ucontrol->value.integer.value[0];
+	/*
+	 * The PGA event applies the gain when the widget powers up. Hold the
+	 * DAPM lock so the power state cannot change under us: either the
+	 * event sees the new gain or it is sent here. The DSP only accepts
+	 * the parameter once the graph holding the module has been started.
+	 * Keep the old gain if the DSP did not take the new one, so that
+	 * writing the same value again retries.
+	 */
+	snd_soc_dapm_mutex_lock(dw->dapm);
+	if (mod->gain != gain) {
+		if (dw->power &&
+		    q6apm_is_graph_started(apm, mod->container->sub_graph->info->id))
+			ret = audioreach_gain_set_vol_ctrl(apm, mod, gain);
+		if (!ret) {
+			mod->gain = gain;
+			ret = 1;
+		}
+	}
+	snd_soc_dapm_mutex_unlock(dw->dapm);
 
-	return 1;
+	return ret;
 }
 
 static int audioreach_control_load_mix(struct snd_soc_component *scomp,

---
base-commit: cde5523c75f1320a55ac1d55a717ccbb566557f0
change-id: 20261111-q6apm-vol-live-d6bb1dbec7c9

Best regards,
-- 
Marc Herrero <marcht@proton.me>


