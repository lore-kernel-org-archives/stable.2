Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022103.outbound.protection.outlook.com [52.101.66.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F747AF6B;
	Thu, 15 Oct 2026 11:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065011; cv=fail; b=XwG2CETsaGmBfaJrdVPBkuQWVPfyICZrL5ijCqaN7shikkIB3bvlysht/Bo8kSSjpGcdtt82NeNPT1owa7ZG6tQ8vFs1zS1VmGj1VsWlU27fjQBV8Pu+8+ho1jqlx2LhSFY9ZGySMnLeUBX2w1en7UWsACB4IXkXqCR4ZsrFeTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065011; c=relaxed/simple;
	bh=MrdkErbGtfWi+YyY0ricZuYls8GMRO5q/kc5u/smhkI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bCS0hFM8+y+02sPyOtiSgN4R0Rlagf5XjBYeJUfeQZ0MkX80OrEdpGvobhB+VVA7kfhf/5fUZ4KtdR7TlQljjdfD5Z2wbNXKN4hhwS/KdZvOln2bHIWcyiMxWTqPsPPa2detWx6l32ubQzITOrfZ4GAKwwYjEFfkUszqRGo4hzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=s5iFyO8L; arc=fail smtp.client-ip=52.101.66.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s5iFyO8L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLABI5K1NvWy/Q1iQbAyfcRM4CGrRQGSK/f+QMBHs0q6rxke7uv+ufisbdjAOwafOSEjGtuFYqvjbtoJAz6cWjiWo4Tcyog8jTvWeV93ngwjigNU7cm/o+3Q6EB/CMziJCSApvU7jCr4TBAeEGm7e+vf3yz8LvhhsJ/3zsLVBj6okCOlurt+M8DpU0oJko4thG8sX24IHJshPdxe4y67/6opFcNvTUhCKmliX0WYU7c3ikVCcjmYC9Xa21EZ5rTu4UM5NC9Jk/TSDqcSu9TgPoQIXyKghwJGC4VNhx+VFduaZnZiWDMEB9JUnFq0HeXgYuEgJO8eaicABPMmT219rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F/QfutoVtb0NefGr+53LzvfokLJJ62aYtcbzphVAgM=;
 b=yoIZYDvISD8DWWlaT8rOUpLtvPJsb61aNMqOuNE9QO2IFPSACN+N3w58Dr+StuVNk2+UwbjrT5zvnlAtLBi9NJ686lsyNkwJNbY9iN1/b/5yzsFI59bCi3ur2qymf/Fw+JAHIuUTbejU3UgSelKME6JwsGovGVa0cN4+8R+9aHpLy0Wqyg8YfynMiuAgus+TtYAgsLYmUlCbMXgwlUSyh2f0W2WTVf6u1pxiUteWsalNCDh1MqiQ+FF0z8xSvkFA1GEjHlo2HP3weW3LcrOi/awbf9n+MidFyqw8T30NMHffMQBwSl8tkwyY/ZrgBeSvsT2lE8XtsY0QMSdeEIN3jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/F/QfutoVtb0NefGr+53LzvfokLJJ62aYtcbzphVAgM=;
 b=s5iFyO8LVsMk20zMN5H/Hf/HzZewC0FBQdm6+gMNike7C5h8Yn8ePVigJyL/BXAA90DD6DLIjAB3NOJy+pc2MIi4JKUhTiTQ1gR0hMzZ7YM2ixI04z7JkzItNvHAYZexsCzPGEmBAJceZoq7sJw5CMSuNahfIVVCv+9MwYZwD3ZjPXpXRiHE24JfbQpTVa+BLlNEoIRoTmVknER7SExWru/ZZETEq6+q+YJZlgX3TZt4OR1v83ghUUDkYAQYbXOxrEWV+lwENmoYbdHhRuIU5EYaRRhM9epwpUCoc/U4Otk35FQZcNtMkpPQPU4tVArmlGCcGjSXH5HF6HHhzgxbcA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20) by DU0PR08MB9876.eurprd08.prod.outlook.com
 (2603:10a6:10:424::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.10; Thu, 15 Oct
 2026 11:49:58 +0000
Received: from PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a]) by PA6PR08MB10708.eurprd08.prod.outlook.com
 ([fe80::1999:c6db:dc55:494a%5]) with mapi id 15.21.0546.006; Thu, 15 Oct 2026
 11:49:57 +0000
