Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057486;
	b=CXjb/FoL6YK+j9HeQkJEtnAewuFF1yoSbNk04ydgOiJYMSWG4IYVkICXTgXW6sRfQim1
	 SjJ1ZJZo20torTsTSUHlyuSw1rq804yE1gpxM93jGZptyMEB6ApTlkqGYKcXESEiWJ80J
	 ZDw1D/QIuHWFaRnNBpls3JaMuEMXE6WxaLG/4KU8GQZe6bLdvpS0/8sEFhDarh7HPMyFR
	 EosgcfxilQ5zOk6kO9H++UJI4mAH6ecaLXNckpXcsEomIXy+iGlKfPax5LI+utJbdpZvw
	 a/MNxIGQftkhsgFvGURs6PcTiXS5LmeBnxfQZIcze8FZy8o9hu4n/ffpHPNP/UP9oKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057486;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=lkeUnC+ke2SeHckxsNXGFCsvZLAe8AN/2/cLkPRumtM=;
	b=aYKlAD76MntT/mT8QPrPkRstTifml/ugJgZbS9rsd8EfggCKsdXDnw/1vovaKRQMj7Ve
	 A0h5Ga7NvdZNdRgWCxuv3rHkz/k5xQarTz8ZEWyC4zIY8RyoVEwZsh5kuN0Rgas/ITRGo
	 pR0Chv0xjYv78Xo3tnsSIPGGYaerbLoEegxhGLTCNH89MWf8JUzwklN9MBzXQfwcuMac7
	 egD4zRyQFciIsTUxN3yNWNV5NWnIDZYZV/MJ03apj/L4WWV0s6XGRmcyrs2S8E6p9VxtD
	 naV4G6ss2cit75NafixyK/2EjAqgdpKejhAMPQFkPrId1L7m7QRa/O5OmTkjEGo+XKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLVL6FXg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106F4606A324;
	Mon, 26 Oct 2026 23:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WLVL6FXg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4037C1F031E4;
	Mon, 26 Oct 2026 23:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057485;
	bh=lkeUnC+ke2SeHckxsNXGFCsvZLAe8AN/2/cLkPRumtM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WLVL6FXg0vHz/gidKve/pjODS+0haZDG7Pz9wt1w6lIJRrIezoVOGFFxeQnFGWJUC
	 Oh1S/7Ts9XcXEHskvuXv4xWsR9U6n5+ghh5PrusNb19hSOJZLkpWQW7jm+f7LppoLp
	 nRdmsTY5ydvVfPPBYKfSFog8rg3u7fckoyrMVJcewFoW32wez6F1F681g1rez9jjlo
	 VpYGoehVJXN5aYjbNK/5aiFRgWQlMXHycy1oszm2PIaDU4bSRaezAblXErdFsv+nGK
	 WVM4CKwy9q9O57aOMot6Sxcl2q9ipgojiGwZK2yMXBqW8slqmRQD5V5djgEkP6/coW
	 4+3g/vQdhBtFw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Tue, 27 Oct 2026 00:18:03 +0100
Subject: [PATCH 43/46] mm/vma: don't leak the charge for stack growth
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-fixes_core-v1-43-6f74bec9a5bb@kernel.org>
References: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
In-Reply-To: <20261027-fixes_core-v1-0-6f74bec9a5bb@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
 Lorenzo Stoakes <ljs@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Barry Song <baohua@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
 Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
 Baoquan He <baoquan.he@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, Hugh Dickins <hughd@google.com>, 
 Pasha Tatashin <pasha.tatashin@soleen.com>, 
 Pratyush Yadav <pratyush@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Zi Yan <ziy@nvidia.com>, Lance Yang <lance.yang@linux.dev>, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>, 
 Alistair Popple <apopple@nvidia.com>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Xu Xin <xu.xin@linux.dev>, Chengming Zhou <chengming.zhou@linux.dev>, 
 Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Youngjun Park <youngjun.park@lge.com>, 
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org, 
 stable@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1191; i=david@kernel.org;
 h=from:subject:message-id; bh=ALGNQwhpLft8D6XNQK7dKBbPofsh/OWRq1n/Y7LvvI4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLu35/xmeH/Ej8mv/5em33yHRWMvuIu37qv79rNdMFa0
 H1pQcX+jlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACZSfZyRYfrPY5yHLG8pNPFE
 GU/wzQmSbHFNljx4/M/6qv9bn2izcjL8D1125f3Rlhh7VfZ6A4uzkXN7GiZLX9/2JpXJkNnP+P8
 xLgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

acct_stack_growth() charges stack expansion even without VM_ACCOUNT.
This can happen for read-only or MAP_NORESERVE mappings created with
MAP_GROWSDOWN. Unmapping these VMAs does not release the charge, leaking
Committed_AS.

Only check and charge growth for VM_ACCOUNT VMAs, matching mremap().
Unaccounted growth skips the overcommit check while remaining subject
to the other stack-growth limits.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/vma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/vma.c b/mm/vma.c
index acdf00346cda5..695d0be85ac86 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -3391,7 +3391,8 @@ static int acct_stack_growth(struct vm_area_struct *vma,
 	 * Overcommit..  This must be the final test, as it will
 	 * update security statistics.
 	 */
-	if (security_vm_enough_memory_mm(mm, grow))
+	if (vma_test(vma, VMA_ACCOUNT_BIT) &&
+	    security_vm_enough_memory_mm(mm, grow))
 		return -ENOMEM;
 
 	return 0;

-- 
2.43.0

