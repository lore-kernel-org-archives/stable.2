Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F463D5679
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703579; cv=pass; b=YDm+Fvte8baxSSrFH4aASDb//zkln3lUGkjyHBRwvy/kNmJTZPItGHvhhVOugvnQzHvr7MuVX3dGwAFNH0YsaDz2GCylr0xa0Uqmo//4cbw4klnImjKssEN+w6NWmaRbnZSu0TL5xFWhJZkKelKw8tfIFjF0eJIAYCj0Du1OIt8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703579; c=relaxed/simple;
	bh=h7jQ/799MnzhF7pM7CmcHPw4JikTnVVFN7Ea/1Ax3Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t512wBJviHv4elgDRPQ0CMm731WMOtbR8dTDHl/S5qNOwaoGGHJaeSe4OUe/XnWOAj12TUni82RzZRlowbbJZCHP1Ki2QlQVjJhJe6X293Z+/wWjeU7Zcrs6ErC+RuwIpLCF+qbPgjBsLrFfm4BlHcsy3WAOLfTR3EXTMJRmD6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A7JYncXc; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A7JYncXc"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b211ee6aso17924765e9.3
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 16:52:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780703574; cv=none;
        d=google.com; s=arc-20240605;
        b=LrzHEjHWWymNAsiwBRX1j3nCFTx0pY2zUq/tLnMlHqgMKhxevlE7rcxpzWK/zW/pQ0
         ETsXHiAPmpnUB429cfLxTgjhCkh5K46ZNGIYcF/sZ1+cx9pFra/J0sYp2wqFFtHsQC2B
         tDOLZ7TppjeO9YIH9rduNQAIe6hwbA7tF4hOHcjRS3XT76oALuFGXA3+xLfEz5uBszOV
         ipTy9Efgu8dwD60KTBz6ZJKe3q9HJ0l8QqteMM5erok/ia+bwV/XnrNmSrsLOgTGH4PX
         3utu2BMHEhl3mB1QQh8Fa7BE3+tRGVOBvUFUjvCl0InsXHMYTAs5vMUZEivwSlJyY5wL
         u37A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QQ2aesgpMBNeafFS9klaQL11vgjs6VizkXGycGBMi8M=;
        fh=PLhD8C0mDIV4UAXwxDktD9xuDBpoLPsBHzYGva2SbG0=;
        b=lEMNnrsTu5zZhNe1K6o0gm2uMUmKtlb60gELQ6U1iXsdgZeTXzHMdqoSXdUCtMokaY
         sgOpOkAwFsP15+G8d2afMnpGAyjpeU4CCbJtDJRzyVx8D/mgOn5AcTJRNAxHsLdEv1Q6
         2xjs5HNeRBW+4mveVNAnV3k8vbQxk3Tzgip5sl8c8Wiu/7l9aD/jcuRoQVx8kUJQRAVv
         7Bx1reEndlVfGMimFPYTOWCXekjnanj0jcb1NyllIWegC7iecUsQUo70cKJSZ3/KKEev
         XxVUoLWAV9R6w3LOKhcqYKoLxG1DmoUeA4iiGEFiT2+atvPjUWYIc77S7HhJdPvLvZPA
         xRQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780703574; x=1781308374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ2aesgpMBNeafFS9klaQL11vgjs6VizkXGycGBMi8M=;
        b=A7JYncXcdI4QG3W9owSC4Gc+T7dZFzHTP9ELMX1SY9+fRJSTACusImr8gt1iLHQMLV
         MKbEEmAP+ZAUP6vE7+Aj5xGuxBFfOKx2qeJNYi6RJ0dTk/jTX8/DrYqONzWqqHz66oQQ
         MIvy4/PDNc60V77bdfX5DyfQSivKEklENjxX9NQY48jj2MBWGMvX9UvHev0niiZ8fF+/
         ovk6GTN06GLPcMAzDml/AUz8XQi7fPJHztpXBHi4qsfmGp8ZsaGRw2E7DF74RGO3w36d
         2CGMj83BhgXfizgwIbx9Fphk4E/QR2KWLXMNk0uT/VxWPm4CpogKzT31Uyk8bBMcWoFD
         z0mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780703574; x=1781308374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QQ2aesgpMBNeafFS9klaQL11vgjs6VizkXGycGBMi8M=;
        b=lj2vBsZMyIipBTjPcUtrmpwv2lBUqNGgVvdSst308pOU5ot8HeIUb+Ja47bfRC4FZc
         Id1nx/nj7DyRZc1OVtKZ5zoGM4KENdK6UCKmLux22g6NHx54NnNRVvV/o9VLbf4g/mZH
         fQULjprssNjw7OMZUVFpdERIajqxRJV/oGsAM5vFfyOxFFJIGYuVAS6dgjhX3XeSYKRU
         PX3xVkZ13qRGfa1nFyklxkCaDNEpVjOaYzWFgY/xEZwsZIFlfjnbIrEwwVC3zI2AApdT
         9FXKiR6+QCG+/xbFZOcc3mdhh+9C9Lb4dR7be78lCMc/SpybMtr0K/BJzwZ+IsJJHtZb
         gS2g==
X-Forwarded-Encrypted: i=1; AFNElJ+CSdIcLnE38lhJ+mKxraRksT4qrhfA731NjNd65ptgMUVpXPtZekAWJTtSY5Vr3pWqISyCVFY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CROrZyinhrWw5LhdUh5JC/tbb9YmoK/5zMYunbRM4/6Ur5im
	xsxywonKzS0VaqrO25NVKkJh8rWT0v3+fqvAoFYJQfQfMdwTpba2nuH2vxazzt82wsUTGe3Fn7v
	gMVMzYMdGpN/uYK4coOhbSDvXDh9kZjGsIPOXqHM=
