Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44223364E98;
	Sat, 10 Oct 2026 14:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791642868; cv=none; b=pYFaR7ffNJ1k5EqQ+zqW90/h7pLZKwy2EAYGI/giYi2WB4sXVXW9g6eOqq+rrjTZg4x/310mz0jf5qSDgjWOO5KNQ1DcpLctdhWDGA1+kb6U46DCS2pTU34+4Zewg68cWig+EBW31q2OiQo0+lqIaqLvUgjVJuO/NNxfwQk0Cbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791642868; c=relaxed/simple;
	bh=bY1FkzrmoTrmnMtl/t7yCZ44XVx09IFgGcx53OvFoHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQdTtbKZiWvLeNQczYhRvHP4iKpo4RUAYnyXv0nxO0C5OtRRdGfoMDKHiZ8XDL+AjBgcPn6VwySmTqgQw8T//A5dPvVRg9pbxs99YgD/ZLGtSROJ89m6n2v55BQ0j3RAv/xmQAiLz5kgx5tzhEETuvWfTQBoI7Gp0BH9AZkqPe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JxylpYuF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxylpYuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87111F000FF;
	Sat, 10 Oct 2026 14:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791642866;
	bh=cDnCu2/UzjdlBjBG61ofGnnF+daBO265HXx+uRzlR2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JxylpYuFGD0bsDT2yhVbDIn3AI/VXQPGQBV/T2NiKD6QMdyuqDrlaTQy1jSVAympo
	 l9JlGJgJnVXPYKic1RsQDs4Gtwo/hxMbpAerxtx+iw4a8DUTCkFNHIZDipOBRdov1X
	 c8gy+SVnoZ980NxoF10HJEEAutRLV3yy5wrcR+Pcu+qtqDPFU2TaVNBWDU6V8oIb0l
	 cv5tN67XsacVP1/3VqUuOo3juyGfo1hNvCW6syIN1yhbwNVpQQ5kEtUDf8UVhOEEu2
	 2O82OS7q9ZIodA6FLR/nA/88gdNT3PjVvyeqdum1U4mQbZmbBTYvF6zJuSsTrBqRBU
	 l0kmkzoVmw4hA==
Date: Sat, 10 Oct 2026 16:34:23 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Wentao Liang <vulab@iscas.ac.cn>, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux@prisktech.co.nz, wsa@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 04/20] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
Message-ID: <aspGdlG2J4h6KxFl@zenone.zhora.eu>
References: <20260916070631.1965713-1-vulab@iscas.ac.cn>
 <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>

Hi Wentao,

On Wed, Sep 16, 2026 at 11:17:49AM +0400, Alexey Charkov wrote:
> On Wed, Sep 16, 2026 at 11:07 AM Wentao Liang <vulab@iscas.ac.cn> wrote:
> >
> > In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
> > subsequent operation fails or when the module is unloaded, the clock
> > reference count is never decremented via clk_put(), leading to a
> > resource leak.
> >
> > Switch to devm_clk_get() so that the clock is automatically managed
> > and released.
> >
> > Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia SoCs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

this is 4/20 but where are the rest of the patches?

> > ---
> >  drivers/i2c/busses/i2c-viai2c-wmt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c-viai2c-wmt.c
> > index 2cf3cc0165fb..74ca93b44347 100644
> > --- a/drivers/i2c/busses/i2c-viai2c-wmt.c
> > +++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
> > @@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev)
> >                 return dev_err_probe(&pdev->dev, err,
> >                                 "failed to request irq %i\n", i2c->irq);
> >
> > -       i2c->clk = of_clk_get(np, 0);
> > +       i2c->clk = devm_clk_get(&pdev->dev, NULL);
> 
> Maybe we could go for devm_clk_get_enabled and drop some more
> boilerplate which follows in wmt_i2c_reset_hardware, while at it?
> 
> Backporting this to stable seems like a stretch to me, though (it's
> quite old code, so there would be quite a lot of backporting for a
> rarely hit resource leak).

Alexey asked a question. Wouldn't it be good to follow up?

Unfortunately, this is becoming quite common with LLM generated
patches, where questions are often left unanswered, perhaps
because the patches are not fully understood by committers.

I think the patch is correct, though, and Alexey's suggestions
can be addressed after this is merged.

With some disappointment, I'm pushing this patch to
i2c/i2c-fixes-2.

Andi
