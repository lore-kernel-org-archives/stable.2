Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013008.outbound.protection.outlook.com [40.93.196.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67A39446B;
	Tue,  1 Sep 2026 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788263995; cv=fail; b=bcoGCOyaA2VC5M/Qkonc2jWOp4LDlc+JL1reiMmbkzm6syqyruC7jO08shOFIvsxycfYUvkoer3yzqnQCUkzaKaIbKQmMQSWbXFRltS4DOsdl7vkdcb55E5sq1k7L5ElajGt661ntw39ntAZGA608Rj9dNEygHV3A1kDdGqiE1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788263995; c=relaxed/simple;
	bh=IB68msNX7LPSPD6joEjNOZYBoEaivEx0aZ8LnTWBFxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZLABbhkMvC9XJoc4Ru3gUPEZAnl1k/nj/LIbRFivRJ7eJjOPB5CVEEAznc387wjq0eLxvI5YR+Y2s76QQPyAHj+QL0/wbHJwUbczafevb9+y2FN1CEs1dVUcVknN2oJLpz/wYQKz6fdWJOzK6D3ONr7tZEDPYUmgbstZnkxNaio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sVNvzWir; arc=fail smtp.client-ip=40.93.196.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sVNvzWir"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YhwZngsqGRAGDmybMznjoBPXYVfMjI0e45DskN2vMhOhQ3WKv36h4cwVW46PNG8lw5lndE8kjcRn72Tuxgvu1ujtqVHcJhCKgKZiEoqhihWlqu60Am0dVRiLXv7pp8mEpSYzyjac5HdCP2i470SYhVSoQ1NxiP4QkVVKIgc8Vsp+6XvodhR7X5QEmvokC3l/UctpBfsmKWcTvJKOU4QSK/SDmKIuxaf6m0zwfHdaherQlSqdZkVdvSNpawFrjEjbQELZBp5rP7nOI12C5U0OuZe0rf/U4OGyeBXpgwyEFcMwqaMcsY3RoGwUwlqMI+dGdtAoyYj2wFuXw7PAqs7wOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mdk955cuj59ek9QBetSLOBDZ89QyoIuFaxuEcMq0V4=;
 b=uqQB53vAWwrrS91fUxVAi0brOyf+M+2WDeZFl7P4GLNxiunIYNG2j/ny1UCp0UQndqQP2M4fqzZ4U6BPQpth2cOGidWyCTnxiwa8h1Y37IeqAvTD/Ho6VjswAQxSJ3GlHhrUk6qUbf2gaO3AQTpaB4OtEfVnUiIbPtPtvJSeHgubjPs/5Xl/LrQ9tv0sy2OQPBlgwoCuPhtsrTXo6GjXRmo7bQm/xEIaf5MahLs/WkiucPaYf7Pk+i7LrUyheithrJSqTqHQkqCH21FS/II3xKWiv/nHsAlsfahSZHUBKlEMm3UYfDEs8RFi8iRByGOGWR/Q2v8BmjqOkLV4zKVn0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mdk955cuj59ek9QBetSLOBDZ89QyoIuFaxuEcMq0V4=;
 b=sVNvzWirsMWpHM0FBh9zyvK0TJDz3X6rIxHJ2G7BBH9JNB5x7R+95+ET3s2Esc1mqP4Eyx/Aw808ZenRlQPOdvWSqI/0L9JruAz+eEfqUKu/6Umjmkxv+2iDdrx63J1tTZn27zZR81QUzEnmbfsN7Xmhs5g2V+YisstF8CmjHLw=
Received: from SJ0PR03CA0341.namprd03.prod.outlook.com (2603:10b6:a03:39c::16)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 11:59:49 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::4b) by SJ0PR03CA0341.outlook.office365.com
 (2603:10b6:a03:39c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Tue, 1
 Sep 2026 11:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 11:59:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 06:59:47 -0500
Received: from [192.168.19.2] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 06:59:46 -0500
Message-ID: <05dce607-fb34-4962-be0c-9316ee8f4be3@amd.com>
Date: Tue, 1 Sep 2026 07:59:45 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] x86/amd_node: Remove smn_exclusive
To: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Mario Limonciello
	<mario.limonciello@amd.com>, Thomas Gleixner <tglx@kernel.org>,
	<x86@kernel.org>, Yazen Ghannam <yazen.ghannam@amd.com>,
	<linux-kernel@vger.kernel.org>, Penny Zheng <penny.zheng@amd.com>,
	<stable@vger.kernel.org>, "Mario Limonciello (AMD)" <superm1@kernel.org>
