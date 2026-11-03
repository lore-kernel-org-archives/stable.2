Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701611;
	b=XZbetodK2JkyX3+g8S8gQXk8VKhBtyL6CszgGwRyxPuF9gwSMsIEnr+CLCWpgboC8hDC
	 YYG5ShIoe1d9sWTiMe/GoX1SkxeMepZ8GS/goYT43ptcRwwJQou3gegr93DIG1YW2AtZn
	 W49mKVHZHvZdoC8FE+o7aiNIUSv5ZKMXlU/X+3zwrhzTA3SXI3YnnPipn/qBAWT0Exi34
	 t3dxCYIX6gtnsNgsL8su07P+5QtvLzpykc4f+HO+lrEOyzyvbZkoU/5QCVUR8D9qP8KoL
	 Eb2PSkQwaM2hoee6UHXfTyMbZBzhnIsKItbKcq3HQYvUP0LhH454HyOqFNGYOhyZvgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701611;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=R9XeDdNG3SfD34Ot+GAcgU3Z6g81VFnBLXSrMlwBreg=;
	b=D1rRtjTg/QG/kZMlW9d3ygUfNvOA55wX1HXftx9JxV+wRSES2EaIhFE3sjVP2BD+Pnlj
	 7HP/grgbOJ9Bo8YPzNfrX2MJal9aWgvCzGtwcESVLUp17FWsd+ysAeuEQYrjSOzOSuW5S
	 AyjqnvBYed4O77+nPVtGuOPYBQWut5E46LwmJTWOSzAi6PhMKnwUQajg60AFYKtNoQT6C
	 uFRf3VWUMPMp6Bem3uJPusXpi1rY7UQ77z6TN3TpGwXeFSLtiWaF0GE7GPAyI2pF10PH+
	 LwApG9Xy9N0Kabh5CuWzuXsEuNqkkxSu5gTK6RXQJJhPu1RB0IswVwYOOHL5hQxlVuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gj7/7uaW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F4C606FAC1;
	Tue,  3 Nov 2026 10:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gj7/7uaW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8941F000C1;
	Tue,  3 Nov 2026 10:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701610;
	bh=R9XeDdNG3SfD34Ot+GAcgU3Z6g81VFnBLXSrMlwBreg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gj7/7uaWPD8l6WCj0nkt/dxqvS9SCyLl9TTQbG6hPZEVvTZ5+7uEmWYcgQJ5VNW61
	 SFuhU2qByE2lKcYuC9ggyHv94fyQv1Id3fNfwGTC5pJIHDQ4kAWNm1hq+YRueNuW18
	 o62P3bhO4pwqnKEaIO1omu8NR6FFii2r1WSUKURfTr4FEE+IVgiXjkkGoOXQ+daLxZ
	 lmMZ9M96hfu5PwTjnR2zxMcf47/LpDluWegzpGbV3fcPARsJmh51jtuBIzYjW8/Z6l
	 1KKvF5Hw5S0frWh36GQhe7TKp9GY8ihe3Vf4QZlh3eGV8gwn7DqTjJSxH8kvKmgOdx
	 ZnI/XJh5NZ6Ag==
Date: Tue, 3 Nov 2026 11:26:48 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-media@vger.kernel.org, Devarsh Thakkar <devarsht@ti.com>, 
	linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] media: imagination: Release m2m device on probe failure
Message-ID: <20261103-tiny-centipede-of-fragrance-a21f0f@quoll>
References: <20261103094617.1289402-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094617.1289402-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:17 +0000, Wentao Liang wrote:
> e5010_probe() initializes the mem2mem device after registering the v4l2
> device. When mapping the "core" or "mmu" register region, requesting the
> IRQ or getting the clock fails, the error path jumps to the
> fail_after_v4l2_register label, which only unregisters the v4l2 device.
> The v4l2_m2m_dev allocated by v4l2_m2m_init() is not released, so it
> leaks on these probe failures.
> 
> Release the m2m device from that label as well, so that every error path
> taken after v4l2_m2m_init() succeeds frees it. v4l2_m2m_release() accepts
> a NULL pointer, so the v4l2_m2m_init() failure path is unaffected.
> 
> Fixes: a1e294045885 ("media: imagination: Add E5010 JPEG Encoder driver")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/imagination/e5010-jpeg-enc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
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




