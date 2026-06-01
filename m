Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013012.outbound.protection.outlook.com [40.107.162.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A024194A6C;
	Mon,  1 Jun 2026 21:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347842; cv=fail; b=tWVdEvFTWFyLwcarszDj68JFOn1iTeJNTVVycnTspbuDuLe/IRYqyM0UuCiDlKY/rdeB8PXDvT/zggV5XbkypVQ6pnqLtAG1eNL9Gf0nCu9srWp1Tk1V9qxrmVSaTTiD9fu3hvrrL/18zDGCtRYaYDPNFfZhdkuyO1WgOPydzOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347842; c=relaxed/simple;
	bh=4zDKudiuYQO/NGbYTiWGLsv/6NDwkESUUnQwEi3HpdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EO55+56HfBsTfjyOUeaYE6OI6VOu5sTfMc3DNsuUhNUhOZpXTqnHuKx8e8Licz/5PjxSRq9gNecByx4QckpyU5nbR+abZFaghhArIg1KNjSKWa3jtSkuZaTj5KDANlQdDfP2jHfQDjX6O6EA9/63l9oUykrKbD5U1rLRWxpjw78=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=HIMX/AGS; arc=fail smtp.client-ip=40.107.162.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HIMX/AGS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qb71uT3GBC+CL+n1sLhZX0V4MF7d2KWcvQheRhE7exGnanV57ubpvHkRcDQD5yM/8tm/jhE3RhMH3/h8b6xMDy5ZdBQoyVxMMnSDUNXRt77oxQcRp2icspJzxZU2cI/Ly9SNiZXuBIFz93+6faeq3nTTfpBbp5MzfUIVHHqQwe7Pzq5D5ZztKrP/hrHBymBdxjTyr4n/tyPsNwXXLSbq3SWwNatctcjQVU2lgBnCb9/rQlcL3quOwDb2J/gUb7SsY8eEriHcgiHuoKoKk6zZc3SLPWfjOfmNM/S91maeBRXOKg8sGFVlfjkV/VP24/1j+pLgxNGBNxH6GUNsraicPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nslvE/JwldPBYVw3KdaCFrfBxLVcgwqeOy34asEZtZo=;
 b=nrJb0Nsw11JW1xcnNlY8wA0anCokHYQHSdi10yOAxRvwq+Sc18DKpULJoCXVI6gEiQ3EvGifzWvTRVNf0krlV9t527U9BvYapp8dLALIrpLlVq63xNrckaZjEufe8rOpA7ngtbp5TN/I+xQhe9d1MwKys2MvesNbG1ohfW2y8NsdTEKFrHlmhq2/kO/Msv+chZwZqQHxe+PjBgYQPF1Fn/bvwf6kmMvVHHpmp+I8LuIUMmNng5unyC8EEa/8Wql7Mi5FvzOQiWI7QS8gCjykUiA7xGv4W/25u+1/K1ImTaYfdMTJI6ajNsV6WPSu3qeqr79wqnKvzgO5qbYB9UHfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nslvE/JwldPBYVw3KdaCFrfBxLVcgwqeOy34asEZtZo=;
 b=HIMX/AGSVBekr1073cVJB5fdL1QMHVlC+GMCwe7Zoh6FJvhOSvcCjWg1AZnShAFsf0GndDoh6fvrGBPJNJDO7godX7a5W0QlTvLl/ouFjtzXO50PxHPVcyEaxRnu8K5Aq6vDs464nPLgr7PKFjLAXZlyOVognb/4G9quLSpAajwI4gvdal54MMn8bwdC06R6jyBPoXpR6Eq3uFLaTdh3G/e6gFL9yptvNPUjb2/glGQwPSg3Rzk0Q02HfwkPH9WGNcbYEWDMeMAz/KfaU7NPRMK/SXhf3kLZ/+HzXxMa3/BX9aeop4LXBAPWxlqeno8ZcYp/4zvams4DGrbbfwypmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI0PR04MB12079.eurprd04.prod.outlook.com (2603:10a6:800:310::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 21:03:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 21:03:58 +0000
From: Frank.Li@oss.nxp.com
To: Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: s32g3: Fix SWT8 watchdog address
Date: Mon,  1 Jun 2026 17:03:50 -0400
Message-ID: <178034782710.586600.17914400551362692167.b4-ty@b4>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260528120323.46287-2-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260528120323.46287-2-krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH8P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:348::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI0PR04MB12079:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a3d6441-060b-4a1c-66c2-08dec0214c5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|7416014|376014|921020|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	Gf4mKerwv+IGWQwjqwnR5kI2ZgkvL28iGmKRAQcrX4sjiVPyUyT6zVz2jhL5z6QP2sB7vPZsTBv94wvqFZDoBmmb3OsY6qDJuc0ltgN81cuaaMaSGf65KjzKXzxJcGfF2oTNIrX7GANxFYOl+YBtxQSxGnLB/a5q/CdmshFVO1+UbJj2b7sCL1UG5CaT5eiTb/mgsVWfDenu3pAsHTKFui4+hiHH2YqORh8GepWsv30kI7wAbvZy8tH5MhVPUBQsiAqPbsdJagc6hEhbf7LSFSiJeTO+YnKmT+7N6YFaNlsoHvpG1PAgmiZdpY8Z/wMFBpiSUtPDt0ScK1bWeGtua/RCtyCxRujaUkIHiYwj8s8vALeTo3yLa3QXdaspnXMDGv0Cw7VHgTEsDRVpaO/IDuOotO43+L4LpvJEs+IKBsv+TMqy4ZE7u/geoc7mhkEcOyA91AJEN0ZjDkK5tDQKuvjURvznxMnaNGHlVGAIxgOYdJYERmSIe3vWb/8/mAEXOLfuzy3NZ5v94jS0A9C6xorCRdAPKA7tYGWcR61r9UVYqeREMpBFxiCSPzOzVoHk4G7hoS6tzEWhhbNMqxrlNCKsuMGFw75yEtOJ5s1Ti3gXCwgesvyH5iG2aNblMHhU0daojq18GTQ2fIt5y3LAm1FeZuzh2tm9XYYJl58TvLqd/6tPZ/p7n9ydkcw2+moJv7iAC+0tAtDluswpBBS6cOD8fsjf3Q7RZFJVuj1CH28=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(921020)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RW1Fc0hqUUY5QjZkVWZxeTcvSDFIdGVkNkxmckpoMjJ3dWtmS2U0c0sveUoy?=
 =?utf-8?B?Y3dpY21kdEVHY2NrKzUxMFJ5eGFXT1lpa0lwaUVETFBjMHFYTnBYYm9ISExY?=
 =?utf-8?B?TVFhV1pnUEwxcXJzSFAwb2lnanJIWXRXNlc4Q0IvUFJYZGV5YmZUMGJWNHhS?=
 =?utf-8?B?THZJSTE3MVNuODFCZmhZU0lhZGI2ZGdsb0pFT3pGbEZTSk9LM2xRM1lBbUR4?=
 =?utf-8?B?RDREVFBJQkZHR3o5aG9jOHl4dk1RUk52ZVU4KzVDQVhaZzZPR3hubFo5SGpp?=
 =?utf-8?B?bG5UQ0hzY255U3NZVGlrbnRrUFFEZy9JcWNYRitnbDlOa05va1I1OC82SW5Z?=
 =?utf-8?B?aE4rL3g0MTg0bk5xMGVHRnFIdGh3STA1VldKWk95YldxdnRNbDN2UU9HQ3BO?=
 =?utf-8?B?NjRieEg1TjVCZmNBNXh5S05tUnZlbzY0K2ZIV3BzWW1LREVaaWpiOFF5elJN?=
 =?utf-8?B?UnYzU3ltdzhUOXkxV1pWajd2TFRhQW5ITmtsYy9pSlM2QkJyV2tmRVhvdE5v?=
 =?utf-8?B?Nm85bHQ3T3RmQlk3cW96UUU0UWhGOCsxS0VCQjB6LzdZYks3V283eDltcHd1?=
 =?utf-8?B?bGEzR1VsUVl0bTFvSWVrN0dKTFVqM3JhWUpSaXpvQ0hRc3hrYW13NjdoTWtZ?=
 =?utf-8?B?T2RrcDF0Z2ZMYkh0c2FqVWlDRGJPZjFWUmpTVFptWVlWLzVycFlGM3JNOUFO?=
 =?utf-8?B?aGdlLzlwMDNnRUZOM1NWWW5CL1pYWWFLUWNhUnJobWpacUVVeHNJaytmUkhC?=
 =?utf-8?B?SW9PSkRDZENndHZMc00xY3hxanl4alJkcjAxdUs5SW4wc3poeXorZWxwTzhD?=
 =?utf-8?B?S09Takh5SXRSb1pPNnBNRTJXcjZhejJ1VW5aVmlNMnY5ZGNlbkdZTG1JOFIr?=
 =?utf-8?B?U0NQeUV3ZTZrNGpyRnFKRFE0QzJvSE41aWVFZUhLbXA0QVZ0elIxTmEvWGt5?=
 =?utf-8?B?Q0lPNFdBQ1h3czFKL0RCSHcvWmgrZlprRVQzUEdYRkhhNlE1ZmkrMTY3OGNu?=
 =?utf-8?B?N1A5ZzFNUHUxczcvUENDSzExcWtIMlVnRkJIdnZkZ0luZjJEWXlTSHQ4ZkFP?=
 =?utf-8?B?MTJ4andCbTFMWmRoYlhnRCtINWVJK3Y2THAvaFRDa1ZqVkE1UkFxYVpQQkp1?=
 =?utf-8?B?cU5FeHAxWCtjcElRSmtXdm0ySGRhaDVyRE96QTA1T0l5M2FnUVErVmlGeG1X?=
 =?utf-8?B?ZE1jUlIraEZna3ZyMGY5MFR5dWpZcUYwUDFvRnlNNjJ1WDZiREJNTVJTaXZh?=
 =?utf-8?B?dnhBaDJkdmIybXNiSUplZVVROFFFelJtR0xkamg3NlI0eDR2czRyNGFneXhv?=
 =?utf-8?B?UWRQdTJnbXl5b3RBbWQrcGh2VWh1bFpuaEczeG5PdTdzd2lseTZPVWhpQk9H?=
 =?utf-8?B?VEp4eENNUnA1QTZGMnFQYVJXVE5SbEUvRHlOaXNpc1dZZnNhQ1hMUys3aHho?=
 =?utf-8?B?VzFhWkxVWEtUSHRMejN2VEY3Y3lFb2pnemlrYUt0clJ1L2ROREdGc2JqazRF?=
 =?utf-8?B?RXo4S0gxV1BZd2d4dWZhNzRyMmFGWGRyMnVQaDduaGorUTRIWW15dUk4a1dz?=
 =?utf-8?B?QXpuSUJmVE9mZFBUbGpzTFl1SjhnTXB3OEV5cjZwSmRVOGF3enNPZWtlaUIv?=
 =?utf-8?B?TkpkZVNrdmdsRWE2bnpkS1M3aTJTWTB6YzVFZ0pWVWwvNnNWU0lBRnBpVWt1?=
 =?utf-8?B?YUhzaGtubEhCajlndW1RQWU2VHNVdmVnV2U5WUhPbmVVQ1MrTzdjQmJZMERC?=
 =?utf-8?B?bmlUSXcvc1cyTjJIeFVXb1E0bndJVmZxOVRBUDFRZ3g5NEcwcnViVjk1Syt0?=
 =?utf-8?B?dUx4NkNlOHhiSHdERy9CMVpQL1VqSzVFWWhwR0NLRE5oUTd0cHhlUm5uQ0xV?=
 =?utf-8?B?MW9aMkk0THB5c3ZURTVtTm9jVmNKb1RVUkVnbG5zZjk5YVA4SWdHa09xcUFU?=
 =?utf-8?B?VHhyZ2tUQ3pmYVZsdkxOWW1EeUNhMzM3QUd6ZFFqMUNJQkJCRjdWcmgwdVll?=
 =?utf-8?B?WW13MXVEdDlNK3YwNllCMFlCdHREMlRwSFA5NWNIU2lpbWltV01sL3BhVFdR?=
 =?utf-8?B?MTlVaHhBamxtUy83ZjlBL0JLNmRRUnJrcnl0YWplbHMvVGxHdmJmMTlsTlI4?=
 =?utf-8?B?UnpQMXlXU3lzR1JpWnQwK3RKUTFQWGRsYWMvYXA5eW5VMCtxSlExbEdTd2hj?=
 =?utf-8?B?VElqemFpWkFEa3B3c05uOURyOGlzb09vL25NVUdKNkt5bjh3bXN3QUVCU1FJ?=
 =?utf-8?B?OFhlZDIvNXBRZFpqUnJuYy9kYWFUREw5dUI4OWlPOGxhZ0pUcUZxSnFISTN6?=
 =?utf-8?B?VWUyd3AxMXRnVENzQjVlZVk4Z3BKYWtDV3hHVXdMNEgyUXRQUFZReDNtUGY3?=
 =?utf-8?Q?Ux0ZmDR+XQ4zFKzg=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3d6441-060b-4a1c-66c2-08dec0214c5f
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 21:03:58.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdI2pozTasWVLsTym5ekneQ/0ckl0srG3FmE3j10x2hRYFBvz0v7sZDQaDZCPr3h7J34me9hkzI0nfybvINWkPw7Gt39M14JrxQTE8IegUGs0oCprhZK3yMRBRv4hDqr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12079

From: Frank Li <Frank.Li@nxp.com>


On Thu, 28 May 2026 14:03:24 +0200, Krzysztof Kozlowski wrote:
> Add missing hex annotation to fix the SWT8 watchdog address in 'reg'
> property, as reported by dtc W=1:
> 
>   s32g3.dtsi:863.27-869.5: Warning (simple_bus_reg): /soc@0/watchdog@40500000: simple-bus unit address format error, expected "269fb20"
> 
> Lack of hex '0x' meant address would be interpreted as decimal thus
> completely different value used as this device MMIO.  If device was
> enabled this could lead to corruption of other device address space and
> broken boot.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: s32g3: Fix SWT8 watchdog address
      commit: 34faa9fbda5cc78479851fcd94f3b94f91b0cd84

Best regards,
-- 
Frank Li <Frank.Li@nxp.com>
