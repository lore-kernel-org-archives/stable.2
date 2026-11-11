Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420872;
	b=0sCRryGp/qJ0ZcibV4Cu3gKJFfis+v1I5FB1f7nFTod+VTyyZdGkJC5cTGKeI7FZHwJM
	 WzEj+KHfyDGPz7xP7rJdV6XYpk/1J7DtlSeTgS/kYz7cQjybfV5U+m61+sX3ObpzOaTcK
	 LT0/SvhW2BLM2thlKe6QAgSt1tfp//zJnqzd416Apl8oBRHWtkQgQY7/ptGfk55EW1iKI
	 /kIZbZtOwlCNxarLKu9Lg2wVyIppHK9GcGwjILYuT7AfqUj6iUkPyCb4fcPGg/J7lahFL
	 A6+ixa3Rnr0HGMI2JS/J22+4GTOF87iZI45GyU8mX/DIu45Sm4hqqfJu5JgiY1MV2hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420872;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=hnpErT/5ex3ruLHjEk/CH/pFjQzrzGhN0FfCOEgwH8E=;
	b=CBBEizt4j4qIDleqz9M+BirBHN7AuEn4h0iY+lyd4Zw8knrBhppa9YWlCOKbd/AWfEXR
	 jP3YvZokR76pfEGX+pg7EMesKxIclbVsbakmbUa97Xg+JCL0SFPXFrcWvj5Y8Jhu8kYEI
	 /agfQSOr+xu5Em2uXwTo9jCtaIKSJWbFcUh4K4WyMkHPJTsHUXWv5RhUOzempQmbAk26R
	 Wxk3jKyt95s1VuJ7JuU/FGGN6QDS3iP/ACeF4nokbTPguwwzAGLZo4+v7DiENEHFzzT33
	 R43GIIk8OfxYwv7cUITXbxMQy9J6NFxYvwVv4eur6IOvtXo3RGmUcjQDYIfN1YC1nPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gggu3Kzp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C2C606C168;
	Wed, 11 Nov 2026 18:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gggu3Kzp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B607C1F00A07;
	Wed, 11 Nov 2026 18:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420872;
	bh=hnpErT/5ex3ruLHjEk/CH/pFjQzrzGhN0FfCOEgwH8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gggu3KzpzpzxVd847cbidkioq1t/iCuVorKe0gddlXiOBwITTFoL70pfujDKNK1xA
	 jwZyzTeDwM/nstQjwFDRab6o+ZiOyd0QVmYUTYr5/0WmN3ghJ7K0PpvyA3Gbawi41b
	 LVLUE9qOfJMwBTJo9xNrJV3cUzTmj8QaMd3Fq6uPr3WfQ0SFqzfD8/UjYnaVUWtHEH
	 E9JKDTz9Qxep/eg20EupXcOh+1MzGysf9ro3ISes9jEjUIN/0GU+BphsjlSANSQzql
	 NiVSxOdTPQMM1vaxhONoLqnZRPxhaiXe6tfFwu07lgtpbK4Seyt2uG+mw2KXbFGCmB
	 Z4rfzw4aSkIqQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Wed, 11 Nov 2026 18:13:16 +0000
Subject: [PATCH 02/13] mm: cachestat: count each page only once
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
Message-Id: <20261111-mason-migrate-et-al-fixes-v1-2-3d2454362e8d@kernel.org>
References: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
In-Reply-To: <20261111-mason-migrate-et-al-fixes-v1-0-3d2454362e8d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3239; i=ljs@kernel.org;
 h=from:subject:message-id; bh=bQk7Pct3Nv6+Lk3m/yXgydjISRgLjjXotQmEcxH2ziQ=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK+bMj6emSjJs/flWJfGa0+vm6XPCWub20hLb/KLHArn
 3uZYxxTRykLgxgXg6yYIsvzL+L7g0TC5nVe8HeDmcPKBDKEgYtTACYitZOR4e5mQSN13/DzAZ5v
 z1t+zk34rsZ1+t3C71ej9s5ft33tvkuMDJs+hc6QTK7/2yL355t97hWnc1y+ex8mnXX9MuXPojd
 1B9gB
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Chris Mason <mason@kernel.org>
[ ljs: updated to use curr_index, fixed comments, updated commit message ]
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

