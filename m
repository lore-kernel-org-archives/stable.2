Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F594349CCD
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786522816; cv=none; b=ZwuRTrDtFBMSbrY4t2oYaQrai1DtSWOeTFCEUnaI+eSIZKCbqmFGE4RtFFimose90mkkLhJzQnBvcHJ3Vk0LxVkXVycv95OH8+RjNC1RTbZkqy0cNS5XKIOYAYVURH5cnIHvnzedNOURiJ2XFbYbbHJK7tTZ1l60YptgLYq8nuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786522816; c=relaxed/simple;
	bh=19QElKc8Z4AqLbONO1diyd00Et4pA8DxWHmwjN27wXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fwy0i0TWc+UfQlEuHZ1peF5nvubMdw6lR506Ez1hx4fcRDFIPkekqqgsUUvZR7MloHS/zpjD3iTNFYviv8kD35mAB1Vd7Pl5SvEAmCGiYvGSygbRRfsz+cPb7nlbBrx6U/QjfFg/I1B41krMtIYgeKSZYWUmGrdEAfxAhhpIolw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZPc4Eur; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZPc4Eur"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49553515a8bso9733395e9.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1786522813; x=1787127613; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yr1Y7iy9IPSmNqTQd+CZP9OkFr9hJGR5T9MqLlZLr88=;
        b=RZPc4EurzQYkphc1z9Ibp0bBjvw/ffS2U/t5rZdrOehS9CqMzbaQ5zwvKIq5XEQ4DZ
         W5KNGXDWP0Q8igT1RdGN4Kc8RzqFxzdw//9aSNFNgdfw9uGQdEZjgapFRLcnKWECoFvV
         rq1mW+jlCFNmVtNkKtjWGdJ7vG3LZ6BEgsz9L1DJzxSNrsd6qGCzSncSOC05XiIIqGx/
         duKTjdYWm35dvVnjF1cPlu3g0NrMfUP7Vs8H78b4oGWJxu7Zm3LHRXdLRHIcP7+U7uV/
         pujjsj0yCzoRydqITzUzGHBG3H6pMtIvpN1FIKZ6uumZQ46JhY4bNqDO7t50oQdUzMzB
         Jz8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786522813; x=1787127613;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Yr1Y7iy9IPSmNqTQd+CZP9OkFr9hJGR5T9MqLlZLr88=;
        b=UWTddMNiBiqfjlEvMVWc11k/NNaO0sjt5qlSjKDZSMunmVL2yp8oaajnLSBaesOIwJ
         ETiUunJpHAqB+udn75T4hewLNzyI/7fSPyJ4vPmOTX4fM4/GQ8DJFoWPv9S4xmJ3Hyxq
         eTIADq5E3vsDX5WA4iomV/fQ7HB3JjOcQnkJ/irZHRfrO5AwUCakom6sRl5pFmpWonZU
         ZkjtizTMMhLMxtMNhsWj0NCETWNwIA5H5T9ST4DIr+L/BjObAhFWRYWxMMrMx/RvC+d4
         FLcfwvmdzKVFId3Krh5chx3ou1oAmvpghex1tHJCBJSA2e24Lily0QKCuxnXrvalBTKw
         COQQ==
X-Gm-Message-State: AOJu0YwCgPBk3sk4BmBTxIYqqX61qxJW1de3zXC23W/KXGp8r/kryL6I
	7VojOvOI7oqXLmKrGD/0SNrrOKHPkxcna04yQ5T2YNwGwYzvZNT5UgE5DQy87ojZD6Y=
