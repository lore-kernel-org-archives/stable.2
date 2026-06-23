Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1386D242D65;
	Tue, 23 Jun 2026 21:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782248775; cv=none; b=oA75UR7Vo52/UPrg+rDNEp+3aIZ3UFNFnJEnurtA3jF1Ls8Cmq5dsmjrhuJg9aAEpBAlC9dyJswq4lma1igARqEj0ap5ExC45Vu6+t5LDt5jGl8yLO/O2/INxhPC+Fedvi/0Q8iJd1f83AspPdyK7L1WYGUt6wNzRtJzsGeIy00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782248775; c=relaxed/simple;
	bh=OmlqrksIMUEC1pIlVjNzTHZ3h4FHLGXpP7MGs0ygmGU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k4miEMPO3nb1ZuKGEEkAM2930Ia3QqcmUdK9u1zub5RQ4a9aI79TSLBBbTw1D0M01XTITDVrRbLftnk1PeY6VXJnRrsfesta5bbJXuFqFMmzML3aI674mcANNsXthat3XHraCjfQhA4wZX6U+aTCPbAPbTTr00Z4e83uxr9fko8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IX6onWwp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IX6onWwp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB22B1F000E9;
	Tue, 23 Jun 2026 21:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782248774;
	bh=btyawJkQsfw1oo8Y8zJTe7hXSr4b47wC/ZxD1Tk/dK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IX6onWwp1kbVy+CNiR//uNY4MHHZgO5uLW/VlBe5x8DKjYocFDm+FAYBlHKrf2uR4
	 MUe+1G4KJt9A8WvCS745WUjKVBKoY8pZ0VyJbC9TBH0QeeUOPFZST2wRSnCPQjzEVT
	 bNsH1Btdhloxo5f5RHJzRMO+0M1ZgAE0TGyf6jFI4NNnelcxg1+m15gf94O7VMiVjE
	 06yOi+F7Mt3wuoxW5dYOvkoRgXVYCf1FsdujZC4f7rEaphxYPH+ofe20iPNdu1r5Yy
	 u2JTapvc0a0601PiRH20OcVwmMP9QKt8UnsCFTCmbKXUhJKGzzDmhLCEXEb4GdSyK0
	 AlUXAeCFYP6Dw==
Date: Tue, 23 Jun 2026 14:06:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: Alex Elder <elder@ieee.org>, elder@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: ipa: fix SMEM state handle leaks in SMP2P init
Message-ID: <20260623140612.0c7be551@kernel.org>
In-Reply-To: <526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
References: <20260623031831.1788454-1-haoxiang_li2024@163.com>
	<526c68fd-684d-4593-8c6a-e08aafdada5d@ieee.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jun 2026 10:53:49 -0500 Alex Elder wrote:
> So I guess they were never "put" before?
> 
> This looks OK, but I'll just mention that the IPA code
> doesn't use devm_*() (managed) interfaces.  So it would
> be more consistent to just call qcom_smem_state_put()
> at the end of ipa_smp2p_exit() for both ipa->enabled_state
> and ipa->valid_state.

Let's do that instead. The devm_ APIs prevent about as many bugs
as they cause.
