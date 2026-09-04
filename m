Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF44A4E8E17
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534197; cv=none; b=PbOBbqG+Ip4Kfpm3dWPhun+Ot6modQMe1GQmiJHntz1ZQN9rD/4oFaIutkuECIl2vq1HktROHPep4hNTTxksQ/s5TmMMyBUqScl/0Mqgv7mB9pVUfSigd7noEqFYruBzDb1m/I8CqrZ6+tfw7AOC39coqvf7eZ66py87segzN3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534197; c=relaxed/simple;
	bh=6RcqfWTpR9cSAA7gQiwQ0i4hUp/8e4bbFr3Xg/BPp9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p70aUH7D+0/ShoRc3LnJBB462AOGk7v9IantFGe5qhQeQqu2CZHv5EKzW/OuO9tRAvFbla86u3FcmRHH5VjNpG+McW9DxbwyI0WbkJJDVx8cxYlFC9E5crD0H2R95did67QaxuUK5ptUJpS2bxz4FfxyIt1ty4ONatyRsGfPRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=W0KNwZ9z; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="W0KNwZ9z"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a6868f18aeso1674529a12.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1788534193; x=1789138993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPdoZec4iRzjfMWUlv4D9QHImQ8qSXuSr3RPA6jeV48=;
        b=W0KNwZ9z8LmrZGcIAtOzKp+85vNnLoxXfmkkKfcKvn3ZSHhX4eZYcEmyhly1T1/yJF
         B+bxLSxaitpKR2aWAtXNy0YSG6s2ZL/BUN+pZBXrId212byn+FluHRKV7B1PtxKBMLcq
         +/kBMqzjy6ZETHZtMIrLvzG+0/FKRX8uxs9PZiyWLmNVBx5gwTE+kHVjcfdDJbDFppg5
         +BQCJb39l+P0DsaD8Eh7ON6INsFDl+CrclB8fN/FvdxJL6+p+BtRU8sl2OrGCPb1gJvd
         Fj1U9owcnSRahjo2d//07lW1sUmB2d0BuJPdeS3D1JX7XP+nFIjmZ1bK3K8WfwIiduuy
         VNDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534193; x=1789138993;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NPdoZec4iRzjfMWUlv4D9QHImQ8qSXuSr3RPA6jeV48=;
        b=UEu8yjdU2wGeIQhun8VK2nkQvEZOygUaPlGnEwnNJaRaSdKaymn9b+3mgAYRAUS+jC
         HxoJfmAU5BvjSErGPCdekZ5vEqcqI2Nw9jXWdDuI/35a/D67OL45jxbBeA/whmLYDhB9
         d55bpKlTKE7Z0QSWxZcDn4qTw8ZkmvOgyWZ1V/NZ/dLywnSHkqZxd6DYJpDfRGvzEjAF
         d/uSNY7C7L9EWRCQ9+afAiJn06DiTvnSa1WFlqcbh1ZYV0WbWUn+A3zdhsEenpu7MNJb
         AzGXg/ebGvJO4qs6wr/3AjUtjJtIM8HvEL7psHNGhCFyDt/x5WeLOMBIuITZIs3tCDH5
         oUtw==
X-Forwarded-Encrypted: i=1; AKwUvBwJ5LXzdIcGdXT71yaOXY3LVPCyG1tabrUYyFvT6HdkNHlLLYjSjr0eyA3j2x/DiJ6vT4A89Bg=@vger.kernel.org
X-Gm-Message-State: AFuF++nc+dncSh2tppZeuYEQ/o7bQEsg4DO461LqRS+lcK46UUp4WVaG
	VBMghR1hrma0ppZqLY2GIdXpDmGkDewOJPiF1MiAY2okOd6L9WbRetW1FiEJgkjZxCw=
