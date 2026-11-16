Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794827589;
	b=U0dxle5ODRZtIDB0ZB0qzrCx/LeBJtnytBuSlBxwqf2afiCP3s/bl8m6aqn8mRQe5d0F
	 WB1Le/vjBR6smNo/YnBsIL0yWcIaqngPbc6NQieEBpTsEE/Tf479b9yGTCSwpe7s2yAKh
	 9i/yDJMNx9dESnViQm8KeM3t1sZbPGHtwphthwLC1vrkas4sHBn1kVE8IkT9i3ljuNXfE
	 s9S64pWK0BcTuZuQNBBhR6GR7CkDXUpR86r17krQsqC1EvFCLE+FZuZxBVbW6Yp032vqk
	 N1YdVfRwdpcUmPuhDFPOpdcsWfIMSQGK2PytV9satl8exCIVTGZ9GtEByFXt52+Y82g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794827589;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rROGYk1aEiWG91xI09CLyS+cm7Q+TGC8+ehzSxVtxO4=;
	b=uptbNqdBjoGvLf2qvtZTHCOnBK5Ycre/mvjxMGyOKBp0vBT47k2iA64ETdkNoWUEztrg
	 cSLPnxkHAWsz8uoLVoU3WtAsjvue7/PmJ9s+2y2yp3ZlCzL+/t+JQ4P8aKMEwQhGjn8If
	 9MFaG6MLCILkPUytGV4NEjWfe4w1EUZjtOxS4sk8wijX8pVRBW8ZViD2irhJNRp/7mphF
	 MziHe9mFv/uW+gjzipTp2QN7i9JwIJVBXpxuIb04SsaMSA6Cw20Us4uH2qHLcdA+mpDLO
	 /WOBVocQaiEJzfJCQhyi+de7bWcuNYB0UekI5uHe5pTxWlCFRczQ7hTZHldkY4T9Ftw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv0YrJHa;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F96606A331
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 11:13:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7F96606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sv0YrJHa
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b1535be329so2443583a91.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 03:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794827588; x=1795432388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rROGYk1aEiWG91xI09CLyS+cm7Q+TGC8+ehzSxVtxO4=;
        b=sv0YrJHal6yKIbHCL09EvCkmGX1nNr6Oz3Eo9+cwRe4qV2BQB5IX6/WdaOVtxvElTI
         Qf0Q8FeIIDU4oGJQkBviViZXVimGGETKdfnjEChfp2VrnGcSQB0KoHCYKEWv472Itoxd
         ma431rEX8S2KcYPwCgSJIEXskkOe3CUKKk3TyXSd6PAeFXA2GdNx82VEY4ePRfrlmMMp
         HQI4SYzAIpcTYVtT8R918YaptPLYAFzn8nKE/WmX0AzT0kd2Tsun8b7IsMMQkRkWcdwV
         +F5lyKhqk4lX5X0PANjiKu7zziPr0o8xr52n3PQPoGsvNR3QH8xZbqSkrhFSjIMqZfZ3
         2lbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794827588; x=1795432388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rROGYk1aEiWG91xI09CLyS+cm7Q+TGC8+ehzSxVtxO4=;
        b=mqYv/xqvUK1SZ5AlIQ8Ky/b1hJWficB9oCDV1uV+uB/mznCRcALenM4jq0jJldIWkL
         /n2Qj3GxnG2iooJ3arq2O3nGdszezt9cK8xTEtuaVTxMTDM0w/BnGzL4iycnZvGxybVi
         oX9Hmbx7trx+H+Y2IK0ChEy4LYJYtA406yTRitF7Ibu8JFxNLVJeUF91B6r+OfXkvy/d
         zlCoI6fRoyamG8Fpsel6mPT11urUBuChz/3rYzxyB6wTfgcFLlaxiRoms/hCZB84tZWj
         ao5p0PV8kJtqhdmzAnJYjeaQoMoG1vkLX9O4hgR/PZ1vvdZxx14EAucK2GsgwrrZXYxZ
         wc3Q==
X-Forwarded-Encrypted: i=1; AL+hErF1Gj0cxRJ5/Lx6cZcW+CXDl/jcLlHixF2YB+iLTd7CB0qRsI094fC8RCxtxGq/OwjXHRYE0tQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+T8YH7RAMDTKU5J306GS5L+nR141lU+IYh9oHjsZUalxAWaI6D
	+JrB/nqJU93tJNhZyAHSC4eSkZ0YJcp7x3D9dIk/GWOQn7LxpW3MjoFM
