Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794370738;
	b=kpDxyib/JPazNoUWpvSuscszKzptjwnwvhJ5jAgPNNxPc4pcZIKDxVDxRfpeESrUuG/J
	 uIAZEK7fdd6c3WnwCjOHEc2YOmuxz9MhB/Hd1fU/jUqojjA6FkXSpUaN9yrgUzVmZ3GGA
	 5ZMcco+S4rJx2kGnFrF1SKEYAcYPkQXnVeakFdiTDoWIdo5Y1c3EMkYR1jFMz+5YehCVI
	 wV2wjSehu9BPYxOw0LDfvpYjWHxEwRxzRXtdTfnD4IQmCk3EOwKKn80R0+tfdzQaQHxnq
	 8dZkOg4VAcVO2/CKP4ROfa2kKqz0oSacsV8GFuZy9AxuT45mmBRodxajLi8BxPOWJ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794370738;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Sm50SvROwggJQfW8M8Q41wiYcqS/n4vqiah6Kd3AWyk=;
	b=BnWLQAxQK2k7IhZGqa+DguUR9o3ZJyHDOYpN264GIWKZs3yLJHUPWMtZsziVV3Hx8B+Z
	 m9o8X992c0ovV4D7teFbQkqmnw74PTMTk2u7NQs9vKNjAD7EbBdJL8lswfmz5sm/0EVjZ
	 iTkEkARRJPxBrMTD646D+R9qjnJwXZk5Z7jsfI5XAxYs47DKTkpUMFkTHJU6z7pqWbRL3
	 L9yn3MOJ3Rdabop2sHD6wVR7akIKOC+JuZDeJccGZBcFiS+aojj6kvy8SZu6kplVLx+d1
	 HGGsGiwjEO3dLpqTURPglofOOan0TK0JQR6ums1hFVBriITLpxlqzJf/4MwmQTbfyqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F77606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:18:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32F77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Sm50SvROwggJQfW8M8Q41wiYcqS/n4vqia
	h6Kd3AWyk=; b=R88M0ZszFOtqVgKLZkYvl5hS5ntGffZ3O9xKU9R1S5onsMMDPt
	JtZAQ2bH4+IooqfXhXDTy65Ea9Tv0JsNyyZCaLX5Z14fGxIORmRT58SWDze3TbMb
	+/4lSuzbUxEMWkqSjocfm9G8SD5rRr2abJkMUlK4RO9DtF1l39kdhcLBM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkC2_gOt7PNqn+ZyAQ--.59405S2;
	Wed, 11 Nov 2026 12:18:53 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] ALSA: hwdep: Serialize DSP load requests
Date: Wed, 11 Nov 2026 12:18:53 +0800
Message-Id: <20261111041853.4380-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109202048-failed-5.15-aee83c204f80@kernel.org>
References: <20261109202048-failed-5.15-aee83c204f80@kernel.org>
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
X-CM-TRANSID:BLQMCkC2_gOt7PNqn+ZyAQ--.59405S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DZF1kXFyUtFyfJw4xJFb_yoW5GF4xpF
	4qkFWYkFWqqr1UCw1DJwsrWa4Fyws7CFsxGr45J3WFvr15ZF1F93sYqry2gr10kr4rCFy8
	uFyjvr1fJFy3Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7IU0nNVDUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUOD2rzM1aSBwAAss

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
(cherry picked from commit aee83c204f80d56b4d55f53acdb8594308ddcd4a)
---
 include/sound/hwdep.h | 1 +
 sound/core/hwdep.c    | 2 ++
 2 files changed, 3 insertions(+)

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
index e95fa275c..c4215f780 100644
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
@@ -377,6 +378,7 @@ int snd_hwdep_new(struct snd_card *card, char *id, int device,
 
 	init_waitqueue_head(&hwdep->open_wait);
 	mutex_init(&hwdep->open_mutex);
+	mutex_init(&hwdep->dsp_mutex);
 	hwdep->card = card;
 	hwdep->device = device;
 	if (id)
-- 
2.34.1

