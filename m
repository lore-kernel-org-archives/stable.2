Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794447600;
	b=IVFFeOevL4vJ4N2loPCQjxGwAfHbAbJgvPg32KwmRYN4xVKnCWfmtrZ705Wqddws9sWs
	 LEUWkNat6nDDKFaKR5SPRzLl1PbzC73lXW//khoXR6/SP70c8UStqFE149vjdnKO1tzvs
	 bC9AIoJC1q0XEo0O9KiU2H325EaL9gkUyaoG7V9VXyLaKpPo60lOBhsXSXKPE3vNcHMaG
	 1k//btzn9Su1FAPqXgb900BSeW9AVvcY7yOHoUd0jIAAL5sGpV5H6O7FAwQlQtcLIwFmD
	 3m3HYTAN82d6gtdHMEkP93jXVzsri7YkMQ8WcEUoW0/v1DjlcuuySQ63/wOzt3MBNcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794447600;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=NkplOxGSGDrMxpav0jmy0t5ZzlMZyF9ymrW0nd1yEqA=;
	b=BfTTsNqptoSloGdajQZTCUEGZIjD2gqfPI8N7kaid0nz608+T+A2C+TWtY7arSnHAkCK
	 5qgM76unwu+939SDelX+8si45NPQayqBSLNyU2vvSxaeD7cNle92YzKI0S8vrwFVddrj2
	 chGtAegTCxFFdIcNaxAOPmu4l4bCr+yzBExiB1FaSKlwAVcMvegXqpXzjP9DhKt7eAO21
	 1fb4idS1SUZvdWcdkKos2jhiO7ixCMAksqRDEoOnvMI64L9ps7vJWrazG84efY5ZL1jMH
	 Y3UkW3oLIZsT3tJ6rHLxtwTDiho6ysNCNx1jhFcKBP/HRCE4wDvvzjQlKiEUhJMndQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7D4606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB7D4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=NkplOxGSGDrMxpav0jmy0t5ZzlMZyF9ymr
	W0nd1yEqA=; b=jcVXs7IeTGw1t/a3D1jjto1Af93Ry1IJEXMYfmK7AV7G6m0X6g
	oCuu6RIl4aRqsMyfc4gJmGD7Hvh9LfU8LWQWlFL2GoAkmnjBTKsuMvOmKPwFvm+O
	DmYXRoHLsO1E6igXaJYhYtWYBPYaBBC8KtM+8cEmfJvYXSGjGg8NCTULU=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkC21PreGPVq5LOAAQ--.22760S2;
	Thu, 12 Nov 2026 09:39:43 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y v2] ALSA: hwdep: Serialize DSP load requests
Date: Thu, 12 Nov 2026 09:39:41 +0800
Message-Id: <20261112013941.8004-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkC21PreGPVq5LOAAQ--.22760S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DZF17Gr1UCw4kZw4UXFb_yoW5Zr1xpF
	4qkFWYkFyDtrnrCw1DAwsrWFyYyws7GFnxGw45J3WFvr15ZF4F93sYqFy7uryFkr4rCFyF
	9FyjvF1rJFy5Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUJVWUXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpnQUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUPD2r0h0ZMggAAsW

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
index 0c0298928..2862cbe75 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -211,14 +211,19 @@ static int snd_hwdep_dsp_load(struct snd_hwdep *hw,
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
@@ -376,6 +381,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 
 	init_waitqueue_head(&hwdep->open_wait);
 	mutex_init(&hwdep->open_mutex);
+	mutex_init(&hwdep->dsp_mutex);
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id)
-- 
2.34.1

