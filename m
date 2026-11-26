Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702258;
	b=yvPemTZEbzKJIwB7hMkKakeOKk8IwCjF4e3E1/+ExwW/G2rVPd7198eGrji4ToY2uJW0
	 rfe/6vucMzWK0Mslmg1gEKPbec1zbKUx1ivyGXWnkKqET8Y+VyqLqjPcv/7DWfSHVAZwQ
	 fXz29nSNDMBgIJ5TUZRRA5wX6/JOb+0mODLeBTK4/IvHmqOij5hr3zpoDjyCOTA3OjazR
	 DXGW35cFx7C22fcgBaOM5CSv1IWNiD4TStWCwy6ceqqtiClrQSpbae5IlzL2dFLLn1U3X
	 5KalJiHuFrvcwe1obK/jryU5s8WGz8gPA8upn/IzrTxW9Cvb0C2Z4LBUzEJesWjA21Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702258;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mmhdqFI00N1WBlVnl/3cbJ793dbxFER3bru1NLYoAdQ=;
	b=4UOuC/9C0q4Ds6+SgUnnPhY+Lz8/4AJmtMfhQfNeBF1mlOgCcsiBrAjjd/xRMSIojNcD
	 7cM3fS6DDVyr7A/N9tTRcBaXAIdZAGzU4JMJ6epGzyqwweTmz3HapHvjAQH6TPR/rLsiJ
	 bOmYhAmGpCO5BCbK96a1yXnkOmuABW77V75twUNHsK3IrX2BudBg0lLZHMfV20Ty1T0ke
	 JR1j2XbRia73q8x2Py6hK1p6nAGs6jISFdraWVDfuBhgCKruNIyHH32MZI0sGxjAXDWkX
	 LglnQfuiojWoLsx5sj5Dl0Z4mxB7DhQjvqInfadnw99VPazCOccoSQQqbe70pjuXEGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KB8bNW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 21EF8606A32A;
	Thu, 26 Nov 2026 14:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U9KB8bNW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B813A1F000EE;
	Thu, 26 Nov 2026 14:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702257;
	bh=mmhdqFI00N1WBlVnl/3cbJ793dbxFER3bru1NLYoAdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U9KB8bNWd9736dk/QI6XKLJjRYslrkd8KUeSXKqHqSbtayZiQGSalZq70LYAEGGwD
	 xSrpz3rzgTpnCGUcVA3+yiVkaourMgSk/mSYNUaaO/BVf+HypFVwooM02RvQm59eQQ
	 q7hg+bTb9YxPzMGZWFlINbuYMwFNG3edahazUhwKTY6Mnx3II9kfjbnh0zAwCr0LOf
	 oebPmei6y/82sNcAt/XiWg/KVWZeAaGfUtad1YqAff8ZK6GnbPWStx/1P9ZX8zfPro
	 0GGXzEsx05hK/p6f5Ht7NomI0PEZvM1jFrXmSYlOsQfccWN+BmFaNgW6ezvDEE5x6v
	 BU1l5fmAtNDHA==
Date: Thu, 26 Nov 2026 15:10:53 +0100
From: Bartosz Golaszewski <brgl@kernel.org>
To: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
Cc: Linus Walleij <linusw@kernel.org>, Joel Stanley <joel@jms.id.au>, 
	Andrew Jeffery <andrew@codeconstruct.com.au>, Ryan Chen <ryan_chen@aspeedtech.com>, 
	Billy Tsai <billy_tsai@aspeedtech.com>, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] gpio: aspeed: Fix potential coprocessor bank map leak
Message-ID: <st3vyhktf65rk3jzhxdefjnhsl6xxqhsu6dvi7pbudppfgt3jg@qon74p7q44vw>
References: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124135833.2275409-1-liguangshuo@mail.sdu.edu.cn>

On Tue, Nov 24, 2026 at 09:58:32PM +0800, Guangshuo Li wrote:
> The coprocessor bank map is allocated lazily but is never freed when
> the GPIO controller is removed. Its only owner is the device-managed
> GPIO private data.
> 
> Allocate the map with the controller's managed resources before
> registering the GPIO chip, so chip removal finishes before the map
> is freed. Round up the bank count to cover a partial last bank.
> 
> This issue was found by our static analysis tool under development.
> 
> Fixes: a7ca13826e47 ("gpio: aspeed: Add interfaces for co-processor to grab GPIOs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <liguangshuo@mail.sdu.edu.cn>
> ---
> Changes in v2:
>   - Use a managed array allocation instead of a cleanup action.
>   - Allocate before GPIO-chip registration so teardown callbacks finish
>     before the bank map is freed.
>   - Round up the array size to cover a partial last bank.

Please also include a lore link to the previous versions in the
changelog.

Bart
