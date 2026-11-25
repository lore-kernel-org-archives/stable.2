Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795569770;
	b=gV/sbnX0w5FiTnzaQamK4175QlgkM9lQxRp2k03HnkmKah5109Z6LQHhYGaf85YXV0Hh
	 IttDr1N5XjOV6ZMFYVaFubNymmJAoZmj7aT0zWYB9rLNEgwTWVEK0M2gtkW7p36TUCKun
	 c2H2jhLDexdI3KbjxWdWcSUW7esNOqzCeKJm9hDpKdS8brmIjdzfAeggCWKWztOl3rXaj
	 WyGPHepwcKvZhOxrv3L4FBMXixJs2ui2YgXuYIYeK+9kemOj8ziG4fAn/NMwMJ5R7zHu9
	 f4I8CdMZOz4xyFp3Ec6Gw689lvhahcRbuV6u7h13c+TlXrrwkPXQZeSK0own6+4Oavg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795569770;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wNiHe9qvjeLSIhDwarY1WjZQZ+c5iOrBNm9DgIHA17g=;
	b=CqV3QN41/1Gvk1LnN1sowD216L2lNlUdQxwBgU9NZA0oAezKMGPWv01EPI1mxqRSV1Nx
	 xYVlv0ePEwn0IVXS7WbjtlLPNfigR00x7Za2vdKYVlPD9XM+WgZdr1ViUKDtlDYxvPger
	 pBLuVoUKl9v+3w3lPw3EjLoFZufHCDeGNufHIrgJQ5n1YMLE54/1H2Btb8HCJsBKEGvsp
	 yBp/jvpE/C0Xuo1VbhZ4rxhB1mZoEp5T0l6upQOft2gv9ewLkF2v6eTk8GTockxpWIoFt
	 tXAJ2T4dMWFNqDT1g+2BRrP8BwnCe3ZrqzWce3bUbWRbE7X4GAEI4GrTG6L5xRQXTXQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0G3N+u91;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA601606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 01:22:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA601606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0G3N+u91
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b3fb193c03so2215632a91.2
        for <stable@vger.kernel.org>; Tue, 24 Nov 2026 17:22:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795569769; cv=none;
        d=google.com; s=arc-20260327;
        b=rSbnbH7FSHhhJbDAcTuwRtzP3SFVP2086l3UokGat95huoJ/i1It/ge8eM7FmcoWTV
         CCLy/r/Vr12YF/YsBFCYQLvx8AtVQrtNrlDD3l5A4+GEK+Rqjqy2da83XJFvcmmwi2WH
         jHKrGxAEh1/09ZXorU/j6pTp8fPmr69scYb3PYgynRReNrRWCse7kzTFeiE594nBCCdM
         KxJxuz7TYdraaNMmqBGAxvWWLd+NzcixDM+fLViqBKAoqPutXmgrXmlV6jEvDV0ZpWlb
         uyX9v6qlo71LIVWwKqq1spwO/7CF5Xq2nbxJHmQEqLeQQw+4S4tfjseJ2i3hor/GeMhR
         rLBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wNiHe9qvjeLSIhDwarY1WjZQZ+c5iOrBNm9DgIHA17g=;
        fh=cITCtv8ENZndd4ZArOMBMuQjiPsROMbSuyNOP7fDtJ0=;
        b=Op/O7iZodUJUJjQ8Vyws+WPmqkRmjh0SYpuNUaIx0MhviXhWl9QQfhoDlqf+r6KeSP
         rZB8ieSSovi5U3zPeeaGxI0c7eRPieRPWPfvkHmwmjkgedOi1tvnxOF6Wl9s8KoKaC9a
         /J1x5yHJGi6vMZ+iAf3pnhD1bruZFIbR0WTRESTTCTjAzcDNdqQLrHITS4hlgjEdbh/Q
         vhWB5o2BstbImz3N5mOZuLnD7zdsFJ85/5wcCO8Wr+s/LxSXDkoW7SFiILn344s+V8Xe
         ZySFkYgG7hiVXt03RReq5gxmxnUPxtdlO92YKiBJ4V6oVfpW5kwuu9Q3Xr+2NWQ7sYgY
         HdZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795569769; x=1796174569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wNiHe9qvjeLSIhDwarY1WjZQZ+c5iOrBNm9DgIHA17g=;
        b=0G3N+u91D8EA8Sz4lrEzn15RIlrWVPJ2E237FQOueNDAY4bjYgW089rsVNFFaAKTOW
         bqY2sbhc6g64GFB3eD71YqRgz28MV7F8XeR5C/P6T76lpjIC02T38F34+iZ3yLbNhJer
         sVPbWrhgTHlP4ECfcZCrfEhtZPR8NDoq+l9Z9TJVqaHN/JnZtGWC7tgEQhPKSXSiO8PF
         KGx54fL7Ddmi766AnCqQnS+K+xDpTdwBlkrBfelM6Sd4IIkMqqN3xo6zFM1dbTkcJqQ3
         VdyzHhbldRwobIAGmuewnJZyLpltQu9+F/njcOSPpyzCL59hxdJArNTJgcyT1jZCc594
         Dfng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795569769; x=1796174569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wNiHe9qvjeLSIhDwarY1WjZQZ+c5iOrBNm9DgIHA17g=;
        b=zoK1DYRiIJnVO08ZRb3bYdxc/oQwYrw/CIVCmU3F0yXusxZH8mzCxGDyiwA+lIdViE
         pgYABLqx60xiJDVp8W21+Bjs8MX9nQEXc2WTpvRHH5DIy8mdfeETRRNWymt9AKq/21DA
         rgnEHNkk/AOdLqR2yoNjHoi74+uzv54CccN3dM3luhAZ3JVOTCv36x61K/xHJSFEwV7O
         cHf/ZkOGiYHy1z2ppAbLIIDUQxsu+0jACqUN/fESTXfyVtUGUP/AIXdy+z0T/oXMcKb4
         8h6FSvYHnHrrXSvTOoGdg3eV3m/FbQh7YQi1LMuk5RzQIoV85JoQ5JAIql/mbAXi9HcE
         bd8g==
