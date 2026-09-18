Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7C4372EF3;
	Fri, 18 Sep 2026 06:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713224; cv=none; b=f8cC0j3NdKs91NSIoMcCjcNXNlkbpqr7cEWa34vGXhWFRb9acDfzRunX+17mcXOqjgJmCQOaWk6NYoBtBk/DbipZQh8x5rB3cLhw7/jGvHT73wea8RiZMaOZcvPW9acI4pwuCAfl4SubOTGoqlDyMqEmTL3DOkpVuVqRZYKAo38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713224; c=relaxed/simple;
	bh=c6lHG2+BOGP1n5lfEZzpEidb3oiza5tftAB3gGU5xys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NWw+qAk5hKgxUy8c7cLI2C4vN4hb/55/rkoqDZSNq1Y8BC++ZGjNrbL0QvIdwpaH3dSfx95FamAUqUPjKsFAnch6B7S/wN/QBOtZ1eRcVgJAsm+RDMaH4uws3tN7RiT+4WF+7uBppdojk5UZREYCtmCo4xbAlX8pp+E/XnOiR8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V5y2GaKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V5y2GaKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11BC1F000FF;
	Fri, 18 Sep 2026 06:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713222;
	bh=UEMp/ok56d/H1fXbEjoAxkfOqK2lewL3gNlPrwEc3g0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=V5y2GaKwmTJFmYeJOk6m1rb0E41zqgktErPPOApKE4mgnqiJMN3uyzUVQKFQdUFBe
	 4deYF1YDBX9ZzPHkiLzhtKm0+YhYbOnxKqOIveK7SU4hE0fbXtrV9zBlsDSyk+xVhb
	 RAAZdGjXXTF8YDoGEIYRxiklqcPmTtg5HijajdZaRQ63llfc2ogOOxhJRyF3YHGMDX
	 OkhuWTYaJidEpmendWZbOekruBnx5WV8lQwFnirETRCu7BvZx3RI+2LuvRJQf8n9Nc
	 KbDF/o/fkJKzpD9+IEZXBHhmufrUcIBIaluOtOcyZFLuSDYXzWLN7IzgJCqA+0+N7Z
	 aj/mEjc1DOncw==
Message-ID: <7faa1a14-92f4-4a96-b7c3-da7c385724d7@kernel.org>
Date: Fri, 18 Sep 2026 07:33:40 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] slimbus: messaging: Fix runtime PM leak in
 slim_do_transfer()
To: Wentao Liang <vulab@iscas.ac.cn>, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 srini@kernel.org, stable@vger.kernel.org
References: <20260917152234.2158902-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260917152234.2158902-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/17/26 4:22 PM, Wentao Liang wrote:
> slim_do_transfer() takes a runtime PM reference with
> pm_runtime_get_sync() before allocating a transaction id.  The
> slim_alloc_txn_tid() failure path returns directly, skipping the
> slim_xfer_err cleanup that drops this reference.
> 
> Jump to slim_xfer_err so the reference is always released.
> 
Same question as your other patch,

BTW, please check the list before sending duplicate patch, there is
already an identical patch on the list.

--srini
> Fixes: d3062a210930 ("slimbus: messaging: add slim_alloc/free_txn_tid()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/slimbus/messaging.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/messaging.c b/drivers/slimbus/messaging.c
> index e2dbe4a66b70..ee127ef42046 100644
> --- a/drivers/slimbus/messaging.c
> +++ b/drivers/slimbus/messaging.c
> @@ -139,7 +139,7 @@ int slim_do_transfer(struct slim_controller *ctrl, struct slim_msg_txn *txn)
>  	if (need_tid) {
>  		ret = slim_alloc_txn_tid(ctrl, txn);
>  		if (ret)
> -			return ret;
> +			goto slim_xfer_err;
>  
>  		if (!txn->msg->comp)
>  			txn->comp = &done;

