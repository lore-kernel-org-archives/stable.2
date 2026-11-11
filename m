Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355573;
	b=npCxNOHDM3kj+cMW30omMFeE2kcPENiQOBudCrJkVSK5lACNLeO4/6UhXdG3hXK62klH
	 AEBUsTxuS0kb38ncJMOI+0QCf1xwpuJ3I6QjIwTF8j1ZYbE+EGKFZVf3DWWXTdE+k0w3L
	 wEP7IVcP/IsUs5ng79PySGuRZP9gdKzY39HunL/XKU+ZEwfKFpJMAYx2YxJly594eKzeR
	 cjpMqcq8y5GHAZqPvHdg8bXiogX8dX3i6QRrYGdeebvsCLWpK6Be85KkAqDwu3AwAQ3mg
	 /6cPbWA0f1iF4ADe+deS0m7DU+b7oB8rmLj5IKzGvudIj77zg1HPR6z1xBqg4mgHaBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355573;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:In-Reply-To:Mime-Version:
	 References:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=MPaGHlrKKNil3fGv3AqMssX60Z7aoWmytXHFFmuU4tY=;
	b=yA7AxcugyL2L6vgOyUy18jZcJ6mOHq3fCyH30o8tmwFJkOoEhc4I96E+fYu+n9wbeoPd
	 CWXLCtqkaf3uTwONh2Gj8wNpQC4iFxr+Z4VDk57bAFdW82gZlDZOSIPVrnXlMvWqC2rUY
	 k50yNNYpjN9fcQ3JfZNFCnrhNnDi/VUVg9+hwyJlqsT5cGmEQaX9ZYjNUHWQ8RVQLyNGi
	 LttGEWVrANTeblWXX7Vq5yjufMgYxBkRhNsgdZMxXCLUutC4DYIMKBeiFNdUiwpB1E0BZ
	 FFmEayYYVn0tqkbnI2H8Z+AJDiWIDjOEm0r/svTQ3AjXUjCjg3tVOQfaCgMeBzXOivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlP7VyvS;
	arc=none smtp.remote-ip=209.85.210.69
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AE60A3811
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 00:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C2AE60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PlP7VyvS
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-84586110393so2957312a34.1
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 16:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794355572; x=1794960372; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPaGHlrKKNil3fGv3AqMssX60Z7aoWmytXHFFmuU4tY=;
        b=PlP7VyvSrDeXMNWQEx/7kzCYf3XxtifnDxYirKTCReGZBDgzInBxAzazgX3iSPlPwC
         6hi94Ll2ZO0NCrBnVPnY6E0akfCRiW69lKNTQtAmpV9sci6JGARmrPD2vt1Xu+5+RoXW
         K/UP2zWlhJLKXMU/Juy8PoOC54b2fYxQgiQdAGNV1PAEnoNwGzwk7/vhjWHrL4mYvJn+
         svez5TMgL3DrHaIA5dFxpJQ3BgJs+o0+ZLllAPd3NdmbKTT2UaUv8nId7xYpcE4r6EK8
         cl5NM6KYOu7WRMYUXetLfhZXxmspG0r/QNtDDTWDqRRZmPOzFRP6aGzsBsNw/t9Hrbg3
         VtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794355572; x=1794960372;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MPaGHlrKKNil3fGv3AqMssX60Z7aoWmytXHFFmuU4tY=;
        b=VEVYMjcz8EWs5aT0suHNct7Xcc3O2mctagtl1JwB4tdZyh0oUOyNlJE2GS280P8gji
         37zmj7P4QKVim86O6tn2PLj6pwMFkY3UYnsjB0Nynvvi8AsT1RR/KVn+aC2NA0lInPrk
         XYsZHQXmj1P491giGWSRG3WkO0YWkFJrfwxmAy9mIhPwSywhGjcz7Zeo630NInKvMxPz
         hFXQFTLbcQX3ux44LVb0QWOmz69g7uyHMb8kW5dQV6QZG0ZqG8VvCjbGISWFfWabc4eA
         K/3QgaMbLP5FMRRYaoakIZtmCHz4zIkeroVNyAMEcsSeRxs55M3YhCqh1rE4Sk7Zhuvt
         jyQw==
X-Gm-Message-State: APuU4Z+iEPvz3a0iUsTSLOu5YrLU8AJXwXVZJ6p94Y51oYihbna1Mx/B
	rNxx4VjwZ/yNpPXwNQJflMtrXdDUpD0oV6Yz91tw33iJIwVuinweZw444/57f/bx/EVmnfufNFA
	6UKCrmlcifWjLsBVKHTo22OHx+ZuHI78dzCk8KGzQNVhMmNKmhSx+W19V9hPEzExiwdfbuDVX58
	25NvaN+UkgAgzGc8UhsiQWeQtBYb6DCx0IwQL+gVb7UsGLKKc=
