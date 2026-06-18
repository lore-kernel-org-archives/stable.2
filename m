Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8823BD05;
	Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781742061; cv=none; b=Xmi6s7yBAYnk5wUahz9Q/h73pwYnZ5fF9TFQ5AVk8JUAy3ZVZXiffWh0ClGxZWsq4EA9/ZsAamsiASXPfgtJnbL2hzpXlPuFqZI1TLAbJZ6DJJSHr5ZM+e4kWBvNnq+8a73Bh7buXbH0N9ElYV4wJmp1zqRmQP+w9tvN/sZX+1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781742061; c=relaxed/simple;
	bh=lr8B23CUEuUVxrs018Ab4gVyzVvF5e+YytiPE25nT7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=THpcfQoqZOxiWGU442cLz5CrrSb/gq8XQi0jaVTM+Ni3kHdA88nWFPGGO/IsiKW0xWyorpx+Sjm0xbnPSSUz5T3qWz+MRElGFhp+KrOuAs1QtG/HoxV9AJLuB/Kwy+kivFy+QjOVVrX/uLqZSwpRowz45Hb0MUmSqrCHKBWpxP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8Xch6ww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8Xch6ww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812D01F00A3A;
	Thu, 18 Jun 2026 00:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781742058;
	bh=txMSbLOB/VgDi7veIhU/GN1KySANA1CPKnIMDHt4Oz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c8Xch6wwdJpFFmMVVKziBBDAQvByuV4Oy7oVqymVt/blvGPHTOtgmFqLxz1i/I9af
	 OfYJ0lCtTVAXyQiiqaz/slhyrKB9ETzNIEXqU8bvVoQIRf3OrnAUdcuUaMucIGgPK0
	 0CFMcPvGY+spHbmXWmjjq3RAUD2Fv7MWYvRopD1xilUa5XEo2j4DstTQoeRj6AoFme
	 jDIx3YjsDnEsQLnVOXc97gvpHrBaPsGZ4gmkNyav/zP1Lgg7G0SMubNlorzvBAF9HE
	 s9JdG33aIoQOJUNwTYLrM6itXBI7BdKw7as4lEFb2hHVtpviwY+56C2kNA7oApmWPM
	 c1ZzRMqo2k8aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD2393102B;
	Thu, 18 Jun 2026 00:20:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netdev-genl: report NAPI thread PID in the caller's
 pid
 namespace
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178174205225.1875263.7744214441467621571.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jun 2026 00:20:52 +0000
References: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260615171736.1709318-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 razor@blackwall.org, dw@davidwei.uk, sdf@fomichev.me, dtatulea@nvidia.com,
 skhawaja@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 16 Jun 2026 01:17:36 +0800 you wrote:
> netdev_nl_napi_fill_one() reports the NAPI kthread PID in NETDEV_A_NAPI_PID
> using task_pid_nr(), which returns the PID in the initial pid namespace.
> 
> NETDEV_CMD_NAPI_GET does not have GENL_ADMIN_PERM and the netdev genl family
> is netnsok, so a caller in a child pid namespace can issue it. That caller
> then sees the kthread's global PID, even though the kthread is not visible
> in its pid namespace, where the value should be 0.
> 
> [...]

Here is the summary with links:
  - [net] netdev-genl: report NAPI thread PID in the caller's pid namespace
    https://git.kernel.org/netdev/net/c/1f24c0d01db2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


