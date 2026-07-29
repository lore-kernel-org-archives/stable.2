Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627FF392829
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 04:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785298464; cv=pass; b=j32GZbmwhBDizTFXnte0ozLdru9AZyrDQLeds/59TgaQPVp2wFUKwTN2CeWKsnP7aYrFtN1AdqmHNP3W329ew0RBJex9nKa0AW+Iw03rBpYi7Fkn+PH8uDkOx5udQwyZoAXZ+LfVlS+vOOBsZcwRCkTmijXcsbAyM/Fv6B9noaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785298464; c=relaxed/simple;
	bh=CepGmDEK6OBNfUfXuejBy9kdH9EdttPI4R03Nv6jgnk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOk7zLdtMLP4UMwVmUxHsZD/yksbCVlhNbYF6/cZ0uub5R3e2hiT73YmX6ply72e0wF4E2Bik04mscnxfLjhBEzMI6KEpe6VtKzBcs26YKov/0eTDsrLHecttfyiy79N1rlndZpE25LWuTdC4RqbAMb0TiFYmDlDQrjJPKLr3zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=po7WJ0mz; arc=pass smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quora.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b="po7WJ0mz"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3811f512167so493416a91.3
        for <stable@vger.kernel.org>; Tue, 28 Jul 2026 21:14:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785298461; cv=none;
        d=google.com; s=arc-20260327;
        b=bCpXypSBdiNzeBRBArAOQctw8WrwPm6zZToY2SmA9xuUYvoFGdRYDFCNehn8BRQE62
         VTWKPeyu43AgMGpKRRG5xAUQ60OXVpoVVdPZooM2wRsZtEP72w3g4aZ5Zo3MUsP/mKCP
         EwaC49/xaAIUCiaHUfRgOwx5j4rfGlwrqGA1Ka8xCyYL0LNnE+x++pyilum+t+iuQp1m
         83zfvdMMKHWgVwmZ4nW1b25fT2HGJKgo8KdYrY6aKM5r2eK6TcqFDeWn67b7coF8MNpe
         wUdTflVSY8wjDkxFrxIdBI3/80GpModvxsfEMS8hF9WaDN9+ZvY3kaH72iSZCi3C0qHJ
         KBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hP1SH2landNf+VecwvUxNLCDVGixxdgRDv2mXpbX3tw=;
        fh=zeKnDVc+KTxyWto8DT2rLpncUwrKlmdNr1lB+Y8voXs=;
        b=eVmAUJOv+BaF2V0YcG6a6H3/2iH1d4iPXaxTiagTNko2i+qtgaeOFY1enA20XAhvTN
         mLkXny1R9ThOIQ13PAwihHptFwUbTAy/KTJfXPjPSNAMzkv+x1OB0//ES3zFFvlaEsPE
         LAu5QQ7QGiDzjEHpTw6yj4QTIFYBEwU9sWIseU0hIRFw7xCjopPmkXgAYnP7DjNxetAE
         i5Ij/MENjm6AMQVN/tola1DPeQSLYHz7vIgTIJOUAFdU0cfjM+/HjXhsaaWZR/WxM1QZ
         GpLxRwCKAgPmreL5nFB8/lrqjePDVJ7gpM5w2b/0naTbX9YQb9nRpAKNTPDUPc8QXXOD
         b8nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1785298461; x=1785903261; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hP1SH2landNf+VecwvUxNLCDVGixxdgRDv2mXpbX3tw=;
        b=po7WJ0mz8XbXgy6flAcU+7X5sPbiB8mTQIe28JSqHv6ywcaGKb7StiIopGb9kF4DgF
         Kd71DbnAjtdW0MZZOFvM+xqKajJLuilGOhZaPVK+Lq0SVEdJAd+Dmc4kePyLu6KH3peV
         SvvULEysPFhUXUU28d2DWnjSdcGiOUTF3E+gY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785298461; x=1785903261;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hP1SH2landNf+VecwvUxNLCDVGixxdgRDv2mXpbX3tw=;
        b=kk9qLAW1esU4FMQFBYd8Tn4Oa93Bmn5GxDKbTbxCYHIhS8Ck6RVaKY/w87oaiSjhXi
         DllPtgs/EUr3Oi5l912oMlLtmCTYi60MIdtuqgOS+LT5SRXFE82klwJjx1RTqXnZS7JV
         f0klCUsdjfCSuk3s6gkO1heCrV2VFkuDOETRjYMxjGxorrM2n0yKgIegM5X1eA9vAN2O
         KMA+r0tEPpmHzXv4gimOSbjPI49NieTXKfIlnXltuJ/NvXLIqhNwZKpLOGuFxs2uJ9Wy
         yB/oo0j3cMIhq+KQJayKWe7+J2ZtwNjEQ6mXohGIPNhpUUJeNsTRhdfWVM8W2wcuYM/G
         yGLw==
