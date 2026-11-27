Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795770913;
	b=GNNZwsfGHiINVUwymkO3xQLmnbOOn38DdN9vMmrGhERgv66tlgMy66ZbUEwfFd41BInd
	 RGZrx+ur7R03TUyWrVibUgBN3IWgOoNguXcWky9NSL2VaTi8gXNeq026xrfAuRSQpcUIU
	 fcCZmpBWZPUnQQ3z1sviGeF81EpgsZQLKlAVrClVt6C+P3YoW/PjEt29GZPaQgn0zSIoY
	 H5av6M2vaqooxEfraVPxbXvl2cVl37JjgqP0JO2zTHNtzZj0FhlFOOg8ZL+DCG5mpHbhn
	 GCTTYBn6ZZjxRkJbx830k2g99tfMMKi3GNd7vIbI52yCFgQ4OMtgOndmbuGxt0Iq1mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795770913;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r4tf2BfxDN+nidvh3c/c73rJuBoTBoakfoPdafRUpy4=;
	b=0Ca9QXUs2eBQyeKFtYSoTm34mYasDNo4gjRQU92YefBkEoaozuO9Rc0BweTK9lgC4y8K
	 OQzw1MzKBR2e3HH6I7SuMNExPylXuXf78AqklG+VYCp+0xGd4oyHdtw0bhFZhTWCVeA9Z
	 Msi2a5iV1EEa7JRnEls8X9XS8CONxgvhForkha2Uc7V3Udn389n4CPKqiGUuDeAyWrLiZ
	 7Ub6QL6r+OUOa8yN3xjUcijmodYkPnJzZmyp3TtsGtNoicRxkSJr/g/dSW3ERqfX23kNS
	 bYE0dv4xaAlqHmYnnlt/9dtYqA4BU3bNhFM0RciapL56wm2gymo0IDEZyXtuuGYbFjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juovWTzc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFC606A31C;
	Fri, 27 Nov 2026 09:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=juovWTzc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795770912;
	b=LVSbMZGiILtDLcnmlv12oO8iDHH7XkQ0jFhpgEgbXxQROvtkLWzBcRFTAhJGlxIvbsWf
	 MXPKxStBVTO/SvVsk6vf4lCYVz9VWRFv1/tb1X/t9YZSIroWJB8Ei6suIatSjuA5EvMiF
	 Ot8Uh6lUyVqVRtxKYIoyf/VzD8Lqiwpvhy8lLzrqSbT29Z+/hm/pbDbRh+rGU4JJus0en
	 ErFBSq488jdqNs5g7o7W2ZI1EmZnRok0euEGlcOkcVuBBIIxeUAkWQ92huDrkrRSJqIUJ
	 HzfNpXpdAMZO3tPec/sdmODM7SX4RGKnqjXvEZhZS58cybEiBv8jFwZ4SK8jfeDhV/w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795770912;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r4tf2BfxDN+nidvh3c/c73rJuBoTBoakfoPdafRUpy4=;
	b=cj5anc6qwmbK7PD6mpsj8IQp3TLO7+zV9nGyx2LEg706LG9kC+PpAFdNSuPtY6djCguY
	 xsJ7qothtZzvE+YNt143bjEwAWLk8puhHax9wlal6o82RMT0WzusyuwEYc7nx8yNhPZV8
	 qSvkv2N3w3WnbVz6/HKbYal2ePxW6rmflHALZDR84mrXYq0TyQdMpJ4VLpXVkXMUREv33
	 chopgRwDKLJNZujXNYnMVVaNnSRvO8ICTRIxcY4Sy+NtJeXwM+C4cvCeP9DEzccdKVphg
	 +6zP4yC6aU/qK8EdC6VZTS5RzDagyjRIU0xxZx4idLptO8Ih+YTXi6mX4SPT/B94/VQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A03751F00924;
	Fri, 27 Nov 2026 09:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795770912;
	bh=r4tf2BfxDN+nidvh3c/c73rJuBoTBoakfoPdafRUpy4=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=juovWTzcXvSqaHomL4DCwxUgb0iY9n+VFvOEyku6il1yNMzCh55YsXphTM6xICBdn
	 lbOyaE2ixJDIDvZr01SagS5wrIdBkMiujDR2R/bvdkEG7hEugIuC7O0CjXQBD+6a0U
	 MqpS490rWot7HaxjPQr9+PyHqGNv2jAQzwxjFLMGGommu5mz85hzgSM7sgkZ79Jh2S
	 2bK+X5JIbBP09jlScRECtRLXTlaWdy0M4j20L+5Owhip4A+e2A6TvcxBWUXccm/9jL
	 Ef493RIoJbGMd0Dtk/p8TAgyIL1/LPW5AaUYz3JkgzyzoG4KZzNHj4h+lrrzeyLnOU
	 hQDv96KP5QowQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1BFA54B690;
	Fri, 27 Nov 2026 09:15:00 +0000 (UTC)
