Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2190112F585
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788573137; cv=pass; b=Kmfm1vyFWTiJD6Y8GR2CU5V4vlad9PTMeO+tL0ko9026kVaP3qOoy4pkg+bahZUC2jCfdeB3Oy3aAc9Q/NkY//Gn8tPg4nwJSTxiS5nSfWZS+lesn2w/pa/Pn7kHq9Yw+fjq6PcV+hFA0uC0FeqNAqe0ols37WS8KgbI4FDIULU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788573137; c=relaxed/simple;
	bh=QXe/qLEGPNp6rYVF9CAbWyTgXu3VADgmCm+boxz7WzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCOLDjD+kyg37Ywx3WkzKUXkoxo9s4MvUI1B89UVz45rL/tUEIf1X6sYrkMpd3EGbRMRImSCCFG1yydqsGwhq3+21vDsdC2T+mB2aiWsOAgGEJ8doVB9y+IEpymmKQXXD1mFyA4lvNrA0/njxArXa1CLswfYzy07Dz3Ss+yDAeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=F1km+XtK; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="F1km+XtK"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c250f28f1cdso260271566b.0
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 18:52:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788573132; cv=none;
        d=google.com; s=arc-20260327;
        b=ROr1Kfx/zUwP9ko07h3TJJ0269lwYM/DAMH4oCLpPwJzyhCdxo6R6zvZhVGhanOT0M
         T0ygZNCljDG9Nd5Lo6q2VkohaU+OeP22+ZQXc8XKfQHzF1+1/LXegGu526yJHnxlpTlN
         MjLQwORf/fXvIZbChx8o4w7zBneCo0EUASmD+9KvZ7zVGwNOFj8nzYibpI4MdbWbgcd3
         j74nzKIngmBQJOzdWfccpoZCBvFkFmsfS5X+SVfCVYkEGkZj8FlESKohNLm4jEEXHfXj
         IZ7KcOIg8KZnMUBDxioVE5oDNxfh/6wpsmw39yu+4fnU2vaCm0zGqtz9GViOn129yM2b
         BVXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zizaHlGLemHEp2ko9U/krNPoMS0xneIqW4TRSLAG3is=;
        fh=GDK0pifEYj1d0uTlIQ8Nj2nn8Zb/y4GKKZDfES6dnEU=;
        b=sQaOz+W2W0tbAEuma8oc+MOW64dvZ0ITXf6/84dz8yq9Mim5f5nOuokUlvwxG8KXyx
         y7fIAfLQwbKnPwtJLfFolvinS7FuGLUfXPonVkloXfb9mR0M1KYJUzPsVuJK913zydDm
         Z+HWW8kJs4JT3S+QxDssLU39QBUwfG/1aOfL9K37tWoJ2FRRTA6hEYXJIZJPaF+rdO50
         QTOkUb+0Quq0CAyCmW3gjAsJA+hBItkZl0WEMHT1h7CHjCFAQPnptNJCjF8/QBjK+wlD
         0XNXfNFake1TAde4kMz5p7w/TEyi5ZVnAj+6DsRxp7DW2rDQIGzJK1/JPif4Z33nnx0Q
         TWjQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788573132; x=1789177932; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zizaHlGLemHEp2ko9U/krNPoMS0xneIqW4TRSLAG3is=;
        b=F1km+XtKUusQ9t4acZzrpuwQ1pGBJ8aKZMR5Z+1rMpn9ihiW8FUBlaOpJWYAlwbGb8
         chaDrHHHhAq2hLuf/mOScKVig2xmEuLLHmWiPwTpcRCclsklpfVismFVPd3pUWLehV3n
         Am4AqMpTUu/vEKtqo8+jPaLzPjIMrQLamWDEJtSSBfEUNLs4u9VqkZz2a1ZupeVK2zke
         LG2h3A+VnsnS6kpg3ds8d9hqhDvF4L3nfymSS5I3u0Si7kB6eFY+snNe1j6u0PeaestA
         ltdTAirLn7bzoYy8j3w2Rvm33hHaRv89YaWM2cVzFyz9P9giFSM6KF1Ar0jf1Oent5ZB
         R9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788573132; x=1789177932;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zizaHlGLemHEp2ko9U/krNPoMS0xneIqW4TRSLAG3is=;
        b=mEtX+waXFPfr527KwZqmXtCrDiXpsDS+f7k+UkAMijvBYxaSh2O9DtT2stRo4kLWC2
         0rB1EG1bGk78IfrO8V9DfHrjq9jd1poZST4QQevOgS/2OwAGx8Vq4JheNsfkR9s11vO1
         0rSIJvtsuzvqmHlFVAeeGSlab05KAFtZ5nkNb+OCYzbrqpz5IEQA32yGR4A838IJMYjt
         hFMsZ4ElmoKoY/6DRacDpN5C6G51jM93TI/XF0gOSJQNtxqzx2u892kUMDErXdJ4C8bL
         WV+xP18tUdodQ6B7+6EnE0jt6mw7sbsWOeKRDTI1LTg4jZhwySXmSeSL56sNK2cniJXo
         LwWw==
