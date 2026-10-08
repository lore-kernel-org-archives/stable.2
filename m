Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49539414A3E
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791444727; cv=none; b=iMw7EA3/e2UtcwV6Zt1SCTSwvqtNe7oE955ApGS0/u+N1LVBuQGPlBgajJnW4n95SSvMXRihCR0DyLcdWzK1YviMV9PuoD8JNxhKaN5jLZ5v7VfEKl7MitKrjqbsAqD02ufFEgXkZCRcwY9NnlDnM/V16X54lJBvLu141UI7esQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791444727; c=relaxed/simple;
	bh=R1OauTk58FGLCJ/MOr79hoSoxQboPp2ENsJOfzmEyCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoYD2RgS27Ws12hpAbTeAQlSBnWC7WNl7Q67rJ97FqabdlxFot5iOr/ka3z6WKpQWzLLnQvcV4IQvzeV2k0pO3FOKblDWVrjzpBqDXaJ/KPc3bbHyPbniC98bEb/14SJiH3Zz3KZhfxt/M8kKWTKhkkAAgheleu69yE0BCkeHSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWSzOQfM; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWSzOQfM"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a01933b584so23973125e9.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791444707; x=1792049507; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TBYqwnAjN95MxzXbUBiz1fIAS5G9TFt/mqAU6tkwBvk=;
        b=HWSzOQfMqXVe/4HDYaEpM+NCxCYL45MrZw9PDtZr85zDEPSsbkPeXb6rPcPfj4v98q
         oA9J1k+JDPHi5Cp/OWqBkwxaGZUiVActhpBCz+1ywWqm6SykFTzGMJdan58uIWLdMjIk
         MrN4/Rtg7MwbMvJeGpwFMZDiqE3Sn+UVhPvTyFgeS+9GUwxsBXzuRLHxO83hbQlYP2l1
         oYbW83KXWUcQ4oFSe1QI12+3HU63lACniHlbYFkO/dR6XCf+f8JEcKq5CZ63zzyi70J5
         m8eK/0lyYFYSlj+pDwPoN9+NSg7+dpN5UtfS+10kdSoLD1rDO6wm5ouHNTsliYXA0Glw
         5Xtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791444707; x=1792049507;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TBYqwnAjN95MxzXbUBiz1fIAS5G9TFt/mqAU6tkwBvk=;
        b=C4nfPania04gTFS/JrT9QfLz6lEXQp6j3EmwQV/QfAzZSjk47H4+32gUPNFlPdllsA
         DtenURIch1GlvQCANPR8dBg5p5uA49TyQYgCsAmBtoNN/9p69Wn1lB8o8SwLGcMSLra5
         2GrTKS6Db7UTxzsMdbFaKWzW3t8+U/eGIi16onwpq2CmkrYV/vkJSi9TLm4IZVX5Hil1
         xqQasQax0ldqw/JNtXKfVaur3eUzxkkGOjV+nGKQ3pLgIavK1Zg5RB7ba7i2NSqAic55
         bg42a4q7qEjjNA+DPiGRMzTAqNko34WqpI/FEGh8eKh+HdFgpN2VdkhOub4T4UGfMBtO
         x3Fg==
X-Forwarded-Encrypted: i=1; AKwUvBzqnQqJOvcmMYNh+9/c1kN7JhJl+Kh26fdd2HKz6yCtFhkS44AsWToiqh0BPYQORFL4pKbLloA=@vger.kernel.org
X-Gm-Message-State: AFuF++l7Ao8SYacGPiWvvi0bKQm3nta8NE/AIwlUxQ6UbJtOAOhwI1cG
	rW08SZnjMIW0akV7Ig08/FLil0h9ZOlBPO7ns1ZqbErMWgQ+WgVAQuJE
