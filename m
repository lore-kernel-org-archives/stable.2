Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A216340926E;
	Wed, 23 Sep 2026 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790156011; cv=fail; b=Z0HrIZf1gaoCVw7AC1W9pUim/qfX0lJgVJwR9u3c7zVlL4mgOCWXqQ6BUlMYqGepdRwWAPOOLY/1vVk6Qr7cvYdvrgo0kRzLsu+dPnINLObmgFucCKa8MU9VneTnCz1sbYRUZV7vsV5PR/LZG0LMbto0bDfCf0+gIbaKJp1BrRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790156011; c=relaxed/simple;
	bh=acSnS3bWF/RwhEVn/xyR2Wl696Ia1wRJ3SnPtD5zizI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2f0AXoc2tpeizCscghTvnsOs/7rsTqXsUlBGJYwPgJD+1LIlKz83Sji7ntw9636n247ccsavWpwwWZY95TA/S7QWjrh3AWgNaI7rYqdlGfwM9WjuJlqJvs8KQYscwxovLRxIUacn10IDDTHpKM5YpPb2Qf7/5ti/Pqmjbz5kiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=HtQPZCIJ; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=Uwb4hBNE; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="HtQPZCIJ";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="Uwb4hBNE"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N63OhR3764922;
	Wed, 23 Sep 2026 04:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=bXlUuERUOqidt72mvm
	TndTAoYS1M4jBWxdh46Uc/MJ4=; b=HtQPZCIJih1FO+LIc43ORPUCuxMLBujz7q
	k9baIBvavO6baqyfFDNT4RIklELw+lDI8v5IaA852gkwS4fd0Q/xML44Sxi0LzJk
	dRhUi0btSgJdDiFO3RJFarE2TAmkm6nbmSclAMsj3CRdsHV8vqe5GTztQ3NayFR+
	GxCN6PEzhjbn+QMLc7gQRV9+DsXFKyJPMLMcracWCzglo4tn+JrJqtRurcX3zrJs
	Kj9veMd/1cpuBbtLL6ZjWzs7Q6KoBISJwe6BmZxZfgKBIma9gO8xHPGmMG0RSbyt
	4qYRpppjxCpMpgvG+SoBjfBwwksOtukjg6zFTPVCVouFDJQlPttg==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11021125.outbound.protection.outlook.com [52.101.57.125])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4gsqt0dbp9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 04:33:19 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j/xy20VAyyJ5dXR+Rq2QCIKo5Bw7rzbq4rhEbSlAgevGEvqIF1jJAwPRmKYtaxizKEUjduRB9+RxfIDBym+g+aMA2+asXngE3IbQ/WjC/+9eCqjBIUmEroekMNHVkjHSg3glJTZ5jkwQuK1g9LFq+AtC34b8sYHLrzqoiKBwDXtQUkzy/9GSv2Cpt/noAqBberJEuT9TuV8pauwQjdkVjEaCWh9YZhSk/ZPcFax3n59wGGF9pv41BnCzJeeBKaYiXMv4ZIcTvzAM/kb9qO3CCuKnfENJS9GSDrXcl5Evh41ILbkcgmyDxJkZ2bMDTI6FPGnXtJMZ+GA1XfXPlOngxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXlUuERUOqidt72mvmTndTAoYS1M4jBWxdh46Uc/MJ4=;
 b=s8JU5tqpBfRXOBckD/2sXs8D8l9yElxeCYuKg3mV5r8xrzhv+CIRyPl8ZXGAgCAhyOi7hwkfMH79tKDYYKJpjJilpcuufzNTNjQtpgIlZxInLfWBQfynjhoKlYun+aW9C3zWYeQraClrcTpeJeC2ALcMwU/nqXV6SoU010XvCGm8IJlZDFMljzdOompEhb7cHHIelSbDwEXo7rW6MqP5lVbJEVphQGIiwkvv9udMzNNZX8cZaondLaUrZ49ghTQlWGjIbkVLl594YOcI5xiA5ZKUc/6aHykxUkO39F5cRD0Q5cu/05ArlGvPjJRUUl3f+UsBgke1wF2V5J8xKVFoDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXlUuERUOqidt72mvmTndTAoYS1M4jBWxdh46Uc/MJ4=;
 b=Uwb4hBNEdAj7LA834wv8q/rjuxpDg85YvB5AI4/WKtaDoQYO376UtkiDniLjPvMR13YWpNN1V1xf5Nl15IZDxuXtY7CnSI+yl1aiHMeNQMu1iUaho8wUqcphXbX+NMH5JVlrXHfNGiy737sycVTtXC/9r4hiSYiJbJKxGqILvm0=
Received: from CH0PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:76::11)
 by CY8PR19MB7201.namprd19.prod.outlook.com (2603:10b6:930:94::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 09:33:15 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::5f) by CH0PR04CA0006.outlook.office365.com
 (2603:10b6:610:76::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 09:33:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Wed, 23 Sep 2026 09:33:14 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id CA68C406540;
	Wed, 23 Sep 2026 09:33:13 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id A9AA5820247;
	Wed, 23 Sep 2026 09:33:13 +0000 (UTC)
Date: Wed, 23 Sep 2026 10:33:12 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH v2] ASoC: wm8962: Stop IRQ from requeuing mic_work on
 remove
