Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547174DD3A8;
	Fri,  9 Oct 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549093; cv=none; b=YD/9vEU5thVSdlgjqPtLPGVNe3oCSO9P0eHO9xkKtSiGu6hV/r6OVSvSKL4N6nAQ6vkX7+lY9thiaNgT2LuIkRNndRNbhNKVpw3bdZWGcvIhlLDBYNxX/nHAq4rwwjJF7CR+qqom1CRi0AjSf75Ry6MRySf0fj9zoIbXmEqA4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549093; c=relaxed/simple;
	bh=PwDdFd5UTrauZBeUJBIFLaXhys5wIXRZpCcMuFtcH+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YuYkoZeyF8ZcFaR0dvgxv4EmwnznJzTCTx/yPHcH8MPt0iv6ViS4To+3fymzuOjujzYQpIU7rz6CdwbyglIfw3NQxO0EuL7KghDreRbcyRzu8s8kBKwMLXh7PywgQh/HTUsXeXN2c0+dxtq9maGO+a/qvF1L+VV7oYlqVL8+NAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ar4QZoYs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ar4QZoYs"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6998ZpW43814405;
	Fri, 9 Oct 2026 12:31:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=a1/mGcTiaN92a/deh
	7MBXbRTvV+R4Xy9kQfBiyfbg0A=; b=Ar4QZoYsMnWmgOPgmg9Clndf9ewoIHD0l
	VcDaCk0xGVAvQB0zI3jovsPep7LPE4C2FV+/9CNyl1Q70qCxyKeto4jp3pU09O6u
	VXbfQmotUU4I5PeGAf3QD+SlIWg30A6m88Zr0XpBsQ9L04jR4kBd9FGbT5pwaLKa
	kClDFPJxdjihCxoDl0J5VrVq9Td/tMdemY938/Z6vQ7dIeL7UB8BMqxaGzRjHC+L
	zbyjEsP5t0xJWE7hRZMHPYWOb9loKQm6UQLonRhV4BKC8v5ghRKUdBWgLwVDEiFV
	i1RkM7T71w7K7xNTGxk5q/eqRfjSMlikBINJlJi6XseDx4z+vDKyg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvsv1c-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:31:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6999s7WP724098;
	Fri, 9 Oct 2026 12:31:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y8gqy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 12:31:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699CV5Gf31326544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 12:31:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0DD222004B;
	Fri,  9 Oct 2026 12:31:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 54D4F20040;
	Fri,  9 Oct 2026 12:31:02 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.27.243])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 12:31:02 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v2 4/4] KVM: PPC: Book3s HV: Take SRCU read lock around kvmppc_h_page_init() call
Date: Fri,  9 Oct 2026 18:00:33 +0530
Message-ID: <20261009123035.157770-5-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009123035.157770-1-gautam@linux.ibm.com>
References: <20261009123035.157770-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: xDEVNNTP9HqtwVRUmW-KA9M5Gm_kjEPG
X-Proofpoint-ORIG-GUID: -0kbYwW1_rhhTYnSK3O_35-6gbp0mthK
X-Authority-Analysis: v=2.4 cv=FoOQbGrq c=1 sm=1 tr=0 ts=6ac8de8d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8qrm3ZJ1U5mLyAqmLJwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfXzb4sAc1fho7e
 jFngrTOINX71oZX9j/LsI1GHQqDFqPH3Jsds/38e55fWLsP6OszHN8jQSxA4dl8x0NMGyglDVdP
 y4tQ1WzJrvQoNM8OhiMI7suozXk34t4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA0OCBTYWx0ZWRfX4xTsgG/RDy5W
 byocwY2K/QzEtqFQ3c6sypwkzREjH+ciaX3vnpRLOsj/R72xneB+tU/3jraqih2DBsr6/U9NkBk
 Eysgs6DU5oRpB74bX3Dlrt0AdU0tGCNXdfDRF68xsmBWL6Md/OG7Rby7ckp/yMxts4i7yqvx5fE
 rlFxck7HMmr+xtaLKfdqSdrOND8+5zRhIOu0T82okxyEzNXpfsjZ3zG9Z572S+TYYw52pQQoCDL
 BFx1yBddNUeLDDgoabtukZqv131hKlRdHFSfd7KQXDnht1hwSwZmJXsyt25zw/CYJ8CBiK+Li/N
 Y0/i1ZNbQSkZuUes4w2YLvjJ6xOrPVBeS4tWnWG9MyubdPKDFM0NqkBfikXzBFc+UmrBS4FUUic
 ueUezChu/tVgNoSzOBqkw/RSdAYZK07c7vq19HeL3qUTD3QTUoEFOe9gNoWbo4l5xNpMDdOKtJ4
 ilXs6JUf8VMufIX3Ing==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090048

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
 arch/powerpc/kvm/book3s_hv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index de05d721edc4..4153edd49475 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -1386,9 +1386,11 @@ int kvmppc_pseries_do_hcall(struct kvm_vcpu *vcpu)
 			ret = kvmhv_copy_tofrom_guest_nested(vcpu);
 		break;
 	case H_PAGE_INIT:
+		kvm_vcpu_srcu_read_lock(vcpu);
 		ret = kvmppc_h_page_init(vcpu, kvmppc_get_gpr(vcpu, 4),
 					 kvmppc_get_gpr(vcpu, 5),
 					 kvmppc_get_gpr(vcpu, 6));
+		kvm_vcpu_srcu_read_unlock(vcpu);
 		break;
 	case H_SVM_PAGE_IN:
 		ret = H_UNSUPPORTED;
-- 
2.55.0

