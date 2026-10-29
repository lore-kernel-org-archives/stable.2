Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793289751;
	b=FCvHpQIOs/7J+90RHODnM3EMFXqz6mClyauZ3BXqpg6il70n5iFuRgcaE/hWx1nzTAUL
	 kAMQZ075Iwl+iSUu7Jn4Rch46gAsgVsTEkMwCgWzetzrA/uQRcDEh7r2Q2L+h3Vba8QZp
	 EhlyfcT/1Crex2Alj5EdqkVZIxl59kpEQkR5K40BvEBP4bkVlSOqMd2rrz5TBnPLztE9x
	 9TpdQlXm6xu5swJ1ecW96lf7GwSztB/bGo5Sm7dkeOcYGLW9q9lPBMOY17+ks4mngtSM/
	 DSNRgLo5SAI9dUXMZaKV7JgChQMUz8FWB9e5a/BHuEUCNcR4f1GVRbGuyWPHFR9vINA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793289751;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=pI00oraJcj1gbywxrmhhYEBArK86LZYRPpd6Xl7nY4g=;
	b=ylBiAxe9jLRoc/Hmz5hFglWpMk5xYJOOtHuLsexq2Rg1e663bqXKxaVwgOErx7GCF39e
	 NdPAW0xP2b5wylojnaG4K+lk3vxy/xMqdyt6Kw8am3HStsx34DrtBBG+Y2q+fR5qxLx0s
	 2gRjImNi1JNPypH/tUiIX/q9mnCo6IfjN10RR5jjaTisfa8VJN8gGwB6auNOp2f1H71vA
	 4S7kVgLFxUXNOKzhjTV4Sl7/3uKGUJRHeFX80ecoFhLIE7L0MLHTvXR1IBc7N/deImbZM
	 dxaRlDWSlpL8uA+NiI0MwqAR2ERrAol/a8PwOMGq37PWT8LFcCzapwiGXLLxqWNq28Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21EC606A335;
	Thu, 29 Oct 2026 16:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B21EC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=pI00oraJcj
	1gbywxrmhhYEBArK86LZYRPpd6Xl7nY4g=; b=ps7AKoiNveu4MzEsQFvViVHnWn
	JdQiO3yg3+yyHAlqHQVNmLVREJmdfOuvdC7z9GfFUM7Cs09WuPDWZlzcY6/mfqhI
	eFCy6rhAGN8fkPclZ9Ka20fDLHZBF2sfgRqgl8VgAlAaBuk8R8Mixitfg65rEjD7
	vBlWADMMzo/zIDsYI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.38])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkBWXgH8beNqsp8AAQ--.1728S2;
	Fri, 30 Oct 2026 00:02:05 +0800 (CST)
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
Subject: [PATCH net] net: usb: lan78xx: only stop phylink if the interface is running
Date: Fri, 30 Oct 2026 00:02:04 +0800
Message-Id: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkBWXgH8beNqsp8AAQ--.1728S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13Ar1UGr1Duw1DXFy7KFg_yoW8XFyfpa
	9xZFW7uryUtw1Du343Aw48Z3W5Za1qqryxCryj9wnYqwn8XFy7Zr92kr9xCF15AFW8AFWI
	yFnrCFW7uFy5Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBmb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	FIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wrylc2xSY4AK67AK6r1l42
	xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWU
	GwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI4
	8JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4U
	MIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I
	8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUfjg4UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2rjY8EGvQABsY

lan78xx_disconnect() unconditionally calls phylink_stop(), but
phylink_start() is only called from lan78xx_open(). When the device is
unplugged before the interface has been brought up, the attached PHY is
still in PHY_READY and phy_stop() reports:

  called from state READY
  WARNING: drivers/net/phy/phy.c:1670 at phy_stop+0xad/0x380

The same warning is emitted after an ifup/ifdown cycle, where the PHY is
already in PHY_HALTED. Call phylink_stop() only when the network device is
running, which is when phylink_start() has been called.

Fixes: e110bc825897 ("net: usb: lan78xx: Convert to PHYLINK for improved PHY and MAC management")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/net/usb/lan78xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index 5655941f1478..68e61004b3d7 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -4581,7 +4581,8 @@ static void lan78xx_disconnect(struct usb_interface *intf)
 	net = dev->net;
 
 	rtnl_lock();
-	phylink_stop(dev->phylink);
+	if (netif_running(net))
+		phylink_stop(dev->phylink);
 	phylink_disconnect_phy(dev->phylink);
 	rtnl_unlock();
 
-- 
2.34.1

