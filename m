Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=149.72.141.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794140992;
	b=3SXGFFenVWtrV6ZpK1Wboz0BjNhXSUBSIY73JbeNMSiTlrHxrQgsjzRhXgS4b33cfOXu
	 dFTTj4MohR652igtzRNVeN5Grlanbenv7uiwXmEGmQPDKj50McXkVTVQdvKXh3ta/YMvs
	 wkX7bWVXoCQxp7HY2PYjXkpP+BY94S5Fvd94yoHEREHJ3pkz99lblWMMTYJDtY+0WxkSO
	 X70u/dB1VmdWYuSRPuMcw3dB8rlJgig3CxLJRYmFA/p5keJyXt5KRqPJ6KsljxQQS3QZS
	 5TDSr9V8yBCNNz+mNVPWgBTPYf1MkwM/WQ/xkxWy3h7Bkdb0Yw0lRjJs4FdPBKS6HQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794140992;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:X-SG-EID:To:
	 Cc:X-Entity-ID:Content-Transfer-Encoding:Content-Type;
	bh=6zo9Affma3d9f2OvsvgbfKWV0Uz8drYcRyaGKjyIPS4=;
	b=KlVw3gy7/dLOhMYc43nWQIfs76epU3sArZijZVe2Hx7kgWhsIyrkYS1orLUAJu5i7jcW
	 ts2PW2FNgwsejomX+mvDy+nL0tyT/wNOW7i1RCqYzAoBFNPq2KW1YjiR99kmRESJG3Q7h
	 hdKOt1hiuaeSkX0iiCw1UmAemc/4wRKPtJexQlrjvisZ1pQv5jf8U2nMpiL4lQvaPnORP
	 hNdrA6W4uNp7pZUZxim+kwM/xPvj2VarMxvDwfJ33zWEgr8sNy7jHIRlgP9NSSJdxI5f2
	 ISKqcfzTEna/dyxnmmGisLak0ueHk8vaPluktX/srIR+vfKZYYIfqtLevWabKsqSjJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=honeycomb.io;
	spf=pass smtp.mailfrom=em.honeycomb.io;
	dkim=pass header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=Qp5CJ72b;
	arc=none smtp.remote-ip=149.72.141.136
Received: from o1.ptr9745.em.honeycomb.io (o1.ptr9745.em.honeycomb.io [149.72.141.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF84606A320
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 12:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDF84606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=honeycomb.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=em.honeycomb.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=honeycomb.io header.i=@honeycomb.io header.a=rsa-sha256 header.s=s1 header.b=Qp5CJ72b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=honeycomb.io;
	h=from:subject:date:in-reply-to:references:mime-version:to:cc:
	content-transfer-encoding:content-type:cc:content-type:date:from:subject:to;
	s=s1; t=1794140990;
	bh=6zo9Affma3d9f2OvsvgbfKWV0Uz8drYcRyaGKjyIPS4=;
	b=Qp5CJ72bOGsf+MZLoZVIj/v+NP9PaaXtNMNfwkEqEbmRxglrCD2gyqFO1sYCwa1PgdIH
	7KciPLlBDUSNCYKADnrMFLiFAuPNaRgFmFuKhsuwwxKd/6m5WfmE0MpBdRcspdkmNynDQM
	mqF6fXWWbhJT9sfqSqmgtSc+KVMnPGVdb5O9W1otUSvLCLVMX6skMZyMsqbc67F0esZvNu
	h55DwKO2/GsdgSSebHVvBYy76oQ6kr8CCbM8uLOtLyKG5GivVvzIb0bSafuBVIKoHvBpdd
	8BfvBbyxSGEZL5zPOKIVc4iBKN20OH0eB50JA0lJBWBkQ5oN87fbhpalJJUxdf4Q==
Received: by recvd-65b8cfd999-6zpt9 with SMTP id recvd-65b8cfd999-6zpt9-1-6AF06B3E-62
	2026-11-08 12:29:50.651994134 +0000 UTC m=+216962.289948740
Received: from daisy.dens.ffj.family (unknown)
	by geopod-ismtpd-16 (SG)
	with ESMTP
	id ATXYnMNzRtmjbAXUyZu1Ew
	Sun, 08 Nov 2026 12:29:50.577 +0000 (UTC)
From: Liz Fong-Jones <lizf@honeycomb.io>
Subject: [PATCH 6.12.y] writeback: keep cleanup_offline_cgwb()'s scan out of
 syncs
Date: Sun, 08 Nov 2026 12:29:50 +0000 (UTC)
Message-ID: <20261108122950.601926-1-lizf@honeycomb.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052523-failed-6.12-90c96612460e@kernel.org>
References: <20261107052523-failed-6.12-90c96612460e@kernel.org>
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
 =?us-ascii?Q?ezqeFFjUkh=2FeROy4LtnO7KN9jZmef1=2FqNfKkWze?=
 =?us-ascii?Q?c66FofcWXkGT6XbwNvkOFGDaypjjBPoQxXu0aWq?=
 =?us-ascii?Q?CrRzL3gXComSMi3g0wMYzxIP0ykWYo++MxXPujy?=
 =?us-ascii?Q?PMK+oxKTQo=2FY2jtgsYDdIdOoct4Jt77qugrckO0?=
 =?us-ascii?Q?yV4AyqKqwZVb3lJ2sDzjc3Sdqnn3pZLPGuQlK7X?= =?us-ascii?Q?QBHE?=
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
index 48ac4f58605e..03f1bb9a2bc9 100644
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

