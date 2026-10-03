Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C6438239A
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 19:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791056256; cv=pass; b=VIg4A3L8bghn1svJbXmslmnyiLVupLUaTz6bm1RWa9CCLqqoFt6UDQfc92XLqQ1Q/jbNlq6Bncm4rj5fQyteSsbwv23UwufijTM4+U+YXOQm1VZfYx85ialccFjKphK1nbmc5U0YH3+iXMGbFrdiypYsq48Tbk83WyXn99nTTls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791056256; c=relaxed/simple;
	bh=RQdISwCIeTHJRNNRYXKnQccif86ZtXCpqBErB1KRL7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHgKy7Bl/4KLbtiKFtw8cEYIT+c46R4SV82En8vgr361LBl2GQvmAG348iZPCucM8fJT8P0Pqo1slifAgI32fAfAtcU5OSJ0UuFFzRCD2r13lz+5YA0l4m9+4RiHVETFqfzciI82kE7MQAoJy9TLt0ZG1eqbcKJY8SiNLC/Y1B8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2qBkOJb; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2qBkOJb"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a837b0c2bso11414466b.3
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 12:37:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791056252; cv=none;
        d=google.com; s=arc-20260327;
        b=bAlq/HnkrtaHkc39mAvUUVEhuv1Xuvfk1vlXoVW8mSoWwmkfI30uS6GZqH61kAR7SN
         DKQeqC3kuxrBjJUZXNdCKFjoNwFKEwbs8LJzzq5wivEkfQMq0CyzDxwCt3XaMK/N7cYo
         eycm/T6qsP1f89B+pt+N0M/0Ua/66UiCo8qza+SALPVBB1atgx7YDRhgv6E/CRJ/JIuT
         IBVdITKqIAU6gPtnodYTeA5dZv1UPcvJp4zy7MyOi8hAwvN8Q9iAjdTFFLdGIxfwaKEf
         GOZLMVdpyMtQWNZ2FMDd+QhkADEArDZmJ6GmA3sH55oxN7728nOrwIVPxkuaHMmMi50Z
         cwvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        fh=cKqSZRn7N+DNy5oSnu0H7xcjItoxvM8twwooKDRQKiE=;
        b=NVIrekJixFkmDDlAJyth9jNEBsjxVl0s55Qj/yc9X1w1n1eJJNw8RT2RW8BUXjhEWe
         oFniyi2snpQ8a5MEIdDAJm5HAEWGITk7dv/bG7VPNGU1PEP3G+ZTwC5tnbN/Z7hQW6dP
         onITskMU8ixqz2OirCyTxdRkT0TK/DXjzACb2Is4ZMTQn3KAzX/vTaLKbdCOadkUdLVe
         3p3dloSiwsfqKMRGzKnpl0wFVjbnjlkEfAUdKAzOu0IlZ5f+qHnV7pDdz02d9r/D2LdC
         jT67yQU+W8fhj73SJuwBDM7m/3vK3r178Z0XqN/eKBtsdBiwXTk0xXw89ppdbubSEkm0
         zA+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791056252; x=1791661052; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=p2qBkOJbe0JoIVZCajmcrQTxkDnY+IOH3/Tk7u4MNIVFwtr+MwYQD/b8Wiq+6L1Z5D
         XH8mXaO7g+fmFom3HdXa+rO/y6TynLCKTZZpNl6SscUG+2P0WMrwx5aRc3kjGm6PfhRd
         1Rr8zmBaUPRzZe1ZoIUjLsdfPRDUU8P5zuF9k9YDE+0VfkHUzJduxWdNTQ6ThddUKhmO
         2M7odiGaEisdf693nRTuGLEe1H63qaLVrTKKCXqkbNhho+sqeZzA8Euk8bvc1Bq1rnMp
         omDjAxvICJx04pmTcLSMIRTpsmpop8GR/dN9vInYBmrSD2ufRbKFagmEqiFPTI5+Rh+f
         Ylcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791056252; x=1791661052;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+1sgNjTuEhjk9Api27Ek7GbjZW7LaWBth9pDAUxc4Wk=;
        b=xVdjX2Hxg+WXfzkHT6s9YdRvF2r5x2zPOGZejBWu3bkxCDDiPelCPr/mRQLbWELVJX
         dPx4YNMHqIGjbgtpfyRZmKrMbunAVovE6Ez9Xvy1RhC3yRcW3jo5+vbYvD8UHG0nCI3n
         88BM9JTxrqIsI6nkkjIfCee66hzesyb6TY/sQK8kgaw4qjKqUCQt5WRbW5y4pG+w4JYz
         +Iklt7uxfwI+46pDKYNInW0PMzHZYLvStDjqMH+x08EsfwSmYAXe3LCgR4+Gosws3RH0
         lm1kycqFaCvjoQHTGFe49WL3VVGjFGOrHFCMsaQYy0GrpdgFqRT78tbS3volTjYjax/Q
         mvdA==
