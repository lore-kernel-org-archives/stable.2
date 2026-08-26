Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BFC3B71B7
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731459; cv=pass; b=eGhrWfqdG1I6Yrlfed9xqzNb9xnglE9ZcUpQ2LvxKh9WVEZV3TaqhlukNO//AlC+6vhwinWFApqRPBtMOcZGNnqUZPZdY55LXA5eSE2jszyL12OcCVI1RVdPsSav0ZVYNShM/mNyrGlmwbG6nfgKLJa7P5dvw30a6Jaj3rR4kRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731459; c=relaxed/simple;
	bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pzWMcamxnPd3zGksS1+SuVKU+W+zKdH8+tGWHWjyQiDjtZNRijIYV0aaUeIqNwEWXVrgHhzBvoJl4pDvzSNAhLU5a00+pU9kX1QdxhKGna3ti1E6E98yyW3FgYsYWYvffXyBx6pZLfdwAZz2gMdBXxIs4NRKOMBHpJ6eEA3oKVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fB5TxhS6; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fB5TxhS6"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66c82b32121so1110570d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:04:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731456; cv=none;
        d=google.com; s=arc-20260327;
        b=NNjDApKoW8C3t6tpOYOAuAohG50JVWjfx5j/rBYJTNHIW1Mg1tT3iOKr/IngK68ywe
         FKehaM/v9nmU6zFzZCeJLqoZ0nniljmeCkyvCfdrIyrgE+/5uek8zoFrO/LZRnEPdd8C
         WhyKj1+rqSUEq5ryuPLA6aRqa1rjbT/A2G30RmuGRD9/A3LBv+uV6RImw5u+yr3093do
         A0PqedFVUdIZtGxFZitzndQyfaDCHtMsoJx0KWyXO6RgczwcJcoEAOngmvNIBd83OKXB
         ONDLAhEoEYCLvY9a2nWq8Sw4ytLeZ4y4q6h89Qf7ySAVZnI8GKszZ7ghDkYT1XHZJRF0
         L0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        fh=gSTMDEKe/t1UMSZTAIJJ65Z+BQsFpL7/vDDnuA2dpQM=;
        b=mbaxEeUAU2GrTO1ZdV2Z/T/UFXEFp6DewsEpRqI9y77+Qappshf8h+iHVc/12qOGiS
         lklcDg6mXvMOZMD+JB7AuMMJxnfomh5UQU8HXqyVTgFMn0Xke4eqAcWveY/0gBTyN5wu
         mH11GfVg4vbPkkipiVfBBt4aoiMpv8QFM2Otl6h24v2vP2984d3ldF6iC/igAigybB+U
         +NPKwcdus9tI9pbPI6faDlGCYmVNAaD/8vlN/GMY0708qFqJdv1AYLPhyoDj8AjNXI+Z
         9TKwrgAQ6GJw6gJwh049EQiYIkJ4w4PFKKc2H+7CJGlunqktHpLkWCcUZRCkIFyaCdFa
         F8sA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731456; x=1788336256; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        b=fB5TxhS65xz708KQVMljrC1emhQwLXzArjVEzxDLcRCUjsNt+pW4uWKW1I3GsdRu9d
         hjKXzwNcqKXLjTwq5OVjPcbJR//6rNHuNXlXnAhU3RHqZV0jESIA+A6t5g1gfZFV5N0m
         4sJAniOV/Y/4pj2DiDqQ1folhk/9654BLHYV5j85KI6YQKV/hhvLbGtYYxMYHvWAArRL
         ZjIoSt95cAP3HsfEhIsOYYdT0FLnUsa7xSsgYb+L8bAjk1EKmIQ8mzIWqk6XFFqJyIDO
         6Wrccod3Yl/TYE9p2k9JcjFKZvq5aCtvhwo5+Mws2BrkqrUMUd9Lw3hbuYcubLYSM4CE
         bCRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731456; x=1788336256;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qrqtL/BsYInvu4iu0wA+F970KXoh6jf8+iEGpJ3PU+A=;
        b=RgsKN8NS62VfAbAKLq2b7bF9thaH6hgmnvvE8KO6RJj4yOhw9ghwB1q8+mi1UgocxW
         mtlhpGBbE4Lg/hmhB7Zf1niKUW54CTeOudMSvMSHTZLCDTbYoMjISCcSuJFhRD/5sdEF
         SfW1W3lSHt158pdiU9gI53b2tAe3lpb/EnrsCCEVhv5vB7jgHERsO0advMPqni/a3R0c
         kGfXRxLCCUv6OjGBRAxMNSRL1oC7QbbVeVc3T7MKqG/15jxjCKhv7T+IDcC18CXPfbei
         nh2/BDt/fGM5kBeCdFyNn/OEhKRMsD54VIPIM66Xr6YqwapWz0Th0YFxBvn0BI5j8D0p
         tOcQ==
