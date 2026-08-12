Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BC41684D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786528167; cv=none; b=XEW7ZTrBpGbicBYV3oHhz2gj9h772zdNWsD9dYId+rqfgNVE7846JmxXXzyVNPIymbejAZKd+FTitrzvcogUWdWgi6KG2IMQ+HzhclOZIFiIpI2n4FaoPA6JnbXYUsBXMF5cYslyoGcnkhLfqZiSCWvtZDopcLXgOgnGacfx/xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786528167; c=relaxed/simple;
	bh=7lyXdQdjtI5/WAS+cJSExnEQhF25v7gRqCB3t62wdVM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LBDeGMLKKLhvd4g0UFBK3eVMZFb8sNNGA7BW629tmrR1O4+fHUp1k3pMArbUSRpdFP/GqF1FHWekIURcuPrcdicVfQsMsVK2BVCkJ/6R3ZZkXzNYIt79Sz1WO1H90b4uLTnf9Cv5k33wngqPMwJH/lh/enygDwshflH/lRJ+Js8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=z6+xNepN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6+xNepN"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-481412f1828so215074f8f.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 02:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786528164; x=1787132964; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KNnL3c87mu/DIX31ZmKg4EMDsyOIpMA1GsTwk82rq7I=;
        b=z6+xNepNRYQYHQSCju6GTKpjMd8/AgvGXLhk5rV25EpY23ozDHfB6rG9+3jXhfeoB0
         ZbSV57zvukYogwLdRf/cSGU89QOBBvZ0R4NcXizOjNxcwfsncotXLWRTnuJPP8J5djgQ
         r3YXd5FMzXon3pELUJP6OnVcOdpfjuQlfCSqhFQPQ37WLfyYV/6M9SosE/7fgKhvnh+g
         5tgQ2ByR7536Db0bkTvhNEnCKZo5xwKb3Zieq/iuteyKJFQSpFPQlAU4ucdHNiMrmnuh
         OdNyPPqfOB3zHOQjyaxYfJmqVxJOLFDuSLB69ysm/SQmnpl9IdUrLOfyKO058SJYR2G1
         PjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786528164; x=1787132964;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNnL3c87mu/DIX31ZmKg4EMDsyOIpMA1GsTwk82rq7I=;
        b=n4kqROwu0eaQVqEcly6QNnUiVtpDPbwu9MJCnu8UKpTXhFVi7P/hnpGEFhT2GrA3Xe
         MzHJl9CiWsNjRvBzkvGqFpR1Lm2cJKKy69jNDrpiy2Py0+BSXwbRa7Iu7KYlEztgmjNC
         nqgv+aKPetWTcSoCVZQAuKBc82R2wSPLRelNdue9jOHHAFNKZkvBV3SDDnBAG6YUjyu0
         ViOHllbPzzu/0g3v7AYboQE9240HnPPijIUD8bGDhA9lVCZsGrN76kSETzb2i5JW16DI
         6j2DZ9zRXoKr5Qv56g6BAAHb/zraieqjvVRwVQAaAAmRrQ03jV7qxpQV9tB8b8nEk092
         56Lw==
X-Forwarded-Encrypted: i=1; AHgh+RozphmVbK8DjRKlZIDvP5LQAogFAhO4Huf8eBO/bgyEOx2mWAcPvBClv6xMnHkai6QxRJrUpLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE46k6W3bfGQVJAOv4s8kjJDxtoqyDy2FX4Dixiaj3xgRghbzV
	b4G19ROUwj3onoIZydjPhHu+G//Q0W2WiYZ0KbEEoOY4Q3jnjOkKZzy/iiIC31z5uQo=
X-Gm-Gg: AR+sD12ClX1TzS9bPI4i4e+WMCDLOzvyYhfUop6dMorbLVR6Y/gGZqg17krRT3FGfXZ
	Z5yT9cb4pRvVlGsy0iCIHJ1P63AFv6MkBm3kxZEAXdIKCDJeBfsACKhw3J66+tN67r9l7TGm4RO
	kalZhMnKxdwbwQ2JUa6TaCgcZ77eS7jVzH8/3hFfrEW5N6CNmrcIRUKB4O2Dqvf1ma1C5RJvjt8
	emqr/Nk03B/J9G2oPRCSA0HEwvdSKA6+11IKgCzozmZ3h7UUeYyE88tKJk+shUWtESOcl3IjgCo
	EuwS5nEK/UZhNJYtem+0XZ+grMujS51oEPJ81wpTdYP319tYEMYWb5JUgzMC4tJJgnMBe8dbt6B
	f12g1+Q3VIm772avgwIwUxDz59DuweooaL+953ePokMW//lgtNGiguwT2aGNoENjSFcLuLOgvqi
	xw+W5i5uEtD57gLy4EjyVgDYCP1rHr2gGeULUHGQmlKo6HDqIGAVeM1xn4MjSG/x03bIgcXAg6K
	8CguMvr
X-Received: by 2002:a05:6000:41c2:b0:47f:aead:f81b with SMTP id ffacd0b85a97d-48152c75b41mr4968917f8f.21.1786528163621;
        Wed, 12 Aug 2026 02:49:23 -0700 (PDT)
Received: from [192.168.0.252] ([79.115.63.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d5cba0sm5984868f8f.25.2026.08.12.02.49.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 02:49:23 -0700 (PDT)
Message-ID: <5a4670bb-e24c-4adb-889a-01f54f04d32c@linaro.org>
Date: Wed, 12 Aug 2026 12:49:20 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mtd: spi-nor: use guard() in
 spi_nor_rww_start_exclusive
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, jianhao.xu@seu.edu.cn
References: <20260811041349.333176-1-runyu.xiao@seu.edu.cn>
 <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20260811083111.403453-1-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/11/26 11:31 AM, Runyu Xiao wrote:
> Commit 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup
> helpers") converted the RWW start helpers to scoped mutex cleanup, but
> left spi_nor_rww_start_exclusive() using a plain mutex_lock().
> 
> spi_nor_rww_start_exclusive() is used as a wait_event_killable()
> condition. When it returns false on the busy path, the raw mutex_lock()
> leaves nor->lock held and blocks the operation that must clear the RWW
> state in spi_nor_rww_end_exclusive().
> 
> Use guard(mutex) here as well so this helper matches the other RWW
> start helpers and releases nor->lock on the false return path.
> 
> Fixes: 03e7bb864d9a ("mtd: spi-nor: use scope-based mutex cleanup helpers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
> Changes in v3:
> - Reframe the changelog around the scoped-helper conversion that missed
>   spi_nor_rww_start_exclusive().
> 
> Changes in v2:
> - Replace the analysis-style explanation with a short maintainer-facing
>   description of the busy-path lock hold.
> - Keep the fix focused on using guard(mutex) so the mutex is released on
>   both paths.
> 
> drivers/mtd/spi-nor/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index ccf4396cdcd0..8bc117b46e02 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -1310,7 +1310,7 @@ static bool spi_nor_rww_start_exclusive(struct spi_nor *nor)
>  {
>  	struct spi_nor_rww *rww = &nor->rww;
>  
> -	mutex_lock(&nor->lock);
> +	guard(mutex)(&nor->lock);
>  
>  	if (rww->ongoing_io || rww->ongoing_rd || rww->ongoing_pe)
>  		return false;

