Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FA53AE1A3
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782133664; cv=none; b=Kes+nG3sogAEqG/mVRnIp3saxNzXa8MPInKLOsiLurDTJ0rsQNm/YWvx7NFfO3p5SFOZFeg/n9fN5XxWKIErZxTN02Puc95tj43lZfS/PObpjsZ8B37Vvns0Xc/YtdkEXdgAg/RgtpWC4oN1w8AC8Jl7KmOLis5Pz/csZPVSxxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782133664; c=relaxed/simple;
	bh=LbWNRhos+22c9RaxoUUl7utEPstrEUdh1I5gAlg5Hgo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=qYV/HJSBEv50IVHNSDTQSQCT1Xxl49A7BE1OyJ+6TcGVrwPL1O9xq+eXQ87bAgmb0bsqA231FjBHV7fQK6T/1BEru9VuR578ctKLZ/e2h/katdPcsm7I0b4xBcT3xE1Dhx0N/5j4iN+U64ydDt2WVL1FI5Lz2hl1hK09GaIAoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyyA49g+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyyA49g+"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-69767cb5d4aso4504820a12.3
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782133660; x=1782738460; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3wp3qDNeLDwzCm9eD9hHpUci3sq6PvJ0QUokiq7Icw=;
        b=CyyA49g+KO3DIsTjisCgXkNs+RA7bzcVJ2QmdCRcPovKROCI2xa/aeFgQyYsxMmL3R
         3cU4bg0Ni4RbBDm62YF13SS5oyTC9p9tcVCoewdMENoJhJiLuuJVSF9THCZQnViSJEbr
         CGd8IVM90UgQpCcc23keWux78+PsVLDkOv/tHQ6zH98YTcqnLe88iey6RwkwvRfk8saj
         +qOuz2gn5DYMk4oku/smRxKwn86AA3gIODObTPUElOYltEZUzOIyDbCbY12bQpZUqPGX
         CQaDFhI2k4t13DXopMcqr07zV4Wesy1Zd41OyF23+4tcPy7qaZc6kkdgjg5/2fazcD9d
         EClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782133660; x=1782738460;
        h=message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z3wp3qDNeLDwzCm9eD9hHpUci3sq6PvJ0QUokiq7Icw=;
        b=fFe8mkcKoLKE6thPmCEJpXmLafQH8kL6/N4ZOH/Z3rUrJI20/B0ItBGUmmN6UgmsBf
         t+FPFhRZfsKD7aEjGGyAWodq9zxfJuP/9mRVvWwNCKEm4ED6SaXkMrjCUACBcTjZMDCn
         SyWw4wbK7at2HFUosyKw1uv0+lkSHRIK3Xmdb7cJLSOToXgMMH8q84Mf+EqWGfqgbpgd
         jcDuDToLnLdXjDWRz3U39jxZ1HY9RSc9zbrUKlarHS616NPG/t82Olik7tSZ+bILk/v2
         YAbK9YNN+tJgEAwh3tNAGUfEOb7GXd4w4ylrawPQXTOtNFjcwAeuj2uM2A+eXIQq4kwu
         y49Q==
X-Forwarded-Encrypted: i=1; AFNElJ9sEu+iha8NBR3VmfY8JsYIEkDeeMAkWg0WzNreNqeHcsOgDoes/zlAlEzdMoY7stVyQca1UYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8F4s2C+vBoVNbzggPYshPNYDh8JlnPSey7/k+TwlExH0NKHwL
	HJ5RRAI1ov9PY8UXeUeJQIoZ2rru7JnGzF+dg9tpAqaJxuttXNA5pMhc
X-Gm-Gg: AfdE7clGeIOPyAXYl+wSYv5iVc3btnhW6Vlu3Eh/J5jUceHkK/PaiSG/KAvlT56Jwsm
	G9DwuYKTfcGSf15rKQ6JYCKPBB9OlaQPKFpSz9eYqay3+EvnGgZmfEw+3yGw9FjPoMeMoHBO7Xg
	EIqcP4rpaXl9IvpV/Wh0W1/2ge2UNPAZXTkI8Ve7hEDO2mc8WGUhLDLQDP34BhIdwQ738WvsFvr
	yzrY0+NAUJP3S1gAl37FmzHDojqFPOS1qiNxe20fHdfpveXpeGM/7WYNSH4mvc3qAB3UGQS6GG6
	hgjGSj3Dv5IUXNaG37amkVyH+fXHZsWFG9Rfq27pZr/+z0N5X0nNZ3VhwTnkVc1OCxpKO5ADIZx
	+6pJxh0FdoI18dhMRADl9O97YFwPvy9phSLRBUJMBXdY0x3vgRA1mFRMGxj6Sy/JUBeMrmq/tXr
	/LdsoW/P85u84=