X-Forwarded-Encrypted: i=1; AL+hErGYjvA8QUI/4aSdmwRrRFOHVkVHTIPTy8FdqpZ9YxitY61GNPk0M38KASfhnRn3UgO70M4bl38=@vger.kernel.org
X-Gm-Message-State: APuU4Z//8hRuoUXOJ8uVfmcQO13+QTYIiVBzPSRQD7AA9z7u8CXyTVgI
	5imiG3Rl5ZmBiVpNlpbG1r5Scgy+LKU4z6xdMxHZkJa61FAfXbP0J7IywQoNDwSRQM3ecFb7OBb
	oSEct2e7quHLl++0zTHibxFPJZ59iWnY=
X-Gm-Gg: AZFdTZdjJrf3Et6+GSb0R4uTNMf970zZAv04epPzmBeVTQs9l8CGEsaPhhyHSMgjZv3
	ienXOH3FRFwuxj95cZWscLV7zMzDsSSKDHL5szrg0Gi/NBVCB+ZZ9X3u5jZWYIq6Zl45DB+ozr+
	rnKfLnFCoqCHfyAi3ndb4sabV/c+mOXtooDs4wpFfo7T3hQdeMoQh4Lqx5YlC7nte6QmXfekAU6
	pLIpGimU/qts0BKWAOd6qDhZvmS7Wb/xvUJQdqk/9PwnkAo+3ql8YRKXAM71pJgqvzFJV7Xh5hp
	K3bjP7pa85eZkXWcvL1pXKPDb8UHFJ6M37RqPx3lHuGefIWuxFQilzNlo8KFOpIGh6VKzyR4CpM
	smQfsyk9o5r9UYtgxbfvZLueXQCS3ckXPmkZTuIMeULmIzdjLy0SPJsNgfKmcbz2C68BwG4RWfz
	su8VVJkipkZNqBbHfeVqjL7BiF