X-Gm-Gg: AR+sD13U2HcCL6B7qPs+4R2IYuPH4ckWoRl0dyqolU8PnD1dG19131tVoxjZQIJuqJV
	Q0khjVbllYiZ1GUxDO/4eFTWOHcLCYMmTCNXTAFMvftR+1HibrMrqCmAiH6zeVmMX5A6HDhyUil
	KiVSjGE5hXFl0eFLQvAHJH9a1lq0N7/BeELIj9z5U5dgj47DdmGuaVxXDk7WCm3Rppk0p7+jQgD
	+TTA0ACClh8D8iOaoRu7gzJjAQeEf9qYM8kslfLn1Rtjn/PXOo4XPB6iKmYQRRMPqWVwuDxcYM7
	zeA5MwE9Rgb2YF9/pAufPsnrdUnlAs0j3KjKtQ8Xbjo39r+1FYPi3SkSLPVcRX1BTWT+4w9UgyA
	8dzUYtUCYlXSbJzSlz18xtA+O9vjQOIrYJ4T1mlc6zq6t3+RkwFe+jyviz73lTCS/nW7Y4qvudJ
	O2IuJQ3HW+VSYUIxlGcaoUVvf24ZQRJ9TJnNNPwAQ11GnvgK8Bm6KhMVehQB/fRwJzqw==
X-Received: by 2002:a05:600d:6446:10b0:499:593c:3384 with SMTP id 5b1f17b1804b1-4997c1070f3mr28058535e9.6.1786522812683;
        Wed, 12 Aug 2026 01:20:12 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aaa5d04sm51386525e9.2.2026.08.12.01.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 01:20:12 -0700 (PDT)
Message-ID: <ff3580ae-1b04-49b7-b438-e8ee5a0c04a9@linaro.org>
Date: Wed, 12 Aug 2026 09:20:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12.y] spi: spi-fsl-dspi: Avoid setup_accel logic for DMA
 transfers
To: Vladimir Oltean <olteanv@gmail.com>, Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Larisa Grigore <larisa.grigore@nxp.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mehmet Fide <mehmet.fide@gmail.com>
References: <20260811091322.3592403-1-mehmet.fide@gmail.com>
 <20260811184500.stable-0013-sashal@kernel.org>
 <20260811212856.4wp56ryqgtgzahhc@skbuf>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260811212856.4wp56ryqgtgzahhc@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/08/2026 22:28, Vladimir Oltean wrote:
