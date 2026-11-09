Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794226340;
	b=z/bmC4za9sacc55g9syFuUC2ppgeERS546tc2kOA6BtZ9C5AbdG7VDMuRGnAhyfbNbTy
	 DDHqXZ9mYzhRA7ze46DG9W0Ieeu0Ah6KdfDqIAc/IozOM8R44p2HPV0G9yiRR5+3XUbgr
	 6sAzRwlsQfZiGhOQUBC5FIQw2pEhVPsLyu2yxbphtd9Dl0+OQCKjYWMlm7oGzIvR97H2L
	 Nantmp54hYZAr1OSQaOd626mUPN/9qRxtu4w4bUoVmmuaTe2iSNDexaUagNp1Rcu+0yI3
	 uUaN1Ojr2K7Yw1xJ++vA8X9J0E86idj0FFzGCVTH/R75J1Ls108vycWT7/FFl6V9oVg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226340;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Ahqk8ZpP9+E3a7lm4QE+U0OG00vjkXyfuDjP8/SbDI=;
	b=Hk6ar+3OlUFA5dnmjTJ29WYllZds+1lGaApqfihI9WZVEkG8EJxnmgWWMNKHlzWAICis
	 xpGvAl/hEi1nhBR8ou6aw/FNPvIGhDGRPjIxx4baLyJ4gu3VY4JB/MiKLU87lMyJajxSy
	 irGTh3MnJceDhTTwhBtYk4wvOsn8JX2W0unmW/nzEGL3kpmC450QBzdaynHVkxJjW7qdb
	 O4A28miJ3lbhd7HkEAMkRLWRuwQw52EhaJtwkjEiaL1yWITkK9KDJytVBMxtbsKvYGq+P
	 5Uvs6zhNUUjRZBHmkAlXNEaoRBYErw6Ca8uW8sMNpuSQkvz5KQA6lMzk5LT1Dmqe4ZA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqIucLVG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3889606A31C;
	Mon,  9 Nov 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QqIucLVG
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794226339;
	b=tJz8WwEBG0hJMIfG0A1m1sogIkujJ2XBTPP9hjDXOetrqXo2E6FQsaIZPbaJziNSeFST
	 grOk887BQMbebBgJtsBSDrvc8i5JkcCC6ArZP5LJwMiaLGxnaC2+dLrMiX2ujTdyjSB+8
	 ZOzEx7SgT5jBz8F6JLtJg+HbHbDcqQSKRGY8LKburJFoKkpuH/9xllk1d8saej59Upxau
	 O9HezIH1v4QiHo0gUJLKOdJdu94peNm0i2D7mM6X3GRmL+ysvx1drRfpofDofO9UFNddf
	 47JABJmhB9Erzii2eKqIU4flfG4d48/uKHa1IQ9vtI7S7KIwwH1QC3bw/qQzPIRTLvw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794226339;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=6Ahqk8ZpP9+E3a7lm4QE+U0OG00vjkXyfuDjP8/SbDI=;
	b=CzRXsX1faeJDN06aYngcaDFxAtzTawAbjM7YADvhZWg77ZtUWhjaMpaM1EVfer5BKl/A
	 Qee2zwdDGFmVIE9dUNrplHuB96hnfkCVAllj8V746tomX28psKTpqAq71IAsZgbaO7GQ8
	 2RdQG46McG3iBlA2AzWemGUzK2xfDL/6hoqHi6DhmSN6kWL1NpPlVDicyHJg5/g+t+8dd
	 iuj5cocsXOO/YNdgHSl8M4UmU7C4pIHZPQDzEKgnSEZWcHvdZEe+fW7PgtYx5BOzHQ+G5
	 DtF0QB1A3BsDqChl7QfuTSyyh3kqUksIW9hYd2oITBYlgynwh0q8MdN6+9hQyKgyYew==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id CCBFF1F0089F;
	Mon,  9 Nov 2026 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794226339;
	bh=6Ahqk8ZpP9+E3a7lm4QE+U0OG00vjkXyfuDjP8/SbDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QqIucLVGJHLAfpODDVaGOCu6CdEu161HwHgPQ8hWtNxYKgY+D2BU+eKHYb1WcpQzI
	 Syo39g9lIyhVng1aHa9o5w4LdcOIiBQCBOXGKZZdSP0GiHyh6gbDwP5DI23SnR3+yO
	 gfDtJtdOFboifQaGwl288Y9djUwyHi0h4aVqOcSes0uzJ+veuFEvoh5c7EtP+rA53A
	 qZh6BFsUS4UkEzGC/6cXQxJokgmMUHq5L0TzjgDmd/w3/CWKIce9sOnrOUBBq4pqnh
	 uG96iGFwl6sCoMM4X+f2IBEbn94FxSea63D8BzAYBb/add/DI+dvovj76mF1zfrsaD
	 w1v/mctI1W4jw==
Date: Mon, 9 Nov 2026 13:12:08 +0100
From: Joshua Crofts <crofts@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, luiz.von.dentz@intel.com, brgl@kernel.org,
 pmenzel@molgen.mpg.de, pengpeng@iscas.ac.cn, u.kleine-koenig@baylibre.com,
 lars@metafoo.de, mike.looijmans@topic.nl, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ltc2471: Fix LTC2473 differential offset
Message-ID: <20261109131208.00006886@kernel.org>
In-Reply-To: <AD0B78CBE86D2045+20261109100659.3796603-1-raoxu@uniontech.com>
References: <AD0B78CBE86D2045+20261109100659.3796603-1-raoxu@uniontech.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Nov 2026 18:06:59 +0800
raoxu <raoxu@uniontech.com> wrote:

> From: Xu Rao <raoxu@uniontech.com>
> 
> The LTC2473 reports its differential conversion result as an unsigned
> 16-bit value spanning -VREF to +VREF. The IIO scale is consequently
> reported as 2 * VREF divided by 2^16.
> 
> IIO offsets are expressed in raw codes, but the driver currently returns
> -LTC2471_VREF, which is a millivolt value. This makes the processed
> reading incorrect: with a 1.25 V reference, the midpoint raw code is
> shifted by 1250 instead of 32768 codes.
> 
> Return the raw-code offset so that the midpoint maps to 0 mV and the
> endpoints map to -VREF and +VREF as intended. The single-ended LTC2471
> does not expose the offset attribute and is unaffected.
> 
> The supplied fix was reviewed and this commit message prepared with
> OpenCode AI assistance.
> 
> Fixes: 1d3eacbfa644 ("iio: Add LTC2471/LTC2473 driver")
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> Cc: stable@vger.kernel.org
> ---

Looks fine, but please wait at least 24 hours before sending a
new version. If you spot an issue after sending the patch, please
reply to it describing the problem.

Reviewed-by: Joshua Crofts <crofts@kernel.org>

-- 
Kind regards,
Joshua Crofts
