Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FB24611C9;
	Mon, 12 Oct 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793843; cv=none; b=coRSOsTLsW68vxKltbTkIe9769UPBdsMvgOBIbDjhSmu9X1VDMj3vlKeT7zZUsvYSfU8HqVw5wa+6IFkHx220AH3nIx4jePd4vkOFR//6BFOIbwh5iw252QunhjoEJ6m/qxQp6Uwt0JwqnMtbLE1uyCvoF45bHOoUJHBzysDi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793843; c=relaxed/simple;
	bh=EfjAVM+rSmwSw5mc5TdAO1S/IIhIk3XN1erOWcrE4bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY71J4A2/Wrj3P6o9KK2tF/+JZRtohVbX0xnsPAC2VY5a0guqkJf76vY8d1iSmwdDxsN3TaiVOmaa85pINxsT3Mrknf/MphMdqC+UXbX4NWzFwxLty0XuykLJOtXd7vdvLJZMygcFdypbeKK9RxpbM0rziGEhBZ4ip3XSowa/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AbpcBpzj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AbpcBpzj"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5F4pQ3481917;
	Mon, 12 Oct 2026 08:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fS52B2ik2RpcmITc0
	+spHR5DXtyRsWYJdPBu20lYcXE=; b=AbpcBpzjFzvlkgnEXqO3ZNwGq9U2BrVzM
	t0aTxIjBHL2V4FCcRFV1s0ART6jGyTHmkOCDaLhgCXEeF1VXCZP3pDNoc2cX7xQE
	138HpWSC7PhUI9nXySfNfg+LWZBl6zBLvo4QgXHt/B8S+KXZ8pRDkBAzbemTQvTS
	XNL3yR4/qbYnjl0UtRJI1dj6+xwMEwxtvdKJ5c0YM9QVFDJqjdtkMOF0eC0gINtP
	liVZQrYGajsjF4zxmsYLNAQoN9r2oXNqFioBCFhBfRpRs5SsrQu0LPeX9f3lBsKy
	4q4QvNuSSU6x3URjJeM16C7wDx1WeUlwXB3adVTfuxvMOI9GLRumg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1vykfn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K2pX1013550;
	Mon, 12 Oct 2026 08:29:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyc30k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8TqqD47120774
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A8732004B;
	Mon, 12 Oct 2026 08:29:52 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E58F220043;
	Mon, 12 Oct 2026 08:29:49 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:49 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 4/4] KVM: PPC: Book3S HV: Take SRCU read lock around kvmppc_h_page_init() call
Date: Mon, 12 Oct 2026 13:59:20 +0530
Message-ID: <20261012082922.218799-5-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX5gxxItVbleqO
 lZCmtHY0463SDQ3qVxV6aldl5Sdirs6sxY/3OJRIwU2behwNKE09fxBE6m7YGNkiM7mQf7Isa1U
 dp7ROAgczzQbnbRZmOa4ns3J/kz4kWg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX9se1/7+FhEJU
 VLCP/DTYc9d0Bl55w46DGC+2pXcL4ms0ZgKvPqqCDA210KYs3o5fEOPB8AtFNI10djaJLMxGvp9
 uClba3y0KMufTeDOXFLip0ICRwJ9RdyQwM7Og0TdAf/eagJjV7bE5ZoDV1ezwcN4eDwMTMymP7w
 GYg9aQ7cq0fiXJaQBL/p4wMtcWvgO/F7uyDBLUDJneXLgos5YVn3gjPkPHcdI3n6AfACgwHo8Hy
 ndnY60JdFiAJZ9rW7z2n+vFFCPDjbRL62m00NiSZN0LW8W49jtVl14Ijh1sDURVYLFgR8cuDMRX
 pyTMmZ8sPsiafkuGS0cjOVVZOanQBK0AZyjWkWgSltZSOwmRskyAqjeI9gtSrSUded5pIyh052v
 rT85B1E336O6W3/VHM98JSxltbx3AnfdGbQBrxMR+6ZuY51i0EmHvH5Fc+B7FauB/6L45ViSQt5
 +AuJ1RqEGKQjnf9vQkA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6acc9a85 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8qrm3ZJ1U5mLyAqmLJwA:9
