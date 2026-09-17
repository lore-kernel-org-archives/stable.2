Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011047.outbound.protection.outlook.com [52.101.57.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA42C391828
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789676781; cv=fail; b=FlNGoRdl9D+79kOd+YL2VqCeqbFGMPaz0uilF7TAyf0ZDcEKQr+TVlZQWUQIElAqgoZ7SQszB0+5qXeTdPVkkODpNI68hb3Rl/qM2ac05cLhZqOj2HQ6g078KBtVUa0QqM1CmWklm35VAhKiwNh59RxWlDGZrd3Sit3jAahQ0lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789676781; c=relaxed/simple;
	bh=DI45E1mgAG7xGA5h4z9MPRTGh3PX8nRmHpiieOWbN9A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hU8ECebeP6YYciA7OreHniAkx5K3JjynKbKHutUfvu3Q8w8bPVhTgXQ6fIoxUcYHof8QzOeT7Rhs+AaV0g3B+08WPvx3YhWllN5Lqu/3pzoTYeaTuQWcpiQUZ2cpRAgdVNdQ3nE3pRRFkIfAqnufHfdOpFkJVafTvGQ0s5xQlPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m9DWyDmk; arc=fail smtp.client-ip=52.101.57.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m9DWyDmk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xFGFnJFYO74hmLdO5veubsIhnD2fGUKxT9h0IVROlYB4YuWT97HJQwHlfdhICoeBytQ36hg8TtCc5fyMuLHxBZv3A8kW5VybIieGoBhWR1FDeCp0OW/RyFTtt7MvnrINSZNKafp54Afb4T2klj/eQ3Pu7e9Z6B6Y4dzk5xSB5WlVm5T93P5w0yxatbtLKM5GCubWgJw1qMJkJWkEgVE6Bd8Hp4Z7DgebPyIpJSkf5NoZ4h6jgf85MF7/cRdq3ui5x8kdF2FSTrPv07fM3dUc5xTXbLWVjdlaOjl89uPJGmGbgV8xR/7AFtLPiw/H2XsOvf7awUYThzAcVpxvDnHpNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyLyjn7tBurALIVdLMVTxdplDRX5x894G3TrGhS4oAs=;
 b=EgpwMR678UMyt45oCrM1nYqbhceXPgizUcwh/zOkAmVtKdUV6Z8u7Gip7zQE6hoYdOoHgZP+KkvtTEfQlCk1sfDxpSd+dCZiwDhfsXofxRPcQYN8y2lWGAK/zF0NZb2rLN0Vze7cOVBEd7z0jQpBKSPQbD/K5d04RSFCGYLQKu7scNEey8RzJvTKQdYOyFhVngZ6gZ1DMTK5BIXCD95j7KjMty73zaWeUI8t5YLvaSSqXaaJOhIq5+LDeDZ7o1pvLvurbVjDe5yIzd+WHQguwkVTRqKbkf5GyHzspF/bAXffgFXO9j+SWpRtpSgqViGujgmuBMNdBZhWhMG+yBUlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyLyjn7tBurALIVdLMVTxdplDRX5x894G3TrGhS4oAs=;
 b=m9DWyDmk964bnBR13E3CgAMq8RJqAxGOxOywYetF6JVqA9s0VqVo7JuWY4oFOJumth4JLd+sTf8keOY/Y7KNI8H7MKdWuHpAxEo4vise9oZYU6qh7IMeXA0/tEHuFuSJclwNHmQ3DWYOaZESxAz/k1CwP8xK2FNBJOXqraiSL1M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by CY8PR12MB7315.namprd12.prod.outlook.com (2603:10b6:930:51::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 20:26:16 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 20:26:15 +0000
Message-ID: <af7a9d72-2294-45f1-88dd-9818392e9a65@amd.com>
Date: Thu, 17 Sep 2026 16:26:12 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amd/display: Honor EDID overrides for connected
 sinks
To: Mario Limonciello <mario.limonciello@amd.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
References: <20260917135949.2552704-1-mario.limonciello@amd.com>
 <20260917135949.2552704-3-mario.limonciello@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260917135949.2552704-3-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0007.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::19) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|CY8PR12MB7315:EE_
X-MS-Office365-Filtering-Correlation-Id: a6e45b22-61e1-4598-9527-08df14f9ec68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|11063799006|56012099006|3023799007|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8fIptCu3KIxY3NPIBGIBkFzQ+R1HMBw9/Yq8yxgkaW3Icr0c70Wm8fKVubHgB6BsJJvjB8qw9TD6FK0UfV8ad8JZfMi+CHMNyRNDf/2Eh8b+n4m9nGYIcnCNcZnywA6IXcef1uLoNQIQZZvG7BywKWwjTG4SlXK1luw+mFax+QmWhmz68jwUg2drUqUWrOr7oytLDWdisXzKudZz0Y23FgSfkybmtrZcWVIYGdBgf0NsnE/4mMt/GBRwWBYR8fC9fSGX+wJimX1+hjvcbFc8JM0bjVTrsAye069k2bWFCVTmvrZRnm/FiaHOcpoMQpFId++HSfwmiucyxDA+j3wGTvtNXUk2DZTc/FB57b+XzFqqnUZR1t/nJnn3IiiCIIf+RgppJPwhqJkvx9Nn3KluzA4/k6jZbiSj+E+XbDY/K7Cy9VHCyMzOnhhz1ecG7U1nHhduYtJJRdCaZIe++VTh7JFPZVzPnG5LG7Lic0e0djukbhuE5+ErfcjvAEQB2NSF2AwVAb+DUZ1HumDDGRG/ZCpX2cw9OABGQQ+Ef2sEtWUsO54kDUav/fVoV6qd0YX9ehizuwQxj+1YSgiHNA/cokGWNEnpnfEqstYvN1i614gzrSp6LF3f+03ipeoIU6xj
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB7007.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(11063799006)(56012099006)(3023799007)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cGUvcGQ5TzFhZUZ0S1R4ekZVS1lXd1hJYjR5VVBtRHV2WHRxazJvNldPZHpo?=
 =?utf-8?B?Tm9qMzBEY3lJUFpPWWhvVHFjTXhSaXNPdGpLY0VEMXVNUllrdWI3eVVRRWlh?=
 =?utf-8?B?VEJvQTg0cmI2RTZoRDRGN0dldk4weWZpRU1ZN3BVWThld0kvZHdWdzNDc0kv?=
 =?utf-8?B?Sm02aG1ETERpeHhmdmZycElrbGVsMkFlczZKaWI5ZjNKR1NqaThoQk5CaURh?=
 =?utf-8?B?Tm4wRThLU2syY2wzWFhMR1lIaTNWaHlpajJrZWJseHhZbGxwMkRzcytHSnBN?=
 =?utf-8?B?ZndrVnBVNXZja1g5VVBBQVNXaXZ6d0E0NXl5YXlZcXg4ZjJ6cnhEelNyWnJv?=
 =?utf-8?B?K3kyWEltbEFFRVU3N2lNR1JZSTkxWkdZdWMvMitiRXVDYkxXWGtiVWJpUEhS?=
 =?utf-8?B?ZkxFQ0dwdWJnamNpWVZSMTc0SXZwY0xFVFMwa0xQKzhLZmdORktOd3VrbWFU?=
 =?utf-8?B?dDVMUlNkMHV2d3NEeFRxVUxJUFpoS284TnI1MHMvN0tubDVSZFJ1UklDcVUw?=
 =?utf-8?B?UWQyQnFMMGxmbDB0MGp1bitZQUU4cEFTb08vYlMyd2hiVEpVWEdwTkxZR1Vy?=
 =?utf-8?B?RmhnNmM5RnhPbUcwbnNRcHR0UTh3NWJHT0g1NlZNQnByNW5pUTNlUnR0MjNz?=
 =?utf-8?B?QTdXN3U4OHpQVndESms4dUdya3VONDVnazkxM2JGbkNhNCs0NWpqbFMyM1Jt?=
 =?utf-8?B?Y3padlc2REF3V0hCcVZqbFNETnNRWTMva1lOVUNWQjhSMlJtL1ZqM1hzaGRv?=
 =?utf-8?B?cy9IOFkwMUp1endoazhlbmp1dUNMYVJSS0V6dzBXb3UwMi9vckFDUUc0ZVdq?=
 =?utf-8?B?NGtuM1l3RFBpVnRjZWk2dC8xdk1JeUl0MjFQNkJVVDRKaW9tTkZ4N1FlNVo1?=
 =?utf-8?B?d09EYnZDTmNSK3YrMHY2aXU5SWoyVlJ2am9iZGIrUlRBdktNa3ZTWGNvUzU1?=
 =?utf-8?B?QUdaMlVFK21sKzE2T3FrVGxlOU1WV0lzZ3VTYTFDOGVXRjhTN2NNb1NCM2Z6?=
 =?utf-8?B?VTh3Mzg5TFB4L0tWK3pWaWZuU1JUSUxMNjVNRHREK0ZvVUdCbXUvajUvTGpl?=
 =?utf-8?B?T09KRTNuN1dieHlnR1VEUzU5Uml3UUhVOHp2SHBVTUV0OEVncWdLZGV1SFNS?=
 =?utf-8?B?b3NmMWJMQ1M0U0xkQ0RuL3RWR01VeU1pSUdnQW5KNEQyUkxzd3NFeVJIYWlL?=
 =?utf-8?B?R3BBczJ5eXZIR2J1YmZCS3B1VmtYUXRZaUhaYXl0NzdCQVlhSCs4MG45dWor?=
 =?utf-8?B?OXR1MWJyM08rTldUQ1doNUZBem1WLy82MDhZVitKdmdFbm81S3o2cGw1RG5v?=
 =?utf-8?B?K0RpTVdFVXJCdVEyRGNmaGoxM3NqQnBtQ3BJc0lORkZCQjkvS2haa1Blbko2?=
 =?utf-8?B?aVc3bmxnNWNrZnUyU2pkaGNwWlFqZktnMGpkekhJdnFERzVKVTRUOUFSb1BM?=
 =?utf-8?B?ZDdSVUtQR29hRWtKdWxzajBzM2k1d1dzVEgvdnNMRUVqdXF2TENyZHd2WnBC?=
 =?utf-8?B?bm9wS2FPL0hZRmZjVGszYUN0U09nYnlLNXlpQ1UzOXQ3RVQxV2p6WU0vZ201?=
 =?utf-8?B?RS9tNHh2MTRDZjJKT0VnU1FKOXhKSWJST2tHcFQvcGxJVERJQ0IyTDdsbGd0?=
 =?utf-8?B?WHdxU3hNaUswOTBmTFZHRG1XVjJoK0I4aGZRbm1Oa3FHajdhK3g5T0dITjIr?=
 =?utf-8?B?aHRMcllrZUVpZVdwa1ZXRERBU29ER24rYU1NWHR4MWg2dGNCOXYwQWlDNnFY?=
 =?utf-8?B?MytraXpiSGdjOU1nV0x6aVArbUV2RE05Tk1SY3I2VVc1ZlpMc2Z0OUJ5eUhO?=
 =?utf-8?B?cTBOQ1JYUk1wdFVQSHVnc002S1BQc2hUanNSQzd5eEh2dTYwVmF3ZEh3K2FI?=
 =?utf-8?B?VzgyRFZ4bnVFRFhyVnZ3Z2NXcm83MWM0Q1VxUUhTaUIvOTFGS1NXQWxOZitz?=
 =?utf-8?B?VXp5aEw2RTlvSVk0OFpncW9TUFZ0YmRPbzQvREhUSGRTdnFZYlAwT3UyaFV1?=
 =?utf-8?B?SWRLdXFqWEkxcytkc3k1VVRiK1pVZVlVSzFQajBwZGhRMENVaXkvMGkwaUh1?=
 =?utf-8?B?TjNoU3U1dnJidW9FellBZVVrUGRFYTRFbXpuUjgyeVVaYUJyZWVJa1d1RmF2?=
 =?utf-8?B?ZE1DUjBtR3FVWEMvSkF3dk5tWEljMS9nWjNKZnhSUUlJSk1HVFYrWGNIeG5P?=
 =?utf-8?B?SWhDbmhYUDFkei9sZnB1QzNrL25JY2poT29kWTZPcUxKeUYyeFA2YWNQRld5?=
 =?utf-8?B?Zm10Sjhib1lXdXp6VUJXYVlJazZNVGtEdjBjR2NZSENFS3F6K2RIcmRqWG5w?=
 =?utf-8?B?cXlLS2Jyb3QzVXVkZzBsMjVXcDIzbDdzdkMyaGd1Tm1mNGVwZ25HQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e45b22-61e1-4598-9527-08df14f9ec68
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 20:26:15.6935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpPtL9fJckcw0iHr+OB4jeIyXqWasem5FkbmU8P8LVp5y/jn5fTJolkepw/JhKm8lDIzAp2qF0rW18xkhUVhaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7315

On 2026-09-17 09:59, Mario Limonciello wrote:
> Display Core determines whether a digital sink is physically connected
> from HPD before dm_helpers_read_local_edid() attempts to acquire its EDID.
> 
> The helper currently calls drm_edid_read_ddc(). For an unforced connector,
> that function probes DDC before consulting a debugfs or firmware override.
> If a present sink stops responding over DDC, the probe returns early. The
> configured override is ignored, and AMDGPU creates a 640x480 fallback mode.
> That also prevents DRM's later override fallback from running.
> 
> Read an explicit override before trying ACPI, VBIOS, or DDC sources. Since
> DC has already established physical presence, this does not make the EDID
> override force a disconnected connector on. The existing successful-read
> path updates the DRM connector and copies and parses the EDID into dc_sink,
> keeping DRM and Display Core state synchronized.
> 
> Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5779
> Cc: stable@vger.kernel.org
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c  | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d451082552e83..b8f02c854667e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1244,12 +1244,16 @@ enum dc_edid_status dm_helpers_read_local_edid(
>  	 * do check sum and retry to make sure read correct edid.
>  	 */
>  	do {
> -		drm_edid = dm_helpers_read_acpi_edid(aconnector);
> -		if (drm_edid)
> -			drm_info(connector->dev, "Using ACPI provided EDID for %s\n", connector->name);
> -		else if (!ddc)
> +		drm_edid = drm_edid_read_override(connector);
> +		if (!drm_edid) {
> +			drm_edid = dm_helpers_read_acpi_edid(aconnector);
> +			if (drm_edid)
> +				drm_info(connector->dev, "Using ACPI provided EDID for %s\n",
> +					 connector->name);
> +		}
> +		if (!drm_edid && !ddc)
>  			drm_edid = dm_helpers_read_vbios_hardcoded_edid(link, aconnector);
> -		else
> +		else if (!drm_edid)
>  			drm_edid = drm_edid_read_ddc(connector, ddc);
>  		drm_edid_connector_update(connector, drm_edid);
>  

