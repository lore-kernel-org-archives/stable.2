Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917805;
	b=5q6OV62TpXdXa0mXNoZP2P78EAOtfF4BMqmG8Z8uN614RXN0rWkbYvt2pGQCwUymYb6L
	 CeQuKfca4d1jpmS59TbJeExNmfC/+8JbuJszjkYvuB3cM0uKS4GE1MRtNIV4m4ZKF5Ou6
	 oGOY99ZpxNzHVj42VanDeUku/f4t5hs/Le7085/hz3IszIbuNwr2N7zUkSs95QX1MGM0m
	 GxwsFZ3/8qtiQmqIE/DYgQ79R0lAjWqWdGyxrf5Dr1bleIQv+I9qrmOuX3LLPbS0FjhxH
	 x4ith857AOHG/USh/+3BMvlfDI4Z+goNNrUBHfc1hxnLhgc73q8tPFmoHAXDg9tKkVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917805;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xHhwduXYjZsTcrueRZeatOj1/QPkxm9HvyXxSX48zKk=;
	b=eC35wXaicdBQPmhIHcRZ78BxIeu64eacBHM31ALls+J7sabqEQVy7nRi2lfdGe1dnMTT
	 k626qwTkJY8Mb5rADwbKSjzfwh9Pu113kCGqbtrkkNrga6GPOsI/VcKIBs+U3mM0gYo6C
	 jgL29EogZX5Bd2oJbrFi/cOtdG4qc8VRbb6VjgXlXQEVPQketE4fagWkmUXTafReiXJSx
	 HXtClbgJ+visKZY5j/1PY/MbAOdWnAJpCCY+IK8TisKTs3+oychm5MDbkAFPox28q7IkT
	 lGxblYS0RFeZ6xlbaZ9nvznpPi0/njVdP1bujmr+VFwL0BK2zZrrehuXzyP54UdfG8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vYJYhTBL;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF4606A32C;
	Tue, 17 Nov 2026 12:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69EF4606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vYJYhTBL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794917794; bh=xHhwduXYjZsTcrueRZeatOj1/QPkxm9HvyXxSX48zKk=;
	h=From:To:Cc:Subject:Date;
	b=vYJYhTBLfWhmHVROHVOV6S4IpaR1DlHP39ikL7rIeTbcLR6eqatJg6+pMU3MTN3LW
	 0M/92VYt/4YjrABwRe1i+gy03Pi1/WLCV3ldagNjUjuu8EEHejt2lATeXQjx8zJh37
	 fC7F7NQSzE6M2zVM+bvM1CdoMSRqA3h7p76P204Y=
Received: from DESKTOP-6LNKCJL.localdomain ([114.245.39.251])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 41B01800; Tue, 17 Nov 2026 20:16:27 +0800
X-QQ-mid: xmsmtpt1794917787ts32msj22
Message-ID: <tencent_1B8BBAF215484255F04168752D9BA778EE08@qq.com>
X-QQ-XMAILINFO: Nx5J06Esz7r7tOdMo4oLhcU1HEvq6piSmNZYgze6EELdW4f4Dk9mRfb2x4T8Xl
	 9ctfO5b2/AZffMmxAo7EgJG1/lOiz1h3R46i2psvEfjh0ssoBPYjaSBptlp3JCaEJ1aeAEOQizG/
	 n56t8jOOcvqNK0+DjPsAqIuo7lxd5bA6S/U93XSK3EYLQF0Ttkarh0UTfsIWk6v4LmZ49FaBjcNJ
	 xkAE4423kkrzGty/5lEn44ODq0YpwM4NpfJmoC4781cv7OEJ9+Qly0GFlfXZJGH4EdHI0T25wCyW
	 ts0enf5OsxAk0lUrWToNja8MOzIe0xInipZCvnmU35FZQJ5bzxut1PnmhCFt0RqpFd/yn9tjeImG
	 LC2VaNq3gPTBpBYFElsYvLH8l3zDfisQvS3fSR8J6BEgUMDG0SpS+mjlq7Cp+riYGGco+diVZS8p
	 aiPJhxOpOjAqlX1omY0XGt94k8oAr8UfdMoUFseLx+Q7LOc9kwN5Rb7BZt8atI93XBrXi0TgvI3E
	 cxRl3aF4COHXMeTVK6nP6LXY0uPvECxANe1DxUC7QpzuNJVPy3H0/jrXGn9NvfrzoNLjkiebE4HK
	 75oMrkvlUFg0FOeppkESVTmsRDIleD7AHKcURwfzB7MYdo/Xurme5okgtxV3fzfYM98hHiutVtGw
	 6PLg588TkomDuLLweuEL06EzjfEhXJaW9AzsE4de6qVoeb1WGPxcY2SfX8Nt2Km2gfiwEiqqTbma
	 krH2mfPRFT0X3zNqMndSJS1/tkv8p570KYsbZ0cwH8ayEEs6AvtU9IyIdWZXaMLllAjr1rurNRQb
	 99xvatiOArzF4KbSzFH+IQnyqrfJPRuRqMFLNOmOwMh8amv9WL441u9k3zjuj+xcG8kK2lf/PhRg
	 hDH5RlMgVy/TDhUdFr4b94GkqGF+UUr1azMBYBEb6YMnCspQE1eT+fRZb3mJEp92tn3Lhf1agGXa
	 su7xHHr6OawkJm1oZjlSikQmUKKagBzKqFZwC9uue+dv/XaayOWviyC0rUtY6yAA0MtHVejgATAK
	 OWlqvNTBBLICkuwVBBnGi1Ra1C/DEz3o6/tGhGfYIYjPL7vGLMEE03GUFITK5nVNQ8alXccm0mdw
	 81iKfTyVE6rUFFwZIAHRpayDk2dBv+kVb5Xowu
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Jingyi Sun <1045704958@qq.com>
To: Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH] mm: shmem: limit forced anonymous shmem huge orders to MAX_PAGECACHE_ORDER
Date: Tue, 17 Nov 2026 20:16:26 +0800
X-OQ-MSGID: <20261117121626.1058-1-1045704958@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the top-level shmem_enabled knob is set to "force",
shmem_allowable_huge_orders() returns huge_shmem_orders_inherit for
anonymous shmem without masking it with THP_ORDERS_ALL_FILE_DEFAULT,
unlike the other return path at the end of the same function.

