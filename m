Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645650;
	b=QgZXjWlDp5dqflPRIEzdhu6732ten2qCpBESVsXJnOoNSf5/llLR6lNbxine1yYolE2L
	 od8SaayxcvOpeiMGMaBPFZREfIzdFtKAdBuBU4PhaewcrZtRPK1LLcV1ru/MiJrlypqhs
	 oo3FZszoJ6tF/8LMCW/84k6LEX/D0i8TlC7b3TktD+w87rVUZrsyqpj3+1gdBMnYUZJsu
	 20Ou3kVaWCdXpqfj/vipAUQLJ3bJaXDiOGgM9RFlC09trFpoH7IgeQ0JoqdOl1KiQ0bOD
	 8+bZRogASovxG/iKZ7sj8hQuBzCnB8KdmbLTnKR1HFenqVYu394RZELeXoP1q0axYWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645650;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=RiNM9OF5vBLtGgFl62pfxBUQi+W1VLFdVJFedeCHig4=;
	b=WYBHLT9iAfV3AP3aRxy+q50yt3jC9TTX1RPxuvKQ0v98X8Ax7hlfL4Y0VnpcteRDev0k
	 q3sF0VApjbthzH1xu3NivjrLRuno0VVVI9b/3lWLnmx8SLx64n3UYDUo8PSViA7jb/zj1
	 cDZk62MeSJq/Xtvj06W0oy6FpQAHLqHLtwggWRP+WKxdYxSASW7OZ9YG/Wfx16lRm52cI
	 9FTVhg8ToiVVN5UOnskLGWRRfuNad1H7mGxbWVw9SZoHefyeyHo4K8XSV3Np9DmK4G0bF
	 SL+NGomT6LIBpxzAVeftsvaLEx65p6/NRiJrcidwetLUUdaCeYsSK9+cIUA9n21cIaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--elkin.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZp8zMxx;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16EE606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 22:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E16EE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elkin.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nZp8zMxx
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-3869865a304so490588eec.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795645649; x=1796250449; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RiNM9OF5vBLtGgFl62pfxBUQi+W1VLFdVJFedeCHig4=;
        b=nZp8zMxx+xiHgR6o7ArSyLmlUC+8TFeTxpnjim/CeWqQULhssE6GK2uwFqCuFnwfEp
         +I6a+WEfjTzj0vXnutB0nbx4TAUlRbWMV/yRzaqYdqpFIs1U39lclRIQZAL+YoKnNsvs
         RBK6o9DiZ1u/Zy8fQSwOPlFVGH7dkTMwbWex2vyr/3e/1F+pXUNQ1Zx4cli2XQ/g8iMu
         Br6Ur8/b1cKyVXPDoyB4Ryn/s/QSxo/Qm05sq6TQ9hPtBuj3Yat4Fmn7q8ZumG6fAMwd
         RmJrvPHQvnfcc9397M3PhZjbMDr9w6kQcA7/CshHdCKrzAWgSYGbP10bFp4v2TLjU9QL
         WC9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795645649; x=1796250449;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RiNM9OF5vBLtGgFl62pfxBUQi+W1VLFdVJFedeCHig4=;
        b=SorPdy0PCJbWgyJU7aVrbOcjyqHF9OckgpT/4i0gnTVB2c1aSGo5eCUPTEYqzHsb1X
         5FqATI1hDwTrR3xsjfII4pqSnNAhFAihDDrr7ym60rLjsofyuFeIrIex6jQ8aOcyA4RB
         +y1Uq6cva24uv0qLltK5lMQiN33XIFR8K4nqIwq0v/PHIDO+RMzv1War6XDZcmzGfdPC
         IQGmtTW0DnIHmRtCk8bbwQ4kVOvxsdF4OsogvhtTCmo79Oz5HOgmRoiy1oVL/x0EKfJU
         cEuB0/gqW2FbNPmWujsQQ64g8GswJRGyU97s9KY0bQq/VLdMqYXExpycNIPC1/Ml7/gP
         zBRw==
X-Forwarded-Encrypted: i=1; AL+hErEQxpaYXTmbJJsvU/0AUotRZ90sAPkGItXbSAtjfa4wV6yL1bqQHWN7opjbNfPQw7U9b1+8Yk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LFrObaVjy2lUoTzX4D1p2PXZeKLDXRomLTKLWhsXecSnprj2b
	A38im5Lk6AoNxkbr5/fseNoNCYvsCJakNcy+XNUsikXlrXJSZBh2smSICnnKyRoV1YEg7sMDuiM
	UdQ==
