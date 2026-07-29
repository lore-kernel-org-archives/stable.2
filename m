Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AEC3D9678;
	Wed, 29 Jul 2026 07:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785310062; cv=none; b=kLMsbpMNBJG1Mx4SgB0f2cSs4P7QvtRmdOXz4iu/+XzEQoqsIkYOCz6S6Eq+Z1fJq/r8EjmVaTUPAdWeLUS/wQG60cdWbWy5JMs130tTPTsQSAmAr3rzMaXCmB39gzwSalsjRf0snEJkqRCuTAz1GKJ2uGjVDfSUnI89Gmt+OGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785310062; c=relaxed/simple;
	bh=u/a4KPmBlaEia+AmwHWXXSHDQQ5/I+Va9QoEwAHlZgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LUYvXyr0pZP1xMqHiwbIwrhS06GenM9oA+tkglpsqfFwDYu+XxFNtDMn8exQOyQVVpN4e8wpLDF6Usb7BbnmaMFGfnrkmIu078MJwwoJjt6QVKOiqZv9F9AynEYic0ObbTPQYVJKDpgrQA/W/iW8qcsmwfjmrUOTGhFy9goe3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wDnAH1Oq2lqafZKAA--.5394S3;
	Wed, 29 Jul 2026 15:27:11 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c5Mq2lqEM5QAw--.8290S2;
	Wed, 29 Jul 2026 15:27:09 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: mchehab@kernel.org
Cc: hverkuil+cisco@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>
Subject: [PATCH v3] media: cx231xx-audio: drain wq_trigger before audio fini
Date: Wed, 29 Jul 2026 07:26:13 +0000
Message-Id: <20260729072613.264429-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260716134846.3132097-1-fanwu01@zju.edu.cn>
References: <20260716134846.3132097-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c5Mq2lqEM5QAw--.8290S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?CJwYeQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2j3awJT+p0AFtkS3Kpp4g60yA1qECR0+kQ94zHYPgTFEpb
	z7h18OmAJ2ABOuvlOmo=
X-Coremail-Antispam: 1Uk129KBj93XoWxuFy8tFyDJFyrtF4rKrWUJrc_yoW5uw18p3
	4v9FZ8KFW7J3y2yF4DXw1xX3W5Cws7ta18CrW3XF1UJwn0yr18C3W5trWxurn5uFWxAay2
	yr1UXrWqy3yqvagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

audio_trigger() is deferred work (dev->wq_trigger) armed from
snd_cx231xx_capture_trigger() on every PCM START/STOP; it dereferences
dev->adev state and may free the URBs via cx231xx_isoc_audio_deinit().
cx231xx_audio_fini() tore down that state without draining wq_trigger,
so work armed before or racing fini ran against freed state.

Use disable_work_sync() in fini to drain the work and prevent further
queueing.  Initialize the work, lock and stream_started counter at the
top of cx231xx_audio_init(), before any fallible allocation, and clear
the partially-built audio state on its error path, so fini is safe even
if a later step fails.

This issue was found by an in-house static analysis tool.

Fixes: 61b04cb24a12 ("[media] cx231xx-audio: fix some locking issues")
Cc: stable@vger.kernel.org # v6.10+
Link: https://lore.kernel.org/r/8c7e1294-b906-4636-890c-b64d03b0e1d0@kernel.org
Assisted-by: Codex:gpt-5.6
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
Changes in v2: use disable_work_sync() instead of a teardown flag +
cancel_work_sync(), as suggested by Hans Verkuil.  The init-ordering
fix and error-path cleanup from v1 are retained.

Changes in v3: v2 was mailed with an unrelated ti/vpe diff in its body
(an internal packaging error); this version restores the intended
cx231xx-audio.c change.  The commit message and trailers are unchanged
from v2.
---
 drivers/media/usb/cx231xx/cx231xx-audio.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/media/usb/cx231xx/cx231xx-audio.c b/drivers/media/usb/cx231xx/cx231xx-audio.c
index 9c71b32552df..1179cb0334f4 100644
--- a/drivers/media/usb/cx231xx/cx231xx-audio.c
+++ b/drivers/media/usb/cx231xx/cx231xx-audio.c
@@ -576,12 +576,19 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	dev_dbg(dev->dev,
 		"probing for cx231xx non standard usbaudio\n");
 
+	/*
+	 * Extension init errors are ignored by the cx231xx core, so fini()
+	 * must be safe even if initialization fails part way through.
+	 */
+	spin_lock_init(&adev->slock);
+	INIT_WORK(&dev->wq_trigger, audio_trigger);
+	atomic_set(&dev->stream_started, 0);
+
 	err = snd_card_new(dev->dev, index[devnr], "Cx231xx Audio",
 			   THIS_MODULE, 0, &card);
 	if (err < 0)
 		return err;
 
-	spin_lock_init(&adev->slock);
 	err = snd_pcm_new(card, "Cx231xx Audio", 0, 0, 1, &pcm);
 	if (err < 0)
 		goto err_free_card;
@@ -596,8 +603,6 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 	strscpy(card->shortname, "Cx231xx Audio", sizeof(card->shortname));
 	strscpy(card->longname, "Conexant cx231xx Audio", sizeof(card->longname));
 
-	INIT_WORK(&dev->wq_trigger, audio_trigger);
-
 	err = snd_card_register(card);
 	if (err < 0)
 		goto err_free_card;
@@ -651,8 +656,10 @@ static int cx231xx_audio_init(struct cx231xx *dev)
 
 err_free_pkt_size:
 	kfree(adev->alt_max_pkt_size);
+	adev->alt_max_pkt_size = NULL;
 err_free_card:
 	snd_card_free(card);
+	adev->sndcard = NULL;
 
 	return err;
 }
@@ -669,6 +676,8 @@ static int cx231xx_audio_fini(struct cx231xx *dev)
 		return 0;
 	}
 
+	disable_work_sync(&dev->wq_trigger);
+
 	if (dev->adev.sndcard) {
 		snd_card_free_when_closed(dev->adev.sndcard);
 		kfree(dev->adev.alt_max_pkt_size);
-- 
2.34.1

