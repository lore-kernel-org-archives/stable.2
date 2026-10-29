Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793271306;
	b=eDBy7PFggslhiFc0X4jyb9DfNUkzuA6Tme3Tt7OroPsYF6DdiwEwKtm0c6ygUPjvYw9Q
	 rtrttsC/WNgpHhKk100kBODTlXDDv7Q7o0+DNxWVZvyEAMgjkcgc45Mvu6zVNjBex7IFl
	 U1Znr5eJiG+/sN6+5hVKt3gwiNb246pIFlbUShZRQjH+lOTg3tp1fXz5BlaED1iuxJPQh
	 qKoZfo3KAmt2xrQRxIs2HnU6HTRAtUl3Fi7DTAqS+XiHY1M/l9oC6hac/ODnVnyqdzSjN
	 TtUXVaY2xP0KW47zXGaYRY9SCJGQzLB0YgOIx/yKXF7Tby8XPjVsij3sDsPRR6aobLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271306;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=WTx7pmASk7/nsv1yYc69FRa7+fLFzGFr42sP00Tprpo=;
	b=HkQqEyiMfuZUbyWouJKdPrDHXfLUlkn5N65dIElnkpmzPtk24KwNgceA4lNqwDRq0Sez
	 243oxHl2lOq/UCk26johT1+79BqCslwkeVGB1CZUrwwS3c730BTafnu4q+1WHJWtBMpaV
	 nJUTjxTCNkbiCs15XIsw9S9FgeGV/Mjh0d9iMzbdRawUGK2UJl61RHU2hOykC6uKmSmz2
	 1LEyZgHJf14QdwJUTPaFMtOWtUCz25c/jUbpd/0lEGSvuQttA2tTy0DTx2skRXStIlSXp
	 siXIvqkar3DARI9JxZcsBYf+6Jq12ZrVG9xlXWJp13AO4UaNJL3xS8XEctZX7ziaqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F67606A31A;
	Thu, 29 Oct 2026 10:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F67606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=WTx7pmASk7
	/nsv1yYc69FRa7+fLFzGFr42sP00Tprpo=; b=PadOlEUt5v70rFNboilPcsVY14
	vvFkObsZDr713Pl+2bmjJp+efO1Rf1m5NEV+Z3ek9klvamweCesHJx2CM/AwoRvN
	B9XNghvxz42Xf4pVQgdcouKItHA0US9E5n1eZGv0mCuP2tO1t0c0Oc9DlysQTJ9s
	rZ60IJ/VFlWUkqK4Y=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkD2HAP7JeNqTWL+AA--.51457S2;
	Thu, 29 Oct 2026 18:54:53 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lei Huang <huanglei@kylinos.cn>,
	Dean Anderson <dean@sensoray.com>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: s2255: cancel the in-flight firmware URB before reloading
Date: Thu, 29 Oct 2026 18:54:50 +0800
Message-Id: <20261029105450.5852-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkD2HAP7JeNqTWL+AA--.51457S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCryrZw48AF45WFyrWFy8Xwb_yoWrCryrpF
	WFga90kFWDGw18Crs7Cr47u3W5Zws5JFZ8KFy2ya4vyr15J34DCFZ5t3y7XFyDArySya13
	Jryqvry5u390qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUg0D2UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2riEkGqlQAAst

The driver uses a single URB to upload the firmware. s2255_timer() submits
it one second after s2255_fwload_start() filled in the first chunk, and
s2255_fwchunk_complete() resubmits it for each following chunk.

When the transfer does not complete within S2255_LOAD_TIMEOUT, s2255_open()
stops waiting, sets the firmware state to S2255_FW_FAILED and returns
-EAGAIN. The next open() calls s2255_fwload_start() again, which refills
the URB and arms the timer while the previous transfer may still be owned
by the USB core.

One second later s2255_timer() submits that URB again:

  URB 00000000b9ed398a submitted while active
  WARNING: drivers/usb/core/urb.c:379 at usb_submit_urb

