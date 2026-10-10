Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B814B443C29
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791631587; cv=none; b=BI4MuIMmSgUVw4oUDDcjh01MvNSqwRiPIch6jUozZg3AQO9RSklm+Zg26/Wsn6AL5mEb2aGQzm1cEFBYq2bmGa0uYxnSvGCJ4/tKK2CfGt0GLg/p/lnLNfLSDiyjL3Y+ibOm2SMLY+pmDomddMTvXp4mYCTIOHeVZ5h8yN90c64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791631587; c=relaxed/simple;
	bh=CotAfEchWPvK4pxrQ4IkUgKYDrw3lLJO14nMB6jiOXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J6cpyiqCQ+UjZG868TvZRlhNU7mkUyVBpCTKdMi2N88Vb+qd+zT+QfS8eVslKQAfpA8LghNHxdus6+Y/i2Z0b/hjoFwX8aQlPx1HpH//6lVg/eV/HZ1QkpNUWDmk5vPX4Oy9yus+lrQdhl2oFTQ+kg11D4jnCZI2q4WJrdvVmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=VOs7UfyX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="VOs7UfyX"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398b3c37877so218933a91.0
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 04:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1791631585; x=1792236385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nwX2V/6o0Kptw/VlXJ/4Jp9bBaiXMijAHR2YrE2LL1c=;
        b=VOs7UfyXUFlmDUUXM8U4/vi0e7Z+7Z04qUVfARNqibeu5qdJLOg8NW60NPg7LI0JbY
         avy1bRVeGLoHicB3Ew/82VE109jjBDlXQHzsCGpFRDgoxyq2CT5pEs3eGlIAP3xR3blY
         itQqkfgNwuJXgNIGa5NwUUKGjX1Q9QErjNok8Ue46dFlSIL+Qg9NI9XG4Rm+DEwbcImt
         ksOlfUnNMMhe3BUqkIiJ3jzp4bjVNvHjO6iLnIYn1x9gaRkGY99+aM3sW1fOAijq5ux4
         wgZGuR0dRveaWTMadypEFIserEkzXl/TYNzhxIxgSZJO5L5ixLqoenEDrWIiE8NdlB3k
         2GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791631585; x=1792236385;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nwX2V/6o0Kptw/VlXJ/4Jp9bBaiXMijAHR2YrE2LL1c=;
        b=dyAzNFKLLgYxTwG4tnHOXEGEwflVGcCyfB27IW1BGbL34vPLwp9muVyslPVU9tarsQ
         wqSuQhJS5bNTZDSaORISB1jg29DeqweyG+ysT77UBTOnCobpBLImeCZOmb3beISvrAh2
         J418BjM2/IG2AgOZKfgPFBsQN6+GSg4r0T+NRroeYx8UYGml5h0eAlmntaNkOFOfjG+V
         OOIV6bNaFijs5O5uvsUhyVoIKmp6M4J2EzCXAmnugaxG9Js/ye+ooHVLm83LADoRJkxE
         askp/6D9VM6MH+bii6nryLWDvC8eZ7fm9AsU+9j92dMSGMv38SzKy+T+OUUignXIGo4d
         0VWQ==
X-Forwarded-Encrypted: i=1; AKwUvBwW5bTzb2tZJxZn5zP6LQBkTNo2Rn9NsSvV8/wavRmKUGxVGW15FDPkXrc+qrSnUGxv4+9xIFk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIS7q3AeA5mLAPtKsY0/BSMKEXFPPWpAzzBoxStTbnEsz8EjkfO
	l0KPVaHGLfdTOEjUevoC2CFM5AYyaqoo4eLDF6F+XXbIEXilB1cZt/vqVpLF0qjKCLg=
X-Gm-Gg: AYBFou3ubB0/iJkespAw1X4T7naXo3VIrYx+tLwaO0NCBYnPC5IFTFPXBHcfhqP8mUz
	Cp3zGU6SH9nQjmEOE5L+kNSv6W/qGRKlXt+MOqnfaHRuZ63QKjSig7Yd8G/fKE47zWpLU9jrgJw
	cZ/HZmkVOAMyefEHLRRqZFjKcPND5+qbhlDD4qIdbY+SXJoPvkxgBrqnGlvIx1qhvjta+MKoZj+
	mQ76JG7j9qAb/F/E3eiAQHzM3Lt6YL21boVt2xms5KsMw3IjW0vqA+/ehNXQSIersXCp+YDAqSp
	VjJExUqrjaqHSWZz55cqA2onis5r27xtmXp/E23kLL3iong7ksA1TbejPy0qG1bz7t3q7qeNndy
	VtuVLrY01cb1QzDriN589fG2veZ8C+ww9yJoaMQgGGk2CtW1Z7DAgflhs0j4bDgeUPPzpvJAUbi
	h6dbKA6T7Ln1anMfYpQ7dtZQ5Ll61frx93YpjSm3gTkb4O19ylYita+BGtMvmdo4+2lIGyHVVSo
	QpxoKkQN8FWal2W4NdiynorhNdRYH36+OWtoA==
X-Received: by 2002:a17:90a:e7ce:b0:3a4:ef4a:4f12 with SMTP id 98e67ed59e1d1-3ab3b01ccf0mr3608742a91.61.1791631584895;
        Sat, 10 Oct 2026 04:26:24 -0700 (PDT)
Received: from G6L4RL2QG9.bytedance.net ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3690474esm7900233a91.0.2026.10.10.04.26.16
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 04:26:24 -0700 (PDT)
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
Subject: [PATCH v2 4/4] arm64/mm: fix destructor for unconstructed hotplug page tables
Date: Sat, 10 Oct 2026 19:24:57 +0800
Message-ID: <20261010112457.49485-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261010112457.49485-1-songmuchun@bytedance.com>
References: <20261010112457.49485-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
---
v2:
- Free intermediate tables through pagetable_free() (suggested by David
  Hildenbrand)
- Update the commit message for the page-table freeing path
---
 arch/arm64/mm/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 7343ac9294f8..26a8c665ae52 100644
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

