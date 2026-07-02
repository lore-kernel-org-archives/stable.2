Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011023.outbound.protection.outlook.com [40.107.208.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08B03A75B6;
	Thu,  2 Jul 2026 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032396; cv=fail; b=mou9ofxSfomkkd+EFPv4HXW7fIqljlxrgPQEckkPLVUmdkGNkn7BoWxmuhSBoUpHyUkR/9bCDqmbZNQGUil0VsiwUrLS8Yi/6wULfPkILwUukxBE2udCUVpz1xlEG3THtjG4ngfGeo3WfOojSuku3+nm2ivuOyRWqeV/nEA59e0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032396; c=relaxed/simple;
	bh=XSFRlWFMe/rr9h9JOEyx/AA/qsBuTrBWO7JLfQCmiHI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlJcjmtMuwMJ9wlDt6C7q0kXu5ARQ823lOAHbyDVAj0OcE7JWi3dHu+AV4mxbovIhRJZzE0SCutOXgowiWoVaOjJWpksDkttMBS1FHTZ0DxUpPNsMhI8FAuYY5NkHs1iFl+0FnYVnkHhBqxGte+Oc6cfEx/AVmjAJ938rezOwt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WIykmeWL; arc=fail smtp.client-ip=40.107.208.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WIykmeWL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mFBrbhzm3Lmd33S63qUKo62KlY6PctrI9zGeo28e7QVRB3yXHIQKuSqRiibavZ76kBr5NIJvQdB/cCq/LV9y2PBAi/zzlY8axbZXeCxaeFHexkYsW1Vl5EtOs7oX7XSazMR0x25eiY5veO90mws7G+tsGpnISyzaIRSDfwv0WHCqVAqp5LhtkSwbRRHvnNz1SaxsYfkl6km9IIMc2l8nDarm/xCovYGGgWz8ufZ5fA3k0slHuUKzF1aiHfXU+f1bMQuLL+MFKl+llmcyriAAdZzyUX354sRpNHBIpCLjY706kzQxGIpSMUizlX8f86BxU7E8lUjcnwzADMB1VOv7NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kuqGSuteo9cyCm3zEcNY0Y8Qu+jtc+fdBCC/c39Yu48=;
 b=iMdiszQK+8Q2vJir11M3qMKsSbhkxKDDUoOD0Ehv1hyPikWLOAvcy3mGxi95xH3pRy8kdkuwDdshtpQtTGVQbK6fsbz6zoC7zoiRSFm3iGv4hJB9QldQSM7jkWYrMvjYg7VAcsjCs+IFIVvz64YmhZ8cCz/FJZ+rJUERjn4ZrhmLEYlQUbMFfeidB+lC44WkyDfblfhG7vfibD/TM97IOG1dr9vV7YHtABUPpmGm7P/BgwkM3cCSOmu7IoA8nlfQxiJIgu0KkeKzP22dOf3iFeoCRWocnBw1N9AxaEJaVOriv9h94vDvX5WOJhn0SAy0lL3ntezzmUQOorp6d5IndA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kuqGSuteo9cyCm3zEcNY0Y8Qu+jtc+fdBCC/c39Yu48=;
 b=WIykmeWLZN0paTI1RBWD2mdDubrn9y5gqerbfDuJCNBayFVsNBzmVVLx4Ltk5l6XyiEY42YWLoyTOGiDIjis2jh1wqn2Of5FcO0z+8MC9RHZP+/ZbS3re5oxoArz/kzka1xdNvTjDTK63eUzeB6K9agd2f+leiTBQbnOa4k1hc6g/oQKGmr2sQqWmSKVk1e9JHTVIGwocVd/4Sp0htPeLaBdYlBCu/VMA7sPuTsXaG4J+YMrqIWTi8EcN3YTIXQQZW822fYnfZagoEBiAax+nlgGfmPDbKlQ26KXH6NmzqxTV5cKEcOAiqaI1aH7JzrPewUdU7r8/ZI8BVwIoaWneA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 2 Jul 2026
 22:46:30 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.21.0181.009; Thu, 2 Jul 2026
 22:46:30 +0000
Message-ID: <b5d08cfe-aead-45f2-937d-6e9ef4dfea50@nvidia.com>
Date: Thu, 2 Jul 2026 12:46:26 -1000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/nouveau/gsp/r570: Never enter Gcoff state
To: Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@redhat.com>
Cc: Lyude Paul <lyude@redhat.com>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Timur Tabi <ttabi@nvidia.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Kees Cook <kees@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maxime Ripard <mripard@kernel.org>, Mel Henning <mhenning@darkrefraction.com>
References: <20260701182857.190713-1-lyude@redhat.com>
 <20260701182857.190713-3-lyude@redhat.com>
 <DJNNQVO96RR1.141CE7TKF6MZP@kernel.org>
 <CAMwc25qA6GFb1Q=VHTa8BcM85B2dr22RrgdJcHTz70P5Xjj_bA@mail.gmail.com>
 <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <DJNO6SIE8T88.1F0ZUILIRVDJC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0020.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::25) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 35a15242-7a76-4f56-cc43-08ded88bc1fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|5023799004|11063799006|4143699003|56012099006|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	J9PmG+Rj5p/dWsI43M8+DPwaVX3LJPDfG0TZQoSOV3DT+uo9GVAoypHT0/YxxUFERSBul4nLmzJQql8jFDXMZwAC1pYd6egaMK4zfp1ZIi6sT/+45c9EMTKZL1ZpvpfhgV8VfnGdsQGdEWpQBelgZEafceWr0H2OB6yus0iq37lz5AMDHJtpiWmU6nUy8Bzn/I+ZZqfrV/uwAeGoHZycxEd5Aepm6B696QN6fEmwc3RZrsfXoB5PRkL+nZ8+XyiaL+nTjvFlsQwlMzCmhEeGd9hByDvdDVOZybaAEyWbhSE2fOqkTy7bUOkpWeh4xf8ardDbMSTcHRsMEEdU3VGmAeiwZAFj+FRr/TeN9up8WzEKoUpyBaJh0j2xiztzDrV9Kx8mZ7LgDIztRk7hZKBJlhp59uh2QOQfIqcGPkCv97NtlidimVX1UorQjoaljlsnO2F5/ycpok8LX2VQ5dy0BOWXfYDfdSf9cligGG6p86t0vqwjQPFTsejCwmbuN+0xveMAGic+pD5E4hkGsVgivFq2QZ6Eyb/luPiF2dhIk2DT9yaWKSihbIKEsHtoMWGNwJDp9Q/URhNy+6s8u0aJh6jVJvDVTaNFArDw1V+eZ1WbwlzZUJn/GRRYKsEHVY35/Y0hVxoFibpP7f+z6t7tDbsTk/VwA18AQmaOPifaAcc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR12MB9416.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RFhNWHF2a2cvdEFiTS9iM1djWW1QeXpGUFg2b2x5cStoa0NGcStsNWp4VHA5?=
 =?utf-8?B?SXV5Z20yeFl3UkVFamRBZldOMldsT084dVNCL25jQW5CTGUra1NvYldmM3ow?=
 =?utf-8?B?ZDRoaVhIVm1ZOE5UVElETjc5OUxld3hIS2tzck5mWUpHWGRaYTg1cGJnVVdE?=
 =?utf-8?B?V3o1QjNhVWVEUEdhdVJzS3Flc2RkZVhCblRWaFZ3UzE3bVdUWUtMckM2OUhP?=
 =?utf-8?B?QmhEZjJ2UjNkdnIzdC82RHVETFFFTnp3cTZPbU5LMnMveldvei9hMUlodDZY?=
 =?utf-8?B?MGRwWi9QZll0eFdEODRmaEI1K1VGMjVPU3Irc2sxSlducWdQYWJvdXZsdkpY?=
 =?utf-8?B?K3dsK04weWNtUEtNd2dFcUdxQld6cDRHR1lkRHErSnNEL1BaYnEyM3AyWWs0?=
 =?utf-8?B?dHY4UmczWitKNitEbm1GQWZWeUVldDVvOTlnMFZBL0c1TmZlcGh3U1RLM2NZ?=
 =?utf-8?B?eDJpZHdnbmNmb2Y4MWM2cnowSWk3bzlJcHQ4ZmFwaVFpZTdWNkdUYk1hYmU4?=
 =?utf-8?B?RFJhNVcxRktQS1BRMmM3WXkzcGRhZTk1RUlGWTZrb0pmS0Y1dkw5dGxFd0hH?=
 =?utf-8?B?bEw0TWtod3czNnE4NEhPMmI0SktPTktlV3AxSG9KeG1rdGZmamFmNTRmMmRX?=
 =?utf-8?B?Z2FzR0w4NzZ0YlRaU0F3NDYvbUFiaWpmZU9CNzNtazNTbjRrZmp1VU15cWtu?=
 =?utf-8?B?OFRqNEZpZ1hmTjN4T1NzYkhhZFk2NkNwY1lsd3ZqTEc3Uk9hOG1pelMxY29N?=
 =?utf-8?B?WE91QWk1bERhdUtzbE5MdHhvMHp4dmxIa3VtbzdPQ3pmanJaQUtyZXM3SmJz?=
 =?utf-8?B?anM3dkVXVy9pRDVrTmljS2xSL2VuTkduTzZBZWJDVGRtV2MxTnRVTFJjaSto?=
 =?utf-8?B?QmZUL29VY3B1R2FmN0J0WXRCemJTQTJPNCtuSzRWcjhGVVovNi82MncvbG1N?=
 =?utf-8?B?VTI1UEcxTHBVVy94d3NZOVYyVVM2VTgwTWkySTdkZjYwU3RWZW41cnJpNTdF?=
 =?utf-8?B?UGpKT0RoNWNVbXdYSlhUVkpkMmdaYXpicTFHTmFNVHZtaXZYUytPaE1mMldz?=
 =?utf-8?B?QXYrNHppME95Mjh2bmNVdUd2MDRxM2RyMm9FVjZvZ2dWakpZNEs2YVFsZ2d6?=
 =?utf-8?B?SDRuWXNqeHVFTk1HMWNBaFV1SmZzUFZPaGZ2bVVFOS9acGpTY0g2NG8vUU9t?=
 =?utf-8?B?WEFraEtOMUtsOGhKa2ZKREtjZEQ5Q1BlQWNiYjNGaHZ0UVIzUm0xZmc4SmVv?=
 =?utf-8?B?b3M2ZFAwLzBHa2pxK3RuYkxyYkJWN2prVlorQlFJdldadE9iaWROak5icEU4?=
 =?utf-8?B?VUwxUE1rbDlkUU9DV0JCck5OUk1MWnRGNjFOVDBGNHQ0U1JpeGFUalVLYXd2?=
 =?utf-8?B?NHNqb3JXVXJURWlJQWxsSzIyNTNGUmJUa0hLMnk1cDYrZnJnaUhWbFk1WkFJ?=
 =?utf-8?B?OEtkZ1R6a3prMWMvd2RLNFIvd3FkTTJPaDhLMGhVaVRWck5uNThKTnFHamJv?=
 =?utf-8?B?aFF6ZTNlTGtrbElES005NHltYUhheDh1VTR1S0hCUEFiTDN6VXFPb3NMblFp?=
 =?utf-8?B?RXFZdmgwYU9LQTRtVUZ6QS8xQWd0RHJSWEVuWDFtc1VnVEtWOFBkeDhpWlpq?=
 =?utf-8?B?MVErdlVINDZoWXRQeGFhc0xIZjlLbEY1MEVBVk92Yk54NTc1SjJYSEVmNjQx?=
 =?utf-8?B?L0VFTXc5NmVWYTYvZmFTbEIyS1hMRnJ3RnIrdmFQRkh6RVVLM0Foa2dJcTNj?=
 =?utf-8?B?OW0wMnBXbkh5aU5WQ1VmdzJzQjMwSDdoNmowK0lXT0EvTVpwd21NZW95ajlE?=
 =?utf-8?B?K0NGWjdQc2tTRG5GMjg1QXdyOS8zS3FiTDNLbWhiTlRuVEVBYkduOGFWV0d2?=
 =?utf-8?B?TVdweG5wdS9Bak5ISjZRWVk2WmVYWlEzWnVGRkQ2emJaUUtnajBlczNreFBT?=
 =?utf-8?B?dS9OVUt6QVlkMUpkSGVGSmxaUFhPVHRlbXlZbTVuSlFCdEwyTGh0NVRKK2Fi?=
 =?utf-8?B?VVpkVC84YzdJUVcyVndMMGJpU1lPdCtnbHlPMHk3WXFjdEg5YnVKVFFGb2pu?=
 =?utf-8?B?bURlSXBnb2JuOGh1eGNtUk4xdEMzcnNyayt1TlJPQU90L2g2MXlpT3hNZDhq?=
 =?utf-8?B?TytUKzM5bVowK2RuRVZjWEJIUHpXWXNhb0pGdElQNVRSR1IraW5RS2tNcldZ?=
 =?utf-8?B?M1VoMjdMcUhvYnVqTEVDbTNtL0J1Q215eERQemNxWk1FZGNZbEx4R1RPTjZY?=
 =?utf-8?B?SE53VFc2VHFNMGowK0N2QUdhaXo3S3U5bGRLRkZ3TEVQY2FWczBwb0V0RE1M?=
 =?utf-8?B?U0JBUkF6NncySkZkREZoTEhVM3NlYnpDcUNoVHNJSHl4REVFcE9rQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35a15242-7a76-4f56-cc43-08ded88bc1fe
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2026 22:46:30.1950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DnipVT8qzJY6gI2998wryKsO6xInfARtjJBtCDbR+LkLIqA4Es8VnJiWwHJ+GkFWhsdHSx/7oZegwZCD5885Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139

