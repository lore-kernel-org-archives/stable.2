Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794046878;
	b=kwPQNcN8+06qDWgGyrbqzAvtfeevVSeq515KvIUmkGSTDW89U8spIAK75Uf9uUAgKnBC
	 5OMspAfzlPshk+kqp7aQESwU0hNl96KwoXwSDH1rto9ov/wo8sBUBpXpFlUhIk4Px+C5y
	 ppZwDxiPhPL6xFaThklyD8RR9TYp92U0IKC29XvflCQZYst/cJyA7sedkgnHyApjKsRGZ
	 fuKRyQTiAZDv1tsmlmMTfOBgUZ1ExCOlQZYlDzbv0ALeKxf9vTmzr+JQCa6lFmX+84wto
	 ZxC+GRWJmoiEewQDzVHZEph0FGZmNxBgFy86Z1xj8j6j3wAUYt3g/okO5adDOIMTYQQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046878;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=M2ES+UgQdoJHpBcPgUiCIw7Joyo4PN9p8CBKji7K0/Y=;
	b=yNuUN+6dWDOJtTuVEfPYq2lz273UyTYhlGhgtwytPs4rTTlS00uzie5JxA2bIu/hvXT1
	 WjTV7QLUBvTCOMZDLOVR87XdT3Aq5iRNFWrNWkeT55FyOnkjf4IHWvIcmrqf+L4MSXXrm
	 kyMpFvLq/NPo6rxj1SGCMfDhXOayE1hF2cs29H+lU1xfcwaZ+I7BKQh4e+sssZCqBTSu1
	 WbAPGzHoo3rx2v/sFuVCQDVbuN3OGq9uV2Nnv0jkpUzVOeCVWdApEhwnZ0efhHKhGT7De
	 kFFkwqnkdYPRWbubXcVsoO0w7qdER6KBtzVkOqV+33InYeM4TH5JDg5kLdNWRPnrXOQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3pevYKMV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.51
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010051.outbound.protection.outlook.com [52.101.56.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C77C606D824;
	Sat,  7 Nov 2026 10:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C77C606D824
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3pevYKMV
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EM3pyiw0SglGLCVNucfOZg0NMQBQ+KlBbLZt4pE7CYg387V4Ln4w9YZg1jWEHrwbYM6XKxiVQ7W9eDjMiALQVH0zR5sty8LI8+jT2pFx6TeGrH9SJJe4L4wpIhex5qpiUpDHnDw4ig8VSkIpQuw7IizDYxgM7H6651pqOSn+70zxMNLUUldFkngZvYRHLoncjFC4BM/3XYB+5u/TqEOaBC9tYQVSw3Yis9T5cauVrsoHxluwWztSmd8xpvpvgxFmanCXZUwkqtIFAxBZsWT+QBy/C4y2uQraShtdpWJ8JrujAmXgbhB33DpGmzMh6HprzhYm2j2lviY7CWiegHAhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M2ES+UgQdoJHpBcPgUiCIw7Joyo4PN9p8CBKji7K0/Y=;
 b=s8HL9ZCNkflIpdqkDP0JMHg/HTx1g9sxwKGIi8pr1bp17IIjc559pZvvVx49Qf0sxjNHSkNDc2RfBLi9l6S3BrweTqnuI5EEGNDliFefLGmm5gMI2qhbI3BYWHYEgHlXyQrLon5ysJucTyVvkmH0i2Z7B5FpD+KDng6MkJK0aZo3Wy9fV2KYQ6u6OTsRXwrFs7pKK1D/vyotMs2OtEWuYHtAPmFaoFArGhWlSeMWAr6RBBuinMDXxTNvca+5++1AqkvGe8CLwvkptp3WDeW8oxeELZT/3gTvqdLlmWgdTaAl0AT3w6J/CUgRM7rlt6+JONKBOtQMtcGkZpMt6jXf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M2ES+UgQdoJHpBcPgUiCIw7Joyo4PN9p8CBKji7K0/Y=;
 b=3pevYKMVNBqTyW04Kgd9sNv6fw9zRLbqO4QoAe+uVqXrpdzP8+hC3RmY8l76+fj2hLvJinE9HQlADmV5vWgB/OsdwTuFcGU9DOdffYMo1G2aIGvOyfDFdcouL28MTucGpJuAMCnEHswFHD7ruVvAvXomUthpCfxT9tv5M7p+Qn0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 10:21:15 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0592.009; Sat, 7 Nov 2026
 10:21:15 +0000
Message-ID: <eff393df-9016-40e3-bab8-432296c0165b@amd.com>
Date: Sat, 7 Nov 2026 15:50:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/21] soundwire: amd: Check clock resume timeout in
 amd_resume_runtime()
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 Mastan Katragadda <Mastan.Katragadda@amd.com>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello <Mario.Limonciello@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 "N, Poojitha" <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-21-lee@kernel.org>
 <55ccb8c9-9d11-4c22-b17d-a31746ea4031@amd.com>
 <fa7230de-7c4f-4c27-93e5-d4145f10dc53@amd.com>
