Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.165.32
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614384;
	b=upZ4XwJLVfIy+IwBjQywxXndI5eXkafVYgS2gjuHmc4lLp8etjRM719Rc5aacFpQlixb
	 GaZT3boPZiv8H4HOqPmQb1r27g4QX7aPpvU4ZoPoMykGksnzz5gejXknpJnAJ5DiSz9ur
	 VOkjsvI/QvqcpqcieVuadhBQbmotJBamZO9mMk3OlqhbRTpwgeO2x1nj1K/b2rrrOemdf
	 Ky6ethVernK556qCdhMPJcs6hRaWsfT+SWs7WnKcQ05m7ck4kw1G3b0knCjzp/kLa8l8L
	 86VBK52yF9o8+1HBCeII9aCcbGs1EmnleWuFyh3Tfp70uj0H2UgLou1XmCAVwMtQNOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Reinject:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info;
	bh=Vj5RINAOfFDUFpi+mOm+JFRWkzPw3FqrFyL9QQk+W6k=;
	b=OE0764V43HL7w8iiKFgCerPqZsZb0xDLgE0AEuyl38/ST+tZVsmywN1ytOiZXFG97NBv
	 74dtmaktWyAvC78DWq8yxTQ95XWpGEoO8Dfa1jdve35paBS7R6zf051cPe1Q0Rbyr5xdb
	 +33QZTZfHXuy9faNopLDFl31ISj9yuG2mjjbEsxJNPojS4D1I0YkOki/RnDtBpKk/5NX2
	 9MLXbwmPCtm/1hQ2EwUXMxfW44TLlKMavpE9XBD8+bq/ZiXhMWlKClVjkQla5u/wmoGyE
	 0tTqYrGvNXd12m1mK+1BHLbiCK3k2tmnRPDHzVkIkznqe/WlRazljf9f3vG2svEVqVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oracle.com;
	spf=pass smtp.mailfrom=oracle.com;
	dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Ot83zTsL;
	arc=none smtp.remote-ip=205.220.165.32
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACE3606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7ACE3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2025-04-25 header.b=Ot83zTsL
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A20Bq6D1209164;
	Mon, 2 Nov 2026 10:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=Vj5RI
	NAOfFDUFpi+mOm+JFRWkzPw3FqrFyL9QQk+W6k=; b=Ot83zTsLmIpZDcpiLmpSF
	b3FB79UWf6hjmXUdVmh76NxqJx1uuPdKQPFfnCizwk1/UwJFgGTlF0wz/NjT5Jpc
	2e5ixZ5TgJ0da6ZjFOpPVlj6nvrxS59rK/eLr881y3kvKnBiijg9x1Me8nPsQ9K8
	yIK3k/jKaBJxlNe/bP/UEoDbJltIwvvXsbCQ13APySU+H4QuHDBOtSQlKt+3JZ1e
	WAsBkMvnNmMOLQwsAvU6F2lG4b9/xs3QHB2afsU+NzzpcD7zu4487wtu8i7JPWNq
	6zaK2MBYPoqWU2E5+YB+CyOb6GNOoENwEtrPUwxPD1KehW2ixnhKhwe+CPG0Ei/0
	g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4hn876hk7r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Mon, 02 Nov 2026 10:12:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29D2dH2995969;
	Mon, 2 Nov 2026 10:12:57 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4hpqfja56j-4;
	Mon, 02 Nov 2026 10:12:56 +0000 (GMT)
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
To: stable@vger.kernel.org
Cc: Sean Christopherson <seanjc@google.com>,
        Minh Nguyen <minhnguyen.080505@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Siddhi Katage <siddhi.katage@oracle.com>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 5.15.y 03/11] KVM: nVMX: Put vmcs12 pages if nested VM-Enter fails due to invalid guest state
