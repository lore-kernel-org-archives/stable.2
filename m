Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16A53E308;
	Fri, 16 Oct 2026 17:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170014; cv=none; b=X1EqzUW/dIZI9zIdlM/p7b7b3ua+6JZ0rpLflyPhFtYbxn2eS+e7KQH0iWTbqri4wk3FWcmKKTI292MKHtXwlUPLW6NgcDQkipTL+r7GpwpzPlmiSj/YI4Mk6g8vo91m27zQaiqOcZl3N3eY4g1WxPLBWsWQId+tX3flFonNnNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170014; c=relaxed/simple;
	bh=/ak6vK17bkaE86rZ7vaBahm6omxqFSWgpPC/T5JNeO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW2f20u70ZJyVcUvlVobevhBNZGQ5YZ1p109IxftwIPkBhZGpXwH6SAvNkwCEfxJR3lHbDFvEfWVhgJt/MO/OD9k69c3ZhXTocgz39JWF7w99oyGYDbkwFHarEkDsKHTs/eDKQTStmwXklmNG1UpbhLDMjevfn4JaDfNX3F8AzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbfQ7R3x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbfQ7R3x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60A21F000C7;
	Fri, 16 Oct 2026 17:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792170011;
	bh=/qqXVe5p9S/gEhsn3j6mqdXqY8DCRG0YIMtV/BtA0xI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DbfQ7R3x4eXk03s9KoSQ8p0KsSDNXroXPf4bLuws/D8JglWenQ6ui+rGNKaEaIOa6
	 ozosD9yP8WNd+MjrnbXCvVb52YEOGl3AOKP88lpq/weNsCD/BEMbzAJojOMoiSm3At
	 XV9/Ysw+pR0yrrhnOXfJrg698TVF3HM0WPZ0rBKugCln3YJixosf0OGNr19zBF+s4k
	 VsLZy6lxCbE6GyID39w7Vdf7/EsnHVlTXb7KyB+JAmlYlX6HwTX7KmzzD/KbiaWxCm
	 MoFD/JzY+fC+AGdyq3dpgCRysn9UYS2A7b1JxPodibMIegCgrumpaWtofgezBWdTNT
	 upg4xJOPSU7DA==
Date: Fri, 16 Oct 2026 18:00:07 +0100
From: Simon Horman <horms@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipconfig: fix use-after-free of device list after
 ic_close_devs()
Message-ID: <20261016170007.GH363352@horms.kernel.org>
References: <20261010085003.3261587-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261010085003.3261587-1-bsdhenrymartin@gmail.com>

On Sat, Oct 10, 2026 at 04:49:58PM +0800, Henry Martin wrote:
> ic_close_devs() kfree()s every ic_device node but leaves the static
> ic_first_dev and ic_dev pointers dangling behind.  When a DHCP
> negotiation gets an OFFER but never the matching ACK, ic_bootp_recv()
> accepts the OFFER and records ic_dev = <list node>, the round times
> out and ic_close_devs() frees the whole list — node included.  The
> next failed retry round runs ic_close_devs() once more, evaluating
> 
>     selected_dev = ic_dev ? ic_dev->dev : NULL;
> 
> against the freed ic_device — an 8-byte use-after-free read.
> 
> KASAN confirms:
> 
>   BUG: KASAN: slab-use-after-free in ic_close_devs+0x214/0x220
>   Read of size 8
>     ic_close_devs    <- ip_auto_config
>   Allocated by: ip_auto_config (ic_open_devs)
>   Freed by:      ic_close_devs <- ip_auto_config
> 
> NULL both pointers after the free loop so retry rounds take the
> clean empty-list path.
> 
> This memory-safety issue was discovered by Tencent CodeBuddy Security.
> 
> Cc: stable@vger.kernel.org
> Fixes: 46acf7bdbc72 ("Revert "net: ipv4: handle DSA enabled master network devices"")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
> Changes in v2:
>  - Fixes: tag corrected to the commit that introduced the ic_dev->dev
>    dereference that makes this a UAF (46acf7bdbc72); in 2.6.12 ic_dev
>    was a struct net_device * that was only compared, never dereferenced.
>  - Code comment in ic_close_devs() dropped per review.
>  - Message reduced to the memory-safety mechanism (no vulnerability
>    framing).

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>
