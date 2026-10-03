Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D2F451982
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 19:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056974; cv=pass; b=p5QMftaa1GPLLVZj9h1m4ulAaN0Vf6RhPnJs530660H4O0spfCrRGkstFtHrm2cEgc3RqUVTAt742qKfUXQFaavsoo6kdPdssj3Gk/jXdKJrDj+EVcLxoQPfacfS2td0wWkEhQLCMrFGBmO95wZyq5KAFFnODcU5uDihmeED4R4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056974; c=relaxed/simple;
	bh=c2qoWHsQlTh+5S32DI962bDO3NnnJ1VQFtDuQoujjfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H22pQ0uNZ2CyoGhHU4npsspxvIawbLBiY60/ImBvIS1zH+hPoBR5XheMXbAym7zuNTYvsMC4/6n/+ZlFW+nhgAqq2R87/J6MezOIajQeChmK0zN3OHSfQhAQPwbaybL0Z4kuHzZZG1+cMvH0mUzOFfxL1L0x2Dd7OnMO1X3182Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAS1QFOA; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAS1QFOA"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a9a26ce219so93788a12.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 12:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791056970; cv=none;
        d=google.com; s=arc-20260327;
        b=VS+H6+NGZ25+ScsNXqBStXpnTPTCBgo4dqGjYyUFnSNy/NUgItMTResCIM47iYFvb3
         5/TITl+DFm86YNneXKfBWHJ7qNWb1iJPeikGI14MtcKWyox+My2zvfH1IT527PsJZgHN
         Mw7oZzexkdo4Sy+zMVechUKiWSsb1AaaeVuAMWlYjDpTuj3CaAKz7skxMRBsWpC3O+9n
         kOH0SBWU80ieKGJkjusAFwu/T1pQtLq/YtZOmgFKean3719yPGJccOZt/37nqkvxi9Fi
         kxtx9DNiQKh0YDBFhKKqIvhFNAELDhMNrYh51LUyPGQzlJZEZV3zwdu33PDGUnwcPHK9
         tASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        fh=JX5X9H1UbGWqUfujN70I1K+8xF5Y6Tc6guAeKkLcOYs=;
        b=YHgN/e7wtOOw+mdF4LsSIt0+6JKJuUge27grCOZJGQ0O7SK3FNNELu9AVl+mCSb9CH
         DDWEfwfb4DaDCdR6261EWmZREi4mU2s+03NbUzjI55zJhsjdUHYAxe+9CuYGnOnMlT4Z
         ZS+jVSXhey1VXOBNCDb4YrliDUcGn4QpPL0p3m6g4N3GUb1SkMwuBmz8a7Wr7WJwp1QZ
         GCbpoT30cYPdM+J1OBlCWCGkbNfUPBgbr8yJAqoOLminjERhHX1tssEdIYry/7U8KJXo
         UWAarvjrTAdsTP1KRfL/MSYaYp0hG6+736n0IAeSm99MS1fQdb6ku2D0N4ToqGyNzowy
         lPcg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056970; x=1791661770; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        b=EAS1QFOA2+YyhspV4Nle7v47vYDOHFe7rgDdnmjugIevLnMwQBP5V5JN+mTRrH+Qve
         J62fquYVfK6cNWEK98FeEF+7kbfwGgAd5k9kIcnSIIXwgS4qXk6gkvxrjqTFhLzuKke0
         /tXNRpX50RchKwOARfTYnYUctG5LUPQzzPkKsT0FiERWiAbcmBeO6u8ovs9LXX0kfj2u
         z+lYoltLngXvi2dqs8IDsQLoXhXt5hBG2U0mJa8ecan1pJOyhRAFXl4idE5uLSgPDI+R
         e/hLBkFEymQbUjXY/4svpc9H0vDhXWK6JwyLfmOTHwDz3hNVPJ7P7FmQ7XBQYqe/sNAV
         fXPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056970; x=1791661770;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bL60aTdrtyYKQsnQIlO0Kdzapjm5bDbHcbO8RKh/OCw=;
        b=bOLhR3Rj3vVSgPn7qvucJ7jOgv06hHKFAr/sMdQyQeeZTqWnBcZN49PVsTNKmTVkPM
         2uPa9o3LUnEhbmArv+8WUmVNCwTSiAm2ID63NiqRjAqBEKkTvjOkt985s04tZ7HqQKKA
         6alzPSOvwbKEH+k8faGwphxydak341vuKhRy5lghgS4qZySrmD2QQKzyy2aF7m33pztp
         Q73N8GHhWMx/8fXdnbf6msy8ssx0/hUzPomG1xtqICrpOyDWQ6FLnBeetXCIeh4rZqCM
         hES3eR+wwQH2TG+Dcy1LGwPRXY7wdEoyBzntsDvRX/9D9yjjgPqiIjXk2nXHqrbMgm4E
         zxeQ==
