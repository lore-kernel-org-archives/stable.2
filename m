Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550B432E6BC;
	Fri, 31 Jul 2026 20:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785531191; cv=fail; b=YuewKK3iGhgVRCNVGN+87LAQg4u2Ouy2YSGx/jpr3fUHhiG6/XAAAjFjThLoB9sjFey5OPdiYmRgPaUnj1BNG/LHIlKqvfWIKow6X3MgA6aNggfMAdxsVYpyLIYbEz5XeF0uWEIgJWwMijGBWE3593RuNw7bUwyRK9Wtz5c6wX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785531191; c=relaxed/simple;
	bh=NbEDRhKpOCUOswQIcW1WQYJmh7EdI4tk6biC5RMm4qQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zj3O5SUMeESAGRUz1NXCjOBkQ1G+YRwbEAl7gaXncWvPySTYi9S259qs7gjmNA9hJcmNvBzlDlIeW4U0fL36n/gEhfUi5V0lRIL2I3aNywuIQ/D62NCfuCojk354On6865Gxz9k70YArUvGrOhG2PLwDPBEoVsqELJly9Fo7kt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=izWpMb98; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="izWpMb98"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MxLf384A9+g/3mSyzJNYSeUxH6x2+u177rnAZnm7UFcMMahpatmXF+rqoKhWWGPW5zvFKbx4JFYfSENRLpQgMQx8+hIw2Vc9bhzVPsTdJRC9fTixB8OTjPXCJuhEinfoG4I0sXtIi7WPVKIj5JwUGoNEQBCCzB4RnLkFrrI+HYrPpCXT61mia1b+GLEHbxGmbD6rGFG+Bya6yJi1a0FUje6sVnV+c6CMlCMfLYVbE33FypPBrC61zLcniW+bQGLZ97vzet47gXnbZYVZk6ftgqaRRgFzeuZR0gA9PvswTnqgwbIYW0m+cnqd1mg3aJbjT6kZcfA45VfwHAgUpzhRxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF9OprNpKwTv+ex95HhGx5+nAMtY1E4uWWJv03rWfSc=;
 b=SUPy9lVBSO1lYWp6E6EVhPRIWGS93K5pN3fekhmT1Ur5iXk/fi1DIDUKA9huKgHCrpBL8mVZVAEQk8JS/XtQcWdWWQJdzHFh625ZBAwLXm3MwqyN+GyABJYUeW0JZwKpjLJblac0WLOqv98j6caSs+lAyArKaw+AIWCnbdZnVY+5Js/0c4MsKqZ6sZosiWTo6jRU7X68bBRRGjHfekw0pCn37CWvZubCIJDvqjBjqVfkMDkhUVtkC9hHYhCraKs36fP9C+JFjWEupZxHGKidsnl0tvjoqxeiZ4YdPTHoptqm6gLc/6960e80A+CXAeQAAbxHs5EtTfyFHW6AdnBY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF9OprNpKwTv+ex95HhGx5+nAMtY1E4uWWJv03rWfSc=;
 b=izWpMb98WvnFFhVH5h6JTZ7wk3LIgDNFHk6fikwLgcQwQfh1W1YjM5+W9N4qh7jBgTvC+SsOfDfx4bk85zVFj/5QD1a++1Uj4Hcpyk3BhvdQNoTZMyXehy4xWZAzC4dIBPW4V/1El4EsZFsYqiLcWOu9dOdap/+JNhoGWTGIx9silcC3deoHSaGYsNfEp7Y8SZbzYkTp8a7I1Xv7mPquegXN3QS8nDUJ55jLvIW0p8j+qwgb9w829w2oF/GBIWvaMUCZPyoSot/VYqny/bWOXIqAmaMuO7k6ShKfvR3b4UJ0S4D06/By1bD26I1ghlBnMEwys4qieK4mgaQbLEK77A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 by MW4PR12MB7287.namprd12.prod.outlook.com (2603:10b6:303:22c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 20:53:04 +0000
Received: from BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f]) by BN9PR12MB5179.namprd12.prod.outlook.com
 ([fe80::cf08:f59b:d016:c95f%4]) with mapi id 15.21.0270.015; Fri, 31 Jul 2026
 20:53:04 +0000
