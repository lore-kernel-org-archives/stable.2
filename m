Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263710;
	b=ZG/YX8g2Pz9Qa3W7sR2js4a30ZBqPuZsFu61UKLr63a/yjvYZba3nx1GFNHgONUHwIf4
	 8GVEFZh4RzG6IhfMicH1+H80HBOAL4UB0SBRuQMNSOmDuVTTCwwvjIRJyWA1xxB9xLwHc
	 8VFvLbCP54WZz4gbBzQVkFVKezADF98+uxmN0/0LM3nEIdXfwG7EdK30mctZUPtr+K93Y
	 vUKh28BHbM3t0fAABOo48zHiOHPNZA/ag/geV+OhVS22WUZckcLezaudz8YoRtDE+XUce
	 M4ZBArqbSbsipSuMLlsKDsHedXjq9N+QaQx3zP+GcPdU3V2rM03DbK/FwHYH/bCqCRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263710;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=9YHy2jluue061+9f1QnvmhvqOkv6/lLP8VsJqdtmZoc=;
	b=urFNsO0SkGL6SDYvyxzNKQwOoi6hHwiB5je2vLtvk4GbP4ZsPOq3Fb4PW6W0dDYwoi+p
	 q75ZkJFSy9KEajB/QPfRXxYDD3Nqs/+oeN56K8xrMDZzb4PlKOAGXowkMxiNVmiswts1S
	 JvTl4DCLLZX2kehqigE4uh1rSsDBnx8U8WWYHGLkkN8cywFVupI0BNSG+/txXQiwbQjLt
	 jZbhuYjqVq05BoRXtPMDMPaqL0x1EIR4eYWsxARG7q37dGYHvH9LODzV/2Xqh2PF7epOd
	 knywl40SMiA9J5aEtBmWbe9wDHMrlUgdf35gtPqg/Wd5DLcgEf90j15gop2heMLH2eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB9606A31C;
	Thu, 29 Oct 2026 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBB9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=9YHy2jluue061+9f1QnvmhvqOkv6/lLP8V
	sJqdtmZoc=; b=JWlplOO1VjxY8+uyAUycIupOfBmmB3MKxs0G2k6jaogUfibcfF
	sceOAllGGn4g27Q9+tpgkFTzyXhwG/z0NPNMxEYlhpMynceIxgoKQDuqNC+OBfzy
	ThkHAOqEuLyBRsEVfkWI9+2gJmL79vGHHasCdxDE2pUrwFizEwk9g/irg=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAmKv1KCONq6jz8AA--.61740S3;
	Thu, 29 Oct 2026 16:48:20 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] ALSA: hwdep: Serialize DSP load requests
Date: Thu, 29 Oct 2026 16:48:09 +0800
Message-Id: <20261029084810.21910-2-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
References: <20261029084810.21910-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkAmKv1KCONq6jz8AA--.61740S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw48Gr4xKF4kGFykJFWfuFg_yoW8Kw18pF
	4qkFWYkFyDKrs8Cw1DJanrWFyFyws7CFsxGr45J3W0yr15ZF1F93sYqFyUuryFkr4rCFy8
	uFy0vF1rJFW3Jw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0E
	x4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
	0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUxD73UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2riEkGQPAAAs+

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
---
 include/sound/hwdep.h | 1 +
 sound/core/hwdep.c    | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/sound/hwdep.h b/include/sound/hwdep.h
index b0da633184cd..7357727f0660 100644
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
index c6de5345e946..fb9034897c56 100644
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
2.34.1