From: Xiubo Li via B4 Relay <devnull+xiubo.li.clyso.com@kernel.org>
Date: Fri, 27 Nov 2026 10:14:56 +0100
Subject: [PATCH] libceph: re-target OSD requests on PG merges
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
Message-Id: <20261127-libceph-pg-merge-retarget-v1-1-2427758cdd1c@clyso.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMBAEf6XcswfJgUb9FfGhTbftidZwSUUo/
 XejPi3DMrNShikynZuVDC/N+pwr+F1DcWrnEax9ZRInB+8l8F27iDRxGvkBq7+htHULh/3p6MQ
 NoRdQ9ZNh0Pevfbn+OS/dDbF8g7RtH/2TqJl9AAAA
X-Change-ID: 20261127-libceph-pg-merge-retarget-7598020f7d2e
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: =?utf-8?q?Niclas_M=C3=BCller?= <n.mueller@mueller-it.de>, 
 ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Xiubo Li <xiubo.li@clyso.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795770898; l=7315;
 i=xiubo.li@clyso.com; s=20260625; h=from:subject:message-id;
 bh=Zado0TAGrUK3dd3ptM/7zluOKnbbQeVWAwqIQJArbzQ=;
 b=2yIneOIi09i31RVhpoWGU9jt4sbVo/gZAE5X8/UvhOs2icbE+g7wuQr6JKl3O+YWyw9AI5rwQ
 0jaC4HgyYf7CQdm/5Vl8YG2bnYf5zaaQEk03hv4digM9UhsmiLLNk63
X-Developer-Key: i=xiubo.li@clyso.com; a=ed25519;
 pk=V3NGr0AgAopiUhaLY51ipBkLN5LlcLhjOEfLEq1RoZ8=
X-Endpoint-Received: by B4 Relay for xiubo.li@clyso.com/20260625 with
 auth_id=840
X-Original-From: Xiubo Li <xiubo.li@clyso.com>
Reply-To: xiubo.li@clyso.com
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubo.li@clyso.com>

calc_target() only recomputes t->spgid for a regular request when the
primary changes, when the epoch being processed is the pool's
last_force_request_resend epoch, or when the request's PG is split.
A PG merge (pg_num decrease) is not detected at all:
ceph_pg_is_split() returns false when the new pg_num is not larger,
and ceph_is_new_interval(), which compares pg_num, is only evaluated
for linger requests.

The monitor bumps last_force_op_resend_prenautilus, which is what the
client decodes into last_force_request_resend, on every merge step, so
most of the time force_resend covers the merge.  But it only fires on
that exact epoch, and it is easily lost:

- When one MOSDMap carries several incrementals, a request that is
  re-targeted on an earlier epoch is moved to need_resend and is not
  scanned again for the later epochs of the same message.
  kick_requests() then calls calc_target() once more against the
  newest map, which is past the force resend epoch of the last merge
  step, so the merge goes unnoticed.

- A client that falls far behind, e.g. an idle mount, may get a full
  map and never process the force resend epoch at all.

If the merge target has the same primary as the merged-away source
PG, the request keeps the spgid of a PG that no longer exists.  The
OSD drops such ops, as it expects the client to resend them to the
merge target, and the request is resent to the same OSD with the same
stale spgid forever:

  REQUESTS 3 homeless 0
  260  osd1  4.173fada4  4.24  [1,2,0]/1  [1,2,0]/1  e451
       10000000231.00000000  0x40001c  12  read

while pool 4 has pg_num 32 and 4.24 has been merged into 4.4.  This is
easy to hit with a mount that stays idle while pg_num goes from 128 to
32, and then reads.

Do what the userspace Objecter has been doing since the merge support
was added: treat the request's PG being a merge source or a merge
target like a split, recompute the target and resend.  Also count
merges as a new interval in ceph_is_new_interval(), matching
PastIntervals::is_new_interval().

Cc: stable@vger.kernel.org
Fixes: 7de030d6b10a ("libceph: resend on PG splits if OSD has RESEND_ON_SPLIT")
Reported-by: Niclas Müller <n.mueller@mueller-it.de>
Signed-off-by: Xiubo Li <xiubo.li@clyso.com>
---
A kernel client never re-targets an in-flight OSD request after a PG
merge if the merge target has the same primary, so the request is
resent forever to a PG that no longer exists and the read hangs.

