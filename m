Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2915B39A07C;
	Wed, 23 Sep 2026 03:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790132790; cv=none; b=RO+cwRMr1OD04wM8w4sLPc30jeQvR+MEDsGGfcDmNIDgDpmo+vnaUkEIDlsbPv64w+vmhFnvzEEms4lb1brKStWSMVSwjWg01DBW7P/QkmNnDBMzXbrEl4KrqzPDWoaHV3SwH2QyME3M1jcMF2IcUONRUSODfEU73VVgC3ffXms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790132790; c=relaxed/simple;
	bh=3EwO0EYw+mTOrYwxnMMWjIll/hMQ4/gaQ+s4Bdl4ogs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TiZ+hT4/xXd2S8CihYaP3ND2iCdQimEa20DqUH0ed4XuzKCulYMa3Zf1UIOAUZjSgL5W/zCdC4NYor9J3V+J7XdTwKnsSo4JRjW//rQ5pxjDLkSJTlOLIfI/S0CCqGc7anGXJACSViirq6555MAZ+wH1zn4yj/HyHN6EK5dsk0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wCXrnwpQrNqTyEwAQ--.4422S3;
	Wed, 23 Sep 2026 11:06:18 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn+tApQrNq+G6VBA--.59138S2;
	Wed, 23 Sep 2026 11:06:17 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] can: ems_usb: use usb_kill_urb() to stop the intr URB
Date: Wed, 23 Sep 2026 03:05:22 +0000
Message-Id: <20260923030522.409344-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn+tApQrNq+G6VBA--.59138S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?CXGSCgXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2UqrLr6gmX1sihfTAW2cmoodJqjuNKbeRhRo4tkDIW+azR
	+UQ4jbHZXGTvhIGllkx/fhSXRnQnisA2hkqkTVk6
X-Coremail-Antispam: 1Uk129KBj93XoW7uw18GF1kKw48ZryxXFWrWFX_yoW8Aw43pr
	Z29Fn0yFyDWr4YvanrJrsrZF18AanrAry5CryI93yruwn8X3Z8Gr1UK3ya9ayDZrnxAFyj
	vrZ8Jw4Uua98G3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24l42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rV
	WUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
	JbIYCTnIWIevJa73UjIFyTuYvjxU2LIDUUUUU

The intr URB submitted in ems_usb_start() is not anchored, and its
completion handler ems_usb_read_interrupt_callback() resubmits it, so
it stays in flight as long as the interface is up. But unlink_all_urbs()
stops this URB with usb_unlink_urb(), which only initiates an
asynchronous unlink and returns without waiting for the handler.

The handler can therefore still be running while ems_usb_disconnect()
frees its data: it reads the transfer buffer dev->intr_in_buffer, which
is kfree()d there, and dereferences the private context, which is
released via free_candev() together with the network device.

Fix this by stopping the intr URB with usb_kill_urb(), which waits
until the handler has returned, so the frees in ems_usb_disconnect()
happen strictly after the last callback.

The handler treats the -ENOENT completion of a killed URB as terminal and
does not take RTNL or any sleeping lock, so the resubmit loop is cut and
no RTNL deadlock occurs.

This issue was found by an in-house static analysis tool.

Fixes: 702171adeed3 ("ems_usb: Added support for EMS CPC-USB/ARM7 CAN/USB interface")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/can/usb/ems_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/ems_usb.c b/drivers/net/can/usb/ems_usb.c
index 9b25dda..9ffb195 100644
--- a/drivers/net/can/usb/ems_usb.c
+++ b/drivers/net/can/usb/ems_usb.c
@@ -705,7 +705,7 @@ static void unlink_all_urbs(struct ems_usb *dev)
 {
 	int i;
 
-	usb_unlink_urb(dev->intr_urb);
+	usb_kill_urb(dev->intr_urb);
 
 	usb_kill_anchored_urbs(&dev->rx_submitted);
 

