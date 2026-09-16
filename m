Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34D4DF4DE
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789603062; cv=none; b=jMxEQWpxts49of0Hwa4crijccw7YdnnGHg+hldo9T/2WR5qEDVTgibqdeZV0/GN3o4yt/sh3SgCDBfHrlcXJtz/v8L7CK6upVrvZbFWbAedPkTbuEVXz8XsYP3OO35LaL/k1tECuNMfy8PoOcmsF+M80lug5BeSuDE9ePCcTYq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789603062; c=relaxed/simple;
	bh=HuNThuRtR/b8nPXMJCUZcQGR9ZTengwNPThxjxcEuCc=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WcXj5pApp15/hK9/AAAp5O2w8T1s0Ga2sWVlHGUu1zSmaf/XPzFdr0CHjX4Vuiv5IXn9M+N8k6Mi37zqeg+BHhFYunrG7ULYCVmjDFfkh0IEkTtSnhynRAyLjnygS6U/VHIrQaAHoxWyh20ZJC4Ey7L/+llZqoHaT2MHzNvorjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGBsJfFz; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGBsJfFz"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e69b9e16aso2686295e9.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789603059; x=1790207859; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i76bBjRt7lWeVEtpRfqzBf+audkyQA+RhPrniCN+9Qc=;
        b=NGBsJfFz/lcCy8QUv77zpZ1ZV6NviWsbn7L7473f9UL0u31xf3YNyyr8QMleRnXvXR
         9fVNK0e6/Jl3wdqUtpWQ70fjSauoXGy3HQlOhJ3c0gTjuyjMycuPsmyLnJ0XrY5yk4rq
         Q2mpUV7ZMG80GTpFsYvRPR3UmA+FZUatedTW9bczCIoP8ZHiJLFTsUrbeTUU3iF0tLS4
         ZIjWi3noHwU/A67+EnC38cy2XZ+irqK20Xr5bN1APrU1+GQd8hTtXXl9OU1XQHaIIXEu
         7JpP6ZKFIOm3f46g7Gd0R2yRxGotZzL83Bedn0YWxdGM52nd11a2ZStFweK8go9Ic7P7
         U9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789603059; x=1790207859;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i76bBjRt7lWeVEtpRfqzBf+audkyQA+RhPrniCN+9Qc=;
        b=bECjuNPuoq30ZQmdCp4rOivh712s8IA2sjAtEEeoE7Qjn9+znyFEG513VZBPY5se+B
         vR2ydJ1IiEaY2SfZ+z+b9xHWz2UN5euiW2DBsF9kByumq5TPU8ge88lHueGEoXEiEZxC
         Luw5YGtHN63Zi+QrWUvZ4afuJk332UYGNlS0pu5u7wJPH7dCJbBW27YhagGpIrOt4m/o
         u65HNfwucIdV5tkgoMNM0EjvkPRsCs+i3bn5VB4qEv7aKyMAaQR2SNWZVWlYy1pfQJvJ
         xAx0Mzxf9sDOzZBsIuDZFY279sjbHXKpQFMCnuysR3z9qdeCMpVIBSKsFNujC7KARs9I
         vKrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxKXe3UwI8xjorjSDc+apkRz6G+km8CSL+CaRA7wAbU5WHMTM1L+thqDrnu55l4UYlxnyM/E80=@vger.kernel.org
X-Gm-Message-State: AFuF++lg3oNOrrBMPi/4Ap3/lReDxT7mdpr5Bf5r9W8BM6UcyYmUrog2
	xbksySUqqCWmISmot9I5W06NywRpG5/wiuz542Zpg8f0tZXmDGMKCRfH
X-Gm-Gg: AYBFou3WUWzte/5J1NWtxgJXyK4WpVWJ2yNvOf1lpRqhO6NfI9+R+EmlxS/VwCgCNkJ
	8I7VqwuYC9YxM47l93gUeyIzZR+QrKyaiMUCUvee0tB/kKsRkyLzCousjGw6EC6x5P2ajd5fzDh
	YhYFV2SC9ZPaEY8+Zo4yu8JVQFXjuKkQ8MrmF3iy2a7RsGGjs94fQnTpa8CAme/nMdQjktzmoKQ
	IcIJOTKm0PQIcj3IOH6TZdp3rdGfzAtCilopKaeyFKN1jUrtkpnyBWmUZoG4P726ii8Gdd2SxXP
	T/2HO8gRF+qYwdUsY4dpprEk0LGgsyHH5ClzHok1r9Y4BtTNl1QWbzS0D67CnCTUzeW+UXmJzAk
	Xf9RBYoVoWB3H/4tUGJo7kpOwRjajgzPJUcAjvspHpQEj6yyOOA/ocjEgmMUnVTAEwHlLVIkYRr
	etTTrM45O+9l7qjZP21dovFANOIP6KCmnrw5QAQetEKvpIbr7uX5BD90ivniS5Mr/adGNgbs8Dg
	9zk29hArh3YkqZP51MQFBihYaDtmS1StEBoRfr6JMquuss=
X-Received: by 2002:a05:600c:3150:b0:49d:25b0:cc60 with SMTP id 5b1f17b1804b1-49eb73321d4mr54015475e9.29.1789603059482;
        Wed, 16 Sep 2026 16:57:39 -0700 (PDT)
Received: from Ansuel-XPS. (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbd17051fsm30297125e9.0.2026.09.16.16.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:57:39 -0700 (PDT)
Message-ID: <6aab2cf3.a47bfe04.3d08b3.8af8@mx.google.com>
X-Google-Original-Message-ID: <aqss8DLZEsJZLhwf@Ansuel-XPS.>
Date: Thu, 17 Sep 2026 01:57:36 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Daniel Golle <daniel@makrotopia.org>,
	Rosen Penev <rosenp@gmail.com>, Sashiko <sashiko-bot@kernel.org>,
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: phy: qca808x: keep an explicit
 active-high LED across the reset
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
 <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915223138.321307-3-donggeunyoo.kernel@gmail.com>

On Wed, Sep 16, 2026 at 07:31:38AM +0900, Donggeun Yoo wrote:
> With the previous patch an 'active-high' LED node is accepted, so
> led_polarity_mode can now hold 0. qca808x_config_init() only re-asserts
> QCA808X_LED_ACTIVE_HIGH when the mode is -1, the value that means device
> tree asked for nothing, so an explicit active-high does not reach the
> register.
> 
> That matters because the bit does not survive a reset. phy_init_hw() runs
> .soft_reset before .config_init on every attach and resume, and
> commit f203c8c77c76 ("net: phy: qcom: qca808x: default to LED active High if not set")
> records why: "on PHY reset, the Active High bit is not set resulting in
> the LED driven as active-low". The polarity written from device tree
> during phy_probe() is therefore gone by the time the link comes up, and
> the LED runs inverted.
> 
> Re-assert the bit for anything other than an explicit active-low, which
> is the one case that wants it clear and gets that from the reset for
> free. Name the unset value while here: led_polarity_mode otherwise
> holds a PHY_LED_ACTIVE_* value, so spelling the comparison
> PHY_LED_ACTIVE_LOW says what it means where -1, 0 and 1 did not.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5

Reviewed-by: Christian Marangi <ansuelsmth@gmail.com>

-- 
	Ansuel
