Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CB47CC84;
	Tue,  9 Jun 2026 15:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017937; cv=fail; b=WVYmjF+SeZ5c8QpOO218ccmHZ/JOJd0aN0yZWHb4lpkkK/vFgxTHwpJk0XRGARF6okeLtD+agJJE/D0H1FIvJJccW5Iw3OmRYcxiX9tQ7W559uJ1aKVQUXqRkhrGHgqAUuA9w1TYLStxEcJSLzcP9TaGPARUowMt33EZGOQgWnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017937; c=relaxed/simple;
	bh=jHy8rZBmOWn/NHGUWVURMzeisRjc/4DY1sHAp/7A8sw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GdOPiTv2lsIIAwWX/4Svo5D19Ke9D0d6bhdf4E5THpian5WTq/EELYRtJMkePTjUBUTIPpSK9xWnT54BPXU7mNTwAuGbqSAgeUlCIyYckgGIQlqk/MJhZnb8//FnVEkQsakAqxhlT5lGpySrQyKe0nnZweiPj5WmuPf79SOsD50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QMMuGbYT; arc=fail smtp.client-ip=52.101.62.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QMMuGbYT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fqc0dMtropEy3sfBbbbbTNioAswbA5z+QHFAUr2mjHl3Ky2X1XoqM1xmbGDpfByRBmRdcpcd5cJoTshJQGY2Fz5JQY9QxXQASmM0cokz7w4iP5NqH4SFgPpjltyTD3JwUtpL/ZvlqzmSsP/X4RPnTCFmmwyzFH+w+NKgMGx6oV3b8NGhHKno/pJplx/vU2+1vyuzxR5zmBm9U5ss++1YC7EBqa4/W1l1/Uqb+g1zSbWqEDFYOuk9Eya9U/t2mod0+QYLfGDgKT8jCd28TODp7NIQLSXiGDJT9Clfjt+lq5gAhARS+L1TnV2rvwfxuk/Yl1xcw66cIUowO06BSd3pwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNF2VbATlsmq7exbIyl8iwJeO7Pe+V5mWf41PeM6nf0=;
 b=N76aJge//JmhSp/aAwyy4iM7L/P/xYk05p0lln0+fJp0lUyCEEaXlQXb5DzX6//epjIxM9UYPfpq8IKrZm2+gHBBinXhNiIVj7URIRL/a8T+eTUEyb+8w012AlN5zGfRYqWxKDqdfScbMWbajwzkIo6zB6uUm95ZiwTRNlvFG99iTkKuk2cxyW2Ns6CnPEXcJkEwENanA20e3LJtDuTH8F5u239z6aqH7m/7YhIncfW2RyzywqMxadBjHO1N3AYHmRaacziF6/pthpNC9GN4li4BAJ9BEUgARjSEiBLynz+mYp1tv/6F/W1cI38vWTBxUvMVasbhnFsvOU+vAuDhgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNF2VbATlsmq7exbIyl8iwJeO7Pe+V5mWf41PeM6nf0=;
 b=QMMuGbYTggPjDkhSIQWzrzow5/xwAb+a34ciXaYr9XNk+5BIW+BrpHL/AA45PEuCJ5Z/YlvoXT1N82uz+jhYiLv3iDvSexzPq9j+D2WUMUAKxHQmYo6DK23sDMPZdI9G5Rt4ANYeJlTtppm9Tiz/0m6iqsgTazcCRMXBdTWTRjU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by MW4PR12MB7336.namprd12.prod.outlook.com (2603:10b6:303:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 15:12:07 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::be0f:431f:5f27:96d9%3]) with mapi id 15.21.0092.011; Tue, 9 Jun 2026
 15:12:07 +0000
Message-ID: <2e24ba30-83df-490f-8a1f-5b80d832cb3b@amd.com>
Date: Tue, 9 Jun 2026 10:12:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/port: Fix missing port lock in cxl_dport_remove()
To: Richard Cheng <icheng@nvidia.com>, Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org,
 ming.li@zohomail.com, rrichter@amd.com, Benjamin.Cheatham@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, stable@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 PradeepVineshReddy.Kodamati@amd.com
