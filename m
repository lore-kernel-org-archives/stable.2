Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429570;
	b=neVU/Tp6nlcB6ghxEFJuvX0YxrVihi4M9wiJfm5Gy+EVlSmD1VVaUkWfIRToU6MV47L4
	 GXRg+8UE/k0DKi9BBF0ifm1DpBCQkP037RacAzmodLE5JWzjESLkc4scz5hq9gDYH5TxO
	 cWs1lsVVn/2Et9ZOiYOadOTURX6swKsgnBxcblMaVu4aHcunBz/CRteT+cIcKKQCpBK0e
	 reXr9wt/Fgxk2epuO4iLAnl3SZrG5oVTuc+im7NtaKUSGydPMlxKcZCvtn3RINIH/CldT
	 5YHsjWbVNrk57JDUpTcxdfyml3vGNJV3kZuD6p+2n8RoC+szBzIM4Ptbb0iPgRimmYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429570;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GspHiISsMAJGMf3UxXzlbBZfXcuYxjQHDRAjesilWu4=;
	b=OIaRZuZhubHFSaEdKqxwuWJCMNmQHdLDVYH0Ff2uj+aSWSs31iOX2dCxKWZM6e8JJdg+
	 ljT0xcZ38cAlX7B03t/KO91I5VwYRww1Zij7qj6Sg7cjke3Q/c+lJ4/BY93GHMTu5+P41
	 FK3jcHCaR+FjTd48WqRnKIDdKjwaTMyMD64gtvie4FDQ3bOPPQ5P7PWrK/5gB4VEos1eP
	 KDRx8zlnR4WUR7VIVTj+FXyWWwULzBaWyfbRNdBciTKSsseNuesTTs1viBUO4hEYJWW3u
	 RRnELuQfzIbCGMx66TJC2521lfOZFSfUwZc0SUKfcpQRMrZl2G2Mg7W/fOfURq7ND1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhe16LJb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40A606A31E;
	Mon, 23 Nov 2026 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fhe16LJb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 496B71F000E6;
	Mon, 23 Nov 2026 10:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795429569;
	bh=GspHiISsMAJGMf3UxXzlbBZfXcuYxjQHDRAjesilWu4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fhe16LJbqMv4h0EgzpTJNPVpQXaFwFrx0yzWMfj/jW6j7JpWRk7ZDGrO77/YbSj40
	 CgXtUZfv8+vXCSjLOYrbDGjTkXWBx99hSz0sxS48QjmlFwGBbR22yj3rQIUQaL/vRv
	 yi3NJ2f7SQj0f+PMeS8P3pQaW7aYDKmdykoLLXb9FMmaOS66tFG6BIwgFdwNhTwmZl
	 imJXhRplH3PJVPjM8WmNwC9T7r1YbWlSvV9lV7EFIlL8eVLJ8VgaRSa6yKenPurl8i
	 MS9xlGI1Wf23urMxv4aBRm7PW2WegvAAolhDbxW1ZzS6GdEuCf4ZM4RtZe0Wy9KjpB
	 KXvtOyecECg+w==
Date: Mon, 23 Nov 2026 10:26:05 +0000
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Dale Whinham <daleyo@gmail.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Dhruva Gole <d-gole@ti.com>, Haipeng Lin <jimmie.lin@gmail.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Charlie Garner <charlie@akao.au>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_scmi: Don't mark OPPs as turbo without a
 sustained frequency
Message-ID: <20261123-eccentric-ludicrous-roadrunner-0a7efe@sudeepholla>
References: <20261121-sp11-noturbo-v1-1-37e1083cec5b@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261121-sp11-noturbo-v1-1-37e1083cec5b@gmail.com>

On Sat, Nov 21, 2026 at 12:56:02AM +0000, Dale Whinham wrote:
> If the firmware reports a sustained frequency of 0, every OPP is marked
> as turbo. With boost disabled, cpufreq then has no usable frequencies and
> fails to create a policy for the domain.
> 
> The Surface Pro 11 (X1P64100) CPUCP firmware does this for the two
> clusters that have a core fused off.
> 
> Treat 0 as "not provided" and don't mark any OPPs as turbo.
> 

Charlie had posted a fix for this a while ago but never got back to my
comments.[1]

> Fixes: a897575e79d7 ("firmware: arm_scmi: Add support for marking certain frequencies as turbo")
> Cc: stable@vger.kernel.org
> Tested-by: Haipeng Lin <jimmie.lin@gmail.com>
> Signed-off-by: Dale Whinham <daleyo@gmail.com>
> ---
> From decompiling the CPUCP firmware: it reports as sustained the first
> LUT entry rated for exactly the cluster's fused core count, or 0 if
> there is none. On X1P64100, clusters 1 and 2 have 3 cores but only
> 4-core LUT entries, so they get 0. X1E80100 reports non-zero values and
> is unaffected.
> ---
>  drivers/firmware/arm_scmi/perf.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
> index 0116ffb2b279..d4394984a0f5 100644
> --- a/drivers/firmware/arm_scmi/perf.c
> +++ b/drivers/firmware/arm_scmi/perf.c
> @@ -879,8 +879,13 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
>  		else
>  			freq = dom->opp[idx].indicative_freq * dom->mult_factor;
>  
> -		/* All OPPs above the sustained frequency are treated as turbo */
> -		data.turbo = freq > dom->sustained_freq_khz * 1000UL;
> +		/*
> +		 * All OPPs above the sustained frequency are treated as turbo.
> +		 * A sustained frequency of 0 means the firmware didn't provide
> +		 * one, so don't mark anything as turbo in that case.
> +		 */
> +		data.turbo = dom->sustained_freq_khz &&
> +			     freq > dom->sustained_freq_khz * 1000UL;

I worked out something very similar as a solution. Anyways does it work
if we also add the check for non-zero dom->sustained_perf_level ?

No need to repost if you agree, I will fix it up while applying ?

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/arm-scmi/20260923152245.44624-1-charlie@akao.au
