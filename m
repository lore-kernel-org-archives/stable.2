Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793510811;
	b=A6GbFFzt0iASjrmfLihhZ4ss3hfnNqWU0V0YvYDl0AwceGnboS9WJoLPhdvIzZgtunTe
	 CU91k8xdpqd6pwTgiShm7AsIN8UgTbHqLyFmJrnHFI6ADBJJD9/ZMPo9p1+LYS5zf/fey
	 lfsXCT5jfBj5Pdmpo4VU6yAupMqz3BHZ5cSW+emsgE20hBr2p5pSvxOWYNqxnhduxYpxn
	 VXPPB/STHKsBp2Wwl+uPAC2XjqxgtCypQWC6aDyXHBi2oMZ+HzZwP3bZsLcGI5Bcbka6g
	 /1LOvwQTpja9hqHWlpmocJXJmfUlRjpPFYfF2XiJ1qrncZQVhsYlRCYy/7w2L/ya1hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793510811;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=gM3q15/BMiP6EHVsNFcvdv86I1H+gIVZ8AKY9O890iw=;
	b=tXNEh88p+GWeX3CCex0d5lr7KsLEDfa86YibOQSZKz3OzWdho0OvslidN0iVdxXCeuyK
	 EwCxWAsbpKaDNiX035Zh0eHeAnUXcSKUsbZquslIr3/cMH/kXdcek1yerl+zt7qluoQah
	 cWyFJ3RKwYyrLQweRuoBAB1/FcQdTEBer7Y5zCD9ezDmFIXkTpHvmb2rk29vbhM3z6Pit
	 Jr0pR6JH61q8TZ9r2G0oOOZMCTS1j8JYmsDfpmgJ3BXWL0u8vL9hNV/FI+52ndow9maNa
	 YPR3cKWgcgHHwECxMXyydVJ+YR7b74KhW3wX8A6NVUPDo7hpbTIjAlLAqe2A9+sAOQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D590606A324;
	Sun,  1 Nov 2026 05:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D590606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=gM3q15/BMiP6EHVsNFcvd
	v86I1H+gIVZ8AKY9O890iw=; b=DcTmpEt6tu5MPIYYUmzCQvTDZfthEoxo2ZpI8
	5oir9rrGWoNToWurvWVNwEHj68b2fO49plEFm06tsK1eBQSEp8w5vbFJAzpvvYq5
	GO03IoZaqsQMupFzAc05qgb3jOj/TFbGiOSvCnEOS2+l7XVIFEU0l+SIczKEfSPx
	zWHv6E=
Received: from [127.0.1.1] (unknown [113.200.174.23])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkD2FPuEzeZq_Z0UAQ--.15833S2;
	Sun, 01 Nov 2026 13:26:30 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject:
 Re: [PATCH net v2] net: usb: lan78xx: let unregister_netdev() stop phylink
Date: Sun, 01 Nov 2026 13:26:28 +0800
Message-ID: <179351078879.2591.15287457752530436149@stu.xidian.edu.cn>
In-Reply-To: <e71cccdf-59e5-407c-b536-9dd47a49b0a7@lunn.ch>
References: <20261031165213.2738-1-25031212351@stu.xidian.edu.cn>
 <e71cccdf-59e5-407c-b536-9dd47a49b0a7@lunn.ch>
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
X-CM-TRANSID:BrQMCkD2FPuEzeZq_Z0UAQ--.15833S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4UCFWktr1UGF4xGr4UArb_yoW8Jw45pa
	s8ta97Wr4vyw1S93s5ZF1UZw15AFnrZrW3Cr90grWrX345try7Jw40qFykZF1akrsxA342
	vr13CayUuFZ5J3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Cb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr
	4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07b5sj8UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUED2rmBFRXBAAAsA

Hi Andrew,

Yes, I did, but it ended up at the bottom of my reply to the sashiko-bot
review, which was not the right place for it. Here it is directly.

e110bc825897 is the commit that introduced the call which warns. Before
it, lan78xx_disconnect() did:

	unregister_netdev(net);
	...
	phydev = net->phydev;
	phy_disconnect(net->phydev);

and phy_stop() only existed in lan78xx_stop(), guarded by
"if (net->phydev)". So disconnect never called phy_stop() on a PHY that
had not been started, and the warning was not reachable from this path.

e110bc825897 converted the driver to phylink: it moved
unregister_netdev() after the phylink teardown and added an
unconditional phylink_stop() before phylink_disconnect_phy(). Since
phylink_stop() reaches phy_stop(), which warns unless the PHY is at
least PHY_UP, unplugging before ifup started producing "called from
state READY".

	git log -S'phylink_stop(dev->phylink)' -- drivers/net/usb/lan78xx.c

returns e110bc825897 and nothing else apart from my own change, so that
line has not been touched since it was added.

This is also why v2 puts unregister_netdev() back in front: it restores
the pre-conversion ordering, so an interface that was never started is
not stopped at all, and a running one is stopped by lan78xx_stop().

Thanks,
YuanZhe

