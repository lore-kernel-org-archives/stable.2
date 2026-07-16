Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A663BCD1A;
	Thu, 16 Jul 2026 21:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784235785; cv=none; b=frMoPMiZ85fuMeQ49ZY4h+2VkhpPE3LeoeFgWxWN+VL7XTBj+zvKIgrGXczl144C3/5uDCaAgUYxiWSpSt67Uqk6BIz/v2bYCARG77g6uXSDFJiyHAzf13+uwCCGSQH8Fh8qaANhLrmitIvGgIX6zLINuuCcQKhGO93N9ERlGM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784235785; c=relaxed/simple;
	bh=gURF/f26LtgYi+6R0afhLgaUW3MQbcR7pLq89FPcdsE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Dtu4dbT3Ba+qN46/v7bsDAkhC6qMNHLSew1gdNAxFa7YZEwUV9MAvBNQQmhroxC/SYbPITVe12UbW+yAu+E3Fejpc+iWc27hCPtnpuEv2rWa6BXb4U4p/jHNGkrGoCXyxv0CWjL4pgu52ojS2YRNtp5oxszfpfXG8jOz/f6Qia0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=noHJF1qe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="noHJF1qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA31F000E9;
	Thu, 16 Jul 2026 21:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784235784;
	bh=pKdQgrIHceIREIVVGmwICTro/Yl0whar3mIxzUvC2EQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=noHJF1qed21YcW2RCttyeswAkDNRSam4Smt5cM2wpzo8VYpTv22oZ2+GNHdD+pgnG
	 xzLmUe00opKKpwEkmGTsdxs84jodvuYUGg+jZRCkh+Ug8IzuzvaUohAWdy/8fEWxsv
	 nCXZUalcG8qYFaAXX4iqgdgTQJ331ETw9spLLm1mFS1k7LkSdWeysmOJxUIFxsIlAL
	 pwib5jEAHKkjknhbD9bzIz9ihiqVYXfSQ3E7/oxlDeXEvixtCzj4Ph2Mzrkra3uEB7
	 OS4soAVuw38ALp+fVN2oNTWeSQUxP3dSHw/6bvzAnuXpZS+eGjx96vbmEf37SSpp8H
	 /bHIP2DflS8Wg==
From: Srinivas Kandagatla <srini@kernel.org>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Neal Gompa <neal@gompa.dev>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Sasha Finkelstein <k@chaosmail.tech>, Hector Martin <marcan@marcan.st>, 
 Aelin Reidel <aelin@mainlining.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Clayton Craft <craftyguy@postmarketos.org>, 
 stable@vger.kernel.org
In-Reply-To: <20260611-apple-spmi-nvmem-cfi-v1-1-9dd90938ef4a@mainlining.org>
References: <20260611-apple-spmi-nvmem-cfi-v1-1-9dd90938ef4a@mainlining.org>
Subject: Re: [PATCH RESEND] nvmem: apple-spmi-nvmem: wrap regmap calls to
 satisfy CFI
Message-Id: <178423578232.378288.5894319743008111004.b4-ty@kernel.org>
Date: Thu, 16 Jul 2026 22:03:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 11 Jun 2026 05:46:48 +0200, Aelin Reidel wrote:
> The Apple SPMI NVMEM driver previously cast regmap_bulk_read/write to
> void * when assigning them to nvmem_config's reg_read/reg_write
> function pointers.
> 
> This cast breaks the expected function signature of nvmem_reg_read_t
> and nvmem_reg_write_t. With CFI enabled, indirect calls through
> these pointers fail:
> 
> [...]

Applied, thanks!

[1/1] nvmem: apple-spmi-nvmem: wrap regmap calls to satisfy CFI
      commit: 7089170e1df160f5f8fb395bc5aa2e2697b4e896

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>

