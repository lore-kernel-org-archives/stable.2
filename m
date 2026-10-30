Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.99
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381015;
	b=YMp+gmTQbsPr+5WGwPggvtlBTG+G2CpxRAnkhcb8u8c2KNQvvLKQCN1BfzxkarFKWgSc
	 gojXzT9HSz38jOtx10+zFvVeBd20zqbz/4U7ycVNm1lmLRIIyMQQ3ZpBt3qGxlNJ4Drum
	 I3WAavrCjhnj/L6/UZnInmtf7bkx2dO1gFNJT1aRU4fFGIlN2YE++HzEtLWczKfO6dMnQ
	 LdTcHuEsqEgqn9zS50WbTBidLSEBUVqzM0fVQmPLZVGfl2vynyi+h+tHp43m26lDTFQ2I
	 ugsNlhH8XBesrkBHokDdiKUWUjwkIrkD7kjh88OzKIajaxklGx/sZfuGuabBYLTs4LA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381015;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=q/Q9JkBadsgG41NDSYMszyxdI8yHLcwep1flIBRRZUQ=;
	b=dS1LYFdXXCS65DdNLinrPc4h7APP+L4AUkprFpcL8bO1F9K4qkx8ab52x7dCn3iutvn+
	 d2lvH5D4F+o3yvzRFEk0o5m4PlGfSBLSR5uj4wQfhUEc7SxqidFGriGSeqINZohSvP9yl
	 SKkmItwz8kcKHJ2NIg8v0Gi4PzqUI4uFpfwwEW38I2E2cG9ZgA2clDlizyFxbnFNMxssY
	 IjMqjGM/s3Oog1tYfD8mOrqJ8qs9+6wTdvDiOM85WF1lLzSEtxgGX+QjKx8LqfArR3qsS
	 MQAoQ83ZWhc9e5Bk29l0vCPg4GYKDfW9F3A+yKFoYGJ9yR3DPiqJzzuqnxOp9DSMeSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pg31d73H;
	arc=none smtp.remote-ip=209.85.219.99
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97095606A31A
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97095606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Pg31d73H
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-91c11468b5fso10369226d6.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381013; x=1793985813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=q/Q9JkBadsgG41NDSYMszyxdI8yHLcwep1flIBRRZUQ=;
        b=l8gBPSv6Pit6MsfKkr6+DQtjGEnCzRW4lnwiekhNMmWimlWPQtgofTGlem25IIZfRb
         gDUXAdMIDvnRoqJVHLnKUMDNo0lzh+1Kxbd4whDsPvwdsY9YPwExpIbldeClnMeTTT1u
         iSltTjYqcmzj2E49Ug77e1L4slVZ87oZL5H2H78fWhIw+mNjrng5zJMZIn0ywuuODFU+
         uNA/aMuMKzcjmXo6zCzBbSACaYd9cyoksYI44ypqPBtWpn8I5BOk/Y2Gzjt28t60bA34
         i5i/AT+LwIqv6pEXOVFxZ1Fzj24Gnj8LjQsEeIofU8P//GLlY4uU3O6QVR6ecJFbspFf
         elcA==
X-Gm-Message-State: AFq9FYLaXz67NMFwXmSwRpgwHRIfYSKU8ZCV7T6/nA3bREOC8cPmSxEP
	dwA5sJX4540/X8r7QjUAc1mvsfUK9pJ30aVY+nruFpCM6fQigBaPYdtr6DfL+tEoa07OIAtvnZ8
	gNtbcBJUWqLJTi8ByJCEUMRp/JIS4BY9Is02Q7DWR6+Badu+kPuxK99Mp5Ypy5z/5IWVwW0Z1rN
	5YzZsDU/NToEeriWQj4SseLU35ijHjXVxZjMaKlJo8m9qHs1QjSfHcvYRBezVqurxUEODIPx6ij
	A0rfSe+9rF25S9zckA=
X-Gm-Gg: AYBFou3mghapdG3g10ocoZNhBHv6uNe30BaioXlO9rvdZq8XwgljT9rxjipKtgS6/el
	CxoHSyHYIlzMvHkK3fSsSkG4sffZ7+H1vW0BWtBljK9V60plSBDKOYm9ptQwdhr5DOLq87OwAlq
	F9SUiIGIf7Dk5u8opFQtzDxmcfrW5/0bZgtAyRVGawWAetqFnNGHwxT7SYlYo1KEigX6ca5IpvL
	jQuw1dOhGU0sMKY0w1fbVE9Wv3YzYLvaFdPBwJHKHisYMJmwDBosCOEBoFlHCwBJRuyPIHLJSgb
	xQrnCtSKIQHpT26tDdyJyMkzRd+XvIv6wDx2YkUdi3FlN99B/QFoOZZqpvfNTwvrl5dDUyF463R
	R8+ZyTbNFWBzVnDxm5JAgr43PyUKyy7EsQa4v6ObpLB0YJ1KxHO8jL1LdPYED06EZZ2IPsFY3Wx
	caIJ4S94l+kYIfH9Q7HcMY54+FI382cTx3LaikS97D
