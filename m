Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326349;
	b=3ZQjmTfy0q7wPWBtl9Te/JarRf0CqKGH2vdaqyNWKwfOnh0MmIq0cIdeRfb/61pY7OU4
	 bTfmqyTRvuq25+q4+7vYCcAux3D6piEZP/6Q4tjaMswtzcOIc8aVxNT5Df3R5I+TjkcWe
	 kWS/nO4xWmHmPa/e1LfZ1uQ/OOGYpAu/89zncDbl4Nv/tkcrVr99aTtMcgz3f9/qvkZjL
	 t5ctmnGhMOgPI+nSbePpDBxjl6ZIQYhGXX/oejmkEFQU2CuheCEy7PmFxapeuyu8UUegJ
	 mN3s1OWm+o37sLmpOw7k6hBomwbiuIFXzYTXV8wGr0LtfJpXl37KZJMwmD6iQyKgO6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326349;
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
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
	b=OhulgMeDxgqYofrggV47QASa36U+Xh8Li8vu1Jzw2j/JllH9C7IwkuWpC92eBGIjPOcR
	 Y2yLzymgklmVh23DKUnKeJtkrHCCNaPSjMT/4Tv0nMLHIzivkBfVen0bu8G4444BO7U5Y
	 yrPOcmi/jk/kINpDwv8mHsJ6zdAXOwCd+ZWgz1JAWAkBvfkYFiWf+H2aV+gxzgoVq7Yzl
	 8K+dbc25vMpegmodYlJKIRVafvU3wj9q0RdSsIBKhr9f/S59N0MqvfVd7HV1DspVWBN1r
	 0eQYapSigwoy/w35GmyEzWJa1TmCikNxzrg+YIYi+KbqWJNKBQns32sXSAAFBLw3Pxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NGbYcACj;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=FobtllF6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FD606A32D;
	Tue, 10 Nov 2026 15:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C67FD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=NGbYcACj;
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=FobtllF6
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6AAEwCUL3291787;
	Tue, 10 Nov 2026 09:59:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFf
	Z0=; b=NGbYcACjsobXJVSYqni1T5LTIh2DbR0SkbBUZxWIVZPLxLYarh+OaJmFX
	/NSNe0WKJ8iKi0+tMqMFVQ3aIBcWSbuQo8G4g1StbDml0b/INWc4n+uKM/QHlP3S
	aXEvJSgO0EDZjBUTtslw5XnVHRAlsXjLBez+0l+71UgQybzbyiCP/JM0iyzHBSUv
	WIE0PFtj3grWQk76rV2LTMEC1mFZ2K39lT1cLgpz6YAvOdPnO2afmOzJ131t+nsu
	S2/6EL9nbn4etW8pW4y1LQF2XTFvTfy/lrWWks3VZ0pTJSNCrn5zOAuE8io0+N4e
	WcDeiFPGPqTuiSAlfluomPEShZ48A==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012015.outbound.protection.outlook.com [40.107.209.15])
	by m0384305.ppops.net (PPS) with ESMTPS id 4hv0j0a3c6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 09:59:02 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFuE9KZxF616oxm4Ec/crToDZl/RbHa+DP1H4Fnf01RK99ko7FKt7BhCoFhEu9yPSDt+WBkcsB1Fg+hPr9Jrd64f++0twqho3/1PFc0zj5Z8P+j6GuOVA45Cf4RHUiKU3LHFxKo8DdegYmZR5FkBOU5BDEkaiV6c1cqzbPZ3pciE6dnTJQeErT3Z9aszdEmM4jkwUGFVEG+9slIZzAe+oHL2S8rlRich9/u3EGAFpxFGRJLzLHW9Kd+61ndd5mzuY44SWPZIz+tnR31OmOjHQ6Rj3z5YNPymqDkCYTQGXVs2TiVlRSJt8EZmDJ4ZxRJxgYrOwGiUwYoGuFnnalyZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
 b=IaYZrfV/5yFuyDIf5yHAGoCBkopcmFz6ID0JXuWWK5u73iqXM6PLFcKR+T7hdMq47baPseNYNcyzJnWjABgzceenFgznpQQb/XpHWY6gm+ORtDLRIRs37U9WZ/ZH8UK1plwiwiFOZxu87LfN2JIts4YCR+f6/xzwEI48PTR7D++ahZ7jalpu/3y+sGR4gFS7yfVZhQUr9L8HhFQ3u0QfJfPTpK8FfxCcTSFeLiIQZUUY3IOdodKgROyZ9SylZTLA5JX2fmKdaMXI1prL+/4xVZGl3uJnEVLtsZuoF0eIaxEki9SHwmF2p3cldHnHm37Msgzvp1f5NI/kcVRrAsPGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOfEYuUBe6ndDWQJv8TzQxCmohESfL6Ga0KOJmJFfZ0=;
 b=FobtllF60gAHGyTY2GNal/BbZRquk8Rwq5BLw/ybMqA1QoUddiUSduMLIcLHT5nUslRymfaBDokk45pCVI07FEx6krelfi7imgm8H95483aOJAZ7W4EQssNX9gQ2Dt+GWVRKE3sCrLbPLNzTlzUO8vPhxUjJAa2ZAjNz7SB+mcs=