On 7/1/26 2:47 PM, Danilo Krummrich wrote:
> On Thu Jul 2, 2026 at 2:30 AM CEST, David Airlie wrote:
>> On Thu, Jul 2, 2026 at 10:27 AM Danilo Krummrich <dakr@kernel.org> wrote:
>>>
>>> (Cc: John)


Also Cc: Aaron Plattner. I've provided answers below, but Aaron
has actual experience in debugging suspend-resume on our Linux
drivers.

These answers are the result of my moderately long session with
our best AI tools, using Open RM, GSP-RM, and Nouveau sources
as a reference. I'm not actually experienced in this suspend-resume
area, much, but this makes sense from what anecdotal things I've
seen before.

>>>
>>> On Wed Jul 1, 2026 at 8:17 PM CEST, Lyude Paul wrote:
>>>> It turns out that the only reason our previous fixes looked like they
>>>> worked for this was because we would occasionally set the Gcoff state to 0
>>>> in the normal S3 path, which fixed suspend/resume on desktops - but not on
>>>> machines using runtime suspend.
>>>>
>>>> The proper fix is to just never set this flag. Our current guess for the
>>>> reasoning behind this is that Gcoff likely coincides with GC6, and not
>>>> literally power off.
>>>
>>> I don't think GcOff coincides with GC6, it should actually be a power off.

