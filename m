Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046247;
	b=JyGa0os/S6b3WBBy8gyLoJdBwEMQ7ul03fvXE/WtiRzG4ffbPK60Nha4V0Jn5yFjB2WC
	 Oos7wNdTS3EhJad8bbQ4MUqkmDeRKxstB4zuOpVGIT4WRQluEgF4IsAao7pSmTQmLyQt4
	 BGA6bkZHr63GyC/gmAQfNZEYBjW6b4vNWLgN3vL02lOIlGJhqgSFwxUjRKCBEIZbY6/aF
	 bFR8q1QUNHB8DG6Ul96GYq6kLw+Me+fEWyEI4Jxu5v06k9hqnrabW0DhBY3IhTu5b+WWG
	 WXq8GNvqfDkD/JxOijStWuZ1946jHi2bC3GNmkoJZwSmqHyM95dCNUrgsjfPE2G2ADw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=x1iESeEBmUkD2ThodmhWR2pWW0kpHCdRLjU0gC+xNeY=;
	b=sTjP6jdpL6FwCJl5VR3kAUGxZ7lCGP4qtWGU+maiOeefmS8EZ52V5SxwUzw3GznGsbxn
	 EmD7B9RqBWVYsbnHgetFxldqf89vGe+h+aMx7uGC/IqT3+83G/ekDxyNObhchJJ8AN1fG
	 p8Cw8YsoV9hY5cYtKW7tUp3B5BuqlPP2UwjqFerEpjX8z23BPTTRgKzpO6iAicEOR0RIH
	 p4cvTf1ovXa09LtOpUBiS81hMKK7RFrMkNVpX2piNmXc1RiuE6W4bLMHiXD2epP7hYJ/o
	 v06udK+TDk875HNpq9wwjeJa3I1SthBvapl4P9jjZpHdyANcCmz6FE5NxIV+2yPnF4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="b79/Gb+j";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2BA606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b79/Gb+j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B8A41F008A1;
	Sat,  7 Nov 2026 10:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046246;
	bh=x1iESeEBmUkD2ThodmhWR2pWW0kpHCdRLjU0gC+xNeY=;
	h=From:To:Cc:Subject:Date;
	b=b79/Gb+jzjZ7Ehh2mGOC9XrBovMPjQ4HMwpfLu8fhohWBgOlSnRYHzufqqDosSg6B
	 WVDlWobPfpMDen/uwcdCYEp8V2yn7cfAyO675xTuofrc7X611cniwAG328AOkkD9M5
	 nvP5Y01WKKbVYy5SCWgL+aev8CaqRz4NoAQ+ADXlXYinJuC1pRA8dg+eKUWmeYpDB+
	 5ls3ShrJC/0wnrL0XN25XGUZeDlCczJKV3aRCIJe2pNY0+kmLXjYjfGxZyABvoQ+P1
	 iYHMSeU4B7HOqELDnrDkNiX6/U7Y+L0ZWIazARlunTFg8naoZ7bKc8MWsupBoucpeu
	 4lNM+I/gLDIQg==
From: Sasha Levin <sashal@kernel.org>
To: devnexen@gmail.com,
	akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	bhe@redhat.com,
	baohua@kernel.org,
	chrisl@kernel.org,
	hughd@google.com,
	kasong@tencent.com,
	shikemeng@huaweicloud.com,
	nphamcs@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/shmem: don't release a swapin-error marker as a swap entry" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:10:44 -0500
Message-ID: <20261107051044-failed-6.18-e4b92891aaca@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x e4b92891aaca0d37b5973362dd14747a65406650
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051044-failed-6.18-e4b92891aaca@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4b92891aaca0d37b5973362dd14747a65406650 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Sun, 20 Sep 2026 16:50:02 +0100
Subject: [PATCH] mm/shmem: don't release a swapin-error marker as a swap entry

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
---
 mm/shmem.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f2a36a1b53750..07b2855dfb7bd 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1184,6 +1184,7 @@ static long shmem_free_swap(struct address_space *mapping,
 			    pgoff_t index, pgoff_t end, void *radswap)
 {
 	XA_STATE(xas, &mapping->i_pages, index);
+	const softleaf_t swp = radix_to_swp_entry(radswap);
 	unsigned int nr_pages = 0;
 	pgoff_t base;
 	void *entry;
@@ -1200,8 +1201,9 @@ static long shmem_free_swap(struct address_space *mapping,
 	}
 	xas_unlock_irq(&xas);
 
-	if (nr_pages)
-		swap_put_entries_direct(radix_to_swp_entry(radswap), nr_pages);
+	/* A swapin-error marker holds no swap slot, so just drop it. */
+	if (nr_pages && softleaf_is_swap(swp))
+		swap_put_entries_direct(swp, nr_pages);
 
 	return nr_pages;
 }
-- 
2.53.0




