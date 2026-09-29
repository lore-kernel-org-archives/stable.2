Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012028.outbound.protection.outlook.com [52.101.43.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6339734E;
	Tue, 29 Sep 2026 07:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790666573; cv=fail; b=Ul4T/lwYNeoE1rVWQ2NlE2mFybm+VH397aP31SMnogVqMiCReFhuAabVxMd00/4EKA9020q7JpweXFaLXx/dflBkJWb6wRkhRjvZ3i7aH7P/vyC4i9Dtyfxag6+Jc7U3nBzbEvwSm5SvZrgiFXy5RdA6ZdtWm19uSHd8m6QnmsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790666573; c=relaxed/simple;
	bh=xHgEqaVIPwevKeL5/Iqtk4fr2PjmcWqxjwxaIFxsCfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kj5Xo99m1lRB1OXCGHf69gEpf3oMS3tzVR86E2c9nkq0CeQi6rFPth7jp7OBgmJKPxTGZ8eAEElIcB+F7y3A20YhhCq3iRhRs8tkNIPSOKDviQtRkPCwF5e2s5GTcBPfH2LCMslT1egbOVjw1CYeEgoKcyHHlqYWzDTkmFUx/0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MzHMiMP3; arc=fail smtp.client-ip=52.101.43.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MzHMiMP3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L6WTZzhJ0d4ia7L1b7CRKBACiV6ORqT1oQf6xL6SLoAtSes2AZ4niMv2c0ExGeS4sqVhHYmjy+Jl6zrJWLG5VN7qg/H5XggQkTClQk+yGmqH6KKcDQ1lMyfdzP+EG25AKoF3tod4QU/5GP22WGPRYo9WBT9Wj249JpHHJgoO53R1H+HtSNZgj09lvV+6sYTVRCoqv414M54WNeBuRNaNJgZX5eqvV1wd9z1xBDyPL5DIt52pBpKg1zeHyWJTiVlKiewPF8+tFm5m1wy9I887jcFu92ZV2k0JWerQv6fYqidXcFeLX1n/NLIGdbScpazyVmU4Wk1LWViMm7TPPCoQmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJ61/YcnQ7aDs2OThU5+VFzLTZQj8lc25nh0ahg7F18=;
 b=Omq1oMVwXFDPRlbXBrLfyzSOHs8Tp2oQlTGr/NX9cHCylPXRU12BByS/Sj5eOqyWCND5Y82Pl2+kZ6syySR2EGDqx5/dpLTyhnPnLisIgb7C5kED8kYyRVwMbW6E+5ogI0GDcUK+zQCdtceucnIjoOrvgajstzMCR5vYf7GL0OZznTvCjpW7yz6miISGt39vZkNSA9/x8pMD0hVe2O0MfPkWta+iYcwypw5ad7VtwVaDNnR9+sCYoNQDefhpsAIKiDilV4M2s8PL8gHOex5EaAQmZxL5/AjZ+NNvhwbRlLjVRH2SWwaEgTS595ddmcpG96O7ztqMXQD8K/sWPDBynA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJ61/YcnQ7aDs2OThU5+VFzLTZQj8lc25nh0ahg7F18=;
 b=MzHMiMP3YMa4FbtYGlRBA4JgOHPFEqXGfsP5RabTqXP9H2skgY+KUAlLO8F8D4kUuZ7Ne1hzBjdvv7SBXo/WxRpVXy1T1TXjl2ttSDsS3gZ/p36X+IA+pBgOr9w3hGtc9uJ2/SRDeP15hesT859ed21vHDgsaFzgJxPr8arPUW7GePqbCiUBDGixL1fLcR23glWINTFsaLqm2blZBfGGGgHBPsIuYgAq0cGfbDK2svtjPCzkpdWhP/hWUoeFFKB9zexED03kEyHIL/OOaE95ihstkJ8brC0V0RzP5es1yXXd3CqgVyOv8zzz0UNfFpfevq5oIyMnpJW1vhKbFwcFbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 07:22:47 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::736a:e1be:ec64:5740]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::736a:e1be:ec64:5740%6]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 07:22:47 +0000
