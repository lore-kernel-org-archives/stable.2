Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794682212;
	b=1UuXkcb5plrk3tZhhJ7Eghmt0cOlFc3gmnSI0DgTzxqHO6PjzrEdd5pnrejtgTEqtYYa
	 rP3PGZhjQvk+u8xQDUMZ1s9z3H9G23/jNS3r5JYoycytKtciAKJXUg8G43yGKeJPvv6ob
	 ln3QAKj1hAbzrZpQxBVbZg5N1dVdHRoDdlUn1z/bQt+iLiMWQb0It4vVhcnPgT8a0fvvz
	 J0hYTYLABWFBTUcKb2oJWWIlhGIdjDkoZwkdk+xtJny/39csTz3btyy1+9utx7mSPbwp7
	 6wrLsKdS8/aeJBalY/8pIRsXaYx+ImXLrr+lw9jUE400LMN8dAQFcrgo9fW6e3Y997w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794682212;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=fEnV7meHeIXrbVFY6btGf5S6ZSC7MZxfBU/Gv7848Sg=;
	b=qPV17k2RDCzhaqCbrezkXq0JA15HG8+QrKETsB5m9HE/qBLgPru8Y3a4gFNeqH9Uqs7F
	 Y46X2bl/hO44oMV2tEwZ81N3lGHJOmtAe8Dgn93KJEcP1IJp9D782e/la8SdpWpJxRUhS
	 nro4xsOT7UG/wAaU7kW5eJWL9/YOmFHZN+4Ygn+njFjLWvrjk0Q2s45Ot/3SMs5bXNebp
	 8dTQBOTQUNPvTeBL3K2DHCP0bAzEXdz4F1d72YDh6uUel2xcgzjM+qjhHhdshGrRrdoy9
	 IpuFeMAWNN7MCB1SsG+uV5L0RfE80JWPYGD1yp9exihv1wMBs1/RtEd613y+ayh7VvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvFmHS+5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B75606A33D;
	Sat, 14 Nov 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvFmHS+5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE0E91F000C4;
	Sat, 14 Nov 2026 18:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794682211;
	bh=fEnV7meHeIXrbVFY6btGf5S6ZSC7MZxfBU/Gv7848Sg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FvFmHS+5+QWxgtOwZTk/Y0D+SqDIHf0VYPzmVLeWjONAqHuW/t2jQRbuoPckf452l
	 2yis/DCXEOZ9/JqbF+uxZlSCtivMICeIQooAoDxqULDSBs0OxwFYXDesotmA4wAw+S
	 IjGw9IZ2u+lRuiU9RSUm4R3yBcth0yk9hkT9MYkJ/9NZC9tjcx0V/ndN5YMc7yDec6
	 MOg9RZ4G+Z1dsEWgdUTV3zUnQReGYUUKIi2D0B4NWWLALLpkklZp7BAQ/zMqLTEcCd
	 oktWRpJjtMyOPVI1rFDu7AcfWUr0TRrcBOS2A31nbCYNqgDJkEeDuZjyj8dloqZ0g2
	 Gj0pgfLPikesQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4411380821F;
	Sat, 14 Nov 2026 18:50:11 +0000 (UTC)
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
Subject: Re: [PATCH] bpf: fix verifier model mismatch on __sk_buff.remote_port
 narrow read
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179468221032.2337414.16612050775582398663.git-patchwork-notify@kernel.org>
Date: Sat, 14 Nov 2026 18:50:10 +0000
References: <20261105060331.1912252-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261105060331.1912252-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Thu,  5 Nov 2026 14:03:31 +0800 you wrote:
> On little endian, the ctx access conversion for __sk_buff.remote_port
> loads the 16-bit skc_dport and shifts it left by 16, producing a
> 4-byte value of up to 0xffff0000.  It reports its width through
> bpf_target_off() as 2, the member size.
> 
> A 2-byte read is a narrower load of this 4-byte ctx field, but the
> fixup pass only masks the result when the access size is smaller
> than the reported width, so the masking is skipped.  The verifier
> models the register as [0, 0xffff] while the runtime value is
> [0, 0xffff0000].  Arithmetic the verifier folds to a constant can
> therefore take any 16-bit port value at runtime, enabling
> out-of-bounds reads and writes relative to map values.
> 
> [...]

Here is the summary with links:
  - bpf: fix verifier model mismatch on __sk_buff.remote_port narrow read
    https://git.kernel.org/bpf/bpf/c/4722bac72de6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


