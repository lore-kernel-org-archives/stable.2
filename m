Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45A53D4105;
	Wed, 19 Aug 2026 07:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123811; cv=none; b=Q9sIZ01C8swAKXgqops9VboLldf7bj9ihb/Tv1HGacDZAEOUKNz274H1+3kipsA4QLQVpqlJR2rI+kzqHgagdbejWRn5M00aJHVo1Lb+B14/Smooel/y5dXBmKUa1NN+T4JxZjJg8QxQ9UNw5pHedjFY4msmhxliaH+fn4JliQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123811; c=relaxed/simple;
	bh=Yj3s3fKgbLzmS70kBNGTJHXUvueoOryMugMhqrLz6mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftmwE7BKO0pN7qvNTC7XrAyWGPusH4l3YKt+7Je3eG815gjouEj/UOIsooOx9jj5re3yoAtPr6SLWpOKpjFL7pg5qyV0UtOQJN1QGKCDogX+kB3ZEfVH3guqxWs5nHdF7S4sAs0HQ7tVD/dpQIwd+tSqAzdXJF9Vx39zqi5YQqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD5CETUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD5CETUX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CCEC1F000E9;
	Wed, 19 Aug 2026 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787123809;
	bh=nSHRVZTg8PJ4gqBdu76l1GN1bM+sGswAZwFhZZjgELc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kD5CETUXTvagSY+WEEb66feo7NRLWafrMRKvQggE+okWzCBIJ6yIQSuWQihwj3W8x
	 UjadJJ7mVrdNvtpJMPHSi/CGmGic3sRvdReh2WCkAA3ZWOnntA31RY0k45DscaxYXh
	 SjibM9tGMBID97S5y99j+reE8V6wnzwFGOCAaspuo4Mfhxg9mW59XceyzjQAlp+IVY
	 OxObSH74x4hyERvKHregbEjUF4WSIO5oeQqdV6vJ5h523kQGwDBKc7iJVP+KKyzLfs
	 ktCA5wAGvJqM/i2UO67xKqjL7la3HeHEMjwefspeD4WQyhZIlyASHp9WcAa7mTvhMF
	 5JvdKuzylIeSw==
Date: Wed, 19 Aug 2026 09:16:45 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>, 
	Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, Abhinav Kumar <abhinav.kumar@linux.dev>, 
	Bryan O'Donoghue <bod@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Stanimir Varbanov <stanimir.varbanov@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Hans Verkuil <hverkuil@kernel.org>, Stefan Schmidt <stefan.schmidt@linaro.org>, 
	Hans Verkuil <hverkuil+cisco@kernel.org>, Mansur Alisha Shaik <mansur@codeaurora.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org, 
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: Re: [PATCH v2 3/5] arm64: dts: qcom: sc7280: Add dma-coherent
 property into venus node
Message-ID: <20260819-daffy-armored-angelfish-3be5b1@quoll>
References: <20260818-iris-fixes-dma-pseq-fint-v2-0-8dc8c4b3880e@oss.qualcomm.com>
 <20260818-iris-fixes-dma-pseq-fint-v2-3-8dc8c4b3880e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818-iris-fixes-dma-pseq-fint-v2-3-8dc8c4b3880e@oss.qualcomm.com>

On Tue, Aug 18, 2026 at 09:24:16PM +0530, Vishnu Reddy wrote:
> The venus video hardware on SC7280 is IO-coherent hardware: even though
> the driver does dma_sync*() calls for the input and output buffers, the
> venus node still needs to declare dma-coherent so that the DMA mapping
> layer relies on this hardware level snooping to keep the CPU cache and
> the DMA buffers in sync. This avoids the unnecessary cache clean or
> invalidate operations performed by the dma_sync*() calls, which are not
> required once hardware level snooping is enabled via dma-coherent.
> 
> Add the dma-coherent property to the venus node to describe this
> hardware capability.
> 
> Fixes: 37613aee2179 ("arm64: dts: qcom: sc7280: Add venus DT node")
> Cc: stable@vger.kernel.org

Nope, nothing to be fixed here. I already said it last time.

Best regards,
Krzysztof

