Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=67.231.157.221
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792689141;
	b=KJl7TsT7p7Ck2qlKaNZU7juMQZF+YhzvtDdqVm3arCux+K72c3Dc+KFY25mKsyMN9R/n
	 YcBhtgRzKwV2iVyDQ6ngFROjwA1f6i0Z6TpP56Ny+BzH9LqgJn5kSGmDlCCRW+DFBJACN
	 G01f1CYvxie42iANNNZWSRY7PaB0isiZvZFrnLVFG0j2FKoS/VPt7ApyqkkeGVfsjfbZc
	 x6yZJ54LAnDGDd6MEZLW0lU4LSO09uOJ4X48zZJkiUo4f7m5C5XlRpLD+e5VZdafaNU17
	 jjPaj1nDzJD848uOrQLb2R4WNageJCjHMAXjzsmbfbUScZDrs7kqnJVF+lotVws9nHQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689141;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:Authentication-Results-Original:
	 x-ms-traffictypediagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Zscaler-Block:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=+eoFd54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=;
	b=C296DLWXb/ybULSNO9OdLDPffEN7mCqy+E7HgYWWdShzEPSv6MX7cqL9NRde2IzUpR0I
	 cscgjtsAOPsxxEqC1wmBOeN3LrysgXjAGX1R0Qm5MzIWaako0NdB4VdJ6j5E8A8iPo6d5
	 g0dWe0YOBLxyn6KsNpFz/WvAK4o4XGVYoqTWHW2fmGTgxZWR/Clhxz6HlzIXm+CqxKqST
	 lkm9BfEOXaPJbQP3md09LC3DduecThrTPZk3cCX5tlT6QxYfozZn6E/EVVSDwC4HBRQRn
	 CriUeRP8B1FS7NJPsg73xPwHlJz3Em8EIujz3P4923u9HSyqzS9RqpTWqGxbasikLVw==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=netapp.com;
	spf=pass smtp.mailfrom=netapp.com;
	dkim=pass header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=pps1 header.b=TKNwoSUD;
	dkim=pass header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=selector1 header.b=XOlhths+;
	dkim=pass header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=selector1 header.b=XOlhths+;
	arc=pass header.oldest-pass=2 smtp.remote-ip=67.231.157.221
Received: from mx0b-003fbd02.pphosted.com (mx0b-003fbd02.pphosted.com [67.231.157.221])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA04606A319
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 17:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EA04606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=netapp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netapp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=pps1 header.b=TKNwoSUD;
	dkim=pass (2048-bit key, unprotected) header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=selector1 header.b=XOlhths+;
	dkim=pass (2048-bit key) header.d=netapp.com header.i=@netapp.com header.a=rsa-sha256 header.s=selector1 header.b=XOlhths+
