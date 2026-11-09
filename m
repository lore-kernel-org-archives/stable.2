Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241288;
	b=F9nRrxn9t9aQjLxN8Os+g7bYItkJYbG4Yjs8dFrb11zR3bisI/ELSFZ7lBLf8WkEzyCs
	 snKoYtZKYAbEo9X5FivG0d/cbyyRbG0HVNLK8cIDSy5o6yOmolDh8KcV9DzRugTmEK0u3
	 Ak2n+XV8iKZfgN/buyfuCAg5/3Mc3e2hLEqHMNBI5wAxPlgn2lAHRgYJcZPjzFsLbMmP9
	 Pp8kW2Z+7S6o5tIWVtmVq34BuWRN29CkMiSuR+7ePOPi8CTWEwitK/1Kp94WesM3zlOtK
	 hApM+8a9vQOvF3EE9ntn42sdSYCCINZyRa9KusMm4csOsBITfUtBuZNDZJfvL7tQQMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241288;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=dwtWGIWuqHod+4QAdiZAucHZ6XTgkValN4Xr+jKDn8E=;
	b=c4mbZ97FTTR7/yyWb0FzfddYJyc7LeokuSN/Mfj9h89/7GBe0/JxyuMA6aA/5FYuIb6w
	 iXYbFIesrMdXXm/NBTkOlRXat14WP+z+Sp+BYf4eUuc7pDrulFYzRlUWye+4i9vVUHbEb
	 Nqaetna8u1nu6aUzvzY2Udnl/PsBVNMTCExxPE/wvinCn5Y9USCEHMjtbGMPKuz2l0bZv
	 LF8AH8+TG+RiPOBkNnDUoJnxwUHqyCfy2fNGfePBQ1vY2EvBufX7jWN5RLul3CSJt9JWN
	 tP+AmXMCIhBqy78kh/VCekN9cNwD8neKS4X7PVgI4XgN8C8i8novA8uk/8N4DTGWXig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQgX8eOD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE083606A31C;
	Mon,  9 Nov 2026 16:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQgX8eOD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590171F0089F;
	Mon,  9 Nov 2026 16:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241287;
	bh=dwtWGIWuqHod+4QAdiZAucHZ6XTgkValN4Xr+jKDn8E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQgX8eODZl3NoEfG0FVWWUOTaExeyheHrM8vkvXq0sGj6xG8uvx69yPzZByvXnkUy
	 JVFlD3Ny5AWJrrGl9b6fFD42AXvMjh4pLOKLmkF7c8c95cDDd4MnJGgmZFxkrfxM9Q
	 VNlNGJpFORY+cHVRzF8QRQITepG446/2Y2/8ZR8LD9UuxxRV7/YVLc4Nz9jJ8KtLal
	 T8WWaG668fcCfQ/Xc1BShvRhrbV3vN4mtezRB5eshC1/dk2H3GIV2mo5Avf+qphOtd
	 ViI0Db2hvAhsG4emQUwRcRWsZ/ZwDj/cKe3PV5ETH5UiTTtgKF+Rm/9b8Z+JMNfpCV
	 s0XNeP6gZYxfg==
Date: Mon, 9 Nov 2026 16:21:23 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, shawnq1@163.com, davem@davemloft.net,
	edumazet@kernel.org, jiri@resnulli.us, kuba@kernel.org,
	pabeni@redhat.com, victor@mojatatu.com, thomas.goff@boeing.com
Subject: Re: [PATCH net v3 4/4] selftests: tc-testing: teql: cover each
 attach rejection on its own
Message-ID: <20261109162123.GP18859@horms.kernel.org>
References: <SER-NSBD.v3.r0.20261103064310-4@mojatatu.com>
 <179406302081.994134.2324214805948881495@kernel.org>
 <CAM0EoMnjMoHQ2kU01naxDT0L3JXx61uKa7XBEWSQTJ9DaUa0_w@mail.gmail.com>
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
In-Reply-To: <CAM0EoMnjMoHQ2kU01naxDT0L3JXx61uKa7XBEWSQTJ9DaUa0_w@mail.gmail.com>

On Sat, Nov 07, 2026 at 05:15:49PM -0500, Jamal Hadi Salim wrote:
> On Sat, Nov 7, 2026 at 9:50 AM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found more severe
> > issue(s) in other patches of this series. This mail is only an FYI, in case
> > you want to address the nit picks below when you respin.
> >
> > Low priority / nit picks for your consideration:
> >
> > - [Low] The commit body describes the patch as a change relative to an
> >   unmerged v2 posting, not as a change to the tree.
> > - [Low] Both rejection cases check only that tc exits with 2 and that no
> >   matching qdisc is dumped.
> >
> 
> Again cosmetics - so far no reason to resend.
> 6a06 is added by this commit, not by a previous posting, if i resend i
> would reword to state that.
> The module point cannot cause a pass here - it would fail several other tests..

Reviewed-by: Simon Horman <horms@kernel.org>

