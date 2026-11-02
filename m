Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614442;
	b=RRRlst6Jsl20RPJoqbKMmU0m6pLeONEslMIXIbmqSS8zpZTYnv0M00KDPtYsHxrbpDKc
	 XiJ9OxU1LsaTg35zREfyhhOiAE7rev5gFWonR3qnk6iR7+YhrFhK/o9Xd6xweHIUhrsbq
	 ++CfR1gNDaMnCU2THTTGfvF2SMQNYpJUL5zoGfYeISgBF9JKp3QaS2XRmifSUgkcDc2i8
	 xIFj513AUSoX87SLZnF5R10Pde67XarI2kUiKsikDaauc5ZM2qfALbb/nvZTHuUjhgC8o
	 jV9/FO8Yo/jeqXjk4JS5v3AB5EyzbJMQD1oIiPHDKXbxqK8QxGRSI9oSEC+tj14r7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614442;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9XxIqirAG9D56BcIeaHVZySoAG+yF8xDS5voiiVDsuA=;
	b=quhCibf5rAnIRLVZoeWymXLiDrWKLSubNLsmdhXCUsSkETzMORhYciojnrbq664K4aq5
	 XYiU5pWswJB3zv7ZTWrhSJA+UHLqtzkYzbCZIECTpgtDBIRFmzjQ9pStgWfttFxZIrmI2
	 Wlgjo128L2BH0BIwEeDNzvleFDPcbeoK3Dzy7kuJa6Z4RobuiCcDl6C4WN8W93IIUJ+qA
	 4mVVIVLqpSSblIob7cVu7Ln3YDKm50XPgdMQmjuDLcXeObWmrrrju7i9BdAaFg3qIVcFg
	 6KRWTVqiq+yVxzLWolqJzcW4NKbtyjOSlOSNxdbjABmGBwe/aZ9v6RDVHySLJtv+/cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFqYM9Or;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A28606A331;
	Mon,  2 Nov 2026 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LFqYM9Or
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6C11F00A15;
	Mon,  2 Nov 2026 10:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614441;
	bh=9XxIqirAG9D56BcIeaHVZySoAG+yF8xDS5voiiVDsuA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LFqYM9OrlIwewmMAudK8Nb2PgbWj38oj2L+52Pc86pKmF1yKSGXZZybmDJaCNkYog
	 frTq7cCZ3kZzJhvkTCyNDeeXGdXqSoqeKuOBC4KVETWzfkVnCXdcaQGOUw9OhFcflU
	 iMtAt6M3uylm3p6Q60suUSLPvd7oaSOPJgCImlgQ0BQa5s1C5+UX/VgywS0rHz9Dzb
	 MDBfhxsrhf9SYBk7qSp9YkSL2mGnrjxEW6mGo0wVNTnMshvRP+XXtm5KAaxWnL3dsC
	 huR/6o6dz+8c3UuMI1f5VMC5jaR//OrCZ9RqjglOOSt3iS8kyPanygIGlLkHY0VabP
	 LhcYoE9WTVt8A==
Date: Mon, 2 Nov 2026 10:13:56 +0000
From: Lee Jones <lee@kernel.org>
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Kai Svahn <kai.svahn@nokia.com>, syed khasim <x0khasim@ti.com>,
	Peter Ujfalusi <peter.ujfalusi@ti.com>,
	Samuel Ortiz <sameo@linux.intel.com>, linux-omap@vger.kernel.org,
	mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on
 teardown and probe failure
Message-ID: <20261102101356.GD13023@google.com>
References: <20261027093306.2812695-1-lee@kernel.org>
 <20261027093306.2812695-14-lee@kernel.org>
 <20261028165003.60d0c033@kemnade.info>
 <20261030104806.GC3774906@google.com>
 <20261030115241.642c5971@kemnade.info>
 <20261030112835.GD3774906@google.com>
 <20261030131049.10167177@kemnade.info>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030131049.10167177@kemnade.info>

On Fri, 30 Oct 2026, Andreas Kemnade wrote:

> On Fri, 30 Oct 2026 11:28:35 +0000
> Lee Jones <lee@kernel.org> wrote:
> 
> > On Fri, 30 Oct 2026, Andreas Kemnade wrote:
> > 
> > > On Fri, 30 Oct 2026 10:48:06 +0000
> > > Lee Jones <lee@kernel.org> wrote:
> > >   
> > > > On Wed, 28 Oct 2026, Andreas Kemnade wrote:
> > > >   
> > > > > On Tue, 27 Oct 2026 09:30:42 +0000
> > > > > Lee Jones <lee@kernel.org> wrote:
> > > > >     
> > > > > > twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
> > > > > > and checks for a non-NULL twl_priv at entry to reject multiple device
> > > > > > instances.  However, twl_remove() and the early error paths in
> > > > > > twl_probe() never reset twl_priv to NULL, a failure when adding MFD
> > > > > > child devices bypasses twl_remove() by jumping to free instead of fail,
> > > > > > and twl_remove() tears down the IRQ domain and dummy I2C clients before
> > > > > > child devices are unregistered.  After devres frees the underlying
> > > > > > memory on probe failure or unbind, twl_priv remains a dangling pointer,
> > > > > > causing subsequent exported API calls to dereference freed memory and
> > > > > > blocking future probe attempts with -EBUSY.
> > > > > > 
> > > > > > Unregister DT-populated and MFD child devices at the start of
> > > > > > twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
> > > > > > reset twl_priv to NULL in twl_remove() and on probe error exit.
> > > > > > 
> > > > > > Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
> > > > > > Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
> > > > > > Cc: stable@vger.kernel.org
> > > > > > Signed-off-by: Lee Jones <lee@kernel.org>    
> > > > > 
> > > > > Hmm, couldn't we use devm_add_action_or_reset() for resetting the
> > > > > twl_priv pointer? Feels more clean for me.    
> > > > 
> > > > Nice!  Thanks for the suggestion.
> > > > 
> > > > To keep this fix minimal for Stable backporting (and avoid resending a
> > > > 27-patch series), I'll take this one as-is and send a follow-up patch
> > > > converting twl_priv to use devm_add_action_or_reset().
> > > >   
> > > 
> > > I think the whole patch can be simplified a lot then, 
> > > 
> > > devm_mfd_add_devices can stay.  
> > 
> > twl_remove() runs before devres teardown and destroys the IRQ domain,
> > unregisters the dummy I2C clients and clears twl_priv->ready.
> > 
> > So the MFD child devices still need to be unregistered at the start of
> > twl_remove() (alongside of_platform_depopulate()) before the parent
> > transport is torn down beneath them, at least until the rest of
> > twl_remove() is also converted to devm_*().
> > 
> 
> ok, I merged the two chunks of twl_remove() into one in my head without
> the lines in between... So you are right.

No problem.  Thanks for your review.

-- 
Lee Jones
