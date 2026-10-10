Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810B63F787F
	for <stable@vger.kernel.org>; Sat, 10 Oct 2026 10:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791629933; cv=none; b=gKRJ8MBVlqQkrBNnUOXVEP2NK9L1/aV4uWCEDLfvIDVTYjdSTVPjWw2IhHSx2tBt+Tb/9zCZWGy/DI/wqcoKiEzcgl8E2FaWZX6SFNy8aiuzNtOt2CFN3l3q6KWOUKfvIlTgtKl2hagBbIZIRygyY7jY4d436qevw86j8qE04eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791629933; c=relaxed/simple;
	bh=ey2uGSuG3jrWAcctmiGZyGdUCH4Y/JKOYhjHktRVi18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoBEbU3ZAeHeKqtIPtJU5u5dbLbL80kTXlZxg9nQT1d0eQyCqZZe65rbeepYvqu9Q0PQ62M4qwWMZe/RgTGKGfpyppAfpabIQV2YNyiPbTAvHBJhmitnF1jNFHmkneC6UdnQ/SGOkFA7QCMj4w5AZlGXm5sSJH7+J1a5W6SmHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UORYt5yy; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UORYt5yy"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so6411235e9.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 03:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791629931; x=1792234731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0p+tcFuaad+Ed9GUNOLJGi5vSHUZkfcnyvs2CnZiAAQ=;
        b=UORYt5yyzjPrrVJAI4uPXT4rQkd4pDNL9AAT/KrcCHNj8dqNT+UEB5n1/SYfGvVB0K
         5IipRB0KG8I8nRjikGp9hIiotR/03LuQ8+3KPua6nWMchymndNHWaP5OskIo0o/d9Kk+
         Xlxtk0+7MKlksuiNql6F+UHol10TMducex7Kwb6VJYdme1LVwVmQnp9DBdl1itIwUktI
         Trsalck+4VVT6s8DsG8sfhjamG5uhZeLNkwBBb2gulBF47huEvCOJwUZCjn+N+7ib8V0
         JXxRfAt3kKnWu9jEB14FG0Av/Q/l0iGkvtwV1uhiq9kyCbZFKpKdTh+t4IKInlVVuzlL
         Wp3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791629931; x=1792234731;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0p+tcFuaad+Ed9GUNOLJGi5vSHUZkfcnyvs2CnZiAAQ=;
        b=T72LGF/qSnHT+khit/NyrPWiITtvVdbaqvqP70w0qJXO61EtBlGlyzrv3wUPi1XdyJ
         AKc9NBx0n+3APT4hwgh8XDnYQqwT/VxeZTUPcq0jA3QqF3h0tRUfLMaXFJA65OQKOUCd
         hp5s6KGp8Cs7E67sEjJawEuwWeX/oTvS0A6zULSwHsaIVbAobnhMrHuCXpvuSoLGNW1L
         j7iHJpLG8pcNZtNmgnYe4O6yPDviYLP56zqHsVXNHiOEvk35pa1fpdTBz+s4JC6jx0Om
         y/qkosI9wnkWJA0rq5zhCO20HSRYw2WxnMG1tr49w5Ve2bLfAXlneaDA5TxUc0Xc+c4n
         WtSw==
X-Forwarded-Encrypted: i=1; AKwUvBzNYEZJiGf45wU7kCoNTCOd7/ESZ4zkLRo6IcL7gaD3c6V1X01NqIvvKhFm3xB6dE08kIJ7Z4w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxgRntnyTUpGhQ5PQI5yrLwzaSP7yoKjMwY1TPEXLrA1iZ3ARW
	ym6OwFxc5L0MH+AoFw5vA5LzXOCpwgWLVcBgzr0Y3Ef+ZVrKz24D31mB
X-Gm-Gg: AYBFou2LnKbP4syqAkaIsFtBfWHCdA4ZvzSjjHUhj+VoZWNCknPR4yJa19zQ9gkRrqV
	fHIYurIzkKQB8pUFNVqToUYAo9WYOTnFjaQ//CQ5CrDJRYQPkYnPoTdlMcnpN8RijUwPkzAnbc5
	2aUkTlwNBASuLDe6yL0Cm5v5nsQPHRnBQMwLQg6g9K+NQ/mCICXBVbusOGhrM6+gawH2QzecdfK
	OYvMnDl2SqvPcTPhYChASOkgiZ5nruB403qbM1JTErylBB7VKH1L7l5XUbZg8htnDVbbpwnDBNN
	//LQ35x5jp0HHqCRcosCnjvRwAW2t74O1sp3kwto8WHhceUnXwqcEETOVacYuejXx389IfmncwB
	OZmNY6WT48RvfeBenC6aepXuXdt+9S/IC7nchoOzc2EoMnJ7OAdqRJ2vOqlfKds4Z+QNUBKV4Zn
	6nSBbXGlUdaDzykRBdLLAo3qMidxeAsKDzP+zcLM0USrJ8eTp/h001+3F8/ravijfwrxVv6/zmu
	ViBv6bCPjICuG2ZgCnVMPJsAWDehpiXXGUF1xJIhcgszf5CpL7HJXZKzSI+2AzuiwIRFOt8akhb
	y5ltpCiP1XVAPOPkU4o81vC+KF9GbfE8uTHXxGO/+mwIek+ZU19GVO4dtKuaO4/cT0iaxkwCxrR
	KAjDH
X-Received: by 2002:a05:600c:3e8f:b0:4a0:263c:704f with SMTP id 5b1f17b1804b1-4a18e4a3fbdmr88482075e9.16.1791629930405;
        Sat, 10 Oct 2026 03:58:50 -0700 (PDT)
Received: from imx93-evk.localdomain (dynamic-2a02-3100-9d3f-0d01-48c7-5d76-0ec6-9dac.310.pool.telefonica.de. [2a02:3100:9d3f:d01:48c7:5d76:ec6:9dac])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18e4a3b4asm216792105e9.5.2026.10.10.03.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 03:58:49 -0700 (PDT)
Date: Sat, 10 Oct 2026 12:58:47 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Lukasz Luba <lukasz.luba@arm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Changwoo Min <changwoo@igalia.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] PM: EM: allocate the cpumask for every perf domain
Message-ID: <asoaPjyhSAQ5r-lO@gmail.com>
References: <20260910205234.5392-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910205234.5392-1-kmehltretter@gmail.com>

On Thu, Sep 10, 2026 at 10:52:34PM +0100, Karl Mehltretter wrote:
> KASAN reports slab-out-of-bounds reads for both dump and by-ID requests
> against a synthetic non-CPU performance domain.
> 
> GET_PERF_DOMAINS does not require GENL_ADMIN_PERM, so an unprivileged
> request can reach this path when a GPU or another devfreq device has
> registered an energy model.
> 
> Allocate the cpumask for non-CPU domains too.  The zeroed mask remains
> empty, as required for the documented unused field.
> 
> Fixes: d8eef0453132 ("PM: EM: Implement em_nl_get_pds_doit()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Friendly ping on this patch

Thanks,
Karl
