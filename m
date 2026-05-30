Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0781AA8;
	Sat, 30 May 2026 20:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173625; cv=none; b=fCeyF17V5iN9pw/fZZu9X7XRLBuWA8Eh+leYZ26h7Ug/A34689gLI+vMwRgFPUt4ehu/exNP3BUFuRDFLdcxbsbJRrmeAJ4X4UZFf4Y93pBmZ2p/ZjrMedHL2k1SVnBa6xlUjrHsfz1953x6hrQ+VLKvHrFri00Sk8jtfeTTHWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173625; c=relaxed/simple;
	bh=WgRkJOyBiuORez769sm6fL6zDgEr+JalV+KLoc5lR/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jlEYqUi1AI6mCGf10x/lwJSq4IuUFu5Cqi5by6uIVEzRzyHWST4aZa8q8L/8VSSjTJDV7j4S+3aEy42u6Bjnt7RlHg35M9g2fSKc9QNepZTNBtEWanVqGKHROWM/umyhPQUXllHTsYdB/THGKlIXOjswKLjy8by4vbkQ+zfKsy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIpqfVws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIpqfVws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22D441F00893;
	Sat, 30 May 2026 20:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173624;
	bh=h6P+4e18fj4Wo82Qkuu3Z3wXeaTA4vAtamdzZqsN1ig=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DIpqfVwsm/HJ1F9r/8VeiZdmNQQkJJsEbE85O3yvhVqKIllwKU5ccJq1JpUJYt7z0
	 NyHHYP5KDKCXLoWF6ZOQuE72cK0IuvUWO7CtDHlPk/1L9KppzEWtwbtlYWeT//2ejC
	 FZos0sWv+l8ULfPNGYrzQjA0N8ax6ghzn+fdhIImSA7C2lZZe98HgsRZIn7v0IYWNU
	 159Ns+FklN+5soPoj/AJ299ily9AFe2/Z7RqG1HkNaFx18NERLvN57kT5JWysv3Yau
	 ioMDsqhAtBIzgAH+VAb8AWMHKMYXf97r+inzOOUR/1fL6hFe4jQcUnh98+tsMHB0lR
	 ca2FUa1EAuXvw==
From: Srinivas Kandagatla <srini@kernel.org>
To: Bartosz Golaszewski <brgl@kernel.org>, Johan Hovold <johan@kernel.org>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org
In-Reply-To: <20260521-nvmem-unbind-v4-0-7fa136759491@oss.qualcomm.com>
References: <20260521-nvmem-unbind-v4-0-7fa136759491@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v4 00/10] nvmem: rework nvmem core and allow
 unbinding with active consumers
Message-Id: <178017362283.116578.3318264066349893407.b4-ty@kernel.org>
Date: Sat, 30 May 2026 21:40:22 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 21 May 2026 16:25:33 +0200, Bartosz Golaszewski wrote:
> Sashiko pointed out some issues so this iteration fixes them. I'm also
> Cc'ing Loic who seems to have encountered the issue of unbinding with
> active consumers when working on the block nvmem provider.
> 
> Nvmem is one of the subsystems vulnerable to object life-time issues.
> The memory nvmem core dereferences is owned by nvmem providers which can
> be unbound at any time and even though nvmem devices themselves are
> reference-counted, there's no synchronization with the provider modules.
> 
> [...]

Applied, thanks!

[01/10] nvmem: core: fix use-after-free bugs in error paths
        commit: 034b31a7b03d5d0a0bf1ad67ccb84c2ddaddd7c2

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

