Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368060;
	b=nkH43XVg5Xh4YOn2jYuW62xqczlX6qxUKNKnLpBZb3UP31A9Y34famwFWLkW6H420Eq5
	 cdZ4bfVhbUj+5YAzRY9qwk95y95D1CSUsG2JJ8cWjHwyVJAi7lw4gBemI3ys24s3ZpSqD
	 xRlsz7H8xMJ1I0lovZrYBdpGpkiKlJoF3jWuiznII5pVvI095HO3W3xjC2HSJaFLis0Kt
	 0lIGtqI5ybIDrvSt5/wPw6hmpzcISWo7bkKTeU6nDOMFQj7dMjbzL/+Tg8pBMAGSx3UHd
	 Exva5fKTviIUbKYZpbaayd9Fc3eXkYllMweKLN4kVkEWdSVQknhq/0wl7Je+pxrPNlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368060;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=V+M/f6mVh6jxfTVe/Ebx6CPlmmG/gPSQ6YtXy0KYSZo=;
	b=MGsWW2X3ZKzbje15rc/MCgk5UOG4BozUmpR2nA8BVfQMN8/q2x77Dcse7+K3hGolY72z
	 aiAvJ0z+r47YS2gMQFhq0wp7pj9CDQ1J1rDypCFe3BQMz/SqpLqzxbCX7XU3+CuvAFKZ9
	 ubzGg689IxyPIs4RLdR56yqnzNqt49af0xKkBKomqNJre5xsFM9vt6SIT6JMbHykwIIwX
	 2+/fYOjgrIY7cn5HprRznzEZLS8308togL6fHcy6pL8p/L3CDdjJ3ahMjWJEEH/zpYdBY
	 dGzIFsbtJtpMQKnNRN5qopaCzbURKMtwBmMeeO8AL3v0Q+IyQLnz4KJqQw9nrThsJZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED57606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:34:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ED57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=V+M/f6mVh6jxfTVe/Ebx6CPlmmG/gPSQ6Y
	tXy0KYSZo=; b=ghOsuyHcs27TUJ2wUN9Ay6xydtU2uPInxQ1Ar7kFFVygQTdHfG
	IsXVVNX1nDF1HuMvFvskZft2dGm3ZHfj4aCPCvh+yNdTUHw3GD+5MWNjJs4EyRee
	6GfFF+Uu0hLx1Mjw0ty9rFcZJqCI+pyRDJifohRiAny8L6CsvCIFjSchM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.33])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBGSv004vNqt9JxAQ--.43297S2;
	Wed, 11 Nov 2026 11:34:13 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y] ALSA: usx2y: Refuse a retried DSP load after a failure
Date: Wed, 11 Nov 2026 11:34:12 +0800
Message-Id: <20261111033412.14904-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109201942-failed-6.1-1f8101b6adc8@kernel.org>
References: <20261109201942-failed-6.1-1f8101b6adc8@kernel.org>
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
X-CM-TRANSID:BbQMCkBGSv004vNqt9JxAQ--.43297S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAr1UAr13Kw15tr43ZFWrXwb_yoW5Gry7p3
	909rWDtrWDJw4qga1DXwsFk3WFywsYyFW3JrZYyw18Ar1DAFyfCryFgw129r42yrW8A34F
	qFW2qr1UGFW5Cw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r
	17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUJVWUXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyT
	uYvjxUyBbkUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUOD2rzNcaE+gAAsS

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

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
(cherry picked from commit 1f8101b6adc87a3ddbd51fcb6609251591758026)
---
 sound/usb/usx2y/usX2Yhwdep.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/usb/usx2y/usX2Yhwdep.c b/sound/usb/usx2y/usX2Yhwdep.c
index c0293af44..89c7ff597 100644
--- a/sound/usb/usx2y/usX2Yhwdep.c
+++ b/sound/usb/usx2y/usX2Yhwdep.c
@@ -185,6 +185,9 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 	int lret, err;
 	char *buf;
 
+	if (priv->chip_status & USX2Y_STAT_CHIP_HUP)
+		return -ENODEV;
+
 	snd_printdd("dsp_load %s\n", dsp->name);
 
 	buf = memdup_user(dsp->image, dsp->length);
@@ -209,11 +212,13 @@ static int snd_usx2y_hwdep_dsp_load(struct snd_hwdep *hw,
 		err = usx2y_in04_init(priv);
 		if (err) {
 			snd_printk(KERN_ERR "usx2y_in04_init error\n");
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		err = usx2y_create_alsa_devices(hw->card);
 		if (err) {
 			snd_printk(KERN_ERR "usx2y_create_alsa_devices error %i\n", err);
+			priv->chip_status |= USX2Y_STAT_CHIP_HUP;
 			return err;
 		}
 		priv->chip_status |= USX2Y_STAT_CHIP_INIT;
-- 
2.34.1

