Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBF91E4AF;
	Thu,  9 Jul 2026 07:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783582821; cv=none; b=NvfS6GRmYb3YwB6R000nWi7C93RglRl/jidkgiX9wj9VYmnn5Ql4Sz7Icbvo+VQb4LvYeVMFMOc7WzmsyXSWHPWqx3J8h7zYyuwLV/4OASzwrF16m/KWSAMz/+MHaQMggmVWGGpagkgABx21WgtoZQjzsARv4/ZbF336wdZv9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783582821; c=relaxed/simple;
	bh=HM/gYrLEvZR09F5qsvVfKg5T9K5VZ6UmwBphz7bqJac=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dI+1R8bCVsfZWsy3Qv/YjIgZUXSUPaFhSSqWc5mVi1IX4CB338z35Qr4CZSrnG4lM3QJW8KKmu9O30qeXcrxy3F81gOz38u4fz706+y8grVLWF1ZFIewUFP/rKNew3fe074iD4lr4x4iNePXX9TDHIKfQMgF1PU6+gCGZyEukEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V+WFQLCO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V+WFQLCO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696IN31754028;
	Thu, 9 Jul 2026 07:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SKVKVa0lRnKWGdo4kIHa4TdLC2a7l9
	Ow3eiebFE2rTU=; b=V+WFQLCONHlM1SuT/c0N5l76Nf3JxFVcIkDkuSWXkFCazo
	8Nnhgs/4mLtFcNkEa0VV669zYJBWzWc7ArZboRaSx1ydPCDFRy6FcW8AL2tLxBxe
	X82rSTLb1M30/i0BSU6QrF3OIkyaH5oifczKesmnA6liiqPBXNQFo1eicjoFmliO
	+V8Du25n20/3y9sZj+CxJwh1LY9JX+W3Z0U7WPpPwmWS22E3Cj5rLWFodoSj7gKD
	0LexEdMYRy87BbCMW2EcNxK5QyugRjAZ46LFGtRZ+R1xO+D0RjUGhCF7G05ANika
	XFpbtPeOZ8NBedSefvlcaqzC/Uu+TlXauoFxeErA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rke0ye9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:39:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6697YdDS004527;
	Thu, 9 Jul 2026 07:39:50 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hm0s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 07:39:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6697dnAN28705294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 07:39:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8430658061;
	Thu,  9 Jul 2026 07:39:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F19E5803F;
	Thu,  9 Jul 2026 07:39:44 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.43.124.196])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Jul 2026 07:39:43 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Thu, 09 Jul 2026 13:09:42 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: leixiang <leixiang@kylinos.cn>
Cc: seanjc@google.com, pbonzini@redhat.com, stable@vger.kernel.org,
        leixiang
 <leixiang@kylinos.cn>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Nicholas
 Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Suresh Warrier
 <warrier@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Set irqfd->producer only on success
In-Reply-To: <20260709055755.31297-1-leixiang@kylinos.cn>
References: <ak59frQUBl9Gs3Qn@google.com>
 <20260709055755.31297-1-leixiang@kylinos.cn>
Date: Thu, 09 Jul 2026 13:09:42 +0530
Message-ID: <87se5stxvl.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4f5047 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=OpZPvQM_6S_00z3mgO4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX2S+vkU4q0Hf/
 aCFFljFfrrXJmGt0HedXJVKHOkT8yQ7NKjqrB/iOu/tO6iC/ULguI7EPXitP0R+6+bSQO0TL9Yw
 kV+En1mz4Z7MxSAOiyaeL5bVmc56gd9Shkmv16MwBJA4QIR5Fj2zeoe5YR+DkF71/LvXV3xYYIR
 hLHhWesBka+oMsTo//uT0rDH9iFl1dwzS4EjiJF537myYmKSYOpr0b0fRZGEMZgqB8r2p/YzRll
 XCJMcU1dnbzexeovYmdPEvPTMn2mgxB+Xd9WyQbG+sZE3CxWDgB05DipSNA9L0onzq8mtWSxQWi
 TFqm3WB3UyD56+u6x/JOeakN9Z5A3EGHgNpjLjmqSmW6HNOlNeXG1THMDKFiobuCAiRoTrJEnYA
 GuI/JcNhAyZ2hP62255iUxpGV/ZOFb5fgIaktv5h7Zlb/JVKWx7Dsor3cGQYlDjOAl/FLIy8qYe
 +oiZx5CHJ4GtsGcoXQg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA2OCBTYWx0ZWRfX8ocAnjptmL7i
 Ob7uKmtiOSnGch16ORflXtCaxBaXI79cbCn4/x+H1+SuiI2Go8Vt85877fztFRyYuQF7bFGZRAj
 RwVZ4ugnHFPvRqpYInCVEyE/yaFUW4M=
X-Proofpoint-GUID: 2mGopxkw-TgwJnY9_JQU-7s-auhOmslQ
X-Proofpoint-ORIG-GUID: IF47d6jbO94cYnx2KYd2-EkhmqVRbTrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1011 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090068

Hi leixiang,

Thanks for catching and fixing this for kvm-hv:

leixiang <leixiang@kylinos.cn> writes:

> Set irqfd->producer only after kvmppc_set_passthru_irq() succeeds to
> avoid leaving a dangling pointer on failure. The bypass manager does
> not register a failed producer, so the pointer is never cleared.
>
> Fixes: c57875f5f9be ("KVM: PPC: Book3S HV: Enable IRQ bypass")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: leixiang <leixiang@kylinos.cn>
> ---
>  arch/powerpc/kvm/book3s_hv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 61dbeea317f3..ff7b25629125 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -6111,12 +6111,12 @@ static int kvmppc_irq_bypass_add_producer_hv(struct irq_bypass_consumer *cons,
>  	struct kvm_kernel_irqfd *irqfd =
>  		container_of(cons, struct kvm_kernel_irqfd, consumer);
>  
> -	irqfd->producer = prod;
> -
>  	ret = kvmppc_set_passthru_irq(irqfd->kvm, prod->irq, irqfd->gsi);
>  	if (ret)
>  		pr_info("kvmppc_set_passthru_irq (irq %d, gsi %d) fails: %d\n",
>  			prod->irq, irqfd->gsi, ret);
> +	else
> +		irqfd->producer = prod;
>  
>  	return ret;
>  }
> -- 
> 2.45.0
>

Proposed new error handling path looks better compared to v1 of the
patch. Also agree to the changes made.


Hence,

Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Cheers
~ Vaibhav
