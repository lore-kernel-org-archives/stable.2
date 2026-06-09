Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0814E35E925;
	Tue,  9 Jun 2026 03:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780977009; cv=none; b=V1+v+MRJbHH9I5/gDLq+1IKNbXbmMzmrfwyHtGsWsr9cxIV7j0wJcHXjE3Hs5eC8f45d45Ls0+SoTh4nMoriScPmACVLZucteOf1nwm5tj0ca6deBItWly5uXMjMRcKAqxIPHVkE2pjWoEZuJVPp38Bqbs+petVWhG4nrLkg05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780977009; c=relaxed/simple;
	bh=v3yhIW1AHD52ketwXrPT313yzyHoo2f43Boy1ORM8I4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HmK5TckYaXtYIZ8jHkwSqOxVivCry8yMHO3FDw4PYR/kXy+HN8SEr7HVJBJ1YH6czrkIbPYaSV2R3/NGpWHLidxr4QHrUujl7lIkGRPB+JOZiVBCXRYIeYQ06K3Td3KD3x7f3DoN43Os9oD6EuA12DnO5dSmJkK2mPOl8Za0iyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pqKxfASP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pqKxfASP"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658CVbC32894314;
	Tue, 9 Jun 2026 03:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ooNIQw239ybpuWm5zqCyb0z28r9XLR
	d5kIecBPWrCv0=; b=pqKxfASPqPmRSN+ASCY73xPQ1WXBaR3vd52qGSMhPTVmAp
	Y86esXq+t6qXd27tzeFrTHJHqevJWGfx1+1ThOM5PVeaRcfta3mD9Rf5PfQzm8xG
	E8e6WavO+3JmRxseGjvNfCHA0h2WoiesDCibLdyjp7hMbv01JOV0qpsiqEoJ4uDS
	FH6XRiWRYIIfVVfcFs9UFT3iJHPNTLR+a2QZmeZ2jVjgJLRreF8Hed8Ihrbdj681
	uN2R8a1cZmCa6m6KXSSQVN1CtYF2tt2Wbch8j+9IPICtO2Y9YOejisE0kyo2KggP
	btKdjoNcx+ORXexx5VLnk7ZMx7kORt70cdSCuUOA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qj79c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 03:49:45 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6593nahL022996;
	Tue, 9 Jun 2026 03:49:44 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4emwvq0dgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 03:49:44 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6593ngMp47120832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 03:49:43 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C814C58051;
	Tue,  9 Jun 2026 03:49:42 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE025805A;
	Tue,  9 Jun 2026 03:49:35 +0000 (GMT)
Received: from vaibhav?linux.ibm.com (unknown [9.39.27.30])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with SMTP;
	Tue,  9 Jun 2026 03:49:35 +0000 (GMT)
Received: by vaibhav@linux.ibm.com (sSMTP sendmail emulation); Tue, 09 Jun 2026 09:19:33 +0530
From: Vaibhav Jain <vaibhav@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Harsh Prateek Bora
 <harshpb@linux.ibm.com>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Anushree
 Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani
 <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
In-Reply-To: <20260608201001.65760-1-amachhiw@linux.ibm.com>
References: <20260608201001.65760-1-amachhiw@linux.ibm.com>
Date: Tue, 09 Jun 2026 09:19:33 +0530
Message-ID: <8733ywmkz6.fsf@vajain21.in.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a278d5a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=ezl3feXKi1nSa3xQh9EA:9
X-Proofpoint-GUID: nLK-bo4i65HP7pTgpF5BUe4U0GOTUnhY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDAyOSBTYWx0ZWRfXyWd75HkTvpkt
 6xUfmdxc3VgkBVlIhdvp5r8ai3apPO1d1UaX0Mr4Xbi45ZF2DIa7UxOOOSlCeeynXnflwMw/FaC
 Ps74+z0YsMIsvC5OvOijpaE0aYT+OxazOJz701dAeEimxStERLtpoQaeu55wmjcRfMsx/+z3Xyi
 v5yVdFLG78rt94Jq1wcWSKbBzwUpANOfG6NTCSPFRZR4RB7flAb1NMaKhugVaATVeh3/S9wh+vl
 JTV5hs+Qfbuh6cUdxpNGHfpC34OQXWih7i87hLwYNT55xsr5VYVIn+RyKPzKJALud7ttNt/n3Gz
 r8GVlr3vPSpH5xsXd0ZqXUvFQ+3tfZpXA9b8N5/ytG/52CxvvIv60bb+qeVW0xa1cTsspUednfm
 bPLtRbvP2QjkcGMe20HNrtlEQ8zAmbAKb6mMVNlrbMUJrTzQjFFXiAJnE0tlVcII6GPzRQi32DA
 U2fTrB0AW0Fd/XISf6w==
X-Proofpoint-ORIG-GUID: YQwCV_7By69o5DBf0MO6YIWiF4mdjeHJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_06,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090029


Amit Machhiwal <amachhiw@linux.ibm.com> writes:

<snip>
> Introduce a validation mechanism that detects unsupported arch_compat
> values early in the guest initialization path. When an unsupported
> arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> checks this flag and returns -EINVAL, preventing the guest from running
> with an invalid processor compatibility configuration.
>
> With this, when a Power11 arch_compat is requested on a Power10
> compatibility mode host, the guest fails early during boot with:
>
>   error: kvm run failed Invalid argument
>
<snip>
>
> Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>

Thanks Amit for addressing the issue reported on v1. The v2 patch
changes look aligned to what we discussed offline. Hence,


Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>


-- 
Cheers
~ Vaibhav
