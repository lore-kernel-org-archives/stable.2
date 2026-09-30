Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC91B4257;
	Wed, 30 Sep 2026 21:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790802557; cv=none; b=EEYymcTFejIwRbwWKFFF5aKyeVegO03BFrC+7j375cIhwQBH91CvO58xgZf4jg14mgEGaeHgQmtkRtDrGsVr8uEjhSR7F/t1UzEVCGWhJppsohUW/unB0GPDshTkAI+SN4deflM/tl9WEg5odUeqqvRyDZa+MSxQmmwNxghHEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790802557; c=relaxed/simple;
	bh=+h1AK9FaSIZu4NK6+sAY/ZpVVNKWLNdH+DcFotpcdZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFZmTHRdhtD0hAXDsRQRw8BUkHXDIP+OkkNe0JhygLbTai2xIgPNckIMCweb/oJrWMO7u539HHfl2oRcM9KBOu8pBWXoNaWrPex29XO3iPtKPUIGG+KHlmmMoiMK8Gf6d69qGMvIcoUDHXGlHShPQIvmzGhPaifFs3Ibc6se1pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WuZ00+LH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WuZ00+LH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F0F1F000FF;
	Wed, 30 Sep 2026 21:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790802556;
	bh=SIVklcNVbiwOf1YM8imRfWd4HLfUgFmK2z7Gpu6faAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WuZ00+LHSuJ8eE2fKvVK/YQZtJy+/MwM+iWNyVELGtf8qy3VDkaWZLX7NHYsRrTfR
	 uOHmYDH3Z0j9wB46AJ5XqMPwmGSKDggUPucDFOgY+GB9e8h4lV8cL0KqDKKTJwUUGj
	 XkaJ7/F3LUOm+UgW3WS075xZ1VWL2e1g3uKHdPzSzaXoxshxoQmIZF/+8Rk5QidAxx
	 3tbPDdv7ixljJ1RjId143jTFEZWCY3zOgS+8NSjvNZxiGE7DSjKPki/RquL/MU2gnq
	 z1Ks3AkKqfgdsg8OoiMmJ32liHhDYCrv/KCe1A/vOVQj0Nald5K0a6mx1i9sKmpHiT
	 UT/pTnO+fPOnA==
Date: Wed, 30 Sep 2026 16:09:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: saravanak@kernel.org, devicetree@vger.kernel.org, Julia.Lawall@lip6.fr,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] of/irq: Fix remaining refcount leaks in of_irq_init()
Message-ID: <179080255383.270996.7058123919952080909.robh@kernel.org>
References: <20260917124247.2151674-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917124247.2151674-1-vulab@iscas.ac.cn>


On Thu, 17 Sep 2026 12:42:47 +0000, Wentao Liang wrote:
> Successfully initialized controllers are moved to intc_parent_list,
> but the final cleanup only frees the descriptors. The device node
> references taken with of_node_get() and the interrupt parent
> references are therefore leaked on the normal return path. Drop both
> before kfree(), as the intc_desc_list cleanup already does.
> 
> Fixes: 8363ccb917c6 ("of/irq: add missing of_node_put")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/of/irq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Applied, thanks!

