Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A424CCDC7
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 05:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788500545; cv=pass; b=qsIReoszLASkCe+un9JCSwSDA0UUtjbZEhqCMMSoWgwuYxMu6xJLRaVVKdt/fSbnAOdaW2DSAXSgi07UNJg9gS96RSY2kV8Jz9sXtxMSeqaKUccTIqSSh+c8B7hRjd+UlCpZ6b+bTRXmFmqPRZ9qo9uidfdXbeZIRZnQxDHJJPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788500545; c=relaxed/simple;
	bh=7a9ytScdRalaQfs49ax3SHBjSOpZN0zrjBNJQ4qqRgw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=itdjajAZgjZJYm6euKJ5CRmJrk3zSeJd6OMM2T6mFL6Hkm2rvhCqMl7lPvcoBqJUGAO/hTvtI1lUGfIHyJFY5SLQrFaBUvIRKOJdMwlnCC7igI3GNY6GoIVIeLPXygxPo9nJtl8icajQz6QkDrKv0DZ1wcKdW+chl3HDRy7I2HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=XR5HqxlY; arc=pass smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="XR5HqxlY"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a20d12211bso6363831fa.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 22:42:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788500540; cv=none;
        d=google.com; s=arc-20260327;
        b=jEt4Gw44ZvGMZdJ71YgzA8EJvX7fMsiL2voI5QHRgw7OBUIc3K1luCTZDxGp+qfv4F
         evjWxR7I7HfOOqxrPEuEq2xS6dcz/Wbs2cpnsVATvCZOyQOyIfPPIfelJqnlOonX9AEY
         3YwHYyTkb7iQdtupWd3d9ntx+yKBzKHIA/yNeks8xCPekEnZNqeTd3gYlhXZJLQaxZQw
         Q2rpMGW0hzrSVd90RafgbrULzd33wr6YlWQfbPPxENlcB0B0kOY7cES0KqFYAIzRvX/W
         XZX8BimgulmgJvXRxw08K51A0xdq9lPEOMG0Pkeer6YsSXAJbNLZsI33iv4jZP1iRWl/
         gFtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WP9LYTFZF8MbWwJfhaukl4r1/bwWhLGNTeX8IkDlRSA=;
        fh=wvkNSt/HoieqbkfgPvYJOqlnrkRpP6ZzoO2TyJzCLn4=;
        b=cgENDxP+TB8B/c10a9SdHJSgG1HkT0yPf1P+OUjx5JmInMT5JZBlaoSGai92DyHS1N
         Td8sZogI+gCUFc1moemgdFxh8DtFrHJLlAgrVakN+dPFGFwdX8mOHJMWa7ypMHuLWPjL
         jgkNrneQl7YJnb/ty/HXuYWR85HSYAORabT2YZqv09mdxO2aRnpVkkuxvmwYIU0K09zf
         oOxW37qv5E5ZzDi4W9t2GA5MMdLJfbPI6cPWsz2NLLbwl+CUtVUh8TwCuAqxzFo3IVhy
         lPq0KEns4fUJ/1azdZPu4rxI4bX7gj8ADIt/2/TFLZLnS0PBOnixd52wtXS8CepOetZm
         ugng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788500540; x=1789105340; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WP9LYTFZF8MbWwJfhaukl4r1/bwWhLGNTeX8IkDlRSA=;
        b=XR5HqxlY+Mahz09OZo80Hn5QddQI+Y1xc3wGYM51C8r9jjtRqYpb4SQQjkDxdVIf8t
         yg/7H0yiRLPckeljaBeJLoYWMwdba6Qkt1Lx5+hTquI9TKokB9ICbn8+DmzaKCSqlXKf
         Wo/Jbzjorw2r+LnW5tCHlc/njxQF4RQ0dJrPMbJmhyaFGRUJSJBrq4nx3q9IW7vTNnq/
         BeuTWl6Q9u38q8wnXz3MlgwGfgz4ZqbxoYkL3p25HWalD0+lSk1mpDi+md8c/6+jJiac
         nunhIciRrKl/gYvB5spC4JADvuexX2vmokSm6G+ccMuiBwhPyDeD4f20CHrOiPEw5G6r
         04Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788500540; x=1789105340;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WP9LYTFZF8MbWwJfhaukl4r1/bwWhLGNTeX8IkDlRSA=;
        b=kTDblat1Rf++vYismN74zf/pjc/t9C0YrL0d4CWoHJU7k9TXxF/8eR1mwrMJpY8ikF
         dyxCmvqc01blHm1NiLWxXSyIC/9BqDyIPUiFUazmNGILU9yRE4R8gotoCb1eb55Endbf
         r506Vhw8QmoKkDttHnlr94tnucnx6zb3Qp6jtZ/eciqeZe78le8aRV9V08MoBrN+Kv/B
         KmeYWZ+U+on0McM3ZGgtsZgQM67W7vukIbni45wjfKut7Wx6VWWi9Z/tg14B5t/7zf7Q
         gFXHZoOEpMijuC1CAQGQsHFsadVIpNiie/vzwB3HBqIGN1ph6lvcH6gQNLzfLS5PFAmM
         13MA==
