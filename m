Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com [148.163.150.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9AF390209;
	Fri, 18 Sep 2026 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.150.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724522; cv=fail; b=aX2M9x/woPCx5KXoUNN9aMcUCk8+V1URzx6F17vSqoGPmHBM5nqwqf8VhnChca84yaPwC+mpbDp3meJi19VOIrMoSI2Gtr48yoImIFCfaD7VGE6SN7h459YHZFCCmeRrb8IO/TZA+F8/BE2sgYp8Y5f9WahL5bornFZjhe9lsUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724522; c=relaxed/simple;
	bh=CEreAJniSk7RQh9v44R74CtAepdxeEnPLt2qtWI4QTk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=s3VGV6F8gW21SUnBaIZbSGXc5zExHjEjfOeA6pKAwioIwbanylqcLXpolGi2TwrF6eb3gusivORmcQ3oox4ZCLmKDBg6h2yh2z8HkPttNgbOTcVodNBwyHVPs+YL/fP1vZfhXODLx3u3nNHc0xpGu2L7yNaILggFsAcaHxU0YdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b=F0qYPF36; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YoRfpNO5; arc=fail smtp.client-ip=148.163.150.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.b="F0qYPF36";
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YoRfpNO5"
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
	by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 68I9cR9o3870217;
	Fri, 18 Sep 2026 04:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint-05-2026; bh=Z4yxnZ44PUF+Fy6BjvzgAixiAvzziiXwhJLspQ00h
	MY=; b=F0qYPF36/0CIGpB4BCrPcdPI8ZD0wKeLfownuBrMKQS9XwHvzfSEwrdeu
	40YvFZH4DwMU7NQgDRTxy9ws/XGPgwMb5GvbSVwxfqHqrcmqKj84kCpJaSuKGCWV
	osY3Meh7NM6iWXiVfodCclGeEAmC2garcMln4Fr+rkJOcr2wOBX/i6rQTDbdXYUG
	RHCPSgG+EputPQy2PXbWc9B/gXcjMlFNORJx3rH2Jrb30a7UhOVtPrPiQiPYN32O
	0UjqU2dOeJnwnyhY/bQQalVlYRzPYF8g15C036SEOVCc1aqTfIKf44U1yNbIMV9Q
	WLsNsq9Tb0D+vwuPDRlwfECqC3+NQ==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012002.outbound.protection.outlook.com [40.93.195.2])
	by m0380145.ppops.net (PPS) with ESMTPS id 4grx6d9ryc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:41:54 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acmL49OzZOxnVp7/pU+jEcoXJEGzC/zYzle2jsygnFrM7nanUM/ez5kb4qKg/g+ijDt57tOLSrt6ljYGOVR0pUn+E06yte+TcaxaJlzLfBj/2JlyBTU+xqEMZr2IujQcVOf6jKUvjYklvVa37i0mr6l9Xo7+aQG2Zpm+CdMg5+zalzASus0jtxhpoA112nPNgsMXP9sAHCXyXmaYALWxvDWmp5DyVB622pzf2c11NORcu2DMcaTywHSG2abHj6Hr2f8q8FlXuyh/bwvVE8YUOzS/IlcM7EjGXlClbdbuQ5XkC0CqImsiFPgmYDQuMtpZtAPksiX3IK+BDhF9/yMJLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4yxnZ44PUF+Fy6BjvzgAixiAvzziiXwhJLspQ00hMY=;
 b=M4nZ3KcLuLIOVtipYy6TQT9hLSQCpe07O9NDazT4kaKz5/gU5IzQgchoTPcUqyntX33/dAlbvrCfRTa8qEZt5u+sSY6IJ3zK7dVthA4V3ldMFv0PjuQH65B4PKtn+7gA0nlD64j0zPiQjSzbkXyH4NOMqFIbvdN5E6TlbhQmTMP0Xy0tqo3OwgXC96RbCOiQ8LaMcHQYhovyD5hXQPBvzYwfkyC5F+zZxscLlr8+RBxxkliuUSIwRlzpYDda+Sdx0U55YzwcWn1S6F5B8W6RIY6LBLhIwW4XlH8vFfYoDrA9uZRwZO7NwOpjhlLrdD3QiXK4DsKhBILtvDaEZh/9Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=ideasonboard.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4yxnZ44PUF+Fy6BjvzgAixiAvzziiXwhJLspQ00hMY=;
 b=YoRfpNO5ItOX/lFgiAGR5glTibB4PMR3xCgdAAs/xA5cke+YAvql8Hy6l01ooC5xmefzqWYjYctG43AIZGSe+YTEkhCd4QkkaYEB1iPtgDyOx8ef/7afR9+PN6uU8elCB0ZYtCmjGPpjZ+QEqeYaiEPtIA4mfB5feeAAE+kkCqI=
