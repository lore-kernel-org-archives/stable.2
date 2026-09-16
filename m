Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D961B3B47CA;
	Wed, 16 Sep 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789572063; cv=fail; b=WyZSe280c+BE6gNUYEH+QEh4Q7CMAvUHr32Adye8TUmhn6iDrbRPgb/S6hEB24+Pni1vSHLuA84HXZ2g9xwzbiDR/zm8peztIUYnw1kOO+RmAMIiKPpG9gXQldHpOAoqbCOJK+AIqhyk56fzHYyzaSaiGWi4Esz86xEpipiURxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789572063; c=relaxed/simple;
	bh=vr+Uk00n+Bq3INk+TLsC3jN6e3FHsCXwzQIq9Ovse8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Cz15u1oFbW3gO8moIyWMtEaWRUMptUdZGnYqMvt4ayyEsUfghMBQHc3afXk0/CGiKLo4AFraaZXW4jT1F/BWTPSWKcCCenTOfrT8Ki1Y2exnq/oN41rtz0nowmFOQFLw5flhbYtGVws9QqOYCuuVjSckxGHLrX6pwmSAzbERAjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AWA1x/pf; arc=fail smtp.client-ip=52.101.84.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AWA1x/pf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vprTMfdGeTCWe9kH3QRH3yJn/r+zVW1R86gOzrLvLK/VlhpcQ1nnuicVxzdalEmsuZo/UL8d1NSpfsSEpSgZFsdS7HqxlDjpoC0NgdfeMxwb3LwmAVYYptnR9nq+9rQWG6MOJe89KogSMrl9euqL/axnSocv05hwo/sPPKGKlqHjAsbd07V0XwJR0lmmc2/MujidDFzjOK7CvdEVR1almMoEJL6A90TFOCfazPQcx2Xe7Q4MJtLU1aDnQoKnUuWkZogBxsqxuP6GmrFWHPdoS6pnTAKX0PIIE4PIPGJXKSoPPco4ta6isjP+5ozvrXuVBjk7j0u4RKmFU8qJ/2abnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtGzm6tEc3XcJquEfnKIWlwzb+MTWiEzzs6vwOqrLVI=;
 b=L5BLOwIfAWExiyTfztR7VIfpJInYaWigIHT8SpQ3bEX9jFlAiuasE4q38wD3vTcvhIawMRE1VlPCU2s+WAbrsJyofqEGU5Ck8C6dxomIBVr6ppht6YvM0J8NIG0oW2Uun3aBvY+1LjpdqL+93t2fRDDqJN2Ry9qq0+sbVEvVUnDIbBIQ6VwFyS/bTGgcYn/Zi2Nf826jJOL1Hoy5IxugHqF5RfSiMClQNOkXeOpZe5UZReZwasYxEcUH/s8hf8kGRXZWOX/cnfFj7XE9HFqQtlMB/J984Y93C0PvX830T8aoSmTsPwA1nGbXZaAKMMtcWFVyfoTh8w8tDRgH0OQWzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtGzm6tEc3XcJquEfnKIWlwzb+MTWiEzzs6vwOqrLVI=;
 b=AWA1x/pfEPo7jyhpw2LjZ+MBoBncJxZ7VDz8U6feq2aTtQkfV9Uownx90rxialXjehVpNDUll9eRG46X3jpuk6D9RIL0h7vh5Nda2uMK6Dnv1Nv1GbTNQ5cJbyDM3MghyGQ4URX16HxIS+c/cx6qnRzaIdzXfFA6IA1HB3125iGKbT1nlWqgXIIsM2rMIi11TYG9VqupMubB6GgpU7kMP15Attsx48w7NtIKi5M0Rcv4UlGWzjZoMf6so67d131ZJCtt2MHaSbVbKQNLsm5qUulzypLHziWOYPWkrQqZyOHaUQeSqt1XOgeEnkPpkLGlu3P4TkKovUlC3oBi0KSW4w==
Received: from LO4P123CA0327.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18c::8)
 by GV1PR10MB243114.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:13c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 15:20:52 +0000