X-Forwarded-Encrypted: i=1; AKwUvBw2zytinD9oq6QY7SGQWD0KR1SUZBbhEXpM+2hvcDaKZ6amGTMJ9VlOHmH2yA/R2+AqfyYIE4E=@vger.kernel.org
X-Gm-Message-State: AFuF++mc2U71UEQa8ADJey8aLfhKzQWSlFGEQHDI5V1KK64jxCD5dDwO
	qpxp8CM9ztofv5kQIz2OfYWk6gBqDQLHXa9twiKQ4ktSpDLKyBpeTZDGARd9pimw+wbXwhawUGW
	QT4eLgIDOF00EU7dwgzLLEvzuFZ8vsQPztfUrX2Bo8Z8=
X-Gm-Gg: AYBFou1SAdiz6mDyj4pwgDL0HXrshMxQSbhRkgnC8UXbC3ZNLp0VeCodvyHZ7yEm19i
	PKgbwRbbuv/2X9EPv3YO0J05jGrBaZsJCrloL6Ez2e7kl2Zx/Oy8aJo2DHXMiyZWHQ3KMpYVL4c
	Jrl9s0RkA3azhmWngGbiCtpiYs+y9VzQuA/wxICmT6IuVwBS86OXn8rg5cuTfe3YMsjx2IrQtfk
	EmDJ1OZH9cy8S3JbUPxiYA5ZKNbNF3FJfAMjwPuVYyYTOx0WeiSiGTA7VEWeh0NJ67XvH9BEYP8
	RCNWR3TGsGG9GRnAwyADwYqE70HAf5G7+BVSZ/NyiOrwGNXul5SLa24VPfQdIv4XuusGUYiXZlE
	=
X-Received: by 2002:a2e:b8c3:0:b0:3a3:61ec:43bd with SMTP id
 38308e7fff4ca-3a361ec44d3mr7558051fa.14.1788500539833; Thu, 03 Sep 2026
 22:42:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1788259244.git.zihanx@nebusec.ai> <34824eaea68a895a3fe9ed5337248eca1d81f74f.1788259244.git.zihanx@nebusec.ai>
 <3674f5d34d731403bfa0e680c9e5718237612315.camel@iki.fi>
