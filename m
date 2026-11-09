Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794237660;
	b=LitvM5sO7iCqWf7o+OKhB7QAT8b7OH5qU6PGbd7S3ZZ3+AhwSosDvB0BQhAWPs46p3w2
	 LzUDDCWKdNBPmXp6utYVyXK3xNf6cB26vFZq/+LNOrLOuSBRvKboeRStKI48OPLXRnu0/
	 zKJ3lKA7/m9E2lE1Qs4kE9QRcp/s0ErNcOHBAEwnm1TJwZADiBZ9YGpcMzrB3T/csPH9k
	 fLdKOxVbZ/9uBVT8WTGuSS6T5vu60CpA7aE1BFVR1+KjbkHhCnK/c0IJNo1TVYvZhrcof
	 9azNnKvb7MV2GjikKFXb8Oh4oVNVpaHVgNoDP8EbYks7n/GZ8NZQSA+F8cRLvbPzF8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237660;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ZEDcgpZXv7tELS5BnebtNXmUzNMs+qj+jNMbQJ/Z9P0=;
	b=li0FaudPbXXmOFVdBRwxcce8Hw7+rKeKhf+fU58iw/SQ6m0tqCC0Xk3PR7YObLSBMwvb
	 IjEuWY6rGDeP9nF2ZDVi8sbRe+C9bOCwtbMtJDoYKqYZ2v8c6zdmNZOVAqQlfF2/kqkyV
	 eL4OSGbihjN/Dy1uRljhsCW4fRaywEbmzaYNW++l37SYI9RTB/elo2kl94sLtNyLNQsBo
	 sjQkrSskGkAADREsfNTsuOXICaXHb9rrHUp/mZ78B7DFwy9LoEakOXYj2NhdCCJiEqGUG
	 rYBPLdBkXCQ1Oca8Qch00d93pA40aDUS2wPKV6cKRGP4PjhLfjcCdgI61txstcSOPVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBBah3C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28880606A335;
	Mon,  9 Nov 2026 15:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jZBBah3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30061F008A1;
	Mon,  9 Nov 2026 15:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794237659;
	bh=ZEDcgpZXv7tELS5BnebtNXmUzNMs+qj+jNMbQJ/Z9P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jZBBah3CEkuczstxqzX0W1hJaSHbQ6sNIED+xrfJzrJGbzEChuY2EKDdrLMgSbkx2
	 ylxbq0P2ml//UkOYXNdWLTf7OEKwJLrIIOBBsQzmEMKCK3SqADe5F4WZETLTb7zA8A
	 a47U9w+I1CUP434aQL5ZGT8Vpnc6yJmOdRqhXhE1Iq/NRtkx+EEHAd0RocqzRIYMTl
	 KbOIaHSefN+6vUoujGxCFTKjtpG13FR2TIMuVE/85q7B5ZW6Yfpg1Cxw75XRB4/YbZ
	 aSDJUlCg4uxrqcUu7EvPpseuAO5gOZeN0bVMBsX2ZeIaUMG0LsSovmxxkn3TATm6sj
	 lFUrBAIRsOSNw==
Subject: Re: [PATCH net 2/2] wireguard: noise: recheck replay and flood under
 write lock on initiation
From: netdev-bot+sashiko@kernel.org
To: alex@badcode.im
Cc: Jason@zx2c4.com, wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Mon, 09 Nov 2026 15:20:58 +0000
Message-ID: <179423765848.994134.12106914820524986319@kernel.org>
In-Reply-To: <20261105141006.95083-3-alex@badcode.im>
References: <20261105141006.95083-3-alex@badcode.im>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message names the response-side fix as `commit
  2a73c9b2c0ca ("wireguard: noise: reject response consumption after…

--

wireguard: noise: recheck replay and flood under write lock on initiation

This commit makes wg_noise_handshake_consume_initiation() run the replay
and flood checks a second time after taking handshake->lock for writing.
Without the second check, two copies of the same initiation processed in
parallel could both get past the read-locked check. The read-locked check
stays as a fast path for rejecting replays.

> This is the initiation-side counterpart of the response-side race fixed
> by:
> commit 2a73c9b2c0ca ("wireguard: noise: reject response consumption after intermediate initiation")

[Severity: Low]
Is this the right hash for the referenced commit? 2a73c9b2c0ca doesn't
resolve here. git log reports it as an unknown revision.

The commit with this subject appears to be:

commit d0305f8d9002 ("wireguard: noise: reject response consumption after intermediate initiation")

Running git blame on the response-side recheck under down_write() in
wg_noise_handshake_consume_response() also points to d0305f8d9002:

    if (handshake->state != state ||
        crypto_memneq(handshake->ephemeral_private, ephemeral_private, NOISE_PUBLIC_KEY_LEN)) {

Could the reference be changed to d0305f8d9002? This patch is tagged for
stable, so readers who follow the cited hash to the related fix would
find the right commit.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105141006.95083-1-alex%40badcode.im
