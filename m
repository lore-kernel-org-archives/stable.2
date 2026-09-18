Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B643AAF73
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789717927; cv=pass; b=BjretZfZDSncUSj68ssuns+O6MWJaxYlQGHkGnqtFAZoImOFedkANyDVoqkC8XArtWSjM9ZELU3i28TG/WCWe1QcxbPQp+zd1DF0hxEtlL8aINxcLXF3MFeJfUmqwASlHcMRuc+kyyMISidgIuY1KFHxgKjs/HLu9RCQ/7aLooY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789717927; c=relaxed/simple;
	bh=HmU3O9u9jVAkFRCkWEdl+bin1iaF6HrroVvtBQG2j9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uY52oHJ/8UQ3+Cua7rQWzVKkQ8XxeGiUTYnZoUqBtcze5VBeA3EFnunsOYSW+KoNbaQLvV3XXlXWxHmPgIlvhqTGbF6svYsBBwzFnsLxh+2hduzVEVaD7TYeyoIpCamdYMT3SFPM/ewFktdGHT6vq+cAqFan8UJhlqie4WtsXtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xlBZRl; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xlBZRl"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb76ef19aso4285821cf.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 00:52:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789717925; cv=none;
        d=google.com; s=arc-20260327;
        b=fFMbWsMKj8rD/41x95iMJfgIaYc+8rtWE59HiOmhExkrugzjMDdDmX4KJLB8oDjA41
         derjW3bkfloS1Mmq3yvVGO0KRKeeL+aSS/TuB96ffx8YQvXRLQKxd1gzjlaHH0/D/UkQ
         lIAP3UfORRWNbgDSyZ20i+PnIrr7r8ntzjA0r1m5fYeRN4Pz0vtSt4kpBXK3Zu60oXZc
         Pvv/q9jeBZc4XLWDSC3Sxra7kqBwWNkQaDs558XEyfjhrRJ7aQe4Vx1o5P/YakgsFQv2
         oH/46iQLvcOX8NYI6FkIfp6IPKLEp69lP9IYKB+jL/WQQmasXPDmB8VltQbyYlpldgEN
         mYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        fh=8bvWN2zE8Dz9vUK3FDuZJmec8oRmcO/+E5UkgtNL4jA=;
        b=AESV++QJTskwv+8LxBL2cUFPb8cy+rg4DgiqQHoJWs2KIJy86n24Aph0yz7Y/jAUTQ
         tR7yISu06NjlKLRV3Y+WklcVWoqh6dYwvbrO3Q0Wg+kTtxMMpnExRHRFODHHZfLMyrLN
         Guso39KdT3HSxx5X9QULYNk8+oCFgH9vmqGPXUD67WxMid+pQ+BE0oGxiGNoW4L7CDiN
         cXCEPengMD0gFMZoaLjXdqI8ucAA2hKpak+FW79aOfl1Q2G2CR6ghIH/nCoW9ZwCgpGA
         iz3zuvxKCJzENaX29gs3ZJTKoAD83D5ztzAm3eHyWIiCaR1jW1kkJROkWtj1xu+F51oo
         mmsQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789717925; x=1790322725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        b=Q/xlBZRl0d1u4TvTkrjunTffRGdneS3ZGZ9KpeYJHWJ4j5vBeZcAQcajCRBlEKtZ1R
         9qcHZNY5Tj5gTnWw/gxSY2grlwWTayC403wG+ZHKG/+1xWWkQuPRWkXkon96eOxoaw9+
         /oYMDZTPmGa+r0JdjAfetHzpzN0FauE9zA26ewQG/lWJhMe/UklgcqWuQQxN/otC+U5X
         rOMzHO3e4TEQq+/C6ufRmdM/X83CNDZ8IJEtojCF+bJ1eGsugbqQR/iKWNmmazYU59RU
         HPs01ABdOHAM+JFkSrpRcEN7oPgBFJRVdHfjt3e7gfIzRjFWaQNio5RQqDhuVwjyXa2C
         CjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789717925; x=1790322725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GENi4md1c446ap3YU+8WbAIKW0z2UxkHlaNTGXc/qAc=;
        b=LpnLxpNB3MgrWvb9wBCGGCUkemBv05KeKERhNL3gX7+KA5nwKLpdy7aQptcsoLTvMj
         X8iL5WtUAiMjLqBO3npseReuyBUUr5tjthPamkS5wqz/0oTVOlWJn6jqITJK6xSNSB5+
         sOt4hSor/EtDt7fHTDeLk55jAeoGDiO0/l92/vS7b8xs6HANTCHERFBKfz8dM8wVF7H1
         4QDp6v95vU4ALc2emsWk95c+riVl543/PqNwE5S2c7ve7/6SXY9qcoPJs9GkdA6PB5SH
         1w5czdTs5HkZdQ9uAlNWywFkaa/awmoX5CTxuHrWgjtB/ocOP2q5YMBNClsksTWyZiTs
         p9jg==