X-Gm-Gg: AZFdTZetm/ZoxqK7r5WmQWct/X16DbrVmy/nf6Miy56oCAMmjUHmZ7U+++dW/XFYo6i
	ZtUEyXWA2E4hjAtQlcbW+2PI49ZNCJoHR492JBxFqzwIPNV8O3DrO+PICacdSxjWRBaBanwDwpo
	RrRvrfyCDvHoTQA7dB8RzoxQ/2fZrqmDFDMr5LCByab7Bn9qBIUyxEzgGUeq1H35MS6eqfYuex2
	RwBg20LsihRjnTcTtTi7x5SRxOZRHxpL/czP+azXYOA8bKl3E/U2BVh1aBT927YV0Y+1DJ4n1PI
	RNzde6MK2/AIWdzUCS/ZmG/RFADo5zfoc8X9ljfJKSu7Q54OyDpep8k7HG6AdWN08VpspBw3UtV
	+3gdxQ2BonepgEdOw6ehrsHHUAgfa9hLLKGeKXgBFxBkAaEo0dYEatQn18KeMP/Z4Ij8GXV1dro
	740CtTZ55Ja1quAXCqDRwKM/JTqvMk1TuyONdxDvwEz29x2N4o9CRZ2TxPeQzGJf08zKRuoXK4O
	FTxt1A1hK6VDGv6FOPDOXaytxu7XbEA4OfSqCUDU/ThAJcUMgte13c93x5pXRva3UmNqKw7yEQh
	DjpqPvQlDeA3TvLy3B5RlhHz2Drs2i5U1oXBjulWzI+Bn8Z8eC8pSlevEh2EabhwcPs71ae8C40
	sSR2S7dOOK6xU1fSmPV9VSmM5ynCW5mS24ezDCVZEwCCHB8oTSGKP9vig2Wixa9SkIqK8bOXISs
	GaAzFPLJ6BNvnf+hDGFAb+08SD+WZ7XPPKqhaiUL5M/YUCAf21CpZo71H3dYc8eVS1NsSKsN7Ui
	QjV8UEGM8sxKdefY2mENej7R6BnuOoCZp3LyXjLsm9ePPE/Ee/JQcMXhmrnstbrAA==
X-Received: by 2002:a17:90b:37d0:b0:3ad:b8c8:4a84 with SMTP id 98e67ed59e1d1-3b1b0a0d978mr10900837a91.26.1794827587617;
        Mon, 16 Nov 2026 03:13:07 -0800 (PST)
Received: from localhost.localdomain (123-243-92-89.static.tpgi.com.au. [123.243.92.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d0f497sm21525599a91.8.2026.11.16.03.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 03:13:07 -0800 (PST)
From: Daniel Wade <danjwade95@gmail.com>
To: David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	stable@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/memory: mark unshare copies dirty to fix MADV_FREE data loss
Date: Mon, 16 Nov 2026 21:42:45 +1030
Message-Id: <20261116111245.28871-1-danjwade95@gmail.com>
X-Mailer: git-send-email 2.39.0.windows.2
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

MADV_FREE in one process can make reclaim free an anonymous page that
another process still maps and never gave up, which then reads zeroes.
It happens with a page copied by an unshare fault and shared by a later
fork().

MADV_FREE and lazyfree reclaim rely on an unwritten rule: an anonymous
folio whose content a mapping still needs has a dirty PTE in that
mapping, PG_dirty set, or a swap cache entry. madvise_free_pte_range()
only checks for other mappers on a folio that is already dirty or in the
swap cache. Any other folio it covers is marked lazyfree once the
caller's PTEs are clean, even when other processes map it, and
try_to_unmap_one() then drops those clean PTEs and frees the folio.

The copy wp_page_copy() makes for FAULT_FLAG_UNSHARE breaks the rule:
pte_mkdirty() is applied only for write faults, so the copy has a clean
PTE, no PG_dirty and no swap cache entry. Unshare faults come from R/O
pins on non-exclusive anonymous pages, for example process_vm_readv() on
a page shared with a child, or KSM unmerging one. If the process forks
after the pin is gone, MADV_FREE in either process frees the page under
the other.

Mark the copy dirty with folio_set_dirty(), as ksm_might_need_to_copy()
does for its copy. pte_mkdirty() is not suitable: on x86 it also sets the
soft-dirty bit, which this path carries over from the old PTE.

Side effect: smaps and numa_maps now count an unshare copy as
Private_Dirty or Shared_Dirty rather than _Clean. The PTE is unchanged.

Fixes: c89357e27f20 ("mm: support GUP-triggered unsharing of anonymous pages")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Wade <danjwade95@gmail.com>
---
Tested on mainline b3dfbde62cf1; mm/memory.c and mm/madvise.c are identical
in v7.4-rc3. x86-64, KASAN and PROVE_LOCKING, 2 vCPUs under KVM, no swap,
as uid 65534, with only this patch applied.

The test gives an unshare copy to a child, has the parent MADV_FREE it and
a control page it alone maps, then waits for reclaim.
- without: "test page in the child (unshare copy): present 0, 4096 of 4096
  bytes wrong"; an ordinary shared page freed the same way stays intact.
- with: the child's page is intact, the control page still discarded.
Same two results on v6.12.117, there with folio_set_dirty() placed earlier
in the same function. No KASAN or lockdep report in any run.

Two other ways to reach the same state are known and unchanged here:
khugepaged collapse to a sub-PMD folio in a non-writable VMA (covered by
"mm/khugepaged: mark a collapsed mTHP dirty"), and a swap-cache-skipping
read fault in the stable trees that still skip it. Checking for other
mappers in madvise_free_pte_range() covers all three and passed the same
tests, but changes MADV_FREE for every shared clean page.

 mm/memory.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index ec3d9d99ccee..49f6dc92c020 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4130,6 +4130,14 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
 		entry = folio_mk_pte(new_folio, vma->vm_page_prot);
 		entry = pte_sw_mkyoung(entry);
 		if (unlikely(unshare)) {
+			/*
+			 * The PTE stays clean, and pte_mkdirty() would also
+			 * set soft-dirty, which is carried over below. Mark
+			 * the folio dirty instead: MADV_FREE and lazyfree
+			 * reclaim may drop a clean anon folio that has no
+			 * swap entry, even one others still map.
+			 */
+			folio_set_dirty(new_folio);
 			if (pte_soft_dirty(vmf->orig_pte))
 				entry = pte_mksoft_dirty(entry);
 			if (pte_uffd(vmf->orig_pte)) {