Received: from pps.filterd (m0412384.ppops.net [127.0.0.1])
	by mx0b-003fbd02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MEC9rL030350;
	Thu, 22 Oct 2026 17:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps1; bh=+eoFd
	54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=; b=TKNwoSUDbbvw9rD2Cjby8
	pqjCVAXW5v/r6q1b3WdZfYVsDzZrTqDa0Y6h+zqzs0tobffVitxCLFt1smqiy9Ix
	VKqnd1JAi5ucgu31OPPs3iauXRZeA+2vK2+bcaJBn31WPPW9PtIwJlkmSdtqnx97
	bH3k1UQsGIeSFyS7isN64jJD97OOOJVXxm0sFAvTb2SKUCCBkRPS5/TiV1s+xuW1
	HQ/4XellE8+SvuGaaEYznwjDNkTTLX9KqA318x6ZRxX526+nVzbpvfU60QErv1bQ
	zMhyv7zn3b3D7W/xRSMyOc6vCw7WkX1zQ+ZVYtJ0ni+RLOCqnzMO6BzJl0PfZeRj
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010053.outbound.protection.outlook.com [52.101.193.53])
	by mx0b-003fbd02.pphosted.com (PPS) with ESMTPS id 4hf93ekdfb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 17:12:12 +0000 (GMT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=tnIqkjr90Ao9wLCA/AkJZpK9d4L7tBey4+6f8BMn27RMnAWt1GSpZzmwRxMLFg3JQRCy/VUBCoa9hE5VqJjTG8phoQMMkNJm9Shtq7IWBx05aCcoFxsmtsd3sYXz2ojiv8lCXHh95+L/onIaxOrE6OIrzu+jCkf5Pr7m9WzfwOsTiQEuQrY3bn8ROWiDvRIKajZRfb2w8otSeIC26ilPulyZ8W+3N+08VesOXo915ijF3bGK/Q4SgA7aLZNGw8JppE/aLheFtV61KbABiySH6lXRjZxE4fqjzcPiDEAUNj2Zo1gLeJIHTVcdvpenJzkiweQzWusovPE7m151+79WBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eoFd54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=;
 b=kD7XjxQk8YNPLaeW93qbOqRGlCySNVmyJxuuCzsIiSWRhpPzDRpNK+2Xkq+LFHxLyXeyK/54AUMOSvc5+2Zx2jXXRhhR9CWU/Zg6F7cKigX4M+LpMaciyg+JSL4cysnlyzVHNkPpkcrKIm45Ur7zdJAcMvshVaWWDygkMQr9B6jrJ8XmzEoa9jk6TdXbU4MZfydHylJ+c3VP2yLG62OkYSDTmsEJmN2xiz0lSStxciSlrtkXpotuU7SCRiwkeKqY8M0q0FGwuwjdJGkdA95fB5+J+vvZdmEc+wRobHbUulgI/d0axub50O9PXmfJMaLO4M5UHRVrS3jJqJSnIp77vQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 136.226.142.114) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=netapp.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=netapp.com;
 dkim=pass (signature was verified) header.d=netapp.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=netapp.com] dkim=[1,1,header.d=netapp.com]
 dmarc=[1,1,header.from=netapp.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eoFd54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=;
 b=XOlhths+UdrXXTRjEzE7x9SA4dPy56NN0CD7nnBxxG6puR6GK5689xT0Z2fWSJm8AB2E1gI6mq8/sZxSRvLBJptGPi7EWLhpgeORIVSRv2/r2EvMW1CJNS0iakY8bwCNYqwHTfyQRiZ8wyttT5R53+D1ehK+8TM6mvNamw1uUFyqJJTiuTVVvlRyTf3L2JvOosQq7iug/m54dYG16Q1RjiFrSk2KILDKJxLkU8ysPVQcBE1b3i0Vr69UOMD6wbPiFsaYAHF/UH31gNtsKiyK78ILNPk4BHIY7KJCyjK9h9TL7C8s7U/uAi3IWg+TLK0Vw33yILgTgILgL5cUTmfkAA==
Received: from MN0PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:52f::11)
 by DS2PR06MB10861.namprd06.prod.outlook.com (2603:10b6:8:2ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 17:12:09 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:52f:cafe::64) by MN0PR03CA0017.outlook.office365.com
 (2603:10b6:208:52f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.17 via Frontend Transport; Thu,
 22 Oct 2026 17:12:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 136.226.142.114)
 smtp.mailfrom=netapp.com; dkim=pass (signature was verified)
 header.d=netapp.com;dmarc=pass action=none header.from=netapp.com;
Received-SPF: Fail (protection.outlook.com: domain of netapp.com does not
 designate 136.226.142.114 as permitted sender)
 receiver=protection.outlook.com; client-ip=136.226.142.114;
 helo=sjc41b5.mail.zscalertwo.net;
