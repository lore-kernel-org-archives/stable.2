Received: from mta0.migadu.com (out-135.mta0.migadu.com [91.218.175.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD11A38F9
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787879568; cv=none; b=mLKZJ+Dl+ATPoV3OQ0n6+/YX3k9LKZqTjn4F3tr9h7z686g1d37iOMA6+bhLtK0I4jNvMCMf2E44t2fXSnt0xtxjCDSWzVZ7CnM7mep/Oq1DJzuijduJtlb222o6OBzAFaGLa01TCVclEoceXxMMzmjkReQKFp9ld0pJ8p02lZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787879568; c=relaxed/simple;
	bh=LxnVsBbSKAllbT7hbPBLZruqjqy7W5pVTer8CwkRN78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ggjX5u0mf2AUsz16EClTcNwbnRYkOgMlX6Ea8pCEt+1XK+/HVvH4nrovXnrKdvInJHL5Qtd4oY48PPUkVucgV+hgPb8jb4zD0w7nWcnAGde7h2lfLdobswhruYNsz9riLqH13UgWc5//yFF3wzzk2LIzOVetenF9fG+jCqwmEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sItprG4b; arc=none smtp.client-ip=91.218.175.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sItprG4b"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LxnVsBbSKAllbT7hbPBLZruqjqy7W5pVTer8CwkRN78=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787879563; v=1; x=1788484363;
 b=sItprG4bghK7oANCupztWS27Veojya5KD7GlaVbQzBLnt+8bDhWtUfNQmMBEyoP6h5l4nP/X
 khy8QNZjjxaznohc5wYH2ly1Wb21B8ZAFScEFNp4miqM1Z3fxU8cv+eEHaQ/oRHS5hCH2e3H77b
 Fv67zO/4CJWvMl8hkX90uOPo=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f68c53f74fe6287d;
	Fri, 28 Aug 2026 01:12:33 +0000
X-Mizu-Trace-ID: f68c53f74fe6287d
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 09:12:24 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, jv@jvosburgh.net, jiri@resnulli.us,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient
 headroom in bond_header_create
Message-ID: <apDgeCLGiHTd7fAC@fedora>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.361c9e585560e@gmail.com>

On Thu, Aug 27, 2026 at 05:37:09PM -0400, Willem de Bruijn wrote:
> Qihang wrote:
> > Hi Willem,
> > 
> > I'll resend this as v2 with a cover letter.
> > 
> > On scope: I grepped every header_ops->create.  Five devices delegate to a
> > lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
> > team re-select that lower device under RCU -- the rest bind it at netdev
> > creation.  So bond and team are the full scope.
> > 
> > Re Fixes: I used 950803f because it introduced bond_header_create (where
> > this check lives); before it the type-confusion BUG masked this race.
> > Happy to point at 1284cd3a2b74 instead if you prefer.
> > 
> > On the fix location, I'd rather get your read before writing more.  The
> > options I see:
> > 
> >   1. per-wrapper headroom reject in bond/team only -- small, safe,
> >      backport-friendly, but not generic (the next stacked device needs
> >      its own).
> > 
> >   2. central check in dev_hard_header on dev->hard_header_len -- one
> >      place, but I think it's unsafe for bond: bond_dev->hard_header_len
> >      only follows the first slave (bond_setup_by_slave),
> >      bond_change_active_slave flips curr_active_slave without touching
> >      it, and same-type slaves can have different hard_header_len (two GRE
> >      tunnels).  So it can under-reject.  Would need bond to maintain
> >      hard_header_len differently first.
> > 
> >   3. resolve the effective {dev, ops, hard_header_len} as one RCU triple
> >      via a generic callback, so the caller never cares which subordinate
> >      the master picks.  Truly generic and race-free, but it's a new ndo --
> >      net-next material, awkward for stable backport.
> > 
> >   4. make header_ops->create() take an explicit headroom contract and
> >      fail cleanly instead of pushing blind -- cleanest long-term, but
> >      touches every create() in the tree.  Too heavy for now.
> > 
> > My v1 is option 1 (per-wrapper).  Want one of these, a combination,
> > or something else entirely?
> 
> Thanks for the analysis.
> 
> I agree that 3 nd 4 are too invasive for the scope of the bug.
> 
> It's a bit odd that bond and team just take the hard_header_len of the
> first slave. And that bond_create_header just passes to

Actually, bond will use the max hard_header_len of all slaves, see

netdev_compute_master_upper_features()


> curr_active_slave, while various bond modes like LAG will have
> multiple concurrently active slaves.
> 
> That indicates that the intent is for all slaves to have the same
> header length and header_ops->create callback.

And here seem you want to all saves also sync the header length?

I'm not sure if we should/could do this in the same function
netdev_compute_master_upper_features().

Thanks
Hangbin
