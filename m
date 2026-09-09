Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B33569F04
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788970376; cv=none; b=QRgaii64wOlpZYY3EZlwO/egXs47azKbbXA64t6j+yRBqBuNKG4HT21Va9DBgpLmgmBTqmdIhxuj5AkwYE6zkH1M2dOOCFJawhBrzbrQ9zKF9jPvJuDWExjSLxVYm7ZZs4BaNe/NEViastp3UqRnSw2j8Vu4+N2nEZvSXmUNjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788970376; c=relaxed/simple;
	bh=nj7DwGHIWT5bRdn+m6Ws0p6FvGQIKtGggZEHdb0mxK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOjedXQ7jcmepvUOCgw3t9hYSImKHyhOlQ+swe6t4ynHsb2OOUWTOiOZlVGvyamz55EoZHnOH26sSFjChVhp7ydn5QPGcYAk5erCeSaVXS+QBluAtRRUbRkNiGOJaBLBMHwIZtT0D+dn5o188MAC83LV5QpW9h2ZY05OVOEIgtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XruKM9UT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XruKM9UT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CD41F00A3A;
	Wed,  9 Sep 2026 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788970374;
	bh=kILeFf/0WkqTSczX6cU1SiYvJlymCojxF1qlijnWgEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XruKM9UTbiV+D/rptUMxEfVUiBifjlpHn9DWqA7gMOnEVRpTkK7zPWiU/YjDtu0Vw
	 VAGL/jPbETxfdMqDbmngkFp/7fO54JSDWQr7cYwRuTADPaeobtgCUb7HF4YAa4Mh6i
	 zQdK1ugejX3EFIp9nW/xSPTuZPK6zpSNr0FM0bqVa+6q8TRk0CKHGkRFTK7sz8Jbsp
	 n+YfnRkzqdPqW99d6o2SAOaHnr4VDfUhq3X6dO6GCRAbdSgxnDpOILO2Ka+3XJgpam
	 BA8KNbyK4UbOI3OvPIIv6zp9Vh09ZiJkiMbLOI3fLIMHCX7KsBpQlnUrdTRPNmn3xH
	 NWhefhWMPqhyg==
Date: Wed, 9 Sep 2026 18:12:51 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: lgs201920130244@gmail.com
Cc: loic.poulain@oss.qualcomm.com, stable@vger.kernel.org, 
	vladimir.zapolskiy@linaro.org, gregkh@linuxfoundation.org
Subject: Re: FAILED: patch "[PATCH] i2c: qcom-cci: fix autosuspend cleanup"
 failed to apply to 6.12-stable tree
Message-ID: <aqGE1W9jGLjONXZQ@zenone.zhora.eu>
References: <2026090908-irritable-errant-ac6f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026090908-irritable-errant-ac6f@gregkh>

Hi Gwangshuo,

On Wed, Sep 09, 2026 at 11:41:08AM +0200, gregkh@linuxfoundation.org wrote:
> 
> The patch below does not apply to the 6.12-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
> 
> To reproduce the conflict and resubmit, you may use the following commands:
> 
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
> git checkout FETCH_HEAD
> git cherry-pick -x f98d4986482151a835b521a734722fe8dc5ca37d
> # <resolve conflicts, build, test, etc.>
> git commit -s
> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090908-irritable-errant-ac6f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

can you please help backporting this patch to the stable branches
where it's not applying?

Thanks,
Andi

> 
> Possible dependencies:
> 
> 
> 
> thanks,
> 
> greg k-h
> 
> ------------------ original commit in Linus's tree ------------------
> 
> From f98d4986482151a835b521a734722fe8dc5ca37d Mon Sep 17 00:00:00 2001
> From: Guangshuo Li <lgs201920130244@gmail.com>
> Date: Wed, 12 Aug 2026 17:44:25 +0800
> Subject: [PATCH] i2c: qcom-cci: fix autosuspend cleanup
> 
> cci_probe() calls pm_runtime_use_autosuspend(), but the remove path
> does not call the matching pm_runtime_dont_use_autosuspend() before
> disabling runtime PM.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without undoing the autosuspend setting during
> teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> Use devm_pm_runtime_set_active_enabled() to manage the runtime PM
> state. Its managed cleanup disables autosuspend and runtime PM and
> restores the suspended state on probe failure and driver removal.
> Remove the now redundant manual runtime PM cleanup.
> 
> This issue was found by manual code inspection.
> 
> Fixes: e517526195de ("i2c: Add Qualcomm CCI I2C driver")
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> Cc: <stable@vger.kernel.org> # v5.8+
> Reviewed-by: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
> Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
> Link: https://patch.msgid.link/20260812094425.3515179-1-lgs201920130244@gmail.com
> 
> diff --git a/drivers/i2c/busses/i2c-qcom-cci.c b/drivers/i2c/busses/i2c-qcom-cci.c
> index bdeda3979c48..25b6e4e9e3fa 100644
> --- a/drivers/i2c/busses/i2c-qcom-cci.c
> +++ b/drivers/i2c/busses/i2c-qcom-cci.c
> @@ -595,9 +595,11 @@ static int cci_probe(struct platform_device *pdev)
>  		goto disable_clocks;
>  
>  	pm_runtime_set_autosuspend_delay(dev, MSEC_PER_SEC);
> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		goto disable_clocks;
> +
>  	pm_runtime_use_autosuspend(dev);
> -	pm_runtime_set_active(dev);
> -	pm_runtime_enable(dev);
>  
>  	for (i = 0; i < cci->data->num_masters; i++) {
>  		if (!cci->master[i].cci)
> @@ -613,8 +615,6 @@ static int cci_probe(struct platform_device *pdev)
>  	return 0;
>  
>  error_i2c:
> -	pm_runtime_disable(dev);
> -	pm_runtime_dont_use_autosuspend(dev);
>  
>  	for (--i ; i >= 0; i--) {
>  		if (cci->master[i].cci) {
> @@ -640,9 +640,6 @@ static void cci_remove(struct platform_device *pdev)
>  			cci_halt(cci, i);
>  		}
>  	}
> -
> -	pm_runtime_disable(&pdev->dev);
> -	pm_runtime_set_suspended(&pdev->dev);
>  }
>  
>  static const struct cci_data cci_v1_data = {
> 
