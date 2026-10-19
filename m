Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442248;
	b=rCvdGEd3rFX08A2HeiDviYe0vjboungdin2NXlyk13E7wMcws/ruy+8h41QBZQV9H+yH
	 /xpFOHLUFnqegOuoqMd5W5v29vx1RAPiTrMeyGQfhHGRwurtP9E67N6EhcyYwtWLgP6zF
	 sO/QOwvwB+5vShM+ZNrAYkIZiMtE1nAEGAbmufqI1xe5597ysa33A3GklmDdLZ7ZQcMeq
	 ucLsljHl7mkX/TyDJh8ls75QwoW7+HvXdYNN8uameQ8dWWZ3Y7U4U/DD0AVfa6lY5/KiC
	 JuSvfnYE27Hwuq2xW2JEDIIpd42+dkF0tlUL63WSokQSs4UvtdA0pjjVlsyiku/jMsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442248;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
	b=fLbsidpPotZvkcvPjqQoYm3bnzVOwZIvFnaZ4dfUA7t/0co5aAK+LmL0R6nL8ZCRIZzc
	 wTl/NZfBH/nnYQEgA/HzXZd+0IRFrwvIqdUKa6ltBhTzP8NW8CEu47vYDG+2WWEM4R/e6
	 BG2SmTZqwceg5fZli3xS7U1i+zeRw8AFRUlD1zkNxOvEsEKEnizgkG+zX8jPhwqqOxxpB
	 PJT+DTPz/3uBTAJIYVSYLftq4oxwoJQqW1nAIamvr6AO297YjA9Coe5pyw+/aybELAhKs
	 sGvjU2XtGtd4dRXYCgo+b1WsD1ZgdGwOUSsOv/97tKUpDY7t3noH4ulWzne6SwzVMLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C0606A322
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030C0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so19313795e9.1
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 13:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442241; x=1793047041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=TbdVKbnQRRp9vEsLOXaAXOe8RCtxTDKUbwKg9QY2mqDPSPar/3P4WhNaodDxDY+BkL
         z5fhNg+9YEHPJPYwu73YuJ24D3oaA7K6HDZKf5aH+c1Pe/B7GdlWJdKoI7eTwRUs+eNR
         XWTT2Bvx1AyIFnoplHVTcghLleDAmLt5NYnTajZ7eY321BIDTd3dT989KlGwDKD9NDGP
         cr4C9uSJVWcYwgvwncn6c7MjZTP1GInixxG1DDJuJeIPCWhUwBxCX3CPl8BcL+65FzdA
         UkvSpS6m+3pS+D/8aBkplRzK1r/Qv+7uSg5JACP5SEL+A+he8lOE68px7ghnG77sVgpW
         fEuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442241; x=1793047041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OlQWf86SXokSuh4SBBMFiqlQD7tg29+MR0deKhyYBLU=;
        b=VMqEkiI/skkuOBW3uDiGKqFmR6YpAOkvYsR+EhYHcPGziuGSF7JPbwtvpcc9Bcfw63
         O5u9qAtqdPbR/zy+WnTEgun16rT7equAMiicycXU+WbEHbPFVIBtPd7/f/p2+JNaR9c7
         LeuoZK69m9oBKg/EBSapyKCokUi1/Nfxb8hw6HBS0z9v7FH/MFmlrenyQE7M7r5QdZyG
         GVi/iPqjuz2J+o1QV3SNIoh6xns+IYY1/1qdqCPpQL08+a43LFtmWCQcKucPWwktPaXF
         3fHzk7XjVZho6m3lmfUWZRquWbgaF/AFNyTLn4VQzxDFwKFZJJXIAZr8RbK7rCdcJycK
         27+A==
X-Forwarded-Encrypted: i=1; AKwUvBz3q5hMch6DJjcqGz/NdcKsLhbjkbXMwU9TEYx5AmfvXi1Vshy8ZYV6AJUTiTt7OPKhKwBF8JM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIW91SLYa9McY/RgfAS74ZWpNkOWEdHLsjdPk5C5vfJVut8Ex3H
	poLMrqmwciof1VlJN4ZjPT4RlfTltvj/NE9by4NIdBednXpVIhYSdxBS
X-Gm-Gg: AYBFou2hlHCZ8/UJaFCwccUeF9v4kVY2b5B0fHTHq92ZcHE5V2+zN9NX3F3t+wcj2Q8
	5jECEem1gIEaJbVIZuAanMLjqyQENiNkwaQA9T+zmbLdX9KzWXG7F5rxGlyJ/H9geAwIg9/HoGV
	xR2QDz86JilKsPz+35IkEjfcRpitig+MsGCcqDauk3ya+FwnAHQIustUq1A8RvWg7aSEyjRw24l
	qpHAuTbDopEwM9Eg8xJEui8JwFvpfOgo1ObOZhz4AHv5W+anCGdD6UEZvmqBTk088bi28hCNqCn
	xIdfUkUBgE9ndHMNN7YLKrU9d4NioQ5/nAS1aNVQ/yC6rxsnbN1KpWwnWuz7VvJvL8pbX/5j2nV
	vC7t6ZMTxi1ZpVs9tJrnP08R3oDymUhN7bZV6qvHmdVBt5OP7ZgflJI7dPii2WDspLfa9HQn2az
	wpP1DEuI4GRYCZJFrvMSozqTncbMtfI6M00bdT3VwNeLsjIxxGKMnX5UplmtNq9sqZquLNwnreO
	h7kWfdA5JtSM3NrsGtERws7aExdBOU8zot8YzFfNwMUdUGEdc+lwhWEwZvYwr0zDfqqOjqd7Pga
	rKnE+RR2qLH24/dh5WMqsp1uXNW65KVTNP4RHK0T4qRnjw3PRx73FV2oxG8MG4tsIsPh06Fh0Sm
	l0OuFlETI
X-Received: by 2002:a05:600c:3e85:b0:4a1:d798:b08a with SMTP id 5b1f17b1804b1-4a1d798b0d4mr175531195e9.21.1792442241144;
        Mon, 19 Oct 2026 13:37:21 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de. [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2c9e9c3sm15967405e9.3.2026.10.19.13.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:37:20 -0700 (PDT)
Date: Mon, 19 Oct 2026 22:37:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: netdev@vger.kernel.org, Roger Quadros <rogerq@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Keerthy <j-keerthy@ti.com>, Kevin Hao <haokexin@gmail.com>, 
	Alexander Sverdlin <alex@sverdlin.org>, Arnd Bergmann <arnd@arndb.de>, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: cpsw: fix netdev cleanup on probe failure
Message-ID: <atZ8lCW0VVPzoHwb@gmail.com>
References: <20261019060430.33254-1-kmehltretter@gmail.com>
 <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c20d708a-f4d6-4e66-a516-056d93264825@ti.com>

On Mon, Oct 19, 2026 at 12:19:11PM +0100, Siddharth Vadapalli wrote:
> > +		unregister_netdev(ndev);
> > +		disable_work_sync(&priv->rx_mode_work);
> 
> Although the above code is a refactor, it appears to me that the correct
> sequence should be:
> 	disable_work_sync(&priv->rx_mode_work);
> 	unregister_netdev(ndev);
> RX Mode work (cpsw_ndo_set_rx_mode_work) does have a 'netif_running' check
> so it might still be fine if the sequence isn't followed.
> 
> Please correct me if I am mistaken regarding the above. Rest of the patch
> looks good to me.
> 

Both orders are safe here. The worker and unregister_netdev() serialize
on RTNL, so a worker running after unregister exits at !netif_running().

This matches cpsw_new, so I'd keep the current order.

Thanks,
Karl
