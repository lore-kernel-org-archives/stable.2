Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704219;
	b=M9K2r4LqlrcvTXYleY/xkUXCbgX3VRWYc/vZ99GNgERKcsd7GBovjBJ/YEOCJ421lqCO
	 6gTuwYHhiFD3CA7/vfweotLxslwtSbvvK0n/u8uXlHyZewAHbPyEsH4k5npTu9xh5OltG
	 FXZir4z8DoHMDAYFkhm0+CALNSn+H9sivUiN6E5K8WCc3JQUTGD/fZD0LlgOaAGgFA5uI
	 1frL2xgxqtL6hcGtcAkWy4gAULguBG6QVHCtc5aBOOsxedaKpXQVPqQtEFlQvVVbtW8Sd
	 1rl5ibcJyovKT1SMfnrQXdNkqMKjD9sQsvLRbaRxj+Bq6149A8Aic6y75js8SmX6F0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704219;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=NcMf+ZVLmz04u/HN3Wxip9DQ9rG8PD3kxPva+jU7U8U=;
	b=GYyW39/AK7tfsfapnt/gTZvRA2DtZUxN6KOstW6pIWFivoy4o7C5pAzTJIKmuOyIdG4s
	 oxFODd7sFU1ZCq6NDvOS2Xu6gPzgeENOwFdEZ9uvlzU5xZZih3Zon8i6L8xK8IrQJShAm
	 vHmwZweRUodEYH6NKZWGKJJsw3tMkYaeC5S9KLEPxM4z9xgdCT+jvfZELtewoR8aT4TIH
	 vdEqHiOJr7rd0DXfzcXuxg52RWM+ZZp/FvKHeeLH0Rr+dmD8Tk8IZ9fVnKk98DZlL1vWH
	 ovULAgCTPg2VHgYfykfqQlXr37vjPsPguyn6t3nLE6HmkbrMi4VpYoVNcSI+Mu/rrJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mdlyZ/Y6";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99F7606C567;
	Tue,  3 Nov 2026 11:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mdlyZ/Y6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B348E1F000C1;
	Tue,  3 Nov 2026 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704218;
	bh=NcMf+ZVLmz04u/HN3Wxip9DQ9rG8PD3kxPva+jU7U8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mdlyZ/Y6k0sbdKbPikMDKXgsUtOAz5HrJRPAoVFXjshi76nsuMvVkkNHl84B39eLt
	 mylrl8mWmKM2EClq6buoqHPVskn/HH+gGTbb4zYZkydPBBaG4OhhTvpUVrSChfZPQw
	 wc0nYOhZbdHjk5953sL3BwLrcZzaeN1Tzir+BqaLaTNmwvl3Y9FqA5jyIbdpZvU4z8
	 cyacM2376J6s3vZMEcviRg5GpWEPOQKC93qLHBlorrwsozfkQl/m00ZSnL4rzhAxjZ
	 dRxtNnkk/4oSqbMt4iEGK0fK9XmmAXGlgKl/iEQTZsK6oPvi2WIZzF4EMTBXD7JF6O
	 vK+JeO3lmMKKw==
Date: Tue, 3 Nov 2026 12:10:16 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	linuxppc-dev@lists.ozlabs.org, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Zhao Qiang <qiang.zhao@nxp.com>
Subject: Re: [PATCH] net: wan: fsl_ucc_hdlc: release the net device on remove
Message-ID: <20261103-psychedelic-malamute-of-health-ce7f30@quoll>
References: <20261103104237.1373675-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104237.1373675-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:37 +0000, Wentao Liang wrote:
> ucc_hdlc_probe() allocates the net device with alloc_hdlcdev() and
> registers it with register_hdlc_device(), but ucc_hdlc_remove() only
> tears down the QE resources and frees the private data.  The net device
> is never unregistered or freed, so after the platform device is removed
> or the module is unloaded it stays registered, keeps its reference to
> the module and is left pointing at the freed private data.
> 
> Unregister and free the net device in ucc_hdlc_remove(), before the
> private data is released, as fsl_qmc_hdlc does.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wan/fsl_ucc_hdlc.c | 2 ++
>  1 file changed, 2 insertions(+)
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