X-Forwarded-Encrypted: i=1; AKwUvBzQ20dgPiihjMPHkJBJ1z4gRHHmVSaYMgzN9pdpuyzBfrZq4nyPLKA72OIwJUy/ozMhPGKkQkc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKkOtuPAtzEM0I9nPRGPY3SCz/rqSZZCZO4qOJWzR7zZzVTaD+g
	KUpN6VLAiih154sWpRc6pFj3qxOogo6o5bzxsqQHcFpFA+/NLzANAfVtqaUSSCFE0li2rdlfq0P
	yIXoRCfmkD8979N3aZRcOeBs2kRGe4Qk=
X-Gm-Gg: AYBFou2gV5rqQkPtLIdnzXLBWrZtRhMRv79PbwnKbDQJLPT6Z3mMiVEL4tlH+hmo3RC
	xkobpKUBuzs/teF45YO2L/Nl8cAitrRnwIsP3tBNN7a5nM8zI9GvBUSqwJpZ2O8XbrxVXyRkB9z
	Y7KUE4oeakAwmSfwWELULpzizvQc087BZ+RGtQ82WGELYMqXNOC8+lPTdMbsf5cjGGBWN7Wxdi7
	/6qf4vyKLPnkQQLD5kTnrfZrNPUx6owShjGDmvl8Jb3xv6c3cvBLR2fKyACR9HVSA8zJwN0CCwn
	66ywdLQ2uYYjPBWu8zjqulse5lNv6UDiDl1C7zxYooW7mMnCiSRyFZLUIeibDwF5mnnuUwDne7W
	ypUdgyZA1FPM=
X-Received: by 2002:a05:6402:1ed0:b0:6aa:a040:cc0b with SMTP id
 4fb4d7f45d1cf-6af9e26f8demr6054679a12.1.1791056969478; Sat, 03 Oct 2026
 12:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927074600.3694802-1-nicoyip.dev@gmail.com> <179072931609.434549.973981787075835588@kernel.org>
In-Reply-To: <179072931609.434549.973981787075835588@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 4 Oct 2026 03:49:18 +0800
X-Gm-Features: AclHuK_Y0i4trNbA9V55a6x6i4E4Q33ZR1G4G_SD7hO5cjoUUquUDzMxcOA1ENU
Message-ID: <CAAo+4rXocEj=0WZAtTD1em+c6SirU+4Bb-GEJ8P1piVnhxFCuw@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Serialize CLC preparation with link teardown
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kgraul@linux.ibm.com, 
	ubraun@linux.ibm.com, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:48=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 2 (2) =C2=B7 Low: 1 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] When smc_clc_send_confirm_accept() (net/smc/smc_clc.c) finds
