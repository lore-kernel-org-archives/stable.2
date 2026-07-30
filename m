Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A652777FC
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785444050; cv=none; b=DAGB2m8QGdWfttR2u5JfGmgmFd2R0lv0r+4GKGpH4RZwqmLDeQdHRZg2bbCrKlnJcaeLHW/w8Br7Av22fhHUAs/a3OCCByBjjm69PnFS2370IOdz6A/EojJ6ujbqT4uw6emfNc8uJ/xLBwlIRwIOZVsPckGbn20FNUCrNeO9FUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785444050; c=relaxed/simple;
	bh=aXLp3Xrbw0QFVyd/AfIAfjIOAOfO54b/lnpVPsBegwk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Te9+cgxTFfivKThfi+MPS0LE3oP05nsfB7C0O6Fze/MTWlkDU+MvqJv7i6OePTTj6klNNHBB8rUMXIM4+gUzxNcYxxoST57hXSfC4SRSPseMm/VVGBLuVfjlaFDu2oJnmKaDcWcA3fzVwE8CfI7xAR1EGinCtzDGYvRQmHTvSww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=q2YqROCf; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="q2YqROCf"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6acabd2c8bdso83353eaf.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1785444047; x=1786048847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jfLEApi7Y2h1IshU0PF3d8BF/sEF9vNF3m0PUhFH3Gk=;
        b=q2YqROCfgyM/AgmToi72JnFsJCR5CmSk8KWgE0z801a4UOb5VWi2k7AryKvSi1EoZG
         TRw7fT/46ElyXTmyb5S5y4dKXclsMIrNOwmZNcZhy+mHu8DbqaP8NCb8NOcSC4mEfmMb
         4CTWkV4F+GBYu1anV9jiv+bBrrdemUgBLY2reFAoGn1BESGjLj7mTUXUA4/4TaNt7TZ5
         w07YbLWWLRRog0Tbud9u453rp0i/ekiyhbR5QihyOUnK4Er7cDiYm3T1IRA3TbhTBXmA
         B2hPqh4Q5sz5WJFO5UWLlKH7Q65yaFqgBTlA6VZ4Q3XxCjmkTW5kr8X00+iq7Qi/ZIkn
         qZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785444047; x=1786048847;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jfLEApi7Y2h1IshU0PF3d8BF/sEF9vNF3m0PUhFH3Gk=;
        b=ndCpTm9tiTywntJNGNyWxBkyXEtV79ekLixeoGnCVoulUxfZhW3FB1iQ/eT/TA2KTy
         U7btjz89s60/+UQiMcaJwCUbYZUUisXuTDAy4wBeVuNO4wEChhXvIl99EuRwT96C0Ly+
         rPEAeuOcV6a1taFjaoESz4z1AdjzVjVc0D6Tmin8Uy1jifS41krVaIqGTvQNWf7MxvGD
         wgQ6t5r7vdFohvQLXfq7/5NzhwfCKQ+SSlk2wceU+PMNuYepLIntnUzldU7vO++7Hh8u
         fyHVIfdC/ZMrOo31zrSjWsHrXukMek9nybXl6P9mTCdiJyAedhZjLK6YblEL1uEvl19A
         1lTg==
X-Gm-Message-State: AOJu0YykPmW5U3E2UZOZ6uHifnTicfLTEBxOElTe4msUhpjUouGMkt0h
	gh4iW94+dVfw6NEu2YX0BvFOdArTBHVCUEU5dDIc//Faqqkf3luCiyF2fDX5gIIncSY=
X-Gm-Gg: AR+sD13TJiTd/7g5OHccTHPPIRR921+7GZMnxb85937qTUd9etGwo0GQxUm1LEuX3lu
	WMn0rW3+8ZwP5rxC7OP8pyvKF1UAvVEXwfQvVJSrmYPhUrxCWVdLwmD52VGQ7Sqo2Z0Hi8RFAG+
	bTycl7Q5JerhZgcBb3YGY27A8g4zY5xJj3vPlrgff2Ro2stbATigMuAcS2NdYH6iE/V5MD1d5Jk
	eOiCr2c4ExzN/lAyfeBNBF8CDrZJpxK0kEaKC/1UhTFDzy3Y9dHR/3L60y8C5PBQDJtlId587ZC
	W1PS1Pi8sAGC7oh5G81laZzuYdaLRh/gaw5w6nbMRgtq3cFELm8FSz2uPP4Jq++xdjmwjDrqDhi
	DJcPXjyoQ/4Ophcj7X5vaN6JzbbbMPYNv9s7KAboW84ViCsi2Z7mzZw9u6eS+STiNqLCnhlpD4p
	SuiPT1ar4aVyOjHzyEFrQGGlJUp6FkN5wXTIarU/QCw82lNilok/P3RJIkPVBV2q/sCQGAJIbVf
	UKV6DJHViYhJZk34o0qYyoflMjZox/oq3U+WGvVbQ==
X-Received: by 2002:a4a:ee08:0:b0:6aa:f37e:8d33 with SMTP id 006d021491bc7-6acbc11ee34mr2712052eaf.64.1785444047145;
        Thu, 30 Jul 2026 13:40:47 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-458c257c411sm3075594fac.4.2026.07.30.13.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:40:46 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: io-uring@vger.kernel.org, Kyumin Lee <fyonglkm@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260730192734.459247-1-fyonglkm@gmail.com>
References: <20260730192734.459247-1-fyonglkm@gmail.com>
Subject: Re: [PATCH v2] io_uring: preserve task restrictions across exec
Message-Id: <178544404619.3239387.3359715670063842245.b4-ty@b4>
Date: Thu, 30 Jul 2026 14:40:46 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 31 Jul 2026 04:27:34 +0900, Kyumin Lee wrote:
> Per-task restrictions apply to all rings created by a task. Once installed,
> they should not be dropped across exec.
> 
> For a task that has used io_uring, the exec cancellation path calls
> __io_uring_free(). This frees both the task context and the per-task
> restriction, so a ring created after exec is unrestricted.
> 
> [...]

Applied, thanks!

[1/1] io_uring: preserve task restrictions across exec
      commit: bc0e8faf90e776a2f1f3967a04e8091e6bdb4977

Best regards,
-- 
Jens Axboe