Date: Mon,  2 Nov 2026 02:12:31 -0800
Message-ID: <20261102101239.1557688-4-harshit.m.mogalapalli@oracle.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
References: <20261102101239.1557688-1-harshit.m.mogalapalli@oracle.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=872 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020040
X-Proofpoint-GUID: Ej7r1pd9akvEVFV5rIbDCb5eVSRzT5BG
X-Proofpoint-ORIG-GUID: Ej7r1pd9akvEVFV5rIbDCb5eVSRzT5BG
X-Authority-Analysis: v=2.4 cv=JJauIMKb c=1 sm=1 tr=0 ts=6ae8622a b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=1XWaLZrsAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8 a=FwJbE6n6EM51GTaFqHgA:9
 a=WmVTiCyuxqgg3mnwYu6p:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfXxEajZoevB9W9
 U3zT5G7GGc4Zu/FEmLEq0AzKnbTrqPb3BaMv9tEIKbI+2QRKAWm4UclwiEr8jD9aulY/SHO+Mzz
 hURQN+Ps+S2WH30Fl4MYNHvffqXcFEkFQ57ItdR1NGT+tZmT1+SumBu7S1VlSZJ43vu6vYzhnbB
 BHrBLlJWuMHeIGlxPmAaSFlRHygD2DwWAM4eEQmN5cZUEfn9Tf0Td9YNTpoNxhHlQiunb/kASZ6
 TwIjwFY9GvkQNzFQ+ul27CujUfxNXWvrTdJgaLrq0HvNpyRCkzL1Kef4p9fBzMWUaAZa3EfrLaf
 TY4HCdfhwyZW7NdwtcKZ6GF1MGn/UdbqprxFqcto1W38eTCgLEftN6wer5O7tzUmCptAP/Ce37b
 3o1Mi2rXAFfB76r/wLGdEvvgrGAF9fpql3sUpgoohSjewmGVN44QLjso++2GUWMWxfCfE2J7/+D
 A6+XeAoyyPHyHwBhsRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA0MCBTYWx0ZWRfX4mr4AXTB+Mit
 EuWkzWNy2w4tSWDhxAzBltzQ+fx1g9M4BUitNp5FPo566L92hC7xeO8lVxctCdn2cXPKmmlOatD
 jH7WM47H2bH0J+fYFShKaqo6/6lBEUXhw04yPZWTx3z6uKIwxTTh

From: Sean Christopherson <seanjc@google.com>

[ Upstream commit 2f2312c422fd2695da772cecb30c69994b795964 ]

Put all vmcs12 pages if KVM synthesizes a nested VM-Exit due to invalid
guest while emulating VMLAUNCH or VMRESUME.  The invalid guest state path
doesn't use nested_vmx_vmexit() as that API is intended to be used if and
only if L2 is active, and the open coded equivalent neglects to put the
vmcs12 pages.  Failure to put the vmcs12 pages leaks any pinned pages
(and/or mappings) if L1 retries VMLAUNCH/VMRESUME.

Note, the !from_vmenter scenario doesn't suffer the same problem, as
vmx_get_nested_state_pages() only gets/pins/maps the vmcs12 pages if L2 is
active, i.e. if a "full" VM-Exit is guaranteed before KVM will retry
getting vmcs12 pages.

Fixes: 96c66e87deee ("KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page")
Fixes: 3278e0492554 ("KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt descriptor table")
Fixes: fe1911aa443e ("KVM: nVMX: Use kvm_vcpu_map() to get/pin vmcs12's APIC-access page")
Reported-by: Minh Nguyen <minhnguyen.080505@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 2f2312c422fd2695da772cecb30c69994b795964)
[Siddhi: Use 5.15 vmcs12 page teardown because the upstream helper is absent]
Signed-off-by: Siddhi Katage <siddhi.katage@oracle.com>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
---
 arch/x86/kvm/vmx/nested.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index b6c302786b93..82aa349e33af 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -3543,6 +3543,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
 		return NVMX_VMENTRY_VMEXIT;
 	}
 
+	if (vmx->nested.apic_access_page) {
+		kvm_release_page_clean(vmx->nested.apic_access_page);
+		vmx->nested.apic_access_page = NULL;
+	}
+	kvm_vcpu_unmap(vcpu, &vmx->nested.virtual_apic_map, true);
+	kvm_vcpu_unmap(vcpu, &vmx->nested.pi_desc_map, true);
+	vmx->nested.pi_desc = NULL;
+
 	load_vmcs12_host_state(vcpu, vmcs12);
 	vmcs12->vm_exit_reason = exit_reason.full;
 	if (enable_shadow_vmcs || evmptr_is_valid(vmx->nested.hv_evmcs_vmptr))
-- 
2.55.0

