Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005873E4111
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444640; cv=none; b=pVD8mHsGgl0iFjkk0123Xv+wkrZ7BpX+U2YIBNdAktMMcTPmF5kv5t4o2zACBW2X7J3pfLe93wo9aQ+JaSbA2TADuZl9HVMRhf+CYkJXJV5NUlgCwEL0M3wLEv5Ryq7Zw0TDXRWbFKm1r5x9iy/Hm9GN1Lttg91rEsKJnIxmOMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444640; c=relaxed/simple;
	bh=ZRj8nD6TnoWrdtQ47lJkomVWahJQ80S25nasHm2yrb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aZNBTTnkn7OoxYX+nAyIbVT7Shiabh5Cfb4wBwwBVDZ8clmgcrW5vljmkceGDXor5URHDNcTpH5h4Q0vTylX+rXc/LqIy22kvTrENnPQ0sqsn3ACFjxNA4+qS6v/pC7augF9lkAiZ3n3ZcPNnIakVmq8/B37gpSavp5AKo1uvRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jSw8KpxI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jSw8KpxI"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3a89d1ca907so1600122a91.3
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791444633; x=1792049433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8u18xg6N9qLEr1Kj9955ylpG90sgpgszfVpX4EGLse4=;
        b=jSw8KpxImUoG1miIDYwfTkB0Hm4Agpok7jWGb37JH9DN/wK/lBNfgmAY4evhlr7aN2
         VFgMUZnOSwA2avdGZ87X36SYt5KD+HNNdhQE1Q1kPlfPyvcPzotmd+BGvKs2XhtgQafT
         y1nqKd2doHI3exzsIxydtLuAKdd1DfaAlCNNNr01BjRoZpCxE3VIGQS/u1LEMpU/P+Mf
         AV3tCI51Tc9e/5r/Shejh8yVaLFzUCzjf1GM8xHJDzEr2r7y0wxEBmemo52fpOvOFn+p
         pM5qPjBdAGMTYnR46JY41bg2MmnkEjp/+ZqBmoaInRe+VUo/sO4hOt9uoMrlv05XuT8O
         BFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444633; x=1792049433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8u18xg6N9qLEr1Kj9955ylpG90sgpgszfVpX4EGLse4=;
        b=pPJta4YQomVDPMN9K+gUs7aDMaRvn6hWiwonEjbgeCOwa1rfs8JyMLIJi3YIIe0GPL
         XUaAD8SF8e0ZvvEKOjb+05qWz/Ik1RtGH0QoiX1cRWkQvcB/vzoQzfQJDwjkaa2iX5pg
         JIAi8xThN80PhOOf/vH4uKkLdhG6Zx8Mr/4ou/SIVV+NTeMbCh0otkmVvzOVRlV7kzOv
         PNCKhSTN+z+9DgusaKsp7JX4ms/IXnAKmghb95ntSUZ7Mr6ulCUxSIQSCiWw/vdoGWS6
         yHrI0Vu/T+/2G6hCnf1lJtOplLTqh3ZOtxhBpahvLkfK6zA8BTXbzQdAcwiSWRKqb9tw
         gYlA==
X-Forwarded-Encrypted: i=1; AKwUvBwPqmhLkRQnL2N9Pvr/km1jLOyHbQN/NNjBaQjagkrTTcie4ALwu2OSuyh8UU5lCAm+OcCpOWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJN0CeXhfh3bSdkRQcb6BbbpKRVVOwNvX+jKGht9WFsSWXFHKkz
	gqBC7vSmQ2DAmR6Xs5C7RTxMv1d+fuer77B4Ivppkhud9YW0OXGHf+aFju3EyMbAdxM=
X-Gm-Gg: AYBFou1zN/EeJzf7YOLX9965ktXN0XUUv00cBJpYoBU9WYN1rKIl0qP4XKIPu2wL26r
	7hw30mIEYcg/p3rohNEXc6vXqFLDKQWx0ws5bSc+ERitfAukq7xwpD5enmHHUfGwWrARBQwURlB
	oRLe5xvMgYjBXLHaMAlGk6sNMU32kjmurua1xmqgDDgML0bQUgrdP6QSPBE74fczlBRmww59ad4
	joNXOm52p5R6fQTTfQa4nYFJ7R+Q6TTPfu03ieD9AyEO9OSlNKPC23xzLCQQ/QSTwLVdpNnQ6C6
	4bCT/YwsH1W+JR1FjIfze8RC77ZEy6I9QM7U/qgjdTjy2ZGwCJRzeLyut0PSe25l4d6zveMlDD+
	PZZ7gR3P4V5LqRac/mF81xJTJdKCNq32KvVVmGuaJC21ou732cmKlqScRRjS8IuK8vXEec22H+1
	2V9KoAeYG06PIhqWFZb6IcVFcopkGesfd/NjehgK2wRdTsku6uKudxWtTcQ9vOXLtjHhXp6kqbM
	NpzqEETwaCZUh9/M88=
X-Received: by 2002:a17:90b:3ec9:b0:3a0:9aa4:f9bf with SMTP id 98e67ed59e1d1-3a8a072a971mr4136690a91.12.1791444632841;
        Thu, 08 Oct 2026 00:30:32 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a8a438f25dsm3114715a91.2.2026.10.08.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:30:32 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	stable@vger.kernel.org,
	david@kernel.org,
	osalvador@suse.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	peterz@infradead.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	hpa@zytor.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	linux-arm-kernel@lists.infradead.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	bjorn@rivosinc.com,
	apopple@nvidia.com,
	linux-kernel@vger.kernel.org,
	muchun.song@linux.dev
Subject: [PATCH 0/4] mm: Fix page-table teardown during memory hot-remove
Date: Thu,  8 Oct 2026 15:30:17 +0800
Message-ID: <20261008073021.2512665-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory hot-remove can free page tables allocated through different
paths. Some of these paths run page-table constructors, while others,
including generic sparse-vmemmap population, do not. The teardown
paths on x86, RISC-V and arm64 do not consistently handle this
distinction, leaving constructors and destructors unbalanced and
corrupting NR_PAGETABLE accounting.

On x86, the destructor is missing for vmemmap PTE tables allocated by
HugeTLB vmemmap optimization. RISC-V also misses the destructor for
constructed PUD tables. Conversely, arm64 and RISC-V can run
destructors on vmemmap tables that were never constructed.

This series uses PageTable() to determine whether a destructor is
needed before freeing a page-table page. The RISC-V fixes share a
common freeing helper across PTE, PMD and PUD teardown.

This series is limited to bug fixes for the existing teardown paths.
A follow-up series will convert runtime vmemmap page-table allocation
to the generic page-table allocation helpers, ensuring that these
tables run the corresponding constructors. Once these tables follow
the normal constructor and destructor lifecycle, the PageTable()
checks in the arm64 and RISC-V teardown paths can be removed.

Muchun Song (4):
  x86/mm: fix missing pgtable destructor for vmemmap tables
  riscv/mm: fix hotplug page-table destructor handling
  riscv/mm: fix missing destructor for hotplug PUD tables
  arm64/mm: fix destructor for unconstructed hotplug page tables

 arch/arm64/mm/mmu.c   |  3 ++-
 arch/riscv/mm/init.c  | 34 +++++++++++++++-------------------
 arch/x86/mm/init_64.c |  2 ++
 3 files changed, 19 insertions(+), 20 deletions(-)


base-commit: a92f009ac1c21986ff1ea0706419e545a4739513
-- 
2.54.0

