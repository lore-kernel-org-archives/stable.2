Received: from mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF9B4446FA
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788514555; cv=none; b=BqdjZ7d9BZg7wIkaJN/mBzX8H++LZca6tr26GCqIi1rU2udab95R4imm485PoWteqYegfAzgnNFip6UWY6IcJaVcE+nCuCFFUPirslAUML99pZzwieHdbeORZDrs/FDmc3KGK24yiTzEB8Q3q6/eWZ97wYpzRDhyQgzMiCQ1IK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788514555; c=relaxed/simple;
	bh=LfO1/eqlAVD+ofSYiszO71g9ocWquBTr4eOFRXWuc8k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J8W7X4O7eDjvUOD38p8QdRC71ca3YqHTgEKqnuVQS537WRpRsQJrqyh+sZNXjnCa8nEku1/4Gi0PjqQlHjIL5IiCh0RsUzB0fR2yIMSOpsWG8huiVMndPacyW2S5qXLeIhyX46yj96xDBhBMz4OrpmolNti/lrYRabZh3sJcOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=itRzco7R; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="itRzco7R"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=LfO1/eqlAVD+ofSYiszO71g9ocWquBTr4eOFRXWuc8k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788514551; v=1; x=1789119351;
 b=itRzco7RSv9Xt2qT3tmxTPrdd3vf0Blz8VWe7xJOGpENuh6AXYH+8AtOQxg25nRVw6mclh4+
 1lF2cSZ9hGxSoz1kCNvnWlDA5tTzFr7GcyhVT9ERrWxi8ewbcKoH72755uP+W2Gc2ajbkgPFeeK
 IE4kcwLZ3l8GToAiWRX03zfY=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1529718b5a2987b1;
	Fri, 04 Sep 2026 09:35:50 +0000
X-Mizu-Trace-ID: 1529718b5a2987b1
X-Migadu-Flow: FLOW_OUT
Message-ID: <08b5843b-33f0-4c33-8db6-c23da0c9b685@linux.dev>
Date: Fri, 4 Sep 2026 17:35:44 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@linux.dev, Hans de Goede <hansg@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] mmc: core: Fix OF node reference leak on card add failure
To: Zhu Ling <zhuling0805@qq.com>, Ulf Hansson <ulfh@kernel.org>
References: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
From: Shawn Lin <shawn.lin@linux.dev>
In-Reply-To: <tencent_CAA125B50CDEC8BA29F4B982356549608D07@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026/09/04 星期五 17:07, Zhu Ling wrote:
> mmc_of_find_child_device() returns a device node with its reference count
> incremented. mmc_add_card() stores the reference before calling
> device_add(), while the card is marked present only after device_add()
> succeeds.
> 
> If device_add() fails, the callers release the card through
> mmc_remove_card(). However, mmc_remove_card() only drops the OF node
> reference for a present card, leaking the reference on this error path.
> 
> Move of_node_put() outside the present-card conditional so the reference
> is released for both registered cards and card-add failures.
> 
> Fixes: 25185f3f31c9 ("mmc: Add SDIO function devicetree subnode parsing")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhu Ling <zhuling0805@qq.com>
> ---

Reviewed-by: Shawn Lin <shawn.lin@linux.dev>

>   drivers/mmc/core/bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index be5cf338bdeb..92ad39c0cabc 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -417,8 +417,8 @@ void mmc_remove_card(struct mmc_card *card)
>   				mmc_hostname(card->host), card->rca);
>   		}
>   		device_del(&card->dev);
> -		of_node_put(card->dev.of_node);
>   	}
> +	of_node_put(card->dev.of_node);
>   
>   	if (host->cqe_enabled) {
>   		host->cqe_ops->cqe_disable(host);
> 
> 

