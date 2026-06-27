Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E61033A9E8
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 21:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782594243; cv=pass; b=nTu14QLNt1UeEI/15Ham73Fp8VBd4n7QUIn+mRLyZl36sAAR0FLF1Ik7sqQ/Yu15ty/0ENFJMR+FXHrZy2RKLOMzc/VPeIyT77hMy6b9EG4fCYJWg5iZ0BKDHGLoEsa0VyfWxVzTVJpN8AAdTSmGWFwAWT1JO7yVGi/lwo8UjNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782594243; c=relaxed/simple;
	bh=MFPTZmygDB5eIaofxE2nBy2zz3SCsiq382k9t8M2MvA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OElbWJcMzWW0oKaS8P7+R0bcGVC4ZI0ilNljB6jkcmI+SzN5vo+lDrG2P4HBrfyBRgJW2lqpKkhfFlL9KKABWjsbcpwhCsVEFDHWFnjmVK5BiLNf7RdzOXOcJGooPObWbKi7Zusz6s+mHSt39q91MZUST7hPCURYu/5VYvhquzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=v6SKBx+A; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="v6SKBx+A"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-845b8193c52so1647289b3a.2
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 14:04:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782594241; cv=none;
        d=google.com; s=arc-20260327;
        b=Ybs4pM2SssU+GUu01Y3nHbZuprZdACC6kql0l0UClRJ1OZI4Qr3PbQ6xNdzNbfkKaa
         jswzMRUeJCWh2fGxu7WkqSJ+B/IsKA5ySSnj0aLeSObLo6gFeb0+hP0FrI0T7A14T3lg
         dC5TnneG6fTYIgZBB9kNnA6Krd3XulkkEgP/5YyuPKU+wQHLyu3+M84NIqOr9Q9LYJmf
         wiWwjrCk6p0KJDFhz5rpj3wLPbtpWYQAQm5WuvTocMdbwhtub7PGRTCRqpx4A0J1CKKW
         56t+HtrlrjAdBearOf2l/ff9JZO0sTCpsDDm4PJRlMxqf9LIuHqey841hVpYDKhAfMjf
         sdWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Aw09dR/Zs90zrBnlxdIxEMTCBzgnoxukuT5GWdKhK6w=;
        fh=ghYX3FDqXIZfiYbNEX+FmVzPpAcRuC2h4p+jQ/Jxt5c=;
        b=sUus9ThiqG1tX+A+psBUR7ws5AYQewBGbwIfe4HbkcRugcDQX+K7SbULZKMdR67bUu
         VSVvCpSni1L/9QD+sBIpqUK7f1GcGiAJ7u2VNxsQscNf7LTFOccvO3SqBXkZqLnuvW7V
         c0Ugds88cFxeW1wtlrJYJ1DXss1QtdpGfNiA+r35YIxEK5GKmDX4cnAKu7KCivWKz3Z4
         zP949TF52uWsf/d5CMLbcB9L4MNww8moXtBMYKHU11pcxom/0t1xXJTTcNIXYv37PRwA
         KGEKOBjNoEc3IML8TQa3n9inry3i0EFWKJvjsLKil0iRwLyQLnqWoW+ddk3jiI+1AIhU
         iEoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782594241; x=1783199041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aw09dR/Zs90zrBnlxdIxEMTCBzgnoxukuT5GWdKhK6w=;
        b=v6SKBx+A1QrtP5hOa/+roT9UueRthHofkTXS3BfDJeFN3Ymq3nQohN6WjMDMuEuoCE
         viRPaCQMgYwuysjMIuAvFx7pvzvGnI94+zYcQiXTIcLVfiWgDPSROgNfHNnj/wiwP7Oj
         Sket+QH9klEprsv1JES9AV6iawBgQ+eyw3518=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782594241; x=1783199041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aw09dR/Zs90zrBnlxdIxEMTCBzgnoxukuT5GWdKhK6w=;
        b=OgcucJgYEfPSolY1gdbb+XB3DF4H7oUjj4gTRz/jGTZTQLzR0TFWOzP/jIZxXlylhw
         5ZlhV8q+g1vOuEIGW1QTcKNwuga5wsDXjftHMEV+2OwMtBjCnqam+udIuTp+yEg/W3j6
         n+U3SBtT8TUpaUHZf20xHGyBlZKQGFg+a6UDtXT8UuOa8rKUTXqso5skDlM3jFnNqWU/
         mhcSsRQ0oI6vqy9GZGumbrvIhwHanpzPlw7A5GkjN407pnfIgXaRIc0DHnBRgOGJDkct
         /POCLd58uT+DmM88/dRJMBsKBfDbY/6bF1S16u08sDflmF6heK4+Y4IdwqhxtB3hNxN3
         xVtg==
X-Forwarded-Encrypted: i=1; AHgh+Rpept8wxf5mMYEd3JvAxneqbvEylcE5q34AjYgqxMcYpTVosVCqpfxh+IGMO3p0Esk3lh8TxVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXoz2/EQCVqERMAB4o/Cy2UyicHebkIdmZpBOH5cmjMVrDVeKf
	YfYQlzEGjdYh0rPyadUe1rH/vsYXaNoXuqJYje0/7Fz8U0C0mYO0MuW9u46JmcU+NCSTXE7ecWF
	XM+64ry7lCryM5yb66VDircsBKrjNrZrb3p+nVP27
