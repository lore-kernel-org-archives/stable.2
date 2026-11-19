Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795084593;
	b=PKvaTsWA/wXuec6Gq7MMmF4lzz4pyxQ2v2bVkrEMcBYxJR9yEbDw3KL0eX2iURrz0iW9
	 qt1DLHo4kIV8R4LWSzFZWk5xoh2deQvw3NLCFCKXhAHrsccC6R/413yu/TvMA1Quyux00
	 vkmZ2mIEGc/I6ZHelNK+C+Jx6nIVPhBuEHtzkfdsB5EnJub0eA3qwAPp1EUz5TqbBpNL0
	 yQ/s5DTOMVLNI4m0xaliZt4sagBjPw9alMdbIRn7e9Pi5zXGhLsY9U/ZQ2GDCDpNFeJwn
	 FNmds/zzcBzhOPcgVuTgkIlqD+wEWVAiO+VIznRkbM4Jn3p2Qo70wDNygkMoRg3CGOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795084593;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G37VaxbrGX/eenghh5IVt88W+qJYL1Hg1iK9/5saiJE=;
	b=xxTZsPveV4eOX6ssY+n/Gh0k1bEfDcj5X4SYrhLoqc/+EdeYCFfK7BPr9h7eyCibKs1L
	 DhxV4iNH4DGWnEjCT11fuGsI2YgFzyL71ykx0VVFoYvRdhRdajgDtQOXypRUDuU+1Gtcc
	 4Ka7mKTxly/iYP8WjtYfSv3kQfwBw2WzvFCbGbpzDGDSLYxr0PjLigS6uaviOFu+86Mcg
	 ZZxpf8MuXzvmpNYLAP469zLkTa8YNsStmoK05UqCu1tWqlG+EPF56k7Y5WKMZoMIIoLds
	 pjpS6T8MQcDhh+ogtmGTVO0wWUSd6IjfgU+f1/ArpNFe6BC/kq1qNeUG9zk/h3TBV1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPGNOgwx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353EC606A326;
	Thu, 19 Nov 2026 10:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPGNOgwx
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795084592;
	b=nav3Fmgzl3eOf4HWZgi2wF8c7vJqSqLTPYmZL86oxtnfVeMqYquiHYN3vOrCCa4/FrFN
	 eFntf0YD5Q5wJ9IUgpT930tryDfVbESgJtcd4FqRTOojHa618qcwpPVSIhBEhU48+fwIq
	 vFYO8zsPfRP5RVXaMI+W4xG061lTlX5wukKPOrhMcBBmkDx+KzeKBZ6u1Hh5RMqxgYM3A
	 A7Uo+6eyq+teQO/qjea8flDp8wbH8EWNkDqEv++YlqWMxOqXcpsMWnXGGGQUqroN+Dz5o
	 rkV6Lfg8gf+gKqEc10u3b7Ce1rupz1cQ9imfFhdk6MK3x5vzlbpVI+f/+7pzVgH8anw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795084592;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=G37VaxbrGX/eenghh5IVt88W+qJYL1Hg1iK9/5saiJE=;
	b=CMIt2/26+4yOSPlmeE5qYdPd5cBGDiqle1i/hqBvEu8ZW/fLHBQ3EkyIr0CqsJF+rh1i
	 jR4UgITopeVLmhNr91QECx4+uK2pAHw2oFdxNLwpYk45LyOzHFB2BY7S8tl5DqbUYCy4f
	 D0D+sWbVF0NmWyX0RJiseTehc+tAWDHpIRfn3e9tZS0c5MthdTBcFKgx3PlZGr1dYLsdS
	 opjHolUPGybZ+uic7E8brB60pIhb7k4ggiLZxP/L/IKECg/SyEmk0YHU7+dDspHVQK17m
	 CU9ASn39tjr28fy7J5RMMhuS0jYsOOn3eugYG/J47X8D9s2AJAmhj5mQVxuamoywDJQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 190141F000C6;
	Thu, 19 Nov 2026 10:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795084592;
	bh=G37VaxbrGX/eenghh5IVt88W+qJYL1Hg1iK9/5saiJE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=kPGNOgwx96//wV7lGAJ+MTHStjPMtlhgoSDmmwef5jJRcxyo2ozDEjJm5rgybYU6b
	 vqIsVAdEkIX0jnf5nZHIzHNQQVL5SqOcB4TfhgkXvJMETUgC8NMagFQtSMjKPs0ovr
	 8zICJ9sYI5sg/tOFD/ezGmq1QviPrzfUqCwgfjJUWiZxVy3XUEN4zEXE7m97Ob/IcV
	 JR4wcljJBFo4xlCosAQw6NJaefGO1EGse3UK3ttyWg5TkDjV0JMjt/MLbaq3Z93PH6
	 o67pU10s3DjtPTAHyTN1PUEgiUKMz6FPmJzdxpyDOcy8U1XAtR3VyVtu7r0pWSu0Su
	 FzScniAT5btDg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 9AAE24B24A;
	Thu, 19 Nov 2026 10:36:31 +0000 (UTC)
