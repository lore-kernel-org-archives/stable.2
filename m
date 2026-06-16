Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B07D43C07E;
	Tue, 16 Jun 2026 10:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781607279; cv=none; b=LEbDCeiEZga/ez2d9pLo8MxMW0R3KtRTe2ozg1Zcs4Dxaru65dnTaaHf7sTgxLthkDgCNaNg4Jg0YWv6/qWzxW1l7ewTcvar8jKNc6tWYBRPSEzju2MBBoVpflH+MXUVhdJK17RLH2H+io6R3gMsP0p8vaWIZvHP3CwwkE1niGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781607279; c=relaxed/simple;
	bh=0UDw0QWlpKGl28Xty4RZJ3yVwsTk8ajCpBttmS4tKRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KWCGhTUBrY5lv5izhb5s2cqhwA/Fqh1SQIVb00EkKF5p9ZIvdUmegirDIbSErC4CQ8zZOkyERtaxvcJQJTdO6Z901itvkXxblqp3sK9Ei+30PMlqXr71I2UYTWNmqLRQ4CCJCa6HfAGxLKCqj+ddfdtkIFVc3m1bLTIJmgmsc50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k9dCgquv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k9dCgquv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIZQB1117823;
	Tue, 16 Jun 2026 10:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SXY3eX53pBQE1JdaXJtaqzCYpHXmDx
	pz/2ijBQDqnRk=; b=k9dCgquvhL1MLuWYYStp/E4mgs6NL08Lf/Dyz0YZRu/SCs
	aS1EcZ+4V8tUIGz+9/H6yyB9t07NeFq4BR/RlMZR4IA5/6jz/sgAMXmw/eKnChHD
	q042O3+CSHVvE/inJVCpl7GhGFItv+GcZ2g4bBfGM5dY+uz2wzIQ3YMXtau+YbDb
	c9WU7qb0oxr6As0MavN3qwCyLQ7Znjrq40dFeELdCZAY+jDqbIipnKcHJFvohTEA
	+eZnnggfWpgcX/7kbLbjE0bUR9pC+5pbAK/cJaAnAlYHEVHu52VWQyPwYnCZpBCz
	r5O50gNnEWOx5Of6VjgH2auV52DiWC7CSzkVZgXg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v2cndt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 10:54:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GAnZZi009209;
	Tue, 16 Jun 2026 10:54:19 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7y2py7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 10:54:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GAsG4U49479980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 10:54:16 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1520720043;
	Tue, 16 Jun 2026 10:54:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A4E820040;
	Tue, 16 Jun 2026 10:54:13 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 16 Jun 2026 10:54:13 +0000 (GMT)
Date: Tue, 16 Jun 2026 16:24:13 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        Anushree Mathur <anushree.mathur@linux.ibm.com>,
        Gautam Menghani <gautam@linux.ibm.com>,
        Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against
 host compatibility mode
Message-ID: <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Mail-Followup-To: Ritesh Harjani <ritesh.list@gmail.com>, 
	linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
	Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20260609053327.61563-1-amachhiw@linux.ibm.com>
 <cxxqerzk.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cxxqerzk.ritesh.list@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX2nmqGZPiivoR
 nrg77UUVdMA4u90GKK2XplyPcuDsmjQqgw1Ilrh/zNiRPBe/WdW14uM8JrYfw4cIJ+3Bvq3ApmG
 IOpQquaDvB61o4RS5ETmvUIRbYyUAZw=
X-Proofpoint-GUID: ro_QMaLZbot1FSc3dZW9hY2L39WJYVhV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEwOSBTYWx0ZWRfX4QjP9HFNYuEG
 zHU8qtx7MoGq1yR4xdDUld2qZYvTkK1b9KWXJmdA4lWEcX30vcK3YdcxKUMecoY0zu5iovYAOtm
 2dWgNvpqh2A4L3IXRUMW6U65P1UOGvXhvJmFQutYmiwo21DCOna+3XJ5dezRyIdseZCD8UZeGO+
 6x+oLV7n3QvUNv7lWufyLd/IxcdXnxgjkc3Y0HUp4l+1H4Hac5h/B6uH+vNO8aLd22Ih82mzTAV
 oJQD0smiekq+BvgAyFE/YKMKTXpsGFjEofhKxp24qEeFtFAIjRTQtf6VFu21OLp9KyFTpf1+g0H
 9brQWUZYXKizh6XNrwo2Ya8J1dvlnG9KXEi+7WxHCS8YAYcz4YU5b44uWWkqcrer8T0i1TJ/WLG
 YLACUyI2fwSWEGcEboG1VumdT0OnyaGsrhRQW5yM0SxKVWUMyH7DJjLoXmsFtJjx19yS0KJBXfE
 M7IaO+FnGpa5TxRFhAQ==
X-Proofpoint-ORIG-GUID: IfzZDuJIZG7lFDp-uwINxi7KyIcJEl3e
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a312b5d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=WpanCPjGmTOz0TF1uqAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160109

Hi Ritesh,

Thank you for the review and feedback. Please find my response below.

