Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794298145;
	b=0WrDGOzjBLh7JTZa88vB7OcZQVCvJNOM6URUPdDCq3oXC/En6lAngVPxuGG3X8P2w9fa
	 NMYr4F64vLp07r9+Eb5jClkcPQ0VJwzxa7yyp54LqPwWNEntISw7cLhsPjJO386/D3f5T
	 ccd9z505uul/YN2cX3Y5AecXgTjmGsZVZAtU155qdKYNr28/vIKe9gg3gKD3tjv14bZ4o
	 0JXg/ChL4/YnRxktaKn8KN+L0VMZ1s6IO7+PV2VZUiKe/zr2A60DsjYa2utjSwWSZFapb
	 +YO+DbZAcqnWFIjovHa7JWjs57nkadcrCtTgD1f84J85CLC+qPHmer6gGTC4Zgs5riQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794298145;
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
	bh=6TSqzrR9T+3kI/l+sR+aHGBIvSGkD3hX+kWBRzWImpc=;
	b=xl25901bT6bvHQeuSCZbIeQ46vLdSnZP0kkB54iyeUIvq37TU9/V9+zMr1kj0HwLdWMJ
	 k6nTBL0rRvILgwltEHYEsHufE9+y+FlnLtYE2hzOP/omgLJ0o7VZ5JnLVazJw+Tkk4S6G
	 mQq7fx3XOBzVX6BZv1YX1qsFoi3EZKoWtd8vrSXsRHYeofEr6b4+pOGGmTgy8dvw7tlrK
	 M6mqkean13PtABRE496hgo3vKCb9yTUJx56w8H3SmaVFui5Kg3YRBhlJL6Gp7dfdan0o9
	 FE4z6RD663sOkvBZ4CKXRPNq1D1wFs7uyLHQj0ecHLpJM8vCS4dqKVQPs70gVqrYlOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=S793Gujg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.52
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012052.outbound.protection.outlook.com [52.101.66.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688AC606A321;
	Tue, 10 Nov 2026 08:09:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 688AC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=S793Gujg
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sE+gdJSZHi9UCFG3PVXJQ6+4NwH2PAWP5WyKkBcUuXEkHkq+OHaK9vBTsK7GsKdGp5nH/6fHjeeQj9wt9sK5zQH4XWPtQRty0jwETZK/VHUTxnlCD1PuL58iq6uN1/ZDX/ZASGWmgaAzOn7EFAhJ12BGiGgrl5sfDudFAFGpOUY4la9UPeuNN/+a5bOJ09oouFFgc4CDkuWRGkwCpTUbZ3n4a1syb+mCe+LD9v9YS/WpHlBzh5axS7LCEo+DPUfBVBwuWrNIL9zZ8rUd8ZLi2dX9SXJ/eadDzeCj+zN0CGYDr2S/R6s7yd7/gMfesviBsZF+BpIJXzPC+zAP5gnH8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6TSqzrR9T+3kI/l+sR+aHGBIvSGkD3hX+kWBRzWImpc=;
 b=lGVXSs9AtKwo57sAOmkzl4rpqJvtiGKiSkuH+RnAQApkQrYcKFR5RpoqTJgPRUs0TYC8eTnh5qfiIJD425lQ2eQyW4t8iaL1jgsl/uq/qw0xtMhaojiQv3DHFvfmN0/TmTXhGDQoJW3a8WIP49G7ghyFp/fn2KaRnWnpF7vWpNhBJRvwZ29cV6r7/uqdb3NQtVYPd/KFzB+bACX8J1TCliOvkbL0e8qu3Jj4B8m2zEDIryR8gIlP+RZB+6HBY0NNtSk53wqghKWKcSILdLSVSieW/bX96G+2hwQU8/tfZl9kzTF9/VTzKTUu5fS4ApvtRqSCdoUUw93PMj23bHvPXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6TSqzrR9T+3kI/l+sR+aHGBIvSGkD3hX+kWBRzWImpc=;
 b=S793Gujg+GjN0Wz7GPEpChfSKWr8l8azyON2smvprJ7jKyU700Veg+3vb9Foe7wb4i10MSWtRu4aW2nn5kHMNYBR/DoIjqaoC7YaXDiyS4k+7gbWPfjM0/nGKrSGdeI0wKa82l1bSCKsStma81gZcvnJFvwtlgPTK1D2h8anW6uExvKGbh5JDw9BW827N2q24cZ3qn9eLL1en04avIyQM6p//GKnPrDyau7saevbYFCcLpzPVhrF4Ra4lPTfLaqWnPudFSmmoqZbipyen86rvuXon/0TDXJ3Ubnq0r4zVLXJJjhX5Xs2x96gB661/pecQ5s/tAAICHuXA45fHKsREQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22) by PAXPR04MB8207.eurprd04.prod.outlook.com
 (2603:10a6:102:1cd::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 08:09:01 +0000
Received: from PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2]) by PA6PR04MB11909.eurprd04.prod.outlook.com
 ([fe80::a4b:fa4e:7fe7:e6a2%7]) with mapi id 15.21.0592.010; Tue, 10 Nov 2026
 08:09:01 +0000
