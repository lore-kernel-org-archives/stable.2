Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.48.77.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358368;
	b=oX+s5GmorT2/Gz28xr7QuwPOS6zVMWURNZYzAV4z3YOLlmAUOJMnhjTXdFqwYgQPceFy
	 a2Oqv7RCbrX1AsDL3C8noxwUU6uKXDSwnmIr24bj6Vrfe2SSuctlVd74TaoElWY9Qate4
	 6gsofLKhApuO7e+PmpPEIq12MiCSyGUkIxKUw1kSBYIsbIgMV1fQ3rx6HUqm1qMey3H4m
	 r8bmvxofY1qXSqbRzIRDtlgkvdXCw7+FT8S6F52QUB4GEZsF1r0xi6Q7hQGwuhxV2VIKo
	 oHd6h7XDfgq8QE4VcBmZ8Ugpenkpq2kAMVa1kGNWm5tztOQBJ9Jnfaij8IS/epMDj/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358368;
	h=DMARC-Filter:Content-Language:Content-Type:Content-Transfer-Encoding:
	 DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 MIME-Version;
	bh=pwD6sWP6AnoZnkuzTiLUv3GKkj4c8qZjxyfsKqHkGGo=;
	b=1eTn2KNv4mOfDEsD+D42sNGEbHtrqHiKjhxA2NIMiiP8rtUVdsPGFE9IkIcgABWlvWBo
	 1jPzhwJ1rcpttffsfLE/TF5HuCR0yWq3fZkruSYsThFuRLZmIFyt7Kkj5Qwlpj75EboP9
	 8l4V+xSlu2WU0xi/DmUIK40gG2lizFf6av5479Hjv6o0v4ig3ZWjCzNU1U1p+YJVsKNUw
	 LuKjaIXY89KVTp4tekfbxJZCGaM2mNwd01gHt6ZfAZKRno9xj4zioAPXbSnsD63egHJte
	 g7DAjKNRM4gN5RaXXSse1FSzSS9CdWR9rAV25VXUNOdeU78EfIrWq7BBeQIeOfC6gnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=prosoftsystems.ru;
	spf=pass smtp.mailfrom=prosoftsystems.ru;
	dkim=pass header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=REcDd4OG;
	arc=none smtp.remote-ip=46.48.77.131
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174BF606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:06:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 174BF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=REcDd4OG
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1793358370; h=from:to:date:message-id:subject;
	bh=pwD6sWP6AnoZnkuzTiLUv3GKkj4c8qZjxyfsKqHkGGo=;
	b=REcDd4OGZbM+C2RzX30tyoviWb0S3bonBqgnl6ylI5rkq8iLRh/vNOFDwA+PjiKZhY8Lp/uohSP
	xA8vmWMdlgQwq6PeEDP3NnNSlVLDrZDWNa3fjDdgaRQxLzhWSsHnIytGjNwkrZjRTOwsQ58wYSgvG
	i2XaRqq08XO7rJC9DhSNewyOtPoXBC6gJrpm9HrJXFh7v6TMjRzBAJsOC12vLaPIFmccI1mPx4U73
	iuyn/9iUZu1p81tYZvEF0goTO6LD73XV3paN1lz8PK360s2Jz2XqEg9Eb8BiUovhPQNJwZkBPGkhn
	IpVm3k0yw4g19p7KHhDH9kGtgVraomF3jFJQ==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 30 Oct
 2026 16:06:09 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 30 Oct 2026 16:06:05 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::dd52:6e09:81b8:b31b%17]) with mapi id 15.02.1748.039; Fri, 30 Oct
 2026 16:06:05 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net-next v4 4/4] net: fealnx: allocate the card index from an
 IDA
Thread-Topic: [PATCH net-next v4 4/4] net: fealnx: allocate the card index
 from an IDA
