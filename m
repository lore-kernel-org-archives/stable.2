Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB974D0CE0;
	Thu, 17 Sep 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646332; cv=none; b=WcBkX85uNRYrIyssCri8nSqC/mKF6nRrEvgj3ItS17btOo1yeo1SFuajcCRCuCBEaxHXioc+n26hw51u6Ki6tP2r9o0Q76p3G96AQBZ/HwYhx1GYao/SAwNuaVzFTZjT4PFd8UaAxAf3qmHizrH3WyVKvRXJJvWu03YERFlapRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646332; c=relaxed/simple;
	bh=YqLFuJq396QQX7QY2JmqdsE0CwNv2C0DJlNzLta/S1A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VB49ITxxhGSEhy6bdnl5nBBwp0mjAyAgRaIkeZsMEYOi4EpfqO4HX4PKVmCpCrO5zp+qMZohIkKoL2+cFZp7D6BOOSENsR/PouIkCPJrVgGMTGBUSvtiI+SICL/U0zKKROUwka7L2Hp6KkRcdKTDZ5S8XpZohbi4l5ttERcLpbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3HzrT1atqqQmACA--.2301S2;
	Thu, 17 Sep 2026 19:58:11 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Rengarajan.S@microchip.com
Cc: Thangaraj.S@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	john.efstathiades@pebblebay.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] net: usb: lan78xx: Fix URB reference leak in lan78xx_submit_deferred_urbs()
Date: Thu, 17 Sep 2026 11:58:11 +0000
Message-Id: <20260917115811.2150119-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3HzrT1atqqQmACA--.2301S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF4rGr4UZF4rAr4kJF4kXrb_yoWkurX_Ww
	1UGFyDGryUArWqyr43KrsIvF4akanrXw1kur9aga9Ig34jyFnYvF17Aa9xArsrW3yru3WD
	Jwn8KrW5JrWagjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwAC
	I402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrw
	CF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E
	5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtV
	W8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY
	1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14
	v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuY
	vjxUquOJDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBgMNA2qrq3aE6gAAs5

usb_get_from_anchor() hands over a reference to the URB, which the caller
must release. lan78xx_submit_deferred_urbs() never does, so every deferred
Tx URB keeps an extra reference: the counter grows on each suspend/resume
cycle and the URBs are never freed when the buffers are released. Drop
the reference after submitting, and on the path that drops the packet
instead of submitting it.

Fixes: 5f4cc6e25148 ("lan78xx: Fix race conditions in suspend/resume handling")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/net/usb/lan78xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bcf293ea1bd3..8e075a31d97c 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -5204,10 +5204,12 @@ static bool lan78xx_submit_deferred_urbs(struct lan78xx_net *dev)
 		    !netif_carrier_ok(dev->net) ||
 		    pipe_halted) {
 			lan78xx_release_tx_buf(dev, skb);
+			usb_put_urb(urb);
 			continue;
 		}
 
 		ret = usb_submit_urb(urb, GFP_ATOMIC);
+		usb_put_urb(urb);
 
 		if (ret == 0) {
 			netif_trans_update(dev->net);
-- 
2.34.1

