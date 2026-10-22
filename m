Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792638185;
	b=WjTR5tLyxNNXjFrMRc6LFNPmMcLWtUS4WeP8BmuuMcq43wVL3Dm9DU61PQwuJMsFio64
	 WINxxMtiQvssFtmsbKmnN0CB051Pk7g+t47uFJjnoW6xcoPcoqV+KxfeF+nOxhycW31Yc
	 VEcYDmjEQXazlCshPyCKeP+v62aR12sj9i6QEbl2tsZ7c2zxk3a4qLibPjcJ2hjieR041
	 lTsLa8y1DwLhgSSx6EhO54g8q38IA+tIaeM2+THCm0DSZYQOsQWuMkjeWSyqTW8E5l676
	 molWxxB8lOaaSTb8cgTSFoOktGbVKaBnZ8HA+VxaYrVrdgj+xVxXbcx+II6nkD3sSag==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792638185;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eqWdgaTceNT3JTDi/LY16DDScdb29oYTmDXWPTVKTb8=;
	b=WCJ06jrL1ft1eVCp/anuGFB6gI1kv/ATcdkeuyXnqGFjJmBblaJN+bAbSMuaNoFM1/7m
	 m7An4xOXvnmPUmh0TVTiZjYA6lbk+OAX31sjmHFPjNQ7SHNdHrHtMeLIAloihowuvjkGA
	 fAQS5e5gKKXt2xV1fZxXHT1YWAAsrmnWIWp4VuUYHwZzv3DCIf31hO1cLuNLQ6VsUO+/Q
	 We4qqSM+F3AcyKW3lJ4Qkw+4AH6GPUGdbJGERJ04odQi7+Q4fcfYEGruPAw1L1lWbjKTZ
	 8kbtWKvzMLau018XflQwS9O/caHQdtCX6DeiWmVVMu0wSSSq8nX8iF7maVT5+X5ZQnA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=clyso.com;
	spf=pass smtp.mailfrom=clyso.com;
	dkim=pass header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=H7GaxLru;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94548606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 03:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94548606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=clyso.com header.i=@clyso.com header.a=rsa-sha256 header.s=google header.b=H7GaxLru
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2acc1e170cso195366466b.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 20:03:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792638181; cv=none;
        d=google.com; s=arc-20260327;
        b=oJLwQtZ3Cufnd/jTtAIPps53w2IloGi+ENaRkfmeqUjCYW3wwPphs3xWnLjoWwMvmV
         4qPbOWLiEN7elfW8pshV5ZDxuVN5sT81Li06yyYXh6wnk4RGSGJ74BHAUzX5QXsriiT1
         845X6P7XmfYwvUZEtGPJV3gxgCs2t6APcYymQeO6BVBRaU9RL6DRYG2IDUHDT3SzXA0B
         VE0Cbi7kj96m29D3BVLfl2ZX0/eglJrPmYG4Eo0wMkj2xQE1DrJPFuVnzDErsCOT/e21
         g1rVBYvAqP5apz6ICzaZKmd8ghZJPUyDdiA1vLgzxJC9LpPEEIvSZfgDdyyOww/2ueTE
         HDvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=eqWdgaTceNT3JTDi/LY16DDScdb29oYTmDXWPTVKTb8=;
        fh=H4AZ5tZYNTjwCabj595gu2zl/dIIgwBNzNAfOn12oN8=;
        b=lYz6ySUeZi5STmgAjbtngu5e8XVCcoxRGXsCqMVzxq5lnSDtVc3tAAPrYP/C/vNFmC
         zFwzvSBTcMiC2+L684I5ae0JfQSJeq9ewGd+uRnGMyNXVJ3B/4VsciEIYrgDC8pnSQRA
         JJg5o33e0KQQB0M9tABDZ7aQOCfAouUxt5ve+7olvg8iasiK33rvmNAoS7gaJsJnrnpt
         zIh8OC9bGFXuWtmb6FFMCpVlF8+y/h6gQ+FbiaTrRJGyynwWjl0ahTzV97r0EUcTBXjC
         4hmSlnv2d608y9LsINiXufAQRW4FPuKlvaV/cruVYe6JkKmMmtv33+T83QQU4l5HLOzM
         FdWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1792638181; x=1793242981; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eqWdgaTceNT3JTDi/LY16DDScdb29oYTmDXWPTVKTb8=;
        b=H7GaxLruOseJUgK9SLX7ZGvMVOeS6F8IXC+Noiy5jhFCOauHyBMhcBWW/Kjc2KHArH
         Oam2yxuVkPNC7dMAMf8ovHzaRVM3cSsAyEOFhe5M5yybGLL6S54FJxdM/C4AXWy2bo71
         pNNC3IyumbfHGZIYGJl4Z5eHGFT6jM8fm/BqYsCLX/o8qUNoh4MbtbWsFforxdQkIK7H
         e6ehoVmjBWGVrmgVgbxZWHMoaMDtzfXmMBerCw4tchyJtIs/sq908R571BxBfbBa4tFk
         VYYUnlCVwRGA/fS8JEI9qIPtmaghcGgAOXd7mUaMPOr5rqtKkbRpkfUTGucborA/wlBU
         sc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792638181; x=1793242981;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eqWdgaTceNT3JTDi/LY16DDScdb29oYTmDXWPTVKTb8=;
        b=dbsyUaIhMuszaLC6tQEIiQYbt67FPTO1F+IbooaU2IytTK56oco37Kq4mexnGEOtTq
         FzbwVZLMFAvB5RSWkmxh/sWSQ7iZFEV5rks/ALFmppFeyXGEHFrMkftYmZCt7/TvF1Vy
         p8kq7Yndqs1dPIstPQjTxW7SKO2jSw8K1E7+rkY6SWfQuUMqEN67/X6ggmGsycyoX1OF
         97gtMcrcWtHzSGccBpr2rU2yHlxiyumn5A2Y6z3HyVO5mOdIlaImoo4I+GLvCFUoUoCP
         t6M9HRqF5DeEVouQ68A4rL8b8P7wjDWAmY2k050e6+OmKSjAkjqHu8oCQ2arksvnEuhv
         n/uw==
