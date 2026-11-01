Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793552465;
	b=qd6IYnQWZT0E7Qu7tizSUTXekDeMfqpG3RsaABDj7/Mpx0fZnmyns/iLNQACbL/N5sVF
	 GyzXzVz1yeTkeHvtgtlnNpIhiikmu4jP/wKnrUJaiNtdBmPtHTOy9UF7fTkTX9Qgg8ucG
	 qzzt0bwcrF66USMfONJ1+4doxuJRK0zOJNrLJ45r4t3U99lKxQkyq3aRlRxV9u9ZmpZGn
	 GvFImPDmOOjeuwx/VZNjDTLak42ugyffMc5vbvXkWC5P6xyf97wDB7RRyh/CRkXEGG4NV
	 9pgOqip6+cUpvh/6g4o8u1Uuz83+zrMzz7z/ButIa2PEk7NtvjsW2PSMFxRDpV+DHXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793552465;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
	b=Zg2+7ecWPMyNoIqnkZU4ysfOEshCZ5BCE9X6Ks5xX06YVTeMWAhUsAhSx2UHlG70HUMF
	 BMuVkp0ZX54CVN2wYTa2noauYMDqiVbCogiVDmnTKxuQ9Rbt714t6WJ1pUMbygz50TYd/
	 yyDgNV5b5FDwOcX1H/pVtAMER8dBYqMJz93CHBg06NRkzdAiD7f9qyvheulKNBwNP/eZc
	 os2jumD1czvhSoyBaA5BIVJl0HQmLPwsoxXqO9Z7Vf6SEiM4eRDsEpiY1MxJI81uWAeZo
	 Yguu/MPx+5QUt+DKuEeoYeMnmwDNcQLtnNEH9DXKc9Z6WcJZCHSxjOrCA4xeHOfJQng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1TsPBwM;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A35606A324
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 17:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A35606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F1TsPBwM
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae18eb9b69so1327642c88.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 09:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793552464; x=1794157264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
        b=F1TsPBwMoLjgBx5CuDe4M/U6iY84TGXhDM8ujtQ+4MsBnfzmb67AOTiiRi9DcLBoxD
         VzIQ7xBJLUolpKZBW3gzsaA1dOtO4FahVvzIU9PW1nI8MqM8jAN8xHWQMbAjiK1/4Rnu
         POPpuVhrhLvoksaEiEkhCxYqyvh9+8iXxmhY6BkPneTHenqbg1HCFYjF54eArH+HK+mw
         y5IkOonyGBExt2XlJHdeTp8Bkq/R2w59rbVEqiaFxXsVOmS3ZkJO2MvyereEc9OuHdcE
         zlzgK05D3i5izmXqsDBUAOe9+3iCXFLgbqSu2jkilq25RSAggW5yA/W31bsLX9VqbwHw
         Shzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793552464; x=1794157264;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ROsDDi/peHhOy6BynZJX3N2nHlHF3d+geUaRBvCkIfc=;
        b=spRBC1fU9anoDtjSw8ABpQaV06DXbOidmsdHyEQAXv5ZB4RFCm8aEisVJ3ljMFuNb2
         Lh82kWGaMegFIzGlY66f1Tlt21SogJDCQp+CE7KD28uM36hAiEEH9yyF0mGAMox2qe6X
         HYLqMqwFsPwqQ8GZNrfo9vXBovqJaJvcu/PX1Fhy7VaqHB7Wmos67lZtMPP00+JogOqE
         M80hj24bo88imES21oqfDZLsaDMjM4xN0WLNivqWf+DnZf+tT30mzcK0GdKqcA/j476j
         wDi5ETFJkL5UjPjZNNVcX4Zzpj6lzW6VM7m8hdMSgc3OKlUsBnfotdQXIapbnh+THqXc
         cOjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSsMEXiNmS+kJlEKj48fDH9hPvmcAjzkC3qlB/0KwROqZ4GvNyI/MHQ0ks34Z1XYm/f4XoD6Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYImeMyEziA2YWzSnuVlYOvjncA+xJucmH5hDhxXrsdwTuec93vK
	A9aKkKG7Htqrm+GcoLIYzg6zP8aJC/L3LVO+fqsTE6gKngQMS0zaWV0G
