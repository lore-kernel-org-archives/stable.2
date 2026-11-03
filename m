Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690809;
	b=xkOir3QU3pp9AK1YBiiJguXH2RV38VlJL0wmTJneOj2ZlBf2OZ5pJjTqTRA5/snCyyRa
	 Zfl2z1R7fYOICGIa982imD0wU1/5Mw4upLD89gJ0UtYP3E/r4JGGFJ8zkqSsR6AKkjlxF
	 7zIk7acnVullMCI0MJeYZ3NQrbG05IufXoOg4RTbVTsYK4dFcOFxoY6YUCOrHF7pYwEsE
	 Sg44EsHIgduEybFjgSJghjDa+/UhcnRMcfeV9VQIe62qNdGFesUQtYoxS9uSOvHg/cVUA
	 4RjMMQNpdtYlpH6q/wp4NZ28+gaXLLEDoR2KQpYLNj0R8EKnYwqVk7QLC/KIgWX0Qfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690809;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cWD6HISfk/RSMSoaxgmdaTD1BK2I+6ChmJkCmkdV6rY=;
	b=TW+Ww7uv9qw38pScpP81mHEk9Ww1bZ4jSe9K670UqznTBbODYqwtsuwIaa8jf3faW0tM
	 c7x8gqNOSA+vKe5dpZaV0A1jeeF/yOhD9SANTU09DzjjGwgQs6U0KHk5TUZd/SnK69OQ7
	 EZ3+amZmIvu0gv7tjkB4/DKUwu3HgkMxEdpoCIvf2w+ODgnGr98D41PnDLx/V81njo3WQ
	 xy+yhKJ6kLHw+mynTGAR1NzKehGwTV+Zn4q17IFzTORcm0oaW67GDk8BqynYgnIbyq5Qo
	 1rHFPWv1Xm6/DGMRE1uiMCblRYFNEV104R1Y4AiVeiklDtF0KOBAHtNLAMJVTn4zTVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g89jAtiK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C490A606A329;
	Tue,  3 Nov 2026 07:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g89jAtiK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B2E1F000C1;
	Tue,  3 Nov 2026 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690808;
	bh=cWD6HISfk/RSMSoaxgmdaTD1BK2I+6ChmJkCmkdV6rY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=g89jAtiKsZgG6WB+kazVgGXBuA6Ack/7yxaBEURfyryEQ849WGH4SYN1Z0dnf/oFM
	 Emd4a5Hlk+d+ZBdPQF4QOlYS7wtU0xVFkI6xe+4BmgCz8XhEnIHWGbWk8OKD3huiD+
	 e9OOUZnxeTwVOitvsc76slPRu9Q2N5nnf4LlYb7UhFKmdl/2Ce2mOZxWJ5mRyns3Bj
	 l/2B+STwAOOkVbEmettxU2+JOXoi76dOxaNUDLBjsXSlrkQD33bg+OVsezEuk2ufHt
	 ZrfsIlBlY7Vw7Rvlt5pav7ltQ+1bAzw00m442+s0XlS7idzkc06mIQB94L79Obp2PE
	 BS+KJACKF1huw==
Date: Tue, 3 Nov 2026 08:26:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH] intel_th: Balance the runtime PM reference on driver
 removal
Message-ID: <20261103-mystic-eager-beagle-9f9c7f@quoll>
References: <20261103070904.1085387-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103070904.1085387-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 07:09:04 +0000, Wentao Liang wrote:
> intel_th_remove() resumes the device with pm_runtime_get_sync() before
> calling the driver's remove callback, but never drops that usage counter
> increment. Disabling and re-enabling runtime PM does not reset the usage
> counter, nor does the driver core's subsequent pm_runtime_reinit().
> Repeated unbind and bind cycles therefore retain an extra reference each
> time and can prevent the device and its parent from suspending.
> 
> Drop the removal reference with pm_runtime_put_noidle() while runtime PM
> is disabled, before restoring the existing active state.
> 
> Fixes: 142dfeb20209 ("intel_th: Add runtime power management handling")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/hwtracing/intel_th/core.c | 1 +
>  1 file changed, 1 insertion(+)
> 



Multiple things here:
1. Your team ignored completely previous feedback. Multiple times.

2. You use multiple identities with this email, thus I doubt
   that we speak with an actual person.

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
letter), how to document usage of LLM and what you should not do
if this was posted in a good faith.

Best regards,
Krzysztof




