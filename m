Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A8C44F57A
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 12:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792326750; cv=none; b=IBJ/84LOPofqofGG7+c5kMHe/VDrU4m1EPLDfjQ1SzxL8s/MqaSuhtMLzHIj8pBrmEYsG6d/9m6DrnHKUjSy4alDA97zX9GtRvAThHryD83tJXF18fd4RHmLjpSNyB/KW7U29PTzbZd4PRIbnDJTRXS1oXpYsoe5m+JIj3Cp25U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792326750; c=relaxed/simple;
	bh=fv7Rai3TL8fpTZTkYTwFZrQz5aegp7PoVLZ58XPsOgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tRQOM44zsyPuUluz/stCBg7nAw62LrMgJDVNLfVDcsmJdR+AGp9jwJcDaRdaj9Bk8yv4Pwa8x0Q7t8i+x1J3HLYhXVqPenIcx26G7Fa4RFOO0uQxGW4sj9UEnk8u2dOmDxDYPeRvsy/QzLZXRWd0GNOGeptqEbcODfAL70vGITk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlRWDRQv; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlRWDRQv"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-15354aa70e8so837741c88.1
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 05:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792326748; x=1792931548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FHebQQxZTBF8VhHuKubJ7Ol2fYKgzc9t878DoxD9tRs=;
        b=KlRWDRQvog3IYbz2SyhEMUQ+8z7ZSwn9LtZ3mxI+NJlDXsJQN9/laVGgqArZdrPtR1
         uEjLE+L/JG0PyS7kadqlWj0tvT3mGBSWdRjQirSd0J4qx9zJTl1TeA5+eEFBuzzT8T0q
         PWwSLubndUOSf9s/kNh+n6KtB9Ni2jckqVRSLMhKrzlkIEi0As3koqTqG1iUo7WxLmY0
         YEChkykP6a751zkXF1sEpAlNlbyX03Qiru+99248WD8v+VPMG3/5U2O1Ln4rx/3QhFks
         SrRMh9lLCCSlaDaiPXi7RFLTc1sP3e0NtpZMZ/TDSnd9mhDg6S/YM8w9Xd2fFvzFqjpX
         i/ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792326748; x=1792931548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FHebQQxZTBF8VhHuKubJ7Ol2fYKgzc9t878DoxD9tRs=;
        b=oOXPUOI/7yAgFjDDuZzJjWGdWeqi0NPucQkILNpZqvHjXljDZnd4KvPs76iRu1fKKG
         2mWS6lhjeAwUlqcOUQBJ2DKvjue667miRJ53d311DWsdhoPG9BAejAxXaEkDI9pNAWGZ
         l6CmSvYVREJzZS2sYu2Kome/zXsQE/gXy75UOIPbnSxcSkc3S6ifAEnNyn8oLRuUHnEJ
         GTBULhBIhPnQYyfmZ/Q54LanoujyUIWFoInWFs7NNtmo6e7ZzLQKpZ0grYxxBx9gzJsw
         aXVHwwCLj54MXhN01v8LUNCiW5TJfMOTWinMubux+3ZL0q8PZqDUECTBDCGtToqMRGHv
         kQ/g==
X-Forwarded-Encrypted: i=1; AKwUvBzg+SqQwTQDaXZFrzk8TFLltjKY9tEjjlFZk4lmeFAWLViD9gS+PMF2fBlKqDd4CdS+W5LtVSY=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCYAUMYT+HY6SxvWLuEqt+1OpteNi55K1atI8Yz8CEZZhkLbXR
	sGIM0LoSdAiC/bo1iiyyCiUh0Z22alqKpI94cVOllOwN3VbkacgRtfNH
X-Gm-Gg: AYBFou2hRY9jEnCCb9Eg9BSgx7/YrTzrIwWciPIpcvWqdyfwp6ldSVWZAC/wBGgNjV1
	HBsRAl42fj5QVVcqK2hszRcVXUmVDqZ+EiltYcaLSmIpfU54fDxm4azAr2rQHbX0eBcYl9PCwL8
	YUGcTecDN7Jvgp615M5AvDe4MakJPnzf0FeKm2QnyL91nlgxttyoH+I2XzGbCvdgKHqyu//u5oC
	HPBM4keH8aFNzvjEwh9fJuRd1hW0J2krn1SbvTyk7qBcrkMDjUfvpr+t0b4Fdz7w4JB3E0YDF1Q
	vaSXOhAx267WbhCNMSObm92AiW0oIDRoScZX6DV19LM/ndT9h5ipICBs1lraj2my+M8El9/MdTF
	DLjpfQNIXjTouj/FC0UWHJfOHr36NGJxeK6e4hgbOM7QnxJs++1bqiCLVV+TnYKIWSB/DB6dnus
	2Y3J2cMEVXnGsu1vCUtZHVH93c3iXe+fKH+cwk9FyWqky+Dt07XIl+Blcn0PT54RSAz/6iShocP
	9LNehORAVdSLWeXB2XfUC8OZQO1/ZJDfJAMKXNThTmfxQIZgb0ro94J
X-Received: by 2002:a05:7022:294:20b0:189:f7f6:38f3 with SMTP id a92af1059eb24-189f7f63acemr518737c88.13.1792326747918;
        Sun, 18 Oct 2026 05:32:27 -0700 (PDT)
Received: from 1u1g-b650-0212.nvidia.com ([72.25.70.131])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831ba424a6sm20953055c88.17.2026.10.18.05.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 05:32:27 -0700 (PDT)
From: Samarth Narang <samarth.colleges@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>
Cc: Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Samarth Narang <samarth.colleges@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mm/ksm: keep soft-dirty and uffd-wp when merging a page
Date: Sun, 18 Oct 2026 05:29:56 -0700
Message-ID: <20261018122957.526467-1-samarth.colleges@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty and uffd bits of the PTE it replaces are lost. Due to this, a
write before the merge no longer shows as soft-dirty, the next write to
a uffd-wp page raises no write-protect fault, and because the page is
mapped with the VMA's normal permissions, on a uffd-rwp VMA the next
access raises no RWP fault.

Copy the soft-dirty and uffd bits from the original PTE to the new PTE,
and restore PAGE_NONE for RWP VMAs, as try_to_map_unused_to_zeropage()
does.

Fixes: 292924b26024 ("userfaultfd: wp: apply _PAGE_UFFD_WP bit")
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Fixes: 763f43865fc4 ("mm: preserve RWP marker across PTE rewrites")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
---
 mm/ksm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index dbfb8f98b189..b0d0555aa1b5 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -34,6 +34,7 @@
 #include <linux/memory.h>
 #include <linux/mmu_notifier.h>
 #include <linux/swap.h>
+#include <linux/userfaultfd_k.h>
 #include <linux/ksm.h>
 #include <linux/hashtable.h>
 #include <linux/freezer.h>
@@ -1463,6 +1464,18 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/*
+	 * The old PTE may carry soft-dirty and uffd-wp state that tracks writes
+	 * to this address. Make sure to preserve these bits in the new PTE.
+	 * On a uffd-rwp VMA, also restore PAGE_NONE.
+	 */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+	if (pte_uffd(orig_pte))
+		newpte = pte_mkuffd(newpte);
+	if (pte_uffd(orig_pte) && userfaultfd_rwp(vma))
+		newpte = pte_modify(newpte, PAGE_NONE);
+
 	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
 	/*
 	 * No need to notify as we are replacing a read only page with another

base-commit: 48fe11c8d0f1e4e59426a3606f20ac1130b6d8dc
-- 
2.53.0

