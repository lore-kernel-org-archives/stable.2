Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013065.outbound.protection.outlook.com [40.107.159.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44735275B0;
	Wed, 23 Sep 2026 19:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790193538; cv=fail; b=JJ5EjADowtYIQrztTz8rwYr0aVG2zkIzNit2fqmDxmpEZ1PX7PhIi7C/QbXgoI+trNyPKrU7WZNBjgIH/QgOkFaFRcoDFhZ2TOUgI0RRGUhhfhF+AvgvXJdnVOWx8apQzouqYRR8WtnQkjUJPRIqGLXNdTIDFOR7gZTDvMnkKiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790193538; c=relaxed/simple;
	bh=sbxzueeRPX7keQr3+hRKgk5PL9k5z9al+mGJv82i0HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEhdlwe+9rWAmweJRGG6lKcMcJq+lnT3SlEDVSAzvvlLGcLgu5qdUcfOP2Q0dSJjzZJxX7EW6laGt8+Hfq0Rf/L92ieC8C4OFMequL3HHoBUcHr06JxvNuRysOvhjq5v7sRoTGURLD8aS8cluBfuGMC26jCihA178TvZlBfN0co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HutkrnAa; arc=fail smtp.client-ip=40.107.159.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HutkrnAa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVtsQRrQmpbMtECxdd/iIx2X78dWgMHW67s/ttzW+2NrIT4gAfKETbgt//1yb69J4nIy3EZ9umBFEdLH0tOYvKLw6h7MG52RrWq/QMSFuU7XeIjqBKJFN2y2u0yuK9vPdLpEWpPJAIroVJOf2udg79auc3sJH4sBs2EA1eO+3ID1GD2VXiTyOPMR+B5F765mThOrUCydWDC+jFZX4s49QTixcGuDh0bIiHwqimHgzFTFfHgG/A5us3ms+tlW8nAmV+EBc3x5sr2OBIJdn0cWWVCNtJg5EFAORMOKBZf1ygkfEZu8H1FRa61QMUJM2ZIHmyLuzfCJhStzqvlokzZy7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezF5kMdeYVWgh3U5SwEfeiT5Frwhay7pTmnqGkatgjg=;
 b=GVJeCG5TBrObctlSMuIOOgxPfVhlDCIwoveQQ7M2sIrUeb8A/UEe1YdZFbh5LqUyPVQQg/yuS8VE9pq7KfcQj/LXbtrupS7CmZbB+WR3y/rezKq646PHcYV6aaSht3VHFqZpWJ+fSh04NqSpVLp3QRm90oXP98J44gabMAAPvKbgpcaKpL9RGiZFC63Db/vGs+ZqvLHzakeN+3AogIJCHvYlvdj486oau62rnrzyAcsVn0gpKtIU9pAm+A2Mt0d3CLjuxF4KKm07zWaxxm2p5esERrBH3OCvWKoYGTi0WoD6HgEpy+jVIRoeqYQzp6xgn+htUdyeZp39cP1o2Mh+mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezF5kMdeYVWgh3U5SwEfeiT5Frwhay7pTmnqGkatgjg=;
 b=HutkrnAaeEe0N7n6ryhHrVqniMcLij0zLWb60fc3I3jo7IWlYblQaUYyrSqmCYQK0/oskFJGFNKtvJcomkvnhDNTA7bakiFUxEte3Si8wMtXFNnkyBR5XisLF6ptNBsuJv77zB08KKPJ6actCfucIoGN8lLJ9FXXL3tsuY6CyXcQwKivdjXVr5jcxX8DOwgWVpz2Q71LuVb/CMtmEpgzm1lZvEPOirh++HeEqytESc9GwgPpd6ajG9KWhIAMTaqcDni+Lss4GJRBcpuPL3L1jDeOTTkxUrp4cDhsXSac4xrU4n+BGEDFhHUCD3IbFcex12usKiWRxvZGOQEVNz6ByA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA4PR04MB7552.eurprd04.prod.outlook.com (2603:10a6:102:ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 19:58:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Wed, 23 Sep 2026
 19:58:53 +0000
From: Frank.Li@oss.nxp.com
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Francesco Dolcini <francesco@dolcini.it>
Cc: Frank Li <Frank.Li@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] arm64: dts: freescale: imx8mp-toradex-smarc: fix SMARC_SLEEP# gpio-line-names typo
Date: Wed, 23 Sep 2026 15:58:46 -0400
Message-ID: <179019352263.3733294.14111787723423970974.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915201411.23118-1-francesco@dolcini.it>
References: <20260915201411.23118-1-francesco@dolcini.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:930:1e::10) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA4PR04MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b1d168-691f-4d74-3c15-08df19ad181c
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	DZ8Fyt/7mcLddiHuu4axiI8XRQq4gJO9osl2EEeDoCvqRwDqgKuHTmLwuhtR/dYtRG8VvrniFzvp6Xp7o09sWfsBqTgBuLPjVbtBSupCCzOPD+foLE22BNf8P+C3mY0EHcXXI4g8bvMWH1MEzJqbidTXJ3fR/+Unbi8HOdtWVP+5sxD19bcXzOYpAY+GNzG5nvAt5ZChgxYpZoNLRYZlngdUqNojuuZDa8am81CRLawe0/r7Yd8WaK8SPEc2U7yOxJJE4kFNTVGxihxBIZh1mDNtagakrjgMAA30zQNWFuCfD4cM8+tMxW3XtyxAuEGJTbyYGgXgKsK8rxY0lQqY6tAjbsJGnYg60FtO7iKQS1BCy1nG3oRJKVWujdGm2QhsYBBDMtv9YUXxjcf+jveJZP1Mh2HGmXHtbWSmC5t2m2W9i8AwTbXIoHl3UeUV8nb4UdemQU//k08uC8thkPy240BdofAQfn71sawKdDrhEeID+izgrN5g9n7j5DJuX9ug+eG/VVBjVbNfx3KTl/+aA0mBaWmQb8euPIk2Wl9xayf+Q0xCa7KXDlTiazotn4ZjabEoZYutF7cZCd5715tMXxUGZGDsXDnWKf+sb3Ogy3n21k+Y5e65JuKUOY8zqqfl7CvaBY6f7uHuo4nZs7+K3pbLe95ZbTAv478vaVLWXwI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R055bzFRMnEzMmJ2WEtiNjVGTVJIVHFjelNiVU1DaUFFV3FkUlhETHRGN0ky?=
 =?utf-8?B?OFZDb2xjTEhMeEQzWnFBNXdCZjRQdGZBUWtrODlTTGtGM3NUbERkNWNFUHNn?=
 =?utf-8?B?bEg2emE3NGp6ZHVDNXlPS21tZWJ6QWpSOEZmZ1MvdmllS0NiL09LQWs3T2cx?=
 =?utf-8?B?UFRPNVI5a1JvL1I4WWVtajlIWU4zSTFqMGpHOG9RMWlDTzJSaUZLdm1hUlhy?=
 =?utf-8?B?V01OZXcwVnVaZk1idlpnU1VGaTIvU0hjTDFsSzVqTmNXUDhTM3Z6SjdENFo2?=
 =?utf-8?B?enFsR1o0N0wrVXh5eUxLMzhLYWV5dFZxOTBaMmNxOUpRS0NZNGdFVFkwTzJp?=
 =?utf-8?B?c3V3WjVyeVNiaVk3RkRIN2pEQ2dqQlVaM2RrYkZEL094a0JGZE50WGdEOTF4?=
 =?utf-8?B?QmYxcVJERUYrZmRIdG5FeGJKdkoySUNDWlBnWHl3eHkxVXNyVnhXU0ZmdUdU?=
 =?utf-8?B?ZTliNGtQVENUd0lSc2hWbmdGOEJTTVczTHg1ZE9seFpmbUEwa2dxMnFTTlQ4?=
 =?utf-8?B?QkdSdUVKTHFjRXdibGdTenNENlFoOUVWc3IwQ1l4cmpUYTJBL242ODVjUE0x?=
 =?utf-8?B?cXZXamkwYXNOOHdDajUyelY5N2xzOUwyTDZJZFdxOWJaTUhIWjNkcXVXRGMx?=
 =?utf-8?B?YlNVSFVSRDI4ZmRoaTAwdU5Lay9rMGJkRmVHQjB2TVNIWVdXdjdrZEtQM2pq?=
 =?utf-8?B?TXV3VGZtcjl4RFQ3TVBlbmNrOVpYeTFQOUlndlhoSjB5NUxPeWU1UmdaQ0l5?=
 =?utf-8?B?YXRlUWNRRUQrL0J2cGZTak1IejEyQzBrWnNhczdkWjFkNnJNaDJ3WFdRSEdO?=
 =?utf-8?B?eHcvQ3F6RWxaSjdRU2JnTVhzdi9zWlFKQ2YzYzkzUzd6bTZHOWpmQ1BNR24r?=
 =?utf-8?B?UG9uTFJHeWFYdWpqWVg1eVAzUlZwL2V4UTYvd040bHBueHlRY3FWK1RXQkdS?=
 =?utf-8?B?b3BNTEFoSWNwU2VOMUdXLzYrSCt5WitsL0IwdUtjdzUwS3N0azVHcWN6SGdl?=
 =?utf-8?B?RG5mY25TWWdZamhRN1lRNm1TVWl2L0RROXlXUkN3dURDUThTMnNnSUs5WjBM?=
 =?utf-8?B?VlBlWEZVbWI3WjR6QmpJSVkybWdhaEd1Y1BhRi9PbjRKMmx3OHJrZ3ZZNVlR?=
 =?utf-8?B?bUV2QWlCZzNxOWhSQ1pYQUtVbzBiUmNuQVlzZUdJcG5DY0hZVGFpYmlvanA4?=
 =?utf-8?B?TlY2K2x5eHFrZzh2cmZ1MzhJTmE5UWJ2Zmp3R1c1Z3pmVTgzS0FCUWgzZjEw?=
 =?utf-8?B?TklSbVRpbnVqTTl3NDBsMlVaL2RyaGhucUl4ajg2OXFSbFdMSXVSZkRxeDkx?=
 =?utf-8?B?MHdMeWNrVGVFLzBkbXpyRWR0MHBQb0ZuOGhick15MzdOamxtNmhFakhlRjl2?=
 =?utf-8?B?YjZQNnRtZ0hsY3p0c2VSTGhnQW5qVU1YOGM3MXJTZXRyRFZsbWQ0MFBLMkJi?=
 =?utf-8?B?WTFlR3hOV05JYVR1UXZ3N0poV1lqcEh3ZlVHQXdldVZYN3RRYkRYajdUMnFI?=
 =?utf-8?B?RlNwY0g0MDVqOGFTNjZnTFNqQW9XeGUwNkZHbVMyekdqOUNWdHd4MDlEMGdt?=
 =?utf-8?B?TjIxRkhzSGVnZzAzaTZlSlJEcXNuVWVTenpKcGxVd1lUNHFTZGRaeE5zQmVO?=
 =?utf-8?B?WmdEa0c5Wm9wT2QvSlhFN2EzR1NhMksycmwvakVTU2hkRWtqemtKSWxQemJk?=
 =?utf-8?B?cmMwY05QMm9aT2REVDV0TnFWZ2trQUZxVlZvUG8zYjNRTVpJcTJUbGxBNU05?=
 =?utf-8?B?ck5yd2lrWUQwaCtTbHV0WGE5QTVSN3dMRHIyU2puNmx1bzhCN0xJdFdPTDFv?=
 =?utf-8?B?M0VXSkZicGo0cmhZUmZLenMyVUlwTXcvNm9yemtVOHVaNkdVVlgzZzQ0djJ3?=
 =?utf-8?B?cVg2RHMyeGVUclU2ZHR3WkNLaFlpV0s5Q2dLbVhsWG5lcVdFTS8zWVRQbjl6?=
 =?utf-8?B?UncvVW54cVNYRkVUSWhjM2V1K3IrOG83TUNnYTE5QURXVFlMVDVKL3E2KzZF?=
 =?utf-8?B?UEt2UnB4Y2Vtd29PeVlnakJiQkxQa3J3MFArQUFEVElpTitTVEU3ckIreThB?=
 =?utf-8?B?OExoeWJ5b1pjNlJNYkpRVlcyRDdwZ00zSzNwUHRsbkdPaVNPOHRCMUNWYzd5?=
 =?utf-8?B?Y0JDYmdCRHY2bFphbTQ1MW03b05BaitiMGJxTnEvR3FBVmQwWm5WN2ExR2du?=
 =?utf-8?B?eUN6Lyt4WXBDTjZ5ZURoYkR0S016cDlyOFFSOERobWdEZnB6M2t3S2J2YnZt?=
 =?utf-8?B?UHlnUHVpcE9qNXZTNk56b3E0U09FbjBEMnQvT25SVElmZ04wZVliOG9kMFJM?=
 =?utf-8?B?UVZNNFBkUithRjZHVjJMRU9KQ2FKdHhZQXRQNGRCT3NuNFpZUFZ4V3IrNjhz?=
 =?utf-8?Q?bQcwRZbVnk6g9iDXQn0DHcX8O9cER1zvjs/2I?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b1d168-691f-4d74-3c15-08df19ad181c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 19:58:53.7167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vLQSJR+xUKcQDiT7u8UscAt3V6hFD+Eo0iAtibNBvetMBLCG/WIz/1XOOcE9Ufviy8fA/dlmRfW/l+tYFBKvYZjgjJcMmqjpNkQYwHD8saJe1TNrCHmwatkYWcOILa9i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7552

From: Frank Li <Frank.Li@nxp.com>


On Tue, 15 Sep 2026 22:14:10 +0200, Francesco Dolcini wrote:
> gpio3's gpio-line-names has "SLEEP#" instead of "SMARC_SLEEP#" for the
> SMARC SLEEP# connector signal, while the gpio-keys node driven by the
> very same GPIO line already labels it "SMARC_SLEEP#", and the imx95
> Toradex SMARC variant names the equivalent line "SMARC_SLEEP#" too.
> 
> GPIO line names are meant to be stable across the whole Toradex SMARC
> family, using the official SMARC-connector signal names from the
> SMARC specification and the SoM datasheet's pin assignment table, so
> userspace GPIO tooling that looks up a line by name works the same on
> any Toradex SMARC board.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: freescale: imx8mp-toradex-smarc: fix SMARC_SLEEP# gpio-line-names typo
      commit: 90bc5a53c7f0733ec37a5c041b4e1aefa3d8d965

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