Date: Tue, 10 Nov 2026 16:13:55 +0800
From: Bough Chen <haibo.chen@oss.nxp.com>
To: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, michael@walle.cc,
	Haibo Chen <haibo.chen@nxp.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spi-nor: clear the default read_sr2 opcode for
 Octal DTR flashes
Message-ID: <20261110081355.5d7ubrgulopr7qvm@shlinux89>
References: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023-spi-nor-fix-v5-1-bb6e0ce21169@nxp.com>
X-ClientProxiedBy: SI3PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::6) To PA6PR04MB11909.eurprd04.prod.outlook.com
 (2603:10a6:102:51c::22)
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
X-MS-TrafficTypeDiagnostic: PA6PR04MB11909:EE_|PAXPR04MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 880f5ed7-5945-405a-81de-08df3f01e091
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|19092799006|10067099003|11063799006|5023799004|56012099006|261022105027099003|261021121427099003|261022075727099003|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	y2KM2wFLNE+myUjbvU9fOqKBCClAm1EDq47xkerEZHrwAkq3T0+Td6QkzKRmbMdTLPNJAhkltBUJtgmMiTOrJ890DEkaCkw8TiauKVfSceLIWlGKhx1GOa/qbyFE+3b9kZi4/J5SeHIpOT12dqYZmeibxkv1rUokXo1jYP0EueaBdLjYs4bziJYogBftKXGS9AllBhETEYNjI5juC62zGEz8PJWFfJ4CoNrazHsK2C5FHK4KepNWM7LAoV79RSzm0+b51dQH7cvKWd8yXV6Fjb/bLUfQpqMyLcjjirVSHO1A7AbulJ3oMY51Q0dvxPkuNoXjKye2mzZ9E26PcB/SpiVOQhr4fEOGu+pELMYcvAnIBVEEt3iDXwx0tPUdLlM+07yAHfFQLgo8qs8pBQCkIykQdDk8Hzo+hwvVTuXj2YqvFWfrM9fhPfit3xN/I+lHZDxlw06iykyfYNl9T+oUljlT5p4ds2MHwBsYgtJbBOKGlkHHxTeX3m4oLDBtkx7CCOzU5mn8UJYVd+KU5pZGVHMOa6Qe+W6I96aH2XlFFyR7jOhe4IjfYZwLHQqLImfeyaQaVPjXIvvDu70UegvfwWXS0GUTmmdmSQO0wpdQdJw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR04MB11909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(19092799006)(10067099003)(11063799006)(5023799004)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cqBkE8bRbkcFeTCkxXqDuIxXrH78IQWUv/HhX367P/pN3I6LGuU2JMPWThEG?=
 =?us-ascii?Q?kbIgp1cHTCbq4nW4GDVuCk2GDczhYNV3Wl5xtJANZlw8EMAe8bcLDCKhXRdK?=
 =?us-ascii?Q?2q5X3TntKg4TxTTdHvvkrLP7q6kb3pDUeUaHaAg21nvzTv/jsiDtXn5Qujuj?=
 =?us-ascii?Q?EuvdwvJ2GyFzCy5fznWLIso6najhl2OqWkcXkjXFyatd/IDimdZkEhIQUxxl?=
 =?us-ascii?Q?qkz3Rvvy4wLeq3MWel1NfugM4v25LIS7DD5qjhTOhuKR2FbTCDTV0FqGtn0y?=
 =?us-ascii?Q?WADnL8OE0Sjyefe1BIFXwUYhzwM8QvoA5YFqe8HF6As9ypBRKAJu2hSJAsh+?=
 =?us-ascii?Q?01n/j8pLUfk20nS+tuCP8rIdoibUXwUN5B+NkNntEPsBbI6mqbg2NQUzSxtc?=
 =?us-ascii?Q?84y5T6xLUzCzMIHPOYMk7zBCuWP0wvgOQGvUzJrZMJfbuHrv8Qc1deJ++/aD?=
 =?us-ascii?Q?sI4H5jpT0G2HCjITaqqnz5DfnjGZZtt6fsneDyQadaO2ACIwTeSaRrZIFYAY?=
 =?us-ascii?Q?oTAlI8fPqKNwQV6eqeWrb6Dz4PkUCkiR1ylLqWf8zm3FaggqdH3whRqFoKdm?=
 =?us-ascii?Q?iFMqzc9SQ5QcVMmNZVquj9v3SgoalDnC5/SeoMaUgW+B+lDxcTUJp+kkbB5r?=
 =?us-ascii?Q?FlMN3cXduul3/1uzA90V1mdUVJYCMAm3NkbALiuAsvpTGGMjwgbdlW4lv5WA?=
 =?us-ascii?Q?Xp0GzNCNPHgHLChmyXawfI3YIjXcaVgJFmRSZbIiukozUJAaR5Uf6a3FOPQZ?=
 =?us-ascii?Q?OAFEBT1M42sEvMEWgvYH4IS7E/CEDVS91bT3fZBNozW1q61KZTeBUgt7//Ww?=
 =?us-ascii?Q?kQpblJMKudxxoE0ewmPTSx+LtFZ3I1MRcQ/euzJ8oJWFzUiyOJdC8vC8npt8?=
 =?us-ascii?Q?JMv+PbQ07EMalZ7VruW9HJbIS8pbasLirZ3L0aX1Ojihd3Jvf4nZt3P5sWfj?=
 =?us-ascii?Q?ySBiv3Q48I4kbsjCLxz8UkyNYre4566K/YDTGwuHwuV7/j8NU0IB8/eW5svz?=
 =?us-ascii?Q?Iwy7cdPxVfUt4NbRVWyt7YTgLSQ3pov2doa4J5/sscCfXYt92C7HzMHNoYab?=
 =?us-ascii?Q?jDg+X+w2wg01fZp8fqmWISRRhv4WlHvGrA/jWYSONZr/eFDaMxtFHIycscSR?=
 =?us-ascii?Q?UZqxJfcoOaSZP7bz0JGpiWzeTtIBozC8cYz88QErbqI71CVPSt14d4dZ0b6B?=
 =?us-ascii?Q?OxUAcwn+hZkqfBOcuq3mrJ5sz7rzM8HMYss77T9ie7wm+5o86+TvbUXEzng5?=
 =?us-ascii?Q?oOtQIvqvr0VTwMi1TG3Mnw1oCRbrHx3gAxgr6NBYbujJVsx1VgAGbfcEoT34?=
 =?us-ascii?Q?BVg5VbAhdGqIjdIa43tLhIcNJog/l0prNk2VjxxvMarlq6ufzwAO6FAi8Jir?=
 =?us-ascii?Q?kkkolHxonJbYMgefmfg0rY2H6IL8K6k0WEoogmgUldwyfOhWdwWN5q7YR84P?=
 =?us-ascii?Q?E/mO7j/lU5pY4xTufEuHWM4s9XiK3/kZb4/owrSAGYOrJ0OxHqjkkvpCFrbv?=
 =?us-ascii?Q?fs2NjnTExXxBbdles9Fomh7vU/KsnfU+SJQ29tZxM7U6N+D4dBd/BKjWvEvS?=
 =?us-ascii?Q?UtL75RhpGgWERDtNgoZYk1ToEuuQpYvZrA+Z0TF1cuylrbMQsjXlbFxRKonE?=
 =?us-ascii?Q?0rLyIsoAOwi2EaXLF1asmyrKJjl3E82vX4UzJ9tZAOH/JeGXYkmZCBbXb3ew?=
 =?us-ascii?Q?oXJupzUPtpj0jP430WJ0d7Oev2xgqg+HfZk4rgJgG++pcFnaUAD6tewz2PVT?=
 =?us-ascii?Q?G1sFMp1wbytFHiYDLDRqtfJYbxWuGyZHfS0N+XA9a2VX11Qc7QOO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 880f5ed7-5945-405a-81de-08df3f01e091
