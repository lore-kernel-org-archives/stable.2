Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701545;
	b=AaG/DIf+A3062pMSszZxRr4t3YPfAlUbfRFdxxGVmU4b3dLKrZAwlK54jCFmqgxq5Ek4
	 kQulmhlQHYuSEDrUnSpAMgNouYg78YHpKN/69dh1pJVvM5FHvIMWhDfkDY7p3inIzFXCo
	 hoy7hV684SfIRn5hm5px3qfYgDFdC3Dk2gQ59gED6e2KpdFXSlnBGdFn9sqgkujIxQ0uy
	 dYzox8mn4efPDvDjuqMrq2CY+yfNAZpRl9u3dxFZkKnPkT76Aoz+rIyzDTrdMG23k61wu
	 nJWMTqeVhGxvJKMfa2jELJA0ECQG9wMIhAkLWfaiodP6REsIgrVTTR2Az4onXXStE2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701545;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
	b=maPAfc8cvjVFWUAQJ0zjcbfzvcY1qJpHGqSwN32EjWauHFDCnJH4uHh6EJY6NzTFJNv2
	 s+p/v1Ak1aNT+6LqVg7iCGE94AVPbpIcBfKunC+1Oavj9vnbK/dT6wSpYGyx0O2ikAA7H
	 jSCi6ACPIZJ8sVvvJvKnmyX/sVSFywb6kR1JdwmowxFp0D8KxnvJkU2rMqMLxjZAojRtS
	 QQek9XAExv7a7u4C0m49iWPKiJNhLl3vv/RLbOd3Tad4esITxOPyZEdivx67Wp5QNZ1DG
	 9SyaXDkFKQFnuMHs1FV4ZwM3fc2wmFGqeLZpkxrum0dFhs/TigEu7wfCGbVBjgPTaIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSx5z+Eg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF1D606BFAF;
	Tue,  3 Nov 2026 10:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NSx5z+Eg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 047651F00919;
	Tue,  3 Nov 2026 10:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701544;
	bh=u2LnnysjiNlnAErgAFylACAxMV+BLUH6+e8OJM6PuFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NSx5z+EgmJ/vqZbdQdsVGn57b8f6BhRgX4zf7ZogXfqYI/ouOgdCh3Jk/J06tb6wz
	 lihMw8dP784rFojOlkRlOi3BeCiwQzV+X2B/qZ3HX3wEYwCJrD5xVbvb6/9Jo0rL3v
	 x4hyIa73hXQE2Vbo2pFmEUrCFIcDuzAqg4kFcfHJR5hs5NkgQsS4lvp5JL++ECEnHl
	 xLZDjCdkRWXbowhxVnRBMjJm3LbBS8DhZZYPDWK+XyxuUyNNdAU1pfzC8HG83wa3Cp
	 n1kmcIchka8DV/BjwQnbK2sZhmPa3Ci3eAdIh4dvfZBJHxlagLe8rPf8M+l71EFyvD
	 bMys7mWMgqzrQ==
Date: Tue, 3 Nov 2026 11:25:41 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] net: ixgbevf: drop the SA reference if secpath_set()
 fails
Message-ID: <20261103-esoteric-hyena-of-penetration-223ea3@quoll>
References: <20261103100534.1310071-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100534.1310071-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:34 +0000, Wentao Liang wrote:
> ixgbevf_ipsec_rx() takes a reference on the xfrm_state returned by
> ixgbevf_ipsec_find_rx_state(). On success that reference is handed over
> to the skb's security path, which releases it when the skb is freed.
> When secpath_set() cannot allocate the extension it returns NULL, but
> the function returns without releasing the xfrm_state, so the SA
> reference is leaked.
> 
> Put the reference before bailing out.
> 
> Fixes: 0062e7cc955e ("ixgbevf: add VF IPsec offload code")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ipsec.c | 4 +++-
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