X-Received: by 2002:ad4:5768:0:b0:91c:7460:6ebd with SMTP id 6a1803df08f44-91ca4b4d445mr43783086d6.36.1793381013298;
        Fri, 30 Oct 2026 10:23:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-91ca804abcasm300596d6.33.2026.10.30.10.23.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:23:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-189d17eca17so765080c88.1
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793381012; x=1793985812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q/Q9JkBadsgG41NDSYMszyxdI8yHLcwep1flIBRRZUQ=;
        b=Pg31d73HWunu1kW3CTgo8MEZm1s0LfWCaLQt386p1g72d4JX5UqsYHUL5LnFBN4bOH
         x3UMP/AWoS9O/88KN0Xm+TcJf7JwL6I3TP+jP6eXq0Exm1QUWPkSIlhySi8nPqNYQvp3
         N9Qe5jMLyNq7/nEbFUAaqBsPNtvvzl6qKvRdg=
X-Received: by 2002:a05:701b:230e:b0:151:2e62:fe4b with SMTP id a92af1059eb24-1ac5bda8579mr3875031c88.23.1793381010477;
        Fri, 30 Oct 2026 10:23:30 -0700 (PDT)
X-Received: by 2002:a05:701b:230e:b0:151:2e62:fe4b with SMTP id a92af1059eb24-1ac5bda8579mr3874956c88.23.1793381009347;
        Fri, 30 Oct 2026 10:23:29 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm8463406c88.21.2026.10.30.10.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:23:28 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: stable@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Russell King <linux@armlinux.org.uk>,
	Liam Howlett <liam.howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-mm@kvack.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH stable 5.15] mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()
Date: Fri, 30 Oct 2026 10:22:15 -0700
Message-Id: <20261030172216.368052-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030172216.368052-1-florian.fainelli@broadcom.com>
References: <20261030172216.368052-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 6b008640db7355d8de6ac18f74cedd7ccc92684f upstream.

Instead of having callers care about the mmap_min_addr logic for the
lowest valid mapping address (and some of them getting it wrong), just
move the logic into vm_unmapped_area() itself.  One less thing for various
architecture cases (and generic helpers) to worry about.

We should really try to make much more of this be common code, but baby
steps..

Without this, vm_unmapped_area() could return an address below
mmap_min_addr (because some caller forgot about that).  That then causes
the mmap machinery to think it has found a workable address, but then
later security_mmap_addr(addr) is unhappy about it and the mmap() returns
with a nonsensical error (EPERM).

The proper action is to either return ENOMEM (if the virtual address space
is exhausted), or try to find another address (ie do a bottom-up search
for free addresses after the top-down one failed).

See commit 2afc745f3e30 ("mm: ensure get_unmapped_area() returns higher
address than mmap_min_addr"), which fixed this for one call site (the
generic arch_get_unmapped_area_topdown() fallback) but left other cases
alone.

Link: https://lkml.kernel.org/r/20230418214009.1142926-1-Liam.Howlett@oracle.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Liam Howlett <liam.howlett@oracle.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Adapted to the rbtree based unmapped_area() and unmapped_area_topdown()
  used before the maple tree conversion: clamp the lower search bound to
  mmap_min_addr there instead of in the maple tree search. ]
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/s390/mm/hugetlbpage.c |  2 +-
 arch/s390/mm/mmap.c        |  2 +-
 fs/hugetlbfs/inode.c       |  2 +-
 mm/mmap.c                  | 18 ++++++++++--------
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 8631307d3def..01aaf530ee7a 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -290,7 +290,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index e54f928503c5..1cb7ec9f9e6f 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -136,7 +136,7 @@ unsigned long arch_get_unmapped_area_topdown(struct file *filp, unsigned long ad
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = mm->mmap_base;
 	if (filp || (flags & MAP_SHARED))
 		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f663657c237f..b41e79f964d2 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -232,7 +232,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/mm/mmap.c b/mm/mmap.c
index 53fa4f5167dd..2c22f4bee04e 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1917,6 +1917,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long min_addr = max(info->low_limit, mmap_min_addr);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -1928,9 +1929,9 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 	high_limit = info->high_limit - length;
 
-	if (info->low_limit > high_limit)
+	if (min_addr > high_limit)
 		return -ENOMEM;
-	low_limit = info->low_limit + length;
+	low_limit = min_addr + length;
 
 	/* Check if rbtree root looks promising */
 	if (RB_EMPTY_ROOT(&mm->mm_rb))
@@ -1996,8 +1997,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 
 found:
 	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start = info->low_limit;
+	if (gap_start < min_addr)
+		gap_start = min_addr;
 
 	/* Adjust gap address to the desired alignment */
 	gap_start += (info->align_offset - gap_start) & info->align_mask;
@@ -2012,6 +2013,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long min_addr = max(info->low_limit, mmap_min_addr);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -2027,9 +2029,9 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 	high_limit = gap_end - length;
 
-	if (info->low_limit > high_limit)
+	if (min_addr > high_limit)
 		return -ENOMEM;
-	low_limit = info->low_limit + length;
+	low_limit = min_addr + length;
 
 	/* Check highest gap, which does not precede any rbtree node */
 	gap_start = mm->highest_vm_end;
@@ -2101,7 +2103,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	gap_end -= info->length;
 	gap_end -= (gap_end - info->align_offset) & info->align_mask;
 
-	VM_BUG_ON(gap_end < info->low_limit);
+	VM_BUG_ON(gap_end < min_addr);
 	VM_BUG_ON(gap_end < gap_start);
 	return gap_end;
 }
@@ -2208,7 +2210,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
 	info.align_offset = 0;
