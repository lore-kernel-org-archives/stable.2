Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049763A0E86;
	Wed, 14 Oct 2026 02:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946491; cv=none; b=L4ASxsuO2j9aoNzDtFAP4oL9KOiSms0LM9S7dl9UfwGI9g9IQQAW2WM1/beaTa6cST56ht09k8R1P0LEuMNpDNsUh+cEc4j4krky1Q7RZPfpb0PKZT4yiUqjHDkWj3weS0irJzME+gOtuZxWK3ldJFqxeLB9gLJsSTczs7C8USM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946491; c=relaxed/simple;
	bh=FYMRP7jy+p8kLSXa9krCZ7hd9pP85ws5fXnZOJRaPJw=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=jkQ8foGQl+gVzPbcOWsW9glCok/5N/7Q9jWzbSpmnTUaxx/K2lVcpJy8t3GaDqnoCAktlow1R7ld50BVLe+N3aZJuyXgm0pIBy6K+hvlAVHSCeHlXDYkUsbrMs/Ws4EnUUXslmIo3PQchtgrGzKLQaeqQjf7cGFhnHevYh0tyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=p4GGPcp9; arc=none smtp.client-ip=203.205.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="p4GGPcp9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791946480; bh=rrsBLriRgC1EgL80ODJnHwyIwn1KvUDijJjv6Fz1IwE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=p4GGPcp9hmNOT7VRCgExfsOA9ZMqsJrZpGMZH8xcy/qFH3949NvkJkyFfWng2XQCT
	 PIZaIfbUsj/zd+ALJjqi97fb55++CtfpXX3WIlG48VriQ6CDEal1kBI9x5u18TzzSG
	 FQLKs0saKNdx+oYUHtXzy5WJZZ02VKZj4084u1X0=
