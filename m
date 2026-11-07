Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046427;
	b=z+J4p2b/Mw6oK3KnVgCVbD5KkZIyVxJgQpeTuo1ewgIrYZEDIhXiv8/9Cy2AmbD3rZ+0
	 3KHFC9Dn6Jyj0TSVnP9aBfP3dcwRxlzO2syPOVtK3S8R7KWHG7qlZxdL7V+pD6HoFmFWm
	 Qqw+/+JoKkvr3zW6KZhT9i2IKop6EUX9cTUfDUhvL7seI4msNg98mVFHglxfFacsXz+QN
	 +q5vxWKXDwPL6jBEyaxlbxrRlfUF4i7s57EOq/nLIlR0aYHyNceWifhS9gHZnJJVCIrFS
	 Gqlxki1ui0bc45KwMj42abESSgQaGC7Ct2fSNMps1Pok9LHTaNAVhZeMJbV9xJsSqNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046427;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qqhMX3sQMWRPUv3Hf33ilNH1AnTVmOg5RUrq+1jzFJY=;
	b=N5Wm09J00ZbAJ1A5AXuWpRAZsz83AYsKKii5LOHIo5bUDPB2x2D18YaDs7xnTs38JSQM
	 ZDTC9IjnH3NINWwMPKzOD0Fu63dhuvDtmM0ByVCebvWJHJ5RkZG/Fm5F6/K6irjqONQcB
	 IBZMdGJTUkX/7LOCpD8Um19nxhB2uhNxZ9gpjSjSIkYz253ugPkUTbQF4/jo8s3pp0KET
	 24MlYOqiEfwbO2Zt8ExSxM+/OD+NpWFwIZOHuUGZj9SOBgXiDwrdSsY8GycRryGBvpg/M
	 J3yRKrnKnvMII3SDVuS0O2Q2OeIkbPhBjsZcGNMEX73kiMXh1VCKFyRF4rsPJElUs9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jnfv/pu7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DFE5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnfv/pu7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0BAA1F0089F;
	Sat,  7 Nov 2026 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046427;
	bh=qqhMX3sQMWRPUv3Hf33ilNH1AnTVmOg5RUrq+1jzFJY=;
	h=From:To:Cc:Subject:Date;
	b=jnfv/pu7VhyKfjOUt85Ek3wV160QhJsz3neBTmsnpLmqm1ByNaEZoHUfhexWRFUUB
	 IFOhvCYyF8G7Miq5kiyTXhuOstaJMNHzWlPq83JaWpA3G+vnjDd/JBaLauuHPoboKl
	 ko0qmqj3eeZHssBpDN20VB9MTbRD4x9e3SGfXsya04IEsR81jF1LfbGcSo/mZ7uLVM
	 pkhx3kSWB5RdgGnnScMW8hKf2V0q4vY4AEFdJ00hpPycAcf0ioMmODwolF8iNEXhQf
	 s3pQiqnAD4kj2EY2SsGzMxl+h4Zjcy7mGKtBKO/zp9GLlehMAib0238CI17wtftu5C
	 SZQqnlR5bDGqQ==
From: Sasha Levin <sashal@kernel.org>
To: lizf@honeycomb.io,
	tj@kernel.org,
	jack@suse.cz,
	brauner@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] writeback: keep cleanup_offline_cgwb()'s scan out of syncs" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:45 -0500
Message-ID: <20261107051345-failed-6.18-90c96612460e@kernel.org>
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
git cherry-pick -x 90c96612460e6accddbda5a195e6ddaa391ecde0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051345-failed-6.18-90c96612460e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




