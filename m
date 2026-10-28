Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793198346;
	b=jtJQwLq9bnhkD57SsFBlnbLJT9PFj+x7YBH9QtJtDpC9YwYzpcBZyhftqTdUx3qAe+cb
	 /4RR47bfC771clcArj9e6FP15jq/N3LduNZ+cpScAdzgOg1rZstxHxxtvUwtoda9dWktT
	 eh0+8qDzpLX0qda0oojrTWkYbC+BQvSbSfFdtDY40XO3epCyE4eWWGtS0lsJ6lOOT04/L
	 retwgRAO5bx45iAdK7J4EhMU8fWccoQVuZtd9BvW7dRS2d7on5RaIVC+FbNBMqO2Ce2Ad
	 ZzdAGJvukFEiSaqW18bAa4KO1RO4ibNdOfYxoRVLubkfFW0KQZGSwsV7ywdQTFfOT2g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198346;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
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
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Reason;
	bh=y7NSQ9BTszMsg/QCwTPe7j3lK7jq89CtPEY4IDSzbhQ=;
	b=ZX9wwzfBkbdLffUvPQOnfvum2JlzdQ+ZbND5lWRjjolnspPRY21qbnGgMsjmeQDUuYuY
	 yXxbDKi8IEQpR13gQobYJ2fBWE8cHnwqDSyY8/YZlIjDKsLHrlbWLnO6IfO7D/yYvqB3h
	 ICJapMGKucTXnIiEvUWjbAP2+sIngo/8RX4sNeRSvH+TaFc/FstBEp63UT3hJqh3Tr1nZ
	 K03CZAaC4xXIY1PAfbxzhhWHx2vjAfjlvadVcCF1dT7pf8fe5d00LkhPkiSeYVy0oArvq
	 r2LIrYSDB9tL+ICM+cZpRzTlExntuYC10KxmgVQJPgaSB+dAF4OoydGTO7NLiA+vM1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=opensource.cirrus.com;
	spf=pass smtp.mailfrom=opensource.cirrus.com;
	dkim=pass header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qlGigFwN;
	dkim=pass header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WcfiRg46;
	arc=pass header.oldest-pass=0 smtp.remote-ip=67.231.152.168
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EB606A31A;
	Wed, 28 Oct 2026 14:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419EB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256 header.s=PODMain02222019 header.b=qlGigFwN;
	dkim=pass (1024-bit key, unprotected) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-cirrus4-onmicrosoft-com header.b=WcfiRg46
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SDLqqb3203640;
	Wed, 28 Oct 2026 09:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=y7NSQ9BTszMsg/QCwT
	Pe7j3lK7jq89CtPEY4IDSzbhQ=; b=qlGigFwNTUpcq3xT+yKXQ5z3iYkFtVY5SL
	ScUugETt2sKU9EMKXYJ1B04UIvWce1y08EuC+ZIvvcCcEamydmPX9uzisFozoO7g
	F59QkqwJZfeMBk7yD2v3y+SFHTi4YjxwHIhh421fNSHhR2EOSqERIlFhbtqpiyWk
	8Jrt+ox6nCDaoRGk0HpXyaHrAVyOM3txeXtUQqgCbRlms23flc17dplzHdQ6HWx7
	pJo1+g3fEXq5dhWd2odPvhNNNsj5Z9HH9g38gcPQQU9iS93xja8VPx8HkHY7uWx3
	8f921ux9Z+YFfAfSbVrgCUe5fBuiptrWyeqV5SWFIdF5gPrsvKUQ==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11020098.outbound.protection.outlook.com [52.101.46.98])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4hkhv804f1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 09:38:42 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjOHKMTO3Xpvn99JRJqINZIYn3ihHpPpCL34SNhYXicxTlReEkATvRX4wrI/+KNltdYBiSw/q+FU0ntGE/QtvLipnBDqC0OS67bZXwEbRcKYMG7cjLH/q/vdmQSFLrvxFObuPNIr/+kk6vZYpBXInp+5Bcdn3qwOap8zFwzmyM2PjYQ5aV2NA3kPvtU5QsvnFx7JIOtS4Tr6zBIlbEE/Jlgilz7FBW664/HcJkU87MJuXk1uPvQXHCu2F64ksuG8WeAjdwG6y2mqmeYzv+wEu1G+OOCcLepcX5qPgnL9I/G5NikQsCqqBOH6R9oehwyBqABGqZM/da0o8t+O9fXsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7NSQ9BTszMsg/QCwTPe7j3lK7jq89CtPEY4IDSzbhQ=;
 b=pvmE1eh9dsCb4aWyMEeD3qZoBXtFQCmOqT5PGieYGva/rUOnu+0DebRAoUNj/euUeyPdh0V+z1Q0gqdbKlCmDR69MAG7RobMHLYbtwkAstKyNQIdYnTvKMUuLgMsFdOuzE3WTrGK6RU08z60cHNUQLx+I99+WJAnINang2Va4bz77zkZgQy0g+yS28aEyLBxxEdudYqCDyXVTtDyvMT/LmrZaUQSGBGTiwuxp+r4gzN9tlmdgyyvssTd7Ofg//0IAszJEtD8HebeGkQMLGvMFmjjJweYJsqg96xhizmUPsoA+en7dgHHZvIMpOTejL0+y/MC9qV5IGozNmTA1kr2nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=163.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7NSQ9BTszMsg/QCwTPe7j3lK7jq89CtPEY4IDSzbhQ=;
 b=WcfiRg46IPfw21XtCm+R6HgLPg8pmIpJm/p8QMLpzTCALp0YhpK36Slh0iKWf6c9E8noY2DQ6oDTDfZr+1eXirnCPAWdgHsZ/kCXjAFr8zHMY/MM6CIcDyooQStAjd3E/B9EaezDlL9p0mT3QSOlbU9hJ7d3A52YnCg5trMlbLk=
