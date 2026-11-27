Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770842;
	b=B4BVjcxN+6MblxJ3ihg/iPVrs6ncNd6HeYjdIWBPHLUPOExjsXzYE4LTBAouceXGrIoz
	 sn/H18EJs5lGkzjfKShj5PA5mavY/S1lvOlHz8iFpVacWcMTjG4QeoH68+QsbeSZoqE8X
	 zOVUcEiAYpwid1AaWYrlRxCs68+rKQf/QOJBDvXxb/jIirCu7r0exUs7W3jPtKbfqFZGH
	 sS6y0PuxJhcz1ahED0ZVgS5etn93mkwDCIn6TCiLEz+lvEHHQgCcRpBZML8VkuuH0xeae
	 fdr4GNcsTRXF4MnsM8fqnnqARaBcD2vH15Q4XnLrEa8gRWTNZgiVxWRyQXEkWZMUsDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770842;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
	b=oJR1X1SPfOIZ5hCT9S94+GoEZRoJ/kWPaV3IS6BydUWDSrAbo9gjrZbKbnmPUGlfbOiH
	 4bqdfLEqJWUkzLvGmuAETAKHMaxUurabXZ6iHYY8AVNLojFY0S4vmrD8kzHz/vQz21aYT
	 fYmMaRwqtFw/BUNu5KAh3hgz0lEQkOlz6gluLqnW0h3fQPOxxMtngsCWbSgQQZcCgxVUo
	 GAXmXba8W4F7w1zzbye1XFosMjKvnC0BlwdWcp+Fi2X5tH5crTi1nTyY2cYGiKuJhV8xK
	 ZDwjpHyJNBrtPGh0GWgOFgy3oQ6RNn//COYjzQHcXi64t79Pabqr5Uoq+/crXyEfa2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfxsMBdy;
	arc=none smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F2606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 307F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfxsMBdy
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c5118deebcfso1169959966b.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770840; x=1796375640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
        b=HfxsMBdy4mrgWCcKqetQG/kIRtdA9cbqj5a3Sz06/WOdhPJpjdWqsxWbcDEUCMIath
         1XRerBbusZo3mRQ+iVvG4DRY2fOtgumpQmF9W76P8onXqeGmUksb4dKXgUf6PcUukK10
         WVuWqITSBIMNAOaDqcSfZ6WYDuIbv3j2L/4hpqmNxnxxyvJ6AMgygXKPafUrN/7paQXw
         gju4o4YsghpaJ2xdrJ5chVYhlWJgMzzYYJ1LUGRN0x8Jhts2MyJz1C6DTKAv26FMsEkD
         KnTP5+J/gr3sb0TVJ9T6iIiP3AidVcNYLZpMl6VGX4Pkocr2gmiQ+8iHtpgV8tFxcPDH
         qZQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770840; x=1796375640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2kjuxamo+ARDPfXgOKJZvTzyyERo8tzr4IQwkyrTwCo=;
        b=YEsL2IJxlpAcUCbYheB7nE6tDgWg1JJ8yjaYjpQfzOZw+HWufAc4QSJCrBX1SaMrN+
         8p+yyaGKaj7QVqDWb7Y/wIZAfWFB2941E2lT0pKlyyEil/RCQdo1sp+0JYJlRRfOTorg
         J59wUU3fEUGWWNFbSZFNgO+SWBBEVkEGWN6WOV4wK6eTD60tBCPnUs/BxykXxcf0NbiF
         7cPYsgANg0JuiQodC6ELk4deXxKLTaCIaGCTp69z9p60+Y6EWzGa4cTksAdJXjKgd8cA
         jNLtLZUMSRZHn50FR7e+rO2b/38Cn4H5eoproP2Ncrer6cFDckqwEizfoBjwqjWFQ4c4
         9A0g==
