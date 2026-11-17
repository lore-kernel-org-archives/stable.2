Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794934427;
	b=icMvcMqJlnYvM0Fyb5JLmuSTakYpvurAVKLZ7jxFWyv3EsRaJgvTS0ThU8QiwjvVD22x
	 5AKGBzNHJZ9EC7pUH8KJZRhMQRWgUX9H2S2LdoAEesyXqZeK2C18Wr1PagtdiNcVhCQ0c
	 akTJVF1YJ6xV8LhXHuaESb8gV5dHUd+rg51C63Fc+fB+kLKolhctN2noxJ+PNwsYvrzzh
	 koly5vk8DiXqR21usa+Fd8IM9mFJMfEkqobnZtl9MLvecarNGqjNcCMSDEhz4w5NkECNH
	 bY61Vxc7eLGt7MxIHS4foyQdfySUFHzJy71dHK3klhIRrgt6mHT2WaufOFdl9J9iIcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794934427;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=BmgiMzGT7OfAJWTl0Rrrk3sC7aMU8c/Efc/wVlwAwJw=;
	b=WA4KnZ9361T0EflgRvtwdmQZqmijcEDp0cn5XtUHC095AdNN6R0ZM8BmEC47/k/3CrdX
	 ZN43i0NlNbCWyVGYOz5DQw3/IcyOIFlaQcLBCw6ZWx4VzD9z3HSnhaOfKK6gEZy+a8iLL
	 BZxJFbR2qB64T1zisKxyR2kvD46Uj3M6YqQm4XuH4GRgWGPUbefI05k+989R7odXu/rca
	 gxTB8q85tiCz6jzBMvaEY9TgcCjWY2q0c+Y5wSLcSEJYFIrM2pYCWr9p0MtAGK2AZh1OA
	 YFuL3QE9a2ZAiB3Aq4J4l5BCwpz34Y5JKh9APm7l2lE0u8t2ez1Z0hKKcClm+UtuEQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q+dVPWqA;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07794606A31C;
	Tue, 17 Nov 2026 16:53:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07794606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=q+dVPWqA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 468D11BD0;
	Tue, 17 Nov 2026 08:53:43 -0800 (PST)
Received: from [192.168.178.24] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DEE03F632;
	Tue, 17 Nov 2026 08:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794934426; bh=dY0PlREzeD3CrKGc5kC+MkEZZnll4L2/lUyrz1nZh2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=q+dVPWqAaS0kMOEhMc2VQlNIvhkDLvslCwBmEUdwcLXcx+QijE8Ch9ipS5RVJRrRU
	 2IU8zJiKB2iqK+SCSVJvLy90A5rZzpc/0+c1MZD8cudYSOEjGki7aZLSDNTUjE2SvC
	 mIiupqDyyMFJdNqVwyEltuw5iI5ivDl77fHlcJzQ=
Message-ID: <7932f2f8-07cb-4b35-94d4-f23de460dded@arm.com>
Date: Tue, 17 Nov 2026 17:53:47 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "arm_mpam: propagate MSC access errors for state saving
 function" has been added to the 7.3-stable tree
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Fenghua Yu <fenghuay@nvidia.com>
References: <20261117143202.1638547-1-sashal@kernel.org>
Content-Language: en-GB
From: Andre Przywara <andre.przywara@arm.com>
In-Reply-To: <20261117143202.1638547-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 11/17/26 15:32, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>      arm_mpam: propagate MSC access errors for state saving function

Same thing as for the base error propagation backport notice: this is 
not needed, if it's just required for backporting 197a7a41e6e0.

Cheers,
Andre

> 
> to the 7.3-stable tree which can be found at:
>      http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>       arm_mpam-propagate-msc-access-errors-for-state-savin.patch
> and it can be found in the queue-7.3 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
> 
> 
> 
> commit aa9c4741947f1d2968ac6b9f0bab050d413a2326
> Author: Andre Przywara <andre.przywara@arm.com>
> Date:   Fri Oct 2 17:04:41 2026 +0100
> 
>      arm_mpam: propagate MSC access errors for state saving function
>      
>      [ Upstream commit a3a94c13c44216a92e75d6e50331897d49c67e9b ]
>      
>      Allow the mpam_save_mbwu_state() function to return an error, and
>      propagate read and write errors from the lower level up.
>      
>      Signed-off-by: Andre Przywara <andre.przywara@arm.com>
>      Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>      Reviewed-by: Ben Horgan <ben.horgan@arm.com>
>      Reviewed-by: Gavin Shan <gshan@redhat.com>
>      Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
>      [morse: Fixed merge conflicts in mpam_save_mbwu_state() and __ris_msmon_read()]
>      Signed-off-by: James Morse <james.morse@arm.com>
>      Stable-dep-of: 197a7a41e6e0 ("arm_mpam: On saving mbwu state read the monitors before clearing CFG_MBWU_CTL")
>      Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
> index b20152c3c67ee..720198fb8b0c1 100644
> --- a/drivers/resctrl/mpam_devices.c
> +++ b/drivers/resctrl/mpam_devices.c
> @@ -1752,6 +1752,7 @@ static int mpam_restore_mbwu_state(void *_ris)
>   static int mpam_save_mbwu_state(void *arg)
>   {
>   	int i;
> +	int ret;
>   	u64 val;
>   	struct mon_cfg *cfg;
>   	struct mon_read mbwu_arg;
> @@ -1770,10 +1771,18 @@ static int mpam_save_mbwu_state(void *arg)
>   
>   		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
>   			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
> -		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> -		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> -		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
> +		if (ret)
> +			return ret;
> +		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
> +		if (ret)
> +			return ret;
> +		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
> +		if (ret)
> +			return ret;
>   
>   		cfg->mon = i;
>   		cfg->pmg = FIELD_GET(MSMON_CFG_x_FLT_PMG, cur_flt);

