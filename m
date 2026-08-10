Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013029.outbound.protection.outlook.com [40.107.162.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFD39792F;
	Mon, 10 Aug 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350600; cv=fail; b=h/Ey2oadiCRy3GxfLAMRMd4dGou+vK/qQn6GwF4b77iYkgqebOyj7Sh0au/xLyNc1q/ZmzBx6lEeg1YYnzqzgEOhiiQW4eVPs/d9U+I/efvopZdVDjb7k/UCI1Xft3JBvp+O9QNQ8ePesLVrr+0H/gaCGH56Opx/n2emd8S5jc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350600; c=relaxed/simple;
	bh=wrjILINt54VJ7dBVSXL/f/AjJRzNig5AJuLfjzm094M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SADXFj4WsmAFzrd2TkEcwvPdBshhqpb6ngmgQguNymHLTRMMOdrb/hnJwoBRSIQTddyiY9iczEpsny4oh9SUqLga4/+AoJ+av+AZvAN3R12cWwfTbrvQshgZKPoJnhDfSuJ0UuGUQxLoYeMdwKw2Ub2eFmK6yleyre79u8Zk9D8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=T6qvuleL; arc=fail smtp.client-ip=40.107.162.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="T6qvuleL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L22SFo9CJClgtcHsYOJbArBEqNp1r2wpTKePEfJfAs5ETdfsK8DVmE7TCLMAMuJMBK3VDtVwIL91q3R1+c39tChgy+8mLElMWXiT0RKWMK9httGjeFpU3MOkj7wRe3Qd0k70Bj1S/SPOlD8390zJYNDEEr8tDgFmc95REXoaAOg65DTD/KeuFOmjQwbBNY6zz9wVG9CA/CAjWayMs2SLdZX54aSbsZwsoGUK2QMFTM9CfvJ3Ablt0Y44ZE0bch59eVoo2OGEQSLBKGLmUle2HQuP7JUTiw1+VJVDgmCGAumrq2G/5ldVDl066odTI60UOYhSyQfcsk5oEAPWwFIevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrjILINt54VJ7dBVSXL/f/AjJRzNig5AJuLfjzm094M=;
 b=W/CD/9qPp3XIj4GT/tDbQavb5xo20NZPVWEf9gsHahJkzq0UPm00WE7+Xb1+Hnse9myPIKAg3lCiq4R/uyP4ni6gXmc9JPJe2GG+fDJamG/SItY/jOkybwPSRhL/Z0g0aqumaQWxY1lvYPRaAbnxmIUT3Y5IywNpmj6CQNPqJfK70O6oIPE0c0Se8MgSqgXrx3X/HnynACVkPek8VG/qDha4u7MgyVYtmo1uSav7f0yyYCDjM3VQcB73G3HMxBRT/hcV8mGA/TDAmsdz2SgIXzGQxAbyT1n4Js9HHIIjZP8L+l1yZaRD3zsPRmZJjB2YX9+eKqAHyCWhaXyt/NI90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrjILINt54VJ7dBVSXL/f/AjJRzNig5AJuLfjzm094M=;
 b=T6qvuleLNT+25HrGb866M8Ia03L+REhTGtOGcfzXtwu/q+aQIxx6FG2HAmynzF1felJqgCOXCKiYENvF3/4lx3rUXQQGMU209m7riwuj1jWpcdXQoM8pnSRAQ2iM/mj4+MQKKNAJtf18pEriOKG/1d+AI+r7HW6iCXnUlMnBkmjvW4wL2WVGvjgW+FqlLL4cSrUNeRRz+StSBvpA/cI2nyRFfyX5kFFs3CzvxVwE47rGsZPXQH0zk5VEPLduaGqqtYIE+V85CehviQy5yY2MPwczzIBzW7ccNr8/GjcO23eSnfL6JhJoRJ4D9ZgPVn8aNIvrMa6OViJkQsHdxtUGfw==
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by AM0PR04MB6964.eurprd04.prod.outlook.com (2603:10a6:208:18a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 08:29:55 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 08:29:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>, Abel Vesa <abelvesa@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>, Frank Li <frank.li@nxp.com>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>,
	Shawn Guo <shawnguo@kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] clk: imx: imx8qxp-lpcg: fix runtime PM cleanup on error
 path
Thread-Topic: [PATCH] clk: imx: imx8qxp-lpcg: fix runtime PM cleanup on error
 path
Thread-Index: AQHdJwxGLcnr0UUR80mflHbdJJQN1raW9p7A
Date: Mon, 10 Aug 2026 08:29:55 +0000
Message-ID:
 <MRWPR04MB12330DF8BEF971E044EDE4A1788DE2@MRWPR04MB12330.eurprd04.prod.outlook.com>
References: <20260808080215.2669452-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808080215.2669452-1-lgs201920130244@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRWPR04MB12330:EE_|AM0PR04MB6964:EE_
x-ms-office365-filtering-correlation-id: 086aed76-7f6e-4cd5-5139-08def6b98ea1
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|19092799006|22082099003|56012099006|11063799006|18002099003|38070700021|10067099003|921020;
x-microsoft-antispam-message-info:
 Jvirk09i8Zb+6m/cEJpUEx3MCnlt5p6vJyjQL42DCk1NulKE/ULICLGTFxjbe0vbuBmXAuoW7L3vtAZb7ZiQpsJlkaRfC0uwrrh0+bJptfsvvx1wIpOHKq/cEBHMkZyel9DIgkTx2aLqbFm0V3Ve6c2Z2ogErI65MHCSNtHh+gtIYcrAFbxTMoxeTDRrCjCCWbeZj44G/lsNrsDL3bnGe6sfz2Rv2bZUkBSBTsjjCGcqLZ4hRRomm330N2TF3GLP3gxR2B2PlF0R6vHxXeAyVfwk8fwOFcvxnjJVkxmLjb8V8JFPXp6JtnQmSIghGW7IaxJiFB9gg/ZMPFOErScOF/Jylc04y+6IaN9rv5nXmT9Pl9L68ZRzKO4R1oepfxdiO+yuiCBQmH09Ge2K2AUSWQGw00+0M/PEFsSEO3H2B4mzK4QNRSAml3TMcfISF1A0xeDlV4kUH4FlkTfndo3eEsNe5zHEB0F4CtbSTFWuNzfTexuIJ8yllJUdv5qFaOAoShipnW25NsAKXA4mBG2NEhgkp5jccM6Xl5YgpiySypcePKFSWsFh99tXAmDOAhLueYZpYU9yfdhe81BL9JSD7FOSyQvljg7HTZ9fByhzGTmTWt9BVyMQjhjqCUQ+YLK2ET0ecJ3LQd4SsPGQSOTMPoydzUwvbayBb3F8plmlJwDUKhq+jQ9gruBb3hUij8jFw8rClrlnNq20gtH+v+jqHtT1YOKM0eHI+WSI4KqH13E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRWPR04MB12330.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(19092799006)(22082099003)(56012099006)(11063799006)(18002099003)(38070700021)(10067099003)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qeYzkUF3vuRHotkyVcgsa9ows1CxRl+ExyLMZW64E2R68J9KqHYbiOdH5Y50?=
 =?us-ascii?Q?tvdHM0AobD8sZStK0nley4tY8HERDx6YJ6aZTKJYfU3pAetZXLnJkY7BPLQH?=
 =?us-ascii?Q?0riuy4Y1yRaZVPZ+p6ce3AQLCvM2Dj13Td4m5JJ0XXzkg3TqwRBPv1XLp6Wg?=
 =?us-ascii?Q?OUPCrliJCm1nYrPajru3gdK8KGoXbguL+u9bs1KQVc4pzWrijnShBFRiGrzD?=
 =?us-ascii?Q?UryZNVrNFpaTEW7Qxs/gNQHkSNgP9ZzFV7F95UWvSkHTeCqI+xHO/45pyw69?=
 =?us-ascii?Q?7FtVV0wn4c4xYwllS6gnI2ei6tmf6fX3ldmad1X7cBkJjudEvZ4GH90Nti/5?=
 =?us-ascii?Q?x7mdbkboJ6h+Xq38MRu839gmCxtoCUzR+J7VZbNhM4rmhQwwLgRFwF8tOyBI?=
 =?us-ascii?Q?/NzpRCj7m+/SYYWCLmMj9rVv7csqXxB4YMCDLspoZzS+IXhovu/EqZ2LCPe8?=
 =?us-ascii?Q?Ju3odd77Yfq35mXRmCkINsr3shpuMv+cRBLyQ2eAu/cCS+IqhmHYYOLjYcDq?=
 =?us-ascii?Q?XNXdZMou3IqlhqDaPsPgZc9CbdsJsjd6Do56glCPrVDLgCCY7vlQLv5Ogn1U?=
 =?us-ascii?Q?onpmAbu7OO65nmHPHOPywNG6gL4IRsq/MsdXx/6pA+u8ftiiClEn7UvsgtFk?=
 =?us-ascii?Q?1cBhOfJgXq9cKrof4CfYLH6gywimr8RtTiPP409NcQFX0B81s/BDJHkRt1tU?=
 =?us-ascii?Q?R6xa2Wq7auGyk8GyMPmdc+qLqBvMHJiL4mPJibeTDm8RzE8VIylSzMOeUSa5?=
 =?us-ascii?Q?F2uGv0wWFnlJtcOI448aiwDigERrP2TgEQlBFCrfQUobYCf2Ogwz4oczmPbx?=
 =?us-ascii?Q?nAFsrjCOZaLOaoouLhQwVp7IfuoL6xZuPezW7GRZCUSABaT4Spe//ubD1OlT?=
 =?us-ascii?Q?cNFP/kGKj4arwQfvCfBgB6OzFXNF+fbBudgWy8h2PPOi4vt4iD527cExPIJe?=
 =?us-ascii?Q?oQHJmEqXVfFdX1hK2nH1/obTZsFNrJMZxUYQ/f9D2RNAFUp9GJ7zfutpcCa1?=
 =?us-ascii?Q?T1lm826AZ3sSjMmTfNDvn3LfYFvG/r9522doRpg+w7Mqanls8vhQYvf/nJSg?=
 =?us-ascii?Q?svmfROutrR8mXJUhbF4uJohwqTVuTM5YC6XJSXor5gs4h01P8EZViKjS4AKb?=
 =?us-ascii?Q?a5lcTJNcGQsLDaFG7jQGp2McpslQlJZdmXFGW540NlegM7d0exRqvW2b+bzB?=
 =?us-ascii?Q?omfuuMBhYR/7cpTdWe1QH/vOn9d+tszg1glfCeLy9ITIj4YuXAqQv04jveRg?=
 =?us-ascii?Q?hsoqYIB2eVEM9BZ27cmMMpdp0jJELP8ctX60YpB2AJA7ZL5S8V8mbfRDHJpz?=
 =?us-ascii?Q?jgrZcZ8LuJwGRynlDm0bt2xzYxw22jaoZ7JT5VX4gFiju3QR93jBXOXFwAfD?=
 =?us-ascii?Q?kHznxIr6UuOj3OmsrxPo9AxLJ5opuAPUl36ki/1f1B5KSVcg6pAWBmIzZOyu?=
 =?us-ascii?Q?dEVb5gDo6gyf9euLRFZ73SkqDLk41WBP/jmnmtyrOQwxa5QNAEL5xJozROAi?=
 =?us-ascii?Q?GuQZQivONbYhL6ZiKjMwCD0Gq6FXmwR4GfT7qYmOm+W3CqK24lxhJTVtfDmo?=
 =?us-ascii?Q?V8NOJ9ZspJnYSPfyNmuM1IBdwvdg+ZfLjNGbvHdETe1cwGAlq3S3MRbAi/At?=
 =?us-ascii?Q?coo3gy2hck0QePMJYks7GKK40eod80r2ISTvGPuqpiq/mRpSYPruprDksMf/?=
 =?us-ascii?Q?TLmvGAmEfEjPTTG4iiWRxXK0NfpK9urzsCJMHiByI3QkgHGd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086aed76-7f6e-4cd5-5139-08def6b98ea1
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 08:29:55.5240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQtNYNWwtTsIkuD63PgZu2J5e3/WnJ1TjvGIDWI+nR8QgFTTPjFol3ApQ+2LL3wEShsCby+sAzOhLZ93bjfQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6964

> Subject: [PATCH] clk: imx: imx8qxp-lpcg: fix runtime PM cleanup on
> error path
>=20
> imx_lpcg_parse_clks_from_dt() takes a runtime PM usage reference
> with
> pm_runtime_get_noresume() and enables autosuspend with
> pm_runtime_use_autosuspend(). The success path drops the usage
> reference with pm_runtime_put_autosuspend(), but the error path only
> disables runtime PM.
>=20
> As a result, the reference taken by pm_runtime_get_noresume()
> remains unbalanced on registration failure. The autosuspend setting is
> also left enabled instead of being undone with
> pm_runtime_dont_use_autosuspend().
>=20
> Add pm_runtime_dont_use_autosuspend() to undo the autosuspend
> setting and pm_runtime_put_noidle() to drop the usage reference on
> the error path.
>=20
> This issue was found by manual code inspection.
>=20
> Fixes: 18cdbad40c6c ("clk: imx: clk-imx8qxp-lpcg: add runtime pm
> support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
