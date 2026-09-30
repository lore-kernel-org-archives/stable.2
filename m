Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020137.outbound.protection.outlook.com [52.101.195.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3864F68D7;
	Wed, 30 Sep 2026 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782285; cv=fail; b=lBxNJy0EaKJ70OZPS6xK4YfDTSZpVUw0KoaK5jXzX+fc/8iZplgbwAZVgiM43I7M+nVRFVjjxqVVG8a1BcARkrotHdZwIb4XkNoIRBGXkR/PihcYk0AKYrA+WLSFTdBv0+kryRkT0vLn4OKbzDDjVqPporjPJWAzqtxGhJlsrd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782285; c=relaxed/simple;
	bh=CbhmrnIXgUrUd0iuPkscSNNnrD/WBtRZmwsLnsMUrf8=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=EWMrxu7IZXp0bNhP+2BXeLUz147lS3h8+oeo23n3DS6hwHMn2GXjkPxf1OBfWgk47Xcs2leGAGLpUJTdijwINfZZ3uNSdinFxVfy4hA8cEyd8C3wsaUutNaEiiIrmMI/1+ZTNXaehnga7qRDWqgfLZqfi6CPG5lQdfA9K4gcaJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=kk8RDOby; arc=fail smtp.client-ip=52.101.195.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="kk8RDOby"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gVOgxFc7c4OOW3sU8q02Mt2nLy8kxatD3hzBL8NZJFa42vTVPnhJ6nKnR39awGZLRESjtlz0ZQtv1y62dGgNsoe0HXujOio6Q3D8hbGUba9MCqgumZ7Bzrmf/IG6YZ8rX4Ku92srpA8NL7RQVyYyWAO786nbuswSpR5nPQhF5WvRn7nRNuVP+fmnH32ot3LzEq18duJjS5Hl0xTBd9t9rPhZUWtSoI+RnFhap8WDTZj7i2sXwUc40tqwfLUJfsTHEtHq2h3z3mbuDN/8BBZVBnNKwqa3aB8X5QlkPCOzS3jnrdjgdbhicsSx77EQIYcsErrKXwJNqfQfSAvdJxc6XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49QwDSFb3rjADzb5DKkBuFRmJHVdTo0j08H7PdOOPx0=;
 b=xBoaQzAJRjwqErpTs9qVEmcIES7/rg8Tp4S6awQzMxQSW1lgnxeiak98bBX+FZmLhyMitABHxnJXked7cSoKuoqQhvcCrmW5qOr5TUVd4PouiYPoxGO8K7cuxEzacYueNEI4O57W39Zct5G7nNH53mtdVI5Lmrx7Tg2/pbMkWm1WXp+03XgD/gIHwa4h1X2cc6eZzA6FKoCH7/cV6iNQPOVX7JexnACSI3ye81iie8zyjobEZ72kPwRMCNI3mIUUQVvmBQ0RJQ3aKqdNQX4VyNKKdRoOkhomwadfvNs9fV/rjYb1C7V4uCHwLuEcczJqh/FeIiO3k6Zk70CLRbPdVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49QwDSFb3rjADzb5DKkBuFRmJHVdTo0j08H7PdOOPx0=;
 b=kk8RDObyxO5rnFCBUqgz5i+KIIsV5/hgKT1etJxQa7+CLimWqTZiamHOT34tr7pE80YDaJlRRUPLoq85NI9gFgXADn439UtG5dqz39Xa0ki73RLob2WGv61jdhSYVgrlhzYs5B4vjmYAVDlmeY0y7BWZ0vIhqZ5eVVbm3yMNbJE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9022.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 15:31:13 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 15:31:13 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 16:31:12 +0100
Message-Id: <DLSRC2ORPMSV.2W8O7S95JLAXM@garyguo.net>
Subject: Re: [GIT PULL PATCH 0/9] Rust changes for v7.4-rc1
From: "Gary Guo" <gary@garyguo.net>
To: "Thorsten Leemhuis" <linux@leemhuis.info>, "Jens Axboe"
 <axboe@kernel.dk>, "Andreas Hindborg" <a.hindborg@kernel.org>
Cc: "Boqun Feng" <boqun@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-block@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Alvin
 Sun" <alvin.sun@linux.dev>, <stable@vger.kernel.org>, "Priya Bala
 Govindasamy" <pgovind2@uci.edu>, "Dylan Zueck" <dzueck@uci.edu>, "Yuan Tan"
 <ytan089@ucr.edu>, "Sophon Z" <aiqubits@hotmail.com>, "Qingxiao Xu"
 <qingxiao@tamu.edu>, "Malte Wechter" <maltewechter@gmail.com>, "Mark Brown"
 <broonie@kernel.org>, "Linux kernel regressions list"
 <regressions@lists.linux.dev>, "Linux Next Mailing List"
 <linux-next@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260929-rust-block-for-v7-4-rc1-b4-v1-0-642a4c1aebd7@kernel.org> <179068244058.1205226.1765319338142659278.b4-ty@b4> <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
In-Reply-To: <d1381ed8-eab8-4fd7-8b15-1e94876d7099@leemhuis.info>
X-ClientProxiedBy: LO4P123CA0324.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::23) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9022:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c3be07b-a474-4272-ba6d-08df1f07dc30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|7416014|376014|10070799003|4143699003|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	o0jOorASzr3fhCgUg9cfL8rzvAym6eq469oKNiV+/Y3W10eMJzF60GHIxizKDYrq1g3EmYMX2NgwPQc35fMl/zH8MbF3oOdOtIlNb093jcNzssBcJJsweguAeTtu3fMfhQDQLniGjF3ue6Bh0JLTWWZimKOzUb6mR+wYu8bt84ETCrCiANDsKxn5Yoj42WKyTQ+t5G23mZANwFzaCAaThyjTL4IdCCiEs6Uhnx/GClRiqxKwxM4wBN1No86hfF+4TXGYv4C7i5yPII8iLqYT7BbcnpYBciFikWUIVQWlMgvW+mqiaNFQmhvarhiaBPmDT9t8Pi8oZ/hhD7oKwJBI3LOg0Yp59L3we9tL1ZMkgge80lxJU6379QilZibGwKhBop6mcYWjCofPWah2Ted8Wi7zUNX8bDnYUzIggpstUp+27nmDp8eRDXA5FmE2wUHYgCiK4MQxAAND0/2Wzyq/Exe84Nk4IZ/k7PgTqaSSwbTC/uVbHrm98P7klfy4OuFMlTDgdJ2QM5m3GP/dGzQsOm+CNLRBQHTOJNQoqs01HmHn01XazGMQCBFfk1jmC/Iwhzf7qcucYXcYHA84MJctRSxxwb/ShnWSJlyCdTwhZI/7k+inPv8WSXrtmeIHwJeY
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(10070799003)(4143699003)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtLY3NRazN2bVBZaUtnVzNvQkhIaVZCV2hvWUdWYjJmWkZMVDE0TUJDaXBM?=
 =?utf-8?B?UXY3cjc3eFFqZmZGV3lTaVkwQ3NNZmFNcVdzNndUdG50Vk1zZTJQWEl0VXlo?=
 =?utf-8?B?SVBXZUN3emFMaWo1ZUs2dVR4Q3RiNy9ua0d4cEZZQXQ5aHJJTUwrZ0VtSlp5?=
 =?utf-8?B?OXZuTUl6U3BCWUdRemQ1QUpaM0ZJNDY4ejFUbzVJaFlpVm1NdngwQWZkc3BD?=
 =?utf-8?B?elIzelJsSkJrT2wyV0pKV3NsWlNGWk1yWDI1a0pIcjB5K1FEUDRaTEY4WlFV?=
 =?utf-8?B?aUVaNXhMbFhzQ0ZUc1hYS0gzTGlxeC9uYVZyZ3VWMUx1Q1VlN1FLNXNoeXRk?=
 =?utf-8?B?MWJiRVZJNkxiYlFLOTlEcEZDMS9NSFNUUThtbTFwNllYREZRT0Q3enVNbFQ4?=
 =?utf-8?B?Tzc0SUtnMHh6MTFjdlRZSUtFUFZOK2R3c2VHUHFPVFpPdEpFNjFMTXlCRGlr?=
 =?utf-8?B?LzFVSndxSW11ZUVrTTdrU21kTDNXbzg4d05UTEVKTEdwVmY1VlNORXY5T3lC?=
 =?utf-8?B?Nll4RkpJM1d1SUM5ZkdLM3dkTTNLVE03c0Y0SVJuQzJFdkZMUmc5ZFQ2SWRQ?=
 =?utf-8?B?Nmxsek8xd2RHK2VVMTBQWjdKZzB4Nm5jdktvdnpQZHpnMjF1dXppMWxoNzk4?=
 =?utf-8?B?RVhGMGR2TXorcENmbXpSeUdUNlQyT1RiaEYxZHhYR1ZYdFMwaTlGNUNPRkxP?=
 =?utf-8?B?MXVUdnVIYUptcVN6enpnaGJNaC9CQzRxWXpEOGx2bTZCWHFyblNLdzFGUHpP?=
 =?utf-8?B?SDFPRDNiUTkrM3RvYTQ0LzRCdjluRjVXZ1dmUlVJREZyeGh2aE9ldVcwd3lk?=
 =?utf-8?B?Q0p0WTdEeXIxZmhudEsrQWpZTnZIZklvQkxFeThRMUJiM3JGbzNZSE14TE95?=
 =?utf-8?B?MEdCaXk3RHF1WEV2NkF6c3pXNG5UZjlFVXlXQ1lvYkpib2FsYiszNXo3c1l2?=
 =?utf-8?B?NURTR0Y3WlFSZ2VuQ2hHZXlpSzI2UHFPRWxOVFQxTGRweVFCMGRDRkdjejFB?=
 =?utf-8?B?bW4wMFJ5bHcrZVozdXNDTzVVQjJ1QXQ3SDF0VFRMQWYvTW5CQUZJOFlKTUVM?=
 =?utf-8?B?cTFkVUZZR0NpWDhyL1F4dHZNbkhpRE5WcG5ZSk5WbUIwc0tHM25KaWQ0bU03?=
 =?utf-8?B?SFM0RHdyaDBPMTJJdHREbFZEQkt5Tll0b1BoNWM3aDNpN0NvaS84YktCUEI4?=
 =?utf-8?B?LzJGcjdFbHNWWDRJQ1hLaU54Vy9CVTFuNTRDOEZmL2pCNWRqT3k5U3FFVEF0?=
 =?utf-8?B?aTZFNEx1SUhidU5iRXpLcTY0WHIvLzVKZ1JxdlpGNzNWbTFkUEdXVGY0eXhv?=
 =?utf-8?B?aGY2Znh2Qjg5TjZzYWRJdzcraGNEQndJOG1vSGNJVDBKRFA1U1MyZGNPbFM3?=
 =?utf-8?B?SDcvbWsrbytXbjUrSDhaRG5uMlJrQlNzbjUzMDRjWWoyTUpSbkdzR0JyWDdS?=
 =?utf-8?B?cmZNS1hRa2UyazFMNEt2eVJoSmlHbkpqbUg1amZza0FKTk4rWjdiSlgxbFdY?=
 =?utf-8?B?UnBOV1J2SEpJc3pzTktrOVBRSk0rbXpZWlY5eGpOOWZjb1VXRkxNN0JWSVh0?=
 =?utf-8?B?TzdLUmNaUld6Y1VUYjZMVjdjZjl2L1R4SnJQdElOMHkvSEJjbm1RUmVSYVVH?=
 =?utf-8?B?NWZQM3RTVTFEelZtT1NFZWh3Z21OaXdTQ3FRbU9TNmFYMmlpNlFJYlZLZ0VV?=
 =?utf-8?B?ck8yRlMrWEt3K3NYTXZPWDF5OTh5TTg3QXZMaERDRklhdGl3Uit3czJQK3Av?=
 =?utf-8?B?WERPWXBlaUV6bTc5STRXQkllR3JxbEZyL1VTckI1VVpIUVEwNEVBSGM2bWJh?=
 =?utf-8?B?REtCaXAyKzVzTlUvakozcmFnUUxUMnlCRmQ0OUE0NEZKelAzU0ZMOTBvalpU?=
 =?utf-8?B?d0dRWUp0Wjk4YVlIQ0xEYnNuTUZ4NDlTcUJzeGhmMWlOeUt2Y0d6YkxDY2ww?=
 =?utf-8?B?dmlkL2o5a1JBU2ZldlBLWmhBY21zcUl5YlljRXBITUVjUWhsUGFvV1FoSXFR?=
 =?utf-8?B?cktiN2Y1UHBZakNEVnEwMzNrVGp4WEk4UFJqU1RZTGRReFRxOXo1OWt5d1ht?=
 =?utf-8?B?ODJVdU5KNzduWUczclRlY3JubG0zc2g5d3YvQ25MZFhncGNLKzVCOCttWG9a?=
 =?utf-8?B?QUZoaXZmcUowQXZ4RkpvZVluOGR5b0hiYWVQUHBtTWREZ2xlUjV3eHFKY1RK?=
 =?utf-8?B?ZHNaR0locTdHVnIzaWtWR1E5OGs3TDBxZEE1WHZpaWxrVFMrUDhMdEh2K0hn?=
 =?utf-8?B?WmVUWFNveG1CamZ3ODVBZ3JnYk5HendrN29rN3kvbFVIVERQZ3BrMjFIaUgx?=
 =?utf-8?B?blNTMkFhTHNNZ3JVMXF1VDRuaEd4SkdUdzBMK09mQTkwVFp3Umtndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c3be07b-a474-4272-ba6d-08df1f07dc30
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 15:31:13.0156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cmXg5tLyhvg61Kv5LEj8q4wBM1Cc/K8bx96un73k0ykQMw+i9Ly1qQY26ns8v0g++3wo9kENIAvI859Gu1Xceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9022

