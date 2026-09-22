Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F84F528444;
	Tue, 22 Sep 2026 08:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067346; cv=fail; b=Lg70rc8cypeQoboIK63K5CwQi87jXopb5rJaiYL6PhnXMOTCyBTTeiGHZSnekW/7w55XTG1cWul5hfTftO9KtimgBbuxkb3FtimMp6/hqW8v8m8nAD2A8PfHVGbKZB1+J74W2JySHNt8iFvRTsV9Gaf+u5kE2FQNZQglkyo6SiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067346; c=relaxed/simple;
	bh=1JwjY5TIvG3KxcFJjNF72p91h0bCOFuIH+ox518dBy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=temuhLivpaAd4w52I4nuvuFdBKSG5ZQdmlmXRfQZmcH/zwZEbnT1ZaZaVh90dgcKO4k7VTb+dyNDmJ9auBNDDuX1+IbSvaNGvW4zDfbrmcsAdsUS0Evy0W/AqRHBxjL0+uXOtUPnmO+MkedPbROf+2crPnt4en21FLfPKNPThJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fzG8h8UK; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=b9bjr1Pz; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fzG8h8UK";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="b9bjr1Pz"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M4r5H52920621;
	Tue, 22 Sep 2026 03:55:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=HE3jvacHiPm3RyvhHL
	kYts0ozAgVMyuwZoHsqWy/SIE=; b=fzG8h8UK5klYv0eLAnTkdaEd1H+bC6VZbQ
	q3ti3boA6z3i22JCZUk2TgVtqGdtc4RcwlQ7+XMMu6J09PFhA209Ph2yIPPwrD+o
	rmooS/uasYHnfpe8WqJFCzp+g4SCBz9/yxmeDFpf8QXkKO5lQbhikRyPdBcIAV0Q
	IssE5EvgzgFsmswT3i7EhiB/LUWGDUhP6dWqYH4hjDUGsPkaUbCnyQl/LTNnXYgv
	xYSo+JsNIU9iUHdktk+KMsCt/+jxFM/hN1ADguPyR9UtBqxfaE8TwhlllmMwI/Dz
	FSvBMyJduJ2Z6d8OGdqUOFc7Dt/6AhlyGxLf9kM6CvHthDaN3hgQ==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11021140.outbound.protection.outlook.com [52.101.52.140])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gsqt0bhem-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 03:55:25 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teC53fL0tsbGhKrRmgHmSOoiVRVS7DEjFOncC9tupoQUU9nNPZLUDNOny3LjYtzITMWkgg5DP7iKwQwleLthg/C2r5vTaNMnq0Ih8akrjPfkIOiLWfV0OgwP3YhzkCgaL8iTuAs6n9MaVPAWXPPmyLibd0M4r+ZsqRsJByJHtwV/gr9WVerWGYGln/Wf5fTYImvpQ0j63BLPovjCaTEyPZiOieuByqXNZkgUjo4CBuZGL7od6+nBxCkejCpLo83MOVP8DTvtN2pjmHVwA3St78apxpo2MqZDLvgoVBZihFP+RiPHbjEq7KcgzcZKE6DGhY+lhmTr0vkQSmVYIub56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE3jvacHiPm3RyvhHLkYts0ozAgVMyuwZoHsqWy/SIE=;
 b=VsukUnfbQVRB8Nf/Uby18rzTk/7/rYScUEDbBZ4LQlPusgAlIukMnuEcD3RjyH/1pWGgDerXVM2T3mkjz0f1eBY+7bKyWuuLP0wfpLzce2BEGYxgZQm20SKQodkmw/cSDQoTCfmlIEFxd223XrKl/6kCp9PJqjZ0bXUubxJu7V02bAtTZFhXEwsB0an88aMJDlFp97VRjfeQASdv4UHly3OLj79+5ByRz69b6M6BI3jQTIJj29YVe0u2p9MdBiSKlQbJ4+2egSAqsaj3P+kUD5yaU1y4/AKIj+T0p6lPczkP3jwJNnOQb4tLh22CcKfbWfLNy28rzfC7wIwUSkbllg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE3jvacHiPm3RyvhHLkYts0ozAgVMyuwZoHsqWy/SIE=;
 b=b9bjr1Pz5miZ6/1xga96pGZ17aI83s4d/SSELezHye6H4BridprmjAtumW8Lrqca97f9lGJmzdPBPZYJa7KEQr7nDSWUUYnKPCv4JSkT5EjTE065533iS56jTiTtfhedZDwxxebxoqrQ7aELXerWIZCd12PGRzWeEqJw/y/aLuA=
