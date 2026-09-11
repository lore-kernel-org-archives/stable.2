Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331A428C2BF
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 00:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085924; cv=none; b=tguJlA+PBwgivrmcSBUtJexU3AE8QgPsqJ6T8+pDpeAHQ4voYNzPEoyZ5CEhNBwkqpuDnXEr6NRqsAqk52P3O/VzaXwexSkxB2JvJl9ptAVy7qdBCW7mjp64SQ8jS7RQtBG9UsBqf4zNDHcHlx4kIpjQl6Q4Wu4zy9MhtihmajA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085924; c=relaxed/simple;
	bh=tJeL+TtL8fcQ3ySRpIEsJeq0/SmJ3J8dhXSj75dUeBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFhozpTqRwAlyDLc3qJrCGT7v1K/ssIwZIe4ywbC5l5vzY/4nh1+zrzBBK7mnUr+6EHwCLBN6eZY84UAyQpF+2/nByELmBeb29z6B2v1GpLU+6rqVXFWUeM7Uswh5dIfpdjYYyEN0CeoW/hhEQ8tLE+/sgQXVYQeGRz6fBGSCuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=XScuUtPU; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="XScuUtPU"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910cadeb7so35736685a.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 17:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1789085921; x=1789690721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LhZIogGFAKBWcn9TqaxnEfdXlwBjbgcMrXypWpyrcPc=;
        b=XScuUtPUL+N/ZXdfWm7PussEhbg2oDJ0cr1DGkI5dnDBBNfDj0NBHKuT1y+fktzQoH
         9JcrlygOVr1Xwh1eC31T81WWYVaGB/HKbbIAyuSmZOzBU3WdQTbZO6fU8m872UGhHeX0
         rwO2VhjS9Whih4jnBJWFQGHUlsvv6FuipYHYxKkhUALCmZz3lMgoj1kFPy388LDripTD
         MMXnfLb6lmoFhAkOZDzFmCTCJSkvHAzquYI6XPx0fT1kc6yZhIUCnZR12jqxERYTw3aX
         FlESFmZF7G3MzFNfX+zIXH0RFXWWlgeOENlbYfvM3B3LU7gxGwQ6yuxsZ8oS+fjI4jjV
         iEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789085921; x=1789690721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LhZIogGFAKBWcn9TqaxnEfdXlwBjbgcMrXypWpyrcPc=;
        b=Z3OthI0sGdJDDcYimGRROW0rgUTwZZEUMp4w3VHhQMcN8WsEI0fEUIK0WZCIsqNXNv
         OQibKcE5VUHnrpyhnpXea/20eqt330xw5ajEZWKTKa79J23fl3rhllFrYLzx/UmLT6FA
         3xT/vI+sbVn++gzL5R1Lm0g/ezc+cyIaYPETpB9lhRMT83TwjOsz6WCYNiEBul1V+KEI
         S05FByGwpk9TVBWT3WL71ZMeg4/DGO6egJpniskl+5NE2btCJhcti9Krc8JvX3cvEPQO
         lpVwnn55vk2+Z0ZvEGwFdGYmRNAsxJfVYyMX0VCvCHy4yVQJ5aBmOJP2wt76cCl+XdwM
         oTlg==
X-Forwarded-Encrypted: i=1; AKwUvBwnb5e32EEbBwxWz7gTOCRbLqHfsqKaRPV3U4q658LUlDUwMGX5quVJ2JgpE22KguSg8dja0lA=@vger.kernel.org
X-Gm-Message-State: AFuF++kWhWPDWxDuDHCbaBHEhWJZ36PpRBKR1jynjgcsqGE3LR801ORd
	4gkKF2OxrQQ4O7HBu5yluzXWpoEinTB5WsH+zJZJV3sVshaTeJQKj6dd+qFEcurMCSY=
