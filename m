Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CBF368D52;
	Tue,  2 Jun 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780369823; cv=none; b=sacKo6FHNdM4SIcweqRsdnJ+05dw/YPIs9gQ9IRpr5LjbvX/1zbHljbUDpCFOyWBuga1OQqP69TbB//PTN20KvOr3+f3aqhNh9bVpPlSjm5DQ+9QX4g7WhPjvtYpVQeWw61i0yKTchDC2Au2sd+cm0RcHv54xM7ncoDrH2zgLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780369823; c=relaxed/simple;
	bh=WJN8CzofN/W0ri4BTYKZJBNpzfigOeT/kKTG4JrPMog=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Kr3PBTBMJLW2ClbRKPZ9TTz0DUImFH7y3p2b4psUP8t7PxV66oTRFwYejTxIHHVhT9V6JH7cn4bDC9k0nzojpROdBrZpAFmGURBs4PgYDusIn8rUNBebh2lYlcYFarfilM221EGbKQ17XJrX2ARcbhTY88lJSvevQqHkcy9Z2D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4heG3oq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4heG3oq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E409E1F00893;
	Tue,  2 Jun 2026 03:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780369819;
	bh=KnK8K8pQoH/ek10Er8yHN1BaRBv//G/62A3/HJNKdWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E4heG3oqaUKDcQWfXO20xPtkAQcO9ymXseCLnVR44Ex3QfbnDaYrJwxCY2/F+mM2k
	 hKSczFJfIOmk7/feLlOlQOjjk5NwbIHFY9XAPoYUEdIDddJDQN19iC3dfXoO5YDh41
	 STmw5Y9dti8GaGEiIwCWtOFBHXhRwYajg/Q5+qVmhnFEWcT6FMmN2J6km07/Fl5sMa
	 +KXDmu75BglQkLMDEPnCiimI/lOE2ri66ad29dFIBpvIJbzR9OmQD5xAvg9u/vDZWu
	 cuosPsS9cdhWpQur7z9eV+7nfEkTR4Z11pQ6PkjGXJEdKJsk+cRpa+kpQSN2dFmeWT
	 b8JwZ76LcffTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56BDC38119F9;
	Tue,  2 Jun 2026 03:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qrtr: fix node refcount leak on ctrl packet alloc
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036982189.224606.10962942847177813465.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 03:10:21 +0000
References: <20260528080019.1176700-1-vulab@iscas.ac.cn>
In-Reply-To: <20260528080019.1176700-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 08:00:19 +0000 you wrote:
> qrtr_send_resume_tx() calls qrtr_node_lookup() which takes a
> reference on the returned node. If the subsequent call to
> qrtr_alloc_ctrl_packet() fails due to memory allocation failure, the
> function returns -ENOMEM without calling qrtr_node_release() to
> release the node reference.
> 
> Add qrtr_node_release(node) before returning on the allocation failure
> path to properly release the reference.
> 
> [...]

Here is the summary with links:
  - net: qrtr: fix node refcount leak on ctrl packet alloc failure
    https://git.kernel.org/netdev/net-next/c/3b09ff541145

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


