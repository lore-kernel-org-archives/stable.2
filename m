Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701731;
	b=xNCLDYPpTxSHlK1qLLWrONNqpYPXBWDJoJMgm0EcX8B6lzzaOuF+XcmSAw4p4vhXXYht
	 z5gB6hK39LuLjnYaIK4jfyoXrL0zPm7mP4wfDpIKm8ADj0o/zvj4wSG0QE5/CtN+/+Wab
	 Jjqz0ZaMUfvMr9iwBk7HYqtacQ9ARsNk23ty1kattJ73H/bcg8q8GehKdcNcuGbQA+epV
	 inuaURAsMK0bl6ZPML1Vn37gtryWcJgmDWGIEkITxBqdeHBKADE90TMfyHq4+I23wGNh7
	 PCJYE7mNbuBTqIHL2gfxSlxdv6uxwBBsXifR7EP4kap0rDC6Dux1yE8lOM7F0yPvd6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1bfQdtMJVeOry4zlZR5idJ3ioLg9CkbsmK6ATlbqUPI=;
	b=LQVBqhBcB6hxu54S5x8pAqTJZZ4JKteFWZmxqe9R2C4jCRvOBaMTbCCQ5vPD40OM6GHZ
	 AB6WZO9q7oxd8ThU/Z/Mnv0OF+4f00JHFwGiSrXFyFhJG3BGf2AyqoB0rn0X4a3G1NOQ6
	 I469R86WaQ8lLrD/J7QFrGvjUSUf38JdPQlyHgzcnWGhKn7PEQmQ4Ge5Z+pS0XW8gVFhp
	 nqc65AXmay9aflQqxMaKWuQEeqmZmMN4IJx/m9sFs6cW//OTdek5RxdvGYJ1O3W2UIW7C
	 UGk9BBN0qDQw8emNNk3byGZTJi6rAjNWoaavZ+ZQlvZtv67/XDSFjMihAgDClYlxKCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TODm00G4;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B6C60A380C
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 10:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B6C60A380C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TODm00G4
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48df0fa43c5so331435f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 02:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793701730; x=1794306530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1bfQdtMJVeOry4zlZR5idJ3ioLg9CkbsmK6ATlbqUPI=;
        b=TODm00G4alr+z6BRhGlXx23IP7ZkEySO4RDAWd9wJPUOJdQ+5XL5h85th+krrWPMG2
         IkZxdhEE7wtgBbVPP0IHNFQyOYyhKyebMse9y0a1NjBxsQ+h6DcNpx0rUEC3mQ+m3uKh
         2sDD9kRVd3Qt7T7N13G2/je82bUBAON4lr4ZPs35pSt5TxPpqDW6MouZB2AzlUE+Falx
         p9zDwTwgNr1OjkKkUu734GIls2xhy091V9lioaaEdan7IG3bULNODc2vQuWWfnhS2a58
         Q7ZG05vb+HVnuynmuork9rlBxM1tzwi6Bf7W1nAuTrrCQdTFzLC1m8Ezql8+Hx6ZZPza
         ZbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793701730; x=1794306530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1bfQdtMJVeOry4zlZR5idJ3ioLg9CkbsmK6ATlbqUPI=;
        b=v0eoklXNmXwimtvdo4gym4bQux7pw7RK0pV8pkUoR6gVqelFkxqwr33MfzwOff6lo8
         bEipLuvIHVyZaBgAklzLQMVeqsuvk+eA+1L1RrzRy8lY3YTBu1SBbTBDOYkQTX6vyGkL
         6NknEWRwYkdAs55wxcZa2Ks0VtWlWAZ89TJbcwp5ta79TnzHWp/g4qnlMl5V3QjhAltH
         Lpl9dv1cl7mHCoCXEa0f08AM81+5FQ3Jik4waFwA/19Eu4GcBPGy8Tdi4o9mPJncAD1S
         MFGSWrZSexWLioy2adnUMdGlAKdsWiTNmONz9RNdwNHZZ3qvUGdhI/sOMh3nS5uEHuW6
         WVyw==
