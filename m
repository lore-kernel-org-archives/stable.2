Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228B3391E4C
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609166; cv=none; b=WFZtHxSkEuDt+VtmHlVblKlUPpt0lIQ1KUHXUZKV5zetgQIHFpWUJJBuukg5nE46Q5ARV1xjnBx180WK2p2n3vSWT5XDlZ/cIDeHPTFwcKjXCTpqlU/TT7vNcvh3aGcYggJg18fz0ut2hiq38SESzja+G5casgUxLGhqQzFI6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609166; c=relaxed/simple;
	bh=2t78zmPeZh7PSHMNQlqF9hneoQ6ulb2kGxIGsdTNUTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RRST6ziXvb5XiBEW/AnZZsrnxHyPzueMzY4NpkDJwQ05Qbf2SfzKGl384yWrU3ELoK1g8a4ZB1Lny/OCBEDv8YUsBG74v3990c6ZEi3+swMxHhY0vO4X+OpiMNqqWtG0dMRBOxQ1Mjl2f4JCGnJPI2dFsuRPv/ujEl86xGHUQqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNo6APZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNo6APZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E50CC1F00A3E;
	Mon, 24 Aug 2026 22:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609164;
	bh=UpSmBqD2SU43GdKgXcU007kqBjii/IqCG20XjmD96wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cNo6APZioebuBt8WFpft5nVrKrWGun/Zrk4XbKupbxcOUn9oB2smH13iL9IK8KJnJ
	 SyLt5/gdp4A3tr7ZH45svwExvLVLYsOtlWaU9UZhycsXcyhvH3WZHSz4lFkfrz4/0m
	 7HyIqi5ox1IcoP2ox25JFuMyADo60b8N/wHDEK6rCh0m715BMG9a0ThOTF6PHNSd1b
	 Mu/b6zYSj8PTskLwINJS+ubud1XFtEFYndoOvGSDjhl41hjgnQKlmNBGMYIwvWmJTx
	 fG0iv56MeqLs+gBhYKZ0hufThHFtYW02LxlnLeaElBvWl9mw4UO32leC7UDgMPL4qU
	 GMW3bCQwfh5Tg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/5] ASoC: SOF: Relocate and rework functionality for PCM stream freeing
Date: Mon, 24 Aug 2026 18:05:58 -0400
Message-ID: <20260824220601.440874-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824220601.440874-1-sashal@kernel.org>
References: <2026082057-slush-president-f8ca@gregkh>
 <20260824220601.440874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 169ec0a541aac8afb215ab591b0fd53276686014 ]

Move the sof_pcm_stream_free() from sof-audio.c to pcm.c as static function
and add wrapper to free all active stream, which is going to be used in
ipc3/4 topology code (removes duplicated code).

