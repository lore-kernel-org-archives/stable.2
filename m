Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904064;
	b=jrBup/hyt4EPgwMSs77CDtDG6WnQbU0+JfZ5YHX2k4mkQU09Oi6ie+OSURSFPM44R13b
	 33OAXgxtWM6BMkmpZQ7rLrzaZQT0/Acj9KYYhxLjM04QnVbKdHCFLdkKEwo1k+j/QSb0c
	 iM1S6N2eZxzBU73/YdY7Yo9u31ovDWG01UgyDGsvDkLeeemMvfHs/qXFzUpgYBXq6yU8b
	 JOhW8BPGs1dDYuEGHSgFvWtUYrQb+MVHKMdmanjQeks9MDm8Qmz6n6svsVKiYZotgLHH4
	 zwGNBw6gxbEktmRfupq0wOAr3It/vvczTgKSeekpAqY3oJzPpn4+TNLOpoFmPK2enCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904064;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/8bJMm/sgf29qfCgUJsD1PwhcylKtHc9E7GXw05kMnY=;
	b=igpm3cqgnaN8QMhtgpPHEI1nTT+0X0GTMfm2OWMOCpDijSzmal6zal8Ecxn7OGngzLoS
	 8cSobA2LEKVHrxPYdPdQvLCHQ4mkTtGHA51ekCdhnSF21m6FihzGiFjhNKPbn0U+Sjybr
	 cFoS6NoYRhVFhDyKtT2Jac5Y4Vibe6029TjYeGshVZ/tV2ndha0NhZix7zJtBXweOVN4k
	 5uLkh+V2y/HDUYq8+i0lPvJZHAPdeyTYFhIVORLdepA1wo32Mhhfr9bQ7R9B5dDmaAfRe
	 0lfly0dHrKpCIXdyyNJhAsqyAESLKejwV8Vlbx58Ef69HBYvNWSbV36oRGcZUtbH33Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fcUh3zPF;
	arc=none smtp.remote-ip=95.215.58.119
Received: from mta1.migadu.com (out-119.mta1.migadu.com [95.215.58.119])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B34606A335
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09B34606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fcUh3zPF
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ESJRx81IWR2zPX4rBwYm4630w/5tlX0IX9UcfPNoYB4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793904062; v=1; x=1794508862;
 b=fcUh3zPFAUHMX9gyVjNaHYheubTR0rm8S/XTgm23JM5hjsp5pPB/Y0q6k3akWJdvVfuOgxhj
 wiigDzyWyt5MiR8OGRU+NhdjUouqLXiY4rNfsKYV5dDbOmGQU/5qzJ7WzRCRtTBiHRvvGoCpbWw
 KIFKHu4G/AZKstVh3OhaE9vU=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 59e87fb4a13f42e8;
	Thu, 05 Nov 2026 18:41:01 +0000
X-Mizu-Trace-ID: 59e87fb4a13f42e8
X-Migadu-Flow: FLOW_OUT
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	chrisl@kernel.org,
	kasong@tencent.com,
	ljs@kernel.org,
	ziy@nvidia.com,
	linux-mm@kvack.org
Cc: chenhuacai@kernel.org,
	ying.huang@linux.alibaba.com,
	Baoquan He <baoquan.he@linux.dev>,
	willy@infradead.org,
	youngjun.park@lge.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	alex@ghiti.fr,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	Nico Pache <nico.pache@linux.dev>,
	Liam R. Howlett <liam@infradead.org>,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	nphamcs@gmail.com,
	shikemeng@huaweicloud.com,
	yosry@kernel.org,
	qi.zheng@linux.dev,
	luizcap@redhat.com,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>,
	stable@vger.kernel.org
Subject: [PATCH v9 10/32] mm/migrate_device: avoid leaking folio references during THP splitting
Date: Thu,  5 Nov 2026 10:38:54 -0800
Message-ID: <20261105183940.2236717-11-usama.arif@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105183940.2236717-1-usama.arif@linux.dev>
References: <20261105183940.2236717-1-usama.arif@linux.dev>
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

migrate_vma_split_unmapped_folio() takes an extra folio reference because
split_huge_pmd_address(..., true) drops one when it splits a PMD.

However, migrate_vma only holds mmap_lock for reading. A concurrent
MADV_DONTNEED can clear the migration PMD, or split it into PTE migration
entries, before the split helper takes the PMD lock. The helper then does
nothing and leaves the extra reference behind. folio_split_unmapped()
fails with -EAGAIN due to the unexpected reference, and the reference is
never dropped.

An existing migration PMD is expanded into PTE migration entries even
with freeze=false. Use that mode and remove the extra folio_get(). The
reference already held by migration keeps the source folio alive whether
or not its PMD migration entry still exists.

Reported-by: Zi Yan <ziy@nvidia.com>
Fixes: 4265d67e405a ("mm/migrate_device: add THP splitting during migration")
Cc: stable@vger.kernel.org
Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/migrate_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 9e19fadfa65c6..3286bb8a4b73e 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -920,12 +920,7 @@ static int migrate_vma_split_unmapped_folio(struct migrate_vma *migrate,
 	unsigned long flags;
 	int ret = 0;
 
-	/*
-	 * take a reference, since split_huge_pmd_address() with freeze = true
-	 * drops a reference at the end.
-	 */
-	folio_get(folio);
-	split_huge_pmd_address(migrate->vma, addr, true);
+	split_huge_pmd_address(migrate->vma, addr, false);
 	ret = folio_split_unmapped(folio, 0);
 	if (ret)
 		return ret;
-- 
2.53.0-Meta