X-Forwarded-Encrypted: i=1; AKwUvBz5gcyiqVB2Xv8INjdtX4wtKg+Gxq8aVV9s4bgxSEfow7ayXubozBIuLQ3SmCIL8ZgTF9NhpFo=@vger.kernel.org
X-Gm-Message-State: AFuF++lJ/QYpOhmBjSipJuTPWh7UOAntjQSafOVSlMces55MhGKVmtGt
	D2Ly+9GchypRyvOIz5v31FkhxjA9ZOwX+6AdlFBfdmGN8zEwFZBIadqBaTBNy25W2rSi/7/XTwZ
	vdbI0uuGZkg69sjC0DSHKkOXb/CG2hTHdH93wyFFXPg==
X-Gm-Gg: AYBFou1ShTa7OzUTzSxiRb3IJT77ZlnkBNwxrY/dIkjLDsXk3uvaq6WMLIcsXAUBPg7
	XpH/vC+s3S9XIKfQOvfnyJgPT70dk/eMp9RMTz80nK0gxke2WuPARdg+ogTck//ihWxECRYkpCQ
	y8nxgQCSjWVsGthiNadG/5AXr8JDDVyDyPhK10iiUzZv/Crijafzo6kYAGzxx2j+NXdaS3jkSjY
	RJmgdksi9NFI50rfXb/rOWTDMNTgmmJiyu+IWKDptsTC5BEglMqZKjtJejzjAPsz7el675HxXjd
	8Q2iIDUBjePOHwb1b0hwNd+Wc9tIk4k3SvGXBkYcUe4LTg==
X-Received: by 2002:a17:907:7b9e:b0:c26:19de:9ace with SMTP id
 a640c23a62f3a-c2619dea6ffmr271428166b.38.1788573132401; Fri, 04 Sep 2026
 18:52:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904150304.49104-1-max.kellermann@ionos.com> <20260904150304.49104-2-max.kellermann@ionos.com>
In-Reply-To: <20260904150304.49104-2-max.kellermann@ionos.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Fri, 4 Sep 2026 18:52:00 -0700
X-Gm-Features: AcwNN1WDZu_1s8_xnV9u-kbrEsmmesZJZNKdYDJ26EL6R83yaSu4quJJiSUFKlE
Message-ID: <CAOJNxRJ-A8+PyVYB75ensD_i4r0MppFJ32_hXrD9HhzcQRCJ_Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ceph: fix use-after-free in check_new_map() after
 early session put
To: Max Kellermann <max.kellermann@ionos.com>
Cc: idryomov@gmail.com, amarkuze@redhat.com, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Good catch Max.

LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

