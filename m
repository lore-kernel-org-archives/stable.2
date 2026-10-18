Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69A4AEBE5;
	Sun, 18 Oct 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792339811; cv=none; b=sctjulFqe8C8YEfl3+pLZ874/TIMwynyi7xNzee+p/L3kUc2Fq1w6rKMfpekLoYDMqzf9qEbAv4q6/wgCbl9Wdpq8zPWiGOT0lhMA7pHkg+Lw5ejg9YJ8SDukF8F6j7Ivd7twxc/t7siDed8HhlAunu79KbxlIptyJSq5N5HlHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792339811; c=relaxed/simple;
	bh=EUp9OxghaaUbdXshNZklnsyS1ZQXBQUqAg/PcxvKuy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZw/C2+KVrMmxRFObFHoPwCdrF9raOb4S049CypIOjIiHD9H5YgPxP/vGvncznAgBHOO+tiD/fo5OVgA5HaFNwxSoNfRWeMp1GvibPvmvo+s9iyJ3UdPOBC6/BNXv1xraofwRCBGeUPhYVMZGhGXkWJILS+fo3MlpPENMdQ1zDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=XP2LyJ/y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="XP2LyJ/y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jKuRvw62P9dZ3Ihr2ZfFrRv3XWzvYUb5KNEn9SgslhI=; b=XP2LyJ/ysnRd6uv1HcntXTyNAp
	BACtgbM6mFXZ7v0RrMv9TYUZBuJ4op96kaIXGEXsep+gpO+G3midWtfIGprJI2yUm+9abeh0QmT0Y
	CvYTNIKC0StauovEQkmtje257qOTRBUpeLwl5uvI+DirhCQwx+FhWn8sqK1qvIoK73F4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xITSQ-00BVTr-8q; Sun, 18 Oct 2026 18:09:58 +0200
Date: Sun, 18 Oct 2026 18:09:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: usb: lan78xx: reject short register and
 statistics reads
Message-ID: <ce3a8add-3bf2-4507-b778-a0f8a10370c7@lunn.ch>
References: <20261018061734.19488-1-law.wei.jie@gt.tech.gov.sg>
 <20261018061734.19488-3-law.wei.jie@gt.tech.gov.sg>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018061734.19488-3-law.wei.jie@gt.tech.gov.sg>

On Sun, Oct 18, 2026 at 02:17:34PM +0800, Wei Jie Law wrote:
> From: Wei Jie Law <98lawweijie@gmail.com>
> 
> lan78xx_read_reg() and lan78xx_read_stats() read from the device into
> a freshly kmalloc()ed buffer, but only treat a negative return value
> from usb_control_msg() as an error. A device that answers with fewer
> bytes than requested leaves part or all of the buffer uninitialized,
> and those bytes are then used as the register value or the counters.

You are assuming reading registers can fail with sort reads. To be
symmetric, don't you have to assume writes can also fail in the same
way? Should lan78xx_write_reg() have a similar test?

> With an emulated device on a kernel booted with init_on_alloc=0:
> 
> - A reply to the statistics request that is shorter than the 188 byte
>   counter block leaves the rest of the kmalloc-192 buffer stale, and
>   ethtool -S, which needs no privileges, reports it. Before the
>   previous patch, a zero-length reply was enough: one counter pair read
>   back as 0xffffffff8a427800, the address of
>   usb_api_blocking_completion(), next to several direct map pointers.
>   With the previous patch a zero-length reply is already harmless, but
>   a reply of 1 to 187 bytes still gets through.
> 
> - A zero-length reply to the RX_ADDRL/RX_ADDRH reads in
>   lan78xx_init_mac_address() turns uninitialized heap memory into the
>   MAC address (12:85:1f:dc:2e:bd and e6:93:44:41:9b:9f on two probes).
>   Both of those are valid unicast addresses, so they are used as they
>   are: written to MAF_LO(0)/MAF_HI(0) and set as the address of the
>   net device, where anyone can read it.

If short reads can happen, bad things are expected to happen. No need
for examples.

> This patch needs the previous one. Without it, a failed statistics read
> would make lan78xx_update_stats() compute the counters from its
> uninitialized on-stack buffer, so the leak would move from the heap to
> the stack. Both patches are Cc: stable and should be backported
> together.

This belongs below the --- so that is it not part of the commit
message.

    Andrew

---
pw-bot: cr
