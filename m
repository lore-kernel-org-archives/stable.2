Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F48364935;
	Wed, 14 Oct 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791946486; cv=none; b=X+sUNL1mHZ4jPn0aP01RwHTlHN2lbJPdDplbTSgn5nD/lOARWiRZegCrcKWgA5UFs3ecj7N5MAfm5AyF0xu810HiqaPmPujTG08siKDP0Fi8fxf7jdXAfTC0JKChOup+X/mzsLqUuOvoOlj3RFRq5k2Qc5U/6OqyLcLOBVqUwQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791946486; c=relaxed/simple;
	bh=uB+Pk/mygKqGhQYSoYzTiXpubbzalD/v2yRTUeNfoh0=;
	h=Message-ID:From:Date:Subject:MIME-Version:Content-Type:References:
	 In-Reply-To:To:Cc; b=XyPHA/zeRM2A8mHKQ5sZitkpbX+pmsiGfXFrLxKIGpA27AjyNJ6xYIBcAfIRn6tpmEqLGWkWnAw4AUk1OVSf3sUOudgg5m9nlMloLlaFKoFlt/myp6bdMTnQlWOjk79BWkEKDjM+OCqwG4ZK9YoetzCb0c8YaWu+lha4iLM+Gd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=KAVCdpnn; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="KAVCdpnn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791946476; bh=bkxb/SSvWmoJe26HTtHwdhNk0MSZX0RLO3LLp8B2RzA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KAVCdpnnmDhYevQxOc0Mow5176er9Wiy+bMzWBp5zLm8y4FMP+K4YgyE2cScY7rrZ
	 940RNd1HTiQWBjWxvGXhwoPUMhXEYsw8y/cDwt3rhyevvFUop4P0IKaf1CbJrh0sNh
	 yOYDWV0WDNmmYHEZ8SLu9kjarvVc5kFVw/d+5DvQ=
Received: from ubuntu2204.localdomain ([2409:8d20:7f:35d:9e54:40ff:fe02:3f0f])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id D9F194D5; Wed, 14 Oct 2026 10:54:31 +0800
X-QQ-mid: xmsmtpt1791946473tjd2h8u74
Message-ID: <tencent_196A2433801631CD2FA42998465E26316105@qq.com>
X-QQ-XMAILINFO: OW/hvONf2Ob/Fv5PtXrSHO3o8leLMIOT/zbKLJ/ZSXvI26/6VVSH6VIIkOITCM
	 wfUEePpEWQfE55IMcuu4zToWE/qxBFV+Yd28b+4uOYxUV3FsXhkwLTxDwlOwhkSREjC7/00ZjFT9
	 mU+n5XpEbBymlsM24cCMOxLmgdM9F9Lz8O2hb1qSz2uC+D9z4eX6dXX5hRBYqhQZxcGY+AaAfkwx
	 cIU7oXoGQUEjToTAtiGDEemkD/WzXN5B655eZ/zRSFcE3JvdklQawptKNSpzZ4xZH8dumVC5uEZV
	 /vgM1kZKGcio8KUVwCNyOfF7awGzxLWD2sPL9UdNkEWDPTT2Aa6lLR480JIrpLBJejEQBjprxucS
	 kCosNiBBJL4HC7MB07p6YTYsZjBU4hQta/uVefNghRPd1fyPVBiOUAu432RKZ60fPInuDfeUMJAn
	 YymOtMTgv/Wc//KNi03yt/Bb1UiCZZu2RDQPzupn8yl+2aJja7gCV6ZYy7ce+nDagMnO0eVXVy4X
	 CRMk549afx7NHo+5uzhyx1qPulU74NSeV9Q41mRYiINKeB38btaalJrl37THto55EKNtqhozGnCg
	 peFyRhNgXbSEcur/ptLaYvRn5ASdZ8SzfaGYG+OMORvJScx5F62j3dVhe45Yl/v12OPWwEYhoe4O
	 8cld1rBKNI+gwLCdgdiBVCCsHWwiIPdJT3jZYxAVfapOBcY9zxzhaV7V6+K8HOlP605UiCgIQMsD
	 v1CWXM7wigTZJ/6MPPXR8oKEkqPQLi0tsaRph7zZtkoxtFoVfhaLoG5aCpzuskc/LUZMQ2xIeXd9
	 EhoK9RNKIdyY+BiAUGGi0zN1sYdh4yrAQzxShgBRLHrvTNqEQsGH2FFByTT2XnswQ2ugfuD5Moc3
	 sD4WYgPtSe/elyUpRl4WtS77byUDSuDneNP44JXvZol/7ONKDq9KX+4Y0vcVAws3P41QKSnJP8QQ
	 BaiuuK4EtN0C0CA8fESZOZgoaSHjuQ6CmDmeY8UaeXHYYH+Dc5vpc9tcM0YG/X0xeXNHQucd/UAC
	 rEh+83IV8gg3ky/ROx+vAoJdV/3F3nKIBh7iI87fBa8SMJ/pX6gHyvynSQ4LPqQqyQgMuPATZgS/
	 ZM6MW1Jy9DXa3SBoHLSO4Al5MoucXadTujNY026LxoICMI6CD7/BmuYDEs1FwdTVHU7NnpHSeoNJ
	 m8iEMHPqpwmNErKw==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Cunhao Lu <1579567540@qq.com>
