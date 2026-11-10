Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272978;
	b=LyM62j0SsOG+dO+0xK6w1/RKeQ1zEX6kRIAu2zJfM8Yp/bknI6taKfnXkkIR7tUO+QeJ
	 irmoN5ltGWabJsJ9mqzMrZ3SPKTm4Sc/Wujw7PWoh793PYjyIDw8zv+uro0cIsY/llLpI
	 hHIaTDt75CS5SeqyPTdDZJXfEojDEenWztEf10D59p1bJSyijXR+DmSxEIkmF9Olbptoo
	 ngKYUy2bIcRDoFPfsFWZOXfwwM4kfBgbbhW9BJiL99uFsEnoV8Kpcy/LxnySUkrrPX5rY
	 H4LTg+UFDzDblcixcp5IwJQoT7Qj2PmJeigF9BCpHRF2xWj9RqWsRNS4M+MEbp8KXpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272978;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YFZ933FVHlyDd1eGIvbuNExuRwiaJCIAKdxJwObKXrU=;
	b=XaIJrhIZ/B0XbktsjiK11GTnfJ1OoEs6QgOJmSVkAE/cg6g7bRKsZZXJHMTbeDq23Z5j
	 4QiuKjKcKJhmqqBbyoFnbNgxYqTzl1eVQnHInfoVTh6kXir8kFSOQGVAAbzZJS2lzGtJv
	 I5gGoVSHUdC1sn1ccLTbodlfSJA9xZqVfsBXnZy0QsG7A9Jf1SNOwMq49+eFwHK/KhiQV
	 fMkpH7suzwhxeURhs7RqAmv4z1A8ukS5urhmaBpmbMaws6fLM9hNbDewINerskNiIkmGl
	 Djky35rKishzzrsdBEn5pEcg7DXRddgQJaUGiW04AlGY9QcICk211qE0pWzzUd0uttw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXniAQQZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6787B606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nXniAQQZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A911F008A1;
	Tue, 10 Nov 2026 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272978;
	bh=YFZ933FVHlyDd1eGIvbuNExuRwiaJCIAKdxJwObKXrU=;
	h=From:To:Cc:Subject:Date;
	b=nXniAQQZzrHjEOUXudGhGBpHvntGOLgdpSEmFamvwWfvBG8TRLynbJdX7Cm4UI2wk
	 phT8DCnbUcNETfATvbM2TuPt92yDZtpFnr/L55fQJLNqeA7cGtqkK8dy6KvrpMY9JS
	 nKYvPfQoqquhU5YfSvLA2JKqkadcQFTZXSvaHDp4eMxu/ItuqZkMv5dxB2wlQoLFq2
	 SokYmpMSh+yxjDiBUS1NxW1ap25v6TWp6xqEsw2/E+x4xWv8tqYlW4aThQ9dQd84Ri
	 rIbsjJPlY4jnpc6sOVyfo0x8H0YYOfqQnSO/F0s/2DPvfCPgjACyNezbIweSjFWdtV
	 hJyDakF9I1/PQ==
From: Sasha Levin <sashal@kernel.org>
To: skhawaja@google.com,
	luto@amacapital.net,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:36 -0500
Message-ID: <20261109200936-failed-6.12-71555ae8c757@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 71555ae8c7572fd99158013ca2e29187c5d2508d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200936-failed-6.12-71555ae8c757@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 71555ae8c7572fd99158013ca2e29187c5d2508d Mon Sep 17 00:00:00 2001
From: Samiullah Khawaja <skhawaja@google.com>
Date: Sat, 31 Oct 2026 20:35:40 +0000
Subject: [PATCH] mm/gup: check folio->mapping under folio lock in
 memfd_pin_folios()

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
---
 mm/gup.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ba4907b352323..2b405cce2ca5c 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -3471,7 +3471,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 {
 	unsigned int flags, nr_folios, nr_found;
 	unsigned int i, pgshift = PAGE_SHIFT;
-	pgoff_t start_idx, end_idx;
+	pgoff_t start_idx, end_idx, retry_idx;
 	struct folio *folio = NULL;
 	struct folio_batch fbatch;
 	struct hstate *h;
@@ -3512,6 +3512,7 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 			 * reason, we try to allocate them and add them to the
 			 * page cache.
 			 */
+			retry_idx = start_idx;
 			nr_found = filemap_get_folios_contig(memfd->f_mapping,
 							     &start_idx,
 							     end_idx,
@@ -3524,7 +3525,21 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
 			for (i = 0; i < nr_found; i++) {
 				folio = fbatch.folios[i];
 
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
@@ -3535,14 +3550,12 @@ long memfd_pin_folios(struct file *memfd, loff_t start, loff_t end,
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
2.53.0




