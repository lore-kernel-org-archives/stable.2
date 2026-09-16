Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE88E5C613;
	Wed, 16 Sep 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581696; cv=none; b=HGJ3M6Wt2SizAEBbLR3IjMIRZs7iZs0ZhLAv/xVz0V8n8eSaOnU8tYsBxCOBYA+bbsjFFk3F7RWU7dnHglXHrAsDDQAXVmaUue+Xn0xs6WSCzqufbolXxUrupwUcPCeWiH7FVt8cHndzWCwtznNtTFWd7L4/rXzdD9Xk4wUxe9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581696; c=relaxed/simple;
	bh=yMZ3u+0AkPZHapINFufKC15hseUa4KBpxCG87lFAXCM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XXTeRMKEj9i/U9ljWvHmqC0kHDYz/R4WRHJacglVYhUtytz80upX7lCF0cy6hOQGMCsoVJOgR+khT/O9ZDO1kW+8coWrE053spWrDgVb07tCMcHBjr53VxWV8EkjlDt+hJZm4igSf0TvGa3x+Nde/8sPoZyu6+kTtRRFEjkTML8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaRc5YyQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaRc5YyQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A48D1F0089A;
	Wed, 16 Sep 2026 18:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789581679;
	bh=fP5Jh/A9rg2DuMlKCMCjkdCOYQ2TczRDMVFGcGtlz0w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DaRc5YyQHtLHckQgQO2YXqdo6PluvAblKfRgRYUf+sV4mPBaRu2VrU1GgheZUWh+X
	 DOnXZW61fn8GY+KDmvBQmx/sTWKUEeqnsYODDR4ozHfHJ38g5sfbMcZdSHEp3oZdR0
	 yHC1f0wdDB5woZ7YAYMLwL3lA5xXZKyyt/wjBFuHzSsZhxoSJ/cZgtIn2u10fbo0F8
	 jBiEXS9dVmFkJhSRERFYtX8ZzQTTEJbl05JgUc/HlFzaENXYKUc1GVu21VR3IbHubS
	 /LG525k9miGaRXZPzqGAZdznNmNQq354/fEhXnzT//DqcEMpbvvyCZS6DgyToikBti
	 FmlqnRK0KbMlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AAD39E8A50;
	Wed, 16 Sep 2026 18:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: ISO: balance the parent hold in hci_bind_bis()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178958161343.2777538.8562575351949671610.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 18:00:13 +0000
References: <20260915160332.3107274-1-qwe.aldo@gmail.com>
In-Reply-To: <20260915160332.3107274-1-qwe.aldo@gmail.com>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 13:03:32 -0300 you wrote:
> hci_conn_link() takes a lifetime reference to its parent with
> hci_conn_get(), but only takes an operational hold on the child.
> hci_conn_unlink() later balances both a hold and a reference on the
> parent.
> 
> The SCO and CIS paths pass a parent acquired from a connect helper, so
> it already has a hold. For an additional BIS, hci_bind_bis() obtains the
> parent from hci_conn_hash_lookup_big(), which returns a bare pointer.
> Unlinking the child then drops the parent's existing hold and can
> schedule it for disconnection while its socket is still using it.
> 
> [...]

Here is the summary with links:
  - Bluetooth: ISO: balance the parent hold in hci_bind_bis()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4c94557dd025

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


