Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB27348C4C
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788712915; cv=none; b=jkvOQmF/0AVCN0FbT5aZrgG4flokp8OgaEeVR7vz/pw0zWt2uGMjAv42CNrbtAfak1tJhp/qvcNFJIcxRrGFNAHcrrIBIZDd102ktm8bdATzCQOqpZ9mrPorgiJv7TONPxUyZQe2O2F+rHXJLzbsxvLVDx2V6G3MLfgFpjNfRBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788712915; c=relaxed/simple;
	bh=YW7hij+2Ap+2p+P3mIpwt0FweJWV/wBDDNYlFQB1G3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iDsaecijynqhysfl400z2XG6e5ijZUKXh3weIwUzGboOxpgormxcOfDBUbLM1DbTv1n1bOpBlKUupRL1+6eAEAqkrM5bcl1UfT65dxmo0SJLWTq6uXnThqBF5v1VaPfUYJTFDk7/2lHgQiNOYtrFPZ2IdxHr/rqPv1t8zj3gOdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT+BAhH/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT+BAhH/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69EE31F00A3A;
	Sun,  6 Sep 2026 16:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788712914;
	bh=7EvuoRd8eYAIhoERbAFoy3kUujcXMeZdPiNroGGUWX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UT+BAhH/BpnNrQLWgnF1J4Jq84lGojlqyD/lbP5QkoscjYeoAIqCkpdKyJfugNa9V
	 elhs7Y1HoH35LG3aqVjI0IQhwa4rYUSJQLSSDws4q6bZXrV/WucF1rtoVuCOwuvibM
	 KwOpdDGkAUiiv0u+CWGdEAp5UZUUKCfNiOqmUGuFzacCZZq93GOFtoKcj+wdDoDU6N
	 yfnKSbCAtz/RpXREVfmikZycUuOD7xjl9S5xOCO8z7RjjpCbIDtm3IhuE530kf4fPS
	 K/Ft9o0oktfbvO+dfjHBRCT/TBvyr3Zy0mBNpdptmFfPq+1O8c8dKVKJMyBGrEVHGY
	 JoLwLdf6e7czA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ceph: do not repeat ceph_trim_dentries() if no progress possible
Date: Sun,  6 Sep 2026 12:41:51 -0400
Message-ID: <20260906164151.1611015-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090311-shiny-gills-15eb@gregkh>
References: <2026090311-shiny-gills-15eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit e7d7aa7b730178278109c41fa1b17b06873065d5 ]

ceph_cap_reclaim_work() re-queues itself for as long as
ceph_trim_dentries() returns -EAGAIN, which happens whenever a lease
walk exhausts its `nr_to_scan` budget.  This creates a busy loop that
consumes CPU without making any progress when there is nothing to
reclaim: with no cap pressure (`count==0`) and every scanned lease
still valid, each pass runs the full scan budget down to zero and
returns `-EAGAIN`, only to be queued again immediately.

The dir-lease walk made this worse.  When `expire_dir_lease` is
`false` (i.e. we have no intention of reclaiming dir leases),
__dir_lease_check() returned `TOUCH` for every valid lease.  `TOUCH`
moves the dentry to the tail of the list and resets `di->time` via
__dentry_dir_lease_touch(), so a walk over N valid leases pointlessly
rewrote the list, refreshed the timestamps (preventing them from ever
aging out) and always drained `nr_to_scan`, guaranteeing the `-EAGAIN`
requeue.

Fix this in three steps:

 - Return `KEEP` instead of `TOUCH` when `expire_dir_lease` is
   `false`.  If we are not going to reclaim the lease, leave it in
   place instead of churning the list and resetting its timestamp; the
   walk then terminates naturally (or via `STOP` at the first fresh
   lease).

 - Only return `-EAGAIN` from the first (dentry-lease) walk when something
   was actually freed.  A full batch that frees nothing means retrying
   the same list immediately is futile; fall through to the dir-lease
   walk instead.

 - After both walks, bail out with success (0) when nothing was freed
   and there is no cap pressure (`count==0`).  There is no reason to
   keep retrying when we are not over the cap limit and made no
   progress.

Under real cap pressure (`count>0`) the reclaim path is unchanged and
still retries via `-EAGAIN`.

