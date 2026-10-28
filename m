Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793161534;
	b=AFsQBailSMnkrzk0hQgveSuV7/8PUBGqNy3jht9n3PNipH+9cRl8B5z0wFt+MxYbX2LQ
	 MIbhUutJbKgnaNt5vw4hk0blyXuRVdG1fRVcprVPzbglEWgivQXvPpBoLw16F+01AJDQz
	 exEY70b7CT8fkx0ErZ7OKzqztks57hgUleU6rZM98Rkce5PhuUs4lEqYn2X+w4PUGoGrh
	 RjJHeHs7ltj9RbWTDFlyOUMir0t9F3wTWE5SLOVDir/Ar0RMlQjAX7Yim97ydXk104sRb
	 nLe9rMWRuudaFCj4OEyedDVPgmpflYxKaXImhP85YTCTtLBTQy/WyaLLs31eCEAgUDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793161534;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=EHNhuc96HLFzFHehXSSUJIzpWm6INtH/7YymMk0hd+I=;
	b=y3we6craIUHuGIxTNaiU2uDdc3zl+eYASfNKTPJ8KlQGLp5mZWEPYgZenEzk5TBbpDyV
	 p+fJtkRodcuDvhULIIYoegQxGCXamRbHhvsqtTJ3EoYmNLIvIpqG2LR/myIsiQYw4nMj+
	 aKtaP67S7JteD8s6t/H1rltnZglHl/aa5fYOLdAnVydIda/ovtX8g2KGUiszM0VAiOdeo
	 fKXj4koQzp34xV7GSWWx9GS/Cg2cRz2SNvPqmVz35uAKZa8s7Sa61Wc+byCWM+8NxQ2F4
	 WL5MF/rhFyycNlsma2C+jtFW6uByhnFtjkWCKBBL4LrnVXWd3VKuIWFZYXxFNnG7zrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05A8606A31A;
	Wed, 28 Oct 2026 04:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A05A8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=EHNhuc96HL
	FzFHehXSSUJIzpWm6INtH/7YymMk0hd+I=; b=bjZSIIDoafc8oRpjJmIw3uwyPy
	YRI11LDTbP1YZJqFFc2YVdNvuX7eV1W4MhH4CM8rntWqdtQJUisu2WwilJIJ/W3L
	d1gGJq7o4XABcsU4ZvmfE2ZstVprW61MRhrqQ/2dmsKjRNJADTE/GDrtaRxPJHlM
	NBwAI+BhSZGgchn1A=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkD2GgE1eeFqquXyAA--.58159S2;
	Wed, 28 Oct 2026 12:25:26 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
Date: Wed, 28 Oct 2026 12:25:25 +0800
Message-Id: <20261028042525.8737-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkD2GgE1eeFqquXyAA--.58159S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrWkKw17Cw15Ary3tF13urg_yoW8CFWkpr
	s3urWfKFW3Jr4v9r13Wa13tw40yw4qyFy5Cryqvw15Zry5ZF4fJ34rCryYgryfWrW8CrW5
	Krn8XasI9w1UA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r45MxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJV
	W8JbIYCTnIWIevJa73UjIFyTuYvjxUxl1vUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUAD2rgvlNkOwAAsz

usb_stream_hwdep_mmap() reads us122l->sk.s and dereferences it without
checking for NULL.  The stream object is released by usb_stream_free(),
which is reached through us122l_stop() both when the device is
disconnected and when us122l_start() fails, and it leaves us122l->sk.s
set to NULL.  The hwdep file stays usable after that, so a later mmap()

	KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
	RIP: 0010:usb_stream_hwdep_mmap+0x107/0x890 sound/usb/usx2y/us122l.c:182

crashes while reading s->read_size, which sits at offset 0x10.

That NULL is an expected state for this field: usb_stream_hwdep_vm_fault(),
usb_stream_hwdep_poll(), usb_stream_hwdep_ioctl(), usb_stream_stop() and
usb_stream_free() all test it before use.  Only the mmap callback misses
the check, so let it return -ENODEV, matching what the other hwdep mapping
in usx2yhwdeppcm.c does when its shared buffer has not been allocated.

Fixes: 030a07e441296c372f946cd4065b5d831d8dc40c ("ALSA: Add USB US122L driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 sound/usb/usx2y/us122l.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/usx2y/us122l.c b/sound/usb/usx2y/us122l.c
index a5db0d044ef9..27b6b0bd5768 100644
--- a/sound/usb/usx2y/us122l.c
+++ b/sound/usb/usx2y/us122l.c
@@ -179,6 +179,8 @@ static int usb_stream_hwdep_mmap(struct snd_hwdep *hw,
 	offset = area->vm_pgoff << PAGE_SHIFT;
 	guard(mutex)(&us122l->mutex);
 	s = us122l->sk.s;
+	if (!s)
+		return -ENODEV;
 	read = offset < s->read_size;
 	if (read) {
 		if (area->vm_flags & VM_WRITE)
-- 
2.34.1

