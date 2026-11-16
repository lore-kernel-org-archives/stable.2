Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794797189;
	b=2P7gyylCvd8dxfn5byDFqrAaBdH/YnosVFwztctFWjaZ8PfXk6ZeAcmPqXohDic0dGfS
	 folnmn+uYtjgIl0+zK+vs6XJxBKKW8ZlOrJnJGBJZXT2FHY3dlfuUWZFHS/6X447SZC9v
	 NR9jQtm10Z8gNQLw5Abo6RD+Ww8hLcXo16V+q3/jVau9/fLG0ONrdmwKP6V3+09qV3RQT
	 MEGXrvtDVPTfbdho//gDzr4zqzhpOrf2nd44FSm3bwPuUvOMmV/x/1QAwSb31Bf1e7k0A
	 UNuJQ0pprriRyEu7xgwC6eIHAuSdqXPfyrztPRYgPmjR5SBooo5FpBY0Z7jPrqT+HTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794797189;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Zj59LSbZyWj0ln2DuqrPp59iX3YCpVN4OBGZx/UUUxc=;
	b=V5weTunFQ+cq1beF7QR9gCDIXqVZqCsDcjegVFDsiCARTeDuiQmhUdxQ+Tf71YHrX8hE
	 pJ6zO8Rx3vlE/yiWbi7DNvHKgLmgCGDT2tXyy0x1tfRnitW2slCSbZJmq3fw8YSW0Mqlw
	 fipYMwDCS1kSF5VS0ET5w+IJXIgv3YbCaSyFqgDm5gima9RAyWXuSakHjwne/vdyZH5qv
	 YT3enasBqdJZKq4vnBUm5yYJcm3Efvh1pKMYWGfHF89F73YDdivTbq8w2ysdDBzqcqw8j
	 SXGMZPEuQZ7CZ4q0aDz4mAC3n+az0HxxXLtp1JxSIqNed7rkGv9/SbyAjEMusyRrLEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIZYQnzo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E53606A32F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JIZYQnzo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC1E1F000C4;
	Mon, 16 Nov 2026 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794797189;
	bh=Zj59LSbZyWj0ln2DuqrPp59iX3YCpVN4OBGZx/UUUxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JIZYQnzocaEx9IhNDwbCjVJIqnR0LMkpNajtjnIVnBxAk8fqj+oPWtBxA67SHogl6
	 DAOBuFDVH8FQXRAEZ3l2V7/c1rL8ecwi+XYnLgyBiHtoOfUw1OCy0y3pEOYjWBk1ef
	 N420XOlQ1LYNVg6zbqYdyg1rDqc+k872M9ISnAh7wrTkx1Y16XZV2lsscWK55MAjPm
	 afOn9g3KB9A7O97cpESG3U98BfaeOqfQ65sLrGfbMLGtW+i6ifhl7yP8hmyp7FBsFu
	 6UzX8llCWQMAxb8qygESHm0Q3+F2lgQRLMDTkLJYcoemoNqBw9N//tg9BKqqloTG3S
	 clX2cnXbpasDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tal Zussman <tz2294@columbia.edu>,
	Linfeng Sun <linfeng.sun.dev@gmail.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] vhost-vdpa: fix pinned page leak in vhost_vdpa_pa_map() error path
Date: Sun, 15 Nov 2026 21:46:25 -0500
Message-ID: <20261116024616.2408867-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116024616.2408867-1-sashal@kernel.org>
References: <20261109202626-failed-5.10-fd1462c96baf@kernel.org>
 <20261116024616.2408867-1-sashal@kernel.org>
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

From: Tal Zussman <tz2294@columbia.edu>

[ Upstream commit fd1462c96bafe2cb14e88c837b270f8990b717b5 ]

When pin_user_pages() or vhost_vdpa_map() fails, vhost_vdpa_pa_map()
is supposed to unpin the pages pinned after the last successfully
mapped chunk, i.e. the range [map_pfn, last_pfn]. The unpin is guarded
by nchunks, but nchunks is reset to 0 every time a chunk is mapped from
inside the current page list, so a failure after any such boundary
leaves that pending range pinned forever. With physically scattered
memory nearly every page list contains a boundary, so the leak happens
on practically every failed IOTLB update.

The pending range is non-empty exactly when a page has been pinned,
which last_pfn already tells us, so drop nchunks and test last_pfn.

Fixes: ad89653f79f1 ("vhost-vdpa: fix page pinning leakage in error path (rework)")
Cc: stable@vger.kernel.org
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Reported-by: Linfeng Sun <linfeng.sun.dev@gmail.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20261031-vhost-vdpa-unpin-v1-1-94ffc9683256@columbia.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vdpa.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 32dde456a181a..cfe3bf958f318 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -632,7 +632,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 	unsigned long list_size = PAGE_SIZE / sizeof(struct page *);
 	unsigned int gup_flags = FOLL_LONGTERM;
 	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
-	unsigned long lock_limit, sz2pin, nchunks, i;
+	unsigned long lock_limit, sz2pin, i;
 	unsigned long page_offset;
 	u64 start = iova;
 	long pinned;
@@ -668,7 +668,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 	cur_base = uaddr & PAGE_MASK;
 	iova &= PAGE_MASK;
-	nchunks = 0;
 
 	while (npages) {
 		sz2pin = min_t(unsigned long, npages, list_size);
@@ -683,7 +682,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			}
 			goto out;
 		}
-		nchunks++;
 
 		if (!last_pfn)
 			map_pfn = page_to_pfn(page_list[0]);
@@ -714,7 +712,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 
 				map_pfn = this_pfn;
 				iova += csize;
-				nchunks = 0;
 			}
 
 			last_pfn = this_pfn;
@@ -729,7 +726,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			     PFN_PHYS(map_pfn), perm);
 out:
 	if (ret) {
-		if (nchunks) {
+		if (last_pfn) {
 			unsigned long pfn;
 
 			/*
@@ -741,7 +738,6 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
 			 * the corresponding unpinning will be handled by
 			 * vdpa_unmap().
 			 */
-			WARN_ON(!last_pfn);
 			for (pfn = map_pfn; pfn <= last_pfn; pfn++)
 				unpin_user_page(pfn_to_page(pfn));
 		}
-- 
2.53.0

