Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737302;
	b=xDNUOLTJG2nENKSDg1LZd/RVdluLLFjKj4nB98Bgsfwf/rh5JtjvQHEfnyWzkNKA6vbV
	 t/hgYHQX34q6nmpBzagRzrBx4tfr0e0idxWM0KJY3kKk1JTPnEI4jbRAoD7U4ekWoBGc7
	 A+AdDM9pt1/IlzBBn+htb3gWCaMtle8uR6qyA9OVH6zXjuzpufodZpIteNpQF/da2WoIK
	 9PxqNtSoBOXYlknJkm0W5Asmj8Ptg+naZVU1pVoVkapUuVLRwAaEAPn9CZB8PrDLvtPqN
	 65gse8mgx4AebM4aCNcdbCd2/U8H+xbT5b49PoyBtpWx/npD0ASSlqwyhQsuk1zG45g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737302;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dMWdlBhmxnvLIraZEDjRljS62kPMNDcGFS9KF9CUDaQ=;
	b=42h/pFyjYyNt8KhAnj3JxGzzTigV5GDHVmUAZmmaYcVdYPVHOhO5VtmRonwKVJIT/V4c
	 XLJvWz7qvVtukGag9pdaiEsg+3hfkPNONbm7i5FBhe0AiKuQ5OwQ0Sv/q+IbRfIVqAIil
	 3tGSvnK0XZ/hHKa3LePOQ12GGO27OvbsPVSzZOmYmSALMdGB2lLZmp/oc6bUyNHVoGLR5
	 EPXB92MNnNVkcSJoFZRzY5HU3jVbKHRBBkjxY+vBGDvU48Rsqaiw7+6NLUyQEdtBQRIvF
	 p4isFj9IbX1xy9LCFSL7YthhBv8IXJHP61lzcJw76dUBlruQ5Z6D6ZYEl8BaytLNUwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ku2pLXJJ;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3F606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75E3F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Ku2pLXJJ
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so404694a91.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792737302; x=1793342102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dMWdlBhmxnvLIraZEDjRljS62kPMNDcGFS9KF9CUDaQ=;
        b=Ku2pLXJJTB6Zbs+NAq8GQMT6NZtgy8bqAwhorT2SwgAsDjm/fP4v6M5oYY6buP8sa5
         bSNwZarC75XpX9/yINlNZIUJ/ubLIiZNwfrAMTE2uU5UT/CMToxEcpIk5n+DWF1R1ZfD
         dJ9SUPM0xznR+yqwMJFmz9x+3ywJZxJHfSY7gyVyrX2uMvNv+jiNQUv0QjIfAvwaVKgY
         LCdUkDQMrNPVq7MoqUA9ghP2ai3vOb9QtyaOGegksLcH5qlEM9YqkFzMWV0KQ6RT9lxj
         lb0AdRjLCx7wRMAjPwYGMtujdE63DNdmqryoeTwPdkMBrC/I/X0h90aHROBoPUm0vtTn
         7ZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737302; x=1793342102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dMWdlBhmxnvLIraZEDjRljS62kPMNDcGFS9KF9CUDaQ=;
        b=eXhRaUw32c8IxUx+zMemT9OGnqRZhzEoLyNjayqMWFA3GDyQWDEeCkN4nN6dKBMc+J
         9CpeMLK+FNuaGfjG3/sQq6K0Y4D0hwEcifzBQZhgyx9uqwoiYqSyOeoMBSy1SKdSYjH1
         onKQIfn7ir/dW88ffbec7M2VvBtEbwIC4lns+jrUR1YIHwm1cijua4St85FlSxpqNv/h
         nmuboRlNe3QDc7ETgb/flTy/KeY+mroGtbb4vcKZu4UabUAy89OxxyuaZw0UeKGZ1YSp
         vbQpy370Cc3qg6mCvJUa81gXHpTiF1ox+r7eHaijPY/mL/dhEgsKVSntZMPJ40n/DgRp
         /Ucg==
X-Forwarded-Encrypted: i=1; AKwUvBwtsVVG4740UNghAggBAn9cPEBIln12ydZ4iLitEOdxJzDJo+ZVhDtfcHgNe0LpNhs97ycMeOE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKaIwDR1xNgUdJ+rZIfvNWHlosWmrUNq+yxDYagiycWGRAUHrkP
	4QNFAiJM8A4u390gc3mdgrXeg2fh6ns7Smz0vPyKcXHzOluxeB+3lJzWlVVcBYiZjLI=
