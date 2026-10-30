Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.48.77.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358357;
	b=b/DiuN3EMvm2R4tIiwAuueoJmNX7invsUyW0RuF8qUta4FPyPvVEajW2Q0DHuUssVE16
	 oJTvvjngh6Be4f5Yg9AIjugNUq9hLGrKVEUCpep9qL6el91St7Iqi6ZMHr1kDPBHUZmhI
	 B4nyw7iCxlqQ4xStcipOHK7v2w6zVeNYJvXlmQA1bZFZYi9g4lj5487bbbYkNB5Ksk1Sh
	 YwY7N4B5SD6eU6ug3evgASzLRnNw79UekPz9/FT+xPQzmzIJzdXcJiGV6Kjhm2LPydV3F
	 IVUOdadhPL1o7XzyWZ/KspMXcgKOfDi9ZaPXcm/zqxPgNOATfUm+Gn5u2DbXqIuMLCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358357;
	h=DMARC-Filter:Content-Language:Content-Type:Content-Transfer-Encoding:
	 DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 MIME-Version;
	bh=WiniaEuh5i/wsjW0YuKIcYJBpMIyEjiA5m8ZmX85ceQ=;
	b=glR28u0CKi9Q6uKDZqbCUnV7ZmmyjvxdqSJgOp0zVL5DuKiCq28W83AphWWmS76fWiHi
	 V0YetBkcHvEXIeNcekOKXn//gbxtXXccBxWq98DMuFn0UEDnbVkAMLXHy1iNeMlgxRWBv
	 jpPEMZPolyjxtLnREsMuvZYINcEm5xLPsVS+sVF2PcSgr+AYg6LVM9Z2Ja5Lq+g0DY9Ni
	 ep+T21gpbdme07LvnBmKl9la6HPP393/njZptvdES7bJhhMYQ70X4XD1GwtbtiIOM73FP
	 A0n9nMUEtC6ZA95sw4Ty3g0cPeBi1ALfafM+Xj7F7G54eevIGD5WzMkoHa97rIYVDQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=prosoftsystems.ru;
	spf=pass smtp.mailfrom=prosoftsystems.ru;
	dkim=pass header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b="GY8N/94v";
	arc=none smtp.remote-ip=46.48.77.131
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D3606A323
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 784D3606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=GY8N/94v
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1793358355; h=from:to:date:message-id:subject;
	bh=WiniaEuh5i/wsjW0YuKIcYJBpMIyEjiA5m8ZmX85ceQ=;
	b=GY8N/94vhbaVVdujrmJ5nYWdNZYOgkcITNyZUOEkb0lpK3neVrWvtlLfynljwfAmQ8NGAb7VG2c
	CS844fi7hO/dCGa+FvYeNyjcQA0zYNUx5Pec7tCzoGAyVeY/RC4sxWk3W90HxYPzT3Xt0U8yCTiCw
	SX2unjQxiA5gDAdUlqz0z/uTJpa5bMGWv5OQiJhOgqcDTbS9BSFvNHHI2OmD3rLqEHEsKsaU55OgZ
	QJhyLZpTyNMhb9OQ+YTl7Y2vHbjQA5MZPzQo+zxE1NTtGmRhgffiYVbGfJ2/GTVQPVcwQ0IiuQ8zz
	sQPcpMUlDdqmfTBzuUZ122GEjwXPnV1IeuUg==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 30 Oct
 2026 16:05:54 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 30 Oct 2026 16:05:50 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::dd52:6e09:81b8:b31b%17]) with mapi id 15.02.1748.039; Fri, 30 Oct
 2026 16:05:50 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net-next v4 2/4] net: fealnx: disable the PCI device on remove
 and probe failure
Thread-Topic: [PATCH net-next v4 2/4] net: fealnx: disable the PCI device on
 remove and probe failure
Thread-Index: AQHdaF6fiK+x2GolY0KN1xpDn6GfcA==
Date: Fri, 30 Oct 2026 11:05:50 +0000
Message-ID: <20261030110502.59804-3-r.zhambakiev@prosoftsystems.ru>
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

pci_enable_device() is called in probe, but the device is never
disabled on probe failure or remove. Device remains enabled and
bus mastering stays active.

Add pci_disable_device() to the probe error unwind and to
fealnx_remove_one(), after all other resources have been released.

Found by Linux Verification Center (linuxtesting.org)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/net/ethernet/fealnx.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index 68194c9ef332..b5e96c7037f3 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -502,12 +502,13 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	if (len < MIN_REGION_SIZE) {
 		dev_err(&pdev->dev,
 			   "region size %ld too small, aborting\n", len);
-		return -ENODEV;
+		err =3D -ENODEV;
+		goto err_out_disable;
 	}
=20
-	i =3D pci_request_regions(pdev, boardname);
-	if (i)
-		return i;
+	err =3D pci_request_regions(pdev, boardname);
+	if (err)
+		goto err_out_disable;
=20
 	irq =3D pdev->irq;
=20
@@ -671,6 +672,8 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	pci_iounmap(pdev, ioaddr);
 err_out_res:
 	pci_release_regions(pdev);
+err_out_disable:
+	pci_disable_device(pdev);
 	return err;
 }
=20
@@ -690,6 +693,7 @@ static void fealnx_remove_one(struct pci_dev *pdev)
 		pci_iounmap(pdev, np->mem);
 		free_netdev(dev);
 		pci_release_regions(pdev);
+		pci_disable_device(pdev);
 	} else
 		printk(KERN_ERR "fealnx: remove for unknown device\n");
 }
--=20
2.53.0
