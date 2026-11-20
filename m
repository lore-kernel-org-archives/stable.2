Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795195356;
	b=GM5t//LYsHIdkg4yTdEv0yqGCIliOVELi+uGLYy03eomBXnNKfiAEdHFUjGZ6jv6y8hh
	 3hB5NhIXVJUW+JAB0RacZWKG08n53VZ5T/4xIeDcdlcFfL6eE/3CtBNaxMHFPOZeLax52
	 rsefdh9tjSNYyXDYclKuz5a2lZ2g3EMB34SGbB2QN1vu5crtOl4+kB6VT+AMEEZ+fso7m
	 La9DkbVn7SlbGVLoFNfJ373j1YJzJ+VcXN0uKSNssvySsfQl4BkISFb8KSHpMkIHRs0Jl
	 Aa3bNBI9W4PISWRL799Z8swY29lEB7xsbcmzTkBqrfx3oZSg1iZHwMBb2ezNKOElYQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795195356;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=t258KzXmDOE/aDuZ4ulmzyH3SBaKcKbKKylim9qbfIQ=;
	b=fdHmsa7JQ17FaCWfF0mjmDaNKAjmY+geGIxKJVRCb+A1F84VstK7chfjpHemfCYngTxO
	 9/GEX6SAaNd1FNO3RWuQfcaeU83W83WgmIrDiAfrm8KL8Y9QmtzXfmOwxJNEbawqKPXMU
	 hJHR9PCg7jVHKMLrXoB6RPyLuwghxpiPSGBTjqF/CnyJHeonhrHi7VLysfip9GFEbnqOg
	 WlZ3fd27hKKtInuE0K8/ZJat8esyTInrubG7J3Bl9JZGSnWUh5IswALvF7pXl0xmf68R5
	 rC2Zq6ueg1CtgZgHx5X3PfHrQFp5A8tXIYgVk+UISN8hfuL+vfDsv3dT5tyQav1LQgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=UPjsOXYY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.47
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011047.outbound.protection.outlook.com [52.101.65.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93054606A767;
	Fri, 20 Nov 2026 17:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93054606A767
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=UPjsOXYY
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RnFPEWknPph7mFTJR8jNrn/j6PCEkZ67h4Zt7LBM499uR5wiWKJDonsrWM9QABdEoQCGPcKfFw7Z2BxyjHIIrh/Fuu+7Zdjr2iEhs0JXpbl84/BdtP/guc0XQefyMjNhG6qx2sdOsJW8HrMv6AkhIZaO2bZo/aGUwxT0+/T65vvsEDZ1z7GoVvkQbhXtPUQM/QkqItB6EC1gL+d/O5jsJ16OrBoasL3mwJZvoCVIvGigQkwR90M8cQgxNQE0AGeylAEX3YF3TnN7MF6B/yTsW52ru/f70k+70bUU9ME4+jtOC2cjKlQGsUkVA7oL5nGYVPlxkaHoZoYwnSgsem0y5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t258KzXmDOE/aDuZ4ulmzyH3SBaKcKbKKylim9qbfIQ=;
 b=HNzOYJlA+kArRgvZEKJgCRHeIBi9NwnWQ/b6u4WOvDtsiFoxvJm1T4ywhdpU3Y/pj8Wxpfj0jfSbN/sOsRpEwwX9tyx7lAFP4tCFfC+OWzv6F0vBGWbAuF4MvA3bGbAsihczZPb7aTuCdWzlOddbLMAeUBvZedUJlA9IiIhA61Sdh+BPSejnxmZKxZIW2/LeqUeNpzVqUutcLp0S28gVuZTJ+gVDkOWWjubHXdrWIeRm5BwSERCV88Ry6W1/H+AKGwbNzeslG0zu/NcuwbQQ9iG/HxFWqcAP4djU7jlttmezD+RN9ZPTOJHOfog3wx0UyJSKaJQhJzH1BRcjQ/MR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t258KzXmDOE/aDuZ4ulmzyH3SBaKcKbKKylim9qbfIQ=;
 b=UPjsOXYYSisGrwDEoQc3NemtkP7JOf5mn14WARwiv6Qot3khlCiXQgQ38jzYMnU/29si4mvO08D/V722NuXVJ6W5hlRAPa9arTBEvSPYGa9BHhrn/DhOw6VbYF35IV4ZLeED/7klaAOvSAaXNu0cdtPbtrHR7T2M3ADTmjvt1FCdvEkJX58bnf+/ih21wY7juzfj2GeWTzb8q7kOkrQQZ3NDlskN8shl7vIBpk8up6u/9mO+kBR+2uvNI2vxWoMPHC5VpdAeE3wyjPb3xB74BDP4q7QpYWx39MBFFTw6aMWLc4k4RODT5hfYsFK5tDdbFNDOVwTe82jhEpPYpKfEWw==
Received: from DUZP191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f9::18)
 by GV1PR10MB9090.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 17:22:29 +0000