X-Received: by 2002:a17:90b:2792:b0:3ac:4e18:238c with SMTP id
 98e67ed59e1d1-3b41cb0c476mr13175916a91.49.1795569769043; Tue, 24 Nov 2026
 17:22:49 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121070804.26185-1-alfonsocvu@gmail.com> <sashiko-outbox-226770@kernel.org>
 <CAJ=mrFowQNahOjD-NQzcuJCjPE=efvDK85kMpseRUrqYBwX3Sw@mail.gmail.com> <20261123054042.GL229695@black.igk.intel.com>
In-Reply-To: <20261123054042.GL229695@black.igk.intel.com>
From: Alfonso Villalobos <alfonsocvu@gmail.com>
Date: Tue, 24 Nov 2026 19:22:37 -0600
X-Gm-Features: Aa3M54pT0_8tgO6P1r4mw5msEUdOT3vfDvbG2P3XisMd4UFaW0VbA8wVLw_bRT4
Message-ID: <CAJ=mrFqe1ujyq5oX==HQ8MsBRNb_64dPZz7aHg5LYBYtKVOGvg@mail.gmail.com>
Subject: Re: [PATCH] thunderbolt: Re-add host router DP IN adapters after DPRX failure
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: sashiko-reviews@lists.linux.dev, westeri@kernel.org, 
	linux-usb@vger.kernel.org, andreas.noever@gmail.com, YehezkelShB@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the details.

> Does the RX 9070 driver poll for a new connections periodically like the
> i915/xe or it supports PME?

It doesn't poll. When I looked into adding it, the GPU had no way to
check the connectors without taking the core out of suspend. After a
wake it stays on for about 5s, so polling every 10s would eat most of
the savings BACO is supposed to give. I haven't actually measured it.

The card does support PME, but in my testing a hotplug on the TB side
doesn't wake it up. From the amdgpu code, PME seems to be used for the
audio function and only while the card is active.

So I think the problem has two parts. On the GPU side, PME wake on DP
hotplug looks like a firmware limitation. I'll share my findings with
AMD and see what can be done there, but I'm not sure how much I can do
from here. On the TB side, the host router never sent a new hotplug
for 0:10 after the DPRX failure, so I still think the patch is useful.

Thanks,
Alfonso