Received: from YQBPR0101CA0231.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:66::8)
 by MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 09:41:51 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:c01:66:cafe::45) by YQBPR0101CA0231.outlook.office365.com
 (2603:10b6:c01:66::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Fri,
 18 Sep 2026 09:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 09:41:49 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:41:20 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 18 Sep
 2026 04:41:20 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Fri, 18 Sep 2026 04:41:20 -0500
Received: from [10.24.51.87] (devarsh-precision-tower-3620.dhcp.ti.com [10.24.51.87])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68I9fHx31477361;
	Fri, 18 Sep 2026 04:41:17 -0500
Message-ID: <5c96e842-5b1b-4dd5-9dd8-01c5d77583b8@ti.com>
Date: Fri, 18 Sep 2026 15:11:16 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/4] media: imagination: e5010: Move e5010_init_device
 to Runtime Resume Hook
To: Brandon Brnich <b-brnich@ti.com>, <mchehab@kernel.org>,
        <hverkuil@kernel.org>, <sebastian.fricke@collabora.com>,
        <benjamin.gaignard@collabora.com>, <linux-media@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <stable@vger.kernel.org>, Jai Luthra <jai.luthra@ideasonboard.com>,
        Kendall Willis <k-willis@ti.com>
References: <20260831213231.2125544-1-b-brnich@ti.com>
 <20260831213231.2125544-4-b-brnich@ti.com>
