Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E287B4BD790;
	Wed, 16 Sep 2026 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554248; cv=fail; b=EL2XP6T7qF684Aub1qnNGFwPCulDhPgdsc5Mf4JkbjjsMbPkySOuZVhMVV6hSGhey+gJ81d1TN2KokTj/tPPaP6vBnqc+DmJvxyBNrOemvvyAwSUI+Zt9JU/47Jy3Rz4KEzf8y0rWnLjOWWJ5P2KDeAPXqyUIUSNskxmfxwR1Sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554248; c=relaxed/simple;
	bh=UVfagib1Hjk0iGzGfvPDb6CRSsQWQ5st0xRdm+qgxmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HR1ggkkpeon10pUCv/6NPM3SfiPt4FKNEPrQzTBOJfM/RVtyokQiOFXlL78CY9+z848uwZQE0CscjCJrZWJqd5+9JFfe/Gw/u0B2BY3gq9EoCfXu4Y1LSzVQWt0/PPNSCQ6bu90LBCzMSORLF4zzNqiUV/IGMqiU61w4i1KbGx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=EqURQ6dL; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="EqURQ6dL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2TwAsCA0LuB6tuoiwCNofc0mWQKjWX8RsU/UtGHoMTOsN2XtA/FRo2T3C6Vx8K7e+/ekvN323VByAzU8uzJ61D6Zv8Z2hHYx6CRkTKAhCl9KxHB9HP/lsrUcw2m8zXVbuwxWAOmwp6dG+P0MwVfLA02cBhJ5PlbjYIj6zev4QhDqr4tYmn2yTGYUU9RbbjRDLkaESnxNp72JnEDIDx/dAmI4AEogUEaBidq/xkbtwNCFLYVj9bxW+xP7QfjZf9Kv65SIl2lqYt3EZKfHE4bP75uAqLPYZl/fPLKJ7EfLcJwN7kjmWjmVYgIbGa7gD5CaT+7kAAtFZ7xtWBdDS7cZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+qQvatdBnegyc5f7vGbDQGKjal/WBEA2oSvVeOnDT5M=;
 b=rTKDYSygAeO0bl+zoFzFWbMbaJZtDwZP6dqAEO2Tmc8uypTsPQSdngRJuq5PwggOqbSul2cI3vPKGhy+nA2yKxMoEfcZQOKnkmu9KjjRLxsCFeTXWzY917hkc340HZGMAFYBm8/ope0GV14AEQFx0yqlRIuGBHjIB0iTNl9r3DChUpjXdoN/82/9WaAQPc3VSorhyI7p8AbV2Pnb6fI8OfeJRgw/u0zA3cpqzDxtPsvwbxNzd5/L56OiH44qwGWi0a5WdvtDt/MCOak76prQ+6lzP40bPN9W5lVZpMLFZCcLE+IS+6k/APFGwJozuexK89Y3EmuZ3Z7WPthQA/g3aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+qQvatdBnegyc5f7vGbDQGKjal/WBEA2oSvVeOnDT5M=;
 b=EqURQ6dLkul5q+Rcy6oCIWbajbuKXsb40q4eQbzStY1zf1MrI80IImhaR6mnG5nonJtUd3E0UaSme/ctIxGLb4fOHtYayhv2eBKCsn4/5XLnWICT+3SpLqtF+Q/z5qA5R+OST4j7fBwHoZHMmE7B1+vv3Ov0kk101UKVM1t3HesGicGV0W83I3xtVH5Vc1JRyU/ggwJk1WpO8RSDhA7J58q6xmV+7gDUmEWi8xD5W8lXbQQ8lCH7dZeu4b+zFD1svolkf+Wzl71yIbDPhdIYUgLwfCtwA7ErUjbbhgaC+mv0B3WPx3dPqGdfVr3TqXysKznvbTP4UAj/46L6xfSkkw==
Received: from DB8PR04CA0028.eurprd04.prod.outlook.com (2603:10a6:10:110::38)
 by GVXPR10MB9064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 10:23:43 +0000
