Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690841;
	b=LLEJnTCtmoqn2ox3JSZN3kzNH6GR07rGZXu+/NXCHk5QxiOYMYVsol8sMoojYUVHZ6cW
	 +vrdGBwMx9be2AYnJr9woB7TqX7eX3a8kriGyUJ82kH+qckjKRvAZ4zitZnNJ7j9oUa7D
	 0IARCOPvma1tVg0GrdGVVokMlqKaYbbwg16E/mtq3a887AQv1k7Dm/1MuIVv93OdiZH7g
	 mfw1JHdsDV5xx3cSnDpzwb7m2CJqrfpDtPS05LOwF+IiBPvmXUVrjLqcCl09SfVHdf0UU
	 Qygi50dSzWPBS7r7rsMX/Rq6LKeCpzdCTd07juaK+Nfh0S36KE8I+hOzKy8SLWv67zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690841;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vPHNiviDw8bCyhc2/1anGPmHqql6Qcpfxxl9tL+t7C0=;
	b=mmqXkWm4Nphh9APS3dyW0GejqIgOviMxWX5+4RRSM4Oplq0wDLZXC9skPqNVj5I+vSmc
	 Pkd3HtgegBN8lNc75uHf+Fy/DF/QiVGBhSaDlptdJ8FHHWHOWrndyR74/E+SZWLKjEal0
	 1GkGBfTc5t4AtVfZp0fKj2SN+lJ7FUr8QZxdoi1p6KZT9anuw9ohIe/+fNLLIUc+OhlW7
	 d5dpg8oVTPEA+xuLzIGCgw/Ii0sYCxyhn/YXoVQnDp6Vu2K1j0alK306oES6Lafw9zyNR
	 uoGWByk3u0/2b/wIX2nLHZlSJ+4ZVC3W3PRvuWszG7JkhMhH0mI7PXH1Zbfb71j7e8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W++qHBR/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818F606D802;
	Tue,  3 Nov 2026 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W++qHBR/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A7E1F000C1;
	Tue,  3 Nov 2026 07:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690841;
	bh=vPHNiviDw8bCyhc2/1anGPmHqql6Qcpfxxl9tL+t7C0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W++qHBR/CFynWqUgs6DD2Cnq4xQhe4cyelSfzgWD4iaca4jE7mQmxRiRNuXhiIypX
	 SXRpWbTWmGVPRGq4SIJltGuZULFpU723w3uIvB08c2ByrNJ6ix7JDlBkQJpokAMFKC
	 2YX2T7m41zsxuOD0hxNGaEobhTQfqxOU/byU0yIYwl1NP9UogA4JRnRWDwRkGTTMJS
	 IzUGZIvIs5oRoAKsrQICwOR5bCHbvrdFzMDHZJc7qbNoEQiFqVRIXirrl5k5cOtneb
	 hiCUkRGuDOa5u8o/wmQjQKdcJOiUEmtNcDVU2aOt9Uo341GhHKwyNLIw2yu+41re+H
	 clNCHkd6wX6RA==
Date: Tue, 3 Nov 2026 08:27:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, stable@vger.kernel.org, 
	viresh.kumar@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpufreq: pxa: Release the core clock reference on
 failure and exit
Message-ID: <20261103-persimmon-chupacabra-of-amplitude-9d0b3c@quoll>
References: <20261103062843.1020546-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103062843.1020546-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:28:43 +0000, Wentao Liang wrote:
> pxa_cpu_init() obtains a reference to the core clock with clk_get_sys(),
> but neither an unsupported CPU nor a failed cpufreq_register_driver()
> releases it. The module exit path also leaves the reference held after
> unregistering the cpufreq driver.
> 
> Drop the clock reference when initialization fails and after unregistering
> the driver on exit.
> 
> Fixes: d9278077385f ("cpufreq: pxa: convert to clock API")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/cpufreq/pxa2xx-cpufreq.c | 3 +++
>  1 file changed, 3 insertions(+)
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