Reproduced on a vstart cluster with a mount left idle while the data
pool went from 128 to 32 PGs: before the patch 2-3 of 200 reads hang
(both when the client applies every incremental map and when it jumps
to a full map), after it 200/200 complete.
---
 include/linux/ceph/osdmap.h |  4 ++++
 net/ceph/osd_client.c       | 13 ++++++++-----
 net/ceph/osdmap.c           | 24 ++++++++++++++++++++++++
 3 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5553019c3f07..0644a410b4c0 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -272,6 +272,10 @@ void ceph_osds_copy(struct ceph_osds *dest, const struct ceph_osds *src);
 
 bool ceph_pg_is_split(const struct ceph_pg *pgid, u32 old_pg_num,
 		      u32 new_pg_num);
+bool ceph_pg_is_merge_source(const struct ceph_pg *pgid, u32 old_pg_num,
+			     u32 new_pg_num);
+bool ceph_pg_is_merge_target(const struct ceph_pg *pgid, u32 old_pg_num,
+			     u32 new_pg_num);
 bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 			  const struct ceph_osds *new_acting,
 			  const struct ceph_osds *old_up,
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 22a793a4bdc8..3adb9e6394eb 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1595,7 +1595,7 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 	bool force_resend = false;
 	bool unpaused = false;
 	bool legacy_change = false;
-	bool split = false;
+	bool split_or_merge = false;
 	bool sort_bitwise = ceph_osdmap_flag(osdc, CEPH_OSDMAP_SORTBITWISE);
 	bool recovery_deletes = ceph_osdmap_flag(osdc,
 						 CEPH_OSDMAP_RECOVERY_DELETES);
@@ -1672,9 +1672,12 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 			ceph_osds_changed(&t->acting, &acting,
 					  t->used_replica || any_change);
 	if (t->pg_num)
-		split = ceph_pg_is_split(&last_pgid, t->pg_num, pi->pg_num);
+		split_or_merge =
+		    ceph_pg_is_split(&last_pgid, t->pg_num, pi->pg_num) ||
+		    ceph_pg_is_merge_source(&last_pgid, t->pg_num, pi->pg_num) ||
+		    ceph_pg_is_merge_target(&last_pgid, t->pg_num, pi->pg_num);
 
-	if (legacy_change || force_resend || split) {
+	if (legacy_change || force_resend || split_or_merge) {
 		t->pgid = pgid; /* struct */
 		ceph_pg_to_primary_shard(osdc->osdmap, pi, &pgid, &t->spgid);
 		ceph_osds_copy(&t->acting, &acting);
@@ -1706,14 +1709,14 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 		}
 	}
 
-	if (unpaused || legacy_change || force_resend || split)
+	if (unpaused || legacy_change || force_resend || split_or_merge)
 		ct_res = CALC_TARGET_NEED_RESEND;
 	else
 		ct_res = CALC_TARGET_NO_ACTION;
 
 out:
 	dout("%s t %p -> %d%d%d%d ct_res %d osd%d\n", __func__, t, unpaused,
-	     legacy_change, force_resend, split, ct_res, t->osd);
+	     legacy_change, force_resend, split_or_merge, ct_res, t->osd);
 	return ct_res;
 }
 
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index a946724d4ef7..0d418af9c5f6 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2358,6 +2358,28 @@ bool ceph_pg_is_split(const struct ceph_pg *pgid, u32 old_pg_num,
 	return false;
 }
 
+/*
+ * Returns true if @pgid is a merge source going from @old_pg_num to
+ * @new_pg_num, i.e. it doesn't exist anymore and its objects now live
+ * in one of its ancestors.
+ */
+bool ceph_pg_is_merge_source(const struct ceph_pg *pgid, u32 old_pg_num,
+			     u32 new_pg_num)
+{
+	return pgid->seed < old_pg_num && pgid->seed >= new_pg_num;
+}
+
+/*
+ * Returns true if @pgid is a merge target going from @old_pg_num to
+ * @new_pg_num, i.e. one or more of its children were merged into it.
+ */
+bool ceph_pg_is_merge_target(const struct ceph_pg *pgid, u32 old_pg_num,
+			     u32 new_pg_num)
+{
+	return pgid->seed < new_pg_num &&
+	       ceph_pg_is_split(pgid, new_pg_num, old_pg_num);
+}
+
 bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 			  const struct ceph_osds *new_acting,
 			  const struct ceph_osds *old_up,
@@ -2379,6 +2401,8 @@ bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 	       old_size != new_size ||
 	       old_min_size != new_min_size ||
 	       ceph_pg_is_split(pgid, old_pg_num, new_pg_num) ||
+	       ceph_pg_is_merge_source(pgid, old_pg_num, new_pg_num) ||
+	       ceph_pg_is_merge_target(pgid, old_pg_num, new_pg_num) ||
 	       old_sort_bitwise != new_sort_bitwise ||
 	       old_recovery_deletes != new_recovery_deletes;
 }

---
base-commit: 3f90412e989cb381d4bf96260468f5c7b2d08655
change-id: 20261127-libceph-pg-merge-retarget-7598020f7d2e

Best regards,
--  
Xiubo Li <xiubo.li@clyso.com>


