Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821659;
	b=LKQ2ZyfGyTwz/Mgmont6VymxLRUQ9YeuXhlk8zi7ihzGC9Pi8c6/auQ/2ISZlCeCG4/E
	 +JDDAjwqCLb/8w50lmRh4vOwi7sH3FfyqPLyJvxnRFdx74Pr5T7tErDg0bEki2bVFe0PF
	 euSF5YopvreJeBto2ypLIK6DfGIB6fFKT3DFKtz3m7aGzKY/RN2lSzYYFTsf5CTq1c928
	 BsHtWMC5yWAn37dpGNMAesWqGHillMasfuvj6DMiDUVuoK3ZYguwYnWaIRwlRKx6YiqbD
	 EEGvUBC1Fnc96EZM3qurZCvZx0lLgODHVMIpwzw4+wNOCiKIc9tQQWiki6vZEtaSOuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821659;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
	 Received:Received:Received:Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:CC:References:Content-Language:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=b3XJ3uMLgJmcQrJgXnJXJ6ykpT19UaHPPeMEczP1Fco=;
	b=nAOQHAsnIL8US0liq9DaD4mf5Li7jDzwzXgbkcYvHNzgyu6zBXrrfsMdeAMzN1xBS8bn
	 LTpM4ByMGtwLdXK9jwkfmFx/gmdVUSE6wlG5Rev86rMc1Xzbv0UWoc1bBD3RCnHTjTS6n
	 REXSqHa2I6pI3wQGU+Iq3dxlvoQfXZC/irtcS+wXK5EEwJux6yxRcX7KY3oAT2xE42tVp
	 ZCOHKRwEIZGTApB7Z1X1e8Jdx1EGLId6RoLrvWyh2ao6Ls9Cjwga2Cu99Qn97xXe9foDD
	 5YqjylYJ9pYsDT9aWhRquOOGQEEib5wjhl0TocOFGsI+PPzPEjB6Wl/LXcb+mdPhFxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ti.com;
	spf=pass smtp.mailfrom=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TGJaBplg;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UutwuyGX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472B9606AB03;
	Wed,  4 Nov 2026 19:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 472B9606AB03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=TGJaBplg;
	dkim=pass (1024-bit key, unprotected) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=UutwuyGX
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6A4JlZ5i3035911;
	Wed, 4 Nov 2026 13:47:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=b3XJ3uMLgJmcQrJgXnJXJ6ykpT19UaHPPeMEczP1F
	co=; b=TGJaBplgjPoImUokcEIDXEdBUrxxDIFOIBAaZqgyX2KRhUjgsFWNnNVim
	hViMxvypmhAkCp+3lA3sWX1uXmSqpB2io7z7Baim7ZJ5/NvGwQeVTPSZuo5rZZjb
	J2w9x9howmOilOLV1vWjRs6t2liqC0Gr/Wl0XNwyXtvPw0ZHtdsATGfZmq7odijH
	pbRK8Pd+3v4tNruD0FJZP7Nx6cyCft+00yliTQdH7Q8VyJlmgfmTB/J3R3ujDZSe
	EQjYgtcyaXGZp7jy3WhUhIhrt2DWc73gEzN5MHqPAw9vdHacmOqZJ59UybOqr9IL
	jSR411ufpcfgxLi+Soy4I/4mM6Rmw==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012066.outbound.protection.outlook.com [40.107.209.66])
	by m0380145.ppops.net (PPS) with ESMTPS id 4hqqra6vpu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 04 Nov 2026 13:47:35 -0600 (CST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lrMEkElDJ4zmGGdT/R7g8LBxRWmK5WOqwYthI0i2VU3rXbLWw4uJqMub2qwo6RbLSlmAfcCw9NaPRbmvMWOjMx735+MhklVulSeisZG7VGsTbfiTVwlKZVgNtq7ZAkEazoFuelaJERDYMulpO/G9EfhDd5Ji5A8uHPlCNivqPB1DH+J84q5C8cq0QSTX+516mpBSd2nM6X2va3A1zghDYUYjiUzhGgVNviXQpobigyFhMVkQNV0CjtMA5lqcc8ZsBRAkw+uNADtTPOBkf1nkaoH/kc8vxkLefr1vSu4q6t/Irm8mYp+qypZyfwFFdg38aykD7OuQumak4T5bGEGePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3XJ3uMLgJmcQrJgXnJXJ6ykpT19UaHPPeMEczP1Fco=;
 b=KIjQtImxUGnnacuVV4yMposlKIsG+VsIEyB3iWPJXoGmx0Sik+KNq7s4C/8WrceNnp9wgSG4ctfaV1Vlp40CcV9Ul/8x8+Zt8279WHENnqsVneJwcyUMy0UyGnSSpGP37ThKH4eNGrC4+7UkuLWPPH272oxvbw1ot+jg7tFE8vA9G3Tz0UXZpQUuM+xJZKaqzYlo/fTdbL3ksZa8CxrAC6dFffFJWpvXL8tUHtOcAEivNo1NwFyaV7KrFoGRld6v/FV3BtDW6eohaNrz0cX19kxZJ02f2ADhdpCppyRrDiRVY8roYPm4wQooxi6f6fq20HTT9sAZ8ITugXqFDm2/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3XJ3uMLgJmcQrJgXnJXJ6ykpT19UaHPPeMEczP1Fco=;
 b=UutwuyGXffY3icexxZerA9i7JmGccgeifVKLCPR+TAINBMJp3H7VcQCE2x0iHEeStU3CNKFhUlG9iYO3CJsQ7YprhQUtKTD1BEJBxF/FrTEI5hQO0ba6vrFvI5nLnW56Z+jRBMWm9l53ppFiF5/e8rwKs/Wr+QGTuP86dPPwTL0=
Received: from PH7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:33d::27)
 by CHBPR10MB780557.namprd10.prod.outlook.com (2603:10b6:610:407::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 19:47:31 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:510:33d:cafe::67) by PH7PR02CA0008.outlook.office365.com
 (2603:10b6:510:33d::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 19:47:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.23.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 19:47:31 +0000
Received: from DLEE209.ent.ti.com (157.170.170.98) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 13:47:05 -0600
Received: from DLEE211.ent.ti.com (157.170.170.113) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 4 Nov
 2026 13:47:05 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 4 Nov 2026 13:47:05 -0600
Received: from [10.249.32.147] ([10.249.32.147])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6A4Jl4fq1815910;
	Wed, 4 Nov 2026 13:47:04 -0600
Message-ID: <6d906d09-74aa-4e7d-b8fc-08fe975da7b7@ti.com>
Date: Wed, 4 Nov 2026 13:47:04 -0600
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
Subject: Re: [PATCH v4] leds: tca6507: Fix use-after-free on unbind
To: Danish Khateeb <danishkhateeb03@gmail.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@kernel.org>
CC: <linux-leds@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20261104193038.91614-1-danishkhateeb03@gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20261104193038.91614-1-danishkhateeb03@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|CHBPR10MB780557:EE_
X-MS-Office365-Filtering-Correlation-Id: 21bbddc0-bc9d-4c3d-f270-08df3aac76cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261022105027099003|5023799004|10067099003|261021123027099003|56012099006|261009223027099003|261028144727099003|261022075727099003|261021121427099003|261026121527099003|261102123227099003|261026140227099003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	tPViXkfXdkz0DruopeF3EwwjpArVknWulixPVtNv/xJfjfC3W8qYsz1jhVGRTIkN0zgE9M5COT+5MqSyX34F/ZTVV/4Q9CH5RbTtfOWiea9RNnqZzQ2NCET65w9AfGjwnlnnWph8b0J2kKwzcjKZn+ZULkhIjDiisYzNS7mAPFsyriRm+BreuuS07KZh52yUX2OJGtrZ4BfFGwzJ3qayHwDgrzNZAXT5V+suObj6X+K8EAuLklWc7KFi74nyjTBh4EArj+XMJ3+Af0YF7wPZBJ2jNwT6clDRRpH6O/Ta8fK3/N0xh33Sd6S66f1S7E+ErNu8gLmq+k9su+URZ7o8ExQCGm3m9QqL3zbNwMXh+lJOcd9Fh/ihOTIojbpRM7XtNEAGbrCw7UE499V4k5p4PgTV6wIBCZkynmOYt9e/l3R3TRPLQAJs+i0BUBRF8+E4KWljrqs89867qoxytuJC9+64DZXqoDFqKmbcO8KuqbFhenr3n+grd7+VaR+3Uat+OC9wT5kDkJw26wj5Ypdh0ikr+HKEaCrFumJ9DESzbCUIlyA/awxdH79vwNyOmbI5fQY9VKFnq0OGU+51F82Mji5k/hNe2qm6PR9U7qOU3q7EVRw5Fm6L+QkKL9qL6rjoibVkyqZE7CXHZJZwrIbqzPi2O9WfgoQDuOkuPOID+64=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261022105027099003)(5023799004)(10067099003)(261021123027099003)(56012099006)(261009223027099003)(261028144727099003)(261022075727099003)(261021121427099003)(261026121527099003)(261102123227099003)(261026140227099003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UU8QFEajxsVtkyX44odT39TJp3fezr5SRLootdK8ATrixzn+GCY4tgVEfX3uE9QbdbTzT+lAggXrvqhTViSPIgI9VNRF02Z13h51DQsICXOfgA22P9/aROT79/KZxPX/6MjAVfGseGBARMcyuBWkLEXN4EvbT0CO1AJd1i4r1D30VNrUYQhK1O8sevovTmOIFslHNX7yD1+4vNKiCGdtEhgbXyWZIRU6VYHP6FUAAYIcpe+vMZTdZY7PP+NvEz8TcisDzyTh4c50lk1OAXEMcPA7KAUoBrGyyivcBP9JJjBWwXMCO0I/1SJGqBMoyqys4tgGlg8vRaidcHHK3P9YL5HR5dlh4GCjGsiss4BPSfqXmNEVcHCBXwBTUNaqF4GBcn8/P/C0UdkO+s1u+swcSsIo7qEYdVnDtnR2VekMP0kLhbtsu3eo0NLVR/XfWVVb
X-Exchange-RoutingPolicyChecked:
	1j/uhy/0VoVuUnFHOytmKzAEqKveaYzWAYPz3Uw1IIg4SEAQc6D74Lv+s64r+OfeZ/NUTf8FMpMwj7gJ6+KvB1W/uza5bGoCVIO7XDwDGZtirrxfjydN3ujvVNx2fYNMysnwqDuDbUVDE8kxmPApG38nDsJ/rOrcCTxtiZKPQbBk0Tr42/UUL80tgYaQ9oE+QQyZ+YZUBlcxR71KQucMtQzy+GBwKA21qmlLlDkK8KV/QAGqNnALsXj0MGaVwrHTwd2MRIwjNpZ4W9KnTGBkx6tLSUjSORQM/17inb+7p7H5j2WOpRZdbTRTthKpu4HLsPxOTgZUuaZ2zeLs3JJbag==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 19:47:31.0498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21bbddc0-bc9d-4c3d-f270-08df3aac76cb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHBPR10MB780557
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3OCBTYWx0ZWRfXy1XSctZknivL
 qXgj8it6Vmh9w1Qf4SlKNCZAJbW/M03GX1w7i5irEY+/W5wIdUNM8KMBIHy2pBcPO+CU4SbKlYL
 ru9B793uvUwx9tEGqYnVcrQ6ojjherw=
X-Authority-Analysis: v=2.4 cv=F9TC5ahN c=1 sm=1 tr=0 ts=6aeb8bd7 cx=c_pps
 a=TLqzh4Vj95vWg92rYJ0Jsw==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s63m1ICgrNkA:10 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8 a=KlaZ7X0WMiNgMZjx13wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3OCBTYWx0ZWRfX0XinGVkfzDCE
 sqtQcj3gTBm7eKtCyam9pEaev0mn83SgOiykA1W2QucPno/tGEIM6rLhls3j4rEU1NpAiSX0gzo
 7FwBsZnyoXb2tyqn6gfnQBX/ADm2N5086EOFK5FArcrZRntxYDFIqP+mUxuucJp16HxlKE0Ui2Y
 XyobCvAMQDpAzp87tUlbRaRvWQB1ypWZNRH8BXHjl8jSkZibBJ+XmPCe+TS+pgVVpmcfPxUhK0y
 DUK2zLhbYKTI3N2hZpM6InKDJ+5+nEBpEayTBQsVy7zzog2JOUP1tTVgjpqo6GP+joGaEon6Irs
 zFP0SEOlIWmtIa3uaxSQqYB2Me0aCKccrWlwkawvwgx8xptwjQxJtf0v3D6epDgHIZe6P57/yE+
 h9KnqafyKk3Arxfo8GipetrnI+AwmALin0Cdc6yTMRDsHC+DUYzB9tv2ge3eboj7NB00UsB/xUG
 ZQhWlpztxCO0GfflNqw==
X-Proofpoint-ORIG-GUID: aIapWjQrFyS6ifZDY7X8D5yyRdBPzmgY
X-Proofpoint-GUID: aIapWjQrFyS6ifZDY7X8D5yyRdBPzmgY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040078

On 11/4/26 1:30 PM, Danish Khateeb wrote:
> Since the LEDs are registered with devm_led_classdev_register(), they
> are unregistered only after tca6507_remove() has cancelled the work.
> Unregistering an LED that is on turns it off, which queues the work
> again from led_assign(), and the work then runs after devres has freed
> the chip:
> 
>    BUG: KASAN: slab-use-after-free in assign_work+0x414/0x5b0
>    Read of size 8 at addr ffff888010d5c0c0 by task kworker/1:2/65
>    ...
>    Last potentially related work creation:
>     ...
>     queue_work_on+0xb6/0xc0
>     led_assign+0x223/0x340 [leds_tca6507]
>     led_classdev_unregister+0x26b/0x340
>     release_nodes+0xb3/0x140
>     devres_release_group+0x247/0x470
>     i2c_device_remove+0xbf/0x1b0
> 
> Initialise the work before the LEDs are registered and flush it from a
> devres action, which then runs after the LEDs are gone and before the
> chip is freed, and drop tca6507_remove(). Flushing instead of cancelling
> also makes sure that the queued writes reach the chip, so the LEDs are
> really turned off. By the time the action runs, the LEDs and the GPIO
> chip have been unregistered, and the work does not queue itself, so
> nothing can queue it again.
> 
> Fixes: 1b5c2fa7081c ("leds: tca6507: Use devm_led_classdev_register() to simplify remove path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
> ---
> 
> Notes:
>      Changes in v4:
>      - Squash the two v3 patches into one, flushing the work from the start (Lee)
>      - Drop Andrew's Acked-by, since the code is now different from the
>        version he acked

Acked-by: Andrew Davis <afd@ti.com>

>      - Rebase on for-leds-next
>      - Link to v3: https://lore.kernel.org/all/20261028174348.64014-1-danishkhateeb03@gmail.com/
>      
>      Tested in QEMU on a next-20260930 KASAN kernel, with the driver built as
>      a module and a test-only module that adds a fake I2C adapter, logs the
>      register writes and adds a software node for a TCA6507 with two LEDs.
>      Without this patch, unbinding with the LEDs on hits the report above
>      (39 reports in 20 unbind/bind cycles). With it there are no reports in
>      20 cycles or on unload, and every unbind ends with a write that turns
>      both LEDs off (with v2's cancel, 7 of 20 unbinds left an LED on). A W=1
>      build with GPIOLIB is clean. The code is the same as v3 with both
>      patches applied.
>      
>      An LLM was used to help with this patch.
> 
>   drivers/leds/leds-tca6507.c | 20 ++++++++++----------
>   1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/leds/leds-tca6507.c b/drivers/leds/leds-tca6507.c
> index 9afe2722986c..ffad476af625 100644
> --- a/drivers/leds/leds-tca6507.c
> +++ b/drivers/leds/leds-tca6507.c
> @@ -711,6 +711,11 @@ static const struct of_device_id __maybe_unused of_tca6507_leds_match[] = {
>   };
>   MODULE_DEVICE_TABLE(of, of_tca6507_leds_match);
>   
> +static void tca6507_flush_work(void *work)
> +{
> +	flush_work(work);
> +}
> +
>   static int tca6507_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
> @@ -735,9 +740,12 @@ static int tca6507_probe(struct i2c_client *client)
>   		return -ENOMEM;
>   
>   	tca->client = client;
> -	INIT_WORK(&tca->work, tca6507_work);
>   	spin_lock_init(&tca->lock);
> -	i2c_set_clientdata(client, tca);
> +
> +	INIT_WORK(&tca->work, tca6507_work);
> +	err = devm_add_action_or_reset(dev, tca6507_flush_work, &tca->work);
> +	if (err)
> +		return err;
>   
>   	for (i = 0; i < NUM_LEDS; i++) {
>   		struct tca6507_led *l = tca->leds + i;
> @@ -766,20 +774,12 @@ static int tca6507_probe(struct i2c_client *client)
>   	return 0;
>   }
>   
> -static void tca6507_remove(struct i2c_client *client)
> -{
> -	struct tca6507_chip *tca = i2c_get_clientdata(client);
> -
> -	cancel_work_sync(&tca->work);
> -}
> -
>   static struct i2c_driver tca6507_driver = {
>   	.driver   = {
>   		.name    = "leds-tca6507",
>   		.of_match_table = of_match_ptr(of_tca6507_leds_match),
>   	},
>   	.probe    = tca6507_probe,
> -	.remove   = tca6507_remove,
>   	.id_table = tca6507_id,
>   };
>   
> 
> base-commit: fb511964723311e9a7223e424d725c58dde8307a