X-Forwarded-Encrypted: i=1; AKwUvBxZfpSqx1WfO0Tq7gbkdZdZSUC46TEzrUgNwF2Dh3ZCs5XshhLIEePEZyut8ZPWhxC9Gi9d3wk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKGZ7tKxfF/Y0D88d/A90cKKV8h3dACT+fHUbTifHIki2Q2Rdwg
	q4V8Inxka/Lp5YW24EyaI5no+42j2vjrfG/MH6MyfDjmj2z9e3Jqd6qQKhjnDybfAwjlk4RDpCT
	1Nf+G15vv64n1UlhS40mwoY+DmyNEhu4=
X-Gm-Gg: AYBFou1uB7v4X0utnTVoRaRyATBpL6VRyYZXoAPo6r75HdDqMHkkDy0wE8sGErjTyvv
	87T6MbZYXx6sh+QR628s/2lTCWSu7AclbamOd40YFsm92UCbXVEGbIE944ni2AqNi9FW2grIhT7
	crgu/+/S/1AnwPrDkChOhFS2uGtI12yFrmk0LKwqjjX4sDNokQkqrC+r9Nwtd0cW0aEfOcbJFPJ
	dqeSN5Vw2urLURNMTeQTsaQP8VLkRiyyG2euTzmloJDxr1fUQqLsXOmBv9RH2wDLjrGaFagQw3R
	wM9ZC6HP0eOJVtdU4GhboeU1DnyiT8yhDGSKCRU2W6g4K5AIhlMzxasTNJLkItG/KYZNplVkuU3
	18ZDaY/il6auvNAQqDF4usA==
X-Received: by 2002:a05:6402:1ed0:b0:6aa:a040:cc0b with SMTP id
 4fb4d7f45d1cf-6af9e26f8demr6033264a12.1.1791056251842; Sat, 03 Oct 2026
 12:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927063607.3691520-1-nicoyip.dev@gmail.com> <179072873236.434549.5842458403458661428@kernel.org>
In-Reply-To: <179072873236.434549.5842458403458661428@kernel.org>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Sun, 4 Oct 2026 03:37:18 +0800
X-Gm-Features: AclHuK9p6aQ_J43EOVKpodci3vxNOzsM7jVie2jHyLl0wZCCleShlxslsIU4Ncg
Message-ID: <CAAo+4rVATDapayqSFFjRaNxFod=bnUGk66opVVUgdwVBr48FNg@mail.gmail.com>
Subject: Re: [PATCH net] net/smc: Serialize early link group cleanup with termination
To: netdev-bot+sashiko@kernel.org
Cc: alibuda@linux.alibaba.com, dust.li@linux.alibaba.com, 
	sidraya@linux.ibm.com, mjambigi@linux.ibm.com, tonylu@linux.alibaba.com, 
	guwen@linux.alibaba.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ubraun@linux.ibm.com, 
	kgraul@linux.ibm.com, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 8:38=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 0 (1)
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] The patch covers only one of the two callers of
>   smc_lgr_cleanup_early().
> - [Medium] Early cleanup can free the link group while a
>   smc_lgr_free_work() callback that has already started is still using=E2=
=80=A6
>
> Pre-existing issues:
> - [Low] In __smc_lgr_terminate() (net/smc/smc_core.c:1573-1574), the
>   comment says "cancel free_work sync, will terminate when lgr->freeing=
=E2=80=A6
>
> --
>
> net/smc: Serialize early link group cleanup with termination
>
> This commit makes smc_lgr_cleanup_early() check and claim lgr->freeing
> under lgr_lock before it calls __smc_lgr_terminate(). This stops early
> cleanup from racing with the other teardown paths. It also makes
> smc_conn_abort() hold a temporary link group reference across
> smc_conn_free() and early cleanup.
>
> > diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> > index e9f93b3ab435b..97b0a0b510664 100644
> > --- a/net/smc/af_smc.c
> > +++ b/net/smc/af_smc.c
> > @@ -1011,12 +1011,16 @@ static void smc_conn_abort(struct smc_sock *smc=
, int local_first)
> >       struct smc_link_group *lgr =3D conn->lgr;
> >       bool lgr_valid =3D false;
> >
> > -     if (smc_conn_lgr_valid(conn))
> > +     if (local_first && smc_conn_lgr_valid(conn)) {
> >               lgr_valid =3D true;
> > +             smc_lgr_hold(lgr);
> > +     }
>
> [Severity: High]
> This adds a reference for the smc_conn_abort() caller, because the new
> lgr->freeing check needs the link group to still be allocated. Does the
> other caller of smc_lgr_cleanup_early() need the same protection?
>
> net/smc/smc_core.c:smc_conn_create() {
>     ...
>                 write_lock_bh(&lgr->conns_lock);
>                 rc =3D smc_lgr_register_conn(conn, true);
>                 write_unlock_bh(&lgr->conns_lock);
>                 if (rc) {
>                         smc_lgr_cleanup_early(lgr);
>                         goto out;
>                 }
>         }
>         smc_lgr_hold(conn->lgr); /* lgr_put in smc_conn_free() */
>     ...
> }
>
> The hold is only taken after registration succeeds. On the failure path,
> smc_lgr_cleanup_early() runs without a reference of its own.
>
> For SMC-R first contact, smc_lgr_register_conn() fails through
> smcr_lgr_conn_assign_link() only when the new link is no longer
> SMC_LNK_ACTIVATING. As far as I can tell, that happens only when
> __smcr_link_clear() resets the link inside a teardown's smc_lgr_free(). T=
hat
> teardown drops the link's lgr reference and then the initial one. For
> example:
>
> smc_smcr_terminate_all(NULL)   /* reboot notifier via smc_lgrs_shutdown()=
 */
