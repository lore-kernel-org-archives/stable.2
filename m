Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CA37DEAB;
	Wed, 16 Sep 2026 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789563816; cv=none; b=DOJ74qrIzkfa0+fBleyhQmHlIvXMSR7O2EijnV2JWBCyNqE01P13zr4XR2bHopbTxQk4hp160iFoMSMiirvJUdJqqvU64hIQPsuMTZjKkyoJSeZSaeUkMFZ1UdZNVuuuvjquO97KwlCbOLwApZW1F4xFWSWIKNWkRCHu5g6p7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789563816; c=relaxed/simple;
	bh=zAaI/Jwp0jmE1s6NFDeqMQuMuBEAoHe8yVA1CjPWbjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsZpJeytF+hFnunx3gjQp9mAlEFsy7unkGguBxurZspHYxgR9EMOxoIPYuz+5j4dEyx9DIkOggR0ZhWFE3d47UZZ2k/I78gXVllksOdTlaNPoQ3j+o4l8Bcj/jYNMOPJAaiGw5qxQkOsCQyrUm/pfEjFjhBkTlX4FqiWTLjPa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxyNB81U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxyNB81U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEDF81F000FF;
	Wed, 16 Sep 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789563815;
	bh=uiPclxV1NiqDsfmVc5H/wnm3CGtWHcyg2RThJ/0Z7Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NxyNB81U8f6PAWeUwwzdOtXaPmfXw7FN3QcqQjIIsCcH5VI5wVZu0Ri+B0XMGGqpJ
	 sOXEJzTx0wNrc+VdxL3vKDs1JhUbhxK4wJuuvfYYtqSK8osdipx93Lqyd50Pky+nvC
	 UZrtQ+Niv5k6gGiLF7ncwKcd+kzEUPC1tec3Mz7daR+93cf1lp3WVCpsi31K6y0lIq
	 SSOVvte+SXrOBSFM5dpv9604d1hwa2RLdt6tBQCVXUG900N+sQVVK9vlB+W7DPcK65
	 vUgSD7hSlWBD8L3frOT8VdZ7lOAwwFziaota7Gqui/gjq0EwTIpm5sqrKNeOzSN3Vq
	 la0AaQFHvyjJQ==
Date: Wed, 16 Sep 2026 14:03:29 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Gregory Price <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, liam@infradead.org, david@kernel.org, vbabka@kernel.org, 
	jannh@google.com, wangjiexun@tinylab.org, sashiko-bot <sashiko-bot@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/madvise: reclaim isolated folios if PTE restart fails
Message-ID: <aqqTbGMJL86TzDrf@gremlin>
References: <20260912110832.3203902-1-gourry@gourry.net>
 <aqloB0zm3RjJ47m1@gremlin>
 <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aql65IhMobL5Al9B@gourry-fedora-PF4VCD3F>

On Tue, Sep 15, 2026 at 01:12:03PM -0400, Gregory Price wrote:
> On Tue, Sep 15, 2026 at 04:55:47PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Sat, Sep 12, 2026 at 07:08:32AM -0400, Gregory Price wrote:
> > > MADV_PAGEOUT collects isolated folios on a local list before reclaiming
> > > them after the PTE walk.  The reschedule path drops the PTE lock and then
> > > restarts the mapping with pte_offset_map_lock().
> >
> > Is this reschedule path even necessary? It's pretty bloody sketchy.
> >
> > I thought the modern approach (TM) was to not do cond_resched() and friends so
> > can we actually look at removing this?
> >
>
> Sorry - meant to reply to this.
>
> Honestly there's so much jammed into this function i can't give you a
> straight answer. I can take a short detour to figure out if we can
> rework this as a whole.

s/short detour/long journey through hell/ perhaps? :P ;)

>
> ~Gregory

--
Cheers, Lorenzo
