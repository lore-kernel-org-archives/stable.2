Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794389889;
	b=TAHjCNhEX54XLIhYMzQgwzO+4ywJQMBIf6ifaOOgDNttj0m4WmtsAWxJvBYUOgMNJaLt
	 WM98ssVLtX6XPo51NbUlByX5Hnu6d562QJwlWImQ4chZuxOglQL/V1cFx5GJZj2kwBwef
	 Gppztee6wHsYrvrrEml9QiCGDOGeFHvtqZTGj49ydL6ymi97o/K2pUDnp7ViSpEIQCBrn
	 LEQGBG+rJ6OjKLXQywsRJpKkKhNO1dyMh2xlFarsUvBBCluWpG/tMDfg2ZA7igxpb/mJr
	 VDL3hEXPoxq2N1NXsDIkYZcXDjqTILahl/jIarEbS8kR5CzDXRYsrzCKWznoOdKDXww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794389889;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=nNJ7JQckRH+BEIq6xP+FgdYGraXKkj9NjALFdeEe068=;
	b=iNLgvb/bBNurjfMxfgr2uhOizSbdht3M1LzHhKpteySitwoVeeTGM0mKm61PtsP4WIoO
	 xOEBCAHWkg8sL6r2WjsS/ePTZDRpOZ4zI8lWcAn4gH9RyI/6sypSbNZiPREtaIHmj+OGj
	 j4dDazhbqHbjzle7yD3+bN6Wuidt2KOX/wwpW647Bz3RWHlp+bzXMTh3b/C5FI9j9W55Z
	 /LyES2cV9june5BI5hO6/qaGWiv7R8dtS8euILBxCJXwwgAW2A+pNHE+wi0vKaj7w4MM7
	 LkJyB24h8WPSuv8yMzAExLl7jMLmpAa6Mw/bBzIzB0CEA3i/p9aTFbxJZy3Bx+jTeHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Hp8TINu+;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A125606A338
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 09:38:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A125606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=Hp8TINu+
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3704d30b84fso3820559eec.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794389888; x=1794994688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nNJ7JQckRH+BEIq6xP+FgdYGraXKkj9NjALFdeEe068=;
        b=Hp8TINu+StVbWUF9STZfwLttRriFG4m/TTYAn77RmTP7oLZkquAPtP7LDofs0l6YaA
         mXPlO1+FE4H4/APt9LqPOS0nTpcaffuF2gWKMGdl3AfVowWkxWwy52ja0UhNR47UMD+Y
         4j40IXj6fEW45aK8lxNu1G/qBPELv/6Hno8gmS4aaanQb5hJaGZ4m4T6cPO54tLdpr0K
         VsBWhYE12WYodlVzWVPNWM5eoMXBgee/68IdlhFwMsn4fD9WhAhs6Hkpp69nM/2ImCoY
         kI9t8I/N1m32OIEnHE7hjkAHX7GsKZSJPJnve5ZY2Pif67LTxxy+heRKCrEHX3ZsqrxJ
         bY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794389888; x=1794994688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nNJ7JQckRH+BEIq6xP+FgdYGraXKkj9NjALFdeEe068=;
        b=D4kYgpgVbm96hzfXX4XJQBjSHRMD3V7h6C5velBzYL4djDlsghLhuInc6w1Cna+HcA
         DbwJepMq1GxtcBo77foxS2R/wnLoQNEx9znwqCzkVr4SUJhqKWPvgw78lA4ZXxyqwCy/
         ZwL3pVr+DFx+t1uoXmenre3lgSnRviQysKzw+fOTObvxt8HXnDO7JykKZajBCRpzqlsB
         SK1452EUHj/ghhNaYLZpo3tEdC/HPGnqyOqSyoRFwhWinrx08L4tIH7pxFgLyjow5CHm
         /j6lUlTuqQHEhR+L4/6ffle4UbqPBDwcMgrGHbSxFEsN7a6vZnm5ZZfi/GnjNRhBeMNA
         +zIg==
X-Forwarded-Encrypted: i=1; AL+hErFH2QY8+791efP2vsLF1M5NWkrs4t8bD5DfV9m/xUf3hXmj0t6meQmUE+qHF49C0L7lVX7wA+I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/nxmku6LBA2wrX8xqmW8NS/J2cqVL6fSRmGTQIKCDgxGH6tmMj
	FIif8Jdm4zA32yjzTytP/O8tu+I5DGmbP0Qt7uXjp1glXgFgJadKcbmFbGqvBA56Ba4=
