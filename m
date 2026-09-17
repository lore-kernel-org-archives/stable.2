Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9311A4FD27E;
	Thu, 17 Sep 2026 18:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668151; cv=none; b=RCCBeOF4XseNVRIePPFMi/uv19YjtcrWEhYuxwgyTIkwnzuLNjz5hKzXiDQc7ZlgCu032L41CzgpExAcF/szWspp5XBMsB+QSNAZtFTrZ96hsL9JIggJBXwB9j5lCN3wwudso0//hbjgUGIm19vDI5BldglX3yTIzLeu98xFCl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668151; c=relaxed/simple;
	bh=JldMhV2U3O3qyM0I1MwAI1p2YVFkCCvDXuwG8kfUspE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UxREzQiliQdqZGbyOwYQl+j9xDB6GzqM5kJEX3cse+pj+TZleCDwlF5DPbRNCfUs6soeNvQfUn9Epb9lvTz6dzDtQoaK3KwcPFiZ05gADVAbn1Ndre5MmfHTUx9njPOhru19dts5g34L6375D0Dp2cPoyP4w7rlXU+QG+yqKkto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S06VcLvf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S06VcLvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7851F00893;
	Thu, 17 Sep 2026 18:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789668150;
	bh=rotodS3cmAPC3hGEOA1tyayaGlDuD2j3cViAEtNkMoc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=S06VcLvftn+SrOOv6kGTBbZ4LebREU8+SlDZ3AvC8/yzwFH8YriD1qbaW5q4LXTSB
	 MJ1yG0ZHj5auyt7tyGfqxF0yuTWmhDfnEbl0ai2b1SHrYkgHb0ZrW+rnEq2Na8CaZC
	 I2xWYAdMKRB10JFYr/ogysarI1uZRDRl0QBBaSDa8maG6e8em/NA+DnV69v1/Da4BN
	 zfhLPSX0PQyWiLUrO0jtO+HDkL6SLgqxgRilF6Kh/qDtJLu+SwG605PspYaIa4wFHM
	 yJKMxIHhPypv8BKzjGooVQP2tSAOXsHPT0wPTW/wAKIc6fUoJNfm+1rjLKXjpNi/TX
	 3bC6rI19iuthA==
Message-ID: <55c9bb7f-33f0-4fb0-8fac-69d5660ac1bc@kernel.org>
Date: Thu, 17 Sep 2026 13:02:27 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86/amd/pmf: Fix power supply leak in
 amd_pmf_get_battery_prop()
Content-Language: en-US
To: Wentao Liang <vulab@iscas.ac.cn>, Shyam-sundar.S-k@amd.com
Cc: hansg@kernel.org, ilpo.jarvinen@linux.intel.com,
 linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 stable@vger.kernel.org
References: <20260917140140.2154244-1-vulab@iscas.ac.cn>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260917140140.2154244-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/17/26 09:01, Wentao Liang wrote:
> power_supply_get_by_name() takes a reference that is only dropped on
> the error path of power_supply_get_property(). Drop it as soon as the
> property has been read and stop searching, so that a successful lookup
> does not leak the reference.
> 
> Fixes: f4627dfd0e19 ("platform/x86/amd/pmf: Add support to get inputs from other subsystems")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>> ---
>   drivers/platform/x86/amd/pmf/spc.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmf/spc.c b/drivers/platform/x86/amd/pmf/spc.c
> index f48678a23cc7..cd957d7a4e48 100644
> --- a/drivers/platform/x86/amd/pmf/spc.c
> +++ b/drivers/platform/x86/amd/pmf/spc.c
> @@ -249,10 +249,11 @@ static int amd_pmf_get_battery_prop(enum power_supply_property prop)
>   			continue;
>   
>   		ret = power_supply_get_property(psy, prop, &value);
> -		if (ret) {
> -			power_supply_put(psy);
> +		power_supply_put(psy);
> +		if (ret)
>   			return ret;
> -		}
> +
> +		break;
>   	}
>   
>   	return value.intval;

