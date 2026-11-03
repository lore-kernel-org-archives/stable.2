Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701574;
	b=iBJ36cedFqoq18xrnIMu6EkkLrM0H53ggzRYMK485rXqpuyg1fx0nPrFXISZA+LK8kqR
	 kCRW9xaBXmy4v68Iu67hYCTJWFtyyzpUdeeSUEOBNYe8XMtNgmnFcNpp5B72PkmsKBLA1
	 sfNRD2EVkr8X5xpP3w7DliLiWVStpisqnDIbBCEvKNHxbmns+GNe7m94vNa/C0p7f3oHs
	 dlSy7FbRQxcgc8/Hp21tEBDkYwgg5jped4e3ImOvNm+Iz9TXBqHGpP9TR6HvWzJDpuJQi
	 vNvZCsOMSioAoaCT6CiB3UXARX4d+4DoQaR9aaF4avhz7VmTFPEJZKmnw2vu0fUZ92A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701574;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qUyoZGjFGQOPeeRO9E3lTpQ1eLM4d6d6tlvrm+8kxb0=;
	b=G0tQoo0CBaxeXlNZNPCtahpXCBcnQpjjNhWJhSnbELpvakhL4MSSZqgYsI9JcMld1F0A
	 AcfC3pNki9RksaallOdNCP6HZvnRK33coTkYnAtMmncLVgD4mL/z4PiQIVSt52TPPXacO
	 3RE10HjHpq0OmWMxKeE18RhPIvCROOvhhFkuY/+56va+KyFeVN+Iw9VJzOpJO5OF5PZ+v
	 icudJ7G4huPaxAiHIBYpPoFNplc2aqP/PLeoGAxDp+i3Mcx2ukETX76rorGJKBCdO8QXU
	 coaEYHk0eOsGzcyXzjUbsQ9Ud6uO1TUsdIIQxyp+7mC+b3DktVE/DpwnPxC/GbzgypQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFkSfzCh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1FB606EEB0;
	Tue,  3 Nov 2026 10:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lFkSfzCh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB91F000C1;
	Tue,  3 Nov 2026 10:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701574;
	bh=qUyoZGjFGQOPeeRO9E3lTpQ1eLM4d6d6tlvrm+8kxb0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lFkSfzChsyncS1wMeU3n9VEwiz8x0Fo71a/5ra/ytsLVU3hRGSo0FJJE3YkCF3kxq
	 jPKnCfLlTzXsUG9QHLidsVMZDz6erG/Bb76JeTIPea/xX0uRA01of4Ta7VdDYvjCsE
	 0qDbmSmzQtM/tDZzqtAwuUbEyuIHP1sLp5fsh+2gYs7zGrYJeBBlEgxdio27DSBSMF
	 sllaNWPGI1dcjZlB8jelkOC3jHksyXRxWC32VZYdvfQ0gk8+IBFoUlRQ1t4Z3/kXRq
	 xrnc/BbfCmags8Dk47dr1Cc++p/BjUgHeGJ+sRzi/TnnfAye3DDqg5eqP3QVCPFF8j
	 2C6tQk1hjCkPA==
Date: Tue, 3 Nov 2026 11:26:11 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Vladimir Oltean <olteanv@gmail.com>, stable@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] net: dsa: loop: release netdev reference on registration
 failure
Message-ID: <20261103-subtle-private-dinosaur-e0effb@quoll>
References: <20261103100529.1309887-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103100529.1309887-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:05:29 +0000, Wentao Liang wrote:
> dsa_loop_drv_probe() takes a reference on the CPU net_device with
> dev_get_by_name() before calling dsa_register_switch(). The matching
> dev_put() is only done in dsa_loop_drv_remove(), which the driver core
> does not call after a failed probe, so every failed registration leaks
> the reference.
> 
> Drop the reference when dsa_register_switch() fails.
> 
> Fixes: 98cd1552ea27 ("net: dsa: Mock-up driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/dsa_loop.c | 2 ++
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