X-Received: by 2002:a17:906:9fc5:b0:c06:1310:21cc with SMTP id a640c23a62f3a-c09901dce24mr813472666b.47.1782133660090;
        Mon, 22 Jun 2026 06:07:40 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c610e55aesm360917766b.52.2026.06.22.06.07.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Jun 2026 06:07:39 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	riel@surriel.com,
	liam@infradead.org,
	vbabka@kernel.org,
	harry@kernel.org,
	jannh@google.com,
	sj@kernel.org,
	ziy@nvidia.com,
	balbirs@nvidia.com
Cc: linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/page_vma_mapped: revalidate and do proper check before return device-private pmd
Date: Mon, 22 Jun 2026 13:06:51 +0000
Message-Id: <20260622130651.23359-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

For pmd_trans_huge() and pmd_is_migration_entry(), we does following
before return the pmd entry:

  * re-validate pmd entry after PTL
  * check PVMW_MIGRATION
  * check_pmd()
  * handle on pte level if split under us

But for device-private pmd, we just return after pmd_lock().

If a softleaf entry is present, e.g. device-private pmd, the existing
code simply acquires the PMD lock and returns success even if
PVMW_MIGRATION is set (indicating a migration entry is sought), meaning
that the caller can incorrectly interpret the entry as something it is
not, causing data corruption.

This patch fixes commit 65edfda6f3f2 ("mm/rmap: extend rmap and migration
support device-private entries") by following the same pattern as
pmd_trans_huge() and pmd_is_migration_entry() for device private entry.

Fixes: 65edfda6f3f2 ("mm/rmap: extend rmap and migration support device-private entries")
Cc: <stable@vger.kernel.org>
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Suggested-by: David Hildenbrand <david@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Balbir Singh <balbirs@nvidia.com>
Cc: SeongJae Park <sj@kernel.org>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>

---
v3:
  * remove cleanup part, only fix the issue for device-private entry
  * refine user effect description based on Lorenzo's suggestion
v2: https://lore.kernel.org/all/20260616063436.20455-1-richard.weiyang@gmail.com/T/#u
  * specify the possible error case of current code and user visible effect
  * besides fix, cleanup the pmd entry handling based on David's suggestion

v1: https://lore.kernel.org/linux-mm/20260508013728.21285-1-richard.weiyang@gmail.com/
---
 mm/page_vma_mapped.c | 32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
index 2ccbabfb2cc1..8de3c6b82df6 100644
--- a/mm/page_vma_mapped.c
+++ b/mm/page_vma_mapped.c
@@ -270,21 +270,33 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
 			spin_unlock(pvmw->ptl);
 			pvmw->ptl = NULL;
 		} else if (!pmd_present(pmde)) {
-			const softleaf_t entry = softleaf_from_pmd(pmde);
+			softleaf_t entry = softleaf_from_pmd(pmde);
 
 			if (softleaf_is_device_private(entry)) {
 				pvmw->ptl = pmd_lock(mm, pvmw->pmd);
-				return true;
-			}
 
-			if ((pvmw->flags & PVMW_SYNC) &&
-			    thp_vma_suitable_order(vma, pvmw->address,
-						   PMD_ORDER) &&
-			    (pvmw->nr_pages >= HPAGE_PMD_NR))
-				sync_with_folio_pmd_zap(mm, pvmw->pmd);
+				entry = softleaf_from_pmd(*pvmw->pmd);
 
-			step_forward(pvmw, PMD_SIZE);
-			continue;
+				if (softleaf_is_device_private(entry)) {
+					if (pvmw->flags & PVMW_MIGRATION)
+						return not_found(pvmw);
+					if (!check_pmd(softleaf_to_pfn(entry), pvmw))
+						return not_found(pvmw);
+					return true;
+				}
+				/* device-private pmd was split under us: handle on pte level */
+				spin_unlock(pvmw->ptl);
+				pvmw->ptl = NULL;
+			} else {
+				if ((pvmw->flags & PVMW_SYNC) &&
+				    thp_vma_suitable_order(vma, pvmw->address,
+							   PMD_ORDER) &&
+				    (pvmw->nr_pages >= HPAGE_PMD_NR))
+					sync_with_folio_pmd_zap(mm, pvmw->pmd);
+
+				step_forward(pvmw, PMD_SIZE);
+				continue;
+			}
 		}
 		if (!map_pte(pvmw, &pmde, &ptl)) {
 			if (!pvmw->pte)
-- 
2.34.1

