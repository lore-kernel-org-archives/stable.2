Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D680443DEC8
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790149635; cv=none; b=lWrqGi84DkX/1cQv1Vsmg9PBW1VQDy0PpWSD9n4wJ1lO2myqD19xX/2QZBnuEzO/+MsaoIxUS3fHPFudxDON4jFWabd4jHJ3Aa5psuCSwi0m+YEzYX1clI+i70ObMdK/VXsTqdk9KMPfXa4hRpv/+G7jIRvNmRlEEhdbiviE5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790149635; c=relaxed/simple;
	bh=FmVmUh3Pez0fISCwOmEErGTogJPCLdUNYSuZ0EFNmUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSe/sGPZDKULOq7EUT4hEhY/9rJ5fJKPODhxE43oTzLBGtfUmnDVL3ekxqnsZqycmp2OdIlalC+7iERGgP7796Eky1t97bVBgG1ZpCVtTWv6DzVh+KJKgsjxPNEoMlIUk8GxDObi6Bu0RYvfZ1mp+lj7UgtQt2nYM8yMq125uAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bFScNaxO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bFScNaxO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E0E1F000FF;
	Wed, 23 Sep 2026 07:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790149634;
	bh=l4cmt6zxZE0RCbPFtciqZwcm0r0knlQ0xl0DsVCqRKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bFScNaxOLU5qRw5uvQs3UzzsnwSsY2oE9bpnuwO8PkYoD1OuZrNWUHCV+xIFHUtr3
	 svywBlQCKhsfFcWQvEplKJXl9CKpz00GZupTARw8MZuU8plB14X37qEYsvmVakCN9W
	 2HF0uK+10Csbr+hN+VMJA+TtgQb4lH+9PKjIZLBA=
Date: Wed, 23 Sep 2026 09:44:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: stable@vger.kernel.org
Subject: Re: [stable 6.18.y] Backport request: two ntsync fixes
Message-ID: <2026092330-humorous-unnerve-a325@gregkh>
References: <CAH5fLggWya+4rz8LWjaCqYQ8eBfds2-yim9NFZ7nZpz6ABdG+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH5fLggWya+4rz8LWjaCqYQ8eBfds2-yim9NFZ7nZpz6ABdG+Q@mail.gmail.com>

On Tue, Sep 22, 2026 at 09:22:15PM +0200, Alice Ryhl wrote:
> Hi stable team,
> 
> Could you please queue the following two upstream commits for the
> 6.18.y stable tree? Both apply cleanly to linux-6.18.y:
> 
>   180a232ea78003d1dc869b217b4e49106fd58e8f ("ntsync: Honour caller's
> time namespace for absolute MONOTONIC timeouts")
>   61611481f7b599e0526a3782c626b1a9deeb48bd ("ntsync: reject wait
> ioctls with zero owner")
> 
> The first is needed for correct operation of the driver, and the
> second prevents wait ioctls with owner == 0 from leaving an unowned
> mutex in a corrupted state (count > 0 with owner == 0).
> 
> Not sure why Fixes tags were not included for one of them.

The second one also is needed in 7.2.y, so I included it there.

thanks,

greg k-h
