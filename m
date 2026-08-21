Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F56637B00C;
	Fri, 21 Aug 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341857; cv=none; b=hn/N2RwOLZh6RrFYGTyiCD0P2zt26EuuNxIQ2ZwqAwvSxQXSvGIgX+yRJLpEe12+AVQPhD9xZSyn8d2P+lMkL2BLjyc4FuJVXIhr65T7AKDvnMs4R9kS+myvXl3tJk6WK5uiVz5dD3jHxXmXM+zdKkJiLQRmFavy0SkBTi5jugs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341857; c=relaxed/simple;
	bh=IvgfLFMZTKaksc4EfaQFDSj3ZYOHy2FnAN40qXRwUWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ldmrrCQh+3CbyTnnhAeBJ6GA9C8JGRKOThIlIgONOQ16jNY23LM2LXzYYd4YXpLiqa0j3p0fenIhqMqIpbNfUqmoXIDBhvrhSldM1h/E/EcLDzvKit7OokfR0i6Ic57OA+1uHqRu+lGW3fMo87+5+xP4L+rPYG7WaVtmkesbxTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CohgOngH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CohgOngH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188821F000E9;
	Fri, 21 Aug 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787341856;
	bh=Uxc6nMkmizNKE+k5BJ7aySAnok/hVOEcf7qLnrIOLwE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CohgOngHOckt8y3fEJMt7o4iWeiHcEzgzl2FsCE+G52jH2ghxQ2kpIwclIowuW6+b
	 XxoVqPeU0LaFCop6DCLxpplrnIiKa2V9HgE6BLteLD9jzm2qFQQmLFhHomVeZiraF+
	 QfZa88vc/BBy6vIhKSJCbIF0WJj4s7EgIVZdiOPPbHMR4h82uU+SyvWSni9758whj6
	 RAIeoZbtYRxYxjtIxMe8+L0kyy+54BtVkhQvJo4SQsA6Sbse4/8BZ6iMy+gtBjb9CK
	 Y4iVrHhOJJqP7pBnjtmg19VDKjsNQt3Ff0za72dsMuYxT0UJFKNgOE+VL5+572LXc4
	 OYOiAB8YkKPXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4F380CEC4;
	Fri, 21 Aug 2026 19:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_uart: Fix false success return in
 hci_uart_setup()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178734180539.1457312.10393631411871109730.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 19:50:05 +0000
References: <20260821024555.1647597-1-13875017792@163.com>
In-Reply-To: <20260821024555.1647597-1-13875017792@163.com>
To: Gongwei Li <13875017792@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@intel.com,
 pavel@ucw.cz, sre@kernel.org, robh@kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 ligongwei@kylinos.cn, stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Aug 2026 10:45:55 +0800 you wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>
> 
> When reading the local version information for vendor detection
> fails, the error is only printed and 0 is returned, which masks the
> setup failure from the HCI core.
> 
> Return PTR_ERR(skb) instead.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_uart: Fix false success return in hci_uart_setup()
    https://git.kernel.org/bluetooth/bluetooth-next/c/b8d936018ce2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


