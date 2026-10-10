Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE53BCD05
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791631550; cv=none; b=lgUQqM7m+z/mXexcW+6BfsOBt6gNt2PDQQTFbS+DGoyTNJrJUzuu9d/J8eK9TA4n8Gtc10QT6P7nw2ugg2cxJxDBtp638TNc/uvPF9vuW6hwb2UGyNUi0APXZmo0JKJ+uqJbDSabPinbuycaFAo4SrwbCXucdU6ZTkj9emtGADs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791631550; c=relaxed/simple;
	bh=+/svH6Yt3TVOaA2Dmeuofm5tgchOQ23jAXlNQeiT4FY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k1XbuZN3qQuKeqtks3/LtRrzGLh/m+yMDmcEoGBasyriP6TMu5KqGKpDspTGIy4xc9ZnDtPziwWqQC/hFeHVYAMRXpjYT2wCVOMZd7XYbsBAm4UJxMu6kfhTJbbKCoOWK/dhplvG7FB0FlgH1pTFweTVta836Hmo8G6O1mnvYE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fWI2th3d; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fWI2th3d"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc751eddf25so268920a12.3
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 04:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791631549; x=1792236349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P0oeUsShMWj3bJ1nudJ9ra0uDTnpz7SXDogBWHR7tfw=;
        b=fWI2th3du8M4TFaEl4lpph4wdXUkc548S/FUX7h8IdsBmuWKs4DidUE6VV/8kHMCYu
         G2zIL4Q3T+eoi96JrYgyU/liBY8lxqwwSawIofYaoMfRvm6C6c0U0alvDmHNGjfxy7/o
         ol39tNwn/5lmSV6jZnticmPEQFRAFt1AK3K4rkwvoIZhfXhoLr+t4BxyAEHEvZ+Qp+gw
         NA/zlX68ORPL7qlYJSrLr0lXz7T+DgXir+9XYPEauQfkLi6a1fmWafaigMR50tdwj1tu
         2ucfm4K9JUa3yOZcWmKYcqFCsVly8JgtG9emYMROEM+j7mv/Cv+5/8EKqyHh+zTa3o+m
         1i1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791631549; x=1792236349;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P0oeUsShMWj3bJ1nudJ9ra0uDTnpz7SXDogBWHR7tfw=;
        b=WEBCFGNp2IJy3cskBRtB2HLSwnihe9cIogyuEOI3bRZbIKcu2ovSzP6eoGVjFgCgFg
         ZfW13f1dhmkrD4SOrQgw9fAA8ycdcen0A1uNAhLmAbEOttB3NR/U6CRSBtcCYckyag9Y
         J1UVr1FaA/y+RdcHcCCzfcTvp/+H1I881OFR9dcUj/X1ubXyIPf5JMDkbILkX7uv50Tz
         ZFXMkBOuetY1zMgTHzha/U+LhfmCkqMNBPSvHsqW0tnVV/h6dwnO3fImrk0MLmQ3vDaA
         8vdMBhdAQhFEcdhkpSg8vCuj/Vdw3bn1K07pH9rmq/Zl+F2v+lt4h5j1E2Eo22byAkua
         667w==
X-Forwarded-Encrypted: i=1; AKwUvBw3mxUlY+IZR5lMd2SW3aO078YtjFX7voHE9a5BfD7YLZrHX5zoyvxqBiS091uV6L/iLTqH14A=@vger.kernel.org
X-Gm-Message-State: AFq9FYL8DBeBtYSvvPPaNveSgLQgEvDrElJOENkKmwPLofsq5gEigAUA
	u4n0SnAOrEwmGXm8+p+axBEYWQJaoRuFYmuQyx/GdY16M7n6TQRJbjSM/+F0UovizJo=
X-Gm-Gg: AYBFou3lw3+3SvuvCvZWFBgtoiJf9ponTmDSHEiHe610kX04h0Myb37f0vS5vyVcy4r
	ofVGAzS/cz+6m7OCqTp0KvVPx/8M6XXBmFrteDo4vYEN6PLOK0Zao9eNp5qjHQFoMlcsiq+RJfG
	/A+CBWdH/lOaQ5q39S1JHX7bEQFKrK93ZWoB92yxZYxrWzdgqGG9g72VjOU5Nu2qxFx2b0zY1Hk
	QWpcNzxM/cTaKW81o3S6sOIZrPGN1im50bN0y1QaYZc1KZJRXnKGqnzjpqQKl4JOSHYDaW33Eu4
	wbwMn7AHyBgj4B+HIOKfvGUDB1PCmcddluCa4fLq0Fi5HKZPPbHmoXBBS0ht4Er3PBHwt8JJrHj
	WBPGh2WRTBZLInNYVxKeSNDk9a18KEQTu/MxatCKH13inkfqm3nnEh0tbK2rG7nujeDNnrcEZJC
	lpUzP/+OeLieSzAWzI1v09CaEbNtsdKCuYxn0qayjNDf1gDRwyJnA4QHJVa9F/TAjbEOmREmik7
	u4LGTQ7WiZsmdqMTYwYryPG0bniZQqPCcA1rQ==
X-Received: by 2002:a17:90b:3a48:b0:39d:f6a6:60d8 with SMTP id 98e67ed59e1d1-3ab3a33db57mr4120069a91.3.1791631547298;
        Sat, 10 Oct 2026 04:25:47 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm7900233a91.0.2026.10.10.04.25.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 04:25:45 -0700 (PDT)
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
Subject: [PATCH v2 0/4] mm: Fix page-table teardown during memory hot-remove
Date: Sat, 10 Oct 2026 19:24:53 +0800
Message-ID: <20261010112457.49485-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hot-remove can free page-table pages allocated through paths with
different constructor state. Some paths run the page-table constructor,
while generic sparse-vmemmap population may not. The x86, RISC-V, and
arm64 teardown paths did not handle that distinction consistently,
leaving constructor/destructor accounting unbalanced.

Make pagetable_free() test PageTable() and run the destructor only when
the constructor initialized the page. The RISC-V and arm64 fixes then
use this common helper for their memory-hot-remove paths.

The architecture fixes depend on the common MM change in patch 1, so
this remains a single series. I expect it to go through the MM tree,
with review or acks from the relevant architecture maintainers.

Changes since v1:
- Move the destructor decision from x86 into pagetable_free(), as
  suggested by David Hildenbrand.
- Use pagetable_free() for non-reserved RISC-V page-table pages and
  simplify reserved-page handling.
- Collect David Hildenbrand's Acked-by on the RISC-V PUD fix.
- Use pagetable_free() for arm64 intermediate page-table pages, as
  suggested by David Hildenbrand.
- Trim and update the commit messages, as requested by Dave Hansen.

Muchun Song (4):
  mm: fix missing page-table destructor in pagetable_free()
  riscv/mm: fix hotplug page-table destructor handling
  riscv/mm: fix missing destructor for hotplug PUD tables
  arm64/mm: fix destructor for unconstructed hotplug page tables

 arch/arm64/mm/mmu.c  |  3 +--
 arch/riscv/mm/init.c | 32 +++++++++++++-------------------
 include/linux/mm.h   | 37 ++++++++++++++++++++-----------------
 3 files changed, 34 insertions(+), 38 deletions(-)


base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
-- 
2.54.0