Received: from DB1PEPF000509F5.eurprd02.prod.outlook.com
 (2603:10a6:10:4f9:cafe::56) by DUZP191CA0014.outlook.office365.com
 (2603:10a6:10:4f9::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 17:22:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB1PEPF000509F5.mail.protection.outlook.com (10.167.242.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 17:22:28 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 18:23:30 +0100
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 18:22:26 +0100
Message-ID: <11aa41f5-da69-40b0-9b8b-6c5abfbec5f9@foss.st.com>
Date: Fri, 20 Nov 2026 18:22:26 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] iio: adc: stm32-adc: Validate channel index before
 writing chan_name
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Lee Jones <lee@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
 <20261119153151.1397003-5-lee@kernel.org>
 <av8wzmfrU7zLzGmU@ashevche-desk.local>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <av8wzmfrU7zLzGmU@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F5:EE_|GV1PR10MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: 41156dac-ae5f-4e95-0d38-08df472ada33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|7416014|23010399003|18002099003|22082099003|261009223027099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	MJHpMPQWOe026Mvyfxp+hwQXq1iM3NLrx/L3DXVFlKlu9FIfL1MC/nRcbVDeYgfVAcPRZ7Wx2tLqpTXUdiJiSZsoThi+u/zkk/+y/TgLDEYVgnTPy+eJihWGXWsWdmRGoT69Z/ldD18udGJ0BXgwy0aDgMnPDzl2Jlkyg5+LqWEkiNj6qXJ2WNSzadjTOlczc5ove7MRv1tPtmJ1Nsf7EiSCGlaOwsNQYEY6ZXquZ9bdJu/9A52Tje/PhyYY/5h3OUU1d1XvvDqq4tc/m6y0AJgHxX8tf0mA918tcbIM+miGFdVb8i38uLz8FAdPV9W7x5QsITYz6s5sioXeueBuG0WQci5eiP3H5ikeZ/0BT2xmxY5ESS6s+yGQHhphKPIamepfxKJ9DZQSS5M4sjWxLr+4k/ABV8imM6qwG1oIqJwVnMqNbp1SAXddE17nGE5YVYXijcGLGMl5lb2gLAWs03BPsuLCJ35rMhNqWhG9mhoC2OBT5mqFFkKcDtLvcBYjayISXDPxFTl1wdeoUGK/Oqh25uh2DNAB+TBcNmIEAZ4B4JMqj66nH9rWmGpSbJ9sJiMFyEFkk4L9gptLBViQ/FOtS0IgiCjKg1ZYvhqG9ZjNwQdxSb+jJpY9e0CsipXap9KM9XrnTljiYhA7T6ycwqkmNP7avD1fibntnIlgIBAPW8hRJwyjgu2QiOJVbp4c7v4jNsqZ/4oRfP25fh8iBQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KsOWybU6NDr3mzId13qQ+BOxe3HH2kpe85Tz2W9r3c4sqHZu2yt58DPIV/1xZkcXvd0knJMtFY5JQafnV8NBSHov2oxe580evsFGhvh7Q+MO6uCAGat7s+H7DRRrsPTn5oubW9BjgNOaXk03a1RXuS6OzAZIlYCZ7kPjr4avkAS5sYAF4VgTfFoTKn2ga/6EJSkLR6fcEDD2HRKFy5UAhVmr9h1iTbC69MQnEc/c92Zr9fvGm1WYDuWamjSZDRNzEfcFxiQwBaeVjEjZBeM8x9XU++1T7nKJiv46DxF7AcsFfN0Kb6D+4/sbXeXOWB9zOSQrqfD4SIzfWaxgFLY9EMNujC71Dv5O+qqjvN3Q8o10hKYRTHvBarul8epVUtmPfYJU5xf5dKle8jp40/vbREbsPG3CL5IPVr4/T+3/Iht6G7DDz0vUmcA0h3kXqyXL
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 17:22:28.2268
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41156dac-ae5f-4e95-0d38-08df472ada33
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB9090

On 11/19/26 18:24, Andy Shevchenko wrote:
> On Thu, Nov 19, 2026 at 03:30:37PM +0000, Lee Jones wrote:
>> stm32_adc_generic_chan_init() reads the child node's reg property into a
>> signed int and, when the optional label property is present, writes into
>> adc->chan_name[val] and calls stm32_adc_populate_int_ch() before
>> checking whether val exceeds adc_info->max_channels.  Because val is
>> signed, values with the top bit set also become negative and bypass the
>> upper-bound check altogether.
>>
>> Store val as a u32, matching fwnode_property_read_u32(), and move the
>> max_channels bounds check immediately after reading reg.
> 
> ...
> 
>> +		if (val >= adc_info->max_channels)
>> +			return dev_err_probe(dev, -EINVAL,
> 
> -ECHRNG
> 
> However it seems in the original code like this.

Hi Lee, Andy

I've no strong opinion on this remark, whether to change the error code here, and if it belongs to
this fix ?

In all case,

Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Thanks,
Fabrice
> 
>> +					     "Invalid channel %u\n", val);
>> +
>>  		ret = fwnode_property_read_string(child, "label", &name);
> 