References: <20260608223533.583278-1-terry.bowman@amd.com>
 <be149ddc-702b-46c2-b6a7-d9195aee0eee@intel.com>
 <aifBp346jcVZ6sgi@MWDK4CY14F>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <aifBp346jcVZ6sgi@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR17CA0023.namprd17.prod.outlook.com
 (2603:10b6:610:53::33) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|MW4PR12MB7336:EE_
X-MS-Office365-Filtering-Correlation-Id: 7900cae4-a9e5-46fd-89d3-08dec639788c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	jMigATncbBOeysGrQRzcnaytFiO2wI/EQeGhuaY0G+yG7a5JtGGJhhNejtJeLMrS4sSeOk8tyDZhWocMWm2IvWDeK7q2pfagro2ZSYNT6Trml60Td+UbIYItZjW4IiL7uh4ENo0ywg3NULBSWbf+6dFqEWVPEwIxux6MjUtvWSApmLQvyfP6vICMyDjtfGuGdK/ASV0Y6vs5dk2Lui2FkxTPkQTqDnRHF+Xu90I2qNLV9zIac9kazZzFSfaYCku+ek9PJfvhG4Kq16PPd9kpgcPeohDwHN2urllFp7xch1MxKCzMkmZP43LCkmszeR6lCa4JU8nXPRKKZ3vYjOXOrLtz2KbY4H8vWioYEpR3L3Q2j22yt+Qyb2tC4/SGBE7ck+tPp168OvISggXUgpwiPVoSWCC+cVIqsESahWdq7ReovPpXBvnaWcC/SaHBJGD3nFXDqP0wH26jhkPNjEibiybRxenNZpWvhqkuN42VBZsM/YHEfRUP/GO5H2gIp4Crc52e2j9A9SKA43ECZWihUFSBoGIvOVcjFol925WUd/k/muxysT2hWK5rp8NKsmskH7yZV7PoPm3ZyX4EEE6eSYPVYxZEm96YArT0l8CA5znDe5UBXslZzRDg/O+3sHPax5OHOeIgfdPde0xuYMb3p2nJ2HR5xyy0fXChX5eSoj7xY99XbFmP3Y/DmMmzUQT2VSR4oGLlJgR8EomGzDK98Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU5yNTYrdnV2Sk9kSUd4aEd5WlpZK3dtR0hLYlFzdHloNTNwcnQ0QWJVZEk4?=
 =?utf-8?B?TG0zMldwTUN5RGFpQlIvRUF1MXU1WVF6MTU2clNTd0lWNFNuOUhLRnpSSHR4?=
 =?utf-8?B?RnFFcmtiZys3bzJWQnBpREZJQW9yM0hKV2VueitiMm1EUjhIWTZHZXN2UE1Y?=
 =?utf-8?B?blhLSVlXWXA1MSs0OVRmVkczQkFjaVFYY0pDRk5MYXhqUWFIZkhUd3YwL0Ju?=
 =?utf-8?B?WktraGFyUjA5My8vTmRSd1FNVXl0b2VYZ1VHSTdQL3hzZGxZMnhOZW5FY3JJ?=
 =?utf-8?B?SzdNZURjWGVnM3BCemtpV252SDAwNmVtQXp2U2ZnN3lYU2taZHcxcDRaT0hu?=
 =?utf-8?B?K2puOS8wUTBWK0hFWFFnSlVPeU9BNlZRcnhFSGEvMjB3RjZwMFJzQ1huQlFN?=
 =?utf-8?B?djFJOFc5aVI5NWhHdllDdUxkaVVSM0oydFpQVzlKS3BLMHZqSUJLSjBBR0Uy?=
 =?utf-8?B?d014NUErb1AxUW5XSnpXczl2SDVNOE1lNTNDRHdramkrYWJiUFo4MklidUZ6?=
 =?utf-8?B?RTFFM0JxbEIyT05vZW43Nmtpdy92eGhEblFLTEF5cFVYbEhCVEM3Y1djQVo2?=
 =?utf-8?B?ZHp5cXdJYXg5VE9yMXk5VkllOVhGWHdoY05pZks5NG54cExsVC9QbG52azB4?=
 =?utf-8?B?Q3NpOFJxSXRtVWxSNU9oNzhYUGdtMzFubkNob3JCWHk1YWJDVGUvZC9jZTY3?=
 =?utf-8?B?M2FFRlVTK2VWa3ZUVTRxNzdHRlJ1aURMcHdKc0J4L1JnMjlBZlh0R2xsUlFG?=
 =?utf-8?B?ZmkwNTZCTWN1eFoyaUJOdkpXay9tVVh1UTROazJXRUl5S1AzcGttQWpyWGFV?=
 =?utf-8?B?L2k3cUhCYnBPbmpjN2xsQjBvTitKam5KckJzVjA0SW5NdHpvNFJoN1BiWFlo?=
 =?utf-8?B?enUreVR4c3l2cFBGRzhUQTc2TXlJN1BmcDk0cmJ5YnlMVjhwd0hvYTNPWENF?=
 =?utf-8?B?SUN4clRZRTdYQmIwQ1ZiMDhVZ1ZoUmxwRUxrdm9Wb2V6WStpWjdkVnJ2WmJt?=
 =?utf-8?B?MzhsaWIvTFh6bm95R0gxRnBMb1J0T1NBcnlIdDQ4aWNWeU1Yb3JtaWU3bEsx?=
 =?utf-8?B?Tkw1UGdNd2NKUUVtekNUL1BXcWNkZFhsMmg0aUwwaW1POS9VZDRrbGJnU2sy?=
 =?utf-8?B?dEp4M04raThQcTZhM1F4SU1yelhBV0ZETWZRR0dZQjdWTkhsMzNDajVQeW1i?=
 =?utf-8?B?QmJkdWVSRXY4ZzhFcUVuSEJZbmlzdXNLVmM5bzloc09zUG5LOHVydVFWUGE3?=
 =?utf-8?B?TzZwMkQrdVdpTmxJNS9WWG9PRm5nRDdZNk9kOTBpOGl5cFRXUHpYR3RJNmtk?=
 =?utf-8?B?T2VtbFNQU2hSSTNHVEw0Zld6SGZIU0Q5UjFvc296N1V4bTlUekMzbzQxZTFW?=
 =?utf-8?B?RVVteldWVExPL05wUEpzZkJGMGdwUWRXMzNQdVNsUzFjVFdtMHVqc1VmL1Vz?=
 =?utf-8?B?ampKRE80anBMcUdrcTMrNVhLaUxJdEQxVWdRaHlFeEtVVSs2bGdZZituUGN5?=
 =?utf-8?B?blp6MSs3N1MvUTgvS3pZTzFzZ24yUExVbmx1WXFVa3EwQ1pGZzhhaDJ2eGVO?=
 =?utf-8?B?VU9pRG9GYXdLNnBFZjY2a0ZvMnJuZm9zcTM5aG1hdjZxVUx6Q2h4S2R4SkhL?=
 =?utf-8?B?Y0lyT01SRzBXZ0g3L0doQ25CVXFTZHRmbDBCTG1HcFNDRzN5SFgwSXJvRlRZ?=
 =?utf-8?B?R0lBS2ZUUVdnRU5iakVnaUJodmo5Q0dwQlYxUHBkTERLcWNsT1ZrN2E5dHhS?=
 =?utf-8?B?V0xpL2l5K3ptMUZ1c1RJdGs3YUFOSkpVdFNlakZaZkR5cnVPZEhTeXpwOGov?=
 =?utf-8?B?c0s1QTcvM0QrTkd2ZFlNTE5aTzZaU01qaUE5bXBGRUN2bXlNNm5GeWVINVZI?=
 =?utf-8?B?UjRyZ0RYalQvcVlITktSZUVSREJDb2VweDY0bjB0Y3VUZWVOQlpwd0FqSkNU?=
 =?utf-8?B?ZTRYTkxsVmpONTZ3MVh4NWNoNmppMlhKTWFwTmhkamtTcVlaUWR6TTVvZ2JI?=
 =?utf-8?B?ckFpUGI2OXBuQ1JpOEFQNE5QQ1hBM01obFl4MkFJTVVocEV5VjhJQkFnb21T?=
 =?utf-8?B?ei9zRmMvdm03bWNVMHhuTDJwR3Iycy9xaml3SVZlWVFrYXRVT2Zsby9kQXQx?=
 =?utf-8?B?Y0lnTm11QjAyVDl5T3EwTUR2WE93L2dQVldjYms3WUVOQXpGSFdVWkpFSEJa?=
 =?utf-8?B?OVZLU3BRWFVVZHl2UXRMaElqTzltdXFqZVQ0WUhjampMSkdBRklTRVF4c2Uy?=
 =?utf-8?B?YXVhMVl5blNtSUV0bU9CSzE5cE5lUitBQW1id2Y3dFJrbkluNFFKSEt3U2FW?=
 =?utf-8?Q?wolEJPY8xgWTnQ0pAt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7900cae4-a9e5-46fd-89d3-08dec639788c
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 15:12:07.2486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UhRh1ZjnBsQVMSujvjQTQh9iFVRfHwvYBa5ApgKU+jwVVhGcKGlHtJDGRSZA1SIx9WZwbkmio1M3CFITSZzaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7336

