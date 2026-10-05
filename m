Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0286377566;
	Mon,  5 Oct 2026 07:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186160; cv=fail; b=ksDfiaG61YOaV9R/vJl9g3D+F29JAyJLtctsem+3rUjOlvnWs9N4ADJ99ZUzsan7waVAcrBUmkUHo+Tki506jfoagUFq8jllRtZIaDAW7B58Ed1Y9vFnvOvPYpF66i2/u07ZAIDHYSbDvGBus9ll43KXLzghjrpRu53/l6L7JWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186160; c=relaxed/simple;
	bh=K/cSo5mU5j1aHoOrEKnue4Qea0FXan6+QwYD/QF/p2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K9ScVBC8GXgFEdlVbC1AwamvmXpUS7HfMWsMl5FtoM5ZE//OSh2dU8XeMka48BMahOM1WgjfOCZGrFEyCBWzuyk97SdGxxPWGwNear5pjqaucXLjKGc/uBtcmdEIRbDmnfxWot3PEDqhIKAnV8e2PTFvkzAqzCm0cJGltXAIFEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=adRTCQiO; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="adRTCQiO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vu1zmaFgPo5hl5+XX3IaUIXB5+SOYPvN9KkM3gcLDL49SV1hH+ZeYcluRXPpBFrgRUylVAnyTPbtAIHA8urb9wa8PqaWRK1VnMqjFsokb0yRcRemTE942jl0tY88MN7CQKCa2bHOVXYYQVfUAZn4cH6QAlGr9MvdmU7JFtzh2GPEV+sIuX44mKJrmFAQZTodkErIkqMgRUL8HlOIbrf8miAiTTmoh+C/7x9oRWIglIwniivwQzMmokV5vsK7F3SHaHYhfkHGo01vjhNz77iS5JL7pjVd1UeQhH88hBHyboTLW4eYz4xpTxAA0QMk7ULIs/PMH0zridhzQtMYeIZJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w5/CyqPDHFv9k833HKPRS8bi1AHq+mPPfrQ8UHfbBvw=;
 b=ZtoimnL6U+JthaSHdrSbgOuvCh1j/XNDwEHIEt//1cdnLRSg3ty29QP2/zL8XRhV8C0EWPcTUuE2dmVvfWcyRvzFxldOSk862DDTX15Iv+6SM/nDWbLLztxMBYtnLaW1rlRxo0jHqFQE2rUmnYGKPt7lyznx1p4LGtobyxSAW3mpQ4a8F6REcEb9fHD98kFYHiB5WXJO6vaQ/V5U2apYxiM+qX5tyavbDPDJwM47kcmgD7U+SIEN7F1rzTijQBfUFfqgo7+NWbekDZ1yvZ+FlZrS1FtBM4lORAc6DdSZUfOcMDDMjBQ9548ULiaxKppjW6ZflXGNGC47yWtMsc2DbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w5/CyqPDHFv9k833HKPRS8bi1AHq+mPPfrQ8UHfbBvw=;
 b=adRTCQiO3/fEzgzK5MgxW+yBjjDKMnxnC8/+KUt7iEI2z9UW5B63N7m5pplmrIN6o9ZIVnyXmcdjSYvsC9KloWKM/juzv8Wdtpe4OlUongqvYMku+oid1pnbAHagAKBkzrR6lQWe+nGfluYxtvyMS3gYc2416wcNDFqNYo9rQ3mfOjKsMZMIEgzCY2gJnGAhB6TGZR17OfyPbn6JPQzwBlNjkxQhDidKgys/BebidUxhIr2Zw84gfov0coo2sg1IYBV06a/TOuUDX80ib8mj0oHwsKV+Ihsg9iEFElzsN8XrNHraI1ryr6waK3v10/jrFj7HJxMN5u3LGvcw/jYYzw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17) by AM7PR04MB7128.eurprd04.prod.outlook.com
 (2603:10a6:20b:11c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 07:42:35 +0000
Received: from MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8]) by MI9PR04MB019273.eurprd04.prod.outlook.com
 ([fe80::263c:943a:dcb0:29d8%5]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 07:42:35 +0000
Date: Mon, 5 Oct 2026 10:42:32 +0300
From: Ioana Ciornei <ioana.ciornei@nxp.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Christophe Leroy <chleroy@kernel.org>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
	Ijae Kim <ae878000@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] soc: fsl: dpio: Fix IRQ cleanup during probe and
 removal
