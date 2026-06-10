Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823B63E123C
	for <stable@vger.kernel.org>; Wed, 10 Jun 2026 10:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089117; cv=pass; b=ZlrUgExjtN6VkkVGAPTqH7AERnFUhUZLvwIZVNq1mkwENOu9cVBSgoHdok5wplmrB3qJjcSM9w5Q0bZ6odAevvtLPWdgJlYoIeBRDd5XwAp6W8Ybdxdu/B6tituyb4Lq6S/N3sRAWUKfrVC2X7otj/Fdb07XGUHgTy0ssL1keAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089117; c=relaxed/simple;
	bh=IsH/o3sokzqOos212l12PDYiFKlklnRFmICJnS027rw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YjjRg5d7mcGDBo6kYb63B7Fwv1y0Hd5dM/JyG1sVnezHZ6/kc+VhsDxLQeZ3/5XjyJCJ9jp48FWfKO2G2l0h1gZfuclYRTD9gesWxNhFMVCxqlVdgUNyDeUI9VaMBBM1QgFm99cWVLhGHxxDK613+7VIb4bJyIcolYhyprmA8j8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r7rIU4FO; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r7rIU4FO"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so13027451a12.1
        for <stable@vger.kernel.org>; Wed, 10 Jun 2026 03:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781089110; cv=none;
        d=google.com; s=arc-20240605;
        b=QKJHh7OIARETvk6t111jAr4nnONq8c4nthWzGavc7cGNyYp8NTG5FvTC14O1wEN7J+
         NrqjNEXmoPWSBRv/qHZzMQkYhNVtT48O4Y/sgMA5r+Ysf9nAGmTW4+KzSAmI6hzz3gRe
         5XA+R+xji5b4IIlJANw4wIak5QPEFuLgxR1f4E/3opqFXg+MzN9xXFW3cvC2l+Q6qAmz
         Sza3kBHzzuZMWDnaPb0jnLl8RebHDNreIR5Ydcqd6MzvIk4ItwJB0uigNRdGacdP2aUT
         HF4eTCChLAKhYJRL2tjVfes6Vg92vaDW4uEfALgTwBKrpuzpyW+ovUTXkmylpQYl1g1X
         qvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=CZevPFZWYMUUhq47/UQyoxjI9SWdGG7Ind6IJjxpI3Y=;
        fh=zNRVzY9US4fz6qKqgWIWIT7OV85IagZ4yLjr4uFpTx4=;
        b=MFer1fLiQ7NvKmgdLnyRkZZLUrCzpo77FVfffqpoLYxz0Vyf4dzPvaI0SoAvwVov5L
         MNhiV+6aDefnLDsDYOllTwE7JaprKOfpYFB312ZxsDlw1NzPU1YIDZ/xXA8C6sButmU5
         a2WH6U+3PnwnDWaOtjC33t0tGfOqiKlEM3DfG8Z3DOu+XsHCv5NxHF04DHLqzUOpbPhW
         0Q1EafY3Qc7Omx4T2s1lQHali1WTKNhrkWJM8jWAikwSrZYLgyR32sEVWpB9EosYj2ho
         gsx63dsdIFCxFSRAuTFyGRY2TAjYL3GYGUHVrbsN95JTR3gH6G2emFFPS43bkjOZU6aA
         WrcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781089110; x=1781693910; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CZevPFZWYMUUhq47/UQyoxjI9SWdGG7Ind6IJjxpI3Y=;
        b=r7rIU4FOd7qobXnqxhwQnjMwuijY0UTSRUt+Q80H+ICNXeK6ut2PpyNgZvjutvci2W
         4kNIt8pWtdJlAEwDffMehiElVm3t4JFVd73zR1eGXFMSh4V+wvwzueV3nDVx0R0wvfcy
         KpLjvp2yihv/pSGFKcbNmiu7IxkFT+vG8rZgrMxQdpuJuwHfE6IL+ZUGNkD+rfvNTGL/
         Y9HkI8nFqEFmT9W4vcDPErSuU1DepSIq51I0u256eVvecnL8N5q1fzNHatTnLX/mGaQA
         SPTcBl19eb1R1SW8+wurKGUVunm4bG0DwYV5s8AYPzM/bNs4/M592hr6Av8CdD0w+uUx
         FvCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089110; x=1781693910;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZevPFZWYMUUhq47/UQyoxjI9SWdGG7Ind6IJjxpI3Y=;
        b=KHu9D11XPMoiVAqS1f27xX1WED/qnGr+txbFFM/61yf0ELAhmLwa3ar03ZP6NRjTeP
         KP0isIl4yE2KPJTcNP/JoPKeDPPtqs/8TeOp4rFSwj2fThw7CYxLE2Vxv2t5dNfVaKZF
         kA+t/PO7kuWU87vMrFzOaqPrpU/+mjAi2raGWCYA/1IdGevYZjI8DvKGSQRJOj6tlk8H
         tdEwV3dmdllSttNXWru6k0CEOyfV5JnjnrxsL7P340fPSapxgERDKFbN2Rs+ivwbPw8V
         +4561Gc4s/G8KkrU6AvC08wyCAdux63vw0r+yl4NNVvEOncrTninQrxb6ymN07D4HwGz
         857A==
