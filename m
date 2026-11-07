Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048791;
	b=1TSXldcFLWLl87bsbcsO6+X+F3dzEQithWUompQAjaiYiP3U83Y1hER4nbdOdDKvaHk4
	 2IrIB7fEQprb/sXPVyI0x0nTHubxboBYB8E44UM2ZRE9Xb2ZxiDup8aTxfNj3UoYgWQ1q
	 ny2zxmmcZs4oTTTyggx2hT/rDOuxRKSKaftxpvv09cnH3SChMQOFVYUaFR07XlWxatuh2
	 XkUmt5iTvNHiV39saYZJPt0XCsfv7/y7L7KGKHCkl/qXroZQV3wnl7VCYKFEUsrovXvgV
	 brBo9j1F5m509E4Rn6bT1oXt6A4HVuoYDcC3Xt+JsQxRj+oXCuAQ8TqAAxlUQW9kNkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048791;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sfOEpt6mnQ3YFSmvpS6yeEhAja/pUZAvxPNpZZAS2oE=;
	b=heShMtpQdEJNkeZX6rEbyMxm4mofBpdtsXs4B3m1Jvwk23zxpaCLU8oIAzpyopQ8zJeB
	 SvN3Qeb5ZAoXwpdqjN9t5NwQYhXgR/3w/TPUGYfVCApj3AiVHvb7zCyoD/TZMp9TOXPJa
	 cknhKk1Z9WJIwvu83ORtMXC8VDy4QWyn1yyVHk93wmS5+OsxAk/k0h2065tXgVDByG3Dh
	 23tBgNOR/yi1T6KHUVKdIkayRZtQoDhYvbLT9b8bIj6/XmMPJLdX9PQSNlI00RXAiBDzt
	 wZ/46H91kAf3VfpFYOWuilcUXjGUa9eUbCXoA6U4eXv2bm4p69vDwqvanBK28YsHEAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eg8m0bVn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AD606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eg8m0bVn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49741F008A3;
	Sat,  7 Nov 2026 10:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048791;
	bh=sfOEpt6mnQ3YFSmvpS6yeEhAja/pUZAvxPNpZZAS2oE=;
	h=From:To:Cc:Subject:Date;
	b=Eg8m0bVnTRQ3lXn7D1zfntb/GpY4+Cz9myKbDSNqRZXRCyXTdqlNUrqTwoGyOEmSc
	 E0SW/BN7AutoDFf3lDXkUr2x8bi4U6j8IZHY7AMXm7sIxbhkKbrVhWyJueBQtNSeiI
	 tuZ7MfXb3sEIMxMzfvXckwtndrc/wRcbBOnroxcaNCpa5JS7Y08FiFY75k3o7NDto2
	 RNsQTzDV+yCkky7aeyTQ+YoUFfFC3LepZONZu8tmLyp4QkAIToP2fCKNINV94dEn4L
	 Nzh2zn8mZWeoF1Bnol8u1W6T9d9IelaZ8MZq5oVUW3vGQiUfwnKa6181b/uG5bQIJE
	 sZRLVqb5j7C2A==
From: Sasha Levin <sashal@kernel.org>
To: henrik.enquist@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: aloop: Update the PCM Slave controls for a matching playback" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:09 -0500
Message-ID: <20261107055309-failed-6.1-c3bde2beacbc@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c3bde2beacbcb40790f0e3c3f909f9e16bbced9c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055309-failed-6.1-c3bde2beacbc@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




