Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619027;
	b=iAG0HfgBAik/b6iSsj0waQeSKg52BbPT2Yf69Sl4y/GANQ9IKaNEzh5f2enbniksvCVB
	 7yuAVDshHsHWDgmcgFlcC9I7EaHq7Q/VkbQRDG21HapblqrN2H8nu7jQ9gMO/NQO54bXB
	 Oo3k5vJaa7Vrj6kq5fixVYnG7/4xfvpJRxYBQFqtuNxjJQdqcOiXDqH6b8oFdOmidXkdm
	 IrvSECfHvC1q7Ggsn05iPRNL9zSrCusQjBkXYyjPfacgqS6qqczgVkB7MEJUkxxrSvQJx
	 V8LUNEaF9Go3gGJfX4AgEs/yBux957tPVIKVn6aknUCdIqPpa2kdnJMM6Bdw4snf4Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619027;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Vl3NSKsKg/CSQtal7pauAg6RMNsPj+Y+d5jOU6wQ3IQ=;
	b=BWClisRx7J9IKv+Es+oBnR3Q+MzaMzn68XGdfPGPXu3nCbxTSwAaGYIJjh0UGQ9ajHMV
	 lHM0BvxZyS1Elr/gOZIIU68wV1dj8tL/+POJ6Vki+Y3sXOU/pMO/WyiZsM5HKyc+GzqsH
	 1Vc+zAm2a7YdFlSVybN6yulHuCduDKcTFmm4wmBSMg0kxY4U/o2MngjYbwzLW/luCk3gE
	 MVR355W0bPbx0M/B6wuOpk5WbvaKkrwBfoP63m5HCeBi9id6rVhvZ883sGzyPqdRLFMMk
	 LCoWBVtCkSaQlWJ48HvnG9BOnFlrulypI9kvGac7s1CFAOkvwqCkdEx4lpncP04iWpw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5645E60A2604;
	Mon,  2 Nov 2026 11:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5645E60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=Vl3NSKsKg/CSQtal7pauA
	g6RMNsPj+Y+d5jOU6wQ3IQ=; b=L01u+KKXYyEQku6VGiV2GuBf3REy297ILf5NU
	bLzTolHMDe3mS/DBPWaRL5Mpmo3prSwgR2khUX8AK+tSr9ZUp9OSr+a+7d/25kCN
	cqJbgpKSIfI06L0pUD1RzsApSAnlP2c9pvUW3LbMWymTmYYpJBQCm1Tp/tZ9eL1N
	R4H3Zo=
Received: from [127.0.1.1] (unknown [113.200.174.101])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2fw3dOhq_AMZAQ--.23074S2;
	Mon, 02 Nov 2026 19:30:01 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: sashiko-bot@kernel.org, Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 stable@vger.kernel.org, Bin Yu <byu@xidian.edu.cn>,
 Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the interface
 is running
Date: Mon, 02 Nov 2026 19:29:59 +0800
Message-ID: <179361899931.4450.17435057020255203640@stu.xidian.edu.cn>
In-Reply-To: <auhgcS6p-HDFYd7x@pengutronix.de>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
 <sashiko-outbox-191206@kernel.org>
 <179346555447.2831.9240931140716315096@stu.xidian.edu.cn>
 <auhgcS6p-HDFYd7x@pengutronix.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:BbQMCkDW2fw3dOhq_AMZAQ--.23074S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWw48Gw1rAF1kWFWfJr4ruFg_yoW5Xr4xpr
	W5G3Z8Cr4DJryaga17Xa1UAFy5uwsFk3y5Cwn8G3yYqw4YgFyaqr9Fva4DA3Z8CrZ5Xa4I
	qr1FvFWrCayUGF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9mb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28I
	cVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx
	0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402
	YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5sj8UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdSm9wAAsT

Hi Oleksij,

Thanks for testing this on real hardware - that is worth much more than
what I can do here.

To answer your question first: I have no LAN7800/LAN7850/LAN7801 board.
I test on a virtual device that closely matches this driver, generated by
an automated virtual-device generation tool we are developing for this
purpose; our plan is to run targeted tests against all USB drivers in the
Linux kernel with it. The WARN reproduces reliably there, but I cannot
tell you how the patch behaves with a real PHY.

You are right about the interrupt path, and it is a better explanation
than the one I gave. 30a41ed32d30 removed config_intr() and
handle_interrupt() from the internal LAN88xx driver, so
phy_drv_supports_irq() is false and phy_attach_direct() overwrites the
irq that lan78xx_phy_init() has just set:

  drivers/net/usb/lan78xx.c:2896	phydev->irq = dev->domain_data.phyirq;
  drivers/net/phy/phy_device.c:1854	if (!phy_drv_supports_irq(phydev->drv) &&
  drivers/net/phy/phy_device.c:1855	    phy_interrupt_is_valid(phydev))
  drivers/net/phy/phy_device.c:1855		phydev->irq = PHY_POLL;

phylink_bringup_phy() then skips phy_request_interrupt() because
phy_interrupt_is_valid() is false (phylink.c:2213), so nobody calls
request_threaded_irq() for the mapping, lan78xx_irq_unmask() never runs
for it and the PHY bit is never programmed into INT_EP_CTL through the
irqchip. So for the internal PHY the PHY interrupt path is dead, and my
remark about lan78xx_remove_irq_domain() was describing a path that does
not execute in this configuration. Thank you for pointing it out.

That does not affect this patch. The warning comes from phy_stop()
reaching a PHY that was never started, which has nothing to do with how
the PHY interrupt is delivered, and the patch touches no interrupt
handling at all. It only moves unregister_netdev() ahead of the phylink
teardown, so that the interface is stopped by lan78xx_stop() when it was
running and not stopped when it was not. The dead interrupt path behaves
exactly as before with the patch applied.

It is also only dead for the internal PHY. For LAN7801 with an external
RGMII PHY (lan78xx_get_phy(), is_internal = false) the PHY driver can
provide config_intr and handle_interrupt, and then phyirq is really
requested.

I kept the change small on purpose so it can go to stable. I would
rather remove the dead PHY interrupt plumbing for the internal PHY in a
separate net-next patch than mix it into this fix.

If your test still produces the warning with the patch applied, could you
send me the trace? Then I can see which path it takes on your board.

Thanks,
YuanZhe

