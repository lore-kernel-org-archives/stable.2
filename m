Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407270;
	b=lxMNi2i+UY5FE8ROrFwWhx5W/MxmB4cTekTzBRYH7q3XovaMscEGb0+F5ddqsBcqziYS
	 LYP8WiLBfv+tZXZaE5av0T3hlzcnHdVopGIXWZN13z7+HUyULCGy+C2lXc9mup3kg9UHT
	 vjvnYM6SnekU7xDL7TlpAOjHih4t7+ocxvh8wM5cGTIROyy6mzt2bexvXWABmqMGttkGw
	 KXHmIQT1Ou0RmL9lgz+v6y8Hp9nhAIUniuWPieuKAf/kew9FUawvoYic8zpDc0Sb0KmAI
	 JOnVYNMMwhalBAmDI1AcIHzx/iLdqafrdegJw9/BJmWc1LQgcv/ZdAt9kgfIrPZuC2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407270;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=JD9yYuzhqD9PB9BJmZC2ytS9q3GGkyCVPWF5JrGyyxw=;
	b=mgp+OabIQTrzNybbUnDaq0VyGsyM52D1e5F+bPSdyEjPH7PJBXgZ1+xd4+2HyXf7NbsM
	 tg/oynYo1AVd+sfIb8ARlPQZKss26Ke4RN+SwDoxw6a5UE7rHiaUbzpMVseSsYMrRhspR
	 9OtZa1BsGS3Ud/ybe6McNqhhLnPqQMJ+Wdy8ImiRSBIfQjn9RRcLOtDNFDyjG+4r9iipD
	 Tky8kWQDeI/eBloTiMDcI6vsUhrpQ2psDfxunbV3lk3qBASWVEwlsX+yhtmhZphucNkAu
	 O+MDNQZeVSnc1yee42q96+WXH35dILuwkTAJ0wpvx5t/VrxORmjwmyiyHUF6e9sdgRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LvdC08/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD5A606A32D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvdC08/O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908231F00A05;
	Wed, 11 Nov 2026 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794407269;
	bh=JD9yYuzhqD9PB9BJmZC2ytS9q3GGkyCVPWF5JrGyyxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvdC08/OBjRDbIwmBTRNMYsTgnYFVCqrC1IMLXC7NhPDr7Bwz1CWAgUGLEZ7rf1gj
	 Isq70ll15Q7+UdqsDlO9+cA9OTMHb4vzZNATERX8bFA6SGVEe22Yp5xuD3JOU7nyrZ
	 vRz+sUdldRlA+6VgPmxs4WOsFnUqIOMGsdzZ0WycqkEi45ZYWodeTFkgSJedmUzTHC
	 +WiuSF/E1T6HpUexuoU1WXWiPpAX1/0iLbm04C3w8kGmryQ7XgYw2EUjC9RBZz7SfY
	 f3D0qv2S6Y2YB26pRuRvXsa9EM2MMgl9/461MvQDjFU01qNY3uZZ8IPLSkah57XrCf
	 ZlZxmQZZodKUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Carlier <devnexen@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	syzbot+23b25ba3c6bf971f9c57@syzkaller.appspotmail.com,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Baoquan he <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Chis Li <chrisl@kernel.org>,
	Hugh Dickens <hughd@google.com>,
	Kairui Song <kasong@tencent.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/shmem: don't release a swapin-error marker as a swap entry
Date: Wed, 11 Nov 2026 09:27:47 -0500
Message-ID: <20261111142655.2313974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051044-failed-6.18-e4b92891aaca@kernel.org>
References: <20261107051044-failed-6.18-e4b92891aaca@kernel.org>
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

From: David Carlier <devnexen@gmail.com>

[ Upstream commit e4b92891aaca0d37b5973362dd14747a65406650 ]

A failed shmem swapin (eg, EIO) frees the swap slot and leaves a
PTE_MARKER_POISONED entry in the page cache.  On truncate or eviction
shmem_free_swap() passes that marker to swap_put_entries_direct(), which
warns because it is not a swap entry.  There is nothing left to release
either way.

Skip the release for non-swap entries, as every other caller already does.

Link: https://lore.kernel.org/20260920155002.1030454-1-devnexen@gmail.com
Fixes: ac2d3268284b ("mm/swapfile.c: remove the unneeded checking")
Signed-off-by: David Carlier <devnexen@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: syzbot+23b25ba3c6bf971f9c57@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=23b25ba3c6bf971f9c57
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Baoquan he <bhe@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Chis Li <chrisl@kernel.org> (Google)
Cc: Hugh Dickens <hughd@google.com>
Cc: Kairui Song <kasong@tencent.com>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Nhat Pham <nphamcs@gmail.com>
Cc: <stable@vger.kernel.org>
[ sashal: adapted newer softleaf and swap-release APIs to the existing swp_entry_t-based swap helpers ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5efde9fcc3057..d90225a3b9a4d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -947,6 +947,7 @@ static long shmem_free_swap(struct address_space *mapping,
 			    pgoff_t index, pgoff_t end, void *radswap)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	const swp_entry_t swp = radix_to_swp_entry(radswap);
 	unsigned int nr_pages = 0;
 	pgoff_t base;
 	void *entry;
@@ -963,8 +964,9 @@ static long shmem_free_swap(struct address_space *mapping,
 	}
 	xas_unlock_irq(&xas);
 
-	if (nr_pages)
-		free_swap_and_cache_nr(radix_to_swp_entry(radswap), nr_pages);
+	/* A swapin-error marker holds no swap slot, so just drop it. */
+	if (nr_pages && !non_swap_entry(swp))
+		free_swap_and_cache_nr(swp, nr_pages);
 
 	return nr_pages;
 }
-- 
2.53.0

