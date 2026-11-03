Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706020;
	b=ya9xY33d9NIPbx3OtDOAewChG9BC5ahBJED0f+/VPbtAoZgpOQJyubEnihurtGWt6MsS
	 Vgrbn5LcuNq3UfXLErmwL1nXN7NKTxiIxU6/rH0InIuxUD3FXHirs9Or86p/hIIvXf4mp
	 v43dgzPeJJzksTLcA5R12nL0BypU2f/8v8WT29dJilvLTWKl2zrT5pnua7bxaCX05GyhY
	 kPP+tiBGHbe4Su3zfCAKB5CNK8upwf2q4cgLxVVah8bsy3H394JIB6tkFUpif/eVBcMl/
	 5XJpIGqLQduk+uXWIAOAYIiSXL4Y9cs1LsKKved/NxNqYK08WpZVdnfDViYq8FhqV2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706020;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=tesqzDpZOT8hQ4pu7vbpIQkvzWqWZw964o2URMNByzY=;
	b=ebZU1yQWRz1JCbpXmeldJWnIJNQ6Y41GxtSy/AlbPwT78ywqNEip//MFw/WlA+jmeyNc
	 Xfu6dpN1Dv7EorvboSmLAfg1KPSH10/gzO5hSNX+VUosImRZIBxJldv9TbgLv00moLLQJ
	 Bl3oFEVdjb6UPZxtH9cjErzgZoz5CCNsRrrSaN1iEA8UB61Kr0EO8LGmP+BTqybD4CyvE
	 Tbixz2kjDNNUO+7zM5ddkUy1kfgUspy9XK6VJPopCQbVwFb3ykoRSz//H+KaIJIbJKKOO
	 Ssvb2PEjJrVE5C6BG8mC1d1ZTwuOhWQZ2/fapT7sXczc8KpXXlYr7nwnp5shHQ8jQfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F35TgBCw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5DF606D82C;
	Tue,  3 Nov 2026 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F35TgBCw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2C11F000C1;
	Tue,  3 Nov 2026 11:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706019;
	bh=tesqzDpZOT8hQ4pu7vbpIQkvzWqWZw964o2URMNByzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=F35TgBCwcIZ2ocjoz+iQMrMq4ChhfMxzKE/57f99vO3TDyY13rUkCnYz6YrS0SFEu
	 dKYScWHVneYwi2AqlIDiiG8OtvvQOsE6tsCTycYC78MGlCd5ZK+fLaGH27MeYnvfXj
	 ssow3g8xepxK/eqliobgc32K1SEMLXSr987e7LKZsZhXAvck6Dxy3YsVZTTMxWrN/8
	 rTfUAtOPa+YPFwVPnIN7atZpu3UGC5ZUY9Hcbqn7mHd44CLonEu/mYoGTXgQUntczn
	 svLPTJBg9RyBmeaLH6ktp4LKvid+5sBwAumrQYcGI3mmx4OinDpVRodmouiG8IQ7gn
	 Dlx++AuvoIgbA==
Message-ID: <46e9506d-1eae-48d4-803d-d731d85fd376@kernel.org>
Date: Tue, 3 Nov 2026 11:40:14 +0000
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
Subject: Re: [PATCH 3/3] media: iris: Fix use-after-free on unbind with open
 sessions
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stefan Schmidt <stefan.schmidt@linaro.org>,
 Hans Verkuil <hverkuil@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Hungyu Lin <dennylin0707@gmail.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 stable@vger.kernel.org
References: <20261017-iris-handle-unbind-v1-0-7809148eb90f@oss.qualcomm.com>
 <2rWHCgRwgvQ8e4bhpYnYDjIzh1pjQNSNjdBFELmGe_h6iZzVLuoQDpUPAD64feN0mYHgyoDf3AYwIu-5ilkZdA==@protonmail.internalid>
 <20261017-iris-handle-unbind-v1-3-7809148eb90f@oss.qualcomm.com>
From: Bryan O'Donoghue <bod@kernel.org>
Content-Language: en-GB
Autocrypt: addr=bod@kernel.org; keydata=
 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
In-Reply-To: <20261017-iris-handle-unbind-v1-3-7809148eb90f@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/10/2026 04:16, Vishnu Reddy wrote:
> The driver unbind can be triggered through sysfs while a client has a
> video session running. The devm resources will be freed when the unbind
> completes. That leads to use after free for the running sessions.
> 
> Keep the memory of the core and its device allocated until the last
> file descriptor is closed. Stop new sessions as soon as the removal
> starts. Make sure the interrupt thread cannot run on the core after it
> is freed.

There's too much going on in this patch in one place. The commit log is 
indicative of that too. At a minimum the IRQ stuff should be separated 
because IMO its not really a use-after-free its a race condition that 
already exists, its just more obvious when you free in this fashion.

