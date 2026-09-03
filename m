Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CDD3624CC
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405428; cv=none; b=OwU3+KnjQEXmKAYhmZWPtPvQQKxdvsN5kD5TsdinL9yn9jqc8BZuv4wenEHRFvfDJZwcGHGnWm0TXM9bgBNfQBwxbPfwiVRhNDfSNlh2lAbkMx7iF+cpVt1Q5cEFdxnEjq3EJUv0anfVUjD1R8eWDn2TfpLYvaMntiEtfXweUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405428; c=relaxed/simple;
	bh=uh3PjXoLjosxsg+DIsuL1EOEHL16VgIJEnVi4iERdns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QWXh9wsPACJQqiJzhmviB0GUapbcITIZBlMYkKcItHO7YyAjv6o8xFubRau0pyjUDJrAyM3iuwvbi8Ord7rlfvtoywi0hYlxx9Jn2VV/QxSnvEZJF4Bu88igcPL44tb3HqZp/CuFhhwCMzmSsq4xaAYQlXTUPx5MyD+46Ju4vFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XgZbhmcI; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XgZbhmcI"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d71ae3455aso27065695ad.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 20:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405426; x=1789010226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Ry9aZAR4rOnvuBv9WAZuiM8CW7iBdIw7/zNBIgTZE4=;
        b=XgZbhmcIord8qddUxjh9ZF05p4x9Kn2vmIbmxSyrUmTV3UTyvZI3fxcZ+wP8VxJOJe
         EhqSM6o+STzLiD/4UR2mBiE+zgrb6zuFmA8yyAvjdhi7kYAunWx5bSIAcVcGe4UGX7gI
         1eQpFazPTeetc2v9audCvMYOou3B3eEXbbr1x10DVPHPLHsU7q7JUK95YQ6gFsP5pi3p
         OlJQeHwRqewTwlSh44Qgp3wwHmemkd1yGvRpV2bfZkiFXdMYEIqytWFBr6YKFRTF8TkZ
         U1sb25tcqSIfbhYXe9UTWxERzQnSLiNl4iw2sJTFDasEDYsAzceCO7rnPweYG6NpcOZ/
         qJcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405426; x=1789010226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Ry9aZAR4rOnvuBv9WAZuiM8CW7iBdIw7/zNBIgTZE4=;
        b=S8/GRkdNJxMDf6Bi3EIlooijMMS3PtER9H2Yu1dtQhYpZ1JtyKgqjqArPXsZSHz9eg
         g9m07M3ongbq0lXKNnc4UJ5Xr/ZZyvCzC53d/9ZQJeAVSi922wbt2FQ/NYlKdYoZKfHZ
         0nl1kmqT+28fGVhPz3kx8ml9fH5G4zH2XKp6VJ1M9w3CYQ6b7rZDizuG00e4eLlo/y0p
         YLAZbYQFtk0im6WblMxpBw3rCkTkTO5AqNdrL3syLIoiR8cI8RX+MvQIbc6IZn4Ql+IM
         gDaocpxoFHHIf6PXaK0NHVzPHRPFqD4FoXW/EOrH/R/mLPruRlx5hS28lvXNjbMUM13m
         m9dg==
X-Forwarded-Encrypted: i=1; AKwUvBy/5i6XRW9uqYy5lNp426u1TTra0VwYX6Pyy/84h1agYdbSUncd4E5uzLmpxMq4khYhzQ05Z78=@vger.kernel.org
X-Gm-Message-State: AFuF++kuNC02eQauGRtClO2i6bEyqkcJH52+OJJyLy0u+AcNxdMAePL+
	dTrb4qfNEo2UPNSQPgd3c0/mn0G0pYNo3LKnFh95C0oxVW4iikzXd5eG
X-Gm-Gg: AYBFou1RjyqBDIGVUXI2LiF21nkFdu9+WZGoIxsLo/RbxZcs4sQGfmvcnKEUaDXU4fT
	i9776CPiISvt8GHXFvwupGQtZ9//rbNuVFSMt0FePijRwlxYnMSWlquX8QiAGa0dJQ/UJJ+HTF2
	Iys9rqVHSAcvYmzA/WLNd9sXGb8zdjVvn2nNeXY9QPHBmJKbCEk8XopkYsn94k7FneLjWwXScLS
	LewACYpJyfIea9YZabZH6AUE4s2QlUyMFc6voTNRKHKnz4z9Qpx4YU55ohABmw9Ky3QAfl5NX+c
	rBkdz/Zcrg/zeY5Ljbm4f4yv8EvNnffPpoDSI9XWfx3DODo7cPjPZxSFtSSZLLTUe0S17ixXtsp
	zMR7grkdfQFvj3bXitL8QTXwbNF0mdNUj9Scd7KTthWboEsz6LSqN12v71kK+xx9Hu9LWbLcp2C
	VA1mQz4tWJptphaOywwTDGnVJecUTuuZoY4cDmoIET9blfxYiNSHH6a0pT0yMS02gt2dok0Y7FY
	Z8=
