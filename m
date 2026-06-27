Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BA42459D1;
	Sat, 27 Jun 2026 04:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782533359; cv=none; b=l/uhINk961jFUL9J8vAnoHCT+38wOdrecBgdxYlrdlJw0sgOGsQHsgRhWmACzYcxk2jHHfPi7rI2DhaIjMJTiJupCSU6GfNUq/E83DOoThgesPCVm/qijQoKKw2e/ZvCSrJ/AY1t347GhSXbXQSRokfVzmrF96mSC+FtvDXaZUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782533359; c=relaxed/simple;
	bh=GtPUSB1RFjwFZZyr7jWp0vtOCYMSfjvAaMpplHyl8sg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F0sltiDR37Ov8f0MFSe2UI9c2dhNNxjQq5PbdbPNDDe6LvY9KI98l9+6pDtiBjkYuQoX4tfA0yS4StJ9E9b2fieUBLNi5EYnETnoENTP5CeXd6EpT+FCyhbLXaFUnzUjgCbOTjzauZLW3BVWJ+lg5L8wkArSm07FSk11JGd1ofc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [117.182.75.66])
	by APP-01 (Coremail) with SMTP id qwCowABnB9DlTD9qoSeCAw--.6498S2;
	Sat, 27 Jun 2026 12:09:11 +0800 (CST)
From: WenTao Liang <vulab@iscas.ac.cn>
To: perex@perex.cz,
	tiwai@suse.com
Cc: kees@kernel.org,
	vulab@iscas.ac.cn,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fix: sound/usb: snd_media_device_create: incorrect media_device_delete on borrowed reference
Date: Sat, 27 Jun 2026 12:09:07 +0800
Message-Id: <20260627040907.60784-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnB9DlTD9qoSeCAw--.6498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4Dtw1fAw4fZrykGw13CFg_yoW8ur4DpF
	48KFyUJrWUXw4Dtw4UWw1kWF1Y9wn8ta1fCw4xXwsIgr4fJasaq34qg3WSv3y7CrWkKa4j
	qr47Wry8uryrGaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbVOJ7
	UUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRMLA2o-DxB2sQAEsb

In snd_media_device_create(), when chip->media_dev is already set, mdev
borrows the reference without incrementing the refcount. On error paths
through create_fail, media_device_delete() is called which releases the
borrowed reference, corrupting the reference count. Additionally,
chip->media_dev is set to NULL, losing the original reference.

Introduce an 'allocated' flag to distinguish between borrowed and
self-allocated references, and only call media_device_delete() when the
reference was actually acquired by this function invocation.

Cc: stable@vger.kernel.org
Fixes: 66354f18fe5f ("media: sound/usb: Use Media Controller API to share media resources")
Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>
---
 sound/usb/media.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/sound/usb/media.c b/sound/usb/media.c
index b7497d18ee3f..290bd24bf301 100644
--- a/sound/usb/media.c
+++ b/sound/usb/media.c
@@ -255,6 +255,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 	struct media_device *mdev;
 	struct usb_device *usbdev = interface_to_usbdev(iface);
 	int ret = 0;
+	bool allocated = false;
 
 	/* usb-audio driver is probed for each usb interface, and
 	 * there are multiple interfaces per device. Avoid calling
@@ -272,6 +273,7 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 
 	/* save media device - avoid lookups */
 	chip->media_dev = mdev;
+	allocated = true;
 
 snd_mixer_init:
 	/* Create media entities for mixer and control dev */
@@ -292,9 +294,11 @@ int snd_media_device_create(struct snd_usb_audio *chip,
 create_fail:
 		if (ret) {
 			snd_media_mixer_delete(chip);
-			media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
-			/* clear saved media_dev */
-			chip->media_dev = NULL;
+			if (allocated) {
+				media_device_delete(mdev, KBUILD_MODNAME, THIS_MODULE);
+				/* clear saved media_dev */
+				chip->media_dev = NULL;
+			}
 			dev_err(&usbdev->dev,
 				"Couldn't register media device. Error: %d\n",
 				ret);
-- 
2.39.5 (Apple Git-154)

