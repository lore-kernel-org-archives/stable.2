Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF894AB1C2;
	Mon, 21 Sep 2026 15:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003872; cv=none; b=dFG+M92actC4rwKPcxUp05o/x1iccmlGTgdEC4Ob6iWOwku06d9y+/+s5TpGPP5GoQ/1nIi1zV8njNxfNRRnA3WQzZA9n1BDiWUIqJ6BxsnzzLbZHD+WfQyTIO6sqPk7PpgiCwlivnPYQNwma4U536e3elPaw8lA0Lj+nK5fMAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003872; c=relaxed/simple;
	bh=XiIYsOrPmhTtSAq297RuJeu7Kh60ICy+5B0ekAL4U7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUXuBLl01Pi/z1oC8L5qOvwT6tzIND4dh1D491V8pKK0DqEe7aMOXbK690n52MPKYMYlUoIYxULPykZ5AZEp6nrcBIRR0Pt72aytlZqT5jA7YncB4DNCpZfxFbrGsJBpzTR6RIe4swOHsGSLfbc94isEAc4FiZrAPrhtfUz2Nk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvsSq7bG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvsSq7bG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 204551F000FF;
	Mon, 21 Sep 2026 15:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003870;
	bh=FZeopfMMZGjaWtQq8rssdR4HwEQQbLQYNh1E8IOw0DI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FvsSq7bGpr+WQkIRqKbIFqhznCehDavMsy+xrRUogym6mY3wQDOFmTHYiBDR5utUy
	 xXnFOx0VI7OXvgUC4z2/HHL/SEm6ko7DVLbT+YWQ1jydr5XkbvhZI45RuAkLLNnxhd
	 N+A0c7UsjQhvT2to6O5OzXKZDEmjTWodrS8LweVr6zuveCd+qWq2MyQqbecvRFnYtO
	 jf06uhx5elUfYm7NkEy6yNp/gyfuP85YU6do3J+txWMitujkhsoByVbFO6oji5QpNk
	 Z/OSu5MZCfcv0CKizE1chWr9RjK8uNUA4aBue93UMThW1qFJQDzxRsB34Of1JxSXYw
	 ouyM6iHUmQJBw==
Date: Mon, 21 Sep 2026 17:17:46 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: richard@nod.at, alexandre.belloni@bootlin.com, 
	linux-mtd@lists.infradead.org, vigneshr@ti.com, bbrezillon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	nicolas.ferre@microchip.com, stable@vger.kernel.org, miquel.raynal@bootlin.com, 
	claudiu.beznea@tuxon.dev
Subject: Re: [PATCH] mtd: rawnand: atmel: Fix HSMC clock leak in legacy
 controller init
Message-ID: <arFKmdQULrC47WYe@quoll>
References: <20260917102804.2146887-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260917102804.2146887-1-vulab@iscas.ac.cn>


On Thu, 17 Sep 2026 10:28:04 +0000, Wentao Liang wrote:
> atmel_hsmc_nand_controller_legacy_init() takes a reference to the
> HSMC clock with of_clk_get() and enables it, but the error paths
> that follow only release the device node, so both the reference and
> the enable are leaked whenever the controller cannot be fully
> initialized.  The probe fails in that case and never reaches
> atmel_hsmc_nand_controller_remove(), which is where the clock is
> normally disabled and put.
> 
> Add an err_disable_clk path that disables and releases the clock
> before jumping to the existing out path.
> 
> Fixes: f88fc122cc34 ("mtd: nand: Cleanup/rework the atmel_nand driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/mtd/nand/raw/atmel/nand-controller.c | 25 +++++++++++++-------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



