Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793255779;
	b=Yqyck1t8rGMZA8R9+KOdVIcUn80rEaTpG5lFeu/JNbSTeU6J1Ese0wlOvmSO/MXw4z3s
	 nyMRUthDuo+yTI+1cHXSoOZX9QfdZnDEtCXJXVGuMAAT6xaH9uYmgaWOX5WZ9wD9nv1oZ
	 /PNJdmy0s2hTernDyKsSLeraXnWApYxxR3UUJcfwqQgt1iWTqFRz8jxXR8o8SWVReAnTo
	 wtvG1zUIE1BgGGj2LPEOPYGYQ8VTE7lkL7N9lM9VfhMs76oED9hogYUwt4sELpyapuu2O
	 Pz32bZ28x8/W1kO/apc/kdjBVkP5wIkD0S6X3bRf28qL3Eff79+pTD12n26sFyQXygg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793255779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
	b=TgYodwzjfg5GjE6lgT4ocCkdS5ujYc9IwWlkbaw+ct+dcmNrLwMcGE2lMtVEjhgupPfq
	 J7EV2UYqJsHG5YXLP0J8wapH3csm4zMHCpF+oYY+u9Lv2k7oHjiumOq4RupPKLNGEmKnm
	 UG1vcWHvNljfdtLCPHHPWyWFWpJBlsyepyd4zGPiPl9XFmGRquj7A3WK4TqD/uP47CG1I
	 y6q7IFLPbEsSL9G1nQy5KSI7LvDEaKUovWcjy8t3StDYSuPfnVp7Q6pE/mqSRqW3TsPk2
	 TwKx7Hwq5REze3cjWpHXfI137NFtmCBgRvrQzdkPy+BWa6pPwBMhtqUsHfytyFHR1Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DqSnp94D;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19DB606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 06:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D19DB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DqSnp94D
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ad2b3b1c02so961082a91.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 23:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793255777; x=1793860577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
        b=DqSnp94DKFGisKiyfDxktRIL0uOk8pII54N3dJQrdA+C0xNFCpfSAnhpA98Oo91Bxb
         PMFkzFVPNRZMeA6tXyRo3VIQ5ejxwilSijkz6w8oL5Pv6yZsptAGEeopd+hzbSb6l3aM
         6B/LQ63bWAmMJz6ZegouGmXUz3JEqAsIfxApsfDX8llVl9vX4ifac0klZto8XQ/HOAu/
         jPo7ykV2dITBiV7C/MAte4aS7esRjMX8MGlY3xGCtVeZ4CffHlce2cwkWjMaFkk+8cm+
         qvEa4IHQKUtk8CGcfHtqqmTatj/1zb0NwS1winhswZFlS9urMP5/ekl9y4eF9iF8uduL
         zdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793255777; x=1793860577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BTXYfxfVOBhpvhPnAVq2lfmYKNgysPKxlm4ckRVwZ/U=;
        b=M07mLqsg6nUjn76tX7avcMe40lWF/AoSWLgOLo5oiDKw2n6qBlIIp/4Yu/XMMfqrYQ
         QS3NUgOzQuLH5hufAybZRAGf6P7bELilLsdT8tsPxdjqBCksOUv5CqE3JTmv46L8RoIo
         OnR0JouJlowDtsXguTxsqQeeh7eSUjb8GvHyZsSCJkDPxAOqwx2LqRbv1xn1GI0wGArd
         4Z1CDs/+2JW/xDpmLdyHkUtjKHHEmo0T7JsOfOKPPHXP6zhDVuhnPmXgPZCLISK7XclE
         pTm6/9l4+kWOotTMC4ZwxzW4ulI1yvzRIwgLWl3Y0RtYm+1EgiJ4Lbn98sA3NG2ouruc
         MpOQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2VpRnhrmBuYkwk1QEtKACAT1z5vhZqUjacrWyPF83NjyDJ0xwGbku06OjXDD+5OxH6jK+mdA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLcsCAS5wn53QvVZB0F037oq4PorZ+HYeeCmrEuL8reuC9+2WW1
	gS2cHvzaY9V+1rA5iMzMNr7kARBP1QbrXOV5qgYDflnvJg2fG1ezNZHzsO9e/M6YAKA=