X-Gm-Gg: AYBFou3cvGmvxPmprK+HiAM16ViT9NBFDOuGM6dFN1MvoMewJ32Aw37VAH7OlvdiwRS
	ZUu2K7xgAmmKwOuvBHFPbaOG9XAvIxL4wRvhIINgbyiY76o2INSPxFzNdLfHV2RHqB/LsOf6m7r
	fYgElMn/9Mipwo7yeo3OcTqtc4Jw3UBMajKdUmffVwmaO3+MwWPUu0SOXWoLLKFqxsb+WFu8elA
	V+BXcNwTkFDRvAhYAKqRs1WZMk6U69sOayNcYfeRd33o0YZOx9N8bLo0AEZl/XeSvb26N+fPFav
	8hCPgHSIQIHHipvdDCJPJklWMrIQcXss55vcw4OOMuTLp8V8nk6o6+zwn8X+r+BcHKgremx5kZT
	RN1pbTOOvPUxxjTgGNXQbFrEuoVS+pdQQ1OeZK/NfgCsr35zIqiAa/3fytNpDJZAy2eKfzJ0GGX
	/KqJ5aJSgthQmSuqRNl2RZgNEt9oBizdkhS+YnLp/9s60UAlcj7LAlUJFEoZogwG/5gH+zYDxIE
	HDa0Ydr4z1/EsHP450/5YIzpZ8SHDcslH9YLfUNWAlGESq3xiS3LM9H8dGuclXi
X-Received: by 2002:a17:907:a892:b0:c20:3402:bd35 with SMTP id a640c23a62f3a-c260c988d8cmr286054566b.12.1788534192795;
        Fri, 04 Sep 2026 08:03:12 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f04b700023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f04:b700:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d6e1c93sm122438866b.63.2026.09.04.08.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 08:03:12 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: idryomov@gmail.com,
	amarkuze@redhat.com,
	xiubo.li@clyso.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH v4 3/3] ceph: don't unregister an MDS session before removing its caps
Date: Fri,  4 Sep 2026 17:03:04 +0200
Message-ID: <20260904150304.49104-4-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904150304.49104-1-max.kellermann@ionos.com>
References: <20260904150304.49104-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

handle_session() removed the session from mdsc->sessions[] at the very
top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
Between session unregistration and remove_session_caps(), the MDS rank
has no registered session while the old session still owns all caps it
was granted.

Any concurrent filesystem operation may walk into that and the next
__do_request() call registers a new session for this rank.  Once it is
open and the MDS issues caps, ceph_fill_inode() calls
ceph_add_cap(), which looks caps up by rank, not
by session identity, finding old caps linked to the old session.

The list_move_tail() call then moves the cap object to the new
session, which is already a bad thing to do.  Since it doesn't
decrement `old_session->s_nr_caps`, this quickly triggers:

  kernel BUG at fs/ceph/mds_client.c:1959!
  Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
  [...]
  Workqueue: ceph-msgr ceph_con_workfn
  pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : remove_session_caps+0x2bc/0x2d8
  lr : remove_session_caps+0x74/0x2d8
  [...]
  Call trace:
   remove_session_caps+0x2bc/0x2d8 (P)
   mds_dispatch+0xf48/0x1b60
   ceph_con_process_message+0x74/0xa0
   ceph_con_v1_try_read+0x3a0/0x1510
   ceph_con_workfn+0x260/0x460
   process_one_work+0x168/0x3b8
   worker_thread+0x1bc/0x3a0
   kthread+0x118/0x1e0
   ret_from_fork+0x10/0x20

That's BUG_ON(session->s_nr_caps > 0).

I was able to reproduce this reliably by delaying the close and
starting I/O during the delay.

