Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F714CDA0E;
	Mon,  5 Oct 2026 15:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215253; cv=none; b=PDU43efVqtDGI6OvHGI5pFr9S3z16Z7QRjH658WsBYxiyz56KUCCBnk95AcEtEfRGHCpDWpYAdoHrFAEtPXG6Ytfh70Y/wq3ZJu+NRdiKBzRIVEkd0CDxrG85UDJZ0lBdfpj4g4nch3Kwlb5iXG5V9Ft9KZApCTZpPgW+yIgorQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215253; c=relaxed/simple;
	bh=/cfHVsE3Z47Zo24L4kNcrdQdPx9Z/yW7QH/AN32B89M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RAKpYeBmDqdqNxY738tFY1n+Qh14NTiJSYinnvQ3jtVcm4ScUNDidbLFvdPXsrsK97LXGmi8YGdkye2EvMkMOLfRrjxNzLpUhQ1vWSdmlozk3JJW3EoOAPMyYoE+9eazXyan7KMUkb7m7WVUlwqUpPn3q0vyNrSzWXsQFx5Uhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+R8s7ct; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+R8s7ct"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE14A1F00893;
	Mon,  5 Oct 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215252;
	bh=w+aP+2ZMs4RwaMICIdfZWNaeh5/3kQLyQSBNcq8U96Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j+R8s7ctKNHU6JFfe0wAv+NS/AA2Or9wDfMAqDs13CNWdrjKQjt0w8IEKm/TGmMmg
	 cde5MHHYMrYmedvgy5MNBRu34/Fcf8rrsqDyhd/UTcmfC8W2cn+OBLCJCwq/6CoOPc
	 dfgJX5YGfp+PSG1wdltFrJzR2uLJOsexcHfZyOvA+MmLMGKiKEwwlju55FXju9Y5OX
	 dhjo68+JDlm7hljeZ4li4DFI2NKFm9I97HEsmiCRI6OXryzc3T6aiJvsS3c+P06+TJ
	 SAsLWUg4Wywwpfa5mQa3pcQBcvnsVyeGvhpm7M6kOKH0oCj9eqlW49ToI0BjyVtuaN
	 2mzHI1SS/QHqQ==
Date: Mon, 5 Oct 2026 17:47:29 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, brgl@kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v25] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Message-ID: <asPGkQDjiR99ih1L@parshuram>
References: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-bam-dma-free-irq-v25-1-f39e01d19910@oss.qualcomm.com>

On 02-10-26, 10:51, Bartosz Golaszewski wrote:
> The BAM interrupt is requested with a devres helper and so on error it's
> freed after probe() returns. We disable the clock before freeing or
> masking it so it may still fire and we may end up reading BAM registers
> with clock disabled.
> 
> Stop using devres for interrupts as we free it in remove() manually
> anyway. Add an appropriate label and free the interrupt before disabling
> the clock in error path and in remove().

This doesnt apply on the current code, can you pleease rebase on the
next

-- 
~Vinod