On Sun, Nov 22, 2026 at 11:40=E2=80=AFPM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Sat, Nov 21, 2026 at 09:07:04AM -0600, Alfonso Villalobos wrote:
> > Hi Mika, hope you're having a great day.
> >
> > I'd like to check the direction with you before doing v2. After the
> > Sashiko review and looking closer at how host router DP IN adapters
> > are handled, I'm not sure v1 fixes this in the right place.
> >
> > The DPRX failure happens when the RX 9070 XT feeding 0:10 is in BACO.
> > With runtime PM disabled for the GPU it always works. After the
> > failure the host router never sends a hotplug for 0:10, so it stays
> > unused until something triggers the re-check from v1, here me
> > replugging the dock at 00:27:26:
> >
> >   [00:26:36] 0:10 <-> 1:11 (DP): activating
> >   [00:26:36] 0:11 <-> 1:12 (DP): activating
> >   [00:26:48] 0:10 <-> 1:11 (DP): not active, tearing down
> >   [00:26:48] 0:10: DP IN resource unavailable: DPRX negotiation failed
> >   [00:27:26] 0:10: DP IN resource available
> >   [00:27:26] 0:11 <-> 1:11 (DP): activating
> >   [00:27:26] 0:10 <-> 1:12 (DP): activating
>
> Does the RX 9070 driver poll for a new connections periodically like the
> i915/xe or it supports PME? The current DPRX timeout is pretty much
> following the i915 that has 10s polling period so simple way of working
> this around is to set thunderbolt.dprx_timeout=3D to match that.
>
> > The DP OUTs also end up swapped, so the ordering part of v1 doesn't
> > work as intended either.
>
> At the moment tunnels are created pretty much in the order the hotplugs
> arrive.
>
> > The comment in tb_dp_tunnel_active() and the redrive code both seem
> > to expect a hotplug for host DP IN adapters. Is the ASM4242 supposed
> > to send one once the GPU starts driving the DP IN? If this is
> > ASM4242 specific I can limit the fix to it with a quirk.
>
> The hotplugs should happen when the host router is enumerated so for
> example in your case it should work so that if graphics did not do DRPX
> capability exchange in time, the DP tunnel is torn down and if conditions
> are right the domain is put to sleep. When you wake it up there should be
> new hotplugs to DP INs so the resource is added back to the list.
>
> > v1 also only recovers on a new event. The alternative I had in mind
> > is retrying the DP IN a few times with a delay after DPRX fails, so
> > it recovers without a replug. Which is better?
>
> Can you first check if drpx_timeout=3D helps in your case? If it does, fo=
r
> simplicity one option is that we just make the default match the "biggest=
"
> and some slack.
>
> > I already have fixes for the Sashiko comments (the missing
> > tb_exit_redrive() and the ordering in tb_dp_resource_available()) and
> > one to skip DP IN adapters that are already in a tunnel, but I'd like
> > your opinion before spending more time on it.
> >
> > Thanks,
> > Alfonso
> >
> > On Sat, Nov 21, 2026 at 1:25=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
> > >
> > > Thank you for your contribution! Sashiko AI review found 2 potential
> > > issues to consider:
> > > - [Medium] thunderbolt: missing tb_exit_redrive() in
> > >   tb_add_dp_resources() leaks RPM ref
> > > - [Medium] thunderbolt: list_add_tail() in tb_dp_resource_available()
> > >   breaks DP IN order
> > > --
> > >
> > > commit 4eedd8886dc180b45204d935f18725051dd0e6a0
> > > Author: Alfonso Villalobos Ulate <alfonsocvu@gmail.com>
> > >
> > > thunderbolt: Re-add host router DP IN adapters after DPRX failure
> > >
> > > This commit re-checks host router DP IN adapters when a new DP OUT ad=
apter
> > > becomes available or a device router is scanned, keeping host DP IN
> > > adapters ordered by adapter number on tcm->dp_resources.
> > >
> > > > diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
> > > > index 418ad0a61a5de..1f3dea836067e 100644
> > > > --- a/drivers/thunderbolt/tb.c
> > > > +++ b/drivers/thunderbolt/tb.c
> > > > @@ -109,6 +109,29 @@ static void tb_queue_hotplug(struct tb *tb, u6=
4 route, u8 port, bool unplug)
> > > >
> > > >  /* enumeration & hot plug handling */
> > > >
> > > > +/*
> > > > + * Insert a host router DP IN adapter so that host DP IN adapters =
stay
> > > > + * in adapter number order. A DP IN that is re-added after it was
> > > > + * dropped (for example because DPRX negotiation failed) then gets
> > > > + * paired with the same DP OUT as before, instead of swapping DP O=
UT
> > > > + * adapters (and therefore monitors) with the other host DP IN.
> > > > + */
> > > > +static void tb_add_host_dp_in(struct tb_cm *tcm, struct tb_port *p=
ort)
> > > > +{
> > > > +     struct tb_port *p;
> > > > +
> > > > +     list_for_each_entry(p, &tcm->dp_resources, list) {
> > > > +             if (tb_port_is_dpin(p) && !tb_route(p->sw) &&
> > > > +                 p->port > port->port) {
> > > > +                     /* Insert before the first higher numbered on=
e */
> > > > +                     list_add_tail(&port->list, &p->list);
> > > > +                     return;
> > > > +             }
> > > > +     }
> > > > +
> > > > +     list_add_tail(&port->list, &tcm->dp_resources);
> > > > +}
> > > > +
> > > >  static void tb_add_dp_resources(struct tb_switch *sw)
> > > >  {
> > > >       struct tb_cm *tcm =3D tb_priv(sw->tb);
> > > > @@ -118,6 +141,9 @@ static void tb_add_dp_resources(struct tb_switc=
h *sw)
> > > >               if (!tb_port_is_dpin(port))
> > > >                       continue;
> > > >
> > > > +             if (!list_empty(&port->list))
> > > > +                     continue;
> > > > +
> > > >               if (!tb_switch_query_dp_resource(sw, port))
> > > >                       continue;
> > > >
> > > > @@ -130,7 +156,7 @@ static void tb_add_dp_resources(struct tb_switc=
h *sw)
> > > >               if (tb_route(sw))
> > > >                       list_add(&port->list, &tcm->dp_resources);
> > > >               else
> > > > -                     list_add_tail(&port->list, &tcm->dp_resources=
);
> > > > +                     tb_add_host_dp_in(tcm, port);
> > > >
> > > >               tb_port_dbg(port, "DP IN resource available\n");
> > > >       }
> > >
> > > [Severity: Medium]
> > > Does re-adding a host router DP IN port through tb_add_dp_resources()=
 leak
