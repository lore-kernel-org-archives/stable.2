Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616096;
	b=rTfa3Hg6NRVeof+AMLS14e1zz4U6ehCjXPHqdARYdxLGLhsDG3O8TO6VcvElzUkTcFUq
	 LRIwnRPcfRNcI+MALI/jV7JT6mVLXPT4tf7gEkSShe1Lo77uRbUAqOdyvIHzvRpCS0zJG
	 UIRQw3txnQDJbqOmbRMfb0/CcfZ537OmfbU6BtNrDpF4Ibea+dlBOf8o8iofDoQtwDw7+
	 f8pMrDibHHjbjTOWe1dMei1LNULo147DXEgjf9WkZpIkadQT6Tmht7ug7pJ8NYWNbZtSi
	 Jsd2cnuVu4HR9oB6ohWktCEPDTfCOlDP9wNHS3udUFAQh+O7kv4Smc4q66uY6YT29UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=w4LlOPP020au30EZIDHlk1alCgqnzjFeQiEleoj/jqY=;
	b=cnEZEILawKNGTAYgmVDDL13OXxkbeMOaq4AMfe/akk/yQ62TKMnFdD2IiRWSHUSAeZIh
	 fDsYsxY421kFypyh/lggZwdSk4v/55/xBvln0BieR8aiIxgbg/bjyM42RGvcWSaFZM3SH
	 L6N+gcfqWvJEJEpR8ctS0mvtg3cg1Y11HyBEwH21ueoGCAyGG/ZFug4NNJ6QSFSue83Dk
	 SumwEgE12jDPTNGMm4sfFxpIbXFqnq0mIqtDaweaHYjpwVMBaEzdBG8/MkBQXoRwIXxHz
	 23FPrbcA+ypTuvZ38Sv2XQ4fsMow5As0XCgs6S0Iu7kDhgK+QbT25Ahusv8fKOZ3C9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDmiOFg9;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB6760A3808
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:41:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4AB6760A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDmiOFg9
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e940d5d2beso10315715ad.0
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 02:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616095; x=1794220895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w4LlOPP020au30EZIDHlk1alCgqnzjFeQiEleoj/jqY=;
        b=HDmiOFg9LmWC1qeIeOmdtC0BdN5SaLCKolsBcI4ZZdNKTGn0LHthir7vWVd1xjBdol
         o7pODJQWwOqFNCJKbr5oTsGtSkAhzdjOhsiKKq8KZsiudWLjYot3nJ1iGFMuVOti6Vm+
         AolaRGT33An/VO1zqH7BFHx2RleU5szmO3vL1BFJ2dSpmOzf7QrQ4pLH2Gu/BgmKyzGJ
         XHrykPkhekEYSgCv5VVgO2W9u2fhCbD/rslgsXGoyVOiNxw2QHj6cYCezWEy2KEwdZCX
         Rkg5iHHTT8Xfhmbps7DNrcTeAZd/Ap4dhBcGCrS3R0pMmg0c4Y+ZJqt7E48lLOv3dsbA
         pqmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616095; x=1794220895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w4LlOPP020au30EZIDHlk1alCgqnzjFeQiEleoj/jqY=;
        b=K/H6I+BIqFHdUoWSj3qILdR6IwZbgpZ898+NG6xZO6jzrT/3LozTKZyscwuo8ZTJ0e
         XFhiErUrOQenugWly5F0GVzpIsq14JHTxAmfwXEY3LMHrbVSr7I+6G74JDxLFxbrX0mh
         xoCuGWtHXvkYFYmGPz/4jGDpF5X38xTpnw7o/CrovDTH7jyzI7UMl4TKLQKl/Bnp32u0
         8Oq/ajA6MuxEZFxEIu0mmCi/TVtf+lhDJzUZ07rnJLN31MWYxSMEh18vAPUf4yYZSMXQ
         v0Yo1tlJFU1WFjtHTL1BHZybArc3QXqwo0ZVSXG/V3DMRPl/gecGsMyVl7FNKt0xU8Qm
         +c2g==
X-Forwarded-Encrypted: i=1; AKwUvBw7MJb9Pvni+0fAnvihRdlxbmXVqaD6meVLfLO0WlvOnkxX50DA8hMTbgM+QrnxJxiRc14vfJ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Wo9H4oKh75Px1VWbqNi+ED/qMhESU+dRXNQ23iWypcIqj5YoH
	2Rvn8Nl0HHmWdOXyZ04cAMfhFXe7rnfsPFQsxy25dNUjm6FU9U23/LO0
