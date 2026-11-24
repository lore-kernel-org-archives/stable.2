Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540279;
	b=fJqxpsyMOLV9x1mkXflFTG/VGus/KV+KiUwx//rhATDVygo7gP5fsTqDqJ/7rlIZGwkP
	 NiDyOGjaSuLmIZ0GP5iyDtAkTDZ+D+fjyQWnfdIOEp5noZXSq/wlDLk/azfWLLsk/6aZv
	 Ib3A9LKG8x0Oei10GHRjEa+aaIpeBRKzR8SDQszj905wHrgjRCHyYueCHgNIDUPouE3w/
	 VjM5aLRzWzW7HhzcxcifquFBO6CrdQxTn5KbvFCPHQy2C08VVwE9kV/4Ep9V0IIx37CeM
	 806ioahKAJD8J63M7sax5Mlac0HD/AxZqbI3/OnAspjkdLxYalj95sEFeyLDH86cZOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
	b=I20HlDmi84mVceuW95LnsYBCphuWSuZOVb6646eFTVZx0cyLF1p8EUgQ1qOs7E3klSW4
	 EfOy47ecm4P4Fxi3Icc/erkYHBSAv7Joy+UX+kihmPLTaIkg4w3IXW8XbCMhlGfitybax
	 1IFv/OOjwXOuvgui1XoKvqLspPDm+RgRUQm1ELweCNjJ7Arj9e64kZLRIQ+rbjBx8YYmT
	 SaBg6Fvc1KPzBZe/UR5RWoDVN+JUMQEv5+X8dqvhjdrlXyiKZsyGB65f+9tfYclNNejas
	 arph5/o4RTOB21JF7/mnU3XMfE7RUevC4QlxcxrXeaOAlfcB1PblZYV1Nv0gkqc7Row==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aKkNx6z8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87A606A6BC
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F87A606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=aKkNx6z8
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8c20d68c83fso3174959b3a.0
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 09:11:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540277; cv=none;
        d=google.com; s=arc-20260327;
        b=pgTg5UfuadbbnWJBcxS/b9riCraZ8k1VPAbInesAQf+gJLW9b9NK2IhxAC2gVxu2Vy
         QM29PK7EhrB9wTqTVgywA4Vi7wGLsIoUkPZiXmfmSZ3885H3zYMvsJ+N/ZTLI6psMjy9
         +xBxQRRM+GcoKzVE77OCIVDVwPbzpvpLTfe8sMzdSaqrLu5DPyo0r2IrLNBWB0wvs2Jf
         zYAcBye2gDMaKlqNoCCgVkH0Av5w5aePYOlJn2o3WqI/cQCTELiCw+mCLIjUSUdcShgz
         SGMnz5H+HfeTZyDurFzi4GBaZrdrrU61z43k9M/sXiT9pFYYCH0hPECcDiqk3FOQxzgy
         DMrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        fh=ZY/YqAs0e2yVOU3v0ae2J2Cz0rufVghT4cU9y2hmzTc=;
        b=iEltMfMeBvPD8SC1VjnWw2XLRM031Z9h5/9uU2HBjcwmxVmjelIzWUv/2aNj55vFlX
         Q6GZuKbQo+QtO5bT0Syy1iOyrI7VsVq5aCkT/12DG1u4VW4tddda7vPrjCgAhfR+HaPU
         prBgHX7lG+ZSphThdZCExo4/9GBG2+O1pmr9D5rk29vyZOgyA6qdK9BXJhEjDCH79mul
         sd6gLNmSh0mfVC25XEif3RVxmlnWxdWCe8aII7zFs0VmYiSP1FtB7+ky/rJl8HlYXHCI
         93RtFEFYb5FX6iSZirEzNupOaNyAW4BsP0tZsDb1ndWVf8DyWtim7j5T9a7ckls9umZz
         cBvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795540277; x=1796145077; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        b=aKkNx6z8zf1GFQJFVfRbdvXUoIdS76x/L8IotURk7AtYZABQ+Agu7L2ft+MyU/oCZ1
         8RacuoMqNGIGTKMEeRMuCym+SPEGH5myefDjMl6p2+1MlVUqXgckoKAsD9pE9oVD9+kj
         iUp0zCdOOqhicYBxWhfEqQiaYmS7KKQeO9daw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540277; x=1796145077;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ke4DMY/5oHPgUmAeqSFagfiX14Vkl9nfeTs1w7gvuG8=;
        b=Z+KYWuG3khTFmbZT9pVVL19hotgHZQjpdYlij1gYZW/Ot1mVgDv5ouV2j23gfVMxVN
         113aC86IpjuATXrWx9u9R/gymeHUnAPFqzk8XaR/IRqOWeKW05uP+lkoYbaI8UMaQNRk
         PwtJnsIsL9XFXVkUIT/o8E9j4wkXyYAANGz2jRjl+j+JHVEETU3MU0/u42xC7C73ZBWh
         4m42KfoYFXBH5qhc5DMQ/YWd6YdH/JYPvaa4RAvY6n+Fu1qyfsFa9HIVqxFJ+g1mEnIN
         yzFq5usAbHg7TYdi6GBe5EdeC6BCtJQIcKqMYyK3WlJ3HkzlfgK7RbMMFjq1HWBoT5ZM
         6REQ==
