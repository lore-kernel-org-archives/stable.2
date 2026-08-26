Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707723B6C1D
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731480; cv=pass; b=YYBYb59eYudP2nkpb6GPQFzDJ9g7CVQhOQb7j9vsOUGqc6kOSHBt+WM1H5+AGTocGgSpFTF3GvFj3DFpDcADl5Rw5ep350hW/w+R+ndut0UNdV2Q6GdqXm3c1OW8rD6nRuwB/57x3kxmJ9MuqTF3gE2jnYAbeJ4pHRqGTBBxsNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731480; c=relaxed/simple;
	bh=gljENqI22pecVC7PFj3mqQuHtHE6FZCK6uxJWQ0B0nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gO36CORN3RFkwSvsASXROTbN90kImz8F0D7+NvRKx+kNXPaGd0j2G9EdE1WJg6IS6YOjKd9pm/5o4iApku6avAi/+CyLEDb0z4SJz1xlik/O/XoK8t+3BJZkNA119yzho5WVW8fa8g13FTWoXGDZ1dlapU8fYmfOpaKA2twPhX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JZzpKw+A; arc=pass smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JZzpKw+A"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-66d1663c00dso554065d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:04:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731477; cv=none;
        d=google.com; s=arc-20260327;
        b=ZmZaIR9Y+yFaqDej8AFa7DD6kw1KYmy3/oTceqlQdj+ROcClG+KBDPP1DbaUk+k272
         kVBxgwN/G09v5UginiLUZwp42xoI1rcg1/RKmb/3eMWbvGD0zMBD12vK5C3mtreNgqHs
         WVyHEK1vikXC/s54wwqz7w2puPtTHFS7BWgZQyaL2CJ7DHQ+EKXTMo7scgTbmBKM3oqC
         UE+yKEzBZJ+R7FNxIHc5E7eu8a58Uf2txmn6+fnZdfpr/PMvpb/PYBvYJSvLhb4Ljg1w
         VBv1HKO2O+RPbj+u2wjpWyn08A/5V++wG76mYz557o3jsdT55QGUG9gx395cGWhq985X
         vzMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gljENqI22pecVC7PFj3mqQuHtHE6FZCK6uxJWQ0B0nc=;
        fh=zkfzQ6QdcdhL8WwG3HtYJ6EXvXlsknTocyl/ELZ2Yhg=;
        b=JnUXpe7pw8Zez+bhHLWtWwZUys5BJ6wNCOd4LiMgMTql/D1UVNt0AuuA03axAfl8Cs
         eeL7LFduxNPm0w7lnrdd/BFVJ3HIaB1PfjwXMpLPMFg9hUOf0ByDUMJHsIrjx2+QYHhF
         27wBCYNjdsczJf6evzAfkYiEo63LZBNoGf+wmBdjxVKjWzku5zsbz2fp7KNbaHWNHnv+
         VMbR18amDpRL47WDemkWoZ2CHbewryd5+jXdOPXReci3gdZw3mqT2FGPb5QUtW4ggTJQ
         0JFzMFOvfLYbdw2s/z/L74kNtVaHoILWDtiN3oqKaGPRYTiw9caO7BYbUomelBqdlzng
         +ZLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731477; x=1788336277; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gljENqI22pecVC7PFj3mqQuHtHE6FZCK6uxJWQ0B0nc=;
        b=JZzpKw+AAPBmuxuCaGpy4CXoHmxkNgbKRfGxEHGIQgnR2E+xFmaLtyEaGqKB2i2YYt
         AF8XIOQlvTZ584+HN+d52SEVrzy/479qIC0/T8ms+eWWuXsdlof3Qe4NcT4mIBb6dVJ+
         Qo1mh96rwtVLvmOuk/MArJ2NvEscDFhV8jZOhXSmzw7uwUkM7znw94N+tiOU4npRJGXp
         s3mZpPn/L2cNRtVEbDZIbJxQIOoZTPfi6RPES7Pik4NsBvxJAp0DcdEPUokKYUgMg7zT
         is8TrdNKOK7OcEpSm9tWvQg8WYdF4WFsvuyfGNHBiELmj+2+/pEpCpfh0bLtfti8b8gn
         pNHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731477; x=1788336277;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gljENqI22pecVC7PFj3mqQuHtHE6FZCK6uxJWQ0B0nc=;
        b=Q0ze5+7ESmUlaXxcgxnFRJAVCZ/xcTgOdSPmLr3zuE2sfnhFTRpYPgYyawmq+ETqzE
         R04aJ+7xIeiAC3sCY0SzosL1xzsI3Ie6v047NMpxj6xWlJGUBde3Jm9IF/1Goc+kACji
         W8PERJPSFu+CeyNy/1EBxB6ALmZPJJb1ivKqJR0MuKOsacPTiRQ4vE4zF9HRBYuEieE9
         D0h1FpKSnFLNy2QgvHpFnO9pa1I51TPUF7s3Ak+dauyb+n0oBrPLe6ZI+9CDSIJqLFkW
         CiP0saZm1hLF13bGHJD4knURCXZTvcLGAyjPUHX7GIoB8P141Z5b9N1GefcAVb0G7oiL
         6XoA==
