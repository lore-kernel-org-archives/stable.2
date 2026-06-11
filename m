Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062353CF662;
	Thu, 11 Jun 2026 23:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218824; cv=none; b=n+Tcmcoj4gSjoGdvW5KgVDU0j3H5uzCTYociPqBAHT4TUPHUIPRZWbuTZXc9JlAdnuQoG0AGaJR6qclktKOUXzJ2IjDjytl4qAHQBBIK/ARgPZVDu+KaTM1ghFw0Idhw/tlZT0JsBpV+44Nkk49tSZxcCH1x+jv//FVpOmloefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218824; c=relaxed/simple;
	bh=5U+hldp/zehyTzZeDzKtHUZ8B+dzwadEJGhaAQIOpmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YCyXL0RiH1EFjRdAwu/nQOqJ8+lBy873IRl8gIuYk/c+DirgP9atzZXmnyGVcBbKeM1aq8dn0aeFjIZJb7KZvkcUJIoS8ud697H45twiF7vwfGclnOd4eTfS9rCUf98PtqSLrTbNJiYEpjdvxJXfU62A16yRjdJsabV4q3zp73c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mBghlLX2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mBghlLX2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D921F00A3A;
	Thu, 11 Jun 2026 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218822;
	bh=IWJRDZFHtQ0APYtrnWDk7v0QYrg5OLivgMI4R7jxi4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mBghlLX2+eHkLSfUYBNoq6vAdQGE941Ff4Y+ShivFJsKsswDx6GIMdYJFBOb6gBaK
	 QCaSG+GEDI+HOdcI4lGsTfp+7cGVj4OdNiGRvHJHca+QDMoylnLYxjwgfJW0POj+eF
	 +dN+ddDbrTAyYVquf4bFOPEKuXtds2ZZX068JHcbsp/VdYiovs/xk9c5b9MdiCIj/d
	 luSduELK5ZjFQb6SpTBjzx1qgJkRls2eN2nQCidWRYMYzVVs3InpdU9mQACz9ihnf7
	 Yi1W2h/PIamrngEwX51Jz9w1RtgkkBY5BfbfJIa+jMpD7hQPQ3mQHPESMS//6SL9sS
	 u4s6jz5loUu/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 196FF3930FB3;
	Thu, 11 Jun 2026 23:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mlxsw: fix refcount leak in
 mlxsw_sp_vrs_lpm_tree_replace()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121881963.398116.3479211553775156015.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 23:00:19 +0000
References: <20260609084730.215732-1-vulab@iscas.ac.cn>
In-Reply-To: <20260609084730.215732-1-vulab@iscas.ac.cn>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 08:47:30 +0000 you wrote:
> When mlxsw_sp_vrs_lpm_tree_replace() fails after replacing some VRs,
> the error rollback loop does not correctly revert the preceding
> replacements. The loop decrements the index but fails to update the
> vr pointer, which still points to the VR that caused the failure. As
> a result, the condition and the rollback call always operate on the
> same VR, potentially calling mlxsw_sp_vr_lpm_tree_replace() multiple
> times on it while never rolling back the earlier VRs. Those VRs
> continue to hold a reference to new_tree acquired via
> mlxsw_sp_lpm_tree_hold(), leaking the reference count of new_tree.
> 
> [...]

Here is the summary with links:
  - mlxsw: fix refcount leak in mlxsw_sp_vrs_lpm_tree_replace()
    https://git.kernel.org/netdev/net-next/c/21cf8dc478a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