On 6/9/2026 2:40 AM, Richard Cheng wrote:
> On Mon, Jun 08, 2026 at 05:35:23PM +0800, Dave Jiang wrote:
>>
>>
>> On 6/8/26 3:35 PM, Terry Bowman wrote:
>>> xa_erase() in cxl_dport_remove() runs without the port device lock,
>>> creating a race with any caller that does xa_load() on port->dports
>>> and then dereferences the returned dport pointer. A concurrent
>>> cxl_dport_remove() can erase and free the dport between the xa_load()
>>> and the caller acquiring the port lock, causing a use-after-free.
>>>
>>> For non-root ports the port lock is already held by the caller on two
>>> paths:
>>>
>>> 1. Driver unbind: devres_release_all() is called from
>>>    __device_release_driver() which holds port->dev.mutex.
>>>
>>> 2. Dynamic endpoint removal: cxl_detach_ep() takes the port lock
>>>    before calling del_dports() -> del_dport() -> devres_release_group(),
>>>    which synchronously runs cxl_dport_remove().
>>>
>>> Use cond_cxl_root_lock/unlock(), which only acquires the port lock when
>>> the port is a root port and the lock is therefore not already held.
>>> This matches the pattern used in __devm_cxl_add_dport() for the same
>>> reason.
>>>
>>> The write-side fix to cxl_dport_remove() is necessary but not
>>> sufficient. Callers that obtain a dport pointer via cxl_mem_find_port()
>>> use a lockless xa_load() and must not dereference that pointer until a
>>> lock that excludes free_dport()/kfree() is held.
>>>
> 
> Hi Terry,
> 
> I think the mechanism is right, cond_cxl_root_lock() in cxl_dport_remove()
> is a no-op for non-root ports and a real qcquire only for root dports, so
> no deadlock.
> 
> But this only cover the 2 cxl_mem_find_port() callers. The sibling
> cxl_pci_find_port() has similar lockless xa_load() plus deref, and those
> callers aren't fied.
> 
> Could you either extend the same fix in this series?
> I'm happy to send a follow-up for other readers if that's easier for you.
> 