X-Forwarded-Encrypted: i=1; AHgh+RpROwCq9qptI3g0ZTSYqXx1YXp8ptpXUUcFrTdh+FUTL9wvZlx8CRP6V985Pn0mPRUIG9T/4jM=@vger.kernel.org
X-Gm-Message-State: AFuF++mMkziNBIPOi4pB2BT4QDVxdUW7jv2/qmwsl86BgCThCI2lJMC8
	6ub+A7QA0beMBBpcyPnG+dvONlRTKtlr0ZNTPYoyjKP2PxuLWZwpr6I2Cj5/TvGUTbkugOiXGfe
	x/AigSaR2iDRUlz3T1FPfn6nJGxxyCDw=
X-Gm-Gg: AR+sD10VT2XPLRZmfC6IEGqsnOF1h2QwosYicncHYxjDvP03jZXSbH6cRNkgHLT/xtY
	JqpdjPknrIQ4OR8fqTGRmYqftg7vFG1qiDNixSueAF63lD1HdWf6EjHpNahO+F+bM3hQ7UAnMng
	sKh1doIFi/dJWfagWqUX8omY/TbcBSpU0iGdlg53l3GxKk4Vzkl5Dkr/iSaAIpA+79W4F5TDO61
	H9qQj96ychwTSRmbWayYni7wGCAWHR/75m7y93JtHeYmJeLp1XuY8VKzGR337qzIVUZL6WTb3gv
	xrXRExYmA2O8db8ZVXSaAKjQNXcR4JFs4yA4QId63SXl270=
X-Received: by 2002:a53:ac9c:0:b0:668:9fa5:b9cc with SMTP id
 956f58d0204a3-66d2551013fmr1633452d50.0.1787731477460; Wed, 26 Aug 2026
 01:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808073748.2649808-1-lgs201920130244@gmail.com> <9e6142fb-bb69-459b-b7e7-4aaf2bbc3bc4@kernel.org>
In-Reply-To: <9e6142fb-bb69-459b-b7e7-4aaf2bbc3bc4@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:04:24 +0800
X-Gm-Features: AcwNN1WTArxH-Wd9ybxPgMiQ8kdpjWn5ZJku5MGMoyUD_P2LJqYmH3XojzLPzC0
Message-ID: <CANUHTR-Kqb+fw1EfPoD5W4SMYR6euBcy47jfGVYF0P0y7gfVtQ@mail.gmail.com>
Subject: Re: [PATCH] hwrng: npcm: fix usage_count leak when autosuspend_delay
 is negative
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>, Avi Fishman <avifishman70@gmail.com>, 
	Tomer Maimon <tmaimon77@gmail.com>, Tali Perry <tali.perry1@gmail.com>, 
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>, 
	Benjamin Fair <benjaminfair@google.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Daniel Thompson <danielt@kernel.org>, 
	openbmc@lists.ozlabs.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:49, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 09:37, Guangshuo Li wrote:
> > npcm_rng_probe() calls pm_runtime_use_autosuspend(), but neither the
> > probe failure path nor npcm_rng_remove() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and remove paths before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: c98429297d8b ("hwrng: npcm - add NPCM RNG driver")
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
