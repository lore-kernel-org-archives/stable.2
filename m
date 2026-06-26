Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9636C9CC
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473053; cv=none; b=fciFlFFlPb90S/tRw48etxgfFEbzrkySIbuf1ahPC1Y7TRLe7RfYbFfmQlOlxIZ0ynBFlmT6y1vE8DFZ1AXAt1qLpHtEs3L+hTfcvsrf1Br9gQivb0VvDZGAVaTGgUosbHTPypKockthP8hmmlM9+PIR3Hq4G0sGcOp4BeQC3hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473053; c=relaxed/simple;
	bh=XlzafqtqzssCQn0fo6uVy5EqI86whNIzBdn0viwW6Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cjpbn5ozmkargzaY8C5WQY5+vjs9Ohu9IYaI3THpR5qMA93Gtse84X1APX5yN5vnhygr/W89pPE6KXlJI7S2/8zicrBhJhAR3H4kicSoZtpZWtoapYXBKuv4//XKI6XifFUEz6NGZqTPkR7wGRDanhrgTv6CS10mvq8QNEIhlak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DmUt+voI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9GjIxwX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DmUt+voI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9GjIxwX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
	b=DmUt+voIxM8TonMDFmWGj9593lMnYe3BheI+DE4VCUxr4FYxlMOROOyt2df6AhYGuKcRC8
	RmFRCHlYT6fSC+4fn3Z0L8fUtU7dnyLnQbhTQsgZpHxt0e8I9BAGhI++4tUNrv4t0w6A99
	1L/QQ4oA+LD7fwHnCDs+ZeLi+e+otI8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-g8A33SOKP-CX4aJBGCWi6g-1; Fri, 26 Jun 2026 07:24:08 -0400
X-MC-Unique: g8A33SOKP-CX4aJBGCWi6g-1
X-Mimecast-MFC-AGG-ID: g8A33SOKP-CX4aJBGCWi6g_1782473047
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4926d371224so2845185e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473047; x=1783077847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=I9GjIxwXr4EPY9uGQGMdNyvUX+kb/8/+EJ4EePUmA8A5Wlp/xsaCtZeMpQH7l6vjrq
         BFRawBnpqamLKqtZAxfUxf5YVa+SqXm8PnpI6vwzE4yKgK5izeGDB7I/eSWghPPVnOVl
         93wCk/vqgZ7tK2qLlMeX8WmoX+SRjyOz07RQKjOoLGfZpLfrJmRIJ5akIbLecf0X9Ht0
         97ZVfDUXVLA1MqpaaSPKih4MEBTvPoPd25jioB1Oyve5bPuK1mcL75PKd1oKFj3Xw43+
         4Az2toEtIne9qnJL+J8Q7KT7fioRuSgg7cHd0XxvWrLenzzyOecZlcWMoVRpccG8be84
         nf7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473047; x=1783077847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/74rsUhBrFOpgTK5uyMNeeX5nCLK5VE3Yzf3wlvBABs=;
        b=ixdg2yjwKGtABU7YXfBHO19OUAZe99ER76GH/D8tuRqdbNmKQGmVSVNyPJg1xJLIqS
         N3L7BoSUorRGPm+VzJ7tL8qhD16XXeoDA24lGtkmYuLfhUYOJH7ErcDw4y9HPUeOpfC9
         EgGKcsUxmIAN4EkSKc4QT5Ajt1IbHBmLxfznwoQF2cQtxe730bD92GjSSmt89WFBUVGr
         C0NMLAKa+fZEGJA8MsxgtuBuIGXhH7+oQ9nA6MPinw9prto1Am6QJUzZjVdrXBnSA3Yc
         0qruuefdVURS1ninnd3K0il81kso4gkDMDXRCIuExOcPin4pWyjruTRz5Z8pgdQhWqti
         QSBQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SipyIK+gsYYACPLOlz0tMYmCn7VGe1RzCCvDzwRbX6/YwEFddzvisGjeTLMVVq5NaghW3wLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIMpixtxK3j8OWv/OAFvMTiKd+t2NoSCnte4xvySAuPZhQuBt
	Ur0mqBeI3Yjk8W4w8eIp/y/ghPrAIVgCuo5rbbW2O3zjxg4c3tr14GB2IJO3MD79VEp7ALL1Y9B
	5AunztQrq9wDzo5z0Duk4VHfTV3IZ6N185CUmgN288GiUV8sOqPSqfIa9jg==
X-Gm-Gg: AfdE7cnaP0q1/0cG/8nR7GswcuQWurv5yrpZyxqFr91mGa29zIsVIyK0Qeeu66IfyPy
	DpTNl3QL4wJGfVhOS8Y+mKitB9ove+V9As9Ff4uHn2KqQChvroPFEFlGnEUUDvCT/8hn8/tW2yP
	NjcfNuwk6YVa28p6Pl1HEXoEDMmsFAJynlqjhBArA16bWbaSrjDGNPKne0CEpOR7B8FQQmESCpR
	EjCllJVood0fuJZ5icDeI/ClGvvaIfMD+rcHhzTgOHN13GGDOvAValb0BvFrIY7ZVLM60/bayj0
	RSTpiDW7zkor2VOKEdYBp9pdWmGGBXjijqW29zmE5Hm560GLtIjZU5f/UJsCyU5JshCX6wTCpDA
	u5TxOvbyp8Q8PLmCh2CtLxHAkzd3tKgLPzVgEY8J1EmcVkA2bQ36asc/O8vKqBmZP51CA6fUkZC
	YNlTPKzYOzX8WkhAq8
X-Received: by 2002:a05:600c:4f90:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49266884b39mr85434255e9.28.1782473047298;
        Fri, 26 Jun 2026 04:24:07 -0700 (PDT)
X-Received: by 2002:a05:600c:4f90:b0:492:3237:ddf with SMTP id 5b1f17b1804b1-49266884b39mr85433705e9.28.1782473046765;
        Fri, 26 Jun 2026 04:24:06 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46f0db007b3sm5172225f8f.2.2026.06.26.04.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:24:06 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:24:04 +0200
Message-ID: <20260626112405.1777340-1-pbonzini@redhat.com>
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