Received: from sjc41b5.mail.zscalertwo.net (136.226.142.114) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 17:12:07 +0000
Received: from dm5pr08cu004.outbound.protection.outlook.com ([40.93.13.100])
	by sjc41b5.mail.zscalertwo.net ([136.226.142.95])
	with ESMTPS id 6ADA43E408C40001;
	Thu, 22 Oct 2026 10:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y2p1Cu8D6txGLXUY0W5zk7NuJ/S+Al+U5y4PAQv2Bv5si5IEAvJlfBICf9g8jeaEPcopIxCve6Ckpa34dghid4VlohAsK2mhRLmojVPXPKi5EnhMofkmR8CDtQQUV+/azBOxSQXInI529h07QKuOK7oMRR0tRR/kjm0Jz5Y6SisTPGRzETCg3SgHAhMY6PesWkHxKuQLJYHmfpz9PG84401Y931XWxpArO39RXqo8aOCwSQjk8Y4NPDgkHDf+jh0WZxufc+NAmCB5ME6c4K8TsICUXM1xX//PzsnBOdjpq54x2y4k4kR7gzWeii4ENjYC4+VYIdt7knxmYXkuHccXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eoFd54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=;
 b=iWtMON72CF9Vq13uabLZzcN03s07NZTHDS4OSvlsLmIuzsGQ3CfTJ8JSkuK/1AU/Ob3ra1nFBduXGUeZv+cIgvCT7TdBFDVKH9phnkngPZEpOTUwfBBj+636vWhRBohayZ9H9/53JcJ+bJgxwyAuXlF5iCWp1KxgKl58L70i4Y5r1M86PxPgb6mHfX1UsqiubV8PDMyRuLFoJHzm5D7ZyACaDsGE6Vt0/pifQMpyb1PVwXC7s7tl78GWPqhpeqvD1oHl8lE3j11FH2dpnuxB8S2edXvq8d8zmUGjH/QHgAnM6yIynSBToee5Q3uZDKE12e1N8MCkf+sj1moq9iA5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netapp.com; dmarc=pass action=none header.from=netapp.com;
 dkim=pass header.d=netapp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netapp.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eoFd54elbXL/6ljr2xmzaQLv7LDmOAM8Cro9lNPtZY=;
 b=XOlhths+UdrXXTRjEzE7x9SA4dPy56NN0CD7nnBxxG6puR6GK5689xT0Z2fWSJm8AB2E1gI6mq8/sZxSRvLBJptGPi7EWLhpgeORIVSRv2/r2EvMW1CJNS0iakY8bwCNYqwHTfyQRiZ8wyttT5R53+D1ehK+8TM6mvNamw1uUFyqJJTiuTVVvlRyTf3L2JvOosQq7iug/m54dYG16Q1RjiFrSk2KILDKJxLkU8ysPVQcBE1b3i0Vr69UOMD6wbPiFsaYAHF/UH31gNtsKiyK78ILNPk4BHIY7KJCyjK9h9TL7C8s7U/uAi3IWg+TLK0Vw33yILgTgILgL5cUTmfkAA==
