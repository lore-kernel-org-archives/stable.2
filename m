Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AEA3431F5
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885011; cv=none; b=XuVszh4yKee4p5sezX5zH8qMtgT4u//HZbMrQ/v1rCtpESq42AOQDN4ax9DbSy5XoyJ3BwIf0y1HqHEbm7aowcVMJk+2Ob+3vpE6YuCQIiD3kXbrMztXTbCV7ZxzYkzLmX+z+fNgyuiQj+NudInx2XkWWYSafKxvfRHyN7tt9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885011; c=relaxed/simple;
	bh=x+NfT23xtsOuMyluadpQItVxOmRCcSjP7wwid4hR0yM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nbPUqjCr38eAZ3lLnQhjgvYH+O/vl6eqH41Jx8Icb3SyBxL+bpz2wNA8LUxhLPyogf4pZuGeljJCCRnHAIHUkJS4Icw5l2lYltSfkTS4kmiKwAGIWNiBzo3E2EHAoVNKTjKuXfkoKbZ8A5y/HPwJ4sVqeh4aBjS1tWUufNBKaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hevJ+5KV; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hevJ+5KV"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81f3b227a4aso9403637b3.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787885009; x=1788489809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bKG9LeGJl4HRaolEQhjC7Ndckz2inmxAZZ2u5dpOI+A=;
        b=hevJ+5KV009uiIIYQtLol/qzXGZpNlWLvKfED7FSYk6xp+4bypyG9BqqsYfJoQJTeG
         QzB6qqPeM4CzFWL/AD2AgUoxJeKUQ2fTJTVfaUcVVVjFs/pFs/FfU+yOYPTUSSyUKuQp
         zz6BP+JAbRdhQ6FR+8GwFjkK0Wyxx+LbTKD+weYkWr9yg2FD3FfQ3jGBHaBBH7ER4h/O
         eQajal4wX1qGerwK3Uhu1guLodApb2cKWVMsdYUXxNBZiM6QXelcD25UzMAnog/nSvgV
         6kdGMh9/6rsq+DsDDUxkxAQJOzW80fQuXPmWMogZk64BDFe9ML7JDdQLotD/wcLBXUPb
         eyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787885009; x=1788489809;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKG9LeGJl4HRaolEQhjC7Ndckz2inmxAZZ2u5dpOI+A=;
        b=s2PT4kpWi8XlpP+QVEmlgySjroCkIZ59MpPr3pV8IAYykf3TvLqKmaSFRdlrm0bkRM
         vHFLNXb/riIazQaxgUQCV5FefIZo0qsmGfP3nEASt0SmJ+vyjtiPRy5QIr7qcr/RNMuL
         WZQ1jp+UAKHmzlbykHJ8gusfKtCrDJWemWU4uPmoWajznn7deUlFAvQlWli3v/ik3Xqt
         efHEmVx/shKcwuOk+ji7jVFm6Nz27ScKZjC5SE7nKFXAYyGvZGH/IA87Keha0FeTJ+7i
         ux3dzx65/TgtCDMP/RbMI3C4PaHOobatf2mf6jLTWlLwyijHmcEeqFugeG7K/dsQhxaL
         XtfQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro1iAec6mSfBFovAPoYgiYbbVSokqvdsumOBYvf1CZGCMWRa1rXLtj6nE9fBn6k/UuBtk2a76I=@vger.kernel.org
X-Gm-Message-State: AFuF++n1Aqw8ElzUKkct1f5ERC+3hC6jQi6ZSi47dvvOp8QxDIRshpZq
	yAZ7dn/GKfXAcgzKlANxKS8ZwbWZ9PZ2lLvto3OU2kcPF4iJfcwEgQ9E
