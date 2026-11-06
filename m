Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=219.143.121.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793954487;
	b=IyVhPsmHXg+o26vkcEI0Ph1lpNvhsRdl3ZHok2MI7bn5GyfptlpFeq05ssRkuAiq5RGh
	 1AQqlEQLp3Lb2RplyPq56bp+tsyBK4sI9orkg3qkumAqfurCBtsIU2QgWHPsdPlQ7GOb8
	 /3YjoiRnUn+aU08+rCJjX/JLQYSglfC9PbhKqAJ4FeSyvrZDfCIcO6+5WJuTIisKK4X+h
	 zYrf6LhUvTUd1pN0CMcwnCEPtZsQOHoDCATFq+uP6ZksXSJtDE7kcPpg3qEhO3V2Uh+Db
	 3WBBWOPvYx+e1nB2fhBFMISKWsz7krccKyqFfZC4PJLZRYEdhJmWBV//WAqAA0r7DkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793954487;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-FangMail-Miltered:X-FangMail-Envelope:X-FangMail-Bounce-Flag:
	 X-FangMail-Outinfo:X-CLEAN:Message-Id:X-Fangmail-Anti-Spam-Filtered:
	 X-Fangmail-MID-QID;
	bh=rgRY6L8wp214AvSgqKYYx0hBLRjhaRRvysoMuM44BjM=;
	b=uPISq3qRG8MG/KymGX2X7XxJrn8cIpoWtNQRy5zKmbTUTtL1WmzolKMeDI48ut9e3k74
	 Xg363u13S5/3eWwgFwwvpR4t4C+LXM0fwgmbgRWmDtowV9+gXKB5cpd22n4XyI0zTlyWD
	 OjJ/OHS6+6vCIW2pfjA1BSQ03ealHuHi89kEpus9C5BqpA+JVnh6z9JvnIZb3Qil4OqF9
	 mAX4vRyzu1nhtfuPq2XXDxcgXm3IwNs5nrsqA3rVm+3Y6M/JCd653swXV/+aACdWBGeFa
	 WyDCQbR+MOm07zrg20oetf0gwZn9BbSBAkrXsRo/nx27wMBicWH+3ZiZENEmLIpIHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=isoftstone.com;
	spf=pass smtp.mailfrom=isoftstone.com;
	arc=none smtp.remote-ip=219.143.121.9
Received: from spam.isoftstone.com (smg.isoftstone.com [219.143.121.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C77F606A329;
	Fri,  6 Nov 2026 08:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C77F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isoftstone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isoftstone.com
Received: from ldzh.. (unknown [221.226.109.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlzhangak@isoftstone.com)
	by spam.isoftstone.com (FangMail) with ESMTPSA id 4jLXhN6Cksz4Dr7;
	Fri, 06 Nov 2026 16:41:08 +0800 (CST)
From: zhangdaolong <dlzhangak@isoftstone.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: Antti Palosaari <crope@iki.fi>,
	Valery Borovsky <vebohr@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com,
	dlzhangak@isoftstone.com,
	stable@vger.kernel.org
Subject: [PATCH] media: msi2500: return buffers as QUEUED in buf_queue() before start_streaming()
Date: Fri,  6 Nov 2026 16:41:08 +0800
X-Mailer: git-send-email 2.48.1
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
X-TLS: YES
X-ENVELOPE-SENDER: dlzhangak@isoftstone.com
X-SOURCE-IP: 221.226.109.28 unknown Fri, 06 Nov 2026 16:41:09 +0800
X-FangMail-Miltered: at fangwg01 with ID 6AED92A4.003 by FangMail milter!
X-FangMail-Envelope: 1793954469/4jLXhN6Cksz4Dr7/6AED92A4.003/221.226.109.28/[221.226.109.28]/ldzh../<dlzhangak@isoftstone.com>
X-FangMail-Bounce-Flag: 1793954469.6AED92A4.003
X-FangMail-Outinfo: 1793954469/6AED92A4.003/4jLXhN6Cksz4Dr7/dlzhangak@isoftstone.com/1
X-CLEAN: YES
Message-Id: <1793954471.6AED92A4.003.4jLXhN6Cksz4Dr7@fangwg01>
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AED92A4.003/4jLXhN6Cksz4Dr7

When vb2_start_streaming() is invoked, it first passes all pre-queued
buffers on q->queued_list to the driver via buf_queue() before setting
q->start_streaming_called and invoking start_streaming(). If
start_streaming() subsequently returns an error, videobuf2 requires all
buffers passed to the driver to be returned with VB2_BUF_STATE_QUEUED
and warns via WARN_ON(!list_empty(&q->done_list)) if any buffer was
completed with VB2_BUF_STATE_ERROR or VB2_BUF_STATE_DONE.

If the USB device disconnects before vb2_start_streaming() runs (for
example when v4l2_read() races with msi2500_disconnect()), dev->udev is
already NULL when vb2_start_streaming() enters. msi2500_buf_queue() sees
!dev->udev and immediately completes each pre-queued buffer with
VB2_BUF_STATE_ERROR (moving it onto q->done_list) instead of adding it
to dev->queued_bufs. Right after that, msi2500_start_streaming() also
sees !dev->udev and returns -ENODEV, triggering
WARN_ON(!list_empty(&q->done_list)) in vb2_start_streaming().

Fix this by checking vb2_start_streaming_called(vb->vb2_queue) in
msi2500_buf_queue() when !dev->udev: return VB2_BUF_STATE_QUEUED when
start_streaming() has not been called yet, and VB2_BUF_STATE_ERROR when
streaming is already active.

Reported-by: syzbot+930e6201080a31e9d0c8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=930e6201080a31e9d0c8
Fixes: 977e444f59ad ("[media] Mirics MSi3101 SDR Dongle driver")
Cc: stable@vger.kernel.org
Signed-off-by: zhangdaolong <dlzhangak@isoftstone.com>
---
 drivers/media/usb/msi2500/msi2500.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/msi2500/msi2500.c b/drivers/media/usb/msi2500/msi2500.c
index 282256ab812a..d89db57f924f 100644
--- a/drivers/media/usb/msi2500/msi2500.c
+++ b/drivers/media/usb/msi2500/msi2500.c
@@ -625,7 +625,9 @@ static void msi2500_buf_queue(struct vb2_buffer *vb)
 
 	/* Check the device has not disconnected between prep and queuing */
 	if (unlikely(!dev->udev)) {
-		vb2_buffer_done(&buf->vb.vb2_buf, VB2_BUF_STATE_ERROR);
+		vb2_buffer_done(&buf->vb.vb2_buf,
+				vb2_start_streaming_called(vb->vb2_queue) ?
+				VB2_BUF_STATE_ERROR : VB2_BUF_STATE_QUEUED);
 		return;
 	}
 
-- 
2.48.1

