Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5162E7BD9;
	Thu, 11 Jun 2026 22:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781216409; cv=none; b=ssX8Y0ADUIKsJ9guHr6RvPMRL3px6JTKfFcBKo+luiUuXSYCpe6QK8VIz+/o8etjM/MaKJCLUbM+Xwd2uEgMg4vb7O/VKdd1zpdAzOWoRP2y6LyxYL/3WgANkBIxYGBt8jwierqj4xnO8cUR3VdvZWUbffq686iqQMt3x43765Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781216409; c=relaxed/simple;
	bh=S7SPxj0+n/cAkq0Z6a7eu/C5mwhHIkKVf7s7jgoj3ZI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JIsrbtZyclo3sbH8g/TId+6GsOnCpwufOg8Pit4tXgLgAjEVJaM30FVzFzCwgr4i4QYNBpBQWAFmwCaGea1gk12Yz2wTarKAuyYKgBr7zKz+qiqIr7bAKZSJ8yiI64pgctFDrnqQ2JQzxT3NYjD025cKqiUvGhNAfBC0TSeBowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRP1ZbsI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRP1ZbsI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEF31F000E9;
	Thu, 11 Jun 2026 22:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781216408;
	bh=6XG/CAmsc4ebZcmoGJFBRO7jKXsBEF5dekspXGO+ZoQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JRP1ZbsIncC6UyX84axEMrqtr25lo7zA4sZwzh5ubQDHNAPpY3IV3AThdEM02w8F9
	 hGWL2CrRBCRj70GLesRcGr5U8JDY7BmZn1Gq6AmRTMySawN+dKFFTkiOOReOIctsd1
	 Cv2nMAAMdgcnxstKt60A9A42wVU23wdiHpthI4L6roj9f5zyw2DbUq4qzHsoXqhmqt
	 i5fzqIMFipHhFHpSeCJr6wdnXfOXFC3MeJE/t9uOkut7on4eYPFSOmPRpgccokeR5t
	 I5qZ+U/aRC5APFeTvLbEZxFQeDSex+oXNitEx+eRVmZTB5Vz0u2cMCwDumNXu+hIRL
	 U7WvqZS2seTuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939023930FAD;
	Thu, 11 Jun 2026 22:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net/sched: cls_flow: Dont  expose folded kernel
 pointers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121640518.386394.15064694073972588687.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:20:05 +0000
References: <20260610101839.14135-1-jhs@mojatatu.com>
In-Reply-To: <20260610101839.14135-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, kylebot@openai.com, stable@vger.kernel.org,
 security@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 06:18:39 -0400 you wrote:
> The flow classifier falls back to addr_fold() for fields that are missing
> from packet headers. In map mode, userspace controls mask, xor, rshift,
> addend and divisor, and can observe the resulting classid through class
> statistics. This allows a tc classifier in a user/network namespace to
> recover the 32-bit folded value of skb->sk, skb_dst() or skb_nfct().
> 
> Align with standard kernel practices for pointer hashing and replace the
> XOR folding with a keyed siphash (which is cryptographically secure)
> 
> [...]

Here is the summary with links:
  - [net,1/1] net/sched: cls_flow: Dont expose folded kernel pointers
    https://git.kernel.org/netdev/net/c/f294fc71c4a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


