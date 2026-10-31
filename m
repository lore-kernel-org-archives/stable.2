Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465556;
	b=BxC4PZJYhOeNYU2HOLYMrVMYniMnONk26dMuKMsryYN5WaGPoBJVaCUJG8LFCu72Cox/
	 krkQc6pnmtANuUg5I7niTnfRKtk50qBAM0ZJ7EuEtNkDTEzmPrUL/YqX2Jh86Uo93ofD0
	 XoK/GMYpBpOlKUIlhOtw3gbG9zv/gnx+ibNtKg/YiEgKVT5hQf8Qe407RqTuSeJaiAsl6
	 ohuI3pJyxqqhMF0g1ajPbTbY2gmpxqnLgLClwctcvh2XMoNkd24VjKkgJnQyp96a62rI2
	 QJflioVqn9XPYjFj5QR05lqWO/RSDjy10L3ZVHkcR0HBGEOt5QMIRV+WLGfG4+57Lug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465556;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=v+y6TvZyfAi7jMcHGnrG1M01lrtsY7nvRZmenSZzNE8=;
	b=EUSsrH8sQOMwAyOiiEqmNGM7lSMn1nbm8ujWGa4mcmHmvTqU400FAYiDtuVXTr/UhiVu
	 qPa3Y19esjNWyxG+ov77skK3lUMQK0L+J3mL3t2AvQlYn2gSAHMwoW6WFUgd8oG1EdHvL
	 3Nf1pR4ldg/wOdjQuXNyUb12gPoWvc6GG9wH9HMrRT4HXanWoHVpGhoWh4CasVcEfxs5g
	 a+UTGTlHwfrSXkqjxIXp05qcQwHYF8PxwHVpiwDCigKbbYwo7S2XeJJZF3wsq+sPY5oVR
	 WKOfbJi7SgvL0qLs/TNdXYClUlaTTztQZbGJgRHOYpPIZ7W9S8G78ckh6bLOc9hxCzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72539606A31A;
	Sat, 31 Oct 2026 16:52:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72539606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=v+y6TvZyfA
	i7jMcHGnrG1M01lrtsY7nvRZmenSZzNE8=; b=dQ31JVYMKncRqQbmiwvF9MgVLL
	GEJygIiMd1WZ9GJmFfDywKCYS4KLQEaarY2w6wp4RM5+UnBF6I64eIDQMvT2Jrqk
	Vxx9mUqqCUkjYKFmPjKo+yVB1iLh4KMJlpJm9M4dTYfH88ZZ7tq94/WGNZpy2C5/
	sylGnYLDWbHiB+Pic=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.19])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkBmigC9HOZqRVESAQ--.14215S2;
	Sun, 01 Nov 2026 00:52:14 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Russell King <linux@armlinux.org.uk>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop phylink
Date: Sun,  1 Nov 2026 00:52:13 +0800
Message-Id: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkBmigC9HOZqRVESAQ--.14215S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1fGr4rAw17Zr4rZry3twb_yoW5Jw13pa
	yUCFWa9ryDtr1DuF9xAa17ZF15Z3ZrJry7Cry5W3yFqr4DJFyIv3yxKrW7Z3W5CrW8AFWI
	vF13Ja1UuayrC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIZ2aDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUDD2rmBFQNYAABs4

lan78xx_disconnect() stops phylink before unregistering the net device.
phylink_start() is only called from lan78xx_open(), so when the device is
unplugged before the interface has been brought up, the attached PHY is
still in PHY_READY and phy_stop() reports:

  called from state READY
  WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380

The same warning is emitted after an ifup/ifdown cycle, where the PHY is
already in PHY_HALTED.

unregister_netdev() already closes a running device, which calls
lan78xx_stop() and phylink_stop() with dev->dev_mutex held and after the
URBs have been terminated. Unregister first and disconnect the PHY
afterwards, so the interface is stopped exactly once and only while it is
running, and the net device can no longer be opened while its phylink
instance has no PHY attached.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
v2:
 - Drop the explicit phylink_stop() and call unregister_netdev() first, as
   pointed out in review. A running interface is stopped by lan78xx_stop()
   with dev->dev_mutex held and after the URBs have been terminated; an
   interface that was never started is not stopped at all.
 - The PHY interrupt mapping is released by lan78xx_remove_irq_domain() in
   lan78xx_unbind(), not by phylink_disconnect_phy(); that ordering is
   unchanged by this patch.
 - Link: https://lore.kernel.org/r/20261029160204.2567-1-25031212351@stu.xidian.edu.cn

 drivers/net/usb/lan78xx.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..c1f3141326ac 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4580,13 +4580,12 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 
 	net = dev->net;
 
+	unregister_netdev(net);
+
 	rtnl_lock();
-	phylink_stop(dev->phylink);
 	phylink_disconnect_phy(dev->phylink);
 	rtnl_unlock();
 
-	unregister_netdev(net);
-
 	timer_shutdown_sync(&dev->stat_monitor);
 	set_bit(EVENT_DEV_DISCONNECT, &dev->flags);
 	cancel_delayed_work_sync(&dev->wq);
-- 
2.34.1

