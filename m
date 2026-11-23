Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412446;
	b=SI5XZ1KklAOg/VBN0o0+ynPu/MJXLHOVq8NBxkVcnmobJlW6xpudWttIi2InKBi0ZgxX
	 kFKxBw367Df3bx9aQ8aaNYD+rKNPzhhw6MQmx/jTjnHbihKnBbmEV5Wp+Rbb/J8KzcXDt
	 0gdyTjlO5p6SHsFedeD6eiE7PXUoFIvrcjXMHSvWZZb5nssGcIGmB21260+Kt80mO5LrO
	 6wvEaeHLO35MUWQIOoiSss19s7cYGUtovhR7AM7Oycih2iEAgMV2tN10qOxn24yVm+49+
	 BSwAT9KTSAqSHJeOw2xqC6OWj8lDZon8w1C4Tn3vXv/PnPLzJ2VSDIYHQAsNIFHJg2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412446;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=bbQirXyt3WS+dsPItm3jzvka/MibXeXHe6QHDVoInDo=;
	b=EtmaK+5YFyoMWjefL+3rqiFM3K21TMIa0rbXzb0Kpct3wOKA3I2ZasQjjuqTkLeASmf3
	 Ps5jRuWxv6hMHyKt7o5J7wfLBPilPL1XKDd/so9+P5AVvQky6IfL0nD41Aj/Ejbe4DYw5
	 t388HI+yJNRm6XzZpHmc0I5DDOmDCh1GcwxhdIIdyWBx+cHr6HczuAOuOJgsFwgfLFQ22
	 6dTcI5RAH0je5LgGAQh3YLeBNwroATD/d0oTt/lwcc+0vTAzeP2Cqc5deBRMqHhRfns9y
	 lfSm52IhOp6Zd0dYK7Jy4okpod6C61E09fCJAVqqaziOrYUPSOZxxleU5k3X/9XiHYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D5k4zY9E;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D1606A31A;
	Mon, 23 Nov 2026 05:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A25D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=D5k4zY9E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795412446; x=1826948446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zquiTe0ILvzaj8QJ4CF4afQTdL6kzqlqawTDAHqTfGY=;
  b=D5k4zY9E9fJU4CKgJOBf4SjGqo+NMf5aGP3TpfvJk3a5bx79pYsx+OfR
   7XzWdJzFpLz+knLEZ+lIShdOVAr9uOLYAs/+YK3fPoB3TpfmwgWKpdVmp
   8W7RjgMRVs8lggikOWjE5IReg/Ki3nHoPhjfJETdFsP3LxvZoHaBePlq7
   iBDn9ydxugdlCcliOd9jFN1CkgVaSkRyNs3zdabkxMMr8WTmUWfgKcC/i
   VGDLaoDK/U2zLUsV5JcJUOnxmZ/NuUFoP6NfsXpp/KEuyXK+yUJB9ZwVB
   42t6Q514WwgKH9KbQNo9N5UCRd9xVUNLB92EI1GiEWAL6xd4mAOys4VIF
   A==;
X-CSE-ConnectionGUID: ofAP4u+OTD+Bv1qQHnudyg==
X-CSE-MsgGUID: QdPpL4dLTNiqY+Vg12diCw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4241130"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4241130"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2026 21:40:45 -0800
X-CSE-ConnectionGUID: bezcTEWfTEqTT0NdsBe5fA==
X-CSE-MsgGUID: S6Q1T+7HSLmmeJfyGPZuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="13022637"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa011.fm.intel.com with ESMTP; 22 Nov 2026 21:40:43 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 0F74099; Mon, 23 Nov 2026 06:40:42 +0100 (CET)
Date: Mon, 23 Nov 2026 06:40:42 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Alfonso Villalobos <alfonsocvu@gmail.com>
Cc: sashiko-reviews@lists.linux.dev, westeri@kernel.org,
	linux-usb@vger.kernel.org, andreas.noever@gmail.com,
	YehezkelShB@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: Re-add host router DP IN adapters after
 DPRX failure
Message-ID: <20261123054042.GL229695@black.igk.intel.com>
References: <20261121070804.26185-1-alfonsocvu@gmail.com>
 <sashiko-outbox-226770@kernel.org>
 <CAJ=mrFowQNahOjD-NQzcuJCjPE=efvDK85kMpseRUrqYBwX3Sw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ=mrFowQNahOjD-NQzcuJCjPE=efvDK85kMpseRUrqYBwX3Sw@mail.gmail.com>