Content-Language: en-US
In-Reply-To: <fa7230de-7c4f-4c27-93e5-d4145f10dc53@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0102.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2ac::7) To CY5PR12MB6252.namprd12.prod.outlook.com
 (2603:10b6:930:20::17)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b982ae-1c64-4d79-7f83-08df3cb8da66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|18002099003|22082099003|6133799003|10067099003|921020|56012099006|4143699003|11063799006|261026121527099003|261102123227099003|261028144727099003|261026140227099003|261021123027099003|261021121427099003|261022105027099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	5KiZyUNL4FqmBxD1wiV9L5u3Mf/lGsSJd4OFbPIG67wVd+eU5/P87npW+vsvSjHXgWSj5r0WqIRI4jbCgUrTWoUCtMr2uLSHrWQYgW2nF2JK6aSY8+ya+KAeeXzHyMozk+uVzSJYTcMead1mO2wLJCXWIlTWl7q9UdSvXUbyGoBHlBL0xoPaH3hojcUKe3k6K4x2KlSWtJET8FhQzYFKwyhC86foDdCNhu5Tu5Hamh0bOMyR1msteuxj6z3w7JZ6sKxLD9e7Ly8wIq3OzNBxKqOi6MPq+ek7zSObp1ank6UaUrmnZoGOOymu3lghcXr3JfaZStcWGzVUCjPiECiji57SfbAQ8/0Z5WKZUdZVa8XQBisjUaCMHZgzZUIvb2nUcAgFFiqbJW/6Doh/dlzpxMppRhr+7MFSBS/b9GbQj1aSCeyLK++PStcIl02x7YVzroJoaCTY/ny0bh6rz1dnrmcOBGWFxYDEtQQBj/AMpjnWpe6Ob4nM0NtJ0JYSfh2i7Kxw8cCsaYzZS20in4Zc9GCZrQWuqBEIPHT84RalugDSsK7OY78NZ0QldNlbZa+pvpmpeFx6EffuJpABWAB4tpmZElBjNoJxxDDZriE9fXszwC6fnIUgUGQ5mMmV/daIrEUXATCaNbArPAFqDiWneg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(921020)(56012099006)(4143699003)(11063799006)(261026121527099003)(261102123227099003)(261028144727099003)(261026140227099003)(261021123027099003)(261021121427099003)(261022105027099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTFjcDN1NEplWVZzOURFc0x4WG5Sd2JuOUVrVkJQckdvYlFaS1FuenNMdGV0?=
 =?utf-8?B?dmxXMEMxQW5CNWxOSVdZWURWdkJZNXdGY1ZmQkZQU003M1RlRGM0ZDB4dFda?=
 =?utf-8?B?SnQxOGFPU25hdTUzclVkOWJiVEZqeUszaW1zQ05xWHdTRWpwblpSL0J0VVJO?=
 =?utf-8?B?bWZGRGxYbHhHQ1hHSDdwZHBJdzU2cGFOUXN5dUhpUVl0UDZ1Q3hHUkovSUVT?=
 =?utf-8?B?UjM1QjhZaXhBRVZ5eVhFMzZoZ2hLaXJEOEtQZDlSUnZBbFZHZUV3ZTJ1WE5B?=
 =?utf-8?B?ZW9XOG1MNms1SVg2S2JXSzhHZTcxZGFhYXIvekJnUTJGL01uNnJhSnRuUjlE?=
 =?utf-8?B?a3hab3VzSWVvNzF4VVY3T2JyWTZFZ1E0bUNHQTgzelBWU1VhQ3U1REJ6OEVo?=
 =?utf-8?B?ekZsbkRJTTBVQkQ4di9UcTdLVkpQdDMxb0pzbFRITnhCeEl2L0kvVEVwcXVH?=
 =?utf-8?B?NllYT0U5QURDRzMvbTBkaW16SGdVRldyUDd4Q2pibHN2ZjBuTytXMEtZdVQ0?=
 =?utf-8?B?VHNnUmVUZ2I5TE9WRUM0ak8rTHVTekxxZW5jZEptNXQ0Q2xzYXl6cXF5Mlg3?=
 =?utf-8?B?YmhKYVlZNVFUL2poSVVRWEs2SGluejNTV0t0VU1tWGwxM0s4MEF2UW5HR3F2?=
 =?utf-8?B?cGFyRGQ0eXpnVFpHOU5jbDZSNkdNVXZoaGRUbzh0WmZETUQ5eDhQa2JXaWJk?=
 =?utf-8?B?bUhsQWp0c3FQWlVETzgyVEVqSURXUkdUcS9XeDh3ZTZYNFZWZ3o1bWVLcEN1?=
 =?utf-8?B?VE5KVGZ2WlBZTzQ2b0owUlJhUXEzckYwT1JBRk4yaStqTU5jMWk5TmxETEZk?=
 =?utf-8?B?eFRmNjRiaHo1cHM5VzdsNGhaRHpvWFJiSXdCUlVlcnk5Z3BsRkgxbkRqZVJa?=
 =?utf-8?B?eEpwQkFsUjhEMGVCdndCNEsxK2VEQzBDelUrejZpYmRwVjROckJKc1cwTE1z?=
 =?utf-8?B?c2d3RDhua1dRK2s2MXlqRHNjeEZsWWg0b29GVlNxNXZJRFdUb0EvcURKVVpq?=
 =?utf-8?B?UndOeXJadFNtNkI0Z0Z0UVVPeXhPc2xKckFmb29mNGF1VExrbTRxNnFiY20r?=
 =?utf-8?B?SUx0R2xzUzBLOC8rdjcrREpBZk45Nk03OEw0REdFbWcvQ09HaG1Vc1VZMUJP?=
 =?utf-8?B?MFVFTzdjK1pUZlJXUzR0eldRTVJYRXpMSE05dVBQNDV1dzBXblNwazRyK0pU?=
 =?utf-8?B?TkZVcU4vWXRhc1pGTkVBSFFENzNIeUZWZHJ4UnFwNVkxUlhBNE9CemxwYnJv?=
 =?utf-8?B?ZGJVeEY0d3Y2eFkyZU41T3Zpa0ROWElkazBldytxM2ozN0dhaDlpbGJuZkIv?=
 =?utf-8?B?ZFNxQTNyQnF3azFpWjBWRHdETmM0OVg5ZWdIczNFVzFRd051bXdUQzRKNExi?=
 =?utf-8?B?T0lGNmM5RVFRZ1BHUjZmYmVSTTE3c1dyaDZHalhlZ05KNWd6dml2Wm5VbnBz?=
 =?utf-8?B?MU40dERYYXRNWlFGc3h3VkIrbEFETmwxRzBwZFhiT3JhUkdKTEVZZzBSK2Zl?=
 =?utf-8?B?T0pOajhuQWsyNkRPVmJ3citySk5rOStQd2FyR0hVakR3ZGhHOWpWZHJkNGJ4?=
 =?utf-8?B?UEpGdmZ2Qm9GeG1xNThqcEUzakM3dy9tVnZBUDFCTWtWdGlUNG5iNlRhYk5E?=
 =?utf-8?B?b1RWT0p3bGJIN09IMThWQ2E0OXVqbnFrYjQwWGhMaVFHQzlkMzZOZUxLNEN2?=
 =?utf-8?B?VmRsOVRqUkRNYUxvcFlRbUNVTGlSb0J1cmhtZU9LeGhSWFRnZUR2WHRiOTFa?=
 =?utf-8?B?aWs2ZWRSNC9uMGtyV2JCaE9iOVViaDhxR09TSGlOMDdPOVpQcDh0SnQway81?=
 =?utf-8?B?M3UzclFmWThHd3RjU3FMUGVSNGhGbi85eU1RK2E2SHVVRG5WcTk1WWhnZm1R?=
 =?utf-8?B?S0M5ZXlGVUZHWDBMWnJJT1NXOFdPU09hOUN5RkgwaEplK21hbkdRV3NuRkpG?=
 =?utf-8?B?akVhZWpnVFA0NFRRMm5nZGN4c3cvcDdVNDhVbUM3b3lCRWgzVVNEK3hIMHBw?=
 =?utf-8?B?Q2x2dTJiRWxkaVlFbktsYzJ3RVdLY0pPN2cyMlJQS3UvNWVUeCtUZEcveHdB?=
 =?utf-8?B?L3NJNDhLbERZTVVudUp4bVRoMGtVRll1UTVvRnBYWGZ5cHRuR3lQcU16VzZO?=
 =?utf-8?B?Sko5ditMcWpaQ0xnOFZkZkRGUENYWXpwNmc1empraFpDakxFOUNkYk84Rmty?=
 =?utf-8?B?NWwrcVYweE1SWXJyNHVBY3NWOFVpaldLRTdWaS9yZlhTWDIzRFRZWDkxUElC?=
 =?utf-8?B?dGE5enQ1TnBuSEZpN0lVN3F2M1RsTlF3anBkSEpueFJWMXVuV1RGNm9BMFk5?=
 =?utf-8?B?TnQyem0yTmpmVW5RTzdROHI2UVdiTFFrMGJqekhyakh6Vkh2dUcyUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b982ae-1c64-4d79-7f83-08df3cb8da66
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 10:21:14.9423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMnV9NcD/O9HpprYZI4QBnDyFnYbyfAzykzuVL7Zae45avu5r+BoX9gQhiEAkmcBEWC47p1xf9G0s+SxNXWcrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444



On 10/30/26 18:25, Mukunda,Vijendar wrote:
>
>
> On 10/30/26 18:21, Mukunda,Vijendar wrote:
>>
>>
>> On 10/30/26 16:16, Lee Jones wrote:
>>> When resuming from AMD_SDW_POWER_OFF_MODE in amd_resume_runtime(), the
>>> return value of readl_poll_timeout() when polling for
>>> AMD_SDW_CLK_RESUME_DONE is stored in ret but never checked, allowing
>>> resume to proceed even when clock resume times out.
>>>
>>> Return ret if polling for AMD_SDW_CLK_RESUME_DONE fails.
Correction to my earlier reply.
After further review, the existing timeout handling is intentional.
Please disregard my earlier statement that the timeout should be
propagated.

A similar CLK_RESUME_DONE timeout issue was discussed earlier:
https://lore.kernel.org/all/fbaae15c-f3f7-4125-96aa-41b6bb4f174b@amd.com/#t

As discussed there, propagating -ETIMEDOUT would abort the PM resume
path rather than allowing the remaining recovery sequence to proceed.
That discussion also noted the same timeout-handling pattern in the
POWER_OFF_MODE path.
For POWER_OFF_MODE, returning an error at this point would skip the
subsequent slave-state reset and SoundWire manager re-initialization,
preventing the bus recovery and codec re-enumeration.
The preferred long-term approach is to recover the bus on such failures
rather than propagate the error to the PM framework. This remains a
TODO.
Therefore, we intend to retain the existing timeout behavior and will
not change it in the upcoming respin.
Please drop this patch. Sorry for the confusion caused by my earlier
reply.
>>>
>>> Fixes: 81ff58ff71ad ("soundwire: amd: add runtime pm ops for AMD 
>>> SoundWire manager driver")
>>> Closes: 
>>> https://sashiko.dev/#/bug/linux-c6360b30-11b9-40a1-ab04-528462af313c
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Lee Jones <lee@kernel.org>
>>> ---
>>>   drivers/soundwire/amd_manager.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/soundwire/amd_manager.c 
>>> b/drivers/soundwire/amd_manager.c
>>> index ba8e6d42c467..faff3e9eefad 100644
>>> --- a/drivers/soundwire/amd_manager.c
>>> +++ b/drivers/soundwire/amd_manager.c
>>> @@ -1494,10 +1494,10 @@ static int __maybe_unused 
>>> amd_resume_runtime(struct device *dev)
>>>               ret = readl_poll_timeout(amd_manager->mmio + 
>>> ACP_SW_CLK_RESUME_CTRL, val,
>>>                            (val & AMD_SDW_CLK_RESUME_DONE), 
>>> ACP_DELAY_US,
>>>                            AMD_SDW_TIMEOUT);
>>> -            if (val & AMD_SDW_CLK_RESUME_DONE) {
>>> -                writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>>> -                amd_manager->clk_stopped = false;
>>> -            }
>>> +            if (ret)
>>> +                return ret;
>>> +            writel(0, amd_manager->mmio + ACP_SW_CLK_RESUME_CTRL);
>>> +            amd_manager->clk_stopped = false;
>> ++
>>
>> The bug is valid. On clock resume timeout the code falls through to
>> sdw_clear_slave_status() and full bus re-init without the clock
>> being active, which is incorrect.
>>
>> However, we have identified additional issues in this code path that
>> need to be addressed together:
>>
>> 1. writel(0, ACP_SW_CLK_RESUME_CTRL) is incorrect — this register
>>    is not a plain zero-clear register. Only the Clk_Resume_Req bit
>>    should be cleared using a read-modify-write on the success path.
> Slight correction.  Ignore comment 1.
>
>>
>> 2. The same unchecked ret pattern exists in
>>    amd_acp63_sdw_clock_stop_exit() and needs to be fixed together.
>>
>> We are planning to address all of these as part of our upcoming v4
>> patch series which will be posted shortly. Could you please hold
>> this patch until v4 is on-list to avoid conflicts?
>>>           }
>>>           sdw_clear_slave_status(bus, 
>>> SDW_UNATTACH_REQUEST_MASTER_RESET);
>>>           ret = amd_sdw_clk_init_ctrl(amd_manager);
>>
>