>     list_splice_init(&smc_lgr_list.list, &lgr_free_list);
>     lgr->freeing =3D 1;
>     __smc_lgr_terminate(lgr, false)
>         smc_lgr_free()
>             smcr_link_clear()->__smcr_link_clear()  /* link UNUSED, lgr p=
ut */
>             smc_lgr_put(lgr); /* theoretically last lgr_put */
>                 __smc_lgr_free()->kfree(lgr)
>
> The connecting thread (connect() or the smc_hs_wq listen worker) then see=
s
> registration fail and calls smc_lgr_cleanup_early() on the freed lgr. The=
re,
> smc_lgr_list_head() reads lgr->is_smcd and the new check reads
> lgr->freeing.
>
> The commit message says:
>
>     The extra reference keeps the group alive until early cleanup has
>     checked teardown ownership.
>
> The smc_conn_create() caller has the same lifetime requirement. Is a
> use-after-free from early cleanup racing with termination still reachable
> through that path? The window is narrow. It looks like it needs a teardow=
n
> such as a reboot to run during an SMC-R first-contact handshake.
>
> >
> >       smc_conn_free(conn);
> > -     if (local_first && lgr_valid)
> > +     if (lgr_valid) {
> >               smc_lgr_cleanup_early(lgr);
> > +             smc_lgr_put(lgr);
> > +     }
> >  }
> >
> >  /* check if there is a rdma device available for this connection. */
> > diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
> > index 9974149659c2f..b166a379753c7 100644
> > --- a/net/smc/smc_core.c
> > +++ b/net/smc/smc_core.c
> > @@ -688,6 +688,11 @@ void smc_lgr_cleanup_early(struct smc_link_group *=
lgr)
> >
> >       smc_lgr_list_head(lgr, &lgr_lock);
> >       spin_lock_bh(lgr_lock);
> > +     if (lgr->freeing) {
> > +             spin_unlock_bh(lgr_lock);
> > +             return;
> > +     }
> > +     lgr->freeing =3D 1;
>
> [Severity: Medium]
> Can early cleanup free the link group while a smc_lgr_free_work() callbac=
k
> that has already started is still using it?
>
> After freeing is claimed here, __smc_lgr_terminate() only does a
> non-synchronous cancel:
>
> net/smc/smc_core.c:__smc_lgr_terminate() {
>     ...
>         /* cancel free_work sync, will terminate when lgr->freeing is set=
 */
>         cancel_delayed_work(&lgr->free_work);
>         lgr->terminating =3D 1;
>     ...
> }
>
> free_work is queued on system_percpu_wq, not lgr->tx_wq. So
> destroy_workqueue(lgr->tx_wq) in smc_lgr_free() does not flush it. The
> callback also holds no lgr reference.
>
> Suppose the callback has started but has not yet reached the freeing chec=
k:
>
> net/smc/smc_core.c:smc_lgr_free_work() {
>     ...
>         smc_lgr_list_head(lgr, &lgr_lock);
>         spin_lock_bh(lgr_lock);
>         if (lgr->freeing) {
>     ...
> }
>
> Teardown can then run to completion. smc_lgr_free() drops the initial
> reference, and the new smc_lgr_put() in smc_conn_abort() drops the last
> one. __smc_lgr_free() then frees the lgr and its embedded free_work, and
> the callback goes on to dereference freed memory.
>
> The commit message says:
>
>     This also prevents early cleanup from racing with the delayed free
>     worker
>
> It looks like the freeing flag only prevents a second teardown while the
> object is still allocated. It does not keep the lgr alive for a worker th=
at
> lost the race. Is the commit message accurate here?
>
> To trigger this, the SMC_LGR_FREE_DELAY_* timer has to expire during the
> creator's abort. That looks like it needs an unusual stall or a jiffies
> jump.
>
> [Severity: Low]
> This isn't a bug introduced by this patch, but the comment in
> __smc_lgr_terminate() quoted above says "cancel free_work sync". The code
> calls cancel_delayed_work(), which does not wait for a callback that is
> already running.
>
> What protects a pending smc_lgr_free_work() is its own re-check of
> lgr->freeing under lgr_lock, not a synchronous cancel. Early cleanup now
> reaches this code after claiming freeing. Could the comment be updated to
> match the code?
>
> >       /* do not use this link group for new connections */
> >       if (!list_empty(&lgr->list))
> >               list_del_init(&lgr->list);
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20260927063607.3691520-1-nicoyip.dev%40gmail.com

The issues (incomplete fix and comment consistency) identified are
addressed in v2
https://lore.kernel.org/netdev/179105277608.1402591.16173087244761956438@ke=
rnel.org/T/#t

Best regards,
Chengfeng
