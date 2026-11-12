Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447600;
	b=AHV4gtbXYXsnEvKqWKKAjT8EF7BzBMOaD9xocx6vHezovfYoQibKYV3hgTs6tBJNl0q9
	 cJm407Qf80jGUw58zgAiNNEyuB0KGexyY9U267XESwZVHfi0YkSuKzZaNUiVoxwkgZVOS
	 4GDQix9VvSW5dhkN4jNQWlu6eZs1b3/BtCHrOB2gB249zRbtwb+xtGh2IMThop3zTMGCH
	 oK0zkWotCl/10pQNCniTFMBkVR6d8BhRboDZ8q5COSY0yZJaSEsdjvhq5AUMOYQD8lKZg
	 OsNEHJX/UX7BpDIYTCjZHq9aHgZbm+wh1pXzwtfSU/hq41D5DsFTeiW4+ei1h2cDnMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447600;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=CB/gSskTR9wvWmmWPupPceXVVxOUepJZ/LaXi7EL3Xk=;
	b=USgoRSbiURqChHi7cfhPPQHyTb7M9XuLilWntt85B/mqe4ZM7Q/FhRgFrnBHtzPUqJB6
	 lTjNtd4+J7eDEQwnlQykYRMaSe+3HA0SKc0TwsG7bn1GjxUhrtqBIGBzqs9feA53BREYU
	 Z6HPasKIAz6ivOY6uTWXzQB2gwUewuMrr6skE9jtuEHplzv8e9DBG3Y+TbLpiqKvmsLOW
	 hb5RSbttSh6CAqcHKbhv4fSnkZRVj7MkocMOiUt5F6mSyu2wQeHAt2zDTJ+ANDYujCtBX
	 SGfvceHNkfTcoEViWpu28fUP9vNbqftI9HvhHc8DbJlt/r7N9lN/I0Z46FT67V6erng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB868606A324
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB868606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=CB/gSskTR9wvWmmWPupPceXVVxOUepJZ/L
	aXi7EL3Xk=; b=UBH+ZRibXJXJOPSozUCF6duO/HqjgrDNXRguy5t7jODvH7pIuu
	KFt0xGeNuDGsFfdZVcrCL0PyJsS+gMSVn4VxyRzSoO5yHJ50ZIohUesPGi40QrDv
	tpIG7TeXyLPJVD2YDjTFpBtlBVHIyr2MzQNDYzPL13DNlwcOzU1pI0Hww=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGif7oGPVqa5eAAQ--.28680S2;
	Thu, 12 Nov 2026 09:39:52 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y v2] ALSA: hwdep: Serialize DSP load requests
Date: Thu, 12 Nov 2026 09:39:52 +0800
Message-Id: <20261112013952.8019-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2026-11-11-1-daily-reply-0025-7d3aa7a83ebfc4bfd8b3@kernel.org>
References: <2026-11-11-1-daily-reply-0025-7d3aa7a83ebfc4bfd8b3@kernel.org>
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
X-CM-TRANSID:BLQMCkBGif7oGPVqa5eAAQ--.28680S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DZF17Gr1UCw4kZw4UXFb_yoW5Zr1xpF
	4qkFWYkFyDtrnrCwn8JwsrWa4Yyws7GFsxGw45J3WFvr15ZF4093sYqFy7WryFkr4rCFyF
	9FyUZF1rJFy5Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	JVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvj
	xU2Pl1UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUPD2r0h0ZMggABsX

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

5.10 and 5.15 still build with -std=gnu89, so guard() cannot be used
after the early returns of this function.  Take the mutex explicitly
and release it on every exit path instead.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Link: https://patch.msgid.link/20261029084810.21910-2-25031212351@stu.xidian.edu.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
(cherry picked from commit aee83c204f80d56b4d55f53acdb8594308ddcd4a)
---
 include/sound/hwdep.h |  1 +
 sound/core/hwdep.c    | 14 ++++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index 8d6cdb254..137be4b40 100644
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
index e95fa275c..f7cde6bb8 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -212,14 +212,19 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
 		return -ENXIO;
 	if (info->index >= 32)
 		return -EINVAL;
+	mutex_lock(&hw->dsp_mutex);
 	/* check whether the dsp was already loaded */
-	if (hw->dsp_loaded & (1u << info->index))
-		return -EBUSY;
+	if (hw->dsp_loaded & (1u << info->index)) {
+		err = -EBUSY;
+		goto unlock;
+	}
 	err = hw->ops.dsp_load(hw, info);
 	if (err < 0)
-		return err;
+		goto unlock;
 	hw->dsp_loaded |= (1u << info->index);
-	return 0;
+unlock:
+	mutex_unlock(&hw->dsp_mutex);
+	return err;
 }
 
 static int snd_hwdep_dsp_load_user(struct snd_hwdep *hw,
@@ -377,6 +382,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 
 	init_waitqueue_head(&hwdep->open_wait);
 	mutex_init(&hwdep->open_mutex);
+	mutex_init(&hwdep->dsp_mutex);
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id)
-- 
2.34.1

