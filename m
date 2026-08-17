Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACEF3E8342
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004505; cv=none; b=GO/M9iYozXe+pOGXgOxzOWAfiIaUHloIHWv9yG080qdsuFDOkUPUFn595APgePy51/RADvcTIoSMzFzYr0sn2zfPjT2X1qLB3zKfSIC7WQTUzQWVppZYyFNecy4FdZw0F7swzNuTXnD2f/DDNB6o5qodJSh/qqJP1ZtiJAIFqP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004505; c=relaxed/simple;
	bh=ZXtcW5Eoj+sECtsN1QOXnQk3JSNbUEnxSoGOx9uaKHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRDZcestPs2P9i5L68m+F6N/k8zdMVYxuf3bxkmoeiBli0nru1ZShmF/T7ch+Xyz+WWHmx8HS/zhlYi/5DbA1eMNKkxe0KePfoZaYZTpWb14qAfoTnt9EJomH1Kup+AqhnuNVAvu+vSNAp01j3ORR0g42585n+/Y+rmZA++Jf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=VpoGboIi; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="VpoGboIi"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-92e6c4a867cso247627585a.0
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787004501; x=1787609301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oLjt6fqOYQqPl3RBDaIWJlYyCKzqU8AbAXeHyMH4wI=;
        b=VpoGboIi+7R5Ie1/wbOoaHqJMIL55HxwCaCS4HahyknzAvi6xPszqyjXfsS1QuDGhZ
         gP3UZyzzw/GMlCxZ9ugyO4+BEVvVgLd4Rs2nKbJTumMwREY4HzeH3Uod9EzEYvh/ms73
         XkH6l01V0x5Q82Qcb/2yhO4binpt0DocmL0CuYBfoaAk1gbDUpvV3a7wCrhEGZfHzfAC
         Cs9JIKJHAGhUO4OhJeLiKmlBTmSNQloQxK/vWaWSpT7yjBm4nmAFkHmQm1IaI/zkmOGD
         WKsCqA/uMGpYyegc+tRv7xt6W1xyEyZQvDZEDBa8ICKWvQD3nF7/5C18vLuuG4PmU+Vk
         xQVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004501; x=1787609301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2oLjt6fqOYQqPl3RBDaIWJlYyCKzqU8AbAXeHyMH4wI=;
        b=UM8AI7f+ZTWN8IspYlL3nk52QuJWezAIAxRFfcGCDqCC5GvvdOb8Nf15A4cB6rzpzj
         5LCr9PFttKcdwcYA0cjt+dwMnC22dp7IN/T0RfdT2gBywlu8zXjgkhp/U8NVCTlhnCAd
         BIaMaxhZRLFP/RqPAq31lvqqT3RcyQJ/1g1vyZyyIKDjVLKtq+jcM0aUDpm4LM7t1cNU
         zsaGqBm1hRqNXa5/KWNc7L8qBccxjwvGq32AULebNVpeJObF548/d/zontZaFEINq+zE
         sGJqYMT8AGAT9K7z/S9+h7UWK/ZOffL0JSILmiYLLO+VYSAeNzTVABjjroszHEwzBdSZ
         DAwg==
X-Forwarded-Encrypted: i=1; AHgh+RpWv4BshmkuOJrzUjUsITlTcIGULVg7XrKnJMI6XTg1qpLInfGOKgYPlt4O/iW1RBvVKOPx1LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0kXk/bYqwxVvFkTBzJ7/SX+K5nbTdJs3TAYSSJij0WvXMt7VZ
	tb/jG25abMUZQUytspbxfNeVBbvKsx3SrUdXgBBtTB1oyUdBaqxEqcYzemtY7Ahn+pE=
X-Gm-Gg: AR+sD12ERCnloL7rK4KcPudLG0N1vwVTPoIZhaTd3TO1FDcl/skMf/EKYUCxuavFA0a
	/7qssx2W/GTxPQAXu7TVEGQYt7lXt8sYZ/T+tkldcGpCFWB1t5eqLLcnhDofl0AUTT5NT603iGG
	UPdYDFTSpUrsJvGcdYr7fOIUP9+AiGtHlxiEt/87RAL/NcamTMdWzfBBj8UwHzBVG99XLJMMYyo
	z1mULoup4gvIi7NVe+CKamAWp7HhciDWCz1U4ZgT1/E/xCN/KMF0pyyg3jFZVVf/wwunwvX4Kti
	gtgNarjWROo6Ah1on4NwxfHcC9ydf+n33W1LRDGmqeokqzKQ3/j5QIN/oz4hNBt6JREXSXD+Q3P
	xdgUyEkTRE7T3fDSkLHaX7A9b+mxX+LA5KTBdfYjWB1Qx+28MHbW6m5/K21re3pYcu3KlgBdRip
	yL0FoE8MBXgvPCFZAz7A81e3f29H6sbJZu7QaDFh6Pu7+ELyoMdj+Tz7raMhFeDCkt/M4uVDGos
	6PEIzg6YHLbXi/5GQVljZTBXJ32B9dVX+nTX1VjVUnlX4D9FI+QvT5Hiuog8Q==
X-Received: by 2002:a05:620a:2889:b0:92e:7cc9:a888 with SMTP id af79cd13be357-936d1fd98c4mr3001265785a.2.1787004501326;
        Mon, 17 Aug 2026 15:08:21 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ce78csm147108885a.31.2026.08.17.15.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:08:21 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
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
	balbirs@nvidia.com,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm/mempolicy: skip zone device folios when queueing folios
Date: Mon, 17 Aug 2026 18:08:10 -0400
Message-ID: <20260817220810.1175596-4-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817220810.1175596-1-gourry@gourry.net>
References: <20260817220810.1175596-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

queue_folios_pte_range() already pairs vm_normal_folio() with an
explicit folio_is_zone_device() check before adding folios to the
migration pagelist.

vm_normal_folio() alone does not reject zone device memory (a present
device-coherent page in a normal VMA is returned as "normal").

Mirror the explicit check in queue_folios_pmd() as well.

queue_folios_pmd() uses pmd_folio() directly and can encounter a present
zone device PMD - e.g. a device-coherent THP.

This is not filtered by existing checks:
  !pmd_present()   - only rejects non-present device-private and
                     migration entries

  vma_migratable() - excludes DAX and VM_PFNMAP.

The early return also means such a folio is no longer counted in
qp->nr_failed under MPOL_MF_STRICT.  This is the same pattern used
by queue_folios_pte_range() (skipping zone device without failing).

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3498a5651d50f..3418b5664dcf8 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -662,6 +662,8 @@ static void queue_folios_pmd(pmd_t *pmd, struct mm_walk *walk)
 		return;
 	}
 	folio = pmd_folio(pmdval);
+	if (folio_is_zone_device(folio))
+		return;
 	if (is_huge_zero_folio(folio)) {
 		walk->action = ACTION_CONTINUE;
 		return;
-- 
2.53.0-Meta

