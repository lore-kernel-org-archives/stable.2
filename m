Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AD949C4B5;
	Thu,  8 Oct 2026 12:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463425; cv=none; b=UbN59l+hWNBl0V3vYfdMcnW5sxwPRwsoeOYnqkN0yIEX8sA/VxU//lewGox660Snm5V3/MSkcXo71VWYoLTcJ0V3sY8SQr5+eJ5LjZulIIdReMNVj9wm+3KKfjXyDbzLIEFZhD+8EWIANRhuvx0dGNxC3KvuKzpOWq/lwFLuASo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463425; c=relaxed/simple;
	bh=CZEpxoj7osafW6sPXVlmd5gvfgm8mFy62rioat8DIPQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FAU+MOSs1fcGKaBR7Y8MdJaOZu5KbBF7QQgzFIY6uXQHugcVJqByHMRac+u+e31WfG3KAQT44Rcqhr0tIHrc1Yg8cxFBqWSTMjvcHfk8QjkNeU1rWPy0mBkUwrUUsFD4HruUXFjCcinZcn+OfeH0v75zGkG0jmnKbvYjjxX5zyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PnlNVr9d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PnlNVr9d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844401F00893;
	Thu,  8 Oct 2026 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463424;
	bh=C1efxFgcw8yYebQG9Ico6xaJCUlgQA5pFB/ghCLxXfk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=PnlNVr9d3tqTv2NHzuDKm5ztyQreLONH3J5MpREJkoBXrDwp20ALS3EAzY5J7FkUh
	 1SfKO5rO/AUjgU0IVsoqOwhihPR/TXOidSYTcqtcyvtC0vU26+1WlNcoFpAM291qkr
	 er5UjWjoygxxLZLYSeNfghoLhjmKUswMM03yrj0l+a9NCrf4VQRDXQBTqKSXp333gB
	 I+nTBkAu7cASWN9U7K1VsBj+e8w+2Oo1jIAL37Nzncyrkh81lOqdBG/CYpJoNR6eJF
	 1O4E4gVWnw51iwzW/sjZi0busdq7DoaSqduoELPBp8V8FESysbSd2lu3KnGir6QkmF
	 zWu3gBKoEtlMA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20261008-bam-dma-free-irq-v28-1-5e5b10de441e@oss.qualcomm.com>
References: <20261008-bam-dma-free-irq-v28-1-5e5b10de441e@oss.qualcomm.com>
Subject: Re: [PATCH v28] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Message-Id: <179146342226.488308.5545075747929342879.b4-ty@kernel.org>
Date: Thu, 08 Oct 2026 14:43:42 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 08 Oct 2026 11:54:35 +0200, Bartosz Golaszewski wrote:
> The BAM interrupt is requested with a devres helper and so on error it's
> freed after probe() returns. We disable the clock before freeing or
> masking it so it may still fire and we may end up reading BAM registers
> with clock disabled.
> 
> Stop using devres for interrupts as we free it in remove() manually
> anyway. Add an appropriate label and free the interrupt before disabling
> the clock in error path and in remove().
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom: bam_dma: free interrupt before the clock in error path
      commit: 82eed160cfa7a296ae4eb5acb8dd8f493323eea7

Best regards,
-- 
~Vinod


