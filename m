Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690836;
	b=t+DITP93Xdrtbvmsg8Z6Aw5SumxCiPbVT0b71Vh5fUIqpWwvPVypclYG8uLSZOkdOimy
	 Ll68q+/UvhPIZ6tlDC2ID19pxP1Jtt+CzYsd66ZzhgdQhHdhkui4dpix2tGpF+V7zlVuJ
	 NjIRYLNblOU5Y2ADs2yGj9/Oq0OaBb84VpSiMl4o6dZcX/hqjFtJ6rzkvZKlvwDq9BoJW
	 yuXK4O0D4HFqomk5j2SUDSYq4evw0NKVyxE4Bpkednpe346RHnserx3DLrZDSraYmwM42
	 O6mEm+0SAPUn2i8AkzKYAoBFbv4/Ceef3LGSBH4owN3ij1dxSTcWY8OdL4/wscGNofw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690836;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KnI4XiEEZnUqfonLNz0d3Ky/4+ASOrj10J0r2JYLeWw=;
	b=SVetFOX7nIGVxnH94lFD8wugnUW8LClYupyHJ4arRsOHePLszMKfkHubeW2GDlRt45df
	 bpnDNrxVEnzEF7kC2bVm+wvA6Zoga5Iu3PX/ZKzPAGUFhVJUO6OUVoxg9FFi2/9Fs5gGp
	 5llXuLWMzXs/6N9lxhZgTyl820ohu30FsmKqUKBgYY8yjU5CCTBYvoLqA2j2vXAytqE8X
	 lp1tHoNBL4USQ5RVR5ew3nJ8AKVskqsDRBX02RAuvUKjdTEo75DR6GMpUGscrU34W12pM
	 YWZXGhIIZGpTb4Zyk0wGV9iVcobz45JNSUqrRI3zi+ebHZ8FEOO9mhj/X8BBxUvS6tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkuvyZkb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A434606A33C;
	Tue,  3 Nov 2026 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KkuvyZkb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7FB1F000C1;
	Tue,  3 Nov 2026 07:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793690835;
	bh=KnI4XiEEZnUqfonLNz0d3Ky/4+ASOrj10J0r2JYLeWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KkuvyZkbLA94fOGAm7ujkNDc/d184aSRYy48LXMILNfwGGx3FaGCIVA7o3D5dLM17
	 3ncp4S9D3pin1LESv57FNoKc8UzsGQhZMilVWOiOUflcsicjdOVlT0hEC1If7gD96k
	 6GaB/U/Zwfs9OBCmu/KY2BSry/YdE2w+svqi2T5VAmqpqc3wFn2sKjdCcF6weLgm4R
	 e/cFhEbm14fY8uuT2yULzBuq+HUSuq/9vz/WS9Tf3MYN7gQebeiqRPA2gfN1gknPqC
	 E3e/I7fD/wFAXB8pqyyQotx+FZS1fWhPSk8UOeAsq9yHvqHeed3mxGDeD3O3HVcj6Q
	 Rdb74dbk8CZZA==
Date: Tue, 3 Nov 2026 08:27:13 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, 
	rafael@kernel.org, stable@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: mediatek: Release DVFS resources when removing
 the driver
Message-ID: <20261103-fanatic-grumpy-elk-a1df5e@quoll>
References: <20261103063609.1028187-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103063609.1028187-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 06:36:09 +0000, Wentao Liang wrote:
> mtk_cpufreq_probe() registers the cpufreq driver and retains clocks,
> regulators, OPP tables and OPP notifiers in dvfs_info_list. There is no
> platform remove callback to undo this on device unbind or module unload.
> The devm-allocated DVFS information is freed while the list and cpufreq
> driver still refer to it, in addition to leaking the retained resources.
> 
> Unregister the cpufreq driver before releasing the DVFS resources and
> removing their entries from the list, as in the probe failure path.
> 
> Fixes: 89b56047f6f9 ("cpufreq: mt8173: Move resources allocation into ->probe()")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
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




