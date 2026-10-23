Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792781693;
	b=4ctGOb/WtPLkPLSqYO9sxfh+q7yOGUbpudiJ8+SBw8Bua+QC7sjVPtqvcrAgfotT1p7f
	 7kLaE0hzDq880V4MeH5UR+44sv/H0S9JUGTTwi2FTt68rwxFL2xfvrcRZ9loTMCi4ES4U
	 wuMyAGCsssKbv1NzUpEUV2XGc/7vHmI/GdojV5/syjat1EaA6V3aTXl9lbKG0xuSo2b7e
	 rXOll5bTFjwoYJWnMxyqF2CkIP04W0FNzcIIUOJkRR4Op0l1C84Z0qiFtdLInfGrki3Gn
	 2I44aOENLCF3GoGbc4IECYUoOeIsCnkLs4a6MDMwl3Qg8zZ4/Z3L+1/ZdNLGFLkCzGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=5JeCLuqqMDUTG5R1UF22Ayp5Yo1Dsg+yKJhacFl6/Cis3RfymOnJKpza8yAVhC1wiSaJ
	 KnQX8JKd2vCOL7iGUrc8s0EZGYqRlJ5G2xXIIpvHQxVjsKWTy3jU3mSEVd+fnDwY2TnyO
	 mEaUTLdr8S2Ws+dPSCTMD477fPH8iBSkI5EDSzMa7aqcD+6jnGG1bvyLUjc7hZE5BlmXX
	 c5oy9mkIrGToqjo192PLMtu3oOBXm0DSlMGTZsLAz21BJJn5hJL86lSNTTbq3C52Ro3aI
	 sfL9OD2/t4iVFD1ccgN2sIriaMiux6rmDQazypakhms754lDViJydu7+3xXrlls4NSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="h/kuyFSY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46032606A31A;
	Fri, 23 Oct 2026 18:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h/kuyFSY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9031F01825;
	Fri, 23 Oct 2026 18:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792781692;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h/kuyFSYxROdjj8btkzQ8jS9IqFVU2SoKrWR6SfdS+hAtSfj0DdFdt/sIEsCuJHH3
	 bjiO32/jDDDq/tDHMHhRTA8iAyeeWjAOjC9zd4y7mj9WHuMrk8AQysW2mbwbpTHJYR
	 LI1jP6vcMm4yMF8JhmHffnkGI4Y21cIjtb0N31Gy20ySWPYYH+MajKOfi4sqrtVKgK
	 vjfT7ffPk9bV0iZQSFnoX9yNl9vGgXliT8rNOHaSr+nwpBxxEZ3xP3tsu/G4Iwtij7
	 qpz4eeipcAqqT5+L22EPDqvOD7ORAIYHjc0t4gbK0+cXZSrebEJTMm49z9f6GCtW2H
	 XsXUMel7bf9tQ==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] inet: frags: prevent acceptance of partially
 authenticated reassembly
Date: Fri, 23 Oct 2026 18:54:51 +0000
Message-ID: <179278169172.3327.18212871676528933059@kernel.org>
In-Reply-To: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