Received: from MAD0EPF000008B1.eurprd04.prod.outlook.com
 (2603:10a6:10:110:cafe::39) by DB8PR04CA0028.outlook.office365.com
 (2603:10a6:10:110::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 10:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MAD0EPF000008B1.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:23:41 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 12:29:45 +0200
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 12:23:39 +0200
Message-ID: <bd47e39c-18e0-46ba-8cdf-9ba35f387793@foss.st.com>
Date: Wed, 16 Sep 2026 12:23:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: stm32-adc: fix possible division by zero in
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
References: <20260915-adc-fix-div0-v1-1-7daed9e52f2f@foss.st.com>
 <aqpGy9oQkDC-xZGW@ashevche-desk.local>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <aqpGy9oQkDC-xZGW@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAD0EPF000008B1:EE_|GVXPR10MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: b19e0adb-3cf4-4bb1-c827-08df13dc9498
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|23010399003|82310400026|1800799024|10067099003|11063799006|4143699003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	8geF3SnG+/HMtkOlup2T2jpO92Ot9+G4tzHsilEw89/zVrY29j3Tv/YfdWLbDhyyedmi6O6oZSZJQtuSlSSjgrzjPZmlPWJe65qLRe9tsCegPBI4DfppuueX0mGFiQuU3LuvCjSgqi6aWv9N/FRvfx5ZbUqMgRMZaI62FKv56pE0pzcNmrXikp3NfVv+HeQgdsOFcjGWK1bqf7uvqQbkP+M7wNPI6I2mlF3k3oahvY9OHuDl3kuo90d8V/c9Cbqe6QlTuadUfCTZFPJvel4nGNCPE5IYDwF6OkgSjl1eK8QyPDznGZgPlHZQfSYBC0vhPX4ZPHabe/fUm9C8ZFLHcB7knyKI01C9HJGc4OXSxDYvwpfH5XVxPPpXJekHYwx0mCCGnEx4IGQ0zx6lzzgg8/KuC08XsEzt+gUqadgdDeJw+kxs3+zZ9H8M1jYUF8P1U5gXzj1K6FezFgTsZdsSNEbCuJbpRIRoaY19Umdk4JZq7Z3CUXMcabWgOHR7YrUICD4P1ayB9+hUHTqucRHKpqrcpq/0upf170hDqIMvxaVGcF50qxIDoEZqP2NqM0UeiMOWAnpDjYK8JW8srGUfZx5N6S/dkJUoEyrJPxleaf7MQnhzjmmejVoFWuNtr5GstthBLawwlbegqn6IwPLr8Sm5Ye/UeK4H2OY9pKVTBKLztUD/ZDjrh2PbbgBOtR5RvLZTsG4T5//3yq79fl4FGw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(23010399003)(82310400026)(1800799024)(10067099003)(11063799006)(4143699003)(18002099003)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7puQ35SidRd6piTfLN6fM6W1I0C/XxjGx9hrO5QV7mdx3oC8oS59oGXxUmHBL4MHqsnngu0WIuAaeJx3UGY8mL7Ue/TIfNDPIpudSz2K6k4hkcBWYOAxTyUR1mPzXATa9HC0nYQckQb0oYFksU/e4P0PysKn8icLkfVhPC2aubzpDHkzO5SameZju42/gB8b2ADd9ycflTNKGq2nZjNWd3Cfix2BNolXVqSE7ML52wPrW7KiwNsQfWZq09CiP59YbZKm1XTOxFJ/iflzemF/QNJE7Mn6lHYHL9gMof4TRUiHS/+tjuU915ZOR6prITprLiBYehc3moTuhp+oI2dE7JKiffTt3nIr3sIHVRJpjSvz9fkeycxJVF66pOh5ui9YFwyg83XVLUURMA8giIGlCYPsGn54XzATLL4ovAVONSPSj9TLbnmN1VOfExj+JU2N
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:23:41.5524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b19e0adb-3cf4-4bb1-c827-08df13dc9498
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MAD0EPF000008B1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9064


On 9/16/26 09:35, Andy Shevchenko wrote:
> On Tue, Sep 15, 2026 at 06:10:40PM +0200, Fabrice Gasnier wrote:
>> In case the conversion has failed or returned zero, processing *val
>> can lead to a division by zero.
>> Need to check for errors, or converted value is zero, before processing
>> the data.
>> In case converted value is zero, e.g. the Vrefint channel, this should
>> be considered as invalid in all case.
> 
> Something went very wrong with the indentation of the above.

Hi Andy,

Euh, sorry but I don't understand what's wrong with indentation in the
commit message ? Could you clarify ?

> 
> ...
> 
>> -		if (mask == IIO_CHAN_INFO_PROCESSED)
>> -			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
>> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
>> +			if (ret >= 0 && *val)
>> +				*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
>> +			else
>> +				ret = ret < 0 ? ret : -EINVAL;
>> +		}
> 
> Reuse of the *val makes code harder to follow. Add a temporary variable for
> this and do something like this (also note other simplifications)
> 
> 		tmp_choose_good_name = *val;

In case ret is an error; this lead to evaluate (e.g. read) *val from the
(maybe uninitialized) stack. Probably not an issue? But would prefer to
keep reading it only when ret >= 0, as done currently with the if
condition above ? (e.g. evaluate ret, before *val)

> 		...
> 		if (mask == IIO_CHAN_INFO_PROCESSED) {
> 			if (ret < 0)
> 				return ret;
> 			if (tmp == 0)
> 				return -EINVAL;

I've started with something similar before, but we can't return directly
here. Must call iio_device_release_direct() first. This would add more
lines.

So I chose to implement above ternary ret = ret < 0 ? ret : -EINVAL, to
fall-through.

Please advise on the preferred way,

Best Regards,
Fabrice

> 
> 			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / tmp;
> 		}
> 
>>  		iio_device_release_direct(indio_dev);
>>  		return ret;
> 

