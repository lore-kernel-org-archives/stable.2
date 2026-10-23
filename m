Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785295;
	b=x+qO4uy6vV7/DLyDmoQiadG26w08/hf5BKaZvBz4SF0JypOeTsvKGrNrFA1KY1Vh5a+Y
	 KyXb1GOqKND58RByYWv9A4TVyBoTsglJ7tQXEI4n7KNDRMwHS61YxT+YWyWDu2FYH4ti2
	 +YhSoqEU2vgzTSJ7cVS3TBMog7QUpjR4v9PZvyJIJWqQQBZhFrPuGYme9bIdwnBqOrqHx
	 GHRCO60vMFhrHCsqF9vFTO0JMxNPe+VV3y52YvrAjKvxQJ35tzGbXN0S6aUjiGmyiH+Ry
	 I6AFf59O/kY7jhyWTZ8eucz6e7FREwwkhbBI79viuYOQ0dFHiEnRbDEyO51a+RQft3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785295;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=n1dExzRwpieQZCdkT2EASASJklN8W3dtqeu8kJ88H/3VrGXfbz1bCLyLa7DjqXxcSqnp
	 +QHoRNRTDILX7xbPQMv0BwbpNlE5hzBvfvDhHmzK1MVcMIu2Q2WJBx0MBKXPT5zv/R0mv
	 dieaW/Cj7Z80KG7UJJZv9qsGK5W46M+C72U2AidW4NnHC4KROnoSMWOMYyifBRi2nLlkE
	 kzS+w7CTu+qkGZSD7j2FzsRruIGstg53XcqbKMECthK1N638srdCvbOaMEeVfuvOgEY4W
	 LHQO7HcgK03Ry6Zgbq6xPH+fJYGZTS4zs+UMTh+ir/uskVKLtNBI3TTzbfvofN7CvHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jq+dhRiR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20696606A326;
	Fri, 23 Oct 2026 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jq+dhRiR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623A51F01825;
	Fri, 23 Oct 2026 19:54:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785295;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jq+dhRiRE9nRItBkTadAidmOAdfjTyzXLGvBhDcTCbkqKc5ixpM/hkSc7/99xA5e4
	 x8AToQga5V/hRgZnwjoW61GYSw+aMldsDI9c+bKYo9Mge5dGqM0M7nXCJnSnXaBgtp
	 xrSkrEplcn4FY8ypjiQAzTJx53gob4e5CJ+5OA/HP4XiQngmiqFarg1n1oiKhe4x3g
	 gdog0foaapiiV+Nn+ePJTpW7NLbRpTAQHg7pEvX+ah9CTMipIvWXgkjIe8PjF8S6Ko
	 rE/RYL3nTRzBTZSivURUEvHQpvPfvlJ2mlWvR4kezNkw5iJ45MUN3h3Z1bHlwa3nZw
	 0YyYLElN7jtsQ==
From: netdev-bot+sinfo@kernel.org
To: Tristan Madani <tristmd@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH net] seg6: fix tun_src RCU lifetime on namespace teardown
Date: Fri, 23 Oct 2026 19:54:53 +0000
Message-ID: <179278529389.3327.1530536500905686255@kernel.org>
In-Reply-To: <20261023195234.3524462-1-tristmd@gmail.com>
References: <20261023195234.3524462-1-tristmd@gmail.com>
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
