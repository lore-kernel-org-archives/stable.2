Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8923B2FE4;
	Tue, 11 Aug 2026 18:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786474302; cv=none; b=P5rlIY3SW+BFGS9uyssjNRFmSZgtj7j2dj6flVB4cylYUKh37h6C5+d3gWv6xeWfKnXocYWUd4QHNMb8UihGaYh5ElhhC+eB0Jal4blgCsXlYyWXPZFPeez+f5MFj6ucqFccxzLx2PVHDhIpCS+PsrH3d2CRa+uY/AMbnDdFKQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786474302; c=relaxed/simple;
	bh=1N+UX6ZLIsR5I+aEW1CKXPQUwRveNc5tnvONG6fr/g0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=l2fyWAwGNhPGcGi12PMGR5ltl0BgSPitPEH3sn+uaVVFoTbjFF1JPSOO26oX25X0f6WTkwfLJOayP831Wwrh7yLCd5PWWzLRnfLwOtxTz5yL6ng07W1g5vn7/yJKIq39OW5sSsgXgk00+eWGhDVuq5moDYjTrck2kXwEnHJuRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gehtUgDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gehtUgDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA671F000E9;
	Tue, 11 Aug 2026 18:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786474300;
	bh=A4D9KJ02fzxGZMPApeHbP2Gw4eDu7VlXUhUGqHROaiQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=gehtUgDcK3IRjuIq1zNFj1j+afNf99sTQOgpAFOS0nCIoF3mVhVXYikyVz5PJ8VkO
	 +GHoAdK/pzgk0gKSP8NrF7Oha4B9dGvgS+JYA11ZqJq030klX7YM5671CqFxEkbfbg
	 J8SBgHxl4OELqmz0eoC+piNC0XwhY7EbgHKKv3tIDtlC0pzbfITF2QRwXbHVAwHQnF
	 ezfMVt/Gn4z9YE6J1bQl6H/ox7aSd7OUwZsA4Y+t5fQG+JM74XZ7lIJXECXd6zJ/H/
	 641wYKq7dGq/THfKllkg0a0NYpUDDNHOYjM37HKR9e+j/7fzQxpfl362JdmLYQg3R7
	 erFHm4wniyEzA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, Kees Cook <kees@kernel.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>, 
 Pramod Gurav <pramod.gurav@linaro.org>, linux-arm-msm@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260808110642.2770355-1-lgs201920130244@gmail.com>
References: <20260808110642.2770355-1-lgs201920130244@gmail.com>
Subject: Re: [PATCH] dmaengine: qcom-bam-dma: fix autosuspend cleanup
 during removal
Message-Id: <178647429579.1113716.13825283915355462784.b4-ty@kernel.org>
Date: Wed, 12 Aug 2026 00:21:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Sat, 08 Aug 2026 19:06:42 +0800, Guangshuo Li wrote:
> bam_dma_probe() calls pm_runtime_use_autosuspend(), but
> bam_dma_remove() does not call the matching
> pm_runtime_dont_use_autosuspend() when removing the device.
> 
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped and usage_count remains
> unbalanced.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: qcom-bam-dma: fix autosuspend cleanup during removal
      commit: a50184171235045d96104811414b25cf5338cf86

Best regards,
-- 
~Vinod


