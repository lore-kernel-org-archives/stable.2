Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F215E3F44E2
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473191; cv=none; b=HJPkf+xCCQyu+9Hh9+pJn9P22JK/egkdVwIJArroH2rO05b/IemykxNS+NaZUD2Y64KpEsj12Y/tRL4whNPITmzjAQyQ7//QgnsnJdcNRBSG+k3cYqUazyeQI9Ng6+8MXDU/8HbVoSfslcIZy2V+JolV0A+OfDdDENlX/Nd2/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473191; c=relaxed/simple;
	bh=p+3Gwz6AyziYJJ9CXfquciLU3UkNoURa4qIotaW5/00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXxDDGpSadW9VuS/zXeAdMMY+IJcnFg/mWQoJ99ntkd2s/CpLAkO9jDyC0DYul2CsrtGZfAi8wGWW2YQwgLZ3OcS0QXoFYy2sFfLm5xcfRj+48s2t99xTGU9gIvhDeD3y9DferEzPjnGrPmeRuyp9S6LCPesRRNhwARww2a93I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K74/fKpI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQD3tHAo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K74/fKpI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQD3tHAo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
	b=K74/fKpI+MmLt9Exv4D+SxqzqtXXmrQfhfZZN/uhnFMIWVz+6HwBb/b62wZLm5Zb/PDrDd
	D4EmnHwVHbG9fvPnjTQHHoZ7lfHR7A1xcSFKaOK0co91vzng+XifcEy1W6xOTsMxt0XejT
	EcgNvEUHwYWTTDiWHae9e4J1nAXI5o4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-sE2hfALWP3a5c4lKUilWZA-1; Fri, 26 Jun 2026 07:26:27 -0400
X-MC-Unique: sE2hfALWP3a5c4lKUilWZA-1
X-Mimecast-MFC-AGG-ID: sE2hfALWP3a5c4lKUilWZA_1782473187
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46f291e7cfcso454343f8f.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473187; x=1783077987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=DQD3tHAoqnURqStFrOxWv/JS0BoZDOHFQhQ1ScS/BMkfrPvH0CedJch4zkDuj/ypn7
         Spkczwudnq1p3/0rody5oOAPq5YEvs9qX862FIdQ9W6hT1iph/1Gw77OoOp2dzwKaI65
         AY4ooyfWOdr01QOD9Joj310MuTK7tixqJ/mm7a9V4EdPRN8GEeRLcuW9EFXUHduIVRbJ
         v7EJ8qV93Sdsk7DfiYbtmjLqb+nGXtWZcp9a9NeSP96fz/KwHAVpJAqUNSBrfyWZqv8a
         8tCOzrL2NO/qt0YVo7GOLpKVK55RKFTzA5dLLYsJ48jxxo3AMR0VjhxHlh58s/KA5LIF
         +rRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473187; x=1783077987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XrY+UmUW4JNwUSoh7EwGdDHBgh7nGvRI3+n6n9n1VU4=;
        b=hv1IsTcCo15w05KgCPVG00njusVxUKot7ly8dMcMxbneNpLF41oHbQlA2BNmO3Qx2v
         539rlAO8V1iemjfagreM2RQARXJzUZNZsPSvI5yoec4ciGGhOLh0Kml4yEJSX/hqdyhh
         UWUOY7nuvno0znT2a2leLnlyor4gAAM6GmrCwrsNKwbzOtb07cpDTrAks48L/OHDorob
         qLw4gVGUudcQXrq7yxw3NZCV5reBtqSqYii79HGv4nZJM38E+/PO6GMz3EnXjtFPPCiF
         dzxf8HTf6VVHkMqDpbtlUySpycNn1g9QLX3eOxMV291YS5HdehERRJn7PPsyqeCs8v0N
         gIDA==
X-Forwarded-Encrypted: i=1; AHgh+RqpLy/9rFfmlDsH49mXLazUZbYaVBnWrSwzRM1C72PeVhwbTiUGIO+LOlUR7dq0NZ/yjIweFLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6czkw/9KzFjlicqtRkh9lEIr1zh5qwJjLnKOxFJeF9BFMDNsr
	Gw3AJDP95+1u4Y1+3b9vG6ywF8pqbnJZCZl6j8uwCBFDiOquEMNM/YvcJaEzEkbe5px7TDTFvDX
	muzOwsKDIyUfjdSDR5vc8AJyRUJEXyt0SoOM8b364nIUptCHImI+uHVbUAW8SU01m+g==
X-Gm-Gg: AfdE7cmd9FR57Yp02AvABQBJsp41Mil1eIc0ITO+3V7L/o3IMo6lbVlwOqO8v7WlaSy
	z9JW8eafTC2WoAE5sNyUZvcoMqxqk/DbJneqmnuIM3FjXlkcnDjjaES3+DCU52N84kS6YuJUwb2
	PcjByluCkldDRgnoOO4J7hwKebVf7KbZih2zdTaSHEZeGunhu4F+3/avxMV/3qFrLoml5VQc9Qx
	5tQUUCEKcGAn6mZXKsf/2ZB3/7NqmxiewDNi8FRSkzdkIqMPFLLy3nmF78Ga6GRBvown4nf7a5p
	J88SyeqsRUXQGq8rqefwr2dIKgvpzWU7FHzk8/kEKrwhSMwt3JRfTUJCJFv9VwspXofFdaoGNWE
	gjEzVF5fWist2PdzO1XYXsSNW5QD+4uT4arKQ1qQv98yZSsVtNMl7LYkMNZMegyn1ewLbz9YQ0u
	ypUvZ+GSASdLlbwAiD
X-Received: by 2002:a5d:5f8b:0:b0:46c:c078:9d71 with SMTP id ffacd0b85a97d-46dc1c93135mr9386820f8f.34.1782473186706;
        Fri, 26 Jun 2026 04:26:26 -0700 (PDT)
X-Received: by 2002:a5d:5f8b:0:b0:46c:c078:9d71 with SMTP id ffacd0b85a97d-46dc1c93135mr9386777f8f.34.1782473186287;
        Fri, 26 Jun 2026 04:26:26 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46efd7ee1c7sm6765881f8f.14.2026.06.26.04.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:25 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 5.15.y 7/8] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:26:05 +0200
Message-ID: <20260626112606.1778248-8-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626112606.1778248-1-pbonzini@redhat.com>
References: <20260626112606.1778248-1-pbonzini@redhat.com>
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
index 6c9656b8062e..e9dbe3e7ec62 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -2175,13 +2175,15 @@ static struct kvm_mmu_page *kvm_mmu_get_child_sp(struct kvm_vcpu *vcpu,
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