X-Received: from iohf6-n1.prod.google.com ([2002:a05:6602:a5c6:10b0:9c7:7732:c3c1])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1819:b0:564:3bc3:4605 with SMTP id 5614622812f47-56b9770f2cfmr502869b6e.40.1794355571526;
 Tue, 10 Nov 2026 16:06:11 -0800 (PST)
Date: Wed, 11 Nov 2026 00:06:05 +0000
In-Reply-To: <20261111000605.3227011-1-skhawaja@google.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261109200936-failed-6.12-71555ae8c757@kernel.org> <20261111000605.3227011-1-skhawaja@google.com>
X-Mailer: git-send-email 2.56.0.542.g3ef89b7020-goog
Message-ID: <20261111000605.3227011-3-skhawaja@google.com>
Subject: [PATCH 6.12.y 2/2] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()
From: Samiullah Khawaja <skhawaja@google.com>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Andy Lutomirski <luto@amacapital.net>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

memfd_pin_folios() pins folios from the page cache without taking the
folio lock. khugepaged or MADV_COLLAPSE can therefore replace a folio
after checking its refcount while memfd_pin_folios() still pins the old
folio. The caller then receives a folio which is no longer part of the
memfd.

For udmabuf and iommufd, this can cause data corruption: DMA accesses
the detached folio rather than the live memfd contents. DMA reads can
return stale data, while DMA writes update the detached copy and are
lost from the live memfd. The detached folio remains pinned, so these
accesses do not constitute a use-after-free or target another
application's memory. For memfd live update, the stale contents can
reappear in the memfd after handover.

Lock the folio and recheck folio->mapping before pinning it, like other
page cache users do. If the folio was removed, retry the folio lookup
from the index that was removed.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Reported-by: Andy Lutomirski <luto@amacapital.net>
Closes: https://lore.kernel.org/all/CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
Reviewed-by: Andy Lutomirski <luto@amacapital.net>
Link: https://patch.msgid.link/20261031203540.2282507-1-skhawaja@google.com
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
(cherry picked from commit 71555ae8c7572fd99158013ca2e29187c5d2508d)
[ skhawaja: resolve conflict with the existing next_idx variable in 6.12 ]
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/gup.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index b4746ab82dd1..cfee41084873 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3703,7 +3703,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 {
 	unsigned int flags, nr_folios, nr_found;
 	unsigned int i, pgshift = PAGE_SHIFT;
-	pgoff_t start_idx, end_idx, next_idx;
+	pgoff_t start_idx, end_idx, next_idx, retry_idx;
 	struct folio *folio = NULL;
 	struct folio_batch fbatch;
 	struct hstate *h;
@@ -3744,6 +3744,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 			 * reason, we try to allocate them and add them to the
 			 * page cache.
 			 */
+			retry_idx = start_idx;
 			nr_found = filemap_get_folios_contig(memfd->f_mapping,
 							     &start_idx,
 							     end_idx,
@@ -3768,7 +3769,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 
 				folio = page_folio(&fbatch.folios[i]->page);
 
+				/*
+				 * The folio might have been removed from the
+				 * page cache (e.g., truncated or collapsed)
+				 * after the lookup. Recheck under the folio
+				 * lock.
+				 */
+				folio_lock(folio);
+				if (unlikely(folio->mapping != memfd->f_mapping)) {
+					folio_unlock(folio);
+					start_idx = retry_idx;
+					break;
+				}
+
 				if (try_grab_folio(folio, 1, FOLL_PIN)) {
+					folio_unlock(folio);
 					folio_batch_release(&fbatch);
 					ret = -EINVAL;
 					goto err;
@@ -3779,14 +3794,12 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 				 * page cache that were never cleared.
 				 */
 				if (!folio_test_uptodate(folio)) {
-					folio_lock(folio);
-					if (!folio_test_uptodate(folio)) {
-						folio_zero_range(folio, 0, folio_size(folio));
-						flush_dcache_folio(folio);
-						folio_mark_uptodate(folio);
-					}
-					folio_unlock(folio);
+					folio_zero_range(folio, 0, folio_size(folio));
+					flush_dcache_folio(folio);
+					folio_mark_uptodate(folio);
 				}
+				retry_idx = folio_next_index(folio);
+				folio_unlock(folio);
 
 				if (nr_folios == 0)
 					*offset = offset_in_folio(folio, start);
-- 
2.56.0.542.g3ef89b7020-goog

