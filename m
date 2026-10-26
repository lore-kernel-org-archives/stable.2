Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793007714;
	b=JbsD6xlbFB0TYbQyLbUs3cEacL8c6hDXxFm5mwD1WnErKK7AFfCL61lS+jaeLFwelxmE
	 MBLSGONK3F3vXApqbRLOTIx9di/A/VPx+OCh23ZUKzVugHyiQ4l6IpME6iaEbcPTDbCHd
	 XuYQvtRcFbK8lC9DPzkefBEiHqH1pVQeaenVy7ROAzjpYl4HrJ7l5fLO3ZBcztMBrGVt7
	 2kSeRlJ5VCfliyq6yK2zKw/dhhr1k27i0Eo0IcrauIOms1f51IVEW3WmiPnPbLidgA5+y
	 juPPxp22TeWzS2pEl1GiUFSywQgJFyOGGWdZ3ug+GTH5MjTSz6DemwqPo4Ua6OuzlUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007714;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aGpDUDlUvxDHEJHBZRQ3tgIXl+rm1QtshrWtObqHbjk=;
	b=Fjqmph6/Cb1n4/kmnW5WQF8XWNZnv7UJRSzf0DxqyURQwQA+s8YI2vGC9sSTYdacj3jj
	 3rtaQDnazltUrJ4I/Utlb6fj/9vtnCfCjusV7wKZcPKywphlVkdiItq5Sxqoss/U/eEzh
	 4q3NzrhXIavv0HBRQ4fKfAE8XSf0XfyDAQK03FNsyomWHrYY01lR8ptSp5HVTqKc6molb
	 6r+S1B7wfL7WIrXyLvo04Qg9w0poIUdAc3wWM4FT1/wfTZD6xctFj5kdhvP23FF6IQ0cG
	 yhw429xVnkdn9Y9BgYwmhgOzNp6AZMNv+O6XKFyGu3FpCCneYt/7nog1Uf97mk7ufUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAN+Pfx0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D4660A3807;
	Mon, 26 Oct 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DAN+Pfx0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5D11F01486;
	Mon, 26 Oct 2026 09:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793007714;
	bh=aGpDUDlUvxDHEJHBZRQ3tgIXl+rm1QtshrWtObqHbjk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DAN+Pfx0l97EzGHUgR6+hY9dfBsCc7pWR3sIjaIjOTVvtghshSAsBv9hcX8q1HblE
	 3fh3YMs2Pph2GGcogjwJ7O/+IFfzC8GiE1XF8qy2ngbTSy/NwQTFeraQC1YL7WnIhR
	 fEpDr0APRvlivHSVrantysmOjNXgBtBvV/CKNNK12qtJlXERRFWMy5isq0eIUMqnmS
	 rYDGIfBDRaLMCTI7XyJEGDJuQrcpwD71Uy9NLKbHvj5kW5lbQPe03L1d9xDXZksHPC
	 2VnEHdJ7SfA1A8J50R3+GwfY965aSFELcnjaYb896n9s+vnY1dvW6FiW0n1+8z44kG
	 q6yPyiaO6r1+w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 26 Oct 2026 10:40:42 +0100
Subject: [PATCH 09/16] mm/shmem: preserve data in clean folios when
 splitting fails
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
Message-Id: <20261026-fixes_shmem-v1-9-703206d5fa0c@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2232; i=david@kernel.org;
 h=from:subject:message-id; bh=EQ/dFnzmWeu2+S+buSrLImOQdEESG0dp5Zm7vqfc91c=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLLuK4iz6U/dXKOosypTqWf9+Vm5HJN9NsysXzVP9vv9T
 jZ3FynxjlIWBjEOBlkxRZag4PsGL1+uq61242OGmcPKBDKEgYtTACayfhojw5efjec4Ig/7HL7+
 Iuz/MqX1Agu+PP3+ZrvGhO4JFjOf1N9l+KeUWjDj2rs7xn/LMr5zd96Icpyl+Td334clTYK2Jdu
 PfeEDAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

A shared writable mapping can have dirty PTEs while its shmem folio is
still clean. A read fault can install a writable PTE, and a later store
sets the PTE's dirty bit without marking the folio dirty.

After shmem_undo_range() has handled the boundary folios, a concurrent
read fault into a hole below the new EOF can allocate a large folio.
For example, on a tmpfs mount with huge=always, the fault's offset must
be within the file, but the allocated folio can extend beyond i_size.
The final scan then finds this folio and calls
truncate_inode_partial_folio() without marking it dirty.

Splitting normally collects the PTE dirty bits when unmapping the
folio. An extra reference, for example from vmsplice(), can make it
fail before that step. The fallback unmapping on split failure excludes
shmem, so the helper still sees a clean folio and drops it, losing data
outside the range.

Mark large folios dirty before partial truncation in the final scan,
as the boundary handling already does. Exclude failed-fallocate
rollback, which must discard the folios it added.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
Cc: stable@vger.kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify descriptions, adjust comments ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/shmem.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index e2c3b04051833..938221c473f3f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1474,6 +1474,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
 				VM_BUG_ON_FOLIO(folio_test_writeback(folio),
 						folio);
 
+				/*
+				 * A shared mapping can have dirty PTEs while
+				 * the folio is still clean. Mark the folio
+				 * dirty so a failed split cannot discard data
+				 * outside the range.
+				 */
+				if (!unfalloc && folio_test_large(folio))
+					folio_mark_dirty(folio);
+
 				if (!folio_test_large(folio)) {
 					truncate_inode_folio(mapping, folio);
 				} else if (truncate_inode_partial_folio(folio, lstart, lend)) {

-- 
2.43.0