Hi,

On Sat, Nov 21, 2026 at 09:07:04AM -0600, Alfonso Villalobos wrote:
> Hi Mika, hope you're having a great day.
> 
> I'd like to check the direction with you before doing v2. After the
> Sashiko review and looking closer at how host router DP IN adapters
> are handled, I'm not sure v1 fixes this in the right place.
> 
> The DPRX failure happens when the RX 9070 XT feeding 0:10 is in BACO.
> With runtime PM disabled for the GPU it always works. After the
> failure the host router never sends a hotplug for 0:10, so it stays
> unused until something triggers the re-check from v1, here me
> replugging the dock at 00:27:26:
> 
>   [00:26:36] 0:10 <-> 1:11 (DP): activating
>   [00:26:36] 0:11 <-> 1:12 (DP): activating
>   [00:26:48] 0:10 <-> 1:11 (DP): not active, tearing down
>   [00:26:48] 0:10: DP IN resource unavailable: DPRX negotiation failed
>   [00:27:26] 0:10: DP IN resource available
>   [00:27:26] 0:11 <-> 1:11 (DP): activating
>   [00:27:26] 0:10 <-> 1:12 (DP): activating

Does the RX 9070 driver poll for a new connections periodically like the
i915/xe or it supports PME? The current DPRX timeout is pretty much
following the i915 that has 10s polling period so simple way of working
this around is to set thunderbolt.dprx_timeout= to match that.

> The DP OUTs also end up swapped, so the ordering part of v1 doesn't
> work as intended either.

At the moment tunnels are created pretty much in the order the hotplugs
arrive.

> The comment in tb_dp_tunnel_active() and the redrive code both seem
> to expect a hotplug for host DP IN adapters. Is the ASM4242 supposed
> to send one once the GPU starts driving the DP IN? If this is
> ASM4242 specific I can limit the fix to it with a quirk.

The hotplugs should happen when the host router is enumerated so for
example in your case it should work so that if graphics did not do DRPX
capability exchange in time, the DP tunnel is torn down and if conditions
are right the domain is put to sleep. When you wake it up there should be
new hotplugs to DP INs so the resource is added back to the list.

> v1 also only recovers on a new event. The alternative I had in mind
> is retrying the DP IN a few times with a delay after DPRX fails, so
> it recovers without a replug. Which is better?

Can you first check if drpx_timeout= helps in your case? If it does, for
simplicity one option is that we just make the default match the "biggest"
and some slack.