> 
> Fixes: 38506cb7e8d2 ("media: iris: add platform driver for iris video device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
> ---
>   drivers/media/platform/qcom/iris/iris_probe.c | 56 +++++++++++++++++++--------
>   1 file changed, 40 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
> index 4cb678bd56f0..25876957381b 100644
> --- a/drivers/media/platform/qcom/iris/iris_probe.c
> +++ b/drivers/media/platform/qcom/iris/iris_probe.c
> @@ -243,6 +243,15 @@ static int iris_register_video_device(struct iris_core *core, enum domain_type t
>   	return ret;
>   }
> 
> +static void iris_core_release(struct v4l2_device *v4l2_dev)
> +{
> +	struct iris_core *core = container_of(v4l2_dev, struct iris_core, v4l2_dev);
> +
> +	mutex_destroy(&core->lock);
> +	put_device(core->dev);
> +	kfree(core);
> +}
> +

What you would have here is an admixture of devm allocated stuff and 
hand-allocated, refcounted with custom v4l2_release() which might all 
work but, it's not obvious to me does work i.e. core is hand allocated 
while reg_base, response_packet etc are devm() managed.

A much simpler solution to your problem is :

static struct platform_driver iris_driver = {
	.driver = {
		.suppress_bind_attrs = true,
		...
	},
};

>   static void iris_remove(struct platform_device *pdev)
>   {
>   	struct iris_core *core;
> @@ -251,18 +260,20 @@ static void iris_remove(struct platform_device *pdev)
>   	if (!core)
>   		return;
> 
> +	video_unregister_device(core->vdev_dec);
> +	video_unregister_device(core->vdev_enc);
> +
>   	disable_delayed_work_sync(&core->sys_error_handler);
> 
>   	iris_core_deinit(core);
> 
> -	video_unregister_device(core->vdev_dec);
> -	video_unregister_device(core->vdev_enc);
> +	devm_free_irq(core->dev, core->irq, core);



> 
>   	v4l2_device_unregister(&core->v4l2_dev);
> 
>   	iris_unreserve_iova_region(core->dev, core->iova_state);
> 
> -	mutex_destroy(&core->lock);
> +	v4l2_device_put(&core->v4l2_dev);
>   }
> 
>   static void iris_sys_error_handler(struct work_struct *work)
> @@ -281,53 +292,64 @@ static int iris_probe(struct platform_device *pdev)
>   	u64 dma_mask;
>   	int ret;
> 
> -	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
> +	core = kzalloc_obj(*core);
>   	if (!core)
>   		return -ENOMEM;
> -	core->dev = dev;
> +	core->dev = get_device(dev);
> +
> +	core->v4l2_dev.release = iris_core_release;
> +	kref_init(&core->v4l2_dev.ref);
> 
>   	core->state = IRIS_CORE_DEINIT;
>   	mutex_init(&core->lock);
>   	init_completion(&core->core_init_done);
> 
>   	core->response_packet = devm_kzalloc(core->dev, IFACEQ_CORE_PKT_SIZE, GFP_KERNEL);
> -	if (!core->response_packet)
> -		return -ENOMEM;
> +	if (!core->response_packet) {
> +		ret = -ENOMEM;
> +		goto err_put_core;
> +	}
> 
>   	INIT_LIST_HEAD(&core->instances);
>   	INIT_DELAYED_WORK(&core->sys_error_handler, iris_sys_error_handler);
> 
>   	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(core->reg_base))
> -		return PTR_ERR(core->reg_base);
> +	if (IS_ERR(core->reg_base)) {
> +		ret = PTR_ERR(core->reg_base);
> +		goto err_put_core;
> +	}
> 
>   	core->irq = platform_get_irq(pdev, 0);
> -	if (core->irq < 0)
> -		return core->irq;
> +	if (core->irq < 0) {
> +		ret = core->irq;
> +		goto err_put_core;
> +	}
> 
>   	core->iris_platform_data = of_device_get_match_data(core->dev);
> 
>   	core->ubwc_cfg = qcom_ubwc_config_get_data();
> -	if (IS_ERR(core->ubwc_cfg))
> -		return PTR_ERR(core->ubwc_cfg);
> +	if (IS_ERR(core->ubwc_cfg)) {
> +		ret = PTR_ERR(core->ubwc_cfg);
> +		goto err_put_core;
> +	}
> 
>   	ret = devm_request_threaded_irq(core->dev, core->irq, iris_hfi_isr,
>   					iris_hfi_isr_handler,
>   					IRQF_TRIGGER_HIGH | IRQF_NO_AUTOEN,
>   					"iris", core);
>   	if (ret)
> -		return ret;
> +		goto err_put_core;
> 
>   	iris_init_ops(core);
> 
>   	ret = iris_init_resources(core);
>   	if (ret)
> -		return ret;
> +		goto err_put_core;
> 
>   	ret = iris_reserve_iova_region(dev, &core->iova_state, IRIS_NP_RESERVE_IOVA_START,
>   				       IRIS_NP_RESERVE_IOVA_SIZE);
>   	if (ret)
> -		return ret;
> +		goto err_put_core;
> 
>   	ret = v4l2_device_register(dev, &core->v4l2_dev);
>   	if (ret)
> @@ -368,6 +390,8 @@ static int iris_probe(struct platform_device *pdev)
>   	v4l2_device_unregister(&core->v4l2_dev);
>   err_unresv_iova_region:
>   	iris_unreserve_iova_region(dev, core->iova_state);
> +err_put_core:
> +	v4l2_device_put(&core->v4l2_dev);
> 
>   	return ret;
>   }
> 
> --
> 2.34.1