Received: from SJ2PR07CA0012.namprd07.prod.outlook.com (2603:10b6:a03:505::13)
 by PH0PR19MB4922.namprd19.prod.outlook.com (2603:10b6:510:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 08:55:20 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::44) by SJ2PR07CA0012.outlook.office365.com
 (2603:10b6:a03:505::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Tue,
 22 Sep 2026 08:55:20 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Tue, 22 Sep 2026 08:55:18 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 8D9B2406540;
	Tue, 22 Sep 2026 08:55:17 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 68AFD820247;
	Tue, 22 Sep 2026 08:55:17 +0000 (UTC)
Date: Tue, 22 Sep 2026 09:55:16 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] ASoC: wm8962: Prevent mic_work rearm during removal
Message-ID: <arJCdFoeSM+YX7hL@opensource.cirrus.com>
References: <20260921235724.533472-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921235724.533472-1-mhun512@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|PH0PR19MB4922:EE_
X-MS-Office365-Filtering-Correlation-Id: b9e4126a-ba9b-483e-abf5-08df18873a9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|61400799027|36860700016|23010399003|11063799006|56012099006|10067099003|16102099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	a9vh0tbWk9Afp1zZyTlnOHT3JL1BDop0kWwXd4rdy8kzN9mykcQ+f9OG8TmkJnmG8wyOvN96X/Zz879iVMjHi5631HUQ43E0zwpSvUzKOwYDGXlWIzhod/TY19BwCTZo5e3kRW+VfLFczyTXbv7C9DiG4syn+0RtN+RNRPq2uAg3Dp8iQwYSagZVfhm3Y37zbkhsVRAqGVCCrv82uDJmLJNBQlm7nNJKjZe63w4NIT5ZtoYmOwwnHV14Ir7lzFcJTwgYbm/lmU5STZNcXBJoViwHRznoXoWAqgoSSMfA703+/ckIJlCSjqA+T6cAWJFy/3p0TZRkgTJfrkN243TYdKQ9r4t2uDmZELgfSWZVVrr7pnJE9VJ9Jsx7jMVtsG+DVBdCBtR2sWnMDD2yUVlGFAYq6YdUnQIcHhvx/MfaosLrz46cYgwa6QTkUP56qwGkd3GdsahcZQzGkrlMOI998IUyfGqU7PWWr1RD+WVVAJwj7qSaYIBdl51c63UqO2cAcTixTDpuKSeKbyxbp2e0Y2as2cVmfmyIkM3qZ/g2TTp64aWlvI4ApstScbv0++5j32HZFv/kpk9Wo3rvrLoSLwO3SJxrHwl1QgphTrZHFgko0IpVGTK05X9x19PBITS6sNZVadxCxX4mqeqLTPnioqWWMOwb+TcFYdDnI2BVVGiL6BiKN22dG3DRq8FxOWdZiCKNAkstaaPtCI8z0nA6BA==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(61400799027)(36860700016)(23010399003)(11063799006)(56012099006)(10067099003)(16102099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	n65vVIWVG7+ea7FujmvzgG2p8uaDbo5nJvZN+JvVzhsHq1Vu7/LcTSafBiaH7a9mkt+3HYh1A9wJOUrrv00b9gyOXZzEYhSKH/xG0cc7gljp48npn2fNWidtO6xnV7AIO6QaJRZZI3VjArVzG5lfztTdbcUZarl3MCsRqIa0xmVpuRBea96T6+eawhKjz0lNGSoeVMrgrIv4nhc8LotJhE20RQlOhD0/2LngAa0t7cwnDVLXK6qSKWRmLaDvxxw5mJ1jAdIzHOBTQ1Vn5SW12rRIX/KU/ADtZv9MN/tSY4pI2ox5gNOr8DlJ2G98Jb0eyPwGEbN85RRxK1RqSQWmbV06Dx6Vz/e7y3NXSOLVmP7DbvmS1tEQLRWfZIytoCOtJ3QFMmwhINp4yvDTyTivxaXoQ7JoGuFiYtybkiwoll9Xz+cDhzDBSGgqs3ShdEud
X-Exchange-RoutingPolicyChecked:
	ED6PSqPkiwod9RMoLF2MSsPCo6LgR7lZCLZQF73f/WaoNQZN5rwnDzJjNoGwDC2uImRbSFlkqQkP9wqgLysXlJ0/MAlRFAlbPbl/4KlJaL9B/sl0hYj27Ls9XhyB9T2BOc5VV7lpRW+wBS2tPEBUbaBcOxz/YKTdYgN7r+BoRFHkfsA0d7F/gw7i4Z6f8MOM8XG/31LZZI1SSLKU5XK7XC86Sq+H3R01GvhM1jBvTTHZw6glSpacT7J4kTQrdqJx5i90Aas7zV6qNtSJA15764Kwt475QjkCQ1NyLsHiy0Gj1pvuCefI2ce7ZZ9C31fRkgF2teCxz8WfhyEztE/4Bg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 08:55:18.9462
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9e4126a-ba9b-483e-abf5-08df18873a9b
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4922
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEyOCBTYWx0ZWRfX0XfzTUfbBWKo
 egFipAD1AzScxqfgTymz+24pQnxLZtLSrwFHSUVoNURY1EmvU5kCSZWnohK+HJlhqrl+JUnnvJb
 7GgXGh1u/jibS7Ec+5hFisPUc9pvb1EWZiFZLfqp3x0WaWOprux3oD9KnOVKxeucGRKHOuiPUVs
 Ao8MAm6lQztQh61mFYB+boA8vb7Cjl9D8gUr701DJZjuvrWVCsCG1QlxZ6tU6A9DyYznbjT3ID1
 kFSbpcb2XN4LYzv72L4gxaOMiaX5zkYU3nE4nO9MtTe7E/Ue6J7N61YkOdPdR2mXUHTs9rHgJa7
 y0JdJJh2KNMm5XtY9Ggj5KFWcaewu8YuLfV7PUhwoso0p0auIeaeJyEp6VKDH7zKWaCfOL5QIzr
 qiZW6z0P8G67t+HyvxefW59NZgfTXEw12j/7vIa3fFjyjP9ROrGJdVkNlqTnFSLWF5mCw2Pb9Mx
 ZHFRC2D754HEoaETsEg==
X-Authority-Analysis: v=2.4 cv=TPTQ2Fla c=1 sm=1 tr=0 ts=6ab2427d cx=c_pps
 a=gYwftH0Zntp9Uye4m1fzyA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=M6tK6H-xDgpuijqxFgQA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: T7su0xRC7k3n3x7EC1FXXFupTS1hyTaS
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEyOCBTYWx0ZWRfX9H/8zWN3+p0H
 k+WfbYjIxHPknRrB9DXQHBMNk0UVRjC4VXciM7xkWo3Adc3o9J5MeVvGmrOPFN+y9gMxj6oUxg5
 ZqL2/Gecu4M5azHFgdXicZ9bl/+yFR4=
X-Proofpoint-GUID: T7su0xRC7k3n3x7EC1FXXFupTS1hyTaS
X-Proofpoint-Spam-Reason: safe

On Mon, Sep 21, 2026 at 07:57:24PM -0400, Myeonghun Pak wrote:
> wm8962_remove() cancels mic_work, but on unbind that cancel runs
> before the interrupt that queues it is released.
> 
> wm8962_i2c_probe() requests the interrupt with
> devm_request_threaded_irq() and registers the component afterwards.
> devres releases in LIFO order, so wm8962_remove() runs before
> free_irq().  A MICD or MICSCD event in between makes wm8962_irq()
> queue mic_work again, and the delayed work then calls
> snd_soc_component_read() and snd_soc_jack_report() on the freed
> component.
> 
> Commit ca50410b731c ("ASoC: wm8962: Move interrupt initalisation to
> probe()") dropped the free_irq() that used to precede
> cancel_delayed_work_sync() in wm8962_remove().
> 
> Disable the interrupt in wm8962_i2c_remove(), which runs before devres
> release.  disable_irq() waits for the threaded handler, and the
> existing cancel then drains mic_work with no producer left.
> 
> This issue was identified during our ongoing static-analysis research
> while reviewing kernel code.
> 
> Fixes: ca50410b731c ("ASoC: wm8962: Move interrupt initalisation to probe()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
> Found by inspection; I do not have the hardware, so this is not runtime
> tested.
> 
>  sound/soc/codecs/wm8962.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
> index 8a9598161b35..210ec96fab4c 100644
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3890,6 +3890,16 @@ static int wm8962_i2c_probe(struct i2c_client *i2c)
>  
>  static void wm8962_i2c_remove(struct i2c_client *client)
>  {
> +	struct wm8962_priv *wm8962 = i2c_get_clientdata(client);
> +
> +	/*
> +	 * The IRQ is devm-managed, so it is freed only after the component
> +	 * has been unregistered and wm8962_remove() has already cancelled
> +	 * mic_work.  Silence the producer here instead.
> +	 */
> +	if (wm8962->irq)
> +		disable_irq(wm8962->irq);
> +
>  	pm_runtime_disable(&client->dev);
>  }

Something seems a little off here. We are disabling the IRQ in
wm8962_i2c_remove() but what was the point of cancelling the work
in wm8962_remove()? A new one can reassert in the time between
them. This feels like maybe this is not the correct fix. Step 1
is probably to decide is it reasonable for the IRQ to run whilst
the component is not probed? If that is fine then probably
putting the cancel_work into devm_ makes sense, if that isn't
fine then perhaps the IRQ should actually be unregistered on
component remove rather than devm_.

Thanks,
Charles