>   that conn->lnk is unusable or being cleared under llc_conf_mutex, it=E2=
=80=A6
> - [Medium] smc_clc_send_confirm() (net/smc/smc_clc.c) now does
>   `smc->sk.sk_err =3D smc->clcsock->sk->sk_err ?: -len; reason_code =3D=
=E2=80=A6
> - [Low] The `sk_err ?: -len` changes in smc_clc_send_confirm() and
>   smc_clc_send_accept() (net/smc/smc_clc.c) do more than keep the new=E2=
=80=A6
>
> Pre-existing issues:
> - [Medium] This problem wasn't introduced by this patch, but it concerns
>   the locking contract the fix relies on.
> - [Medium] This problem wasn't introduced by this patch, but the patch
>   makes the CLC send helpers inconsistent.
> - [Low] This problem wasn't introduced by this patch (it dates from
>   2020).
>
> --
>
> net/smc: Serialize CLC preparation with link teardown
>
> This commit makes smc_clc_send_confirm_accept() hold llc_conf_mutex for
> reading while it prepares the SMC-R CONFIRM/ACCEPT message. If the link
> is unusable or being cleared, it returns -ENOLINK. It also changes
> smc_clc_send_confirm() and smc_clc_send_accept() to use the
> kernel_sendmsg() return value when the TCP socket has no sk_err set.
>
> > diff --git a/net/smc/smc_clc.c b/net/smc/smc_clc.c
> > index 014d527d5462d..6b9e64a5b9d0a 100644
> > --- a/net/smc/smc_clc.c
> > +++ b/net/smc/smc_clc.c
> > @@ -1169,14 +1169,21 @@ static int smc_clc_send_confirm_accept(struct s=
mc_sock *smc,
> >       clc->hdr.version =3D version;     /* SMC version */
> >       if (first_contact)
> >               clc->hdr.typev2 |=3D SMC_FIRST_CONTACT_MASK;
> > -     if (conn->lgr->is_smcd)
> > +     if (conn->lgr->is_smcd) {
> >               smcd_clc_prep_confirm_accept(conn, clc, first_contact,
> >                                            version, eid, ini, &fce_len,
> >                                            &fce_v2x, &trl);
> > -     else
> > +     } else {
> > +             down_read(&conn->lgr->llc_conf_mutex);
> > +             if (!smc_link_usable(conn->lnk) || conn->lnk->clearing) {
> > +                     up_read(&conn->lgr->llc_conf_mutex);
> > +                     return -ENOLINK;
>
> [Severity: Medium]
> Should this return a positive CLC decline code instead of -ENOLINK?
>
> Both handshake paths read a negative reason code as "fallback is not
> possible". On the client, smc_clc_send_confirm() returns -ENOLINK,
> smc_connect_rdma() jumps to connect_abort, and then
> smc_connect_decline_fallback() does:
>
> net/smc/af_smc.c:smc_connect_decline_fallback() {
>     ...
>         if (reason_code < 0) { /* error, fallback is not possible */
>     ...
> }
>
> As a result, connect() fails with ENOLINK.
>
> On the server, smc_listen_work()->smc_listen_decline() does:
>
>         if (reason_code < 0 ||
>             smc_switch_to_fallback(new_smc, reason_code)) {
>                 /* error, no fallback possible */
>                 smc_listen_out_err(new_smc);
>
> and the accepted connection is torn down.
>
> Other SMC-R link and buffer failures at the same stage return positive
> decline codes, send a DECLINE and fall back to TCP. Examples in
> smc_connect_rdma() are SMC_CLC_DECL_ERR_RDYLNK and
> SMC_CLC_DECL_ERR_REGBUF. Neither CONFIRM nor ACCEPT has been sent yet,
> so a DECLINE is still valid here.
>
> A matching code already exists and smcr_lgr_conn_assign_link() uses
> it:
>
> #define SMC_CLC_DECL_NOACTLINK  0x030a0000  /* no active smc-r link in lg=
r    */
>
> In multi-link groups, smc_switch_conns() skips SMC_INIT connections. A
> connection that is still handshaking therefore keeps the dying link
> even when another link is available.
>
> Could SMC_CLC_DECL_NOACTLINK be reported here so the connection falls
> back to TCP? The callers of smc_clc_send_confirm_accept() treat positive
> return values as byte counts, so the wrappers would need a small
> restructure to pass it through.
>
> The commit message also doesn't mention that this case now fails
> instead of falling back to TCP.
>
> > +             }
> >               smcr_clc_prep_confirm_accept(conn, clc, first_contact,
> >                                            version, eid, ini, &fce_len,
> >                                            &fce_v2x, &gle, &trl);
> > +             up_read(&conn->lgr->llc_conf_mutex);
> > +     }
>
> [Severity: Medium]
> This is a pre-existing issue, not one introduced by this patch, but it
> affects the locking contract this down_read() relies on.
> smcr_link_clear() is documented as:
>
> /* must be called under lgr->llc_conf_mutex lock */
>
> smcr_clnt_conf_first_link() in af_smc.c calls smc_llc_cli_add_link()
> without taking llc_conf_mutex:
>
>                 smc_llc_flow_qentry_clr(&link->lgr->llc_flow_lcl);
>                 smc_llc_cli_add_link(link, qentry);
>
> smc_llc_cli_add_link() calls smcr_link_init() and
> smcr_buf_map_lgr(lnk_new). On its out_clear_lnk error path it also
> calls smcr_link_clear(lnk_new).
>
> The other callers take the write side. smc_llc_process_cli_add_link()
> wraps the same function in down_write(), and smcr_serv_conf_first_link()
> and smc_llc_process_srv_add_link() do the same around
> smc_llc_srv_add_link().
>
> The new reader here doesn't seem able to see the cleared lnk_new. That
> slot isn't any connection's conn->lnk, and smc_client_lgr_pending
> serializes other client connections on this link group.
>
> Should smcr_clnt_conf_first_link() still hold llc_conf_mutex for
> writing around smc_llc_cli_add_link()? The new down_read() assumes
> that all link setup and teardown runs under the write side.
>
> >       memset(&msg, 0, sizeof(msg));
> >       i =3D 0;
> >       vec[i].iov_base =3D clc;
>
> [Severity: Low]
> This isn't a bug introduced by this patch (it dates from 2020), but
> further down, smc_clc_send_confirm_accept() builds up to five kvecs
> (header, fce_v2x, gle, gid list, trailer) and then sends them with num
> set to 1:
>
>         return kernel_sendmsg(smc->clcsock, &msg, vec, 1,
>                               ntohs(clc->hdr.length));
>
> kernel_sendmsg() passes num to iov_iter_kvec() as nr_segs. This only
> works because iterate_kvec() walks the segments by remaining length
> rather than by nr_segs. Afterwards, iter->nr_segs underflows:
>
>         iter->nr_segs -=3D p - iter->kvec;
>
> Should this pass i instead of 1?
>
> [ ... ]
>
> > @@ -1227,7 +1234,7 @@ int smc_clc_send_confirm(struct smc_sock *smc, bo=
ol clnt_first_contact,
> >                       reason_code =3D -ENETUNREACH;
> >                       smc->sk.sk_err =3D -reason_code;
> >               } else {
> > -                     smc->sk.sk_err =3D smc->clcsock->sk->sk_err;
> > +                     smc->sk.sk_err =3D smc->clcsock->sk->sk_err ?: -l=
en;
> >                       reason_code =3D -smc->sk.sk_err;
>
> [Severity: Medium]
> Can this copy -ERESTARTSYS into sk_err and into the connect() return
> value?
>
> On a blocking connect(), __smc_connect() runs in the caller's context,
> and the clcsock sndtimeo defaults to MAX_SCHEDULE_TIMEOUT. Suppose
> tcp_sendmsg_locked() waits in sk_stream_wait_memory(), for example
> under TCP memory pressure, while a signal is pending. It then returns
> sock_intr_errno(MAX_SCHEDULE_TIMEOUT), which is -ERESTARTSYS.
>
> With this change, smc->sk.sk_err is set to 512, which
> getsockopt(SO_ERROR) can expose. smc_connect() also returns
> -ERESTARTSYS, so the syscall may be restarted, for example after
> SIGSTOP/SIGCONT or with an SA_RESTART handler.
>
> smc_connect_decline_fallback() leaves sk_state at SMC_INIT and
> sock->state at SS_CONNECTING. On restart, kernel_connect() on the
> already connected clcsock returns -EISCONN. The application may read
> that as success, even though the SMC connection was aborted.
>
> The receive side in smc_clc_wait_msg() handles this case explicitly:
>
>         if (signal_pending(current)) {
>                 reason_code =3D -EINTR;
>                 clc_sk->sk_err =3D EINTR;
>                 smc->sk.sk_err =3D EINTR;
>
> Should the send side map signal errors to EINTR the same way? Before
> this patch the same case was reported as success, so the change helps,
> but the errno exposed here looks wrong.
>
> [Severity: Medium]
> This is a pre-existing issue, but after this change the CLC send
> helpers handle the same error differently. smc_clc_send_proposal()
> still does:
>
>         len =3D kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
>         if (len < 0) {
>                 smc->sk.sk_err =3D smc->clcsock->sk->sk_err;
>                 reason_code =3D -smc->sk.sk_err;
>
> sk_err can be 0 here: after sk_stream_error()->sock_error() clears it
> on EPIPE, or when the send fails with -EAGAIN, -EINTR or -ENOMEM. In
> that case this returns 0 even though the send failed. The client then
> waits in smc_clc_wait_msg() and is likely to hit an error or EOF there.
>
> Should smc_clc_send_proposal() use the same sk_err ?: -len fallback?
>
> >               }
> >       }
> > @@ -1246,7 +1253,8 @@ int smc_clc_send_accept(struct smc_sock *new_smc,=
 bool srv_first_contact,
> >       len =3D smc_clc_send_confirm_accept(new_smc, &aclc, srv_first_con=
tact,
> >                                         version, negotiated_eid, ini);
> >       if (len < ntohs(aclc.hdr.length))
> > -             len =3D len >=3D 0 ? -EPROTO : -new_smc->clcsock->sk->sk_=
err;
> > +             len =3D len >=3D 0 ? -EPROTO :
> > +                     -(new_smc->clcsock->sk->sk_err ?: -len);
> >
> >       return len > 0 ? 0 : len;
> >  }
>
> [Severity: Low]
> The commit message describes these two hunks as:
>
>     Preserve the preparation error in both CLC send wrappers when the TCP
>     socket has no error recorded. Otherwise the new -ENOLINK return is
>     converted to success.
>
> Is that the whole effect? The change also covers every failed
> kernel_sendmsg() where clcsock->sk->sk_err is 0.
>
> That case is common. When tcp_sendmsg_locked() fails with EPIPE,
> sk_stream_error() calls sock_error(), which clears sk_err. Timeouts and
> signals (-EAGAIN, -EINTR, -ERESTARTSYS) also leave sk_err at 0.
>
> Before this patch, those failures became reason_code 0 in
> smc_clc_send_confirm() and a return value of 0 in smc_clc_send_accept(),
> which callers treat as success.
>
> Could the commit message say that ordinary TCP send failures during
> CONFIRM/ACCEPT are no longer reported as success?
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260927074600.3694802-1-nicoyip.dev%40gmail.com

These pre-existing issues are variant of the data race reported by
this patch, now they are also addressed in v2
https://lore.kernel.org/netdev/20261003183325.2289707-1-nicoyip.dev@gmail.c=
om/T/#u.

Best regards,
Chengfeng
