Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A770836;
	Sat, 27 Jun 2026 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782525027; cv=none; b=LofUuVRirIkc/l+alXj8sOfdsbdd2rlBQnhJxF7jCbFHA+nsJU3xKBNys6edy4/K4TSFEGVQDGsE8xmdLAcMA4i8Elivr4wZFlhmGUa1NMyt73U8F0h8bGVZ2w6tN10mGYM4sVJn3iDlQaMqIiGdDEHzo9gTDWAP23RJW9pXxP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782525027; c=relaxed/simple;
	bh=G58EgNrcpZUfSYoK4o3L0lpfFnDgyFvICuW4mDmOVzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EORF2QFp0qgIFxD91USGyIkC+IUJBRsJz61lZ6i4lI9GVGkq8PvR5fdC+64xON17EYT+vgzK6hle5D0FDC2CxIXqLxGu2BXS0VBefI4tzXubEGzhsHBpR93faUCBKKXhzu8PZyb3uZPoioboAsWeJEQRA/tm4tH4Rif8vknyOZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPjKBw7d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPjKBw7d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF901F000E9;
	Sat, 27 Jun 2026 01:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782525026;
	bh=mQiiIhFV/ARXUNyGYP0/EIYCz0UP+z2qwf/qpNzZD90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OPjKBw7dNDQUgKvlQS4lb/rMhmPuZPwUSkw7lYtdU0wpoVZtx7JkwlkUHVV5OgS2Z
	 TK0EjzHXdmMQVyLN9FqE8xxzi5CSWmQQWg7AT3Ed8CGcQDgIONMPSPIHKbonawz/Wc
	 fhfk4Jeia+/w9zloXwkHfK6sLflMnfG1p/yipAUjHp7vNzXxHEzSwHJCrjwKMeIao0
	 ZUPGPXjZQt9peQYrPgfRGpK3pqj+3q8BZX07n9JyLD+FXEzCpWpjpCFkvZQ4RJpXmo
	 L8l3g5PWsL7IlfMUGUQ45w7OkI5Po1SmlvuCC+Pud8gLU+pLdoHqLmnQ56TZtxnCAp
	 LYe2vITRFwdIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B2F3938C76;
	Sat, 27 Jun 2026 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipa: fix SMEM state handle leaks in SMP2P
 init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178252501255.1164679.2346571927021694863.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 01:50:12 +0000
References: <20260624065955.2822765-1-haoxiang_li2024@163.com>
In-Reply-To: <20260624065955.2822765-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: elder@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 14:59:55 +0800 you wrote:
> ipa_smp2p_init() acquires two Qualcomm SMEM state handles with
> qcom_smem_state_get(). However, neither the init error paths
> nor ipa_smp2p_exit() release them.
> 
> Release both handles with qcom_smem_state_put() in the init
> error paths and in ipa_smp2p_exit().
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipa: fix SMEM state handle leaks in SMP2P init
    https://git.kernel.org/netdev/net/c/96ca1e658ae4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


