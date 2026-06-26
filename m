Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04283FD132
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490323; cv=pass; b=UWVzmFJPgMw1TqhHazvVzpRevY5J0mIkATV9EMWAdeA44s/OEmMwlqTIFmxCtLrijOUm/5B8BEb4NpCHizrKnePYg6k9VlnILuXgGZIRVmb2O2WfcxON/7MIIHZX9WwkAd0/0sjLObRec1qmHd0cC+YBAPSlqzr0h6/9ByFTp7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490323; c=relaxed/simple;
	bh=t+bRc5tua2h22UL66WgekbHNR8+kStkdljkjSb9Lf+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ik37xOCzHfBuc7IdSDlziWUY3lE8ei/O0TAg6MsyTsvGeQaeq8vrXL4juV30Vg92WCNAIZ+wS3iZ/jvRWSLB8VPhgzoT6IFpA2C3sr/1isCvIeJezDso9FKzKrEyD4FPSRLoKE6KiqA8lUsje2MZOjzi+v9f4DEUC5HRaKVr788=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=VHfq9S6C; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="VHfq9S6C"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84236f9b638so521117b3a.2
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 09:11:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782490319; cv=none;
        d=google.com; s=arc-20260327;
        b=NRA66fDgrUYR4eIicYYXKpkvyMiHOKOFTZKNQbvRxqxvGK7bIekuDS1yxEHWlHigyh
         BOadGJWP+jxgU8jTl8q5f9Iz3WhUwnw5mR8y05ZsZ88Vx/Gopirmv9cRWLhPqJ+cgTPw
         EgIanKCETZ9CBVDYTO6Ktk8IDI5b+IiMce9NbNVIVOVPwEuhposPvEW6AH+fLvv/Bw2o
         9nQSg5rxWV5+TriasK1WYjfnS01ctEYXtx+bOg2cnngijTRz+Mc/rD+Q41MZBno1tYv8
         M7Q1PWZn14mGvFjfA5fqfbe8hHgqYKkXOOruafqObcHAVBbgjbt2QP1ZbGMzOyS0xR0p
         U3Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        fh=N4LF9dDxAg8iUoOXkbNdz3jygxo/wVMstkDroky06us=;
        b=d8UX2/XzG/Hle5LnH1vy+upj33P0fZPZrHyc0mHk3eIF/K9dh9d+7Yfg8Z9YMWuwap
         7YIsg/Lm4aqiOCim6kMO1XU4vvnsZtkIhho3DWxKwPnHis9KsexEkNZaLwRerX1WVVpp
         //pqoIMr+2BVt0tJjr1wfPkmWgbEkEHT+GSNJ+8pt3VJUeOM9Ij18+Za/FCR8fMX2eod
         z8d/xslfIOR39Av/R/JlrMTF/rVaQnv2llIRTAGmKzTG/k0sKknuJ26Vq3Dki5FbUVIU
         OEAFlw68bWaqpZX0EcFT+it/zneM8XXXJBnQxpjy78AYTWGguvlh6SUI1LKLjmJ96LoK
         m/Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1782490319; x=1783095119; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        b=VHfq9S6CQ9kgJFUCRZEWuKKVDsoCUPSxVrtyiRy0YN/CNjEUjQ7efUvjgTCWdW7p04
         xLuZvNeXcSWR4ue0KStp/o40/DbFc/XCCcgROmxX8+H7V85cpMp5yE82+6hyAY34oKdR
         DEH2G/TpQ1tmtt42vldKPe73u22dzQyYdZ8uw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782490319; x=1783095119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXQEyT7Q4jr5cIIxct5CGj348m6uRo9IrfssmoijES8=;
        b=C0NS+4APTbvAXHCGwSGPmIjI7tsaQNwGjGi7pTAE2rVofxX0Jdi5VVfVZg6JBH9aBD
         5eOaY01A+BBxrZ16Bi1tGqgdLLE8BtlGj9qVfdFC0h83J7A1OrXgpAX6st8FgHnGDdwE
         poq49O1rjQ8WFCAFCf+OwkyrI9s4UmEcXz9XvvodIL7YDsnZMycKfKENsSKlR1LIsxfF
         8Pkx/Qg1MfKmacHMvKzKgJpO376ET6pzYK3xN3RHkcXxE0y4ryttMHgkseZ+t3mRQKIM
         Mk9KYtJhi7JWObZ7+AIxrYPpDZl6xG+1l+N4FWoEE5LCoSaWO7/XMV6qp1rL4TT4isHO
         O1pA==
