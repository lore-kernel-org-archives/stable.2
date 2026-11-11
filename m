Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418959;
	b=nllizxfe++GsF/uR7g5vabU1RyXvmNBbtxYnFXjFMM+uzDT8Iz098857Q8pWRwwxVQKb
	 Ss6vczCZ8IVPYjqG/sDPoUqwkCCa7Xhnlu5AFRlTilySSVMEiL8qv8OG8K744Uh/SL7ey
	 k62eUtKkzwl33pvk0pnisS6GRaI2j/dWVzo/BRioq+CG3791m+R80cJ5YKXSOVzwhxlvd
	 SsPHBpoWlzZqYaQAgc9re38baouWf0kyeXGBbI8aIWPL23Q6hXxWckfk6VG2WKCjqtSu5
	 tmuoUCQoMI+OohkZlo9HftvbgXIH5lednNF84kA6zPeofu5r0vq5smXTeEfeCz5dqqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/awrkvgaivukY33xJpmIxlXREOmLKLBaHz8ox8yS5RM=;
	b=KD5CkK46hSYmt7/GCPl8Gg4qoYg5gjDTMSfuUW8g4ERKLZeAMdFpdUjzamVjgGhTQWdm
	 NjIgoBpMNTGMeXpReB4K5GFJw6cEeWPznpkWSc+EeSYUiqYqoyrbneSae/UN2gEJjijGy
	 5xw6uKc8DW/nOWm5J3EdUfAebejMiW5H0a56c1S1HkZoIhGq5qlHza1L2Mc4wMPbeOmok
	 Qy5NsLTxjaLs9o63nY5IKDs0hA8uHa8lqkSzqaYjxff37Cf2x54oainmRYMnDB2nWPLJf
	 YrhziaGW+E6YwXXyPsgJ2kUOo5/U4uOGo5x1vcT7DPcw0FUsc4CIAvpSLO2zOCSKySQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRnzzUeG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCAD60A380A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hRnzzUeG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4A61F00A08;
	Wed, 11 Nov 2026 17:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794418959;
	bh=/awrkvgaivukY33xJpmIxlXREOmLKLBaHz8ox8yS5RM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hRnzzUeGaaYjpOPe4w82GOykY4gksPrrLwO8sYKRZb/PTUqOz9pfZIIDZkOsqyjrq
	 nBfGsBzjWD/q/PJ9Rld9eAOx21zARUkOAYKVM0OJaw/37jNZYivBv3JdiSYfOE5GAq
	 D5u00bBIaQUe2gV9E4W4/zIsTqUdRjWKYDne7c5Az/KmJEw6euB42xyyUuLJpXdxlg
	 dTadNC6RLGIfOqSZhilmG18wagyYBLehvWRPIdJsiBSdsncq8ihpc+tLM6NWcbolwL
	 hnT3pRgSJscZb9usaCh2+BGPB4T3VQKGopbk2lVQE0UoAjrAOimJWTGPqLnNxeOwMf
	 cgV+QtlCzXOpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ALSA: aloop: Update the PCM Slave controls for a matching playback
Date: Wed, 11 Nov 2026 12:42:37 -0500
Message-ID: <20261111174223.3632325-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053803-failed-6.6-c3bde2beacbc@kernel.org>
References: <20261107053803-failed-6.6-c3bde2beacbc@kernel.org>
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
[ sashal: Adjusted loopback_check_format() context to account for missing access-mode comparisons. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9c7671f034d54..29959455fe072 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -346,11 +346,14 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 			check = runtime->format != cruntime->format ||
 				runtime->rate != cruntime->rate ||
 				runtime->channels != cruntime->channels;
-			if (!check)
-				return 0;
-			if (stream == SNDRV_PCM_STREAM_CAPTURE)
+			/*
+			 * Matching params also go on to the update below, so that
+			 * the setup controls follow a playback that joins an open
+			 * capture.
+			 */
+			if (check && stream == SNDRV_PCM_STREAM_CAPTURE)
 				return -EIO;
-			else if (cruntime->state == SNDRV_PCM_STATE_RUNNING) {
+			else if (check && cruntime->state == SNDRV_PCM_STATE_RUNNING) {
 				/* close must not free the peer runtime below */
 				atomic_inc(&cable->stop_count);
 				stop_capture = true;
-- 
2.53.0