huge_shmem_orders_inherit defaults to BIT(HPAGE_PMD_ORDER). On arm64
with 64K base pages HPAGE_PMD_ORDER is 13, while MAX_PAGECACHE_ORDER
is 11 because of the xarray split limit. With shmem_enabled=force, an
anonymous MAP_SHARED mapping can therefore get a 512M (order-13) folio
in the page cache. Splitting it later, e.g. on swap-out from
shmem_writeout(), triggers

  WARNING: lib/xarray.c:1051 at xas_split_alloc

and the split fails, so the folio can never be swapped out.

This is the same problem that commit 9fd154ba926b ("mm/shmem: disable
PMD-sized page cache if needed") and commit b66b1b71d7ff ("mm: shmem:
avoid allocating huge pages larger than MAX_PAGECACHE_ORDER for shmem")
fixed for the other paths; the force branch was left out. Mask it with
THP_ORDERS_ALL_FILE_DEFAULT as well.

Reproduced on v7.3-rc2 in QEMU (arm64, 64K pages, -cpu cortex-a72,
4G RAM, zram swap): with shmem_enabled=force, a PMD-aligned
MAP_SHARED|MAP_ANONYMOUS mapping of one PMD size got a single
PMD-mapped folio (ShmemPmdMapped: 524288 kB) and MADV_PAGEOUT
triggered the warning above in 3/3 runs. With this change: 0/3.
shmem_enabled=always and 4K pages did not show the warning. The code is
unchanged in v7.4-rc3 and in mm-unstable, but the test has not been
re-run on those trees.

The issue was found with a research static analyzer for
cross-architecture dependency bugs and confirmed with the QEMU
reproducer described above.

Fixes: e7a2ab7b3bb5 ("mm: shmem: add mTHP support for anonymous shmem")
Cc: stable@vger.kernel.org
Cc: Luiz Capitulino <luizcap@redhat.com>
Assisted-by: LLM
Signed-off-by: Jingyi Sun <1045704958@qq.com>
---
Note: this touches the same line as "mm: thp: always enable mTHP
support" (Luiz Capitulino, v8 14/14), which is still under review. That
change masks the force branch with ~disabled_orders but does not add
THP_ORDERS_ALL_FILE_DEFAULT either, so it does not address this issue.
Happy to rebase on top of that series if it lands first.

Link: https://lore.kernel.org/all/752f528f0fed5cdc9de12b54260b0495d4e5a6cb.1789695931.git.luizcap@redhat.com/

 mm/shmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 10cef89b00b0..41bb3f2c6b63 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2114,7 +2114,8 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	 * means non-PMD sized THP can not override 'huge' mount option now.
 	 */
 	if (shmem_huge == SHMEM_HUGE_FORCE)
-		return READ_ONCE(huge_shmem_orders_inherit);
+		return THP_ORDERS_ALL_FILE_DEFAULT &
+		       READ_ONCE(huge_shmem_orders_inherit);
 
 	/* Allow mTHP that will be fully within i_size. */
 	mask |= shmem_get_orders_within_size(inode, within_size_orders, index, 0);

base-commit: 666539eecdf4db623f5e3c3e55cf9f2dfad24aa4
-- 
2.43.0