X-Gm-Gg: Acq92OH1M/p8LetGsfMsywXcNV1xyGrC8hVQ5859Puq0Dx/5M0JFUgcLqn/hkGSaEq0
	i5isOB+HH/nZhcUxx2iUPBy0swJG3FsGJ/lCGW3hkvnO9SnTbjBpf/YiNKv21m295trU25NGFmd
	+0eB5KgQz/HrpZFG+zl94Q3oMUD+E3zJS+xcTrmUc5+jsKq9mYxM48/lsIQ79mmbnnpTb9wxVTE
	Fh94fDrl5My2HkO0JGNuxFHf6N6mzmjFNoljB3Hjf7/MF+ad1q95swPCj04YJnmQgiYVU6tPmWM
	MM9l6r7pyxt8xjX+MJpnhwJILeE=
X-Received: by 2002:a05:600c:458a:b0:490:b2f2:9aac with SMTP id
 5b1f17b1804b1-490c24f56d2mr107170215e9.0.1780703574033; Fri, 05 Jun 2026
 16:52:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605192708.141921-1-joannelkoong@gmail.com>
 <20260605192708.141921-4-joannelkoong@gmail.com> <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
In-Reply-To: <058fd2d4-3ba4-46e5-9107-3a7e0ab66653@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 5 Jun 2026 16:52:41 -0700
X-Gm-Features: AVVi8CeLJ75-2pKBCW7TL3OuVJRSkV7jfiZNNENXXNsOs4uK8aFbUIF90TpqkgI
Message-ID: <CAJnrk1YHQEtpwA-ForFWXsLntc950ekqAHg=L9VExVfJ2WF1Rw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fuse: end fuse_req on io-uring cancel task work
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, Chris Mason <clm@meta.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 3:09=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> w=
rote:
>
>
>
> On 6/5/26 21:27, Joanne Koong wrote:
> > From: Chris Mason <clm@meta.com>
> >
> > When io_uring delivers task work with tw.cancel set (PF_EXITING,
> > PF_KTHREAD fallback, or percpu_ref_is_dying on the ring context),
> > fuse_uring_send_in_task() takes the cancel branch, assigns
> > -ECANCELED, and falls through to fuse_uring_send(). That path only
> > flips the entry to FRRS_USERSPACE and completes the io_uring cmd;
> > it never discharges the ring entry's owning reference to the
> > fuse_req that fuse_uring_add_req_to_ring_ent() handed it at
> > dispatch time.
> >
> >     fuse_uring_send_in_task()
> >       tw.cancel =3D=3D true
> >         err =3D -ECANCELED
> >       fuse_uring_send(ent, cmd, err, issue_flags)
> >         ent->state =3D FRRS_USERSPACE
> >         list_move(&ent->list, &queue->ent_in_userspace)
> >         ent->cmd =3D NULL
> >         io_uring_cmd_done(-ECANCELED)
> >         /* ent->fuse_req still set, req still hashed */
> >
> > The fuse_req stays linked on fpq->processing[hash] and
> > fuse_request_end() is never invoked. The originating syscall
> > thread blocks in D-state in request_wait_answer() until
> > fuse_abort_conn() runs, which can be the entire connection
> > lifetime. For FR_BACKGROUND requests fc->num_background is never
> > decremented either, so repeated cancels inflate the counter until
> > max_background is hit and all later background ops stall.
> >
> > The non-cancel error branch already handles this correctly: when
> > fuse_uring_prepare_send() fails it calls fuse_uring_req_end()
> > before fuse_uring_send(). The cancel branch must do the same.
> >
> > Fix by calling fuse_uring_req_end(ent, req, err) in the cancel
> > branch before falling through to fuse_uring_send().
> >
> > Fixes: c2c9af9a0b13 ("fuse: Allow to queue fg requests through io-uring=
")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
> > Assisted-by: kres:claude-opus-4-7
> > Signed-off-by: Chris Mason <clm@meta.com>
> > ---
> >  fs/fuse/dev_uring.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 7cd50990b097..b5cc700575ca 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -1222,6 +1222,7 @@ static void fuse_uring_send_in_task(struct io_tw_=
req tw_req, io_tw_token_t tw)
> >               }
> >       } else {
> >               err =3D -ECANCELED;
> > +             fuse_uring_req_end(ent, ent->fuse_req, err);
> >       }
> >
> >       fuse_uring_send(ent, cmd, err, issue_flags);
>
> I think that can race with fuse_uring_stop_queues(), which leaves us two

Hmm, I don't think this races with fuse_uring_stop_queues() as
ent->state here is still FRRS_FUSE_REQ and fuse_uring_send_in_task()
can only be called for a registered fuse ent, which means the ent has
already grabbed the queue refcount which will trigger the async
teardown worker to run in the background during abort until the ent is
reclaimed. I think this adds a race though with the request expiration
checking logic which (a) fixed, so I think you're right that we'll
probably need the same cleanup here. I'll look at this early next week
and send a v2.

Thanks for taking a look at this series.

Thanks,
Joanne

> choices
>
>
> a) Same logic as fuse_uring_cancel()
> https://lore.kernel.org/r/20260515045541.1171335-4-joannelkoong@gmail.com
>
> (also introduces slight code dup)
>
> b) avoid the code dup and send it through fuse_uring_entry_teardown()
> with a bit refactoring. I thought I had send an updated patch version
> for that, but don't find it myself anymore. Explains why I never got
> reply. The old patch from October had bug, but I'm rather that I
> posted an mail with updated inline patch, not as separate series,
> though.
>
>
> Thanks,
> Bernd
>
>
