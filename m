Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58A3F822B
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473228; cv=none; b=cpdCgw1jfsiIwP2/CtnYpN/Tjxv2b41tYhw4OrePExRhePswhc3v85J6Cih0u7kR5s1a0E+sL+EqERa3HIZ4tiQJxf8cLKjuWcn8gVhV4czCGx1kDLvdxIrGeFwoPIm5RRp9pFSQMWUKXnHuM2uU67/dmn0LrDayuMw7l+f8Phw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473228; c=relaxed/simple;
	bh=S7C4OiMM2Cst1oZit0kbD3rwF9kEhOT+2FiGE9qJ7J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wi402IUUDDBuAQDcrNQq7SPbkdmUhhazMgF1j7IbZETOs7G5iSIFIEf8nQ+EV97Y9YXjJmYfVZsbmhPTolEGVCeeImC6H0at4Iy4ChDvO+EtMjV07aT1EwFQ317mGvas/PkSvNNJ67Y6f8KFV7mgD9eizONd7/awcsXHOw7SZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZTIHoLhi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=monrxx5z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZTIHoLhi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="monrxx5z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=guVvEc4K0Spa25r+663b4DoWfeJx/0sCWjaxeU9tiPQ=;
	b=ZTIHoLhiA3SyA2JeJnDzDxxJjhRIM7bZcCqMOO4fxzP0E5+OU/8w2lyi/dqViy+jsWb0C6
	m9DHJD7CIyOFpvdLJNYhyYimBPoMIJQ9KdJJY37ItxXN6HOxXHMNjb5E7cOaOfROBxRTsC
	xrca1ko3b/VI9eHglo3UKSXV22umkQw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-oWLTriL2Ox69a-WKEa0_yw-1; Fri, 26 Jun 2026 07:27:02 -0400
X-MC-Unique: oWLTriL2Ox69a-WKEa0_yw-1
X-Mimecast-MFC-AGG-ID: oWLTriL2Ox69a-WKEa0_yw_1782473221
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4924a7ae480so7386645e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473221; x=1783078021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=guVvEc4K0Spa25r+663b4DoWfeJx/0sCWjaxeU9tiPQ=;
        b=monrxx5zoCb2RCuxwxPGxGzS9JPITUOeITUkVdmnR0+23j+GiikZ4i8xq1cr9oS4SK
         9iVu7lOS2a4zWlMYljfC0gh5rM1wSijjA6GY+2PTNKoUnzjsSzBdNpJvdQdjttJNM1VE
         MArbM8KklR3CqkwniXUj6QhCVCncqayCFa3QbRlA2mWe4nBqOqdeRA4/vSbIB/kYnXr/
         a87Rtldgu3tO8fMujC+gxgsUYMOlB++9YJHFBVtMUregEfDgbciMLLWSs8ZpraE9q8dZ
         /YL2qEqNM8OzC5/8OXYFa02hEc+XF0qY34TPwnjsxtsyzelehQ0r6aSlqhZFcQF9vC8R
         s3Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473221; x=1783078021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=guVvEc4K0Spa25r+663b4DoWfeJx/0sCWjaxeU9tiPQ=;
        b=HLMm48BcJ3kIGDs1B1BnPJpaUIPV5rLLw2Le54QSK4ZlmkyD6f6WcFXqTXQ3cFXkFl
         Us/7K1c6xWrdfIotyMhWd9uki1g5kzL8tdTLTqdTueUm6lTGwgi4IhOnNsOXhmVdjgb1
         +PaRmvC3v9tQh2rI18NtyB9Jd41RoHTrXRy0D8vIBksnZ+FG0gJKW+AnYuB8jiqbgwFK
         tqeABH3HUn0MFVm2flq3Vcv24l7eMxtYmdkHy8r7HcDg5Xkm5rsZAfJ250tcSo95Enc4
         a8fAg55mfd4YoBan5+EzaOCCEPioyyvZzSYLyHfTbrBYTRW60Z+6gWgTPRysGOnkA8+t
         ewOA==
X-Forwarded-Encrypted: i=1; AFNElJ8Kd40H+vCzHaS3FIDQjtpBO4nedgG/thCbbs3Cw4Ftz7eAjTxRU9jXG9OUXSHRv98xLpyHldU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJW/Fdj+T1AMb49CeAbJ8NThKlH+Zw61AqIMJ4M9DHQ7p+K3Mt
	5UNAkxckBcDAkJLQpcXjJx6RNRejwkq8NLIVQtFn0N4t98uTU8uRYtn8f4r7vInFVbXwp6kwiHf
	9U5kjvpNuEyqyz1/skNjMdON+btFN7Z2lFNMgaBoFGZ27wqSu1mK4ZPry+6BR+zAZ8A==
