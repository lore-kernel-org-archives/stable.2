Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338451;
	b=FSjK8spL1JB/7x9HKdQWU2Bxk3W7T5GBK/j41NpMRQDFV3gYRrklRVu90fS3g7pnmkDK
	 Crq65nNZSzLSJCpVWaCgR7r5/4KYFSFIx967C0/gtfj6W84wvgPrfP4iBHm3Pqo9MVq/E
	 OFH6DJk6fZPVRKmTTywmcYdk/J+BQCL46FCOAcenBTvanSKcvNiXQqJ5CMcJD6yoSmV9H
	 17pOl+SoPF2YQU1/eWGQGmbi7mGPqKIugKrwuUQQeGUDaLSlbjfe0OHCFW29vi9rkvZPP
	 tJp01qDWdXqosvY89CdwnXDwl/bHcWm2cKNn9wuYeMBrTsYSksKvGTdMchIvsK/KBNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338451;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TswJ++Iu7H22CtooflhXQo0hHoBWF2UtI4SQN410ngs=;
	b=OFBhSKpNYHlEaBNdhxMG43FTIzbKQwF8R3ENFrqBZXSt+U9r+fipwYR5sIz+vQmwqci0
	 KHQDMsI3jHJ0TpUdrhGb2DdqB97UAMQzY0A8eX7RW4+wyLVim+C2+cwqVl+ROMmXADqwy
	 2nCmWhZJx7185hX0WuMkk7Ll8TSODIF1BPNSVYBeHvfDXhag4LeJPN+65A+XVv1I1gY1w
	 W4VBFwzvFUb8e+dZmaW07D+77eQUgYu79ivze5ncSozAhWEdPX60+Q8A33LvIwV2VXbDI
	 xzNEqavqRVHFa20b/h4dW3TA6y2Auk5BIv/sMZjOnoRpCSS4MChwQ91FwAIE7RO4CEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGK+nhH1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D27606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGK+nhH1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6A0A1F0089F;
	Tue, 10 Nov 2026 19:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338450;
	bh=TswJ++Iu7H22CtooflhXQo0hHoBWF2UtI4SQN410ngs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGK+nhH1FiTBK/twVYDO4sJlDvyFWkLGTqW4aKba8b6ADO+cJ+30LO1OSFz6ODKez
	 VrjCB2H6T1kuMWT4SjH3bXEAEhdMscPcGV+/sGyytGttB3WawdL7gps+Ad+2l7LHjT
	 xqo/IejNT1WI3ngcGazYZW15LHlu7kdYZfkH6g7sczqZHCYvfo8fG9MmwUo9/go/wH
	 BQuRN8FsVrJZ28i8Vo8IF3TTUstnYyhCuQxXWpbNDzQ1cerkEmJLr3bCjSqHYwXW+D
	 7GpaHP2uEOQvyePCmJ4B7gpuJUS3wLVPNrij18gsNa3dFASaGUIQKiSWJBV0oJ3q22
	 1Cgd4EtJo8A/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0
Date: Tue, 10 Nov 2026 14:20:48 -0500
Message-ID: <20261110191015.3414229-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051147-failed-6.18-0ea3e0b196f9@kernel.org>
References: <20261107051147-failed-6.18-0ea3e0b196f9@kernel.org>
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

From: Vladyslav Tymoshchuk <tvlad744@gmail.com>

[ Upstream commit 0ea3e0b196f9dcc17b40ac881a6efef06459975b ]

q6apm_dai_pointer() turns the number of period buffers the DSP has
returned in the current lap, 1..periods, into a position and reports
one frame less than that. Commit a93dad6f4e6a ("ASoC: q6apm-dai: make
use of q6apm_get_hw_pointer") added the "- 1" so that the end of the
ring is not reported as a position equal to the buffer size.

One frame short has a cost once the application stops feeding the
stream. The DSP returns the last queued buffer and the position stops
at appl_ptr - 1, so avail stays at buffer_size - 1, below the default
stop_threshold. The DSP sends nothing more as its queue is empty, so
no period interrupt comes either: ALSA never detects the underrun and
the stream stays RUNNING. A poll-driven application that missed its
last wakeup waits forever, and drain only ends on its timeout, with
-EIO. On capture, the last frame of each period is held back until
the next one.

Before that commit the position wrapped to 0 at the end of the ring.
Do that again. A full lap is the start of the ring, and
snd_pcm_update_hw_ptr0() accounts for the wrap: the position cannot
move by more than one lap between two updates, as each returned buffer
calls snd_pcm_period_elapsed() and the DSP holds at most periods
buffers.

Seen on a OnePlus Pad 3 (SM8750) with PipeWire in interrupt-driven
scheduling: after a stall the PCM sat at hw_ptr 78239, appl_ptr 78240
(avail 3839 of 3840) for two hours.

Fixes: a93dad6f4e6a ("ASoC: q6apm-dai: make use of q6apm_get_hw_pointer")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20261014162703.10172-2-tvlad744@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: Adjusted context in q6apm_dai_pointer() because the push/pull-mode branch is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 54c1a33f9f937..4ea2c9869d5a1 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -442,11 +442,15 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 	struct q6apm_dai_rtd *prtd = runtime->private_data;
 	snd_pcm_uframes_t ptr;
 
-	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) * runtime->period_size;
-	if (ptr)
-		return ptr - 1;
+	/*
+	 * The hw pointer counts the period buffers the DSP has returned in
+	 * this lap, 1..periods. A full lap is the start of the ring again:
+	 * report 0 rather than one frame less, so that the position of a
+	 * drained buffer reaches appl_ptr and ALSA sees the underrun.
+	 */
+	ptr = q6apm_get_hw_pointer(prtd->graph, substream->stream) % runtime->periods;
 
-	return 0;
+	return ptr * runtime->period_size;
 }
 
 static int q6apm_dai_hw_params(struct snd_soc_component *component,
-- 
2.53.0

