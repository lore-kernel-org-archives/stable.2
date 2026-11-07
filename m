Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046059;
	b=SIgrw9v1ge2V+B/2yhNtDI6WLCYquube+I7ZkbqVatGb+phnKudAzdXdN66UnwQF7rHy
	 qW03Pwm3H3cZFKL6RaPqIBrcDuX/ias0uatExm6dz6iatiLyGBUAvofbnD49jvvq+dgWW
	 Kb3kvMBrrsoigJtQ3SScnKcXjLStkmz9uzWcYaNGeigD9bIrZLzjYBxh389lFkVRB8m5F
	 2XcPzp49jL+dvwThzC3eJ9zsmDDDYqIVZfqVQpDTIN5mMM9/aTomCMmCTyG4F4r0aX7/N
	 pp+ANSitJHSinPyytES5O7Nfi3948k2Fk8SNEQoL5j5WB/fFaD569vG48HoimOe1VkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046059;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=j7AqQ8zqPtmmZmbuZI6P6iCiew5dq1RaZRKqBKibKgU=;
	b=j985XgH7Twoe5X8Qw5pTokxTAqywkeyBzMnDzCIfQrCI1Dbq8ZIBDdaR7IG2Tu6R20t3
	 k2e6rjH7yw6oqUNgsqW8iWxC3ivWkU7Jg03nLhZu3IbpXKXEXMHAZZ2xEfJa/pkAGCGWb
	 JGFH4YvdhmEORJZrLMEdELClcah69/RGUglSHS+S/lWhtEQHn1c79uVGBHnI1PodgON/0
	 Ja3SEel2G33cLXs+dwcZFe8CNOc7b+ZiSLZ3ZP0LEN90ANDFafa+cRoRBhcgj238ZB5t+
	 BfsbnizPGUaLKlX5EThlqZ8IMe2R9v3VuiRUmUsUpfbuH8roQpG6qDnaITLyeFSBG7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYolRDBl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3677606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RYolRDBl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629F81F0089F;
	Sat,  7 Nov 2026 10:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046058;
	bh=j7AqQ8zqPtmmZmbuZI6P6iCiew5dq1RaZRKqBKibKgU=;
	h=From:To:Cc:Subject:Date;
	b=RYolRDBl5Fgy/3GEQhhEQwDV98cgkjmXKy/lHMNkU4SRn0Ga6ZT2F9724iG0GkC84
	 /X6qfGrKrHNTWjO2vlmBF7LvVBxHXuhKEiSaEH2lofMtQxEDnW5lLlA6N7G70FqDXk
	 zXtas0YaEgB8pf9uAg0TcCLSfUNUw7wv6ptyrMIitAD4aeBHBg5Eb3H2C9oCl+3dEo
	 /YZKqctbXMpHwkhfvoynkUiRVOnMCaVo9r5VxCnbd/cb76e/Py6kirfAMe4GZDBB2p
	 REPdJgcWkWpen5DnETetZMQPqjso0Bnz9rQMM5ijnePUfvutChsFrNV6e/xAXVX0sv
	 ulZh5B5ts4Olg==
From: Sasha Levin <sashal@kernel.org>
To: danishkhateeb03@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:37 -0500
Message-ID: <20261107050737-failed-6.18-1bbc033983b7@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 1bbc033983b76f41d51d4a48838bf94c5e6b6f50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050737-failed-6.18-1bbc033983b7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1bbc033983b76f41d51d4a48838bf94c5e6b6f50 Mon Sep 17 00:00:00 2001
From: Danish Khateeb <danishkhateeb03@gmail.com>
Date: Mon, 28 Sep 2026 13:23:52 -0500
Subject: [PATCH] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit
 tasks

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
---
 sound/core/timer.c        | 1 +
 sound/core/timer_compat.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 679b264356709..69a59b25fe0a8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2176,6 +2176,7 @@ static const struct file_operations snd_utimer_fops = {
 	.llseek		=	noop_llseek,
 	.release	=	snd_utimer_release,
 	.unlocked_ioctl	=	snd_utimer_ioctl,
+	.compat_ioctl	=	snd_utimer_ioctl,
 };
 
 static int snd_utimer_start(struct snd_timer *t)
diff --git a/sound/core/timer_compat.c b/sound/core/timer_compat.c
index 25ee81c1668b7..5bab00466de7f 100644
--- a/sound/core/timer_compat.c
+++ b/sound/core/timer_compat.c
@@ -99,6 +99,7 @@ static long __snd_timer_user_ioctl_compat(struct file *file, unsigned int cmd,
 	case SNDRV_TIMER_IOCTL_PAUSE:
 	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
 	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
+	case SNDRV_TIMER_IOCTL_CREATE:
 		return __snd_timer_user_ioctl(file, cmd, (unsigned long)argp, true);
 	case SNDRV_TIMER_IOCTL_GPARAMS32:
 		return snd_timer_user_gparams_compat(file, argp);
-- 
2.53.0