X-Gm-Gg: AfdE7cneefJi7TKPfnizYz3JtHcgsB9Y0tA3rr8I5c1pp0uJK3O4wyDeSnlTPENuD2s
	UkGd5lWrOrj34egxuD3lMqhJBFzF3qKadRBAIQGzpeTUIvaqg2UN/pvNZc200HYaNT/XlI/xl3a
	VbOE6kY5G9QnQRuQsAIsV/Ra/172OLlGR2WxXO1XtprXPmnPhTDXkRm+QtbxFzTEYpgHZt4bF7c
	WydxUcFjpljnLVhjANjzeuAfe+9YM9AbEV7zjOKgWnX5QWKInsLNE35cKGKS33b0q1XhX4ZmasK
	7wE7oN9Wa70XsBQESvQklrttwY8h0dN/35RbHxzIkSK17dkF9KxomnokuKaWbaSZDknSpom+GiP
	w5MdnthS9H1/TOT6OfMDv1f9vNNS6movlnKUeX2IGO7+x4g6KhvJj0lKb6a11MhzbjQlL6wRibs
	BFxIzwDfyiZY/DD8wk
X-Received: by 2002:a05:600c:46ca:b0:492:6eff:7d02 with SMTP id 5b1f17b1804b1-4926eff7d25mr14078645e9.30.1782473221293;
        Fri, 26 Jun 2026 04:27:01 -0700 (PDT)
X-Received: by 2002:a05:600c:46ca:b0:492:6eff:7d02 with SMTP id 5b1f17b1804b1-4926eff7d25mr14078295e9.30.1782473220916;
        Fri, 26 Jun 2026 04:27:00 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49268ff1be9sm72324875e9.8.2026.06.26.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 5.10.y 09/17] KVM: X86: Synchronize the shadow pagetable before link it
Date: Fri, 26 Jun 2026 13:26:26 +0200
Message-ID: <20260626112634.1778506-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112634.1778506-1-pbonzini@redhat.com>
References: <20260626112634.1778506-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lai Jiangshan <laijs@linux.alibaba.com>

commit 65855ed8b03437e79e42f2a89a993206981ac6cb upstream.

If gpte is changed from non-present to present, the guest doesn't need
to flush tlb per SDM.  So the host must synchronze sp before
link it.  Otherwise the guest might use a wrong mapping.

For example: the guest first changes a level-1 pagetable, and then
links its parent to a new place where the original gpte is non-present.
Finally the guest can access the remapped area without flushing
the tlb.  The guest's behavior should be allowed per SDM, but the host
kvm mmu makes it wrong.

Fixes: 4731d4c7a077 ("KVM: MMU: out of sync shadow core")
Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20210918005636.3675-3-jiangshanlai@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c         | 17 ++++++++++-------
 arch/x86/kvm/mmu/paging_tmpl.h | 23 +++++++++++++++++++++--
 2 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 161e05783629..6db07ebeb695 100644
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
@@ -3419,7 +3422,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 		spin_lock(&vcpu->kvm->mmu_lock);
 		kvm_mmu_audit(vcpu, AUDIT_PRE_SYNC);
 
-		mmu_sync_children(vcpu, sp);
+		mmu_sync_children(vcpu, sp, true);
 
 		kvm_mmu_audit(vcpu, AUDIT_POST_SYNC);
 		spin_unlock(&vcpu->kvm->mmu_lock);
@@ -3435,7 +3438,7 @@ void kvm_mmu_sync_roots(struct kvm_vcpu *vcpu)
 		if (root && VALID_PAGE(root)) {
 			root &= PT64_BASE_ADDR_MASK;
 			sp = to_shadow_page(root);
-			mmu_sync_children(vcpu, sp);
+			mmu_sync_children(vcpu, sp, true);
 		}
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1500fc877aec..25d4484c78aa 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -667,8 +667,27 @@ static int FNAME(fetch)(struct kvm_vcpu *vcpu, gpa_t addr,
 		if (!is_shadow_present_pte(*it.sptep)) {
 			table_gfn = gw->table_gfn[it.level - 2];
 			access = gw->pt_access[it.level - 2];
-			sp = kvm_mmu_get_page(vcpu, table_gfn, addr, it.level-1,
-					      false, access);
+			sp = kvm_mmu_get_page(vcpu, table_gfn, addr,
+					      it.level-1, false, access);
+			/*
+			 * We must synchronize the pagetable before linking it
+			 * because the guest doesn't need to flush tlb when
+			 * the gpte is changed from non-present to present.
+			 * Otherwise, the guest may use the wrong mapping.
+			 *
+			 * For PG_LEVEL_4K, kvm_mmu_get_page() has already
+			 * synchronized it transiently via kvm_sync_page().
+			 *
+			 * For higher level pagetable, we synchronize it via
+			 * the slower mmu_sync_children().  If it needs to
+			 * break, some progress has been made; return
+			 * RET_PF_RETRY and retry on the next #PF.
+			 * KVM_REQ_MMU_SYNC is not necessary but it
+			 * expedites the process.
+			 */
+			if (sp->unsync_children &&
+			    mmu_sync_children(vcpu, sp, false))
+				return RET_PF_RETRY;
 		}
 
 		/*
-- 
2.54.0

