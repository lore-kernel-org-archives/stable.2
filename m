Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012042.outbound.protection.outlook.com [40.107.200.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A992F4734E0;
	Thu, 23 Jul 2026 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826489; cv=fail; b=Mu5BWab/onnibCgTiwE9YRWXI7B7xR33Ov6QhmQUlrIVXhf6rrFUhDktUZhnmLR4M5Zw07vMd0XHyZZ2d7Mvd9XhtvatQzRnlt4i4IZSrYGMZ5lsxhkTj5PQ70328KDYEegkc8KkP9FEbZu0/lz+IGCv1XV3MFgA9QVwMzZcQYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826489; c=relaxed/simple;
	bh=l8mMPg9TqsqiVxPJ4y9PHkt6iPNPmFCEuITfesVev98=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TZkFCAqVW0taxcUtlD2ckJiTQ24iDdLCqP4JXcXlrewojVvs3lmN1m5Y0aygYqF3nAjvnOtK5UMLVtS2mnxUfGByNGtYUZ6CFPwXhxix1Dn7+V/whzuCAzRqQlsUGs930DXuuwgztOY+EBz9iRyc1Tzt7nyQAC5EbiIbjWyshjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hjJYpn+b; arc=fail smtp.client-ip=40.107.200.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hjJYpn+b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2ud07hPP3FKF33wavxYM1WLdmCBs35HVeTIIZ+XXiyfFxltssl0Lb/HHS2EpqCWXHslsC6GYR/zS8vWE8F0nixEjSVDZ2HvqJeUsaXhZZG9fm1EqZ+kvKuWZTjT5kgJi/cta9QcUrSeo5T3aMVeYVYOGfOlwxQ5+MyZ9CQvBsb9ofwnngIuwPsvBxqC84fQf5CZD/aYz819vDr2w+WxCNOZvFYE+tIlQlBvh0BteL5Yuq1gqsQwqKhOiWwD5YEL/5vq2xgnke3hIYqF7ZYPojG/tPxi30oCVUWXdnS5DDJMLS3YMlycF4Rza40ppKpe6X9hoempTgHotiSFhuz73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8mMPg9TqsqiVxPJ4y9PHkt6iPNPmFCEuITfesVev98=;
 b=AYXSy1npPmyD1rodXtybJanAdgmF2S0OhQ5Ml4/8S+RHFji5HeU5zL5TfGOdrMv52yHmvedSpVCZzvrtgmwOK5OCWl3C6x20bMZAde8pgmKjulsaKwngoPk+S62OxnW/SR87WDGpBL04hbfQSJwLq1NL4UV4MlOUZ4ttYfweZpPncFk3lZhBPaiNJk3/GkkLvhHmQ/SYZPYOPDD6sZ8fT1G0tfDoh81NyzLs0ANS0oZEtPdfEqrtO2+y2IiTEoaKIXH9UMCglJMJK8MTpjfsXG5aSO9Ef1aZFfzwNaH/C1Iiyqr1smnBXAWTg3ZYD4UqMTxtaLkIsPPsR5V8HDCWfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=efficios.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8mMPg9TqsqiVxPJ4y9PHkt6iPNPmFCEuITfesVev98=;
 b=hjJYpn+bHBje+CvG9pIodiPUg9CIwkcOAPcCePC/oTb0wdb+sBhLylxQr3sPaQGiG/q8Qhte9Jznv3NhsbwozoiuOS3/N+/dUGCGpbHhnyVZmoj5ixASRReHl+64R/QNYA1yzMfy2XRhlL+2f3OrkHg8EuqqaAXYdV2XdjMmoA9TF6fCZEEluuNYh3EuOEfiS1kUFNao7oGML3jwrG3Gbe3yiDqTJ/tlBScuaK/OEkea68smUBE9MiD1A/9p9MwLjodzhXivEvvDQFdDYGoCrSRwu1KwN13zlkmFvy+k4wbobjjxhv76mCP2WArstJFz3NCklkZ1L1oQBZAkqY5QMA==
Received: from SA0PR11CA0158.namprd11.prod.outlook.com (2603:10b6:806:1bb::13)
 by CH3PR12MB8660.namprd12.prod.outlook.com (2603:10b6:610:177::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 17:07:46 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:1bb:cafe::51) by SA0PR11CA0158.outlook.office365.com
 (2603:10b6:806:1bb::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 17:07:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 17:07:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 23 Jul
 2026 10:07:23 -0700
Received: from 82875d6-lcedt.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 23 Jul 2026 10:07:22 -0700
From: Nirmoy Das <nirmoyd@nvidia.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
	<liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	<linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: Re: [RFC PATCH] mm: use precise current RSS for high-water accounting
Date: Thu, 23 Jul 2026 10:07:08 -0700
Message-ID: <20260723170710.1971749-1-nirmoyd@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <21d24fc4-141d-4957-8b96-6d5887ef4027@efficios.com>
References: <20260723134158.1473841-1-nirmoyd@nvidia.com> <bd3facf5-cc4e-4fa3-95cf-0f4aa926ae23@efficios.com> <20260723162133.877125-1-nirmoyd@nvidia.com> <21d24fc4-141d-4957-8b96-6d5887ef4027@efficios.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CH3PR12MB8660:EE_
X-MS-Office365-Filtering-Correlation-Id: 56084cd6-7443-4dc1-95df-08dee8dcea76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|23010399003|1800799024|36860700016|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TWdR2aQ9GucmGQenFMYqhiKt8bnelePiwY0BCWmNLZ4XwidGfa15/WzYhfbWlmcz6kkwJW+XhCG26gl40AvmlFnqlR9uszzO0qFg5zyIRS+dV08obkLb9YKaAQaw3mbl1b33YfNZyi7rOvH6P8gve9a/vjeHVnYLHmu/nlMIfiVVsMXQaCs3ad+HNA+pNe3OU5kMWkxi0oJswiUrnMufMPo8TxINljLpc3rxfF4GuQhfPb1DhPndDQbr5g7p/KNdZcBdsIBZwPtx53lYBvyLDqgXIO6nsKTaDGiesv8rLAXv7pkAT3tbZeikREmxBzVS6enSYwBjgOHdNlhRjv5J8al5eJuePM/a5qpqQxtrNFjrbuQr3h1wfbqO+AtfBIViUsAFpi7rpEmJrEOky6+KuQdME+9k94F/wcByYm19UV5wy/5W3Rf6kKNeJBOppVSs0Oq1mbuIxugpCRYcua1HMzUS7/Cccb2YQbFfnHjOzSBgDoy4KVfVDmoCIR5ET5Sel3e4KAUH9e5WbhXq0TklfulmDPQbCd9mmnI4A0hhea+anQfry6FOAWXE1tvG/3SbmcUay5zKAaZITtGtDkca6UWcnRD0lY5jvYunBJYiHim02SNGZFY5rvug6TSRGr0uxVtnI0fHbJ/lnkC/AUzQQ8Q8iTVVDPXEENfBNFTbfPjl8gZLlU4li6JK45TEcJc9GzANGUH9dgORmMVhUzFyUA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	foPolEPhmvRd8a5kJOAgM1uqXoLaOFLxW1OXuP1y9oqXR6Weq6VsYzANDYO4uZlyf9WpR9j8XKgxfE2X78eKPde6mGGwg64ypo8HCkNdnncmTT9k2Js9qw6K36uP/5GyB1s3coZhQExlQ1Tt6zBu8yrG+a2oG3fMmVXd3s7NplKaM9k1BogbtgMWz8r6nt1cnF2hwADS8y4KNvLnKV1WycrUXK/60nkb7MNpWH9GLv9I3TJuBCZ7A76XtNtQc5Ji+fQkI70wpnoJifO2ViuVkbGnZZEpWLJIK8FihwMndWiXC8UyeoFELzzIS+RXRePS3eBUvOufRENv54AQiyxIAjT7nq5uIKjn193v14ejJtf6kzhZ0uLzKSq4c1EgOPeDExos09bU7Oz/FsojGRPkpondfzfnvx8Ucpumli5r2Cfz8VpIdVl0pwQVoAncawzh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 17:07:45.5751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56084cd6-7443-4dc1-95df-08dee8dcea76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8660

Hi Mathieu,=0D
=0D
On 2026-07-23 12:31, Mathieu Desnoyers wrote:=0D
> What is this test validating ? Does it actually matter for a real-life=0D
> use-case, or is it just the test being too strict ?=0D
=0D
It tests getrusage(RUSAGE_CHILDREN).ru_maxrss:=0D
=0D
https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/sysc=
alls/getrusage/getrusage03.c=0D
=0D
I am not sure about a real-world use-case; I do not have one.=0D
=0D
> What is the overhead impact of your change from approximated counter=0D
> read to a precise sum on this /proc ABI ?=0D
=0D
I have not benchmarked the overhead yet. I will get back on this. =0D
=0D
Thanks,=0D
Nirmoy=0D
