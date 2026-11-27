Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773906;
	b=Bj1GKGNgfk4fhzzdokithh9WIgC45ihINuXhb4sodzU29O9WsIBsBIIO5Ai27x78G7UF
	 FBONueFkAabvPC8pIKuJStUyqgVVMn8n8r0mtBXnwtaYNPremNBciIm7jYPwvZbJhE9F2
	 R16sPXyLET4GnzqNuBW4/Gis9EGQnM1/H3DZv0Rvi2QxEWonmFClIhdqjUNHyDWbpBPlE
	 cdrfNo2TqbQchzFyO4Nnb0FkNHx+72Rbek+lfoiB5ShvosOk9L3XSvdfShM54nVS8ODk4
	 dsqreWnVb0k5QTEW34ClDVROuE6rC5jjJhN40NcAZhysQwv1fHXlOiysnddgzbQsUSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773906;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=Jdy71fDeHqZs/zP5Euv9gPmm/MC+wKfOCc3L+nx9OrA=;
	b=H4t4O3fzk3x1BmDtZR651gpKRX/2qU/lm8kEUKSu/ukjstxW55YBe3SQsDi5b1C6YwWe
	 WydQCsSx93x1ePbvKyP74hf+PuT6aDnErS6Z1FT6lDgoUMTjEBC4zVJEh2CnetZdhV+Xp
	 5cwoIcVgImnTBJPt062MKbKJNTuWJwlF/WKGyrrZDBg9UABt9qPu+2naRpNFCKD2HNAv4
	 PPQ8QX1XdZybp/WPbd/RA4z3D2CIIouo03Gqe3WAqSeQe8WiVJQrEv9D+81sOp4igXxZN
	 sVuA6SGmzkVWHz8A9Z5jCnt6T8+hUkrDq05RR0Hw9yjpH0oZd+Ek6s75g+bwaGKdlzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q7ISQvpc;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AA2606A32D;
	Fri, 27 Nov 2026 10:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2AA2606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=q7ISQvpc
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7Yk3g2489554;
	Fri, 27 Nov 2026 10:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Jdy71fDeHqZs/zP5Euv9gPmm/MC+wK
	fOCc3L+nx9OrA=; b=q7ISQvpcozp8OifhYqGeNE3+q3bhPdC8E/tUFmN+aHLv2N
	kibLaGrZmza0dxAYpiAkEgIITNBBGOgzr9JQBsW4nPy6VBPNmnzNUpFFlu5Hscg4
	SsOUhFejfq4IsUqPI1CpsgMw0oGbmm2U+uu5SgE+dUERsY6kXP8mTQE3D+2UQzcQ
	N5qf5P91WKh5hWy2EELLNEvdB4NGUOnnF25NpXGW2xUnjxrZYcjmWdJmFT7VIOiG
	yHemNJubujXwZDMlOzt5Req6OY3bg8Az/cmUdCuL78XUqiZJ4c6Vk8iCfTb+YoCS
	DjTGrZHxYmCmDeCfJaplPry1G+9009SmI4EUJ5lQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34fkw81u-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 10:04:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7JFKo426841;
	Fri, 27 Nov 2026 10:04:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4j6mjg3mn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 10:04:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARA4hEU55509330
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 10:04:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9CC52006E;
	Fri, 27 Nov 2026 10:04:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3E1F20043;
	Fri, 27 Nov 2026 10:04:40 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.123.6.5])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 27 Nov 2026 10:04:40 +0000 (GMT)
Date: Fri, 27 Nov 2026 15:34:38 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
        Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
        linux-kernel@vger.kernel.org, chleroy@kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCHv3 3/4] powerpc/kvm-hv-pmu: Don't allocate gsm/gsb
 GFP_KERNEL allocations under spinlock
Message-ID: <awlVXFZ-U_hCIUAB@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <cover.1795441238.git.ritesh.list@gmail.com>
 <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52381792ff2e208f213cf250d5122a1ab367de20.1795441238.git.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX539/+ldoRQG7
 eDEv/HElQi5RS9TUYbsAim5wzgzUZ+agNwWDcKDgOxBYWMl9CsC5wauytOc62cLT6M511rT2aYz
 ZmHXqjR57HatMCvjIhYUTVPRNmAEaZs2wWmDImis/FwvcAb0INjgN78mKh852Oga58aIjiKyIrA
 LOJn5BAAjzwH9QuiQdQqVHlyF3VDU81SiVeLPYP7BGbvCrOHvx13PxfkD+aR1HFXT0WLxLfDz2C
 HyMPCBfQoW8Tmxpc+WlVCXgToFGaYparfoF8S81J6L+R7UZXoxxPEvE2Xim8fxd9lgOwiHBwhW2
 B1rG25AkR8+0YVzJgQwcfIhqHt5/Qs7LeGu0rv7q918aTgyHcVNUwMP5HI2MazhNdWGTGnEAniL
 hMUFd7qZRN/47SkMEaKBGtDXyk4UG1z6nQ8M46mkeL90j0VNoT9CC5zrRlLj7ljPtKpjjEvB3M7
 FT9exOUnEKkmVZt7Qmw==
X-Proofpoint-ORIG-GUID: 4WZ7GCtmq_mE0kaSFNCmQUb3EWUR3Zc-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA0MCBTYWx0ZWRfX4YOhK/L+Q42S
 oQnwq0OEo7W7ajt0GVVVb5009emqBYszQpzZPKzv7dBWb2q8twyBdC7V+cXgBq0iFLTqNK5WINb
 UpvmIQUgzT3lIHbLeWebMHwD3sC34wA=
X-Authority-Analysis: v=2.4 cv=A9z5rKWG c=1 sm=1 tr=0 ts=6b0955c1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=MYuXjEPGYuzpEpTdxDAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: HJ3ESf0oHie-dhEVCfD_Cp4BZ0USyWEj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270040