Message-ID: <80d4c8aa-dfa7-4d67-83aa-60f9474a5d9f@nvidia.com>
Date: Tue, 29 Sep 2026 08:22:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
To: webgeek1234@gmail.com, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Thierry Reding <thierry.reding@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20260926-tegra194-hda-sdo-v1-1-f7a636a07a58@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0497.eurprd06.prod.outlook.com
 (2603:10a6:20b:49b::22) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: d46298b6-edde-427a-2941-08df1dfa766a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|23010399003|10067099003|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	DMi26UlR5FuN2S+7TgpTFeOSDDHKa0ESQ7K125OQ42guwEOlpENADP3nYeTmTKyN/58NzAlbUM9GXO1dDalX2Jq9sJ8+8oIX/fFuD+wQiugV64J7/hpXBBEHdvMMhZpVU7fRIkV3XYIkjJ1mVL6NBTXYrUuKif4xLB0/kL16JbtZ3C6+sm87CDylfISYWqGzwPD4EPHAqtgvm7h2E0Eozyj08t+YRuNcWJPjv9/3bf1JcmM1K2qD/D3EBmVnOptpRVPjMprJW2FUm8aQl0UF+bSqdKqaaGkcbEg2eTq8WgVRf62AR0ju0QYqnXLD9vEJ7ji16jf9fA14lYBbjbEO91KOLW6S7ad2sv/V2wpyaZ5Y6IHm3qrAR56m4x/AcxBoNMXdX6QAKK1LeEsQjeLDiwtJwM0ls5il2ejJtPTTgtaYKrR7mUYctz62+fhg+yCY2BKE9gRmDyQ3UrueIqv6wvgwAZA+uqKgcaE3dFa2lnW7KNd0lONKhdBGqrrgi7pkqoMLaWi6b6QhnSDEM/FOgRcoFA3jygnbkCFlnA/MxOXWNRWs4ny/eNe6CJ0JaBljlU5YPBAAoGIE4kjxVl1mZBbEiyFRvk+qkvg05eI7hS1Gxs82kJtdCyxMaXZ3AvamKZrqSz3/RyotwrqbKyTx8qzJiNX/2ZgVrlBoRVmkkVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(23010399003)(10067099003)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MExmUFFJSEJRTHJWRG1qSERqUExKWXFZTWlRdms4VHVLZ0k1V096L0UxOFNE?=
 =?utf-8?B?MjFuampuKzhiRjFkRmRWckdPakFEa3NLQ2xjUTN3RnlzSkt6c1d1TUprZTA2?=
 =?utf-8?B?ek5kdjRoOGRDS1hYc2V0a1psUm82SWdsOU5sanYyY0NtWlJKWjNLcEp5Z2dW?=
 =?utf-8?B?ZlVtcVhmMlNLWGV3UDEycjZBNkY4MmJtSFpLY2syMnRsZW5PRUNjSmVCUklC?=
 =?utf-8?B?cVNiTjF3d2thZzdzaHF6Sm5WbXVYMTBUUTQ0SERoVVE4YSs3Q1NWc3l0Mita?=
 =?utf-8?B?RGx1eU5MM1lQc2NGdkpaeXNyNWczaGtlNUsrWUtOVE41ckJNdjFFa01XR1ZP?=
 =?utf-8?B?TWd3TXIyUG9JMWRJc3JUU1JZd3U1SGU0eXFrTzVQWDZKZ0srVlNrNU1IOEdL?=
 =?utf-8?B?Mm5oeVZ4Nyt2Qy9ldWhCNUppK2c3Nm45TWozcThwVEhDRjBFZHFUTGt0Zy9E?=
 =?utf-8?B?TmwvbmFwMkI4UlpWRG9lT2QrY29WaTdURmdURGZZelpRWFVMeDEwVlZDbXFp?=
 =?utf-8?B?dzFrVHB5V1paOXZQVXlQM3pEdTVEZGYydXpmYXVFeEVNVFM3U2VEcVQ5UUMv?=
 =?utf-8?B?VkUrbDZUcDEwbnpRV2ZPYm5jL1BCZmdJZlFxcWdTOG9RbnZQNUE2dUlUaHhv?=
 =?utf-8?B?ZEZsQnYwcFcyNGhOb1hrMVhOaGtOL204K3ptbVlMVmJ6U2ZQSnhrZHpkN2Vt?=
 =?utf-8?B?UXBoUFg5SVFqc3hSSWRPZm5qRVlKVER4anozZWFQbWN0TWlONjdpS29tTnRQ?=
 =?utf-8?B?ZUFRL1F6M1RCQ3BZbWc0Z0JNRGw0Y05MY3RManlhTVNmcmc3ZUM4djNzd1NQ?=
 =?utf-8?B?c0N1aGpacEpWdVpLRndacUk1TkVyMXFMcldtZzc1VXRqWWtrYlFqcmlGWjdy?=
 =?utf-8?B?eEt0dTQ1SnljVnpGMnkrTmNOTXQ3Wk5oRVNpQUVQRjEyd2FtZUdCRnJ3TmZq?=
 =?utf-8?B?dVY3UFVPNTRXY2RiOGJuNnNOdEhBdTZCbFNtY0tMNU01R2tpUFZid2RXaDdQ?=
 =?utf-8?B?Qkpudkd2djBNaFhlRUZFelh3ZEtWaUwwQUdRL1lVMzFWeGdkWWtka2FtdzNH?=
 =?utf-8?B?ck4zaUFzZlQ2RmRwK1F4cWdOR0pTZDUzQWR5dmV0WjNKVmgyMUM4aVNEOG5N?=
 =?utf-8?B?M2JJeHNFQWtnNVBoTkNlWTVWU0hLMmluN3E3VnJmYnJvSjhrYTl5bjhlSHpW?=
 =?utf-8?B?QXkzczFyRHBGOHl1NXU5VlhQU2x3ZVRnRUJjR0NvdCsyYXRPT0lvRWIxS2N5?=
 =?utf-8?B?MU5iakErZ3RneHdRNVpqaHZ1N3R1Y3dwN1ZLdWwrdlc4WWhLRjQ4aXRBc0dG?=
 =?utf-8?B?a29yUGpzR0ZETlVyWjV6NU14WlFSMGxHdU00WWZubXY3dFozbE1PUnhxT3hC?=
 =?utf-8?B?WUo2ZXBPVG85UnEvKzZWYTN1Uy8xNE0vOHJselU5b0JuWk9PRkp1TWZEcEpE?=
 =?utf-8?B?TkkvN01VYitFU0dLM0Nhc1phUHFkYi82M3FwODdlQmdkMGFORkdia1IvMTlN?=
 =?utf-8?B?N05pM29Ma2VIWGtnNXdISThpQmhkRFZnTlJrSG1nVEY3K0QxcVJqdmFnNkY5?=
 =?utf-8?B?WUdwZ1RCT2VXVFBNRlcydk9nd3Rvb0tNOFRJVmwrMFhDWXVEWmR2Vkx1azBC?=
 =?utf-8?B?SFpUTVJ3RFVMTzhnOEhlRzlRWWNCSlN0SXBmeVdkc2c5bXJWbHVIMnRBMnQx?=
 =?utf-8?B?QUY4R2ZBZkppdXVOa2xCOUFnck1SeGlCaklNZndOTDVSSDJnSFJlQ1dkWEJ1?=
 =?utf-8?B?WWhmMTQvREc5aHBQOGU1emhBb2JGbnF5ZmJ3UzdLYnBqWDVIUGpuNEhmMmxI?=
 =?utf-8?B?Y3E5T0U4UnZBNFpOWXdOSG91ZDNIdTcxZEtBUXZuanFaaXd6KzFlYVA5K3NC?=
 =?utf-8?B?RFRmMm5ySU9nb2tCbjBFVWZvTHRLVGZ6NGMyVFMvMkl5LzZobU40ZWpncGZT?=
 =?utf-8?B?cHBSTWgwUzVaeUp2WXlMUmFJTWorY2htV1VqSUJ0bFkxMTFwa0VVS1pmcUVR?=
 =?utf-8?B?RGtucXUrK1VvTm1RbTBVeUFLSjZLNHZJTGpldytyYjdGWlQ4VWwyNzB5YzdP?=
 =?utf-8?B?TW1JWU1rSFdTTHFvSTNwYzZPVHdSUW12eVcveFBaNW9ZVjNKWWNaQ091cDVO?=
 =?utf-8?B?Y29ScUwzbWVDeDQrcTV4UVJDU1dOWUVIQ2xrblVCdkJ6QTZnUm4vYkpiVWhW?=
 =?utf-8?B?emgwd2dmODFQRm1FMVVtb2tkUmlDd1RRZGR5OXNudTdlYll0WS83R0tEcXBs?=
 =?utf-8?B?ZzV0clNsN3ZJcFdtaDhZNUxkblpTeXhvaVR4TE9UdGZNb3hTUVRMaHcrQ0RZ?=
 =?utf-8?B?UmxQS1RmTHBBL2pBRHhaaFJnM0xQQXg0SHFYYUZUSzZTM0FwTjVCRVRZYUo5?=
 =?utf-8?Q?LKdh/GwJJpRBrxyOqHerEFBkTkqbH+L2JdthjeKVzXDXT?=
