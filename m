Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4723F2101
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 11:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782473267; cv=none; b=coxzngQ8SRytbWWV2SJA2m6LEd8a2T7KfRmwGDs8z10UJVACbr37rBdhgv3tTAwqzzDx4mUFRZUZ1VuI7Nb0PZ3cwIfEd1bovlkwgVZNomQV2kXuOXgsAmJmKgDDw7V24s0RTpmnXK+w4caDubT5/KOoJ/cQp1LHGn6ooHj0xsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782473267; c=relaxed/simple;
	bh=qzFqL40tuVr5uJc4Z/ZoRpVEOvYkfO7gT1pHry4dH8I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=gDeTyC6yRO1fLELVd0Mx4ZNGwRy/7HQLuu8PLH8PGe4NYcUPxIZV2iF4tti5urhUX0tm0r4Fb89fU/eD3Wyl61yNCA32VvxpAIMP7qS1HHU3D6KX1TBIx7AlZ+BY3F9v1qhDBQ9iW2hSkDY+3ETkkCvT/v/2sTol1D4+prjJ114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SsntBiIP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NJ6SCMkJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsntBiIP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJ6SCMkJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782473265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
	b=SsntBiIPYZRvXSRFzMlxhHH8HY0kZzHW5msDD7g89N/AXc1OQInWafuNAdEUPXZ86NNKEQ
	My1/F9phwgEI3VJnAiyDhZprDxdZR7ZAcGmML86Hc4Igh6hjyZBUUk0JcueS/wuehj50Z9
	1ZBjq2mQzsdTahUHXehUY041OmfUW1g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-N8O8qu09N6qy_uxT2XVodA-1; Fri, 26 Jun 2026 07:26:37 -0400
X-MC-Unique: N8O8qu09N6qy_uxT2XVodA-1
X-Mimecast-MFC-AGG-ID: N8O8qu09N6qy_uxT2XVodA_1782473197
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490ae461f8dso5554215e9.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 04:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782473196; x=1783077996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
        b=NJ6SCMkJy+MtVou3k1vMC0vLtkkErV8pa3s6fVdEfeMfBG0IAWd3FsSoYwbbH1v3HY
         OkuITdN6Id20RK5ZLFCgAosaYTkp2CTjkeWNSgw1jnOvT7b2/+R/hEL58x7DRcX45g3l
         zM05UWDLEAYHve+WmYW6ooWpmmuaw7XP0luiCm8PPWHFoZddtP15eOfsG2xpQErCjh4A
         tLks2KFImKtASxBKNVTeeanisuPrpxKLozL/jNjmsSz4cuYTRjFlboJzA+YrDTL4oM6d
         bm2oUkhXYfQ12B3EcZPC/f7TTuNOhSCIxeMzNwSVf275dC4EX7nwA3BpWzkABaGzXDYH
         Bn1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782473196; x=1783077996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d960/iMXCVx2w6Xzf/sxVDFmfLPy0pQ94ged3XDQsPo=;
        b=NUrowYZh+/4xUgGcAbOZwXkXaOAnvafDwRmcyGR6I1EqwQ0sNA5JlCOZsOXECBoQ/g
         OiG2gjQJkGKn3uJE070Cada2MUpFOYD5hZD991NYOjQa+Ke2KVKwrUmsz/2cyC6v6DEK
         dyRSKbsma6TUvJJVQHRI8HlVQWSc5Zoy2PyxFWHCuQh5bQ3Fmsu+yg2YZpH05OHa5E43
         SGRRYFzeOBPnc8cbS1BMgRUd0gdmmx0RmJopXV0ANJasyBqLaiL5CFuB5ZdC3iaFbKHr
         skEW5nXKj7gjMgkQcyDCHe/Dz+UEEW2QgqEfGGPCLh3wNdfzhtMGuIBDl6sXxOEUUHna
         gqcA==
X-Forwarded-Encrypted: i=1; AFNElJ+oTlvE884MDPS1nrTU7Dg5t4/TFNnnkhHtvZ5avj4z0QixR7xK6ekm5u7yh2WDfDnOyd/tmzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXxKqx8LPyifBI+Vb8I+PWdoAFGDvUdotnllgB+UIFYEbcOuz3
	zm0g5N2PddSSYWejOYz1o81D6LTUy+kJhxUOfzKAsNPcHaB2uVt/dv7kabmZ9ZSuz33CNYKzKd/
	2TJblBRZdLKLB/+acPnylW8FyxAlD9yBdhcXcXh6EaDRywjJ5OFGf5NJAHuCRDstkdQ==
