Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C6B509EF2;
	Mon,  7 Sep 2026 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794572; cv=fail; b=pI/oOAjrCfOZdRMuCp5VaEXbKY2X/iVEdmjIW4ZINNUrsRnFuhD1gn3CXvJcb8chfXLpD2wBtolWapXOhYV1MYoIc8V2lXtlswAGhsxYazofnKhFQqdoBfC4WkqcfIqdg5cTFm4lIXBnk8IoZfrrzLeYMUCXgGa8bCjtd2lTMkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794572; c=relaxed/simple;
	bh=AoqZgVoScRgxMR0/gQtCcdrEEmiGIi8ojK89w0ZAiI8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H4ubJS2dK737u15qP6OdGPG977WSdx0lLvfuxZ1zWEOYgHOj3L9zF3x0gFmxG1GBZL7yf1uFoKfsNw3XX/dHfXvY1bTpAA9DVvzNrKbgARV6RRtg/XELn6AfBs5tzaxy3d6AYEl0qsoQt7pvlAonDk02IzQWL+ZT5kb8S+ICeow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XzYOeuHT; arc=fail smtp.client-ip=52.101.57.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XzYOeuHT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbEpZVfF3DePznNoIJRY8s/sSr0kRhyyO2EDkzDlzLk2/KOSbE9yaj7rKpEOIMdrNm0M1pRtcec7xOyUh8vnG5tv5onBTX7yuuV+YUUv6Xkxq9r1n9gB2DTzCcnQ1vXykRKlF1hy6ieMriM3FCRFh7o7I1PmGRjQ7nHBXvA/5LAz1CD26BGmu+Hgt5UQbswKiFcb+Evv4aB8KP1dSC05JUvRdtj3PrAWWaRxLw97Kd+rmY3/PCvZILTFCQJpZyDeiTex59s4oH9qIMlNj+B9qtw++nkzTB0+bFAvwptHWLIgBOg4QARKYXjdtpBWwTTbOymBCfkw4kj4+RNGgqt2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nVJ85+FUtPyl7m1PYChhEMdhK3tTsAS43kJOhX7/2yM=;
 b=kxbIKPLQgBwQ6arPpiuAS+uERktWVLVOfrROLNu/3axYhxEO/6/m3epTJw5NcpjTOlK84KZzOaEej27ZKhWgB9duM9Q+uLg5ChmmRliTCUVOfZsUf3wECUePDJWJg74YWh9LvVf6BseiLfHxFKs99NQRYpUvKeJtWY9OJfnRP3SMW3a0ykp6cmK8Oi2XZO9hKpRT7AMf2iMBRtLAqt9WJNbsh8EkeLhiOafVcaMEchB5DD1e9L4aQoDfXHe6YP4GucflBgLkKEYLSM/d0pjCwrO1wMWZrWXdjaSLoScMT8vw2ZvfBCPGcOFP6DXZ6JA0i3/oktiRqARgtl7X7HLCTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVJ85+FUtPyl7m1PYChhEMdhK3tTsAS43kJOhX7/2yM=;
 b=XzYOeuHTCQOAw6LfwagSEH9WvRMaEKsfsnznu5ulSzM5VUA68Yce54g52Skd3dV6ENHZj4nnFOeeVm2JwgH9o6ka+oosTAkSSNu9Mplfods57iMfu7Wo4oeyerA9vTkWNb4H9YjXV1K9m6ZJ+v991sgKTL2exOk5EKrARDTHReM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 15:21:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0339.007; Mon, 7 Sep 2026
 15:21:34 +0000
Message-ID: <825c1f02-b9ad-4160-8e4b-53f2393a7bff@amd.com>
Date: Mon, 7 Sep 2026 17:21:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/sched: cache the timeline name to fix a
 use-after-free
To: phasta@kernel.org, Tvrtko Ursulin <tursulin@ursulin.net>,
 "Jonghyuk Kim(MalHyuk)" <malhyuk97@gmail.com>, matthew.brost@intel.com,
 dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 mdaenzer@redhat.com, alessio.belle@imgtec.com, luigi.santivetti@imgtec.com,
 stable@vger.kernel.org
