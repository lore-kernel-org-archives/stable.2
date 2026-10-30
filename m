Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=178.238.236.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793362256;
	b=D2K29UujBB1Y58c3RPsZp8hu0BwXRgrybQoLR8lXCtgDhOQ5SQU0ubl6WEhI5BqCYegz
	 za1HJGZqYpI6pGmhpUtrfGNXkmRzmfiPGVBYBDQbptZ+v6OQg57GaXkN+dqe7B/Jjgi0O
	 oW+3RkFvBf6UPNtszhjGMJPfAO0LhHBgBQQL5yArP1aUCIxZecjsJU+JSWqTPEHonoBMY
	 jt/cSWRontR1rHy1D6Hfu7/VrU+FGOLUO4L0hGReVdGjqaX+t92sHGCMQ6gf8xepoFYkM
	 pczINUV59PmAM/oQ6qEH1rXrvmbKPb4skyZVJo6mG+xYWLZHcnHMQhP0+rKPLROPYeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793362256;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=0Kl+MHOCZ+R/GW81g7LtxnluF7pHvK7kuj//VGTFoCU=;
	b=o/zOFDCnY38JW2u0rhs+Q6woXUwuG/k82gRHc2zERVGtNdktuq6y0XT2aA/IjT7TNzc4
	 oUPFBr2QA8o3u+LNXLjRB7SkreHEi03jBt4L44eWli5ZVc7IASod5yy9kClWo3S4QOr4j
	 j79Jetpq7eHyX9ZbmzhrJmttTc6Ym1nX6ZPsfFEdHiS8M8QCxG+TTcrgL5bK/DBKeGj44
	 q3SMeMjtf4ZjXxwHZj27twtgdi0h9s3Br2enT+5zPlZPrW2qXkV+HxrCBeOiWuFgQTK3B
	 bBpm1WjmYI50M9jEjcbSJZ8BCWcAsbH1x3CnHn7vANcSIK0xw8P9nJD0wW7wnWbXHWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kemnade.info;
	spf=pass smtp.mailfrom=kemnade.info;
	dkim=pass header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=di3KAnsf;
	arc=none smtp.remote-ip=178.238.236.174
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A983606A31A;
	Fri, 30 Oct 2026 12:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A983606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kemnade.info header.i=@kemnade.info header.a=rsa-sha256 header.s=20220719 header.b=di3KAnsf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description;
	bh=0Kl+MHOCZ+R/GW81g7LtxnluF7pHvK7kuj//VGTFoCU=; t=1793362255; x=1794571855; 
	b=di3KAnsf/TGDlK/IyE8BJxV5M6xw/7uFAquR6ZUUYqLSCUVXEQOSalHNoXpLDq8w8VNMHEKbMsn
	EWQucs8E3UrcH9HIDqW78itVwwf3Gpr+fImjGyYXMwVbZMJDot/4aUfcykeM5klDNVg3NqXqIink6
	tx0Uirxn+eTWtVt6OM1UCI8+yDq3qp5PPdIIiN7pGuVGI7CIq+J/C0cGuDh5EfioMnz7R1pvYIpFQ
	McRX/WBE3xSXNXDRYbcPJXSoK6FtvQxW7meTVPZFoVQZ/mGIHsdu7g/xfk4b7bzGzuwayTMQIkAPn
	1fzFFgcG/226PiQx3Cdx0zrmlNx2Fb7sJBkA==;
Date: Fri, 30 Oct 2026 13:10:49 +0100
From: Andreas Kemnade <andreas@kemnade.info>
To: Lee Jones <lee@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, Kai Svahn <kai.svahn@nokia.com>, syed khasim
 <x0khasim@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Samuel Ortiz
 <sameo@linux.intel.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 13/27] mfd: twl-core: Clear twl_priv pointer on
 teardown and probe failure
Message-ID: <20261030131049.10167177@kemnade.info>
In-Reply-To: <20261030112835.GD3774906@google.com>
References: <20261027093306.2812695-1-lee@kernel.org>
	<20261027093306.2812695-14-lee@kernel.org>
	<20261028165003.60d0c033@kemnade.info>
	<20261030104806.GC3774906@google.com>
	<20261030115241.642c5971@kemnade.info>
	<20261030112835.GD3774906@google.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; aarch64-unknown-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 11:28:35 +0000
Lee Jones <lee@kernel.org> wrote:

> On Fri, 30 Oct 2026, Andreas Kemnade wrote:
> 
> > On Fri, 30 Oct 2026 10:48:06 +0000
> > Lee Jones <lee@kernel.org> wrote:
> >   
> > > On Wed, 28 Oct 2026, Andreas Kemnade wrote:
> > >   
> > > > On Tue, 27 Oct 2026 09:30:42 +0000
> > > > Lee Jones <lee@kernel.org> wrote:
> > > >     
> > > > > twl_probe() allocates the file-scope twl_priv state with devm_kzalloc()
> > > > > and checks for a non-NULL twl_priv at entry to reject multiple device
> > > > > instances.  However, twl_remove() and the early error paths in
> > > > > twl_probe() never reset twl_priv to NULL, a failure when adding MFD
> > > > > child devices bypasses twl_remove() by jumping to free instead of fail,
> > > > > and twl_remove() tears down the IRQ domain and dummy I2C clients before
> > > > > child devices are unregistered.  After devres frees the underlying
> > > > > memory on probe failure or unbind, twl_priv remains a dangling pointer,
> > > > > causing subsequent exported API calls to dereference freed memory and
> > > > > blocking future probe attempts with -EBUSY.
> > > > > 
> > > > > Unregister DT-populated and MFD child devices at the start of
> > > > > twl_remove(), ensure mfd_add_devices() failures unwind via fail, and
> > > > > reset twl_priv to NULL in twl_remove() and on probe error exit.
> > > > > 
> > > > > Fixes: 80a97ccd33be ("mfd: twl-core: Collect global variables behind one private structure (global)")
> > > > > Closes: https://sashiko.dev/#/bug/linux-73e82f84-94de-4d08-82a4-f22d42a1dedf
> > > > > Cc: stable@vger.kernel.org
> > > > > Signed-off-by: Lee Jones <lee@kernel.org>    
> > > > 
> > > > Hmm, couldn't we use devm_add_action_or_reset() for resetting the
> > > > twl_priv pointer? Feels more clean for me.    
> > > 
> > > Nice!  Thanks for the suggestion.
> > > 
> > > To keep this fix minimal for Stable backporting (and avoid resending a
> > > 27-patch series), I'll take this one as-is and send a follow-up patch
> > > converting twl_priv to use devm_add_action_or_reset().
> > >   
> > 
> > I think the whole patch can be simplified a lot then, 
> > 
> > devm_mfd_add_devices can stay.  
> 
> twl_remove() runs before devres teardown and destroys the IRQ domain,
> unregisters the dummy I2C clients and clears twl_priv->ready.
> 
> So the MFD child devices still need to be unregistered at the start of
> twl_remove() (alongside of_platform_depopulate()) before the parent
> transport is torn down beneath them, at least until the rest of
> twl_remove() is also converted to devm_*().
> 

ok, I merged the two chunks of twl_remove() into one in my head without
the lines in between... So you are right.

Regards,
Andreas
