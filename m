Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420534;
	b=Kt8Fh9gXFuZuELUTr84QmHPXEjCiCbfv6oyr85QpA6jUDHelpJZJcqiTO3iQyJP+YB0o
	 vcAZlNMPuQUqTQeEvBm+386uIQwtJarxgKzTFGcB6T51YNOFPi3iuMQVVgHjThsky9rw0
	 WpKHwId9YFye4BIJxQZSkuiKZ2HGv2iz54nZoTmjLa1xEY7+dJybk2f//1oOX7hdhphuP
	 OJ0IqBJ5oK9h6P9B+DoVor1CfbxCYN/AnynWJDypjmBoO38DMwK+TZcaFkvlzRqa3OnEy
	 zchtEgtumTfK/1A3sne9j/MhDlTyXhfduIOq1D0trH7jX9ttKtZDtXhoKF1ciG9mLGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U0gyj2a8XlEB3Koh9HkxkuEE0PBRiHK2iZJInBWgPso=;
	b=sukTf4r431R7aOO4ib1DC5VtYZW/my+4HwnkQFtkq5HMKLCWTw0EhnZ0ZUutfB+AGgHd
	 +GtRvkQP4EusW+HRd861FkRflroN9im6dvWvREp4fipVdOkdw97C2nAgwWcmI6nLQICI4
	 YOKSahISNRWdOIje4FbvBwbFcjpeoA2Gwmxgsk0mMCCKEaU8np4SL7UclcuYkNVs5nSW5
	 HKBry+gSSZ0gfaaYhk0vqyMKYmTlzdPGjmLfoJY3SNttTmaa6ixU27tj2Ff5bhVOJ01qP
	 8Nj+1BNbz81z5doY6VLvWfroyMH4OsnanYkOqmJllslEM2k8/iFvAd3c4fFfnujwLWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQM2J5d8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB85606A32A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQM2J5d8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9457B1F00A08;
	Wed, 11 Nov 2026 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420534;
	bh=U0gyj2a8XlEB3Koh9HkxkuEE0PBRiHK2iZJInBWgPso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eQM2J5d8qwv7mdF9sLI1MtZGVmF3mIvxSOUuiaNeJeqoYILXuxblI5YPeI3MrNRHg
	 +Tl8tmkxgdvEGmQpMDcuAnTou/YJWQOqSS++/V3+EDoBAVNgEoOyEuqNpRId9jqYH5
	 yd47/HWTcUlki9tYqfHVaY9dhZjEC+aVJBGjR6dYnjMpdy7l30rLTdIc1jXILulnTf
	 Kve8VH11XEXM86PAb31d16StcdMKTpwdD8ImtAlCIZ2HK00O/LwapnoIUbQCMfT5Je
	 qj6IhYp4mC5KVmNc0ifOPwm4+s0s7at+izpSdmCiadJRVsmzm1sk0fXBKT2zviEmw2
	 +YBH00Rf2zS/w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Henrik Enquist <henrik.enquist@gmail.com>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] ALSA: aloop: Don't constrain playback params in notify mode
Date: Wed, 11 Nov 2026 13:08:51 -0500
Message-ID: <20261111180831.3732596-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111180831.3732596-1-sashal@kernel.org>
References: <20261107054422-failed-6.1-ded106036984@kernel.org>
 <20261111180831.3732596-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index cc0c59232d61f..18ca2951d4be6 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -944,6 +944,18 @@ static unsigned int get_cable_index(struct snd_pcm_substream *substream)
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
@@ -953,6 +965,8 @@ static int rule_format(struct snd_pcm_hw_params *params,
 
 	snd_mask_none(&m);
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		m.bits[0] = (u_int32_t)cable->hw.formats;
 		m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
 	}
@@ -967,6 +981,8 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.rate_min;
 		t.max = cable->hw.rate_max;
 	}
@@ -983,6 +999,8 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.channels_min;
 		t.max = cable->hw.channels_max;
 	}
@@ -999,6 +1017,8 @@ static int rule_period_bytes(struct snd_pcm_hw_params *params,
 	struct snd_interval t;
 
 	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		if (loopback_playback_unconstrained(dpcm))
+			return 0;
 		t.min = cable->hw.period_bytes_min;
 		t.max = cable->hw.period_bytes_max;
 	}
-- 
2.53.0

