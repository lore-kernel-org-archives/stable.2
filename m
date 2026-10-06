Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981063E7640;
	Tue,  6 Oct 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791287947; cv=none; b=BCxjQ+bZv3Afld/WRXXcjnVTsKhlphxKGpG8V1+bP7qWFDAblMFJUlfa5aTar1T8BCy1ibKzAILCuTwBzfSi374xWi6PEVFi0cmqnqMTKnDHev1TLxteqDWVcJnwsMklyte9gUDwXlBeNFj28e0LwwvTXK0aGmFAhb7bzYEmupU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791287947; c=relaxed/simple;
	bh=H9bIcuuIXnqAtetpAeZk6HQOWbnm3Kq/l876rTSS+CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TSta09IobKolacdb/ljejbvlWJKpxAFfhT2OpeMbo3QB3ROZmbi8yGd7kbKkqWwRGBkuydxSyWhi4iTDF2Hf+/A/H011Z1yvg6kD+fUpApIPNciNHMM3g51iPvC19zeKJ5xYNWdc6YOrDZF2YSLpiULkJxOapkPEuyaEl6UrdpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwMim50w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwMim50w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A387A1F000FF;
	Tue,  6 Oct 2026 11:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791287946;
	bh=TDwArwilkib5VnP7hfeIeZkF7gcbhxu4DwDUiOv/8Ss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iwMim50wMjIYXRSq++iaWAAAFoVOsl+Qrb0UhG9zz2/2qp8EL65L/yf7zLaTnaUYP
	 JY6O+zHUnfjnat8Q7ochTrkcKIlQWZpKXaBzNcL46B2V+DY/7Xojp7n53Yrm0sat05
	 deIaHlZtowPsK+xG1kcvPmZ7kDEa7tNMI6qevb1OC4JI4uF4Xaa2pGqCliMwMTysMM
	 DUlQimiHSnZ6oBYAV/sl9BjVVuZQ+dJCp6EUSzBo+wvJ1/vfribunqxjvHa/m7SPXh
	 eX2EQUCCLHw2zf+spXr+VdNHmyF6Jf5mE7k6+i61RILD++OorAqO9r5WVFYGRYheyo
	 A8sPgxPD/nuUg==
Message-ID: <97c651a1-7647-4f12-8b6b-74b949dce575@kernel.org>
Date: Tue, 6 Oct 2026 13:59:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net] mptcp: pm: in-kernel: fix C-flag endpoint accounting
 on family mismatch
Content-Language: fr
To: Yiming Qian <yimingqian591@gmail.com>, mptcp@lists.linux.dev
Cc: martineau@kernel.org, geliang@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, Security Officers <security@kernel.org>
References: <20261006114409.117190-1-yimingqian591@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261006114409.117190-1-yimingqian591@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Yiming Qian,

On 06/10/2026 13:42, Yiming Qian wrote:
> fill_local_addresses_vec_c_flag() clears the endpoint ID bit in
> id_avail_bitmap before checking whether the endpoint's address family
> matches the remote ADD_ADDR.  If it does not match, the loop skips the
> endpoint without incrementing local_addr_used, leaving id_avail_bitmap
> and local_addr_used inconsistent.
> 
> Removing that SUBFLOW endpoint later calls
> __mark_subflow_endp_available(), which sees the cleared bit, expects
> local_addr_used to be non-zero, and triggers a WARN and, with
> panic_on_warn=1, a panic.
> 
> Keep the endpoints that are skipped during this specific C-flag
> iteration available by tracking them in a local bitmap passed to
> select_local_address(), instead of clearing their IDs in the per-socket
> bitmap.  Only IDs of endpoints actually used for a subflow are now
> cleared and accounted for.

Thank you for the patch.

Please do not Cc security@k.o on patches sent to public ML. Here the
issue is "just" a WARN produced in some conditions when the user has the
rights to delete MPTCP endpoints.

(Please remove it from future replies.)

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 1a77508132354..a5952dd0ae125 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

(...)

> @@ -574,22 +578,28 @@ fill_local_addresses_vec_c_flag(struct mptcp_sock *msk,
>  	u8 endp_subflow_max = mptcp_pm_get_endp_subflow_max(msk);
>  	struct sock *sk = (struct sock *)msk;
>  	struct mptcp_pm_local *local;
> +	DECLARE_BITMAP(skip, MPTCP_PM_MAX_ADDR_ID + 1);
>  	int i = 0;
>  
> +	bitmap_zero(skip, MPTCP_PM_MAX_ADDR_ID + 1);
> +
>  	while (msk->pm.local_addr_used < endp_subflow_max) {
>  		local = &locals[i];
>  
> -		if (!select_local_address(pernet, msk, local))
> +		if (!select_local_address(pernet, msk, skip, local))
>  			break;
>  
> -		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);
> -
> -		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote))
> +		if (!mptcp_pm_addr_families_match(sk, &local->addr, remote)) {
> +			__set_bit(local->addr.id, skip);
>  			continue;
> +		}
>  
> -		if (local->addr.id == msk->mpc_endpoint_id)
> +		if (local->addr.id == msk->mpc_endpoint_id) {
> +			__set_bit(local->addr.id, skip);
>  			continue;
> +		}
>  
> +		__clear_bit(local->addr.id, msk->pm.id_avail_bitmap);

Why is it not enough to move __clear_bit() to here? Why do you need to
modify select_local_address(), etc.?

Also, can you also provide a regression test as well, please?
Adding a subtest in tools/testing/selftests/net/mptcp/mptcp_join.sh,
e.g. in deny_join_id0_tests(), adding a new subcase using
"addr_nr_ns2=-1 speed=slow run_tests (...)" to remove the subflow during
the connection.

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

