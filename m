Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.82
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795607552;
	b=SwmQWeMcRP2n83iA7ec/PLiD1q39EYS8HR/JPmkNdPQdAA34iO8MaCwOc01dl8Vw/U4Q
	 U9SBkplzvFSff3eDkYHDotBSVttIA85+XZilsuBRJkdw2f2Juvv/10m6iwTqnPTAm8iq0
	 UURgBQdjq6tilbxIFmotqH8R/HY37DfSaXFFXKZNa6FBKQ27hllWIG71HmuSi5Sc+y6aE
	 MZRszcASPtip55esANJejmchmhovKicv1tmLuKGNIg2PXBt4POHrm1RPSVYsKbP/CoL/T
	 IRVeWJ1KQZcsC8BH8P0vFCtVx/2GB720j323nVRF0i8TzEFmgE/QZmrXZAwhBdqMVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795607552;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YrUqEMm9z5J4jaNe8INgEE9sMz1REWYf5p9yYZc/oOM=;
	b=uAmeNjYj1ybVQ+tXfGDApgAOyGPXuTpSbybQahPpj+ZLIbqDSBI1XzVL9EuIguTrl6jn
	 lD/Cxn9dhb9rBHFp7MpTkjOfUDa5+3fDAAUfLR9GoyyDzvTGW+YKdGIXjQBk+oer3TEzi
	 Z0D8MbAtV7GTwcHenAYwx7waiHylzZkmGiAFFG96tpj1yB9x3FJXdURt9Pb+AQTvlhLCS
	 42EDuxHMcJG2TGtFpcLw0A4+EhQMlRRvyOrsNkGadS/J5y9/P8IxgPqN2DnLv/93w4RZ9
	 qCXVoF+nwX7AANxw4meXIfVGePE+49xPTvppcLle2jmqB2xlJm4L9fCYhghqpYmYE5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KWUVFlba;
	arc=none smtp.remote-ip=91.218.175.82
Received: from mta0.migadu.com (out-82.mta0.migadu.com [91.218.175.82])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0484606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:52:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0484606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=KWUVFlba
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5O5gPTvKN1uioPmvTeSAALfxSrjKERJLwEwvEZL/R/o=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795607550; v=1; x=1796212350;
 b=KWUVFlba5ywf7fospShMopuIh2zVTNzVE5TkmvuW/W8i1EcePQAW1ct/gxNabi/1Eoeq2zAi
 6o8i6JCIPB2/iL/bhqL3bfJWwqyrPkrKf9JHMn2b6/Onx7e+hIJ36R2kh62Gmrzhkg201WilN9D
 diiKzF4mdm9qLPWUs+Z/hsPU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id dab8a477befd0327;
	Wed, 25 Nov 2026 11:52:29 +0000
X-Mizu-Trace-ID: dab8a477befd0327
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	apopple@nvidia.com,
	byungchul@sk.com,
	david@kernel.org,
	gourry@gourry.net,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	liam@infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	ljs@kernel.org,
	matthew.brost@intel.com,
	mhocko@suse.com,
	pfalcato@suse.de,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	ying.huang@linux.alibaba.com,
	ziy@nvidia.com,
	kas@kernel.org,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev
Cc: Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Wed, 25 Nov 2026 03:49:59 -0800
Message-ID: <20261125115014.4014507-4-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.1
In-Reply-To: <20261125115014.4014507-1-usama.arif@linux.dev>
References: <20261125115014.4014507-1-usama.arif@linux.dev>
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

Device-private PMDs represent mapped pages, but smaps_pmd_entry()
passes present=false to smaps_account(). That treats them like migration
entries: mapcounts are ignored, PSS is charged in full, and exclusive
mappings are accounted as shared.

Match smaps_pte_entry() and mark device-private PMDs as present so
smaps_account() uses mapcounts for PSS and private/shared accounting.

Fixes: a30b48bf1b24 ("mm/migrate_device: implement THP migration of zone device pages")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index cf1732935c73df..9017b312f404ef 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1034,8 +1034,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(pmdval);
 
-		if (softleaf_has_pfn(entry))
+		if (softleaf_has_pfn(entry)) {
+			if (softleaf_is_device_private(entry))
+				present = true;
 			page = softleaf_to_page(entry);
+		}
 	}
 	if (IS_ERR_OR_NULL(page))
 		return;
-- 
2.53.1-Meta

