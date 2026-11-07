Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049718;
	b=sAYvwxip7E54a9Q+kUVKQNGZcP1z6OGp208jIsZi8bZQVXQugt7L63JmarcnWbQXokA4
	 ThgSWcrA9OXQ7rHeCWqeiIPCb5+t9LTzgbD6AgS4CNI640OaGTD67ZXOfK68Dt//7zta6
	 VPmqrwrvPL1zL6gwbphDaZ5ZzPrYRTVfMvWtSl9gMoqZ1QN/ErrRvzdUAj7ELT9lgIqRX
	 DmTsSHQrdK+MFb1dG9XEVjFkkGFGCMMioivaOxl1rzXWbIYDSgbJYDzbClZ6a01bw01ge
	 gqhuyuXKknsTtEPT28Btg+UzpC9muttZui8E5/rQbwkhz3eHL+qHJXVvomSlKsEVwxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049718;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yl4LD1CP561/TC4j7giHRmi59l5+rPzJ9CuI3dXfoaI=;
	b=UsqQi1g4Wo32PQj809souJfZVAnzHeFkjL+Jp8stzmur/Eqa/o6r/WB7giCkyNOOgVEl
	 ymI19bBMbqppg7w5y7Zbp242g4scTIxaP8a3wAbXZaJPiRgI4cynFLnusPPqlFsxT1BVs
	 n+wLFpSq8WpUKC7Yay3LCDtV4O/1HPDNFJ4IydE1779Ci93QO6IeUcymhu8g5pWq2EpMt
	 LT5icR2f22qSfcEjYsDWC4PMeVzSOgggnZerArRexXub1p41qWmzv4IT9MheC8pXKvUNl
	 PKZfDmmmIBvvRSYDyPPnsI6YQGVZ+iY1SscoehUztw9KH/3C+TTpkFzccKp9uU1vCnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GF5keYzB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DEE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GF5keYzB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DD41F008A1;
	Sat,  7 Nov 2026 11:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049718;
	bh=yl4LD1CP561/TC4j7giHRmi59l5+rPzJ9CuI3dXfoaI=;
	h=From:To:Cc:Subject:Date;
	b=GF5keYzBexs/auOzzYNM7sqUO0tC+nhyUgIwi8sIfjSP2PTPSamGWc6f6KRw87vWE
	 Hi3cxIo4dXdzVH0MixqWDyCN52yEe5F3pZ3lFQ6hL+tRZhSv2469FaP6tbqSD7cfql
	 Ii1Sbd3SlQQYavX+2Nk9JQA5osVuK2s9+U0Vv4bkPqXCbHR//OHVvz0ZJQIzLAQMgE
	 n/jvsQ3gHdX33KnSHNmSIgmafqUbr73uCKtIczt3Zczk4TMB/G7MqHlcsOpn2suIZk
	 tP/yhm6xtb7lDMqayABG0oLLD4YQETKlO+zDCI7y5UejUcKVt63x+u0UrEBYoRCfN/
	 wIbFM3RP9PO/A==
From: Sasha Levin <sashal@kernel.org>
To: peter.ujfalusi@linux.intel.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: compress: fix buffer leak on failed SET_PARAMS" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:08:36 -0500
Message-ID: <20261107060836-failed-5.15-fbc74ca9fbf7@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x fbc74ca9fbf7e0b8f6872ccac62f9f4a1f3b5e53
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060836-failed-5.15-fbc74ca9fbf7@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From fbc74ca9fbf7e0b8f6872ccac62f9f4a1f3b5e53 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Date: Mon, 19 Oct 2026 17:45:30 +0300
Subject: [PATCH] ALSA: compress: fix buffer leak on failed SET_PARAMS

When the driver has neither ops->copy nor a preallocated dma_buffer_p,
snd_compr_allocate_buffer() kmallocs runtime->buffer. If
ops->set_params() then rejects the parameters, SET_PARAMS fails, the
stream stays in the OPEN state and keeps the buffer. The next
SET_PARAMS allocates a new buffer and overwrites the pointer, so
repeated SET_PARAMS calls with parameters that the driver rejects leak
one buffer per call.

Release the framework-owned buffer when ops->set_params() fails on an
OPEN stream, so that a failed SET_PARAMS leaves no buffer behind and
the buffer is allocated only once per successful setup. Use the same
ownership check as snd_compr_free().

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20261019144533.30665-2-peter.ujfalusi@linux.intel.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5c0db178d635f..50301f72579ee 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -702,8 +702,15 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 			return -ENOMEM;
 
 		retval = stream->ops->set_params(stream, params);
-		if (retval)
+		if (retval) {
+			/* the stream stays OPEN: drop the buffer of the rejected setup */
+			if (stream->runtime->state == SNDRV_PCM_STATE_OPEN &&
+			    !stream->runtime->dma_buffer_p) {
+				kfree(stream->runtime->buffer);
+				stream->runtime->buffer = NULL;
+			}
 			return retval;
+		}
 
 		if (stream->next_track)
 			return retval;
-- 
2.53.0




