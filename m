Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3CA483BD1
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 06:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393101; cv=none; b=CqmsSLsiC6vrQXW60Ii8Q0l5gqBdMgGJ59/Us+XIIslMPdDVe4lwvBJda6ntlyXbf3cKVH35icKCFY185vB9hGmqIWwphzFdi9bARJgR2w6P0l7ToxbMlpz/hY4oxBiWEwO5QL5X9i8ERkKHEmxvJx60uM/wey+vk1pPYluYEgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393101; c=relaxed/simple;
	bh=BkqYLaUB1cV6PolllDNHh7VQegUDlG4d5Vf2nS8ZXhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mli947R2Dsj1t32lY47KR5ewoTd/ECrl3UqDUAcRIIBLCRuig7wTlQHj+BWeJY4H8lbImlQIDsP5BNd9LrlYc0pBa/618kk5x9tqZhYd6TZU5+8tgUMxgMHB2ewDTRr+elTfr6C2yUcsfY91LvSTIhuqbpxTqwTlvhzOLaGep30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=16bpAqqc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="16bpAqqc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6A41F000C4;
	Mon, 19 Oct 2026 06:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792393100;
	bh=c4HX7vS3/ALqXYJaTbKtDxQ9lxdFR6hWFHjGHXBfKi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=16bpAqqcTKl9Hhv3UNsVTi9KLTEmKm9eLoxIq0k7GYPwHx5Rix8VIaZajhwj3HR9b
	 LFs9H43mHGkyhZQaQMXzeNNdm/u5F8d1aC0arrr4eCEL1v6bsPAf4hHXdUWmUmQcGK
	 LYzAVyqBt5axmouvF5+kckbIvNiPafljUzSg6dME=
Date: Mon, 19 Oct 2026 08:58:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>, security@kernel.org,
	Willy Tarreau <w@1wt.eu>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel
 stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Message-ID: <2026101922-cherisher-grout-bd7c@gregkh>
References: <179235055956.10524.6485282696272965887@gmail.com>
 <atU2brRgmeb6ght2@1wt.eu>
 <179236182769.4914.3317139682579833845@gmail.com>
 <atWvQFXJzJ434qGd@strlen.de>
 <179239012164.14465.16534329674629579851@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <179239012164.14465.16534329674629579851@gmail.com>

On Mon, Oct 19, 2026 at 09:08:41AM +0300, Abdifatah Suruur wrote:
> Hi Florian, stable,
> 
> Thanks for the explanation and the Ack.  The explicit memset patch is
> attached with your Acked-by; it applies cleanly to 6.12.113.
> 
> Stable maintainers: would you prefer this minimal init patch or a backport
> of bb061d3de4170741?  Either works from my side.  The memset preserves the
> existing multi-register ABI and is the smaller change; Florian is fine with
> either.

A full backport is always preferred for lots of reasons (long term
maintenance and proper tracking is the primary one.)

Please submit that and we will be glad to queue it up.

thanks,

greg k-h