Content-Language: en-US
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <20260831213231.2125544-4-b-brnich@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f798201-1182-4ca3-fa36-08df1569102f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|10067099003|22082099003|18002099003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	VAvutW+nJ9epYvylQDKkDcX3eCgdcWYAdNot2Yp5SaT83mN010DBxuJymAdhjIyIDv1pkrBsWu7DhJEBB9b/n1dHujpC3KdrQtjNqxrlojnRUTJMFyFCf2JUy/pTIH2eY5qaIpxHtDQuYHBQgOIn6UkxN5HZ6odyF55/yo2FXXOVlGU0DCLOfUwbF4aM8YU16vJ+4mBqCoB1Rx9Sbp3THZ7BciC/+X8hIFFH7UuvSU0Se6pyU3/pCMOODnRJbN6S4OxyvvxfKvdnLdRoQGFMbkZjX2X+A+zqdaSb5Ri9zeqwKHDPAAW198OK5Ty1EeNtlDJ6T5AdLkEIMxhhLfEjvNwrP0cL+efCSWV5myqcnm2oeSKA4Mh+QAI8IcEiHceD6tQXu1CeRrSK/o4O7TYZeDf2+aGaM7o80QSrKjwrX+Qy3/gp2rDIgBE/yHvprmNkAJpa5mXCrIfgGHLHVYIjO4SefFGEBzwvGEEwJ4ETnEGTzkxeuBaeuvvy+2l2S7u89NU/tz/O/wblHCZAFWQCkT97Og5BugYC0wtP9QsinfuzzXiHXbRYg0BoOVAHTLZ/8IGf6p+1tsCqSLpp+Drbbr2hQp0EbKcNdpokVMaNmuluH+YioKO5GdSL0qRPDUyf5qDE2Adv7LUMKLF7mDm07Yr9rrRYRT7h1Fa+TLJVWpSVZyX9KWbPM3cBrgkEpq5jYpzuH0X+JmajBwgj++fGlw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(10067099003)(22082099003)(18002099003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Chu3dTlIRROrpxFlsmeyKfz1Z4ws2y29LX6wtbnP4o1lwXnJXQhgJBoQg2KoYYhd/A82cL2Vmf/16nlOtf0kcpXajyycjxBQXlH913Lp/0k6YRl+ZZhTwGsFFeTQQ5TsMl9SGXmuefLABnn6x4hqUvXw7Upkv5NFSTn5/JLGxW59oTQHhcc5UI56pjEvSdmdmyGUiRZS+2ahIJ5ClWZkjIS4Zv9RsuwVk5f93P29AyjfwiQ48iWQfeDrBgCgoolyXsj7lNaDb1zacJhGKtzSJAeviboamYug5iW0BOcpE5Vdh2gSEvnyPDTVh53Ls3QxYD+BmlRhyu0gxJHndCxs1mIRTKv4CVyO92RSiZFxJRcl2xU9j8NN1y+xw9ElipctlML0Medr65MT+zX9Zlmh1vAqpY5L0l/3+rFRS805ozapEZ0vSyC8Rjkcx8jwpC4j
X-Exchange-RoutingPolicyChecked:
	jiZtjT6OFco3r/W9j4dcxtUK0NNaNfFgx9FjHR1j+Nm3oKGwm4pGkRC5xQRcuNm5ZQf26tUqOve9002e0HFfyYv1EMbfV03wC9qOgy4Ey+/0yH+tRfeP8vzahqV/75tZ+qzkjSfLlvYFr4ibY0J2xD2DefA2bo30bAv1vn+Kca9QxbCZMWY6V+WPLqNnT26s5O21Ew2D79ZRYHJxIOli5bcHD52P7DiYebWBEqYfxGUQYXbb88NEMlXRRVpk8yOawgwszInDNnvQZORjG9ec3NHKajKrLBJDaadwXkJiXVSQ+tR397dnoKOKt393JGEZ8GMmPjFlGexgPSoUthIHhQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 09:41:49.6072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f798201-1182-4ca3-fa36-08df1569102f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDEzMyBTYWx0ZWRfX7cDJTr2M+YjD
 a+NHVI3k0v7NWOqy57u+7Kpi5CDaiEdf9nJTUwIELj49yP7zXBGdEkmYhtKhi3Lcfi5riP7ZRye
 QSJQ3varPOKm5/zb1uw76JZrCotTG6Y=
X-Authority-Analysis: v=2.4 cv=Cswq4X4D c=1 sm=1 tr=0 ts=6aad0762 cx=c_pps
 a=LBR8CsJoUNkXwF8+XrmcNA==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=P1BnusSwAAAA:8
 a=Tg7bMRh8Bi4Y-2AXGZUA:9 a=QEXdDO2ut3YA:10 a=D0XLA9XvdZm18NrgonBM:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDEzMyBTYWx0ZWRfX966ieHuFL6JP
 7gfob6SfygH6P98+lwcIMWnAQ35spTyJ4JdqVoVa6OhRLHEtE8d/MUHpfA5SBbqnPauy2T+WipY
 Ea89xWa/wIG8Hm8JGH4G5dimm0kKFGxqCz9smd/JeKThUIZlImlYOVArvrsdIV6R9UciiZ8l90N
 idwFI/i9WegEX9b/pSPblgn1IXa3DhNAds8JxG6wfzt2VoVqU41iF6iZ18e956hWWrIGpxhv6H5
 p6KcHJFsumBOA3hfgf+bOxl5zOFOltXw39POoEew0TuzMvKXTqfJ+JMzToWFG5fTzuMA2lQTs29
 2gt/Rzdl/bdxpi7SxKtlnqpz4gyPqwmm+IEoiXpsDsP99RMiRINZQrtwAZdLo0is+3FtOS9k8l5
 LihoxHB1ufkpAae8GZNHF0ja/3eTB0ojyzQJuczVblw+UaLxIqg/A1uMKZ8xbHQfr/YjiQ6jgI8
 6JnzbEdn2a44jYLL9ow==
X-Proofpoint-ORIG-GUID: PNRNVDv8sj8ZxBYrKIkEAbS3oKBX5FcL
X-Proofpoint-GUID: PNRNVDv8sj8ZxBYrKIkEAbS3oKBX5FcL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180133


On 01/09/26 03:02, Brandon Brnich wrote:
> The PM framework skips the runtime resume hook if the device was never on
> in the first place. This results in a crash in the system resume hook when
> a call to e5010_init_device attempts a write to a powered down device.
> 
> Move e5010_init_device to the resume hook to ensure register write only
> occurs when device is properly powered on.
> 
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Brandon Brnich <b-brnich@ti.com>
> Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>
> Reviewed-by: Kendall Willis <k-willis@ti.com>

Reviewed-by: Devarsh Thakkar <devarsht@ti.com>

Regards
Devarsh

> ---
>   drivers/media/platform/imagination/e5010-jpeg-enc.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/media/platform/imagination/e5010-jpeg-enc.c b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> index e98fcd3fcd9ae..488f5d7e4c9d5 100644
> --- a/drivers/media/platform/imagination/e5010-jpeg-enc.c
> +++ b/drivers/media/platform/imagination/e5010-jpeg-enc.c
> @@ -1511,6 +1511,13 @@ static int e5010_runtime_resume(struct device *dev)
>   		return ret;
>   	}
>   
> +	ret = e5010_init_device(e5010);
> +	if (ret) {
> +		dev_err(dev, "Failed to re-enable e5010 device\n");
> +		clk_disable_unprepare(e5010->clk);
> +		return ret;
> +	}
> +
>   	return 0;
>   }
>   
> @@ -1543,12 +1550,6 @@ static int e5010_resume(struct device *dev)
>   	if (ret < 0)
>   		return ret;
>   
> -	ret = e5010_init_device(e5010);
> -	if (ret) {
> -		dev_err(dev, "Failed to re-enable e5010 device\n");
> -		return ret;
> -	}
> -
>   	v4l2_m2m_resume(e5010->m2m_dev);
>   
>   	return ret;

