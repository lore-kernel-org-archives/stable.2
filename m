Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792568808;
	b=X7cy+CGux0cRBfQBhMIEKpfdeKDcv0d8BnWrFsoWhwkI+MJbCUJCKBsv27zHyNeVTN5G
	 jwv41ZKgSZP4c/hov8JEqSwv97PKBOgRcrerwBx+063otUgWADGJIy1CWx9CnZgGmdTSg
	 9xLRCqSzjtukK0g7w2LqhI6GJyQQ8x3ohzfWgUbIn/iQoUrANPKJzAFgXf+cl41ND3C5s
	 2NzgXTsS6cS+jsqgtgk75P7hd8dgp50em6v/APzm9tGC4QNmKQXhfx21wAkwgqD0hcsFj
	 Nrj1EqYWiC90cNsXJUbxlrdmBa8NCGaf3km6qOeMc6zjdOA5rZtgYic/Li+t83faniA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568808;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L2u42M2YsC+ehb89rqqgYHL67FTxygXb/r1It10ecj0=;
	b=T91+Fu1rNsv+5uf2fd+Fl8YGl7UZruEuo0fWRXszsTCkUqGXXqV09Ie/g7d7h++viHqa
	 sMgRCT310AEKmT2XZA3nU5RQf2Lh3MeBIa5G/tCtrLmk5p5Jw0TUExTF9p4IkN4gSeDr+
	 3Ic5AO8rQT8uaVdW35d4TC7mqFHKWuAuDa349GsyIcxPZTuo6oXllpdPi8TgR5cQDVNa2
	 BG/056aZK7GTFWNfY4LDnB6a7pwVZ2NzfXhxF7/QhtpwXCGJkyoejYRrUSmrOXUfLgSNI
	 UaoLPGYcInCr9UhVNLXMj5vwJOaqNOZ1DCFkJ6f5Sa14xImoRjxnkLxqxTh+MvXpfgQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze8Y3R+a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88D2606A31D;
	Wed, 21 Oct 2026 07:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ze8Y3R+a
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792568807;
	b=GpVjM3Isj6FrDqmsP0/3bvPdVrji3B1sFuujXIz/4TdEs4HVSmVFPk2L3LrV8OEJh12r
	 8YpgFXeXf21vbhhag1NPefHIHgLFaxW5CDoRgPPfP2VpE5Ens//jAxpkZuwyKHQSk2kds
	 7gaM8AQBqobeCUGaIRF0IusWaLvChZz6B/bS8Pc5LZuyrUViiJtcqElSM/cSiMfC9pGeX
	 jit6cOO67lfXYsmnIJG3aANwSQWJMZZqPhd/J8TZ+7cPKK+MM02YT4pe8UYdp8QQxWTXn
	 LfGnndqexvGJsiF+Z/H3owU37D8Yp1gRtftpembBhbm+grgM2lRCxcEwXUHsICEE8jw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792568807;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=L2u42M2YsC+ehb89rqqgYHL67FTxygXb/r1It10ecj0=;
	b=COJaxL7RlC+TbetvR2Dq98RVzXu+9NfQl6bLQ3xBhB2PXU+n+yiK8s9q/PUXSIpsKREM
	 ldbbSRLg1hM/j+2ZlXQYYWZMmmb2l8zBDu5ZiB8FTo2hhpFsoFaR3z/Alv10TCzDW8e1x
	 khFICi43eM2jvnLdiJH3byw0NQElRlPx84xwPFpbkZZJyT0sN/f9wjUACBjElPlYkzCzG
	 c5XOH0F5J4RjEEFGFFKBTHKIJ4PNzRTrVOZpIKAWsE/G8xeM6qP6fNE2PtFeBOoW5gmO0
	 4M9X5b+qOrjNlnFBXcfDO6C52+LCZOyV8dMDfG6NmqzDQT3b8pmEUPEQmX82E/RetJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id EFF241F000CB;
	Wed, 21 Oct 2026 07:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792568807;
	bh=L2u42M2YsC+ehb89rqqgYHL67FTxygXb/r1It10ecj0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Ze8Y3R+aT+XNrWV6TiO2T0bYE3s6TM89rAMxTKHjKwTsDmHN7VsYw2pxbLMm1zW2U
	 N5Ga+Isbrv5TprsbF89N25njwDadLK9LmF4UTbjPrZLXnktIDgHLUu6CB8s/xQR7WD
	 V0BoltBky0oZfxThtgwCLVQ8lRUMjhmefDuykIC2DsqUn9iJ4qDjNLecsqGppA+Nzj
	 PvzKWFEBNH9xvaBG0ehmxKTjKOnOZCBV00nu74BKWS8CQKcPRCtmSwLbPJhai5DNTj
	 5cxqf/mc74GlR/Gy8XJJcKQ25CZYlihObZwyRJXLnQyvZbdsMX52LxmE3WxdZTMCW5
	 6WVdTfD9s5i9g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 532A64330A;
	Wed, 21 Oct 2026 07:46:45 +0000 (UTC)
From: Henrik Enquist via B4 Relay <devnull+henrik.enquist.gmail.com@kernel.org>
Date: Wed, 21 Oct 2026 09:46:45 +0200
Subject: [PATCH 1/2] ALSA: aloop: Update the PCM Slave controls for a
 matching playback
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261021-aloop-slave-controls-v1-1-62297727177f@gmail.com>
References: <20261021-aloop-slave-controls-v1-0-62297727177f@gmail.com>
In-Reply-To: <20261021-aloop-slave-controls-v1-0-62297727177f@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 Henrik Enquist <henrik.enquist@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792568804; l=2444;
 i=henrik.enquist@gmail.com; s=20261003; h=from:subject:message-id;
 bh=JSJJdwA1ZDYJEuhfeBvekFeO/E6auhSV39A86bwL5zo=;
 b=rwbDWv14VwAVd3bg7bGo+K04O3M1ra3Pg33dXO0xnzytFdHQK76IXF7N/JYkVRVUXMTPK4iSm
 /Ah/2wI0OgbCPGu33eqrATVSaoRWVswGtmLhwBMaVUIkowCovnZK1Tc
X-Developer-Key: i=henrik.enquist@gmail.com; a=ed25519;
 pk=ctrSXwtuuiWIZbc1qNzu+n+1PkhB/a+2nlRyXd5j2pg=
X-Endpoint-Received: by B4 Relay for henrik.enquist@gmail.com/20261003 with
 auth_id=1105
X-Original-From: Henrik Enquist <henrik.enquist@gmail.com>
Reply-To: henrik.enquist@gmail.com
Content-Transfer-Encoding: 7bit

From: Henrik Enquist <henrik.enquist@gmail.com>

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
---
 sound/drivers/aloop.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index d6a059ab37..824d320b66 100644
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


