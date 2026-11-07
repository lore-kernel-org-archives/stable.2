Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046688;
	b=M8faquTd0zQMLIwGcO/cujGWzvOhDEncpoLoqIm49kkZ4WIyu1ZnjsDYHUOFBj+i38SR
	 agj5VBRAgeZWklurkZY7ZyQJ+7aIkgBILjQllSxrO91UbPBr7DFFE9Gb9FQ9pWdfOfE7L
	 d/3fbbYn5TWp/ClnutI9NNWHI5LPXYKQGfpMp53wXr27RNWIlt5RcMB75TU/aSvAo8YO9
	 ZORMz/S54mvBsGxjrwiG8FkEJwcPPuvD9hZc9d3YCZi7COcnLtqEoHoKUyb+RtPOx+f/a
	 d13Z1fLYNXpLOSgFvGtAF/6+hJS5dVPmgGlcuuoeJoB/S7ft6VxAYaF6qxbo5YLi56Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046688;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Y703BgFTnkahWJQWqZDGin8Q9pTFBePeQ51pLD4r73k=;
	b=kXftXuRaUE/qHv7PwbvylVOl0LotoBag0v+i0vVqY6lxOZ83w3OB2Tp7XwZphoB9Aar1
	 gcoJ7+rmOUHEdVP1e4sYYBuayEEorppN8j2tzhuJExtkTYRAh82+Mfa8cGUU0y1PapKEY
	 Mxh62jV98H/wLlS4ek8yQtxfCqAiLUx0C5kx/NXd8d7QteLff3bKpibgf35v9PVvm/FwM
	 4doJEZ+Tyjtbuyz2Kj2nBr4xYG/mFT95mtPGcHJcbdcOvKCN2sFzGSvSnCcNfC2lwrhHQ
	 jCVLvHLu579x5rYph1ukvlR6NU49EhYmLA/qp8F4r41syU6LnHeryvsAJVfuIGt2RBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqG4ciKJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4233B606A330
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqG4ciKJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BB01F0089F;
	Sat,  7 Nov 2026 10:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046688;
	bh=Y703BgFTnkahWJQWqZDGin8Q9pTFBePeQ51pLD4r73k=;
	h=From:To:Cc:Subject:Date;
	b=EqG4ciKJudthPpH0AFJcdgF+rxLARHmtrlW5Gq7/3369R6IpMIPLJvNSkgZye58Bo
	 sHKs/6LNYg3ukblkUZGJprR5KgcxnqfW6xl0t5bz9/rzGB/OCCC1LZfpdkM9ghTT7w
	 sBjJe7hgvfnxqL3SOnO6+QPmxP+OViWRJZval6VCBSTIzk+Tgs1vf7co8L+UyxJinS
	 TP53+mhaQ1swS2Q2jHYn3HCaS5BbhI1f1rv25VM3/0XI20qNrTpKGv3X7P4+hJdXLH
	 SEaPaqce0AEG9UkWF2eaiV5oZgmLmcsrx8+IvXXvno59zCJxMkItcTCWMCfj6U2B0z
	 B4O24z2XO1U1A==
From: Sasha Levin <sashal@kernel.org>
To: danishkhateeb03@gmail.com,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: timer: Handle userspace-driven timer ioctls from 32-bit tasks" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:06 -0500
Message-ID: <20261107051806-failed-6.12-1bbc033983b7@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1bbc033983b76f41d51d4a48838bf94c5e6b6f50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051806-failed-6.12-1bbc033983b7@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




