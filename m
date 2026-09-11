Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF2344F557;
	Fri, 11 Sep 2026 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789113195; cv=none; b=cbVPtighlJbMINvpTc0IziMCLziXi0z1xFtI/sJRFfTGdUXaDZ/+jX8Kk3aUaS4OJ0H9+mzCSDdH/ogeUVZSF6Tzv34zEsO7babVE0sOmijccN4LLf067ZCDx7385Ks0w8Q35n6u5gA62hNbuQVVxk6K0bwI9mZDnfRoY58gquM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789113195; c=relaxed/simple;
	bh=H8gYMLu0FqMEJcrlEhdP39qH8kOcKnX1t0x4BibwQ7k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GtHH/hZhM0s6zaHDyQED6JaMw1eowZsmURnRhTHn568jbf4RaFjnW+bM3MkGkKfRaYnDw5G8KdJP4n7m9Y73U7Z8dCLa6LHasSgoyQq/LrPh4TBgQ2BcMmQwmGveEyI3MXjV1Y59Zcg9liM7tNtJCOBggtxcCqUEOuKUtQmQ810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H1lbzs/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H1lbzs/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86E81F000FF;
	Fri, 11 Sep 2026 07:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789113194;
	bh=qE7A6c5AEh1AccdUOH2gjIcuQyQq7rJniYEbe20MdvQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=H1lbzs/tsBiChifp1/4qkQY3KObhMuOUVK4f9pA1rS8JyM0/Bq/lTmW5oSQM3bMEI
	 M581dA/2sL6WtzZnGImw9yA9EDW8IasNkqmgcbdIYOLRBktx6DjsKMwp1Yjh46tCG6
	 xPXZLp661SR6K79EtyDUP0GcL2zZmSqyvPkD2QUWfKKmW9OdmLXM15LzXitTzJYUEa
	 XyO/Rih1bcMWuMM6GkdCNkli5u+suoXSOAZ3E7/GUPs0HojdMTowJ1BkdwmsWYoee8
	 pq5dh/56XC6XzQRhke6n5G14uh9mcJ/a4abVloQLCbIjXINk/S07ZOQgsMu/QowkHr
	 qbMJmqI74a2IQ==
Message-ID: <10c85f87-85db-4ee9-ab80-edbd30f3c95e@kernel.org>
Date: Fri, 11 Sep 2026 09:53:10 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH v4 01/19] media: rc: Ensure registered is cleared in error
 path
To: Sean Young <sean@mess.org>, linux-media@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Rik van Riel <riel@surriel.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1788882189.git.sean@mess.org>
 <abfff8cffac8899a26cb258150b5c17b7a2009bc.1788882189.git.sean@mess.org>
Content-Language: en-US, nl
In-Reply-To: <abfff8cffac8899a26cb258150b5c17b7a2009bc.1788882189.git.sean@mess.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/09/2026 17:51, Sean Young wrote:
> If rc_register_device() fails, ensure that registered is not set to true.
> If lirc_register() succeeded, then userspace could have an open file
> descriptor open. This leads to a use-after-free.
> 
> Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
> Signed-off-by: Sean Young <sean@mess.org>
> Cc: stable@vger.kernel.org
> ---
>  drivers/media/rc/rc-main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
> index d93e98189c1a..1f99540456f1 100644
> --- a/drivers/media/rc/rc-main.c
> +++ b/drivers/media/rc/rc-main.c
> @@ -1934,7 +1934,8 @@ int rc_register_device(struct rc_dev *dev)
>  			goto out_raw;
>  	}
>  
> -	dev->registered = true;
> +	scoped_guard(mutex, &dev->lock)
> +		dev->registered = true;

Is the guard actually needed?

>  
>  	rc = device_add(&dev->dev);
>  	if (rc)
> @@ -1982,6 +1983,8 @@ int rc_register_device(struct rc_dev *dev)
>  out_dev:
>  	device_del(&dev->dev);
>  out_rx_free:
> +	scoped_guard(mutex, &dev->lock)
> +		dev->registered = false;

Same question here. I think the real fix is setting dev->registered to
false, but I'm not sure the guard makes a difference.

The commit log mentions nothing about that change either.

Regards,

	Hans

>  	ir_free_table(&dev->rc_map);
>  out_raw:
>  	ida_free(&rc_ida, minor);

