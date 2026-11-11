Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419127;
	b=JiNbsXid9+YLV/NR3e8tXV6RXonJfxN79sf8dH48lXLnuXT1CstUDOndBU5i0V5EtjCi
	 azp+knwGe2+Va50wT6xMw9k9r6LeObN0gHTxYKirpKmiiRvDUiaq8aGOOzW1/Kb6lYy2+
	 IrSBhoUM82ukEpNFq5XBoceFpMkRzAgPoDQt//cIH7osDzJ0wChu/DxkINqPMBrE7cOz+
	 5lX2SFpTLoxSiwXKk6HfiaXbxkQBA3szIZqDDIfLWxdRIPm5spkiEXPgV3CBnmjdY+R0I
	 +bB3DoOhNlL6KZiZci+L+raXEH6AbIHhvOj3krRvqe6lWVVpZytgsP8qhYIkqzmfTJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419127;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mRP6vAhoWR3MmECjS8zD3FHlWKIUtew1wC7ZcpglQmg=;
	b=cJOuKMSBvinP3CtbLLWF1sAMvLD0ottrM7dx65V7QAZ83WHfYTXbVH1VYi1PRss63Tkx
	 hhP+/xbqfFa0JE5x1RcPxT7ozOMJoE3E23WgvNiRFsAb1x2mnohR4itObKi3EVroUR9uJ
	 /aipKTMEeV05Wt+BkeS4yEoDidJhpHuEheS/fB2fKoOCy/U43ATAVhyrFgZKjRZGJfGnM
	 Q8nZJ6jR7+ZrvQnGoqx/6A7HJlQTITuQ2HWdy1PgBNFbr5vnOV9LfUgT1t9H8epd3NcRx
	 7+TFnsqbR45RZZUVIfJQhdJrcO/0rb9/OSOujfM6FaL67aVqekPzhNjAT07wRRsH59w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BInpHpYF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBCE606C1CE
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BInpHpYF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A5B1F00A05;
	Wed, 11 Nov 2026 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419127;
	bh=mRP6vAhoWR3MmECjS8zD3FHlWKIUtew1wC7ZcpglQmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BInpHpYF37SZXjnXvXfNKP5FCNOAXzbx9n3YNXs+OfkC+/8VTNepSuPWalsGSeMDZ
	 LnN+97qRatRaUiAbnDIEKM38CI8prcQ31spAUgNiXTojz91iEDtVq7/JzSyzbdt/D4
	 8KL5yJkwywu3B2rAc/LpHl1nZ3SId1JCEg5C0LuN+D+dLun7/lckElJGEmUbcDvtwZ
	 UV0gnk1jOEdmXSBVaY7GaJF3XQd7zG8fzx6DlJTF1ECUCJNL7/hq9Fg3CKIGAqWwQd
	 s6wkjGpiHzbzgMAe64qceKQhuRDn9pYXItanp26CKCobiQK5zv444P2RqBxJvUefYv
	 FMW0se03gFGow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ALSA: aloop: Update the PCM Slave controls for a matching playback
Date: Wed, 11 Nov 2026 12:45:25 -0500
Message-ID: <20261111174512.3685448-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055309-failed-6.1-c3bde2beacbc@kernel.org>
References: <20261107055309-failed-6.1-c3bde2beacbc@kernel.org>
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
[ sashal: adjusted context to match the existing loopback_check_format() implementation ]
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

