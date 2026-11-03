Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704258;
	b=4m0eQsoj5r3yp32mH3ckxp/nLOk8AYoE53xEQOe76XOqyjdl/xK3qieDpzcjWtoOsFou
	 wjL5AyYJnNXwnBPwLqu9ZdTDk9r3JUSiJAa/NMaBXj73Lkz0IsUSqTkyfGv0ta/wjpBD1
	 LSatm8B71bUll/wteshk107lIbSGWUd1R/REHC564im3SVZKJU783GqTrMmaOWMOjMhHa
	 LmILExSqUckDlzB6h9oM8RUu5z58BFBFkaJbAnn+MYCUg0Cri4zmG6GkMTzS6SDmrTydJ
	 Sgc1K6WxTyojvW7YzNuOL18cnhCJY7WbKLIletkLpGivFSqvTI+8bq0zw+ahWwXSHkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704258;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=RE+aXXA/wR6GIKDSc8AVIfNk5ebi+YmfdsADPRUWcYE=;
	b=1Khaw4luxXTSMvnEwf2r3vaSJSf7KwZ+RsuDRXf1cFs7VMkj+rtE7rXNC6lwdJ43oOPX
	 VHXq0e63v7MDK+4uqEF9Ev9fVCqGRbyfQkZSCICK3IafDysU73tmWw+haMhmV9xEQIe1U
	 0JhpBKrNQoMxwnY4yT78osespmUsLIo3fx0k52t/AjlRUpkg6jYVy24jIrhYZIxeTwYXP
	 bN2lQEWGEPqsAX1rHyqxZ/dBdfV9hMfvYQokiTAi8DeM6miU6a8P1azdBHvveODXSZm9s
	 ZNcX0ZNJw0276lAcwSOzU1gS+AH3MWMXgM0qKqqhWTKAxtv/SXkiyDCsBDRLfsFtDJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyY1VKm5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E137160A2631;
	Tue,  3 Nov 2026 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyY1VKm5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358551F000C1;
	Tue,  3 Nov 2026 11:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793704257;
	bh=RE+aXXA/wR6GIKDSc8AVIfNk5ebi+YmfdsADPRUWcYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TyY1VKm5LDVr7ikDYq/sAXeBKjInzslwl3OqClwWZLEtUKaGaTM+gS4jKHd6YyPD+
	 17+WL1VaVBEmTDRkAgw9I6zELadqi0r2ra6bq26qzSU/YMP1HrDwvvXsTccp2gQ8bn
	 r3kUWrhQdlXaGJM2I0VKtX5ORv3u2gHNefDlhAYM1BP0q4sJ9j0YlQfJL2075xI8nx
	 1VlrP/HrqNi4AlpA6A3QzJiIqqE1t/YEkcDak/uQUMqA+HGqB2VD1yoPgj9mJrkNX7
	 Ntiud5HCEEL7FOqucqBAOjnsZhII/TFr3p5fg/IXazOs3i7KyFgLW15Xsgl7ciL7n7
	 eeqy6uKH3JJYg==
Date: Tue, 3 Nov 2026 12:10:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: ath6kl: free the ath6kl core on USB disconnect
Message-ID: <20261103-unbreakable-chinchilla-of-aurora-d98dcc@quoll>
References: <20261103102901.1340914-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102901.1340914-1-vulab@iscas.ac.cn>


On Tue, 03 Nov 2026 10:29:01 +0000, Wentao Liang wrote:
> ath6kl_usb_probe() creates the core with ath6kl_core_create(), which
> allocates the wiphy and the per-station aggregation state in
> ath6kl_cfg80211_create(). These are released by ath6kl_core_destroy()
> only. ath6kl_usb_device_detached() calls ath6kl_core_cleanup() and then
> frees the HIF private data with ath6kl_usb_destroy(), so the allocation
> made at probe time is never released when the USB device is detached.
> 
> The SDIO counterpart, ath6kl_sdio_remove(), already calls
> ath6kl_core_destroy() right after ath6kl_core_cleanup(). Do the same in
> the USB detach path.
> 
> Fixes: 241b128b6b69 ("ath6kl: add back beginnings of USB support")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wireless/ath/ath6kl/usb.c | 1 +
>  1 file changed, 1 insertion(+)
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




