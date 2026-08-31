Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013052.outbound.protection.outlook.com [40.107.162.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4DE473C65;
	Mon, 31 Aug 2026 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191458; cv=fail; b=oiTU/lEkwJqa2Ye5lSC1ARkxkAn/SLb7Fr6HYvknhYLfbS0B3ibT5Lx/hwrDIw8aiSNNum7oTQiPrC7mp//UqIBk4NPV1pB6KhIKzraTiHaVWGQ3qALwWePC9J698jvvgxzfdUktk4sl7OoUygZLS3S4DqoQuLjsSKHEJHj/+o4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191458; c=relaxed/simple;
	bh=5O5oC5bUeh5pewvRERwau1QRM3JX624VEJRmHswXcOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UA/z4bG0YYYbuoiaAFBUG7TNPbuX0A731mWq8+WJw2v+zFBAu40Qe1wWUyXkdYQeA2t4mndSasp3xY6mlMSy/hPN0Dr49MHKUbjaom48a3iWA+3YxgFQQrLCz8BuI2PokP1Gv6QRlPs01f/SdaTZfptZ4Eph5k913U0/7pyqtZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=GwJTYKjA; arc=fail smtp.client-ip=40.107.162.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GwJTYKjA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7D+WQJ2US6OZDAbGTd8obgm/UkoP6X6KzvM+C7iqS0R4vDORdtNr5pjeyiRLefhQT0cZ4toxTAlG/TXlgCM+A3RxJdvUvRx1KSLchP+973yZBj/wdCgOCOoLykiOYbFaswaaiQxr35EUMJaTlSxMQdJs95Im7+gVttgOXGHFLhZhFPwrPa5ZXkPlREes3Eev+Yl4jX34A4Hdzvi3TrNfb74H0QORdltSRsN9UeHplfG4PzOxiggiqitEWUUDDvAq80BvwK2XCux08Tnc2I4FDn31UmGvuN+x8zGjCjs++XMXcP/CfGH/8xi4yYjEXDpt6852/0WyNb2Vs3uHYMMww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSRM5LK+L9byeskj6UZn2JpHSlZNI2FO+xWRg+E1lAA=;
 b=LGuLhIuDTuRsEGZat23N9kVgor0eCSRzqui7YJom5xjMaCuzg0DJSxLhAN42CYAepYpbmsRY3vSCUc2PPGJKPYPF8UAYFuRUsMc+6iOuJCBCsjEhSe2mUPz9jOTk3LeRfCSf2oj9bEN8W8vH7t+7N5wZkn2Gz4MfZW9/m0RlQGqhEGTRR5Py03sEh9eWWdygO5+9OhppgY1rueAX2yxP/bIuLcALBtIBkSCd6JrjiqIZm0vgOyTW4KSI948IS5vMxasIJogjKq2Hv7P6GqKJPztblK/KS0LJF915dqgD6JhYs1CI62kRn+XsPZ/vM0taYmAQwterMj2b/tSDEw3syQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSRM5LK+L9byeskj6UZn2JpHSlZNI2FO+xWRg+E1lAA=;
 b=GwJTYKjAzSfvdYgLKNaV5lxksWqqU2Xqk3eW4T5jwicM4p3QCneHbgv6pE6Pyu4aVOWAkAu8kvWYPX+7k39YpixyasVSH9AQ8PBVqCUF4aLNJL1eZ/fpgxdK8O8zZjX2A8Nl4I0ziMKl/WjKygMA5AW1dNbvmwlwhmwj0z61n6BBC6g+IACiGLISTj3qJn2Mw3yMkEfsq3A8TB5FRCzyQAe9ZeUKKoACCqbDX/Sr0r8o/teAPjf+OAh1Zaom8/3PIUC3WiK/Eri9cieNKGx/JfaxiBjenC0Y2Lv5L+If2Pi6BMC5y0nVZSwSFGPsAWUKFYY3EjDLAaB91O78bQpSMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7812.eurprd04.prod.outlook.com (2603:10a6:20b:245::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:50:53 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:50:53 +0000
Date: Mon, 31 Aug 2026 10:50:44 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: adrian.ho.yin.ng@altera.com, sr@denx.de, vkoul@kernel.org,
	Frank.Li@kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] dmaengine: altera-msgdma: initialize state before
 requesting IRQ
Message-ID: <apWi1DOEPZ50SL6_@SMW015318>
References: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260830053308.2190597-1-runyu.xiao@seu.edu.cn>
X-ClientProxiedBy: CY5P221CA0118.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:1f::35) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 8741368a-1539-468d-a0ea-08df0777a342
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|19092799006|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	/q5UkcFg1kRs6zM1V9CajyPgNjZoXBn1+aIcCR1jyPinuK44sqdU6zsfP8hYvBFH/lmYhpTqo12sqejL+IU/q0klEdRqU3QXuRU1JUDx3BEWlmHXmyjtfzLRnCpuO2QCSHQprEBard1FaML7JYrKP8n9/luRl8OSgKT6uqcsKUuEf2YL8nMG7xdCkDqsC/X4FHELRzeZcb9hx2SJ6dYskKpHIeDfHCGwzDyp3K7koCSIi7m4FIE/isL/INA1qAK59JHVl7iilBrJFjV7LP//nv6SO8tWyHDh167ooZPPn90P9hbsYi+PhFzY9UrC+ig+pRdcvIbIAEVYEVCG+AyKPpGiagvxr11ZeOOcHykLxb6kwGn2pVTgssR5xa5OvVCvOtP9FpyIpE23NNoYBkZdaUPCRLTE3KQMs13dbCpUl6q+IjnT0vv5YztFl25J+2uRwL5PTzyk81wcAy7kDwNfVSYnnPFTC6zKZOxUnLjOSltCmpmnFvQxrhjV0TsdNF8NI89OO8Cij/4fxycBTPoVd5hS93z5OK5JuzefaqJejiliTXg65CtHkL+XioYjOQ6UtaxGE/dJFTUo9i+/rxkAgW+CZajgY0UsIrG1830f2zc0XBgRCSrADKNKhKfJLy96k9yXVWENfXvhAElGSyz5Fo2EZOnXkaTynIW6vrBJQOU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(19092799006)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W33phPPpeLHqi0vKMNmjbkYLeJmC0LgJPyWau6VqSsVhuqwz2EqlJ6Kkh72Z?=
 =?us-ascii?Q?dsO+g5JH2GzQWGhZNRSFiNbDVeJJTVU8kgwCWQJQvNr0+nt4O4DRIYpjp+fq?=
 =?us-ascii?Q?iP+TIZZfFFS6X+RcaayME4NTNM6MunzsMxEbFr0RlHhgaFdTz1SOzOvvyCgL?=
 =?us-ascii?Q?vV/ebgPy3YyhTU6rT3/6b8TAAKIRZvD5fBclJXbna0XWAwBGxCGBRzEltY4x?=
 =?us-ascii?Q?EDeHrdHay+hTqhq/dcRj+W28U7VqnQhExvtIrqZ1q3FXwLtwe3kyZt2j+emY?=
 =?us-ascii?Q?Mp3HI1BPPPSJb4VM8a800BxPO6gbKe/4UeYZySCdqUesj4YAiowXa5TR7tXU?=
 =?us-ascii?Q?EHGeWieSkWCbbEr4whxpY8KjWPZewShifSWDaeA/+XugrpmIelP2mBMIQSDM?=
 =?us-ascii?Q?zEXZ8y/jviI5qbqo01ZTK3qxKtDj8LoIZErtGLZ2cOU8oLqgJQy3amHx1N68?=
 =?us-ascii?Q?19S39tTjR2Xq+rcD/GOEjiwKNgISdV/YaRx7WVgixYQamYQ70HN53DpdNXgV?=
 =?us-ascii?Q?gjTW8+flUuuJyfn0ntRPjIBWZ+fTn7tycDwC78GtTCh9Ne3U0bXZnngbxjJV?=
 =?us-ascii?Q?KVbcl/5Tuh52khKa37lDPcGUSR6iE3jLJxA1AHsP8WeEOOaHcROMdzIynnla?=
 =?us-ascii?Q?LsBZnqDCTnbFN+LOUhoKdyQ/Yiw/P7b7V6s5JeAxVc06R1QrxQJ4HJg6rBtd?=
 =?us-ascii?Q?rhOHBbpyFZISC1MM3vSy6DIAMVfTHgJmkakDhOjaiWwwdg6gfExf0FAR17g2?=
 =?us-ascii?Q?9nDTDWio7GpnCC7tgUHZYM+RSFQA/Ow6zbA9lf2tds8mwly4sA9BZXAxS7vm?=
 =?us-ascii?Q?Gw0L65+7yngcZc9XTCGk8z4L9VtRsc87K3KGE2LbH/xrw542FFONJtMfYniv?=
 =?us-ascii?Q?E3qRmDYlcjCuXNxqzg0bA7ZhrKbLz8Yci1J7zJNIkFyU02n4sbw4X2b+SLJW?=
 =?us-ascii?Q?c8UvRcR/rBpwpcmplaxrcDpvxZMVmfUJ1DUM9wzRyuOBPVQu++6he6ZaLoYW?=
 =?us-ascii?Q?eUrZw87ufDGki/0xxD5U/zgL43APLepuh7FuTyAapnVbR6ndK5xKG39dfPK3?=
 =?us-ascii?Q?gu37kT6uT+71FkWqIMaV8HbbVUBQBkm+FDZehmY0TcEB7ZHcti2Gbp5mVYCI?=
 =?us-ascii?Q?75EU46h8zTMJjLCMglB5WNvlKJKY9QcF/tuV/QR8WOmujhiTbw8ZDyn9alBb?=
 =?us-ascii?Q?mldZxNUCpeqNxaIjSpbdmT2Hoy+78scAioy5n97KaEjAkq5Mg2nsQjp5j6Oq?=
 =?us-ascii?Q?ST6Hd7fbZFHE+xFdEuIapIZMQ/25gI4vvFlpNmul5dqTR/1Bosvf/55ZPdME?=
 =?us-ascii?Q?fzP99xYaJVjaEFDqx8AGdNDPk04fwRBOZoe5kYVh7E1hrteq3Aa1iAzmcjN+?=
 =?us-ascii?Q?UsJfmSOOwtmjd5O+GYVUKLbUwdxm+8RdHPQ47L6smkG35pG0mokJACCs14Um?=
 =?us-ascii?Q?H6xK8EYLuaPMVv6q0gR4Xa+r1IVai8SkO601qns7ZH3TjWCqwtekx/X1xB1S?=
 =?us-ascii?Q?PZ0S/Y3g09kvM4H8a6yHE16ZjvNdA3DJeKMS+wzMKv/JYF11O3qYZBZhRMwa?=
 =?us-ascii?Q?R7Pfzxis6OwBJE+/a620/rgFddympYFtBC5F+64WRuQsj7zoOrVqIVv6HIZb?=
 =?us-ascii?Q?dLGQEzFBfL7vRLZBz3oYpQ7q3iN7OGRsjf4/CBUjUCIOp2MustYtcXBB0TRC?=
 =?us-ascii?Q?yBjv8saJgioz7JlNi8vdEAViTlOtWzXwY7SQKsagIE5Nk3AQZjq1buSVB+08?=
 =?us-ascii?Q?+//Jkcrn4M89QGLOm2IiQvgizb0gwgyH2rzCMs89wuN98f8jBoUx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8741368a-1539-468d-a0ea-08df0777a342
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:50:53.5416
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fISpkpGgSg6HOSjmKjvK+60FF6J4/F0IP1HPDtlZd0ZlU1QmO+Sj12zsa/f9F9AeIZ2Ciehbu/btNzfdZ6ousUVYQdxQmNKLIIZSn9zT7Ah7G9U1dDL8mFiaGAB8aZ7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7812

