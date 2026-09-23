Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781E052B1FE
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 14:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174216; cv=none; b=p9OqHAd9bhK0KLjzG1KgjDe+EQ5kQznyMamUVCztajMOl9JSa741CjEprHafBK8z7T4tUOCvRK0lMJJv6tpaWrDbmGxV0I/Fvbe3M/7heVmCKzrpJScvxcXsPvd0tkqSgl5MbkW3ZTkgiigfdvX7R1oGJEh9Z00Ji1V8xFr70vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174216; c=relaxed/simple;
	bh=OyiV9rMkvu1Jy8aWRg6sMe/+zI3reMyCNwVjzvrPocA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AzNPrFpBK7WxW5LU4xLNNiwy+ArzsqJibMbUVf61Oj/+dxE9VoO8X1JqoMg9wCcTfShZpTXYbQpKWA5tyCsd6GPay69JaMcey1dYYnedXuuwhDc1DAqLvpF+Veymy7b0A77uuSwChay6LjKhrnrkoVbV1IY3LOConHYs24e41fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAFTfHZr; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAFTfHZr"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd4ba9f68so11493515e9.1
        for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174214; x=1790779014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/jXk2YYyHPMkVqRrGY/FRmIlGWuOA8HLRzHk1PaDVE=;
        b=qAFTfHZrBWnXuPhScadcMExR/tZ+yMMwWx8RudH1EKMfqNsNt52GYOhPKZDqFGb5FN
         ka16ZDyXTDuZ2ZLXgmU3WQCdcAVBd5s9vWWls5f6phDgoCJ3XbWLtUQKqHmtIkhMBW0h
         w2eOEOV0jcUzZR9aDc1Dm7+anqoird+2bh/q+kHsCLIOhBMzZ0vz4fB6YM6R+XFdjQD+
         5b7W3layKrN7HLG1zD3Yx7HDTYQ9elquhXLcCPimq47s6yM2tRafwh0C5/3mXRLYMCVZ
         OmyNHJYEiEBNAzL9dRtQjsiX4s/bfzt0rMHjOiB115ReQRxnNQZ6Ruh/LMsCHYD6iFI2
         RmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174214; x=1790779014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/jXk2YYyHPMkVqRrGY/FRmIlGWuOA8HLRzHk1PaDVE=;
        b=EqdihUHV6lG6SuiTPfv7ZzhRwTTm20vWW1EMi0e5a4G5lkGPmI0CarCHskzi7OBa5n
         mi+3rT1bXEW92XH/gDujrffSEc2dA8Mwkx+62adKM7QgTdSBiwWQW4WiNNfPecXx9LcL
         vrp3U0IRnmBY/N1l3j6YhVQa96q9cUmm0abCpWs+ejlDqZsk62QtpeGKmGHPxW/SiG1p
         5A7vNdYWaPCCiBUQCs9lY85SD/wJxPZHDLf8lQH7E+jLSWkN6aiy9J1ETGwAhV696chA
         VVeujaHIE8AW84lEPwe/2JDcL9y02KtcCU6l+74znusm7wTuKQuZfAGFaU0QAuYAj5q5
         HhPA==
X-Forwarded-Encrypted: i=1; AKwUvByodYlk9mCcPLg2pmC94DeR17UBZIc3t1Yl4Jz1ySrxAo1EwXfHJ9v1n5LYcxcVd50XfvsG6Hg=@vger.kernel.org
X-Gm-Message-State: AFuF++nK1bLH1XCgzYPeN0uB4ZfCweq3LuBj50jCeg6YN4toA1jKRlOy
	es1YpMFTn9PVFT6YDxSTa9d41a1jC0HR7k63DTatZdxwMbXolO7/lReQ1fllwS5wG2A=
X-Gm-Gg: AYBFou1hPP9RZx4np97sW60ZnrwAk8M7twb/2CKzTk3pOw5806yxMZ7XaI9xkfb0iDr
	3K/x1SXfgYQk9TrrTzAsETGtXkDl+DQIT1NCUxMOi9qXYrfLW4pkuuAPv60KMRn9Aw941HLKk8v
	alymmYEka25rc7b2GuIvv2FU/kWVNToR6uiTTInY70sJKEYknJIuY729DX7Yw+cd2I031X8XQEw
	byy7UwPUezi8dE8nZROznh9dvji2Gv//U9XmpfMJnbj/6FDn4mXFFDtlgDUCjP3rnUJw7Pp81M/
	4oxreMJmfzCN9MYalkC6LteeThRlR1kHBtpmab3+HQ0nhdM+XZA9/hu4J9WlMdjykLnNC+9lSu7
	pRZfiy339KAeWIXtb3Z1bzg2fLy/USqGrF3a6OyHYrUXY+74dDrETACdcsWYw7ebQB93YVn/iUD
	7XBATj5ii1WDAjAB6vbEURqqmB/wncVtfWsMN1vO4LFmLyuOPCoTfPZi4eV4KHqCpM3bZxaPee6
	2kmJFXx8keeRDTYm5mHjFTFc0hPm5Y/dK7QshwIpzfz
X-Received: by 2002:a05:600c:c493:b0:49d:15f8:2bdb with SMTP id 5b1f17b1804b1-49fdee0a968mr39819935e9.7.1790174213402;
        Wed, 23 Sep 2026 07:36:53 -0700 (PDT)
Received: from andreayoga.wind3.hub ([31.189.116.68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1aca52sm81960045e9.14.2026.09.23.07.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:36:52 -0700 (PDT)
From: Andrea Parri <parri.andrea@gmail.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dev Jain <dev.jain@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] arm64: mm: Fix the break-before-make flush range for erratum 2645198
Date: Wed, 23 Sep 2026 16:36:32 +0200
Message-ID: <20260923143636.89480-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

modify_prot_start_ptes() performs the break-before-make TLB invalidation
required by erratum 2645198 with __flush_tlb_range(), whose third
argument is the end address of the range.  It passes nr * PAGE_SIZE
instead of addr + nr * PAGE_SIZE, so __do_flush_tlb_range() computes the
page count as (nr * PAGE_SIZE - addr) >> PAGE_SHIFT.

For addr > nr * PAGE_SIZE that subtraction underflows, the page count
exceeds the batching limit and the flush degenerates to flush_tlb_mm(),
so a single-page mprotect broadcasts an ASID-wide invalidation and a
full-range mmu notifier call.

For addr <= nr * PAGE_SIZE only [addr, nr * PAGE_SIZE) is invalidated,
and when the cleared batch starts below nr * PAGE_SIZE the tail is left
in the TLB.  The workaround then no longer covers the whole batch, and
for addr == nr * PAGE_SIZE the flush is empty.

On affected Cortex-A715 CPUs, this can corrupt ESR_ELx and FAR_ELx on the
next instruction abort caused by a permission fault.

Pass addr + nr * PAGE_SIZE as the end address.

Fixes: 7efa1cd5f89b5 ("arm64: add batched versions of ptep_modify_prot_start/commit")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 arch/arm64/mm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5dc..d4384131e10d8 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -2295,7 +2295,7 @@ pte_t modify_prot_start_ptes(struct vm_area_struct *vma, unsigned long addr,
 		 * in cases where cpu is affected with errata #2645198.
 		 */
 		if (pte_accessible(vma->vm_mm, pte) && pte_user_exec(pte))
-			__flush_tlb_range(vma, addr, nr * PAGE_SIZE,
+			__flush_tlb_range(vma, addr, addr + nr * PAGE_SIZE,
 					  PAGE_SIZE, 3, TLBF_NOWALKCACHE);
 	}
 
-- 
2.53.0