X-Gm-Gg: AYBFou2mNqz1+sSbbMrQ04lNmROjvMEHfm4OJOWK1yX6ApWViTl1AAgTDKF3/531Lg+
	t/i2tWkjusBtqn8q7aAsGGJlyM8SKIlpKrYJ10u8R5OJF5r/qhuf+W7Z+LLjZYF08To9/0G2exn
	Q5YONed+YcVICSbujEGZrwvYZ//ZBVdMI8nnGGKnIw3HTxIXmBzm1yUsExtmM+u8+7zqWRS9e4Q
	09ELHKezufKIGCunkW6/2t9Y/2c16dTcsCdg/TUQ20FAZYytJDb1N1dOfLrhIJuv98/rr/LOvoY
	XNNH1F7gNEaKyP2XU2bq8d7QCtI5aW+/nW+mNrIZQZPOj14/6t81cGRrPODKOwrRSQAABKLJkiM
	qgEryc6yguRr7bVhDXhdZMpyiO26n+KIGNuJokVt9CLu8w7dDLbWPUbPrkxVjMfjD4BSdpKrdzE
	zZmoGVo/8wbe444q8aoWbjaoSUy15c7XlMxqouLrCQ2iwRUYj8Yw64JaDV2IcmM2rhfXx89WqSR
	q36ctJ4O8/KhlTzI9tue7KtBMkWLoUfSoJx+U9uvx/hZz44lBoscOUf/w15MVKbX8HCDTw=
X-Received: by 2002:a05:620a:4109:b0:938:fd60:4f9 with SMTP id af79cd13be357-939ea16a07dmr234110685a.27.1789085916408;
        Thu, 10 Sep 2026 17:18:36 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-939e80e4c36sm108896485a.40.2026.09.10.17.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 17:18:36 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	jannh@google.com,
	pfalcato@suse.de,
	osalvador@suse.de,
	hannes@cmpxchg.org,
	raghavendra.kt@amd.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] mm: allow shared folios to be promoted to a fast tier
Date: Thu, 10 Sep 2026 20:18:24 -0400
Message-ID: <20260911001826.2109390-3-gourry@gourry.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911001826.2109390-1-gourry@gourry.net>
References: <20260911001826.2109390-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Gregory Price (Meta)" <gourry@gourry.net>

NUMA balancing rejects shared copy-on-write folios and executable
file folios mapped by multiple processes to avoid placement bouncing.
These checks also block promotion from slow memory.

Allow such folios to participate when moving from a slow tier to a fast
tier. Keep the existing restrictions for ordinary placement.

Fixes: c574bbe91703 ("NUMA balancing: optimize page placement for memory tiering system")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/mempolicy.c | 8 ++++++--
 mm/migrate.c   | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index a082ccfa09ec..19b599bc2dd1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -863,8 +863,12 @@ bool folio_can_map_prot_numa(struct folio *folio, struct vm_area_struct *vma,
 	if (!folio || folio_is_zone_device(folio) || folio_test_ksm(folio))
 		return false;
 
-	/* Also skip shared copy-on-write folios */
-	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio))
+	/*
+	 * Shared copy-on-write folios are poor NUMA placement candidates, but
+	 * a hot folio on a slow tier still needs a hint fault for promotion.
+	 */
+	if (vma_is_cow_mapping(vma) && folio_maybe_mapped_shared(folio) &&
+	    !folio_use_access_time(folio))
 		return false;
 
 	/* Folios are pinned and can't be migrated */
diff --git a/mm/migrate.c b/mm/migrate.c
index a369d0c95c38..afd9c97d2389 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2697,12 +2697,14 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
 		/*
 		 * Do not migrate file folios that are mapped in multiple
 		 * processes with execute permissions as they are probably
-		 * shared libraries.
+		 * shared libraries, unless this is a promotion from a slow tier.
 		 *
 		 * See folio_maybe_mapped_shared() on possible imprecision
 		 * when we cannot easily detect if a folio is shared.
 		 */
-		if ((vma->vm_flags & VM_EXEC) && folio_maybe_mapped_shared(folio))
+		if ((vma->vm_flags & VM_EXEC) &&
+		    folio_maybe_mapped_shared(folio) &&
+		    (!folio_use_access_time(folio) || !node_is_toptier(node)))
 			return -EACCES;
 
 		/*
-- 
2.55.0