> > > the runtime PM reference on sw->dev when the port was in redrive mode=
?
> > >
> > > On host routers with QUIRK_KEEP_POWER_IN_DP_REDRIVE, tb_enter_redrive=
()
> > > sets port->redrive and calls pm_runtime_get(&sw->dev).  When
> > > tb_add_dp_resources(tb->root_switch) now runs at runtime from
> > > tb_scan_port() or tb_dp_resource_available(), it adds the host DP IN =
port
> > > to tcm->dp_resources without calling tb_exit_redrive(port).  Any late=
r
> > > tb_dp_resource_available() call for that DP IN port then returns earl=
y
> > > because the port is already on tcm->dp_resources (or already enabled =
by
> > > tb_tunnel_dp()), leaving port->redrive set and preventing the host ro=
uter
> > > from suspending.
> > >
> > > [ ... ]
> > >
> > > > @@ -2234,6 +2272,14 @@ static void tb_dp_resource_available(struct =
tb *tb, struct tb_port *port)
> > > >       list_add_tail(&port->list, &tcm->dp_resources);
> > > >       tb_exit_redrive(port);
> > > >
> > > > +     /*
> > > > +      * Host router DP IN adapters removed because DPRX negotiatio=
n
> > > > +      * failed never get a hotplug event of their own. Give them
> > > > +      * another chance now that a DP OUT became available.
> > > > +      */
> > > > +     if (tb_port_is_dpout(port))
> > > > +             tb_add_dp_resources(tb->root_switch);
> > > > +
> > > >       /* Look for suitable DP IN <-> DP OUT pairs now */
> > > >       tb_tunnel_dp(tb);
> > > >  }
> > >
> > > [Severity: Medium]
> > > Should tb_dp_resource_available() also use tb_add_host_dp_in() when a=
dding
> > > a host router DP IN port?
> > >
> > > When a lower-numbered host DP IN port becomes available via hotplug i=
n
> > > tb_dp_resource_available() (such as when exiting redrive mode or afte=
r
> > > resume) while a higher-numbered host DP IN port is already on
> > > tcm->dp_resources, list_add_tail() places the lower-numbered port aft=
er
> > > the higher-numbered one, breaking the adapter ordering that
> > > tb_add_host_dp_in() maintains.
> > >
> > > --
> > > Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/2026112107080=
4.26185-1-alfonsocvu@gmail.com?part=3D1
