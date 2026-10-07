Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF7844063E;
	Wed,  7 Oct 2026 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791370671; cv=none; b=ngjPzCmbLxA8Eo7C6oeLv1MszFPyoNQ8dh3cB9DsDgDHePlfyaoLij/02voaC1tmCiTNKdPhukIAE5nrExyNmY6BrxfBrGbcu3mGZjAP5viUhHrvfU/s/FxmAPHfvcF4WEQ6+J40mOelV80dEWay0B/b7W9PFcNay+INKI1R87c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791370671; c=relaxed/simple;
	bh=FKPl8K4OQMqj6x7bQKb+Ij9G0eLAP2POSsT/jjoc0PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chECE5g9uBE3PrQx37bZJsLm3SRANqy+Ng8zWBCNdhpNUwES1aefdYwRgG1RkKIE62wus98DC6dXMI6hTFgcdRel2cwJfRENmM9vDHUqPVF1yab53FV9Fs8ZWKvA/2lZyQki2TNFGR2+Pck0v8w7dEpeukNOIOFpWWcSBFRJ/nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hkudkQ9+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hkudkQ9+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB0A1F0089C;
	Wed,  7 Oct 2026 10:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791370645;
	bh=I8Hn2H3aSA+WMwgsxsNGd9M13Y6LwmNxTwB7ecQup00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hkudkQ9+E0PKtA+7QifM9ZInJQtUR3SZJcmw98WTLSmENz1O1LkWCgAOLKyY0W+tT
	 E1AwaE+mfbGRVpgZKsfx/DaIdTEMu1FjkszjTZuABW420MbdymxxxUI8jDxoJz4sE8
	 52ddQYGV3Jupzf3AaonNf/ajVi9IBBpYjxnGNUZSE47ztnwwS3TisMiDq7WKxjmNeL
	 c24OjHlQUFeX8dmpe19G74eZbcIAylk8WwqujsUEpCGeYy8JRMrtq8JfoOEYxIjJXW
	 PRcVRz/iZ2+KaLQAGaZQvWZPHtPqhuXQetMhhE85in6fDyPc9sxy9+hKeyXwupEUdb
	 yIrvXZWv9m75Q==
Date: Wed, 7 Oct 2026 12:57:22 +0200
From: Vinod Koul <vkoul@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, brgl@kernel.org,
	stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v26] dmaengine: qcom: bam_dma: free interrupt before the
 clock in error path
Message-ID: <asYlkqFPqm3_P1I4@parshuram>
References: <20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com>


Hey Bart,

On 06-10-26, 10:08, Bartosz Golaszewski wrote:
> The BAM interrupt is requested with a devres helper and so on error it's
> freed after probe() returns. We disable the clock before freeing or
> masking it so it may still fire and we may end up reading BAM registers
> with clock disabled.
> 
> Stop using devres for interrupts as we free it in remove() manually
> anyway. Add an appropriate label and free the interrupt before disabling
> the clock in error path and in remove().

This does not apply on current code, please rebase on dma/next

-- 
~Vinod
