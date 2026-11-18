Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021320;
	b=3sU+TYaIklOONYnBjV7XOgNwNzB2USZzKys2LNH/r6b/p/88jQccGyrONohny03gScHp
	 9EGR7lidOd+L59wBAyPv/xz+Qa1UdEqsucXl45pCPKMeRMpM7zNjrM/WPmVpzJrq+y7Uu
	 mceT/AW2qoLp1zRFYYvwCSREcxVlD/Vp2nJiQ52GTMP20xTeHU0kodEl814YSmfEIinp0
	 EmFUO1nzRL8yMJKSmAxSsj00LKU1L7M/KbcaPfSYgmlAbNr7+wE4+SZulc2BpjpD5R9Ec
	 I0CvZVMkNaIdHP2SI9meH/DGUJXB5UC7v8eif1s8cwtLrhHNexFAIWdYkBkphuO//5Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021320;
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
	bh=zJq2pXKkRaQQrrq6h28WTqWjtESIWQfBtpmGTeUaphA=;
	b=j5NJwYbZN2dGckky3ftugAjHnGFInR9BgP2BwewV9uVXSRyAA8EwqClkLQzz2enjyXHp
	 8DYRe5iu/OZGBLZ584hIAzTL8066tZDVryrpZiIZAd2gc1JdjU7hYu0AQWyTVC32JSaK0
	 5mXNqjxOpxzqSMLdC0QMgbKjryXHVoCDDIrVavxhFrGERBFdQ249czbyOfEd+I/fib/Of
	 M7NqRhzpQojTAE2vsg3BaXEZl6kgZQtSZvgyGenEjKBXTpZbtrXNe9m0vXceVp4CMyNWx
	 LDJP8k7/WFC+o0Sx6uQCca5n4MDpHb1RdTG0SBQ9IrZQq+N+MvOuJqNAnqp9+5JQlsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JCJ0UsCN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.12
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012012.outbound.protection.outlook.com [52.101.66.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1423606A31C;
	Wed, 18 Nov 2026 17:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1423606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=JCJ0UsCN
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIqvefXWVJgciLuS9gIU0dWL0QrLvFlCqwpnMwwFyeMRStsMCfywWRcm5Wi8dYZJ1+8hcmpY2NwIjc5/cUw0e9IUDmTC3r8JgY7p+2/waOq8URx9/jNDrTdHF/3z9QNGUxqlUVg3q1J2f82RgoZQ6BzNS3q2q+6p0VZGAk4eZmmnafHSezsdBS6w15Wdpzc+Kyy2v15hAIShkSCNI3xlRsYAb4SCAJ6KIma4hl3RZlrcesqZIRDeRRI16um0EG9FChGrvaUJpBQIb7KlUM6dW+IaCO3k88MCGvKLH+nHiREpX5jQrz8GMmaZxXFU2rlzZ8urWWU5ZCYlzhcQUr3DvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJq2pXKkRaQQrrq6h28WTqWjtESIWQfBtpmGTeUaphA=;
 b=FKfwr9TCqqa9u7C40+lYb6AGuXs6hh+sgV6UZ83JJu1mMLHO1xRO6e1K8tdmryOtOlYiFfkVNu/7klOhn7Hgl0R+z8q9/3YrQlRRdY8HOiN2bZC1HuWRetBBW9imy8D7YF2v5W6hPJ8E/sgIQR5WcVs/trOMWK+YWdd4IXFQPSWq9Ps/FvlVVt0TIDVoP1Pc2FO790TiGcGhUk5DBAMB+E5VSkb8FQt8497/um6JLXvjYZsUz/OrbcUAxjAdbGI6/H0q1fCTlm/PHoe/uqkkkDqOZr6Fxj+bYPY2yzd6iyF0q+YBgrHZ2560Wvc888kcO2aexkdmtQwxryiGR8V5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJq2pXKkRaQQrrq6h28WTqWjtESIWQfBtpmGTeUaphA=;
 b=JCJ0UsCNvvI/Gg7iLD8etLChtN7iNn9o0xh4sKw30hXHAWNyWlf20FE5fCfEnLVjEdYdS09Tm4MbhC7Q6pC1v4lj0kHrU3UNYSazhkf5mSkuhY3fIrjLz19/cvpfa1VvpxJ1oBqy/uJ83CJ7Q1cxlKUEyjJoiMYkHhZCUrK9LJWygOublRKxhC3W6AKKk/X0T2mJThSosbK/ndjSSfFj2mfJ/JGIssoXIigzrdXkjfYZ7Hg1P+84okfiQdW/9EdaQbEIOh6k4kSqbC5AiPVAJG0fwWWUPq1nLbL++ACKfCX86qjIqRk9rhWP6+DSkqyNXjvqcHjwHg1ND1UHjLK1lA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 17:01:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%4]) with mapi id 15.21.0615.013; Wed, 18 Nov 2026
 17:01:57 +0000
