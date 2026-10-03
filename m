Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011018.outbound.protection.outlook.com [40.93.194.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8994766AE;
	Sat,  3 Oct 2026 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791044099; cv=fail; b=ncfmZXE3MPp/4qprnELTMNH3Z/C1p7XavshOjC02yP+9XON6KpXRZfMZmVCAub80jzu2w2+xg1mkNIqwzv8Oh9aCUfpdbHLnvy/eiVqZytQzl7ARA2XyvVEjsRzMbBPnbz+Xt4BwxPgSJd2A/thAu7q285zoBKIzz9XUUtNE7rs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791044099; c=relaxed/simple;
	bh=s1g/589y9U3RLm9NGzaO9R5JEbbjTxTNUyWu8qB/HtI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T9qg5RPduGcVy9H4JZS/+aYLWQBNR5PvrvI3sRqGZzfpRdRcLxv17p6jpvoGWfXUDqBRa909HY74pugyKj2Qh77yXSmm0r/ViHHnvnVgsEQs62IWd2OxvYNoG7XVUz1THKak/JD06nnGdGGR45N98nnE3cjmwcBsKmJHtJPETCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z6dfiqnE; arc=fail smtp.client-ip=40.93.194.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z6dfiqnE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IKrYKI8XYWcKAofY2TJpJM2oTsGRW6GvS/uSVyXdtwi9/rjxP7zE+5/A085Iw8WbjSMoCiDNx6NKUvxX3L/pPgOVdFNA4dKMRI/N3SonKzcALtHl9JkkjIgn/YjiDzWl3isegGKNE3MuZJQQlbZ6Tg+Px2z4VW6J1V3FODyONdtRAQoTZadjISpgI3CHTLnRAoKocvWK3dm+s3fJ18rTSYdrUrRa8VoHwhTA0jmQjJFaYzvLQi4Ew7uM7c9rin3JloeAlaO5o/Hru7X35/1sNu45eI8OQoBrKxujmLkoGJsNhQNT7qnZ+NlNXZQiwSPZIJauccw37GkIdGEK8cnx9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHKBvAuhHefkXxjvszV2EHZd7kxxIvzVCRTd7BrCRZQ=;
 b=IoaZ32DEXKspb/mKrGb8rcho/x7czMixkzttDcL4kbgm/PfS5EhUyHhMjqOB+9xne0hek0UQBv32qETKym8v3231gwbnlu1l5Ee7Ju1lXcen3/SjuYFNQ6+4qbcJvDGVTQlmMJB6CRIy4FYiEazVQfu1NiF0s4e1q+6GQ1YvycXHa4dIgw6322oGtrILXk56f1nxw2XmTbOIemONKBPuH9TP9bkkWRR+mA23BLMhQri2hnmnPodVCE5CRejZty9s1+mOK0m0AWbUF8+7RgKTciLA+3bgNroVVRyMEoEoJKQcj2LJhSmJCHxS77S50pR5qqB1+JC57AC3u3M1mC6ltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHKBvAuhHefkXxjvszV2EHZd7kxxIvzVCRTd7BrCRZQ=;
 b=z6dfiqnEBqtrR8wFBdK5rdB7hxyoMOuuJkRjAsXlvkyw77oa/+x5Ku5qBPJ9nLCpCGHxZCoBk0kiieqzeK2PPkpgzA/eZCq+S9ygKPhsYs7019WU1j9LYJl2MH1upUCyLDb8lmdmgBLjGg0ySImoJKA5/YLI9CuD/92zofy8nBU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB999319.namprd12.prod.outlook.com
 (2603:10b6:510:40f::24) by CYYPR12MB8730.namprd12.prod.outlook.com
 (2603:10b6:930:c1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Sat, 3 Oct
 2026 16:14:51 +0000
Received: from PH8PR12MB999319.namprd12.prod.outlook.com
 ([fe80::582a:6d15:9b75:5235]) by PH8PR12MB999319.namprd12.prod.outlook.com
 ([fe80::582a:6d15:9b75:5235%4]) with mapi id 15.21.0472.016; Sat, 3 Oct 2026
 16:14:51 +0000
Message-ID: <aeced5e0-7b2c-46f6-a232-a2cacf4e4d09@amd.com>
Date: Sat, 3 Oct 2026 21:44:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: amd: Clear S4 wake bits when firmware has _AEI
To: Mario Limonciello <mario.limonciello@amd.com>, Basavaraj.Natikar@amd.com,
 linusw@kernel.org
Cc: Olzhas Marat <marat.olzhas@gmail.com>, stable@vger.kernel.org,
 linux-gpio@vger.kernel.org
References: <20261002143040.37200-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
In-Reply-To: <20261002143040.37200-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0100.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::7) To PH8PR12MB999319.namprd12.prod.outlook.com
 (2603:10b6:510:40f::24)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB999319:EE_|CYYPR12MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 84160526-f551-4128-d820-08df21697410
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|6133799003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3quTMayIZiUusE/1RTyPpO6kq6a4Kmz5+iqB8N48hau2N6Be2ZKj5y8jDSNVPgIS7KAR0U4OQLfejBN7YyIXxSqgKBMzP+v3SISX8of1YY1vOUJ4g0uX/xPcaw+67d9Le/hAjucrVsupmdO7cAsXOQzVV+4PI8CTZTm6v5FhfNh6gi9OrqeTZJgcda7T7hbNJpU4/1nUTP6M/lZCymq+OWrm0WYitBWNQb9zApc1gGR7gPYxQmPQzsoI+X74x3kWmwJB7Ox0AOC68QX/vcGHS34KaD2ygYb6kB87win9Cr7iMfciNjMmudMW2JNRdcK9m4dyzQQnazFc8BzxKAQBOM1oRIyuFi57AEUw/sx8BwO3p1gEKDlWT+AwAkdIF3ZQjBUv+UBWs+wJtguQqeDd0sXziwdTS3wPtC4jh2Y8IJqgKgKa5l2mdaF/kF/ntoonm9JXIe5eBWqXlQXu+wZpV8bmYYRT61gX1Vx8/WdCIzpAmUeMVk3T8LGGGG1Kmqgk9oZeVivwjvLxatWwP0Ik7NgVfnnWv3pN+1ts/dljgXM1mlOq/X8TOACdNA7x0vS6H7qxFz8AzRvNoT3ady62seMnq2yA8lHQZ8CTVxmqLtX12JYTYz+Be7r8EHnM+V4O
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB999319.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(6133799003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SCtuZFcvRUdGRmpuV3ZmRGpiTW16bUQ4S1E4cjA2c0FRMURnb0lLMzVFbFVy?=
 =?utf-8?B?cVE3NUY3Qi8yNDFXRnZ1T3FTZnAwQ2VGK2NWSzF3TFZ4ZGRGOVhzR2VtNTJZ?=
 =?utf-8?B?S0FQcWVlSVNCemtUeklXZDZTMzA0QzIzeXhIcXczN1JxNXhWWHY2ZzBrcytG?=
 =?utf-8?B?RTZwOFU0Qm9FdytyaEJXWi9RVWdpOHRYMTRMd1NlQmV2SFkzQjJvRGNLZXVo?=
 =?utf-8?B?K08rdXdJZEtPelpIOEJxTlIwUUFCUm5ieWw4MXZsYktCMk5kQmwyZUlHWDFj?=
 =?utf-8?B?K2pMQURxWVpTcUhLUW9TVVl1TkdqRVRRSEg1MjQ1VnFQdWFRcEFXNVgyc3FD?=
 =?utf-8?B?VGtESGdMaE40MDBaakxUbk56Q0lTd09VVlpRbkI0RnZHNzM4RTdlQ0N5ZkVL?=
 =?utf-8?B?eFEvcWs5SXlzWDNQNS9CZVhiSncyazAyVEtCVDZtV1YrbERLWjRNc21Yc3BR?=
 =?utf-8?B?b3ZvZnV6S1lRTHBDYVVMODlrSVFpSDJiTHZoLzdmOFJIOHVyaUQwOXVXWWtZ?=
 =?utf-8?B?NWltU1JqSksxNmRkeDVYQlJldHZlMlU1Um0zcElYckFZZW1GeTFnY3JMaGVB?=
 =?utf-8?B?NE82Y0ZQNndjQmpuMU9xS2ZGeGxmWFEwRzZzUEJDSW9wSGw5cUdwMkxwdFBw?=
 =?utf-8?B?ZUNiZ2R2SXV5ejZJSVZvOUQyYlN4L2p4K3c0UitzTTQwUUNObUltUHp1YnZH?=
 =?utf-8?B?M21udFMzcEprOWFBTzA4U01mZmdiZ2xITnB3eEdJdEcvd1RvKzNKQW5lRkhk?=
 =?utf-8?B?SlZUWkgyVWNzZGNmOU9hZEMzYjIxLzhCOVRqRFRZS0l0YXE1SmFQcmNrNm12?=
 =?utf-8?B?dXNUU0RhU2Z0d09PZlFxUG9QQjZkRGh5dld5a1diYUd5RTJDYUpEOUU1cnlG?=
 =?utf-8?B?d0l6Y0hrOEVGblovOFJ4aXVQczBUaTUveUhSVy85cWpqUW5IN01PbEpmQmV6?=
 =?utf-8?B?VW1OU0cvSGNXajZkWFFMZWNvb1FCWjJOUnloeVZWNW9IQkhMc1hnWk1Yb21U?=
 =?utf-8?B?RGF3VU1KMU5DRGplTnQzUFdvNzRudTF6V2JiTEFweTVWRVFOTFUvdmRxMWtu?=
 =?utf-8?B?QkozZ295MVowTEkrL0g0UGJhYmFaQXQ4WVBrNkVRajJmOWo4TStHUmNzYmgz?=
 =?utf-8?B?NUNUbUJjSVowbmlvMTFlOGcyZVZJeGFySVVhTnV4VTJDWU5xdVc3YkVIbFJx?=
 =?utf-8?B?RDN4c0tnQVRoWUo0cHhzME4vYWtmQnI0MlBiVEJuRHc1d3MyUytVYWhFREtZ?=
 =?utf-8?B?aFVKejZMRElDcGh5L2l4VUtwdVBoaU81cEtjRnFjOWU4RkJ4V1g5Ym9lRXFh?=
 =?utf-8?B?eitYU0ZLZVBmcWYzNVhGZW92VGFld1FxNmZqRktiL01xbnk4M04zYlozNjh0?=
 =?utf-8?B?R00zYWNpRmh2WGgvcGpKK245Y3M0WGF0Wit3RVBQQ3U1ajNiQm11MzJUdjNJ?=
 =?utf-8?B?cDJWR256N0xXV01KM1g5OWNhWHQ0MWxGVVdHbDV4YVlob3hhUTZBNGpsSVdQ?=
 =?utf-8?B?Rzg0QnBLcWtCNktoMThwZDNUVW5CenJlMHRFemFZeUdVcDFhK1crQjJNS1pH?=
 =?utf-8?B?QytWZWZPbUJwZi95M0lYUjRTTnQ3YWFTS2Y1L2dvWkVYaG56Q0FjR0VoM0d1?=
 =?utf-8?B?dEZUWVFWRldTVWNCQ0NWcUhnaGpMRndHSDRoZXk0eXFKRFl1S2ErcDhSR1ZR?=
 =?utf-8?B?Y2dkbkpYR2c4emY0UUlqM1lpam41MG5iZzVwNVEreG1KSWIrell5SmlzU3Fj?=
 =?utf-8?B?eEQxeWdkamcrOG01YkQrcllKM3BGOTVOTjlEOXB1UnZyVGRIMngrT2ZWZHhV?=
 =?utf-8?B?QmRPSUQ0WVlFblNIdU9mWHFrZngyTVhLb2psTmR4T0o4azNNRUlsalJiVkl4?=
 =?utf-8?B?d0tsa0JYM0UxcjdYOWVaMzBwemdta2FJcnVWajVHRzByRGd4RWFiT0J4STZZ?=
 =?utf-8?B?S3RHZ3lLaXVuYUt4Uk44R0V4YmtKSHBYcHMrZm1remUycEppcnZIQ3BPZzRo?=
 =?utf-8?B?K0VCWFZuUkFvRDlhc3doVk1tWmEyd3BLUU11cndxNHM3ZFdlUlNoODRCL29W?=
 =?utf-8?B?MVJPcGpoQjVTMUp5M2JTZHcxeHhiZTZnUlkxZHR1YmhtVVhrOHNaT21COU1k?=
 =?utf-8?B?cll1VGIwWHRJN2xIYXVGbHJjelZITWEzdHRxU3ZvQ3hiRk03U1NZYmV5cGt0?=
 =?utf-8?B?NzAzUzduUnBJekdzcy9QUkFZbE03a2hIM0h5UTJsNWw2MlpGcVNhTmhLYTlE?=
 =?utf-8?B?VHRRUmxxVlpibjF1UzI5MFgyT1Fhb3h1a0I2bFp1K3VSckRkdlBCSGV4bWk3?=
 =?utf-8?Q?2MrxeK61zfSBxh6QV5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84160526-f551-4128-d820-08df21697410
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB999319.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2026 16:14:51.5791
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7WQ4lC31p8HRyQv/Q/oGclklsLsyeSe+W3Y2KZ6vpjsOiE+m7u3sN+VFewIDEr0A7XZcnwWmmCow6CcCWGTFkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8730



On 02-10-2026 20:00, Mario Limonciello wrote:
> Commit ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
> preserves firmware-programmed S4 wake sources because some PCIe devices
> rely on them for Wake-on-LAN. The system that motivated that change does
> not expose ACPI GPIO events through _AEI.

This is definitely better than reverting or carrying per-board DMI quirks.

One corner case I can think of before this hits "stable:" on a system that
defines _AEI (say for a touchpad or buttons) but routes an onboard NIC
through a raw GPIO pin not listed in _AEI, this clears that pin's S4 bit
at probe. That could kill WoL from S4/S5 unless firmware re-arms it
during sleep transition. 

Low risk since nobody has reported that setup, but worth tracking if any WoL
regressions pop up.

A small point on the comment:

> 
> On a Chuwi CoreBook Plus, firmware exposes _AEI but also leaves the S4/S5
> wake bit set for GPIO 24. This causes the machine to power back on
> immediately after shutdown even though Wake-on-LAN is not enabled.
> 
> GPIO register dumps show that the only relevant difference is bit 15 on
> GPIO 24. Clearing that bit makes the machine remain off. However, GPIO 24
> is not itself listed in _AEI, so clearing only the pins described there
> would not fix the problem.
> 
> Use the presence of _AEI to distinguish the platform's GPIO event model.
> Continue clearing S0i3/S3 bits on every system. Clear S4 bits when firmware
> exposes _AEI, indicating that the platform uses OS-managed ACPI GPIO
> events, but preserve S4 bits when _AEI is absent for firmware-programmed
> sources such as PCIe PME that bypass the GPIO IRQ wake API.
> 
> Fixes: ffe8a0c6b552 ("pinctrl-amd: Don't clear S4 wake bits at probe")
> Reported-by: Olzhas Marat <marat.olzhas@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222041
> Cc: stable@vger.kernel.org
> Tested-by: Olzhas Marat <marat.olzhas@gmail.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/pinctrl/pinctrl-amd.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/pinctrl/pinctrl-amd.c b/drivers/pinctrl/pinctrl-amd.c
> index 15a398bb3be23..dca01c5d2231b 100644
> --- a/drivers/pinctrl/pinctrl-amd.c
> +++ b/drivers/pinctrl/pinctrl-amd.c
> @@ -880,12 +880,25 @@ static const struct pinconf_ops amd_pinconf_ops = {
>  static void amd_gpio_irq_init(struct amd_gpio *gpio_dev)
>  {
>  	const struct pinctrl_desc *desc = gpio_dev->pctrl->desc;
> +	acpi_handle handle = ACPI_HANDLE(&gpio_dev->pdev->dev);
>  	unsigned long flags;
>  	u32 pin_reg, mask;
>  	int i;
>  
>  	mask = BIT(WAKE_CNTRL_OFF_S0I3) | BIT(WAKE_CNTRL_OFF_S3);
>  
> +	/*
> +	 * _AEI indicates that the platform uses OS-managed ACPI GPIO events.
> +	 * Without it, preserve S4 wake bits for firmware-programmed sources
> +	 * such as PCIe PME that bypass the GPIO IRQ wake API.
> +	 */

On the Olzhas's Chuwi machine, pin 24 isn't in _AEI either, yet it's
the pin causing the issue. So _AEI isn't distinguishing which pins the
OS manages - it's more of a platform-level signal that happens to tell
the two boards apart.

Also, You could drop the outer "if (handle)" check though, since acpi_has_method() safely
returns false on a NULL handle:

Either way:

Reviewed-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>

Thanks,
Shyam

> +	if (handle) {
> +#ifdef CONFIG_ACPI
> +		if (acpi_has_method(handle, "_AEI"))
> +			mask |= BIT(WAKE_CNTRL_OFF_S4);
> +#endif
> +	}
> +
>  	for (i = 0; i < desc->npins; i++) {
>  		int pin = desc->pins[i].number;
>  		const struct pin_desc *pd = pin_desc_get(gpio_dev->pctrl, pin);

