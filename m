Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418801;
	b=BYpszS4d0VK/bRUAFCe2ss251wUnS6PzBJrl6l0HGpOJMdRwicGItSAavFClMYYXJMAx
	 Z/dgwt2LLtEkpLjOKnVsCflrYAalZTh42WHTy0CP0tNeuXKFj6T8wX2udRYVY20wSuD4s
	 0b4rWdUEWb+2RAtdDdBAtwVzd/WXrr+38bTZq2euYgeetPg0nKY8GwzZtV2Y76TZpnE75
	 2zr/7HDw1+3StxWnhO3ZSNqM1+P7sa1Grd01XYCMZbqM4vVDlQU4gu+YYE+e4LMOvtmIj
	 kbcM17NbU1IvzsmNSaytdT5tKNL2qF/YWKnG/Dgma/73ze+ubClciECkDf2yRiPmluA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418801;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=L/YGve35Gtr29RvA6c9ruL+WPngc1ZzgKShfgpUo0Y8=;
	b=bvE2u/rhbPmyCF3nxGI5OMFlU7q7CEthq7UYOsWxWSKULHjeDXhnrtTewzA3fMCmOzFN
	 b+kg31sqZQq21HVNLRa9DnBeIapcGii04VZD9tYjM0/+iBNSOVvR8iHGR06KJ4Db6QGCB
	 5M/c3yxE31M3kNpge1IPOE8w3OCZwYH7f4Ba7Kvz6cC0PtWuFwnAa5wctyEocxm+QFZzk
	 3uVr1FR4c5frOJp1qFArDdWbQ7IRAr2ZDAtoXi/sq/TJGCEpXhVVN0NvjwOt8xlF79m0s
	 gkkRkabCaOOje+GbRJWULnbqvM2fnVo/l9jwYhtFo5HN+EN3uls0Ihc/0pG43DNjRNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhLyxA+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A80606A31A;
	Mon, 23 Nov 2026 07:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=PhLyxA+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFE71F000C4;
	Mon, 23 Nov 2026 07:26:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795418800;
	bh=L/YGve35Gtr29RvA6c9ruL+WPngc1ZzgKShfgpUo0Y8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PhLyxA+U6M63z8tX+BTX5RTEYvGfWc2FOBtxbgJ10UUm0pblHii8dzEzITjrgY9UF
	 dEn7MM5EKLLBh+Ui52hYVojtbvwmTJ5bjbp1wRm4AAQ1uD59kik3wq7n/uWmnILBok
	 MejlJ0CNM1W4ylxopccAaYP9BxSBqGwfwBDQSvg8=
Date: Mon, 23 Nov 2026 08:26:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: free_netdev: exit earlier if dummy
Message-ID: <2026112329-moonshine-vanity-29ae@gregkh>
References: <20261107161415.1917665-1-dust.li@linux.alibaba.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261107161415.1917665-1-dust.li@linux.alibaba.com>

On Sun, Nov 08, 2026 at 12:14:15AM +0800, Dust Li wrote:
> From: Breno Leitao <leitao@debian.org>
> 
> For dummy devices, exit earlier at free_netdev() instead of executing
> the whole function. This is necessary, because dummy devices are
> special, and shouldn't have the second part of the function executed.
> 
> Otherwise reg_state, which is NETREG_DUMMY, will be overwritten and
> there will be no way to identify that this is a dummy device. Also, this
> device do not need the final put_device(), since dummy devices are not
> registered (through register_netdevice()), where the device reference is
> increased (at netdev_register_kobject()/device_add()).
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
> ---
>  net/core/dev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