X-Gm-Gg: AfdE7clH6kgU8DsaCHP/p4UyKAGrOrmHoPL+AG+ZnLwPyiU1qX8y3kGl6zEBn952aAv
	OWritqvoHNl4VzWBGJRXYHDHSsS75vy2TCoDc0XucfbciUDG4wv4N393z81LLI0JVzvO9mPtsH3
	Q3pp4RFTPaNpuGwwCAQIiowXaCn7dVupUzjAZOfv+9ZMAW/m3UatNM/GlUOISKO4V1a+X6/A1Zw
	dLQ2GhtWOpBml+JoDwfAFhYK8Y9G4Uliacyt8BDgpnmUPhY30Nc4a3QtJm+dzEvj1WjEc1AWMCY
	v5WI8IUPC5b9rpgOQdvBvTNek1RFWF9k+gGID2qWiPhGQ8no+P7hDGktq9zantDvrGx0hiz/nmx
	GG1VW4lqXD82xHsvoML4HmCrbLN47r8SQ1rsLiOHP1UFlWGD1ejPE8cEY/d+kd1WMPYeECgliKs
	aYAGhs+uj/ObQAyamU
X-Received: by 2002:a05:600c:c4a5:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4926684a6b7mr94795455e9.4.1782473196505;
        Fri, 26 Jun 2026 04:26:36 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a5:b0:492:2e48:81e6 with SMTP id 5b1f17b1804b1-4926684a6b7mr94795045e9.4.1782473196050;
        Fri, 26 Jun 2026 04:26:36 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.124.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm22611955f8f.28.2026.06.26.04.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 04:26:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.10.y 00/17] KVM: fixes for CVE-2026-46113 and related issues
Date: Fri, 26 Jun 2026 13:26:17 +0200
Message-ID: <20260626112634.1778506-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sasha, Greg,

this is the backport to 5.10 for the above CVE.  Similar to 5.15, the
fix was relatively simple upstream but only due to years of refactoring
and cleaning up of the code; fixing from scratch is not really feasible
so start by applying the patches that are needed.

Paolo

David Matlack (2):
  KVM: x86/mmu: Use a bool for direct
  KVM: x86/mmu: Stop passing "direct" to mmu_alloc_root()

Lai Jiangshan (2):
  KVM: X86: Fix missed remote tlb flush in rmap_write_protect()
  KVM: X86: Synchronize the shadow pagetable before link it

Paolo Bonzini (5):
  KVM: x86/mmu: Derive shadow MMU page role from parent
  KVM: x86/mmu: Always pass 0 for @quadrant when gptes are 8 bytes
  KVM: x86/mmu: pull call to drop_large_spte() into __link_shadow_page()
  KVM: x86: Fix shadow paging use-after-free due to unexpected role

Sean Christopherson (9):
  KVM: x86/mmu: Capture 'mmu' in a local variable when allocating roots
  KVM: x86/mmu: Allocate the lm_root before allocating PAE roots
  KVM: x86/mmu: Allocate pae_root and lm_root pages in dedicated helper
  KVM: x86/mmu: Ensure MMU pages are available when allocating roots
  KVM: x86/mmu: Refactor shadow walk in __direct_map() to reduce
    indentation
  KVM: x86/mmu: Check PDPTRs before allocating PAE roots
  KVM: x86: Fix shadow paging use-after-free due to unexpected GFN
  KVM: x86/mmu: Pass the memslot to the rmap callbacks
  KVM: x86/mmu: Ensure hugepage is in by slot before checking max
    mapping level

 arch/x86/kvm/mmu/mmu.c         | 431 ++++++++++++++++++++-------------
 arch/x86/kvm/mmu/paging_tmpl.h |  72 +++---
 arch/x86/kvm/mmu/spte.h        |   5 +
 arch/x86/kvm/mmu/tdp_mmu.c     |  23 +-
 arch/x86/kvm/vmx/vmx_ops.h     |   3 +-
 include/linux/kvm_host.h       |   5 +
 6 files changed, 308 insertions(+), 231 deletions(-)

-- 
2.54.0

