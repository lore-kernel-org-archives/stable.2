Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AF5417D8C;
	Wed,  5 Aug 2026 09:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923832; cv=none; b=ZeuNVsRPGdCITXyRttF2Cuu6ilsMHW2FmVNgv8YVgVpeBcnox4f1bD4hHZrykB5TWM2P0VZWMwlyxhPgn/z1rJCpPD4GrBfjmp6wGDrU9wZAg5tKMZjGhoozz7qWAglc/vjKUpuVBRHYSTLrnUYZLDkHz0jRM9r159/NsXerbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923832; c=relaxed/simple;
	bh=KcLO1RK5lnGAsC7d+SlNu0KKWBoF6yeguQllEya2LPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q5KVnpPfpy4Qcu3bQrvvIpRam+oUzD2IrDFtdNz+GQclGlcTW0X1dq3BRoo/AelEmOeb0RuC8XZCCs+B5uTNYIC2K6pYAgei2DmgYBGodTuI/hLefMgTSA013jo0EqvbG5u0fH/8Bvfe6lq96e9aRgNh2UEBiuyEOcPXJ9RDsho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fKq6tk+s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fKq6tk+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A416B1F00A3A;
	Wed,  5 Aug 2026 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923830;
	bh=Bphk0/zegifSMIWWkNrW+dxxf8hco/IatcqgGzaEPPc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fKq6tk+se54tZhdXO0bwFRGjGgyI1rF2cuSyHlefuX1FFjne1qyYTLzNKgqRJ6r9i
	 2GfdO7mJq82j/ezhPosM0HIcVp/fX39zFeXJD+PHhTEEN5cKjMZbImHjqKg1Ha9UCs
	 0XGt8V0ln+ev/batsHyIp4/0XyONFEXIsT18zXXfZOVKyZRfRr+Ais5npSirlVtLhK
	 ay9KLFSZHPnCVJEgT9zFoubis3aOCzC2rlmOAfVtN0xZ10oLvhtBDUO5D8cgSimt38
	 nrNRoY1TRioOTVtu+IUy3StdsSwDqb1hvdPNsVoOGsJErqviQ3xGzSRrWtqwtHjDxd
	 0qNwnJk8jlUew==
Date: Wed, 5 Aug 2026 10:57:06 +0100
From: Simon Horman <horms@kernel.org>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH] net: 8390: pcnet_cs: release PCMCIA window on
 setup_shmem_window() error
Message-ID: <20260805095706.GO51943@horms.kernel.org>
References: <20260731161740.44955-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731161740.44955-1-mhun512@gmail.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731161740.44955-1-mhun512@gmail.com?part=1
---
--- Patch [1]: [PATCH] net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error ---
commit 74f57c39e62b4fcd24846cf9fc7fe9cbcd03cfe3
Author: Myeonghun Pak <mhun512@gmail.com>

net: 8390: pcnet_cs: release PCMCIA window on setup_shmem_window() error

This routes the post-pcmcia_request_window() error paths in
setup_shmem_window() through a new "release" label that calls
pcmcia_release_window(), and folds the existing buffer-verification
cleanup into it. The pcmcia_request_window() failure path is left
returning directly.

A few questions below, mostly about the changelog and about the
surrounding code in the function being reworked.

[Severity: Low]
[Finding: main-1-0]
[Sources: opus-5]
The changelog states:

    The requested window is leaked.

and carries Cc: stable. Is "leaked" the right description here? On the
success path pcmcia_request_window() stamps the map bits into the
resource flags:

    res->flags |= (win->map << 2) | IORESOURCE_MEM;

and pcmcia_disable_device() then walks every window resource and
releases the ones still carrying those bits:

    for (i = 0; i < MAX_WIN; i++) {
            struct resource *res = p_dev->resource[MAX_IO_WIN + i];
            if (res->flags & WIN_FLAGS_REQ)
                    pcmcia_release_window(p_dev, res);
    }

Both the pcnet_config() failure path and pcnet_detach() reach
pcnet_release() -> pcmcia_disable_device(), so the window looks like it
is reclaimed at device teardown rather than lost for good.

Would it be more accurate to say socket window 3 and its reserved iomem
range stay held for the whole bound lifetime of the device even though
the driver has fallen back to setup_dma_config()? That wording would
also help stable backport triage, since the current text reads like an
unbounded leak that survives card removal or module unload.

> diff --git a/drivers/net/ethernet/8390/pcnet_cs.c b/drivers/net/ethernet/8390/pcnet_cs.c
> index 19f9c5db3f3ba..a913674be60ac 100644
> --- a/drivers/net/ethernet/8390/pcnet_cs.c
> +++ b/drivers/net/ethernet/8390/pcnet_cs.c
> @@ -1434,14 +1434,14 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      offset -= offset % window_size;
>      ret = pcmcia_map_mem_page(link, link->resource[3], offset);
>      if (ret)
> -	    goto failed;
> +	goto release;
>  
>      /* Try scribbling on the buffer */
>      info->base = ioremap(link->resource[3]->start,
>  			resource_size(link->resource[3]));
>      if (unlikely(!info->base)) {
>  	    ret = -ENOMEM;
> +	goto release;
>      }

[Severity: Low]
[Finding: main-1-1]
[Sources: opus-5]
This isn't a bug, but the indentation of the two new goto statements
differs from the code they replace and from the statements around them.
The file uses tab+4 spaces at this depth, and the new gotos use a single
tab. In the ioremap() block the two statements of the same brace block
now sit at different columns:

    if (unlikely(!info->base)) {
	    ret = -ENOMEM;
	goto release;
    }