X-Gm-Gg: AYBFou1qn9n2h4rCeg9LOnHrHlnd0YyVp1kFoMVStATAFKo2JxwxKL6OXyPaQm8hsAw
	oRU2lJvOaSRG4NLKVB29zBKn8tmCfK+AgPnJkBEcWS2qD/oOZyvtXN7iUG4iKhlIy0JJcsUtDd0
	9UVVFu7omIO/js5TTx4x2ZUCGLomt3VnAug7gYY5XF8hXQYe15bIpgmA98ErQfh1nwFrevDKIcI
	bToDYy90HYuOCElqvkuzyGqb1BdwXdH28W0vhY0ya4oHXvq3G2G27KbI0NdzUaY1bgjAd8jmwpE
	k5ysAiSbUgLzqrlJDTUf6Zr0jD0LJXB7eOQba5NUKOXct/lniZOnpaTYq/Cd1QaKdqPadgwSqNr
	k3Fnv03IK4LR0Dyntw8lO09Jzq5mCvcYKbmENXm6d/Dmgd72vK7XYEH7Ucp3BGbfXcUsIBftgCF
	IUzfh7aTi+MK5+y0NE5s+StE3oX4Z5CRSQlPLIZsom32l09iKWSvGzr+4cjXUkvPdZnVksyee6m
	wyQF/3DBfy7dvkGULaNW0CWeRh2TxAssmL1piiVzybLTJABaq6tX2syeNLh6pI7uH61qkhu9+Ur
	6nT6EwEkmfpshzbVQAwGIY0UKE2vmuBvouURQSwYaABiRNRqHbpIaOSP
X-Received: by 2002:a05:7022:f50a:b0:144:eb46:be0 with SMTP id a92af1059eb24-1ac5cb19684mr9393895c88.13.1793552463413;
        Sun, 01 Nov 2026 09:01:03 -0800 (PST)
Received: from [127.0.1.1] ([2601:647:4184:b3f0:b5a0:ac44:5583:ef02])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac18458e07sm25456350c88.8.2026.11.01.09.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 09:01:02 -0800 (PST)
From: Kelvin Zhang <zhangxp1998@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org
Cc: Kelvin Zhang <zhangxp1998@gmail.com>,
	David Hildenbrand <david@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Kalesh Singh <kaleshsingh@google.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] fs/proc/task_mmu: check THP exclusivity for each subpage
Date: Sun,  1 Nov 2026 09:01:00 -0800
Message-ID: <4c1b393a4b04bd94e4f1c7879ae04e1793eb0931.1793552446.git.zhangxp1998@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A PMD-mapped THP can contain subpages with different mapcounts. For
example, after fork(), the child can unmap only part of the THP. The
parent retains its PMD mapping, while the remaining child mappings
are PTE mappings.

pagemap_pmd_range_thp() passes the same initial page to
__folio_page_mapped_exclusively() for every pagemap entry. With
CONFIG_PAGE_MAPCOUNT=y, this applies the first subpage's exclusivity
to all entries, falsely setting or clearing PM_MMAP_EXCLUSIVE for
subpages with different sharing.

Pass page + idx to check the subpage corresponding to each entry, as
was done before converting to __folio_page_mapped_exclusively(). The
index already accounts for reads starting partway through the PMD.
The conservative whole-folio check without CONFIG_PAGE_MAPCOUNT is
unchanged.

Fixes: eb16876971ea ("fs/proc/task_mmu: remove per-page mapcount dependency for PM_MMAP_EXCLUSIVE (CONFIG_NO_PAGE_MAPCOUNT)")
Cc: stable@vger.kernel.org # 6.15+
Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>
---
Tested on x86-64 under QEMU/KVM with CONFIG_TRANSPARENT_HUGEPAGE=y
and CONFIG_PAGE_MAPCOUNT=y, using the same test binary before and after
this change. After fork(), the child unmaps the first, second, middle,
or last 4 KiB subpage, while the parent retains a PMD mapping. Both
bulk pagemap reads and reads starting inside the PMD are checked.

Across three repetitions (12 cases), the unmodified kernel fails 24 of
84 assertions; with this change all 84 pass. Fully private and fully
shared PMD controls pass before and after the fix.

 fs/proc/task_mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index b87d3e86442d..da4319d972e4 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -2038,7 +2038,7 @@ static int pagemap_pmd_range_thp(pmd_t *pmdp, unsigned long addr,
 		pagemap_entry_t pme;
 
 		if (folio && (flags & PM_PRESENT) &&
-		    __folio_page_mapped_exclusively(folio, page))
+		    __folio_page_mapped_exclusively(folio, page + idx))
 			cur_flags |= PM_MMAP_EXCLUSIVE;
 
 		pme = make_pme(frame, cur_flags);

base-commit: 64703f0fee7421f0ddfcbd8ee1bfa53b25ffc4ca
-- 
2.53.0

