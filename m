Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050852;
	b=umFjBYe1vksndW5r+ewXSCBXW0hYQqjXpDQBtx1F5i93jraBgy09Ca7aDpwTlpFY4wQV
	 8Ixvi9BIsd6g4WTBFM+tRXkwp/hmRXFg1ojX1Y8TQ7N+wiW2Hs6udj07+KksrpuafxCkT
	 /cZUp0VzdEuwyN2U2bfB0DE6o1fywY0qqVKeWkqYeGGGjUOzKdv7lv1d1LH22Rt6WG6c+
	 S0xw9Awn0RVTNS8mumZzy7V7pw0NGs3va+ZePncevUeKoBoBcohMZYf3siNO1Pf70lrCH
	 V0kezzFDah8x82QPtow/zgO+UjzWzlmxrAk/L8sUAjNojTdqN3B5oNYYBpNmVdKin6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050852;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=abZQeOjODzIdWUqvhceHcBQyRNm5Rr4INkstzJuxDhU=;
	b=A8TPgDB5cXsIc77CaBljbnOR35q1Yv07tiG05ikpADhjvMcq5G8ADWt2qqxm360MZbT0
	 44abjcr7q52YJxMnJFV7UqQ54ow791CpZs6d3i5Gb65V8gYI+8/JseAZUFDrgK+itB5lw
	 KGvlUVcdS6VNuSbcVgqRhESrOwmXAYL/YMOEMGEmBplzXqDaFN9skbLCvGmempgzO6+7F
	 Nq5uNY8xsGdTNIxrvLwZ6ufz8u1BFrW0pguiNHVbbu4sy39tGySOTk/2LrfpHRNfjjOml
	 ZKDG5kduGMgXm5qs8GRsXGQO2XeGeBnGeqdNP0mTycXl7zc2/2HvHKHDloYkr7uYWgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcbbWAdi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6051C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AcbbWAdi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB641F0089F;
	Sat,  7 Nov 2026 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050852;
	bh=abZQeOjODzIdWUqvhceHcBQyRNm5Rr4INkstzJuxDhU=;
	h=From:To:Cc:Subject:Date;
	b=AcbbWAdisOwYgNknoEESi57EcKlZx4f7WldhZpgdi2eTOh2GFrhKUMShlqg9Wn2e0
	 toovTIK4XwoPfkp3ysmW6gnbQJWMd5ys9F4s/AYVeA3K+kbJeg5vrLJQKWRMZdCjYb
	 XQtQrXzvkk6A38XnyRve/WmNSEST7Qa60H9c5XyqlLqiKHdr+AM8t2f8fevXIilyUF
	 1YomA29Ix8EGR7mHqVqXF+k4h+p34nixdDNoHFSxVh1fOJyI9BPOK1y3YcouvqhgAQ
	 6+nNdKuORG0jPHi1G5PV+0nKfil+bfvIwGJloXf2rVBw/3gEFF5l5D7ifqDjfhTjFL
	 BLLHvfs+arHyg==
From: Sasha Levin <sashal@kernel.org>
To: henrik.enquist@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: aloop: Update the PCM Slave controls for a matching playback" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:30 -0500
Message-ID: <20261107062730-failed-5.10-c3bde2beacbc@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c3bde2beacbcb40790f0e3c3f909f9e16bbced9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062730-failed-5.10-c3bde2beacbc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c3bde2beacbcb40790f0e3c3f909f9e16bbced9c Mon Sep 17 00:00:00 2001
From: Henrik Enquist <henrik.enquist@gmail.com>
Date: Wed, 21 Oct 2026 09:46:45 +0200
Subject: [PATCH] ALSA: aloop: Update the PCM Slave controls for a matching
 playback

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
---
 sound/drivers/aloop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d6a059ab37474..824d320b665bf 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -412,11 +412,14 @@ static int loopback_check_format(struct loopback_cable *cable, int stream)
 			runtime->channels != cruntime->channels ||
 			is_access_interleaved(runtime->access) !=
 			is_access_interleaved(cruntime->access);
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
 				snd_refcount_get(&cable->stop_count);
 				stop_capture = true;
-- 
2.53.0




