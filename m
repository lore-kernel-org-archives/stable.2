Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270693;
	b=LHGMlYTtgrzBpnjTqxsKkJW6xS6YQsxwFOFEPghIcbtHdhj77sUUYsJSoLSRYD2Lgfzc
	 e0OvrJxJtt3g2p8wM2yqtBIY0cIt4R9qg+Jy+IQdxedSlfEsWxzZ4frpURFnVdxG23PKC
	 FrE3q4X/jZwOcTuEM/BirTg8M7D8F/ToFp/GRBgxiW9+LUXCNbh/Xy/RqcmUJcIdDPS+o
	 RGBZRJtKP9xYXra4qj6Y+3m9GoFg7IuetIObre0UJlKwkDnxcaeOLCmFF7nfQj4++T1C5
	 9TvTIPCW/NWtimIsP7l+abhlMs97EC2XwlOA+aFDEMR9HBw/GXUvflxaE+A0fvMiCWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270693;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/95lv6aVada0IifKxWvdrhbpIXNviWW3ADyrNE8l91c=;
	b=WgFivz591Wyq8AkwmLbC+pU0tb/FHReGUgKL58URfe4f44EyJXtUQJRQt9lug7x3gDPW
	 Bl8W5SWvClVB8tOH2XCHZg/iXq1XSyuraXbyWU4MEZ+kGoBw2Ntr1Ti8X2HjiS+CpnXvd
	 VGCBIb634Jc4Iq/hTDBOmuq3r+ejMRDDWi+WNDR34VfqQlZhLEIJA6ExcBoHqQre1WKIq
	 XFkXRyzAEyj1289Q5apnRPZMntT8bBEf4Axn5VYpHn4WntxrlOLjTPhcut62QJLxQOasy
	 layt17DmomgpX1/Wrlz22/khJOGi8ohH+PiOAmkBu1cTDRfXrieB80ylDkVm5K3ftLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hKEZW/No";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4BB606A31D;
	Thu, 29 Oct 2026 10:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKEZW/No
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95BDD1F031E0;
	Thu, 29 Oct 2026 10:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270692;
	bh=/95lv6aVada0IifKxWvdrhbpIXNviWW3ADyrNE8l91c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=hKEZW/NoFy3UQ8cF/iokzenKy88As7+rDs1tkqhAvtPrWIgSfKZVccTYUQaU/a153
	 pBIpsWHmOzrvlEuJWbRL3PpseIDHcugAc4c4CWrOYdV/8vVjD42IbzYJwIytB4pNnU
	 e3X7pksgyx/WdJbInFvU9HCYov3vPig6MLB9HhMps4nx7WpLUh+y9mCP8e4uVZL4vM
	 47oVA0JplPB1pJXZT68hCC3CCxjMYs2RJqKKEloTo7m9VsiErn5aELfYe1fkA/IH5F
	 Q4AazYf1xrTW2gsyWoCvhtJzYYDixMndIcI9UGfvghs39e7omE3Vo8aDagJKI6xumz
	 xJuxVACItU8pA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 29 Oct 2026 11:43:28 +0100
Subject: [PATCH v4 07/15] mm/shmem: stop retrying folios that cannot be
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
Message-Id: <20261029-fixes_shmem-v4-7-392fc715d8f6@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1791; i=david@kernel.org;
 h=from:subject:message-id; bh=ZAjzOB+Z7IuIURTjUdGNPAA3MOXXkABgEGbnq/FphJc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIeK4dNYVP/5RhZam0gvNowdeFDg93ObdWJxk0+O2/5O
 5wyZ8rpKGVhEONgkBVTZAkKvm/w8uW62mo3PmaYOaxMIEMYuDgFYCJz+Rn+cC0rY4uLeLUl4R1/
 T7DsaZWJPM/8b3BKNrt0/2CYkm8YzcjwfeY22Sj56nWsXJIXbp01WeN68b1/3czCZotH9bu+8TY
 xAgA=
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
index c44d2dd71c89..af49d6bf6382 100644
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