Received: from MAD0EPF000008C1.eurprd05.prod.outlook.com
 (2603:10a6:600:18c:cafe::6d) by LO4P123CA0327.outlook.office365.com
 (2603:10a6:600:18c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 15:20:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008C1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 15:20:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 17:26:55 +0200
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 17:20:49 +0200
Message-ID: <538c8203-3880-47aa-ba4e-014a345b3cb9@foss.st.com>
Date: Wed, 16 Sep 2026 17:20:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: adc: stm32-adc: fix possible division by zero in
 processed channel
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Sashiko <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
References: <20260916-adc-fix-div0-v2-1-f702d3ed782c@foss.st.com>
 <aqqqCf6mQPMoKZRj@ashevche-desk.local>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <aqqqCf6mQPMoKZRj@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008C1:EE_|GV1PR10MB243114:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c7ed850-4d14-4b10-8a03-08df140617f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|1800799024|7416014|36860700016|82310400026|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	MmfaAf4JUY2G2fzQ1soTq0QxJAAqQNSJJhpm3tUCfp7xIQScMgbTi1WH3n829ZRPztudDv2ciaSCdeAdexnL1HdDSh1q8uq/jHeDzAXuT7NogvMqL2ZSlqCBgz9qE/ueNdQegV62/W6QQ5yZtRiA4tSSbCXZmD/fSLgTvRkC+8qj1wLOMlG/D584543mxC9l+SFxzDgoKgKmST6e15HaUWh2wuD1uS6P789XYx2dCcwtgOQE9pHZJVFYikYYa9rotcfap5GB5m/Q+O4LM1uC5eMESinlC3yiw041WRHNN87/N/7FdlZiSefeRD1xWdfHHSPjQmZGFyYWhzugBYYVYAKjZXoqlFFYwPIQdYnF31zlJZIvWACGwKnaQaGP5nAtXWBDoY22vnGVRCF567mgufFHhCVmD9lvE7nh17F6r89eLA+3DpnoYhfvN+eb8xobwutWSvkSkqBVAvi6L9aeuVAXkQ/evcyrhIdx6BweFfjHhySUq5MDyVTNiGd3XJxMKZL3v8E97npH/W66p+LJbVK1dOKFQbYqgS2+k45hFdiMlWz4EbELuWB5arHZmkjDwWj8UkHrIkNWxYIhoP2nmIk88atg7CdAK2KWUbc+pCEYJGWiOujACYdtSQk/kr09lpNXyCIcwggWRr56k4IMo2MMFvbaEiFIAP0WYEgE6iJH1BZbgaAzrLS9gKGHJtJcZrXgLZTgBD6k1FcCGmKcNg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(1800799024)(7416014)(36860700016)(82310400026)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7TVERqhwM5xys1OMW1oyoVpKuqVJd4YbNIoWcNgOWlvwR+Y+Bc1FLg7jDR3j3uNSrPAdE6ZxMTRUPLihbulSzzi0uOn9nwosFS2R+Qdq7U8XRQ3cg6qCy7SeLJIhaMEiHRamGeXFnMROddY0F1SoNfQY67dBunPzij7WsXACeVKdhvNEBu+bYivGiuwSTWXLyG7RNR8NdB7PetB8OW9r4yjhyTdeLmoNn+Ah0CPEnzdvUJJYGyQO7pEIapAI7ExwLMgLDF1QsBXlVNAQjJLeNhDpPPWqFmhUWx583FPEneNO69pK82gQ6On1MXLtx3uqVNSV3S5RmfXTD2wevYJhz5NpYtvUdkC1h/0xBnuJPan74LYIilp1qbqHSRXPa+3gE1TmILnjJF6eSbe5AYgrdw+q7XhPvT01QOqzjCIA6zQl3xHqpl01naLWD+CqWAOO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 15:20:51.3001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c7ed850-4d14-4b10-8a03-08df140617f4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008C1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB243114

On 9/16/26 16:39, Andy Shevchenko wrote:

[ snip ]

> Let's look at the current code in this switch-case
> 

Hi Andy,

Thanks for you suggestions !

Let's keep in the picture the 'normal' raw case:

	case IIO_CHAN_INFO_RAW:
> 	case IIO_CHAN_INFO_PROCESSED:
> 		if (!iio_device_claim_direct(indio_dev))
> 			return -EBUSY;
> 		if (chan->type == IIO_VOLTAGE)
> 			ret = stm32_adc_single_conv(indio_dev, chan, val);
> 		else
> 			ret = -EINVAL;
> 
> 		if (mask == IIO_CHAN_INFO_PROCESSED)
> 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
> 
> 		iio_device_release_direct(indio_dev);
> 		return ret;
> 
> In the previous version you were trying to keep goto-less approach.
> However in the current state of affairs I don't think the goto is
> too bad (after all we need to backport this to the kernels that may
> not have IIO_DEV_ACQUIRE_DIRECT_MODE() macro).
> 
> Also checking 'ret' under another condition seems unusual.
> 
> What about
> 
> 	case IIO_CHAN_INFO_PROCESSED:
> 		if (!iio_device_claim_direct(indio_dev))
> 			return -EBUSY;
> 		if (chan->type == IIO_VOLTAGE)
> 			ret = stm32_adc_single_conv(indio_dev, chan, val);
> 		else
> 			ret = -EINVAL;
> 		iio_device_release_direct(indio_dev);
> 		if (ret)
> 			return ret;
> 
> 		if (*val == 0)
> 			return -EINVAL;

So *val == 0 is normally a valid value, for 'normal' raw channels.

> 
> 		if (mask == IIO_CHAN_INFO_PROCESSED)
> 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;

With you suggestion, moving if (*val == 0) to here should be fine ?

		if (mask == IIO_CHAN_INFO_PROCESSED) {
			if (*val == 0)
				return -EINVAL;
			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
		}

Best Regards,
Fabrice

> 
> 		return 0;
> 
> ? (Yes, we leave that line untouched, but we get the change cleaner.)
> 
> 

