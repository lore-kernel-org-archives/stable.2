Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=31.44.14.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795526688;
	b=pwN196P9Ot7N9HtX14RwKIt6RHbGwp2wfq9wW2j+Ia8UY3adktGwINNDo4tkWJmeoE1L
	 DxAyjl5PbSaSAV5IzLTAFx95AT/rEOD8n5IJ5fv+E4Xqwg7z+uB5qsNcpauqoA8SlzuKA
	 2kMMz29btbnp6tub+6/XwtCTDnrH1GyGHErd1qnXJ0FHzOBNhxFIOPRrRxVIbp46J7Y4b
	 dtTZ2YM24nFJadp0IRPn+ZmMPTJPZm3heAjwnNYPMZ5FStDapqyYqL5CF3D8IG0CAj0p2
	 yXPcoUUt568PcO74nNsuhrVpqchEiD0fLsB86h18L+XARpJ/ceQjwz86KJy75DCpZAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795526688;
	h=DMARC-Filter:Received:Received:X-Yandex-Fwd:DKIM-Signature:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YYfDbNOgSdFef5NhBjaaqzm1pRX/y/dOOUs0QwMT4O4=;
	b=Lix3JfY5GJ/PmgpUG6WR6gUz+2V3jcxT2HxrNPMyRR8gOEh0nDoTbNUKo+b1akIcaugM
	 Oo1bnuSGdfdiB2pPVy/e9ki/czXy1rj7zXm2z8UA2c5LohHCyb1cExnh7uX+hn61dtsS/
	 kIWtZjXdhV0fAVNYn12aXWNGcf7+tPW1RWpfDEYOOgOREogoDGWB//eYw3IYfOjG4rl8f
	 1BEVZ5ZjT0rSyw8AOuFvloWfUsXWwl9AWPhkI3wPgly8dJQiKeA9u4ZluaBuFEtxx9HYR
	 fgcDO8n69jYyZrtJiWrU73nJEr2hYCg5lH9Iq3Oy1aqJi9DT1pDrBgpyV8y6Xbm4Ufg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=yandex.ru;
	spf=pass smtp.mailfrom=yandex.ru;
	dkim=pass header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=uHo5lb83;
	arc=none smtp.remote-ip=31.44.14.16
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [31.44.14.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5824606A321
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 13:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5824606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.a=rsa-sha256 header.s=mail header.b=uHo5lb83
Received: from mail-nwsmtp-smtp-production-canary-28 (mail-nwsmtp-smtp-production-canary-28.yp-c.yandex.net)
	by forward500d.mail.yandex.net (postfix) with ESMTPS id 61C038194D;
	Tue, 24 Nov 2026 16:24:39 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-28 with ESMTPSA id YOg8RW3Xma60-GbXH32to;
	Tue, 24 Nov 2026 16:24:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1795526678; bh=YYfDbNOgSdFef5NhBjaaqzm1pRX/y/dOOUs0QwMT4O4=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=uHo5lb83jQ0K8HIcAsUX14W0GGn8b4mb3rPpHGYlT02wJcGSNbfPuyjh7P8cYYpug
	 VuwUAkKcvPk9CY+4EgZRPnTgEwPUMA5EtS0Mb3q6XIdhnn6wJAzIAxMNRZr/wuFGgi
	 lk6p5hFSVKZemOmVNfDQHHvJHU4CTbICWWa69G+A=
Authentication-Results: mail-nwsmtp-smtp-production-canary-28; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lvc-project@linuxtesting.org
Subject: [PATCH 5.10/6.1/6.12 3/4] HID: roccat: use kref to manage device instances
Date: Tue, 24 Nov 2026 16:24:33 +0300
Message-ID: <20261124132434.134814-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261124132434.134814-1-dmantipov@yandex.ru>
References: <20261124132434.134814-1-dmantipov@yandex.ru>
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

commit be90794d15c6b22861cacebaca2380cbff855157 upstream.

Use kref to manage 'struct roccat_device' instances and fix both memory
leaks and UaF-triggering races between roccat_open()/roccat_release()
and roccat_connect()/roccat_disconnect() pairs. To avoid the scenario
when opened device is disconnected and its slot indexed by minor number
is reused by another device, release the slot in roccat_free_device()
rather than in roccat_disconnect(). This way, there is a time frame when
disconnected device may still occupy the slot; to reject such a device,
add extra roccat_device_available() checks to roccat_open() and
roccat_ioctl(). Add extra WARN_ON() device check to roccat_disconnect()
and a few debugging quirks to roccat_free_device() as well.

Reported-by: syzbot+d632e93ffcd1452bc61e@syzkaller.appspotmail.com
Reported-by: syzbot+c492a9e154f81127551f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d632e93ffcd1452bc61e
Closes: https://syzkaller.appspot.com/bug?extid=c492a9e154f81127551f
Link: https://sashiko.dev/#/patchset/20260902094551.200587-1-dmantipov@yandex.ru?part=2
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://patch.msgid.link/20261022054454.238343-3-dmantipov@yandex.ru
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/hid-roccat.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-roccat.c b/drivers/hid/hid-roccat.c
index 648b42c2101b..cd7385531eb4 100644
--- a/drivers/hid/hid-roccat.c
+++ b/drivers/hid/hid-roccat.c
@@ -40,6 +40,7 @@ struct roccat_device {
 	unsigned int minor;
 	int report_size;
 	int open;
+	struct kref ref;
 	atomic_t exist;
 	wait_queue_head_t wait;
 	struct device *dev;
@@ -75,12 +76,20 @@ static bool roccat_device_available(struct roccat_device *device)
 	return atomic_read(&device->exist);
 }
 
-static void roccat_free_device(struct roccat_device *device)
+static void roccat_free_device(struct kref *ref)
 {
+	struct roccat_device *device;
 	int i;
 
+	WARN_ON(!mutex_is_locked(&devices_lock));
+
+	device = container_of(ref, struct roccat_device, ref);
 	for (i = 0; i < ROCCAT_CBUF_SIZE; i++)
 		kfree(device->cbuf[i].value);
+
+	devices[device->minor] = NULL;
+	mutex_destroy(&device->readers_lock);
+	mutex_destroy(&device->cbuf_lock);
 	kfree(device);
 }
 
@@ -174,7 +183,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 
 	device = devices[minor];
 
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		pr_emerg("roccat device with minor %d doesn't exist\n", minor);
 		error = -ENODEV;
 		goto exit_err_devices;
@@ -196,6 +205,7 @@ static int roccat_open(struct inode *inode, struct file *file)
 			--device->open;
 			goto exit_err_readers;
 		}
