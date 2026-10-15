Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE14051992F;
	Thu, 15 Oct 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065761; cv=none; b=g/zSq3cMit+yhw+npcMg3zKKu7597TyNtjRbi1jUXWoswQznjd8V9eLGLffT/ga5Tu6H7OdQgvOJ7Yl61OFFi3eTIFRgSTvaRvvHQZGHD/tRTdXDJOwe7KhJ8iEs5f27o0ye1MyCXEde/Iwx4CZwI2zeH2sc4nsQxTphQ3K2Xh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065761; c=relaxed/simple;
	bh=4VYhtbbch1PucZRJi7zDbI0FaMg/6eh+VPE/GAoDWa8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cjtVKFwRUaSZ/lOudIx90aQRmmuebKDqE+CYFcbnQJEIMs/cTF7VUCC+Uz0tkCh/i6ZyJmroLFW48amMarm+0td0bIerA7TsGB5rncfphDi2rQ0LxkJjZ8HgVWOXGuaAiJvxSjnxzCRNn6bdshd6oJobhGhebVvsABIJtUp9pi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KZN+lQD3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KZN+lQD3"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9kLvU531670;
	Thu, 15 Oct 2026 12:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=locun8ff2u85xFcCJpcxGMt3fOvIahGuElM0G4kds
	jE=; b=KZN+lQD3hjUCsic6eI8ee+0xqm8NVKZMCZ16vvnqYbBeMjhJ5Rys3IXbu
	b8TnCAMxYFtgVfdt/M4HwnBY6/YpdVK01DPAyk/j4uTV1hlP6JRj4QdBbXKQmZL4
	zGR3sO4L6TbRZOFR6x0oOEtoU0PL7Jyo5qWPbcjJOLk2Hv7CWCBiqFt7QaI8QRA3
	+w0vdLGNHXqe9Bwt9P8AVNZxN9wn19M1sSINW92DsHuxnLQfOMFmdqEaZwvE0tal
	mwze+F3G7pQKfzZZOhUR1oQxPdS+7fxfXP3YVhdRzdA3kmjkaGeA/NB2yMTpT6oZ
	t25keoNVhmqCihWSq0xvPm0TRlcdw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3sq1m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:02:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69F9ntdQ1891164;
	Thu, 15 Oct 2026 12:02:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h9q2ysatk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Oct 2026 12:02:19 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69FC2F7U49742278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Oct 2026 12:02:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B4420043;
	Thu, 15 Oct 2026 12:02:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 596BE20040;
	Thu, 15 Oct 2026 12:02:12 +0000 (GMT)
Received: from Narayanas-MacBook-Pro.ibm.com (unknown [9.39.29.169])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Oct 2026 12:02:12 +0000 (GMT)
From: Narayana Murty N <nnmlinux@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <chleroy@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] KVM: PPC: Book3S: Protect TCE IOMMU table walks with RCU
Date: Thu, 15 Oct 2026 17:31:37 +0530
Message-ID: <20261015120137.28843-1-nnmlinux@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1WAN7T4O-doXYrz1-eOQ0s57d3CV7HFd
X-Proofpoint-ORIG-GUID: elbUbtBM_G0zj52YCSSwR8rqL9TJHCIZ
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ad0c0cc cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=h1-L7VZ7pQEXAjHVqXwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX7dyVA/CBAjJU
 JQFrbAlG5OW48GOeSxVLiJVT4wOkx69OKJnkTz/z/NAq27URr33dL8/R9GxL7kN49gl01/dq5WM
 Wp8NwaJTspVmtAFn0HKbpbHGCzN5RGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA0NiBTYWx0ZWRfX0KetqF6ZPEvB
 os8OU0yuAh0uLX4kDSeDU9TgqRuir1RL7mBXnr16htwDXh8jvqXWbG60jyXktKrsJ61MTIiX5JN
 Ew7LyBPfap+ZD/EVwaTNOmAOE6ynZGtyhXjXjFjCLGSWMNSwVJCOr4nW3mdjGlC1J7EbEk0mfOq
 PlKqdLgDPgn1mMcBuPOnhLDI5IMzHmfasTbDRMzWnTgYBpgWfAqVg6ecyYM5T53z72Xgaq6MUtD
 N7b68oOBf9k1BmX8KLZ+qkiAVw6b5w+u6w1+XQm98Vuj0W8bq4h/k9B+zgTYKw9+pFW8Ou4sitt
 QDb5/ITNUid6PLs/laG/Il4O9BJp4xDTkuoQakSp9tHKMz8eI9I6CYH4tvy3Iv/vOoJD0SXDZgl
 Vowadk2x4IhsUgdZDcoIJf021yZrJAEgrLGg2CtvMkY13NrD4Yu6fNlk3rgC9V8gCU8T86HkVFb
 xhaA+2CkVh9eK/aCEQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150046

