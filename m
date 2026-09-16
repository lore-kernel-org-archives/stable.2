Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06C34C900C;
	Wed, 16 Sep 2026 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789553016; cv=fail; b=R9ZGmLSPIlGnLpPrAXOW2J/JrGFaX7vKvGPFzrV9gRqJTRG7a0FWFmLyq/HKp23Qqtc4574DDmUgmnvrie3G/lM2YvxtViENYxqOHBw5g6aqqbgpiCvnbNn3knplW8L0iZCuXmtq9VJVvrf/xZJhRVJ1XK0jx77urLfOTAjJquw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789553016; c=relaxed/simple;
	bh=OfLRw9q2swAEAusGjoSngXPBBMxpXqs0nWL6IhBfShg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IjNP3XsHPhdPJwBSmfK3JtW4N3gSbT2l/nb4lWqXLBjOKdbuRoHKCPDtzBcV6q0panRaisd8CScvCez18FsRRL0WdHEUjxJ7USFYo0MRhuSGcs+MrMV5AbD+9UDY4YbdxOvlkEYag3Zk+QQuEtgWiqrMcXRWRNhscIM0yRR8qtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=L5/F30B/; arc=fail smtp.client-ip=40.107.159.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="L5/F30B/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dfyUAUg1IIQJuP20/VSdKtPTICGllYhDQB+DYpIlmesUDc5v7dsl9Rjl8a2f7uPYI2NmM4FM4ftTU19H31R5ml0LpcfqlDMZVLhNKC+BjRMwfFyR2c1e6qJYB7K/J6cLG3tk+goOAu1PFQYJI8K635fjj/Rq1X5A2O0zLtVigxlqp3DLoIgUyiVPJA2Qs9MeMN/C0X6oNePtcMlAu4m1t5Icrkze6iqPcQcaKXJtpCcjNIZ5GxLxmRPLn4BzyIwBkX0frVuOvr60TfQ2SUFGraioFki77ZbiOszEbTkz3MuUGre531GIWOlpkfN2tMCKxF7qH+NlWv+TpYiuB8hbeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KIcrIfWx+TSEvxGKy6/D5I9qUebgG2wvJxELHA4JgfM=;
 b=ySPWwFKyn2Cb/F4NFQg7MzDAR1lGfALdsspHmTXDrDRJM43JmjDjjOOb9cpDwZEwC+OuGHM8MnfqDyO8ONPhZttQL3EMu1Z2mD1wNTOBpITcnD/o2COhRkgnYGkol1o2M+IxvcG/VFPGse9+poTDqIg6uuULvaemV+wcj2D7NabNOaJbjsi7ftx1GV0pFMLueZ4ctAAyOVg8YpIy2qKaAZNchVOlI6W/xF9WygUnYYTE9x3VJfJi+FYo2aVqjpCQp4p1GGXNrDSr4CCM96MIn4QLGk6ZyC90Lzq/G7lXpkrXsicZiHOUfIGEq122djEh+ByoSDr9xsxhhu8XV93PZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=intel.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KIcrIfWx+TSEvxGKy6/D5I9qUebgG2wvJxELHA4JgfM=;
 b=L5/F30B/nt/mdMJ4VCyoFAv6tVlXI7KuvheFfkMCajP9xMCDc9HdwNBzYBo8YyKztQfK5nrkiC/81avcl9ZkLMu4GbAcQT95FbnRQB0VBpgtMJAfSx46OTDjaJdyuYxBqaHoy6Y5v+D1rDKsB5mCdtWXgZAtfP18+VTZqzbJ0vz8lTBYmL4PIsdX39h/Gu4Hdu6TVRHKYQY0bObx/mD5gEwzsX5zPQHRer09QBiAMLZscIwmXh1mQ8FYJgy1vn+9p634LYUMbGjHjVVEao5U46x7AwPQU+/W02B1r6FFNOAcHIqGznqu7k7dB3aXcIhCuGyzXgt+iWXX1oiTJhKzcA==