X-Gm-Gg: AR+sD12QN4wVINLxHhiv6mhv6JvQxVO/M5XCgvK8bf/NhEChizcNPRr11GR8D7iOI+U
	c70yn0lyJKDWTbrXO0Fc7lK9zZr1KSfj3zSy/W4ljKXvOJJO2M1UfOhnYn5f9/Hm/LJ2nLPWot+
	OzeRxeS9QIk4mwGHaQQKKR3MDsi8jUhH7G1m5slVE5LZiohtBneR+eLtsl83nrfHb/USPK7lriC
	cMlKUKyzuGMbAb2QFE7uOH0+0yajirK07brEiRRzbxQRDBhi0ULEvQWofel76Hi4l0Yc2CKDyhS
	O9bPSN/u7VAu0pSHo0siAKsNr91rPlxIq0YZJ+gDW/IadQKWFDGgpvBSe0ZCzj2Q9VFagT39N0u
	Xa7Qx/kaCBLVkn27jV7WCl1UvX3CO33lyLfsEe8tl/d3/QCiIBgLsYIimzFGxoT2n/oWrWfxsfk
	frN2Mckde7pwca5+iJQW3URWDTQ9JqWnhZg/0SevfHpvD9DwQf2Qc0IjEPDhRI0WHoS4CtpIw6g
	KWJRTLPHe7uDuDnwjLJ9k+c3gbS6OHjGV4DvyqDmw==
X-Received: by 2002:a05:690c:319:b0:80f:8faa:b8e0 with SMTP id 00721157ae682-85d69e009femr21839417b3.8.1787885008958;
        Thu, 27 Aug 2026 19:43:28 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e7163c4dfsm953097b3.15.2026.08.27.19.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:43:28 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:43:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Hangbin Liu <hangbin.liu@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 jv@jvosburgh.net, 
 jiri@resnulli.us, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
In-Reply-To: <apDgeCLGiHTd7fAC@fedora>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com>
 <apDgeCLGiHTd7fAC@fedora>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Hangbin Liu wrote:
> On Thu, Aug 27, 2026 at 05:37:09PM -0400, Willem de Bruijn wrote:
> > Qihang wrote:
> > > Hi Willem,
> > > 
> > > I'll resend this as v2 with a cover letter.
> > > 
> > > On scope: I grepped every header_ops->create.  Five devices delegate to a
> > > lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
> > > team re-select that lower device under RCU -- the rest bind it at netdev
> > > creation.  So bond and team are the full scope.
> > > 
> > > Re Fixes: I used 950803f because it introduced bond_header_create (where
> > > this check lives); before it the type-confusion BUG masked this race.
> > > Happy to point at 1284cd3a2b74 instead if you prefer.
> > > 
> > > On the fix location, I'd rather get your read before writing more.  The
> > > options I see:
> > > 
> > >   1. per-wrapper headroom reject in bond/team only -- small, safe,
> > >      backport-friendly, but not generic (the next stacked device needs
> > >      its own).
> > > 
> > >   2. central check in dev_hard_header on dev->hard_header_len -- one
> > >      place, but I think it's unsafe for bond: bond_dev->hard_header_len
> > >      only follows the first slave (bond_setup_by_slave),
> > >      bond_change_active_slave flips curr_active_slave without touching
> > >      it, and same-type slaves can have different hard_header_len (two GRE
> > >      tunnels).  So it can under-reject.  Would need bond to maintain
> > >      hard_header_len differently first.
> > > 
> > >   3. resolve the effective {dev, ops, hard_header_len} as one RCU triple
> > >      via a generic callback, so the caller never cares which subordinate
> > >      the master picks.  Truly generic and race-free, but it's a new ndo --
> > >      net-next material, awkward for stable backport.
> > > 
> > >   4. make header_ops->create() take an explicit headroom contract and
> > >      fail cleanly instead of pushing blind -- cleanest long-term, but
> > >      touches every create() in the tree.  Too heavy for now.
> > > 
> > > My v1 is option 1 (per-wrapper).  Want one of these, a combination,
> > > or something else entirely?
> > 
> > Thanks for the analysis.
> > 
> > I agree that 3 nd 4 are too invasive for the scope of the bug.
> > 
> > It's a bit odd that bond and team just take the hard_header_len of the
> > first slave. And that bond_create_header just passes to
> 
> Actually, bond will use the max hard_header_len of all slaves, see
> 
> netdev_compute_master_upper_features()

Awesome. That should address the issue.
 
> 
> > curr_active_slave, while various bond modes like LAG will have
> > multiple concurrently active slaves.
> > 
> > That indicates that the intent is for all slaves to have the same
> > header length and header_ops->create callback.
> 
> And here seem you want to all saves also sync the header length?
> 
> I'm not sure if we should/could do this in the same function
> netdev_compute_master_upper_features().

As long as the header length allocated is the max of all slaves'
requirements, no need to check again here, I think.

> Thanks
> Hangbin


