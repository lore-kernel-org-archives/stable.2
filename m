Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341794;
	b=fcwrA8yHoxKGEkuelReiGAL82x7jzvqjF2AfyO/X0Kl4+seGtSl9IVV4a27L/GvshP/p
	 dU7vgKVXY2ekXOxTUJbqv1Y/iTcTkmYH4cytx8r6sE3DmXs07m4iRhrxtrZicydyv+8vu
	 szughR3ypqA3CdLwC9qFNuIL95YIvXecq1sRQR9aJqqfqVN9hwImDtMPLOLv0buKI5Oe0
	 ko10aPT2IINGaPlTSDLAhj75xqODYdM3FNRCw7q11loKWJhpzP8rogHUerei1lDM6115J
	 3V610hp/khE+CQeq1O45LnVyLTrD4FdQvcfG+LeD264hfpdKjNTYo5yu80T53r8BetQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=zO10wKAE4P82VZclOw8qx37lMoJGAPT0t+9u2mDLtvA=;
	b=Bap/x5NM4Kp4gE7mUtkFskB/gWs75m1UH3dVuOJatu6TSeleDl0plvJ0ncmslLwTUwcY
	 wO3KsLv8mp/2g/Pzraz8C77P9jmg8vTFzqw33bHAg/46BhOfJLRB9qV6BK5in5oRdAJHH
	 qJtxQ8PO0ZGGOxpj0WIcSJexcJaIBQZV//gNbaWfNkHNFoz2r9P4tt+AhrvVe1OFH298x
	 AvKL/E0APLXo75HRv1pPBR1ynx0wqZaiMAOE+oFKeLKqEJVt2juAMjT3m/TQ5UjNe5nMs
	 Th9JGmccppQPVMpW/5ZAM6G/MXvQnmTgEAXFxNDAuZW9gDRQc844+rCazsCchQtX7NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCooIo3y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5986606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XCooIo3y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67B21F008A5;
	Tue, 10 Nov 2026 20:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341793;
	bh=zO10wKAE4P82VZclOw8qx37lMoJGAPT0t+9u2mDLtvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XCooIo3yHKZ9cRi4tpLrXW4WoU3rTfbj2vRJZdBDUS1b47S0JwDB1dv/3wz0AHyis
	 ENcXb2eyCKfYRQulgbZsBlpXQx8PDg9qlJni06sPOjczkI7Cy9edP6+BuEsEbpOe5y
	 Q7yWoWXw794M3ru+SpvQpSR1rblBIN0c5Y7X9iCQm8beDI1VcUvORc6ulLuqYcE7j6
	 lPvNz3VBEOYoaoYIlFMn10fR/GY85XtyfZ+77AGiOP3zxxvC9GR3oMDuMEy51JB3Tv
	 9QVymPW2nIS3m7lK7wfKblwhmhxnIgGykwN4uAHlfzMLGL488FDgi0oDd/dT2tVlaB
	 YcaQv3xtfx4cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladyslav Tymoshchuk <tvlad744@gmail.com>,
	Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0
Date: Tue, 10 Nov 2026 15:16:31 -0500
Message-ID: <20261110200604.3670083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053538-failed-6.6-0ea3e0b196f9@kernel.org>
References: <20261107053538-failed-6.6-0ea3e0b196f9@kernel.org>
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
[ sashal: adjusted context in q6apm_dai_pointer() because the preceding bytes_to_frames() branch is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index 80df749859190..9e22269a8c723 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -440,11 +440,15 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
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

