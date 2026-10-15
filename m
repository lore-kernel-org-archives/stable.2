Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15451C349;
	Thu, 15 Oct 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792058141; cv=none; b=KT9wWpUnttOahKU6ox1VHk1+ex4plmJwjeD6rXR89Md4z6clKV/tRQzbpGpq7xUcRiktpSQqsMGoPYittawrg4cna7CjtEK1qlkYV7TEFh3cIW2zNqvrxLuIFrs/ySKjNY/TI8G1q4KhY+VBkgLswc74Bh0VawJE6gUUkJjsQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792058141; c=relaxed/simple;
	bh=Buk9x+xIr0Hp/9kAkSnMDdIn8/lS/bCV6UBqC0TwOuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Okzh081qTz2HVHbNCCOgEvVJliQss1lVYXtABcLTjwUeDG4PIxIH3rl+Xe1Ju69aOuYKvqSCKwrCbyLMd1ggum9wkroYUdp3j81YwYj/tEl/gE6NM5isWsCESbSYrNYBVaJMIu/hec8J6NvJDH5h9KeL4Jc8iBndNpz98jFD0OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uMZAES2D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uMZAES2D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0E81F000CB;
	Thu, 15 Oct 2026 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792058135;
	bh=OjGYxvUIE7EfrZL3fGuw5Qh3SDT3bvcL3SWeWM8eUOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=uMZAES2DjeDsfGU5WPmZ87Wr/UbsnwQy3b5GKnnqD++JeUejUdV1+IZqEnBQIvxQl
	 iZVXQvcVfRUUG7ueXrfqr/b0eG+eJgMUcjiNZECTrokNEEsCQ3PWeijXVBiMDjfVF6
	 v/kUAM0ScHfJZFx9Rj+Zh1l/+6FxopYq5s1mlJiE=
Date: Thu, 15 Oct 2026 11:55:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Artem Dinaburg <artem@trailofbits.com>, stable@vger.kernel.org,
	dlemoal@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	frank.li@kernel.org, bhelgaas@google.com, sashal@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [6.12.y] Please apply one upstream fix
Message-ID: <2026101501-willed-gracious-cc62@gregkh>
References: <20261014190815.23455-1-artem@trailofbits.com>
 <atBnuPOa68f21L6C@debian>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atBnuPOa68f21L6C@debian>

On Thu, Oct 15, 2026 at 11:13:42AM +0530, Manivannan Sadhasivam wrote:
> On Wed, Oct 14, 2026 at 03:08:15PM -0400, Artem Dinaburg wrote:
> > Hi,
> > 
> > Please consider applying the following upstream commit to 6.12.y. It
> > applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.
> > 
> 
> Please explain why you want this commit to be backported to stable kernels.

Yeah, this is odd, it's a test function?  Artem, how are you hitting
this and why is it needed in older kernels?  Can't you just update to a
newer one if you have this hardware and want to test the endpoint
hardware?

thanks,

greg k-h