References: <20260825214805.39148-1-jason.andryuk@amd.com>
 <20260825214805.39148-3-jason.andryuk@amd.com>
 <20260831023016.GEapTnOHTbN8XZGe2j@fat_crate.local>
 <13e77e26-7b4e-452f-bc61-a84acadf37f0@amd.com>
 <20260901002705.GFapYb2c6fPJYqokRi@fat_crate.local>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20260901002705.GFapYb2c6fPJYqokRi@fat_crate.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9dd6b3-3509-42d3-efd3-08df082085c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|13003099007|10067099003|6133799003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2vsqQuBW9rIeIx15tYfGEyTyNSCmqrKm+ZDVFLU3qss4y9zsslQIahVkOrxv17HbN0orQunn2Cq7EeIPTgpWYzlV7sHJkEYxgqtR1gGqeyUo6YnF3VnvNhuIzzpEt2oEJSUEev7kjgFBl4IEWTPsb+fCthZLq+fNg7nFDIT7o1z0pmuWMveMxgm96VNGvVBCeQ32zwxGHAQgAspbQVvMMV5cVF/pE4/GPiiMh49DmdZZ9RcRIEgCnVlVOv1yNxeOirTGmCvHhSL+2SA2JTBVa8m30UYEI+JuxA7/sFHd/ncGQQ3nYDCia9YOMEeG5cCpHI7PazuNX8IGvoLGlMFOFi2Etc+GpgMg03c0Qt9SpypXWLZvu0nTIBJC3GZz5OGITwFpwxZEAjAvqWqZXW+MUuyhnwbL7bPcyWBXxH4ILT4sPg5tVzk5MkWrDITqbOgO2nb9GD1gjyn9FQGaDrXTkwQghboF5DcvqBaMq9ddo0eACxAaZrRDbxfjt25UPqvc4YjXodmVG0FbMo0D9SkN5uKWBEUQdWaOUVQSYppUyz+c465G3ktid9xjXBCM9CEFi7RlRop4P7toxFouVefqwE7izJMePFJquWMlaLFLvIcC8VT00PCjyDRnDbahj46j8t0200E2XUU5poq8+9gpqSDPpk9knxg5SazQmefDhdo=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(13003099007)(10067099003)(6133799003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	30gks7Ewlynm2LZUgg+50KhNi5QrHqoJS8UBocEs234TD62gpwevfG5TV+os07WCwSA3r9MJQoqieXdVpFqBiwxQOwcfytMvywLNEsgzxdeeNwW9jcII+WRawUzmqRrAeFGQHhiy5g99zSSh6/WBzucyv61o3bAerjAxiTb4HY3HpvvM4lMXCbTFfL5QEHNkIP4cBNBxTjOG2D/FsaVfIdNHGsZzTYoXdJIMKBS2d9pGmN32Tw9uYw8Dfi80VL55Vvk95FmqxjvH8wdWMxKbfjh7peHxlL6+QWcW0P5aDaOLEoyKAeF+wAPea9bmuJJgxJ2gPf3dwQz17DkYPtXFuSug5XiV7hs1z6K+wb0FjOrDKu0ymBLP28gWvbTkdxIU1urXeKygghCQm2q55YHPiHAaPIX35FP0m9BC/PszalyEpbsOhDv7CcdXniTwMxY8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 11:59:48.5070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9dd6b3-3509-42d3-efd3-08df082085c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076

On 2026-08-31 20:27, Borislav Petkov wrote:
> On Mon, Aug 31, 2026 at 01:52:08PM -0400, Jason Andryuk wrote:
>> No, the code and the comment are both correct as posted.  It's just that I
>> wrote the comment reversed from the code to state the positive property we
>> want.
> 
> So if amd_smn_init() succeeds, that means we have registered the PCI config
> regions of the PCI roots, including the SMN ones, as IORESOURCE_EXCLUSIVE and
> they won't be exported to userspace through /dev/mem and what not.
> 
> So, any caller of __amd_smn_rw() should fail because it is coming from kernel
> space and it can expect that userspace could interfere with the hw and thus
> not a good idea.
> 
> So yes, this is what got me confused and the (!amd_roots) check is correct.
> 
>> I'll change this whichever way you want.  It's not a big deal, which is why
>> I added the comment like you requested originally.
> 
> I think I already "intercepted" your suggestion, see here:
> 
>  From 1a1c4addc5a14e9ef2bb7d351a62ff4563d0f10a Mon Sep 17 00:00:00 2001
> From: Jason Andryuk <jason.andryuk@amd.com>
> Date: Tue, 25 Aug 2026 17:48:03 -0400
> Subject: [PATCH] x86/amd_node: Prevent potential NULL pointer dereference
> 
> amd_smn_read/write() are exported functions around __amd_smn_rw(), so
> they are always available even if amd_smn_init() fails. In that case,
> amd_roots is NULL and __amd_smn_rw() will access uninitialized memory.
> 
> Then, commit
> 
>    83518453074d ("x86/amd_node: Add SMN offsets to exclusive region access")
> 
> added smn_exclusive which indicated the calls to
> pci_request_config_region_exclusive() succeeded to prevent concurrent
> userspace access.
> 
> Commit
> 
>    0a4b61d9c2e4 ("x86/amd_node: Fix AMD root device caching")
> 
> re-ordered initialization so pci_request_config_region_exclusive() is called
> earlier and a failure exits amd_smn_init() before allocating amd_roots.
> Setting smn_exclusive moved to the end of amd_smn_init(), after amd_roots is
> allocated. It became redundant and can be removed.
> 
> Replace smn_exclusive with directly checking amd_roots to avoid a potential
> NULL pointer dereference.
> 
>    [ bp: Reorg commit message, touchup comment. ]
> 
> Fixes: 77466b798d59 ("x86/amd_node: Remove dependency on AMD_NB")
> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
> Cc: stable@vger.kernel.org
> Link: https://patch.msgid.link/20260825214805.39148-3-jason.andryuk@amd.com
Looks good to me.

Thanks,
Jason
