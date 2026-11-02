Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.37
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793653818;
	b=eBHdnt2Y7EC4myZUTsHiDmW8+gfhFWZSc/+87xtyoTe1Php/yfLxO95PLMp41GjnWA8X
	 LQMc3Pv3ZzGEjJLehLqkERnxsr1f+Bg2OM7UYVoA3pz5ra3gg8XAmjGy3pfrUGFjHZi1F
	 dGBINRwjRRRFleLMMQPhnO4Er2plC36ZzfcBrqCVKMpIGvG5lmla7aUU9TEFRppSj2QpP
	 +jo7vTcqw5fcil2i8Yzga6+VHcn7j03iINTLwUhsshDg2c54ykSnOseAj982aM1JS7Orv
	 A8Gt4xkLycWeQc9JEHNuzGUMV/S0cqW7ZKeXYxz8lchx0g6RkQ1qkJm3VF0ALN2RZOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793653818;
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
	bh=1dUjQmf+wzicArY3fDxNEE6AbNtWOtE1s/XhpTk2yuA=;
	b=sATgQ89eHfOr94cDmNEI9Qhj0QdXj7V6CGrO426aUDnona+n4OgEPErh3YW/hMhDEGlv
	 emDjAdzvPSmbw7NxaGw+cWoF5+zW0FxrGnVdlaA1v/ZsJuN7p0S7Do7g/7beUGX4KODAM
	 xztlJ3ldnYpNjtu2i7Hr2Vyh/5pqYxui/4JyZoIN1LDm0BHr/srnLbmWqb/D73qxDFeo3
	 NrVcyDbq99IbpJL+uN+Zj0HXhPj3lg+Xq6LPcCXkzNTBljcBO2dra0BMP0MPF4xenjwAH
	 9BXjpuPW/7RMrqXjQf50XHIJO9e53MT+7intf7668HacoJv6t2/VdqRfgEHuzJCcJhQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=i31Rd035;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.37
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011037.outbound.protection.outlook.com [52.101.70.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30E5606A333;
	Mon,  2 Nov 2026 21:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E30E5606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=i31Rd035
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ESJkDqvFXNpPmfmzro7Xq9LMfZrQN9fxcMhTHEo8quDsCT1lBaS5IhtfcVA45Hl34wDTWyovJpiWYf8a+lAt6hBa23eTQW7WSNSa/gcbuNjXABg8PpQrv5SQJBTiutPl3mJdlADKJUXfEQKLqcJn9OIo6FIkErfVHI8XmgSNEAO2e5gv5+gBDNK4JayoTcetvvSFfAxHn4Xb+DQxMcLCbJguO03a5HFCwDuVltIjIJolTbTRVyCTdHNh6/2PRTIhIaS4TuPugajxgu4wuzSIaqkEin1wRRDLPlXIRW38vrskJy7q8aYwdSpfbJ8wWGFwIKJq5VZV9x9fVtucryjs/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dUjQmf+wzicArY3fDxNEE6AbNtWOtE1s/XhpTk2yuA=;
 b=xo2jaEkodNwPM9RyZCkn01c+mJcR0vBEyQyHe4e08RsgB96JNr75g57kj6ZWyL/EjRsp2aXCLfVxmmULXM6nFJOXk2aTVkRFUGKx6uEGjdovZSECDhR4LlmcJQwwOOlxhKBQGkl1bPENabcFywWH9MbHQg5oBtldQZD0klTYgXie28HcVSE0BEg75c95G0AVyg/dHdnVbZPtmrScEND6Wf8RqbI3M0O43QSOxJtyC60NvEI/VKTuORJJB7yntdWMhj2bkigJLpGe4vCmW4c7ahO+5ATHNsU+JvauRnM7TIuHJyemdUNPfesZOyH4muoWfWlgexmGv9XvPEmqkolkjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dUjQmf+wzicArY3fDxNEE6AbNtWOtE1s/XhpTk2yuA=;
 b=i31Rd035cNvRQPxJZX2/dzqi51t0rlqWnqAuveTQOASNveIRxgLhRTolvySNE/hjHHRSbFO63OQ6B8B2yoMNFX7Dvr+JHTAd7sFFA1M9mTD3aWmWy0ihoRPkazE7AxTi1wLUbu5LrIRqflUtTT7JYRMToe1oHVMmKcrs3rTySaVCVVEQ7dht/2oTl/Z6SVE3pinIuGK9PD0A8KFRi97k/W7EbmxEP6kikAZk9htbFm5I3/xllIMuRVMeSSmevlKWHWL8nHN9dBI4ervCoRmdxAKeS1IHbXvSz6Pm1T/wBAV6Kl9j6MNxMKfTysZKOMjXQxZfhuBw7vPUFIngbMMJUg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:10:13 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 21:10:13 +0000
Date: Mon, 2 Nov 2026 15:10:03 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	dmaengine@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, stable@vger.kernel.org
Subject: Re: [PATCH v5 05/10] dmaengine: dw: calculate residue in the status
 getter
Message-ID: <auj8K5jwbBOZWIOu@SMW015318>
References: <20261102-submit-dw-dma-synchronize-v1-v5-0-d3207758fbf9@gmail.com>
 <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102-submit-dw-dma-synchronize-v1-v5-5-d3207758fbf9@gmail.com>
X-ClientProxiedBy: PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::7) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ed04b8-3064-4aa3-40ed-08df3925af9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|366016|1800799024|23010399003|10067099003|18002099003|22082099003|261102123227099003|56012099006|4143699003|11063799006|261021123027099003|261022075727099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	3121c0K7bni3EbrMvaonVfW6AQBtWC14nRk9wPXtBjJz8a5mMhhiPC/+pEAwWbPaWXMEcGNy9xWsLKxlje71U5HpNA84m9kUvt+v8FlaCSeqo8LCOvqXttAFwss9Fy5+rUn+2fGu++HqMy08AyluTxmnJufHTck6/9dXC3E0eyyAlIIaxlkTmEvWMuEqVM8qZUHwaDZtrGtXrxX0U4dZ5ah28LibwD0HFXTuUGUWz/rxmGVAPRpJ/hflb8UePU3dXpKDTkI48YAYPrq2GH5GQ5KPH7CUfoOVK5DgKlhjcpBGFfwlr8p4n8ywZlj9vQEGcrels6Yb5sczcuPIOj4b50tGCHIWmQEyhSF+gNq4KCRTD1tFqlgIuSn/RCfH300Q8j2K1yqu3+r2/od9KffuIebM+9x8FC1fagCcdN8E7xJlEAaRXVoP0F+Jn82jkZecVRMpK4YAViPCaLlpOQIVmtGOhyZt/no3qX0uTRgBm94oJPzkwEEhN2y55KJdKQ20XKG03FvrFy94/CiwusQN6m8v+L/Zodgxn9fXcwQdyvOeoa8Wjs3ttFrzdvJreRI2JU/qb/izcuGfBVj3hkB75nqYhctTV+HF8BjIsVcQiUxYOG4gZCZoG+/shdC7rWxMpJXmUFNstQgP7usHhMre0KOJFiOVtdm9YAsz4o9msKI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(22082099003)(261102123227099003)(56012099006)(4143699003)(11063799006)(261021123027099003)(261022075727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NSqAoydYk2/UXaQ7KiEEAtsJha6yUbAzblC1MKN99xJAgBpLv766Rz6v/jN5?=
 =?us-ascii?Q?LFnZV3wmyXS/G7s1ezDBhz+NpjTl7+wmSblvtDk06jE75APgk5WK480Xf6vX?=
 =?us-ascii?Q?USbI8OxePicDAZqy+uEZnkinr6b5QD4vzQeTVb1q/uzD7EbNpmeUK9Z5dDrO?=
 =?us-ascii?Q?HttLowUmkRMVQdfpCEp5QqCwKALvqM8h+52Fo0hcPQs36ixzaCeNA/Y6UobJ?=
 =?us-ascii?Q?qZ2U+AQvLsEszH4J8wY+inSMGJmgNdDdeLspNV8Xlg/KEuHEm+cBpOFafCu0?=
 =?us-ascii?Q?Q+iePNi5TMiEEHDY90YpDiKEG1+o/BHk76Dc1jVqtg+l4c7+vudq+yta5euQ?=
 =?us-ascii?Q?T4QbJRo6dZpuDRw05OPH1ja7eRJuQKHr9cvji+d1QdGyxvPbOfJR8Cs0iSHk?=
 =?us-ascii?Q?gXIKCV9Ji+NDEjRPu3qrXo3W2+mscGtF0+438IYxUQ80bDeW7qyRUotuZHJ6?=
 =?us-ascii?Q?XanoMJfSCavU6FgCsf0Z4sg9VrQz+7ONweIWoUoKPs8l4x/KutZuMvNwZJ5G?=
 =?us-ascii?Q?BwFbjlRJd9kEtf2yeKa+fQMmrFhq2CLsP4TT0E4bkW9PaYzzcENB+x/BMbJv?=
 =?us-ascii?Q?z9/unfNtXm90olh9NgZRM61uhKU8Xi81++Ye0GL43QUdwyQkvC+6YzPoeCrS?=
 =?us-ascii?Q?Zz2Iu/XSb2in7A/xEROxfDVL2ToZ9K/OfPWrLqQgCOi2B7hRKerl2coU028b?=
 =?us-ascii?Q?ncVmHRbauhHMz88D2N8cdZZuXME+EO9mSN9OGBHAymJBSwWSRGhiYSRou6Tz?=
 =?us-ascii?Q?V1ui5WLBT/0M9hu4eQnP016YRtMkTG9z0EOBgidR2dxuF5E7pBblxtMisCDE?=
 =?us-ascii?Q?6rrqKiOLHKTO9Q7gxigo/a/OZn38NaEQg0RTA8vGPGV88j9YcldV6Sv0xxk0?=
 =?us-ascii?Q?lF9OGMtDzgOBic50Q3NWpa5ivW8a0LJUuJzLoOFV7UztQeUiVoy1Rr8nrAzv?=
 =?us-ascii?Q?LeEkrupuwWHZgNpUKvSb2gTXQncFy11y5Gl5NJbPzo+ytoovPsXeotAzGe5R?=
 =?us-ascii?Q?BntZ5h3mbEZyA/W6F5HmP87pqstaRMiGVtMcHiATl3cYmU3bvYjs9cu2mFAE?=
 =?us-ascii?Q?7Ptuq+KW7r/9XJgtTQ17lU6uS7zXhDPB3WAKz9g3qFxUyjpFLrtbMUXSi9/u?=
 =?us-ascii?Q?rtwvBNfPrzc7fY9DoEn/ai3Hevpt2YOkETFvkdI7Toc9s+hCX/VnGvG+39jS?=
 =?us-ascii?Q?+H3xx95tRed8IG2+ISQNu3tdc62b7LDDt2BoyUSWVDqY1s4eQ3AMWZfepN8m?=
 =?us-ascii?Q?R2lbgFGji0t4u/gXHPenO2R05RnjdZ9CtsUZSo/OS9K2ILSYIM2O/KVxDbea?=
 =?us-ascii?Q?oCWYoAl5b3xvCb96u9qNtqZBN7qsLVnPHlXUK9m+EkSreiLsfLEEXHAWUOWB?=
 =?us-ascii?Q?IVBAJinf6XzBJefagMMUwjOJgS76D/ES6lNH/25NBo/xgzXfqZAPj2yRQIK1?=
 =?us-ascii?Q?owOFYtKSoPWA/nGx4ys7wB1Uh4R5sCXPehVF6WC6oNdocdQmkU02RyCZMTmf?=
 =?us-ascii?Q?QnGLTiRpAFNTWYIqqX+TlL5bgdnmBZWBvykWXqq8DujPYsSxAHypweujMvKZ?=
 =?us-ascii?Q?lWOOTBuTT/EUUM3pSdJC2FsRFozeZRc5ql2x17jJE5pgM6FHVIvZV0X/EhPu?=
 =?us-ascii?Q?SYTp7uPH9so1BcsKTPCOfeoO9hcbtROOt5xsuHAsEML1exB4c2c14ERym8EU?=
 =?us-ascii?Q?RETPbdoAynBKlSJ3qhakDZXtx1HTC+08haDxDdWB9GkXOfyxmTX6KQVtswa5?=
 =?us-ascii?Q?s0lcRZLdsCzWlzNmt66w9W3ZbZzae8vp2aqAwAJclA3uQjIg80uj?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ed04b8-3064-4aa3-40ed-08df3925af9e
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:10:13.4876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXRoV94LTZnoAy9WZMClftj8e6rABNiqKMLC22UfMBhkVx1Adz+If0ishvrR+r3sGpBX0mFg8NBhd2BtUVEy677QqsoScGa4K9K5y7iSLqPR65Da7Qif7M7j2p9avfTL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8604

On Mon, Nov 02, 2026 at 12:34:17PM -0700, James Hilliard wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
>
> Calculate hardware-LLP residue while looking up the requested cookie under
> the channel lock. The scanner and the status getter currently take that
> lock separately, allowing a descriptor to start between the scanner's
> residue update and the status query.
>
> Have dwc_get_hard_llp_desc_residue() return a local residue value from a
> fresh LLP snapshot. Keep the persistent residue field for software-LLP
> block accounting, subtracting the current block's progress when reporting
> status. The descriptor scanner continues to advance software-LLP blocks
> and complete cookies from RAW.XFER, including for polled transfers.
>
> Fixes: 3bfb1d20b547 ("dmaengine: Driver for the Synopsys DesignWare DMA controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> [james: retain polled completion and software-LLP progress]
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>
> ---
>
> Changelog RFC:
> - Instead of just dropping the dwc_scan_descriptors() method invocation
>   calculate the residue in the Tx-status getter.
> ---
>  drivers/dma/dw/core.c | 88 ++++++++++++++++++---------------------------------
>  1 file changed, 31 insertions(+), 57 deletions(-)
>
> diff --git a/drivers/dma/dw/core.c b/drivers/dma/dw/core.c
> index 5a1caca7ad68..0d6b5bd8ea6b 100644
> --- a/drivers/dma/dw/core.c
> +++ b/drivers/dma/dw/core.c
> @@ -267,41 +267,8 @@ static inline u32 dwc_get_sent(struct dw_dma_chan *dwc)
>  	return dw->block2bytes(dwc, ctlhi, ctllo >> 4 & 7);
>  }
>
> -static bool dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc,
> -				       struct dw_desc *desc, dma_addr_t llp)
> -{
> -	struct dw_desc *child;
> -
> -	/* Initial residue value */
> -	desc->residue = desc->total_len;
> -
> -	/* Check first descriptors addr */
> -	if (desc->txd.phys == DWC_LLP_LOC(llp))
> -		return true;
> -
> -	/* Check first descriptors llp */
> -	if (lli_read(desc, llp) == llp) {
> -		/* This one is currently in progress */
> -		desc->residue -= dwc_get_sent(dwc);
> -		return true;
> -	}
> -
> -	desc->residue -= desc->len;
> -	list_for_each_entry(child, &desc->tx_list, desc_node) {
> -		if (lli_read(child, llp) == llp) {
> -			/* Currently in progress */
> -			desc->residue -= dwc_get_sent(dwc);
> -			return true;
> -		}
> -		desc->residue -= child->len;
> -	}
> -
> -	return false;
> -}
> -
>  static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  {
> -	dma_addr_t llp;
>  	struct dw_desc *desc, *_desc;
>  	struct dw_desc *child;
>  	u32 status_xfer;
> @@ -309,7 +276,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  	LIST_HEAD(list);
>
>  	spin_lock_irqsave(&dwc->lock, flags);
> -	llp = channel_readl(dwc, LLP);
>  	status_xfer = dma_readl(dw, RAW.XFER);
>
>  	if (status_xfer & dwc->mask) {
> @@ -372,27 +338,6 @@ static void dwc_scan_descriptors(struct dw_dma *dw, struct dw_dma_chan *dwc)
>  		return;
>  	}
>
> -	if (list_empty(&dwc->active_list)) {
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> -	}
> -
> -	if (test_bit(DW_DMA_IS_SOFT_LLP, &dwc->flags)) {
> -		dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: soft LLP mode\n", __func__);
> -		spin_unlock_irqrestore(&dwc->lock, flags);
> -		return;
> -	}
> -
> -	dev_vdbg(dmaengine_chan_dev(&dwc->chan), "%s: llp=%pad\n", __func__, &llp);
> -
> -	list_for_each_entry_safe(desc, _desc, &dwc->active_list, desc_node) {
> -		if (dwc_get_hard_llp_desc_residue(dwc, desc, llp)) {
> -			spin_unlock_irqrestore(&dwc->lock, flags);
> -			return;
> -		}
> -	}
> -
> -	/* Residue describes source reads; only RAW.XFER completes a transfer. */
>  	spin_unlock_irqrestore(&dwc->lock, flags);
>  }
>
> @@ -975,6 +920,32 @@ static struct dw_desc *dwc_find_desc(struct dw_dma_chan *dwc, dma_cookie_t c)
>  	return NULL;
>  }
>
> +static u32 dwc_get_hard_llp_desc_residue(struct dw_dma_chan *dwc, struct dw_desc *desc)
> +{

Don't move this function, just change to return value boot to u32 to reduce
changes.


Frank