You're right, it's the other way around from the commit message guess.
In the RM sources GC6 and GCOFF are two distinct GCx targets. GC6 keeps
video memory alive in self-refresh. GCOFF is a full power-off where
video memory content is lost, so RM copies the used framebuffer out to
sysmem before entering it, and it reports vidmem power as off while in
GCOFF. GCOFF is the power-off case, GC6 is not.

>>>
>>>  From a quick glance in OpenRM, it seems that with bEnteringGcoffState = 1 it
>>> also saves off buffers flagged as MEMDESC_FLAGS_LOST_ON_SUSPEND.

That matches what I see, and it's the key point. bEnteringGcoffState is
not a GC6-versus-off selector at the FBSR layer. It becomes the
PDB_PROP_GPU_GCOFF_STATE_ENTERING property on the RM side, and that
property widens the set of allocations RM saves and restores across
suspend (memmgrAddMemNodes, through its bSaveAllRmAllocations argument).

With it set:
   * RM reserved regions get saved, unless they are LOST_ON_SUSPEND.
   * RM channel-context and kernel-client buffers get saved even when
     they are LOST_ON_SUSPEND.

With it clear, the reserved regions are skipped and the channel and
kernel-client buffers are saved only when they are not LOST_ON_SUSPEND.
So =1 is a strict superset of =0, and it does include the
LOST_ON_SUSPEND buffers you found.

