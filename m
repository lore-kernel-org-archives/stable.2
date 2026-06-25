Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F43EB109;
	Thu, 25 Jun 2026 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404469; cv=none; b=RUoRc15fkhRgoAP2EwXyQJonxLqBYzZTD1w482yJVzoUFJXraOQoZ4I/LB4iy0/MOjiW9xxXuVNi6r/8u/Lmf3MUuN3ZNyYso0kehlAjSSJmUZH5UYaHNZBJIqZyfvj1LNSXpPqbY7TjFlSIQLD7UkBSRmmSXKohfabeXYofpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404469; c=relaxed/simple;
	bh=UOt6EGM8fMiJFW34YFdUp24CWRPrPqiNaWTM8wkZfNg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E/t0TqsD6QnVxi5Ca+fddnIiIwJNw4XjeGaSD0i5Bp587PR18OUAVA5/xsHsXeaaCUQVZGopQOrRQjSHcarqv0eWH/PZ2ppT9H8hYi768GDeVrn3VYGfDZ1rXJ1l0oYudois/UrJ6YuJ5r8z+QY7PStNYT3IDP7CM2VMSFI/yv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ikqMxPyq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ikqMxPyq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C061F000E9;
	Thu, 25 Jun 2026 16:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404468;
	bh=LGBo2vf5YhWLqWr2lTqOOyhPJy8D4/FOwRNjsyPwlAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ikqMxPyqHXeNLjjVPGzWundaHYDRIPj2Iv983MLxSlcNsDXVawdAthu910VhKzErK
	 a0nchwckRMPHDXVdS5ay8Ez9rPwq/wHQgFWLqg0KcihDmEKJg6E8UqY4o/CMiPokkG
	 OJ8pVzzNizLvatWF1iQWns7BHpw7tGMJPQlGfOTzD9lsC2sqD2pLuUEbUFmxoKDeWb
	 dH/GAXeWB6vk6w3/DTmwckAk8eV2XG0D7nfPMEfjt+hDFPVp0v1saRGvKLtlx7tGt6
	 EsxKpIWKE0D3VQSEkutqydIrFGiQJUNPDEJf1gprFkuANHttP4ONB63w7bsOjW6ic6
	 y4MXHjDhnl1uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A363AD449A;
	Thu, 25 Jun 2026 16:20:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: sparx5: unregister blocking notifier on init failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445557.3803792.18219919431428523826.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:55 +0000
References: <20260623115714.2192074-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623115714.2192074-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com, kees@kernel.org,
 horms@kernel.org, bjarni.jonasson@microchip.com, lars.povlsen@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 19:57:14 +0800 you wrote:
> sparx5_register_notifier_blocks() registers the switchdev blocking
> notifier before allocating the ordered workqueue. If the workqueue
> allocation fails, the error path unregisters the switchdev and netdevice
> notifiers, but leaves the blocking notifier registered.
> 
> Add a separate error label for the workqueue allocation failure path and
> unregister the switchdev blocking notifier there.
> 
> [...]

Here is the summary with links:
  - net: sparx5: unregister blocking notifier on init failure
    https://git.kernel.org/netdev/net/c/483be61b4a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


