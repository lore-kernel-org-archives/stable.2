Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793783486;
	b=WEM+3Meo/WWBxKt9AwvnutFmmycYiYZCrjlCYkiSJsdeyBTODUPkxnnFuE9ETYXpx3iO
	 kX+kH1XkpYpktPjWgApAOCr3J2jP/03Cg0mmQiBIBYcfw4xC4wrOU8QYIEB83DJ2vBwZq
	 APHpFxVxj/R7jUV62FPi57QcMAbo0aFINcEF430CQji+DUuIhm3nuvd2k1I8+lgSoY+q8
	 FjZALuDlQFV1xI2somZKICZXCvjWyI0kqaiFWxXwTTVSdn7mQOrv/nuHu4xYCJR2Y2LvP
	 rE9zGnsdqPXbnGGFDEAHKN0gESkAUTf6qgQIXXZKiYqISHctODgkeOKhjvx3Rs6IBWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793783486;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QKMR7wUr3RequfVI/fCFzvQaDgDCr5sLIgWe6uM/uY4=;
	b=Ih21q0sRSNXQDEdU6Hv21dyoOUkC+T+be5hrILOo4BiCvmXRqc09O0LmhrMY/nVdDObf
	 +jgabrcriz0F8NIQxxYaz+asWubro1OVfNOWsVnMF5zpHEiJA/+ARRbSKVbp/fmG/0p5x
	 HYVcZQTmeZgCubEdQXfIfLdjeZmVru91aCghItjM70IqM34cYXDkdui5FV+VpFSTtQexq
	 LcLR3yXS9VK+UAtYvD/D9SHr4cWWTlPQ8sCaKsh94HCBR+lCwp5mUCJWX8N/Cs0dFObXK
	 Q0zPSKzFd1F64sfywGXQkVw8m8i+p5fuqxxXldbDknCUshLzI6QCflr49BAG480o6PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZYrdz4J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 10B7E606A31B;
	Wed,  4 Nov 2026 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fZYrdz4J
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BC1621F00919;
	Wed,  4 Nov 2026 09:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793783485;
	bh=QKMR7wUr3RequfVI/fCFzvQaDgDCr5sLIgWe6uM/uY4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fZYrdz4JuK19qrpS3eF9PsMmG2Dt0JWJMYIwLo+AYfy/Oo0jUtP+FX7b+S5UuNTGf
	 jGmAvyH/sn4aHFhXpItr/OwM25laSQAVHudwqsD0oI/23ozx8ubYkgQK04lluksm5V
	 OUlhmCys66AgJIIlO0xhu5SG9JOBMCradrDwb3r8tpHcARBGei6irjsPPMWfPqCeoJ
	 DMdODdTJI1Nvmo/OOBB/1ZMj0OdQi6BB0R2cXxbLBtlkrlAVofJRjTYzI4sbyYslGW
	 YYPAJhLxYhqMQ6PXFw9a1skWYWsbJAJkKs3O1v9N3ZZmuv+Cr4bHZKfO+R3ARPMjUb
	 RPPsPdpGGrDHQ==
Date: Wed, 4 Nov 2026 10:11:22 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Ajay Kishore <akisho@codeaurora.org>, 
	Christian Marangi <ansuelsmth@gmail.com>, linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 10/10] pinctrl: qcom: Check qcom_scm_io_readl() return
 value in msm_gpio_irq_set_type()
Message-ID: <5nfz4eaxtiuu53srzclwokpeaiooqmsyok2zbuq7ulr6lsbykx@qto7uvaf35h5>
References: <20261103213002.1673560-1-lee@kernel.org>
 <20261103213002.1673560-11-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103213002.1673560-11-lee@kernel.org>

On Tue, Nov 03, 2026 at 09:29:15PM +0000, Lee Jones wrote:
> In msm_gpio_irq_set_type(), when pctrl->intr_target_use_scm is set, the
> return value of qcom_scm_io_readl(addr, &val) is ignored.  If the SCM read
> fails, val remains uninitialised and its stack contents are modified and
> written back to the hardware register via qcom_scm_io_writel().
> 
> Check the return value of qcom_scm_io_readl() before modifying and writing
> back val.
> 
> Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Apps")
> Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968f50
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
> index 27f06bbc113c..1b46735fc4bc 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1105,11 +1105,13 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
>  		u32 addr = pctrl->phys_base[0] + reg;
>  		int ret;
>  
> -		qcom_scm_io_readl(addr, &val);
> -		val &= ~(intr_target_mask << g->intr_target_bit);
> -		val |= g->intr_target_kpss_val << g->intr_target_bit;
> +		ret = qcom_scm_io_readl(addr, &val);
> +		if (!ret) {
> +			val &= ~(intr_target_mask << g->intr_target_bit);
> +			val |= g->intr_target_kpss_val << g->intr_target_bit;
>  
> -		ret = qcom_scm_io_writel(addr, val);
> +			ret = qcom_scm_io_writel(addr, val);
> +		}
>  		if (ret)
>  			dev_err(pctrl->dev,
>  				"Failed routing %lu interrupt to Apps proc",
> -- 
> 2.56.0.385.gac671c819a-goog
>

In case Linus wants to apply the entire series at once:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