X-Received: by 2002:a17:903:2290:b0:2d6:ffa1:429b with SMTP id d9443c01a7336-2daec62c280mr119641375ad.7.1788405425604;
        Wed, 02 Sep 2026 20:17:05 -0700 (PDT)
Received: from localhost.localdomain ([240e:b8f:1df9:a600:c693:b19f:ada0:748])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe62d1d1sm2831855ad.24.2026.09.02.20.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:17:04 -0700 (PDT)
From: Vernon Yang <vernon2gm@gmail.com>
To: tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	akpm@linux-foundation.org,
	david@kernel.org
Cc: hpa@zytor.com,
	rmclure@linux.ibm.com,
	andrew+kernel@donnellan.id.au,
	pasha.tatashin@soleen.com,
	kas@kernel.org,
	tj@kernel.org,
	rppt@kernel.org,
	rick.p.edgecombe@intel.com,
	yu-cheng.yu@intel.com,
	orsonpeters@gmail.com,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-mm@kvack.org,
	Vernon Yang <yanglincheng@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] x86/mm: Fix pmd_modify() dropping the dirty bit
Date: Thu,  3 Sep 2026 11:16:08 +0800
Message-ID: <20260903031608.1194238-1-vernon2gm@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vernon Yang <yanglincheng@kylinos.cn>

pmd_modify() masks the old value with (_HPAGE_CHG_MASK & ~_PAGE_DIRTY),
silently discarding the hardware dirty bit.  The subsequent
pmd_mksaveddirty() call is supposed to transfer _PAGE_DIRTY into
_PAGE_SAVED_DIRTY when write-protecting, but the dirty bit was already
stripped from the value, so there is nothing left to transfer.

Contrast with pte_modify(), which keeps _PAGE_DIRTY_BITS in its mask,
and pud_modify(), which keeps _HPAGE_CHG_MASK untouched: pmd_modify()
is the odd one out.  Any pmd_modify() on a writable, dirty PMD loses
the dirty state.

One visible consequence is data loss with MADV_FREE on PMD-mapped THP:

    memset(buf, 0x5A, size);          // PMD-mapped THP, PMD dirty
    madvise(buf, size, MADV_FREE);    // PMD cleaned but left writable,
                                      // folio marked lazyfree
    memset(buf, 0x5A, size);          // hardware sets _PAGE_DIRTY again
    mprotect(buf, size, PROT_READ);   // pmd_modify() drops the dirty bit
    mprotect(buf, size, PROT_READ|PROT_WRITE);
    // ... memory pressure ...

Reclaim (e.g. under memcg pressure) then finds the lazyfree folio with
no dirty bit set anywhere and frees it in
__discard_anon_folio_pmd_locked(), even though the data was rewritten
after MADV_FREE; subsequent reads fault in fresh zero pages.  NUMA
hinting alone can trigger the same loss, as do_huge_pmd_numa_page()
restores the PMD through pmd_modify() as well.

PMD-mapped file THPs are affected too: mprotect()/NUMA hinting dropping
the dirty bit means rewritten data is never written back.

Fix it by keeping _PAGE_DIRTY in the preserved mask, exactly like
pte_modify() and pud_modify() do.  The existing
pmd_mksaveddirty()/pmd_clear_saveddirty() pair then performs the
hardware-dirty <-> saved-dirty transition based on the write bit,
preserving the shadow-stack encoding rules.

Closes: https://lore.kernel.org/r/CAJxLxMUGu1-L+O_nAONOwOXnS=cNbNApCWqdthRjd76LThtSPg@mail.gmail.com/
Fixes: bb3aadf7d446 ("x86/mm: Start actually marking _PAGE_SAVED_DIRTY")
Cc: stable@vger.kernel.org
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
---
 arch/x86/include/asm/pgtable.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index d5f4917c1edc..d551120a7c88 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -806,7 +806,7 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
 	pmdval_t val = pmd_val(pmd), oldval = val;
 	pmd_t pmd_result;
 
-	val &= (_HPAGE_CHG_MASK & ~_PAGE_DIRTY);
+	val &= _HPAGE_CHG_MASK;
 	val |= check_pgprot(newprot) & ~_HPAGE_CHG_MASK;
 	val = flip_protnone_guard(oldval, val, PHYSICAL_PMD_PAGE_MASK);
 
-- 
2.53.0