X-Forwarded-Encrypted: i=1; AHgh+Rq87sGLJCIzoxZaiQNf5LRmR2KLc5FNbYuF5Tfg3IJBclLVdR0y7oQ2fsP37DDQ/SArnPP6B9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYAutyvkwhgntw/JaV3Q5BFAajI3qVca/IVlXjkd+R/56RfTs/
	fGI1dzZFzoVJ1YCisi+8Z7NIGdCBK7UQNGwxsYhOayQhNi7e+fkQsqXdjIrF3w1OUUMM6wP/Qes
	+sFOW9DfIwspEbVquj4RcQPqUwZnKl7JHZKo4HJ2E9Q==
X-Gm-Gg: AR+sD11lRiNVB7Hh+HyYLqbLX3NYhTKsl/kM1FNBDZiBWDCv4306HhiSlp0ZOuETADs
	KmFM+mrsMx8PFNMu00iy29HVBCTuJioPYcMqCL+d9dRdtZkQ64n4EOC6foJxaWLdCoyHyDUvBIX
	li7bEmGQ0nW8sD3VcGBpb5/6akjZHxVKfsOTI5RPSslfBAKQjvAoMGeKEQr8PhbL7uKApKQwkO+
	kr2PGNdCyuNSi/EWxB2AKlyuU5hGgnnmnxZ8ubEaeo5y5nTxo97+xzqz0SaR72os+Hnj14MijtW
	EheGDv0ZuckirzX8KqjW2pm7UzNBkF7fg79p68OcS/HLXUzPpGTMYyKjATp2AeqU3oHgZYpJJjR
	vAP9otIuUZyPjpWHbig+XvHfCqbp+Qpvt/uig/lYJiF3sK2OdFz69lWOopWfw4//btSa23WXWat
	IMKkMbP05DsyCqDNogAb6xqLtRC5oCUjZb8V59XBie8NZ7TetmXrG1Bp54+QOp6hisYFLzGYK0h
	lnN3skYKeS7dvBa4MtbdYmJ
X-Received: by 2002:a17:90b:56cf:b0:38d:c0f9:30be with SMTP id
 98e67ed59e1d1-38f6a480100mr5165016a91.38.1785298460785; Tue, 28 Jul 2026
 21:14:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org>
In-Reply-To: <20250110-soc-qcom-pmic-glink-fix-device-access-on-worker-while-suspended-v1-1-e32fd6bf322e@linaro.org>
From: Daniel J Blueman <daniel@quora.org>
Date: Wed, 29 Jul 2026 12:14:09 +0800
X-Gm-Features: AUfX_myf3MWvQnicni0oin27mcV4qjlzSadUHqw9n9Hnpgvs05MyQmBe0-bNBK4
Message-ID: <CAMVG2ssS4=Kb=OxuVXb_062fgvBfKz+X0q1N2rFob0TH6JypYg@mail.gmail.com>
Subject: Re: [PATCH RFC] soc: qcom: pmic_glink: Fix device access from worker
 during suspend
To: Abel Vesa <abel.vesa@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Caleb Connolly <caleb.connolly@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Johan Hovold <johan@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Val Packett <val@packett.cool>
Content-Type: text/plain; charset="UTF-8"

