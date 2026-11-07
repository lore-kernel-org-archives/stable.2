Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018558;
	b=ZF9DbaoP0ra0lzZWvEodTyGgdGC5uHqZPjpuw+YNfrgDFUsSmni8xj77y04phg6MezCi
	 RSjb86CngmyJh81oilsPuWxvppmvvekH1R94ZE7asXDEMijYSLzGyvva6FeMuJTiYf1nw
	 ZE00x0avYbs4l/TJvbe84dThUDeYwEhxHIwLLIZM/LorUKkY+e8CPmgakSQgTHkIL+yu/
	 Hvlo0HKKqOHMJoqqkBHUifr9NPmxHAT8RzAsDTIDiRNnRXjcWtCM1DXqIahtO/9+RNpsu
	 oQny2Bf9twBOhPUfoM+2j98VaQnuu3wW5GZzXgND1AeBx6C9H7FoCShFc6bG32cpUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NQXpLd3G80J/dmpcLqjd+RdJWhUp5qcgTvnxnG9ug9I=;
	b=3I/KBnWdc49rrcLk3nrx+kJzHCsuBgTtCr1hsZbEHLhc4j5fCgR+HuW0vCyPjbDpvLX9
	 amssRgWryaHwOYLFAKpRmSCNgVevIz2zu4kAJO5aghN3tMfBOikNvYjWM9qoLan4qyRJ9
	 YGji4n8wMT4sAclwxhczrNhIUH8wo/YpjsuOOVBMX8XWCMtVfoF192g9iEsrWSXwW7Dpp
	 +n5Tc1/tI29RtQLRDemgCRCBuVX95f5vmWQHvuzxyHlQrE8YfNLJso0N1XLCjr1x4E+iK
	 YdVkaFs3/NHU/Bds/L2T7kg5lV6N8LITwDL8RX46NL0JEOUMkqNcAsXZq1F6OxUPKAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b="Hv/gbKSz";
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08075606A333
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 02:29:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 08075606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Hv/gbKSz
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso2049918eec.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 18:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794018557; x=1794623357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NQXpLd3G80J/dmpcLqjd+RdJWhUp5qcgTvnxnG9ug9I=;
        b=Hv/gbKSz/ftIDOEtIkiFWg0RDYwGA3nNLsTF3VxBJug1HdaXrjmOBxKB2omceRrLpL
         RsW6fw+In/lT7WbO3sXFtKKbiPkqqNcN/OtJS5f4P6kJQuRzLdTjexpbJg9oI2uzPHhq
         zRViPcuSQwruAeFu9SL5g5545lKYg0cAxul5rhTc4DVzyAIUVzxTHnIYlSm/itJ5xj1E
         T4vsfuaqqw5EQMPsO+goEZRKQ+FZRbMwsW3Iyt0k5YQZnWwj7SLRa0o+rAbk3Uletiq7
         jUzkRvvz1Pa9dFH753ndANtmhJxVvbKmkPsqvgxUhrDlAU4+6JqVn7YZbgUIHxJnaEOW
         MPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794018557; x=1794623357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NQXpLd3G80J/dmpcLqjd+RdJWhUp5qcgTvnxnG9ug9I=;
        b=pwL21/vp46Xas9/BnLu+QJRnRUkeDPlgjqsHUFFkD7kXF+3aY8qR/TDHgL4ycDpKOI
         UhVcI713SsUOYtdkVqblEqlEvJHpa+XcEPxyasfhb3pn3D3dTI5DOrNiUFbN75waHtmJ
         9pk9xhx76ZjaHLHk+nBoKiesAgBHVeyPNNYzDMAGpmud3G62yyEKFRYj6ZhHwGtUiO2q
         eb3IawdQjuvy0T0Z8fMAJyh04rwbArRBmANKHgcYy2NOSocKXXiRh8m12b8w5kTxmKWL
         ys63J4Udp3qlYt4ihOQ4R2PnZFP1vOTOh241YL5KnNNYGyn2sOUYpaB44sZLwaZoIoPb
         uPlw==
X-Forwarded-Encrypted: i=1; AL+hErHgSxHfxCR+t9uBGX01WVtIkbyqX8Edj5kJTkjQHWwKZQVLs67YF/K+TNVTPo+aFkd4xmKvX6U=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wxkZroEUB01PNw4kjGsuswY4D7siCDRJizq3PLt7MLZDJhzLT
	DjO41DAX0wHmclcrFle7fnEESpBUj287kCVT86oTBqNvjWQ27uBK+KG/IDiVMIsuQCE=
