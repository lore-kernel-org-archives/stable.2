Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794606360;
	b=baJgH+seYwpcgrhEvJ5Hys4y48xiBWuoSWRVVYLjSdEGe7mI+6GthFRXlG1Uhs3uirTX
	 TZ6aSk2dnHQfI3oKLCJjrxJOWr4sR2ImJbDQhBcRHYy73b9CB7jHM0m3aDdjbe8TfpbNI
	 zyjtrmkPPhNpJJBYcvXsLd2o8cJ68bowzAW7juR1BCFWd6ZoeD2SbpUfOmIX3hkxV5u00
	 +q/P8Pk2Edo3/CQSzDuKqXqU32B9tuqsJ/tHZfZLFdA/yadJt4M6JLV4Zbm4OiEUK8UGL
	 037lA7mo0maQMWUbq/2qWNgWVmHQ9C4UkNNHSQKHSwFT0+z/lLdOF4ahrF3h7/YxLYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794606360;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q7kRhLj0vZ7LFs2r4iaCcpOTG24J8Ze5ZTlEa/aA2j0=;
	b=GCWAqcKIV7xahpqbdDQnHjnbyHe0P8f6HLGUN0swcWOHaS99i9Lls2OUJXTRJ8Yz7SbW
	 qew+rcHHUqO08mGu3je2rTvbzi5iLEr4wdC7D5DHWFk4jwbKMdYtoxNrtP2nKRedbLjv+
	 ZxVzAZFak8mwQg4fBFUf8EmK/yTAgrY/lFRUU5WeGasGlI09qCTds37fMV7iCTxtte+F2
	 dt6dOl4XXeZkt83XeXtlht/0rxUzChyAuWGVGoB2p/dWakE/O52w0UlYHf4lWNGgrJSEp
	 u2HSpx6kbKAdMvkIJWSBRFQc3ZI9ExhnkyUL9tp/DvKBIgAMNo9NJQpqjmwOPvVldCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y34JoCp4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C123606A33D;
	Fri, 13 Nov 2026 21:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y34JoCp4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B698C1F000C4;
	Fri, 13 Nov 2026 21:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794606360;
	bh=q7kRhLj0vZ7LFs2r4iaCcpOTG24J8Ze5ZTlEa/aA2j0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Y34JoCp4LxRMKvUVbRz3LK0bkmsIq9QMdl00WVSlZlUveIlw5q1L7EeOKIai2GI5Q
	 Qjrky0JL6fDi/DbB5Rl6UfNVPzzsBwtFnK6eoBcIWj6hmEAKkEMqbaQC97cUF1dS/X
	 ZoLMjON1vwtAz6/HnWMIzGaWTNvjvIp9bawHtjrCbpXYuqC2ekUlbkx4X8kCusGfde
	 1IVPjFe8OgshVbiNKbHrAw4Sgs+xVcE5xkcFzJBKUr1C9CdnAqLk8T8AgENA5qhtnp
	 M3Oq7VjXMlb22yaBwO7GfsqLt6fj2oOXnYeQvP/82NZbLIERoO6upynfBJn3O23d2T
	 W6cATDfdF4YoA==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Fri, 13 Nov 2026 21:45:20 +0000
