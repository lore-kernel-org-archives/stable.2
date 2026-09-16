Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD6440652
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789543104; cv=pass; b=aMzjSpXHRgjJSsPinJjeNzn/kyeHsKSQUQpf8r8k7v9qNRQgKbqjYwd0cA8v6jHecw8w0zBmw8bhEFuj+JTeJpxs9wrhFdZT8RUzVqbKkEfbVxMdKoEDDYbem7g0Q3g6qTPUGivOiaf+0lRiyK4Cc0lLyNg2a8KjjX8eutf+dew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789543104; c=relaxed/simple;
	bh=NZR9oJcFKVLcrgem1bgASUkURlhSqxs9JZAAiNdx57Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/bE/7q54KhQNP+CdMsD1l6gS1TrXv2L8ZpC3Vk+uKP0YQOX+FmWGk2R1DwCxvcJHcW6qMO47/n//gvaaieqIIHAwqiAQ2hE9nx2NjbdIiWoZ25KwYqrC7DUJ696ezvyOmF3CFx8y2meORusDAEDvNwyeiLql+BIa2Jc1oAkEwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ1ENgN4; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ1ENgN4"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb4so72745485a.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 00:18:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789543079; cv=none;
        d=google.com; s=arc-20260327;
        b=hfvC7b2GkeHq/cRw9D+OvNu/79lbic/e0TV6nNUB5X3/kKDq7rZB9J90gwY2X2yWPN
         JuHV7V3KALdRuX4xptoX0WqqNTG+GkSxOoc4wreDmtiT2eF+kNl6HJnNeCLcJDDxG+FB
         IUFNrwSZ4UbAQwLzeBPqGNJChPjzLBm1CJ4AEyYQHrChDWj6+ycmBc5nP84pV+0yKVHG
         Lkjy5UDLURNGPCwG0KRfVduv5P1rK6SNCJSbpX/lABgOW9Kcz88ygdZH+sWqjnrQWotw
         YVDUtA8F7GaSvPYiVNAtvoXlNEbRr0+Tm1RbvlC8RAa3ftrlYs77SQoDJA1UtUwMA6MT
         NQZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        fh=pqBR2giEFig6GcFTsQPJOkkeabWc+NQFer7h9yTt3DM=;
        b=sXdAk2RDC5EraRDtO7lYU6cq7dMh/BVUWhD6SXh52YszM28Dts80now/wymvlBu14z
         bmjVL+2VJkbVx/4AMF5snAZR7O/9emhHaYyhFR1dJHLRSlhoMxCcf3Y7RNuvIBqL63EB
         cuKEHz2XicCgKVSkYto722T6oBrA4n/chja9VgdSHYH3bYC5Sgvd3RTiiLjOpBDzA2Ol
         2LGl6BqBw5b7nbl/IML99noI2PptAi1lCr0Xa2RmBzFOiscXWLWtafJieruzT/5QW45d
         x05cTHbJobouRVBErRrNYBTDdKQbqoGk0Pibk5UFplu4AIjrJ9BYlnsU8dXFLfb81RHE
         HzOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789543079; x=1790147879; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        b=pJ1ENgN4u5fI4oIyvdZIi/FUm9YUsmRo5XHoLZQdvFmP8eXh96bKKvMIYiodimWiqJ
         PstVXZqGfiCkx4PXPFqVwf9FlO5vWSYCSgtmhVw2SIdIazaHzZDKqWLZp1Q8m9v3u+uK
         s/bldKH4KY8nrslJTmMXbhFd/P8Vg6j4H9WQT1fi0oBD+IG8jpwc24ihHXlH1MRlrU5o
         uWj42z3jmCUyJFfaJbG7dq/DVxwYTKFOpwi8BOrwYGQ9Wbd7pXFNTXx0HYoCVH03GQ6s
         o6LVRp4o4diTX5bB7/2TfPUwKtzPd4JZsPP/ymZlULZS9Nbc4+BXLns7D+W23MSb1QUp
         gouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789543079; x=1790147879;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HePzGTrSXdk0LNKW30I8iTNCaViy2K7dGjEo2OIzHmY=;
        b=oW2O5dPv3stLHXCnNks4i6bIrMYSnArlb/fI3e5Ya+OnnHwuNbuhHVCIxMmRZAdm66
         VwMuCKbbJOH6sh4GHzEByMJwmg3xaNtcO7ZGgXPWEO35rE3rEtJ+d9SDY6wgrN3vul82
         t7/NXr6b3NdYIahO1yXR6GLRPbZk2uh/SoUnk4a2uHRHY9r4lqI8EIUX55FdebUtdgau
         fUPyrzFzZ9kw7WEzzxh7bL8UuRFW3y1JfLKR6S9sReE0WZBQ6wjulQzJAhurv+SIww2F
         Ro8c6QJrdhO4c9EwzEBIxukm1XIRKx1p9mFIxg4KsZiHho/nuekpTVzyWD06Q8kvtawC
         9mtQ==