X-Gm-Gg: AfdE7cnDenCnMF9qSMegZFmYfGMCt0jL+KvaAo6q54sT9nrQXRmONY1sTFN3oZbXZLy
	1rhQoJMRdH5pCh7jpkCZwtkk8lAlZEaEJXW71XmhJz/WIuF2zz3l/PSkWnKBzGck4mHL0nS9O7T
	zcO/uFHyI7x0FQdyboOEDcrf9KihFRpq0QkV0+BftllGKQZ6PlpJ4qNVbK974SQL8rA8S9DFX3S
	SkzTg2W4wUtmFBrmkPxWXtyEEdaIrDN6Lzbd0sX9YyRUkV/QWUndmNv/9PtZWaaSlLBVQR5rjbP
	Cpb0odx3
X-Received: by 2002:a05:6a00:22d1:b0:845:e08c:a4eb with SMTP id
 d2e1a72fcca58-845e08ca873mr2238300b3a.58.1782594240806; Sat, 27 Jun 2026
 14:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624224016.24018-1-jhs@mojatatu.com> <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
 <20260626141547.GA1310988@horms.kernel.org> <CAM0EoMntFA+fqs_BgT0E_KSsQHyf0W0u7OTngHHB7icrnUiC3A@mail.gmail.com>
 <20260627163602.GG1310988@horms.kernel.org>
In-Reply-To: <20260627163602.GG1310988@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 27 Jun 2026 17:03:48 -0400
X-Gm-Features: AVVi8CcrCffzgUXXJ-TShlgaYV3gjj8Lvxm4KD3V_maA6P8aE4SdQzXXyB8yS8s
Message-ID: <CAM0EoMkr=1qj6LQGsi6JHnEneiycyZ5_aLCr5DLSy2cCp9Xqdw@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 27, 2026 at 12:36=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Jun 26, 2026 at 12:11:47PM -0400, Jamal Hadi Salim wrote:
> > Hi Simon,
> >
> > On Fri, Jun 26, 2026 at 10:15=E2=80=AFAM Simon Horman <horms@kernel.org=
> wrote:
> > >
> > > On Fri, Jun 26, 2026 at 06:16:43AM -0400, Jamal Hadi Salim wrote:
> > > > "
> > > >
> > > > On Wed, Jun 24, 2026 at 6:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> > > > >
> > > > > The teql master->slaves singly linked list is not protected again=
st
> > > > > multiple writes. It can be mod'ed concurently from teql_master_xm=
it(),
> > > > > teql_dequeue(), teql_init() and teql_destroy() without holding an=
y list
> > > > > lock or RCU protection.
> > > > >
> > > > > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is=
 freed
> > > > > after an RCU grace period, but teql_master_xmit() running on anot=
her
> > > > > CPU can still hold a stale pointer into the list, resulting in a
> > > > > slab-use-after-free:
> > > > >
> > > > > BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux=
/net/sched/sch_teql.c:142
> > > > > Read of size 8 at addr ffff88802923aa80 by task ip/10024
> > > > >
> > > > > The zdi-disclosures@trendmicro.com repro created concurrent AF_PA=
CKET
> > > > > senders on a teql device against a thread that repeatedly adds/de=
letes the
> > > > > slave qdisc, together with a SLUB spray that reclaims the freed s=
lot; the
> > > > > resulting UAF is controllable enough to be turned into a read/wri=
te
> > > > > primitive against the freed qdisc object.
> > > > >
> > > > > The fix?
> > > > > Add a per-master slaves_lock spinlock that serializes all mutatio=
ns of
> > > > > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > > > > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_=
lock
> > > > > around those updates.
> > > > > Annotate master->slaves and the per-slave ->next pointer with __r=
cu and
> > > > > use the appropriate RCU accessors everywhere they are touched:
> > > > > rcu_assign_pointer() on the writer side (under slaves_lock),
> > > > > rcu_dereference_protected() for the writer-side loads (also under
> > > > > slaves_lock), rcu_dereference_bh() for the loads in teql_master_x=
mit() and
> > > > > rtnl_dereference() for the loads in teql_master_open()/teql_maste=
r_mtu(),
> > > > > which run under RTNL.
> > > > > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the=
 list
> > > > > traversal in teql_master_xmit(), so that readers either observe a=
 fully
