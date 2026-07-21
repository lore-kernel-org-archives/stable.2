Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90063AB5CA;
	Tue, 21 Jul 2026 08:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622014; cv=none; b=fIM+nOtu2j+hWzVRgGKsO+QMHiZZrjZJZyyxJ9163aHhBms+wkm8ZUfLF4m+GIfLZ0WeQO8h75NXA/LJI7bscezBrhtDF6zYnBVTFr67lB8ike6WNa+t7HWdgPc4vqI2CqfWYl8mWYFqaPoYWPzdMgA4a0p8dgq7hiWVv3QPr4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622014; c=relaxed/simple;
	bh=EBmyS7Ev7QwLlk7pTfqWrf57IGoxnA0THVWhEw6+O08=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l3fw/PcjASR/c8yncB+3Gt7lXjMdjy1bAyzDFhCawUuU5rH3TobRSMcUrYzkq47uwoTwbUIKFFLcrSTE+5e0/Q4R333rEgSmJZTK+4wJO7iuIapXe99GAr/AJ0RtsD3opmIUKNTcdecekWLJzRAa0RMixDRe2XafdQrcgPSKm1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=Y9Fl8EVI reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="Y9Fl8EVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=slkMB1n5lL
	18xVarizCiSrf3pbimSGms9jOIwlPcuPE=; b=Y9Fl8EVIROLgzAT7Q1/vyVB3pR
	N/chrl4/htKfVUiZQa7dRl8MLJh7OxlCAbDMBo2jfE9B3hGOozqoDn/gmrObv/nd
	0fgBfK3F9SE4IfJMakBJBdL7ojfCUMtHJdqJS/1aG7AIGt4B0woOG7EEfsb4STr1
	Pn/UaB1nN5jVt/2cE=
Received: from wmy.localdomain (unknown [115.51.78.210])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkC23xWgK19q0zBKAQ--.7875S2;
	Tue, 21 Jul 2026 16:19:46 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: simona@ffwll.ch,
	deller@gmx.de
Cc: tzimmermann@suse.de,
	sam@ravnborg.org,
	javierm@redhat.com,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: core: Fix pointer desynchronization in fb_io_read()
Date: Tue, 21 Jul 2026 16:19:42 +0800
Message-Id: <20260721081942.107024-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkC23xWgK19q0zBKAQ--.7875S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar17WFyfCFWrZr4kXryrJFb_yoW8Cr15pF
	43KFyfKFn8XwsrAw4DCa12qa4Fka1xZF98WFWvk3WYv3s8tr1Y9348KFyjgrWfAF4xGry0
	qan7Kw1FvF9xuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4
	vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUeYLv
	DUUUU
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUBEWpeO3mHWgAAs8

In fb_io_read(), if copy_to_user() performs a partial copy (e.g., due to
a faulty user buffer), the loop adjusts the chunk size 'c' and updates
the remaining 'count'. However, the hardware 'src' pointer has already
been eagerly advanced by the original chunk size.

If the loop is allowed to continue, the read will resume from an
incorrect, over-advanced offset. Since the remaining 'count' was only
decremented by the successful bytes, this desynchronization causes the
next iterations to execute more hardware reads than originally bounded,
eventually leading to out-of-bounds I/O reads.

Fix this by breaking out of the loop immediately upon a partial
copy_to_user(). A partial copy indicates a faulty user buffer, making
subsequent read attempts futile. Breaking out ensures we return the
number of successfully read bytes without risking out-of-bounds hardware
accesses in subsequent mismatched iterations.

Fixes: 6121cd9ef911 ("fbdev: Move I/O read and write code into helper functions")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
 drivers/video/fbdev/core/fb_io_fops.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/video/fbdev/core/fb_io_fops.c b/drivers/video/fbdev/core/fb_io_fops.c
index 6ab60fcd0050..0798e88799eb 100644
--- a/drivers/video/fbdev/core/fb_io_fops.c
+++ b/drivers/video/fbdev/core/fb_io_fops.c
@@ -61,6 +61,14 @@ ssize_t fb_io_read(struct fb_info *info, char __user *buf, size_t count, loff_t
 		buf += c;
 		cnt += c;
 		count -= c;
+
+		/*
+		 * If there was a partial copy, the user buffer is faulty.
+		 * Break out to avoid over-advancing the src pointer and
+		 * reading out of bounds in the next iteration.
+		 */
+		if (trailing)
+			break;
 	}
 
 	kfree(buffer);
-- 
2.34.1

