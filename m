Received: from mail-lr2-f3.google.com (mail-lr2-f3.google.com [74.125.230.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3D37DAA3
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791602621; cv=pass; b=bj2e3dDmjvW6v3+QCuxmpEF04eh1XuZppWT09OuA+TovShQDmimU/QY0raS1Vn6PrhyshEsogwXaSxJJIN/tXRi/XPQLoz9DaJBmcGqNxAZfc54oYCPI0fQr7r8P527d79aS/V36FsdFFzuszKgeXsP0RMLcgrGe9BxI+es1c/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791602621; c=relaxed/simple;
	bh=DilpxP77Wf5IGboFkUym9zfEMniRVTNtL7kIYRWXCaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5d0o19B1TlHBj1CDLFcBXIuaSNzIEDelEAVn3vxnO2NxR0Qh7RilBhrUa++UjcCu/JfONUlNBOwjvUQp2BmzWkHGYwuQPY9ncwdtSg/+wUyk03VOlM2p08F4wfKKUU9oQUFMDap8uoMCQ6VvXaikCF8wE6PMKBhm1jPxxzsET4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iy9l2wXq; arc=pass smtp.client-ip=74.125.230.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iy9l2wXq"
Received: by mail-lr2-f3.google.com with SMTP id 38308e7fff4ca-3a77f4bc209so2956211fa.0
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 20:23:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791602617; cv=none;
        d=google.com; s=arc-20260327;
        b=CbjMzHuKxJWjaVhuut6A5RpLfZRWNP7AjjMQwxnCjKLyyK2E+RILQtX+04QeSm9D53
         9ffTjVaw2sNFdcZJS7jI6ACj3/Q1ccINgBTAp8J/tjKXXqKQoMIKomPh2h3Ex2sFa9TC
         20ugsvePi7ugly3y1h4z6gvwYdVJtWyBDgFKaQYJMzV0nkW89TK+Y2gssEMIFagd5u/h
         PzVunXRKdXSpojLniFT5SfK5GnjHjzNgF4AiMXlBauGPJZfHNOXPq80rcAS2aJD6ghy1
         LVYlpC/KXWC8+AUHNXvUVVLeS6ToTjVyw6pgv2t++Xz2zOJQDXEMqDcvksUBMcO0xO/v
         13eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vieoj/AaG5T84Kvl4ASa8xKsULW9X7IG5LBpCgMJAnA=;
        fh=VUjDX50hssxjhxFfF0AAiecG5MNNRV1EiA+OjQZqRXg=;
        b=WamfCvdG5dovC9g+kmvTfudzrJ/3kPnoZSH+MWCLb6qVI5+C0j+Nm5L8ilBG3IfPio
         MiaW+I9kdRR2ZdD7OBsRnaUPOOnZF4UPwH4+Ir7+LTDjpsM4OcCTlO0t2jQuzcHzbfIU
         8zpY0BvHQd1QkaOFplmByGPH9cjRt/fJZ/CszB9J5hYaFVMUeE9Ij3uBonIq/QroTj+z
         lU1XV/v8BgtwuUygfEqFNenDlvzmfflFqz+UlE+ONRG8yKo389mSQaiCz+dgCrB1R9HH
         437aaj22elpBJ+mgWhLM8QRDH4yoDm0Q2EnZPvpPo430FG47fKVDXnzKXnFN6JBNmvbL
         tbYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791602617; x=1792207417; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vieoj/AaG5T84Kvl4ASa8xKsULW9X7IG5LBpCgMJAnA=;
        b=iy9l2wXqxs450eRlYYluXw+MWY1jZUo5eEy2HK9P7AhZRvHGzif8YV2/PI7V4uSMq4
         zze9yMaEWfjG5aavLkL8YTBS2sTJF7nHf16ddDDulRdQP1p7JDSNbyN/hCwxdh7Mi3x2
         o6oXlGFPcniIRo3RlexBjlk7INFFCPA5uOLhprd8YiP5SjWFFBH0zk7xt+U9VbTjkpRc
         IhSzYfXvy+eU7FKtFc7EQ0wK94DfRBSwnG52EPZ1L83L+Rtru26xZKoQJAjlsMdw8uuX
         cGn/d8nDMFicpHj8xYl9d1G9DPeP/d8b1PlxGbC9LhJ4WWVqe1QJj/sr20Bgtx2A7nFC
         SqGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791602617; x=1792207417;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vieoj/AaG5T84Kvl4ASa8xKsULW9X7IG5LBpCgMJAnA=;
        b=FFVfcqODHlUlw2Vu5usBYF35Y0DPVNFWaeCEghajhKkHnp4zroeK05l7nfWloVECc8
         zkS9tift6pBIx/npsn1yay8IDvTByGqECKY7+LtlhBFVPr0N9siPyDdrIe3oEMfsH+sw
         XMsx/fIqA4FrjTglbfNKZU6OangJYB3jFLngiTodzqU7EmBqo07u5O9VVZ0vPB0g483Z
         5+XNAljZ5En5fgACJMGJoP5BTaEIx7anM8z17vf2J7QZgKUfCzysdChJX8BiEDVSmih9
         4PbljLd8+MfRBEB1nrI0DHg3m0BxmULj7C7yqlxH9bFF23NyZaBc8i3r+uwS2cVG1BFU
         9zxA==
X-Forwarded-Encrypted: i=1; AKwUvBxInDMcQhPJT9UjOde6/vr/ShAOoeV6ommaU22pOfJD9dChdjUEdd3GyBMmsO2UVBTmG7lBVbs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIQzR+kna+L+jwq4zWIvdGasRu9zoCspowHLbTQQ04hG3YaQuD
	JB1mEYxzGkTzZJMvPlIlABXu1nT81O13IMEqidiA9gN3TPbu0MwogXPpT08VX1w13lk3J4/96S8
	nfwH0q0Ia4JBSN4fBJ+0zLlxFQdWpbEY=
X-Gm-Gg: AYBFou3jCyrgJXf+Ugd4/5X9oyLXki9c5F7K6OpYUjKvxdD2+LMJcZMZTOizcdKibJd
	jE5VNBjtyybRMLGXj8VviaS9LR5GuSgzy3xFXIYFhtqnR2JYC/jyci3zefmuXOKui54V0/ZbxjW
	C9AoAobqnDT00SCHOB54D8/djFfW7zwCLdpfBGlRiJMarV9o+bW4pVL4+J6SRZheEk3EIUt2kqd
	LdVrhAVOW5N5BnrmT3hvyMdX63DpiuYQYpuIDJyC0vgEfDdYmTL2bTEtjG/xic9Xl9SS2MKR3We
	937NywIGn953BUFrmNBwwftezqo9JlVEoDeJlIdhT+zaH1AR1nSZP/cA
X-Received: by 2002:a2e:be0d:0:b0:3a9:707e:ad88 with SMTP id
 38308e7fff4ca-3a9c4eba34emr9355861fa.2.1791602617190; Fri, 09 Oct 2026
 20:23:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009080252.2805877-1-bsdhenrymartin@gmail.com> <CAKYAXd8MyiCVhdN_PaQ=aSEO3yYYQ-Qb-2TnC68o0_pbchM0mw@mail.gmail.com>
In-Reply-To: <CAKYAXd8MyiCVhdN_PaQ=aSEO3yYYQ-Qb-2TnC68o0_pbchM0mw@mail.gmail.com>
From: henry martin <bsdhenrymartin@gmail.com>
Date: Sat, 10 Oct 2026 11:23:24 +0800
X-Gm-Features: AclHuK-ClitBdOErynduKFQRc6WJDbowcHXBQ97nLFTy84wq9FJpNr2s6fS0Too
Message-ID: <CAEnQdOrta-P0OptZ+6qCKGxHN00=fR71JhjdP1b75bS+3EMFyA@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix use-after-free of server info on
 cifs_ses_add_channel error
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, Steve French <stfrench@microsoft.com>, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeon,

You're right, thanks for catching that.  chan points into
ses->chans[], so once chan_count is decremented under chan_lock a
concurrent add_channel can reuse the slot and overwrite chan->server
before the unlocked put reads it.

v2 caches the pointer in a local under chan_lock and uses the cached
pointer for both cifs_chan_clear_need_reconnect() and the final
cifs_put_tcp_session(), so the reference we drop is always the one
this error path took.

Regards,
Henry

Namjae Jeon <linkinjeon@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=889=E6=
=97=A5=E5=91=A8=E4=BA=94 21:32=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Oct 9, 2026 at 5:03=E2=80=AFPM Henry Martin <bsdhenrymartin@gmail=
.com> wrote:
> >
> > The error path of cifs_ses_add_channel() calls cifs_put_tcp_session()
> > before cifs_chan_clear_need_reconnect().  The latter reaches
> > cifs_ses_get_chan_index(), which dereferences server->terminate; if
> > the put was the final reference, TCP_Server_Info is already freed and
> > this is a use-after-free.  Same put-then-use pattern as the recently
> > fixed sibling in commit 717e0a25036b6.
> >
> > Reorder: clear the reconnect bit and drop chan_count under chan_lock
> > first, release the server reference last.
> >
> > This vulnerability was discovered by Tencent CodeBuddy Security.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ee1d21794e55a ("cifs: handle when server stops supporting multic=
hannel")
> > Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> > ---
> >  fs/smb/client/sess.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/smb/client/sess.c b/fs/smb/client/sess.c
> > index e095f41b5882..650c0f855a29 100644
> > --- a/fs/smb/client/sess.c
> > +++ b/fs/smb/client/sess.c
> > @@ -626,12 +626,16 @@ cifs_ses_add_channel(struct cifs_ses *ses,
> >
> >  out:
> >         if (rc && chan->server) {
> > -               cifs_put_tcp_session(chan->server, 0);
> > -
> >                 spin_lock(&ses->chan_lock);
> >
> > -               /* we rely on all bits beyond chan_count to be clear */
> > +               /* Clear the reconnect bitmask BEFORE dropping the serv=
er
> > +                * reference: cifs_ses_get_chan_index() dereferences
> > +                * server->terminate, and cifs_put_tcp_session() may be=
 the
> > +                * final put that frees chan->server (use-after-free).
> > +                */
> >                 cifs_chan_clear_need_reconnect(ses, chan->server);
> > +
> > +               /* we rely on all bits beyond chan_count to be clear */
> >                 ses->chan_count--;
> >                 /*
> >                  * chan_count should never reach 0 as at least the prim=
ary
> > @@ -639,6 +643,8 @@ cifs_ses_add_channel(struct cifs_ses *ses,
> >                  */
> >                 WARN_ON(ses->chan_count < 1);
> >                 spin_unlock(&ses->chan_lock);
> > +
> > +               cifs_put_tcp_session(chan->server, 0);
> As soon as the lock is released, a new channel can be added in the
> slot indicated by the decremented chan_count. Then the final put will
> act on the new channel. Please save the server pointer under chan_lock
> and use that for cifs_put_tcp_session().