Youre right there are other callsites requiring similar changes. You're follow-up 
would helpful. It will allow me to return to the error handling series.
Thanks.

>>> For root ports, dport_to_host() returns uport_dev, so all three devres
>>> actions (free_dport, cxl_dport_remove, cxl_dport_unlink) are registered
>>> on uport_dev. __device_release_driver() holds uport_dev->mutex for the
>>> full teardown sequence including kfree(dport). Holding uport_dev->mutex
>>> on the read side therefore excludes concurrent dport freeing.
>>>
>>> Fix rcd_pcie_cap_emit() by passing NULL to cxl_mem_find_port() to avoid
>>> capturing a lockless dport pointer, then re-fetching dport inside the
>>> uport_dev guard via cxl_find_dport_by_dev(). The previous guard on
>>> root->dev was wrong: cxl_dport_remove() releases root->dev before
>>> free_dport() runs, so root->dev does not protect against concurrent
>>> kfree(dport).
>>>
>>> Fix cxl_mem_probe() similarly: pass NULL to cxl_mem_find_port(), then
>>> re-fetch dport inside scoped_guard(device, &parent_port->dev) for the
>>> VH path, and re-fetch again inside scoped_guard(device, uport_dev) for
>>> the RCH path. This closes both the TOCTOU window between the lockless
>>> xa_load() and the guard acquisition, and the window between the two
>>> sequential guards in the RCH path where a concurrent surprise removal
>>> could free dport before devm_cxl_add_endpoint() dereferences it.
>>>
>>> Reported-by: Sashiko
>>> Fixes: 391785859e7e ("cxl/port: Move dport tracking to an xarray")
>>> Link: https://lore.kernel.org/linux-cxl/20260505173029.2718246-1-terry.bowman@amd.com/
>>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>>> Reviewed-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>>> ---
>>>  drivers/cxl/core/port.c | 10 +++++++
>>>  drivers/cxl/mem.c       | 65 +++++++++++++++++++++++++++++++----------
>>>  drivers/cxl/pci.c       | 17 +++++++----
>>>  3 files changed, 72 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index c5aacd7054f1..0b8f144596e8 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -1092,8 +1092,18 @@ static void cxl_dport_remove(void *data)
>>>  	struct cxl_dport *dport = data;
>>>  	struct cxl_port *port = dport->port;
>>>  
>>> +	/*
>>> +	 * For non-root ports the port lock is already held by the caller
>>> +	 * via devres_release_all() during driver unbind, which holds
>>> +	 * port->dev.mutex throughout.  Acquiring it again unconditionally
>>> +	 * would deadlock.  Use cond_cxl_root_lock() which only acquires
>>> +	 * when the port is a root port and the lock is therefore not yet
>>> +	 * held.
>>> +	 */
>>> +	cond_cxl_root_lock(port);
>>>  	port->nr_dports--;
>>>  	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
>>> +	cond_cxl_root_unlock(port);
> 
> In the comment above, maybe worth adding some contents about this is
> also what makes the RCH reads safe. It's no obvious for me.
> 
> Best regards,
> Richard Cheng.
> 

