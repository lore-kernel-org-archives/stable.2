Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1413D3F823E;
	Fri, 26 Jun 2026 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782483354; cv=none; b=Fw1ZDTDEkJG/n4HC3MxXeA8Oz2KuAiiZe8DbUcFy+6ZDValN2+xCg/PmPcI3MFxTYenRpq9JFFkrwrNAMWH7ZarAxs2plQY++8adFaYX/NV4Ul4mEi2/ij0HPoFwT+8QHo9tVkRwCUkcAiwc6t3yTm5e/yXkGiTmX9SuJOlP0NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782483354; c=relaxed/simple;
	bh=xewFC2Nu7+ukLNb971H6Vy6r7z3RQr1HiiWQVGlGHmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnbLRM+nKk2dU3J1aU+oNBeKGVaM80GATxP3fbwD9ml10xkkPjpsmNbKWlGy39rypSd4BPf9M0HyeBwXPUKiC5mi4qyq1Tz9+evmTOVf2eNDTgPOa1v0gm7qI5u4x+eQpBBzh/yrTeurQzsvJHOeKzAHuGoB1+Q9Jwho3Ul3Pao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/4x+MBP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/4x+MBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EE71F00A3A;
	Fri, 26 Jun 2026 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782483353;
	bh=QR6xohXjq8QO4I0tR2UKgynxmL8FdNro5f3Q9KrztfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X/4x+MBPR7/rhyZCwoplGwbNfusOTZ48Gh6T+TEs3/GbLRK2yBby7aKJuglpJ+ukt
	 14gPxC5y184HgdwgzkOg9YkDsLurnI+KSXg5CQUGCOZZ+70IKuxRVNsuJYeG7zykLK
	 n1Jm8h0Sw6AC94jLJ30jeyjCI8k7NaE3r0QWXeFY57zMNzprZPnP7D0CrD0LEgFQbK
	 YlkZGqq8ekHFXygvQkIOCQ10ly7bDrb71f5JhYRWTp5bQJGPwsCIuKgqRjAJZUfZXo
	 /ufMGWFGpmqLzWyVFRSAO0gCqWyBS65tACP/yc/wXq3eLlvK3RfQCCjpuEQZ1v3i3X
	 lLXlWvXexlWdw==
Date: Fri, 26 Jun 2026 15:15:47 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	victor@mojatatu.com, security@kernel.org,
	zdi-disclosures@trendmicro.com, stable@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v2 1/1] net/sched: sch_teql: Introduce slaves_lock to
 avoid race condition and UAF
Message-ID: <20260626141547.GA1310988@horms.kernel.org>
References: <20260624224016.24018-1-jhs@mojatatu.com>
 <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmJZxAbOsyW7bBp0DbTTiQKZeGaaBHPEw45D5b6DKDEvg@mail.gmail.com>