X-Forwarded-Encrypted: i=1; AKwUvBwcRvTwyEe3hlEqzAiysqA/Fw9Q/d4M9WF/M/KkNLdsUDfniJycpACcVV/aR5kvm+PqstciqQg=@vger.kernel.org
X-Gm-Message-State: AFuF++m/5pJXGRLBTdJlWC7YCxrRft+lIstjMKV5dG0TBYrUlnxmqksA
	E0bZjx2tTz3fLymugkTGjbwXu9oBCGmNVl5IDQxhqTeiVemijbhXFeHVo0RM235pbwBYGdEizbD
	7NJTiT9F0HH4OSKxARFPQpJnljyuph7U=
X-Gm-Gg: AYBFou22yamU8AJYDwZ+sIgiG1033ALdKDrJfAzURhJCbWra/CfNIYT1jYyporUEGlY
	L5BpxQFr+3oFhsTOg5zmaDg+/BR2uE4divbDvTN2W4H/UignGKgI6j3jW5JYgAy8yMeTx/DpQpj
	qC6mC6FYvu5+dPskVIqSlBfPtbMQrOvTbr/VAZcDzCeMsx9Oourjpbjrn6Y87Zsd284HhA1dl4n
	6znKfZZcXEcqJGrMtrxsZ9SNcW7IDrfwKMZzLaJsxeERsB6udvVqA8IJ9+7d4F1UCpGuVDNZ5ni
	o6SNhidAy2ENWPghjL9P6RC118IgWu7k7nmNlMCV4/Mrq0C/BdHtbxymeZHTpOdkBwP/07PUvat
	hsDd6AJw0/fwgEA==
X-Received: by 2002:a05:622a:54b:b0:530:e6b9:f5d9 with SMTP id
 d75a77b69052e-5329e2887c3mr28806961cf.20.1789717924743; Fri, 18 Sep 2026
 00:52:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917155834.2161361-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917155834.2161361-1-vulab@iscas.ac.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 18 Sep 2026 11:51:56 +0400
X-Gm-Features: AcwNN1WPnMYUOHlV-frab_8tJfPEncIhhSiRLeqBqP4mXUOCMzFeKOSH0f4nq-I
Message-ID: <CABjd4Yy-9A0xWCDfZemHOTZDrDdtdO05nUjmN=w=sLwYjzZn8Q@mail.gmail.com>
Subject: Re: [PATCH] serial: vt8500: Fix clock reference leak in vt8500_serial_probe()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, krzk@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux@prisktech.co.nz, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 7:58=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> of_clk_get() returns a clock with a reference that has to be released
> with clk_put(). If clk_prepare_enable() fails the function returns
> without doing so, leaking the reference.
>
> Add the missing clk_put() on that error path.
>
> Fixes: 12faa35ae5cb ("serial: vt8500: UART uses gated clock rather than 2=
4Mhz reference")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/tty/serial/vt8500_serial.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt85=
00_serial.c
> index 78a1c1eea11b..fc6fdc751b16 100644
> --- a/drivers/tty/serial/vt8500_serial.c
> +++ b/drivers/tty/serial/vt8500_serial.c
> @@ -656,6 +656,7 @@ static int vt8500_serial_probe(struct platform_device=
 *pdev)
>         ret =3D clk_prepare_enable(vt8500_port->clk);
>         if (ret) {
>                 dev_err(&pdev->dev, "failed to enable clock\n");
> +               clk_put(vt8500_port->clk);

The probe function currently mixes devm-managed and manual resource
allocations, with the clk standing out in particular. Instead of
adding a manual clk_put, could you please switch the clk calls to
devm_clk_get_enabled and drop redundant boilerplate?

Best regards,
Alexey