X-MS-Exchange-CrossTenant-AuthSource: PA6PR04MB11909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 08:09:01.0271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y3yN9kMaRen4ZeciZZ+wLKOIgK+sHeQo3vZm/F6oJKGboIbKnTzfj0aJ73s0d3bkPgcPwL5KG+Xdtmlq0b1UL3qOVUfOd3R4URBI8tR3kviwbu27WoRS1cTIlDt3vIhQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8207

Hello,

Just a gentle ping to the MTD spi nor maintainers.

Please let me know if any changes are still needed. Otherwise, could it be picked up?

Thanks
Haibo Chen

On Fri, Oct 23, 2026 at 03:11:54PM +0800, haibo.chen@oss.nxp.com wrote:
> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The core defaults opcodes.read_sr2 to the legacy RDCR opcode (0x35), and
> spi_nor_cache_sr_lock_bits() reads SR2 during spi_nor_init(), i.e. after
> the flash has been switched to its runtime protocol. On an octal flash
> running in 8D-8D-8D mode the opcode is extended per cmd_ext_type (e.g.
> 0x3535), but RDCR is not a valid register read there: these parts access
> their status/configuration registers through a vendor-specific indirect
> space, if at all. The flash does not answer, the register read times out
> and probe (or resume) fails (on i.MX FlexSPI: -ETIMEDOUT and a controller
> WARN(), seen with a Micron MT35XU01G and a Macronix MX25UW51345G).
> 
> Clear read_sr2 on every path that enables 8D-8D-8D, so that
> spi_nor_read_sr1_and_sr2() degrades to an SR1-only read and no
> unsupported command is issued. A manufacturer driver that genuinely
> needs an SR2 read in this mode can still install its own opcode in a
> later fixup.
> 
> - spi_nor_parse_profile1(): the common case. The xSPI Profile 1.0 table
>   does not describe any SR2/RDCR read, and it runs before the
>   manufacturer late_init.
> - mt35xu512aba_post_sfdp_fixup(): some mt35xu512aba batches lack the
>   Profile 1.0 table and enable 8D here instead, with the BFPT QER field
>   left at a reserved value so read_sr2 keeps its RDCR default.
> - spi_nor_no_sfdp_init_params(): non-SFDP parts that enable 8D via
>   SPI_NOR_OCTAL_DTR_READ keep the RDCR default too.
> 
> CMP (the only user of SR2 beyond quad-enable in the locking code) is
> Winbond-specific and is not placed in SR2 on their 8D-capable parts, so
> no octal flash loses a usable SR2 read because of this change.
> 
> Fixes: 63489002d397 ("mtd: spi-nor: Refactor Read Status/Write Status support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
> Changes in v5:
> - No code change; address review feedback from Miquel on v4:
>     - Drop the Fixes: b7b63475903c tag, keep only the Refactor one.
>     - Add Cc: stable.
>     - Collect Reviewed-by: Miquel Raynal.
> - Link to v4: https://lore.kernel.org/r/20261022-spi-nor-fix-v4-1-fba3ec3d2b5e@nxp.com
> 
> Changes in v4:
> - Following the Sashiko review and Miquel's preference, keep the
>   capability-based clear but cover every path that enables 8D-8D-8D, not
>   only the xSPI Profile 1.0 one:
>     - spi_nor_parse_profile1() (the common case, already in v3),
>     - mt35xu512aba_post_sfdp_fixup(): some batches lack the 8D command
>       info in SFDP so Profile 1.0 parsing may not clear it,
>     - spi_nor_no_sfdp_init_params(): non-SFDP parts using
>       SPI_NOR_OCTAL_DTR_READ.
> - Checked all vendor drivers; Micron is the only one that enables 8D
>   outside Profile 1.0 parsing. Macronix and Cypress rely on Profile 1.0.
> - Link to v3: https://lore.kernel.org/r/20261022-spi-nor-fix-v3-1-bffa00b75c27@nxp.com
> 
> Changes in v3:
> - Clear opcodes.read_sr2 in spi_nor_parse_profile1() (capability based)
>   instead of in spi_nor_set_octal_dtr() (runtime-protocol based), as
>   suggested by Miquel and Michael. It runs for octal-capable parts and
>   before the manufacturer late_init, so a driver can still install its
>   own SR2 opcode afterwards.
> - Confirmed on a Micron MT35XU01G (i.MX95) and a Macronix MX25UW51345G
>   (i.MX8ULP): both publish the xSPI Profile 1.0 table, and 0x35 is not a
>   valid SR2 read in 8D mode on either.
> - Drop the Assisted-by tag (removed upstream for 7.3).
> - Link to v2: https://lore.kernel.org/r/20260929-spi-nor-fix-v2-1-75440cfe4e76@nxp.com
> 
> Changes in v2:
> - Rework the fix following review: instead of guarding the read at runtime
>   in spi_nor_read_sr2(), clear the default RDCR opcode.read_sr2 once, at the
>   point the switch to Octal DTR succeeds (spi_nor_set_octal_dtr()).
> - Key the clear off the real runtime protocol so a flash that advertises
>   Octal DTR but runs in (x)STR (host without 8D support) keeps its RDCR.
> - Drop the swp.c change and the -EOPNOTSUPP handling; a cleared read_sr2
>   already means "no SR2 read", handled by the existing debugfs caching path.
> - Trim the code comment; move the details to the commit message.
> - Link to v1: https://lore.kernel.org/r/20260928-spi-nor-fix-v1-1-ce65ba90cfbd@nxp.com
> ---
>  drivers/mtd/spi-nor/core.c      |  6 ++++++
>  drivers/mtd/spi-nor/micron-st.c | 10 ++++++++++
>  drivers/mtd/spi-nor/sfdp.c      | 11 +++++++++++
>  3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 90524c58602e1c27cd83951ab0cdd3669a2ebfd6..8ded5cd12669161a95d7c08773b5a3a9a5f9b3ac 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2711,6 +2711,12 @@ static void spi_nor_no_sfdp_init_params(struct spi_nor *nor)
>  		spi_nor_set_read_settings(&params->reads[SNOR_CMD_READ_8_8_8_DTR],
>  					  0, 20, SPINOR_OP_READ_FAST,
>  					  SNOR_PROTO_8_8_8_DTR);
> +		/*
> +		 * The default SR2 read opcode(35h) is not usable in
> +		 * 8D-8D-8D mode; drop it so spi_nor_init() does not issue an
> +		 * unsupported command.
> +		 */
> +		params->opcodes.read_sr2 = 0;
>  	}
>  
>  	if (no_sfdp_flags & SPI_NOR_OCTAL_DTR_PP) {
> diff --git a/drivers/mtd/spi-nor/micron-st.c b/drivers/mtd/spi-nor/micron-st.c
> index f97f2dead8c2f175564410871c896260dc31aad3..cff774a83d7656ca2d7dc5af13a78c8c520b1dd9 100644
> --- a/drivers/mtd/spi-nor/micron-st.c
> +++ b/drivers/mtd/spi-nor/micron-st.c
> @@ -181,6 +181,16 @@ static int mt35xu512aba_post_sfdp_fixup(struct spi_nor *nor)
>  	nor->params->rdsr_dummy = 8;
>  	nor->params->rdsr_addr_nbytes = 0;
>  
> +	/*
> +	 * Some batches do not expose the 8D-8D-8D command information through
> +	 * SFDP (see above), so spi_nor_parse_profile1() may not run and clear
> +	 * the default SR2 read opcode(35h). Drop it here as well: it is not a
> +	 * valid register read in 8D-8D-8D mode and would time out during
> +	 * spi_nor_init(). Clearing it again when it was already cleared is
> +	 * harmless.
> +	 */
> +	nor->params->opcodes.read_sr2 = 0;
> +
>  	/*
>  	 * The BFPT quad enable field is set to a reserved value so the quad
>  	 * enable function is ignored by spi_nor_parse_bfpt(). Make sure we
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 4a3f82e97cef8a76c9704918aa6558ca4e2f2b97..722eeff71d0df8c47ec7bdd795c08ba1bdf5e9cc 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -1344,6 +1344,17 @@ static int spi_nor_parse_profile1(struct spi_nor *nor,
>  	 */
>  	nor->params->hwcaps.mask |= SNOR_HWCAPS_PP_8_8_8_DTR;
>  
> +	/*
> +	 * The xSPI Profile 1.0 table does not describe a Read Configuration
> +	 * Register (RDCR, 35h) instruction, and the single-byte RDCR default
> +	 * is not usable in 8D-8D-8D mode. Drop the SR2 read opcode for these
> +	 * octal-capable flashes so spi_nor_read_sr1_and_sr2() degrades to an
> +	 * SR1-only read and spi_nor_init() does not issue an unsupported
> +	 * command that the flash never answers. A manufacturer driver that
> +	 * actually needs SR2 can install its own opcode in a later fixup.
> +	 */
> +	nor->params->opcodes.read_sr2 = 0;
> +
>  out:
>  	kfree(dwords);
>  	return ret;
> 
> ---
> base-commit: 9a482184d910775cf648863148944945b74e2815
> change-id: 20260928-spi-nor-fix-eb7ebe22a740
> 
> Best regards,
> -- 
> Haibo Chen <haibo.chen@nxp.com>
> 