which makes the goto read as if it were outside the if block. Could
these keep the surrounding style?

>  
>      for (i = 0; i < (TX_PAGES<<8); i += 2)
> @@ -1452,9 +1452,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      pcnet_reset_8390(dev);
>      if (i != (TX_PAGES<<8)) {
>  	iounmap(info->base);
> -	pcmcia_release_window(link, link->resource[3]);
>  	info->base = NULL;
> -	goto failed;
> +	goto release;
>      }

[Severity: High]
[Finding: main-7-3]
[Sources: opus-5]
This is a pre-existing issue and not introduced by this patch, but it is
in the function being reworked, so it seems worth raising.

Does setup_shmem_window() mix up the card-side window base with the
host-side displacement into the ioremap() mapping? offset is computed as
a card address rounded down to a window boundary:

    offset = (start_pg << 8) + cm_offset;
    offset -= offset % window_size;
    ret = pcmcia_map_mem_page(link, link->resource[3], offset);

That is correct for pcmcia_map_mem_page(), which stores it as
s->win[w].card_start. But the same value is then used as a byte offset
inside the host mapping:

    for (i = 0; i < (TX_PAGES<<8); i += 2)
	__raw_writew((i>>1), info->base+offset+i);
    udelay(100);
    for (i = 0; i < (TX_PAGES<<8); i += 2)
	if (__raw_readw(info->base+offset+i) != (i>>1)) break;

With the default parameters (start_pg == PCNET_START_PG == 0x40,
cm_offset == 0) window_size is 0x4000 and offset stays 0x4000, while the
ioremap() covers exactly resource_size(link->resource[3]) == 0x4000
bytes. Doesn't that put the whole scribble loop at info->base + 0x4000
through +0x4bff, entirely past the end of the mapping, so the write
either faults on the ioremap guard page or lands in a neighbouring
device mapping?

Should the host displacement be the remainder instead, i.e.
((start_pg << 8) + cm_offset) % window_size?

The derived values look affected the same way:

    ei_status.mem = info->base + offset;
    ei_status.priv = resource_size(link->resource[3]);
    ...
    ei_status.stop_page = start_pg + (
	    (resource_size(link->resource[3]) - offset) >> 8);

In the default case that gives stop_page == start_pg, and for
USE_BIG_BUF (start_pg 0x01, cm_offset 0x10000, window_size 0x8000)
offset becomes 0x10000 so resource_size() - offset underflows in
unsigned resource_size_t arithmetic.

Reaching this needs use_shmem=1 on the module line plus a supported
card, since has_shmem is always 0 (pcnet_confcheck() does *priv &= 0x10
on a value that is only ever 0 or 1). Given that, is the shared-memory
path here exercised at all, and does that change how the changelog's
"probe can continue and even succeed" claim should be phrased?

>  
>      ei_status.mem = info->base + offset;
> @@ -1475,6 +1474,8 @@ static int setup_shmem_window(struct pcmcia_device *link, int start_pg,
>      info->flags |= USE_SHMEM;
>      return 0;
>  
> +release:
> +	pcmcia_release_window(link, link->resource[3]);
>  failed:
>      return 1;
>  }

Simon says: I think the pre-existing problem described below
            is out of scope for your patch.

[Severity: Medium]
[Finding: main-2-2]
[Sources: opus-5]
This is a pre-existing problem in the PCMCIA core rather than something
this patch introduces, but it touches the assumption stated in the
changelog:

    The pcmcia_request_window() failure path still returns
    directly, as no window is held there.

Is that always true? pcmcia_request_window() allocates the system memory
region and sets the client bit before programming the mapping:

    p_dev->_win |= CLIENT_WIN_REQ(w);

    /* Configure the socket controller */
    win->map = w+1;
    ...
    if (s->ops->set_mem_map(s, win) != 0) {
            dev_dbg(&p_dev->dev, "failed to set memory mapping\n");
            mutex_unlock(&s->ops_mutex);
            return -EIO;
    }

On that -EIO return win->res stays allocated, the _win bit stays set,
and res->flags never receives the (win->map << 2) marker that is only
written on the success path. Both cleanup helpers key off exactly that
marker:

    w = ((res->flags & IORESOURCE_BITS & WIN_FLAGS_REQ) >> 2) - 1;
    if (w >= MAX_WIN)
            return -EINVAL;

and in pcmcia_disable_device():

    if (res->flags & WIN_FLAGS_REQ)
            pcmcia_release_window(p_dev, res);

WIN_FLAGS_REQ is 0x1c, and the flags pcnet_cs sets here
(WIN_DATA_WIDTH_16 | WIN_MEMORY_TYPE_CM | WIN_ENABLE | WIN_USE_WAIT)
contain none of those bits, so the half-held window would be invisible
to pcnet_release() -> pcmcia_disable_device() too.

This looks reachable from pcnet_cs with mem_speed above 1000, where
yenta_set_mem_map() rejects the mapping on mem->speed > 1000 and
pcmcia_request_window() takes that -EIO path. Does that mean the
struct resource from pcmcia_find_mem_region() and the reserved host
iomem range can no longer be released by any in-tree caller, and that
window index w can later be reused with win->res overwritten?

Adding a release label for that branch would not help while res->flags
lacks the marker bits, so it may be worth noting that the core is where
this one has to be fixed.
