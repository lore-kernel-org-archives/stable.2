Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794328423;
	b=2hnIzUKTVqmo0p57MXCs3EFLBdHk95UJEB/RMT9zByabD7qgExq2BxelwWEBg8dGM3mu
	 jumqoTbiLQg9TT4Kv863uF+zZVo9+w5Tvx3SN3wEI1efuiHQ+MedReHqagDZWEaWHBBuw
	 sUCytsEhJbtRrukWxEKpSHA5e+oSjvf4eDPqVup80f5KZdnzKObvmZOagOaGzONH6s4Yf
	 1g6/MCnTayrhAv2hy4TKLQ4WRbUneYcsqEdRBxeDcLihsKbzXPBVfyCNTsWnO8/dPuT58
	 5CfvbPB7K6pQkimg/KOjD5sOcL0jjCxZLsUlLJfQlhixwqvLnPFdzmdgNvZCudvjadQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328423;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
	b=pEx+yPEAn+AMrN1c9ext6uPyumgMyVS9bX9ZAJWukb5vDgAjPR2P9nKs7NILCb8lynBy
	 qdwrHETH4iVBPMltcrYGsHNT9DeAvwj+V+WFkpK6rIRrh/9uObIEt6fkwgqNfyTBTUUMb
	 KHZZyMgxxg3qnzvMOw+0+lj8jo7HxQB0deEVyYHHKM21aUHqhAIUv2PrAUPE1m4NlIoSp
	 Gj9xtHP8s/MVeT8EHavz85czCXU+6YqyvjWsXZ+yqX6rmzYefoKLz2sW8M8s7lXWT1eW5
	 YQl6LhfH8ksLCd6AzYjtc73DuAa47m9hg1aQr7FhrY2KC49wos1Nbc41Eb3wS5QQGJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HylrYvB8;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=c2HsFMrB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE70606A206;
	Tue, 10 Nov 2026 16:33:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BFE70606A206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=HylrYvB8;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=c2HsFMrB
Received: from pps.filterd (m0374956.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwGai1618160;
	Tue, 10 Nov 2026 10:33:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3y
	qs=; b=HylrYvB8fKiYjmnISJ97xuuHSbqr8XeW1ulqpDCuvVQ3+Jp5kobihqnS7
	SoW4QHdOZqVnhTJyASrcHpHfkGAKTrwUmX5fKkSSR8EHGm1XC++NfkFUt3rc9YL4
	GxIwZCUTYneLlCbOyKN4RX6mMuwXZ4PuDCDiTzFxIqJjizyAhal69K9FAKsPS/ZQ
	rtL3SbuvJ1sRtG8Isgoh/CHx9D1eDWOZSrLLB83GkHM2eZQZDOdlh2l3om7b1ixC
	QZDJfFQXECXkzzEnGebNDJxiOfk8w41HWFi62bbOOQMutIJCuK+cXFi3tEfCt9HW
	ShyzOFjCxr7vx6bEjPyHvoy5H1UyA==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4hv0kstajc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 10:33:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RSVEnfiTy5IYV5qrkPDPoTwtlruzfjDc25VT4OWh2s9z4fnUyOcCMsGKN+bpUz+RNRVIZ0ZKLG9ywmRov2ssG6KqjwzUzkSNbJ3EouIf0t8jKR4nRhu6JOZfxOdd/SOKdqcTumotRlEPGw1fb+Mw5VgXMFwYHQsYyEf3ML4I1fSvY8L3Lq6T462dCjcb6VWlDfJ6k6aGl3JWXiRkIofBIypsZis7lY2tZmnw59PRg0+0Kc5/pccQUYhzjdXmf/uf9FEg7adqwF5XoPFcLHXdfScE3Cw4YMAwt1YHeJ4rfpNKpW7Pgi/F3Yloj+kV7yOWfMPC0bvTL4CIfrpDvqrM8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
 b=k7foMeFZHrqh4MwYicYRi9f8SU6ne2Kodr2/KF3stssaXrnWiBAiQyXb8Jq6DLYE2sfjKdnchKcuuQOc7+7j73R/6m5BQ4SKgRM6QKMtgQrc2974QE6nQVZe4qvQ00qKQGChcExcGlgNGIYVA60E6KHS+sD4XKnmtaR/EjRlH4w3AZTobeIkcDyliUpdD/jKfbjZ/Cdn3FcORua9vsNcrgxPJCJMLwmREYT0QuzwhQs7oqNp/1HAtnV8cu9hY2QYIssJ7pll081v5ICSigFw14XZ3NBuH2KNRVaH0rDfH0Oa1kLM5sQU756SeCqLcm9igB2O/zm48daB1WA+SkiW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vXnUGB2Md7aQ7Na1iGu7XmIgmDC2Kx7/T5xcKSH3yqs=;
 b=c2HsFMrBEobBV09X0GpG9Ee9fgodce4O0ltdik+Kjplv1nxmYp/wtY5Uc4G2iRMU08q0UdvhojjkyKxu8k2ABMZ++5V82n/o3iKZsI4RT3xkcQBot2NCkQy6BhCP92/LeSc3bZvv4ZavvfZf4iTVn63FXLaLb2LQlYGcaD6A3Ac=
Received: from BY3PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:217::24)
 by MN2PR10MB4256.namprd10.prod.outlook.com (2603:10b6:208:1db::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 16:33:34 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::4e) by BY3PR04CA0019.outlook.office365.com
 (2603:10b6:a03:217::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 16:33:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 16:33:33 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 10:32:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 10:32:50 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAGWoH51141135;
	Tue, 10 Nov 2026 10:32:50 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v8 2/4] media: imagination: e5010: Fix clk never enabled without CONFIG_PM
