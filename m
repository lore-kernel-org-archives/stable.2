Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5453909A5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787609166; cv=none; b=JLgPH7ACVa+pZE+xzA2euGEgjEY32f2MtK3dejG4+wLH6IEgwviN1bq3eFz67Ao62ATYv4jW9lEbc+cZ45iP9KIenT+tkOclfPfwAVlIvb2svYWAkRLLaoUVCCvIJeqG6h4qtxFDKyJn+y9I3/lki3zlH6sTeseN5isZrH7/irE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787609166; c=relaxed/simple;
	bh=QzK68WUZTc2VTdd3o7LfMlHf5zMTIJrBXShrJFo3IVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=StOj82rSYr7dygF6zsdmt3a3/eIgdRYU+nCZVmAymeZMS84l9ypNagbTB/exmPZ1SE9p9QUMa8yXnYtYXYcxTilm2fDUuhAKOKcnNgQkQboRTGzMdkQfB5yeaoeh8pqvjpBDnk5CpAgLqgx3xDDJnkbN0mIaL6/wVpiKgH8pK/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGQuP5Fs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGQuP5Fs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E27711F00A3A;
	Mon, 24 Aug 2026 22:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787609165;
	bh=vD2rJ5xPV7MPvCwEpGDkh11kgO/AotXn6TV/PyeSarI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XGQuP5FsZb3ZHkd7kuGpN5eQHgHTK5n+0+xN2AYX30Rq62MmfScTC2NHDl7CgUDzI
	 jlcLccQxFZyrwlEQsHv1YJNQniE1T0h1mFwx1xdqIqarFRy+t6MyiOsLHla6oZX6O6
	 TYX7j+kqQjnBVYWUNizEF9lc3fnsNk0dvMSysiCJRCPssWEXNxzZtGdW3dvuHfYObH
	 /5PwYZ7yaqKNEmvwFjpDwE3d7EhowkxvE1VgqTUBEmngoRFr5W71huk3hpp63OCyel
	 TnoESgkBmw84HEj9chWnOjoN09Pdhv//nqhQOZR1cMT3U1g8vTUzi1H8wAErXg19mf
	 N9tOe9NVJcihw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Liam Girdwood <liam.r.girdwood@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] ASoC: SOF: pcm: Move period/buffer configuration print after platform open
Date: Mon, 24 Aug 2026 18:05:59 -0400
Message-ID: <20260824220601.440874-3-sashal@kernel.org>
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

[ Upstream commit 4d2ea16576c8aa1437048cf436bff85653f139fe ]

The platform specific pcm_open call via snd_sof_pcm_platform_open() can
modify the initial buffer configuration via constraints.

Move the prints as last step in the sof_pcm_open() function to reflect the
final setup.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://patch.msgid.link/20250206092828.7569-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 17661c67b206 ("ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/pcm.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index e169aaa4848fb..de9fc989cf313 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -519,15 +519,6 @@ static int sof_pcm_open(struct snd_soc_component *component,
 	 */
 	runtime->hw.buffer_bytes_max = le32_to_cpu(caps->buffer_size_max);
 
-	dev_dbg(component->dev, "period min %zd max %zd bytes\n",
-		runtime->hw.period_bytes_min,
-		runtime->hw.period_bytes_max);
-	dev_dbg(component->dev, "period count %d max %d\n",
-		runtime->hw.periods_min,
-		runtime->hw.periods_max);
-	dev_dbg(component->dev, "buffer max %zd bytes\n",
-		runtime->hw.buffer_bytes_max);
-
 	/* set wait time - TODO: come from topology */
 	substream->wait_time = 500;
 
@@ -537,10 +528,21 @@ static int sof_pcm_open(struct snd_soc_component *component,
 	spcm->prepared[substream->stream] = false;
 
 	ret = snd_sof_pcm_platform_open(sdev, substream);
-	if (ret < 0)
+	if (ret < 0) {
 		dev_err(component->dev, "error: pcm open failed %d\n", ret);
+		return ret;
+	}
 
-	return ret;
+	dev_dbg(component->dev, "period bytes min %zd, max %zd\n",
+		runtime->hw.period_bytes_min,
+		runtime->hw.period_bytes_max);
+	dev_dbg(component->dev, "period count min %d, max %d\n",
+		runtime->hw.periods_min,
+		runtime->hw.periods_max);
+	dev_dbg(component->dev, "buffer bytes max %zd\n",
+		runtime->hw.buffer_bytes_max);
+
+	return 0;
 }
 
 static int sof_pcm_close(struct snd_soc_component *component,
-- 
2.53.0

