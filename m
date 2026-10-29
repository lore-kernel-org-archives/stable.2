Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274167;
	b=EL4qA2oAMKkNQIeybvX6f/lQ/OR6YxQW91Z65J0h9bwnKkHHgB56lAasb93KMMt1p5RD
	 d9MvQ2qwuQp8+6V/p2GPILq3uvOeYTZAZnFqW3aQYQOIUUdxfJbhlcYlXdPrWFIN/MC+U
	 c4RqyG0S8Uys00zslJTuTL4M0WdqtVTp2MqD2bVTCaM23GrV8mQUxom3IuxUDkEYXOIWz
	 VtoJwqZ/A4l1yXaKKjNwx/uaWz4Zn6WHlGr9pwOqd1HaQF9HsifUghBKwykzBIbOjDxby
	 aTofn88aqNlXkktvkHJDGvrBtL8BUrnFCPgITFHuuiqwhhCiUts14JUkKet7zlKFHtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274167;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=pI00oraJcj1gbywxrmhhYEBArK86LZYRPpd6Xl7nY4g=;
	b=5cduaLbLVuUglHjjXSjb+ROJVUZmf1IV7ELVVrTWRpfGRQJ8LlIP8z9kBodViz1KLRA6
	 IV1bjnxChlQvKvDpUMMH3CGPggQIbL+LwtFMYKQTdFXk+hwMoSvAo3ayMfuOSu+LJzV4/
	 nmgKcR19rivTu+WrgBi0f+g4Y4FZz+vetE6AZ/XCozdfJpjSFKy8ItwU6rK+i0SqMmsIg
	 b57DKvXi8Od7vyHI4Xr9P1TjxwlPIQPEHEctT7KREbwuSz+sZqFBQYYS2kjaLQdqoAxe6
	 9uDqCpxRsLoYlzEGS0mVNDSrnpwd87HPdmT7YfsQ3vr5eaUSMP8H4NJlhDPjM39SKig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5A4606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 11:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E5A4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=pI00oraJcj
	1gbywxrmhhYEBArK86LZYRPpd6Xl7nY4g=; b=06zu+tJmM0REmTN/dpOzxcTI7Y
	y5leIPKkgHik+1rSZUpy4OHczZ9GOQOoMoR1iDTtsnXxcsUiB4NaJvUIUYCVLsXW
	IhtVtCy6AcnjRWJOW8ySkaC3OleyE8RlvdIaFhVaoLXWcNA8Ke+8EYctnvtZeHaj
	WVoRogEs62+G0R5ds=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.47])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkAWWwApMeNqI5P+AA--.64933S2;
	Thu, 29 Oct 2026 19:42:34 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: 2726988870@qq.com
Cc: stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH net] net: usb: lan78xx: only stop phylink if the interface is running
Date: Thu, 29 Oct 2026 19:42:32 +0800
Message-Id: <20261029114232.12629-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkAWWwApMeNqI5P+AA--.64933S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tF13Ar1UGr1Duw1DXFy7KFg_yoW8XFyfpa
	9xZFW7uryUtw1Du343Aw48Z3W5Za1qqryxCryj9wnYqwn8XFy7Zr92kr9xCF15AFW8AFWI
	yFnrCFW7uFy5Aw7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9qb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVWxJr0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8I
	j28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF
	1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxG
	rwCY1x0262kKe7AKxVW8ZVWrXwCY02Avz4vE14v_Gw4l42xK82IYc2Ij64vIr41l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjxUfw0eUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUBD2riEkGzyQAAso

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