Date: Tue, 10 Nov 2026 10:32:45 -0600
Message-ID: <20261110163247.48712-3-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110163247.48712-1-b-brnich@ti.com>
References: <20261110163247.48712-1-b-brnich@ti.com>
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
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN2PR10MB4256:EE_
X-MS-Office365-Filtering-Correlation-Id: d5c51e52-1745-4d02-64f3-08df3f485c79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|261028144727099003|261022115727099003|261021121427099003|56012099006|261021135927099003|261022105027099003|261021123027099003|261009223027099003|261026121527099003|261026140227099003|261022075727099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IxfZJkUb7efMVZ6XmEEZ7ga24u7in6kejQgEuL5VsrQkQInNEdKw38jO7V2dYgCWmPJLI8t1VWfOqzkYB45v/TuugWzck7LyssW8bSKSft87tlU9bDP2m/KdbNk9hJ8EeT6SLNP8E6fKFRMZnRyJXmQTyCG/AaMl0K211RxJCiTmvPlPZI0shhSzTgK+FNbxHardesNQItt/OsmpFEKkfph8BgOo7/4Zquqp3tJTWJGN53CBvm/BRUfVznB6qLANyi234AxyyHnwQST6Tg9xw06T/Tn61bQisMZOev1ju4hGou0eZ8DdUp185ve/QdV5g2nZ2ushqNC8fz2PE+2mY5+XV6w0EDcnFte3JpfXsdUADB4qzL4nBL6q7U9KqESQTG/qS0H+MLDrArXW6k3AxwI+XIC5q62Fjk4JWYHfS3lIL9CE9EM/MZr12xWQgZBvS4whA7yr/Bf7HvYsq5iU2CGAPyd+unInQT88ni/Er9OhLqZGo2ifyYnGV0LoMLUg42DwgAE2ohQlpH3hg+O7z7MCppNOia1PUOVti70kjGZDAsFxCGVPzYH91IAI+tSFjWPbZw7PGeo1oESpnTwYsfIqrWTZsD8aOzw6XwowUEOBm2Yg+SwiYJthR8fcMGre4r+kDcZdyeLozNGfr+EududfvJVmK9NGNmx+jPCsQZiCGTQ4/Dw5COfNbTagi5mZ8I6w+VCuojNwpa3kTWx3RQ==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(261028144727099003)(261022115727099003)(261021121427099003)(56012099006)(261021135927099003)(261022105027099003)(261021123027099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261102123227099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QRn5WxXew3DusoW8mch2LcL+H+ds4oEFSzbGvWkb43DIOO4ylUyRuUszAymjCslHLp7N++LRqvQM2BB6VQDbaik7xEEb3X2YzmwpAvas0xP3QrAR4zln85Emx60DcSzCgjbLLgOqaUKJj7Hn2qntPviO5+K2U8Z3juUUFs4EhIl7DjAogHvL7BO2QMoh/LZjPhuTIKiiRl0RBQDaqoPVYr6M6RCSIfs6XlAX0e9VTKRJPobPJXSTtUPB8VRHsAUl4o/v5gEu63DkNiVyKp7eBn07bFV5gOAgcDlZ4ZBSe9pVtPJtqqXrJy/aIJrqnh0Gf3JAe+QJP68hTiRalZ1FCDWFaFW5YkiCSi/WUW1wEVLployAA7f3WkXONM+iM+BA6RuIKsOpqR3fpo7hOtH/K/FSf6FYeAkmCrYxqd74+Dz+UulXSuxdwo/+76eRSVrD
X-Exchange-RoutingPolicyChecked:
	W1V6pCwoPXRv+jPrAOrLA05sJ+bhZgVX/WeJYWZHXAdWO4nLziGVlKMrxUj6ra+1SdHUgD6+mZ9UBmY3dCnoYuHJlIb1Xi5hrIAbmUqDFOb/4f3hPpn8A+DhRT2TSpCDUZ1RJpEcsVoy3zAmbr7YoCqMV0xJH3z4QencXQVQe7llT0kSW3hUe5uZ7yEJaRr2cXpwdxcky7keQ3lwK4CkPpjkUSINE6ZX0JoG4X0T/GNPNWLgvU6Vd95Y9OeHTqZWJqILM7HTHPQFb9PVlX0ohYmUzzLwWJuef3EfWolYKS3j/JL2RNQqyjaQOZ93c1oXNmMtcFHuY4WhPnxsSTopZw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:33:33.0331
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5c51e52-1745-4d02-64f3-08df3f485c79
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4256
X-Proofpoint-ORIG-GUID: xGyIJ7XlL5yd4E9AitSgeZiUtzzsCqsM
X-Authority-Analysis: v=2.4 cv=bcH+w+PB c=1 sm=1 tr=0 ts=6af3475f cx=c_pps
 a=J5CYyyHZZtesdUd/yj239g==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=jwouBfj2j3NM8CExmVVE:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=-BWrc3HdS1PG3WIIs5UA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX3PadczeNJem4
 5GvnNP0BTIHks5JzVcNBYXJvZRWiqOgz6+lbOdPZusfIEwZAzTTi/fPc9jDo+gfJT+FScmC3fBM
 gabBIlGegz+zCXpvF5NXnmsbdOQP/IqDkVMdd7iBkA19R53zo5UeubiDBRYSl0Bi4xITneNVVr/
 j9wDxPz7HHWZ5Zyw1T4psEazXVTT2bYmDFZexEAjvlOnlcI0qVqB4eS78ZPejb8p+QO2QzZKxdq
 RMIIP/onv+y5wfkjbKVwCbBoP2Cvjk7E+QqlQksS+Qq44jYUF8I2opT1xSPzrDIl4Hq2Ypvmd0J
 zDTYs+zeLV2et1N7/ic9xFXP9roSZUekAYHdACGYCjVi2bS5ILL6pEeROP4xDbmqbBEQIeI7e6Z
 7Zq3PL4B1cDCAHutS7FP8v7J1KcMe74nJEZQ/TNulOHQI5UFbNVShiyoTuklrfv6IZ0+zBAS3Ml
 l578/oda6mCKKC+iDcg==
X-Proofpoint-GUID: xGyIJ7XlL5yd4E9AitSgeZiUtzzsCqsM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2NSBTYWx0ZWRfX7OgkWJXSrVMy
 DUZ/yFYDW8VwLhtfbQPAWXQCJglO+HYGpU5Mfjow8bsRKnsgaaGNB/yJODJ62Wi07lxYejQ64mK
 qv/TpFqyZ+v2QI7qJscHxx2g1I4jJc4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100065

clk_prepare_enable is not called anywhere unless CONFIG_PM is set. This
means without CONFIG_PM, the JPEG Encoder will not function properly.

Add this call during the probe sequence to properly configure the device.
If video_registration fails after clk is enabled, clk would be left on.
Make a label to cover this case.

Update e5010_remove to ensure that clock is getting disabled in the case
where e5010 was not suspended when remove gets called.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 20 +++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 23d06709a6929..17ea616ff1795 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -1101,10 +1101,18 @@ static int e5010_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	if (!pm_runtime_enabled(dev)) {
+		ret = clk_prepare_enable(e5010->clk);
+		if (ret) {
+			dev_err_probe(dev, ret, "failed to enable clock\n");
+			goto fail_after_v4l2_m2m_init;
+		}
+	}
+
 	ret = video_register_device(e5010->vdev, VFL_TYPE_VIDEO, 0);
 	if (ret) {
 		dev_err_probe(dev, ret, "failed to register video device\n");
-		goto fail_after_v4l2_m2m_init;
+		goto fail_after_clock_enable;
 	}
 
 	v4l2_info(&e5010->v4l2_dev, "Device registered as /dev/video%d\n",
@@ -1112,6 +1120,11 @@ static int e5010_probe(struct platform_device *pdev)
 
 	return 0;
 
+fail_after_clock_enable:
+	if (pm_runtime_enabled(dev))
+		pm_runtime_disable(dev);
+	else
+		clk_disable_unprepare(e5010->clk);
 fail_after_v4l2_m2m_init:
 	v4l2_m2m_release(e5010->m2m_dev);
 fail_after_v4l2_register:
@@ -1125,10 +1138,13 @@ static void e5010_remove(struct platform_device *pdev)
 {
 	struct e5010_dev *e5010 = platform_get_drvdata(pdev);
 
-	pm_runtime_disable(e5010->dev);
 	video_unregister_device(e5010->vdev);
 	v4l2_m2m_release(e5010->m2m_dev);
 	v4l2_device_unregister(&e5010->v4l2_dev);
+	pm_runtime_disable(e5010->dev);
+	if (!pm_runtime_status_suspended(&pdev->dev))
+		clk_disable_unprepare(e5010->clk);
+
 }
 
 static void e5010_vb2_buffers_return(struct vb2_queue *q, enum vb2_buffer_state state)
-- 
2.43.0

