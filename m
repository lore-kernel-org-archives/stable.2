Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5863B38A9
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865806; cv=none; b=gjhPWsCx+twRdOIWabTLv4LhnWBojOPg8UplVxNZf8RXJ+x3A2HrvOzhhbvWQcRBVhGooKmulg3JE4SIKR15b7VjpO/2plqW/EiGgYCDHKXP2joXdMONx30bgY45p8E+Q+mRYPYUylu9iADuPKtnRh+b1Y0QIFKE1VpgNPoMHYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865806; c=relaxed/simple;
	bh=Xa5jcdcqx67e3jNNM5ymHB/EDczYtA+SY20lfLqj4/U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=CHopOWnvQ69TV5mCCda9l8Sz/ESG1wN8P6izA57wPb70DjyVP3iVI89UwDw2S59jLfufCscqJ3tpcANxGeDRHcuLQBUAHsIgigNkmxALkaQVdxdBq+niTkTiyh71ULY4ZtR2Kz1hZY5+azGH94tLz+91mC5n+ujEWNxNcClgidc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=BVEGMhAH; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="BVEGMhAH"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-48f69d8f72aso624860fac.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790865802; x=1791470602; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O/hNnkyBrVzy7QYaX7Aa9ulQWtOZJ0SM2Heb8j07gr8=;
        b=BVEGMhAHhet/nsxLTh8rdlTTbXWPvT89W9mE2T4ZAH6Dk4njtwjSbpSMfupYTX9Gi4
         psGRPWS2iC/zzuLHoi3uw553F61O//qpNg0Mc7Zf/edjT3WHSUTDvtncp8Dj51Hg/i56
         2j2udl5TRf0Ml187PqqaD6qvleBxt591Qov8gWxN+ZFFmpVJJMj9fJi2jYlxVnKw/X5i
         bECYxK5CaoDY6Jv94TaVrTsG4dQ4LL7zI5t5QEFjWGjitq2b3OlvrJap1KNASCXXHPdK
         yHi9UmJEL9hWBH0lmnneaJk/uepC0lCbLWCB4mN9+uvWNHsZpfNAvRn/T04rZHv7hPS7
         PXlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865802; x=1791470602;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/hNnkyBrVzy7QYaX7Aa9ulQWtOZJ0SM2Heb8j07gr8=;
        b=YR0caCqtikG7uCgoWcA5bX79TyjKDvtUpoJTVnNN4HHLYAmWfsCQR9NkbIYfscnUCC
         /3hyXNW7FamHTjzhYj9NZdUVXlekGf8nqhCIKcX2Huu+5fTp6h3UIlojHfpEpTeXxQNT
         fab6AKZkKmanUHFoc862jfFzsZuAuRGpHsbBvmWVCdQK4qQexbO5zFjKMcT6omqrhB6q
         kt6gqNOFUyVz3rgX4RVq3xBJ8MDCSK6w4odKPwqGQqx/UaxuiQPeBzTB+FC6A9xJL6m2
         ouP6mAq/TBg9L5FgHzD1BzJh9ylXM3Zb5mK99lGQbZ14/wJSSwWdrGIKQEY80iQBMFg0
         uZXw==
X-Forwarded-Encrypted: i=1; AKwUvByip6s1mrlYPIwLftNzTqLDUT1BY+NphIJe0lOTgsMjFW4gDyP9RxZqUOVZpKsikxFpg+Ukkw4=@vger.kernel.org
X-Gm-Message-State: AFuF++lCJbI8aMwlezBZGDRbIAYAlRcF2hmZtk4DKfUJilIind6ZXcF3
	LHQWZ2jsjMA9k638iKqO9QmgAwK+m18Wf764BdyuB1bnNg8Dp8iuRARWA5FW5lZoT/wGMF4Yc1W
	/hSCmjJg=
X-Gm-Gg: AYBFou1XHL9TS0Yap+nYzjn3E2R7UMt0pSHU8RlldkZN2V1of6d+ewOp4SKro+ug5Um
	MkB3nFiu+p1s/aSdrg1gbg/X4+jPZ1cWI11jJkfBgYVcHHTI60lW2OZ0w5waTA4gAuOLEXGPT1I
	yyGg/B1l0NPLsNDV4cQdc57aRAPRueVxVCbyDS3SXlVOgYvOYw+xyPU7sPuR9VNRNuqcyHdiHNQ
	fQLlkr4qkoF53qwjsVZ9u+1cRYIdQXyuv9D8WwPpf5wyLlioFip7Uy6WINSV5MNaGyLh698cCHZ
	kPEMYUOcKsOfRG96bIWfsQS5wvKonj3uZHizRd197M678XNboutSh1cwhurlbpWlV38BA7+1gzH
	fnSlphBl51pJFfs7Z5HXc9zfngCBYh/2Aw0pzFu66c/g7QjtbIqBnTmjrLbV0mG1IYCGJVt3Msk
	1lfsv/u8ZN5gL+SkeEnwgUhLfMLp5RGVOy4opDuBYEVi5BvVlv14xAuISb3vQALKFas83qgmJSm
	cu3m+T+tz9bLLHHI4kqMGkD0W4OrAZB45qijbKMAzQ5BMdCG9FoDoI=
X-Received: by 2002:a05:6871:3313:b0:493:5dc4:e591 with SMTP id 586e51a60fabf-49defe01b8amr2509657fac.1.1790865802044;
        Thu, 01 Oct 2026 07:43:22 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded14d8a0sm2638009fac.5.2026.10.01.07.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:43:21 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20260930-blk-plug-ts-flush-v1-1-bf8ca7bc5cd6@virtuozzo.com>
References: <20260930-blk-plug-ts-flush-v1-1-bf8ca7bc5cd6@virtuozzo.com>
Subject: Re: [PATCH] block: drop the cached plug time when
 blk_add_rq_to_plug() flushes
Message-Id: <179086580097.1687323.5913036071644387074.b4-ty@b4>
Date: Thu, 01 Oct 2026 08:43:20 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 30 Sep 2026 14:32:26 +0000, Vasileios Almpanis wrote:
> blk_time_get_ns() caches the current time in the task's plug. The idea
> is that the cache lives for one plug and is dropped when the plug is
> flushed. __blk_flush_plug() and finish_task_switch() do that.
> 
> blk_add_rq_to_plug() also flushes, when the plug has too many requests
> or the last request is at least BLK_PLUG_FLUSH_SIZE. But it calls
> blk_mq_flush_plug_list() directly and never drops the cached time. So
> a task that keeps submitting without sleeping stamps every request
> after that with the time first cached in the plug. start_time_ns and
> io_start_time_ns are stale and the disk stats charge each request for
> the whole time since the plug began.
> 
> [...]

Applied, thanks!

[1/1] block: drop the cached plug time when blk_add_rq_to_plug() flushes
      commit: e0f2224433b15a57125d6ac5d46182f99c6c9d08

Best regards,
-- 
Jens Axboe



