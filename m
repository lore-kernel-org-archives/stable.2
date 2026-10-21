Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792556044;
	b=YLPlWJBtobw2mupym4Rukzij4Ya8OPt95Fm+zD3xwXomdvrD+jTZ8KjAYeQ/41vTZNfJ
	 ioRkOkMehzLPAZQQB3IZPdSwvduXvzDPYpPsd6DXYKI26mNFZsiuAXJl27TCP5w1krmB7
	 Zph64eLpxFi/FqBQF0msKRgl5CL8OOuDctQTWT5o5c1aZc0eYIQiBbCMEgdAdm544wo7d
	 jncGZUaSqEZrt8lOgSnTzvztnHGH1rH0+do7RfW1KlBOrYF/7dRpmObJYMIL56EGjbEJ3
	 nD0Ta1xCL4kARJq4QeqB5Z7+TZQQAhqzg341XshH+PtaKP+ApoYUx6kkUOB5LE0NmnA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792556044;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:CC:Subject:To:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=a715ZyPshsuUtwRocdoUqtu9crP4ByRYKLKxT8cV1j4=;
	b=HAj0M6rkTPDb1VOaf0cQIcQC9FmonJDC/ad1EtOIJ1mzQzx+7l7TY7waHODgEkCCRa9q
	 ScnCcl7ZOTNAgHXNl2dAds4qQemnBO7jKu12PAy0Oeb89A/XAyxwW1soqUPYbTMzeTFd8
	 tg7KnQduJTzVRjx6j7+Qi+ME9aAdGGuIKj9HUJ2dp79CD08OmtIUCX4ANLxxrdW4ASP0Y
	 N2xsdkrkUYIm0PeINl5fAYZXPvtwIfDHnnABH5qh7Ub0bbAeyol5jcYP4u80H9jsJc96y
	 DlDoics1NlhiWRLOZNyRYEsYMfnDYLH4vzHDodv7glANbePcTyhkS6tZxqGf2z/MVzA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PhTg9HNa;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QRkIqBiQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE08606A319;
	Wed, 21 Oct 2026 04:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ADE08606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=PhTg9HNa;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=QRkIqBiQ
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L3DoKX603415;
	Tue, 20 Oct 2026 23:13:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=a715ZyPshsuUtwRocdoUqtu9crP4ByRYKLKxT8cV1
	j4=; b=PhTg9HNaJMIW4Ty/nAZgW5WK/IipDjZ5n+ts+YGJ6NRq0Y+x0w9B9Abuf
	peWxtLawkXRsFS3hc5R3tGBpUZpbpq5AMgotPiCxZOhU/uskXm7V10xLWk62wyLB
	oxTk7Iw1VNHmNzAfhyDXDg/LNUfoLp4nhyhSS75R7mMK8JFsvFWmYm44w/D4nA+Z
	yWfLBxiQ6r9KRkArtUeLT+abYciCTunr1PAd7QOe/QKq91iKcoBzJyUiXgn7WU5U
	cZ3LNdkD7HwX8GGiHpYqFWLzYD8zKGckRuh9VQUv55G6NstbCTj6rQeEHKghdFIp
	i3bz1VDHl//UFt62hQVqTpxLG394w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012068.outbound.protection.outlook.com [40.93.195.68])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4henaag7vk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 20 Oct 2026 23:13:36 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BPn20pMDV1Fc33Mj2LhZdqE6FGWwKOFPbaivnnv0hDvF742urRi3Un+14KJmnobX3XSHUkcKFOftlQgQYhUxezs0i9e1bGIxjv8+sQex/Nva5pSfjXiH5HXd/rj9YpjpfEg4KNGsL+Xt+aByr9TGmNQ6EAyktuGqLW0r9+0BNVzmkKiYW4XhR9OAlIfHa/MBqCCYWbnXNQcCHD+8d9DUSJhLlCOwvG/oLnERVHsky7Oy5R/tVbXqZqpmb6rWFmHPrpbvbu7UAsFQDm6mYegnywLQTC4l+LmHk03047AYPKuOst0cgvsTlBPjXU+s7FLL0rc435pM4jCltuVw9Khh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a715ZyPshsuUtwRocdoUqtu9crP4ByRYKLKxT8cV1j4=;
 b=dXxEuGXOntNdt797Y2oCnPB4zuP4cHXs60EaG0d82jAUPgp4pgbj+etmqLjvkIauqEpWwc2701vh7eQNmRhwbUqTrxF52RL/8FRO9pirlO3/FjhoVJG+xLQYN93qLxawjnDLjrcPNiSABiwYHMPlFcDuBHLP2WApzBtekcMHiO3yqybaxRHxPosKXtR+rZj0EleG0vVr110wiUX2mkes0an0y5l5/TxGG16FBI4w1m1BOxEFTpCCp21dR5y2tE1brE1h/Gfxg1XA9GugGbL0PO5slptmDUgc+js7BDF1Btx3srY7NZOWV+zmRkDE2snv7dXSjDBaELBiUyH6Ioi+0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a715ZyPshsuUtwRocdoUqtu9crP4ByRYKLKxT8cV1j4=;
 b=QRkIqBiQR4/smxUIDoy2dW7fSsAueuAC0PRHLXArd7KO7Mv3iYVJnJ707A76BjxJcm9KADCVI+EKfOmu0YaeUfez8+l5rLAvm6pg99hLox4ab+QK4d+7s1MZO0d7svEQtBeJqlUGAVoN5JOUh2ReRMYBnHrUpBzZqTi/Bfsz6aM=