> I already have fixes for the Sashiko comments (the missing
> tb_exit_redrive() and the ordering in tb_dp_resource_available()) and
> one to skip DP IN adapters that are already in a tunnel, but I'd like
> your opinion before spending more time on it.
> 
> Thanks,
> Alfonso
> 
> On Sat, Nov 21, 2026 at 1:25 AM <sashiko-bot@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issues to consider:
> > - [Medium] thunderbolt: missing tb_exit_redrive() in
> >   tb_add_dp_resources() leaks RPM ref
> > - [Medium] thunderbolt: list_add_tail() in tb_dp_resource_available()
> >   breaks DP IN order
> > --
> >
> > commit 4eedd8886dc180b45204d935f18725051dd0e6a0
> > Author: Alfonso Villalobos Ulate <alfonsocvu@gmail.com>
> >
> > thunderbolt: Re-add host router DP IN adapters after DPRX failure
> >
> > This commit re-checks host router DP IN adapters when a new DP OUT adapter
> > becomes available or a device router is scanned, keeping host DP IN
> > adapters ordered by adapter number on tcm->dp_resources.
> >
> > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > index 418ad0a61a5de..1f3dea836067e 100644
> > > --- a/drivers/thunderbolt/tb.c
> > > +++ b/drivers/thunderbolt/tb.c
> > > @@ -109,6 +109,29 @@ static void tb_queue_hotplug(struct tb *tb, u64 route, u8 port, bool unplug)
> > >
> > >  /* enumeration & hot plug handling */
> > >
> > > +/*
> > > + * Insert a host router DP IN adapter so that host DP IN adapters stay
> > > + * in adapter number order. A DP IN that is re-added after it was
> > > + * dropped (for example because DPRX negotiation failed) then gets
> > > + * paired with the same DP OUT as before, instead of swapping DP OUT
> > > + * adapters (and therefore monitors) with the other host DP IN.
> > > + */
> > > +static void tb_add_host_dp_in(struct tb_cm *tcm, struct tb_port *port)
> > > +{
> > > +     struct tb_port *p;
> > > +
> > > +     list_for_each_entry(p, &tcm->dp_resources, list) {
> > > +             if (tb_port_is_dpin(p) && !tb_route(p->sw) &&
> > > +                 p->port > port->port) {
> > > +                     /* Insert before the first higher numbered one */
> > > +                     list_add_tail(&port->list, &p->list);
> > > +                     return;
> > > +             }
> > > +     }
> > > +
> > > +     list_add_tail(&port->list, &tcm->dp_resources);
> > > +}
> > > +
> > >  static void tb_add_dp_resources(struct tb_switch *sw)
> > >  {
> > >       struct tb_cm *tcm = tb_priv(sw->tb);
> > > @@ -118,6 +141,9 @@ static void tb_add_dp_resources(struct tb_switch *sw)
> > >               if (!tb_port_is_dpin(port))
> > >                       continue;
> > >
> > > +             if (!list_empty(&port->list))
> > > +                     continue;
> > > +
> > >               if (!tb_switch_query_dp_resource(sw, port))
> > >                       continue;
> > >
> > > @@ -130,7 +156,7 @@ static void tb_add_dp_resources(struct tb_switch *sw)
> > >               if (tb_route(sw))
> > >                       list_add(&port->list, &tcm->dp_resources);
> > >               else
> > > -                     list_add_tail(&port->list, &tcm->dp_resources);
> > > +                     tb_add_host_dp_in(tcm, port);
> > >
> > >               tb_port_dbg(port, "DP IN resource available\n");
> > >       }
> >
> > [Severity: Medium]
> > Does re-adding a host router DP IN port through tb_add_dp_resources() leak
> > the runtime PM reference on sw->dev when the port was in redrive mode?
> >
> > On host routers with QUIRK_KEEP_POWER_IN_DP_REDRIVE, tb_enter_redrive()
> > sets port->redrive and calls pm_runtime_get(&sw->dev).  When
> > tb_add_dp_resources(tb->root_switch) now runs at runtime from
> > tb_scan_port() or tb_dp_resource_available(), it adds the host DP IN port
> > to tcm->dp_resources without calling tb_exit_redrive(port).  Any later
> > tb_dp_resource_available() call for that DP IN port then returns early
> > because the port is already on tcm->dp_resources (or already enabled by
> > tb_tunnel_dp()), leaving port->redrive set and preventing the host router
> > from suspending.
> >
> > [ ... ]
> >
> > > @@ -2234,6 +2272,14 @@ static void tb_dp_resource_available(struct tb *tb, struct tb_port *port)
> > >       list_add_tail(&port->list, &tcm->dp_resources);
> > >       tb_exit_redrive(port);
> > >
> > > +     /*
> > > +      * Host router DP IN adapters removed because DPRX negotiation
> > > +      * failed never get a hotplug event of their own. Give them
> > > +      * another chance now that a DP OUT became available.
> > > +      */
> > > +     if (tb_port_is_dpout(port))
> > > +             tb_add_dp_resources(tb->root_switch);
> > > +
> > >       /* Look for suitable DP IN <-> DP OUT pairs now */
> > >       tb_tunnel_dp(tb);
> > >  }
> >
> > [Severity: Medium]
> > Should tb_dp_resource_available() also use tb_add_host_dp_in() when adding
> > a host router DP IN port?
> >
> > When a lower-numbered host DP IN port becomes available via hotplug in
> > tb_dp_resource_available() (such as when exiting redrive mode or after
> > resume) while a higher-numbered host DP IN port is already on
> > tcm->dp_resources, list_add_tail() places the lower-numbered port after
> > the higher-numbered one, breaking the adapter ordering that
> > tb_add_host_dp_in() maintains.
> >
> > --
> > Sashiko AI review · https://sashiko.dev/#/patchset/20261121070804.26185-1-alfonsocvu@gmail.com?part=1
