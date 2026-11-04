Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793814153;
	b=HhH/0GcGXBJSFAnHScTdKFrV7gxNuAi3iCctl34C4n1jmyr6TUpD/HDPg9GhIGZz9wV9
	 G8pls413BfYmEy/1YawlwwsO2i5G3R6wP35mFPSJNKVsI8DtXJgc8uxjFGfnwBLm7Keip
	 9RfeQuTKdfRjMapdKSVu2WCTnBJar1XeXRYf22mFjDS6uuJAXVFduL5smtjof4Sn2IKsr
	 QKqEZm7pAQE4DmfNrRY0mnfZnXKhTLn2yNbNLXojin6BOE8FfnCpVbwoQf6kRH8Lk1eQ2
	 ccICZNIfKbBelhTR48hw9kL93ECw4fadeXBYbXk4mUK+WNkubnXN3NAAr1g5BKsCiBA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793814153;
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
	bh=gSRcu9DhSo7woCqDk3it1TU/lXI/lW8eMuQxcQMusAM=;
	b=VgBPbrU5rORp6ur0+KqljIYWIOOZg3rgun31TCmStRlb/gr/jh3qaXsATIrmLrYtKg6r
	 a9MWJUjKC6rTFW9sIBz4pBxm931PTYwmK5bIeoPr+oliX8omno84sKyM8M/FpLGWw8uN4
	 loaDEvjtCZf+Wh0Mt4La7j15U6TOMr0g4uOdq40Jd7jCDA22RDr2pETOIr2iisO365aiY
	 T5p7nEaxId1NP2wpVd74GHK6a5C213RGpYE913jzeBjrv8bcLrQ6fVYoCjPhFYY6SMjGJ
	 cgFIwS4Cmnyzq4kKsmZ0A06I+HfIyjkbfIVwi9ckvTQDLYp5WIDQchhXnF0byhJHpfQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b="eXb2/tqx";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.18
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011018.outbound.protection.outlook.com [40.107.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8E4606A330;
	Wed,  4 Nov 2026 17:42:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D8E4606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=eXb2/tqx
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PsK9X5F3tfo3ujdlk8enRXJ2tVWjZMsMFxCtfUqeH4/Rq2kNH4Pw6aBnDwr+Q/7lBCXmzOediLI0V+wVa7Wg+fPRct1Rajz2Tz/HSWwWL85OIq5YE2jRIxzqhRpPkOB+ubCHzId+8RKgVxhYDcHE2DA5Nczq7Afc2nUIf2b7muDr9xR8Uc+eO9KBS893YXHlbFVCefw9p9xHB/cf3/0j/C8zkMZzhBNUoW0CU5JNGsPW2RI2q+8azoQH35CajrtMb728Ve3rhtOxytxbZDyBa3ptYxM0++HPAkN4avcbecsYfYZCmMcZfZwu68pQjoQno766LB2mhylZPlYHWbZ7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSRcu9DhSo7woCqDk3it1TU/lXI/lW8eMuQxcQMusAM=;
 b=cId671k0+0lFfNGa6mccAnjI4jqwXi/GNUjPdtavkrzIUdkxiNTNiwz9HqcFiFqM6fvEUgV5ck54S8FP4WgqW3UM2IPM2xtbp68RW8OAHtEgXQ5VAht/fzYaw8Gsj1600Gyv7lCf4Fcp1D6xsLNeggANXa1gRXpje3HgM66PA0cAhJRhaP9cRr23MBt3joKvboBygO34ldV/QyHeA4xFjTNTljoqfw6fl/ZBLJg1ISn52qMWVFCK/N1jQjSA9e3gq8DLV97wVzcTJ4DZrQ1qamLhEu8o81CRku93VbhxIJV0gCFsYF1ZGh7KxKHbAf7uLUHi7sWQwyqvNR9AFEzHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSRcu9DhSo7woCqDk3it1TU/lXI/lW8eMuQxcQMusAM=;
 b=eXb2/tqxCEdHXz07ZGgKAc2FcP+p93ce/sEoyjYBeckAGr4ujBNMX0F84T7NA5IzyfAptZDPfzQw9aFajSZEFZhzpZuz49feMvuI8t/xatLrysG7drNib3MJA7KdFFx6kjJadmhiN+yqAi8+cavKT0pGAMrLt2e0v/O1vMfbdWvJH9SrtlrY2pAcylWrqvn8mEzm6aRCHWRV4lfh1MJW7bGaSpUXTkc8fQFdkfqrM+J4usWKNhTgjavU0u1P8NSY3XzPF75QY719Z/E0E3Iu/XRU/3UxnO/3gBX6qOr4vjXUXxHSnW4PjS5J9qOlLSOGLUbmzmGUytKn6+UPWnCKkw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB7490.eurprd04.prod.outlook.com (2603:10a6:20b:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 17:42:29 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 17:42:29 +0000
Date: Wed, 4 Nov 2026 11:42:19 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Tony Lindgren <tony@atomide.com>, Daniel Mack <zonque@gmail.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Julien Panis <jpanis@baylibre.com>, "Mendez, Judith" <jm@ti.com>,
	"Francis, Sebin" <sebin.francis@ti.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] dmaengine: ti: cppi41: Use td_queue to restore
 DMA_TDFDQ
Message-ID: <autue--8pip-cNQk@SMW015318>
References: <20261103-v7-3-topic-am335lpm-cppi41-v1-0-d7213446c5f5@baylibre.com>
 <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-v7-3-topic-am335lpm-cppi41-v1-1-d7213446c5f5@baylibre.com>
X-ClientProxiedBy: PH8P221CA0038.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:346::9) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 50a0cee9-fbc1-42f6-c9f3-08df3a9aff6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|19092799006|261022105027099003|11063799006|4143699003|56012099006|261009223027099003|261028144727099003|261026121527099003|261026140227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	URZmQ8+c/3eqlJMkPajBTFDcoQvgtWvyYODIf2sUTGePsZK/mgp0k7ixbh5RZoK6ZQnqhVGlYKDhZ0UlVH/ZcuhNgW8DYwgjJ9a019PU6XqVFuvyOjWotjhc1dsJmt1A7dlkdU06VmTFY0sd3IrXgOS/wMMtu9thzwswLS13Dk71VaGtYnifxRkSU0b3FYD9eZhwfr1tIhLY0fXy5wG+P/jJ3l5Qc9XpH+SMxIJYt0wLlYdYbzAfq5iW9e+BtbJ8Sj7vxfcMBXuIK897rrO/lPvbNX1GbsVJ5wFnVvZZuDXX0apJe2oMcxX0f3clhX8UiFozf+83o+yjg3Y3cXgj8W2DwlUPcTtVmAimVdCMAo98b6pi+YeHnNpr8Kj2B7vH8WF5oCjg1XTxZljg5NMtV82YwK/DZkMN7tk5LU8BHZ1Qx1qhLt8+M5ML4HO/CD5Tb6FffAJel7ZCr8pX4kI5bZACTuQ3cEmuRxTBpqmrCgKiRmMgR5VcCxlgt0ZjOimW8x7gtETjRGp40JWcZhumW3U0fzGkIOKBHNfrDaI/mNxmIdFJYwQqbHQTmeFUfWbo87jWFOfkzlvZZY1ka9zATUPZEkrYQlTzDAr/htbHigGa9wm0azFSYebfBf+LFhL5ZX+s0vDiRCjIDacbKvt1KkDe2YThAPsWu3J1pSgyJOE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(19092799006)(261022105027099003)(11063799006)(4143699003)(56012099006)(261009223027099003)(261028144727099003)(261026121527099003)(261026140227099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4xDMaXivvzGEG0e8d1lxaSgn/FGg+89s1k3CqBcl8kuhR1hH2S8eqDu3csDb?=
 =?us-ascii?Q?22mXuWHrhyhJQVDvzAeTBpTEAMwQt2HDHUmDpbx+nmasaagXLAO1lX3mk1Sb?=
 =?us-ascii?Q?nAJ0jdsMC3rTwE/d6kHSqkAgKBzeTqFJdl67fbzRxAZEhIYNFdTqS88hDe82?=
 =?us-ascii?Q?v/SMDG5hLgD4yyPxkp7D1MMqB4FABcIVbuQn14vT19ilpw/1PtbVov34XP4B?=
 =?us-ascii?Q?nE+AF2QnvYwWSWSM/8ABHnYBuVcj/1/A57K6G7NZeaG7wk79EKjU4vRihw2E?=
 =?us-ascii?Q?t5mMaFcVc0Y9g566RODjaT4hYGzNgOq1TtJTQxOvUhVJqOislGvfR+lgNVtU?=
 =?us-ascii?Q?xuy9ZG1TeuUTRdvwf1RG1r8iCS1KzrBKa49nXoysldeCRnhOCLvuA/I9er4P?=
 =?us-ascii?Q?j/5u+og8A7w3ViQ+cKvbuLpU/0TUD3mEJKtrnZ5uWxH3DtGz75XrLSsZ1pF6?=
 =?us-ascii?Q?ZRopLBKjeVYKNd8sBd6GDlYPwQ3Tgih0Y0Ge9Ji33RbbOmSLhlmRaEVMi7yZ?=
 =?us-ascii?Q?JIoFuQjJ7F8ne9XCLLAjMZIo4wRb9VMcdw2ocIoqsnr2CIjuBhlQgbGj4d2l?=
 =?us-ascii?Q?++RH6lIrM4Ke9OgAxCsUcf+7CvDx0zmIzM1r+EOHTFJJBwwrHIvdw/hZLlTR?=
 =?us-ascii?Q?z79Pxk3hyzqfcL7I+ExJcg6TenHDSBYGA1So7MxazsICGzELboGUl3cmSI0m?=
 =?us-ascii?Q?VGWdWIzc+3/aCaWWktDFrfzooZHOV2DUikGxZOVOLzmavzsJ3RXsRHAu/YCo?=
 =?us-ascii?Q?ZNO1uM1qRuT4VbJzlneyFLeBMPOyyMV7xfxNTh7v3038emTBdQ6lxfraLe3Z?=
 =?us-ascii?Q?8Kb/gSqna0AJW5Ae3WmhuClEBl2uNYe2AG1p2amkJ689ubbM6zymWkDBzC3a?=
 =?us-ascii?Q?o0svBKQ+QVwatWRoe9hEywkU+EWXynu/WN4zKQ8EL6f0Zpf0JnZLsFrcPbyu?=
 =?us-ascii?Q?oTVBgqszn+Cc6LfpF4YKasZzrLrFEdBhpAg6MhyUQE54KkeEaS6dFLV9SQsy?=
 =?us-ascii?Q?uzktIAjaXGI4hlPGNyPrzDmlEGhngTVXJK7gzroVO6pTXe7buZc1fK8hwMZR?=
 =?us-ascii?Q?lCv8iD73Wp4ik7Qw5927g7NiTjk2w56UkGJyugrgwdsqUpXRlq+rkgQdUf32?=
 =?us-ascii?Q?ixBEbNCCQPxavy+g5HUWbssseNSRkwEkXtgFlPH8Ti5o7Wxuuv19/g4Gnl6W?=
 =?us-ascii?Q?vi9eVw1eOUu3PKR4oGMsQ7b7CTXZGHW4kGqVhlcQo3yR/WcJKyGNiCdD3nxl?=
 =?us-ascii?Q?ByFEkoYk4Kq/CjQlo23yz5bdN/PPEsHDJd7BtSigvJtUt2uuiY7rg8cdbDya?=
 =?us-ascii?Q?AuqME/uh8d945yVIuMuTkOYCWte2qwo8QMy1p1sGQSOgp4bc5dfr6yF3H467?=
 =?us-ascii?Q?152hroPAyfwe9wIqutwGRZoBFXXeUOOcut4lJm9WSATvcsgneU/4kJfvrUoA?=
 =?us-ascii?Q?ddERTpR39rRHu8WySt/ai9arlgNymeSA/JPrdCStUZVFtrsWvUVESc96+1/I?=
 =?us-ascii?Q?Uo45EUlLWeZeW7MifYLmWRXDLXvq+Y+o2ol9ML578w3rK1Yxz0ovRQ/4cMKd?=
 =?us-ascii?Q?CLn96bMr1aMlGZ7nUD1QYV00mFhLxvMKXJ8axuPqyW8l+TVro1FwNKWYOekM?=
 =?us-ascii?Q?MyPU1n7gBxik/8b5LMaRvQdxIEm/I2L/DPqRp231TaQg9Nhp3oIa/lvsPvF1?=
 =?us-ascii?Q?5IULXQj99ZIQROUJvYe+dFCFwXAbMk/AM0wFHVT09TllurmsFlOreMrpSoCV?=
 =?us-ascii?Q?zpk94i9sylQCpRgO7qK3DAA2SyOW02IhuRoFMqUkcSTScYNggCqJ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50a0cee9-fbc1-42f6-c9f3-08df3a9aff6f
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:42:29.5409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uzL7i7e46q40ImZLte5f9/tyJ26qQms+bnK6hGwlZFLlrUqWtjyJw8uOCbSRdXOCwrvvt5bszFZoMTic3QRxF1oymnkCBqb4k1HsgayKE/ooRgUnVItP4yoA+PwabgVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7490

On Tue, Nov 03, 2026 at 08:37:28PM +0100, Markus Schneider-Pargmann (TI) wrote:
> [You don't often get email from msp@baylibre.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> In init_cppi41() td_queue.submit is used to setup DMA_TDFDQ. In
> suspend/resume the same value is read, stored and restored.
>
> To get rid of the suspend register access, use td_queue.submit in resume
> as well to restore the value.
>
> Cc: stable@vger.kernel.org

Do you fix some problem? why only have cc stable without fixes tag?

Frank
