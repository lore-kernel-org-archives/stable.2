Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020104.outbound.protection.outlook.com [52.101.228.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C352ED31;
	Tue, 29 Sep 2026 16:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790699369; cv=fail; b=oC1tetfupgZ4E4INcupcNSkMmUHatqE/zfmh0hV/LdAtW5Yh1Kn4NwgGZELrc7LWlSLBinEP/TKlAHoJk/THh3gxZfCGR9fPhXrHvEx9wNiQOiZn/YCSL9rD/UiCoNOnTmmoiNX28x3smhozMV36S3PHOZGSHD+78DPxurI9Ofg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790699369; c=relaxed/simple;
	bh=ljDW3sFu9R75WUeZSt0+PC2bbhlGPthbdE0QC8DxXgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FUvij7GnIddh8AU45oEzWCScIzNQ+yvD28qn6xBS1XJJRxPIxD1eHL5zzV+HjD2eywGeXSEvTQCWXbidvBYrxacIJecBBnLF5RzLXFCTK1h9IS8dzBg4b3DO1+jYb+gIxzEwBmnoNDRKuuZvKCzm3wn2peo+z9pfu1Z/8MS7bpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=TawINlvQ; arc=fail smtp.client-ip=52.101.228.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="TawINlvQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj6ti444IZrpwHS24DNchcPGVR44ILV4vEauKLQbP8EjrDRiCyoRZOi8k5bkYxgnr3e3frVHODTnn1tXFAr8aIqof1hDrBe6zszOv1H5skX46IDhiIPCsrutWH2UKUf2SxstwJl6Z1xQcLlhxv9OEjtwDMPa00glzlCxKZhR68C41Rs+2+n6EfRGBg9gX5X28b0swVH4phMv08aUwlWTHH9WvJ/4Bq3K1JylWCM1n7APPsbi6+AoJIQGg5s2at/wSBul5650PtEPFRC5SB9oqmafv8bEcjWpx41WvUvyfnyVT4VW/qBWlVdqgc/IJJPhfnsqomToyX6pnuUU84/Elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MvHpoUPppRVzzwG7MyeGFzxE1wh2KcvNqYJD8/csQx8=;
 b=h33T8OkqcLdgld1+4fGpPkUQV8LkNhaAVPujwv/ItKd3AYFFjFob5bSMTemSOLoFONKH0ynUm8xH1mxbEkXR/1uZh9UtX63eJg68RvsPb9nA1MbD2PgWpwyxX0EZAq4iDgLokMx66bztpeFPpcL3Q9qCbAxvA+uPamCQX03U8ZM4x64IxZKAlx/4tkMruVxD5lxVh9V52Jk30zQw+Mlhm0eeiW5RV65JrqIOpZ3252abbYm85s62rz/ZpqvLqAR370CBmOKVed9Y/igEPe3emN4L8xoaunl/AYjttbP/nAReb0/+DzgtbosvaGxH+Rwss/jp5reaPf6iwoqqFrjbmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MvHpoUPppRVzzwG7MyeGFzxE1wh2KcvNqYJD8/csQx8=;
 b=TawINlvQU2ptAw6YvPqBFIAtPIfQPCEaakLoechRf00NYoj/aQX4ULv0deiKZk9gcnX0VcLj8XH474DuhaoV7pi7ZQ0B6pkXaakLBAGsNZlWKY0VoYZGXxsHEpsEuCRe+FAnTWDU7zFQ2hd23F4hwM9VtYR9GnMKXK+XT7vBcZA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYRP286MB5281.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:112::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Tue, 29 Sep
 2026 16:29:22 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 16:29:22 +0000
Date: Wed, 30 Sep 2026 01:29:21 +0900
From: Koichiro Den <den@valinux.co.jp>
To: WeitaoWang-oc <WeitaoWang-oc@zhaoxin.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	WeitaoWang@zhaoxin.com, wwt8723@163.com, CobeChen@zhaoxin.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/apic/msi: Fix MSI interrupt affinity configuration
Message-ID: <6mg2eqdehsmb5fh6hf7icsha2547xfdfvulnycawiit2czhhmh@6bbmicaoz2zd>
References: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928164839.6381-1-WeitaoWang-oc@zhaoxin.com>
X-ClientProxiedBy: TYCP286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::11) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYRP286MB5281:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d470c6-b9db-4b3d-31f7-08df1e46d1a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|376014|7416014|56012099006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rbt6WoqJPPoJ2BRaCmxztM+DVhnFB8imD/+Z/592SZHh7wOsLDsne0/IsAjbc9mOMn572FElpFbgh/eh60Hzvo7nC0NAC5p79tqJnyp2wZ49JGlEkr10Dhen9nFUtsGXW0up88RjYY/aQKLXUtAZdF8w9OxKyhg8ES0BHmA/aOfDDXYofgtZBRrfx+7PJOBKIaiaacZLKbnB3XXDJc8T/evvX2kAvsCOv/ZlZUrdYl0T53YooHNkIlUNRe6U66V72rdzVoUS2IQPTSMG+zzoOeAPn32QJXVMQ5XgT0MhFjuBVBsc7+jopKB0BIjdvfMMsfvjTa3JKWZhO71aFWqRyMAdVcI5//vsH+rjABpt5sPTw024z5TMPIKVsltbV5/pEobBvGSrZpGS2jyK60RN62CaVvI/MJqUGJ7b/nbwBWJeKwosA7SJBc47PQa2dW7+rak8SZUKxsue8f7VeVw9k/JvIRu6EJc6Q1sxGpoG/CPOpqWEu8g4afvGE1V425LulRAe8hkZyONuNGGuhpycCNnMvtQPUsEXiqVRLJKFkVnsq4KKo+YeAZ9IOTgcpG6Lybs4Nyq/hnh1vQ698bzme0b+1nN4Qu1NakKIKl5cg1UytYVYt4KpjBD5VZ7zMPnuKuSE37K4YGopQG6PrqZkCe6pGxcv1BcH8hU+1rXqBZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(376014)(7416014)(56012099006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BCZy/Q7sjnQUSSmJrqWobwfRp7079XvMeNP5Liz74SbK1jv4p7VJpT8BzhMR?=
 =?us-ascii?Q?jmDOjuNB4V37zOC2dbgI2D9UfhQQxZAPU0JFu4rAOg36KEZXZOrAs1YR/u+s?=
 =?us-ascii?Q?n7Hjxmgmw0S11vrr03bgwr+mC5o2eFIf1VMx6NQAoZGq92QFJ2Mgd7oTjFx2?=
 =?us-ascii?Q?3b2EIkTADdqtuw2U2HyIjyGpdobQbdUDQ7edK+pYHF6zPAP3UsI0GlHJg5xw?=
 =?us-ascii?Q?qCvoRfHUhDtOlYABsgupEx8Xc4zEb4J19YOucij/iYZJzCxLA5jSW9fjmVW7?=
 =?us-ascii?Q?Och/gPZyp+dVr9jOaKJu1fCC0mPQQIkB1gTCHUYbbXZHDdqB8z7dYJlc3fCy?=
 =?us-ascii?Q?O6z1AKK9267XCvYsu37lXzpusf5eMmR1hyeickU07pADP+jZ7sNwdaUdjK/c?=
 =?us-ascii?Q?njL6BFpkaDlykHXWadw+UVL6COnjEGuMPCMCvdSLsFNxR/doVgr5byggk1/8?=
 =?us-ascii?Q?xKOkhdjle2VbLYcXosNx1adopTVuq/d68piZAMG/ymHGPcsiJA9OKFVPcQ8V?=
 =?us-ascii?Q?u9GS+xIexHv04dwa7qQZ2xyh0Ox1EBzdEA7WcEFc9lRlmzaB9UKbWVINNVRm?=
 =?us-ascii?Q?wFNDu54KC9lJJX/EYmaclJzoeCGJU0rs72+Jd5HSw+LOrwnrXsyL/ZrevzqK?=
 =?us-ascii?Q?k1sfwuZNpPw2fKqOj4Gu5rxtDmSoVkeLApvtXmYwNvMm07RGJo5EEKUbZYtc?=
 =?us-ascii?Q?5s21u95r2XDCZ6SA9EpYCV+r9oTlEmGM47ln4O0segIa40ILvviQga6Vs8G8?=
 =?us-ascii?Q?WsufixobLpD0Fk+R8JE8i+ESx7Uyg2TG9w9DSbutIuL6p9oHCODwprOdOrrU?=
 =?us-ascii?Q?6G9G7/h+NCuIYXJAR108Ye3mOAo6PQivHPbz2098UOaerl0kx/Ij7zWNOaDL?=
 =?us-ascii?Q?gC+XpMWntnAwqHoBHfQA2RIkIxrb5bhvJuE6xCR4Bc8JnpPB38YH3iX/CjKb?=
 =?us-ascii?Q?bLQoUgYKjYIuFCfrVWOMzqw/7J4fmnMUNGBPENqHca8IcCzb2IDczDXfjSzq?=
 =?us-ascii?Q?tJ5ukFQvA2bZQZ83IIa8GdtPS0k17eFuUQ7XPyxSwcIa9ab9ZxnvBwPiXt98?=
 =?us-ascii?Q?x4ZKkx2FrorKxZzPW5/GCEegYXwBYiaOTUIv0EAIQSn2sR9NE5A+dMHNcAzD?=
 =?us-ascii?Q?MjTLzDiLfSs6/vt4TZFgF9Sw2M73+NzmCGDTwSLNpn383APi2CznbmvYCKbO?=
 =?us-ascii?Q?ZSPYrmeOag5ZOIde86ZW88+0ubtuF86zm1ncKHx1m3Bcbu5RmwhgxhQBiCJW?=
 =?us-ascii?Q?5YtgWWqwReA8IFr9lnidQ7BSLe+vFJW52Y7of4DVKCzTE5WG50D92jRgkMQH?=
 =?us-ascii?Q?nV440OC3URPQRJpt4VrYBco42owb7aVIFtAotWsuolIT2BU3RlVp0//URytb?=
 =?us-ascii?Q?jlb9Y8xR4iPJzV7m0JyXkG3sJ0rhl/NVknYLBTatruAO8De4qbL1yHnl4Tf+?=
 =?us-ascii?Q?Jb8tPbm7YIaEQzxiQ94CImJGWketDmvo00hXxKGfWDnR4E8yF8QdpZWIxpfP?=
 =?us-ascii?Q?0mnm4SpJGIq8tGO8CkioMZVR9cAlV5uHppvMLuDkOVYiq+wNWljK5mYx6N1G?=
 =?us-ascii?Q?eDfTV9ihfRU5eKd6+Ml/wFzbqMP5Bu36lrP+hqCMI3ijpLLhLKo0Rs8Gz6r4?=
 =?us-ascii?Q?iQXv2cQxnCWeRPFBmqBnLKgAb38ivnVKT/73U3JwXHoU1vOnq/DdFH9n7FRT?=
 =?us-ascii?Q?wff2yRILUxp6crhmGewzHqx7QmrwFv4/zyL2FU2a2yy5y/DaslrCgwMRZg5Q?=
 =?us-ascii?Q?NfPyNjB4YmfikEuoRtwm40hNR6zoEjRTTlp3GfUwIy0z/Sp1cyCj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d470c6-b9db-4b3d-31f7-08df1e46d1a5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 16:29:22.5135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rwKTxJocYZYN1+Afq0o8nIDGFSktrZZ7DmDrE6jeC8BMuQvAqyz0t+nRGTCUjxZNLHj/iRVujN25VcUAYhsYDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5281

