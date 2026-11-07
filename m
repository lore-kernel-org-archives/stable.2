Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046786;
	b=5rg6XGNj8jzqGAqj5cpJPutYF1eGpnpQbiIDDgaY9vZx8wHl6VEZRNrGgvQikdfmjGmP
	 cIccF8fj5UW1gEnSNb7VLPQHZmEMuJEX1c2Xw14Vji/G/wjc+WY//CoZVJxQ7Bray+DpW
	 lV3KOH0x5hiiGA1jawIG0QyKuXXVOJJ1pX0YTXdv5EtE+pEgrMmn/X+WpsOFFWgMGO2lk
	 9GNy+HFkLp7j4wmsY7JvOe4hISZtX271WKSaCruQJYfNRtmzxC+mBsPT1ZyUQwkOUKyvG
	 xQOrtoz3A3aRep5N9N/jf44fvvRJUr7IWFCf7QD7s9Egh7t5p05tFKCFRucc6ZF6AFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046786;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HriJtGDMFuCxs50EQCiyMpL1GcMCxRBKtv7ofMKiOAA=;
	b=fsh98WQRG5VC85DGiz6tjJNsopkHyebJU2kW15/7c6xMkJknWOw58UzBJaDAJtx0Pwjd
	 qp9mTMuLW7eZup5HJ8g0zqQpFepRwRQAeuYr1hn1jgRdyFcqkpY1rcSc+GeUPchxRt1Tk
	 obS62+qAuQNHF7gMihKgsfzw/cdxYI3HfKeXlEUQHkHI3prwXHzI1Xia25tvB3JSFl+ue
	 dqy5YnTnyv/SiJHz5Gm41c4FjdGj8fZLo+gcsNdd3o+exbdpZYkECIJvrEJqrZg6nbShe
	 8hvj3tA898qeHkNYVkeFqe8wVp+2vSIh4L9LEz2WgCGo5+DM5o6pefSNCGU/HklH2cQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb2e7EVT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C23606EEBE
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Eb2e7EVT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8587A1F0089F;
	Sat,  7 Nov 2026 10:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046786;
	bh=HriJtGDMFuCxs50EQCiyMpL1GcMCxRBKtv7ofMKiOAA=;
	h=From:To:Cc:Subject:Date;
	b=Eb2e7EVTvzoiYNSBjBCdGqdqmrF54sELZXdFfBCOvhAx3mE8wqboNzzRuXP02p55Y
	 U6S30aBP897KOVqbbryxsDS7BfrLX1LauwElW8k9bF1F8gGaWM1bpckBNkJzuQ8pf5
	 qsvZQWzNC6XwAAXvkPibCbZlyYuJijP2vwjqgNZxmZ+LKb1BzdUCy1P6dMJyxVvd+t
	 S1fpgYsBBezFHxHOPUG2xZ1lzSRA8lSq25HJhQYmTN3upuTQAb4Z9J48R/7AUBXtqh
	 htYS49NFpunSqDvDTpKUjpna21NIhECA2qLGb8MlGmIJbbKx6amCsBHL9hT7ZOZVyP
	 /wmW4qgkkPtXg==
From: Sasha Levin <sashal@kernel.org>
To: sj@kernel.org,
	akpm@linux-foundation.org,
	usamaarif642@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/damon/paddr: respect folio end for DAMOS actions except STAT" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:19:44 -0500
Message-ID: <20261107051944-failed-6.12-1613ac9edf38@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1613ac9edf385c35f171a25610e2706a7e6afad6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051944-failed-6.12-1613ac9edf38@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1613ac9edf385c35f171a25610e2706a7e6afad6 Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Tue, 1 Sep 2026 06:18:44 -0700
Subject: [PATCH] mm/damon/paddr: respect folio end for DAMOS actions except
 STAT

A few functions for applying DAMOS actions including pageout, lru_[de]prio
and migrate_{hot,cold} in DAMON physical address space operation set
(paddr) collect folios of the given region by getting the folios of
region-internal addresses.  Then, those functions apply the action to the
collected folios at once.  The collection starts from the region start
address and advances the address by the size of the folio of the address
until it goes out of the region.  If the start address is in the middle of
a large folio, and if the next folios are small, some of the next folios
could be skipped.  Fix the issue by advancing the address to exactly the
start address of the next folio.

The user impact is that DAMOS action is applied to less than expected
amount of memory.  Given the best effort nature of DAMON, it is no big
problem, but it is clearly a bug that is better to be fixed.

The issue was discovered [1] by Sashiko.

Link: https://lore.kernel.org/20260901131850.98037-4-sj@kernel.org
Link: https://lore.kernel.org/20260517234112.89245-1-sj@kernel.org [1]
Fixes: 3a06696305e7 ("mm/damon/ops: have damon_get_folio return folio even for tail pages")
Signed-off-by: SJ Park <sj@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Usama Arif <usamaarif642@gmail.com>
Cc: <stable@vger.kernel.org> # 6.15.x
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 2ab7b3842701e..9ddd1ec8202b7 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -264,7 +264,7 @@ static unsigned long damon_pa_pageout(struct damon_region *r,
 		else
 			list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	if (install_young_filter)
@@ -302,7 +302,7 @@ static inline unsigned long damon_pa_de_activate(
 			folio_deactivate(folio);
 		applied += folio_nr_pages(folio);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	s->last_applied = folio;
@@ -350,7 +350,7 @@ static unsigned long damon_pa_migrate(struct damon_region *r,
 				folio_is_file_lru(folio));
 		list_add(&folio->lru, &folio_list);
 put_folio:
-		addr += folio_size(folio);
+		addr = PFN_PHYS(folio_pfn(folio)) + folio_size(folio);
 		folio_put(folio);
 	}
 	applied = damon_migrate_pages(&folio_list, s->target_nid);
-- 
2.53.0




