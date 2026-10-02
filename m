Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77A147141E
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932586; cv=none; b=YvPFs1IQFpnZnSmspFjlFVwY1TvrMB86y3EQOK/vJBV+mMP3MiEPob+IOwfhqoSLROvXVE618LuZDUyQxMDukCCLLA7dqJ9UQf3Gt/9pwkpEdf6nZsbPAzeNkhXfrsUpSKeWLd4A8e1BDy61lqSpryY5YBAVRDq51TmallnO5JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932586; c=relaxed/simple;
	bh=pFfuAASs4vU8PbL6rfnwmVuYQIlTkdQEJsjJKzsA+Cw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tT8/LojSmohCF90S6L+h333GInnpdyltQX/sMSbE4ALF+PSzWH40tBJXN5vJ9jdZN5H0lIPtlzc7AlmiJR1H2cPLxpY5+4VtPy4c8rtso1SixjxuH5LQhdpdON6cyxXf/yMRnEmKjGGXjSOqPTGX/87Na5s0SvB0w/3KkV1s4N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ecXPoYFm; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecXPoYFm"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b09f6bbe8so983751f8f.1
        for <stable@vger.kernel.org>; Fri, 02 Oct 2026 02:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790932583; x=1791537383; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RbUJ70a7/T0AAXTkHVeKzaKU/0/JyXpkSVeKdxVFGPw=;
        b=ecXPoYFm93rYfCIKliOqejuK+VIOq9xERUZ3B+S2nJW1CuOdiyEzr75Jxw0hsz4Slh
         omfNSqTu2NJZ4U8DB8EnpRILBfzaS+pSxTeh44b8EPg35vK0koOFVQ0MzHs0Oaw2yQbQ
         W83QVTnDWX1GQHnzrnJPFeYPXSVOyahq4SrIDA2v6ON2Z7AbGPtaxDz7t9lpa1yEgeEL
         hjCWycoEgTPuj/rRzDF3VtVVnvTwYDcP9k8Mx9eQOb9PyD/qpH/TqNngBFysh7Im5VG7
         wn9OK/D6RurodVgg+Va5F/W4UdpA9pR6qOrOI26rBWWjtZ8DTRddlVyHpZqzIL2Qm7iF
         TNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790932583; x=1791537383;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RbUJ70a7/T0AAXTkHVeKzaKU/0/JyXpkSVeKdxVFGPw=;
        b=XIEoLLEc64tt6kAK1qR6V/zM5ZkBYQHgqXiPXDCsohmFtpEPgqtOmSiHXFOYK27SRJ
         sSXd8HuDEYKUdhQJQkXfmrUdEOHw+OC0SeXSkXcWdvrkrG8rMWufR1Gsl9Fm7ysrem87
         AT2aYYbSyVD0C5bBIyFcwy1yIP/2fsivYFsBUgsU3MXnibPPCTN3/F6WSnX8RMk0tNa2
         +daY5mb8hVW5/aK4C1fo4pNsorKZ6OhVsXh8WKk61VnW5aT+zEPCWxj87n9/VkOrdyXp
         NqhOm+oHctJhYmBr8ZDRawQNQBeoGsvLEt8uZ8whI2GB9dN9uwqe5N7sVLPv2gOX9HGB
         XW9g==
X-Forwarded-Encrypted: i=1; AKwUvBy4xgRajiVniHpS385xV2a6LCZ2M4vKeHamci9ZUqcb74g52Pmip9e3i1Ary+2JJ3k20XEakHs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIe6wqn/wHIxNyHoE9RwfHr27XAYrQKS4ke44iFVTKtljKMOH5m
	fnplxfgurtjAtDRBitnnV+dS0ZuG4j8WTy6dyw3WvX4UaNTMHUUQ3U5LLjxfFM2TK53eP9U/Bex
	n5Fj8
X-Gm-Gg: AYBFou2SzlzRVIlhupAgUfIp6O4d2bZmDXb7nDZ6WRVTYceirruHuLmYNSzooYzcYDT
	cdhpU6v3ZXXk6e8Mpny61qmE4t9ckhA9Ex+OdSF4X3jBssCEgh1pruiyuSp2zQMAVa1NTikHPFr
	1Vt0mo5qGLoqzlPBfY5nTcc0w/dka5idI4zf7DKhv9kuIzjQLBUXNGTCjCUxhHDfwcg0lZCnqgR
	9eyGoe5+Ag+2zOZ3a6mVhUG5CM2edKjIO+r4NZcW3F1ps5nK6AUdX/M7zcp54VWfd1uyS+j5hmC
	8T/47IGDzupK8hXmkff6716m9MGNuSHr0Up4J8s5DNOiEacz+5IkzkAqMjZg+G3/a78egzoVtu8
	g6f6KYykDjNV4ae8t47ElQ6y3RwRHD3jJXXxX/+6kIZPoGNH1hKjLxIUMnN46v/siRcm6GOmPKZ
	iJUQh3nHy9MWEruk1vOj8HZA91q5m5sR6wcMBtLNYieTzeg/fAdJDCx078pPtAcFaJVJe89m/0H
	+bTFBw7mkQvZl0KUui+e2s/BdPnyA==
X-Received: by 2002:a05:6000:2285:b0:487:197a:5c1f with SMTP id ffacd0b85a97d-48b1272b524mr4209416f8f.49.1790932582851;
        Fri, 02 Oct 2026 02:16:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f9ad6sm4461292f8f.40.2026.10.02.02.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 02:16:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: jesszhan0024@gmail.com, dri-devel@lists.freedesktop.org, 
 Fabio Estevam <festevam@nabladev.com>, stable@vger.kernel.org
In-Reply-To: <20260909201346.937343-1-festevam@gmail.com>
References: <20260909201346.937343-1-festevam@gmail.com>
Subject: Re: [PATCH] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable
 delay
Message-Id: <179093258210.2282096.13923382036557231233.b4-ty@b4>
Date: Fri, 02 Oct 2026 11:16:22 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.1

Hi,

On Wed, 09 Sep 2026 17:13:46 -0300, Fabio Estevam wrote:
> The RFF500F-AWH-DNN datasheet requires a minimum delay of 250 ms
> between display signal output and backlight power-on.
> 
> Without this delay, the backlight can expose unsettled panel contents
> during display startup, resulting in a brief bright flash.
> 
> Set the panel enable delay to the datasheet-specified minimum.
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] drm/panel: simple: Add Raystar RFF500F-AWH-DNN enable delay
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/a92ed345422cd66329b5e9d4e82b0452e185f36f

-- 
Neil

