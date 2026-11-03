Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793701632;
	b=Ss6+IxbJmfiJIjbXhSz46JNa2dNfU/ncT+49Xi5evM+a07sAKXzC1eQ/+ryq0mglEc8E
	 ymp43QhUDieEOmVMjjw8JpUciV77Kx3TPY/wZupaOMNytlxn+tzEiVenukTZYG24+Bn5V
	 F/zkty2uuXNOSzEJY49ZSC4+awHckIyZ7S7m4jmt5oqjfNOY7EfeENsD7qc7Zx4tfoLQL
	 wT9AdkaWCNAvjyZiZHxfHRuAVpVGNaSj1K7QuS4jfUPIMq5rWAQNUeEnVOhI1GF/ky+Kr
	 UdLX95QTHFcdnO8UEfnTPZYoie6+zG/FXmaDvonzYi4LAPKJ4m9iBLnnaUSO6AeU4vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793701632;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IhgesoIix9StZ4qDPjO+BPgeSgYAhuw3j0/JxuasPEI=;
	b=ynPUoToFeXBtRKrtaHfTOEBceCTOKw20zGpOfpliOrggIWNU02jl12s0KxnUih/FwYS4
	 GG1Er3P69zMK0+scygTiBEH3cAmzntVJjYGE0LPemfdR3BhNhGa8ndGQdUSwG5s63hfs4
	 ox7ZV3RWFWs4RJzWAUP3c/FgQaDYVXoPd4lxNb9G9jowv97F3TjthvH1bduexdOMYxo3p
	 K1feL4iv8KRAZxKdPxSpnKKoLVWy3tmvbC/uNJkrBCV3LQOZha6UvLHFa8yuivr439dw1
	 b5r90++WiC1gBkcUxKu/YdAk5bFSaoMEQ6JOiPQX3bSY2Cs/I6xT0pcRmXQdm4OUkKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Sk/650Fs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD3A60736D2;
	Tue,  3 Nov 2026 10:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sk/650Fs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D631F00A17;
	Tue,  3 Nov 2026 10:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793701631;
	bh=IhgesoIix9StZ4qDPjO+BPgeSgYAhuw3j0/JxuasPEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Sk/650Fse74yDh9z5CrHo7uJr/wIWlB1rrBHQLkVSLZ6j6T/rnUsGvJG0DQmVFybO
	 uxTaBZ0tqaVnnK0XGuqp5z3/O0IwzNRWvG6J2CON1e79KYbEK6ewVlTyLVhwuWISL0
	 7G0E5772CcRkY6FJYy39W1rYagft78YGkmkyY0/a/PcYHDiUZWblT8tw+1n/kRGNAw
	 qgRjFx0bt62aQrWf3dVwUe0rznNovF/ldIe53gMHrM/Ia3AxuRSu++MuuMwGv41x7W
	 CuiEvL5fMA2on/RzXX7Nq1kt9aeS0UpEPFTgb7BhxP4Qey5HRis05hduAEsgFCer+t
	 nvPR+wsTuf0gA==
Date: Tue, 3 Nov 2026 11:27:09 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Peter Griffin <peter.griffin@linaro.org>, stable@vger.kernel.org, 
	Sylwester Nawrocki <s.nawrocki@samsung.com>, linux-kernel@vger.kernel.org, 
	Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH] media: exynos4-is: Free the control handler if
 fimc_ctrls_create() fails
Message-ID: <20261103-resilient-steady-boa-90aed1@quoll>
References: <20261103094612.1289226-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103094612.1289226-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 09:46:12 +0000, Wentao Liang wrote:
> v4l2_ctrl_handler_init() allocates the handler's bucket array, and each
> subsequent v4l2_ctrl_new_std() call allocates a control.  When one of
> those calls fails it only records the error in handler->error.
> fimc_ctrls_create() returns that error with ctrls->ready left false, so
> neither caller calls fimc_ctrls_delete(), and that function would not
> free the handler in that state anyway.  The bucket array and the
> controls created so far are leaked.
> 
> Free the handler before returning the error.
> 
> Fixes: 9448ab7dec30 ("[media] s5p-fimc: Add color effect control")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/media/platform/samsung/exynos4-is/fimc-core.c | 2 ++
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




