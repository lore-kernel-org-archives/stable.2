Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795770834;
	b=P4PgvIAZHdMMlhykPjDq8lLDpISmSozJvnXq5FYH1Jl4xVN8EaNj6HbupcM4Uc0hli/e
	 a9oWBEuHtbjwmPLesY6t/8KbS3Nq4Q5FMK0ZlIgbYaC1Xd6NBM05E0MRU3Q0dyySx3vDQ
	 zEs6kFyBENCuHE4/LkQIQyUqP/oP6KwK55T9RkzKmp8pj8ad7WhZjU+py/4Trquish4sX
	 RQkam8XzEzRHdkOG6kZS9YBOxh6g0SA0hejV5iutOegZnlrOwLcMJbyQRZaN2yLyU0Ov/
	 lvpUo/Th9sAfIvNnbdCX35UH+XVnLQ7XKwZzwBZ8gsqjweKZgVfeAn0N/3dLVD+acvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770834;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
	b=nMR5ogCUxJYEu51P1KtEuTCbNZf1fUffRFQ7dmhtUH9EUQ/nATQgj6yFzZK4jcXCbPnw
	 /wkOcgvSZAUH2s/8pmabG8juJBcQy+2ohSK4nK0LctXdEPuspHPM59DKAgkuWGylU6BI0
	 n75AdOp6AACqRYfg+O4RwQQxm7uwGftgQW4V5S6Qr0incm4T+iQnCPQlLKPCToVpB3A0P
	 tZPCGncnxDwgN6leA2k5i9sUBk2ZPb+WO2BFsfpAcxYHwweji/eeJOJwjLJAFDksP4B2V
	 eLcanqNeJ6xa4aM7n9JOitJ7pqCRiQbtEK7o5DZF0eyC43NhpaFnMtdBggmnXgVdtjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJ9aTNJ;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8857F606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 09:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8857F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mkJ9aTNJ
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4a68190a2a7so6661438f8f.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 01:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795770833; x=1796375633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
        b=mkJ9aTNJ0BoYHPiFyUJ7deP/ehR5ZFMHYEhr6Y1uxGN9DL/TAvf1Wgg5pfJZAQhamg
         Zfp99owmJjBOThHinbfT/rLf9OJfjYLSHj0ml6eCQrEu2DyOHST/AQXwEnjS9Bw9Jhph
         WiggT5e5sutI5LTtyki8TAVxI2FiHoqkoSQQQBfz2AN5IfBpe3WMz/twfn8P6b4cxOki
         noBIoHREG9/SSWUuGFNfIypgViVyejqE2p27AzHcbT+KE03Ps/QEcjdnNIm5p9moxMRS
         FhM/Nw2MirNSrExJjQ9JHb9e3U08/sHEAtFGF0huyA2N6I76UfIFYBndgS99lwHGN0Dw
         nwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795770833; x=1796375633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=v9lbr4TFxiuuucypBBOqCbJsUUDeJTCLXV6XHKdyrTE=;
        b=iP+1xSBDUOixzD9uvX+ym70R64DC27rT5ipQJpDNHfNW2Spk74RBGK/p5SENQZMBpu
         kdMBaDUe/EV8ytjt28SkI3jW0n5LqZt8ObnKoCCzegjgNridsgZ7MOUT/CsEPAcrITif
         FpUOETGBXHCoeIQNHB2rem55dAzPXhJUpuK6tRUgWv9GKNQBpQmd6rSwwWv6uvu/IGo/
         knht6nek0MihbJtshdWQhNP1Pi/k4E0wSc4TzpTwvE7OL7A2Yk4x25Jg5zJVBkfBmdyr
         p9lLdH5z14v4wiKLEgGblhlrDe960HqqKZZsW6V8AQvW8LQvK9TxlQrxHfnCDW6CyhlU
         qA8A==
X-Forwarded-Encrypted: i=1; AL+hErHHHFEEgbiyLYMtWgMK5qO+ygD8CNnLylkL7lELZeLRBuyJMsjQq9bqOpK+RFpXQwdXtCMNA8A=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Po67SPM7dGBT7yPnKvJGgyxazw+bO7LalLE/Yl0EmCZ4zLdp6
	EFKp99uC9MhqVKM1clOr3aF9ECIpX3FzmCh6nPeQJS6RNWKWbnGcmOg5G5H+a666