Date: Wed, 14 Oct 2026 10:54:22 +0800
Subject: [PATCH net v2 1/3] can: dev: prevent bus-off recovery when the
 interface is not running
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <20261014-rockchip-canfd-restart-close-v2-1-c8fbdfad1803@qq.com>
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

The networking core clears __LINK_STATE_START before calling ndo_stop(),
but CAN bus-off recovery neither checks this state before queuing work
nor before calling the driver's restart callback. Recovery can therefore
be queued or started after the interface has begun closing, potentially
re-enabling hardware while the driver is tearing it down.

Check netif_running() in can_restart() before flushing echo skbs, sending
the restart notification or enabling the carrier. Keep the existing
unsupported-operation check first. In can_bus_off(), only schedule
recovery for a running interface and make the log message reflect that
decision. Keep reporting bus-off and disabling the carrier.

These checks do not wait for recovery that has already passed the check,
nor serialize the check with work submission. Drivers still need to
cancel restart work before tearing down resources and quiesce its
producers before their final cleanup.

Fixes: 39549eef3587 ("can: CAN Network device driver and Netlink interface")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
 drivers/net/can/dev/dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
index 769745e22a3c7..92492c503446e 100644
--- a/drivers/net/can/dev/dev.c
+++ b/drivers/net/can/dev/dev.c
@@ -198,6 +198,9 @@ static int can_restart(struct net_device *dev)
 	if (!priv->do_set_mode)
 		return -EOPNOTSUPP;
 
+	if (!netif_running(dev))
+		return -ENETDOWN;
+
 	if (netif_carrier_ok(dev))
 		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
 
@@ -264,8 +267,9 @@ int can_restart_now(struct net_device *dev)
 void can_bus_off(struct net_device *dev)
 {
 	struct can_priv *priv = netdev_priv(dev);
+	const bool restart = priv->restart_ms && netif_running(dev);
 
-	if (priv->restart_ms)
+	if (restart)
 		netdev_info(dev, "bus-off, scheduling restart in %d ms\n",
 			    priv->restart_ms);
 	else
@@ -273,7 +277,7 @@ void can_bus_off(struct net_device *dev)
 
 	netif_carrier_off(dev);
 
-	if (priv->restart_ms)
+	if (restart)
 		schedule_delayed_work(&priv->restart_work,
 				      msecs_to_jiffies(priv->restart_ms));
 }

-- 
2.34.1

