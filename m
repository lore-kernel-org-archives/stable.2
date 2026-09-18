Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6519A5C613;
	Fri, 18 Sep 2026 06:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713150; cv=none; b=i/rIa9dZUR5eWTFXCPaQfiSExD7GceHENenx4Yx8b9lvTYa/pyc/vEhcHQdB8DlcnW4wdS+1yTKgHcSUBSSlB9gZr73Xo9Y23mrQXOJUGEhusF2BUAsRzFtKkwFOudcW71oQNe3Dz+Pr1tKEeF2K40tWl/H7ZoIATj+Soarn2hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713150; c=relaxed/simple;
	bh=XwrqToWW6ds8H6Yd5khVB2HcPjOhh+PHQ2Jqml1GP70=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJYY3j3aYkWcAKvFQNmQw3nEn0LSHOUgrbW+RUHs0a4nJJWON6/rtbd6WiPbx/Ui6goKZqf6CUBA0G8FszdcfoT5UXJQsDAbT4pBHxo7wHqmNC1VRA3YaYrkK8UhnittV1iHYxqOQr7BqAHD2yLmANree/qDxbzchUOc9lTMjVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoO9iyAy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoO9iyAy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909751F000FF;
	Fri, 18 Sep 2026 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713149;
	bh=0jginng20HyEPfWE13UVglgNNNor7mab+3rUOQNhgOQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eoO9iyAyKw4vPHgIfe582rvqtGVDyIGS6odDyEgr9ghn4gjNpF6DNxWwZlXpOuXZw
	 YxAjG5qb3AJC27S+Y3dACN0DW+DvWjENeOB101YrMaruqm84aYSYoycQ4BzZq0nd/G
	 Vbrr/Kygzk1tGet8AA2CbVikMoC3oJrRgON1lS7h6m7O3M3y/EAzphNY1wRZi0ER+p
	 pELftNaX3BWN1cUrNcYq+jW6AyB5Sy/AvzmAIxYgE/6ezvKcOkayGTGlsCeCP9qqlf
	 IKyVaf07svATccedfPCootfANNHq8OttyrPDEQp4mJOoAZ/LdczTA9KDRNlwXJRRKI
	 EiBV45DQT0eNw==
Message-ID: <5ce059cc-b408-49cd-96f8-85943ec9e51d@kernel.org>
Date: Fri, 18 Sep 2026 07:32:26 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: ngd: Fix runtime PM leak in
 qcom_slim_ngd_xfer_msg_sync()
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-sound@vger.kernel.org, srini@kernel.org, vkoul@kernel.org,
 stable@vger.kernel.org
References: <20260917152525.2160238-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917152525.2160238-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 4:25 PM, Wentao Liang wrote:
> The successful transfer path returns 0 without dropping the runtime PM
> usage counter taken by pm_runtime_get_sync().  The error paths all jump
> to pm_put, which releases the reference, but a completed transfer keeps
> it forever.
> 
What is the exact issue that you are seeing on your device?

Is this AI generated code?

Was this patch tested on the device?

--srini

> Fall through to pm_put on success so the reference is always released.
> 
> Fixes: 917809e2280bb ("slimbus: ngd: Add qcom SLIMBus NGD driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/slimbus/qcom-ngd-ctrl.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index 1ed6be6e85d2..be5640f45d7c 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -937,7 +937,6 @@ static int qcom_slim_ngd_xfer_msg_sync(struct slim_controller *ctrl,
>  		ret = -ETIMEDOUT;
>  		goto pm_put;
>  	}
> -	return 0;
>  
>  pm_put:
>  	pm_runtime_put(ctrl->dev);

