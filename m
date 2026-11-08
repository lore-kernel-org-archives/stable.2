Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158898;
	b=Gu/LX+nCBAqX4Ai7Wsm3ltVDutcI/rAPQI/fpY048M85Tw+RIEYwzSWgvcHFr13aBoXs
	 4rmS7tqVxpq7h+C7vJPHvsf/OHJa6vmTM90ZbM/Da2/dUOGrUG6da4Ef9qmhPiyeKhmSa
	 L1Obh3tiFaf1+UIlKKDNoZpvBIk9FcCF5KU7OELLB+gudw5l4wRcneWOPAA5zn2TUbdIq
	 vA0deMSX8774ErSKVHsiRNAF/kZZ20fwGWWPf9I2uPABk+c+riB6K5ZFjSVMxBpnfgpj6
	 Fh6txeVy6el9v9j6cR6LTy1xZw97rYwgvmJvzk17s/gV9YLSeOEitsOUaEXZh0aZZQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158898;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=KSXUWRx0EDguLxJ+F0RcWQ7qU373XM5KCoNfJLe1Qho=;
	b=Si8nJdLp444E9xxQYKh0FeHySyxk072Awmsfw2EFV/ko94XP6W/36lYZI2wnpJJNHlAR
	 frsMWv85HJF28CiWblEfHVXNMxYZStEjYa2rNHo3hCn48rQjmlBzmYkiqKmvc72fTWcwB
	 vAPZGtiLIWRXmqiJZ5bQWTxXyRiOLdGBt6y+6ObLDa+jcgmc2LEuyPUj9ZIOU+LCnwX9U
	 LYNlLQaYaSo9T3TJHkOiJDQrPZ5mPfViy9cHvlGm3Tyfj5D/t6AYn4322vEvupm1vyr2O
	 v4fAFVENdQ3vC3QQWXmkYoHfgUQnvI/1Zg2xibLZ6hnMmcmCRc/VwUn2URtAeM1H4/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLv8RI8T;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C41E606A31C;
	Sun,  8 Nov 2026 17:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CLv8RI8T
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7D9D1F0089F;
	Sun,  8 Nov 2026 17:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794158898;
	bh=KSXUWRx0EDguLxJ+F0RcWQ7qU373XM5KCoNfJLe1Qho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CLv8RI8TF0gEJYhrgPQJTn7qGYJ0sEzAWjPBOfzEzCguXMFLLI1vEJHa9RvWRRZ9X
	 y+76QOKaGeScbUjelNLNOkYQtOIIyjBW8NdEYvsdi4pa2v31NwQKUs5O8HLYmMjE8M
	 5By6QobOgMupcmz3mjNS4ivQL8Fv8JvSSc2l0/OzEElFd+LLVsXs2bnGZP5iWdXDT/
	 xUY6+AM1d018TFU0N/gP9xAOK9raWAMN/rRqmMGMw667AFxl1XEqs2QSuODufsCQHz
	 JAaWJDLfdMz1P7rouigVPJtHXCY1T68G1NiGvUE6itCYeryE7mgP+Y/jLunSnmPshy
	 WR6lIbshI6uTw==
Date: Sun, 8 Nov 2026 17:28:13 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261108172813.GI18859@horms.kernel.org>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
 <179405014554.994134.10719290719575125531@kernel.org>
 <20261108172504.GH18859@horms.kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261108172504.GH18859@horms.kernel.org>

On Sun, Nov 08, 2026 at 05:25:04PM +0000, Simon Horman wrote:
> On Sat, Nov 07, 2026 at 11:15:45AM +0000, netdev-bot+sashiko@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential
> > issue(s) to consider.
> > 
> > Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0
> > 
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> > 
> > - [Medium] This patch fixes the SA reference leak in only one of the two
> >   copies of this Rx code.
> 
> I lean towards this being a pre-existing issue that can be handled
> separately from this patch. But I do note that taken at face-value
> it severely impacts the reliability of the  teardown path and the
> usefulness of this patch in practice.

Sorry! I responded to the wrong patch.

The correct response to the issue above is that yes, that is true,
but the requested patch has been posted already. It should have been
part of this patch-set. And the author should keep that in mind for
future patches.

> 
> > 
> > Pre-existing issues:
> > - [High] ixgbe_ipsec_del_sa() unlinks the rx_sa from the RCU hash table
> >   with hash_del_rcu(&rsa->hlist) (line 783) and then zeroes the same…
> > - [High] ixgbe_ipsec_find_rx_state() finds rsa->xs only under
> >   rcu_read_lock() and takes its reference with xfrm_state_hold(), which…
> > 
> > --
> 
> ...
