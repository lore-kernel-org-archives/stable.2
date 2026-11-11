Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420009;
	b=nDkEMvoKW4EB+YFlONj6kUkckipEkIp51yRFSrnwWEXG9qvqPZk+IofLArso9HkephVm
	 Mp+lXB6Pr1K0b8EUr7RTjGvP+lU4kg6TiiGXFIGgCYK8ho7zD28zR9G4bYUL8pvGpfNsS
	 qxt9QORguG2lz2KnW/qk7UfXUlm8lQu6+aYjxwvVCHoJvxOpHzviKlyP21M7ZwO3pq5b9
	 ZmdR5uIQ2Wbqpt3OCtmRsOBZTiux4ZiGKdnX9RlLZGrhRit+C73NQzqnRGgmYUvUmaQ5g
	 LWVUGV8n7NaRscSJfafal9KGnHB9uveSptkCEDMlIfP4MKnxiFYBXDJgEt/2HYQ2N4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420009;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BQsSrUPstIFKgK5G0KyjZrsa1htiJg4mwWP21ZqhMHg=;
	b=WHEatFGXclH3n0IlTew114he1wZSzPJ8pnmu+uK5k1nfW83XYipTl35SyWhA9Lir/VsS
	 VR8S7/VaBIUD/OeM0w54thehKySkmrLCQXI9svaSiaU+iBTIhgsCQcXRX9FHeQ/EfeOD3
	 z0wDSe680Dj5R0iFG2JwAwnayN+C+iQj+YnDxIGA5Wa2n68vwTYe+ZdTd1FTgID5CoYzL
	 /5R46wR+qCBM9pdEOEW+IEVG7ORHkK8X3vmdmdPsNKVzT0qjbqZSIr6Rq04JJvJikzQo2
	 cJVP/qAhcvtldWz/9HYPcUJIJpXM7jUGh9HGZCLP2VqEJWpbumanSkM8Iek7nhxmZfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDFtatVU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D4A606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDFtatVU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4533A1F00A0C;
	Wed, 11 Nov 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420008;
	bh=BQsSrUPstIFKgK5G0KyjZrsa1htiJg4mwWP21ZqhMHg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDFtatVUYI2fwllMoq93hWDHfq3B/rwvME/S7bv0nXapQfibAkZXFzqKB4AeHxvWa
	 yZu7lm/67C9rTwrG0yWkl5UY8wD/cE5Iv5ku998FvbCqSpGR0rR01+oQfZGu0od8Pe
	 EdZ1NwklgcOPP2UXOfD4w79oECp7CAbaJQ08XWNFZ2qvwaJP+XPy6iQJVDgYMhp//y
	 oE3xloV8FbB5xoqZIOc10Q6oQZ3GYZMoF84arVZlRInvG7lV8nLVEqkzvQc2DG8RF3
	 3l2C5QWV+LdyWYH0KGbzYU+Y+NCSGGSysGiGLb5CnSk/BDLZFGSN0VbKEwa2m0rksr
	 0BvuLc9EsRgrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] ALSA: aloop: Update the PCM Slave controls for a matching playback
Date: Wed, 11 Nov 2026 13:00:07 -0500
Message-ID: <20261111175949.3747120-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062730-failed-5.10-c3bde2beacbc@kernel.org>
References: <20261107062730-failed-5.10-c3bde2beacbc@kernel.org>
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
[ sashal: adapted the checks to the existing err/goto unlock flow and snd_pcm_running() helper ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 3901f52164933..d10ec91a0aa54 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -352,12 +352,15 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
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

