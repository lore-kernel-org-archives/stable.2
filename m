Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2253AFD0C
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786355003; cv=none; b=L0iwJE7BSP8/+t6MvWRvB6+d8gwtPyvydYcgt4lJKfbAfQ/n/yt8GFUPqv12l733DCXfF1+7kxi4707kvGOyL3yXAe/qzK7Af8nSjdzzu5DL14swob2QBFXpFlEJ8y7VUiLJY4a6gBNlKxqpZAx37z6A5MyIyLXGYlhooBroVVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786355003; c=relaxed/simple;
	bh=GU3cyX8C2ifr6yqKgZoZDnHQeYRKrmG0+ikoVMl1HGo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LAiYY1QSkbpT7oFCIvZcQE9t9GSQsup+WBI9OkmR5PPfsp9Llls7a4bCwfEBcw1eKfJckHdh7QnRPy2P1WRxq/abmvjXBeiQ5UIK4eHFf9ika6IXAJcL0kQ8Loc8Dgt8NJq3jFkBaWIAXaTTMp3EeCze+5l0wbTdBbLGIqO1Hz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFbirveO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFbirveO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C81511F00ADE
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 09:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786355001;
	bh=GU3cyX8C2ifr6yqKgZoZDnHQeYRKrmG0+ikoVMl1HGo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=MFbirveORxuGsdhASo6iu1j0J9YtR1zCHeB145Semvr4yhW9ND7IRT2+0ddIWGD0U
	 mZ2VCG5GxpJ9cSdQkELvLW5LHS2rx53UdKC2wpMUCsSfa8dBVVEHYm1Z3U50oTKSxY
	 vdGu+wWonYH6ETHV+XfElnwa5r5yl/DraqcdwOrKSzVrXbDr6/Kt6+RahJK9vnzMJq
	 83/exrMK4dbgnr628h9qzsgqIREPzxbquIcjRSAxD+DdjW9d7aqEEmcW6nugVpDuSl
	 COUSntVxoOcp/57lO6AXW+IQnoOvrltqzFEELXtlymEQol1vIjeB7kIfihvTHI9Q+h
	 JT6WK4QVRhl0A==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0231a3e86so1558888e87.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 02:43:21 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtewsMqPQ0yIfNNVaauAT93hT4e29/ZT/hjEH4ntPp91Y5bumV
	/aetfuL5cWsrwVZ+aoo1jaSgEeLPiEoHRSVV5Ksjix8H0x85S5ICNz5BSN2CRR7x7JBMfj92p0N
	6KdQYNS7vCqKsTe+eJrxboHcAtMDkwcYfIimVOrqKTg==
X-Received: by 2002:a05:6512:1599:b0:5b3:e52:9ff7 with SMTP id
 2adb3069b0e04-5b30e52a216mr1879705e87.51.1786355000515; Mon, 10 Aug 2026
 02:43:20 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 09:43:19 +0000
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 10 Aug 2026 09:43:19 +0000
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260808110642.2770355-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808110642.2770355-1-lgs201920130244@gmail.com>
Date: Mon, 10 Aug 2026 09:43:19 +0000
X-Gmail-Original-Message-ID: <CAMRc=McvRCX9jogG-qAuVnqb3=SukzTc54+iRRsojWOL_k1P3g@mail.gmail.com>
X-Gm-Features: AUfX_mxfC18jKqTRVYMFhmThw-mQt0wiGItMAY86S1ADQObHNXGQ5nFShXyCT4Q
Message-ID: <CAMRc=McvRCX9jogG-qAuVnqb3=SukzTc54+iRRsojWOL_k1P3g@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, Pramod Gurav <pramod.gurav@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 8 Aug 2026 13:06:42 +0200, Guangshuo Li
<lgs201920130244@gmail.com> said:
> bam_dma_probe() calls pm_runtime_use_autosuspend(), but
> bam_dma_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() when removing the device.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
>
> Add the missing pm_runtime_dont_use_autosuspend() call before forcing
> the device into runtime suspend during removal.
>
> This issue was found by manual code inspection.
>
> Fixes: 7d2545599f5b ("dmaengine: qcom-bam-dma: Add pm_runtime support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
