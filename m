Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381013;
	b=W9k3/ySK6CpQspS+ThxKh0Q7Xrw3N8557J0pQi92kWTQrLAufxlIDMss1+1rx81X9o1q
	 gO8DG+VX+Ti7Cp1EmE78Xqj+Yt9JTIBtQaYezfIVjsaURf+jxBv70CiptlT3eQSj3MGmh
	 lVv4c1rkgltiORCi8VhoZl1t/uFCL5273gwl5yuTmvIJAA3S2TU1XGGgvoyk53avW3gXj
	 8EQqiKWHEEmUZtVvr8i8SSjyz3ADTDBTAuhtTNr0pbfZuaP/WaT3U2dTitFfDGC3W08dN
	 le6UYQP/x6T79WyiYTwNaShQlHFHsJQfelbXxXE++aqoaYPzq1wtN2GJdsmqmpCxbOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381013;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=A/s8CVJR0YF5mgHtNd3A3LZYKxjpwFNKk2F6XF60RQU=;
	b=B2hMtIuZKZCCODXa6Q9mn+d6qUOWqDfdsGvtFu92PZggdW5NR8RaR9Q/5QNqCc3yi4On
	 9CPiOjmlWwO6NGk+y1z4DMNu8uWy8Nc915cOMq5wloJw8xNLqijEOmemzEPUCBlM+6ZwH
	 ZFdoLOs/uBCaK02Us75qpB49JO0uV2Xh7fKQt6LUY5+LKhZxE4wKI+vGmMRnUXkrnDQGg
	 6nWtM/iIT5OKLUxArR0tNiuw6Cp0chDGmexsZ+2sQhucoGQKfxzfE+hZhBPKRdN2PfNWA
	 ai+R7LTNaWaZP04cEGDC0N/gHCLKr8vw3tgf8z+kQB8NWVgufA25fkiTqQa4EvQEFhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CC4+Ted9;
	arc=none smtp.remote-ip=209.85.222.98
