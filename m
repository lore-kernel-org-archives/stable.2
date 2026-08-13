Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012007.outbound.protection.outlook.com [40.107.200.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4227322A1C;
	Thu, 13 Aug 2026 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786600577; cv=fail; b=CsGeCHtTfPRoGZe1jRz/5HGmo6THP66mFdvAxKt6kYnugaK5wfHTBvsniQAAdqYIuODl95C478OCWGVoyB/xKoEsSfe0FIdNErPnCn6+AVhEidqI9wi+29sqBkMbxcWkZTW1DbQ3Ydl0uEx2LJIlKWp0k67RmpuTXw0Z5DmLtug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786600577; c=relaxed/simple;
	bh=wJp5x6bzSl/+VGsPJWJd66rnboLTF4cDmS9rPeJ4X3A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZNdMPuzm9BShHUHX47fIIFxXeSzD1vaXZlE2yJJv0Ic7RTfMULtG6o/LVi/Hs1KO1IEdyyanlt/GdP1rKdMQF88K8+h5zpEon353jhjSsLJGAoayvm2zQ9KK8rI7crpf66M6PAFzy9D1VWCZKGf1KNUMM9vYO0ig0OfzBqIzzzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Og/LdkRZ; arc=fail smtp.client-ip=40.107.200.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Og/LdkRZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pGwveSvaP8nZvvGRRJNIMPqreuDGH9Z3CRZPWj+smyVdwLdvUoPRSFx6HHhpy1qvNGNywP23vyaxgnfmxDP6t0VeEyOG6pCfDUE6dp08p58MTo+h96NkJs12o4aKBADqdV30KPDJeOTLIt4bGI/pVe602+RdNh0puNUHTd8FL7Npa3H0yJ6aBTfS6fcaz/DrtzQUB5qKvKJRBDAKVFkbH0Y85afNXKwu9vo6bs9SlIEiYXagMjyHHFagi6D1tLIB00meAZA4FD2rVrgJtU2XnDJA3uVcXvp3CMCmUzOblRZfQVoB+yBl4+NjEWcRiLktkxKqhyGn8vf/uRf91c1rEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSvMGikNgE5zus4122FZQaZAGi0LeU+OXuLh5KzOoxQ=;
 b=F4X6NqVFo7i4wjQXu08g6IEqbYnJTeqCl6JUsl9ChyY4yikGFn7FwRh/6GBEQQN0r3ypJQ4D1Sgg/vv/FtC+PLiWHS94emR/s00vma29SsfNMgD77gLyhWhkTTAyvysYjJgu8dg3+3l0Kh3BFQLGPDPKAgv0PT/O73s5LMYYtC/aEWjzfokFfgr8xFmotqVTsNlY2PUEb4T65K2ptvQtUpeqEOXF1vGXEnJ0fsCM385HeJK4qz2MBiF4yGzq9heOADeE7B2aGUClzayMt2QOb3fIuHMi/q0JbfH2cImd2r9hqBouFegiOsWjE5wC+by7oCGOq1LAr/UqXbEOpfzw7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSvMGikNgE5zus4122FZQaZAGi0LeU+OXuLh5KzOoxQ=;
 b=Og/LdkRZK9zJnYxfmu0lsMI+nZhsX+BRVozhG5M62fszv09jkQrLxkW4aidGQQ2PjWwiJLk70GGVWPjRMAFonVM+CV095J46N4qZVdPZh6b6trJOn9xDXUsPzOuvpejA2XjS6V3k4pF59IFirCm6gmF1LU8PYQTY/98luziL+D0=
Received: from BYAPR21CA0016.namprd21.prod.outlook.com (2603:10b6:a03:114::26)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 05:56:10 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::69) by BYAPR21CA0016.outlook.office365.com
 (2603:10b6:a03:114::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3 via Frontend Transport; Thu, 13
 Aug 2026 05:56:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 05:56:09 +0000
Received: from gomati.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 00:56:00 -0500
From: Nikunj A Dadhania <nikunj@amd.com>
To: <ljs@kernel.org>
CC: <akpm@linux-foundation.org>, <baolu.lu@linux.intel.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <david@kernel.org>, <den@openvz.org>,
	<devnexen@gmail.com>, <hpa@zytor.com>, <iommu@lists.linux.dev>,
	<jgg@ziepe.ca>, <jgross@suse.com>, <jirislaby@kernel.org>, <kas@kernel.org>,
	<kevin.tian@intel.com>, <liam@infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <lists@steffen.cc>, <luto@kernel.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <pfalcato@suse.de>,
	<rppt@kernel.org>, <shakeel.butt@linux.dev>, <stable@vger.kernel.org>,
	<surenb@google.com>, <syzbot@syzkaller.appspotmail.com>, <tglx@kernel.org>,
	<toshi.kani@hpe.com>, <vbabka@kernel.org>, <vishal.moola@gmail.com>,
	<will@kernel.org>, <x86@kernel.org>, <nikunj@amd.com>, <bharata@amd.com>,
	<Ananth.Narayan@amd.com>
Subject: Re: [PATCH 0/5] x86/mm/pat: CPA fixes
Date: Thu, 13 Aug 2026 05:55:44 +0000
Message-ID: <20260813055544.25567-1-nikunj@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <anXvODEvV4f_Taj7@lucifer>
References: <anXvODEvV4f_Taj7@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd4b775-78d3-40ae-a381-08def8ff9306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|7416014|376014|36860700016|13003099007|56012099006|22082099003|10067099003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	hBed2QdmaJxe/8IGLWe+NryCu3Wq3HmUQamu92apJZ9VLix29EbJuvwTetnjw7Neh7SNJPYzmA9/zUbrNYVAUvsby8wkYczVUczJLymP3Mi6YKSGMpgqSi4Nmnn3WjUIKAt9vjGYROAxS0uxqXNvRAuYU+x5+9HOVZeqPhM74+BRNayZL2ZiJoeHTYP9uylWENyh8RoqiFM7VZPpzcy0P0wPBaiih15bbhbiaZJi5EO7UpWQpZ5GLMhc7IEygCE59Ym7JwHfleBfSTRzvgZxD1QbL5NqyLDYIG/T2/mo48/FukhTzfRjIrXevd9KB8AdG/5nzX16zHeWRyZRkUv9hDgh09oIKr93LAbmQhss2vYxF8E+zz+EN/Rp9tEolyIPykpYmFBKRt9Mg6M/SELJp0MexmxNU0JOfs3dhf9ViSXH8zwhXHjdPKcIhQQo6IO0kQJgdgej1UEbKGfL3/V6+8j+F1Rqp/u9OLAeXuG5ciPbkTjb94w4NBZ73b/o2JnHL9rWhTOrQL6U/WPkiwONoRBCoi+RRwNejiCgDGpAETRVscCb/AhQdX7Tp2MXef6twnl0viI1Ckc6LYi4c/5Rn53TeJdj4SKjv2hMI1a54QbAbEOCQ8P+s8p6Ee0BgGhRO5nZmZ0eRo0E4PiveNyZGrzJJnuxF/n9iJNkKqhjm4fkaItTYq1QCaO2oNcD9SjvC0DGeeEu6w14KjTx5/G5CA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(7416014)(376014)(36860700016)(13003099007)(56012099006)(22082099003)(10067099003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HQLRjanqRWHsJHtdL/8BZxzpbI8QtYMc2mWpBlw3HvlH+mfkHlCKaQ+beRFejTHC/ypSgcHTx+37lAK0DwpfcmuTdVCtF6BCGz6cEQIRxIg75HpI0esZ7PqiRAs+X6lhCtv+lSZytj58oB6+sKhBvbSoOb7sW48p3lpjVlfe5VU2kyRuMQgZpd4mhyD9YmHR+C4BdJxs01zpzeNKUC62Qj1oD5TmD1PQY0Yut/rudH8lTe8t8kYi767bVEQ9y2oNVFcckiwbxX/lsVgLQPm3fJvMNNp7T1wH/T7e95rjlSM4Z90lY2dCwa1k8qhDYR5UBQajRA2VDmXnzpsrVMzaQr02BnaBUZORhdLIHJ1D3w6zkL18hQnV4I3j8BcE4vbNMP7Va40uOY3xxbhRCazBme0NZHXnTnCwvFasOzzpB/8Gii4xTwe1jEV2CpW9A2yE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 05:56:09.8975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd4b775-78d3-40ae-a381-08def8ff9306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

On Fri, Aug 07, 2026 at 04:36:08PM +0100, Lorenzo Stoakes (ARM) wrote:
> +static void poke_vmalloc_pages_safe(struct page **pages, void *addr,
> +				    bool cross_page_boundary)
> +{
> +	guard(mmap_read_lock)(&init_mm);
> +	poke_vmalloc_pages(pages, addr, cross_page_boundary);
> +}

Tested just the proposed patch from this email (without the rest of the
CPA fixes series) on the 512-guest concurrent boot harness (details in
[1]) and still see the memcmp BUG, I havent hit the first BUG though:

  kernel BUG at arch/x86/kernel/alternative.c:2727!
  Oops: invalid opcode: 0000 [#1] SMP NOPTI
  CPU: 1 UID: 0 PID: 485 Comm: (udev-worker) Not tainted 7.2.0-rc5-pokesafe+ #42 PREEMPT(full)
  RIP: 0010:__text_poke.cold+0xdb/0x2af

The instrumentation captured the following before the memcmp BUG:

  SMP alternatives: __text_poke: memcmp failed at addr=ffffffffc06ce1bb len=4
  SMP alternatives: __text_poke: expected (src): 2e 2e 31 c0
  SMP alternatives: __text_poke: found    (dst): f9 b8 9b d3
  SMP alternatives: __text_poke: pfn at poke time (vmalloc_to_page): 8ece
  SMP alternatives: __text_poke: pfn at readback time (vmalloc_to_page): c6ce
  SMP alternatives: __text_poke: page table dump for addr:
    PGD 2f042067  P4D 2f043067  PUD 2f045067  PMD c6001a1

pfn acquired at the start of __text_poke() (0x8ece) differs from pfn
at readback time (0xc6ce) in the instrumentaion.

[1] https://lore.kernel.org/all/20260812063316.21371-1-nikunj@amd.com/

Regards,
Nikunj
