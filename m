Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619C43A7F0;
	Tue,  4 Aug 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785834320; cv=fail; b=bbLQbqYEYehUfCC1r3FW6GIXxfGwAcUCyNBgrTPvEt7Li5s11fvb7Q3QpAxQEHFeXuopB+h28QJw4NSX+i25uYrHzGHfyHkofAmpoAu5zew4e5Z/9vUO98UWN2EpgvYjtko5s6hhb+hANyvhRIrNv6sDPfcV9/DZZwvf1D3GrIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785834320; c=relaxed/simple;
	bh=mcGiOpw6ogjcikbjK6/jWkApTibmYPC/I99tc6UvTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jr0mhB/YgnUqY5W3EJRx/MP5sA9/yykb8eT/PTnT94a9vnNJ5h+Ae+54Fm8Y7808UpRz5B+bRHztvfMMOQ43Mm0vUpJfegaYl6lwK+7Wo01AS9k8NlUOvry45jkrxDLCODiYY7w0NiDJe5/3kw/IDlPu1sd5ynmAInwQp/S2prU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=bhNvoqZx; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="bhNvoqZx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAl6FGhrfrA6gkHW9PNruiaaJywrzcIS9KYkE4GLSTL8lmgYJUb2GgBiwV3raNammbvSccPxh51zyM0yzQ6nspxHwZ2efMVE0jCpUdi5HouzuW2TXBa9S3mjm9JE1lWuLrKhSg6RsVRga3aZQmzIRMo6AzoShyrMnUPBzmNazuLoaNigKUuvAxsZBMIyrr7ffZ3pIq0GtlBsEiGR953RAOrXQPkehQ1+s17Oa6WQpCDniHifMSNO8ksPo4KO/k125+zoacEZhxyWV2RNIjlFQIs4VvLu++ADnKT4QcJawzm+vqxDdlBG5qPlvpbQDjKbg8ty8UH4Np31/xkbA7nAXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y660dO42Jd+nnlc674LLQQcczIl07JTJ59yU+wBTCT4=;
 b=fFjNSCxWM9NuhMxTJrAzwMEeZQeEICn5LVwc5VCNmiRNH1JH5pekFx+OGTmYGJNngQgxTNYVdw7MYP0/9A99CzfimW/CtQSfJfFqT1gozyfvhOB1Cdf2gkJlA/756ZEjA90FjH3m1FsBnbWH+o4MLz49YRSZxnACUfeZDR3rO/VTpLtFKmlmNjch39v8CRDboctjNxquyD5rsco9P6Xmpyztb28ucHrG8WjKJmP0vvaoU/YUc8dRAYWVxKQsz3RxQyL9P/mxYk4Wqjwc2Iy+QT+2UYm922Ch1pE4IbtMzXRZoSQdChOka84an5v5g0Fwf7fTAkWPpg2aSqsiKdDdXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y660dO42Jd+nnlc674LLQQcczIl07JTJ59yU+wBTCT4=;
 b=bhNvoqZxT4Xjolk9RFKmGtOFaPyXaE5OOJcTqMfRvCWs2ILScWr2w4dZRrDbD06j/nB9d+O56Xlgdh7MityrXVHbAdN/aD/YyRXkAb1Xxk8wsxALNGV+8FFR69QnQQXg/P2FSMiRMk3Iadvd3l/L6zl5+d8NG03JggV4f6b7o5Mx9M9gxr+GJB9b45Yw0hdlXgSztI9HZgh10uVV+AyTjMzOOLlVTvz1toKPDUXkkrrsMG0nKeNOCx6vKfYQv9xQnfujNYjRAAvCducPGWuEb/n+ztv9qbdFqEtNxa8NtLDNJszJDvhePGOp46AHqhXxTdcEuJdldM24MMcpY46JOQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by PA4PR04MB7998.eurprd04.prod.outlook.com (2603:10a6:102:c5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Tue, 4 Aug
 2026 09:05:16 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0292.013; Tue, 4 Aug 2026
 09:05:15 +0000
Date: Tue, 4 Aug 2026 17:03:38 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, xu.yang_2@nxp.com, Frank.Li@nxp.com, 
	kees@kernel.org, panjunzhong@linux.spacemit.com, andrzej.p@samsung.com, 
	laurent.pinchart@ideasonboard.com, balbi@ti.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v7] usb: gadget: uvc: Fix null pointer dereference in
 uvcg_video_init()
