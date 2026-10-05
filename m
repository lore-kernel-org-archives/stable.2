Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79514D90C0;
	Mon,  5 Oct 2026 17:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791221658; cv=fail; b=K5NgN3g3mbPOeQe2nCwYYlZGfL4GYLkbTt60fzKr9olh/H4wp+HFAzZJRwWI/04HTMJSrg+SoODTgV10XOKAyNMDmYkvSdTSzzQDzz1YGfT9X/nDDfq+Uaw+1ShxujI3pp2U4qMYjWdQa3LtCeHg/0AhI/c1m7xexfRW47gLW50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791221658; c=relaxed/simple;
	bh=VI95vqcpeatjOYIMH9B6dxvz2OvfkK0Q5PwQAUUqx+U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KN6awtQcmlvl8GnWwXB4AEGRHk69VBZdOUblDX0xJLlQejuIc97bPBaCNYz3rrK0xjnGBz1kjZ7D1xaDMKEJKFdM5vYZrLgoI+/R+V97gJOAjL5qpdsdt2kqkXh+Ht7cthYwakFOSIqI0+haUMrucaezX1eUkPLVRUOslIwPE9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=VPFUCWs2; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=ACLWFf3w; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="VPFUCWs2";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="ACLWFf3w"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 695HLlZt427545;
	Mon, 5 Oct 2026 12:34:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=X3iZvC+aU1JJ0jO6vhstRwy4CWdKZigv2pT2x5nF2
	bE=; b=VPFUCWs2IVyxJKlM8Fg3CSGw5CQEXaI57Jiz0iLRwgPxB68W+6o18k8wP
	axhkrQl+thKYbXEaPbrmFzeQSU2Ic+0fcOKzNH9tzlEH2PtGdILSdP+e9aapjs3A
	8yQh5v4zHBQcGB2wAP/swE4W/fuhrkGBqwy0210TCbcGwpbDadw0xAFHdVWQ2PuV
	QmWYicrfnlRtOsyDO62DBwP9tHa/OegljNpEeQchzubC5J11Z3Gmyk3hd8iJNsKs
	Uwg8kPzJnoSYvcfBW6556JUsN4z4+DUp1wP1wJTsBaSFSFkiZoaMLcmo8GV8pMSD
	cKOn+2+BuclqyMjaCZyKC/9gKFeuA==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010010.outbound.protection.outlook.com [52.101.193.10])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h3knnpvvg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:34:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab0JoUzsMMQRWfHXlml7XygcqrGnFWsnYimeCi1jLCAdTukBX+jEblaGnbg+aHbvEG+DEUhC8Pa3QmzCU3LoX9QeJ1/KfWiMkhUGZAQM021Z57kj0zYi2ia0O9l8dQEUFBgUzD7QlxCOfh+7S6K2SAcBN+ynTnp0N5MMP4fQQjSyN0vlieTzOXaNGbgvDQwzf8Vh7LPcuvy/BzNG8QvCXfCa+rAiAy1oB9IEtqTvB2V0KIW/a7+CiGpDXShNW0WCAbxN0F58HLhN0dyVSOUtyPNRWu32no6jIhcQuGzMxKKrwGnLUwK4WY0DqwqEEspk0c4qOJCQ/6S2NHHCgxGxwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3iZvC+aU1JJ0jO6vhstRwy4CWdKZigv2pT2x5nF2bE=;
 b=KFpKZKR1LyUfx8diLy2lTE++B33edV9MDqxWzSjYuv+Gz1VGxEjGgO9f56VcZBzoqRHTlRK78VCsTjTddhUBYBswglDtFpLAM125+/MjRI313q43qhy4chtONLt4zw60f8smZJh0OITjmKexMoxel2161ls8htpJuemxzAU8XdqIREX2hrdwHMmHuJhhoQFd8b0VlsLllefTIEmPGUwcY9goKpZS3DcIWQfVkN3bzHOCE/+Bi8KZaezuxL9xh1Lksr3RwStj6goBOSwVPFLb6zPF3ro2CVOq1vzbKStHWR9GyJZiVR/AFPUjVQHApVeLqGxktgFslsvVHsw0zJBnLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ndufresne.ca smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3iZvC+aU1JJ0jO6vhstRwy4CWdKZigv2pT2x5nF2bE=;
 b=ACLWFf3w43Ebha6Kj8Y7RZotGS9kquUcUbiHG8+P0dcrp2TkoiTyIO3n/lD/w1KakxRxIfUH5osI0mQSn2UcBNqnVZRKc3Kaa7qfrUG8nEg6aeN6Pf+9L5XUfSbcrCeOABJCxmlO3c4+ft6DtOWA5qguBFFcwjd7jb6vMCw2GMo=