+		kref_get(&device->ref);
 	}
 
 	reader->device = device;
@@ -234,9 +244,8 @@ static int roccat_release(struct inode *inode, struct file *file)
 		if (roccat_device_available(device)) {
 			hid_hw_power(device->hid, PM_HINT_NORMAL);
 			hid_hw_close(device->hid);
-		} else {
-			roccat_free_device(device);
 		}
+		kref_put(&device->ref, roccat_free_device);
 	}
 
 	mutex_unlock(&devices_lock);
@@ -348,6 +357,7 @@ int roccat_connect(const struct class *klass, struct hid_device *hid, int report
 	INIT_LIST_HEAD(&device->readers);
 	mutex_init(&device->readers_lock);
 	mutex_init(&device->cbuf_lock);
+	kref_init(&device->ref);
 	device->minor = minor;
 	device->hid = hid;
 	atomic_set(&device->exist, 1);
@@ -369,19 +379,19 @@ void roccat_disconnect(int minor)
 	mutex_lock(&devices_lock);
 	device = devices[minor];
 
-	atomic_set(&device->exist, 0);
-
-	device_destroy(device->dev->class, MKDEV(roccat_major, minor));
+	if (WARN_ON(!device))
+		goto out;
 
-	devices[minor] = NULL;
+	if (!WARN_ON(!atomic_cmpxchg(&device->exist, 1, 0)))
+		device_destroy(device->dev->class, MKDEV(roccat_major, minor));
 
 	if (device->open) {
 		hid_hw_close(device->hid);
 		wake_up_interruptible(&device->wait);
-	} else {
-		roccat_free_device(device);
 	}
 
+	kref_put(&device->ref, roccat_free_device);
+out:
 	mutex_unlock(&devices_lock);
 }
 EXPORT_SYMBOL_GPL(roccat_disconnect);
@@ -396,7 +406,7 @@ static long roccat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	mutex_lock(&devices_lock);
 
 	device = devices[minor];
-	if (!device) {
+	if (!device || !roccat_device_available(device)) {
 		retval = -ENODEV;
 		goto out;
 	}
-- 
2.56.1

