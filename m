Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D213F1ADF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472980; cv=none; b=jUFUT9QlZLNOYw5aLgIbdDYB4Lzp5QucqDPjQiZ0SaTYChzpJ6unFe61REtdBT1oPJuTu9BfkN2SL7MwGm2mtb/0GeuvqG2Smsk27/SQ4q0mgTCIOp4L3RPiAFFoW9OToU20XtppQKE58Dzfr1p6UGgn+M0KQNiT/AO2w0uhcG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472980; c=relaxed/simple;
	bh=13RMLtcXtrlLSFok0ONZErzIGBfkNRnW2XbObGH94i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HpBSYiyI/6i2cnt38dM7HHIvr4J9bs3PDQ7cq52LMKV+rOA3HRxdrnrdx3EFJsr9ZJgmWYS6B/0djlHOW/M8drNIRooqzGYG/Bx61g8OVaXunmqKcmJXKjmP7BN2NWTeZk6WPsIBhte8aMPP3cC/HklzoqqgVDg92x27TLf9P24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoAQqRrJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nHq/lUYL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoAQqRrJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nHq/lUYL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782472976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
	b=WoAQqRrJU9WhUggoqebsKfgRwd1joq/eeD8NJUwLVymU3JF21xETFtISpjeDlaT1Sswn9I
	l5TSQBrhYZc/ZqKEU5t1O8BPRC+N62Zs0tn7mqrgtMWoY77p2ZZ1tWmSre0uaydKG/YDKe
	6Zjk9O6OHsWalwO/v5wNLoTyED3v7oU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-VL5RbqqLMh21cr3yj9Wq1g-1; Fri, 26 Jun 2026 07:22:53 -0400
X-MC-Unique: VL5RbqqLMh21cr3yj9Wq1g-1
X-Mimecast-MFC-AGG-ID: VL5RbqqLMh21cr3yj9Wq1g_1782472973
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49244130073so6420565e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782472972; x=1783077772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=nHq/lUYLrt/e5FdIG6/daYncQZ/6pzXjsD+8u/4cRA/bp9FeDkujqCEcR6gLyGHBg0
         4sTg69HzPlhJtv0HKVAsBNDHvk34LpJPqupSDey6Or5jdasp8TxQOOuEBNB5BAtq+Ufq
         VdHqwHn6V/7Pn/jFaCQdMdeNptmPtl3cbQzEl4eiqdRIFQ4L1nKAB7nbfcLVMBFn2K/s
         9c1SAB4dlFBeWFPZJI7hW1gqlk0YV4WwFJrANMoOLxVNKy5koLKLq0KfdxkXKcZHLy0d
         gwJvrdYcaFw3PURZlK7RaoWrKvVV5LuWzOfnk16HqESseWFDTWsyCcUfG2PJraKlgaUz
         m9LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472972; x=1783077772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=PvizJU7HIz2wpO772XK1l+qbCkjAngaJF9vqVxk6W3e9ZuIZ8lzl0jUtW9lNdjVnJV
         ozQdohQ0Pr2Phujb50fQHRdx8/ZczAszpGV2/OgsJmU6ffxZd1VysWi1R4W8S4r9wAUh
         1joUSxGiKalmB4J/ZVfSwU83DgO2Lomp2UYZXdQLQS3RcFftFfUJyOkgRy3vWWaq7hx7
         BxuEve+PGohONV95IoHRzLrA1sqYsTPV25FMeTYmnTV9XlMjISfg6WsVYu+m93T5thjK
         iLTvGtAR5LDF/74dVvLN7HJC7UicDVNpoaPCz8JbW0h70YARjBA1l1LveqmMANOQex5Z
         TZ6g==
X-Forwarded-Encrypted: i=1; AFNElJ8BqM9NXiwUiOLeEWyi3NKPbbRYQcNYizoSRzeNupp1j+XDinnr3FUGhGSXr+dMffaW/98W7CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJMxw0yLsbt1Ue8W1eCJIAx2Fzq95FXqaIOlMwS1fq9e2tqNXF
	n/GngWHT1035N2lxTaJQ8el+yxj1h7WUglA/QJaAssZx87ueosL9wWyZwc9RRseKbLfqNp/V1Bj
	4hQ4Lig9YJyFNgmYZKFneahqpoqojWZ5+JJRRuBzSDURTZHckexXAFu6FQg==
