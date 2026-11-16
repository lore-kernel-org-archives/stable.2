Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.236.53.106
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793634;
	b=prnK8f9eXAO6Oa5HQ+dQH9BqT8yhu4jQXPkMNvbshvJYptiNiBTD15NppPyjYTR2lgtn
	 D95/hvDr4c6TiyiPUGu3l+5Gp07nF7tGochjU0d7Vae0WCm1FmqjSF8WG0u2sgcNFoJb9
	 F324l9FVx5dzcBYFXHFaaJA4/mUwtRzxEc5AumLsEZVHDZ/VPR3rZXeFeQBeLBoEWzglN
	 C2Y9TTgYdTqVaiXNRbHe08YNA/W1HP7GmuEXk3vYOQvDTtEhwxLFKROISbXoXYS6Z/z7l
	 PSXoFfMhdUy+A6AyATFEsC5CfH1u9tkOzIC4l8HSB2j37t05MTiuxKI0aB+IT+nT1iA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793634;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:X-HM-Spam-Status:
	 DKIM-Signature;
	bh=QL5XckioorVY3HmQuyB7sCoeqaOvjjXM1fRm/QS1zoc=;
	b=fGBg9sue5shgZ3zIW3Eu5wm+kR3MCT17eRyQDc6+zgL9jy6TJ7SkIOq0s4KwO1kwC4A8
	 pgbtrY8SZhAlmO+zIRgHNp/ibgDzCmyDIL4DLGHtBmeypz2UEkcQA770p1ivNoI8dvhDF
	 ZlouRbAqYfB5QAOCOwqqrtzxokuj/X3wFlbU0jNXq/DhWOohdmE9N6vbPFl5TyOP+Whek
	 N1xA9kWdMCg22Vn5jUkidPjjSZPVWqlniEcUIj2dSmGPLdkeTzaFkPT+sVW8I8HG2aV5X
	 4UMEt9WCuhoIpRbsa/D/sW4tF91dpvzpp4811IlNY9j8+h/OKka/NEQp1fD0KnuWS4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rock-chips.com;
	spf=pass smtp.mailfrom=rock-chips.com;
	dkim=pass header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Xlx9MASN;
	arc=none smtp.remote-ip=160.236.53.106
Received: from mail-m16023653106.xmail.ntesmail.com (mail-m16023653106.xmail.ntesmail.com [160.236.53.106])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EC2606A31F;
	Mon, 16 Nov 2026 01:47:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EC2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.a=rsa-sha256 header.s=default header.b=Xlx9MASN