Without this patch, I saw 500 ceph_trim_dentries() calls per second on
our web servers.  This is very visible in `/proc/lock_stat` (5 minute
capture):

              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

 &mdsc->dentry_list_lock:        126180         128218           0.04        8063.44    15986965.20         124.69        1573354        5296812           0.04        8291.28    74164526.48          14.00
 -----------------------
 &mdsc->dentry_list_lock         111736          [<000000007b11e319>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock           2631          [<0000000050597999>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock           3878          [<00000000c0022f62>] __ceph_dentry_lease_touch+0x5c/0xa8
 &mdsc->dentry_list_lock           9973          [<000000002f27cb6f>] __dentry_lease_unlist+0x50/0xa0
 -----------------------
 &mdsc->dentry_list_lock         123621          [<0000000050597999>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock           1822          [<000000007b11e319>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock           2720          [<000000002f27cb6f>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock             55          [<00000000c0022f62>] __ceph_dentry_lease_touch+0x5c/0xa8

With this patch:

              class name    con-bounces    contentions   waittime-min   waittime-max waittime-total   waittime-avg    acq-bounces   acquisitions   holdtime-min   holdtime-max holdtime-total   holdtime-avg

 &mdsc->dentry_list_lock:          1203           1215           0.16         408.88       33082.88          27.23        4320501        7357389           0.04         500.64     1961578.00           0.27
 -----------------------
 &mdsc->dentry_list_lock           1029          [<000000003c9aea8a>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock            169          [<000000002038c577>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock             16          [<00000000c991106d>] __ceph_dentry_lease_touch+0x5c/0xa8
 &mdsc->dentry_list_lock              1          [<00000000612fe15f>] __dentry_leases_walk+0x64/0x2c8
 -----------------------
 &mdsc->dentry_list_lock            158          [<000000002038c577>] __dentry_lease_unlist+0x50/0xa0
 &mdsc->dentry_list_lock            858          [<000000003c9aea8a>] __ceph_dentry_dir_lease_touch+0x7c/0xa8
 &mdsc->dentry_list_lock            182          [<00000000612fe15f>] __dentry_leases_walk+0x64/0x2c8
 &mdsc->dentry_list_lock             17          [<00000000c991106d>] __ceph_dentry_lease_touch+0x5c/0xa8

__dentry_leases_walk() is almost gone.  The total wait time is reduced
by a factor of 483.  That will give some latency gains to
ceph_readdir().

Cc: stable@vger.kernel.org
Fixes: 37c4efc1ddf9 ("ceph: periodically trim stale dentries")
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Reviewed-by: Alex Markuze <amarkuze@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
[ retained callback arguments for __dentry_leases_walk() required by Linux 6.6 ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/dir.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 74845a793aa36..ea3b2abb38152 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1503,11 +1503,11 @@ static int __dir_lease_check(struct dentry *dentry, void *arg)
 	if (ret > 0) {
 		if (time_before(jiffies, di->time + lwc->dir_lease_ttl))
 			return STOP;
+		if (!lwc->expire_dir_lease)
+			return KEEP;
 		/* Move dentry to tail of dir lease list if we don't want
 		 * to delete it. So dentries in the list are checked in a
 		 * round robin manner */
-		if (!lwc->expire_dir_lease)
-			return TOUCH;
 		if (dentry->d_lockref.count > 0 ||
 		    (di->flags & CEPH_DENTRY_REFERENCED))
 			return TOUCH;
@@ -1534,7 +1534,7 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.dir_lease = false;
 	lwc.nr_to_scan  = CEPH_CAPS_PER_RELEASE * 2;
 	freed = __dentry_leases_walk(mdsc, &lwc, __dentry_lease_check);
-	if (!lwc.nr_to_scan) /* more invalid leases */
+	if (freed > 0 && !lwc.nr_to_scan) /* more invalid leases */
 		return -EAGAIN;
 
 	if (lwc.nr_to_scan < CEPH_CAPS_PER_RELEASE)
@@ -1544,6 +1544,10 @@ int ceph_trim_dentries(struct ceph_mds_client *mdsc)
 	lwc.expire_dir_lease = freed < count;
 	lwc.dir_lease_ttl = mdsc->fsc->mount_options->caps_wanted_delay_max * HZ;
 	freed +=__dentry_leases_walk(mdsc, &lwc, __dir_lease_check);
+	if (freed == 0 && count == 0)
+		/* no progress possible currently, retry futile */
+		return 0;
+
 	if (!lwc.nr_to_scan) /* more to check */
 		return -EAGAIN;
 
-- 
2.53.0

