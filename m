Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FA485517;
	Mon,  5 Oct 2026 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206243; cv=fail; b=ak+3hfQa3Sg+idlw/nV+ecuV6VPV2jXiurl2RuAmunFWrRV2znIYfj0cYY4p77vlDYFqIHW/FVFfrU6D5wlNFueMY7j+XPaFqqjOzk3EcDu0wk3yK9x1UbSaKngEdAAAZjZnYtMKy22m121lc8KLeUV32Tv1VnDXCGRNiR2sSoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206243; c=relaxed/simple;
	bh=DfTEyrzOUppfcsPUDmdqBBzV6qzNYmSun34BsV9a4Dw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=h8RthQmY+DSOU/hrq9FCJkTvIUmFvWhUbOSAPdPY6JqDNl6k3cia3IPtVX6gdikkZFYoOmtyA7AD2X4u1q13+JrUAcEKPGRRTDR1WMtube1FOPBvc3pZHO6WuFQ2pV/zjsSUTKTqn8bJ43iLYQOqfamP0cdsKbE/eawkdlvwvpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=Z6YCHYUq; dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b=L+u8qv/H; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="Z6YCHYUq";
	dkim=pass (1024-bit key) header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.b="L+u8qv/H"
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
	by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 695CI7vk4052391;
	Mon, 5 Oct 2026 08:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Uo6k2/wfMoqNkfHUXKyLHR04A6b4E6HVsviUYN2ib
	ko=; b=Z6YCHYUqFaCk7mMyq9mUMFwrXMPLsWF7nBAFYNbXIceEtYBPdLRwvrUip
	psHveIJuY2oKeCVoJkBxmniet6YEWwzrX6IvdXk4HrKJkqH8vnf0bJ+kheT7DRB8
	wOJblPB2RElVZFPIvsdQRF+e3SQlxlieLqe+tKcjJb6KH3hUj2/oppVDKm1udnjx
	XALaljZ1ES+XvyKg8nPPzcRI0NHRgpU8JNheS/dQe1+jgt0iMw20v7h0NKlLJCc4
	Vhj8aSKbh2ZzNujECPRtDXLvkF7AcWS1mCW3kK6lKOsCFhQgyjgJYtiaYW4im/g+
	5xgx3DWPygoKf0IW5BJLHAPI86bfg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013023.outbound.protection.outlook.com [40.93.196.23])
	by m0384305.ppops.net (PPS) with ESMTPS id 4h3knnn7nh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:17:12 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJApcQfaLmEN3w9OJ3eXHFmb36GJ9D/fcnXX8YziBzqdP2UNRCom0nJPZ/qx2/sUAqTUjaArfHNcda02ZDGBgl/W52Yc1GOoEycFogWn2VqBeMeTXsnJC+mMve+FNW+86LjkwOrN8ExI+5pGnJyM2QXHQ9KIb0FfybaZCvwyThR6UD1HIwrm+jXWAOHa/gnQOD75Polc6F3VSmaIQsVJIHG5GR3kj0dJh2eP7mYiTi0T/1BrujO19l7hkjzK5KKyTIWpbLxVui4YicAsx3QlatjN/Z81JLWfIbEksZGZpj1VQyYXdnTluS3MKdPR7Z558+H7Kg/D0t+lR92RRE+dCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uo6k2/wfMoqNkfHUXKyLHR04A6b4E6HVsviUYN2ibko=;
 b=SeiX72Y1ClhpDwOrOyLo5KnFDAIgrSH5rKEAdJKFChAennFTI5hP239pjJJNf074ypwaIHrrub0Cd62VoCUn4sWGkdKr0fXv8zXxkeItSxtGeOCVpC4xxsaY0MIG/s3SQyJZDdMNqGtYpsJVW50bdSz8DonY+uTW5cEOak0q8iaesEY1zDoT61tgfGyZ7knbG1FDYwxayWOWicMW0oQbWB7CaQuDoRv9yPR9qbpcg6CY6SuCPY4dCjESGIsXJVIqG1OqUuiiFDtZrV8kB6V45aL8l0giPTp0yxfqzEvins0htd4InuVjCCb70mseQ60lMK+fMeBMuiatuZrRUivU8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=ndufresne.ca smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uo6k2/wfMoqNkfHUXKyLHR04A6b4E6HVsviUYN2ibko=;
 b=L+u8qv/HaAfYRBT/pCBdBYCdXxprIEfor0aZGovCuJatPqRbPpuZoQy2q+d/2Qn5yQYpVwsopeO10PZ6p2gTKXBhcyoQvtms9GQHP2/nu3TB7Hc809DWn7918F0V4M+Gv7PjOdWLJlhMO3Xm/SE3hIXCan+sRBuDkVkb6CC/xj0=