Received: from BN9PR03CA0356.namprd03.prod.outlook.com (2603:10b6:408:f6::31)
 by EAYPR19MB623050.namprd19.prod.outlook.com (2603:10b6:303:2e2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 14:38:39 +0000
Received: from BN6PEPF00000074.namprd03.prod.outlook.com
 (2603:10b6:408:f6:cafe::87) by BN9PR03CA0356.outlook.office365.com
 (2603:10b6:408:f6::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 28 Oct 2026 14:38:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=softfail (sender
 IP is 84.19.233.75) smtp.mailfrom=opensource.cirrus.com; dkim=none (message
 not signed) header.d=none;dmarc=fail action=oreject
 header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 BN6PEPF00000074.mail.protection.outlook.com (10.167.248.201) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.4
 via Frontend Transport; Wed, 28 Oct 2026 14:38:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id E1799406544;
	Wed, 28 Oct 2026 14:38:35 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id C7C6482255D;
	Wed, 28 Oct 2026 14:38:35 +0000 (UTC)
Date: Wed, 28 Oct 2026 14:38:34 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] regulator: arizona-micsupp: freeze charge-pump state work
Message-ID: <auII6tZWxW8QKWgi@opensource.cirrus.com>
References: <20261028045001.99474-1-yaojiale02@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028045001.99474-1-yaojiale02@163.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000074:EE_|EAYPR19MB623050:EE_
X-MS-Office365-Filtering-Correlation-Id: c2409aa7-f32c-4620-1790-08df350126b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|82310400026|23010399003|376014|36860700016|261009223027099003|261026140227099003|56012099006|11063799006|261022075727099003|261021123027099003|261021121427099003|261022105027099003|16102099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	o/FTx9glNwWH/adqV5FBghwwThjbHkzzpJ/PkEm4vSWgyOacLjmMdBs5Um4yTOYQVYmZkfMdtpnG0c24XN592T7vCHkQSAtloh+etsDvTklNYsxvcyWruUPvUJrRcfEL/J+eaQ1sZcn1phCefYF7MEMORybLkmLWIO63yCoXBmCPlhoIYtFbraW4ao8Z6wu5LivGGoGQP+pKyHF+qAbriIlpq7fU9/WKhv/om8bvvEUHKQcJPWfDzgog6Xj6SXe90lYisDctRnzJE0Llnf5KGZ7SKcWUzMXtI19DFDGoAQSOXw0SQ50SBe9S1ZQ5O4ps5aJsWQ/OTNpzidqy/ThQMVXMM1BJNxSJ2PgWnWg0sqwJXeysqgn0wyRSEdnBb4sfL9o0ZY9XNAKdDZl2VcjjM326NoVzIbMVzvBF7t2SDPgq2HJKTpoZb37H2oPZyMNAxo4IzIZCNgsjApRt7gm3DAcTaSjRTIqtR5MECfdcirgB6vXFrGT4n5HZ8UpVYcpXpt1WVyoXkld7+aQo/qGLzyLIzlUI09VE1OqqWGtAtHjN0XuzhfdV1lYIO4UAP3Km7LgUauaG7aggr+ysFIt8iKpml8dBZmXeWkAuWCyDFFAEMujzXIMT98qPHAS05tO3Vzy6LIiEc+tJBIQFrZF33uIMuw1hQp7bUYNnP+lm06vDxcNOH0kHV6q9A9Z/UDC0OPbpuGafe5zHu+raqo0AMQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(82310400026)(23010399003)(376014)(36860700016)(261009223027099003)(261026140227099003)(56012099006)(11063799006)(261022075727099003)(261021123027099003)(261021121427099003)(261022105027099003)(16102099003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z/jYGae44jAJ8Coc1Z2Gbghjd+ex/APIt1GYAcZb23KSTqU1fP5qSbUZ5FIHDuQF/jBaPb1LOe+dp3eGPHO0S/lRxKPLRgIBBoohfZf7/JveKoo7ru3fb4YjoPw73lFTsfeuJzdEGMeZ7cejoozpjePanWq9sf0mnEshK35fd1O/0GtZt6C1l7AZeI6K4grfnUbNJQddBQtRvtahPX15RdG7RmsbUHCHqysQgbJBB+c8b3FD4N3DIkA0BruDZTsBaj78NcMkWwvy2rSWvrYv3EcmlTBW6OawsbDiDW/A4kC7KnmquR8qUUMJSgphi2D2lt69n5hHKcmd5ixZfOAquZZWv5VerRw0I0OcvsCJOJxg3oQA+nwa3Fl94TzKwJS/zL/hQyAfyX4OEVI3d4dK9VshH+gPK5l5QAK8e+yKWxJUQpOAGO9WNCpuBAEgye9c
X-Exchange-RoutingPolicyChecked:
	Nm4ra1nvHaXR2xdwMGgYe1bi8qJw8lpwC8LsWSfaOzy81MO2e8/jo3Gto4Uo+U4Bhq2Vetc46THM42Nn25VYNxbNYQ2VMuTwetfdDPr1q/w5UltST78kKOn1mmU+LGIPhI6T0UwJD53c0PjLc4Xb9g7mfTZouaRAm1BgO1ZkzHMPdyYHIha3Dqe0RFJC0A3SwoEeAPgg59uFT8grnAboeipZ3L5QIPV2sF01S59F7tXMtnhuJJAEFqg03MWpA9laOP3Quh7RZPzfPpj8+LKfVNuCpqChg2z0WQ0atnIC55HSqc3Uw3pQWcSSB4j60KXbihqydRRYoWYU1FaJ2ic1Cw==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 14:38:36.8593
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2409aa7-f32c-4620-1790-08df350126b8
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN6PEPF00000074.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR19MB623050
X-Authority-Analysis: v=2.4 cv=DpnDa2/+ c=1 sm=1 tr=0 ts=6ae208f3 cx=c_pps
 a=jzpQLMhUvwWo5cn4Ul+sFQ==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=1XnwcmcVHSl-bROfdDIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX9F4Frqhcobba
 uMs0m2OWodfJryq+onYw2N7LUDdAbj7X0UxtjkfbARlEuQHUnTBZY3EbvGTqisS2GQE60rjlS1R
 nECJ2mOyrFxvcjox/sQQ/E9Lymscd/ssiH/aoQztXRyU4PkYd8NFySoUHP7PiSXCrz1cA812NiQ
 MvN9z9l3Vvowrl5OQxztH2hUEjogbe0GmgRM4e5YJYo/lBQCLrCswJEBRbjYcbEhkIzyUfBWgIv
 IHWWiEpG96a5naU/p/gfYGARm3wTUrazFRz6+DfKs/gsvd/1VT9F08d8McxjKggIMZlG0O1SO4h
 bpfmE4IcjZmE0Qznk0AnUv44fZeLGOTsm+CXmQweJcqXsfF8xiTu5GRUAHk1eE5fyPWSGpM/i6P
 9CSWm2NEaI/CvTHfIoWvjhzVI8Zf/iGOLs+oB2dFYyyQL24qewPij/+ndbr0P0jsLkqeVhwE/ZO
 3nn5q1D7BDJFYI1c8cg==
X-Proofpoint-GUID: a6CNW5YhrYm3FGDS8cy2aaUk7xyvRgSo
X-Proofpoint-ORIG-GUID: a6CNW5YhrYm3FGDS8cy2aaUk7xyvRgSo
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA1OCBTYWx0ZWRfX79KvnrlHhMYI
 JA+arlDK3FP7UUnuEeTDyMYkrw7jviSUccsR7Tvnta5aK1wjJNK2hUqqv/fxL2QesveA+I7Id2U
 ODBGPtKqejBBf/gv6JY3OkesdS23C7c=
X-Proofpoint-Spam-Reason: safe

On Wed, Oct 28, 2026 at 12:50:01PM +0800, Jiale Yao wrote:
> The charge-pump state worker accesses the device through regmap and then
> updates DAPM state. It is currently queued on system_wq, so it can run
> after the backing bus has suspended.
> 
> Queue the worker on system_freezable_wq so hardware access is deferred
> until devices have resumed.
> 
> Fixes: e6ed90581bfa ("regulator: arizona-micsupp: Enable SYSCLK for charge pump")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/regulator/arizona-micsupp.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/regulator/arizona-micsupp.c b/drivers/regulator/arizona-micsupp.c
> index be7208bc7409..ae99173b8236 100644
> --- a/drivers/regulator/arizona-micsupp.c
> +++ b/drivers/regulator/arizona-micsupp.c
> @@ -78,7 +78,7 @@ static int arizona_micsupp_enable(struct regulator_dev *rdev)
>  	ret = regulator_enable_regmap(rdev);
>  
>  	if (ret == 0)
> -		schedule_work(&micsupp->check_cp_work);
> +		queue_work(system_freezable_wq, &micsupp->check_cp_work);

The Sashiko concerns here seem fairly plausible, I suspect the
fix might not be quite this simple. This is a fairly old driver
at this point and I suspect this might become quite an involved
fix, are you actually observing a problem or is this based on
static analysis? I am inclined to say if we arn't seeing a
problem IRL perhaps its better to leave this one for now.

Thanks,
Charles

>  	return ret;
>  }
> @@ -90,7 +90,7 @@ static int arizona_micsupp_disable(struct regulator_dev *rdev)
>  
>  	ret = regulator_disable_regmap(rdev);
>  	if (ret == 0)
> -		schedule_work(&micsupp->check_cp_work);
> +		queue_work(system_freezable_wq, &micsupp->check_cp_work);
>  
>  	return ret;
>  }
> @@ -102,7 +102,7 @@ static int arizona_micsupp_set_bypass(struct regulator_dev *rdev, bool ena)
>  
>  	ret = regulator_set_bypass_regmap(rdev, ena);
>  	if (ret == 0)
> -		schedule_work(&micsupp->check_cp_work);
> +		queue_work(system_freezable_wq, &micsupp->check_cp_work);
>  
>  	return ret;
>  }
> -- 
> 2.34.1
> 