X-Gm-Gg: AYBFou1ETAXOmhas7pGxmQuxQzjLNGaMn47nbv47hLCtSiPtBbasM685DuZtW/ZZ7bG
	0jTcb/rjmdKrOvzQrERCJwD5cy9/7ytkutiwqyuYHIfxCuZJDGgb2rbQzCapH6hL1FEvh9gS168
	g6s3x6KTYe9H7p+isklwH0hk/V3HnRdAyoUW2LyGPCEYvPOUxIjz0hJPrC7HZwx+vlte7iGs5Bi
	JoYH635pE0dyHgu/mUfVVw1j+WTa5g8Nialo7oDE1wvX824dKaMk3Dd++8r61I0XV71GbkwLe8u
	o/rBsjVMANshPmy/5FZh5LoEhu2GKnKzLUZWZoxN6B3J5dnNXsUXyqg/WnvMgweG8i2seodgnOQ
	Q3MsDbPjzbfWXC8ipKepmgdmEBrpNOmBMDKb0xJyC1WdJ4OXbLfSuLrsFfNXmJGGMwT11Iub05o
	9NPDYQSO8NrtU31WmSaILZ5GEIBWetvMUvw7wFlzSztgmNqTdMCd2TNLxKw0DFq5JhzTCWsZxPT
	dJZpAbADgylpkI6pv1eaG/Gvaev+paqUeaYuWQ1t/CGXKzlG4c+87xkBnxICwADy/ug0h4drkEE
	7g/Js0XVuIkyyN3yujTWngB+26GHzFCei4mkcIjikYumg5U7x08O24+0slgcGOc51tGXTlb0jvh
	+Pa1+6o+Kf7iHikc5iDMALPUBIED0sE/eh3LVKFMejSmp9Hk/HdAzEbxDlscDVgjjLaN8kfEdsf
	r8hBPlDs7qfr4gcg1m
X-Received: by 2002:a05:600c:3b9f:b0:4a0:2644:80db with SMTP id 5b1f17b1804b1-4a180664e4fmr81750295e9.35.1791444707089;
        Thu, 08 Oct 2026 00:31:47 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1842abdb9sm47993535e9.6.2026.10.08.00.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 00:31:46 -0700 (PDT)
Date: Thu, 8 Oct 2026 09:31:16 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Alexis Bouzigues via B4 Relay
 <devnull+BouziguesAlexis.JohnDeere.com@kernel.org>
Cc: BouziguesAlexis@JohnDeere.com, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lothar Rubusch <l.rubusch@gmail.com>,
 linux@analog.com, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: adxl345: select IIO_BUFFER and
 IIO_KFIFO_BUF
Message-ID: <20261008093116.000077e1@gmail.com>
In-Reply-To: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
References: <20261007-fix-adxl345-buffer-deps-review-v1-1-0c94c8d0443a@JohnDeere.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 07 Oct 2026 09:34:16 -0500
Alexis Bouzigues via B4 Relay <devnull+BouziguesAlexis.JohnDeere.com@kernel.org> wrote:

> From: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> 
> Since the addition of FIFO watermark support, adxl345_core.c calls
> devm_iio_kfifo_buffer_setup() and iio_push_to_buffers(), but the
> ADXL345 Kconfig entry does not select IIO_BUFFER and IIO_KFIFO_BUF.
> Building with CONFIG_ADXL345_I2C=y and CONFIG_IIO_BUFFER=n fails to
> link:
> 
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_irq_handler':
>   adxl345_core.c:(.text+0x145c): undefined reference to `iio_push_to_buffers'
>   ld: drivers/iio/accel/adxl345_core.o: in function `adxl345_core_probe':
>   adxl345_core.c:(.text+0x1db6): undefined reference to `devm_iio_kfifo_buffer_setup_ext'
> 
> Add the missing selects on the hidden ADXL345 core symbol, as done for
> ADXL367, ADXL372 and ADXL380, so both the I2C and SPI front-ends are
> covered.
> 
> Fixes: cf04212d1fe7 ("iio: accel: adxl345: add FIFO with watermark events")
> Assisted-by: LLM
> Signed-off-by: Alexis Bouzigues <BouziguesAlexis@JohnDeere.com>
> ---

Tested-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