X-Forwarded-Encrypted: i=1; AFNElJ+jkcUXjyfe+bj3UY8Rxuz1un8innFB8y5QjpTZcML3YRU9rFzFYI4ENdPMpcd6mtfMWp4xi8w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5mDBotDw/jAz/eJif9CEimtHq/dhP/QbwQL/I2XaVW4cPcJC5
	uwJ0nMqTwnXJ5DD4kOV9IN0tLa6G/SmOHDFLFmT2b7BGOLiPrxVYSxhLlb/w4X9uhhU+gNdbRy5
	i2b9n6cDOvfvWleSYn/6oGLhRBvHjSxo+MvU4iIuTBQ==
X-Gm-Gg: Acq92OHO/0T8vo7bLLFr8msseEjp7xq58ktTOjU07uTvq6wyReVJddape8pR++rTJwL
	h5ZvbS4DIrK33pkX83NnNM3xreT9KrAuSYopjGxLoOntSlLb/vSV3tAu5tML5p1ZAjvI+nB5/Hw
	0pzfbR//XLwEEWF64Z/SD1UyttbjWSwoRmDdq+Yb5l7TSaSvUUc1R5VDAIRVHUsK3KDQbD3eb+A
	BZ3rJTHF3DJvu3f1pBx4pUfSe7yXMOKKNA2gzmPUsNf4f1H7ejHEjh0SHBdT3jjdYVWM5wBz4iw
	F/QNwCiKE3xti3sGh7FFQc2ArYQLa2pMGj5K3r1tTWEkbVZJ0vvp
X-Received: by 2002:a05:6402:3711:b0:691:ad29:ea20 with SMTP id
 4fb4d7f45d1cf-691ad29ec32mr8237260a12.14.1781089109643; Wed, 10 Jun 2026
 03:58:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-0-0cd05c81a82d@linaro.org>
 <20260605-exynos-pmu-cpuhp-idle-fixes-v1-2-0cd05c81a82d@linaro.org>
In-Reply-To: <20260605-exynos-pmu-cpuhp-idle-fixes-v1-2-0cd05c81a82d@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 10 Jun 2026 11:58:18 +0100
X-Gm-Features: AVVi8Cc8CtqeDsBexbU73aNUL0ZdHbMknGnH8Y2ORIFe_Si6C0zGr-kM3HOWHug
Message-ID: <CADrjBPoHhiNTfBsEam+=AWVc03mbQt+E6gm5Dw0fo=pH-w4Uuw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: samsung: exynos-pmu: fix use-after-free of
 interrupt generator node
To: Alexey Klimov <alexey.klimov@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Sam Protsenko <semen.protsenko@linaro.org>, linux-samsung-soc@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Alexey,

Thanks for your patch.

On Fri, 5 Jun 2026 at 21:19, Alexey Klimov <alexey.klimov@linaro.org> wrote:
>
> The setup_cpuhp_and_cpuidle() parses the device tree node for the
> interrupt generation block via of_parse_phandle() and decrements its
> reference count using of_node_put() immediately after fetching the resource
> address. However, later the intr_gen_node pointer is passed into
> of_syscon_register_regmap().
>
> Fix this by moving the of_node_put() invocation to after the
> of_syscon_register_regmap() call, and adding it to correct error paths.

I think  using
__free(device_node) = of_parse_phandle

would be a cleaner/simpler fix.

Peter




Peter.

>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://sashiko.dev/#/patchset/20260513-exynos850-cpuhotplug-v4-0-54fec5f65362@linaro.org?part=3
> Fixes: 78b72897a5c8 ("soc: samsung: exynos-pmu: Enable CPU Idle for gs101")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
> ---
>  drivers/soc/samsung/exynos-pmu.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> index 6e635872247a..9636287f6794 100644
> --- a/drivers/soc/samsung/exynos-pmu.c
> +++ b/drivers/soc/samsung/exynos-pmu.c
> @@ -428,23 +428,30 @@ static int setup_cpuhp_and_cpuidle(struct device *dev)
>          * syscon provided regmap.
>          */
>         ret = of_address_to_resource(intr_gen_node, 0, &intrgen_res);
> -       of_node_put(intr_gen_node);
> +       if (ret) {
> +               of_node_put(intr_gen_node);
> +               return ret;
> +       }
>
>         virt_addr = devm_ioremap(dev, intrgen_res.start,
>                                  resource_size(&intrgen_res));
> -       if (!virt_addr)
> +       if (!virt_addr) {
> +               of_node_put(intr_gen_node);
>                 return -ENOMEM;
> +       }
>
>         pmu_context->pmuintrgen = devm_regmap_init_mmio(dev, virt_addr,
>                                                         &regmap_pmu_intr);
>         if (IS_ERR(pmu_context->pmuintrgen)) {
>                 dev_err(dev, "failed to initialize pmu-intr-gen regmap\n");
> +               of_node_put(intr_gen_node);
>                 return PTR_ERR(pmu_context->pmuintrgen);
>         }
>
>         /* register custom mmio regmap with syscon */
>         ret = of_syscon_register_regmap(intr_gen_node,
>                                         pmu_context->pmuintrgen);
> +       of_node_put(intr_gen_node);
>         if (ret)
>                 return ret;
>
>
> --
> 2.51.0
>
