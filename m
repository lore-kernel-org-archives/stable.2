Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795371589;
	b=k7SpFAwE/f/b23V8ntWQ/yeRq/tU2OnU/3rqjSZPByhd/dnK/vD8KCWLkhjsaQdu6t63
	 s220g68nQxtNF/BIf2+oABt8loJkwXUZK04ZB3TKA0sVhwt0icfAmOCa723+KuJ5R26RQ
	 crRj7sKiN3ayAgAvuoxHvCJELtC+x8M5PwHdUuDxhDvxKFKuEQu9Tsm0SvaQhVjonRTa+
	 TWauzO0m6aRmeMP1I6AJo1dzy66U1iSMxzx39xSJAb4QUyVreH5pzpAL/OV0nxJNHZV+h
	 gWBX0T4Cqg2HNFAL+Lhb+HPBwJk9er1YQm86+9IPAdjoSncjZ6DaSqS6nK2LtfrjpiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795371589;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RI4kRWxl4XYAMairOnQShzPIXYese8AvwwdfRR+uYTw=;
	b=EUuidJxIaqBHIBcyTBu1UJdFLix2bHhVhYerRCGaMlvRLhq44BWRv1+T554v6VAwkiE+
	 DWoOG3JnVa3Gwwz4eNs+/oLewfcUEAD/JiGhLXnweKFcRWCdvyYgKMcbBM71STEYnBXcF
	 uS8gBKUtEzP9uqAB+NYQerLgTkO7hWNXcWuQki+PTv7lRoJdel3O1lSaM4xdLvn3AgaVK
	 imOt9ZFLPspnRraRdhnALZpmQDIvktjMo06jj33+R4G3MQ6drLN8foDPhOduTuDaliiRW
	 yuphcud2wPiTwIyJuk7mnTQuZO2R1xVsf3fWJ4FC++h2jZGaqxYdX5iWoFuX/qaZxDg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Zvcv/9e4";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CC3606A330;
	Sun, 22 Nov 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zvcv/9e4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795371589;
	b=ZI51zN6HeGqgAuTrHcpTDy9bH6wcWfGpBcgJClVdTzdRmUOQXOhSb5vFdbg9ohln6eYz
	 i4FkMpxQb+ZIQW8JF6wy3at4MQE9smLYmjmNTlLjuuXcG76IzlasKcRU2WBF/nEjz0PgO
	 Mh3FmjViWjGtpbKKI1y5XcbTvhTenb/hyLmZdyq3QkvPu/6Pd1SvrNoZ57JQCAyi5HPAH
	 VWm3XWph7uKDjk0aaZjpK2rDQpAXAUHl2SCb9bSwEt+aT9299pgKcU01D1er5kvRfNYvB
	 89XDfV5R4KGQEvc7M5CfJGGcQe3TRc7nXuOdj+IWf3SDP/vM4X/T8CPfOSPrtOCj3Vw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795371589;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RI4kRWxl4XYAMairOnQShzPIXYese8AvwwdfRR+uYTw=;
	b=xUVbEUH0BfCMrhMmPjlOWDG5hc2eQR+vEWuE7vO/fm+bJxXUxHicBvqUbBLUmdeCC/Qe
	 ZJA66KBq+llNFoZRGIrfUrX/eEVZpblGL1gsnTWTZf1qkTk5IaHAOndB4mr/Ns5PBudMA
	 lKxth8Sump/iCp49K+TVtScQNH9d7sP3gklwWj1UQewEzCkWkHI9CWlMg7z65tejsD/hA
	 M3PK61QBxMIR9tmv2wsf3Hnk5bdv95PRqHxaPZeIfFe2sqGzD6CxGGv0Zi7QD5j41hnwt
	 fOMAEb/qdIu7v4gIxs4MU53zOJaII4zea4kUw2XAkfXUlqP4hdlhQGbt5xNnz5Rc7hA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5D7FE1F000D1;
	Sun, 22 Nov 2026 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795371589;
	bh=RI4kRWxl4XYAMairOnQShzPIXYese8AvwwdfRR+uYTw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Zvcv/9e4o9cEt5RidnZkS0BNvjR/Djm88RDm/0y974XNc6p74OmvR+3khITH18kQX
	 xWtEsWiS7khQqY0TD+t1WQNd4GCLvGUT3k9PJ6F/F1mq4cCgs4y3P7NIv3jz3YJI3f
	 Hcdtu0QhfhwKvtfL9soo5lSJOApw98FE38CNUVsX3S0YI8brZpMRJNXF1TwTlKpWjO
	 4GGi92WLX5plZOiPjRFiYjsSUk5vHc1+j0uWeuzbRN1U3ChRIrTQLBYYTAcqqq8WP1
	 QqEw2eJymUgw7SP1InMfMReXi7IQ/lteIFGDqByWADanlzPOgYoBMnRlwKLptH+5m7
	 NGnj8UHIt3sOg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DFE4B4C184;
	Sun, 22 Nov 2026 18:19:38 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Sun, 22 Nov 2026 19:19:40 +0100
