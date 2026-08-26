Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D573B71A6
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731422; cv=pass; b=m+geJOHGLctzwM+UwDqqK2BcxsKvaVkZlyT5od2sIaL3mMuUO+WLGuW3lSphPGfD6r2K/AUyrTI/2ErXfUgers2NRpcYHi55qnG+0iuFIEsR44h4lpz+SsJKLaBsMZz3kliM4TN6mXBWc06OgeiB7aMQN3fmtYldqVKAnu2GahI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731422; c=relaxed/simple;
	bh=TGWXhg3kIFRbogyDdU2TFv0HSJZmOgnoG5WYlfdiuIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rUnvIRUdKmpV521NhZ8qxLeI1Didr8+wm9y7noFrt3sbDBKBDrArEu67hUqV7IlXp2S+csAErgua2kNM23nazsac3sGkG7SnU+vXrLzuPQ4m52NEXJ+3fNuZAhyjgoreTNLXheHieSES9SOlk+XnMq6WlAoE3bqm1Wzl42IRwE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhKm+q3G; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhKm+q3G"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-66c744a00edso539820d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:03:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731418; cv=none;
        d=google.com; s=arc-20260327;
        b=B0tUIv1aWao/bGvQUO923ZzPxP8NOKRwfcoQqd09ycotO1S9bpedvIKrvHyhHF2QpA
         rIbC7hvnBOTAgkVElLgWr+/Hl7sQgH5Q9ybnXVzbDx5L4FuhodnOP7VwiiRdnGVVXQ+p
         IPXE4Db0QKBZlUnS65S4jB64oGjjJJxFPl1SIlVtapyuXrgNv7a2FrmzsZi4bB+nX8Hx
         m4gC9OiHp2mnpyybHSx0KeA6lmTzHhRngLeJl1d5F0KeOS+So+2JsWDyFay5b34B35EB
         C7WXlPKE0raQDu/jF63WrqYZLWBBDPBcWZDoPjjaueLQOfKMCkla0KtsWf1zhPiXmSO6
         JHWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TGWXhg3kIFRbogyDdU2TFv0HSJZmOgnoG5WYlfdiuIY=;
        fh=d4bjS+ar0pCogqtCnM1XqO1oSKLJ1KOesBx89TH11Ps=;
        b=ZM5SEwbMfUNWycck4/XQiW6xkyHX3+22HMkqLhvxiLCqqnsHfO2IepGlNSdWJcWr6e
         GWJeAvZBszlo21tFKtmluK0JAEDQk26mOqIUitBGj8PRlF3WKFkpQb2/fzXHNpbCniKt
         /4w8G8TPtlVOZXOXc0xlyRkpRjcBWeGdAxLkI21fabJ3x5uy4KNx7bfRqKVV7a2PGBOh
         L3tWhSDhyhzqN/dOrQXPmMU6yjhmWlywmotqyaIMZaQ/Tflnba5gHwm3lB7UdXjtbmzN
         6Pif7krJMAYXJyvwMB94ce9wK07Yio0W7owP4cBhwV/t3Gc9Zkhfp5U3iVKbVNOqC3LI
         tAlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731418; x=1788336218; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGWXhg3kIFRbogyDdU2TFv0HSJZmOgnoG5WYlfdiuIY=;
        b=qhKm+q3Gihr2fe9cUKB15n1/234rKzy0OXluD3uGVnPpz05VPixI5TYD4jYKC4qc4C
         kNFPqtSXVqExND+j6EDgkhYVuKClczeJLkxfN3gEilvxss66lwWfM2cRdijfFO6AR+W3
         LuNKQsUExbzj/PeAqciqGXLuWqDZ4Fe1ztZ/6xDYZDlP8ny9eeGH+KgpOhMh/O2RZewS
         tjeEHTX5+nn0gw/PfSaC8S2OG3Vn4bYFKJ/Q7HAq/n98M0BR0bVgJn+yuIpBHHSdoESI
         twquvNRoYCz/m1IFRe3U+O+UTu9JnUYBnLI6zOvNjZWPoz74FtkxCp23bPGzpTv+RoYV
         OiWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731418; x=1788336218;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TGWXhg3kIFRbogyDdU2TFv0HSJZmOgnoG5WYlfdiuIY=;
        b=f8bRWYXHbB956QFKgigXFp391iKQxlSxsM2NWwn8/VzAn7PGpB8epSkvg5bRT7k/Dy
         omKHuse6tzXQCyjB5u5xyZXMd+f0S7VypW03nAHpZPFhkphAPkfJ1fEJA7V9VqXahhsO
         gnPKgVVOqeq8PjmgPt5T1gZWkPUz+nlLu8ngW/w8ATk8NNVCsZhhljUM+Th6fDQCtTR0
         ZcBl5sfEyKhaE6oSKoe93uejTMXel29Jcb7ed0oSuU9VRfNC+0j3LksUhJdmA97NjSkY
         XpVd6JcGRRUMIaPuHtsWCc3btDnI2/R1t3Ujtde3XsUMmyBifr+RpqT4qksU+P3YLSf/
         c9FA==
