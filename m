Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D89A4483AC;
	Mon, 17 Aug 2026 19:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786995979; cv=none; b=Y3H3K4m8O6stmJmafCE1MpXr2SWJtQmadILcJVIWEZ9tsxKfcz+nJXqhfU9Qb0iumugSlVfKGQlxtjFFesrMGo/gYX5ubbVVZ+5TBV4UUX4dnSPXYVPVuetK8bQU3K2x0Rx0xrgOh5npYO/Dqsu15e9Uh60FUWo6DBEDa4kxHF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786995979; c=relaxed/simple;
	bh=hvMSRv4ZwzD9H2aVy5lTvRnaoijj3exYtbniD5lzQIA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=et5IgZQvI200agtC16N/Ii9IDesbBLHxqGpJpwmptrFIgtIWo9h9qfOUznmvGnZkHx9Q5O9NVZ/UJU4TPsBf5kBkeuIZ8y6pHgqn3b45Zu3fD3dw4ucuteSJv/kEqh53VtdWBtWSElyrmXoXfnctjRs6LIBchMqheITWOZ6YQoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2VgJBmL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2VgJBmL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CF31F000E9;
	Mon, 17 Aug 2026 19:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786995978;
	bh=+jdZyyBRdBR8rmYk2QuFAJUQ7167yZuw6RxsYqaVYNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S2VgJBmLLvy68tW1y1Y8lBHJK4XV05l7SBIX0oVjwXV0mkd5hybup0KXnESKmUuwE
	 O+lQF9KAsyKVNWwcs8fHQBctT1afEmLU0um+otmnTWZ1ZFa+pa02iUiTSda6kX2O+s
	 3o0Rb+1DaUqHgg09qvasYZk/tmvVBF1byX8bF+ioPOalz2weRyiueDenTuA1olMRJD
	 L8WN/5rurljK2iThD7NcHe6CeA8rqFEsmqLWC0MFv6JJvkyQ4eeASE5i7L3+ufMkN8
	 QyDBhpqUuu7lLqCVkkKKTziimldobI4o/fWp1s7Ak9M5uMxRVqcLBfc0W5gJNyTJgN
	 c1U+zMMpFNCUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939843926262;
	Mon, 17 Aug 2026 19:45:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: thunderbolt: two fixes for the failed
 bring-up path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178699593008.1691257.14492670475821229800.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:45:30 +0000
References: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
In-Reply-To: <20260811-b4-tbnet-hopid-v3-0-9e75d1b51331@gmail.com>
To: Fan Ye <fy15309206903@gmail.com>
Cc: westeri@kernel.org, YehezkelShB@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Aug 2026 13:20:48 +0000 you wrote:
> Two separate defects reached through the same branch in
> tbnet_connected_work(), found on an ASMedia ASM4242 host-to-host link
> when the peer drops out while a connection is being brought up.
> 
>   1 releases the HopID the allocator handed out when it is not the one
>     that was asked for.  Today it stays allocated for the rest of the
>     XDomain connection.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: thunderbolt: Release the Rx HopID that was handed out on mismatch
    https://git.kernel.org/netdev/net/c/2f1463554d05
  - [net,v3,2/2] net: thunderbolt: Mark the connection down when bringing it up fails
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