Received: from LV3P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::25)
 by CO1PR10MB4546.namprd10.prod.outlook.com (2603:10b6:303:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 13:17:04 +0000
Received: from BN2PEPF0000A88F.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::1f) by LV3P220CA0015.outlook.office365.com
 (2603:10b6:408:234::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 13:17:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF0000A88F.mail.protection.outlook.com (10.167.248.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 13:17:02 +0000
Received: from DFLE205.ent.ti.com (10.64.6.63) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 08:16:10 -0500
Received: from DFLE212.ent.ti.com (10.64.6.70) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 5 Oct
 2026 08:16:10 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 5 Oct 2026 08:16:10 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com [10.24.51.87])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 695DG7Ei240749;
	Mon, 5 Oct 2026 08:16:07 -0500
Message-ID: <8afcba70-afb2-4cd0-8bcf-ef20e84744cd@ti.com>
Date: Mon, 5 Oct 2026 18:46:06 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] media: imagination: e5010: Properly Release
 m2m_dev if probe fails
From: Devarsh Thakkar <devarsht@ti.com>
To: Brandon Brnich <b-brnich@ti.com>, <mchehab@kernel.org>,
        <hverkuil@kernel.org>, <sebastian.fricke@collabora.com>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Nicolas Dufresne <nicolas@ndufresne.ca>
References: <20260831213231.2125544-1-b-brnich@ti.com>
 <20260831213231.2125544-2-b-brnich@ti.com>
 <39a03dcb-bebd-4794-a2bf-ff1b56cb632b@ti.com>
Content-Language: en-US
In-Reply-To: <39a03dcb-bebd-4794-a2bf-ff1b56cb632b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A88F:EE_|CO1PR10MB4546:EE_
X-MS-Office365-Filtering-Correlation-Id: 28b5d3fa-6578-40eb-7804-08df22e2f19f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	e+33XXpaeC2yirHpUBhSZBJvdxDVEQgC4vXZEvR8mPGe8nRDzyTP4bj4N2zwulJW4MAd++DWmbLqUtf+FVb95yUqqtNlhhiq11eo7Cr3TGVyKnbn+4rxmvnxUK9yq9BgAg4uYig+C58tNJfmTzJEArU/5YLQdVUUUbWvFw1MwzS6xskKnZFtSOH8qBxyg8fXXfLEmxid5FqV29K5sfc4zVrJOD0dH9cNfAMbiMG3/zg+eWk94K1zgaEq7gcWblW9FmrLSOotNCwd1QGAZE1LARjuvlyTx+fT3u9KiV+0U4rH6R+5MYC13ZlpoXdW+Xb4Jh4rHQf4l8rkka2SSPlMN2hjEJ6Oo0Lan1SLZzWqv6VC3uRIWGp/LOVPdUMLDngp0wmGy5SWuChlZPEEVYx+P8U9dNgIy3s5v5Xw/XyuppPV4L4Kbnv6F6SHiXcVGv4ZBEI9SlrXS7PGoboizPeA2qjbiftHKErZKLk9tXw5gDN1eypzS/VEZMBo53LOxu/iUb+5h2bNn+rgJn/ptkG1/owcJvountWbk7CBCRatT7EC3hyU/FKrnX81xAxHY2L/PpF9a6x2p+eT4eDyWYmuOTU005nvJde6K3tQisdZRZILN76uafimKbdRLltYXxAN/3B7zL8wtKn1ZMAFBjYzdZfxT0xN7Sk/74yd5gEglwE=
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VDcB21kd4aMCvexs+H/lF+/RdTaX5dUlhK+nmZDd3DZtTcOhrFlsjQ+a3kF457fV/4G3cb1/W9msPClGp/LpTSK9S4Xu3UgOpa+GeJEcGZEitOKsgeiqzQfPsVPvL7Ne8FndagQgneVi1kH6w5+tcMTa/VAYZZZR/7qXKbLDlGWbPT8MxfKoTTPzCIQaclxxpF9esDAYMsoLINoyjnSeB5EDRBMoxFGp8cam3oRwVt613Sry7oaFnu65WYel4B4eJRlFQ1l3hD9G4F8KYXTbClx2TZM59djW0bnarmTBZlrtsdvPKHEpyp5WriFbxCn399BBsC6KAhjM8SwaQBl1uuBd1388t5PhGkBVwBFclg00fQ4Y2Cvvhomv0w/5kyILDyFrUb9LvjYTz9TR8ZDXlIhGrytRvD2smjXiU44N32qiUl1pGhMFmnI6/PxNrIe/
X-Exchange-RoutingPolicyChecked:
	DUIXDO9Lhrz73wPI60QkN8NmGlVLoacKO4Kgx6j2cLRp+aFVyQ20dr1I56h+XgXbf1BIIPRLgiRh5KvspOGuoG05Da1TUmZ9L5Uyd0FaHFtO+ANWZq7mbllfu9NSmv4pfT4+jiMSMEfntIy8oZdMwIxK1uDVt0hribI7CqJIjID0tqUG7deQxlD0pt2b4nrnYM+XLDKm0GJ9eTyh4mm31aViOkM+MP28uWj9l/i8g9cavjdIwaM4Q/X7i4jnu5Lc9hHFVo5agyQ5GLDs6mMn1Cux2SXyeDueQWds4nCSjU2akWt2rDlobmUHoCJDp3TSeu1FdonZ/bhUGm+aiORiVA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:17:02.0463
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28b5d3fa-6578-40eb-7804-08df22e2f19f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A88F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4546
X-Authority-Analysis: v=2.4 cv=I/7w19gg c=1 sm=1 tr=0 ts=6ac3a358 cx=c_pps
 a=iHXbSHwDNs+yH6wS+48/mw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=AlMIdn_sM9wA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8
 a=NdpDR30p39xbMVcjvp4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: U9fxKxDFj50Y4FjzC3cqhcGKWZNY3dcB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX3kBWf50JbIzi
 Nw6DTvX9OEUQZfda96ph0qQfgclI706c2cWy7cbSmFabkt3IkBcOHMe4gJm7U353hDTWRbo36NE
 RxRvfnaYvC7rZd+TzjTqGHsG+o6sWZE6AeY5EzD+1gKq6AuDF3OXcDWZqsRo+3i1V8yof2WbAtE
 9kkdovOa5rCweHCEt5LNb7jlVvyv7no809+3iDL5uIYWDlgzLmHzPdPqU6VU3ih3jySOnv8MOpP
 tKeccP/1PTOSnxhrd3IXPEvd92PIawJ2TbXUwSv8fI8gP4cK9rrb0LpnDQCpbOOTaeURqNlL1y6
 qxH4I8wJ9WBKQtIh0RTPE72KMHBVl51P1KlZCV2n/biUit1p40rKukffbgDiX7mhWwAnczIG9XC
 v2buaDE72Ix0ghzYhMHXUmynfxeZaf29DgckTClB0OpiKwBwsDkg6UATbvUmuOjLh5SUehmzK7X
 ZFibJ2/9iCXJtRlao3Q==