X-Forwarded-Encrypted: i=1; AL+hErEPsNOf4UQCsYf23lmL1UosvyLZhV6XcKz9Qn0PAFMddSD3fRo2ymY4pxe5qZiXjxYhlb0c4mM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KMAHO++55ReswsvuCrqAjO1Vi50Ftlh+B8rX0MXBwoqcNpPKx
	lhr8n3uzneebXk2xZQPDnD9Z066uP8yAORbtJjWKLF5xqJlvJNLJOESGNh5ogjGk0evSXemiOEa
	NINbi+ibg67yybVU/iAqg1lJuBz3+r5GOJi7bVec0
X-Gm-Gg: AZFdTZdmtPPwJPMcsTEpstItvsGWMTVnyDp6499T3au3lT6mQQxDmYtThj87L96D7Rz
	NBKscqPI2cRaEOTFui4SqaPk7jjnJLTEGwm84NYshq3ZJjKoGdX2KQI3vha+hQ6LVlobAMfO6Rq
	5UFPz9Lj0dvnORt6k5LrLr4f70WZsZDRKictpIjGvcqsGcbtHgtNbBpwe3OrQFVpYxxT1FcFdVb
	f5qC6eZ3DS/dTX9dqKfS0/FU/O8u5I6qf2R7qAI8q0MijC4DdU7HJVFATVQQCAzPBe+Rml2TeP9
	S7lVFculPJH7ORKKpxHR6Fe+daf9vlnKq5go4YZFdEWhE+cRpFllPjUQD6RDlIFIdw/3e9hyFK4
	RUWyBtcRfj5WuM+U/UTnGQP+yk6Hn7pM2xFxP0S2rrHZg6OUuq8+5diQC5JhbIaJkAhadq5AcX1
	2PU1xP1HzbHHj65to=
X-Received: by 2002:a05:6a21:e089:b0:3d8:e57a:5a5b with SMTP id
 adf61e73a8af0-40149f7bc79mr13550670637.5.1795540277488; Tue, 24 Nov 2026
 09:11:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-WEXM.v4.r0.20261124074514@mojatatu.com> <ACT-WEXM.v4.r0.20261124074514-2@mojatatu.com>
 <20261124161258.vLyrm8Y4@linutronix.de> <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
