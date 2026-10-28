Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181725;
	b=SWBuKkgnfJvBbYver7jz20gbjfnpLRMJgP8KkYf0m1TMDG38qeqotxDIzP+x8cUaiqaj
	 f7N5VaKL9SCMMD3UVEyCvRnDe20C5EtqplWQICP8/8br4hMX/7aaifMhUlYEvTOxBL3DY
	 eh7oKNfDo5b4LHa1Rd6hc+QjPlRVaLekrYNfgom2p96PxomEN5Bs7WTwfwZ4RAu7ZhbbC
	 Zd3f8jy9tk1ojpra3mP9GcLdtAVcyJyBXP+88edVyKY8H/fEfybXX8BOq/c0ujLWi27yu
	 MU6g8igiLcgjx93t9WzYEXeXz39Sj564vgH5QOt2a8KoI2PQLbyhn8k9jEbvy8one3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181725;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=h346dBwTcXp12j8JvQWcUPOg/wYuINR90li767Hpzx4=;
	b=cJtnPkfd4QWzHxKKR7YQ29qSVfluxcMm8vATprLFmlwJZinQz3ZpITmE1vF5ZtzotxeQ
	 Y+VIxpgI/OgXUR/MT38FOre3t6k8Sau4Zf7+NIPZ0ytY2QUFkiOQQ7khRaq/51BHxH+oR
	 235JIOFPSAHNBDpQTnRIl4H8CNzopzhn1iGOa5QY343V9wwbFxdSqg+l4fkZbZtK3/cVa
	 1uKMGGN/m3b9xX8b5kg73PQOqS0EpZ6nH+TZAvoHx39Tw4mMzyx4nSdAmJNmh79CWvZq3
	 gf/jxRMhox8Z/OFR6N0UnUl2S13a/oMMZviTRtrcy5gAwnji6csZ3NLvixgr4fouQbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2PgvYHc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB94D606A31A;
	Wed, 28 Oct 2026 10:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=o2PgvYHc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5030F1F01825;
	Wed, 28 Oct 2026 10:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181724;
	bh=h346dBwTcXp12j8JvQWcUPOg/wYuINR90li767Hpzx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=o2PgvYHce2EMgAZ2FPWXpApN/diFGjL7R2i5i4TYeF3vgxYlP5ms4+rS69Ihacw5l
	 rPaDU9/pY66P409WOYFZb4Gk5BQLniWn9NtsqTvF7Kp2WfMe1v4naLj4Dn1wThjySL
	 6Pa5RR3B/5Etr/TSBlslux9wTut5TMBac03NhQABllGzMu19sB/12cD0XUhPhMvWCd
	 CVEtC/lOALcl7nZlelwuypIXBkZVfXCsZpu8Al1FoWigxdHflmofa7uAl5jAAwQUw0
	 ePcUjVAUv9du/6js9oLCL93UshG3+dX3JmfDu8IG7JB1EAPWVccjgntXpWzTDFdQ3G
	 YEhF9xJ1R8Njg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 445F33AAA0DC;
	Wed, 28 Oct 2026 10:02:04 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sched: prevent scheduling deactivated qdiscs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179318172275.622019.2392717179120363996.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 10:02:02 +0000
References: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
In-Reply-To: <20261023194712.package1-20-v2-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: vinicius.gomes@intel.com, kuba@kernel.org, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kylebot@openai.com,
 dominik.czarnota@trailofbits.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 23 Oct 2026 16:02:56 -0400 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> TAPRIO can schedule a deactivated qdisc after some_qdisc_is_busy() has
> reported it idle.
> 
> Commit 47e8dbb6e763 ("net/sched: do not reset queues in graft operations")
> made graft deactivation skip queue reset, leaving TAPRIO's timer armed.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sched: prevent scheduling deactivated qdiscs
    https://git.kernel.org/netdev/net/c/d6f81fd6abe2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