X-Gm-Gg: AYBFou0AxoW8e0R7FILpE5KXjJQt+O9YjghXtJLsk2m04RIGpB353jbVOnU7ScBop25
	9aBYABY3qP4xiD2acfbrVc+qy1vrZ+T1RaPYVEeqdVWhPWJR3jCsjplguTpjNkobWFq/zCvVTim
	H/SJWlnkN/xj2YuXVO7cjIXvAhqHZLajSnkzpPcaArLV41K8LInYQ7jOoiYKlM04tT3/1nvg3qc
	+IhTzBIZEeyD6s4qYKV5X/R5x2XbjXmZsirrdXwqzTKvqB/UkY1PEePF6Mv7eUm6AFkiRzJuuKC
	0GN0z5qLiylEEb6XCpjsL33yTGErmys9dbJeBebEouWfBRL1YqhhE6T0BsBkyakjERmXABtDMuL
	EkiehAvL7mK+iAj9TstX8YMk+kOGMp0k7kfLlK7ogDCSuJQ5yIAKbSrakS0GUfrhGJMTCaSvRrj
	LlhS0zA6JRBtKMqOd/shhU3zW4EdReoqw84mE2wegDDrjNV6MxAwZUjOFNvcJ0DWZNIghIPb7Yf
	jCE+4bwhBYmTD1vYUxAsyF3zcszN+2tAE2d8JQf8R0Oa/twjhPTfEo5qc2ce7FR1SnRBR0P7rSH
	u1s5jIOOupuDHD92kp+TPv3Al8qhJ/2hK9C2Jd+OZcC9PCDgH/VV5FNdBz2E
X-Received: by 2002:a05:7301:dc2:b0:35e:5ca:e0df with SMTP id 5a478bee46e88-36f76b18abcmr6279268eec.35.1794018556813;
        Fri, 06 Nov 2026 18:29:16 -0800 (PST)
Received: from G6L4RL2QG9 ([2409:8a00:1832:6900:c8de:13da:804b:a0fa])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36faa4b8aacsm10457077eec.23.2026.11.06.18.29.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 18:29:15 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>
Cc: Qi Zheng <qi.zheng@linux.dev>,
	Lance Yang <lance.yang@linux.dev>,
	James Houghton <jthoughton@google.com>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Yili Zhang <zhangyili01@baidu.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 01/13] mm: hugetlb_vmemmap: fix OOM during head page allocation
Date: Sat,  7 Nov 2026 10:27:44 +0800
Message-ID: <20261107022756.77731-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261107022756.77731-1-songmuchun@bytedance.com>
References: <20261107022756.77731-1-songmuchun@bytedance.com>
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

From: Yili Zhang <zhangyili01@baidu.com>

The head page used during HugeTLB vmemmap optimization is allocated with
a bare GFP_KERNEL mask. When boot-time hugepage allocation drains free
memory, parallel optimization workers can enter OOM handling before
userspace exists, leaving the kernel with no killable process and causing
a panic.

hugetlb_pages_alloc_boot_node() invokes HVO on the folios accumulated so
far when available memory reaches zero, allowing the released vmemmap pages
to support further hugepage allocations. If allocating the HVO head page
returns -ENOMEM, the bulk HVO path frees any vmemmap pages it has already
accumulated and retries, while callers can continue with an unoptimized
folio if the retry still fails. Therefore, neither an allocation warning
nor OOM handling helps this best-effort allocation. Use GFP_KERNEL |
__GFP_NOWARN | __GFP_RETRY_MAYFAIL to allow reclaim retries while avoiding
both.

Fixes: c0b495b91a47 ("mm/hugetlb: refactor code around vmemmap_walk")
Cc: stable@vger.kernel.org
Signed-off-by: Yili Zhang <zhangyili01@baidu.com>
Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
v4:
- Split this patch out from patch 4.
- After splitting it out, the resulting change was almost identical to the
  patch at:
  https://lore.kernel.org/r/20261104133938.50974-1-zhangyili01@baidu.com/
  Retain the author of that patch and only rework the subject and commit
  message.
---
 mm/hugetlb_vmemmap.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index b8ce014ba6e6..7fcc97b12773 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -501,6 +501,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 {
 	unsigned long vmemmap_start, vmemmap_end;
 	struct page *vmemmap_head, *vmemmap_tail;
+	gfp_t gfp_mask = GFP_KERNEL | __GFP_NOWARN | __GFP_RETRY_MAYFAIL;
 	int nid, ret = 0;
 
 	VM_WARN_ON_ONCE_FOLIO(!folio_test_hugetlb(folio), folio);
@@ -527,7 +528,7 @@ static int __hugetlb_vmemmap_optimize_folio(const struct hstate *h,
 	 */
 	folio_set_hugetlb_vmemmap_optimized(folio);
 
-	vmemmap_head = alloc_pages_node(nid, GFP_KERNEL, 0);
+	vmemmap_head = alloc_pages_node(nid, gfp_mask, 0);
 	if (!vmemmap_head) {
 		ret = -ENOMEM;
 		goto out;
-- 
2.54.0