Received: from CY5PR15CA0004.namprd15.prod.outlook.com (2603:10b6:930:14::33)
 by IA4PR10MB8253.namprd10.prod.outlook.com (2603:10b6:208:561::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Tue, 10 Nov
 2026 15:58:59 +0000
Received: from CY5PEPF00000E82.namprd05.prod.outlook.com
 (2603:10b6:930:14:cafe::a3) by CY5PR15CA0004.outlook.office365.com
 (2603:10b6:930:14::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 15:58:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.194) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CY5PEPF00000E82.mail.protection.outlook.com (10.167.247.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 15:58:58 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 10 Nov
 2026 09:58:14 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 10 Nov 2026 09:58:14 -0600
Received: from b-brnich.dhcp.ti.com (b-brnich.dhcp.ti.com [128.247.75.1])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6AAFwDIV1079577;
	Tue, 10 Nov 2026 09:58:13 -0600
From: Brandon Brnich <b-brnich@ti.com>
To: <devarsht@ti.com>, <mchehab@kernel.org>, <hverkuil@kernel.org>,
        <sebastian.fricke@collabora.com>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <k-willis@ti.com>, <jai.luthra@ideasonboard.com>,
        Brandon Brnich
	<b-brnich@ti.com>, <stable@vger.kernel.org>
Subject: [PATCH v7 3/4] media: imagination: e5010: Update
Date: Tue, 10 Nov 2026 09:58:09 -0600
Message-ID: <20261110155810.18521-4-b-brnich@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110155810.18521-1-b-brnich@ti.com>
References: <20261110155810.18521-1-b-brnich@ti.com>
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
X-MS-TrafficTypeDiagnostic: CY5PEPF00000E82:EE_|IA4PR10MB8253:EE_
X-MS-Office365-Filtering-Correlation-Id: 23952997-304a-46e9-ee05-08df3f4387a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|18002099003|22082099003|261021121427099003|261026140227099003|261009223027099003|261026121527099003|261022075727099003|261021123027099003|261022105027099003|261022115727099003|10067099003|261021135927099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	J51VD4/hH0OFUM93WzrqDjxLRnZYLeDNmVX/sg98Mq6tWxEphVl2T1k7MhRwjeTqvOubZXqrFH8xXvk5KcpSrbyyh59j+uAzyxELgVtVLBosWQdfIFvUC96u+JkpHhMk4ZtHF3Xa8UCnt4FlUJ6knXh3BJHWTNbXTi/V5s2OPqkgG/yfhnjpDe0xDw4yYCUaFvBU+To6pDzBq3pi8sKuDRti1Nx7QWyYxyleM/rJbnVbytvyGqZbINPrYnChSFnhJEaBiUhbjyN0Kgon6/mgJR7vVvT1JUxEdac0W9TOQ84wtypXmonzvCb33fXu3ptyAw5uTJaP9paZlOIbkc14Wf7CP7WT8Tfwm4P79pAy946OTRgCeFYqezZSqGWFfRNwyGGWeg+Jr5IDZCQJzTObPOlyvyhY95FjQskQ2q16dmZoYoFQhVryfiSFf8ILJDh9IqwSptGQuMcnJvwXorMO9CvwVUOrlksxKfZa55whSK9jEpQIgSfhZ22+NFjZbFx+WZ7P+fIlN99XcqlBq8SzO80lT0wrhIAgYSoi5tKKct1c3BZZINC/8dCNJff28z6Pxo60tzaNOPY1v9p0fFTaU7NgTaQo0s00q2YVV3TYQfyVWOd0a447ia6cstk2zdoVTQrbFdNFxU/bM1UagcT4LyiXdXpGrVRDIjxZttJaQH2Id7LWdYrzOucQ09/O8gn3/s+1y28RKuDaSg6yTv4vlw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(18002099003)(22082099003)(261021121427099003)(261026140227099003)(261009223027099003)(261026121527099003)(261022075727099003)(261021123027099003)(261022105027099003)(261022115727099003)(10067099003)(261021135927099003)(261028144727099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6vFdQinn0b9yUvq5m5bQdrG1gwg3x+e5iK/Lm6QtzD03oy4HiCj47oZ6nfhW2B4M0bmkoPL5K3aiTi4HYf8w7SW4Z5OJx+V24UfNWwTB46xGOhnVRBnaiFqB4SrMSFCQGU8Xm1kluCKqAPjceuGdnzv5SSmfbA+IrnHWdxE+nepOW5NpAbxuV5CWUM/BgUEzV0JGR8eXdbb2kBdEsICd7uPDxRtKyYo3ZC0PofSLmiEjckXHNcyzYOVCESzWzNV9Ub2m11wFQRopvvA0KDogxyUY3N1AKfvTEQvJ59Ba1Ye1SEBeISUhvg/tc2A0DaTH1lmacBZR2SYMRL9TPEXIw8bNjrgqseLl0TdYftovKnWHFXgXBnjayZ5OzB8L5oLCMzFFBRPLNrDEy8rVQ3B35WnPp9zxzA3TfH09Joe5lPao9BYY0XVN9BYaa4bDmg0l
X-Exchange-RoutingPolicyChecked:
	Q2+qefbn3kuJBxiNjoz/uk2uuD5flWH2ft8cV73CIh6b3f8HZa5ne4n9+pfLUGrSnYxGi1TtHJd6jiLG45PBoGJ8pj5i97Lq9NNRIYMe31XSRWUf7F8+cj75zC8XLRTdvUBptc64Pn6jtsQnt6CXzHbNDoQnZu9YuTPh2cBAT4vA4iH/viuiji2wKai9yWzKay7PpD8n+tvR8Bn22P7WJC2jt5yH0Gw/eotgXnaTl3R+ihI+y+WrHAw/nnQu5YnyzEj3oV7O1cfnPCnyIn7XvKFaD9aWWNC4BR0n4PWE4lYUPmQWAWkxwk3wdZHetWwtvZlFbqtBnF1nmZNT3pj7oA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 15:58:58.0047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23952997-304a-46e9-ee05-08df3f4387a2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY5PEPF00000E82.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8253
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfXw6HIUbsB43y6
 ifFFW6nDV3s+MDDqRH1f0UuyR54gHzvibieh1zHG1ZY9o9wCL6NqCPB1bpywiX5UOHXVnB8Ypx5
 XlB6xYoIUzFp45NO+MLbUx0WGPDTXEyKI6KWEGfwo8zoUHVslnXYtIQOwxMkc+jPE4uOkRRR15l
 0xQjz/3HCTW/jQi/4Do7qngOwXctb+I5VH8UE6pBt5ORRn+Jsguq6PcwanuQvqbTwZ2gBelZsQ0
 +01dqB/r4s2m/vvPg827aKp/rCxt+6SYP2RCpyTfJDXtzYo6mxOIAL6IpIeZCLB2HKrm4sKKRR+
 ac8Jk298o7hDwBRgcEndUsyy0HX/A5nucL1L2hUs2ct5uZT44Ybg9M4eVYx6/qrTv6cigtqeZw9
 fqY0zZv9wHxrB379Z4U85bpSGEKZi8bFHWdQezlugcSXEIcqcAKniyzxvjEgSQExJBHg56skxfX
 2jGOoaJ/1kWf9yLHcFQ==
X-Proofpoint-GUID: w7rVeWYcm0USyD18FcqDSKX748xAS4yY
X-Proofpoint-ORIG-GUID: w7rVeWYcm0USyD18FcqDSKX748xAS4yY
X-Authority-Analysis: v=2.4 cv=BrgIUoX5 c=1 sm=1 tr=0 ts=6af33f46 cx=c_pps
 a=YvmT30J82QCmV9938MlLOg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=zJRp6_cAMcgA:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=Jee-tNXcj7xYXxj2UzcA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA2MyBTYWx0ZWRfX0b5oUtM49UvC
 bWERutWuTuH2vcx16T1fXI82yHoxGLyvof4tCTr9u3are6b7dkQg1H1uKZVdSmbFLdsfIC3ihwI
 fAz8Kke8eY/pzPQtn9qQpUiOgoLCAms=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100063

The PM framework skips the runtime resume hook if the device was never on
in the first place. This results in a crash in the system resume hook when
a call to e5010_init_device attempts a write to a powered down device.

Move e5010_init_device to the resume hook to ensure register write only
occurs when device is properly powered on.

e5010_init_device needs to be called after e5010_reset for next
device_run to have all registers properly reset. Without this call,
register values are stale. Similarly, e5010_last_context_run should be
set to NULL in e5010_init_device so the next device_run call does not
use stale QP values.

Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
Cc: stable@vger.kernel.org
Signed-off-by: Brandon Brnich <b-brnich@ti.com>
---
 .../platform/imagination/e5010-jpeg-enc.c     | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
index 17ea616ff1795..4e77112b59197 100644
--- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
+++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
@@ -986,6 +986,8 @@ static int e5010_init_device(struct e5010_dev *e5010)
 {
 	int ret = 0;
 
+	e5010->last_context_run = NULL;
+
 	/*TODO: Set MMU in bypass mode until support for the same is added in driver*/
 	e5010_hw_bypass_mmu(e5010->mmu_base, 1);
 
@@ -1488,7 +1490,9 @@ static void e5010_device_run(void *priv)
 
 device_busy_err:
 	e5010_reset(e5010->dev, e5010->core_base, e5010->mmu_base);
-
+	ret = e5010_init_device(e5010);
+	if (ret)
+		v4l2_err(&e5010->v4l2_dev, "failed to initialize device after reset\n");
 no_ready_buf_err:
 	if (s_vb) {
 		v4l2_m2m_src_buf_remove_by_buf(ctx->fh.m2m_ctx, s_vb);
@@ -1517,6 +1521,13 @@ static int e5010_runtime_resume(struct device *dev)
 		return ret;
 	}
 
+	ret = e5010_init_device(e5010);
+	if (ret) {
+		dev_err(dev, "Failed to re-enable e5010 device\n");
+		clk_disable_unprepare(e5010->clk);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1549,12 +1560,6 @@ static int e5010_resume(struct device *dev)
 	if (ret < 0)
 		return ret;
 
-	ret = e5010_init_device(e5010);
-	if (ret) {
-		dev_err(dev, "Failed to re-enable e5010 device\n");
-		return ret;
-	}
-
 	v4l2_m2m_resume(e5010->m2m_dev);
 
 	return ret;
-- 
2.43.0

