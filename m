Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411465;
	b=0ee/+2I+z7Uej74CXNUqK0bNBRxiR3NWrEpBcBeN86qLI8PSAMItV8d1p37C3fY0Kl7Q
	 84hRZAVhRONyk1m/WopkOi+AJvKDsH7E+0GB4wcSmv1teL31waNRrsPCQZA0PDhroqTOl
	 ciSpfu/cA2kP5GXOY+635NvcVF3lRIRsglOOpUm+AtTnwY/93m8sPARi6bXoXh9eh8QMO
	 49koe2jwG8AZb1erlRrLYWe7WtgYFVCKOyo7nuIx8BYDq8Fk8ySAb7xY8PiQbIA9QSV9s
	 nFjS5+JWBLGre8siVj2lyCmoM1aZJ6mAmYF3u0GZwleIsC/wQja/582wy9F3Lyfvkbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411465;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	b=kGg5GwkATBoi5zSPGRpVfutqMAcwl9SjINuERm8xIjnjyA7sVnSGfvoyUZ+o9HhuANzA
	 ExEM7FdS/Nj9f4U6EHPGbI6eKWwrQTdRtr6qVtz6l05zm05rctCDuihi7Mi+OR6ZmG70O
	 zYwz0ZnCvvUWDQyErwRnNtVY3+N51PVvK+TxW7buQqqtec4pUM4PqnTAJUnwNBj0Wm1Zp
	 vGSOHINXoIpesEEsGlLqIv7sh1dQr50xEfBJJ7Zb6uDm7jq955YywDdmdKthrZLoLrzml
	 bHiwNNi4dOC5SlIsxu5F3xz8gcK5GZO41xtCJP/vxpBcd21UUk7I4toZBDaMgh1B+xQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW4KK3W9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40549606A339;
	Wed, 11 Nov 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SW4KK3W9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6871F00A06;
	Wed, 11 Nov 2026 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411464;
	bh=oVTc5I6nKpBiLsItkBZmeShBR8ASpkDeEBpnWBZ++aw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SW4KK3W9O6e+ReIFSLAGBYlbXrw5R51EnC+AQwBArU7s4WtOgWrWUnVyi1S+zR9NN
	 XFv0p2FpPVTBo2UopI01mc42Z5CTHQjZ1DP+3RsOv1Dh2uF8GHwgOK/JMKzAPijWIT
	 tO5Us36UZqx1o+lgOK14GbpBQPmfmvlVEoruaklEp75PrTWHLAxxHL2ncKngzatl7p
	 XHDC40wrER6E6Z0O2Il5GkNcfxG7eYKyRn+iAuY4fSQBy3gySU6xk/lxqou2WAZZ2E
	 rqYDQefb8nuLZ1GjB6h7s8dwRYc58rlsMlhdzq0jf8ewGhoBDsnAuIoGMof4gZTwRi
	 ztQ2gNI6pF2ig==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] net/sched: cls_flow: pin file with get_file_rcu
 before reading f_cred
Date: Wed, 11 Nov 2026 15:37:43 +0000
Message-ID: <179441146372.2168702.5462633106767625518@kernel.org>
In-Reply-To: <20261111153106.580776-1-tristmd@gmail.com>
References: <20261111153106.580776-1-tristmd@gmail.com>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
