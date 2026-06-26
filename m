Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBC532E128;
	Fri, 26 Jun 2026 15:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782487353; cv=none; b=akPR6xHkGH6OGzzKIqk2QoiGEfWLJWB8om1zZbb4WUXMolOkiFm4pKfE/s0139djShGNmn3iKkzoDe1yOIe3sl9LOifQHLIkMO78UZHrFGsFXMbjXW3IQBN1eMI5WcBw/Gb/f6wJr/TR2k+1DNtwj5cY2D5gvygaPo2Bn7Gs9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782487353; c=relaxed/simple;
	bh=a+PmPZy77MT0l0MsmzX289TBUK2qqpVAaGxjL7fADHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzC9dKUkBQEpck9x8yIhzLNFUj9B6qr6uoyplV1Is9j7rTdgsprf08RItqYpd/Aa58bf+ttH13deR5NBw7XcNKezNVu3BroyzYeR9tuvnuIl+5oI8ISJY3VxTyEJpUjFRbgEjjEvO7ZP3wCVb/gdnk5WylFOVp9a8rNUsr0bEUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHiBFbm0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHiBFbm0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2131F00A3A;
	Fri, 26 Jun 2026 15:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782487351;
	bh=a1xj1TG/PfyEbhWtltQ6KeqTCcGTiLODcOSnoEj/Dr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dHiBFbm0/zrKL7Y+MqfOSUeJEg6ahiCxi5m8fPPrDIC37t5fGJ6Km2LIZNcSZWvgQ
	 NAoE1MUslSg7FM544ZvX8XFhAVAuUUr1wrcj+LCcNA9nV7w0PD053bFpxGbRSkB/+C
	 ZEqvWuPkuN/2RL+0irsgVIDAKVjde2dlI3KXRFjS+xleSG7hJAaSrh8kta/T5EwhwF
	 qF3EQxve/6N8xslFWMkHs3Kkpc4crhdQIyaOH+i80MEkjvvO10MDquTYLBme1zeAgl
	 tZal3TWalWMgWqxUgV2Z4aDfM1alPpOkm6r/q4o9rNJZ15Ci+gDwy+sgA/eb6AlbTE
	 M4WKVs/fN3oGw==
Date: Fri, 26 Jun 2026 16:22:26 +0100
From: Simon Horman <horms@kernel.org>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
Message-ID: <20260626152226.GC1310988@horms.kernel.org>
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
 <20260624170930.GB1131256@horms.kernel.org>
 <78397a8d.5bc.19efc3325e6.Coremail.haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78397a8d.5bc.19efc3325e6.Coremail.haoxiang_li2024@163.com>

On Thu, Jun 25, 2026 at 08:34:31AM +0800, haoxiang_li2024 wrote:
> 
> 
> At 2026-06-25 01:09:30, "Simon Horman" <horms@kernel.org> wrote:
> >On Tue, Jun 23, 2026 at 07:43:16PM +0800, Haoxiang Li wrote:
> >> nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
> >> a plain kcalloc(). If any of the following devm_kcalloc() allocations for
> >> the BPID mapping arrays fails, the function returns without freeing the
> >> bitmap. Free the BPID bitmap before returning from those error paths.
> >> 
> >> Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> >
> >Reviewed-by: Simon Horman <horms@kernel.org>
> >
> >I am wondering if you did a pass for any other similar problems
> >with users of rvu_alloc_bitmap.
> 
> Thanks for your review! Yes, I did. I found similar issues in
> nix_setup_ipolicers() and rvu_setup_msix_resources(), and
> I will address them in follow-up patches.

Likewise, thanks.