Received: from SA1PR06MB11353.namprd06.prod.outlook.com
 (2603:10b6:806:4a2::17) by MW4PR06MB8468.namprd06.prod.outlook.com
 (2603:10b6:303:12f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 17:11:48 +0000
Received: from SA1PR06MB11353.namprd06.prod.outlook.com
 ([fe80::ff:880:c010:68bf]) by SA1PR06MB11353.namprd06.prod.outlook.com
 ([fe80::ff:880:c010:68bf%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 17:11:48 +0000
From: "Mora, Jorge" <Jorge.Mora@netapp.com>
To: Jorge Mora <jmora1300@gmail.com>,
        "jorge_luis_mora@yahoo.com"
	<jorge_luis_mora@yahoo.com>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] NFSv4/flexfiles: calculate stripe boundaries from the
 file offset
Thread-Topic: [PATCH 1/2] NFSv4/flexfiles: calculate stripe boundaries from
 the file offset
Thread-Index: AQHdYkU1kKBY94MDrkGEXKM4xtNWorcJyrCr
Date: Thu, 22 Oct 2026 17:11:48 +0000
Message-ID:
 <SA1PR06MB11353A3A4E0F8AB96D26509CEE1652@SA1PR06MB11353.namprd06.prod.outlook.com>
References: <20261022164826.38125-1-mora@netapp.com>
 <20261022164826.38125-2-mora@netapp.com>
In-Reply-To: <20261022164826.38125-2-mora@netapp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=netapp.com;
x-ms-traffictypediagnostic:
	SA1PR06MB11353:EE_|MW4PR06MB8468:EE_|BN1PEPF00005FFF:EE_|DS2PR06MB10861:EE_
X-MS-Office365-Filtering-Correlation-Id: 066e8850-399e-4b44-ad57-08df305f9a4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|38070700021|4143699003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 uLErPYEIC1QtQFNgGwPoaAVE2lMm42aWsPEK4IONe5JelYrs+Y40X82Wrv8BzRevqXCwk4UmRNl55x1muvu2djANQSZM61UYGPQ8lid/zwfI4p85kPLYjOU1dnwoTnILccq8oe3MAp84ytXN+1YGQqbDhl0oZ8iIkLvuB4+J4Bsy2hLVuI2pcRLOwyD6ctj5jb63vXgE9X9xkPnj3bMkJRxLvNr8JoFRe+1r7z2bv3LE73fnp3zUAABSzDnOgFQXYTWx1+Cmm3pJF/HA0+AuRl6Nbgf90dr15xOefjAxM/nWYewJ2U5+p1SDTidZXeK9j+plH9t3v1NE2SQe+iZYxqS10AT6X+Wj75ygxNCydJOnF8XsSoi+pXJBJeUUTzVTaEWwHQ66J+HtbAgWFtVjnVpK3GW43lXI74uUIRNbYePZUOAyuT0CkXoXzeOTvqvdbrBo2Wrz62x6FYLJZGiTwASq4g2kqdg0hzcTWOotOdH1B6o1EDmn3vzy8/kie6cauKoAq92ElLXdXPAcfpcje6p+OSo20GeINec0FsRDplfbcZhnr69MUKa0H14XLmaD3mUcCksfKxpzGbpYh3/oYsM8XCu6kai2UPyFjAHRFuYFMkOaC2AH7H8792y3IvRTjJ6alWRUH4FyPoNuL64gI6VaUlM4hjEdEJqd6u9jnLMhOii3ghFOwZwzAGAACJhuy0dAzwwIYrMDGhr903IhyQ==
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR06MB11353.namprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(38070700021)(4143699003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
 SfhMHDjk7UAMdCnhPGa++n2ptw7gsUDrYq5ZaNPWA2rXzJQdBXh06QmPV0Ym+2reyRuuYtYr05aqv5PxiJ3j/iwmQIhNBdUd9mWHlhpF4snfI6IxWVQYN3l3/IwAlkT/s6MQ43CuoZUKEZ5o8wlbFP8eXqU5bGHZ281GmWQIsmMXg0ifzv54unGhVd83GbiDaos8W0RffOpDZ7KGQ4lzJ+kE9uGvCHg+6+KWGbzlbFUrpMuZ634oo7MjNJGf4/VN1rqUDNS0GxzEuyIXqQHx5K1IdNZfb7b2r3RxmRGCd2sWmScwuKsoDJw63pkqNnOHcGEa7P5k0Wtzb7XrvySCRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR06MB8468
X-Zscaler-Block: 0
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	d029ee77-a4f9-41ff-4e52-08df305f8e98
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|36860700016|376014|14060799003|1800799024|23010399003|56012099006|11063799006|4143699003|22082099003|18002099003|6133799003|10067099003|261021121427099003|261021123027099003|261009223027099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tx8cYX6u5Elvpp1wcqzNsDndL0SvPmDxdwyARwgr9hBUYD/XdaVBrSNMFL5lqvoRY1FTLqAyMuWjzbBBWEYxXOPtBEVuOxO8fFNpc2oxATGQKpSYMEdxD/VV1vMs1X9XonQ4mp/6aru95QXSbIOBM+YyqfWcEfZ4bVj6I70wprvI+Qb6t5yKuv419GwdawPkqgKbbwBd0hZUwmdywSCWQvkSEbtF4ca/9pycizTHaswPCdFmXDUOD8yGKrAVZ/bLB0+UsWrAsk+gQVjfjrbMk/DMZoIM5iPj+jrmvfPAVFfsHr39/pBOZrZf8z34N1uUCYGkHIpxrR4afw+S8WGXk/zJehtWwbEUqy9Sl/nPdxGwlLmLYQIMKbZ6P/FfSQPkUjBek7xQrIUeZ8JhbAaqFhW1uFS1Oi8HhZg741RoNx89UnBouUec+4ZP4ytXI2R89TqgMRG9Ze8WYURTY69H9YwfOrTFGtZwas17kV01qncr2B1J7W/CcheBIFqUBRqH1XQAQxVwuCO54f7hX51JgmdOwPNHjqVl4fVMrSXih1cOS0zwRmNZzuKdw67E+gpQBU9VuyQsZ6OAphc/Qfm35Vbe3/mIKw0oZdofPKoa6iN24TrRaYrVOD57qrObJePqoDLvh8wyRGQHOBx4Kj5H06vQ7Mkt1S1PKsUeexhiFXkgDf51H7E1KYsE/eK44kZMh4K2qQOHaRVJMFNzNPvGFw==
X-Forefront-Antispam-Report:
	CIP:136.226.142.114;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:sjc41b5.mail.zscalertwo.net;PTR:sjc41b5.mail.zscalertwo.net;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(36860700016)(376014)(14060799003)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(6133799003)(10067099003)(261021121427099003)(261021123027099003)(261009223027099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r7JQvUr4istDik6jo0ObTvXJr6rbl0xg4mzUBAL+oxq4m40o0rr2NA7z24A+702rqCJ7Jeyx6faykcSEALSTT01WgoQCkexonKqjAKp3AiSj+t//z5VzmdQI6b8dabBSH2xCTqfQPe/alPm+fw4tbYpST9IXA2SKI5t8RlRjbUnJ88MWkL5x/VnvbdxZz/W32pjOMUVv4xlkmXKfPFXyMEybAI2N005U7TZItvYWIA4dWXBcEH5fzswnOH1lUMrEQUiQctziFYrEOQhKXOQV+YoMLUpMW9aH+Is7ccbIhGEeAThgKfKcf2/lFCVy1jbAVwbLMlRiKBewsSpRMc1Md3al5Vkpt80ojcC4pDte0Un6Zvr8EqiTPN5ZSPEHc10OT16nIyIfa4TuzvXQH4vwneVdBjz85K9qZ+d+CkGhnGNam6bCvzFkeP2elAPgFIjO
X-Exchange-RoutingPolicyChecked:
	QsGbxazZnW4N7t2OavUZVNUz5rsy82/5Sb0tJUoEUEP1nzemqeGb41y2jUXlzJd2T5bJKPtqb3Ml9vBFOI7lOQIn0qzwQIYUI7UP7y4m+1RD6+xX/pHqaSWQByWqfsBgEiVHr5zrhFYFxcuB39BYDDnKEb8+sCH+QKejrr5hmWHzoZg0JHL+mz4Ccu5RmIpoABCK5SFxuCr9jSs91gmz6pQmCxrYixWN7QrIcIkNKyCdpnEiXFvPiB1vvMCQVqzba9wTY3zPqQr7jxY51NM6xHPWf9RZDvYv8cEh/OgV3CUcsmuQsHPlc3jQXeH7ZLHqKpAM0kjtFgFPJr6KNp4s+Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	gQ35NCJudnK1tuYTsPTx2kLsBKTH8AGelgDVIyge45MxdDzHlVcSCjiHSPEEdWxITCSfqAvAitY4FqFyWrwgwdrmeisECyGbWPUGDkTnaIeRld0E8Lfr9FPX931mOhHneKgqjC2aIOX7OinWnQE/5qVt1/CdXkS8v1SjV1QnJAg2A0xVqQNn/PO0AHNH1mPa50h/IV+P6caPatScvi8LkW/Lyp22BpR+VPzQzKw/lMdFHNQo3p6l5fxz/TAbvOOikt+F4asvUy0f6o3DWJT8G6Qpem82NkGSXfAlVTZW2gcTaI9b4EV0TqAMXdKBNfiMI4DXcmEtgh9Hy44VuhdEfiDxZMEa0SUvEOSWVQY2HRVpCByOxUJzi+VV4ubDWfBGtpz9Rni5Gbl93chbvTwkXyn1TUsZwNnWIPiWroFx4kAmbQW4FLBIlYjg0D0rVgaUk//AA+BtWUrf6fI39jOfdRZ64tMpAJcbPtGwshdvPZmQdb7KgIsxPK4h1HE99JlKAc73E54KzdPV80yXhBnHESAU4jCDhsxDy/HRQk+54o+/5hoxA+J3UFiIqiZ3Zro2dsuquVliyPxlNQpHWd5ZiiZqjZ1rOt6RsHRnu5IfBHowFcVtDClninF86kVqjxs1
X-OriginatorOrg: netapp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 17:12:07.5612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 066e8850-399e-4b44-ad57-08df305f9a4f
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4b0911a0-929b-4715-944b-c03745165b3a;Ip=[136.226.142.114];Helo=[sjc41b5.mail.zscalertwo.net]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR06MB10861
X-Proofpoint-ORIG-GUID: Kl7i3QOGyoAfJJkvQhpF_sEo6f3roQs7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA2OCBTYWx0ZWRfX1ZfIz3hCh5+r
 gWblSUF/EvIEBeqUnVRjPTE0Y4+lSrI27fPHOkS6Jx3HKG5RCgpMOXT2UEgV4oPAGjIYWdeLf2T
 BIN5LwLbGuor7pGiB1fx5TmH26bI8O4=
X-Proofpoint-GUID: Kl7i3QOGyoAfJJkvQhpF_sEo6f3roQs7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA2OCBTYWx0ZWRfXxLaItjKCA3aL
 pU2d8+c+6sdIpOKSaCWbmQ9rWB2kMq2/R19Ip4+pYwHXGsxcgncRSn04UpepHyPYb4+pyIvtFhI
 kLq16ror3W+x7sRyC00PWvAaAJ287zOjHa1WdMfN9l2N3ZgJDH81UQq39dATGx7hExa6qnqrx8r
 4+Z/dqWVRGCmX/k3jkp32hstM9gbnWTjGsUbm2jePS/n4fWBRGfEsw7a7A4aYCkgdosySQvCZMW
 ZrKxVsAEDpn88o1YefhhHikkK7LA7gMSbE4aMWUMbY404Yz7nAK7R9a1wVK+Xh/A7ybdxu1sN7K
 fPi69LvNPNmbpqje7BZn+bJrqqSQuHFpezdfbQ2ouX8ZMxf/hRcjbF0s92DrQHu/g2ZPViX0MJz
 B+eYXhJpSl0XCOGVU58MxVE/h6XGqVXeRogxjgBFw8k4MABbVtzJPtXdkFYXQWdBdQFTFlwV4HE
 Y/aVvlUjj04DerNQyww==
X-Authority-Analysis: v=2.4 cv=W5GtxhWk c=1 sm=1 tr=0 ts=6ada43ec cx=c_pps
 a=XYxO6LlR7Df2C67LKP0s0A==:117 a=ykUZaGlhMcAjilxMIcqxIg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=660iZSQnnn4A:10 a=GWG4Yq0kndkA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=1lWG0UuNQvn8UhQ8Wh4S:22 a=aI3CQ4rmUk7SosRCZclN:22
 a=_EeEMxcBAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=CjxXgO3LAAAA:8
 a=JDjsHSkAAAAA:8 a=ov7d9uJKH4Utnbgp72sA:9 a=wPNLvfGTeEIA:10
 a=dseMxAR1CDlncBZeV_se:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 spamscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220068

Please disregard this message.=0A=
I was testing my git sendmail configuration and it automatically send it to=
 stable@vger.kernel.org even though I did not add it to --to or --cc list. =
Also, this is no my patch and the author will re-send it soon.=0A=
=0A=
=0A=
________________________________________=0A=
From: Jorge Mora <jmora1300@gmail.com>=0A=
Sent: Thursday, October 22, 2026 10:48 AM=0A=
To: Mora, Jorge; jorge_luis_mora@yahoo.com=0A=
Cc: Mora, Jorge; stable@vger.kernel.org=0A=
Subject: [PATCH 1/2] NFSv4/flexfiles: calculate stripe boundaries from the =
file offset=0A=
=0A=
[You don't often get email from jmora1300@gmail.com. Learn why this is impo=
rtant at https://aka.ms/LearnAboutSenderIdentification ]=0A=
=0A=
EXTERNAL EMAIL - USE CAUTION when clicking links or attachments=0A=
=0A=
=0A=
=0A=
=0A=
ff_layout_pg_test() subtracted the layout segment offset when splitting=0A=
I/O across stripes. Device selection in nfs4_ff_layout_calc_dss_id()=0A=
uses the absolute file offset, which is also how RFC 8435 sparse=0A=
layouts number stripes.=0A=
=0A=
A LAYOUTGET reply that starts off a stripe boundary therefore moves the=0A=
clipping point while the data server is still chosen from the file=0A=
offset. After a data-server error, a direct write that crosses a stripe=0A=
is joined and resent past the real boundary, and a later read of that=0A=
range is not split.=0A=
=0A=
Clip with the same file offset used to select the data server. The=0A=
segment offset remains the covered byte range; pnfs_generic_pg_test()=0A=
already limits coalescing to that range.=0A=
=0A=
Fixes: 4934ccbeaed3 ("NFSv4/flexfiles: Read path updates for striped layout=
s")=0A=
Cc: stable@vger.kernel.org=0A=
=0A=
Signed-off-by: Jorge Mora <mora@netapp.com>=0A=
---=0A=
 fs/nfs/flexfilelayout/flexfilelayout.c | 18 +++++++++++-------=0A=
 1 file changed, 11 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout=
/flexfilelayout.c=0A=
index 7fe8b91fa..09d44de26 100644=0A=
--- a/fs/nfs/flexfilelayout/flexfilelayout.c=0A=
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c=0A=
@@ -996,7 +996,6 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgio, s=
truct nfs_page *prev,=0A=
        unsigned int size;=0A=
        u64 p_stripe, r_stripe;=0A=
        u32 stripe_offset;=0A=
-       u64 segment_offset =3D pgio->pg_lseg->pls_range.offset;=0A=
        u32 stripe_unit =3D FF_LAYOUT_LSEG(pgio->pg_lseg)->stripe_unit;=0A=
=0A=
        /* calls nfs_generic_pg_test */=0A=
@@ -1006,10 +1005,17 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgi=
o, struct nfs_page *prev,=0A=
        else if (!ff_layout_lseg_is_striped(FF_LAYOUT_LSEG(pgio->pg_lseg)))=
=0A=
                return size;=0A=
=0A=
-       /* see if req and prev are in the same stripe */=0A=
+       /*=0A=
+        * Sparse flexfiles stripes by logical file offset, the same value=
=0A=
+        * nfs4_ff_layout_calc_dss_id() uses to choose a data server. The=
=0A=
+        * layout segment offset is only the covered byte range.=0A=
+        * pnfs_generic_pg_test() already stops coalescing at the end of it=
.=0A=
+        * Subtracting that offset here shifts the stripe phase whenever a=
=0A=
+        * LAYOUTGET reply starts off a stripe boundary.=0A=
+        */=0A=
        if (prev) {=0A=
-               p_stripe =3D (u64)req_offset(prev) - segment_offset;=0A=
-               r_stripe =3D (u64)req_offset(req) - segment_offset;=0A=
+               p_stripe =3D req_offset(prev);=0A=
+               r_stripe =3D req_offset(req);=0A=
                do_div(p_stripe, stripe_unit);=0A=
                do_div(r_stripe, stripe_unit);=0A=
=0A=
@@ -1018,9 +1024,7 @@ ff_layout_pg_test(struct nfs_pageio_descriptor *pgio,=
 struct nfs_page *prev,=0A=
        }=0A=
=0A=
        /* calculate remaining bytes in the current stripe */=0A=
-       div_u64_rem((u64)req_offset(req) - segment_offset,=0A=
-                       stripe_unit,=0A=
-                       &stripe_offset);=0A=
+       div_u64_rem(req_offset(req), stripe_unit, &stripe_offset);=0A=
        WARN_ON_ONCE(stripe_offset > stripe_unit);=0A=
        if (stripe_offset >=3D stripe_unit)=0A=
                return 0;=0A=
--=0A=
2.52.0=0A=
=0A=