The part that matters for nouveau: in the full driver that property is
never just a standalone flag. RM sets it only when it has decided to do
a GCOFF as part of its own RTD3 policy, after it has reserved correctly
sized sysmem for the save and turned on comptag backing-store
preservation for the state unload and load. Setting the flag in the
FBSR init RPC on its own, the way nouveau does, gives GSP the wider save
and restore set without any of that surrounding GCOFF handling.

So I would adjust the guess slightly. It is not that nouveau never
saved those buffers or never had them. nouveau provides the sysmem and
GSP-RM does the copy into it. The problem is the reverse: with =1, GSP
saves and then restores buffers that were meant to be reinitialized on
resume, and it does so without the comptag and state-load handling a
real GCOFF pairs with them. So the accurate framing is "buffers that
should have been reinitialized get restored instead", not "buffers
nouveau never saved".

>>>
>>> My guess would be that with bEnteringGcoffState = 1, GSP's resume path expects
>>> certain kernel-driver-allocated buffers to still be in place that nouveau didn't
>>> save off, or rather never had in the first place.
>>>
>>> John, do you have some details about this?
>>>
>>
>> In nouveau we have the INST_SR_LOST target, for buffers that aren't
>> preserved, I wonder did something change between 535 and 570 around
>> what needs to be kept around.
> 
> The r535 code never set bEnteringGcoffState in the first place. In r535 OpenRM
> seems to do the exact same thing.

