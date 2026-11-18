Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.240
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794969937;
	b=aLZR3KWO7TDuA+ff1ufGRtkAnOG3UZTPUfjtMleT9dF5pZi3rj//C+L89C2YteuAKRtZ
	 E7Xd7y7uLf/n71uLJYg4UCYj7kwQyJKSeEJDhpMDTm+B/a/5vbSqB6nFHq3NYu3dN+vLI
	 B++dSs3PonOgk7YKX2ij7rhGnlzgok6W3bhS037Dx2nkxKXqj5rmcmaTjcjxwLKQKIzkd
	 rYu0BrdLFlao3qVGnlUW6K2YVVqCTBEfpftG4O3dL9o9JkeXf/JFPhrvu6Jd5u9Xcb3wj
	 A3l7k/AADlgygUqCDbYSM3wYnDseo+M3x5mnavyujFGMyh7P8MnCn4pyi+AlbMyePNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794969937;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=aWUwZ4yOXRgwWXdv9mQMt4h2IPiJ7i2CqyiC71rxZrQ=;
	b=qXVXFR7w180nftMMkb/p5pes1oixTMRxEUGEYMr1n7GVlnVuzPCUAgNf9JVbPnaoisEn
	 SR5os0bZvYNJikWUrb5uX6sCP5BQ0rlynh53CL8NHeXEM8W0zFfWHl251V0R0lfz6MUAh
	 ljojZiI+OGJo3HD+6AOEu7GAFpq3+Nc/8Ey2EqXIYGiAaaciU7UkxdRUqGHf5X/O0OUj7
	 jfxN4JlaInGiNhNEYmS5Jla1DSXdPAl9YTgBVeVjQj8Ntz9F4SeYJK+ZqD5wh5O2Wyx0g
	 TL99NoIIEvLAIHquOeuCQTpwBjQwVIyiWvqqP1W4D23cxhWursx9fnkfGkBNrbd3ZJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=z0VBrlBM;
	arc=none smtp.remote-ip=203.205.221.240
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A60606A32C;
	Wed, 18 Nov 2026 02:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9A60606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=z0VBrlBM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794969932; bh=aWUwZ4yOXRgwWXdv9mQMt4h2IPiJ7i2CqyiC71rxZrQ=;
	h=From:To:Cc:Subject:Date;
	b=z0VBrlBMafE7ALto0Ev5yQCq+FJXCnvTMM68deyryMtglChsnmIgVz1QsNL0a5Hcc
	 mer4VE0JIrRtCVBFXXZG4PCs0z74fz+iiUOv5TmCOzHxL2xKPQIUr0H3UaOn9ImGlb
	 U4EcKEvo+U1P5ZE+yZChcs02A30/C/T9W4hYI+as=
Received: from DESKTOP-6LNKCJL.localdomain ([111.199.66.152])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id B5183EE3; Wed, 18 Nov 2026 10:45:17 +0800
X-QQ-mid: xmsmtpt1794969917thdjdrz3a
Message-ID: <tencent_FCBAE9157D42FFF00E681A2D5EA72CEEDF08@qq.com>
X-QQ-XMAILINFO: OKkKo7I1HxIeqyjo+PW2szCQuXozTViUajm53Bq7Ru891VqoHDVA9qJCiyO/sF
	 O1+YZvw4FBJoeqGKqN0aKu9q39w/5FCaZ3zHdzLEH5hqXN9H2scLaF+k0XmF2Ix+jBqLbfj37XpN
	 O799si6nUvJjcZElalzNg2mAmHZczvqgtQVLR4NVheTEzXn9DHgtZFC322qBHfSyJlDuK4H7XRtD
	 xVXHeMxsKq6Z9Gdml7a/RBeC/eJTqog0LCFIg/dnJeddeduoNbpRxQWvKlo6eJu0cN9IfUMo76cW
	 uwMHqUs3Aki2JW94EQLQC93EpZJYwdGJCeWFOdU+vdj6GhTasgvAha8NJR68gGxnV8PqPeFkVGl6
	 vaBOa20bNfRSDnTSa2xSskuI28Rpwcm/0bC8sxOqUQPXzgVBBkOExxeq/IvvY6IABupXayWA2Lq6
	 Gi4IQSx7FLzbeh/ZMEj1408IixWDOvvrDiNtU8YGAyzRjjIWsq+denB6wjCgdRns2imSp7VACXri
	 ffAhyb7VipEqrYieYfNeB56tfXkil2lmIDF2+zYxQF8sNtbLXrGo4WWQwxjImKpLep32iHU//e2f
	 62HSxrE01/EnRwCqHIERzjoNnJpdmjU33grJJvwyJ6aJGMS0491pwJbIbxsp8Ocd+tijUZWQ3vBR
	 25hOfiByEU0CHPaAscN6MA3TlB9Mo0yH6hFyxLt8INiMIDojsDlIGNXJF8LXfwMrTlsZJvK/jRJk
	 C8ZcNcY8OFkqACpa/kAtVkCa7fysvNJyOgmUnWxxF+S0XhFVUeHMidb/sRHhLQpXgy+XrMa7iLsP
	 ig6a+6ZZBnTa9BHkLhPt5Jh3PZUSuFG1njp+kuwaO8J7LXJ21BSodIVZqJWT6XJAgFaS3WUwf5Y2
	 YJCXbh1g6a3yG+Uf9qc9R5h/wIs9lj1Ui2Z3ZyKGbScI8CYdf9G2ftbJfgZuYcbNyqTeRDeDkqeh
	 Xd/1sz0JSjYn5PJV8VyUQu8HCcj3+Jk4/naDHHnjP9OO0Ru4ryjNPFhJewnTwHANtexRlTXkAFbo
	 Yq2Q8gOG21Mn/ddleyWcavb4WjDBsuYYjWy/rosLpqEn4TijLgWjbrJlACpRk+gTGHCckdZraRp4
	 JVVJp6uK518SIfsobLW5QrIkHbGA==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Jingyi Sun <1045704958@qq.com>
To: Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Luiz Capitulino <luizcap@redhat.com>
Subject: [PATCH v2] mm: shmem: limit forced anonymous shmem huge orders to MAX_PAGECACHE_ORDER
Date: Wed, 18 Nov 2026 10:45:17 +0800
X-OQ-MSGID: <20261118024517.21812-1-1045704958@qq.com>
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
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Signed-off-by: Jingyi Sun <1045704958@qq.com>
---
Changes in v2:
- Dropped the Assisted-by tag (Baolin).
- Collected Reviewed-by from Baolin.
- Dropped the note about the overlap with Luiz's mTHP series; Luiz
  confirmed his series will land after this patch.

v1: https://lore.kernel.org/all/20261117121626.1058-1-1045704958@qq.com/

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

