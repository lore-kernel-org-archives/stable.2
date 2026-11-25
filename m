Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795600873;
	b=3Ny+NySuOQW82aD/73WGvTHPKX/Fi1iqzJFfWIlkHoMS3IdQLYGUMF3ZHLm4rQygWPLm
	 DHXQQUa7INiJDMpV87fYaSDLHDzmlkiUJ+GzPrfZt+Zai1fadS/j2dpdkBDGLPEGh7u8i
	 CATjNqcSNiSpoiE2S2c2N8hs6jx8Q5hmaO10kvYgyAvUKrJpBu6DBQMKiQdTYtQG2j4L9
	 nWODJHpnoHCg/1B7AC+ZV3J261a7o2BEpLTfhMab2LzRCHJGpADXfvoZRokSD0RphDdCS
	 qfV/GGER7xm364QgrPRzi690z7WK18pIC9gxHeegJxS3NZTKjtVQj8WRRE+nuoVcSVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795600873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
	b=37PU3D/bV5BtQECAzpL1zvqqEsSI+D0FsHPZysETub3NDYOYgMYGLlhXlYi8/MLjxPsr
	 eCJEWJy8KXNCKGE9y/614bLwSpMsmrioQTRzQ7DUM0dQkM0w9AOsrS2mOlS9BTK/H39Cs
	 9st8eBhH2c/zXvjp9zVTBKM9AVJMSx4J+Lp7M+Mhtok+IfFM7RvnCNS/EzA94fdKqT0r7
	 AVYx3MBf8ltdlXOlkq9uroodNLxArt7+x6ZqYIeDqpAElx5zV3nvdOYfryoC5+IIVsqN+
	 TDVEJjUuKYZ6Lwr+Ts1qtCI2rxmhP6TiCqdHBIWXcFXInx05wLvhQModRIXtX32x6lQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBmvbaG3;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76CF606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E76CF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zBmvbaG3
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a214c5c4c0so52735535e9.3
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795600871; x=1796205671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
        b=zBmvbaG3szHtUabaAe49M42Bq5WBsRLYqqevp++ZOyEhct1oM8O1qEe38Y+tekT+ei
         WsAuzw3p/vSPvl5n78uZYvnouBt4boT3mWSdinyHtp60gTm4p6WClwwdZpOwD1eXKMZQ
         a/gZThLf8xn0UQ3nq50mJwsBVaFNKm1lYWn+6X5LSshuk/yKklakqPYmCrL7kdqD9VGR
         E7AKnqjoQdYeO4OH8FfZVHVAXzl929rRImQdg73+C3nQQ1Fyv5Bm8pBPm6ZGZTTvnfI1
         zwHsKaYtrwvxdZO9cXsQFsxVanG0xjsMI1yaRaZiitIpnbuthE9Zd9TEnofJ2Yq1+KXi
         xl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795600871; x=1796205671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gIVwXBqoIbWsBwcLK9XzDcXEsdYI5cY24iYHrBHq0Cc=;
        b=w0/gRGCJnu0v7tUrF0y1lcjO/c+xuJWcAHH1AEBW52urvxWUSOyKtVPHub+rFM2xiz
         DFD3ORfYQGOqwGX3TuTalhgzlFcU3owAA/5cqgWgY5oTfRklhl2LBALy4oiku5b159S0
         jun0zTudo0JfspVx1byWPbG0l/FdqHnAUTl70bTHG8AT0C1o+SMJ6aPIehWBcHTL386b
         +qkxO3QnT6lnt56SC5/t7rJz8ciiHEptq9F6LZQ/wr49qlj1YC4c5n94YYPJkQjSqsTb
         NuPhvQ3eUvVclkUCFO3SonfiJLGpt7FtaTg7F67ZLBv5ZjhRKK+qlu98r4DRzgUiMTrQ
         G6hQ==
