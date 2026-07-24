Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D53477984;
	Fri, 24 Jul 2026 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936441; cv=none; b=PjzQABICcwXxPH7DjDEPi8qptmZ/+kEQtQifc90JNFGqRAWT9UedypUvS6oCOen+bB13d7U6bmXxaBdcbIyOwlzbDxCaSyccErPZfwnf6t/JwVqg5zT7+Wo7TZv+O8tBMGKpbydN2YlUIWJ7KB+bsQOsSydF9CaE2z0NhvHDnAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936441; c=relaxed/simple;
	bh=QAO5CVsaPtzpkwPIP2mFfEnCl8vGvPJgHNQs9kiR/b8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=urKJz9bq4N1iVo83RTZQoSYT5fGJwX5EcmWddcLCvvJm7uM+tGgpFfxrXf0T5jKrKpeJUqfnvA9BR7xhZiU31pQJYwTsceQDWrmx1cfP6yYHY0jcaa6Kq/Dr/hqNr9P/nurXlddJoL04UOr+XdS82pkMq9teFD7LNYVhbSaKCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwkXrYzr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwkXrYzr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB911F000E9;
	Fri, 24 Jul 2026 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784936438;
	bh=mPadTm1aSVriN+cH5QLoWHyB2LUiWZaVhp6cyWlogeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VwkXrYzrpLGxKIILUSv+lUTaWU9scY9OWvyF4zLnT0QtUFXXxfIUCfi5U7NLDEn5X
	 r8n99I4j0votdDHiy5Fn0YbemCHhHM/z5YAP8dJK5xH6us4XL/tERslVv4yjDVbEXY
	 48BoccnmuigKjsFzyyJMLTaXzpe46JLh+Dwg3Uu4Wpbg3aLqvJye/iuprZYz5LbSwi
	 oMFGkRzam/Mp6QTpsw5ESgAbf2fp7LOmfKLt4NLWsaqGi/BkkxlOaEEA6UENiKVv+y
	 JaT6ZRwDPovEX/TFsn9kGR5g7W3zLmi19JOUnheAcpM0eVJZEnrtVkLJh4Akw0DKZ1
	 VXP//D6c5iNog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id DA07238111D8;
	Fri, 24 Jul 2026 23:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: pktgen: fix proc entry use-after-free
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178493640576.3354511.539340145815216251.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 23:40:05 +0000
References: <20260719145740.2888967-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719145740.2888967-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, thorsten.blum@linux.dev,
 akpm@linux-foundation.org, andriy.shevchenko@intel.com,
 rdunlap@infradead.org, robert.olsson@its.uu.se, stephen@networkplumber.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 19 Jul 2026 22:57:40 +0800 you wrote:
> pktgen_change_name() replaces pkt_dev->entry while holding t->if_lock.
> pktgen_remove_device() removes the same entry before
> _rem_dev_from_if_list() takes that lock.
> 
> This allows the following interleaving:
> 
>   CPU 0 (NETDEV_CHANGENAME)       CPU 1 (kpktgend)
>   if_lock(t)
>   proc_remove(pkt_dev->entry)
>                                   proc_remove(pkt_dev->entry)
>   pkt_dev->entry = proc_create_data(...)
>   if_unlock(t)
> 
> [...]

Here is the summary with links:
  - net: pktgen: fix proc entry use-after-free
    https://git.kernel.org/netdev/net/c/817ff6efdb7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


