Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048810;
	b=AzjgxeCn54QdmwRvTgJ0EHYrAili+5kQbAYFw43Yu5MhYbkQaa1HyQQ5w0mgD5ezLA3r
	 YCemIrraxY73GLy7WY9OHxRxYjpSrVPsM+pJ41ODm0OczFo9HiCyTM2LbYaUZu7mM4hWa
	 lKwTcUWyIxCwoPPWXdoP8U0vX4qjIAmmlAPW1eWf7du4wW3yImV1IFplre83NAZiev75C
	 rBVv8dWgCRfmYPg0lwE2u6r2lPR5iXdX1CHLOysMFWujL2Sfcn9QXA+lYN3H/9qfjkpjZ
	 pL2IHKVxeTyw29ACvqjRc+xTVDVVtqikkM5njrNl4GGnkxfo5cY2rWIEztfK6h/2mZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048810;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=K0ll2zhErpZN4kSYWoUaL0fXsNyFwV17d6SKCBqCYL4=;
	b=2rm3yAudH+37SB7eNgXammOBzoTF9vuWPi/FG0VtfxooghqatCFyZGC7iJSFeIylMd8p
	 A9AQytXaus/zesNEbAGW+v8XxDNdUrg6CWikb5N99tAOauMRcu7Z/IEKnDs7EQuFXQlbS
	 /ETDVWsxWf94QaeqdNoidvsrqmXNPdqOv5/RAaF/Li/nN+xZZgX0CYg6QIUk5VAVnAYN3
	 vOtoWMmCDW457pw8ZaPlzmBCHOLNqlxtQhqDWMpmqRVHmJoFCR8JKHF0FX+Uo4EyXql5Y
	 eMukIUyVLaZQZvlUwcFCloxlVUSag7FpBBRdNmUq4lVAdVnxboDkCVW3IlEfJ92Ltzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0YbtfUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q0YbtfUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A087F1F008A1;
	Sat,  7 Nov 2026 10:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048810;
	bh=K0ll2zhErpZN4kSYWoUaL0fXsNyFwV17d6SKCBqCYL4=;
	h=From:To:Cc:Subject:Date;
	b=Q0YbtfUB+sAGCHGYd0tdbtO76vRg1xmJKRnNSYKDRq540Dx+8j6hGYkFYJweOBa2f
	 GSZueWhDUnHDBla8l8VwNszREw4qwe+e0SPkkGTVXdiwrPlQMBmDaj0DjxcJASkygh
	 oAr96nuGV82WH6cWF7nM/2p7KAWD3WlfYZ9gRBw2f+KxtugR8bk1Y75M8bb6yRxypA
	 cg+IIKstA2axqmHMgT1n37unHFp7Bvnsa+A18fFovRht4g1P9tMI+j6iVmdyt16XXH
	 QQ70X1VOHVTkn4+8eo1NQZoNy8V2zB7jQPU0PJDY0M4AROkzJfaXzbRZfWwnGQiGlQ
	 tX8RTS42uxNyg==
From: Sasha Levin <sashal@kernel.org>
To: lizf@honeycomb.io,
	tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] writeback: keep cleanup_offline_cgwb()'s scan out of syncs" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:53:28 -0500
Message-ID: <20261107055328-failed-6.1-90c96612460e@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 90c96612460e6accddbda5a195e6ddaa391ecde0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055328-failed-6.1-90c96612460e@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 90c96612460e6accddbda5a195e6ddaa391ecde0 Mon Sep 17 00:00:00 2001
From: Liz Fong-Jones <lizf@honeycomb.io>
Date: Sat, 17 Oct 2026 04:07:11 +0000
Subject: [PATCH] writeback: keep cleanup_offline_cgwb()'s scan out of syncs

On a filesystem mounted with lazytime, sync() and syncfs() can return
without persisting timestamp updates of inodes attached to a dying
cgroup wb, so a crash after the sync loses them. File data and sizes are
not affected.

Since commit f6988c90671e ("writeback: bound cleanup_offline_cgwb()
rescans by rotating scanned inodes"), isw_prepare_wbs_switch() moves the
inodes it walks to the newest end of the list. When a pass fills its isw
before reaching an inode that got its lazytime update after a sync's
cutoff, the walked inodes land past it on b_dirty_time, and the sync's
queue_io(), which stops at the first inode dirtied after the cutoff,
misses them. The late inode has to be one without a pending lazytime
update; one already on b_dirty_time keeps its position.

The window is narrow. cleanup_offline_cgwbs_workfn() skips wbs with
anything on b_dirty, b_io or b_more_io, so the scan has to land between
wb_writeback() fixing dirtied_before and taking list_lock for its first
queue_io(), unless a multi-pass drain started before the wb got dirty
IO.

Take wb_switch_rwsem for read across the scan, as
process_inode_switch_wbs() does for the switches.

Fixes: f6988c90671e ("writeback: bound cleanup_offline_cgwb() rescans by rotating scanned inodes")
Cc: stable@vger.kernel.org
Suggested-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/all/0bc5d58533f10b4841807be3025daa11@kernel.org/
Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
Link: https://patch.msgid.link/20261017040710.1174009-1-lizf@honeycomb.io
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fs-writeback.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1f192a581fb2f..ac612c02ced9f 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -790,6 +790,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * The scan moves walked inodes to the newest end of b_dirty_time,
+	 * past ones it didn't reach. If one of those was dirtied after a
+	 * sync's cutoff, the sync's queue_io() stops there and misses the
+	 * moved ones. Exclude syncs as process_inode_switch_wbs() does.
+	 */
+	down_read(&wb->bdi->wb_switch_rwsem);
 	spin_lock(&wb->list_lock);
 	/*
 	 * In addition to the inodes that have completed writeback, also switch
@@ -804,6 +811,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
 						 &nr);
 	spin_unlock(&wb->list_lock);
+	up_read(&wb->bdi->wb_switch_rwsem);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
-- 
2.53.0




