Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5043E2773;
	Fri,  5 Jun 2026 07:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780644639; cv=none; b=V3pfKmS4ApMwBwqasxthnEF339ZysylmnKdENK04sEByIx3yQ12o0618GxW0LYwvOQazkwFQj2Zbh34hs8U3xmB2zfTjbfzT2/NsRI3r0n/zv7o47YGezvzU5aulhNiIMK7pyZEzbQzhhtfo+GCbKqkwTSv4gEAxkuv8YZemqe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780644639; c=relaxed/simple;
	bh=8O5/F8XDc6RWtLPFw9Wg3YZ2kUzClxPUbM2MUK49V44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lFgMjCBYsNueIB3QPG9N6On2tNPLUTHxJaT/P0S4f7JW/byd6qYbkE7HiXbB90OAj2uDPQBAF7QX8ELMpng7wVI+JvDe85L4OpQ5LCoeiw0vjB5M4s5tgpnrixQIRurQ03FU32vUIIOXtDe9ipzLRblbQvfldJXr6bIKy7tNyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CglZPtkB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CglZPtkB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6556WvgU313051;
	Fri, 5 Jun 2026 07:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=A65gBcJW6Nm4ssfR1XDaWfKu26LLfo
	8gr0TVzhqhaDA=; b=CglZPtkBWjXCx5y30n2f1XjMJ7KU7Ih7W5JbSTVNtYEaqj
	p0+79C7CmwioXTGAlFKMW4UF36SVaPidtJ9UEHcLprHAXcXcdZFxNF88ndVx2hjM
	0RUp70NM/yR8vr9n60JnuNdUsWHZ+pqYc/1c4nGn/uQGY6jOWPFlTAocQzCdioUX
	foPfcjAR6Z6VjEM35V0EJ6QUM6b/Y2BDPhWxQNMVFgjAflFNmUxKv0Spk3lenm2s
	wPMUT0calnBi1yRpaOpJO/VUSR7aB1vEH9lXl4wYOA4K5A85dePpyxnzBJgJgo88
	+hR58l9CF7ZCI6RmMhZp35iD9z9tFkPimXJCoKag==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnaj2w2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:30:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6557OGUX003308;
	Fri, 5 Jun 2026 07:30:25 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhrj81-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Jun 2026 07:30:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6557UNKu31523436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jun 2026 07:30:23 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C866758059;
	Fri,  5 Jun 2026 07:30:23 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DF6C58043;
	Fri,  5 Jun 2026 07:30:17 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.124.210.197])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with SMTP;
	Fri,  5 Jun 2026 07:30:16 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Fri, 05 Jun 2026 13:00:15 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora
 <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe
 Leroy (CS GROUP)" <chleroy@kernel.org>,
        kvm@vger.kernel.org, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Validate arch_compat against host
 compatibility mode
In-Reply-To: <20260603141539.47620-1-amachhiw@linux.ibm.com>
References: <20260603141539.47620-1-amachhiw@linux.ibm.com>
Date: Fri, 05 Jun 2026 13:00:15 +0530
Message-ID: <87ik7xmol4.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA2NyBTYWx0ZWRfXz7XBwMqr1cV1
 /MqsSuAPmzH05wLYU/NYtVmwBHSITaWM0yQWDBgxCm6AjSFf7R/jA/++wMV53J5saBm96/UkGLg
 5DQiPdHhNJ9uIW8+4ogfsbhLxHG9KnUatxWXtQaufAkgAEEmr7bhxDbBCd7sYGSqmBWEftk9yYl
 RsjkuZHU6FGh3kTW9OJ7Hc64Nbof2Gw1SAhvL7iVurq4oXZJO9iun8H214xT3N+YWyFncSMvu5W
 45AJWTvbtJrQfklpbdsTiyw30Rz73/Yj+HU7XYORr8Vt+mLlxyXbjddYNPSSN4PJqAcmsv75Iz/
 Zag/2v9feVZIIMEOYLE+DNcYdSQbWUtckBoomjmvJWl+qNUcGtvo3ZkbQ0wZy7AME85ZIU+A5I1
 yZiyb2UQCJsrB1znZ2/IK+vr4+WsJSGbGbXnDQHM/UsHbNwA9Cox7DR8WC2JxHc0wMAOLHvcgkw
 1uPP+zZk1GGHeLxxWbQ==
X-Proofpoint-ORIG-GUID: olIAlBizh-uFgtCkP73-EaqN6gZLJUPZ
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a227b12 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=zpmr9W5NDK2xhLxDAGUA:9
X-Proofpoint-GUID: 01Jt-T6Ta0oEV_qFyKp2zexJ-ViDJMWb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606050067


Amit Machhiwal <amachhiw@linux.ibm.com> writes:

> On IBM POWER systems, newer processor generations can operate in
> compatibility modes corresponding to earlier generations. This becomes
> relevant for nested virtualization, where nested KVM guests may need to
> run with a specific processor compatibility level.
>
> Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> logical partition (L1) booted in Power10 compatibility mode, the guest
> fails to boot while setting 'arch_compat'. This happens because the CPU
> class is derived from the hardware PVR (via mfspr()), which reflects the
> physical processor generation (Power11), rather than the effective
> compatibility mode (Power10).
>
> As a result, userspace may request a Power11 arch_compat for the L2
> guest. However, the L1 partition, running in Power10 compatibility, has
> only negotiated support up to Power10 with the Power Hypervisor (L0).
> When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> hypervisor rejects the request, leading to a late guest boot failure:
>
>   KVM-NESTEDv2: couldn't set guest wide elements
>   [..KVM reg dump..]
>
> This situation should be detected earlier. Rejecting unsupported
> 'arch_compat' values in 'kvmppc_set_arch_compat()' avoids issuing an
> invalid H_GUEST_SET_STATE hcall and provides a clearer failure mode.
>
> Add a check to reject Power11 'arch_compat' requests when the host is
> running in Power10 compatibility mode, returning -EINVAL early instead
> of deferring the failure to the hypervisor.
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Tested-by: Anushree Mathur <anushree.mathur@linux.ibm.com>
> Cc: <stable@vger.kernel.org> # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks, this LGTM
Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>

-- 
Cheers
~ Vaibhav
