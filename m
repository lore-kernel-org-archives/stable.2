Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=101.71.155.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794750169;
	b=A/sTbNk7L5KouyKc+63I6w6qPgNoNmE146YAHDKFPnxiypudx8vB7x3YrL0+++v/guQA
	 ms19+U8MnS+i02SaLROALn9Fsn2FAgfcW9g/tTnQJP0GA3o4GUejQQzpdCmDhjpEUpPSr
	 1Hn6VE1edTqgiRxHk24xAdLSXJZwlbUzxec9IbzYW6kzqFVVRKqNOc+aNlnBPTJ8+B247
	 23cxiThUfuOB0HdoL26HnY1QvlD8/igzuOVY4VLO7/sp85XWAjxOD2lYdf9ewrMYLNYrz
	 cU/ZlWfd+NbGalvdm6XD+q74M9Cvj1+HVSXvignM+iBZkr7ehuyI2GuFNfy6gUiPe1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794750169;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-HM-Tid:X-HM-MType:X-HM-Spam-Status:DKIM-Signature;
	bh=O4Pu+XOzyyu9/z/OzDH/Zf5ByDCwJvsC4BxuMsmIuA4=;
	b=BYwwP8BKVwWhtcnU2ojlJs+llDtXCpkf0vsDOcikGLZuDXLyBmz93WoovS6xcMM11vrm
	 fW9T216BK2BdCPw8QcMwhFdtx7DPbje3pGwtQapLXx1ETH5LwTziEw1gL7hd4GM9zFIyq
	 jgoK5ADRX02ujn83A2WY+DATaVdCMWad8z2KXrDBV3Eyk7k+fb7xCPOk6SMEIKui6Y2fa
	 gbuscH54RYxGhSXkxMJ4RemC9lDDqjCLJt7JVvD9pAW7C59YNR1nl8/eLnPYreddw6hyW
	 SqEUH9QgC+TL/EBekUvabFrvcyob5HYKQEt3Fg2v/SE85Flrw23kS8UDOAgt2m68r+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=seu.edu.cn;
	spf=pass smtp.mailfrom=seu.edu.cn;
	dkim=pass header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=lrKWv+Ca;
	arc=none smtp.remote-ip=101.71.155.101
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB92D606A33B;
	Sun, 15 Nov 2026 13:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB92D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256 header.s=default header.b=lrKWv+Ca
Received: from [192.168.17.1] (unknown [124.79.98.159])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54b8d4a12;
	Sun, 15 Nov 2026 21:42:42 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject:
 [PATCH net v2 1/2] net: plip: quiesce private work before releasing resources
Date: Sun, 15 Nov 2026 21:42:40 +0800
Message-ID: <179475016060.114908.18308299911622759410@seu.edu.cn>
In-Reply-To: <179475015898.114908.1534399014158681174@seu.edu.cn>
References: <179475015898.114908.1534399014158681174@seu.edu.cn>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-HM-Tid: 0aa1df72282203a1kunm6a37fc6bc5350
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0hLVh5CH0tNTEgfT0wfTFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VTEJVQkNVSk5CWVdZFhoPEhUdFFlBWU9LSFVKS0lCQ0
	JKVUpLS1VLWQY+
DKIM-Signature: a=rsa-sha256;
	b=lrKWv+CaDuWr5g/5n4Ss3bggQHtUsr7zG7iezoJiu0MiOdhY7a5bVyMfj//optNqFiga7QvdD/NsNJeo2jz0OzcUyCakAmhmBsv42paem478xUunnK8R8YSC2UE3dFlZRFOj12ew6KCWj3Ino70ZdvR6YCgGiNBP10MMRzHQXGY=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=O4Pu+XOzyyu9/z/OzDH/Zf5ByDCwJvsC4BxuMsmIuA4=;
	h=date:mime-version:subject:message-id:from;

PLIP can still run immediate or deferred work while close releases the
parport and pending skbs. Initialize both work items disabled and
disable and drain them before resource release.

Initialize state and enable the work before parport_claim(), since
claiming the port can already expose the interrupt handler. Restore the
disabled state on claim failure. This avoids dropping a trigger on
disabled work and then leaving the connection in receive state forever.

The separate second patch balances the controller IRQ across close and
an interrupted transfer; keep that repair separate from work quiescing.

Found by the author's in-house static analysis tool.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260928134136.1213-1-getshell@seu.edu.cn/
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Zehao Gao <gaozehao@iie.ac.cn>
---

Discovery: found by the author's in-house static analysis tool.

 drivers/net/plip/plip.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
index d81163b..dc3d258 100644
--- a/drivers/net/plip/plip.c
+++ b/drivers/net/plip/plip.c
@@ -308,6 +308,8 @@ plip_init_netdev(struct net_device *dev)
 	/* Initialize task queue structures */
 	INIT_WORK(&nl->immediate, plip_bh);
 	INIT_DELAYED_WORK(&nl->deferred, plip_kick_bh);
+	disable_work(&nl->immediate);
+	disable_delayed_work(&nl->deferred);
 
 	if (dev->irq == -1)
 		INIT_DELAYED_WORK(&nl->timer, plip_timer_bh);
@@ -1069,14 +1071,27 @@ plip_open(struct net_device *dev)
 	struct net_local *nl = netdev_priv(dev);
 	struct in_device *in_dev;
 
+	/* parport_claim() can make the interrupt handler reachable. */
+	nl->rcv_data.state = PLIP_PK_DONE;
+	nl->snd_data.state = PLIP_PK_DONE;
+	nl->rcv_data.skb = NULL;
+	nl->snd_data.skb = NULL;
+	nl->connection = PLIP_CN_NONE;
+	nl->is_deferred = 0;
+	nl->should_relinquish = 0;
+	enable_work(&nl->immediate);
+	enable_work(&nl->deferred.work);
+
 	/* Grab the port */
 	if (!nl->port_owner) {
-		if (parport_claim(nl->pardev)) return -EAGAIN;
+		if (parport_claim(nl->pardev)) {
+			disable_work_sync(&nl->immediate);
+			disable_delayed_work_sync(&nl->deferred);
+			return -EAGAIN;
+		}
 		nl->port_owner = 1;
 	}
 
-	nl->should_relinquish = 0;
-
 	/* Clear the data port. */
 	write_data (dev, 0x00);
 
@@ -1088,12 +1103,6 @@ plip_open(struct net_device *dev)
 		schedule_delayed_work(&nl->timer, 1);
 	}
 
-	/* Initialize the state machine. */
-	nl->rcv_data.state = nl->snd_data.state = PLIP_PK_DONE;
-	nl->rcv_data.skb = nl->snd_data.skb = NULL;
-	nl->connection = PLIP_CN_NONE;
-	nl->is_deferred = 0;
-
 	/* Fill in the MAC-level header.
 	   We used to abuse dev->broadcast to store the point-to-point
 	   MAC address, but we no longer do it. Instead, we fetch the
@@ -1141,6 +1150,9 @@ plip_close(struct net_device *dev)
 		wait_for_completion(&nl->killed_timer_cmp);
 	}
 
+	disable_work_sync(&nl->immediate);
+	disable_delayed_work_sync(&nl->deferred);
+
 #ifdef NOTDEF
 	outb(0x00, PAR_DATA(dev));
 #endif
-- 
2.50.1.windows.1
