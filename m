Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419850;
	b=jaz9gdvpy97clIQwXfr5czTCgplACAAhQYpqWePo2m2HBb2Kpxud60ibW/qLrlLy8WKy
	 GS9C0AOVwI0PuNnZA6aCmUdKu+r8kbAQgBycNthDK7wQRylkleCUQxoEpkqvpCYyiB4V2
	 l2rSqkVUHX4FFcjwNVzWxz0bqgZiwERYsmnncipzKg98Jhu92tOPHTufSWPHVDOsJpC1F
	 t1s4wMQPAltGPKngiDRFhcsUv5dwPfDZEdo2TzIpq26vaERekRrxL11pK0odKny4v/WV2
	 5aQyvPJx8PAqN7QTqDnk4K5aBk2JPmyfB1HkY7H0S9C43lImpNf2Jk3EbAErVL4rG5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419850;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RUFQ+BqETQtvZKJj7YJY/vtA5QdUYciKAWLwRhReREo=;
	b=Y0RCwHMyhR9GyLVdRAzkXWrzJvhAfeayhteOs7geRd2KB839HiJdColC2zy2lCjeuVPX
	 Hn7ujhQija2QfzOFt0ryfJCrobYOoNRMprl/tTb7WnM/4ngbK7UrUN4YO0gIjrXq5EKlk
	 CrgdNkKhOJ51VeROXME0OhKM/obampIW0N9Vpk3+xhPBIrmjYj7mA9CB3NRaGJHxDw5XP
	 JCLj6f5ryoA8MzpEDipA38MZZyuCrKCv2iFpBfAaRCBsg0iq4KCgWoK9owXkI4o1eKLLP
	 e8Os1dI2PLpdSOYQHGPqmv0Etse7N8OBV4MES/f865Ftas6oIXM6S7Ls/br7skeRKBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjkqYT1A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA18606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UjkqYT1A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 393351F00A06;
	Wed, 11 Nov 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419849;
	bh=RUFQ+BqETQtvZKJj7YJY/vtA5QdUYciKAWLwRhReREo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UjkqYT1AAcYXmPh7PuollIcGZky5NnLdd9aBWLgyE6FJQ36XIpiks/3iGs1W5SR2e
	 TJ7sh7LgfxZruiEctbKNGS74Rjovr8g1EzA/1ee9swhpD4LrE0uW4oXGzCH9i5dPpr
	 qiX08AyOn08Gu6WGZKFvVq99B1TDUr+U+kgTxQv33tpclA2Wp933s7pQobw7rmeXZv
	 GOzAjZv53UuD16rd8soH9WyhKtcxCFjmqE6OFN7QutxjrPR0nNhFSD/IFNUTZSGghk
	 BN7IbT2BPmF7AZfp4QtB6Bn3uXGNjf1NQRlKuF0TNXMvBnWskPX40AYlogmCDteGC+
	 UbiUw7cWwgzvg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ALSA: aloop: Update the PCM Slave controls for a matching playback
Date: Wed, 11 Nov 2026 12:57:27 -0500
Message-ID: <20261111175712.3698081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061020-failed-5.15-c3bde2beacbc@kernel.org>
References: <20261107061020-failed-5.15-c3bde2beacbc@kernel.org>
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

From: Henrik Enquist <henrik.enquist@gmail.com>

[ Upstream commit c3bde2beacbcb40790f0e3c3f909f9e16bbced9c ]

The "PCM Slave" format, rate, channels and access controls report the
parameters of the playback side of a cable. loopback_check_format()
updates them when a playback starts, but returns early when a capture
is open and its parameters match. The controls then keep the module
defaults, or the parameters of an earlier stream.

A playback that joins an open capture with the same parameters is the
normal case without notify, where it is constrained to the capture's
parameters, and also with notify whenever the player happens to use
them. An application that reads the controls to find the playback's
parameters, for example to reopen the capture side at the right rate
after a restart, then gets the wrong values.

Only skip the capture stop when the parameters match, and update the
controls in every case. A value event is still sent only for a control
whose value changes.

Reproducer:
  arecord -D hw:Loopback,1,0 -r 44100 -f S16_LE -c 2 /dev/null &
  aplay -D hw:Loopback,0,0 -t raw -r 44100 -f S16_LE -c 2 /dev/zero &
  amixer -c Loopback cget "iface=PCM,name='PCM Slave Rate',device=1"
Before: the control reports 48000, the module default.
After: it reports 44100.

Fixes: 597603d615d2 ("ALSA: introduce the snd-aloop module for the PCM loopback")
Cc: stable@vger.kernel.org
Signed-off-by: Henrik Enquist <henrik.enquist@gmail.com>
Link: https://patch.msgid.link/20261021-aloop-slave-controls-v1-1-62297727177f@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
[ sashal: Retained explicit locking with goto unlock cleanup instead of upstream’s scoped locking. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index fb507076e006f..b2df37d63ad73 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -351,12 +351,15 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 		check = runtime->format != cruntime->format ||
 			runtime->rate != cruntime->rate ||
 			runtime->channels != cruntime->channels;
-		if (!check)
-			goto unlock;
-		if (stream == SNDRV_PCM_STREAM_CAPTURE) {
+		/*
+		 * Matching params also go on to the update below, so that
+		 * the setup controls follow a playback that joins an open
+		 * capture.
+		 */
+		if (check && stream == SNDRV_PCM_STREAM_CAPTURE) {
 			err = -EIO;
 			goto unlock;
-		} else if (snd_pcm_running(dpcm_capt->substream)) {
+		} else if (check && snd_pcm_running(dpcm_capt->substream)) {
 			/* close must not free the peer runtime below */
 			atomic_inc(&cable->stop_count);
 			stop_capture = true;
-- 
2.53.0

