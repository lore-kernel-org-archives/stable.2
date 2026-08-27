Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011059.outbound.protection.outlook.com [52.101.57.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA33470128;
	Thu, 27 Aug 2026 15:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845910; cv=fail; b=ibs28JU4rIClADLL6mCyUWByyMwn5Rge6aq5SPb2Nug3ZNYjs9eooB/AwjsCn529jzBg3/0A5O3AyxuR6GBpSZc9rg6vZCjwDjNupRyh60B2AmaKqYAhEC4j6pPu+p2ZOIBDLtr8PvkJmp4+WKBJY0vUoyGy8HqnBgEfJ6tnY5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845910; c=relaxed/simple;
	bh=IEy0LR4QA+EFu1WXI26DY6kC6ZJ2Gx54GUBrnefQopw=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=M545DSn720o1bAqArKC9ciPeRXZ2vBDZyuKMHVE+VivSuVa/3pTnsPyKDuznbUB7fwfYhOOfeQe7noZ/I/jC5z69cIrQbcuo3p/eTFAIIurTGqVr+IIFKj/F8/2RSzgVHjn4rw1x4td3LhSx6jPZ+lB3X4qUk3VeB3iVICwKap0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K5vpZmT/; arc=fail smtp.client-ip=52.101.57.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K5vpZmT/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bx/XqXh90P6Y02G8BeCrtNciQMS20xhj82XVxxPD0LF7hWM4LAB7hV2RMDopC9iLuZphkmNjoUynah+apGYG/cfvwmjyiAWuvPc+Qx3hj8JHWfEdn6QtT+IiPpnJWx0GBfwFnoS52BlCOh2zIj5Aqqcx576wkf6oZAj0udcmmIdf2Oteh+WY7dMRYqLV0KLV6jcNYsUIr2f8Y/9KIPbpFxPxNN4NBn16BA7Y9HPvZpNvVEIEtTfozLaeXcatFN5AVE3QUhf8deHxJgGi3ATrpZaNQ4zf18u1EZxz29pKHCJBDY13xcA20Lc/4sGJPor2NJmbQPkrEkAw+PFBRy+jRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqM/D11UhKb56tMg8U/tR/GyGoVA3HWgIT4/kY9fQM0=;
 b=XFhcjTUjYtFRvOXOHmu3iIo/QfnDybQE0+Sm691YF99Jx0BYq0jNZnV3fes87Phzd2uWpGORPdDLoLnhHe7LnlbADlFZ312scw7Dfj46xCFgkS4w83GuQfsI/Q/2gv7CEfmH7TRw4t5gFL8xushXTeK4qjG+iKAiPEk4ASLxkkdR0esWqSfmtyfOG69z1gaHY8QYFksvcpixP/8FESDenyASs7pVbMWq+uyGMOh9dkSk103FJDsGvAidtiluponKpT/sM0RgfEpI8R3Oa17cSGQ/LqfqaoqcDlyipFZnMK56y0oHu7HaeT1IvwHNGjHgmpK1GLyCsaDmd9TswwPdSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqM/D11UhKb56tMg8U/tR/GyGoVA3HWgIT4/kY9fQM0=;
 b=K5vpZmT/vOGCuvahSUCjLNQC+YPrtFJEu57xC86MFqXPEWSqncGivzUFKxdie8lPwFs2Ax/IskCGwIcvECBZE2hDxZAFKumUvwx9FCpyUxYc+BPS17vvMJ/I+7ZES9OdOu0qImH4bsdEGKj020joI/Dx6DKTMV0GOUfScinX41iTqXANLP/HKoxFrTM0ql1fcFRUYDzJMY0hZNmKHP7ygopCjAmsBLG3k2JxMH6Z5qplovoKPe3XnNpbUaqZ3NmL0wriE+64+TfzkJrjSj+AAY7k9i/qfoXEMi4R4VoM/JrGiLTgqtXUfc4y3niSxpsXuCo71FQagQV95Vela/MuFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA0PR12MB8374.namprd12.prod.outlook.com (2603:10b6:208:40e::7)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 15:51:45 +0000
Received: from IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16]) by IA0PR12MB8374.namprd12.prod.outlook.com
 ([fe80::d85f:4c87:ae84:3f16%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 15:51:45 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Aug 2026 11:51:44 -0400
Message-Id: <DKZUH9SFMP6H.1ZMKA92IHQLG2@nvidia.com>
Cc: "Andrew Morton" <akpm@linux-foundation.org>, "Hao Li"
 <hao.li@linux.dev>, "Christoph Lameter" <cl@gentwo.org>, "David Rientjes"
 <rientjes@google.com>, "Roman Gushchin" <roman.gushchin@linux.dev>, "Alan
 Stern" <stern@rowland.harvard.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
 <syzbot+805630f1453e490427fa@syzkaller.appspotmail.com>,
 <stable@vger.kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, "Harry Yoo"
 <harry@kernel.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH] mm/slab: reject unsupported kmalloc sizes
X-Mailer: aerc 0.22.0
References: <20260817-limit_kmalloc_size-v1-1-5bef487701cc@nvidia.com>
 <82f138f5-11d4-4839-94a3-c226fd982715@kernel.org>
 <ao9dPUpHxP5uOOcw@MacBook-Air.tail10959e.ts.net>
 <DKZ7J9HNUDR6.BP9KG5Q7HYMJ@nvidia.com>
 <c4684212-f44a-4aff-a02d-f3f26095ebc1@kernel.org>
In-Reply-To: <c4684212-f44a-4aff-a02d-f3f26095ebc1@kernel.org>
X-ClientProxiedBy: YQBPR0101CA0306.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6d::28) To IA0PR12MB8374.namprd12.prod.outlook.com
 (2603:10b6:208:40e::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR12MB8374:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ecca88-b8d1-4ebb-8be0-08df045318cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2DpfGAQWnMJRYBoZq4Csf2imxnc3W4t267WmqNnjQLs398l4klfM/IF4oZXwFOgPBn40hXxfKKeEzvA+yzfe1saOYHnpgXhCD+iDJL5PjWce4vpbDv6pAINOmylVvyRaN+QqIoWPmfRNu7pHUY47nOwTJsbE3D11ZMM0kgxH3QDAUmOPGpf5Dm35xuUub41dHDSsP11naslTtmnnnm1KpQAITkktDv3HnlE311qTfwABWSvPmMKmBnvAM7iWuSuNofV+mnZ1rPUguJdnQbfcYAKS/I5xaxQWmFaZVLqqGkZ8aTzug6sNGlynTPyDOeF5EkA9c2df8VcCZYaTx1YxbOuL5tZ0+5QaGu+DbhzMQIMzKe198Wec3KkfhWmBACcvMH8Q6P9BwqUEXe3er4uCbhge9C8XDNoDI0/2LOgMF8wWRGgotw1AN09YdAuaVFIleXBD5mNVc5op1zUxcDPVB/99UHa14K+QhnSZLypvayoQiw2WWfvY9f5RaJouQQX4lLZzO1D7bVWwCMkbXRJ3l5HL7MeKtbCgJT71hVZhWA+1GlRTcuKM79frCJVot399jHvBB+ZCWUG7QA4FugMQUBCLkGmxW3qVeJqma7jTBZyb9Vv+Vn06m1u1MffFJdvRqQbS4qrRYOOzN8zjgr4JNh9JaB+kW+eD8Mz/OuM5BiM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8374.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzVZaWptMnpjUWxhVWFldnh6NGNOMEFVRFd5bDVYdU5KZ1NjeHgvZjVzTC9t?=
 =?utf-8?B?aG93ck8rbzdpMXVQQVQ2UnJtWlpVd0ZkRCsrTUY0M09lS2d3eGkrbG5aZm5a?=
 =?utf-8?B?alVxZzNRRU9Xa1ZNRG9wZWJrTFowb09Pc2U2V3pnenNwSEF6c2FjWnlkVWVt?=
 =?utf-8?B?dm53blE3Tnlsc1FjbzdsaTVHRTAwN1dBWGM5MHZWeWNCdldrdGp2UmlzOUJS?=
 =?utf-8?B?di9aNHRIcnluVUo2bTdQZHQ0QUw1ZU1oaW1lM08wM0lPaWVaVlcvb2dYRmxx?=
 =?utf-8?B?cGNRZVZhN3BGYzNxaU9zN3ZWeXgzaytEMFJSa2JlaE9OOFY4cCsrMmw5QlZY?=
 =?utf-8?B?MG9pd0pKdG9sZzdBWSsybnhBMGlGV05EOWJDMXdzQUErVHBtL0lYeW5pMXlS?=
 =?utf-8?B?NjlvZUlCTjZrMDdEc1FCYzZ6dTZPdFdXN1YzVW92TG13MUg0RjdBNFZacnNu?=
 =?utf-8?B?YjlSMjNyZnJTbnIrL0FVQjFUamlNbW1kcy9SNm1WaVRDV0VqRHJKeTBVemhx?=
 =?utf-8?B?THd6YUZvdVNWT0FMTHRiZk9iZ2haOUlXRGtpZHgxL2pGbkF1VUVCQ2toSXNS?=
 =?utf-8?B?WGFkblhQMWpGQXdRdVIrczB4cXYrbHBCdkxPVVo3SllLSzQ4aU4vbnlVWjFr?=
 =?utf-8?B?UCtWdkd3cjZUa3MyU0ovUEQ3Wlk4em9XMTE2eUFnOGlkWU5LS2R4VTdrcHlJ?=
 =?utf-8?B?b1pPN24xSzhOMHBVWlRONEljZzU4RzRqQTgwMEtnZ0txQlAyc3ppTFpIU3di?=
 =?utf-8?B?aHdJVDZOMUxHaUhnMGdoclBEZGszZ2hhMXRvRVNJa0VWdlNMZ25IUzZndHV0?=
 =?utf-8?B?OEJuZGRmWjVVcGpHeFZpeXJDbmh3Zk16R3NxK05PendQVlFIYTRUNkl4YTNm?=
 =?utf-8?B?SWNtWXI0NlhkZFk3bEQ4R0FlUnNwMUpwVXMxTUdaeWhEVlFYVEswaTlBMHU3?=
 =?utf-8?B?bkIzRzBVclFlQnpJR1B6NmZvTFM0TXdEVjUxZk5naGhEcTQwYk40RWQvNjVH?=
 =?utf-8?B?UEtrRlk1MWxIZGg3TkxHQS9FVkhKakZnamhJTUM1OHV3OW9IQ1NoVUVad0ov?=
 =?utf-8?B?cUFYMHQ4U1laSGJEQzRqRDZqVDR5Z2FGWTNHcHRLSmdjWVA3U1ZvdVZaa2N4?=
 =?utf-8?B?VVNLN1l3OUtXMERQTWYwcHE4V2lBeThsWXVKalV4S1diMDF2VFB3bFczVEs3?=
 =?utf-8?B?Q1ZabUYrYnZ3Y3E0eDgybUx5V0pjQ25keDg4ZHhUTGVRYUFjQ3VKdlZ0ZVRT?=
 =?utf-8?B?TEc2SWlyWEZYVlZ0ZlFNN25oVFRqVWszVzUzTDFXZXpjaVhzdTE1R2ltUlpn?=
 =?utf-8?B?WStYdjVMc2NvbjZpakMwWmJUYjk5SVl5Q2xEeXdXYUdCdVN3ait3WUR6MW00?=
 =?utf-8?B?MUJaTU5ybU5SaTRVMkF2YXF5ejZtMWdqL1pTM0xhcG1YZ0ZMQzNkYWpmaVFB?=
 =?utf-8?B?dkhlaW56YlVOQ3BiRXdiOWdKemYwcmFCWUtIaHlveUY4ZG1nMVdCN1RvbjBM?=
 =?utf-8?B?WkY5MWtoWUI3MkdMSUkwNkw5VHFPNmZrRFNHcEJ4b0lwRFpFbWV4a2RtbjIw?=
 =?utf-8?B?eUs1d1RMUmJSK1VtamJSMEt6Qll0YTRWK2NqTG9OUllnSDAvMmx1OEdUUmlR?=
 =?utf-8?B?QVRBc3dhR3dNL0xnZG9tMXNoZDliMGsyZ2JyVm5yMCtaMWttTHdDdzZpU1NL?=
 =?utf-8?B?N1JkOGpEdVpqRVZKejhMcFZiMGlLMFZQN1g0aEdXQTc4NUMrYTBEemFWMXZZ?=
 =?utf-8?B?SUp1bWx6SDNZajBQWnpZcnQwUDBUSm9pMUlRNlpNb0l1K045RXQ3aVhyVnJw?=
 =?utf-8?B?M0p6WFRTajVyb1pYRVJXZW9DQ0NaazVrRTQyREM2RHZtd3RmbTE4WWRSVXQ0?=
 =?utf-8?B?Nml1L3ZBTHh2L2FHcXVtRkhFNjI3QzQyRGpDNkJjM1ZOQnA2ODdURnEzTXNw?=
 =?utf-8?B?TFZUS3o2SVAyK0hlRXhNbEF4dGZlQTdkQVo2ZUZMYmp6eUJjSUd0bmxiMkY5?=
 =?utf-8?B?SDJwTnlLQkF6OW5ZaWtLOW5CSUhJWGRKL3N4TDVmdmd4YWUwQ0hnMHVxZTkx?=
 =?utf-8?B?eDNqTGU3NnZlRXUwZ0sxbmVxRG96U3JaNlM1emZkTWYxUGEycTRiRVE5STlL?=
 =?utf-8?B?c09Va3RBN2hOOHRudDRMRWViemZjRTQ1cXZDMUNZTEpaeEZ6NG1rUzZHZC9Y?=
 =?utf-8?B?VkdlQkF4SFRPU05vUFBOL3RjVW55bWtYSXN3bzYrK2hhRjFxeW1ITW9seFZU?=
 =?utf-8?B?dkZKcldKTDhvd3lVRVdZM09CUXpYY1QzZ2pTQXAydllyNGxkUE1JUktwdHhk?=
 =?utf-8?Q?WRokZY+y6GDukBWO7K?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ecca88-b8d1-4ebb-8be0-08df045318cc
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8374.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 15:51:45.5726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKnrEsQUXWMtJuN+0UjVblrb8m1dH48Fv1qNRM1CLEq5hnmoNNaUjrPO9kAcd282
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On Thu Aug 27, 2026 at 3:47 AM EDT, Vlastimil Babka (SUSE) wrote:
> On 8/26/26 11:52 PM, Zi Yan wrote:
>> On Wed Aug 26, 2026 at 5:47 PM EDT, Harry Yoo wrote:
>>> On Wed, Aug 26, 2026 at 11:28:12AM +0000, Vlastimil Babka (SUSE) wrote:
>>>> On 8/17/26 22:40, Zi Yan wrote:
>>>>> kmalloc is used to allocate physically contiguous memory for kernel
>>>>> allocations. For requests larger than KMALLOC_MAX_CACHE_SIZE, kmalloc=
 uses
>>>>> the page allocator and can only support up to KMALLOC_MAX_SIZE. For r=
equest
>>>>> sizes bigger than KMALLOC_MAX_SIZE, the page allocator can emit a WAR=
N
>>>>> because kmalloc allocates an order greater than MAX_PAGE_ORDER. Syste=
ms
>>>>> with panic_on_warn=3D1 crash because of this WARN. Fix it by rejectin=
g any
>>>>> kmalloc size bigger than KMALLOC_MAX_SIZE.
>>>>>
>>>>> Fixes: aadb4bc4a1f9 ("SLUB: direct pass through of page size or highe=
r kmalloc requests")
>>>>> Reported-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>>>>> Closes: https://lore.kernel.org/all/6a820ebc.9ebadd4d.20b15e.001b.GAE=
@google.com/
>>>>> Tested-by: syzbot+805630f1453e490427fa@syzkaller.appspotmail.com
>>>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>>>> Cc: stable@vger.kernel.org
>>>>> ---
>>>>> It fixes a page allocator warning (order > MAX_PAGE_ORDER) when gadge=
tfs
>>>>> requests excessively large memory from kmalloc. Instead of adding
>>>>> __GFP_NOWARN to suppress the warning, as was done for usbfs[1], chang=
e
>>>>> kmalloc to return NULL without a warning for this specific issue.
>>>>>
>>>>> [1] commit 4f2629ea67e72 ("USB: usbfs: Don't WARN about excessively l=
arge memory allocations")
>>>>
>>>> So I checked and for kvmalloc() we have in __kvmalloc_node_noprof()
>>>>
>>>>         /* Don't even allow crazy sizes */
>>>>         if (unlikely(size > INT_MAX)) {
>>>>                 WARN_ON_ONCE(!(flags & __GFP_NOWARN));
>>>>                 return NULL;
>>>>         }
>>>>
>>>> This comes from Linus in commit 7661809d493b4. I'd do the same thing h=
ere
>>>> then.
>>>
>>> But the purpose of this patch is to avoid the warning in the page
>>> allocator. Should we fix this in the caller (gadgetfs) then?=20
>>=20
>> It is fixed by: https://lore.kernel.org/all/20260820223719.A4A3C1F000E9@=
smtp.kernel.org/
>>=20
>> Please disregard this patch, but we can keep the discussion going.
>
> I still think this patch has some value if done as proposed above. Yes
> in practice it will just replace the page allocator's warning with a
> different warning, but IMHO it's "nicer" if kmalloc() sanitizes its own

And SLAB maintainers will be Cc'd. :)

> requests to the page allocator, using the KMALLOC_MAX_SIZE value.

Like this? Or the exact pattern as kvmalloc() is preferred?


diff --git a/mm/slub.c b/mm/slub.c
index 0337e60db5ace..b562f2a6fbbee 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -5263,7 +5263,12 @@ static void *___kmalloc_large_node(size_t size, gfp_=
t flags, int node)
 {
 	struct page *page;
 	void *ptr =3D NULL;
-	unsigned int order =3D get_order(size);
+	unsigned int order;
+
+	if (WARN_ON_ONCE_GFP(size > KMALLOC_MAX_SIZE, flags))
+		return NULL;
+
+	order =3D get_order(size);
=20
 	if (unlikely(flags & GFP_SLAB_BUG_MASK))
 		flags =3D kmalloc_fix_flags(flags);


--=20
Best Regards,
Yan, Zi

