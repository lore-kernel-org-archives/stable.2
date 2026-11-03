Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704237;
	b=kqn58yZq7ZJeSTTaZhNARdXVLWyKhbg+R8ruNg2O14ajHnkx3Cuq2aukEJTr+iGBwUmC
	 MIYS3OAb+Mr8h4I5N8v32DbUYGBKfNvVY/SS9Ak19BsiwWNzQNaiCCEEXCDlk0Ujc3R8l
	 wnnUd9RkCeNHGRgZnk4RCrcmh1W2aOEaBXhoN96zILaQeM9+xTIxuWJcN3oQ7GF9nridK
	 0HXAXU3Ry4DGg+5ONHwDg/CxpzFRv6x2HkF0FoKROBzDUDt7eY1bd6bbfrz3yYEYaiCE3
	 76s/4BoBJG9XRE/b0krshh07m/ilTmeaVcSnfTi9xitYzDaCs0YDQ3eFq7Kf6bqoutQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704237;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LhexjFgLMi9KDZ2tlynj0L4TbfElzEQbR/cNygIzCDU=;
	b=RH5da3M9Fm5FzE0OzyVlVz43eafQPLsHouELLuehGhJdFNiVf/Tu4gImabf1RKux9n/U
	 6QXadfJ+LT9b0EhZQZ5/1GbuZjXouwSzg9wsDNJ+7Q1BeYuVFI5YNr1TOZD1tyLneui+8
	 XDOU4Q/7xyxo1Adlc2zRy8Wo23FYeqzI45Fir4tSkXUwDicbw44pgJwNJ1voUbHEtbMDg
	 OUD6uRr6pzhLSAFs0vSWMn/03Mw7AwrQno+qrIdz/QaLiUrFDMK0Yn8preNdsddmnXqec
	 wn6DsMe1tEavlRvtRjKoodziKqhjtSIKqdher8J+8JWYhSei2VmqgXZA/GRizEfDHNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwnmJNQr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E87A606EE85;
	Tue,  3 Nov 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AwnmJNQr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147E41F000C1;
	Tue,  3 Nov 2026 11:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704236;
	bh=LhexjFgLMi9KDZ2tlynj0L4TbfElzEQbR/cNygIzCDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AwnmJNQrxme/znXukONSzsqJs9HU7t4sX41bCrep/ULdgHchxh5gJs76akf8DKCwN
	 h9aMG+dQiVJXpZJ2yxFikPwpOI5mo5AAtkJxVUNbOkWcPgZPjIj/eq5VfiXoYsKy0T
	 guQKC3ZESSJHC4V/pYBfw67sNmv6DXOoro6tEE+SqnnTyng4UEr5APZIxgkL0legoc
	 SB7G+BijfLAp0Z5SN8gAIKgHm4XqFKNEVnjGQumEGElh5/CDP3YdAR+TsEb0rEvskz
	 Kf7MiuC2aEPybCG8UUM+m/O92c+CuGoQDBnIxSWvGtO3Dv5Vr+J8plviTLDmdsOqLk
	 0dTM2iPcnDjtw==
Date: Tue, 3 Nov 2026 12:10:34 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH] nvmem: u-boot-env: release the MTD device reference
Message-ID: <20261103-vigorous-antique-fulmar-f2b435@quoll>
References: <20261103104238.1373700-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103104238.1373700-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:42:38 +0000, Wentao Liang wrote:
> u_boot_env_probe() obtains the MTD device backing the environment with
> of_get_mtd_device_by_node(), which takes a reference on the MTD device
> and pins its owner module.  The reference is kept in priv->mtd for the
> lifetime of the driver, but it is never dropped: there is no remove
> callback and no devres action, so unbinding the driver or unloading the
> module leaves the MTD device permanently referenced.  The reference is
> also leaked when devm_nvmem_register() or u_boot_env_parse() fails
> after the lookup.
> 
> Register a devres action that calls put_mtd_device() so the reference is
> dropped when the device goes away, including the probe failure paths.
> 
> Fixes: d5542923f200 ("nvmem: add driver handling U-Boot environment variables")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/nvmem/u-boot-env.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
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




