Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22FC83F1078
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 09:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908809; cv=none; b=CeW8fnnIs7yl4pddsznf3fkhu5ZmD3grEp8AaUHn4uVKkQXsMC4oMqpJhwP4qwXu0MCg+CjhLbpybehZJmhSFPpMlLbYwpj6+i3uesc2jze7aCY/4skUhYEGCOqjPNimoXQNuXqjA+Q9D30shDbMPuxMZAeM/vVpP+AuSH8aY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908809; c=relaxed/simple;
	bh=EGGw3miVGv3g5cGs3Y5Uv6JSfXmW9UFpDJgLxjdqzMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UKlDlSC1HPvkCvM6gSt9Qd65HOoax62uB/y3ebv07oLPTiWWn8LGVJgNtfoG6pU9HsrOawQG+PRr+XklNXkaJLP0KrFDDRItODtxNClvIUjt53mQ9KvupY6RCQmJ2NhE0OKC1349oDExGV/tvNvE64Vbd9BiRQytIQNHc5CfQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Pux+ojDq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pux+ojDq"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84830c774a0so1047450b3a.1
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1787908807; x=1788513607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Dn4vRPgsu9ZH/AxJw/yAM2v9xHesMIpX1FxiYpcxLmU=;
        b=Pux+ojDqr4IkTYpL/QaDQYtR8zxovJJRNG43i0Cv03tV+hOm8SMKWWvNJoAdTDYaF4
         MpnrXyWNSuTkL6KL14753V55TdQm0aQsXuiIZE76CUNbGKXrXyKIKch6Q1hpl8Eb8CLq
         TtcURFnt8fDtIRmCIWFPLWSFf1iQaSjWVvTYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908807; x=1788513607;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Dn4vRPgsu9ZH/AxJw/yAM2v9xHesMIpX1FxiYpcxLmU=;
        b=PFHaMdrlOOmlVKU7nYvyfK637FfCoIl3o2RMYNaKeI8rAY2aRaomJ+GOTit80cVf9S
         rsFVLkzX2/BmFIxApw1RGZf6HzNKAeoqv6egrABdlT9lJC+Ub/13U5YK/GeFHy5AveLm
         LC48xL8x+hZEL+BZ9ogtNwv0QZdhb1c8BP8BArkDHnwwY2J5s8E1zMzWOuM1yWePe+Of
         U7L4uhVJ7NX40f4pSiA6p6eEOT8oOlQUWohdqAifQ8hpcLjlDCjnjaUVFzI7SEjDcoh1
         fvGqMXNOVL6iOsxVPz7a44eNI8ps74Xsm6ket65RlFg2OEcS4EiB9tkVvwfO5N41G1hZ
         vfRw==
X-Forwarded-Encrypted: i=1; AHgh+RrHui/m7J+uwCQuwITaZ8G1RM9LnpD9ZfJMTFTotF30z0uiy0vGGMrthk5XeHlmeX6Ye5ZnCcc=@vger.kernel.org
X-Gm-Message-State: AFuF++mLyqIiva2FbFofwNl0e15fc1JcAkYz6GFLT5HcLqnMyLGlARrL
	WzAZOGcr1CRufzSZ6fLwQLzufJksXTn/gDDnuIMc378t5F+5KMaCRU5QW/9zlQFi5Q==
X-Gm-Gg: AR+sD11cA+/cdO+WH7yuJvJ1x8YgZrH9oFwuT1AP9ji+pne2FPTLYoQAd4EQYyibBq6
	BEkWzlLTQQcYMVyrjnmBh0iiHcBMwCXLLaawsW/HBVAQKH9V/d2WiRJS/f5hUhBgyVaITD8zTzX
	pIyhQiSbOZ7+mp8wa1yRBeEzOj3lc0HSDsVendtqlELLsn0xYfp7i1DN7+BOxWI4cUothuLVw01
	CwbjQvuU2ta5K9zFvTlKhVfVKxklLYOx2fE/A/M8Aaloa6L17kkJVcQUCg58Jn48H2t8fdBlXEo
	hKyK52R5uBbal2UljIAFxzFY08pq9s/OInK1Z6Mul2DAocflaqBMi13Jv1k7gVQPpjLq3zrpSFk
	BeOE0OiWPqDmI/Yx+/vbkF3QUv8CXAZwSfadVv+D1c7/FbWC9b1tKGuh0GKF82AWlYsVLGUxcqp
	xcreP7gJ//bML0EX+z5bWLeQTQrOVlzD/Pz0a+PNofatVmfc/QCicgStmiuB29DlTxuCOxwsnSw
	r/3fPvZzNU/BEwpIOW+eLCJLXqv
X-Received: by 2002:a05:6a20:4499:b0:3cd:9dea:2be1 with SMTP id adf61e73a8af0-3d263ad82a1mr12426617637.0.1787908807449;
        Fri, 28 Aug 2026 02:20:07 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a804:e404:4b31:580b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f68bdsm372314a12.3.2026.08.28.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:20:06 -0700 (PDT)
Date: Fri, 28 Aug 2026 18:20:01 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	akpm@linux-foundation.org, bgeffon@google.com, linux-kernel@vger.kernel.org, 
	linux-block@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] zram: fix idle age_sec underflow in idle_store()
Message-ID: <apFSk6cEmfHNGstC@google.com>
References: <20260828083149.45760-1-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828083149.45760-1-jiahao.kernel@gmail.com>

On (26/08/28 16:31), Hao Jia wrote:
> After commit 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking"),
> idle_store() computes the idle cutoff as:
> 
> 	cutoff = ktime_sub((u32)ktime_get_boottime_seconds(), age_sec);
> 
> Because the left operand is cast to u32, when age_sec exceeds the current
> uptime the subtraction wraps modulo 2^32 and the huge result is
> zero-extended into the s64 cutoff. mark_idle() then marks every entry as
> idle instead of matching nothing. For instance, running
> 
> 	echo 86400 > /sys/block/zramX/idle
> 
> on a machine up for only two minutes marks all newly written pages idle
> and hands them to idle writeback and recompression.
> 
> No slot can have been accessed before the system booted, so an age_sec
> that reaches back past uptime cannot match any slot. Return early in that
> case, without walking the table or taking any slot locks.
> 
> Track the cutoff as time64_t rather than ktime_t. Both cutoff and
> ac_time are boot-time values in seconds, so a plain arithmetic
> comparison against ac_time in mark_idle() is correct and no ktime
> helpers are needed.
> 
> Fixes: 2e8ff2f51dde ("zram: use u32 for entry ac_time tracking")
> Cc: stable@vger.kernel.org
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