Received: from [172.16.12.11] (gyproxy-mailtls4-entmail-gy2-virt39.gy.ntes [61.154.14.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 54c20f935;
	Mon, 16 Nov 2026 09:46:55 +0800 (GMT+08:00)
Message-ID: <13ee0fa0-fcbf-455e-9aac-ea3dcf03b270@rock-chips.com>
Date: Mon, 16 Nov 2026 09:46:53 +0800
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
Subject: Re: [PATCH v2] PM / devfreq: governor_userspace: Guard against NULL
 governor_data during switch
To: Choi Chanwoo <cwchoi00@gmail.com>, heiko@sntech.de,
 linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kant@allwinnertech.com,
 kyungmin.park@samsung.com, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, tony.xie@rock-chips.com,
 huangtao@rock-chips.com, stable@vger.kernel.org
References: <20261022022109.642339-1-finley.xiao@rock-chips.com>
 <94a65d65-e81f-4942-b119-51b71e8eabb4@gmail.com>
From: Finley Xiao <finley.xiao@rock-chips.com>
In-Reply-To: <94a65d65-e81f-4942-b119-51b71e8eabb4@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1e2092ded03a8kunm3009e2001cb66a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCHhkfVkJPT0lDHU0fTE9MQ1YVFA
	kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUJCSU
	5LVUpLS1VKQktCWQY+
DKIM-Signature: a=rsa-sha256;
	b=Xlx9MASNidfN/0/OmnFeLgsodsmzadR89tKU3zq++QnM8UqlhcBAE9GPtPhdMUj8as2WjEADMkE/eG3Rli8TzVi7BgvVr9cUHtnLqTgGasY8903Sk5ClXTWQxdj6y6ojSI0uCWupVaDfuFNU/3WGZBJQghHQMmWVOc63uL7iGhQ=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=QL5XckioorVY3HmQuyB7sCoeqaOvjjXM1fRm/QS1zoc=;
	h=date:mime-version:subject:message-id:from;

Hi Chanwoo,

Thanks for the review. You're right — I've also taken devfreq->lock
around the governor_data assignment in userspace_init() in v3.

Will send v3 shortly.


在 2026/11/14 22:16, Choi Chanwoo 写道:
>
> On 10/22/2026 11:21 AM, Finley Xiao wrote:
>> The userspace governor is the only one that uses devfreq->governor_data,
>> allocated in its DEVFREQ_GOV_START handler (userspace_init()) and freed
>> in its DEVFREQ_GOV_STOP handler (userspace_exit()).
>>
>> When switching governors via sysfs (governor_store in devfreq.c), the
>> sequence is:
>>
>> STOP(old) -> df->governor = userspace -> START(userspace) -> userspace_init
>>
>> Between the df->governor assignment and userspace_init() completing,
>> governor_data is still NULL (the previous governor never touched it,
>> and the core does not clear or pre-allocate it). During that window,
>> asynchronous paths that call update_devfreq() outside of the driver's
>> control -- the OPP notifier (devfreq.c:686) and the pm_qos notifier
>> (devfreq.c:707) -- run devfreq_update_target() under df->lock and reach
>> devfreq_userspace_func(), which dereferences governor_data without a
>> NULL check, causing:
>>
>>    Unable to handle kernel access to user memory outside uaccess routines
>>    pc : devfreq_userspace_func+0xc/0x28
>>    lr : devfreq_update_target+0x58/0x158
>>
>> Add a NULL check in devfreq_userspace_func() and fall back to
>> previous_freq, which is the same behaviour as the existing "no user
>> frequency specified yet" branch. This closes the race for all callers
>> since every path ultimately goes through get_target_freq.
>>
>> Additionally, take devfreq->lock around the kfree()/NULL assignment in
>> userspace_exit(). Without it, a concurrent OPP/pm_qos notifier running
>> under devfreq->lock could read governor_data after it is freed but
>> before it is set to NULL, constituting a use-after-free.
>>
>> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
>>
>> Link: https://lore.kernel.org/linux-pm/20260723080806.1451-1-finley.xiao@rock-chips.com/
>> ---
>> Changes in v2:
>> - Add Fixes: tag and Cc: stable@vger.kernel.org
>>
>>   drivers/devfreq/governor_userspace.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
>> index 3906ebedbae8..f7a485c43fd7 100644
>> --- a/drivers/devfreq/governor_userspace.c
>> +++ b/drivers/devfreq/governor_userspace.c
>> @@ -24,7 +24,7 @@ static int devfreq_userspace_func(struct devfreq *df, unsigned long *freq)
>>   {
>>   	struct userspace_data *data = df->governor_data;
>>   
>> -	if (data->valid)
>> +	if (data && data->valid)
>>   		*freq = data->user_frequency;
>>   	else
>>   		*freq = df->previous_freq; /* No user freq specified yet */
>> @@ -110,8 +110,10 @@ static void userspace_exit(struct devfreq *devfreq)
>>   	if (devfreq->dev.kobj.sd)
>>   		sysfs_remove_group(&devfreq->dev.kobj, &dev_attr_group);
>>   
>> +	mutex_lock(&devfreq->lock);
>>   	kfree(devfreq->governor_data);
>>   	devfreq->governor_data = NULL;
>> +	mutex_unlock(&devfreq->lock);
>>   }
>>   
>>   static int devfreq_userspace_handler(struct devfreq *devfreq,
> Hi,
>
> Looks good to me.
>
> I think that it is needed to lock  on usrespace_init.
>
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index f7a485c43fd7..cfbd72892598 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -94,7 +94,9 @@ static int userspace_init(struct devfreq *devfreq)
>   		goto out;
>   	}
>   	data->valid = false;
> +	mutex_lock(&devfreq->lock);
>   	devfreq->governor_data = data;
> +	mutex_unlock(&devfreq->lock);
>   
>   	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
>   out:

-- 
Best regards,

底层平台中心 肖锋（Finley Xiao）
************************************************************************************
瑞芯微电子股份有限公司
Rockchip Electronics Co., Ltd.
福建省福州市铜盘路软件大道89号软件园A区21号楼 350003
No.21 Building, A District, Fuzhou Software Park, Fuzhou, Fujian 350003, P.R. China
Tel: 0591-83991906-8602 Mobile: 18506057603
************************************************************************************

