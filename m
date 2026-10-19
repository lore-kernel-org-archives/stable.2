Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792435138;
	b=TugL7OxI57Ei2GgguX9hxPuTNuN63+Twz26VXDtyIf+fvuNj01C6oAj/onc1470eTXUm
	 mz9WtGBYrQdufEGbPLJtAIvyl+dZ//8F1cuMyHpGwXA+jCN6XtDpwYBIEiqpezTZU98mn
	 0JCkdR8kouAQs+qJG0pvSi3zQQ4WXTf2Dkw59uSufTnsf7h2GQoBSwHIokO14b8ass+Le
	 Um3nbHgGoiUmpMBua3BsPScob0+/jnWer2fn3AmYa+wHh9qrkD+xZxV5CnA8MliX3yoz6
	 +dyZ6rHoVip2Hvw/1SMazJ0AugQSmJKghsvF3GKeeqBQVoznkZbQBDcRu4drtQZJsOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792435138;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=WD0sxxOEa2MH/26Of97hfhUgNRTbd2CMOIAfQQomIVQ=;
	b=LkSMO0IP4YXqvVJKAgUnJq07n+OSaQ19vXbroYj08H9b9wVmWnDHsRYmR1RIaOWJgbHQ
	 eWPFCfMdhDAHWN2od1G2+K4TlVClq+TZkYJBb5g3Li3TnSSBXSSonMNu8BfvTNMv3TkI+
	 2m8TFed/WvcE0EzDvyAXMhO4cJ1NNzybxyojUFGfZjCCHgxrK5finnZuFwNy3rEjZt/jQ
	 uZI/bQo7CU3dXKpdMYJiK+OlLcfTcIFt5zxu/eSQzVU+WbVmNxMgolRf0uIIhg3dbHNGk
	 YonBm6K+6IK8Z+XKUiB29QWw5d34V7UEGjPHM83znEIJyQiGuy76RZdrD8upo7r6/NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QFrIhmZz;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44749606A31C;
	Mon, 19 Oct 2026 18:38:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44749606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=QFrIhmZz
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id D835B20B7168; Mon, 19 Oct 2026 11:38:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D835B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792435125;
	bh=WD0sxxOEa2MH/26Of97hfhUgNRTbd2CMOIAfQQomIVQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QFrIhmZzIMPBGY64mWtf+3NR6uH3EB3JlBXo0QXV3jvxAbbI/E8UzVwejCDOw51Ds
	 Ptxp6sbnElE7JeLGl2miDRdYvO86EHm6Sex4sdjtioZBWUPfamKuxts5v/WOf17DtV
	 kUm/cFm1sltOW4+7i4jss/HN3HB4VwG2cqkj7fdg=
Date: Mon, 19 Oct 2026 14:38:45 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Lanfeng Wei <xlfylawarthur@gmail.com>, airlied@gmail.com,
	decui@microsoft.com, dri-devel@lists.freedesktop.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	longli@microsoft.com, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, regressions@lists.linux.dev, simona@ffwll.ch,
	ssengar@linux.microsoft.com, stable@vger.kernel.org
Subject: Re: [PATCH] drm/hyperv: add a parameter to disable the vblank timer
Message-ID: <atZjtSlZAocUWYBS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <c238f4ff-d5d8-4a9a-8773-793bd9056c9b@suse.de>
 <20261019154121.6257-1-xlfylawarthur@gmail.com>
 <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e91baa4-1ca5-43b8-bb04-9b5e3630bc2b@suse.de>

On Mon, Oct 19, 2026 at 06:03:55PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 19.10.26 um 17:40 schrieb Lanfeng Wei:
> > Hi Thomas,
> > 
> > > Yeah, what's the cause of it? Switching off features does not fix any
> > > bugs or improve the status quo.
> > You are right that the module parameter is only a workaround for users
> > affected; it does not fix the underlying scheduling problem.
> > 
> > The cause is that the synthetic vblank timer is used to pace completion
> > of atomic updates triggered by dirtyfb, in addition to providing
> > synthetic vblank events. In Xorg's software-cursor path, pointer motion
> > damages the primary framebuffer and the damage is instantly submitted
> > via DRM_IOCTL_MODE_DIRTYFB. The Hyper-V dirtyfb path performs a
> > synchronous atomic commit, and with the vblank timer enabled that commit
> > can wait for the next simulated vblank. Under continuous pointer motion,
> > these commits dominate the update path and delay normal client updates,
> > resulting in sever frame-rate drops.
> > 
> > This particular regression results from the combination of the blocking
> > dirtyfb path, synthetic vblank pacing, and the absence of a Linux DRM
> > cursor plane in Hyper-V. While the Hyper-V video protocol does have a
> > hardware-cursor command path, the upstream hyperv_drm driver currently
> > exposes only a primary plane. Cursor plane support was deferred during
> > the initial upstreaming [1]. Without a cursor plane, Xorg has to fall
> > back to software cursor-rendering path and it competes with periodic
> > graphical updates on the primary plane.
> > 
> > So the proper long-term fix could be adding cursor plane support in the
> > Hyper-V DRM driver, which may take some time. Providing that the stated
> > purpose of the offending commit is to rate-limit display updates, while
> > its current implementation regresses the existing software-cursor path,
> > I think adding a switch or reverting the commit until the requested
> > features in the driver is ready, is a reasonable short-term fix.
> 
> The problem is that module parameters are impossible to remove in practice.
> Once in place, someone always depends on it. They also increase the number
> of states to test.  Avoiding them is usually a good idea. Especially as
> workarounds for bug or regressions.
> 
> 
> I'm not familiar with the Hyper-V protocol, so I have a question. Why is it
> hard to implement cursors? From the link at [1], I assume that cursor
> support was left out because the simple-kms pipeline did not support cursor
> planes. This has long been resolved: the simple-kms pipeline is gone and
> hyperv_drm runs on the regular DRM framework.  Unless there's anything
> special with the Hyper-V protocol, cursor-plane support should be do-able in
> a single patch. [^1]
> 

I actually have been working on cursor plane support for hyperv-drm.
I'll post a patch soon.

Hamza

> Best regards
> Thomas
> 
> [^1] See https://elixir.bootlin.com/linux/v7.2.11/source/drivers/gpu/drm/ast/ast_cursor.c
> for an example of how this looks. Most of it is hardware-related, but hyperv
> would likely be similar in concept.
> 
> > 
> > > We had another fix for a problem with vblank timers:
> > > 
> > > https://lore.kernel.org/dri-devel/20260914110004.211027-1-tzimmermann@suse.de/
> > > 
> > > Did you validate that this fix is unrelated?
> > Yes I tested that fix and confirmed that it is irrelevant. It solves
> > issues with excessively long frame durations, however this problem is
> > found in normal frame updates (in my case 60Hz / 16.7 ms per frame, way
> > below INT_MAX).
> > 
> > Best regards,
> > 
> > Lanfeng Wei
> > 
> > [1] https://lore.kernel.org/dri-devel/20200622110623.113546-1-drawat.floss@gmail.com/
> 
> -- 
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
> GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
> 
> 
