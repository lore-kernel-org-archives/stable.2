Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677649;
	b=s71z0sBIRxUVfu9jl1TLICfjV7piLEkVLjMe6xRJbRmksPuBxR6ifzDs/1qnzWeDWuNd
	 Scwgli4u+YlbYxpakSFhq4DXlDcrteVfmYHrx+5QSeiZPHYTeZUlOTJ1T/hxtlUSMYhlJ
	 pycIhNOgpaYkVdZ6P/siHw30b9/sBp24EOPMEKZpmaKLEu/NfO6Ktw4BZu9uhEc+w4kHi
	 f6PScquym0YWYRk1sNzRp25ZcTGXJez4Z21OCJUFM9RD5ctdVjiyiBN+EYTw6EoGJdUQu
	 ncSCKTEUiDSvUMY1OK85nr3TBzYEOn9odX0AFYjFVT4orVwD4Uvpeoyv2RK8XbyyU1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=RYxKdG3hGFUHAS2wMT8TWf0HywRpu62ZcKtPYmwcpl4=;
	b=1Xe4ya2WdKCVAZJyWgyEQW2IBUH7WcCMirn1j2zZdXeIlCIAHkhpb3fbLCIGYR7mICx1
	 ufyJJo8XQ8iL/uqXfmpU2hyr0pdPwD2jQX/KllOi1Osq6FAyTMX/zXCo9sDzukGH616mN
	 03uJxgrS6wRL9OoGP5atWfom66RQ7TpxvWj4cNpwxcP+m9nTaV4zeDJ/5lv/xHCWitLg3
	 7duhPsjKA1un9TQwdJbSNX7lizsA2WO+9Qpwk0nroCCHQVE8cp32m4+NSgxD2jo+pIlRV
	 GFG3dp+phIpxMsAcPoELmiu3kSJ7qk9fHqhlQSShcb2u2u8LtMA4I9N30P5wOSy3kVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bxh+hitZ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2B6606A32E
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 14:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F2B6606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Bxh+hitZ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35943f55c06so1229486eec.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 07:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792677648; x=1793282448; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RYxKdG3hGFUHAS2wMT8TWf0HywRpu62ZcKtPYmwcpl4=;
        b=Bxh+hitZO2FfVxuz5Qb9/4WIWAKO1lLwLLJ2tAGbDmc/XpxgVHZrEjIvDM/FXCMaOH
         9ksyLbdCCzsT8O8/74+VYG6Jd5VDQvreFNb5S1p4n90dsLImy18AOoDlyNN3sRtvShor
         Gj+utQlqLyd4ntudIORPMfB208zKeVn/eFPaD9M73Q/Jp3y40aAgvf+SYE/atC6e+3N1
         JzK8uT4RTeUtrWvqXTNtzD+mRUCfqxdcIHSdI2NSgMILnxPqQJfUwB7IW1SlJMqGN+78
         x6igq4CMTL2Uxeg2rNI3sussxWHoPv792Bk2Mew9uXxjg+nM7HOu7OPraJBXudKPCRK9
         M2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792677648; x=1793282448;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RYxKdG3hGFUHAS2wMT8TWf0HywRpu62ZcKtPYmwcpl4=;
        b=IZRNvotz3rwPpdFf5VFC0rpJeyFxBgrHJemeIMaBfatoRUo0vECo3zpv8mpeQyyeK8
         uG2JtorX3g8HUo8fBNgvGSoNUZeUF8JuEkKH6YVGVvVlcn6eJZzmh8M2qelXUUOfImDb
         0id6EOlFUvF61uiC7/fMj0b/JxTmIwUfw0w/h1Sx0jRL1Vs99ziPuxLgon5nryYcNROT
         2y7JWburKtoGKCiTtuUZH39IPC0t0H+i63qAOSciNktlCB450p7BOr9Gw34gFs573hUL
         iJHC7PNDXWbXbqb1rhS63G5+dmlSZRT6Haac2d/9jKHHT9TfquUeJ2uE0O6cQ7BnfnpY
         OuPw==
X-Forwarded-Encrypted: i=1; AKwUvBzbbKyN1NDkLx5cWUUZ3cEmDhlr6T2V3Q3njzOdnOUlQD2LUg9vG1g4Fy1UeIgc3R0HfzjHLyQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJCaDZ+AeC7w9NHwjmlLLKjNr0cUWcysAHmfx+U/iEHTJgsdZVe
	WF3IxXixSQUrqXSDqu3XPaqD87zFRPO5RAas5helgk9anTgJZusjuyWW