X-Forwarded-Encrypted: i=1; AKwUvBwdK1TyBoI7NvaGt80tOX37TVuaiRFsK9MrDwTG3gP/PZ83PeAZj8J0DlA6gev0BQJXr6uWXVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlWSQUeeuB2Mwdv6tkPS1999ggw584v9PTkZ08eRJ0PbqwID6O
	tkHHilWguU3aTPOYUE/bNNvBMIlP1zU1tAalHPkpuVycbn1lyjqB70iaPh1Hg+sIxQWYDgo3DlV
	FMyr/sXfucEaxIJLRntKd5LOx4emhf0eDIIlC8t6qhg==
X-Gm-Gg: AYBFou3gF/zF0ydkD1DEMadYz5E9fhlDROvtITewCqki/lmUof//hXAYODv9gOfpUbA
	I3hitTcPAYsHCBz1OKr7Z0s57IW/jKIldgQAAT3kDa7rPPFmBueNOnO2qP4qYrAnnIQ7IACiIh6
	wv78R6okYTXeJko1nLbUScSCTlPRH3lmtj41hppCi7R1Ah5kt12TA3jS9KjIZXvJqnSJmmr9fkX
	LTbPqnuQbOLZqmK67MOeVbZWwITMmWnmxlFG3h0U3HU5VrM4mrXe+PilwXmlJQzDgs1kQQjZ0Po
	JQhmK8AdHDtWd+6WQcQpsVZl/T+HKSK8ToN3sW+bdb8d1ig+HTBeEbRw7gkuZlfRlAl3/avEVmn
	1h3SkRbMxui9iGqEq1BE2mQdlimWPW0IYQEl4VQk=
