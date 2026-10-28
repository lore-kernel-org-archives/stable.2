Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793163371;
	b=MSTnPm6FvXcMj0r7etGJnIDNcRbU7MPzITt9ef54s93jVpJrTqBYhyK5Fgv1O2nixXca
	 Def3H+VgA+S6RkfyC9RNWOVsRic46wrLoWyrm3JWm2YT/O+OzSHDKzkpahvYZQM0fiySR
	 z5XRqlZQRj+ICcihHDoG9oBjf7SCgVtME7DnhG3za+rGmasjEYEf0hQFg64Kz4Rc21UF5
	 6j/ukLLvxS1WA5QRAIn4IaFzUZLtLa/flP29ILtHo2jZWHnUTIkvDyQWn5p7ZgYP15ELA
	 kFMuthU/BEHQAKsaHHFDbTYRbIDn4hDCPuVI2G14qljX64DCW79oxDkWSyWz09xIcfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793163371;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=ta7lEblSOhyp/ykI6yMGs5HNz9TNjeUSd8o/9QM2Bsc=;
	b=pZMHW5J3wFLU3VnFmxlXZw7qIP5Z1uPbzRwQGUQK1tx1vs7QY5xooHkNann0Bbqo+B4L
	 V7k2UFB9pVM07VieO99hsYYObfWlqJphXZNHrxtVxxV4U/LNez0yDYwCkLR5tGRK9p4cg
	 U5Poh4+NlF2zmn09WyImMV11agWLodG/JReZD13EdG4hMDZPUDtzE9EPQWQDIxvVSWggT
	 +86eQ5NJIUIVnsbN9XvdQuGYU3Xjfrf5oD5TSmfTxx+BNuNXfjsDyZn++iu/fqMXVoXLi
	 5RDVXDkm1/9udYHLNYXu1+0HehIhX0WLK9jdW1FuVvirUdSCVXS9gtpDoZ2Z3I/3+0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kc0PsBKe;
	arc=none smtp.remote-ip=117.135.210.2
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8F1606A31D;
	Wed, 28 Oct 2026 04:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C8F1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=kc0PsBKe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ta
	7lEblSOhyp/ykI6yMGs5HNz9TNjeUSd8o/9QM2Bsc=; b=kc0PsBKeC1s7TN/6Ws
	pQSAg07H86kvUZJ0SF24RzdgM7tUy77xMwpYpLWc7Ru22JcPt8UhXcc0yqsmFUmS
	SplRGTV1nOQyyda6HyHu0VV2V5jIlJR3Wa3epJb/Bd9LvwSGNxJ889bXX2W4L3hi
	RmvbnKX7HHuvr2xTamoWNf4fM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3P1NkgOFq_DBWDA--.43191S3;
	Wed, 28 Oct 2026 12:56:05 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Stanislav Yakovlev <stas.yakovlev@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] wifi: ipw2100: drain IRQ tasklet during teardown
Date: Wed, 28 Oct 2026 12:56:01 +0800
Message-Id: <20261028045602.111668-2-yaojiale02@163.com>
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
X-CM-TRANSID:_____wD3P1NkgOFq_DBWDA--.43191S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7urW3JrykZFy5GFWkZFWDurg_yoW8Ary3pa
	9Iyay5Kry8tr47Wa48AF45J3W3Xay3trWUCryFgw1rXw40vFyFqFW09a45Jw10q395Wa45
	JF1YyF43Wws5JFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPCzNUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQVMhmrhgGWADgAA3i

The interrupt handler can queue irq_tasklet immediately before teardown
frees the IRQ.  free_irq() prevents new hard IRQ handlers, but it does
not drain a tasklet that was already queued.  The tasklet can therefore
access queues or MMIO after the remove and probe failure paths release
them.

Kill the tasklet after freeing the IRQ and before releasing resources it
can access.

Fixes: 2c86c275015c ("Add ipw2100 wireless driver.")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/wireless/intel/ipw2x00/ipw2100.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/ipw2x00/ipw2100.c b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
index 43b4e432956b..44c76f1789d2 100644
--- a/drivers/net/wireless/intel/ipw2x00/ipw2100.c
+++ b/drivers/net/wireless/intel/ipw2x00/ipw2100.c
@@ -6300,6 +6300,7 @@ static int ipw2100_pci_init_one(struct pci_dev *pci_dev,
 
 		if (dev->irq)
 			free_irq(dev->irq, priv);
+		tasklet_kill(&priv->irq_tasklet);
 
 		ipw2100_kill_works(priv);
 
@@ -6346,6 +6347,9 @@ static void ipw2100_pci_remove_one(struct pci_dev *pci_dev)
 	 * FIXME: remove the comment above. */
 	unregister_netdev(dev);
 
+	free_irq(dev->irq, priv);
+	tasklet_kill(&priv->irq_tasklet);
+
 	ipw2100_kill_works(priv);
 
 	ipw2100_queues_free(priv);
@@ -6353,8 +6357,6 @@ static void ipw2100_pci_remove_one(struct pci_dev *pci_dev)
 	/* Free potential debugging firmware snapshot */
 	ipw2100_snapshot_free(priv);
 
-	free_irq(dev->irq, priv);
-
 	pci_iounmap(pci_dev, priv->ioaddr);
 
 	/* wiphy_unregister needs to be here, before free_libipw */
-- 
2.34.1

