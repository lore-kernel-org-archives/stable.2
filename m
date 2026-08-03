Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013003.outbound.protection.outlook.com [52.101.83.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCAC25B0B3;
	Mon,  3 Aug 2026 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785736292; cv=fail; b=bS9kAJy6uDE9lzMHZKi+YjYTi35lVS14fQawp25Gi51+ZJAW1OJxs41iiFqQomc8pRtlcwtXPg1QLAhzhKJ9VsutXDUmwqtqOzOreQdCvwLExTokWpMIerrnyKPpztvl1NtY1mN4k2NUPlgCTvk8fC7wEIyfhVwy7ZptTEcqtnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785736292; c=relaxed/simple;
	bh=e+RZhptv8YAN8p4tcdrQ8k+RxlzqV2jkRL/gBLIHeOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tTHFGZQzADsQTSXcC+Q0WBRvBOSwIn0QXE2fg8wZLenMspdXSRT366dHJr0dXPLRMIXCFxPIRL9qutTzqvp0wePWzmJAMiTMoqQYnQriBMtwiJyfA9hFcy6b9dSWYypvnBnaEN7jeoRUEWqizHaUO6UOeur4eUs3E48yVOE7PO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fZPR7MGk; arc=fail smtp.client-ip=52.101.83.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fZPR7MGk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Daod0lNNEk9QPZoV7ayGwrBq2Bc02+Sa1APk/s3PsG/R1OPvHdNmjCsrlkboal/oR/6/jSyH8uhDv9uYCtT3YIS3PRTc09Sc/Vpp+LIk7obkJ2ZE/ZDKlBA0vjB0HRdfeEvGWTIkhZbNsEoF8fXErR37dSDcLsAfYf5LftMCZEnvGJwGWcAQ5ltFqFlGyi6hzgiVGjNxam3e27CAyxbaJrvdpEOg+84lneZ7sKv0lFcr78Qt9rHYW0WWLchGNagFmDElxaj2y4sL2QVMmkPCwVIZi7wBWwwI9Vj7prp2wOR5BgAEEmfgICQDljQXGfqW/XQE2hGPl9Wms7eq4XEU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pRKyo/u4AMLL0bPkiksfAiAzVYLNuoXI7pR3bO4bj+8=;
 b=WnVq0iCAUVrGZs3LyM0njQ083cPLScTWJtzxBGmCGc2/eXow7+TDa27MQRWeW/W1Egl3g17D/c9Bb1SdaAgZHZh2wYQyVHzL0v60qK9VW3I2CRsr93Gr2tOvruFNkEeWzJmQ/DfzAQ/yxD0jk3vvFl/8ndYCJuP1XZg3+EIWbDWWlCjABJfnk0x20e3K0LczJgCT6eHfvobup3kQJ6kOgZcRPWurHPAlzPG3Li8M95iATTrXoMVv+YFqOtzGgJD8aoccrPbSE0W1DhV2kxu4dZSwKjddugCi3ZbwAVp82R+7phjD/rY6fyLUhuU9J+bfu2R4qJFwUwG0i7LLSqZT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pRKyo/u4AMLL0bPkiksfAiAzVYLNuoXI7pR3bO4bj+8=;
 b=fZPR7MGkwcKpRT0kCRpiH9FYOY6qnXBTzf6Tejh+j6shXqcCSNtFk7/xHhabcV36VGrBuS0dBE88oJgZcUw+1b4AocLSKzirRPWtRf+YxsjSakIUdJHLA/dzlzPXgkEsTzEqHG2LSzTb8F85+cceZD2a4YZV7vp5ZA1+aCwN0isBoqGX1tg0ODzUmO7YF0ZOdW5XROVPvF7vApqbzU6/VkNA9vaKxvbdlB6xxOmj4GCpNNsh2juQxU9TL8I+N4n5nwSHkgsZ8JDZqdTVOWFSb3x/H3HHajtEkYB4vNWzo8plWZ+E8KsjeJVbvyagr8WJO9BthXcYkb4NfycRzdcfmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com (2603:10a6:102:2b4::21)
 by GV1PR04MB10079.eurprd04.prod.outlook.com (2603:10a6:150:1ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 05:51:12 +0000
Received: from PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d]) by PAXPR04MB9422.eurprd04.prod.outlook.com
 ([fe80::54e:28bf:aa85:d25d%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 05:51:12 +0000
Date: Mon, 3 Aug 2026 13:49:37 +0800
From: Xu Yang <xu.yang_2@oss.nxp.com>
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, xu.yang_2@nxp.com, Frank.Li@nxp.com, 
	kees@kernel.org, panjunzhong@linux.spacemit.com, andrzej.p@samsung.com, 
	laurent.pinchart@ideasonboard.com, balbi@ti.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v6] usb: gadget: uvc: Fix Null Pointer Dereference in
 uvcg_video_init()
Message-ID: <uatwg23po5zuagx6k2gvmgwgdcsquxlmpm7n6milpvu65qvao4@jsxasxynd4di>
References: <20260803044856.9271-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803044856.9271-1-jeffinphilip14@gmail.com>
X-ClientProxiedBy: SI3PR01CA0004.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::15) To PAXPR04MB9422.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::21)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9422:EE_|GV1PR04MB10079:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b3a56bc-6205-42f4-f719-08def1233959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|19092799006|366016|6133799003|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	fD7XfrcVMJsqw/uP6ZmC3VB3me3OOVpXaLgw8X0ohqtJYD22bj/4h8LxL9rqUZr4QXgwxUIMbwxeOssKCEoVwLYMlQBlZw4ZmhqLQs3oUdJwBaEENyQ+p2WlCXvUEMy7Z92Xky2/3IAa7FGV0W8N7nDAe4+eobAUM3ZVyrplrVjohY3XqfmGskURrFWa8pJozbPfJv1ZlK3oDVHY460p5AJa1Z1yiNiB/JFXJfE1jNM9zwaqvnu61cEKO+43M/Xs0foWl/vHioMcg3fcH9lkYddJjKtpf3b+3A9IhBI1JwOzDCxswcrnzE5vXn9OsH3DfgfZSp5DlGNMVuVv7EiqhT1RXYVUIjieNGEje2h2TW3hNH9kKY71T//cbIFr8GveH5NiQ7Hm1CRWNsHa+PmVWS81EDmuAPtxVApb+fV1dRjhpScDh9TtRgtV9YV0mH9CQZl8eiaiC3esj+UmPXLYETUZIXbbyeihQiOntmw9E3EYLxVEDFcFO9WEM/57aM3KanebzQ55d8Ka0J/DUA1BSWfEkpLQZywjCBj2WorYlBeMfGf1JiTYaR4mbC17dO3VVswVNbyBpBCawIS0VNbbzIcm60VV1PsvV+uuwRrcHWnEGNCrRVgrkfq6TeQnewWW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9422.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(19092799006)(366016)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qnGgFHL1Mz1QgXOBG97cYP/PRZH0P8W30eKVbt0yMTFGN9j3Sr2XHb0Cs1DE?=
 =?us-ascii?Q?w5VeRJxxkKLmGNs96ZeRqsHej1EMawY+ISphKDTg2rHG14egJpt3zwrjI52f?=
 =?us-ascii?Q?jGmV7qC58AMlBrV1qe473bJwmajcK9m+jUueo7nnPyrIexvbsg53wfEK6xBL?=
 =?us-ascii?Q?DUgA144WlUTLDkCaICNr3I7uW2NqyCdz4Mu6fD6hiEW9aRdlwp4J06UzYFeQ?=
 =?us-ascii?Q?jOKbRC1kEe69MChvgNjJHZTuy2emEQrfFgFyXtBvPgAUWHc3+VYfyNA/kFt/?=
 =?us-ascii?Q?JP+sNGKeP3ZW+gy7HwjY1LfsyQMRB53laWtwtNimmPCBJzG2eyX9SITRSPkE?=
 =?us-ascii?Q?JIGZVRPhuf14X7D6uXtPcu3aikZzsyYoIHa4def9vmozEP+qQ6CuR+OEH5fp?=
 =?us-ascii?Q?BlyMKBjiggngz6zmauJCJwKcI82vDRlbLkDlyDjak02MlucLhmMv9H3JCTxd?=
 =?us-ascii?Q?ZyCi/jb8M24szq4jPsDnps+H8A9VPJ2JgNq14TueGvkWsnDa4ePGAreVTP9p?=
 =?us-ascii?Q?8IhGuLrUvKZrYs9HVZZA3KQsSWaeL5N6TnsMOew3sAv5lPMteZpg+HdJJWDL?=
 =?us-ascii?Q?yu3Dh8vEKU8sTXUXXlR6ENBA4WOkpbZrC9SkYwg/3cZJ83eScPkfFL8Nz4S9?=
 =?us-ascii?Q?mI3zxtInsfJfbldfOwpeEamFrfZj5DWdc4ePGvsJE97WnMHs/isMwmc4l6qd?=
 =?us-ascii?Q?RNu5eLCuu32ryFNHrlkS6HQvPUbKM4oeoL1iBDMSyqdPOIGNE/RsNe2Lo8uK?=
 =?us-ascii?Q?xOZqOLP5ltgiBvdSqYM0z/UMGd7/q3B9sLxsjoCcYJtz/VMhscoscomrxhAx?=
 =?us-ascii?Q?b/cMDAMVsUYNPp8+JUhMHTKrpGm8OVvMekHhmFb5tP1JjXldTDUOPYPlGjCG?=
 =?us-ascii?Q?UQzcaTMOZzv5dvUPchvKT5kqjyya10CQGUjr0gvGhXLgdVdRMOkUfGF24iCJ?=
 =?us-ascii?Q?d483MCpPb+1wzYNbbKPjTLRD/XKi68dnNQL1i4pebBhFwmSGYqLDEMyaJbpm?=
 =?us-ascii?Q?jcwS7DC+WgGeJsWS4dBDmZAMjU8TfhCfbJiL+LWwjEV8Lc2aHaA5eZZ69lVT?=
 =?us-ascii?Q?tm3PYSNXeC8DFrCNDKhI/g5HGo8wk4eetV+T7mDmvNN76Hry10avNOfNnSCQ?=
 =?us-ascii?Q?2OPWjOVhqrjc2LwzQKBFizrF/RodNdKCw0a4zKvv3ma/lNOoc1AeZh8Ckdes?=
 =?us-ascii?Q?zTYp0Fmtw5W6cN0qqPmCUWywtQMql/fVwprARDm4mHTNzSyH+CvOHv9LpmUZ?=
 =?us-ascii?Q?1kLem61xSfaNEnNtGaCRTm5DYtp8rYkYLu54VkD+Q61CFRorys6v5abwUL4E?=
 =?us-ascii?Q?p9q9whnI1GE1gul/PSu1+KNB0LxZC3VjHrsXP32TsjnLKSYZr1Y+WjNgZFNe?=
 =?us-ascii?Q?5PnbF8mLJmjHJnI6KuIR8KIIR8uPZ2BgOIMTQbcfSGgjHFJLLKOysXTeYxAz?=
 =?us-ascii?Q?u2mLUUQVJvWNaX2PZvWgd2P6WI2KXjLC4qabKrA5q09tGNcLEgfCoAsp/wUn?=
 =?us-ascii?Q?hZj88+RkQut3S+j78voU/VwhTvMu5rMH0ujCoFjxrQJDriWZI0jrEcPp/wPR?=
 =?us-ascii?Q?buTYDUnAclEIv0rCjCDs4hkWbRnayhHxekxrSTs3mNOwbAvu5tgP5ciwqOm8?=
 =?us-ascii?Q?53LOBfLWbsfIudmrDlMA/u6CO+rHJRKVbFFYib5mS8cM7GLq39m2z2B+Px/T?=
 =?us-ascii?Q?woD9gWn3O8ry6QJp+79LuXKvifNQQ10KdcBDfRD9mch1u50qr8FwQv7w9iLD?=
 =?us-ascii?Q?IZAAqf+T3FV/6hNBKBqa9BVZ+33VNdT9OMV3vRObYBVdc1Z1UDkq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3a56bc-6205-42f4-f719-08def1233959
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9422.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 05:51:12.5765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJW9TMXh/nuRgdcqIHm5cx+hiSuhLfkmxw47PIK4fOJyLfIxk3iuCSQfKukqsHUwCEK+BzM1/tVeWsSIlEjK990GF1rgxJbrZpvODRSmfQeTqaqTPxHFRJQtegrgb4l9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10079

On Mon, Aug 03, 2026 at 10:18:56AM +0530, Jeffin Philip wrote:
> In uvcg_video_init(), if kthread_run_worker() fails,
> the error logged uses uvcg_err(), however, the pointer it uses:
> video->uvc is not assigned at this point, triggering a null
> pointer dereference. Fix this by directly using uvc->func which
> is assigned already.
> 
> Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
> Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts with host uvc")

No. The Fixes tag is not changed and still wrong.

