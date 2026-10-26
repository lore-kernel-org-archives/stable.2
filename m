Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793052915;
	b=Y3jmYX0LFAWonsJYCT1Ts1LpWhL2hGHjFJArnX8Sv3sIyQ3CgUC6AS6e8fmCf5yhYf0y
	 GsY9jCFKiTuo9/0GsIhS0b21PVn6pziLBHyp8LS0z4ZYo4O1wgVPHBuuV9uuRPIla/eJn
	 PKpFSlkye4ZGEXSLtlnXA4U/2uFie+9Dt0AvwiWdexJikiHFlLVkrAfeFYygu9j0o55K1
	 cbbswTE67c3mCTF+jT98czkfibJKaHA0yzUiLmfAhbyRal/y8BMQBPXOSTo579Qmw2iTK
	 vhUeFxDwWBJ+Qj1t9xdUc2DIU7vGucrAu1uWShMsbJ880hGpuReFD4Wubs3/4zFyN2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793052915;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=jS5R8UqD7vAoI6DQkwTWmbWUkFd9jMJsEok3doum9PRDllsWO6sBAlcbUoZTnIru2LJr
	 qEb+OccF9wdVKbIijBYfPyMgwxaXHRl+wHWLWaMpwYjHG3SaD8Iq9Lrm4xVsu3jSL087T
	 LntwmnC9Y1dOTB+aw5clgcb8XR7GLxOkHYxsTWxCL9SX5M0eu6IOsVQpNfpf0tIoKZduY
	 PJ8wFzANZ+CBvEWMei6EuOZ97pECO0KBPDtnADHCPLJNohs8SPK1kEOvC6ei4Ycz2YzbN
	 +Hsxc4fYT3IcL08KfV1LdxN2Bcxu1ak+q+/bridwhFaKUja/JYYdxspjT3NSjWN/aJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsLbeABU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788B606A31A;
	Mon, 26 Oct 2026 22:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gsLbeABU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE1E1F01825;
	Mon, 26 Oct 2026 22:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793052913;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gsLbeABUZ9QLKoMkzJ+pxLlBJ/o472OdPVLtXXxuueO8sCSlYaYJbE2t+Yd3Qw0eS
	 c6NosOXCi7ORu1Zbi9BiJP6LMP2T2ap7zzPId3kfn7NoBubcGAeJy1K8aQRMIgaZ6F
	 FfaJfj0lKPf9YlK7jZDgKuYcHnxlHTtEwzjivK6Y0bmeTfWdoLehFCts0I1Ot54fNe
	 154PzWrgquI+GYhovcAivrzuInIOpRjtFN4lSff/YgaDMIYjxvz8th0IdPXkPa4nOu
	 0Jbd056OzqqnT+TRhwJatK92Jrwz775POPDYJfLIhHZgaQgjTsKlcgJiU5QXfqF5HN
	 ISuBWdUCDDL/g==
From: netdev-bot+sinfo@kernel.org
To: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
Cc: netdev@vger.kernel.org, pavan.chebbi@broadcom.com,
 michael.chan@broadcom.com, kuba@kernel.org, edumazet@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] tg3: Invert restart quirk logic to restrict SNP
 power-down bypass
Date: Mon, 26 Oct 2026 22:15:12 +0000
Message-ID: <179305291274.3327.7897598693564915611@kernel.org>
In-Reply-To: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
References: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
