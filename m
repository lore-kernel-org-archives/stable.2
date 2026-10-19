Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0904A0C;
	Mon, 19 Oct 2026 13:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792416009; cv=none; b=SWNhe9BlsTTfE1QO1QNtKOxcVFwlG9Dl2Wo0RyxRlnPoI9XTNqR1iXU09qIgzFjLcxPhBzJHcloObWbcMEK0uqrdXZs2Ie+dd8aD34XrjQSVbmAsPqSNveDdKiDdKhLxyZYHCWeP8TjgCPtmjrfu6xdMeadGvlNDjzpWHVmHmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792416009; c=relaxed/simple;
	bh=DXHiM1bMOCWpWX0JIcypM7COkCu8XMumDVKn4IWb/48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qv08YUs5mmHL/CrHpPHvXmeg5apldAnin3bH0BR2zPgMO7J6gjFjk1MfPK0E9L2lu58X/RkPlkbwLXD+fog5UkvmRWD0VNKQQ4PjfZG9WWQ2EENbjF9gOk2PdMlWZTJ96+/1S+BelOcNBzki0ILzV1wB7uwqSXCSPcB8krlGXTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoWzeM8z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoWzeM8z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B40C1F000C4;
	Mon, 19 Oct 2026 13:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792416008;
	bh=+XXDrQJUpY2PpAGKrMkLS61VUDcwfbBBNUpmADVAu2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IoWzeM8z1c8rJHkQPVPY9n+m4E0no7E+sMcHA7HxN0KzGfsDnK3OLsbEDvps5mzXN
	 JCcT5NI8Uf8LACks/epLOJCFUzozkpHZgXVU11sPmCauMr0ISOueR6LuId71RRmn/K
	 pMlNvX0sp/3oznA5j5O9kvFL2+48RJQ1hjl40pu0dvkfz7LlqY0I8ZN5r7ILCRpVKZ
	 XNISWIpkExEOOFr1UvgOSFXeKYYaxmEWFKVyESysVaRcwgBvDdyMWDx7LBupQWDmZZ
	 PDXwA/FB29jZckY6foHTZmXtfvz8aiXW1AIhPwXS9XWO5un8hU1Uobrg3q0FYcVHqO
	 9gGozJ7LKvQ9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15073811A5C;
	Mon, 19 Oct 2026 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] bnxt_en: don't leave an XDP program installed when
 the
 open fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179241600658.2633077.17979665169071396850.git-patchwork-notify@kernel.org>
Date: Mon, 19 Oct 2026 13:20:06 +0000
References: <20261012072802.2153706-1-vnagare@redhat.com>
In-Reply-To: <20261012072802.2153706-1-vnagare@redhat.com>
To: Vaibhav Nagare <vnagare@redhat.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 nagarevaibhav@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Oct 2026 12:58:02 +0530 you wrote:
> bnxt_xdp_set() stores the new program and drops the reference on the old
> one before reopening the NIC.  If bnxt_open_nic() then fails, ndo_bpf()
> returns an error with the new program still in bp->xdp_prog.  The caller
> treats the error as "nothing was installed" and drops its own reference,
> so bp->xdp_prog is left pointing at a freed program and the next XDP
> update dereferences it:
> 
> [...]

Here is the summary with links:
  - [net,v4] bnxt_en: don't leave an XDP program installed when the open fails
    https://git.kernel.org/netdev/net/c/78731b46967e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