> On Tue, Aug 11, 2026 at 02:55:56PM -0400, Sasha Levin wrote:
>>> Either way the behaviour is the same. On vf610 in DMA mode the accel path drops
>>> the tail of odd length transfers and byte swaps under SPI_LSB_FIRST, and this
>>> commit removes both. That is what makes it worth having in 6.12.y, whatever the
>>> original intent was.
>>
>> cac7e5054115 ("spi: spi-fsl-dspi: Avoid setup_accel logic for DMA transfers")
>> applies cleanly to 6.12 with no dependencies, so this is not a mechanical
>> question - it is whether it qualifies. It has no Fixes: tag and no stable tag,
>> and James reads it as a refactor.
>>
>> Larisa, Mark, Vladimir - was this a fix? If so, a Fixes: tag would let me take
>> it here and on the older trees, where it applies just as cleanly.
>>
>> -- 
>> Thanks,
>> Sasha
> 
> It wasn't understood as a correctness change until now, but yes, it is a fix.
> 
> Fixes: a957499bd437 ("spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode")
> Acked-by: Vladimir Oltean <olteanv@gmail.com>
> 
> Explanation:
> As part of the original introduction of dspi_setup_accel() in commit
> 6c1c26ecd9a3 ("spi: spi-fsl-dspi: Accelerate transfers using larger word
> size if possible"), it was well understood that this is not applicable
> to DMA transfers.
> 
> The reason is that the correct clustering of 8 bit frames into 16 bit PUSHR
> transfers ultimately depends on the ability to modify the SPI_CTAR_FMSZ
> (frame size) on the go. In the case of a 3 byte SPI transfer using
> 8-on-16 acceleration, the logic of this clustering is to first transfer
> the first 2 bytes using a 16-bit PUSHR transfer (with SPI_CTAR_FMSZ=15),
> then to update SPI_CTAR_FMSZ=7 in order to be able to push the last byte
> using a single 8-bit PUSHR write.
> 
> The difference between FIFO mode and DMA mode is that in DMA mode, there
> is no software hook to update SPI_CTAR_FMSZ in between PUSHR FIFO
> updates. The DMA engine handles them.
> 
> This was well understood and was the basis of this code path, which
> explicitly excluded DMA from dspi_setup_accel() with its dynamic frame
> size updating:
> 
> 		/*
> 		 * Static CTAR setup for modes that don't dynamically adjust it
> 		 * via dspi_setup_accel (aka for DMA)
> 		 */
> 		regmap_write(dspi->regmap, SPI_CTAR(0),
> 			     dspi->cur_chip->ctar_val |
> 			     SPI_FRAME_BITS(transfer->bits_per_word));
> 
> However, this truth was forgotten soon after, because as soon as a bug
> report came in - the trigger behind commit a957499bd437 ("spi:
> spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode") - it became
> broken.
> 
> Namely, the separate code path for static SPI_CTAR_FMSZ settings for DMA
> mode got deleted, and dspi_dma_xfer() started calling dspi_setup_accel().
> This had two effects:
> - dspi_setup_accel() correctly updates dspi->oper_word_size, necessary
>    in common code: intended, fixes the bug reported by Michael Walle
> - dspi_setup_accel() enables 8-on-16 acceleration for DMA mode now,
>    which will transfer 1 byte too few if the buffer size is odd (it
>    incorrectly assumes that the caller can dynamically alter
>    SPI_CTAR_FMSZ and then send the trailing word separately):
>    unintended, causes the bug reported by Mehmet Fide
> 
> The breakage probably went largely unnoticed because Michael Walle's
> peripheral only used even-sized buffers (a flash, IIRC), and the silicon
> on which I regularly test the DSPI driver doesn't use DMA.
> 
> The commit under question here - cac7e5054115 ("spi: spi-fsl-dspi: Avoid
> setup_accel logic for DMA transfers") - fixes the unintended side effect
> while maintaining the intention of previous bug fix a957499bd437 ("spi:
> spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode"). By having
> the "goto no_accel", we bypass the 8-on-16 acceleration on DMA, while
> still assigning dspi->oper_word_size - which was the reason for calling
> dspi_setup_accel() in the first place.
> 
> Note that 8-on-16 acceleration is not intrinsically broken for DMA mode
> (it can yield a DMA buffer more densely packed with PUSHR data), it just

My commit message on cac7e5054115 was probably a bit misleading then, 
because there is some benefit. I was only thinking from the point of the 
FIFO, not the memory backing a DMA transfer.

> needs more work to skip it for odd-sized transfers. However, that work
> may or may not be justified from a performance standpoint, so the
> approach taken here is reasonable.
> 

The commit could have mentioned that it wastes 1 byte per entry in favor 
of simplicity and correctness. But DMA isn't limited in size like the 
FIFO, so waste isn't an issue.

> 
> Regarding the SPI_LSB_FIRST issue - from the description it seems to be
> a completely distinct problem not intrinsically limited to DMA mode
> (should also be visible in XSPI mode), so disabling dspi_setup_accel()
> on Vyber and Coldfire only partially addresses it.
> 
> I don't have a use case for SPI_LSB_FIRST peripherals, so I don't
> personally mind another "goto no_accel" follow-up patch rather than
> fixing the underlying byte packing mechanism, BUT this should be done
> by the issue reporter with a proper explanation in the commit message
> now that the issue is more clearly understood, rather than just be
> happy that backporting commit cac7e5054115 sidesteps the problem on his
> platform.
> 
> I am currently on vacation, and I am unable to do much testing on actual
> hardware. I also haven't completely evaluated the SPI_LSB_FIRST behaviour
> with 8-on-16 acceleration, it just *seems* plausible that there is an issue.

