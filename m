Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39377298CAF;
	Wed,  9 Sep 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973869; cv=none; b=Ajr6Ma+d72wfee257KRpv2iFhErvJ3JP70mc1RQKzEum+ZM+I38Y3WfzS/s5y9l+y9Te/MLRVDafHOoHb7p97jx+roNQ5hiySdUnAtXO5B6Yn/ETREhKp3zV4bAzeQ+ynCtTNpCm/Kr8asGRZwcWt6iMnDdwR9JEBhbl7Xxus24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973869; c=relaxed/simple;
	bh=5nP3SABh7khN0k7YsgDDCUFgWm+k/354IDRR6uf5BpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZqPeMc9h+1Lt4mWCeiUmVyNH65vFqGw5WOz32bOlg0YOHdEAC2clSKkDM8E/1t3VZkDqGdx92lI3vHy3gEw9CRTK3lW88sH+N2Um1OWhf81y92MwWMHvf5rbNVX3A0s3Xi661dOPM/wXnHRLs94rpqi3zetVs/MpsiQ4elNk59I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmAksmPa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmAksmPa"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 109AFC2BCFD;
	Wed,  9 Sep 2026 17:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1788973869;
	bh=5nP3SABh7khN0k7YsgDDCUFgWm+k/354IDRR6uf5BpY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VmAksmPaODm6zzhe9HR1j4cII72lhpikhFZxWcW/l60t9hnfbxjdgPSMyR425+YyY
	 RFLityF9xzDPGTya3J3lhi8BZqxxY3POBFMjUXKz6jBzdntVwlpPCxwdWyytdlklqz
	 aH731ahR6rjt7XR4sWl5JIfKAbMcnwFL296V599iAMbwUNsGshp5d5DPPANSCZN/wt
	 KpG8OXysJllfLLf8h3a1kogIxyOGiqvu+xEm2mmqxDZhtpEyzMtXalfKvghWSfseJg
	 0BeMjeWgbx+s6Ok5l29qjezQFysz2zeUNdwPCkNJv2O0uAFVit3MNihZ0NAQ7kpvfq
	 BKHmXiqFAjnwQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47E9C79FBF;
	Wed,  9 Sep 2026 17:11:08 +0000 (UTC)
From: Ackerley Tng via B4 Relay <devnull+ackerleytng.google.com@kernel.org>
Date: Wed, 09 Sep 2026 10:11:01 -0700
Subject: [PATCH v2 2/2] mm: hugetlb: Drop refcount before freeing on memcg
 charge failure
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-2-4b4a8a19a7f7@google.com>
References: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-0-4b4a8a19a7f7@google.com>
In-Reply-To: <20260909-hugetlb-alloc-folio-memcg-charge-error-handling-v2-0-4b4a8a19a7f7@google.com>
To: Alex Shi <alexs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Dongliang Mu <dzm91@hust.edu.cn>, 
 Hongxiang Lou <louhongxiang@huawei.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jonathan Corbet <corbet@lwn.net>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
 Nhat Pham <nphamcs@gmail.com>, Oscar Salvador <osalvador@suse.de>, 
 Peter Xu <peterx@redhat.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
 Shakeel Butt <shakeel.butt@linux.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, jthoughton@google.com, 
 fvdl@google.com, rientjes@google.com, vannapurve@google.com, 
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
 Wupeng Ma <mawupeng1@huawei.com>, Yanteng Si <si.yanteng@linux.dev>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 Ackerley Tng <ackerleytng@google.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788973868; l=1354;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=RCk4FUhHtfR9+WkuFadogmxvoeEME9GEkAvOLYp7r3U=;
 b=gBpcMiO0hmn63lrRPn7N0MR5W2dOzYOn5xT2nETVl+UJrZXPV8t92Dbe0aMohlnvWSzSzqKO6
 Lcdbw5LVxr6DJq6Hl54+GpzcN4ODPHZbPRq6605zAFWp8ctP3310CTf
X-Developer-Key: i=ackerleytng@google.com; a=ed25519;
 pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Endpoint-Received: by B4 Relay for ackerleytng@google.com/20260225 with
 auth_id=649
X-Original-From: Ackerley Tng <ackerleytng@google.com>
Reply-To: ackerleytng@google.com

From: Ackerley Tng <ackerleytng@google.com>

When mem_cgroup_charge_hugetlb(folio, gfp) returns -ENOMEM, the folio has
its refcount set to 1 via folio_ref_unfreeze(folio, 1).

The error path calls free_huge_folio(folio) directly, which expects a
refcount of 0. Hence, VM_BUG_ON_FOLIO(folio_ref_count(folio), folio) is
triggered.

Even with CONFIG_DEBUG_VM disabled, returning a folio with refcount 1 to
the freelist can corrupt allocator state later.

Use folio_put(folio) instead of free_huge_folio(folio) to properly drop the
reference before freeing it.

Fixes: 991135774c0e0 ("memcg/hugetlb: introduce mem_cgroup_charge_hugetlb")
Signed-off-by: Ackerley Tng <ackerleytng@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: stable@vger.kernel.org
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 522487d341841..f5b853a5377c2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2891,7 +2891,7 @@ struct folio *hugetlb_alloc_folio(struct hstate *h,
 	lruvec_stat_mod_folio(folio, NR_HUGETLB, nr_pages);
 
 	if (ret == -ENOMEM) {
-		free_huge_folio(folio);
+		folio_put(folio);
 		/*
 		 * Skip uncharging hugetlb_cgroup since the charges
 		 * were committed to the folio and freeing the folio

-- 
2.55.0.1007.g17ff1f9808-goog