X-Gm-Gg: AZFdTZcKY9Q14kUq4OPvQVDb62Qz+oTK1TI9E2WiCt9vC+lyfdeKR2C1dQQGJTjxjsa
	AFKLud9vfUutWSHnEzDz/UjPdViXSZOMRRsZidT9jUOANMV/ya7w8o5ln1gRloCEcFPjjBqk8CX
	1vTden95kjRiOlbns8DKcUu9WbOSqJu6qyZg8eJeDP7rYxfSokNQIgG+DhsOL7fW68lT4xqZeDZ
	TndDZZmQZ48v5sWIyMjXUUkYgE50dG3G9wvWS4rhDFLIEIMHSCZoQ5F0kvo1/r0XxMssDdRtKRo
	z+GRv9nIREbpdnginl6usAjf+tofPyi0/8JeE6Dm4N2FtqNpUcat6AThbyBZ8LSlgeUGDZ2iSTF
	mlw2GtuOvzrUP0J9xrwMs+tFwzr/lBksvX9nC0eBDw4LcUbZ9gTgsuR5GVlnDYLAgv7I4BHlW7Z
	QFpoU8L8iDgNVZ83wAmo6MJjsllG/An0pe6Z8UeYryqXysgeijDVS7aiX7FnCSRcHf0sMKvuNOh
	0Qg3IQo/11/+fA5KSCLJQ8AOgcTvPECHg+B2e/yPACKwPwT5S1vYqKzaVvaI8Qh28Q2l/0cnITg
	SmPQhgMbC1eqmRoOhKsUOiFsSHCb55C9y1Y=
X-Received: by 2002:a05:6000:4211:b0:4a6:4862:28fc with SMTP id ffacd0b85a97d-4abaa9764b7mr46243092f8f.7.1795770832771;
        Fri, 27 Nov 2026 01:13:52 -0800 (PST)
Received: from nobara ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4b1ed8b6a05sm26067087f8f.43.2026.11.27.01.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 01:13:52 -0800 (PST)
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
Subject: [PATCH v2 1/3] mm/memory: allocate the deposit page table with NOFS in do_set_pmd()
Date: Fri, 27 Nov 2026 10:12:14 +0100
Message-ID: <20261127091344.113688-2-azpijr@gmail.com>
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

On ppc64 with the hash MMU, do_set_pmd() allocates the page table to
deposit when the caller did not preallocate one. Both callers that let
it allocate hold the folio lock: set_huge_pmd() in khugepaged never
preallocates, and finish_fault() has no preallocated table when the
page table was removed after __do_fault() checked the PMD.

Allocating with __GFP_FS while holding a folio lock can deadlock in
reclaim, for example the memcg reclaim deadlock on cgroup v1 described
in commit 63f3655f9501 ("mm, memcg: fix reclaim deadlock with
writeback").

pte_alloc_one() takes no gfp flags, so allocate the table in a NOFS
scope.

Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_COLLAPSE")
Fixes: 1d65b771bc08 ("mm/khugepaged: retract_page_tables() without mmap or vma lock")
Cc: stable@vger.kernel.org
Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
Changes in v2:
- new, replaces v1 3/4 "mm/memory: never allocate a page table in
  do_set_pmd()" (David)

v1: https://lore.kernel.org/20261125100058.15200-4-azpijr@gmail.com

 mm/memory.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index dfa307a9228c..05d03b32ce52 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5806,9 +5806,17 @@ vm_fault_t do_set_pmd(struct vm_fault *vmf, struct folio *folio, struct page *pa
 	 * related to pte entry. Use the preallocated table for that.
 	 */
 	if (arch_needs_pgtable_deposit() && !vmf->prealloc_pte) {
+		unsigned int nofs_flags;
+
 		if (!may_alloc)
 			return VM_FAULT_FALLBACK;
+		/*
+		 * The folio is locked, and reclaim or compaction with __GFP_FS
+		 * could deadlock on it. pte_alloc_one() takes no gfp flags.
+		 */
+		nofs_flags = memalloc_nofs_save();
 		vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
+		memalloc_nofs_restore(nofs_flags);
 		if (!vmf->prealloc_pte)
 			return VM_FAULT_OOM;
 		pgtable_allocated = true;
-- 
2.56.1

