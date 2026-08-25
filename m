Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012010.outbound.protection.outlook.com [40.93.195.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5C24570FF;
	Tue, 25 Aug 2026 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787663875; cv=fail; b=nllOx0n4ZHWtUFgf/f0QKM5RecY5ZZb6BZC7tRKf1y2WI9LREsz92RLLxSBUikNk3WFb8tsgVwiodNtBVaxN9EPzCPOt8vyVH+PBqvEKP2VnSP8NWUAx7Kw8Y9V/VvmDY4A0UhBT/Fm25Gh+TgMF9dxNei3PU2x1oC47fOmAgqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787663875; c=relaxed/simple;
	bh=hXA73AuajRXeHp3TS7/LiLCjm5uJbdOoa8lBRDhyrH8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L6Zz7BGclIFYOCYrBoGj614s8Crk3v1/BATP+qKKlfQpYZJBq6JW/r56hua+SP4Gq1WPrFHXdg4JMPMevwB70KBkt3sQFmnfZA+UPzeeL0Fsw095G6/jAzms7kpeg6WOYZiwV7BggA12g9TLuiM1gSR2NBHNCbu76Ab0dP9lQXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wd7GW9N7; arc=fail smtp.client-ip=40.93.195.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wd7GW9N7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHo8CgQRKZyFbOL18797miUnnMkKaZ6QnqvdTX5EVy5tJaYqkXBXp1LqgI1HZ3kaDw/mGZDeACc1FHE9vIJp9mx9HaV6pY6ivMB9tZ1tV4TH2jMM+j7v1mpQJJYbZkdsbebBscccZZOw48RdDjrJqTM+rMzVWAKFndb6wEHfdD0Y4Bz5iHNjXjNYDe4F8+orLB5kDF3ynNJFAzP9QwpYQOaRgTp+kY+yDRD1Ed6A4OOiNkefRCdXFfonGFIIyYfCeo1woK8UC7eZGCdXe0yT83WsY5Mh83SZCZZb9TxAlYcdPrQeFawXqvZ/WsnJ0LJz1md5UXBUdNYzKmhyAb5Gjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mxGtSMecCscX+ft/cEfEbXnEEvqonyzVsJb5noAbOo=;
 b=twTq/vd0vT4N7fTnxHEfY0aqrO+snjhIjJAobhlu+cRpkUydLP9+KVU6rxgg4hWGS52cmPi/RVD3qp5jpYAaMRMplMPOJk3S6FlYtU8U7PiqDhGS/vAaX23uIYFVKeVOnAmPDSKF6GQUDDvGMXgwP9P4+WeNE9tnDNZgFIg9DSKYYGS8DNv2KSYRR938dqSjMFFtnZbNFxl9KaVW9U+IpJL40QGLZK+9wXT/8di+60JxEOtd8CufCfsBgLl4GsoxjxUNfjp2861DFGP2woYQFZz5JmJ3ZPHeA9Ot4wMf841Mv8HZNUcgXx2lci6nInJGx7pe5GQxwmpAxCvaV7BJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mxGtSMecCscX+ft/cEfEbXnEEvqonyzVsJb5noAbOo=;
 b=wd7GW9N761Lp+2B0LxS1jTIoYTkg6ldlPqcJk+JtuNMULheQws+KvmjrHqiq5foqAdf3e2cvMFKP8Pvm0BPnXKXbtDL7nbPKofyBvpYCuPbfOFtLm9Tl1tgcYdTialxmoI5T3nOymqz4roEJUEPBDTDsRbvBoe4SlvQdGNoJKeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19) by SA3PR12MB8803.namprd12.prod.outlook.com
 (2603:10b6:806:317::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.7; Tue, 25 Aug
 2026 13:17:48 +0000
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99]) by LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 13:17:48 +0000
Message-ID: <0524f7d8-970d-4a2a-aa6f-c0cb9d479deb@amd.com>
Date: Tue, 25 Aug 2026 18:47:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
To: "Guo, Wangyang" <wangyang.guo@intel.com>,
 "tglx@kernel.org" <tglx@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>, "Li, Tianyou" <tianyou.li@intel.com>,
 "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
 "Liang, Dan" <dan.liang@intel.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260821184923.2462575-1-Vishal.Badole@amd.com>
 <DS0PR11MB80186E471C1553ADAB16FEA592AF2@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <DS0PR11MB80186E471C1553ADAB16FEA592AF2@DS0PR11MB8018.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:d::13) To LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB999069:EE_|SA3PR12MB8803:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c6a5259-cd37-4a64-68f2-08df02ab41da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	URmqMtJtCzKkCKN2m1MDTLTiIV3ot9qioqYa3Mn/542QGRHU9xaQ+imAKtuKETbGgqPHAc7O1p98THsEbz/YlzU0RGxcsbZuqGgNk+tRE8BTCpSCUYjokt2BEMe1etIZ5xbc4d9isYDnA1M/63OIQd0tr+iO/aDeOTY2RBzplTrhI55Gs177jEGB4rUHexrB65rjfzPZBdCjqCYKBR81CIvd1lfzZljfh4f4ek9cMOillSMWK+kdhOo8D2KdmlkHgHRUQFxU9v8DPktMlO3Enxja41i8AIjA3D3V6NjMu7IWnfWJmiWZwlrKtY1ju2nYT5/R7tGiSgxEjZy04vu3abd0Epqh74yYr/NntSzmLhBO6ZyLd1Pr2aKzBxBhnExHjnXUtuwj0Sp6kKWGuMMTaUMm07SR8/fTkYCA/CdnHCKP/xlDiapJl1C6UslGT4bIv83VV/Je86yczjgAbu7RejmVMNUyPNMIk4U6BsRO+kId+8ok3cI6WW5hC4/dFbYLWnmbRfX3jDK8j4SGdTBj7YnZ1K10tUPDfBExpfFcQTPxuthMmvDotqBs0m4dXOaLb7SzHdDZauvHjZVWxs03l/KvqVUFMvijK8TzQcMLyq3jBUI0f/aObUIcEvWE0LPXW47/vDjAngw/2re0XrO+9dNSLC+1CnwpQb2BmPgFXyQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB999069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dnJNK0xTYmVYZzlkOHBFUE5KMDVTOG1OSE5xeTEvZnV0WENMeUxLZ0YzaEho?=
 =?utf-8?B?M0J2UWxUSkMya2ozdVp4dU0vNUc3dVdXbWhNcFU5Y0dXS0QwZnFWUDJUYXBa?=
 =?utf-8?B?THdWTkJObVVUZXZPZ050cUZNTllYK1dDQmNnS0UrajJsOGpDV3JPWkdNalk4?=
 =?utf-8?B?VjVDSEh1SFZPb1NhNkNaQ3JCK2FZc1FJdmFIWG12YlFhV21ZQVdsb3A0UUFO?=
 =?utf-8?B?OHhYKzZSeTBhbUllQ1Q0MG9jcnBFOCtheVZKZmpzQ0tPM0xpcWJkdElINXdk?=
 =?utf-8?B?RUt4TC8wRDlHa2ZxdWQ4Z2w4VXp6QTdOZ1BPanN5ZmRoUXRXem5DVUpvcGg2?=
 =?utf-8?B?N1ZZLzNmT0s4enNnWHBJZWVMU3NDclIwQlQ5ZExMbVhMRU5OSG80amhycTV3?=
 =?utf-8?B?MGNtVUJ3VitRSmFiOElkWXNIQzZrR3ovTEtMZm1JaThYcHJvcHRjRnhpQnIr?=
 =?utf-8?B?aXJTV013MEJCUnFlY2QzRDRNUlJTOGtxSHJ2cUl0dmtDak5ScEpnT0Y2TEVw?=
 =?utf-8?B?S3F4bi82OHNUZ3diZGExeXNmazZsY0hLbVl0VUw3aTN4NE9aazF2K2JyNVZP?=
 =?utf-8?B?TWJ4dGQ5cjJUSnhYOCtoU2VYeVZGeitsRmpQTUNLTHE3TjBaam85N25KK3No?=
 =?utf-8?B?Nm5qN2dqZ1ROc2gvZFNIV3FENHBUcE8rL3ZLbXFEOGRMOU5hOFpkN1E0VzY0?=
 =?utf-8?B?OW43UWg4WW00NmRnTGZzWWVuaGVWWlBoV21zK3Z5UDBweDFzb1JrbGFxcEF2?=
 =?utf-8?B?ejhFcWhyZElOMm90OWdJRzA1NUE4S1ovQkF6dFJMd0o4VjhMeFF3ZkdlNnVE?=
 =?utf-8?B?OVhtSlVXWlNMcVBXVG1VY3lRVTVTem4yWWhUVmQ1UHNXbTMraitzblZOTzBw?=
 =?utf-8?B?UzhDcHowRXNJOW80VjYwWWtrblNHNkdVVUV0Njg5c2ZjSTZsVktBcXAzVi9I?=
 =?utf-8?B?enRSRDlMVEpsZm5aVzQyUTlOWHFkMEZGOGU4RmxMQ3hOVlp1S2twSnh1SU8z?=
 =?utf-8?B?WDVKVW0vVG1acHY5ZHB2Y0M5aE54ZGxlVGhRaU5LTEtsc3pQVUNuNkU2Nmta?=
 =?utf-8?B?VXVCR3ZyMTFQbTBhRHgzdUpaUzFkaHorelMxT2ZmUSt4ZGMra3czYWQzVTFP?=
 =?utf-8?B?TnZQdjhHU1pkaUVTM3pNVThkYnhzZGtwY0NWVFV0Nng3NVNhcWZGN1hGRW1V?=
 =?utf-8?B?V3pTVldJWVVXSmF6WHJGY1h0Vjg5UjVKQmkxbTM1SzZLdUt1Y0h5b3FIR1VE?=
 =?utf-8?B?WmJGZUhGTU9icFBsYmNpRFlUWkJPTUVuMytCbi9nRlBPS2wyOXlVQWZXOW9i?=
 =?utf-8?B?QklaY3VYQkZHaGo0STlKWGNidGNPME5aN3JiYWhlNmFzOGczR3RCR2RjNFVC?=
 =?utf-8?B?Y0hNNGhVaGsrZ2lWZUdGbXAraStad1lzenBkd2VPSzc1aVZrTkY3L1IycDlO?=
 =?utf-8?B?bDd0RGdnRjZnUXN4ZG1sWEl0NGdnUmxTOXF5UEM1Z21aT01kZmsrZHUrNEpw?=
 =?utf-8?B?cUk3RXdya2Y0amh5bFpRc1pqcEFMVVNYS29ZVjJYL1ZXNURveXVYZnVMM3ZB?=
 =?utf-8?B?bENscVM4aTFCRW5abzBaVm9FT29RR1dYYkZwRkZ4YjE4OGdJUW5vUlpqY1JP?=
 =?utf-8?B?S2ZSd3pvU0dOenQyaW5DSnFFY3NHZVJpSXhFd3gyakpvNHVWTlV5NndGNGpZ?=
 =?utf-8?B?S0FCaUV5Wmk5S0VCenp3NzNkVDhvSGdISzFoZGh4R0dNL1pkNWNDbUIwOHVS?=
 =?utf-8?B?N0Y5OUR2VzFRY1FnZnZLNENlQVUzblIvRGkzKzZjcDdTT2Z4WWk1WHAweGVr?=
 =?utf-8?B?dHE1Y2hNYkhMMkFic0VxT2s0ZlZOTWVERmFCQ3hBQVZ5a3E3Mjd6T0VsY0NF?=
 =?utf-8?B?Rkx6cWxyNVFKTFJtRzZOcVZXRmtRNEt3cGh6Y1FUTkNITDVUZTg0Rk0wNk5Z?=
 =?utf-8?B?M3hGeFEyVmJ1RGI2YzU2Z3daTmRWY1pPZFpwbi9neVNQZ2hQNWE4WUM5cDJw?=
 =?utf-8?B?OGRGbGgxeU1nUEdubUhLV3JFbytsN1hUYUl3MUoyc1RJTmkrM25PMnpMb1Np?=
 =?utf-8?B?YVJjODJoVzh4dEN5S0wvb3ZyYlFzVlBoR3ViMXNZSzMzYlpUVm5uNE0vV3N6?=
 =?utf-8?B?Y0laMHpIWDVVbC9vclRROGpjZktGeUtQaDFjZGpHeTllR1gxajM5c1ZDUnZS?=
 =?utf-8?B?WGZTSlN6RHhySkh4eENsd21LY0pyV0RxSEo1YmtMS1dmaHp4Q2dGTXVWcWZn?=
 =?utf-8?B?ZnJpazRpcEdFMG9YblVWTGljd1FCWTRRZFNrNVpXcE9WemJybmY4UEVZUEcr?=
 =?utf-8?Q?3M4h9wECam5Egl1Llq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c6a5259-cd37-4a64-68f2-08df02ab41da
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB999069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 13:17:48.0843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBMM+Md5m9m6XceSOcas65+hiETf3u/LP7Xvw/XGN7iw2rfiwfcQwrRdBIBBzKfyUoEJEfn6oK64+fQEMDMYOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8803



On 8/25/2026 12:14 PM, Guo, Wangyang wrote:
> +	for_each_possible_cpu(cpu) {
> +		if (!zalloc_cpumask_var(&snapshot[cpu], GFP_KERNEL)) {
> +			while (cpu--)
> for_each_possible_cpu(cpu) may have holes, but "while (cpu--)" assume the enumeration is dense.
> Although freeing NULL is not a bug, it worths a comment or check for such subtle thing.
> +				free_cpumask_var(snapshot[cpu]);
> +			kfree(snapshot);
> +			goto out;
> +		}
> +	}

Thanks for the review. Sure, I will address this in the next revision.
