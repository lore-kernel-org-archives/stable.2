Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273650;
	b=YZWOgZL/QijyZv0xuZX6yyzYw07rUuIsjrqYtJhVByD1oB5LqQ+s5hBBlF9dWZAnw0Pg
	 nnlWwfUAFgaB8ILkuwnc5DVA8I3GhbL7OYC0sUk3RChMbVzaHt4/MTuMDMqxrezgf0Ieh
	 47zw/BUp3+G461j2kMW4xTBvFw0aDgqLEZ4PSic7oMbXBtFqjkWryVHzI1Tl526TTvRoK
	 97KvCl0oK3IFhAkqyY/Zhs1qPi4Qn4b83jr+PQ3ZdVE9ATl194U4pGzVRUujAUjx7titW
	 g57IYdg0B70052gQ7qZp7lnowrFa5m5KLj/8yPbpN3vyeDh0JZTSQMdQGfvorgl9HRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273650;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aI1ow3InK9DV+YM97OXdbmf27ErpmmqBo2acH53g9CE=;
	b=tSI2dRM4LnY8YtdwLobFzXUnKUCpuoAZxN7MDJX1SHahoorn3I85sBEjnovr7J7im408
	 z5iVWr8yf32bvh/dAMF20BP1UTCzc0/UErqRIQ/xPVLxZAo9N9XewFMPCjN9idysn9/OP
	 0BlHi4G9IvXrAdVt/OcmeXwNKc4PDOiJXpQ4O0u0TpOmYQo3X5zT5caA9T+jwOijqLILH
	 Gwxed39q5VlKZSAUmfNi070nmDAt9ObKOoELBPTJQeOONeCtHUvCaOXAgEZvc+Ul9ZBWr
	 bZF0mznsiRDE9Iecti0PV3OXJMSn8c+2Qjmo+0D5fC5HJ2eJF0/FzMB7Wu5hs7fz7Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJNVNdY7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21445606A33A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mJNVNdY7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6066F1F0089F;
	Tue, 10 Nov 2026 01:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273650;
	bh=aI1ow3InK9DV+YM97OXdbmf27ErpmmqBo2acH53g9CE=;
	h=From:To:Cc:Subject:Date;
	b=mJNVNdY7bLQYCpe4HNjotM+LpCRH65QYJAEaWfKyB6wrb1rV78FoM5r28MCSFuiRx
	 tt2gVn6MWQ3yLuoi2WgGCkggmObE8s8TvHe1zBuqOZ2YEhnakLmTaCHjl8p5NXc8te
	 WNRj4nzktURAmCc6sZ/2B0nuFPDZ2wiONVYHy1156QjUisHVso6dIn5Aa/gvv/MFqa
	 d1ZeBYKBB0OxQuDEGPTjZY7OGYp67byYflfODgoSXpC8BU+NWVrnSeFjauiPT20OV4
	 8hFpTADHvfUYefy1R5XPo/3HNqDS0YEGXxHBe6BcYbbNqvbz9nIl0BNuyT6kDoivZk
	 sXJGdR3IVsNbw==
From: Sasha Levin <sashal@kernel.org>
To: 25031212351@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	wencheng@xidian.edu.cn,
	tiwai@suse.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ALSA: hwdep: Serialize DSP load requests" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:20:48 -0500
Message-ID: <20261109202048-failed-5.15-aee83c204f80@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aee83c204f80d56b4d55f53acdb8594308ddcd4a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202048-failed-5.15-aee83c204f80@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From aee83c204f80d56b4d55f53acdb8594308ddcd4a Mon Sep 17 00:00:00 2001
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Date: Thu, 29 Oct 2026 16:48:09 +0800
Subject: [PATCH] ALSA: hwdep: Serialize DSP load requests

The check of the loaded DSP indices and the call of the driver's
dsp_load callback in snd_hwdep_dsp_load() are not serialized.  A hwdep
file descriptor can be shared among threads, or inherited across fork,
so two SNDRV_HWDEP_IOCTL_DSP_LOAD requests for the same index can both
observe the index as unloaded and enter the driver's callback
concurrently, even though the device itself is opened exclusively.

This breaks the assumption behind hw->dsp_loaded that a firmware index
is loaded only once.  For example, snd-usb-usx2y hits
WARN_ON(usx2y->as04.buffer) in usx2y_async_seq04_init() and may
allocate the US-428 sequence URBs twice.

Serialize the check, the callback invocation and the bookkeeping with a
per-hwdep mutex, so that the second request returns -EBUSY.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20261029084810.21910-2-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hwdep.h | 1 +
 sound/core/hwdep.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index b0da633184cde..7357727f06603 100644
--- a/include/sound/hwdep.h
+++ b/include/sound/hwdep.h
@@ -57,6 +57,7 @@ struct snd_hwdep {
 
 	struct mutex open_mutex;
 	int used;			/* reference counter */
+	struct mutex dsp_mutex;		/* serializes DSP load requests */
 	unsigned int dsp_loaded;	/* bit fields of loaded dsp indices */
 	unsigned int exclusive:1;	/* exclusive access mode */
 };
diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index c6de5345e946f..fb9034897c561 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -212,6 +212,7 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 		return -ENXIO;
 	if (info->index >= 32)
 		return -EINVAL;
+	guard(mutex)(&hw->dsp_mutex);
 	/* check whether the dsp was already loaded */
 	if (hw->dsp_loaded & (1u << info->index))
 		return -EBUSY;
@@ -380,6 +381,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 
 	init_waitqueue_head(&hwdep->open_wait);
 	mutex_init(&hwdep->open_mutex);
+	mutex_init(&hwdep->dsp_mutex);
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id)
-- 
2.53.0




