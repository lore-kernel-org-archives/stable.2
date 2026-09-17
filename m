Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91BB3A5449;
	Thu, 17 Sep 2026 09:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638900; cv=none; b=ZtxhEorn10zU9iz4dwBnNv1D7nkFqr8+dE4DcDce67EXA05BgIxUi4Z5yCG8jLvvqYwgdqS0FvQEI8IRkJ2vfWL87zAVIyH2vQ6DaUqbJdW9pAppXXR2YRIOlOHYKtQ7dn1FLr7UsyDU/i2BsK1z+pXf1rqlPcnGscyOg/zcQxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638900; c=relaxed/simple;
	bh=GcgK0cOP/xsRIMscluwCnFRfGlh4TqqsN6j/q8dZFY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GHrE8B6eRnhBlcnvVHLZqHkazMazp1MHe4GQujomsMPiJXfcVFlx7wM+AyWc3+kIDNQpcUp9SsASM/zBJY5Y/yNNSFr3H/qJZ5qcNtY2hdxxnmAj+/XaLy7BBsqdS05rPs80E4kCluCX9Dryp3BlR0ur9tCsq8bSNtMiSMvO8P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnUDvjuKtqyxZ+CA--.40302S2;
	Thu, 17 Sep 2026 17:54:43 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: hverkuil@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	shuah@kernel.org,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] media: au0828: Fix media device leak in au0828_usb_probe()
Date: Thu, 17 Sep 2026 09:54:43 +0000
Message-Id: <20260917095443.2145586-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADnUDvjuKtqyxZ+CA--.40302S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Jr17tFyktw4UWF47XF4UXFb_yoW8JryUp3
	ykJFy5CrWUJr4q9w4UJ3WUWF15W3ZavrWrCr97Aan3ur1fAa47JrW8Za4jgw4UtayIka4j
	qr4UtrWrZr4Fkw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBFb7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4UJwCI42IY6I8E87Iv6x
	kF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x07j0rWrUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMNA2qrq003VgABsT

au0828_media_device_init() takes a reference to a media device with
media_device_usb_allocate().  When au0828_v4l2_device_register()
fails right after, the error path only unregisters the entities and
frees au0828_dev, so that reference is never released.

Release it with media_device_delete() on that path.

Fixes: 812658d88d26 ("media: change au0828 to use Media Device Allocator API")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/media/usb/au0828/au0828-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 445cbeb7abae..c3826b3b8a2e 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -697,6 +697,10 @@ static int au0828_usb_probe(struct usb_interface *interface,
 	retval = au0828_v4l2_device_register(interface, dev);
 	if (retval) {
 		au0828_usb_v4l2_media_release(dev);
+#ifdef CONFIG_MEDIA_CONTROLLER
+		media_device_delete(dev->media_dev, KBUILD_MODNAME,
+				    THIS_MODULE);
+#endif
 		mutex_unlock(&dev->lock);
 		kfree(dev);
 		return retval;
-- 
2.34.1

