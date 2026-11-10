Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794305567;
	b=EAO0M0+/AFX9sXJXC7m65iU88fD6J5NGVdr29MNY/bUUr5a4YU9DWN4+wbI6RsT8jzl6
	 H+9LB33CrfFx4QKj6aCu6JX8E0wv2HagTxd8zujpZnXaXIc6uNLRdAubDckznqO312Fbk
	 QxmP8qhHtouyS11cqJTcvxofdpLFrwgLcAjaUoAdmjfZ/zV1fYQnWNCj8cJfusnTv2/B6
	 HrHHRUfbblGSzzAAzQaztxQRvK2r6hoQu+AbsZLXvZMpQv1O8nStp9lhp6IPuCuHpUvhn
	 qnSH8I8r04AhaO/aQRmHeyeQn4Gdn8A1SZt/FF02TAWzaa4IStapnWuYmzJAOvAYYqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794305567;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KTQTZgEIbgkQxpYkxWc3fbV0n3H+XOSJdQT5Ddmwlzc=;
	b=Y9oUOUHBlD8eBGMEk3H5AGXVoZ8DcTDbXTPzzhzeqH3naBeuIPAXVRtzZJ7CeTPhHFaE
	 yCZudW6X141lnhoMZQ49SHN1sn+lojXmz53E447FIcWbvtrb2KUTSlnIGZWwW8EcDxccf
	 dB9oszFwbeeOe2fDbbDffqEqlPys/n1LGzfWpctzqDn+t+cNfO8BbHSdmUStTUxlDosfw
	 DKgTX8Dti9g14igmCeJByYWXzL3CERYF70aMK+hl38wPzl0pyOvkGnuz0/c+qtQb22FDp
	 40HzZAd0GgaA+ZwmHdDIAPHmZEfkZGR+dhtN36EFLSog99DmoNoe9hUtkTChFml8rKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cp1O3eps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7736606A321;
	Tue, 10 Nov 2026 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cp1O3eps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8BF1F0089F;
	Tue, 10 Nov 2026 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305566;
	bh=KTQTZgEIbgkQxpYkxWc3fbV0n3H+XOSJdQT5Ddmwlzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cp1O3eps3MGQe8xL50/0U0R929vw4vD6ILDZJxc6eqo3xD0te5c4wxdCR635jl6vF
	 mhUgcpnvgOrrAsybOgBUBkK4vR9aFzyCqYbI71TZ1XokIu/Lr8brBe9JvZmLDFTL3j
	 BFDXOms0akUY4GPjAclY5xKY0YpeHnkoi+7g2BLNQi37ixX0ffF2rw8U9RB08t57vk
	 JMA3ejvvX/ei1JvEqCbQXrj+LVlMDyJU0gE+DkHwVocAc05kJCqcTfrfHXXjEY195O
	 myc5rjexsfiVM17C/Atk8GryyFo/WjNiOvUMlg+TBVRjQJGTYp1X41iCqCTJQO/W+m
	 XhlvCek6yYdQw==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xQiqJ-0000000AmBB-2xHc;
	Tue, 10 Nov 2026 11:12:43 +0100
Date: Tue, 10 Nov 2026 11:12:43 +0100
From: Johan Hovold <johan@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	Hans-Frieder Vogt <hfdevel@gmx.net>
Subject: Re: [PATCH net] net: tn40xx: fix swnode use-after-free on probe
 failure
Message-ID: <avLuG_1eQJ-tAyC5@hovoldconsulting.com>
References: <20261110100051.2567443-1-johan@kernel.org>
 <179430521299.488859.1743918211448248351@kernel.org>
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
In-Reply-To: <179430521299.488859.1743918211448248351@kernel.org>

On Tue, Nov 10, 2026 at 10:06:52AM +0000, netdev-bot+sinfo@kernel.org wrote:

> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
> 
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

This was found through inspection when reviewing users of
device_set_software_node() and has only been compile tested.

Johan
