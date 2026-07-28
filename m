Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E5A470EB7
	for <stable@vger.kernel.org>; Tue, 28 Jul 2026 19:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785268047; cv=none; b=ozNm6bdl8vN26IEh9Q379BNcGVazgX5ePjptgbUxSxRgG/NdoKxWmlaD7fcrVVMx4pDFQ92/bWTeTBObeRFXIqw4h6cTrLl60VfP45yT9DVRAb/ob6Ve5f0pQKy/eqlimlo7bNFmHvfWqB6F7uU6fPBkkNRkNVpTwESy3dVDbjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785268047; c=relaxed/simple;
	bh=QMZ7J7lKfDME8A5FG6nzVSk2RlwEU5lJAgsrB/UXl7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oknqFRd5VHICfSy8g1cdI02bTvp57wlc8HIOftXY8+1ZvJ5YpfyDm6MA0Mt1iL7DiS8T9YWbF2mxQbRlfF0NOLOx7kDc51urX1jCtNCSwY+Y3Rkla4zO2Vids9Gs0+zNgjJccPAUTsEe974K730tKtgOKf5Rf7OYGw2d01IAv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=QFgWFY5r; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="QFgWFY5r"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-51a868b6962so2194211cf.2
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 12:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1785268044; x=1785872844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pqmZmonnGKuyrTzlO9IdYf4JadmrLNGgv2eh0Lztbm8=;
        b=QFgWFY5rplJgBTZ0DUBT/7aUmAmnCaGim61StbqxE7tL1euejovrRBURSgxKM6EC58
         +236Uh1HUg5NZ0lSWrKP2FTH0DA4UmrcNxUPres1mrIeItBxvXqXxq0BTCvEPUriIMNr
         7zMOg3Aicxw30peaKP3nSZWm011dIyBmlT1Cg0SyirHviOsrFlohIa5Kze08Jc1GnNO/
         qVnDRABNw/PTY6A8WKisTIig6B9Vrghim79bCheyuQOwMukWv+MAybKQY3iwQyISA8BW
         KCN33JMtJuz6SjWNfEPoSGfcqI3l8TlKh4RwqLBDdGtF8kBNYQSgAKByS2zpefU4xYa8
         4dCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785268044; x=1785872844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pqmZmonnGKuyrTzlO9IdYf4JadmrLNGgv2eh0Lztbm8=;
        b=FJFn7Sg4Y5X/KuOETJ7k93hmHO9wWmz9N3YhO23AanyxLlzSfhN+Ia5WUp5TDAkolC
         9ckHpOefnB8ZcrZoUjbyXiTh7UjaGyXpvkaZK/87C3A7ycsglDyQP/07bb0wJ4cZAOtW
         RT7/BPSO7cNE7b6fIBkX83dYZGmV9ORn7yZo0EbAlVC9zhJw32d3AQJhA9wQY6VCEwPk
         wZbunT4DSO/IOgT3ANjz7aSMo93MIP+pBPCfTcJ45wMb9Uvcs5Q7iCHFNlUlT/Re2/CU
         rax3bRz6messD/FuQeO4LcJ/C7VHvmi8SRi7A4rZOjuBs8pGUYP+MIvlS58//AjuaP5h
         SBMQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe34vJz6bynGNhrJEJ/HwZoBy7SpvB6xjqQuAq/Oem13aLHAQ4gc2RfPU6R1vPWNx+afmTK+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2qopXLj9b+E+NDD8C7oyOOrjOhnsRnRZoqm5iaWzacKAr+IMg
	AUgyncbWMomqYVnK3ym64HTW6VPjRbK2a/8ePp/Qj6ZAWp0F8bxSl8/uMi6iAYHrONs=
X-Gm-Gg: AR+sD13c/zG67fwvpDU6iFy9uvq8qSJKr2b4emY9Vn3TxAEOh2G+5RtcIxFlNTwij/g
	Z8O8seC5TtJxeySqk2Iyz2He2R73YwzivuDCy2Psar+jo0q2tZA/rXy5ElQbJ64MapxLcHN+3ii
	VrWcly0Aq+Zz+zDUEKOWZM/xSNF002fLEapJYoTEZCIeHYVdBzt9KRl+35/jbz9Vmook3eUADFk
	vihLkqvFt7j/u5NaiB2780wzOPV+zNxepA9E4mj5oVbmBJQS32VMbm87+EVyAxG+5PZG6BJahvt
	ML2pRUu9dqn2gTMItLCNBg6bhGfZF5Qr3w8UVG7GaBECsbanPWqWD3uyDMDU9HQxcjqVLbU+rPo
	lkrCJc6Z87pvQf4AzAE77BM5R+wIEOGw1rpEHU5Ph+VUAy0EEBIWDIJtPNKB9PxTsIGXxWRqKii
	/D5rNT+1WXG4I4eWZFFj01rycGgw1tFDMplrNnotq07J1pEgl4rR+83Fa+tnzx/war4OU9XE5QI
	w==
X-Received: by 2002:a05:622a:2c6:b0:528:3b83:3483 with SMTP id d75a77b69052e-529d70fc0aemr38942701cf.23.1785268044243;
        Tue, 28 Jul 2026 12:47:24 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9081dd6b539sm6700176d6.41.2026.07.28.12.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 12:47:23 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	sj@kernel.org,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	vbabka@kernel.org,
	jannh@google.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH 2/4] mm/huge_memory: skip zone device folios in madvise_free_huge_pmd()
Date: Tue, 28 Jul 2026 15:47:12 -0400
Message-ID: <20260728194714.3713735-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260728194714.3713735-1-gourry@gourry.net>
References: <20260728194714.3713735-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

madvise_free_huge_pmd() resolves the folio backing a PMD via pmd_folio()
and marks it lazyfree without checking for zone device memory.

The surrounding guards do not cover every zone device case:
 - MADV_FREE only operates on anonymous VMAs (DAX mappings are excluded)

 - !pmd_present() branch rejects device-private and migration entries

 - present zone device PMD (device coherent THP) is not filtered.
   Unlike vm_normal_page_pmd(), it performs no special/pfnmap check,
   and would be marked lazyfree here.

Bail out when the folio is a zone device folio.

Fixes: 368076f52ebe ("mm/huge_memory: add device-private THP support to PMD operations")
Cc: <stable@vger.kernel.org>
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/huge_memory.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 5bd8d4f59a7b..e0ffdeeb3077 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2338,6 +2338,10 @@ bool madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	}
 
 	folio = pmd_folio(orig_pmd);
+
+	if (folio_is_zone_device(folio))
+		goto out;
+
 	/*
 	 * If other processes are mapping this folio, we couldn't discard
 	 * the folio unless they all do MADV_FREE so let's skip the folio.
-- 
2.55.0