Message-ID: <d62ux4m37z7xp2tt4k2voc55yold6khw5t2tiapctrumnmobng@goh7b7pur6s3>
References: <20260804034338.7976-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804034338.7976-1-jeffinphilip14@gmail.com>
X-ClientProxiedBy: SI1PR02CA0024.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::12) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|PA4PR04MB7998:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a66fcff-da95-494f-e43c-08def2077fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|1800799024|376014|23010399003|6133799003|11063799006|3023799007|56012099006|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	h6YG9v92TslGeSoFkthzmlCjpQ85ZE5IzPqYqxyFPjyT+BjCf046P5sz3VjCYFDrGT8Wa0vfPSXdeFJoDE7ULC3R9ysDVKVs6r0Enn+PYiWnfcVJdkVjjGOxCpxhidwzh38w7ZgWUpa1gO7K8fxVy8WvdF2Jg/vaN4k/04a3Qr2Ax+YLXWfLxtriVvd3Sb7/MMDiVhlJBKNyVLKxlHdO+mkJ5RRIxnCm5QsA8m5UaV4SRkaWWADpFNB8rGgTV76Tx7/RC6lY88Yj2YPnj14B5WPYuLJvkqm5mwbC6xUsU8ZwRNe8OsinlerQQqjLi+fSbjutlGPo7Jmg+yNuvTcCN1UWEThFn6uvEmX7T1tuAZoA/ZwrUWXe4qVM2c+lDsGMSRNA/VzxydPK8Rtx4Z10lELn8DEDJcpp1YgWHOA63akLO8uSTOcN97EvYXCaWNK/Oyp+h8xKn73e2etJA6yE9pgLSCqG1yyX4ZfY29x4C5ye4d0ridypKJOaaGjOtjqtkHXH/90oP2ulyMDStid2zNQoyJK7QhWVh8FabCNq8jWGydBdMPhq47IhdzzajuNQLP8RrhGjAB3pfQq33Wmpq+xN1n9O+ePO6Wzt4J/hwqJw2zRmJi/mYIHTCUwLQOkC
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(1800799024)(376014)(23010399003)(6133799003)(11063799006)(3023799007)(56012099006)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?egw3pozH0Is0sfZc8tXR+Q6lIT2eAGN+bJyeCRbnXdo7JijoKe7JRsXw3l6c?=
 =?us-ascii?Q?YG2PFFaDlxLe2kECXrHiPLUKY5uQbIj6iz5bZBjSS89cNIMWdS/NRqBH27Ez?=
 =?us-ascii?Q?TgLqENVgZqTrKGYEIBPjmEOEN9qM7fK9B+V9l6EFatbtVaVTyCZhSSVpRWfo?=
 =?us-ascii?Q?7SPUkkYE//bFUBoO/oPlClEyaWGkhq/awJIjEZ0glPGOidSUZ7v2BBDcfbUO?=
 =?us-ascii?Q?U4Tynk/nFiZ63F4pOj0pFeRAdEdaT0fSw/nwi8k29ZQS+jeeqI1j3JNS8UTP?=
 =?us-ascii?Q?QHSrCLtfOSJGFjirpY186lem/V5wrJv6Wqfrb3SD3mH6OdpqkKnbpAkSq4++?=
 =?us-ascii?Q?Ez9HzFABv3CQIHyE+a1/ReeXUOUc1TC4OypA76x7P9BZCeCz1+ISwQq7G6SJ?=
 =?us-ascii?Q?eusDyuW59z8Xk09LqCzeoojLgL2R7R5NjXrIzyaEH89soUbLlNR6DUqFYnKV?=
 =?us-ascii?Q?Qknil33oYlIqmr48mRl922R0xNdkUVos1HbxC3XXpcIisQ5RnoeeHXuE8x/j?=
 =?us-ascii?Q?7TDNv4Gu1KADmI2yOxrlF1vci+74+0Qz5BhcaewLPEJPKdAgpLQkgFg0xIBF?=
 =?us-ascii?Q?b7C1TFrx6SnURSkbRiCdlzQpfMLi99HqloIW0Q+3J+KKYa59AtE0ad6Lck+q?=
 =?us-ascii?Q?zm6dnG5bUGqMKq2aiBufSIOIbM3MNMP6iiUcMWHj5zqIgqQzJ7BQz/20CB8S?=
 =?us-ascii?Q?KM8vjcPdA/xZJN/7RmtJfg5ywNKKOAJTjQvw88wumvzm9JAMc9DHtWyoyvnm?=
 =?us-ascii?Q?gcKrcj+HTfAtZoPYaQkBzxJNwYwqRYHSNKcW9+W1g+eIjROka7OrgIlz+tbl?=
 =?us-ascii?Q?qsukPBZnj76QNhgLKgoTPDYq/iNyCxFODdfC9yYQ9GSHhrn1os661pXWi8py?=
 =?us-ascii?Q?gNiNJz99AJorL6Y53kTcO4U9yz07uBGaNv9UzKNo8qi1+0WEMT8jfn+7LO3O?=
 =?us-ascii?Q?rjT3qim2NiA7CuSwR+7cqTUAKb4Gly9iita9a3HQWseCuUklU0P04BWLum1I?=
 =?us-ascii?Q?DLI1vEOsKHYqzIofRC35odTJOK8roYKVwQ8WW38uDKSa8qtoj2/4A0WqxT8w?=
 =?us-ascii?Q?ZRW9PdQhT43iSrbtNZikiLSvQ9DWCLipaydEkuBBcDbsWY5C9RDeXUkCFViM?=
 =?us-ascii?Q?jXbCAiYtabNP45NDC0gHk5gbAryVtAYG3KSAk2iaitxF50/8c9pnruP/pXEF?=
 =?us-ascii?Q?FjRiqR1Bh1C5q/4THuGhRr6A4NGX+em9aZhOL4sMS5Ozc/B2fOXqWieu9rNO?=
 =?us-ascii?Q?HeXW8gSR4Q2IUGc1ALHeCcAa848+vzi7ESjhmrRuVpYZ04pQXj88OOP6Yn6s?=
 =?us-ascii?Q?sVZtdm+0ic9eE96G+SSckESq92rO+wCkyZzJ2rwEywRvXyZOcgrvBk73afDg?=
 =?us-ascii?Q?Qysd7y8QWBV7W+x4l0tAfv42I8dRwijp4PeEkXN5Nn/9Bsy3UH6L9FvKme9z?=
 =?us-ascii?Q?k4t0boQ9uu6FQw8cXuZEjmuGGnLBFB8zig79qfxRNITn5ZWafgzAAX0UHew1?=
 =?us-ascii?Q?YEUdrvBfIERfOMSj/AhdmspggBBwGWoTJAFPdgMchKK4JYz4jcoT/y1mLUyq?=
 =?us-ascii?Q?rHSUYuKKSwh+JjIerHTQ07zx5boRQ5rs2E7dh/+RBd8rjTRyS39SvROhqygl?=
 =?us-ascii?Q?y5VxR9kWhETV7oR1H17a6D3Z0O6m3b2haaUZqkags6+SKy3EggXORQzsqMMs?=
 =?us-ascii?Q?FjcCWgZAoOf13wQnWOeILWvNesl+SXHfd5KKXp0gCH6f1vYl8Z1/Etv3Afqn?=
 =?us-ascii?Q?KC+rckhbq3IP1FMJyC3FPWkkVAxxyz+bjce1cgZRQqmyKPc/DymA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a66fcff-da95-494f-e43c-08def2077fa0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2026 09:05:15.8532
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Lpw6BqgKiVzKV+HTDChrkIVxsV0oS60Mnd/R9HyV2GnTmKilA/bQ6lC/ASLQiCI0kWfRS1i3Odn7WSV1t1siwx7e3mm64q8Gam15SdoNvMEIGdFtIumb/xEPcEWTO6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7998

On Tue, Aug 04, 2026 at 09:13:38AM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: f0bbfbd16b3b ("usb: gadget: uvc: rework to enqueue in pump worker from encoded queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>

Reviewed-by: Xu Yang <xu.yang_2@nxp.com>