On Wed Sep 30, 2026 at 4:06 PM BST, Thorsten Leemhuis wrote:
> On 9/29/26 13:47, Jens Axboe wrote:
>> On Tue, 29 Sep 2026 11:33:58 +0200, Andreas Hindborg wrote:
>>> I have a number of Rust block layer patches I would ask you to pick for
>>> v7.4. I have collected them into a patch series as well as a pull reque=
st
>>> so you can use whatever is easier.
>>>
>>> The changes cover
>>>
>>>  - Style and formatting changes.
>>>  - Documentation fixes.
>>>  - Fixes for missing trait bounds that can cause API unsoundness.
>>>  - A change to set the owner of the file operations vtable in `GenDisk`=
.
>>>  - Two bug fixes for the rnull driver.
>>>
>>> [...]
>>=20
>> Applied, thanks!
>>  [...]
>
> This series showed up in next today and broke the build for me on
> various Fedora releases for aarch64 and x86_64; reverting this series
> fixed that from a quick build test limited to drivers/block/rnull/
>
> The full error msg is quote long, find the top of it below. Full log:
> https://download.copr.fedorainfracloud.org/results/@kernel-vanilla/next/f=
edora-rawhide-aarch64/11055137-next-next-all/builder-live.log.gz

The `Child: Send` bound is introduced in configfs:
https://lore.kernel.org/all/tencent_05937A22D2DA2BAE808EF19E491AA109BC09@qq=
.com/.
So this is more or less a semantic conflict.

However, the fundamental issue is that TagSet never implements Send/Sync, w=
hich
means that "rust: block: fix `Send` bound for `GenDisk`" will unconditional=
ly
strip away the Send implementation, which is problematic.

Something like this should fix the issue:

    unsafe impl<T: Operations<QueueData: Send>> Send for TagSet<T> {}
    unsafe impl<T: Operations<QueueData: Send>> Sync for TagSet<T> {}

That said, I am not sure why the GenDisk need to carry `Arc<TagSet<T>>: Sen=
d`
bound in the first place. Removing it should also fix the issue.

Also, the `QueueData: Send` bound should be part of the `Operations` trait =
and
not carried around everywhere.

Best,
Gary

