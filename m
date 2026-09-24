Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com [74.125.229.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A44E47B406
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 12:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254637; cv=none; b=unWqbNujJFVpk5Ar/eQTapb/PdsnKstP9MUNwBDmTW7MN50nm+P9XbllDhVWPj7KbtBToy2QrcmaNs4M+D25e+E6WUZhTtrzAT1sGLRCM4Qt3qF2axVtcUFSB/zJX/R9sfGoKjtinQcRBG1j1UpLsuYP5wD++KqEuFDZFJgdTgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254637; c=relaxed/simple;
	bh=qO0kj9PE3B3BHU7L9oKJMgaMPTafszLp+ZSfz5gzDLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5WMdSBXS6jne3Uz1SNGufGxNj6YUI0azbCEdHVIgOP5AcuoSndiHWqcNwS1LMrgz8ud8TK/iTg8LbvOl3f6NwHPEFinVe1gCvFkdb2s4DneAmCNjkjotFOUrTXk+gw6hueXV2B5IKQVVuBXKJuz4IQmUYJVGAlmbEvE2yDGmCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=LW7QsO6h; arc=none smtp.client-ip=74.125.229.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="LW7QsO6h"
Received: by mail-dl2-f42.google.com with SMTP id a92af1059eb24-144efd1ea76so1593544c88.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790254633; x=1790859433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pevCrRcNO3jk1yVeVzTiK99o69tfb2DiDsJdfsvZ4aU=;
        b=LW7QsO6hNJO5D72KAhOv1RfeZJ+a66q4U23s4dQ3+/aepIHGhuXeAcBpHsHzsK9nPe
         HUZb5e8AckQ7n/dBel5MsXyT6XxyEPB+Vn/VJXG9Nq7K3h3oCkkdyCxU54uZEOowhTSl
         SifJxz6dkZHbrWR2Mo0JC3aDrCSFgy6uOH2B/5zKvRygjP1rpQ/Wh8g1BGKsZ6HTzaYb
         yjfRlqRD5Gvm4OuDc2YfaFznXbE41KQVrwavUWv4CkFk4VWQ5/7bUy6c9OA/lvMAeUga
         c8HHo5Jm7TFkQdyovVDkHCtoN8OwHLaSCPjqAYdHgJjU/nqDyV90FUwLPcKM67ReZfQz
         JH4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790254633; x=1790859433;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pevCrRcNO3jk1yVeVzTiK99o69tfb2DiDsJdfsvZ4aU=;
        b=rwCL+Izh/TQ0pSlOJKiPNzHhy6xvSYndEUlxHABEKmORJYdzdKDiGubEO2Kn/EflZU
         BRNS37C17hpVC729qH1wkT5hEWhCD5Yx9SBRCJ+5hMJkkq/TPuZVt2PI1VMwYH9/3akM
         q26Afxjzn9OzoH/J0dFaMyC8eaev2+r3rapztbbrCnDa/NSD2kf9XujRmbFlY7jBNdYY
         3jV1BqxJGezBKM95bkYo3shakQB3/YyM0ugz3kG1BcLXNjDmGnIVr9hg7oQOtEcekU64
         5ESyjX1AlzIRpSWAuN4EXPyAky2FbTgZdGdgEEnQjwKmI+zwfg5jNHDnTkIBw1WZeuds
         pQLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxWGWja288UAGrCiV5VT3b5WOtWyKaeugLqjqCptcpsvmJGyG3klT0rQxtnCBs2yZ1Hvjf0i0k=@vger.kernel.org
X-Gm-Message-State: AFuF++m7oxS2STv4XhkYmp/KZ7Ho6oTM7TxQ++/dnrzecJgJB3psil9S
	TQTjrkxwNNczqARmCunLNdnVP/nTxscM3mwXdzea6/97TifrH/gjHTwkYrk1A7FITYA=
X-Gm-Gg: AYBFou22MDzOwmUOmsLb3Eh6Cd432lOaA0J+jQMHn2Z8gIIueLBZjpGzab4+per+sC8
	C8qQ9OH63WJssIwpOPRGZwlMup45nj1kY2o4ieYETIXItFiO8Mnk8sk4qNhCBRgJwj3UBZrl72s
	/7s/oZiD4/4pnDy0UiT/e3WV8HC8apr+k0kvVppLlczaSjIBEZnI6DvmxkZ46SB4BBO1eNIA8pV
	GpuUCc5IBeRFur8rITVPSoooOfbFblk0349ozkBxhFYCvV7K8ReG+Y0b3fmFpUXXQrwPCAy2jzd
	KJ/KXuizCNZOU/4plL+VCcT7sH/vAMJR00fY9AyKOxpV2v+K7yiNHWPiv8yLIK9kwq0cgsjFp6n
	d+ZPPA1q2SUViTKZGL/noTewqbdKJVjPU94/yReLjNBLf0G4hparl3c+tq5MHehwk4bV+T32NQB
	FJWwUXTWqeDux+JcWr3c7jvf6ifDwv1QRSSm5Hgo07sd6c4LCmszsOnNyrYLU5LZutSZjvfre/W
	hYMrQHoBkBTBCk3rwbRauYIDGV7Bk1z4S00BZJ85ghZ1uzZAWfUVVsAYkZQy9iXflYn
X-Received: by 2002:a05:701b:2083:20b0:137:f532:e360 with SMTP id a92af1059eb24-14504030c73mr2106323c88.3.1790254633130;
        Thu, 24 Sep 2026 05:57:13 -0700 (PDT)
Received: from [192.168.1.125] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f98ca0edsm12812367c88.15.2026.09.24.05.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 05:57:12 -0700 (PDT)
Message-ID: <73b530eb-ae36-4c20-b9d1-b657410ead97@kernel.dk>
Date: Thu, 24 Sep 2026 06:57:11 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] io_uring: fix CQE32 and CQE_MIXED ring refill
 handling
To: Hui Peng <benquike@gmail.com>
Cc: io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260919203516.2581409-1-benquike@gmail.com>
 <20260924063525.2500081-1-benquike@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260924063525.2500081-1-benquike@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/24/26 12:35 AM, Hui Peng wrote:
> This series fixes two issues in io_cqe_cache_refill() and
> io_fill_nop_cqe() for 32-byte CQEs:
> 
> 1. Restrict skip CQE insertion at off + 1 == ctx->cq_entries to
>    IORING_SETUP_CQE_MIXED rings so pure IORING_SETUP_CQE32 rings do not
>    emit bogus IORING_CQE_F_SKIP entries.
> 2. Require 3 free CQ slots in io_fill_nop_cqe() before emitting a skip
>    CQE for a 32-byte CQE wrapping across the end of an
>    IORING_SETUP_CQE_MIXED ring, preventing an orphan skip CQE when fewer
>    than 3 slots are free.
> 
> Changes in v2:
> - Split into a 2-patch series and drop the third hunk from v1, as
>   requested by Jens Axboe.

Sorry maybe my reply got lost, but I did do this work for you and
split it into a 7.3 and 7.4 set. See my branches here:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=for-7.4/io_uring

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux.git/log/?h=io_uring-7.3

Please take a look.

-- 
Jens Axboe

