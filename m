Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793135043;
	b=hl5dngm5pt7mdJeaV8CPkyhgH7ejlM1ipCo3bq77KD50/iCDWA1FT0gnPWN+U0pyaBdC
	 47wMudjG0ro2ErWISUR5856ryV9enAvCyvMkedS9E3gTkzLhp8algGSsRqkBeYTPp7D0J
	 M0Z6mjlkIQSJhyoTn4xsN7c5ukD1KAHFjJ1Cx8THh72sCUadYAbVZFIiK9fdcCkmnJZre
	 JWZA0A+bX63hoOJSXI2HYevvpYwkZg2J4wYGL16MTAXG5nN+EjTtP8AOdFrWoH1x7enyG
	 Uadvv0aIQqp/CAknlUEsFbUn2z7d+bhwTHnlGrj489mebRWAfTy5mzr5434RbmR91Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793135043;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
	b=TVnHadi1HW0rSuiw6/izogMMTFqVq8kvitgF2ip6SZxKDAshmm8PnCGqFuYlLwal0QjQ
	 D3q1MVtamY0zu1PwdCXYZsfYQGodo8oaM98exbLen5IpKfVVWN66pv/FzoC6mWw85Xvbi
	 r+HmLQUjp/IXDkVtu7wQk8fWXl8ZUr8JSaqHkL15lD+kYWx3AnPyvf2zqWlGhz1rh+SPO
	 x69MQ9UTSKnNNDbAZCPL5StNCqk49huze9wrYUCxBq+3lcdpcup9n2oLzFSFXY+0QU7WF
	 YpCOW8rVHn2nw5ZoibPMFEUyc+DigEODtKi2Wu4tBMs3Xk0p1S6JABTWt6zTZNVpIyA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vM069MxS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310A606A321
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 21:04:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2310A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=vM069MxS
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so236296b3a.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:04:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793135042; cv=none;
        d=google.com; s=arc-20260327;
        b=YjaiInhChq7nSyTaIaGxYGVhbPnKNNR5/cM1Rixy45Bg3CCd0rlGnWf2eCU7fkYJYc
         dH8SFYLbrNvt8Ul9XiwX/gTnSZab0GKgaVsdQsXqcfkJ436+g0U51/Rly4C2pRvAq5oG
         Vgij2JPh7LI4G6PXkHRlqt5xK7oBGb8L6GRDtZZoJTcQsdb6bBfmiR/6Q3ss1ztp+47N
         cqG9sBhKMXQgmYECc6qcZvcLQge2F8bJZ1X3sLylzac3euA38sbg47iBL3kdPdR7XdY8
         W2MFqCnxxKBvIl5BYvBY8CT+S3SFmjuXNKlMDVC1ZAudebFXwfPYNDng8RZn6rxFfZji
         VLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        fh=MqPnrsyUcMfBAu8G/i5jLzZ0Vsbiv6X9PFpqtjjXUNg=;
        b=IIW30rW4tlVQ9+0e/q9jMsrEXKTz3V5NI33gxUvwvUl8TIHoIKTbP6otP2DC+0z4w/
         tnxhH6se2NIaAVqdELx6pBspfFV2eTTOiRF8GJfFSbzlusu+rjTtzAhVp+Dwq733v5JS
         PgIMadoh+argjC+yIb3zGv711/gJ88fDZ7rnkS45onX6hQV4Vkr/SFp0xD87W21j2xgY
         hsirL2Z8BMucuoaNwsONSadnn5NuiAIQgcHvvnScWUu47eyb7X8ioCZbzztpTbJ3cpxH
         rnKU/dHfp+AYKIb6WYzHTjoMiRIFnqLE3Xr4Gfjim+fqdXGUkAHXvPqLP4ob/erZ1GOB
         gMrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793135042; x=1793739842; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        b=vM069MxSM3jdj5X0BIYcB/sD/jnq7gSWYs+UECV3gLTfTKR3XywdrBrbbz9iI/ruDn
         KzKcXlNG2jvCwBtEmmBSKfMh9efBeEOOweCvT645hceEEALXnwmyoiuhVOuhf9Q6Zup8
         wHFktoce2QRLLZM+7zia2TF6OUGESgAOriaZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793135042; x=1793739842;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ak/cCAQEKHhz+YuYX+iPG+8fTfipPOcs1u4U9H1RnPg=;
        b=pVzrOTkRwK33Lrge9ONftebl2FQ3czbOuOrGmWZCds86h6hkn/Wko7U6/2C51ejjuL
         UifuXCekQEq4392gbjWmViv2IibbQbZzophLkttM0lrXkWXjxqJVESxXEBYE0wv4QT9T
         UovJHm2oF2kQrrul8evJeXgTEH2WKECtrUdx7VQ3BDsq6aEh044Xfj0NC8QlrcMU2eWN
         Za6VICtUtm9eOlfECHtxVi6VRaPxNkP9hzSGAnrGQg4FzLbbvPVUyzSzWAA63uC+2790
         KsLirvmLF1NvPbjNYQ+0cfc6ETZyIA2zGnVdV01lcvht/vLHBmt1KaIxTJplFPk9mYHP
         FZug==
X-Forwarded-Encrypted: i=1; AKwUvByHAdJI5Zr3EGqLrhsAUKgWXsw7nTkN9BYiu8LJYklWbjSpBoyCnQVm3K3eCfdIFF/agj7MEBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJH1SicG+5KLwl1UYBU9EH/ODcHTrs71VY46x9EqmsD+8d5ZQyu
	B1FXKamCgQX+4OVcNXB0yTNl11lG3jJC0XPO/Zy5eqd8w4dNJAlDkfEapLi98RJi5O/RPHPjXt4
	T0d9PW+76lG1+WtxikL/mts+9u0spuklVxwIjBqeP
