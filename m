Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11613D5246
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004502; cv=none; b=HwApTAixCNOObhYvpwQWj4T5OrqKhmXxI5RlWgmD5aCT9LCImIgAHws8JzgWPl6I2iTLw/1wALMG5imc4RxcWEEmcLQDmGAbvxbfN4sa+X2bffyq1ZdKSBJR6YNC6trAosGgpCdh6CRyHp6o2UlXpMfErd8PeZSBDpHWGuwYfZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004502; c=relaxed/simple;
	bh=HLXd7r9UoHiCOCGXYySq+SbExbsYPes653QqEyqbsUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eoGl7l/uGjdTJcfE1ElSE9DsYCRFc3ypwGlnemmnM4nuTNf7JMHwI9guNxK91UUzis22VUvHuZtl5HDzqxJr9qoO4YB2M3Fa2mdZEw8T62ypGyH67M8z0haMrTlZH/HgRNh8CyrpS/UQMlkUnH8M/2A+RjDpqc0cYStBG38bbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=W1RSBXYx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="W1RSBXYx"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e512a9a6bso181063285a.2
        for <stable@vger.kernel.org>; Mon, 17 Aug 2026 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787004499; x=1787609299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PYwESWun0fa6liMiTXLOYEKQD6iVsL/nuJsHb68bQDQ=;
        b=W1RSBXYxvSp4Bx+MpTdA7tYVjdzTPMp42cpQTj44pG9a+KH3KJuQs+t7g/y4o881ki
         0cf/vVG3ithSk3upodZqb3CoR+C02b5OtwqI9yTjCVQ6OGL95/utiDSzbUpgAK1WYKzz
         XzejA44Jd4M+P4BK7buaoGV5f6k2jWkkfvOycPAoTYPqPR9hhS3BJ++z9ugnf+nvZz6O
         tMf1itWdu2CBq5kU+olf4VSEfNtS6D+VGuzmDSrlLSwpwvvEWjWh98+c+8VmTedDtK5U
         F8Z77a2cQnQ8gPEX6mx61kKuk0WrB4YLbOb6HauPVC4zF+GJ2ThgQBwSsSMX1ongV8p9
         gHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004499; x=1787609299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PYwESWun0fa6liMiTXLOYEKQD6iVsL/nuJsHb68bQDQ=;
        b=pcWF+dXZUFv/LGlqVAVjogV8c3pjj8dtPFWcjI8Gd4UAMZECMtr6SQqBa1MhyZvu13
         lWMkVTlFARAecQfRV3lZTiljQEfTqomPuUUFQBUeKO91uIxdfdFdr2ceJw3x/+JcErUP
         vZfG7UXmbu8zHdbcvG1e3gr2h5u9VmvhV87Az1K//R1xyIjlzHX4dvrIwe6LBEASFDmg
         S2a82J0uUTE2HtQemxCD1Kox2WMf2fOqLlYmZ9rHpEppBtgnNifOW8jeDsUbtIS1qSYc
         aDCTvIWAHOeQJR4AEg94v5qsDm8YzdL37UG+uO4Eba2gj7+CoQbrN5w3/2VKqQSIW1B7
         6fFg==
X-Forwarded-Encrypted: i=1; AHgh+RoDG4mbbuieM7t3p8PtkBYvfyBNqEGXYkxMIS+Y+a2YJjHVfYOSPPmklkEqT+YS4DWnxTr/MUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKSpKX0wABsYmYf+uH8JOXkUzCHjs64vIx8uTrIglAPZHqR2Jf
	Em4lpiitUbhCZhvkqWBISs+S+yqjkC70Q/r5H3l0bS0Aqdo+IiYccS2JpDUW8qN32gM=
X-Gm-Gg: AR+sD12WKiMa6WOPUVMvqXDH7PT8cs/+6IKpsYckiccvREJmm7yxrRieTP8YD9j2vIq
	LLZ7pwqV/Z/8mO0Tq46ZoX8NtofkGzzCshRCCsUidsTlYs3EAS1mVqHKYl4UFnyad1MQkRh6Q10
	rBMGPAKhwPPU6GK0y+7G70Yk5GLjjmoO1iCgj5+xDNsss+vJRfrTwr8/fmLI54YB4D3tK5bIPnG
	Iz/ATgeUbOZnvP1GvurXShdjavm6JCzNUY5aVzs7rU8d7AnOlsumFhsynteyfdoE4UYuiB29ad/
	iQSaGkhcQ7YpIpMu3R6icImfdYHB2RsFF8M9wL+4IiFUhvqLcPVlinZ29OEsJmWl61jn6+uBCiF
	WWYrLUSItedewJo8D7fwxr7CmtCLNDE++xtNlqzKXr3rwPkHnrOMA7SU99q/MjEL9+AL0LZh3NH
	xKubX/OpDOX3cz8KpvzAbV74aClEOj+YgUO411qh4I63ckcM+ObrWoZZdrt+vO/3L6LrhvlNjVJ
	Vth1inKoMBBdXQo0XQud6bRfHIFHKK+kDnKDUQuYmaorRtzunQCCyCUGQRz
X-Received: by 2002:a05:620a:4387:b0:92e:bc28:5479 with SMTP id af79cd13be357-93704b1ac3fmr488870385a.2.1787004499566;
        Mon, 17 Aug 2026 15:08:19 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-937033ce78csm147108885a.31.2026.08.17.15.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 15:08:19 -0700 (PDT)
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
Subject: [PATCH v2 2/3] mm/madvise: skip zone device folios in cold/pageout PMD range
Date: Mon, 17 Aug 2026 18:08:09 -0400
Message-ID: <20260817220810.1175596-3-gourry@gourry.net>
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

madvise_cold_or_pageout_pte_range() resolves the folio backing a PMD
via pmd_folio() and ages or reclaims it without checking for zone
device memory.

The surrounding guards do not cover every zone device case:

  - can_madv_lru_vma() excludes VM_PFNMAP and VM_HUGETLB VMAs
    (so device DAX is filtered)

  - !pmd_present() branch above rejects device-private and
    migration entries, which are non-present.

  - A present zone device PMD - e.g. a device-coherent THP - is
    not filtered by any of these, nor by pmd_folio() (unlike
    vm_normal_page_pmd(), it performs no special/pfnmap check),
    and would be aged or paged out here.

Skip ZONE_DEVICE folios explicitly during MADV_COLD/PAGEOUT.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/madvise.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index c179938097bf0..2151bb9468594 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -396,6 +396,9 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 
 		folio = pmd_folio(orig_pmd);
 
+		if (folio_is_zone_device(folio))
+			goto huge_unlock;
+
 		/* Do not interfere with other mappings of this folio */
 		if (folio_maybe_mapped_shared(folio))
 			goto huge_unlock;
-- 
2.53.0-Meta

