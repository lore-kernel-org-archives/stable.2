Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011041.outbound.protection.outlook.com [40.93.194.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C442435FF5B;
	Mon, 14 Sep 2026 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789366859; cv=fail; b=oqmqNHH7KOzj19aQxuJhQ8nbsX2M3j+JlEWA27CzaXz4gjYwoUymWmyRXAALuf9sOaValMYqpEOxGVV2weUyzw0M45HtvoCzKZSEP4K91qgB15tWhLf4ua5+45vCL4vLcig62hUkRjtPAWdTPmqIrPvO0NzUMqMfzQsWfCHd0WM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789366859; c=relaxed/simple;
	bh=jbsSUmAfGqmDfFVFB6mG6bfXzHDC/9MWTrp8JSFJHQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lqDTMmKaf2FWNkM4Cc9eyqZ0m4r8jvne7Yftnu/zLuru7r0KZt4Rtcp9jCz5+efGRkE17JT+esX2if6ZFy/aVpMRmB4PCHk+EOiADrhkwNLGA6//dMjAsTuaZvaF1uvwKduniVywQ2hnQkmORw4K5ZwZyZ0p1A8ra+LNsG4o1i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gvg3FEL1; arc=fail smtp.client-ip=40.93.194.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gvg3FEL1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LJMc4T1wHG1NOZt4pNDnvzFj9UXZaMH4Z8Il66zUnrvblMIF76LjomU+3E2dHNr6ucmsYonqtF6lVIMyJWd5dpT9qEzlKfxp9PNMFrcU1JYbYCz0IyJjXe00O9pxq2xErQjuGfXOnWukbqPDOZ9OzUjxEbQslk13IsL8XldMRafMMgrSFLM8GY5vhgZSeYaBaQ6WguYCnbLD5z5Aw6FxRUUshJMJy7aHlzd5cWIFYWEeSpGTV8NSVEEbq/AByVuYxuIMLHRBIJrV0QZwSqkPezmaKZmHQzeytiUQxOdMJb9IA27ys+iMHTXHLv8O9JVzUJOjgKM5ZNSK4z1ltwzt4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ItVB+/wULudYOF2I08vhbUvDTg90twY9iXDXkXRBhs=;
 b=o+9T6FynDM98yCFCYMbKqLRkiWPJuv/6TwHyIcK1kuOmv59Doe5JWXW8PbzWVGfC+ljworE9gJfU/q0DVYCOU/FAsijWhqd+8/reTwss1+DVSPt+P0mQV/XSi+IKzv8YU0T2c8rblrzvCpff0AsWBraa/sLvmpgDbfaPaO2AjvGVf4aeMzmWr/JQnA6uhygg2v5glYnNlbyHbIbDhav4mJdZWsoIjwtI8Cv/xCpbCRq9hBsaTkLuGldxWgVjsDMtTxywtYrfsLEq1gc7fu0Y6C4zo8yYcdugNlCHg1RLbUI1Q1m4etD39psmD+T+zIUhms5tL0nJ3p+c66BLgNIaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ItVB+/wULudYOF2I08vhbUvDTg90twY9iXDXkXRBhs=;
 b=gvg3FEL1MCYMALfxRJkVVL3WEfExaLcAk4YL0EWlZrb/S2+/bA0ZqEMQY0cAIEyM/uvog/1DVALrdunEKPM6cPYAE4Rvkng8+2G4sJgv2fzwsFn8f/gGNRoNYS1k0A6f/PU0Soe6aRu+G6vuDMumpud4sIyn+D+8AlcQQx3RWiGKZBMbsotJGcof/JKr7QpZ4HYGqZgCLmHzYctFiaHCmMx+a0scHZORDpTEecEpGujIxHTMsAtg09IPusZouCQ/Hcj7iEQn/OeAtCcKwdAriyjmOLZklqd26pN1N+w7Fvsa9POm6OvEs17Wu6p3qf/iCUiWAmJE0fDb76oQey6R3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW9PR12MB999210.namprd12.prod.outlook.com (2603:10b6:303:301::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Mon, 14 Sep
 2026 06:20:54 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 06:20:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Myeonghun Pak <mhun512@gmail.com>
Cc: Dmitry Osipenko <digetx@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] pwm: tegra: Disable runtime PM on cleanup errors
Date: Mon, 14 Sep 2026 15:20:51 +0900
Message-ID: <RjVH6lTrT_KugcUQV9puWA@nvidia.com>
In-Reply-To: <20260913040606.23272-1-mhun512@gmail.com>
References: <20260913040606.23272-1-mhun512@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0314.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW9PR12MB999210:EE_
X-MS-Office365-Filtering-Correlation-Id: a29e0eed-552b-4db5-84a3-08df1228551e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|10070799003|366016|376014|23010399003|10067099003|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	iGOOa2eI/2LTOtQb3UgLiGM8fGWxgrxOJZML2Eoq/CGbwBH4+I19OFCtnHsajIqYwJ9AcP2hFdugLK+jJOmYfTPIXzS8MukREx6xG/6T6VbnkGUIbKmvYQYYCHHjhXYkwM4dsLU9D+nFvFF6eYu/OTNUANbHNP2SnfgWscreh2I9XbjPtg005l+vrVa/Y5xhsKaxXUtifa+YjPx2Z4YB1TII/kni73FsrcexdVpn+O7o5+5Jpatrm02xJvhgtxGPlhnJAB6nGc9eBHXb3z+mmzt2BwRWphTUBS3zeGnlkDOz9fQlCndVGJ/xTm20wKVIf8MFPNMLVvrKufwQUitbVITHTZhHuIFXdQslRopxGr6DgxR3vPXaJDUOYvp12TV3ujwohgnwxwhv5Ct+o51yI5GpjCLpNrlemxolykMXsbf4J1W8ejEY8xfuw7FYuwk5ac5LwA8ROsSMQhXOJErYTEjJlhgjhHxKzzvMfM1nHRDghTkAFkj0OpFXjSrKW0+rxxN+kvxQlH1FIzIDBo9wWjFHpgFm4uB+L01gJ7dT2ap/qu6JGkCn/z1ROPLcPsoaJeEgxSkVpUMAyy7AGDx89Td2eri/br0c7mIxEotqHH3VB0zV9syEp7Hm5VRfX8nssWQLvdJ4YyIvhCTgw0bbqoxpgO/SkUSDOAop6UuFASc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(10070799003)(366016)(376014)(23010399003)(10067099003)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QnVTMU1wRnFqWXN4V1ZncnE2NkZXK1hEZzFWQmJsQUk5ZUJoNGt0NEpUbFlk?=
 =?utf-8?B?dDZYY0d4bUxPRXdjMENnU3RNcnFPWjNHK2Nyb1J6NWlHRmN6Z2VncnRtcUN3?=
 =?utf-8?B?Q3NKWVc5WWV3c3NIYi9Zb1Q4RDM5OFNIOHdwVXdRYUt3V2x0YlhNa01DY0U4?=
 =?utf-8?B?QTQzeUJrbUFoSy9RTHJTZXJIN1o4Q1JydldvSXpRYTEyMER1eDlXMWJ3TkJZ?=
 =?utf-8?B?QWd6RUR0MnFGdVZibGdrc3g2QytKRFJsWFNxRFJORGpnTzUva0ViRloxMTE0?=
 =?utf-8?B?S0pteEpreStWVWc5VXRIUkcrZTJyM2x6V0xLS0o2VFoxTFkwc0pnZzlmbGY4?=
 =?utf-8?B?cXQvekp4WWFydFRQVHgxMi9XNXV0NEJkT2N4V3lqdVBlK21uMkJxd0FTVnNV?=
 =?utf-8?B?QUFQQU1XZS9sZUhOTStQQXNFU3hQbk1ZZFptU3ppVDBSOUJKeXkvaHE2dk5v?=
 =?utf-8?B?MHVBUWNPZzN1WTRJeUxQZVNQbDQxT3paL1E4Qk5FOG5XMURoWHRHdDgxZUt5?=
 =?utf-8?B?MnhIS3RrdWswWmdCanJlWmpHQnNGemRNc2hUVFduUjRiN1ZERVZleTk0UzJo?=
 =?utf-8?B?VkpId2JFM0FkaTJ5NUM5UWcrcFcvczFCQVUzSFhXek01NTlkM1NxaTZEUG5n?=
 =?utf-8?B?bFdpVDlldnF1ZWE3ZFBOT2pYeUJlZVlFamwzRm9yTVFMU1ErNUVXeTNEM29J?=
 =?utf-8?B?YkM1eE9XMlptNXUyWFVDRGlGRVFmbjdRZElyM2U0Q0RRQ2ZZbjU2NzlBUHho?=
 =?utf-8?B?UDJ3dmZZTFFhYkg0d2N2MEI0YlVMek1IY1NRVXZLWUV4WEQ5VXl1ZHAva0NV?=
 =?utf-8?B?bjVFM2tveERUYkdocWIrNm9ETVZESFRtS3F2SjRUamhUN3NuZ3duS2tOTnl2?=
 =?utf-8?B?MTAvSy83NkJWeFhwV2xEVlBUQ0dKemtjSmMzbmpUaUg3QjNqajUwcVZOaTJB?=
 =?utf-8?B?dE12ZnY5b2tIcWZ5RzNnTE9Md2FZb2lNb3ZoMnhPc25SL2RzT3BYelFKSXJh?=
 =?utf-8?B?WUc4N2I1SnZrYXB5RWZzVHFtKzdOV0YvbWF3bmo2T1VZeUJDTStBWWdmbVdk?=
 =?utf-8?B?bjdtOTUyMExiTFE3ZitPaE11TWRTSUFlUjBPdlB1OHFjRFdYUWNDWEZBZHpu?=
 =?utf-8?B?d0ZPbGlmK3U3bG04YzMwUEY3dGRXMDhMbXM5NXUrZGY3S3g3YkNkQTE4aXlk?=
 =?utf-8?B?RGY1bXFJNm9qMUtQcmdicTY0Tm9kenJZSnUzdExqdEVpMDRST1JoZmpVZHgw?=
 =?utf-8?B?bGkvTUV2dG9PYnlGRTJsZG1xbEpPQld5cXVlUEE3K05nemVXQUNlMTdMTXlv?=
 =?utf-8?B?Z3padVZqMFRvZzFCRUFreUNaM21vWmZ0cFV5dzlzaXo0K1JrWlZtT05zcEpk?=
 =?utf-8?B?VnF2RWhxdEhRQ0ltR0Foc0srVi93VnBLWElBbHY4ZjRaMTQ3bExyZ0o5OFlB?=
 =?utf-8?B?SDZ1elo5ZGpaR0R6eXB4cVhwYjg3RDNKUFlxYjUxZ3R3NjdlNzJ1ZDQ3RXAz?=
 =?utf-8?B?R1V4SmpJVlJaQzk1YnQyUGI2MlNDMlZXd2IvUkR6WHBzUHVNeFJkbm44aHNM?=
 =?utf-8?B?TjNqUUUxZGJkRmNvNHUyWUgrTnlDcVI3ZzlRM09BREZPa2hxN0NFb0hhQ0tS?=
 =?utf-8?B?eENaMDFERWlnL0YxaURLT2JYSFNTRmhhMC9nK2pQVlRMKzQ4RS9sNFg4QlVl?=
 =?utf-8?B?QnN3QkZVOVFXS2RhbGwxRkVIem9oeDJOSUl5RGI4MzEwTXpyUGFFREFCekl3?=
 =?utf-8?B?aHJpQzBscVc5bVJ3blQ2ZDFSWGEvQ21SdnZtY1Z0Mm45eXkzNUY3bHF6cEdK?=
 =?utf-8?B?OExkY00xNTRrYzhZNTNxNXpWK0lFYzBqQ25ZbldHcXVldnpVNGNwSVZaNFpa?=
 =?utf-8?B?L0F1YnR6b3FPZVRraFVQWXdrekl5YVpqVVNEWklsb2piWkZtTnRCOWIwekcy?=
 =?utf-8?B?TjdBdGRvTVhnYUsxRkEwVUZicDFINXVYSVRTV1pKamRvSmowbGY0VW1XYUtw?=
 =?utf-8?B?WWw5eXpvS1FyVnB3SGZQRjUyaGRpcml1M3ZsTEp3ajJZdkVrYXhHcCtQbS9V?=
 =?utf-8?B?MHBuUEIybkYyRHBwTWUydEUwdDM5eEhtZlRNdTM2eHd0a0dLVlRKLzhRa21z?=
 =?utf-8?B?REJwVjN4QmNDWlExYTBrWnIzTnRjYnpiSFlTRGZ5TXhRN1ErcFBSb0FGYi9o?=
 =?utf-8?B?YVNRTU00QVVCbzVOSjFtZVRONDBKWFFpWDdrc00rU00vaUxkY1d5c2JBTHJo?=
 =?utf-8?B?SFo4d1NPdExVZ2ZWb000R2RrZmZMNFBIRWFtZFVseDdodmlaY0hxUEQxZCtV?=
 =?utf-8?B?RGFYeE0rVTUzcjl5TzB6VXpJUGQ2VEJ3Mjd1N1k4N3ZnaC9xY1E0ZGEvN3BL?=
 =?utf-8?Q?E6/Brxn/Vk+YIbIVQM59EKcGhrMO1L66cuozRpd5+34UD?=
X-MS-Exchange-AntiSpam-MessageData-1: QR5w38foMcFGmA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29e0eed-552b-4db5-84a3-08df1228551e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 06:20:54.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILPH9wDjvs2+eZ5c4NizQqDeEpCvb4/cBiI7bMviUSoUloANYV/pL7JXpDbyvJUgmKXKpZsxBiMjYvH1oLMdug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW9PR12MB999210

On Sunday, September 13, 2026 1:06=E2=80=AFPM Myeonghun Pak wrote:
> tegra_pwm_probe() enables runtime PM before requesting the initial resume=
.
> If pm_runtime_resume_and_get() fails, probe returns with runtime PM still
> enabled as the managed driver resources are released.
>=20
> The later probe unwind and remove paths use pm_runtime_force_suspend(),
> which disables runtime PM on success but enables it again if the suspend
> callback fails. Ignoring that error can therefore also leave runtime PM
> enabled during resource cleanup.
>=20
> Disable runtime PM on the initial resume failure and when force-suspend
> fails. Do not disable it a second time after successful force-suspend, an=
d
> preserve the original probe error. The failed resume_and_get call has
> already balanced its usage count, so it needs no additional put.
>=20
> This issue was identified during our ongoing static-analysis research whi=
le
> reviewing kernel code.
>=20
> Fixes: 3da9b0feaa16 ("pwm: tegra: Add runtime PM and OPP support")
> Cc: stable@vger.kernel.org
> Assisted-by: OpenAI:GPT-5.6
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/pwm/pwm-tegra.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
> index 5cdbe120b..55287afcb 100644
> --- a/drivers/pwm/pwm-tegra.c
> +++ b/drivers/pwm/pwm-tegra.c
> @@ -346,8 +346,10 @@ static int tegra_pwm_probe(struct platform_device *p=
dev)
> =20
>  	pm_runtime_enable(&pdev->dev);
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
> -	if (ret)
> +	if (ret) {
> +		pm_runtime_disable(&pdev->dev);
>  		return ret;
> +	}
> =20
>  	/* Set maximum frequency of the IP */
>  	ret =3D dev_pm_opp_set_rate(&pdev->dev, ULONG_MAX);
> @@ -395,7 +397,8 @@ static int tegra_pwm_probe(struct platform_device *pd=
ev)
>  	return 0;
>  put_pm:
>  	pm_runtime_put_sync_suspend(&pdev->dev);
> -	pm_runtime_force_suspend(&pdev->dev);
> +	if (pm_runtime_force_suspend(&pdev->dev))
> +		pm_runtime_disable(&pdev->dev);
>  	return ret;
>  }
> =20
> @@ -408,7 +411,8 @@ static void tegra_pwm_remove(struct platform_device *=
pdev)
> =20
>  	reset_control_assert(pc->rst);
> =20
> -	pm_runtime_force_suspend(&pdev->dev);
> +	if (pm_runtime_force_suspend(&pdev->dev))
> +		pm_runtime_disable(&pdev->dev);
>  }
> =20
>  static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
>=20

This driver seems to be good candidate for devm_pm_runtime_enable. Using=20
that, I think we can avoid any calls to pm_runtime_disable or=20
pm_runtime_force_suspend.

Thanks
Mikko