X-Gm-Gg: AYBFou0P4hfj4F0EIs9qzKXtQN7sRUkE0huVvZ0zmAKjtmxpj+rPKRBj6NQf6dinupx
	u/OugwhsJapwLda2vOQP8n58UYdO2W9+XAerchek9dLZW4l620dEITw14BTJzVN8jFA2HNHZCOi
	b4IYMz2f+EYaWn4H8Zj0C9/PipoGSzU5Rtmf+lPQAvxasoJ09RY9x+NZoYmGfmyYyrZ9kwiyIRS
	o/65dwpixUXACQ8G0cLKET+Trk93J2nBGYIZFfxEsXhv+zIz1uA2/QnB6syt71ilfWVObbhpwkr
	RwdvqR2o4sWjN5lNg6D3PopMA13QbMxLhlxVqF3BSFoMK1QzlrStOhEb21TyBkeAcnI1GVXBipQ
	0R2LJGIFf1X4xLXB7Nw8ylIu6oeaSyZAhPHqFP4UOHftF78r/QLkvc4QRcDuWh4zD93eGzjJpPY
	4qjrbWkfG1QKDhWh++WB5/le9+oRv9PZ/I2xKbFtr48KY4VBCRKFLHC9LgIR5s/AnuIRvf5bAk0
	cgLwp1MNEav4/shIWk+LzhrrnLrqqk+uBZsFeJTk4ZyvJOECnt0fgPDbegFZ1QIP8tfwdCF
X-Received: by 2002:a05:7300:c392:b0:35c:49b9:3166 with SMTP id 5a478bee46e88-368aead362fmr3201965eec.6.1792677647279;
        Thu, 22 Oct 2026 07:00:47 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3673e15353csm29420342eec.2.2026.10.22.07.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 07:00:46 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Thu, 22 Oct 2026 22:00:36 +0800
Subject: [PATCH 1/2] mm/filemap: read ahead downwards on descending
 VM_HUGEPAGE faults
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261022-bug-mm-mmap-readahead-descending-v1-1-6d08b34862f2@gmail.com>
References: <20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com>
In-Reply-To: <20261022-bug-mm-mmap-readahead-descending-v1-0-6d08b34862f2@gmail.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
 Vishal Moola <vishal.moola@gmail.com>, fujunjie <fujunjie1@qq.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Qiliang Yuan <odys.yuan@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0

On a VM_HUGEPAGE file mapping, a synchronous fault reads the PMD-sized
folio that holds the faulting address and the one above it, and maps
the faulting folio with a PMD. do_sync_mmap_readahead() counts each such
fault in mmap_miss and stops reading ahead once it passes
MMAP_LOTSAMISS, while filemap_map_pages() lowers the count for faults
served from the page cache, but only when it maps them with PTEs.

A reader that moves towards lower offsets, such as memmove() copying
backwards out of a mapping, never finds its next folio cached: the
folio above is the one it just read. Every folio is a miss and none is a
hit, so after about a hundred folios mmap_miss passes the limit and
every page after that is read on its own. Since the PTEs mapped around
a fault no longer count as hits, nothing lowers the count for it.

When the folio above the faulting one is cached, read the folio below
instead, without a readahead mark, and count a PMD mapping of the
faulting address as a hit the way a PTE mapping is. Such a reader then
misses on every other folio and hits on the rest.

Reading one byte from each page of a 2 GiB file, last page first, in a
MADV_HUGEPAGE mapping with a cold page cache, read_ahead_kb 8192:

                   before       after
  time            36.76 s      0.41 s
  major faults     473191         516

Fixes: 0b9c0aeba938 ("mm/filemap: count only the faulting address as a mmap hit")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 mm/filemap.c | 101 ++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 72 insertions(+), 29 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 00fd89cf6f550..8a7d1238ae75d 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3319,6 +3319,23 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 	return 1;
 }
 
