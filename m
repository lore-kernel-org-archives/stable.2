Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011030.outbound.protection.outlook.com [52.101.52.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A13E3DBD
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780653390; cv=fail; b=ixdMImd2JjvvTRzSxbQyIt2aA/qHda0NxxGg3/VacQrPXfbsJL3SxmGuXG8TC2XA7iQPfSvFsmVsBvTsxrHoboerB9SshBKUhv0bBWfdqGfAZESQ/Q3BtjzdSlkJYC2kJNtY28+UXV4snPCZzgsbp5BzxshtL5/rQPO04fgbc8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780653390; c=relaxed/simple;
	bh=FH9DsvJyoGqDI26NUpH8ZvuUsxdZJwSGULtTw7KSl+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mkldyqYAq+wCJiewu4HohN2VVb0ZRsi/QI0WQAsocMTCVY2rvFLZoYmcWIwxKQxIwhcaLPQ3w5qtyz0rohdKuhKnODbUICpPAmKjWbab3CvZ7EHSM9r0+FLcD3JWOsAcWcatkt7seqqP9+dfO9CDqBODhrvw0Cj7//7Aq1lcIJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ghzXZ3Jm; arc=fail smtp.client-ip=52.101.52.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ghzXZ3Jm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J7yhem101jxy5yegePJjMZ1rlANO0V9yPHNjAOUkvrDPHNiDnycjiwDcICb08H00cXhBd6J3Tfa4e7R4V/gRbeuk8fe6NbF01vIlZxdXMSllLCxZoGQPg4FWNi0KsqCxaiui3HYz2tJ0DSpqjMxDVjH7XcHje0TdTa9MmAURr4ChnFkm9l06twcuinJl9BZ39z+e+CH+tc5WgWKE0JWFvWzrSAfAa5jOTJfPo7Ghu5PdmoM8xMWu54caqhUwQfgmR844ScYdo4/1gZoLVTi7xc8a+YDbuqtilVDMsrPerMqsNlqzQCyWTaqgAC3+jJlKliS0FXKj9XCbgBteE5JvNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJI/91m53BYsogjD9yCbqthy2Jnh2D9Tof4bT3ME8tg=;
 b=RFiR7soYiP9FB42DLgjKpAw8p4jPkE9Wf/YkP2XOiQuDPGgm1dxxWuZ3Qjp/FhtfTHZHpCWBX47MeXZD5EKvktXzivhOCy55/AK1dSe/oZOkTGuvo+X8mDswqB2SCPxrMNLPYc3+n7LIn+7VaswmwR2oExFHFpMQTAokBbAcGolWZMw2Vcas2dWKw5VWfY+1Aenrlom/jOsTqsfXljUifHvGmZ0gFXBqiKGP3VMOUdTVlxzISw99e/MZnpJMQOLiXM8hUSJ1ypsPCezjfphXgpldsBQ5jqIaZvf0PuZOY/Wg7S5/i849KQhFmG+KXfgNYb5Mvc4o+fuJQrDLkV4hKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJI/91m53BYsogjD9yCbqthy2Jnh2D9Tof4bT3ME8tg=;
 b=ghzXZ3Jm3Dm4dKm0HFrgce5WYJLbzxVdKzi7IF+LZWXBrGoL4rKy/XY8bheg9TuN9yq8kdWl18Jberk+bGNA6zUxXcXgEj/y+kvdyLOK7GASyRDDoXpr88wHmRbSUfsVyuzWbISOQyPgNFNXtFm5Y8rfPxGho/63Tkgc7Y2Ui1g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Fri, 5 Jun 2026
 09:56:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 09:56:23 +0000
Message-ID: <11a8b646-f067-46fc-9fe6-5fe7d6038870@amd.com>
Date: Fri, 5 Jun 2026 11:56:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on attach
 failure
To: Matthew Auld <matthew.auld@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Gote, Nitin R" <nitin.r.gote@intel.com>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Brost, Matthew" <matthew.brost@intel.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260601101536.1333480-2-nitin.r.gote@intel.com>
 <ff4a02f0-5a59-4bad-af76-3d71146f136e@intel.com>
 <5e3854dd-d6ad-4110-966e-9029ef7c2374@amd.com>
 <b9b9e20f-703d-4e43-bd1a-17d8bbcead70@intel.com>
 <157c5cfc-b0a5-4ee9-b91a-909e87df3080@amd.com>
 <SA3PR11MB8118477615C02DD99CA966F7D0152@SA3PR11MB8118.namprd11.prod.outlook.com>
 <SA3PR11MB8118C54C085BCAF117582849D0102@SA3PR11MB8118.namprd11.prod.outlook.com>
 <9d26ec14323cb5a54e2b6e58cb177a4a7eb3652a.camel@linux.intel.com>
 <7269ac80-1470-46d6-bf2d-75b5ab7acf91@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <7269ac80-1470-46d6-bf2d-75b5ab7acf91@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0009.namprd08.prod.outlook.com
 (2603:10b6:208:239::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 28501bed-ce8c-405f-3280-08dec2e8b370
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099006|4143699003|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
	GWHMtpMaSWQ7gHLwDv+RHm0MTGJr4jHv9ZA4KXOyTglFDuT/0l9AoItQe1+M5Qiz0F5JHG4Ieb6Q44TAg7Yd52kDBUSKJnGJxMt01VsWDV19SvyjDaJCmdBsbmA/c9BYk97uEy+OOspr9tzNvA2aqIalhUDonqB05wvoHR7AMjOqo1aBYyqVhXOHIxws+sQEO8ug8uo5CBUyPCRMaJ9JD78daK3fiRrtpR2v3LTdiNj4HzXf8WZLYhltf6dGZdgTpfjsdUcB6JDS0Wwy10pXh6hKfTK8f9SFR3YaVJv6g6NI4AkmVGv4vuDH0FWH2XK+3FgHpWUsKXmlNMBIdi1j11O9k5i7mchnzZXjFVPgbgbEzKwcUCllgrBXgokGLTrXAPe62ajv5De4umocgyZWAdz3EdvoOGZOurI9rKqrlb/BdQgPjg4uqY1PvV9ck5qe3fLl9mrQRuMWScrKujYw4MYPhbP47pzLAYYbpTFklub0Ex635bN0LR3zlkiFxm41DxTKIPu4nLnhJ4SjCUo1CohXg+MxVz99hYaVcVxCO9ajknn5FxO4ZyaCvXHl1TdkUgEbYrxwg/WFEuvcWvZttbA9joReUp7a/pbgGeCZ0BiKPcLqTMTajnDOIMVy6RmDt2eOa2tpNs+Iv+4HiPYKcA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rkd2amJNWlhMREZiRVZWa09DN01rN21BMmVHYi9VWU82TVFiWjJ6djNUN1E1?=
 =?utf-8?B?RUFMdkhzdWowQk8reGtLdXlNRWtKeE4xTjJsaTcrb2JqVUg2QkJva3ppbFpj?=
 =?utf-8?B?Q2M0T09RTFpKaVgwK0sxMnkwVjY3cUtvNmYyNmhON3o4ZGhId3NHcnlCanZh?=
 =?utf-8?B?am8vOHRobTdTcDROZElNRmNZeFljTDgwOXdmTnlJV1NrbWRVcThoRDVJVVhG?=
 =?utf-8?B?dFVEbFdSN01WM1N4c2x6N1gzcGZvYm5Da2d4SmRTSEJ0TURXNy9sME4xVlFS?=
 =?utf-8?B?UnVOeGJrdG8vcnBLWEp6dERMTFB0OUtxSWt3cWRmVGhEMHl5UTAxMndLY2po?=
 =?utf-8?B?WHZUcmJ3UGprOTNJeGlzOWFyL2pwL0tzWnNrSnpaUkpnRVI0MVdVQjJkNHdB?=
 =?utf-8?B?bHBhY0hadnJrRVFpRjlFYS9kMkdZWVh3K3VLR0FQUDZra21HK2RqcC92dmJm?=
 =?utf-8?B?enl4RmFscThZQTdkRE9ZbTY4ZHhMTEkyZllvUlM5QWdMVEVjbGZoRGdmS0Yz?=
 =?utf-8?B?UTBwcUNyUjJQeStSb2hUSjV5Y2V4RFBrTXdMalFPNXo3YWRybXcrTFU5Q3lV?=
 =?utf-8?B?bjRtUnlMNFpHUlYxKzhyN3F4VnhnTStYMEVtSWRDWTJPS0h3T1dYVDJvTHlw?=
 =?utf-8?B?ZDB6UitGR3RSNjBKbnJ3MEQ1WGo4U1dVZEZSejBaM2dnT2k4NTRYaGRUNjFE?=
 =?utf-8?B?Rk8xREY3Qk5aMXRWODhCWUNUNmRUYXNQYXR5QmNreU0zL3c4L3VsaWppZzZ6?=
 =?utf-8?B?SVRzblRZWTdNeGlOVW9YR0h6bjNONWVxVU40am92b3hObjd3djVpVjVRMzVP?=
 =?utf-8?B?NGVobG5TdE5nbFJDV01PNlBCSjhjRkh3RlNvS0MwVTBHeEtZUGx4TkJlOW1F?=
 =?utf-8?B?U0cwaDZpK0F5b2E2WUFNYWVtYzNKY3VQSjF1NDZoSmkyOHJ2VUlkVnJzS21k?=
 =?utf-8?B?TFlSbFhrcWdOQ0U0eGRKTkpYamZqMTAyb1hBT2haMnRMbkVEcStpTWRkRmRh?=
 =?utf-8?B?VEU2L1MrY1BBUmFhcTdwNGRVdU9OUHM5Und2TzdRMFlNUlVabHRWTzFuNUVa?=
 =?utf-8?B?NnN6U0xCeXkzaGc5SW8rZUVhQ3Y5c1diOWo4eEpjVzcxOGMxZUJDalRadGNq?=
 =?utf-8?B?UUtHV1JSVHM1LzVPVUNLNDRvTmxxdlM3WmZ6L3pqdWp1Y0doaEhjTHYxemZX?=
 =?utf-8?B?Y1o3bGhtbXFoUmRZWkFKd2VFNzM3bTUrVVJnWlNxaEd6NjB4OXN2UTBGZVpL?=
 =?utf-8?B?QlNMWnVYa0lYUlJUUStkMFhZajZ2Tm1kMzgyeFFVZllBMnZ2dzAwVmNlZ0dE?=
 =?utf-8?B?dGR6KzdXblZHTVpZamV5bEoxVDhwWFp4OHJOU21ZY1JSTVpBZk41UGZBZ29S?=
 =?utf-8?B?Q2JWSVNEMGtlTlhYMWdRdDl2S0dNeC9ibFVFSEFXVm5lYldvY3N4NVlRUVBk?=
 =?utf-8?B?Z2pnZUtzL0Q5ZmR3OE5yNjBWZjBjV1BGcTVIMVlydkorYkFLdkJGSll5RzJQ?=
 =?utf-8?B?WGdXa0YzcUdldVhza1AzZ3BRL09lOTloWUQ3a0R0Wjc1SW1xRGo2bEp5T0Vm?=
 =?utf-8?B?V1hIVWpWR0JVVmR1SC9FYldMRnJsdnpZSXZ3Y3hoQ3NmYjllNk9EVmtvMXJN?=
 =?utf-8?B?TWJ4dHMwdGFaM1VMVzZ3dlEvSC93UVd0a0ZQaHZOTWVaNzgwZFpGNkFRNmZZ?=
 =?utf-8?B?QjRzeGFEVTc3VWIzYVN6QXZhZWdYNXorQmFSelpNUFYybWZKVmdDdHcwRG1V?=
 =?utf-8?B?aTAvSmJrYStDTmx2bTVCVHMrZjh6MWRwYm5Rb0RtT0VneWZCOG45Y0RrQlJo?=
 =?utf-8?B?YXdtL0Y4WWpmOG5QZm5HQ0JFNkNsMXdRZko4eHlkU0JsWTd5ZDl6aDl2UUhk?=
 =?utf-8?B?c2QxM0ZjV3IzQlJEZENiNUZmd3E5S2RCUFNFdWE0Q2dJQ3hQQjBhYXBVaEZi?=
 =?utf-8?B?QmVERW9tUmE4TlY5KzlTc3NIbHEzQS9CU3dFOE5WQ1RuLzZlakZrZmYzL0xP?=
 =?utf-8?B?RklSdTRZNHJKcFJrZVNxT3BCY1hWSTMzbk44dGFGSHNmMmkxcTF3Y09XRm1s?=
 =?utf-8?B?OWFYbE9sY3YwRGs4K0hQaHpZc09BQ2dCaHV3SDUyRWRvaEVQYVZmOHk2Zmdu?=
 =?utf-8?B?YUZ0cU9SZjVUZkd6UHFBMFRQYUwrb2tEQStnNWJOcHM4WlZqeXREZXFwM0hv?=
 =?utf-8?B?OFFScVhKNHpRMDFKQXpkUWorWURxNERBeTJBTldpZ3dPT0hoQ2g3Tk5aS1RK?=
 =?utf-8?B?b05IVEdwNzVKVWtHbGFUNm9iVHlMZ2lPRXIrV3oyc1N3Yy9TR2l2bmxYOFRE?=
 =?utf-8?Q?E7mYw7KE3W8agDePCW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28501bed-ce8c-405f-3280-08dec2e8b370
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 09:56:23.6039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4+rXhUFKIhK/tJRopBP/oVFdsTzrIIw6sjLwK7IR/Xyw4GcvywLRxN6p+F3kQlT8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

On 6/4/26 13:32, Matthew Auld wrote:
> On 04/06/2026 12:14, Thomas Hellström wrote:
>> Hi,
>>
>> On Thu, 2026-06-04 at 04:54 +0000, Gote, Nitin R wrote:
>>> Hi,
>>>
>>>> -----Original Message-----
>>>> From: Intel-xe <intel-xe-bounces@lists.freedesktop.org> On Behalf
>>>> Of Gote, Nitin
>>>> R
>>>> Sent: Monday, June 1, 2026 8:57 PM
>>>> To: Christian König <christian.koenig@amd.com>; Auld, Matthew
>>>> <matthew.auld@intel.com>; intel-xe@lists.freedesktop.org; Christian
>>>> König
>>>> <ckoenig.leichtzumerken@gmail.com>
>>>> Cc: stable@vger.kernel.org; Thomas Hellstrom
>>>> <thomas.hellstrom@linux.intel.com>; Brost, Matthew
>>>> <matthew.brost@intel.com>; Prosyak, Vitaly <Vitaly.Prosyak@amd.com>
>>>> Subject: RE: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on
>>>> attach failure
>>>>
>>>> Hi Christian,
>>>>
>>>>> -----Original Message-----
>>>>> From: Christian König <christian.koenig@amd.com>
>>>>> Sent: Monday, June 1, 2026 5:47 PM
>>>>> To: Auld, Matthew <matthew.auld@intel.com>; Gote, Nitin R
>>>>> <nitin.r.gote@intel.com>; intel-xe@lists.freedesktop.org;
>>>>> Christian
>>>>> König <ckoenig.leichtzumerken@gmail.com>
>>>>> Cc: stable@vger.kernel.org; Thomas Hellstrom
>>>>> <thomas.hellstrom@linux.intel.com>; Brost, Matthew
>>>>> <matthew.brost@intel.com>; Prosyak, Vitaly
>>>>> <Vitaly.Prosyak@amd.com>
>>>>> Subject: Re: [PATCH] drm/xe: Fix UAF in xe_gem_prime_import() on
>>>>> attach failure
>>>>>
>>>>> On 6/1/26 14:01, Matthew Auld wrote:
>>>>>> On 01/06/2026 12:39, Christian König wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 6/1/26 12:46, Matthew Auld wrote:
>>>>>>>> On 01/06/2026 11:15, Nitin Gote wrote:
>>>>>>>>> xe_dma_buf_create_obj() creates the importer BO with obj-
>>>>>>>>>> resv
>>>>>>>>> pointing at the exporter's dma_buf->resv. When
>>>>>>>>> dma_buf_dynamic_attach() fails, no dma_buf reference is
>>>>>>>>> held so
>>>>>>>>> the exporter can be freed immediately. Since
>>>>>>>>> ttm_bo_release() now
>>>>>>>>> always defers cleanup for ttm_bo_type_sg BOs to the TTM
>>>>>>>>> workqueue, the worker later calls
>>>>>>>>> dma_resv_lock() on the already-freed exporter resv,
>>>>>>>>> causing a UAF.
>>>>>>>>>
>>>>>>>>> Reset obj->resv to the BO's private _resv before calling
>>>>>>>>> xe_bo_put() in the error path. The BO is not yet
>>>>>>>>> published
>>>>>>>>> (attach
>>>>>>>>> failed) and carries no fences, so the switch is safe.
>>>>>>>>>
>>>>>>>>> Observed with igt@xe_live_ktest@xe_dma_buf_kunit on BMG
>>>>>>>>> (QEMU):
>>>>>>>>>
>>>>>>>>>      Oops: general protection fault, probably for non-
>>>>>>>>> canonical
>>>>>>>>> address 0x6b6b6b6b6b6b6b9c
>>>>>>>>>      Workqueue: ttm ttm_bo_delayed_delete [ttm]
>>>>>>>>>      RIP: 0010:mutex_can_spin_on_owner+0x3f/0xc0
>>>>>>>>>      Call Trace:
>>>>>>>>>       <TASK>
>>>>>>>>>       ? __ww_mutex_lock.constprop.0+0x2dd/0x18e0
>>>>>>>>>       ? ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>>>>>>       ww_mutex_lock+0x3c/0xb0
>>>>>>>>>       ttm_bo_delayed_delete+0x41/0xc0 [ttm]
>>>>>>>>>       process_one_work+0x239/0x740
>>>>>>>>>       worker_thread+0x200/0x3f0
>>>>>>>>>       kthread+0x10d/0x150
>>>>>>>>>       ret_from_fork+0x3bd/0x470
>>>>>>>>>       ret_from_fork_asm+0x1a/0x30
>>>>>>>>>       </TASK>
>>>>>>>>>
>>>>>>>>> Closes:
>>>>>>>>> https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8023
>>>>>>>>> Fixes: d99fbd9aab62 ("drm/ttm: Always take the bo delayed
>>>>>>>>> cleanup
>>>>>>>>> path for imported bos")
>>>>>>>>> Cc: stable@vger.kernel.org # v6.8+
>>>>>>>>> Cc: Thomas Hellstrom <thomas.hellstrom@linux.intel.com>
>>>>>>>>> Cc: Matthew Brost <matthew.brost@intel.com>
>>>>>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>>>>>> Signed-off-by: Nitin Gote <nitin.r.gote@intel.com>
>>>>>>>>> ---
>>>>>>>>>     drivers/gpu/drm/xe/xe_dma_buf.c | 8 ++++++++
>>>>>>>>>     1 file changed, 8 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>> b/drivers/gpu/drm/xe/xe_dma_buf.c index
>>>>>>>>> 8a920e58245c..6d944bd4065c
>>>>>>>>> 100644
>>>>>>>>> --- a/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>> +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
>>>>>>>>> @@ -384,6 +384,14 @@ struct drm_gem_object
>>>>>>>>> *xe_gem_prime_import(struct drm_device *dev,
>>>>>>>>>           attach = dma_buf_dynamic_attach(dma_buf, dev-
>>>>>>>>>> dev,
>>>>>>>>> attach_ops, obj);
>>>>>>>>>         if (IS_ERR(attach)) {
>>>>>>>>> +        /*
>>>>>>>>> +         * The BO was created with resv = dma_buf->resv
>>>>>>>>> +(exporter's
>>>>>>>>> +         * resv). Since attach failed, no dma_buf
>>>>>>>>> reference is
>>>>>>>>> +held and
>>>>>>>>> +         * the exporter may be freed before TTM's
>>>>>>>>> delayed_delete
>>>>>>>>> +worker
>>>>>>>>> +         * runs. Switch to the BO's own resv to prevent
>>>>>>>>> a UAF
>>>>>>>>> +when
>>>>>>>>> +         * ttm_bo_delayed_delete() tries to lock the
>>>>>>>>> stale pointer.
>>>>>>>>> +         */
>>>>>>>>> +        obj->resv = &obj->_resv;
>>>>>>>>
>>>>>>>> +Christian, does amdgpu not have the type of same issue
>>>>>>>> here? Also
>>>>>>>> +any
>>>>> thoughts here?
>>>>>>>
>>>>>>> Oh, good catch. Yeah I think we have the same problem on
>>>>>>> amdgpu as well.
>>>>>>
>>>>>> Maybe dumb question, but why does the
>>>>>> ttm_bo_individualize_resv()
>>>>>> skip the
>>>>> final switch of the resv for type_sg?
>>>>>
>>>>> Because we need the original resv object for cleaning up the
>>>>> mapping
>>>>> should the initial attach and then map have succeed.
>>>>>
>>>>>> It goes through the trouble of copying the fences across?
>>>>>
>>>>> Because we need to know when the import can be cleaned up.
>>>>>
>>>>> In other words TTM takes a copy of the current fences and only
>>>>> unmap,
>>>>> detach and then do the final cleanup after we are sure that the
>>>>> set of
>>>>> fences which was active on destruction is now signaled.
>>>>>
>>>>> If new fences are added to the resv object (maybe by the exporter
>>>>> itself or other
>>>>> importers) after our reference count got down to zero then we
>>>>> don't
>>>>> care about that.
>>>>>> If we do need to handle this here, do we also need to grab the
>>>>>> lru
>>>>>> lock, like we
>>>>> do in ttm_bo_individualize_resv() when doing the swap?
>>>>>
>>>>> Good question, of hand I would say yes but I clearly need to
>>>>> check the
>>>>> source code as well.
>>>>>
>>>>> Might be better to switch the type of the BO on error so that the
>>>>> normal cleanup will just switch over to the local dma_resv
>>>>> object.
>>>>>
>>>>
>>>> -               obj->resv = &obj->_resv;
>>>> +               gem_to_xe_bo(obj)->ttm.type = ttm_bo_type_kernel;
>>>>
>>>> Switching the type to ttm_bo_type_kernel lets
>>>> ttm_bo_individualize_resv() swap
>>>> resv to the BO's private _resv under lru_lock, which prevents UAF
>>>> without
>>>> needing any manual locking.
>>
>> The lru lock is IIRC only needed and safe when the ttm refcount is zero
>> (in the TTM destruction path) to protect against a racing LRU walk
>> trylock succeeds against the incorrect resv.
>>
>> I wonder whether this was actually why xe code initially took care not
>> to publish the bo on the LRUs until the attachment succeeded.
>>
>> A TTM LRU walker may pick up the exporting resv as soon as the resource
>> is published on the LRU, and then try to lock it using
>> ttm_lru_walk_ticketlock(). The lru lock doesn't protect against that.
>>   So we have a sort of moment22, since with that approach move_notify()
>> could be called without the bo being fully initialized.
>>
>> One way to move forward would perhaps be to, for now, reinstate that
>> and have move_notify check if the bo is a stub or fully initialized
>> before doing anything.
>>
>> Also perhaps we should in the future consider allowing dma-buf
>> attachment removal under a separate lower-level lock than the resv.
> 
> Is it plausible to check for drm_gem_is_imported() in ttm_bo_individualize_resv()? If sg && !imported then it should be safe to swap out the resv?

That's also a solution which came to my mind. We should probably completely stop checking for ttm_bo_type_sg there.

Regards,
Christian.

> 
>>
>> Thanks,
>> Thomas
>>
>>
>>>
>>> Checked all bo->type readers (xe_evict_flags(), xe_bo_move(),
>>> xe_bo_can_migrate()) and found they can be called concurrently by the
>>> shrinker or eviction paths without any synchronization, making the
>>> bo->type change unsafe.
>>>
>>> Switching resv to &obj->_resv under lru_lock, mirroring
>>> ttm_bo_individualize_resv(), is the more reasonable.
>>> I'll send this as v2, along with a separate patch fixing the same
>>> issue in amdgpu.
>>>
>>> - Nitin
>>>
>>>>> Since we don't need the original dma_resv for the cleanup that
>>>>> should work
>>>> fine.
>>>>>
>>>>>> Ideally xe and amdgpu can just have identical solutions here.
>>>>>
>>>>> Yeah completely agree.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>>>
>>>>>>> How the heck did you found that? Do we have a dummy driver
>>>>>>> (VGEM?)
>>>>>>> which
>>>>> could be made to always fail attachment for a test case?
>>>>
>>>> The bug was found via the existing KUnit test (xe_dma_buf_kunit),
>>>> which was
>>>> failing on a BMG VM device. The test runs 20 parameter
>>>> combinations.
>>>> the failing ones use force_different_devices=true +
>>>> mem_mask=XE_BO_FLAG_VRAM0 + nop2p_attach_ops, where
>>>> dma_buf_dynamic_attach() returns -EOPNOTSUPP, hitting the error
>>>> path.
>>>>
>>>> On bare metal BMG the race window is too narrow to hit the issue.
>>>> To make it
>>>> more deterministic, added a small msleep(100) in
>>>> ttm_bo_delayed_delete() just
>>>> before the dma_resv_lock() call, which widened the race window.
>>>> With KASAN enabled, that gave a clear slab-use-after-free in
>>>> __ww_mutex_lock
>>>> — the 0x6b6b6b6b SLUB poison pattern in the faulting address
>>>> confirmed the
>>>> UAF.
>>>>
>>>> Thanks,
>>>> Nitin
>>>>
>>>>>>>
>>>>>>> @Vitaly can you take a look and try to come up with a test
>>>>>>> case for that?
>>>>> Thanks in advance.
>>>>>>>
>>>>>>> Thanks for the notice,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>
>>>>>>>>>             xe_bo_put(gem_to_xe_bo(obj));
>>>>>>>>>             return ERR_CAST(attach);
>>>>>>>>>         }
>>>>>>>>
>>>>>>>
>>>>>>
> 