With this change most of the PCM stream related code is located in one
source file for easier lookup and simplified flow.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20250206092828.7569-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 17661c67b206 ("ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc3-topology.c | 20 +++--------
 sound/soc/sof/ipc4-topology.c | 18 +---------
 sound/soc/sof/pcm.c           | 65 +++++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-audio.c     | 36 -------------------
 sound/soc/sof/sof-audio.h     |  3 +-
 5 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/sound/soc/sof/ipc3-topology.c b/sound/soc/sof/ipc3-topology.c
index 0db8c4b2f0ff2..7c813e3d09e21 100644
--- a/sound/soc/sof/ipc3-topology.c
+++ b/sound/soc/sof/ipc3-topology.c
@@ -2295,28 +2295,16 @@ static int sof_ipc3_set_up_all_pipelines(struct snd_sof_dev *sdev, bool verify)
 static int sof_tear_down_left_over_pipelines(struct snd_sof_dev *sdev)
 {
 	struct snd_sof_widget *swidget;
-	struct snd_sof_pcm *spcm;
-	int dir, ret;
+	int ret;
 
 	/*
 	 * free all PCMs and their associated DAPM widgets if their connected DAPM widget
 	 * list is not NULL. This should only be true for paused streams at this point.
 	 * This is equivalent to the handling of FE DAI suspend trigger for running streams.
 	 */
-	list_for_each_entry(spcm, &sdev->pcm_list, list) {
-		for_each_pcm_streams(dir) {
-			struct snd_pcm_substream *substream = spcm->stream[dir].substream;
-
-			if (!substream || !substream->runtime || spcm->stream[dir].suspend_ignored)
-				continue;
-
-			if (spcm->stream[dir].list) {
-				ret = sof_pcm_stream_free(sdev, substream, spcm, dir, true);
-				if (ret < 0)
-					return ret;
-			}
-		}
-	}
+	ret = sof_pcm_free_all_streams(sdev);
+	if (ret)
+		return ret;
 
 	/*
 	 * free any left over DAI widgets. This is equivalent to the handling of suspend trigger
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 43040d4d724bc..39e4f0fdd5e45 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2951,9 +2951,6 @@ static int sof_ipc4_dai_get_clk(struct snd_sof_dev *sdev, struct snd_sof_dai *da
 
 static int sof_ipc4_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verify)
 {
-	struct snd_sof_pcm *spcm;
-	int dir, ret;
-
 	/*
 	 * This function is called during system suspend, we need to make sure
 	 * that all streams have been freed up.
@@ -2965,21 +2962,8 @@ static int sof_ipc4_tear_down_all_pipelines(struct snd_sof_dev *sdev, bool verif
 	 *
 	 * This will also make sure that paused streams handled correctly.
 	 */
-	list_for_each_entry(spcm, &sdev->pcm_list, list) {
-		for_each_pcm_streams(dir) {
-			struct snd_pcm_substream *substream = spcm->stream[dir].substream;
-
-			if (!substream || !substream->runtime || spcm->stream[dir].suspend_ignored)
-				continue;
 
-			if (spcm->stream[dir].list) {
-				ret = sof_pcm_stream_free(sdev, substream, spcm, dir, true);
-				if (ret < 0)
-					return ret;
-			}
-		}
-	}
-	return 0;
+	return sof_pcm_free_all_streams(sdev);
 }
 
 static int sof_ipc4_link_setup(struct snd_sof_dev *sdev, struct snd_soc_dai_link *link)
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index bc32324748a18..e169aaa4848fb 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -191,6 +191,71 @@ static int sof_pcm_hw_params(struct snd_soc_component *component,
 	return 0;
 }
 
+static int sof_pcm_stream_free(struct snd_sof_dev *sdev,
+			       struct snd_pcm_substream *substream,
+			       struct snd_sof_pcm *spcm, int dir,
+			       bool free_widget_list)
+{
+	const struct sof_ipc_pcm_ops *pcm_ops = sof_ipc_get_ops(sdev, pcm);
+	int ret;
+
+	if (spcm->prepared[substream->stream]) {
+		/* stop DMA first if needed */
+		if (pcm_ops && pcm_ops->platform_stop_during_hw_free)
+			snd_sof_pcm_platform_trigger(sdev, substream,
+						     SNDRV_PCM_TRIGGER_STOP);
+
+		/* Send PCM_FREE IPC to reset pipeline */
+		if (pcm_ops && pcm_ops->hw_free) {
+			ret = pcm_ops->hw_free(sdev->component, substream);
+			if (ret < 0)
+				return ret;
+		}
+
+		spcm->prepared[substream->stream] = false;
+	}
+
+	/* reset the DMA */
+	ret = snd_sof_pcm_platform_hw_free(sdev, substream);
+	if (ret < 0)
+		return ret;
+
+	/* free widget list */
+	if (free_widget_list) {
+		ret = sof_widget_list_free(sdev, spcm, dir);
+		if (ret < 0)
+			dev_err(sdev->dev, "failed to free widgets during suspend\n");
+	}
+
+	return ret;
+}
+
+int sof_pcm_free_all_streams(struct snd_sof_dev *sdev)
+{
+	struct snd_pcm_substream *substream;
+	struct snd_sof_pcm *spcm;
+	int dir, ret;
+
+	list_for_each_entry(spcm, &sdev->pcm_list, list) {
+		for_each_pcm_streams(dir) {
+			substream = spcm->stream[dir].substream;
+
+			if (!substream || !substream->runtime ||
+			    spcm->stream[dir].suspend_ignored)
+				continue;
+
+			if (spcm->stream[dir].list) {
+				ret = sof_pcm_stream_free(sdev, substream, spcm,
+							  dir, true);
+				if (ret < 0)
+					return ret;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static int sof_pcm_hw_free(struct snd_soc_component *component,
 			   struct snd_pcm_substream *substream)
 {
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 22a5df6aed2a9..ff5d3428346b5 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -831,42 +831,6 @@ bool snd_sof_stream_suspend_ignored(struct snd_sof_dev *sdev)
 	return false;
 }
 
-int sof_pcm_stream_free(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream,
-			struct snd_sof_pcm *spcm, int dir, bool free_widget_list)
-{
-	const struct sof_ipc_pcm_ops *pcm_ops = sof_ipc_get_ops(sdev, pcm);
-	int ret;
-
-	if (spcm->prepared[substream->stream]) {
-		/* stop DMA first if needed */
-		if (pcm_ops && pcm_ops->platform_stop_during_hw_free)
-			snd_sof_pcm_platform_trigger(sdev, substream, SNDRV_PCM_TRIGGER_STOP);
-
-		/* Send PCM_FREE IPC to reset pipeline */
-		if (pcm_ops && pcm_ops->hw_free) {
-			ret = pcm_ops->hw_free(sdev->component, substream);
-			if (ret < 0)
-				return ret;
-		}
-
-		spcm->prepared[substream->stream] = false;
-	}
-
-	/* reset the DMA */
-	ret = snd_sof_pcm_platform_hw_free(sdev, substream);
-	if (ret < 0)
-		return ret;
-
-	/* free widget list */
-	if (free_widget_list) {
-		ret = sof_widget_list_free(sdev, spcm, dir);
-		if (ret < 0)
-			dev_err(sdev->dev, "failed to free widgets during suspend\n");
-	}
-
-	return ret;
-}
-
 /*
  * Generic object lookup APIs.
  */
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 3606595a7500c..7699c1ef22f26 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -633,8 +633,7 @@ int sof_widget_list_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm,
 int sof_widget_list_free(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm, int dir);
 int sof_pcm_dsp_pcm_free(struct snd_pcm_substream *substream, struct snd_sof_dev *sdev,
 			 struct snd_sof_pcm *spcm);
-int sof_pcm_stream_free(struct snd_sof_dev *sdev, struct snd_pcm_substream *substream,
-			struct snd_sof_pcm *spcm, int dir, bool free_widget_list);
+int sof_pcm_free_all_streams(struct snd_sof_dev *sdev);
 int get_token_u32(void *elem, void *object, u32 offset);
 int get_token_u16(void *elem, void *object, u32 offset);
 int get_token_comp_format(void *elem, void *object, u32 offset);
-- 
2.53.0

