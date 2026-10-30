Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381015;
	b=set7UH/60I0/xISGj3lGyT4IpXo0Ekys0lDy8Q3GUSDHfkRYRGR3GYetSdIgLJBwThqr
	 LOhFXzKLKA8WbFZEfxjDNsbPv0XQ8AHi0M7/0EmZvcakuTF+et4OtNVphRfQVQpIg4Nj0
	 LzocJVfSL0qxdLr/wze5M18G+hG+SlnqPPNFDq0ERrQXJCFVQltBtAOKhgWCwPTvz+7PB
	 j53+hZcOdPWMMw22SdsohDKTzLvr9D7PDRGLZGnwg9jprpPntVRnUhTSXt9ATb+avJB/Y
	 e+gU7b27xl94kfbEUNuClB5ioeJvoxevd9osK1wLLrBDezxEf70kl0J67aQ8lIlwyoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381015;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=zmpmCNUnxZltA0RrJz+fEFjfdRhaWWv/gMnrq/ZBymM=;
	b=cWpdf27py4sWMq9cTCPpKt94BueqxDWS1dEmaZL8TuxMuAvievZg4KsfXdxOisu4KZND
	 8P5OBYOIpWi7S2fa//hnCDX9WS3cXPIqH39L3hTUpumAd1jMVeTsIDB340ClMBcj55+hN
	 5mCwl2Z+jlr606nltiLTnzPLjG/XtPffEvQZDASpVrzi5LE76sdVUnkDcQ++5naG/vOfq
	 jTnZLOoGwSWNvIzfWa4vlZiRNA0O14N6io5DHE4A1buK9idksQ48AzO/L8Y51/stDfDpT
	 tQ4CS15m+boMDCMrw7g09M4frleJwVUxO60AjwzZptuczw4sBEFe7Q4w7Pl42Jg/B2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=b2S+Vh4S;
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6039606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 17:23:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6039606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=b2S+Vh4S
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd61cef87f1so446989a12.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793381014; x=1793985814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zmpmCNUnxZltA0RrJz+fEFjfdRhaWWv/gMnrq/ZBymM=;
        b=uMKL6szfP3XkulwxiA+tZmhizrYhfZTW37HvX7YMQYdS0LPb2G2abYeltSpdh7loMw
         qiWkBSqrXQxsrzblpWE4xDnrBujN02NQIPpnJScPhz01T6cnVfGUGRToPlMwGQSAjd3j
         8AYQz9vS7ERRJN8aJNAabpcGsSbnlMBat5qrYTVQZZ6PLT5j0BoPdinepxqtpYZjdfYV
         BrTb8Qu8pwHBdETM51RvXvl6jenEtdd9dbp2zZdNrwmEfymSMPAOK8EYsAYBXseAQf/1
         lQmBQji2iGmrUmIx9A9jGtEy438L014kyV+/QQe8jDoLiZsgTHvbXYvVWoQavRJP/gUf
         hHTA==
X-Gm-Message-State: AFq9FYKgylhPbmjJd+w7cfG3dHfvtIvTVRLMfMQJg8rNUpmbm7cy2ym8
	8dFNHhlyJQvJk+5SPeN3on8bszDC2rl54+QeX8kKtuMEaN+ISD8V4+QF4Mbxt7xJK4SjiBne04F
	/4u6tZWZUCuWyqC+xciuKss7suCK3K1B7mKSDszgRdfjAKgh1uZJ3Xn1mmHvGirk1tdPx6+KSVH
	mqSwoKMtiDH6ZLeqaEet7KsWqa51R5PP78eNVvNXKEcoJ1NlKr0adzxY0gxqfuoYKi6x1543DXZ
	/nkq8JxcXg+eBZXg0E=
X-Gm-Gg: AYBFou09uHt9xSS/eXv38XK5USr5gSxsMPPowrjcDQNeiqOUwVAiq0u3tD3AQf6k9kR
	r6BjYp072nnOsYbxQStRkyloF7tvB0XcAy4flTKJH4Sq6pBj8SqzLi+TVM46GY3q/TJ29PyVMDh
	lXn8VCd/t0nJr0q4i9mB0UWBSDdHyhgDu0w6p1Ei1tY48EX8DH4QKZcTpjWQ8dykKcuwsE/KFBy
	XfLXjN4xno+iObDshbgICt9KV27clkbLryMBKcEEnFy3BwvQB8ygLntfJO0DOzN3CxhaINNrjH3
	CMn8lP+iI1FdJ4A73TIXy+daIdel9sVYcWJ8xrcgNsIIJfJPVUDgUoAjzj1aaIp56vHaZ26UJFC
	0WW1gteRk6As3EE6z8dBr8KsdABrZNAHqhwjoLLgKv/GXaF8xd6KUPyIJj5/fMoDr/tCbRK80Sw
	MGxMpce7vKbHjVBV4qwIrN3TT5dciE6A2R3LvGKqit