X-Forwarded-Encrypted: i=1; AKwUvBxq6JIVZbreNbwuZahsIMKAEEq0L0g59ZzdSpJTWJeSPCt0yz6TWGODBXdQd3ASt3NyKposvRQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nYuLulD5dEtvKsVHFyj74f5dAfJfjzxDVJEcTcxQdm2JfoxeQO
	ZoAyJ4FUI6XyRyNAQRiyRBtU/GbG5ybPrUXQwZsTveH9axhXIlQo0oxgSbPNrU9nHp6yZ/BWA9Y
	/jClsxV47RiKh+h6ewoMDRW0R86O9PRo=
X-Gm-Gg: AYBFou2yXPZtZmUwuW8VAvS7PIRSdDL7v/mGG3dxADZeneLHaOImVqKnYOgy+C/VtUP
	ryyZOUCdNXmL2j+URRFcsJbh9rSM9tggcGo3hPFKMhPdSIa/PnkgX4lUP1Fpjy98vNdEBFfsE8m
	gK8WPX6FO35bO4TuEOJkpzSf8/8b2jE1kQDkgmv6y43u7Nm+EvC39Mgq4LtQyehCQNS2mmWou8/
	4k3jpqNp/BGOuaf2FiuPpl0Axw/oVY37aYC4T6GFIHkyVOWr92vPP10eQqqozKCXeRPYRTnxxSo
	h4Bo5xs1KdaXOoRADwhb6knqKvMPen3tM9x5hUEQ1iRyu9U/0oKn0/7F
X-Received: by 2002:a05:620a:4008:b0:93a:7bc2:d75f with SMTP id
 af79cd13be357-93bb790da17mr204175585a.36.1789543078899; Wed, 16 Sep 2026
 00:17:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916070631.1965713-1-vulab@iscas.ac.cn>
In-Reply-To: <20260916070631.1965713-1-vulab@iscas.ac.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 16 Sep 2026 11:17:49 +0400
X-Gm-Features: AcwNN1VnmMXQfeYvkGasjznx5Qwpu_KfApsjjbpvaD5udE_w8aTgwLskI1UsZGY
Message-ID: <CABjd4YzNzZ0nnO4Xgw1JsRHhj9Crc6diX1uJnWHpHvd6BcPk2g@mail.gmail.com>
Subject: Re: [PATCH 04/20] i2c: viai2c-wmt: Fix clock leak in wmt_i2c_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: andi.shyti@kernel.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux@prisktech.co.nz, wsa@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:07=E2=80=AFAM Wentao Liang <vulab@iscas.ac.cn> w=
rote:
>
> In wmt_i2c_probe(), i2c->clk is acquired using of_clk_get(). If any
> subsequent operation fails or when the module is unloaded, the clock
> reference count is never decremented via clk_put(), leading to a
> resource leak.
>
> Switch to devm_clk_get() so that the clock is automatically managed
> and released.
>
> Fixes: 560746eb79d3 ("i2c: vt8500: Add support for I2C bus on Wondermedia=
 SoCs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/i2c/busses/i2c-viai2c-wmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/i2c/busses/i2c-viai2c-wmt.c b/drivers/i2c/busses/i2c=
-viai2c-wmt.c
> index 2cf3cc0165fb..74ca93b44347 100644
> --- a/drivers/i2c/busses/i2c-viai2c-wmt.c
> +++ b/drivers/i2c/busses/i2c-viai2c-wmt.c
> @@ -117,7 +117,7 @@ static int wmt_i2c_probe(struct platform_device *pdev=
)
>                 return dev_err_probe(&pdev->dev, err,
>                                 "failed to request irq %i\n", i2c->irq);
>
> -       i2c->clk =3D of_clk_get(np, 0);
> +       i2c->clk =3D devm_clk_get(&pdev->dev, NULL);

Maybe we could go for devm_clk_get_enabled and drop some more
boilerplate which follows in wmt_i2c_reset_hardware, while at it?

Backporting this to stable seems like a stretch to me, though (it's
quite old code, so there would be quite a lot of backporting for a
rarely hit resource leak).

Best regards,
Alexey
