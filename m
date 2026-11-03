Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701592;
	b=Csmo4dfLlSZsLx2wO1b/4a3NFHSdLGuA/XaTAvtJi+9vHw7/6eiXIZleM68mVBrt+Odc
	 i5G7ZYnp3D0wvpsJQcr8y4I9l41lcz9D/syhR1RJIQjSJEG0zSR4zBP9g18dWI9QPGWra
	 arXICgUVkXYqSNmT068368W96Ug8N2yHfEumEsC5xyIeWBJ0qjC4Acw8l5AyEUW+sFLzH
	 3lhTx9bvNvTUuD2rbZOyf4MhVtSr48vZcGDmIuCJ+qSPZNB04NNBslNin8PAtegcdtKml
	 nAcjlg4pHUK41LrGWEihBk2kAXZt/1Y7ekGTErOHWiWut/OhkuFXlkSNyAMPpQ20Lzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701592;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KfnI8zt/AZ8WAgoOs9mBI1mCPV8VU01+baE2vWXucIE=;
	b=vVEnHcVCuOzPVr+9mKAcRiygc9KIawj+bT6r/d9AL48ACG91rkWo3AqiwuegwKq7eJWj
	 8vc4MpLDBrmenLWp3GJ3EgsWBxxqfTcadAdln0XaTahYL1YarJqQHsFCcuo9wklk2rGyx
	 KejOkmfuq2LmuEo4K1k7nfwjlygAZyj/iFf+Y4iJFo+G+145ALs11wg5/HLahROtYpv2X
	 V/SVaHOnMwyo+I34l98DuSXzc7iC6U2DYWh9MywqKsVaPU4UUs/2dXazRKqt3vOynBTFK
	 GUC0CteDLcexoRXeU0RRHle2FTWw+S/zGPKaYLqfs3Y1moIsIa+kJGOEeCs1WhrXYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBI+l3qQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0A7606A816;
	Tue,  3 Nov 2026 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bBI+l3qQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A41F000C1;
	Tue,  3 Nov 2026 10:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701592;
	bh=KfnI8zt/AZ8WAgoOs9mBI1mCPV8VU01+baE2vWXucIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bBI+l3qQAwA83v2g+i3NkocwEVgIFMlMM7m4mvG339fl5uhFrGYMAwhQfu0ZMUQz4
	 xH0tp6IXNO9CCcCTc9X/Xcbq3OdUSauTMwPEXehnbrbgzbCWaZrc6scUOefxZL+rjd
	 yxuPTPh4QfczMjAOn78b8LUuRS8R9k0UnsQfO7vBQVrIzM+FVw+nPwfk9g6rvOx018
	 EbhC8uRNJshBgXXCWK78Su6uVOtBTh/OmloSaZAq77wf6yE7hZKiF3GdZCdEMs0ykX
	 KqSM5WsmlY5Wdbv2Q1vTmR4JACURvuahkC0gQbibCM6v5dIbiOi2KEMjbI32C6V0sY
	 mG2OSQdv/hvOg==
Date: Tue, 3 Nov 2026 11:26:29 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Thomas Richard <thomas.richard@bootlin.com>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH] mfd: cgbc: release the platform device if driver
 registration fails
Message-ID: <20261103-advanced-memorable-swift-865a45@quoll>
References: <20261103094625.1289569-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094625.1289569-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:25 +0000, Wentao Liang wrote:
> cgbc_init() registers the "cgbc" platform device before registering
> the platform driver.  If platform_driver_register() fails, module
> initialisation fails and cgbc_exit() is never called, so the platform
> device stays registered and its memory and resources are leaked.
> 
> Unregister the platform device before returning the error.
> 
> Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mfd/cgbc-core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
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