In-Reply-To: <3674f5d34d731403bfa0e680c9e5718237612315.camel@iki.fi>
From: zihan xi <zihanx@nebusec.ai>
Date: Fri, 4 Sep 2026 13:42:08 +0800
X-Gm-Features: AcwNN1UfMQ3DTycfG08OX_qcUrL1qPCx5CxEUb6NKsdMUjjJ1Z01C_kABixHz6I
Message-ID: <CAANe3eTturj=T-H_O+eA=XF1jcJdt0TkRnG_UJEbeGsvgr-Gyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] Bluetooth: Fix parent socket UAF in accept queues
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Thu, Sep 3, 2026 at 11:11=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> to, 2026-09-03 kello 11:11 +0000, Zihan Xi kirjoitti:
> > Bluetooth children queued on a listening socket store the listener in
> > bt_sk(sk)->parent, but the accept queue did not hold a reference on
> > that parent socket.  The child side can later fetch that pointer and
> > unlink itself from the accept queue while still needing to notify the
> > listener, for example from L2CAP, ISO or RFCOMM teardown/state-change
> > callbacks.
>
> Please revalidate the KASAN crash on current bluetooth-next/master,
> there have been related fixes since v1 of the patch and the v7.2-rc6
> shown in the KASAN crash in the cover letter.
>
> With commit d4bfa78fd679 ("Bluetooth: L2CAP: reject accept queue add
> unless BT_LISTEN") in v7.3-rc1 cherry-picked on v7.2-rc6 the POC no
> longer reproduces for me.
>

 Thanks for the review.

We revalidated this. On bluetooth-next with 9db7e5fffbae ("Bluetooth:
L2CAP: reject accept queue add unless BT_LISTEN") =E2=80=94 the same change=
 as
d4bfa78fd679 =E2=80=94 our PoC no longer hits the l2cap_sock_ready_cb UAF.
That matches what you saw after cherry-picking d4bfa78fd679 onto
v7.2-rc6.

The KASAN report in the cover letter was captured on v7.2-rc6 after
reverting that commit. I should not have presented it as a crash on
current bluetooth-next/master.

> ***
>
> The design intent AFAICS is that the accept queue of the parent socket
> shall be empty when the parent socket is freed.
>
> Otherwise, the child sockets in accept queue would leak.
>
> There must then be parent->sk_state =3D=3D BT_LISTEN check before
> bt_accept_enqueue() and some were missing in v7.2-rc6.
>
> bt_sk(sk)->parent read/write is guarded by lock_sock(sk), and it is set
> to NULL when removed from accept queue.
>
> Dangling bt_sk(sk)->parent should then not occur.
>
> If bt_sk(sk)->parent !=3D NULL is observed under lock_sock(sk), the
> parent socket is valid during that critical section.
>
> The sock_hold/put(parent) in this patch are in lock_sock(sk) critical
> sections, so should be no-ops.
>
> The accept queue items owning reference to parent also should be no-
> ops.

Agreed. Once the BT_LISTEN check is in place, close() empties the
accept queue before the parent is freed, and lock_sock(sk) serializes
ready/teardown against unlink. The extra parent references do not
change the lifetime of the listener, so this patch is not needed on
current bluetooth-next.

I will drop this series.

Thanks,
Zihan Xi
>
> > If the listener is closed concurrently, removing the child from the
> > accept queue can drop the last listener reference before those
> > callbacks call parent->sk_data_ready(parent), leaving a stale parent
> > pointer and a use-after-free.
> >
> > Take a reference on the parent when a child is queued and drop it when
> > the child is unlinked.  Since unlinking now drops the accept-queue
> > parent reference, take a temporary parent reference in the callbacks
> > that continue to notify the parent after bt_accept_unlink().
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> > changes in v2:
> >   - rebase onto current bluetooth-next
> >   - refresh trailers to the current submission template
> >   - retarget author identity to Zihan Xi <zihanx@nebusec.ai>
> >   - v1 Link: https://lore.kernel.org/all/65767989c644f8adf52f35334f4034=
c66f47881f.1784383243.git.xizh2024@lzu.edu.cn/
> >
> >  net/bluetooth/af_bluetooth.c | 2 ++
> >  net/bluetooth/iso.c          | 2 ++
> >  net/bluetooth/l2cap_sock.c   | 2 ++
> >  net/bluetooth/rfcomm/sock.c  | 2 ++
> >  4 files changed, 8 insertions(+)
> >
> > diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.=
c
> > index 411d66f24393..61a232378e6c 100644
> > --- a/net/bluetooth/af_bluetooth.c
> > +++ b/net/bluetooth/af_bluetooth.c
> > @@ -218,6 +218,7 @@ void bt_accept_enqueue(struct sock *parent, struct =
sock *sk, bool bh)
> >       BT_DBG("parent %p, sk %p", parent, sk);
> >
> >       sock_hold(sk);
> > +     sock_hold(parent);
> >
> >       if (bh)
> >               bh_lock_sock_nested(sk);
> > @@ -266,6 +267,7 @@ void bt_accept_unlink(struct sock *sk)
> >       spin_unlock_bh(&bt_sk(parent)->accept_q_lock);
> >       bt_sk(sk)->parent =3D NULL;
> >       sock_put(sk);
> > +     sock_put(parent);
> >  }
> >  EXPORT_SYMBOL(bt_accept_unlink);
> >
> > diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> > index 75bfd5938b2e..e709292aa112 100644
> > --- a/net/bluetooth/iso.c
> > +++ b/net/bluetooth/iso.c
> > @@ -286,8 +286,10 @@ static void iso_chan_del(struct sock *sk, int err)
> >
> >       parent =3D bt_sk(sk)->parent;
> >       if (parent) {
> > +             sock_hold(parent);
> >               bt_accept_unlink(sk);
> >               parent->sk_data_ready(parent);
> > +             sock_put(parent);
> >       } else {
> >               sk->sk_state_change(sk);
> >       }
> > diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> > index b553b6356af8..3720ab2e39ed 100644
> > --- a/net/bluetooth/l2cap_sock.c
> > +++ b/net/bluetooth/l2cap_sock.c
> > @@ -1748,8 +1748,10 @@ static void l2cap_sock_teardown_cb(struct l2cap_=
chan *chan, int err)
> >               sk->sk_err =3D err;
> >
> >               if (parent) {
> > +                     sock_hold(parent);
> >                       bt_accept_unlink(sk);
> >                       parent->sk_data_ready(parent);
> > +                     sock_put(parent);
> >               } else {
> >                       sk->sk_state_change(sk);
> >               }
> > diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> > index 958081adb9b5..a16daa68ecb8 100644
> > --- a/net/bluetooth/rfcomm/sock.c
> > +++ b/net/bluetooth/rfcomm/sock.c
> > @@ -78,11 +78,13 @@ static void rfcomm_sk_state_change(struct rfcomm_dl=
c *d, int err)
> >
> >       parent =3D bt_sk(sk)->parent;
> >       if (parent) {
> > +             sock_hold(parent);
> >               if (d->state =3D=3D BT_CLOSED) {
> >                       sock_set_flag(sk, SOCK_ZAPPED);
> >                       bt_accept_unlink(sk);
> >               }
> >               parent->sk_data_ready(parent);
> > +             sock_put(parent);
> >       } else {
> >               if (d->state =3D=3D BT_CONNECTED)
> >                       rfcomm_session_getaddr(d->session,
>
> --
> Pauli Virtanen
