Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6055D495517;
	Thu,  8 Oct 2026 12:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791463423; cv=none; b=NSJTnK6EpICyHpqO7x7u+xFyk0HvJ6zY4qKnPTiiBz2+QpwY5q2of9VQGTtcYPi2G2vICNQ20di2b1FJmWK0KPIRTgy+khqEHx49Q2EokP57FzDs5ldBgxfQxmgnuqxvCinKapQ2mOsf0wCag7cBE8fowqgi8FZ4EEWpjGt0YEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791463423; c=relaxed/simple;
	bh=HoV+OFLwXq4GWYAT3Gv7nYfWq/HmqlaGoiIWaG1I+Yw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cjqsJYj3semtZPOwM/zvaDTg8pTCgxY3iOZAeQy3++3FYXfB2A8GQkqDNEE7VsQFrNm28UBPWUncmcu9dkYrV9VlmyEAQzpn1aNEv5uasVFpsAiaCHfhR16SH66UDUIpK+yiIFxrcZWLzc21rK2elBOahLlWPu4+SVcTG3RM9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XiUhDp32; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XiUhDp32"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D66BE1F000FF;
	Thu,  8 Oct 2026 12:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791463422;
	bh=Fr6lprjqXKeoj+K3xBxYBGrVIrwlOpJEEWvZwKmyIIc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XiUhDp32+CL2rCQeKh/UjvrCv9HC1AKIvijTltddVK/Q7HqJTva4QKZNJTq4xPrzY
	 mNJHDncS66pBwJTMZGslqYbdo8TfAx8shmtL08vDqukF12c++iMjdQIVfOhKHAZ9Pf
	 EmjRiUxRpGFHwEiBPlpNN90oCvrd1jKuR/2bpNgYyrlmM95oqGiNcZnnuJT8QWPZ5F
	 sx2CQvnIm7LhvdMiw/STt8wqP2ZiuokGzJTz7oQISZiCNCpcX8Z02Vxz33s4eVPOxe
	 Jl+QVfet4pAjIBOE9rPgkx+5lOmqDdm3hzSWQbV9UnbNQzBrrNVxogAETwPvBj9k8j
	 XfzqjqFbDbVuA==
From: Vinod Koul <vkoul@kernel.org>
To: Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@codeaurora.org>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
In-Reply-To: <20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com>
References: <20261006-bam-dma-free-irq-v26-1-eef5c713d831@oss.qualcomm.com>
Subject: Re: [PATCH v26] dmaengine: qcom: bam_dma: free interrupt before
 the clock in error path
Message-Id: <179146341953.488308.18215967421549392555.b4-ty@kernel.org>
Date: Thu, 08 Oct 2026 14:43:39 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 06 Oct 2026 10:08:11 +0200, Bartosz Golaszewski wrote:
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