X-Received: from dyp12.prod.google.com ([2002:a05:693c:65cc:b0:381:fb4c:34e1])
 (user=elkin job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:4710:b0:378:314:4042
 with SMTP id 5a478bee46e88-385702587c5mr17876713eec.14.1795645648594; Wed, 25
 Nov 2026 14:27:28 -0800 (PST)
Date: Wed, 25 Nov 2026 22:27:13 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261125222713.1450385-1-elkin@google.com>
Subject: [PATCH] mm/migrate_device: use locked folio in migrate_device_{range,pfns}()
From: Elkin Cruz <elkin@google.com>
To: David Hildenbrand <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, linux-mm@kvack.org, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, irogers@google.com, 
	Elkin Cruz <elkin@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

migrate_device_range() and migrate_device_pfns() read a speculative
folio pointer via page_folio() prior to taking a reference or lock in
migrate_device_pfn_lock(). If the page splits or changes compound state
before lock acquisition, folio_nr_pages(folio) inspects stale state and
the nr > npages - i error path calls unpin_anon_rmap(), folio_unlock(),
and folio_put() on the unowned speculative pointer while leaking the
reference and lock on the folio actually locked by
migrate_device_pfn_lock().

Return the referenced, locked folio directly from
migrate_device_pfn_lock() and skip unlocked entries cleanly.

Fixes: dc41e961a269 ("mm/migrate_device: avoid out-of-bounds writes for compound folios")
Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Elkin Cruz <elkin@google.com>
---

I am trying out new Clang static analysis checks for kernel bug
classes, and they flagged this code as possibly buggy. The findings
were triaged/fixed and commit descriptions were drafted with help of AI,
then checked against linux-next (not runtime-tested on hardware).

Thanks,
Elkin

 mm/migrate_device.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index a953e7acbea6..a599d5baa340 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -1416,11 +1416,13 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
 
-static unsigned long migrate_device_pfn_lock(unsigned long pfn)
+static unsigned long migrate_device_pfn_lock(unsigned long pfn,
+					     struct folio **foliop)
 {
 	unsigned long src_pfn = migrate_pfn(pfn) | MIGRATE_PFN_MIGRATE;
 	struct folio *folio;
 
+	*foliop = NULL;
 	folio = folio_get_nontail_page(pfn_to_page(pfn));
 	if (!folio)
 		return 0;
@@ -1436,6 +1438,7 @@ static unsigned long migrate_device_pfn_lock(unsigned long pfn)
 		return 0;
 	}
 
+	*foliop = folio;
 	return src_pfn;
 }
 
@@ -1464,18 +1467,18 @@ int migrate_device_range(unsigned long *src_pfns, unsigned long start,
 	unsigned long i, j, pfn;
 
 	for (pfn = start, i = 0; i < npages; pfn++, i++) {
-		struct page *page = pfn_to_page(pfn);
-		struct folio *folio = page_folio(page);
-		unsigned int nr = 1;
+		struct folio *folio;
+		unsigned int nr;
+
+		src_pfns[i] = migrate_device_pfn_lock(pfn, &folio);
+		if (!folio)
+			continue;
 
-		src_pfns[i] = migrate_device_pfn_lock(pfn);
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
-			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
-				unpin_anon_rmap(folio, src_pfns[i]);
-				folio_unlock(folio);
-				folio_put(folio);
-			}
+			unpin_anon_rmap(folio, src_pfns[i]);
+			folio_unlock(folio);
+			folio_put(folio);
 			memset(&src_pfns[i], 0,
 			       (npages - i) * sizeof(*src_pfns));
 			break;
@@ -1508,18 +1511,18 @@ int migrate_device_pfns(unsigned long *src_pfns, unsigned long npages)
 	unsigned long i, j;
 
 	for (i = 0; i < npages; i++) {
-		struct page *page = pfn_to_page(src_pfns[i]);
-		struct folio *folio = page_folio(page);
-		unsigned int nr = 1;
+		struct folio *folio;
+		unsigned int nr;
+
+		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i], &folio);
+		if (!folio)
+			continue;
 
-		src_pfns[i] = migrate_device_pfn_lock(src_pfns[i]);
 		nr = folio_nr_pages(folio);
 		if (nr > npages - i) {
-			if (src_pfns[i] & MIGRATE_PFN_MIGRATE) {
-				unpin_anon_rmap(folio, src_pfns[i]);
-				folio_unlock(folio);
-				folio_put(folio);
-			}
+			unpin_anon_rmap(folio, src_pfns[i]);
+			folio_unlock(folio);
+			folio_put(folio);
 			memset(&src_pfns[i], 0,
 			       (npages - i) * sizeof(*src_pfns));
 			break;
-- 
2.56.1.839.g22a8290db9-goog