X-Forwarded-Encrypted: i=1; AKwUvBz7avx2hhLy13kJELtEFgIKJGxH3GxSPQPfnTYfr2dZgESXT77Ka30QRheTh03+BcpT2VYdpyY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8y8Gsnst5dVI9LHIW8LI8XVioTOWq5G/cx3wbmMHLgPEpFEZew
	DRoE6Cm/w4Dij+C8rCizpaJsMN33r7NdrSQArx1Rc5pHfi/s7KQhxLhN
X-Gm-Gg: AYBFou2qLQL+JyIhm/9eRUCHljl7w1TjFogneg0gyEZmOqGkbIoB91jYl205VMNiZEu
	Fog2oFkHKKQkpBPtWuHFNH1R+GUiNaC9mGehQjryRzVS6680fdm+E5F+O4KtuYrfvTzMHgLaUXS
	WJXgWoq0Ac7+LEVNAqYF9v51bfWzBtSboIYwivP9YfruXF4t6/aQGrJz64ap8iwLK9C1va7JEMV
	qyRE5tFnCdf51Wg2sXgKZnuldg7pLHmvQDHV5azRi11/ropjpsz4S865zZrSY+Mf1ACSzuzDZHi
	krIxbFeXX1HJifGjg/8/v1br779AYf5c9HkgGHucTvXILnb1RApxebDXIH5NcfhzV2yqujHSXBq
	ABbgUOp5uXiQs5wQFx3eEQPmWQikV11oXPhLbXzNGB/NafmpDyiNTUtu/+imh0yUlvFutRvw2qK
	g9gt2/OHCrKtyeqHV0dCEGuNEX4e0XfsEQAt27v+wkFRCsO80YhD6wMGgbLVMtu3qvnaDELsBIH
	b1QVPxqsRE/W1+eN7MB/zZRS+vOJ62Ll9Og1Cv0jQlWs+xfrx2RXpubSHax7ffN9eujOn1cqZDy
	GX6WNHT6RiQ2aA==
X-Received: by 2002:a05:6000:98b:b0:48e:3484:8af2 with SMTP id ffacd0b85a97d-48e64d10510mr37075329f8f.31.1793701729728;
        Tue, 03 Nov 2026 02:28:49 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7815fsm24941003f8f.22.2026.11.03.02.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 02:28:48 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Peter Xu <peterx@redhat.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/2] mm/userfaultfd: recheck WP registration in the hugetlb UFFDIO_COPY retry
Date: Tue,  3 Nov 2026 11:28:35 +0100
Message-ID: <20261103102840.68903-2-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103102840.68903-1-azpijr@gmail.com>
References: <20261103102840.68903-1-azpijr@gmail.com>
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

mfill_atomic_hugetlb() drops its locks to copy the source page with page
faults enabled and then looks the VMA up again. The retry doesn't check
that the VMA is still registered for WP, so if the range is re-registered
without WP in that window, a UFFDIO_COPY_MODE_WP copy installs a uffd-wp
PTE in a VMA without VM_UFFD_WP.

Recheck VM_UFFD_WP for UFFDIO_COPY_MODE_WP copies after looking the VMA
up again, and fail with -EINVAL if it is gone.

Fixes: 6041c6917903 ("mm/hugetlb: take care of UFFDIO_COPY_MODE_WP")
Cc: stable@vger.kernel.org
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v3:
- none

Changes in v2:
- drop the leftover sentence and the non-hugetlb reference from the
  commit message
- add Mike's Reviewed-by

v2: https://lore.kernel.org/20261102081140.201987-2-azpijr@gmail.com
v1: https://lore.kernel.org/20261029221129.89068-2-azpijr@gmail.com

 mm/userfaultfd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index f33ccedfecd2..6321bb82c1ef 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -810,6 +810,10 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 		if (vma_hpagesize != vma_kernel_pagesize(dst_vma))
 			goto out_unlock_vma;
 
+		/* The range may have been re-registered without WP meanwhile. */
+		if ((flags & MFILL_ATOMIC_WP) && !(dst_vma->vm_flags & VM_UFFD_WP))
+			goto out_unlock_vma;
+
 		/*
 		 * If memory mappings are changing because of non-cooperative
 		 * operation (e.g. mremap) running in parallel, bail out and
-- 
2.56.0