The set of buffers did not change. The FBSR client ABI did. In 535
nouveau enumerates the exact VRAM regions and sends them to RM one at a
time, and it never sets the gcoff field, so the flag is a no-op on 535.

In 570 nouveau passes RM a single sysmem buffer for the whole heap and
lets GSP build the region list itself, and the gcoff flag is the only
control nouveau has over which regions GSP picks. Forcing it to 0 makes
the 570 GSP-built set match what 535 effectively saved, which is why 535
looks like it does the same thing. So 0 is the right value for how
nouveau drives suspend today. RM derives this per transition from its
RTD3 policy, and 570 setting it to 1 was the deviation, not 0.

On patch 3 (the resume state flags), I looked at that as well, and here
is what the firmware actually does with it. In the 570 GSP firmware the
resume state load already runs with GPU_STATE_FLAGS_PRESERVING |
GPU_STATE_FLAGS_PM_TRANSITION. That is set unconditionally in the resume
path, and it is gated on the bInPMTransition field of the SR init
arguments, which nouveau already sets on resume. The firmware does not
derive those flags from srInitArguments.flags. That field is read in
only one place on the resume path, an unrelated display workaround gated
on the PM_SUSPEND bit. Neither 0 nor PRESERVING | PM_TRANSITION sets
that bit. And the value the open driver itself puts in that field on a
standby or RTD3 resume is GPU_STATE_FLAGS_PM_SUSPEND, which is a PM-type
indicator, not the state-load flags.

So from the 570 sources I do not see a path by which patch 3 changes
what the firmware does on resume. That points to patches 1 and 2, the
revert plus never entering the gcoff save path, as what actually fixes
the push-buffer timeouts. Your 100-cycle RTD3 result is consistent with
that: those two are what stop GSP from doing the wide GCOFF-style save
and restore.

I want to be clear about the limits of what I checked. I confirmed the
resume-side firmware behavior against the 570 release (latest) sources 
rather
than the exact 570.144 build, so I am not claiming patch 3 is provably
inert on 570.144, only that I do not see how it changes behavior. And I
have the mechanism for the =1 breakage but not the single allocation
behind the timeout. I can see that =1 restores LOST_ON_SUSPEND RM
buffers that should have been reinitialized, without the matching
state-load handling, but I have not isolated the exact buffer that
produces the failure.

My bottom line: patch 2 (=0) is correct and is the right value for how
nouveau drives suspend today, and patch 1 is needed with it. Patch 3 is
harmless, and from the sources I do not expect it to change anything on
570.144.

Assisted-by: Cursor :)

thanks,
-- 
John Hubbard

