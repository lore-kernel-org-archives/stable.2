Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793465563;
	b=dRJ2oeUfJC8MzBqnG5dC4KZjBzaGEOmuRjVUJTnO5ci5B3jOjBe33BJIuNyLd1To3pmc
	 X+a11X8xHgIvA+Muv61WYHZI8WyZDBp4Y+QwIPxT5LR3HwhpPuwODtR32E1QdjdFupwiX
	 MTVIze1Ra24XnZKKMekcGvwZkUKt+1q6Bul7e/9T6TFbE/jw2vd6Lxvs7Jqr3bRlm8BA0
	 IOL0sULvmHan+N01aDzsNQJ8Slig4HODb1f/HIy5U5EbmQFvVwy9bBgiPCGzyWY/LjBx+
	 AdjnHBNelyIDkhumsw5AzWzaZuhL3Ya5hAc8y/FIZmxKSVmlmc3EiCLV8798hs0fHew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793465563;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=CpDc0Fd22BqQEPmxXBfznc+cqZ7jBDRaBjmgcOMLibc=;
	b=V4jsouKPRahguKKlW1Bg+u2cp5gXBjm31xvG8pudDbgOmSCz3yrfm+fbaAuIqqfOnAjo
	 LSSrr/ctM2E7rStZP6ht6givT4r4ot61qIG1uBuQjUqvb/gwsP38G9A9uxUIjVeZ/5tAS
	 4rFfIhxtJzNPw1G1SCduJiZuuqifJXXbijVCgep/2Hk94NmXccgyS81IbIZLRwHbaK7B/
	 hTXzPjszW7Xif+2OmLSZRHIqZoO/uXS/d5yt73ocPdmpx3Rb/50slbheTJ5rtL9uwDR04
	 0zgO9svoPHxTeZ2S7JZIBLDunR7njbMGo3rSZ/vnAuZ+hj8FEZOSnyOeRqj5G09OZ0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E1B606A324;
	Sat, 31 Oct 2026 16:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80E1B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:In-Reply-To:References:Content-Type:
	Content-Transfer-Encoding:MIME-Version; bh=CpDc0Fd22BqQEPmxXBfzn
	c+cqZ7jBDRaBjmgcOMLibc=; b=T5sYcNR/jMy6+H3qUN4QOSbcQviy5xXnhGwma
	K5HOYY0iTLbjy8/eVzpXbFOEZuzJOYbB65Q8xEIYCL9QCsCNtsMRA0itah07j2O/
	OBoT+MhTnMKlhhCZ1KnCOS0ijDU18klAIC13kY72Xi1GmVq10GZLjXawT29/yVBN
	hA52mk=
Received: from [127.0.1.1] (unknown [113.200.174.19])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCm7gPSHOZqMBoSAQ--.18634S2;
	Sun, 01 Nov 2026 00:52:35 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: sashiko-bot@kernel.org
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
 UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>, Russell King <linux@armlinux.org.uk>,
 Oleksij Rempel <o.rempel@pengutronix.de>, stable@vger.kernel.org,
 Bin Yu <byu@xidian.edu.cn>, Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH net] net: usb: lan78xx: only stop phylink if the interface
 is running
Date: Sun, 01 Nov 2026 00:52:34 +0800
Message-ID: <179346555447.2831.9240931140716315096@stu.xidian.edu.cn>
In-Reply-To: <sashiko-outbox-191206@kernel.org>
References: <20261029160204.2567-1-25031212351@stu.xidian.edu.cn>
 <sashiko-outbox-191206@kernel.org>
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
X-CM-TRANSID:BLQMCkCm7gPSHOZqMBoSAQ--.18634S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1xWry8Ary3XrW8Jw1UKFg_yoW8ury7pa
	y7KFsrWwn7Ar4rury3uw1UuryUZF1DJa4xAryYgrySvw45WF929r4xtryxA3W3CFsrJa12
	yw1fWayvvFW8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxG
	xcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r1l42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUkFApDUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUDD2rmBsIMBQAAsK

On Fri, Oct 30, 2026 at 04:02:36PM +0000, sashiko-bot@kernel.org wrote:
> Does calling phylink_stop() and phylink_disconnect_phy() before
> unregister_netdev(net) in drivers/net/usb/lan78xx.c:lan78xx_disconnect()
> cause out-of-order teardown, a duplicate phylink_stop() call, and a race
> window when rtnl_lock() is dropped?

Yes, the ordering is wrong. v2 drops the explicit phylink_stop() from the
disconnect path and unregisters the net device first:

	unregister_netdev(net);

	rtnl_lock();
	phylink_disconnect_phy(dev->phylink);
	rtnl_unlock();

unregister_netdev() closes a running device, so phylink_stop() is done by
lan78xx_stop() with dev->dev_mutex held and after the TX/RX URBs have been
terminated, which is the same sequence as a normal ifdown. When the
interface was never started no phylink_stop() happens at all, and that is
exactly the case phy_stop() complains about with "called from state READY".

This also removes the second phylink_stop() invocation and the window in
which the net device was still registered with no PHY attached.

On the remaining points:

- The duplicate phylink_stop() was harmless in practice, because after
  phylink_disconnect_phy() pl->phydev is NULL and PHYLINK_DISABLE_STOPPED
  is already set. It is gone now anyway.

- The PHY interrupt is not released by phylink_disconnect_phy(). The virq
  created by irq_create_mapping() is disposed in lan78xx_remove_irq_domain(),
  called from lan78xx_unbind(), which also clears dev->domain_data.phyirq;
  lan78xx_status() tests that field before generic_handle_irq_safe(). The
  intr URB is killed later in lan78xx_disconnect(), and that ordering is
  unchanged by this patch.

- Andrew also asked why the Fixes tag points at e110bc825897: that commit
  added both the phylink instance and the unconditional phylink_stop() call
  in lan78xx_disconnect(), and

    git log -S'phylink_stop(dev->phylink)' -- drivers/net/usb/lan78xx.c

  shows that the line has not been touched since.

v2 is sent as a separate thread.

Thanks,
YuanZhe

