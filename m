Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012002.outbound.protection.outlook.com [52.101.48.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F838944D;
	Wed, 12 Aug 2026 16:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551588; cv=fail; b=hPHqM0P2Gw5mEspAvGTo6ayUDNkA868LuLmoFRF1Nzny7vH50nLIVktsNcjHq+kgGlq8O0VXFjiWo3PA4cgrUUEuCu3yWt/09egNdPmomP/jlV5VWJ8qdLgWSxvjJMucGlWVoO1Lk+On+WarEHA3JbPw6wqJNVu6m05PHjiJ1ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551588; c=relaxed/simple;
	bh=xE1B2WywV2KleFKfWP7fSf07CYA6E1x9xEw5YpDXuzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jiLq/VrVGiLPohY+jDMNZH+I4kt0DA1d87jn00VmhdBjEiuS6ex2CN35FynR7Xz90wpB/rc0gXJB/4CYxC/seSU5smcDInsKTiVGsTJZkLyXsStC2lpLNBRCNnZHNIKRPTmYT3k/+IegzBeLcc2m7tNcML4JfMi7l+DyDSZMARI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4URIAD4S; arc=fail smtp.client-ip=52.101.48.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4URIAD4S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xWRzg+/KLQ1cvE2f+eaSByVCMoQ46EzFmUoFWpmeHsByCp7Y1EK9ZhGS9l9pttuXhBrqgP2FqeN5CvGTl2cLJL3iGEclMESnwRXp6Slv58kvhw99Pr9Sfb9aUCkU+O8wfs7wIVXFkmsusotWJhFuRL3CiKkNXoZ0XWg8gv4c+43+ogqwisdYw5VmjEkPgM0kPXCWfWWwZ6R22TI407SkSd4Zt5Ax/kB5ql2uLGNSCSrVnm0CE3CVuYaAceBqZLxVDSyI7uAV9egvy153Ds91SgC6PoBLKQcR5HUv40s1H0sa9KBuLeRUzBYOpQRtoiBFvpvPLfe+OXOEipWxD5zpGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMpOzuQ024KvRyj5N2fdEfMXgIlgBmT1YgIITUGf5gI=;
 b=rrrQR5BV8ObzaOl8obPbKH5lsYqUuIv/d87dq4j+Q2Q4mH4C7qxp+xTLstRzhrfMh7YXyddO6xbmmrCdSDty9eBepkocKn4mQnQB3TwTxV9fWzp8QYme0kV8YXiEfYOwjkbHfYaO0rZQeBwNVksNcQJgqOcfqT1tnm210OdD73yl7n4b/pNN7wLhsU+NESYkBjo6nEQljBP95JqAGo079e9BBIK3YRKXrx/fcVDmkctPUPgmhFpzh7pK1xs4sCuHehyEWcv9mwBVAChrmNdD+i3KDWKgEgZxhss0TcGTFb7jFaAgIvRy9+Ihn7MlHiuntII3U/82OX5VozaF/av3mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMpOzuQ024KvRyj5N2fdEfMXgIlgBmT1YgIITUGf5gI=;
 b=4URIAD4Sdc82etWhrWlZXWN2eVo5mXNK0ViKf+3p4EtCG+FcEgAM7KN9w4oKWuk2zKZZM9tD69WeeTpW/LuDxI0auvZJpL/syZXWr9oLrsK8uyFPuhGgPS4qtD/SMrisheIe2WuonAPW/tX8mYWO6pEPs2MGDeiiWvmoaTSLRng=
Received: from CH3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::14)
 by SA3PR12MB9160.namprd12.prod.outlook.com (2603:10b6:806:399::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 16:19:42 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::3c) by CH3P220CA0025.outlook.office365.com
 (2603:10b6:610:1e8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 16:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 16:19:42 +0000
Received: from [10.236.178.106] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 11:19:41 -0500
Message-ID: <e0f20e5c-91af-4f9d-b1fb-b00eaef76f58@amd.com>
Date: Wed, 12 Aug 2026 11:19:40 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
To: shaikh kamaluddin <shaikhkamal2012@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dan
 Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <tony.luck@intel.com>, <bp@alien8.de>,
	<linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <x86@kernel.org>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
 <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
 <anyYev89TB1jHAXe@acer-nitro-anv15-41>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <anyYev89TB1jHAXe@acer-nitro-anv15-41>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|SA3PR12MB9160:EE_
X-MS-Office365-Filtering-Correlation-Id: e64bc036-910b-4e19-28ba-08def88d83fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|23010399003|5023799004|11063799006|4143699003|56012099006|10067099003|18002099003|22082099003|13003099007|6133799003;
X-Microsoft-Antispam-Message-Info:
	/dwnBOLLdTodvaEZlfo6lqNViOh6jRglc5+IPyvl3MVUybUcN8ip5tuKZhgjvYTpFTMbKDPxhEw4fjOkZ5drRdUYAhLiSmBU4Ni9bRLigtVG9cWcybfoRhAD+vjrmrrw2Hq5Byr2aMjaSzR7hpXI+OXQMEywczZ8eNNyUNXtNXQmVXIl+H7mPfl8EwnuyYpL+PPJm9mTNNoligDXBhgv5e4caKr0FwUk7CQVo7Dbjj+fe8uSVDlo65P6EVWYh7CA6mepVPzV+99tp4hLRPMjxOZFIVPQtuB6SinymB9vaZfr094+vSv00HhP2fA9Zg2tG/LjTfe06cWxqChOZ6sK+OyUegPg0qZE1s9EPvQvme+NjVY1Z00o9TGadruZMvjhAPHTqJ6UDiK5tmg7irC624HXMuX3yQy0agbsSYVJ/necn5l8zrxD2H1gC5ZewON76+zP3UGrvp13QKOrJi0TObl3b4Sw5r2PwPFFELK/yk3cNjeip/hsDR/dH69rLwuwEkR0lxtRK07FfHqb69ZcyKZtm4JTs7DNuCayPxdBpozzL8XHzKs9SPZD9x64sX3Dbnr2PB4mWVkjrBhGvvgyQlV9XUPQorh7N7UiaqyqzAoapIOdzq2J4VM+8qSL+s5vUZyiL5FHAQ7VCfsx/V19gun+xXVIVUCr1OWBg0QPd98=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(23010399003)(5023799004)(11063799006)(4143699003)(56012099006)(10067099003)(18002099003)(22082099003)(13003099007)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	BYpYVLrV3ymU9XDrgKJDtlD4D+JTOClNIlq8r7SUxQ8I/ruvZDUdMwg56Hnl97dYis5xJWVb65xDWne5uEjTZmeuikn+e+s2VAVxY6DQBVKcNPqw5xkfAot23HWjKSOVt3YlFGsVjUzorAxnLqtfPCjlRM4WuHdhP4hViFk/H1o3Suv0lKIG+xgBp1aj+PDvPTqGzfY6tMFkcJNwBst6hWwkVfK+FASOGlcVdiDvyI3s83jGP/0KxEIZmm9Mh8pgh2kMlj8v7bnsoPynHK+YnCuhSb6O4CYhtVkCtW6eSJI4WooBXCrWlzhPKdSPM0yISF1Yw9RzKAOcrhP4+imjDuLXT8hLBj276Rfq1qSHC/NHJynOReCVOY7cmoDaYri/HGR4AcVGoUsJolpClIXLLpmbfx6E/Ia3v9hv7k/pBWIbwyEJbQ2iNC3la+tABvKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 16:19:42.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e64bc036-910b-4e19-28ba-08def88d83fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9160

On 8/12/2026 10:59 AM, shaikh kamaluddin wrote:
> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Mon, Aug 10, 2026 at 02:00:18PM -0500, Cheatham, Benjamin wrote:
>> On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
>>> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> cxl_handle_mce() offlines the aliased page of an ELC region on any
>>> record with a usable address; it does not check MCI_STATUS_UC or
>>> filter non-memory errors. uc_decode_notifier(), the equivalent
>>> handler for plain memory on the same chain at the same priority,
>>> filters on mce->severity and leaves corrected errors untouched.
>>> cxl_handle_mce() has no such gate, so a corrected error - which
>>> the generic handler ignores - still causes the alias to be
>>> permanently retired via memory_failure().
>>>
>>> Corrected errors do reach the chain: machine_check_poll() logs
>>> them via the same mce_gen_pool_process() path that feeds
>>> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
>>> extends p->res to cover the DRAM half of the ELC pair, so a
>>> routine DRAM CE carries an address inside the region resource.
>>>
>>> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
>>> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
>>> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
>>> machine checks") established this filter for an equivalent handler
>>> on the same notifier chain; the consequence here is more severe, as
>>> the CXL handler calls memory_failure() rather than recording a bad
>>> block.
>>>
>>> mce_is_correctable() is used instead of copying
>>> uc_decode_notifier()'s AO/DEFERRED test because the alias must
>>> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
>>> the reported page but nothing owns the alias.
>>>
>>> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
>>>
>>> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
>>> ---
>>
>> This looks good to me, so:
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>>
> Thanks for review!
>> If you have the time, could you also share a script that does the below testing on the list? It may
>> be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
>> the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
>> for people to run would help with any future breakage.
> Happy to share it. One question on where it'd fit best: ndctl
> (github.com/pmem/ndctl.git) as you mentioned, or drivers/cxl's own
> tools/testing/cxl/ in-tree? I'm open to either, or proposing it in
> both if that's useful - happy to follow your lead on which is the
> better home for it.
> 

If looks like there's already some mock functions for extended linear cache in tools/testing/cxl, so
I'd recommending trying to put it there to begin with. It may require updates to ndctl after the fact
to run the test(s) as well. If that looks too involved then sending the script out to the list standalone
should be fine. I don't know if anyone will pick it up, but it'll be searchable on lore if anyone wants
to test this.

Thanks,
Ben
