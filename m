Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A248136C9CC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473003; cv=none; b=tnMDhbjJpt+yoDIAddCM0UOjEL2Y0vHfQ1YABqIj+3ijdedhQubIp1PxUDnMEh78s9Pymma/G77y1LvjpXAupVnfcdDwgerdg7BWwrQSGoYFb1EN4rNmGPpThfK7E4xynMrtaq88nzUQAEWH3J7cbByvMol6xXScwVvlpisJfAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473003; c=relaxed/simple;
	bh=13RMLtcXtrlLSFok0ONZErzIGBfkNRnW2XbObGH94i8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gHql/mloikzhecHJcy2o6rIYXHzBRhxNGqkX+ittFHvxUTH2gtV19gG+aiV5OGzYv4lREOU1bAbgtcDLSiYQTeAfe89mGjXS8Ne7evf5fXcZ8k5l4oG5VrRPjH8E1kq30/u6LtC0yhoSq0mJIbozMkvDumYA0xkvlNCXm7p0SDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1aDpPvS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ciDIFWxJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1aDpPvS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ciDIFWxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473000;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
	b=S1aDpPvSNN+7BAe/x/cH5rbo1IJ3sTznmcHP4MEHeBb5dr4YJ6NDI6Gkx2E1mcyKth6r55
	TzrXnjRFHRrWYwzLPba2QYhd2+PaKDZQQcFIsL7QFuaispntI6nGWI4PO2PKVO2t+02FEq
	bvH0SG2NAlW5kYT0BGi0LdgU2HBzj0A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-YbqB3--LNSSaPRHt_Yo1Ng-1; Fri, 26 Jun 2026 07:23:19 -0400
X-MC-Unique: YbqB3--LNSSaPRHt_Yo1Ng-1
X-Mimecast-MFC-AGG-ID: YbqB3--LNSSaPRHt_Yo1Ng_1782472998
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso5527695e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782472998; x=1783077798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=ciDIFWxJzhuWr2rUJglrwG4bcfnVES6ZnTlEEny8GaRUfSvf/3wS8/KIPQLxfAlU94
         aSU70RkApYtirm29Sd+TFfWKiVJZ4gEobg4CwAZ+4Jtx+N3Rt5HFaLA/k9kDL2lppWJX
         8cwHWHnNcHqRDUROdelChmO7ybS6KJ2yUHjY1Qj7k9aisIZdv+oJdQERWIjVQI326lIq
         rhQqim2RH6MeADgSLVfJbbX0/YzqTikKw1Yf4OD5b6DQVcE0x+rAfvjjETdMxYIrFKPQ
         OFYXnQAKEjrH2G71I6sXuC66oRYdabz+BHXHe5EligaaG5PUJbdZ5v3hzhbxpdlPGVwO
         Hurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782472998; x=1783077798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGmXX4WBXjzHN/a62VWiamRwoMZx1FPp9nRGhV6/6tw=;
        b=oBt28Pxe5TD9i9S4ahoSP32a/kxUubys1VwInTXDl3gtTeGatG4DKEGpOl23q12aHy
         WB4RlYZNDsunV9Z6SSRXphcQAaHHf/vwhfMdettABFaNSd5LRyj84NXP2UqkLhlGd3aJ
         OR5c+fKRpqH5Sc5S62aQs1EvYFPWlupb5amoUGlDlENwDvAITWoMLAhLJAfNeTtd0er/
         5QFs7ExKlzIsfc3oVkdcWEoKCjuWDHTsrmSm7QSUoWU6UJFuna38BzmGCSnCprbr7VRc
         kPvQHMjOHyV2jcdrwF8AJ8U18AyB3/FiwJJb0qnUj+/8PVZDXxZ5voYtsUOHc/vEsUVX
         9lFg==
X-Forwarded-Encrypted: i=1; AFNElJ9h9wpCtFa0XDiJK5s/IiI2GjYvYexIvuuxOHwDx7qIlZcpqySf1cOSFoQik+n1XaRkQxfHsEc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Lw0fvUJLVW9DwQTeW0ZR2miVaZNZ1GK6VaAIohAgCkDwFIRt
	U2JEMPswehkt5VfrkDWqNHlaRV8nE2wUSpxaKGYbaUyeKG06g8PaoOE8FOkCziy58oqnsIt5pGj
	AhmhhOEBtySfGs1tf7siOd01qIcRgXmDhzZISYhImaMO//l81ZovfAJh1mQ==
X-Gm-Gg: AfdE7cluqcav/r/BlPJSalsda5tbVWAbVEkIbXnxB7UZzvzS5D0uH1twQQeQ0ANoqeX
	fP5Proq7ZExzsBol0ZqAT448egxbGZqxdqL+sBB5wwdX52ifLIP72fovpUrgGkPRNIsguBSKyLD
	qLsgabPcmtMsu9p9fc55gJhudJHijC5SNm/yYfujsC07TMb7MiW0EEFLZaNQrWnUDNIJFOU8jov
	SsWor8frtrfjDpadYZhphttlHu1J1HElvyiKPI5YqEHgGzfuRtGuZl6s+ULyBLj8yMYkkcodv5A
	VpFr2urO9O5YmtFybH26yXQ5YXZVsPphTLZCB5wS2QvoofFSmOBsZyL+04/aAubPKwrwu9vh/Ni
	l7Eb0w1g7aK8dPCoNfJNIYjzJ8+3eHpb99m2PU7vCI//v+TINH/OS8laMiFGeV5qAZPdsUx9foe
	iROcI1vHBldDCLQktQ
X-Received: by 2002:a05:600c:e555:10b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-4926685af4cmr68774845e9.11.1782472998066;
        Fri, 26 Jun 2026 04:23:18 -0700 (PDT)
X-Received: by 2002:a05:600c:e555:10b0:492:4a70:faaa with SMTP id 5b1f17b1804b1-4926685af4cmr68774615e9.11.1782472997674;
        Fri, 26 Jun 2026 04:23:17 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f8d6f10absm2415443f8f.5.2026.06.26.04.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:23:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.18.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:23:15 +0200
Message-ID: <20260626112315.1777138-1-pbonzini@redhat.com>
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