Message-ID: <arOc2HZm3JCf5tjJ@opensource.cirrus.com>
References: <20260923030641.992569-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923030641.992569-1-mhun512@gmail.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CY8PR19MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 035c1831-03b8-45ce-915c-08df1955b170
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|61400799027|23010399003|376014|82310400026|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003|16102099003;
X-Microsoft-Antispam-Message-Info:
	bVkLl99OjSk7fJ7eGy5cZmEiznBJc8ufIZT4iKfL2HDH+h//Au0uEXj+hBL2nafPvXxCzbux4/Io8fq8QQa5rNiX1bNwj2M475hA7K/QS9815A7IrSpf/rqW4IK/9i3mI8lXAA8UZy9i47yQuvkvsHQsO3FQZA8O1i2kjJSfrX4b24tfdmYxQzOD5knH9tHzoxvmazpDSi/KsbwAbQMZZp24WZ0/la/ylSK90grR7s6BoBQCe36feeWN+2CMO7firY5dbUOKhN0BB8N7WzVibR7zJ4OBKlLJPgfnx28LqetKYSnPmD18vR8OW5+PYN4GdFj2knyjtCS+b9LfWuLHCFnGkLsBESyS+UrYmW0RynaWtMgmx7CbzKntDl6CE/+94+OUpYg12alBzwQ4IVgQJ0X+XFlKPhew1LdOoi+VkpVgdpf9op6fSDpkHOewvQmbILQlzwMH7yJtrSYA+FKlC/XaktrmSWGdyti633qg16SqS7dGyaWNPRZqcAxgGf9HtiJzhnxC8xMNMlUbu7eeNqHrP7o6qp5lzKItJ922DXnOZ1vYeX019Bq9+vbJp9M+Us0n7GYjxKl4ZBoyB0tuXzcgCImF39D0MZCD2RjF44V+rILh1dnB6y2gbeQ8cIVeOnK74qvHq0XwLzIKL8u9ql7JchRKBSijTB2OBG1WJFZ9WzpMw9ybq96HJ/67bp0teYvp0bivxLcKOP1oIZD1Gg==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(61400799027)(23010399003)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(16102099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4mGSqD9m+9cyqQsV/JOdE8uW/HEzuCPanFmKNJWhs3iIWSwhko8/pCAwSvLz+JegxFTKzPxFg0hn3wsTa5gEXv4bMfqreOwhIqDMsGdm7igRWAxvlWwd+kcGojrQfp4q3GTbJXaGABNXco2S2dOXc4cCLKJ4bonq8d67gde+csxqDQbAHuKsRbVhwQljQu2V/L3s1N0LA7veeC5Tmnn2R4nH/DEg6vfu+Hmjbs80wwwdN4VhU4cEdqaiJKkwGmmY30CgVnC1K5OkdffQ/t11YFizeX8QWAQ++O2HPOxllTssiairL4D5cDRH96sPPrs9karLcvOi9OKvB3DdGHqfNCJhYSdXAIzdZqZuNIrlCndlPPVHgCsBKNy6SMAHLHA4msfGwHQydsEljeqJbVm4HsmlqB2yDKKl6IMIUeCOYjZ27Cvz5pdFLihBuQ/n3te0
X-Exchange-RoutingPolicyChecked:
	nPPezBJOWgYIkK+qVPBHb0OSbMtw1VPx01qYN2D3jtlREsQukN8nO8yZKT5y0U14Dwx5yVo7xyJ2FIIAqqPTgpq/cY2xKnRy9F2WCOsz2XZ7HJ25mVEVUPtOgO4QIUs9X738zKALdFpQUsYk0ULf8wO84MvIq/GGjARYdJWT+Csm9MXHtvMxYxx5rUJhsL0I8oPguW3bCldIzNxxGcshNsVlHOiuQabiNvDQCSWtMl6nGTpyEj9PLZPqmF539YNPn3/mDVV49sv7hUUJB94eYH9ZOTgKkcncsYfjvlFUe4lu6H+fxwpztrD9LvBX2fgpK7G44m3vz7dnSeEqVpHS7g==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 09:33:14.7384
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 035c1831-03b8-45ce-915c-08df1955b170
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR19MB7201
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfX/DRNicDonrTM
 S9TlpTR7kViwa54/odfj8+Nw3s/7tFPw3MdL/E2rOx+zNujbgL23VMnX8yG9vag9MJs7j11FVEg
 QUpLH//gwSP4XH7mmWIy+EGeiv/is29sxa92jtZi/XO4bzHiHDk7PjYxYssQswakmHeLbCDFU2W
 K/S3HItqf2OSzDEpmQggIDRHOp+lAmYHXY5aexGiJQFP6EtbiBq87wtqCT0zOiIBC7Jsk3L4fRq
 HRlDKAefLq8MaiSVnalQsqncAbHc7EgiMb1WgN3WK4HPTbBVykRN6MbGLsovQbYiPOfVHg3F1c5
 SQ/DM4ZJhBMaWziXLhD6CZixw32GL3op0uSJ1y9SnrTOPiiu7MxPqxJOscKwG5xgePRPOV57VIF
 +2qT/fu84Cu53Nrhkw/NLI2vmj42taTYKfo/hWJRABh/1ADTuLVDSifDmZRqTU+dCgR/z3jKcjF
 7LfzDbqqFUE/6csZ0Zg==
