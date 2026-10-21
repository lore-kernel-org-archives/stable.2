Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560176;
	b=ltrnKKkv28jaCpGEQ6l7zC/xUVQIbNCoM1Y1swYYTR8LF1EaRZc+cK7eXqmm0uOKUd13
	 X2iJES6wCrPtC6te/WnfEi1NvzlSOdDRa8T/kNRzl4blmfRXhh+Q44Ka43e1pRmAMfqOX
	 CeZ/TzijlH6cs+cx2K+HomrKsOiTTHiTe699iHgLgxl0L92Fm9n787sID4x0B6cFPwRoH
	 8m8MBbgom+aAECr8MjYasC9ibCHn0qhtYortbcKP+j0rpyl9dfm4M79AKhvduM5QjsC7E
	 g3ZrlQYQgMojMatBH8ZsdjzhSxBBu49Visl1SBSq8thbd+aSRNj+LkfJt8n3lK1qgsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560176;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Swfs28hXtM8sdZG1SyRpeTzhFRqeD6kprzmA4qDc3ps=;
	b=dqYzRmKm31Ag+5+O1zC099IFElpsXFD8uHScuQb1bUPd0hWG9uFG7Wqn8Kyok3NJgRXN
	 jNKjFJr+5rnxoryg8jI6XaEw7Fr1eKvpFNHDUwjyetQRGeHZmNTM9mTvHJvT++5NdxgtS
	 LtOuT9a7WSBNtEbh/DNIJp+r5wZ72EwV8Z7ksvo4rYbhjtvruxehIG6Gn7Dfd8rGsH0hw
	 EcUikElttZrD8uycHMvn/yAoQL0jBnDAaEu0dAb/PVOhiH6fkTuKUvJoKepPvbHffbYCQ
	 uO3EoxeLnMv3HqOArrimfq4WmQH3e0DBYx7epMGcLs9a21UEW6E2qf1yKvqYRTKopjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=packett.cool;
	spf=pass smtp.mailfrom=packett.cool;
	dkim=pass header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=RaXdLKKd;
	arc=none smtp.remote-ip=95.215.58.176
Received: from mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF18606A31C
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCF18606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=RaXdLKKd
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=TCPeloyadGAu87uW5ws1DgAebc3Cc2vxp0sBhDg8za0=;
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792560174; v=1; x=1793164974;
 b=RaXdLKKdviumWYiwGHPMbHseCFipUyls44pXG9jgvwNjPZtgZSZkzZ+Zg/K95zd/1lU3pQPZ
 7SlMiZ2+AdaKI8CPgfiLnmWFekeWzqsa9242nEAX0Wpmd5luBK3/HLFQW49AzXTW5PGjklRH+SD
 I5BdvNneDv3Jv+RcoCo5VnfUbod+tVHKKaAfMQGqbkhJPtZMMH0sAFcNsqQIhsEuGcCcc97637L
 BIVMJ8IKp4JD8JPubtiINSpI1qtx5gQg1Kr7NOkxeyPOQuA0C+F5iSgMRvglcBnUvwNRRN6ReYm
 a9PLQ0rURddlF6KK/JF74grExaAk3MOBpilL0Eo13pYLQ==
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id effd227a1c24da30;
	Wed, 21 Oct 2026 05:22:53 +0000
X-Mizu-Trace-ID: effd227a1c24da30
X-Migadu-Flow: FLOW_OUT
Message-ID: <bfc5414e-5616-4a64-becc-d16c2b01ecf4@packett.cool>
Date: Wed, 21 Oct 2026 02:22:48 -0300
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
Subject: Re: [PATCH v2] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
To: Slark Xiao <slark_xiao@163.com>, mani@kernel.org,
 jeff.hugo@oss.qualcomm.com, krishna.chundru@oss.qualcomm.com
Cc: loic.poulain@oss.qualcomm.com, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261021024038.17127-1-slark_xiao@163.com>
Content-Language: en-US
From: Val Packett <val@packett.cool>
In-Reply-To: <20261021024038.17127-1-slark_xiao@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/26 11:40 PM, Slark Xiao wrote:
> For some MHI devices in some specific scenario, the default value
> of autosuspend_delay_ms may not enough to handle last wake event.
Missing verb.. may not *be* enough
> This may lead to some unexpected problems.
Sounds vague, are there any examples of the problems? A short 
description of a concrete error message or something would be nice.
> Refer to the Qualcomm's Windows settings and we checked this with
> Quaclomm over case, Qualcomm recommend us to set this as 5000ms.

spelliiiiing. Quaclomm? :)

(also "over case" sounds odd)

> Qualcomm also suggests us to update this for all MHI devices.
> Since this setting has affected some existed kernel versions, it's
> better to be applied to stable version.
Please leave the "meta" stuff about where the commit applies outside of 
the commit message.
> Fixes: d3800c1dce24 ("bus: mhi: pci_generic: Add support for runtime PM")
> Cc: stable@vger.kernel.org
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: define a autosuspend delay timeout and explain the reason
> ---
>   drivers/bus/mhi/host/pci_generic.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> index 7193a384cca4..1f52542794d7 100644
> --- a/drivers/bus/mhi/host/pci_generic.c
> +++ b/drivers/bus/mhi/host/pci_generic.c
> @@ -21,6 +21,9 @@
>   
>   #define MHI_POST_RESET_DELAY_MS 2000
>   
> +/* Add define of  initial autosuspend_delay_ms to accommodate a potential 'late wake-event' issue */

Not a very necessary comment, but if you do add it, please don't write 
things like "Add define of". This *is* the define, we're looking at it..

Also, it's not "initial" if it's not a tunable or anything, it's just 
*the* delay value.

> +#define MHI_AUTOSUSPEND_DELAY_MS 5000
> +
>   #define HEALTH_CHECK_PERIOD (HZ * 2)
>   
>   /* PCI VID definitions */
> @@ -1483,7 +1486,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   
>   	/* Allow runtime suspend only if both PME from D3Hot and M3 are supported */
>   	if (pci_pme_capable(pdev, PCI_D3hot) && !(info->no_m3)) {
> -		pm_runtime_set_autosuspend_delay(&pdev->dev, 2000);
> +		pm_runtime_set_autosuspend_delay(&pdev->dev, MHI_AUTOSUSPEND_DELAY_MS);
>   		pm_runtime_use_autosuspend(&pdev->dev);
>   		pm_runtime_mark_last_busy(&pdev->dev);
>   		pm_runtime_put_noidle(&pdev->dev);


Thanks,
~val

