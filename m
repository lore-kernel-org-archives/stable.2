Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com [148.163.154.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFF8360EC0;
	Wed, 24 Jun 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.154.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282687; cv=fail; b=fXyURfFAj4x8g2o9M61gKpLo1HSpdnQX3DjiBCbgmJb4f5Zw1uTtWade2K9BJD1RXxz+o2hZu5gPGY2HxfN7KdSSC6ov4OwBIIqdnQ77XljvEsnS/pcYMae5BU96bW8xoNwjcWbreRVPd8J1V8gX9LPGfLtu07SS4FA0sMRRzCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282687; c=relaxed/simple;
	bh=nj6S3D1PZPD3XhT0gBIyvbcgT6bITwugoD9hKDYf5gg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FZkrdw07ELj4xEnVx4YepppJZuRKX3QNTB52suEi0nM++NfSxnoxbwzyCrjcqAzVuGL15jiTTuIG/PHgTGcnFQXmME4oBehm7G5RZAiDToNIl9TDa/Ig75UT4wBwYzU9WU5MTcv5/xgCaq/NKcHyncxXwW94cE8WfIP8xziLhsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=hCK/Gka4; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W50YS804; arc=fail smtp.client-ip=148.163.154.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="hCK/Gka4";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W50YS804"
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
	by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65O5taxS3838863;
	Wed, 24 Jun 2026 01:30:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=0xdS9bucrBsIM98T1Q9w2ijqx0Sn+dtQvpM7Ul0fC
	5o=; b=hCK/Gka4G4G5BUV9xeMgt+WtfH67wM00OXIVzB2KHB+lm3Afh7hTq2d0g
	p8EH6r/L3kpiHBQNDYvBn21FdcaSyqYMZFPrH5HdK+yL2uh8Se10GnFnFyikfOw+
	prc/N84cy9WqnM/KnpR/0PFwWcgNZuFYJ10ijbvVyGkMOaS+TgI/jN5rSB9LPJDn
	ga/4kABGTfNihHc0thA/pIQeTfi8Do3dSogSfNgMdTsUP6khkujh8lOgm8OE8Ohm
	qhPrVDx0DVifAFYHbLcZ8H4xBywviHplvkDIOM2QqR+M/atMrZzaneQLKOf0Rxpo
	CWQSKkFJv2ksbToLbQt/Rb/DyvUrw==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010043.outbound.protection.outlook.com [52.101.201.43])
	by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4eys146etm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 01:30:46 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZ/zP3Y+N7x2tyLBr+qh/T/ck9mNnnMmViTRpbnCPmrRxgAVpOvzgh7Mu/fz+X8i9b7JjpB1D0VAF+qQ6No+MyWdKWIkGozTkM/+h53EgsFD8RtETC7fb8kskrWxznwHCADxOvIfPl5ph8hmwlu8rMZOJ9og/0rgMUkE07m85b1e7GI2tc/gl/7U2Tq5TQj9JdLiJ0DJcIHV3R3bduC9r1mrbH4zX8fDh3B+63xq+lGvnWXDpTe/QGLLdGp5HQ5lKZFtH4SMAiPqijYh96vr+6l299WAR91tuOjqq9mJMyDBdVKp0nkdOgR7SqhN4sncfQz9VUPKZts8zOU7ebCkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xdS9bucrBsIM98T1Q9w2ijqx0Sn+dtQvpM7Ul0fC5o=;
 b=DmnteBz2s7gdkYJQzhUosuCSi8dhScYrs40bLIB5J5kWurSgroNRjrYZGzvAJYhIau9IJnTdlLavz20jcOoeEFjBikQd6LnJBcc+SxI4ZMhm2faxyDtiGj1jRvLMLJffVvhJHGijTEGTVNJK3BVCA4TVHnq80ZMtdfUSk2wzzOUXDVL1Kar3lf9FKrlJrf9ezagEHrvCNmASUyGrqcsLAP3zFv0SPCHGP2l2VnYGERTPmk5LFmVBnOg1AH6j7maJ76uGOBLb+pPcJ+lbXzmCqXIr7KBAkRxXGhnrJdrUmM4Q4X65vPKnD5/piLxGlhqMkVplaU2v0tBCPKEksXoszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xdS9bucrBsIM98T1Q9w2ijqx0Sn+dtQvpM7Ul0fC5o=;
 b=W50YS804sSyF89nMLYT02O+6NzbN9nh8I2QC3hmFZZ3FhDqThen+nLqAIuErBkQnEttvrSwAyLaIkP86DZFf7Y9g+WkR1HCMXNYCmjvruhHLXlIVY1eoWKwDE/+GYsG/C+6Fngv2ao/dbXYveHYsCe1tNQ+A7LJcgyngtwvtiWk=