+/*
+ * Whether a miss at @index, right below @nr cached pages, comes from a
+ * stream that runs towards lower offsets.
+ */
+static bool filemap_descending(struct address_space *mapping, pgoff_t index,
+			       unsigned long nr)
+{
+	void *entry;
+
+	if (index < nr)
+		return false;
+	rcu_read_lock();
+	entry = xa_load(&mapping->i_pages, index + nr);
+	rcu_read_unlock();
+	return entry && !xa_is_value(entry);
+}
+
 /*
  * Synchronous readahead happens when we don't even find a page in the page
  * cache at all.  We don't want to perform IO under the mmap sem, so if we have
@@ -3392,13 +3409,20 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
 		ractl._index &= ~(folio_nr_pages - 1);
 		ra->size = folio_nr_pages;
+		ra->async_size = folio_nr_pages;
 		/*
 		 * Fetch two folios so we get the chance to actually
-		 * readahead, unless we've been told not to.
+		 * readahead, unless we've been told not to. A stream that
+		 * runs towards lower offsets gets the folio below.
 		 */
-		if (!(vm_flags & VM_RAND_READ))
+		if (!(vm_flags & VM_RAND_READ)) {
 			ra->size *= 2;
-		ra->async_size = folio_nr_pages;
+			if (filemap_descending(mapping, ractl._index,
+					       folio_nr_pages)) {
+				ractl._index -= folio_nr_pages;
+				ra->async_size = 0;
+			}
+		}
 		ra->order = thp_order;
 		page_cache_ra_order(&ractl, ra);
 		return fpin;
@@ -3896,6 +3920,39 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	return ret;
 }
 
+/*
+ * Whether mapping @folio at the faulting address counts as an mmap hit,
+ * which lowers mmap_miss in do_sync_mmap_readahead().
+ */
+static bool filemap_mmap_hit(struct vm_fault *vmf, struct folio *folio)
+{
+	/* Skip the retry of a fault, which maps the folio its miss read */
+	if (vmf->flags & FAULT_FLAG_TRIED)
+		return false;
+	/*
+	 * If there are too many folios that are recently evicted in a file,
+	 * they will probably continue to be evicted. In such situation,
+	 * read-ahead is only a waste of IO. Don't decrease mmap_miss in this
+	 * scenario to make sure we can stop read-ahead.
+	 */
+	if (folio_test_workingset(folio))
+		return false;
+	/*
+	 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss increment in
+	 * do_sync_mmap_readahead(), so skip the decrement as well to keep
+	 * the counter symmetric.
+	 */
+	return !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC));
+}
+
+static void filemap_count_mmap_hit(struct file *file)
+{
+	unsigned short mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+
+	if (mmap_miss)
+		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss - 1);
+}
+
 vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 			     pgoff_t start_pgoff, pgoff_t end_pgoff)
 {
@@ -3930,10 +3987,16 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	 * Make an exception for shmem/tmpfs that for long time
 	 * intentionally mapped with PMDs across i_size.
 	 */
-	if ((file_end >= folio_next_index(folio) || shmem_mapping(mapping)) &&
-	    filemap_map_pmd(vmf, folio, start_pgoff)) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
+	if (file_end >= folio_next_index(folio) || shmem_mapping(mapping)) {
+		/* Check before filemap_map_pmd(), which may drop the last ref */
+		bool hit = filemap_mmap_hit(vmf, folio);
+
+		if (filemap_map_pmd(vmf, folio, start_pgoff)) {
+			if (hit)
+				filemap_count_mmap_hit(file);
+			ret = VM_FAULT_NOPAGE;
+			goto out;
+		}
 	}
 
 	addr = vma->vm_start +
@@ -3968,28 +4031,8 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		}
 		ret |= map_ret;
 
-		/*
-		 * If there are too many folios that are recently evicted
-		 * in a file, they will probably continue to be evicted.
-		 * In such situation, read-ahead is only a waste of IO.
-		 * Don't decrease mmap_miss in this scenario to make sure
-		 * we can stop read-ahead.
-		 *
-		 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss
-		 * increment in do_sync_mmap_readahead(), so skip the
-		 * decrement here as well to keep the counter symmetric.
-		 */
-		if ((map_ret & VM_FAULT_NOPAGE) &&
-		    !(vmf->flags & FAULT_FLAG_TRIED) &&
-		    !folio_test_workingset(folio) &&
-		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
-			unsigned short mmap_miss;
-
-			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
-			if (mmap_miss)
-				WRITE_ONCE(file->f_ra.mmap_miss,
-					   mmap_miss - 1);
-		}
+		if ((map_ret & VM_FAULT_NOPAGE) && filemap_mmap_hit(vmf, folio))
+			filemap_count_mmap_hit(file);
 
 		folio_unlock(folio);
 	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);

-- 
2.43.0

