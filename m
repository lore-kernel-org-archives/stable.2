Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010025.outbound.protection.outlook.com [52.101.85.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49272459AD5;
	Wed, 30 Sep 2026 07:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790751812; cv=fail; b=VsBkVDF/m/qWDFoKXkviOwi1+LxVZuJkCl4yo3Gp7JuFU6i8Yr132H6d7gOQGJOofuFpi2zaHXF1oGY+dq3k/7D9m6JuwzPt0BJY4K4PAStRWM1ozdRlRRNFzuwj/Bg5344Z5VXFqGTzOXtJDBmLKRMOnFc9r850aEYl2afs3bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790751812; c=relaxed/simple;
	bh=LleY10jWVKcioh2cCgFT1XCzTPL49EuhQjhBg3LPyYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AwG+1t+cX1rAkXX/M2v/lfg+wB41V1otCDCDW3/FiKfWo1RmS3p2hHY8b0JhM0n9erejzu9lhhkjtck7bml9xLGOmr2lr56pDfbwSXlHmKbTzTuhfI616kfUswiqEC711vh8rLUPz2M2D/XhsUpyEhm5ABw1YBxn5G5J5Wzejb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1EcJUWZw; arc=fail smtp.client-ip=52.101.85.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1EcJUWZw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5KP66IU/lMNf42l7VsWwAQoFB97WhEya6mGwmv7PK4n+pbsvFy6mhfDDwM24NIJNVKZNQ9dvHCN0TMIyglaLMc4HG2UcKulp9hWtSHEJx/OoiiHeyiAvJK4af4dWZvyRJ0NR1dgAW1DD474a+K6b1aEY2yon+dO1Hikg/GBBgEIvQSctrNnYyBbh3t1da1/tpEBhel8XmuVBsJXGCIJv3RiLwblnETswY6lNtbo0IZZYNliamwgsRkgt9Fk4xM+BDZq5cz37ZA+V8uQmQ1BTZiwKJA9ipyxwXGiFRZ1VG86KA8WZzS4abGS1Rr6vw7mrXnTmIW0gQ/MfjjLNxMo3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIGqYt8SGKQwTUO8HUhpZPTbl9msBETf/+epdvUAfig=;
 b=gZKGHS6V9I+Gj4wN3kl45mOOaaw3hBZjvM566G+RWvzl615KAupwhmXh8x7rLOSHPwAp9uIjRn7z30gEA3glao0blpztNZEZkRKkL4b+r+8Tp7H38wHTRC/JQH+7vOD5oLHxOCUjGb1XQOfKe05ObHXzjChcufzgSdGNYjVKNX27m1AjIgRmWcjmoiaJu0g1VNcuky3OWFeeYalx66spqD2wH9A3IKXquNeYTNPHvo1Cdf2Oyg3KczvFRjEcbdL66Tbxx3YS682DE4QDNaZtcqdZi/eFNdmPUc+eQV58Qg+2Fd4wp9M3mPeAuPye6Lvfe0NKG46DZvnAZKSeb1zlLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIGqYt8SGKQwTUO8HUhpZPTbl9msBETf/+epdvUAfig=;
 b=1EcJUWZwwXks5oNDUJ4GXRcK034KqNzPSW9UbJxWCf03n9pDu0a+MVTwuUWhvOZyD8O4KeDAVzMsFkJJ9vvQ2LZ66kozaOfZalyqeR2FSdsxBliJNwa41UWWa5D3MkX7wj4gpn0Scec5UnGMMg9hEhZDuUh7EnZNPjdPeb5io7s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19) by SA3PR12MB7903.namprd12.prod.outlook.com
 (2603:10b6:806:307::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 07:03:11 +0000
Received: from LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99]) by LV0PR12MB999069.namprd12.prod.outlook.com
 ([fe80::6d95:9938:bff0:cd99%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 07:03:11 +0000
Message-ID: <e3c3dd49-a1ad-4a94-81ac-4d5759e847b5@amd.com>
Date: Wed, 30 Sep 2026 12:33:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] EDAC/amd64: Mask UMC chip select to the four
 implemented selects
To: Yazen Ghannam <yazen.ghannam@amd.com>
Cc: bp@alien8.de, tony.luck@intel.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260928180935.472319-1-Vishal.Badole@amd.com>
 <20260928180935.472319-2-Vishal.Badole@amd.com>
 <20260929165549.GA3082391@yaz-khff2.amd.com>
Content-Language: en-US
From: "Badole, Vishal" <vishal.badole@amd.com>
In-Reply-To: <20260929165549.GA3082391@yaz-khff2.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0035.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:273::16) To LV0PR12MB999069.namprd12.prod.outlook.com
 (2603:10b6:408:32a::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR12MB999069:EE_|SA3PR12MB7903:EE_
X-MS-Office365-Filtering-Correlation-Id: f11d8e5c-ad9f-4592-5616-08df1ec0e3b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	wMcjhjc/nCidYy2L0+zjcV1GbJfmbkTKJc4YBEySf/RUUUDp+XptgOePTQmAzxgAwdrPK/yxy5Jw7SmQU0/4EkzaKR7XjJEYKozaVZj5B8Gnb0hN0J9kChjEjcQR4+lOpX70FFOBlnYj4WeuOFhSNEU+nn60NJMn3VBqZW8UYBK/7XOFs9EIEXxchimYQ/vWOLRnE2R50S0STY19mJWdXDPiS1LjtxKz43UBCLB0erhUhBwrmcglpBnxdxwtByXGRXKuBo9gldu5TcAv+swdsmI75HB/3YZzuPDyM1wnQ/5UiRDG7LgR0IKPiU8IC/jWDGmKBMSZEq13pOMMESb/cLz6mQep7Kn4b3ru01TKxQ+8L37Wlu56cm1t6gNNe2XShUkKuc5zUWSTDhEzw1UNTn+C2678J3rLMWPHJEfPbk/DQ1+QAILCLGvWZx9GyaWPp/P8i/Lvqdg5MAcNmGoKKwCjkiRlCxhFkBRS1QJ6TcZEDMYlItF0uh8hzCIG+iJiMzbSVI94+b7d/JBgkeA3dYIN1nudm4N9iphW/+bArHP41sO8OPphH0ePDE/PQH7nWJaAEWGT54IZXOay/zayHe4uZZWa8SSl9gMyadIjz+r6dLfNFTNag4pWPNccQJkcjhMfehA5ZKpbsGzblDK8S41vsVh9PUCyePcyIJa3fnE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR12MB999069.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0FWKzBDNy8xaXZqRi8xVjkxdE5YK1BEZFd6REorU2dwZDBjTW9JcUd5SmNy?=
 =?utf-8?B?aFFhcFd6WlIvbHJ4OWlCRTBmNjJJaUE1U09GWUMzcEV1Qk9meUFwNkdIWWZB?=
 =?utf-8?B?dlBwVU1YRW95VE5vRHRWT1dTVHIyTVhoQ2gxNDRMQ1lWb1FiYk9NYm9Nc092?=
 =?utf-8?B?cThpODZmUU56VEtHaFlIWHJPSDVmdmJJUWJJRTREc0JJVHI1MDdta3dKbTBW?=
 =?utf-8?B?QWdTSG9CcFdrbEJFck1Lem9aa0dBTVRFTmFZZkFESHE4UnpaSkNTOWtXU0dT?=
 =?utf-8?B?MVMyb1BrK3BweFd3SXBFa3gwRzF5MkVHQ1dmK0ZScFk2US8rQUhveTl0T2Jn?=
 =?utf-8?B?SGlXSTlxdXNWMnBJRXFobGVYWkxZUDdpM0xCclgxZlVGZmlrTnEySHpIQyt3?=
 =?utf-8?B?U1ZaN1NRR0VCcGYvMit0eXBya0paN3JxdWI1RTQ5OE1iMHZFWlpyc1hJczhE?=
 =?utf-8?B?RlpTMkdqWlVITmQxYklKWXc0Z1Zzc0RjRUxHWXdLVE9iRkw0M0hKSWlhTHNp?=
 =?utf-8?B?dUZoNXN6a2ZHdnhkYXZGVU9abFQzK3E5U1VuOVg5bWt3Rmdja3JHTEk2ZGRW?=
 =?utf-8?B?L3doYStDYlpPN0R1ZWkyL212WnhEZGIzSmlnRXF5Z013QVphc28wc0I3M2sv?=
 =?utf-8?B?K1RUcW40SHIvL2NPLzVncVgyOHJsS1lROGFIVzRHNEZjMXI1WUxwdkFacGdX?=
 =?utf-8?B?R0hVMWRaMGc3V2tJajgwb0xHWko5ODJuRWZ1ckNJRXIrNW4vU2h1STUzanRG?=
 =?utf-8?B?TmtSUHB2Ky9qYWFreVNGNWFMcEhrWTRMYkd4bnpjVlBGcUFJWjlkbmVDcnNC?=
 =?utf-8?B?N3JJRVI3S2xuaitibzRJam9KdW5QTU1PMUVWcm9nZVlpZkw5Zm9GQWFlbTZX?=
 =?utf-8?B?NTNDRWRxVENRaUF4QWQ4U25PVTc5bGx6T3A5YnphYytsbXFPejdVdjMycmk5?=
 =?utf-8?B?YWo0c1lFaDlIcFZidzJNVVp5Z1ZuK3c3U2dyZ2l3alpBSVBpS2hKdWQzUE9S?=
 =?utf-8?B?cGM0dkNxSFQ0ejdCUHkxUHdCSTNibHpaWUJhMG5pSU0xZzFPNHdFcllDNGRE?=
 =?utf-8?B?YlZNTkk2bXpyMitzb0Jqbjg5NW9VT0g0T2JVdHRNVXdqQnRGdmxRbWJ3WFA5?=
 =?utf-8?B?YzliSlNLOStJME1SRXkxSmNPS3d6c3FaWmgxbFRNZXFQU1FWWkE5RXNrZ1hr?=
 =?utf-8?B?RmlBbGViMXdqYnpYSXE1TTFVVndvU3VFL2lTQmNZaWZtQlVaWGwwSHluRzFY?=
 =?utf-8?B?VGhLZG9GNkF5Q1IySUEzenVwMkJkRFJZS2crTW0zMGZBWXE5bUhVSzZoc3p3?=
 =?utf-8?B?b1JIc1pTdk44cWh3alNmbndqYzJxMCtzY0ZqcVJ4SEJpSkFXcGM5Qkw5QW1p?=
 =?utf-8?B?cXJhdjZ5NlEvTnJMZWU5UWVwZHByamRuL0FrNHN0SzFUSEx6VXBzT0lsWWZh?=
 =?utf-8?B?NXdWMHI4WEpoNGxCY3Fqbjd2dkRRcm5YblU3VEd3OHAwam1YbmFndDlKcXl6?=
 =?utf-8?B?Q3dhVWQxVlllZ3Zhd1JRM3IwNlFGNTBnMVRvMGJXL1Fob3M2a3ZIblpnZnhq?=
 =?utf-8?B?dHNQcEwvQ3gzMHJMTlVwa2FLbVFYdzM4TWdXVkFhTlhnUEh6b09uV1MzQlh6?=
 =?utf-8?B?a1I1T0h0Qkp6RStZVzNvLzFMbFpsdEhnMWlXVmlseWhDSXA0L3YwYWNjM2lY?=
 =?utf-8?B?RmJPcE85VGljTnh3MDhVdExaRnlDUnBRamFyQ3QybDQwak5rTkZmUEhlcVQ5?=
 =?utf-8?B?a2NpZXJRaXFwcWlTZ29wUTZEVTg4ZW51TEpWaTd5NjQ1RHNoaXAyMWFMZVhs?=
 =?utf-8?B?aDc5UituSGpDYXFReG5FZmFqL1I4UXhZUkRlWEtaK3FpVi8rd1RVVnFVYkI1?=
 =?utf-8?B?WnFKRXJDOU9EUUE3VGZaUzlCWW9jcEkvNnErYTIxbHphUjBrdWcwN3dEU1M4?=
 =?utf-8?B?VW92NXlJSC9aclc1UVV3ZlArYlhWall6bmdLMVRDK1JWNDI1MHpSZHUyYjNj?=
 =?utf-8?B?MHpJckJMMnV3dXVRMExWRW1QWHpEQUpORis3Q29wTnN6TlA2eHQ1NEovYm9o?=
 =?utf-8?B?RDZWcGpiTnAxczVXNzdQME1TM0sxYzlMT2NmN3Q2NmduU3BFVkgrNVhDSmZv?=
 =?utf-8?B?eFl5dUJyNm9yWFNacXRLT3Fkc21nOHY3dy9iU2VqRnYrNmpiaFJsWUZ1eWFE?=
 =?utf-8?B?cjhEcEw0dkxKNnZGMXorSTVCNXlVMVFFZzBiMXZIeUFrdXdYTjhlNkI0SWl5?=
 =?utf-8?B?WHk5VkYrSXVzakVCZ0g3b3NIUXZmeEtmTlI0aFdha2ZZMUdaZnhDalJKdlJ2?=
 =?utf-8?B?amhwdnlzQ3ZBMVFKb2dSYmVnUE1QMjlhK2pYYXdTYmxFbStBclkwQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f11d8e5c-ad9f-4592-5616-08df1ec0e3b4
X-MS-Exchange-CrossTenant-AuthSource: LV0PR12MB999069.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 07:03:11.5595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqP+40yroc19aoM5FRaU6LK3FieSaJRucvbAY2VW0BXt6PLplgxjBkrsxJxTSXceW/QPdQmCZL0AqlBhf4UsJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7903



On 9/29/2026 10:25 PM, Yazen Ghannam wrote:
> On Mon, Sep 28, 2026 at 11:39:34PM +0530, Vishal Badole wrote:
>> umc_get_err_info() masks the Chip Select from MCA_SYND with 0x7, a
>> leftover from Zen 1 where the architecture reserved space for up to
>> eight chip selects. Only four have ever been implemented, and newer
>> products document this as MCA_SYND_UMC[1:0] = Chip Select.
>>
>> Since only four csrows are allocated, a syndrome with bit 2 set decodes
>> to an out-of-range csrow and trips:
>>
>>    EDAC MC0: INTERNAL ERROR: csrow value is out of range (5 >= 4)
>>
>> Mask with 0x3 to match the four implemented chip selects.
>>
>> Fixes: 713ad54675fd ("EDAC, amd64: Define and register UMC error decode function")
>> Cc: <stable@vger.kernel.org>
>> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
>> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
>> ---
>>   drivers/edac/amd64_edac.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
>> index 475235c402e8..ec4cc306b726 100644
>> --- a/drivers/edac/amd64_edac.c
>> +++ b/drivers/edac/amd64_edac.c
>> @@ -2802,7 +2802,7 @@ static inline void decode_bus_error(int node_id, struct mce *m)
>>   static void umc_get_err_info(struct mce *m, struct err_info *err)
>>   {
>>   	err->channel = (m->ipid & GENMASK(31, 0)) >> 20;
>> -	err->csrow = m->synd & 0x7;
>> +	err->csrow = m->synd & 0x3;
>>   }
>>   
>>   static void decode_umc_error(int node_id, struct mce *m)
>> -- 
> 
> I just noticed that the code comment above this function needs an update
> too.
Sure, I will correct it in the next patch revision.

> 
> Thanks,
> Yazen

