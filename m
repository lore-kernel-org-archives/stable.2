Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAC1446042
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 18:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784226090; cv=pass; b=ta5fKuZRglTdVQ/sYTOCS4iumW9qzF+0z71lj7v2dgUhYukK3Rl5laBt69kcHKoUQlu5G6gb9a0ZXX0NIGN+U8updCtj237ZQ5qMzER9KjGoVbFVncM3ZyNxASzlyWZRVHHgweGp+69zptV3r41ORwJVN5+7eIxepxXTJvwkeoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784226090; c=relaxed/simple;
	bh=EED7I6Cgzn4Siqa2KZnQb+9Uj22ntNVGfKi9KJsb2QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t5eenrqVhHKcE+/sJHVUGF3L3QSlQ+bTQYVKE5+JGa1m2lhVsnaOjF3s4IKlqTkdwzNR1IWAP9cfUJBmTx09732jTTbdT6bmRxKrUqG5fuky8FZJ4Zn6JLwB3N3LmlAwxOv4J2MJUkGvoymKlHjYCCL20+GrtmA28iMHgrPtJMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oe5dnp+g; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oe5dnp+g"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493f45e206dso4055125e9.1
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 11:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784226083; cv=none;
        d=google.com; s=arc-20260327;
        b=Fj36skaD3Fy30hgxp3/be5jOKqXYKdEECgZ17u3RdPhaV22AbGkeCMOsG2Dc4xbczq
         CD/4J+bY2f+dJTRzXDmA/9ei5OvGik37frIjKWgB9r1HSoLwrQbbez0zNOJst0pgQjrN
         JraxbEJ50l/8q0PcxshKJEAuRZ0sSUPY+m3NwdJAlcCYiAbIJl8ZOdF4d47i8hHnF2hH
         dT/3agn3UPAoyEGaq5aEkgWasrrR+pvB9bxpr80CD1XvsSq8sHlxAKR1tsexpS8xseAP
         QecW0D6qGVDk+3vrnqO7R/9W8qt3BxkQ2ye4IIclFhmfCbLpDLvbjAYtaZGLEkJhsKYv
         VvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CCALGBJmvNhpJ4X8shKHWQmC/dAzM5grVkNM/sgcff0=;
        fh=RkkLPc/scOAwVEq5q20D3Xy5WktYTVelNMyOUN4ctxE=;
        b=RzotW4bzeqAut4IJs36mTc0aCYMw32XhQZXDPZTHaLImJQReoErhSKv424LKJdL6T1
         aVWXWjXi3ueUgK5p45CyzyLzInGiMQ8SpzeUgmuPkuSv320reFVWIIfGO3edVqObfSyA
         xRJG0pgbICFOkTaUce7JWcaRh87t41RLbM9/sYxhn2TPHTev4DKiN9+XbrZ290/ZBG6Q
         5+L4a0NO1A4CqIJzHeuTi4DTdIIBGJOu0n9amhIWW+RYzfZpUGtMflbo2Q5tgcpPcylo
         3GdyJiTKLI67i06tS0fW+kDhIDxWfCV9X/4DGs1KJ8zSppfJqz6YKVWCTveJPLRuC0VO
         70+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784226083; x=1784830883; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CCALGBJmvNhpJ4X8shKHWQmC/dAzM5grVkNM/sgcff0=;
        b=Oe5dnp+gRPMhlEkPa7RPST71jIx5lQmOsjMTHSnN4PNDRtDrNKPk0wBj9OdWn7RaTG
         +N5P55dUoTo7xuzWfWVqMTjfa1LdG8m+bj+wrq2WFukyL4t9/4ANnpXyarwfD6ULJEMg
         OpLQVu1VHZRj2UqX98k69N4Mp7xpEFmWi5q8gXFShPZCwNQ9zRAbPNRZ52A8enoAx9iv
         KWR2fCZZO5cUSTgPxDKDKwE0lEAoqlf1SO2h4savrZ/w6L9LiKUwStQ374dx1JDJ2Dgk
         3xY3AqTlWv5uTwMhNQrHDGAYmJy0pKyrOAf92ny8FxAnphePYBBgH/lKDzRq9nMV7At/
         t4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784226083; x=1784830883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CCALGBJmvNhpJ4X8shKHWQmC/dAzM5grVkNM/sgcff0=;
        b=lvHhtGSB+d3y6K6tLALhhLWn4cq1DhcbND0L94sezZIYwtMeeI/nczbxubpozqZgR8
         WwzzAuweFCvV83r9EGTsiduAlXKoqOBbem5Mb0qjB9VRzBYnS/hUxDA0GDI4OpVf2+XC
         csz5zxwvLbxV9pIqyYIM74X2o65ILcX+vuKo1KuXXikTkqQ0OYSloV88Wyq1z9zuP6ML
         ubIn4k655pzWRfV7CPkUXsVYadcvyF7CgP4pFidwyygPupfj8Sp5x7atdd4XyMSfsiBW
         HvoGJne4wY50lIcNh33E9jTT8zs7cjz5wxSkKKdjrh1eZKeBmlPVhNi5Ujesg2KwXVto
         uCDw==
X-Forwarded-Encrypted: i=1; AHgh+Ro267tRWrlEZRdIBRQEkmMgyyW4hH6t1HdD/OTwOkqTBYY/GVuQ+Cz1zcFXvOLqfyifdALAQW4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoT4Gzj0Z8iA3YCSm/pGVLsynXzZGkwcKDzZC3b6LqjFUpUeaE
	tsMYe2KGLNpwoJGoLpjURKYCwc9RIiycRDn8zTN2txZzGEpbJyk6VurVo52PAq01qScp8McANjT
	ukT9ngjs84+YHsXSD78kdHDUPD0KM4sI=
