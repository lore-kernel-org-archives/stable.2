Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A10D3B27E9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731912; cv=pass; b=FMVvVL09HqIVm8sCoIvwbVWBIp1QQCjGrXg/5vmZBr5WHmraM+FBKjiQ6/6XEnkcKH/1koFRc9q/+zTuPTmhcKAdixP4kbzK1IEzIRycrZh0POgsMOmJhLCg5ncb2fBNlrmri8bBOBYxoDANw2N8zrsaKyH2JBnAMFzyGdLnZd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731912; c=relaxed/simple;
	bh=aNXvnIajDX/7w3x9F5uELFST7rm/QC00IWx5n1LjaBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V9devUU2P5OyFmo7tT0fS8yOwXuwj3ygIZxHTP5XZtFIjdCMg8QYLabRSCpGK7nClm1iQ3OcP3D9AiehNSnHKQILgDXsTU36P3Nl1P+889Vskn4Pa1wd01zWwzZ68kkbufNNAIDc4fmXQ8MeWLHcH+uBrc4qUKnSCvub9pAAlkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShIRzkJX; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShIRzkJX"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c82b32121so1120606d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731910; cv=none;
        d=google.com; s=arc-20260327;
        b=mHu3isuGRhGA3RsERt+L5NvbUzh1tUEQ/84+hwAm0k0sEbiM3WMQmodOxz5FqP6Qky
         nXh9Gb2vXZj4OY2BJ/cbpZYg6tTSWGuZpdzqRO964WSnbjF7rU+cN+8cN98o4S6vxCrN
         tMDx4ctA81F+BsuQnkvylYMcXPGAkG3NPsvVONZZY2nvVIt6gKdyU4RC7DfwTk5+Ri6B
         DQ469LfgD1d8GqlngOfd45OLO8NyWkULRoHrBQbsSKl1AHx3+yWEX8Pb9IgPuJ124m0P
         PZ+mNW+m5yRjXHXh4ayXT5qqbjuVHa2h1Bm13yD8PLWo/jZskoq2krbr6N6qZc1wy+/r
         wUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aNXvnIajDX/7w3x9F5uELFST7rm/QC00IWx5n1LjaBY=;
        fh=gIIeyeqXbqXgXA1+s31vQ0ku/Latt5poTMmALdz0sQg=;
        b=HOksCd9c+bpwoTjQlQ9T/RRLjRgGqIfpcL32fQDwbQZ2W+W/YDGilIerLjtOzepTkt
         ieQ0kGXrNBLGOBfazNVrH/TkbzjEb+tC9EDNwXACSK3Kyf6DrEk1V5R5zuAlV+uUhXnw
         +NlErs8vZFHf7qKL+Ti2YJbp/Z9IqMvfw8Cr5qZBjRhBrODJlgp/6z3ZZUee9lXACLb7
         7L+4yzGTX/lw8z9huFgzf22suvxqFocApGL+mSNpI6AxDIR6JMHazTCSjmjdCjbbM8xE
         o5nwN5+BUN/nkwsw1nZvaAe47djtpBzQmKLCFJVsePhzSAQnbCG6VxoQFB+B7/Vj++Uk
         Jysg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731910; x=1788336710; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNXvnIajDX/7w3x9F5uELFST7rm/QC00IWx5n1LjaBY=;
        b=ShIRzkJXNoYaQ5kHVu/9/n0OjHLSLW7Qz+qA+uk4YfOPsiL0IS54j/urbXDeFNBA4R
         82hGD7LlRdBjsnbEvFfNKVA8YWuAxo/HHz86u7jYiJD8jSP6ZtkuVcxS1rg104CeBC5w
         Zb17XJKhjHycC2w87ae9tFSmO5X53Tn5qMaODWVUDXWbzu4rtptC81Yx7K7ACzyvZ08h
         T4il3L4SlemNo5sRZZNf7hsUMInJCs9oRbHewz4ylrYNl4UNsZV4tDm1yx6Wjqn/xteB
         HCHawFrI5Y1p5KtaUyVwqbe/296WtKsW2pRMz5E283cYVM/UVmbM8krOfd9hodMxQwFB
         6/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731910; x=1788336710;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aNXvnIajDX/7w3x9F5uELFST7rm/QC00IWx5n1LjaBY=;
        b=kAm4B4ChRktMaOaJFrgOHu0HpCPgcqbKMo6C9LdGLCYJC37MRDmEzF9GVO72VODEVd
         6oi/2uWLrmkVzTKqKWJ2o4QaTsO4pjCgBMnNG4oUbtI44CLpwVmFYTPaClnLDZeB8fF2
         4wMq4TJurZ1DnEpC4YYuNU1Zqo4jT71Dm2SEmdmEja4p8eqlY+b/lx8X86TiWKpYF2BQ
         x1EUCyO8hz53fk99rsYczjFOprj70Bi0m/VKPgC+iIqI9fPEGHZZMXcwBz5BRJjtOkcI
         qzk9iJIST7C5v6wn3iF6D0GapTD7WTMiintzv/uV14EtSn6INxmnejqPsc6QF+XK5da2
         bdrg==
