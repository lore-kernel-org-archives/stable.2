Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795197800;
	b=ZoQ4mdGL67mShA1gJmJTb8/FZh2JC3Asc+GwMoIFzgSPeP3bBJ7g7CaCJ2F8p2kzINpz
	 NQl/E3tFtc4ncTcBL27d6neyeTOuhe8M26z202jW95S1HObHUAfFnCaz/04Lz8mmiQtiG
	 +KQBFM8xX5Q0BlnXpKm1z05ZCPM/QFDSLpXdiealoNyYrywh0+lzr/v5m7N0AVhbhYcO3
	 1Ao5hdc6koClnS6UYMrZBohGe8GP/Om1tVJ7A+coopbBmu0FfWKKQx13I8zWmk6gW49Oj
	 Dg7qEphShk0WIq+C8hsLftcgumLDY6trYuF9yzBBNr0qUV6amhdtu/wmd/a4iXUnUEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197800;
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
	bh=ha1goxV1uznv7FYwU3jGyeseBGJWBh1KQjmGUUraPrg=;
	b=iABb9eHpvTY+tHJqlZWo48Y/VA9i7H4CBNeHxPIbjfgboC3fnoORhjIxLZBthJ+BeOvo
	 Ad6IvgpCiFpW2F1GZPd8OG74SN6LNQQb0lFpyiNfl5pFZsecVjKOnh6AWVzpyEV0iq4kI
	 2l8zDR35PpUwJncMRw251a2DoM4bGDW1R+48O0dhJEWzclAHqi26XcaRRRsfs+x5sMuqh
	 otD0/nrJWWk/zRJcnMONZDF+gVzxNHvxoafejh/ZpNxXNfECrty8pIxRZ1fecoQ5rPpBB
	 3Ubg8AgMnnmFRCAGTnidDWsD+LDsdP/WnasZko9eayaVGhcMo51MVnLixe+m/ZL3/sQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AwVRPTfw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.1
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011001.outbound.protection.outlook.com [40.107.130.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256C160A2630;
	Fri, 20 Nov 2026 18:03:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 256C160A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AwVRPTfw
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2tvPmS3BxhoAsjFrYFwAO+CIwK3GIPNlhq1nUyLbkeQveHil+gCd2ZUvw2jz82yF9DW2fbtwth0H2dLacFUuYrKRmtyAvkCWbb2gVFE9ihhpnzXYJisXVRP86kB84kPZf2c3srHs5G4Su/pGBQ/Lilv1yrEhP9pjWp5FNQrWoiDlAfsgcDntabwaCygM+zMzURZ8rrNg7fakoCLcEnn2Z1u3KwMHFrrcOk5UhSiNVteLVycM+/xkfywa4zPsCnvzuviDy8wP2v/5u3MObVLE2wB2sH67Lrc/gm5uX/pLefs6lhdmWzsZ/+ZGwLX2+vzYXWN8cy7S6AJJb4qd8pK4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha1goxV1uznv7FYwU3jGyeseBGJWBh1KQjmGUUraPrg=;
 b=cK8RGv7dnbyIXgZ/Lo4176epTmTvpYPvKA1qwdmefjVVdm+DtrnCi2gy0n2NTmJMhM/jp1jAg5EnL6UAV7tbFo8D5ytFF/372hAOIJbY/73z0Fw3pl0dXTSpQIo9zIb4iXaJ8dMMMdrWE4X/NDgWoG3BtL+fALafoX5j3731r8vyVM8Le4QBOBVbeP7ep8FRAqDunqxpHc6Pufif+VvWlvL1sfUJFfI4/o+zZEBGzMhlDQQGuNiJ0sIJzGLFn7gUAQr6eKjE5KpaTQcNHxLsPLCu+mC+m1DHYcsOcNg0xq6Y3YvdlBbRW8SpX6/oILlaxKlYovEshn15MyrwZReoqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ha1goxV1uznv7FYwU3jGyeseBGJWBh1KQjmGUUraPrg=;
 b=AwVRPTfw5iSjujgKZDdtDp/a/xLGvNXKDqK1kU9uMqX+ziHpyTLGt6AqUwxmG8FrLXUvJ7xySPYTAQST4Aakw/qh5V/DIOjjgW8lASP7r7sRJJOB+mFzfg+nNtd6AqIn5Mnr9Z2XC82YNNvdaltDj0YO99O94u9O861Frwrvbl5PCrzdAsRPqAM6oELnaU8mObz61dvMLmLC/DZ0/0j9uNUx9glA5tAuPdNl6dY/EfFiAz/tV/hVewdqww4Pc7/z5UIuKT+/NXBag/LNY86rMqwOMwFxnjv8OU1TElEcxixMT3rBUZgintV/MHc/lEBzhQJII+xxtoVCo255xOdqPg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR2PR04MB834250.eurprd04.prod.outlook.com (2603:10a6:2c8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 18:03:07 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 18:03:07 +0000
Date: Fri, 20 Nov 2026 12:02:57 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 3/4] dmaengine: stm32-dma3: validate LLI pool allocations
 and fix cleanup
Message-ID: <awCLUSCKqsBDF5g3@SMW015318>
References: <20261120-dma3-fixes-v1-0-f29c1f437399@foss.st.com>
 <20261120-dma3-fixes-v1-3-f29c1f437399@foss.st.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261120-dma3-fixes-v1-3-f29c1f437399@foss.st.com>
X-ClientProxiedBy: PH8P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:510:2db::32) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR2PR04MB834250:EE_
X-MS-Office365-Filtering-Correlation-Id: 40f0cc9a-0a5a-47be-7b88-08df473087cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|23010399003|7416014|376014|366016|18002099003|22082099003|261009223027099003|6133799003|56012099006|11063799006|10067099003|4143699003|261102124527099003|261102123227099003|261026121527099003|261022075727099003|261026140227099003|261022105027099003|261028144727099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	1jXf84XSfQNRoC1DbcSdaltwe3ePAKv2RcwfSyL+nLExlGjJjkYvo22fmcSJ3Nem1q96jGelQ1iczeawWWHX3VOLZZXre5leMX4JjVJSPBJYMAMr+o1BcyM7DM0yF6JKZiHnGC4jmgE+LoxvZCb6PJ610VPgxsFraQUVu72f+0b7fAhfqXz2TO5lmOmfDUdkFmIBgV5Uapocfns0mNO+VBFd+BoPt28rCedQAwvLMTsSsg3oxgdWbkYoppO7IGJ5vln3+vV/74S6T+pjzRHW0v7/6B/TZepX+SLefBV+m0GAOM52jOHT+RDiePj+rDbxbTiiDZzTNslbGhg8EwBMQhK7uITGGadEnla6qnE1DHvzcnRW+pHyxnXvqlMCKoyWcfSWwH5wVsSsZ3chr9ZsreaTk1RhNvzOmBZcOArusSf9R9xNBpcCSG/A8WN89c+wxW5jBTWmsVi8ME9Y4KFgVhVhQ0e+YQSpL2nmt+3/8zn1H/1xxjMEX7Bc2M9v24+Adv8qQzHbitYMP4abDortVAqnO/LIiNUhp0Mem7PZkcUHlIq8op+XDPd1rsSaAM800z9ekKLaqqWkARtSycl+2oBjQFfKzBRG3l+FUxfvgl6PS1epRpc6NYL+g59j2jTt6Wkv2J0vjLOAw8MPSiZjCh+N3c6MnuWmLHGU/vlKdzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(261009223027099003)(6133799003)(56012099006)(11063799006)(10067099003)(4143699003)(261102124527099003)(261102123227099003)(261026121527099003)(261022075727099003)(261026140227099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nu0x8FYE4uO8Ekvk4fvK9wgzCFtaIEfpElSKoZQ+o72exA4TZ5VAvEcjUmCH?=
 =?us-ascii?Q?ULmaSylYbI+py77WAf8xIO0YzzEPX9vES8xS77+zL6klWi9Ak8Jit/159E6b?=
 =?us-ascii?Q?ahqENakPRHmzOeOqnuwbGRQLIoAf7IQjAHQgh+IFQLrQQXzA+Xz7wtvDO3Wy?=
 =?us-ascii?Q?sqlRfq6OD+yoChjrCEHBB0ZWgYqAAgBuvlJ30vlEGA8otwtRHXvdxOJgQ/zz?=
 =?us-ascii?Q?0TRw7br8hcZ5P1DnefFRCHYFXruhwgXzo1xUVkKUuUiNXpScKPLPaoy6RCV+?=
 =?us-ascii?Q?GnSb74MSTx9XBqZNtdxemobk9JL/ShcvYMD/tMd9M/CuDsN2A+VKqZi00DjA?=
 =?us-ascii?Q?OcG+RF9IXgKlWX3YG7iOnFJZknjr3404FLKjYSaOf8Frf3oiVoBLnammR7Y8?=
 =?us-ascii?Q?VI5Xb/IK/YL/l1UinRE/zYHKQpSzhWuN2qML/TTnNvQ5fiQzBry1AwvjxtlA?=
 =?us-ascii?Q?faXi1lxUwmqgqMC85nzCsYHCqTBBfEjwbcAZw48E5Eq9cZgft/ZYZDq1gfaF?=
 =?us-ascii?Q?PTG2ND8gIgtOP2AcxmlYrCgL9q9pR5hhUPqWo4AIksEgT9pNVNYMlRinaBIR?=
 =?us-ascii?Q?QxtQksZZmYTLY1UXdAGcF/+ncNjwwCv0TUwNnHwxQh6eYhDoHoIufuNow5S+?=
 =?us-ascii?Q?wZqKQF/6rWcIh1+azRspB1J4SKpU1xiILzoD0mmm9TD2SjP4vXVrO7CChsN8?=
 =?us-ascii?Q?9963X9mj4gNF41rnulJHEL2R/7lqJaN6L4NcHcuBXdFUQo/iF/l8XBd9YITs?=
 =?us-ascii?Q?jsFUgapLIkK0k1KDOvCkbaoCtjkt9tbde2OGEhgQI+y/sSN9ay6saAWKP/hd?=
 =?us-ascii?Q?ui2sIpH+zXkO4EfFiMl1xK+T5YC/JOygg+J0i7LdgBEfboSM1S/ouXYrVsJG?=
 =?us-ascii?Q?ask0cjG/8STfZ7FBMBsRU1lw0KjVZJ3ojSgxi3aohhFyEhZadP6Dyhe20+V+?=
 =?us-ascii?Q?wS0bRQgn2y6k4TNO9O14GhDa2QkkjXo/qxYJlMratYtZaa53QNhIfYRvIWrk?=
 =?us-ascii?Q?J7uJKdLz+ry52mjnclAcQVbkVu0WfvG1zMt9Dp09DFEVWEWYS1OPfKrcEMtg?=
 =?us-ascii?Q?Q20IDQuWNxc/QBd1UsH5ix82I7IEeLZhGXgGjd790RDYW8uxChGTFj0Tuc6Z?=
 =?us-ascii?Q?v0vTa6Mv/2/fKAoSJLDvdj98RkqYTNaMkwsx7q9tafj2BzxIMBhnY0cXYJs1?=
 =?us-ascii?Q?MC8w5dMQDNsAPsNmO9uQhsOLA0BFbjGkWA++N/S2av3Kcz8ue7CzZUghU9fG?=
 =?us-ascii?Q?VYn+dDyJ+Brc42qppWXIzA4yAhHFjsWfL3Hg2EiDCKd7dny8a8hSUcO7QENO?=
 =?us-ascii?Q?YG/AQ2tMdkwMSH7e176Qbxo6Cjd96hmosPuhUlOMDstnVnT7GaAJDP8hHt4K?=
 =?us-ascii?Q?2mdgpoGDctY7LvxjPSE1bBuLWD4aCEBrCNnRytS7WRjWeTWxmjqp4CeJkWDn?=
 =?us-ascii?Q?MrD6LdjVdX6Gk8AFjw0un9qizLWzhnpbZdL2xQHNqEAyyxi8kPJcXiUcV4Bz?=
 =?us-ascii?Q?cBCgFGC8bmrQHMNPdr6yAnRnDTM/eWSo9NcAC402XtKww9frfP7vnvChS2c9?=
 =?us-ascii?Q?FJi7fFmQ1ZTsbpzL2L5MKawjyaFlVshYj4U/dusraro+5RNBSJ/l+VwotEjV?=
 =?us-ascii?Q?ciw327ynh3dHlZYq7b1umU5BHBE/VfRvMQI5LExCiM5wHg+6YrJA5xoeujZu?=
 =?us-ascii?Q?k+47Hg7rgJ5jXP1T5v/5iB5bi3/Py5bysmPpKuwtFyGpz5YSmJgNVH9tzEJq?=
 =?us-ascii?Q?HowoUnSsuPB189pnKzmeXMbP7MMhbhydy0uyA/eh1jNqCaI+uW9c?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f0cc9a-0a5a-47be-7b88-08df473087cf
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 18:03:07.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eQGsJ2fbR+cY+oOrAmFUyMoYqRpvForlmA8kjxHAEJcdpDIrkM7yESF/KtEhRWNqdOoVV7eCs5UP1vcRug2icRyEcpCvC6ic0PUtirM7mzGDlTwa3P44AKueaLvTUvXe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR04MB834250

On Fri, Nov 20, 2026 at 10:18:03AM +0100, Amelie Delaunay wrote:
> All descriptors in a linked list must share the same 64 KiB address
> window because CLBAR provides the common upper address bits. The DMA pool
> boundary only constrains individual allocations, not the whole list, so
> descriptors in a single list may be allocated from different pool pages in
> different windows.

/**
 * dmam_pool_create - Managed dma_pool_create()
 * @name: name of pool, for diagnostics
 * @dev: device that will be doing the DMA
 * @size: size of the blocks in this pool.
 * @align: alignment requirement for blocks; must be a power of two
 * @allocation: returned blocks won't cross this boundary (or zero)

suppose you can set allocation to 64K to avoid cross 64K boundary.

 *
 * Managed dma_pool_create().  DMA pool created with this function is
 * automatically destroyed on driver detach.
 *
 * Return: a managed dma allocation pool with the requested
 * characteristics, or %NULL if one can't be created.
 */
struct dma_pool *dmam_pool_create(const char *name, struct device *dev,
				  size_t size, size_t align, size_t allocation)


Frank

>
> Check each descriptor's base address and reject lists that span multiple
> windows, instead of letting the hardware fetch descriptors from wrong
> addresses. Track the last allocated entry so that the error path frees
> exactly the descriptors that were allocated, including the one that
> failed the window check.
>
> While at it, simplify the ccr initialisation, which is functionnaly
> equivalent to the previous code.
>
> Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> ---
>  drivers/dma/stm32/stm32-dma3.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> index a056f73fbe02..7c509a69f5e5 100644
> --- a/drivers/dma/stm32/stm32-dma3.c
> +++ b/drivers/dma/stm32/stm32-dma3.c
> @@ -397,7 +397,8 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
>  static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_chan *chan, u32 count)
>  {
>  	struct stm32_dma3_swdesc *swdesc;
> -	int i;
> +	int i, last_alloc_idx = -1;
> +	dma_addr_t base_addr = 0;
>
>  	/*
>  	 * If the memory to be allocated for the number of hwdesc (6 u32 members but 32-bytes
> @@ -419,18 +420,38 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
>  							&swdesc->lli[i].hwdesc_addr);
>  		if (!swdesc->lli[i].hwdesc)
>  			goto err_pool_free;
> +
> +		last_alloc_idx = i;
> +
> +		if (i == 0) {
> +			base_addr = swdesc->lli[0].hwdesc_addr & CLBAR_LBA;
> +			continue;
> +		}
> +
> +		/*
> +		 * dma_pool boundary=SZ_64K only guarantees that one allocation does not span a 64KB
> +		 * boundary. It does not guarantee that all allocations of a given linked-list land
> +		 * in the same 64KB address window required by CLBAR/CLLR addressing.
> +		 */
> +		if (base_addr != (swdesc->lli[i].hwdesc_addr & CLBAR_LBA)) {
> +			dev_err(vchan_chan_dev(&chan->vchan), "LLI crosses a 64KB window (%pad)\n",
> +				&swdesc->lli[i].hwdesc_addr);
> +			goto err_pool_free;
> +		}
>  	}
> -	swdesc->ccr = 0;
>
>  	/* Set LL allocated port */
> -	swdesc->ccr &= ~CCR_LAP;
> +	swdesc->ccr = FIELD_PREP(CCR_LAP, 0);
>
>  	return swdesc;
>
>  err_pool_free:
>  	dev_err(vchan_chan_dev(&chan->vchan), "Failed to alloc descriptors\n");
> -	while (--i >= 0)
> -		dma_pool_free(chan->lli_pool, swdesc->lli[i].hwdesc, swdesc->lli[i].hwdesc_addr);
> +	while (last_alloc_idx >= 0) {
> +		dma_pool_free(chan->lli_pool, swdesc->lli[last_alloc_idx].hwdesc,
> +			      swdesc->lli[last_alloc_idx].hwdesc_addr);
> +		last_alloc_idx--;
> +	}
>  	kfree(swdesc);
>
>  	return NULL;
>
> --
> 2.43.0
>
