Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737296;
	b=X05HrI08DAAN3Ouk4xeZ4TdTjJENqv7tdHvi6z8VgyIgjfrAgk6Siow2uY9UKMCscAZk
	 K1dtOZerTclByRbtkVdBB5fe9qDIgH3UgJLRCLjySqEQXWJ/vPnR3Hfm1M+uxVS9GUanp
	 B8Ir669v7RtwnyHosC4llneHN/GuuL/1Rs/y1f2an5eB4URc7EvYXQSK+yePz+qUhAxPJ
	 nXG4VM4Rb6K0DiUG4PL67WECEHfsuoT9etfsyShEluHEHbVux1nBLRTrZDWEXhG7CPya6
	 vYZMkZXv0Aor8Q/bB1dq8FMMunUIz4U+LsT/GKFgQptCnwvNcj+Gbhp1JNSnEcDVBKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737296;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6F9SSG+/FeDA6bw52vBp7L6cM7wcJHblW41owDWPkN0=;
	b=M15DI7ZDBETbm+GMcmopQN0C1fk6apxXVawOgrYapdNZc4rXFBVyqfW3se0Wh8VEuBGT
	 yjofRhTJBOmPbhBVIokr5GeRyFqf2X5NOvIoX5i5lSXFUQIvR6OByyKSEWo5qniU/kHYa
	 RU9zW3Sa0ZQVZG47MM1oMN923xoiqGaQ/F9dB4etxuTcDp1Vunv3qqP+ck11u+iNL90rk
	 Tz6QWtPg9Yjrie9vn7jJgljIKAmBpB4yek6AInwL7pIyzJSnY/NOEpCke/DFg5EmYcBjX
	 M2Sl3taE1ERLf4nm0t4Pl4w/c1hLjjB4+IqmnFZZRRFS43euMeKrFOqM2PwSKYySozg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S6UphPG+;
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45C2606A31B
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 06:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D45C2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=S6UphPG+
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cd623dfe420so400898a12.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 23:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1792737295; x=1793342095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6F9SSG+/FeDA6bw52vBp7L6cM7wcJHblW41owDWPkN0=;
        b=S6UphPG+rRft9PJK9LNUZxfkqKKdBYGxMdEU19sUyV8HeZ/ImIX25itKyinkC02Uou
         0y6k0QqWX2M3bYEEIe8kKa8n2Qus54XCueOawO2ET/KsBA1iznnIdXGFKJVjogW6t1ZD
         e9aaun4U7YIIeou0+NInUXRIp5wSU3d6jk+yPJpx0M7luC62QcyIC/1cHeq52c7/+Fih
         zln6TnPTfPhSjBbXU8IZy050hDS4R42R8IGjVvWixUHRqeLAAfLFTzdsEj19kwfgU1Gn
         7EQ+59idWYC1ZHB4VcX73UhSyQn2yxXfi2SWvDoIAZu4xHQCrlz3iJS+p0UFlco/wmUQ
         0Hdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792737295; x=1793342095;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6F9SSG+/FeDA6bw52vBp7L6cM7wcJHblW41owDWPkN0=;
        b=i2Fs7qrNYOHz3A7RNXi6Wrc0mvj6dCLHk4utVd9ZgLRPaguWG/9eVDUm6KjBevugFG
         Gt9ycODTjvX/24udNBf6A9gIzG52aPlpCweCCQ4IeTYtiJO9pXyZJlLCjMUVvKolUJrJ
         46d1VmSNcyYNiZDDWxZ6T7i3LHGj1z2RLLicgG5hv39eT2q0J3uE71Knrb9teiRrVnuV
         hjJtxPwpEUMfZb8m8piol6YHtNFA7y+sprVn8897XD+yix1NIfSisiUbJepKhwSaLVlz
         WsviCGiLP0RJRrImml/HDoBeNp7g5Bgp2CKabKiHq1syhBRsPFjMRVf8RBg+w5ME/iz/
         w9Yg==
X-Forwarded-Encrypted: i=1; AKwUvBznXdLuHKfuhfZhQQPkvAbvFefV9O/e3CrYnW+mQbcIyIf/UfHhMFPWCw/IdiD5p/rEDH8V6sc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLNYbzSnIMu8/64O1u7dcUKtsk27uYKV01HawWDUeqJOCYS0hjM
	jD+GGDSM5AA81ngXJBgSOIFHKahEHCLvCpe85RPvfs82YQzl745refMF+z2rRJVvB90=
X-Gm-Gg: AYBFou0pAtWA0GZEC05lmIAT47E6nMBOYsmGOJN2u14/6ARvMcVvCg2mS9OvKW37ZVM
	HaGzjn6FwhZ53JFSzqxbfWJ3kF/GjmylhzL+BriLI3xzIsjZLkX3QKFXfiTUfxm6gAE9MNTnSx+
	+KA5LtGUfv3DmzVRGfQBXsXPPhfOcu8eQnLqMD0d2ylW+UFiG76vNY8K4E0eu9qYQlNB7ai44rY
	Y1VZNT8lsDV5mb8T4fjP04TOtAvZYKrYP8x1jlgOuAx69wDUuED4H+oEzmOW2+aPcOa5FbiltqB
	SLG/S9UAKR/vS5GC6ZrL2ukYdyNhsry7AS5Owz7aUN3E0oIM7y4u7xndiCu6mXlaF7/aJhalogz
	Ro4+YlAuLEJyGAxrH4Vak18l+sg7uQhmWKOsm5gHfdUsdlX2Ms0al4Umhi9ueGzfcB3UymMMNRd
	oN8CSlTxr2wWRv/SVDY45OlMzjX8PpU821noTF3lWQpkii31OQUbh3Jcok6rO3nPDFzqAQtRNlT
	piXT6Gc6mU2qZ+Nxxx+o9/0+WpBNT3nnZceUIPECxcHAl4W5qYkUJcUNkyWOphQoFibeghXcoqq
	qA==
X-Received: by 2002:a17:90b:5487:b0:3ac:d79f:8229 with SMTP id 98e67ed59e1d1-3adce1737eamr1157717a91.61.1792737295119;
        Thu, 22 Oct 2026 23:34:55 -0700 (PDT)
Received: from n232-176-004.byted.org ([36.110.163.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3add246f308sm575202a91.0.2026.10.22.23.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 23:34:54 -0700 (PDT)
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
Subject: [PATCH v3 3/4] riscv/mm: fix missing destructor for hotplug PUD tables
Date: Fri, 23 Oct 2026 14:34:27 +0800
Message-ID: <20261023063428.3658761-4-songmuchun@bytedance.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel
pgtable alloc") made alloc_pud_late() run the PUD page-table constructor.
However, free_pud_table() still frees non-reserved PUD tables directly
without decrementing NR_PAGETABLE.

Free PUD tables through the common free_pgtable_page() helper so that
constructor-backed tables run the matching destructor before being
freed.

Fixes: 8472cc4503eb ("riscv: mm: call PUD/P4D ctor in special kernel pgtable alloc")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Björn Töpel <bjorn@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
---
v3:
- Collect Reviewed-by from Björn Töpel and Kevin Brodsky

v2:
- Collect Acked-by from David Hildenbrand
---
 arch/riscv/mm/init.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index e111d25e18e1..f35fe4cda89c 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -1537,10 +1537,7 @@ static void __meminit free_pud_table(pud_t *pud_start, p4d_t *p4d)
 			return;
 	}
 
-	if (PageReserved(page))
-		free_reserved_page(page);
-	else
-		__free_pages(page, 0);
+	free_pgtable_page(page);
 	p4d_clear(p4d);
 }
 
-- 
2.54.0

