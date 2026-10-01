Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF54457E7F
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790865807; cv=none; b=Q0d/4VHrDFfv4uxpro860pElsdv7iRrmluIihDNaGS4Ovhv/K8075IkVXeYEGqM6n+PHADfdHNFJg7Amn6QVzc2cTJo9psBMI69UfShGBsQcJTQ8WCt4Pq/9NJ0sQ8GnDOg2GTyg0zYEw/cBY8b/OVYeKL2eEuLonT6UAf32Hsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790865807; c=relaxed/simple;
	bh=CJ410Hnuw7HxUN1V6vTAjlcL9lvaHvFeCOJ1Ey0FcDE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J2h3zqcDa9pxzIzB2GjgkPqyPj7dh+RIJB5NnBp968ZJjGX0dgj46Awa7e4kS8Q8ojd9dvWINKtk2Dsc2wn0Bql1kDrkiiLrj6bmHxa6DtrOo8xVfEhbT06Wah43vGFR8D4cvLR2nlGl8iqkPbN+ED8wAy7m7/PpNApu4pSyGlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=UEG0Df7I; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="UEG0Df7I"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2a99so3601898fac.3
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 07:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1790865803; x=1791470603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0lw+Zx3Ctji2MKAhZ1Qo8iu3S4OiHZVAXCS35rHrty8=;
        b=UEG0Df7IWlrbq1QmAq8rbT6UOXeeR5gp6ulSqm1bOjdOJDUhPnqFZa9GdUXgb9hKsf
         uBsBgfk3Rt8ned53uqKeJyyMVkJVfBPfK7JU8sLCX5mmfLLvG1wiek9oCfpHuUhFht56
         Vqr974Aqy99KYFHW3UpZ6HYwPmCv9rcvVKm1Rj4pxtVnJlIenPsarkQnV8ce1v13JiDX
         X0C9fV1bsxgGloLzwe2uDx2ZXziGbH6EiG8sjAVvK4Gaj5Usx0UwlbPmKfUOFEYYgQmO
         4RXNYMO3VRlgCVuZLsaNVI3qYqi9b3OnoOl+r+T5pCX2fKeVRej+FHsk9A7bSooAKrRu
         lsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790865803; x=1791470603;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0lw+Zx3Ctji2MKAhZ1Qo8iu3S4OiHZVAXCS35rHrty8=;
        b=iB1N2Vg0e/r7qrJ0P8jVYpD4WT1XAe6tmLuGCMnMu53hVmnDbqMTGITWRUR6C70wLf
         szHLxj+4gY7+ayR+EfeHyWfsY7BD9+AXfdv0BFGBsJ7FAyfPJqzABjI4ShskaTVWky6H
         4YAzua7uwoHz9niUvSQ23tYK8VBad9w7HCm17scXShpebZU+H+KUGOCLOlxjFJ0f+9cw
         g5GlxJyhHg2LPwyQ2SM+CJlnXyER7eyP9fj7QH+EogVi2ReA9MlDzPHAANKBxrx1fVRO
         crHDbv/r/5xKU1qFbF7puCynRDY4ELtpW3fkT/FLvE6UOAIwUzYgyYJT12VPtQoeO/p9
         bQPA==
X-Forwarded-Encrypted: i=1; AKwUvBzjTO6ws9lRvix3UuWf1yzht0OIMrrrpDRsCHPF+KvVlU9GzJ97gsPrCElwUlFta3AF4Vo1O4A=@vger.kernel.org
X-Gm-Message-State: AFq9FYISZB4dYRlhgBamR78vVHEB4yVHp/t7H1kxiHpZ7px3xSyvtamH
	z6StEu0OGbaSDcfv1BQ9ZIPiQqiHOvIFLfxPi+ROaLdRnursz5uJYolNYUO6qT7X/jp4KE7SAZD
	gwj7vppQ=
X-Gm-Gg: AYBFou3zMulsdJw+HT+8x6B5kN9tA0RIU/BHoTI+AB8keV6xK17BaOTJbE85VE601cG
	+1Hy+gOB3T8z6Cm0GFhTGMd6vnlLhQewfBiwX5M8UAeo+o806qqYzl3miZzxbCXmv1dKno4r3Nr
	KWtuXW9yUrW6nK+B15jTbSLUWuhfia/JRN+MpZURvKXTE+pfWalEtg+OPp/AjC8a2R1NER6SqNA
	FQqeLlUXRJwcaZ2nOH+H0M+R9KfmjWpMN4ykigFnUPkuAWR0P0T1r/8HIZljzNQrNp0ALfL6Qyu
	UPTCRhxIOMB+JJ2DnQQGe8tKODZmV7PimS8eryXN4PbqoakbwlIY0TerASiT5bL0Se1VbMd6aUO
	EfYD1pC7FAEKIFhbEUuvU52IVqTq7DQu4eZUlaUAZCRnX0K9qHHXewOScarsUrsXUNGo3UFvoBW
	+CxQwkny+EcZND2NlJDSuv9g50SFKGUaFzmOfycLIZMGvqNemzwBeZhFmzTAr6dSQLaXVaQi9vZ
	zOXIIFMI1rYO+zBpiNSmE6r+4VZZmm4Nn5pWDx9eYqriqDn+qUEbwo=
X-Received: by 2002:a05:6870:e121:b0:48f:fd06:76c7 with SMTP id 586e51a60fabf-49ddd510ac4mr4912248fac.9.1790865803330;
        Thu, 01 Oct 2026 07:43:23 -0700 (PDT)
Received: from [192.168.2.38] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-49ded14d8a0sm2638009fac.5.2026.10.01.07.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 07:43:22 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jianhao Xu <jianhao.xu@seu.edu.cn>
In-Reply-To: <20260930065951.2932739-1-runyu.xiao@seu.edu.cn>
References: <20260930065951.2932739-1-runyu.xiao@seu.edu.cn>
Subject: Re: [PATCH] block: amiflop: synchronize flush timer before track
 flush
Message-Id: <179086580223.1687323.6325589264595491998.b4-ty@b4>
Date: Thu, 01 Oct 2026 08:43:22 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 30 Sep 2026 14:59:51 +0800, Runyu Xiao wrote:
> The amiflop track buffer is shared with the timer callback. timer_delete()
> does not wait for an in-flight callback, and that callback can rearm itself
> when it cannot acquire the floppy controller. A synchronous track flush can
> therefore race with the callback.
> 
> Stop the timer before synchronous track writes and use timer_delete_sync()
> to wait for any callback already running. Keep callback rearming disabled
> until the write is complete. Apply this to the FDFMTTRK path as well.
> 
> [...]

Applied, thanks!

[1/1] block: amiflop: synchronize flush timer before track flush
      commit: 9690943353cec1690a715e000ba6a74e5139f530

Best regards,
-- 
Jens Axboe



