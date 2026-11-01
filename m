Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793521846;
	b=lrxiVfSc/GCYpe2yl/LkU0r8/w40B9vyQzWsPQUzY/KK3KptWhDaq4YwKL6US+qITSq6
	 pybFtV+Ua5PUfnaw0Fj54v9qe/7fKpoNiSiPYjFDel/IdjwiT6xcV2xP1erbu//zeYYLL
	 IxeeRSCVB+dB/apAZJDyP3y4cc9fVHuCj2LCmrviSykvEYKSJSFmyLgfXU/HH7xvfflHY
	 MaH5H891fi4rdbjP+9NSrCwJbLcZkbeYsJtZQi6ZoNDfuLAHnhQC3oKN+fl17Hu38DHgM
	 DIqLhn+sm2s8Fxue73+WpRqu9I5sFh4Duhr128ahqZmF/yVsLQpIlALbOZcqFoac+tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793521846;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=F1c0HdyTRLsIzAFM0JN0P2R0UNqNGHuzxSki4WI7BSA=;
	b=JZqtHLGRbKT4tIug7kkreF3/t49jJCTes/+PXapRHTwqrj1j0QL+Hk6aqThsx1JmZ6jV
	 fWb41hi6Cy7nm9E8ywcjD8IpbWuV0aXIBsCmsHCDfZe7rwNDfFUAXqDD6Pqd6KPuCecPM
	 P21bjar+vULyUji+hUmiosxo6GqqM+uT45+3+GSFYmIYVWWxDaGNXlfQNl9FdEDPvFCBA
	 eRhK/ECTiwjzsaVul/bIfDbTFkqjSuJcdmIU+QKHloCSvSNmZuKoJS3g8Kko8or4XXeAq
	 tXG1rE4zguzZCtGV4SeHOys6J/f2MPECQMI9mMGOKSvSFpW35TIL1V0RbLz7/qraY3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA0606A324;
	Sun,  1 Nov 2026 08:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1ADA0606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=F1c0HdyTRL
	sIzAFM0JN0P2R0UNqNGHuzxSki4WI7BSA=; b=UX662lZ+7MwRvSaGww0JuA9nJB
	FIdNOBqggcOjuaXQ1cussJg78SsSj1mzh+W1/KA44SIL0s23hAKo8VKi6eNL8sMZ
	9UNQLPkqg2xBS2PSS0VTez9aKVTzUPVHO2nhChrcawXLE4bZ1+CGtUMZuUNQo3iC
	OrLNsnK808bi117aQ=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.23])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkAWWwCp+OZq3eMUAQ--.23366S2;
	Sun, 01 Nov 2026 16:30:34 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Hans Verkuil <hverkuil+cisco@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] media: usbtv: fix use-after-free on device disconnect
Date: Sun,  1 Nov 2026 16:30:32 +0800
Message-Id: <20261101083032.14459-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BLQMCkAWWwCp+OZq3eMUAQ--.23366S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1fAF18CFyUtry3CrWkCrg_yoW5AFW8pa
	yrGFWj9a4DGw4DKa1DZw48WrWfCws2yFy5CrW5Za4DCws3AayfAry0yFyDurnYka4rAa4U
	ZFyjgw12qayYgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8E4EtUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2rmBFRXBAABsB

usbtv_audio_init() passes the USB interface as the owning device of the
ALSA card with snd_card_set_dev():

	rv = snd_card_new(&usbtv->udev->dev, ...);
	...
	snd_card_set_dev(card, usbtv->dev);

snd_card_set_dev() is a plain pointer assignment. It replaces the device
that snd_card_new() took a reference on, the USB device, with the
interface device, without taking a reference on the latter, and the
reference on the USB device is leaked. snd_card_do_free() still puts
card->dev at the end, so the card drops a reference it never owned.

usbtv_audio_free() releases the card with snd_card_free_when_closed(), so
the card outlives the disconnect as long as user space keeps a sound
device open. On the USB side, usb_disable_device() drops the last
reference to the interface right after the driver has been unbound.
Closing the last sound file descriptor then runs release_card_device()
and snd_card_do_free(), and put_device(card->dev) is called on the
already freed struct usb_interface:

	Read of size 1 at addr ffff8881024a008c
	...
	kobject_put
	put_device
	snd_card_do_free
	release_card_device
	device_release
	kobject_cleanup
	kobject_release
	kobject_put
	snd_card_file_remove
	snd_ctl_release
	__fput

Pass the interface device as the parent to snd_card_new() instead. The
reference taken by snd_card_init() and the one dropped by
snd_card_do_free() are then balanced, and the card keeps the interface
alive until the card itself is released. This also fixes the leaked
reference on the USB device. The sysfs location of the card and the
device name used in messages stay the same.

Fixes: 63ddf68de52e ("[media] usbtv: add audio support")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/media/usb/usbtv/usbtv-audio.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/usb/usbtv/usbtv-audio.c b/drivers/media/usb/usbtv/usbtv-audio.c
index ae0a14e5ed2a..6bdb64051cf2 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -333,7 +333,7 @@ int usbtv_audio_init(struct usbtv *usbtv)
 	INIT_WORK(&usbtv->snd_trigger, snd_usbtv_trigger);
 	atomic_set(&usbtv->snd_stream, 0);
 
-	rv = snd_card_new(&usbtv->udev->dev, SNDRV_DEFAULT_IDX1, "usbtv",
+	rv = snd_card_new(usbtv->dev, SNDRV_DEFAULT_IDX1, "usbtv",
 		THIS_MODULE, 0, &card);
 	if (rv < 0)
 		return rv;
@@ -348,8 +348,6 @@ int usbtv_audio_init(struct usbtv *usbtv)
 		"USBTV Audio at bus %d device %d", usbtv->udev->bus->busnum,
 		usbtv->udev->devnum);
 
-	snd_card_set_dev(card, usbtv->dev);
-
 	usbtv->snd = card;
 
 	rv = snd_pcm_new(card, "USBTV Audio", 0, 0, 1, &pcm);
-- 
2.34.1