X-Received: by 2002:a17:90b:3887:b0:3a0:d265:3647 with SMTP id 98e67ed59e1d1-3ae89573dbfmr2301471a91.8.1793381014182;
        Fri, 30 Oct 2026 10:23:34 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ae6e88749csm4442159a91.7.2026.10.30.10.23.33
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Oct 2026 10:23:34 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-1aa0fb7f157so1473423c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793381012; x=1793985812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zmpmCNUnxZltA0RrJz+fEFjfdRhaWWv/gMnrq/ZBymM=;
        b=b2S+Vh4SNXeNm7+NQ346tQX6SB/OAXcHXzmZ4J1D/suceGxfK39hLU9ALkT/qKyYBY
         Lb9kQoXLYRQJ2iV9yfSApWh1c+FAxKtLXq/c68sv0a4tMO/dYB2s7xn+jJqeo0rHI3Xy
         Q8JlnyDaJohI6chDqnzN1Yiwh/XX9Z3qmBmSA=
X-Received: by 2002:a05:7022:ea46:20b0:144:c128:4c4d with SMTP id a92af1059eb24-1ac5da76f4cmr4112855c88.38.1793381011708;
        Fri, 30 Oct 2026 10:23:31 -0700 (PDT)
X-Received: by 2002:a05:7022:ea46:20b0:144:c128:4c4d with SMTP id a92af1059eb24-1ac5da76f4cmr4112794c88.38.1793381010859;
        Fri, 30 Oct 2026 10:23:30 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcf67csm8463406c88.21.2026.10.30.10.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 10:23:30 -0700 (PDT)
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
Subject: [PATCH stable 6.1] mm: move 'mmap_min_addr' logic from callers into vm_unmapped_area()
Date: Fri, 30 Oct 2026 10:22:16 -0700
Message-Id: <20261030172216.368052-4-florian.fainelli@broadcom.com>
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
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/s390/mm/hugetlbpage.c |  2 +-
 arch/s390/mm/mmap.c        |  2 +-
 fs/hugetlbfs/inode.c       |  2 +-
 mm/mmap.c                  | 19 +++++++++++++------
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 33ef6790114a..d646d81ead5b 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -273,7 +273,7 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = current->mm->mmap_base;
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 3327c47bc181..fc9a7dc26c5e 100644
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
index 3faad73c74ab..a7b6a97543b7 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -219,7 +219,7 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
 	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
 	info.align_offset = 0;
diff --git a/mm/mmap.c b/mm/mmap.c
index 1eb86aba7de5..17ec4d40edc1 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1598,7 +1598,8 @@ static inline int accountable_mapping(struct file *file, vm_flags_t vm_flags)
  */
 static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap, low_limit;
+	unsigned long length, gap;
+	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
@@ -1609,8 +1610,11 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
 		return -ENOMEM;
 
 	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
+	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area(&mas, low_limit, info->high_limit - 1, length))
+	if (mas_empty_area(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.index;
@@ -1646,7 +1650,8 @@ static unsigned long unmapped_area(struct vm_unmapped_area_info *info)
  */
 static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 {
-	unsigned long length, gap, high_limit, gap_end;
+	unsigned long length, gap, gap_end;
+	unsigned long low_limit, high_limit;
 	struct vm_area_struct *tmp;
 
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
@@ -1655,10 +1660,12 @@ static unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info)
 	if (length < info->length)
 		return -ENOMEM;
 
+	low_limit = info->low_limit;
+	if (low_limit < mmap_min_addr)
+		low_limit = mmap_min_addr;
 	high_limit = info->high_limit;
 retry:
-	if (mas_empty_area_rev(&mas, info->low_limit, high_limit - 1,
-				length))
+	if (mas_empty_area_rev(&mas, low_limit, high_limit - 1, length))
 		return -ENOMEM;
 
 	gap = mas.last + 1 - info->length;
@@ -1793,7 +1800,7 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
+	info.low_limit = PAGE_SIZE;
 	info.high_limit = arch_get_mmap_base(addr, mm->mmap_base);
 	info.align_mask = 0;
 	info.align_offset = 0;
