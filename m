Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F573BB101;
	Tue, 28 Jul 2026 06:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785220291; cv=none; b=iGSncPXAVc/0vyQs0LHqpv+a/sNiWgFCoI5wlTSyHq0mdb820ifGRGx4jW1pf+6xfvddw5Mpm3LnZzgyX0/8Owd5U0S9rS+n6HHvwkISUu/PTHOCKcXTz1P4NSHzvOmJOeReuGcoiBl/7ptCbvcCAmOqawK/PT9h1XtYj0pFnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785220291; c=relaxed/simple;
	bh=wa49OgL2Wl1GlFD+NUHQsnNkxqpnb/fpwbaSDddR5eQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BHm0UyhJ2zN9uaWc6Ywk9tR5OO/fuOzqDAPfnxxFVK9ckOBxxQbyp2iCE1QgrpOulIvfAEzP+9lBJCcjpYvxgRt+OEBx1zJMuwT8yezv3oAKouyELRdWmuwYFmBG3k2+s+U5QLl38hPouUTFpq95CivnmUeSA4sm4I+TK0cFIjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4h8QNR2dGcz1cyVg;
	Tue, 28 Jul 2026 14:21:59 +0800 (CST)
Received: from kwepemf200017.china.huawei.com (unknown [7.202.181.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 40D264048B;
	Tue, 28 Jul 2026 14:31:24 +0800 (CST)
Received: from [10.67.121.58] (10.67.121.58) by kwepemf200017.china.huawei.com
 (7.202.181.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 28 Jul
 2026 14:31:23 +0800
Message-ID: <511c7f13-3344-44bf-a960-044fc2401789@hisilicon.com>
Date: Tue, 28 Jul 2026 14:31:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / devfreq: userspace: Fix memory leak in
 userspace_init()
To: Malaya Kumar Rout <malayarout91@gmail.com>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
	<linux-pm@vger.kernel.org>
CC: <mrout@redhat.com>, <skhan@linuxfoundation.org>, <me@brighamcampbell.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park
	<kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kant Fan
	<kant@allwinnertech.com>
References: <20260704163238.115819-1-malayarout91@gmail.com>
Content-Language: en-US
From: Jie Zhan <zhanjie9@hisilicon.com>
In-Reply-To: <20260704163238.115819-1-malayarout91@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200017.china.huawei.com (7.202.181.10)



On 7/5/2026 12:32 AM, Malaya Kumar Rout wrote:
> Fix a memory leak in the userspace_init() function where allocated
> memory is not freed when sysfs_create_group() fails.
> 
> When sysfs_create_group() fails, the function returns without freeing
> the memory allocated for 'data', leading to a memory leak. This patch
> adds proper error handling to free the allocated memory and reset
> governor_data to NULL on failure.
> 
> Fixes: 5fdded844892 ("PM/devfreq: governor: Add a private governor_data for governor")
> Signed-off-by: Malaya Kumar Rout <malayarout91@gmail.com>
> ---
>  drivers/devfreq/governor_userspace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
> index 3906ebedbae8..b9fbcacdfba1 100644
> --- a/drivers/devfreq/governor_userspace.c
> +++ b/drivers/devfreq/governor_userspace.c
> @@ -97,6 +97,12 @@ static int userspace_init(struct devfreq *devfreq)
>  	devfreq->governor_data = data;
>  
>  	err = sysfs_create_group(&devfreq->dev.kobj, &dev_attr_group);
> +
Redundant blank line. Otherwise,
Reviewed-by: Jie Zhan <zhanjie9@hisilicon.com> 

BTW, this function can be slightly cleaned up, e.g. the 'goto' statement
can be removed.
> +	if (err) {
> +		kfree(data);
> +		devfreq->governor_data = NULL;
> +	}
> +
>  out:
>  	return err;
>  }
