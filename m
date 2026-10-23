Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737280;
	b=KiIOlCHcYRe5pl4+CgeJ3qfILfVHnHZUqyxoneqOp4ZUxqxkrlfUP3KsalESgyYkCHAC
	 gWwIMIdRDh9RM+WoQoOOMGW76dhKRseQyGR3HIPoAxxw1E5hQlHrQuqiN9Jbc/0BCg83u
	 QlunZ5YHTGmndS/WwKpT4upo4cs0y87d7jEOXbz6GTQifBV87m1cf+CXKYzQu1ALV3XQw
	 CQejP9BUDcEY7/kYs2WbMazJ5ZRyXfcqWNNiRT0Gsy5P9GmJBDDK7/bSoMHsb6OiPQXNn
	 TftH8T0u3C281WOElh1UIDVxQ9tUz2jZ1/OrY/m20f5SbixvZSaqyOvSKiYhJN7bwbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=64tBqhaCstcvhuNkWvz0hImiXE9PsoHY46iN8B5GY0M=;
	b=yUXRwwRemNKguoqeuGObv+TNXKJ0RQ1H5LGii2bYlIpPe+yUNmm3AP31EartohQ3E4/+
	 b9y1hKbJWLMSNABZlaSHPzFkUQKH6edtuD/7Sj4x+s9LGEky3H9x+1U4gTne21R8wXXHq
	 cAxoS5yOD4MlHt/5J4w2CJgsj6G/Tjfj2Gx+ejKqIwti9sUMwWugIWRfqnWMZYCh6VCaV
	 HNR4noIbCzFJNInr7ygliz7/ZHtsewYOGJIWhL4slUY2Y80Ldv0UtImX31AbqPayGo0uH
	 iROs99hukd1b7+O2gpdbqr7upQKol8mKAeFIoiumWMG1HAaJQ1CO8H0+JJv4roqsd1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MGMJ1URh;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E2C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42E2C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=MGMJ1URh
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3adc0fd0299so421400a91.3
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792737279; x=1793342079; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64tBqhaCstcvhuNkWvz0hImiXE9PsoHY46iN8B5GY0M=;
        b=MGMJ1URhE36Rb3NTCa1J3+ZYJjhIYC37rxcwHbjO5PnQbHWUQhymIbCGAMYTkkL3hv
         DM+havcrv+laZL0fcBaGvJymdQJcCvfXv0bjwQoY7s9OJUqAvVROaOkIpg5tW5D+WbWL
         fv+aI2rBq3RfzJ6Og8Q+/hnk7NohvM+e6rwdDOLfN49VnJdZiPjQbeOb+/Rl6nB6+cU1
         v1KidzppSgagVEGr2p4fsm6FqVe1rDDUm218tNCRD8D8A91qR5xy+my11QStoGAAWlGa
         AuoXDH1e5yMlAURQy0B1nxgAcZrPJwOA2xa6iO04O+IfCcPMZ/AwRrna3f+DlgS1g3e+
         RlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737279; x=1793342079;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=64tBqhaCstcvhuNkWvz0hImiXE9PsoHY46iN8B5GY0M=;
        b=O4rdOrUZWFXsJ+E2jE2lE6FmWpitLSrQLXcT5vvZzCzCnpSixCy92gyXzt/5SuD0w7
         8Ed1o4fX4iJQDKtoL3YG46y3tMtfzaropgn879N9Vkv+4gXVKR5YQ0vLm3NMud8SrU0u
         eRLqVlgopw97wqYbyjlVRyQZscy+mc6fQwFaxv6PDN963WqyDyU09ynYLA2/6FWe4jD9
         Fi6GbDkj9ZfVPLg84uTv4lkgdUDUx1e2/WKfZcAFyJ1yICghc2Ovhs1MWxbyTgyLSAr1
         VJMPNoHqgDoXBciDT5hmN2jyMV38YKSxTEw/c2aJxG4uyXAJVZDDQ/6fQQa9njWmQAbD
         dNbA==
X-Forwarded-Encrypted: i=1; AKwUvBydvCcE8MbUaQls6StKM4keorv8ERpaSTH/SRrSVvJcSaGKrxUsBdGdB5LkQugtQaK3WVisvdc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFRlsy1uMCgJFmQ0JJ71HoDOJq3Y8/tzfWHhZD9z6GX/fOVuqW
	3lc27HVBG3te4ESE7IhEtoEmyyw6Nr4E3rIDa88CoGroEEbO4F6Gcjz7iM4w9QJ04iQ=
