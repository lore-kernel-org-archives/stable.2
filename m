Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.48.77.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358359;
	b=DknnRQ8FBQ5pyXJg9uUZ0zKpzuqGcTwtxFxI4/71A9EmautOXpYIDH5SAq8W1hBWHyPD
	 6keTzSCfA0MfboOp/KBfK77i2tNDsTklP/eNmAktvhAde60ZYmWP7BMjpmNiPm2siCK8E
	 vsibxmRmDjc+rTAfZqBwQVw4RCfON/yOXaPssTDWX5uBa8l2mPwkGx1ZJOlaQAiU4T2/Q
	 m0DCCBHZYTsDy/ejsERgIe5pdpjWe44kN3L+kbdxDyj2c4ne24IU2aJckm+LYiEzxUywl
	 8gazOJRfrSlHi2JkPODz6dAiUYqNtcxHUiXy6W5vzvySTmgLqPIGD4GB0Hdf4TNrb+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358359;
	h=DMARC-Filter:Content-Language:Content-Type:Content-Transfer-Encoding:
	 DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 MIME-Version;
	bh=WiniaEuh5i/wsjW0YuKIcYJBpMIyEjiA5m8ZmX85ceQ=;
	b=jRfo8am52XSKtMT8WECdDEjGN3sLz0q0CLn7uMwbrQICIJJbUcu5Cq9fgiZSty4nw2oH
	 htq/U53yP2QqwoBcjLP325UUtJSF2ThpxR8+uA566Tbsv7NMod4kj80HW5SYSzfnTH1wZ
	 5MbL2XtYyqHtLHNlDsbXAHYbw5bwi11Ab1n5MAsW2ehdPu9y7pj2PyDE95Qt84OmrSJnk
	 XficnDFbWih/uXblMTQb85HZgdGaMUTGPhP/5UFcwEywVjGQdHgiOoNcc9dfd+EQnyh2G
	 a+g7b3aXmUB4brlGG0zBeuESJUBNubx7lLTVr3L1QFLC/R4vlsa+2zAOkw0hI8AUWgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=prosoftsystems.ru;
	spf=pass smtp.mailfrom=prosoftsystems.ru;
	dkim=pass header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=tenVEh+4;
	arc=none smtp.remote-ip=46.48.77.131
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC05606A32E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFC05606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=tenVEh+4
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1793358360; h=from:to:date:message-id:subject;
	bh=WiniaEuh5i/wsjW0YuKIcYJBpMIyEjiA5m8ZmX85ceQ=;
	b=tenVEh+4Lz0Gu0JFoPZJkl5IqTR0+aBeHtIsXtXekgzKeUGhM46HqLd1dGVXYczO/00ZBM3SRrH
	oRvqQ5KkZIl1FOLiXDvzaWExESgSqaRyO3/qlFpkbJ0gWr8d/H1CG8FZhX8+l147B7JpQv04yJ6ji
	k6iZ+1Sl8cUMoB3vdnfYstyzvIyrfajwMviKwjlY65vXEX3Ps5e6pU9Lnf46W/Ueae2kkRG+C7kjG
	xSsPvttLBChytPov3j4xrMdKxN6UBzohod9dMYMjhV1aAcltXcywKpps8/vb4nVrzQPB5Pf+whbI8
	XNbhOj7Ep1UwLhenBGc07txzbKuWv1aDbNTg==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 30 Oct
 2026 16:05:59 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 30 Oct 2026 16:05:55 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::dd52:6e09:81b8:b31b%17]) with mapi id 15.02.1748.039; Fri, 30 Oct
 2026 16:05:55 +0500
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
Thread-Index: AQHdaF6i8WZVj9C0w0ikOEv50mt3rg==
Date: Fri, 30 Oct 2026 11:05:55 +0000
Message-ID: <20261030110502.59804-4-r.zhambakiev@prosoftsystems.ru>
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