This patch keeps the session registered with
`CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
`s_waiting` list where they will be resumed on the new session.

Since `CLOSE` now sets `CLOSED` before taking `s_mutex`, make
send_mds_reconnect() validate and update the session state under
`mdsc->mutex`. Preserve `CLOSED` if reconnect preparation later fails.

Fixes: 2600d2dd5085 ("ceph: drop messages on unregistered mds sessions; cleanup")
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/caps.c       |   4 +
 fs/ceph/mds_client.c | 182 ++++++++++++++++++++++++++++++++++++-------
 2 files changed, 156 insertions(+), 30 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index bcb04c6cb92c..024714d7f34e 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -4261,6 +4261,10 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 		}
 		new_cap = ceph_get_cap(mdsc, NULL);
 	} else {
+		if (tsession == ERR_PTR(-EAGAIN))
+			/* locks already dropped */
+			return;
+
 		WARN_ON(1);
 		tsession = NULL;
 		target = -1;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 86d592f06196..f091f0eaafc2 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1783,6 +1783,30 @@ static int __open_session(struct ceph_mds_client *mdsc,
 	return 0;
 }
 
+/* Is this rank still occupied by a session being torn down? */
+static bool __mds_rank_closing(struct ceph_mds_client *mdsc, int mds)
+{
+	return mds < mdsc->max_sessions && mdsc->sessions[mds] &&
+		mdsc->sessions[mds]->s_state == CEPH_MDS_SESSION_CLOSED;
+}
+
+/*
+ * Wait until the rank is no longer occupied by a CLOSED session.
+ *
+ * The caller must hold mdsc->mutex.  The mutex is dropped while sleeping and
+ * held again on return.  Another session may occupy the rank by then.  The
+ * wait also ends when shutdown starts, so the caller must check
+ * mdsc->stopping before proceeding.
+ */
+static void wait_for_mds_rank_not_closing(struct ceph_mds_client *mdsc,
+					  int mds)
+{
+	wait_event_cmd(mdsc->session_close_wq,
+		       !__mds_rank_closing(mdsc, mds) || mdsc->stopping,
+		       mutex_unlock(&mdsc->mutex),
+		       mutex_lock(&mdsc->mutex));
+}
+
 /*
  * open sessions for any export targets for the given mds
  *
@@ -1800,6 +1824,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
 		if (IS_ERR(session))
 			return session;
 	}
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED) {
+		/*
+		 * handle_session() is currently closing this session;
+		 * it stays registered until its caps are gone.  Do
+		 * not return it to our caller because we don't want
+		 * it to attach new caps to it.
+		 */
+		ceph_put_mds_session(session);
+		return ERR_PTR(-EAGAIN);
+	}
 	if (session->s_state == CEPH_MDS_SESSION_NEW ||
 	    session->s_state == CEPH_MDS_SESSION_CLOSING) {
 		ret = __open_session(mdsc, session);
@@ -1819,7 +1853,19 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
 	doutc(cl, "to mds%d\n", target);
 
 	mutex_lock(&mdsc->mutex);
-	session = __open_export_target_session(mdsc, target);
+	for (;;) {
+		session = __open_export_target_session(mdsc, target);
+		if (session != ERR_PTR(-EAGAIN) || mdsc->stopping)
+			break;
+
+		/*
+		 * Keep the exported cap on its old session until the
+		 * target rank is vacant.  Dropping it here can discard a
+		 * dirty auth cap; handle_session() wakes us after removing
+		 * the old target session's caps and unregistering it.
+		 */
+		wait_for_mds_rank_not_closing(mdsc, target);
+	}
 	mutex_unlock(&mdsc->mutex);
 
 	return session;
@@ -4553,8 +4599,20 @@ static void handle_session(struct ceph_mds_session *session,
 			ceph_metric_bind_session(mdsc, session);
 	}
 	if (op == CEPH_SESSION_CLOSE) {
+		/*
+		 * Pin the session for the rest of this function.  The
+		 * __unregister_session() call is deferred until after
+		 * remove_session_caps() below, or else other
+		 * processes may find caps still assigned to this
+		 * session while working with a new session object.
+		 */
 		ceph_get_mds_session(session);
-		__unregister_session(mdsc, session);
+
+		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+			pr_info_client(cl, "mds%d reconnect denied\n",
+				       session->s_mds);
+
+		session->s_state = CEPH_MDS_SESSION_CLOSED;
 	}
 	/* FIXME: this ttl calculation is generous */
 	session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
@@ -4612,12 +4670,24 @@ static void handle_session(struct ceph_mds_session *session,
 		break;
 
 	case CEPH_SESSION_CLOSE:
-		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
-			pr_info_client(cl, "mds%d reconnect denied\n",
-				       session->s_mds);
-		session->s_state = CEPH_MDS_SESSION_CLOSED;
 		cleanup_session_requests(mdsc, session);
 		remove_session_caps(session);
+
+		/*
+		 * Now that all caps are removed, it is safe to release
+		 * the MDS rank and allow other processes to create a
+		 * new session object.
+		 *
+		 * A concurrent ceph_mdsc_close_sessions() or
+		 * check_new_map() may have unregistered the session
+		 * already, so check __verify_registered_session()
+		 * first.
+		 */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, session))
+			__unregister_session(mdsc, session);
+		mutex_unlock(&mdsc->mutex);
+
 		wake = 2; /* for good measure */
 		wake_up_all(&mdsc->session_close_wq);
 		break;
@@ -5168,16 +5238,6 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	/* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
 	xa_destroy(&session->s_delegated_inos);
 	atomic_set(&session->s_num_deleg_inos, 0);
-	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
-	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
-		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
-			       mds,
-			       ceph_session_state_name(session->s_state));
-		mutex_unlock(&session->s_mutex);
-		ceph_msg_put(reply);
-		err = -ESTALE;
-		goto fail_return;
-	}
 
 	/* s_mutex -> mdsc->mutex matches cleanup_session_requests() order. */
 	mutex_lock(&mdsc->mutex);
@@ -5191,12 +5251,23 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 		err = -ENOENT;
 		goto fail_return;
 	}
-	mutex_unlock(&mdsc->mutex);
+	if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
+	    session->s_state == CEPH_MDS_SESSION_REJECTED) {
+		mutex_unlock(&mdsc->mutex);
+		pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
+			       mds,
+			       ceph_session_state_name(session->s_state));
+		mutex_unlock(&session->s_mutex);
+		ceph_msg_put(reply);
+		err = -ESTALE;
+		goto fail_return;
+	}
 
 	pr_info_client(cl, "mds%d reconnect start\n", mds);
 	old_state = session->s_state;
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
+	mutex_unlock(&mdsc->mutex);
 
 	doutc(cl, "session %p state %s\n", session,
 	      ceph_session_state_name(session->s_state));
@@ -5338,7 +5409,10 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
 	 * (check_new_map) can retry.  Without this, a transient build
 	 * failure strands the session in RECONNECTING indefinitely.
 	 */
-	session->s_state = old_state;
+	mutex_lock(&mdsc->mutex);
+	if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
+		session->s_state = old_state;
+	mutex_unlock(&mdsc->mutex);
 	mutex_unlock(&session->s_mutex);
 fail_nomsg:
 	ceph_pagelist_release(recon_state.pagelist);
@@ -5746,23 +5820,29 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
 			continue;
 		}
 		sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
-		__unregister_session(mdsc, sessions[i]);
-		__wake_requests(mdsc, &sessions[i]->s_waiting);
 		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&sessions[i]->s_mutex);
 		cleanup_session_requests(mdsc, sessions[i]);
 		remove_session_caps(sessions[i]);
+
+		/* Keep the rank occupied until all old-session caps are gone. */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, sessions[i]))
+			__unregister_session(mdsc, sessions[i]);
+		mutex_unlock(&mdsc->mutex);
+
 		mutex_unlock(&sessions[i]->s_mutex);
 
 		wake_up_all(&mdsc->session_close_wq);
 
-		ceph_put_mds_session(sessions[i]);
-
 		mutex_lock(&mdsc->mutex);
+		__wake_requests(mdsc, &sessions[i]->s_waiting);
 		kick_requests(mdsc, mds);
 		mutex_unlock(&mdsc->mutex);
 
+		ceph_put_mds_session(sessions[i]);
+
 		torn_down++;
 		pr_info_client(cl, "mds%d session reset complete\n", mds);
 	}
@@ -5864,6 +5944,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		s = __ceph_lookup_mds_session(mdsc, i);
 		if (!s)
 			continue;
+
+		if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
+			ceph_put_mds_session(s);
+			continue;
+		}
+
 		oldstate = ceph_mdsmap_get_state(oldmap, i);
 		newstate = ceph_mdsmap_get_state(newmap, i);
 
@@ -5876,18 +5962,24 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 
 		if (i >= newmap->possible_max_rank) {
 			/* force close session for stopped mds */
-			__unregister_session(mdsc, s);
-			__wake_requests(mdsc, &s->s_waiting);
+			s->s_state = CEPH_MDS_SESSION_CLOSED;
 			mutex_unlock(&mdsc->mutex);
 
 			mutex_lock(&s->s_mutex);
 			cleanup_session_requests(mdsc, s);
 			remove_session_caps(s);
+
+			mutex_lock(&mdsc->mutex);
+			if (!__verify_registered_session(mdsc, s))
+				__unregister_session(mdsc, s);
+			mutex_unlock(&mdsc->mutex);
 			mutex_unlock(&s->s_mutex);
 
-			ceph_put_mds_session(s);
+			wake_up_all(&mdsc->session_close_wq);
 
 			mutex_lock(&mdsc->mutex);
+			__wake_requests(mdsc, &s->s_waiting);
+			ceph_put_mds_session(s);
 			if (mdsc->mdsmap->m_epoch != map_epoch)
 				return;
 			kick_requests(mdsc, i);
@@ -5906,6 +5998,16 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 				ceph_put_mds_session(s);
 				return;
 			}
+			if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
+				/*
+				 * handle_session() set state=CLOSED
+				 * in the mutex gap above and is tearing it
+				 * down
+				 */
+				mutex_unlock(&s->s_mutex);
+				ceph_put_mds_session(s);
+				continue;
+			}
 			ceph_con_close(&s->s_con);
 			mutex_unlock(&s->s_mutex);
 			s->s_state = CEPH_MDS_SESSION_RESTARTING;
@@ -5964,6 +6066,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 	 * Only open and reconnect sessions that don't exist yet.
 	 */
 	for (i = 0; i < newmap->possible_max_rank; i++) {
+		if (mdsc->stopping)
+			return;
+
 		/*
 		 * In case the import MDS is crashed just after
 		 * the EImportStart journal is flushed, so when
@@ -5989,6 +6094,19 @@ static void check_new_map(struct ceph_mds_client *mdsc,
 		 * reconnection request in up:reconnect state.
 		 */
 		s = __ceph_lookup_mds_session(mdsc, i);
+		if (s && s->s_state == CEPH_MDS_SESSION_CLOSED) {
+			/*
+			 * Wait for handle_session() to remove the caps and
+			 * unregister this session, so the reconnect below
+			 * uses a fresh session on the now vacant rank
+			 */
+			ceph_put_mds_session(s);
+			wait_for_mds_rank_not_closing(mdsc, i);
+			if (mdsc->stopping ||
+			    mdsc->mdsmap->m_epoch != map_epoch)
+				return;
+			s = NULL;
+		}
 		if (likely(!s)) {
 			s = __open_export_target_session(mdsc, i);
 			if (IS_ERR(s)) {
@@ -7149,9 +7267,7 @@ static void mds_peer_reset(struct ceph_connection *con)
 	 * Snapshot session state with READ_ONCE, then revalidate under
 	 * mdsc->mutex before acting.  The subsequent mdsc->mutex
 	 * section rechecks s_state to catch concurrent transitions, so
-	 * the lockless snapshot here is safe.  s->s_mutex is taken
-	 * separately for cleanup after unregistration, which avoids
-	 * introducing a new s->s_mutex + mdsc->mutex nesting.
+	 * the lockless snapshot here is safe.
 	 */
 	session_state = READ_ONCE(s->s_state);
 
@@ -7176,18 +7292,24 @@ static void mds_peer_reset(struct ceph_connection *con)
 
 		ceph_get_mds_session(s);
 		s->s_state = CEPH_MDS_SESSION_CLOSED;
-		__unregister_session(mdsc, s);
-		__wake_requests(mdsc, &s->s_waiting);
 		mutex_unlock(&mdsc->mutex);
 
 		mutex_lock(&s->s_mutex);
 		cleanup_session_requests(mdsc, s);
 		remove_session_caps(s);
+
+		/* Keep the rank occupied until all old-session caps are gone. */
+		mutex_lock(&mdsc->mutex);
+		if (!__verify_registered_session(mdsc, s))
+			__unregister_session(mdsc, s);
+		mutex_unlock(&mdsc->mutex);
+
 		mutex_unlock(&s->s_mutex);
 
 		wake_up_all(&mdsc->session_close_wq);
 
 		mutex_lock(&mdsc->mutex);
+		__wake_requests(mdsc, &s->s_waiting);
 		kick_requests(mdsc, s->s_mds);
 		mutex_unlock(&mdsc->mutex);
 
-- 
2.47.3