X-Received: by 2002:a17:907:c317:b0:c41:6de7:7dee with SMTP id
 a640c23a62f3a-c46791a97f8mr354514966b.7.1792638181499; Wed, 21 Oct 2026
 20:03:01 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021170613.1144381-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20261021170613.1144381-1-sunyuechi@iscas.ac.cn>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Thu, 22 Oct 2026 05:02:50 +0200
X-Gm-Features: AclHuK_rJLQFSxHqbVLM_IjCoLrCiui5eY0DXoL0WX29TvTRda1lVx23utsbBJg
Message-ID: <CAOJNxR+bfs_g7t4qkZyfcWJAd2W51LH0skzzOpSztSZqCjuqeg@mail.gmail.com>
Subject: Re: [PATCH] ceph: reconnect on peer reset even if the mdsmap says the
 MDS is active
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: idryomov@gmail.com, amarkuze@redhat.com, slava@dubeyko.com, 
	ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, Oct 21, 2026 at 19:06, Sun Yuechi wrote:
> Since commit 39fe30315893 ("ceph: harden send_mds_reconnect and handle
> active-MDS peer reset"), mds_peer_reset() tears the session down instead
> of reconnecting when our mdsmap shows the rank past RECONNECT.
>
> That map can be stale.  An MDS killed and restarted on the same address
> resets our connection before the monitors report the rank as failed, so
> the session is torn down while the map still says active.

Agreed.  The local teardown trusts a map that the peer reset itself
says is out of date.  Once the session has been unregistered,
check_new_map() has nothing to reconnect, and the new rank 0 evicts us.

> Send the reconnect and let the MDS decide, as before that commit.  A
> daemon restarted on the old address has a new nonce, so the reconnect
> does not get through, and check_new_map() reconnects once a map carries
> the rank's new address.

I checked this path.  The session stays in RECONNECTING, but
check_new_map() compares the whole ceph_entity_addr, nonce included.
So both a standby taking over and the same daemon coming back on the
old ip:port end up in ceph_con_close(), RESTARTING and a fresh
send_mds_reconnect().  Nothing is left stuck in RECONNECTING.

> An MDS that really is active replies with
> CLOSE, and handle_session() unregisters the session so that new
> requests open a fresh one, which is what that commit intended.

Yes.  Server::handle_client_reconnect() denies a reconnect outside the
reconnect window, or for a closed session, by sending
CEPH_SESSION_CLOSE ("denied reconnect attempt").  A sessionless
reconnect gets CEPH_SESSION_REJECT.  So the "reject or ignore" premise
in 39fe30315893 does not hold for the ignore part.  The client side then
unregisters the session, removes its caps and kicks the waiting
requests.

A few nits, none of them blocking:

1. It would help to say in the changelog that this is a partial revert:
   only the mds_peer_reset() half of 39fe30315893 goes away, and the
   send_mds_reconnect() hardening stays.  Please also mention that the
   active MDS denies the reconnect with CLOSE.

2. The reproducer needs the client to send no MDS request between the
   peer reset and the new map.  If a request is issued in that window,
   it registers a new session.  check_new_map() then reconnects that
   session when the address changes, so the bug is hidden.  Even then,
   39fe30315893 has already dropped all of the client's caps with
   remove_session_caps(), while a real reconnect keeps them.  That seems
   worth a sentence too.

> -       if (rc)
> +       rc = send_mds_reconnect(mdsc, s);
> +       if (rc && rc != -ESTALE && rc != -ENOENT)

3. check_new_map() still warns on every non-zero return of
   send_mds_reconnect().  Its -ESTALE/-ENOENT cases are logged by
   send_mds_reconnect() itself, just like here.  Not for this patch,
   but the two callers could be made consistent in a follow-up.

> +        * Send the reconnect and let the MDS decide; one that is past
> +        * RECONNECT replies with CLOSE and handle_session() closes the

4. Nit: "replies with CLOSE (or REJECT if it has no session for us)".

Tested on x86_64 with a 7.3.0-rc1 based kernel (KASAN, lockdep,
kmemleak) against a vstart cluster from Ceph main: 1 MON, 3 OSDs, and
two MDSes with allow_standby_replay set (one active plus one
standby-replay).  Only ceph.ko was swapped between the runs; libceph.ko
was identical.

Each run did the following.  A writer keeps a file open and stops
issuing requests during the window.  iptables drops the kernel client's
established monitor connection.  The active MDS gets SIGKILL and is
restarted on the same address with --public_addrv.  Once the client logs
"closed our session", the block is lifted.  After the takeover the run
checks ls, a new write, a read and further writes on the held fd.

  stale map, MDS restarted on the old address:
    without the patch: 4 of 4 runs evicted ("session blocklisted",
                       "rejected session"), EACCES afterwards
    with the patch:    3 of 3 runs "reconnect start" ->
                       "reconnect success" -> "recovery completed",
                       no errors from the writer

  "client evict" by the active MDS, mds_session_blocklist_on_evict=false:
    without the patch: 2 of 2 recover with a new session
    with the patch:    2 of 2 "reconnect denied", then a new session,
                       I/O fine

No KASAN, lockdep or kmemleak reports.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>
Tested-by: Xiubo Li <xiubo.li@clyso.com>

Thanks,
- Xiubo

On Wed, 21 Oct 2026 at 19:06, Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:
>
> Since commit 39fe30315893 ("ceph: harden send_mds_reconnect and handle
> active-MDS peer reset"), mds_peer_reset() tears the session down instead
> of reconnecting when our mdsmap shows the rank past RECONNECT.
>
> That map can be stale.  An MDS killed and restarted on the same address
> resets our connection before the monitors report the rank as failed, so
> the session is torn down while the map still says active.  When a
> standby then takes over the rank in up:reconnect, check_new_map() has
> no session left to reconnect, the new MDS evicts and blocklists us
> after mds_reconnect_timeout, and the mount returns EACCES until it is
> unmounted:
>
>   libceph: mds0 (2)10.89.20.12:6800 session reset
>   ceph: [...]: mds0 closed our session
>   (mds) evicting unresponsive client ceph-c1 (14900), after waiting
>         49.7175 seconds during MDS startup
>
> Send the reconnect and let the MDS decide, as before that commit.  A
> daemon restarted on the old address has a new nonce, so the reconnect
> does not get through, and check_new_map() reconnects once a map carries
> the rank's new address.  An MDS that really is active replies with
> CLOSE, and handle_session() unregisters the session so that new
> requests open a fresh one, which is what that commit intended.
>
> Skip the warning for -ESTALE and -ENOENT: send_mds_reconnect() already
> logs those, and the removed code was silent for closed and rejected
> sessions.
>
> Tested on riscv64 (7.2.6 kernel, Ceph 21, one active MDS with a
> standby-replay): SIGKILL the active MDS while dropping the client's
> monitor traffic until it logs "closed our session".  Evicted in 4 of 4
> runs without the patch, "reconnect success" in 3 of 3 with it.  Eviction
> by an active MDS without blocklist still recovers with a new session,
> 2 of 2 runs.
>
> Fixes: 39fe30315893 ("ceph: harden send_mds_reconnect and handle active-MDS peer reset")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> ---
>  fs/ceph/mds_client.c | 84 +++++---------------------------------------
>  1 file changed, 9 insertions(+), 75 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index d4ef8a355a48..d23250af0750 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -7236,7 +7236,7 @@ static void mds_peer_reset(struct ceph_connection *con)
>  {
>         struct ceph_mds_session *s = con->private;
>         struct ceph_mds_client *mdsc = s->s_mdsc;
> -       int session_state;
> +       int rc;
>
>         pr_warn_client(mdsc->fsc->client, "mds%d closed our session\n",
>                        s->s_mds);
> @@ -7246,82 +7246,16 @@ static void mds_peer_reset(struct ceph_connection *con)
>                 return;
>
>         /*
> -        * Only reconnect if MDS is in its RECONNECT phase.  An MDS past
> -        * RECONNECT (REJOIN, CLIENTREPLAY, ACTIVE) will reject reconnect
> -        * attempts, so those states fall through to session teardown below.
> +        * Our mdsmap may be stale: an MDS restarted on the same address
> +        * resets the connection before we learn that the rank failed.
> +        * Send the reconnect and let the MDS decide; one that is past
> +        * RECONNECT replies with CLOSE and handle_session() closes the
> +        * session so that new requests open a fresh one.
>          */
> -       if (ceph_mdsmap_get_state(mdsc->mdsmap, s->s_mds) == CEPH_MDS_STATE_RECONNECT) {
> -               int rc = send_mds_reconnect(mdsc, s);
> -
> -               if (rc)
> -                       pr_warn_client(mdsc->fsc->client,
> -                                      "mds%d reconnect failed: %d\n",
> -                                      s->s_mds, rc);
> -               return;
> -       }
> -
> -       /*
> -        * MDS is active (past RECONNECT).  It will not accept a
> -        * CLIENT_RECONNECT from us, so tear the session down locally
> -        * and let new requests re-open a fresh session.
> -        *
> -        * Snapshot session state with READ_ONCE, then revalidate under
> -        * mdsc->mutex before acting.  The subsequent mdsc->mutex
> -        * section rechecks s_state to catch concurrent transitions, so
> -        * the lockless snapshot here is safe.  s->s_mutex is taken
> -        * separately for cleanup after unregistration, which avoids
> -        * introducing a new s->s_mutex + mdsc->mutex nesting.
> -        */
> -       session_state = READ_ONCE(s->s_state);
> -
> -       switch (session_state) {
> -       case CEPH_MDS_SESSION_RESTARTING:
> -       case CEPH_MDS_SESSION_RECONNECTING:
> -       case CEPH_MDS_SESSION_CLOSING:
> -       case CEPH_MDS_SESSION_OPEN:
> -       case CEPH_MDS_SESSION_HUNG:
> -       case CEPH_MDS_SESSION_OPENING:
> -               mutex_lock(&mdsc->mutex);
> -               if (s->s_mds >= mdsc->max_sessions ||
> -                   mdsc->sessions[s->s_mds] != s ||
> -                   s->s_state != session_state) {
> -                       pr_info_client(mdsc->fsc->client,
> -                                      "mds%d state changed to %s during peer reset\n",
> -                                      s->s_mds,
> -                                      ceph_session_state_name(s->s_state));
> -                       mutex_unlock(&mdsc->mutex);
> -                       return;
> -               }
> -
> -               ceph_get_mds_session(s);
> -               s->s_state = CEPH_MDS_SESSION_CLOSED;
> -               __unregister_session(mdsc, s);
> -               __wake_requests(mdsc, &s->s_waiting);
> -               mutex_unlock(&mdsc->mutex);
> -
> -               mutex_lock(&s->s_mutex);
> -               cleanup_session_requests(mdsc, s);
> -               remove_session_caps(s);
> -               mutex_unlock(&s->s_mutex);
> -
> -               wake_up_all(&mdsc->session_close_wq);
> -
> -               mutex_lock(&mdsc->mutex);
> -               kick_requests(mdsc, s->s_mds);
> -               mutex_unlock(&mdsc->mutex);
> -
> -               ceph_put_mds_session(s);
> -               break;
> -       case CEPH_MDS_SESSION_CLOSED:
> -       case CEPH_MDS_SESSION_REJECTED:
> -               break;
> -       default:
> +       rc = send_mds_reconnect(mdsc, s);
> +       if (rc && rc != -ESTALE && rc != -ENOENT)
>                 pr_warn_client(mdsc->fsc->client,
> -                              "mds%d peer reset in unexpected state %s\n",
> -                              s->s_mds,
> -                              ceph_session_state_name(session_state));
> -               break;
> -       }
> +                              "mds%d reconnect failed: %d\n", s->s_mds, rc);
>  }
>
>  static void mds_dispatch(struct ceph_connection *con, struct ceph_msg *msg)
> --
> 2.56.0
>
