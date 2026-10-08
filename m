Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932503932C4
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486079; cv=none; b=mgXW3XT9x/D2wF63aaIPOqSm07HTOqKzPLFkUDyiIqwHETDoA1VgGq1pDbd8Kj6RFvEII8sMZzgLpc/RUBBoCcktNi+yd38lqCJMF4EeY0SJhd6JKPNTBLh/GQAeDXvZSPO4jP/lHAs4mjFfAl6T5cMdArnUdulQ1QsLHyYi198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486079; c=relaxed/simple;
	bh=NV297hPhL0HERbs2IyoZwWWLUO44XQvPJKokBPrQwBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Az3jErfmVqYIexTtwCw0W85vDZ2nhvHjamngNVc8S1I/pJehm1CN2BDaY9gBLVAw0UUEFC56e9xQMoWupCMbK3kUXjOLXNLf7jcLR5QJLipnfvVMm3nuvlrG1YKnsNFr72LV2sBQlEmcW/PivtNe5UER01og76rwleaZlI2A8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=coIvsxtw; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="coIvsxtw"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso6941418eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486078; x=1792090878; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZaD67jW1zaHMwLOSmvc/1aeKMLwK1RpzPD9+yhLQ1do=;
        b=coIvsxtwe3OV7tt8S6kRysvfsC6BEQ5PNXTuAfGjE10y3+yzM9qrK6TfsNRJPlFUuv
         kzXxy5bAk0dr3SGYjVqYYNjKutuHvkNM2sUPCwzNlMzbIWYZ5e8llppSiCArViX4plSH
         4hhwChUs/5C2iQrbdIt5cMkxSz+5ecD5EopWGVEvgFkNkgkRCFZ0xweOu+109/5ueu+I
         52OXT1LQEEhTkyoceFCJfvE6dV1dVy0UhnA/TQvttVUlcb35t3G2shtx8RVyBgPsv4Ho
         CZeDQbiiPCp1f/K18KsLQiQ6aAMWtlZEHYrGBEqmCkMBZ+xgdmJDAkqtFUfIrsoXYb72
         e3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486078; x=1792090878;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZaD67jW1zaHMwLOSmvc/1aeKMLwK1RpzPD9+yhLQ1do=;
        b=2sYWStCS+ghYI/F7/4NIBI/65+jfiGYV7cP+O5WvXECmVphedxCR1dB2AieTK0WIC/
         vw0R9r/rWXYJbwYYx+7s7BfudtUec1hT+g8SUZhmSQJ0W5Sqd2OcQiCJSiZ4MvLSrFXR
         8O5IDhnSl+2MiMOMI0PRK33TNU0r9DBwqYY8D6Xs4zMofDpDxL6GbyCFUKS0AgeT1sEF
         bx4DnbpeQnprwRVfAE4sqXA5OWa4ZA8tbRdP8weDI9T65e1mnU8O1W/LXKhQg89v8HVo
         lxK7jbo1zsaznrDYKtO5WQqpGQCXv1HB/8TNm9K5t7CjuncwUZ04x+DDoWVeXhSWlp8r
         3UpA==
X-Gm-Message-State: AFq9FYI7ChNnzT7+PQJYPVxoPOl9uL7erHmBXRAGDitZ6IebFqe5Oprl
	at5uXbkQAv+vdsaxBQLnSGFR96wMQ5PYSx0aHt9sTsmqpZ2ZwyJPUx5iWNRbsKxev5Uy/hc/dUn
	6iYGPSX4dPA==
X-Gm-Gg: AYBFou3fX6eoRTgizZq5arcgh++HYBEo8BhNuqYPk7F7nT6HvfSlowGfn6I7ArPXcAp
	S45p2FQiMezbKN+4x8UYihVAK1LeJDy6Rpmu+TDOmmduoCzKeixF4O6kliLuWWjuNr6AYx6we47
	IohKNpvHBbXvQtbFjaxFCjm0UrZnjCZ6q29KvryUZyoFKns//r8VW82b9sWTwEu36/xNqEMMLJv
	PrcU55IBuufY+s0PJvBGpmPyE6TmLAuWq8lzaxrQJvUJFpr3IjzPeSJ37pK/Vl0CryE2bQPpBlo
	pkh38WQfMR6pLh+qgte+KXC2aezkOBHHgHPGojJY7gMzkGQokriQXwI6sK4U96WWF6cbuKBkqQC
	Wd//TFrBTMCVGTUwSTTFw0mjM/azUbiHgbQx9PT3PcJAL4KhJIdmbJpSPTq2sSlcFSI2ovIOnkf
	7PxGuZog+lYrrkkRYHqshbyvwygWG/LctAO/CkEkd6Nlxot3ds4bJCIbeQ/dan2e7/vzhzPpY/a
	Md3TdN5FAmoVCLeEe+lunR55AmAcdp3YNDwihKw87FF2UuKV+PqESHTD23AhQJyElAffEs=
