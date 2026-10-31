Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793478956;
	b=Pq8gWHKu6rbaxDqRDrr9lWHsPcaCy3umAMKfLcw7PawI3wnSKTDi7850WDgbqzO4VLbE
	 OhoJMRVoqLjrTUQxCwhULIS7Otx3ey6cGZ5YaQ094aIqbo6INNmavwcZtWu5roSWFucVL
	 jqBeBh9dP/+prwNeFkyttBFKB2AGxc37I1H9EAmklkyMBr7wq3hVtYcPt0qw9PezptDog
	 nFF24AbBJ6hW/VGgYczLvgsDmX54KKeFJl89L7ucAkHP7l7fT3gI3tlj8fGqQYQ8z/Hvw
	 uy297PVCP9y6xMM8FanNyiQdzhUhKWd2z4oTr+tLVouS5m1S2cJHK/h7lmgCw4mRtTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793478956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=mWqOErFXDyqrG4+5c5D2/KSgqZrNhszC76dEZeElAkE=;
	b=yoS1rQ03BGvShhHj/QsgY1hb/WEsgyH1AvaHZfjV8RVfvaB6deG7WP4TGF08tXxRJHML
	 gSG52NxhInIArkna7Zzh9PZvlEmJGVFnmr+hglXciKAbN5OCvPCrF92JAZHJaJBBVCcpT
	 XxLs/G0PNH7LLbXAYgI7LkpovtvRycKeMtUDdUyE1b3Strk9St8vevPGNSl4hJIzp/XCx
	 MXyo8C01KUtxPsJw8Nb/B+33Nv5mqE2m7UEayoPTXa/sR6SSdfO/Bh8Rbt89KNjdUc8HW
	 A+CsC5ovuh0LpxG4Eb3VrGMN9Kc8GtzCdLFJWm1kBH6y/fiNgrEEtQjH+W1p1dO7Pmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ki/9YKoY";
	arc=none smtp.remote-ip=209.85.215.199
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8E606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 20:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CD8E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--skhawaja.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ki/9YKoY
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cc7e0321ec1so2179848a12.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 13:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793478956; x=1794083756; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mWqOErFXDyqrG4+5c5D2/KSgqZrNhszC76dEZeElAkE=;
        b=ki/9YKoYUw81LJ6sDOtptLyi9sWhn2YmEATyMT8ZLmxR+u+Yz4InCrDUXGJrFOxAFe
         PjrvfiPQxG7i/ISfbE6nw+unf7r4gRhaqVLLX/0GTKgYM2tNsCBRINJjUMu4tIwGDb1+
         DPJ+32ilu8lm4gDCzUbyIFDp9dYU0myYNDL+ABhpfKXRRV/W8Sma8fYZwkZeBwK3rbDP
         AEAWAJqoLoM0oIMcXZ2kfb8c49P6ZyUG9yEWwfImy763ScEI0zJKxjDXUixD/C1q6/Rd
         YMoZNJTLLuYI/jKFBEwXXYIhfD4UtXfIqgNYFa/8cYLnfYOUbuWqN1PO5YccoikgeZCV
         o7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793478956; x=1794083756;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mWqOErFXDyqrG4+5c5D2/KSgqZrNhszC76dEZeElAkE=;
        b=dTqC5z5vuvtThXQ7TdPOGwUjYjZbdYujfWUZ/S8OkA7/kraUa1r15yAkBSfaVbnW4P
         H7lhAdHxfdlQJYA2T+HOLXO7x8shf6t4KalmE3xqGXt9tQ235aHE0e3ty6mpzUmLIM3M
         VoMz0up1leTyR2vspLr8QR6zXF+moi65LUJ8GiC3F92SqTYIok0cHd8uIt/qsKaJTmpe
         dN7y79gW5Y81m9g0W+GHSqNyK4h4/LnPvrVVtbPBwBpvodxuF+hldFdqXQ09Jc43QKrQ
         6v8W4PDJT/+fLm3qM2hmd+AKoWUAvmv6WxbRGusS422qPi3Mn6S/oVCXiqJBqK0RKiAW
         Y//g==
X-Forwarded-Encrypted: i=1; AKwUvByO04CV0SCSkYxyN94QD1+phVLZq7ICS2wwIdJ3NcWnB0/NZmqgLVJb+XLsJ6R77ymjifHUzmQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLmKz+hS/mehYbc2gLyqG2dTQ4doctRhQ2zLKI5GOMfBWuvY9i/
	2BiFDJXNVjLlw0ROXyZMooxAcF7iUdNCbjKa569LlQeWYq1kK7xztOIWUG1PyCn1X5QzgWPrvim
	fbzVf5HrVwqlOjw==
X-Received: from pfle16.prod.google.com ([2002:aa7:9210:0:b0:8a0:e479:9889])
 (user=skhawaja job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:3945:b0:3e1:aa91:7134 with SMTP id adf61e73a8af0-3e928ace8d8mr5315059637.72.1793478955460;
 Sat, 31 Oct 2026 13:35:55 -0700 (PDT)
Date: Sat, 31 Oct 2026 20:35:40 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261031203540.2282507-1-skhawaja@google.com>
Subject: [PATCH] mm/gup: check folio->mapping under folio lock in memfd_pin_folios()
From: Samiullah Khawaja <skhawaja@google.com>
To: David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Andy Lutomirski <luto@amacapital.net>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Samiullah Khawaja <skhawaja@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

memfd_pin_folios() pins folios from the page cache without taking the
folio lock. So khugepaged or MADV_COLLAPSE can replace the folio after
its refcount check while memfd_pin_folios() still pins the old folio,
and the caller ends up with a folio that is no longer part of the memfd.

Lock the folio and recheck folio->mapping before pinning it, like other
page cache users do. If the folio was removed, retry the folio lookup
from the index that was removed.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Reported-by: Andy Lutomirski <luto@amacapital.net>
Closes: https://lore.kernel.org/all/CALCETrV5eqg6d9=+BQhCpRwBNe3aCQiut8vxPBs8b7PToqjaHg@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
---
 mm/gup.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index ba4907b35232..2b405cce2ca5 100644
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

base-commit: 96995467b456942f5bf1c7f2c5c004467f9dd14e
-- 
2.56.0.317.g454f8302e1-goog

