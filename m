Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163371;
	b=mQXfdICOxZFWk4BMgKHmxfDgrnPClBf+9fSVqiehbiQe0S8rcWV3KFK/nGEcJC8B8iXR
	 TJzoZbkiH6FPWj+perQ5KObORPtqwDN+iBAM8OIFnF5BZ4FrdMVSTUK508mtN/WZreNOn
	 k4+vzukylPZ23PlkE5Kg/1ckLgk8eUPhGOZfdvdCzZDtZbN1q52YVeHCLyY58b7bqVJpK
	 u8sVM80injBqlkdig+NQSSVPvupL1WV8wIPgCRz7kKBkOR79DAbiFrCFvoJDgGH5cczne
	 +JmAy15u/W6Febyss9+M3MwAljOgpYl45dYgvvl2QX0Ucj2GnqxVHQiVroKepAe5lFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163371;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=lx5lK1VQQr4KB+C37H+5kgyd83ZxV4Y58Bkd4eULmJo=;
	b=Syupi/yoNPB01A6PuQ5U/uyYCeBx/nmnxjj6NT3GWiys34giumTnUXlbfZs/siCQQ48e
	 1zSCzonblSCJ/Hd7yzGsj5GNQsRqJDYWylv8oNeqlTvFDDaKBACni3A0cnNMUpnDh0RVW
	 ErrHJWPXmLArQGdPTcr8feh8fhbk7dQkTC+X1uarYXXZesgTR2cvaqRFFOPgQXJUqFJPM
	 tpGYzNK5bpziaMJKO2wLrvhEH24W8w+xJPdLGJBoqVZYmTQzknof/aJWXR1/JMTXnasno
	 W7/fy7GgFYKHAwH9JinFDGKTvofeT1tAxE8OUm8ODM609Qqp2Wfs746GlHay7Xwc8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VO14DnkD;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F061606A31E;
	Wed, 28 Oct 2026 04:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F061606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=VO14DnkD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lx
	5lK1VQQr4KB+C37H+5kgyd83ZxV4Y58Bkd4eULmJo=; b=VO14DnkDkLjqTXaUqF
	SQ9gUU44QdiaZR2C5xPZOE56NgtBuqEoOMnL956A0MNWlrJjMT4iErl3nA2yZdwQ
	/eqVuCfI9aqkW8PyNqEqaZyEQUXDEnbPlrJFed7Yrn3FBW5V7udaEisrB4oxdEKS
	JVQUyULxTMqoIjT122ZqWkAY0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3P1NkgOFq_DBWDA--.43191S4;
	Wed, 28 Oct 2026 12:56:06 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] wifi: ipw2200: drain IRQ tasklet during teardown
Date: Wed, 28 Oct 2026 12:56:02 +0800
Message-Id: <20261028045602.111668-3-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028045602.111668-1-yaojiale02@163.com>
References: <20261028045602.111668-1-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3P1NkgOFq_DBWDA--.43191S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kr4fKr1rKF4xur4xtFWrXwb_yoW8Ary3p3
	yrCayjkryftrsFga4kJa15X3WrXa1aqrW5GryrtwnxZa1avFyFqay09FyYqay8tFZYqa1Y
	qFWqyF45Wrs8Wa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UKAp5UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wZMhmrhgGay9AAA3I

The interrupt handler can queue irq_tasklet just before teardown frees
the IRQ.  free_irq() prevents further hard IRQ handlers, but a tasklet
that is already queued can still run while the remove and probe failure
paths release its queues, command log, MMIO mapping, and private data.

Kill the tasklet after freeing the IRQ and before releasing resources it
can access.

Fixes: 43f66a6ce8da ("Add ipw2200 wireless driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2200.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2200.c b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
index 8249d493ee22..e8112ef3150e 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2200.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2200.c
@@ -11720,6 +11720,7 @@ static int ipw_pci_probe(struct pci_dev *pdev,
 	sysfs_remove_group(&pdev->dev.kobj, &ipw_attribute_group);
       out_release_irq:
 	free_irq(pdev->irq, priv);
+	tasklet_kill(&priv->irq_tasklet);
       out_iounmap:
 	iounmap(priv->hw_base);
       out_pci_release_regions:
@@ -11751,6 +11752,9 @@ static void ipw_pci_remove(struct pci_dev *pdev)
 
 	unregister_netdev(priv->net_dev);
 
+	free_irq(pdev->irq, priv);
+	tasklet_kill(&priv->irq_tasklet);
+
 	if (priv->rxq) {
 		ipw_rx_queue_free(priv, priv->rxq);
 		priv->rxq = NULL;
@@ -11802,7 +11806,6 @@ static void ipw_pci_remove(struct pci_dev *pdev)
 	ipw_prom_free(priv);
 #endif
 
-	free_irq(pdev->irq, priv);
 	iounmap(priv->hw_base);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
-- 
2.34.1