X-Received: by 2002:a05:7301:7305:b0:351:31c7:ab1d with SMTP id 5a478bee46e88-3515dda8789mr6908917eec.16.1791486076904;
        Thu, 08 Oct 2026 12:01:16 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537b3eccebsm405691eec.12.2026.10.08.12.01.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:01:15 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	=?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	linux-sound@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] ASoC: SOF: topology: Parse DAI type token for dspless mode
Date: Thu,  8 Oct 2026 15:01:03 -0400
Message-ID: <20261008190108.96660-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008190108.96660-1-artem@trailofbits.com>
References: <20261008190108.96660-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

[ Upstream commit f9618ff105a0f6f5a6beed3edc557ea6a7d26df6 ]

Starting with LunarLake, the dspless mode can handle SoundWire/ALH,
DMIC and SSPs, so we need to identify the dai type from topology.

[ Backport to 6.6.y: 6.6.y still uses a stack-allocated snd_sof_dai in
  the dspless topology path; parse the DAI type into that existing object
  before connecting it. ]

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://msgid.link/r/20240213101247.28887-12-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This is the prerequisite needed for the CVE-2025-21870 backport. Stores and
populates each SOF DAI type so the following ALH hardening can distinguish
ALH DAI widgets from same-name non-DAI or non-ALH widgets.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 sound/soc/sof/ipc4-topology.c |  1 +
 sound/soc/sof/sof-audio.h     |  1 +
 sound/soc/sof/topology.c      | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 39e4f0fdd5e4..18096aefce13 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -534,6 +534,7 @@ static int sof_ipc4_widget_setup_comp_dai(struct snd_sof_widget *swidget)
 	dev_dbg(scomp->dev, "dai %s node_type %u dai_type %u dai_index %d\n", swidget->widget->name,
 		node_type, ipc4_copier->dai_type, ipc4_copier->dai_index);
 
+	dai->type = ipc4_copier->dai_type;
 	ipc4_copier->data.gtw_cfg.node_id = SOF_IPC4_NODE_TYPE(node_type);
 
 	pipe_widget = swidget->spipe->pipe_widget;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 7620596ead07..13b9026ffd4d 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -514,6 +514,7 @@ struct snd_sof_route {
 struct snd_sof_dai {
 	struct snd_soc_component *scomp;
 	const char *name;
+	u32 type;
 
 	int number_configs;
 	int current_config;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 7eb8eb35b137..011095722a80 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -2364,7 +2364,10 @@ static int sof_dspless_widget_ready(struct snd_soc_component *scomp, int index,
 				    struct snd_soc_tplg_dapm_widget *tw)
 {
 	if (WIDGET_IS_DAI(w->id)) {
+		static const struct sof_topology_token dai_tokens[] = {
+			{SOF_TKN_DAI_TYPE, SND_SOC_TPLG_TUPLE_TYPE_STRING, get_token_dai_type, 0}};
 		struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
+		struct snd_soc_tplg_private *priv = &tw->priv;
 		struct snd_sof_widget *swidget;
 		struct snd_sof_dai dai;
 		int ret;
@@ -2375,6 +2378,14 @@ static int sof_dspless_widget_ready(struct snd_soc_component *scomp, int index,
 
 		memset(&dai, 0, sizeof(dai));
 
+		ret = sof_parse_tokens(scomp, &dai.type, dai_tokens, ARRAY_SIZE(dai_tokens),
+				       priv->array, le32_to_cpu(priv->size));
+		if (ret < 0) {
+			dev_err(scomp->dev, "Failed to parse DAI tokens for %s\n", tw->name);
+			kfree(swidget);
+			return ret;
+		}
+
 		ret = sof_connect_dai_widget(scomp, w, tw, &dai);
 		if (ret) {
 			kfree(swidget);
-- 
2.39.5