Message-ID: <o7tb5a7mvte2cmfdlk3hdprricdvo7gv4v34wq6iudx3t7dnjj@vhbf3df7smyi>
References: <20261002194802.375497-1-mhun512@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002194802.375497-1-mhun512@gmail.com>
X-ClientProxiedBy: FR3P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::13) To MI9PR04MB019273.eurprd04.prod.outlook.com
 (2603:10a6:290:d3::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI9PR04MB019273:EE_|AM7PR04MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: ff50e5a4-1297-48bf-8773-08df22b438e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|23010399003|1800799024|366016|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Wmb1rvTEkCwzGJVhPUyYNSKekZ852vfpEI2ywbVinY+D56NpGB2lXrQNLEca7WyStXXdp1S0XmLvtGjkCOqcXOCpmMBeTx0fU7SCR5ZBEH0hIuCCzDKaZbgJmdsOXtEfJNaosUwgmRzayh6CytbuY99DMvsgViT9c6SawysHCZo53t4HDJp3D1eFEw0mhyMPoQ1gPNcEGSf8YtZzo2AqhRo4o/iwxyWEx2OPzvednPp3xnX977O/feWwY1YxYp2epUYTfjtlxDFBlomADXcm5Xq7+tY4eZhv8Xo2RwDAH/HKoFUPBDzhROPgRWdklWg3YIVzgk7TPKz7XeESAJWAhcn31xGcF4YRGKOuX8uMNaRylbzU2+ABEZyB+uMynKCBl11bwyexyiJAyeOeckhLf2gay+l6ts8O2LbrSBEYy9Sai5Wd3U5znI7Fv4rcofBbv05GnISw0YFq7F9IN37xHpf0gLkqeo1QKhUZtKz2HqjD02PTH54OaiAnECfmWwNil5LVUQ0gRu7pk+cTvTeDvbvvXhq2Y3xIcq0MIEj5O/5DZg77vuQSoo1cPGWfhXZa7tjuhneDpYB906ko5008XJQYloOmUWPtVVkfVpLUzGlNKbibP74Xwwx+xBZ+ZpSRNtpyy9YdD2kaMnxtX6SRvzAK0KrPGIa39EGYL/rr/SM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI9PR04MB019273.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(23010399003)(1800799024)(366016)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GoWAzopSrRy5H1LAIEfbub1L6YiQu884uMYjMCvmmDAA4VUgZ7gGZqJB0/9K?=
 =?us-ascii?Q?kwQUKwiLxEcfMBZfpxK41gdbGO4lL2HuKtkg2enK3hIJkXdFB9a+YqnBqzFT?=
 =?us-ascii?Q?Y8y9GKJCYv91s5tKiTwqMbnedoIZ1GLfOhBYKvQJ6z4tivJtvzrGO23RZN1e?=
 =?us-ascii?Q?PFVoXetlDN5FJuAwGQzNsxzrnoGAp94+2H8aa+eAIPOQd+NKt0INXwyeeoj7?=
 =?us-ascii?Q?ADYT9mvK1rMVOyJo24AlNVitiA09eSS3u5U4ROKwJp90hMa2we4/qkfRoWSP?=
 =?us-ascii?Q?rtuvwU37Vz4Dltc2U80vmXk+9prGso8uEJ+BO/odk86fvCo4tjWmgKCGJ5im?=
 =?us-ascii?Q?5fvilrXohj6xUqasnmo0vpduhPPt/pY7EHlF/kZ7s++hBgMxgoVN98wQU4Lo?=
 =?us-ascii?Q?Hcnb8VhOOJyDa2f+5eEOtoRu5XLaQLHxlLf3pldhQEEH2VRIkdMBPcNF0zq7?=
 =?us-ascii?Q?qBza2/IJiARIMe3D8KWX6B0Zu+0eSjMKm6pAXOczqohb/XH0D6x10P/cY2Km?=
 =?us-ascii?Q?I8ngBCqDY1q6Kzc0E+c05g4ufTCjX9sOT3oOduJRfHgcgzRSwNAZBFj7J6EL?=
 =?us-ascii?Q?icIhhHywghoKzQ/7vdy9/dt39IlXA3HUghzZyV6tQdteaIQCyDCQHeagSj9W?=
 =?us-ascii?Q?oIVVI20PVexW6axAPfZZdOZPXq4W5LjPTIYWpjtQ7qclx3Hu1VP9lgtbWSlE?=
 =?us-ascii?Q?Fsh/iRFAxnTsXR+H7BxHwxez9/lSugRxhgraY3w21iCqLm4+9cP5e3W1QPZc?=
 =?us-ascii?Q?Yy9UeqcdatTJIwEu8nGb02SkzGbVw57rzvHr+kOGlHNmdfWPmXF2COEcg9CE?=
 =?us-ascii?Q?FbaxmqSgt43BACkfWH3W9k3OaBoNwApdoFG5UaGv1zOFVurg5gIIUmtADC64?=
 =?us-ascii?Q?GlEkkTBDidtdWuf+gkbfp/oEOKbs7AsE0w/B4jaeCU8V42PulMZU6eqVuVCc?=
 =?us-ascii?Q?NKCP/Dr00DJ2SEicPLL3lGJdFtQJI+Skhp2T5R0+2xVdCkFdu8VtT5PwSruF?=
 =?us-ascii?Q?Lkv2C5Z6vUUI1s2L6rR2hjZbrinQ7ekXnLzYHPT2zoqHeFyaGS9V/SB04Zde?=
 =?us-ascii?Q?v8vCNo+WPdYk/JqyMqCM3gnkcfTxQ6unZO6Mvf+wONoBWTdrPqZ1bVmwZKyJ?=
 =?us-ascii?Q?sIWm++cCthe+CPT6rKWJTbtRNdmF4UdfWSfzM5Af/gMjrCunUI7Ie533ol+h?=
 =?us-ascii?Q?64TFvUEABS7Byo/B7/fySoxe9DvOH2FTEQF/a0vBvYCu+g4FngUpyY7eJdk9?=
 =?us-ascii?Q?0inUXwKL8/VaXv1ymLYT3FYgviDpF0EEa2cwnsr+xXFek3XiQiZExNCV5+zB?=
 =?us-ascii?Q?mazSwYMrlRZzXm9kKtC3gtbXxp9wVupoSvXFT6Sgtffjemb9M1nmRaFwr0Zc?=
 =?us-ascii?Q?qIBMLeGnFGSolrM5O/CdrR1b6THjUnoIV8UzixcTop8EGVeO/RAPUjJonYGi?=
 =?us-ascii?Q?Fep9E4U+BMmp/QNf7F/YVwnPHlRG2gCcLrIiwAXMplA98cSbcSI3tQploOiy?=
 =?us-ascii?Q?UULuH7mNdpqvpQeHOadNeV/q/lsdYBtIVbRltO0xm3CBBpg5eMj8hkKGKJ90?=
 =?us-ascii?Q?APFk6i350deSGLEljdPsk1BiTgxS5GQv1NkdejfPZsng0xC2hEydRvi9Ea3Y?=
 =?us-ascii?Q?SrfEez2/Bv0dXXc9XME3OVg1zfydg92ccBlNcKxf3YldPFbW7AcDteLY6LF8?=
 =?us-ascii?Q?5gf5/CpceO8huo9umeSvpgCJWMQGF0kjQrmXt1PrVX4KoEhbZlRQOZ746Y3w?=
 =?us-ascii?Q?9cE/5L6ohQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff50e5a4-1297-48bf-8773-08df22b438e3
X-MS-Exchange-CrossTenant-AuthSource: MI9PR04MB019273.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 07:42:35.5488
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wC0wPftgPttbwE7+oUtCX70bNfKFvwl3XkpzkB3bTyHvB88/Twp8fQey4qw/teAgk/LWFYuUqVh3hxaNsAnWsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7128

On Fri, Oct 02, 2026 at 03:48:00PM -0400, Myeonghun Pak wrote:
> This series fixes two DPIO I/O object lifetime issues during probe
> failure and device removal.
> 
> Patch 1 releases the I/O object when IRQ registration fails and removes
> the unnecessary unregister call from the probe error path. Patch 2 frees
> the managed IRQ before returning its resource to the MC pool and before
> releasing the I/O object during removal.
> 
> Both patches carry their respective Fixes tags and are marked for stable
> backporting. Patch 2 is based on patch 1, which removes the probe error
> path call to unregister_dpio_irq_handlers() before that helper starts
> freeing the managed IRQ.
> 

Reviewed-by: Ioana Ciornei <ioana.ciornei@nxp.com>

Thanks!

