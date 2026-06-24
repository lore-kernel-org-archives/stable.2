Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E844136A372;
	Wed, 24 Jun 2026 17:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320978; cv=none; b=Fzb5LHAv5rdNFqusjSUlsEAngVs+AaQN2RcmQuc4hD3WcC1+xMf0nfkKhURPOuq4JOjF7xb2s1amQ65bBa3NU8TLRkR/S2feCpYTt4GNGE1TvRE2oAYUZpBR09PoTA4wJgbeSFK4EJ1ptfk5FpiSvRBiAnmfi/30AeczY9cmfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320978; c=relaxed/simple;
	bh=DYh1LUenaTDhEk/UmsDiMVbQZjBgGC/XJT4/INLu6Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijcgDzJhuHoHg/w+i0Mreh3hqK8hPFBqQowuODa4TSBghI6gZeDRn+9FpU3nHzSclfDpvLQWphvifE5ngvdIlZtI18jvM+KT+7obvQkM2sva9nE2feNkw9OUXICNTzl4Ix8d83kTTEvlx81mp3SLwHK7XT40pIG4rYE1/c76B0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ3u4y1E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ3u4y1E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926B31F00A3A;
	Wed, 24 Jun 2026 17:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782320975;
	bh=TLvkpf4KTJQFN28eqRP3QnEGWaIf2KNDDqo+8IaoD8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DZ3u4y1EuddVkVxZl9TuaKdGmj2sHTwSD7sWEekXqFsWZ+TVrESUWDSr4IqbDlWqG
	 P6TPQnntSk01MslZEtgeXo7N+5uklvsubn6N0PFOkfroCSQzqtWd5I/+khr5W6dm/6
	 qq6b7TCY2pev6ZaJYIsusdPam+L0AGzJnVZxnGUguvi5g9pEQAo92Lr2ZEZLAW1x+Q
	 x8cnu3inZPwCRmH87/Xqc4VOgEG5fs5xdxdUptdgXC2KCCNS8PqrZIeq2k202okG/l
	 95uZNKHpHLQN0Nd/DlD67QmeqUqG3yf8qgVd1Q/O3I+4JBZkOKKrhLEQk8FFilJGQE
	 oartZAyBYq5Ag==
Date: Wed, 24 Jun 2026 18:09:30 +0100
From: Simon Horman <horms@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
Message-ID: <20260624170930.GB1131256@horms.kernel.org>
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260623114316.2182271-1-haoxiang_li2024@163.com>

On Tue, Jun 23, 2026 at 07:43:16PM +0800, Haoxiang Li wrote:
> nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
> a plain kcalloc(). If any of the following devm_kcalloc() allocations for
> the BPID mapping arrays fails, the function returns without freeing the
> bitmap. Free the BPID bitmap before returning from those error paths.
> 
> Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Reviewed-by: Simon Horman <horms@kernel.org>

I am wondering if you did a pass for any other similar problems
with users of rvu_alloc_bitmap.