On 2026/06/16 03:17 PM, Ritesh Harjani wrote:
> Amit Machhiwal <amachhiw@linux.ibm.com> writes:
> 
> > On IBM POWER systems, newer processor generations can operate in
> > compatibility modes corresponding to earlier generations. This becomes
> > relevant for nested virtualization, where nested KVM guests may need to
> > run with a specific processor compatibility level.
> >
> > Currently, when running a nested KVM guest (L2) inside a Power11 pSeries
> > logical partition (L1) booted in Power10 compatibility mode, the guest
> > fails to boot while setting 'arch_compat'. This happens because the CPU
> > class is derived from the hardware PVR (via mfspr()), which reflects the
> > physical processor generation (Power11), rather than the effective
> > compatibility mode (Power10).
> >
> > As a result, userspace may request a Power11 arch_compat for the L2
> > guest. However, the L1 partition, running in Power10 compatibility, has
> > only negotiated support up to Power10 with the Power Hypervisor (L0).
> > When H_GUEST_SET_STATE is invoked with a Power11 Logical PVR, the
> > hypervisor rejects the request, leading to a late guest boot failure:
> >
> >   KVM-NESTEDv2: couldn't set guest wide elements
> >   [..KVM reg dump..]
> >
> > This situation should be detected earlier and rejected by KVM. Without
> > proper validation, if userspace ignores the error, the guest may continue
> > to boot in Power11 raw mode on a Power10 compatibility host, which should
> > not be allowed.
> >
> > Introduce a validation mechanism that detects unsupported arch_compat
> > values early in the guest initialization path. When an unsupported
> > arch_compat is requested (e.g., Power11 on a Power10 compatibility mode
> > host), kvmppc_set_arch_compat() uses cpu_has_feature(CPU_FTR_P11_PVR) to
> > detect the mismatch and sets arch_compat to PVR_ARCH_INVALID. This
> > triggers kvmppc_sanity_check() to mark the vCPU as invalid by setting
> > vcpu->arch.sane to false. On the next vCPU run, kvmppc_vcpu_run_hv()
> > checks this flag and returns -EINVAL, preventing the guest from running
> > with an invalid processor compatibility configuration.
> >
> > With this, when a Power11 arch_compat is requested on a Power10
> > compatibility mode host, the guest fails early during boot with:
> >
> >   error: kvm run failed Invalid argument
> >
> > This provides a much clearer failure mode compared to the previous
> > behavior where the guest could boot in Power11 raw mode (if userspace
> > ignored the error) or fail late during H_GUEST_SET_STATE.
> >
> > Suggested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Reviewed-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v6.13+
> > Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
> > ---
> > Changes in v3:
> > * Fixed null pointer dereference in kvmppc_sanity_check(): added check for
> >   vcpu->arch.vcore before accessing arch_compat, as vcore is NULL for Book3S
> >   PR and BookE guests (only Book3S HV uses vcore) [Reported by Sashiko AI]
> > * Added Reviewed-by tag from Vaibhav
> >
> > Changes in v2:
> > * Fixed issue where v1 allowed guest to boot in Power11 raw mode when
> >   userspace ignored the error, by adding validation in kvmppc_sanity_check()
> >   to ensure early failure during vCPU run [Found the issue after posting v1,
> >   also reported by Gautam.]
> 
> Would be nice if we could post the matrix test results which Gautam
> posted earlier with this v3. I guess you meant you already tested all of
> those - it would be nice if we could explicitely put that info in the changelog.

Regarding the test matrix: Both Anushree and I have tested all the
scenarios comprehensively. Anushree has shared her detailed test results
in her reply to the patch [1], covering:

  - P11 guest on P11 host -> Works
  - P10 guest on P11 host -> Works
  - P11 guest on compat-P10 host -> Correctly fails with "Invalid argument"
  - P10 guest on compat-P10 host -> Works

I have also verified all these scenarios with the same results.

If you'd prefer that I add the test matrix explicitly to the changelog
and send a new version, please let me know and I'll be happy to do so.

[1] https://lore.kernel.org/all/4e833bec-67ae-4b78-9a50-e1b9dec4029a@linux.ibm.com/

> 
> > * Introduced PVR_ARCH_INVALID constant for marking invalid arch_compat
> > * Dropped all Reviewed-by and Tested-by tags due to code changes; requesting
> >   fresh reviews
> > * v1: https://lore.kernel.org/all/20260603141539.47620-1-amachhiw@linux.ibm.com/
> >
> > Changes in v1:
> > * Moved this patch out of the v3 series [1] as discussed here [2]
> > * Addressed below review comments from Ritesh:
> >   - Based the PVR validation on cpu features
> >   - Fixed hcall name typo
> >   - Stable backport
> >
> > [1] https://lore.kernel.org/all/20260522152744.55251-1-amachhiw@linux.ibm.com/
> > [2] https://lore.kernel.org/all/20260522152744.55251-2-amachhiw@linux.ibm.com/
> > ---
> >  arch/powerpc/include/asm/reg.h |  1 +
> >  arch/powerpc/kvm/book3s_hv.c   | 15 ++++++++++++++-
> >  arch/powerpc/kvm/powerpc.c     |  4 ++++
> >  3 files changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> > index 3449dd2b577d..7472b9522f71 100644
> > --- a/arch/powerpc/include/asm/reg.h
> > +++ b/arch/powerpc/include/asm/reg.h
> > @@ -1356,6 +1356,7 @@
> >  #define PVR_ARCH_300	0x0f000005
> >  #define PVR_ARCH_31	0x0f000006
> >  #define PVR_ARCH_31_P11	0x0f000007
> > +#define PVR_ARCH_INVALID	0xffffffff
> 
> Logical processor version is defined as part of the PAPR spec. We should
> ensure that this invalid PVR is also documented in the PAPR spec.
> 
> If you have already taken care of that, then please confirm and feel free to add:

Regarding the PAPR specification documentation: The PAPR spec documents
the valid Processor Version Register (PVR) values for each processor
generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
KVM implementation detail used internally to mark invalid compatibility
mode requests - it's not an architectural value that would be defined in
PAPR itself.

The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
are documented in the kernel code and commit message.

Please let me know if this addresses your concern, or if you'd like me
to add specific documentation.

> 
> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

Thanks you again for taking the time out of the review.

~Amit

> 
