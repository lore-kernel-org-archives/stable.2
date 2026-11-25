Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606370;
	b=I7SOKoQMjPFuXOZYHVgL8qvuTd7TkNLoSc1jmPjdhGf6zOxvPO3KAAhlHj5tA/QHoZT4
	 IUmXv41eeGMbrfDRa5qJJ5xTZUWZELObpSvsfPCN39esk+9jgOLFnpJ3ui0/7oiuD75CI
	 Wnu4QCrb/NK7qmc43auuvwc2jYWlg5kHwy9EbrZJXMC/SLePTG9Nw0hpUxUSTA5r+4yD3
	 RJyqQIyjHkmSh0K+BOVfP9/E3hIN7Lg5WsdsSeV34GqfFALmVmBUPFVQlEGjIIDM9KKu6
	 tZXUemrXJ7iM17qUuMRQEYf59QEpTM0womuogFtWwpvi3kfjXQiFXnsgKlfU71WBEsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606370;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=OX3EmVp8Gw0vgq2WFV4ZbEYiYU8lefr1ybECcGgZIJo=;
	b=XXtIx7IgycAOZ6uI4fFke1N0A/5tQci4kcfaYwMcl5Efbj2z6OcV+f6CfS2OHlZfgR7G
	 WbQNBUlBp0C9vqtqJzr1/fGn5CtDxYW8mmAy06oj07dXVlSRqStrK0lfEcgWTyoF1HUFr
	 B7amqyeuU2J1xCOLXY4KYO8md4do9AvKgxjoEL2S908ct5mWLlYywhLOMjE1VXphjbyTU
	 0B+qKZv8hvPsKjed8KkJN3pKgwQhFEioZCuxUnBougOmYLIhzMgw5lUJgoOfwO+rX9wIe
	 fVE60BwcEsp1WyVXhjHlPv2QhcEucNHUOEXPGVZJIJ5HOkAnKAFG2ZPovlAYd9wFDrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=hFiRBgg0;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA11606A31E;
	Wed, 25 Nov 2026 11:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA11606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=hFiRBgg0
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: atl1c: cancel the common_task work in atl1c_remove()
Date: Wed, 25 Nov 2026 12:31:41 +0100
Message-ID: <20261125113141.99792-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
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
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id 09BE50A7-5878-49F7-83E4-1DEC254CD03B.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 25 Nov 2026 12:31:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1795606302;
 bh=OX3EmVp8Gw0vgq2WFV4ZbEYiYU8lefr1ybECcGgZIJo=;
 b=hFiRBgg0RoQTai9Pbvzc4Zml/+HSGEks0RRZy18z1AQO5M8Je1u+bm2A9m9DXlLFJui9rlRiF
 /yyAtfOFuPRnUCxciO1gynR2jcPz7VZIYaiXaKp2jOWhqErwXd0HWZpSSDvPnQpkf6U0YCxsgwz
 dTLahsawE2zP9wPPLF/HNBPZyTFskQpBLl9oeZOqsHfz2iOzd9pQcL0lcO/vEHHA9263CStAa4r
 hk1MqQkoyMryIe4tD7DZCZ7NqfKKRK8hUzEgd1/Q1X75Y/vdT27jZzoVG1HkSD2UistliSwKsRL
 hm6fuG329201u99fazsU2ezDFecas/ChYcYNZmmRy/yA==

atl1c_remove() frees everything the common_task work item needs - the
register window, the netdev and with it the adapter - without ever
cancelling the work.  A link-change interrupt can queue it right up
until unregister_netdev() runs atl1c_close(), and even the
cancel_work_sync() there is not the last word: it runs before
atl1c_down() frees the IRQ, so an interrupt in between queues the work
again.  Nothing then prevents the queued work from running after
iounmap() and free_netdev(): atl1c_common_task() dereferences the freed
netdev and reaches the unmapped register window through the link
handler and atl1c_irq_enable().

Cancel the work after unregister_netdev().  By then the IRQ is freed,
NAPI is disabled and the TX watchdog is stopped, so nothing can queue
the work again.

Found by code inspection; the use-after-free has not been reproduced.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
Companion to the series "net: atl1c: fix the RX buffer leak on errored
frames": patch 2/2 of that series adds one more producer of this work
item (schedule_work() from NAPI context when an RX descriptor is out of
sync), which is why this pre-existing fix is posted alongside it.  The
series itself stays at two patches.

0aa76ce3324e ("atl1c: cancel task when interface closed") added the
cancel in atl1c_close() but kept it before atl1c_down()/free_irq();
this patch does not change that order, it closes the window in remove
instead.
---
 drivers/net/ethernet/atheros/atl1c/atl1c_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index eddd840..31272f0 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -2810,6 +2810,7 @@ static void atl1c_remove(struct pci_dev *pdev)
 	struct atl1c_adapter *adapter = netdev_priv(netdev);
 
 	unregister_netdev(netdev);
+	cancel_work_sync(&adapter->common_task);
 	/* restore permanent address */
 	atl1c_hw_set_mac_addr(&adapter->hw, adapter->hw.perm_mac_addr);
 	atl1c_phy_disable(&adapter->hw);
-- 
2.54.0 (Apple Git-157)

