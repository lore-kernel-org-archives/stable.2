Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793263709;
	b=nz6RtBy+RZ7ThceBg7htj2o0EfbWU8EPuzT+JzCAO86p5Kvg/tRVwNVmTkfJKbqXAX0z
	 ZSPeHyynWSoY9YAHxDzkJgdl419/RHtsNObS3GCwJH2ZB8pcXY0/dFRaEMjXayXXaCrEL
	 sbG1n9JwiOfcxRNazcl/N5kX/xOTr4+R0PfZJB/460P5DovQPwpTJgijdE6eK5drxYLjs
	 ApCFpbG0b33v8TnP49n1xZR6aWLsfxto4mtf09D1gx2/iN4Fj3wkfyGSsD2SEmEuZldHZ
	 t6ruqtzMfTz3ADw+iB0Y8ppLpo7q1bBCinmy9V/FAkXVhjyPQog5ebpXbaRnD0wsMrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793263709;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=VT52oIdXgrwJN8WfjnqlsxsxM5NwYrL/6rOovOkWsAk=;
	b=n99KarUOop5ZkLYEPaQ1JUWFNsQVDgAdIB95uOUIZ9LsgDO18Cr//SKYBR3IH0fwRirW
	 IXHMB3/yWyr7snAfxWgdtDWcVQpbzLiBnahmAmTvR57HIP9TQ8x/5sxPO1+l19YwZIMaL
	 JCebvvxyY4k6xuNHRRbB/XWxZzxEXBcBIcfLBVrcrJJd6aSfli8TGS7nPX6SWX0BwLcqk
	 s1DBAsbrsXVIAU+yYAvtKBb2uAV7lkGjX37dFzxR63xhOSI9gyKJFgAjg6awQEbReWE92
	 KwZianT8Ld7dlPsTMDFjhLiH6Q3bNRnRFY3QkAGYq23ZY6nuzwe0nfKBn9Retsf97fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC85606A31D;
	Thu, 29 Oct 2026 08:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DC85606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=VT52oIdXgrwJN8WfjnqlsxsxM5NwYrL/6r
	OovOkWsAk=; b=LN/stdaO6FVVMA2zCkSzhrCfa7HnsWGhoSpUwBo3G8wZUn/PQw
	cvdgyfTmIMfOBWJoLXUU7esTR2aWFLHe/GE7haKfnk9rgTiM3RNUknPuNVZcPKBH
	OiiHu+AA3yV/aujDIFzoIIw7KnkP4gCLSQkCSSGTHH26zn6q2Mao2hntk=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkAmKv1KCONq6jz8AA--.61740S4;
	Thu, 29 Oct 2026 16:48:21 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] ALSA: usx2y: Avoid WARN on a repeated DSP load
Date: Thu, 29 Oct 2026 16:48:10 +0800
Message-Id: <20261029084810.21910-3-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkAmKv1KCONq6jz8AA--.61740S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1kurWftr1rXF1fWw4rXwb_yoW8Aw13pr
	W7KrW5tFyqqrs2vw4qqw4I9w1jkan2yrWfCrWvyw48Arn8XF4Sk345tFWqgF17GFW8Cry0
	vFyDtr13ZFW5Cw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmqb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUXwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv
	6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcV
	AaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0E
	x4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
	0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
	6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWw
	C2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_
	JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJV
	WUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
	CTnIWIevJa73UjIFyTuYvjxUsuc_UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUBD2riD9OTlAAAsZ

snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
the interrupt URB when the FPGA firmware image (index 1) is loaded.  If
a later step of the same request fails, for example the creation of the
ALSA devices, a following DSP load request from user space enters the
initialization functions for a second time.

usx2y_async_seq04_init() and usx2y_in04_init() assert with WARN_ON()
that they are called only once, so such a request triggers a kernel
warning before returning -EBUSY, although nothing is corrupted: the
functions bail out without allocating again and the leak that the check
was added for is still prevented.

Return -EBUSY without the warning.

Fixes: 02d382af1c4e ("ALSA: usx2y: Fix potential memory leaks")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 sound/usb/usx2y/usbusx2y.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/usbusx2y.c b/sound/usb/usx2y/usbusx2y.c
index 108f9bddf9aa..14498ce84440 100644
--- a/sound/usb/usx2y/usbusx2y.c
+++ b/sound/usb/usx2y/usbusx2y.c
@@ -268,7 +268,7 @@ int usx2y_async_seq04_init(struct usx2ydev *usx2y)
 {
 	int	err = 0, i;
 
-	if (WARN_ON(usx2y->as04.buffer))
+	if (usx2y->as04.buffer)
 		return -EBUSY;
 
 	usx2y->as04.buffer = kmalloc_array(URBS_ASYNC_SEQ,
@@ -300,7 +300,7 @@ int usx2y_in04_init(struct usx2ydev *usx2y)
 {
 	int err;
 
-	if (WARN_ON(usx2y->in04_urb))
+	if (usx2y->in04_urb)
 		return -EBUSY;
 
 	usx2y->in04_urb = usb_alloc_urb(0, GFP_KERNEL);
-- 
2.34.1

