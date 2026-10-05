Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FAD48A8C7
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211892; cv=none; b=T2ZBExkWRs6rTUmLwleJJZhcW4N6pQrkv2qVHBLbjIDWqPeQ8MVB3BYx3aZcrShprOhjPHrF/i60x8xPGvToyCwBXmEDBtWe7mj9xNFdJFXGM1xzZb688hsFyt47wYcDNTgvqbmxW7Gm4O1CC3zcEGeUoz7S9wN63xyyDWfpPWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211892; c=relaxed/simple;
	bh=d01/RiAPFkj4J4hoyuLc5j8HP5eaNY7t9HSRDNfdeH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDZNJ6i46aTbM330qLWb1h7u0JsakyA6G9YBejGSZLuKTGnCFZnaQQkoiSHCub3LinLwuGXFqwOypFQK6AY/c4ll+0Z87LcXqYBgOoS6QiS2cXFkmEnu6g+AIaFdncDEGIMyTjKKHvyQW8QmKdn+u5t5oK0orjSWqottwEXu2EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D6K5oFYo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D6K5oFYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7481F00893;
	Mon,  5 Oct 2026 14:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791211887;
	bh=8gqDMYmfmFT/HGJXdhC7VXMqoRMIkbVCmRYwIPi7jA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D6K5oFYolNTjU/SG6eytmsoMXrrTnZqpvZSZowf+o49BkqChHSmGT/AFafpxTftkq
	 pdaCTy7eHpHw/knRDbD0Nro7TuKaLRDBJAPBjDhMvc+fwU0JP+1sP3s0PsoMYGi7da
	 s3ajZNYT7HLlH/Plsy4EvsAbrFz0e4XbHolCgil0=
Date: Mon, 5 Oct 2026 16:51:24 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: dinguyen@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] EDAC/altera: Fix memory leak on dci
 allocation failure" failed to apply to 5.15-stable tree
Message-ID: <2026100558-empty-water-c908@gregkh>
References: <2026100524-payer-capricorn-e50f@gregkh>
 <20261005142732.GBasOz1POO8wYBLJC2@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005142732.GBasOz1POO8wYBLJC2@fat_crate.local>

On Mon, Oct 05, 2026 at 07:27:32AM -0700, Borislav Petkov wrote:
> On Mon, Oct 05, 2026 at 12:27:24PM +0200, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 5.15-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100524-payer-capricorn-e50f@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> > ------------------ original commit in Linus's tree ------------------
> > 
> > From 3e4a10a4718e3d963ee4d6c5f26bc5ad57c1d2b1 Mon Sep 17 00:00:00 2001
> > From: Dinh Nguyen <dinguyen@kernel.org>
> > Date: Fri, 11 Sep 2026 07:06:26 -0500
> > Subject: [PATCH] EDAC/altera: Fix memory leak on dci allocation failure
> > 
> > Sashiko reports:
> > 
> > "If devres_open_group() fails, the function returns -ENOMEM without freeing the
> > dci structure allocated earlier with edac_device_alloc_ctl_info()."
> > 
> > Free the dci structure if devres_open_group() fails.
> > 
> > Fixes: c3eea1942a16 ("EDAC, altera: Add Altera L2 cache and OCRAM support")
> > Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> > Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> > Cc: stable@vger.kernel.org # 6.18+
> 			       ^^^^^
> 
> You probably should drop all backports before 6.18.
> 
> Like we marked it!!! :-P

Ugh, but the Fixes: tag points at 4.6, so which do I believe?  :)

thanks for letting me know.

greg k-h
