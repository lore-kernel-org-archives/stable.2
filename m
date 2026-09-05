Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C41B142D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573398; cv=pass; b=oamSH28wcp9SmWydd23pmeAYo+68nGGnKfbgwhSwthmjdw3uHWD+Q9i+gY0+XIqERkZodlC+5bmBqsxSxql7rKESQ9/smUDH13+6WAssODSDbnWSIFSYiNf6trT6AGE82cjcM2EGIHzEtKbnAJhgA/EfAZpXdGgtf4KTp28ER/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573398; c=relaxed/simple;
	bh=wKWt3bAyC1SW1YDpXh0f0Dkut/2IKRfq6rSq0CdGr5U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egReKN/UJSD7akbzKeLddPt7IdE94nKWQwEUQ+qKiWSrLMi7reOIWbxgLZwvhD2O61aDjo0eZbNoiGaxAJCRKVivjdI0kgiMeScDhBdkt8jRIi6zpNDHy6kQTDSgtSK7LCkbkbGi1vG9Yj74T+BJOEyH5EG2Yyf9IGn9hkw/q4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=EURWS2Cv; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="EURWS2Cv"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c252c7270faso239208966b.3
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 18:56:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573395; cv=none;
        d=google.com; s=arc-20260327;
        b=WslrmwPcAGYOKk7LrCqCYthfE3mc/V3hOsPZW0kA5gZDOVAZhX1FJJAVF4dYnex7qS
         cjuQ//OBxDm1oJSWVniGo94rLnCJdIOxL8z60AFVwUMUd9AfwP2Oi4Jftnvgb5Nc72+P
         v3hjZN4V2DCK6OE/HfyPVRb5lobG8grrVEXxR+Gr0UPVsjx2ZorzII5gP6ajekQHKp5R
         9KgSWggkyWipwkl+2z+ERqaFgHO10O9E8mL2RBYhPX/rEa4uEHMUinyCUaSCA4uBvNny
         z57ylGxsHXii1yow81GA+wvsGAPQchxu8B5A2VLXTMrWHpIaEFZSO82jZjcKYhtzuaVm
         iOLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        fh=yPx5eQTDITMYdycpEDrH6BWgzr/TNaSild0e1FH2QGU=;
        b=bgW6888eZIoLePsIE/kspRh1shM21yyrD5JoQPyQWp07Sgz/LZU/tcFlIzZv4f1yN/
         U1jpbsK9bAc0rHTr2MhOdrHGfWgNWxV4oZScg7yQL1Fsb62Mfj40VPCOvfWT6YXuj604
         mk/elK7naMIWkXJ9eryWYLvb3BS0Bn6bXPO0n6X5StyZgC0g3naFwWw3+8c/2EIxlvNq
         AOMACWovhCY3/G1uvuFK4ylvmPbZ/+ZvbdjEqgxCEwyc4kzUPFl3df60r+Lee8K0iRvN
         2+cOFh5/D/J3e0DacfWm0x++MOZzin7Rhp795vnjahgYZE9tRmgAI3oRCF/s7I073rAf
         K4Lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788573395; x=1789178195; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        b=EURWS2CvzZWAGC3hj4onqafma5aF4p1Fjd19llgz6/F8kcUugXDoENhaxekqmfb7HH
         P8cRFiU67vbnv/xfanHUShj//+SCFRdx5gP+6rZHAP4aKK9Ze4tXpJvuvJHfMLA/aGOV
         rnt4jGe1apppanb5CMs+I1omgwSXFITz7pYWl9IsyMD4n0EXc0qeVr/XYrZ43e70iWLd
         sJUHYKOdyPukgT/2o8HinfdSrN8cuSs0guwbYiaIdH3rAlq4d+dJ9qyIcDcgN0GnAs5d
         +6Gqj8CW6ayVCnFVCnfo8DFF6FHof5zH54cmCg0daEI8pmxrewEjVuAYM43RE1T3D+DB
         2QPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573395; x=1789178195;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=64iQUgMJ50ECTx99FYmqUsZAWJ9dQnizuLl55Ewxi3o=;
        b=rQz3hSz+Pg4corI2wpr3dHXf8ADTrItaglJyFIJLVwrHtYbPNIzTAaKSc5O+oYKCcL
         n9rN8fjzXfUo/NpO+lxs7+qNVAhn+o9Q0mlLzMH2QvHnb93WnPmrkWGryUFnRrWmX4EW
         ctbob5dBcOtuJjeCFWEFt7L23of293h0yC/5IdGbAdOlRt+AfT+LbSD4iBEhIN2wSEte
         5HfAZVlzH78tNHfzXCA5SzAd7Ev41DDdCFjmzran399jYQlFl/m23QE5DyhpZntMaDq5
         vsZnksI8HTLaXIpWvIaq0zponCxCzQq1xIvSKHXVhKxBK4INarFJ3oVbyIoJkf2HUUJ2
         94Ww==
