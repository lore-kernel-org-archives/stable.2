Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2013CF1FA
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 04:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788667730; cv=pass; b=eg1/NWYu0LxxICcB/2/uIr/o5ltT+MOtPtKHhi+kZpN8VyG+NgIrHMOaTfM4mKOk/5W8LO53X91nF3zAygxr9E09zSb8H6H9ncNeoy8KqMbZwbzrUfu0wMjO+nQGWBauohNy9oUMmSzLGSh70mygNe4dDnaqr0JmRBejFNo1qlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788667730; c=relaxed/simple;
	bh=eROzLL0q0ouiSUPHBo2yP9ODMUaFLLh+pXzP/8kVr4E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cIQFTlYgPEsBPBX1keX8iV5IU3L2ZoPC0XcJ/i+EVWQ6TSLXdUIy/xMHRT0tenp/SPhkpEO/ij1a4cnwRMYkZY02MZAHjUVVQ7aNgiBInQHq1pcDjtr+Sty/KjDpupKzTIRxaTy4G7ZHwIiehnYG1MxnsokWQa2ZAe71R77pSms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aUxEkIEf; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aUxEkIEf"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39c95395230so22444061fa.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 21:08:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788667723; cv=none;
        d=google.com; s=arc-20260327;
        b=dGYNccfnvp9/U5I8sKgiN3wN+E5iPsk+xZ6M4As96F9yFBBzx7wQeGaVCfBOdvya6C
         GVYoy1Lmn6aB4JtAdzLDU+P2GXswGe2q+WNcJdjk3TBwcjD7eyXkCdMfXJiQkZPF9f+R
         U/QP6YMKRG5SslKj+F1yfl4O7ga/rQxNqtkM+Y5LJJ1dgL0KoTXetWgPej5cT9y0bcPl
         If9QpT/4SWeU7/0DxDTGvDOMJPb6xcn+XuETLmjzsWt2/2fp/fP7y/bhvXbGXVvrUb6l
         066+FM7aPVOuOurTf+XNBFXKR7R6rF+NpUmy4OS6QAYsPXgYceLmEl3mSk/nDkOc7sVi
         f1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        fh=ea4H6OStQfCG1a/epMLI1ekR87O8mlkOAhx3HGImqZw=;
        b=F7Xao6bgNbZBZ4Il20nLqzS1nLLxGl5Ljz9Vq721kMxN2S+dRqCvZ6MmIdOWOFNZ1G
         Sim7cAiqh58OfszxdLk73xQuI4aoUsME7x3KI1rxdsydUbq5aH89YFRnjnjGxivMINze
         NKuUVP9JEOmXzqaGvANarQOuodpIYsXCCmnRVqjeq3K6Ep3dnUibWdzwH1BZsAynPQDj
         AFRxzjqD6j0rJEGCscv5fxEF3BCiVLhXiXIXhN0k13+8ZggTq5AFNyXL1/Mmr0YP+4Zb
         OaDWC/cj4MHKmjI/XXZqFID+XNqRZzzU/zw3X8Ytl/N/prY/2WG/PVtIhZhH/AxTawd8
         bwRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788667723; x=1789272523; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        b=aUxEkIEfst2969ukf+XsHqcWqNmx8Qv/9mKsnIk5iz65Kpsa/DOkmQ+0ItwstA9oJg
         W94mH/IExfM0KQIuvOmi7e6nG2IixkGIfC+d+kl82pN8sCrXGgvre09ea0jut1cwMFP9
         bVQUn4fUgCgzZz99FnXiqyocLr/CPoinfFZ9Z2SrGuM+6UaXvSH3+eTKenqILIkQq6YQ
         5+aW04f1+zYSl/MMnaAVoECL6P1OoN59Od99t/2sgVdttt/vlFd9S9ZLF08uPZFrEFNf
         Eku/EJTL0qQf7E24aMqXpcDiESceKYZDIjCfDmpwam5uZLUmOVcnxVCM3ZxzdH2+cIG2
         IuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788667723; x=1789272523;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/qnRZ1b/ThxLCDKg+XNGDfO9T1I8FVJXyvQjT9BlGzM=;
        b=f8pX2+X3u1BPGJMcjDWnFopcr40NgCywkAdhfikhkSLdIzXOKFpYL2bWktZLvksQoL
         TcN63uM5CKH3tdNgS+AuoK5vE4DYne4LrnWVU10h2QLOOUW11ohtSM2Cx9CaFSfV49n/
         9LCKQikBeMffL4Slek38Vzr2jffR4UTGeYVbSKnW3TygrAm3NxzWC4o4JUkZyRDZrZAS
         XlMadA1ydavMMAI1S5ahCyH0VyuI2lNUmXfrSXdHj7cp0/u/3T6DSHjK6O97nQz51iSE
         Zu2iuW/pdL/bjYwp3ibtZ9e3T0w4EKbF5zg88npv9CVuUdrhQKZ7gpy+0K/IjjrUhK3f
         8N8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxP5qtBaBXG1WJF+QOE7dSdBVRgDjxV2h2JAuIkPXQwfWFpzOQ24wvgQrF5STraynDbfyZb57U=@vger.kernel.org
X-Gm-Message-State: AFuF++nX9ra6gPI9gnp83lKzqJbuRaoWFdMnGnDKCH7KAW5ilqFo5mwK
	koNyo3PMNDvt2ZPf8VyetvUygmocr+v/KzIXRldnRdHucyHh+eAPRSsPmIpWWu1CrAp6XAJMgny
	iQebQfaJd0yofcaaic2Jl4rBiw2x3Z/F1xYf1tIZ2MPY=