X-Gm-Gg: AYBFou1UpxtFM5odUsnaHYmvKUnwragE8UCjlF/kIS04R3wD6dY9K5bZY4TZ9FuQ/21
	BFv7tdekXA6ElmjOGR/mMbPjF5GCxXQKV3PM/kfCQAIgAU2oRTp/jamC7l4qr7h6cHtPzX3jVXC
	2OQxtSIJV3+zXBBtLcHGJegRofjiPL0KB+oO1gih1Qk0jmrw1NVOknbRUJwYrzop0I28OG2i6bX
	XtSosCGx3wmmNbtFSU7rk8xazZO6D6PqywHmzL/a4/EaBmdlEKcAxzQx9Lh+ZgMkvMq9W30lEai
	pv2OWHCLRF/Eq3xHHFas3jhGW/ccCUOCxOR3iLZ/nEaz7/t5SppeXHQ6T/pDtiImrOVBQeQc/7h
	pCxtExjF2UmMJyPJ2JVrBEwCkcUMDqjOyq8z6LllJ2pe2OG5pqkav0Khvk3N2l509V5uWstFaoi
	7n/GRmb2F4gK1JXCzfW5eEuL4Z7AB+7WL6AmMggD4cb+hUqqAEWH2aNinIkl8VjrFEq8NFusVaM
	1HheXbl/qCp98e11T5UzhusHNWT4BfvhrgQ7Bhf0nW1w/SISaqLXEGpjWoiikvcvbkaje+aoxd1
	WmXDbRcpQEYRFKWqkOTfUvb5alQllg+y/vAbfLit3oHEAhBZlx6m
X-Received: by 2002:a17:903:3bd0:b0:2e9:f354:e97f with SMTP id d9443c01a7336-2eb36482f5cmr79668765ad.60.1793616094571;
        Mon, 02 Nov 2026 02:41:34 -0800 (PST)
Received: from umang-Inspiron-3501 ([2401:4900:1f3a:7c59:eeec:de7d:b077:9b9f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb3925ff38sm25195465ad.36.2026.11.02.02.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:41:34 -0800 (PST)
From: Umang Pokhriyal <umangpokhriyall@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Peter Xu <peterx@redhat.com>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Umang Pokhriyal <umangpokhriyall@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] userfaultfd: validate the whole range before changing write protection
Date: Mon,  2 Nov 2026 16:06:20 +0530
Message-ID: <20261102103621.156928-2-umangpokhriyall@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102103621.156928-1-umangpokhriyall@gmail.com>
References: <20261102103621.156928-1-umangpokhriyall@gmail.com>
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

mwriteprotect_range() checks each VMA as it walks the range.  When a later
VMA is not registered for write protection, or is a hugetlb VMA the range
is not aligned to, the call fails after the earlier VMAs were already
changed.  When unprotecting, userfaultfd_writeprotect() then skips
wake_userfault(), so threads blocked on those pages are not woken although
the pages are writable again.

An unprivileged process can trigger this with a range that spans an
unregistered VMA.  It hasn't been seen in practice; it was found while
reviewing the userfaultfd range ioctls with an LLM.

Validate the whole range first, as mrwprotect_range() already does.

Fixes: a1b92a3f1498 ("mm/userfaultfd: support WP on multiple VMAs")
Cc: stable@vger.kernel.org
Signed-off-by: Umang Pokhriyal <umangpokhriyall@gmail.com>
---
 mm/userfaultfd.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 87da92526..b8a9d9574 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1105,21 +1105,31 @@ static int mwriteprotect_range(struct userfaultfd_ctx *ctx, unsigned long start,
 	if (atomic_read(&ctx->mmap_changing))
 		goto out_unlock;
 
+	/*
+	 * Validate every spanned VMA before changing any of them, so an
+	 * invalid range is rejected without changing part of it.
+	 */
 	err = -ENOENT;
 	for_each_vma_range(vmi, dst_vma, end) {
-
 		if (!userfaultfd_wp(dst_vma)) {
 			err = -ENOENT;
-			break;
+			goto out_unlock;
 		}
 
 		if (vma_is_hugetlb(dst_vma)) {
-			err = -EINVAL;
 			page_mask = vma_kernel_pagesize(dst_vma) - 1;
-			if ((start & page_mask) || (len & page_mask))
-				break;
+			if ((start & page_mask) || (len & page_mask)) {
+				err = -EINVAL;
+				goto out_unlock;
+			}
 		}
+		err = 0;
+	}
+	if (err)
+		goto out_unlock;
 
+	vma_iter_set(&vmi, start);
+	for_each_vma_range(vmi, dst_vma, end) {
 		_start = max(dst_vma->vm_start, start);
 		_end = min(dst_vma->vm_end, end);
 
-- 
2.53.0