usb_submit_urb() returns -EBUSY, the firmware state is set to
S2255_FW_FAILED and the device stays unusable. Rewriting the fields of a
URB that is still in flight is unsafe as well.

Cancel the outstanding transfer and the pending timer before reusing the
URB, and serialize restart attempts so that two open() calls cannot refill
the URB while another attempt is running. A killed transfer completes with
-ENOENT, so do not report it as a transfer error.

Fixes: 38f993ad8b1f ("V4L/DVB (8125): This driver adds support for the Sensoray 2255 devices.")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
 - Serialize firmware restart attempts with a mutex so that concurrent
   open() calls cannot refill the shared URB while another restart is in
   progress.
---
 drivers/media/usb/s2255/s2255drv.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/s2255/s2255drv.c b/drivers/media/usb/s2255/s2255drv.c
index 15012d73975c..ba717cdf31ad 100644
--- a/drivers/media/usb/s2255/s2255drv.c
+++ b/drivers/media/usb/s2255/s2255drv.c
@@ -179,6 +179,7 @@ struct s2255_fw {
 	int		      fw_size;
 	struct urb	      *fw_urb;
 	atomic_t	      fw_state;
+	struct mutex	      fw_lock;	/* serializes firmware restarts */
 	void		      *pfw_data;
 	wait_queue_head_t     wait_fw;
 	const struct firmware *fw;
@@ -490,7 +491,9 @@ static void s2255_fwchunk_complete(struct urb *urb)
 	int len;
 
 	if (urb->status) {
-		dev_err(&udev->dev, "URB failed with status %d\n", urb->status);
+		if (urb->status != -ENOENT)
+			dev_err(&udev->dev, "URB failed with status %d\n",
+				urb->status);
 		atomic_set(&data->fw_state, S2255_FW_FAILED);
 		/* wake up anything waiting for the firmware */
 		wake_up(&data->wait_fw);
@@ -1502,6 +1505,7 @@ static void s2255_destroy(struct s2255_dev *dev)
 	}
 	release_firmware(dev->fw_data->fw);
 	kfree(dev->fw_data->pfw_data);
+	mutex_destroy(&dev->fw_data->fw_lock);
 	kfree(dev->fw_data);
 	/* reset the DSP so firmware can be reloaded next time */
 	s2255_reset_dsppower(dev);
@@ -2187,6 +2191,16 @@ static void s2255_stop_readpipe(struct s2255_dev *dev)
 
 static void s2255_fwload_start(struct s2255_dev *dev)
 {
+	mutex_lock(&dev->fw_data->fw_lock);
+	/*
+	 * A previous load attempt may still have a transfer in flight, e.g.
+	 * when s2255_open() timed out and the next open() restarts the load.
+	 * Serialize restart attempts and cancel it before rewriting the
+	 * shared URB.
+	 */
+	timer_delete_sync(&dev->timer);
+	usb_kill_urb(dev->fw_data->fw_urb);
+
 	s2255_reset_dsppower(dev);
 	dev->fw_data->fw_size = dev->fw_data->fw->size;
 	atomic_set(&dev->fw_data->fw_state, S2255_FW_NOTLOADED);
@@ -2199,6 +2213,7 @@ static void s2255_fwload_start(struct s2255_dev *dev)
 			  CHUNK_SIZE, s2255_fwchunk_complete,
 			  dev->fw_data);
 	mod_timer(&dev->timer, jiffies + HZ);
+	mutex_unlock(&dev->fw_data->fw_lock);
 }
 
 /* standard usb probe function */
@@ -2227,6 +2242,7 @@ static int s2255_probe(struct usb_interface *interface,
 	dev->fw_data = kzalloc_obj(struct s2255_fw);
 	if (!dev->fw_data)
 		goto err_fwdata1;
+	mutex_init(&dev->fw_data->fw_lock);
 	mutex_init(&dev->lock);
 	mutex_init(&dev->cmdlock);
 	/* grab usb_device and save it */
-- 
2.34.1