X-Forwarded-Encrypted: i=1; AL+hErHz61GVweykAPJqHHd8mQLLubs0qCoz6KJn/pNJCc6LaOIHy63q/gyMyJCUX9XeMfxNkBmphYw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NtJtisEaM8qK4qJQvA6AmeGtQZMf+F3RS5AuJdxw/lY2Ms2jc
	2a7g1nQ1NRnZDM8ehcgySQAfjYSQeHFyfkQleOGvQRrgpCE66P9ZQ8Kv
X-Gm-Gg: AZFdTZdgRmkJDvc0vmgr0aN3+tkQl/hR7YuTLDnMYW14gfECztjNvCbpzeEcsY0AkwO
	dzyj7DEjaN4vtXwR9Fd7LGyRF68p9UhBgNcjJRK1pDzpQUWyjYgZGgvAQNowUGIxqfLU+w9WTvC
	5xkg7+hl5IHwqVGMxJWjbxLwuVXGHveq6u+92drCRqmXiAdYl6oACbLy4r6cmJtJSmqJaCGF4HK
	On3+be9eCJSZeVMw9qWq6M/3bHLb20VZgiok2Eals1Jtb28U1jopZJSNOGSostg/+KaNCR5uVhq
	zS4x6SbPGbWKHtT4lO4X7SbU+wek8Wl3Rdfewc3RaDx1gL/UqIv6UilaShlIcwy3w7G6nxETN0v
	Uoy2xSvVW6GHGAPnkSqnmfewk2qTWKcksgKTyzOuJqMpifiuKbjeUVTxnU8GXOcp2SKDpHV76fx
	345zn/P+T7a26WRZSYJrpjGAeClpxRJs8Zep8dieKEQzOfKFx2ZRDZvS84VFxx6fRalgw2zbN/B
	IkDtmT0pUVZDwey/G0+5zM3wf+sPndzxP7HumDzb8//JC6sNTgcMflcPQubmtOrYPYHwmxIJwPY
	w377XVpSSdR9jA==
X-Received: by 2002:a17:906:f5a5:b0:c36:7579:fe6d with SMTP id a640c23a62f3a-c513a88a87cmr2056869566b.11.1795770840460;
        Fri, 27 Nov 2026 01:14:00 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:14:00 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Hugh Dickins <hughd@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Kiryl Shutsemau <kas@kernel.org>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	linux-mm@kvack.org,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm/memory: don't allocate in finish_fault() with the folio locked
Date: Fri, 27 Nov 2026 10:12:16 +0100
Message-ID: <20261127091344.113688-4-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127091344.113688-1-azpijr@gmail.com>
References: <20261127091344.113688-1-azpijr@gmail.com>
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

__do_fault() preallocates a page table only when the PMD is empty, so
that finish_fault() does not have to allocate one with the folio locked.

Since retract_page_tables() no longer takes the mmap and VMA locks, the
page table can be removed while the fault waits in ->fault().
finish_fault() then finds an empty PMD without a preallocated table, and
calls pte_alloc() with the folio locked.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

If the folio can't be mapped with a PMD, return VM_FAULT_NOPAGE instead,
as we already do when pte_offset_map_lock() fails. The retried fault
preallocates the page table before locking the folio.

Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- return VM_FAULT_NOPAGE after trying do_set_pmd() (David)
- drop the ppc64 sentence, do_set_pmd() is handled on its own now

v1: https://lore.kernel.org/20261125100058.15200-3-azpijr@gmail.com

 mm/memory.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 05d03b32ce52..dd0cb09ba7ef 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -6000,10 +6000,14 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		/*
+		 * The page table was removed after __do_fault() found it, so
+		 * nothing was preallocated. Allocating with the folio locked
+		 * can deadlock in reclaim, so retry the fault instead.
+		 */
+		if (!vmf->prealloc_pte)
+			return VM_FAULT_NOPAGE;
+		pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
 	}
 
 	nr_pages = folio_nr_pages(folio);
-- 
2.56.1

