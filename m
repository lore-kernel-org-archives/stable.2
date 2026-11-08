Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794158936;
	b=iOeq8d/dd9w98Z7i8/VstrRWDFk/3b3ECCmY0kryVjHVoFQt0xS9UceXm/i6dhM7FLFE
	 Fc1yqUZIIycgHRAjt94sO2YtnDp/Qve/VJW1wK2AieOuxNRtkE+Gw29VPYu44/HOlEvVB
	 VgmO0yaUeCXRprLHA1wHMYbAHauJeLrMoFIOHHlYCxOdnDjTliMfStUpqC+HbfScKpVOP
	 M7+sXRcqc2EAwCEYk5LGe/3G/w2Y5lzhtKGLyKLTFqbn44PuvuOCGvSEfgLAKLwMBezYM
	 Fp1aDuBbT8qwdiZq2iiUtOklkv0Ml8TcqmwqtnpUtAEp44n9wlOYTn+Kag5UZzQfGLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794158936;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+3sMydJI69ovgr4FAhaRbhcYEGKhyJfYBbTm9Eb525E=;
	b=nkNuS2fLKECI4z3Sul3fRGftUzGmHYfulFitoXHEy9gUkAKvCuSBxlupasB2Dt7ibYE3
	 srlNIolRUbby+cOTz5xg4Jsx3W1A1exllfX8TMxaXODCONi1s19Ozr7gKF02Mb5JABG9j
	 JE527IKyOA9htDtVn+uCFm0JEt5MH9nfQ+aPaR4AdtV+rZzaF1DV7wm71MM/Gwg+0fEv+
	 X3crsAAf6xXDLRC1Wk1MeLpZS/1R5FzT91AEYQdA35iKjDZHJyLa4/IQyWJ0mxeFVrB4z
	 9GJcnU6TBKfI7pQFQGXamrSPTd9dOUtv6vTqlZGHa6CY2vMrlNZGVic3DiTvt4I8YNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSfKUiOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CFA606A31C;
	Sun,  8 Nov 2026 17:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSfKUiOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0321F0089F;
	Sun,  8 Nov 2026 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794158935;
	bh=+3sMydJI69ovgr4FAhaRbhcYEGKhyJfYBbTm9Eb525E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lSfKUiOgLiSUr9/4uiYzHIjyFHtHkGuPNLZaPdAX+9wwdnws9nqYxKRhKf7Z/6Ey5
	 sFfNg5lX0CH5wiqV6nd/Mw8VymEUqqggQ4cEGm0IM+f65yXTB0xHmH6S0voE0akp2N
	 d1f7jIkMd3MzuSUwwhx/NrXIL/NjV3ZHgMG7HpA4SEEnlaNyNWbeo6MJcxDY11Ze8c
	 KIfXUji75RTm8fcco1yGtagH45ixp/L6DmZLdmQ+ricMH3jQ4tlNJO6rL/xrVUBfg+
	 X9qtzkzI9AYr8txKYMBd0D4uiQmdSRkCclK0zlXl2HvTGodhCLaU5C4fYrMerLUZPS
	 V501/iVvmjDRQ==
Date: Sun, 8 Nov 2026 17:28:51 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: vulab@iscas.ac.cn, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: mvpp2: free pending TX timestamp skbs when the port
 is stopped
Message-ID: <20261108172851.GJ18859@horms.kernel.org>
References: <20261103100535.1310088-1-vulab@iscas.ac.cn>
 <179405285872.994134.2557194195988942800@kernel.org>
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
In-Reply-To: <179405285872.994134.2557194195988942800@kernel.org>

On Sat, Nov 07, 2026 at 12:00:58PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0 (1)
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The new mvpp2_tx_hwtstamp_flush()
>   (drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:3422-3436) checks,…

I lean towards this being a pre-existing issue that can be handled
separately from this patch. But I do note that taken at face-value
it severely impacts the reliability of the  teardown path and the
usefulness of this patch in practice.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is a
>   serious race on the same data.
> - [Low] Baseline decision: not a valid finding against this patch.

...
