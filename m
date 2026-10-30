Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.48.77.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358363;
	b=BuQzfrE53rU7feMT+wp816NzClYFqtZLF83OXbgik1et7hM9eAB7+BiPEE7XIVzcxVA3
	 20QLHrDukP0knl8RLrei65IiOp0TQjo58/2G5fDZHgR0ByPBH0pUJFsWCbx7A6NpoYNWl
	 pCkyPfA/9lnSuiB+vUv/Vsvtx0h0eTvlyxzj8Eu95/NiN5MwRyNaGZ7xR0sCJW5Hc5FMf
	 uQ23YqQYuxq/Ckj9FeRXA3iEQX1AnR/MvaHz4H1OE4sP+WaK2kN7Ab+BlN+hq5/9mKOKD
	 Y7KFshNmWutAkSpHGLdK9XX/SIbnktU7+xUoCzPkqE9TdDwVpX+jrB1RNYqupPFkR0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358363;
	h=DMARC-Filter:Content-Language:Content-Type:Content-Transfer-Encoding:
	 DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 MIME-Version;
	bh=5mg9s5enIwqqvsUD41SVAQZxwrU0PWtuUiE08tXTehQ=;
	b=O5M7s9ZqbRLkFl6QHrgxBce7c+390rusiM3b7s7Uxc4Bt6dKspRws/rdSXTKci2qy+Tp
	 OaNWIw7kWf2KITq6Kkwr0JQBHsGvu20KbmpElkAPK8tD0FXA/o5oVf26S6jIZoL2/0P2R
	 xzC/P2qmnvg4HmfxImJjPa9k+Z+G4Z1KYZharmVMENFpfzSYPjW25rzxycuFLKISIRdhl
	 1P31g4Z0JOnMdTFuED2wL43QBiYyXOg1Eqe7O242iVzw5vP0Je7FeLu6ZHZ5UliIcX+ak
	 UVyUvtf24mpH9TWgFTYfGk7u3/pTLGG+O813p6jUtmjiHAX1KFs1uSW7xRMNHrNR5Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=prosoftsystems.ru;
	spf=pass smtp.mailfrom=prosoftsystems.ru;
	dkim=pass header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=M1mDHIuy;
	arc=none smtp.remote-ip=46.48.77.131
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A25606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04A25606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=M1mDHIuy
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1793358364; h=from:to:date:message-id:subject;
	bh=5mg9s5enIwqqvsUD41SVAQZxwrU0PWtuUiE08tXTehQ=;
	b=M1mDHIuyYbj0cupK3Lm5BUrKy3A7YLNBDdjyALuvrRVLrwNiHY3P0syixPczymEV8AE1aqcaskC
	WO+YxSWpOiZZm+5nC5fgEsv2amy+KY2rN+enMgRl2nvOiQdlvu+Fvj0hgsrA9ApyDRijClqPsCDSM
	wkUwwAJ+lpG0ccxMe9t41qxgfhsrG+9T48Y4uiHNhHOM1qqKSuUuVT55EfR2gUFkGS1rMtCR+j1fR
	qh5NDoZIpJgaKUS/4OUW045agfRP3wVLj7aKZGjywIcx9CF61qyobH2CY6+Z67UUCuoakMcHq4Fiq
	TfuCzX+Ghnc6wqis1u6iEw9vqF3KhBOOLQVw==
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 30 Oct
 2026 16:06:04 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 echo-2.prosoft.ural.ru (172.21.245.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 30 Oct 2026 16:06:00 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::dd52:6e09:81b8:b31b%17]) with mapi id 15.02.1748.039; Fri, 30 Oct
 2026 16:06:00 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net-next v4 3/4] net: fealnx: don't pass a stack string to
 pci_request_regions
Thread-Topic: [PATCH net-next v4 3/4] net: fealnx: don't pass a stack string
 to pci_request_regions
Thread-Index: AQHdaF6lyvPGFxK5F0eziiA7PZuiaA==
Date: Fri, 30 Oct 2026 11:06:00 +0000
Message-ID: <20261030110502.59804-5-r.zhambakiev@prosoftsystems.ru>
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

The resource core stores the name pointer in the resource and
keeps it until the regions are released, but boardname is a
stack variable of fealnx_init_one(). Once the probe returns,
the BAR region names printed in /proc/iomem and /proc/ioports
point into a dead stack frame, so unprivileged readers can
see stale kernel stack contents.

Pass pci_name(pdev) instead. The PCI core sets it before probe
and releases it only after remove(), so it outlives the
regions. boardname is then unused and is dropped.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/net/ethernet/fealnx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index b5e96c7037f3..20d453843e09 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -475,7 +475,6 @@ static int fealnx_init_one(struct pci_dev *pdev,
 	struct netdev_private *np;
 	int i, option, err, irq;
 	static int card_idx =3D -1;
-	char boardname[12];
 	void __iomem *ioaddr;
 	unsigned long len;
 	unsigned int chip_id =3D ent->driver_data;
@@ -490,7 +489,6 @@ static int fealnx_init_one(struct pci_dev *pdev,
 #endif
=20
 	card_idx++;
-	sprintf(boardname, "fealnx%d", card_idx);
=20
 	option =3D card_idx < MAX_UNITS ? options[card_idx] : 0;
=20
@@ -506,7 +504,7 @@ static int fealnx_init_one(struct pci_dev *pdev,
 		goto err_out_disable;
 	}
=20
-	err =3D pci_request_regions(pdev, boardname);
+	err =3D pci_request_regions(pdev, pci_name(pdev));
 	if (err)
 		goto err_out_disable;
=20
--=20
2.53.0