Message-ID: <3cb6df0a-2606-486b-9667-3952cc631759@virtuozzo.com>
Date: Thu, 15 Oct 2026 13:49:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm/huge_memory: fix the copy of special PMDs at
 fork
To: Lance Yang <lance.yang@linux.dev>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
 <73f0dafd-5b26-42b9-a77b-90c32976942f@linux.dev>
Content-Language: en-US, ru, sr
From: Konstantin Khorenko <khorenko@virtuozzo.com>
In-Reply-To: <73f0dafd-5b26-42b9-a77b-90c32976942f@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0029.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::19) To PA6PR08MB10708.eurprd08.prod.outlook.com
 (2603:10a6:102:3c7::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA6PR08MB10708:EE_|DU0PR08MB9876:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f4e592-ea0a-4984-8612-08df2ab26fbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|10067099003|18002099003|22082099003|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VHCIdSNsVkEcpoaOOnjateHWJUluDLm2LhtnAcT71KmzJCYoELo+qm8lHi4AAglY/NqPsXHbG8h2kOqqbNsB2boMcrL+2UozLQaxzwfGBKO/Gf9+e+gat9lfx3TsBcDhOswgCw1Tra60FhUnkSWbsUf4citJaMTQqQbbOBhdKhpaY4wSh35Z9OMUMBFt2gwd+roMD7xYd6NJ6IKemtmQail/CeNLbo0P/QffraMzaCgtKzrqbckhj8Dc9JPdMe5ric1Dbdlwb+AxUsYZS18TDvfrKKZwME/00zIZ3qXPXPfBiOCIKaOq2x8fOS/EaoaHS+nZKaNDnNmvKJnNKPWHLyZ+0OpcT3ciaIVttv4Id9AqhnzWuF6rVRrXMhG+/SU9Iu7U1zP2u7qeTzKrj4dhkr8tG6so3xcWS7loS08gIzNoqpITCXthbgPcPH45fuUAaaNy6xnVqgh8Dn+YO9BiQfE6B7mEslLcs3/8x9Za9NUjwKCThgxRKOD7bXCC+mvNV7blqJhgYHjhexYzyLMQOI3qFvCUAOQqh5Ssrvh1Kz28KtY24ULq08BeUKhRlTNk892MLI5BXHhsZUwDKnj7Ed6sbIznL1ioxvWdquNuBc3cH4r6etghhfPjxiAjx3i4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA6PR08MB10708.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzZKUW44eXBBeE8vNGVlMTVIOUJwbGo2MklsTUkzeE5WZmlLeTFocW94VlBC?=
 =?utf-8?B?aks3VCs1b1J3WGNxUXRCS1BIMFlKeUZrdGRsU0ZGZGc1WUJ0RzlqeUlzS1dT?=
 =?utf-8?B?dmg5VzZ0Qk9ReFBkY1F0VFdaRGVuMklMNy9CYk9scjFFaHNUbWlQMkx4c1F5?=
 =?utf-8?B?bmxzdzg2TGQxWXowOU16RUtSRXMxcDkreFZVRnhZbnlhK0ZTWmNnWkxBQ1Jy?=
 =?utf-8?B?YTdnN3BBSkZIU2IrVFptMWpvckVaUVl5Y3dqWXl1QWlud1lzWUl5K1gvZXJ0?=
 =?utf-8?B?c1hDWFNDVnlhTFJybU05TGxSMmw1Z0owc2VGVXczODl6a0NkUHFyaXFuNE5I?=
 =?utf-8?B?QmkzTnpWenRneFZwTis2STRLOUErNjFSS01SdXpFdWdEdXBwQk5wL09NTDRw?=
 =?utf-8?B?ZHNnajVqWmt2bytqb1l4V2c4R2ZzSENuT0NadHl5czF1a0hIYU1qbnpsS0tJ?=
 =?utf-8?B?OUFUbHQvNW1VVERoSkl3K3hFdmdjeDFXdy9weTV6eHRmVHVUMGcyZjFtRnk4?=
 =?utf-8?B?amJxbmR3NUdKamNXZnRQTDR0WnpTcHlCVUVWOW0ycmFsRWk0WFZ4cW03S0dD?=
 =?utf-8?B?WFpaUVcrTE1Sd25vR2dKLzBWeUdFUkczYVNMTnhwVnBFYUlPWlZ3ZjJqSkl6?=
 =?utf-8?B?T1pjbEZtaFY4cDF1WFlZU3lsVm1xRnI2eVFLSUtlYTl6VXNxeHRCZTNYYWZ1?=
 =?utf-8?B?aU1kZ2tEMkFxQThwUVdDeXNoZjZZNHJtWHVzOUxxQkFDNjFxUEhVYisxd2l3?=
 =?utf-8?B?NUx0LzVoUkFTZ1cveFNrNlFRL2Jzd2ZVMWE5U3RXcFpPd0l1WW9CVUVBN0Nm?=
 =?utf-8?B?Sm9yNm5WaGtxSmNJVTN5bkZQb0hrRDJTazUxQVE2S1dFbjRsU1gwSVhvMGNk?=
 =?utf-8?B?TzNoYlZ6cmRUeUFZa042eG4xVno2RFhFeGMxWTV0SkQ2eEVsOElHc3kvcDdp?=
 =?utf-8?B?bTRIb0NVMVdQN2pMZithR1FvcFRTcUZPOTlqd0RwOWRHTGdMS2RUd0txRklK?=
 =?utf-8?B?MUJSZ2NwOEhBNVhNMTJYUXBHS3duZXJWZzF5ZW9VbFc3QTIxZ2ExazU1bHpU?=
 =?utf-8?B?bEhJNXR5K2htRjQyVFFtOC9xVE1qT1FYNVFuVDZhdm5ybTdKbFp2WTIyUzd0?=
 =?utf-8?B?UjJpNWVTeDROdEhBZHhDVjEyYWI2VTV4NXJSQlgxb0h0RTBQNGVYbmRuU20r?=
 =?utf-8?B?d0hEV2JabExsaXNkOUl1V2RWNUZtUmQzUTI0MkQzNFczWFlLRnlnS05WckJO?=
 =?utf-8?B?aGdmS1dQM3FnM3dsbUcvcnlJOE9mUjhvT2pWZXNXSWlNNnZZd1BiZG1TemVP?=
 =?utf-8?B?K0VMcEFNZzMvRWFKUXNlZTYxa1BWbW16VktweFNDYmlMM1pRS2Z2Qjh3YzJK?=
 =?utf-8?B?NVZnVHg3OFJ2b0lRdjVJQ2JhcllsbklGWHJhMnJTbS9zZ2tRSzlsY20zOWxq?=
 =?utf-8?B?N2ttUHV1OSt1cFoxM0FIaW1qK2lleUdIQ2ErU3ZQc09MMUhnOVVFb1FMMVR0?=
 =?utf-8?B?anliVUhDL2tsMmJwQWxZT0Qyb2NDOFBRUitWSkFEVURSeWxxM0JWMzRwZXVj?=
 =?utf-8?B?WjZCOUFoaytLSXByQnBicHJqQUtGdHBsQUlHMURjdUZuVDhoNnJjUkdRNkYr?=
 =?utf-8?B?R1VVY2lGSGNqUVZ6c2s2L3NRc3RoZUtOSy9LT1F3TkRqVTZGdlhxa01Jbm9y?=
 =?utf-8?B?UFdJU1g1UmJyS3orOTJpeWJQMk9ubWhRTFdwemQvNlFSVTdMd1NpNnRVSXht?=
 =?utf-8?B?S2xqc3JXWmdqR09ydGY5aEdOZW1Bd2kzREw2VHpiTURnYlNlRWNEMC9TWUxN?=
 =?utf-8?B?WGE4RDN3TFFEeFQ2YjgrOUwrekdaZGcyNmpldUV4SWVSNU96SzNIUFpxZUVn?=
 =?utf-8?B?UEpaQnZwRDRFeUhKRS9DRTAvKzJCS2IwaWwrQ2Y1ck5rWEtEYmYrQy96clk3?=
 =?utf-8?B?VytsaDQzRytVWGNVMFd1L09FYWRPeVQyN0VFL0ZMdnJTQzJXOFhVQ3FoY0J4?=
 =?utf-8?B?TXF0dXc1VVcxVzZ2MFl3cnM5clVkdGU2YUs4ZFg3cG5HWmlYTlZXN1VjY0dW?=
 =?utf-8?B?WHFyby9NMUR4Q2M2NWM4OWQwVzZjTVZqUm9YcThkRU13SjRMeDljclBoYnBi?=
 =?utf-8?B?Rk5nRXA3Q2R3OEd0WXY3dFN4QTJiVWR5a0cwaGVvbjcwa0h0cm56d1cwRVVB?=
 =?utf-8?B?b1RjNDJIQnpWcUtCT3NXa2p4MGFPL09HUDM5UCtuRS90L0IvRVRod3R5V1ZK?=
 =?utf-8?B?b3JsZ0MvYkRab2h6Ukc4MzlDQ3FjYi8rN0gvKy95RHdYZk5HcUFtbjYxOGdD?=
 =?utf-8?B?S2tocG1wWkthYXpHMzVESktGL3U2bzBjd1RKTGhhTnplTUM1NXV4QT09?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f4e592-ea0a-4984-8612-08df2ab26fbc
X-MS-Exchange-CrossTenant-AuthSource: PA6PR08MB10708.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 11:49:57.8307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5J1ycRV1BGsx8AO3bWHF61tBNlk3k9lWh9ldJ4ruF0yGUSrc0rChLSZ74CEiVP2vhqy3C4pyL1gEcd1Qsm2Hng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9876

On 10/14/26 18:04, Lance Yang wrote:
> On 2026/10/14 23:57, Zi Yan wrote:
>> On 14 Oct 2026, at 11:46, Konstantin Khorenko wrote:
>>
>> <snip>
>>
>>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>>> ---
>>> Changes in v3:
>>> - Patch 1: recheck the PMD with pmd_none(), as only a zap can change
>>>    it and a zap leaves it none (Lance Yang).
>>> - Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com
>>>
>>> Changes in v2:
>>> - Add patch 2, the page table deposit for ppc64 hash, reported by
>>>    Sashiko.
>>> - Patch 1: name panthor instead of drm_gem_shmem as the driver whose
>>>    stale child mapping reaches freed pages: drm_gem_shmem keeps the
>>>    pages of a purged object until the last mapping goes away.
>>> - Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com
>>>
>>
>> Please stop sending new versions of a patchset repeatedly.
>> Wait at least a day for others to catch up.
> 
> +1
> 
> Please slow down a bit. You don't need to respin every few
> hours. That just makes everyone start over ...
> 
> Post a version, wait for feedback, then revise. Twice a week
> is plenty, honestly :)

Guys, you are awesome. :)

Trying myself to do the very best i can and yes,
"too many and too fast" sometime does not leads to the "very best" result.
Set myself a hard upper limit to 1 rework per week. :)

Have a nice day and thank you for looking into this!

Cheers, Konstantin