Subject: [PATCH 4/7] ntfs: do not shift the cluster number of a delalloc
 run on split
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
Message-Id: <20261122-b4-ntfs-delalloc-fixes-v1-4-0726f0dce403@proton.me>
References: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
In-Reply-To: <20261122-b4-ntfs-delalloc-fixes-v1-0-0726f0dce403@proton.me>
To: Namjae Jeon <linkinjeon@kernel.org>, Hyunchul Lee <hyc.lee@gmail.com>, 
 Baolin Liu <liubaolin12138@163.com>
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Zhan Xusheng <zhanxusheng1024@gmail.com>, stable@vger.kernel.org, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3638;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=QYrY3PPRwc1pxE1XgYFpRxvEIryQYj/9Bk2ICaRmWlw=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmxmI8uYJ2p3p3zxX3m5Z+l87XsPRQRffrlbHGnPoXIvT
 2tDVuXkjlIWBjEuBlkxRZaO/zdCfEK+fVoWp9UHM4eVCWQIAxenAEykbg/DX5EcxajDEzf/Xf5G
 ZlJS+6FnbK2lXxZLbVq8+efZ7578meqMDAdieUtfsxmmlhy5cX3t60fV3f6TGM/Hae05E7HX4V0
 XFzcA
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

ntfs_rl_punch_hole() and ntfs_rl_collapse_range() advance the lcn of a
run they split with "if (lcn > LCN_HOLE) lcn += n".  LCN_DELALLOC (-1)
is greater than LCN_HOLE (-2), so splitting a delalloc run turns its
tail into a run of real clusters starting at n - 1.
ntfs_rl_insert_range() advances it unconditionally; its callers insert
holes, so only a hole split for a non-hole source and a split delalloc
run are affected.  ntfs_rle_lcn_contiguous() has the same problem and
can merge a delalloc run with a following real run.

The punched-out part then goes to ntfs_cluster_free_from_rl(), which
frees clusters that belong to other files or to metadata, and the part
left in the runlist maps the file onto them.  Delalloc runs normally do
not survive the writeback that fallocate() does first, but a buffered
write that fails after ->iomap_begin() leaves one without dirty folios
(fixed by the next patch); FALLOC_FL_PUNCH_HOLE or COLLAPSE_RANGE
through it then corrupts the volume (ntfsck: "Found 1 inconsistent
bitmap block(s)").

Only shift the lcn of runs that have real clusters.

Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator")
Cc: stable@vger.kernel.org
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 fs/ntfs/runlist.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
index 76ba6ab72b..1e87db35ce 100644
--- a/fs/ntfs/runlist.c
+++ b/fs/ntfs/runlist.c
@@ -1770,7 +1770,7 @@ s64 ntfs_rl_get_compressed_size(struct ntfs_volume *vol, struct runlist_element
 static inline bool ntfs_rle_lcn_contiguous(struct runlist_element *left_rle,
 					   struct runlist_element *right_rle)
 {
-	if (left_rle->lcn > LCN_HOLE &&
+	if (left_rle->lcn >= 0 &&
 	    left_rle->lcn + left_rle->length == right_rle->lcn)
 		return true;
 	else if (left_rle->lcn == LCN_HOLE && right_rle->lcn == LCN_HOLE)
@@ -1832,7 +1832,8 @@ struct runlist_element *ntfs_rl_insert_range(struct runlist_element *dst_rl, int
 
 		i_rl[0].vcn = start_vcn;
 		i_rl[0].length -= dst_rl_split.length;
-		i_rl[0].lcn += dst_rl_split.length;
+		if (i_rl[0].lcn >= 0)
+			i_rl[0].lcn += dst_rl_split.length;
 	} else {
 		struct runlist_element *dst_rle, *src_rle;
 merge_src_rle:
@@ -1988,7 +1989,7 @@ struct runlist_element *ntfs_rl_punch_hole(struct runlist_element *dst_rl, int d
 
 		(*punch_rl)[0].vcn = start_vcn;
 		(*punch_rl)[0].length -= first_cnt;
-		if ((*punch_rl)[0].lcn > LCN_HOLE)
+		if ((*punch_rl)[0].lcn >= 0)
 			(*punch_rl)[0].lcn += first_cnt;
 	}
 
@@ -2008,7 +2009,7 @@ struct runlist_element *ntfs_rl_punch_hole(struct runlist_element *dst_rl, int d
 
 		new_rl[new_1st_cnt + 1].vcn = end_vcn + 1;
 		new_rl[new_1st_cnt + 1].length -= first_cnt;
-		if (new_rl[new_1st_cnt + 1].lcn > LCN_HOLE)
+		if (new_rl[new_1st_cnt + 1].lcn >= 0)
 			new_rl[new_1st_cnt + 1].lcn += first_cnt;
 
 		if (one_split_3)
@@ -2136,7 +2137,7 @@ struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, i
 
 		(*punch_rl)[0].vcn = start_vcn;
 		(*punch_rl)[0].length -= first_cnt;
-		if ((*punch_rl)[0].lcn > LCN_HOLE)
+		if ((*punch_rl)[0].lcn >= 0)
 			(*punch_rl)[0].lcn += first_cnt;
 	}
 
@@ -2150,7 +2151,7 @@ struct runlist_element *ntfs_rl_collapse_range(struct runlist_element *dst_rl, i
 
 		new_rl[new_1st_cnt].vcn = end_vcn + 1;
 		new_rl[new_1st_cnt].length -= first_cnt;
-		if (new_rl[new_1st_cnt].lcn > LCN_HOLE)
+		if (new_rl[new_1st_cnt].lcn >= 0)
 			new_rl[new_1st_cnt].lcn += first_cnt;
 
 		if (one_split_3)

-- 
2.56.1