Thread-Index: AQHdaF6o2SU1qE987U6KYnUnPYG7sQ==
Date: Fri, 30 Oct 2026 11:06:05 +0000
Message-ID: <20261030110502.59804-6-r.zhambakiev@prosoftsystems.ru>
References: <20261030110502.59804-1-r.zhambakiev@prosoftsystems.ru>
In-Reply-To: <20261030110502.59804-1-r.zhambakiev@prosoftsystems.ru>
Accept-Language: ru-RU, en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>

card_idx is a static counter that is incremented on every probe.
It can overflow and wrap to a negative value, which then indexes
options[] and full_duplex[] out of bounds.

Allocate the card index from an IDA and free it on probe failure and
remove. The IDA reuses ids on re-add, so a re-plugged card
keeps its options[] and full_duplex[] entry instead of being
moved to the next slot on every reprobe.

Store the id in the driver-private data so fealnx_remove_one()
can free it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/net/ethernet/fealnx.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 20d453843e09..00dc116c0817 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -83,6 +83,7 @@ static int full_duplex[MAX_UNITS] =3D { -1, -1, -1, -1, -=
1, -1, -1, -1 };
 #include <linux/crc32.h>
 #include <linux/delay.h>
 #include <linux/bitops.h>
+#include <linux/idr.h>
=20
 #include <asm/processor.h>	/* Processor type for cache alignment. */
 #include <asm/io.h>
@@ -143,6 +144,8 @@ struct chip_info {
 	int flags;
 };
=20
+static DEFINE_IDA(fealnx_ida);
+
 static const struct chip_info skel_netdrv_tbl[] =3D {
 	{ "100/10M Ethernet PCI Adapter",	HAS_MII_XCVR },
 	{ "100/10M Ethernet PCI Adapter",	HAS_CHIP_XCVR },
@@ -411,6 +414,8 @@ struct netdev_private {
 	unsigned char phys[2];	/* MII device addresses. */
 	struct mii_if_info mii;
 	void __iomem *mem;
+
+	int card_idx;
 };
=20
=20
@@ -473,8 +478,7 @@ static int fealnx_init_one(struct pci_dev *pdev,
 			   const struct pci_device_id *ent)
 {
 	struct netdev_private *np;
-	int i, option, err, irq;
-	static int card_idx =3D -1;
+	int option, err, irq, i;
 	void __iomem *ioaddr;
 	unsigned long len;
 	unsigned int chip_id =3D ent->driver_data;
@@ -482,18 +486,22 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	void *ring_space;
 	dma_addr_t ring_dma;
 	u8 addr[ETH_ALEN];
+	int card_idx;
 #ifdef USE_IO_OPS
 	int bar =3D 0;
 #else
 	int bar =3D 1;
 #endif
=20
-	card_idx++;
+	card_idx =3D ida_alloc(&fealnx_ida, GFP_KERNEL);
+	if (card_idx < 0)
+		return card_idx;
=20
 	option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
=20
-	i =3D pci_enable_device(pdev);
-	if (i) return i;
+	err =3D pci_enable_device(pdev);
+	if (err)
+		goto err_out_ida;
 	pci_set_master(pdev);
=20
 	len =3D pci_resource_len(pdev, bar);
@@ -533,6 +541,7 @@ static int fealnx_init_one(struct pci_dev *pdev,
=20
 	/* Make certain the descriptor lists are aligned. */
 	np =3D netdev_priv(dev);
+	np->card_idx =3D card_idx;
 	np->mem =3D ioaddr;
 	spin_lock_init(&np->lock);
 	np->pci_dev =3D pdev;
@@ -672,6 +681,8 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	pci_release_regions(pdev);
 err_out_disable:
 	pci_disable_device(pdev);
+err_out_ida:
+	ida_free(&fealnx_ida, card_idx);
 	return err;
 }
=20
@@ -689,6 +700,7 @@ static void fealnx_remove_one(struct pci_dev *pdev)
 		dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
 				  np->rx_ring_dma);
 		pci_iounmap(pdev, np->mem);
+		ida_free(&fealnx_ida, np->card_idx);
 		free_netdev(dev);
 		pci_release_regions(pdev);
 		pci_disable_device(pdev);
--=20
2.53.0
