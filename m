Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=77.108.111.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795002172;
	b=W5dxP4zxurgUw5DGySCy3ptN7IyixCFZqm3WV0etzrDw6q6Bz277KKsHHu93mL6Mmca6
	 ZePP4gRtYU5u7KhMzhG9R3NyxnTq2MUSLRCH80B25hfOTKcy6Xw9gPteBa3f6xlutKr4A
	 HwjmUrGZIOgAYTQSnCpcdvsTRf25ZfYDH2q6QYWOvNV0Y3VFRElfcm3FreD9/XnE7R+4a
	 F2K2z5ufrlOmVAz+nD51QdCLGgCgCWNNSeDT8pV058mFxKKEgFLaTJmxeQWAvSa0CxlgC
	 /e0JBQgpuLdKMMslCwDp3Qr8DK3Mq6inWuWzPuVaauGFXE5meuFFok4UDu9IUgcPSOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795002172;
	h=DMARC-Filter:Received:Received:Content-Transfer-Encoding:
	 Content-Type:DKIM-Signature:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 X-Originating-IP;
	bh=xy3wwlq1qAjY3KOqMhVgEHqcecxTAejvnEiypNdka20=;
	b=TVkK6O3HslBRv9BFN9r4MGCqYxLSfJi0Km3o8CUENtCoXKAlBdxdmOJxrVThY1NAdznU
	 g6zknZb2tdShN0IrAJSxdSaCrkVwPA1aCOanfcjCALXGtHRGOHGXWfu3HXLtQLraS6K3L
	 VTCn/AtI1NaKzEVeSC+EOhDJvnHFnBriMdso32Hyfu5e4mudpmLXmxtsrZFzi5oFq8i9K
	 JpLJFF5tJiyYWiqb52ZMfv2TplKtfwJemYUls2n6yDEYNuQ/PgHCT7NGq8srrO4ajFAVV
	 PCmoQQp9BTachkA6MHInAiXL57MLlJswmpONJ4t+e+HhjCeJmE5F4ThZvUwa11KAnAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amicon.ru;
	spf=pass smtp.mailfrom=amicon.ru;
	dkim=pass header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=j6drFrlW;
	arc=none smtp.remote-ip=77.108.111.100
Received: from pmg.amicon.ru (unknown [77.108.111.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF22606A330;
	Wed, 18 Nov 2026 11:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CF22606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amicon.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amicon.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amicon.ru header.i=@amicon.ru header.a=rsa-sha256 header.s=mail header.b=j6drFrlW
Received: from pmg.amicon.ru (localhost.localdomain [127.0.0.1])
	by pmg.amicon.ru (Proxmox) with ESMTP id 0717F101832;
	Wed, 18 Nov 2026 14:42:48 +0300 (MSK)
Received: from mail.amicon.ru (unknown [192.168.0.59])
	by pmg.amicon.ru (Proxmox) with ESMTPS id DACB91017DA;
	Wed, 18 Nov 2026 14:42:47 +0300 (MSK)
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; d=amicon.ru; s=mail; c=simple/simple;
	t=1795002167; h=from:subject:to:date:message-id;
	bh=/UGFBmqWAxc+UXyoNHL/nGVn+MKrgpoqLB/x2t6A9a4=;
	b=j6drFrlWH/TsoDgbsgAJR3VgDt4Q+6pUMoRM6w1mkjLbeDxRUW1Tt/oPpLIp/xfCDudq5lcd3+B
	m68KqgAhKtqjUY3Drxv3e6UDyvuIFIK22ayCO2IQwzJe6Gnp9Srb0dHZGR7E0zfOU7OxzTW5dGjp1
	PB54MLuK+Q1oXPa2g4XmDwrjIYI2cqVyov7+xuF3yOz8Qk2Fv7TNl+C8tCiEKxH9QvmKjneQF4Ttg
	abycWlEXvJiYrc8JDh2Stai82jKCYj6K0BP5pIDu8CJaj1HfGIyCzKASySED90NNyxapvsIicZ3HB
	wYZLESOh8eG8m4urUSda+BaObI+uCWYcbFEw==
Received: from amicon.ru (172.16.2.25) by mail.amicon.lan (192.168.0.59) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Wed, 18 Nov
 2026 14:42:47 +0300
From: Artem Novikov <naa@amicon.ru>
To: <stable@vger.kernel.org>
CC: <kvm@vger.kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>
Subject: [PATCH 5.10 2/5] KVM: X86: Synchronize the shadow pagetable before link it
Date: Wed, 18 Nov 2026 14:42:23 +0300
Message-ID: <20261118114226.26178-3-naa@amicon.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261118114226.26178-1-naa@amicon.ru>
References: <20261118114226.26178-1-naa@amicon.ru>
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

