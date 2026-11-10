Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794313102;
	b=lDICxRK3VdshCSsr1uvmpflUuzsWiVCpJigm3lnxrFscDYeKcRDeMuBvN6im33CSvLk8
	 10j0yjyBgt2FHgzcSGD11CUYGenIkYSHYONOc5PRX85JjpquDiBSEEVvjKXgQyV5v2TM5
	 jh9c51+t3GpDb0giIG6JnTPKRgTR644CKywmYKPOQMQwz7Bsh3k06vbQbCcmV8Yr5MOOA
	 fzRTiXwF3TXXRiJWO7RR4L+fIzGoiaqF8xxJ4BcC2qxlLAY5HIlNkwjx4Z6hgOYOUKCYE
	 eJtG7bhIL5KSKXSukQjJRjvSJWyDSiyFuixis4odf5YH3TrxEHYhMZygjLIlKrDkynw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794313102;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZIJWQ2myrys9mJU+5h/n/zDd+azt+wjrOqDl9ey6a0c=;
	b=wx/GyUaie5RK6dhGrOVWwh8J7ZzygfFjIhzYAsTAlINhNC7B92sY9kyiXfWV84nXflOK
	 nf5/bb2zDsTVPAt2JH9vUFUFdtDHI5jcOwZTYCXOs0f6ozChgJWlWJ5XeB81I1BPIka/J
	 I2YL4iFKwkUZtkYwJZx6AvMQ3NQMxNbQb7TBV5UfKfTVOTNruXZSEWnOSCnlbYXbHzD/6
	 Sj7Mbql6XBzKeUt/yVMdSw7d5rfkD1z22PN7vRFLmYhxPUw23WorMZWUyfLv86NDSKd5x
	 O6DWItpidAR8vvoRqlyzTg43U0RV8UXsVW4O1xjaw8rc+Vq00yMZCY5jJoTJibSs5Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db8lh8JJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965F606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Db8lh8JJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA7E1F008A2;
	Tue, 10 Nov 2026 12:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794313101;
	bh=ZIJWQ2myrys9mJU+5h/n/zDd+azt+wjrOqDl9ey6a0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Db8lh8JJJwwH0QunnqgrZ18ERTbXjTlVfM8cK66B1rQqn6019p7bmyVmSeh6VfHUC
	 JJdU99oRl/nzfdhx/2CwSjR+EuBulI6wxxgpCpgIP9kqUZFJXs9qXEL8X1OuMbi3LX
	 9yGaA+RM/R+A8AMTSq2WT/wELcjsg5SDMPxDNaC/9CQtDmU11ACfVdVv8lI8S/TKtE
	 h+9+jcgZeJPU1TJSSzZXh9fTb38sK1j8bKe/MpwY8Fx+Ut7oQrxgvG4p0uL+4H1ee8
	 HeOx1GgjALeFMmSGvn64eRJxgJxw/LXd34bApTyZj/CEYJaKW826wfutoPVZM89WGf
	 l0bAGY2NaO8Hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks
Date: Tue, 10 Nov 2026 07:18:18 -0500
Message-ID: <20261110121811.1094002-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121811.1094002-1-sashal@kernel.org>
References: <20261107051806-failed-6.12-1bbc033983b7@kernel.org>
 <20261110121811.1094002-1-sashal@kernel.org>
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

From: Danish Khateeb <danishkhateeb03@gmail.com>

[ Upstream commit 1bbc033983b76f41d51d4a48838bf94c5e6b6f50 ]

32-bit tasks on a 64-bit kernel can't use userspace-driven timers. The
compat handler for /dev/snd/timer doesn't list SNDRV_TIMER_IOCTL_CREATE,
so creating a timer fails with -ENOTTY. The file returned for a timer
has no .compat_ioctl either, so SNDRV_TIMER_IOCTL_TRIGGER fails with
-ENOTTY too.

struct snd_timer_uinfo has the same layout for 32-bit and 64-bit tasks,
and SNDRV_TIMER_IOCTL_TRIGGER takes no argument, so both commands can
be passed through unchanged.

The utimer selftest doesn't catch this when built with -m32: it takes
-ENOTTY from SNDRV_TIMER_IOCTL_CREATE to mean CONFIG_SND_UTIMER=n and
skips.

Fixes: 37745918e0e7 ("ALSA: timer: Introduce virtual userspace-driven timers")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
Link: https://patch.msgid.link/20260928182352.309457-1-danishkhateeb03@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/core/timer.c        | 1 +
 sound/core/timer_compat.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 688a2d1257485..8f84055d3e53f 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2104,6 +2104,7 @@ static const struct file_operations snd_utimer_fops = {
 	.llseek		=	noop_llseek,
 	.release	=	snd_utimer_release,
 	.unlocked_ioctl	=	snd_utimer_ioctl,
+	.compat_ioctl	=	snd_utimer_ioctl,
 };
 
 static int snd_utimer_start(struct snd_timer *t)
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 4ae9eaeb5afb1..7b648edcb9cba 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -98,6 +98,7 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 	case SNDRV_TIMER_IOCTL_PAUSE:
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
+	case SNDRV_TIMER_IOCTL_CREATE:
 		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp, true);
 	case SNDRV_TIMER_IOCTL_GPARAMS32:
 		return snd_timer_user_gparams_compat(file, argp);
-- 
2.53.0

