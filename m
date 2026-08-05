Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B3F3043C8;
	Wed,  5 Aug 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785892864; cv=none; b=Q3LAcNT+m3bJ1TfXTSN24aL2RGuwAmcDwcuJM1ZW53mrMAQSNlaKbNhVdkgBRN451EEgKNUOW/Hu4buN/8236l+3k5ARDa9FFyEzFbfIlZWnFAzkPxHInfysZJrjgOxAOqXoDG6c2d1ALczFZNqmt95CdNRJWsb9Ty2FFhf7eA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785892864; c=relaxed/simple;
	bh=KnhLNhpkigRhLM85NlCDq/2A7NPYV4eWZv3gQSKLySg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W0V1cpYynhXhDM/bPRZ3i2dgRjYLAC3V0KLt6qiW/mGHkzluhwV9Cors0wUZYRy+te1OnlilovfOd/RMwztiQN4h8rZ+Q9EsGGlkA5W5ams3ywVm3Au9p/ib1h3Q+YJJ/02vDr23IRYD08LiH/Qp49Kl1XKRJUETArfEWHT2OfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aQnWmplc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aQnWmplc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9261D1F000E9;
	Wed,  5 Aug 2026 01:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785892861;
	bh=MwEqJjP6qpqAoyV5UkMA9yWLjup70ridbNsRQ1s0408=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aQnWmplcN6wREYS2ZQmrQyrcLqRtNJ13jdzeqUWgDNpuP7FEzilSjwTeMD3Xw/vgJ
	 fRaKcPmNaQES11ku3W37bAVI3S8+lfpM8iBiD7LZ98cf6Nh03X3PJMaOFGUhvl5SWd
	 pqulPglq4nZzW2pKVGX7wJ4S9UXCyySGJGknZKxpDl7Ib+EDEgOF9rnrvEuuTT1oOP
	 aHNzVn005c8SG0fms/lOE5Vxk7r6LDZqfQf/fXUphPR4Fm316rTVjCiwzWbiUvbO/b
	 wICh5FFhpDqnV/y7XfzeDq2KvqeuiJIh6mWuSYjpEPmz/zRBfIM5Iq51lLqIxGE7x1
	 /zdi0GvsHFMFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197DA3926666;
	Wed,  5 Aug 2026 01:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] net: microchip: vcap api: Fix possible memory leak
 in
 vcap_decode_rule()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589282164.3863162.1616529385793132402.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 01:20:21 +0000
References: <20260801055507.47534-1-nihaal@cse.iitm.ac.in>
In-Reply-To: <20260801055507.47534-1-nihaal@cse.iitm.ac.in>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, nathan@kernel.org,
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, joe@dama.to,
 horatiu.vultur@microchip.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  1 Aug 2026 11:25:05 +0530 you wrote:
> The memory allocated for struct vcap_rule_internal, keyfields and
> actionfields inside vcap_dup_rule() are not freed in some of the error
> paths in vcap_decode_rule(). Fix that by calling vcap_free_rule().
> 
> Compile tested only. Issue found using a prototype static analysis tool
> built on top of the LLVM compiler infrastructure.
> 
> [...]

Here is the summary with links:
  - [v3,net] net: microchip: vcap api: Fix possible memory leak in vcap_decode_rule()
    https://git.kernel.org/netdev/net-next/c/30ce0cb576b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


