Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013067.outbound.protection.outlook.com [40.107.162.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEC544CF52
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.67
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625242; cv=fail; b=cXtiz+13KJRmI+mxzK0i2EQQBFObs/9OHdFLEyuqzABLmNFl+dgX5UDuQa1aC6smHnT2pLPZ94DZXATf8NrAH1sshW0Oe0h2RkuYULdfDRzIGTGhu8d5i9KrntMYS7TVeaz2Ji7hi2DoqR/2qnTGloG0wUSZuoqrYdMFU/5+9wE=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625242; c=relaxed/simple;
	bh=1lOM5lyLquwvLwv0GHfA9aCl0qnfhP6/ZTETdNb3Kxs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GyPXn8g0prcOv1N2aWiozUQYEzubR66NzsNJjI+XwQs2Z3O9DqMbG6hZy2L2p72SjFT5n2adkkdcEROwm5ehJFTFsj/ThTBWk7ukTzgR2O2uTrc/anCIcK1T/zwhkm9dLplju85gvNBuk0dG4E0pF2Gq7bzNE56868rqSCEMi5k=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rcPCTLvV; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=rcPCTLvV; arc=fail smtp.client-ip=40.107.162.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rcPCTLvV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="rcPCTLvV"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=HVc2wh35aCs/eAATck+iiPdX2fyIgdQqjWEKC4kelbCI5P2U3HKe3B+GGfBq1n+Gz9jj9cvrlc7JaEVpSHDoCv6nbSLSxPY2uATqd1PHcEijpp4uMmZUyREJJwO4lvcG2dRDzcPpDFti+fFATcPtW0FGh6w+RrCTopXdbMplZ1W/J80QvMh/tSw7/8YL8/QgPPXL0f1CZXKnQQuVUjOQ11hFu1MNuY4rTSDz+dlde5UyCdoiHA8KWxEyWuM3n9qVeQ43IStfzG0NTsMcUVc5HWX+2RXZgGXIA5wgWHgWAwIud9PUKzKr0Tp+k5PkGOpLcP5qn8a6+eafBl/PMpLa+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBu5/7/nW42CXAUQW1Hoijr+feKzD6WmYiJh35qkma4=;
 b=Ixk22xvxNrDSQtyDFpW2JoqT42QTlUuuB4Qy4o94H1G59g19sh70hJWJgQc/JeTJMTAizSlXVDRoTPy5dCJ3rkvqZUw1ZtnL/tc+GdMdkVAw88fWLpJ/k030ul1bUosqE4Xq6j/AT723wNQDrHZ2lwF0YPost22cFy1tbx0KgUG+2cdxbDBEwBsj0Pc3GXnSImYNYyaSh5PQuqoT5xcS6xAX+jrjqTIYp/PWuY7Eg3SGRU7gNfh4sSxfKCaoNjHMp9dl0CKG1GqvunyIATtUmztS/tZpRGiJJ7Z3vsennYNzvSXINh/cJ4nI32Qo5SflIwqu88iPfXgyUhycESpH6w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBu5/7/nW42CXAUQW1Hoijr+feKzD6WmYiJh35qkma4=;
 b=rcPCTLvVBKhDoB6essXzVQxgLsIVlV8m+MJOmbquxYHeLsyyNf/S5loFWpCcU/EhdqkXsv4/sA/CvNupQ3N2BqCECGnVi7w8SuQj8CU5DU1qJoKpS4ukfx3if8O7xSPJ0532hgxTYNZ/NdVDATtuqGEohBhA4FKD+ifcV7g6G+8=
Received: from DU7P195CA0005.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::24)
 by DU0PR08MB7906.eurprd08.prod.outlook.com (2603:10a6:10:3b2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.16; Tue, 16 Jun
 2026 15:53:53 +0000
Received: from DB3PEPF0000885F.eurprd02.prod.outlook.com
 (2603:10a6:10:54d:cafe::69) by DU7P195CA0005.outlook.office365.com
 (2603:10a6:10:54d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 15:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB3PEPF0000885F.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.8
 via Frontend Transport; Tue, 16 Jun 2026 15:53:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRsPzCghiX6jHKhz90Y3HGEjb0I9Bjy+Yc/toKIXm6oMfv2NC5SkcJ5Hyh4M/hXQLauwz6b/XhXnycE65oZuIHTMVOIE+ZHs4DHy/UaQV9169NK5Jr9BHKu4sEqW84OXAfdR/6tATThujqaCurpGXaWgx7qwO9ijADBM+ldIfJHHFmJLdUuLlsik9HVQUc9V8yys4hzsZlxGt6k1X9/jPJfW05s+RvymmAwqNJamaRQO4y6iBBFJdWBSYXJh7yzaHKaj1x1WBvKztujWndUbv8Bdcvr/YUENvWFfUFrxhC/uPFvpu3ZnM8onz/35NXQz1TtrQRHPuCKKF/Kig+9fOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBu5/7/nW42CXAUQW1Hoijr+feKzD6WmYiJh35qkma4=;
 b=Zwmbwy+IeIG61nLx8QtCUheHQvW7k5de5cg68YNmIKnlZUFpZSEpgUd1WHoD/+vRy5XiEhyhy5g8fLrgQFFKYN0ZqJI88OGD/0JgTwuWYkXJHGFFbL92VA7vFRv0a5FkP9gvYG5QWs9MpvOuZm+ZUkiVO40XAz0/facIiZXfNDvIKNt31WcBf5tYcbBH2p4kyoHra/PoR5jyLZZtg0yFbODmnVndOQZmiA0VbsFU0ulhmgNJHNWvVCmhZgvL7MRaBoA3ah3bJpGb01ecZs/ESoQfxamxJ1T0HL46uZJlsOLiijL29nj4smKCo3QKeCZoPmCfuA/rY318HqcL7YAxxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBu5/7/nW42CXAUQW1Hoijr+feKzD6WmYiJh35qkma4=;
 b=rcPCTLvVBKhDoB6essXzVQxgLsIVlV8m+MJOmbquxYHeLsyyNf/S5loFWpCcU/EhdqkXsv4/sA/CvNupQ3N2BqCECGnVi7w8SuQj8CU5DU1qJoKpS4ukfx3if8O7xSPJ0532hgxTYNZ/NdVDATtuqGEohBhA4FKD+ifcV7g6G+8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB9981.eurprd08.prod.outlook.com
 (2603:10a6:800:1c5::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 15:52:49 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 15:52:48 +0000
Message-ID: <521c5907-cdbf-4603-a24f-405d30741e28@arm.com>
Date: Tue, 16 Jun 2026 17:52:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: cdp: reject CDP TLVs with a length below the 4-byte
 header
To: Piyush Paliwal <piyushthepal@gmail.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, fberder@outlook.fr, stable@vger.kernel.org, nd@arm.com
References: <20260612074730.82719-1-piyushthepal@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260612074730.82719-1-piyushthepal@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0542.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM0PR08MB11733:EE_|VI1PR08MB9981:EE_|DB3PEPF0000885F:EE_|DU0PR08MB7906:EE_
X-MS-Office365-Filtering-Correlation-Id: 805d8129-8043-4fcb-0047-08decbbf7685
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|6133799003|56012099006|3023799007|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 jLq6dSCXEnxDYxirvadEAfgd7KCuHZFUg3uo4hSrHmDKTjxczsM9aDad6XWO/inclwkvfyc4ndIq46NqFSdGoYcRYj9YmCClvx3ZJvAKd/l7WtN/RATA9cE59EN73XeagOl1T5iZ0fmrNTpbjbUU4yOx1MEjqsYqvAQYUpbwefYAGMXMkPRVlqan1CjLNvi8CE95AH8Sj9rJCtrd1n0ueB9GA9b4+UzA34Q0/P5f4uE2FWKMmkWVBrUwdua6c0FQ3nSwfSWIVNDKqRUhijo6P696rv3rUZ7P7PNPp10Rh64uVBQB7w6cFnxo+20TpknkvQ+FO657J6EP+ksYTbcTdkuowUlUevNMVTr1q6huB271fNlJArY6z1Ou5kAFccMWAr3B8MhVplGonQ5DO2/vxqpHw1k0tCLhjfZP4+FA7TdqXgqy03F4wc3aHItuAvDM54TZLjFV1UNepldIp4JZGyOJNdCCVjze3RUbTmpy0i8/732q3H1ahecKaTI47uBfXnuwkb//KFrPMr3gVDKShR01nEFmH3JWmfEzzFIViRhA6kjgyawwPZVBTNWK8wWYOiFDR80SlCipTzX9f//V9yoVvgRSLTw0wDLIFhDITOJueixUM1uBoqxGGxDVbijgEClAND3m7XIsKowm+bfoQYUS3fE4XmNxXs1Gj5zGvKNhYu4ArZTpiVw8/6KiOMzF
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB11733.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(3023799007)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 lJ67a7PP36q/B6e/VMPVbxT32nCkKVGFrzEy+nFxTXe+zlrPQRLjjzHc0vFr+oNIcJutPuZtrSZ6alzmoNLsZ6xqIN21fSd9Zevx1vXw29o6ep2H30IGJS5n/cNhUtkhoUo4/pD6SOBJ0DQOL3y5SKrwSrnWoQz/7O7dC+fABvLx8/iVQQlW/yo32qI6aCopNVcO4tsZrvhtCFEduU04sv00TBoB9UUwgF4O+WSQnQ2nCrgMOUhw/HjyYEPWDrCrw7CQBv12RKNXJulqRlkf+A2Fi5rAoyhhTRDHXhTRzoF8T22SHsmVchpBN9uYUu8aLWeTwSG912WxYTYfaov/jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB9981
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	f91c7c4d-3800-4487-7d3f-08decbbf50ce
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|23010399003|376014|82310400026|35042699022|36860700016|32650700020|18002099003|22082099003|3023799007|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	BZZk9NfgcnXCGCt//j4ASaluC0/3KFmNXWaGuMutZGiFAvI0IDs8kypvBLC13komU6eJda+BMGKrYc8n9lV39qXXbT9RCSjkD4wL4mDqolccBtjyvzxTvQXVvqcFis55kP7E+tfmUX92l+jqmv9rmiIO7lJtfn6zqD+CsiGDlXazJ8zQV6TP6ie9xvzp44uLIE0U36qD9Kcj0SJWrC4UYkcchq1U/ZcpPlMosIKmPgpkkJQTSw/k7+rxu3X50VzkTx7sn+14qNSw4YInAFjYsSCmgtp2huJIZnOAk412/p0kYZPNRq1O9F6ln5KaYu7ulkjTryCFGGyvDyd8wVGqd9YsvWU3WYV5hOnPeiPysGYwadRhZhbs9JwyeVH/f9wu4+RtTwbxeeTRlVHYrNj7crTnJe7ZPSgOAwCmtakHGkJAGcgtCqKQ5CDYUHE+RtN4BVlkTbQr2RpV3YPYp9Pvkp+NPd/+ZgWT2zNQ35ziL6AREEi0HoJxWI4TnJo48rMOmIPI8yskqEtd7DPQnNtZEOi14lGVRvSt6tmqvhYMn3o6R/GEgdS4w3u6XhYGv+WhRqSru0s4Lrw9N/v4vLsPjTnAl1ap7Qj5cvA+8AIxL0hhPUpEIhFh+MkWyZxeh1tinl+9wZj6yfCnltvTDE0SvFljq7LGBuQTGML1YmhkiQMeXoq1hCYtxc+FmPNomFny8qBqZcP07POhOJoo5+JEmwmkN3Wdm3ek4jFnU297jDA=
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(23010399003)(376014)(82310400026)(35042699022)(36860700016)(32650700020)(18002099003)(22082099003)(3023799007)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6TccuUgs2sd6pPC0WaxwZsdRup/9pCZbcONPNWJXyxiJCoZLCbWqKM0Uv3TWHNnQMqUiap8zkWNjF32Gs4NIOUteO7zdLr47ImYbG+SYy9Psk241NxmG/Y/Ea6utqZYVwCSvY4wOXa7/Xp//7q27A5OX2r6NWdZe+MKDycLbl91ZMap7FaFTlsR7jI+CDlNdLWNbyF/t4quh1GkiTqSTuq/ThO28+sLuQ5Hb+YQBGZLMml6weUUtYrnw6ndl2Img1HT027NM1p2t2SIlRSxeQ8kCStHGU5a6D96uIEUIfQg1S1XSyAhhKOwQsrg905LrjRF9Gm0Y+l1HJnDgROy5ACxoHqMFMu2D5sg0AVz4sf+utdscVdKlZWJqqu+be2DO8fRmE3QCiu//ccBzZQoMYGHyQ89U/OjqBQOQBep8HYi4M2AbNiT2sRW5Ak+mg4Rp
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 15:53:51.9797
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805d8129-8043-4fcb-0047-08decbbf7685
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7906

On 12/06/2026 09:47, Piyush Paliwal wrote:
> cdp_receive() reads a 16-bit TLV length (tlen) from the packet and only
> checks that it does not exceed the remaining buffer (tlen > len). It then
> unconditionally does "tlen -= 4" to skip the TLV header. As tlen is a
> u16, a crafted TLV with a length of 0..3 underflows tlen to ~65532-65535.
> 
> For a CDP_APPLIANCE_VLAN_TLV the underflowed length then drives the inner
> "while (tlen > 0)" loop, which walks ~64KB past the receive buffer reading
> *ss each step -> out-of-bounds read (crash / info-influence). A length of
> 0 additionally fails to advance pkt/len, hanging the parse loop.
> 
> Reject any TLV whose declared length is smaller than its own 4-byte
> header. This is the same class of bug as the recent bootp/dhcpv6/sntp/nfs
> fixes (unchecked length field), in a sibling LAN parser that was missed.
> 
> Verified with a standalone AddressSanitizer harness using the verbatim
> cdp_receive()/cdp_compute_csum() routines: a 16-byte CDP frame with an
> appliance-VLAN TLV of length 3 triggers a heap-buffer-overflow READ that
> the check eliminates.
> 
> Fixes: f575ae1f7d39 ("net: Move CDP out of net.c")
> Cc: stable@vger.kernel.org
> Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
> ---
>  net/cdp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/cdp.c b/net/cdp.c
> index 6e404981d4a..300b3d5c409 100644
> --- a/net/cdp.c
> +++ b/net/cdp.c
> @@ -276,7 +276,13 @@ void cdp_receive(const uchar *pkt, unsigned len)
>  		ss = (const ushort *)pkt;
>  		type = ntohs(ss[0]);
>  		tlen = ntohs(ss[1]);
> -		if (tlen > len)
> +		/*
> +		 * tlen includes the 4-byte TLV header, so it must be at
> +		 * least 4.  Without this check a crafted tlen < 4 makes the
> +		 * "tlen -= 4" below underflow (tlen is a ushort), and a tlen
> +		 * of 0 also fails to advance pkt/len, hanging the loop.
> +		 */
> +		if (tlen < 4 || tlen > len)
>  			goto pkt_short;
>  
>  		pkt += tlen;

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Added to my net queue for master, thanks!

-- 
Jerome
