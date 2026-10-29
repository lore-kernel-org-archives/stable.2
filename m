Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270736;
	b=epiuVOCcgTfXwVvqpWDPxAoZGECRGXr4WBg/tvDiA0AGV0Fky0VmO+IuvOpyEFsMuFUJ
	 usOlwuj4ip9oiKzzQNt4sde8KxSFzTsaythSawiUUNqd9C4FYAfDurFrnKskBVdIVpEdY
	 MFgBmcrNoaco/xix+Xgx8fehyzazswkty4Rn56Z7d6YfrvgB/+0hgah/BF5LLyN91rDxP
	 +xaPrvJIvcT+EBqKxcQh94VJwpmEScQvzgVW7vCZT6+lQlawylHiZC1X8v01mA5+qglAN
	 3rih9ZOoAvJGLDW6xD4MMb1ktwHjE5VSD+jllFUIkFYoexz8V1yRUpA8c2/WRO/ETeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270736;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=0fxJ1yIZnUumW1Gvcfcp9HFQq0zCF7wYA9AuvuvXBWc=;
	b=fQQxFb2Y9ZSypNoL9kAA0g0ca/kTbNj4EaxXwSQX3WyuwtIZeWFprCQYmvQdWrSnyEeD
	 +ujhRNofZLxI9kNNhcI/VP/zFoTQmNWvJghBe89iEvseLzDEEYmxHXDTUE1eKUqODmhMh
	 wYiDjFLf/bg0D53XEcLwXjWjFl4OtdrvWhchPPdpOwkeNwKHmYTORmkAgh4zY4SC+ipYK
	 ldxFq6jplWvIa+aw/hAWtdH14kEKy50H5kgZaXWfPRvSbhgbdAoICqouoneb/ag06nm7R
	 3oVTe3nbSc1o3xPIR+YeTRiL71b/6/55/wTDDenH2+4rl8hc0vqxyiyk+w9tg6sexVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY2WSYrS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F45B606A326;
	Thu, 29 Oct 2026 10:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KY2WSYrS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AA81F01825;
	Thu, 29 Oct 2026 10:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270735;
	bh=0fxJ1yIZnUumW1Gvcfcp9HFQq0zCF7wYA9AuvuvXBWc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KY2WSYrSAZkUAfPZMrMsx5s36BqbaDUK+7BvSQwkci2fEIxnAa3xelYkAzkMmSG7L
	 IgEqM119VkmsnG8dfE12u+oOdMyG7g8SIu8HsM6Hxo9bv5mrTJLIWMq/Zx9CueNUKf
	 II7OgBOUS6/L04rBwXsRrj8+LCurvC+JTW+liZhssZgviwuN0wJ6eirbWolHEj1kar
	 Mtj6uehUVnoaOWjn1JMt9QaFn3HZ8PTZSwNtnDAp3kvhL1PWr3dhYoVW+eGYzObhCl
	 BzxPgb+IFzmlMOlKAqNg8aSHH4Gybk4cLRBC3BJKA2svjqIWREfWK+xjrtklMx3Pi8
	 HBIVilPTrkFJA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:33 +0100
Subject: [PATCH v4 12/15] mm/shmem: preserve allocation errors when
 swapping in large entries
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
Message-Id: <20261029-fixes_shmem-v4-12-392fc715d8f6@kernel.org>
References: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
In-Reply-To: <20261029-fixes_shmem-v4-0-392fc715d8f6@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1547; i=david@kernel.org;
 h=from:subject:message-id; bh=/qXGMJ2+Vc8UHm0Vypsyjzej9eUaZtHiT5EAktCFeu4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4db7fTebfvxomo7W7/gYnm9LZLnmNs3Ntz5bHJXY
 m3MpM3aHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEykcjcjw9KU61svWB5VWCvo
 Y5IXNleV9fGtJw1xVX1q+tf3xygeCGP4X7f6NK/LVyWjV8uLGBa9bOFwbrrTk3yP8+Pms4KyokK
 8rAA=
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

Fixes: 91ab656ece13 ("mm/shmem, swap: tidy up swap entry splitting")
Cc: stable@vger.kernel.org
Reported-by: Josef Bacik <josef@toxicpanda.com>
Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index e1b7cf4b5280..02de6326ef3b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2552,6 +2552,8 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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

