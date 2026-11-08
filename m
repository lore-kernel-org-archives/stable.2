Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794157342;
	b=5cxcd3g7+R2lAWiq5y+U8WST3lPhwcSMTeIV0ntIDQ8oBBkoxqUakLUS4bwSpakCdAuT
	 p6Kft3Dr2R3tLQS3uaPMosfapq71s/Z3SrIErPtY/KpkdXPgqHsFWH3OfbgPlH5S/1Hf/
	 fIMNZxDUlVYD02A1QLT8trpsxRrS/gNHTGTVS87yjaaKGk+Aku//QNqGWguOS4G6UsK4r
	 N/Nzc9LMOKMTkYNKNOqAmTzsj7jTXlxGNzCgCEIiByqm9yX8FYBRJONhXU8mz9Mv9E6w5
	 U8sITQTauCTP1EwLpVu6fUY4cs5GFNYbEv1reaL0XIw9VS52maiY8BEep9ZqOW6p71g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794157342;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=qFlpjEueTpCiMBdjh8PXXrYdnau7ws5RWsTwS4pQKrE=;
	b=WlzoInJ+ZcT9ignOZIjPtydReIPmFeiTgs8XfQDMiXodnz/qdKGpHG2Q7bdqOYrT2DtF
	 JN6yBewnN2moan7Pu0snwupIILfKFvurx3Q9N32yODvJTWUCqE7+EuI9cH9wEDEisUSuC
	 hi3ts6TuYdsntLEzxvEFFV4ACtAOsL5JxX+Ez3j5kMZMe+knJ0zEKmGcw5VLsQRKFHXjD
	 awla0wGSWEnpckEbezT/eg5x1Yg6Gu3I2N3cf5lKeFzlhUb3vTV9fiJPiPVCXkxhy7ddo
	 rTcpG7XgVUlfYCreCAcO9uXyXQgJawk/x6kdHvegLdPjV9VnTKtS75QlgLQ45hFN+jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhunhaGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9720606A31C;
	Sun,  8 Nov 2026 17:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhunhaGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C36B81F0089F;
	Sun,  8 Nov 2026 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794157341;
	bh=qFlpjEueTpCiMBdjh8PXXrYdnau7ws5RWsTwS4pQKrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mhunhaGC7EzIXBAewEYHTGHdu3as0GnW4KEeFBL4EIDf54IKSDKIOCulf8r1QBH5n
	 54qLU5xQqMyvc/4ngQxdDo1OOwzuiUtBX5mxCZ3itBbgDEso6g9R2HGXDstPQsN+ci
	 388YhEXBAWk9d/lJDN6oVpqK1xbsvX+NIFav7D9qSw6DBZZ8/hfaa2y8VRr02JLp4Y
	 lN3cTQ9xzZIufuAFpFFAU70GFNMOSf4RDm9QFTP+RoSfd/OS4NfqTcsKq6/mKJKruo
	 5Ff8R/1rvRDOXqISrMmYQunYoWd7HhvW8XuIoEyI3wHT/9J/xMyxnvlZ6wRObA1mb3
	 VNeRfHDh5IhUw==
Date: Sun, 8 Nov 2026 17:02:16 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, sgoutham@marvell.com, gakula@marvell.com,
	rkannoth@marvell.com, sbhatta@marvell.com, bbhushan2@marvell.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: octeontx2-pf: drop the TC mark reference when
 adding a flow fails
Message-ID: <20261108170216.GG18859@horms.kernel.org>
References: <20261103100536.1310108-1-vulab@iscas.ac.cn>
 <179405110835.994134.149418482897287841@kernel.org>
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
In-Reply-To: <179405110835.994134.149418482897287841@kernel.org>

On Sat, Nov 07, 2026 at 11:31:48AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new helper otx2_tc_put_mark_flow() (otx2_tc.c:1240-1245)
>   uses `req->match_id != 0` to decide whether a mark_flows reference was…
> - [Medium] net: octeontx2-pf: otx2_tc_put_mark_flow() leaves TC mark flag
>   enabled

It seems to me that although two issues above are pre-existing, they
should be considered as part of the problem that this patch seeks to
address. So I think they should be addressed by a revised version of
this patch-set.

> 
> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it makes the
>   counter the patch balances meaningless.
> - [Medium] This problem wasn't introduced by this patch, but the error
>   paths of otx2_tc_add_flow() that the patch edits fail to undo other…

...

-- 
pw-bot: changes-requested
