Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.48.77.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358356;
	b=ZHfeBOzUDWva+e3033lNEgLyw+TJQg6UQjCqKyHEtqvKHPYaUFUF2PBmktUMiXKBAcUE
	 X1oa1Ba9zSYvhp0Qo0SpSvJukQQe0GKEslWLOmVIh7Cr7kFVVRN2kSRj8h7DUAUqaKB+V
	 RdMdrDlj0TB8m3SPTya+ElT1mx11ctSNOGJ8iXwblBBrJk9L5fOTpC5JgsogTwoWw0M1p
	 aBAGMoLSMxxiPINlG4NHOf9UUK607kI4Y4x5DBQLhdNNZT5DdolPaow2WqzZwdYWjNiwB
	 emhaq7BSPaWejr+Xtre102u+E98rJx66B5xdU9z0b3hDKLTyf5Hy8iY4fJPwfhR1lsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358356;
	h=DMARC-Filter:Content-Language:Content-Type:Content-Transfer-Encoding:
	 DKIM-Signature:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:x-originating-ip:
	 MIME-Version;
	bh=v8lEuLC7PH65n/AITm/xoolRZ4Mc0T+XfSzWlqukzjQ=;
	b=rua+GpkzkOOLvz7UZ19YYpOJymDUNabScsqvKMAuzhHsabj10vJRD7IwXkrPr9UXtcZ3
	 14GFDo300a4W625LLD1qzyimzadi5gZuftxcB0QSBGbmDmf0ZWjaLHwtbD91TbEarOrFS
	 8kkoNu6cMHq27y7cwSYTlJugM75dOfsFx2Bund5JN+iR/8wlp2OP4LetbzQCjhtKrWaM9
	 syR6Kpm5KCdDzBwoTVzHUp4o+TV4au5kinRASzVNjkztd5782uCtBgFQuTPGt8Ckxb99k
	 uQYJPA0t4KeYj7snYfh60FILwgxw5kPVBVJNPYMzvkr2dOSkjK56wjHyG0DPte/9oIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=prosoftsystems.ru;
	spf=pass smtp.mailfrom=prosoftsystems.ru;
	dkim=pass header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=ZrE7ERD7;
	arc=none smtp.remote-ip=46.48.77.131
Received: from mx.prosyst.ru (m2.prosoftsystems.ru [46.48.77.131])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644B7606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 11:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 644B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prosoftsystems.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=prosoftsystems.ru header.i=@prosoftsystems.ru header.a=rsa-sha256 header.s=ps header.b=ZrE7ERD7
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; d=prosoftsystems.ru; s=ps;
	c=relaxed/relaxed; t=1793358350; h=from:to:date:message-id:subject;
	bh=v8lEuLC7PH65n/AITm/xoolRZ4Mc0T+XfSzWlqukzjQ=;
	b=ZrE7ERD7ipQ9qqRE5sVOQ54aJbpcaPhnWKCajRf+x+y9LC/gI8YBBH6NtF+dU8B8w3KAE92DYVE
	pXrdL3mDPb74DEsX69MxR7hCPB7tqrUjWxH9LkMPGYcUTlz31NSJFsHDpF0eZePEMUEUwumc5psFG
	mh4FGa8V+pN7FUfF5gTP8V0zuLCvMLgthgwJfab5q0Do3/uoWMYmucPehwC+51s5UtUeI8VPSLqc3
	rD/4fLNqR00YvsSTE8LlHyrDwDhrkrLjdIZEYZkeXg89mOMDOkUQcQn6ADG6vGf+ghnN5wIyhkmT0
	66W2YkOKFWCMmrTldRiRgrtvbLjT5yglrG8Q==
Received: from ECHO-3.prosoft.ural.ru (172.25.100.229) by mx.prosoftsystems.ru
 (172.21.240.33) with Microsoft SMTP Server (TLS) id 15.1.396.30; Fri, 30 Oct
 2026 16:05:50 +0500
Received: from echo-2.prosoft.ural.ru (172.21.245.22) by
 ECHO-3.prosoft.ural.ru (172.25.100.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Fri, 30 Oct 2026 16:05:45 +0500
Received: from echo-2.prosoft.ural.ru ([::1]) by echo-2.prosoft.ural.ru
 ([fe80::dd52:6e09:81b8:b31b%17]) with mapi id 15.02.1748.039; Fri, 30 Oct
 2026 16:05:45 +0500
From: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>
To: "lvc-patches@linuxtesting.org" <lvc-patches@linuxtesting.org>
CC: =?koi8-r?B?9sHNwsHLycXXIPLBxMnKIPLJy8HSxMnOz9fJ3g==?=
	<r.zhambakiev@prosoftsystems.ru>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: [PATCH net-next v4 1/4] net: fealnx: fix teardown order in remove
Thread-Topic: [PATCH net-next v4 1/4] net: fealnx: fix teardown order in
 remove
Thread-Index: AQHdaF6cu5VfPYj5VEWNePR1YN2lDA==
Date: Fri, 30 Oct 2026 11:05:45 +0000
Message-ID: <20261030110502.59804-2-r.zhambakiev@prosoftsystems.ru>
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

fealnx_remove_one() frees the DMA rings before unregistering the
netdev, while the interface may still be up, which leaves a
window where freed memory can be accessed.

Call unregister_netdev() first so dev_close() completes before
the rings are freed.

Found by Linux Verification Center (linuxtesting.org)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Radiy Zhambakiev <r.zhambakiev@prosoftsystems.ru>
---
 drivers/net/ethernet/fealnx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/fealnx.c b/drivers/net/ethernet/fealnx.c
index bdc38aac5850..68194c9ef332 100644
--- a/drivers/net/ethernet/fealnx.c
+++ b/drivers/net/ethernet/fealnx.c
@@ -682,11 +682,11 @@ static void fealnx_remove_one(struct pci_dev *pdev)
 	if (dev) {
 		struct netdev_private *np =3D netdev_priv(dev);
=20
+		unregister_netdev(dev);
 		dma_free_coherent(&pdev->dev, TX_TOTAL_SIZE, np->tx_ring,
 				  np->tx_ring_dma);
 		dma_free_coherent(&pdev->dev, RX_TOTAL_SIZE, np->rx_ring,
 				  np->rx_ring_dma);
-		unregister_netdev(dev);
 		pci_iounmap(pdev, np->mem);
 		free_netdev(dev);
 		pci_release_regions(pdev);
--=20
2.53.0
