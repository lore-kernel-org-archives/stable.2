Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792506559;
	b=RC0KAB6rr7AdAgZrRNEkRJYI5JB5oEt5DknuJ8XCFX74PpFASMkvs2PR86y3ifuisi5o
	 cGpUTHeIwkvYM5CcWaRRa/jkf6HvKNtueXaIyC9zaLS5UDgFhJfxeOaiKhBrXBYurou80
	 /672o2LTCONlLkGooiVp/FXW/f9WPLleY2+xTmlQF3angnlA/AVBE9rfmh/nDMkaTv+/X
	 YDvc86Rst0ONaXin8dXkKCnYhqqvM2yz6+w60jU037ClaL7tlhFMyOWVuyQmwIOuzV/Iw
	 yWndcK/H14JVogTPqitwhFhhkFBrGw5VQ6YpI1EG+BqW+jyo3AfM1e0MDDeNOIo90tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506559;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=NuAe8AjFSftttWQOn65dh16cRt0hMp+B9GtrMj23Bzk=;
	b=qkYE/bpyWrK4501BrifpGYBJ+eymx1Sx/tsW9yCaxWCSSNfrDKf/lD3a1R4/ZedVvIdm
	 UKtWqBdFsMl/+FFF4c7dc0IyG2l9G9/E1mp8NS8rRbxMbk8m0FixOWVRovKXJiNIleH8m
	 cMY0E96P4OVbPHKNmi0U8rWbnO/186ze07fD/a5zX/eFNYayul+vAKt2B03W1jXstNXdm
	 ARpHhVUN+zt6FyIKRWPXDqKr3Zp5F3UigeWUj+jZMYZtfN6yJ9lVqbRcwqtvnbb4NtCLT
	 Hq9SKmG5k2qmBylAwdSheMym0OxlZnB9G5BNfVzX8XjzG64JTC8AfsVQvaO3pqkS7pQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W48DmTft;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.57.43
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011043.outbound.protection.outlook.com [52.101.57.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF3D606A323;
	Tue, 20 Oct 2026 14:29:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF3D606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=W48DmTft
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zR3kg638JGe3EBCvZsYpQqhNSi4mGGIau7bcOJXK6B9E4ImEYaioh2xc8/Shkv4gy6ET30bWyGP9MNinJ6/04SZ1ZrNXOrpWN6d2nVLDPkU48WtSP31+ozgTMcBAAjkVcCssalWXjT4BIuEeijsP8tXFi+yMFNBCdQakiZtCB96TM78+yljE8Uncs8LG/cwM5lswXLvbhbIzVV1v/9JEk+Co1LV0cSFpAf1enTJqhoanv9wEzq9FbN7yhIA2Q9hhMK+7woc/HzJQHTXhDFI8sxHNJ2tmqDQscVE62HQwJPNHvJO1yO5nRHvthFn7AgLFs4r1bnwPvyV/DOOKTuHONQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuAe8AjFSftttWQOn65dh16cRt0hMp+B9GtrMj23Bzk=;
 b=fuVdIPmiNRAhSnNiDf76ZK93IrHLcxnIHXVYSpGMG3UDwAMa2ZJfklhOGpQGCiKEDy7uyP/oHxsv6zysCDd1+VOqhwTGhmqnr4ut23Zyli/44M6+dhsL//VR/z9Mm4TvLZvyB35CYPwJR+Fvr1F5dOBN4AovZ7o63690FJe/fRpt5F04MKoUWjylSeW1NMFaKaLvmZA6kDMbqjhEe/848tnL/xo/LBq4qCliNwAmmaifKNqUcqWBKcV/OHHqD1Cgm8L8j4oy7K5n/+qKxKEwf0R8apnX5gvU/1F3RDdPSI3ELdhT7RipVzqBpnIzT7pkE+o+TBXyeTE1PC8iiKEIjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=acm.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuAe8AjFSftttWQOn65dh16cRt0hMp+B9GtrMj23Bzk=;
 b=W48DmTfthSXiMihNl0pO7evJE7SmVG4HxHggOsE/sqRjAAtWPw9yLYZh31hUU2IwUCsUowbtOWHWYqnhXcb4vebke6jQ+fi3x3fQ1+9qoQ/k5M5ziTVWKMEE0t3eytfDRjEJu54MGB7VfSJvNXcET/qrROvam24IM/dkeYY/BDQJe4jqHsw6ZSBCzrkGdk6xBdA8xymAFuKoDp4pHN/Cm9kphFqLvXpri0YhuCBtfK2xG1ZPm9Gmp3oSN1O9744XzVT+ADU34fH6w1xPq/9zJSq9a64m8wu9Pr5ym9xB3FIB0RNlc3oD8T/E7zwR1Y1bKS3qCJ3DTF4nYfjBinN1Dg==
Received: from DS7PR05CA0001.namprd05.prod.outlook.com (2603:10b6:5:3b9::6) by
 LVXPR12MB999196.namprd12.prod.outlook.com (2603:10b6:408:3dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 14:29:14 +0000
Received: from CH1PEPF0005BD61.namprd02.prod.outlook.com
 (2603:10b6:5:3b9:cafe::76) by DS7PR05CA0001.outlook.office365.com
 (2603:10b6:5:3b9::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Tue,
 20 Oct 2026 14:29:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0005BD61.mail.protection.outlook.com (10.167.244.250) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 14:29:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 07:28:54 -0700
Received: from [10.64.160.70] (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 07:28:51 -0700
Message-ID: <9609b534-4af8-48ab-9863-9dec3596a6e5@nvidia.com>
Date: Tue, 20 Oct 2026 16:28:49 +0200
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
Subject: Re: [PATCH] blk-mq: clear stale inactive flag on hctx reuse
To: Bart Van Assche <bvanassche@acm.org>, <axboe@kernel.dk>
CC: <ming.lei@redhat.com>, <hare@suse.de>, <dwagner@suse.de>,
	<linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261020125129.430600-1-nirmoyd@nvidia.com>
 <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Language: en-US
From: Nirmoy Das <nirmoyd@nvidia.com>
In-Reply-To: <ff516ed8-d4b0-463d-952b-14cf110ec8da@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0005BD61:EE_|LVXPR12MB999196:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e97d37-ae83-486c-16ff-08df2eb683ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|4143699003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	VeO6j/8U4xh46SWUklqLdkvjyDq9tukOyZ/fCnB+77EH6PbPqMxbfdx+UEDek9/mk9Ej2DeLjWAyiADj0VbY79hOVAHnX2kEbz27jQIwh4NJfSSChkEXD0QMSDMomsnSpaNlI3HUiFf2MG4VZJZjQk1lOCK/BlhCX/dafs3DqhBF9ySGgU7KLNOqEkTDRpyZNUfX3EJWqZqO8NFTaebavLARO6lYj1Okqvb+EXdkOmYOVz+Wtl2Rze9ul3WlTup0F1A3Mum4Tum/2ckY4sAKYSyve3xMv8eFBLbCR5/VX0gW2A43Qys3Rro6feIceclkBVpAF0o1JGn7T1Q8/CofNVy9SEq9jWkPY3cMY3kxa86ig4xQvRS1UJ9j2P4Dw7VfCFaJggHJTmm9/MjNNGFMq7oGLreEWFgbWE2eJQyJLxpYLw3qigwQRK+en4/giaHaJSXLGDjdz/aQa+SiKEy6i02973TwVszlsvrAQDPqeqY5I6+ufD/55Yps5Wqgv1/O6hN5x5UMufw2uPo1tZnjOo48fNvtcXzKpguau/6UqfpoTuUDKGFDSFAj+jmFwao6DC7PsNEYry7+5NmhoYjkFbVQY6Qbv3t8I0x/MLbU+4bU/dlalTJqk7BF8mQqkQmteNJaTyTSanVucQo0aCJtQTNyIANDJ7e7ml2LpeuGvHk3+qGJ12qDwy6MQPvXmYtbG1hkPTvvYohsEK2kEjJm3A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Nh/cgxutNASfQ55PkEjcfUdLeB1QI715K5ehrSMHq/U/ZpYarQDg3RCTgZ6BrfyBPBabbu76JRm8unNdGSmlEOYy39BYUTOGvxFB9Rrbklyyo/CXbERUJIfGM3eZnCIQ+9Jn8GYiGsFQUzFWL76ofUGYvdLm/iEByJptHQDQiDuBu5jfLdSdZ64R33+5vGXlRPfXgeuNXQL7qxNTxjCCOY+QLbLFN694rPzXj8VwOEjF8oXq0iaa/wnzfw71P1iEFKSRMc8kH8X7890u2iA8NZ/xgRloKhlQ92HSTHbmkPiwxAt8728Q6p8FhRDQIe+98N2C934xwehTevIDcjEOmXyutobEUl56qj8tbi1nq/knRBLmZd2RfN1l2JfGgE2gaUCV6Liaxs3F8RCt6PF8ilJB9q0fyWwI3iEoS4qcjc33jFvxnXiTg7oL0ZDJQTm0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 14:29:13.7220
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e97d37-ae83-486c-16ff-08df2eb683ba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0005BD61.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999196


On 20.10.26 16:13, Bart Van Assche wrote:
> On 10/20/26 5:51 AM, Nirmoy Das wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 025a799f35b924d..00b75eb95dd943a 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4002,6 +4002,7 @@ static int blk_mq_init_hctx(struct 
>> request_queue *q,
>>           goto fail;
>>         hctx->queue_num = hctx_idx;
>> +    clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
>>         hctx->tags = set->tags[hctx_idx];
>
> Why clear_bit() instead of __clear_bit()?


  No strong reason, I followed the other hctx->state 
updates. __clear_bit() should work too I think. Should I resend with that ?

>
> Thanks,
>
> Bart.