Received: from DS7P220CA0103.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25d::13) by
 CH2PR10MB4344.namprd10.prod.outlook.com (2603:10b6:610:af::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.13; Wed, 24 Jun 2026 06:30:42 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:8:25d:cafe::6e) by DS7P220CA0103.outlook.office365.com
 (2603:10b6:8:25d::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 06:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 06:30:41 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 01:30:38 -0500
Received: from DFLE213.ent.ti.com (10.64.6.71) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 24 Jun
 2026 01:30:38 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 24 Jun 2026 01:30:38 -0500
Received: from [172.24.231.93] (ti.dhcp.ti.com [172.24.231.93] (may be forged))
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65O6UI6j4014524;
	Wed, 24 Jun 2026 01:30:18 -0500
Message-ID: <d37c1cdb-6fae-4d64-94c9-7b5b6076c48f@ti.com>
Date: Wed, 24 Jun 2026 12:00:17 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: fix XDP_TX from the AF_XDP
 zero-copy RX path
To: David Carlier <devnexen@gmail.com>, <danishanwar@ti.com>,
        <rogerq@kernel.org>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <horms@kernel.org>, <hawk@kernel.org>,
        <john.fastabend@gmail.com>, <sdf@fomichev.me>, <ast@kernel.org>,
        <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20260623112225.303930-1-devnexen@gmail.com>
Content-Language: en-US
From: Meghana Malladi <m-malladi@ti.com>
In-Reply-To: <20260623112225.303930-1-devnexen@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CH2PR10MB4344:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f9922d-f739-448d-16e7-08ded1ba1cee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|36860700016|82310400026|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	4EdtZaVCM2AOvUEgsV1VgqgPJ0At2t0ilGU7E1Wa5W2qJQ8ixGvRlbFEUuJTPNi6LW7vSjHgmXm5iVSp/eTS6XwWbR5oN9b6NAncIK6iWePE99tXz6zqVkbjgALaKtR3dMNa2r5+QCNthH/Ba2oR5jik03MDtbf7v0pp2VLiCeSvxdmUCWZ7Cpri2NGhTt8T46/kzOtOpT+nHC5VriqVHO5Uf4ZSWx/GehP7bnFYr2H9OSNxPyNo0wiFfkfNc7nDBQpRZpX0DpXHbCNPdBtQAyJTmOYXalmStgdGnzHX/h/J32/3kKR7QQ3goItc/qMGXzHJh9MT8zg1qaXwTK3YLyFHN1vSMkCfLM8tm7mpMZxslp8FMp2nnizYJ15+I/LFwl1XVtBm/yC8QGsgqXAquHk0VRdZnyVEsDOz1a7EjF2w4mHAmphk4GhGvjlPrmdy7W+H2lMKgLddcaWQyX9D8W698rbasJX6SWeJ4H+cSJ3pkOHhY5grOFrlLCgGijmad3BiqGc5j5UgFf8GHMkF3P9vKn6wj0HZjTDAdlc58Sura+9Z/NKasLVPFZ4BgP7K2kWTIHBITciuM7z846tbRyIxxDFD4eeSltDbGPPQn72lHVYpwsWRORUdC8qbPihsmYsAwM012uaBQF8Ey68Zk/ESV47dV7kDL56dT+il2RHcCv90vTOvHaBESO6Yu9SOa6wkgXhmUenqXkUKa/kGSw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(36860700016)(82310400026)(56012099006)(13003099007)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	85knN3Z7sYZ/qWZFiv32z4YR5GbjRKVJKDM3CYA61bZ07vTm8QE4X7ixpGZsOl1Ry4j/p9iP0HjCpi01Yt2EO1hkqhm0bhAoJHuwbApAfJJQAR9HDeJV/C3lSbtNGYXx7+paiELJGc8cI2bpYMus0FCNjA3QvubMV2DgHRafBKUJ/TKRj+1NJClSbLSotnGCeRguGWS7TcgSO8lbuW6IffY4c4uRBxSNjLzOiW/YFrmtRIBD7fcxVfkDuQwDzq9ra44Szf50ooOh3BbiZilZQh7SUfBGxQIAs/Y+LrPqmcVLLZs7odpTodgtsUSQcq+BXetS1g6an6RK88bFCKDrEgwxqWjgeNEx/xrvw02OrTmmMhGG6ISsCRiV5sVe6SFhLAm6YMCJv7RPzsKqf6jrFT6pSSj5wUCs+Ca2/PlPSaklRVy+N1rpLCSeBXj12XAu
X-Exchange-RoutingPolicyChecked:
	gCHmZeWFiAQZ3khoBvgUc4RTh4QFLRC+bGndmbBQKbYC4ZQ/IQk4SvfsA8uaD12g+X1KY0fz9SgOX49doeHZ7ITvMFPTlgOP1LAG/AUtzOqnxDR5PCEYVHW0Wi1x/DzI+h/379rAXMtnQZPl/r+REEs0RWmI7gN7fjjulEHjKk/xh7R2T2TSKJmwTpgE7nudJqv/K8xFybCI+zwDmUD/riPhhyaNysd6ivuYRSd0MNxqOSrjqWObiwImv9rKGLa02IRowqrUm/lcyE8KFIeF/8Yyu/XTraLzY2OJlGvXJfSLf0iU71YTCpwt0KrCbtv7lJ0Y6+xLtkQF9b84/0+1WA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 06:30:41.1956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f9922d-f739-448d-16e7-08ded1ba1cee
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4344
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDA1MSBTYWx0ZWRfX46NuuDpxt8MM
 XRO8S0T7/Yb7bjc6foEInPbpUpymo/Lejc5XOVlI08bCjwQpCj5S5ylXwsyByzfCTtDnPLo3TZ5
 hae7qV/RD7RBWkedK5htH/PoViBH+OU=
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a3b7996 cx=c_pps
 a=MXKEcm+r4KK8PT7sjGsI9w==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=sozttTNsAAAA:8
 a=xPYmqtWX-RWNEyULkpMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDA1MSBTYWx0ZWRfX72YCzDNgm0IW
 v8braovW9jsFeO1nL+VYzPV2FhU4ofRHT7oXuDQU1Ycwr/XC8NNPaPUp2zBj+sD643SWzhpArrC
 uyv51Zr9nnzEMBzo2XXH8OYznZqFUpseB73FCJjGmLhI7TTUiYk35wLdEx0MF6vnV3EffLm68E9
 lLUPJpEUzD/ZZAOYGTK90LCDzByqYTZSXA0wTvaYcP8YGTar0pzs12n0wxAajjN0rW07eycIHNA
 xVlYuU8wlmJrGc3zkNZ51fvgt5E+AZFwGP5NbmPViecEaHXMBBFH1QUZRlNm39UorrrlCtOmqyB
 j92M3FlXJhxx33+TvbhI2s/n6cMvJasaxPNDB3KZGsdY0y3xI0wXOeA1KtjysTj6xnU0g5SmSsR
 WA3ECLdcByJ1/4yL+FbNSirrER8Z6w==
X-Proofpoint-GUID: rQO4FisSCf2wp5NvEkfDh_2aJzncN4-Y
X-Proofpoint-ORIG-GUID: rQO4FisSCf2wp5NvEkfDh_2aJzncN4-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_02,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240051

Few nitpicks,

On 6/23/26 16:52, David Carlier wrote:
> On XDP_TX from the zero-copy RX path, emac_run_xdp() converts the xsk
> buffer via xdp_convert_zc_to_xdp_frame(), which clones the data into a
> fresh MEM_TYPE_PAGE_ORDER0 page that is not DMA mapped. Transmitting it
> as PRUETH_TX_BUFF_TYPE_XDP_TX derives the DMA address with
> page_pool_get_dma_addr(), reading an uninitialized page->dma_addr, so
> the device DMAs from a bogus address (corrupt TX, or an IOMMU fault).
> 
> Pick the TX buffer type from the frame's memory type: keep
> PRUETH_TX_BUFF_TYPE_XDP_TX for page_pool frames and use
> PRUETH_TX_BUFF_TYPE_XDP_NDO for the cloned zero-copy frame, which is then
> DMA mapped through the NDO path and unmapped on completion.
> 
> While at it, fix the page_pool XDP_TX completion path. A
> PRUETH_TX_BUFF_TYPE_XDP_TX frame carries a page_pool-owned DMA mapping
> (established against rx_chn->dma_dev), yet prueth_xmit_free()
> unconditionally calls dma_unmap_single() on it with tx_chn->dma_dev,
> tearing down a mapping the driver does not own; xdp_return_frame()
> already recycles the page back to the pool. Tag such frames with a
> dedicated PRUETH_SWDATA_XDPF_TX type so the completion path skips the
> unmap, the same way PRUETH_SWDATA_XSK buffers are handled.
> 
> Fixes: 7a64bb388df3 ("net: ti: icssg-prueth: Add AF_XDP zero copy for RX")
> Fixes: 62aa3246f462 ("net: ti: icssg-prueth: Add XDP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2:
>   - fold in the page_pool XDP_TX completion-path unmap fix raised by
>     Meghana Malladi: tag page_pool TX frames with PRUETH_SWDATA_XDPF_TX
>     so prueth_xmit_free() skips dma_unmap_single() on a pool-owned
>     mapping; xdp_return_frame() already recycles the page.
>   - add Fixes: 62aa3246f462 for that path.
>   - no change to the original zero-copy fix.
> v1: https://lore.kernel.org/netdev/20260620213756.87499-1-devnexen@gmail.com
>   drivers/net/ethernet/ti/icssg/icssg_common.c | 20 +++++++++++++++++---
>   drivers/net/ethernet/ti/icssg/icssg_prueth.h |  1 +
>   2 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
> index 82ddef9c17d5..96c8bf5ef671 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
> @@ -185,7 +185,7 @@ void prueth_xmit_free(struct prueth_tx_chn *tx_chn,
>   	first_desc = desc;
>   	next_desc = first_desc;
>   	swdata = cppi5_hdesc_get_swdata(first_desc);
> -	if (swdata->type == PRUETH_SWDATA_XSK)
> +	if (swdata->type == PRUETH_SWDATA_XSK || swdata->type == PRUETH_SWDATA_XDPF_TX)

line length crosses 80 characters

>   		goto free_pool;
>   
>   	cppi5_hdesc_get_obuf(first_desc, &buf_dma, &buf_dma_len);
> @@ -259,6 +259,7 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>   			napi_consume_skb(skb, budget);
>   			break;
>   		case PRUETH_SWDATA_XDPF:
> +		case PRUETH_SWDATA_XDPF_TX:
>   			xdpf = swdata->data.xdpf;
>   			dev_sw_netstats_tx_add(ndev, 1, xdpf->len);
>   			total_bytes += xdpf->len;
> @@ -769,7 +770,8 @@ u32 emac_xmit_xdp_frame(struct prueth_emac *emac,
>   	k3_udma_glue_tx_dma_to_cppi5_addr(tx_chn->tx_chn, &buf_dma);
>   	cppi5_hdesc_attach_buf(first_desc, buf_dma, xdpf->len, buf_dma, xdpf->len);
>   	swdata = cppi5_hdesc_get_swdata(first_desc);
> -	swdata->type = PRUETH_SWDATA_XDPF;
> +	swdata->type = buff_type == PRUETH_TX_BUFF_TYPE_XDP_TX ?
> +		PRUETH_SWDATA_XDPF_TX : PRUETH_SWDATA_XDPF;

Use braces for the condition please

>   	swdata->data.xdpf = xdpf;
>   
>   	/* Report BQL before sending the packet */
> @@ -804,6 +806,7 @@ EXPORT_SYMBOL_GPL(emac_xmit_xdp_frame);
>    */
>   static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len)
>   {
> +	enum prueth_tx_buff_type tx_buff_type;
>   	struct net_device *ndev = emac->ndev;
>   	struct netdev_queue *netif_txq;
>   	int cpu = smp_processor_id();
> @@ -826,11 +829,21 @@ static u32 emac_run_xdp(struct prueth_emac *emac, struct xdp_buff *xdp, u32 *len
>   			goto drop;
>   		}
>   
> +		/* In AF_XDP zero-copy mode xdp_convert_buff_to_frame()
> +		 * clones the xsk buffer into a fresh MEM_TYPE_PAGE_ORDER0
> +		 * page that is not DMA mapped. Such a frame must be mapped
> +		 * via the NDO path; only a page pool-backed frame already
> +		 * carries a usable page_pool DMA address.
> +		 */
> +		tx_buff_type = xdpf->mem_type == MEM_TYPE_PAGE_POOL ?
> +				PRUETH_TX_BUFF_TYPE_XDP_TX :
> +				PRUETH_TX_BUFF_TYPE_XDP_NDO;
> +
>   		q_idx = cpu % emac->tx_ch_num;
>   		netif_txq = netdev_get_tx_queue(ndev, q_idx);
>   		__netif_tx_lock(netif_txq, cpu);
>   		result = emac_xmit_xdp_frame(emac, xdpf, q_idx,
> -					     PRUETH_TX_BUFF_TYPE_XDP_TX);
> +					     tx_buff_type);
>   		__netif_tx_unlock(netif_txq);
>   		if (result == ICSSG_XDP_CONSUMED) {
>   			ndev->stats.tx_dropped++;
> @@ -1395,6 +1408,7 @@ void prueth_tx_cleanup(void *data, dma_addr_t desc_dma)
>   		dev_kfree_skb_any(skb);
>   		break;
>   	case PRUETH_SWDATA_XDPF:
> +	case PRUETH_SWDATA_XDPF_TX:
>   		xdpf = swdata->data.xdpf;
>   		xdp_return_frame(xdpf);
>   		break;
> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.h b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> index df93d15c5b78..00bb760d68a9 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.h
> @@ -153,6 +153,7 @@ enum prueth_swdata_type {
>   	PRUETH_SWDATA_CMD,
>   	PRUETH_SWDATA_XDPF,
>   	PRUETH_SWDATA_XSK,
> +	PRUETH_SWDATA_XDPF_TX,
>   };
>   
>   enum prueth_tx_buff_type {

Reviewed-by: Meghana Malladi <m-malladi@ti.com>
