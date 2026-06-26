Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872073FA5CA
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473245; cv=none; b=UQPDBiKsWfIiZb4U4oxX8VPqcnMetHZbyLGFgbJYjyAk3abb79ykUfC9Q3j5Qte26UsS8GSYJJ0Q2hQFllbdGNb3C4bnVxG177thjqQta6q5Le/eI76+XdgoeJRFtlIbvXIZuRfrP9AFQmkbZCNi9rCi0teXpkDn2RUD5DM1B/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473245; c=relaxed/simple;
	bh=1+pTIegP7pRm2oKQ0Occ6wuxA4zZ6yWLC3Lm96uIe/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaL5N1r9LkjMOIaX31CaLzLo1Pq8K+Rjf3gL2NJytdxi9gZyH6EDj+AQybT/+WBGTiTYz7+LXUQ3f1fPfJXHtSS+Rnhc9iijzyh+MtNtUP6PPz98SboEZIW8AMPLEOd5I1qRI2mUfHMmuJeXrquhfO0E2LYDQewl6pmsIolldP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fZTqYe9v; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=t+BC6EuV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fZTqYe9v";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="t+BC6EuV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PkHkQDjBcpvj3/e63ukJoKb10fFeXwe3AyGk2fTcWyI=;
	b=fZTqYe9vpWf+F/JL+iUDmsL2AkXWw0qzjRdGWDeoRMyBVikrDT5qYs3Mm6h7gO/WRndf+L
	tEIyksaLy6lr99cQTVpXPLw4hVb+a3NFhEkLUqwkTtlxPHODGi0EpBI47+AwzdabWKBiMc
	SNLfNhHHaahvirWPBWjfqAIEbjnJ9dU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-fhWQa_c-MaaoVhrhdQ16aA-1; Fri, 26 Jun 2026 07:27:20 -0400
X-MC-Unique: fhWQa_c-MaaoVhrhdQ16aA-1
X-Mimecast-MFC-AGG-ID: fhWQa_c-MaaoVhrhdQ16aA_1782473239
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so9047255e9.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473239; x=1783078039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PkHkQDjBcpvj3/e63ukJoKb10fFeXwe3AyGk2fTcWyI=;
        b=t+BC6EuVmOhZZvXvSIeR9NRDConf7ap3HZCSmp/cJYajI3V5ivwkTQz9blI7hJQnJx
         8hCS8gZAPB4sekDgrwXPa+TV7zCtFccIg2zOPn1UqHmwxdhTq5mfEcNPqlMA6P8+TuML
         Tk8iyHeMyI0JDHW1r/H2h1J2yDIFGL3IuKAC1cuNZ8JQg80pLuCiLu7gc1rS8rTr3CUt
         OirDOnD5tavXL5cFJOrkIGYwvksNfdHRhcSoZvUU1OajUfsnyNzksH1SxHdldKxrCM4N
         D8xdwjwoZ3/zDqiUbTkjQaOshSS407rgMmCsgphcU7YLXf+8FgHSXns+jntbuE9yjH3P
         IOJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473239; x=1783078039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PkHkQDjBcpvj3/e63ukJoKb10fFeXwe3AyGk2fTcWyI=;
        b=BQVocG7hvk4LVRdHHGT80AixBKccn2iL/+OmcMFGV/MuilI+ZAmiLZAX6m6OoxgYZl
         c03UudwF0awlC8D0w7/t21/UbtvgttV6ZBjApX1BrFwtYIjg2XpGUqLJlFMx1OKiaex1
         cSNe0N2vlEg0TY+SC+4atOhCKr0ZjmJn96DdXoGxWaZIgbc5BhxavidOhCreGeveSz4U
         X68XEnYE5lhFu7qr2T3MyPeIsRms3HVvDhMoxWrcYDP8ghtGbDFYlM2V/IzXtip6bybN
         arDguLS0hQX7m7Vb6PXK68/EOnlEJFNrx+yzyzPZM9yavAOMH+A7e0EPdl+TPd8UJXOB
         Oe4Q==
X-Forwarded-Encrypted: i=1; AFNElJ9SSwiDhSJ2VkQeQ8BHnGdyTCLrNC3QePapdI77GlLCu+y6Pv3P1eR999XcGH4Gz8qfBjjcIvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbtxwOhlpWZrpQIOQI+G6wIMwJ3DTzw6JXORim9cJ9IbtP56IU
	0ZdwkPnuwYMoGje65y+S6NFdbvR3PrcrVhYv7LdBbmm3FNWQoQo5HjsGYTW5AtepbQpr8j+/DmU
	WsdqJrYxI+LuFh6yPyFFm01mI7DhmdO8zBC+S24x+H9FNo5UHmUnEwZlQKQ==
X-Gm-Gg: AfdE7cmoavSFaN0wfr6BGWlBl3DS61Sz/j8S/XDy7Yh3mSkPP7dxeP9TU00LvxvMpN5
	/jnm72wplJ5X38qlXC6H4ZCM2qj4KT0yWFW76jx1Gi/I1Sy9PnV2Kaa9JYNR7/HIYnGybtWPwO1
	q+HeVUdq814xyao4sg/OEdqXOJrzt5VEF4tUhx9+c3iqJj3D8djJ9a/A+r3eHoCGV/gNM6KelF2
	fY07sYFC8Lq5s5UQgKF+7EkcKGG2p+PYITkoocFhrxrQbtyA89oP4pzDvbHgbXLR01Hqjl8X0YP
	iczmR4PilY4xvBJR+l8voiol4lR4SYJE0lQLdiq3Wwe/n8fvE4cXMzw1ztDUcKOpt6PKDU4k0n+
	fjQt/3FN5CLJOHBk9Zk82YOCSzik3WxEAihZi+mLwW4oKXavT8sN2o33QKe1GDWNMPB5qtroZST
	gz5mhHLULX8lEZ6Rjg
X-Received: by 2002:a05:600c:c3ce:10b0:492:6067:2a6f with SMTP id 5b1f17b1804b1-4926689a01amr76140895e9.28.1782473239048;
        Fri, 26 Jun 2026 04:27:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c3ce:10b0:492:6067:2a6f with SMTP id 5b1f17b1804b1-4926689a01amr76140525e9.28.1782473238609;
        Fri, 26 Jun 2026 04:27:18 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b734sm25557109f8f.30.2026.06.26.04.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:27:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 5.10.y 15/17] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:26:32 +0200
Message-ID: <20260626112634.1778506-16-pbonzini@redhat.com>
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
index b669a847e007..276cf62eb94d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2118,13 +2118,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
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
 	return kvm_mmu_get_page(vcpu, gfn, role);
 }
 
-- 
2.54.0