X-Forwarded-Encrypted: i=1; AKwUvBxRUZe2MlXu5ihNKHxuuuZ5PqtDFx2LdunM3QFJ+4fiaIPit8jSZrOaTr5N13QJjtd56jkFE00=@vger.kernel.org
X-Gm-Message-State: AFuF++nVjDqVjWDR/QB2UXPZjQChXjN9CS13hGa7jysEkYCOdl9mqg0D
	+DChII7HNc8QqFvPxXbEqTKrE9Has3ggrnbVCntZ+1EsWg4S8wdKiy2i4iCRsloF4JtOAPx4VB9
	FVTtJWGnt+FbvCN48cuXDJ8tpDLmI45jquOgwHGky8A==
X-Gm-Gg: AYBFou1UbKB7LfQg7w6wTBPZqqxAkSXDr/deAlosrqtCf88EDPTHuqFE135/vix7qRf
	WRCIHZ/9hTeF6bFx6A1A0x4S8tlQhABvMTIxYkc3AShwzg6+gzllMEOPhF/M2sFQCofgSMqWAW5
	2r/09akLaVL5YlaHkH3Xo2pbiAGsddm3kXFbb4My7ejYQpXf8nyrik/wvJcVMEkMavnSj6+dHOO
	zd7KITFYeSx691Z41Mjle7cAhunKY7de//oFkRfxfdTeP2CbnQVtcJqvGLdlr7ZNCC3o6mdfDAF
	Z78Bsg33zWuhfZvSLrQ90iC3HNzWjY4hvCQojvCiYfW2xg==
X-Received: by 2002:a17:907:d28:b0:c25:8eb7:f388 with SMTP id
 a640c23a62f3a-c260cc0bcdbmr656999166b.17.1788573394975; Fri, 04 Sep 2026
 18:56:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-4-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-4-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:56:23 -0700
X-Gm-Features: AcwNN1V2_9bl4T1sj_5dTilZTOBUX-ygseBv2Vtt7jqYUX-VmM0O4adaBDyDbOE
Message-ID: <CAOJNxRKxO3z3H0xXG0J0W9_hp2qwBfFEUeKFGFnk_MRQtu--tA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] ceph: don't unregister an MDS session before
 removing its caps
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Max,

The fix is correct.

Just one remaining teardown path still unregisters the session before
removing its caps: the fallback loop in ceph_mdsc_close_sessions():