X-Gm-Gg: AYBFou32/7iRkDtkr5OZF5oKdDWg1Y93hT4+bk/+oxKwoJf/MiWg8GdSZI7ErqK1jcL
	OfOaL5PHdiNK22wPN1qe4dkYUI0PfsXzFrOT4gYThyagDceFbsFjwr0fTB3JkImYetmol35thVz
	/FjFkTCAHorD6G3v/uync6jdswE81zs55DDvOpOpASeGL371CthLwuU8wRiclGBPJOSlKKouYYi
	xadKcjOWXEVhvOQ6zK/iZth6kNQecqgoO7lCOO1+nNmqTc2EUT7HN/srKY5oS/7snZ/yane/7Nb
	k1mma/uZ/OG3PouJQ/tjzT7O7v0/pOaTxXB+v8pMbQFM00qBYWo25ZW6YuW31lJxbXRNB1MwLBQ
	kaZR21YzR5ORW348HTPnKbIkSu9mHrLu8zi3WoQmkKjwMO0UWBlgOg8eCl+Ul3u6ugrL3/DAsbW
	Ljjh6aSH1Sv5arV7PltOu28LMFEJFZLdGMSe/e837FQBQSe2F+zbNz8jYXAg6rNuNSDlP23ZkLq
	22IZ3cufx8ybNZrV2XhNl2Juzm2C3aJ3AIcZiwq/ytZ8+9dcSXpdSYFFRA+xw9NhyA8dIt0AmIi
	UQ==
X-Received: by 2002:a17:90b:1c82:b0:3ac:a7ee:6770 with SMTP id 98e67ed59e1d1-3adce0ccd3dmr1138974a91.7.1792737278490;
        Thu, 22 Oct 2026 23:34:38 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm575202a91.0.2026.10.22.23.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:34:37 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 0/4] mm: Fix page-table teardown during memory hot-remove
Date: Fri, 23 Oct 2026 14:34:24 +0800
Message-ID: <20261023063428.3658761-1-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Memory hot-remove can free page-table pages allocated through paths with
different constructor state. Some paths run the page-table constructor,
while generic sparse-vmemmap population may not. The x86, RISC-V, and
arm64 teardown paths did not handle that distinction consistently,
leaving constructor/destructor accounting unbalanced.

Make pagetable_free() handle any remaining constructor state before
freeing a page-table page. Callers that already ran pagetable_dtor()
have cleared that state, so the destructor is not run twice. The RISC-V
and arm64 fixes then use this common helper for their memory-hot-remove
paths.

The architecture fixes depend on the common MM change in patch 1, so
this remains a single series. I expect it to go through the MM tree,
with review or acks from the relevant architecture maintainers.

v3:
- Explain why pagetable_free() does not run the destructor twice.
- Add the x86 stable prerequisites noted by Jose A. Perez de Azpillaga.
- Collect Acked-by and Reviewed-by tags from reviewers.

v2: https://lore.kernel.org/20261010112457.49485-1-songmuchun@bytedance.com/
- Move the destructor decision from x86 into pagetable_free(), as
  suggested by David Hildenbrand.
- Use pagetable_free() for non-reserved RISC-V page-table pages and
  simplify reserved-page handling.
- Collect David Hildenbrand's Acked-by on the RISC-V PUD fix.
- Use pagetable_free() for arm64 intermediate page-table pages, as
  suggested by David Hildenbrand.
- Trim and update the commit messages, as requested by Dave Hansen.

v1: https://lore.kernel.org/20261008073021.2512665-1-songmuchun@bytedance.com/

Muchun Song (4):
  mm: fix missing page-table destructor in pagetable_free()
  riscv/mm: fix hotplug page-table destructor handling
  riscv/mm: fix missing destructor for hotplug PUD tables
  arm64/mm: fix destructor for unconstructed hotplug page tables

 arch/arm64/mm/mmu.c  |  3 +--
 arch/riscv/mm/init.c | 32 +++++++++++++-------------------
 include/linux/mm.h   | 37 ++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 38 deletions(-)


base-commit: 26d7e34b4226709084461a07bf28d9066fa96d8c
-- 
2.54.0