Received: from DU2PR04CA0309.eurprd04.prod.outlook.com (2603:10a6:10:2b5::14)
 by WAWPR10MB601896.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:1d0:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 10:02:52 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::47) by DU2PR04CA0309.outlook.office365.com
 (2603:10a6:10:2b5::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.13 via Frontend Transport; Wed,
 16 Sep 2026 10:02:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 10:02:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 12:08:55 +0200
Received: from [10.48.86.251] (10.48.86.251) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 16 Sep
 2026 12:02:49 +0200
Message-ID: <eb5dad33-9344-4b70-b7dd-a0e808f43ed8@foss.st.com>
Date: Wed, 16 Sep 2026 12:02:48 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: stm32-adc: fix check on internal channel
 availability
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Olivier Moysan
	<olivier.moysan@foss.st.com>, <linux-iio@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Sashiko <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
References: <20260915-adc-fix-intchan-v1-v1-1-761a1b35001b@foss.st.com>
 <aqpJCsBNKDSKlfFD@ashevche-desk.local>
Content-Language: en-US
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <aqpJCsBNKDSKlfFD@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|WAWPR10MB601896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeac330-ee11-4904-a181-08df13d9ab5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|23010399003|7416014|1800799024|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	thci0OiEXEv8ELqyxe36IHjahLog4u6qfBz1mfNRigcZLGG1ABbsgqbkmpLB0mzB7XPADW8F6JgwO182dd1wjgMTooBFArIpmZ33yVRB5nx7fNrY0vC0PokE5EpyvVUDPqtUUP/uZ7qo8x4GB/Y6M7VCAMx+bvzZzWlAVff4iQn2724tOxy8vgFmHOClLp7UIxc2urop3+g8kjn08D9M8FYIndzupa+8bhbrlhJ0s07ODvlQ+EN7WCanapCPUfjSEYxoqLpTC2wDl8yk6oufcEYUAVhkDy7h33aVIrbVs0k8Z9aSNdwxEmL/tvpAe+PppRHxpvyDaE0Usvx+UEg/5A3AXRkJ9b2RdmvA64ywe2Mt3dRP+/Zh20Qv5agtzvmHspSWcVtrfBP/ABUzj2TjkbuLCh5+GZduhi/xCHZNiRftJklM6NKQjDUBN6kOU7tMmHf0mmfu/h+R2dNPwxxHCbiXvKGV7J9Hgc8NXGaGZM3jGhsFUVRlxABX9k/lVWNGh5FmRyqFgCD2sHYlbg0RnGjU1zXHPbfUZSm/yvGQEIcH+fxx1j8QFgy3C3Gzt08QRkppVDBEBVeFbzf5lD4iZ0sE4h8+EPNDrgjUh5dTVvSM6sLYkdL8kOCbfg3LEEKBWljG82aXJL/uPHZbkwLgBxCfnSQcY00igsB0RHMXr0etw5Phw+LjErRez/gobXQKjcD4jDCzvoV+ooI5IZQBMA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(7416014)(1800799024)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qkxoX1nMm2v/vHAaATEQyX6GyWuRy2xw3wDbXgRn4aVJYTcVlkj93gDfZnj/quvHnYyl0yoI9CQMCA4AQCy9RZvPui2ByY2Ls6WdObBRWHZ+1TwJS/PdboTtpAWvtO3uNeMFwAafdGbmZbHpwVp2ZJknsvDn8zioJaG6sUYNmmiHpvzKy//YnZemmy+oJbbCRK+jCofBT3XPL58P42HThgY9PPpjE6iG6odCS7A6L+klDxxYkZbyWAWON9tSR03CF9sh3Ek8wdCOHWnPc/0uaLSm6xmXQYIQbLNz13fscx6kJkLWOgL4KtLISPryxYlJnEjASGIp5DVNRqYEEwZGzuc5bragsLV0dAhePPpZK4vYZGtSaigPseEKt0UVnpy138oa8hhdK+9177a0sQEQBv/tmhrKPaf/Q5rkNZmnCH47l4WwWmiOTw5pmU3h7IEx
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 10:02:51.2392
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeac330-ee11-4904-a181-08df13d9ab5a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: WAWPR10MB601896

On 9/16/26 09:45, Andy Shevchenko wrote:
> On Tue, Sep 15, 2026 at 06:15:49PM +0200, Fabrice Gasnier wrote:
>> If an unsupported internal channel like vddgpu is requested, the driver
>> prints a warning but falls through and assigns it a valid int_ch below.
>>
>> This causes a problem later during setup:
>> stm32_adc_int_ch_enable() {
>>     ...
>>     case STM32_ADC_INT_CH_VDDGPU:
>>         stm32_adc_set_bits(adc, adc->cfg->regs->or_vddgpu.reg,
>>                            adc->cfg->regs->or_vddgpu.mask);
>>     ...
>> }
>>
>> Because the register offset is uninitialized (0), this performs a
>> read-modify-write on offset 0, which corresponds to the ISR register.
>>
>> Fix this by returning before a valid int_ch is assigned.
>> Choice is made to just warn about the channel name as it could
>> be confusing, rather than making the probe fail.
> 
> Are this and the other patch made with AI assistance?

Hi Andy,

Not the solution (patch content) to fix the issue.

But most of the commit message is copied from Sashiko, as I find it
clear, see:
Link:
https://lore.kernel.org/all/20260911162602.D323F1F000FF@smtp.kernel.org/

I've added Reported-by tag. Do you think I should add more tags ?

The code bellow isn't assisted-by anything.

> 
> ...
> 
>>  	struct stm32_adc *adc = iio_priv(indio_dev);
>>  	u16 vrefint;
>> -	int i, ret;
>> +	int i, ret = 0;
> 
> No, either assign closer to its first user, or do even better.
> 
>>  	for (i = 0; i < STM32_ADC_INT_CH_NB; i++) {
>>  		if (!strncmp(stm32_adc_ic[i].name, ch_name, STM32_ADC_CH_SZ)) {
>> @@ -2267,31 +2267,36 @@ static int stm32_adc_populate_int_ch(struct iio_dev *indio_dev, const char *ch_n
>>  			switch (i) {
>>  			case STM32_ADC_INT_CH_VDDCORE:
>>  				if (!adc->cfg->regs->or_vddcore.reg)
>> -					dev_warn(&indio_dev->dev,
>> -						 "%s channel not available\n", ch_name);
>> +					ret = -ENOENT;
> 
> This is a repetition of the same value. Instead add a boolean flag and do here
> 
> 	bool na;
> 	...
> 			na = false; // or can be dropped with 'default' case
> 			switch (i) {
> 			case STM32_ADC_INT_CH_VDDCORE:
> 				na = !adc->cfg->regs->or_vddcore.reg;

Ack, thanks for suggesting! I will update in v2.

> 
>>  				break;
>>  			case STM32_ADC_INT_CH_VDDCPU:
>>  				if (!adc->cfg->regs->or_vddcpu.reg)
>> -					dev_warn(&indio_dev->dev,
>> -						 "%s channel not available\n", ch_name);
>> +					ret = -ENOENT;
>>  				break;
>>  			case STM32_ADC_INT_CH_VDDQ_DDR:
>>  				if (!adc->cfg->regs->or_vddq_ddr.reg)
>> -					dev_warn(&indio_dev->dev,
>> -						 "%s channel not available\n", ch_name);
>> +					ret = -ENOENT;
>>  				break;
>>  			case STM32_ADC_INT_CH_VREFINT:
>>  				if (!adc->cfg->regs->ccr_vref.reg)
>> -					dev_warn(&indio_dev->dev,
>> -						 "%s channel not available\n", ch_name);
>> +					ret = -ENOENT;
>>  				break;
>>  			case STM32_ADC_INT_CH_VBAT:
>>  				if (!adc->cfg->regs->ccr_vbat.reg)
>> -					dev_warn(&indio_dev->dev,
>> -						 "%s channel not available\n", ch_name);
>> +					ret = -ENOENT;
>>  				break;
> 
> Don't you also need a default?

Ack, I was wondering too. I will add a default in v2.

> 
> 			default:
> 				return -EINVAL; // for example...
> 
>>  			}
> 
> 			if (na) {
> 				...
> 				return 0;
> 			}
> 
>>  
>> +			if (ret) {
>> +				/*
>> +				 * Confusing channel label matches an internal STM32 ADC channel.
>> +				 * Just warn about it, as there's normally no restriction on the
>> +				 * name but that's not among supported internal channels.
>> +				 */
>> +				dev_warn(&indio_dev->dev, "no %s internal channel\n", ch_name);
>> +				return 0;
> 
> My gosh, the ret value is even ignored!

Yes, That's what I try to explain in the comment, e.g. Just warn (as it
is doing currently).

The purpose of the fix is not to change current driver behavior but to
address the undesired subsequent int_ch assignment which ends-up in
writing bits in stm32_adc_int_ch_enable() in an uncontrolled way.

Semantically, this ret value introduced in v1, will be turned into a
bool as you suggest. Hope you agree with this approach ?

BR,
Fabrice

> 
>> +			}
> 

