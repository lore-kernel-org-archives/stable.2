Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064359;
	b=HmB3imBETzMHs+OszZTy0e7kHLSitnOW7CBKqXS/vFpNiVkWgrHACNaeQT3BBT8ioWCF
	 kfBCe7KMi1y1dGE+TXIj4exUnp6gIz7mSGSs8hDwc+xvBbZkYVbd6XtuTKobZXtqY05Ti
	 b6hmSghv5uYCW9Vbjf80G9DEzJUCoZEiwvi4/Y8PyAfJDDsDH7Vw/c7S+Ynuy/vFf4mZm
	 Tfq6hHNlVWKf8qHlMgS0Oyznyxm8dhS5jzkWBk8Mwl6RJc1gIzFrFr3XBo2V7jaiUGQ3F
	 k06EZaQA8RzqvTprsE9m5IVvwZnteRWxKX9ofSXCEQzLfylZZ93kOtJcfPqdLco8lww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064359;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=e8x+Yp1b8Kxu6l3y8Cyq5giM+y9Uzg1iDoLxMoSR7RA=;
	b=oulQDFEC1o4xe+VKOo80HsAjpdA441a5/QJ7e8sAHS8UnJ9QNLMiQ3Zgf6aHThJr4mLz
	 6/jBTDMfZEjBV2ajhycTgU2ZmUrmEEd0sPb1AAdfMaG74aF36dj5wp4sibUZNTiMmSOAu
	 5ShInhzYDUA8EuBM2w+mQTD4Wl0Dbdr7VAgxOBChoKcgA18RzwhAJtyQvvLI3J4Z0dy0b
	 RFIgClREdTqZbCOBXeUq11h9KI/D5NqXD7di+busR7NpurZUG4FwaKhkYqmA5NjaJsRwO
	 NEihjIdYZgqsVpPEP5kFC40YCHRVbp6uwMYO/HcLwsNluaYxxHVfOSADUEy27eOY/sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C79C606A31D;
	Tue, 27 Oct 2026 01:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C79C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=e8x+Yp1b8K
	xu6l3y8Cyq5giM+y9Uzg1iDoLxMoSR7RA=; b=Fdq/Tvv/aaiQUlvLwMCr5gu9cN
	c+RTBMmaRF/9+7GjCV5qHoeHFkiWihOG1fSIkW/B5PHAurcfyRvv+6VeOMjYJeyA
	EpjpEVOGAkt1wfV8135eDTJACSDXPEYlf+A/QGpuCmbF6Mn8/knRTtx27525qers
	zpShgkUium/i8ekBg=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.115])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkA2WwGX_d9qJ5LsAA--.52315S2;
	Tue, 27 Oct 2026 09:25:44 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Subject: [PATCH v3] media: dvb-core: prevent frontend thread resurrection after unregister
Date: Tue, 27 Oct 2026 09:25:42 +0800
Message-Id: <20261027012542.5029-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkA2WwGX_d9qJ5LsAA--.52315S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4Utw1xKFW8ZFW5Aw4kXrb_yoWrAw45pF
	Z3JFyjkFWDKw1xCr1vy3ZrXFn0q3W8ZayUG347G3y5Gr1rGFWIgry5t34DXwnxArZ3Jr4q
	qan7Kry8Ca9rAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
	6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr
	0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbcTm3UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2rfbNM95AABsK

A use-after-free read in dvb_frontend_thread() was observed when a DVB USB
device was disconnected concurrently with userspace opening and closing the
frontend device node:

  BUG: KASAN: slab-use-after-free in dvb_frontend_thread+0x1380/0x1620
  Read of size 8 at addr ffff888008dd4320
  Comm: kdvb-ad-0-fe-0 Not tainted 7.1.2-dirty #81
  dvb_frontend_should_wakeup drivers/media/dvb-core/dvb_frontend.c:641
  dvb_frontend_thread drivers/media/dvb-core/dvb_frontend.c:682

  Allocated by the frontend attach path:
   cinergyt2_fe_attach+0x... (drivers/media/usb/dvb-usb/cinergyT2-fe.c:271)

  Freed by the final frontend release:
   dvb_frontend_put+0x... (drivers/media/dvb-core/dvb_frontend.c)
   dvb_frontend_release+0x... (drivers/media/dvb-core/dvb_frontend.c:2934)

dvb_unregister_frontend() stops the frontend kthread and only then removes
the dvb device node.  dvb_frontend_open() does not hold frontend_mutex, so
an open that is already past the DVB_FE_DEVICE_REMOVED check can call
dvb_frontend_start() after dvb_frontend_stop() has returned and spawn a new
kthread.  The frontend kthread does not hold a reference on the frontend
object, so once the last file descriptor is closed the final
dvb_frontend_put() frees the frontend state while that kthread is still
running, which is the use-after-free reported above.

Remove the device node first.  dvb_device_open() invokes the frontend open
handler while holding minor_rwsem for reading, and dvb_remove_device()
takes the same lock for writing and clears the minor, so once it has
returned no open can reach dvb_frontend_start() any more.  The kthread that
follows is then the last one, and dvb_frontend_stop() waits for it.

No change to the fe->exit state machine is needed.  The thread that is
stopped through kthread_stop() records DVB_FE_DEVICE_REMOVED before it
releases fepriv->sem, which is what keeps concurrent ioctl() callers on
already open descriptors away from the driver, and DVB_FE_DEVICE_REMOVED
keeps the meaning drivers rely on, such as skipping hardware access on a
device that is no longer there.

Fixes: 1f862a68df24 ("[media] dvb_frontend: move kref to struct dvb_frontend")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes since v2:
 - remove the device node before the frontend thread is stopped and
   drop the fe->exit changes: unregistering the node takes
   minor_rwsem for writing, so no open can restart the kthread after
   dvb_frontend_stop().  Leaving the exit state machine alone also
   keeps concurrent ioctl() callers, driver power-down on normal
   unload and the DVB_FE_DEVICE_REMOVED semantics as they were.

Changes since v1:
 - do not mark the frontend removed in dvb_unregister_frontend();
   the ordering alone closes the race, and an unconditional
   DVB_FE_DEVICE_REMOVED broke hardware power-down on normal driver
   unload.

 drivers/media/dvb-core/dvb_frontend.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index d082b6c57c76..22d2e0112b74 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -3076,8 +3076,15 @@ int dvb_unregister_frontend(struct dvb_frontend *fe)
 	dev_dbg(fe->dvb->device, "%s:\n", __func__);
 
 	mutex_lock(&frontend_mutex);
-	dvb_frontend_stop(fe);
+	/*
+	 * Remove the device node before stopping the thread: dvb_device_open()
+	 * calls dvb_frontend_open() while holding minor_rwsem for reading and
+	 * dvb_remove_device() takes it for writing, so once this returns no
+	 * open can reach dvb_frontend_start() and spawn a kthread that
+	 * dvb_frontend_stop() below would no longer stop.
+	 */
 	dvb_remove_device(fepriv->dvbdev);
+	dvb_frontend_stop(fe);
 
 	/* fe is invalid now */
 	mutex_unlock(&frontend_mutex);
-- 
2.34.1