mutex_lock(&mdsc->mutex);
for (i = 0; i < mdsc->max_sessions; i++) {
        if (mdsc->sessions[i]) {
                session = ceph_get_mds_session(mdsc->sessions[i]);
                __unregister_session(mdsc, session);
                mutex_unlock(&mdsc->mutex);
                mutex_lock(&session->s_mutex);
                remove_session_caps(session);
                mutex_unlock(&session->s_mutex);
                ...

The rest of this series consistently changes the ordering to keep the
rank occupied until remove_session_caps() has completed. Is the
ordering in ceph_mdsc_close_sessions() intentionally excluded?

This path is not limited to shutdown: it is also reached from the
corrupt snap-trace handling in ceph_handle_caps(), ceph_handle_reply()
and handle_snap(). In those cases mdsc->stopping may be false and the
mount need not be in CEPH_MOUNT_FENCE_IO, so a concurrent
__do_request() can register a new session for the rank in the window
between __unregister_session() and remove_session_caps().

That appears to be the same race this series is intended to eliminate.

Unless there is an invariant preventing a new session from being
created in this path, I think this teardown should use the same CLOSED
-> remove caps -> verify/unregister ordering, and wake
mdsc->session_close_wq after unregistering so that
wait_for_mds_rank_not_closing() waiters can proceed.

Thanks
- Xiubo

On Fri, 4 Sept 2026 at 08:03, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> handle_session() removed the session from mdsc->sessions[] at the very
> top of `CEPH_SESSION_CLOSE` handling, before taking `s_mutex`.
> Between session unregistration and remove_session_caps(), the MDS rank
> has no registered session while the old session still owns all caps it
> was granted.
>
> Any concurrent filesystem operation may walk into that and the next
> __do_request() call registers a new session for this rank.  Once it is
> open and the MDS issues caps, ceph_fill_inode() calls
> ceph_add_cap(), which looks caps up by rank, not
> by session identity, finding old caps linked to the old session.
>
> The list_move_tail() call then moves the cap object to the new
> session, which is already a bad thing to do.  Since it doesn't
> decrement `old_session->s_nr_caps`, this quickly triggers:
>
>   kernel BUG at fs/ceph/mds_client.c:1959!
>   Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>   [...]
>   Workqueue: ceph-msgr ceph_con_workfn
>   pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : remove_session_caps+0x2bc/0x2d8
>   lr : remove_session_caps+0x74/0x2d8
>   [...]
>   Call trace:
>    remove_session_caps+0x2bc/0x2d8 (P)
>    mds_dispatch+0xf48/0x1b60
>    ceph_con_process_message+0x74/0xa0
>    ceph_con_v1_try_read+0x3a0/0x1510
>    ceph_con_workfn+0x260/0x460
>    process_one_work+0x168/0x3b8
>    worker_thread+0x1bc/0x3a0
>    kthread+0x118/0x1e0
>    ret_from_fork+0x10/0x20
>
> That's BUG_ON(session->s_nr_caps > 0).
>
> I was able to reproduce this reliably by delaying the close and
> starting I/O during the delay.
>
> This patch keeps the session registered with
> `CEPH_MDS_SESSION_CLOSED`.  New requests will be put on the
> `s_waiting` list where they will be resumed on the new session.
>
> Since `CLOSE` now sets `CLOSED` before taking `s_mutex`, make
> send_mds_reconnect() validate and update the session state under
> `mdsc->mutex`. Preserve `CLOSED` if reconnect preparation later fails.
>
> Fixes: 2600d2dd5085 ("ceph: drop messages on unregistered mds sessions; cleanup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
>  fs/ceph/caps.c       |   4 +
>  fs/ceph/mds_client.c | 182 ++++++++++++++++++++++++++++++++++++-------
>  2 files changed, 156 insertions(+), 30 deletions(-)
>
> diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> index bcb04c6cb92c..024714d7f34e 100644
> --- a/fs/ceph/caps.c
> +++ b/fs/ceph/caps.c
> @@ -4261,6 +4261,10 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
>                 }
>                 new_cap = ceph_get_cap(mdsc, NULL);
>         } else {
> +               if (tsession == ERR_PTR(-EAGAIN))
> +                       /* locks already dropped */
> +                       return;
> +
>                 WARN_ON(1);
>                 tsession = NULL;
>                 target = -1;
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 86d592f06196..f091f0eaafc2 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1783,6 +1783,30 @@ static int __open_session(struct ceph_mds_client *mdsc,
>         return 0;
>  }
>
> +/* Is this rank still occupied by a session being torn down? */
> +static bool __mds_rank_closing(struct ceph_mds_client *mdsc, int mds)
> +{
> +       return mds < mdsc->max_sessions && mdsc->sessions[mds] &&
> +               mdsc->sessions[mds]->s_state == CEPH_MDS_SESSION_CLOSED;
> +}
> +
> +/*
> + * Wait until the rank is no longer occupied by a CLOSED session.
> + *
> + * The caller must hold mdsc->mutex.  The mutex is dropped while sleeping and
> + * held again on return.  Another session may occupy the rank by then.  The
> + * wait also ends when shutdown starts, so the caller must check
> + * mdsc->stopping before proceeding.
> + */
> +static void wait_for_mds_rank_not_closing(struct ceph_mds_client *mdsc,
> +                                         int mds)
> +{
> +       wait_event_cmd(mdsc->session_close_wq,
> +                      !__mds_rank_closing(mdsc, mds) || mdsc->stopping,
> +                      mutex_unlock(&mdsc->mutex),
> +                      mutex_lock(&mdsc->mutex));
> +}
> +
>  /*
>   * open sessions for any export targets for the given mds
>   *
> @@ -1800,6 +1824,16 @@ __open_export_target_session(struct ceph_mds_client *mdsc, int target)
>                 if (IS_ERR(session))
>                         return session;
>         }
> +       if (session->s_state == CEPH_MDS_SESSION_CLOSED) {
> +               /*
> +                * handle_session() is currently closing this session;
> +                * it stays registered until its caps are gone.  Do
> +                * not return it to our caller because we don't want
> +                * it to attach new caps to it.
> +                */
> +               ceph_put_mds_session(session);
> +               return ERR_PTR(-EAGAIN);
> +       }
>         if (session->s_state == CEPH_MDS_SESSION_NEW ||
>             session->s_state == CEPH_MDS_SESSION_CLOSING) {
>                 ret = __open_session(mdsc, session);
> @@ -1819,7 +1853,19 @@ ceph_mdsc_open_export_target_session(struct ceph_mds_client *mdsc, int target)
>         doutc(cl, "to mds%d\n", target);
>
>         mutex_lock(&mdsc->mutex);
> -       session = __open_export_target_session(mdsc, target);
> +       for (;;) {
> +               session = __open_export_target_session(mdsc, target);
> +               if (session != ERR_PTR(-EAGAIN) || mdsc->stopping)
> +                       break;
> +
> +               /*
> +                * Keep the exported cap on its old session until the
> +                * target rank is vacant.  Dropping it here can discard a
> +                * dirty auth cap; handle_session() wakes us after removing
> +                * the old target session's caps and unregistering it.
> +                */
> +               wait_for_mds_rank_not_closing(mdsc, target);
> +       }
>         mutex_unlock(&mdsc->mutex);
>
>         return session;
> @@ -4553,8 +4599,20 @@ static void handle_session(struct ceph_mds_session *session,
>                         ceph_metric_bind_session(mdsc, session);
>         }
>         if (op == CEPH_SESSION_CLOSE) {
> +               /*
> +                * Pin the session for the rest of this function.  The
> +                * __unregister_session() call is deferred until after
> +                * remove_session_caps() below, or else other
> +                * processes may find caps still assigned to this
> +                * session while working with a new session object.
> +                */
>                 ceph_get_mds_session(session);
> -               __unregister_session(mdsc, session);
> +
> +               if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> +                       pr_info_client(cl, "mds%d reconnect denied\n",
> +                                      session->s_mds);
> +
> +               session->s_state = CEPH_MDS_SESSION_CLOSED;
>         }
>         /* FIXME: this ttl calculation is generous */
>         session->s_ttl = jiffies + HZ*mdsc->mdsmap->m_session_autoclose;
> @@ -4612,12 +4670,24 @@ static void handle_session(struct ceph_mds_session *session,
>                 break;
>
>         case CEPH_SESSION_CLOSE:
> -               if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> -                       pr_info_client(cl, "mds%d reconnect denied\n",
> -                                      session->s_mds);
> -               session->s_state = CEPH_MDS_SESSION_CLOSED;
>                 cleanup_session_requests(mdsc, session);
>                 remove_session_caps(session);
> +
> +               /*
> +                * Now that all caps are removed, it is safe to release
> +                * the MDS rank and allow other processes to create a
> +                * new session object.
> +                *
> +                * A concurrent ceph_mdsc_close_sessions() or
> +                * check_new_map() may have unregistered the session
> +                * already, so check __verify_registered_session()
> +                * first.
> +                */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, session))
> +                       __unregister_session(mdsc, session);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 wake = 2; /* for good measure */
>                 wake_up_all(&mdsc->session_close_wq);
>                 break;
> @@ -5168,16 +5238,6 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>         /* Serialized by s_mutex against concurrent ceph_get_deleg_ino(). */
>         xa_destroy(&session->s_delegated_inos);
>         atomic_set(&session->s_num_deleg_inos, 0);
> -       if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
> -           session->s_state == CEPH_MDS_SESSION_REJECTED) {
> -               pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> -                              mds,
> -                              ceph_session_state_name(session->s_state));
> -               mutex_unlock(&session->s_mutex);
> -               ceph_msg_put(reply);
> -               err = -ESTALE;
> -               goto fail_return;
> -       }
>
>         /* s_mutex -> mdsc->mutex matches cleanup_session_requests() order. */
>         mutex_lock(&mdsc->mutex);
> @@ -5191,12 +5251,23 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>                 err = -ENOENT;
>                 goto fail_return;
>         }
> -       mutex_unlock(&mdsc->mutex);
> +       if (session->s_state == CEPH_MDS_SESSION_CLOSED ||
> +           session->s_state == CEPH_MDS_SESSION_REJECTED) {
> +               mutex_unlock(&mdsc->mutex);
> +               pr_info_client(cl, "mds%d skipping reconnect, session %s\n",
> +                              mds,
> +                              ceph_session_state_name(session->s_state));
> +               mutex_unlock(&session->s_mutex);
> +               ceph_msg_put(reply);
> +               err = -ESTALE;
> +               goto fail_return;
> +       }
>
>         pr_info_client(cl, "mds%d reconnect start\n", mds);
>         old_state = session->s_state;
>         session->s_state = CEPH_MDS_SESSION_RECONNECTING;
>         session->s_seq = 0;
> +       mutex_unlock(&mdsc->mutex);
>
>         doutc(cl, "session %p state %s\n", session,
>               ceph_session_state_name(session->s_state));
> @@ -5338,7 +5409,10 @@ static int send_mds_reconnect(struct ceph_mds_client *mdsc,
>          * (check_new_map) can retry.  Without this, a transient build
>          * failure strands the session in RECONNECTING indefinitely.
>          */
> -       session->s_state = old_state;
> +       mutex_lock(&mdsc->mutex);
> +       if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
> +               session->s_state = old_state;
> +       mutex_unlock(&mdsc->mutex);
>         mutex_unlock(&session->s_mutex);
>  fail_nomsg:
>         ceph_pagelist_release(recon_state.pagelist);
> @@ -5746,23 +5820,29 @@ static void ceph_mdsc_reset_workfn(struct work_struct *work)
>                         continue;
>                 }
>                 sessions[i]->s_state = CEPH_MDS_SESSION_CLOSED;
> -               __unregister_session(mdsc, sessions[i]);
> -               __wake_requests(mdsc, &sessions[i]->s_waiting);
>                 mutex_unlock(&mdsc->mutex);
>
>                 mutex_lock(&sessions[i]->s_mutex);
>                 cleanup_session_requests(mdsc, sessions[i]);
>                 remove_session_caps(sessions[i]);
> +
> +               /* Keep the rank occupied until all old-session caps are gone. */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, sessions[i]))
> +                       __unregister_session(mdsc, sessions[i]);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 mutex_unlock(&sessions[i]->s_mutex);
>
>                 wake_up_all(&mdsc->session_close_wq);
>
> -               ceph_put_mds_session(sessions[i]);
> -
>                 mutex_lock(&mdsc->mutex);
> +               __wake_requests(mdsc, &sessions[i]->s_waiting);
>                 kick_requests(mdsc, mds);
>                 mutex_unlock(&mdsc->mutex);
>
> +               ceph_put_mds_session(sessions[i]);
> +
>                 torn_down++;
>                 pr_info_client(cl, "mds%d session reset complete\n", mds);
>         }
> @@ -5864,6 +5944,12 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                 s = __ceph_lookup_mds_session(mdsc, i);
>                 if (!s)
>                         continue;
> +
> +               if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                       ceph_put_mds_session(s);
> +                       continue;
> +               }
> +
>                 oldstate = ceph_mdsmap_get_state(oldmap, i);
>                 newstate = ceph_mdsmap_get_state(newmap, i);
>
> @@ -5876,18 +5962,24 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>
>                 if (i >= newmap->possible_max_rank) {
>                         /* force close session for stopped mds */
> -                       __unregister_session(mdsc, s);
> -                       __wake_requests(mdsc, &s->s_waiting);
> +                       s->s_state = CEPH_MDS_SESSION_CLOSED;
>                         mutex_unlock(&mdsc->mutex);
>
>                         mutex_lock(&s->s_mutex);
>                         cleanup_session_requests(mdsc, s);
>                         remove_session_caps(s);
> +
> +                       mutex_lock(&mdsc->mutex);
> +                       if (!__verify_registered_session(mdsc, s))
> +                               __unregister_session(mdsc, s);
> +                       mutex_unlock(&mdsc->mutex);
>                         mutex_unlock(&s->s_mutex);
>
> -                       ceph_put_mds_session(s);
> +                       wake_up_all(&mdsc->session_close_wq);
>
>                         mutex_lock(&mdsc->mutex);
> +                       __wake_requests(mdsc, &s->s_waiting);
> +                       ceph_put_mds_session(s);
>                         if (mdsc->mdsmap->m_epoch != map_epoch)
>                                 return;
>                         kick_requests(mdsc, i);
> @@ -5906,6 +5998,16 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                 ceph_put_mds_session(s);
>                                 return;
>                         }
> +                       if (s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                               /*
> +                                * handle_session() set state=CLOSED
> +                                * in the mutex gap above and is tearing it
> +                                * down
> +                                */
> +                               mutex_unlock(&s->s_mutex);
> +                               ceph_put_mds_session(s);
> +                               continue;
> +                       }
>                         ceph_con_close(&s->s_con);
>                         mutex_unlock(&s->s_mutex);
>                         s->s_state = CEPH_MDS_SESSION_RESTARTING;
> @@ -5964,6 +6066,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>          * Only open and reconnect sessions that don't exist yet.
>          */
>         for (i = 0; i < newmap->possible_max_rank; i++) {
> +               if (mdsc->stopping)
> +                       return;
> +
>                 /*
>                  * In case the import MDS is crashed just after
>                  * the EImportStart journal is flushed, so when
> @@ -5989,6 +6094,19 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                  * reconnection request in up:reconnect state.
>                  */
>                 s = __ceph_lookup_mds_session(mdsc, i);
> +               if (s && s->s_state == CEPH_MDS_SESSION_CLOSED) {
> +                       /*
> +                        * Wait for handle_session() to remove the caps and
> +                        * unregister this session, so the reconnect below
> +                        * uses a fresh session on the now vacant rank
> +                        */
> +                       ceph_put_mds_session(s);
> +                       wait_for_mds_rank_not_closing(mdsc, i);
> +                       if (mdsc->stopping ||
> +                           mdsc->mdsmap->m_epoch != map_epoch)
> +                               return;
> +                       s = NULL;
> +               }
>                 if (likely(!s)) {
>                         s = __open_export_target_session(mdsc, i);
>                         if (IS_ERR(s)) {
> @@ -7149,9 +7267,7 @@ static void mds_peer_reset(struct ceph_connection *con)
>          * Snapshot session state with READ_ONCE, then revalidate under
>          * mdsc->mutex before acting.  The subsequent mdsc->mutex
>          * section rechecks s_state to catch concurrent transitions, so
> -        * the lockless snapshot here is safe.  s->s_mutex is taken
> -        * separately for cleanup after unregistration, which avoids
> -        * introducing a new s->s_mutex + mdsc->mutex nesting.
> +        * the lockless snapshot here is safe.
>          */
>         session_state = READ_ONCE(s->s_state);
>
> @@ -7176,18 +7292,24 @@ static void mds_peer_reset(struct ceph_connection *con)
>
>                 ceph_get_mds_session(s);
>                 s->s_state = CEPH_MDS_SESSION_CLOSED;
> -               __unregister_session(mdsc, s);
> -               __wake_requests(mdsc, &s->s_waiting);
>                 mutex_unlock(&mdsc->mutex);
>
>                 mutex_lock(&s->s_mutex);
>                 cleanup_session_requests(mdsc, s);
>                 remove_session_caps(s);
> +
> +               /* Keep the rank occupied until all old-session caps are gone. */
> +               mutex_lock(&mdsc->mutex);
> +               if (!__verify_registered_session(mdsc, s))
> +                       __unregister_session(mdsc, s);
> +               mutex_unlock(&mdsc->mutex);
> +
>                 mutex_unlock(&s->s_mutex);
>
>                 wake_up_all(&mdsc->session_close_wq);
>
>                 mutex_lock(&mdsc->mutex);
> +               __wake_requests(mdsc, &s->s_waiting);
>                 kick_requests(mdsc, s->s_mds);
>                 mutex_unlock(&mdsc->mutex);
>
> --
> 2.47.3
>