X-MS-Exchange-AntiSpam-MessageData-1: ue2JkX9FFWcHag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d46298b6-edde-427a-2941-08df1dfa766a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 07:22:47.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YkaLb5Fparhvx9v9Bh7BdkP292ZyQlZRlpWybbltBVmQHQm0YfVhTgB84CoAgHsaQmcau3XfBA3oHfhn6fC+XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378


On 26/09/2026 08:24, Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
> 
> This workaround was originally added for Tegra194, but no longer gets
> applied for it. Commit 615d43540043 ("ALSA: hda/tegra: fix tegra-hda on
> tegra30 soc") changed the guard to tegra30-hda, which worked because all
> affected archs had the fallback compatible. However, commit 7f0ea5acfc19
> ("arm64: tegra: Use correct compatible string for Tegra194 HDA") removed
> the fallback compatible for Tegra194, causing this to break.
> 
> Fixes: 7f0ea5acfc19 ("arm64: tegra: Use correct compatible string for Tegra194 HDA")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> ALSA: hda/tegra: Re-enable SDO workaround for Tegra194
> ---
>   sound/hda/controllers/tegra.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/hda/controllers/tegra.c b/sound/hda/controllers/tegra.c
> index 31c14c4bbe683..674cc0f79c3c8 100644
> --- a/sound/hda/controllers/tegra.c
> +++ b/sound/hda/controllers/tegra.c
> @@ -374,7 +374,8 @@ static int hda_tegra_first_init(struct azx *chip, struct platform_device *pdev)
>   	 * in powers of 2, next available ratio is 16 which can be
>   	 * used as a limiting factor here.
>   	 */
> -	if (of_device_is_compatible(np, "nvidia,tegra30-hda"))
> +	if (of_device_is_compatible(np, "nvidia,tegra30-hda") ||
> +	    of_device_is_compatible(np, "nvidia,tegra194-hda"))
>   		chip->bus.core.sdo_limit = 16;
>   
>   	/* codec detection */
> 
> ---
> base-commit: 4c253ac4b29b8c6cc6fdef8f92d4facde62e63b9
> change-id: 20260926-tegra194-hda-sdo-1d84c6085198
I would be tempted to change the fixes tag to be 615d43540043
("ALSA: hda/tegra: fix tegra-hda on tegra30 soc") because technically
the Tegra194 device-tree was incorrect and after commit 615d43540043
is present, we always want the above. Otherwise ...

Reviewed-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