X-Gm-Gg: AfdE7cmFtQRZnaxzY10zqk+kD1EtEXoiw9vQBcIGZiByCVB4mxPaN+EQ3P5F+pEFPoe
	FnoFOkAokN7MgdTrbiAHKUw6a8tAfYmGq1YZBdLDEPtloLPFBaW6nyfqaTJGgycbrKO0NSquYXH
	PxzG17NKjrpGFjBZbDqz6E7E6c/BbRk62iPWPA7BFlmnOXaOhnfPiiyztZrIpsLyXGwQU2dFgJJ
	RV0F1lS7dx0F9NilvXRlzMUNJExlLS5zVwIhOYL3pmOxJYvDcb4qEf2LPcnJnrbcPfv3Cxv7W3q
	coQL0raikkrTJdBmnJjZMZUtlOERMMQ7BT7YKgdF3bIwTJCjAtDgknFk6VUey+gRQnc9AiK2u2g
	9HADPzK0+JOpP9DAYLtioig8UTDxyHYQ8xil9fPi14nABmPMcJtKgzSukOBFN1DwCIOs9OI1mfX
	BHmZqCNXy+KP59HjWK
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492668628d6mr90694175e9.5.1782472972538;
        Fri, 26 Jun 2026 04:22:52 -0700 (PDT)
X-Received: by 2002:a05:600c:4fc7:b0:492:3fb5:4697 with SMTP id 5b1f17b1804b1-492668628d6mr90693825e9.5.1782472972078;
        Fri, 26 Jun 2026 04:22:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492690168d5sm97312125e9.14.2026.06.26.04.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:22:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 7.0.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:22:50 +0200
Message-ID: <20260626112250.1776969-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 81ccda30b4e83d8f5cc4fd50503c44e3a33abfeb upstream.

Commit 0cb2af2ea66ad ("KVM: x86: Fix shadow paging use-after-free due
to unexpected GFN") fixed a shadow paging mismatch between stored and
computed GFNs; the bug could be triggered by changing a PDE mapping from
outside the guest, and then deleting a memslot.  The rmap_remove()
call would miss entries created after the PDE change because the GFN
of the leaf SPTE does not match the GFN of the struct kvm_mmu_page.

A similar hole however remains if the modified PDE points to a non-leaf
page.  In this case the gfn can be made to match, but the role does not
match: the original large 2MB page creates a kvm_mmu_page with direct=1,
while the new 4KB needs a kvm_mmu_page with direct=0.  However,
kvm_mmu_get_child_sp() does not compare the role, and therefore reuses
the page.

The next step is installing a leaf (4KB) SPTE on the new path which
records an rmap entry under the gfn resolved by the walk.  But when
that child is zapped its parent kvm_mmu_page has direct=1 and
kvm_mmu_page_get_gfn() computes the gfn for the 4KB page as
sp->gfn + index instead of using sp->shadowed_translation[] (or sp->gfns[]
in older kernels).  It therefore fails to remove the recorded entry.

When the memslot is dropped the shadow page is freed but the rmap
entry survives, as in the scenario that was already fixed.  Code that
later walks that gfn (dirty logging, MMU notifier invalidation, and
so on) dereferences an sptep that lies in the freed page, causing the
use-after-free.

Fixes: 2032a93d66fa ("KVM: MMU: Don't allocate gfns page for direct mmu pages")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index f0144ae8d891..bb204d3c66b7 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2453,13 +2453,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
 						 u64 *sptep, gfn_t gfn,
 						 bool direct, unsigned int access)
 {
-	union kvm_mmu_page_role role;
+	union kvm_mmu_page_role role = kvm_mmu_child_role(sptep, direct, access);
 
-	if (is_shadow_present_pte(*sptep) && !is_large_pte(*sptep) &&
-	    spte_to_child_sp(*sptep) && spte_to_child_sp(*sptep)->gfn == gfn)
+	if (is_shadow_present_pte(*sptep) &&
+	    !is_large_pte(*sptep) &&
+	    spte_to_child_sp(*sptep) &&
+	    spte_to_child_sp(*sptep)->gfn == gfn &&
+	    spte_to_child_sp(*sptep)->role.word == role.word)
 		return ERR_PTR(-EEXIST);
 
-	role = kvm_mmu_child_role(sptep, direct, access);
 	return kvm_mmu_get_shadow_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

