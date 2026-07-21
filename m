Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414F1298CC4;
	Tue, 21 Jul 2026 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784674245; cv=none; b=Ul0gdLGJZerEcJpKwoe84gV+QAXnGQ9k9ihMEtFWhKMYp+eJ7FLe8fjPtwG4g81Ds4tDVhnP6qJC36aiPnQCRmS0XFtEM7R9epPVdNcI23LG2EAk9HHgLfo2X2GduCPQlrvSsXIMdExfRHcE0UYk6t0Yy2IDE/Mv77ztX6JRnoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784674245; c=relaxed/simple;
	bh=eXgVAldGxgS4Lp/AxZmo2QQ0NxvVS74fqrfpqxHwmGQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNk7rjyP2BmVT7IoZgQPbQlw+e34YlYwJIG0W8FIO4TPYyb6w8OrNIU2Bya2mzcsPnWyScGo63v/pXjmeDKKYWwyNmfuCKIfm1nOe7udU90dudiQWkQVhn5TsVB8MucZmT9i5zKUwTRxl6368/ipdvZEexZzdPo3gc+HNBsvoYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXSUfZkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXSUfZkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003781F000E9;
	Tue, 21 Jul 2026 22:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784674244;
	bh=Bhg5FayJF4Uj0dXAjwg3kjC7mkfhcAlBhFcmyt9Ozm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fXSUfZkK8i02FTgr95zgHRtCnK7+sP8NmC/zlPFmmU4irtwiLq8ZLnITKQgZMlc8O
	 ZjY//tOOyGYjLhv7IT0VJ1z2hHCAMwrjmxdyGG18XB1meoIzUc/oOBliDxhQ4KzOcK
	 sZfYgU816GNf63V89FmXbegQSW5Z1oRhfKXvOAJmyDbD2CUqkCI8D6TjX3XT3HaXIB
	 lKPjGQAUYosPfvzc+NmukUgbhL0edrQRw744l88qMgjrlMtPGo595Qwzb7Rhrumm30
	 5fBVPmBsLPTZ2ulOwo9PL2e+8fezmFARyzH64qIQ3+eCWtc4gpv61RDf/C8gb7578W
	 K7vQBkNtvcseQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CDD380820D;
	Tue, 21 Jul 2026 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp: initialize standalone TCP-AO response padding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467421315.1142823.17462720379435193321.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 22:50:13 +0000
References: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260713105631.8616-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: netdev@vger.kernel.org, edumazet@google.com, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org,
 yangyx22@mails.tsinghua.edu.cn, wangao@seu.edu.cn, fengxw06@126.com,
 qli01@tsinghua.edu.cn, xuke@tsinghua.edu.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Jul 2026 18:56:30 +0800 you wrote:
> tcp_v4_send_ack() and tcp_v6_send_response() construct standalone TCP
> responses with TCP-AO options.  The option length carries the actual MAC
> length, but the TCP header length includes the option rounded up to a
> four-byte boundary.
> 
> tcp_ao_hash_hdr() writes the MAC only.  Thus, when the MAC length is not
> four-byte aligned, the one to three bytes after the MAC are left
> uninitialized and may be transmitted.  For the normal TCP-AO hashing
> mode, those bytes also have to be initialized before computing the MAC.
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: initialize standalone TCP-AO response padding
    https://git.kernel.org/netdev/net/c/e1a9d3cc1182

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


