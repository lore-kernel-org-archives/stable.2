Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367439;
	b=bNZYj85g1bsqNZpBb3ltOYSYjH+vJg/JygwgNrTgKgBLhbn0SZPlD76KpukOPIh7vPn0
	 09QqEuMl3ShjTnkbdEcBuTBSjxWm5ar5pk9sHTYGn0mAG5Le5kHZ7u+6RLPJHESM0/sQT
	 E1CBf4571CZ6syWVTiUqLhD1Gf537ZdHSqRDR6PYnjmHLHDduugN27f/dTGAvsDwFpBS2
	 3n4noB/iZIiNTr5MVJmkHwQOfiyf8k6d84SYQPeKOP/j9VPbSNYNzoR2E4JQ0m5U95c2O
	 0KLCbozb7TQ7aXC6Wb/D/jg/aGQRAk6s1bdf0J8qZ4uPpJ7JtaP/bb1GiBvkfPzb74w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367439;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=t6vNfQ8SI2LqTx1rlc7rYaZCkpTPoetYSICm3Sca440=;
	b=26WBBQdna5CUdRnM9xkGtEfaWLh321NKM30izbIiXBNzwpFBszjrnbnqh13OZ6O2BaPw
	 jbJZjMW71IdswH8Ht+H1K7QZEAtyUNEksrffaIK83v2uGjIgpCiOM0L6gUl1etVybNcqw
	 24dXgKl0/QCmlAY47nXpd28PKanX5o4R3HnD2ihv+tGN5AYkPbcYc6CbpzhtaHpQB7ReA
	 vRPKJcnOIyRb0pCMUKMzP1kTjh2QwQeoLV/vaLNJ/2xXewK0cCITi5dXk7n9xzg3z9vzS
	 NX4kN2c1cC/f6Usam3ov5clEWMwHRAJHpOp3FdfN0qKmAGZi+s5uZvnfH8SHMYnflyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2204606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:23:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2204606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=t6vNfQ8SI2LqTx1rlc7rYaZCkpTPoetYSI
	Cm3Sca440=; b=5Wjulw7672QBSVoKO7GWVqrAl1tzbXU6+mLzOJfSc+op6UUYNu
	bMYAMlkBWwaey83ZSHpFksim8LvJfDDX3PIAeh0ef8OnKa14THkeMr2hgHFdO8mf
	1TfFq/8t5B2HJoMy9yrCo7LCe+7x2UT4NABpRDoVaVY/aP5gfrMZvIoKE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2WgC43_Nqjj1yAQ--.12932S2;
	Wed, 11 Nov 2026 11:23:38 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y] ALSA: usx2y: Refuse a retried DSP load after a failure
Date: Wed, 11 Nov 2026 11:23:36 +0800
Message-Id: <20261111032336.8545-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109202907-failed-5.10-1f8101b6adc8@kernel.org>
References: <20261109202907-failed-5.10-1f8101b6adc8@kernel.org>
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
X-CM-TRANSID:BrQMCkA2WgC43_Nqjj1yAQ--.12932S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UAr13Kw15tr43ZFWrXwb_yoW5Jw47p3
	9xuFWDtrWqqw4q9a1DXw4qk3W09rs0yFW3J3sYyw48Ar1DAFyfCrWFgw12gF42yrWrAa40
	qFZFgr1UWFW5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkvb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1j6r15MIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07bOPEhUUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUOD2rzM1Z-AQABsG

snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
the interrupt URB when the FPGA firmware image with index 1 is loaded,
and then creates the ALSA devices.  If usx2y_in04_init() or
usx2y_create_alsa_devices() fails, the URBs that were already set up
are left in place.

The core keeps the index unloaded when the callback fails, so user
space may issue the same request again.  The second attempt then enters
usx2y_async_seq04_init() or usx2y_in04_init() with the URBs still
allocated and trips WARN_ON(usx2y->as04.buffer) or
WARN_ON(usx2y->in04_urb).

The URBs cannot be released at this point: the card may already have
registered PCM devices that user space can still open, and the
disconnect handler accesses the URBs without holding the DSP lock.
Mark the chip as hung instead, so that a retried request is refused
with -ENODEV and the assertions keep their meaning.  The URBs are
released by snd_usx2y_card_private_free() when the card is freed.

A failing usx2y_async_seq04_init() still releases its own URBs, so that
path remains retryable.

In 5.10 a failure of usx2y_create_alsa_devices() frees the card, so
there is no retry to refuse on that path and only usx2y_in04_init() is
marked as hung here.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
(cherry picked from commit 1f8101b6adc87a3ddbd51fcb6609251591758026)
---
 sound/usb/usx2y/usX2Yhwdep.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index eeafe580d..50c03e6cd 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -193,6 +193,9 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 	int lret, err;
 	char *buf;
 
+	if (priv->chip_status & USX2Y_STAT_CHIP_HUP)
+		return -ENODEV;
+
 	snd_printdd("dsp_load %s\n", dsp->name);
 
 	buf = memdup_user(dsp->image, dsp->length);
@@ -217,6 +220,7 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_in04_init(priv);
 		if (err) {
 			snd_printk(KERN_ERR "usx2y_in04_init error\n");
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		err = usx2y_create_alsa_devices(hw->card);
-- 
2.34.1