X-Gm-Gg: AYBFou1LoJ9sUji1cV7k83/jCt2K0L6cfWvGBiMdYY/jSp+lmXMEmROxe5qxB5EXE3v
	lDDCS+E76jZwDeq9iEb5CvGvLclOGiJqzzHI0UfsaUMix9G4b9vXN7X5z10ehlMNlWUh1VkALd+
	tbVvTaQo6bKsW2vrzzV/Z/FGxtfLJH/Ipnm+myRAskP+J8j9yM3u/qxy2qQJX2G5Y1OdsVTQX2V
	/KLenk4mHWtnW3BKUakIOqUs7YlMsVmyb7pKYO+zbOgsP5J9uF2COmuMtO5W9GlPlWoQb2Gou/6
	xGPHKGl0kuB9BVYV2KjnWWzX7dYH4u1InEZ3Dx+iEvyfoZPXztnp/GxQ2e2YGNzDviv6F921WHL
	XtOplKK4HSp6FrpNGiEe1c5vTrP8Tj7eKtXW7oRKp7fg3R8flfLVUsm4nMrw639jdp+NflrMVvH
	YFQvl3IkKtwCL4S6/TRjAbt9tvctLSpj1xNc8QMQhvM1hpSVjfKk+uaXuk+mt1hiwJEZB7teTn1
	tTJQBl/DyeYw5SVbEJ/+fRrC8z48SqqYpC/i4bjUtzhZnMEq9YuJcurjEfrlTGsAaHQSVnJp8gn
	7+pfDHrWurhSZpTgsy6Ll1g=
X-Received: by 2002:a17:90b:33cc:b0:3ac:7556:8eec with SMTP id 98e67ed59e1d1-3adce0ce647mr1174819a91.39.1792737301360;
        Thu, 22 Oct 2026 23:35:01 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm575202a91.0.2026.10.22.23.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:35:00 -0700 (PDT)
From: Muchun Song <songmuchun@bytedance.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
	Oscar Salvador <osalvador@suse.de>,
	Dave Hansen <dave.hansen@intel.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Kevin Brodsky <kevin.brodsky@arm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/4] arm64/mm: fix destructor for unconstructed hotplug page tables
Date: Fri, 23 Oct 2026 14:34:28 +0800
Message-ID: <20261023063428.3658761-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261023063428.3658761-1-songmuchun@bytedance.com>
References: <20261023063428.3658761-1-songmuchun@bytedance.com>
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

Commit c594b83457cc ("arm64: mm: call pagetable dtor when freeing
hot-removed page tables") made free_hotplug_pgtable_page()
unconditionally run the page-table destructor. This matches page tables
allocated by the arm64 mapping code, which runs the corresponding
constructors.

However, arm64 also uses the generic sparse-vmemmap population code.
Runtime intermediate page tables allocated by that code do not run a
page-table constructor. Freeing one during memory hot-remove therefore
runs a destructor without a matching constructor and corrupts
NR_PAGETABLE accounting.

Free intermediate page-table pages through pagetable_free(). It runs the
destructor only for constructor-backed pages and then releases the page
through the page-table freeing path.

Fixes: c594b83457cc ("arm64: mm: call pagetable dtor when freeing hot-removed page tables")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
- Collect Acked-by from David Hildenbrand
- Collect Reviewed-by from Kevin Brodsky

v2:
- Free intermediate tables through pagetable_free() (suggested by David
  Hildenbrand)
- Update the commit message for the page-table freeing path
---
 arch/arm64/mm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 79d90226fd5d..4dce8fa227c3 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -1495,8 +1495,7 @@ static void free_hotplug_page_range(struct page *page, size_t size,
 
 static void free_hotplug_pgtable_page(struct page *page)
 {
-	pagetable_dtor(page_ptdesc(page));
-	free_hotplug_page_range(page, PAGE_SIZE, NULL);
+	pagetable_free(page_ptdesc(page));
 }
 
 static bool pgtable_range_aligned(unsigned long start, unsigned long end,
-- 
2.54.0

