Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009741;
	b=ZhCiRUb30EluI+G8tgaYdOVMEipzCk2o7tVsC6G619pIuYle93E0hv63WJrShEoytvKY
	 UXbjvYAqrKc2fSMLVQuAobvbJQTNuVvLq1Q7AF4BnT9Y6RwaJ//SBYGGmRcCccvCcDGxt
	 OPLaKYSbEfH1mhdlJJDRrfNiwp5NzXQS9yUE5VZE2NgunMvFSKSO5FrENLDxF+0ub6exT
	 SxjHWErgW8PfMMUay4rr4U3p1FjhLtzY41UcubFZbJlM4R9lxswFgRE+xNs3GR++G/Xl1
	 h/40nJXfxKLeqv8rRQSjAD70xjPFOORSxwt4QAIg+ycDbQMYmxB7KYWRigQM89/r9FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009741;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=xy3wwlq1qAjY3KOqMhVgEHqcecxTAejvnEiypNdka20=;
	b=4wwLW+ctDGbiyzmaXbsatkcxP2Ie5SuDqC4V7MvaIM7Yzj1KvjPXlb0+UUTLvVptT8Z8
	 Z1TDvxEd0xf6x73z0M0akdV0v0ZcbPRi8D6pURfDnu+YUfadYxd/Z1ygrhWxaos7cvPDG
	 0+S2z1aNvisJ3Ruaa7A9b7qKAvEqdVpvw1YPTSF/6PTXmZnINL5/OXeonbfzDwps5Hb0m
	 Sm5SD4Y6tORaA6pZCw+SNK49+XgZ9UvF6rIIwCv6TkUDjYOAdzj78G4yb512M6Mv7uIDX
	 ROl2wGwOuwzoplZwPByjHb2uoo6zxROhuRrklgLoltIrSDcozI1QuKHjKHkGT9VRlbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=ih0bnQd4;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7EC606A32A
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F7EC606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=ih0bnQd4
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id A90321017E2;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id 8F2C4101327;
	Wed, 18 Nov 2026 16:48:57 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795009737; h=from:subject:to:date:message-id;
	bh=/UGFBmqWAxc+UXyoNHL/nGVn+MKrgpoqLB/x2t6A9a4=;
	b=ih0bnQd4R7pE5ePcE6WOyQCS1oX7G7NhtusSWni1zZc6FesvlQQwfSsV3PaBgJqCmvpqmJunj1U
	AcC3yh9x9brOqTt3owyRVbDEDKcp4sxMBMa4IQ9VpBPsUQ7SvtTs+NH8Hgy/uAY/aWxFlixxp0SKr
	fRma3Xly1w1uovY14XId4YE/g748uKXtZqSUX7JZpAU4fX5Us4zS380LS3KBo5jT0CC8TqyUVYQJm
	ydmujRHIMXDM2n7/hGYSmLZ835fvvKZkEDqHY0Vu2xCxiaHS+3l0sqPu+rh/T3SEeLmhVKPCcECTt
	8gF+enTub3q+n6SkjE6nPTWa5x4TyJ4NIHjA==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 16:48:57 +0300
From: Artem Novikov <naa@amicon.ru>
To: <lvc-patches@linuxtesting.org>, <stable@vger.kernel.org>
CC: <pchelkin@ispras.ru>, <rrv@amicon.ru>
Subject: [PATCH 5.10 v6 2/5] KVM: X86: Synchronize the shadow pagetable before link it
Date: Wed, 18 Nov 2026 16:48:47 +0300
Message-ID: <20261118134851.203854-3-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118134851.203854-1-naa@amicon.ru>
References: <20261118134851.203854-1-naa@amicon.ru>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit 65855ed8b03437e79e42f2a89a993206981ac6cb upstream.

Synchronize descendants before linking a cached indirect shadow page.
A guest can make a nonpresent GPTE present without flushing its TLB.
Retry the fault if synchronization needs to yield the MMU lock.

Fixes: 4731d4c7a077 ("KVM: MMU: out of sync shadow core")
Link: https://lore.kernel.org/r/20210918005636.3675-3-jiangshanlai@gmail.com
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[Adapt mmu_sync_children() to the 5.10 spinlock and PAE root path.]
Signed-off-by: Artem Novikov <naa@amicon.ru>
---
 arch/x86/kvm/mmu/mmu.c         | 17 ++++++++++-------
 arch/x86/kvm/mmu/paging_tmpl.h | 12 ++++++++++--
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d2428c76d940ec737ec1d7e8dd447f3218c0c5bd..9e711d0fa02cc972a817aef05a92253d04f8648a 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1972,8 +1972,8 @@ static void mmu_pages_clear_parents(struct mmu_page_path *parents)
 	} while (!sp->unsync_children);
 }
 
-static void mmu_sync_children(struct kvm_vcpu *vcpu,
-			      struct kvm_mmu_page *parent)
+static int mmu_sync_children(struct kvm_vcpu *vcpu,
+			     struct kvm_mmu_page *parent, bool can_yield)
 {
 	int i;
 	struct kvm_mmu_page *sp;
@@ -1999,12 +1999,18 @@ static void mmu_sync_children(struct kvm_vcpu *vcpu,
 		}
 		if (need_resched() || spin_needbreak(&vcpu->kvm->mmu_lock)) {
 			kvm_mmu_flush_or_zap(vcpu, &invalid_list, false, flush);
+			if (!can_yield) {
+				kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
+				return -EINTR;
+			}
+
 			cond_resched_lock(&vcpu->kvm->mmu_lock);
 			flush = false;
 		}
 	}
 
 	kvm_mmu_flush_or_zap(vcpu, &invalid_list, false, flush);
+	return 0;
 }
 
 static void __clear_sp_write_flooding_count(struct kvm_mmu_page *sp)
@@ -2073,9 +2079,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
 			kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
 		}
 
-		if (sp->unsync_children)
-			kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
-
 		__clear_sp_write_flooding_count(sp);
 
 trace_get_page:
@@ -3416,7 +3419,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 		spin_lock(&vcpu->kvm->mmu_lock);
 		kvm_mmu_audit(vcpu, AUDIT_PRE_SYNC);
 
-		mmu_sync_children(vcpu, sp);
+		mmu_sync_children(vcpu, sp, true);
 
 		kvm_mmu_audit(vcpu, AUDIT_POST_SYNC);
 		spin_unlock(&vcpu->kvm->mmu_lock);
@@ -3432,7 +3435,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 		if (root && VALID_PAGE(root)) {
 			root &= PT64_BASE_ADDR_MASK;
 			sp = to_shadow_page(root);
-			mmu_sync_children(vcpu, sp);
+			mmu_sync_children(vcpu, sp, true);
 		}
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1500fc877aece64fc9e0f013554ae8ecff99882e..d9ab3a855a859bda1fd15f932db2eedf96f21953 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -667,8 +667,16 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn = gw->table_gfn[it.level - 2];
 			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
-					      false, access);
+			sp = kvm_mmu_get_page(vcpu, table_gfn, addr,
+					      it.level - 1, false, access);
+			/*
+			 * A change from a nonpresent to a present GPTE needs no
+			 * guest TLB flush. Sync descendants before linking.
+			 * Retry if syncing would have to drop the MMU lock.
+			 */
+			if (sp->unsync_children &&
+			    mmu_sync_children(vcpu, sp, false))
+				return RET_PF_RETRY;
 		}
 
 		/*

