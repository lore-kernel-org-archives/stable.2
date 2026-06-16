Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D983AA1BB;
	Tue, 16 Jun 2026 22:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647213; cv=none; b=C0F8gAjsTFC8JQmI1OaqTVNaIV35ogDL4dEO0Iv/4g+dnpUsqeXoZxdVCWVLTEQ4+4j9N1jESFB5UIumMlAkKgYJSA59deYbLcj7dBHGPDKJsMyVt+PX6aqLYts75z1oo7Wx0NtgdPFnurVMUtWHqWN2cA+HQW2SIjgdPTZmyEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647213; c=relaxed/simple;
	bh=kSovyPQf1u2/+wpyT4dQZ1O7R+GwVZMm10TSoSuDU04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YSzBMIbwkJ99NF4PgRb5oM/CMsrWRqGec3eMIoE9LzwJqC76SbKhqWU3IN2OooCvaIHMwO5lty8LuwtELEFaEqzY43oQl7PX7C946daM3FORAuxgcqRfyiKpJu6UsT08Sbh68jTwOcTDKGO/8VKFaJ/lRMBFfwJpsvPkVtjfGg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TtNwvbPU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TtNwvbPU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EA21F000E9;
	Tue, 16 Jun 2026 22:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781647210;
	bh=QX+gVE0CESSzoDMopJzLLtkh0bSG3nJdRekHMwjNQJA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TtNwvbPUrr3/Ys4kJsn4oXYtTJdt5toBBhhuCa28ouxp/5yV3IUpohtwf63BP0mfv
	 mw4cz5J0gwJF+gpfEUEeajUmenuw4PrE+lrF8XqdIGYX5juI255CSeZ4HQQhJnmsWu
	 xaflEccirz9LQuM7g2TeX/gCaoH7Qahf4TdYVpjtCL6get8kH8AWA1+24dFB7MsLGe
	 kmYIQrktAr6/Q1+vKWTyDZNi/cRwd085xqq59gii+ZETGDEUYpcjnJ8AAbIC6wWUgk
	 v/vXYKFB8bbsLST362F0SozlIYrSb+hlAmmqFWK7WDljlxXLWFY1CxhCsSRGXMK95M
	 4PlSl0i++NwEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B393930C2B;
	Tue, 16 Jun 2026 22:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: skmsg: preserve sg.copy across SG transforms
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178164720514.1257010.17974091199123614376.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jun 2026 22:00:05 +0000
References: <20260610062137.49075-1-yimingqian591@gmail.com>
In-Reply-To: <20260610062137.49075-1-yimingqian591@gmail.com>
To: Yiming Qian <yimingqian591@gmail.com>
Cc: security@kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 keenanat2000@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 06:21:36 +0000 you wrote:
> The sk_msg sg.copy bitmap is part of the scatterlist entry ownership
> state. A set bit tells sk_msg_compute_data_pointers() not to expose the
> entry through writable BPF ctx->data. This protects entries backed by
> pages that are not private to the sk_msg, such as splice-backed file
> page-cache pages.
> 
> Several sk_msg transform paths move, copy, split, or compact
> msg->sg.data[] entries without moving the matching sg.copy bit. This can
> make an externally backed entry arrive at a new slot with a clear copy
> bit. A later SK_MSG verdict can then expose sg_virt(sge) as writable
> ctx->data and BPF stores can modify the original page cache.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: skmsg: preserve sg.copy across SG transforms
    https://git.kernel.org/netdev/net/c/406e8a651a7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


