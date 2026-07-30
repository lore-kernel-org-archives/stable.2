Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE18E4119E1;
	Thu, 30 Jul 2026 11:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785411043; cv=none; b=XPfyzrJJiZRsQzsTfO7XaLvHZ8ilteTm8Eeb8+uiCoUXDZImPFWIOqwlxI0fQOhp6qHsXwXLYR9z1PH5kVUzt1/DaWaVOPZc+gtqvdP70zNPJfGlpwK+nsXucvc36o/+0QzBZduuQt1xxIXOuLMg+eWa77J3wndjria49wuwFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785411043; c=relaxed/simple;
	bh=0upf6hWlKspAMfAIA/yZbSNmxL/IyBjhlf5HxMgt68w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q0RKSS3GwhYgQnqdO00SfDyWhyxnk3DIuz+x0zJy5oppYhsIAksfjDjCFdG8DR9FwYMZGv2/ls5WxsJ7p601wcgmTw0fgibmjeHkil26AdqB5U3IS4HEaYdNpatDkvGmj9Y7ZSR7ptbD6RdShQ+X2Fa05YrGYQZ+pNlU7fuMZxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMJ3AEYe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMJ3AEYe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70ED21F000E9;
	Thu, 30 Jul 2026 11:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785411042;
	bh=mxpfPw7Y43sW4jthQTUeDMcBtD3TVJx+xeiANCb/00E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cMJ3AEYe1Ba59X/n1bVUdwYrDgPa9N+HGjwnRnI+4ivY9FNWMsEQyTnVGQiy7DvcW
	 YYTmWxrhh8sMkby3JmkqiVKepc3BZ2e9bT28tTbONYTGTET8h/VdfNpFt3SGLWuw8b
	 bml1yG0GsAVINgt910MU4Yt+tRkQg6AF6AU1ut/oQt1NSOgMrwfRpq1T/6slCNYEwP
	 LMkXkwSOsVB9ODASh4BBUQD5Hj0Nx4jkW3YZdzXgkMGl8v54o/r/kTIhnx6ZmFU6AF
	 gQ58E2KKzajx4YUOQ+iOedN3HYUkL7IAP0GhEHRoldsqZjqX64IN7pFM8BrVBKNFOg
	 p1Z/lgWikk9Ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B838119C8;
	Thu, 30 Jul 2026 11:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: openvswitch: fix potential UAF on meter attach
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178541100631.3521176.18317518103767015432.git-patchwork-notify@kernel.org>
Date: Thu, 30 Jul 2026 11:30:06 +0000
References: <20260727121022.198461-1-i.maximets@ovn.org>
In-Reply-To: <20260727121022.198461-1-i.maximets@ovn.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, xiangxia.m.yue@gmail.com,
 aconole@redhat.com, echaudro@redhat.com, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 27 Jul 2026 14:10:21 +0200 you wrote:
> While attaching a newly created meter attach_meter() function makes
> the new meter visible to other CPUs but can still fail afterwards.
> On failure, it detaches the meter back and returns an error.
> 
> However, this is an unexpected behavior for the ovs_meter_cmd_set()
> that uses a plain kfree(meter) on attach failure without waiting for
> RCU readers to stop using it, assuming it was never visible.
> 
> [...]

Here is the summary with links:
  - [net] net: openvswitch: fix potential UAF on meter attach failure
    https://git.kernel.org/netdev/net/c/a58a2b0ce354

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