On Fri, 4 Sept 2026 at 08:03, Max Kellermann <max.kellermann@ionos.com> wrote:
>
> check_new_map() drops mdsc->mutex while it locks a session, prepares a
> reconnect, or kicks flushing caps.  A concurrent teardown can call
> __unregister_session() in that window and drop the sessions[]
> reference. When check_new_map() reacquires mdsc->mutex, its temporary
> reference may therefore be the only reference keeping the local
> variable `s` alive.
>
> Commit ee611a750955 ("ceph: fix UAF in check_new_map() on session freed
> during unlock") addressed this by taking a temporary reference around
> each unlock window, but it drops that reference as soon as mdsc->mutex
> is reacquired, while `s` is still in use:
>
>   ceph_get_mds_session(s);
>   mutex_unlock(&mdsc->mutex);
>   mutex_lock(&s->s_mutex);
>   mutex_lock(&mdsc->mutex);
>   ceph_put_mds_session(s);    /* may drop the last reference */
>   ceph_con_close(&s->s_con);  /* use-after-free */
>   mutex_unlock(&s->s_mutex);  /* use-after-free */
>   s->s_state = CEPH_MDS_SESSION_RESTARTING;
>
> If the session was unregistered during the window, the sessions[]
> reference is already gone, so this ceph_put_mds_session() frees it.
>
> Additionally, the session could be freed while its s_mutex is locked,
> which trips the WARN_ON(mutex_is_locked(&s->s_mutex)) in
> ceph_put_mds_session() and then unlocks freed memory.
>
> Fix this by holding a single reference for the whole loop iteration:
> look the session up with __ceph_lookup_mds_session(), which returns it
> with a reference held, and release that reference on every exit from
> the loop body.  This subsumes the per-window get/put pairs, so remove
> them.
>
> Fixes: ee611a750955 ("ceph: fix UAF in check_new_map() on session freed during unlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> ---
> Note the stable maintainers: this is a fixup for ee611a750955, but the
> bug has existed before; see
> https://lore.kernel.org/ceph-devel/20260828174504.1247038-2-max.kellermann@ionos.com/
> for a patch that applies to pre-7.2 kernel versions.
> ---
>  fs/ceph/mds_client.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a091f77cedaf..d36a114747ae 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -5860,9 +5860,9 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>         }
>
>         for (i = 0; i < oldmap->possible_max_rank && i < mdsc->max_sessions; i++) {
> -               if (!mdsc->sessions[i])
> +               s = __ceph_lookup_mds_session(mdsc, i);
> +               if (!s)
>                         continue;
> -               s = mdsc->sessions[i];
>                 oldstate = ceph_mdsmap_get_state(oldmap, i);
>                 newstate = ceph_mdsmap_get_state(newmap, i);
>
> @@ -5875,7 +5875,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>
>                 if (i >= newmap->possible_max_rank) {
>                         /* force close session for stopped mds */
> -                       ceph_get_mds_session(s);
>                         __unregister_session(mdsc, s);
>                         __wake_requests(mdsc, &s->s_waiting);
>                         mutex_unlock(&mdsc->mutex);
> @@ -5896,15 +5895,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                            ceph_mdsmap_get_addr(newmap, i),
>                            sizeof(struct ceph_entity_addr))) {
>                         /* just close it */
> -                       ceph_get_mds_session(s);
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> -                       ceph_put_mds_session(s);
>                         ceph_con_close(&s->s_con);
>                         mutex_unlock(&s->s_mutex);
>                         s->s_state = CEPH_MDS_SESSION_RESTARTING;
>                 } else if (oldstate == newstate) {
> +                       ceph_put_mds_session(s);
>                         continue;  /* nothing new with this mds */
>                 }
>
> @@ -5915,7 +5913,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                     newstate >= CEPH_MDS_STATE_RECONNECT) {
>                         int rc;
>
> -                       ceph_get_mds_session(s);
>                         mutex_unlock(&mdsc->mutex);
>                         clear_bit(i, targets);
>                         rc = send_mds_reconnect(mdsc, s);
> @@ -5924,7 +5921,6 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                                "mds%d reconnect failed: %d\n",
>                                                i, rc);
>                         mutex_lock(&mdsc->mutex);
> -                       ceph_put_mds_session(s);
>                 }
>
>                 /*
> @@ -5937,15 +5933,14 @@ static void check_new_map(struct ceph_mds_client *mdsc,
>                                 pr_info_client(cl, "mds%d recovery completed\n",
>                                                s->s_mds);
>                         kick_requests(mdsc, i);
> -                       ceph_get_mds_session(s);
>                         mutex_unlock(&mdsc->mutex);
>                         mutex_lock(&s->s_mutex);
>                         mutex_lock(&mdsc->mutex);
> -                       ceph_put_mds_session(s);
>                         ceph_kick_flushing_caps(mdsc, s);
>                         mutex_unlock(&s->s_mutex);
>                         wake_up_session_caps(s, RECONNECT);
>                 }
> +               ceph_put_mds_session(s);
>         }
>
>         /*
> --
> 2.47.3
>
