Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631D1439F6C;
	Mon,  3 Aug 2026 21:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785792654; cv=none; b=DrO9FJu2lO2HzmNc6XDO2SSfwCshiNQXhwX/vaK3HcB6jFVZOdtgSKWl7iBR+Rj84xAjgVgpboApD+WTzwYJWU9N9arBpzJ1U9WJAnkcNHLUg25qaUd7F1swZWB9yX+SQR9Is0UfqSD5k/OK2sfVWXa5wc+GUzPE4/8YYrGYnsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785792654; c=relaxed/simple;
	bh=sACfbu1anUBO3qe6r+PppWdOcUTcJcBuhQ4/dn3/M/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRMJCy3LuVhk8mjat1xK51sVq6Y+tN6lzM9jpQ5SuBONcd2PzbomWat3ajJuPdMAPD8qaWZ/wyjd9lccahMaQIveMIYZ51evebVZDirTZqoDVDLBRmJJSKJDzLCqJwKaUYVoKRaMXLaArrLDU0h+t1RQt3Q+5CaWALVTkb4lZfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3TuHzFK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3TuHzFK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1761F000E9;
	Mon,  3 Aug 2026 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785792652;
	bh=LvJW6uRBD338wmMBZWVv8XIuJAjYxP0Vosz9SibfOrg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L3TuHzFKFT3pV7HYKJvdQhzPW9gNgVjWURErKDVaqBlBrcKDVHx+p9H5/1V7pGXlj
	 7oaCNpTZpWi5zSkOdon0y8YwSrVJcar3KK6ShSHGNgSh1/v+xYk5/+XujFwjiM1phc
	 wsr/IU2LXT8f6dt/FzZ6Q45i5pLjfAkwyqP89SsRRdUMhbx8oCNTnoVwWtjwhzUfX9
	 BqmPxTOPsmo+lfu9/A5uO/nRVyOORYjZhfl0XSCYgkxnQMYXqEyghxQwSDU19OIYQ0
	 VzoKEJIWXu5x2bacLWxgZ5k1F15jlbG5vkFeADGHXoAxcPNCqOf7ZI7Ui1xdTpqOEA
	 mpFoujsix7UFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D93924461;
	Mon,  3 Aug 2026 21:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: fix Route Information option length
 validation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178579261338.2840566.1503229035489033744.git-patchwork-notify@kernel.org>
Date: Mon, 03 Aug 2026 21:30:13 +0000
References: <20260730035310.74584-1-syjcnss@gmail.com>
In-Reply-To: <20260730035310.74584-1-syjcnss@gmail.com>
To: Yuejie Shi <syjcnss@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Jul 2026 11:52:32 +0800 you wrote:
> rt6_route_rcv() validates the Route Information option (RFC 4191) length
> against the prefix length, but both checks are off by one.
> 
> rinfo->length is the ND option length in units of 8 octets and it
> *includes* the 8-byte option header, so an option carrying N bytes of
> prefix has length == 1 + N/8.  RFC 4191 section 2.3 requires length 3
> when Prefix Length is greater than 64, and 2 or 3 when it is greater
> than 0.  The code accepts length >= 2 and length >= 1 respectively.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: fix Route Information option length validation
    https://git.kernel.org/netdev/net/c/d1ad8fb2ac6a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