X-Gm-Gg: AYBFou3wzRZPyy8Ws6K1TdqrkTwX1vnrWYDEIFrKif+T6TY0yGBKB88aQoN9EtvYcsl
	60lMRNeMWvXl9Oq9iMltRBYOd92/wmVFE5hzUqftwq85dBNj1L55rQmmDOUnboAubRpdX4KzfZQ
	7+ZbAi5qIVs4q09Icv79QWI+KO2X0B8g3a7ihWZbAI7m3lRtTQC3q82qaG5Ft0dOlLzkBs9dlTo
	OEnWYYYTX7qgv1lHrNqaYqiubAPuvNSWEw4R4yc9L3uDpKcMjAVcNXqVRdmM1Q3WyYsCVxT7v64
	CE6e3oPg6v4Ly1gLlFuGOKCif7xzWm8/polgrjxSAHp29fvUCnIu4t0mqiHu1ESpaNsXTFBr5fB
	8Zwt/cavjbiwUZdvHC4785eLQZqhb7npz7KQ7Yc6d44oNY1tdVw2Rnx1o8GJgHKL3hhkXNHtyd0
	xy+kIVmRPzNLNx5Us=
X-Received: by 2002:a05:6a00:b44:b0:880:973d:597a with SMTP id
 d2e1a72fcca58-8a6e7fbea5fmr385656b3a.53.1793135042355; Tue, 27 Oct 2026
 14:04:02 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org> <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
 <CAM0EoMkvbVZoG91==QWT2mfyPkWYsS=BWCBsK0iYJR9BP=aviw@mail.gmail.com>
 <CAM0EoMkf_ewuY4bx=MFNc0ybR66pLP3F8nZSCZBMW6bbXWoFOA@mail.gmail.com>
 <20261027182905.GQ257209@horms.kernel.org> <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
In-Reply-To: <CAM0EoMkym=CiT5=ye72N4s_zat6GF-ihN-Mk3hpY4R0YgAqFGw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 17:03:50 -0400
X-Gm-Features: AclHuK8WDz-9m21Tu6ynzCQN2XEQfhMrL7hiikqLic4FAAUgXHk123CAgRhBRy8
Message-ID: <CAM0EoMmXWO0BpKbngHNSUpdCBO1T9+2UQh27KD5H6aX1a+-DzA@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 3:45=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Tue, Oct 27, 2026 at 2:29=E2=80=AFPM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Tue, Oct 27, 2026 at 04:04:34AM -0400, Jamal Hadi Salim wrote:
> > > On Tue, Oct 27, 2026 at 3:44=E2=80=AFAM Jamal Hadi Salim <jhs@mojatat=
u.com> wrote:
> > > >
> > > > On Tue, Oct 27, 2026 at 3:25=E2=80=AFAM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kern=
el.org> wrote:
> > > > > >
> > > > > > On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > > > > > > This is an AI-generated review of your patch. The human sen=
ding this
> > > > > > > > email says "Hi Jamal, passing this on for your consideratio=
n as it
> > > > > > > > seems to have got stuck somewhere."
> > > > > > >
> > > > > > > There was nothing wrong with the headers this time - so not s=
ure what
> > > > > > > is going on. A bit frustrating.
> > > > > >
> > > > > > It is frustrating, you are the only one with these issues.
> > > > > > Patch 2 is posted in reply to patch 1. IDK what else is wrong.
> > > > > >
> > > > >
> > > > > Let me send a repost3 - will take the opportunity to pedantically=
 fix
> > > > > the commit message (no code change).
> > > >
> > > > BTW, checking i see the threading was:
> > > >      0/2 cover  (root)
> > > >        1/2      (reply to 0/2)
> > > >          2/2    (reply to 1/2)
> > > >
> > > > I checked other postings that didnt have issues and it was fine. I
> > > > also found the approach
> > > >    0/2 cover  (root)
> > > >        1/2      (reply to 0/2)
> > > >         2/2    (reply to 0/2)
> > > >
> > >
> > > And for repost3:
> > > - 0/2 (root)
> > >      1/2  In-Reply-To/References: 0/2
> > >      2/2  In-Reply-To: 1/2; References: 0/2 + 1/2
> > >
> > > I am sticking to this approach going forward.
> >
> > Hi Jamal,
> >
> > It's unclear to me if the threading relates to why the NIPA-Sashiko rev=
iew
> > of this patch-set didn't propagate to the ML.  But I would suggest that
> > however b4 handles threading would be a good approach top copy.
>
> I looked at several patches that it didnt have any problems with (some
> merged already) and it doesnt seem to care which of the two approaches
> used. But i will look at what b4 format looks like for completion.
> I am begining to suspect it is not the threading, more the repost
> approach. The "repost" was not including any code or commit changes
> and it seems to be problematic even when i changed the message ids. So
> likely it is only paying attention to subject versioning i.e vX or the
> body text. I added modified commit text this time on all 3, so lets
> see if that fixes it (caveat: the Vx didnt change).

I dont want to claim "mystery solved" yet, but Simon's forwarding of
sashiko for "[PATCH net v2 2/2] net/sched: sch_teql: fix
use-after-free on lower qdisc" triggered me to look at the sashiko
site.
Sashiko has some "email_status" field that is a per-patch field.
Both patch 1 and 2 of that series have "email_status: Muted,
smtp_enabled: false." which means the email will never show up even
though the review has happened unless a human forwards it.
Likely a bug on sashiko or nipa - after the embargo was lifted it
never allowed the response to show up on the list.

cheers,
jamal
