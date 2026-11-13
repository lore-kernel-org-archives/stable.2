Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794571071;
	b=NtevoAwjIz0xQHrKxhbxb6VvvFqViGeWyA5NdOTT6RUOPjNy+2swCUQVqyeCjBytG2Uw
	 /bTcaxdSyy3PDz2fZd+L5h1H0L3OwOR0UccH1H9xSSNDgVJrmIYlumIhx1ZyDTP6l+u4l
	 bwLyEA45kbWfNAsfrWP5jm1ciZvaiPc9UtijuT7ldArtJxsKtzIwgRoOMxb3c80eitHyM
	 KYdUKeSyP6gSZqa0QOOHbF8U/SDX/kr+rQd5oCaJo8EeYkyVR/2ZYynOyaxi3svxjZP7i
	 yuhmtwFdJIjFATx1xor6xW5doBKxGgso3aLY7ucFpkYoAT1HkkiAjgbVV0YNUfMyJxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794571071;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=L4YjZ/1ljkh/HjE3eGpUGCJNzVMxyRxT8CIi/utfosY=;
	b=GKFRGZT8dHjgErhBlhwxjP/aI8cQnlTJ3W0CAgEhHtCPfAGJCFp+U/41O48AQCSVyGzH
	 ZjjxHU1mVRD3cBJ/Po9p7zYo2UyNfPwoNqGpxT6yU9pvvu2b2CzYg2pHV5L0/zSb3lKsf
	 JiL1Mfcx+lNNKRTyYLaEIjop+zbhbyEuFlPGZWxeP5CZGA+NHmgOprNyTlZgxPxK/Zo7w
	 VyCZHgCgG47iv7Le3Nzkr4d6OC5PJN5qLoN1w384ls8/w5IPoUf1mxYp8HtsfyMvQWigq
	 zQF3qWS5P3HvwKz3dMhGhM8c8wPmcwTI9SfLqWJey5Cw7+AuSkBeHSp5sv1hG89G++Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EBE606A335;
	Fri, 13 Nov 2026 11:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42EBE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=L4YjZ/1ljk
	h/HjE3eGpUGCJNzVMxyRxT8CIi/utfosY=; b=SQwYcv8j++txssD3y7dbhZGSG1
	11uxRg3jZlByBcpk/3k2btKI+Ua4xj8s5D+GW/gCZ9yJHFCbel49c12smPXn1LW2
	NicdmGcdwRqeizitAfJwtYrjRhEYA7nKvnYUwNnW5oe5xxEfU814C9KLSFX5yChV
	WRPSUaip73SBYycE8=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [240e:454:4310:e495:3439:1db1:93eb:3bc3])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBmav0s+_ZqWp2NAQ--.2840S2;
	Fri, 13 Nov 2026 19:57:34 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: mchehab@kernel.org
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+54648a6c1187a7ef46a6@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>,
	Jinning Zhang <25031212117@stu.xidian.edu.cn>,
	Bin Yu <byu@xidian.edu.cn>
Subject: [PATCH] media: em28xx: clear dev->v4l2 when v4l2 init fails
Date: Fri, 13 Nov 2026 19:56:54 +0800
Message-Id: <20261113115654.642-1-26031212468@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkBmav0s+_ZqWp2NAQ--.2840S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1UXF1UCw1rXFy8Zw1rXrb_yoW8tFykpa
	9rWFWYyryYyr4qgw17Jw1UWr10yFn5t3y5CrW7Kw1qkrn3GrWxCrZaqryUuFs0y393AFWj
	qFyDJw4xWFW5uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vEY41l42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUbg4SUUUUU
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAQUQEWr11lZwpAACsM

em28xx_v4l2_init() publishes dev->v4l2 before the initialization is
complete. If a later step fails, the error path unregisters any video
nodes and drops the initial v4l2_device reference, but leaves dev->v4l2
set until the release callback runs.

em28xx_init_extension() does not propagate an extension init failure, and
em28xx_close_extension() later invokes the extension's fini() callback.
The extension init and close paths are serialized by
em28xx_devlist_mutex, so clearing dev->v4l2 before init returns makes the
later fini() see NULL and avoid another v4l2_device_put(). Otherwise, the
reference count can reach zero while a video node still holds a reference.

The open callback checks dev->v4l2 under dev->lock, so an open waiting for
init cleanup sees NULL and fails with -ENODEV. Clear dev->v4l2 while still
holding dev->lock to protect that check.

Fixes: 288254383674 ("media: em28xx: use v4l2_device release callback")
Reported-by: syzbot+54648a6c1187a7ef46a6@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=54648a6c1187a7ef46a6
Cc: stable@vger.kernel.org

Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
diff --git a/drivers/media/usb/em28xx/em28xx-video.c b/drivers/media/usb/em28xx/em28xx-video.c
index 47441e98173d330c773dede5596872ad85678649..046b52f1afc53bd5f5b3944194eb1b9eadeabea1 100644
--- a/drivers/media/usb/em28xx/em28xx-video.c
+++ b/drivers/media/usb/em28xx/em28xx-video.c
@@ -3127,10 +3127,15 @@
 			 "V4L2 device %s deregistered\n",
 			 video_device_node_name(&v4l2->vdev));
 		vb2_video_unregister_device(&v4l2->vdev);
 	}
 
+	/*
+	 * Prevent open() from using this failed instance and fini() from
+	 * dropping its initial reference a second time.
+	 */
+	dev->v4l2 = NULL;
 	mutex_unlock(&dev->lock);
 
 	/*
 	 * Drop the initial reference. em28xx_free_v4l2() will be called
 	 * once the last video_device node release has decremented the
-- 
2.47.0

