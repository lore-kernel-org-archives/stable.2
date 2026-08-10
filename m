Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012004.outbound.protection.outlook.com [40.107.209.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F34C439004;
	Mon, 10 Aug 2026 19:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388472; cv=fail; b=ikgiUiOSZYaownM7FpWBTK/S9tzM7NEsweMJ3Pi6qQkTlfwusmWZK9HgCOeqgPgX8IICPzgSMBCVnFglOFPnLmG0SXlaS1p4n+FLftZC+Oeu3kc6YcT15+qkRmn5JlLU6Ts5M3Y6gcXk2oL5HUwhFSzzoRdvDU39oT2WFTQ7wX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388472; c=relaxed/simple;
	bh=UDLaV6ar6MjteDKX0z3r2KnglHriGZSCI8mm+dEVXV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bFHfVf/MWkDyuKvS3tFOhThtQiGiraQZI3M+4acA38G3XEqHNWEpIhD2vUKWEsKEhzKphmCraezVG7DvvbCsRCgD6ePsZDlSP7FdelVo2OfywdOPw3k1Py6l1swoh8hO6XmMOxNg7Lenjw1DByEj3T+Skwv2VB4AQoxoeCxU/0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JILSKbA6; arc=fail smtp.client-ip=40.107.209.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JILSKbA6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qgiIo8/xZJErhLTKenPKXOrG8lfa9VY3oG5HQ/olIMH58K2wxVzoYJU4ECdMlLEwBP8aKLM42KwEnuH4/Yp2wm645w3SeSXViKmJ4ftkXUBm0wXTgL7DrQrwpbG6LxlZFsiCvQOXxTfwVoVnYPCpGXTinBv2jxbCE+oCjpDfWNuKZY4p48ewS7vJAO8xGvGNztRfXfiGtdjTp5iEn56EeZjcfVmB5cadWqlhae3DaoA3RmyWE0Wgf/c7Soae6593A4BVX1GQ2Cr6/SndWdJt5+wURyk6Rtpd6AFVddRMT++TiKyxjEjZW2HzRQFwpYgI8agOzih7LgUlpF++pUVrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYdgfEWQ8yhmHKX2/lSRCbzQHXlViRkar1JkHJ33fFM=;
 b=ghsJpQ0jkdUbSwuRotglvREt1gzGFoML7vybpOXQ6WXIy/286ZbvXK2GFO0Ll3pvr/ts6AWumsLopGJQAQyZDdq77Eyikny3k24cdUOmSNrVpsTviayl3HHHo/3s6qONmFY9fFseOen9icdZgLJEClu3eLtFMiXRcXQRU5lIXeGMEj9bRGGwISE7VXIuUls+fN4FN4mrf3xVhkjfXKEVXNdP8u9yziDtB3H28SfDzw2kyLaIuusphUy1sOAWgl3dGHiqeITnGN9bZvvkSjyWZTRJjsOzHw15Z2afPu57Il2Ko9Kbkpn8jWjlJmHry8JUrqz1+fL1adwj3gTJLLjI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYdgfEWQ8yhmHKX2/lSRCbzQHXlViRkar1JkHJ33fFM=;
 b=JILSKbA6gzIt5YP6nnab8WBVajjDw1yfMdD4k/A/A6SgneIAoaYLOC6bp2L5cwmTmdXA6Wx7FjxZGARiTjKU2DPi9dLW+xK+Ja5zRJgX/FyLjQUTUMXTXDiPwNj7FNZopUZ2JYeV4ZcdN+enA/aau2+8u8L7g+CG/jMWqZjiqpc=
Received: from BY3PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:39a::15)
 by LV2PR12MB5942.namprd12.prod.outlook.com (2603:10b6:408:171::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:00:21 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b) by BY3PR03CA0010.outlook.office365.com
 (2603:10b6:a03:39a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Mon,
 10 Aug 2026 19:00:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Mon, 10 Aug 2026 19:00:21 +0000
Received: from [192.168.86.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 14:00:18 -0500
Message-ID: <8cef03f0-ab19-42b7-ad04-a1e98e2270ec@amd.com>
Date: Mon, 10 Aug 2026 14:00:18 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/mce: Only act on uncorrected memory errors
To: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
	<iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, <tony.luck@intel.com>,
	<bp@alien8.de>
CC: <linux-cxl@vger.kernel.org>, <linux-edac@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <x86@kernel.org>
References: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260810183013.47085-1-shaikhkamal2012@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|LV2PR12MB5942:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d7a40ad-95c4-47c2-0a31-08def711a0ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|82310400026|36860700016|921020|13003099007|22082099003|18002099003|56012099006|10067099003|11063799006|5023799004|6133799003;
X-Microsoft-Antispam-Message-Info:
	aBk5cVUs//b7nEqn9npti6Q5cgoDSLQPFYJcoUV2KXu6Ipowjcgf3/1KEFvteugddTi0QtbNgjKPhsIR6BwVALXZkYPtrSM5igu9BZKM73j6mfLxMxAIayTwa1KVm8c3AXULoHlqoYLc8mUPFxuX+X6y00v8YZJLdSIYVirhjYjAM7QquuC1wyr3ktice22J7wvyuBOsYc12BQJk6FMNQ+flxHjzCxWzcrRRUlREYQp2RqSxcVROyM0T/6MylqacbITdMLKBJ8tGp7MO1gxkfgFvHjnzyaraIhiQGnax5Bnj90YLMkZQrDPhG8lQB1oEEPH7AHHUA8ZIjEELekZQQL3Rf9aLxfVvjQtumD30vGrnanMJncpBIDfGVSxUftrP1sV7m25lfBpQdg/KiNAW9Wjt9KBj19b9+qfPsd1j/79exXy36vLFUb9w52CAU/KBUsBaLnxIvcAhuaZoB+lODLPBEiwkgEa7ZxtmSjCzc88In6lhyqha8J/U7sgiIok8cJ9RibkuA7gqFjjJ5j/TyC5r6/stHDYJVAm/N9CMq8MvkKZZpRTylxN9FJbyZ3xX98eEr/r2P0lR5sAzCthfdPgr+dBxwX3fMdrV6I0RsiBUj/G1MXsEuhVr5r72QYMoBbYXex4IWhb9OWhgBVdUSpLH4tXu/9NC0wFYFnnLYjBo59rj9ScsQfI9CFYW1kwA+X4bkH3at93hVQE0Y0uJqw5JWgwMzBMZ4RoiYW0iGAZeQWdweNoGbn11ArIO64yo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(82310400026)(36860700016)(921020)(13003099007)(22082099003)(18002099003)(56012099006)(10067099003)(11063799006)(5023799004)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MjtoaSHVyNQc8rkeKjfntEW5/IDJ22cglW4XswUwNJpgewkffjMN+y1F3HKq0p8c7uP0W1rmr1gnzIzkOIMqal4+kLh04TN6WwRlx88CcpYN7VZgr+ML9ylDScYu/SKv7GTb4qbdGxmH4bhy6CTiBUGnkrfpASc3n2twwaxPeIPdx2xeB+VrdoOvJZuMDN+fppM0TEyPj8yYJtTIt2u2raCQ87WKy+ivkAAZHNacLhZtm643bcUSUtTaB1KVBxE0NX5Jb7iVrJbrU3gDLx0ks0OTzis7KDg8pkzumr1J0R4UStdsAFc2mQ/HGYHTyWSyGqYamBj2erITby9/dFU9wlwhXdsxhbtvUm0SzyOj8JpBdkwvE1hnYXJ+E9jQ0F65leTuMlxHblhAMHxZIWv8czTNXe0c9lGkQpwW7p/QBdQNs58Lw7/0peFbnTyrqOr0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:00:21.2484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7a40ad-95c4-47c2-0a31-08def711a0ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5942

On 8/10/2026 1:30 PM, Shaikh Kamaluddin wrote:
> [You don't often get email from shaikhkamal2012@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> cxl_handle_mce() offlines the aliased page of an ELC region on any
> record with a usable address; it does not check MCI_STATUS_UC or
> filter non-memory errors. uc_decode_notifier(), the equivalent
> handler for plain memory on the same chain at the same priority,
> filters on mce->severity and leaves corrected errors untouched.
> cxl_handle_mce() has no such gate, so a corrected error - which
> the generic handler ignores - still causes the alias to be
> permanently retired via memory_failure().
> 
> Corrected errors do reach the chain: machine_check_poll() logs
> them via the same mce_gen_pool_process() path that feeds
> x86_mce_decoder_chain, and cxl_extended_linear_cache_resize()
> extends p->res to cover the DRAM half of the ELC pair, so a
> routine DRAM CE carries an address inside the region resource.
> 
> Filter the record as nfit_handle_mce() does. Commit fc08a4703a41
> ("acpi, nfit: Fix the memory error check in nfit_handle_mce()") and
> commit 5d96c9342c23 ("acpi/nfit, x86/mce: Handle only uncorrectable
> machine checks") established this filter for an equivalent handler
> on the same notifier chain; the consequence here is more severe, as
> the CXL handler calls memory_failure() rather than recording a bad
> block.
> 
> mce_is_correctable() is used instead of copying
> uc_decode_notifier()'s AO/DEFERRED test because the alias must
> still be offlined on MCE_AR_SEVERITY, where kill_me_maybe() owns
> the reported page but nothing owns the alias.
> 
> Fixes: 516e5bd0b6bf ("cxl: Add mce notifier to emit aliased address for extended linear cache")
> 
> Signed-off-by: Shaikh Kamaluddin <shaikhkamal2012@gmail.com>
> ---

This looks good to me, so:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

If you have the time, could you also share a script that does the below testing on the list? It may
be possible to integrate into the CXL testing suite (see https://github.com/pmem/ndctl.git), though
the QEMU usage may throw a wrench in that. Even if it's not possible, having the tests out there
for people to run would help with any future breakage.

Thanks,
Ben
> Reproduced under QEMU/vng. QEMU's cxl-type3 does not emulate the HMAT
> extended-linear address_mode bit, so ELC was forced locally for testing
> via a one-line debug hack in cxl_region_probe() (not part of this patch):
> 
>         if (!p->cache_size && p->res)
>                 p->cache_size = resource_size(p->res) / 2;
> 
> Steps:
> 1. Boot with an Intel CPU model under TCG (KVM host-passthrough will
>     otherwise leak the host's real vendor ID, and AMD/SMCA takes a
>     different mce_usable_address() path than the one under test):
> vng -v -r ./arch/x86/boot/bzImage --disable-kvm --qemu-opts='-cpu Skylake-Server-v4,+mce,+mca -m 4G -machine q35,cxl=on -object memory-backend-ram,id=cxl-mem0,size=512M -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.0 -device cxl-rp,port=0,bus=cxl.0,id=root_port0,chassis=0,slot=0 -device cxl-type3,bus=root_port0,volatile-memdev=cxl-mem0,id=cxl-mem-device0 -M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=512M'
> 
> 2. modprobe mce-inject
> $cxl list -M
> $cxl list -D
> $cxl create-region -m mem0 -d decoder0.0 -w 1 -g 256 -t ram
> $dmesg | grep "DEBUG: forced cache_size"
> $modprobe device_dax
> $modprobe kmem
> $ls /sys/bus/dax/devices/
> $daxctl reconfigure-device dax0.0 --mode=system-ram
> $lsmem
> it will show as below:
> dax0.0
> [   42.857642] Fallback order for Node 0: 0
> [   42.857828] Built 1 zonelists, mobility grouping on.  Total pages: 1010805
> [   42.858446] Policy zone: Normal
> [
>   {
>     "chardev":"dax0.0",
>     "size":536870912,
>     "target_node":0,
>     "align":2097152,
>     "mode":"system-ram",
>     "online_memblocks":4,
>     "total_memblocks":4,
>     "movable":true
>   }
> ]
> reconfigured 1 device
> RANGE                                  SIZE  STATE REMOVABLE BLOCK
> 0x0000000000000000-0x000000007fffffff    2G online       yes  0-15
> 0x0000000100000000-0x000000017fffffff    2G online       yes 32-47
> 0x0000000190000000-0x00000001afffffff  512M online       yes 50-53
> 
> Memory block size:       128M
> Total online memory:     4.5G
> Total offline memory:      0B
> 
> 3. Load the injector if not loaded earlier and derive the two MCi_STATUS values.
> 
>     modprobe mce-inject
> 
>     MCi_STATUS bit layout used here (arch/x86/include/asm/mce.h):
>       bit 63  VAL     - record valid
>       bit 61  UC      - uncorrected (0 = corrected error under test)
>       bit 60  EN      - error reporting enabled
>       bit 59  MISCV   - MCi_MISC valid
>       bit 58  ADDRV   - MCi_ADDR valid
>       bits[15:0] MCACOD - bit 7 set = memory-error signature, per
>                           mce_is_memory_error()'s Intel branch
> 
>     python3 -c "
>     VAL, UC, EN, MISCV, ADDRV = 1<<63, 1<<61, 1<<60, 1<<59, 1<<58
>     MCACOD_MEM = 1<<7                      # memory error signature
>     ce = VAL | EN | MISCV | ADDRV | MCACOD_MEM
>     uc = ce | UC
>     print(f'CE status = {hex(ce)}')
>     print(f'UC status = {hex(uc)}')"
>     # CE status = 0x9c00000000000080
>     # UC status = 0xbc00000000000080
> 
>     MCi_MISC: address-mode field, bits[8:6], must be 2 (physical):
> 
>     python3 -c "print(hex(2 << 6))"
>     # misc = 0x80
> 
> 4.  $ cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0x9C00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> [  221.813395] mce: [Hardware Error]: Machine check events logged
> [  221.814716] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [  221.816200] cxl_mce_debug: spa=0x190010000 contains=1
> [  221.817089] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> [  221.817655] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> [  221.821504] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> [  221.823903] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> [  221.824617] mce: [Hardware Error]: TSC a605ccda40 ADDR 190010000 MISC 80
> [  221.824997] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786375908 SOCKET 0 APIC 0 microcode 1
> root@virtme-ng:/sys/kernel/debug/mce-inject#
> root@virtme-ng:/sys/kernel/debug/mce-inject# grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     4 kB
> 
> CE without this patch:
>   cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>   Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>   HardwareCorrupted: 4 kB
> -------------------------------------
> CE with this patch:
>   (no "Offlining aliased SPA" message logged)
>   HardwareCorrupted: 0 kB
> 
> $cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0x9C00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> addr  bank  cpu  flags  ipid  misc  README  status  synd
> [   61.681659] mce: [Hardware Error]: Machine check events logged
> [   61.683442] cxl_mce_debug: entered status=0x9c00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [   61.684528] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: 9c00000000000080
> [   61.684974] mce: [Hardware Error]: TSC 2eeae32fe0 ADDR 190010000 MISC 80
> [   61.688880] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377156 SOCKET 0 APIC 0 microcode 1
> [   86.504456] clocksource: Watchdog remote CPU 11 read timed out
> 
> $grep HardwareCorrupted /proc/meminfo
> HardwareCorrupted:     0 kB
> -------------------------
> For UC, same steps only status bit information will change :
> $cd /sys/kernel/debug/mce-inject
> $echo sw > flags
> $echo 0xbc00000000000080 > status
> $echo 0x80 > misc
> $echo 0x190010000 > addr
> $echo 9 > bank
> $dmesg | grep cxl_mce_debug
> $grep HardwareCorrupted /proc/meminfo
> [  313.398747] mce: [Hardware Error]: Machine check events logged
> [  313.400518] cxl_mce_debug: entered status=0xbc00000000000080 addr=0x190010000 cache_size=0x10000000 res=[mem 0x190000000-0x1afffffff flags 0x200] usable=1
> [  313.401727] cxl_mce_debug: spa=0x190010000 contains=1
> [  313.402157] cxl_mce_debug: spa_alias=0x1a0010000 pfn=0x1a0010 pfn_valid=1
> [  313.402663] cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
> [  313.405999] Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
> [  313.408375] mce: [Hardware Error]: CPU 0: Machine Check: 0 Bank 9: bc00000000000080
> [  313.408999] mce: [Hardware Error]: TSC e9dd2869e0 ADDR 190010000 MISC 80
> [  313.409367] mce: [Hardware Error]: PROCESSOR 0:50654 TIME 1786377750 SOCKET 0 APIC 0 microcode 1
> 
> Patched, UC: alias still offlined, confirming uncorrected handling is unchanged by this patch.
>     cxl_region region0: Offlining aliased SPA address0: 0x1a0010000
>     Memory failure: 0x1a0010: recovery action for free buddy page: Recovered
>     HardwareCorrupted: 4 kB
> 
>  drivers/cxl/core/mce.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mce.c b/drivers/cxl/core/mce.c
> index 65fed913b221..ee70c1c9f9b9 100644
> --- a/drivers/cxl/core/mce.c
> +++ b/drivers/cxl/core/mce.c
> @@ -18,7 +18,14 @@ static int cxl_handle_mce(struct notifier_block *nb, unsigned long val,
>         u64 spa, spa_alias;
>         unsigned long pfn;
> 
> -       if (!mce || !mce_usable_address(mce))
> +       if (!mce)
> +               return NOTIFY_DONE;
> +
> +       /* Only uncorrected memory errors warrant taking down the alias page */
> +       if (!mce_is_memory_error(mce) || mce_is_correctable(mce))
> +               return NOTIFY_DONE;
> +
> +       if (!mce_usable_address(mce))
>                 return NOTIFY_DONE;
> 
>         spa = mce->addr & MCI_ADDR_PHYSADDR;
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> --
> 2.43.0
> 

