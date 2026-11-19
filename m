Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795115914;
	b=j2l0p8XqiE0129DPIOMUV7WfZOTW/TmgEgQuhcjMdwaZexzAtkZ3QpPRp9RwiGMewpJH
	 4Va9j8Dk/sOzRRqWBe3nhvQrlKZtwekzlq2m0kT9foSX4gU5D1Dj0kX6Tc808OwW1E5Oi
	 eFCqKO83RN8JA5BauAogFFTvqWOz1fvP1AG/NKnaptaPF6zByTV4JElCQpT9UTBCFHhrz
	 qthjRZC9+FB8l1Cl+aDYYaZwbfdS7k2UzFDaeXF1LpSPBQQqPes47BOXTgDfoiVEtPHjU
	 PlvX9O+uuK3j0KoGGHyrNeFsK7fMjEoDyPvsNoKS/fnCliZPZzC3thBd8Sr88c9luag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795115914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=HHbMcPSoqaTrzic802DFkBFm4TaBBijFqbFOSw6gaqGLhW+PTdmfb5GM9kJUnbUi0ak2
	 ucQwFvA+3+Kc2ZpnaX1joHp4tYzeKUQSQEOz6HAevQUqM6HXDoMQ9ygx6V3vTmh4OQWjw
	 tOHTlTUEAMsXa1uXLqpPNf5SPSoszYShU1pU+5PzSRpaFqYRdNY6YWHelDUegz3i2LWOd
	 RAkgnL0HEJoS2PDcyIn3VC5ztbb+TAu8zuYyOsjtwl3dkar5unQkq6yg5gLzSuoZfphpg
	 KS8wdkeeUSkDrpWw1iPkK5FhrSfcZQrB8skl8IEkZ13/+vjvYsjoPRSrRd13HutBVAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAF4Y29l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B0C606A324;
	Thu, 19 Nov 2026 19:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UAF4Y29l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A581F000C6;
	Thu, 19 Nov 2026 19:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795115914;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UAF4Y29luw/yKHufeprEhfXZvNrw+ugAeCSW3z09Ek3r8HNQOVc2Yw2igqb5CNA/6
	 IBRoMjt9p/1Y+nv/OMYamSBSyyTNNAnkDw3zsApgMnrwNgO/QGXLvAlmpi8LRDSvdK
	 ihl/To4VepPbhtxAIa3awC+HNcVO5Tab6gtaORGnXufjRwiiArFxDfwWfj04knFHtY
	 TN2EOPaGjDN5jGz5LV1WODO3ZZoITuGtxnZ1/dFvrEpV5Zja9+aSJ6OJkdv7eR1tAX
	 1HvbY6U2aMN+nrOh/ZXUGkQSCuhUAtH6usPgW5Ayz6eeuz4K/H+gzFa/lUckyUZYrt
	 5ugrtG6faeB+Q==
From: netdev-bot+sinfo@kernel.org
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Alice Mikityanska <alice.kernel@fastmail.im>
Subject: Re: [PATCH net v2 1/3] tls: device: keep tls_sw_fallback() from
 encrypting its own output
Date: Thu, 19 Nov 2026 19:18:33 +0000
Message-ID: <179511591345.3291.2759215840962575723@kernel.org>
In-Reply-To: <20261119191341.4089157-1-rjethwani@purestorage.com>
References: <20261119191341.4089157-1-rjethwani@purestorage.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