X-Authority-Analysis: v=2.4 cv=TPTQ2Fla c=1 sm=1 tr=0 ts=6ab39cdf cx=c_pps
 a=D7/jkJElyu5J9GVQDo57QA==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=oIgDJqyV6jQ77BMZMCwA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Ye9f5Q6QSi1K6ITOgMlbvp3Nx7AeBYri
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAzNyBTYWx0ZWRfX7U39HF8rFZ9o
 XIgDRDhbXTQYg1rYF/NN/1NJwjGrnw5nPKiZtsWKw8BM3pnxCp0EsojETHxHO6sLuJ6GWA/55qS
 RoqqOrJZT/OQCqxmfJi21ROJ6mUajOg=
X-Proofpoint-GUID: Ye9f5Q6QSi1K6ITOgMlbvp3Nx7AeBYri
X-Proofpoint-Spam-Reason: safe

On Tue, Sep 22, 2026 at 11:06:41PM -0400, Myeonghun Pak wrote:
> --- a/sound/soc/codecs/wm8962.c
> +++ b/sound/soc/codecs/wm8962.c
> @@ -3115,7 +3115,7 @@ static void wm8962_mic_work(struct work_struct *work)
>  
>  	wm8962->mic_status = status;
>  
> -	snd_soc_jack_report(wm8962->jack, status,
> +	snd_soc_jack_report(READ_ONCE(wm8962->jack), status,
>  			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
>  
>  	snd_soc_component_update_bits(component, WM8962_MICINT_SOURCE_POL,
> @@ -3203,9 +3203,14 @@ static irqreturn_t wm8962_irq(int irq, void *data)
>  
>  		pm_wakeup_event(dev, 300);
>  
> -		queue_delayed_work(system_power_efficient_wq,
> -				   &wm8962->mic_work,
> -				   msecs_to_jiffies(250));
> +		/*
> +		 * mic_work reports this jack.  Removal clears it before
> +		 * synchronize_irq(), so do not queue once it is gone.
> +		 */
> +		if (READ_ONCE(wm8962->jack))

This feels a bit like its duplicating the mask check above, I
think it would be nicer to ensure that works as intended than
adding a second layer of filtering.

> +			queue_delayed_work(system_power_efficient_wq,
> +					   &wm8962->mic_work,
> +					   msecs_to_jiffies(250));
>  	}
>  
>  	pm_runtime_put(dev);
> @@ -3232,7 +3237,7 @@ int wm8962_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
>  	struct snd_soc_dapm_context *dapm = snd_soc_component_to_dapm(component);
>  	int irq_mask, enable;
>  
> -	wm8962->jack = jack;
> +	WRITE_ONCE(wm8962->jack, jack);
>  	if (jack) {
>  		irq_mask = 0;
>  		enable = WM8962_MICDET_ENA;
> @@ -3247,7 +3252,7 @@ int wm8962_mic_detect(struct snd_soc_component *component, struct snd_soc_jack *
>  			    WM8962_MICDET_ENA, enable);
>  
>  	/* Send an initial empty report */
> -	snd_soc_jack_report(wm8962->jack, 0,
> +	snd_soc_jack_report(jack, 0,
>  			    SND_JACK_MICROPHONE | SND_JACK_BTN_0);
>  
>  	snd_soc_dapm_mutex_lock(dapm);
> @@ -3594,6 +3599,15 @@ static void wm8962_remove(struct snd_soc_component *component)
>  {
>  	struct wm8962_priv *wm8962 = snd_soc_component_get_drvdata(component);
>  
> +	/*
> +	 * The IRQ stays registered for the I2C device, including across
> +	 * card unbind.  It is the only producer of mic_work.  Clear the
> +	 * jack first so a new handler does not queue, wait out a handler
> +	 * that already loaded the old pointer, then drain the work.
> +	 */
> +	WRITE_ONCE(wm8962->jack, NULL);

So probably calling wm8962_mic_detect() here. Although
granted that probably needs some small fixups as there are a
couple races, probably also makes sense to move the mic_work
sync in there too.

> +	if (wm8962->irq)
> +		synchronize_irq(wm8962->irq);
>  	cancel_delayed_work_sync(&wm8962->mic_work);
>  
>  	wm8962_free_gpio(component);
> base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
> -- 
> 2.53.0

Thanks,
Charles