X-Gm-Gg: AYBFou3G9mY/2RRA9QXQEUFuJBp9a+qiRd6FR0K9Ly/TmeWzsLWvlLVuIBhlsE8BXAL
	17WHJyAFUS8I3jsmvHHMQS4CDUVNSZ5OzhyA9Omcu5KPdSOT30/HDPDlzFN4sAzmpVFkTWI301v
	aovRNKmVD1C2+Cin39+NE10PrlJipPp/LD8tclWLn/4zZgEl74g0IhSgTzuHJEox7apv4zQjx74
	h0AWNKP31dUzZUtAwW2MOGfNDdFhEDdAzKK7L++/heU2ZqFZ1Zcly5vRBVAMxOCTS1Iss9//qd6
	GYlAZEc5xyWJJPDdcKENp56qC767NuqJIh4AvEEmJc7JggcSghECWLFvwUlLXld01VHhQoTQMs4
	=
X-Received: by 2002:a05:651c:2205:b0:3a1:4b92:76b0 with SMTP id
 38308e7fff4ca-3a371b5a644mr16405391fa.5.1788667722643; Sat, 05 Sep 2026
 21:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <133b6aee9e2c908c9da37d5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai>
 <20260905151227.75099-1-horms@kernel.org> <CAANe3eRpVGnYpygfiQTsXd2VmBO43P-P1RfREkdDypgXBZB9Uw@mail.gmail.com>
 <20260905190217.GE40544@horms.kernel.org>
In-Reply-To: <20260905190217.GE40544@horms.kernel.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Sun, 6 Sep 2026 12:08:30 +0800
X-Gm-Features: AcwNN1VTRejeC3BkfntBUh_MIrPvKzSvYUZPlMcVAjoUU_1YeMmnOwv8v11Td5o
Message-ID: <CAANe3eQ-N3fse+6hTJfEjHQT+y=xkZA6eYVeD--+k+fdhZC5Xw@mail.gmail.com>
Subject: Re: [PATCH net 1/1] udp: diag: bound bucket lock hold time
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, xemul@parallels.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 3:02=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, Sep 05, 2026 at 11:49:05PM +0800, zihan xi wrote:
> > On Sat, Sep 5, 2026 at 11:12=E2=80=AFPM Simon Horman <horms@kernel.org>=
 wrote:
> > >
> > > This is an AI-generated review of your patch. The human sending this
> > > email has considered the AI review valid, or at least plausible.
> > > Full review at: https://sashiko.dev/#/patchset/133b6aee9e2c908c9da37d=
5585b3d2cd016906cd.1788187473.git.zihanx@nebusec.ai?part=3D1
> > > ---
> > > udp: diag: bound bucket lock hold time
> > >
> > > This patch limits the time the UDP hash bucket spinlock is held durin=
g
> > > netlink socket dumps by collecting a bounded batch of matching socket=
s.
> > > It takes a reference to each socket, releases the lock, processes the
> > > batch, and resumes from a preserved cursor.
> > >
> > > > diff --git a/net/ipv4/udp_diag.c b/net/ipv4/udp_diag.c
> > > > index f4b24e628cf8d..18cfe0df654dd 100644
> > > > --- a/net/ipv4/udp_diag.c
> > > > +++ b/net/ipv4/udp_diag.c
> > > [ ... ]
> > > > +static void udp_diag_dump_done(struct netlink_callback *cb)
> > > > +{
> > > > +     struct inet_diag_dump_data *cb_data =3D cb->data;
> > > > +     struct sock *sk =3D (struct sock *)cb->args[2];
> > > > +
> > > > +     if (sk) {
> > > > +             cb->args[2] =3D 0;
> > > > +             sock_put(sk);
> > > > +     }
> > > > +     cb_data->dump_done =3D NULL;
> > > > +     module_put(THIS_MODULE);
> > > > +}
> > >
> > > [Severity: High]
> > > Does this module_put() introduce a race condition with module unloadi=
ng?
> > >
> > > When an active netlink dump for UDP sockets finishes, inet_diag_dump_=
done()
> > > invokes udp_diag_dump_done(). This function drops its module referenc=
e using
> > > module_put(THIS_MODULE) as its final step.
> > >
> > > If this was the last reference, a concurrent rmmod udp_diag operation=
 can
> > > proceed and unmap the module's text segment before the thread executi=
ng
> > > udp_diag_dump_done() executes its return instruction to return to ine=
t_diag.
> > >
> > > Could this result in a kernel panic due to the CPU attempting to exec=
ute
> > > unmapped memory?
> >
> > Yes.  If that module_put() drops the last reference, rmmod can unmap
> > udp_diag while dump_done() is still returning to inet_diag.
> >
> > I will keep the extra module_get() in udp_diag_dump(), and move the
> > matching module_put() into inet_diag_dump_done() so it runs after the
> > callback has returned.
>
> I think that the fundamental problem here is that managing module lifecyc=
le
> from within the module itself tends to be unsafe. I'm not sure your
> proposal addresses that problem.
>
You are right.  Keeping __module_get() in udp_diag and only moving the
put into inet_diag_dump_done() still lets the module pin itself.

> I think one possible solution is to move the module_put into delayed work=
.
> And another, is to move module lifecycle handling into the core.
>
> Possibly the first option is cleaner as I think that only udp_diag
> has the need for this.
>
The extra pin exists only because the dump kept a socket cursor after
inet_diag had already dropped the handler.  I will drop that cursor
instead of adding delayed work or extra core lifecycle state.

v2 will bound the bucket lock the way tcp_diag already batches, and
leave module get/put in inet_diag_lock_handler() /
inet_diag_unlock_handler().

Thanks,
Zihan
