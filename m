Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.72.141.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140992;
	b=E3pxMxWAtou779JpdPG8MSAXLI7RdnNInzLgnwrDZ4Qym+CCdNoGkyDWtUMvg0ukHFlC
	 AzUgOoeXCzOnXoKgpdzQsDy6SV6v31s7I9Vpd84pNio/3CIpjlpoXZ7VFBbe/HeVGNa3d
	 5xeOOFoaSb6DALxdJnqrpbgCNkQozUPjePu/9025+kLdpfaZeSqqGXHew+LTYub/6Njtm
	 K+bneM3LdJH20JUg4RTmLb/peDXJv7V+5xP0gqF+iapU67Y/2ZfwEIJaYIHsqdmk/Xwg0
	 uGooBXOD9IS+R7MYMK0RLLcB2wNR/McpKZ3hWV4IrVse/osS4tYgbqYMS7k/vEzVP9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140992;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:X-SG-EID:To:
	 Cc:X-Entity-ID:Content-Transfer-Encoding:Content-Type;
	bh=yzTW9mpwYO3870v3lYfOSB2zBQpfPORuUrXDOiz6USQ=;
	b=GuIFjjoZHzZ/4Laj1utmoBGuhyi7ao58cX5mIaJ0wur4KoguIYGwdUfCNS7HuaOw57lZ
	 mAkUmCQnvWHmeLw+D8bv0c0DkTW0ShEasta48Nlu9sBtKfber3D3VRDG9Ba0K9lX8r68E
	 henvj4NfzoDL21bEmAKNptArQDdsaRWYIhUa8Yh0rAtARAyfFNMAupae6ryAKmTr0leVs
	 FgCu/965lt5rsoqAhpg2ccO5gWIyTD+9VIEQVcn97174x4/0DcW2pk5Ss0laEl8m0e2NL
	 //6Bz6JnbsPJH9o2HJJoxlYwdbMnCuaA8itt1v/829zcZ45ZZMRg8dCdLwjacfThc7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=honeycomb.io;
	spf=pass smtp.mailfrom=em.honeycomb.io;
	dkim=pass header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=Ka5pPBfT;
	arc=none smtp.remote-ip=149.72.141.136
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715F3606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 715F3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=Ka5pPBfT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1794140989;
	bh=yzTW9mpwYO3870v3lYfOSB2zBQpfPORuUrXDOiz6USQ=;
	b=Ka5pPBfTM16WnTciDxVlQkAhh5KcFUCpOdY/FUclP251I6Dsu6Ek5JcCxrGqdE9vqNKd
	RD7lSz78PIaNWSWQ3sF036Jf4FRXAm0p9CgpKIIDtC528E+fu5D75pJuORfATQypGLaqsq
	rlJ6pu1Rcsk5o22AT4jBmX6GeikogaJEghLfoBcklXc7Izr8V6XmdiBifcBo3szEqXIpON
	NodlJzsa6bUb8wWrEtcCbYJBlXhV6wj92WV9L6+1v0DOPz3VtJ5oqWAzCpAOPRgyXQJgSD
	U9w3QcThPgpO+NhpRqHM+48PWrLwyU3CUCVIv2ZtLnUgIHSdfmfn2pxTN//c2Orw==
Received: by recvd-canary-84d6db54bd-wdvvx with SMTP id recvd-canary-84d6db54bd-wdvvx-1-6AF06B3D-3E
	2026-11-08 12:29:49.858010868 +0000 UTC m=+217014.555711408
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-36 (SG)
	with ESMTP
	id rK-9LdFAQVWeVipO3UORbQ
	Sun, 08 Nov 2026 12:29:49.761 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: [PATCH 6.18.y] writeback: keep cleanup_offline_cgwb()'s scan out of
 syncs
Date: Sun, 08 Nov 2026 12:29:49 +0000 (UTC)
Message-ID: <20261108122949.601892-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051345-failed-6.18-90c96612460e@kernel.org>
References: <20261107051345-failed-6.18-90c96612460e@kernel.org>
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
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmeW+0ckIe452j?=
 =?us-ascii?Q?dQiwB0G9corOdXIDMSjTcECRq3YjhDAYK4TgQmU?=
 =?us-ascii?Q?cCdcOBShjtmzr9xe2L3VSNhJYr7lFb2sbfO28Bn?=
 =?us-ascii?Q?HuD3CEsDBjbBpc+NQCGwCNEkIr3=2FK91Tnhrscuo?=
 =?us-ascii?Q?YfUwm=2FmsbObRt=2FI+IAkQquysKB7gvlBSaIK1fJ1?=
 =?us-ascii?Q?OPjD?=
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
the rwsem is taken before it.

Tested on 6.18.62 with a debug hold on the sync work: after a crash, 252
of 300 lazytime atimes were lost without this and none with it (ext4 x3,
xfs x1). Lockdep and DEBUG_ATOMIC_SLEEP clean.

 fs/fs-writeback.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 094d2872881d..9c973ed0ef8b 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -756,6 +756,13 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
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
@@ -778,6 +785,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
 						 &nr);
 	spin_unlock(&wb->list_lock);
+	up_read(&wb->bdi->wb_switch_rwsem);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
-- 
2.53.0

