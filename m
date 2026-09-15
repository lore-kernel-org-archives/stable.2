Received: from mail.tkos.co.il (hours.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2440641D637;
	Tue, 15 Sep 2026 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789492433; cv=none; b=N6bJrIfKBZiAhcbsCEKzEVy3gOcR29kJhiyst1Q5yoHGFXPhA0pokZrgTGO8/MTEnCnDDuqwOK8xyF0vrvB4DXyS+dvLabWIKDLDvBmWx7Il63qFNjPNkdLHU67er5vb6BhHXaC1eh1+x+HC8BhzkGFykR9GS/ssTugPVNtVyo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789492433; c=relaxed/simple;
	bh=xH4ZlU5k/yRo7phBWr9/5nBvSCsCwNfWIrWpnRpJgJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gBzRF2r+8gldSarqBVsaTyc5L1ADLj4ghSjjanXB6OxxbJ07xa1DtmX7I1EqKItI8hnrh86sytkYMyBe68//h9r6yWpz9seCG3mHtqB4PHkETjIBJB35QARvai/abUUGXnDhOAL1FSuoT1wbT03Atqo3Avl67WvLXI0cKGZ6o7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=Ar/Cq8k3; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="Ar/Cq8k3"
Received: from localhost (unknown [10.0.8.3])
	by mail.tkos.co.il (Postfix) with ESMTP id B59B344054B;
	Tue, 15 Sep 2026 20:13:12 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1789492392;
	bh=xH4ZlU5k/yRo7phBWr9/5nBvSCsCwNfWIrWpnRpJgJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ar/Cq8k36IJgv6PUzoBa+JCDGGB8TRvR+AUBaqrhYWuakCpVpI5rNVZRkroTAnMIu
	 g8quLhD8xDf75Z4awqyBVohrAp5UxjuT3WKY4nN3VHFDPK+A0bKWXXdqr0LIlkuSu/
	 a5yWppr4iVRZTq9i8XjTpudaIE8J3Up2VoihLaqdM1p8A0y9TFMnAvOqwTMNTjt9Ip
	 /9BMd40eVG2NwXi/MKWKz02tGaboiTEJ25wWbHZwdOPzcJ9eEqg166rl40OJHITysb
	 fwB6WMQvb8FT8LToObgltXV5Or3tG0urcKLBvpdQxM8gaKwc3eGQBL+NqZudJxSQW/
	 HfZmmF501HvbA==
From: Baruch Siach <baruch@tkos.co.il>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: daniel.lezcano@kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  tglx@kernel.org,  lkml@vger.kernel.org,
  stable@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/digicolor: Fix clk reference leak
 on request_irq failure
In-Reply-To: <20260915045242.1726702-1-vulab@iscas.ac.cn> (Wentao Liang's
	message of "Tue, 15 Sep 2026 04:52:42 +0000")
References: <20260915045242.1726702-1-vulab@iscas.ac.cn>
User-Agent: mu4e 1.14.2; emacs 30.2
Date: Tue, 15 Sep 2026 20:13:44 +0300
Message-ID: <87o6dy30af.fsf@tarshish>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Wentao Liang,

On Tue, Sep 15 2026, Wentao Liang wrote:
> digicolor_timer_init() obtains the timer clock with of_clk_get() and
> enables it, but the request_irq() failure path returns without releasing
> the clock reference, leaking both the enable/prepare state and the
> reference itself.
>
> Disable and put the clock before returning on the request_irq() failure
> path. The success path keeps the clock enabled for the lifetime of the
> timer and is left untouched.
>
> Fixes: 9b8bb7736b78 ("clocksource: Driver for Conexant Digicolor SoC timer")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

Acked-by: Baruch Siach <baruch@tkos.co.il>

Thanks,
baruch

> ---
>  drivers/clocksource/timer-digicolor.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
> index 559aa96089c3..46e0c329957a 100644
> --- a/drivers/clocksource/timer-digicolor.c
> +++ b/drivers/clocksource/timer-digicolor.c
> @@ -190,6 +190,8 @@ static int __init digicolor_timer_init(struct device_node *node)
>  			  &dc_timer_dev.ce);
>  	if (ret) {
>  		pr_warn("request of timer irq %d failed (%d)\n", irq, ret);
> +		clk_disable_unprepare(clk);
> +		clk_put(clk);
>  		return ret;
>  	}

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
