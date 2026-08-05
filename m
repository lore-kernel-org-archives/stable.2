Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B163430E0F2
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785893301; cv=none; b=CPdaqR/9ynDPZbBeoIkjVUicxWOoZsPYmeem6cZlLhNDzggqSN1Mnufewh1suIuIOSFj7rRXd0GYPPw/Cy575GcFQBThSILTNIWh6+r950bVj8MVTh8+Lvcu16fOjEY1Vhhux3TXfAZqyd+bj9ohNao+fd0cZNGwUNdh8m7oPu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785893301; c=relaxed/simple;
	bh=LP/CPsWWk7JdhdkRUgVX64RFY6Mb6ULuSPlD2yzQEHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyPWjKPvxuIXj/VmJ3rGBDz9BMeYmimzxpbTLQFjMyz1oQZhg9k9TzdAB88ZkM92zxD3itoJA08Zip35OXnHqLriwymBbHl0fqTs00vmz2N7BKTJxbHwxv9H6hb7NnBnLmQJKS9LvB5KEJtKVFmTJVfXvGsjN1PWrmCq5zLKNr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hvADBIN7; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hvADBIN7"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38dfe910e9dso396752a91.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 18:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785893299; x=1786498099; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hDRA8RaOryE0v7n4VH+L8tqsdWogJTvOgNRaAuqsLwI=;
        b=hvADBIN7rloNVJUcjZwSAi9T70JUdSa0z/QU4PX57XNrGiSXe/61ezs7CjBU5JwkcO
         KIpJUfnjj7UaaYLaJAf7f2zqFLKhLAwmMXknBvLrVtybaF6d4WEoL1Y4AvyQhnMCQxdB
         uQ4DbY182uXwI+CJAzKyJ1javMr2Es1Aeo2AM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785893299; x=1786498099;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hDRA8RaOryE0v7n4VH+L8tqsdWogJTvOgNRaAuqsLwI=;
        b=cMl/wbhMIB7aeLDk8WRwIKeB4USyrzlbmKI1I1bwpefHqF2T8fGzyuC6qFdatsFK2E
         hg1pEh8b9KETcGUtbs/I54e+GrVyDz7WWesRlhsPgaaFeQxBsMShRByCVGmmrqOGtsM8
         eLSQFx7qXNiKPX2omr9o/VVTo2RBCkyFX36zQympmPXOp79uC0pub0ysGrBeBDvQzoI7
         gSaoBPvfTmYgMgGqs1Ll3Ti0Iu3xqxQzXYyVt/EywE2CgwjMQM3Kmt6RK3vVxJf5IZ94
         E4ExZWXV4bZLku3XVfb7UxvNAdz5fKEd1FVbgi1vNZYS1Kd5CYTzOZ2LD7dS6Ned0Jvr
         umcA==
X-Forwarded-Encrypted: i=1; AHgh+Rp6pRk+jR56mXV0qEbTRCguxva3EtlwsWdeQS9JMeRRwGRC8fO7ZuenwnFvlOsCZvs6arId4fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwfOPBK/2a5SpHHcOly/TOUC58Gn5nvwm9n2xmV8guXkdhggtR
	1PJZfLMv9P1/3ujI+7wf6X4CobQXcPiZU22YFXGjzLmSMMom8vusahwMeACo4sTDdg==
X-Gm-Gg: AR+sD12zYpNunSkI6o2To9yzk5t1ZGrFeXv4PKd8mMvHttDODrEposSt8rAKsDiFoNH
	PcvT1j8NNHr8MidVbJlmUGdGvGesrXhezbPtR+AGT7+O8x6tKu40XhsFMB4xF/dmg9Cpmn4QJ4b
	PO6wbN+XQhY+S3vTk2bjmSCKV6giR3O/Bj8RHL+6i+ys+Ogy51iwzg6H4TxH5QMzTDHSNdo+ZAL
	J/Rap6ra6mze6YNVs6qriZtz+G6ELlXLcJ2covwQUQJEqOEV79uUsJkheQ9TofI2A/6KvckRs2G
	8Hbd+mYPbqIeX3nAKjwvGf8iMmta/o8KlJ83+1uOBkujZUoa3YjVzWEzJBTvw/1JHoxmlySmJqn
	a66EiIpDmnJie58g+zhV//ZqBIy2ny0Gqxab8iE9kHi9ImSMOrK9upOHXqx41sltdNdbpKojDtW
	4ZwPrCqjOw5sOkBoi9uuwHtpGMpxF4p4nUhvDYtlq7IS0W2r+++PBeABjhIvCesjwUYRuLovfA4
	P1ElEtX3sQLVKHUCinHbso+OanqeIljo/0tBf8=
X-Received: by 2002:a17:90b:5447:b0:380:83fc:4315 with SMTP id 98e67ed59e1d1-3903c66b3bfmr3047061a91.21.1785893298950;
        Tue, 04 Aug 2026 18:28:18 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:32eb:b46b:e9eb:65c5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903d183dadsm554776a91.0.2026.08.04.18.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 18:28:18 -0700 (PDT)
Date: Wed, 5 Aug 2026 10:28:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Longlong Xia <xialonglong2025@163.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Message-ID: <anKRhIPsWUwvCzm_@google.com>
References: <20260804143832.146129-1-xialonglong2025@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804143832.146129-1-xialonglong2025@163.com>

On (26/08/04 22:38), Longlong Xia wrote:
> zram uses u32 slot indexes, while disksize_store() accepts a u64
> size. On 32-bit systems, a disksize larger than U32_MAX pages is
> truncated when zram_meta_alloc() assigns the page count to size_t.
> array_size() then sees only the truncated count, so a small table can
> be allocated while the original capacity is published. Valid I/O
> within that capacity can subsequently access beyond zram->table.
> 
> The same oversized capacity also lets full-device scanners compare a
> u32 index with an upper bound larger than U32_MAX, so the index can
> wrap instead of terminating.
> 
> Reject disksizes larger than U32_MAX pages before aligning and
> allocating the table. This keeps the table size, published capacity and
> slot index range consistent.
> 
> Fixes: 33863c21e69e ("Staging: zram: Replace ioctls with sysfs interface")
> Cc: <stable@vger.kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