X-Forwarded-Encrypted: i=1; AHgh+RqCtVKL/wL1ciLO3xLEGk9ZvbaOCT00Vd7ZvBLzHQ5FAzGjXEwJj+FqFs2M5eiV6G5Zd9OUNeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy22QrLGi8ga26OniPusKTv3gcRrvHKLaW37vHBho1OcuWgA1Xs
	3pW2MU45YQDjGnwcjDiEdC1PHlUMf1yQU65VUfUz15ZoMFJfifU3qfglf2joE6IT1jiNKdAZmGI
	14n/LH0EK/3VrtMzASV6hwuqICo6ZZFSMGV3qArMY
X-Gm-Gg: AfdE7clmDChiYtOLGGScWRTMw8TH1M2aR97qcUkPjrElb+d8DYTgm+4rYkJWREZbSN5
	MwTnQsNkS1xFyRiUBCs8Zdzh9K2BZaS6A475dvEFrdOzg2e+X3NWbKyHoOhn3UOZxU894ZFNo2r
	/e6DDFvHcIgOxuKjKiAkjvrQyt95/vFYtWm8LZItsg666NUWgOIEqJABpxMDQyfo2vSp1KTMIaX
	463ipQyizUlCFbL8XSqnrBEMb54OHNguuwWaxLJqw2YaFPratyakfmh20xovTW62ZOY/bZenw==
X-Received: by 2002:a05:6a00:9a9:b0:845:d284:9e01 with SMTP id
 d2e1a72fcca58-845d284aa06mr879981b3a.59.1782490318736; Fri, 26 Jun 2026
 09:11:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624224016.24018-1-jhs@mojatatu.com> <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
 <20260626141547.GA1310988@horms.kernel.org>
In-Reply-To: <20260626141547.GA1310988@horms.kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 26 Jun 2026 12:11:47 -0400
X-Gm-Features: AVVi8Cecncdcl4VQwa1dstOAibkOpvT8I77lUEklwuWglJcyWzqV1iNugZHWSgI
Message-ID: <CAM0EoMntFA+fqs_BgT0E_KSsQHyf0W0u7OTngHHB7icrnUiC3A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, victor@mojatatu.com, 
	security@kernel.org, zdi-disclosures@trendmicro.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Simon,

On Fri, Jun 26, 2026 at 10:15=E2=80=AFAM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Jun 26, 2026 at 06:16:43AM -0400, Jamal Hadi Salim wrote:
> > "
> >
> > On Wed, Jun 24, 2026 at 6:40=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> > >
> > > The teql master->slaves singly linked list is not protected against
> > > multiple writes. It can be mod'ed concurently from teql_master_xmit()=
,
> > > teql_dequeue(), teql_init() and teql_destroy() without holding any li=
st
> > > lock or RCU protection.
> > >
> > > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is fre=
ed
> > > after an RCU grace period, but teql_master_xmit() running on another
> > > CPU can still hold a stale pointer into the list, resulting in a
> > > slab-use-after-free:
> > >
> > > BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net=
/sched/sch_teql.c:142
> > > Read of size 8 at addr ffff88802923aa80 by task ip/10024
> > >
> > > The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
> > > senders on a teql device against a thread that repeatedly adds/delete=
s the
> > > slave qdisc, together with a SLUB spray that reclaims the freed slot;=
 the
