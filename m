Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F202C21DF;
	Fri,  2 Oct 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790959209; cv=none; b=XAvDRvab0RSpOwHN4rjb9Ovl6r8Ja3Q9lQUHRff5A56kLQguTAsLMvv8pGvi+9Yos7A6Ns1Jtwap9Mc3eIADmLN2sTGdOtImRKHEDGNEywkkAz5dc2pRion1TXQ4j3i/sHDix4+wgcmwxElGZrQ/zhkhreZYvtcWJjminF5mVi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790959209; c=relaxed/simple;
	bh=GWRXLuApdOXNBbZoTAAUxFcvXzBXm9BOLVab+OzuOrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jSYlMIByD4BZlD6ngubxIYVzbMLmAWMlfeDlKS1zgX+V7wSY5YYN4ih+gF5jdT4BQ4YhQE4wVPaH1h3gJr9DWAYbOyQJ4gu43ckYMS4/E5ja2kuG3n93wcZugQGI36PWWF6vPqU2uQUt1HsRVxOxNxa72HbXVs2ZailAtFyuODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z62xCQqp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z62xCQqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1A91F000FF;
	Fri,  2 Oct 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790959207;
	bh=MODovUH2EPungsOx04HErzxq0+Lkt9i34L4BQl/yKd4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z62xCQqpgbeG6UWiAfvR02PjcmAbbXiBOIweUSpjSbLyJKuS3/aP5L0umC8vm9npG
	 vfaSVo8DVBN10W7fh9xyJUEcOn32zzSpEwNU7GFMr4FubGHbHhSyf+DA53vpuDuiKs
	 XPqnHwuAUi0Az50jLkXLw3iP3OisR2Y80GR2SZQEQclZA3Wa7yPZj01PN8LtqP9B2y
	 uX5iX8HDLYaVvevNroiY2nczsHMTw27O26eI8QdE+8VSVqSf9HNZadw2gO8jXEYse8
	 8ZxO/hV4/EjKjGRfV3Xu+q6clpfK+jlWEIzdTD+T0h3U5EngpGMTVnsjHHTPeaaHcV
	 quyhH//mQ253w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7734A3811A65;
	Fri,  2 Oct 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: use managed IRQ teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179095920628.3497173.5666642957609869868.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 16:40:06 +0000
References: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260930074453.2944525-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, tedd.an@intel.com,
 kiran.k@intel.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 30 Sep 2026 15:44:53 +0800 you wrote:
> The PCIe driver registers its MSI-X handlers with
> devm_request_threaded_irq(), but remove() uses free_irq() directly. The
> devres actions then retain registrations and attempt to release them again
> during device cleanup.
> 
> Use devm_free_irq() for the remove path and for already registered vectors
> when a later setup request fails. This removes the managed resource at the
> same time as the IRQ is released and keeps MSI-X vector teardown ordered
> after IRQ ownership is gone.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btintel_pcie: use managed IRQ teardown
    https://git.kernel.org/bluetooth/bluetooth-next/c/25016fe8c1ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