Message-ID: <3945845a-af6a-4d24-9821-a3925a030301@nvidia.com>
Date: Sat, 1 Aug 2026 02:22:55 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 1/3] ACPI: CPPC: Reject desired_perf reads on ACPI 6.6+
To: Christian Loehle <christian.loehle@arm.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>,
 Jie Zhan <zhanjie9@hisilicon.com>, Lifeng Zheng <zhenglifeng1@huawei.com>,
 Pierre Gondois <pierre.gondois@arm.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Ionela Voinescu <ionela.voinescu@arm.com>,
 zhongqiu.han@oss.qualcomm.com, stable@vger.kernel.org
References: <20260729100245.2628302-1-christian.loehle@arm.com>
 <20260729100245.2628302-2-christian.loehle@arm.com>
Content-Language: en-US
From: Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <20260729100245.2628302-2-christian.loehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0174.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::15) To BN9PR12MB5179.namprd12.prod.outlook.com
 (2603:10b6:408:11c::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:EE_|MW4PR12MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: e2518542-973c-425f-1ec6-08deef45b712
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	TvzT/qH5fAKozs9FLs7WZOoUPMP4C0IyglAKaCYXrbBxM7pX8cSlTMY3ukwTy9/qh245vmfozp4JA0yxBYwP1gjUfUpAkjYdE/d7eaWAznrrume8nSR73KCJw8Ibko8iz1DsgpsA57LU372ZD1UlaA6eYali7L3RNPanZ8Tfuk71Iiw1H+m7Fqb/i3P7DpU1nFcHye4pmGMKn2z3UHpr6xAnbJWeNH67OWnBUBcYfRXqkXZ76NivUqAdSbWAU/p/ex1If4RQfywSPPGTYin/yJKl5n8UGzXncvnBGk9B1CRe+XuOv1JFGwnvFt577VFnE2MIu1GQrJsAGd2d9A1oTp18K14VAqMMfLrDkUOHsuJU27ucqP81mYgHZNtC/HbA/khCHdeFPEwAZEHUWeRI2A/dGpXS8Z1LwOS82R7U5Vkt01keKNZKhnewsW9aTOBDecca+fujbD4IwT6oP5bI8zZ3OWS1zQBhWCJqBEbUjqPAT5JigC6O/HVgDcoB8F52PtRZCp+yaGXyFq48Hmfrdgy2f/A/upFn2ou1sVKunAwFqP1h8cqUyZqTmi2GOTD16C4RpGtFegFeTVDTkxu82/O3yd8LnO86ek88zGJYgmoFJPukGkcVrnL0ra+C/NNUPaFu/m+L2DWV8L5xJSXM4AAnS3ZmSWi71n08Wreioas=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5179.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkZxYnh4aVlkbUFCeng4Ti9TNXZLSWFNTEdrQnNVaHhaUHhkeFpCRGR6dEVl?=
 =?utf-8?B?aXQveE5INWN6dXJkZm9tMVpWcUFBMGlBRTYzeWExUWp6M3cyRU5QY2QzS2U2?=
 =?utf-8?B?bW9LN2czaGtKbHowaTVZbk5SNGpJOGdSbXZBVXhjeVlEcjJDN0xSS0lhZ2RL?=
 =?utf-8?B?clZySkdvM3NsS2ViY2VFbmt1WGwySDRoZUdHTjVjbzJaSGozdFF3cGgvZ3pa?=
 =?utf-8?B?cW5MVVo0dlY4R2lZWnk4eGNnVjZtNGNOSnNOZHU1Nm5FVmNaaUZtWllZS0lE?=
 =?utf-8?B?MzBIT25XZkFHZEt1bzZwSDgzZXZ2RUxWdjNSZ0w5ZFgvRjUxUmlYajRiU2Zq?=
 =?utf-8?B?TUtMNUZiYTNSbWRVV2kxajlEWkF5TTBhUGdnOXlpbTMvbkZpZm90Tlc1MEFX?=
 =?utf-8?B?ejBkZEFkMWpRamxzMC9qNTRBUTFqYmx1WVJaYzVRZ2pHZ21lQ0lQeE90NmVO?=
 =?utf-8?B?OWNvZGNEOGFiYXFnZ1pmSXllUXpCTENBQ1FGZ3lSWGdjMmc1UVdrbzQ2SFZX?=
 =?utf-8?B?OG9zM0hxM2hnMyswWlUxd2V0QTY2YW5YeWNPUHdRakdORFNOQjRVU3Y0eTFL?=
 =?utf-8?B?UWhGMTR3Y2Yvd3Q0UXN2RFFlT1NSdmlnU0tqRlFIVHFYcmNabVdzSExjZ2NF?=
 =?utf-8?B?TUxoWGlLcVp0anNkWDRkVlJ1Nld1S0F1T3NtL00xenFFRWtwMkRBVWN0S1dH?=
 =?utf-8?B?VHBpZ0k2Zm9rVnViUEhDUTFBUmdXZ2w3dHJSNkxlaHNNS0FvcElUUWx5R0Y1?=
 =?utf-8?B?aFEvcmxsSzY3c0tsTFpXRHBldG1TVnhsV0ZJbG5WQUZ1Uy9vNTlGS0YxVGlD?=
 =?utf-8?B?L0Y1WUVTVS8yMVpneWxZeDJkTnNINlhibDZFQysyQkVDL1h3dVlNSWV2bmx6?=
 =?utf-8?B?RERzeDdEOWs0Sm42L0VheUgxd1hWeVBvUkdnV3IxenlYYXoyTVZrKzJmWWQ2?=
 =?utf-8?B?TlRtZUV4NERnMEJLWFBMS3EvMk5FVGhXbHF4V2xNWkNtaFYrTlFFdFl2QzlJ?=
 =?utf-8?B?cklJVUlSb1hBM0xLanQ3REVBTi9JYnR2NzRDV2pGelhrdXBGNzFKWHJPV3NS?=
 =?utf-8?B?ckpwUUdFaFBINDNHYU1jZEF4NHpXUjNOZHBXZ2Y4T3lHQmNsZTJzZ1hoekRn?=
 =?utf-8?B?NXJDa2xQSGt2MmIraWdzMFVoVjlDS2Z0VzlqZTBnUUxqUW9Hek5SR0h4Y0F6?=
 =?utf-8?B?UW9jekQ1OTVqZ3c2dGsyMGVQN2QwR2ZQTDJUb2hxYlFaZ1NscXpzUytaZmNN?=
 =?utf-8?B?TDczSFNLd3l3QWdJaGl5UlIybGFPVjdDeC9QSnhScVVtcmc5RDNGTUM1QmZF?=
 =?utf-8?B?UnpCREZjeHJxT2MwYS8vUE5tbVFVV0wvc2p2RXNmZlZ4eVlOOTVGakhxemVY?=
 =?utf-8?B?clRvYlBWUE8wYWo4WW9UZE41R3dYRFRSK0wrSnNqOCt4c2JtUUhKdG5DZ3RW?=
 =?utf-8?B?K0hFQzlmTHk5cDJSSFczcm1xMzJRL2RQQzFYZzZmSGRGam95ek5pT3Y2SHgz?=
 =?utf-8?B?NzlnUG1OR0wzU3oyTkc0Yyt4SUlLc1pqSzJVRkhISUtaejJLMSs5K2FORXp0?=
 =?utf-8?B?dDFlRFNTaW1GcU16a3pwdXNvcEpzVU5TWFBiK1BGZks1aWl0cWdVeVFqVUVa?=
 =?utf-8?B?b1l5Kzh1WmN4eEQwYU5DQTZjb21vVGRTVWYvTDJ1STRld2RJV2tDNXNtNnNn?=
 =?utf-8?B?bVdzVmFRRk4xMUVBVnZGendHbytybWhJc2xuVzlXTnNlQy9pMFVwNFp6a0Y3?=
 =?utf-8?B?RFR5bDQ5RVNoc2NCWExvRWljTmc3eWZxamU2U3o1YzFjOUc4RUdvN1cvUlBD?=
 =?utf-8?B?ZU1oNEkyYTByS2NjMzRDVXdxS3JWbmtUL0swd1A4UEwvbk5YaGxERmVGTWl4?=
 =?utf-8?B?ejJCSWIxV1dJL1Z0anlxOC9teTRHYkVBVWsrSzd6LzBOb3lOcGdSUmpKaTNl?=
 =?utf-8?B?YTNjdWRpNmlEK1ZqQ2IybDJSODFjSEVkNDl2Qk9BY0pPUUt3bHp3bGZYc1ZX?=
 =?utf-8?B?U2d1b2dNbW85WUk4WERpcC9CU2hsZFZ4Zkt0OTZQZFRReHVIN2tUdUZVL0RT?=
 =?utf-8?B?NjQyTEhlY1plVkMvWU5mZkdUNlUyS0hFTmNoU01RSEJFaHhKb3BwU2gza1dH?=
 =?utf-8?B?MHprMnhGb3NLQnBQVW1QZWlHTzdJTC85Nzh1UzFocWxzVTBEVmJQWHhxUmlp?=
 =?utf-8?B?S0Z3QlpidWd2cmJwbkVFMmxOY3E4dkJQOW8yTVlXQS9YVi9Nb05BM0RIblA3?=
 =?utf-8?B?NHlCZi9ka1FpdXl3cnZhSlhqRjhCcHpwbVA5dlcrZVdZVHI1ZzJKeEh6dXlD?=
 =?utf-8?B?VldCVGZ4eXVHa1lWM3JWYVRrZW1KOUI5dGJsRU0vT3pCNFlxNXc4QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2518542-973c-425f-1ec6-08deef45b712
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5179.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 20:53:03.9660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LhiWvI4WX1/s5bv8oTlwCTLp2oAm0JMsdg0uSttgdHvwITyapZU4cmYLOPG2RYAUPCMJqMFXafBrB983I2kxXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7287


On 29/07/26 15:32, Christian Loehle wrote:
> External email: Use caution opening links or attachments
>
>
> When CPPC feedback counters cannot provide a usable sample, cppc-cpufreq
> calls cppc_get_desired_perf() because some platforms repurpose Desired
> Performance to report actual delivered performance.
>
> The fallback was added for platforms on which Desired Performance reflects
> delivered performance. ACPI 6.6 defines the register as write-only, so
> invoking that workaround on an ACPI 6.6 or later platform would require an
> invalid register read.
>
> Make cppc_get_desired_perf() return -EOPNOTSUPP in that case. Its caller
> already handles an error by using the cached desired-performance value.
> When checking the FADT minor revision, mask off its upper errata-generation
> bits and compare only the specification minor version.
>
> Fixes: c47195631960 ("cppc_cpufreq: Use desired perf if feedback ctrs are 0 or unchanged")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>
> ---
>   drivers/acpi/cppc_acpi.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
> index 53d09ca98f06..6e5381f8de38 100644
> --- a/drivers/acpi/cppc_acpi.c
> +++ b/drivers/acpi/cppc_acpi.c
> @@ -1316,15 +1316,28 @@ static int cppc_set_reg_val(int cpu, enum cppc_regs reg_idx, u64 val)
>          return cpc_write(cpu, reg, val);
>   }
>
> +static bool cppc_desired_perf_readable(void)
> +{
> +       u8 minor_revision = acpi_gbl_FADT.minor_revision & 0x0f;
> +
> +       return acpi_gbl_FADT.header.revision < 6 ||
> +              (acpi_gbl_FADT.header.revision == 6 && minor_revision < 6);
> +}
> +