X-Proofpoint-ORIG-GUID: WmVtHqfYA1TyRnHbNzvvQkL8uj0Kqbwf
X-Proofpoint-GUID: 0dYAFVYwNcwxV_QQkMSbWHgSaFWr0xmE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120032

Since there is no srcu read lock around kvmppc_h_page_init(), a
"suspicious rcu_dereference_check() usage" can be triggered by running
host linux with CONFIG_PROVE_RCU=y and the following code in the guest:

plpar_hcall_norets(H_PAGE_INIT, H_ZERO_PAGE, phys_addr, 0);

 =============================
 WARNING: suspicious RCU usage
 7.0.0-dirty #227 Not tainted
 -----------------------------
./include/linux/kvm_host.h:1074 suspicious rcu_dereference_check() usage!

other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1
1 lock held by qemu-system-ppc/2093:
 #0: c000000354197ab0 (&vcpu->mutex){+.+.}-{3:3}, at: kvm_vcpu_ioctl+0x10c/0xaf0

stack backtrace:
CPU: 30 UID: 0 PID: 2093 Comm: qemu-system-ppc Not tainted 7.0.0-dirty #227 PREEMPT(full)
Hardware name: IBM,9080-HEX POWER10 (architected) 0x800200 0xf000006 of:IBM,FW1060.60 (NH1060_158) hv:phyp pSeries
Call Trace:
[c00000033e1bf430] [c000000001b3dbd4] dump_stack_lvl+0xc8/0x130 (unreliable)
[c00000033e1bf470] [c0000000003da964] lockdep_rcu_suspicious+0x1f4/0x290
[c00000033e1bf520] [c000000000231424] gfn_to_memslot+0x1b4/0x1c0
[c00000033e1bf560] [c00000000023637c] kvm_clear_guest+0x9c/0x110
[c00000033e1bf5c0] [c0000000002714a4] kvmppc_h_page_init+0x160/0x1a0
[c00000033e1bf610] [c00000000026c040] kvmppc_pseries_do_hcall+0x1930/0x1940
[c00000033e1bf6d0] [c00000000026fb18] kvmppc_vcpu_run_hv+0x268/0x800
[c00000033e1bf7a0] [c000000000246b30] kvmppc_vcpu_run+0x30/0x50
[c00000033e1bf7c0] [c000000000241ed4] kvm_arch_vcpu_ioctl_run+0x364/0x530
[c00000033e1bf860] [c00000000022b870] kvm_vcpu_ioctl+0x1b0/0xaf0
[c00000033e1bfa50] [c0000000009b4514] sys_ioctl+0x144/0x190
[c00000033e1bfab0] [c000000000034330] system_call_exception+0x170/0x370
[c00000033e1bfe50] [c00000000000d05c] system_call_vectored_common+0x15c/0x2ec

Fix this by taking a srcu read lock around kvmppc_h_page_init().

Fixes: 2d34d1c3bbfd ("KVM: PPC: Book3S HV: Implement virtual mode H_PAGE_INIT handler")
Cc: stable@vger.kernel.org # 5.2+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
1. Use srcu_read_{lock/unlock} instead of the vcpu_srcu* variants
(Ritesh)

v2:
None

 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de05d721edc4..3ed033d4f80f 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1386,9 +1386,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmhv_copy_tofrom_guest_nested(vcpu);
 		break;
 	case H_PAGE_INIT:
+		idx = srcu_read_lock(&kvm->srcu);
 		ret = kvmppc_h_page_init(vcpu, kvmppc_get_gpr(vcpu, 4),
 					 kvmppc_get_gpr(vcpu, 5),
 					 kvmppc_get_gpr(vcpu, 6));
+		srcu_read_unlock(&kvm->srcu, idx);
 		break;
 	case H_SVM_PAGE_IN:
 		ret = H_UNSUPPORTED;
-- 
2.54.0

