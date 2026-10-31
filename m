Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793421257;
	b=I1i6wVNT7i3HXAIyjWsbBJ4asoZOHm4q4XQzrrVLtPxEnfPRZPF0Vcsym0d79tpG+Ark
	 kNiTMbH4v9PvMz9cEZ+CaPVpWcbkv3CY0ky3ObS40E9Tfchxa+GvG4cpi7IlcIUUvPblV
	 yM5dYoGrWcP7iy1UObFnqdoQGgSQwv+JZGsI4JTb0SgNfvyELDdPso1nkSKA5rhVcvIjS
	 X/8MI/mB+rztBVpa3H/NV3lwnul6acSewbK20OeRwgRq0nfHRxjCkmoJBsYPGk2kw5rFF
	 D0UXjbVxXJ3YlpbFrCrHKkuuSMRQK88i4I9WQ+xVNEiG6qwYNB1n3GfgiyK1mfV/dYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793421257;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 X-B4-Tracking:X-Change-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=Flx6BFpBHU/1mQwNgXF0H0qYyTFKKY1odWtVjJY4UAU=;
	b=Fv5ylZ0FPsHoSGSPKlPoEAIiRonrCQxYA5GcjA0wOBh6XxSbCa8gpl+BR6kPHZJpTS+Z
	 0Dyh1obc9vrolNKkuOnepN3KUTJdZSc0epHCvQFgaBfALzOX09mUuhgNodS/ZUNclNxGf
	 fvEK4S/CFP3AQbgisE4lSGLlDeJrJ88MkpeZHq7ejRNeomULz6Ui134O55LlklHNXkVTJ
	 6uSxULMkG4/v5hV3kHwsuBgdNBiKKrqE4nT4x5bhicGCMizfpk7tZb3i3vSRYkUOawO0b
	 hGm8FCbdslyOnDMt7Dl/G5ou2N8l521Lm3Sir+bicTRuzhzHqD2Jb0DkgTFT+6MageA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=obcdZO7I;
	arc=none smtp.remote-ip=91.218.175.59
Received: from mta0.migadu.com (out-59.mta0.migadu.com [91.218.175.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B645606A31D
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 04:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B645606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=obcdZO7I
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sRRglwrZgXV0SrK/OtUomTWdFA+5PNai7nUeEM2ufrs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793421248; v=1; x=1794026048;
 b=obcdZO7INN1kPM1v5GvlYd70X42q221riOIqjegL1GE8Y3xl3zxAacC/Om/Vt4G8sfHmhE4V
 lrkL01cLaRw/2ZGemRxFlg1/kqalN891kSFL8xTDO1sd8izjxcLdmV+CdQHPgbbOizq+5r0xXIC
 hNBzQ8+9eLGKt+aU2Pk/L5sI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 84ce8c3f7c47124b;
	Sat, 31 Oct 2026 04:34:08 +0000
X-Mizu-Trace-ID: 84ce8c3f7c47124b
X-Migadu-Flow: FLOW_OUT
Date: Sat, 31 Oct 2026 04:33:59 +0000
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
	stable@vger.kernel.org, "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
Subject: [PATCH v2] mm/filemap: stop fault-around when the walk steps back
Message-ID: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
X-B4-Tracking: v=1; b=H4sIACVu5WoC/yXNyw6CMBCF4Vchs3YSqAmpvopxMbRTHEIvaUVNC
 O9ugcVZfJv/rFA4Cxe4Nytk/kiRGCrUpQHzojAyiq0G1aq+a5XGyaH36GRmTwn3JRq54By/nHG
 IS7BIvbqy1aQ7c4NaSpmd/I6Xx/N0WYaJzXtPw7b9AbLiH4eHAAAA
X-Change-ID: 20261028-jf-mm-filemap-map-pages-lower-bound-a623ed8a81c9
X-Mailer: b4 0.15.2
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

filemap_map_pages() can dereference a PTE pointer outside the page table
it locked. KASAN has reported this as a use-after-free read [1]. The
same path can also write out of bounds. When the stray entry reads as
none, the fault-around loop maps a page there with set_pte_range().

Its fault-around loop walks the page cache and moves vmf->pte by the
change in index. A lower index moves it back. xas_find() can step back
to a lower index when a multi-index entry is split during the walk.

[1] fixes xas_find(), but the loop still relies on the walk never
stepping back. Stop the fault-around when the walk steps back. ->fault()
maps the faulting page if the loop did not.

Link: https://lore.kernel.org/20260904121301.200049-1-krystianmkaniewski@gmail.com [1]
Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
Cc: stable@vger.kernel.org
Signed-off-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
---
Changes in v2:
- Add Fixes: and Cc: stable tags, and say in the message that the loop
  can also write out of bounds (David Hildenbrand).
  https://patch.msgid.link/0a1ad7d2-ff0e-4248-8f03-2a64a9134aae@kernel.org
- Link to v1: https://patch.msgid.link/20261028-jf-mm-filemap-map-pages-lower-bound-v1-1-0bf126e876d4@linux.dev
---
 mm/filemap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index b74bc1e5015c..1df776907140 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3968,6 +3968,13 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		unsigned long end;
 		vm_fault_t map_ret;
 
+		/* A lower index could move vmf->pte out of its page table. */
+		if (unlikely(xas.xa_index < last_pgoff)) {
+			folio_unlock(folio);
+			folio_put(folio);
+			break;
+		}
+
 		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
 		vmf->pte += xas.xa_index - last_pgoff;
 		last_pgoff = xas.xa_index;

---
base-commit: 65ba8f34ec886ec72b2c07ddc8cf3d815c32869d
change-id: 20261028-jf-mm-filemap-map-pages-lower-bound-a623ed8a81c9

Best regards,
--  
Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>