From: Alex Ainscow via B4 Relay <devnull+aainscow.uk.ibm.com@kernel.org>
Date: Thu, 19 Nov 2026 10:35:36 +0000
Subject: [PATCH] libceph: don't put a linger request twice when its watch
 is cancelled
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
Message-Id: <20261119-wip-libceph-linger-uaf-v1-1-40f3661fea68@uk.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAA/yWM0Q5FMBBEf0X22SZaIvgV8aC1WBGa9rok4t8tn
 iYnM3NOCOSZAlTRCZ7+HHhdBFQcgR3bZSDkThh0onOlVIE7O5zZWHKjpAw8bm2P0pWdNqlNswT
 k7Dz1fLziuvk4bGYi+3tscF03j4fg+XoAAAA=
X-Change-ID: 20261118-wip-libceph-linger-uaf-1119d2b3c340
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Xiubo Li <xiubo.li@clyso.com>, Viacheslav Dubeyko <slava@dubeyko.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: Xiubo Li <xiubli@redhat.com>, ceph-devel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alex Ainscow <aainscow@uk.ibm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795084591; l=6146;
 i=aainscow@uk.ibm.com; s=20261119; h=from:subject:message-id;
 bh=P336QPYKJ+T98DqHq/Xl/XyUZlBZy0xGC+6YBxgAyJQ=;
 b=+NmmuqClQ9aYtwjUwh1aiaet+s66SSRqJ0aDT2Pa7MKJK2Fi7LaRy1KjDNPMJHVv0OVhYOBF/
 tPeUwUBx8FND5obSVsQXQXu6JLRHdBLlEi62b4s0C7e6NluI5ln9xEi
X-Developer-Key: i=aainscow@uk.ibm.com; a=ed25519;
 pk=VlrkYHn/ahAgYEx7wjI3JQeBO/6/uCw4k8oYcEnn6dE=
X-Endpoint-Received: by B4 Relay for aainscow@uk.ibm.com/20261119 with
 auth_id=1568
X-Original-From: Alex Ainscow <aainscow@uk.ibm.com>
Reply-To: aainscow@uk.ibm.com
Content-Transfer-Encoding: 7bit

From: Alex Ainscow <aainscow@uk.ibm.com>

handle_reply() finishes a request under osdc->lock and completes it,
calling its callback, after dropping the lock.  A linger request on
lreq->osd_reqs holds a reference for the list, which both its callback
and whoever empties the list (send_linger(), __linger_cancel()) drop.
If the list is emptied in between, as when rbd re-registers its watch
after an error just as the reply to a watch ping comes in, the
reference is dropped twice:

  handle_reply thread             rbd watch error / OSD reset

  down_read(&osdc->lock)
  finish_request(ping)
    # unlinked: r_osd == NULL
  up_read(&osdc->lock)
                                  down_write(&osdc->lock)
                                  __linger_cancel(lreq)
                                    # not cancel_linger_request(),
                                    # the ping is unlinked
                                    list_del_init(&ping->...)
                                    ceph_osdc_put_request(ping)
  __complete_request(ping)
    linger_ping_cb(ping)
      list_del_init(&ping->...)
      ceph_osdc_put_request(ping)
        # freed
    complete_all(&ping->r_completion)
      # use-after-free

Drop the list's reference in the callbacks only if the request is still
on the list, and empty the list in __linger_cancel() under lreq->lock,
as send_linger() does, so that whichever takes the request off drops
the reference.

Seen as a KASAN slab-use-after-free in complete_all(), called from
__complete_request(), on a request freed by linger_ping_cb(), in the
rbd-nomount workunit krbd_data_pool.sh after OSD session resets.

Fixes: 75dbb685f4e8 ("libceph: fix potential use-after-free on linger ping and resends")
Cc: stable@vger.kernel.org
Signed-off-by: Alex Ainscow <aainscow@uk.ibm.com>
---
This is a standalone fix for a use-after-free in the kernel RADOS client,
split out from a larger in-progress series (EC direct reads, pool migration
and stretch EC) so it can be reviewed and taken on its own. It applies to
current ceph-client/testing and is a stable candidate.

