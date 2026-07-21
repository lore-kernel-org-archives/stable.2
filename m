Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3653B5318;
	Tue, 21 Jul 2026 08:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784622637; cv=none; b=cV5Uf86wLRLFTpFuizcDfLivSX09+29D317bAuQK/FXjeki++wwtke43TCqdXzzyhPNPLiuDbT2x4gkrxzG/03DgL+qk4Ff+gXdqmrx5o2ZXLAVzJQCdsq8PtnL0Uk/XYmm0hw384cgmChY5EEXJWwbjOxRmx9ZvFbENeH/1zh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784622637; c=relaxed/simple;
	bh=wDCVzS8HuI620KIoVlMJitjckQwua0jc1FV7lYzjHzQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A/H6q21YYGsaFZrAmTJu2wow0SwfMVcvCzADcjvItgLjTl90uOER9u/zXvpNnhVjVDVQZ3y1R3yzvcw9T9e+OQA96dIHrubtIihEjhbecdex6V0rhcnvXjaBftmCss4WMNjo96HLhNgV41hh/emALrcGbSY5BYkiFkjZ7en6uEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mim9LUWA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mim9LUWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88191F000E9;
	Tue, 21 Jul 2026 08:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784622635;
	bh=RcEGfRkm7PeWY/uBabOw8DMSOHbyW6M0wmUmzuVueh0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mim9LUWABUIHmJgGoPC2rGQcg+6qRR0SMdqvG+B2yalV4gydAYdaSc06GGNkskAaz
	 KoLmbkNogFDyiiHw7b+hCi0cJ554b7pNTs80rPJ+vV4ZBoNV9gKpH4YKlgQZNLrkQT
	 W8MOuYOWXikYSuzEfx6DobXbmIVIgI3mxGCL++iFxMl2qG4M1tWyIh6h0AYPLAAWLC
	 J4jndxHpJlJrQXtEu8EQpIkUfvZxcJK5KjFFVeVRL/Z45rzD81XmQhsKPNrfYw4eGR
	 9R+Oixlejum2HFBB1YGjIQVkDXe59kt/IAAzs1wyA5UCPRw2fuqrjVnECxdcR88yJF
	 KKu7yro3BAwlA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A273924A30;
	Tue, 21 Jul 2026 08:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] openvswitch: fix GSO userspace truncation underflow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178462260542.156776.14796632376137154593.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 08:30:05 +0000
References: <20260707221635.27489-1-kylebot@openai.com>
In-Reply-To: <20260707221635.27489-1-kylebot@openai.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jul 2026 15:16:35 -0700 you wrote:
> OVS_ACTION_ATTR_TRUNC currently stores a delta from the original skb
> length in OVS_CB(skb)->cutlen. When a later userspace action segments a
> GSO skb, queue_gso_packets() reuses that delta for each smaller segment.
> A segment can then reach queue_userspace_packet() with cutlen greater
> than skb->len, underflowing the length passed to skb_zerocopy().
> 
> Store the maximum preserved length instead and bound each consumer
> against the current skb length. Use U32_MAX as the no-truncation
> sentinel so the value remains valid if skb geometry changes before a
> consumer handles it.
> 
> [...]

Here is the summary with links:
  - [net] openvswitch: fix GSO userspace truncation underflow
    https://git.kernel.org/netdev/net/c/4032f8ed10fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


