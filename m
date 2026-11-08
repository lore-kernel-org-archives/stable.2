Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.72.141.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140993;
	b=kKmmM0mBzMhYkopcKLKNPwhyxXT5f6QGlug+QW0nocTBy1odUSu2M/PiwZd0j9r6yIqQ
	 0V8YwlDJO0Sop99PAMtina48NRs9zs61JkXmkdwZFvw4D9iOch1UiRBkjgZAhhKhnHZIi
	 6IKGw6S6YNGVkH47C0MQQ718nrgUm2owITOramHt7S89IP4re2A55YbQgwM9N6MlVWr4x
	 Ica+Q/jkxFTvp774tUNcIFnV7Qnj4PMBUf0CbGP/8coPVwz2GWrpdyi0girK45jQKhwXh
	 GayG1wB6MR7273V8lTFfGtYuelkc6sDhBi9mL9yh1KmaiglhLT7rRNKkCeL40XQzynQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140993;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:X-SG-EID:To:
	 Cc:X-Entity-ID:Content-Transfer-Encoding:Content-Type;
	bh=ci3/uizM6qBDovrwimDa4xfj8Stkcf8UjEpLaQjo4Xg=;
	b=cV0YqxK0ni7kfAudF0jYug/welGpd21WsZv3FCvv4G9+L1Ftd1ewEFdEpmZSt5RdmeXi
	 KuBlaqpfkPAvDCPZiRVce+jVtHbZ+SD3Qvk8RKTtaK9GPQEqssE0alloHG7iLIhpG58bN
	 xUtgXKaIKE1g3dkNYte1raahl10h6Lp5Krpqr5yN24jwEpe4jiRDVBFmDv3ITRowqIjBA
	 IQcCPh+TeKZ7ASqdk2iygCXEtY5Wzi2GpayJtHVRfRmgf5YYPQtJ2JmawK/ZfnWIdG7Hz
	 72upFLKD86perletC9EnOIWu6fZhnxJYxmkOPCHScYLMw4s1lIrooZyQ3Nbl0rfiOtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=honeycomb.io;
	spf=pass smtp.mailfrom=em.honeycomb.io;
	dkim=pass header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=HPYqGPG7;
	arc=none smtp.remote-ip=149.72.141.136
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB4606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:29:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29CB4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=HPYqGPG7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1794140992;
	bh=ci3/uizM6qBDovrwimDa4xfj8Stkcf8UjEpLaQjo4Xg=;
	b=HPYqGPG7FY0650zVgQWZ0bwLHBINMFyDTUvJjXybGn4uj+ArA7/CmyghFlT0kH3H4+5/
	LBDUO4rsCwqyngRw9B3HIbVb6WAty5Zjn3PnX/09edKkYb/JshA1CoNu1M9Mf2RAmZZR9U
	YcV7SZ7B9CNxr1pLo7vgFMLZaEb8ahSRFG4bnwzcW5vSSudk4UCbDHYrY5UfRLaGAVkh6d
	xdJ3d0cYe4MK+40VrWHSUnBOJcjF4Ejbz4QqA1Vm+VtZMwIGh7GaFwtzuPKP3g9fKT4Oje
	Nbei4oITXKflv9Fkgc12K1QttfoPyVaOLDcv47+cPFJrvQCUfICF2qarKDkXJYDg==
Received: by recvd-cc8d845b-xcv2x with SMTP id recvd-cc8d845b-xcv2x-1-6AF06B40-34
	2026-11-08 12:29:52.215065152 +0000 UTC m=+217254.257411646
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-22 (SG)
	with ESMTP
	id FUjBHN2VSM6Z1xsjDBlsNg
	Sun, 08 Nov 2026 12:29:52.158 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: [PATCH 6.1.y] writeback: keep cleanup_offline_cgwb()'s scan out of
 syncs
Date: Sun, 08 Nov 2026 12:29:52 +0000 (UTC)
Message-ID: <20261108122951.601970-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055328-failed-6.1-90c96612460e@kernel.org>
References: <20261107055328-failed-6.1-90c96612460e@kernel.org>
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
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeblFZis96ejt?=
 =?us-ascii?Q?3g+cSsTtFvM91yx12IF18succ=2FhaIydbnH3umpX?=
 =?us-ascii?Q?DhwOQMCnQexGmZ98L0szJschJg58ArleNN5mv78?=
 =?us-ascii?Q?hH3swm5l8uvzwsL1MaGiVvHN=2FYNsxheba166Hbk?=
 =?us-ascii?Q?YSCPehJr8iui4ZCyBrb9XpT1VXBqaUeMLW0=2FJub?= =?us-ascii?Q?tui+?=
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
index 085e0fa0cab3..44bfe24fc9d7 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -730,6 +730,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
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
@@ -752,6 +759,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
 						 &nr);
 	spin_unlock(&wb->list_lock);
+	up_read(&wb->bdi->wb_switch_rwsem);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
-- 
2.53.0