X-Proofpoint-ORIG-GUID: U9fxKxDFj50Y4FjzC3cqhcGKWZNY3dcB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1MSBTYWx0ZWRfX5MAYg6Yd/AeJ
 QeeFWU2vjOMvqRq4zd5nJibRnCOxhELKiVS8SapjrJ2uBXktSNT2vlQdlAo7+4L61EgXyEtpJJN
 /bI1ABEsve7lRPKWveKML28qbIE4icQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050051

Hi Brandon,

On 18/09/26 14:38, Devarsh Thakkar wrote:
> Hi Brandon,
> 
> Thanks for the patch.
> 

I think this patch [0] is already addressing the same problem.

[0]: 
https://lore.kernel.org/all/fc08a754-1e0b-42ab-ac53-94bff728aef3@ti.com/#r

Since the above patch was posted earlier and hoping the next revision 
for same is coming soon, is it possible for you to drop this patch ( 
media: imagination: e5010: Properly Release m2m_dev if probe fails)

in the next revision for the series?

Regards
Devarsh

> On 01/09/26 03:02, Brandon Brnich wrote:
>> After the call to v4l2_m2m_init() is successful, the following
>> initialization functions should go to fail_after_video_register_device.
>>
>> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
>> ---
>>   drivers/media/platform/imagination/e5010-jpeg-enc.c | 8 ++++----
>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/ 
>> drivers/media/platform/imagination/e5010-jpeg-enc.c
>> index 42ad9ee3993b4..d3c11337c815d 100644
>> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
>> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
>> @@ -1072,14 +1072,14 @@ static int e5010_probe(struct platform_device 
>> *pdev)
>>       if (IS_ERR(e5010->core_base)) {
>>           ret = PTR_ERR(e5010->core_base);
>>           dev_err_probe(dev, ret, "Missing 'core' resources area\n");
>> -        goto fail_after_v4l2_register;
>> +        goto fail_after_video_register_device;
> 
> The label naming looks incorrect semantically since 
> video_register_device happens after all this at last actually. Please 
> change it to fail_after_v4l2_m2m_init instead.
> 
>>       }
>>       e5010->mmu_base = devm_platform_ioremap_resource_byname(pdev, 
>> "mmu");
>>       if (IS_ERR(e5010->mmu_base)) {
>>           ret = PTR_ERR(e5010->mmu_base);
>>           dev_err_probe(dev, ret, "Missing 'mmu' resources area\n");
>> -        goto fail_after_v4l2_register;
>> +        goto fail_after_video_register_device;
>>       }
> 
> goto fail_after_v4l2_m2m_init
> 
>>       e5010->last_context_run = NULL;
>> @@ -1089,14 +1089,14 @@ static int e5010_probe(struct platform_device 
>> *pdev)
>>                      E5010_MODULE_NAME, e5010);
>>       if (ret) {
>>           dev_err_probe(dev, ret, "failed to register IRQ %d\n", irq);
>> -        goto fail_after_v4l2_register;
>> +        goto fail_after_video_register_device;
>>       }
> 
> goto fail_after_v4l2_m2m_init
> 
>>       e5010->clk = devm_clk_get(dev, NULL);
>>       if (IS_ERR(e5010->clk)) {
>>           ret = PTR_ERR(e5010->clk);
>>           dev_err_probe(dev, ret, "failed to get clock\n");
>> -        goto fail_after_v4l2_register;
>> +        goto fail_after_video_register_device;
>>       }
> 
> goto fail_after_v4l2_m2m_init
>>       pm_runtime_enable(dev);
> 
> Regards
> Devarsh

