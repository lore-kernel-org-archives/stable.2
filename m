Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F333A5436;
	Fri,  7 Aug 2026 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786113506; cv=none; b=iprF9acfIOUS+l4U5EcuruMk31MDYW9aC9t7OxCrpFWjbz/2YUCxLAjFL8BMkQiUJL2YmVDuSjp4pOG+CHD+r3YqXcNL3rl3wMPECDuAYlhFSNjW7MOwQP0zyxRPHxGM4tAXytwpzKZWWUkz0Jio1Cc6ZA1ZOrYzJ3BbuOD6ep4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786113506; c=relaxed/simple;
	bh=SPeyJun5GGNv2JmxQxTTAs/jyNLyfJRuGfh+YHCcH3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XntoKLJHCypTX8PTKjfsvvl3KhGyJBXLTjXHyNb/WnhpBZEuEvCKgtoZwrqsUT9hUyoHX8FS/txFziuSeoX/r4PoDYGljdM3z+MDpkjHePWb4yNrG1Y2XlOq+vbhkIxWL/OvPeCc0kG5KEypQ+q3KB/eiLp3pDAq6GneK+/79Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hsCFp4Or; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hsCFp4Or"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D611F000E9;
	Fri,  7 Aug 2026 14:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786113496;
	bh=4NQsNhafXfqt3vvYSvrFFNkI6Bzq3TezU7xMHrLilhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hsCFp4Or3HSU3gYRFBOi0FCdy45zU6DEgdIYyppCR5ZBTVSjoaxhbglJhvyxYIsG6
	 pFWDgQpCqe8LFoE/bNlaaWyDGaqG8Zw8WKvVbvRSGFYPJEoDa/uaQ+tGyk+pvp8BlX
	 yDKoY/v66527BgLx5JybULMyAPq/3UiF8OvPv/bbLFuG9iGsYrMCYfRn+GcbWW2cin
	 g1LvDWRJDTLXftT8GxDPwrZcpFTf2JfjVDwklkMSHd/CxryMqIJGQYfOi9rjoVeJz6
	 UMC0nwA4Ne072RdHqwWO/MP4Yx6+gt8B+/Kkhgjqs1k7xMhfnxeJbbyrdpowwwOG96
	 CtWtY/xqwGkIQ==
Date: Fri, 7 Aug 2026 15:38:12 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH net 0/2] net: mcast: do not write past optlen in the
 source filter getsockopt
Message-ID: <20260807143812.GO51943@horms.kernel.org>
References: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-mcast_fix-v1-0-bed0a5518e57@debian.org>

On Thu, Aug 06, 2026 at 02:41:59AM -0700, Breno Leitao wrote:
> getsockopt() on the multicast source filter options writes past the
> buffer the caller declared. Only the fixed header is checked against
> optlen. The number of sources copied out comes from gf_numsrc/
> imsf_numsrc, read back from optval, and nothing bounds that count by
> the space left in the buffer.
> 
> I hit this while converting the mcast getsockopt paths to sockopt_t.
> Fixing it against 'net' first, so the fix is settled on its own before
> the conversion goes on top.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> Breno Leitao (2):
>       ipv4: mcast: getsockopt: do not overwrite past optlen
>       ipv6: mcast: do not write past optlen in the source filter getsockopt
> 
>  net/ipv4/ip_sockglue.c   | 16 ++++++++++++++++
>  net/ipv6/ipv6_sockglue.c | 11 +++++++++++
>  2 files changed, 27 insertions(+)

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

