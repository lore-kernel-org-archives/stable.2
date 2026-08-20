Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2283C367B68;
	Thu, 20 Aug 2026 14:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787237318; cv=none; b=teb6NhUBon0DZfI4Km/cjfddWDbhuIAlrF2TN6gzhj/GqqUrayyILEzkGJjavbULnqRMjgjcfff4ksoP7hM+AScSiEgDf/herP78LB6DdY5p9pGeIiz2wtII4bbbz+F8ucel8mAEDnxFGjwhNe6c5mVaLHzh2QyKDKdc8OfPMWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787237318; c=relaxed/simple;
	bh=OsBkTeNrbunJLFzESNPCWKOTIUFMhDbMa+60GRaExeg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UPVBkd+LbpxrcDycePv4cCXB76mNFbcM6J8KE+88V27VRiNq1hO6CkC3EKA4WFJbU93vVIwUS9bSibK8yf/vP2D/haln8bNJ/fkAH/jqmTiWVtN8VRPvBaEuEK1KFQFQ6LfyxykgvcVCzgt3jD7Iyk5ghEnZ7ZefBV4MreW+TrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aeJInlIx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aeJInlIx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0411F000E9;
	Thu, 20 Aug 2026 14:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787237313;
	bh=kFyHRqu+JaNhGqZzmEuwxYZUBHvHFHl1vgQXkY2YlIU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=aeJInlIxxUpCnltkIF5i//8tvfpmKdcBizMmAbhsLTaUmu1ivAQVErhniQZ1xuQ2a
	 3KizNjpyU4ReOCdSXiuuBFWpCNfwIqWhFMQEhUAke1LZLa9hCwCmQrmMtxlZg399Nc
	 W2gdo3xMVbfVHrXLRIZr8OCU40dYZTwR3Ur0VMqRY6AGk/kQ64b6+OyATiALy+o4Ri
	 Wo2RDcRuayDgHrHyWKkCafuyPNEgGj5PmRnL/p4XszAk3tM9FvpfaRx32hrgge41jy
	 vkdzE112KST09TeuPLUoiqPmjojNvNcbNG7Q4FCAu+hUPM5Ax8OUwjnmuc9eKzw3Iw
	 s7BTIBGfw/Z2A==
Message-ID: <0d9ba848-bef1-4171-ba1d-edc73e65ac51@kernel.org>
Date: Thu, 20 Aug 2026 16:48:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] i2c: mv64xxx: fix autosuspend cleanup
To: Guangshuo Li <lgs201920130244@gmail.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Andi Shyti <andi.shyti@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20260812085808.3313948-1-lgs201920130244@gmail.com>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260812085808.3313948-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2026 10:58, Guangshuo Li wrote:
> mv64xxx_i2c_probe() calls pm_runtime_use_autosuspend(), but the probe
> failure and remove paths do not call the matching
> pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> Call pm_runtime_dont_use_autosuspend() in both the probe failure and
> remove paths before disabling runtime PM to properly undo the
> autosuspend setting.
> 
> This issue was found by manual code inspection.
> 
> Fixes: e5c02cf54154 ("i2c: mv64xxx: Add runtime PM support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 2 ++
>  1 file changed, 2 insertions(+)

Srsly, one more separate I2C posting, just like you did for dma, crypto,
drm and everywhere else. You seriously waste our time.

You sent vast amount of patches, all separate, making it very difficult
to track and respond in efficient way. Do not do that.

Group your work per subsystem.

You were asked to clarify and respond to incorrect fixes statement. I do
not see how you clarified and responded at all.

Best regards,
Krzysztof
