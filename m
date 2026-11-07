Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047740;
	b=RWr2crACqWHhVYobiBDjALGEdKKwtay8iRGAlfDSeO7P0h+dSb4N2gQxmecUyiVLIiYh
	 6fVdkA1aao/80Cqmr9n8Taag/jdeTmjLbV9RngundHfljxvd+SmJLh8QD+wZw3jNQDBpY
	 /8BXrfjvLmHFp3dwBlx3NXY61QuxifP7NQMom2u8gKKkOaLpxWwGJUi0bnaAlwDqj1OU5
	 w7zDoarYx/+zaH2gwznA9F2+XBcBAitq0boLaLJdGUS4w+cbZN1BUZoMXImKRc/a2Kxsr
	 JcEl0sU7jGtCnbxpEnhRSfmwTX3XOOPQX4IqV28i067Jwevl4bFfkDmAP1F1hA1Jadw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=PUp1fs4KQdjc3eQTiG/TlycbQ5kSxSdbihtUyxDXQ9s=;
	b=uGiWcwiuG7IbCQIWavGHkdOznfUC7D42paZg92ovgOYcI/P6LDb0aw+4BEl7/IpJbqiK
	 2egHgKzeolWyVmTDwq10BXYlAUt8FYpYvg1E82gvGyUVS06sCQgMxkGL6NM1QVMHgW+M1
	 ABYdPDZmkHxAFQPW24So6P3LtQ+Za3V+rrWlhv8o9WiVQTs1DpjM5LFGGMML6WniXHYiW
	 x75AO3kDLAWsXqsAZ+dzfKJVc7Fok10nRoyjlQZ1AMJcTtW2mGeL8YlxFq8Y18sGUWvfx
	 1zY23ev/XyS07WhmcUCLc49390wXCuz/a5pL1McYQTh+6oFkmlFJKSFxN3W9l6lcrmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vysl0qN1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D8D606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vysl0qN1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1ACB1F0089F;
	Sat,  7 Nov 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047740;
	bh=PUp1fs4KQdjc3eQTiG/TlycbQ5kSxSdbihtUyxDXQ9s=;
	h=From:To:Cc:Subject:Date;
	b=Vysl0qN1XQD2JO5eX4HeIPBFDGaf3yvKNkJ4taEJedyTRKc7VBlk4wNJ9WsaZko8y
	 otCUnwpRUkEdTUTquC4ATdQ6rlICt2heYtV0OJ/Ucp5nazGm5sfbTdOnMmFFAE9V90
	 FVorcAME8BNMx0c6tmJxqlRePVKfuKCa0Kg5IhK67ka7UZ5NCEOjqu8KvI2T7pPHHP
	 fwEXnf69aQc0ybtc9d6xvwuetOGGxboMHujeFlinR0RH0Nyk0xZ/xk10fjv/Gsaw+u
	 BnX966wA9fwgCqe9XjQh9WmrL64r2wdjy3GE1tNU2vgenT8A/YtsD0XRsz20Hl+l/3
	 reYd/d29QHjmQ==
From: Sasha Levin <sashal@kernel.org>
To: tvlad744@gmail.com,
	srinivas.kandagatla@oss.qualcomm.com,
	broonie@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:35:38 -0500
Message-ID: <20261107053538-failed-6.6-0ea3e0b196f9@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 0ea3e0b196f9dcc17b40ac881a6efef06459975b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053538-failed-6.6-0ea3e0b196f9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0ea3e0b196f9dcc17b40ac881a6efef06459975b Mon Sep 17 00:00:00 2001
From: Vladyslav Tymoshchuk <tvlad744@gmail.com>
Date: Wed, 14 Oct 2026 19:27:00 +0300
Subject: [PATCH] ASoC: qcom: q6apm-dai: wrap the position of a full ring to 0

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
---
 sound/soc/qcom/qdsp6/q6apm-dai.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm-dai.c b/sound/soc/qcom/qdsp6/q6apm-dai.c
index b0b10ba51c99d..58beaf906b9ff 100644
--- a/sound/soc/qcom/qdsp6/q6apm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6apm-dai.c
@@ -613,11 +613,15 @@ static snd_pcm_uframes_t q6apm_dai_pointer(struct snd_soc_component *component,
 		ptr = bytes_to_frames(runtime, index);
 		return ptr;
 	}
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




