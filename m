Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794757981;
	b=MP/7O4FomxD7Aw9uNgnEYJ1cT+t96IoW+cVjYPitt8f5mz7lRvhZ4Xs8yNSbZhWyL/07
	 d2PszTzrTKf2QNqKHTsi64hDIVFCa/HmN9qWAyTptiJe8rZjsCZV4urD2TBp0R7vobb3Y
	 inWDQU1RCDTk8cs/NGzaEMgTYHTBBgys0pcOjyNdrLnQsyV4nLn3oDDzTQDQfomTokXZN
	 xH1A5aP0A2j6oUfw1mE/ME6HiWtrmvuwJP8MHdqTzasb5XeazL9v3Uh9H4JTf5Fz2Bht6
	 PQbCs+784PVgV0XYzqd8u5dPYISX94wizBEmun5m1PtL+F1m6WdvzLiwws5IR5BMuPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794757981;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=3w2k8dv60M9yhIxrZGVgOz8RjAq82d6eRw88JC7KQX8=;
	b=1ynuJPiki3JTSRFxKCdWQSWzZDEafgvVsw7zn85u9/eaPJWjXWmdyVXQMV3oX9PpHquF
	 9P0FTIAAvKYafXel4fxZXPL58bZ7Z31JGL7gPGQqH5odfjThnwvkcnJhq/Sy6ycC3Dsxj
	 PTOKWRT0Ax3by5o/v6bPpxCh1cTCCWaQYdrm7aJWmIBSaUI4/2ENr9ScxpDO2wPqAVYTq
	 eQocRzIa+chgLP42rkncPFbcn2RLA2WSC96LxvKdqeG2zoKlqvLJT3AR5NwIMjUGthAVY
	 dTMY7C7gfWr/u6+SyjHy15wiqGnpzPK/3lX1ZPSGoQtQ5enN0tQeKUnkiZu6uak21/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5PuG6+tJ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2D5606A334;
	Sun, 15 Nov 2026 15:53:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA2D5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=5PuG6+tJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3w2k8dv60M9yhIxrZGVgOz8RjAq82d6eRw88JC7KQX8=; b=5PuG6+tJNvkZcOd+koxl9dO8Up
	2s8H+g6pF4Nty9+e3X93gr8+RsU+m25LMKR0z9qxMzeLJFfTUfgk/fCkKP8ClkHHQmkNPtK7DfBnq
	WVr8jYk7pkpGY+qGnIUBKGDL84cKBCUxOAa5zHeeYxYwLHeAIzF+AOBkVhEHRg8WKHxU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xScXH-00GdYo-RW; Sun, 15 Nov 2026 16:52:55 +0100
Date: Sun, 15 Nov 2026 16:52:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH net] net: microchip: encx24j600: Avoid unsequenced
 accesses to jiffies in encx24j600_tx()
Message-ID: <58014e4c-fd79-44d7-af47-35da26616570@lunn.ch>
References: <20261114-encx24j600-wunsequenced-v1-1-c978fc36cacd@kernel.org>
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
In-Reply-To: <20261114-encx24j600-wunsequenced-v1-1-c978fc36cacd@kernel.org>

On Sat, Nov 14, 2026 at 09:38:26PM -0700, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in encx24j600_tx(), which
> can break the build with CONFIG_WERROR=y / W=e:
> 
>   drivers/net/ethernet/microchip/encx24j600.c:898:14: error: unsequenced accesses to volatile qualified 'jiffies' [-Werror,-Wunsequenced]
>     898 |                   jiffies, jiffies - dev_trans_start(dev));
>         |                   ~~~~~~~  ^
> 
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior. Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
> 
> Add a local variable to hold the value of jiffies before the function
> call so that there are no unsequenced side effects, clearing up the
> warning.
> 
> Cc: stable@vger.kernel.org
> Fixes: 04fbfce7a222 ("net: Microchip encx24j600 driver")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2196
> Link: https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