> > > > > linked list or are deferred until the in-flight mutation complete=
s. The two
> > > > > early-return paths in teql_master_xmit() are updated to release t=
he RCU-bh
> > > > > read-side critical section before returning, since leaving it hel=
d would
> > > > > disable BH on that CPU for good.
> > > > >
> > > >
> > > > sashiko-gemini's complaints:
> > > > https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatat=
u.com
> > > > seem bogus to me (someone correct me if i am wrong). I am only goin=
g
> > > > to address the first claim of "TOCTOU / "resurrection" race in
> > > > teql_master_xmit()"
> > > > teql_master_xmit() holds rcu_read_lock_bh() across the entire
> > > > traversal. teql_destroy() freeing can only proceed once the qdisc's
> > > > RCU grace period has elapsed - so where is this TOCTOU? Let's say t=
his
> > > > were true: both calls hold the slaves_lock.
> > > > The other issues are of similar nature.
> > >
> > > Hi Jamal,
> > >
> > > I think the central question here is about the protection offered by =
RCU
> > > in these code paths. And while I agree it protects the use of element=
s
> > > of the list, I think the problem flagged relates to the management of
> > > the list itself.
> > >
> > > The example AI gave me when I asked is like this:
> > >
> > >     Assume a TEQL master has one slave, `q`.
> > >     The list is circular: `q->next =3D=3D q`.
> > >
> > >     1. CPU A (Transmitting): Enters `teql_master_xmit()`.
> > >        It reads `master->sla ves` and gets a local pointer to `q`.
> > >
> > >     2.  CPU B (Destroying): Calls `teql_destroy(q)`.
> > >         It takes the lock, unlinks `q`, and sets `master->slaves =3D =
NULL`.
> > >         The list is now logically empty.
> > >
> > >     3.  CPU A: Finishes its work and prepares to rotate the list head
> > >         to the next slave.
> > >         It takes the lock.
> > >
> > >     4.  CPU A (The "Use" / The Resurrection):
> > >         It executes: `rcu_assign_pointer(master->slaves, NEXT_SLAVE(q=
));`
> > >         Because `q` was circular, `NEXT_SLAVE(q)` is still `q`.
> > >
> > >     5.  CPU A: Releases the lock.
> > >         **The global `master->slaves` is now `q` again.**
> > >
> > >     6.  The System: The RCU grace period expires. CPU B finishes
> > >         `teql_destroy()` and the memory for `q` is freed.
> > >
> > >     The global `master->slaves` pointer is now a **dangling pointer**
> > >     pointing to freed memory.
> > >
> >
> >
> > Yeah, thats the same earlier claim of TOCTOU (what sashiko-gemini
> > claimed was "resurrecting the freed q")
> > My view is rcu read lock blocks the subsequent call_rcu free - and
> > destroy() and xmit() already serialize on slaves_lock.
>
> The read of master->slaves is outside of the slaves_lock critical
> section(s) in teql_master_xmit(). This is possibly the nub of this issue.
>

Yes, i think this could cause an issue on a second run of xmit() ;->
Let me ponder on it. I will probably have something tommorow..

cheers,
jamal
> > I could be totaly wrong, but it's almost like sashiko-gemini thinks
> > that the list-mutation lock _alone_ governs the object lifetime.
> > The rcu read-side critical section prevents the UAF, not just the
> > slaves_lock alone
> > Only reason i added slaves_lock was to prevent corrupting the list
> > state (whereas the RCU read lock prevents premature free).
> >
> > In step #4 above this thing somehow leaves out any mention of the rcu
> > read lock entirely and places the free in step 6 as if it was
> > independent of CPU A's critical section.
>
> I see what you are saying regarding the free not occurring at step 4
> because CPU A is in an RCU read-side critical section.
>
> But once CPU A has assigned master->slaves as q (again) it exits
> the RCU read-side critical section. Then the free of q can occur.
> And master->slaves will point to memory that has been been freed.
>
> So the access to q is safe when teql_master_xmit is invoked, due to RCU
> protecting object lifetime.  But it is unsafe when teql_master_xmit is
> invoked again because by then master->slaves is a dangling pointer.
>
> >
> > I am not sure how to improve it.
> >
> > > > OTOH, sashiko-claude
> > > > (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016=
.24018-1-jhs%40mojatatu.com)
> > > > does make some valid claims which are low value, so not sure a rese=
nd
> > > > is worth it.
> > > > For example in claim 1 it says "Should the changelog mention this
> > > > teql_dequeue() site too?" Sure I can - but just because I provided
> > > > extra information in the commit log, which I could have omitted, no=
w I
> > > > have to add more info? ;->
> > >
> > > FWIIW, I think there is a value in tightening up the commit message.
> > > E.g. so it's accurate when we look at again in two years time.
> > > But I also lean towards it not being necessary to post an update
> > > only to address this.
> > >
> > >
> > > > The second claim is "rcu_dereference_bh()
> > > > should be rcu_dereference_protected() on writer side". Sparse didnt
> > > > complain and i dont see this as breakage rather a consistency measu=
re.
> > >
> > > I think it would be good to address in the long run.  But as per my c=
omment
> > > immediately above, I also lean towards it not being necessary to post=
 an
> > > update only to address this.
> >
> > I can resend with these two taken care of - but i am skeptical of what
> > sashiko-gemini is claiming (and i admit as a human the AI may see
> > something i am totally missing).
> >
> > cheers,
> > jamal
> > >
> > > > Unless I am missing something ..
> > > >
> > > > cheers,
> > > > jamal
