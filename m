Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374018;
	b=Kv2JHcE0RIFjF7nMCKayck4yvyuJxhAeVZ5+1Q/EU807Bys7vEo96d3oyB3Y8BQ61tiO
	 51M/1klt8c5mPge9Vc6Hpjak3ym8ftDxCehLuynDUxVeeexVQD+6/vIcuU9h6EjpzXfVS
	 gY+RFN764iNAzbqP000YHMG14tVCt9gg0LArfbRc2qGyf1LAV1L/Ds2SPzUFDds40lkF4
	 wUy2fJmXStD1QXlUxbr0PpIfVi+vuvGQutU/wIGc1LoZjcK/goOK6R7+1+81/qKp9ohNS
	 X+VWHkJHeUOGjStpBQA9DOF1+TjkGG/3t+uU8fz1Qc9OvImh/2i+GIa932QCxWXeVIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=coMhq9Qf+3gIWffQ/My/KYnlq0cSDEZ0xkwyX8G/RIs=;
	b=WgjIK9NxE4Zc8tTq76F+TyD1ZiCLlAXaR4p6jrLhnFsncfH7cH5jDTdqI0y+tfSmz28G
	 kf9dXZP8IXD6uLAgWY+tc5qAaRzakok6ymkCd41CXEWXxZCCA8xsYHLJeKcHMsX+LrvJo
	 yA33stT6LIUrOIB/9QJk8yCIWb6paNTj/CBIEQndP5WAlxbu/4Ki4j/22aH+HIMkcRrAI
	 crH5bX4JU8JdrW7EVS0HOXcpc5drn6MrexixUwmCEqHaH4d1mEO3cCpcWIbSUWyPsoHyl
	 TwG7WWHewn+EHWdae+tDrXGlLouDKb2PONHSUeFza0NXvvbeQk/1VMLQa+Q/a0K1r1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="B4phn/tH";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D95606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 05:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B4phn/tH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2C7A1F00A03;
	Wed, 11 Nov 2026 05:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794374018;
	bh=coMhq9Qf+3gIWffQ/My/KYnlq0cSDEZ0xkwyX8G/RIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B4phn/tHkJ/djk0TbTXlPuClSWjDvl2XtqLoqT2J+qUyv/F9vx7dv3NzO7GFA8nuq
	 QaNgpxV3jznGKhMoObS9XBT/6EC6DSbnl8Ef7m6VNTcUvqC18eKezMZsJJtwrJqCbN
	 j8MztczU3DVGsPwug9GG16/Q4GX9uz3OT+5jKww0MNe8EMbu26/w1YH86c1u3kfUC2
	 LP9x60SarlM4P7mclZdKVS9tAPwvpNbH/fZrU1TMOYWg7q5EsP7iaqBrbNSUkuei0H
	 SkO86A0eaO5ck+fN8YBhb7BLkwbyWJucPGOK6nCtiSOCXpeoCHcvk3scV8Np3CWd5W
	 OJtOwZYECMZcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] ASoC: SOF: Intel: remove all dependencies on SND_SOC_HDAC_HDMI
Date: Wed, 11 Nov 2026 00:13:32 -0500
Message-ID: <20261111051038.1204227-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111051038.1204227-1-sashal@kernel.org>
References: <20261107055548-failed-6.1-08a44bde821d@kernel.org>
 <20261111051038.1204227-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[ Upstream commit 2c6c809cc00b71b3195d76a69d603cc761716ab7 ]

remove all dependencies on SND_SOC_HDAC_HDMI and
clean-up ifdefs. The machine driver still supports this configuration
used by the Skylake driver.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/20221027193540.259520-3-pierre-louis.bossart@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 08a44bde821d ("ASoC: hdac_hda: Restore the codec device type on unbind")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/intel/hda-codec.c | 3 +--
 sound/soc/sof/intel/hda.h       | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 5827747cce2ae..a95b04d420279 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -231,8 +231,7 @@ void hda_codec_probe_bus(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(hda_codec_probe_bus, SND_SOC_SOF_HDA_AUDIO_CODEC);
 
-#if IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI) || \
-	IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI)
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC) && IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
 void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable)
 {
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index a4737c8e4fcb3..b032f4a4e232b 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -711,9 +711,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev);
 
 #endif /* CONFIG_SND_SOC_SOF_HDA */
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA) && \
-	(IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI) || \
-	 IS_ENABLED(CONFIG_SND_SOC_HDAC_HDMI))
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC) && IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI)
 
 void hda_codec_i915_display_power(struct snd_sof_dev *sdev, bool enable);
 int hda_codec_i915_init(struct snd_sof_dev *sdev);
-- 
2.53.0