X-Gm-Gg: AYBFou1mHbNGDhKy3lScnX4B3tdCn0PLoWjj02lydnn6EyB7Uy2BvaEtP8IcRkYjA7+
	W0V/bXzFvjjqKmQa5GyGgbN9k5Xbp6MyMTJvBJxABFF6b7bC+uko30MGVcEXFy9Y41fULUrJpMu
	r5nAD9YRqIoYAJBFZDvzt5aWM56dp28fkm3nDF4dlENwJGgH4ntAWPvYKDks4Uy2D/RFwjuqbcH
	ha0I9/6kW6QELIpjckx0v43l5I734ecINvDVhoifI3CCk7uv+H1B+oby/VTMG78o05qmzrwWynh
	E4DobCkcZB+NNXjsVi2/HvztxADf/MKOt2nwNkmqHVJ8ZjRfXbdbj9YBRlkXBycYJS1WvjU3H5T
	qiFLTuU0RCsIJRDwIgr3nTohiUbuVgTSvlopZj1anyZlTlXgRPGMwDHalH0Mzv8EY5XuhraMUM6
	6mY9fthkMmnXy/c1JFEmdBU23hsPlNmBBLYgVrYL58Jt6CH5yId54E5E1U85t12ewBl7IBUvKIm
	eg8y6AhuHmQvqZYtAjwbPI0/fPzvbBQeNCW8ZCm2m8YHCKOPR2iTIzTPLUyK3cFNNReFo1gsF9c
	w+568QVjP/bNWPRikqyfP8kI081xoXpkTe2nANk4BAz4wChqDMqqeLcuEkKkow==
X-Received: by 2002:a05:7301:4902:b0:376:f63a:cb24 with SMTP id 5a478bee46e88-376f63ad124mr1305017eec.3.1794389888322;
        Wed, 11 Nov 2026 01:38:08 -0800 (PST)
Received: from G6L4RL2QG9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212e9e03sm29016749eec.23.2026.11.11.01.38.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 01:38:07 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miaohe Lin <linmiaohe@huawei.com>
Cc: Muchun Song <muchun.song@linux.dev>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Joao Martins <joao.m.martins@oracle.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm/hugetlb_vmemmap: fix deadlock during PMD split
Date: Wed, 11 Nov 2026 17:37:46 +0800
Message-ID: <20261111093747.50048-4-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111093747.50048-1-songmuchun@bytedance.com>
References: <20261111093747.50048-1-songmuchun@bytedance.com>
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

vmemmap_remap_range() currently walks vmemmap page tables under
init_mm.mmap_lock. If the walk reaches a leaf PMD, vmemmap_split_pmd()
allocates a PTE table with GFP_KERNEL and can enter direct reclaim:

hugetlb_vmemmap_optimize_folio()
  vmemmap_remap_range()
    mmap_read_lock(&init_mm)  <-- outer read lock
    ...
      vmemmap_split_pmd()
        pte_alloc_one_kernel(&init_mm)  /* GFP_KERNEL */
          <direct reclaim>
            ttm_pool_shrinker_scan()
              ...
                change_page_attr_set_clr()
                  mmap_read_lock(&init_mm)  <-- self-deadlock

Since commit d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on
attribute changes to avoid UAF"), reclaim through TTM can enter CPA,
which also takes init_mm.mmap_lock. If a writer is pending, the nested
read blocks behind it while the outer read cannot be released, causing a
self-deadlock.

HVO walks vmemmap ranges whose intermediate page tables remain present.
vmemmap_split_pmd() revalidates the PMD under init_mm.page_table_lock
before installing the PTE table. Use the lockless page-table walker so the
allocation no longer runs under init_mm.mmap_lock.

Fixes: d5d8b8662e6e ("x86/mm/pat: Acquire init_mm read lock on attribute changes to avoid UAF")
Cc: stable@vger.kernel.org
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/sashiko-outbox-206969@kernel.org/
---
 mm/hugetlb_vmemmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 6fba3184356c..5852b0a1c479 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -161,10 +161,8 @@ static int vmemmap_remap_range(unsigned long start, unsigned long end,
 
 	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
-	mmap_read_lock(&init_mm);
-	ret = walk_kernel_page_table_range(start, end, &vmemmap_remap_ops,
-				    NULL, walk);
-	mmap_read_unlock(&init_mm);
+	ret = walk_kernel_page_table_range_lockless(start, end, &vmemmap_remap_ops,
+						    NULL, walk);
 	if (ret)
 		return ret;
 
-- 
2.54.0