> > > resulting UAF is controllable enough to be turned into a read/write
> > > primitive against the freed qdisc object.
> > >
> > > The fix?
> > > Add a per-master slaves_lock spinlock that serializes all mutations o=
f
> > > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> > > around those updates.
> > > Annotate master->slaves and the per-slave ->next pointer with __rcu a=
nd
> > > use the appropriate RCU accessors everywhere they are touched:
> > > rcu_assign_pointer() on the writer side (under slaves_lock),
> > > rcu_dereference_protected() for the writer-side loads (also under
> > > slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit(=
) and
> > > rtnl_dereference() for the loads in teql_master_open()/teql_master_mt=
u(),
> > > which run under RTNL.
> > > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the lis=
t
> > > traversal in teql_master_xmit(), so that readers either observe a ful=
ly
> > > linked list or are deferred until the in-flight mutation completes. T=
he two
> > > early-return paths in teql_master_xmit() are updated to release the R=
CU-bh
> > > read-side critical section before returning, since leaving it held wo=
uld
> > > disable BH on that CPU for good.
> > >
> >
> > sashiko-gemini's complaints:
> > https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatatu.co=
m
> > seem bogus to me (someone correct me if i am wrong). I am only going
> > to address the first claim of "TOCTOU / "resurrection" race in
> > teql_master_xmit()"
> > teql_master_xmit() holds rcu_read_lock_bh() across the entire
> > traversal. teql_destroy() freeing can only proceed once the qdisc's
> > RCU grace period has elapsed - so where is this TOCTOU? Let's say this
> > were true: both calls hold the slaves_lock.
> > The other issues are of similar nature.
>
> Hi Jamal,
>
> I think the central question here is about the protection offered by RCU
> in these code paths. And while I agree it protects the use of elements
> of the list, I think the problem flagged relates to the management of
> the list itself.
>
> The example AI gave me when I asked is like this:
>
>     Assume a TEQL master has one slave, `q`.
>     The list is circular: `q->next =3D=3D q`.
>
>     1. CPU A (Transmitting): Enters `teql_master_xmit()`.
>        It reads `master->sla ves` and gets a local pointer to `q`.
>
>     2.  CPU B (Destroying): Calls `teql_destroy(q)`.
>         It takes the lock, unlinks `q`, and sets `master->slaves =3D NULL=
`.
>         The list is now logically empty.
>
>     3.  CPU A: Finishes its work and prepares to rotate the list head
>         to the next slave.
>         It takes the lock.
>
>     4.  CPU A (The "Use" / The Resurrection):
>         It executes: `rcu_assign_pointer(master->slaves, NEXT_SLAVE(q));`
>         Because `q` was circular, `NEXT_SLAVE(q)` is still `q`.
>
>     5.  CPU A: Releases the lock.
>         **The global `master->slaves` is now `q` again.**
>
>     6.  The System: The RCU grace period expires. CPU B finishes
>         `teql_destroy()` and the memory for `q` is freed.
>
>     The global `master->slaves` pointer is now a **dangling pointer**
>     pointing to freed memory.
>


Yeah, thats the same earlier claim of TOCTOU (what sashiko-gemini
claimed was "resurrecting the freed q")
My view is rcu read lock blocks the subsequent call_rcu free - and
destroy() and xmit() already serialize on slaves_lock.
I could be totaly wrong, but it's almost like sashiko-gemini thinks
that the list-mutation lock _alone_ governs the object lifetime.
The rcu read-side critical section prevents the UAF, not just the
slaves_lock alone
Only reason i added slaves_lock was to prevent corrupting the list
state (whereas the RCU read lock prevents premature free).

In step #4 above this thing somehow leaves out any mention of the rcu
read lock entirely and places the free in step 6 as if it was
independent of CPU A's critical section.

I am not sure how to improve it.

> > OTOH, sashiko-claude
> > (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016.240=
18-1-jhs%40mojatatu.com)
> > does make some valid claims which are low value, so not sure a resend
> > is worth it.
> > For example in claim 1 it says "Should the changelog mention this
> > teql_dequeue() site too?" Sure I can - but just because I provided
> > extra information in the commit log, which I could have omitted, now I
> > have to add more info? ;->
>
> FWIIW, I think there is a value in tightening up the commit message.
> E.g. so it's accurate when we look at again in two years time.
> But I also lean towards it not being necessary to post an update
> only to address this.
>
>
> > The second claim is "rcu_dereference_bh()
> > should be rcu_dereference_protected() on writer side". Sparse didnt
> > complain and i dont see this as breakage rather a consistency measure.
>
> I think it would be good to address in the long run.  But as per my comme=
nt
> immediately above, I also lean towards it not being necessary to post an
> update only to address this.

I can resend with these two taken care of - but i am skeptical of what
sashiko-gemini is claiming (and i admit as a human the AI may see
something i am totally missing).

cheers,
jamal
>
> > Unless I am missing something ..
> >
> > cheers,
> > jamal
