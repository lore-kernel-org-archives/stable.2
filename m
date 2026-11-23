Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795418835;
	b=YMySYItHh3aW/tOn1xpemS4qoZ7HBh08Khwqm65nz3Af0KwyEi28aSVcclTjvVVwsmIl
	 tuE2TqL7NiCSljpqLskE5FwlT2GH/+etF7SrHXmIBCSZuxduPRJvKBD/vHxoWhqrrVLpa
	 VZ1VfBOxnWtBkCo5Jk0Z0Jm28YLc4MYQk6HYEfXZXkC6FFpxZ0DIeWyIhaQ2zrVFjpEMA
	 H40ymF2+NAJFucS/Okdn362nIjD7qJja+nnBOMvUD9QnodJEStOvH6vil/pF4KuBr6p3t
	 ZrlkrX7Cye9fvWk9QTMX3WT6C2TFAMnaQ4QGVq7TsWamY9AUPeS89QBncCYHsptOVIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795418835;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BdgF1xKuYu4ni+LZr6mvba7jnkWGZBA/HLKCnKO9gOM=;
	b=uPOk+au9OsXdspxuB6ANm4TZsg+vrg5xKmj7+u0OpzLcGQ4Jsf7jkbLf3IiW1EPgbETB
	 3v7TU1HwctrLNHpFEzIDCNSeHNuuzYqkH8SOfAJAYhGBuiOC8XKVUvEW7t0d+dS1Lb0RQ
	 CTOQPAupiuzCwrI+QTJkqTXKUtMtcwB5hiL3wZ8bJt3cjSE9WiB/Iq40ZB/VdTHHyo1Yw
	 ITxMD/vXJN+PSYsNwMBJE+5jezowrkZXljtEYwiPvcGMxOiP6aaiskZ3N+DAZUnil6OMC
	 8FhRgszwjQ1UZOfsR+m8KSbm5T9W+6gWK5gTICK2Wc0g3M8lpoBIEPbD4zsD/4gFu0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YFO3CfRh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C0606A31A;
	Mon, 23 Nov 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=YFO3CfRh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25C41F000C0;
	Mon, 23 Nov 2026 07:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795418834;
	bh=BdgF1xKuYu4ni+LZr6mvba7jnkWGZBA/HLKCnKO9gOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YFO3CfRhHOkovGAv/QnJOgVJWPcrceNkYFIyBASQAXeZ3wGyVeJr1R2PnrnnWV55s
	 4sIHIzVgzZqPq4+XogMKqBup8N5fmwC3k6/D0G0Rj0xbmVvFEuv1U8F/AIq+FJXEbz
	 ySaNUp7yD/U7AGQDF7C5qAFZyXs3mYxNJTP0x6EQ=
Date: Mon, 23 Nov 2026 08:27:11 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: stable@vger.kernel.org, Breno Leitao <leitao@debian.org>,
	Sasha Levin <sashal@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.6.y] net: free_netdev: exit earlier if dummy
Message-ID: <2026112357-twister-activity-1181@gregkh>
References: <20261107161415.1917665-1-dust.li@linux.alibaba.com>
 <avK7XqLvdaeWlp8o@linux.alibaba.com>
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
In-Reply-To: <avK7XqLvdaeWlp8o@linux.alibaba.com>

On Tue, Nov 10, 2026 at 02:36:14PM +0800, Dust Li wrote:
> On 2026-11-08 00:14:15, Dust Li wrote:
> 
> Hi Greg, Sasha
> 
> Can you pick up this patch for 6.6 ?
> 
> This is a prerequisite that was missed when 6.6.y picked up the
> dummy-net_device conversion of the mediatek driver.
> 
> 6.6.158 took b209bd6d0bff ("net: mediatek: mtk_eth_sock: allocate dummy
> net_device dynamically") as d5d57501f543, followed by 16f3a28cf5f8
> (as 81e82340170ae) and "allocate dummy netdev sooner" (efc91ab1d97bd).
> 
> alloc_netdev_dummy() -> init_dummy_netdev_core() sets
> dev->reg_state = NETREG_DUMMY, but 6.6.y free_netdev() only special
> cases NETREG_UNREGISTERING and NETREG_UNINITIALIZED.  So every
> free_netdev(eth->dummy_dev) -- mtk_remove() at
> drivers/net/ethernet/mediatek/mtk_eth_soc.c and the probe error
> path -- walks into
> 
>     BUG_ON(dev->reg_state != NETREG_UNREGISTERED);
> 
> Upstream f8d05679fb3f and b209bd6d0bff both landed in v6.10-rc1, so
> mainline was never broken.
> 
> 5.10.y / 5.15.y / 6.1.y - alloc_netdev_dummy() does not exist and no
>                           driver creates a dynamically allocated
>                           dummy net_device
> 
> So only 6.6.y need this.


But what commit id is "this"?

thanks,

greg k-h