A platform whose _CPC follows ACPI 6.6 semantics but whose FADT still
reports 6.5 would pass this check as readable. If the register read
returns zero, cppc_cpufreq_get_rate() reports 0 kHz and policy online
fails with:
   cpufreq: cpufreq_policy_online: ->get() failed

Since the FADT version cannot be fully relied upon, would it make sense
to also harden the consumer? Although zero is valid Desired Performance
value, it is not usable as a frequency estimate.
So, cppc_cpufreq_get_rate() could fall back to the cached OSPM request:

   -    if (cppc_get_desired_perf(cpu, &delivered_perf))
   +    if (cppc_get_desired_perf(cpu, &delivered_perf) || !delivered_perf)
             delivered_perf = cpu_data->perf_ctrls.desired_perf;

Thanks,
Sumit


>   /**
>    * cppc_get_desired_perf - Get the desired performance register value.
>    * @cpunum: CPU from which to get desired performance.
>    * @desired_perf: Return address.
>    *
> - * Return: 0 for success, -EIO otherwise.
> + * Return: 0 for success, -EOPNOTSUPP for ACPI 6.6 or later, and a negative
> + * errno otherwise.
>    */
>   int cppc_get_desired_perf(int cpunum, u64 *desired_perf)
>   {
> +       /* ACPI 6.6 no longer specifies Desired Performance as readable. */
> +       if (!cppc_desired_perf_readable())
> +               return -EOPNOTSUPP;
> +
>          return cppc_get_reg_val(cpunum, DESIRED_PERF, desired_perf);
>   }
>   EXPORT_SYMBOL_GPL(cppc_get_desired_perf);
> --
> 2.34.1
>
