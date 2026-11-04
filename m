Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793812634;
	b=DfLE7ZtMb83q2lCrk9wYEfNUelFm96fCT8/7+vECQtUuBQix2F6Fg4Kh2rOf6vL4Ugjg
	 vCOhiQ5zU6azZEi5jk9PdzXGgW+PuvZ4GRPJBzVy4uPoQs4IXEOefphDY4TK1gbFLz3Gl
	 jNiSVuNY3IgTPIfPg7TRW6826Fux4clxHiuKat4nP+/IBg4h145ut8lfHBKar3IWHdt1I
	 K7pl52aP3pCDKjxXChrOMjrbWH0n5iCYTJvJETOlMlKoBB07lqEPeIIUViLODVcUB363I
	 GWWGYQqbMSEqPG7EeIExHOY1eadkDP5n3x9bzM5rDdlaqrrp16aENmuDf6TplCW3+7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793812634;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 CC:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2a9nj85GgAHRcrZfTxnIuENU34xXt0EJ0rqjSE+rjYc=;
	b=lnGE+nuBBSefalJIE5VmtAQasztQX97GHbVCSOUdcYvUS3LOxvPDkLSHGDv9fZj6rX0c
	 3iraW+qD7wm1hqkD2modWQ4SnP/mJUGjR8PHO5mvSZ+nNYdusPOX43X7UV1wHj5DcBVdU
	 cWumnVl8+qcoMoyKdb3DIut3na3khmsrF6ZIf/m8FsFqHmgKZJxZ2zaG7Yc99qHy9j82k
	 ba8WKnVU2A4zAofCBhcDHu0dlTcAr2I11uuE+tuLlY7crvXhWTDzYaqRW09E1Tqc4fWEx
	 /6kXJiMC/FQK/bF/NS2R4t4O88vX5l/2EKyB8KwxEEZBMIBFYu/hzpPRlXJpEWmBMKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rm9aF1ts;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.22
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010022.outbound.protection.outlook.com [52.101.56.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D00606A31B;
	Wed,  4 Nov 2026 17:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23D00606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rm9aF1ts
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VH5SvwdhM20PrtB8ZjETjQgaJSn31TGQtmxGSLaFYHj4r6w1QQfO0DiJ1PcmQmfIbwjDwThNbdujMA9xIcd9R4BU4ICesuZz+Navw6U5DaOlKYeQ5MNLEuA3sWiZsqdP+VpWnYcMFK81oN+Mf/JiwsPnPE83Wz6m7k/6V/T4aZd5g8fJy14Viwk/Adrg5zOYXdx4pp7Sgwm8/tnT89G2mcOVYYKb91b3aRsv0nqicON8wWQqJrJFGpELZupxzGaRKrRjol9udLNSXnjsDbhId1JTZ3f6idHWg6gVv6K0cJuDbUuxn+e6TR02gQer/OSazvzqZvOJrfgSC98GWwndTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2a9nj85GgAHRcrZfTxnIuENU34xXt0EJ0rqjSE+rjYc=;
 b=qmxpId/FXSCN/ig/EI/pNfYF7ecYAaAHB/fK8puXOW0UMbCi230yiiWmXYWmOykO+0/+k2PbZft/JDWWcORAsS4D6bAq2gqnEK2qrIdgOPSkSfP+mQO7pRlIOiwYoPluxKqoaeNMVo3ECwcsitsuZmb2jES5y2FuIp0Bd1KBVFTQAXMtbSkRLTRTuy/7oSC9OzKfU1eM5tBsryNenIgw8+UMMwA9PVe16yK31oMFWPGzZalrMlVFdkn3By/nFnAVISG69PkxxR7/sXPCrTEX2zXbCRZZi4Xdkfw4l+2U95pYSZcEUzV679UT6whEWJNtJCYq5Pb6knJLaP/8KrA3sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2a9nj85GgAHRcrZfTxnIuENU34xXt0EJ0rqjSE+rjYc=;
 b=Rm9aF1tsS1DpQnv00byhbXyrDKwogEf7FAW35NcvWOx1FHWpeFhswm1eUu8XrJEGOx+/jLiy/z7qSpS2Zyl51/wPdraSlfAdfLcrnGCw0HQK8k6Gad6PwDt8soCVYtwjbuRbl8GppJWnUyxc1cktv6frZ9vDoJlCmi6tJPbsXOk=
Received: from PH8P220CA0059.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:2d9::7)
 by CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 17:17:09 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:510:2d9:cafe::15) by PH8P220CA0059.outlook.office365.com
 (2603:10b6:510:2d9::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 17:17:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 17:17:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 11:17:00 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 11:17:00 -0600
Received: from [192.168.19.2] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 4 Nov 2026 11:16:59 -0600
Message-ID: <4cd83347-7c98-48d8-8883-2fec24e201b0@amd.com>
Date: Wed, 4 Nov 2026 12:16:59 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/CPU/AMD: Don't print reset reason in VMs
To: Yazen Ghannam <yazen.ghannam@amd.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Mario Limonciello
	<mario.limonciello@amd.com>, <xen-devel@lists.xenproject.org>, Ariadne Conill
	<ariadne@ariadne.space>, Sean Christopherson <seanjc@google.com>, "Juergen
 Gross" <jgross@suse.com>, <stable@vger.kernel.org>, Ingo Molnar
	<mingo@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20261104013026.185392-1-jason.andryuk@amd.com>
 <20261104151820.GA716491@yaz-khff2.amd.com>
Content-Language: en-US
From: Jason Andryuk <jason.andryuk@amd.com>
In-Reply-To: <20261104151820.GA716491@yaz-khff2.amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 162ac3d2-d68d-43cd-88cb-08df3a977510
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|7416014|1800799024|22082099003|18002099003|10067099003|261102123227099003|11063799006|5023799004|4143699003|261021123027099003|261026121527099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|261022105027099003|260925022911599003|261021121427099003|56012099006|260925021311599003|260925021911599003;
X-Microsoft-Antispam-Message-Info:
	feS7RXoyVg7zwk3WxLJQHRx2/j8+vSmBO3tyDpIqw9d7pX52ciNCccC+PN2PhW7hzrv2yJlqCYevE27Sdv4mgVp0xx/4rk2+4+F15eAAoAywe52SMgGafiht9IxmATTaYWEhjinOofqyGwZ7znrD2eE2ECt7d8wc+xlM+kQ/zL8FLQLfzrQ7/irwfso8mqSRnkTwnpeipsAPdtFShFlvuH0RB1ZqvGfo2Qrm6GroOZjWuE8rtMMr0n7oaoj2feOhZh49P9ANIqTL5HAFfRb1tPR0BvekO1VBkFRvJ1U42F+cmcFeyy9N8MQ+GNdj73yVrI6x1mEt2+3/hpNL+VqS/stdnj3gocS8b4t868aHfHrfcQkVjNnhkQa6PcaYRlJfms0qggKbDf086dHBM9qqfTVDNwWqRfNXxY12VmJ4JvkyfOa0rZgDgbnqkAQFzV6++o6/Xu+iQg4cEBO5iktfeFNvs7HcXWS1Ctktt2OkmjpfDGrF+y6c814kq9g6NMdYTxwUCC5zwyMCJ/2VCa/XLaIa1qzxZwA+H3ACsiqLaTy9lSMlJ0KaH6Md8fpdCtJXr4NwN2NKTkiq9fsMvMurH5HU8oX2FESf7y1oBVyofEH8W+Xv5KZ26NpVGnWtRNIFuCRV/CVHeyy2SwLEnikUL83MMdyXq2ViBgjIjD0w1fI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(7416014)(1800799024)(22082099003)(18002099003)(10067099003)(261102123227099003)(11063799006)(5023799004)(4143699003)(261021123027099003)(261026121527099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(261022105027099003)(260925022911599003)(261021121427099003)(56012099006)(260925021311599003)(260925021911599003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	gRfP2mCEPcxlVCCDG86YObuTqFmaIhX9PDmGvHeX6rTEnMLgSPFMvRxnaCLgfSl3bGpQiOOWnPaGv6k+2BwLoNcX03nm1swSVmwwmFkNVljl20J0WWNV0dgyxo4QunCWxoZHpXsDd1yqqDYeinSjZc6Dtz3+Ex92hU6VuI4gE9mrfUbo+9fticZb/4lVu/l71spmawxM93UTjdW9O0hQdgHJcEe9XrlHHQa/5f7jPQr1uHOYeVMeIv+GOmHLlVppqON744K7o1BDh7PnhQzsrHpmCGV+KhS7i++SVQScwCzW6G6jq/Rub+fz2OqjLtOndgeYULvAQzyAgEch20pibpHpSlny8r4Sto+LQnLzbZkhT035mgvBZj+HSEh91zknVl0k4/teRXaiZK7RGSu5qKlAeRyXc4vL8Zj5gqA2ylnDylt4jrsvIgdBn1HCjrDp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 17:17:08.6996
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162ac3d2-d68d-43cd-88cb-08df3a977510
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692

On 2026-11-04 10:18, Yazen Ghannam wrote:
> On Tue, Nov 03, 2026 at 08:30:25PM -0500, Jason Andryuk wrote:
>> print_s5_reset_status_mmio() expects to read FCH MMIO on baremetal.  VMs
>> don't have emulated FCH registers, so there is nothing to check.  Add an
>> early exit when running on a hypervisor.
>>
>> The real motivation is Xen PV domUs can't boot on Zen CPUs.  PV domUs
>> PTE contain system physical addresses - they don't have concept of guest
>> physical addresses.  domUs can only map physical addresses they are
>> assigned, so a domU fails to map the FCH MMIO addresses.  However
>> set_pte() does not return failure, so ioremap() returns a pointer while
>> the PTEs are unpopulated.  print_s5_reset_status_mmio() faults when
>> reading through the pointer, breaking the boot.  This change fixes Xen
>> PV domUs booting on Zen CPUs.
>>
>> dom0 can map the FCH MMIO, but it has X86_FEATURE_HYPERVISOR set.  With
>> this change, it no longer prints the reset reason.
>>
>> Fixes: ab8131028710 ("x86/CPU/AMD: Print the reason for the last reset")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Borislav Petkov <bp@alien8.de>
>> Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
>> ---
>> dom0 could work, but that would require a xen_initial_domain() check.
>>
>> I've wondered about a different approach:  We can't directly check for a
>> device for the FCH_PM_BASE memory, but maybe we could check for a PCI
>> ISA Bridge with PCI_VENDOR_ID_AMD.  That might be close enough to
>> indicate real hardware?  But it would still be a heuristic, so I'm not
>> sure how much better that would be.
> 
> Maybe, I had an older version that used the smbus device / i2c driver.
> https://lore.kernel.org/all/20230407203720.18184-1-yazen.ghannam@amd.com/
> 
> Is this available in dom0?

lspci shows 00:14.0 FCH SMBus Controller
Kernel driver in use: piix4_smbus
Kernel modules: i2c_piix4, sp5100_tco

so, yes, it seems so.

>> ---
>>   arch/x86/kernel/cpu/amd.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
>> index 40463bad1078..580ccc2ce5fc 100644
>> --- a/arch/x86/kernel/cpu/amd.c
>> +++ b/arch/x86/kernel/cpu/amd.c
>> @@ -1357,7 +1357,8 @@ static __init int print_s5_reset_status_mmio(void)
>>   	u32 value;
>>   	int i;
>>   
>> -	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
>> +	if (!cpu_feature_enabled(X86_FEATURE_ZEN) ||
>> +	    cpu_feature_enabled(X86_FEATURE_HYPERVISOR))
>>   		return 0;
>>   
>>   	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
>> -- 
> 
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Thanks,
Jason
