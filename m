Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0623C8728;
	Mon,  3 Aug 2026 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748496; cv=none; b=qsn/ZciCv8qZ4SJihZu48bTffVirQlJxYC2n6Y9xGX8tSnrb6st/Vss71SnJYinjQPE13DsIuZKG6rlX+x4HJFYHbQX4LlugtwT0UMgxEnBYqX04G2LN988SfNeUyqGmmiN6BLgS5EYyFTgezaXCANUK1XHRojZjTY1OEDAAPhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748496; c=relaxed/simple;
	bh=r0avL45YisffyW7ENM7UncyXQolGflP72UQqd27chAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uX1aF4f+6gkRSn2xbKBRPfx8L4Hg3XX0C6bsunH7FNRcTLxSR1fDe25H5DGoqDfPXohhp2Ic+/dI2fv8XS1BT3yNrJ10Uv7Ig2FSxGGDUTuKaXwAevRP4yUITlicXsvm73m0xZWm1Og7PB9SD05GaFBjnEpjCgcFigbiYMxKsdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X5nnwJhY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X5nnwJhY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 695EA1F000E9;
	Mon,  3 Aug 2026 09:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785748492;
	bh=1/FqPAf6NXN6P9N+LddU8JXF6C3Ygknx45fwKkKYZus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=X5nnwJhYKGR59doifDZjmWXKP5MeXX1g5pwCrf53P0fJBwcb9IEkOAj8AcBNKEr+g
	 Z69ND2es1FjqhdyLYTx/sVk2GP3XOryeR/VChhxBC4oRqPcuF6BNhQTretDGE7Txbw
	 FN8CgFaR4EkOAgJuk/mefFW6CORwu6vfZCSgo11E=
Date: Mon, 3 Aug 2026 11:14:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Hongyan Xu <getshell@seu.edu.cn>
Cc: sashal@kernel.org, arnd@arndb.de, linusw@kernel.org, brgl@kernel.org,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [RFC PATCH 6.6.y 0/4] misc: ti-st: close transport removal races
Message-ID: <2026080323-peso-hesitate-9920@gregkh>
References: <20260724052842.1052-1-getshell@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724052842.1052-1-getshell@seu.edu.cn>

On Fri, Jul 24, 2026 at 01:28:38PM +0800, Hongyan Xu wrote:
> The TI shared transport is published before probe completes and remains
> published while remove tears its core down.  The exported protocol entry
> points can retain the raw core pointer across that teardown.  An attached
> N_TI_WL line discipline and its write-wakeup work provide another path to
> the same freed core.
> 
> This series publishes only fully initialized transports, accounts users of
> the published pointer, withdraws and drains that pointer on remove, and
> synchronously closes an attached TTY before freeing the core.
> 
> This is an RFC for the 6.6 stable tree because the driver is still present
> there but was removed from mainline by commit 78fe66360ed6 ("misc: ti-st:
> st_kim: remove the driver").  There is consequently no current mainline
> code location through which these fixes can first be merged.

Great, then you shouldn't worry about this driver as obviously no one
uses it :)

thanks,

greg k-h