For RCH/RCD case, the cond_cxl_root_lock() only synchronizes accesses to the 
xarray. The RP in the RCH/RCD context is a SW construct. We need to hold the 
port->uport_dev->mutex to prevent kfree().

- Terry


>>>  	put_device(dport->dport_dev);
>>>  }
>>>  
>>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>>> index fcffe24dcb42..345b56f215ff 100644
>>> --- a/drivers/cxl/mem.c
>>> +++ b/drivers/cxl/mem.c
>>> @@ -70,9 +70,9 @@ static int cxl_mem_probe(struct device *dev)
>>>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>>>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>>> -	struct device *endpoint_parent;
>>>  	struct cxl_dport *dport;
>>>  	struct dentry *dentry;
>>> +	bool rch = false;
>>>  	int rc;
>>>  
>>>  	if (!cxlds->media_ready)
>>> @@ -107,8 +107,7 @@ static int cxl_mem_probe(struct device *dev)
>>>  	if (rc)
>>>  		return rc;
>>>  
>>> -	struct cxl_port *parent_port __free(put_cxl_port) =
>>> -		cxl_mem_find_port(cxlmd, &dport);
>>> +	struct cxl_port *parent_port __free(put_cxl_port) = cxl_mem_find_port(cxlmd, NULL);
>>>  	if (!parent_port) {
>>>  		dev_err(dev, "CXL port topology not found\n");
>>>  		return -ENXIO;
>>> @@ -123,21 +122,57 @@ static int cxl_mem_probe(struct device *dev)
>>>  		}
>>>  	}
>>>  
>>> -	if (dport->rch)
>>> -		endpoint_parent = parent_port->uport_dev;
>>> -	else
>>> -		endpoint_parent = &parent_port->dev;
>>> -
>>> -	scoped_guard(device, endpoint_parent) {
>>> -		if (!endpoint_parent->driver) {
>>> -			dev_err(dev, "CXL port topology %s not enabled\n",
>>> -				dev_name(endpoint_parent));
>>> +	scoped_guard(device, &parent_port->dev) {
>>> +		/*
>>> +		 * Re-fetch dport under the port lock to close the TOCTOU
>>> +		 * window between cxl_mem_find_port()'s lockless xa_load() and
>>> +		 * this guard acquisition.  A concurrent surprise removal can
>>> +		 * free the dport in that window.
>>> +		 */
>>> +		dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
>>> +		if (!dport) {
>>> +			dev_err(dev, "CXL port topology %s not found\n",
>>> +				dev_name(&parent_port->dev));
>>>  			return -ENXIO;
>>>  		}
>>> +		rch = dport->rch;
>>> +
>>> +		if (!rch) {
>>> +			if (!parent_port->dev.driver) {
>>> +				dev_err(dev, "CXL port topology %s not enabled\n",
>>> +					dev_name(&parent_port->dev));
>>> +				return -ENXIO;
>>> +			}
>>> +			rc = devm_cxl_add_endpoint(&parent_port->dev, cxlmd, dport);
>>> +			if (rc)
>>> +				return rc;
>>> +		}
>>> +	}
>>>  
>>> -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>>> -		if (rc)
>>> -			return rc;
>>> +	if (rch) {
>>> +		struct device *uport_dev = parent_port->uport_dev;
>>> +
>>> +		scoped_guard(device, uport_dev) {
>>> +			if (!uport_dev->driver) {
>>> +				dev_err(dev, "CXL port topology %s not enabled\n",
>>> +					dev_name(uport_dev));
>>> +				return -ENXIO;
>>> +			}
>>> +			/*
>>> +			 * Re-fetch dport under uport_dev lock.  uport_dev->mutex
>>> +			 * is held for the full devres teardown sequence including
>>> +			 * free_dport()/kfree(), so this excludes concurrent
>>> +			 * hotplug removal through the entire dereference.
>>> +			 */
>>> +			dport = cxl_find_dport_by_dev(parent_port, cxlmd->dev.parent->parent);
>>> +			if (!dport) {
>>> +				dev_err(dev, "CXL RCH dport not found\n");
>>> +				return -ENXIO;
>>> +			}
>>> +			rc = devm_cxl_add_endpoint(uport_dev, cxlmd, dport);
>>> +			if (rc)
>>> +				return rc;
>>> +		}
>>
>> Still reviewing the patch, but thoughts on moving the two new big blocks to a helper function?
>>
>> DJ
>>
>>>  	}
>>>  
>>>  	if (cxlmd->attach) {
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index bace662dc988..710a62a66429 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -708,10 +708,10 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>>>  {
>>>  	struct cxl_dev_state *cxlds = dev_get_drvdata(dev);
>>>  	struct cxl_memdev *cxlmd = cxlds->cxlmd;
>>> -	struct device *root_dev;
>>>  	struct cxl_dport *dport;
>>> +	struct device *root_dev;
>>>  	struct cxl_port *root __free(put_cxl_port) =
>>> -		cxl_mem_find_port(cxlmd, &dport);
>>> +		cxl_mem_find_port(cxlmd, NULL);
>>>  
>>>  	if (!root)
>>>  		return -ENXIO;
>>> @@ -720,13 +720,20 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
>>>  	if (!root_dev)
>>>  		return -ENXIO;
>>>  
>>> -	if (!dport->regs.rcd_pcie_cap)
>>> -		return -ENXIO;
>>> -
>>>  	guard(device)(root_dev);
>>>  	if (!root_dev->driver)
>>>  		return -ENXIO;
>>>  
>>> +	/*
>>> +	 * Fetch dport under uport_dev lock to protect against concurrent
>>> +	 * hotplug removal. uport_dev->mutex is held for the entire devres
>>> +	 * teardown sequence including free_dport(), so holding it here
>>> +	 * excludes concurrent kfree(dport).
>>> +	 */
>>> +	dport = cxl_find_dport_by_dev(root, cxlmd->dev.parent->parent);
>>> +	if (!dport || !dport->regs.rcd_pcie_cap)
>>> +		return -ENXIO;
>>> +
>>>  	switch (width) {
>>>  	case 2:
>>>  		return sysfs_emit(buf, "%#x\n",
>>
>>

