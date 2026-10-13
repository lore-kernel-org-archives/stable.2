Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012024.outbound.protection.outlook.com [52.101.66.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA2EA5237A3;
	Tue, 13 Oct 2026 20:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924599; cv=fail; b=lYcbkvZoTsXDBiwZAMA01gYuirjp2UKRyj6SEYVfK04+nrrWYoPxsEWIZNWZcEPL1QBjz27kIm8NoQc4r302XxKa6UUDgPqMZVZqerfYvCPbfUZGKJrq8CLizN9tWbVofcvaFWeW6ydQXuLW3r/1106jWw36aXmWnsaajUag0x0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924599; c=relaxed/simple;
	bh=pKXnJ2xOqzu1012+aU5LkR19rAcUPRofTtlbv7TU2Z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fZmSteO1h9UXjhIvXGc/0JZgyG11LT+f3l3bARSSeaYxsn/Nmom5bfpFYY2X3EeTjR2ikGomUpUskbUVzvSya+PbiexSK+LkAyAWseTzgHWPqkFi1ltn6bJkfENx1Vnh4TINOzLM2TUksQ39TZduTtMNP+qyEpiPRDpe0ZxDh64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=kPZgO6uJ; arc=fail smtp.client-ip=52.101.66.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kPZgO6uJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=afPoYmLN0ApPZKayJXDZqJ5c8C5A5+9D4b3ESPc0ikgL4NjWinb9u9e7Pvrwy4ZIwelPx7jU8yuSvyYZqlU/IF1G2Cc+Gk08v7u+zl/5+fVYIsvqxBHBTkT9zbo2BFB0jZlATJ1FMiaxl4QUk6Gdeo8BadCdIZaGSaCC8WqCTChjiN8uSiDQoqaMlWqxFigqlChBLjYCNA42gKF96Xu+GPH1ZbHyEaeYJfzHLdhHjjKxuHM4DK9OB3kGOVYPzsqLbaazpRuyDznEbZ1/ipk1dL24O+0X3piuaY+b3/63Nk3EAgQ9/CIxCZekLKYcCbH597IzqLnEz049w7IxMQN8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Go1o+no8SYY2iFthQpxyIdqUa/p66nYvSVs0v1GaWiU=;
 b=r2vYDSPdgikZ+wCf+vwxMsk4EbrXrt7vTrpqhoa2guklAPsnXyYNwnyIR10X8NRkz+3gOjsnWrZ9nF5x7QIfmxbpisgELTDPEC8mUFAyG8OoyrKJM9Rq5+/7Hp3+J9GtnpZPJ0SvMa2VODp/Xpy5iph29RI0Dslx3221XPalk3uTwCXITcD1qMUCSAkVDYP7Ggf/ucoRxSNchZqIv4u4c9NdLEXR/aVB9+Yastd8nBSXPrfkwT7LrimxkcG/tOS/Fs4MB60+aFpVqIOtKo0GYsVDa/fSQOyiI5GYtpiZNMTrdQC7usHgUMlbO+nvSOo4byAZT7jZayDWDiRWQ08sIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Go1o+no8SYY2iFthQpxyIdqUa/p66nYvSVs0v1GaWiU=;
 b=kPZgO6uJC2HstduOhsp35Z72o6F8HjOakrePQqG1I+bns6dwbwcsBv8bKg9u/o4IffNZSrgQ7u2rI8VVBkKjHKWPujZZM5pry3hU6BlKmojd02pEuLEDpy5DE+d5hP/9oYYoiBPM6cl2PJWGUVTwh1LtQTJNAtAyT3LCliEclSpzhdlGb2uWbnDoxSfdtLoElyXbz/mWyIxizX7H0lRrbTlCWJeuV2bQhPntLbeU4YPpLVN3Pz5x3zYo/hb5FJFnJAqokt7j1/audDOgIgoEZAklhqJQ0kuLnnLVYfxZoVn1E1d9EhLmwPU+vDQf8kkbe5UDAy2sX8JWu8GOLklUXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by VI2PR04MB10689.eurprd04.prod.outlook.com (2603:10a6:800:26f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 20:49:54 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0522.011; Tue, 13 Oct 2026
 20:49:54 +0000
Date: Tue, 13 Oct 2026 16:49:41 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] dmaengine: qcom: hidma_mgmt: fix autosuspend cleanup
 on probe failure
Message-ID: <as6ZZXtckWRPMuVQ@lizhi-Precision-Tower-5810>
References: <20261007122534.194286-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007122534.194286-1-lgs201920130244@gmail.com>
X-ClientProxiedBy: PH8P221CA0018.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|VI2PR04MB10689:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e50f72-25b2-443c-ee71-08df296b8888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|1800799024|7416014|376014|366016|18002099003|22082099003|10067099003|11063799006|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	uldxNxR8dQefHOE5EwBzAEjOKPFHHmVr43Cx+nz/Icnljt6IZqmL0W5y6k0g5cYMMeQpi8Mdrp4RxG2VS1xAEx0PVe9BHXf4jf/AJuzBuxlBbezBpsptyRkiaBoG0HdjSv5WIiTyhhA216XSvLa12nQoxUqbP4CccW0nqKNWk/10jvCrmnAlm8AaFTflHhaWACgTtjl74zraJ8Rw5YtzTUt1ik5esE2jIh9KU+W9PKJRn2zJ0Ndxy1DDRKlPhLr9vAMU4jAZxu4XWyut93JTICXhLc66t92otZrihRPrDoQsv75s6EHxUoIxWhfUQPWc8S5duy4hH/Vh2aKJYA+f2grxYYcK7w48Xg90QZAAwX530r7hROUNZj0XxEfQqIlluwFYDzBDsYstfZeY2I4NSUzcJGI+9uVwb4Ah6YwE4AB3i6ThUTlXMiF+EQrl2X/S3A2Yyyn+K0Wv7sZtzylvh13CWnWC/XjV0gYhPARGgXQNY+dFWTyMW5MgJdzKhKn022m7j4VRcMVvYLljCyfrgeIOuxB2p2DeSKL9daarJl9HRKRAXYdcn38iVASUQcB95uCeWYVEykIsGdKcQOd65QyXslVvipVxQuGKxecFEPD55ZoUkXSCLaga46VwDPhe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(11063799006)(261009221227099003)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q4OEY9huvWKNrctFZFbpwueSZKTmEpabFoK9Pw9yyieofsWMjRG02JAANB+N?=
 =?us-ascii?Q?fpYFgXFIQ7xSzVLaVhG8EeXUcWyf/2/FZcRrKV0QholPzQ9hteoiHqTeqURr?=
 =?us-ascii?Q?eccMGzomn1YWGuVZJvWyKKJtGJuzcmuXrvUg58jKH7BorEpAfnHk8AEW15Ih?=
 =?us-ascii?Q?eRSH0/OGB9dr5A1rPyGJGqQl9e5kyeXhzFn6dwNU+W198xCIncpZBHw+R3ra?=
 =?us-ascii?Q?MvuWfPd2mNhdDlBd65LyMAELpBD/fdw3hkhwPujrzfo/lYX5XuqoLlgzzY1D?=
 =?us-ascii?Q?NPJ18e0NwUVWuWbI4/wHr/Rfg/glepQTgWbhgQ079w5sgle8o2kNmpclzuCA?=
 =?us-ascii?Q?VmIun/AK7k6sizbTmyUdwtBz3SDlYEKzb4oegVDkVqpQtS/Xtnq8hCMr+iAK?=
 =?us-ascii?Q?skAuoBuWySxNG4W7FjfajRVXAR/9wzAoNvmF1jylYeYf0m6zBohbB6hFvnlv?=
 =?us-ascii?Q?8IsVD6738pbfYITvI59w5VxQ0x1MpGu8KmdXfEJbJkr5J3z05i4rNFSPfkM4?=
 =?us-ascii?Q?lNvOs+Q04mpdHuTDcd1f80SwvtHdlrXnQVCs7E2MmRteTPjz79RBJBQZbT3F?=
 =?us-ascii?Q?Tv0e2u8A3Ha/90Qyd8AIfAA1KMNLmekheDsRxrMLvOkjrGg8CCpoyyhkpxQP?=
 =?us-ascii?Q?OM2wasIF1W5oP118OeNpoPTunedqWRst3ZByPcHyCVizbO+9bhoOqAf5+oEQ?=
 =?us-ascii?Q?eGPA3QmnYI55VmABmNVqGCUidnkpAShBPWa6pwF4R2MSypDmFGcjT+NXkByX?=
 =?us-ascii?Q?7tSKTQ40JA+I3o9/xgvIfIDtNQwII3s6x37N4O/nPODL9/hfuxblYVK3fMX2?=
 =?us-ascii?Q?w7bXrU98a35cVpk0X2FvEo440sf40yjiDsUxQ/1LjBHih22NJ2lLDq+DnER7?=
 =?us-ascii?Q?TaIS6AiOBae+ZvXyEOCWn3t2vf8ax+figC0JFBJLMBTnsDsHWiGVPbU5mwmJ?=
 =?us-ascii?Q?IX0lG03rCkGjl/Xbk/XMCmYgHC1HH3wPFhmUdjjUGVd08L7N00kgziafo7p1?=
 =?us-ascii?Q?PqaV5z1Py9/AT7SIa+DpNYYkJyT7qYjh3zI4IKlCGIK3LTwOkh8aIw7O81gR?=
 =?us-ascii?Q?qBAVFeagg4/FCrB+X981E7u9jtvDYn70eSfnuOiqRGfivd812duY/IFG8PBL?=
 =?us-ascii?Q?Dn27/Z8u0t0OkBj9TgdJHB6Y7yjpl0TJ29SJK4tgYtM8t9mSaoMq2HCWwNql?=
 =?us-ascii?Q?l4+nRbOjpjsdY06bsYW7mCt8w+ksNq39jeRqvRFqNILLk+mVOHbgnuS7DIKQ?=
 =?us-ascii?Q?7E1uEYxE6bo1f7dx6QqmgGUs9vMQnrKshFFm1SOjWDrUWPo+ZIlTjOLyQz6x?=
 =?us-ascii?Q?jIT1XQ+s9PWMwWQS45yT/bj7dAGo8Jm78Xs83H6DfVGcX3T+dGGtL/980QqG?=
 =?us-ascii?Q?McRbxX6wbVuaeOb/djvE3oAH/qyDPpl+9Z7yFZO4wShH7gOwqlgccUST77lr?=
 =?us-ascii?Q?tpzeKwrNYH4gbkjOU/ITVbYAc4toOdeIGUDGBqm/iwPD84YkT8TaO4L4SAJQ?=
 =?us-ascii?Q?sP/67xgy9gv7hHdhsjwiEHcRb1KyeU89duz8gyCNnJDYc0wTLsHfNVEm29et?=
 =?us-ascii?Q?aoZyMEaX4YzNVXTZIx/t1HiphE+xIiqENRj13h8hhnZiF/RgKEe/36Ja63tf?=
 =?us-ascii?Q?5/FsnQwMQBbU3lYWeF3mdIM+8Bjs+EZ/Az4/9xaLutcOmqbGNnhs0f7JUWhx?=
 =?us-ascii?Q?rv5I/r3qXgSRmsL/kBqbOMRLfkm0JTDUcqnE1tmdr4dtKTxTELoSM0eyTbLN?=
 =?us-ascii?Q?3An2Z0Ft0fsdJK373TavqWckkgJwh53EmnuZNG7+0JZn+hW9QCgS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e50f72-25b2-443c-ee71-08df296b8888
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 20:49:54.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mt86pRFHYUAdkR1EN0WKZR6iA2BhOUWWGGhDSH78LPKMUgM//ZjMU3KXIU4szNg6Ef8YFDhPad6Zwq7n0Lu6ypKsPwnEQyuFE/VRjNBbzQqSJAWECmc7YndsV/+TUmQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10689

On Wed, Oct 07, 2026 at 08:25:34PM +0800, Guangshuo Li wrote:
> hidma_mgmt_probe() calls pm_runtime_use_autosuspend() during probe, but
> the probe failure path does not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> failure path before pm_runtime_disable() so that the autosuspend
> setting is properly undone during cleanup.
>
> This issue was found by manual code inspection.

This patch is not needed after

commit d1706f9da9f40dffe8621cc0ee03b847f41f1d6d
Author: Joshua Crofts <joshua.crofts1@gmail.com>
Date:   Sat Sep 19 10:24:28 2026 +0200

    PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()

    Add a pm_runtime_dont_use_autosuspend() call to pm_runtime_reinit() to
    ensure autosuspend is disabled on driver teardown.

    Suggested-by: Frank Li <Frank.Li@nxp.com>
    Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
    Link: https://patch.msgid.link/20260919-move-dont-use-autosuspend-v1-1-f6e2d1315c23@gmail.com
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Frank

>
> Fixes: 7f8f209fd6e0 ("dmaengine: add Qualcomm Technologies HIDMA management driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Add the missing changelog.
>
> v2:
>   - Keep pm_runtime_enable() and explicitly add the missing
>     pm_runtime_dont_use_autosuspend() call in the probe failure path
>     instead of switching to devm_pm_runtime_enable().
>   - Update the commit message to match the actual change.
>
>  drivers/dma/qcom/hidma_mgmt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index 4805ce390ffa..d8c56af5882d 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -310,6 +310,7 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
>  	return 0;
>  out:
>  	pm_runtime_put_sync_suspend(&pdev->dev);
> +	pm_runtime_dont_use_autosuspend(&pdev->dev);
>  	pm_runtime_disable(&pdev->dev);
>  	return rc;
>  }
> --
> 2.43.0
>
