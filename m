Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793360319;
	b=lcNuNDJkWxzqC9EfUEK0ANB6zGdYaDQ9vHjgyKAdLu6swoBHAZzLWjDAhLrkbXJDZop3
	 UEtLolT7KaEVDY+ZEWOoAc8MRxa4Rqp49D3sweijiZmOpXlyVSI4Jsrt2xiAXCpbejKSn
	 8K9RPt0JacKBKpjAvmaL5ZjSTvRoZF97Kjfm/HClv2TjwUiIEEfkUVIh4l9nWTKJoSNK8
	 xu15uHzlqzGoLDI8YjRuUGvM8Qyh3o5UOk95tl1n8fGG5dJcWMqPqZ6HiIZBTFheCI80J
	 l3Z/z3sN2aXo6ULsRn27F5ijgxM5lucUaOaaImj9S5lHaQzpp4yxaPcShaNB694eYnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360319;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
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
	bh=exYFVFEZ6zKdNjZP7MjVxfDqIyZ2mjrtbLkB0Zh0fQA=;
	b=j86J+FlOi5FmvbqeE1fXraZkV293xX7icpKsZyYFa5UFi6Gh6pjz7hXG0Tt9BzduY6nf
	 YYvVOtmu2IU8e/5i7zLpDf/VMekosbDh8J9AA0nqCc9rUtshWNasgTKEMouBLsNSEf/7/
	 F6HEhIBjJbskzU+VeSQQ1FomMO1RF/jTc11EY0B9267074DcfsfixTVUDOAGEbI4aT7xA
	 HJafEoK/5pfGbmGXUc2p/HWCsO1uhbztBX187rPszwtJnlpL9XPiIpnfDU4JkWCFM+2ga
	 tEey3dOoWJGFY46BA2fe2q1I1uwNl9mUBuj2KSGEm8w/r9l9SIjXTWWdgZ/5U1bWxSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eoPLGY5U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.29
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F2F606A321;
	Fri, 30 Oct 2026 11:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9F2F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eoPLGY5U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGRowEQy/l4LiVvU1EF7rX1D1h5lUebwRA6PQQXOGIbMXGNWxo8FkZJzgTOrZfsFoXdF3o2+aQOQrqIXb0UROPjVY2MQ+qdxYp83IarhaG9lvJwrQka5NVFL+lSJi/hViAesmw9+Axod89qIRSaq3UqWhCkY2nPlNy/5CQioxXGS4/caf0BsYGi0quVaW3rwzHjSm4XjiAZqycDsVHA3cuQIrDOYaBSC6IHNdATS1RfUDl3cUmbeJKxPY1WKZ/AYxJk5mR7yqWe+uAMDCbkikybAaZ4u1Eu72VV4rVK87uZSVEfBHcue5c9+FD0sXcsZTOh0D0q7tz9IO5t6+1cfYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exYFVFEZ6zKdNjZP7MjVxfDqIyZ2mjrtbLkB0Zh0fQA=;
 b=FRj1FaP00FfzB0JE876Alb7B5H0ui8pZrS8/c5LtFq1xgbFsn9vfuNowB3fBbLVAc3uc2nhy+zSZXb4e0z2WF81nqOMXE/eM55OLNxpOq5yk6pfzSb02WZFewJXSXUrLMgtQBtZvUxlRBaCXXGXcS/dHkGlhNZ6wY3DL4jWl9XldCc/+go7Lxl894L3rBe7QF/M5rL7+6RjJKsAtmKAgpbXVZ2oBYJqHo3xYQX+e07xlqWErSjbSYht/keSLDaYwzpG5AuHLThw/fI7EVB7ghhmYsq0nENYTwGc7pD9nqTHMcEG4hz17pznJJK9CSh0nqtZmCrAQmxVw5RAdoeiRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=exYFVFEZ6zKdNjZP7MjVxfDqIyZ2mjrtbLkB0Zh0fQA=;
 b=eoPLGY5USAkxnhol8aw9zt+8b0B1wQZNHfYL+vZrkECfurHa2J/hsTtKBGGP43PPNeJMPikf3ewNNtBhE6uVqeoqbmb4qToNzU9Dd9MljC8isJkBgpXhNzfeFQAPF171bsqnbVMt6ArNK1rlSGviKtfFAZiglWzc/42Ejv3xRu8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 11:38:36 +0000