X-Forwarded-Encrypted: i=1; AHgh+RrDh+qJ0AmrbUgwUtdBpIQhWRwskOnBsykb9urzT/FDObj+6iulgViEYEGz0cUFML2l/+9ofLo=@vger.kernel.org
X-Gm-Message-State: AFuF++mq36p0eHtH00z6mWLzlU7glQtsVrgTFPlA0jGme+akF7bROUbD
	DeswP14jSCCKHKrAhIh9Vb6MxueGZcbQJcS56RIQJm/7NqpKqYv8ELqjASwvkrhtOHYdO4rwtjM
	bBkwEfViCn/3ghmbjYu8nqvzNvsdkXr8=
X-Gm-Gg: AR+sD10wivT9KQGCJTYU4SoAgI8S6NudFmVwufuerdpvacPaiJjwLzD1blrlnwNQ6a1
	NNi3k92sYUDv/e5IgJlFg8c9eFx1Cy2AvGhgdBup0R+d5N+1ACgfwIWRaoV2LaDKElPn6h+x8xO
	0FT6JBBSlL9q8r+Er2Z3bbBvbDQF2nOPOVQe4bpJ6gJb1ONaHsqTZNCp+2wNpUMC9tXlPN6cUOi
	r0OmgAXs3C3qyB6vS/iYjTZDWRzlGoxs1D9YTV9c3IyiHKeiq9Et6ZiSU++xdu7Zit3q4PLdem3
	V2MO/HmZitvVlwDqQPRZMr0jI1Tm/fDTXleZ6sAsQeVh7GY=
X-Received: by 2002:a05:690e:1516:b0:66c:e3b9:f696 with SMTP id
 956f58d0204a3-66d257ea066mr1655899d50.48.1787731418010; Wed, 26 Aug 2026
 01:03:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808112551.2786782-1-lgs201920130244@gmail.com> <578653c4-a7c7-498b-a283-f3b17f3d4191@kernel.org>
In-Reply-To: <578653c4-a7c7-498b-a283-f3b17f3d4191@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:03:25 +0800
X-Gm-Features: AcwNN1XeMS8Nn9F7_AMg2pV323zlKWTVjDvTMsgkH5LpvJ4tmdamIR4FLSMBfwI
Message-ID: <CANUHTR-xZpWYjsCAXCe+uRyJS5zuafsxpm7fNO09xRo-LK7jMQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom: hidma: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sinan Kaya <okaya@kernel.org>, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 13:25, Guangshuo Li wrote:
> > hidma_probe() calls pm_runtime_use_autosuspend(), but neither the probe
> > failure path nor hidma_remove() calls the matching
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
> > Fixes: 67a2003e0607 ("dmaengine: add Qualcomm Technologies HIDMA channel driver")
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