Subject: [PATCH v2 02/13] mm: cachestat: count each page only once
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
Message-Id: <20261113-mason-migrate-et-al-fixes-v2-2-50a2ed382b61@kernel.org>
References: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
In-Reply-To: <20261113-mason-migrate-et-al-fixes-v2-0-50a2ed382b61@kernel.org>
To: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Andrew Morton <akpm@linux-foundation.org>, Jann Horn <jannh@google.com>, 
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Usama Arif <usama.arif@linux.dev>, 
 Kairui Song <kasong@tencent.com>, Balbir Singh <balbirs@nvidia.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Glisse?= <jglisse@redhat.com>, 
 Kiryl Shutsemau <kas@kernel.org>, Yu-cheng Yu <yu-cheng.yu@intel.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, Dennis Zhou <dennis@kernel.org>, 
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
 Peng Fan <peng.fan@nxp.com>, Josef Bacik <jbacik@fb.com>, 
 Chris Mason <mason@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, "Borislav Petkov (AMD)" <bp@alien8.de>, 
 Mark Brown <broonie@kernel.org>, 
 "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>, 
 Rick Edgecombe <rick.p.edgecombe@intel.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=ljs@kernel.org;
 h=from:subject:message-id; bh=/lH9dpcfdnjcbyszDCTpwOv7bWKPPrM5NccyMQXngic=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+t/ww8bNfUBhxYVryBs2ZHTNVClfG3pFZoHOxxmwSM
 8vcRSmMHaUsDGJcDLJiiizPv4jvDxIJm9d5wd8NZg4rE8gQBi5OAZiIpi8jw68nzNPMH/9y53P+
 Jq3nsW7i9Os5Wr/4p+j9lYnvV7VcJsjI8IPx4QGVTfMXG/37x5q36tMxQQGph5/crEwZEm4E5Wo
 v4gAA
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

From: Chris Mason <mason@kernel.org>

It turns out that filemap_cachestat() can unwittingly return incorrect
page counts, if large folios are present.

This can occur due to underflow - nr_cache is nearly 2^64 on a 64-bit
kernel if the input range starts more than 64 pages into a folio that is
split during the call.

It can also occur due to pages after a large folio being skipped if the
range starts in its second or later XArray slot and the call reschedules at
that folio.

Finally it can be caused by pages being counted twice due to folios in the
range being split or collapsed during the call.

filemap_cachestat() walks the page cache under the RCU read lock only,
and for each entry it counts the pages that lie in the range. It does
not track how far it has counted, so the counts are only right if the
walk returns each index once.

But a large folio can be split during the walk, or small folios can be
collapsed into a large one, and the next entries then cover indices that
were already counted.

Resolve the issue by tracking the current index as one past the last index
in the folio, and explicitly using xas_set() to set the current position in
the XArray.

Additionally, add a check for folio_last_index reaching or exceeding
last_index and break out of the loop if so.

Fixes: cf264e1329fb ("cachestat: implement cachestat syscall")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: updated to use curr_index, fixed comments, updated commit message ]
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: Usama Arif <usama.arif@linux.dev>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 mm/filemap.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index b04be64a5069..7c05e4fad081 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4638,6 +4638,7 @@ static void filemap_cachestat(struct address_space *mapping,
 {
 	XA_STATE(xas, &mapping->i_pages, first_index);
 	struct folio *folio;
+	pgoff_t curr_index = first_index;
 
 	/* Flush stats (and potentially sleep) outside the RCU read section. */
 	mem_cgroup_flush_stats_ratelimited(NULL);
@@ -4667,13 +4668,19 @@ static void filemap_cachestat(struct address_space *mapping,
 		folio_first_index = round_down(xas.xa_index, 1 << order);
 		folio_last_index = folio_first_index + nr_pages - 1;
 
+		/* Skip already counted entries, e.g. after a split/collapse. */
+		if (folio_last_index < curr_index)
+			goto resched;
+
 		/* Folios might straddle the range boundaries, only count covered pages */
-		if (folio_first_index < first_index)
-			nr_pages -= first_index - folio_first_index;
+		if (folio_first_index < curr_index)
+			nr_pages -= curr_index - folio_first_index;
 
 		if (folio_last_index > last_index)
 			nr_pages -= folio_last_index - last_index;
 
+		curr_index = folio_last_index + 1;
+
 		if (xa_is_value(folio)) {
 			/* page is evicted */
 			void *shadow = (void *)folio;
@@ -4721,8 +4728,11 @@ static void filemap_cachestat(struct address_space *mapping,
 			cs->nr_writeback += nr_pages;
 
 resched:
+		if (folio_last_index >= last_index)
+			break;
+
 		if (need_resched()) {
-			xas_pause(&xas);
+			xas_set(&xas, curr_index);
 			cond_resched_rcu();
 		}
 	}

-- 
2.56.0