On Mon, Nov 23, 2026 at 07:21:52PM +0530, Ritesh Harjani (IBM) wrote:
> kvmppc_init_hostwide() takes lock_l0_stats with spin_lock_irqsave() and
> then allocates the guest state message and buffer with GFP_KERNEL. On
> a nested API v2 host with DEBUG_ATOMIC_SLEEP this warns at boot:
> 
>   BUG: sleeping function called from invalid context at include/linux/sched/mm.h:322
>   in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1, name: swapper/0
>   preempt_count: 1, expected: 0
>   RCU nest depth: 0, expected: 0
>   locks held by swapper/0/1: 1, on CPU#0:
>    #0: c000000004ad95b8 (lock_l0_stats){....}-{3:3}, at: kvmppc_register_pmu+0x50/0x270
>   CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 7.4.0-rc2-00028-ge5a8bf3a3ee9-dirty #124 PREEMPT
>   Call Trace:
>    dump_stack_lvl+0xe8/0x150 (unreliable)
>    __might_resched+0x190/0x30c
>    __kmalloc_cache_noprof+0x4dc/0x760
>    kvmppc_gsm_new+0x68/0xcc
>    kvmppc_register_pmu+0xd4/0x270
>    do_one_initcall+0xac/0x48c
>    kernel_init_freeable+0x3cc/0x7f0
>    kernel_init+0x3c/0x274
>    ret_from_kernel_user_thread+0x14/0x1c
> 
> The lock is not needed for the allocation of gsm and gsb buffers.
> Allocate and fill the message and buffer without the lock and only take
> it to publish the two global pointers.
> 
> Fixes: f0c9c49c5067 ("powerpc/kvm-hv-pmu: Implement GSB message-ops for hostwide counters")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> ---
>  arch/powerpc/perf/kvm-hv-pmu.c | 65 ++++++++++++++++------------------
>  1 file changed, 30 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/perf/kvm-hv-pmu.c b/arch/powerpc/perf/kvm-hv-pmu.c
> index aa72b96b5a8c..a58634f656e9 100644
> --- a/arch/powerpc/perf/kvm-hv-pmu.c
> +++ b/arch/powerpc/perf/kvm-hv-pmu.c
> @@ -314,53 +314,48 @@ static struct kvmppc_gs_msg_ops gsb_ops_l0_stats = {
>  
>  static int kvmppc_init_hostwide(void)
>  {
> -	int rc = 0;
> +	struct kvmppc_gs_msg *gsm;
> +	struct kvmppc_gs_buff *gsb;
>  	unsigned long flags;
> +	int rc;
>  
> -	spin_lock_irqsave(&lock_l0_stats, flags);
> -
> -	/* already registered ? */
> -	if (gsm_l0_stats) {
> -		rc = 0;
> -		goto out;
> -	}
> -
> -	/* setup the Guest state message/buffer to talk to L0 */
> -	gsm_l0_stats = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats,
> -				      GSM_SEND, GFP_KERNEL);
> -	if (!gsm_l0_stats) {
> -		rc = -ENOMEM;
> -		goto out;
> -	}
> +	/* allocate the Guest state message/buffer to talk to L0 */
> +	gsm = kvmppc_gsm_new(&gsb_ops_l0_stats, &l0_stats, GSM_SEND,
> +			     GFP_KERNEL);
> +	if (!gsm)
> +		return -ENOMEM;
>  
>  	/* Populate the Idents */
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> -	kvmppc_gsm_include(gsm_l0_stats, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_HEAP_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_SIZE_MAX);
> +	kvmppc_gsm_include(gsm, KVMPPC_GSID_L0_GUEST_PGTABLE_RECLAIM);
>  
>  	/* allocate GSB. Guest/Vcpu Id is ignored */
> -	gsb_l0_stats = kvmppc_gsb_new(kvmppc_gsm_size(gsm_l0_stats), 0, 0,
> -				      GFP_KERNEL);
> -	if (!gsb_l0_stats) {
> +	gsb = kvmppc_gsb_new(kvmppc_gsm_size(gsm), 0, 0, GFP_KERNEL);
> +	if (!gsb) {
>  		rc = -ENOMEM;
> -		goto out;
> +		goto free_gsm;
>  	}
>  
>  	/* ask the ops to fill in the info */
> -	rc = kvmppc_gsm_fill_info(gsm_l0_stats, gsb_l0_stats);
> +	rc = kvmppc_gsm_fill_info(gsm, gsb);
> +	if (rc)
> +		goto free_gsb;
>  
> -out:
> -	if (rc) {
> -		if (gsm_l0_stats)
> -			kvmppc_gsm_free(gsm_l0_stats);
> -		if (gsb_l0_stats)
> -			kvmppc_gsb_free(gsb_l0_stats);
> -		gsm_l0_stats = NULL;
> -		gsb_l0_stats = NULL;
> -	}
> +	/* setup the Guest state message/buffer to talk to L0 */
> +	spin_lock_irqsave(&lock_l0_stats, flags);
> +	gsm_l0_stats = gsm;
> +	gsb_l0_stats = gsb;
>  	spin_unlock_irqrestore(&lock_l0_stats, flags);
> +
> +	return 0;
> +
> +free_gsb:
> +	kvmppc_gsb_free(gsb);
> +free_gsm:
> +	kvmppc_gsm_free(gsm);
>  	return rc;
>  }
>  
> -- 
> 2.39.5
> 
> 


LGTM, no errors are seen in dmesg with this fix applied and
CONFIG_DEBUG_ATOMIC_SLEEP=y

Tested-by: Gautam Menghani <gautam@linux.ibm.com>