Commit cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode
handlers") moved the TCE hcalls from real mode to preemptible virtual
mode.

The stt->iommu_tables list is RCU managed. Entries are added with
list_add_rcu(), removed with list_del_rcu(), and released after an RCU
grace period with call_rcu().

However, kvmppc_h_put_tce(), kvmppc_h_put_tce_indirect(), and
kvmppc_h_stuff_tce() traverse iommu_tables using
list_for_each_entry_lockless() without an RCU read-side critical
section.

A concurrent IOMMU table detach can therefore remove an entry while a
TCE hcall is traversing or using it, without the traversal preventing
the entry from being reclaimed.

Use list_for_each_entry_rcu() under rcu_read_lock() for these walks so
that an entry removed concurrently is not reclaimed until the reader
has completed.

Fixes: cad32d9d42e8 ("KVM: PPC: Book3s: Retire H_PUT_TCE/etc real mode handlers")
Cc: stable@vger.kernel.org
Signed-off-by: Narayana Murty N <nnmlinux@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_64_vio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
index c5f3f5b29d89..d8625488c3c5 100644
--- a/arch/powerpc/kvm/book3s_64_vio.c
+++ b/arch/powerpc/kvm/book3s_64_vio.c
@@ -602,7 +602,8 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 	entry = ioba >> stt->page_shift;
 
-	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
 		if (dir == DMA_NONE)
 			ret = kvmppc_tce_iommu_unmap(vcpu->kvm, stt,
 					stit->tbl, entry);
@@ -613,9 +614,11 @@ long kvmppc_h_put_tce(struct kvm_vcpu *vcpu, unsigned long liobn,
 
 		if (ret != H_SUCCESS) {
 			kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl, entry);
+			rcu_read_unlock();
 			goto unlock_exit;
 		}
 	}
+	rcu_read_unlock();
 
 	kvmppc_tce_put(stt, entry, tce);
 
@@ -697,7 +700,8 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 			goto unlock_exit;
 		}
 
-		list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
 			ret = kvmppc_tce_iommu_map(vcpu->kvm, stt,
 					stit->tbl, entry + i, ua,
 					iommu_tce_direction(tce));
@@ -705,9 +709,11 @@ long kvmppc_h_put_tce_indirect(struct kvm_vcpu *vcpu,
 			if (ret != H_SUCCESS) {
 				kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl,
 						 entry + i);
+				rcu_read_unlock();
 				goto unlock_exit;
 			}
 		}
+		rcu_read_unlock();
 
 		kvmppc_tce_put(stt, entry + i, tce);
 	}
@@ -739,7 +745,8 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 	if (tce_value & (TCE_PCI_WRITE | TCE_PCI_READ))
 		return H_PARAMETER;
 
-	list_for_each_entry_lockless(stit, &stt->iommu_tables, next) {
+	rcu_read_lock();
+	list_for_each_entry_rcu(stit, &stt->iommu_tables, next) {
 		unsigned long entry = ioba >> stt->page_shift;
 
 		for (i = 0; i < npages; ++i) {
@@ -749,13 +756,16 @@ long kvmppc_h_stuff_tce(struct kvm_vcpu *vcpu,
 			if (ret == H_SUCCESS)
 				continue;
 
-			if (ret == H_TOO_HARD)
+			if (ret == H_TOO_HARD) {
+				rcu_read_unlock();
 				return ret;
+			}
 
 			WARN_ON_ONCE(1);
 			kvmppc_clear_tce(vcpu->kvm->mm, stt, stit->tbl, entry + i);
 		}
 	}
+	rcu_read_unlock();
 
 	for (i = 0; i < npages; ++i, ioba += (1ULL << stt->page_shift))
 		kvmppc_tce_put(stt, ioba >> stt->page_shift, tce_value);
-- 
2.54.0

