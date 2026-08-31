Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE09244692
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788154371; cv=none; b=pXC7dgcli4RgLEkt8WGo0Iaxao4l2UwRYX6lOtJSDOLrhWgfDwGMIVVG/gFLGdwTp4NkvCIvz/g4kAVm1nwSNiQGjG8MADIwrBmAgDcdJFAw62hHZa1f/8inYmA9tIMYCXuodRydi+98OPmEaQ052HMo77ox2wQnbhmmreQroiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788154371; c=relaxed/simple;
	bh=DbE10ieYAAPdZ/aMj7Jha3L88yCriiIiyuo63Lm7PCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NL+EafFUZ55W1LZxubdmjp25tfIr4r9Vj4xyjGdJYEscKdBfVJV+GpHlUOhgHXLCOe9YcSyXqD5J/vHNZx1e47qyODR16LJHh7ldqNEzHAC+lnT9tPxYrs58/K19dB3p5EJOr3ugmCdiWnE71NgVI8EQqtWadqkbiGUgtFIrqTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yUOn5QLc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yUOn5QLc"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3964e480f76so3772478a91.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1788154370; x=1788759170; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z3oEOL/HCSYn6nVXIxkFld926tCj7R+jnIQrhk3OHvk=;
        b=yUOn5QLcKIShaSFftZdQbmyej5/roTsoUwXl6MliySgXKrmvEh3m0snZd6vqjY42yA
         qaxdf7D3k6ESk59InZzH3Xfa4eMXDGsUO/tZIuhD9a+mxYsmlsg128qoRZHuZVpFYnYv
         gZdQzRjj3anUtg9sugk5TwYjUHACrfq6T2D7OYI/ZYoysueMZuuzusWBqG/TuGxqF+FK
         Kfa/yEeKKIKH/pukEPB70eWmlQar4Gze+r1gj13OLewshMgrlIB1RiqVTOlkcPMuOiUL
         vp9O6TaAo8ND6WosT5+RLiLtkkLZykywg8qnkQEH6/Azm2mJQItT7+EyVg8CIRhffB4q
         P1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788154370; x=1788759170;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3oEOL/HCSYn6nVXIxkFld926tCj7R+jnIQrhk3OHvk=;
        b=AsPXjHK4wc4G2K2rvLU/YE5vkuDVayl5CGe0ZvXBXn9mjq+LHgbEsL+A8CHWzqVBSx
         ZjdCLcbwPQzlGyiHGEAxCF+c1rZejuLeo+IY76tGQYUf42YsO8uf5NM8ywm1pM6rOW49
         ZQmfCt9tI0ECWQlONRC8TFvQxZYP+gXQJxnuxRSR15KpHFFw74NUCzIkPX7k7xd1H8v8
         XhE/gr3Qyl9+CD7nuhs0r5B5odIcmN0JI6wYZrkT3LPfv1dx2tXYKBdArv+/RH4xEExt
         7cCS+O6As1QePDo5TQOzpvHGT5/vdzonXLTl6V4s8EJYXygEyFia0HWKzJpGRh353PH9
         WR+A==
X-Forwarded-Encrypted: i=1; AKwUvBxVAjUs6XrRqyn6ShK0IMIfPfETd59Kyql1ckkCPTkZQNZMwkuLEWKLCJ77RPdEsQWrZtQmw4U=@vger.kernel.org
X-Gm-Message-State: AFuF++mQdeh03rfNvSsVXXK79Wo+VUNtbRxcSEdUpe2eQbqCG1eKXwm3
	x+hdjMoA7W3LCQyc5hxgfjXsRBOv1N4Ynn1XSy2WYWEVLK+9HaHXcnyjHbt2MTnzawA=
X-Gm-Gg: AYBFou0wNS++7poDbVZ7muVTUHESOhBZP2NZN0GW/uiWGOTsUCDkdc5VY5l7f1YUZg8
	bXK8dcQxzNke6SCEedAU1ZQxn96rgv5EOLu+cb3psfozRefQr+8jgR1cYaCZrPdkN08FQgQgGLg
	Ru+udYAIafEINFsYWG34UQmVb5X+GGvLKTSwnG6E/8oXRfnwYM280mkSSYZV2oFkhd4353sdaYQ
	e/TLB3srrVWpaWeV2gXxlHDEB0UnjNL+8xQ9ODP2nOA9tdtBTsKpSPtyBY40xvo0Xt5Ga7McO6h
	8tDwIbVZGJqVRtiCR8q2cJbg2uAyOE1KlZM8CHyQ7FfsAce5FHO6rCESz5bQ6GeOsP9nbVScLDw
	OPyGFe1wof/5Gf2cD8+AsvLxuxR8SKpJeJt9HrHSBfFh/LTquUxVF9xYv8rutLt5jzMbNLOkJ0A
	3F8a0J9KwjXnwTuD6zPpJgYUn1bbdWaevKs5cpNEcc4mGaRRpRoKAyrz1gPejYD0A=
X-Received: by 2002:a17:90b:388c:b0:396:5f7f:52f5 with SMTP id 98e67ed59e1d1-396d0e2466fmr36959506a91.3.1788154369601;
        Sun, 30 Aug 2026 22:32:49 -0700 (PDT)
Received: from localhost ([122.172.87.224])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32bdfd03e71sm9171326eec.1.2026.08.30.22.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 22:32:48 -0700 (PDT)
Date: Mon, 31 Aug 2026 11:02:46 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] cpufreq: airoha: fix probe failure with correct error
 check
Message-ID: <apUR_vBWRwMfUlsK@vireshk-B250M-D3H>
References: <20260821084541.139703-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821084541.139703-1-ansuelsmth@gmail.com>

On 21-08-26, 10:45, Christian Marangi wrote:
> From: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> 
> dev_pm_domain_attach_list() returns the number of attached PM domains
> on success (a positive count), or a negative error code on failure.
> The driver checks "if (ret)" which treats a successful attachment of
> one or more PM domains as an error, causing the probe to fail with
> return code 1.
> 
> Fix by checking "if (ret < 0)" like all other users of this API.
> 
> Cc: stable@vger.kernel.org
> Fixes: 84cf9e541ccc ("cpufreq: airoha: Add EN7581 CPUFreq SMCCC driver")
> Signed-off-by: Daniel Schwierzeck <daniel.schwierzeck@gmail.com>
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/cpufreq/airoha-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied. Thanks.

-- 
viresh
