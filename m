Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012000.outbound.protection.outlook.com [52.101.43.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA304432FF;
	Fri, 25 Sep 2026 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790317998; cv=fail; b=ePALXHPPX9BSZuInP5E4DneprMMndrUsHzLE8Ryu0Zw+uBehorZhpcJekARfwjt0omPZNj5jmXYdE+ExekB3JJPxGtFkuj0sYjng4Nl0h8O7w4FoR5eaehPTvte5egjFR8YzAwtu7/GAvmxwT288B7fhYpvNmxwOfLHIKtRMiGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790317998; c=relaxed/simple;
	bh=cWe5aip5IahY1IpOQ8S6hqCgZo1B6r9dPS5cNimXKxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T22NCKCbmvUKQGYOIKfD0b+qFBO2aIgiW9jg2rHRtqGYjaX54HVS2nGmBoY7RTeir1fPv1dIkhHD6jTAogv56VSNxmlTfjZNzXkaQ5IhgzAjEbEvg8isrQbsIrJRRfcbj3sfl2q7G+hQAmoBQChN+51AEfR5dwRTYQtCk+cq0QA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bnpKDFDy; arc=fail smtp.client-ip=52.101.43.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bnpKDFDy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJwJK8x9y45wURrOK5O9Ya41U8Vtxg4lN9xJXtv1bGDWEKt1ivoTJwUrFzPdQ9NAakOMwLZUZWNanJFx91b5XjudApu9NhZOhWHwh64u7vtD8HBN33L3u7CLT8hcVRgt0rDY16138tXBBoV1QEYgrZ7fpv2Re3B59OQjyYjY4mUj4HigRd3D2RzxngTK/WGrFyaWJVx03iV5Mu37/xLOUtxhwJ4ghBBLb4zrO9b9fLDS2Qx6h+eR7aXzOUAmgi/1tPBJI80tK8CzB9kLb4QNz/ecMPPByZS9HNvo8grMdYkxvaQT9iqCKM0rKigWwaFJrXiIzQqGyDXGNupTB2n/qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qvXnIbnim7ip1ox4SYDw8tGjRyr7E9bmooSJ3kxTVLU=;
 b=qvBIEmFwQ/+cmXvN+WQBr2MeYGMBrmh05RYqSzcSAor08seqiaubHgisYZKUMavO9LTktgeJNlCw4vFIttwjOe92Sz1eX5CigTDNJmHSqnUk1e3qs2chYKAG5ADLco1u+kdZf1pEABfYK8a2rKv2t25Y8/wpNZEOGa1+qOhkIo5LGi+9u6PRmeGHbkZHTkZiC+T0dj5mjfMIxv4kifFrSoCvLHOUZwG+qcBOOO+FxhFPt1O5pRqAy+zPD/+FoYMYZZVVlwcbdJ1ZrJRnbppG7TVTynL27bfFj3qRcsbHqZT+f/CcrbJAV0omoCn4hzTZKwVEzKl/XxCfXCoMWAE8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qvXnIbnim7ip1ox4SYDw8tGjRyr7E9bmooSJ3kxTVLU=;
 b=bnpKDFDylNwrGfHxWs3KmWDRZFGxalKsRsJOHpf8hPYuE/GviFzAlONMC4PmI3J86kVZBU3sVJrdj0SKnySOiKAtf4sYTcUGXsBpURvHgXjoW5Kz1tmpAVZ8guHarCShJ8tpUupCfx+zGrFbVxa//Z6T3/v4/XyTQHAqNmMbX44=
Received: from SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::34)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 06:33:07 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::84) by SJ0P220CA0003.outlook.office365.com
 (2603:10b6:a03:41b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 06:33:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 06:33:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 01:33:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 25 Sep
 2026 01:33:06 -0500
Received: from [10.85.35.99] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 25 Sep 2026 01:33:04 -0500
Message-ID: <f0ff1193-8612-4eee-9997-4ef3ec215977@amd.com>
Date: Fri, 25 Sep 2026 12:03:03 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
To: Yosry Ahmed <yosry@kernel.org>, Sean Christopherson <seanjc@google.com>
CC: Paolo Bonzini <pbonzini@redhat.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Stefan Teodorescu
	<fane@google.com>
References: <20260903223258.486034-1-yosry@kernel.org>
Content-Language: en-US
From: Nikunj A Dadhania <nikunj@amd.com>
In-Reply-To: <20260903223258.486034-1-yosry@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: af24912e-8ef6-4f91-e72a-08df1acedc6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|6133799003|13003099007|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gYfExFccB+WZt3OvefJn87QeuKyQRqrgPRATRhTJETHr8Xo7070pWAvMXg9lOX1pXA7257Dbm8nDdyHKYb/HhStcslHcXELczgHE1a7UMjKABd+82V3oOPW5YxRFleAd+6Yvu0XDkPR6VjMdBnmBf+Z53dpnjNNvB63FNd2gUpIM2wLBZGMw4Ov1oqHQNEz6rU7pFyQnmdagwtFO3qKdA540ZOCUoWGN6Jebhj11uCtrFtPvDxW8qklEQ1cp1IFMZEmLgqtak7EDxn9Ee+K/tedKoYl51KkPp9SjR9jU019cagYbob3HqYUaVdULekqvlNcbhUVKhtOSIcSJ81shqB0oQdw+U5cZMSI03PEnoP5KrRDtqiw5FB3llh9tlDLFXU9I7wNiA0H+bPsvyAiu0ydcOsAtNRKfbYFiFWJ4M53HmtjLrdbyO5j125sRSPkExuN9/yhaym/jtK1xxqSThwJ/kE/rM0wslGZ3ynhDRdqhVuMzaqPBU2Yp3h+e+gbXlHfboI+CYSA7eEIqqLeY4CYYSOTiekrOOaLsbJQNgO6fmxPD/BsRyZE5jQsOtQdQkFjpybr6vs5XB0h3J6GAVc8tGXDicuPVID49ghVsqhvBO9JK5udIpEtGA6N7YWn6bx+6R6hdCczFhm6TthtuCcrYdAZSwLvJ00bVyWF9iYsbvuBY4AMVxgOm7Te0ayQV8q/ymbGgIAOam6Sd/SQz0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(6133799003)(13003099007)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZcJZTKIaKKJ4vEH6mXUHkSlHsT+noAd+qdeegc6O9Iz4HUELF0146YkmONAuw1N1SEDo6zB1dAdka/RHkDeAI4xgQkhQXbK5iVJGUgS9sy1XkKBAv75gfX27JdlXC0PUD6g4W/9JMYLWCJes7UH9YZL0n5rfg2ySUUC3fAdcQNR0zpQnZzTUeRn+gUuMWtjtFcoI5xnDc9uTJMRYeseqC5eDxNhSUo93t87E4bVSC9uee25O59VkvLaBTt7poAYf9JukA44dt3G2gCMd61Gl9+cZtfxJqm/LoPFgMp/qz3Ab/R3fm4qwcf1I7J5PEjP6LmNQvDmAxF4iUakdEcWr2pwIH7If3w+tkfxhJJSmkVFS0h737FBAwOgAZh9UFZJl/tx9CUqKXXLDo7geC6Cwx6rZmR51Un8vhH3s+PyZ0xxZ5Xh6gKkDmlpVMjHrVd6/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 06:33:07.2205
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af24912e-8ef6-4f91-e72a-08df1acedc6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249

On 9/4/2026 4:02 AM, Yosry Ahmed wrote:
> When the pCPU where the VMCB was mostly recently used is switched, reset

s/mostly recently/most recently/

> the ASID generation in both VMCBs, triggering new ASID allocation for
> the immediate VMRUN as well as the next VMRUN on the other VMCB.
> 
> The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
> nested transition. However, since pCPU tracking is done per VMCB, it is
> possible for one VMCB to allocate a new ASID when migrated to a new
> pCPU, and then the other VMCB reuses that ASID on the old pCPU. This can
> result in the same ASID being used by multiple vCPUs on the old pCPU.
> 
> Example scenario:
> - vCPU runs on pCPU A, vmcb01 is active, asid=1.
> - vCPU migrates to pCPU B, vmcb01 pCPU changes, new asid=2.
> - Another vCPU runs on pCPU A and allocates asid=2 as well.
> - vCPU migrates back to pCPU A, and then switches to vmcb02 before it
>   runs again with vmcb01.
> - No pCPU switch is detected for vmcb02, so VMRUN is done with asid=2.
> - Two vCPUs end up using asid=2 on the same pCPU.
> 
> Keep the VMCB dirtying to the active VMCB only. Clean bits are tracked
> by a pCPU for each VMCB, so do not unnecessarily dirty a VMCB if its
> pCPU does not change.
> 
> Additionally, initialize the tracked pCPU for vmcb02 to -1 on nested
> enablement as hardening, so that a new ASID allocation is always
> triggered when nested is disabled and re-enabled.
> 
> No performance regression was noticed when overcommitting L1 vCPUs in L0
> (to force rescheduling), pinning L1 <-> L2 vCPUs, and running CPUID in a
> tight loop bouncing between 2 vCPUs in L2.
> 
> An alternative (and perhaps more proper) fix would be tracking the ASID
> per-VMCB instead (e.g. [1]). However, that's a more involved change, and
> it would result in having different ASIDs for L1 and L2 without actually
> properly maintaining them. It would probably work because all TLB
> flushes target the current VMCB, and the other VMCB is always flushed on
> nested transitions, but the code ends up in an arguably more fragile
> state. Punt a proper clean fix to an incoming (and overdue) overhaul of
> SVM's ASID usage [2].
> 
> [1]https://lore.kernel.org/lkml/20250205182402.2147495-2-yosry.ahmed@linux.dev/
> [2]https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.org/
> 
> Cc: stable@vger.kernel.org
> Reported-by: Stefan Teodorescu <fane@google.com>
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
> 
> v1 -> v2:
> - Make resetting asid_generation in vmcb02 unconditional (Sean).
> 
> ---
>  arch/x86/kvm/svm/nested.c |  1 +
>  arch/x86/kvm/svm/svm.c    | 19 +++++++++++++++----
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 73f37b050d0a0..0c55c71fc6010 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1494,6 +1494,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
>  	if (!svm->nested.msrpm)
>  		goto err_free_vmcb02;
>  
> +	svm->nested.vmcb02.cpu = -1;
>  	svm->nested.initialized = true;
>  	return 0;
>  
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index ea647938a2a65..762b6059eda31 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3765,14 +3765,25 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
>  	/*
> -	 * If the previous vmrun of the vmcb occurred on a different physical
> -	 * cpu, then mark the vmcb dirty and assign a new asid.  Hardware's
> -	 * vmcb clean bits are per logical CPU, as are KVM's asid assignments.
> +	 * If the previous VMRUN of the VMCB occurred on a different physical
> +	 * cpu, then mark the VMCB dirty as hardware's clean bits are per pCPU.
> +	 *
> +	 * Reset the ASID generation in both VMCBs. This will lead to assigning
> +	 * a new ASID now, and then again when switching to the other VMCB.
> +	 * However, this is needed as the ASID is shared between the VMCBs, and
> +	 * otherwise it would be possible to use an ASID allocated on one pCPU
> +	 * on another, for example:
> +	 * - vCPU migrates from pCPU A to pCPU B, allocates a new ASID.
> +	 * - vCPU migrates back to pCPU A, and then switches the VMCB.
> +	 * - The new VMCB does not detect a pCPU change and runs on pCPU A with
> +	 *   the new ASID allocated on pCPU B, which is potentially used by
> +	 *   another vCPU/VM.
>  	 */

Nit, the example duplicates the one in the change log. How about dropping
the bullet list here and depend on the change log for example scenario?

Either way:

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>

>  	if (unlikely(svm->current_vmcb->cpu != vcpu->cpu)) {
> -		svm->current_vmcb->asid_generation = 0;
>  		vmcb_mark_all_dirty(svm->vmcb);
>  		svm->current_vmcb->cpu = vcpu->cpu;
> +		svm->vmcb01.asid_generation = 0;
> +		svm->nested.vmcb02.asid_generation = 0;
>          }
>  
>  	if (is_sev_guest(vcpu))
> 
> base-commit: 76671054f9a1ff6abb976583cd8da37650acdc97

