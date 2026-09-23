Received: from zg8tndyumtaxlji0oc4xnzya.icoremail.net (zg8tndyumtaxlji0oc4xnzya.icoremail.net [46.101.248.176])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721A0443AB9;
	Wed, 23 Sep 2026 07:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.101.248.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147100; cv=none; b=Rgy4GAbDovo8j/c5cxaESLqrzijC8jyr8/2xiI5XiQ5NljkhdCXzJpZ9BBNMVmHqgR3+sq9flVQpb4LlOdtJlaPkPWE6vdKpQDN+UDnQblrIvOArHv5COjFQrS8ophdWThtOvkRj4/wI58FAqApYBSoNXLnXS+jjFpkXhSW8DlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147100; c=relaxed/simple;
	bh=r8a+4eNBHeysQqTYoRMI9KPT5zoninvrg+/ruGE+Y7A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z456Hc1AHMyDFDfsfhathyneIGUSvk0ISanE1HsyUOM7pcTF5Neo9zep0pfzKhyUKESJDtNy0T1h5byEDnEMd9glMAiw+vw2d6xFzitFB1n9pSnOVoVCyjRbmXR/pcdZbzJXzg+2PRe+c4zsEH6oNJjgbqMWxpZtlrJUaxVxwlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=46.101.248.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wBniigQerNqssgwAQ--.6034S3;
	Wed, 23 Sep 2026 15:04:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app2 (Coremail) with SMTP id zC_KCgBn2c4QerNqgwuWBA--.49072S2;
	Wed, 23 Sep 2026 15:04:48 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <fanwu01@zju.edu.cn>,
	stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] can: gs_usb: kill RX URBs before destroying the netdevs
Date: Wed, 23 Sep 2026 07:03:52 +0000
Message-Id: <20260923070352.487595-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgBn2c4QerNqgwuWBA--.49072S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?nWDCAQXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfncGSG+szpQCInt5Y8rbJUI2v+ZK8a/WB5UEqM6w+2CI+Ofbkec6KJ6j+2OqMEVpE9r+W
	Dfxwh6G2teOWOqFrYmmp9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoW7Zw47CFy5ZrW7uw4xKrWxuFX_yoW8uFW8pF
	srKay5tFWUXF1fAw1DJa1DuF1rAa97Aa47ua4Y9an5Zr9xA3W8JF1Fqa4j9rsrCFW2vFy0
	vr43t3y7JF13WrXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Gb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc804V
	CY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AK
	xVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48Icx
	kI7VAKI48JM4x0Y48IcxkI7VAKI48G6xCjnVAKz4kxMxAIw28IcxkI7VAKI48JMxC20s02
	6xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_Jr
	I_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v2
	6r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj4
	0_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8
	JrUvcSsGvfC2KfnxnUUI43ZEXa7IU86c_DUUUUU==

gs_usb_disconnect() destroys the channels one by one via
gs_destroy_candev()/free_candev(). gs_can_close() disposes the RX bulk
URBs on the shared parent->rx_submitted anchor only when the last
active channel is closed. With two or more channels up, the earlier
channels are freed while their RX URBs are still submitted, and a
completion in gs_usb_receive_bulk_callback() accesses the freed struct
gs_can and struct net_device.

Fix this by killing the anchored RX URBs in gs_usb_disconnect() before
the first netdev is destroyed, and in the error path of gs_usb_probe()
before the previously created netdevs are destroyed.

usb_kill_anchored_urbs() waits for running completions and a killed URB
completes with -ENOENT, so the completion handler returns without
resubmitting the URB. The kill in gs_can_close() of the last active
channel then operates on an already empty anchor.

This issue was found by an in-house static analysis tool.

Fixes: d08e973a77d1 ("can: gs_usb: Added support for the GS_USB CAN devices")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/net/can/usb/gs_usb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/gs_usb.c b/drivers/net/can/usb/gs_usb.c
index ec9a7cb..663746d 100644
--- a/drivers/net/can/usb/gs_usb.c
+++ b/drivers/net/can/usb/gs_usb.c
@@ -1595,10 +1595,10 @@ static int gs_usb_probe(struct usb_interface *intf,
 
 			/* on failure destroy previously created candevs */
 			icount = i;
+			usb_kill_anchored_urbs(&parent->rx_submitted);
 			for (i = 0; i < icount; i++)
 				gs_destroy_candev(parent->canch[i]);
 
-			usb_kill_anchored_urbs(&parent->rx_submitted);
 			kfree(parent);
 			return rc;
 		}
@@ -1636,6 +1636,8 @@ static void gs_usb_disconnect(struct usb_interface *intf)
 		return;
 	}
 
+	usb_kill_anchored_urbs(&parent->rx_submitted);
+
 	for (i = 0; i < parent->channel_cnt; i++)
 		if (parent->canch[i])
 			gs_destroy_candev(parent->canch[i]);