On Sun, Aug 30, 2026 at 01:33:08PM +0800, Runyu Xiao wrote:
> msgdma_probe() registers the IRQ before initializing the tasklet, lock,
> and descriptor lists used by the interrupt handler. A pending interrupt
> can access incomplete state during probe.
>
> Initialize the handler state before requesting the IRQ so the interrupt
> path observes ready software state.
>
> Fixes: a85c6f1b2921 ("dmaengine: Add driver for Altera / Intel mSGDMA IP core")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/altera-msgdma.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index e23e5b441..412f4bce1 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -847,11 +847,6 @@ static int msgdma_probe(struct platform_device *pdev)
>  	if (mdev->irq < 0)
>  		return -ENXIO;
>
> -	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
> -			       0, dev_name(&pdev->dev), mdev);
> -	if (ret)
> -		return ret;
> -
>  	tasklet_setup(&mdev->irq_tasklet, msgdma_tasklet);
>
>  	dma_cookie_init(&mdev->dmachan);
> @@ -863,6 +858,11 @@ static int msgdma_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&mdev->done_list);
>  	INIT_LIST_HEAD(&mdev->free_list);
>
> +	ret = devm_request_irq(&pdev->dev, mdev->irq, msgdma_irq_handler,
> +			       0, dev_name(&pdev->dev), mdev);
> +	if (ret)
> +		return ret;
> +
>  	dma_dev = &mdev->dmadev;
>
>  	/* Set DMA capabilities */
> --
> 2.34.1