X-Gm-Gg: AYBFou0ISjtHmZS4eb//1iIUdB5BDQmT2aflkW28NsKGMWRN9B+4Zg4KChFFX5Y5lWW
	KYT76/WG+S8EhdjozXKcyyp3NAClcuvHQyuVlxLoFbR+s/I2BC6D+/eTJI2mrubQM0D/pN5v+2r
	4FpKzUPkNuIIZDFDhvwfKhWdqtU3sF8GastX1vlgCej6+u5fUVXI3PPJIz3ekdohnKgDdWAP4O5
	qq8vbprOPIMj4YL7cLOaKbmpJMbuigWmf+GErHk+kPuOuFOL7K0tlbSIXNMuQ7gVhghRfO5nFyy
	FApY73D15cBNHRAbbhv+WmwwR+iTkLexgVIcq0tGfskKyuRM1z/0Wv+mDCURjHUma0Pl/aRalQv
	fxHq0rKLjdkMYlFbRcv1F6483C1KzAs02nzXhAEQGiBbDc2hMVY4b9fUGSxEniI0jowa+bkGPE2
	QRbzV1kENkWScJmiaCEJOEasmllaz8WmgXnuONlT8aQ5UzyzjUY2viGu8rkllDx/7umY0Fk/4C0
	gN/NYi91ap7t+s5uua5gjaHbQOpTNVUfUIsL9B376H9uvPkbCQaceGJ+Rd4xFXMl8FdTwBx5qC/
	5FhAN87zWjK79rSFvBMfT8PaEa3aIzWrdbxpoReX3TvFjaB1RQ==
X-Received: by 2002:a17:90b:4d10:b0:3ab:e588:c275 with SMTP id 98e67ed59e1d1-3ae57f9ae1emr3026634a91.20.1793255777049;
        Wed, 28 Oct 2026 23:36:17 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e2a703esm2734757a91.0.2026.10.28.23.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 23:36:16 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Ritesh Harjani <ritesh.list@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Pavithra <pavrampu@linux.ibm.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] powerpc/mm: fix uninitialized ZONE_DEVICE struct pages with PMDs
Date: Thu, 29 Oct 2026 14:36:01 +0800
Message-ID: <20261029063601.1961415-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PowerPC radix vmemmap population can reuse an existing PMD mapping while
populating a device DAX range whose section is marked as HVO-enabled. The
reused mapping is an ordinary vmemmap mapping: the redundant tail struct
pages are not remapped to the shared tail page.

Leaving the section marked as HVO-enabled makes later ZONE_DEVICE
initialization treat the range as optimized and initialize only the struct
pages that would be backed by a real HVO mapping. The remaining tail struct
pages can then be left uninitialized even though they are still used as
metadata for the device DAX compound page.

This first triggers a zone mismatch warning in __init_single_page(), then
faults while initializing the pageblock flags:

  WARNING: mm/mm_init.c:600 at __init_single_page+0xd0/0xf4
  Call Trace:
    memmap_init_zone_device+0x164/0x430
    memremap_pages+0x43c/0x93c
    devm_memremap_pages+0x3c/0xa4
    dev_dax_probe+0x264/0x3d0
    dax_bus_probe+0x140/0x1c8

  BUG: Kernel NULL pointer dereference on read at 0x00001400
    __set_pfnblock_flags_mask.constprop.0+0x34/0x160
    memmap_init_zone_device+0x358/0x430

On kernels without these initialization-time diagnostics, the
uninitialized metadata remains latent. When userspace later maps and
accesses the affected device DAX range, the kernel operates on those struct
pages and panics at that point instead of during device initialization.

The Fixes target predates the section-based vmemmap optimization
infrastructure, so older kernels do not have section state that can be
marked non-HVO. Backports to such kernels need to handle the PMD-reuse case
in powerpc radix code directly, for example by initializing the tail struct
pages that core ZONE_DEVICE initialization would otherwise skip.

Mark the section as non-HVO when reusing an existing PMD mapping, so the
section's HVO state matches the actual vmemmap layout and all required
struct pages are initialized.

Fixes: f2b79c0d7968 ("powerpc/book3s64/radix: add support for vmemmap optimization for radix")
Cc: stable@vger.kernel.org
Reported-by: Pavithra <pavrampu@linux.ibm.com>
Closes: https://lore.kernel.org/r/97f85592bb78a273be8519e6897e7f9b9bd31469.1793070429.git.ritesh.list@gmail.com
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 arch/powerpc/mm/book3s64/radix_pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s64/radix_pgtable.c b/arch/powerpc/mm/book3s64/radix_pgtable.c
index 44868b62b14e..4f75f10ed68f 100644
--- a/arch/powerpc/mm/book3s64/radix_pgtable.c
+++ b/arch/powerpc/mm/book3s64/radix_pgtable.c
@@ -1261,7 +1261,16 @@ int __meminit vmemmap_populate_compound_pages(unsigned long start_pfn,
 			return -ENOMEM;
 
 		if (pmd_leaf(READ_ONCE(*pmd))) {
-			/* existing huge mapping. Skip the range */
+			unsigned long addr_pfn = page_to_pfn((struct page *)addr);
+			struct mem_section *ms = __pfn_to_section(addr_pfn);
+
+			/*
+			 * Existing PMD mappings can cover the edges of a valid
+			 * HVO populate range. They are ordinary vmemmap mappings,
+			 * so the current section must not be treated as HVO-backed
+			 * when its struct pages are initialized later.
+			 */
+			section_set_compound_order(ms, 0);
 			next = pmd_addr_end(addr, end);
 			continue;
 		}

base-commit: d865f2677c44cb2171b833d6775cf692756fa8be
-- 
2.54.0