Received: from CH0PR03CA0069.namprd03.prod.outlook.com (2603:10b6:610:cc::14)
 by CY8PR10MB6586.namprd10.prod.outlook.com (2603:10b6:930:59::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.13; Wed, 21 Oct
 2026 04:13:33 +0000
Received: from CH2PEPF000166C6.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::43) by CH0PR03CA0069.outlook.office365.com
 (2603:10b6:610:cc::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 04:13:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CH2PEPF000166C6.mail.protection.outlook.com (10.167.244.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 04:13:33 +0000
Received: from DLEE203.ent.ti.com (157.170.170.78) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:13:21 -0500
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 20 Oct
 2026 23:13:21 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 20 Oct 2026 23:13:20 -0500
Received: from [10.24.68.238] (uhda0492258.dhcp.ti.com [10.24.68.238])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 69L4DG2G1857072;
	Tue, 20 Oct 2026 23:13:17 -0500
Message-ID: <cfdd08b0-d52d-48e2-9cc1-9c75e5b72357@ti.com>
Date: Wed, 21 Oct 2026 09:43:16 +0530
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <netdev@vger.kernel.org>, Roger Quadros <rogerq@kernel.org>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric
 Dumazet" <edumazet@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>,
        Keerthy <j-keerthy@ti.com>, Kevin Hao
	<haokexin@gmail.com>,
        Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann
	<arnd@arndb.de>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <s-vadapalli@ti.com>
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
To: Karl Mehltretter <kmehltretter@gmail.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
 <c20d708a-f4d6-4e66-a516-056d93264825@ti.com> <atZ8lCW0VVPzoHwb@gmail.com>
Content-Language: en-US
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <atZ8lCW0VVPzoHwb@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000166C6:EE_|CY8PR10MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: e3129a83-75c7-4f28-7eca-08df2f29abda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|18002099003|22082099003|10067099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kLOUmTISqm4UqEqo6JYKWkcmWSZNyZZKiZhzGWftO0PrI6ece2gaiLyNQEj66dt9TY5FFHE54VLOylOBXJy6dm4s8I3oYoDKSStXBU9g+n4Jya0/5EiZwFodvbLeeGrUUXJRRzu8b5C1v+vPocv9y9aoWzEDkvyMVzfyOAEOqkKxnsk+joiQJ2H8doJQdjl26LdwpKXn0+tO+l5l3vlqshFY/Hgnpa5b3PYrUsOlzUbXfuX8Ie3Q2MG+EdiMcXNKat01HUPsKpQDWWeULyW4/ncUrKj12xsbsSnGUml0oGia+3eAEmhcSZYsj64GmnWUUkwE3UEaFSd7ZfTkk+v2nxNCfObTT8/oJREIJj4Y7xu9xHNKm6pOvIZBf0K45j9MCHruUe6e5crKBOjhzFkl6sVYG7dCAdt4YqAZJL33AK4f0o53G2R5ZrUJpCB+EKchuUcsz/enm8yPSSzErIhrSRCrVZCsO4UA5w9OGZF5ljx/jxSpwk1mHrBLaQxDM/gBTg7pY9uKPLpsJymZR2Sho4gtRs0e8ZMdLTVGqhlUfM0HEa8FNbkDCaA/Z2fy6BK532l8RJUjJw7aZAbNrGNpkQLDO839idzu6cNMgg7dRa2hlcA3sox5W7G6r5OcqvUYaShyQv2BHIa1x02fWBi3Ve27f1mLCgk/pBiG49z7Z3TUEKqH0V7QBbmxFGU27pMrknDtcCCwbmzypV7L/ji4Dw==
X-Forefront-Antispam-Report:
	CIP:198.47.23.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet200.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(22082099003)(10067099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TUHJbsX+3a32tILhmQUyyXXWYoaTSlLhF+NbUCqpCg3k+xUpK5hmYGOxb69CwzCSfnQOBCos+Kcb8x8v881o3DGJUTYHOc+IwPlLdjYLA8Lf7a3NalCrT5Ptgdjqf1poEob/bW+XZ7ZLt+XWakahf96aZV78YDj4XpSNvMzJ9FMuLQ4URyepqoIA/xd/wLW1YDxYdgmiHXDNtqzSgLIYpUIFB48uMWkGs0oHX7O5+Ks/IL9XrCOfQS/cf8Fm2pULv5t0AbOq939GmSwVamBDejwwp92oa94YGd+jIzu4lIpfgNE9dXFnT+3MlNmzUqV9hd9xyIe+aMD56cT/Ai3yk5RI/+qM8yAqg0aaax+s8XH/GPenOxMey+VSyWQ4XnDJi8BoRxg2fWJo3Vu2YWGbKaUic6hRkR25wHY4oYHH3WvUf6iG1OMzgm9iMDi+GVwE
X-Exchange-RoutingPolicyChecked:
	LY0omibT/0YH+0uJ2z/q1ZaovsbiYFMdi+/BnEDJWTB1Yop9z1KdmdoJFrEBb6U8bHXPK80LzjfUuj3eu+GyaCLZSmGOKjsEiPNQdpUANb0LfH3D+8WPnMbRNYEHSH4AuK9uBzmNd1KVOBNRoA+7jmJIv1z0Ler3eo4q5rP0JpMGM4dBkfIyHQPbUCi52OvKLNDswov5aJx7uyzpgIbLVR0VrSLhCUqUnxYiQ5wTdXAemG+dQjcVrpC5dCTzLSuQIzy2bisj9OBpyIDqSkHBKdSNTOzuCH0wnxkmu1YqinaCoTgOyFfyoXHL6Om4309frofjXkBDnqyW1wlY6nhDSg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 04:13:33.2238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3129a83-75c7-4f28-7eca-08df2f29abda
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.194];Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF000166C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6586
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX4SiNTdoaaRUn
 FpRxbI+DnMUZH+NuctS/6lPp1HaWAipF5tuquTtyhjCugXhHE9snPS47GbR7UHzD2tqcr71SYSs
 OgQswPg3iPaStHvikuL2F+jsg04nAbc=
X-Proofpoint-ORIG-GUID: Ol6wSHxRkQMQiyervYvzUTRP6a2BfexP
X-Proofpoint-GUID: Ol6wSHxRkQMQiyervYvzUTRP6a2BfexP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX4pGFwshuW0j/
 Dy8yS2qpOPks2DmbCsXfcDweWQK+o1sJjNl9cydWEhjbGkl+ADURu1XuVutNyd5tH48/tpRTZrE
 Hz3SMTPHcZCWRDeW/t7G1/VnEhMz5CZPk1QSmbaBBrjRmmK/amOC5qxt+xrn4zBUJehN44bM3V2
 O4Bb4pT/Na+RwRMx0xlSIGzccMnWCOHGnZv/Y44ZGHdVmcwWN6bApJRwYLo9P5YmLMVPQY+lExL
 PTXh6WZwnvT1r2o8D8EHrPwCAJqXtbHrYbBxQWRdxilH8NfxT2etIkdLFQ5CYa7s1aIID24BQ+X
 UaS1eo6Y0tfR22K42vWJmQPRTesEklsNj9IGO9J+gKy5l2JLx3BrXyNGMx3XflQEG88Wpmhhm/z
 GbOktIIDizQQwWvv79Uiny2Zq1QbZFpkmeG+COajGlTq51WxSaNQjZOIEOsgg0y9+Dj4MEM75rp
 moYr8PocOoN+iYaqFcA==
X-Authority-Analysis: v=2.4 cv=cJB1IVeN c=1 sm=1 tr=0 ts=6ad83bf0 cx=c_pps
 a=VErjObUdaCniAoRVWXewiA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8
 a=mrqFhlF1Oqc6JB3Vze8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210016

On 10/20/26 2:07 AM, Karl Mehltretter wrote:
> On Mon, Oct 19, 2026 at 12:19:11PM +0100, Siddharth Vadapalli wrote:
>>> +		unregister_netdev(ndev);
>>> +		disable_work_sync(&priv->rx_mode_work);
>>
>> Although the above code is a refactor, it appears to me that the correct
>> sequence should be:
>> 	disable_work_sync(&priv->rx_mode_work);
>> 	unregister_netdev(ndev);
>> RX Mode work (cpsw_ndo_set_rx_mode_work) does have a 'netif_running' check
>> so it might still be fine if the sequence isn't followed.
>>
>> Please correct me if I am mistaken regarding the above. Rest of the patch
>> looks good to me.
>>
> 
> Both orders are safe here. The worker and unregister_netdev() serialize
> on RTNL, so a worker running after unregister exits at !netif_running().
> 
> This matches cpsw_new, so I'd keep the current order.

Thank you for clarifying.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Regards,
Siddharth.
