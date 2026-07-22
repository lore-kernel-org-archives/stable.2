Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731044399C8;
	Wed, 22 Jul 2026 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784754641; cv=none; b=DlD/1qqBfIi97TXYmO3t3kyM310PY59Y1Juq/J/yLSWb6Z2OSpW73h/IiMJvSRSkSpIbE0YjSQApd+iy5V+BYJgGM8oqayJoxoYORC5kQEkoDSmqE/pkTy3/9IFTAb9TSSOkqkAEoVWkbAs0AZ3tCXVMLafcZexc56wFaSKypbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784754641; c=relaxed/simple;
	bh=UwK/u3uJ3LZD6XY12nfjZjOO4Uicj/wYw13EtpIlurg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n4G/sqek76MjqVoo4Luz8Gjt8k98mKr65sVwEWAGipR5dWtk9MpRRSGkRxvG7/1xFbCp9XDLaMaJTzGpj3PkNuNB0RBsQS1p6pl0Z3j+WstQluYyYpnmFCJxx1DSMrIjkyOhqOsCYeBobOsQ2Wxf396B7+aFIP5Ws75VKtAGmv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJE7EExq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJE7EExq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3101C1F000E9;
	Wed, 22 Jul 2026 21:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784754640;
	bh=aDtLv41pnAcLZ0TtgI4sbNq0Kxq3zzirw39sIp7j1Qw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DJE7EExqs+JluqE/stvmLDoR5npu85axS38pYeJoJmy6IPw+pmUL6LEhoMk1T9A7n
	 f9xfK1E4NxIlgRwXV/u13pxl5l/UnEy7ed6/qFaAIylNn86Y0EQ0P4JRxJcVl3Kjfa
	 BiXl7oH0V438YiCFQ6jQNOOoYFoQoloIll5H7HYlwnt/DVd4IdP6OZf5OptU2i9629
	 JdzFoyxahCsiJ96l5t3x3ezh7v5rMxivejh87AL+TMvPXRhLbEnJSNBkythCpH3xF4
	 zRA8SOf5VvIa6tFqIZOXqmQkrDzOfPG++p4scJBd65CaSamVSe/6hheqzBkcuJy8Ml
	 +NwbZdQEgiuAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19885380CED5;
	Wed, 22 Jul 2026 21:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ila: reload IPv6 header after pskb_may_pull in
 checksum adjust
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178475460864.2026851.2730101991676119458.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 21:10:08 +0000
References: <20260714114903.3763420-1-michael.bommarito@gmail.com>
In-Reply-To: <20260714114903.3763420-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, atenart@kernel.org, horms@kernel.org, tom@herbertland.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jul 2026 07:49:03 -0400 you wrote:
> ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
> pskb_may_pull(). On a non-linear skb whose transport header sits in a page
> fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
> and free the old skb head, leaving ip6h dangling; the following
> get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
> uses ip6h (and the iaddr derived from it) again after the csum-adjust
> call and additionally writes the new locator through that pointer.
> 
> [...]

Here is the summary with links:
  - [net,v2] ila: reload IPv6 header after pskb_may_pull in checksum adjust
    https://git.kernel.org/netdev/net/c/92d3817649df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