Received: from CH2PR16CA0022.namprd16.prod.outlook.com (2603:10b6:610:50::32)
 by DS6PR10MB529489.namprd10.prod.outlook.com (2603:10b6:8:4b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 17:34:08 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:50:cafe::60) by CH2PR16CA0022.outlook.office365.com
 (2603:10b6:610:50::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 17:34:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 17:34:06 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 12:33:15 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 12:33:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 12:33:15 -0500
Received: from [10.249.33.211] ([10.249.33.211])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695HXFxL1591650;
	Mon, 5 Oct 2026 12:33:15 -0500
Message-ID: <036643d3-c3b1-41ee-9afb-67e4503cf85e@ti.com>
Date: Mon, 5 Oct 2026 12:33:14 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] media: imagination: e5010: Properly Release
 m2m_dev if probe fails
To: Devarsh Thakkar <devarsht@ti.com>, <mchehab@kernel.org>,
        <hverkuil@kernel.org>, <benjamin.gaignard@collabora.com>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20260831213231.2125544-1-b-brnich@ti.com>
 <20260831213231.2125544-2-b-brnich@ti.com>
 <39a03dcb-bebd-4794-a2bf-ff1b56cb632b@ti.com>
 <8afcba70-afb2-4cd0-8bcf-ef20e84744cd@ti.com>
Content-Language: en-US
From: Brandon Brnich <b-brnich@ti.com>
In-Reply-To: <8afcba70-afb2-4cd0-8bcf-ef20e84744cd@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS6PR10MB529489:EE_
X-MS-Office365-Filtering-Correlation-Id: cd637890-65ee-4590-80e6-08df2306db7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|22082099003|18002099003|10067099003|13003099007|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Z0b3+JTnu64gl8MDp/bZPqfII67Kip2IJpA6aNzLB1pIE7dyYvkf0/6nr9dHlyUSGdHazj9DzYdTMU0U5SMcoFNcFrpzq3vmghOHgZ8g0VPvyERihdoeHA/+5Q4ResG7ksOs4t0c825zFE0BOkuKQ/4XVUc9zveIQAP5fG4xW+tIS3kZg/9d01QIZncJTvr6HTS03/wJp1dbetwffgAPaqlXpu4bUuhIKl16M7kcPL9vzcWQeVx16w65fz00Iikf8w5Rrrt3P56xmSSspY6P4zs6Kv3TL0KgmVYzysVvVzLcCULtYX2MggP6U1fL66g/pdIFiT8a+kI0uyClQ4mM+IgvtkaElPGGcV00aN/A+V+q3UInxFAEaNBoXj/EdU9XZyN6pGESBetKRv/7XUWPTXaCdmy/xh7SS9ebhagkddAoYmAWJpS6nA/1P/DVbQ1n9MGg7Q3YzvumScDWrpQRKE+PTAI60blw7Tyu1LL3vm7v+IteH2vlFBoJnt7lmKO19XY0PNlMrCr2IacpY8yp+KCuvJ664s9qkCkJQ0ZfOnmxOyD1vXAnvoF5JlC7mmOn+DVKg+Fyo81GshlObLrJ2bDjGyJyJg/ekNRsiPOnm9HzMGw6eV4u5TBGVOjrGfRo2g3bwl1AGiTlxxgtxDQtSII+x9wTiKUhzTFw8OvFoQY=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(13003099007)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xbPChdICv1Fz6GM7CBW2iH4D009e2N22tP+4dhOE5G2Qdpy4FX+dlW7VLmvmHfO/25Lnuqm+PwrfEuv7hTXq1bjkpD8p4lFk3KU9tpmXMWgePLYFX5CkBwlK1TckDkL5DkA29LWaTe1qVofVF/w8lor/b/5akNO3kZ+515jwsKK6zskASRLsHygJEtnxxN/MHwUJiGEfXKQVTHUVLGRNENdA2F6HS7V8+Sb38l9yGUnZxXFKmZT09fA4HsoOfH5WuoXWabQOroh99V1rzrd3ssIY0MpOphenQP+8DoG20ReDC+b9350eDaXQ/NSiNIfFgr88zCCaA4rAaVXaUns8W4NTVZpIezM7c53YkZeM/MRvU3ITWX35tQPLzufDj5JizMIlMI7X4TfVWL1hHA1Gys/Q+0xTU4FiQPVr9cRcWVHfoNbeQrizt8T3Wjyq5TJd
X-Exchange-RoutingPolicyChecked:
	R7UoTV+YFZ7Pykp9VLMMDdbM8HvmFFuBQXqP7sY6n1GBtTRkbQCZLhlQHoQ5/khrqywYJ+oQGo5KPlpUeJdamoXwSme76eui7aXHdS4Rpzqj4CM6XWLqCKkg0HtXBx8F4rCaaE+iaAtSYf4ROXjnx878+1MlNA1ic6SkmcfW81NC85OHF4El6s0dttCTCfUnSNkKegTvH/wB+hX3T2XY+M55ig7aVSVRdSx9LvD/CfQiL3vUgEqs+LbxRbUDSEJfXch77e73JkKsxT8LOBkGqh5GF5Ueyvh9y+xK0ZP/uthDL8/LTqE6H/I1tX7D6oUgXPVO/NrdyDhBDtLbce4azw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 17:34:06.8037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd637890-65ee-4590-80e6-08df2306db7b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR10MB529489