In-Reply-To: <CAM0EoMmMio4kotBqbcJmFtf_c3Du=rhfvp+sMiAd0fHKowv6Vg@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 24 Nov 2026 12:11:05 -0500
X-Gm-Features: Aa3M54oig4IWsvcX3iSlWHrklygop5_tvIrr2s7WuHfHlt2lcJnss6T7_wTd3Ko
Message-ID: <CAM0EoMkEjxCo6K9k3MZH0U+3na9soMNE0gouddwOTzUYXcEunA@mail.gmail.com>
Subject: Re: [PATCH net v4 2/3] net/sched: act_gate: refuse schedule entries
 shorter than 10 us
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-rt-devel@lists.linux.dev, Victor Nogueira <victor@mojatatu.com>, 
	Po Liu <Po.Liu@nxp.com>, stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 11:58=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Tue, Nov 24, 2026 at 11:13=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2026-11-24 09:12:09 [-0500], Jamal Hadi Salim wrote:
> > > This is a followup of commit a51c328df310 ("net: qos: introduce a gat=
e
> > > control flow action") as reported by Sashiko.
> > >
> > > The issue:
> > > fill_gate_entry() only rejects an interval of zero, but that interval=
 is
> > > the period gate_timer_func() re-arms the hrtimer at, and a few
> > > nanoseconds is below the cost of servicing one expiry: the next is du=
e
> > > before the current one finishes, so the action holds a CPU in the tim=
er
> > > softirq for as long as it exists.
> >
> > The timer is programmed in the past, fires immediately and hogs the
> > CPU.
> >
> > > On a 2-vCPU guest, entries of 1 us and below hold 86% to 90% of a cor=
e,
> > > 2 us holds 61%, and 3 us holds 22%; from 3.5 us on the cost falls to =
a
> > > few percent and it reaches zero by 100 us.
> > >
> > > The Fix:
> > > Require at least 10 us per entry.  An act_gate schedule is not tied t=
o a
> > > device, so unlike taprio there is no frame time to derive a bound fro=
m;
> > > the bound has to come from the cost of servicing one expiry, with roo=
m
> > > for a kernel that services it slower.
> >
> > The 10us sound sane. With enough debug (say kasan, lockdep, =E2=80=A6) =
this
> > might become tight again.
> >
>
> Agreed. Unfortunately, there is no way to derive a "good value" here
> (it depends on workload, machine, utilization, etc, etc).
> poor choice of wording on my part - should probably have said all of
> what i said above for precisiness...

And now that you bring this up - this should really have been
targetting net-next not net.
I dont want to resend (unless sashikos find something sinister) - but
Jakub/Paolo consider applying this to net-next instead when the time
comes.


cheers,
jamal

> Cant wait to see the pedantic nitpicks the sashikos will get about
> this. Regardless if this is all they came up with I am not resending.


> > =E2=80=A6
> > >
> > > Fixes: a51c328df310 ("net: qos: introduce a gate control flow action"=
)
> > > Reported-by: Sashiko (gemini) <sashiko-bot@kernel.org>
> >
> > There is no syzbot report for this?
> >
>
> It's in 1/3
>
> > > Closes: https://sashiko.dev/#/patchset/tencent_4ED9536B0375C96183B224=
4CF7709768C605@qq.com
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> >
> > > --- a/net/sched/act_gate.c
> > > +++ b/net/sched/act_gate.c
> > > @@ -25,6 +25,11 @@ static struct tc_action_ops act_gate_ops;
> > >   */
> > >  #define GATE_ENTRIES_MAX     1024U
> > >
> > > +/* An entry shorter than this lets the next expiry land before the s=
oftirq
> > > + * servicing the current one can finish, so the timer stays permanen=
tly behind.
> > > + */
> >
> > No strong opinion. I leave this here.
> >
> > | With a too small interval the next timer will be programmed in the pa=
st
> > | and will fire immediately.
> >
>
> see above.
>
> cheers,
> jamal
>
> > > +#define GATE_MIN_INTERVAL_NSEC       10000U
> > > +
> > >  static ktime_t gate_get_time(struct tcf_gate *gact)
> > >  {
> > >       ktime_t mono =3D ktime_get();
> >
> > Sebastian