A linger request's list reference can be dropped both by its reply callback
and by whoever empties lreq->osd_reqs (send_linger(), __linger_cancel()).
When the list is emptied in the window between the two - e.g. rbd
re-registering a watch after an error just as a watch-ping reply arrives -
the reference is dropped twice and the request is freed while still in use.
The patch makes each side drop the reference only if the request is still
listed; the full race ladder is in the commit message. KASAN flagged it as a
slab-use-after-free in complete_all() during the krbd_data_pool.sh workunit
under repeated OSD session resets.

This fix was prepared with AI assistance (Anthropic's Claude Code): the race
was found by AI-run KASAN testing of krbd under thrashing, and the analysis
and patch were done with AI help and reviewed by me before sending.
---
 net/ceph/osd_client.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 2ad6d917ee61..481cd56301c0 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -3053,6 +3053,7 @@ static void linger_reg_commit_complete(struct ceph_osd_linger_request *lreq,
 static void linger_commit_cb(struct ceph_osd_request *req)
 {
 	struct ceph_osd_linger_request *lreq = req->r_priv;
+	bool listed;
 
 	mutex_lock(&lreq->lock);
 	dout("%s lreq %p linger_id %llu result %d\n", __func__, lreq,
@@ -3078,10 +3079,13 @@ static void linger_commit_cb(struct ceph_osd_request *req)
 		}
 	}
 
+	listed = !list_empty(&req->r_private_item);
 	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
 
-	ceph_osdc_put_request(req);
+	/* unless send_linger() or __linger_cancel() took it off */
+	if (listed)
+		ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3101,6 +3105,7 @@ static int normalize_watch_error(int err)
 static void linger_reconnect_cb(struct ceph_osd_request *req)
 {
 	struct ceph_osd_linger_request *lreq = req->r_priv;
+	bool listed;
 
 	mutex_lock(&lreq->lock);
 	dout("%s lreq %p linger_id %llu result %d last_error %d\n", __func__,
@@ -3112,10 +3117,13 @@ static void linger_reconnect_cb(struct ceph_osd_request *req)
 		}
 	}
 
+	listed = !list_empty(&req->r_private_item);
 	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
 
-	ceph_osdc_put_request(req);
+	/* unless send_linger() or __linger_cancel() took it off */
+	if (listed)
+		ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3182,6 +3190,7 @@ static void send_linger(struct ceph_osd_linger_request *lreq)
 static void linger_ping_cb(struct ceph_osd_request *req)
 {
 	struct ceph_osd_linger_request *lreq = req->r_priv;
+	bool listed;
 
 	mutex_lock(&lreq->lock);
 	dout("%s lreq %p linger_id %llu result %d ping_sent %lu last_error %d\n",
@@ -3199,10 +3208,13 @@ static void linger_ping_cb(struct ceph_osd_request *req)
 		     lreq->register_gen, req->r_ops[0].watch.gen);
 	}
 
+	listed = !list_empty(&req->r_private_item);
 	list_del_init(&req->r_private_item);
 	mutex_unlock(&lreq->lock);
 
-	ceph_osdc_put_request(req);
+	/* unless send_linger() or __linger_cancel() took it off */
+	if (listed)
+		ceph_osdc_put_request(req);
 	linger_put(lreq);
 }
 
@@ -3285,6 +3297,7 @@ static void __linger_cancel(struct ceph_osd_linger_request *lreq)
 {
 	struct ceph_osd_request *req;
 
+	mutex_lock(&lreq->lock);
 	while (!list_empty(&lreq->osd_reqs)) {
 		req = list_first_entry(&lreq->osd_reqs,
 				       struct ceph_osd_request, r_private_item);
@@ -3293,6 +3306,7 @@ static void __linger_cancel(struct ceph_osd_linger_request *lreq)
 		list_del_init(&req->r_private_item);
 		ceph_osdc_put_request(req);
 	}
+	mutex_unlock(&lreq->lock);
 
 	cancel_linger_map_check(lreq);
 	unlink_linger(lreq->osd, lreq);

---
base-commit: 6a9830a8f414d3830c584782568d0233be969d09
change-id: 20261118-wip-libceph-linger-uaf-1119d2b3c340

Best regards,
--  
Alex Ainscow <aainscow@uk.ibm.com>


