Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701608;
	b=rkWRM3FJkdz3Dh/TuNKzmNmd7GyGXWYhQ2bn/GcX+Kug14tEdQdmNDrb2jaXjTuhKwPv
	 U2eDOBOAyPPK7JvKmG5EZPTBkZfxR1F00QNvKvVSHjdRxDNDJrEFEhLqIKkl+UhcZtHkm
	 cGI+e1XimuzyjMd6xN8e4P4DKOSmcTv+Z68xjXsWR7iaxp86kjwqq4LbgH4pPUGyStUjc
	 0SJrPd7G3kF+XyuRDpzsRlK8IhMtNq1YAFO14n3QzXdcOD/Ikt6flzhb1FoNY+XXNljlq
	 7N5x2n1SXcNsjFBQ3085fEAIbWiTXam0h2WDrf8l+pohYi2JjSFz6Yf9LSQ5+bzxnQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701608;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mh8rt69uVGWEk6uWexYeiT3eBD3jutwzkgfGqG2cZjk=;
	b=Uve3VkuT/vFJa91ZbTnOF7QViVs8T/Uo9nGYP/Ki/8awCCuNsrPgRixl81ZhFzKKeF4K
	 WV7t3RiLGDT+44NTfDYEqTxjmgwjumboM8HP2axGnAScJCdSlb/Xyji4a9K9xFW4lODCf
	 zzbT1LkEl+h9tkqKLhyXCXkPl29SU2hdnvUj3tUH2bjJsvQyxfjdUjq1XS1L9Hjw3y+ty
	 nDKNU46opjt2Xk/QNW8PaTYfecxyO4i8m4s0JWJftaYc1vvI0NtCJgffucy4/3BEquJIb
	 yVa5/6RQXhjFTtd0mO0tbDev9HPqRkN2gvfC/8tP93YA6OHk1er7XRXpadRUV4nJJkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzT1jeAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBA660711C9;
	Tue,  3 Nov 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzT1jeAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7F61F000C1;
	Tue,  3 Nov 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701607;
	bh=mh8rt69uVGWEk6uWexYeiT3eBD3jutwzkgfGqG2cZjk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UzT1jeAsUM7d5M2D7w1HsM2VkaMnz8fOp/0fKEJlQj82DnbVW3NNj7B+QklIUIOTj
	 bKwThRxnXyQL2BKaSXqeWJPhFIAYmCaAnYzEVEgXChQDLcOhkSgfA3cKakAdhpl6WP
	 bvRfUtfGsnu2l6FhGr6gE78CxQH/xqofEJqlS1xhI7wNkzatTVUvzl2f9KUDKBQXj8
	 7ug5wa5kyr9ONeSENr0kbKcHluQ5H5SzIzL2Pz4Qk6uQN2fIlhmsf0RdPbInrRmItH
	 QrmgfyZC0ox4Ksv+oicTaaV8zMmkFozKNKBFV+kR0qRMy2592fLsgKUqj2h2kHzsar
	 OlZuUuIm+C9nw==
Date: Tue, 3 Nov 2026 11:26:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: cx231xx: free the rc device if IR client creation
 fails
Message-ID: <20261103-meerkat-of-unmatched-unity-fb507a@quoll>
References: <20261103094623.1289509-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094623.1289509-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:23 +0000, Wentao Liang wrote:
> cx231xx_ir_init() allocates an rc device and hands it to the
> ir-kbd-i2c driver through the I2C board info.  It then ignores the
> return value of i2c_new_client_device().
> 
> If the client cannot be created, ir-kbd-i2c is never probed and its
> remove callback, which owns and frees the rc device, never runs.  The
> allocation is therefore leaked.  In addition, the error pointer is left
> in dev->ir_i2c_client, which cx231xx_ir_exit() later passes to
> i2c_unregister_device().
> 
> Check for an error pointer, free the rc device, clear the client pointer
> and return the error.
> 
> Fixes: 141bb0dc2d0a ("[media] cx231xx: Fix i2c support at cx231xx-input")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/usb/cx231xx/cx231xx-input.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
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




