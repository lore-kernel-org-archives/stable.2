Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049333;
	b=x5VWPmU8kR9CA1XneYrTxtzjaZ4jpxPYyZahcRiXdyXNxLuj3Rooy7alo9Bs4tw2vbOq
	 9Lsb4KYDOuHfIG3s+QL/32gj7gacc9lyh84Ng/JkZSKLGqOONFMnzUnu4LQfRvhOwuF7o
	 YrVV3eCdqQdlPhkJvoIJxjTa1BlbyNtizDbqYkGvLFePgtBcozO3Ovfhei0UCefZGckub
	 iD5+UYLfVh8OGpIcaL+uuO1QbP3cQvwQs5gM84xSvTa0OPCOEp9xKvUq2lrtAxrYrzJ8b
	 mPDbhYSPvugVdTuG2Ewqfg3OSSQ7+/zQg7GHiG78keX/U4fetLq//LGwk2pGLYqwWHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049333;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eyl0EPafbUZaYoMNTWWBnIQsd1h0SECqn3MMCqT3cGM=;
	b=KogS68ASkytl2N2bcfazqzJUrV/evF7fiHJgwfD14IoUMXVYbv241Wt14Taqj9O7FCjK
	 /N1zKV3/yXRnPt9ETj8cOK6nlTZqkd4ASwRLdXd2jHW30xIf9PzcvDxludE0Ywe3BQ2eN
	 mH+s4WhkkV2Yc9dI1XOjgQ11tSGNrXMItz7bPFIwE3rBF+4L8EwmqhsPAvZxcqjmL/Wx0
	 IP/aXVA0Vk9lq2FAdJal28231c0gMGkWr+RCEyXq5RtU9jpMkoFQ5FCSBDOpTOTOjmN+H
	 EgClfCglV01z6QmZIWV7qHWV3GJHxf67K+zMzPDPmS3S1RQf4ffddps8bh6JDLFQ2wQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8Ckvqe7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFFC606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8Ckvqe7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D307D1F008A2;
	Sat,  7 Nov 2026 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049333;
	bh=eyl0EPafbUZaYoMNTWWBnIQsd1h0SECqn3MMCqT3cGM=;
	h=From:To:Cc:Subject:Date;
	b=U8Ckvqe71VNovEfgs+qWl6PkzWajAE4JbsKvSILUFQ2sjGJXpw9OmKaJaJ+1ffgwQ
	 WCqcUZmnf3J4K4WPKRFXMOdgRepFRkgvEQwRaC5AXKleiTonALWeTxYfIKgxfcpIfL
	 Ve4H1mdicZBykmt1MNihlUO2DQPm6Yh7CuiRebFXWZRFSMA5GM1Nh/MWYflZqpHjEP
	 6dRSTTXrJgF1HjMPcra83wJSsctsy7P7RQgYfCqnqPkbkMOQfKYZUPJmXe26BPpQq7
	 ld2Iwb7G/waNZg61fWc3D4HBFaASMAYuM26jEtQhvmn67dcgaW25YoskZabcTH6W5S
	 PNkCy2zy52rCQ==
From: Sasha Levin <sashal@kernel.org>
To: henrik.enquist@gmail.com,
	pavel.hofman@ivitera.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: aloop: Don't constrain playback params in notify mode" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:02:11 -0500
Message-ID: <20261107060211-failed-5.15-ded106036984@kernel.org>
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
git cherry-pick -x ded106036984a9dd766e7e1451b02e2d15c81438
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060211-failed-5.15-ded106036984@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ded106036984a9dd766e7e1451b02e2d15c81438 Mon Sep 17 00:00:00 2001
From: Henrik Enquist <henrik.enquist@gmail.com>
Date: Sat, 3 Oct 2026 15:26:11 +0200
Subject: [PATCH] ALSA: aloop: Don't constrain playback params in notify mode

With notify enabled (the pcm_notify module parameter or the "PCM
Notify" control), the playback side of a cable may change format, rate
and channels while a capture is running. loopback_check_format() then
stops the capture and notifies the "PCM Slave" controls, so that the
capture application can reopen with the new parameters. For this
reason loopback_open() still gives a notify mode playback the
unconstrained loopback_pcm_hardware.

Since commit 898dfe4687f4 ("ALSA: aloop: Fix racy hw constraints
adjustment") the hw rules refine against the shared cable->hw instead
of the substream's own runtime->hw. This pins the playback side to the
parameters of an open capture whatever the notify setting is. A player
probing the device sees only the capture's rate, format and channels,
and the format change path in loopback_check_format() can't be reached
by a new playback.

Skip the format, rate and channels rules for the playback substream
when notify is enabled. Skip the period bytes rule as well: with a
sound timer source, params_change() already takes the period size from
a notify mode playback, and keeping the old capture's period bytes
leaves a playback at another rate with a period that doesn't match the
timer. The capture side stays constrained to the cable parameters.

The capture stop this makes reachable again was hardened by commit
826af7fa62e3 ("ALSA: aloop: Fix racy access at PCM trigger") and
commit e5c33cdc6f40 ("ALSA: aloop: Fix peer runtime UAF during
format-change stop"), which need to be applied first when backporting.

Reproducer, with notify enabled on the cable:
  arecord -D hw:Loopback,1,0 -r 44100 -f S32_LE -c 2 /dev/null &
  aplay -D hw:Loopback,0,0 96k.wav
Before: aplay is forced to 44100 Hz and the capture keeps running.
After: aplay runs at 96000 Hz, the capture is stopped and "PCM Slave
Rate" reports 96000.

Fixes: 898dfe4687f4 ("ALSA: aloop: Fix racy hw constraints adjustment")
Reported-by: Pavel Hofman <pavel.hofman@ivitera.com>
Closes: https://lore.kernel.org/all/b4af9071-f8d7-5b47-4d7a-c5743bd67394@ivitera.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Henrik Enquist <henrik.enquist@gmail.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20261003-aloop-notify-fix-v1-1-ba5dfb831bf5@gmail.com
---
 sound/drivers/aloop.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 81cb1f59f703b..5f0e2dc96769e 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -1073,6 +1073,18 @@ static unsigned int get_cable_index(struct snd_pcm_substream *substream)
 		return !substream->stream;
 }
 
+/*
+ * In notify mode the playback side may change format, rate, channels and,
+ * with a sound timer, the period size. A running capture that no longer
+ * matches is stopped by loopback_check_format().
+ * call in loopback->cable_lock
+ */
+static bool loopback_playback_unconstrained(struct loopback_pcm *dpcm)
+{
+	return dpcm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	       get_notify(dpcm);
+}
+
 static int rule_format(struct snd_pcm_hw_params *params,
 		       struct snd_pcm_hw_rule *rule)
 {
@@ -1082,6 +1094,8 @@ static int rule_format(struct snd_pcm_hw_params *params,
 
 	snd_mask_none(&m);
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		m.bits[0] = (u_int32_t)cable->hw.formats;
 		m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
 	}
@@ -1096,6 +1110,8 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.rate_min;
 		t.max = cable->hw.rate_max;
 	}
@@ -1112,6 +1128,8 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.channels_min;
 		t.max = cable->hw.channels_max;
 	}
@@ -1128,6 +1146,8 @@ static int rule_period_bytes(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.period_bytes_min;
 		t.max = cable->hw.period_bytes_max;
 	}
-- 
2.53.0




