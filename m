Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26372395AE2;
	Thu, 13 Aug 2026 09:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612764; cv=none; b=tabu2+dZqb8HAoSlDnxG5dO3j2QT96xdSDjek8ZR/5PuTjH8Av0/0P2wV9ExjPfzZy9TVwNkwfeJMvAF0UNcrRFecJN0FkRgV07jQZBOeelQexJuD5BAxPqVCcBCvsnJndvFlDdaGzrqFArjv/R45Z4YfIXEmyELSvR/GdBg4Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612764; c=relaxed/simple;
	bh=Rvlb7d3DPVUO7Rfg/xBsTOVbCksTf2KV0DpMm1IVZm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kW+QE/Ye3aj6BIdBVHl/9M80GsEvmzUxHgCk+SU2aCEjCzCKoLpiojEJyvB4PS6tquxL+TxuUbxBVQAaIvSUasU5yv8MMR7fXSi8gXbVtimvtOobTN67j0y74eab4y8MBEyQ8E3ZRPhek/Cahai4tGrRwIvxKHSlagft/tlho5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaYTaSeR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaYTaSeR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7EF1F000E9;
	Thu, 13 Aug 2026 09:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612762;
	bh=GUbO6EHJZBA9Gb3pwMZqnqkK8tW44x4tkSu21Kl/zb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jaYTaSeR3VOJwqy6bt12Os4MdE953BmT3uquBsYvLODJLuE7OLPn6qtJ9jL6p5kc1
	 46eRqaOTMEQphlGbCnFcKi1LIDPnvqq0/yez/BR08XnjFC/5kJqeohArDWiLodTGx9
	 mn03W0AM39Ht8NSbisjdcisNicSZdj9FcRmqTfEmReDWKaRBHZMeemZpwLiVDUhBKV
	 KhSfMsgfDb/6F6O2dbGHeX56O39YHGPUifImpiIe1M++jPqkrfelEyfJx6hKhIN0Zu
	 uHaYw4d//lIm+bY+GvafkMI1QTrl2UFFf78o1qjwXKA/kMzr7EFRa1PMNbf24O5RxJ
	 EWQJQn86IsLCA==
Date: Thu, 13 Aug 2026 11:19:10 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
Cc: Bryan O'Donoghue <bod@kernel.org>, 
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>, Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Stanimir Varbanov <stanimir.varbanov@linaro.org>, Mansur Alisha Shaik <mansur@codeaurora.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abhinav Kumar <abhinav.kumar@linux.dev>, Hans Verkuil <hverkuil@kernel.org>, 
	Stefan Schmidt <stefan.schmidt@linaro.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: media: qcom,sc7280-venus: Add
 dma-coherent property
Message-ID: <20260813-prompt-peculiar-chimera-7d7dab@quoll>
References: <20260801-iris-fixes-dma-pseq-fint-v1-0-aba0cb22f6ab@oss.qualcomm.com>
 <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260801-iris-fixes-dma-pseq-fint-v1-1-aba0cb22f6ab@oss.qualcomm.com>

On Sat, Aug 01, 2026 at 01:07:27PM +0530, Vishnu Reddy wrote:
> While testing with some higher resolution clips, the venus hardware
> triggers a fault due to wrong input data being received. Corruption
> was also observed in the captured output when the client dumped it
> to a file.
> 
> On debugging, this was traced to the venus node not declaring
> dma-coherent. As a result, DMA buffers shared between the CPU and the
> venus video hardware/controller are not guaranteed to be I/O coherent:
> CPU writes to an input buffer can remain in CPU caches without being
> visible to the video hardware when it reads the same buffer, so the
> hardware receives input data that does not match what the CPU wrote.
> Likewise, on the capture path, data written by the video hardware to
> the output buffer may not be visible to the CPU, so the client reads
> stale or partial data, resulting in corruption.
> 
> Add the dma-coherent property to the venus node so that DMA buffers
> shared between the CPU and the video hardware and controller remain
> coherent.

This is confusing - dma-coherent saves you from syncing the buffers, so
how could it solve the issue? You basically skip certain cache sync
operations, not add them.

Best regards,
Krzysztof

