Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.164
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397168;
	b=dVM+9WxoVB2AabTDbEMFgez/rhXJSnregG1T2XGDZe90qtZ7ykJYCrRzzQ+aVWoOoqSV
	 OeUBG/uWHF087mq3iSyOyTlAtZrzMrY92/cxJtc4N/vRWdSf6HIHctOO0xcTMXK1gQm+F
	 Po08dDV5NIJXUSREAv3aW0PNCYQeQ8IyDTodp4Mvs93yj7g44IxBo4l7CL/Cp5Md/ol8q
	 nef6o6c7YcTuRDT/z3eFkrauJy3RSRa17iLMA45s9akf/kNikMID5SQ8v1AsQJQ/VICZx
	 QxjGR9PL5gZvCTxn/ISHOyAxlxW+DMLRbZgrf1eT5qvpb1SB/zD6d6G5H3k2YsMJwqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397168;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ss6GPqajhnLoAGvpkwWgAL30Fbn2tVqWEm0t1Mamd/I=;
	b=0Nyoxa4/69ADqNVyE9IqD1XFRut/m3J3hjTWDn/JTpuQO2a/0p0pfZUfbtGaw60+fzmc
	 rU+LznLt+xkKhv3zxlG2Lc+TCufw0U6lR8k8Qtms8U/U+VRKcpNQMo/h6c1qcc9dVPwNn
	 imKm6NL4lDvxo1ifRkZFwObmFRab5Oyu55HHcQI71ZmNKFRNccPuiUhxkfKN/iHlDXtgC
	 NJ3M342gzAIBAXxHbPmBXkQcOYGGRQuDksIXT29lksQYjlm0nRMEKgXARb5aX8DBzW/Q8
	 zbvOUZdmtlEiSlt93NxEqL5S9VpPxJlN73HTKPaw5o41p3Yvp6VFnCH3jPW/+LJPEIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sf78Xrbp;
	arc=none smtp.remote-ip=91.218.175.164
Received: from mta0.migadu.com (out-164.mta0.migadu.com [91.218.175.164])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160A3606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 160A3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Sf78Xrbp
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=PxRmG2FWyo+pFqNDGwdneDF6Wr5yBgEA/EARM77L5Wg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794397166; v=1; x=1795001966;
 b=Sf78Xrbp+f+5PKpxe7Ig6SQ4TcsOwLLAsyIdP40wNiOzEzVSNPydukdMZGO179ZiOnf/Rfh4
 DtJS+Dd7lpDal/tlu9SVoef5UOnD/OQuLWJrc94uoK/R2sMMmjAbs3wJxTTr/F5au7Vz6yITkFO
 u34Y9hrqTzbPeY0W+NjXyRmI=
X-Envelope-To: stable@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 997e08426fbd59bb;
	Wed, 11 Nov 2026 11:39:25 +0000
X-Mizu-Trace-ID: 997e08426fbd59bb
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
Subject: [PATCH 3/3] fs/proc/task_mmu: account device-private PMDs as present in smaps
Date: Wed, 11 Nov 2026 03:38:31 -0800
Message-ID: <20261111113904.650722-4-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111113904.650722-1-usama.arif@linux.dev>
References: <20261111113904.650722-1-usama.arif@linux.dev>
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
---
 fs/proc/task_mmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index c0d391186c2b8..ad97532fc1184 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1032,8 +1032,11 @@ static void smaps_pmd_entry(pmd_t *pmd, unsigned long addr,
 	} else if (unlikely(thp_migration_supported())) {
 		const softleaf_t entry = softleaf_from_pmd(*pmd);
 
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
2.53.0-Meta

