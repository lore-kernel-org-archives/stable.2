Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD7536C9CC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473084; cv=none; b=LNSwzVtPyZbSjkcTt07Rev/nLlGbD4P7Of9sxWa9co/t62Cb3Ih1G6+BB3jsbKO1U2QyQVQD2hMtGZHvO6gVNpnxSDbXpbHhEqsQkdXBFfjSo3LmcOjeFhjLTv9ukLxdY2ljsAW8ZDFD+a9/BNdXNW8jgluhTbbib5JcxaQKJlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473084; c=relaxed/simple;
	bh=XlzafqtqzssCQn0fo6uVy5EqI86whNIzBdn0viwW6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s22H3t94h0W7xmMcWG3/PzlNGCdePG01kG30rh17k15djp2ktgfu+QMo74JGv76+eO3Qam2BGSNhDSwfNQYhsfCSJd5Izuasv+ARCOF6wN+wdBR5Be/DpOo3OrTiDxqJK2s8hBWRplkNZmPm9T+PyFErgjFEujKDnsTJXSaMhtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VOSzSVqz; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=dUVZdUMp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VOSzSVqz";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUVZdUMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
	b=VOSzSVqzeYlEyoHpccggB9GD4H+ok9yMs2P3WPkhqR28EAyPb3xdh/5EE8tpk/npcJv+CJ
	V2MtSbJpVNWfH3vOA6shDaabetpF61zCR8Wc7882NncoDKffbKuBDh9tnet1bDuKd8jFZw
	1ckFdkB+5pAzqFkKLqNysAd80w7upnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-Q1A1Kg-hOgy--6_9DAGHTA-1; Fri, 26 Jun 2026 07:24:41 -0400
X-MC-Unique: Q1A1Kg-hOgy--6_9DAGHTA-1
X-Mimecast-MFC-AGG-ID: Q1A1Kg-hOgy--6_9DAGHTA_1782473080
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4639f122c38so580039f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473080; x=1783077880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=dUVZdUMpzshfDCms0vtZbqP6eBCnPtglyA25EwiLT1B/GhiBUxsBBgsXpp4C7eQuLR
         iq9HSKkb1lmaNzmCoLNhZaPva5ITmiRXvR6XNcVBAXt86ohysuVsyS0VP1gBF0pCrF6I
         te0zERO+4kDFkIEN8Z8GD2KjDea3bX3dVpFOdWhmhk0bJwULyw9iR81yO2gHDBX8RhCS
         vcFXUic+o06DszK6lbAbLIf9zDLiXboNDBwL/yq9yFpI3/AEqsMLEK3X1gjfQHPy6CbE
         BFF/OWXmVc+hriVfkRvUokZoNe3BtTH2jkJ5YOcNoCMmgmqZYlHZktEElfMVtxxZ2h/a
         ztvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473080; x=1783077880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=OVe6TmSm2ycRtnKbeqwoyNRN0dhd4jINQf+CNRszeN99yCAVrDRm3u8SGMkaownCkx
         gLhfglUtLbto3Zt5OdeiG3O/jb5C2HWTk6B0aJSMBbKM9NZqPODq1So0pskEraCPO4Wn
         s05dG8Z+9RwZC5S/KHWTO6iWcWE0g/86mayoOjbcYLAfXIbGAt2eqw03zcEPR9PclOJY
         A9cwGwdxvpqMq2354zryWicHxQNcGeUszBZyO5oRHwoRVdAIagmj++hdgdUc0zVlySbd
         bE3tz8A2N5W5t8dmMjPfAw/GrsWs/bCECjxBrt/iSeW/TzP+UO9LUwgySJ1J48B+X/+u
         KtFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpZJHGIqSqBccOr2ta4XnbULTGCSc0yMwkiF6TZKzgVcbFpkgxrYVjglkekAO5tG4Jz0ETjAHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG2Fp3wRdiWW6Ao8GENCv6GH+h+QStKPYIkRRimepL2yHvAuZV
	VOZMbLM2Y7nKgjLaw0j1q+MtChYuUmS3Vao3S8nTwwG3FTynR0PkxojVtMZ5hB2V+qwQIwT/x8B
	HLHzYOZCH6mv+V0j9f2wVWURgpDs1KxbjSfXy904VOGeVeUJTmlRJNnxPeIAZinI0jQ==
X-Gm-Gg: AfdE7clccm1Br1W1edwMhaQdeWRAg2dtvFuEprj+WrV/ECzKJFBn6JYNcsJLdM3K90N
	VtUPvGJPMkF966X+o0ID45LHFJu7Ry2sB/JZ6h8w3fCSb9VBH6IDUXptTV2FJf3qhk9uBotcjJj
	i6fa1Mn2Wl7JIseFq1HCf7IDnUvq8wbb0jCS/gsZiTZAzK4qlqpLkDASmXRKKjHv7Jdb4NsMgH8
	91Ye6LUa4dFO8OvLc3Kt8hR/lXabOxj8mLb6NSRc/TzbXdQm+gRVC86NvwrD6IR/filhpIkBeFI
	Sl0s3CQoeeRKldBk2h6qpukzR1S8M19VDtBKl+LIWaWg450TDNnr6sAD4NhXO+/EvUX+1AKYvD6
	gYdazjZoXTFEnDJzxNgSSnzKvStfHahUSwnP3HyyC1CEMA+p47OLLt1kKu1sTD+nZSHA0lojaCm
	2H3eR4OCRhRO08RwHS
X-Received: by 2002:a05:6000:50c:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-46fb70c19f4mr392767f8f.16.1782473079726;
        Fri, 26 Jun 2026 04:24:39 -0700 (PDT)
X-Received: by 2002:a05:6000:50c:b0:461:fc84:dbee with SMTP id ffacd0b85a97d-46fb70c19f4mr392722f8f.16.1782473079318;
        Fri, 26 Jun 2026 04:24:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b83fsm25264375f8f.29.2026.06.26.04.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:38 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:24:36 +0200
Message-ID: <20260626112437.1777775-1-pbonzini@redhat.com>
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
index d288c60ae200..a67d013fff4d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2329,13 +2329,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
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