On Tue, Sep 29, 2026 at 12:48:39AM +0800, WeitaoWang-oc wrote:
> commit b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI
> quirk") try to fix the issue of misconfigured non-maskable MSI quirk.
> For non-maskable MSI interrupts, use the slow path to fix the MSI affinity
> race. Maskable MSI interrupts use the direct path to update configuration
> info. However, the current code logic is the opposite as only maskable
> MSI interrupts will enable reservation mode.

Hi Weitao, thanks for catching this.

> 
> Fixes: ef8dd01538ea ("genirq/msi: Make interrupt allocation less convoluted")

I'd rather (or also) add:

  Fixes: b56ebe7c896d ("x86/apic/msi: Fix misconfigured non-maskable MSI quirk")

As I recall, I started out trying to fix the issue, but then got too focused on
removing the flag. I missed that the check needed to be inverted. This
left the race unfixed and also made maskable interrupts possibly take the slow
path unnecessarily. Sorry for the trouble. Feel free to use this if it helps:

  Reviewed-by: Koichiro Den <den@valinux.co.jp>

Best regards,
Koichiro

> Cc: stable@vger.kernel.org
> Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
> ---
>  arch/x86/kernel/apic/msi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 66bc5d3e79db..da5f44a80313 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -62,7 +62,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
>  	 * - The interrupt is not yet started up
>  	 * - The new destination CPU is the same as the old destination CPU
>  	 */
> -	if (!irqd_can_reserve(irqd) ||
> +	if (irqd_can_reserve(irqd) ||
>  	    cfg->vector == old_cfg.vector ||
>  	    old_cfg.vector == MANAGED_IRQ_SHUTDOWN_VECTOR ||
>  	    !irqd_is_started(irqd) ||
> -- 
> 2.32.0
> 
