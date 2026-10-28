Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181379;
	b=cxM5G9jQ3NKUB72L7jV6LresEed5iJyo19Xgfi6wRzu0IJ20wC1FGnl1B3N2HpFUzJ3t
	 DkFzdl9JlH8QX1ycTuK0hHs2i7HHJnQnb7FYdN1bWI1Ga1lkk6vH63L1dJeJOCl15V1oq
	 Gd6Vsl+UhuACEzrWLuS0dgA3cDGno7zTJmibEcwP3TfYHImHnJ4MH8hJNrAXVW6LT7+qP
	 c9qbik7jUcvFORmG+hq51v0lK4DDOFwYtQFlzu2POgSQUYhqU6nnUvSxhNmqXYs7PdQ6n
	 aC47dYrl499kcn6mbsJjYm7K/+hlTUA+ApbeJkPC29z70lldD+zmSSU4PHJ1EF/isyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181379;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dWtfJQ4qPr8yDXmK0xlGw+FpfOgHiCBUnwlQop7LS/s=;
	b=GTZhOvQ6RZmWS7op3qvJHy8TA93yRYxcL+3bGDEnXuGwuI5iyq/K5YlFD58QHhEuLtd3
	 GOrD3lDQZxztGJ58JDkrC5VjpatZRbZS5GYeB7pvZ686LZeBpDmNTswl3AAt4BQq1g7P7
	 gMmlbsezEg4Wbnz2Q0P0tZrK7bMZT9K9FEWzpREuuRvbzJoW2xo57evpKANmqQ+RG98jE
	 9WsE7sbmi+4TeMqZOJ0+On0Y04wBz5CoFU4/v1ja5M8qHLUTjmTHFhTNphNaO2nFh285n
	 Dl1k63xFYWZpj9w00vGmdHbKdRwk/ZX3ZiGES+qooNhFI688d/8urYkpY8341SMwRxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZTpr8PM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B15B606A31A;
	Wed, 28 Oct 2026 09:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZTpr8PM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D8C1F031E2;
	Wed, 28 Oct 2026 09:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181378;
	bh=dWtfJQ4qPr8yDXmK0xlGw+FpfOgHiCBUnwlQop7LS/s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZZTpr8PMhWqbEpAM0ku9pNlwYuzx+2+eSealmEstdVbOX7fJ6wmSpifND9VwMTDNz
	 4gY1pWMsiid+4FLtRFjfJiGN5OwrklKjzCPSReprPTmXK/muvX8+LcXpIYHB11k/bK
	 tW+tkYFBxkmrE5csNluPd3UdXcCnklseapQ2VoZzITeVGhdkM3dwxBYhALNkHSHI+z
	 LYKHhp4Uzy4VPO6KlF9lCCMQizp5qA9QIeJQwhkb1j8araZ5hDOvOC/uH8ygtI8vhG
	 Ru3UzIURxpe100XTcZF80VI8iucM6tmqhFU3cY85/qrK65XJFD8TdWJSy8IwOEFR6e
	 sWIlZj8iylrzw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 10:55:05 +0100
Subject: [PATCH v3 07/15] mm/shmem: stop retrying folios that cannot be
 split
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
Message-Id: <20261028-fixes_shmem-v3-7-4ce3baf2db4b@kernel.org>
References: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
In-Reply-To: <20261028-fixes_shmem-v3-0-4ce3baf2db4b@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=david@kernel.org;
 h=from:subject:message-id; bh=NbZDdS3d0PrLLZ1hQxxWa9fDydv0db7qoW/5IxmDaFY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeHmty1P3QYlqws/Ow6MbbPx7KJdZ8EP+4jKvJbUfw+
 rP75t091FHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBEyvkZGRrFRT7Yz4+9euZn
 xPkvPn5TF4QW3r0347rFvqm3L6tO3T6B4Z/V399f3lvF3+aonbBwUu33b8/qA7P/dqw+9jpSuVR
 IzoIBAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A fault or collapse can insert a large folio crossing EOF after
shmem_undo_range() has handled the boundary folios. If splitting that
folio fails, truncate_inode_partial_folio() retains it when it is dirty.
The final scan then repeatedly finds it because it restarts from an
unchanged start.

Truncation keeps the inode lock and ignores fatal signals while looping.
A concurrent unlink() can then block other directory operations while
holding the directory lock and waiting for the file's lock.

Advance start past the retained folio, whose truncated part has already
been zeroed. Do not move start backwards if the failed split has shrunk
the folio.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
[ david: split fixes, simplify descriptions, adjust comments ]
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index eddd5870be07..50d526edc2d4 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1481,6 +1481,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 						index = start;
 						break;
 					}
+				} else if (folio->mapping) {
+					/*
+					 * Splitting failed, but the part in the
+					 * range is already zeroed. The folio
+					 * was not dropped, so skip it when
+					 * restarting the scan to avoid retrying
+					 * it forever.
+					 */
+					start = max(start, folio_next_index(folio));
 				}
 			}
 			folio_unlock(folio);

-- 
2.43.0