On Fri, 10 Jan 2025 at 23:29, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The pmic_glink_altmode_worker() currently gets scheduled on the system_wq.
> When the system is suspended (s2idle), the fact that the worker can be
> scheduled to run while devices are still suspended provesto be a problem
> when a Type-C retimer, switch or mux that is controlled over a bus like
> I2C, because the I2C controller is suspended.
>
> This has been proven to be the case on the X Elite boards where such
> retimers (ParadeTech PS8830) are used in order to handle Type-C
> orientation and altmode configuration. The following warning is thrown:
>
> [   35.134876] i2c i2c-4: Transfer while suspended
> [   35.143865] WARNING: CPU: 0 PID: 99 at drivers/i2c/i2c-core.h:56 __i2c_transfer+0xb4/0x57c [i2c_core]
> [   35.352879] Workqueue: events pmic_glink_altmode_worker [pmic_glink_altmode]
> [   35.360179] pstate: 61400005 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
> [   35.455242] Call trace:
> [   35.457826]  __i2c_transfer+0xb4/0x57c [i2c_core] (P)
> [   35.463086]  i2c_transfer+0x98/0xf0 [i2c_core]
> [   35.467713]  i2c_transfer_buffer_flags+0x54/0x88 [i2c_core]
> [   35.473502]  regmap_i2c_write+0x20/0x48 [regmap_i2c]
> [   35.478659]  _regmap_raw_write_impl+0x780/0x944
> [   35.483401]  _regmap_bus_raw_write+0x60/0x7c
> [   35.487848]  _regmap_write+0x134/0x184
> [   35.491773]  regmap_write+0x54/0x78
> [   35.495418]  ps883x_set+0x58/0xec [ps883x]
> [   35.499688]  ps883x_sw_set+0x60/0x84 [ps883x]
> [   35.504223]  typec_switch_set+0x48/0x74 [typec]
> [   35.508952]  pmic_glink_altmode_worker+0x44/0x1fc [pmic_glink_altmode]
> [   35.515712]  process_scheduled_works+0x1a0/0x2d0
> [   35.520525]  worker_thread+0x2a8/0x3c8
> [   35.524449]  kthread+0xfc/0x184
> [   35.527749]  ret_from_fork+0x10/0x20
>
> The solution here is to schedule the altmode worker on the system_freezable_wq
> instead of the system_wq. This will result in the altmode worker not being
> scheduled to run until the devices are resumed first, which will give the
> controllers like I2C a chance to resume before the transfer is requested.
>
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> Cc: stable@vger.kernel.org    # 6.3
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index bd06ce16180411059e9efb14d9aeccda27744280..bde129aa7d90a39becaa720376c0539bcaa492fb 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -295,7 +295,7 @@ static void pmic_glink_altmode_sc8180xp_notify(struct pmic_glink_altmode *altmod
>         alt_port->mode = mode;
>         alt_port->hpd_state = hpd_state;
>         alt_port->hpd_irq = hpd_irq;
> -       schedule_work(&alt_port->work);
> +       queue_work(system_freezable_wq, &alt_port->work);
>  }
>
>  #define SC8280XP_DPAM_MASK     0x3f
> @@ -338,7 +338,7 @@ static void pmic_glink_altmode_sc8280xp_notify(struct pmic_glink_altmode *altmod
>         alt_port->mode = mode;
>         alt_port->hpd_state = hpd_state;
>         alt_port->hpd_irq = hpd_irq;
> -       schedule_work(&alt_port->work);
> +       queue_work(system_freezable_wq, &alt_port->work);
>  }
>
>  static void pmic_glink_altmode_callback(const void *data, size_t len, void *priv)

Reviewed-by: Daniel J Blueman <daniel@quora.org>
Tested-by: Daniel J Blueman <daniel@quora.org> # Lenovo Slim 7x, X1E80100

I have been hitting the same case (resulting in dead monitor on
resume) and independently reached the same fix. Dropping
IRQF_NO_SUSPEND does not prevent the race window, therefore there is
no better solution until the glink driver gets rewritten.

@Bjorn @Konrad given the real UX impact this minimal fix resolves,
what objections do you have for taking it into v7.2-rc other than
revising it to include a note that this is a medium-term fix until the
glink driver is rewritten?

Thanks,
  Dan
-- 
Daniel J Blueman