On Fri, Jun 26, 2026 at 06:16:43AM -0400, Jamal Hadi Salim wrote:
> "
> 
> On Wed, Jun 24, 2026 at 6:40 PM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> >
> > The teql master->slaves singly linked list is not protected against
> > multiple writes. It can be mod'ed concurently from teql_master_xmit(),
> > teql_dequeue(), teql_init() and teql_destroy() without holding any list
> > lock or RCU protection.
> >
> > zdi-disclosures@trendmicro.com has demonstrated that the qdisc is freed
> > after an RCU grace period, but teql_master_xmit() running on another
> > CPU can still hold a stale pointer into the list, resulting in a
> > slab-use-after-free:
> >
> > BUG: KASAN: slab-use-after-free in teql_destroy+0x3ca/0x440 linux/net/sched/sch_teql.c:142
> > Read of size 8 at addr ffff88802923aa80 by task ip/10024
> >
> > The zdi-disclosures@trendmicro.com repro created concurrent AF_PACKET
> > senders on a teql device against a thread that repeatedly adds/deletes the
> > slave qdisc, together with a SLUB spray that reclaims the freed slot; the
> > resulting UAF is controllable enough to be turned into a read/write
> > primitive against the freed qdisc object.
> >
> > The fix?
> > Add a per-master slaves_lock spinlock that serializes all mutations of
> > master->slaves and the NEXT_SLAVE() links in teql_destroy() and
> > teql_qdisc_init(). teql_master_xmit() also takes the same slaves_lock
> > around those updates.
> > Annotate master->slaves and the per-slave ->next pointer with __rcu and
> > use the appropriate RCU accessors everywhere they are touched:
> > rcu_assign_pointer() on the writer side (under slaves_lock),
> > rcu_dereference_protected() for the writer-side loads (also under
> > slaves_lock), rcu_dereference_bh() for the loads in teql_master_xmit() and
> > rtnl_dereference() for the loads in teql_master_open()/teql_master_mtu(),
> > which run under RTNL.
> > Pair this with rcu_read_lock_bh()/rcu_read_unlock_bh() around the list
> > traversal in teql_master_xmit(), so that readers either observe a fully
> > linked list or are deferred until the in-flight mutation completes. The two
> > early-return paths in teql_master_xmit() are updated to release the RCU-bh
> > read-side critical section before returning, since leaving it held would
> > disable BH on that CPU for good.
> >
> 
> sashiko-gemini's complaints:
> https://sashiko.dev/#/patchset/20260624224016.24018-1-jhs%40mojatatu.com
> seem bogus to me (someone correct me if i am wrong). I am only going
> to address the first claim of "TOCTOU / "resurrection" race in
> teql_master_xmit()"
> teql_master_xmit() holds rcu_read_lock_bh() across the entire
> traversal. teql_destroy() freeing can only proceed once the qdisc's
> RCU grace period has elapsed - so where is this TOCTOU? Let's say this
> were true: both calls hold the slaves_lock.
> The other issues are of similar nature.

Hi Jamal,

I think the central question here is about the protection offered by RCU
in these code paths. And while I agree it protects the use of elements
of the list, I think the problem flagged relates to the management of
the list itself.

The example AI gave me when I asked is like this:

    Assume a TEQL master has one slave, `q`.
    The list is circular: `q->next == q`.

    1. CPU A (Transmitting): Enters `teql_master_xmit()`.
       It reads `master->sla ves` and gets a local pointer to `q`.

    2.  CPU B (Destroying): Calls `teql_destroy(q)`.
        It takes the lock, unlinks `q`, and sets `master->slaves = NULL`.
        The list is now logically empty.

    3.  CPU A: Finishes its work and prepares to rotate the list head
        to the next slave.
	It takes the lock.

    4.  CPU A (The "Use" / The Resurrection):
        It executes: `rcu_assign_pointer(master->slaves, NEXT_SLAVE(q));`
        Because `q` was circular, `NEXT_SLAVE(q)` is still `q`.

    5.  CPU A: Releases the lock.
        **The global `master->slaves` is now `q` again.**

    6.  The System: The RCU grace period expires. CPU B finishes
        `teql_destroy()` and the memory for `q` is freed.

    The global `master->slaves` pointer is now a **dangling pointer**
    pointing to freed memory.

> OTOH, sashiko-claude
> (https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260624224016.24018-1-jhs%40mojatatu.com)
> does make some valid claims which are low value, so not sure a resend
> is worth it.
> For example in claim 1 it says "Should the changelog mention this
> teql_dequeue() site too?" Sure I can - but just because I provided
> extra information in the commit log, which I could have omitted, now I
> have to add more info? ;->

FWIIW, I think there is a value in tightening up the commit message.
E.g. so it's accurate when we look at again in two years time.
But I also lean towards it not being necessary to post an update
only to address this.


> The second claim is "rcu_dereference_bh()
> should be rcu_dereference_protected() on writer side". Sparse didnt
> complain and i dont see this as breakage rather a consistency measure.

I think it would be good to address in the long run.  But as per my comment
immediately above, I also lean towards it not being necessary to post an
update only to address this.

> Unless I am missing something ..
> 
> cheers,
> jamal
