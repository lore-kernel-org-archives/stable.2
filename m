Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793371510;
	b=zCrVckvfxspGP+EX3LQp5Kg/IrjKDyw6nuXDo/D0H/n6e+IudRKTJ2JgeBsKsEHn0zUK
	 moCXTtvaCmFMNGElkznaqGJ1WXXTzqhPTEQkPTyxflXUigAScZr1ohjWgvUfJus6PLRgZ
	 8MlbNhQ4g5sKkA0uOecYsz92JX4GY70FeVtDDPcOky2Md8jx5QL4smSL11zcRgD6Ru/ce
	 2kUgFEUkQVngS2KLNPFjXj+E4x7gPZg7t1xGjxjPKsPGowUlRS+F3PK/kPOpAaeFlXvoA
	 Ps6SzvkIdlxpt+sQCXdnGH8qplsN54erAK/hnNKPIGIy6LifpJbmWl5lJf9isUcLQhQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793371510;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SLBlob-MailProps:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sSVGP5z070jK0BU2x2Dx2OA2xt15GH2VabFX9FZqsQg=;
	b=skmqCebWJddwBnQsR1k8levasY3vjDDhiL7hwJSqSAkUf0cZ9+49QfQTpYCCUdhhIv8X
	 LfclPIY8yR5QCkaOg4cTXvyEJm+IXScHTnMh9AZpdZsFJ2M27LpNVKakHVWAKrGnsz5ew
	 HrvsS9kc+520ayxpCuEYLtjZDPhodca9PibVf2cKLNvA8s4zdirVW4g/GVRrJMy7bFV+d
	 Q/jdqurIF3GXE4LNB1fELsrJ3gsBqMxi6kuxBVZp5l+l/SQb0CvzIwVNhgd3SSRGT7rJl
	 5DUam9/iWlmQ6LH2QrmNkbBesJpL861BKhw+wwM7tuydYC9CG36SmBch3CfpTEjZd9g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b="bQy2/SP3";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.2
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010002.outbound.protection.outlook.com [52.103.12.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3446606A31F;
	Fri, 30 Oct 2026 14:45:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3446606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=bQy2/SP3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lCZg8n4O2S62rTz+NN9dvpAmbFU4dyNwykBC4oZBfWoTxssvzt8/hEF3Ob00vHeTmjTcMK5ntcDP7vU/qTMbug+2EdWf1H0QbXEyAvZsXnhhBJB5K5p0TnWRvChzl/RBCSxtlc8JV7yfai96QiGMTWwhoZFEqscucDkQM8Z4YxkDbaQ/hio70b7O1xy9bNr3Uz5zrgJDabSUbuYX2jWLyNnVhOY2urgorE0CUx/GLvf534+gcu51IVD8JWWMUufEZspdALIKtrzqVOfKZMbLVMmrr+WE+d3OLCtlCklPK96tK4H69Za0CUELTQqr4ZLblxhC2sxSYqie3ZHTgGQfxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSVGP5z070jK0BU2x2Dx2OA2xt15GH2VabFX9FZqsQg=;
 b=tV3LTC/BZkw8suhvjbHK3pfEwGZXjZd7Jl2W9KrMtSTTxr6rypjShnTfVXT3QzPAxB7eW1xyn+oPC+90N5k5WsHHdHMLEFS+Pa9XikPtxgKgpiVyK0/CdudcVYjPuexi+lLV8Jtc7tFyEIlViIlYBm8Ce/l1+MMw0P2LOF9JNKx3y++V/OgWXjTBmI6ROnNAg9n1YzLSYX5HZFP2Cx7rA7v6kgkxaYOI8HPHN0V8j7Ja+QtGgVi1B2O8hcRUj2crmEzs1Bp2Cma+UF/LqbDB7FAjx0spNCQzXSjmvi2/gvPgR0yh+CVi/kd938FlxjmanT00MTtwyuOs5Yw912rYuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSVGP5z070jK0BU2x2Dx2OA2xt15GH2VabFX9FZqsQg=;
 b=bQy2/SP3NY+Rwpf9iW7dxff05NHfgN6Ld70kutgvd3/I1uAlgvGCwvZKbXPNZDao3FcOhRA3/dZS+UZ2BC8v4QrVZbdCNJ5WVjmXpPyPvRgN27lWsB/SBM3+px/vwXG5OCyTlY5xrJ35IwHY4bkqPfwUCkg9kTK2lQ8NfK7sNFXJZnmuuudqKZutWelmOUoGZp68YH6uLp60Mlr8jPb6RxSzCuJdtB8YRnekBBkNPz31hmNt1ev1PJczRWx+UMAl2UbVBiC+bVGyv/E8goSQHX1n86BWEyEDQWax5n+l+HX2NJDUKTiQ+aXjkvK9fcm5cbNnJOXXYFJ9cvbMaz/4Jw==
Received: from SA1PR20MB994539.namprd20.prod.outlook.com
 (2603:10b6:806:4b8::20) by LV2PR20MB4654.namprd20.prod.outlook.com
 (2603:10b6:408:179::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Fri, 30 Oct
 2026 14:43:00 +0000
Received: from SA1PR20MB994539.namprd20.prod.outlook.com
 ([fe80::3a8e:481:2eb8:8d70]) by SA1PR20MB994539.namprd20.prod.outlook.com
 ([fe80::3a8e:481:2eb8:8d70%6]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 14:43:00 +0000
From: Austin Schlegel <schlegelas@outlook.com>
To: kmehltretter@gmail.com
Cc: alan@linux.intel.com,
	austin.schlegel@arthrex.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jonathanh@nvidia.com,
	ldewangan@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	schlegelas@outlook.com,
	stable@vger.kernel.org,
	swarren@nvidia.com,
	thierry.reding@kernel.org
Subject: Re: [PATCH v3 0/3] serial: tegra: fix DMA descriptor use-after-free and stale completions
Date: Fri, 30 Oct 2026 10:42:53 -0400
Message-ID:
 <SA1PR20MB994539626E8C613899CD951CBDD16D2@SA1PR20MB994539.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027065239.95915-1-kmehltretter@gmail.com>
References: <20261027065239.95915-1-kmehltretter@gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0113.namprd04.prod.outlook.com
 (2603:10b6:806:122::28) To SA1PR20MB994539.namprd20.prod.outlook.com
 (2603:10b6:806:4b8::20)
X-Microsoft-Original-Message-ID:
 <20261030144253.3606784-1-schlegelas@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR20MB994539:EE_|LV2PR20MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: 92d331b9-e015-4653-d953-08df36941834
X-MS-Exchange-SLBlob-MailProps:
	znQPCv1HvwUXBahuwteIkQeW30lJPuxOd2MwCr4OMlcc4/yWNVqqz7IUuarFMR8BC6a3WInIYxd8i606wE+PgvRqlXRMF1mV2SVr7EEQNUCwRqLT0zMpPWR9YfuOHPNkr19SqmpORxKPDqacUi2uw0MTFntOJ9N5o1QOm+5UVUfQiLRB0Y/ujE9l90+B5SQ0dymKfGkW4Y4WqqSe4Cjf678gG64T4MBE+PR3S57G9pVphaNalCFWD/C9/GXBOv23aLrYeFFYLta01pPScj7eec2Orn006p/OL2zH4KI53K3uLjR8O+vJaUubeXfn9eV2hSd3tnqH36Neg7l8kZ9sS7usIsc0tPCTOCPthP2ibtL6OpE49Ip483gICwYdu8W9h7BvTaoOteirzr/8yVKtsE+QgONxFgPK7wC4Xh45xvXyhJivFYdylyqQbFN0UZS3F0tNZUGPvBRAY6cN1W4P0k+oyCoOUxu5TlsyTgSR5HGij1w0LBIIjY4ziEIQUQUsVu1n1dYNQpTJAsJOYgxtPZxYJMriZtDaznoAtujAdZlxo1UJbRAmTDo7OwyDmjONofSJj6bTTSOSdCRbrZsXDBj8CJcQerYlmJPjboTGpQa6afEFziEzx38U2mNQuD9So2rQjGDATxOPFmlurLbmO3sBXAlYx5EaMfZeG2nhiTfTJS5dzAFC0Yem4pYIi4VJ4NpxcLb3iI9fwbyBcA7H2MJdFeptZcxiWXkPcGXl7JfSIKIBGVvSEUXjdLtWo9ATBkoGytb3OYQ=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|25031999004|23021999003|5072599009|24021099003|8060799015|19110799012|39105399006|4140399003|260925184616899003|25010399006|22141099003|3412199025|440099028|11031999003|41105399003|40105399003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1EX/2tTpVBZM7iaI86hpPN2wClJs3Hx1v1BNHpnC62MiKO/MA/ZmV0fGJtJd?=
 =?us-ascii?Q?QvBX23N8RCRoP0LeG1Q6TqkCW0HPqNV5w1WvcSH5pwhmIaRPJWavwwHw7b/H?=
 =?us-ascii?Q?8aDnso+FRKo/ihNzGcbg5sNcO8Rlt7/k0SE2ZOMCgRRMUvMBHMY4Kqdb2qHy?=
 =?us-ascii?Q?pdB9bpYptd7C+VzmU6nYAGAcNyC8F+Y7x/emDDbpsH1fCchXM27+mY7RgUNZ?=
 =?us-ascii?Q?fy26dfL4CgnIwKdOiwUoDmFcXXWamB0iKlpas3BeeBuS26ZUL0S0JqdxtezR?=
 =?us-ascii?Q?loAFPCNUpnKkOSDiM61Q94Zc6/vSESYBP6jyx0YRU5k7L/+bNHatN97Y9mN5?=
 =?us-ascii?Q?t23hISbbEChIH3X29wVYhna898farIpm2peTB124qTV4ctBQO+TMgljdGhAb?=
 =?us-ascii?Q?1ngRUtxLEF9RTFLo238MfQ/3Ai3lKMX/FD9QUF/ZDVZNVFcfA444lEllO2vm?=
 =?us-ascii?Q?+Nk/OEHHAExeqvcJv5MEjD6aRZQjzeI38ckhcrk4DVmhh2+u1IBYQlPJObnN?=
 =?us-ascii?Q?avrCqHoZtdz3uY8I5iLb5NhczGhshaH6dz8yDxx5HSXwCtwLePIwdkHpOA1r?=
 =?us-ascii?Q?PUD1zkfc+KSOuOlTz/RyEHuFYQNGnQGghj/CWwSsuOIpOo1Ca276VZjq15WU?=
 =?us-ascii?Q?oDljpsSZunHXNVuDx0ocVbNKxHAwGYFLmhgCH8VYNGoJvYAp3UJtf2L9plWV?=
 =?us-ascii?Q?iJySX+dBiIEHWTGeV8azbGT7qJhiIWgFmwdlA+FxFcZuVIOh5vTlCULafH58?=
 =?us-ascii?Q?+sWmpzyeTupn5Et/vRUPLNJsDzDnGGSm0/LNHEoMjW0+5EYx+PidIvSv3L21?=
 =?us-ascii?Q?zaXMlwU/jDP2Y+Lo5MW/9/8DCGBn5DD0fWxkzwAxDP478sHGGCHeuihx228E?=
 =?us-ascii?Q?idsPW/8UMiB8wTbDTvoUng/227i4SKbEHpnmHreun4pBcEVf+kvVYHEykLyY?=
 =?us-ascii?Q?9axTuj5WodSuViwj9VM6ANMkqUZlj2CVa+/kJT1U3RdgXEL7zQc0y1sROuJo?=
 =?us-ascii?Q?2vygmMbR48UcMwCYyPj7TJZ/8QUpNo8DN4fkbqwAEnExeL50Vnykmwaut7Xq?=
 =?us-ascii?Q?Ti26m9luEf/C7HdB0aRBkq/k+dlITA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O9uq4jWpkWEuyBo/0Yp/YWkeOYlyWI/fjo8NTenwKdJTUTVlz21FZVVTXAi8?=
 =?us-ascii?Q?C7g6f4R3wCWvvinI1B3ecEBKbeaYPqy0vClGynSuI8WjmnIHtH05t7nVpeSi?=
 =?us-ascii?Q?Va3KrsYt2q6Eia7yFF8a0EoVmIta8Qgr8/gORNSw9VHe0wY9YmuEztVZIdiF?=
 =?us-ascii?Q?up5yquE9Hkf4sdbBtIBidltwbZvUQcgOP4eEoGLOe9Qrg5BUiSHsuNunH6q4?=
 =?us-ascii?Q?A18ocnqJFyC7D3h6k/m7KR6cQEfFb2DRMPCCj0sj2cdGr5AIXZZ2GlHO7Jkf?=
 =?us-ascii?Q?2lVA8O8FO5Yb95A4oXrnGTRAoIzAbKCDt0vdRthzidw9w5ipuBL1btZpsdtn?=
 =?us-ascii?Q?dRsPk3hdM1R+4eO5ipB7jrsbsFt+PKRt0ovl8GkwoAjaurJ7bCVLOAXjTmFx?=
 =?us-ascii?Q?WJtptFqIcqKqAK6UAI0X8FYV3FEszRZHwH3oQR0/J3YEHkBShzy/vDUSsA9J?=
 =?us-ascii?Q?cU1L8Jrbo0a4Fi94BD98j069u31gqMm6+eAZHo7UXn0hzWWRjKhhBf1bHpQ+?=
 =?us-ascii?Q?1tQTExWIQtKKpjpPlpkhFeyYT0GaIHytSSG/QmP5U1pvtmfdXSgNNTPCL2oh?=
 =?us-ascii?Q?iV4bFNXkBLNB+dgn7aXGW7cukcNGIA9L0XRfhauOa3jLtnOd64lFocAMhnjA?=
 =?us-ascii?Q?wqpgv324zKoFIs8K7yTZbX2IeRhd8qfDtKRAbkfoKfyE7Ez1cK2dIlYJwT/D?=
 =?us-ascii?Q?uoNWfAdEDLxKUWJXKis2410huE8tIt49nGg9lqc0m8k+IO4qYmYm3PyBCTw/?=
 =?us-ascii?Q?oMgqqPRdrgB8/HZby/Zk/DHWw9zusrqTzqGvuO5tax4nqqzOAblU8otfUFS0?=
 =?us-ascii?Q?gnu2QDo/iJVYP9KnTHDbJRI2B1mK0ZCXIG7YIO8C+BrLz5/I3VyL0klmWG4a?=
 =?us-ascii?Q?AVrXhA+ZvbuThAUPmCKTKMoZwlaWJayvv0gEXoaLXPQ5WdoqFRvPi5uwZES9?=
 =?us-ascii?Q?tIIBnDJCPd6ShQJaUWwWAO0v1v7Loax1HVxooJzUUYgYxkbPfcsjjlcqA5tw?=
 =?us-ascii?Q?p5XOk4Y5U3IqmO4J9iQLmTZZRSHXNVa3G5KOSGr4y6rFsGekdtwWXlDnRlBJ?=
 =?us-ascii?Q?9CD8Fw/e2oiGa+LjEFT1fcUTfv2vCfCISrRd2PYCC+l62YaIFv1088GYrJSh?=
 =?us-ascii?Q?oG1h863QQX9c6KNzyin/3vRwAOC/hGMaHiUljdQTr7JrIZ99Oht+1rFkKIpg?=
 =?us-ascii?Q?kZYXde/kBoIcaHTmBROyEWAXXw1+HnHdlNDlF2g3poawy/4qTRWekTl5nw6o?=
 =?us-ascii?Q?BqAFAzDSU1I42yxjBsf2aYXP6BthwFXRIQMX+q2it/ZYHEW9HyRnARzz/039?=
 =?us-ascii?Q?Wf76CdfXtIrw/uDz1AwK7bxLCOItfZp4rS1mFE9P3yDbfxxXrXfeBqrHpEP7?=
 =?us-ascii?Q?LVI7v5fsApRvzSt9hicr3fcYoTGHgxomP3acPfpVpq94ndIlw6puyYfXwOVF?=
 =?us-ascii?Q?3IiQYmnNS7iavb+6MEvJxjyqt/Z9/Xz3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d331b9-e015-4653-d953-08df36941834
X-MS-Exchange-CrossTenant-AuthSource: SA1PR20MB994539.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:43:00.1633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR20MB4654

On Tue, Oct 27, 2026 at 07:52:39AM +0100, Karl Mehltretter wrote:
> Tested on Jetson Nano (Tegra210, 70006040.serial with tegra20-apb-dma)
[...]
> Tested-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks Karl, this is really helpful. It covers the APB DMA path I
couldn't test, and your unpatched run is the first hardware
reproduction of the tx_in_progress bug that patch 2 fixes.

If there's a v4, I'll carry your Tested-by and update the cover letter
to note the Tegra210 testing and the reproduction.

Austin