Date: Wed, 18 Nov 2026 11:01:47 -0600
From: Frank Li <Frank.li@oss.nxp.com>
To: Hyunjung Ko <hj351016@gmail.com>
Cc: Amelie Delaunay <amelie.delaunay@foss.st.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	dmaengine@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: stm32-dmamux: don't call runtime PM under
 a spinlock
Message-ID: <av3Z-35-RJvHegmf@SMW015318>
References: <90b4417d-f2fe-498a-8128-3229eb284d8c@foss.st.com>
 <20261118152843.1126665-1-hj351016@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118152843.1126665-1-hj351016@gmail.com>
X-ClientProxiedBy: PH8P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::25) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: f9a3d1e8-559e-4877-866e-08df4595a734
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|19092799006|23010399003|261026121527099003|261022105027099003|56012099006|4143699003|11063799006|261102123227099003|10067099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	MjY0LqNrRE99dDw6AD6Llt0gFmOSbc7VSlTMR50azJC6PuvSY83BsC855WU374PqkwaDgWouDINUJwMhYdOcDX+L0EeiuCwZzrU9QVh5yiD7PAwBFaVzqnk4Pr5XWqE5QIgI4ZLksbUwpBZ7MB1nBRRWUVjLPbh8HrcJr1poJ+Z4W4suEuUHUpcX6SePRCtmv3CMzNjctLUYu+1uh5PLE/43ATAraWZU3QTAKAoRpSJcwqK2w/casUf71xJJ2BhJWYWa0ypsWIKjXIW4+EuRwbTngiChjqLw+vQzMXnpiHUVbl+x1atUhYU+IR/q5cSYpkbZvhYDOI3Ui3AejJTYsLBWCJ6QTEcLKQFLZIAtpPUkYUZI51eDFJmmT9t3ckR4PLUo3yQXbGR3XM7WglzGxgehn41sRSxzS0L+g7mZcV3ov6VTfRYk/1eFVo2pNT5jYJi1e4DOVKQErIo7ZA6JiG/RTG4/lYzyoC5EmrSXweyuIRNQIdfG08NywdlkhUwgGHphEC2TVSyf64f3EGl6HiN8kzIeDEHaVQp4WQIL3+ZWqe34idmx/LI5i/E7IfFxzG1GF4CvYC8+s3+SeprW20aNZ2aqEUzDcMPBEtBfPhmDikANE7HVRZtHlwVhh9It
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(19092799006)(23010399003)(261026121527099003)(261022105027099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(10067099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dL0A5DXWflDVOWgxyQtUz6URwxO3Ucpmdo7PHjh07ZFEEqihThDFDQ//njUN?=
 =?us-ascii?Q?gdWYfJBP3TrwWAD+bbU/2DykjxLK+t1MwPJOM8P0a/4i/Nqtvq2n2aKRPbzA?=
 =?us-ascii?Q?/c7G6HGDXbRXXUR2ZBgoU6xnjHXWtMrx5kPyXZfHCufCasJ3MhDIrCW6E6s4?=
 =?us-ascii?Q?ey5hScbv28+/i/XRnkm+0mRVbl5YmkI/cGacYOLh44wIshPJO/akCTBG0Z3C?=
 =?us-ascii?Q?Heuqn0bwAL3uHALcOx/zKaFMOSnMsngF52Atl6LDjAfP755FW9f6o43MyzsQ?=
 =?us-ascii?Q?kCvIxkb1FsD2gLIuiJ6X+EjJvViRaML7actzFzDP7I4QgkYh0plOjjUreVrp?=
 =?us-ascii?Q?64cMWfO4bt+pi6vatkiJKypf3HHrHaKax4Di6yLhNGQtfl/3JF+TqsFXOMCL?=
 =?us-ascii?Q?h16h/sWgcRdZ0E/Vwb5THPsoPdsUCW62rKM0ESEEUG1ffxoXBksRkEnjuNQj?=
 =?us-ascii?Q?ajeXUedzZsIdwUSjwHioXrFyM3rQnTL/sdpVnGvlm3g8E1H3Lm13tK2A+E10?=
 =?us-ascii?Q?Hjb4N5At79InD8j6ehJU5m5Gess6nkns1/YF7N9GVQ0CgQFcz9+uSF486o0e?=
 =?us-ascii?Q?PUTYsVy/coN4Pt9JmyPesTrT7or3INlJqCkcQaaBNJZVAY9ZdgvwpZYggL6z?=
 =?us-ascii?Q?lT7/Ie3ARQD6yjo+leLjnTCwFnEHz1qmRdWhJE5e6EMTxXRAll96+ttD+Nxi?=
 =?us-ascii?Q?FD8u8wFigzi+PqSQo17OUK9BTT1sR2zKtnt+gS9i/Z/D08uo47cJBWkOyJsl?=
 =?us-ascii?Q?JUqr5hNmyHLmAWOmyryQzyCuFZy3MGVUeZNs+rIfrDr+PRua5PSnokYv9hPo?=
 =?us-ascii?Q?MjTyJj5KoBFEMWAaOLn1eUmID0l/DlZ4nIrT3bZwJLyPz1Nx9eqlaFMZDox0?=
 =?us-ascii?Q?0JP2hUD2DWtVAJTLNLOjTiS0spPwPcT0cJ1Ot64cLDZjuaajp0di7UOufSO5?=
 =?us-ascii?Q?SapNzrBGA5GnYj1+5wcMH/grpbwspgtgIOzEl82JuzdaBcBbu676mlunG4NZ?=
 =?us-ascii?Q?1EsCdId85rWn09Qvw+6VOfXmcj2mtT3JVrw1xEj0p17YRHYzojdGzDp3qOqJ?=
 =?us-ascii?Q?68sG72371QdJ2jR42yda7eWd1KWjmuPQs0snkI5e8Us0DTiy6fje9ObEJ5jq?=
 =?us-ascii?Q?TAMajdSghtBPJhtGGYjzb+01cHLcNl6SmJ11p50RzDQ7INDhMtUGFNWoeIa/?=
 =?us-ascii?Q?q+86gtg7a80CvEhQgIqPyBB24ek38UI9xDW4vyMY11KkozmgmcgFloftr6Xz?=
 =?us-ascii?Q?WzTnK/7L5Cfm7wbk/ULr1FMQbTMt59dTWFGhmdbRYXgKt6DKdUzNYqbV20E2?=
 =?us-ascii?Q?qddDgA1OtxtxaZs2dEqGDWrz+2nVfCRD160mKe5eN7ZzB+IWDLE3/1PcndjW?=
 =?us-ascii?Q?zgCB1UnjUjcK123SLaJu/ccntbLhCfm7xTxqjP26cwhhmgXH8jEmf20MBk+T?=
 =?us-ascii?Q?A0ZgzJIYaQHJkmeGfE55NjR2h+Puahkq3BnrWnZw88avk3HYhjCIlS9ktEWy?=
 =?us-ascii?Q?0Edc4qh7p+E5I0uWvlt0mnZe7mLyP29x6Wx3PjDOay1jYPnMCdIdfu54vaoJ?=
 =?us-ascii?Q?54yV4q0tBgwkR1RB30tJWw9ycAzAVx4BW9lsR13qEWYkIROj3tREI7lySSeQ?=
 =?us-ascii?Q?j7N5ZUz2FQyfZw3hv8jUinrLbmqWOG5knRublJaFDj+GbHqDhuUrbRz8gY8n?=
 =?us-ascii?Q?8U7KXPe9fF/Q0A7D5TlNpebJrzLczFEGXAAA2fPyD78F6LLmdHTe1QXYcslx?=
 =?us-ascii?Q?cwHzVeAS9pc0GN1u94UrH4VTHu0fCW/gSiQEypBmAPq2MeYaflyF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a3d1e8-559e-4877-866e-08df4595a734
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 17:01:56.9700
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T+/GveYg2Cb8GbhJU5uFxp9C5NWeukUUf/hEix4+cU/0TRbhi1Jcl2AxzyFr2A9Yjq1Udax9UkQuWlGzB8SWrfLsnSCc3PkXVUFb159WkV/KhMHW8X1F9g8dbfXM9yBi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014

On Thu, Nov 19, 2026 at 12:28:43AM +0900, Hyunjung Ko wrote:

Avoid post new version patch to old email thread, which cause other tools.

> stm32_dmamux_route_allocate() calls pm_runtime_resume_and_get() while
> holding dmamux->lock with interrupts disabled, and stm32_dmamux_free()
> calls pm_runtime_put_sync() in the same way.  The runtime callbacks
> enable and disable the clock with clk_prepare_enable() /
> clk_disable_unprepare(), which can sleep, and the device is not marked
> pm_runtime_irq_safe(), so both sleep in atomic context.
>
> The lock was in the wrong place: it did not protect the runtime PM call,
> while the CCR write in stm32_dmamux_route_allocate() was left unlocked
> even though stm32_dmamux_free() writes the same register under the lock.
> Move the runtime PM calls outside the lock in both functions and take
> the lock for the CCR write instead, matching stm32_dmamux_free().
>
> Fixes: 4f3ceca254e0 ("dmaengine: stm32-dmamux: Add PM Runtime support")
> Cc: stable@vger.kernel.org
> Suggested-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> v2: Amelie Delaunay pointed out that v1 was correct but incomplete:
>     - also take dmamux->lock for the CCR write in
>       stm32_dmamux_route_allocate(), which stm32_dmamux_free() already
>       does for the same register;
>     - also move pm_runtime_put_sync() out of the lock in
>       stm32_dmamux_free(), which has the same sleep-in-atomic problem.
>     Link to v1: https://lore.kernel.org/all/20261118082853.926607-1-hj351016@gmail.com/
>
>  drivers/dma/stm32/stm32-dmamux.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/dma/stm32/stm32-dmamux.c b/drivers/dma/stm32/stm32-dmamux.c
> index 5731871..8290122 100644
> --- a/drivers/dma/stm32/stm32-dmamux.c
> +++ b/drivers/dma/stm32/stm32-dmamux.c
> @@ -73,10 +73,10 @@ static void stm32_dmamux_free(struct device *dev, void *route_data)
>  	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id), 0);
>  	clear_bit(mux->chan_id, dmamux->dma_inuse);
>
> -	pm_runtime_put_sync(dev);
> -
>  	spin_unlock_irqrestore(&dmamux->lock, flags);
>
> +	pm_runtime_put_sync(dev);
> +
>  	dev_dbg(dev, "Unmapping DMAMUX(%u) to DMA%u(%u)\n",
>  		mux->request, mux->master, mux->chan_id);
>
> @@ -139,13 +139,9 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>  	}
>
>  	/* Set dma request */
> -	spin_lock_irqsave(&dmamux->lock, flags);
>  	ret = pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret < 0) {
> -		spin_unlock_irqrestore(&dmamux->lock, flags);
> +	if (ret < 0)
>  		goto err_put_dma_spec_np;
> -	}
> -	spin_unlock_irqrestore(&dmamux->lock, flags);
>
>  	mux->request = dma_spec->args[0];
>
> @@ -156,8 +152,11 @@ static void *stm32_dmamux_route_allocate(struct of_phandle_args *dma_spec,
>  	dma_spec->args[0] = mux->chan_id - min;
>  	dma_spec->args_count = 4;
>
> +	spin_lock_irqsave(&dmamux->lock, flags);
>  	stm32_dmamux_write(dmamux->iomem, STM32_DMAMUX_CCR(mux->chan_id),
>  			   mux->request);
> +	spin_unlock_irqrestore(&dmamux->lock, flags);
> +
>  	dev_dbg(&pdev->dev, "Mapping DMAMUX(%u) to DMA%u(%u)\n",
>  		mux->request, mux->master, mux->chan_id);
>
> --
> 2.43.0
>
