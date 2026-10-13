Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2713E024B;
	Tue, 13 Oct 2026 10:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791886643; cv=none; b=dZpeCloMdf66LNgeSgTYuQN9R/pZM3r3i6okJnCZ5Xfd78QYKjnT25XTeHJydynLBOONA2paneHDpNBfygfQLkclg43kTHk3bFTh+rRxHK9Vs/8Q/VvtVHY7KwPaNwgg01Ogwy7oM76wdn6M6+5fclGS4FZjZN60Ff65sBcAB8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791886643; c=relaxed/simple;
	bh=xW1xfCK3CcQJg+iUUaedOewxhTwufQNR2Ay0ZLu/bm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8rKB3gFil7dRwICgTjdBF8t1UXZHxYRKvBd9wOf7KFtS6hIiOtxis/JMcuHh0VeVBsaFpXFRFxJcnJXymTmXXRe2TqCAXd8ce4atS+PVEoI8Cc248AZ28mVjRu4VGEIwRe2DwpU5K55AJCkBpUWsiAhVxpOMsyuBMj+kgFdpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LE8C4S+t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LE8C4S+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FAE1F0089B;
	Tue, 13 Oct 2026 10:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791886642;
	bh=+1orckk5TDonj1Pfd94IRivAv/Y3Td0C0ziuGJKZt/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LE8C4S+tcOcFoWZ00P87fRoO2jA/fP0mMFiLt8h7tmCjSVr5AHzI2KzE4FH56/Sox
	 sKv+1ZRcMa8CsL9BiMasLbUxdbtqNcC5147hc2MgD5UxQBrtxDiiE/yHTV6ndelkol
	 ky/ivnselfKcSL2DfMl3e8KtpuWA0KV2eegoBJqwLAmvRwREanPF83YkreJ6NVTSVs
	 dLQ4qa66tKql+2DObnlw4zDUf2waZk5i1f5nseStxtNfT5iF0mnj/jrtWfDq4ogcXe
	 tdkmUjpsAFDQu1UhiKg7e7i9VH07ffedPwyeSA+uIWlMP/vc52hOQxpENUKasnSqlw
	 j7s5wb6+dtIUQ==
Date: Tue, 13 Oct 2026 11:17:15 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
	Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
	Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Steve Glendinning <steve.glendinning@shawell.net>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-input@vger.kernel.org, Steve Glendinning <steve.glendinning@smsc.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 0/6] fbdev: fixup callers which ignore errors from
 fb_deferred_io_init()
Message-ID: <as4FBVzand0KlUU-@gremlin>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
 <as0PDmzYL5Bc2NrR@gremlin>
 <fd60a2c8-e4e4-4599-8453-78c3c0e96936@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd60a2c8-e4e4-4599-8453-78c3c0e96936@gmx.de>

On Mon, Oct 12, 2026 at 11:07:38PM +0200, Helge Deller wrote:

> On 10/12/26 18:48, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Sep 26, 2026 at 02:16:58PM +0100, Lorenzo Stoakes (ARM) wrote:

> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > > Lorenzo Stoakes (ARM) (6):
> > >        fbdev: ssd1307fb: check for fb_deferred_io_init() error
> > >        fbdev: xen-fbfront: check for fb_deferred_io_init() error
> > >        HID: picoLCD: check for fb_deferred_io_init() error
> > >        fbdev: udlfb: check for fb_deferred_io_init() error
> > >        fbdev: smscufx: check for fb_deferred_io_init() error
> > >        fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error
> >
> > Ping on this!
>
> Thank you for those patches!
> I've applied them now to the fbdev/for-next git tree.

Great thanks!

>
> > I know timing is awful given a. the insane volume this cycle and b. LPC,
> > but these are fairly mechanical things so should be relatively
> > straightforward.
> Yes, but still I hesitate to push it for 7.3, as it seems quite unlikely
> that a normal installation will run into this memory leak.
> So, I think this can wait for 7.4-rc1, right?

Sure that's fine! These have been latent for ages so I think we can survive
waiting until 7.4 for that :)

--
Cheers, Lorenzo
