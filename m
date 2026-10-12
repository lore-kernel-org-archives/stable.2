Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D028397922;
	Mon, 12 Oct 2026 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791823710; cv=none; b=ocQQL4JkwXRYwksfkyjMrLcFil9R6DRm/qPYdfcmkUesvuFhoXKzkHabto9GGTKqtRnzZn6OiOAGlvI5I1eK7syq/jRywIp/wYDAvC0gFS+2LLUom/M8Vf7eoovkTOGV8tRtzI41pn7CnNPo7jYIgRqzdHb4lrseR70V893EDlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791823710; c=relaxed/simple;
	bh=mMH0te/tvNL90Fzjix9Jb5/yQwN4Tz8Lrk+WcISK7iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/q5dghhTCS/KM94BgDQM15VWRXT8lSGLyzNckWgyWohThCkTsg/mQZOFw6M+K9p0CpNTYOfUWC1HaDua9RjIJExxvxTmDtZLjejmASCi7svDn1l8KsRaxxbpDVWDy/OKgUdLfK+9BcXTo7vvhsDNzzxiwXXn90OkarjASk1nns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3Bv9WpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3Bv9WpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03C811F0089B;
	Mon, 12 Oct 2026 16:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791823708;
	bh=a5mP5nC8nPPlsIQNVn0JofAMSDeCWtdkqJAfFM+RFQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L3Bv9WpIFj/9+8iEAITVKPt4r5u7esiQ99zdQTN/X2zfuuFoP2dz6VzLMoqk3x9BQ
	 GiLCQlJGaQxTJCrvXNxDmBAuMw3N+bY6qTDzPKdoYtI0gvsNqz5yvdUJsQyfkFyt81
	 S/rOIQdH2eICo1+xmN0VSiSQAbtq/cdHYvZQ7x8kT9A5nAv8HMAJXLIcMh/6gGv/gw
	 4EvSr6CyH6yHeHr4gAB7OMdimisJsFYFcRRPqYn0ov1k6kvSqO0rd8b+PEeOW7YyL5
	 Wv+O+KUKBFbNKjFZSWFPhH4ZavfUfUszcFlgm4HbAhj+hDRfLppJAjvauEz12Opvso
	 2rvU1oKXl6MNQ==
Date: Mon, 12 Oct 2026 17:48:20 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Helge Deller <deller@gmx.de>, 
	Javier Martinez Canillas <javierm@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Bruno =?utf-8?Q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, Bernie Thompson <bernie@plugable.com>, 
	Greg Kroah-Hartman <gregkh@suse.de>, Steve Glendinning <steve.glendinning@shawell.net>, 
	Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
	Steve Glendinning <steve.glendinning@smsc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 0/6] fbdev: fixup callers which ignore errors from
 fb_deferred_io_init()
Message-ID: <as0PDmzYL5Bc2NrR@gremlin>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>

On Sat, Sep 26, 2026 at 02:16:58PM +0100, Lorenzo Stoakes (ARM) wrote:
> Commit 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
> converted fb_deferred_io_init() from a void function to one returning an
> error value.
>
> However a number of callers don't seem to have been apprised of the fact
> and continue to treat it like a void function.
>
> This is problematic, as upon allocation failure, struct
> fb_info->fbdefio_state is NULL.
>
> That means when a subsequent operation is performed upon the driver, for
> instance opening the file, a NULL pointer dereference occurs.
>
> Update all of the remaining drivers which fail to check this to do so.
>
> This issue was discovered as part of a separate series which updated logic
> belonging to ssd1307fb.
>
> Also fix up a separate issue with a BUG_ON() occurring on allocation
> failure for udlfb and smcufx.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
> Lorenzo Stoakes (ARM) (6):
>       fbdev: ssd1307fb: check for fb_deferred_io_init() error
>       fbdev: xen-fbfront: check for fb_deferred_io_init() error
>       HID: picoLCD: check for fb_deferred_io_init() error
>       fbdev: udlfb: check for fb_deferred_io_init() error
>       fbdev: smscufx: check for fb_deferred_io_init() error
>       fbdev: sh_mobile_lcdc: check for fb_deferred_io_init() error

Ping on this!

I know timing is awful given a. the insane volume this cycle and b. LPC,
but these are fairly mechanical things so should be relatively
straightforward.

>
>  drivers/hid/hid-picolcd_fb.c           | 12 +++++++++---
>  drivers/video/fbdev/sh_mobile_lcdcfb.c |  6 +++++-
>  drivers/video/fbdev/smscufx.c          |  9 ++++++---
>  drivers/video/fbdev/ssd1307fb.c        |  6 +++++-
>  drivers/video/fbdev/udlfb.c            |  9 ++++++---
>  drivers/video/fbdev/xen-fbfront.c      |  7 ++++++-
>  6 files changed, 37 insertions(+), 12 deletions(-)
> ---
> base-commit: 6812ce4e4379ffc99c52401ec28f0d7ffbc36206
> change-id: 20260926-fix-fbdefio-error-handling-ab135b0193cb
>
> Best regards,
> --
> Lorenzo Stoakes (ARM) <ljs@kernel.org>
>

--
Cheers, Lorenzo
