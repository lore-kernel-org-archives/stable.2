Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FE14266B9
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789724913; cv=none; b=EtzN6JNO8GGnIT2Z90moBAybzquIRZZqcClN2IVgYoeX5rwj3duyNaDTqHZVOgBi7No3HW+bcByMvEw8b+sWXrZ3YIGYejDJRsaZB5jThonsX71My27NObr9eom0GfnkLfzsArPvkR/dqbz54Rwi8o6Zf5onte1JUDozzBZODVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789724913; c=relaxed/simple;
	bh=MZPt/njQ/yiCw9kAPcMxqNM/6hT4kb9aHpexV2YdbAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SozSFMSaBUqiYIl2GMXdvVQ87jWvz12ayLfDurfSl7MSJjKUKP9CXG85UPI7dOa80vifGLndX8vmqQemMJmn+tQbF8ytYlqTGf83/SuSAvAzFr3SOLjGFiUhEyvLjrWCxm2ilimtApxhwB5X3Cjt2l/EPMGEDfdBZ5bEoqJ688g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lO5IHe2h; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lO5IHe2h"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396cccbba92so506430a91.0
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789724911; x=1790329711; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dkQa2qIspUk8yEWkIO1+OC37h14n8QshhY0emIiOSZw=;
        b=lO5IHe2horIQRjPV6fQOlYgPhAsfCfgmDyFxuYlJ4pqJgA34BRmWpPb1uHlCNmUTpg
         sbPBgsk/y9Dw5tKPpxThnoz7IdX7EpNhya4IVvAJ+MwvlsM16C/NKU1N5sgqXlIVBLJM
         53qDFEIx0uA3lQCb3owABRbwQLRpD4IqfXhita6fvku9EX7YVDwh4Qr3YFLi9A1E2SsG
         uH+sZesLSx17hVMZYLKq9OZizDGMhDLw/Al8oohTZKaO3PS0mKAkBK8XztDckT/tUQbn
         vRCHhvNU4ZiCwto/TEnYOJKBUmqKcGTrtSlyqNlA686seQvaSXNVf43OkI3WjzSV35+m
         EalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789724911; x=1790329711;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dkQa2qIspUk8yEWkIO1+OC37h14n8QshhY0emIiOSZw=;
        b=i5DH2NNcfnCXoibFvoC+1XIprsWiX3ZiYosE3eYJUEoAK+EKFSYoEwv11Pj2u2vbjV
         j4qrgla6oskWHTW8WBQP4i26Bq1mtPjIVDa7EZeq+ra++vvJVYHFpln5n6FE/0SFn2i4
         R/R6wJ2heAjvG4Q06hFg1dgrU1c0LcvuQNcXyBKBs2SIer37Ot2YGAnaATOyEjBwtFHi
         mfaCMxgPUj+tFIER8xBKAUjA5ypTZ7B4nNnEDFcyZoQgcXVhfimrjNfn/ElIUEXay5Ni
         qe/Bdtr5hXvZJqc64bS7rD2E727wJHMw29FPE4j9MsKvsPVbKKAU9sbWrNHAnTv3Ej20
         10QQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNNUDJqWTgiZGZj8WjbSqgHc+2g6nt9/FzXT8qt9RuAlQ/iaU7lh7gEItV4CXtok1YJx8bBbs=@vger.kernel.org
X-Gm-Message-State: AFuF++n+mgCRQfCnhgkWGxlMOyTESMLJS60GYITGd2qiaj8AcVzfuRwK
	7EDRoDILQQZb0TzqhLwDk4GVkkNxtFutuEaBw1MqJoJqA/nf8ptT3VS7
X-Gm-Gg: AYBFou29tSFATMzuDs+1GmzgiyqAK0M3CqpuVMaCwHM6MXFGtB70RZo8RY9DMeFKi1P
	1+sB0yVeNGkewbd0L5LODWntqRx//NDQrFeu6bDYCusQRprxZELE3V0qFRGImYq1ANUJQkW/NOz
	IRYRca3o5Vagr33nEBaSrkU0z7/laaT5evqqRtmZXIEkPPzT8O6kibzDJ0J3sg8yLDazm3jCg6r
	b+I7Ryz/ZNQBP1jxUiKt+JYXL2PhC0w3OVWCOl9DHxcV9Bbo+3KjimwxazKPIHPcsq6F4xckze/
	hNXDEv5m+5kY9aO6+EZ6F/RfeXmbxfO2XW9zTZr6+mAxvi7CFevWW/d7ZduefoRjjUF2HsX9Pn2
	91FD38dtta/K96MDKxYTHuuft9NWqDEAAYzVTI27O7syi6nNAq1KIkJ0kI4ogHnItEqmmBOvttc
	lzM2ORU+6K6V3g98yIcRcWqHJaW0QlbZggg/GPssRIgu+eDoMypwA4JwajtCEBTew3i+1PLtrMS
	eziVCqG5zuCJv4zJgU=
X-Received: by 2002:a17:90b:548d:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39e54d11d8dmr4503633a91.18.1789724911233;
        Fri, 18 Sep 2026 02:48:31 -0700 (PDT)
Received: from kernel ([103.219.206.97])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144ce065314sm3547378c88.14.2026.09.18.02.48.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:48:30 -0700 (PDT)
Date: Fri, 18 Sep 2026 15:18:23 +0530
From: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: clabbe@baylibre.com, davem@davemloft.net, skhan@linuxfoundation.org,
	me@brighamcampbell.com, jkoolstra@xs4all.nl,
	linux-crypto@vger.kernel.org, linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] crypto: amlogic: Fix IRQ handler return value and
 fallthrough logic
Message-ID: <aq0I57b04bh8HAyO@kernel>
References: <20260908160120.4805-1-raizudeen.kerneldev@gmail.com>
 <aqz7tT10SEMCrwV4@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqz7tT10SEMCrwV4@gondor.apana.org.au>

On Fri, Sep 18, 2026 at 06:52:05PM +1000, Herbert Xu wrote:
> On Tue, Sep 08, 2026 at 09:31:20PM +0530, Mohamad Raizudeen wrote:
> > In irqreturn_t_meson_irq_handler(), when an interrupt matches a flow
> > but the status register is empty, the driver prints an error but
> > doesn't return. It falls through the loop and incorrectly prints an
> > `unknown irq` message.
> > 
> > Fix this by returning IRQ_HANDLED immediately after the error print.
> > 
> > Additionally, the handler returns IRQ_HANDLED for genuinely unknown
> > interrupts. This masks false interrupts and prevents the kernel from
> > detecting interrupts. Return IRQ_NONE instead for unhandled
> > interrupts.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 48fe583fe5417 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
> > Signed-off-by: Mohamad Raizudeen <raizudeen.kerneldev@gmail.com>
> > ---
> >  drivers/crypto/amlogic/amlogic-gxl-core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> Please check
> 
> https://sashiko.dev/#/patchset/20260908160120.4805-1-raizudeen.kerneldev%40gmail.com
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Hi Herbert,

Thank you for pointing out. I will send the v2 soon.

Thanks,
Mohamad Raizudeen
