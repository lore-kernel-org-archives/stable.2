Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701565;
	b=vmq8FgYm/hZno44hnbevApJQLl7oE8ntuQRfESOxGw9DdDIrUclgUjyd3xT9QjcF6LNv
	 +Xj3f5R88+3TyaDyXUjRolRSGbodo2zDi7qKzTqU3gJbnqwaqraGGL3OUK9n76zmvg+WE
	 XvAZB7YBNVEJHJQvgqllo9OUbkQUnplaYhrx21q0WxLUknP6SxODCz76sQ0g1VQiVtQbP
	 0fr98D/56WTOJgC8qdb8d/70iTaY1Kngp9tvdlOUB3e4UIaMOXT2PJAuTzoUfdaZ+z8k5
	 gHO/FeIpALhECv0uOsDELK8enIRtheUFxC/V4x2S1VV38gGrNJDTVSEBoE9BP8Jen5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701565;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
	b=pP8RaftnjNvHOtCyXELrvBElky70o2d6kgfovR4dsxmi1cGiD1Etq8+fxXpsqZaMkdgI
	 B55f/7KhfdfawkLJ04tYbTUX7fUos6ZehnWJENPFuoVq+4NDCixB1UHQBBEnpr7DYWocA
	 PscDvt2kZWYLg1E1gjVdjIsslt5y5Kil96YvQFlnlbIlItEC309RjAuYtFLacnkNFppok
	 fsRZ5zTlhB4QmMvRKhbZhdzhk50nhf2O1V6qxrGiiF62zuNtmWU5mJCeNcSejgNO/y4xd
	 7jSMZDg3noABirW9exvt73dArXuoz5kk4Ck9ULCW4T+iVggRe5cLn9iF2KYMZbxe6sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS+lyWEt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF58606D81A;
	Tue,  3 Nov 2026 10:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BS+lyWEt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33231F000C1;
	Tue,  3 Nov 2026 10:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701564;
	bh=jGzIIOY4BFl8qf/2SZUl/Z8oABMX8e8gCsMY/rilcXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BS+lyWEt7n3tadznwP0sZc4HKRay2BzPOdE0Q5AvqaoufOqIqXEoZwzRF16B11TRO
	 wV0nVN0iKhuBh5tHsygc7PkXR2gW7dRXwIo2XC5Qx1fnu6r6WZqVTSyqADOixZuz2s
	 ey97QkjQhig6Q1u0d9pCdFQA7mtsY+sOdyPBIH220aGNgjMb+olYPhRTcd0xol98zk
	 CKzZQTwso+YBPDkHIEdA3wSjx7MJ50I34VerHcJPaSq058qipgnlxfDIsZkFbAPD9d
	 T4JtkWlCqTJATfeJfgEfC/gtJRvBtqibwfErZU+PKM2+LgqlBcnbzWSruwQNyD86p9
	 iGiIVpmjP5RXw==
Date: Tue, 3 Nov 2026 11:26:01 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	intel-wired-lan@lists.osuosl.org, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: ixgbe: drop the SA reference if secpath_set() fails
Message-ID: <20261103-arrogant-competent-jaguarundi-3c9472@quoll>
References: <20261103100534.1310039-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100534.1310039-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:34 +0000, Wentao Liang wrote:
> ixgbe_ipsec_rx() takes a reference on the xfrm_state returned by
> ixgbe_ipsec_find_rx_state(). On success that reference is handed over
> to the skb's security path, which releases it when the skb is freed.
> When secpath_set() cannot allocate the extension it returns NULL, but
> the function returns without releasing the xfrm_state, so the SA
> reference is leaked.
> 
> Put the reference before bailing out.
> 
> Fixes: 92103199f10a ("ixgbe: process the Rx ipsec offload")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email address, thus I doubt that we
   speak with an actual person.

3. Your bot does not even bother running checkpatch, right?

4. Nothing of this was reproduced nor tested.

5. Finally, the same feedback:
You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem (so a patchset grouping multiple patches with a short cover
letter), how to document the issue discovery method and what was
or was not tested.

Best regards,
Krzysztof