X-Forwarded-Encrypted: i=1; AHgh+RrHHG4Jk1IvmlzN4NmfsCVfWcdgwzxfhVcg9CYXqMeuksYPEHhdAvX4hAG9g79Y9lgljf40GPc=@vger.kernel.org
X-Gm-Message-State: AFuF++lFTiP+dmhGV8osc6ofJ9mrwo4q3MrqF4VH8mC3rkztaGYZ9epu
	KqkDZJOcY6QvRVrNDVlcjBZBZKBgKvW0xLCHAN0lHG4FxTjNroAjX3rqzyvdmLFdiFZ1D6eTgYG
	hPjLONSZX1d8pm8c4L4C7bEAv/8NaySs=
X-Gm-Gg: AR+sD109cPoAHOSuhxzq2TzOP9Es86fxlhHBVgH+QQbcWA/HmJMbfSfAMa2Wfmp969V
	EI8jhEpEWz2MwqaUQQ+7x4VdhOhpairTdtyKNN2e8R1Dr2IvsE4vIY22kjukw99uqZoCEE4fKBN
	Nt/PWFVR49ToRF+QMLIQO6pCl9lcjBzS4+KkRcHXEXPDNKBCZozJiaOeTg2kBRTqkM29iGMNcef
	iZX0mYO+29CLXWXXefzW7YOpPtEdxyhN8TyksXAE2EB/kvAGhGMWIMjOmN4tv7Q1lm1E0NJiMhS
	BHgiNsPSCRUcRY5V9hgdHjlYe8Jm+KlXoTtMo0cj8Ww7EyU=
X-Received: by 2002:a05:690e:4147:b0:66c:7dee:aa64 with SMTP id
 956f58d0204a3-66d2565d769mr1316085d50.4.1787731456528; Wed, 26 Aug 2026
 01:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260812092322.3423217-1-lgs201920130244@gmail.com> <c2434012-7bcb-42fc-b520-8fbc71db196f@kernel.org>
In-Reply-To: <c2434012-7bcb-42fc-b520-8fbc71db196f@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:04:04 +0800
X-Gm-Features: AcwNN1UUkOd0ofctlZQa_UPVnhnAktZX_7rWwJDJ4MDJ_lmFWo9NXdickmLMju0
Message-ID: <CANUHTR9LDcnLh_gw4TQULZcBoiK8W+Y+eS0h9=Bh_4yrzzD2+A@mail.gmail.com>
Subject: Re: [PATCH] i2c: nvidia-gpu: fix autosuspend cleanup
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ajay Gupta <ajayg@nvidia.com>, Andi Shyti <andi.shyti@kernel.org>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/08/2026 11:23, Guangshuo Li wrote:
> > gpu_i2c_probe() calls pm_runtime_use_autosuspend(), but the remove
> > path does not call the matching pm_runtime_dont_use_autosuspend().
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without undoing the autosuspend setting during
> > teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Call pm_runtime_dont_use_autosuspend() during driver removal to
> > properly undo the autosuspend setting.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: d4a4f927e4dd ("i2c: nvidia-gpu: add runtime pm support")
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
