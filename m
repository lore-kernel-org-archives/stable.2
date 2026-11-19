Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795106509;
	b=w/ec9qzbPC2bqcYkZ53jYUpoKGngTL1IJlsv51uBsilA4mTh/8oph4kK38b6/LYOdfLF
	 31mkJCs90d/8X9LqrAiNINZk9rKmpOxNQlo1TLXxqY+IOp5OFkNuDCypJLDno4s5Uzs+i
	 nHQrSG8h6vggTdXBwNop/WtcWGjRKuIvSyYGiHI5m2e9lP3ibCjXPmDvdRqEXx5H3PQTe
	 wdsTsadhwa3ub2fkwvWjNhL3PnNh8anwhl/p1WlUXRMN+vHMFbbD/X76u7vJMaBPiBOJK
	 SIYKV2OciiJSLpsuEm4bipu3seqDn7a9a1PF9+l64B2t23mgNSWV8E6v13ihmlSDR+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106509;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=+hgwoC1mnHPTdL47hn44vDvOyskXgKTvzaFRmNqiUuw=;
	b=SiXPOCHPppB/U1yunHrSmKe5TG0rTen9X6qadQO44sBUIoly0/trtIcbPst6HGYEeV/x
	 DfhTdZ64E7aWQrdoxNmG2KcdxWzZw/BONlKpINA5kxq3dkU05Hs3clcT8xu1pvNeb2Grb
	 QUnQLllseG071P9rt4PEUU4RAYmF0RKm3blsEBnehsefiBhDeXzvb+nvAaPC8XDWOus+R
	 Bf01f+wOyt3/KtJXVbaOLHAoDDprTUgP9oZ1XaW/YZTAWkSMaEZ57rVK77v2d7O0V7SKr
	 bDuwdMoSpv8RNdYjNs1zHQ7KeJD6+i5sGggKt9n755agCoDaxCZGWAyRH34KMcw/5qA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="nrps/ajE";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.44
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011044.outbound.protection.outlook.com [52.101.65.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31836606A332;
	Thu, 19 Nov 2026 16:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31836606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=nrps/ajE
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loLq2bQLUPmAWRri5CEpMSvvzZrkyszYO88oZqBoHAoWT4CB0ROcuY86yvaq7t0anbO7ftdGklwcMQjpyDYTBrMQNoJ+fjpHuF6N8OyqLBtSjcnOji6IVgIaNnV0M7vaP5XX5G/NN7rqiBtRl8eB8WgknhM942yv41RdGMB0KPfhUwQ1ZQyNelnfWlQsP2czQ99RQG+8mYhpWyXX1/IZiUpp6SYl34YxjWhPGNwdEqtFAtjT8tXcfCKVLy8JT32pYam1nP31uhvV/uFP8tti50khDb64sM+FqWCd2UqukQUPtMSctjAySCwDTHduVE74wwK+cikRRfdMHmy5qqVP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+hgwoC1mnHPTdL47hn44vDvOyskXgKTvzaFRmNqiUuw=;
 b=x5hoqXqYWvVlOz0hvSmS7ANBrfxAQX+Ih9ODkcgysQ+P8fIVTcu+sPD6+axl2sWYngJscSM0EQEOLnaNvbUSqlXthZVnJ2UVFO3t1I0jaiH08HemPVBtdKFm6m2X9y2Qa+kxSan2yLFXTSNGrfR04ksdKWXRxQxn8cAzzfy/B/o4cUDufcHBeYuWj2/oOjTdTJHmFDr7ByzWabs1N7DfogMyL6FwGA/1gkvAsuiol9A8dU6iYIeVI4OXDzj87WFq91Xw/HaoTCxq26e8QhE8Qx6eVQwXfADIjuYOvvoEWK+u9AOGOAkqxTZOP3gDnbGbmxGw4BNJSKLuivPWQAY2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+hgwoC1mnHPTdL47hn44vDvOyskXgKTvzaFRmNqiUuw=;
 b=nrps/ajEXl6S0YCY2JYBHtcPpsnPMaVhi6p+GQEXWMM3XXmaqB1xBVVCkx6L/z5tkZ0O4ntptMb4u2w9NhiJBPGwWGa5gBLYotADMM1WHxUm9vxXHUkDspnar+kSwnpr+R1iJPMCgTxvwl5erDXgyt1szcGd8JDDXb9Thlj6qGfgfYV5Zq2lkQAwAPbcLIxz74s0BsEqDbKur5a0w+la7uGfAXpCZIBxrPliq3j/SZyLNcMmtWmUdwAf0lHEB1LmxQ/JComXSnkx22LgJywPngojYJfT7uzF3jwrbr5fuSb1uTCSVfOOkQ8uVtC0k9JsbuU5ioxPwhTL4oLpc0pt0w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AS1PR04MB9239.eurprd04.prod.outlook.com (2603:10a6:20b:4c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:41:40 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:41:40 +0000
Date: Thu, 19 Nov 2026 10:41:31 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Sergey Khimich <serghox@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sia Jee Heng <jee.heng.sia@intel.com>,
	Baruch Siach <baruch@tkos.co.il>,
	Mitch Barnett <mitch@accuratesound.ca>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wang YuWei <1973615295@qq.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v8 6/9] dmaengine: dw-axi-dmac: retain descriptors until
 callbacks drain
Message-ID: <av8mu_ZFxNKSgFTK@SMW015318>
References: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-0-f8e7fe60594c@gmail.com>
 <20261119-submit-dw-axi-dma-stop-pause-v1-v8-6-f8e7fe60594c@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119-submit-dw-axi-dma-stop-pause-v1-v8-6-f8e7fe60594c@gmail.com>
X-ClientProxiedBy: PH7PR17CA0028.namprd17.prod.outlook.com
 (2603:10b6:510:323::8) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AS1PR04MB9239:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e9e3260-fc62-47ed-f417-08df465bfc65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|376014|1800799024|19092799006|23010399003|10067099003|260925022911599003|11063799006|4143699003|260925021911599003|260925021311599003|261022113327099003|56012099006|261021130227099003|261022105027099003|261021135927099003|261021121427099003|261022075727099003|261102123227099003|261021123027099003|261022115727099003|261009223027099003|261026130827099003|261026140227099003|261026121527099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	LsbqNOYcI5Xxz0VkcHtt43MdBaRRIyH9SeF6QQa91mG4vkxyyFZMVma22gFfbrb9PXEl75eW+jFw5ZN1/EALKPqWPwbUVWJ+yD5XVXjSUETXhcJp0/vMzUEDDmVAx15fm9sv/Xz0nziIm236qOQyvJVlECUJNAdWmsqNZBvTdLc/y5W6vYaSO/UPyzocRb9CzFEL03j15F97QYZ8hE982qFHoFnifIgMiEHEpYsHwYF1ulzlEoQO/Yv97Ql8kcd2xqA2uUOHxrl0+KS1hN3YFgPxmmgBeUekref7DHLwVW9lUxWNNLpzpinld7pI8qY643lL+wlmuZq4ih99Rqr1aiuTqhY27lfWPWjg22/Y3hpab08ridgFIX1lz2NVgh1fEkeJtTSPNOfIHnz8sJwA8hP9rs7thLtr3a80vEV+yPTq/oXE9RqJvugDjtw7xR4t1DKavZFJ0dLiRMdQq6jAg5AzNf1Spa5vBmmOVZMnlIt81Cfvqfce+ObfIkvcssV3Ei0HRV7uLrG742QyvE+pVqAdM+PB4U1J7j2jEjVb6RTUuZ9pkWbDKMvcKtu7Gk+WTeSFluQ29B+f1eYAFsFlG2MRXp7QqK5uDAU3EOCe23oIslkhM61pePJ99ODVVhmQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(19092799006)(23010399003)(10067099003)(260925022911599003)(11063799006)(4143699003)(260925021911599003)(260925021311599003)(261022113327099003)(56012099006)(261021130227099003)(261022105027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261102123227099003)(261021123027099003)(261022115727099003)(261009223027099003)(261026130827099003)(261026140227099003)(261026121527099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3oOlZ3NEH01XX7A4yG6s+eMun0XGPSp/WYnLp0qpFY5KR3DvYefrYxyuSgeM?=
 =?us-ascii?Q?EYdjt8+D4HF8lep3lypGBYHFjkZoCD94WW0NrlMwYGLNnp7eX4h5Qpiz2/jT?=
 =?us-ascii?Q?PQf/XIdrFnQ/vS/xi8liyMRasbGCdnpWYM/hfN4P/lR7w1h+Ys96T4N4wHrJ?=
 =?us-ascii?Q?ddMvxubNCS2zcwmDOhzIQuGvtSPz7f6Fhh/7QaUMWeALkY5DxqpvjHuUvzQL?=
 =?us-ascii?Q?VhomnQpoIEz+0pQwW81/e13HzdF26Db+hL5cd55DkvtQtSezoTx/wzg0fEI5?=
 =?us-ascii?Q?5ZMofVlTCTJRBktT4B+1yelsrQzYusAFRIgnu9pBDya+bddNVYZuHJ0LzOIq?=
 =?us-ascii?Q?K84LWG1aeme9hH8aaFzyGe6PPDIagvDon5LF3/jCN9mcj7Kkyx4LOn33i/io?=
 =?us-ascii?Q?DtxJ127L9c8wZvva5QmgMAIHl5QjPUtlxSicMMMU3rq4OkTrTMP6iD4nEDC+?=
 =?us-ascii?Q?kFcBYAAxNIPWjQN6Ze4nri/uMs4nDYqMDtzS5d56R37qBGS/ruTyp3vvbfq6?=
 =?us-ascii?Q?5GyG48hApR0rpDGMCL6IY4vizsnZ9fPCXNDfrs2osdh1bTpHAbu/xo6sSee9?=
 =?us-ascii?Q?ARlPWADcQ7CQ4N05hSYvh1vO1edzZMLCQghSk/r6YD5Ebbp5WATIYQJRQ7HN?=
 =?us-ascii?Q?mn9Oiw1zY9omtN9fVGo0s/HdkaefJ1iZy2/kbgUv0HRVVXvlhdPUKU/AfCDP?=
 =?us-ascii?Q?JF2jALUIFX4UES4JLOJ1Xw5CM4/NiGVMyLmXHBdo18v8pvld8iwmun6bKBqI?=
 =?us-ascii?Q?7svFXEH8T75yRO9DenlYitmiRSw7n/yGpCCc2aWclPSUTSgDitS7UAqL9GFV?=
 =?us-ascii?Q?JuebVE1r+2IgCiCd9HWalq2jt9JQTu+Hx3XKKnzFogZlpqOLvL+sgwL04Nv6?=
 =?us-ascii?Q?WR0bPuDoee7jNloWVYgsvBqV6HzTEjHXPCYKARZKTo3c1a5W3Jw+CieoSlGH?=
 =?us-ascii?Q?gIA00Px9e0m2AvnumG4a/3PEF4dX7UEfKHDaTqc+ITKSVWDme7V9JyCbUcgz?=
 =?us-ascii?Q?mc46KJ0FPr+MnqBFSfz7jfnr/dyiKH3KdOJ4+7fjerJB5jIG8amS9zNUQ/lU?=
 =?us-ascii?Q?Seh9szXSXtiX/uYIRfCEEe2LjsqvLrK+Ddo6TO79jDTdI66n+PLmtHtHJMur?=
 =?us-ascii?Q?zo2vAH1Dj2boARQyPzY9gbVWwtbLDWYo1nFJMPd34O5XrLoLyYimHXjGCp4M?=
 =?us-ascii?Q?9RKBx/RWJ90D3cCtvKKErtTHkI7iJEbJ5hGMkMRVcEj2ypOhFhchi4iyfMjC?=
 =?us-ascii?Q?cjKFFWW9RHWeXnHH9OKuHl5JLviuo9oAmVb/vE5XZMaqlaRWAu7QqR37mnjj?=
 =?us-ascii?Q?6/WuBK8wzO5LXnMmSgBtH9HamOXCanzzm9i4UCEcGdZvB7+tsrClEukN1Amd?=
 =?us-ascii?Q?bmYHc3KTejxo6Z6vyrX+dfngR1eORs/VK6bcGGy6ga80jH7nWYGwvoBp/j+7?=
 =?us-ascii?Q?8ndp1z1Da1y/ZhwxNCVSv+AlnjL1BgHx+GXU5fUb0k7nJBcgac9DfniHch5+?=
 =?us-ascii?Q?znSfoPWJEqpT56REkLjuT7Ga5vw0K+ugQY4uzpji/GQndoN2egEgmGTD49MH?=
 =?us-ascii?Q?hwpFXGEjIKBVzVx+3NtfGX9Fm5NS7CDEJpL0UoDQ2NHH970lN6Vvxd8VdLUe?=
 =?us-ascii?Q?FT9XHI+wqagMREJ5nkRluPS45Bc5Wqg2TbdcLTCVzscC3aD32E3TWmkALUie?=
 =?us-ascii?Q?LZy1l877LLwnWVqSBWJ8cXSXgV1YTtTnsgQH1Jlfr7HUSdNNULZIph9MF/22?=
 =?us-ascii?Q?SUxYqqo/epXyFOlUQaTXwHe6geETsxl5jVGcK14tr5v73tNn0JK1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e9e3260-fc62-47ed-f417-08df465bfc65
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:41:40.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f+NO1TLFvqs1Ir63ZjQALWWwGIILzChLNAAah4EnoBIfYCCGfev/KSD1TIXU1ryvp4I7Qyaz1pGi730tS2EHhhjkzDns3rYQ0r/BR6amJ6DWumsw+sDarPSx8oDznqeQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9239

On Thu, Nov 19, 2026 at 09:01:01AM -0700, James Hilliard wrote:
> Termination frees every descriptor while a pending period callback can
> still refer to one through vc->cyclic. An executing callback has already
> cleared that pointer, but still receives a pointer to the descriptor's
> tx_result and can use it after termination frees the descriptor.
>
> An error interrupt can also move the cyclic descriptor to desc_completed
> before termination. Looking only at the head of desc_issued therefore
> does not cover every pending cyclic callback.
>
> Use vchan_terminate_all() after stopping the channel to clear the pending
> alias and move the collected descriptors to desc_terminated. The existing
> synchronize callback drains the tasklet before reclaiming that list.
> Descriptors already detached onto the tasklet's private completed list
> remain owned by the tasklet. Repeated termination preserves the retired
> list, including when called from a completion callback.
>
> Fixes: 1deb96c0fa58 ("dmaegine: dw-axi-dmac: Support device_prep_dma_cyclic()")
> Reported-by: Wang YuWei <1973615295@qq.com>
> Link: https://lore.kernel.org/r/tencent_C00D995A9F70206DFD1330DCB1222EEBCB07@qq.com/
> Reported-by: Mitch Barnett <mitch@accuratesound.ca>
> Cc: Wang YuWei <1973615295@qq.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 99b648d4ca76..2547f9596ae6 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -1202,7 +1202,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  {
>  	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
>  	int ret;
> -	LIST_HEAD(head);
>
>  	scoped_guard(spinlock_irqsave, &chan->vc.lock) {
>  		bool enabled;
> @@ -1219,7 +1218,7 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  		if (chan->direction == DMA_MEM_TO_DEV)
>  			dw_axi_dma_set_byte_halfword(chan, false);
>
> -		vchan_get_all_descriptors(&chan->vc, &head);
> +		vchan_terminate_all(&chan->vc);

I have not found this function, Any dependence I missed?

And keep allocate_queue when terminate,

https://lore.kernel.org/dmaengine/20261104-dma40-fixes-v1-1-48c5180f5210@kernel.org/

Look like we new APIs to distingiush terminate_all() and free channel.

when free channel, need clean alloc queue, but termiate_all() should be
keep alloc queue.

terminate should means terminate all DMA engine own's queue, before
submit, desc should be own by consumer.

Frank

>
>  		axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
>  		chan->desc = NULL;
> @@ -1234,8 +1233,6 @@ static int dma_chan_terminate_all(struct dma_chan *dchan)
>  		return ret;
>  	}
>
> -	vchan_dma_desc_free_list(&chan->vc, &head);
> -
>  	dev_vdbg(dmaengine_chan_dev(dchan), "terminated: %s\n", axi_chan_name(chan));
>
>  	return 0;
>
> --
> 2.53.0
>
