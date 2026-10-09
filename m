Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED63314B6E
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 14:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554628; cv=none; b=dC3KuA/QcHJzDiyr5fS/0unN53798ZtepQq4WJkv0n+fF1NhIqxx/bKdh62rqjr0eKvakZWxUptGBYGsdhr3QgmPiQydI4uFQr+yAGyM3qkFgB92y4vT2aNTN3wzWO7hv+yJ6SaxITrgjRlKSfVTwapM1Y28qTqAD5iODOVUO6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554628; c=relaxed/simple;
	bh=k25jAVlFefo9WYoKyx7hn+ugUuvycdd8i4moJdj3Zdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaioB7nhjrDwtANw9kFgFA/qZPFSGt48qQDcgcy8z7vELq0KpiLR9OjFJECweJEUnOsjWDE6Ad6J2gV1BFDviSxFpRcafpx8ih6NSa2c8rzAUQO0QKmvKPlhLlJ2aC1RX7b48hDN+cJjKjGYHYqJbTHT++w3sUUA45AjXdyhwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oSHxKASv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oSHxKASv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD98E1F000FF;
	Fri,  9 Oct 2026 14:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791554627;
	bh=UgF+0ecktxySr9fi28D6+HuQ8nuI8zuu4ToXNcnhCIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oSHxKASvyYQ5LOSuulQvtlh7flDDbAZv4XE4E8ULzwXmUtCxSoDJ9mo3wR6DfIzNe
	 8Ga1omk8WawJSmjWXj8Ur15dRfd6uEbym1iD6pFjYr4+KFiPt8zdAYFTH9PsKI19MO
	 DcrIyr2Z3WV5yE8SVYLAZlI5HnarIPPZBbqGr1AA=
Date: Fri, 9 Oct 2026 16:03:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: jic23@kernel.org, jonathan.cameron@oss.qualcomm.com,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] iio: light: rohm-bu27034: Fix infinite
 delay on error" failed to apply to 6.6-stable tree
Message-ID: <2026100914-obstacle-unify-63d7@gregkh>
References: <2026100659-encircle-snout-9f76@gregkh>
 <6f9295f4-3feb-48d3-bf1a-4e9aa3c6a7f7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f9295f4-3feb-48d3-bf1a-4e9aa3c6a7f7@gmail.com>

On Wed, Oct 07, 2026 at 03:06:25PM +0300, Matti Vaittinen wrote:
> Hi dee Ho,
> 
> On 06/10/2026 10:47, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Ouch. I took a look at this, and I've screwed it up. I wrote and upstreamed
> the first version of this driver for a hardware that was later modified (in
> a non backwards compatible way). Because the original hardware was never
> mass-produced, I decided to just fix the driver to work with the new
> revision of the hardware - but I never added the fixes-tag.
> 
> I never realized is that the version of the driver that does not work with
> the new, mass produced hardware, went into stable (6.6). As a result of my
> bad decisions, the 6.6 still carries the driver for early hardware revision,
> and does not work with the sensor that is really produced.
> 
> I see two options to improve. First is to drop the whole driver from the 6.6
> stable. It shouldn't break users because the driver does not work with the
> released hardware.
> 
> Second option is to backport all the patches which bring the support for
> released revision of the hardware + the fixes.
> 
> I am not sure which makes more sense. The 6.6 EOL is approaching, and I kind
> of hope it is no longer picked as a base for new projects using the sensor.

The 6.6 EOL is still a ways away, let's just delete the driver entirely
if you feel it's better that way.  Deleting code is always good :)

thanks,

greg k-h
