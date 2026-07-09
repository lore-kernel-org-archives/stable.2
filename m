Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0F540E8E8;
	Thu,  9 Jul 2026 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783595429; cv=none; b=NK1WTPI/w4VAtLftBvths6ktjZeKWhhcu5/11mBPv7deOKU8quvfUdCUds1ypb4L9C9YaH1s8ZIRP24lnPwfaNOb9azjHFYTbibLeyo9nRc9ApVeso6bNACk/AlUhuD0Mc6iar/YWF9wZqgM9O39x09W+ZKWejGT/z40gEXMVas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783595429; c=relaxed/simple;
	bh=Rw2BKhBNPfDnflYVZK/NR3FWW0puEUgSEaq9wKcCVfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PI5fsg1dWNnwCrXRW7mevdamf+EsmdZunoaGisjPtlNe68WkZYfkbkUS5K9li/B7DxZ6B/oVctpF4l24Qk4b6+RXXWnjJhX8T4faufRHFzgGXmCOKoG00pIaBNNbrzoXR0JE/VN/0/Zoy93vdur9WgfRJAqqARrgLZxp+jvunW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4kqZ6/R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4kqZ6/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD07B1F000E9;
	Thu,  9 Jul 2026 11:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783595428;
	bh=76xRzWRSgOQF+7inDrTGUaUfL0VORDXioVujCWMgDUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=a4kqZ6/RAUYCCrOjhxpWP3ir13//0nsRoUlE+Zb7C8Iuqm72hf5JMGzBCttCWezuy
	 CGosJYYPz5oEm53ETMTHH2jji0gAVhrIny14p1LQVcj6aVNUXEbzVhEypjonfhCGQE
	 lYFHbII2dc6Wve9xIQrVnQLDrHjId8VzvEJvOY5t5roXedoEjy07tH4Ik5vhytlTEK
	 m7lYgR2kbiKVeckcBXyy+vxp5N2A69nRdIzMYgf/1OBBeHXFtZy2HREKr760vQf+NF
	 XY/ZfeX2CobR8uUi8aYt05V8uMyFRx6kC3jo/aX0FQgSvnuAMYKZauiHIHRIIyep0U
	 Ur+Shs0S+7rtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93DD139EDE30;
	Thu,  9 Jul 2026 11:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dibs: loopback: validate offset and size in
 move_data()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178359540740.3416587.11524899532321320638.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 11:10:07 +0000
References: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
In-Reply-To: <20260707074318.1448662-1-dust.li@linux.alibaba.com>
To: Dust Li <dust.li@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, guwen@linux.alibaba.com,
 pabeni@redhat.com, mjambigi@linux.ibm.com, alibuda@linux.alibaba.com,
 sidraya@linux.ibm.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, federico.kirschbaum@xbow.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 15:43:18 +0800 you wrote:
> The loopback move_data() performs a memcpy into the registered DMB
> without checking whether offset + size exceeds the DMB length.  Unlike
> real ISM hardware, which enforces memory region bounds natively, the
> software loopback has no such protection.
> 
> A peer-supplied out-of-bounds offset or oversized write would result in
> an OOB write past the allocated kernel buffer.  Add an explicit bounds
> check before the memcpy to reject such requests with -EINVAL.
> 
> [...]

Here is the summary with links:
  - [net] dibs: loopback: validate offset and size in move_data()
    https://git.kernel.org/netdev/net/c/78237e3c0720

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


