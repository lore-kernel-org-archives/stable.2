Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3778D3F9F3B
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 10:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593159; cv=none; b=clrSDLPK/c8vUEHz8+KCFMk4cSSYrzLUmQHo3mlfgkSXsC7gYq1qydyO3UkRdvU3WXbPM4JV0H+79vJ+gbOLcQPI/ImChqaUv8paNonVb8NXwZ9tVhZG9PY43NZ0M5IdBqjIY7pczGy7m/PuHFfPGdj5v2uSRCLZeju+8ewlUz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593159; c=relaxed/simple;
	bh=hhoTDi4cE8nBlTydhCg8xgeJgn85ch/Nua+FrdtzYVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bAUJcBzKzWKsSjaiCBL/CG2t99FF1IEckCXvzISDR7ND1gcthGMIsMnFgGjAfhG1lWcRmYCSfzq0yR4dEECJxZpujs2ysgKLZgIZ38kJNUDOAdgG1E9Fcwyu84Q3SHUVR3jlQrpDXOIQTJyIDq8FB1wUmuTuGWl7X9I+hbSwx7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=er7/5bzj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="er7/5bzj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7ea9c6ea7deso1022719a34.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 03:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783593157; x=1784197957; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tnOfuF8AUfrsPAGPhFNYnroM0tYE5o0tbrD/pBbOhls=;
        b=er7/5bzjHqGgCZregc1XNr2SmRmE5gg8klgEaQFFKAunGBrXTY6kX+oYm+oVcx/+Mv
         dXRXr2sI7ivAkC95jSdJdIitHyQdmI6NxorW67KMWDb9Qepe0tzH9Uf8o2ggUGhsqDX1
         ySqL8lYfdaPenf/PlYDXbNm6WnIsL9e3SvA5oYQ7oMjZkvF0xL+QLt0ZczMqZD9RFCp5
         8u6Lkgh5cUcCxKjp5xKnOJJqh4boOtekVceIgHkaenx50VUlvAgfsATbHZjdu8gruCUu
         kiRrAQ0+fDkkrbQdG9TUtHg6VA320M7hlL+JCGPJEYQYgXnrB7Oa6slOisaU8Fcs72oc
         0yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783593157; x=1784197957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tnOfuF8AUfrsPAGPhFNYnroM0tYE5o0tbrD/pBbOhls=;
        b=IqcKQz1XxijtVVyg13WHAzVPdWSaKmQMVJ+FeFnI2tlXEddMxPQztQnIfIdFgKkr+S
         qaXrY7yBXFWBSArgHhwAyVKfRmXZ3QMcJegoeE4PwF0owhaChpZpXt9GhJAhijHcARIN
         vPevUfNtTZTn2FcuGV+PiUUpYuhdEKY1LrgDgAifDBLMQKop25UKP+jmAi0NMMsU0287
         qVV8+gRsHgWH5GUhR05lXzNzjquEGuyuXIhZaDd9uqhjYAMuKLbYYlbw32y6gmpD1cm+
         7dPhVk5RkOgQ+mlEoORPLh4YGAJT6556DMluGv0c652W9/mq7qN1GrM9thmYtZcbNh9C
         GOYQ==
X-Forwarded-Encrypted: i=1; AFNElJ9J5mxHwEumKFQjIadbqcC4ettHW6QbD3fGZGseyQ06tW+IDUzZWpo+JpBBjQbmhyjnyL+HkZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN1bvGx3mvgtyFiG4UYZpCqHE8OWR8I4hMPCTf3ZgZcdX3Bg0b
	0tUSr3NBigDzMbWS1XFwrQEphydRXKrtigSwx0nLHK4ij+hjxICEHKdU
X-Gm-Gg: AfdE7clshARyv3Q+iyw9uXgEv8BDHHebD7+TiKWXKmrOp7FxU60U95RUbt1V1rIbhaR
	Ew7qArQODLlwM87Nry7oWCtKiaov7AUtEMMnYx734jwsCnlgzpqY56/ulIH/IL7wuawlFRQlWcj
	+EY0nX9Z5SXOHBkjGgPUfLdsX6D1R/r73NLv1dX44FdYYE7Z8OtTVx45zGMhyVocHJPmXseYhws
	D33QsPt8mQS2pAoV2FLqO0T9f5poAxLv9pYsTJYd00iCtPdkU68nIbKXCwBJd/3rQLTB4bQ+3dp
	JvwcgIjADUcBEfDMc+JkXZqBJbPlsd3/4qxO3hACk16b56vHI3Ugdq9xyVPv0NatmBIFEtdo6g2
	txAhAHyVCmWi1gl6fFcutndRz405Y65yNaygf7vSzGbe82AihOlFSn166sND/CU4lKwe5ilXfH/
	dR6dSyxwJJh/u0buQ=
X-Received: by 2002:a05:6830:6609:b0:7e9:e9a0:9a8b with SMTP id 46e09a7af769-7ebcff5f37fmr5352948a34.16.1783593157222;
        Thu, 09 Jul 2026 03:32:37 -0700 (PDT)
Received: from localhost ([74.80.182.70])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae1ddb8sm3865286a34.6.2026.07.09.03.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 03:32:35 -0700 (PDT)
Date: Thu, 9 Jul 2026 13:32:29 +0300
From: Dan Carpenter <error27@gmail.com>
To: christian.taedcke@weidmueller.com
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	christian.taedcke-oss@weidmueller.com, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] dmaengine: nbpfaxi: Fix setting channel irqs in
 probe()
Message-ID: <ak94vVkvQEocJuSI@stanley.mountain>
References: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-upstreaming-nbpfaxi-v1-v2-1-e6d6b178a278@weidmueller.com>

On Thu, Jul 02, 2026 at 05:28:03PM +0200, Christian Taedcke via B4 Relay wrote:
> diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
> index 05d7321629cc..bcfab62a71d7 100644
> --- a/drivers/dma/nbpfaxi.c
> +++ b/drivers/dma/nbpfaxi.c
> @@ -1374,14 +1374,12 @@ static int nbpf_probe(struct platform_device *pdev)
>  		if (irqs == num_channels + 1) {
>  			struct nbpf_channel *chan;
>  
> -			for (i = 0, chan = nbpf->chan; i < num_channels;
> -			     i++, chan++) {
> +			for (i = 0, chan = nbpf->chan; i < irqs; i++) {
>  				/* Skip the error IRQ */
>  				if (irqbuf[i] == eirq)
> -					i++;
> -				if (i >= ARRAY_SIZE(irqbuf))
> -					return -EINVAL;
> +					continue;
>  				chan->irq = irqbuf[i];
> +				chan++;

If we don't hit the continue then this could still corrupt memory.

regards,
dan carpenter