Received: from ubuntu2204.localdomain ([2409:8d20:7f:35d:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D9F194D5; Wed, 14 Oct 2026 10:54:31 +0800
X-QQ-mid: xmsmtpt1791946477t7xfc84ol
Message-ID: <tencent_B15E13184DA04C4382F48848C006A2B51F06@qq.com>
X-QQ-XMAILINFO: N5UQ4LLbVXWPL282Toa2IMxmL68QeoSL/cfBpJlIlNWoy17a2y+V4vEH9aBaxP
	 HPVtgjaOhAA+m/x39+UfLBuFCL5F+koTsVOsMiAhGRfLOKOrXoD2bjXUauIykD717W7gyOcn0ToP
	 svMPzBTaMOxzGte5r9wpjz5VTNc8bR3rP8BR3zG6pBpzmokke0eQSTdQuBY4PPuW41tzu3eex/7K
	 +q5ElWy3zVjJLlI0+r7NFIsNa40Z5IC+ujcDT0dWqa4X8J/tAhGQ8SH24fBQhQPwP1oHpNal9h84
	 piau0KUO88uUsA3ac6B+r3iGBEwCwzNVn6JhH0+UYVXajptNex5I70hPPE0A3h6iQdWkaJrFyBc+
	 uvgWg3JUa+fEk/zq2z7n8bKGy7lqdA2iRfbEjy7X5nEyde9vl1+t0vNzFNHOIz9W4ItPNUNjx5KL
	 u8PxmV6Z9cslTzq4PRmfIm2oCvTDMBznjMQZI+Pvnzpczi9AZjnhMqJ+ERVfeTSdLAeFJrBXgsjz
	 K0MpzFxpeCmg5X8zSUYgGTM9k3y73E/7Yo12z8PmWGpYRfjelQ6/5k5CraF+GOdjjQir7v9l/j9z
	 ZHvzP7bTfow1/FLLavrdp18Uu0PI+5TqaBXzdhJE97nFVv4jWDkpm1azygi8TlEIDUq7BRn9W3uh
	 wYMp1Y3k0PfQ9D1jeWsg/sFV0FBLyXiKxAl3TgldFWeLzUjIej/N53KeBLJ8nyO69PKgRCQG5w8a
	 ev4/nrFyHdi8HD9QvbrVlc36QCgC9p32QzIDtmaBVt5K3MSjacuZAmgtjvZ7h/nLQL6P5Tfy2BzM
	 i1w0ZPEUh1DeeZ52pT8czg0wu1ERu/33zJLLmobo8xnv8Gj2PPJww1pVsnknuhjZIgLHzOaOVKyE
	 7yTrhxqWFWbYtDk+qWHK6BcMYxxDVDtRfZdhyVjG1W/nNUR36xSR7haR8jOMalPFBq9zFrW81AzR
	 yGeU/EuQD9oq/ZIa96vfCYJa+rYL67ZTWwlL0J+5afmqtlfGSSMb3RnUzUrKF8ufShkp39yaHIOi
	 KlnDaxhWnNPcsOYlGTwT5AoRvnrAdsNBud1JPxw+ijbJdFl4l09SQCHkvj1T6ILw7BtD5bFctPXX
	 UPdxfkVLPRAgwZy+ggrnPMD38Ylki1g/9e16nPgnhcBYHq46qfoM0I6OEL1nF3ERmqbEH39Qs263
	 xcFHJVwzAUY9IfSmIOuc/6LG7bpS/+FSlfQAk=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Cunhao Lu <1579567540@qq.com>
Date: Wed, 14 Oct 2026 10:54:24 +0800
Subject: [PATCH net v2 3/3] can: rockchip_canfd: cancel bus-off restart
 before closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20261014-rockchip-canfd-restart-close-v2-3-c8fbdfad1803@qq.com>
References: <20261014-rockchip-canfd-restart-close-v2-0-c8fbdfad1803@qq.com>
In-Reply-To: <20261014-rockchip-canfd-restart-close-v2-0-c8fbdfad1803@qq.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 "David S. Miller" <davem@davemloft.net>, 
 Wolfgang Grandegger <wg@grandegger.com>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, kernel@pengutronix.de
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 stable@vger.kernel.org, Cunhao Lu <1579567540@qq.com>
X-Mailer: b4 0.15.2

The close path cancels restart_work through close_candev() only after
freeing the IRQ, disabling RX offload and stopping the controller. A
running restart can re-enable the controller and its interrupts after
IRQ teardown, or restart timestamp work after it has been stopped and
before runtime suspend removes the controller clocks.

Call close_candev_cancel_restart_sync() at the start of ndo_stop(), while
the resources needed by a running restart are still available. The core
netif_running() check prevents a late restart from entering the driver,
while this cancellation waits for one that has already passed the check.
Keep close_candev() after IRQ teardown for the final cancellation and
echo cleanup, including work queued by an IRQ racing with the first
cancellation.

Exclude the IRQ handler while reinitializing hardware in the restart
callback: the handler continues processing after scheduling recovery,
and a shared interrupt can also invoke it while this controller's
interrupts are masked. Keep the shared IRQ enabled while the close path
waits for restart work to finish.

Fixes: ff60bfbaf67f ("can: rockchip_canfd: add driver for Rockchip CAN-FD controller")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/rockchip/rockchip_canfd-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-core.c b/drivers/net/can/rockchip/rockchip_canfd-core.c
index 37c1c22c40c9..fb8f6b067502 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-core.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-core.c
@@ -356,8 +356,10 @@ static int rkcanfd_set_mode(struct net_device *ndev,
 
 	switch (mode) {
 	case CAN_MODE_START:
+		disable_irq(ndev->irq);
 		rkcanfd_chip_start(priv);
 		rkcanfd_chip_interrupts_enable(priv);
+		enable_irq(ndev->irq);
 		netif_wake_queue(ndev);
 		break;
 
@@ -758,6 +760,7 @@ static int rkcanfd_stop(struct net_device *ndev)
 {
 	struct rkcanfd_priv *priv = netdev_priv(ndev);
 
+	close_candev_cancel_restart_sync(ndev);
 	netif_stop_queue(ndev);
 
 	rkcanfd_chip_interrupts_disable(priv);

-- 
2.34.1