X-Gm-Gg: AfdE7cl4FKt3Dr3aFP268Ubej/vp6KuMYhfrp5HNx3BsrETNj8VrhG7dJ/Fx6cM5USn
	LMuCHAcuyaSpAoFxChJ3kULmNv6M1CMAQNVLtEnXy68BiVI8e0c/Uu5u/hrT4hTthRNq+ILjbVr
	n9g1JhllFVkzmA7udbo40yoqBsJcfXvY6p1iDXP1h572hZcMVD9VppE84aeS1wS3fd9S5rKYPbd
	hyUwj75G18q5zoIsGLPNrKJYr4nKdlpGQ62QBY3rov2RMzhYRU4TmeqlG3dLd0fG2HvuKpWLAUt
	cFrOEIwVzkVBw2Y10ecH5Pzk1hph+3wNhgfKl0M8+A==
X-Received: by 2002:a05:600d:104:b0:493:e49f:1541 with SMTP id
 5b1f17b1804b1-4954288e0d9mr33683575e9.6.1784226083225; Thu, 16 Jul 2026
 11:21:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715174305.336261-1-joannelkoong@gmail.com>
 <20260715174305.336261-4-joannelkoong@gmail.com> <668fa6c6-ffe0-48d1-aed6-f86a7353187b@bsbernd.com>
In-Reply-To: <668fa6c6-ffe0-48d1-aed6-f86a7353187b@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 16 Jul 2026 11:21:10 -0700
X-Gm-Features: AUfX_mzTmBWvWvRDl--8ldti_PXiikTVNGTCFrDr1F8x_VSuZf0_na-Eu9y__mA
Message-ID: <CAJnrk1YCSmK=7UwCsm8KF5kvndk+zM655whcHt85oKbpse8XYw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fuse: publish io-uring queues with release semantics
To: Bernd Schubert <bernd@bsbernd.com>
Cc: miklos@szeredi.hu, fuse-devel@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:54=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
>
>
> On 7/15/26 19:43, Joanne Koong wrote:
> > fuse_uring_create_queue() initializes a fuse_ring_queue and then
> > publishes the pointer into ring->queues[qid] with WRITE_ONCE() under th=
e
> > fch->lock. There are several readers that may concurrently be fetching
> > that pointer locklessly and then deferencing it.
> >
> > WRITE_ONCE() doesn't ensure ordering of the queue's field
> > initialization before the ring->queues[qid] pointer assignment. The
> > queue must be published with smp_store_release() so the field
> > initialization is guaranteed to happen before.
> >
> > Readers in paths where the read may happen concurrently with the store
> > need to use READ_ONCE() because any race involving a plain access is
> > undefined.
> >
> > Fixes: 24fe962c86f5 ("fuse: {io-uring} Handle SQEs - register commands"=
)
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> > ---
> >  fs/fuse/dev_uring.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> > index 51f985154aa1..bf9d51f2a508 100644
> > --- a/fs/fuse/dev_uring.c
> > +++ b/fs/fuse/dev_uring.c
> > @@ -321,9 +321,11 @@ static struct fuse_ring_queue *fuse_uring_create_q=
ueue(struct fuse_ring *ring,
> >       }
> >
> >       /*
> > -      * write_once and lock as the caller mostly doesn't take the lock=
 at all
> > +      * fch->lock serializes concurrent creators for this qid.
> > +      * smp_store_release() are for the lockless readers who must see =
a
> > +      * fully initialized queue after &ring->queues[qid] is set
> >        */
> > -     WRITE_ONCE(ring->queues[qid], queue);
> > +     smp_store_release(&ring->queues[qid], queue);
> >       spin_unlock(&fch->lock);
> >
> >       return queue;
> > @@ -434,7 +436,7 @@ static void fuse_uring_log_ent_state(struct fuse_ri=
ng *ring)
> >       struct fuse_ring_ent *ent;
> >
> >       for (qid =3D 0; qid < ring->nr_queues; qid++) {
> > -             struct fuse_ring_queue *queue =3D ring->queues[qid];
> > +             struct fuse_ring_queue *queue =3D READ_ONCE(ring->queues[=
qid]);
> >
> >               if (!queue)
> >                       continue;
> > @@ -967,7 +969,7 @@ static int fuse_uring_commit_fetch(struct io_uring_=
cmd *cmd, int issue_flags,
> >       if (qid >=3D ring->nr_queues)
> >               return -EINVAL;
> >
> > -     queue =3D ring->queues[qid];
> > +     queue =3D READ_ONCE(ring->queues[qid]);
> >       if (!queue)
> >               return err;
> >       fpq =3D &queue->fpq;
> > @@ -1035,7 +1037,7 @@ static bool is_ring_ready(struct fuse_ring *ring,=
 int current_qid)
> >               if (current_qid =3D=3D qid)
> >                       continue;
> >
> > -             queue =3D ring->queues[qid];
> > +             queue =3D READ_ONCE(ring->queues[qid]);
> >               if (!queue) {
> >                       ready =3D false;
> >                       break;
> > @@ -1191,7 +1193,7 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
> >               return -EINVAL;
> >       }
> >
> > -     queue =3D ring->queues[qid];
> > +     queue =3D READ_ONCE(ring->queues[qid]);
> >       if (!queue) {
> >               queue =3D fuse_uring_create_queue(ring, qid);
> >               if (!queue)
>
>
> For consistency, maybe READ_ONCE/WRITE_ONCE in fuse_uring_destruct?

I didn't add it because I don't think it's necessary (because
fuse_uring_destruct can only run after the queue has been created),
but I can add it to make things more uniform, if you have a preference
for one way or the other. I'll send out v3 with this change.

Thanks,
Joanne