Received: from mail-ua1-f98.google.com (mail-ua1-f98.google.com [209.85.222.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB62606A323
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB62606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=CC4+Ted9
Received: by mail-ua1-f98.google.com with SMTP id a1e0cc1a2514c-98c6e050c5dso531914241.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381012; x=1793985812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A/s8CVJR0YF5mgHtNd3A3LZYKxjpwFNKk2F6XF60RQU=;
        b=y85Z6cvCeNSqn4J1pwG9gAGMe/LGcFxBXYo3iOrELvB6n37cFNYF3XWOS1eMnrLbrR
         VTJ85+IXkfyuciNQTWPefWS6hlOrVH/fSJtAIYlabkJZXOt5US4feCF2FzSQXDo2IsPu
         bKZegEWs130eb8CiZkKg95usQZMx442Yaz2bwJCpd9+WiZUL7bY6zr0b9vf9rRMH2wxH
         ah92MeI7JK8R016v2cmWPWFWHy0yu6/+/7z4LuF8KBzezDerqWdA7XDRllSF8EK14nnc
         CLH9Xm0Ww3PYFsuosH9QQMHWtjX3qfXGcDHySgKoDpcrKLkhLrXAdxgAnz2ylPrOOhi8
         tYJg==
X-Gm-Message-State: AFq9FYLVyVpKdshOU/CFPApguZ4YMXQ8zoPwr7nrwCCOpE4b+/oKj7EI
	3xGz1iUvYWZIJMuoepESkNhHnIuhHnKzuNB/+u3JoPl8w4XenUovGIHGmgIT67gdx41lH/0UAcm
	AkWAAChSdTVWwa1yusbPy8QXYoEen/AgYHwSnxgmpgfOzugeNP1kaO1++BiGtr9RZOeh/oi0WCJ
	ryucE0JLf1zoFb5TAYkFK3pvCbuTHYTSiVIiZqWQLWKnDbBNT/D2sKg3e7a7YTk2vW1QtG5LQWu
	Sug/f0BtO2B3k1r23k=
X-Gm-Gg: AYBFou0jgziWesrBR2uiabQ/7Zqf5EUFfwi/adnI9YDvzcny0rQYm6v5zQFWhrLn6TE
	XdPoupPMD5pldn5tFslz0TvJntgnril+wgwrkdzrtFUFdnxX+zbUlh+R1K2ZkdoEipFJwJ+E/ek
	X+jvugQ2pkC4By8aX3Aa0XrNjkXPLaqwl+VsUKv8MdBOBhB/SJrweFCJ2P8JcdWILOU9Qx2aB3y
	d2cMAtjgbt390s0omtum/wcGdP+vU1hbveUXqAo38Kc8X/vVhh1cJJ3um+oL9RUvpVu7icA7RDi
	bcnP3Hl0eIVWqonFf72op/XljjmVQpMrmmGyGMEekJOkbJC3uiXkQRnvJnkJ8fWKG3eBc4w0bwO
	aVlAxyHv23LBCdsoMiFVtopshz4tfESzfMQ2vRv+z5XjQgqYS4vLJKXlD5uqGWVyeP32mB1jzh8
	kJBBGacN3MFFvo1JJjqnnQUSmITDydnCG1Kg97k8xL
X-Received: by 2002:a05:6102:fa0:b0:7c1:62d2:e18a with SMTP id ada2fe7eead31-7d072c32882mr1634540137.16.1793381011639;
        Fri, 30 Oct 2026 10:23:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-992ee51544asm99842241.19.2026.10.30.10.23.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:23:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-1a2af4c8cbaso445997c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793381010; x=1793985810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/s8CVJR0YF5mgHtNd3A3LZYKxjpwFNKk2F6XF60RQU=;
        b=CC4+Ted9wwC7R5EASduSiWWX31LOfND5aT3Wk0Xi2Zm4CicgsCO4/5gzZj04GGwMQo
         F6VD4cdlwmgvsFHDsbY4f6C/GbIYYpwoappOB6+dRgMXJmwlczwNJgkOjZq1ScwVARYk
         yuE1x/9hqx3Pv0xgFtiIoimWIcjhOfarmmMcw=
X-Received: by 2002:a05:7023:903:b0:17f:7280:1332 with SMTP id a92af1059eb24-1ac5c92f6e4mr4286494c88.40.1793381009222;
        Fri, 30 Oct 2026 10:23:29 -0700 (PDT)
X-Received: by 2002:a05:7023:903:b0:17f:7280:1332 with SMTP id a92af1059eb24-1ac5c92f6e4mr4286388c88.40.1793381007744;
        Fri, 30 Oct 2026 10:23:27 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm8463406c88.21.2026.10.30.10.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:23:26 -0700 (PDT)
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
Subject: [PATCH stable 5.10] mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()
Date: Fri, 30 Oct 2026 10:22:14 -0700
Message-Id: <20261030172216.368052-2-florian.fainelli@broadcom.com>
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
index 0ca46f5d9438..96c04071a0d6 100644
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
index d2a3964daf70..0a5236d8d2db 100644
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
index f820bfbe5852..290822968e21 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1944,6 +1944,7 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long min_addr = max(info->low_limit, mmap_min_addr);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -1955,9 +1956,9 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 	high_limit = info->high_limit - length;
 
-	if (info->low_limit > high_limit)
+	if (min_addr > high_limit)
 		return -ENOMEM;
-	low_limit = info->low_limit + length;
+	low_limit = min_addr + length;
 
 	/* Check if rbtree root looks promising */
 	if (RB_EMPTY_ROOT(&mm->mm_rb))
@@ -2023,8 +2024,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 
 found:
 	/* We found a suitable gap. Clip it with the original low_limit. */
-	if (gap_start < info->low_limit)
-		gap_start = info->low_limit;
+	if (gap_start < min_addr)
+		gap_start = min_addr;
 
 	/* Adjust gap address to the desired alignment */
 	gap_start += (info->align_offset - gap_start) & info->align_mask;
@@ -2039,6 +2040,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	unsigned long length, low_limit, high_limit, gap_start, gap_end;
+	unsigned long min_addr = max(info->low_limit, mmap_min_addr);
 
 	/* Adjust search length to account for worst case alignment overhead */
 	length = info->length + info->align_mask;
@@ -2054,9 +2056,9 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 	high_limit = gap_end - length;
 
-	if (info->low_limit > high_limit)
+	if (min_addr > high_limit)
 		return -ENOMEM;
-	low_limit = info->low_limit + length;
+	low_limit = min_addr + length;
 
 	/* Check highest gap, which does not precede any rbtree node */
 	gap_start = mm->highest_vm_end;
@@ -2128,7 +2130,7 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	gap_end -= info->length;
 	gap_end -= (gap_end - info->align_offset) & info->align_mask;
 
-	VM_BUG_ON(gap_end < info->low_limit);
+	VM_BUG_ON(gap_end < min_addr);
 	VM_BUG_ON(gap_end < gap_start);
 	return gap_end;
 }
@@ -2235,7 +2237,7 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
 	info.align_offset = 0;
