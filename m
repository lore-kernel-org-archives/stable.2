Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C347377EC2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472960; cv=none; b=JRLUf8ppNjLnNe10sZ56WtoSwG0AdsJ8Zi3H6nQ7lx3tIuvasVCmMoWyBp5mwJl1A5n8iTcTBZE/s4vKn6/v1QgHOtsnWJJPf77LhpxPBpTKF01IDvyi+mV7XrGuGyYn664kghFA3OeS9ApOE4V9Yqr1zs11fr1HT0FIPeRf2KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472960; c=relaxed/simple;
	bh=13RMLtcXtrlLSFok0ONZErzIGBfkNRnW2XbObGH94i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tAMqTrMEZjoYejgzwwpuzgFVKL7NdRz8ZXQGFuYmQFQMp5edXwicR96BQhEpNjNPHEGK1AN3sgi1TGd+vSIom5bme1q/XmT0M5/KYBlLujf3GMkIEYdhw/kGK8JKKZiiFuCmDKWW3SKHR8Hllf7F4dfQF+OYqmhUweu28YtZnZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T6lEM3w9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2VMTw7e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6lEM3w9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2VMTw7e"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782472958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
	b=T6lEM3w9h6/OyuV6Gp+K99VAFfGzNSuZrt9fbPtaA//Yu8vAkCeT2I5vKAmsHzXN4gqG/P
	UfBMk5UrAdPu1KBd5qhLtCEiEa7MlFlMVtAbXPrY6hqiElmiL8Px2dPOIP5bx2Z238w9FE
	KpGPI0a2Ey5Xr7pK42/cY+iEhTerbaw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-F8XLrhzUPKy5wEzzogw5Gw-1; Fri, 26 Jun 2026 07:22:36 -0400
X-MC-Unique: F8XLrhzUPKy5wEzzogw5Gw-1
X-Mimecast-MFC-AGG-ID: F8XLrhzUPKy5wEzzogw5Gw_1782472955
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490b4d3d3e6so6412835e9.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782472955; x=1783077755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=g2VMTw7e7Nd7hfaVwCyaHYj6qs/Xn1cCuj+xDPYmcUv/HqS2B/Bbi2kafVQIDmky9t
         H56tmOUKmcqiUlJvMoq2g8EYcu+6j7/jXw5vjNQBTzGYWvcROoKa/SWyHgoBaRmLrcKa
         Ou+LpyhoFVMgK6Bsk0s4GB3XH+wtygQfEheffF0x7UGQCBl6S5K2mnpb8C6PBYVRGuFB
         H72Ib63YdRksbKGmvMBX649uZcFa71c+rTiJE+SgORIbMHlbQG7C1U4HXTjdDoAhMU32
         Jw5KgU3EZIsgAMwJqQSezAxZ9tU59PxeUhpOTsa39R7xQ4LBw59/HkaZvFj7sIO9F32y
         vEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472955; x=1783077755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=XSzPfJRVgczh0RL6m+S/wqVAiE/m6J6DakDgjqO3WsbBn9EXoz/4bnieKaw15rs/k1
         8yLxAnOVO4pRBOM8mkF+/fX2iFMQwa8yfPfK1H+wewIjdt1ofK+GbFD5P5ezQEBbvG9Z
         Nb/+kh9w7QhEErs2Sk1cVkKi5G6iIWzPjDeIpJ/z2cQ2trU8BKL8HWdc5ZmixCa/9ma4
         BkeNBHtYIi1QuG7mDuEtVREntjc4zkToAznw25kI4Nm34NTsPgx/kBtb0JoODG9uwlSV
         A0WoMh4BUxKOny1yvrkG6ZBXXStoj6CPk75jZChGhw3w0iOca+7Ay144ci7LzIQSbhdb
         SymA==
X-Forwarded-Encrypted: i=1; AFNElJ+FH1tYoDj58MNpYz9PNIrCkZIZ58bNnSe7F0aSUHfcTZdBP/4Ys/KdOVnbKeQo5qeunXN60+0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6Qa4HHJTMU6aYBn9qYCLLuKH8mP3CD65zpW/l5krlatE+94t
	HkNZk/6mamMgcp1FGtZmc7c1KeMvA6T8gu9sthwstNl3uKxzKSZruOO3flnTSh9DuXAXQdnzK8B
	D6SDZEl1jCKhrGjyng8euJNagMO58NaQhjSjl0Gaerz9IoZu14T3EHI0HrQ==
X-Gm-Gg: AfdE7cmGj/jZjcHalevv7DC7VXcCn93IjxjkvB3vtgJFyHtTuKNhUpA4HcFsHC5AG7X
	/KhHLBax3AspazITrsa+BQtChqI7jKngrEpcW4ze49VrLvRDJu1he1aff9SoofXp2or8oaqItyd
	WCYQDTlq3coa3Sd+SNKVmqhpRZx8k2rn9XKMp7HT7WHnqQx9Mfd8kBECpfECcSdCPAotSpem9lC
	e+YTMfYgkZ46J2aO5JUvx/rksgyCwrfkUK/BdHtXT1lumetRqbN94/JRAp3fleGoUgUFD8dq23U
	sGqglby+RMnaQjgsgNdWCgS8gw5fHKxzEwAXhkI9+lUVd2XzKxy8WiDZEpYmKW7n3au4fLlWWPS
	2VBav05VLVU8j3NZJ2YbGSuS8gOzFIia7XIdRcA7b4ptSejYx8NRU6kx3VJoVOo9U5pS4lp0Vhg
	V6XLswxBWeyrW4fVL4
X-Received: by 2002:a05:600c:a209:b0:492:40df:d49c with SMTP id 5b1f17b1804b1-4926fc770bemr4682795e9.23.1782472954786;
        Fri, 26 Jun 2026 04:22:34 -0700 (PDT)
X-Received: by 2002:a05:600c:a209:b0:492:40df:d49c with SMTP id 5b1f17b1804b1-4926fc770bemr4682405e9.23.1782472954354;
        Fri, 26 Jun 2026 04:22:34 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4926c01de4fsm53268575e9.0.2026.06.26.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:22:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 7.1.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:22:32 +0200
Message-ID: <20260626112232.1776865-1-pbonzini@redhat.com>
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