References: <20260904080618.2098450-1-malhyuk97@gmail.com>
 <20260904080618.2098450-2-malhyuk97@gmail.com>
 <f25f2a91-b72e-4392-ab53-c11ef60e0fe0@amd.com>
 <ee27d37269f609192cdfd7a217d9731d7dca04c8.camel@mailbox.org>
 <a41a35b8-c78b-4c18-af11-26374918f222@amd.com>
 <7e4497506bb051fd1c25ed54f88a8036084e779c.camel@mailbox.org>
 <81e51d72-d608-46d0-a986-390ecd6f468a@ursulin.net>
 <d3d2ae0ae55fb07780f643de9517f3668484575a.camel@mailbox.org>
 <47464619-890d-484f-986b-9a6c06cd89b0@ursulin.net>
 <c3434f0a80318390d183a3a2f8f8fb3ae71c9906.camel@mailbox.org>
 <2aa58eb8-a33f-45b9-8ee0-518d72160f41@ursulin.net>
 <206df2dad0c68b8c25862c74c0a8399940044af2.camel@mailbox.org>
 <fa12360b-2ccf-41c4-a158-84e34835c0e9@amd.com>
 <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <299ef4389875fe1333bb934edcece3bee5c5526b.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 98e5d1b5-5436-423e-a038-08df0cf3b406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|7416014|10067099003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DZIpJ6A9tv1LMoHgI4eCixLdiAz8IkbEOk5HR/vauM2lYZHZdjZzcZZ46yEjMma5po9FB+eFBSLJb1Q5oqyS4Z7ijL4kYAcPZFtrsU2Mfs2ytR+EVw3f6S/aJYNe0LF1s2wXp270IPKNWVFIgUw+OWBkLlvSpdXICehSgQLMrE26jmrIijn+8u/3sHn51v+Sn+xKATdvsBCAHiW8yiGBxf4OPFn8GC3T9a9DqPoAhPd1GxteB/1wwKgSNEoiXX9b8uybdRsBFbeegMhaAlNUB37jivim7NQFEIAm/+Q/eSGANlxLwU6g+wX+z8+3tk9q/W8arnYDlyODT9PV6XNEiCytSDLnu30ZkJhi/Yv70ydd15LfnofTMsHGU1nLmMkB9FB7DGT0zgeOUY9jqYxXntcxIm+DDGei4R70SEwJZYQMiCt2uz1D5/b2WVF8V66eQV3Z4AgWu0ep73bZ77w3s2JSfz14lcN5f1LkpysWQ0t7ZJmroLS2S/l15oQmgtQIK6b2gAnIrLxf81LANBsPq4sOiyDdtBkngioyBm57M2ArJ+9S04eOKeNMxBt4tWKL+6zY3XkhB2UL24Lq789Z+cRubSf1wwIr5plRDiqTGk9X5E+UACCVORTuvFDjg7dsSCQgJurCnI8eLzhjTxdtFzkodgtTB/G+2k67eY6qqlg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(7416014)(10067099003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VEx6WW80K0RFZ0I3K3dPeDRBTEFlOVhLRWw1ck9zSjdDMGh2TGdEQUljUXZT?=
 =?utf-8?B?dDRPUzE4S3VFWUtPWXF2UkplS2NXcDBKZnN5RVhiVjdaVThGTEd6TWpBMVNl?=
 =?utf-8?B?d3kzT0NTWmdDSVhOOVpqUXRRMk52TVR1VTQ3MjRGOWNGQ2RZSW80SEU4Q2pt?=
 =?utf-8?B?R3FRUnY2WVYrK1ltSkNBaVlTL1doQVlkZmVRRURxcnB5L0ZrVVp5T01XREIz?=
 =?utf-8?B?QzRMT1FKVkJoczJNYlJVSnVnRjEzbmgxb1M1SkdReGRLUGM5SzhOSWsvOVFU?=
 =?utf-8?B?Y3lHYjNGa01uSEtNMW1hUncwaHJMSGRmZ3k3NVM3bDF0VEE2alh6d2hic3ZH?=
 =?utf-8?B?T2kzWVg0elNWY3BoZkdYM2kxMk1oTFpIclBId3JQWjN0NHN0VUhKM0tWanlV?=
 =?utf-8?B?NEFRMjBkMlhFelh5WkZGOTUyWlpWdHJPYlM3bXRiUHlWSmQ0UWsxZE04elVK?=
 =?utf-8?B?QTVuS2d4YzF2ZDN4S1JRZUlxOXlLVEtnUUZSUkNvSGdkREJSbCtnTk5TbU1q?=
 =?utf-8?B?b0FTdDFhYm1NcHE0QkZ6a1MzdktUWUNoa3dKcS92dDVGMWtlV2F5ektQNzFK?=
 =?utf-8?B?VWY4K0dtZUV0NHBVVEJYSC9STTVhN01CZGd5K1hMUDUyTDJUMjRTZ0VFM1Fu?=
 =?utf-8?B?cjFIeFBEK2tJZXNOYUJaN3ZQT1BWVFVNTmtjcW5yR0RrRDN2V1YyeEl1VU81?=
 =?utf-8?B?UldHeDFiREZaVVQrK2pHV2txTnhxUVRTSnpQdnozeFQzWkFWbS8rUmFkNjg2?=
 =?utf-8?B?eXlJMjlrNHRKM045dWJpWmR1eDhoUG0yOFVsdTdOOGl1Y3V5b3lzZjFhRnZh?=
 =?utf-8?B?cEp3aEFUU1dvTmN4OWZncnRLTldnSGt6OXFTRGNMbGJyeXhrMnhGd2VJREoy?=
 =?utf-8?B?QUZMM1lXWFU2SGpqUmZUL3MwbXhlMlR3ZFpDNzFxU1U4bHRvZnVhRzdWSzZB?=
 =?utf-8?B?ZURPcmRxUjRobVlyVS91WEVPUGJLZlVrM3BDZ1lETUR0SFFnV1FxVHNESS8w?=
 =?utf-8?B?UlVDWVArVWpDT3ZlV1RGT1BRK0NSWFhIaUMwTWU3Q042WHFxdGRqdHRhSFRm?=
 =?utf-8?B?bS93OWIvUmtObU0wOVVlcExDbC9GRmRydWxURDFoSXlyK0wvWVltdTlWdWgy?=
 =?utf-8?B?ajBpcFRtOGVEK0lCbFpMdkJIYWx3NmlkVVlCbGZRZTN1QVRqQ0hvMXZibnZo?=
 =?utf-8?B?aTdqOXdmVy9pU0xEbUlvRERaZFJ6RGVpT0xSWEVlS2h1cXNXVDg5SDdETThR?=
 =?utf-8?B?N2k5ZzZ2YU43dlJYYVJFRG5TbTlTRnNUSGNmemg3czhsUytsR3crd1hmbFdi?=
 =?utf-8?B?c0dnNTB5OHdIa0Fxb2Jpa1MxUVI2WVRpVk5SOS93SHMzZXJsTTFRcmhlZGVD?=
 =?utf-8?B?SG9TeW12Mjdpbmt6cHV5d1BhMVE4bkQ0WVF3YzVGSGI2a091ak5jZGIxWUdE?=
 =?utf-8?B?NUkycDFLcDhwWHI5NXgySFBKd0tTTmtBaW9IbVROSzBCd0VnRGxFV29LRXds?=
 =?utf-8?B?U2FQcmhleFUvQ0gwcmlqaFFxWXlFVy9Jdkt3bzZGUW05WlpJVk1CaEpsNXNQ?=
 =?utf-8?B?WGFsYkMvd0d1eUw0K3pxY0VzTGNVVWlyS3VSaFhlM2ZRNDA0UmxGbUViZTZR?=
 =?utf-8?B?NWFsUys3TkFEVkRJQkhoOTFDbDNyTjk3NFRueVozQllJUHIya21BSTJxKzdG?=
 =?utf-8?B?SiszZTVYYVRTdVcwMko4NUUreVJEb3BqWjU3bkRSc1pnN3diOUlwRHFyN3Zn?=
 =?utf-8?B?bXVkRjFuei90L0UwRHYxVnRQU0t1OXZwaDkxZDA1QjNMaThDaFAxRTZRdXFC?=
 =?utf-8?B?SkYwc3VoME5lTkY4SzJnMU5FNFJjM3l6R2plUGJVUThQcVVqc1pDY1ZZYWZt?=
 =?utf-8?B?TlBZbSszQmR6OC9QYmZPSmltdzh4NWJKS0dtYVZtamdCcGFjVDY4Mmx6VU5C?=
 =?utf-8?B?OXladnY4S0liMGMyd0FKTWhRVmJzaTBOL3hHMUhzbWZWOFhqRWQzUFJJYVlR?=
 =?utf-8?B?U1JMa2RiSTVZRmxhSEIyTDJrSk9kRTBwN2FiQjhxblFUclNHa1BSc0p3UjYx?=
 =?utf-8?B?Q1prSkpndlUwT0dKYmdpTWIxZ1RSTlVjRG5FeUVmSi85L1ZZdVZYMnBJVDQ3?=
 =?utf-8?B?RTNqZ0dIZGFFZDFnRnhuN2N6Zm1DTFVTY2laVXBHS09tdnZLL0VzWE9SOW9J?=
 =?utf-8?B?MlA1M09zMmNUN3V2TWpHYUIvWDZ5YlFCOVJOby9rNVVZbmNzL2lTNkN0V2hO?=
 =?utf-8?B?c2NsRzdvNEdSM0hEcDBLNVk5UnNTUW9IZTB2VGlFTEdTYUlJSUdtaHpUbzkz?=
 =?utf-8?Q?zTaEHu29vF4e8s/sDa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98e5d1b5-5436-423e-a038-08df0cf3b406
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 15:21:34.7820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hn4LPAUEB0jIGDYXAU/4rvI5n0Nx+gHZMCxjisl2kzlSyXPaN/btIH3zb4JCvNP1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990

On 9/7/26 15:38, Philipp Stanner wrote:
> On Mon, 2026-09-07 at 14:59 +0200, Christian König wrote:
>> I think the memory ordering isn't really a problem.
>>
>> See if the ops pointer or the signaled bit is loaded first doesn't
>> matter if you check both.
>>
>> You only need to make sure that the ops pointer is loaded once cause
>> that one is used multiple times, but that is already the case by
>> using rcu_dereference().
> 
> That.. sounds correct.
> 
> Although I still don't get why we then can't use the signaled state
> everywhere instead of the ops pointer. That would be simpler.

Yeah I have considered that as well.

But I wanted a) to let trace_dma_fence_signaled() be able to trace timeline and driver name for the last time and b) not keep an invalid ops pointer around.

Setting ops to NULL caused some trouble but I think we have solved most of that now.

> Anyways.
> Maybe Jonghyuk can give your patch a test run and then we could use it
> as a hot-fix to backport and discuss the wider future of dma-fence
> separately?

Completely agree.

Regards,
Christian.

> 
> 
> P.

