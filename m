Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.72.141.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140993;
	b=e7yn8JZD/qTsTV7Dz+iCztzo/cnVkZY2E41VRG999wpWqwK3GO6Jnc1bzDNio8wicJbo
	 nbhx82xhU/gwTRvrH6PnwtXsfYbO5UCBFAiSM0ycz1PHEH4TFFJOhyrsSDthnef/lcpas
	 pgux8oV2Wk2lwSqSpR2eDU4i8V0XPurmLvWiAwG2OvsyCy2aE7G/dPSSdtQ+ey2JU/mRx
	 Ti2s0lGrHnM05qgf0dsG8i0ZN2JcTlJkBb8klsR2nCG5eWhumZvtMyRGWOABPM27bDDmj
	 /psZNTzXQ5Igj4PaPJGGddV8gxSqmMIQyZdpAqAGhvHP0xYw01qaHmyFwBA2yedgQIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140993;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:X-SG-EID:To:
	 Cc:X-Entity-ID:Content-Transfer-Encoding:Content-Type;
	bh=3XFZuRuXfhQpadm9LvEIaRYgNvmBcTdkggZyS6p7YlY=;
	b=lhBAZRGf782QnIY4jGntz0ncMnxxHV1VoPh4VBXPoZUiJakZvjHEGJmxA+WMxqBP1+tT
	 YpUBvE61mK4bVjndcFv7MTTT5RAJTOsCm2d+WPzIFky+krTysavEFj5lzRPvuVdFlWMjy
	 MG38i3Q+2m8/jpmEujLaDNDjBbSto1FDBxKxxAGBeyhyzwboAuuPyiQP86bmEeAVdPqXz
	 KaVxa+RsTUQOpag+9tMrgAub+FfdgBVeqNwCA1HRNnKsUO5Crfiuey2EB7WXJKYDzIDmc
	 zpBAhjKc6xzVRkiDSoNowlbZ0dDhnnroe6/Dklwf65XnM+dfsS5ELOgKgGX0W1r/Fmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=honeycomb.io;
	spf=pass smtp.mailfrom=em.honeycomb.io;
	dkim=pass header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=FOjZirB8;
	arc=none smtp.remote-ip=149.72.141.136
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54D9606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B54D9606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=FOjZirB8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1794140991;
	bh=3XFZuRuXfhQpadm9LvEIaRYgNvmBcTdkggZyS6p7YlY=;
	b=FOjZirB8nKAyOMor7F4/4XZcYw4/d9f3SWwaW/iOCIKgh/qaKbJr9cFcYvU/TJx8ebh6
	zCfQVxQuv/7vmwgwdNYs2W9jq/3vPKd1x2jWU8UIOdOcXjVmRs/XHvcTbrbWhNBeCEiF7d
	gu0LkSsRjB/dsmHwvEGRMHvK+o+L+cdxO7ooFi756qSVj2OEoKdKBKxhDDdfCjfXrBmMZ3
	guPRiDrtHQasVOIo4UINJ7HGtNNI6WQ9RI/UG3QLyYDnOxq0RN/8fViqzd8/WGUWp2xaO0
	RZwLM9jSlpag/LaZs/FfQ7oD2rlGl0pFeWwOw8JxojcC2U+47/Z+5OmptZwKTGzg==
Received: by recvd-85667b6c89-8md2v with SMTP id recvd-85667b6c89-8md2v-1-6AF06B3F-20
	2026-11-08 12:29:51.403349795 +0000 UTC m=+216963.094248120
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-18 (SG)
	with ESMTP
	id mLh84i8TSfmb_liPy5w9lQ
	Sun, 08 Nov 2026 12:29:51.370 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: [PATCH 6.6.y] writeback: keep cleanup_offline_cgwb()'s scan out of
 syncs
Date: Sun, 08 Nov 2026 12:29:51 +0000 (UTC)
Message-ID: <20261108122950.601944-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053814-failed-6.6-90c96612460e@kernel.org>
References: <20261107053814-failed-6.6-90c96612460e@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-SG-EID: 
 =?us-ascii?Q?u001=2ECuH7N2XAoeMR1zrzr=2F6NZrhli2vbKPOHff5fJuZuba6ZIE8QPyIf9mn4Y?=
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeeWHBY1750Rq?=
 =?us-ascii?Q?IzeNcHJ0GVZFLIl5Lc6s9PRcn+FY+81n263y6Tx?=
 =?us-ascii?Q?FUWUI0AYJ2KrtO5uzN1xoQA+NK3LakrmkA3fLBk?=
 =?us-ascii?Q?0G8spTgeKr0gXlPWX6iNSOJ8nR=2FE9NgJKcrKuSJ?=
 =?us-ascii?Q?5+B5Aqk5ecXDkOnFUrIGCkG+Fh3YAPN4UX50D24?= =?us-ascii?Q?O4QI?=
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, Tejun Heo <tj@kernel.org>, Jan Kara
	<jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Liz Fong-Jones
	<lizf@honeycomb.io>
X-Entity-ID: u001.GRlkmHQ+Ka/CKxmoC/CxTw==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii

[ Upstream commit 90c96612460e6accddbda5a195e6ddaa391ecde0 ]

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
[ Take wb_switch_rwsem before this branch's rcu_read_lock(), as
  down_read() can sleep. ]
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Liz Fong-Jones <lizf@honeycomb.io>
---
Upstream's first hunk conflicts with this branch's rcu_read_lock() block, so
the rwsem is taken before it. Same change as the 6.18.y backport, which was
race-tested; compile-tested only here.

 fs/fs-writeback.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58fd005d410c..70c8ba790ced 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -732,6 +732,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
+	/*
+	 * The scan moves walked inodes to the newest end of b_dirty_time,
+	 * past ones it didn't reach. If one of those was dirtied after a
+	 * sync's cutoff, the sync's queue_io() stops there and misses the
+	 * moved ones. Exclude syncs as process_inode_switch_wbs() does.
+	 */
+	down_read(&wb->bdi->wb_switch_rwsem);
 	/*
 	 * Paired with synchronize_rcu() in cgroup_writeback_umount().
 	 * Holding rcu_read_lock across the SB_ACTIVE check, the inode grab
@@ -754,6 +761,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
 						 &nr);
 	spin_unlock(&wb->list_lock);
+	up_read(&wb->bdi->wb_switch_rwsem);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
-- 
2.53.0

