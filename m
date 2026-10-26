Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007743;
	b=VvfmRuOsJFbEKYc1J2msLIUR8Pv6cklldan4j50+Mxem7iQinfXpYTF7sI17TwUKpJFA
	 OQ6h2GLNuGcAleCOI/QB9FLl1cy9QwfNQ3b7CMrDADbebYF/2LvIuY4CRp9BzBsG16e19
	 WWCE3W8rZY0EJ/TBEY1uA46BGr9rpD85SOqtT0AawdLjvpFcOnLO8M6doisJE8z3dWa1L
	 hDjNBNzKHgljewle1amm+a+xoM2gvYibw6Kb3KrbtaWolomCpdjYSXCTfyh+prZFEGUdb
	 21Kp6XVTAAO8+Twgvw3QO0ypRh/qg8ZknAX4j1KryyNh8JOcfK/MftQ2ZC5yZel+Kdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007743;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ljcdxIOHbwoigWNhoclMmblcXW+PBjkhYv0wmQViFuQ=;
	b=RRlk7nGpC/xfWd5VMHiSR/dPIxbNOnqgMHCimcDDv+vlUFtqELyhREP3IDkcyhkgVU+/
	 2P7neKCNCE2yV/1h8EJDKEHUTfTXqPjQ2GLYw/7MKJEad4G7KV0CZASKOo/gqD9wVV5JM
	 E9/F2gYl6oeGlvuhB2hI2UCKpj8AHv0TxF4Tpwq747yQN2ujodPcKqJulaaJRYB2B9KKy
	 /EkNuhxHl1ZnW4E2oxWF32Uu8EMiahp+eTt41L8V3vU9OzjwWb1RJuKfZhwObXngt3IU1
	 kQVXSj0W7IoSkEHvOvW38EIGk3NlaNt577pMeIBzw5j+ylLETV8NRbaCOI+Pgn3NlUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYvkGUDH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F12606A32E;
	Mon, 26 Oct 2026 09:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WYvkGUDH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1996F1F01483;
	Mon, 26 Oct 2026 09:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007742;
	bh=ljcdxIOHbwoigWNhoclMmblcXW+PBjkhYv0wmQViFuQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WYvkGUDHITIuwWPwR12HqoyRhUFAy6h7D2GZjbG4VE4gXr7sy72QJNIXs3F5KCaJs
	 q2z+lPQsIi4UaPIagF4/XF0LjXOJDP0WaaxBFC51q9RE7hTdh/VWWb/bCNmf7SNRAr
	 MV+QzMrXcC192m53tetY8803fvgRO4Ms1yEnhvcP+NUfZritkav0ZoUaONMnvpIjD+
	 4cEp+Z+pjH8g/mNzMfpEjr3XUKDDEdFqrPVeFjN8OnxGWN4OJHEiSie5ZGvcsUD7rz
	 gzD+yr8ZRRy5jt3yV8erG5EtN6ZUyNdVCeTtdjFoKPyvPZHcjgQuEsed1G2OaA9wSh
	 elkNNXikanF4A==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:46 +0100
Subject: [PATCH 13/16] mm/shmem: preserve allocation errors when swapping
 in large entries
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
Message-Id: <20261026-fixes_shmem-v1-13-703206d5fa0c@kernel.org>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Ying Huang <ying.huang@linux.alibaba.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Lukas Czerner <lczerner@redhat.com>, Carlos Maiolino <cmaiolino@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Stevens <stevensd@chromium.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 William Kucharski <william.kucharski@oracle.com>, 
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, 
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1410; i=david@kernel.org;
 h=from:subject:message-id; bh=q20WAtGi9Zz6yJcJWGoO/cw3wVyustG3Ar7+W+cD7Fo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4hrTFdaV7N3X2KUVn6/wdbgmU99JyyYYxB9rOp9v
 +I6uStSHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExk6xqG/6E77XmfXzb/UGi6
 6Bq/3fJ88yZZsTXb9nJzPU2ZMu9dUBzD/6TXwrvVb0qkeXAn+K0QseUU3r7WN+7zzbL9N1Uf6E4
 zZAcA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

shmem_swapin_folio() adjusts swap to the requested slot within a large
swap entry before allocating a folio. If allocation or charging fails,
the error path compares this adjusted value with the original entry
still stored in the XArray in shmem_confirm_swap().

Unless the index is at the start of the entry, this turns -ENOMEM into
-EEXIST even though nothing changed.

The caller retries -EEXIST, so persistent allocation failures can leave
the task spinning instead of returning the error.

Restore swap to index_entry on allocation failure so the existing error
path checks the original entry. This preserves the allocation error if
the entry is unchanged and still retries if it changed concurrently.

Original fix generated by an LLM and sent by Josef Bacik in private.

Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
Cc: stable@vger.kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 9e0034a424908..d1716a8da9075 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2563,6 +2563,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			else
 				error = -ENOMEM;
 			folio = NULL;
+			/* Make sure to validate the original value. */
+			swap = index_entry;
 			goto failed;
 		}
 		if (fault_type) {

-- 
2.43.0

