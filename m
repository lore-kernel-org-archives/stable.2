Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421076;
	b=gDcBH1I3x/fTPnY9s5ou2nvgfsbOihXszb9BVto6+kdxVy/I6d5NonEVTby8Ccx4jUfv
	 Qs5e5XMohnHJfbpqF+y793W9K68dqrC3D0P4zEqrOZ9aDj2ncEMBScltcv6yDSEYFOnnt
	 McOON5u9AC1TF9tmXmIJEHZ4cxWmV1HiEOtP2G0n7OIN/vrOiwSVd6awwGR9nwFEGWlly
	 EmD7OxW+RXwTFDNsXgWu7SzDnkHMQ1wtfLkGfrBtipzFhiKsYTsMmfWUoclgLGJrAsQen
	 a8XWRZnnGUJ8bVdZdW861UOC3F1PcKcsRVZJiUM3WY7tCVGKW6Tg6N6r7rR8hE2Zk2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421076;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JySMTmDqir6kxC3CpohRUhPfcg3KuAK+ka6qrtrmmAM=;
	b=spY4WG8Q9glwO4NTWlr8hQcTVNlBWqnRejv5yEYSF06y4GRNadgqrYxreB2scO1ggMY5
	 4bNi9hngbJetyn153Ls2tQ39X33Dq/HE1s/fqqncNaWyDotmpzfp9pWZ1QiFR9045zLJg
	 zmzv5OC9aCFMVZ8O0ijl6DvRZzgIapCnG+BU5xqVEOmFpwdUsm+odMXjqNMxZiRopubc3
	 4+nZOj5YDD1G0dXq4oEELGwGSykN0bFmAy0o1rwaw5El87arN+59qoKCeCrchwwBaXJVY
	 nvqqzHbsR5iVqWUYeLyJX5T5zGIKtbr7QWwEraBlYcIKct2+2bJe1uhLbpPDqGc0xEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcAhojaf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04B6606A89A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OcAhojaf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003E81F00A05;
	Wed, 11 Nov 2026 18:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794421076;
	bh=JySMTmDqir6kxC3CpohRUhPfcg3KuAK+ka6qrtrmmAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OcAhojafWelXzNX9OynLXX5aGI9phwGI1pfl7Y+jdtkvDmesEkeii86MyndA8/Ik5
	 eLereyKkZSzBPZbTdaXdn4cQ+fhn/pP7DqaarWcwCZoTvhPkEeNGpips78gPRzOxs5
	 sjpLiPun83l29mwmkfuVP49LYN5ldfkC/hOgpttbk5WwirebCXrAJb9RKTSdELVk5n
	 6g07vkMBIAR2jPHsd1T5a+GdHzf3a7jPbNBiqsgElIKqCNYOeNTJtz5VocOHR4BEnC
	 /QC/2YI5LJoaKbeoPICalp/Hwk2WORARREgoM1SzfRuhDZAcD+R2gOf2RDJ1sywPKn
	 T6x8Zyj8JDcNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: aloop: Don't constrain playback params in notify mode
Date: Wed, 11 Nov 2026 13:17:54 -0500
Message-ID: <20261111181732.3810170-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060211-failed-5.15-ded106036984@kernel.org>
References: <20261107060211-failed-5.15-ded106036984@kernel.org>
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

From: Henrik Enquist <henrik.enquist@gmail.com>

[ Upstream commit ded106036984a9dd766e7e1451b02e2d15c81438 ]

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
[ sashal: adapted scoped_guard() mutex handling to explicit mutex_lock() and mutex_unlock() calls ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index fb507076e006f..7c76f702296e1 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -960,6 +960,11 @@ static int rule_format(struct snd_pcm_hw_params *params,
 
 	snd_mask_none(&m);
 	mutex_lock(&dpcm->loopback->cable_lock);
+	if (dpcm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    get_notify(dpcm)) {
+		mutex_unlock(&dpcm->loopback->cable_lock);
+		return 0;
+	}
 	m.bits[0] = (u_int32_t)cable->hw.formats;
 	m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
 	mutex_unlock(&dpcm->loopback->cable_lock);
@@ -974,6 +979,11 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	mutex_lock(&dpcm->loopback->cable_lock);
+	if (dpcm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    get_notify(dpcm)) {
+		mutex_unlock(&dpcm->loopback->cable_lock);
+		return 0;
+	}
 	t.min = cable->hw.rate_min;
 	t.max = cable->hw.rate_max;
 	mutex_unlock(&dpcm->loopback->cable_lock);
@@ -990,6 +1000,11 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	mutex_lock(&dpcm->loopback->cable_lock);
+	if (dpcm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    get_notify(dpcm)) {
+		mutex_unlock(&dpcm->loopback->cable_lock);
+		return 0;
+	}
 	t.min = cable->hw.channels_min;
 	t.max = cable->hw.channels_max;
 	mutex_unlock(&dpcm->loopback->cable_lock);
@@ -1006,6 +1021,11 @@ static int rule_period_bytes(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	mutex_lock(&dpcm->loopback->cable_lock);
+	if (dpcm->substream->stream == SNDRV_PCM_STREAM_PLAYBACK &&
+	    get_notify(dpcm)) {
+		mutex_unlock(&dpcm->loopback->cable_lock);
+		return 0;
+	}
 	t.min = cable->hw.period_bytes_min;
 	t.max = cable->hw.period_bytes_max;
 	mutex_unlock(&dpcm->loopback->cable_lock);
-- 
2.53.0