Received: from CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2]) by CY5PR12MB6252.namprd12.prod.outlook.com
 ([fe80::ab00:d77:6014:64a2%4]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 11:38:36 +0000
Message-ID: <a81780c5-5692-4cbd-9f7d-1f64e78e9017@amd.com>
Date: Fri, 30 Oct 2026 17:07:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/21] soundwire: amd: Check ping command response for
 timeout
To: Lee Jones <lee@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
 linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mario Limonciello <Mario.Limonciello@amd.com>,
 "Dommati, Sunil-kumar" <Sunil-kumar.Dommati@amd.com>,
 "Prasad, Prasad" <venkataprasad.potturu@amd.com>,
 Syed Saba Kareem <syed.sabakareem@amd.com>, "N, Poojitha"
 <Poojitha.N@amd.com>
Cc: stable@vger.kernel.org
References: <20261030104840.3361217-1-lee@kernel.org>
 <20261030104840.3361217-14-lee@kernel.org>
Content-Language: en-US
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
In-Reply-To: <20261030104840.3361217-14-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PNYP287CA0072.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:25a::10) To CY5PR12MB6252.namprd12.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: CY5PR12MB6252:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f856fbc-e26d-4552-dc3f-08df367a5575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|921020|4143699003|11063799006|56012099006|261009223027099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|261028144727099003|261021135927099003|261021133027099003|261021130227099003|261021123027099003|261021121427099003|261022113327099003|261022105027099003|261022075727099003|261022115727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	p1c1a5YvGQHuBK1awXUDMHDsZ2tka8lx2x1g3+cUEPerkyD717hsJnRsArlQu42Sf1HcMSFiAM8ob2brBlMA+D8My70U76s9cDr4s1A/37uu9FJ5LDyvKWaqSEPdmUDFRV/N+zY74QdhTMJ0uHEiDdnuhIsb/EwNtEfDEkXoP9iueEYkHsLQtW3WkNNTlrAERV9/VfsJY+B5PDoac3I/gIrlmAM94B4TUrkaF1m3B3ZxxLvQSdaTrd1ifrWrFm3uDnmZGROm4TW605YZg2E1jJe81nCjnsoWgiZyxj8VNKTprYSdkI5yDtFuCKyMFBSsLqLosiN6IsH2SdFqFhuyN0axiawx+ABsZkh6iH+R6Uy7SJPG5scWqEdPB9VWSCQtPMASZSdNZb1vFTjdzWHXshG70PcoF2wLxbs35Acuqt6vGsuBRi9xblejTkHGVxgXnfSV3QfnLpetWuSybhxbkSVJTzN1jNqvaEQs/S94RxLdCgMcR2a+OhpxV/Bp7BV4FUSU3FR6kujqpbQG6rNwLyrZyqBUXGCqdAKfvMpDqNipG9jnezmUA5Ds8yGYCdSS9ha0q6eym1H/NagbJu/O0TZ5eSNrydhqsRRFpSmeVAajO6twfrpH2w0SknawK3gyeXedsUuXawPZV3/F71KSGg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(921020)(4143699003)(11063799006)(56012099006)(261009223027099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(261028144727099003)(261021135927099003)(261021133027099003)(261021130227099003)(261021123027099003)(261021121427099003)(261022113327099003)(261022105027099003)(261022075727099003)(261022115727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2ZXZk1IZVZMalREU3JQN3J1SjB4bklRd09GWjZNSWhER0ltbThmQmhic3FF?=
 =?utf-8?B?MEpWSmFVQnZkb2lLZzhZUVZ4L3hnL0NnUnlsdE5ZOWY5enowSHhlb3BxbU9F?=
 =?utf-8?B?TE9WRzc1RWNWQjk0UWYzWHErSSt6T0RzeUJ6clFpMzc1WEhIUGNxd2J6T21J?=
 =?utf-8?B?M0d2c3Vodld6Z3JvT2xHTnZldGlmMzZwN28zcHBESXZwWlRGQkNMWjFDd29u?=
 =?utf-8?B?SW52SHhrKyt3ZCtrZ0tVZm5BV1Q0c3lxZldtS2JvbkZSWXhVUWhjNXNrZE9l?=
 =?utf-8?B?bktrVEpFYStQUmVIcVV5bVVqdytkZDFlSmcxbHVVNXBXUWtpdk42M1dFcW13?=
 =?utf-8?B?a0s1Q25KUGxjdHRuNDJXc0h5Z05kZ25Ed296UWVmWml6R3BVZjhGWGcwOGRv?=
 =?utf-8?B?emkvUjBlOHQ2QTdiSEVBaG9scUVnRkFPVU84bFlOVTNEdDRzMGh5OFVZcUp2?=
 =?utf-8?B?QjlvdEpKTVZUUmk2UE1mUytjM1poa3RVSXVxT3cwbUIvSEpJWjBGc05neVQ3?=
 =?utf-8?B?RTNRNTRtN3dTNUtDWXRLalRRZE43TVNCVi9DbGViR09BZXk4NlFxbkhEeFVX?=
 =?utf-8?B?TGE3SlFKUjJpbGRkQkY1WDNBdXlORzEreXdRYzRoc0JFZGJ3VzVYTFRxOEN3?=
 =?utf-8?B?V0thZ2c3MEdOd2hpRHVOZ1VpZ3U5L3l6allObTdYK25vaUlnK2VhYTFMUEl1?=
 =?utf-8?B?N21FQ1pUSitlSncwamNTVnBpT0RPMEFjbFNoVDBLb2FuQWl1WEpOb1A3alFX?=
 =?utf-8?B?L1NITUFTZUIrNUFGejM3ZlRRN0Q5ZDdqR2k5THpsR3lqUDJwMFkxZlltdk9O?=
 =?utf-8?B?dXEzQ3Q5bUp0WUVHQW1JV21uSzIzNzlTMW13UGxrOVpFbzRTMkdHcmRhTVhF?=
 =?utf-8?B?VWVVM0RlRHNmSVFlSDhBbEJiaXJBNTdiWjB6UUFjcDk4eTNvbEVsMnlMRHlL?=
 =?utf-8?B?MUhrdXhsVGIxKy9raWN4T0VHMWR5WTkwL05uTGIzaDVzdit3VWM4cytQZnMw?=
 =?utf-8?B?c0RoRUN3NWl1bUc4MFVCR2s2WU5qL2JLK1JwVjhxZ2psZ2NhRUZ2Vlk4WUs4?=
 =?utf-8?B?Q25mQzF5SDg2M0xIajQ2OGc3dTB2UWJZWmh1TWJLdXNmYzltNnlETkhsRVNa?=
 =?utf-8?B?a1dnTUZxNElXV1ROR1gxa0FxSitsWExUdXlTSVJhaHdXSnhaQ1ltNi9Ta3dl?=
 =?utf-8?B?cyt1QmhMeFcrUmNMZm03ZFZ5VFN0UTMvUk96OXg3UWMvODE0VWxNYWFGcHBV?=
 =?utf-8?B?QlIzbHZjenQ4bGxkdjhGMU44ZGo1NVl4QnZmSmFaL1hEYUVDSVF6dnRDcVZ1?=
 =?utf-8?B?TGY2a3ppdWxaZGVjQ3kwbHN6TkdvRXk3SFJFSzVmcWsxWlZCNnU2WjA3bytn?=
 =?utf-8?B?ZUJZTUJCYnppSjFuKzlrVXZoa1ZSYUFGaTliUjBGVW9OdS9TRzBBR1Z1K2Ev?=
 =?utf-8?B?NzQ4Rzhhc3NpbVMyRi9tUjZkNmlMSmthQkhmN0xXQ2c2LytDMndtdGROMFYw?=
 =?utf-8?B?MVBNczhCYmU5bzcyaHV3ZDlGQ0dQSDlNN1FmT0d6ZTN5aWNNdFhsRWd4YXFL?=
 =?utf-8?B?a0tKRVZ2NlpySFhOdWhnV0pkdUFJQVdrNnZ2eFJBVm9vVEw3bWdkZ3Q2VHp4?=
 =?utf-8?B?eFI5U3NvcVdjN29pK0pDY3hsbUlsTUtuaGNDbTRwNTJZSWxGcGw1SFkrTXdm?=
 =?utf-8?B?eEsrL2o3M2lsbHNXNFA3SXVwaVRrejFrYjM2U2FocXAxc2svdlZzREFvOWd3?=
 =?utf-8?B?cm1ZY2ZDU04yNVBHNmhXSVZFMnlJdEYyM1pEZFh2Q3Y5VDdSS1FxSnFxWG1G?=
 =?utf-8?B?NGFtalVUZThtbFFYWkxoMHJ0alRtcW5Yd3VYdW5vdEI2LytMSnRwL3VJbXl3?=
 =?utf-8?B?U1BPOHZGblVUeXdYZ3FIaHIrSS9qdHBHb3BOQUttUnU5bmNKb043Rm5XaS9j?=
 =?utf-8?B?YzVRSkplQkprZ0JwLzAzSHhOY04rNGN1N1NOQnNuZGY1L1d4S0Q1Q0tYWitN?=
 =?utf-8?B?aTcwbll2UG1DVFJQbGFnMU9JbDdaUXpvRlYrSFBZNE83cDIwbm9xRFdhSFkr?=
 =?utf-8?B?dWppQTJ4TWdHMmxnYXRvdUZHTFNDNzFoUGRSVHNKQXRkWEROeVkwblVhcGxE?=
 =?utf-8?B?OVozcHNqL0VPelYwWUVlb0l3UGhSbExtUFlUMi9hcG1EbDVJZnhHYU1tS3Np?=
 =?utf-8?B?TExlZ0JCRUpiWlE3L1JJeVd3bHlab3lteEl1a1pTNmhmd0lUcTN2bklKUFAx?=
 =?utf-8?B?a2Z1OEorenhEeWxOTVdlcDNjaGhMZCt0TlVMRzQyMDh6NS9QMzJXYnFWdDJE?=
 =?utf-8?B?ZitXbXF3N1JRNUZGVEhDUEVNVXNvQ3pZUXl0dFdmV0RzWVlMMWxIUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f856fbc-e26d-4552-dc3f-08df367a5575
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 11:38:36.1004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aH8RoUhQ3KV+6Qvobvot39od5fhK/cH/TLKNyOx0hydk5OIsSGlujSVSy7PRYN2NzYsgbjucSxoC/DppsPj6AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455



On 10/30/26 16:16, Lee Jones wrote:
> [You don't often get email from lee@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> When amd_sdw_send_cmd_get_resp() times out, it returns -ETIMEDOUT as a
> sign-extended 64-bit value.  amd_sdw_read_and_process_ping_status() and
> amd_sdw_read_ping_status() extract peripheral status bits directly from
> the returned value without checking for -ETIMEDOUT, interpreting the
> error code bits as peripheral status values.
>
> Check for -ETIMEDOUT before extracting peripheral status from the ping
> response, matching amd_program_scp_addr() and amd_sdw_fill_msg_resp().
>
> Fixes: d8f48fbdfd9a ("soundwire: amd: Add support for AMD Manager driver")
> Closes: https://sashiko.dev/#/bug/linux-c3a53ed5-eb8f-4982-a3b6-db189e009b68
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/soundwire/amd_manager.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/soundwire/amd_manager.c b/drivers/soundwire/amd_manager.c
> index a3316efdf8ac..a8220235a2ae 100644
> --- a/drivers/soundwire/amd_manager.c
> +++ b/drivers/soundwire/amd_manager.c
> @@ -448,6 +448,8 @@ static void amd_sdw_read_and_process_ping_status(struct amd_sdw_manager *amd_man
>          mutex_lock(&amd_manager->bus.msg_lock);
>          response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
>          mutex_unlock(&amd_manager->bus.msg_lock);
> +       if (response == -ETIMEDOUT)
> +               return;
++

Response should be u64.
This patch can be dropped.
Please refer below fix.
https://lore.kernel.org/alsa-devel/20261013085111.2009061-6-Vijendar.Mukunda@amd.com/T/#m786cce22308c97d055566dce17be5a38b5d98e9e
I am going to post V4 patch set.


>          amd_sdw_process_ping_status(response, amd_manager);
>   }
>
> @@ -458,6 +460,8 @@ static u32 amd_sdw_read_ping_status(struct sdw_bus *bus)
>          u32 slave_stat;
>
>          response = amd_sdw_send_cmd_get_resp(amd_manager, 0, 0);
> +       if (response == -ETIMEDOUT)
> +               return 0;
>          /* slave status from ping response */
>          slave_stat = FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_0_3, response);
>          slave_stat |= FIELD_GET(AMD_SDW_MCP_SLAVE_STAT_4_11, response) << 8;
> --
> 2.56.0.317.g454f8302e1-goog