X-Authority-Analysis: v=2.4 cv=I/7w19gg c=1 sm=1 tr=0 ts=6ac3df93 cx=c_pps
 a=UIgYboCJ6PpLVfK8zyfvEw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=Sos0uDLLLiOI8a10sWMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: hGZkNg5SHI8i1gjOzT-mQy2pt8e4aGMH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA2NyBTYWx0ZWRfXxYTk4UkTKRtF
 ks0biTLtlFa7rai7npo2HxTzaZ57mOs0WKC3zTNf/5HDxZk2YGqXwS9r4G0dpcNP0zyppeb+plm
 axLiADipajLNv4v0XGmvV51ca7YFO6pZx761w9/9ubWW09GQHV5Dbb6Zvk67ImoTMcZAmIXCb6x
 XnKi2BR3Z5c9eW9hbTdzsXkjZCF6crCcXioXQjDXGq5eDYNLbW15zU3V30A1Yk88m3Wu9IjI4nU
 AfNWoFfnvDio3+GOiD1O/RvX6IPWLCzjM2Yczblj78uKms1leWWRYvRKx58n2U8YMSLtNEHmWch
 CG7N4kTh6N5FEQ1Zr3IOALnWbKHwLdqbxTdOv8ly/xN+LAl8wlZEvGSgYF6Qlkk0FklNlxv5pBO
 3tSzKgo5dwFRps9FAKYskFXVZYbmZAfFzsYAhRgaPj9TlrAsU+D4xrvtTH22DE6ECrZx97A4970
 YFuS6DcVWCncmjxRwJw==
X-Proofpoint-ORIG-GUID: hGZkNg5SHI8i1gjOzT-mQy2pt8e4aGMH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA2NyBTYWx0ZWRfXzjPrS22ysLhs
 otDq1VBoTSNGM7Gqc0ZNiyf/wilJ1eCq+BFDitQAwPbFQneto0+zPKw6ywULR6ztqeokJoBJ6O/
 IaB8ws+QqCClxOuVcyqTwrgiBtpKtVI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_05,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050067

Hi Devarsh

On 10/5/26 8:16 AM, Devarsh Thakkar wrote:
> Hi Brandon,
> 
> On 18/09/26 14:38, Devarsh Thakkar wrote:
>> Hi Brandon,
>>
>> Thanks for the patch.
>>
> 
> I think this patch [0] is already addressing the same problem.
> 
> [0]: https://lore.kernel.org/all/fc08a754-1e0b-42ab- 
> ac53-94bff728aef3@ti.com/#r
> 
> Since the above patch was posted earlier and hoping the next revision 
> for same is coming soon, is it possible for you to drop this patch 
> ( media: imagination: e5010: Properly Release m2m_dev if probe fails)
> 
> in the next revision for the series?

I can drop, but this patch[0] adds another label as well. I wanted to 
fix label issue before that patch so it doesn't propagate a known bug. 
It doesn't matter, one of us would just need to rebase our patches.

Since that patch was from April of this year, I can switch to their 
authorship and keep signed off by but address the comment you and 
Nicolas made and add my own sign off. Does that work or should I just 
wait for them to send patch?

Best,
Brandon

[0]: https://lore.kernel.org/all/20260831213231.2125544-3-b-brnich@ti.com/


