Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312710;
	b=ZpULJnvnZ7bo7JYUlxVDmvoJTQOfINwETLX/18PIPrVRiDo2syYHuddpxC3L2owHWCHS
	 38t/okTVHVgqUeYWqEUbDgZcKvqmyyt7EEgHVu00F1ROwoqMGtmPByngkqYt+LgPK5BGZ
	 ODdVMOfXRZYed4SEwtUTfYv3iOBQ5bwZdLWOPIq53WaenKr1/O2Yn1r1aaS2Ca+ungQ0K
	 yO3gcvrICk6UEfjb+TH+pQnod6j8l5IcuEYF+DiqNAyfA87kyF6SQR7MVv+MB9CabCoIv
	 LYH3gDNfHJWaolrSjuen5m5MwQYZLg44/3D13mFML1d0JuCKEdgznqLKOZoY4luOTjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312710;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dxIn4jPCO6nXhE0Ee6lC28qm/NToWn0LBZ4iuEzFAl0=;
	b=S7tmaTT+C6/radBBkiyg8UETJUUlsc5EGhyj/1GXrr5yMulHpw+Md8EkcKjOMQWTp8yj
	 HDl1UNVana42I4zaBZH+QbdY8DIbC9BAkxSYPGBy1X/X5eCzC68Kt83LYgrTwB/hyGWRo
	 PAIBD0RG2c6ZwDeYZCV9If+FOs/ZO4tSqHG+FPuQyHR31Rvki2/e2PNk+75GvIdc5Wv3i
	 rAfwgLBmhwHXwaBVkC8bvKHX60W7OY68oOcnSez+qmXelX8Ki+wBNWNnVAlt7onW51wuJ
	 39hjsV8pUnIX89Hg7GRTtdHFKZGBjX9epPhlbWWH4fhCBQbzWpsdgmlTfxq7ghsY2nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2afu0ng;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B828C606A326
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2afu0ng
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D001F008A2;
	Tue, 10 Nov 2026 12:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312709;
	bh=dxIn4jPCO6nXhE0Ee6lC28qm/NToWn0LBZ4iuEzFAl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f2afu0ngVBpat+Jz8LxnGhVUi9IG0vHCGTAsnN7mcdyH1E2+BiG9/npP2HhNjvM38
	 pUqrdJ4aMW1AUksr0yrpdDsbmKIqi19EDa6o8Km6xJpEpeWyUg0M26rK3e/n8iKxfi
	 zuYrjunO2T1jZvxNFtSqPb8+LcLferw8cJbYgfijnYa9LHXDxVyReKhNCeMnvU0GAx
	 yh4HI6AuP7LDRlSQdkQNnyZCKSs4+TYS6y+StcesL3dZnVEXgGPv4xyvOU9m0g9CFw
	 XISD00Fkfg6L9iJK+1KRdbtht17JxJh8BtQN0pQhOFrXD9he0wTHR6KUkNRPWq2aIo
	 O1X7jZtwZgfzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Danish Khateeb <danishkhateeb03@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks
Date: Tue, 10 Nov 2026 07:11:46 -0500
Message-ID: <20261110121135.974482-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121135.974482-1-sashal@kernel.org>
References: <20261107050737-failed-6.18-1bbc033983b7@kernel.org>
 <20261110121135.974482-1-sashal@kernel.org>
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
index 9838cc6636427..64bffc21295d4 100644
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