X-Forwarded-Encrypted: i=1; AHgh+RrRzj7jshxz5TvlXk7FzjVfquP5rAwDxg64XcQmEjCr4oFEP25DzjladYpuCSFmSbW953VgZ7E=@vger.kernel.org
X-Gm-Message-State: AFuF++kWgS03EGykCCcQrPU+ty3P1y+MNUSPxYwtt1g2V7+rFB/nyGDD
	47hANdMoKvc7XBcbeui/WBv2y9aKWAWjQJFJ21745uYy9flsgRI69UsjNyeNjirxAL5ULJKwZoS
	ywFv8Tce+a63/F6OpgSZzIexh/GpV8S0=
X-Gm-Gg: AR+sD13oNCD+ON9J8VItxjDtKioMjm4NIM0Z3OWmra+Nhzh20iLrHNVhcbyIXp7bNX3
	w/M831BjCDbIROP1InfKuPHAfTvIz0lYzA/QBv6ysoDdJNot8JNuj884PMeNSHMv1LQU4Inek+j
	1V6+tqgKmNCT6Qzz1wD98jKX7upKB66x3dkJi6kuxRMeEnReDY9KSKUz881i2glSj8OXJ8u9rnW
	f0aWl4hthiKy4HuMR/t/QtT/BtKXqy2XzMZxH5iWRvSbHVs+EUJee6qiQ70eEeRRlVQ5H4n87vs
	hMIIJx67mvWNozYbXdlnWv4MFTCJvgHdNzctHIz7Fl8olIQ=
X-Received: by 2002:a05:690e:1188:b0:66d:149e:a901 with SMTP id
 956f58d0204a3-66d256c264dmr1479589d50.21.1787731905567; Wed, 26 Aug 2026
 01:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808105657.2762974-1-lgs201920130244@gmail.com> <3ae8e5d0-4677-48de-bd2a-3315f99650c2@kernel.org>
In-Reply-To: <3ae8e5d0-4677-48de-bd2a-3315f99650c2@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:11:33 +0800
X-Gm-Features: AcwNN1X38av1r3fQHAr6_E215JsX9BX5UoU7-6ID8IrKi7kZhsgC4YYykT0ACvY
Message-ID: <CANUHTR9GnWwDbPK-Hmnc8TY1Hrn5tnV81ytb=wpxogCZY9XTNw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: fix autosuspend cleanup on probe failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Srinidh Kasagar <srinidhi.kasagar@stericsson.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Dan Williams <djbw@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:50, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 12:56, Guangshuo Li wrote:
> > d40_probe() calls pm_runtime_use_autosuspend(), but its error path does
> > not call the matching pm_runtime_dont_use_autosuspend() before
> > disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during cleanup, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call to the probe
> > failure path before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 8d318a50b3d7 ("DMAENGINE: Support for ST-Ericssons DMA40 block v3")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
