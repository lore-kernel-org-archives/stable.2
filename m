Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA42395DAA;
	Sat,  3 Oct 2026 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791033972; cv=none; b=C18fNN9gQqlCgMS7J7uVyhRbltKGUGfOk6o1G82BTXRneqCL2wF7Z9AWPOB7P/d7hE14tDn6bNlZfoVmWW3e3s7zbPOfI2UmBZRj0c76YKTPiYYsdLFgWwPPSoUVZXSuimdGrIAY/MsFAK3VL4dhPB9m84FqSSsJwPheUmhy5XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791033972; c=relaxed/simple;
	bh=QiaWRivoGP/Wplbe4uVdripPFFwjEzIsQT0XwHBlB7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KiZ/k0Ue87P42ZyeyqJrmof9bd+qFChqcNCRrEUUvvaSBRYua0BiJE1BuArmBChOK75jk5ISkLwHEjzsGGMVI21nh3onhV5PvHjSrRI5sHkz/4beQK3GXFl09tKR4niVIcQoYwi0xESRx8v27CQb/Aegk9A7dUZRs32wcv2wWks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gr9kNhoh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gr9kNhoh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE2D2C2BCF4;
	Sat,  3 Oct 2026 13:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791033972;
	bh=QiaWRivoGP/Wplbe4uVdripPFFwjEzIsQT0XwHBlB7A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=gr9kNhohnPKn4Kqmk43qPgFG1/oVWSpgoHzPhlOdUT6keof/g/ruBnkKV1ykB7hpF
	 cKgScXwed915TBMc6frLwbumQ2XR3N9lqkfGy5iALXuhPcxsoGqptSkPpTbo0/rFCt
	 5v4Xad00CvlvRHfVT6+K58gYg6hddLUV5ArGcBIRsyvNhUr1FIUE8rNbLB7udLHnh8
	 hl8lFaJ2T3T87IwdawwMGD4yNOWyc0H3aZAB9OlzmF6DfaOvRciQcXt/pFaVVJrCBA
	 /toK68emAbkGktZnlunas9IqKa/cWZUNCIAv/106giN6NjV/V/NHgUJgPVLgwOXnAd
	 SKVjGO1p5AcMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF59ECA5FEC;
	Sat,  3 Oct 2026 13:26:11 +0000 (UTC)
From: Henrik Enquist via B4 Relay <devnull+henrik.enquist.gmail.com@kernel.org>
Date: Sat, 03 Oct 2026 15:26:11 +0200
Subject: [PATCH 1/2] ALSA: aloop: Don't constrain playback params in notify
 mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-aloop-notify-fix-v1-1-ba5dfb831bf5@gmail.com>
References: <20261003-aloop-notify-fix-v1-0-ba5dfb831bf5@gmail.com>
In-Reply-To: <20261003-aloop-notify-fix-v1-0-ba5dfb831bf5@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Pavel Hofman <pavel.hofman@ivitera.com>, 
 stable@vger.kernel.org, Henrik Enquist <henrik.enquist@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791033970; l=4399;
 i=henrik.enquist@gmail.com; s=20261003; h=from:subject:message-id;
 bh=mJsEJIlV/QPq6A80rdiZ6mhKny6SlO7v9jlAYqri6pk=;
 b=iJJKSuzJgqU5oSM5B24n9BAfa+4jEq6E9cHWU1sWKrWZiMX89fwpCpqcwTHihzsxeOTRpjIH0
 YBApUUsYpT9DiqJgm1SQRes+FTlNXqZGgbjzTEJz23Iz2u6OKi3pbGf
X-Developer-Key: i=henrik.enquist@gmail.com; a=ed25519;
 pk=ctrSXwtuuiWIZbc1qNzu+n+1PkhB/a+2nlRyXd5j2pg=
X-Endpoint-Received: by B4 Relay for henrik.enquist@gmail.com/20261003 with
 auth_id=1105
X-Original-From: Henrik Enquist <henrik.enquist@gmail.com>
Reply-To: henrik.enquist@gmail.com

From: Henrik Enquist <henrik.enquist@gmail.com>

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
---
 sound/drivers/aloop.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 81cb1f59f7..5f0e2dc967 100644
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