X-Forwarded-Encrypted: i=1; AL+hErHpbn8PpP0fiLNV2Yuo3g7gt7LxomI1xKeCvIu4lSwwoaHFinc2Uz0mtZZnR4HqaYLef2euRuY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ElzyqvBgfHmCgPOKd9fxEJwMOwm8BCMAJYF9/6XxbrrPA+8gu
	pRl5HikR9/Po60rzdPHY6GUN5817Hc9SwHHFgokox6K+R1b/iuHGvMUT
X-Gm-Gg: AZFdTZey4acPxg1TV7aVhb/drqPl8drN9uu9Qy40ct8CI7BsYG+PnHsLpCyKuSZqokQ
	dTN08asxpfC4gdd2xH9O2sCz6Bn3zOAPXFnE6zKIVTB0VKrsp2aAzR0PJwrDvyKUbKpMLmaGgsb
	M2EXgKW/ir40MwwtV40K+dXsx3yP3BTOsqJUgjjHtUBSgYwuyeoKYIaynlhcw0+vaW3IO8kemCG
	gSTWD3ojxE6ZZKrDSy7rbR88DUYKkiN/9a1Nu5Fez7o7yBIDg8PHcg5pP8dZ000P7rB+Pq6zFrN
	8efOM8vZBgmG9wOBCjob8J30qBfOChAJqsfDN7VOle63STCKRGu4pZ2UAkuqxgLRkqLF3OtBisK
	6zVUEKDAnydv0fOUyCPv9VYhYwHSNJCYQE9joyCSjpW6SLjbQ9erU8UxHnfstmbdcI+kO+eWAIu
	bkixFHJPH1b5FRrb/6VgQh0NtyaPyHBcOoxoOcqlN0UhGd2yiPs5oVShQcYyWRkhFwEZ00S8hGo
	eDV27SjazMXdI60kthzm+V62MYsZ0D55JV2yHfA4miJXne1Qms1lSsYF4AtyFFPFtLPPKLUCCyt
	zeRa6p3c2KJGpA==
X-Received: by 2002:a05:600c:34d0:b0:4bb:6a5a:7839 with SMTP id 5b1f17b1804b1-4bb889428eamr344330925e9.34.1795600870499;
        Wed, 25 Nov 2026 02:01:10 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853a1e8bsm423898125e9.9.2026.11.25.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 02:01:10 -0800 (PST)
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Zi Yan <ziy@nvidia.com>,
	"Zach O'Keefe" <zokeefe@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Hugh Dickins <hughd@google.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Rik van Riel <riel@surriel.com>,
	Song Liu <songliubraving@fb.com>
Cc: "Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Nico Pache <nico.pache@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Usama Arif <usama.arif@linux.dev>,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm/memory: don't allocate in finish_fault() with the folio locked
Date: Wed, 25 Nov 2026 10:59:45 +0100
Message-ID: <20261125100058.15200-3-azpijr@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125100058.15200-1-azpijr@gmail.com>
References: <20261125100058.15200-1-azpijr@gmail.com>
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
calls pte_alloc() with the folio locked. On ppc64 with the hash MMU,
do_set_pmd() allocates the page table to deposit in the same case.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

Return VM_FAULT_NOPAGE instead, as we already do when
pte_offset_map_lock() fails. The retried fault preallocates the page
table before locking the folio.

Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 mm/memory.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 11cc4039b853..b7e53d7cf6e5 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5986,16 +5986,21 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 	}
 
 	if (pmd_none(*vmf->pmd)) {
+		/*
+		 * The page table was removed after __do_fault() found it, so
+		 * nothing was preallocated. Allocating with the folio locked
+		 * can deadlock in reclaim, so retry the fault instead.
+		 */
+		if (!vmf->prealloc_pte)
+			return VM_FAULT_NOPAGE;
+
 		if (!needs_fallback && folio_test_pmd_mappable(folio)) {
 			ret = do_set_pmd(vmf, folio, page, /* may_alloc= */ true);
 			if (ret != VM_FAULT_FALLBACK)
 				return ret;
 		}
 
-		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
-			return VM_FAULT_OOM;
+		pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
 	}
 
 	nr_pages = folio_nr_pages(folio);
-- 
2.56.1

